Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F9BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 19:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC1961BCF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 19:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbhKQTSN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Nov 2021 14:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240420AbhKQTSN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Nov 2021 14:18:13 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1F5C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 11:15:14 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id s8-20020a63af48000000b002e6c10ac245so1562129pgo.21
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 11:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NrI132Th5kjg0DS+zwQPNWwLlybgHpWaafBqwEcowOA=;
        b=ovr94Sh2PeWXRkDdjddqon9cmpesRJXR294JtYA/fTidlB1mFrTkbc4o9YGTOyLGav
         chSn8DzlUXYqAdnUkSUG6pbFylvwdXuKhpB9W1rq+NBMjJbw6HbAeWaN8ZhX0ngMCtsu
         zGdY8ci+RDrEAd8YpeNCFDIIBm/dGM4QWYC5XfXYqdBA2uXi0M84LqV/q48VPSyf+6nU
         I18cL6Caf2Tl8MPkdCsjEi8kBQAg3U/+EMWQUO1GhQLbhEsZTyECWTbGHpv6pSzFCgDg
         pz/1eWd/aJu8wcw63uUcnaTwv9BgXnC7ZwB4Xb31HPelLWQOw913Evtqn4zTspfNI8+D
         eOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NrI132Th5kjg0DS+zwQPNWwLlybgHpWaafBqwEcowOA=;
        b=DEChGSapikUDMjie8BWdmpQi9y0x1kTit1jzwl2ZFAtH/sUzoc/LV9jEWnuBhelvkl
         s0itN4AH8QgKtvTtWia3MJ6kfBOPsp2HuP2V3T+1O5RsOnAXEoxBIcf3ZGoH6KbCd4E9
         O7mNo+nXn2SBFE9Tu4xm/SfiC2kC2ciHyuvLSAgWn7sniGjcU6VjZ8t4BQsjrwi1/SZy
         4GhOJ1oIc8cRPE1Gowl1aLNLbkOy/EhzcUFYZF5ZoDl5PwOe1TYMhnQ9MXQPggJMhcCk
         +GOMMzTu7dXZWZgy1UP+RGv5ClxRPm2RMvCEA9F0zQ3EXKM83jWOQ/XeE84hCQawo3Oq
         LbDQ==
X-Gm-Message-State: AOAM531E806Vbna+VzRXDW7Df/4PLyBlZy2TIJVvdh3tBvkOV4FKmUPq
        nge3UsmNokQtbcv81S349BnbJ01x6a3nvw==
X-Google-Smtp-Source: ABdhPJwVMpwu8ph7QnjICT44FHC6rrxuh0usmd1Qwf+vThgvZWdMLdeiw/pLPAMUpuzoh9wpId+VvjL5Nw5axg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:b1b3:555c:d0fb:8921])
 (user=mmandlik job=sendgmr) by 2002:a17:903:4053:b0:143:6d84:984c with SMTP
 id n19-20020a170903405300b001436d84984cmr59080794pla.37.1637176514154; Wed,
 17 Nov 2021 11:15:14 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:14:50 -0800
In-Reply-To: <20211117110627.BlueZ.v5.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Message-Id: <20211117110627.BlueZ.v5.6.I363090b80e59a3cda134c9bd2df0b3bca2cb527b@changeid>
Mime-Version: 1.0
References: <20211117110627.BlueZ.v5.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [BlueZ PATCH v5 6/6] core: Update default advmon Sampling_Period to 0xFF
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

Changes in v5:
- New patch in the series. Update default Sampling_Period to 0xFF.

 src/main.c    | 2 +-
 src/main.conf | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
index e05291d8e..e49259453 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -260,5 +260,5 @@
 [AdvMon]
 # Default RSSI Sampling Period. This is used when a client registers an
 # advertisement monitor and leaves the RSSISamplingPeriod unset.
-# Default: 0
+# Default: 0xFF (Report only one Adv per device during the monitoring period)
 #RSSISamplingPeriod=0
-- 
2.34.0.rc1.387.gb447b232ab-goog

