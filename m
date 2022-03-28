Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAF1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Mar 2022 20:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbiC1Uip (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Mar 2022 16:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345855AbiC1UiE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Mar 2022 16:38:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2835049241
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 13:36:23 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y6so13176313plg.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DR2NA8PJy/hc5j7I7Pz/LAgj1jWP/gvnQuzYvwt+XcM=;
        b=Ie2org5knWrEU3+rqc9w2B1fCPvSQJR/sRO9q153gCJl72Dg6JQ/KIjBUpdLs8gBj3
         4/y2Y/BGfhb2jJxQzMu8McOFZdmKhIdvXuHPUwvXwzimpgHF+tt49dNga79M6TFhLG2r
         UNcrXCVu3POGMZBRQLTROrjofTTRYl+zBDPda0CRa8WMmHAxyx9GZ5QhBJGpaGJZigzg
         B2Q7WgmXME46PwCkVA0qbJdyYfNPFE908YyubGriD44Lr70mV7ADiuMycbI430odPVZS
         mssuKjrxegZ3OJDIMP4q8ZNdasH8x54DNtUUXUY9hQiSS5gOOE5PJyj2XB1K4SQfsAb9
         VSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DR2NA8PJy/hc5j7I7Pz/LAgj1jWP/gvnQuzYvwt+XcM=;
        b=gTmwWJoEbI3+81GZqH5WopcgNqVqbMkL1emU+e69+zLwdXekdhny1w4AiVrLQTlk8K
         hGjvVo0wdvj7Za9WBexIuAoNJbZhiNZ7odNf9nTHnqp7CXN/7nBlW6vD1Y8huVxFaTYF
         g5EE99y4yxdP/1D/4KaUlFxRZlAlQto2ETusNcvRX4g870JPM7/Pj2n68O8aOgB7e6WR
         fJN4+r08zDP/D6jDhEhGilsBnJMXqgoncE8hyVQHRq8zcPLtL1KcydKh2bP51PaoXL2+
         V1f6MOJBvysATg/+w6aXMLw5QhlwNN0lO1KyvbIndsKF/GkAwxbqQWve636jYJ54cKMk
         0o9g==
X-Gm-Message-State: AOAM5334Kyf3cLRktoxaN0CUa2Vy0M2xzJIju6rNdiwYYvGgjRz6mVZE
        rlEERyo00g8qCRzebH4sKBIJFxUI5k8=
X-Google-Smtp-Source: ABdhPJw9/hRAys2isho4ttkJM+WzjC09UYoI8dsqr14NOX8j4NwE17cINzHqt1KhNxywqI7zW9Hkuw==
X-Received: by 2002:a17:902:c40c:b0:154:837c:5b2 with SMTP id k12-20020a170902c40c00b00154837c05b2mr27800034plk.46.1648499782460;
        Mon, 28 Mar 2022 13:36:22 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a1f4f00b001c7ecaf9e13sm349769pjy.35.2022.03.28.13.36.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 13:36:22 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] a2dp: Fix crash when SEP codec has not been initialized
Date:   Mon, 28 Mar 2022 13:36:21 -0700
Message-Id: <20220328203621.1853081-1-luiz.dentz@gmail.com>
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
 profiles/audio/a2dp.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c3ac432a7..52a21357b 100644
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
@@ -2206,8 +2211,14 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 		}
 
 		sep = register_remote_sep(rsep, chan);
-		if (sep)
-			sep->from_cache = true;
+		if (!sep) {
+			avdtp_unregister_remote_sep(chan->session, rsep);
+			/* Update cache */
+			store_remote_seps(chan);
+			continue;
+		}
+
+		sep->from_cache = true;
 	}
 
 	value = g_key_file_get_string(key_file, "Endpoints", "LastUsed", NULL);
-- 
2.35.1

