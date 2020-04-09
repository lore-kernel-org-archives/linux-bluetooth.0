Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D209C2BBFD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 19:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75E22074F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 19:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="vweZXeHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgDITro (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:47:44 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:37066 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDITro (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 15:47:44 -0400
Received: by mail-lf1-f48.google.com with SMTP id t11so589635lfe.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2020 12:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wb2l5MlE5PDSa/vPETkuDpxKceTJxVH4B42sQMrryig=;
        b=vweZXeHIpH16A0A3BIkcv26TPnNQD0WY66G7gNruu2dJ1/NU8Ner7OAyUSbKQ8WebB
         cIg+KkF3z1nEVsYvekx5Mhyt+YVVGBJ56WQqLLOlq6iZU5hDIQujisv4hH/pbYO4MIeT
         luzV6vbVHYYw3LnPJlD90GEIXlp/ZjduaE2355C5936jQ7AB9PtNYbKNdjxJ30Swh83Q
         Lgd/EMFIv23nsjoLM+dMOOsFVjgxKoYocF+aiKpZ+irs08NZW3rI8EHsDfmiT9nbLCJh
         vBGtJa6Hdc4r5mw8qye66pUnDW8tBihBcSpKYmCLSqMRkEwpP8s05+pg4hmGf5Ms85/w
         MqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wb2l5MlE5PDSa/vPETkuDpxKceTJxVH4B42sQMrryig=;
        b=LOm6mwEO/V7wcLsdw0OblCc/PjExQfQit+LafvZeBJqBsJMJjh8b4e9Xihbhoxnsp2
         9zsYsUXvYFLB6rUaz55LHxHW5oVPUyNFqYj5+rX5YNwbrDnKxGdyqzHnNgJpHipavgvZ
         TwUPETLXwnCtM8HlD8CYSoKZKAhSFBFGXywLAWT1Gr11SW6gzAyGbl3fbXv9DInzHTZy
         TlCbd6nUpE+BLFpIITiao2yQMHclb7CQ10iMPBEW205Hrp1/pVA0RFs9cq5MsH6M08h0
         eydb7e2trRVFej10esBjachECkxExOL6LR4HvjU2HNNz78Vuvm+of2B3ph3dm4MOaTym
         /3vQ==
X-Gm-Message-State: AGi0PubzlyjHXF1ve4bgPFkFoioRZpqDKErBMWLVBMj3UV1njTRMbwyS
        300prWV31Mei70yFN1I8GWlGGd9dSE0=
X-Google-Smtp-Source: APiQypKHmudys1OazyLaaEW+NTdfv/LtSESZhLo6dmqTG/RqyodXMj+WrWQdooYYZ9UcowINIsFzpw==
X-Received: by 2002:a19:c64b:: with SMTP id w72mr549948lff.82.1586461663194;
        Thu, 09 Apr 2020 12:47:43 -0700 (PDT)
Received: from kynes.internet.domowy (apn-37-7-76-34.dynamic.gprs.plus.pl. [37.7.76.34])
        by smtp.gmail.com with ESMTPSA id l13sm15915895ljc.84.2020.04.09.12.47.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 12:47:42 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/4] doc/mesh: Change API to deliver tokens via JoinComplete
Date:   Thu,  9 Apr 2020 21:47:31 +0200
Message-Id: <20200409194733.18039-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200409194733.18039-1-michal.lowas-rzechonek@silvair.com>
References: <20200409194733.18039-1-michal.lowas-rzechonek@silvair.com>
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

