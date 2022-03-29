Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90557C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 21:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiC2Vee (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 17:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbiC2Ved (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 17:34:33 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6464B239320
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 14:32:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bx5so18754784pjb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 14:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=56fbgVdh1J5rDKNt0tG5KJcZBRHreXxak00Yp74aW1I=;
        b=ilSQ+/cHwPPlNj/TePc5MDo2j/KnT225LrnwfjrNBqYAGqJ6Z3bmCatFDmFzSVHWpw
         /e/HElBEGwvKsiECTdsI2d7jlxEtsUqhEsNO+rsxdKynKJz1orTom6FlRn0nYkFXLOKj
         kM4oa8pGvpywps50t16GHe+lvF6/ua+OagiFvInsphng1QmgwIbYyqryb+xn5qzVXgqa
         MUKAQn3DTQtmHQBVDRUGjN7zXITqnVqRHKnW/KZmN9VSgkf/Cpd8FI70tmdNhdp10LW0
         Y7uc6Kr9wSauwF+n5P/k1eD3gZrFav4W2Kn/AsMoT96pST7kRwFeepaTsCbzOpGzkd07
         aCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=56fbgVdh1J5rDKNt0tG5KJcZBRHreXxak00Yp74aW1I=;
        b=zP8he6+BhanDW1sGr8ty+qTJnUZ8TFyODrojVDYYSi456fOBVrxJ2l7rLpE14kfJjN
         wzBpk0rWfB8ZtKe0NCyUROfGMrV3eORRJ4AI2zmNlLJHmxk+wDd7pRPrkUlCccs2233C
         Hsph9ekuAAX1Qnfhh/2iXeRbU4QmkNhqmhIhQiJGy5jSe9yF823xtEbBHBcc2afZDzUP
         EIodWm30/WrX0Yynwp58CIjfMFfIXZAnr9ZsGm9Bb6mPWCg7vCi0FFAcbfuIAYOS1Sw3
         6UuHkMUo1dSN2Ha15gbZP3mOBb6HhfEZUdlgeZ4eazyuDTwivUy9GZWIuwrKnFSF5/Qi
         fsXw==
X-Gm-Message-State: AOAM532FFrFwHIKbiqXvSv/p7RFNz56ewzisvDt0WS0f0XEV2nDcM8Bg
        LwVLYaqd2bgQZfpFcm/YLzAF0Y2Ixio=
X-Google-Smtp-Source: ABdhPJwANd4TMVFggMhc0v6IEziRWKfZmDAlgos66bIIVLlx0doWtkD8HAApi+oYE1BZ/Ft2VcF1XQ==
X-Received: by 2002:a17:90a:7d10:b0:1c9:7939:c70 with SMTP id g16-20020a17090a7d1000b001c979390c70mr1146012pjl.203.1648589568311;
        Tue, 29 Mar 2022 14:32:48 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w63-20020a638242000000b0038631169c02sm15657012pgd.57.2022.03.29.14.32.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 14:32:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4] a2dp: Fix crash when SEP codec has not been initialized
Date:   Tue, 29 Mar 2022 14:32:47 -0700
Message-Id: <20220329213247.2334757-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If SEP has not been properly discovered avdtp_get_codec may return NULL
thus causing crashes such as when running AVRCP/TG/VLH/BI-01-C after
AVRCP/TG/RCR/BV-04-C
---
v4: remove queue_isempty check from store_remote_seps since that prevents
cleaning up if no seps could be registered.

 profiles/audio/a2dp.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c3ac432a7..5c20e5807 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -829,9 +829,6 @@ static void store_remote_seps(struct a2dp_channel *chan)
 	char *data;
 	gsize length = 0;
 
-	if (queue_isempty(chan->seps))
-		return;
-
 	ba2str(device_get_address(device), dst_addr);
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
@@ -2074,6 +2071,11 @@ static struct a2dp_remote_sep *register_remote_sep(void *data, void *user_data)
 	if (sep)
 		return sep;
 
+	if (avdtp_get_codec(rsep)) {
+		error("Unable to get remote sep codec");
+		return NULL;
+	}
+
 	sep = new0(struct a2dp_remote_sep, 1);
 	sep->chan = chan;
 	sep->sep = rsep;
@@ -2148,6 +2150,7 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 	struct avdtp_remote_sep *rsep;
 	uint8_t lseid, rseid;
 	char *value;
+	bool update = false;
 
 	if (!seids)
 		return;
@@ -2206,10 +2209,19 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 		}
 
 		sep = register_remote_sep(rsep, chan);
-		if (sep)
-			sep->from_cache = true;
+		if (!sep) {
+			avdtp_unregister_remote_sep(chan->session, rsep);
+			update = true;
+			continue;
+		}
+
+		sep->from_cache = true;
 	}
 
+	/* Update cache */
+	if (update)
+		store_remote_seps(chan);
+
 	value = g_key_file_get_string(key_file, "Endpoints", "LastUsed", NULL);
 	if (!value)
 		return;
-- 
2.35.1

