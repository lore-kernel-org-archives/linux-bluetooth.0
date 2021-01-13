Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409BBC432C3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 01:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B0023442
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 01:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbhANB64 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jan 2021 20:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbhAMXj5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jan 2021 18:39:57 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DCBC0617B1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 15:29:01 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id h186so2239515pfe.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 15:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wVwFamY587BzXr0Sv+DHxr95ILPapJvnKnljEHNPQio=;
        b=Dcahn+76J1xfzp3HPOneWydv0Z/Imx8w/FhIWW9IapzuNB83H6NDtlqutfjPsJxUxr
         9NUg3K1YwWOa1nPsuyvyhQU0/xsLelqOaoM6eril2bDa0Bh+fbdwDlcqi156xa2bzDKe
         ZPgfh7UE7cscg8HzU+rBiAY81xbenIQefGUTz+dBoLyDakTrJEUjiLUQUqYlK/gg1z9b
         /HTPXI9/mBAYCdL5/Ot94LIzdsEO4SNCesV5PwntlGrpnZeVxK5CXvJYbmHupcqUW1bt
         7Vvi6NHKGzgezLVvDU6gkpU+wu9/KxalHzioJe+nncBqWSq7Zi2Z1XTzcY/aWZiYXQJG
         ZKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wVwFamY587BzXr0Sv+DHxr95ILPapJvnKnljEHNPQio=;
        b=tlImvtjRFRc8+WfP1p5Q3wf4Lnmeyh12+QrXcl/2FoPKBy3+MgLIsDiDz62MgPE+JJ
         zvJpid1z0QYjAfNmAoqqMSW5XIbZDDm2zZxcgKW/vXyju06iKIP8crVCZHbI6HDqlvVi
         qzs+XfL+2srfyl0hLtJEb+lgZHGWJ60YzoUC7pEx9t4rE+2zFTBj4dyx6NIuIUbUHvN3
         h+xAh8MMzXGVmh2LHLky67Wy2PHUu3HawuXQRCAs9mt5DLFE8pJjQQa6Una95Ri6Kw13
         Z3e/sGn7UD7xo01mwqTcWWzdQnO9uX4DoYBgwXmVIO+6OMTZNNfF7knzI4LnoujPdJXN
         iFWg==
X-Gm-Message-State: AOAM531rG74pxwTIpcWzViP/5raVO5Gw8XXsJNQSCgxUUS6d2rFrSOA9
        a5m+buuYFCArt0kQOABOKx0puS183fs=
X-Google-Smtp-Source: ABdhPJzcUBdOpTxPsAM4CJyFaUaXxqpxcd8NpByHFrVGiLwz/PLLQ1zSS2j62AaZ1qqgM2iSQxHCpg==
X-Received: by 2002:a63:3184:: with SMTP id x126mr4391702pgx.354.1610580541095;
        Wed, 13 Jan 2021 15:29:01 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x1sm3488487pfn.48.2021.01.13.15.29.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 15:29:00 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RESEND 2/2] Bluetooth: L2CAP: Fix handling fragmented length
Date:   Wed, 13 Jan 2021 15:28:58 -0800
Message-Id: <20210113232858.1181251-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210113232858.1181251-1-luiz.dentz@gmail.com>
References: <20210113232858.1181251-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Bluetooth Core Specification v5.2, Vol. 3, Part A, section 1.4, table
1.1:

 'Start Fragments always either begin with the first octet of the Basic
  L2CAP header of a PDU or they have a length of zero (see [Vol 2] Part
  B, Section 6.6.2).'

Apparently this was changed by the following errata:

https://www.bluetooth.org/tse/errata_view.cfm?errata_id=10216

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |   1 +
 net/bluetooth/l2cap_core.c    | 118 +++++++++++++++++++++++++++-------
 2 files changed, 94 insertions(+), 25 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 1d1232917de7..61800a7b6192 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -207,6 +207,7 @@ struct l2cap_hdr {
 	__le16     len;
 	__le16     cid;
 } __packed;
+#define L2CAP_LEN_SIZE		2
 #define L2CAP_HDR_SIZE		4
 #define L2CAP_ENH_HDR_SIZE	6
 #define L2CAP_EXT_HDR_SIZE	8
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 17b87b57a175..a24183734bd9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -8276,10 +8276,73 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 	mutex_unlock(&conn->chan_lock);
 }
 
