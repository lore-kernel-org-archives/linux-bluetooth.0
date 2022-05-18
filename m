Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B435C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 May 2022 22:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiERWRp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 May 2022 18:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiERWRc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 May 2022 18:17:32 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3047C20AE42
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 15:17:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s14so3084681plk.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 15:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=H846IO+fjJ5R46JqSkbj1tpySM3tu5H6t+OYD86b50Q=;
        b=CbcdaMPsFP25m4apnwQFqasULgC3QlM/zNgwOU5JxxwzI6yzD5Yel8t/zSVRC+bhs5
         1LcUGjSxzuRHsBtNsY+Ti1NsraTjoSp3I0DKrSPYcTqRZ87JhPu1ztJQvyI4iSbgBZpE
         Npb+dPjSCb4dqKAcDQowyF/XJXIBivCjM1mD3rD9Bb+6SCzyI2fnI4tI+Wc4obMKqF7X
         auHdF4Xbhp4y4WNCVSnZmc0tuxBtQ0siNKqsDG/n9ETqx9geMMIRIdLqHM8IjdAt3ugd
         y28rNHd+EGAAE4qkdV643SeoAwmtMsZpY9d5G36NFyYdAkUdmwQHnnS/BrneURWxOcvk
         ruwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H846IO+fjJ5R46JqSkbj1tpySM3tu5H6t+OYD86b50Q=;
        b=Xi/lJrKB2fNFAfhax8iWVvcsvGgoK/I0KI1HmlTGOzNa5ui6v/7vOaeLmQjQARlgft
         /Njcm6BC6iiqWwh5lfIr6kWd7AqXtZIlVe4bPEEIi+rk1AUvxhrIK/cuuzIEJDpPLjwz
         MBoLVisJbyEzqcAh1nhVv/mo1Sy0yvL79Pj2flwcWO+BChYe8ijRtdhRoyzLtTrzsryC
         r9R5cUUDeK1WWVI9CUreR65XXKglO4aB1QUtfzyfk8wkvA9pZepSnv7lepYExkqR5o7a
         QNIonmPdHWmOsoOeBacVERoeipyd3eWbBxxB0PfM6Mgsj6Tw8rZ7Yx8hICjn1D04Sfm4
         V9lQ==
X-Gm-Message-State: AOAM532cXb0jmbRd/0DBLWVabtJEfZVzzeC0usKCfzejtExeoCxAlW99
        dsYCTLsdTBcwIk7DOuIqQhEoLweeQTo=
X-Google-Smtp-Source: ABdhPJw3EyKUyYMtP4UmmcvhawGBEDt9qXtVwHDBUDUz1tbee0ELvPr7fKeGwLDihFPwY/QtZLqJVQ==
X-Received: by 2002:a17:90a:6c66:b0:1df:9399:9189 with SMTP id x93-20020a17090a6c6600b001df93999189mr2186136pjj.179.1652912251351;
        Wed, 18 May 2022 15:17:31 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id iz15-20020a170902ef8f00b001619b38701bsm2201363plb.72.2022.05.18.15.17.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:17:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] monitor: Move print_hex_field to display.h
Date:   Wed, 18 May 2022 15:16:58 -0700
Message-Id: <20220518221701.2220062-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518221701.2220062-1-luiz.dentz@gmail.com>
References: <20220518221701.2220062-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves print_hex_field to display.h and removes the duplicated code
from packet.c and l2cap.c.
---
 monitor/display.h | 14 ++++++++++++++
 monitor/l2cap.c   | 14 --------------
 monitor/packet.c  | 14 --------------
 3 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/monitor/display.h b/monitor/display.h
index be5739833..5a82f8e6f 100644
--- a/monitor/display.h
+++ b/monitor/display.h
@@ -76,6 +76,20 @@ static inline uint64_t print_bitfield(int indent, uint64_t val,
 	return mask;
 }
 
+static inline void print_hex_field(const char *label, const uint8_t *data,
+								uint8_t len)
+{
+	char str[len * 2 + 1];
+	uint8_t i;
+
+	str[0] = '\0';
+
+	for (i = 0; i < len; i++)
+		sprintf(str + (i * 2), "%2.2x", data[i]);
+
+	print_field("%s: %s", label, str);
+}
+
 void set_default_pager_num_columns(int num_columns);
 int num_columns(void);
 
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 01825ce0a..192b6c920 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -2123,20 +2123,6 @@ static void amp_packet(uint16_t index, bool in, uint16_t handle,
 	opcode_data->func(&frame);
 }
 
-static void print_hex_field(const char *label, const uint8_t *data,
-								uint8_t len)
-{
-	char str[len * 2 + 1];
-	uint8_t i;
-
-	str[0] = '\0';
-
-	for (i = 0; i < len; i++)
-		sprintf(str + (i * 2), "%2.2x", data[i]);
-
-	print_field("%s: %s", label, str);
-}
-
 static void print_uuid(const char *label, const void *data, uint16_t size)
 {
 	const char *str;
diff --git a/monitor/packet.c b/monitor/packet.c
index d80735a06..2e02b3923 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -1755,20 +1755,6 @@ static void print_key_size(uint8_t key_size)
 	print_field("Key size: %d", key_size);
 }
 
-static void print_hex_field(const char *label, const uint8_t *data,
-								uint8_t len)
-{
-	char str[len * 2 + 1];
-	uint8_t i;
-
-	str[0] = '\0';
-
-	for (i = 0; i < len; i++)
-		sprintf(str + (i * 2), "%2.2x", data[i]);
-
-	print_field("%s: %s", label, str);
-}
-
 static void print_key(const char *label, const uint8_t *link_key)
 {
 	print_hex_field(label, link_key, 16);
-- 
2.35.1

