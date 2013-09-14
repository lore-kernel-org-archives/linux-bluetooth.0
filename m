Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/3] Bluetooth: Fix L2CAP Disconnect response for unknown CID
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379061827-8595-2-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 13 Sep 2013 18:40:25 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <34565D06-3DDE-40FE-A9D7-D2667630C5A7@holtmann.org>
References: <1379061827-8595-1-git-send-email-johan.hedberg@gmail.com> <1379061827-8595-2-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If we receive an L2CAP Disconnect Request for an unknown CID we should
> not just silently drop it but reply with a proper Command Reject
> response. This patch fixes this by ensuring that the disconnect handler
> returns a proper error instead of 0 and will cause the function caller
> to send the right response.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index b3bb7bc..ea3792f 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4206,7 +4206,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
> 	chan = __l2cap_get_chan_by_scid(conn, dcid);
> 	if (!chan) {
> 		mutex_unlock(&conn->chan_lock);
> -		return 0;
> +		return -EINVAL;
> 	}

the only problem that I have here is that we end up with the wrong error code. The L2CAP core still contains this comment:

/* FIXME: Map err to a valid reason */

And now we default to L2CAP_REJ_NOT_UNDERSTOOD, but in this case it should be L2CAP_REJ_INVALID_CID.

Regards

Marcel

