################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################

require 'ffi'

require_relative 'ffi/version'


module CZMQ
  module FFI
    extend ::FFI::Library
    
    def self.available?
      @available
    end
    
    begin
      lib_name = 'libczmq'
      lib_paths = ['/usr/local/lib', '/opt/local/lib', '/usr/lib64']
        .map { |path| "#{path}/#{lib_name}.#{::FFI::Platform::LIBSUFFIX}" }
      ffi_lib lib_paths + [lib_name]
      @available = true
    rescue LoadError
      warn ""
      warn "WARNING: ::CZMQ::FFI is not available without libczmq."
      warn ""
      @available = false
    end
    
    if available?
      opts = {
        blocking: true  # only necessary on MRI to deal with the GIL.
      }
      
      attach_function :zframe_new, [:pointer, :size_t], :pointer, **opts
      attach_function :zframe_destroy, [:pointer], :void, **opts
      attach_function :zframe_new_empty, [], :pointer, **opts
      attach_function :zframe_recv, [:pointer], :pointer, **opts
      attach_function :zframe_send, [:pointer, :pointer, :int], :int, **opts
      attach_function :zframe_size, [:pointer], :size_t, **opts
      attach_function :zframe_data, [:pointer], :pointer, **opts
      attach_function :zframe_dup, [:pointer], :pointer, **opts
      attach_function :zframe_strhex, [:pointer], :pointer, **opts
      attach_function :zframe_strdup, [:pointer], :pointer, **opts
      attach_function :zframe_streq, [:pointer, :string], :bool, **opts
      attach_function :zframe_more, [:pointer], :int, **opts
      attach_function :zframe_set_more, [:pointer, :int], :void, **opts
      attach_function :zframe_eq, [:pointer, :pointer], :bool, **opts
      attach_function :zframe_reset, [:pointer, :pointer, :size_t], :void, **opts
      attach_function :zframe_print, [:pointer, :string], :void, **opts
      attach_function :zframe_is, [:pointer], :bool, **opts
      attach_function :zframe_test, [:bool], :void, **opts
      
      require_relative 'ffi/zframe'
      
      attach_function :zmsg_new, [], :pointer, **opts
      attach_function :zmsg_destroy, [:pointer], :void, **opts
      attach_function :zmsg_recv, [:pointer], :pointer, **opts
      attach_function :zmsg_send, [:pointer, :pointer], :int, **opts
      attach_function :zmsg_size, [:pointer], :size_t, **opts
      attach_function :zmsg_content_size, [:pointer], :size_t, **opts
      attach_function :zmsg_prepend, [:pointer, :pointer], :int, **opts
      attach_function :zmsg_append, [:pointer, :pointer], :int, **opts
      attach_function :zmsg_pop, [:pointer], :pointer, **opts
      attach_function :zmsg_pushmem, [:pointer, :pointer, :size_t], :int, **opts
      attach_function :zmsg_addmem, [:pointer, :pointer, :size_t], :int, **opts
      attach_function :zmsg_pushstr, [:pointer, :string], :int, **opts
      attach_function :zmsg_addstr, [:pointer, :string], :int, **opts
      attach_function :zmsg_pushstrf, [:pointer, :string, :varargs], :int, **opts
      attach_function :zmsg_addstrf, [:pointer, :string, :varargs], :int, **opts
      attach_function :zmsg_popstr, [:pointer], :pointer, **opts
      attach_function :zmsg_addmsg, [:pointer, :pointer], :int, **opts
      attach_function :zmsg_popmsg, [:pointer], :pointer, **opts
      attach_function :zmsg_remove, [:pointer, :pointer], :void, **opts
      attach_function :zmsg_first, [:pointer], :pointer, **opts
      attach_function :zmsg_next, [:pointer], :pointer, **opts
      attach_function :zmsg_last, [:pointer], :pointer, **opts
      attach_function :zmsg_save, [:pointer, :pointer], :int, **opts
      attach_function :zmsg_load, [:pointer, :pointer], :pointer, **opts
      attach_function :zmsg_encode, [:pointer, :pointer], :size_t, **opts
      attach_function :zmsg_decode, [:pointer, :size_t], :pointer, **opts
      attach_function :zmsg_dup, [:pointer], :pointer, **opts
      attach_function :zmsg_print, [:pointer], :void, **opts
      attach_function :zmsg_eq, [:pointer, :pointer], :bool, **opts
      attach_function :zmsg_new_signal, [:pointer], :pointer, **opts
      attach_function :zmsg_signal, [:pointer], :int, **opts
      attach_function :zmsg_is, [:pointer], :bool, **opts
      attach_function :zmsg_test, [:bool], :void, **opts
      
      require_relative 'ffi/zmsg'
      
      attach_function :zhash_new, [], :pointer, **opts
      attach_function :zhash_destroy, [:pointer], :void, **opts
      attach_function :zhash_insert, [:pointer, :string, :pointer], :int, **opts
      attach_function :zhash_update, [:pointer, :string, :pointer], :void, **opts
      attach_function :zhash_delete, [:pointer, :string], :void, **opts
      attach_function :zhash_lookup, [:pointer, :string], :pointer, **opts
      attach_function :zhash_rename, [:pointer, :string, :string], :int, **opts
      attach_function :zhash_freefn, [:pointer, :string, :pointer], :pointer, **opts
      attach_function :zhash_size, [:pointer], :size_t, **opts
      attach_function :zhash_dup, [:pointer], :pointer, **opts
      attach_function :zhash_keys, [:pointer], :pointer, **opts
      attach_function :zhash_first, [:pointer], :pointer, **opts
      attach_function :zhash_next, [:pointer], :pointer, **opts
      attach_function :zhash_cursor, [:pointer], :string, **opts
      attach_function :zhash_comment, [:pointer, :string, :varargs], :void, **opts
      attach_function :zhash_pack, [:pointer], :pointer, **opts
      attach_function :zhash_unpack, [:pointer], :pointer, **opts
      attach_function :zhash_save, [:pointer, :string], :int, **opts
      attach_function :zhash_load, [:pointer, :string], :int, **opts
      attach_function :zhash_refresh, [:pointer], :int, **opts
      attach_function :zhash_autofree, [:pointer], :void, **opts
      attach_function :zhash_foreach, [:pointer, :pointer, :pointer], :int, **opts
      attach_function :zhash_test, [:int], :void, **opts
      
      require_relative 'ffi/zhash'
      
      attach_function :zlist_new, [], :pointer, **opts
      attach_function :zlist_destroy, [:pointer], :void, **opts
      attach_function :zlist_first, [:pointer], :pointer, **opts
      attach_function :zlist_next, [:pointer], :pointer, **opts
      attach_function :zlist_last, [:pointer], :pointer, **opts
      attach_function :zlist_head, [:pointer], :pointer, **opts
      attach_function :zlist_tail, [:pointer], :pointer, **opts
      attach_function :zlist_item, [:pointer], :pointer, **opts
      attach_function :zlist_append, [:pointer, :pointer], :int, **opts
      attach_function :zlist_push, [:pointer, :pointer], :int, **opts
      attach_function :zlist_pop, [:pointer], :pointer, **opts
      attach_function :zlist_remove, [:pointer, :pointer], :void, **opts
      attach_function :zlist_dup, [:pointer], :pointer, **opts
      attach_function :zlist_purge, [:pointer], :void, **opts
      attach_function :zlist_size, [:pointer], :size_t, **opts
      attach_function :zlist_sort, [:pointer, :pointer], :void, **opts
      attach_function :zlist_autofree, [:pointer], :void, **opts
      attach_function :zlist_freefn, [:pointer, :pointer, :pointer, :bool], :pointer, **opts
      attach_function :zlist_test, [:int], :void, **opts
      
      require_relative 'ffi/zlist'
    end
  end
end

################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################
