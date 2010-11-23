Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Nov 2010 20:52:37 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Ville Tervo <ville.tervo@nokia.com>
Subject: Re: [RFC 09/20] Bluetooth: Fix locking balance in
 l2cap_le_conn_ready
Message-ID: <20101123225237.GB11860@vigoh>
References: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
 <1290524796-32246-10-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290524796-32246-10-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2010-11-23 12:06:25 -0300]:

> From: Ville Tervo <ville.tervo@nokia.com>
> 
> Don't try to unlock sock if the lock was not held.
> 
> Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> ---
>  net/bluetooth/l2cap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 5894662..172bf93 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -1441,7 +1441,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
>  	parent = l2cap_get_sock_by_cid(BT_LISTEN, L2CAP_CID_LE_DATA,
>  					conn->src);
>  	if (!parent)
> -		goto clean;
> +		return;

Why not merging this into patch 5/20?

-- 
Gustavo F. Padovan
http://profusion.mobi
