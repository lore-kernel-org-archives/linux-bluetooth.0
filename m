Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CF5C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Mar 2022 20:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343986AbiC1Up4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Mar 2022 16:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345924AbiC1Unf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A25666ACC
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 13:41:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id y16so2584550pju.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 13:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXh09g4Z1ARJzONNdOwUr2RU/ilDa0ZcOwl+YntNar8=;
        b=DrBHBZEAQ+9SQvhIRH52MBXYg3Fyq8999vYnwxqQcddZQZDVLMGMKVjZhqQs1+mhbn
         bctMlUh7Wl0E5FNkl3+QrquP0yhHqTHCxDQEu6sQA9E7+/KAWzz6DrrpqMQp7CQaClrc
         1KnrZK2uH9wOS9d80tLPsaM7sQbAZ3w0+mdx91gNhDNX/tacb4aawA3osCFp7fmRFAcH
         y8zbV7RO1lVo72SOIfOMfQDdd4QTET0BNR2UzpkLFalZFTja7PPa43qQGZDkPcTDE2sc
         LGdSA5/1ApkmjQrXTWjmKcETP1GzVk2kSbc7Rs7kScNOG7jZxmlB1qy/teXGbbZ0hYFu
         sYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXh09g4Z1ARJzONNdOwUr2RU/ilDa0ZcOwl+YntNar8=;
        b=d5jB6iWLJlmT8OCroa6yxRNvm0a19ukWNNPREUVGLAtQbgeSwG9qNONapDdW/+flpn
         xtZTm9NIJN1ixsjj4W8ghnRnwlCRJVnCGS0ZvUMLgUNgqUUgr1rV8ooAj0EApF3tosEV
         yLDiYFec5tBcqrXUoKEslo7wyEpej33ERUkHVkcM1rxaV+37OwaE/c8gKLwyIcqi6/E0
         dC/WACKbWyW1Eef4zqff5zC8UTGeznnxftEQjrBzNG3SZaNH/jcaDAW6pjXgEQ6TjwPQ
         qPr+M9z94Es7c7N8ID1HQ8FAtj0f0/svkYq0FqVaZd36NgxhYZVmPcgdLft168J+q/oJ
         /2HA==
X-Gm-Message-State: AOAM533Z3p2N+UYambiqspEUBX87dWK5M0YAP9enEFwObmTgRxcCfGR0
        OsuiXH6U0X/AzyA1Lnd8jTGGilRiYGM=
X-Google-Smtp-Source: ABdhPJxsbq2Cu54hzYQP4+V4Hd+bxKx3ZwcbFCcvAa+sO1TMiBswNB4iX+gBWKysC8+5Y3EkGfoebg==
X-Received: by 2002:a17:90b:250f:b0:1bc:e520:91e6 with SMTP id ns15-20020a17090b250f00b001bce52091e6mr928900pjb.43.1648500111343;
        Mon, 28 Mar 2022 13:41:51 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id gd10-20020a17090b0fca00b001c75d6a4b18sm362040pjb.14.2022.03.28.13.41.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 13:41:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] a2dp: Fix crash when SEP codec has not been initialized
Date:   Mon, 28 Mar 2022 13:41:50 -0700
Message-Id: <20220328204150.1855063-1-luiz.dentz@gmail.com>
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
 profiles/audio/a2dp.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c3ac432a7..db788cf93 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2074,6 +2074,11 @@ static struct a2dp_remote_sep *register_remote_sep(void *data, void *user_data)
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
@@ -2148,6 +2153,7 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 	struct avdtp_remote_sep *rsep;
 	uint8_t lseid, rseid;
 	char *value;
+	bool update = false;
 
 	if (!seids)
 		return;
@@ -2206,10 +2212,19 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
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

