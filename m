Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037C8C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 07:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F6A2184D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 07:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g9SPW7Ia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgHUHEd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgHUHEc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 03:04:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABB9C061385
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 00:04:32 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t11so477543plr.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 00:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1bpqRclnj9iSVxDziurF6sjEMgtIADpu9kvp6djvcNs=;
        b=g9SPW7IajK/DVedYtIzXGVTuSCGYJVS5BkgGSK6UXWTT7MBuZLH+fetsFvfIGk9ik4
         KJKms+NaXPxtf9J7Y/DSMggTp4Zr8mw8lHKFVPAfLxArcF4D9+mxMtAOpN5iY1ft8k+6
         Ao9Lvo7fL958xjftiVTvpvj1G50Ej48ynPnvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1bpqRclnj9iSVxDziurF6sjEMgtIADpu9kvp6djvcNs=;
        b=XZhH0Hsa+l5SQ+BURh3We5BRzci3xdyYwgapzis8C5HLd5zGWGdRht32fyd4YUliMZ
         EVsBQI25HvPSjG5p8f0IiflpE2kNzdDgfPYfHOc+HLfl5nF86PtHyEqWjjVcXawirT85
         CtGAJ5dzdY0IpmK0h3r36HqxM8WuUXYV+hEuYwe5LxYuT05VvGqOAsr2auQfEzqjX7nG
         xBWuUnnKWRNbU2+rseXIWI8DIUl6/589Sw6XG4RWrXnrgnr4l5rpJG7Vb68yiyVfKn0S
         0Ei56FwXJeBP1PgbyXNuw67NTZa69dDgEpVLgOapabXPHGLZkLGK704pHzYxiG+FJ49H
         Rasw==
X-Gm-Message-State: AOAM531UFlqRxFM6rJp7Fzs4AO1WGlBuCWJC2eF+f8IhgCHTOL5jrtEA
        fp63EGlPA5Pe5EtPiQijVJC0QvTPTeKluQ==
X-Google-Smtp-Source: ABdhPJzJxZxlIcUcRsGSCpPd5QkpMjDucmxPD7A73v9wd/cFgQTIBEzof6H2z+F/8Lo38i06qi5Pkw==
X-Received: by 2002:a17:902:30d:: with SMTP id 13mr1297142pld.300.1597993471653;
        Fri, 21 Aug 2020 00:04:31 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id s23sm989753pjr.7.2020.08.21.00.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 00:04:30 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Joseph Hwang <josephsih@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ] gap: Enable the external flag
Date:   Fri, 21 Aug 2020 00:04:09 -0700
Message-Id: <20200821070409.18037-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Joseph Hwang <josephsih@chromium.org>

This patch enables the external flag for gap so that the gap service can
be exported over D-Bus.

Tested on Chrome OS that this fixes https://crbug.com/722987 so that GAP
API can be propagated to Android apps.

Test Method 1:
  - Connect to a peripheral.
  - Use dbus methods to query the org.bluez.GattService1
    interface in managed objects.
  - Confirm that the gap 0x1800 profile was exported like:
    GattService1 path: /org/bluez/hci0/dev_xx/service0001
    service_props: dbus.String(u'UUID'):
        dbus.String(u'00001800-0000-1000-8000-00805f9b34fb'

Test Method 2:
  - Install BleManager APK attached in C#0 of https://crbug.com/722987
    to ARC++ in a chromebook.
  - Launch the application.
  - Connect to a Dash robot. Confirm that there are 3 services
    instead of 2.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>

---
 profiles/gap/gas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index dffa31314..abe5341c0 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -310,6 +310,7 @@ static int gap_disconnect(struct btd_service *service)
 static struct btd_profile gap_profile = {
 	.name		= "gap-profile",
 	.remote_uuid	= GAP_UUID,
+	.external	= true,
 	.device_probe	= gap_probe,
 	.device_remove	= gap_remove,
 	.accept		= gap_accept,
-- 
2.26.2

