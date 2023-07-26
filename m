Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DB8C001E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 21:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjGZV0K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjGZV0J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 17:26:09 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE60269E
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 14:26:03 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RB6Q21MRYz109C;
        Thu, 27 Jul 2023 00:25:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1690406746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QF4dKVf7TmhOZ/dmj3ft7QgJjtuX9ExKfqILvYm6EEI=;
        b=tMSnUdNhfinhzfxpyt1UM8GkkW3emkSWXn/TNUIq5PxSQFwXtOwQD9uRwppiT6dZZIpSHw
        TjHp5cHk2WY//V2fA6yA63y65Dcw2KiJkse+2inUpW4H9qdZzKV+ZmDtyV7xQG3C3vgn3G
        C4nvSoiGbT7k9vzR9vlrOqBHZZpRonQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1690406746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QF4dKVf7TmhOZ/dmj3ft7QgJjtuX9ExKfqILvYm6EEI=;
        b=Qy5Lt0WW6VvfQvKSTJBSdOGks/ylXk/Xla2utYL22UHYMSW9j0RerSuK6GV3QVYeHDIpTR
        OICistTKdtjtTLWDRKvZdoZYxpA0V9WQAJBH9PRHLf9Q1+Kaju1lyKiOAIGZD4ItAsY0Nz
        acr4h40NYPbMKfCZJhvRGwRdQOFPlIE=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1690406746; a=rsa-sha256; cv=none;
        b=phyUNmSJeQHSeXfYlfTyNB0T1nk4SuZzYlj9n5jeW5ZqLx/9s7OYexDbwQBexHSW3q23wT
        sCNl/eniy7hQGm46GwjgXJ3LF0I+ApsM2vS/DzPhml6rXJAcjQ+lBX4NP0lkim3ol0Zdyr
        BJlXUKq3zaUeeJOU90bDs/EYOoijaqM=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH RFC 6/6] Bluetooth: ISO: handle bound CIS cleanup via hci_conn
Date:   Thu, 27 Jul 2023 00:25:26 +0300
Message-ID: <f02203d5565bbe78c2406ca45a5a72336a1315ea.1690399379.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690399379.git.pav@iki.fi>
References: <cover.1690399379.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Calling hci_conn_del in __iso_sock_close is invalid. It needs
hdev->lock, but it cannot be acquired there due to lock ordering.

Fix this by doing cleanup via hci_conn_drop.

Return hci_conn with refcount 1 from hci_bind_cis and hci_connect_cis,
so that the iso_conn always holds one reference.  This also fixes
refcounting when error handling.

Since hci_conn_abort shall handle termination of connections in any
state properly, we can handle BT_CONNECT socket state in the same way as
BT_CONNECTED.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_conn.c |  5 +++++
 net/bluetooth/iso.c      | 14 +-------------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ba339a0eb851..33fbdc8e0748 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1901,6 +1901,8 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EINVAL);
 	}
 
+	hci_conn_hold(cis);
+
 	cis->iso_qos = *qos;
 	cis->state = BT_BOUND;
 
@@ -2254,6 +2256,9 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-ENOLINK);
 	}
 
+	/* Link takes the refcount */
+	hci_conn_drop(cis);
+
 	cis->state = BT_CONNECT;
 
 	hci_le_create_cis_pending(hdev);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index cbe3299b4a41..358954bfbb32 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -628,6 +628,7 @@ static void __iso_sock_close(struct sock *sk)
 		iso_sock_cleanup_listen(sk);
 		break;
 
+	case BT_CONNECT:
 	case BT_CONNECTED:
 	case BT_CONFIG:
 		if (iso_pi(sk)->conn->hcon) {
@@ -643,19 +644,6 @@ static void __iso_sock_close(struct sock *sk)
 		break;
 
 	case BT_CONNECT2:
-		iso_chan_del(sk, ECONNRESET);
-		break;
-	case BT_CONNECT:
-		/* In case of DEFER_SETUP the hcon would be bound to CIG which
-		 * needs to be removed so just call hci_conn_del so the cleanup
-		 * callback do what is needed.
-		 */
-		if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
-		    iso_pi(sk)->conn->hcon) {
-			hci_conn_del(iso_pi(sk)->conn->hcon);
-			iso_pi(sk)->conn->hcon = NULL;
-		}
-
 		iso_chan_del(sk, ECONNRESET);
 		break;
 	case BT_DISCONN:
-- 
2.41.0

