Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Reply-To: gregoire@gentil.com
To: linux-bluetooth@vger.kernel.org
From: =?UTF-8?Q?Gr=c3=a9goire_Gentil?= <gregoire@gentil.com>
Subject: rfcomm without bluetoothd?
Message-ID: <f4fea7cd-a68c-abc4-3e5e-c4ff80df118c@gentil.com>
Date: Thu, 29 Dec 2016 15:34:57 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm posting here because there doesn't seem to be any more the 
bluez-users mailing list.

I have a very optimized and constrained embedded device and I would like 
to use rfcomm WITHOUT dbus and bluetoothd daemon.

The following works:

dbus-daemon --system --fork
bluetoothd
sdptool add --channel=22 SP
rfcomm listen /dev/rfcomm0 22

but I would like to use rfcomm without dbus and bluetoothd running. How 
could I do that?

For reference, hidd works without bluetoothd so it's possible to 
associate and have some bluetooth communication in the kernel directly 
from a user-space application without bluetoothd running.

Many thanks in advance for any idea,

Grégoire
