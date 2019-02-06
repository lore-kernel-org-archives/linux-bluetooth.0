Return-Path: <SRS0=OPIh=QN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92F1C169C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 14:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FD62075D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 14:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R38ilGbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfBFOw1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:52:27 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36202 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfBFOw0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Feb 2019 09:52:26 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so5560127lfg.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Feb 2019 06:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=FDpAC8AzY0HeOCRovUBQO3a++VQmuet9MbOV4dX35ak=;
        b=R38ilGboFex3eDRrsx+4bCXDiBWAMhgz6N4IIwE6sIMmFcpjpp0SUs1EskzSTijljs
         92+/8O3lRT8/YMfrQzfdO6zb83eUioEzkDeGlR3nVwcM++UFV+lBnX3jF87j4hQ09sJf
         sGyESch8eQaXxSqdl6NlHslq5oL2fg5ajjAvjw5YJmg7Ui73hbSECfqJDkxBnvx5Pvdq
         iARw60HXE9XrXfzsVuKGAfL2VAbh4RYy8IHEolxRzrnVko3dZtsn1FbUGxWNDo0i3JOf
         exbEy+wu6n17NKTcVB9JTXhFSfY6rXLrlyT6K/PQppTx87Uv1g18gWCKJyjjQ0dZg+cb
         c0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=FDpAC8AzY0HeOCRovUBQO3a++VQmuet9MbOV4dX35ak=;
        b=Ji8sSgwnzpe4t+gwcbS8VB0HF7fjQ1QLRlUhnHrmEyuprW6bQAWM0HT/QZGKtIrgIm
         wP/u+hrgTSQsW4LZr3mo7yNow7JsqpnZRQsaSLQRwl7iuRpoViZXx79xfMiEoCsYtFkA
         hVlHVvvofiZys1okzn4q2WxdkKy7mWCPTCBNT87gdU1V+Te9qWMKGMc0iqYlCC3pzNSv
         IbgEhkL5PXWTTIHnqJVVoWV+s5/DRNdkLXCJMEgH0elqoLv9OoxGr225xgkT3PWMtkNs
         LwnEjW8k4HmpEsOdP+UYhnDAOCnzjwzqAw3+7WwkBW0lJP1ahQuPmdeoi3DI17hhL8Qi
         2fAg==
X-Gm-Message-State: AHQUAuYF/moOgXneDvHJRUTrM2cKN1KZoQJPBovWVk+TTR+47IZTx3zu
        i5/VYixHstKQGz6LOTxbq66YDYYc
X-Google-Smtp-Source: AHgI3Ibpuj+86TWAa2aXhb2VyCBvvUe6tVutRB+Vrhf69FW3QDWhcgw27NvzKeSVRzpNOw2ZzUxgSA==
X-Received: by 2002:a19:6f0a:: with SMTP id k10mr6744894lfc.119.1549464743999;
        Wed, 06 Feb 2019 06:52:23 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id a11sm4309523lff.68.2019.02.06.06.52.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 06:52:22 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] doc/gatt-api: Add "type" option to Characteristic.WriteValue
Date:   Wed,  6 Feb 2019 16:52:20 +0200
Message-Id: <20190206145221.29587-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The option "type" can be used to force a certain procedure to be used:
  - "command": Use Write Without Response procedure
  - "request": Use (Long) Write With Response procedure
  - "reliable"" Use Reliable Write procedure
---
 doc/gatt-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 491eb026a..1281dd3fb 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -92,6 +92,12 @@ Methods		array{byte} ReadValue(dict options)
 			characteristic.
 
 			Possible options: "offset": Start offset
+					  "type": string
+						Possible values:
+						"command": Write without
+						response
+						"request": Write with response
+						"reliable": Reliable Write
 					  "mtu": Exchanged MTU (Server only)
 					  "device": Device path (Server only)
 					  "link": Link type (Server only)
-- 
2.17.2

