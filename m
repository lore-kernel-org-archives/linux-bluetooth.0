Return-Path: <SRS0=CMXm=WX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7343C3A5A6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Aug 2019 09:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE00B217F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Aug 2019 09:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="DNNHxFVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfH0JI5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:08:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45656 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfH0JIx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Aug 2019 05:08:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id o11so5228732lfb.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2019 02:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mBWlxPv3SyNRdklua5LMHZ7eiLQGX+jT/i5pt/8PUPs=;
        b=DNNHxFVngVsIftWZO1Wi+/+raXeQUznAFpyguRbPpSCuKmKS8AbZPGytuYBuYBKl3W
         aMewT+92Ii5D2M2mgIb4nH1n833bSjBIQ1y7hYLunUlkFoB8P80kQdPIrPcecOJHCODs
         yNiGEE52Nqo5xfBYx+DI6zKXAHuRnycenB/JyMHyrPNfJ6YpDv0Q2hkq4JbdWbvSbuK/
         33nYNez++yW6Yr/G4OmeTIIFA5npZaT2+2qR2jJh0rF9sKZ3DKgDC5G0DuhbJ8porV84
         htapXfrSeQ7TPKG6MdGliO3ClAIeuPP5z8Koees6rQAjgyu3KoyoUi73QxpRVlNxJq1Y
         Vttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBWlxPv3SyNRdklua5LMHZ7eiLQGX+jT/i5pt/8PUPs=;
        b=RZjqTG9h/xHpN+39FqcMCpXnQ9/xGI5tmXqBwm59AcLvy7YDLXRZsiPNfhbLcul+WT
         /xWUJymSvPbsj131HPFkUpS1LOSuy44mKp1PtRqF5H5iQ/18P514+6kkk/iQmIzXAFx+
         KOjWMGRNqsneb/+YwPpEaZC6UcdAl20/3cyPOE59LO2zyRhNFiyJraf4iIW4h11uKJo5
         p4zQBvkNcjm8mmVH046RRxdLTQLA7wawYdWEjPxrA0pMeXNcp6pA/UOD6lvMCkvAT99N
         JGipfWeGWrZBG0M9jWJTiKt+yYbkXGDhxlPU9IqlP/6XPmGo/iuGj4JfrqJ1X45iFa3H
         PTLg==
X-Gm-Message-State: APjAAAVjxFRnInw2EQXGpZ4Tn/Kjbin5QwUjFkpjk2pzMnTPnTVmtyN5
        F1TGKkex6+spbVRhtTlWS+8NuzloHEs=
X-Google-Smtp-Source: APXvYqz4pSFkoV11U9cT4KPCHkSqnNwPcaO6d8DAFFoAcEWMmrsxuud6lr5BnGJx0o1Ofbc/H3FIAQ==
X-Received: by 2002:ac2:54a3:: with SMTP id w3mr13928700lfk.169.1566896931558;
        Tue, 27 Aug 2019 02:08:51 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id v2sm2525625lfb.88.2019.08.27.02.08.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 02:08:51 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] mesh: Add properties to Node1 interface
Date:   Tue, 27 Aug 2019 11:08:44 +0200
Message-Id: <20190827090844.21394-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190827090844.21394-1-michal.lowas-rzechonek@silvair.com>
References: <20190827090844.21394-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/mesh-api.txt |  9 +++++++++
 mesh/node.c      | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 255104ab6..b639ae719 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -423,6 +423,15 @@ Properties:
 		seconds since mesh network layer traffic was last detected on
 		this node's network.
 
+	array{uint16} Addresses [read-only]
+
+		This property contains unicast addresses node's elements.
+
+	uint32 SequenceNumber [read-only]
+
+		This property may be read at any time to determine currently
+		used sequence number.
+
 Mesh Provisioning Hierarchy
 ============================
 Service		org.bluez.mesh
diff --git a/mesh/node.c b/mesh/node.c
index 3d9ded3b1..789759b6f 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -2198,6 +2198,40 @@ static bool lastheard_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
 
 }
 
+static bool addresses_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct mesh_node *node = user_data;
+	const struct l_queue_entry *entry;
+
+	l_dbus_message_builder_enter_array(builder, "q");
+
+	entry = l_queue_get_entries(node->elements);
+	for (; entry; entry = entry->next) {
+		const struct node_element *ele = entry->data;
+		uint16_t address = node->primary + ele->idx;
+
+		l_dbus_message_builder_append_basic(builder, 'q', &address);
+	}
+
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static bool seqnumber_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct mesh_node *node = user_data;
+	uint32_t seq_number = node_get_sequence_number(node);
+
+	l_dbus_message_builder_append_basic(builder, 'u', &seq_number);
+
+	return true;
+}
+
 static void setup_node_interface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "Send", 0, send_call, "", "oqqay",
@@ -2222,6 +2256,10 @@ static void setup_node_interface(struct l_dbus_interface *iface)
 									NULL);
 	l_dbus_interface_property(iface, "SecondsSinceLastHeard", 0, "u",
 					lastheard_getter, NULL);
+	l_dbus_interface_property(iface, "Addresses", 0, "aq", addresses_getter,
+									NULL);
+	l_dbus_interface_property(iface, "SequenceNumber", 0, "u",
+							seqnumber_getter, NULL);
 }
 
 bool node_dbus_init(struct l_dbus *bus)
-- 
2.19.1

