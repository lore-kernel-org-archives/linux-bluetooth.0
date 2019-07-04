Return-Path: <SRS0=WywE=VB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71576C06513
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 12:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453E32189E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 12:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="cuXN/nOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfGDMdw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:33:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41284 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfGDMdw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jul 2019 08:33:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id 205so6010043ljj.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2019 05:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jT38FKaA1VlPE3jgUiaiXGovkgJDk9z7q3fbUZoZmTo=;
        b=cuXN/nOMTY1veos/DHhQWyDgkiBK6x+mOE/7riSBavKVnImaYwkEDTFAW1XsNkhEW7
         pNDfRPJh43c5+gm6rKZ+R4XG9McZ0UFpI9oGMSw5Ev+xTNWT/gnzdtWO8Izl090qhoad
         Q00LOfGWGFJvlU032ysygo4mBpKL4TWyvBiVw/pFfN2itfKCFsvvYHtdc/M7dCBASLtv
         npQT/HIn0VL1OVnzQmVymo37y75kqmLNKwhrOyUsd1Zc3z5q/5jiRQbC+JfO22wVADXc
         lgJBNjAi6uMEVyPnvQQ+/hVCjEZA7m3Zj7GqYBXQMfGmyrmpCKTZmo2kQCQmnwuzc9qy
         gHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jT38FKaA1VlPE3jgUiaiXGovkgJDk9z7q3fbUZoZmTo=;
        b=j+T2BsLJiFDKJJSrBYn7JZhlZvb7YlncPSsBnNracnBckNhcDoxztvTO97Y3Oj40RB
         OJaAFqqvlTJoXlyU+/nNhOrY6cId547g9gTTEzSnN/YnaLgK3Jv5OJjTsfCt3qpRgQ67
         sZvfHDENYnapYQ/jNg+QcGiz9HN1IN7GixcoyCDsBBXIpoPGBMH/vj/3mjUUnAVSmepX
         KeIdlR8Itkdlg5tK/3bqrPQPfDnLLf8XGIHE6NwNoM8lmZZTdU+ygpqvVS90T6KMmZJw
         JmTfyFC8fMHM92tV4PG/HXgJTAwSuytYuVP8VTEGtn6b89aHUx4Kyt9+KGGAVjIy9xTY
         DGOA==
X-Gm-Message-State: APjAAAVIkEhZILnf0S8oEWGy7rUXvaH1YrWv14R/x7c7V87Q0KMcKdJ4
        yXLe+I0xq5iHqr3eF1Eghgy5HLscrg4=
X-Google-Smtp-Source: APXvYqxc5Bm98ESMg7C5IkLw8a2c77cnZ3Q57nP7ohf2JqdBl7vB59ugEjW0PuC9CEPaaWm+Yq2czg==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26mr24941804lja.230.1562243629651;
        Thu, 04 Jul 2019 05:33:49 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id g68sm1126151ljg.47.2019.07.04.05.33.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 05:33:49 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v5 5/5] mesh: Handle messages encrypted with a remote device key
Date:   Thu,  4 Jul 2019 14:33:38 +0200
Message-Id: <20190704123338.5988-6-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190704123338.5988-1-michal.lowas-rzechonek@silvair.com>
References: <20190704123338.5988-1-michal.lowas-rzechonek@silvair.com>
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
 mesh/model.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index edb820cc9..959465cd3 100644
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
 
@@ -695,6 +704,39 @@ static int add_sub(struct mesh_net *net, struct mesh_model *mod,
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
+	l_dbus_message_builder_append_basic(builder, 'q', &src);
+	l_dbus_message_builder_append_basic(builder, 'q', &net_idx);
+	dbus_append_byte_array(builder, data, size);
+
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+
+	l_dbus_send(dbus, msg);
+}
+
 static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx, bool is_sub,
 					uint16_t src, uint16_t key_idx,
 					uint16_t size, const uint8_t *data)
@@ -833,10 +875,17 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
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

