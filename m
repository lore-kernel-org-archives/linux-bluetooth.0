Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62B1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 14:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF282078D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 14:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CxvbVKAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgFIO6x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgFIO6w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jun 2020 10:58:52 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B83C05BD1E
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2020 07:58:51 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id f18so16872041qvr.22
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2020 07:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SWiX09EdT83HRz9HBipKqbgG5xccBNw4xWLbuoJNm4Q=;
        b=CxvbVKASZVT0YCtNX9bcarE2nd1wNVEcdVGSZE/dZ+/Q7eXfpMT7y5aLS1N1gVV4hX
         kYQrMt5+KmxjIOG4i/mkBJk4OV1gWqo+757muZk6KHcMM8tBU1G0oabJYDYskY/pMMSD
         Yiy1RSQno+yAaZwnW7OT7/qvpNgoZSN7yMb+nXnasaU8IVf6ztzTC+Dm51rPEQg8JA53
         EPviPdyAzpXivaKHvcwTYTYXLT7GrjVNgfTiglTcYx4VaXGgRAcBbPfm85b12i/rLUJK
         dlh8X1k/457fNRoJBsllbwy+o1c7DiQqvMktE4wvo7BOrPM/kOFDEm9P2Ugex6dW2cth
         Tx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SWiX09EdT83HRz9HBipKqbgG5xccBNw4xWLbuoJNm4Q=;
        b=BAqITYYTbeXSZIcBRZ993gV3lqncS5QrwO+xrblzeGI3kFLiiR+OAdYzJp984RO/3J
         lFgtE0BXOO0Mt9ZYULCfG72hTVHMtb8Vf1h7flvYS6kVBgz20Mw15e4tzyZLS7Yc/rmv
         O4KcH0niwMdbH0jfvatIyLaYSNn7rfrsmhXrEtFW2D2CzG4mrl9PgbcVuYt2AECWaE3v
         flZ2FpUyVEtZuB6X2x03E8IAjnUcII2xIPqzNLQnYIzc4wJrC1BibLkQneNCruyqYaph
         pUcakXgUes01dSEPcg5EOAiHDv0Jso4ZnTVb9rJeZQI7H1KMiymtod3f+Lv66t54dFJV
         cOeA==
X-Gm-Message-State: AOAM5307MGoNIqK+hgjGHriWGzs1FajVyMHQMpdf3Yve2PJiumB4kKmE
        hcMZ5ZbV/h2mnBeyeUy71YmNt2R5aPeallAGyJYSSgOiMI3H40EtAIEghPQGPs0sG6Q8X2b9ifF
        rNS/CVlEAQUk/QCXciDO5ztKSzqTZUSA7Og9IKzqQsptFD9WHeRzr4kDV2SVvBOMmuspcU1EpV5
        k+
X-Google-Smtp-Source: ABdhPJzGwkv5TjAJr8e4to1QfMPvutJM23mNILVSOKJZPxk6ErHrCNOPyT8+BdooVlPFu38jgL2dO9bNPj3y
X-Received: by 2002:a0c:ba0c:: with SMTP id w12mr4562485qvf.4.1591714730243;
 Tue, 09 Jun 2020 07:58:50 -0700 (PDT)
Date:   Tue,  9 Jun 2020 22:58:25 +0800
Message-Id: <20200609225813.Bluez.v2.1.I1952bb847ed07631095daf37fe281a49ccf864d0@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [Bluez PATCH v2] input: disconnect intr channel before ctrl channel
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

According to bluetooth HID Profile spec Ver 1.0, section 7.2.2, A
host or device shall always complete the disconnection of the
interrupt channel before disconnecting the control channel.
However, the current implementation disconnects them both
simultaneously.

This patch postpone the disconnection of control channel to the
callback of interrupt watch, which shall be called upon receiving
interrupt channel disconnection response.
---

Changes in v2:
-change socket shut mode to SHUT_WR

 profiles/input/device.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index d89da2d7c..e2ea459fe 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1026,14 +1026,19 @@ static bool is_connected(struct input_device *idev)
 
 static int connection_disconnect(struct input_device *idev, uint32_t flags)
 {
+	int sock;
+
 	if (!is_connected(idev))
 		return -ENOTCONN;
 
-	/* Standard HID disconnect */
-	if (idev->intr_io)
-		g_io_channel_shutdown(idev->intr_io, TRUE, NULL);
-	if (idev->ctrl_io)
-		g_io_channel_shutdown(idev->ctrl_io, TRUE, NULL);
+	/* Standard HID disconnect
+	 * Intr channel must be disconnected before ctrl channel, so only
+	 * disconnect intr here, ctrl is disconnected in intr_watch_cb.
+	 */
+	if (idev->intr_io) {
+		sock = g_io_channel_unix_get_fd(idev->intr_io);
+		shutdown(sock, SHUT_WR);
+	}
 
 	if (idev->uhid)
 		return 0;
-- 
2.27.0.278.ge193c7cf3a9-goog

