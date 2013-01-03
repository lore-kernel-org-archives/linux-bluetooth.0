Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Jan 2013 18:59:57 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Add support for Foxconn / Hon Hai
 [0489:e056]
Message-ID: <20130103205957.GE2114@joana>
References: <1357187100-9658-1-git-send-email-acelan.kao@canonical.com>
 <1357187100-9658-2-git-send-email-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357187100-9658-2-git-send-email-acelan.kao@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi AceLan,

* AceLan Kao <acelan.kao@canonical.com> [2013-01-03 12:25:00 +0800]:

> Add support for the AR9462 chip
> 
> T: Bus=01 Lev=02 Prnt=02 Port=05 Cnt=01 Dev#= 4 Spd=12 MxCh= 0
> D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=0489 ProdID=e056 Rev=00.01
> C: #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I: If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I: If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---
>  drivers/bluetooth/ath3k.c |    2 ++
>  drivers/bluetooth/btusb.c |    1 +
>  2 files changed, 3 insertions(+)

Both patches have been applied to bluetooth.git. Thanks.

	Gustavo
