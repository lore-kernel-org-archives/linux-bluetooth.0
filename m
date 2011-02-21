Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Feb 2011 17:59:32 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: anderson.briglia@openbossa.org
Cc: linux-bluetooth@vger.kernel.org,
	Ville Tervo <ville.tervo@nokia.com>
Subject: Re: [PATCH 2/2] Bluetooth: Use ERR_PTR as return error from
 hci_connect
Message-ID: <20110221205931.GF2965@joana>
References: <y>
 <4d62aa7a.47f3d80a.5ea1.ffffd992@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4d62aa7a.47f3d80a.5ea1.ffffd992@mx.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

* anderson.briglia@openbossa.org <anderson.briglia@openbossa.org> [2011-02-21 15:09:24 -0300]:

> From: Ville Tervo <ville.tervo@nokia.com>
> 
> Use ERR_PRT mechanism to return error from hci_connect.
> 
> Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c   |    8 ++++----
>  net/bluetooth/l2cap_core.c |   10 ++++------
>  net/bluetooth/sco.c        |    6 +++---
>  3 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index d401775..06af539 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -430,10 +430,10 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
>  	if (type == LE_LINK) {
>  		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
>  		if (le)
> -			return NULL;
> +			return ERR_PTR(-EBUSY);
>  		le = hci_conn_add(hdev, LE_LINK, dst);
>  		if (!le)
> -			return NULL;
> +			return ERR_PTR(-ENOMEM);
>  		if (le->state == BT_OPEN)
>  			hci_le_connect(le);
>  
> @@ -445,8 +445,8 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
>  	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
>  	if (!acl) {
>  		acl = hci_conn_add(hdev, ACL_LINK, dst);
> -		if (!acl)
> -			return NULL;
> +		if (IS_ERR(acl))
> +			return acl;

hci_conn_add() doesn't use the ERR_PTR magic.


-- 
Gustavo F. Padovan
http://profusion.mobi
