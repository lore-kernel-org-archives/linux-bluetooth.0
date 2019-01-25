Return-Path: <SRS0=pNHN=QB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C06C282C0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jan 2019 14:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0189218D0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jan 2019 14:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m809RbmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfAYOi6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:38:58 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:39689 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfAYOi5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Jan 2019 09:38:57 -0500
Received: by mail-lj1-f182.google.com with SMTP id t9-v6so8551540ljh.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jan 2019 06:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=2SeDtgkij5RzAn5Ydahnc+0UdTyRPe4w8M4KMznAQ8g=;
        b=m809RbmCH3NWWWgF8cZxgy99DewLOIqFXMVq6mOyiZGBse9XL7DCAjVeUSTeakDcpD
         PZXGCavACYdGOM3D7bm9c3ekUvkeFq7raKkOCO98LBGTKwNg8A2Xm0Qh49KpyJ2WmsM3
         jPHMkS6k2ZgvwmVQTUxH9+ff+YDhm7jHFbL10LW5ToTT+rcYKEHXXGR8S15AZC5NucnU
         TDyxMKCeglsZNptTbBxthyE4vxfEVwOSvWCqIq26AbAfOjFG7AiefHp2VAvXfZcRg2NK
         PZDs2+W2KV/4z0n88Kjen1XvaUiA6tXX+V8F/Nvq79P9nSN5fQH6cKhkEDiTG4KYmzlj
         ekZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=2SeDtgkij5RzAn5Ydahnc+0UdTyRPe4w8M4KMznAQ8g=;
        b=SjdkmY0Rx+FtpDd2MBJwHAaL0T59u4xNOznd1+oslxAHZu6S4cOzW8NC+o1QXd0AJM
         r0Pff90orEiQ62/273Fvs8q3zQzzRX/Jn70oerWiaCm9+S9LpUyEakVqvQWjBcn0BMjE
         clWIBFvkBHNIB+dZoOyYz/HbFlHAZts0JuHrLoirVtEDXBzvzIDBqMhGazocnbY+XZRQ
         VgKb9g0bgnATl9RHIz7qnLHpLaHwYaAC6GGZu33smiJ/Fa5i/GxfIchiUmPgQKBiC9YL
         dVtm9yZwYD44uD5ofgy/XAem8dVWfPvO8p/yf16L3XAEfjWGTGvgQRXGndufErkXmRXu
         xX0Q==
X-Gm-Message-State: AJcUukfbY4zj3EP7B0XDnc+cIe98UUCj4D08B0Apyo/3YVDFdv65bBig
        7U05skx+CP697VVGUMPRsetU61KpKus=
X-Google-Smtp-Source: ALg8bN4cm5KQ3sMo6L14NdEq5y/M9oWpfQci/cmdVMyBxBB4mig1v7Jy4UyC/tfGvqMEIYDV/6pOVQ==
X-Received: by 2002:a2e:449b:: with SMTP id b27-v6mr9228371ljf.47.1548427135042;
        Fri, 25 Jan 2019 06:38:55 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id 65sm1510637lfp.55.2019.01.25.06.38.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 06:38:53 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] doc/gatt-api: Add Handle property
Date:   Fri, 25 Jan 2019 16:38:52 +0200
Message-Id: <20190125143852.17424-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When acting as server it is useful to select where to allocate the
handle for an attribute so it can be restored in the same position when
restarting the daemon or rebooting the system.

In order to do that the application also needs to know in which handle
the attribute is allocated the very first time it is registered, this
also allows for a better integration with PTS and tools like auto-pts
which needs to know the handles where the attributes have been
allocated.
---
 doc/gatt-api.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 8dda60b8a..491eb026a 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -50,6 +50,14 @@ Properties	string UUID [read-only]
 			Array of object paths representing the included
 			services of this service.
 
+		uint16 Handle [read-write, optional] (Server Only)
+
+			Service handle. When available in the server it
+			would attempt to use to allocate into the database
+			which may fail, to auto allocate the value 0x0000
+			shall be used which will cause the allocated handle to
+			be set once registered.
+
 
 Characteristic hierarchy
 ========================
@@ -257,6 +265,14 @@ Properties	string UUID [read-only]
 				"secure-write" (Server only)
 				"authorize"
 
+		uint16 Handle [read-write, optional] (Server Only)
+
+			Characteristic handle. When available in the server it
+			would attempt to use to allocate into the database
+			which may fail, to auto allocate the value 0x0000
+			shall be used which will cause the allocated handle to
+			be set once registered.
+
 Characteristic Descriptors hierarchy
 ====================================
 
@@ -332,6 +348,14 @@ Properties	string UUID [read-only]
 				"secure-write" (Server Only)
 				"authorize"
 
+		uint16 Handle [read-write, optional] (Server Only)
+
+			Characteristic handle. When available in the server it
+			would attempt to use to allocate into the database
+			which may fail, to auto allocate the value 0x0000
+			shall be used which will cause the allocated handle to
+			be set once registered.
+
 GATT Profile hierarchy
 =====================
 
-- 
2.17.2

