Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5D2C169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A412148E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGpOo5c3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfA2N0o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:26:44 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:38629 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbfA2N0o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 08:26:44 -0500
Received: by mail-ed1-f44.google.com with SMTP id h50so15944617ede.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 05:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=G/Ftm0pFdkGx6X26PFfS1xnyy0ImZwYR2rXTjOYdkWA=;
        b=iGpOo5c3/qGzQeAso6la93O90lNByRBrESEmmRL/EfAEo4JrjvLqUc2YtGtDFOG3qe
         n94djxn9zhM6kPkOGJiWsEz2tjeYWqtiRr7lzLOgTngAIZOZCY5GkuzvqfmgNnpO0nRu
         FDkLheriH7dVMePOWhryiDowlpoaM5uMorU9kfmRAWFWDOFOLpAJidbSjz8sRMxba5n9
         51gNq6I5hsJZMJfTFkniGngnoZMx3sUpxzyXReU1enuYNtniALH83JsQEhmFk02uwmyI
         kvm7jnoOiutD4WmLTY7eoY3o0JQ/NXE+LAlFsjiz6VKfZlK67zPof7LXQdJHmqd8JAbi
         Vb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=G/Ftm0pFdkGx6X26PFfS1xnyy0ImZwYR2rXTjOYdkWA=;
        b=GRb2FAYewMGi4TXjuKqyXlxuSp6eFSTQs9fNfQb57bGJP0NQfU+DDevT0kRIkv4m+z
         0ttSzSIloYLhTDP4X8fACl92rPYWgxuIwrJulOwH88iBDMzfSsWdFqwnc/EaeQeQD5QJ
         1NQE5JaObOprXuJQaHCIzs1ZPuc69HoQHXC4dG4roEiCLtFkzO6VwEPXhLH3d6jYrRVX
         AbrfIK95gns/qv7lBbNsHdJxUpW2YXLq+WsDKJz4a+zEtVa1vLkZEYksJsSmkwIHON4C
         h+38k3AI5YOHL7ML+Qwo3rg6ONR2Fn3Xlqj9FVOLnpseI7kDaOQ5RPCZRmwPFMUQ/C/M
         qjnw==
X-Gm-Message-State: AJcUukdU+tshiI/OLe6hgFw2o8+yhMb4lHegCPSTioITLmYjj15i3NHE
        Etob6v8pF6AqxrCUa7r1iOk8IWJG
X-Google-Smtp-Source: ALg8bN4kaBAesCFBpB2SjwS3w4OUC7z8+SSEWu2qbCeh2rH9OSSXrAe8FKXuNG+jO4EUHvyJZL272A==
X-Received: by 2002:a50:f61e:: with SMTP id c30mr24793994edn.197.1548768401761;
        Tue, 29 Jan 2019 05:26:41 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id i14-v6sm8179964ejy.40.2019.01.29.05.26.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 05:26:41 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/15] shared/util: Add decoding support for GATT caching attributes
Date:   Tue, 29 Jan 2019 15:26:23 +0200
Message-Id: <20190129132634.28786-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129132634.28786-1-luiz.dentz@gmail.com>
References: <20190129132634.28786-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support to decode Client Supported Features and Database
Hash.
---
 src/shared/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 145bb2a3a..330a0722a 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -526,6 +526,8 @@ static const struct {
 	{ 0x2adc, "Mesh Provisioning Data Out"			},
 	{ 0x2add, "Mesh Proxy Data In"				},
 	{ 0x2ade, "Mesh Proxy Data Out"				},
+	{ 0x2b29, "Client Supported Features"			},
+	{ 0x2b2A, "Database Hash"				},
 	/* vendor defined */
 	{ 0xfeff, "GN Netcom"					},
 	{ 0xfefe, "GN ReSound A/S"				},
-- 
2.17.2

