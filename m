Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B9EC282C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 13:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C4F21721
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 13:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDjzuRXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfAVNpa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:45:30 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36513 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbfAVNpa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jan 2019 08:45:30 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so19348446edb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jan 2019 05:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=dQXMfrKK633k51y9hnl350MLkTxRXwrZW+Ivg+uxDgI=;
        b=tDjzuRXyMd3ZjT0Asd6G7EI9nDt4QVNfJIYKq6HAOg190EjFAuXJkV1sLjNOhV4TVJ
         n+4Em05cvGeQnE51mUOj22O8FWEnyqKyEHQOgCfpOgI55gQMgp+0bXURZAMF/NVm1xvL
         zjFxzoRSd4MhwM5AIbzXw3RBbQfoR4TBrMyEYT1z7IIdjya9u6N60TDabbhJ1C/AXP3m
         BY2M/yVD6oK+HKq7M99saDHRqGAKvGk8hHrfSkGpnG+1Iohb56h+yqPILX8OV75cg2YV
         5cIqXoIiJ4Ss5DThefr8NTYLMYMnQJzgA9h5bubJ1vIXz7xpI/QDcw601zYDB1wCY4Nm
         0vWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=dQXMfrKK633k51y9hnl350MLkTxRXwrZW+Ivg+uxDgI=;
        b=EMYwL4bWLuAEelyBcIWnc4p0MRZ+MGBaFIefcH4dVE5wyckJxCKWmrUpwYNMyNR/0d
         HKCNN3Wp/2gaz0xSTQ0nyM5CToTe6BSdT5FgS9nefiPtgBAqhsxCTJByyY+Yd36Q5HkD
         ykZOcuB5ERVXNSTuoCeRcpWp/w0VZgXBZv8TD1hPe/+uc7bORfcpklvUDm80MneZY1sA
         1rt6uILOYRFapL42mILaSyzPAHvm0Or91XEAwKQkNOO0s1VP8OXxfRnMvxI+Af7UmNC9
         T/ZNjp73jLhZc7gZhiOYdbikkrJcrLe9JafOHQ1PdzZY/YaiFaasK3tHDa7SNlnBHkqE
         UYrA==
X-Gm-Message-State: AJcUukfM7d7wDw7rhlaA4M7VaGd5tRfh701ZAmpgYJXVXlLy2UsiLfOQ
        klyJnuBTdyoQk2+535NqvnrytBOq
X-Google-Smtp-Source: ALg8bN7ErXs7+d5Fga31V55x10WX5RL73R1oEQE4mxhfm4fQ0MeSYfCSk+BdfNoVV+/M9MV0stJ2gw==
X-Received: by 2002:a17:906:f2c6:: with SMTP id gz6-v6mr28415063ejb.211.1548164727827;
        Tue, 22 Jan 2019 05:45:27 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id dc5-v6sm5319153ejb.53.2019.01.22.05.45.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 05:45:26 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/9] doc/media-api: Enable MediaEndpoint to expose remote SEP
Date:   Tue, 22 Jan 2019 15:45:16 +0200
Message-Id: <20190122134524.20509-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the possibility to expose remote SEP using MediaEndpoint
interface to allow setting a configuration.
---
 doc/media-api.txt | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index b5ad2db12..af9485342 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -500,14 +500,23 @@ Properties	object Player [readonly]
 MediaEndpoint1 hierarchy
 ========================
 
-Service		unique name
+Service		unique name (Server role)
+		org.bluez (Client role)
 Interface	org.bluez.MediaEndpoint1
-Object path	freely definable
+Object path	freely definable (Server role)
+		[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/sepX
+		(Client role)
 
 Methods		void SetConfiguration(object transport, dict properties)
 
 			Set configuration for the transport.
 
+			For client role transport must be set with a server
+			endpoint oject which will be configured and the
+			properties must contain the following properties:
+
+				array{byte} Capabilities
+
 		array{byte} SelectConfiguration(array{byte} capabilities)
 
 			Select preferable configuration from the supported
@@ -532,6 +541,20 @@ Methods		void SetConfiguration(object transport, dict properties)
 			endpoint, because when this method gets called it has
 			already been unregistered.
 
+Properties	string UUID [readonly, optional]:
+
+			UUID of the profile which the endpoint is for.
+
+		byte Codec [readonly, optional]:
+
+			Assigned number of codec that the endpoint implements.
+			The values should match the profile specification which
+			is indicated by the UUID.
+
+		array{byte} Capabilities [readonly, optional]:
+
+			Capabilities blob, it is used as it is so the size and
+			byte order must match.
 
 MediaTransport1 hierarchy
 =========================
-- 
2.17.2

