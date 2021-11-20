Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7841DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Nov 2021 15:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhKTPdK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Nov 2021 10:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbhKTPdI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Nov 2021 10:33:08 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB5FC061748
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Nov 2021 07:30:04 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id l10-20020a17090a4d4a00b001a6f817f57eso6200550pjh.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Nov 2021 07:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=17tQDHDQUht1fmHeg8bl5FT/hN7QDbl//pQvYVh8C8E=;
        b=ZNSi3z2/YiTkOmVzIENDjW5bIf2BtqaV7lT+GxzBL4zDQUOo7lzVyKYAffXqK2nPUU
         uU+cHaZGfzcTuKEZRd+9o70sLdAii6wrHS8k4krW1myZO3P2jwIN/Dd+6Lri6OfxALAj
         uVeE1KQL0YuT8xjmFn1RqE1z6TcqMwhr2e9Ua7NgVs1F4RzjK5AzFM7Eo8Wt41mkHgyE
         GYoj8vD3sxK7dT4CYL5TrH8X9r4E+qc39BxBuP1RZ/jfHP4HA5OgDl59sNaMibWMnVpC
         7JlwJCsIXAOPHNGiNuI6H5vG5cxsqtGnbJygpik/iHGEF9Fj1VyIHeFLkOhHLEHwJ8z0
         zbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=17tQDHDQUht1fmHeg8bl5FT/hN7QDbl//pQvYVh8C8E=;
        b=x0hj5FEQjOGLJpFvUCCFe4ux5MJDo4seqZvHNyokx0hpJACEAw2DifIb0Mcd3VYJFB
         PKBU6SCTRuuVMh0hZS5+LYah2wHzOk9abM39e5s+VU/pfuuCmajVENCOvPgH5CclYwqJ
         gbfiOhpLCIp/uazVy8yrHiC64vUGtlBFCZ54CZkHdZTKnnAJ8E14wvFBLtE0hS0owuJQ
         ckk5yQhPfDDKusZcYzg/Ah7Rld3Rkwoz9R1f0DA7pY4wcmJJhHiBhrHzyjm6d5Ciu0Ar
         8R17qEE/j7S5E1pnl1UjwF79DtExnbq/Z20/lWzUXeaNp7bcguDvDcqBsmQhOnbbt1oe
         zVGg==
X-Gm-Message-State: AOAM530GaHl+o1g+NjuA5OjVLvhSe6Ciet7lpHVycU+wekrlHd0ql1//
        jcCsmzFeAe4729KXCYuQZooetTM2TBtzYg==
X-Google-Smtp-Source: ABdhPJzGqTF0xRBi4njm+F8IcsKFt61jH7R+I9m1ApoIx8mfmBFbVkzMXZtJblLTkkpU8V2bNYXYEHfao5MqDg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:8437:70f3:c03b:1c71])
 (user=mmandlik job=sendgmr) by 2002:a17:90b:1e0c:: with SMTP id
 pg12mr11234526pjb.135.1637422204262; Sat, 20 Nov 2021 07:30:04 -0800 (PST)
Date:   Sat, 20 Nov 2021 07:29:41 -0800
In-Reply-To: <20211120072449.BlueZ.v6.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Message-Id: <20211120072449.BlueZ.v6.6.I363090b80e59a3cda134c9bd2df0b3bca2cb527b@changeid>
Mime-Version: 1.0
References: <20211120072449.BlueZ.v6.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [BlueZ PATCH v6 6/6] core: Update default advmon Sampling_Period to 0xFF
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update default Advertisemet Monitor Sampling_Period to 0xFF. It
indicates that controller will report only one advertisement per
monitoring period for a device. This will help reduce the power
consumption drastically.

Reviewed-by: Miao-chen Chou <mcchou@google.com>
---

Changes in v6:
- Update information about the value range and units.
- Update commented entry to use the default value

Changes in v5:
- New patch in the series. Update default Sampling_Period to 0xFF.

 src/main.c    | 2 +-
 src/main.conf | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/main.c b/src/main.c
index 5ca8d5644..1f852fdf6 100644
--- a/src/main.c
+++ b/src/main.c
@@ -932,7 +932,7 @@ static void init_defaults(void)
 	btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
 	btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
 
-	btd_opts.advmon.rssi_sampling_period = 0;
+	btd_opts.advmon.rssi_sampling_period = 0xFF;
 }
 
 static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
diff --git a/src/main.conf b/src/main.conf
index e05291d8e..17795a847 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -260,5 +260,9 @@
 [AdvMon]
 # Default RSSI Sampling Period. This is used when a client registers an
 # advertisement monitor and leaves the RSSISamplingPeriod unset.
-# Default: 0
-#RSSISamplingPeriod=0
+# Possible values:
+# 0x00       Report all advertisements
+# N = 0xXX   Report advertisements every N x 100 msec (range: 0x01 to 0xFE)
+# 0xFF       Report only one advertisement per device during monitoring period
+# Default: 0xFF
+#RSSISamplingPeriod=0xFF
-- 
2.34.0.rc2.393.gf8c9666880-goog

