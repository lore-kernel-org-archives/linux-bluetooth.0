Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 19 Jan 2010 18:53:46 +0300
Message-ID: <5d6875a11001190753j58aef427v2205f50760bcd477@mail.gmail.com>
Subject: bluetoothd Permission denied (13) when connecting A2DP headset
From: Murz <murznn@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have using bluez 4.60-0ubuntu1 and blueman 1.21-1~ppa1k on Kubuntu 9.10 AMD64.
My bluetooth dongle is USB:
Bus 002 Device 002: ID 1131:1004 Integrated System Solution Corp.
Bluetooth Device

I can successfully pair computer with mobile phone (HTC Touch HD, WM
6.5.3), connect via serial (dialup) and send files via bluetooth to
the device.
I have a Nokia BH-504 headset. It successfully connects with mobile
phone via A2DP and Headset profiles.

But I can't connect it with bluez on computer!

I try this on four computers, and on one fresh install of Kubuntu 9.10
and always see the permission error!

bluez see the headset, I can succesfully pair it with password "0000".
But when I try connect to any service (A2DP or Headset), I see the
error in /var/log/daemon.log:
Jan 19 18:29:47 axe bluetoothd[22040]: Permission denied (13)

If I run bluetoothd -n -d, on connect process I see:
bluetoothd[22040]: avdtp_ref(0x7f6b42fa6c10): ref=2
bluetoothd[22040]: stream creation in progress
bluetoothd[22040]: adapter_get_device(00:22:FC:74:AA:3C)
bluetoothd[22040]: Permission denied (13)
bluetoothd[22040]: Disconnected from 00:22:FC:74:AA:3C
bluetoothd[22040]: avdtp_unref(0x7f6b42fa6c10): ref=1
bluetoothd[22040]: connect:connect XCASE detected
bluetoothd[22040]: avdtp_unref(0x7f6b42fa6c10): ref=0
bluetoothd[22040]: avdtp_unref(0x7f6b42fa6c10): freeing session and
removing from list
bluetoothd[22040]: Stream setup failed, after XCASE connect:connect

bluetoothd is ran as root, blueman I try to ran as my user and as root too.

Which permissions does bluetoothd needs to create this connection? How
I can give they to him?

I can give you any additional info about my system, please help me
detect the problem!
