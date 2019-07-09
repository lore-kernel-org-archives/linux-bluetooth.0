Return-Path: <SRS0=Cqm8=VG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914FEC606B0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 10:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C76620645
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 10:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="V3kIWtnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfGIKPb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jul 2019 06:15:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37297 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfGIKPb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jul 2019 06:15:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id z28so10084502ljn.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2019 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LoE8UHfQYiqhNCRstz/3Bc+5W41p/0drFVl1Xc2ZXkA=;
        b=V3kIWtnXJTjzkMTK2VdMYHxqQSvBW21R6vO7uVHwA14uqCluADOjvnXhpnMY9TwBgR
         5L0uxSYAkSFphgjfY748y3+gR2GjxiD7GypkPrAIJaTBTw6HfwRVdqQ9ksqFQpEQ0yzh
         LeEW8TaHT1CLC31bTrWPmHZfJAZP3MK4JHb6VYOQRIc626JsFoCtcd5tqiRlwgGA5p59
         QU4kgKvpXtTrYmKmCXHGy7f8rRrv7WAXgt8oIAcnemXmkc4ShO3sKj5lLXAF1s46rFCj
         xwdKQFubeajI91j+IcQHODYglbf0fhteFVrDtAQfGj+iGsUQ6ssahjkxXPwtNN0Y5f4y
         TDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LoE8UHfQYiqhNCRstz/3Bc+5W41p/0drFVl1Xc2ZXkA=;
        b=k3Uga632spcLfm1CtFdvn2dHsqrpvppil2hZdVU7ACby0lBXoP7Kdmo4lMcRQcqWKM
         bRscXbwroovo/ObeDIs0nBBL/0kB5I4JTTcZ/fwrveehU6wY+gM/wZSnZP2A93tzHXOJ
         /mSMCucdWpsG6O9XTggHYgYSj8wteVRSKcHaSFgmSpGW/KDgN8RLyWngVk+767W5WDRV
         /zwJdm54W0L3+IuEaiayKifDAxjYmtTBrAVqlQv/rLeF5Hi0pkE6XTFaqaUCavV38Bfw
         mc5czH7oNGxs3VanqH05xKB54kaMVHKcKVV5NH34kmI8Ygp5J4Gs/emAKHRJ6JiN8FM1
         IGYQ==
X-Gm-Message-State: APjAAAUPjauRVF0ATJ0oz+O8FjBx579hfEpx8lBoWDmz+rZD297bRpve
        2a2M23WJ65c0jEM/7AUYErOpXr25PQCR4g==
X-Google-Smtp-Source: APXvYqxzpejkXCgf2rBoSPKDox1G8o2faUa5rpR+wjGQd0udRMGtab9vzbawf6FHFCqViVgVrzkSYw==
X-Received: by 2002:a2e:534a:: with SMTP id t10mr12725089ljd.109.1562667329069;
        Tue, 09 Jul 2019 03:15:29 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id d15sm3168364lfq.76.2019.07.09.03.15.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 03:15:28 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v4 1/4] mesh: Add ImportLocalNode api documentation
Date:   Tue,  9 Jul 2019 12:15:19 +0200
Message-Id: <20190709101522.10623-1-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This updates the mesh-api.txt with new ImportLocalNode() API.
---
 doc/mesh-api.txt | 104 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 93 insertions(+), 11 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 893a1a6c0..f2ba164a9 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -151,16 +151,36 @@ Methods:
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
+		interface, and a org.bluez.mesh.Provisioner1 interface.
+
+		The data_type parameter defines the import_data type. Supported
+		data_type parameters:
+			- “json”
+
+		The import_data parameter can be either:
+			- Simplified representation of node configuration with
+			  provisioning data only
+			- Full representation of node configuration with both
+			  provisioning and composition data
+
+		sequenceNumber parameter int the import_data is optional.
+
+		The format must conform to the schema defined in
+		"Mesh Node Configuration Examples" section. Any included token will
+		be ignored in favor of a locally generated token value. If
+		import_data contains composition data (determined by the presence of
+		Elements) it is validated against composition data provided by
+		the application. Otherwise, new node is created based on
+		composition data provided by the application using provisioning data
+		from import_data parameter.
 
 		The returned token must be preserved by the application in
 		order to authenticate itself to the mesh daemon and attach to
@@ -173,8 +193,8 @@ Methods:
 
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments,
-			org.bluez.mesh.Error.AlreadyExists
-			org.bluez.mesh.Error.NotFound,
+			org.bluez.mesh.Error.AlreadyExists,
+			org.bluez.mesh.Error.NotSupported,
 			org.bluez.mesh.Error.Failed
 
 Mesh Node Hierarchy
@@ -1061,6 +1081,68 @@ Properties:
 		Uniform Resource Identifier points to out-of-band (OOB)
 		information (e.g., a public key)
 
-Mesh Node Configuration Schema
-==============================
-<TBD>
+Mesh Node Configuration Examples
+================================
+Example of Json format for ImportLocalNode():
+
+	Import simplified node operation:
+	{
+		"IVindex":0,
+		"IVupdate":0,
+		"unicastAddress":"0012",
+		"deviceKey":"7daa45cd1e9e11a4b86eeef7d01efa11",
+		"sequenceNumber":15
+		"netKeys":[
+		{
+			"index":"0000",
+			"key":"2ddfef86d67144c394428ea3078f86f9",
+			"keyRefresh":0
+		}],
+	}
+
+	Import full node operation:
+	{
+		"cid":"fee5",
+		"pid":"0042",
+		"vid":"0001",
+		"crpl":"2710",
+		"relay":{
+			"mode":"disabled",
+			"count":0,
+			"interval":0
+		},
+		"lowPower":"unsupported",
+		"friend":"unsupported",
+		"proxy":"unsupported",
+		"beacon":"disabled",
+		"defaultTTL":255,
+		"elements":[
+		{
+			"elementIndex":0,
+			"location":"002a",
+			"models":[
+			{
+				"modelId":"0008",
+				"bind":[
+				"0000"]
+			}]
+		}],
+		"IVindex":0,
+		"IVupdate":0,
+		"unicastAddress":"0010",
+		"token":"bba7c60afaa85fc1",
+		"deviceKey":"56325fd145f3d5eee1b82136dc3e1454",
+		"netKeys":[
+		{
+			"index":"0000",
+			"key":"2ddfef86d67144c394428ea3078f86f9",
+			"keyRefresh":0
+		}],
+		"appKeys":[
+		{
+			"index":"0000",
+			"boundNetKey":"0000",
+			"key":"43886b02ca4343beaae26dc4b6773ba4"
+		}],
+		"sequenceNumber":15
+	}
-- 
2.20.1

