Return-Path: <SRS0=LhHL=ZR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCE5C432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 12:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086A82082F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 12:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="bqh8GPQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfKYMb4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:31:56 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:51097 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfKYMb4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Nov 2019 07:31:56 -0500
Received: by mail-wm1-f48.google.com with SMTP id l17so15245837wmh.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2019 04:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yUuLcrq67bnQWX800OWs/DsAGtU1TIJB6gFkhcL1X8k=;
        b=bqh8GPQkcKRn29/4LL3H9lKl8XA/o2SGzRIjDSzLc36pPMsHH9PaxwWrHcWuobeuDh
         8jy1L2U9A8u//pmSHhJgMnMsBv19kjLiW8VRUpIenRSo7FDPXvlzYxnPcMd6GcKukBLG
         MF/QkVZbRtYo3V9BVloa36wc9HNxJRPvIacc5RCy56DwZGESdna9E9YMkMtT9KrWYa+I
         T1QRMKtXJqoJgHsv2V+mZxgs1+bMzwsy9+1GspysueAj2K+X0UhX7d+FGPldcK2FRM5H
         OrrnyP0SpIEubnK363+kWwhh6/LENLRANbWtgGV/o1UIs+53OVqskBC8aEbwfNdMNJ0x
         harg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUuLcrq67bnQWX800OWs/DsAGtU1TIJB6gFkhcL1X8k=;
        b=qNEiSAaAs0sYQppPKGlPxEcPbv1RzRTJV7ek6hSwob4Vva+hKcyefuKePWnHQ8gNpq
         xR04+J92CqV6Zu54Ikf5J27jDr042uc4I4sA88J/iqbxom/W/QjZwCvbH8Gl4lM6LLeZ
         gcesVLN8WjNhtU5PuOlmZ3M3MqD+MK/DNNBN6B4y8PfTegaa+7Zz57Lf59OueRRAoPpF
         O+O1RKWpaRIExxTeNPt67g+uQBBupjW2fMPbPXYouPwcuOk5RcslRHml152gcIO/yOLw
         fHRFlJSISeWtbBj74jsDrgf2rFA49CZLtlcp6za+rTqW5OtMxSTAktLlhYRflWf2Zyyw
         e9CA==
X-Gm-Message-State: APjAAAUuY+pfYvG8dS/tKF01v78VXCfDfJ5j2JxZZGQ3Ky7MosT89odn
        om8QyqWqvU9WG/sQcVsP/VQVI/3F8I3VAA==
X-Google-Smtp-Source: APXvYqzb2QSRQ0BCHQgBNxvaxvq7xhWtyqxLd0roUEBYkbvrZrWt9Oy0YRvg0aMI4Z8DQJzMyhoSog==
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr30318018wmd.80.1574685113038;
        Mon, 25 Nov 2019 04:31:53 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id w4sm10257553wrs.1.2019.11.25.04.31.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 04:31:52 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] mesh: Provide destination address in MessageReceived API
Date:   Mon, 25 Nov 2019 13:31:41 +0100
Message-Id: <20191125123142.25599-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191125123142.25599-1-michal.lowas-rzechonek@silvair.com>
References: <20191125123142.25599-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/mesh-api.txt | 17 ++++++++++++-----
 mesh/model.c     | 20 ++++++++++++++++----
 test/test-join   |  8 ++++----
 test/test-mesh   |  8 ++++----
 4 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index a589616eb..23a958771 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -768,7 +768,7 @@ Object path	<app_defined_element_path>
 
 Methods:
 	void MessageReceived(uint16 source, uint16 key_index,
-					boolean subscription, array{byte} data)
+					variant destination, array{byte} data)
 
 		This method is called by bluetooth-meshd daemon when a message
 		arrives addressed to the application.
@@ -781,10 +781,17 @@ Methods:
 		be used by the application when sending a response to this
 		message (in case a response is expected).
 
