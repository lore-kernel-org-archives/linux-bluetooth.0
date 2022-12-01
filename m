Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8808EC43217
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 18:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiLASsy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 13:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiLASsx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 13:48:53 -0500
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1D597926
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 10:48:52 -0800 (PST)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-13ba8947e4cso1227997fac.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 10:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fz64XmEhise6zlFNf9gXrcY3jCvW7vg18NKkQNGf6MI=;
        b=du2K6qFOjfgtsFrPejkXLX53yFh9FWsmdn5I/CNqJ5IUYKxoDvasDvkR/M8J7WaN3g
         jBxmpvoQ51HxngeNqtusqik7U+ve0p2DdDDS7Yd8cRMyJY5JEF2teoWkEOgrpYZYV4eI
         izQxlNstOgJD/d86P7KnLYMMCghgJDYUOqv8vT8aG7L7PLc/SyNI9rqObZ9BVG+s6D46
         MDd6dwKetIFxxYaF83U7u7/k2BLYGWRrVnhVZI+vrr+w2Oop0FjX84aefsIvhTgueUPA
         GYXLaPc7xnBgak0NA4cdtnfR4htsoq/kN1yztRZ+nydk61G+BjIKXmR7w7oPWJyhUp5N
         6Q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fz64XmEhise6zlFNf9gXrcY3jCvW7vg18NKkQNGf6MI=;
        b=pLnkQTlIo8ejZJzM8Lmk/uBj0dCBSs+AY2KsO1Qzz0MP/qaH5qs6/ieO8Khfjrr6k0
         NjmSCtU6NGFwQXj02k7ydapF4T0BMTQj/xmRneu7JX+RzsdgOfKFsNzoVl8F71NjY0Bl
         XjeoCNY3gVxBZHP21sq3del3GWnIuRQ1M9ECBJaJB650G8NwDq5i8jI4U0XhtzlWDbSB
         2nqlaoDFyYI9AVw5hy6lTt1r+tYqD8a+GeZFe5ZhiG/m3x1sx3iw3/Stb3rWQSyM13Pv
         EIft7N5GKXMGvYBj/j+6QD/hKrRxieaiJ2YNl6k7/R6UMhJ9/PsHDteKpYBNqwmqODVO
         mLEQ==
X-Gm-Message-State: ANoB5pk9md93G3+iV3uoWzivrkyq7QJabpsOXIRjDPMjzUJlJCoqIeSC
        A8+ySFH7ThnQhSxTuHkN1gGplgG4woEPI59Eg52bkOykYvHs7/zifUS2NkXKTDzHS4fcmEU9xx6
        cMhz1OyPBmV845aMTzEOK56Qi3lPoZHhsL2IbCcYT/4XJzZ+c+yAebFTXljPeLXHyooO7pGveJC
        LTfE4LPw==
X-Google-Smtp-Source: AA0mqf54r1ri/xaXyip8b6eziCYaNng3I3WDNRAtQnv3neDoveGlAJ63HHvo2q3y7f5gCcLhjuhwqmksfoJrOW4=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6870:a194:b0:13b:b601:cbd8 with SMTP
 id a20-20020a056870a19400b0013bb601cbd8mr37138560oaf.74.1669920531647; Thu,
 01 Dec 2022 10:48:51 -0800 (PST)
Date:   Thu,  1 Dec 2022 12:48:48 -0600
In-Reply-To: <20221201184647.4060523-1-allenwebb@google.com>
Mime-Version: 1.0
References: <ed43586d-5db7-862e-f012-1f54b5b6583d@molgen.mpg.de>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201184848.4061303-1-allenwebb@google.com>
Subject: [PATCH BlueZ v4 1/1] bluetooth.ver: Export sanitizer symbols
From:   Allen Webb <allenwebb@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix llvm sanitizer support by not hiding sanitizer related symbols.
---
 src/bluetooth.ver | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/bluetooth.ver b/src/bluetooth.ver
index 214fa8a61..a96fda2a1 100644
--- a/src/bluetooth.ver
+++ b/src/bluetooth.ver
@@ -7,6 +7,14 @@
 		debug;
 		baswap;
 		ba2str;
+		/* Don't break LLVM sanitizers */
+		__asan*;
+		__dfsan*;
+		__lsan*;
+		__msan*;
+		__sanitizer*;
+		__tsan*;
+		__ubsan*;
 	local:
 		*;
 };
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

