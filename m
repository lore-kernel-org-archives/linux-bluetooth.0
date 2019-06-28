Return-Path: <SRS0=h1rX=U3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F86C5B57A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 12:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81391208C4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 12:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="R5VbXcai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfF1MwR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:52:17 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:54264 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfF1MwQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jun 2019 08:52:16 -0400
Received: by mail-wm1-f43.google.com with SMTP id x15so9014154wmj.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2019 05:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K7q/JlZvkGB3rYlSuacqZIyrUtdcq2NNde7Uwwmcao8=;
        b=R5VbXcaiNDKnP71IIaSetD9ewzCZdwCiAwTk4xUUBA/RGI9lZJTp1h/+s9aBPretyt
         9dI092NfHnAGY4FfQR6bcHL6WYR/7MWD+IRgs/Q/jGDIV2qy1fjs3emYmvJqAcVUpQQ+
         0QbmUbh6Ll+NL+vO+fRLqZu6dveTqW54KGLsyeU0cuY9GbSQR+vmpdITQ8wz97BGRS3Z
         7eQy18GyvTusXRrgHahmV77vjpQnqJ22UduvSH47jlZjCqAPmfnL6Y9NI9Sw8VxnRAJz
         HBsC4VrXRcPm1n09QsBUbHQfILLDhwPPXcgvs4+DPLshhbVtNPt3qroeSRT5Z/bD0trP
         k2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K7q/JlZvkGB3rYlSuacqZIyrUtdcq2NNde7Uwwmcao8=;
        b=UezpwzUnVZ5NpxOqofvpzEf5E320yNyQXmfkat0Ll256jEjWy8CkiulWQoRx7bW22t
         o+MIkorcxXb+GWojFFek4+8HvWgD3m/yfchkC+6TmJ1IRmN0tJRD7QbEd2VQeox+0ouF
         2TfVzWSHUbWbfFKjfLizIPYEgdYa76Q64C8CqLSeyg32FoLyZ7aVkTxzbZoZ7pTeZOco
         GIE3yqyKpVpsAjzeN2CTBuuNFHJzaJ0BlDJNkk+ftZcNsmfIgwX9YwqCVyGiMuEeRZkF
         hXyCB6fozJ5V38cBb2Gidjnzg/ihbcrXYepg449uddwGh78a/K9M0xeV4tMCVB+wYKgc
         5mhQ==
X-Gm-Message-State: APjAAAUZ6rStBiRp9A7dinmQt3hQMHntyjkflEQIiHpARSfLl9TVH3TR
        w/3Vpe+fBLInQU+wFXq9yM3YmXUy+Ok=
X-Google-Smtp-Source: APXvYqxBQEpyh8YpMBltzvzBHhuU0TjneLOycd6PJwkHYlppgacxie4hbjToP4qlY9EKtNYPAKfgWA==
X-Received: by 2002:a1c:305:: with SMTP id 5mr7522974wmd.101.1561726334264;
        Fri, 28 Jun 2019 05:52:14 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id y6sm2226484wmd.16.2019.06.28.05.52.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 05:52:13 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/3] mesh: Add DevKeySend call
Date:   Fri, 28 Jun 2019 14:52:04 +0200
Message-Id: <20190628125205.21411-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190628125205.21411-1-michal.lowas-rzechonek@silvair.com>
References: <20190628125205.21411-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/model.c |  7 +++++++
 mesh/node.c  | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/mesh/model.c b/mesh/model.c
index 6cd630aa9..f46cce7c1 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -956,6 +956,7 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t target,
 					const void *msg, uint16_t msg_len)
 {
 	uint8_t key_id;
+	uint8_t dev_key[16];
 	const uint8_t *key;
 
 	/* print_packet("Mod Tx", msg, msg_len); */
@@ -976,6 +977,12 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t target,
 
 		l_debug("(%x)", app_idx);
 		key_id = APP_ID_DEV;
+	} else if (app_idx == APP_IDX_DEV_REMOTE) {
+		if (!keyring_get_remote_dev_key(node, target, dev_key))
+			return false;
+
+		key_id = APP_ID_DEV;
+		key = dev_key;
 	} else {
 		key = appkey_get_key(node_get_net(node), app_idx, &key_id);
 		if (!key) {
diff --git a/mesh/node.c b/mesh/node.c
index a2ac747a1..5733cd4ff 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1969,6 +1969,52 @@ static struct l_dbus_message *send_call(struct l_dbus *dbus,
 	return reply;
 }
 
+static struct l_dbus_message *dev_key_send_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	struct mesh_node *node = user_data;
+	const char *sender, *ele_path;
+	struct l_dbus_message_iter iter_data;
+	struct node_element *ele;
+	uint16_t dst, net_idx, src;
+	uint8_t *data;
+	uint32_t len;
+	struct l_dbus_message *reply;
+
+	l_debug("DevKeySend");
+
+	sender = l_dbus_message_get_sender(msg);
+
+	if (strcmp(sender, node->owner))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
+
+	if (!l_dbus_message_get_arguments(msg, "oqqay", &ele_path, &dst,
+							&net_idx, &iter_data))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	ele = l_queue_find(node->elements, match_element_path, ele_path);
+	if (!ele)
+		return dbus_error(msg, MESH_ERROR_NOT_FOUND,
+							"Element not found");
+
+	src = node_get_primary(node) + ele->idx;
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len) ||
+					!len || len > MESH_MAX_ACCESS_PAYLOAD)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Incorrect data");
+
+	if (!mesh_model_send(node, src, dst, APP_IDX_DEV_REMOTE,
+				mesh_net_get_default_ttl(node->net), data, len))
+		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
+
+	reply = l_dbus_message_new_method_return(msg);
+	l_dbus_message_set_arguments(reply, "");
+
+	return reply;
+}
+
 static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
@@ -2075,6 +2121,9 @@ static void setup_node_interface(struct l_dbus_interface *iface)
 	l_dbus_interface_method(iface, "Send", 0, send_call, "", "oqqay",
 						"element_path", "destination",
 						"key", "data");
+	l_dbus_interface_method(iface, "DevKeySend", 0, dev_key_send_call,
+						"", "oqqay", "element_path",
+						"destination", "net", "data");
 	l_dbus_interface_method(iface, "Publish", 0, publish_call, "", "oqay",
 					"element_path", "model_id", "data");
 	l_dbus_interface_method(iface, "VendorPublish", 0, vendor_publish_call,
-- 
2.19.1

