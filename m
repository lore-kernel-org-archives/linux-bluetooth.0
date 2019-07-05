Return-Path: <SRS0=EGv/=VC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6620C5B57D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jul 2019 09:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3C1218C5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jul 2019 09:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="fP4cwTMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfGEJOa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:14:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38532 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbfGEJO3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jul 2019 05:14:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so8567558ljg.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2019 02:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRNXJW3DzFD6ypBMksXKAsmnFfaqMpPS2E8zTgsbknA=;
        b=fP4cwTMjin8t0MHV7x/OMlkL8soqDO5DdrH5vU59eP1YzW6N7zyZy1IjdCEQoQ6f6f
         QmAcUmQ2r57/wLOL5+dn/Gs25SOsecfQh+ykKFu8PuhY0OtnKdBlGtBdr9McTBu4daxs
         4LtM38SDl/uWjw26lCMEFy/epaSjWta6O0SySKOHXMR94Eq1jjJTDksXg0Wi64bAM/pR
         EVQdxhgE5Hd5Tbu1GYUcIZ5rmnBmtg1eer0kaUcWacv2A5doBQg/QgWZ69h3nOiUyovg
         6oC+8AwVLF6WT4QnmbXKvT184/5uV1Z3ViFzewBmOBNdjGsYT98gNNVoJzgjx9sXLT9A
         RaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRNXJW3DzFD6ypBMksXKAsmnFfaqMpPS2E8zTgsbknA=;
        b=AAZy/6oDCa9qdYPIdAHQwVQwzeHV1SlrlRE6fxtAwqx/gh6ZDuENoGWvA7hyZ2S/Z7
         U/iYzA5QEgU7Az1Pafo3abTjgJFNnWGJfWDlv7vTg74gEs6abLfCqTdJ3wG4g6h8Ia1L
         KVXuXjiXM04JCirh/ki2KbKW8KM3SDSC+lYSJNLI2myVafDY+ujyuPka7nXxkA74kaUK
         5u/YbID6+nArAVhB0J87JtYDnEIlrZY48jyuZWGBL6z41AdjkjE0rbsCcFl0XvaLf90H
         PJiEgD0KWYLW5Blzrjnbl9bwySAQMZfiwsWumAtJbq39KCBT+8TDutZ3rqdEvSAHRuh0
         07tA==
X-Gm-Message-State: APjAAAURcZCpkR5uMgW0gtqG28uIuWOGKaT+EPg5uRDtiiErTj9Z0s7K
        91xbMpOZKe8jzDP23nPBci71fRVvXY8=
X-Google-Smtp-Source: APXvYqy31ioI3oVyEKmEB1Q6qkXTHHbKqf/ojNHwj8FgecF+yZaFu0Us59lSm8afJK42ZoELdDaNjg==
X-Received: by 2002:a2e:96d5:: with SMTP id d21mr1604690ljj.170.1562318066656;
        Fri, 05 Jul 2019 02:14:26 -0700 (PDT)
Received: from kynes.internet.domowy ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id e13sm1671106ljg.102.2019.07.05.02.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 02:14:26 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Micha=C5=82=20=27Khorne=27=20Lowas-Rzechonek?= 
        <michal@rzechonek.net>
Subject: [PATCH BlueZ] mesh: Check address range passed to ImportRemoteNode
Date:   Fri,  5 Jul 2019 11:14:17 +0200
Message-Id: <20190705091417.28866-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Michał 'Khorne' Lowas-Rzechonek <michal@rzechonek.net>

This patch disallows importing device key for:
 - non-unicast addresses
 - unicast addresses overlapping with local node address range
---
 doc/mesh-api.txt |  8 ++++++++
 mesh/keyring.c   |  9 +++++++++
 mesh/manager.c   | 13 +++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index f2ba164a9..4fa2f9690 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -609,9 +609,13 @@ Methods:
 
 		This call affects the local bluetooth-meshd key database only.
 
+		It is an error to call this with address range overlapping
+		with local element addresses.
+
 		PossibleErrors:
 			org.bluez.mesh.Error.Failed
 			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.NotAuthorized
 
 	void DeleteRemoteNode(uint16 primary, uint8 count)
 
@@ -626,8 +630,12 @@ Methods:
 
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
index 4c6d2986d..be17fb8a5 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -131,6 +131,9 @@ bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 	if (!node)
 		return false;
 
+	if (!IS_UNICAST(unicast) || !IS_UNICAST(unicast + count - 1))
+		return false;
+
 	node_path = node_path_get(node);
 
 	if (strlen(node_path) + strlen(dev_key_dir) + 1 + 4 >= PATH_MAX)
@@ -221,6 +224,9 @@ bool keyring_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 	if (!node)
 		return false;
 
+	if (!IS_UNICAST(unicast))
+		return false;
+
 	node_path = node_path_get(node);
 	snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path, dev_key_dir,
 								unicast);
@@ -283,6 +289,9 @@ bool keyring_del_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 	if (!node)
 		return false;
 
+	if (!IS_UNICAST(unicast) || !IS_UNICAST(unicast + count - 1))
+		return false;
+
 	node_path = node_path_get(node);
 	for (i = 0; i < count; i++) {
 		snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path,
diff --git a/mesh/manager.c b/mesh/manager.c
index ca3562512..d3c4b2e21 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -31,6 +31,7 @@
 #include "mesh/node.h"
 #include "mesh/keyring.h"
 #include "mesh/manager.h"
+#include "mesh/net.h"
 
 static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
@@ -60,6 +61,7 @@ static struct l_dbus_message *import_node_call(struct l_dbus *dbus,
 						void *user_data)
 {
 	struct mesh_node *node = user_data;
+	struct mesh_net *net = node_get_net(node);
 	struct l_dbus_message_iter iter_key;
 	uint16_t primary;
 	uint8_t num_ele;
@@ -75,6 +77,11 @@ static struct l_dbus_message *import_node_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Bad device key");
 
+	if (mesh_net_is_local_address(net, primary) ||
+			mesh_net_is_local_address(net, primary + num_ele - 1))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED,
+					"Cannot overwrite local device key");
+
 	if (!keyring_put_remote_dev_key(node, primary, num_ele, key))
 		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
 
@@ -86,12 +93,18 @@ static struct l_dbus_message *delete_node_call(struct l_dbus *dbus,
 						void *user_data)
 {
 	struct mesh_node *node = user_data;
+	struct mesh_net *net = node_get_net(node);
 	uint16_t primary;
 	uint8_t num_ele;
 
 	if (!l_dbus_message_get_arguments(msg, "qy", &primary, &num_ele))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
+	if (mesh_net_is_local_address(net, primary) ||
+			mesh_net_is_local_address(net, primary + num_ele - 1))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED,
+					"Cannot remove local device key");
+
 	keyring_del_remote_dev_key(node, primary, num_ele);
 
 	return l_dbus_message_new_method_return(msg);
-- 
2.22.0

