Return-Path: <cyrus@holtmann.org>
Message-ID: <1350085611.19673.7.camel@aeonflux>
Subject: Re: [PATCH -v3 2/2] Bluetooth: Add chan->ops->defer()
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Sat, 13 Oct 2012 01:46:51 +0200
In-Reply-To: <1350041724-29948-2-git-send-email-gustavo@padovan.org>
References: <1350041724-29948-1-git-send-email-gustavo@padovan.org>
	 <1350041724-29948-2-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> When DEFER_SETUP is set defer() will trigger an authorization
> request to the userspace.
> 
> l2cap_chan_no_defer() is meant to be used when one does not want to
> support DEFER_SETUP (A2MP for example).
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  include/net/bluetooth/l2cap.h |  5 +++++
>  net/bluetooth/a2mp.c          |  1 +
>  net/bluetooth/l2cap_core.c    | 10 +++-------
>  net/bluetooth/l2cap_sock.c    | 10 ++++++++++
>  4 files changed, 19 insertions(+), 7 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


