Return-Path: <SRS0=h9/h=US=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABAAC31E49
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jun 2019 07:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411392075E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jun 2019 07:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="D3wAxcP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfFSHtA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:49:00 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:32828 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfFSHtA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jun 2019 03:49:00 -0400
Received: by mail-lj1-f182.google.com with SMTP id h10so2290612ljg.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2019 00:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+4LlaA6a665awvFm4yjOmxEhD6nyINS588QTgyS/gTg=;
        b=D3wAxcP1qEQEIyOEytNTMNTAFeWWZnV4kbpUDX6w/nC67hSQALYRCjaMdDkiZ6a0fz
         HMpZfRhGpzvK7rHbp2wCW93lUQ4m4u2G6lGboSSTgr9Ukla4xAfNqtyoOWBwr8onSD9+
         dOn+bTLVDvOmmnzi0elzZCm7qRHfTvcfNryoLN1TVn0MSW4bw52zKHPVyG3SovP/sH/e
         Dg+xJ46kP8hHVWdoaGSA+UuoOvThXZMP2xBHrhSI3i/Azi8kFhFhxnNSJZ+JfPh4J4YY
         MCv/48CbhyUUihozLPoicUo2smAgw/rH5g5s3pP9NQGtrCA1gMW7+OgsitFIa/avKhic
         srGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+4LlaA6a665awvFm4yjOmxEhD6nyINS588QTgyS/gTg=;
        b=uhV6Vo8zkeuY4vK9UCbwuRr13SIJ/VHT5jjxQzEZt2faLeC21jlbUu0QKSbe3zwMI+
         UEHPRloKAE8Jtn1fiG72Ju6MP+wuLnE10R1SkwjqFfjm37v2qf6iDofgSYo4CiiZGhx1
         fvHMoqQqNcLlncLAM8DS/A5dnYMyIHnTse8YvkE/FNEGPMJ7cvhhq4v/3EHJE3bCsgyb
         f7Nnvam8zIim29CIOgE3N1iZuR+n1DMQOpy2QYeZ4/jt/7MWn1hIJAiUZvPueZ2Q6eun
         BwQ7d852ONjCWHt31Iup6IjcUVoawxGZcEar2u6GIOHiw0tRVOe5nyWH+7NG/mODHeme
         DR6Q==
X-Gm-Message-State: APjAAAVtCD14V9RBaP2bwrlkga7iQQQERLVx7WsW1YgLniIliOGC3zHv
        pO0yT6PWDbVsJSalx4unEWypoC+GYMQkRg==
X-Google-Smtp-Source: APXvYqwEDV6HfUO07oj6UxskHQ81UdAjkiiZehk916ctvOzqxyVzXIIJz4x5dcWTpUyI3Kx1mYBYQg==
X-Received: by 2002:a2e:8650:: with SMTP id i16mr17089608ljj.178.1560930538550;
        Wed, 19 Jun 2019 00:48:58 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 11sm2948097ljc.66.2019.06.19.00.48.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 00:48:57 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>,
        Brian Gix <brian.gix@intel.com>
Subject: [PATCH v2] mesh: Return dbus error code on Leave() with invalit token given
Date:   Wed, 19 Jun 2019 09:48:51 +0200
Message-Id: <20190619074851.24039-1-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes NotFound error from mesh-api.txt from Leave() function.
---
 doc/mesh-api.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 2a800468b..c82732d2c 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -112,8 +112,6 @@ Methods:
 		identified by the 64-bit token parameter. The token parameter
 		has been obtained as a result of successful Join() method call.
 
-		PossibleErrors:
-			org.bluez.mesh.Error.NotFound
 
 	uint64 token CreateNetwork(object app_root, array{byte}[16] uuid)
 
-- 
2.20.1

