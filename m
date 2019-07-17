Return-Path: <SRS0=OoMZ=VO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C24C76186
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 08:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8D321743
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 08:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="s+uEzeX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfGQIhF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:37:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45616 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQIhE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jul 2019 04:37:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id m23so22710652lje.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2019 01:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XtKh3VCpQshr2zRQu6MayitOcKfNU9hOZUIfGZRFuYc=;
        b=s+uEzeX/BgWhLkE/S14MnQyR7uhqXbzLo+BRgbVupLmI+kTs7geeado052ZmjpNym4
         RSifLqd1sgXAPRGCO9LcaQf0iZhMkPklIjp5+Uwwr6PSg4Mb9KkoF35wvdVD2riA1FdI
         V9Fh5rjiCubD//ioDVSNbegx9QRK5dH43zn8pRo5E6RRy1Siiv6PtNO9Wg2bIjSO6faG
         1XbFhOjUxZVZgGcgxb2Lg4GY+x0DABLJEucUxLzW/QQtZoPXiwbEkE5yXGH9cY8SDgBI
         T3ksJs6P6qouDTdoftPNRJOE/+xAyCKXp90SaCvxfrpgOrlAjtCz/enGWgLRcxYHZ6Kn
         CXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XtKh3VCpQshr2zRQu6MayitOcKfNU9hOZUIfGZRFuYc=;
        b=HCtxlWQn/aRdJyqVmKuBR7XMo2fAp5qkxb9yCZl1eF9fRvFDxPh4lxn97lYbSVM1W4
         d3lZ0zg7bgJhUqjVxe3e+XLvwVyM1q/fNfa8zb6xrL46GzZyfBCHm/lACcB5lUB3Q1HL
         PGTFnMC+tIumiWkkIxbdYMdcoJfJwd1QBjWd5oXBGAbOF+9wIWdOljsH6hVpEe/8OjtQ
         J9AhxVBPuAiiuWLeLv+VpRIidwcMhJofEFQvRZCsChdQrcrwimX5lCIqCjBn5aLSh1us
         MrIw7eWEEygFPx8WiFjXjPN3IBB49c8Ozf6j2KTrD3wuig2h9SN9p7VhdJwxzWgtI0tb
         X4Hw==
X-Gm-Message-State: APjAAAV9XoC3pKKLXouzHFY7tvtaAy23LF6TUtFexjY/ZQ7i6zzbzfIQ
        WArgqjv9/s2FsifkHkVihtakXJOBGeA=
X-Google-Smtp-Source: APXvYqwCG/mcOnRHzZlzkifzZaWmMylpnV1iYM4wMQvos1EpWUsCW/EKyyQq/GSRIU3LSovzeJwt1Q==
X-Received: by 2002:a2e:8515:: with SMTP id j21mr5385491lji.233.1563352622713;
        Wed, 17 Jul 2019 01:37:02 -0700 (PDT)
Received: from localhost.localdomain ([31.0.84.191])
        by smtp.gmail.com with ESMTPSA id v202sm3338708lfa.28.2019.07.17.01.37.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 01:37:02 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jakub Witowski <jakub.witowski@silvair.com>
Subject: [PATCH BlueZ v5 1/4] mesh: Add ImportLocalNode API documentation
Date:   Wed, 17 Jul 2019 10:36:47 +0200
Message-Id: <20190717083650.26346-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190717083650.26346-1-michal.lowas-rzechonek@silvair.com>
References: <20190717083650.26346-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Jakub Witowski <jakub.witowski@silvair.com>

This updates the mesh-api.txt with new ImportLocalNode() API.
---
 doc/mesh-api.txt | 52 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 0ac2fdfd1..7c2a1fafa 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -151,16 +151,31 @@ Methods:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.AlreadyExists,
 
-	 uint64 token ImportLocalNode(string json_data)
+	uint64 token ImportLocalNode(object app_root, array{byte}[16] uuid,
+							string data_type, array{byte} import_data)
 
 		This method creates a local mesh node based on node
 		configuration that has been generated outside bluetooth-meshd.
 
-		The json_data parameter is a full JSON representation of a node
-		configuration file. The format must conform to the schema
-		defined in "Mesh Node Configuration Schema" section. Any
-		included token will be ignored in favor of a locally generated
-		token value.
+		The app_root parameter is a D-Bus object root path of the
+		application that implements org.bluez.mesh.Application1
+		interface.
+
+		The import_data parameter contains a representation of a
+		provisioned node. Format of this representation depends on
+		value of data_type parameter.
+
+		Allowed data_type values are: "json".
+
+		When data_type is "json", bluetooth-meshd daemon treats
+		import_data is a JSON document following <TBD> schema. See the
+		examples at the end of this document.
+
+		The import_data parameter can contain either minimal, or
+		complete representation of a provisioned node.
+
+		When a complete representation is provided, it is validated
+		against composition data provided by the application.
 
 		The returned token must be preserved by the application in
 		order to authenticate itself to the mesh daemon and attach to
@@ -173,8 +188,8 @@ Methods:
 
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments,
-			org.bluez.mesh.Error.AlreadyExists
-			org.bluez.mesh.Error.NotFound,
+			org.bluez.mesh.Error.AlreadyExists,
+			org.bluez.mesh.Error.NotSupported,
 			org.bluez.mesh.Error.Failed
 
 Mesh Node Hierarchy
@@ -1064,6 +1079,21 @@ Properties:
 		Uniform Resource Identifier points to out-of-band (OOB)
 		information (e.g., a public key)
 
-Mesh Node Configuration Schema
-==============================
-<TBD>
+Mesh Node Configuration Examples
+================================
+Minimal JSON representation for ImportLocalNode():
+
+{
+	"IVindex":0,
+	"IVupdate":0,
+	"unicastAddress":"0012",
+	"deviceKey":"7daa45cd1e9e11a4b86eeef7d01efa11",
+	"netKeys":[
+		{
+			"index":"0000",
+			"key":"2ddfef86d67144c394428ea3078f86f9",
+			"keyRefresh":0
+		}
+	],
+	"sequenceNumber":15  /* optional */
+}
-- 
2.19.1

