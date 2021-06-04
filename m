Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFC4C4743C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 21:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDEA861287
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 21:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhFDVf2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Jun 2021 17:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFDVf1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Jun 2021 17:35:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C4EC061766
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jun 2021 14:33:29 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e22so8862223pgv.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Jun 2021 14:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YpfiGYoZkk/lAv0yMGXpRMur7NymrI5zAD8zqOH9O7I=;
        b=OdpV8+lXEe/Tgs+5JJa9p/4SmKbjoJ5hFZhoELt2Ebde33ZHVYjX3AfWwz3wmy1b5m
         U5L9CVptr2p9z5Iw5tDVACh+p/pfSh4b7T7UjD/vubUdSknAhBrHiTAnQF6hRyoGS8DM
         FyE4PXrXaoJC4E1tm4WqtcqDgbKeSTuSo3Zp5x8dV1hz4BCYPx7U/0SZXeETvgb42gmM
         DBjsPxKiK7L5hmeNvaf5/hNjT/MdIEXR1d8OaaZE/BqlpFVL3UhBoROdh3DDT0TQn2oi
         eOAI9T3b1unfVqzTmX3jZ215ONDubhk9b/DvXkG0l5NFT9V8Q4Io5jBxLz+eYjFkgIYn
         7spA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YpfiGYoZkk/lAv0yMGXpRMur7NymrI5zAD8zqOH9O7I=;
        b=JpbAkIa65Y9DJQxfFgdgvZZE1t+JZvaepKYoy42J3MTbCkDchruvM2KObupaVEXHfP
         K/lMfYSRbIO9V6+W6xiCbvX4Za5WMl64whgqxu6DgIKW7JpvQHYLT14zlgVKpd+kMhug
         NgFxahddryJrkr/oiMicGqad2dAGsOu/cswdD7mV7RXLYG7ZjXuuGeug6laO3Ps59hQC
         1N0OiUyP78raxxCNQa/m8gJbeHK28U4ldZrnaf/lr8lH77x7ue3IYObmO+Q1oqV7tdaS
         VYxZVhmLZmiDn2s9xzbN24xToV0TJbb14wLzVE7uGUFDGMGaNDqvK1zABxtYlGJ6tyT6
         /oHw==
X-Gm-Message-State: AOAM532IgRhfzsycDmVCVZwFQtRHYZVlcbexQp+1AtTB38luyRqITiS6
        JJVHiZnA61TUB6hY4amVWu7yCbmKJbU=
X-Google-Smtp-Source: ABdhPJyawfMWhaAPUMpgCICzr8l5U0HLLRF02w0UrgiCXxTI1IqKbID4kjWXabb22Z5qHuhi6GsIpA==
X-Received: by 2002:a63:1559:: with SMTP id 25mr7113481pgv.384.1622842409175;
        Fri, 04 Jun 2021 14:33:29 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q4sm2393529pfg.3.2021.06.04.14.33.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 14:33:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/mgmt: Fix not processing request queue
Date:   Fri,  4 Jun 2021 14:33:26 -0700
Message-Id: <20210604213326.1724684-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the kernel return an invalid opcode like bellow the request won't be
processed leading making it unusable:

@ MGMT Command: Read Advertising Features (0x003d) plen 0
{0x0001} [hci0] 14:25:11.096370
@ MGMT Event: Command Status (0x0002) plen 3
{0x0001} [hci0] 14:25:11.096373
      Set Advertising (0x0029)
              Status: Not Supported (0x0c)

In order to fix this attempts to remove the first request pending on the
given index:

= bluetoothd: src/advertising.c:read_adv_features_callback() Failed to
read advertising features: Not Supported (0x0c)
---
 src/shared/mgmt.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 3e9b9ee26..767a711d6 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -235,8 +235,10 @@ static bool match_request_opcode_index(const void *a, const void *b)
 	const struct mgmt_request *request = a;
 	const struct opcode_index *match = b;
 
-	return request->opcode == match->opcode &&
-					request->index == match->index;
+	if (match->opcode && request->opcode != match->opcode)
+		return false;
+
+	return request->index == match->index;
 }
 
 static void request_complete(struct mgmt *mgmt, uint8_t status,
@@ -248,6 +250,18 @@ static void request_complete(struct mgmt *mgmt, uint8_t status,
 
 	request = queue_remove_if(mgmt->pending_list,
 					match_request_opcode_index, &match);
+	if (!request) {
+		util_debug(mgmt->debug_callback, mgmt->debug_data,
+				"Unable to find request for opcode 0x%02x",
+				opcode);
+
+		/* Attempt to remove with no opcode */
+		match.opcode = 0x0000;
+		request = queue_remove_if(mgmt->pending_list,
+						match_request_opcode_index,
+						&match);
+	}
+
 	if (request) {
 		if (request->callback)
 			request->callback(status, length, param,
-- 
2.31.1

