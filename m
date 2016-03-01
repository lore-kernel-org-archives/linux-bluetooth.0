Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: Atheros 0cf3:3004 duplicate bluetooth device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <56D58217.2050500@gmail.com>
Date: Tue, 1 Mar 2016 08:32:12 -0800
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Message-Id: <A93095D9-C778-47D8-8EF4-D1806C793172@holtmann.org>
References: <56D58217.2050500@gmail.com>
To: Dmitry Tunin <hanipouspilot@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitry,

> We have a problem with Atheros 0cf3:3004 devices.
> 
> Atheros people re-used the PID for a new Rome device.
> 
> This is a Rome device:
> 
> T: Bus=01 Lev=02 Prnt=02 Port=02 Cnt=01 Dev#= 3 Spd=12 MxCh= 0
> D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=0cf3 ProdID=3004 Rev=00.01
> C: #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I: If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> I: If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> 
> 
> This is a pre-rome AR3012 device:
> 
> T: Bus=01 Lev=01 Prnt=01 Port=07 Cnt=05 Dev#= 8 Spd=12 MxCh= 0
> D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=0cf3 ProdID=3004 Rev=00.02
> S: Manufacturer=Atheros Communications
> S: Product=Bluetooth USB Host Controller
> S: SerialNumber=Alaska Day 2006
> C: #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I: If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I: If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> As you can see, there is nothing we can really base on. Revision does not help, because there could be other AR3012 devices with Rev 00.01.
> 
> An option could be to use this PID as a Rome in new kernels. But that will cause regressions for old devices.
> 
> My opinion is that this can't be fixed at the kernel level. For distros it is possible to provide DKMS drivers, specific to the Rome.
> But it will be a bit hard to maintain.
> 
> What do you thing as the last authority in this case?

I think one of the Qualcomm guys needs to come and tell us what is going on here and what are the options. Maybe it is possible to send a vendor HCI command or vendor USB command to identify the device correctly.

We do now have the hdev->setup and even inside the USB driver, we have a pre-stage of its own. There is a chance to actually merge some of the ath3k stuff back into btusb with offloading the Qualcomm specific pieces into a separate library modules (like we do with btintel, btbcm etc.).

Regards

Marcel
