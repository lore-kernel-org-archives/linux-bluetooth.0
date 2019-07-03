Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A09C06513
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 11:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBA6218A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 11:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="aBdp1Le+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfGCLm0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:42:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50999 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGCLm0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 07:42:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id n9so1880513wmi.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 04:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=04Eb9elhOj68//16YIJYMI/8ksDXbThE7RRBQsTmu8w=;
        b=aBdp1Le+zjf+ADI8AVclGelJYfNxx3127EYuTRFGXARIL4RreTe+Hq1eAQpLCRT5AP
         9UW9u3uPC+thkY3mnNdw7AHYRulIIJzN+KtEIDQWD5IHLKwHCxDsJ7QIdX6mxWJI84EO
         0CZwO19k7jHFg1vK1utGCLaLizt//vknwzmPoiGQgGd71fc4XFiITFf0X8hFtiinDu6f
         SA8D/MWYwYNvRn213+2zG/GkTbmE972ibDOH/752GvfhhqHZtc4RMUTAW3OLxmS0q0Ka
         vxmwHRlP4KOe/s8bGzi96a8CfjGZKdTFHdsmGzAz0Z8X6F/SO4zGT1IBkSWK9gCasewT
         QsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=04Eb9elhOj68//16YIJYMI/8ksDXbThE7RRBQsTmu8w=;
        b=Ga2RQ8SKr+ZODo45GcprjiKQJRMRYTBQBilyPf2Uz+9pO15boJa96a2Q09sH0Gm5+l
         TfQ+WEmL2SCYJY2vonkI3oJ7vNFq5WCUmK9A1Jw/cdRxjRZGmZdNARm9zzZmu7zCU1lH
         t/46YPhhDOXH8B/aAbJx5MQHGiECJnIJubdmiRHcREE9bk/JUiBdhcZdGq4AX6rhllHS
         YdapZ8PMt+Xt++p+j1I9k7vEDnASEXNr6fmFskfVt3haENiY1yeYJ4iPN94DH6ocLnzG
         usjO0R5soE0duSgX60FGWGT8IWhJS6mhi6N9R5s16YsKa4BSiwnbLlax7LV/2ZvX35NZ
         WEEQ==
X-Gm-Message-State: APjAAAVy+fpRqjX+SUUUYfVTvZtHdJ+a0Rm1te2uJp/LWE/D2+tqjMEb
        atRG4t+1kSQqZPkchm5SO6N7I+ERepM=
X-Google-Smtp-Source: APXvYqwEct3o1mrir3HxvKGVFL5WepQLV1C3m+hZVZPWbpd6S3vcpvzgKY0iAdxRf0DmslbsMXH2Dw==
X-Received: by 2002:a1c:b457:: with SMTP id d84mr8416012wmf.153.1562154143949;
        Wed, 03 Jul 2019 04:42:23 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x6sm2556816wru.0.2019.07.03.04.42.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 04:42:23 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v4 3/3] mesh: Handle messages encrypted with a remote device key
Date:   Wed,  3 Jul 2019 13:42:14 +0200
Message-Id: <20190703114214.22320-4-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190703114214.22320-1-michal.lowas-rzechonek@silvair.com>
References: <20190703114214.22320-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds ability to receive messages encrypted using known remote
device key. Such a key must be added to the node's keyring using
ImportRemoteNode() method of org.bluez.mesh.Management1 interface.

Decrypted messages are then forwarded to the application using
DevKeyMessageReceived() D-Bus API.

Also, messages originating from a local node and encrypted using local
device key are forwarde to the application as well, if they weren't
handled by internal model. This allows e.g. receiving status messages
from a local Config Server in the application.
---
 mesh/model.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index aae913d92..0ea45987f 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -308,7 +308,7 @@ static void forward_model(void *a, void *b)
 
 	l_debug("model %8.8x with idx %3.3x", mod->id, fwd->idx);
 
-	if (fwd->idx != APP_IDX_DEV_LOCAL &&
+	if (fwd->idx != APP_IDX_DEV_LOCAL && fwd->idx != APP_IDX_DEV_REMOTE &&
 					!has_binding(mod->bindings, fwd->idx))
 		return;
 
@@ -359,16 +359,25 @@ static int dev_packet_decrypt(struct mesh_node *node, const uint8_t *data,
 				uint16_t dst, uint8_t key_id, uint32_t seq,
 				uint32_t iv_idx, uint8_t *out)
 {
+	uint8_t dev_key[16];
 	const uint8_t *key;
 
 	key = node_get_device_key(node);
 	if (!key)
-		return false;
+		return -1;
 
 	if (mesh_crypto_payload_decrypt(NULL, 0, data, size, szmict, src,
 					dst, key_id, seq, iv_idx, out, key))
 		return APP_IDX_DEV_LOCAL;
 
+	if (!keyring_get_remote_dev_key(node, src, dev_key))
+		return -1;
+
+	key = dev_key;
+	if (mesh_crypto_payload_decrypt(NULL, 0, data, size, szmict, src,
+					dst, key_id, seq, iv_idx, out, key))
+		return APP_IDX_DEV_REMOTE;
+
 	return -1;
 }
 
@@ -695,6 +704,47 @@ static int add_sub(struct mesh_net *net, struct mesh_model *mod,
 	return MESH_STATUS_SUCCESS;
 }
 
+static void send_dev_key_msg_rcvd(struct mesh_node *node, uint8_t ele_idx,
+					uint16_t src, uint16_t net_idx,
+					uint16_t size, const uint8_t *data)
+{
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message *msg;
+	struct l_dbus_message_builder *builder;
+	const char *owner;
+	const char *path;
+
+	owner = node_get_owner(node);
+	path = node_get_element_path(node, ele_idx);
+	if (!path || !owner)
+		return;
+
+	l_debug("Send \"DevKeyMessageReceived\"");
+
+	msg = l_dbus_message_new_method_call(dbus, owner, path,
+						MESH_ELEMENT_INTERFACE,
+						"DevKeyMessageReceived");
+
+	builder = l_dbus_message_builder_new(msg);
+
+	if (!l_dbus_message_builder_append_basic(builder, 'q', &src))
+		goto error;
+
+	if (!l_dbus_message_builder_append_basic(builder, 'q', &net_idx))
+		goto error;
+
+	if (!dbus_append_byte_array(builder, data, size))
+		goto error;
+
+	if (!l_dbus_message_builder_finalize(builder))
+		goto error;
+
+	l_dbus_send(dbus, msg);
+
+error:
+	l_dbus_message_builder_destroy(builder);
+}
+
 static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx, bool is_sub,
 					uint16_t src, uint16_t key_idx,
 					uint16_t size, const uint8_t *data)
@@ -843,10 +893,17 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 		 * Cycle through external models if the message has not been
 		 * handled by internal models
 		 */
-		if (forward.has_dst && !forward.done)
-			send_msg_rcvd(node, i, is_subscription, src,
-					forward.idx, forward.size,
-					forward.data);
+		if (forward.has_dst && !forward.done) {
+			if ((decrypt_idx & APP_IDX_MASK) == decrypt_idx)
+				send_msg_rcvd(node, i, is_subscription, src,
+						forward.idx, forward.size,
+						forward.data);
+			else if (decrypt_idx == APP_IDX_DEV_REMOTE ||
+				(decrypt_idx == APP_IDX_DEV_LOCAL &&
+				 mesh_net_is_local_address(net, src)))
+				send_dev_key_msg_rcvd(node, i, src, 0,
+						forward.size, forward.data);
+		}
 
 		/*
 		 * Either the message has been processed internally or
-- 
2.19.1

