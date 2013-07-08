Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH 1/2] bluetooth: Pass HCI LE connection parameters
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1372980303-3007-2-git-send-email-kyle@kylemanna.com>
Date: Mon, 8 Jul 2013 11:59:45 -0700
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <9358E087-B127-4B60-B860-96F40C137815@holtmann.org>
References: <1372980303-3007-1-git-send-email-kyle@kylemanna.com> <1372980303-3007-2-git-send-email-kyle@kylemanna.com>
To: Kyle Manna <kyle@kylemanna.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kyle,

for future patches, please restrict this to linux-bluetooth only. There is no need to send them to netdev or linux-kernel.

> * Move hard coded values in hci_le_create_connection() for Bluetooth
>  LE connections to the channel defaults so that they can be overriden
>  by a patch to follow.
> * Add an argument to hci_connect() so that special connections
>  can pass additional connection parameters.  Update existing
>  function calls to pass NULL and not change the functionality.
> 
> Signed-off-by: Kyle Manna <kyle@kylemanna.com>
> ---
> include/net/bluetooth/hci_core.h |  5 +++--
> include/net/bluetooth/l2cap.h    |  2 ++
> net/bluetooth/hci_conn.c         | 33 ++++++++++++++-------------------
> net/bluetooth/l2cap_core.c       | 13 +++++++++++--
> net/bluetooth/l2cap_sock.c       |  2 ++
> net/bluetooth/mgmt.c             |  4 ++--
> net/bluetooth/sco.c              |  2 +-
> 7 files changed, 35 insertions(+), 26 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 7cb6d36..5169ec6 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -591,8 +591,9 @@ void hci_chan_del(struct hci_chan *chan);
> void hci_chan_list_flush(struct hci_conn *conn);
> struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
> 
> -struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
> -			     __u8 dst_type, __u8 sec_level, __u8 auth_type);
> +struct hci_conn *hci_connect(struct hci_dev *hdev, int type, void *cp,
> +			     bdaddr_t *dst, __u8 dst_type,
> +			     __u8 sec_level, __u8 auth_type);

What is this void *cp for. Having a random void for command parameters is not a good idea.

> int hci_conn_check_link_mode(struct hci_conn *conn);
> int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
> int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index fb94cf1..7ebbf56 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -438,6 +438,8 @@ struct l2cap_chan {
> 	struct l2cap_conn	*conn;
> 	struct hci_conn		*hs_hcon;
> 	struct hci_chan		*hs_hchan;
> +	struct hci_cp_le_create_conn cp_le;
> +

We do not intermix HCI wire structures with our internal channel structs.

> 	struct kref	kref;
> 
> 	__u8		state;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 6c7f363..9894e2b 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -31,28 +31,20 @@
> #include <net/bluetooth/a2mp.h>
> #include <net/bluetooth/smp.h>
> 
> -static void hci_le_create_connection(struct hci_conn *conn)
> +static void hci_le_create_connection(struct hci_conn *conn,
> +				     struct hci_cp_le_create_conn *cp)
> {

Please don't use wire command structures as input.

> 	struct hci_dev *hdev = conn->hdev;
> -	struct hci_cp_le_create_conn cp;
> 
> 	conn->state = BT_CONNECT;
> 	conn->out = true;
> 	conn->link_mode |= HCI_LM_MASTER;
> 	conn->sec_level = BT_SECURITY_LOW;
> 
> -	memset(&cp, 0, sizeof(cp));
> -	cp.scan_interval = __constant_cpu_to_le16(0x0060);
> -	cp.scan_window = __constant_cpu_to_le16(0x0030);
> -	bacpy(&cp.peer_addr, &conn->dst);
> -	cp.peer_addr_type = conn->dst_type;
> -	cp.conn_interval_min = __constant_cpu_to_le16(0x0028);
> -	cp.conn_interval_max = __constant_cpu_to_le16(0x0038);
> -	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
> -	cp.min_ce_len = __constant_cpu_to_le16(0x0000);
> -	cp.max_ce_len = __constant_cpu_to_le16(0x0000);
> -
> -	hci_send_cmd(hdev, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
> +	bacpy(&cp->peer_addr, &conn->dst);
> +	cp->peer_addr_type = conn->dst_type;
> +
> +	hci_send_cmd(hdev, HCI_OP_LE_CREATE_CONN, sizeof(*cp), cp);
> }

You are just pushing all the details of calling this to some other location. That is not what we want in this code base.

> 
> static void hci_le_create_connection_cancel(struct hci_conn *conn)
> @@ -507,7 +499,8 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
> EXPORT_SYMBOL(hci_get_route);
> 
> static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> -				    u8 dst_type, u8 sec_level, u8 auth_type)
> +				       u8 dst_type, u8 sec_level, u8 auth_type,
> +				       struct hci_cp_le_create_conn *cp)
> {
> 	struct hci_conn *le;
> 
> @@ -525,7 +518,7 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> 			return ERR_PTR(-ENOMEM);
> 
> 		le->dst_type = bdaddr_to_le(dst_type);
> -		hci_le_create_connection(le);
> +		hci_le_create_connection(le, cp);
> 	}
> 
> 	le->pending_sec_level = sec_level;
> @@ -602,14 +595,16 @@ static struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
> }
> 
> /* Create SCO, ACL or LE connection. */
> -struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
> -			     __u8 dst_type, __u8 sec_level, __u8 auth_type)
> +struct hci_conn *hci_connect(struct hci_dev *hdev, int type, void *cp,
> +			     bdaddr_t *dst, __u8 dst_type,
> +			     __u8 sec_level, __u8 auth_type)
> {
> 	BT_DBG("%s dst %pMR type 0x%x", hdev->name, dst, type);
> 
> 	switch (type) {
> 	case LE_LINK:
> -		return hci_connect_le(hdev, dst, dst_type, sec_level, auth_type);
> +		return hci_connect_le(hdev, dst, dst_type, sec_level,
> +				      auth_type, cp);
> 	case ACL_LINK:
> 		return hci_connect_acl(hdev, dst, sec_level, auth_type);
> 	case SCO_LINK:
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 68843a2..58d66e2 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -487,6 +487,15 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan)
> 	chan->ack_win = L2CAP_DEFAULT_TX_WINDOW;
> 	chan->sec_level = BT_SECURITY_LOW;
> 
> +	/* Set default LE connection parameters */
> +	chan->cp_le.scan_interval = __constant_cpu_to_le16(0x0060);
> +	chan->cp_le.scan_window = __constant_cpu_to_le16(0x0030);
> +	chan->cp_le.conn_interval_min = __constant_cpu_to_le16(0x0028);
> +	chan->cp_le.conn_interval_max = __constant_cpu_to_le16(0x0038);
> +	chan->cp_le.supervision_timeout = __constant_cpu_to_le16(0x002a);
> +	chan->cp_le.min_ce_len = __constant_cpu_to_le16(0x0000);
> +	chan->cp_le.max_ce_len = __constant_cpu_to_le16(0x0000);
> +
> 	set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
> }

