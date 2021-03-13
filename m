Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B35C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Mar 2021 11:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C8C64E33
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Mar 2021 11:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhCMLCf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Mar 2021 06:02:35 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36204 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhCMLC0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Mar 2021 06:02:26 -0500
Received: from marcel-macbook.holtmann.net (p4fefc126.dip0.t-ipconnect.de [79.239.193.38])
        by mail.holtmann.org (Postfix) with ESMTPSA id 331D0CED1B;
        Sat, 13 Mar 2021 12:10:01 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix not checking for maximum number of
 DCID
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210312181948.1225833-1-luiz.dentz@gmail.com>
Date:   Sat, 13 Mar 2021 12:02:24 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <D4446968-D944-4FE8-A6B7-290706FF7923@holtmann.org>
References: <20210312181948.1225833-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> When receiving L2CAP_CREDIT_BASED_CONNECTION_REQ the remote may request
> more channels than allowed by the spec (10 octecs = 5 CIDs) so this
> truncates the response allowing it to create only the maximum allowed.

so what does the spec say the behavior should be? Truncate or actually respond with an error?

> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/l2cap.h | 1 +
> net/bluetooth/l2cap_core.c    | 4 ++--
> 2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 61800a7b6192..3c4f550e5a8b 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -494,6 +494,7 @@ struct l2cap_le_credits {
> 
> #define L2CAP_ECRED_MIN_MTU		64
> #define L2CAP_ECRED_MIN_MPS		64
> +#define L2CAP_ECRED_MAX_CID		5
> 
> struct l2cap_ecred_conn_req {
> 	__le16 psm;
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 72c2f5226d67..6325d4a89b31 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5921,7 +5921,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
> 	struct l2cap_ecred_conn_req *req = (void *) data;
> 	struct {
> 		struct l2cap_ecred_conn_rsp rsp;
> -		__le16 dcid[5];
> +		__le16 dcid[L2CAP_ECRED_MAX_CID];
> 	} __packed pdu;
> 	struct l2cap_chan *chan, *pchan;
> 	u16 mtu, mps;
> @@ -5973,7 +5973,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
> 	cmd_len -= sizeof(*req);
> 	num_scid = cmd_len / sizeof(u16);
> 
> -	for (i = 0; i < num_scid; i++) {
> +	for (i = 0; i < num_scid && i < ARRAY_SIZE(pdu.dcid); i++) {
> 		u16 scid = __le16_to_cpu(req->scid[i]);
> 
> 		BT_DBG("scid[%d] 0x%4.4x", i, scid);

Is this really a good idea? I would prefer if we check the size first and then just respond with an error.

Regards

Marcel

