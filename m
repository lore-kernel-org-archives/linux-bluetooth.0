Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344D4C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC7B60F46
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbhHMMX3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240317AbhHMMX1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:23:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B91C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:23:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b4-20020a252e440000b0290593da85d104so9057357ybn.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6vqJqSS0wNLEL0KH3mLiDsb2ECz2yxk8FGkapwQBgDs=;
        b=KqFO14SJtIak1i9MnzeuhW5PgZXav7arzPuUXlV/aOsICiu1lCqYbz/PXwcXfEHUZ8
         cah8itVfmi3oPAoLl82V5flxBfBw05JLbKzFNXDj2G1acpixtjTeMobg5PMGD+lT/gFR
         xqYp7AqmoKAPOdlozOnvT0dAsYxVIpasXCde8otz6u26PsH1W4BUjctvMBCM83ZPp7Vw
         cPDElAHpT0hLWuCxKFzLtOfL7eSJ6FxgF10jMkx3IvDg0ZPFDLe3mX3eIGVpAYnIT/TV
         Z0UK9H9r0+6I8GD6+x2ZrnY2mPTApfK8vCqVdhcJ1RWGbCzmPQgETMPrmGwsTlVd5IvI
         NEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6vqJqSS0wNLEL0KH3mLiDsb2ECz2yxk8FGkapwQBgDs=;
        b=WhV1uKmgXW2hJx+vbMYNBMrAs6cdR07rjWVPYNJMbBBrBb2WT9btdtO63R9svXI2/m
         +A57U924GzUBOk4kdxT5/AOhtHEbYRl5wyRT6jtVGverfikcIGilSbvvOKiaHydp26i6
         mGZN4dWTq6Jd4mAKJNJfIr6tvVqE8JQPlaYTu81dpYv9piY+dhNvI69Wagy7Cul3cxjJ
         om/mPOQGdbD9gskXK+H0qtFoSL/OfOq/HoxNOskAi3y36hcUL5Q65VAOAHUyFX/ts0Tp
         pBHpb9vq4Ek//H5m4nmxSo9oBCaNaSaOd8CTuEnH6vZMB7s1BGgJH3YXo5uAbIwKTbw2
         i4EQ==
X-Gm-Message-State: AOAM533m5BGAHrGcPLo08lxgBLy4yU4B4NfzVGDutpcuVhUZpQVa3p9e
        KB7nMnuT0U1M1sBzQ4JZ6ErtG+0qOdhANqd6dKgR7KonAawjVj7DB65Djtui7/HsZLPqr0D6Nnz
        ZLbnrGm2NvoCk9cDEN+DGVAZ4SnZlSzHv2al2VrBwfx6Bic3gM27gkzflHpUPVMPherIrDNHfVJ
        np
X-Google-Smtp-Source: ABdhPJzlw8ZMBkrxP19bR9EjOWlPTo73j19ioGifX571arYMsVzYjhkK6jfC1nNypg+xfcRIHalX6NCo6SxQ
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:ea47:: with SMTP id
 o7mr2633759ybe.144.1628857379986; Fri, 13 Aug 2021 05:22:59 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:41 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.56.Icb2f24bc14fbf8b4e8130be225873f6c4117b1c2@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 56/62] tools/mesh-gatt: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"accept" and "reject list" are the preferred terms, as reflected in
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf
---

 tools/mesh-gatt/mesh-net.h |  4 +--
 tools/mesh-gatt/net.c      | 60 +++++++++++++++++++-------------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/tools/mesh-gatt/mesh-net.h b/tools/mesh-gatt/mesh-net.h
index 29c8de06cf..95a1346e75 100644
--- a/tools/mesh-gatt/mesh-net.h
+++ b/tools/mesh-gatt/mesh-net.h
@@ -97,8 +97,8 @@
 #define PROXY_OP_FILTER_STATUS		0x03
 
 /* Proxy Filter Defines */
-#define PROXY_FILTER_WHITELIST		0x00
-#define PROXY_FILTER_BLACKLIST		0x01
+#define PROXY_FILTER_ACCEPT_LIST	0x00
+#define PROXY_FILTER_REJECT_LIST	0x01
 
 /* Network Tranport Opcodes */
 #define NET_OP_SEG_ACKNOWLEDGE		0x00
