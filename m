Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08281C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 20:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C365B20674
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 20:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d1Tad3Vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgGMUO4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMUO4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 16:14:56 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB9DC061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 13:14:55 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cm21so424967pjb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 13:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0IW9qTSFXBwOuk1yrc6ynqLxslXbEquo65j1s7zEORQ=;
        b=d1Tad3VsvL+6WdpMhxDQv0AMjB5f/1N64Smmm0HX9k4VhGFykZAsnC9u0wZ5V1k8mB
         VvWV9xL/SS6EaSmu7jjP2+6Rcedd/xU2DazKTGlTe7+DOnuGkt6gvACINTgkC/IL6cXk
         E1vR9X3TohSqwYi1HfTkjg8PJIHYvDECsvHU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0IW9qTSFXBwOuk1yrc6ynqLxslXbEquo65j1s7zEORQ=;
        b=VPZB2HDndKHAlJvlqAwsz4x4nVlsuRdiAlmR8XCWKk6/F5eOd8oQ0oiiWmxVic//v9
         eivnnik5WUQ0MH7ILEXdzHgB0g7+38cnSyOXQEBwbhzfdWp5HOvifasJAmz5+63r6qmk
         t49jubzYpx88DD47e+ZSXEmHheaaPdMSsapYmTjo4eBbcdjtv30vQKoTPS3Ox4n8lm1j
         gvmePLZo6SGIKWBcgIWwo/hOGE8DRyyEHCyONxy3aaBLM9IXdmA5ycd2pEeA4HIRQiSy
         A+/n5o/EVkWFZOrrx5/osv47ZpijnQZB6UbZ9w+0XnE3O113m/dY7ZYszZE/vmlzNi1t
         OLhA==
X-Gm-Message-State: AOAM530bqAdlxZAt0VT3WJecBm9jEzsEJ8yXpLPcUisYqoYkkXqsTBAj
        rJDQqnyKiw8oDCvpGf8O25zV3w==
X-Google-Smtp-Source: ABdhPJxouI32B0DgPRih9vRINyL7FATmu49ZTjYgBEWEpG3PSqaUeNQhkXf4AsyNLA1BbBYTLfHzDg==
X-Received: by 2002:a17:90a:db48:: with SMTP id u8mr975363pjx.169.1594671295378;
        Mon, 13 Jul 2020 13:14:55 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id h18sm7866135pfr.186.2020.07.13.13.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 13:14:54 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth-@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ 0/3] Per-device option to enable/disable internal profiles
Date:   Mon, 13 Jul 2020 13:14:38 -0700
Message-Id: <20200713201441.235959-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch series adds a mechanism for clients to choose whether to
enable BlueZ internal profiles (e.g. A2DP, Battery) for specific
devices.

The motivation behind this feature is that some applications (e.g. Web
Bluetooth or Android apps) need to have control over all remove GATT
services, like Battery service. With "battery" plugin being enabled on
BlueZ, it becomes not possible for those apps to work properly because
BlueZ "hides" the Battery-related attributes from its GATT Client API.
Disabling the "battery" plugin won't solve the problem either, since we
do also need to enable the plugin so that we can use org.bluez.Battery1
API.

The solution that we propose is that clients can choose whether to
enable internal profiles for each device. Clients know when to enable
internal profiles (such as when a user chooses to pair/connect via a UI)
and when to disable internal profiles (such as when the connection is
initiated by a generic application).

Sonny Sasaka (3):
  doc: Add "AllowInternalProfiles" property to org.bluez.Device1
  device: Add "AllowInternalProfiles" property to org.bluez.Device1
  client: Add set-allow-internal-profiles command

 client/main.c      | 38 ++++++++++++++++++
 doc/device-api.txt | 13 +++++++
 src/device.c       | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 src/hcid.h         |  2 +
 src/main.c         | 10 +++++
 src/main.conf      |  4 ++
 6 files changed, 163 insertions(+)

-- 
2.26.2

