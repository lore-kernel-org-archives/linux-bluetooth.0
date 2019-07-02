Return-Path: <SRS0=p1bJ=U7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57738C06510
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jul 2019 12:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B02220836
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jul 2019 12:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="OsZd951X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfGBMbt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:31:49 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:32812 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfGBMbt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Jul 2019 08:31:49 -0400
Received: by mail-lf1-f54.google.com with SMTP id y17so11274059lfe.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2019 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MSlXkZ98fkMfYO0+u0lbBPmhe8KOuptU1C+b+RcwPo=;
        b=OsZd951XzTkhFQ3H1uzmvyG0donuXbGy4kcASbLFaAwa7mkvijZ3H1vq5BhqGZIBiw
         l86hKGXl+c9OneEnEQaQq1w/E/xLePXZyT+H5CXXbvhJX6chup4yASwQXeViInHKzWou
         3+cazDTYknIrPGDvQ4qsS2Ufe+FjK7vM77pRF6Yh972Vq3jIAkrO4R5nSZaSAtVR6mZL
         SYblocWavLF5OWfSynYkZt/ZtXVoP4CNJpFGhdtgztsNwwa96wSO+QhyPczqOrptvsJk
         mUhIo2a3LWMXiKUbSxmKJf6AliPdL2SD6+9tKa6Vh1qaJ8LiSfItVi/fjhRXuhf7RICY
         9LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MSlXkZ98fkMfYO0+u0lbBPmhe8KOuptU1C+b+RcwPo=;
        b=NlKeeErcMcKub+BoEYFdDTwsttSRfLGCIuBZFjdHI3bBkU56f3g+PgKArkXb9RM7kc
         lh2IqJsdSDnN5Qt0yyf98+dnUIvrB9VYArjiTD+uLkKE/tbz+Cam2zQTOILIxhyrn4gk
         3SH11uQiNKaHHpjwxm9vv8A/ORB8hUj93c1+skApMHA+DIpp8XQrs1krtpVe9DvA5qbq
         D0/6PBV4kNufyPEwJt8mDRWer3cAaszKrlRNNaUmn0FAzPLGkKcbAJH595PTGbkB74sF
         bS1J9NmJSvc7Jf58+cj9wGhfxGk9PEnC3KclsLjFAsMpfGqIxBGlM3n79wd7DutJKSEH
         wfAw==
X-Gm-Message-State: APjAAAVIl198mDRCNwTsEoO+B+187Lh7bh0uQzR1vPG9mZBUejoIHV4X
        Onzfr40dcPiQKu1kPrzxGsSuBHsgKJc=
X-Google-Smtp-Source: APXvYqxA/s/SwsNJhbTohjiVqBZvwbZfpfNrKZX2qDsTPcz0/rGoYkE9iVsKr06+RSO6XbbLu2ZqXA==
X-Received: by 2002:ac2:44b1:: with SMTP id c17mr14434792lfm.87.1562070706916;
        Tue, 02 Jul 2019 05:31:46 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id d4sm2989981lfi.91.2019.07.02.05.31.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 05:31:46 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2] mesh: Allow to set-up the CRPL with application
Date:   Tue,  2 Jul 2019 14:31:41 +0200
Message-Id: <20190702123141.19673-1-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds an optional CRPL property to org.bluez.mesh.Application1
interface, allowing to indicate the depth of reply protection list.
---
 doc/mesh-api.txt |  4 ++++
 mesh/node.c      | 18 +++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 4e0a8bff1..893a1a6c0 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -724,6 +724,10 @@ Properties:
 
 		A 16-bit vendor-assigned product version identifier
 
+	uint16 CRPL [read-only, optional]
+
+		A 16-bit minimum number of replay protection list entries
+
 
 Mesh Element Hierarchy
 ======================
diff --git a/mesh/node.c b/mesh/node.c
index 7383793d9..adc2aa93e 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1312,10 +1312,6 @@ static bool create_node_config(struct mesh_node *node)
 static void set_defaults(struct mesh_node *node)
 {
 	/* TODO: these values should come from mesh.conf */
-	if (!node->comp)
-		node->comp = l_new(struct node_composition, 1);
-
-	node->comp->crpl = DEFAULT_CRPL;
 	node->lpn = MESH_MODE_UNSUPPORTED;
 	node->proxy = MESH_MODE_UNSUPPORTED;
 	node->friend = MESH_MODE_UNSUPPORTED;
@@ -1338,8 +1334,10 @@ static bool get_app_properties(struct mesh_node *node, const char *path,
 
 	l_debug("path %s", path);
 
-	if (is_new)
+	if (is_new) {
 		node->comp = l_new(struct node_composition, 1);
+		node->comp->crpl = DEFAULT_CRPL;
+	}
 
 	while (l_dbus_message_iter_next_entry(properties, &key, &variant)) {
 
@@ -1372,6 +1370,16 @@ static bool get_app_properties(struct mesh_node *node, const char *path,
 				return false;
 
 			node->comp->vid = value;
+
+		} else if (!strcmp(key, "CRPL")) {
+			if (!l_dbus_message_iter_get_variant(&variant, "q",
+									&value))
+				return false;
+
+			if (!is_new && node->comp->crpl != value)
+				return false;
+
+			node->comp->crpl = value;
 		}
 	}
 
-- 
2.20.1

