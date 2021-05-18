Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4807EC43460
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 18:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DAE56124C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 18:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345973AbhERSlD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 14:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344369AbhERSlB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 14:41:01 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBA1C061760
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 11:39:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id s20so5593999plr.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 11:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2XkMpWYGmA/c07E68wL6jGMt77CGRNTBe4b0pnu8Xrg=;
        b=S7kI2lmna8bgL9OKTGauAfqdfdAkF/KSgV5bj+rB9XVETUzXz/DUNt1C/erRH8iq5M
         URgRsA5dPqdBh7EsX6su1QjUw8gLdMzsrIxO4hL0myHhFxNPGV3ZSBnGs4gO/nSeZqwg
         7t1rZ85pdfIYdBfAq0Et7bKGzWGO+PQ9TLrcgrP0Lu7kYv4bP5lRKb8Beh8QrI9DINDM
         78DTtGDP3lwLbwaWJQjGjK0dyayA8ABFqXaPuqayCqZVjSahGFgcDUzBwI2l+lGicEji
         g9WdFbWd4upbD30DMh1tFbNMwkdA4hg84gOfOi49lc9enKwDn3kg4EnuXeEkaxChogyy
         ZG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2XkMpWYGmA/c07E68wL6jGMt77CGRNTBe4b0pnu8Xrg=;
        b=J2yri6MwWQ7yGylP48Irc50EwgvmNZRNekIVdC/O6Y7j6R2QiFUU4QmjtY/8B4isBd
         M7k7vrEbFQ42hkmTkW+GT7Brl0p/8npI3MNsKYAgSgLjzrajKE138VXk3D3zgeKLGPNR
         ncnH3q0pdJda73/aVnYihHsLd9JRdGIGblzY21vtAQSJTUNCmZONmcgm1TA8QVO/PbTK
         gJaRIt/NAPGslXv52/zlcM7MNZWEIHyXue5u9kcZ6kHGhCDbTIm5h4muTV2oj2XcZ3EF
         noF8J9mn5YyMKs8D7sREHPK4HVbJJ7YxlU3wV04vA61CB9x6RANWrbEtXwWtlNpH5/6E
         ul8Q==
X-Gm-Message-State: AOAM5300jYMxwvgOaEuDU4ONVCsKouGymm5mP12ItdFt+vgjHoENIGcH
        JXpV51ppUvh82RMzWrDb/4Qxg8s8aww=
X-Google-Smtp-Source: ABdhPJwpatjuV1Vd+K9VRXOU9TKS9A+YsmRlSjvKxjHJ7yYNMPnT27QRoj2nRKUC3qQjEl/SEe5YyA==
X-Received: by 2002:a17:902:854a:b029:ef:3f99:91a7 with SMTP id d10-20020a170902854ab02900ef3f9991a7mr6180139plo.74.1621363182501;
        Tue, 18 May 2021 11:39:42 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r22sm13157121pgr.1.2021.05.18.11.39.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:39:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] btmon: Use bt_uuid128_to_str when printing UUIDs of 128 bits
Date:   Tue, 18 May 2021 11:39:37 -0700
Message-Id: <20210518183937.786605-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210518183937.786605-1-luiz.dentz@gmail.com>
References: <20210518183937.786605-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This ensures that know UUIDs names are printed including those used by
experimental features.
---
 monitor/packet.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index d729a01cc..82513a63c 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3282,18 +3282,13 @@ static void print_uuid128_list(const char *label, const void *data,
 {
 	uint8_t count = data_len / 16;
 	unsigned int i;
-	char uuidstr[MAX_LEN_UUID_STR];
 
 	print_field("%s: %u entr%s", label, count, count == 1 ? "y" : "ies");
 
 	for (i = 0; i < count; i++) {
 		const uint8_t *uuid = data + (i * 16);
 
-		sprintf(uuidstr, "%8.8x-%4.4x-%4.4x-%4.4x-%8.8x%4.4x",
-				get_le32(&uuid[12]), get_le16(&uuid[10]),
-				get_le16(&uuid[8]), get_le16(&uuid[6]),
-				get_le32(&uuid[2]), get_le16(&uuid[0]));
-		print_field("  %s (%s)", bt_uuidstr_to_str(uuidstr), uuidstr);
+		print_field("  %s", bt_uuid128_to_str(uuid));
 	}
 }
 
@@ -12006,16 +12001,6 @@ static void mgmt_print_name(const void *data)
 	print_field("Short name: %s", (char *) (data + 249));
 }
 
-static void mgmt_print_uuid(const void *data)
-{
-	const uint8_t *uuid = data;
-
-	print_field("UUID: %8.8x-%4.4x-%4.4x-%4.4x-%8.8x%4.4x",
-				get_le32(&uuid[12]), get_le16(&uuid[10]),
-				get_le16(&uuid[8]), get_le16(&uuid[6]),
-				get_le32(&uuid[2]), get_le16(&uuid[0]));
-}
-
 static void mgmt_print_io_capability(uint8_t capability)
 {
 	const char *str;
@@ -12261,7 +12246,7 @@ static void mgmt_print_exp_feature(const void *data)
 	uint32_t flags = get_le32(data + 16);
 	uint32_t mask;
 
-	mgmt_print_uuid(data);
+	print_field("UUID: %s", bt_uuid128_to_str(data));
 	print_field("Flags: 0x%8.8x", flags);
 
 	mask = print_bitfield(2, flags, mgmt_exp_feature_flags_table);
@@ -12457,7 +12442,7 @@ static void mgmt_add_uuid_cmd(const void *data, uint16_t size)
 {
 	uint8_t service_class = get_u8(data + 16);
 
-	mgmt_print_uuid(data);
+	print_field("UUID: %s", bt_uuid128_to_str(data));
 	print_field("Service class: 0x%2.2x", service_class);
 }
 
@@ -12468,7 +12453,7 @@ static void mgmt_add_uuid_rsp(const void *data, uint16_t size)
 
 static void mgmt_remove_uuid_cmd(const void *data, uint16_t size)
 {
-	mgmt_print_uuid(data);
+	print_field("UUID: %s", bt_uuid128_to_str(data));
 }
 
 static void mgmt_remove_uuid_rsp(const void *data, uint16_t size)
@@ -13092,7 +13077,7 @@ static void mgmt_start_service_discovery_cmd(const void *data, uint16_t size)
 	}
 
 	for (i = 0; i < num_uuids; i++)
-		mgmt_print_uuid(data + 4 + (i * 16));
+		print_field("UUID: %s", bt_uuid128_to_str(data + 4 + (i * 16)));
 }
 
 static void mgmt_start_service_discovery_rsp(const void *data, uint16_t size)
@@ -13352,7 +13337,7 @@ static void mgmt_set_exp_feature_cmd(const void *data, uint16_t size)
 {
 	uint8_t enable = get_u8(data + 16);
 
-	mgmt_print_uuid(data);
+	print_field("UUID: %s", bt_uuid128_to_str(data));
 	print_enable("Action", enable);
 }
 
-- 
2.30.2

