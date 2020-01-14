Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977C2C33CB3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 11:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8B024679
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 11:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="tLTiGehs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgANLtZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:49:25 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:37289 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgANLtZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 06:49:25 -0500
Received: by mail-lf1-f53.google.com with SMTP id b15so9580073lfc.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 03:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vR5T9kiBJOuiNv/ad0Ac6pxMIt2jlwazlEJaOlRR0p0=;
        b=tLTiGehs3ftJD5DQEKbtUEa3Lrg8J8QyN2oEnTmGyhvsQRGEINrZyUmSuPVw3GJtg5
         nGmr5mbAtys0HIupPmKQtROn+TO2jQWBPNwYYf7NRUGZ/QLiY+89FLAFfJrywFoGZkDk
         eBuOU6zJy6jI+9MJA1YiKQTtgO6rvXVyFEDxlUn5exvXlotGtRMZFKiIKMqOhjyt6UDM
         sEfaH90NHQJy9hrf0E5osk6655V7VpFfz3rwMB5Qt3AyuLAfuWEDpsaXVAZZUrMN9hdB
         mAEZTm+loxJJx/FZb92muRZA23TrTldKoogMDtu9i6rZB70Sma6GmXPYlyNINurM+GEx
         sGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vR5T9kiBJOuiNv/ad0Ac6pxMIt2jlwazlEJaOlRR0p0=;
        b=B/WYfLdkr6F3jlRX8dhE6+i8kzzTrkAA/UCD18z+OIDnSJQB33t/aKFXZtK96QqltU
         +0xLp8eVIvEs4c1rnIBserUSMzkwkyZH9LCj0q4VVRcOktcmum6ytnwgFlFUE7O0qfLV
         9/vHxVK66iFEJXRObyvGh8BMEmCOcMa+AnF/3oHxdtcr3eU4Jsi9hmgcd2xC7sbf0bip
         a32M2HSNFSkTLCW7CI4hhVi0DbnYJ5AaOOIA40jrGAwW1Efo8J/ClBOjO87HUjv5+jlR
         p19yYAHcvjKZaGrMjYTHkVJMY5keHYgybitGGMRtVJF0iDYS3ClS81c/TWAUpywmueSE
         hFJA==
X-Gm-Message-State: APjAAAVmkyzQjQwr4p1kaQ2mJdD+FjCq9fv371RtZ4/eY2AexHUz+ixQ
        r/R5DJL7qIacheFXhc0CZij7MozjKHsvYg==
X-Google-Smtp-Source: APXvYqzLR6zemuzi+a00MubxJZm/qmXfCCM3+w0iNaTNUKY7732V0rc2yd3Y3mb/T9IkAjiXtD6sFg==
X-Received: by 2002:a19:6a0e:: with SMTP id u14mr1356433lfu.197.1579002563085;
        Tue, 14 Jan 2020 03:49:23 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id g15sm7349578ljl.10.2020.01.14.03.49.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 03:49:22 -0800 (PST)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] mesh: Add sequence nr getter code
Date:   Tue, 14 Jan 2020 12:49:14 +0100
Message-Id: <20200114114914.25868-2-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114114914.25868-1-jakub.witowski@silvair.com>
References: <20200114114914.25868-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/node.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mesh/node.c b/mesh/node.c
index 3154d6bf4..723869cc0 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -2215,6 +2215,19 @@ static bool ivindex_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
 	return true;
 }
 
+static bool seq_num_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	struct mesh_node *node = user_data;
+	struct mesh_net *net = node_get_net(node);
+	uint32_t seq_nr = mesh_net_get_seq_num(net);
+
+	l_dbus_message_builder_append_basic(builder, 'u', &seq_nr);
+
+	return true;
+}
+
 static bool lastheard_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
 					struct l_dbus_message_builder *builder,
 					void *user_data)
@@ -2284,6 +2297,8 @@ static void setup_node_interface(struct l_dbus_interface *iface)
 						beaconflags_getter, NULL);
 	l_dbus_interface_property(iface, "IvIndex", 0, "u", ivindex_getter,
 									NULL);
+	l_dbus_interface_property(iface, "SequenceNumber", 0, "u",
+							seq_num_getter, NULL);
 	l_dbus_interface_property(iface, "SecondsSinceLastHeard", 0, "u",
 					lastheard_getter, NULL);
 	l_dbus_interface_property(iface, "Addresses", 0, "aq", addresses_getter,
-- 
2.20.1

