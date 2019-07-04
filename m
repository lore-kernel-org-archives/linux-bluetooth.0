Return-Path: <SRS0=WywE=VB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6008C06513
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 12:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A15D2082E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 12:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="boBnnQQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfGDMdr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:33:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46831 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfGDMdq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jul 2019 08:33:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so5991698ljg.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2019 05:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hfn5WItLjDEvtXacOrZrP/C8lF0XtOwOiop6cRRDn0o=;
        b=boBnnQQ/kktuCq57qazE39WyLNn7rj3Q2YubyYqwBw8OhAmJWyj1+M4uCWDm3MRsZ5
         4CmQ3XGDfv1Xb1lYLBWOR3BmCWIBnY1YQrqxXLgVg1oy5Uao7EKQ0B+rP3HU4xNfAhkW
         GoCYL7p1f28HC/PWSpAA/iZBDseSuMZ7V4KCdrhI3ljy/ikELUBkX8Db+JJR8pO6Zfms
         rCgs69Ltu4+PNzl0Su63TWCEZjZBdaq2usJWmeXHylF+cvmps9MgatGy3pxQTT1BzLwx
         sBTHLvbu3tk5g9ZkEU0fInBblsip/PfIePPnmVjN/VS8k1Jf81CYSZog2K70eYr1j64Q
         Jkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hfn5WItLjDEvtXacOrZrP/C8lF0XtOwOiop6cRRDn0o=;
        b=noxTvX0VILxb0qUWAuKRCDPuzFkfPonlA12yNwHNJ8tS3iiz5If163GsCyABbti7Hj
         SHignz1vJFo54nw6r8ri1ksUeQzxpMP1KYsrMD0NhKgdKwK0qVBkqCBw3i/uR/ooSx8d
         WuF8c1kTX5eLUCXUiNV94skfwb2htMYd8gL3vR1HsvPhky+iS2Noa5DLZztrrNJnzQlp
         llOy5DACQuqES8IdFCmEL0DkYhhBZ1GBcj4bB3lO6adRFT6MDcKymgrl4TlZsVzlxnfG
         bBi8N4J+1XuGhWZEMEJxZ6H4NZDC7FCSb6I6no8+i03/XpV5xTvOPgp8RaJ//oKqelVA
         0I2A==
X-Gm-Message-State: APjAAAWA01em/0o2w3dz1b8xfppbVnu7YeLmVSp/pzoeJ/ubFKUzoZx6
        5TNaviJecFhgr1Ja2/nNdTJD2620xA4=
X-Google-Smtp-Source: APXvYqwikterp6c7TDTdYbl9eCCz6zUl67wpHDM7LvzF0bZycmWKwSd2L3DlnBgYYT+zkvQU2GpE/A==
X-Received: by 2002:a2e:9147:: with SMTP id q7mr5589021ljg.19.1562243624449;
        Thu, 04 Jul 2019 05:33:44 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id g68sm1126151ljg.47.2019.07.04.05.33.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 05:33:43 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v5 1/5] mesh: Cleanup l_dbus_message_... API usage in models
Date:   Thu,  4 Jul 2019 14:33:34 +0200
Message-Id: <20190704123338.5988-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190704123338.5988-1-michal.lowas-rzechonek@silvair.com>
References: <20190704123338.5988-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/model.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index 7401dcecb..868fe9e52 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -249,10 +249,10 @@ static void config_update_model_pub_period(struct mesh_node *node,
 								&period);
 
 	l_dbus_message_builder_leave_array(builder);
-	if (l_dbus_message_builder_finalize(builder))
-		l_dbus_send(dbus, msg);
-
+	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
+
+	l_dbus_send(dbus, msg);
 }
 
 static void append_dict_uint16_array(struct l_dbus_message_builder *builder,
@@ -291,10 +291,10 @@ static void config_update_model_bindings(struct mesh_node *node,
 	append_dict_uint16_array(builder, mod->bindings, "Bindings");
 
 	l_dbus_message_builder_leave_array(builder);
-	if (l_dbus_message_builder_finalize(builder))
-		l_dbus_send(dbus, msg);
-
+	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
+
+	l_dbus_send(dbus, msg);
 }
 
 static void forward_model(void *a, void *b)
@@ -714,25 +714,15 @@ static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx, bool is_sub,
 
 	builder = l_dbus_message_builder_new(msg);
 
-	if (!l_dbus_message_builder_append_basic(builder, 'q', &src))
-		goto error;
+	l_dbus_message_builder_append_basic(builder, 'q', &src);
+	l_dbus_message_builder_append_basic(builder, 'q', &key_idx);
+	l_dbus_message_builder_append_basic(builder, 'b', &is_sub);
+	dbus_append_byte_array(builder, data, size);
 
-	if (!l_dbus_message_builder_append_basic(builder, 'q', &key_idx))
-		goto error;
-
-	if (!l_dbus_message_builder_append_basic(builder, 'b', &is_sub))
-		goto error;
-
-	if (!dbus_append_byte_array(builder, data, size))
-		goto error;
-
-	if (!l_dbus_message_builder_finalize(builder))
-		goto error;
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
 
 	l_dbus_send(dbus, msg);
-
-error:
-	l_dbus_message_builder_destroy(builder);
 }
 
 bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
-- 
2.19.1

