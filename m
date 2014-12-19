Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [RFC v2] Bluetooth: 6lowpan: Use new network management channel to connect/disconnect
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418990482-27038-1-git-send-email-jukka.rissanen@linux.intel.com>
Date: Fri, 19 Dec 2014 13:35:29 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <69F6A745-6E53-4C82-866A-B3AB3973AC3F@holtmann.org>
References: <1418990482-27038-1-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> Use new HCI_CHANNEL_NETWORK management channel which is used by user
> space to connect and disconnect a 6lowpan connection.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> Hi,
> 
> this is another proposal using a new HCI_CHANNEL_NETWORK channel.
> The code compiles ok but is probably not useful yet. Anyway,
> sending this to get feedback.
> 
> Marcel, is this something similar you had in mind?
> 
> Cheers,
> Jukka
> 
> 
> include/net/bluetooth/hci_core.h |   3 +
> include/net/bluetooth/hci_sock.h |   1 +
> include/net/bluetooth/mgmt.h     |  15 ++
> net/bluetooth/6lowpan.c          |   4 +-
> net/bluetooth/6lowpan.h          |  18 +++
> net/bluetooth/Makefile           |   2 +-
> net/bluetooth/hci_core.c         |   1 +
> net/bluetooth/hci_sock.c         |  41 +++++
> net/bluetooth/mgmt-utils.h       |  95 +++++++++++
> net/bluetooth/mgmt.c             |  88 +----------
> net/bluetooth/network.c          | 331 +++++++++++++++++++++++++++++++++++++++
> 11 files changed, 513 insertions(+), 86 deletions(-)
> create mode 100644 net/bluetooth/6lowpan.h
> create mode 100644 net/bluetooth/mgmt-utils.h
> create mode 100644 net/bluetooth/network.c
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 3c78270..d642bc0 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1323,6 +1323,7 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
> /* ----- HCI Sockets ----- */
> void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
> void hci_send_to_control(struct sk_buff *skb, struct sock *skip_sk);
> +void hci_send_to_network(struct sk_buff *skb, struct sock *skip_sk);
> void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb);
> 
> void hci_sock_dev_event(struct hci_dev *hdev, int event);
> @@ -1412,6 +1413,8 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
> void mgmt_reenable_advertising(struct hci_dev *hdev);
> void mgmt_smp_complete(struct hci_conn *conn, bool complete);
> 
> +int network_channel(struct sock *sk, struct msghdr *msg, size_t msglen);
> +
> u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
> 		      u16 to_multiplier);
> void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
> diff --git a/include/net/bluetooth/hci_sock.h b/include/net/bluetooth/hci_sock.h
> index 9a46d66..403c358 100644
> --- a/include/net/bluetooth/hci_sock.h
> +++ b/include/net/bluetooth/hci_sock.h
> @@ -45,6 +45,7 @@ struct sockaddr_hci {
> #define HCI_CHANNEL_USER	1
> #define HCI_CHANNEL_MONITOR	2
> #define HCI_CHANNEL_CONTROL	3
> +#define HCI_CHANNEL_NETWORK	4
> 
> struct hci_filter {
> 	unsigned long type_mask;
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 95c34d5..ae69822 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -507,6 +507,14 @@ struct mgmt_cp_start_service_discovery {
> } __packed;
> #define MGMT_START_SERVICE_DISCOVERY_SIZE 4
> 
> +#define MGMT_OP_6LOWPAN_CONNECT		0x003B
> +#define MGMT_OP_6LOWPAN_DISCONNECT	0x003C
> +struct mgmt_cp_6lowpan_info {
> +	uint8_t addr_type;
> +	bdaddr_t bdaddr;
> +} __packed;
> +#define MGMT_6LOWPAN_INFO_SIZE		7
> +
> #define MGMT_EV_CMD_COMPLETE		0x0001
> struct mgmt_ev_cmd_complete {
> 	__le16	opcode;
> @@ -689,3 +697,10 @@ struct mgmt_ev_new_conn_param {
> #define MGMT_EV_UNCONF_INDEX_REMOVED	0x001e
> 
> #define MGMT_EV_NEW_CONFIG_OPTIONS	0x001f
> +
> +#define MGMT_EV_6LOWPAN_CONNECTED	0x0020
> +#define MGMT_EV_6LOWPAN_DISCONNECTED	0x0021
> +struct mgmt_ev_6lowpan_conn_param {
> +	struct mgmt_addr_info addr;
> +	uint32_t ifindex;
> +} __packed;

I think that networking related stuff might just get its own namespace. This is not a fully baked idea yet and thus something to explore.

> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 76617be..9589d98 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -1077,7 +1077,7 @@ static struct l2cap_chan *chan_get(void)
> 	return pchan;
> }
> 
> -static int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type)
> +int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type)
> {
> 	struct l2cap_chan *pchan;
> 	int err;
> @@ -1096,7 +1096,7 @@ static int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type)
> 	return err;
> }
> 
> -static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
> +int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
> {
> 	struct lowpan_peer *peer;
> 
> diff --git a/net/bluetooth/6lowpan.h b/net/bluetooth/6lowpan.h
> new file mode 100644
> index 0000000..ec233c6
> --- /dev/null
> +++ b/net/bluetooth/6lowpan.h
> @@ -0,0 +1,18 @@
> +/*
> +   Copyright (c) 2014 Intel Corp.
> +
> +   This program is free software; you can redistribute it and/or modify
> +   it under the terms of the GNU General Public License version 2 and
> +   only version 2 as published by the Free Software Foundation.
> +
> +   This program is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +   GNU General Public License for more details.
> +*/
> +
> +int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type);
> +int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type);
> +
> +void network_6lowpan_send_event(struct hci_dev *hdev, struct hci_conn *conn,
> +				u8 event_type, uint32_t ifindex);
> diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
> index a5432a6..1f2a115 100644
> --- a/net/bluetooth/Makefile
> +++ b/net/bluetooth/Makefile
> @@ -9,7 +9,7 @@ obj-$(CONFIG_BT_CMTP)	+= cmtp/
> obj-$(CONFIG_BT_HIDP)	+= hidp/
> obj-$(CONFIG_BT_6LOWPAN) += bluetooth_6lowpan.o
> 
> -bluetooth_6lowpan-y := 6lowpan.o
> +bluetooth_6lowpan-y := 6lowpan.o network.o
> 
> bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
> 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 5dcacf9..85b5b33 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2042,6 +2042,7 @@ struct hci_dev *hci_dev_get(int index)
> 	read_unlock(&hci_dev_list_lock);
> 	return hdev;
> }
> +EXPORT_SYMBOL_GPL(hci_dev_get);
> 
> /* ---- Inquiry support ---- */
> 
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 2c245fd..12e727d 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -216,6 +216,40 @@ void hci_send_to_control(struct sk_buff *skb, struct sock *skip_sk)
> 	read_unlock(&hci_sk_list.lock);
> }
> 
> +/* Send frame to network socket */
> +void hci_send_to_network(struct sk_buff *skb, struct sock *skip_sk)
> +{
> +	struct sock *sk;
> +
> +	BT_DBG("len %d", skb->len);
> +
> +	read_lock(&hci_sk_list.lock);
> +
> +	sk_for_each(sk, &hci_sk_list.head) {
> +		struct sk_buff *nskb;
> +
> +		/* Skip the original socket */
> +		if (sk == skip_sk)
> +			continue;
> +
> +		if (sk->sk_state != BT_BOUND)
> +			continue;
> +
> +		if (hci_pi(sk)->channel != HCI_CHANNEL_NETWORK)
> +			continue;
> +
> +		nskb = skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			continue;
> +
> +		if (sock_queue_rcv_skb(sk, nskb))
> +			kfree_skb(nskb);
> +	}
> +
> +	read_unlock(&hci_sk_list.lock);
> +}
> +EXPORT_SYMBOL_GPL(hci_send_to_network);
> +

