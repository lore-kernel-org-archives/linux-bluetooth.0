Return-Path: <hanipouspilot@gmail.com>
From: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: Gustavo Padovan <gustavo@padovan.org>, hanipouspilot@gmail.com,
 Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth <linux-bluetooth@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Atheros 0cf3:3004 duplicate bluetooth device
To: Marcel Holtmann <marcel@holtmann.org>
Message-ID: <56D58217.2050500@gmail.com>
Date: Tue, 1 Mar 2016 14:50:47 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Marcel

We have a problem with Atheros 0cf3:3004 devices.

Atheros people re-used the PID for a new Rome device.

This is a Rome device:

T: Bus=01 Lev=02 Prnt=02 Port=02 Cnt=01 Dev#= 3 Spd=12 MxCh= 0
D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=0cf3 ProdID=3004 Rev=00.01
C: #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I: If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
I: If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)


This is a pre-rome AR3012 device:

T: Bus=01 Lev=01 Prnt=01 Port=07 Cnt=05 Dev#= 8 Spd=12 MxCh= 0
D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=0cf3 ProdID=3004 Rev=00.02
S: Manufacturer=Atheros Communications
S: Product=Bluetooth USB Host Controller
S: SerialNumber=Alaska Day 2006
C: #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I: If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I: If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

As you can see, there is nothing we can really base on. Revision does not help, because there could be other AR3012 devices with Rev 00.01.

An option could be to use this PID as a Rome in new kernels. But that will cause regressions for old devices.

My opinion is that this can't be fixed at the kernel level. For distros it is possible to provide DKMS drivers, specific to the Rome.
But it will be a bit hard to maintain.

What do you thing as the last authority in this case?

Regards,

Dmitry.

 
