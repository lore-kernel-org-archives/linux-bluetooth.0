Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86373C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE25206DA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgAHV2j convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:28:39 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:44966 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAHV2i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 16:28:38 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id D9F26CECFB;
        Wed,  8 Jan 2020 22:37:53 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH 03/10] Bluetooth: L2CAP: Add definitions for Enhanced
 Credit Based Mode
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200107074056.25453-4-luiz.dentz@gmail.com>
Date:   Wed, 8 Jan 2020 22:28:37 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <A8EFE408-EB7F-4C7E-A10F-FC0DA7A84738@holtmann.org>
References: <20200107074056.25453-1-luiz.dentz@gmail.com>
 <20200107074056.25453-4-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This introduces the definitions for the new L2CAP mode called Enhanced
> Credit Based Mode.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/l2cap.h | 45 +++++++++++++++++++++++++++++++++++
> 1 file changed, 45 insertions(+)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 093aedebdf0c..5646a40c793c 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -119,6 +119,11 @@ struct l2cap_conninfo {
> #define L2CAP_LE_CONN_REQ	0x14
> #define L2CAP_LE_CONN_RSP	0x15
> #define L2CAP_LE_CREDITS	0x16
> +#define L2CAP_ECRED_CONN_REQ	0x17
> +#define L2CAP_ECRED_CONN_RSP	0x18
> +#define L2CAP_ECRED_RECONF_REQ	0x19
> +#define L2CAP_ECRED_RECONF_RSP	0x1a
> +
> 
> /* L2CAP extended feature mask */
> #define L2CAP_FEAT_FLOWCTL	0x00000001
> @@ -360,6 +365,11 @@ struct l2cap_conf_rfc {
>  */
> #define L2CAP_MODE_LE_FLOWCTL	0x80
> 
> +/* This is essentially L2CAP_MODE_LE_FLOWCTL but works with BR/EDR */

scrap this comment since it is misleading. It is just another mode.

> +#define L2CAP_MODE_ECRED	0x81
> +
> +#define L2CAP_MODE_ECRED_MASK	0x80
> +

Lets not use such a mask. It will come to bite us if we ever add another mode.

> struct l2cap_conf_efs {
> 	__u8	id;
> 	__u8	stype;
> @@ -483,6 +493,39 @@ struct l2cap_le_credits {
> 	__le16     credits;
> } __packed;
> 
> +#define L2CAP_ECRED_MIN_MTU		64
> +#define L2CAP_ECRED_MIN_MPS		64
> +
> +struct l2cap_ecred_conn_req {
> +	__le16 psm;
> +	__le16 mtu;
> +	__le16 mps;
> +	__le16 credits;
> +	__le16 scid[0];
> +} __packed;
> +
> +struct l2cap_ecred_conn_rsp {
> +	__le16 mtu;
> +	__le16 mps;
> +	__le16 credits;
> +	__le16 result;
> +	__le16 dcid[0];
> +};
> +
> +struct l2cap_ecred_reconf_req {
> +	__le16 mtu;
> +	__le16 mps;
> +	__le16 scid[0];
> +} __packed;
> +
> +#define L2CAP_RECONF_SUCCESS		0x0000
> +#define L2CAP_RECONF_INVALID_MTU	0x0001
> +#define L2CAP_RECONF_INVALID_MPS	0x0002
> +
> +struct l2cap_ecred_reconf_rsp {
> +	__le16 result;
> +} __packed;
> +
> /* ----- L2CAP channels and connections ----- */
> struct l2cap_seq_list {
> 	__u16	head;
> @@ -724,6 +767,7 @@ enum {
> 	FLAG_EFS_ENABLE,
> 	FLAG_DEFER_SETUP,
> 	FLAG_LE_CONN_REQ_SENT,
> +	FLAG_ECRED_CONN_REQ_SENT,
> 	FLAG_PENDING_SECURITY,
> 	FLAG_HOLD_HCI_CONN,
> };
> @@ -923,6 +967,7 @@ void l2cap_cleanup_sockets(void);
> bool l2cap_is_socket(struct socket *sock);
> 
> void __l2cap_le_connect_rsp_defer(struct l2cap_chan *chan);
> +void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan);
> void __l2cap_connect_rsp_defer(struct l2cap_chan *chan);
> 
> int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);

Regards

Marcel

