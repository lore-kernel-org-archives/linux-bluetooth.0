Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] drivers/bluetooth/: Toshiba Qualcomm AR9565 (ath3k) bluetooth fix for c55-b-138 notebooks
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2205962.RYjnk7AA7X@venture>
Date: Thu, 7 Aug 2014 11:34:50 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6B2F2793-5A11-4659-9775-AE906C197867@holtmann.org>
References: <2205962.RYjnk7AA7X@venture>
To: Vincent Elger Zwanenburg <vincentezw@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vincent,

> From:  Vincent Elger Zwanenburg <vincentz@topmail.ie>
> Date:   Tue Aug 7 18:20:27 2014 +0100
> 
> Bluetooth: Add a new PID/VID 0227/0930 for AR3012.
> 
> usb devices info:
> 
> T:  Bus=01 Lev=02 Prnt=05 Port=00 Cnt=01 Dev#= 20 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0930 ProdID=0227 Rev= 0.02
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> Signed-off-by: Vincent Elger Zwanenburg <vincentz@topmail.ie>

Applying: drivers/bluetooth/: Toshiba Qualcomm AR9565 (ath3k) bluetooth fix for c55-b-138 notebooks
error: usr/src/linux-3.16/drivers/bluetooth/ath3k.c: does not exist in index
error: usr/src/linux-3.16/drivers/bluetooth/btusb.c: does not exist in index
Patch failed at 0001 drivers/bluetooth/: Toshiba Qualcomm AR9565 (ath3k) bluetooth fix for c55-b-138 notebooks

Can you please send me a patch that I can apply using git am. And please make sure it is against bluetooth-next tree.

Regards

Marcel

