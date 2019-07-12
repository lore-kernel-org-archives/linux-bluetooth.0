Return-Path: <SRS0=25t8=VJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B2BC742BD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jul 2019 15:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E5E2084B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jul 2019 15:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7Tedawu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfGLPNe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:13:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45418 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfGLPNe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jul 2019 11:13:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id m23so9643401lje.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jul 2019 08:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PwI9PK2hErb0OwjGvA4sp7NsuotkeTsL3/CYmfGN5po=;
        b=n7TedawueiEUF+u49T1/i7eM99Y9AhO6NtY6e6YHAJ2S2/UiQj8hvFNd0Mqn9Nxtg/
         uN4+tSPA+Nt2kNaxxUWFwO5ZDRWam0MOMk+8/70JxXc5nrjet6SNGjp7rzkP1FIpkQqP
         9gFIyjN6zdW5S7uQx/aflx5jbBDPDFFAOOjgMZWzDaA0cTQYXBZnfSo5tLaaKYBQb7V6
         O8NjemFqqO5eubPfWVQ7Y2N+ojb7NKksEm4rRCvNHiSHfQ4c2Mtb7Se76YD9mI9l3nRa
         9lT5ltRoMRx0r37g7SUUDblr4YNhzipZq1jAjlTdyCvGNZ8Ug84GiOysII6GHSnk5JiL
         CCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PwI9PK2hErb0OwjGvA4sp7NsuotkeTsL3/CYmfGN5po=;
        b=GZnAB1bXWtgxnLqOvZGPo7sojaa4aF/iToYzDyCUbNnf84zet+HEaDeo3o3LBZLksI
         EWYhFiEcM1kP934y1gu6mafIhu/iJuAYeHKnH8OvWcRqhQ5Hr18Q+0D4WQa/KPLtBVq4
         jZXTEDS/khYgq8mwerfKOEKlV5F1O4AN9qBoxicPAslB7qPGoDngC++ez5kABZjvWEZv
         zjNHkYH5MGHw+U8cQPG5ynynmvXgcZG1N0350IJ66TWBTbeoE8ZN/ktIVbot1Xvq7Mxz
         drEFHFgsMNO3FQvOyPBWp52RAonTh3bMyLdFPF4fwNnacVJdnmUCTUcfEsEJgoPIZrIT
         J4Dw==
X-Gm-Message-State: APjAAAVWWOv5HGMPdJ/EWyI5j9vtwiox/c49HADPZKbqCaSh45yjH1Ju
        5C0lUtI5RtzzGWmT3LpAe5JSvnHVlUI=
X-Google-Smtp-Source: APXvYqxzs25ozcdwUAhCWh78Z4hwkRRIjtGrE93GvDbbf9dPowF/amiwclctz5+tYps/9w1RBd50fw==
X-Received: by 2002:a2e:93c5:: with SMTP id p5mr6171945ljh.79.1562944411866;
        Fri, 12 Jul 2019 08:13:31 -0700 (PDT)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id y18sm1478970ljh.1.2019.07.12.08.13.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 08:13:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
Date:   Fri, 12 Jul 2019 18:13:26 +0300
Message-Id: <20190712151329.11333-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses application ObjectManager to discover the MediaEndpoint and
MediaPlayer object of an application and deprecates the use of
RegisterEndpoint and RegisterPlayer.
---
 doc/media-api.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index bca8c9563..07f7ac3e0 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -66,7 +66,27 @@ Methods		void RegisterEndpoint(object endpoint, dict properties)
 
 			Unregister sender media player.
 
+		void RegisterApplication(object root, dict options)
 
+			Register endpoints an player objects within root
+			object which must implement ObjectManager.
+
+			The application object path together with the D-Bus
+			system bus connection ID define the identification of
+			the application.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.AlreadyExists
+
+		void UnregisterApplication(object application)
+
+			This unregisters the services that has been
+			previously registered. The object path parameter
+			must match the same value that has been used
+			on registration.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.DoesNotExist
 Media Control hierarchy
 =======================
 
-- 
2.21.0

