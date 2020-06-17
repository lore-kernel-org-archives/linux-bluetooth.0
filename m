Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE998C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 20:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8662821532
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 20:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="tzW6WXH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgFQU1J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQU1I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 16:27:08 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38044C06174E
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 13:27:07 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id k8so3142548edq.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 13:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L11zMselXA31Ce45AwpHjwobbsEPgmwoCvPE/l7GZyM=;
        b=tzW6WXH2IVBywaiRxM+x7HovrsBYe8B10Isc8IQlvH+UheeEaEnb+vIUUA9/DPe9sB
         VcpXlZj4yupB4Ke/xmcgmcolQ65GU36lk8QVU6JH+na+hDPXECil2FZbH7xpS72UKSrJ
         fc9Uh4Ltz8IuxW80rwMqsK1e+atSAO3VvvziE7DFQTdl0NRKY8Ob0r8X2THR+BwXJlx2
         eh71YiTJxjuSaFhBfIgwbBylI8dtua/+iuUDsoom9Sqz6xun9l6YfV+vEE+kld39GxEB
         ZKsNSmjB0w9BZmDzYmBSgDnkZx6igXTog2Cop7BWIjinIIMji8S8i1P2X3Ees9QGOeTg
         iL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L11zMselXA31Ce45AwpHjwobbsEPgmwoCvPE/l7GZyM=;
        b=RNOD2THH60paQa0xesfR5JLEWGQF2SwNiwSG8d9Qr684ZLqDIlhcpKjYxVgS8JOcxj
         SwQDxC87PNFLZthuIajItvSBpLe8Br9tsDWdWTfbPLRAJzGLwQrtb6WLcr7RR3IutNJJ
         f3cbuZBOSQ5+hZXBvAPzPFL6bkZzL2/rcCMduCmzCzrDBxxgbIVi3cPGLYiy3Stw9K3D
         bNKj1Q0PJo2Bk94wLVo/wDOd8DINI49QaQG4GKhKUxoeitg+rAJ72eWNLNIT7ffC0pef
         v2HN5nKL1ty74/FoDmFIE+mCT1wPLTsx4lnZ0RZcBWR634PkE+2WtDUJgRY1PCU7U9AY
         HtKQ==
X-Gm-Message-State: AOAM530224a9VumYtmfJ7sKJsAhSOrF9IXsOW+iQw53Ta5vAa0dxxlQN
        FtRfum6n0TrZgooXztDd8wyPBYvFsu8=
X-Google-Smtp-Source: ABdhPJwCMsdJOZHK8JNcjN1E+McRdsW0fmUtOFbA2c93L0RnLGCB6+14xH3hoRXAjoktRiVRS0Fa5g==
X-Received: by 2002:aa7:d283:: with SMTP id w3mr926600edq.262.1592425625639;
        Wed, 17 Jun 2020 13:27:05 -0700 (PDT)
Received: from kynes.internet.domowy (apn-37-7-126-70.dynamic.gprs.plus.pl. [37.7.126.70])
        by smtp.gmail.com with ESMTPSA id lw11sm661727ejb.58.2020.06.17.13.27.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:27:05 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Replace BeaconFlags with just IvUpdate
Date:   Wed, 17 Jun 2020 22:26:57 +0200
Message-Id: <20200617202657.42474-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To import nodes, applications need just IvIndex and IvUpdate. KeyRefresh
phase in under provisioner's control, so we don't need to expose it.

Moreover, BeaconFlags property dealt just with the primary net key, and
each subnet key is refreshed separately.
---
 doc/mesh-api.txt |  8 ++++----
 mesh/node.c      | 12 ++++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 7fbab32b6..0f10a7c89 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -431,11 +431,11 @@ Properties:
 		This property indicates whether the periodic beaconing is
 		enabled (true) or disabled (false).
 
-	uint8 BeaconFlags [read-only]
+	boolean IvUpdate [read-only]
 
-		This property may be read at any time to determine the flag
-		field setting on sent and received beacons of the primary
-		network key.
+		When true, indicates that the network is in the middle of IV
+		Index Update procedure. This information is only useful for
+		provisioning.
 
 	uint32 IvIndex [read-only]
 
diff --git a/mesh/node.c b/mesh/node.c
index 6140fdf9f..87c3bb46f 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -32,6 +32,7 @@
 #include "mesh/mesh-defs.h"
 #include "mesh/mesh.h"
 #include "mesh/net.h"
+#include "mesh/net-keys.h"
 #include "mesh/appkey.h"
 #include "mesh/mesh-config.h"
 #include "mesh/provision.h"
@@ -2183,7 +2184,7 @@ static bool beacon_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
 	return true;
 }
 
-static bool beaconflags_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+static bool ivupdate_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
 					struct l_dbus_message_builder *builder,
 					void *user_data)
 {
@@ -2191,10 +2192,13 @@ static bool beaconflags_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
 	struct mesh_net *net = node_get_net(node);
 	uint8_t flags;
 	uint32_t iv_index;
+	bool ivu;
 
 	mesh_net_get_snb_state(net, &flags, &iv_index);
 
-	l_dbus_message_builder_append_basic(builder, 'y', &flags);
+	ivu = flags & IV_INDEX_UPDATE;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &ivu);
 
 	return true;
 }
@@ -2295,8 +2299,8 @@ static void setup_node_interface(struct l_dbus_interface *iface)
 	l_dbus_interface_property(iface, "Features", 0, "a{sv}", features_getter,
 									NULL);
 	l_dbus_interface_property(iface, "Beacon", 0, "b", beacon_getter, NULL);
-	l_dbus_interface_property(iface, "BeaconFlags", 0, "y",
-						beaconflags_getter, NULL);
+	l_dbus_interface_property(iface, "IvUpdate", 0, "b", ivupdate_getter,
+									NULL);
 	l_dbus_interface_property(iface, "IvIndex", 0, "u", ivindex_getter,
 									NULL);
 	l_dbus_interface_property(iface, "SequenceNumber", 0, "u",
-- 
2.26.0

