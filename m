Return-Path: <SRS0=E8Rw=U6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D7BC0650E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 11:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1022089C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 11:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="YNPeSJ3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfGALmt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:42:49 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:44552 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfGALmt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jul 2019 07:42:49 -0400
Received: by mail-wr1-f48.google.com with SMTP id e3so3931360wrs.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2019 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rk1hxN298wSgW38dEL3iCkPIATZDRLPpC+yUXoOiHfU=;
        b=YNPeSJ3Tlj9ZrClSldeD7fHW/Sc2V6UsZy46HEp9mT1kMO4J26sWGd+yAKeSqVwFpz
         CrsQ/sahVDM2gaNFmG0Q6VgeK09ktPrk2rHmVOppaaVx/YcjblK+KDDrqFqia/9pqcYF
         n/slY8g1h7CGrpprVyfJOuopcOH9OZf7/3Zs7FEM3h2ub2NaS9PqdDmPrfl1PhVd1qQ2
         +ukISlv/qxW1WCqkk1nw0j4Aq1+SuEul9pOwiSLRBVxG3JaepQ4WwtgVNh+cHZeUKORR
         gCIxygGOwGoPi3Md4WyX5hNfAluqQ1xDT9pNwESB5l9QyjtD6xwJExivEXl9vtbjSr/L
         cOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rk1hxN298wSgW38dEL3iCkPIATZDRLPpC+yUXoOiHfU=;
        b=kNg2dbs7D8//lQsQ1MGQimRX5lbFyPW0wcKZw+mKHMcq4Q/UUYresFWx6BeDOa8jYf
         PgJrcyFCf4XqcqxicF0ojTurH01Q6/CFwiXndwj0X6LP1QSqr0qkKOXFJ0oHfXZbl1F0
         WncpQEtpJ63PtUi2uYXu4D91TMH6OmoRBzPhXWf5MFiqC5zh3i8RYwOldfb99zKPC0Ve
         rmM4PNSfFuzDadzMXUVB7nlQUckw9D+68bxlkW0Ej4qNuOKwyT8M6I1XB/xyWKDBrd5H
         3h3EpVpDRgnbF/d4GD3Ry/lAV6Ui2t8eKVT+ZrvANV7zL2bmv4zc+tqlnmqCzzYB+pro
         hZFQ==
X-Gm-Message-State: APjAAAW/qPROpnqEpaEmoVFAj69BtFhJ+FtV6h7JFFjBNemR9szdXvcp
        Jz+v8AVcZJ6X/9Uf1Oj5Wf0TmJA9/tg=
X-Google-Smtp-Source: APXvYqyH94Wm9BubRDIAnwdiGdKogG017MDV8jP/7q23pqRnJX81dhhvvLGgA/aIdFYhqHoTdB0x7w==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr9649006wrq.143.1561981366592;
        Mon, 01 Jul 2019 04:42:46 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id w6sm8921268wrp.67.2019.07.01.04.42.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 04:42:46 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH] mesh: Allow to set-up the CRPL with application
Date:   Mon,  1 Jul 2019 13:42:39 +0200
Message-Id: <20190701114239.8792-1-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implementation adds possibility of adding CRPL to the node
via application in the same way as CIP VID or PID.
---
 doc/mesh-api.txt |  4 ++++
 mesh/node.c      | 12 ++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 4e0a8bff1..45fc431fa 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -724,6 +724,10 @@ Properties:
 
 		A 16-bit vendor-assigned product version identifier
 
+	uint16 CRPL [read-only]
+
+		A 16-bit reply protection value
+
 
 Mesh Element Hierarchy
 ======================
diff --git a/mesh/node.c b/mesh/node.c
index 4e35bb3ff..9372d540a 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -55,7 +55,6 @@
 /* Default element location: unknown */
 #define DEFAULT_LOCATION 0x0000
 
-#define DEFAULT_CRPL 10
 #define DEFAULT_SEQUENCE_NUMBER 0
 
 #define REQUEST_TYPE_JOIN 0
@@ -1302,7 +1301,6 @@ static void set_defaults(struct mesh_node *node)
 	if (!node->comp)
 		node->comp = l_new(struct node_composition, 1);
 
-	node->comp->crpl = DEFAULT_CRPL;
 	node->lpn = MESH_MODE_UNSUPPORTED;
 	node->proxy = MESH_MODE_UNSUPPORTED;
 	node->friend = MESH_MODE_UNSUPPORTED;
@@ -1359,6 +1357,16 @@ static bool get_app_properties(struct mesh_node *node, const char *path,
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

