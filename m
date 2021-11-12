Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70A9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 22:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA4661073
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 22:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhKLWId (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbhKLWIc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Nov 2021 17:08:32 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44087C061766
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 14:05:41 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z6so9615383pfe.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 14:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IMp5PRkMJz0i1vq3s2O+a4Vv8FjDcxnnenxd9qQ4Kdg=;
        b=WuYJli5qr6TfLlkdo2WE8VXqy/Vg2zKD01xawI1jBHloy7YLfVbdSisbzNbbA1xZ0X
         ab8w3G/1iVmA4ndmQqvRYqz5sg3pVdL2hZL5aIb2SKbYNLQFOnlI1YoqZ78NrOci30Cm
         u51ew2I77iciPojvK5Hlo7hvCQwENq16/OuO5B7k2N+SSi8EOsQXr+Gpv0cVzqNLtmy+
         k1HaL+tlVa0eCF2LfdPyo7/NGCZIjg4tZz0P3GFhIAZ5+1TohC8UHQOu877OjetVzhfQ
         OAdHhgHnM88Yg2ghjvLhYwCN7JuqP+XsVSwoqMGlZPDopn0Sd/5bjErjgsRpVGXMlhsC
         sYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IMp5PRkMJz0i1vq3s2O+a4Vv8FjDcxnnenxd9qQ4Kdg=;
        b=eZAzUY4xHPfnQ/LGzslko4KscBOrgZAWaeXaiFku6o0UU3PR65QgoPy4ubsVPjeWvW
         +rTQVN0yMhOZRJ2LfuSJhtoJGinScpUBzMOcNQiFAPxrDm9EzxzVHRAC1Iie0Gf0NwdJ
         Y5HLKOCZwuqls064zSKbEbsBeLhRp1V0vm4jKPCYgGMrthCbmIbLxoWX9Sg4xsRWrnJM
         c+5CxdjrSHmHCOw5E7XKKpeEajrRbnkJOWbPSFdPqI6lSmP4c2B2qy2zDbkQ5DpEhYXG
         dC0atAYJTuv2xPvjm0z61s1u8eXzY19vQKTHPalOlTUkSOWo7+6T3uTF6l/ww7ywk3P7
         lmuw==
X-Gm-Message-State: AOAM530YVuiDviAe/GePdQ6Qob5TDLpnsLoM4KmhOW/4YDPTmpqAfniP
        oQgRb0vj9Wb7Xu2fpVB5bo8nbJBr5i4=
X-Google-Smtp-Source: ABdhPJwduxFaRLx85w5K/E1P5hq5XAe1SjW4gHUts/I0OHoGo04GRVowJtwqfhJAgc8rEKerTFlKVw==
X-Received: by 2002:a63:7e48:: with SMTP id o8mr12230755pgn.157.1636754740446;
        Fri, 12 Nov 2021 14:05:40 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b22sm5618088pge.2.2021.11.12.14.05.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:05:40 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] shared/gatt-server: Fix heap overflow when appending prepare writes
Date:   Fri, 12 Nov 2021 14:05:38 -0800
Message-Id: <20211112220538.310085-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112220538.310085-1-luiz.dentz@gmail.com>
References: <20211112220538.310085-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The code shall check if the prepare writes would append more the
allowed maximum attribute length.

Fixes https://github.com/bluez/bluez/security/advisories/GHSA-479m-xcq5-9g2q
---
 src/shared/gatt-server.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index dc4e681c9..9beec44be 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -779,6 +779,20 @@ static uint8_t authorize_req(struct bt_gatt_server *server,
 						server->authorize_data);
 }
 
+static uint8_t check_length(uint16_t length, uint16_t offset)
+{
+	if (length > BT_ATT_MAX_VALUE_LEN)
+		return BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+
+	if (offset > BT_ATT_MAX_VALUE_LEN)
+		return BT_ATT_ERROR_INVALID_OFFSET;
+
+	if (length + offset > BT_ATT_MAX_VALUE_LEN)
+		return BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+
+	return 0;
+}
+
 static void write_cb(struct bt_att_chan *chan, uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
@@ -809,6 +823,10 @@ static void write_cb(struct bt_att_chan *chan, uint8_t opcode, const void *pdu,
 				(opcode == BT_ATT_OP_WRITE_REQ) ? "Req" : "Cmd",
 				handle);
 
+	ecode = check_length(length, 0);
+	if (ecode)
+		goto error;
+
 	ecode = check_permissions(server, attr, BT_ATT_PERM_WRITE_MASK);
 	if (ecode)
 		goto error;
@@ -1299,6 +1317,10 @@ static void prep_write_cb(struct bt_att_chan *chan, uint8_t opcode,
 	util_debug(server->debug_callback, server->debug_data,
 				"Prep Write Req - handle: 0x%04x", handle);
 
+	ecode = check_length(length, offset);
+	if (ecode)
+		goto error;
+
 	ecode = check_permissions(server, attr, BT_ATT_PERM_WRITE_MASK);
 	if (ecode)
 		goto error;
-- 
2.33.1

