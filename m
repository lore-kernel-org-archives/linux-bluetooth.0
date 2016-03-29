Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Mar 2016 14:32:29 +0200
Message-ID: <CAMes48935-joX6LCUQyAjSVR3NV5RfGp+FgJjkzNXpJBioSv1A@mail.gmail.com>
Subject: Microsoft Sculpt Touch Bluetooth mouse disconnects
From: Jon Doe <tuksgig@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

My bluetooth mouse keeps on disconnecting after a few minutes. This is
a common problem (see
https://bugs.launchpad.net/linuxmint/+bug/1417444 and
https://bugzilla.redhat.com/show_bug.cgi?id=923349 ).

I have booted Windows in a VM and captured USB bluetooth traffic to
try and see what's going wrong. There are a few differences in the
setup sequence (encryption is enabled, link policies are set with park
mode enabled, flush timeout set to 0, MTU size is bigger at 672 etc).
I've tried a few custom commands to try and emulate the Windows setup.
What I've tried so far:

hcitool cmd 0x02 0x0d 0x2a 0 0x0f 0 (write link policy settings)
hcitool cmd 0x02 0x05 0x2a 0 0x50 0 0x40 0 (set park state)
hcitool enc 28:18:78:xx:xx:xx (enable encryption)
hciconfig hci0 aclmtu 672:8 (set MTU size)

So far, no luck. After about 600 seconds the mouse goes to sleep. On
wakeup, it does try to reconnect, but something goes wrong and the
mouse dies :-(

What else can I try?
