Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGd9gwgFnuqiYMkYgb=2Ssh8ScoR45H=PZWG-BOXb8kwjnMMNg@mail.gmail.com>
References: <CAGd9gwgFnuqiYMkYgb=2Ssh8ScoR45H=PZWG-BOXb8kwjnMMNg@mail.gmail.com>
From: Alex Deymo <deymo@chromium.org>
Date: Tue, 21 May 2013 17:59:52 -0700
Message-ID: <CAGd9gwgfGHo0EtXWE2eM=sYVCx58JG9Kc8LGO9NgPVbBL2hstA@mail.gmail.com>
Subject: Re: audio: Connect doesn't return when audio device is off.
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello ML,

On Wed, May 15, 2013 at 9:38 PM, Alex Deymo <deymo@chromium.org> wrote:
> Hello,
> I was debugging this issue when I found that may be related with this
> new concept of "service", anyway this issue is present in bluez 5.4
> and 5.5 (did not try with previous versions).
>
> The problem is easy to reproduce. Again I'm using the Bose SoundLink
> model 404600 but it should work with any audio device. The steps are
> as follow:
> 1. power on the adapter, scan and pair to the device.
> 2. trust the device.
> 3. turn off the device (short-press once the power button)
> 4. attempt to connect to the device from the bluetoothctl.
> The D-Bus Connect call doesn't return. I think that in general the
> Connect call doesn't return on failure, it only returns when it
> succeeds.
> I can also run into this same issue attempting to connect from the
> device (short-press the bluetooth button on this device) and running
> the "connect" command from bluetoothctl immediately after. In this
> case the device successfully connects to the host, but the attempt to
> connect from the host fails and Connect doesn't return. The funny
> thing is that the device works and you can play music to it.

While on that state of "connecting" (the Connect() call did not
return) and the device connected a remove command will produce an
extra unref (reaching a reference count of -1). I understand that
there ir some timing involved here because the extra unref is not
issued always, but it happens. Below is the debug output right after
the remove command is sent from bluetoothctl. I hope it helps to debug
this problem since I consistently run into the Connect() not returning
an error.
Thanks,
Alex.