-		The subscription parameter is a boolean that is set to true if
-		the message is received as a part of the subscription (i.e., the
-		destination is either a well known group address or a virtual
-		label.
+		The destination parameter contains the destination address of
+		received message. Underlying variant types are:
+
+		uint16
+
+			Destination is an unicast address, or a well known
+			group address
+
+		array{byte}
+
+			Destination is a virtual address label
 
 		The data parameter is the incoming message.
 
diff --git a/mesh/model.c b/mesh/model.c
index de271f171..a0c683691 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -823,8 +823,10 @@ static void send_dev_key_msg_rcvd(struct mesh_node *node, uint8_t ele_idx,
 	l_dbus_send(dbus, msg);
 }
 
-static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx, bool is_sub,
-					uint16_t src, uint16_t app_idx,
+static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx,
+					uint16_t src, uint16_t dst,
+					const struct mesh_virtual *virt,
+					uint16_t app_idx,
 					uint16_t size, const uint8_t *data)
 {
 	struct l_dbus *dbus = dbus_get_bus();
@@ -847,7 +849,17 @@ static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx, bool is_sub,
 
 	l_dbus_message_builder_append_basic(builder, 'q', &src);
 	l_dbus_message_builder_append_basic(builder, 'q', &app_idx);
-	l_dbus_message_builder_append_basic(builder, 'b', &is_sub);
+
+	if (virt) {
+		l_dbus_message_builder_enter_variant(builder, "ay");
+		dbus_append_byte_array(builder, virt->label,
+							sizeof(virt->label));
+		l_dbus_message_builder_leave_variant(builder);
+	} else {
+		l_dbus_message_builder_enter_variant(builder, "q");
+		l_dbus_message_builder_append_basic(builder, 'q', &dst);
+		l_dbus_message_builder_leave_variant(builder);
+	}
 
 	dbus_append_byte_array(builder, data, size);
 
@@ -986,7 +998,7 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 		 */
 		if (forward.has_dst && !forward.done) {
 			if ((decrypt_idx & APP_IDX_MASK) == decrypt_idx)
-				send_msg_rcvd(node, i, is_subscription, src,
+				send_msg_rcvd(node, i, src, dst, decrypt_virt,
 						forward.app_idx, forward.size,
 						forward.data);
 			else if (decrypt_idx == APP_IDX_DEV_REMOTE ||
diff --git a/test/test-join b/test/test-join
index 079f71149..fb7b0d640 100644
--- a/test/test-join
+++ b/test/test-join
@@ -268,10 +268,10 @@ class Element(dbus.service.Object):
 			self.UpdateModelConfiguration(mod_id, config[1])
 
 	@dbus.service.method(MESH_ELEMENT_IFACE,
-					in_signature="qqbay", out_signature="")
-	def MessageReceived(self, source, key, is_sub, data):
-		print('Message Received on Element ', end='')
-		print(self.index)
+					in_signature="qqvay", out_signature="")
+	def MessageReceived(self, source, key, destination, data):
+		print('Message Received on Element %d, src=%04x, dst=%s' %
+						self.index, source, destination)
 		for model in self.models:
 			model.process_message(source, key, data)
 
diff --git a/test/test-mesh b/test/test-mesh
index 3c5ded7b3..c67bb65fb 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -556,10 +556,10 @@ class Element(dbus.service.Object):
 			self.UpdateModelConfiguration(mod_id, config[1])
 
 	@dbus.service.method(MESH_ELEMENT_IFACE,
-					in_signature="qqbay", out_signature="")
-	def MessageReceived(self, source, key, is_sub, data):
-		print('Message Received on Element ', end='')
-		print(self.index)
+					in_signature="qqvay", out_signature="")
+	def MessageReceived(self, source, key, destination, data):
+		print('Message Received on Element %d, src=%04x, dst=%s' %
+						self.index, source, destination)
 		for model in self.models:
 			model.process_message(source, key, data)
 
-- 
2.19.1