This results in a lot of copy around of parameters. I do not like this idea at all.

> 
> @@ -1793,10 +1802,10 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
> 	auth_type = l2cap_get_auth_type(chan);
> 
> 	if (chan->dcid == L2CAP_CID_LE_DATA)
> -		hcon = hci_connect(hdev, LE_LINK, dst, dst_type,
> +		hcon = hci_connect(hdev, LE_LINK, &chan->cp_le, dst, dst_type,
> 				   chan->sec_level, auth_type);
> 	else
> -		hcon = hci_connect(hdev, ACL_LINK, dst, dst_type,
> +		hcon = hci_connect(hdev, ACL_LINK, NULL, dst, dst_type,
> 				   chan->sec_level, auth_type);
> 
> 	if (IS_ERR(hcon)) {
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 36fed40..2c7917e 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1154,6 +1154,8 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
> 		chan->sec_level = pchan->sec_level;
> 		chan->flags = pchan->flags;
> 
> +		memcpy(&chan->cp_le, &pchan->cp_le, sizeof(chan->cp_le));
> +
> 		security_sk_clone(parent, sk);
> 	} else {
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index f8ecbc7..ea9aa22 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2205,10 +2205,10 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
> 		auth_type = HCI_AT_DEDICATED_BONDING_MITM;
> 
> 	if (cp->addr.type == BDADDR_BREDR)
> -		conn = hci_connect(hdev, ACL_LINK, &cp->addr.bdaddr,
> +		conn = hci_connect(hdev, ACL_LINK, NULL, &cp->addr.bdaddr,
> 				   cp->addr.type, sec_level, auth_type);
> 	else
> -		conn = hci_connect(hdev, LE_LINK, &cp->addr.bdaddr,
> +		conn = hci_connect(hdev, LE_LINK, NULL, &cp->addr.bdaddr,
> 				   cp->addr.type, sec_level, auth_type);

I do not see a single NULL check for cp anywhere. This makes me wonder if any of this code has been tested at all with BR/EDR connections.

> 
> 	if (IS_ERR(conn)) {
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index e7bd4ee..5ea8a22 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -176,7 +176,7 @@ static int sco_connect(struct sock *sk)
> 	else
> 		type = SCO_LINK;
> 
> -	hcon = hci_connect(hdev, type, dst, BDADDR_BREDR, BT_SECURITY_LOW,
> +	hcon = hci_connect(hdev, type, NULL, dst, BDADDR_BREDR, BT_SECURITY_LOW,
> 			   HCI_AT_NO_BONDING);
> 	if (IS_ERR(hcon)) {
> 		err = PTR_ERR(hcon);

Regards

Marcel

