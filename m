Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A184AC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 12:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77295207C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 12:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="s+wArg+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgFPM1a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFPM12 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 08:27:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D156C08C5C3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 05:27:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x25so7155166edr.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 05:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F+3LHA6an8AXwiLSucktPnHRQI4LAHpvQehaSspu4EQ=;
        b=s+wArg+TR/aHnuI8z9smg55lNRPWVDBlR5D5XaiALBcuHD/VA3oXDuUac17WNKwH4P
         7kt9lqjqvsyBShTzBqWEvuAWjSnfK8aiXhh4bdo1uJJnIarVXCSA3cy8FzaqkOhtzb6A
         M8e1T3CBOd1453bGep89AocEhOEBlTS7JXAB+EbmG/9gDyDDh9gyw5c9hxnuuVBDq3Jr
         SuRQkZM26digq7NIm7aZBXxvMebP9SQeFfTnRFpa/Nwiv7IIC3p78ltvy89CPia9M6OX
         FxZQ9j8BFWnndhLXVlz8VyHB0qAsyVlWFzuW9OdqeT2cGpf2D8t+S1tUy7k7OsXZCOY2
         9NrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+3LHA6an8AXwiLSucktPnHRQI4LAHpvQehaSspu4EQ=;
        b=UTUL7iAqeFnWUMhAw+HfgD6APU1NHUe5fzj206AJSdhUuf1GTtHYw9CxR5E6PBE2PV
         k9L9efZTcxO6DPKsYb0wP380ZAikVED55UH89COD7F2xun5k6P5BYEh2tTIiob1Y4jiv
         i1UZeCZUdwYkG0ZMiIZdzQQLp9c9k26CoxvSN+6PxHBOFAZLwG1s6sp+4tp+hfWVj6Sx
         I+hOJw/m5W/H5aD7DKgFMzHb8uJY3zmFc1s5DZf2S11d4vpArNWqYDmUXoepBllGRRta
         R+OD/S1EPkISJ50j4lRyjC7KIPCIpC/0gpcewoeXlooXhosUt86B8DOSOxVlk99iRtCC
         EmVA==
X-Gm-Message-State: AOAM532idhqcyLD1SYsIB0Hcy1yFVmcb2UguaqmIFMallLW5aJamhwuz
        vTCHQaB8KsCrjB+pM2NSIMwjViPhi0c3hQ==
X-Google-Smtp-Source: ABdhPJzgR3lNYmzQoC2w8OSWQQzEGMaTNmOgah5Rlx7UQ+EI2fobHU4Vrm/Nlo+u5in2kLeq5lep9g==
X-Received: by 2002:a05:6402:1486:: with SMTP id e6mr2200980edv.99.1592310446536;
        Tue, 16 Jun 2020 05:27:26 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id bt11sm3246334edb.48.2020.06.16.05.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:27:26 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Przemys=C5=82aw=20Fierek?= 
        <przemyslaw.fierek@silvair.com>
Subject: [RFC BlueZ 1/2] mesh: Add documentation for AttachFD
Date:   Tue, 16 Jun 2020 14:27:44 +0200
Message-Id: <20200616122745.25056-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616122745.25056-1-michal.lowas-rzechonek@silvair.com>
References: <20200616122745.25056-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Przemysław Fierek <przemyslaw.fierek@silvair.com>

---
 doc/mesh-api.txt | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 6d905cf48..cd2ffd2a8 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -118,6 +118,46 @@ Methods:
 			org.bluez.mesh.Error.AlreadyExists,
 			org.bluez.mesh.Error.Failed
 
+    object node, array{byte, array{(uint16, dict)}} configuration, fd
+            AttachFD(object app_root, uint64 token)
+
+        This is an alternative version of the Attach() method. This method
+        acquires file descriptor for message reception.
+
+        Method behaviour and usage is similiar to the Attach() method.
+        The difference between those two method is that after call AttachFD()
+        all received messages will be passed via file descriptor,
+        instead of daemon calling MessageReceived() and
+        DevKeyMessageReceived() methods.
+
+
+        The data format used for the exchange:
+
+            Message types:
+                0 - Device Key Message
+                1 - Application Key Message
+
+            struct {
+                uint8_t element;
+                uint8_t src;
+
+                uint8_t type;
+                union {
+                    struct {
+                        uint8_t net_idx;
+                        bool remote;
+                    } dev; // only meaningful when type is 0
+
+                    struct {
+                        uint8_t app_idx;
+                        uint16_t dst;
+                        uint8_t label[16]; // only meaningful when dst is virtual
+                    } app; // only meaningful when type is 1
+                }
+
+                uint8_t data[];
+            };
+
 	void Leave(uint64 token)
 
 		This removes the configuration information about the mesh node
-- 
2.20.1

