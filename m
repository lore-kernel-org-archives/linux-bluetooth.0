Return-Path: <SRS0=dFGF=BH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB34C433E3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 07:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB7AB207F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 07:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxureNHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgG1HEb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgG1HEb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jul 2020 03:04:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB039C061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 00:04:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b186so126810pfb.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 00:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3Tti1y5Bjyb7ZPVuwuxQs125pNEWWZEmzoggkjoZa4=;
        b=OxureNHLzRTRL7rzDdsYfLiC/VdrBDAwKeB/qltP4XNeNMs4TzRmRys7sokkueEbwo
         v6z+c125itwltj24UbvPz5aBPqWcBBwrB9DspFhR4Ub6EI8cETjHDlUy6BdsDNS2bKLM
         ZmdtaCs3dBoVtIbPcotQ9OjQRJBmg7vhyaG2zPTKz+wDv9z+iwvFvLBJNSwzlvpkKxkX
         FBaZUs3kpGv+YklVVUJxQIuqliCge1icGEKqosIYQl4UD+mNUNA9vYa3PtgTkwjF0OxX
         n2GUj3sr14zH0YNG0xkTU8+8Mg2OgUole1u05Tky3nT1d6TPNFUmnXlSDONc4pFkykNG
         hC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3Tti1y5Bjyb7ZPVuwuxQs125pNEWWZEmzoggkjoZa4=;
        b=Ll7PG7vAX8++2qM3N4swI/u1Xaoq0o/4vc5IAlDMyVRLIh93so9eHp0d2y45L75HxF
         lL3bkcF1FvXcy0Pv6c9QRRLHPZ3UyBRQVb9AGcmB01sc/5ohntQsU6c6tGGk4aEcbiql
         x0xLlISm/rv3MBjurvxDKxqZztzs1SqlGK0BnIUCCWGP22RhdaXZCmoTQH8NaPJ08mQK
         UA9dkD1CcRuwvgarWHM4o2lrToZglj4pdjVj1wlGVAfDPizNS5ZkuU8ZLNREwvRXK36A
         gG7tYX7KigPcdpc/8FIzCNDagvwoFRu1EkcGT8QxLysqiCQWVOE98fvVQ1l6EpNRZkyX
         gyEg==
X-Gm-Message-State: AOAM532mWApc9l9usltN6GDJ9HMHnPZSl5UuHKRDjG8bqwDc6u0hufOC
        1uhZL5ikHLsPMkRYKtj/iIfaFPJR8sI=
X-Google-Smtp-Source: ABdhPJzi9m740DPVDsOJ9O6zjBNCwwBy0aLqXjCE3Jc+yvGzBJPAEB9wEIEbX6jUDn8WM4EkE8J6oA==
X-Received: by 2002:a05:6a00:2ba:: with SMTP id q26mr23935437pfs.135.1595919869832;
        Tue, 28 Jul 2020 00:04:29 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n2sm17624389pfq.140.2020.07.28.00.04.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 00:04:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: L2CAP: Fix to handling fragmented header
Date:   Tue, 28 Jul 2020 00:04:28 -0700
Message-Id: <20200728070428.1754257-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Bluetooth Core Specification v5.2, Vol. 3, Part A, section 1.4, table
1.1:

 'Start Fragments always either begin with the first octet of the Basic
  L2CAP header of a PDU or they have a length of zero (see [Vol 2] Part
  B, Section 6.6.2).'

This text has been changed recently as it previously stated:

 'Start Fragments always begin with the Basic L2CAP header of a PDU.'

Apparently this was changed by the following errata:

https://www.bluetooth.org/tse/errata_view.cfm?errata_id=10216

In past this has not been a problem but it seems new controllers are
apparently doing it as it has been reported in Zephyr:

https://github.com/zephyrproject-rtos/zephyr/issues/26900

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 104 +++++++++++++++++++++++++++++--------
 1 file changed, 83 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ade83e224567..193bea314222 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -8269,6 +8269,63 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
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
+static int l2cap_recv_header(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct l2cap_hdr *hdr;
+	struct sk_buff *rx_skb;
+	int len;
+
+	/* Append just enough to complete the header */
+	len = l2cap_recv_frag(conn, skb, L2CAP_HDR_SIZE - conn->rx_skb->len);
+
+	/* If header could not be read just continue */
+	if (len < 0 || conn->rx_skb->len < L2CAP_HDR_SIZE)
+		return len;
+
+	rx_skb = conn->rx_skb;
+	conn->rx_skb = NULL;
+
+	hdr = (struct l2cap_hdr *) rx_skb->data;
+
+	/* Append existing rx_skb as that allocates only enough for the
+	 * headers.
+	 */
+	len = l2cap_recv_frag(conn, rx_skb,
+			      __le16_to_cpu(hdr->len) + L2CAP_HDR_SIZE);
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
@@ -8291,19 +8348,19 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
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
+		/* Start fragment may not contain the L2CAP header so just
+		 * copy the initial byte when that happens.
+		 */
 		if (skb->len < L2CAP_HDR_SIZE) {
-			BT_ERR("Frame is too short (len %d)", skb->len);
-			l2cap_conn_unreliable(conn, ECOMM);
-			goto drop;
+			if (l2cap_recv_frag(conn, skb, L2CAP_HDR_SIZE) < 0)
+				goto drop;
+			return;
 		}
 
 		hdr = (struct l2cap_hdr *) skb->data;
@@ -8324,38 +8381,43 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
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
 
+		/* Complete the L2CAP header if it has not been read */
+		if (conn->rx_skb->len < L2CAP_HDR_SIZE) {
+			if (l2cap_recv_header(conn, skb) < 0) {
+				l2cap_conn_unreliable(conn, ECOMM);
+				goto drop;
+			}
+
+			/* Header still could not be read just continue */
+			if (conn->rx_skb->len < L2CAP_HDR_SIZE)
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

