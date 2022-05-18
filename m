Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153C6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 May 2022 04:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiEREdV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 May 2022 00:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiEREdT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 May 2022 00:33:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6ECDFF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 May 2022 21:33:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so889214ybp.19
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 May 2022 21:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CePwNNmF3fIm01KymEYDMgdP6P1K9tvoxAvRjX3HK9E=;
        b=gSVwexQQ92FjHpWBWZSFVsoBfj7Hgt/AU0Gl67bwX+TtYKOAyR18v2Z/16rA/SCeI1
         8Lid9euQu+g/Yuf4gLvmz/G7ONtLwS+DYQXjrmLAW8Wgo3iOYbvYB6qJodijszuCyPMF
         3XrEFNoK8k9Uf336BG/g6hVAaFz0RNGu2w79l111+96geV83IziwwN7BhUTDK5mM2lRC
         8Cms4j81xkTAUYKXa2TYMb1QFps1vt0LWFKwgcOjCp0uyvfIwXbRG/hMiBETIhR9imRf
         qzEM1EYBkThSapQoJeu726bz5rLr7g4T4yxO1196j358ZIrB3G4KICDOM6hjWLgABF9r
         SJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CePwNNmF3fIm01KymEYDMgdP6P1K9tvoxAvRjX3HK9E=;
        b=wiQyqT4mC1dpR0tBl2l7Mvbdxz86xwQTYXV1pkBE2ADFaZrYDP0528mGHw6mMLJ3nj
         3x+Zq36v2jC4O7uj1PkuG1ptdlmhZVGEe4UGoILkEoXkMWvg98N4WFkilk8sT5rciPr2
         e/AhGTszORUF3EA52zpmQY64AR17Myu4tO7WETD3c0P7z6RI4VwS+EuzQi6ujokaGJJy
         g338jw0C0Fl9KK6084Ko0V1Mi6mmUD8t1yzChoB8qeRh2rr2Or/ZzeCaA5kk+TqDVJ+1
         ZP+hibUonMohN0Vx2s2KJwOUIo1WlStlN2yL2DHHG1Wk1M10hEgsJi6ObdeZo3tw4v2R
         HFjA==
X-Gm-Message-State: AOAM531FzRdo2qwUd+gR02u+H/ZleGAFWgT3a+WfcSqgmO8bgxEIqOF6
        d+/OtTzcZZZibXNRlju72tphLxAqCK7YYceFXQiE77jQbWFhmgABukv4r31dInSq86kD7mmBFvQ
        obMByM0PnPPj1hjaS+w3MDjO0IRd8Pjd26gObOx1d4iEG3zRf1upFnuJkw7sWO4T53W4/Y7ssM5
        0k
X-Google-Smtp-Source: ABdhPJy75DtH7+JJFE0gglPSfz/u1RPei5TsxJDjFR3kpNRWBWe3Ks5DYzhtT1/1duPJ0FZBsZXdVjW/9n8v
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:c48:4501:146d:1031])
 (user=apusaka job=sendgmr) by 2002:a25:874d:0:b0:64d:c470:c8aa with SMTP id
 e13-20020a25874d000000b0064dc470c8aamr10931885ybn.578.1652848396465; Tue, 17
 May 2022 21:33:16 -0700 (PDT)
Date:   Wed, 18 May 2022 12:33:07 +0800
Message-Id: <20220518123252.Bluez.1.Ie61d0e985d42728b2e705ca6dfd000385cf3870a@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [Bluez PATCH] input/device: Notify failure if ctrl disconnect when
 waiting intr
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

On some rare occasions, the peer HID device might disconnect the ctrl
channel when we are trying to connect the intr channel. If this
happens, interrupt_connect_cb() will not be called by btio, and we
will be stuck in "connecting" state. Any future connection attempt to
the peer device will fail because of "busy".

This patch prevents that by checking if we need to report connection
failure when the ctrl channel is disconnected.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 profiles/input/device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index ff4aa771ac..e2ac6ea603 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -581,6 +581,13 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 	if (idev->intr_io && !(cond & G_IO_NVAL))
 		g_io_channel_shutdown(idev->intr_io, TRUE, NULL);
 
+	/* It's possible this is triggered while the intr channel is not even
+	 * connected yet, therefore we are still in the connecting state.
+	 */
+	if (btd_service_get_state(idev->service) ==
+						BTD_SERVICE_STATE_CONNECTING)
+		btd_service_connecting_complete(idev->service, -EIO);
+
 	if (!idev->intr_io && idev->virtual_cable_unplug)
 		virtual_cable_unplug(idev);
 
-- 
2.36.0.550.gb090851708-goog

