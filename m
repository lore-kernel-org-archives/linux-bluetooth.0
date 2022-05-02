Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AEBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 May 2022 21:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiEBVJ1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 May 2022 17:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiEBVJ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 May 2022 17:09:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B2FBC36
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 May 2022 14:05:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x18so2252464plg.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 May 2022 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mZFJU8oGnSo9NfWXq+X3qpT08JftfIhhfeGmT7oGTVo=;
        b=kZjypGl+uT0xL9z2ytFoHLzKR+H4j2rSPPBmprQ2eDPLjjloEaOkcwQZPV3a8auGkJ
         Jrt11QApqMQv5afw0zp3VckO8lA6iLXNdVeV9yNn5OG8beFBHYh8MimUHUT4W/D2sOXV
         XSCGVTMBSEPaoEpJUG1LB9Hg4ju8EaZWEoYVL1BBcDg5ow3CPOXTP19q3lud1pMSleo+
         2vGV8NFIYwpQY2QW/3ZBcg0wcc+NvjLXLZ0IY8idJGUtRFFXSSQLzbYtEoJSsDS08YKh
         Hsju5/PzWBS85P54q66I/ZyhsB2qxst6yHlWHF+Rl6NUeCLf5glRHC62f0OTbLVhPjQ+
         oXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mZFJU8oGnSo9NfWXq+X3qpT08JftfIhhfeGmT7oGTVo=;
        b=kbppU4K7BisxK5x84ptDrmbUc7oaLuTHOLQqVqyNLqQqAroN9ZnbtFjGzRRfRglOGy
         UWkK0lozMOnPKapiXWwnePa0fOOazDNw2ykwaW/gvtdxH4dyP85TldZjJ+Xzu3DNNoP2
         XMIhgZnKMtmzIgfP1AhG0CAWjluNTVnPjibe1yIWC1cukW665032U/tYgh14nbnWn7Z3
         UNc8fOqnYlub21HNerbfyfeN8oA+0xHubdFEr9VsSHjEU+VTq+Q3tC9xszak5usQFujL
         b/eO2ldnzP+ta3wLk8XahgU/SU48oUP5SIYNc0LaGDc1gu/PlL3Y/bMT/j3KrDSGSVLS
         gt+w==
X-Gm-Message-State: AOAM5336VdZRd6kMGYQOGvEkLee+/SXWyh46daywCoo6ic8g5K/nSMOj
        iVFEbGmYYVADeWjAk3aDm3t70IBndLQ=
X-Google-Smtp-Source: ABdhPJyFmgCcryvrgu9+uMuE1g/rtWpRLAMwSKdpC0N8sF8hGM9kZR/jV1FvWjhf70vj2jaw6pKj2w==
X-Received: by 2002:a17:902:ef47:b0:156:646b:58e7 with SMTP id e7-20020a170902ef4700b00156646b58e7mr13238584plx.57.1651525555934;
        Mon, 02 May 2022 14:05:55 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902e38200b0015e8d4eb2d8sm846255ple.290.2022.05.02.14.05.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 14:05:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] monitor: Decode LTV fields of Basic Audio Announcements
Date:   Mon,  2 May 2022 14:05:53 -0700
Message-Id: <20220502210553.2271064-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502210553.2271064-1-luiz.dentz@gmail.com>
References: <20220502210553.2271064-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This decodes the LTV fields of Basic Audio Announcements:

< HCI Command: LE Set Periodic Advertising Data (0x08|0x003f) plen 41
        Handle: 0
        Operation: Complete ext advertising data (0x03)
        Data length: 0x26
        Service Data: Basic Audio Announcement (0x1851)
          Presetation Delay: 40000
          Number of Subgroups: 1
            Subgroup #0:
            Number of BIS(s): 1
            Codec: LC3 (0x06)
            Codec Specific Configuration #0: len 0x02 type 0x01
            Codec Specific Configuration: 03
            Codec Specific Configuration #1: len 0x02 type 0x02
            Codec Specific Configuration: 01
            Codec Specific Configuration #2: len 0x05 type 0x03
            Codec Specific Configuration: 01000000
            Codec Specific Configuration #3: len 0x03 type 0x04
            Codec Specific Configuration: 2800
            Metadata #0: len 0x03 type 0x02
            Metadata: 0200
              BIS #0:
              Index: 1
              Codec Specific Configuration:
---
 monitor/packet.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index d409e4e63..99ed9c281 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3318,6 +3318,44 @@ static void *iov_pull(struct iovec *iov, size_t len)
 	return data;
 }
 
+static void print_ltv(const char *label, const uint8_t *data, uint8_t len)
+{
+	struct iovec iov;
+	int i;
+
+	iov.iov_base = (void *) data;
+	iov.iov_len = len;
+
+	for (i = 0; iov.iov_len; i++) {
+		uint8_t l, t, *v;
+
+		l = get_u8(iov_pull(&iov, sizeof(l)));
+		if (!l) {
+			print_field("%s #%d: len 0x%02x", label, i, l);
+			break;
+		}
+
+		v = iov_pull(&iov, sizeof(*v));
+		if (!v)
+			break;
+
+		t = get_u8(v);
+
+		print_field("%s #%d: len 0x%02x type 0x%02x", label, i, l, t);
+
+		l -= 1;
+
+		v = iov_pull(&iov, l);
+		if (!v)
+			break;
+
+		print_hex_field(label , v, l);
+	}
+
+	if (iov.iov_len)
+		print_hex_field(label , iov.iov_base, iov.iov_len);
+}
+
 static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
 {
 	struct iovec iov;
@@ -3368,7 +3406,7 @@ static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
 		if (!iov_pull(&iov, codec_cfg->len))
 			goto done;
 
-		print_hex_field("    Codec Specific Configuration",
+		print_ltv("    Codec Specific Configuration",
 					codec_cfg->data, codec_cfg->len);
 
 		metadata = iov_pull(&iov, sizeof(*metadata));
@@ -3378,7 +3416,7 @@ static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
 		if (!iov_pull(&iov, metadata->len))
 			goto done;
 
-		print_hex_field("    Metadata", metadata->data, metadata->len);
+		print_ltv("    Metadata", metadata->data, metadata->len);
 
 		/* Level 3 - BIS(s)*/
 		for (j = 0; j < subgroup->num_bis; j++) {
-- 
2.35.1

