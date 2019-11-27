Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB47C432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 09:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7411D2070B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 09:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="I2WMeJOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfK0JnG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 04:43:06 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:36489 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfK0JnF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 04:43:05 -0500
Received: by mail-lf1-f52.google.com with SMTP id f16so16613117lfm.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2019 01:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1//Xzd5dlxFKw75MbZVP8TTIt9f3t0uJP3ixyoBvPxs=;
        b=I2WMeJOvjyWm5Ak/160GxOiOeOR9q27bDff2/OSVLix6BlUc5bslC/tv3lT1JepYjx
         OLx+lCOKLRQENzGnxpU/9gh5MXRmJM87g+UfvnAJ8TBIZDaH1FOL6bjrS46zMoFUozfY
         iONWDQmZex0yrN5r9RXVeH2UkMPmfIn7qWbToqKo0aliZV7pwQOKMA/PR8+eVFXAsBGt
         220KWb7yE7VlXmLZMYwjS+HamE6oUCEsRtRkYkwUAeZiL2Hwb2RJuxLUr2RAQPuKWBwT
         MSAjBt4tTtBpzbHi+R3LnMfRhpEwUYfzMqF+Bk+387wTMtH5vnB/7VCQJp0IgGi4ZNQI
         JdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1//Xzd5dlxFKw75MbZVP8TTIt9f3t0uJP3ixyoBvPxs=;
        b=PbvY6pdO649EFvUhEr669B+rEvBj43AdI+2ynQ/7d5JA4xqGBX/q/g0J7XVy+FhFMl
         JkuM4+uMgdV+IBidfn5JYg4uCRscLYwAM03vvsLV1VH5jHRVQ/kLjTRYqgK0IZaiEsbM
         gqnVx7NGavMa8nmVHIMPjbmMETcblMINyu+2JthH/ZX6kiX91g3+tCH1RN7qhgIXsfh8
         qG28s6mQ/DhZILw1BJeyqG1yBHwVIuKi5rUpzH0fz376+ss28tb+koOlSbKTU6Iza57W
         kIgvC2PxEpG6zrrlpnJR07XEsJeMEEOOUIi3qjoJdtG5i9wkplNoFuMY5UviqFmGUVFB
         okhQ==
X-Gm-Message-State: APjAAAVQ6eydMUflweb5Ruw74ZBfSwtY+3g4Y/FzyuYU10n7ylhlIZ5q
        kgk+v/a5uTHAUx4bTT+2CFBVtN+v8rE=
X-Google-Smtp-Source: APXvYqxFW0JiZxvSyuysy8yfeRurMFTbMemMbNWyBaDyx+ifUcmHZhHzSWFTwteyUW6lwwBj0ntbvQ==
X-Received: by 2002:a05:6512:4c1:: with SMTP id w1mr28195572lfq.141.1574847783311;
        Wed, 27 Nov 2019 01:43:03 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id t143sm2220860lff.2.2019.11.27.01.43.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 01:43:02 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] AUTHORS: Mention Silvair's contributions
Date:   Wed, 27 Nov 2019 10:42:54 +0100
Message-Id: <20191127094254.4037-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191127094254.4037-1-michal.lowas-rzechonek@silvair.com>
References: <20191127094254.4037-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 AUTHORS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/AUTHORS b/AUTHORS
index 25d2e8d4e..9c46015a7 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -102,3 +102,7 @@ Jaganath Kanakkassery <jaganath.k@samsung.com>
 Michał Narajowski <michal.narajowski@codecoup.pl>
 Inga Stotland <inga.stotland@intel.com>
 Alain Michaud <alainm@chromium.org>
+Robert Lubaś <robert.lubas@silvair.com>
+Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
+Jakub Witowski <jakub.witowski@silvair.com>
+Rafał Gajda <rafal.gajda@silvair.com>
-- 
2.19.1

