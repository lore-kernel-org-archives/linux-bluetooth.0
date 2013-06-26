Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Jun 2013 18:33:34 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Bluetooth: Add support for Atheros [0cf3:e003]
Message-ID: <20130626173334.GB3337@joana>
References: <1371706725-2581-1-git-send-email-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371706725-2581-1-git-send-email-acelan.kao@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi AceLan,

* AceLan Kao <acelan.kao@canonical.com> [2013-06-20 13:38:45 +0800]:

> Add support for the AR9462 chip
> 
> T:  Bus=02 Lev=02 Prnt=02 Port=04 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0cf3 ProdID=e003 Rev=00.02
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---
>  drivers/bluetooth/ath3k.c | 2 ++
>  drivers/bluetooth/btusb.c | 1 +
>  2 files changed, 3 insertions(+)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
