Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BEFC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 06:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1C82065D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 06:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JyxqM0AV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgHRGT5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHRGT4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 02:19:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52735C061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 23:19:56 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id s14so2763372plp.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 23:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v8dabrhlWu3e/wsWUIqU4VU/Ni4HgcY/lR6u+xEeuiY=;
        b=JyxqM0AVdgHdtKH/dROXrfVgQ3zh+dHolL34HblszStQRndNwBScQ7beZ9Pl9WQ28e
         Rddyv+TQ9QqnwfirBZrZFm7oF9AFJ0YTFjs6HOYapPROdbo+ZWf4DajrIcHpot9/xaG4
         RpqQrqts+IAcaDds+k1ShRJ0JwgHTQ2P7LlJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v8dabrhlWu3e/wsWUIqU4VU/Ni4HgcY/lR6u+xEeuiY=;
        b=anEGcfkN4pD+rND8HizJDQA/WnggW2kY76fqN92v/fSNn+tqxb67u7zhrJSPD2bP9Y
         K+Ac6Isg6pU1KPyaKkEuGM+EUdExtiqpaTV1qV34Vni7IcSlniQkJS957SSrwmz5pA+T
         ZkKkVQ1FtGRBx0rTlNI5TXkpt+b8wtdufGwffQ7ZchEjcYtlWukhoeprw/823VaKhlDK
         lc06yjMRmfDrkJ7YgFQOxUuprpa696h01PJOuFyGJKrawT4QZDHJwhNBg+HdILVRVBMG
         WEIaeNNdGmRRlfNiCxSdr2CkhVGOK2VVLIv4HI6ZCZDCItcmVvHrLAY032NU57tDHJee
         QuUw==
X-Gm-Message-State: AOAM531o5wFK2PyesHCUiBRB5S8kAkdJrFQd1vMp3/tQg//JeebDirQP
        mdg9jZlhfw4cHEJu8sEfhIBEA40YQa/Gzg==
X-Google-Smtp-Source: ABdhPJxw9hc6D8N0fvmwnmf9pSY3tL0pC7U/t2JoJ4tTO1XIbQPZaBXNs+GZexwcI10QgAzAJjG7pw==
X-Received: by 2002:a17:902:d34c:: with SMTP id l12mr14638810plk.36.1597731595087;
        Mon, 17 Aug 2020 23:19:55 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id b20sm22745580pfp.140.2020.08.17.23.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 23:19:54 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v3] shared/ad: move MAX_ADV_DATA_LEN macro to the header
Date:   Mon, 17 Aug 2020 23:19:39 -0700
Message-Id: <20200817231822.BlueZ.v3.1.I716fc87b0c97e5349a04766a61ecad1f5b0fd28e@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This moves MAX_ADV_DATA_LEN macro to src/shared/ad.h and rename it to
BT_AD_MAX_DATA_LEN.
---
Hi Maintainers,

In order to avoid duplicate definition of the maximum data length of
advertisement for the following series of advertisement monitor API,
we'd like to reuse the one in shared/ad.

Thanks,
Miao

Changes in v3:
- Fix occurrences of MAX_ADV_DATA_LEN.

Changes in v2:
- Rename the macro to BT_AD_MAX_DATA_LEN.

 src/shared/ad.c | 18 ++++++++----------
 src/shared/ad.h |  2 ++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 8d276842e..14a2709b1 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -33,8 +33,6 @@
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
 
-#define MAX_ADV_DATA_LEN 31
-
 struct bt_ad {
 	int ref_count;
 	char *name;
@@ -257,8 +255,8 @@ static size_t name_length(const char *name, size_t *pos)
 
 	len = 2 + strlen(name);
 
-	if (len > MAX_ADV_DATA_LEN - *pos)
-		len = MAX_ADV_DATA_LEN - *pos;
+	if (len > BT_AD_MAX_DATA_LEN - *pos)
+		len = BT_AD_MAX_DATA_LEN - *pos;
 
 	return len;
 }
@@ -426,9 +424,9 @@ static void serialize_name(const char *name, uint8_t *buf, uint8_t *pos)
 		return;
 
 	len = strlen(name);
-	if (len > MAX_ADV_DATA_LEN - (*pos + 2)) {
+	if (len > BT_AD_MAX_DATA_LEN - (*pos + 2)) {
 		type = BT_AD_NAME_SHORT;
-		len = MAX_ADV_DATA_LEN - (*pos + 2);
+		len = BT_AD_MAX_DATA_LEN - (*pos + 2);
 	}
 
 	buf[(*pos)++] = len + 1;
@@ -478,7 +476,7 @@ uint8_t *bt_ad_generate(struct bt_ad *ad, size_t *length)
 
 	*length = calculate_length(ad);
 
-	if (*length > MAX_ADV_DATA_LEN)
+	if (*length > BT_AD_MAX_DATA_LEN)
 		return NULL;
 
 	adv_data = malloc0(*length);
@@ -586,7 +584,7 @@ bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
 	if (!ad)
 		return false;
 
-	if (len > (MAX_ADV_DATA_LEN - 2 - sizeof(uint16_t)))
+	if (len > (BT_AD_MAX_DATA_LEN - 2 - sizeof(uint16_t)))
 		return false;
 
 	new_data = queue_find(ad->manufacturer_data, manufacturer_id_data_match,
@@ -723,7 +721,7 @@ bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
 	if (!ad)
 		return false;
 
-	if (len > (MAX_ADV_DATA_LEN - 2 - (size_t)bt_uuid_len(uuid)))
+	if (len > (BT_AD_MAX_DATA_LEN - 2 - (size_t)bt_uuid_len(uuid)))
 		return false;
 
 	new_data = queue_find(ad->service_data, service_uuid_match, uuid);
@@ -942,7 +940,7 @@ bool bt_ad_add_data(struct bt_ad *ad, uint8_t type, void *data, size_t len)
 	if (!ad)
 		return false;
 
-	if (len > (MAX_ADV_DATA_LEN - 2))
+	if (len > (BT_AD_MAX_DATA_LEN - 2))
 		return false;
 
 	for (i = 0; i < sizeof(type_blacklist); i++) {
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 19aa1d035..17e3b631b 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -27,6 +27,8 @@
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
 
+#define BT_AD_MAX_DATA_LEN		31
+
 #define BT_AD_FLAGS			0x01
 #define BT_AD_UUID16_SOME		0x02
 #define BT_AD_UUID16_ALL		0x03
-- 
2.26.2

