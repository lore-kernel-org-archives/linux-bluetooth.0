Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2125C4320E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 15:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3EC760F4C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 15:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbhH2PvN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Aug 2021 11:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbhH2PvL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Aug 2021 11:51:11 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EDBC06175F
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Aug 2021 08:50:19 -0700 (PDT)
Received: from monolith.lan (91-152-122-41.elisa-laajakaista.fi [91.152.122.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 07BBC1B002C6;
        Sun, 29 Aug 2021 18:50:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1630252216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mp5iApx69YfcZKBsn2lUExWDUnwLiH0Jop2vWribr+E=;
        b=Cl558A2YOMDrzwjEB2McAcO5WM5rXka7rHp6sg0zA+r+Z6qO9B1xJNOXa48kLzi/J3Mwxa
        FTihevzHLW8bMyGCbYtdiL10LJdqkTlvrjgekkxF450eLa0fEfq4dKgR+3BqpupuEd22QT
        rfoThyTf0lObeHXljE3hz/oET7BsO/Pr+L6gGzTt7SpMXXzbgTw/IxgbACEgogEcGTHFqp
        jlhd/vUI04x1RVpUZxilEcv0N1Z0B4egBt4eMPRMpUc+3ISw4Vcy7T8ZEaGGpeHrjZ9wGh
        gwmzjPDOUhvMKB5rYPRFVBn1PizuzexSdYl93rsZ59SYorGhufGwpVkfLhmhEA==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] shared/util: use 64-bit bitmap in util_get/clear_uid
Date:   Sun, 29 Aug 2021 18:50:11 +0300
Message-Id: <20210829155012.164880-2-pav@iki.fi>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210829155012.164880-1-pav@iki.fi>
References: <20210829155012.164880-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1630252216; a=rsa-sha256;
        cv=none;
        b=fxsDn9k7yw4Kq2O0zMNLr6j3ZwE4wHNWpsG9/vwPnK9/kInFMuLVWfvcWNsXpLkaORRpyI
        atp8gP4+lEcMUD26J48Ut7OvoDcHI/miGnIbSxE7mjO0c6CkyHNbQiFRXTaxNTaTxpRLeO
        8NihWgEjHCiXwzljiSQT8S5bus356uiYBqmAgkbrDPghUGWUVolzem4LQJJhHCn7ZPs1Zx
        900qPW4OyhyNRe+FsGjt+Hr/BLQmNX8j+tmze2JKz3H5bKCIvuiPVFwXZw1u1mGTv/46Lr
        zpnBfMi0ghZ1kmavChk4abm5vplEUWJ5q6A3alawPPqDNctFLbDOVmusnv4vWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1630252216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mp5iApx69YfcZKBsn2lUExWDUnwLiH0Jop2vWribr+E=;
        b=PewGPKyRgeC63vqqBBAoXR6NnKIzWawEeUuAvGUjfILWjX9g+FDKMuhny3UvlflOaPR4f+
        ORKbWRDz+f7S6zxCAsdTDDvw2gWiRREUAaC4rubc+cSvR6SY5rh0NiqKHUAFK1XZoIvRJc
        JK2eaeq7FYk3Hi9niwHD67CTppX+cowdKQi2TQe74teiZAfxt3rk7h2GkJ/jAn3ESP90cE
        oMn/YBtdyoOnicZceIQKLaM1AG/Mr471DertlF5Wuic4he41pkHTPBze2KsPLcrZDg8gjf
        QB0dXTfYvW0ZlpfkDB+dyCHcWnKCIOeChS8PQpnQKiVWe/6IjQIKmpQwjd59+A==
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
 android/avdtp.c        |  2 +-
 profiles/audio/avdtp.c |  2 +-
 src/advertising.c      |  2 +-
 src/shared/util.c      | 27 +++++++++++++++------------
 src/shared/util.h      |  4 ++--
 unit/test-avdtp.c      |  2 +-
 6 files changed, 21 insertions(+), 18 deletions(-)

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
index 244756456..723dedd75 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -124,30 +124,33 @@ unsigned char util_get_dt(const char *parent, const char *name)
 
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
+	if (max > 64)
+		max = 64;
 
-	if (!id || id > max)
-		return 0;
+	for (id = 1; id <= max; ++id) {
+		uint64_t mask = ((uint64_t)1) << (id - 1);
 
-	*bitmap |= 1u << (id - 1);
+		if (!(*bitmap & mask)) {
+			*bitmap |= mask;
+			return id;
+		}
+	}
 
-	return id;
+	return 0;
 }
 
 /* Clear id bit in bitmap */
-void util_clear_uid(unsigned int *bitmap, uint8_t id)
+void util_clear_uid(uint64_t *bitmap, uint8_t id)
 {
-	if (!id)
+	if (id == 0 || id > 64)
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

