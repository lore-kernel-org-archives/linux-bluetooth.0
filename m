Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE15C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 06:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBBF6108F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 06:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhKAGKG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 02:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhKAGKB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 02:10:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34BAC079781
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 Oct 2021 23:06:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v133-20020a25c58b000000b005c20153475dso13729587ybe.17
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 Oct 2021 23:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v0aCId91YUIOcgru+L1HRukGZnNCqeqwEdd8IkAfGUw=;
        b=qjY14zW0WJR//wl9IPRAJzMc6CYtSdTqhE2PFiDodr5iuk8E6PGbPAdejPN9qUrYAk
         78POFcJjeHQjpvrF/zNmZ+PkDwamlYKRPJXFhedN+k3ve/h1Ybc4PIDllekcwItB5AYl
         6jBNRs01Pso3Vr65PoANwa4Kod5yMwFgK2Z/K/W+LTxOVqfF9Dqw2rZjjAG7WGijv2Qq
         NERvT/dqIn9j/d56yT2TXgOxVomvknbGNNh+7eyowTyR2KftZccYTnnvDsMJHoBMUR6r
         kkNsAcMNyXUKPPhJ+/ZrPiPAdNa9QHAf/f5nwG6I0V+LaZnacLuNoMcZXCRixEhqOuFf
         olQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v0aCId91YUIOcgru+L1HRukGZnNCqeqwEdd8IkAfGUw=;
        b=OfTwaAeSeGFCZB1yeGy+RgQeKiqOZHNSg1QWvHTEmLAHwn/qGb01GYhYiqmsvb9EyR
         pOwMqDFo94xoOjQ2VshtgDniuayhZwbmBpDDkMFbrng/4V4Wwh4ag5LDLOqAX0YRJ6s6
         P/zuNnvr53FQUvxNQpUwdlxHEix24rp2eFtkvL4Dk46kgtXpWX049qtjwgM1FIvJQaok
         qpk7gSVvHni+EhOGPCF6CABy+HjaGQuzCGqB4DPClOy2wrjzgqRapYF/REPxa5rKnJYB
         IQsKAiUTFMVBVoBrgAdsJBZvHK+V/sTlZ3pJAJg+FR/nroQPuBwJKsFwkpCrJtIwzHYn
         HoJw==
X-Gm-Message-State: AOAM530u1JbXidhcFfkOku9YgXG2jaN80EUs9UBzyFUz2n8kAAuWFZCW
        kBLuDexJTDJTmMXkX3i4tFQojenj02r9X1Mw+DWxTlIPFw4jnUu6DeB/zf3pmu8YleHULsIbYSu
        6QgWRFnRhOQ3BXWPRZOqo8rRB96pC5kX4faXXbqPLPnQPDZDO+cWfi2bKm6Tkf85E0DKJK46G9Z
        41
X-Google-Smtp-Source: ABdhPJy7+aVgAAt82mmjlLV1jmpSysO3aBiBjBwkDw5EAZqidd/2pPel7WARLLiE+2WRB6XMxf/+79ULEHYe
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:93ab:332e:48e3:1733])
 (user=apusaka job=sendgmr) by 2002:a25:328b:: with SMTP id
 y133mr16589670yby.233.1635746808821; Sun, 31 Oct 2021 23:06:48 -0700 (PDT)
Date:   Mon,  1 Nov 2021 14:06:26 +0800
In-Reply-To: <20211101140544.Bluez.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
Message-Id: <20211101140544.Bluez.3.Idb95ae18113225915b97a4f06983e1e41a7f7a2e@changeid>
Mime-Version: 1.0
References: <20211101140544.Bluez.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [Bluez PATCH 3/3] adapter: Remove "Master" entry from LTK storage
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

The entry has been deprecated since 2014 and it's time to remove them
altogether.
---
Hi maintainers,
While cleaning this entry, I found that this entry is involved in some
kind of storage file conversion, probably when upgrading BlueZ 4 to 5.
Should we also remove the file conversion too, since it's dated to
2014 as well?


 src/adapter.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 6b12c9e793..3a3c957a6c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3779,8 +3779,6 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
 					uint8_t peer_type, const char *group)
 {
 	struct smp_ltk_info *ltk = NULL;
-	GError *gerr = NULL;
-	bool central;
 	char *key;
 	char *rand = NULL;
 
@@ -3836,12 +3834,6 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
 									NULL);
 	ltk->ediv = g_key_file_get_integer(key_file, group, "EDiv", NULL);
 
-	central = g_key_file_get_boolean(key_file, group, "Master", &gerr);
-	if (gerr)
-		g_error_free(gerr);
-	else
-		ltk->central = central;
-
 	ltk->is_blocked = is_blocked_key(HCI_BLOCKED_KEY_TYPE_LTK,
 								ltk->val);
 
@@ -5904,7 +5896,6 @@ static void convert_ltk_entry(GKeyFile *key_file, void *value)
 	g_free(str);
 
 	g_key_file_set_integer(key_file, "LongTermKey", "Authenticated", auth);
-	g_key_file_set_integer(key_file, "LongTermKey", "Master", central);
 	g_key_file_set_integer(key_file, "LongTermKey", "EncSize", enc_size);
 	g_key_file_set_integer(key_file, "LongTermKey", "EDiv", ediv);
 
@@ -8445,9 +8436,6 @@ static void store_ltk_group(struct btd_adapter *adapter, const bdaddr_t *peer,
 		g_error_free(gerr);
 	}
 
-	/* Old files may contain this so remove it in case it exists */
-	g_key_file_remove_key(key_file, "LongTermKey", "Master", NULL);
-
 	for (i = 0; i < 16; i++)
 		sprintf(key_str + (i * 2), "%2.2X", key[i]);
 
-- 
2.33.1.1089.g2158813163f-goog

