Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B7BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 15:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C082072F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 15:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vI6vqbAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgFJPFC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJPFB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 11:05:01 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8CFC03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 08:04:59 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id l26so2092917qtr.14
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vNDSMdzW7y2noDTT42tcbQB5so6jv8Z6CwnFPWsb8cg=;
        b=vI6vqbAhStXUSkw4MIULD4ckLr3HhyaUQWp+tvNvldcNVlkivhAn+Wqj79CNWct/NL
         0JN+/0FkvLJGZnNFXPJkxslddngl8rA8eA1tJf91f/gXCLjYWZ59HBrD8qdV9VrrjAdU
         mXVUnkIE2AUSiLeKAMNs+8GRoTH2zSnGoNzuLc69YdQohuRT0KM5vnH0/95f2TE2XR6I
         oB9vcWyLyjz6eWBHYak7YB9q6YVsXjKlEcyuZKCQKXJGNiB1UPrNfmoPaq5OlS0ItdN8
         VMrb5LxBJDN6NX1ZaTMdjNxZePjejAXw2Cf6Lt3og5UVdzZfsYxTLDhscLdyAS9O5Kgj
         KwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vNDSMdzW7y2noDTT42tcbQB5so6jv8Z6CwnFPWsb8cg=;
        b=Wm5HkvzUu12e/UkyHnRg82dKEV3DBP/TUy+6fq7RCUweIMRxncOrY/DK68sKHEx6n0
         WMVu0TpHba4p2fbLa7sHv1dbEVCsEmsksKqmRYFP0H2gr7zEkNh9oJLL+teZEvUyqtKB
         A3FfOqQB6H7JHjQy38egYJxayKGrtnE3D7kiPHgqXFq5FC/r2J1dYUBqVMy3jNBE9t8k
         rAwZiujgyJdJ6SCGJlQyLR7RThVtfKAH/9sOVm4uAMVVcz2BiDybMhUtnxkKvGzVJ3YZ
         bp26yj53P1j9S4G5Z6EHz6EsCVpv1W+f6QO5IwSz9kwtNkEbYQyC9wWQrn8EE93itacb
         UXLQ==
X-Gm-Message-State: AOAM532EGQ/oKkOUUVKlPRC5AQLF1LsHAMxMAgC1md0DsDNKsPAaKtjR
        JyEaNPiGWD4r+t7FGCvK6qvSygi/YlnvE8Wr8Rl6gaElnEzdPfyeAfnP8747EhlCOnEu2ZCz8O9
        5/B8sjJAonFxZUrg4Cx0w3s/AHJ2rWSBnM7Kkjx0Vz1rsXVmthKP8jXnJRaZuZVZAwh2rF05YDY
        GG
X-Google-Smtp-Source: ABdhPJxrEWXVT4UXY0akhYrSlHBn/cb5m19s8JkAcLbUyZRpZUMEjdP71Di6QfxPfBh4x/QAU4l9JIUdPIMi
X-Received: by 2002:ad4:5551:: with SMTP id v17mr3604915qvy.89.1591801499001;
 Wed, 10 Jun 2020 08:04:59 -0700 (PDT)
Date:   Wed, 10 Jun 2020 23:04:46 +0800
Message-Id: <20200610230423.Bluez.v1.1.Id3fa4e63f104f100648140f38d0fc40919b24c69@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [Bluez PATCH v1] input: Disconnect ctrl chan only if intr chan was
 disconnected by us
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

If the intr channel was disconnected by the other party, then they
are also responsible to close the ctrl channel. Such disconnection
message would have the G_IO_ERR flag set, as opposed to it being
unset if the disconnection is initiated by us.

There doesn't seem to be an explicit rule in the specification
about this behavior, but this is enforced in the PTS qualification
tool.
---

 profiles/input/device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index d89da2d7c..a858bbb19 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -333,8 +333,10 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 		idev->intr_io = NULL;
 	}
 
-	/* Close control channel */
-	if (idev->ctrl_io && !(cond & G_IO_NVAL))
+	/* Close control channel if the closing of interrupt channel is not
+	 * initiated by the other party
+	 */
+	if (idev->ctrl_io && !(cond & (G_IO_NVAL | G_IO_ERR)))
 		g_io_channel_shutdown(idev->ctrl_io, TRUE, NULL);
 
 	btd_service_disconnecting_complete(idev->service, 0);
-- 
2.27.0.278.ge193c7cf3a9-goog

