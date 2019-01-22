Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B41C282C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 13:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFB120879
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 13:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2MTv5I0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfAVNpd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:45:33 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:39757 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfAVNpc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jan 2019 08:45:32 -0500
Received: by mail-ed1-f49.google.com with SMTP id b14so19320509edt.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jan 2019 05:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=+WtCu0rsyZy4nM8CNOMdSd/tCuGs86sGScNx81ACbjI=;
        b=W2MTv5I0ehjYg2dNGGxLhl6OSIjH8f+xk81PYnWVWN/eNdsUf9S5pQEZ2GYpUGePmh
         CRDe9cqQ/nTKeG3CgluL+U1a7vIfN5wTXEGPm6vJcLIXV+HlmPRCs9UzPVFevtNcQgjI
         RKhuQzCbcE1kJbW5hP6NxJrD3PvcgSo0Y4w4ZhIY6SgARMpeytxhughuTo/GTSBlQsvQ
         gHBBr3sKi+ZG7/NAqTUjdp/FfKGuWcLGPIw+Mcu4SaejyIOjsHsgsSFpuXVKCoEPLm2t
         qP1zyxpH+qA8iMSFiTc8Ms97hUUSTq7rN/TGsGRsknO9zjcXoH2qhUqJA+bI054nBQhB
         4g7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=+WtCu0rsyZy4nM8CNOMdSd/tCuGs86sGScNx81ACbjI=;
        b=mnI9L0EhXzImSBSMeXt/caCdHtu/O+/zjADal6ZiFK8BVt5SaN7xaC5Zpp9eBDCMV3
         1Td1ewUYFGT6ZctJvUormhWiy7DNE+cFgfk2dg4716NS6fxcvpC986yEkTlWlnwKEWw1
         xviMXpt3hh8H1OkLJGj7zukjm05nWoNxe2hC0mDvHuG8hoqvQ2pCxyuSPqAZhCtPeoCQ
         MvQMZVDegtoHsndlMd0T8BCaki5tIazCWdO30oRLYIznaZOgSNdnU+Zpqq6UUpKUwR58
         Sm0YYUGFQSWq5jpr3Oa+qOgTbdT0v5GbUrapRrUbCd6U8DVuQNviNRx4lmwKP9F+TThK
         b58w==
X-Gm-Message-State: AJcUukdvYLL7SVEFclOqsBNFba/CgGHDUWEa+fHKozi+C22lbew+uNdj
        3xIsdxqyBGrNWWJKSMuEDbUe7ha8
X-Google-Smtp-Source: ALg8bN58ygNhruVJorRyNqHdl/pK8YZCXsWTWM+UvjJLSP4Un0/VY0brtCbL5gZsr5xz4P3H2HP/QA==
X-Received: by 2002:a17:906:7c52:: with SMTP id g18-v6mr28557984ejp.77.1548164730665;
        Tue, 22 Jan 2019 05:45:30 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id dc5-v6sm5319153ejb.53.2019.01.22.05.45.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 05:45:29 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/9] doc/media-api: Add Endpoint property to MediaTransport
Date:   Tue, 22 Jan 2019 15:45:18 +0200
Message-Id: <20190122134524.20509-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190122134524.20509-1-luiz.dentz@gmail.com>
References: <20190122134524.20509-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Adds endpoint object to MediaTransport so application can resolve which
MediaEndpoint is in use.
---
 doc/media-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index af9485342..292e9034c 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -627,3 +627,8 @@ Properties	object Device [readonly]
 			acquired by the sender.
 
 			Possible Values: 0-127
+
+		object Endpoint [readonly, optional, experimental]
+
+			Endpoint object which the transport is associated
+			with.
-- 
2.17.2

