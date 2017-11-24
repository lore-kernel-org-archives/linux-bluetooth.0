Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1511546188.11411.26.camel@hadess.net>
Subject: Re: [PATCH BlueZ] control: Fix invalid access
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Fri, 24 Nov 2017 18:56:28 +0100
In-Reply-To: <20171123130145.10480-1-luiz.dentz@gmail.com>
References: <20171123130145.10480-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2017-11-23 at 15:01 +0200, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When both controller and target roles are supported by a device they
> would share the same btd_service user_data pointer which would lead
> to
> use after free once either service is removed.

After this patch, I'm getting this backtrace when removing remote
devices:
bluetoothd[8327]: profiles/audio/control.c:path_unregister() Unregistered interface org.bluez.MediaControl1 on path /org/bluez/hci0/dev_38_71_DE_C0_FC_26
bluetoothd[8327]: Assertion failed: (service->state == BTD_SERVICE_STATE_UNAVAILABLE) src/service.c:323 in btd_service_set_user_data
bluetoothd[8327]: ++++++++ backtrace ++++++++
bluetoothd[8327]: #1  btd_service_set_user_data+0x2c (src/service.c:324) [0x46a23c]
bluetoothd[8327]: #2  path_unregister+0x33 (profiles/audio/control.c:280) [0x41fd13]
bluetoothd[8327]: #3  remove_interface+0x53 (gdbus/object.c:668) [0x488b43]
bluetoothd[8327]: #4  g_dbus_unregister_interface+0x3a (gdbus/object.c:1391) [0x48904a]
bluetoothd[8327]: #5  service_remove+0x29 (src/service.c:177) [0x469ff9]
bluetoothd[8327]: #6  device_remove+0x6a (src/device.c:4043) [0x4758ca]
bluetoothd[8327]: #7  btd_adapter_remove_device+0x10d (src/adapter.c:1209) [0x461c4d]
bluetoothd[8327]: #8  remove_device+0x73 (src/adapter.c:3034) [0x462963]
bluetoothd[8327]: #9  process_message.isra.7+0x1b (gdbus/object.c:261) [0x4898cb]
bluetoothd[8327]: #10 _dbus_object_tree_dispatch_and_unlock+0x170 (/usr/lib64/libdbus-1.so.3.19.2) [0x7f206c84d3e0]
bluetoothd[8327]: #11 dbus_connection_dispatch+0x32a (/usr/lib64/libdbus-1.so.3.19.2) [0x7f206c83e20a]
bluetoothd[8327]: #12 message_dispatch+0x10 (gdbus/mainloop.c:72) [0x4865a0]
bluetoothd[8327]: #13 g_idle_dispatch+0x17 (/usr/lib64/libglib-2.0.so.0.5400.2) [0x7f206cabf597]
bluetoothd[8327]: #14 g_main_context_dispatch+0x157 (/usr/lib64/libglib-2.0.so.0.5400.2) [0x7f206cac2bb7]
bluetoothd[8327]: #15 g_main_context_iterate.isra.25+0x200 (/usr/lib64/libglib-2.0.so.0.5400.2) [0x7f206cac2f60]
bluetoothd[8327]: #16 g_main_loop_run+0xc2 (/usr/lib64/libglib-2.0.so.0.5400.2) [0x7f206cac3272]
bluetoothd[8327]: #17 main+0x839 (src/main.c:772) [0x40bd99]
bluetoothd[8327]: #18 __libc_start_main+0xe7 (../csu/libc-start.c:340) [0x7f206bd5c187]
bluetoothd[8327]: #19 _start+0x2a (/home/hadess/Projects/jhbuild/bluez/src/bluetoothd) [0x40c5ca]
bluetoothd[8327]: +++++++++++++++++++++++++++

This is with git master + an irrelevant patch to the autopair plugin
