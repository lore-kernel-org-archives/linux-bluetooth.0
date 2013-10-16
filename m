Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Bluetooth: Reintroduce socket restrictions for LE sockets
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381919863-27504-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 16 Oct 2013 16:01:01 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <088BACEA-5E9A-4ECF-A447-56A9F8D03525@holtmann.org>
References: <1381919863-27504-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Right now we do not allow user space to use connection oriented channels
> on LE, and the only CID that can be used is the Attribute Protocol one.
> These restrictions went away together with the recent refactoring of the
> L2CAP code, but this patch puts them back to their appropriate places.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 20 ++++++++++++++++++++
> 1 file changed, 20 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 68f486a..bda52d7 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -72,6 +72,16 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
> 	if (!bdaddr_type_is_valid(la.l2_bdaddr_type))
> 		return -EINVAL;
> 
> +	if (la.l2_bdaddr_type == BDADDR_LE_PUBLIC ||
> +	    la.l2_bdaddr_type == BDADDR_LE_RANDOM) {

can we use bdaddr_type_is_le() here instead.

Regards

Marcel

