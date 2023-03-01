Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0184BC64EC7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 01:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCABir (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Feb 2023 20:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCABiq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Feb 2023 20:38:46 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D493B72B4
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 17:38:45 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c4so4090797pfl.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 17:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4YaGfX2wY7SgSpQy9OYBDc4VfC7LIGHh5xnF/v8hf1c=;
        b=SkCxE2n6IwyBS8JJXtuMCtta+0qBUOj1/At+vTPbAX2jTeMGKMU8QxE/Rowq8MTse+
         OgZ+sk8lfGVO0K2okjMx2NX/V8Ns/H0kr/xVXd0y/xR3I+zwyJ0Q+jCxrsHxU+duC4La
         tbwMQV42zAeVQQ8blzqLxDjbuqGsyHniR67j7zt6O/Lbb9O6Zu7NOrd05xxl46QRp/Yp
         bYoqVvoforPRxSB+mIiMM+Ayk3L8Bmup0/sg4OpHTJ9Ppk6w7e74u8+ILujDcAxxu/f7
         paouFmdXkdr1Q8QbLJTOefsayyk991ZdBEVjrYnjGpsnqbU/8gTzRFJCBeZeJABTPZz3
         pptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4YaGfX2wY7SgSpQy9OYBDc4VfC7LIGHh5xnF/v8hf1c=;
        b=XpFAm94vj3cqw/MZFkBBGLQ3W6CQ7FQWfu6nBm4VF55tMQvkkT6nE1tJdb6WdCCyBs
         p7eVxOtPp6QsefYV0Chfhci6+XyhgL5hSHkBZrfv0bwRXfbNOLGOfjIXo2q7tFSDYvgI
         beePPi+0p9ucRoijtnCItcec/AizQWZRhCoxa9ehYk0/3tmlcWJpGlraGt49xMlYx0A5
         IAxWY+8XK+wrYhsyQTycg0u2cw+13hSZkEvAUStpS6aSlKU26pd/7WRxs94u2W5+sgYa
         ErnMRI2Zkp29EKwhPYz0pomuONjJWlGM2sJm8B7y8y4F8bwyawUrtTFo7uaQJn2fG+b9
         z4dg==
X-Gm-Message-State: AO0yUKUp8CyjWc3WyTz1+fr06qy4sc420mEleIhtEEP3rZ3aFOIQNK43
        QTOnjkKVmsAz3TUh3vaBI6/qWw+JBiM=
X-Google-Smtp-Source: AK7set/EwpXj4ZuTHkqfj5t+F/slcmRtoYOzAMzKpIgu9oIoL1zMpA1UMFce3VQcytBuNPFpvhDQNA==
X-Received: by 2002:a05:6a00:18a4:b0:594:26a7:cbd2 with SMTP id x36-20020a056a0018a400b0059426a7cbd2mr6285475pfh.8.1677634724669;
        Tue, 28 Feb 2023 17:38:44 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id c1-20020aa78801000000b005d866d184b5sm6627797pfo.46.2023.02.28.17.38.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 17:38:44 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] device: Don't attempt to connect LE if ATT is already connected
Date:   Tue, 28 Feb 2023 17:38:38 -0800
Message-Id: <20230301013842.718438-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This checks if an att instance already exists before attempting to
connect it once again.
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index d270421cc7c9..cb16d37c1ae1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5422,7 +5422,7 @@ int device_connect_le(struct btd_device *dev)
 	char addr[18];
 
 	/* There is one connection attempt going on */
-	if (dev->att_io)
+	if (dev->att_io || dev->att)
 		return -EALREADY;
 
 	ba2str(&dev->bdaddr, addr);
-- 
2.39.2

