Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170424082524.GD1084@annapurna>
References: <20170406125150.GF12069@annapurna> <CABBYNZJAs_kSpMk43okA1ZhJow_YZvuTqPPt-Oud2_5yOCD8jA@mail.gmail.com>
 <20170424082524.GD1084@annapurna>
From: Luke McKee <hojuruku@gmail.com>
Date: Mon, 24 Apr 2017 17:16:43 +0700
Message-ID: <CAENjB=KEy=70fG=RQC7xMKm2jrVVJjiHSkr7DXAD_HRYc+jspg@mail.gmail.com>
Subject: Re: Regression in bluez 5.44, bluetoothd crashes
To: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

You sound like a legend even though I'm a gentoo.org user working on
our bugs mostly ;)
https://bugs.gentoo.org/show_bug.cgi?id=613224

I have a nagging problem bluetooth requesting EDR to a device that
only supports EDR (high bandwidth) transport for communications for
connectionless mode (ADR from memory) not SCO.

Looking at the HCI dump it really looks like a linux bluetooth bug,
not a embedded firmware issue.

https://www.spinics.net/lists/linux-bluetooth/msg69931.html

On 24 April 2017 at 15:25, Konrad Zapalowicz
<konrad.zapalowicz@canonical.com> wrote:
> On 04/06, Luiz Augusto von Dentz wrote:
>> Hi Konrad,
>>
>> On Thu, Apr 6, 2017 at 3:51 PM, Konrad Zapalowicz
>> <konrad.zapalowicz@canonical.com> wrote:
>> > Hey,
>> >
>> > I see a regression in 5.44 when testing Sony SBH52 headset. It fails to
>> > connect profiles but the worst thing is that the bluetoothd crashes
>> > (logs below).
>> >
>> > I have git bisect'ed it down to the commit f2483bbfd. It works fine if
>> > I remove it.
>>
>> That is because the very next patch fix it:
>>
>> commit 4a8c33b1f76edf2dfe33b9956014cc2746ae71d8
>> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> Date:   Mon Nov 14 13:30:09 2016 +0200
>>
>>     core/adapter: Fix using wrong address type to listen ATT
>>
>>     bdaddr_type shall only matter for controllers supporting LE otherwise
>>     it may cause BDADDR_BREDR to be used for things like LE ATT socket
>>     listen breaking reconnections.
>>
>
> Is your suggestion that I might be missing the above patch? I have it
> included, I'm using regular 5.44 release.
>
>> > Stacktrace:
>> >
>> > (gdb) c
>> > Continuing.
>> >
>> > Program received signal SIGSEGV, Segmentation fault.
>> > strlen () at ../sysdeps/x86_64/strlen.S:106
>> > 106     ../sysdeps/x86_64/strlen.S: No such file or directory.
>> > (gdb) bt
>> > #0  strlen () at ../sysdeps/x86_64/strlen.S:106
>> > #1  0x00007f92806179a1 in _IO_vfprintf_internal (s=s@entry=0x557f37ad5520, format=<optimized out>, format@entry=0x557f36cd515c "%s:%s() %s err %d", ap=0x7ffc0b7a86d0)
>> >     at vfprintf.c:1637
>> > #2  0x00007f92806dffc6 in ___vfprintf_chk (fp=fp@entry=0x557f37ad5520, flag=flag@entry=1, format=format@entry=0x557f36cd515c "%s:%s() %s err %d",
>> >     ap=ap@entry=0x7ffc0b7a86d0) at vfprintf_chk.c:33
>> > #3  0x00007f92806c9028 in __GI___vsyslog_chk (pri=<optimized out>, pri@entry=7, flag=flag@entry=1, fmt=fmt@entry=0x557f36cd515c "%s:%s() %s err %d",
>> >     ap=ap@entry=0x7ffc0b7a86d0) at ../misc/syslog.c:222
>> > #4  0x0000557f36c6735b in vsyslog (__ap=0x7ffc0b7a86d0, __fmt=0x557f36cd515c "%s:%s() %s err %d", __pri=7) at /usr/include/x86_64-linux-gnu/bits/syslog.h:47
>> > #5  btd_debug (index=index@entry=65535, format=format@entry=0x557f36cd515c "%s:%s() %s err %d") at src/log.c:252
>> > #6  0x0000557f36c94d88 in device_svc_resolved (dev=0x557f36c90e60 <browse_request_exit>, bdaddr_type=0 '\000', err=-111) at src/device.c:2214
>> > #7  0x0000557f36c97adb in search_cb (user_data=<optimized out>, err=-111, recs=<optimized out>) at src/device.c:4516
>> > #8  browse_cb (recs=<optimized out>, err=-111, user_data=<optimized out>) at src/device.c:4549
>> > #9  0x0000557f36c73551 in connect_watch (chan=0x557f37ae0350, cond=<optimized out>, user_data=0x557f37ae0060) at src/sdp-client.c:286
>> > #10 0x00007f928124f6ea in g_main_context_dispatch () from target:/lib/x86_64-linux-gnu/libglib-2.0.so.0
>> > #11 0x00007f928124faa0 in ?? () from target:/lib/x86_64-linux-gnu/libglib-2.0.so.0
>> > #12 0x00007f928124fdc2 in g_main_loop_run () from target:/lib/x86_64-linux-gnu/libglib-2.0.so.0
>> > #13 0x0000557f36c353cc in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:708
>> > (gdb)
>>
>> Ok, so this seem to be SDP causing and error, 111 connection refused.
>>
>> > Syslog:
>> >
>> > bluetoothd: src/device.c:bonding_request_new() Requesting bonding for 68:76:4F:6C:31:E9
>> > bluetoothd: src/agent.c:agent_ref() 0x557f37ae5120: ref=3
>> > bluetoothd: src/agent.c:agent_unref() 0x557f37ae5120: ref=2
>> > bluetoothd: src/adapter.c:suspend_discovery()
>> > bluetoothd: src/adapter.c:adapter_bonding_attempt() hci0 bdaddr 68:76:4F:6C:31:E9 type 0 io_cap 0x01
>> > bluetoothd: src/adapter.c:add_whitelist_complete() 68:76:4F:6C:31:E9 added to kernel whitelist
>> > bluetoothd: src/adapter.c:connected_callback() hci0 device 68:76:4F:6C:31:E9 connected eir_len 12
>> > bluetoothd: src/adapter.c:new_link_key_callback() hci0 new key for 68:76:4F:6C:31:E9 type 4 pin_len 0 store_hint 1
>> > bluetoothd: src/device.c:device_set_bonded()
>> > bluetoothd: src/device.c:device_bonding_complete() bonding 0x557f37acc860 status 0x00
>> > bluetoothd: src/device.c:device_bonding_complete() Proceeding with service discovery
>> > bluetoothd: src/agent.c:agent_unref() 0x557f37ae5120: ref=1
>> > bluetoothd: src/adapter.c:resume_discovery()
>> > bluetoothd: src/adapter.c:pair_device_complete() Success (0x00)
>> > bluetoothd: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 68:76:4F:6C:31:E9 type 0 status 0x0
>> > bluetoothd: src/device.c:device_bonding_complete() bonding (nil) status 0x00
>> > bluetoothd: src/adapter.c:resume_discovery()
>> > bluetoothd: src/gatt-database.c:connect_cb() New incoming BR/EDR ATT connection
>> > bluetoothd: attrib/gattrib.c:g_attrib_ref() 0x557f37ae4b40: g_attrib_ref=1
>> > bluetoothd: src/device.c:load_gatt_db() Restoring 68:76:4F:6C:31:E9 gatt database from file
>> > bluetoothd: No cache for 68:76:4F:6C:31:E9
>> > bluetoothd: src/gatt-client.c:btd_gatt_client_connected() Device connected.
>> > bluetoothd: src/adapter.c:dev_disconnected() Device 68:76:4F:6C:31:E9 disconnected, reason 3
>> > bluetoothd: src/adapter.c:adapter_remove_connection()
>> > bluetoothd: plugins/policy.c:disconnect_cb() reason 3
>> > bluetoothd: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 68:76:4F:6C:31:E9 type 0 status 0xe
>> > bluetoothd: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
>> > bluetoothd: src/device.c:device_bonding_failed() status 14
>> > bluetoothd: src/adapter.c:resume_discovery()
>> > bluetoothd: src/device.c:gatt_debug() Primary service discovery failed. ATT ECODE: 0x00
>> > bluetoothd: src/device.c:gatt_debug() Failed to initialize gatt-client
>> > bluetoothd: src/device.c:gatt_client_ready_cb() status: failed, error: 0
>> > bluetoothd: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_68_76_4F_6C_31_E9 err -5
>> > bluetoothd: src/device.c:att_disconnected_cb()
>> > bluetoothd: src/device.c:att_disconnected_cb() Connection reset by peer (104)
>> > bluetoothd: src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected. Cleaning up.
>> > bluetoothd: src/device.c:att_disconnected_cb() Automatic connection disabled
>> > bluetoothd: attrib/gattrib.c:g_attrib_unref() 0x557f37ae4b40: g_attrib_unref=0
>> > bluetoothd: src/device.c:btd_device_set_trusted() trusted 1
>> > bluetoothd: src/device.c:connect_profiles() /org/bluez/hci0/dev_68_76_4F_6C_31_E9 (all), client :1.256
>> > bluetoothd: src/device.c:connect_profiles() Resolving services for /org/bluez/hci0/dev_68_76_4F_6C_31_E9
>> > bluetoothd: src/gatt-database.c:connect_cb() New incoming BR/EDR ATT connection
>> > bluetoothd: attrib/gattrib.c:g_attrib_ref() 0x557f37ae4b40: g_attrib_ref=1
>> > bluetoothd: src/device.c:load_gatt_db() Restoring 68:76:4F:6C:31:E9 gatt database from file
>> > bluetoothd: No cache for 68:76:4F:6C:31:E9
>> > bluetoothd: src/gatt-client.c:btd_gatt_client_connected() Device connected.
>> > bluetoothd: 89:48:53:01:00:27: error updating services: Connection refused (111)
>>
>> Interesting, the device is connecting ATT over BR/EDR which is weird
>> if that is a headset, and we can see the 111, though the address
>> printed seems wrong, I wonder if that is why it crashes.
>
> The address thing is something to check further. I have no such device
> in a range whatsoever.
>
>>
>> > There is one interestig thing that I have noticed examining the the
>> > btmon output. The bluez is repeatedly (literally till the end) sending
>> > the Information Request (Extended Feature Mask) and the headset is
>> > answering Not Supported. For the same headset bluez 5.43 sends this
>> > request only once. The bluez 5.44 works fine with a Phillips headset
>> > that answers Success to this knd of Information Response.
>>
>> Well this is the information request is sent by the kernel, so if you
>> haven't change it between versions that should not change between
>> daemon versions, but ATT is not a fixed channel on BR/EDR so I wonder
>> if the information request is actually sent because ATT is being
>> connected.
>
> Could be, good point.
>
>>
>> > Additionaly to Information Request (Ext Feature Mask) bluez 5.44 keeps
>> > repeating ATT Read By Group Type Request, GATT Primary Service
>> > Declaration which in case of Phillips device happens only once. Bluez
>> > 5.43 does not send it whatsoever.
>>
>> I suspect it doesn't even connect over ATT in 5.43, anyway that should
>> only happen once but I can see from the logs that it fails and
>> disconnects and then connects again.
>
> I'll capture some logs with 5.43 and share later this week. This looks
> interesting to follow.
>
> Thanks for your comments,
> K
>
>>
>> > Let me know if I can in any way help debugging this issue further.
>> >
>> > Thanks,
>> > Konrad
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
