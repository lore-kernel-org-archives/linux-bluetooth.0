Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04613C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 02:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB04E222C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 02:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgAOCDZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 21:03:25 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:52538 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbgAOCDZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 21:03:25 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 44751CECE6;
        Wed, 15 Jan 2020 03:12:41 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v3 3/8] Bluetooth: L2CAP: Add definitions for Enhanced
 Credit Based Mode
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200115015918.1187-4-luiz.dentz@gmail.com>
Date:   Wed, 15 Jan 2020 03:03:23 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9512B560-6CBA-4C4E-A2B3-DDEC2653DF1D@holtmann.org>
References: <20200115015918.1187-1-luiz.dentz@gmail.com>
 <20200115015918.1187-4-luiz.dentz@gmail.com>
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
> include/net/bluetooth/l2cap.h | 41 +++++++++++++++++++++++++++++++++++
> 1 file changed, 41 insertions(+)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 093aedebdf0c..d85fb2c8e6eb 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -119,6 +119,11 @@ struct l2cap_conninfo {
> #define L2CAP_LE_CONN_REQ	0x14
> #define L2CAP_LE_CONN_RSP	0x15
> #define L2CAP_LE_CREDITS	0x16
> +#define L2CAP_EXT_FLOWCTL_CONN_REQ	0x17
> +#define L2CAP_EXT_FLOWCTL_CONN_RSP	0x18
> +#define L2CAP_EXT_FLOWCTL_RECONF_REQ	0x19
> +#define L2CAP_EXT_FLOWCTL_RECONF_RSP	0x1a
> +
> 
> /* L2CAP extended feature mask */
> #define L2CAP_FEAT_FLOWCTL	0x00000001
> @@ -360,6 +365,8 @@ struct l2cap_conf_rfc {
>  */
> #define L2CAP_MODE_LE_FLOWCTL	0x80
> 
> +#define L2CAP_MODE_EXT_FLOWCTL	0x81
> +
> struct l2cap_conf_efs {
> 	__u8	id;
> 	__u8	stype;
> @@ -483,6 +490,39 @@ struct l2cap_le_credits {
> 	__le16     credits;
> } __packed;
> 
> +#define L2CAP_EXT_FLOWCTL_MIN_MTU		64
> +#define L2CAP_EXT_FLOWCTL_MIN_MPS		64
> +
> +struct l2cap_ext_flowctl_conn_req {
> +	__le16 psm;
> +	__le16 mtu;
> +	__le16 mps;
> +	__le16 credits;
> +	__le16 scid[0];
> +} __packed;
> +
> +struct l2cap_ext_flowctl_conn_rsp {
> +	__le16 mtu;
> +	__le16 mps;
> +	__le16 credits;
> +	__le16 result;
> +	__le16 dcid[0];
> +};
> +
> +struct l2cap_ext_flowctl_reconf_req {
> +	__le16 mtu;
> +	__le16 mps;
> +	__le16 scid[0];
> +} __packed;
> +
> +#define L2CAP_RECONF_SUCCESS		0x0000
> +#define L2CAP_RECONF_INVALID_MTU	0x0001
> +#define L2CAP_RECONF_INVALID_MPS	0x0002
> +
> +struct l2cap_ext_flowctl_reconf_rsp {
> +	__le16 result;
> +} __packed;
> +
> /* ----- L2CAP channels and connections ----- */
> struct l2cap_seq_list {
> 	__u16	head;
> @@ -724,6 +764,7 @@ enum {
> 	FLAG_EFS_ENABLE,
> 	FLAG_DEFER_SETUP,
> 	FLAG_LE_CONN_REQ_SENT,

In a follow up patch I would fix FLAG_LE_CONN_REQ_SENT to FLAG_LE_FLOWCTL_CONN_REQ_SENT.

> +	FLAG_EXT_FLOWCTL_CONN_REQ_SENT,
> 	FLAG_PENDING_SECURITY,
> 	FLAG_HOLD_HCI_CONN,

Regards

Marcel

