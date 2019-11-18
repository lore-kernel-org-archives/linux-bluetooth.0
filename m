Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7D4C432C3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 15:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A8F21D6C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 15:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="pi4WD7QA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfKRPl7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 10:41:59 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:36051 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfKRPl6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 10:41:58 -0500
Received: by mail-lf1-f49.google.com with SMTP id r14so7576589lff.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2019 07:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cA+cXsET/QQ5tAfAJGKcV+EVMdqWMiRknhArkkswKH8=;
        b=pi4WD7QAf5raIbVBFW3Y1+MtfrNjwZYxrn6f1YgY4zuevAOYg9um5fhZ+4+V0wXU+O
         AZfl8YIQDnHbCsVHbWxjDXVIT9LskateSFMy/cfs9bzcxO7ZQ+XJylsTNXcaV4VLppFj
         pFkEvApwKQNwVWDbu6qjqneCzBC6Rto9nJSKriAGxTHFDi/bWynP0tvCzCoRn5Hfpqps
         Sfpd2p2/0JI50a2MAAb37xeSda/5vnfZmqtWGbH6qDziG8SoCUeEl12AhjKR/lQieskL
         3EoljVieXsp7EEwEtLRVvu871mmY3xQachDEC6/8veNE3zgRh+UVZcJH/JByrbuC/K7y
         GOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cA+cXsET/QQ5tAfAJGKcV+EVMdqWMiRknhArkkswKH8=;
        b=d4eRbjPGt3cdhgElUKtEv5GBdtaJrCJ0VKrx7VbzL7kCvmr/QZu/CQfMTXhh4Z4aE2
         nDccInJgCF3tQUlVwMXqG14vyiVqjmE+9qkChpemSiAqhWTj6XAl9ckYvLAyi3ZXpe6H
         yatl97NsJqsIawJivHNRHrfvHNB8os25J0K/71MTmnvdK2sCDgEkBq9LKdCWAukbDGr8
         Lj8xA2I146h3vO6+Vw5jUQL4IsLrCHnAE5OfGDExP7q9YxgTUWMZZae25m+Yc0q7I6x2
         bEoilEh7NKFLcNd9o9cdQyRtxuv0XfNRGyFXIJLYPIIPk5RNyI9Reum1QSkU3J+szT4q
         3BvA==
X-Gm-Message-State: APjAAAXI+kLf4vr5qmG7lDxtcp0Z8LqlejLTwLTI6Ihm+wkpn2krwYuO
        1CzBEExzVM9l0WxcvBe+MHrmHAivevLLQA==
X-Google-Smtp-Source: APXvYqzR6G4knWEzYT26IL9lFCWY9OJDtc1riVExrBf9Ej/tg2Rs8nlQ7y3+C6jpoNBLmWM0d8dh0w==
X-Received: by 2002:ac2:46f3:: with SMTP id q19mr14026lfo.65.1574091715933;
        Mon, 18 Nov 2019 07:41:55 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id u4sm8584108ljj.87.2019.11.18.07.41.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 07:41:55 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] mesh: Provide destination address in MessageReceived API
Date:   Mon, 18 Nov 2019 16:41:46 +0100
Message-Id: <20191118154147.3589-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191118154147.3589-1-michal.lowas-rzechonek@silvair.com>
References: <20191118154147.3589-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/mesh-api.txt | 17 ++++++++++++-----
 mesh/model.c     | 20 ++++++++++++++++----
 test/test-mesh   |  4 ++--
 3 files changed, 30 insertions(+), 11 deletions(-)

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
diff --git a/test/test-mesh b/test/test-mesh
index 3c5ded7b3..91467bae7 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -556,8 +556,8 @@ class Element(dbus.service.Object):
 			self.UpdateModelConfiguration(mod_id, config[1])
 
 	@dbus.service.method(MESH_ELEMENT_IFACE,
-					in_signature="qqbay", out_signature="")
-	def MessageReceived(self, source, key, is_sub, data):
+					in_signature="qqvay", out_signature="")
+	def MessageReceived(self, source, key, destination, data):
 		print('Message Received on Element ', end='')
 		print(self.index)
 		for model in self.models:
-- 
2.19.1

