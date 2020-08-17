Return-Path: <SRS0=KHjC=B3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF6CC433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 20:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980A92065D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 20:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TNurjeIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHQU43 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHQU42 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 16:56:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22469C061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 13:56:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v11so19666400ybm.22
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xAuvgih+72j9IUIm7iDAaTRlM7+svjQwxUff+8aUj68=;
        b=TNurjeIAgdwM1HlUV/65hI/+Ydcs0nHzExOPJdZ9NkaFFkq6jQaJgeoMQMNf3jXjod
         p1ihIIXKAre3BNmA4+hoRwzkmri2+zsiM/2px4AYw2YTKQxpa2TQJtHntfkIOzJCBto0
         gaiZNNeD24fCr2z5DYVCaUMRdwwJKBeGmFc6S/SvAdINxQq5s4xSPDgh7G3AhAISAIl3
         z1F6hbrv/UBmM+L02X5q/z7tojQ/5x+srPNe81kjblXMiXFHSV+UguzGLPOPT5F1cbUL
         O47ract8E0WckuOZ2uSuIHjtt8cPb3AV7nQcB36vglDw/29yNP/zsut3zaS8ZsNnykiK
         UuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xAuvgih+72j9IUIm7iDAaTRlM7+svjQwxUff+8aUj68=;
        b=Z9OyrGrSgeHfIeRnof7cgf4r+jZ5f3mmibnYrXRQbeUxjHC6Zp6oVfGYrPMCdwvsIp
         wBfUUfMNjOaf3hXQ5d2fcn61uCrDC3gSYsv8UqoN823VsqTrd4Px2QcXpoO8dkUapXQB
         QWMf24P8Pg8ZeWcbQ/CNtbpmKt7YGWd0PaxohCgopESe2zYjlfDam8ECqZaAqT6I0nd0
         G0Hxkc3WlXhNgcB9w16HYrCRi9RiNtZsztCXB7GuJyUgbvz6y94LoHo8vfHD/2pzygVE
         Br1ieg3iF0RKB78J/M5dk4KLyQzdERpSPOLkGbqWqc75QVKVxZA4zuq9TMmLZl4dApgo
         OyIQ==
X-Gm-Message-State: AOAM532YOiewqtorFw9qwUcllRj77R0HOod0wGdajhk6NZpmrEAdnTm/
        C/9aTI3/3YoKHmoYJz0M+GWgCxFfcMR4OlarXS0gE65/3IhY3Kn5UnNQtYOq2/krIeZE9FtB9KK
        smhgLzEjRb6TqYhcg5LDGFWsZGId9kYUPizdP/WhuLn5PkIst2AhhUSz2r0kVH5rDzz+5OFtI5g
        dk
X-Google-Smtp-Source: ABdhPJwqfJPUvnaS/gxS/kqq4BI4zelaOUHhis7TLfeiuYkElIaUgVfKPyzghzSE6h4dxZwnZ7YXyMsH/2z2
X-Received: by 2002:a25:40d8:: with SMTP id n207mr24159973yba.69.1597697787315;
 Mon, 17 Aug 2020 13:56:27 -0700 (PDT)
Date:   Mon, 17 Aug 2020 13:56:23 -0700
Message-Id: <20200817135606.Bluez.v2.1.I21d21871d85db48b07ba847742c7cb933024307c@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [Bluez PATCH v2] adapter- Device needs to be in the temporary state
 after pairing failure
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

Signed-off-by: Yu Liu <yudiliu@google.com>
---

Changes in v2:
- Fix title length and format issue

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