diff --git a/tools/mesh-gatt/net.c b/tools/mesh-gatt/net.c
index 2fdd0d4bef..47afedf34d 100644
--- a/tools/mesh-gatt/net.c
+++ b/tools/mesh-gatt/net.c
@@ -47,11 +47,11 @@ struct mesh_net {
 	uint8_t default_ttl;
 	bool iv_update;
 	bool provisioner;
-	bool blacklist;
+	bool reject_list;
 	guint iv_update_timeout;
 	GDBusProxy *proxy_in;
 	GList *address_pool;
-	GList *dest;	/* List of valid local destinations for Whitelist */
+	GList *dest;	/* List of valid local destinations for Accept List */
 	GList *sar_in;	/* Incoming segmented messages in progress */
 	GList *msg_out;	/* Pre-Network encoded, might be multi-segment */
 	GList *pkt_out; /* Fully encoded packets awaiting Tx in order */
@@ -200,8 +200,8 @@ struct mesh_destination {
 #define FILTER_STATUS		0x03
 
 /* Proxy Filter Types */
-#define WHITELIST_FILTER	0x00
-#define BLACKLIST_FILTER	0x01
+#define ACCEPT_LIST_FILTER	0x00
+#define REJECT_LIST_FILTER	0x01
 
 /* IV Updating states for timing enforcement */
 #define IV_UPD_INIT 		0
@@ -919,45 +919,45 @@ void net_dest_unref(uint16_t dst)
 	}
 }
 
-struct build_whitelist {
+struct build_accept_list {
 	uint8_t len;
 	uint8_t data[12];
 };
 
-static void whitefilter_add(gpointer data, gpointer user_data)
+static void accept_filter_add(gpointer data, gpointer user_data)
 {
 	struct mesh_destination	*dest = data;
-	struct build_whitelist *white = user_data;
+	struct build_accept_list *accept = user_data;
 
-	if (white->len == 0)
-		white->data[white->len++] = FILTER_ADD;
+	if (accept->len == 0)
+		accept->data[accept->len++] = FILTER_ADD;
 
-	put_be16(dest->dst, white->data + white->len);
-	white->len += 2;
+	put_be16(dest->dst, accept->data + accept->len);
+	accept->len += 2;
 
-	if (white->len > (sizeof(white->data) - sizeof(uint16_t))) {
-		net_ctl_msg_send(0, 0, 0, white->data, white->len);
-		white->len = 0;
+	if (accept->len > (sizeof(accept->data) - sizeof(uint16_t))) {
+		net_ctl_msg_send(0, 0, 0, accept->data, accept->len);
+		accept->len = 0;
 	}
 }
 
-static void setup_whitelist()
+static void setup_accept_list()
 {
-	struct build_whitelist white;
+	struct build_accept_list accept;
 
-	white.len = 0;
+	accept.len = 0;
 
-	/* Enable (and Clear) Proxy Whitelist */
-	white.data[white.len++] = FILTER_SETUP;
-	white.data[white.len++] = WHITELIST_FILTER;
+	/* Enable (and Clear) Proxy Accept List */
+	accept.data[accept.len++] = FILTER_SETUP;
+	accept.data[accept.len++] = ACCEPT_LIST_FILTER;
 
-	net_ctl_msg_send(0, 0, 0, white.data, white.len);
+	net_ctl_msg_send(0, 0, 0, accept.data, accept.len);
 
-	white.len = 0;
-	g_list_foreach(net.dest, whitefilter_add, &white);
+	accept.len = 0;
+	g_list_foreach(net.dest, accept_filter_add, &accept);
 
-	if (white.len)
-		net_ctl_msg_send(0, 0, 0, white.data, white.len);
+	if (accept.len)
+		net_ctl_msg_send(0, 0, 0, accept.data, accept.len);
 }
 
 static void beacon_update(bool first, bool iv_update, uint32_t iv_index)
@@ -1009,7 +1009,7 @@ static void beacon_update(bool first, bool iv_update, uint32_t iv_index)
 
 	if (first) {
 		/* Must be done once per Proxy Connection after Beacon RXed */
-		setup_whitelist();
+		setup_accept_list();
 		if (net.open_cb)
 			net.open_cb(0);
 	}
@@ -1388,9 +1388,9 @@ static bool proxy_ctl_rxed(uint16_t net_idx, uint32_t iv_index,
 			if (len != 4)
 				return false;
 
-			net.blacklist = !!(trans[1] == BLACKLIST_FILTER);
-			bt_shell_printf("Proxy %slist filter length: %d\n",
-					net.blacklist ? "Black" : "White",
+			net.reject_list = !!(trans[1] == REJECT_LIST_FILTER);
+			bt_shell_printf("Proxy %s list filter length: %d\n",
+					net.reject_list ? "Reject" : "Accept",
 					get_be16(trans + 2));
 
 			return true;
@@ -1950,7 +1950,7 @@ bool net_session_open(GDBusProxy *data_in, bool provisioner,
 
 	net.proxy_in = data_in;
 	net.iv_upd_state = IV_UPD_INIT;
-	net.blacklist = false;
+	net.reject_list = false;
 	net.provisioner = provisioner;
 	net.open_cb = cb;
 	flush_pkt_list(&net.pkt_out);
-- 
2.33.0.rc1.237.g0d66db33f3-goog

