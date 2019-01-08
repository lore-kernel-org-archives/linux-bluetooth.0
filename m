Return-Path: <SRS0=sr2f=PQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED678C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 15:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC9D214C6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 15:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta609JN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfAHPt4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:49:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39140 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfAHPt4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jan 2019 10:49:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so1903262pgl.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jan 2019 07:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=dQXMfrKK633k51y9hnl350MLkTxRXwrZW+Ivg+uxDgI=;
        b=Ta609JN5zR83cnyz5Ni+Mx5GQdPRZwpYWfQNhO8NBf48nU5CqNEpHgzgiiKK6Yy05B
         Qs/TGJt7b/F0l1Bo6W2zqWLUj+OzsqNhd/9EFOmPrcczAXuIQp5BtOaHDv4QnR15Dn68
         u2r57bI25zJ53sGgy4b5jH4JRDkL2psVmYsnCTScUlKSqB1DEfT/YDJHtxu2+oXESv45
         yUWgPtTPyzmTl6ggzlSY0R5qe7ejLENgLhtyk9irS/nBafx2BQ9nxeI11iMNjyk9CBNo
         4GHr0+u8UeTaVqArUbZwmx8q6vhUzpVOl+NOIKH4trhM4jeydNd97AVsokHFjsxh8MLI
         /++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=dQXMfrKK633k51y9hnl350MLkTxRXwrZW+Ivg+uxDgI=;
        b=UyOUCgFFDGgaY7hUErBT3bLD0O2KxX2w0E7e/x3Oql73mJQJ9gvhM/AIlLGJkR7KcJ
         WH4dOq5Qr9Z2IYAtJZTQWI6Bkmj8L2hOG2oH2p5HpzlFfdaVKvBx+sQO2t2LFuwVQ1hq
         8ywcFK9ehVCBZRjN+T72KasnthAVuYWlDuyFUffC3JgRi8aIuEiSd4wddghmUxj6nLCq
         9Ag9g8o/0itJ13rPQ+1Ikm6BgRohbVuE0niI9UCyATbXpQW92sBJGmdDiO/pmmIs04oY
         BxCp9y7j9ncM6qT54+gld6cFTDsMKnVEBAryRTj4yXGUomqU89feLBD3HWysoyuoeEg5
         O9OA==
X-Gm-Message-State: AJcUukdwwN7Ch1NIlbDrxrmIeA4qHTSY0DLf4zNd/OcSs+Skb/fjUsBR
        tdafdBycnMWdeDEVubhue/HpYUVJ4QY=
X-Google-Smtp-Source: ALg8bN4wgQ8wNsyYmzGjh31UmrDFoYiCNxGcYdf8YaXTmm8hrwBUKVEhlXUqV46YcQIu/rkDYDLIZA==
X-Received: by 2002:a62:710a:: with SMTP id m10mr2222533pfc.69.1546962594847;
        Tue, 08 Jan 2019 07:49:54 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2804:14c:8782:823b::1002])
        by smtp.gmail.com with ESMTPSA id 196sm275082811pfc.77.2019.01.08.07.49.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 07:49:53 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] doc/media-api: Enable MediaEndpoint to expose remote SEP
Date:   Tue,  8 Jan 2019 12:49:45 -0300
Message-Id: <20190108154950.8534-1-luiz.dentz@gmail.com>
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

