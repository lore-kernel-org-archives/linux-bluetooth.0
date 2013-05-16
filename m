Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGd9gwgKMt21TnGLJ09+gAkP-=Jn9mfoAThiBuqup_vTyCshuw@mail.gmail.com>
References: <CAGd9gwgKMt21TnGLJ09+gAkP-=Jn9mfoAThiBuqup_vTyCshuw@mail.gmail.com>
From: Alex Deymo <deymo@chromium.org>
Date: Wed, 15 May 2013 21:06:59 -0700
Message-ID: <CAGd9gwgkWe+A5rbEnhgNxc5Va9TQt_-Pp04c5rP18nO2FF9f2A@mail.gmail.com>
Subject: Fwd: a2dp.c: finalize_config(setup) can destroy setup
To: keybuk <keybuk@chromium.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I just found this invalid read where finalize_config(setup); is
actually destroying the setup pointer passed there. The log attached
below is running with valgrind on bluez 5.5 (with a tiny patch to
src/log.{c|h} to have the debug file:line:function on error() as you
may see on the logs)

The code around the open_cfm (a2dp.c:730) is:
finalize_config(setup);

if (!setup->start || !err)
        return;

and the invalid must be the "setup->start". The debug log shows that
setup_free was called just before and if I'm not missing something, it
must come from finalize_setup()... but not sure why.

The steps to run into this (although there may be some timing
involved) are simply scan, pair, trust and connect the device with
bluetoothctl. Device is a Bose SoundLink model 404600.

I hope it helps,
Alex.


bluetoothd[11636]: profiles/audio/a2dp.c:open_cfm() Source 0x6124b40: Open_Cfm
bluetoothd[11636]: profiles/audio/sink.c:stream_setup_complete()
Stream successfully created
bluetoothd[11636]: src/service.c:change_state() 0x62897b0: device
00:0C:8A:XX:XX:XX profile audio-sink state changed: connecting ->
connected (0)
bluetoothd[11636]: src/device.c:device_profile_connected() audio-sink
Success (0)
bluetoothd[11636]: src/service.c:change_state() 0x62999d0: device
00:0C:8A:XX:XX:XX profile audio-avrcp-target state changed:
disconnected -> connecting (0)
bluetoothd[11636]: profiles/audio/manager.c:avrcp_target_connect()
path /org/bluez/hci0/dev_00_0C_8A_XX_XX_XX
bluetoothd[11636]: src/service.c:208:btd_service_connect()
audio-avrcp-target profile connect failed for 00:0C:8A:XX:XX:XX:
Operation already in progress
bluetoothd[11636]: src/service.c:change_state() 0x62999d0: device
00:0C:8A:XX:XX:XX profile audio-avrcp-target state changed: connecting
-> disconnected (-114)
bluetoothd[11636]: src/device.c:device_profile_connected()
audio-avrcp-target Operation already in progress (114)
bluetoothd[11636]: src/device.c:device_profile_connected() returning
response to :1.156
bluetoothd[11636]: profiles/audio/a2dp.c:setup_unref() 0x62c8520: ref=0
bluetoothd[11636]: profiles/audio/a2dp.c:setup_free() 0x62c8520
bluetoothd[11636]: profiles/audio/avdtp.c:avdtp_unref() 0x62a98b0: ref=1
==11636== Invalid read of size 4
==11636==    at 0x4214AD: open_cfm (a2dp.c:730)
==11636==    by 0x424D07: handle_transport_connect (avdtp.c:878)
==11636==    by 0x4288F2: avdtp_connect_cb (avdtp.c:2419)
==11636==    by 0x4458B8: connect_cb (btio.c:230)
==11636==    by 0x4E79D12: g_main_context_dispatch (gmain.c:2539)
==11636==    by 0x4E7A05F: g_main_context_iterate.isra.23 (gmain.c:3146)
==11636==    by 0x4E7A459: g_main_loop_run (gmain.c:3340)
==11636==    by 0x44B0AC: main (main.c:583)
==11636==  Address 0x62c8564 is 68 bytes inside a block of size 88 free'd
==11636==    at 0x4C2A82E: free (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==11636==    by 0x420094: setup_free (a2dp.c:156)
==11636==    by 0x420101: setup_unref (a2dp.c:168)
==11636==    by 0x4201CF: setup_cb_free (a2dp.c:191)
==11636==    by 0x4203DC: finalize_config (a2dp.c:234)
==11636==    by 0x4214A8: open_cfm (a2dp.c:728)
==11636==    by 0x424D07: handle_transport_connect (avdtp.c:878)
==11636==    by 0x4288F2: avdtp_connect_cb (avdtp.c:2419)
==11636==    by 0x4458B8: connect_cb (btio.c:230)
==11636==    by 0x4E79D12: g_main_context_dispatch (gmain.c:2539)
==11636==    by 0x4E7A05F: g_main_context_iterate.isra.23 (gmain.c:3146)
==11636==    by 0x4E7A459: g_main_loop_run (gmain.c:3340)
==11636==
