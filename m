Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72178C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jan 2022 07:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiAMHrM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jan 2022 02:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiAMHrM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jan 2022 02:47:12 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C112C06173F
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 23:47:11 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id s19-20020a170902b19300b00149a463ad43so5308581plr.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 23:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lqg7D1vpwzpCQfKueX7qq7B6zdY7SHtCugzwSsPGXCM=;
        b=G0SohyWslUnm1mbCcGj4Ecpzca3PjKN/hf6QRip0KpRLPMgVNBiT12qbotvli2vfoC
         149k5KodkeEUk/aAnFQsWda2gK4DznDwP+xu7/OfcT//F0L6SzxmAGohflgK3IVWiK37
         zG246b9Fy0suNO02LmlIrSxq1XC9e2YsWwRGcLktTLexO6rjKCQY6qQLTatqHnObJV0y
         8gFTUcVp3T2maLE0kCySQckZTTPme0uLqfkJNU30A+YsdfzAhYMjp9DkDhx1CWEEfh9r
         oIg9H0k5wzjmvg9JdfGIz3B2pAm+LABBPi4EPNIUcZzLtiTcDqrejoWY9UFOdTQTPiTl
         LxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lqg7D1vpwzpCQfKueX7qq7B6zdY7SHtCugzwSsPGXCM=;
        b=wVs3xODD5EMN3eYqZbl9uHndiEhr+PX7h2fZLHfI9ZS3BwJwdfzaaDLl3Kj//S9uwd
         nSmxlM81WOc9Xldvg90O3L9o7VIy19EMDhBX4tW82IMSP3hqJpu/tplsGx5NQTkc5Ssb
         VucQTGfVtZ+e6RwUVxlSfEqZ4BJ1P5ctHn+3mrH6jRj+dE7gSOMv/wprtpnhrAca0HMG
         FHoKgaAYaxb4jYwVVFcpjZG01KcNA0DI3Fa8cQWWuOotBCh0fq/djv9Ix/9/PMIYs3DN
         X0Ks5csPNhmr5zh3cH8s/hSFH7BoprZWg74BpNeR7wwUtLz3fb7ni8cpNlBf4B60ITjc
         SeYQ==
X-Gm-Message-State: AOAM531IOFQ4eqNVj34bG6fLHXJoLdx0uxm3SZrh8CEbmlaYFX11cFAC
        xsGq4ezQPFxo7SgWZyjMFaArmGwmcqFkjGIGFfXUKGCVCHGXvMihoO/bHmOTa4dLvD0OBvlMBgr
        CSyoHlqUo7sXfU7TikeY0oYu4owJsdYBRhn59yGRJGZ0/jHTDuLOezhDTsVSgWu0Vhk6C9y+0tD
        Mz
X-Google-Smtp-Source: ABdhPJzimP7gvpnoT8s6COt0Lkv8V2Zst7R+Tt/gVNyroApore/dhXqDUbgOov4dLITMeNN/w3fAmtskUhM0
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:8245:76ed:a5b3:7f11])
 (user=apusaka job=sendgmr) by 2002:a63:7a54:: with SMTP id
 j20mr2819718pgn.294.1642060030869; Wed, 12 Jan 2022 23:47:10 -0800 (PST)
Date:   Thu, 13 Jan 2022 15:46:52 +0800
Message-Id: <20220113154626.Bluez.v2.1.Iad485a29772515142eefb1b120d5eb5e101d82f6@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [Bluez PATCH v2] device: Fix device can't be scanned for 5 mins after reboot
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

After the patches which limit the attempts of doing remote name
resolving, there's an issue which prevents BlueZ to RNR new devices
for 5 minutes after reboot. It's caused by failed_time is init to 0,
and is then treated as the timestamp when the device failed RNR.
However, actually there is no failure yet.

This patch fixes it by always allowing RNR when failed_time = 0.
---

Changes in v2:
* Separate the one big if into multiple smaller ifs for clarity

 src/device.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/src/device.c b/src/device.c
index f2447c478e..6d29eb8966 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4487,12 +4487,24 @@ bool device_is_name_resolve_allowed(struct btd_device *device)
 
 	clock_gettime(CLOCK_MONOTONIC, &now);
 
-	/* If now < failed_time, it means the clock has somehow turned back,
-	 * possibly because of system restart. Allow name request in this case.
+	/* failed_time is empty (0), meaning no prior failure. */
+	if (device->name_resolve_failed_time == 0)
+		return true;
+
+	/* now < failed_time, meaning the clock has somehow turned back,
+	 * possibly because of system restart. Allow just to be safe.
+	 */
+	if (now.tv_sec < device->name_resolve_failed_time)
+		return true;
+
+	/* now >= failed_time + name_request_retry_delay, meaning the
+	 * period of not sending name request is over.
 	 */
-	return now.tv_sec < device->name_resolve_failed_time ||
-		now.tv_sec >= device->name_resolve_failed_time +
-					btd_opts.name_request_retry_delay;
+	if (now.tv_sec >= device->name_resolve_failed_time +
+					btd_opts.name_request_retry_delay)
+		return true;
+
+	return false;
 }
 
 void device_name_resolve_fail(struct btd_device *device)
-- 
2.34.1.575.g55b058a8bb-goog

