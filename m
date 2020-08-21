Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4E2C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 06:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 843E52075E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 06:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mAcVoR3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgHUGtj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHUGth (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 02:49:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35418C061385
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 23:49:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g15so457338plj.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 23:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1Z7OatO1HXKzF7erLD+BREMH+p3vSOkNDjwzWS3Zi4=;
        b=mAcVoR3dXKs5BKQ3DIP/4wlIaJxEk6P4hXh2lrTNBUC0pONq4DRt+Mkv1SW3zCQidi
         Wmjl2gbpW0LmQfKRHNBfc2fqKuqJ5IVHiqHwo4ZiHoUaysim6yYIbOUXH+BvMuPllejC
         eCcSbax8MZfDjEsg+2MnwTeY4GhT7jaBIhEio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1Z7OatO1HXKzF7erLD+BREMH+p3vSOkNDjwzWS3Zi4=;
        b=mcW55GWnse1eNHO6TzvZc19wpfFo+KkLpH3YHUbYzDcK4CiG7eOj+w5N/ZnciyXu3j
         FAiXbUX8wstPs6GYfmUqwNkLx5ov0HCrRAsg2RugjZOnIMfB3kuu3HsceGd1b9UTrxk1
         eDRe3d4rDCUW8x19xPgjL9SHJPSD4NY5INX5l9oTQq+ogtLZ5A/dRntLLNVTaP1BRX0d
         e5QGR7/8bgo2H/nlr5vsHny+4XijTjeHSxWQn4/616iOb/RXCq2T8WO+18BqQF3TGo6b
         Qglxy7+mVbaIazSAUAaXBWUMUdYhed92LiEt55PtnpGmhEds+bvl8R8xJ88eTcCLRNWC
         JaMw==
X-Gm-Message-State: AOAM531b0Fob4hrjYeAdJSeMSIDP2g0xW3/8AkF9R6JmBeSQiXvGkm8z
        gwIfVENOfOFXxVh4pz25j59S8tBl/yMUOg==
X-Google-Smtp-Source: ABdhPJyvw6BBTYHc/87WO4SbQ03BXFR5HBNF1YPc2Uj5u+TfY2uKKXV0l3vwVUsos9sN/NyPa8RwpA==
X-Received: by 2002:a17:90a:6903:: with SMTP id r3mr1346304pjj.65.1597992576481;
        Thu, 20 Aug 2020 23:49:36 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id a24sm1238435pfg.113.2020.08.20.23.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 23:49:36 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Joseph Hwang <josephsih@chromium.org>
Subject: [PATCH BlueZ] adapter: remove eir_data.flags in device_update_last_seen()
Date:   Thu, 20 Aug 2020 23:49:27 -0700
Message-Id: <20200821064927.17578-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Joseph Hwang <josephsih@chromium.org>

Bluez has difficulty in pairing with Apple Airpods. This issue is
caused by the incorrect selection of BD address type due to two factors:

(1) The LE advertising reports emitted by Airpods do not carry eir
    data flags.
(2) If the eir data flags is missing, the found device would not be
    considered as coming with bredr address for some historical
    obsolete reason.

This patch fixes (2) above.

Tested on Chrome OS by pairing with Airpods.
Without this patch, the pairing success rate is about 20%.
With this patch, the pairing success rate becomes almost 100%.

---
 src/adapter.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5e896a9f0..36bbed2dd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6628,14 +6628,8 @@ static void update_found_devices(struct btd_adapter *adapter,
 
 	device_update_last_seen(dev, bdaddr_type);
 
-	/*
-	 * FIXME: We need to check for non-zero flags first because
-	 * older kernels send separate adv_ind and scan_rsp. Newer
-	 * kernels send them merged, so once we know which mgmt version
-	 * supports this we can make the non-zero check conditional.
-	 */
-	if (bdaddr_type != BDADDR_BREDR && eir_data.flags &&
-					!(eir_data.flags & EIR_BREDR_UNSUP)) {
+	if (bdaddr_type != BDADDR_BREDR &&
+			!(eir_data.flags & EIR_BREDR_UNSUP)) {
 		device_set_bredr_support(dev);
 		/* Update last seen for BR/EDR in case its flag is set */
 		device_update_last_seen(dev, BDADDR_BREDR);
-- 
2.26.2

