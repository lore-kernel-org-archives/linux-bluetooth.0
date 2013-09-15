Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v3 5/8] Bluetooth: Fix error code for invalid CID in l2cap_config_req
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379179711-16436-6-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 14 Sep 2013 20:49:05 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DDB6D220-2DB5-49B3-9200-4AD8FBAAADDE@holtmann.org>
References: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com> <1379179711-16436-6-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The convention of the L2CAP code is to return EFAULT when a CID in the
> request packet is invalid. This patch fixes the l2cap_config_req to use
> that error code instead of ENOENT.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 9ec1561f..d134501 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3978,7 +3978,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
> 
> 	chan = l2cap_get_chan_by_scid(conn, dcid);
> 	if (!chan)
> -		return -ENOENT;
> +		return -EFAULT;

do we really want to use EFAULT. That is normally only used if a memory copy from userspace to kernel or vice versa fails.

Regards

Marcel

