Return-Path: <cyrus@holtmann.org>
Message-ID: <1349963512.27233.172.camel@aeonflux>
Subject: Re: [PATCH -v2 6/8] Bluetooth: use l2cap_chan_set_err()
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Thu, 11 Oct 2012 15:51:52 +0200
In-Reply-To: <1349938311-25101-6-git-send-email-gustavo@padovan.org>
References: <1349938311-25101-1-git-send-email-gustavo@padovan.org>
	 <1349938311-25101-6-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> l2cap_conn_unreliable() doesn't take the sk lock, so we need to take it
> using l2cap_chan_set_err().
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  net/bluetooth/l2cap_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


