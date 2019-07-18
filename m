Return-Path: <SRS0=wIos=VP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34430C76191
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 08:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38722173E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 08:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="QvYoR3f3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfGRIxg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:53:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45429 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfGRIxg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jul 2019 04:53:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id u10so18585285lfm.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2019 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ma+e+XBhIyOIPTXl4W+lCv/gcwtMtCurk/0BcEXio/w=;
        b=QvYoR3f3MNIBk4jMzsNaZvx4YUIODixaEu49D9BHwDoGjbR7S4bJ5neCyhpVr21WZH
         PTQK4cPd91rU/7y2v2o4pkisbWKCtHTqcZLpI+SvjvP8ROgv92euM2jWX1efjuzi5Bhs
         a5uOrHYNxRqj/JhFnBg3drTF1wgbvr+mPSnwqxeEPzFjdOYzY+5CrKzIDGNfkow2itQB
         Aa7Dv4LnQeAo6gSNOIzSMrTOFweuWLZXiTcBax8xLFzw5+nXwhcmigDFosyjkgMlq9iZ
         bprtwYC+r1NqZvIcOhf9eRL6GT8aPAVt9ZQAQS2Wz0OrboI+u/U+2ci6lq5Tifwd+arJ
         HAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ma+e+XBhIyOIPTXl4W+lCv/gcwtMtCurk/0BcEXio/w=;
        b=s2QvbXv8LBjYtgl8QVbPLXnO/RJGSGaMrBOomW76D6vzfnQR7F5iiDfYWwu2leLh2z
         KB2rFZSSaewc0sgU6Szjp75npCD+lmTB4yhk3v42vcJQrajdDd1sWqWyX1/bjT8D4rMD
         sItmyff5Dy8DU1ApL0+UuJZ9mZat4t0lz8ewknhkkYXuIsVoyo/KHmNl4RZh8kH3mqzF
         kdnkb1D3FYYBG2CXGa8aKzWew3qkGCtN+EyRbFxTkdNy7Lbws2jMeT4gw1Zbr5oluLft
         q0bdN9P0qQb5VS7odRS26va9+VB+JZrT39F41bIp8d/h4glZe7Tgtg5A5NSbnpKSq9Jq
         pRGA==
X-Gm-Message-State: APjAAAVTIxz4SRnB+TFmine05e4uBTb60W0dOVMj+/m5gRYHmCSmAyM1
        bCLz4R719WbLhfvkfICMbySePfeKmG4=
X-Google-Smtp-Source: APXvYqxydB+baXO30ATNVMTSgR0wF9mDNGZemMI5Fz+iVKlXDaaohx2sGt4hVox+Nfu3WwNAU2YKaw==
X-Received: by 2002:a19:7509:: with SMTP id y9mr20375796lfe.117.1563440013163;
        Thu, 18 Jul 2019 01:53:33 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id q22sm5027573lje.75.2019.07.18.01.53.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 01:53:32 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] mesh: Check address range passed to ImportRemoteNode
Date:   Thu, 18 Jul 2019 10:53:27 +0200
Message-Id: <20190718085327.9598-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+added macro to check unicast ranges
+changed mesh_net_is_local_address to accept address ranges

---

This patch prevents the applicaton from managing device keys for:
 - non-unicast addresses
 - unicast addresses overlapping with local node address range
---
 doc/mesh-api.txt |  8 ++++++++
 mesh/keyring.c   | 11 +++++++++++
 mesh/manager.c   | 10 ++++++++++
 mesh/mesh-defs.h |  1 +
 mesh/model.c     |  2 +-
 mesh/net.c       |  7 +++++--
 mesh/net.h       |  3 ++-
 7 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 7c2a1fafa..e5d246ae4 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -607,9 +607,13 @@ Methods:
 
 		This call affects the local bluetooth-meshd key database only.
 
+		It is an error to call this with address range overlapping
+		with local element addresses.
+
 		PossibleErrors:
 			org.bluez.mesh.Error.Failed
 			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.NotAuthorized
 
 	void DeleteRemoteNode(uint16 primary, uint8 count)
 
@@ -624,8 +628,12 @@ Methods:
 
 		This call affects the local bluetooth-meshd key database only.
 
+		It is an error to call this with address range overlapping
+		with local element addresses.
+
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.NotAuthorized
 
 Properties:
 	dict Features [read-only]
diff --git a/mesh/keyring.c b/mesh/keyring.c
index 3ea83194c..4b3d8b296 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -128,6 +128,9 @@ bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 	bool result = true;
 	int fd, i;
 
+	if (!IS_UNICAST_RANGE(unicast, count))
+		return false;
+
 	if (!node)
 		return false;
 
@@ -218,10 +221,14 @@ bool keyring_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 	bool result = false;
 	int fd;
 
+	if (!IS_UNICAST(unicast))
+		return false;
+
 	if (!node)
 		return false;
 
 	node_path = node_get_storage_dir(node);
+
 	snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path, dev_key_dir,
 								unicast);
 