+/* Append fragment into frame respecting the maximum len of rx_skb */
+static int l2cap_recv_frag(struct l2cap_conn *conn, struct sk_buff *skb,
+			   u16 len)
+{
+	if (!conn->rx_skb) {
+		/* Allocate skb for the complete frame (with header) */
+		conn->rx_skb = bt_skb_alloc(len, GFP_KERNEL);
+		if (!conn->rx_skb)
+			return -ENOMEM;
+		/* Init rx_len */
+		conn->rx_len = len;
+	}
+
+	/* Copy as much as the rx_skb can hold */
+	len = min_t(u16, len, skb->len);
+	skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, len), len);
+	skb_pull(skb, len);
+	conn->rx_len -= len;
+
+	return len;
+}
+
+static int l2cap_recv_len(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct sk_buff *rx_skb;
+	int len;
+
+	/* Append just enough to complete the header */
+	len = l2cap_recv_frag(conn, skb, L2CAP_LEN_SIZE - conn->rx_skb->len);
+
+	/* If header could not be read just continue */
+	if (len < 0 || conn->rx_skb->len < L2CAP_LEN_SIZE)
+		return len;
+
+	rx_skb = conn->rx_skb;
+	len = get_unaligned_le16(rx_skb->data);
+
+	/* Check if rx_skb has enough space to received all fragments */
+	if (len + (L2CAP_HDR_SIZE - L2CAP_LEN_SIZE) <= skb_tailroom(rx_skb)) {
+		/* Update expected len */
+		conn->rx_len = len + (L2CAP_HDR_SIZE - L2CAP_LEN_SIZE);
+		return L2CAP_LEN_SIZE;
+	}
+
+	/* Reset conn->rx_skb since it will need to be reallocated in order to
+	 * fit all fragments.
+	 */
+	conn->rx_skb = NULL;
+
+	/* Reallocates rx_skb using the exact expected length */
+	len = l2cap_recv_frag(conn, rx_skb,
+			      len + (L2CAP_HDR_SIZE - L2CAP_LEN_SIZE));
+	kfree_skb(rx_skb);
+
+	return len;
+}
+
+static void l2cap_recv_reset(struct l2cap_conn *conn)
+{
+	kfree_skb(conn->rx_skb);
+	conn->rx_skb = NULL;
+	conn->rx_len = 0;
+}
+
 void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
-	struct l2cap_hdr *hdr;
 	int len;
 
 	/* For AMP controller do not create l2cap conn */
@@ -8298,23 +8361,23 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 	case ACL_START:
 	case ACL_START_NO_FLUSH:
 	case ACL_COMPLETE:
-		if (conn->rx_len) {
+		if (conn->rx_skb) {
 			BT_ERR("Unexpected start frame (len %d)", skb->len);
-			kfree_skb(conn->rx_skb);
-			conn->rx_skb = NULL;
-			conn->rx_len = 0;
+			l2cap_recv_reset(conn);
 			l2cap_conn_unreliable(conn, ECOMM);
 		}
 
-		/* Start fragment always begin with Basic L2CAP header */
-		if (skb->len < L2CAP_HDR_SIZE) {
-			BT_ERR("Frame is too short (len %d)", skb->len);
-			l2cap_conn_unreliable(conn, ECOMM);
-			goto drop;
+		/* Start fragment may not contain the L2CAP length so just
+		 * copy the initial byte when that happens and use conn->mtu as
+		 * expected length.
+		 */
+		if (skb->len < L2CAP_LEN_SIZE) {
+			if (l2cap_recv_frag(conn, skb, conn->mtu) < 0)
+				goto drop;
+			return;
 		}
 
-		hdr = (struct l2cap_hdr *) skb->data;
-		len = __le16_to_cpu(hdr->len) + L2CAP_HDR_SIZE;
+		len = get_unaligned_le16(skb->data) + L2CAP_HDR_SIZE;
 
 		if (len == skb->len) {
 			/* Complete frame received */
@@ -8331,38 +8394,43 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 			goto drop;
 		}
 
-		/* Allocate skb for the complete frame (with header) */
-		conn->rx_skb = bt_skb_alloc(len, GFP_KERNEL);
-		if (!conn->rx_skb)
+		/* Append fragment into frame (with header) */
+		if (l2cap_recv_frag(conn, skb, len) < 0)
 			goto drop;
 
-		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
-					  skb->len);
-		conn->rx_len = len - skb->len;
 		break;
 
 	case ACL_CONT:
 		BT_DBG("Cont: frag len %d (expecting %d)", skb->len, conn->rx_len);
 
-		if (!conn->rx_len) {
+		if (!conn->rx_skb) {
 			BT_ERR("Unexpected continuation frame (len %d)", skb->len);
 			l2cap_conn_unreliable(conn, ECOMM);
 			goto drop;
 		}
 
+		/* Complete the L2CAP length if it has not been read */
+		if (conn->rx_skb->len < L2CAP_LEN_SIZE) {
+			if (l2cap_recv_len(conn, skb) < 0) {
+				l2cap_conn_unreliable(conn, ECOMM);
+				goto drop;
+			}
+
+			/* Header still could not be read just continue */
+			if (conn->rx_skb->len < L2CAP_LEN_SIZE)
+				return;
+		}
+
 		if (skb->len > conn->rx_len) {
 			BT_ERR("Fragment is too long (len %d, expected %d)",
 			       skb->len, conn->rx_len);
-			kfree_skb(conn->rx_skb);
-			conn->rx_skb = NULL;
-			conn->rx_len = 0;
+			l2cap_recv_reset(conn);
 			l2cap_conn_unreliable(conn, ECOMM);
 			goto drop;
 		}
 
-		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
-					  skb->len);
-		conn->rx_len -= skb->len;
+		/* Append fragment into frame (with header) */
+		l2cap_recv_frag(conn, skb, skb->len);
 
 		if (!conn->rx_len) {
 			/* Complete frame received. l2cap_recv_frame
-- 
2.26.2

