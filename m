Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2 2/2] Bluetooth: btusb: Add support for QCA ROME chipset family
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <782CEA04-7241-4AC6-BD39-F0FEB49AAF2B@holtmann.org>
Date: Mon, 2 Mar 2015 17:17:29 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <B37A934A-7A6F-4D02-A3A1-081BB5DC5A48@holtmann.org>
References: <403291a4c9b848f6956683e60c7e016f@nalasexr02e.na.qualcomm.com> <782CEA04-7241-4AC6-BD39-F0FEB49AAF2B@holtmann.org>
To: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ben,

>> This patch supports ROME Bluetooth family from Qualcomm Atheros,
>> e.g. QCA61x4 or QCA6574.
>> 
>> New chipset have similar firmware downloading sequences to previous
>> chipset from Atheros, however, it doesn't support vid/pid switching
>> after downloading the patch so that firmware needs to be handled by
>> btusb module directly.
>> 
>> ROME chipset can be differentiated from previous version by reading
>> ROM version.
>> 
>> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 16 Spd=12   MxCh= 0
>> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>> P:  Vendor=0cf3 ProdID=e300 Rev= 0.01
>> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>> 
>> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  8 Spd=12   MxCh= 0
>> D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>> P:  Vendor=0cf3 ProdID=e360 Rev= 0.01
>> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>> 
>> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
>> ---
>> drivers/bluetooth/btusb.c | 254 ++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 254 insertions(+)
> 
> patch has been applied to bluetooth-next tree.

and now I am regretting having applied this patch. Have you actually run make C=2 on this?

  CHECK   drivers/bluetooth/btusb.c
drivers/bluetooth/btusb.c:2677:11: warning: incorrect type in initializer (different base types)
drivers/bluetooth/btusb.c:2677:11:    expected restricted __le32 [usertype] rom_version
drivers/bluetooth/btusb.c:2677:11:    got int
drivers/bluetooth/btusb.c:2678:11: warning: incorrect type in initializer (different base types)
drivers/bluetooth/btusb.c:2678:11:    expected restricted __le32 [usertype] rom_version
drivers/bluetooth/btusb.c:2678:11:    got int
drivers/bluetooth/btusb.c:2679:11: warning: incorrect type in initializer (different base types)
drivers/bluetooth/btusb.c:2679:11:    expected restricted __le32 [usertype] rom_version
drivers/bluetooth/btusb.c:2679:11:    got int
drivers/bluetooth/btusb.c:2680:11: warning: incorrect type in initializer (different base types)
drivers/bluetooth/btusb.c:2680:11:    expected restricted __le32 [usertype] rom_version
drivers/bluetooth/btusb.c:2680:11:    got int
drivers/bluetooth/btusb.c:2681:11: warning: incorrect type in initializer (different base types)
drivers/bluetooth/btusb.c:2681:11:    expected restricted __le32 [usertype] rom_version
drivers/bluetooth/btusb.c:2681:11:    got int
drivers/bluetooth/btusb.c:2805:17: warning: restricted __le16 degrades to integer
drivers/bluetooth/btusb.c:2805:37: warning: restricted __le32 degrades to integer
drivers/bluetooth/btusb.c:2806:17: warning: restricted __le16 degrades to integer
drivers/bluetooth/btusb.c:2806:39: warning: restricted __le32 degrades to integer

Please fix this quickly. Getting endian conversion right is important.

Regards

Marcel

