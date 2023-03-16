Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E018C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 18:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCPSI7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 14:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCPSI6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 14:08:58 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC38C42BF2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 11:08:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h8so2648440plf.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678990136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cnijUVigjrfMSfG3CvXljl/NUz7M88XW1QJriiovO6c=;
        b=W3RjWAC0cNzbgUsGmfYPhrLb13wjkR9bvdxq1oIm05VVGejACrLM8q5JrNdckIlonO
         xmoQHSzr1NL65IFgc/T4EAVgucKvwaVnSNEP+UIrgargtVKpXqIglFMQIhmGQF9aCH0R
         a+CLcrT+yBaaZZc0+kyfg11W3H5l0OQKtCGyoix1pPjJ6hExoprzIaBSNppWKIzMAhHh
         ZLtkCGCyfqWselt1BhcToA5w8pyRnOCTPwIiAV58mJQMERRaTHX/uVEwu15Clbpl0nLO
         GDWxGGXYHYO4CoAsVf2gSUUrBMtMsk3rzFAal4eKMonAr3VBdpZrSw6I+03LqAbjkArF
         SKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678990136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnijUVigjrfMSfG3CvXljl/NUz7M88XW1QJriiovO6c=;
        b=PulBNBQ42iqyaOPyrA+teWahxYdVpmwJCL0LLGClROHjD9X8w7gldTyFzjLuxUDI7X
         THAaCi3fvd7BNksW8gimucwV5mq9nsinmQumVuDfF62+IXjKXr176drc4sDzI3ZuxeBj
         9vfAC27oXKRGOrib1B5DqY8nFggHqJqncxodvQn6l8v/PdRiSWd8KkMcfNxkCO5fQjov
         yxGCLLnc398/c7OK2xWAVUvjlj3w5QWEbLcd+5Ag8+ofGO9yMfApP/o2sMFSdP03H53B
         rDx2NlCtQS6CtfBnIwwSuPu10fgEExhVjiHA8Clk0fxycKGm6P5hL4Xm6gzjobBhM8Rf
         5SQQ==
X-Gm-Message-State: AO0yUKUk0wCrEpVOFKPuVTkx3B6BFMoMBJAwq34vFosTTMQ4DmvnDeO8
        aB/2Eoo3fFBpHUtM7izhTAlSuO5/i96bovjM
X-Google-Smtp-Source: AK7set/6eWgJW8UnOfg6Cd3zKLG25QEc/ujc9svdn9On5QPgtkEw6J1jEtthyRqg7WpGZwm4m6I2Nw==
X-Received: by 2002:a05:6a20:6a0d:b0:d4:32bb:11bd with SMTP id p13-20020a056a206a0d00b000d432bb11bdmr5041431pzk.45.1678990135986;
        Thu, 16 Mar 2023 11:08:55 -0700 (PDT)
Received: from fedora.. (c-67-170-58-107.hsd1.wa.comcast.net. [67.170.58.107])
        by smtp.googlemail.com with ESMTPSA id p18-20020a634f52000000b0049f5da82b12sm5295119pgl.93.2023.03.16.11.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 11:08:55 -0700 (PDT)
From:   Inga Stotland <inga.stotland@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@gmail.com, brian.gix@intel.com,
        Inga Stotland <inga.stotland@gmail.com>
Subject: [PATCH BlueZ 1/2] tools/mesh-cfgclient: Prevent storing duplicate models
Date:   Thu, 16 Mar 2023 11:07:58 -0700
Message-Id: <20230316180759.147486-1-inga.stotland@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the situation when subsequent requests to get a node
composition result in appending element's model list with duplicate models.
This adds a check for a presence of a model on a element when attempting
to add a new model ID to a model list on this element.
---
 tools/mesh/mesh-db.c | 17 ++++++++++++-----
 tools/mesh/remote.c  | 12 ++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index c0c05a29a..1d047691d 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -1964,28 +1964,35 @@ bool mesh_db_node_set_composition(uint16_t unicast, uint8_t *data, uint16_t len)
 
 		while (len >= 2 && m--) {
 			mod_id = l_get_le16(data);
+			data += 2;
+			len -= 2;
+
+			jobj = get_model(unicast, unicast + i, mod_id, false);
+			if (jobj)
+				continue;
 
 			jobj = init_model(mod_id);
 			if (!jobj)
 				goto fail;
 
 			json_object_array_add(jmods, jobj);
-			data += 2;
-			len -= 2;
 		}
 
 		while (len >= 4 && v--) {
 			mod_id = l_get_le16(data + 2);
 			mod_id = l_get_le16(data) << 16 | mod_id;
+			data += 4;
+			len -= 4;
+
+			jobj = get_model(unicast, unicast + i, mod_id, true);
+			if (jobj)
+				continue;
 
 			jobj = init_vendor_model(mod_id);
 			if (!jobj)
 				goto fail;
 
 			json_object_array_add(jmods, jobj);
-
-			data += 4;
-			len -= 4;
 		}
 
 		i++;
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index cee711dec..ec1476ac9 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -54,6 +54,14 @@ struct rejected_addr {
 static struct l_queue *nodes;
 static struct l_queue *reject_list;
 
+static bool match_mod_id(const void *a, const void *b)
+{
+	uint32_t id1 = L_PTR_TO_UINT(a);
+	uint32_t id2 = L_PTR_TO_UINT(b);
+
+	return id1 == id2;
+}
+
 static int compare_mod_id(const void *a, const void *b, void *user_data)
 {
 	uint32_t id1 = L_PTR_TO_UINT(a);
@@ -227,6 +235,10 @@ bool remote_set_model(uint16_t unicast, uint8_t ele_idx, uint32_t mod_id,
 	if (!vendor)
 		mod_id = VENDOR_ID_MASK | mod_id;
 
+	if (l_queue_find(rmt->els[ele_idx], match_mod_id,
+							L_UINT_TO_PTR(mod_id)))
+		return true;
+
 	l_queue_insert(rmt->els[ele_idx], L_UINT_TO_PTR(mod_id),
 							compare_mod_id, NULL);
 
-- 
2.39.2