@@ -280,10 +287,14 @@ bool keyring_del_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 	char key_file[PATH_MAX];
 	int i;
 
+	if (!IS_UNICAST_RANGE(unicast, count))
+		return false;
+
 	if (!node)
 		return false;
 
 	node_path = node_get_storage_dir(node);
+
 	for (i = 0; i < count; i++) {
 		snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path,
 						dev_key_dir, unicast + i);
diff --git a/mesh/manager.c b/mesh/manager.c
index 77d7b7516..410e5e1c1 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -282,6 +282,7 @@ static struct l_dbus_message *import_node_call(struct l_dbus *dbus,
 						void *user_data)
 {
 	struct mesh_node *node = user_data;
+	struct mesh_net *net = node_get_net(node);
 	struct l_dbus_message_iter iter_key;
 	uint16_t primary;
 	uint8_t num_ele;
@@ -297,6 +298,10 @@ static struct l_dbus_message *import_node_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Bad device key");
 
+	if (mesh_net_is_local_address(net, primary, num_ele))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED,
+					"Cannot overwrite local device key");
+
 	if (!keyring_put_remote_dev_key(node, primary, num_ele, key))
 		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
 
@@ -308,12 +313,17 @@ static struct l_dbus_message *delete_node_call(struct l_dbus *dbus,
 						void *user_data)
 {
 	struct mesh_node *node = user_data;
+	struct mesh_net *net = node_get_net(node);
 	uint16_t primary;
 	uint8_t num_ele;
 
 	if (!l_dbus_message_get_arguments(msg, "qy", &primary, &num_ele))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
+	if (mesh_net_is_local_address(net, primary, num_ele))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED,
+					"Cannot remove local device key");
+
 	keyring_del_remote_dev_key(node, primary, num_ele);
 
 	return l_dbus_message_new_method_return(msg);
diff --git a/mesh/mesh-defs.h b/mesh/mesh-defs.h
index 79b38c56c..5cabf22c1 100644
--- a/mesh/mesh-defs.h
+++ b/mesh/mesh-defs.h
@@ -85,6 +85,7 @@
 #define IS_UNASSIGNED(x)	((x) == UNASSIGNED_ADDRESS)
 #define IS_UNICAST(x)		(((x) > UNASSIGNED_ADDRESS) && \
 					((x) < VIRTUAL_ADDRESS_LOW))
+#define IS_UNICAST_RANGE(x, c)	(IS_UNICAST(x) && IS_UNICAST(x + c - 1))
 #define IS_VIRTUAL(x)		(((x) >= VIRTUAL_ADDRESS_LOW) && \
 					((x) <= VIRTUAL_ADDRESS_HIGH))
 #define IS_GROUP(x)		((((x) >= GROUP_ADDRESS_LOW) && \
diff --git a/mesh/model.c b/mesh/model.c
index 785becb5f..5dd469e0d 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -883,7 +883,7 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 						forward.data);
 			else if (decrypt_idx == APP_IDX_DEV_REMOTE ||
 				(decrypt_idx == APP_IDX_DEV_LOCAL &&
-				 mesh_net_is_local_address(net, src)))
+				 mesh_net_is_local_address(net, src, 1)))
 				send_dev_key_msg_rcvd(node, i, src, 0,
 						forward.size, forward.data);
 		}
diff --git a/mesh/net.c b/mesh/net.c
index f7f37675b..b73d668a9 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -3880,12 +3880,15 @@ bool mesh_net_have_key(struct mesh_net *net, uint16_t idx)
 						L_UINT_TO_PTR(idx)) != NULL);
 }
 
-bool mesh_net_is_local_address(struct mesh_net *net, uint16_t addr)
+bool mesh_net_is_local_address(struct mesh_net *net, uint16_t src,
+								uint16_t count)
 {
+	const uint16_t last = src + count - 1;
 	if (!net)
 		return false;
 
-	return (addr >= net->src_addr && addr <= net->last_addr);
+	return (src >= net->src_addr && src <= net->last_addr) &&
+			(last >= net->src_addr && last <= net->last_addr);
 }
 
 void mesh_net_set_window_accuracy(struct mesh_net *net, uint8_t accuracy)
diff --git a/mesh/net.h b/mesh/net.h
index 7e6af8714..80b561d42 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -358,7 +358,8 @@ uint32_t mesh_net_friend_timeout(struct mesh_net *net, uint16_t addr);
 struct mesh_io *mesh_net_get_io(struct mesh_net *net);
 struct mesh_node *mesh_net_node_get(struct mesh_net *net);
 bool mesh_net_have_key(struct mesh_net *net, uint16_t net_idx);
-bool mesh_net_is_local_address(struct mesh_net *net, uint16_t addr);
+bool mesh_net_is_local_address(struct mesh_net *net, uint16_t src,
+							uint16_t count);
 void mesh_net_set_window_accuracy(struct mesh_net *net, uint8_t accuracy);
 void mesh_net_transmit_params_set(struct mesh_net *net, uint8_t count,
 							uint16_t interval);
-- 
2.19.1

