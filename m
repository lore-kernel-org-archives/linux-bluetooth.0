Return-Path: <SRS0=PsJ4=5Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8FEC2BA2B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 20:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09A32075E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 20:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Dtohcq88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgDHUxJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:53:09 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:43673 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbgDHUxJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Apr 2020 16:53:09 -0400
Received: by mail-lj1-f178.google.com with SMTP id g27so9142993ljn.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2020 13:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wb2l5MlE5PDSa/vPETkuDpxKceTJxVH4B42sQMrryig=;
        b=Dtohcq88cp3mbc2xBG8HFDICPDxPOnk36R65EceeByu6izAKKmSSlJ2KOVUcSThiNU
         8fVwXiVgrKWJj1jT5DrE6ef5qSGlst8gY7Lkj+dmO57AZeZ1QdiieHjoStO6O1Aci6q1
         CflL6av9edLeDwG0E0MaQZUKn9FkiGn2IxRKdJ27ZkAPjTwJ89g+ZHr1CffkY90Ztn1f
         96O92heHqn3h/RvcjYyq+1PQ3OSMxYxqshxefx9myQwa7JqGgd5RuTEi+KP2ihTBfoT+
         QHYrYQPOSomd7VmWFHg6VKXb7jylKzXlEoUoRey7v/APioKaAzS7lI03VmRkeqOANcYi
         0g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wb2l5MlE5PDSa/vPETkuDpxKceTJxVH4B42sQMrryig=;
        b=gCQaGpBGNTj7ogmYBtBaj+iB2K39YSRj8mdWL+isaFFEDELaQTGEqdyCDklk1lUo63
         Sn3YcQJtJl/R5ZD7sPXA1vXq6Nrs9RLSvIZjwuaieg20iHaWIlnSQK5irL14HDUpPo9r
         encmP5K4voUIjAlUajCRsmH9mY3XTDJ1Ei4/inoboHpFcRZeEJ1Ad0otqW0/EZD+RE3C
         Px8/shxIxyYOubNrV540mxrZBia3+H6cyN6vOuQkzPCaIadTde86yD0RwrraqaK3MMor
         pP5gB6QZM0yNY8+yL/oTLr2stelXZhZzh8YJJKjXUgqTT1KdTDmm+7qV53E9iyJ1z5u6
         X1/w==
X-Gm-Message-State: AGi0Puaw+84gzoBR8taLgygFz5eld3L4rKdRNY2bfg35+yvX2TkvRfi6
        SAZSnxoAYmrFy+u98n86XfOcejP7Eig=
X-Google-Smtp-Source: APiQypKaUCRLwiPP0S/jafkndC6hfIE3mWzLRV3AwYvdsezIRVUT/vm/qP2W0mOxeEV8oQk6lXNZdQ==
X-Received: by 2002:a2e:b610:: with SMTP id r16mr6269823ljn.254.1586379185585;
        Wed, 08 Apr 2020 13:53:05 -0700 (PDT)
Received: from kynes.internet.domowy (apn-37-7-76-34.dynamic.gprs.plus.pl. [37.7.76.34])
        by smtp.gmail.com with ESMTPSA id r24sm14168976ljn.25.2020.04.08.13.53.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:53:05 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] doc/mesh: Change API to deliver tokens via JoinComplete
Date:   Wed,  8 Apr 2020 22:52:53 +0200
Message-Id: <20200408205255.45112-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200408205255.45112-1-michal.lowas-rzechonek@silvair.com>
References: <20200408205255.45112-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If Application is not be able to reliably store the token, the daemon
will end up with a uncontrollable node in its database.

Let's fix the issue by always delivering tokens using JoinComplete call,
and expecting a reply - if the application return an error, daemon will
get rid of the node.
---
 doc/mesh-api.txt | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index c7374703b..08e34096d 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -29,6 +29,10 @@ Methods:
 		therefore attempting to call this function using already
 		registered UUID results in an error.
 
+		When provisioning finishes, the daemon will call either
+		JoinComplete or JoinFailed method on object implementing
+		org.bluez.mesh.Application1 interface.
+
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.AlreadyExists,
@@ -123,7 +127,7 @@ Methods:
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
 
-	uint64 token CreateNetwork(object app_root, array{byte}[16] uuid)
+	void CreateNetwork(object app_root, array{byte}[16] uuid)
 
 		This is the first method that an application calls to become
 		a Provisioner node, and a Configuration Client on a newly
@@ -155,11 +159,14 @@ Methods:
 		unicast address (0x0001), and create and assign a net_key as the
 		primary network net_index (0x000).
 
+		When creation finishes, the daemon will call JoinComplete method
+		on object implementing org.bluez.mesh.Application1 interface.
+
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.AlreadyExists,
 
-	uint64 token Import(object app_root, array{byte}[16] uuid,
+	void Import(object app_root, array{byte}[16] uuid,
 				array{byte}[16] dev_key,
 				array{byte}[16] net_key, uint16 net_index,
 				dict flags, uint32 iv_index, uint16 unicast)
@@ -204,11 +211,8 @@ Methods:
 		The unicast parameter is the primary unicast address of the
 		imported node.
 
-		The returned token must be preserved by the application in
-		order to authenticate itself to the mesh daemon and attach to
-		the network as a mesh node by calling Attach() method or
-		permanently remove the identity of the mesh node by calling
-		Leave() method.
+		When import finishes, the daemon will call JoinComplete method
+		on object implementing org.bluez.mesh.Application1 interface.
 
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments,
@@ -770,6 +774,10 @@ Methods:
 		permanently remove the identity of the mesh node by calling
 		Leave() method.
 
+		If this method returns an error, the daemon will assume that the
+		application failed to preserve the token, and will remove the
+		freshly created node.
+
 	void JoinFailed(string reason)
 
 		This method is called when the node provisioning initiated by
-- 
2.26.0

