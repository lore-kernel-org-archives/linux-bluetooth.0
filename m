Return-Path: <cyrus@holtmann.org>
Message-ID: <1338094966.15105.100.camel@aeonflux>
Subject: Re: [PATCH -v2 04/12] Bluetooth: Use l2cap_chan_ready() in LE path
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Sun, 27 May 2012 07:02:46 +0200
In-Reply-To: <1337949064-26187-5-git-send-email-gustavo@padovan.org>
References: <1337949064-26187-1-git-send-email-gustavo@padovan.org>
	 <1337949064-26187-5-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> This replace code in l2cap_le_conn_ready() by a similar code in
> l2cap_chan_ready().
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  net/bluetooth/l2cap_core.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


