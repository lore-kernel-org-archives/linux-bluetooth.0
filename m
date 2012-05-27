Return-Path: <cyrus@holtmann.org>
Message-ID: <1338094749.15105.97.camel@aeonflux>
Subject: Re: [PATCH -v2 01/12] Bluetooth: Remove extra
 l2cap_state_change(BT_CONNECTED)
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Sun, 27 May 2012 06:59:09 +0200
In-Reply-To: <1337949064-26187-2-git-send-email-gustavo@padovan.org>
References: <1337949064-26187-1-git-send-email-gustavo@padovan.org>
	 <1337949064-26187-2-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> This is already performed inside l2cap_chan_ready(), so we don't need it
> here again.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    3 ---
>  1 file changed, 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


