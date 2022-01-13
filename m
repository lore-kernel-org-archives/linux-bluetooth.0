Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8BBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jan 2022 06:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiAMGQX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jan 2022 01:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiAMGQX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jan 2022 01:16:23 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F8AC06173F
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 22:16:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 127-20020a250f85000000b00611ab6484abso6094346ybp.23
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 22:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cio0Gl6aOSFmC0Wh8AQeXvew0M/yZ/Ny+p/OoQRknw8=;
        b=pqShH13QEBezvMK9V+Gns4MYUg5MLC90tCJlGn2z8WgpqcEVuF/gZR/unBtj2Sc23x
         vb9+6maFDQ8HRYvTtLYuoQm/F9S10U7LqzqezzWR92pvMazFi176gb4N3/4o/1n7KLDE
         yIN6C9udttWAy2TzeMLCb9e3U8FJJtqlAF2DJNEuMjFwdiZvTmaJ0lGbJEjdgVYO4Kp1
         nxRI29ik0eqW4v+Y1jLI/xJxqaCOSXEdziWqwf98JRkLwc8Zd0rpFOCtp5+/rAz6yWSR
         C4+mmf5m+UO22X/awEF0TJPWbnCazhfufbcTG4zwGp928Be3GBtKmTTexFz4g2ARxhqS
         0Wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cio0Gl6aOSFmC0Wh8AQeXvew0M/yZ/Ny+p/OoQRknw8=;
        b=QV1bBQOkT5dspCpNHwi72DYFI1rjTiz1DQKm095q1kZCQCbUn0m7gVqUK6WYJAqbnZ
         tvObr7G4AF7lABeDZZT2DH4BFVqcxwzcWCt7JZLsgTOxjrtxRNaEt3010upXNjiF/D33
         VUW4ls3FqqDLKFrMRuWyBStmqnS2nEp97uy6RTHR3NOMj1oKZhfkYk7Ojrlt+HJy869g
         /oyZijLCRSDqS0XC95Uf4JncCzTnk0DzYS0X6S1JGU4wge3c6erSygq6xpOXzV8pPyeO
         LM0NoqQAzSBAL0yJsk29QTPLhlYunHYPrfew4hWOHkfTrU7aDOWZcVwzTnJ518EY7fCJ
         AqyQ==
X-Gm-Message-State: AOAM533L+6TCT1Bz+0TZKqXSp1n7qv6tPkT4oygOt7YKvNc+LKAi9vRb
        7GINb8il1DJRO2Pdl9MWwheUWBmKdRzdgYS+hVSlg6gWZAyesrf4bCDxHrl2hPYAdgW6SYfGuoT
        2CNv4sfUapUBwt8Zh+h23752vQclIfwPAsHP/IIdUrXO8Lap4cBFIYDrAff+wvQ4WkrZSJCNUVA
        mV
X-Google-Smtp-Source: ABdhPJzQTMCEkhJfC5ISw1BrQ0DM3960T8UHyB2znNmTNijs6Sg24B9veybA4B9cIjhrOwb9WI0PYMPQVoXB
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:8245:76ed:a5b3:7f11])
 (user=apusaka job=sendgmr) by 2002:a25:a061:: with SMTP id
 x88mr3869640ybh.633.1642054581922; Wed, 12 Jan 2022 22:16:21 -0800 (PST)
Date:   Thu, 13 Jan 2022 14:16:03 +0800
Message-Id: <20220113141533.Bluez.1.Iad485a29772515142eefb1b120d5eb5e101d82f6@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [Bluez PATCH] device: Fix device can't be scanned for 5 mins after reboot
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Shuo-Peng Liao <deanliao@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

After the patches which limit the attempts of doing remote name
resolving, there's an issue which prevents BlueZ to RNR new devices
for 5 minutes after reboot. It's caused by failed_time is init to 0,
and is then treated as the timestamp when the device failed RNR.
However, actually there is no failure yet.

This CL fixes it by always allowing RNR when failed_time = 0.

Reviewed-by: Shuo-Peng Liao <deanliao@chromium.org>
---

 src/device.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index f2447c478e..16b1ed5bd3 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4487,10 +4487,15 @@ bool device_is_name_resolve_allowed(struct btd_device *device)
 
 	clock_gettime(CLOCK_MONOTONIC, &now);
 
-	/* If now < failed_time, it means the clock has somehow turned back,
-	 * possibly because of system restart. Allow name request in this case.
+	/* Allow name request for any of these cases:
+	 * (1) failed_time is empty (0). Meaning no prior failure.
+	 * (2) now < failed_time. Meaning the clock has somehow turned back,
+	 *     possibly because of system restart. Allow just to be safe.
+	 * (3) now >= failed_time + name_request_retry_delay. Meaning the
+	 *     period of not sending name request is over.
 	 */
-	return now.tv_sec < device->name_resolve_failed_time ||
+	return device->name_resolve_failed_time == 0 ||
+		now.tv_sec < device->name_resolve_failed_time ||
 		now.tv_sec >= device->name_resolve_failed_time +
 					btd_opts.name_request_retry_delay;
 }
-- 
2.34.1.575.g55b058a8bb-goog

