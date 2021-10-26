Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C6EC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 18:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CA660C4B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 18:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbhJZSUn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 14:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238171AbhJZSUm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 14:20:42 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEFDC061745
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 11:18:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id m21so284709pgu.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 11:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pz7hA7yOHbAtOlqe5LGP5QJScgQrTEj6RuUnKh0e6Jk=;
        b=N54CzwbtCXn/4cJ8D+M98bStaJqD43sFK0osIycSqpC78dkM3DTqUO5v1daUAhG5sX
         /HKcHLrOcnSfGmhmzrjTlBfXJTLKDfOMJSL5k3SGtwpEh1vPULwOAr5AfLt27tIakx+y
         ae6JE3UuZYdwIeY5HLHNTmXOYJ2UJvn1S+fufX5Lp1YGCko9xJOYro2cvQfboQpkvFDv
         dLoDqwI5bdVcUyGRB5OF+Qi8ORfo3nqG5Opm1Z2Y7kc61P2yo5qQScIW2KrOzK/4Nmca
         yGl82e6i9g4/AlmqPxJlAxVrVI1D0I6hebTYKnunzmbUchylYT8bODJ07bd6G4K30+AA
         +OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pz7hA7yOHbAtOlqe5LGP5QJScgQrTEj6RuUnKh0e6Jk=;
        b=WfCUuTYPgnVUy8Q8Wkgm96eP8WuVtLN3tRFTihCT6aFvzg/tdNXfXPN63F0cEY+RMb
         ZbcWajz9jURuyDectG3N7xnIFp3Jq4NzCM26BR2jX/vno9EzuHUenkpIEW9TW5UN4PTd
         uqQqNjqBkKBpT503m82vEY76O10MK7a1UKLXepkLE84YTFbg8hggMBsHzoN506epIv4u
         ij7TvA87A2k5hGqU3HcgOWeZTO2ct3Kyzz3++GJi1MAztoQR5uGxlBMZrJpqU+5y1r6q
         URhAtfkU2ljD268D2v5O15L+ng8ADUax7WQkjXabV9UC6PlXSm9WFQXRxXTN8Ovum8gC
         IrUA==
X-Gm-Message-State: AOAM531AT3cLBf1TebxB2DnMRwcqXcVF1Sid7hoHtuQOGea33e5S7jko
        2TDT2h+1o18tJNOUUPLGmAhgQUjsJsE=
X-Google-Smtp-Source: ABdhPJzO7n5wfCG/jCxjg9DfxPzthHU+kN1+8XNAAJValwZoLmLU8z5NPrB3wplMHeFatMz6oon6Vg==
X-Received: by 2002:a05:6a00:1147:b029:3e0:8c37:938e with SMTP id b7-20020a056a001147b02903e08c37938emr27442736pfm.65.1635272297960;
        Tue, 26 Oct 2021 11:18:17 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x202sm7677983pfc.170.2021.10.26.11.18.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:18:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] obexd: Add missing phonebook backends
Date:   Tue, 26 Oct 2021 11:18:15 -0700
Message-Id: <20211026181815.1305602-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026181815.1305602-1-luiz.dentz@gmail.com>
References: <20211026181815.1305602-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds missing phonebook backends to EXTRA_DIST so they can be build
from tarballs.

Fixes: https://github.com/bluez/bluez/issues/222
---
 Makefile.obexd | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile.obexd b/Makefile.obexd
index b9fbc9b3b..37a133455 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -42,6 +42,8 @@ obexd_builtin_sources += obexd/plugins/pbap.c \
 				obexd/plugins/vcard.h obexd/plugins/vcard.c \
 				obexd/plugins/phonebook.h \
 				obexd/plugins/phonebook-@PLUGIN_PHONEBOOK@.c
+EXTRA_DIST += obexd/plugins/phonebook-dummy.c obexd/plugins/phonebook-ebook.c \
+				obexd/plugins/phonebook-tracker.c
 
 obexd_builtin_modules += mas
 obexd_builtin_sources += obexd/plugins/mas.c obexd/src/map_ap.h \
-- 
2.31.1

