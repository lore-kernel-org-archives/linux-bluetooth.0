Return-Path: <SRS0=KHjC=B3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4CBC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 20:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F8320674
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 20:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NtAgfKUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHQUmC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgHQUmB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 16:42:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A7FC061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 13:42:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l13so19821035ybf.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 13:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UNmPgd9kNtZoo9wgw4gsRYDyNuPIjwok9mt363/DTg4=;
        b=NtAgfKUIXsJ8BR+6PY8e+bttLBBpQL476nDd1QiQpMCDbP+YtSZ3+eLUOnYhSeqOrK
         KfFa/AI9tex97TLNnfJgbtKZK2ytqPHA0C+a6s6TYz6p5Sv/JqHKeWRDmqD2tK63aEv0
         AKC8SEQwsQv80pfaiRAynQhSNO3WY+d8Jq6WSdU0On5W06mCM6g3EjiUr7nhGIGHsuY8
         lCC1TA5ZdUVoWlBHS/mAN1Qd2gYl/Y/f8av7jSOAs9rYUNJNaLgOQKJMPqABwz7jzVs0
         HUg+SttY8VcC6Ks9zGJPDxKeOWldaPI3VqltP4OzGfseeOhEZ++nNn7f2zdNpOhypJe2
         0emA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UNmPgd9kNtZoo9wgw4gsRYDyNuPIjwok9mt363/DTg4=;
        b=BEkiJkCKv6/MeOA1wTgPSjztZfE1rWFQ41blpykOeuW/xhhc8aq6CLIZ29jKGS4Xpz
         +FuXDYY5/OGpw/QGaLOE+MxmK7io+6sMlgBNpFkBB6K0GQ+Qjq7Swwm7F7/LB9KdysHg
         deBwEaRQp8DZjSrQcP2XcvphCHMkJggcxrg+z6Kz1ANPLmUCDfEb2ZE5yM9dqz4y/D94
         LIpPc31ADG6dAqJp5oApk0LHNVDzM+MiJFs+ASAkJRGQYcJGvlR/GJy9dQh3JIReNGAZ
         UPTyvz2PAOws1GCmDrBSIQI1oeJDonvq4S3I8rWBSzPmqmMX/XpmuMSUqf63OHZ8fRhK
         vQxQ==
X-Gm-Message-State: AOAM532t1YdHytEQvpC69jM+HErB5R2KouZdhQHPbd7Ak7jhsXTyb51m
        +WbtAE1l2HTamaeGmHLic1gf8CJ6JUWEBEBVEPgYWj9tUQRbjjWDE3mL0DE23A3yPHMpgc9A/m1
        tx/uobiTp34fT6XyNME3GMsQSLcBpD+0lj2jr7ulwoXKRQO6Y4ntGgW5xVD5eHLEso6OM2SnqTZ
        r7
X-Google-Smtp-Source: ABdhPJyc81SBqB4rCPKkD2kKicASI6t/lTWvv4PMPtBCBk+6CPPgYlhRwxK5rv7kmmg25jeoccEtHzgNyraH
X-Received: by 2002:a25:53c6:: with SMTP id h189mr23476248ybb.469.1597696920076;
 Mon, 17 Aug 2020 13:42:00 -0700 (PDT)
Date:   Mon, 17 Aug 2020 13:41:53 -0700
Message-Id: <20200817134133.Bluez.v1.1.I21d21871d85db48b07ba847742c7cb933024307c@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [Bluez PATCH v1] adapter- Device needs to be in the temporary state
 after pairing failure.
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Yu Liu <yudiliu@google.com>, sonnysasaka@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This caused the device hanging around as a discovered device forever
even if it is turned off or not in present.

Reviewed-by: sonnysasaka@chromium.org

---

Changes in v1:
- Initial change

 src/device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/device.c b/src/device.c
index bb8e07e8f..93e71850c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6008,6 +6008,12 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 
 	if (status) {
 		device_cancel_authentication(device, TRUE);
+
+		// Put the device back to the temporary state so that it will be
+		// treated as a newly discovered device.
+		if (!device_is_paired(device, bdaddr_type))
+			btd_device_set_temporary(device, true);
+
 		device_bonding_failed(device, status);
 		return;
 	}
-- 
2.28.0.220.ged08abb693-goog

