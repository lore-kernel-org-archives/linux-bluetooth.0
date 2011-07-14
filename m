Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jul 2011 14:20:14 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Ricardo Mendoza <ricmm@gentoo.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add Toshiba laptops AR30XX device ID
Message-ID: <20110714172014.GA4259@joana>
References: <1310569469-30717-1-git-send-email-ricmm@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310569469-30717-1-git-send-email-ricmm@gentoo.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ricardo,

* Ricardo Mendoza <ricmm@gentoo.org> [2011-07-13 16:04:29 +0100]:

> Blacklist Toshiba-branded AR3011 based AR5B195 [0930:0215] and add to
> ath3k.c for firmware loading.
> 
> Signed-off-by: Ricardo Mendoza <ricmm@gentoo.org>
> ---
>  drivers/bluetooth/ath3k.c |    1 +
>  drivers/bluetooth/btusb.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)

Applied, thanks.

	Gustavo
