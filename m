Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Apr 2013 20:29:17 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	johan.hedberg@intel.com, don.fry@intel.com
Subject: Re: [PATCH v7] Bluetooth: Add support for Intel Bluetooth device
 [8087:07dc]
Message-ID: <20130423232917.GB1697@joana>
References: <7512829.DBWZ3dSBuK@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7512829.DBWZ3dSBuK@tedd-ubuntu>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

* Tedd Ho-Jeong An <tedd.an@intel.com> [2013-04-19 09:57:43 -0700]:

> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> This patch adds support for Intel Bluetooth device by adding
> btusb_setup_intel() routine that update the device with ROM patch.
> 
> T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  4 Spd=12   MxCh= 0
> D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=8087 ProdID=07dc Rev= 0.01
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> v7 changes:
>  - fixed endian swapping for opcode
>  - removed type casting for cmd_param in in __hci_cmd_sync_ev()
>  - made command param arrays to const
>  - minor format change
>  - required Johan's new patch: [PATCH] Bluetooth: Fix HCI command send functions to use const specifier
> 
>  drivers/bluetooth/btusb.c |  378 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 378 insertions(+)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