If we go that route route then it needs to be more in the direction of the bluetooth_6lowpan or maybe in the future bluetooth_network module registers with core to acquire a specific channel. And we also want to use module auto-loading as soon as someone bind to that socket.

> /* Send frame to monitor socket */
> void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
> {
> @@ -927,6 +961,13 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
> 	case HCI_CHANNEL_MONITOR:
> 		err = -EOPNOTSUPP;
> 		goto done;
> +	case HCI_CHANNEL_NETWORK:
> +#ifdef CONFIG_BT_6LOWPAN
> +		err = network_channel(sk, msg, len);
> +#else
> +		err = -EOPNOTSUPP;
> +#endif
> +		goto done;
> 	default:
> 		err = -EINVAL;
> 		goto done;
> diff --git a/net/bluetooth/mgmt-utils.h b/net/bluetooth/mgmt-utils.h

We use _ in filenames and that should be kept. Also this might be better named mgmt_core.h or mgmt_common.h. And of course needs to come as a separate patch in the first place if this is the way we want to go.

> new file mode 100644
> index 0000000..42c5aa0
> --- /dev/null
> +++ b/net/bluetooth/mgmt-utils.h
> @@ -0,0 +1,95 @@
> +/*
> +   Copyright (c) 2014 Intel Corp.
> +
> +   This program is free software; you can redistribute it and/or modify
> +   it under the terms of the GNU General Public License version 2 and
> +   only version 2 as published by the Free Software Foundation.
> +
> +   This program is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +   GNU General Public License for more details.
> +*/
> +
> +static inline int cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
> +{
> +	struct sk_buff *skb;
> +	struct mgmt_hdr *hdr;
> +	struct mgmt_ev_cmd_status *ev;
> +	int err;
> +
> +	BT_DBG("sock %p, index %u, cmd %u, status %u", sk, index, cmd, status);
> +
> +	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev), GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	hdr = (void *) skb_put(skb, sizeof(*hdr));
> +
> +	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_STATUS);
> +	hdr->index = cpu_to_le16(index);
> +	hdr->len = cpu_to_le16(sizeof(*ev));
> +
> +	ev = (void *) skb_put(skb, sizeof(*ev));
> +	ev->status = status;
> +	ev->opcode = cpu_to_le16(cmd);
> +
> +	err = sock_queue_rcv_skb(sk, skb);
> +	if (err < 0)
> +		kfree_skb(skb);
> +
> +	return err;
> +}
> +
> +static inline int cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
> +			       void *rp, size_t rp_len)
> +{
> +	struct sk_buff *skb;
> +	struct mgmt_hdr *hdr;
> +	struct mgmt_ev_cmd_complete *ev;
> +	int err;
> +
> +	BT_DBG("sock %p", sk);
> +
> +	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev) + rp_len, GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	hdr = (void *) skb_put(skb, sizeof(*hdr));
> +
> +	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_COMPLETE);
> +	hdr->index = cpu_to_le16(index);
> +	hdr->len = cpu_to_le16(sizeof(*ev) + rp_len);
> +
> +	ev = (void *) skb_put(skb, sizeof(*ev) + rp_len);
> +	ev->opcode = cpu_to_le16(cmd);
> +	ev->status = status;
> +
> +	if (rp)
> +		memcpy(ev->data, rp, rp_len);
> +
> +	err = sock_queue_rcv_skb(sk, skb);
> +	if (err < 0)
> +		kfree_skb(skb);
> +
> +	return err;
> +}
> +
> +static inline u8 link_to_bdaddr(u8 link_type, u8 addr_type)
> +{
> +	switch (link_type) {
> +	case LE_LINK:
> +		switch (addr_type) {
> +		case ADDR_LE_DEV_PUBLIC:
> +			return BDADDR_LE_PUBLIC;
> +
> +		default:
> +			/* Fallback to LE Random address type */
> +			return BDADDR_LE_RANDOM;
> +		}
> +
> +	default:
> +		/* Fallback to BR/EDR type */
> +		return BDADDR_BREDR;
> +	}
> +}
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 693ce8b..dcbeb96 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -33,6 +33,7 @@
> #include <net/bluetooth/mgmt.h>
> 
> #include "smp.h"
> +#include "mgmt-utils.h"
> 
> #define MGMT_VERSION	1
> #define MGMT_REVISION	8
> @@ -244,70 +245,6 @@ static int mgmt_event(u16 event, struct hci_dev *hdev, void *data, u16 data_len,
> 	return 0;
> }
> 
> -static int cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
> -{
> -	struct sk_buff *skb;
> -	struct mgmt_hdr *hdr;
> -	struct mgmt_ev_cmd_status *ev;
> -	int err;
> -
> -	BT_DBG("sock %p, index %u, cmd %u, status %u", sk, index, cmd, status);
> -
> -	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev), GFP_KERNEL);
> -	if (!skb)
> -		return -ENOMEM;
> -
> -	hdr = (void *) skb_put(skb, sizeof(*hdr));
> -
> -	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_STATUS);
> -	hdr->index = cpu_to_le16(index);
> -	hdr->len = cpu_to_le16(sizeof(*ev));
> -
> -	ev = (void *) skb_put(skb, sizeof(*ev));
> -	ev->status = status;
> -	ev->opcode = cpu_to_le16(cmd);
> -
> -	err = sock_queue_rcv_skb(sk, skb);
> -	if (err < 0)
> -		kfree_skb(skb);
> -
> -	return err;
> -}
> -
> -static int cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
> -			void *rp, size_t rp_len)
> -{
> -	struct sk_buff *skb;
> -	struct mgmt_hdr *hdr;
> -	struct mgmt_ev_cmd_complete *ev;
> -	int err;
> -
> -	BT_DBG("sock %p", sk);
> -
> -	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev) + rp_len, GFP_KERNEL);
> -	if (!skb)
> -		return -ENOMEM;
> -
> -	hdr = (void *) skb_put(skb, sizeof(*hdr));
> -
> -	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_COMPLETE);
> -	hdr->index = cpu_to_le16(index);
> -	hdr->len = cpu_to_le16(sizeof(*ev) + rp_len);
> -
> -	ev = (void *) skb_put(skb, sizeof(*ev) + rp_len);
> -	ev->opcode = cpu_to_le16(cmd);
> -	ev->status = status;
> -
> -	if (rp)
> -		memcpy(ev->data, rp, rp_len);
> -
> -	err = sock_queue_rcv_skb(sk, skb);
> -	if (err < 0)
> -		kfree_skb(skb);
> -
> -	return err;
> -}
> -
> static int read_version(struct sock *sk, struct hci_dev *hdev, void *data,
> 			u16 data_len)
> {
> @@ -2898,25 +2835,6 @@ failed:
> 	return err;
> }
> 
> -static u8 link_to_bdaddr(u8 link_type, u8 addr_type)
> -{
> -	switch (link_type) {
> -	case LE_LINK:
> -		switch (addr_type) {
> -		case ADDR_LE_DEV_PUBLIC:
> -			return BDADDR_LE_PUBLIC;
> -
> -		default:
> -			/* Fallback to LE Random address type */
> -			return BDADDR_LE_RANDOM;
> -		}
> -
> -	default:
> -		/* Fallback to BR/EDR type */
> -		return BDADDR_BREDR;
> -	}
> -}
> -
> static int get_connections(struct sock *sk, struct hci_dev *hdev, void *data,
> 			   u16 data_len)
> {
> @@ -5892,6 +5810,10 @@ static const struct mgmt_handler {
> 	{ set_external_config,    false, MGMT_SET_EXTERNAL_CONFIG_SIZE },
> 	{ set_public_address,     false, MGMT_SET_PUBLIC_ADDRESS_SIZE },
> 	{ start_service_discovery,true,  MGMT_START_SERVICE_DISCOVERY_SIZE },
> +
> +	/* Next two 6LoWPAN operations are handled in network.c */
> +	{ NULL,                   false, MGMT_6LOWPAN_INFO_SIZE },
> +	{ NULL,                   false, MGMT_6LOWPAN_INFO_SIZE },
> };
> 
> int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
> diff --git a/net/bluetooth/network.c b/net/bluetooth/network.c
> new file mode 100644
> index 0000000..09ed244
> --- /dev/null
> +++ b/net/bluetooth/network.c
> @@ -0,0 +1,331 @@
> +/*
> +   Copyright (c) 2014 Intel Corp.
> +
> +   This program is free software; you can redistribute it and/or modify
> +   it under the terms of the GNU General Public License version 2 and
> +   only version 2 as published by the Free Software Foundation.
> +
> +   This program is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +   GNU General Public License for more details.
> +*/
> +
> +/* Bluetooth HCI Management interface for networking */
> +
> +#include <linux/module.h>
> +#include <asm/unaligned.h>
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +#include <net/bluetooth/l2cap.h>
> +#include <net/bluetooth/mgmt.h>
> +
> +#include "mgmt-utils.h"
> +#include "6lowpan.h"
> +
> +static int network_event(u16 event, struct hci_dev *hdev, void *data,
> +			 u16 data_len, struct sock *skip_sk)
> +{
> +	struct sk_buff *skb;
> +	struct mgmt_hdr *hdr;
> +
> +	skb = alloc_skb(sizeof(*hdr) + data_len, GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	hdr = (void *) skb_put(skb, sizeof(*hdr));
> +	hdr->opcode = cpu_to_le16(event);
> +	if (hdev)
> +		hdr->index = cpu_to_le16(hdev->id);
> +	else
> +		hdr->index = cpu_to_le16(MGMT_INDEX_NONE);
> +	hdr->len = cpu_to_le16(data_len);
> +
> +	if (data)
> +		memcpy(skb_put(skb, data_len), data, data_len);
> +
> +	/* Time stamp */
> +	__net_timestamp(skb);
> +
> +	hci_send_to_network(skb, skip_sk);
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +
> +void network_6lowpan_send_event(struct hci_dev *hdev, struct hci_conn *conn,
> +				u8 event_type, uint32_t ifindex)
> +{
> +	struct mgmt_ev_6lowpan_conn_param ev;
> +
> +	BT_DBG("%s 6lowpan %s", hdev->name,
> +	       event_type == MGMT_EV_6LOWPAN_CONNECTED ? "connected" :
> +							 "disconnected");
> +
> +	bacpy(&ev.addr.bdaddr, &conn->dst);
> +	ev.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
> +	ev.ifindex = ifindex;
> +
> +	network_event(event_type, hdev, &ev, sizeof(ev), NULL);
> +}
> +
> +static int connect_6lowpan(struct sock *sk, struct hci_dev *hdev, void *data,
> +			   u16 len)
> +{
> +	struct mgmt_cp_6lowpan_info *cp = data;
> +	struct mgmt_cp_6lowpan_info rp;
> +	struct hci_conn *hcon;
> +	int err;
> +
> +	BT_DBG("");
> +
> +	memset(&rp, 0, sizeof(rp));
> +	bacpy(&rp.bdaddr, &cp->bdaddr);
> +	rp.addr_type = cp->addr_type;
> +
> +	if (!bdaddr_type_is_valid(cp->addr_type))
> +		return cmd_complete(sk, hdev->id, MGMT_OP_6LOWPAN_CONNECT,
> +				    MGMT_STATUS_INVALID_PARAMS, &rp,
> +				    sizeof(rp));
> +
> +	if (cp->addr_type == BDADDR_BREDR)
> +		return cmd_complete(sk, hdev->id, MGMT_OP_6LOWPAN_CONNECT,
> +				    MGMT_STATUS_NOT_SUPPORTED, &rp,
> +				    sizeof(rp));
> +
> +	hci_dev_lock(hdev);
> +
> +	hcon = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->bdaddr);
> +	if (!hcon) {
> +		err = cmd_complete(sk, hdev->id, MGMT_OP_6LOWPAN_CONNECT,
> +				   MGMT_STATUS_NO_RESOURCES, &rp,
> +				   sizeof(rp));
> +		goto failed;
> +	}
> +
> +	err = bt_6lowpan_connect(&cp->bdaddr, cp->addr_type);
> +
> +failed:
> +	hci_dev_unlock(hdev);
> +	return err;
> +}
> +
> +static int disconnect_6lowpan(struct sock *sk, struct hci_dev *hdev,
> +			      void *data, u16 len)
> +{
> +	struct mgmt_cp_6lowpan_info *cp = data;
> +	struct mgmt_cp_6lowpan_info rp;
> +	struct hci_conn *hcon;
> +	int err;
> +
> +	BT_DBG("");
> +
> +	memset(&rp, 0, sizeof(rp));
> +	bacpy(&rp.bdaddr, &cp->bdaddr);
> +	rp.addr_type = cp->addr_type;
> +
> +	if (!bdaddr_type_is_valid(cp->addr_type))
> +		return cmd_complete(sk, hdev->id, MGMT_OP_6LOWPAN_DISCONNECT,
> +				    MGMT_STATUS_INVALID_PARAMS, &rp,
> +				    sizeof(rp));
> +
> +	if (cp->addr_type == BDADDR_BREDR)
> +		return cmd_complete(sk, hdev->id, MGMT_OP_6LOWPAN_DISCONNECT,
> +				    MGMT_STATUS_NOT_SUPPORTED, &rp,
> +				    sizeof(rp));
> +
> +	hci_dev_lock(hdev);
> +
> +	hcon = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->bdaddr);
> +	if (!hcon) {
> +		err = cmd_complete(sk, hdev->id, MGMT_OP_6LOWPAN_DISCONNECT,
> +				   MGMT_STATUS_NOT_CONNECTED, &rp,
> +				   sizeof(rp));
> +		goto failed;
> +	}
> +
> +	err = bt_6lowpan_disconnect((struct l2cap_conn *)hcon->l2cap_data,
> +				    cp->addr_type);
> +
> +failed:
> +	hci_dev_unlock(hdev);
> +	return err;
> +}
> +
> +static const struct network_handler {
> +	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
> +		     u16 data_len);
> +	bool var_len;
> +	size_t data_len;
> +} network_handlers[] = {
> +	{ NULL }, /* 0x0000 (no command) */
> +
> +	/* The following NULL handlers are not used by this module */
> +	{ NULL,                   false, MGMT_READ_VERSION_SIZE },
> +	{ NULL,                   false, MGMT_READ_COMMANDS_SIZE },
> +	{ NULL,                   false, MGMT_READ_INDEX_LIST_SIZE },
> +	{ NULL,                   false, MGMT_READ_INFO_SIZE },
> +	{ NULL,                   false, MGMT_SETTING_SIZE },
> +	{ NULL,                   false, MGMT_SET_DISCOVERABLE_SIZE },
> +	{ NULL,                   false, MGMT_SETTING_SIZE },
> +	{ NULL,                   false, MGMT_SETTING_SIZE },
> +	{ NULL,                   false, MGMT_SETTING_SIZE },
> +	{ NULL,                   false, MGMT_SETTING_SIZE },
> +	{ NULL,                   false, MGMT_SETTING_SIZE },
> +	{ NULL,                   false, MGMT_SETTING_SIZE },
> +	{ NULL,                   false, MGMT_SETTING_SIZE },
> +	{ NULL,                   false, MGMT_SET_DEV_CLASS_SIZE },
> +	{ NULL,                   false, MGMT_SET_LOCAL_NAME_SIZE },
> +	{ NULL,                   false, MGMT_ADD_UUID_SIZE },
> +	{ NULL,                   false, MGMT_REMOVE_UUID_SIZE },
> +	{ NULL,                   true,  MGMT_LOAD_LINK_KEYS_SIZE },
> +	{ NULL,                   true,  MGMT_LOAD_LONG_TERM_KEYS_SIZE },
> +	{ NULL,                   false, MGMT_DISCONNECT_SIZE },
> +	{ NULL,                   false, MGMT_GET_CONNECTIONS_SIZE },
> +	{ NULL,                   false, MGMT_PIN_CODE_REPLY_SIZE },
> +	{ NULL,                   false, MGMT_PIN_CODE_NEG_REPLY_SIZE },
> +	{ NULL,                   false, MGMT_SET_IO_CAPABILITY_SIZE },
> +	{ NULL,                   false, MGMT_PAIR_DEVICE_SIZE },
> +	{ NULL,                   false, MGMT_CANCEL_PAIR_DEVICE_SIZE },
> +	{ NULL,                   false, MGMT_UNPAIR_DEVICE_SIZE },
> +	{ NULL,                   false, MGMT_USER_CONFIRM_REPLY_SIZE },
> +	{ NULL,                   false, MGMT_USER_CONFIRM_NEG_REPLY_SIZE },
> +	{ NULL,                   false, MGMT_USER_PASSKEY_REPLY_SIZE },
> +	{ NULL,                   false, MGMT_USER_PASSKEY_NEG_REPLY_SIZE },
> +	{ NULL,                   false, MGMT_READ_LOCAL_OOB_DATA_SIZE },
> +	{ NULL,                   true,  MGMT_ADD_REMOTE_OOB_DATA_SIZE },
> +	{ NULL,                   false, MGMT_REMOVE_REMOTE_OOB_DATA_SIZE },
> +	{ NULL,                   false, MGMT_START_DISCOVERY_SIZE },
> +	{ NULL,                   false, MGMT_STOP_DISCOVERY_SIZE },
> +	{ NULL,                   false, MGMT_CONFIRM_NAME_SIZE },
> +	{ NULL,                   false, MGMT_BLOCK_DEVICE_SIZE },
> +	{ NULL,                   false, MGMT_UNBLOCK_DEVICE_SIZE },
> +	{ NULL,                   false, MGMT_SET_DEVICE_ID_SIZE },
> +	{ NULL,                   false, MGMT_SETTING_SIZE },
> +	{ NULL,                   false, MGMT_SETTING_SIZE },
> +	{ NULL,                   false, MGMT_SET_STATIC_ADDRESS_SIZE },
> +	{ NULL,                   false, MGMT_SET_SCAN_PARAMS_SIZE },
> +	{ NULL,                   false, MGMT_SETTING_SIZE },
> +	{ NULL,                   false, MGMT_SETTING_SIZE },
> +	{ NULL,                   false, MGMT_SET_PRIVACY_SIZE },
> +	{ NULL,                   true,  MGMT_LOAD_IRKS_SIZE },
> +	{ NULL,                   false, MGMT_GET_CONN_INFO_SIZE },
> +	{ NULL,                   false, MGMT_GET_CLOCK_INFO_SIZE },
> +	{ NULL,                   false, MGMT_ADD_DEVICE_SIZE },
> +	{ NULL,                   false, MGMT_REMOVE_DEVICE_SIZE },
> +	{ NULL,                   true,  MGMT_LOAD_CONN_PARAM_SIZE },
> +	{ NULL,                   false, MGMT_READ_UNCONF_INDEX_LIST_SIZE },
> +	{ NULL,                   false, MGMT_READ_CONFIG_INFO_SIZE },
> +	{ NULL,                   false, MGMT_SET_EXTERNAL_CONFIG_SIZE },
> +	{ NULL,                   false, MGMT_SET_PUBLIC_ADDRESS_SIZE },
> +	{ NULL,                   true,  MGMT_START_SERVICE_DISCOVERY_SIZE },
> +
> +	{ connect_6lowpan,        false, MGMT_6LOWPAN_INFO_SIZE },
> +	{ disconnect_6lowpan,     false, MGMT_6LOWPAN_INFO_SIZE },
> +};

