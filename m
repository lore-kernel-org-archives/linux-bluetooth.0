Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACECC4332B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 08:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFEB20786
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 08:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgCXIrK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 04:47:10 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35838 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgCXIrJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 04:47:09 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 182BBCED07;
        Tue, 24 Mar 2020 09:56:40 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v5 2/3] Bluetooth: L2CAP: Use DEFER_SETUP to group ECRED
 connections
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200323203458.24733-3-luiz.dentz@gmail.com>
Date:   Tue, 24 Mar 2020 09:47:08 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8BD7396B-9BEA-48DA-92A6-4863B72EBEEB@holtmann.org>
References: <20200323203458.24733-1-luiz.dentz@gmail.com>
 <20200323203458.24733-3-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This uses the DEFER_SETUP flag to group channels with
> L2CAP_CREDIT_BASED_CONNECTION_REQ.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/l2cap.h |   4 +
> net/bluetooth/l2cap_core.c    | 136 +++++++++++++++++++++++++++++++---
> 2 files changed, 130 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 2d7d28474d34..dada14d0622c 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -47,6 +47,7 @@
> #define L2CAP_DEFAULT_ACC_LAT		0xFFFFFFFF
> #define L2CAP_BREDR_MAX_PAYLOAD		1019    /* 3-DH5 packet */
> #define L2CAP_LE_MIN_MTU		23
> +#define L2CAP_ECRED_CONN_SCID_MAX	5
> 
> #define L2CAP_DISC_TIMEOUT		msecs_to_jiffies(100)
> #define L2CAP_DISC_REJ_TIMEOUT		msecs_to_jiffies(5000)
> @@ -984,6 +985,9 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan);
> int l2cap_ertm_init(struct l2cap_chan *chan);
> void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
> void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
> +typedef void (*l2cap_chan_func_t)(struct l2cap_chan *chan, void *data);
> +void l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
> +		     void *data);
> void l2cap_chan_del(struct l2cap_chan *chan, int err);
> void l2cap_send_conn_req(struct l2cap_chan *chan);
> void l2cap_move_start(struct l2cap_chan *chan);
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 5e6e35ab44dd..9f699d09d973 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -678,6 +678,29 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
> }
> EXPORT_SYMBOL_GPL(l2cap_chan_del);
> 
> +static void __l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
> +			      void *data)
> +{
> +	struct l2cap_chan *chan;
> +
> +	list_for_each_entry(chan, &conn->chan_l, list) {
> +		func(chan, data);
> +	}
> +}
> +
> +void l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
> +		     void *data)
> +{
> +	if (!conn)
> +		return;
> +
> +	mutex_lock(&conn->chan_lock);
> +	__l2cap_chan_list(conn, func, data);
> +	mutex_unlock(&conn->chan_lock);
> +}
> +
> +EXPORT_SYMBOL_GPL(l2cap_chan_list);
> +
> static void l2cap_conn_update_id_addr(struct work_struct *work)
> {
> 	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
> @@ -1356,29 +1379,79 @@ static void l2cap_le_connect(struct l2cap_chan *chan)
> 		       sizeof(req), &req);
> }
> 
> -static void l2cap_ecred_connect(struct l2cap_chan *chan)
> -{
> -	struct l2cap_conn *conn = chan->conn;
> +struct l2cap_ecred_conn_data {
> 	struct {
> 		struct l2cap_ecred_conn_req req;
> -		__le16 scid;
> +		__le16 scid[5];
> 	} __packed pdu;
> +	struct l2cap_chan *chan;
> +	struct pid *pid;
> +	int count;
> +};
> +
> +static void l2cap_ecred_defer_connect(struct l2cap_chan *chan, void *data)
> +{
> +	struct l2cap_ecred_conn_data *conn = data;
> +	struct pid *pid;
> +
> +	if (chan == conn->chan)
> +		return;
> +
> +	if (!test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
> +		return;
> +
> +	pid = chan->ops->get_peer_pid(chan);
> +
> +	/* Only add deferred channels with the same PID/PSM */
> +	if (conn->pid != pid || chan->psm != conn->chan->psm || chan->ident ||
> +	    chan->mode != L2CAP_MODE_EXT_FLOWCTL || chan->state != BT_CONNECT)
> +		return;
> +
> +	if (test_and_set_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
> +		return;
> +
> +	l2cap_ecred_init(chan, 0);
> +
> +	/* Set the same ident so we can match on the rsp */
> +	chan->ident = conn->chan->ident;
> +
> +	/* Include all channels deferred */
> +	conn->pdu.scid[conn->count] = cpu_to_le16(chan->scid);
> +
> +	conn->count++;
> +}
> +
> +static void l2cap_ecred_connect(struct l2cap_chan *chan)
> +{
> +	struct l2cap_conn *conn = chan->conn;
> +	struct l2cap_ecred_conn_data data;
> +
> +	if (test_bit(FLAG_DEFER_SETUP, &chan->flags))
> +		return;
> 
> 	if (test_and_set_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
> 		return;
> 
> 	l2cap_ecred_init(chan, 0);
> 
> -	pdu.req.psm     = chan->psm;
> -	pdu.req.mtu     = cpu_to_le16(chan->imtu);
> -	pdu.req.mps     = cpu_to_le16(chan->mps);
> -	pdu.req.credits = cpu_to_le16(chan->rx_credits);
> -	pdu.scid        = cpu_to_le16(chan->scid);
> +	data.pdu.req.psm     = chan->psm;
> +	data.pdu.req.mtu     = cpu_to_le16(chan->imtu);
> +	data.pdu.req.mps     = cpu_to_le16(chan->mps);
> +	data.pdu.req.credits = cpu_to_le16(chan->rx_credits);
> +	data.pdu.scid[0]     = cpu_to_le16(chan->scid);
> 
> 	chan->ident = l2cap_get_ident(conn);
> +	data.pid = chan->ops->get_peer_pid(chan);
> +
> +	data.count = 1;
> +	data.chan = chan;
> +	data.pid = chan->ops->get_peer_pid(chan);
> +
> +	__l2cap_chan_list(conn, l2cap_ecred_defer_connect, &data);
> 
> 	l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_CONN_REQ,
> -		       sizeof(pdu), &pdu);
> +		       sizeof(data.pdu.req) + data.count * sizeof(__le16),
> +		       &data.pdu);
> }
> 
> static void l2cap_le_start(struct l2cap_chan *chan)
> @@ -7694,6 +7767,33 @@ static bool is_valid_psm(u16 psm, u8 dst_type) {
> 	return ((psm & 0x0101) == 0x0001);
> }
> 
> +struct l2cap_chan_data {
> +	struct l2cap_chan *chan;
> +	struct pid *pid;
> +	int count;
> +};
> +
> +static void l2cap_chan_by_pid(struct l2cap_chan *chan, void *data)
> +{
> +	struct l2cap_chan_data *d = data;
> +	struct pid *pid;
> +
> +	if (chan == d->chan)
> +		return;
> +
> +	if (!test_bit(FLAG_DEFER_SETUP, &chan->flags))
> +		return;
> +
> +	pid = chan->ops->get_peer_pid(chan);
> +
> +	/* Only count deferred channels with the same PID/PSM */
> +	if (d->pid != pid || chan->psm != d->chan->psm || chan->ident ||
> +	    chan->mode != L2CAP_MODE_EXT_FLOWCTL || chan->state != BT_CONNECT)
> +		return;
> +
> +	d->count++;
> +}
> +
> int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
> 		       bdaddr_t *dst, u8 dst_type)
> {
> @@ -7813,6 +7913,22 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
> 		goto done;
> 	}
> 
> +	if (chan->mode == L2CAP_MODE_EXT_FLOWCTL) {
> +		struct l2cap_chan_data data;
> +
> +		data.chan = chan;
> +		data.pid = chan->ops->get_peer_pid(chan);
> +		data.count = 0;
> +
> +		l2cap_chan_list(conn, l2cap_chan_by_pid, &data);

Put an empty line after this. It gives emphasis to the comment.

> +		/* Check if there isn't too many channels being connected */
> +		if (!(data.count < L2CAP_ECRED_CONN_SCID_MAX - 1)) {

If (data.count > L2CAP_ECRED_CONN_SCID_MIX) ???

> +			hci_conn_drop(hcon);
> +			err = -EPROTO;
> +			goto done;
> +		}
> +	}
> +
> 	mutex_lock(&conn->chan_lock);
> 	l2cap_chan_lock(chan);

Regards

Marcel

