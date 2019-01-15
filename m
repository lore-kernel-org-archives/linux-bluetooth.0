Return-Path: <SRS0=18cS=PX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788EBC43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA1820656
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU44dyLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfAOOM2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:12:28 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40147 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbfAOOM2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jan 2019 09:12:28 -0500
Received: by mail-qk1-f195.google.com with SMTP id y16so1586919qki.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jan 2019 06:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=dQXMfrKK633k51y9hnl350MLkTxRXwrZW+Ivg+uxDgI=;
        b=FU44dyLB0xGLZ0DW7KC77UCgUJ0FXy+XiIY/IhVlrOXTy3Ej/Vx6alCMWJLMLzcgol
         pAoovraoADQXIhkkToTlo5j+nsY1jazDcS831R4qswg5TBEVqo8uv2fP21umfQsosfAO
         kSq7afNK/j6BW0uU+ca8a1ZugE0tvBEucnwseT23PsGLbE59AmdV1yr+vmZotH4lQkCF
         yfsyM8bM1ICWaQTE29BrU46keKy1SNrSTFWtKwhnohEy6V2jkj76J1FWZCQxXPFXhKMN
         AGuYtRL0vG2fvv2a1Ma69PDzyq+V6UzJaVijPOlO8RnSQ7Sips2G5WD4Il8XjO1KBIHC
         +v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=dQXMfrKK633k51y9hnl350MLkTxRXwrZW+Ivg+uxDgI=;
        b=kE7fF0q+swlpc/FuY/Ez5vIIK4KNEjrJAfjUj8x7pd5ZWJD0wVX2zpOaPSxrU5aTK2
         vb9oU/rpM7yiEqK1xN3fHFVLxxifqVJYZNNMNTdax73N4f28tuaSesqvGIVw4w4cNEuC
         5+oxB+skWM+IREexNlXy8lYjLg9uIdSDQ98al78LsbYb7g02aqKXCH7Myac3FB1UdXZ7
         eY0XnfShRuEQTkiahQvuNJ7PWW93jWVHNVlp2jBK31hCYCzhJ40kDVIfS19dZqngHXHa
         hyhk2zM+se7X2bzE+HXFLCdGIC8Xn/tBbZG7Ki+qI0YgX7ke0ea6z+2cVKFCBMTxId5t
         zgeg==
X-Gm-Message-State: AJcUukejnAjLNCyQI3VmwOfomoUscSv2Gpe46T5DVZgSCrDZj0mPU3I2
        mcHoZXGdZ3q+FcAy/aow+f95TW5RHJo=
X-Google-Smtp-Source: ALg8bN41QQ31Ubn4o2q9K9wbyUjtG4A04m4jnsKkSJ5fxUK7eLxHT4YYAgsdcRNcVeDjeXNjqN1ptg==
X-Received: by 2002:a37:a6c2:: with SMTP id p185mr2984598qke.28.1547561547005;
        Tue, 15 Jan 2019 06:12:27 -0800 (PST)
Received: from localhost.localdomain ([186.206.5.228])
        by smtp.gmail.com with ESMTPSA id l95sm10572580qkh.37.2019.01.15.06.12.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 06:12:26 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/8] doc/media-api: Enable MediaEndpoint to expose remote SEP
Date:   Tue, 15 Jan 2019 11:10:16 -0300
Message-Id: <20190115141023.353-1-luiz.dentz@gmail.com>
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

