Return-Path: <SRS0=8q+o=TD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874CBC43219
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 09:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A912075C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 09:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BF6yXu1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfECJpD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 May 2019 05:45:03 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:38063 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfECJpC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 May 2019 05:45:02 -0400
Received: by mail-lf1-f45.google.com with SMTP id v1so3987908lfg.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 May 2019 02:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pL5g8Gdn7icw2A088OSOwjbavt26vgDag0C+pOR1O5I=;
        b=BF6yXu1A9jmbPIT/KT2YT0lmVOX3YECZ3wMrzBGDBiwgEiPNAm8W9OL1gmGuCLodW6
         k8WjjaVnCBHuyxpZCHK6gUseGVNWNirByWHr1g2AP0Hkp+CTYc8pCGMkC5pD75Ya+TOO
         AQ1dJge3KXH0H3LzNKSQv5+Wlc4yfGsIBKcSErmrnK98jjdkHsS71fB7KcBvQqi3IaTU
         qZO4WgWKwoSAYhOeFehPdr0HaepCja61SldMltVZoYPCfydDJbI8sIE9ZCHgvm70qwPh
         71B+cZPzuEOF78UxDfTWYUJ0Ysjr17SKfWViihwEi4c8jrhyWHIpJGP5bn4Af/Gov7x6
         N7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pL5g8Gdn7icw2A088OSOwjbavt26vgDag0C+pOR1O5I=;
        b=m8pxJSNgUet7urh8BqAWcbUeFcKnKxRE5S+kt+JjYCUdaRDWhfmmOxBP4zZ9sdoI7w
         ilcEQaSIoHftF9KwltGqcCuxgV7Lg5xf4LxRjiFDNt8+Q8AEk1hSinxErFghs+Nv/F6k
         2o/g72mGLeYxije64ZrYGbInEWqCe1bWl44b4vegP9fVAO8ql8/uN0B1E40GSlbZ7Tya
         20fkD2msr7ESxA558NNhhmeD/7wOZHKxuq/jmapFan6d12S5DXFitnzSKuum1vWPSm+X
         vIXnKnANV0ru+tfoYQeCsto8oPjdx2Z73d2QHJ01KudyLDJTsbDJcObTpjzjY5wgSKqh
         kB9w==
X-Gm-Message-State: APjAAAX6Mi6rkIyuF58d1xMxXqkyqiSeyPLOYHJ5FwkNAHxZw6xJERuq
        oLoIVNwiyCneoZYNWv8TBbnRMU9r68WQYQ==
X-Google-Smtp-Source: APXvYqwURSKMDHoTymQ38nvacST49wyyKki2k4Rymr3jt6q4wenkdOwjmY3a2Rkza7lF5oD56uAVnQ==
X-Received: by 2002:ac2:538a:: with SMTP id g10mr4823877lfh.141.1556876700590;
        Fri, 03 May 2019 02:45:00 -0700 (PDT)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id e19sm376455lfd.36.2019.05.03.02.44.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 02:44:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/4] a2dp: Fix reconfiguring when there multiple devices connected
Date:   Fri,  3 May 2019 12:44:54 +0300
Message-Id: <20190503094454.23774-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503094454.23774-1-luiz.dentz@gmail.com>
References: <20190503094454.23774-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When there are multiple devices connected streams need to be matched
with the sessions they belong.
---
 profiles/audio/a2dp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 2ce7c06cb..f89105a8d 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1648,6 +1648,10 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
 							tmp->user_data)))
 				return -EPERM;
 
+			/* Check if stream is for the channel */
+			if (!avdtp_has_stream(chan->session, tmp->stream))
+				continue;
+
 			err = avdtp_close(chan->session, tmp->stream, FALSE);
 			if (err < 0) {
 				err = avdtp_abort(chan->session, tmp->stream);
-- 
2.20.1

