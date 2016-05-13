Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] Bluetooth: Add USB ID 13D3:3487 to ath3k
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1462826171-12707-1-git-send-email-lauro@polilinux.com.br>
Date: Fri, 13 May 2016 07:55:40 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <924DD1E4-CD48-4046-8736-A12D519D894B@holtmann.org>
References: <3a33c6785127246e637533ec75d81bf7@polilinux.com.br> <1462826171-12707-1-git-send-email-lauro@polilinux.com.br>
To: Lauro Costa <lauro@polilinux.com.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lauro,

> Add hw id to ath3k usb device list and btusb blacklist
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=08 Cnt=02 Dev#=  4 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3487 Rev=00.02
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Requires these firmwares:
> ar3k/AthrBT_0x11020100.dfu and ar3k/ramps_0x11020100_40.dfu
> Firmwares are available in linux-firmware.
> 
> Device found in a laptop ASUS model N552VW. It's an Atheros AR9462 chip.
> 
> Signed-off-by: Lauro Costa <lauro@polilinux.com.br>
> ---
> drivers/bluetooth/ath3k.c | 2 ++
> drivers/bluetooth/btusb.c | 1 +
> 2 files changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

