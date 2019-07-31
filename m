Return-Path: <SRS0=Arr2=V4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A39C32751
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Jul 2019 07:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E36218A4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Jul 2019 07:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="gbXf/G56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfGaHQ5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:16:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37010 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfGaHQ5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Jul 2019 03:16:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id z28so10316794ljn.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2019 00:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e30zSybaK0eLO+TfGSnPEXS9ILhDTx4pdKOhP1IwLK8=;
        b=gbXf/G56f07wMxbty1HlJvLttAmdcc93oEB1AW+jw3c1Z+pooVrk2TLdB2x1DvQk6A
         j6rMR4mYXHnN6wqfTDBH7b+8DjhsbNflASkddE8F3CT8oE1C8liPcR5n4irTUlBeDoLU
         5kn7hlIwi6rKjYGCqziXHTqmV93HRHcZeIzXVWvVwO4/QC78wbtf2MZSkYY3tBkBJf7I
         YNDUJwBWuK6PEHpx1uvqVW9Ebs9poKNqFukT8r7uTaermhVWm7s7vJx5fT4xbkkehAr1
         JM+lrQXh9eB/jJRSAMXLBueSEwRPlJag3Lx/jNgVY7Hkysj1lnEyhk7+Zz6tgLSClThL
         f7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e30zSybaK0eLO+TfGSnPEXS9ILhDTx4pdKOhP1IwLK8=;
        b=jfvUhNAshnxWcYsMHmbiGKvTt/RlWmjFCYznvcC0TW7NyVZTAbIAvgxSXDEa/ErO3q
         x7h9opX2XX5XU3ChiNbwwfkQ+OsMElVCjyo9Lz6vOJPFMbpNDJnoqr9I7jmnHX6AQe9x
         gL6NjgQD7pHuPX6ESSFK6PkCYQbBtaoVR1VDsQQNSD2xCH3CwwF+cmeaAHusSwhtdP5/
         99fLKDho/4sEtZs8MvOkyRlw/gJTaSdVcQsG1AboaQdkS14geyNfBzTWFjyZqVok7AEe
         B9870npl6Et2WNLXsYF8YsgA++SgXfNBsiSxZK7qQenI4W0uit8ZDD5xpY30V5/bJ/qh
         bMxA==
X-Gm-Message-State: APjAAAUqKh0C1EFfbLEuyXIKkn3YuNiwIuEzlTCxdk0ZPOZ/Iz55VGfy
        i56F+gWfx3b5gg8SRhI+KAnOlquy27I=
X-Google-Smtp-Source: APXvYqw+vGlxzAH1Wxes8tsO25tWsQlXUNPmAAVuT0m7fiTr6JUJVbwpSMb1wRurQbV5dTR/iseC2Q==
X-Received: by 2002:a05:651c:87:: with SMTP id 7mr54282414ljq.184.1564557414947;
        Wed, 31 Jul 2019 00:16:54 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id n10sm11662477lfe.24.2019.07.31.00.16.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 00:16:54 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 2/3] mesh: Add documentation for Import() D-Bus API
Date:   Wed, 31 Jul 2019 09:16:46 +0200
Message-Id: <20190731071647.27217-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190731071647.27217-1-michal.lowas-rzechonek@silvair.com>
References: <20190731071647.27217-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This replaces previously specified ImportLocalNode() call
---
 doc/mesh-api.txt | 57 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 7b62c0af4..255104ab6 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -151,16 +151,50 @@ Methods:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.AlreadyExists,
 
-	 uint64 token ImportLocalNode(string json_data)
+	uint64 token Import(object app_root, array{byte}[16] uuid,
+				array{byte}[16] dev_key,
+				array{byte}[16] net_key, uint16 net_index,
+				dict flags, uint32 iv_index, uint16 unicast)
 
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
+		The uuid parameter is a 16-byte array that contains Device UUID.
+		This UUID must be unique (at least from the daemon perspective),
+		therefore attempting to call this function using already
+		registered UUID results in an error.
+
+		The dev_key parameter is the 16-byte value of the dev key of
+		the imported mesh node.
+
+		Remaining parameters correspond to provisioning data:
+
+		The net_key and net_index parameters describe the network (or a
+		subnet, if net_index is not 0) the imported mesh node belongs
+		to.
+
+		The flags parameter is a dictionary containing provisioning
+		flags. Supported values are:
+
+			boolean IVUpdate
+
+				When true, indicates that the network is in the
+				middle of IV Index Update procedure.
+
+			boolean KeyRefresh
+
+				When true, indicates that the specified net key
+				is in the middle of a key refresh procedure.
+
+		The iv_index parameter is the current IV Index value used by
+		the network. This value is known by the provisioner.
+
+		The unicast parameter is the primary unicast address of the
+		imported node.
 
 		The returned token must be preserved by the application in
 		order to authenticate itself to the mesh daemon and attach to
@@ -168,13 +202,10 @@ Methods:
 		permanently remove the identity of the mesh node by calling
 		Leave() method.
 
-		It is an error to attempt importing a node with already
-		registered Device UUID.
-
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments,
-			org.bluez.mesh.Error.AlreadyExists
-			org.bluez.mesh.Error.NotFound,
+			org.bluez.mesh.Error.AlreadyExists,
+			org.bluez.mesh.Error.NotSupported,
 			org.bluez.mesh.Error.Failed
 
 Mesh Node Hierarchy
@@ -1069,7 +1100,3 @@ Properties:
 
 		Uniform Resource Identifier points to out-of-band (OOB)
 		information (e.g., a public key)
-
-Mesh Node Configuration Schema
-==============================
-<TBD>
-- 
2.19.1

