Return-Path: <cyrus@holtmann.org>
From: Marcos Chaparro <marcos@mrkindustries.com.ar>
To: Gustavo Padovan <gustavo@padovan.org>
Subject: Re: [PATCH] ath3k: Add support for VAIO VPCEH [0489:e027]
Date: Thu, 1 Nov 2012 20:19:38 -0300
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <201210291009.12913.marcos@mrkindustries.com.ar> <201211011940.45569.marcos@mrkindustries.com.ar> <20121101225331.GB1915@joana>
In-Reply-To: <20121101225331.GB1915@joana>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201211012019.38950.marcos@mrkindustries.com.ar>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday, November 01, 2012 19:53:31 Gustavo Padovan wrote:
> > # cat /sys/kernel/debug/usb/devices
> > T:  Bus=01 Lev=02 Prnt=02 Port=04 Cnt=02 Dev#= 11 Spd=12   MxCh= 0
> > D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> > P:  Vendor=0cf3 ProdID=3005 Rev= 0.01
> 
> I actually need the output without the patch in, showing the 0x0489 vendor
> id. Sorry, but we like to document the devices we add support properly.

I rebooted with an old (3.2.0-3-amd64) kernel and I still have the correct ID 
0cf3:3005, I can't see the old usb ID.

I tried reloading all the bluetooth related modules but it still gets 
identified as an 0cf3:3005.

Do you know how can I delete the device firmware to revert it to the original 
state?

Apparently its keeping the firmware from my patched kernel.

root@bluestreak:/home/marcos# lsusb
Bus 001 Device 004: ID 0cf3:3005 Atheros Communications, Inc. AR3011 Bluetooth

Best regards

--
Marcos
