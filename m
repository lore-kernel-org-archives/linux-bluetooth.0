Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85106C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 01:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242456AbiCUBid (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Mar 2022 21:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239687AbiCUBic (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Mar 2022 21:38:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499E9DD971
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x9-20020a5b0809000000b00631d9edfb96so10943178ybp.22
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HzBVKHokxfG6S7lseDnOBheRWh/dqD/0K8SGlgy6lu8=;
        b=MAlcl39Vv4u8uf8wfbbLX0A/Sp4Hn0QNrmFa5ud3t81gVl8UKLSLLMHFHtShD9UmOW
         /Lp3TxraGWAkCKzrKs9JuUt5pgrFGlRkqLFznTcaYzeJHzDr1MSX55TK8S4CCaImxbO/
         rQs8hMyiUieHe2RJeWgkqkGdhJDEqltznzAH7N5Gq2qdjnrW3fwMZoUqpuChDxeKnib+
         ZvOFx6cpU5ujl7eo8dmfm0/JlqB+pxtGWjBlV6ZPLdUlNy4Fw0uKoIeo2zB9DNdoYoUR
         NxJl3d50A+bpisKNxGjHuKktPIFq9pg0SnVJwrIpetYjqFXXAK5y2PHcBJaaHhzoY7vl
         j9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HzBVKHokxfG6S7lseDnOBheRWh/dqD/0K8SGlgy6lu8=;
        b=M3ps0z6vSHAIOsHhPhVQhe8iFhshQzrqIgetPuREHFtEWIwE9TWtbn2UqHPTP2A3yp
         IgbYSzJlbXvv7T4S2JreLnRXnxWXeA0LeGSWM65IqIEAhzaMVPlTh7d9K66try/5aM16
         3odUPBd+DI0cvx030tpoKk4UGs3pY96P0uXpvrmg0NsPgkK2XqzTAw2BCk8a9sxcpZ1/
         qWSa80zDRHDxj907FcPByBHfbScs7DrCMI4ibLULs42EIMJsr/HO195x0LbaKsVJavX3
         s3yrkz5Dy5g5brmbm6LRTS+QDfZM21Zrz0o4edf7VvvRnyqmeO641jf2nMlyAgPun32d
         a8ag==
X-Gm-Message-State: AOAM533JxppR9ax03Hqa1rJSgRKMTluEYR0wqrjlUyVwCJ6lrrC5R7J3
        J1QEsGwRFI5vS1PdGgE/VJxw75IT1gxMDw==
X-Google-Smtp-Source: ABdhPJxa5H0XEYgb5c5UnmltAGYrG6sR1a0KRcIRWEZVx3v4ybsizLypNLg1kt1CyWVlWLu45RLXZdOMjTg/iA==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:e0cb:81c1:7b8f:ab9f])
 (user=mmandlik job=sendgmr) by 2002:a25:cac5:0:b0:629:3595:a4bd with SMTP id
 a188-20020a25cac5000000b006293595a4bdmr20111758ybg.304.1647826627547; Sun, 20
 Mar 2022 18:37:07 -0700 (PDT)
Date:   Sun, 20 Mar 2022 18:36:55 -0700
Message-Id: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [BlueZ PATCH 1/9] adv_monitor: Disable RSSIHighTimeout for SW based filtering
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Controller offloading does not support High RSSI Timeout. Disable High
RSSI Timeout for SW based filtering as well to provide a consistent
behavior between SW based and controller based monitoring.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 doc/advertisement-monitor-api.txt | 5 +++++
 src/adv_monitor.c                 | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
index 9189f2cce..942d44b2f 100644
--- a/doc/advertisement-monitor-api.txt
+++ b/doc/advertisement-monitor-api.txt
@@ -79,6 +79,11 @@ Properties	string Type [read-only]
 			in-range (found). Valid range is 1 to 300 (seconds),
 			while 0 indicates unset.
 
+			NOTE: Controller offloading does not support High RSSI
+			Timeout. So, to provide a consistent behavior between
+			SW based and controller based monitoring, this property
+			has been disabled and deprecated.
+
 		Uint16 RSSISamplingPeriod [read-only, optional]
 
 			Grouping rules on how to propagate the received
diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 33f4d9619..a1778248f 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -860,6 +860,12 @@ static bool parse_rssi_and_timeout(struct adv_monitor *monitor,
 	monitor->rssi.low_rssi_timeout = l_rssi_timeout;
 	monitor->rssi.sampling_period = sampling_period;
 
+	/* Controller offloading does not support High RSSI Timeout. Disable
+	 * High RSSI Timeout for SW based filtering to provide a consistent
+	 * behavior between SW based and controller based monitoring.
+	 */
+	monitor->rssi.high_rssi_timeout = ADV_MONITOR_UNSET_TIMEOUT;
+
 done:
 	DBG("Adv Monitor at %s initiated with high RSSI threshold %d, high "
 		"RSSI threshold timeout %d, low RSSI threshold %d, low RSSI "
-- 
2.35.1.894.gb6a874cedc-goog

