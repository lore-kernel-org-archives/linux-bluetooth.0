Return-Path: <SRS0=//f6=62=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402C7C54E4A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 May 2020 10:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D6B7206B8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 May 2020 10:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P1reuHxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgELKCK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 May 2020 06:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725889AbgELKCK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 May 2020 06:02:10 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AB1C061A0C
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 03:02:10 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id n22so13559321qtp.15
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 03:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=F2XEkSJ/AGOM5Mnej5QMSu4cMwsXP5dHuguWTCmaVB4=;
        b=P1reuHxL6de0bY7UCai8LkCBRYQ5VYwpkmCgZklpdOYjcobjS+FaziKZ2qOI4DqgWv
         N0wr+72iAmqzKuklKykzfuKTnbEghaKgisUFDeLHpUGhRAkilDu8IQqvStetuc4oFydX
         0gh4yVT8t7WElKGbTIyvcdH0QL5ABZM8Cck5RBUgylf/D1TRyPIpHyQ5PvkbJmvDef0f
         Vg732uMji75Lmro9er6xVGVmRDMVfa6ap/khvwYon3rs+5wRolHbNpj2wOtZsi85y4r7
         QL6j3pDly2kOKuwHDkVevYgfcgpkZiyI4OK6a5unWxUFA1Ay7J1EK7YWcOzfICiMgku4
         c1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=F2XEkSJ/AGOM5Mnej5QMSu4cMwsXP5dHuguWTCmaVB4=;
        b=I3qbTkiQglcNH6Yol+E7kl8MDT19+YsqKsd1Ng7vBzAKq9Cm1ujRVgkKIDHcKzYshg
         aLwzFCaFgOSFyLdfPBbx8jZ4R48eajtqDUFvBxdFvw0f7+/HbhzZPNdMJfyhlc64p1/h
         Zh74o03wzn79N2o7yxHPvzrHLiLHlEjbYScG2HFVJLfskLHXXSHMZSvocJSaDpiotKXg
         94vlrVEKMuYByS6RnTftYBo/GWQCx6KCc0hUggBunTRCxw2SfSw/kg9i5B2n5mw8pk/x
         hmITyi900D8zgXDTVtaCgs6pqa7toPBi+pRkrgjvO43dT6YWSQ1Pmw2fLtUgSXWLOLTX
         3VXg==
X-Gm-Message-State: AGi0PuanlZwKd4iznf5N5+NgxjNBMaX5K+6w0SjKLsVTM4gv2kOoNL5t
        GGXvInZNk49V/q8qxJi6IDbASAwBCIgVpbq59VLyCx4UcOcUFzcM1yc/RYRcf8T9vR7vUfNtYLi
        Ee6H7k4muVj1OW6yrU40jd5/mqe0cOdy6QVVBLqiEdr4nMIdDO6R+10eftM33EfyrZ2G86zGe9i
        7P
X-Google-Smtp-Source: APiQypKOBrIQN3d74DKTCjldzZJjiwTfZ5n8u1lrQdFaixCaPYoHVnaNBZ6X332zik4L47fgaknHpPz72ofk
X-Received: by 2002:a0c:f910:: with SMTP id v16mr19500723qvn.37.1589277729322;
 Tue, 12 May 2020 03:02:09 -0700 (PDT)
Date:   Tue, 12 May 2020 18:02:02 +0800
Message-Id: <20200512180104.Bluez.v1.1.Idd38f20f6ff4fc0b295a0a4a8655079373216933@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [Bluez PATCH v1] audio/avrcp: Fix media player passthrough bitmask
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Michael Sun <michaelfsun@google.com>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Adjust the values of the passthrough bitmask with the declared
keys in avctp.c:key_map, according to section 6.10.2.1 of the
AVRCP specification.
---

 profiles/audio/avrcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 773ccdb60..d93cfdb38 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -298,8 +298,8 @@ static unsigned int avctp_id = 0;
 
 /* Default feature bit mask for media player as per avctp.c:key_map */
 static const uint8_t features[16] = {
-				0xF8, 0xBF, 0xFF, 0xBF, 0x1F,
-				0xFB, 0x3F, 0x60, 0x00, 0x00,
+				0xF1, 0xAF, 0xFF, 0xBB, 0x3F,
+				0xFB, 0x9F, 0x60, 0x00, 0x00,
 				0x00, 0x00, 0x00, 0x00, 0x00,
 				0x00 };
 
-- 
2.26.2.645.ge9eca65c58-goog

