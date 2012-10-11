Return-Path: <cyrus@holtmann.org>
Message-ID: <1349963153.27233.167.camel@aeonflux>
Subject: Re: [PATCH -v2 3/8] Bluetooth: Remove parent socket usage from
 l2cap_core.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Thu, 11 Oct 2012 15:45:53 +0200
In-Reply-To: <1349938311-25101-3-git-send-email-gustavo@padovan.org>
References: <1349938311-25101-1-git-send-email-gustavo@padovan.org>
	 <1349938311-25101-3-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> We can lock the parent lock only inside the new_connection() call,
> then we just use the l2cap_chan_lock() in core code.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  net/bluetooth/l2cap_core.c | 16 ++++++----------
>  net/bluetooth/l2cap_sock.c |  9 ++++++++-
>  2 files changed, 14 insertions(+), 11 deletions(-)

I am fine with this patch under the premise that 2/8 is properly
explained. And here you need to also get into a bit more detail. With
any kind of locking changes, I expect a proper commit message explaining
why this is safe.

Regards

Marcel


