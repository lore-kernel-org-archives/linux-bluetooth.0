Return-Path: <SRS0=/vUS=V2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93659C7618B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 13:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68188206DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 13:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="vfIrmTbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfG2Nk6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:40:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46744 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfG2Nk5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jul 2019 09:40:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so58750782ljg.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2019 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e30zSybaK0eLO+TfGSnPEXS9ILhDTx4pdKOhP1IwLK8=;
        b=vfIrmTbMcp354ntRxG5IlYAO0gmudCWO3afH6S/6mHRGcmQLQb+MbliG8njLLSGddD
         GdccBy+KTzCAXlu+DpmZvT7YvSr3bEZbCGASoVwauwec20pFNX4oPVoPx8xxDdfaKuA0
         WlV7ZuSKXMf1X4y98j9/iYg0bNiURxiu4pw7p9PPxRf/evLVit+LVhnBDyOYp8fjaUc1
         YgaSsh3FIO/CWQRoQnb9xPAij8ha2jOGR5q2IlT/Ci0S1Qz6CjlSPg0HYJ6FOvUEuBdS
         s1w5oJC08LU2ENoMfMB4gxijP6QSMkMBQtINOc+NHJucVhYZc2ppFdNXuAhjN5fNInxD
         g+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e30zSybaK0eLO+TfGSnPEXS9ILhDTx4pdKOhP1IwLK8=;
        b=goUzYdN+hg4TB8+LyUNWu160ZOe7OI3SB81JgSeLS/Ae3PvsBWQw6EyKiPqP+NbMXJ
         sNnFzZkHzYTYXgoL8h5w5ul7uKesDu+7lryQm1I76maW8cpmkfbypreAmXOEyh0I93gy
         QZ8/CUdHC+2CTo+hg7QaSr647arSDTknxJAZtq0+d2ZHZxXW37O3k+kStpDlwqGriOYu
         pmDVXetXIBymkRntgXaOyzQflTHeAge86LvqaWo6H8HR5DkKBrcvvU3RMTSQXM/uCyIX
         1KViWJ0lbtghXx+OJ7BXbMyuCUFCT0sQTYkvhRireI1yTUx4jMLdkB0MBjhpeWGNQAFu
         oGtw==
X-Gm-Message-State: APjAAAWMrAkOEKYW0/OakNiOzt23af/wfRxtT5Z7LU1mf9OR0mV8Rmzm
        VUs3Vn+XtTjqtA9wT1MwBxgKq9O6oSI=
X-Google-Smtp-Source: APXvYqyrk6Dn2K6bY2oAV5B9Gg8LWck+QHqvnjLkfCJcyon/K0fAvLyMSJxj4vTjT/8v4yGcIL4+Sw==
X-Received: by 2002:a2e:3a01:: with SMTP id h1mr1038221lja.132.1564407655693;
        Mon, 29 Jul 2019 06:40:55 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id h84sm12762220ljf.42.2019.07.29.06.40.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 06:40:55 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 2/3] mesh: Add documentation for Import() D-Bus API
Date:   Mon, 29 Jul 2019 15:40:46 +0200
Message-Id: <20190729134047.21033-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190729134047.21033-1-michal.lowas-rzechonek@silvair.com>
References: <20190729134047.21033-1-michal.lowas-rzechonek@silvair.com>
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

