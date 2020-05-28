Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35A0C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 21:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C062E2088E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 21:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKL1AJxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436710AbgE1VxG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 17:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436703AbgE1VxF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 17:53:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3C9C08C5C6
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 14:53:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v2so91268pfv.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 14:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iflpTdnrlYYAFeQ7PdOyqCC9+nfFboZmwKA70zJrtMc=;
        b=PKL1AJxsDXo6MXMh7MiYWujPpYbbx1WToTZHTcsVnJfIENE1Mw/ZtwZRPmATwaHFNq
         oEWTB8hVplDipNxwL5i+QvHsgfgqZ1TkVm7y96mfVTY4CvEX5d21pvyVwxL17pSrcMwN
         or/yiSUWWgZZCgTT9pWxVRWui8/qVMSe5f73EvmELKOid7NRDk/MKsS0m2DWeol1I9na
         XRrjtpBYADVd2c3sng/8y/Lj5rNgZwKpGn1pl+mBuzNEhV+ygrlJAGrLE8DwmgFca4qe
         KbcOD4WA0NMdvfAFIMddt0pn7PYvQkWpoNmWWi+O5u3uPa66A+4DPrm5lkgqoBfgJkB2
         qzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iflpTdnrlYYAFeQ7PdOyqCC9+nfFboZmwKA70zJrtMc=;
        b=SYRWRss0bcpW+/wyXHTliH26MUorifAithDwojWuncX0lFYiPHCB/jYlYIfcwftWTy
         ESesiLvINpm+cd+Jq+Mf3PtMndGS12L1BzwMUbkMeBakmxFETyq5BFRAyLh8cDYadehA
         NSvCunPw/FC8+bzbigXvJTu5ZxWD9923QOoBd6RujcYkSgRbABa8yaqbMYCz8s/ryHeG
         dfsvo+lUVrQWqyI6C2teDO1J0+Z4GXTxt/ltIPpoJw6FfqnSWPALEL1AJnziHDZWoQnk
         lpySS5mxN6LNdKSUZ/47rrRbPWh55YZJ4awltZCE4nj3wc0kaZCako4ojltURgR5fA/c
         v0tA==
X-Gm-Message-State: AOAM532inD4HorIGtHJhlxeATFS0D0KsaN5IG9GnKrCUfspYHi7R/ySa
        hZjfMGEoJHusvuwrFq1x42MkLhaO
X-Google-Smtp-Source: ABdhPJx2spbAWDOsS9iNJRbTN25HNDJrznOdfY4It/Edx+tnvbET2P2/BGZZZOQwYK7NMJ5N3YUUBg==
X-Received: by 2002:a63:d547:: with SMTP id v7mr5018726pgi.413.1590702784169;
        Thu, 28 May 2020 14:53:04 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l4sm5126170pgo.92.2020.05.28.14.53.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 14:53:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] avrcp: Don't attempt to load settings if on volume changed is supported
Date:   Thu, 28 May 2020 14:53:00 -0700
Message-Id: <20200528215300.225894-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200528215300.225894-1-luiz.dentz@gmail.com>
References: <20200528215300.225894-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If only volume changed is supported that means the player cannot really
indicate track/metadata changes so don't attempt to read them.
---
 profiles/audio/avrcp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 75811bf98..8b3debe46 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3814,6 +3814,10 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
 	if (!session->controller || !session->controller->player)
 		return FALSE;
 
+	/* Skip if player status/metadata if only volume changes is supported */
+	if (events == (1 << AVRCP_EVENT_VOLUME_CHANGED))
+		return FALSE;
+
 	if ((session->controller->features & AVRCP_FEATURE_PLAYER_SETTINGS) &&
 			!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
 		avrcp_list_player_attributes(session);
-- 
2.25.3

