Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0572C6379F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 18:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E989221F7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 18:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IM35q9f0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbgKWSen (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 13:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbgKWSen (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 13:34:43 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3C7C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2020 10:34:43 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id t21so15060526pgl.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2020 10:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gyK2TwJlTc2wmdIeNd/s9rgrTDB6XMF3KJ3m9I0uZKQ=;
        b=IM35q9f0+43JKOlwuCZJ83m/fYn/f2RsQnNeq3oh3TUTrboHQFmYN7RSqpJeBC8al5
         YRpfszhEDpCMAt93E1rMDX2c+ZHwb9QfHvda4Lq5Lyl7KWOFXZ6NPg2oyI7xwNKPbPXI
         M1qhjem94ph3ZvdiNzzl8Ufu8AhxnjfGIM9Q3sdjf8dnmUURTjlwQiYlq/ZBj6gkKR7a
         3L2Ui+9chLnDOs9++a24q3Bx51/1maySLbx/kxDe0vHCBc2uyNXTfoJrycM4byrTg1Ni
         GEC7eryvKPWtpYPJd62WsIDbL/aiCXYG+rPG//D7D4r/9UgC+w7Uow/Q6bDAnpWnzc9s
         R1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyK2TwJlTc2wmdIeNd/s9rgrTDB6XMF3KJ3m9I0uZKQ=;
        b=SGBVFqbsiPF91y6w9v3JEKEx709dVxLsMC08EIAiq2SmHPocEncUwuPliamjTY4AyF
         CjsTXWmKKz25B7ZEVTk+rkcRGlESzBhcee9wbFYDLw+9RCcmIZKke6Ps+5v3XVNrRzoH
         E3c3e6K1fIcHqQ1D1f4AKiSZyWLMNhpuY0c546WhdnycYJ+E7nNKFMaQAkqm2VeYeiJ3
         ug4Oej7RSnvEOl4T62uzG21qu3Ut7jy2RyF86wSwxSlgTakDCbMUMZFec+iS9VermkFC
         LQlIq4/drxpOmWIbUO3Md8OKy9CCEP9+son5ggNwnhc83YyrN2AmvwyeUrmGOVY/Jev+
         sXWA==
X-Gm-Message-State: AOAM532mzImIhUfYxxbAMcNVSYAT2iujB3YSq4biMaDQ29M/skK4fwNF
        2boswuKtyTD5kB3ZuALKGioNvhYfe1c=
X-Google-Smtp-Source: ABdhPJxCjr7DTbw8+IFlPtwsP2kVGwXG8xV1Tirt/I9yTJ2VsODvDnMtkqfV7INfdmnEITHw18X3Ew==
X-Received: by 2002:a17:90a:a594:: with SMTP id b20mr229932pjq.218.1606156482947;
        Mon, 23 Nov 2020 10:34:42 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a21sm84165pjq.37.2020.11.23.10.34.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 10:34:42 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] avdtp: Fix not sending GetCapabilities
Date:   Mon, 23 Nov 2020 10:34:40 -0800
Message-Id: <20201123183440.433677-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201123183440.433677-1-luiz.dentz@gmail.com>
References: <20201123183440.433677-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

It remote SEP has no codec capabilities it must be read with
GetCapabilities/GetAllCapabilities otherwise we cannot match it with a
local SEP.
---
 profiles/audio/avdtp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index ff0a124c3..1093a3543 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2706,7 +2706,8 @@ static gboolean avdtp_discover_resp(struct avdtp *session,
 
 		sep = find_remote_sep(session->seps, resp->seps[i].seid);
 		if (sep && sep->type == resp->seps[i].type &&
-				sep->media_type == resp->seps[i].media_type)
+				sep->media_type == resp->seps[i].media_type &&
+				sep->codec)
 			continue;
 
 		if (resp->seps[i].inuse && !stream)
-- 
2.26.2

