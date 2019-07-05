Return-Path: <SRS0=EGv/=VC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83497C46499
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jul 2019 13:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57489218CA
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jul 2019 13:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ikbk7Kwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfGEN4v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jul 2019 09:56:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33382 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfGEN4v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jul 2019 09:56:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so9388399ljg.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2019 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gYqZQWFBnSWmODdHp1BWWyPKkli5q/Qwe7l3JvgHRKE=;
        b=ikbk7KwciydmXw7Dz7b+vXP9ECIhoe4M6sB1xgRkhjqAAFPUwJ8Kjp2YKp5GbuIV5A
         K4QMTx8eBnjVxxRCKUMdgXbcJwhJ3sD1xWyXmj6gSqsFTnQso3AQ3+/P2drCrP8kChmL
         g2/xGVCX14bZa/BkT1VknzToBFzXAePuxHyZ9eBAZ3qKZExIXwZwBz+OsRJ1C65rhkIH
         EGeOn9V4B/MtFZfIyMx5RzIbFknysD7CT1ytoeY/YXhPctoT5SS9nfLCuGuWIQZnFO2f
         IHk7r01ssNhVehJu1Hro0qbSborUj4kmIcK34vscQ40o+EU5nJF2EJcLq8Zf0GoDwwJY
         4kVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYqZQWFBnSWmODdHp1BWWyPKkli5q/Qwe7l3JvgHRKE=;
        b=EtsMDvcFJSEMy1Vn3MD1mV3oQrpqtDRt6qnSpfst1SfivdayqHEoOx0FO4iGQbh1fq
         /Bl+MgEEV9dRhuoEyqJGf9b2asJya+QYR76NVPW/qS2yKH+4Ifn/FrSEtUVMs4utkGHO
         ObUOQCeD9+cL5P8C6zzrmXKhRpIvJXc8r/AdUU/jn5SBdfLiZUTz1VapDuPqJ4uBekg4
         9Dc1csDGQ7Dm6ILFAr9R+T7s9KS/tttNiRMzagDvRJ+lllXIr5hbV4UrfyiHkZX5zadT
         /bkhkefBreoRd6Cz2PVOXeZCILRlTBWii+7zEJ3e94BZA4G2NXZsUcAw/p2prh2/vvRn
         hh3g==
X-Gm-Message-State: APjAAAVzLzpquYpsoaS95PiiRgnnMzUR4cIPN0IO8SEYJATb9v3c3h3V
        zZU50FRh706zVlkXz95uu+iF18cfL7w=
X-Google-Smtp-Source: APXvYqz3Zg3ujwOKkmVLqKckhBx/vRhbV+7ebSBzmLclf5S853onv1V/JaD2qkmlti20wHlNCQACmw==
X-Received: by 2002:a2e:86c3:: with SMTP id n3mr2373855ljj.129.1562335008267;
        Fri, 05 Jul 2019 06:56:48 -0700 (PDT)
Received: from kynes.internet.domowy (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id 133sm1544682lfi.90.2019.07.05.06.56.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 06:56:47 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/1] mesh: Check address range passed to ImportRemoteNode
Date:   Fri,  5 Jul 2019 15:56:34 +0200
Message-Id: <20190705135633.2013-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190705135633.2013-1-michal.lowas-rzechonek@silvair.com>
References: <20190705135633.2013-1-michal.lowas-rzechonek@silvair.com>
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

