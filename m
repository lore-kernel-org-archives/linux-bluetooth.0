Return-Path: <SRS0=p1bJ=U7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BB8C06511
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jul 2019 09:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0208820836
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jul 2019 09:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="V+JsypLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfGBJHm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:07:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43889 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfGBJHm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Jul 2019 05:07:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id j29so10802259lfk.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2019 02:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BeXoiUBzZvgGk5KhM0sX1cYz05NrTFzD5DM8ZErxb8o=;
        b=V+JsypLCgxGKUYZWi3e1DTFTUI23xQdcdfYLqe+0I0uER4vne5L4r5lTFkxI0iZrZB
         02yv8l0HhhbMRcKfX2AUeCJxJoASvWXcWdfSyrmdPhAK6U7rSRhbctdzE4ldh5VGPmHO
         s2PweUJ4rj6IQKG8Xed+swdWTzALjdTEOTEXRhcCyBgr71pqAqFaoOyTu9WQH6vuXNS/
         236sIxInIOzPfcju7zLeLdX/2/e8GN3EX+IAuN4QCKiHwJ1jX2rdvnm15NpRcFlXbUe0
         0JLzSEwpgjfsgFJMIu4s5s4hc2H1GmVgYOkz9ozyD2HNqkY1XrmtjlfGo/c8VgDAZVfl
         VEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BeXoiUBzZvgGk5KhM0sX1cYz05NrTFzD5DM8ZErxb8o=;
        b=CSyAaymG6aK0Cp5XnDwKDueNdHaXdN7YKcblaHRczGzzH1N2raoAtF88kcMok6pK/J
         ub+xxZMqxHWDb8rNGAfB0PV2yqK8wMnIRcg+ej+5FEgDUZlZwfZu8EEB1WFdRaEyWdlJ
         bIFNbE4qsVfspDOcKWQoTXUFfmJV84Yqj4t1h28w/eNrpBUh7vVB0PAZkohN3UMpKln1
         twrkzhb28AOYJE+o1hDcVOI4PONlYhyJ2W2kaN5XGUSD2A5smWDQHZ8bXOFq0doMmdrt
         Yxxow5JyfGJydXlDmjqYsHnxn/LcgNwTDzhIWWWzdU++Cqh94hKaJeJ0LBXGpNjc7W9f
         RufQ==
X-Gm-Message-State: APjAAAX7ToYFOODKL9kFB//lgxqc7QoOCtb0zQG0iG6ujm8g4ThQFnMx
        xBriGgWc/A3axkQ/djPpTFBx6LkGRzE=
X-Google-Smtp-Source: APXvYqxgb3XYeOq1PzJaus9+5Fh/8qkRK5xRTJEAptm2CaEqv29Iq/ZJSI1PB+G6RwnY/1HuWTy9aQ==
X-Received: by 2002:ac2:5310:: with SMTP id c16mr7845014lfh.119.1562058459487;
        Tue, 02 Jul 2019 02:07:39 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 2sm3684904lji.94.2019.07.02.02.07.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 02:07:38 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>,
        Jakub Witowski <jakub.witowski@silvair.com>
Subject: [PATCH BlueZ v2 3/3] mesh: Handle messages encrypted with a remote device key
Date:   Tue,  2 Jul 2019 11:07:31 +0200
Message-Id: <20190702090731.30852-4-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190702090731.30852-1-michal.lowas-rzechonek@silvair.com>
References: <20190702090731.30852-1-michal.lowas-rzechonek@silvair.com>
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
index 0d44ea72e..e9b8a8ce2 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -39,6 +39,7 @@
 #include "mesh/dbus.h"
 #include "mesh/util.h"
 #include "mesh/model.h"
+#include "mesh/keyring.h"
 
 /* Divide and round to ceiling (up) to calculate segment count */
 #define CEILDIV(val, div) (((val) + (div) - 1) / (div))
@@ -368,6 +369,14 @@ static int dev_packet_decrypt(struct mesh_node *node, const uint8_t *data,
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
 
@@ -694,6 +703,47 @@ static int add_sub(struct mesh_net *net, struct mesh_model *mod,
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
@@ -842,10 +892,17 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
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

