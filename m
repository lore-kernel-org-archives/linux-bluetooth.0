Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 2/3] Bluetooth: Fix responding to invalid L2CAP signaling commands
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379061827-8595-3-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 13 Sep 2013 18:42:12 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <56BC5629-3745-4561-90CA-7BB66D52E205@holtmann.org>
References: <1379061827-8595-1-git-send-email-johan.hedberg@gmail.com> <1379061827-8595-3-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we have an LE link we should not respond to any data on the BR/EDR
> L2CAP signaling channel (0x0001) and vice-versa when we have a BR/EDR
> link we should not respond to LE L2CAP (CID 0x0005) signaling commands.
> This patch fixes this issue by checking for a valid link type and
> ignores data if it is wrong.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 8 ++++++++
> 1 file changed, 8 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ea3792f..1d03644 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5297,6 +5297,7 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
> static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
> 					struct sk_buff *skb)
> {
> +	struct hci_conn *hcon = conn->hcon;
> 	u8 *data = skb->data;
> 	int len = skb->len;
> 	struct l2cap_cmd_hdr cmd;
> @@ -5304,6 +5305,9 @@ static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
> 
> 	l2cap_raw_recv(conn, skb);
> 
> +	if (hcon->type != LE_LINK)
> +		return;
> +

However I do have a question here. Can we just drop the packet or should we even in this case return invalid CID. What does the core spec. recommend in this case?

Regards

Marcel

