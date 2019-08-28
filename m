Return-Path: <SRS0=N1M0=WY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F86C41514
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Aug 2019 07:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2708D217F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Aug 2019 07:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="aGu6Xh5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfH1Hwk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:52:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56207 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfH1Hwk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Aug 2019 03:52:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id f72so1648653wmf.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2019 00:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6UXK87BkdhlK8VCXwHdWa+PKYSVBxV3vuoTw5X/CtMs=;
        b=aGu6Xh5trDkWtqvyP3YGKKjpBTm1RSkPLoGGkzbkw/eqT40U2RDZ558TTt1i1RopwH
         Ci17IjeG4U7IqCC06rbvL/YqZh44+tdpTtJqO9qS7izsMfYYQHwkESpTwN6E6jxLWPTY
         FxnkudLhd6hn403PIc8YtqopYYgPm0JkKo1SVUIv3Vve5FXAD7HBZ1nZayfRTa8MJMds
         A/jros3S9OmA5Ok4ZyhVs+bcnxSoNVibBteGLY1MiQ3u0x/BV3HH9boFMsOxhrbZBESJ
         JvHkOoR2BDEnjydwNQwXW1vLzv54PHWA/9rlH4FEq7SxqEjACBGlsqp4XhLM8tNa3UN7
         LN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6UXK87BkdhlK8VCXwHdWa+PKYSVBxV3vuoTw5X/CtMs=;
        b=ker37Y4K0YQv+HH30xVWmhuffHEDH0NfSq7GZhtl5p0WfQx+JXwm2uLIXo4qwS55Xk
         ESAKZIgRNcp+jI4b7bGl86xVVuL5V76K8nt/GP1Myw/AjKOWTO0RZ7hq6O3Yn7YFZYr+
         syuiDErho6omiQRi30fJB+1P5dgxUBjiI+9nopxwdiHopbxaTKdQpf3U1tFPZwt3y0mL
         vP/6QPFfAyzTcx98PZsfpV9SGikkuKOTDZKvW+qaVVrmgceI5jnXsPmWr9yVZRF8Wrk1
         tuvuhfpxxbyfK/xqNFLK9x5metnKLdcrh+4RdLhVKPMtaA9tQ9O2hcYujZB7t21vtmfL
         dJHA==
X-Gm-Message-State: APjAAAUkhkO8Au74Sxs+zrXr0902C7xmHETXA2ZCQNqwN4KfpX18QAml
        wlmO/vYMNbBhl4SA6DzUdRjUQ8rXBJ4=
X-Google-Smtp-Source: APXvYqxSXGVJcVePX+pecVpGW0w5xVQDLRb02j0pBQibJbshpLmgYI4lFziynlRhoLPO5RX32ISiaQ==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr3062972wmk.97.1566978757743;
        Wed, 28 Aug 2019 00:52:37 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id t7sm206958wrr.37.2019.08.28.00.52.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:52:37 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] mesh: Add org.bluez.mesh.Node1.Addresses property
Date:   Wed, 28 Aug 2019 09:52:30 +0200
Message-Id: <20190828075230.21594-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190828075230.21594-1-michal.lowas-rzechonek@silvair.com>
References: <20190828075230.21594-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To enable applications to talk to the local node's internal models, it's
useful to know its unicast addresses. They are known after CreateNetwork
and Import, but after Join, the allocated address is only known to the
provisioner.

This patch enables read only access to list of allocated unicast
addresses.
---
 doc/mesh-api.txt |  4 ++++
 mesh/node.c      | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 255104ab6..470751f7a 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -423,6 +423,10 @@ Properties:
 		seconds since mesh network layer traffic was last detected on
 		this node's network.
 
+	array{uint16} Addresses [read-only]
+
+		This property contains unicast addresses of node's elements.
+
 Mesh Provisioning Hierarchy
 ============================
 Service		org.bluez.mesh
diff --git a/mesh/node.c b/mesh/node.c
index 3d9ded3b1..b6824f505 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -2198,6 +2198,28 @@ static bool lastheard_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
 
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
 static void setup_node_interface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "Send", 0, send_call, "", "oqqay",
@@ -2222,6 +2244,8 @@ static void setup_node_interface(struct l_dbus_interface *iface)
 									NULL);
 	l_dbus_interface_property(iface, "SecondsSinceLastHeard", 0, "u",
 					lastheard_getter, NULL);
+	l_dbus_interface_property(iface, "Addresses", 0, "aq", addresses_getter,
+									NULL);
 }
 
 bool node_dbus_init(struct l_dbus *bus)
-- 
2.19.1

