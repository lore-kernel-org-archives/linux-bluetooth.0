Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4B5C3A5A0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 12:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D0322072B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 12:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="YwFvCfgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgDTMHQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgDTMHQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 08:07:16 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A55C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 05:07:15 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id k28so7692758lfe.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 05:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3xWBQSiSZ6MtF4M51tRNrK/xgva62ZzZGHbHgiRE9lw=;
        b=YwFvCfgZQ4qIlHrrNCHt09qJkLhLyC3Q9/2pvhZl7CFMhokkfk0xci5MB7e0apiaD5
         6vTMzoxZcncHm+4sXoDAj6f/2Owpnd3KfWgR/EZV+Bu7KUtSdtAWwjqbKz2iv0+6jPE3
         luFXRXsT+wapSEZDr2XxJWeTuClCPI50sKTqKNCMeZ4drlnH7VMZ8W8BffLfSMhFmhKw
         7O3M+eNxSd8DHfZcK4m1BM1K4zH6TX+pxNFKZ9UiBVb2yiIcjmuHeUYUhSddZPYFRujT
         qOxaJqC5saxYtUzEx+EIr/zceOqEsxKyGNApk9ELi/XcsbCgc8Flp812UsThD34o3u/r
         5Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3xWBQSiSZ6MtF4M51tRNrK/xgva62ZzZGHbHgiRE9lw=;
        b=Pye2T9PZdG+7cn1MWgbwOFcVgLLhs4mRdJo3gQujz1mPMFN3xzP6IqTkVulv5HDJVE
         9fVB16JN45+JVg1OZV45pxoMxZQeQmsJrFwowuK1FG1YCDGTvtqu7CIWhtr9rPbxr6mp
         1tTDw3k2N0/RYORHUIzQcoNr5ksdYANVuAYku/FwOTjhbPNjzY7nJMpbe1guPKLvdGHG
         NlG7teT7vkj99iGsPFSP5S0A+f3Zb6iiCrEPqmhzMW36nUgaVVLK+hOqUrCyp7rn1chj
         JFdfoKc6ZkJEWryKVH0wZzd3MbLOCLrYmn6lKwLvBEKKvljBKqXxeAEsVdYOwE69AzgD
         D7gQ==
X-Gm-Message-State: AGi0PuZKe0doHSXEDWzMi3QkzNy8umdyw1jLb+9ssrI9N+XyE8uhM6be
        uMZVE8aIk5T8tUUD7EjmkI/DtL5mG3U=
X-Google-Smtp-Source: APiQypKbwArGmX44jFmr0dilEkprUzadIBo+q94qDjewPzbn4SibpwmM5bIDX18rXq8OgFl+0QfDhQ==
X-Received: by 2002:ac2:46d3:: with SMTP id p19mr10004386lfo.72.1587384434077;
        Mon, 20 Apr 2020 05:07:14 -0700 (PDT)
Received: from localhost.localdomain (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id i18sm666814lfo.57.2020.04.20.05.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 05:07:13 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 4/4] device: Fix compilation with GCC 10
Date:   Mon, 20 Apr 2020 14:07:05 +0200
Message-Id: <20200420120705.89691-4-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420120705.89691-1-szymon.janc@codecoup.pl>
References: <20200420120705.89691-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Class is using only 3 bytes so make sure GCC is aware of that.

src/device.c:397:3: note: ‘sprintf’ output between 9 and 11 bytes into a destination of size 9
  397 |   sprintf(class, "0x%6.6x", device->class);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 5f9ad227d..a8d95346a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -394,7 +394,7 @@ static gboolean store_device_info_cb(gpointer user_data)
 		g_key_file_remove_key(key_file, "General", "Alias", NULL);
 
 	if (device->class) {
-		sprintf(class, "0x%6.6x", device->class);
+		sprintf(class, "0x%6.6x", device->class & 0xffffff);
 		g_key_file_set_string(key_file, "General", "Class", class);
 	} else {
 		g_key_file_remove_key(key_file, "General", "Class", NULL);
-- 
2.26.0

