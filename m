Return-Path: <cyrus@holtmann.org>
Message-ID: <1350085575.19673.6.camel@aeonflux>
Subject: Re: [PATCH -v3 1/2] Bluetooth: Move bt_accept_enqueue() to
 l2cap_sock.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Sat, 13 Oct 2012 01:46:15 +0200
In-Reply-To: <1350041724-29948-1-git-send-email-gustavo@padovan.org>
References: <1350041724-29948-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> This is part of the move the parent socket usage to l2cap_sock.c
> 
> The change is safe when it cames to locking, bt_accept_enqueue() is still

it is "comes".

> protected by the parent socket lock inside the
> l2cap_sock_new_connection_cb() code.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  net/bluetooth/l2cap_core.c | 4 ----
>  net/bluetooth/l2cap_sock.c | 2 ++
>  2 files changed, 2 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


