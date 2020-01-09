Return-Path: <SRS0=NtgA=26=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99F5C33CA1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 08:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD992067D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 08:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="PoF8DYt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgAIIjE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:39:04 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:37980 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgAIIjE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 03:39:04 -0500
Received: by mail-lf1-f44.google.com with SMTP id r14so4558407lfm.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jan 2020 00:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hGW6uQ6pZvqEoYxkVJEfXUFMgiT2O6k17c3VAbzBRlg=;
        b=PoF8DYt61U8KN7u1wrLTWRFfgJaA+yyyakQoCqEGAUI+ogmd18ch7frqSXDndVYzwo
         CiwkBLDOnF37inA19TJ5gIf5aCIXIS+3WpjaPUKODoo8c04A793b99WBLrF5e8kjxYZL
         EcTfq/rmqsQdlaeDWQVRCsQc8kGqaBwZPS4Ag891gDy6Twqo/tYI1DAzz7YIkScICtAj
         xiUOru/WpRhMAn9f6fBcwkBHd0nh0UNzp3FdR1UQbEwnTqt/ox3m5HVf71iuhi+4BncZ
         olqPyOYtTbs035qQlTTgBL/tPZepGqVSr8mV0ea8pQeMKE6OW6PjB+OonMqRKfZwN5h7
         sNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hGW6uQ6pZvqEoYxkVJEfXUFMgiT2O6k17c3VAbzBRlg=;
        b=oAKUj7boFNC5ZoIEegP5Z6cwwO39AEQMLeOFJJfaZ1BXJ8ZZc4oBB9N092ZhHnWbsX
         ZGQEntrzWKRfJ81VQp2sasFjspKZFzDAMlMpHX4/09sUjLzATz5jOkK+K8JxjqXZkU9v
         ssZbFemrghodg/J7M0m3myjkgUX5eozPCujTLNUG5TSqS8K2D4C5p1OXB3gh3k3PW6q7
         6yIws5SblYTw7Qzzc2ZZbkMBS26Pax3pIOLNnFfKgp2s6b2yvMEyOYi+3n5bNbeyJD4T
         MQIuk3x9Pfhi1vq6AkrN6m1nOc3Y73D8E3ooV4cAfJyRKVwvVJ6eF9589t6XlN5GdTZ2
         DOJQ==
X-Gm-Message-State: APjAAAVThDcxq4iAngrRNHsyPLsZhshNtUbxvCtS+0XNeLhAebTAQ4g4
        pJ2daJLiPqqC7onvPejOeYWBgdkYelA=
X-Google-Smtp-Source: APXvYqwmtVnkQ9YCLS9PWNAwvAQPbb125Q3t2kG6pKO6SI8ZVawTRUk4coUtCptqsOqqrx6iGFucwg==
X-Received: by 2002:a19:7604:: with SMTP id c4mr5660265lff.101.1578559141953;
        Thu, 09 Jan 2020 00:39:01 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id b22sm2930456lji.99.2020.01.09.00.39.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 00:39:01 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 2/2] mesh: Change BeaconFlags property type to a dict
Date:   Thu,  9 Jan 2020 09:38:55 +0100
Message-Id: <20200109083855.16000-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200109083855.16000-1-michal.lowas-rzechonek@silvair.com>
References: <20200109083855.16000-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Instead of a binary value, return a dictionary consistent with
"flags" argument used in Import().
---
 doc/mesh-api.txt | 18 ++++++++++++++----
 mesh/node.c      | 13 +++++++++++--
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index b33c24e12..33077bcfc 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -432,11 +432,21 @@ Properties:
 		This property indicates whether the periodic beaconing is
 		enabled (true) or disabled (false).
 
-	uint8 BeaconFlags [read-only]
+	dict BeaconFlags [read-only]
 
-		This property may be read at any time to determine the flag
-		field setting on sent and received beacons of the primary
-		network key.
+		This property may be read at any time to determine the flags
+		used in network beacons of the primary network key. Supported
+		values are:
+
+			boolean IvUpdate
+
+				When true, indicates that the network is in the
+				middle of IV Index Update procedure.
+
+			boolean KeyRefresh
+
+				When true, indicates that the network is in the
+				middle of a key refresh procedure.
 
 	uint32 IvIndex [read-only]
 
diff --git a/mesh/node.c b/mesh/node.c
index 0ad935105..0e28c650b 100644
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
@@ -2233,10 +2234,18 @@ static bool beaconflags_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
 	struct mesh_net *net = node_get_net(node);
 	uint8_t flags;
 	uint32_t iv_index;
+	bool ivu;
+	bool kr;
 
 	mesh_net_get_snb_state(net, &flags, &iv_index);
 
-	l_dbus_message_builder_append_basic(builder, 'y', &flags);
+	ivu = flags & IV_INDEX_UPDATE;
+	kr = flags & KEY_REFRESH;
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	dbus_append_dict_entry_basic(builder, "IvUpdate", "b", &ivu);
+	dbus_append_dict_entry_basic(builder, "KeyRefresh", "b", &kr);
+	l_dbus_message_builder_leave_array(builder);
 
 	return true;
 }
@@ -2337,7 +2346,7 @@ static void setup_node_interface(struct l_dbus_interface *iface)
 	l_dbus_interface_property(iface, "Features", 0, "a{sv}", features_getter,
 									NULL);
 	l_dbus_interface_property(iface, "Beacon", 0, "b", beacon_getter, NULL);
-	l_dbus_interface_property(iface, "BeaconFlags", 0, "b",
+	l_dbus_interface_property(iface, "BeaconFlags", 0, "a{sv}",
 						beaconflags_getter, NULL);
 	l_dbus_interface_property(iface, "IvIndex", 0, "u", ivindex_getter,
 									NULL);
-- 
2.19.1

