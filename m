Return-Path: <SRS0=5uBP=QW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127BAC43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Feb 2019 10:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D184921A80
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Feb 2019 10:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifTEbmYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfBOKO5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:14:57 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:39677 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBOKO4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Feb 2019 05:14:56 -0500
Received: by mail-ed1-f42.google.com with SMTP id b14so7486829edt.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Feb 2019 02:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=kXKIcw5uyV8qEwCRICiS0fVYhe8izBHD8GFRnE73oe4=;
        b=ifTEbmYlZj+ELHFmVM/iLTfrVOuRAANnwo6etSry8dBk+p+m+j+o0C3AT+4s9Dx73w
         nlBG/CMKIIQfwuSwoh6JZkHz0mVKWpQ1Hiqx9wBC1SuIVv8gXxyB1vf3Yk6MbKwg4EAR
         REezMSd4SipYUWlcZ2SmTKCjYWH5b9lWeUFUJmQq0U/+7ft9s3I6p2R0A8S+wTROyZGM
         nR8pVDAaaDKjdhlYhTCovKkx/fZSsqvn43V4AIKddEkjLQIdHsqIqZzV0u9TRPHbitFm
         J4U9czADZzgzJemq+yBT5GarWdrJ8QBl3hlF3VujZb1uBh/UIcPzlqCWf0oV3iOoZGXo
         vM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=kXKIcw5uyV8qEwCRICiS0fVYhe8izBHD8GFRnE73oe4=;
        b=NnWzoYp8WNabqwPXmZuC5HiZdYcdrWEF/IzzbhgVyiE/dSpMs4Xj7H8fyNm3kv+8xC
         BoNhZUxOe1w3Z6XUTOfj9ZWMmz5ma+HGc1JebRmQTilE8fb1uvexmMvdbiXDmk/DHDWk
         fbuGYW6Q2wqPQ78eXaUDpYWoYtjJSSOkWXYpDXShAXnugnPVTUdMHRlZVaK5ueT/8ULs
         lKjcNLNFJ/byepazAouwK8sSyfba8u0fnsHD/zx8ym4kRoKLQB6yGXHSxXFiDBpdxXr6
         EpqJd6qm/ecP3yAN/l4iEnTtdgdUS1ZJWldYZFSe1+akZs2JKEzVS5rmLcHnRMBIDxoE
         RVOQ==
X-Gm-Message-State: AHQUAubtxJxKAs3f040Xh+XXcexlcFVKbhCU/UxwTQjBho32/YYdZUQ/
        k6n3BeaM2o9MA1btIBDXsxDO085ZfZI=
X-Google-Smtp-Source: AHgI3Ibk4BnfxYiSjiO83RSvkSB0GUYdy9H5bt6/Xj0FxgGmFp14SFMZI86OsZWv4gtJdJVd+/4f3Q==
X-Received: by 2002:a17:906:eb95:: with SMTP id mh21mr6118636ejb.220.1550225694496;
        Fri, 15 Feb 2019 02:14:54 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id j54sm171321eda.38.2019.02.15.02.14.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 02:14:53 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] doc/advertising-api: Add support for setting Secondary Channel
Date:   Fri, 15 Feb 2019 12:14:51 +0200
Message-Id: <20190215101451.19767-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables reading and setting the Secondary Channel/PHY supported
by the controller.
---
 doc/advertising-api.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index cfce0f9a3..5cc76f49e 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -129,6 +129,15 @@ Properties	string Type
 			Timeout of the advertisement in seconds. This defines
 			the lifetime of the advertisement.
 
+		string SecondaryChannel [Experimental]
+
+			Secondary channel to be used. Primary channel is
+			always set to "1M" except when "Coded" is set.
+
+			Possible value: "1M" (default)
+					"2M"
+					"Coded"
+
 LE Advertising Manager hierarchy
 ================================
 
@@ -190,3 +199,13 @@ Properties	byte ActiveInstances
 			Possible values: "tx-power"
 					 "appearance"
 					 "local-name"
+
+		array{string} SupportedSecondaryChannel [Experimental]
+
+			List of supported Secondary channels. Secondary
+			channels can be used to advertise with the
+			corresponding PHY.
+
+			Possible values: "1M"
+					 "2M"
+					 "Coded"
-- 
2.17.2

