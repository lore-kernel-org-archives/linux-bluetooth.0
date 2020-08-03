Return-Path: <SRS0=SB5R=BN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090ECC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 06:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6ECA206E9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 06:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbjD66GW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgHCGwl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgHCGwk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Aug 2020 02:52:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AD9C06174A
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2020 23:52:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u206so9764257ybb.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2020 23:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YTtUuJN3BP1ZpCkvg2WNDwIo42ZiWhldxD72P5cBZAI=;
        b=dbjD66GWcTIozlJ0va5aBohunDnmM5ZuTqmpFr6IKinn6M8lIdg972XnUGkPr27GQw
         nOHtvP6hX2mlHA9Hcf2nYf/RWvA8UFdQExBq6tZ2h+lfs7Qm1SRlaSFmVHqw2FlYAf3S
         Q7x4ZZi8rX9PRVsdOT7xrCoTnGuy3tY5at2vK8/sfzOCw3koNqNkGNwWIRH8pCjKcPYA
         LjVHlV2DVMawX0ONgu/itbK0B4G/OMj0ocrA9TXyDsGigOunaPFuPUPMDGeBIe/Ewp32
         ZfSpfTnruR9HCTr0sFsbyVlp0pb2B7RbF9wuxcV1CcbBdx2aCL2TcRNPbeU/rUZY2x6+
         DBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YTtUuJN3BP1ZpCkvg2WNDwIo42ZiWhldxD72P5cBZAI=;
        b=Mo1guZ0wXJJaQEj0s92cUkR18NPorFp1YT2DMhhtQiRYiV9kg62r12LjUL50Jo5ifO
         wOYIcswm1Nw5SilP8oK9424WPZePkXQyEHX7vik07ACXjJ53/3xdabYTSKuAAk3V3Ys+
         Xg5Dz7Dd5CdMLpu4eGyxnm5VRasnnEMkw//2d1nYKUSLM6JnB3osjdF445qKYSjj7BL9
         AnPbc0sgT6Nmj8v2J7fQpgODpApXzlZ8CAvT0sJ1ji2FkXql5kRhXhSN/f2JBlFW1gc6
         dIcx7BSbEDvgRIo2YcdQSbXzuksN1o/THyS1L2R0QwAz1jbNo4VyhFBAant1+msAY1Jd
         6e4Q==
X-Gm-Message-State: AOAM532qXGc2SscIllY1RJ8qOO3KfGj0VSV7M+alHmjhUoF+JSRmUasq
        lTOC1EbRetl2zMKZaOXUlQuupavlC2ONmR9AisvNafKDdNMBiGNP3qU04f8LSJVjrdXaanOfNMx
        QKIeroVlfhWoksZaU9+XEdBEbEuc81nMUJLncZvrWoYSkqBi1bxT4fyGZJZb1ijWVHSyEeCPMfB
        h/
X-Google-Smtp-Source: ABdhPJxkpJpasGt6QYRGcIH6kxUv8QnEdEtNtPZ4J0ep/xhlcijzUYh5hiWjnepV5mf+ZZfUn6OmmdJWBtD5
X-Received: by 2002:a25:40cb:: with SMTP id n194mr23399710yba.380.1596437559750;
 Sun, 02 Aug 2020 23:52:39 -0700 (PDT)
Date:   Mon,  3 Aug 2020 14:52:24 +0800
In-Reply-To: <20200803145200.Bluez.v2.1.Ibf5508171632eebb66a6cd0ed2fa87bfac078f74@changeid>
Message-Id: <20200803145200.Bluez.v2.3.Icf343eb0ccd09fc96a897594ca12dc1a44903126@changeid>
Mime-Version: 1.0
References: <20200803145200.Bluez.v2.1.Ibf5508171632eebb66a6cd0ed2fa87bfac078f74@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [Bluez PATCH v2 3/3] input/device: Send UHID_DESTROY upon disconnection
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

According to the uhid documentation: "If your device disconnects,
you should send an UHID_DESTROY event"

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v2:
-Split into three patches, now this only handles UHID_DESTROY

 profiles/input/device.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 757290080..8fc04be37 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -117,6 +117,7 @@ bool input_get_classic_bonded_only(void)
 
 static void input_device_enter_reconnect_mode(struct input_device *idev);
 static int connection_disconnect(struct input_device *idev, uint32_t flags);
+static int uhid_disconnect(struct input_device *idev);
 
 static bool input_device_bonded(struct input_device *idev)
 {
@@ -393,6 +394,10 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 	if (!idev->ctrl_io && idev->virtual_cable_unplug)
 		virtual_cable_unplug(idev);
 
+	/* If connection abruptly ended, uhid might be not yet disconnected */
+	if (idev->uhid_created)
+		uhid_disconnect(idev);
+
 	return FALSE;
 }
 
@@ -969,6 +974,28 @@ static int uhid_connadd(struct input_device *idev, struct hidp_connadd_req *req)
 	return err;
 }
 
+static int uhid_disconnect(struct input_device *idev)
+{
+	int err;
+	struct uhid_event ev;
+
+	if (!idev->uhid_created)
+		return 0;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_DESTROY;
+
+	err = bt_uhid_send(idev->uhid, &ev);
+	if (err < 0) {
+		error("bt_uhid_send: %s", strerror(-err));
+		return err;
+	}
+
+	idev->uhid_created = false;
+
+	return err;
+}
+
 static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 								gpointer data)
 {
@@ -1127,7 +1154,7 @@ static int connection_disconnect(struct input_device *idev, uint32_t flags)
 		idev->virtual_cable_unplug = true;
 
 	if (idev->uhid)
-		return 0;
+		return uhid_disconnect(idev);
 	else
 		return ioctl_disconnect(idev, flags);
 }
-- 
2.28.0.163.g6104cc2f0b6-goog

