Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 May 2011 14:13:22 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 09/11] Bluetooth: Remove useless check in hci_connect()
Message-ID: <20110524111322.GG2480@null>
References: <1305936645-15007-1-git-send-email-andre.guedes@openbossa.org>
 <1305936645-15007-9-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305936645-15007-9-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Fri, May 20, 2011 at 09:10:43PM -0300, ext Andre Guedes wrote:
> There is no need to check the connection's state since hci_conn_add()
> has just created a new connection and its state has been set properly.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>

Yes this is useless check.

Acked-by: Ville Tervo <ville.tervo@nokia.com>

> ---
>  net/bluetooth/hci_conn.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 84ad32b..b21cbb3 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -457,8 +457,8 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
>  		le = hci_conn_add(hdev, LE_LINK, dst, 0);
>  		if (!le)
>  			return ERR_PTR(-ENOMEM);
> -		if (le->state == BT_OPEN)
> -			hci_le_connect(le);
> +
> +		hci_le_connect(le);
>  
>  		hci_conn_hold(le);
>  
> -- 
> 1.7.4.1

-- 
Ville
