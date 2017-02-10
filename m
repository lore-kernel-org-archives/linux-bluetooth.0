Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHHBb0d+bJGxSucQ_VsgG5jLfo_Xoct6orR3x8jz5ber9znnEA@mail.gmail.com>
References: <CAHHBb0d+bJGxSucQ_VsgG5jLfo_Xoct6orR3x8jz5ber9znnEA@mail.gmail.com>
From: Barry Byford <31baz66@gmail.com>
Date: Fri, 10 Feb 2017 21:54:12 +0000
Message-ID: <CAAu3APaN62PrzJLbCddwoxwjeEdonWK=qGsTe6_dS-7_gfe8eQ@mail.gmail.com>
Subject: Re: BlueZ 5.43 doesn't find controller; 5.19 did
To: Dave Beal <dbeal@cardinalpeak.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Dave,

On 10 February 2017 at 20:13, Dave Beal <dbeal@cardinalpeak.com> wrote:
> First of all, thanks to Luiz and Barry for responding to my emails
> yesterday.  I have updated to BlueZ 5.43.  However, now BlueZ no
> longer finds my Bluetooth controller.  BlueZ 5.19 did find it.  I'm
> running Linux kernel 3.10.49 on a Qualcomm development board; "uname
> -a" says:
>
> Linux apq8009 3.10.49-g3c78468 #1 SMP PREEMPT Mon Jan 16 14:50:44 MST
> 2017 armv7l GNU/Linux

Ah! That Linux kernel version seems quite old. I'll need to let one of
the developers
answer if that is your actual problem. However a quick google search or looking
through the archive of this mailing list suggests it might be.

>
> "hcitool dev" displays no devices, nor does the "list" command in bluetoothctl.
>
> Running bluetoothd with the -d and -n options produces:
>
> bluetoothd[1902]: Bluetooth daemon 5.43
> bluetoothd[1902]: src/adapter.c:adapter_init() sending read version command
> bluetoothd[1902]: Starting SDP server
> bluetoothd[1902]: src/sdpd-service.c:register_device_id() Adding
> device id record for 0002:1d6b:0246:052b
> bluetoothd[1902]: src/plugin.c:plugin_init() Loading builtin plugins
> bluetoothd[1902]: src/plugin.c:add_plugin() Loading hostname plugin
> bluetoothd[1902]: src/plugin.c:add_plugin() Loading wiimote plugin
> bluetoothd[1902]: src/plugin.c:add_plugin() Loading autopair plugin
> bluetoothd[1902]: src/plugin.c:add_plugin() Loading policy plugin
> bluetoothd[1902]: src/plugin.c:add_plugin() Loading a2dp plugin
> bluetoothd[1902]: src/plugin.c:add_plugin() Loading avrcp plugin
> bluetoothd[1902]: src/plugin.c:add_plugin() Loading network plugin
> bluetoothd[1902]: src/plugin.c:add_plugin() Loading input plugin
> bluetoothd[1902]: src/plugin.c:add_plugin() Loading hog plugin
> bluetoothd[1902]: src/plugin.c:add_plugin() Loading gap plugin
> bluetoothd[1902]: src/plugin.c:add_plugin() Loading scanparam plugin
> bluetoothd[1902]: src/plugin.c:add_plugin() Loading deviceinfo plugin
> bluetoothd[1902]: src/plugin.c:plugin_init() Loading plugins
> /usr/lib/bluetooth/plugins
> bluetoothd[1902]: profiles/input/suspend-none.c:suspend_init()
> bluetoothd[1902]: profiles/network/manager.c:read_config()
> /etc/bluetooth/network.conf: Key file does not have key
> 'DisableSecurity'
> bluetoothd[1902]: profiles/network/manager.c:read_config() Config
> options: Security=true
> bluetoothd[1902]: Failed to open RFKILL control device
> bluetoothd[1902]: src/main.c:main() Entering main loop
> bluetoothd[1902]: Bluetooth management interface 1.3 initialized
> bluetoothd[1902]: src/adapter.c:read_version_complete() sending read
> supported commands command
> bluetoothd[1902]: src/adapter.c:read_version_complete() sending read
> index list command
> bluetoothd[1902]: src/adapter.c:read_commands_complete() Number of commands: 38
> bluetoothd[1902]: src/adapter.c:read_commands_complete() Number of events: 21
> bluetoothd[1902]: src/adapter.c:read_index_list_complete() Number of
> controllers: 0
>
> Grepping dmesg for "blue" produces:
>
> [    0.408223] Bluetooth: Core ver 2.16
> [    0.408287] Bluetooth: HCI device and connection manager initialized
> [    0.408303] Bluetooth: HCI socket layer initialized
> [    0.408318] Bluetooth: L2CAP socket layer initialized
> [    0.408394] Bluetooth: SCO socket layer initialized
> [    6.175305] Bluetooth: RFCOMM TTY layer initialized
> [    6.175348] Bluetooth: RFCOMM socket layer initialized
> [    6.175355] Bluetooth: RFCOMM ver 1.11
> [    6.175363] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    6.175369] Bluetooth: BNEP filters: protocol multicast
> [    6.175386] Bluetooth: BNEP socket layer initialized
> [    6.175394] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [    6.175409] Bluetooth: HIDP socket layer initialized
>
> Is there something I need to configure so that Bluez 5.43 finds my
> controller?  Thanks!
>
> - Dave
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