This is just plain horrible. There is no other word for it. And if we go this route of a new mgmt channel just for networking, then it will have its own namespace for opcodes. There will be no overlap.

Read version, read commands, read index list size will be the only ones that are common. Everything else will be unique to networking.

In addition, I really think having connect/disconnect functions for 6LoWPAN is not what we actually want long term. We want to allow adding/removing known 6LoWPAN devices. So that if we have to transmit a packet to a remote, we can scan for it. Once found, we connect, send the packet, and then eventually timeout and disconnect.

> +
> +int network_channel(struct sock *sk, struct msghdr *msg, size_t msglen)
> +{
> +	void *buf;
> +	u8 *cp;
> +	struct mgmt_hdr *hdr;
> +	u16 opcode, index, len;
> +	struct hci_dev *hdev = NULL;
> +	const struct network_handler *handler;
> +	int err;
> +
> +	BT_DBG("got %zu bytes", msglen);
> +
> +	if (msglen < sizeof(*hdr))
> +		return -EINVAL;
> +
> +	buf = kmalloc(msglen, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	if (memcpy_from_msg(buf, msg, msglen)) {
> +		err = -EFAULT;
> +		goto done;
> +	}
> +
> +	hdr = buf;
> +	opcode = __le16_to_cpu(hdr->opcode);
> +	index = __le16_to_cpu(hdr->index);
> +	len = __le16_to_cpu(hdr->len);
> +
> +	if (len != msglen - sizeof(*hdr)) {
> +		err = -EINVAL;
> +		goto done;
> +	}
> +
> +	if (index != MGMT_INDEX_NONE) {
> +		hdev = hci_dev_get(index);
> +		if (!hdev) {
> +			err = cmd_status(sk, index, opcode,
> +					 MGMT_STATUS_INVALID_INDEX);
> +			goto done;
> +		}
> +
> +		if (test_bit(HCI_SETUP, &hdev->dev_flags) ||
> +		    test_bit(HCI_CONFIG, &hdev->dev_flags) ||
> +		    test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
> +			err = cmd_status(sk, index, opcode,
> +					 MGMT_STATUS_INVALID_INDEX);
> +			goto done;
> +		}
> +
> +		if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
> +			err = cmd_status(sk, index, opcode,
> +					 MGMT_STATUS_INVALID_INDEX);
> +			goto done;
> +		}
> +	}
> +
> +	if (opcode >= ARRAY_SIZE(network_handlers) ||
> +	    network_handlers[opcode].func == NULL) {
> +		BT_DBG("Unknown op %u", opcode);
> +		err = cmd_status(sk, index, opcode,
> +				 MGMT_STATUS_UNKNOWN_COMMAND);
> +		goto done;
> +	}
> +
> +	if (hdev && (opcode <= MGMT_OP_READ_INDEX_LIST ||
> +		     opcode == MGMT_OP_READ_UNCONF_INDEX_LIST)) {
> +		err = cmd_status(sk, index, opcode,
> +				 MGMT_STATUS_INVALID_INDEX);
> +		goto done;
> +	}
> +
> +	if (!hdev && (opcode > MGMT_OP_READ_INDEX_LIST &&
> +		      opcode != MGMT_OP_READ_UNCONF_INDEX_LIST)) {
> +		err = cmd_status(sk, index, opcode,
> +				 MGMT_STATUS_INVALID_INDEX);
> +		goto done;
> +	}
> +
> +	handler = &network_handlers[opcode];
> +
> +	if ((handler->var_len && len < handler->data_len) ||
> +	    (!handler->var_len && len != handler->data_len)) {
> +		err = cmd_status(sk, index, opcode,
> +				 MGMT_STATUS_INVALID_PARAMS);
> +		goto done;
> +	}
> +
> +	cp = buf + sizeof(*hdr);
> +
> +	err = handler->func(sk, hdev, cp, len);
> +	if (err < 0)
> +		goto done;
> +
> +	err = msglen;
> +
> +done:
> +	if (hdev)
> +		hci_dev_put(hdev);
> +
> +	kfree(buf);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(network_channel);

I have no idea how bluetooth.ko can use a symbol from bluetooth_6lowpan.ko and then the other way around. That makes no sense module loading wise. Might work when build into the kernel, but not as modules.

That is why we need to go towards module auto-loading from the beginning. Otherwise we create a circular dependency for modules that can not be solved.

Regards

Marcel

