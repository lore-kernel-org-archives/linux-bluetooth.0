Return-Path: <SRS0=OoMZ=VO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6D6C7618F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 19:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C9621871
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 19:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="LRbA3lKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfGQTej (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jul 2019 15:34:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42235 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfGQTej (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jul 2019 15:34:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id t28so24793113lje.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2019 12:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SATHKW3kTIEVuaiD7imn7zESv44ddp26nFB1Wo3WSzo=;
        b=LRbA3lKnQhGmUBPzAdEpRJBwlNDGS048Xb9rENqkxdrLO4ZYzUNKyfN/5kSFJVhMmC
         2BU5NC7Hwhn8Nx588nk+c+Z3E4u6k35rl6NIbdoQd8JjhmMJ+1TAoREo8Sx+1ogSrdSW
         l8a01vjwjgBBB0YaPraGsI4+sO5SRB8A9gnhFPztjs1lLe9JAkNfLOmcxF6aYQ4LasMN
         WtrgIWE+VOCZRPZNp900p/Cezmhz+jLNx8LXSl6D/B7Za9UCVlW19RogGAQSknKjAz9c
         IO8kC31IRtmxYe/tG9hGnUJkZLto2jiCF4AjPVt7gDNUghvK6s59bQ9czmyx1Qox0P9m
         DTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SATHKW3kTIEVuaiD7imn7zESv44ddp26nFB1Wo3WSzo=;
        b=jhBlzfzoagcdtMru1LDET7U/S9Wc6ot4niSGoHQWH/BgQMGHwjg2M3JXBlwLqbHdHv
         YLjWv8pcBj5x34U+7fQr2272t5FXakn9YM9paQvbnQMDOo8gPF4c4rgL+voojns+1wiI
         Ec8wH90qr/mh+OF6kFCjfwMzJIRSSm36+By4WsWq/4JKnB5DFoipLHsB/XCQ67HtR0Jc
         nWGgSUrMtDEAk6Q2qWS0Bec0H2jDIVFbtg1H63MBjnlzOag1ik6ncEvDVQslwMfghy4G
         ZZrT9BycVlVrmDYdS5OwxIbWq+4gcUV0bgq240kGdp2FxJvbL7O++3MbjgqfOUf3qV35
         duvw==
X-Gm-Message-State: APjAAAXRPDAjpZL0okr6JAjV9PZXlBleQWhBixI0L/I2yW9fDpeQDJd7
        PlOpkgVtF/Uz0n9Bs0d/EZki/wnF/gA=
X-Google-Smtp-Source: APXvYqzYIt/dpY0gh3O4sKfPOXfhyMiBht0uNr3QznQcnj/vsu31xAM4FKnnQZvnwybqwei1SG0jNQ==
X-Received: by 2002:a2e:86c3:: with SMTP id n3mr22798551ljj.129.1563392076687;
        Wed, 17 Jul 2019 12:34:36 -0700 (PDT)
Received: from kynes.internet.domowy (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id t21sm4610468ljg.60.2019.07.17.12.34.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 12:34:35 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Check address range passed to ImportRemoteNode
Date:   Wed, 17 Jul 2019 21:34:29 +0200
Message-Id: <20190717193429.14155-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch disallows importing device key for:
 - non-unicast addresses
 - unicast addresses overlapping with local node address range
---
 doc/mesh-api.txt |  8 ++++++++
 mesh/keyring.c   | 11 +++++++++++
 mesh/manager.c   | 12 ++++++++++++
 3 files changed, 31 insertions(+)

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
index 3ea83194c..0b2474139 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -128,6 +128,9 @@ bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 	bool result = true;
 	int fd, i;
 
+	if (!IS_UNICAST(unicast) || !IS_UNICAST(unicast + count - 1))
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
 
+	if (!IS_UNICAST(unicast) || !IS_UNICAST(unicast + count - 1))
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
index 77d7b7516..564a848d1 100644
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
@@ -297,6 +298,11 @@ static struct l_dbus_message *import_node_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Bad device key");
 
+	if (mesh_net_is_local_address(net, primary) ||
+			mesh_net_is_local_address(net, primary + num_ele - 1))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED,
+					"Cannot overwrite local device key");
+
 	if (!keyring_put_remote_dev_key(node, primary, num_ele, key))
 		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
 
@@ -308,12 +314,18 @@ static struct l_dbus_message *delete_node_call(struct l_dbus *dbus,
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