bluetoothd[4935]: src/device.c:device_set_temporary() temporary 1
bluetoothd[4935]: src/adapter.c:adapter_connect_list_remove() device
/org/bluez/hci0/dev_00_0C_8A_XX_XX_XX is not on the list, ignoring
bluetoothd[4935]: src/device.c:device_remove() Removing device
/org/bluez/hci0/dev_00_0C_8A_XX_XX_XX
bluetoothd[4935]: src/service.c:change_state() 0x60de3c0: device
00:0C:8A:XX:XX:XX profile audio-sink state changed: connecting ->
disconnecting (0)
bluetoothd[4935]: src/device.c:device_profile_connected() audio-sink Success (0)
bluetoothd[4935]: src/service.c:change_state() 0x60ee4e0: device
00:0C:8A:XX:XX:XX profile audio-avrcp-target state changed:
disconnected -> connecting (0)
bluetoothd[4935]: profiles/audio/manager.c:avrcp_target_connect() path
/org/bluez/hci0/dev_00_0C_8A_XX_XX_XX
bluetoothd[4935]: profiles/audio/avctp.c:avctp_set_state() AVCTP Connecting
bluetoothd[4935]: profiles/audio/manager.c:a2dp_sink_disconnect() path
/org/bluez/hci0/dev_00_0C_8A_XX_XX_XX
bluetoothd[4935]: src/service.c:243:btd_service_disconnect()
audio-sink profile disconnect failed for 00:0C:8A:XX:XX:XX: Transport
endpoint is not connected
bluetoothd[4935]: src/service.c:change_state() 0x60de3c0: device
00:0C:8A:XX:XX:XX profile audio-sink state changed: disconnecting ->
connected (-107)
bluetoothd[4935]: src/service.c:change_state() 0x60ee4e0: device
00:0C:8A:XX:XX:XX profile audio-avrcp-target state changed: connecting
-> disconnecting (0)
bluetoothd[4935]: src/device.c:device_profile_connected()
audio-avrcp-target Success (0)
bluetoothd[4935]: src/device.c:device_profile_connected() returning
response to :1.156
bluetoothd[4935]: profiles/audio/manager.c:avrcp_target_disconnect()
path /org/bluez/hci0/dev_00_0C_8A_XX_XX_XX
bluetoothd[4935]: profiles/audio/avrcp.c:session_tg_destroy() 0x616f940
bluetoothd[4935]: profiles/audio/avctp.c:avctp_set_state() AVCTP Disconnected
bluetoothd[4935]: src/device.c:device_set_bonded() bonded 0
bluetoothd[4935]: src/service.c:change_state() 0x60de3c0: device
00:0C:8A:XX:XX:XX profile audio-sink state changed: connected ->
unavailable (0)
bluetoothd[4935]: profiles/audio/device.c:audio_device_unregister()
/org/bluez/hci0/dev_00_0C_8A_XX_XX_XX
bluetoothd[4935]: profiles/audio/sink.c:sink_unregister()
/org/bluez/hci0/dev_00_0C_8A_XX_XX_XX
bluetoothd[4935]: profiles/audio/avdtp.c:avdtp_unref() 0x61547f0: ref=0
bluetoothd[4935]: src/service.c:btd_service_unref() 0x60de3c0: ref=1
bluetoothd[4935]: profiles/audio/control.c:path_unregister()
Unregistered interface org.bluez.MediaControl1 on path
/org/bluez/hci0/dev_00_0C_8A_XX_XX_XX
bluetoothd[4935]: src/service.c:btd_service_unref() 0x60ee4e0: ref=1
bluetoothd[4935]: src/service.c:btd_service_unref() 0x60e75e0: ref=1
bluetoothd[4935]: src/service.c:btd_service_unref() 0x60de3c0: ref=0
bluetoothd[4935]: src/service.c:change_state() 0x60e75e0: device
00:0C:8A:XX:XX:XX profile audio-avrcp-control state changed:
disconnected -> unavailable (0)
bluetoothd[4935]: src/service.c:btd_service_unref() 0x60e75e0: ref=0
bluetoothd[4935]: src/service.c:change_state() 0x60ee4e0: device
00:0C:8A:XX:XX:XX profile audio-avrcp-target state changed:
disconnecting -> unavailable (0)
bluetoothd[4935]: src/service.c:btd_service_unref() 0x60ee4e0: ref=0
bluetoothd[4935]: profiles/audio/avdtp.c:connection_lost()
Disconnected from 00:0C:8A:XX:XX:XX
==4935== Invalid read of size 8
==4935==    at 0x41F6D2: discovery_complete (sink.c:264)
==4935==    by 0x42559D: finalize_discovery (avdtp.c:1068)
==4935==    by 0x425A79: connection_lost (avdtp.c:1206)
==4935==    by 0x425944: disconnect_timeout (avdtp.c:1172)
==4935==    by 0x4E7A8DA: g_timeout_dispatch (gmain.c:3882)
==4935==    by 0x4E79D12: g_main_context_dispatch (gmain.c:2539)
==4935==    by 0x4E7A05F: g_main_context_iterate.isra.23 (gmain.c:3146)
==4935==    by 0x4E7A459: g_main_loop_run (gmain.c:3340)
==4935==    by 0x44B094: main (main.c:583)
==4935==  Address 0x60e2dc0 is 16 bytes inside a block of size 64 free'd
==4935==    at 0x4C2A82E: free (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==4935==    by 0x41FAC0: sink_free (sink.c:368)
==4935==    by 0x41FB1E: sink_unregister (sink.c:375)
==4935==    by 0x41E43B: audio_device_unregister (device.c:252)
==4935==    by 0x412F33: audio_remove (manager.c:103)
==4935==    by 0x46E6FA: service_shutdown (service.c:174)
==4935==    by 0x4705E8: remove_service (device.c:969)
==4935==    by 0x4E940B6: g_slist_foreach (gslist.c:840)
==4935==    by 0x4E940DA: g_slist_free_full (gslist.c:177)
==4935==    by 0x473A79: device_remove (device.c:2394)
==4935==    by 0x45D800: adapter_remove_device (adapter.c:1056)
==4935==    by 0x45F628: remove_device (adapter.c:2141)
==4935==
bluetoothd[4935]: profiles/audio/avdtp.c:avdtp_unref() 0x61547f0: ref=-1
==4935== Invalid write of size 8
==4935==    at 0x41F6E2: discovery_complete (sink.c:265)
==4935==    by 0x42559D: finalize_discovery (avdtp.c:1068)
==4935==    by 0x425A79: connection_lost (avdtp.c:1206)
==4935==    by 0x425944: disconnect_timeout (avdtp.c:1172)
==4935==    by 0x4E7A8DA: g_timeout_dispatch (gmain.c:3882)
==4935==    by 0x4E79D12: g_main_context_dispatch (gmain.c:2539)
==4935==    by 0x4E7A05F: g_main_context_iterate.isra.23 (gmain.c:3146)
==4935==    by 0x4E7A459: g_main_loop_run (gmain.c:3340)
==4935==    by 0x44B094: main (main.c:583)
==4935==  Address 0x60e2dc0 is 16 bytes inside a block of size 64 free'd
==4935==    at 0x4C2A82E: free (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==4935==    by 0x41FAC0: sink_free (sink.c:368)
==4935==    by 0x41FB1E: sink_unregister (sink.c:375)
==4935==    by 0x41E43B: audio_device_unregister (device.c:252)
==4935==    by 0x412F33: audio_remove (manager.c:103)
==4935==    by 0x46E6FA: service_shutdown (service.c:174)
==4935==    by 0x4705E8: remove_service (device.c:969)
==4935==    by 0x4E940B6: g_slist_foreach (gslist.c:840)
==4935==    by 0x4E940DA: g_slist_free_full (gslist.c:177)
==4935==    by 0x473A79: device_remove (device.c:2394)
==4935==    by 0x45D800: adapter_remove_device (adapter.c:1056)
==4935==    by 0x45F628: remove_device (adapter.c:2141)
==4935==
bluetoothd[4935]: profiles/audio/sink.c:discovery_complete()
connect:connect XCASE detected
==4935== Invalid write of size 4
==4935==    at 0x41F753: discovery_complete (sink.c:269)
==4935==    by 0x42559D: finalize_discovery (avdtp.c:1068)
==4935==    by 0x425A79: connection_lost (avdtp.c:1206)
==4935==    by 0x425944: disconnect_timeout (avdtp.c:1172)
==4935==    by 0x4E7A8DA: g_timeout_dispatch (gmain.c:3882)
==4935==    by 0x4E79D12: g_main_context_dispatch (gmain.c:2539)
==4935==    by 0x4E7A05F: g_main_context_iterate.isra.23 (gmain.c:3146)
==4935==    by 0x4E7A459: g_main_loop_run (gmain.c:3340)
==4935==    by 0x44B094: main (main.c:583)
==4935==  Address 0x60e2dd4 is 36 bytes inside a block of size 64 free'd
==4935==    at 0x4C2A82E: free (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==4935==    by 0x41FAC0: sink_free (sink.c:368)
==4935==    by 0x41FB1E: sink_unregister (sink.c:375)
==4935==    by 0x41E43B: audio_device_unregister (device.c:252)
==4935==    by 0x412F33: audio_remove (manager.c:103)
==4935==    by 0x46E6FA: service_shutdown (service.c:174)
==4935==    by 0x4705E8: remove_service (device.c:969)
==4935==    by 0x4E940B6: g_slist_foreach (gslist.c:840)
==4935==    by 0x4E940DA: g_slist_free_full (gslist.c:177)
==4935==    by 0x473A79: device_remove (device.c:2394)
==4935==    by 0x45D800: adapter_remove_device (adapter.c:1056)
==4935==    by 0x45F628: remove_device (adapter.c:2141)
==4935==
bluetoothd[4935]: profiles/audio/avdtp.c:724:avdtp_set_state()
avdtp_set_state(): No matching audio device
bluetoothd[4935]: src/agent.c:agent_disconnect() Agent :1.156 disconnected
bluetoothd[4935]: src/agent.c:agent_destroy() agent :1.156
bluetoothd[4935]: src/agent.c:agent_unref() 0x610d4d0: ref=0
==4935== Invalid write of size 4
==4935==    at 0x41F40F: stream_setup_retry (sink.c:187)
==4935==    by 0x4E7A8DA: g_timeout_dispatch (gmain.c:3882)
==4935==    by 0x4E79D12: g_main_context_dispatch (gmain.c:2539)
==4935==    by 0x4E7A05F: g_main_context_iterate.isra.23 (gmain.c:3146)
==4935==    by 0x4E7A459: g_main_loop_run (gmain.c:3340)
==4935==    by 0x44B094: main (main.c:583)
==4935==  Address 0x60e2dd4 is 36 bytes inside a block of size 64 free'd
==4935==    at 0x4C2A82E: free (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==4935==    by 0x41FAC0: sink_free (sink.c:368)
==4935==    by 0x41FB1E: sink_unregister (sink.c:375)
==4935==    by 0x41E43B: audio_device_unregister (device.c:252)
==4935==    by 0x412F33: audio_remove (manager.c:103)
==4935==    by 0x46E6FA: service_shutdown (service.c:174)
==4935==    by 0x4705E8: remove_service (device.c:969)
==4935==    by 0x4E940B6: g_slist_foreach (gslist.c:840)
==4935==    by 0x4E940DA: g_slist_free_full (gslist.c:177)
==4935==    by 0x473A79: device_remove (device.c:2394)
==4935==    by 0x45D800: adapter_remove_device (adapter.c:1056)
==4935==    by 0x45F628: remove_device (adapter.c:2141)
==4935==
==4935== Invalid read of size 4
==4935==    at 0x41F41A: stream_setup_retry (sink.c:189)
==4935==    by 0x4E7A8DA: g_timeout_dispatch (gmain.c:3882)
==4935==    by 0x4E79D12: g_main_context_dispatch (gmain.c:2539)
==4935==    by 0x4E7A05F: g_main_context_iterate.isra.23 (gmain.c:3146)
==4935==    by 0x4E7A459: g_main_loop_run (gmain.c:3340)
==4935==    by 0x44B094: main (main.c:583)
==4935==  Address 0x60e2ddc is 44 bytes inside a block of size 64 free'd
==4935==    at 0x4C2A82E: free (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==4935==    by 0x41FAC0: sink_free (sink.c:368)
==4935==    by 0x41FB1E: sink_unregister (sink.c:375)
==4935==    by 0x41E43B: audio_device_unregister (device.c:252)
==4935==    by 0x412F33: audio_remove (manager.c:103)
==4935==    by 0x46E6FA: service_shutdown (service.c:174)
==4935==    by 0x4705E8: remove_service (device.c:969)
==4935==    by 0x4E940B6: g_slist_foreach (gslist.c:840)
==4935==    by 0x4E940DA: g_slist_free_full (gslist.c:177)
==4935==    by 0x473A79: device_remove (device.c:2394)
==4935==    by 0x45D800: adapter_remove_device (adapter.c:1056)
==4935==    by 0x45F628: remove_device (adapter.c:2141)
==4935==
bluetoothd[4935]: profiles/audio/sink.c:stream_setup_retry() Stream
setup failed, after XCASE connect:connect
==4935== Invalid read of size 8
==4935==    at 0x41F482: stream_setup_retry (sink.c:197)
==4935==    by 0x4E7A8DA: g_timeout_dispatch (gmain.c:3882)
==4935==    by 0x4E79D12: g_main_context_dispatch (gmain.c:2539)
==4935==    by 0x4E7A05F: g_main_context_iterate.isra.23 (gmain.c:3146)
==4935==    by 0x4E7A459: g_main_loop_run (gmain.c:3340)
==4935==    by 0x44B094: main (main.c:583)
==4935==  Address 0x60e2db8 is 8 bytes inside a block of size 64 free'd
==4935==    at 0x4C2A82E: free (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==4935==    by 0x41FAC0: sink_free (sink.c:368)
==4935==    by 0x41FB1E: sink_unregister (sink.c:375)
==4935==    by 0x41E43B: audio_device_unregister (device.c:252)
==4935==    by 0x412F33: audio_remove (manager.c:103)
==4935==    by 0x46E6FA: service_shutdown (service.c:174)
==4935==    by 0x4705E8: remove_service (device.c:969)
==4935==    by 0x4E940B6: g_slist_foreach (gslist.c:840)
==4935==    by 0x4E940DA: g_slist_free_full (gslist.c:177)
==4935==    by 0x473A79: device_remove (device.c:2394)
==4935==    by 0x45D800: adapter_remove_device (adapter.c:1056)
==4935==    by 0x45F628: remove_device (adapter.c:2141)
==4935==
==4935== Invalid read of size 4
==4935==    at 0x46EB2A: btd_service_connecting_complete (service.c:315)
==4935==    by 0x41F492: stream_setup_retry (sink.c:197)
==4935==    by 0x4E7A8DA: g_timeout_dispatch (gmain.c:3882)
==4935==    by 0x4E79D12: g_main_context_dispatch (gmain.c:2539)
==4935==    by 0x4E7A05F: g_main_context_iterate.isra.23 (gmain.c:3146)
==4935==    by 0x4E7A459: g_main_loop_run (gmain.c:3340)
==4935==    by 0x44B094: main (main.c:583)
==4935==  Address 0x60de3e0 is 32 bytes inside a block of size 40 free'd
==4935==    at 0x4C2A82E: free (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==4935==    by 0x46E557: btd_service_unref (service.c:130)
==4935==    by 0x470619: remove_service (device.c:971)
==4935==    by 0x4E940B6: g_slist_foreach (gslist.c:840)
==4935==    by 0x4E940DA: g_slist_free_full (gslist.c:177)
==4935==    by 0x473A79: device_remove (device.c:2394)
==4935==    by 0x45D800: adapter_remove_device (adapter.c:1056)
==4935==    by 0x45F628: remove_device (adapter.c:2141)
==4935==    by 0x40C1A9: process_message (object.c:258)
==4935==    by 0x40DC06: generic_message (object.c:1056)
==4935==    by 0x5143C40: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
==4935==    by 0x5135B0F: dbus_connection_dispatch (in
/lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
==4935==
==4935== Invalid read of size 4
==4935==    at 0x46EB36: btd_service_connecting_complete (service.c:316)
==4935==    by 0x41F492: stream_setup_retry (sink.c:197)
==4935==    by 0x4E7A8DA: g_timeout_dispatch (gmain.c:3882)
==4935==    by 0x4E79D12: g_main_context_dispatch (gmain.c:2539)
==4935==    by 0x4E7A05F: g_main_context_iterate.isra.23 (gmain.c:3146)
==4935==    by 0x4E7A459: g_main_loop_run (gmain.c:3340)
==4935==    by 0x44B094: main (main.c:583)
==4935==  Address 0x60de3e0 is 32 bytes inside a block of size 40 free'd
==4935==    at 0x4C2A82E: free (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==4935==    by 0x46E557: btd_service_unref (service.c:130)
==4935==    by 0x470619: remove_service (device.c:971)
==4935==    by 0x4E940B6: g_slist_foreach (gslist.c:840)
==4935==    by 0x4E940DA: g_slist_free_full (gslist.c:177)
==4935==    by 0x473A79: device_remove (device.c:2394)
==4935==    by 0x45D800: adapter_remove_device (adapter.c:1056)
==4935==    by 0x45F628: remove_device (adapter.c:2141)
==4935==    by 0x40C1A9: process_message (object.c:258)
==4935==    by 0x40DC06: generic_message (object.c:1056)
==4935==    by 0x5143C40: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
==4935==    by 0x5135B0F: dbus_connection_dispatch (in
/lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
==4935==
==4935== Invalid read of size 4
==4935==    at 0x41F497: stream_setup_retry (sink.c:199)
==4935==    by 0x4E7A8DA: g_timeout_dispatch (gmain.c:3882)
==4935==    by 0x4E79D12: g_main_context_dispatch (gmain.c:2539)
==4935==    by 0x4E7A05F: g_main_context_iterate.isra.23 (gmain.c:3146)
==4935==    by 0x4E7A459: g_main_loop_run (gmain.c:3340)
==4935==    by 0x44B094: main (main.c:583)
==4935==  Address 0x60e2de4 is 52 bytes inside a block of size 64 free'd
==4935==    at 0x4C2A82E: free (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==4935==    by 0x41FAC0: sink_free (sink.c:368)
==4935==    by 0x41FB1E: sink_unregister (sink.c:375)
==4935==    by 0x41E43B: audio_device_unregister (device.c:252)
==4935==    by 0x412F33: audio_remove (manager.c:103)
==4935==    by 0x46E6FA: service_shutdown (service.c:174)
==4935==    by 0x4705E8: remove_service (device.c:969)
==4935==    by 0x4E940B6: g_slist_foreach (gslist.c:840)
==4935==    by 0x4E940DA: g_slist_free_full (gslist.c:177)
==4935==    by 0x473A79: device_remove (device.c:2394)
==4935==    by 0x45D800: adapter_remove_device (adapter.c:1056)
==4935==    by 0x45F628: remove_device (adapter.c:2141)
==4935==
