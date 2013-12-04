Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Dec 2013 11:12:27 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Marco Piazza <mpiazza@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for Toshiba Bluetooth device
 [0930:0220]
Message-ID: <20131204131227.GC1608@joana>
References: <1385594125-7964-1-git-send-email-mpiazza@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385594125-7964-1-git-send-email-mpiazza@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marco,

2013-11-28 Marco Piazza <mpiazza@gmail.com>:

> This patch adds support for new Toshiba Bluetooth device.
> 
> T:  Bus=05 Lev=01 Prnt=01 Port=02 Cnt=02 Dev#=  4 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0930 ProdID=0220 Rev=00.02
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Signed-off-by: Marco Piazza <mpiazza@gmail.com>
> ---
>  drivers/bluetooth/ath3k.c | 2 ++
>  drivers/bluetooth/btusb.c | 1 +
>  2 files changed, 3 insertions(+)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
