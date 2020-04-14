Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBD9C2BB85
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 08:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D69D2074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 08:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="t4Ef3Yel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437244AbgDNIzv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437239AbgDNIzp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Apr 2020 04:55:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB00EC0A3BE2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 01:55:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u13so12886035wrp.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 01:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=L5GiMjQby01dqR0vl4XnhvCIDDKqRZfrlvKJr6NqcmM=;
        b=t4Ef3YelFAJV5/TnpyUnDWfuYqHKEs1fQpYeBuqubEmt/hZUBNurIPyHgjqYC0UuBg
         RA6W2XSJ7uAsdWIwXFEdPxcNPPV5bBfkuXlnQYeGC58lAjVw4IoeavuMQl5rJtwlpY2X
         sGvACcL3iM2X1PJg+5JjXR4j5a6iFvb8LwK5GTnlxxftXPY2BThRw8TQrIxTR/Re6soD
         W5ZIt18Wu/0x3kVkPgfY3ShG0gI3D9ojxZo5ofQFWZh6rX5JcPqxFjZSbenyegmJ9Fgk
         r/LsRd7lBMQBdybvvlfRkLUak59YqNVWPWWJI719Ko/ZfAiDRLQQE/+L2QrcWyGOay+3
         mMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L5GiMjQby01dqR0vl4XnhvCIDDKqRZfrlvKJr6NqcmM=;
        b=LWbsIdg+y5qchor1U+B+zGFNxBj58ugm40p/xe1qhL8YTBTcqbpPe7tOYcJP8AlS/H
         +PdYkb2FAE5gya+bWHpaKlQMHi6bQehX0e7C1vbIcbcU8wNfqRMxtIZzz7ms2xLG7mnz
         wInxUcDiZBgWUeu3aaMv/xKbE7gflLwB122Uc9ZG+huk1Mzv80ZiNuVjCN3h0Zqh7Auc
         rUmpQwrwkvWn5uf7jwZDdlL/qSPrqXEt8QUjXmB383aB5rPlVjKIH1K/cmJp2aSISFrI
         aaSFaFIsQyZQecNuv20GZtW2qQOtskHPp9ZFQy72epNEVMTGOM3OPX0wuRGJsddaQwpD
         qQfA==
X-Gm-Message-State: AGi0Pub9G2fDv2WwE8Jagp+4nEIcBVbisZfyUPryxEAnZkZWWP2U7f5W
        4bYg+X6LGmlGGUGiVo9Oeo9Qnl9olzs=
X-Google-Smtp-Source: APiQypLY2OKsIsQnfQ+AGLf2idVF+j/ClFBvbFqutNUMy27dGMatF7hP4v9CyX68JELjrhjpmRjEEA==
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr24009725wrj.419.1586854542119;
        Tue, 14 Apr 2020 01:55:42 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id w83sm18361553wmb.37.2020.04.14.01.55.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 01:55:41 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 1/4] doc/mesh: Change API to deliver tokens via JoinComplete
Date:   Tue, 14 Apr 2020 10:55:54 +0200
Message-Id: <20200414085557.23464-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414085557.23464-1-michal.lowas-rzechonek@silvair.com>
References: <20200414085557.23464-1-michal.lowas-rzechonek@silvair.com>
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
 doc/mesh-api.txt | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index c7374703b..e38b8d1eb 100644
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
@@ -144,22 +148,20 @@ Methods:
 		therefore attempting to call this function using already
 		registered UUID results in an error.
 
-		The returned token must be preserved by the application in
-		order to authenticate itself to the mesh daemon and attach to
-		the network as a mesh node by calling Attach() method or
-		permanently remove the identity of the mesh node by calling
-		Leave() method.
-
 		The other information the bluetooth-meshd daemon will preserve
 		about the initial node, is to give it the initial primary
 		unicast address (0x0001), and create and assign a net_key as the
 		primary network net_index (0x000).
 
+		Upon successful processing of Create() method, the daemon
+		will call JoinComplete method on object implementing
+		org.bluez.mesh.Application1.
+
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.AlreadyExists,
 
-	uint64 token Import(object app_root, array{byte}[16] uuid,
+	void Import(object app_root, array{byte}[16] uuid,
 				array{byte}[16] dev_key,
 				array{byte}[16] net_key, uint16 net_index,
 				dict flags, uint32 iv_index, uint16 unicast)
@@ -204,11 +206,9 @@ Methods:
 		The unicast parameter is the primary unicast address of the
 		imported node.
 
-		The returned token must be preserved by the application in
-		order to authenticate itself to the mesh daemon and attach to
-		the network as a mesh node by calling Attach() method or
-		permanently remove the identity of the mesh node by calling
-		Leave() method.
+		Upon successful processing of Import() method, the daemon will
+		call JoinComplete method on object implementing
+		org.bluez.mesh.Application1 interface.
 
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments,
@@ -770,6 +770,10 @@ Methods:
 		permanently remove the identity of the mesh node by calling
 		Leave() method.
 
+		If this method returns an error, the daemon will assume that the
+		application failed to preserve the token, and will remove the
+		freshly created node.
+
 	void JoinFailed(string reason)
 
 		This method is called when the node provisioning initiated by
-- 
2.20.1

