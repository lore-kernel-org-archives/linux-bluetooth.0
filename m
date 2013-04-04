Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Apr 2013 15:31:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] audio: Fix notifying a profile without 'connect()'
 for connections
Message-ID: <20130404123101.GB9444@x220.ger.corp.intel.com>
References: <1363214761-22996-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363214761-22996-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, Mar 13, 2013, Vinicius Costa Gomes wrote:
> 'audio-avrcp-control' has no need to be informed of connections or
> disconnections, implied by the lack of .connect() and .disconnect()
> callbacks. So no need to keep track of its connection status.
> 
> This also fixes this crash:
> 
> bluetoothd[22811]: profiles/audio/avrcp.c:session_ct_destroy() 0x6325370
> bluetoothd[22811]: profiles/audio/avctp.c:avctp_set_state() AVCTP Disconnected
> ==22811== Invalid read of size 8
> ==22811==    at 0x466F10: dev_disconn_profile (device.c:976)
> ==22811==    by 0x4E9307C: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==22811==    by 0x46B30B: device_request_disconnect (device.c:1005)
> ==22811==    by 0x46B477: disconnect (device.c:1048)
> ==22811==    by 0x40D050: process_message.isra.4 (object.c:258)
> ==22811==    by 0x517C9E5: _dbus_object_tree_dispatch_and_unlock (in /usr/lib64/libdbus-1.so.3.7.2)
> ==22811==    by 0x5167349: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.7.2)
> ==22811==    by 0x40ABD7: message_dispatch (mainloop.c:76)
> ==22811==    by 0x4E77BCA: g_timeout_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==22811==    by 0x4E77044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==22811==    by 0x4E77377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==22811==    by 0x4E77771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==22811==  Address 0x6256af0 is 0 bytes after a block of size 240 alloc'd
> ==22811==    at 0x4C27816: memalign (vg_replace_malloc.c:727)
> ==22811==    by 0x4C27907: posix_memalign (vg_replace_malloc.c:876)
> ==22811==    by 0x4E49F80: slab_allocator_alloc_chunk (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==22811==    by 0x4E92094: g_slice_alloc (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==22811==    by 0x4E9299D: g_slist_prepend (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==22811==    by 0x4E75790: g_source_add_poll (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==22811==    by 0x4EB4612: g_io_unix_create_watch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==22811==    by 0x4E6A443: g_io_add_watch_full (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==22811==    by 0x44CD15: bt_io_listen (btio.c:283)
> ==22811==    by 0x42EBDD: server_register (server.c:764)
> ==22811==    by 0x45DD9E: probe_profile (adapter.c:2650)
> ==22811==    by 0x466BCB: btd_profile_foreach (profile.c:599)
> ==22811==
> 
> This is caused because 'audio_control_disconnected()' which removes two elements
> from the device->connected_profiles list, is called from inside a GFunc of a
> g_slist_foreach() (src/device.c:1005) leaving the list corrupted.
> ---
> 
> The correct solution may be to make the "list" more robust against this kind of
> change in the first place.
> 
> 
>  profiles/audio/manager.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
> index 64665d7..f7b8559 100644
> --- a/profiles/audio/manager.c
> +++ b/profiles/audio/manager.c
> @@ -422,13 +422,11 @@ void audio_source_disconnected(struct btd_device *dev, int err)
>  void audio_control_connected(struct btd_device *dev, int err)
>  {
>  	device_profile_connected(dev, &avrcp_target_profile, err);
> -	device_profile_connected(dev, &avrcp_remote_profile, err);
>  }
>  
>  void audio_control_disconnected(struct btd_device *dev, int err)
>  {
>  	device_profile_disconnected(dev, &avrcp_target_profile, err);
> -	device_profile_disconnected(dev, &avrcp_remote_profile, err);
>  }
>  
>  int audio_manager_init(GKeyFile *conf)

Is this patch still needed? We're planning to push 5.4 out soonish, so
if there's a known crash it should be fixed.

The patch you sent doesn't quite look good (which is why it's not yet
applied) since it seems unintuitive to me that a "global" AVRCP
connection state notification should only affect one specific role even
though both are represented as individual btd_profile objects.
Especially if/when we start exposing these states through D-Bus you
really do need to have the correct state for both.

So preliminarily it seems to me like this is something needing fixing in
the bluetoothd core, i.e. src/device.c. Could you send a patch for that?

Johan
