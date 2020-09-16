Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90BEC43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C7C22208
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VW18xMOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgIPX0I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 19:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgIPX0G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 19:26:06 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEECC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:26:06 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id k14so181141qvw.20
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=E+m79sGOPfqC1NVoAVBQ73IS8QIMVn3x2pbxmIfIMJk=;
        b=VW18xMOTg2HToPZhkvfx/Eztw/EyvSeYj/TGQvKYaQeWKdNZ4ggf5GPWpS0K8XGomr
         jRurrCIiwLQV8sE7q88M+plybJ2YvsWNNN8p9jLwHY9xnSmHhCMGffWYecjDH4F5Ixuf
         5LiWuD/YNatkZPOalPRqywjgzNJnX4iXykTYo1GcTjDv99F1F50xWx1nUy+tHuUhriIK
         TVV+iw77AphPRVhq8D1K1vjxj6Q6JxZhf40ATQOdkPoWiG6kdvR50o1EQqGPaxs5Qbl4
         3NpioeE2UhZbEq5MwDyTfmIZvECb6vVOKvkPW/uruZYduZ40zq2Ya+zC1zea9Hu5fV/0
         2rSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E+m79sGOPfqC1NVoAVBQ73IS8QIMVn3x2pbxmIfIMJk=;
        b=pL2j+3OHfphjSuPIuKHxApFg3rW5aS6EK3GRcAM+nTFx9ZXE0B7fg+s4mR8QA2Eqj4
         VkV50opuILAHbkTRXyxwcAJ8EaZeXxPX7H9tIiyA82kn6Qut+2oMFIYfEjAaaaJRUicb
         +bPm0fhkStG18x68iUYmV4HhVbP5TCLjZP2K4nz2S8NJd5kE4l/dFZBeRAxe8lJ9ogOZ
         Cc0dcIjTjsTQH6HBuXAKSqfjqZZgnfddE7NIDC6D379afYXArLjvsCqgnnGUJMpkHr/p
         yRkv3ENgiE6cHJ87r2UOA4uk4H6eIrOMx/eoJ2tqZwxT9ADCYk/moEsLC0NkBzr3q3D/
         Bgsg==
X-Gm-Message-State: AOAM530iktbXcU5rUbXs0/sYHY6a8yHUfRlwoTbgvFnfIJ7vzPx9JsbS
        wl0F5amCDW4MS6vOquJaAeMDm3yE/1DqTWBHOJtc
X-Google-Smtp-Source: ABdhPJyTltNPH911TT2GP8+ZXBABtzTTh3lKKRDKpPP0t5fn88hR/viqqV3rNxXakZa/jVP0DVmHrEPRAkgwU3kcdUKz
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a0c:f2c1:: with SMTP id
 c1mr17616086qvm.30.1600298765472; Wed, 16 Sep 2020 16:26:05 -0700 (PDT)
Date:   Wed, 16 Sep 2020 16:25:39 -0700
In-Reply-To: <20200916232542.1584854-1-danielwinkler@google.com>
Message-Id: <20200916162155.Bluez.7.Ic9eec7749b769aa5bf73a0d8e9a31be83f232f1c@changeid>
Mime-Version: 1.0
References: <20200916232542.1584854-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [Bluez PATCH 07/10] client: Add SupportedCapabilities to bluetoothctl
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the new "SupportedCapabilities" property to the
bluetoothctl "show" view.

The change is tested by verifying bluetoothctl shows the desired
properties.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 2b0243308..cb8ef54ad 100644
--- a/client/main.c
+++ b/client/main.c
@@ -954,6 +954,7 @@ static void cmd_show(int argc, char *argv[])
 		print_property(adapter->ad_proxy, "SupportedInstances");
 		print_property(adapter->ad_proxy, "SupportedIncludes");
 		print_property(adapter->ad_proxy, "SupportedSecondaryChannels");
+		print_property(adapter->ad_proxy, "SupportedCapabilities");
 	}
 
 	if (adapter->adv_monitor_proxy) {
-- 
2.28.0.618.gf4bc123cb7-goog

