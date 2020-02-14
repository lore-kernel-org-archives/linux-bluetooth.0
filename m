Return-Path: <SRS0=GIG2=4C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D89C2BA83
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Feb 2020 07:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04CF20675
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Feb 2020 07:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgBNHyx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:54:53 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55497 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbgBNHyx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Feb 2020 02:54:53 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 12453CECE1;
        Fri, 14 Feb 2020 09:04:15 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v3] Bluetooth: Add BT_PHY socket option
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200210225550.4248-1-luiz.dentz@gmail.com>
Date:   Fri, 14 Feb 2020 08:54:51 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7C5C3BE8-24AD-4A57-A95E-D3CFE668935B@holtmann.org>
References: <20200210225550.4248-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds BT_PHY socket option (read-only) which can be used to read
> the PHYs in use by the underline connection.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/bluetooth.h |  17 +++++
> include/net/bluetooth/hci_core.h  |   2 +
> net/bluetooth/hci_conn.c          | 107 ++++++++++++++++++++++++++++++
> net/bluetooth/l2cap_sock.c        |  13 ++++
> net/bluetooth/sco.c               |  13 ++++
> 5 files changed, 152 insertions(+)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index e42bb8e03c09..1576353a2773 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -121,6 +121,23 @@ struct bt_voice {
> 
> #define BT_SNDMTU		12
> #define BT_RCVMTU		13
> +#define BT_PHY			14
> +
> +#define BT_PHY_BR_1M_1SLOT	0x00000001
> +#define BT_PHY_BR_1M_3SLOT	0x00000002
> +#define BT_PHY_BR_1M_5SLOT	0x00000004
> +#define BT_PHY_EDR_2M_1SLOT	0x00000008
> +#define BT_PHY_EDR_2M_3SLOT	0x00000010
> +#define BT_PHY_EDR_2M_5SLOT	0x00000020
> +#define BT_PHY_EDR_3M_1SLOT	0x00000040
> +#define BT_PHY_EDR_3M_3SLOT	0x00000080
> +#define BT_PHY_EDR_3M_5SLOT	0x00000100
> +#define BT_PHY_LE_1M_TX		0x00000200
> +#define BT_PHY_LE_1M_RX		0x00000400
> +#define BT_PHY_LE_2M_TX		0x00000800
> +#define BT_PHY_LE_2M_RX		0x00001000
> +#define BT_PHY_LE_CODED_TX	0x00002000
> +#define BT_PHY_LE_CODED_RX	0x00004000
> 
> __printf(1, 2)
> void bt_info(const char *fmt, ...);
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 89ecf0a80aa1..dcc0dc6e2624 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1477,6 +1477,8 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
> struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
> 			     const void *param, u32 timeout);
> 
> +u32 hci_conn_get_phy(struct hci_conn *conn);
> +
> /* ----- HCI Sockets ----- */
> void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
> void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 87691404d0c6..65fa44cbe514 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1725,3 +1725,110 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle)
> 
> 	return hchan;
> }
> +
> +u32 hci_conn_get_phy(struct hci_conn *conn)
> +{
> +	u32 phys = 0;
> +
> +	hci_dev_lock(conn->hdev);
> +
> +	/* BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 2, Part B page 471:
> +	 * Table 6.2: Packets defined for synchronous, asynchronous, and
> +	 * CSB logical transport types.
> +	 */
> +	switch (conn->type) {
> +	case SCO_LINK:
> +		/* SCO logical transport (1 Mb/s):
> +		 * HV1, HV2, HV3 and DV.
> +		 */
> +		phys |= BT_PHY_BR_1M_1SLOT;
> +
> +		break;
> +
> +	case ACL_LINK:
> +		/* ACL logical transport (1 Mb/s) ptt=0:
> +		 * DH1, DM3, DH3, DM5 and DH5.
> +		 */
> +		phys |= BT_PHY_BR_1M_1SLOT;
> +
> +		if (conn->pkt_type & (HCI_DM3 | HCI_DH3))
> +			phys |= BT_PHY_BR_1M_3SLOT;
> +
> +		if (conn->pkt_type & (HCI_DM5 | HCI_DH5))
> +			phys |= BT_PHY_BR_1M_5SLOT;
> +
> +		/* ACL logical transport (2 Mb/s) ptt=1:
> +		 * 2-DH1, 2-DH3 and 2-DH5.
> +		 */
> +		if (!(conn->pkt_type & HCI_2DH1))
> +			phys |= BT_PHY_EDR_2M_1SLOT;
> +
> +		if (!(conn->pkt_type & HCI_2DH3))
> +			phys |= BT_PHY_EDR_2M_3SLOT;
> +
> +		if (!(conn->pkt_type & HCI_2DH5))
> +			phys |= BT_PHY_EDR_2M_5SLOT;
> +
> +		/* ACL logical transport (3 Mb/s) ptt=1:
> +		 * 3-DH1, 3-DH3 and 3-DH5.
> +		 */
> +		if (!(conn->pkt_type & HCI_3DH1))
> +			phys |= BT_PHY_EDR_3M_1SLOT;
> +
> +		if (!(conn->pkt_type & HCI_3DH3))
> +			phys |= BT_PHY_EDR_3M_3SLOT;
> +
> +		if (!(conn->pkt_type & HCI_3DH5))
> +			phys |= BT_PHY_EDR_3M_5SLOT;
> +
> +		break;
> +
> +	case ESCO_LINK:
> +		/* eSCO logical transport (1 Mb/s): EV3, EV4 and EV5 */
> +		phys |= BT_PHY_BR_1M_1SLOT;
> +
> +		if (!(conn->pkt_type & (ESCO_EV4 | ESCO_EV5)))
> +			phys |= BT_PHY_BR_1M_3SLOT;
> +
> +		/* eSCO logical transport (2 Mb/s): 2-EV3, 2-EV5 */
> +		if (!(conn->pkt_type & ESCO_2EV3))
> +			phys |= BT_PHY_EDR_2M_1SLOT;
> +
> +		if (!(conn->pkt_type & ESCO_2EV5))
> +			phys |= BT_PHY_EDR_2M_3SLOT;
> +
> +		/* eSCO logical transport (3 Mb/s): 3-EV3, 3-EV5 */
> +		if (!(conn->pkt_type & ESCO_3EV3))
> +			phys |= BT_PHY_EDR_3M_1SLOT;
> +
> +		if (!(conn->pkt_type & ESCO_3EV5))
> +			phys |= BT_PHY_EDR_3M_3SLOT;
> +
> +		break;
> +
> +	case LE_LINK:
> +		if (conn->le_tx_phy & HCI_LE_SET_PHY_1M)
> +			phys |= BT_PHY_LE_1M_TX;
> +
> +		if (conn->le_rx_phy & HCI_LE_SET_PHY_1M)
> +			phys |= BT_PHY_LE_1M_RX;
> +
> +		if (conn->le_tx_phy & HCI_LE_SET_PHY_2M)
> +			phys |= BT_PHY_LE_2M_TX;
> +
> +		if (conn->le_rx_phy & HCI_LE_SET_PHY_2M)
> +			phys |= BT_PHY_LE_2M_RX;
> +
> +		if (conn->le_tx_phy & HCI_LE_SET_PHY_CODED)
> +			phys |= BT_PHY_LE_CODED_TX;
> +
> +		if (conn->le_rx_phy & HCI_LE_SET_PHY_CODED)
> +			phys |= BT_PHY_LE_CODED_RX;
> +
> +		break;
> +	}
> +
> +	hci_dev_unlock(conn->hdev);
> +
> +	return phys;
> +}
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 390a9afab647..3df4a7cf85a3 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -499,6 +499,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
> 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> 	struct bt_security sec;
> 	struct bt_power pwr;
> +	u32 phys;
> 	int len, err = 0;
> 
> 	BT_DBG("sk %p", sk);
> @@ -603,6 +604,18 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
> 			err = -EFAULT;
> 		break;
> 
> +	case BT_PHY:
> +		if (sk->sk_state == BT_CONNECTED) {
> +			err = -EINVAL;
> +			break;
> +		}

don’t we better return -ENOTCONN here?

Regards

Marcel

