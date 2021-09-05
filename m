Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B653C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Sep 2021 15:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0044960F4A
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Sep 2021 15:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhIEPpS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Sep 2021 11:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhIEPpS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Sep 2021 11:45:18 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02822C061757
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Sep 2021 08:44:14 -0700 (PDT)
Received: from amulet.. (85-76-48-33-nat.elisa-mobile.fi [85.76.48.33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id A42371B001E8;
        Sun,  5 Sep 2021 18:44:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1630856649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IF18CdOHKgmPrX0PbOR4R7mArRM1jLM58+L4+88ZDJ4=;
        b=EpdA2vv+ps0L4E2VwlKgsL6+wP+vr9bv7Gam3zhCmAPraj3CSPkxhuulLRbMSQJqPZhwKw
        090EuADxvl5SYveYmVCZaW+0jBsufWWHlf61366lbayZge0QOVUB3Rxn4m2HdFlAnhK4W6
        FdAYL32ycxy+vlo3UNlZxkN2gp6SVUmCQYFZvHd00shslPSYxcOWy07pPvhaoH/XBMXetm
        NadKXesCxKZMW84039lb/ZsaMif8KxIr1Wnu3BF1H5vIXKCFvf4olNJMImClNUais/H6W1
        feU6F+EAIm8u8mmTDm3e8IY+2DT84TSC2mW6WLZu0rsXijGeBtJ18j6QxJrs0g==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/2] shared/util: use 64-bit bitmap in util_get/clear_uid
Date:   Sun,  5 Sep 2021 18:43:55 +0300
Message-Id: <20210905154356.8296-1-pav@iki.fi>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210829155012.164880-1-pav@iki.fi>
References: <20210829155012.164880-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1630856649; a=rsa-sha256;
        cv=none;
        b=QeqQGb7ktJVx2SKaV3+lF2Bw+tOHkNhXXLv9X1PwXABdBbaRnl1JFLwJ3r1A2bQ71tC1j0
        rX9kP3BQNliXia9w7zPn5wsGx4RNAY3x4LJXKvRmjnbki0ywpYqGZipyzu8RQugeiLLRep
        Om1ZEidHKIsJZ0GJJulNPO4N0z0NyPOdTdu4vl7qmqQWrwUvBoK+LnAfP4Z4xLUF0HaNZ8
        VkgD2tDTGXSu2nuZeRCPTfhAXqaHep1aUdXKAXSBWZFkCRl/zhJEHzsq+THGH7URw3ydb8
        jnpo2xWk74kOkTukUE9es03BcDBxx6iBUl/0G4EotuoPHYj0NLe3Ljnv1TlzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1630856649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IF18CdOHKgmPrX0PbOR4R7mArRM1jLM58+L4+88ZDJ4=;
        b=vRe0dN8v1S7p7I6+0vXPZL0tgdAZwGkX6Ps7cBNH1JzrZZTN/vKJ2m+KMeKcnQkm6Jczd/
        ZagVdewBMd2dIzjrzZfblqQBWtLTq3Nf31LXTBg54VlNP4exoCZEBt1EFRC1Y28TMc2ru8
        46OOzd6sGqOyNBu4mbzriDeqxp65oXyeOTmrrRD++BjTDXWXpOHzSSaxnw+sbsl6Zi/7rR
        P7b9ceG6kHHjpFdNGnY9vGSerDlIQh4oQ2rdfPXKv7vGFb74wjkxUYqribFpMKZvO6NEN7
        SNpgVGK8vlsjZxLh2MnsdisgawUFT+lguVO7H6MIwPmBAW4v6bYU2uNP0ofWow==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The util_get/clear_uid functions use int type for bitmap, and are used
e.g. for SEID allocation. However, valid SEIDs are in range 1 to 0x3E
(AVDTP spec v1.3, 8.20.1), and 8*sizeof(int) is often smaller than 0x3E.

The function is also used in src/advertising.c, but an explicit maximum
value is always provided, so growing the bitmap size is safe there.

Use 64-bit bitmap instead, to be able to cover the valid range.
---
Changes in v2:
* Use ffsll

 android/avdtp.c        |  2 +-
 profiles/audio/avdtp.c |  2 +-
 src/advertising.c      |  2 +-
 src/shared/util.c      | 16 +++++++---------
 src/shared/util.h      |  4 ++--
 unit/test-avdtp.c      |  2 +-
 6 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index 8c2930ec1..a261a8e5f 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -34,7 +34,7 @@
 #include "../profiles/audio/a2dp-codecs.h"
 
 #define MAX_SEID 0x3E
-static unsigned int seids;
+static uint64_t seids;
 
 #ifndef MAX
 # define MAX(x, y) ((x) > (y) ? (x) : (y))
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 946231b71..25520ceec 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -44,7 +44,7 @@
 #define AVDTP_PSM 25
 
 #define MAX_SEID 0x3E
-static unsigned int seids;
+static uint64_t seids;
 
 #ifndef MAX
 # define MAX(x, y) ((x) > (y) ? (x) : (y))
diff --git a/src/advertising.c b/src/advertising.c
index bd79454d5..41b818650 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -48,7 +48,7 @@ struct btd_adv_manager {
 	uint8_t max_scan_rsp_len;
 	uint8_t max_ads;
 	uint32_t supported_flags;
-	unsigned int instance_bitmap;
+	uint64_t instance_bitmap;
 	bool extended_add_cmds;
 	int8_t min_tx_power;
 	int8_t max_tx_power;
diff --git a/src/shared/util.c b/src/shared/util.c
index 244756456..2887a3efa 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -124,30 +124,28 @@ unsigned char util_get_dt(const char *parent, const char *name)
 
 /* Helpers for bitfield operations */
 
-/* Find unique id in range from 1 to max but no bigger then
- * sizeof(int) * 8. ffs() is used since it is POSIX standard
- */
-uint8_t util_get_uid(unsigned int *bitmap, uint8_t max)
+/* Find unique id in range from 1 to max but no bigger than 64. */
+uint8_t util_get_uid(uint64_t *bitmap, uint8_t max)
 {
 	uint8_t id;
 
-	id = ffs(~*bitmap);
+	id = ffsll(~*bitmap);
 
 	if (!id || id > max)
 		return 0;
 
-	*bitmap |= 1u << (id - 1);
+	*bitmap |= ((uint64_t)1) << (id - 1);
 
 	return id;
 }
 
 /* Clear id bit in bitmap */
-void util_clear_uid(unsigned int *bitmap, uint8_t id)
+void util_clear_uid(uint64_t *bitmap, uint8_t id)
 {
-	if (!id)
+	if (!id || id > 64)
 		return;
 
-	*bitmap &= ~(1u << (id - 1));
+	*bitmap &= ~(((uint64_t)1) << (id - 1));
 }
 
 static const struct {
diff --git a/src/shared/util.h b/src/shared/util.h
index 9920b7f76..60908371d 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -102,8 +102,8 @@ void util_hexdump(const char dir, const unsigned char *buf, size_t len,
 
 unsigned char util_get_dt(const char *parent, const char *name);
 
-uint8_t util_get_uid(unsigned int *bitmap, uint8_t max);
-void util_clear_uid(unsigned int *bitmap, uint8_t id);
+uint8_t util_get_uid(uint64_t *bitmap, uint8_t max);
+void util_clear_uid(uint64_t *bitmap, uint8_t id);
 
 const char *bt_uuid16_to_str(uint16_t uuid);
 const char *bt_uuid32_to_str(uint32_t uuid);
diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index f5340d6f3..4e8a68c6b 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -550,7 +550,7 @@ static void test_server_seid(gconstpointer data)
 	struct avdtp_local_sep *sep;
 	unsigned int i;
 
-	for (i = 0; i < sizeof(int) * 8; i++) {
+	for (i = 0; i < MAX_SEID; i++) {
 		sep = avdtp_register_sep(context->lseps, AVDTP_SEP_TYPE_SINK,
 						AVDTP_MEDIA_TYPE_AUDIO,
 						0x00, TRUE, &sep_ind, NULL,
-- 
2.31.1

