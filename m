Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F8EC5B578
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 07:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF33D21882
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 07:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="nT7AYyA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfGCHRI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:17:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35938 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfGCHRH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 03:17:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so1234861ljj.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 00:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9PvTEh+Ow/ORJ6+fgyWozTQlS0tZUDr8e5T+J0UX2pA=;
        b=nT7AYyA3mdX6957WPGJoUsjjccPZumzoAuSxRsFddN47H5oqwV5yED0j67NOtZ9uJq
         KJb4/gw5EtdJ3UCX67Q3NR8KHC8vwrq7wzaasd0BsyoBeUmI5TC2eosTytZnSP7qdhr4
         K9eEczMaNMkg69O1rIEa/tGR3rOFmu4Eb6EOr4onY8rYGBNBFAn3P5KtFLEVqstTVzY+
         KdE/qZ+zDvwm1qFCcjdyAERgqktjrc6mD8WAPt+MaszFA80TwXqHjHWUvy9TfZlRI5rW
         0ZRgcXUcfSdqNbnmcYVX5UmDqJruidZIHh2Q6AkcaBrZF7RT/N416umkwNYbOUQV9Uve
         xYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9PvTEh+Ow/ORJ6+fgyWozTQlS0tZUDr8e5T+J0UX2pA=;
        b=KVQjAp+XghA9GnsJ+cFQGL8MdnDy/tdbXcPapc6DpmeTZXoOBJ3WbEMlfQ+kX+dZnH
         67D7/RGaa2N8nZo7y6FOKciBC4A0mLp9j37ghkwYAnlxA8VYdAWVi+OtRIh3lHgvMZZ1
         OkCN8AVufC/qmEqO2u58XVG+P5xcejmMMrlANxsopTUKmMsVPy/pPNEbFhb6Kxop929U
         m+08Qcoa2kctRTsFyc2CK9q/eYlvBBtlKcAepCau2UdrGsyghOt6I7zlOO/mhsnhFUlA
         AzgFRP3RjNdTmWgoehlb+EZBP9HwzoEUAV9JhljesW2yOs2vybLkHbyKO7pTgT0byjBj
         Gf9Q==
X-Gm-Message-State: APjAAAU2+u30GCg5CFoDMfkmvVElQoVqEAazlVqDoMTVBP1iIsZ2LT4S
        TgEThLgjc5TGuG2XVRwrIGPCQIERVa4=
X-Google-Smtp-Source: APXvYqyL2UqVOIDEPSBxmdkoAQ2BW4u1uHLlWnYAz/iVJ0YIACD9lQ44vfvXpjKuMzECstramXmlBg==
X-Received: by 2002:a2e:8583:: with SMTP id b3mr20332342lji.171.1562138224783;
        Wed, 03 Jul 2019 00:17:04 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id l11sm281364lfc.18.2019.07.03.00.17.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 00:17:04 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v3 3/3] mesh: Handle messages encrypted with a remote device key
Date:   Wed,  3 Jul 2019 09:16:56 +0200
Message-Id: <20190703071656.6342-4-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190703071656.6342-1-michal.lowas-rzechonek@silvair.com>
References: <20190703071656.6342-1-michal.lowas-rzechonek@silvair.com>
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
 mesh/model.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index aae913d92..404f5b64b 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -359,6 +359,7 @@ static int dev_packet_decrypt(struct mesh_node *node, const uint8_t *data,
 				uint16_t dst, uint8_t key_id, uint32_t seq,
 				uint32_t iv_idx, uint8_t *out)
 {
+	uint8_t dev_key[16];
 	const uint8_t *key;
 
 	key = node_get_device_key(node);
@@ -369,6 +370,14 @@ static int dev_packet_decrypt(struct mesh_node *node, const uint8_t *data,
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

