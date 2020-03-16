Return-Path: <SRS0=gY20=5B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5FFC0044D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Mar 2020 04:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE5F20663
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Mar 2020 04:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBcbjio0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgCPEkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Mar 2020 00:40:25 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:46171 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbgCPEkZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Mar 2020 00:40:25 -0400
Received: by mail-vk1-f202.google.com with SMTP id f10so1399476vkl.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2020 21:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=v7tr4/51ZhVaf3hAH5Qkss1fDCY9uT+81FCkJvhXir8=;
        b=QBcbjio0BE56VpkcLvwCC8EBrdzZYFQFSOyFTVSUdLKtCdnmYbpnauIPASMgMBf+6i
         IUQ+MFr5ih49HOB3pTVdb2RORplZukIw0Qp7srwQ43IZMi96hlan5lnnT0/+tuX/xBC7
         mJrjjOa4QzXaKSspIRiCR/oyq0n0A/NFezHPOhVzvnQL0WTVrBydHQWuJTVysew81PU4
         IDJMYCv1DbkwrUjFAyhz1y9vNQjdpjNXp8pENGd2abmCsXSHYjRoFf2ilRtHHaKcQBsh
         8Zrh0vzF31k8UFDwiwJPuoSizZYN+ZtIocBCYG2diagNxo98JUuc9FPwbmY8ww8+p51c
         yA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=v7tr4/51ZhVaf3hAH5Qkss1fDCY9uT+81FCkJvhXir8=;
        b=noQPKSEh/ntTeOI//vabBwn0AWPDhLG6aNf2NVvbAniXsWIf6CUdxLon84qJT+/gwo
         iJp2n2ooNEhwco4QWGsYuuZF7jtvTe5TqUArqUynj5rDggNqEXymeFfAbImlFR9Fxx0m
         Z2mjJq5C/fp9YtmlNq0O8dz9+hl3KiOw7zVz8AjWYNLSxStyegDpU9O9rcwNTNpkuxHb
         bOgswURhoci4obvJ9unAkWK9GTBf8q7XLyB91lFwlxgZ6UAu52G+EAmUiPYCSkMCofWM
         qjirs9hGxIc6wYC6knMU6KUZQB/6i4xDl64RiTKOLVoCvrrrEhFsdfMstSHdNGFhm3ao
         4g9g==
X-Gm-Message-State: ANhLgQ1WKhut+Vi9hD/mQzGj1mbktvS61PfZr0ma/ixRxgR741Cof4TQ
        KTsQyY16gOq4hYMIySBZzt+zb+QrzSFEjo4H/kQilVXZSWT/3Na/S3b6dWqXS2WYX951P1ElIfo
        X2jYLnwv6qYnb4wP7krKHXddae1OJ7X1Kh5X1ujUSPRkAz4QtA2HCXVSWe5n+0jTAdVPJ31i0E6
        Br
X-Google-Smtp-Source: ADFU+vuskHNCxMhoW5eAzhzsxIn4HUnBqH+hHcepZztZdEx+VXMc8mgO8fUAgEk1+0FxnZ3uxsbIBjNwjxsR
X-Received: by 2002:a05:6102:2250:: with SMTP id e16mr16254918vsb.130.1584333624125;
 Sun, 15 Mar 2020 21:40:24 -0700 (PDT)
Date:   Mon, 16 Mar 2020 12:40:05 +0800
Message-Id: <20200316123914.Bluez.v1.1.I2c83372de789a015c1ee506690bb795ee0b0b0d9@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [Bluez PATCH v1] input: disconnect intr channel before ctrl channel
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
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

 profiles/input/device.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 8ada1b4ff..8ef3714c9 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1010,14 +1010,19 @@ static bool is_connected(struct input_device *idev)
 
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
+		shutdown(sock, SHUT_RDWR);
+	}
 
 	if (idev->uhid)
 		return 0;
-- 
2.25.1.481.gfbce0eb801-goog

