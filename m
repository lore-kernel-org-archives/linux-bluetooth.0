Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEF5C5517A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 07:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00D5F2085B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 07:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr0QMD46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgKLHEk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Nov 2020 02:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgKLHEk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Nov 2020 02:04:40 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852EBC0613D1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 23:04:38 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w6so3673470pfu.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 23:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ioncRx1OLhB8Xpr2Z6WOgUxx5Su9ADh8PVyv15rPnY8=;
        b=mr0QMD46DZU1cqk9cRTXEc3ldB6q9VMl2i8neBJG3oW5n4Q67HC+rJ1/L58SDTX37b
         1Kik/1VUAnAmdaX6nOYoUvmR+mdoENK4QFvyWifqEKgtLGcQJsuH646cwzEXS8bX4a1h
         t31M/Pc+6Ymnxb6yINi+mZjLRl19KfdEC2sq2fxVwDrTloWGqyFVBKm7tT7NKjXOv8Wd
         yC/6ZPgscFzvYYJYbMUYejn+PG1LVGMSqWg5P2WlsmbQi5x4Fcl36+74WkeSfXyzlCLQ
         qIQSkXm/vs5Bh3ffXIMoLQImC0qU6utARQ7IqJUurIa+2OMvFg0UgJ9wZGqoscb0rlJR
         lUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ioncRx1OLhB8Xpr2Z6WOgUxx5Su9ADh8PVyv15rPnY8=;
        b=sjNjQdZEurw24uurXW3fRbLZ7V8pwvtG2rzVRu/vqg/xi2gvti2FSVc3+GAmAKehmM
         ucdFCECrX8NNgtit6md6hjoUW/mgb0ndknVtX6ThQfePzopOM2+uz+XQfFZ72lRsbmUe
         KCqJJJUxiVc1h+WJbd6amqG0xdvxxn5IWA67hXzMu2jKMhy0hSLgNw0aN13vodytzKjM
         mwzhSixccEEx+AXu06SuvlklDhDshFrHxWJYWXLu3FyySQeQrEivttUvm+hfU5AyvcFc
         uM5r2umbs9T8nC87jn/8iYc/qVOPfCZTCbW8QzMkzCyNEedUmN8VlVTXC9Jwu2J2OKUW
         n8fw==
X-Gm-Message-State: AOAM533OB8R007aMtoIbnBiu6VUYe0w3Zjrapylsw+AlnJcyiEWtvICZ
        ifM+oCUtZtghAcjOnMVF5lqQWlXpC08=
X-Google-Smtp-Source: ABdhPJzdpiy1JuCr4ZpMJtZ8fCpdI6Dh4/ISmy0jSzFmmvWK0x5ZYQQYgueQdEFrbpNhjVeCbIMGHw==
X-Received: by 2002:a63:f318:: with SMTP id l24mr24539559pgh.193.1605164677920;
        Wed, 11 Nov 2020 23:04:37 -0800 (PST)
Received: from localhost ([122.181.216.76])
        by smtp.gmail.com with ESMTPSA id q33sm3362367pja.42.2020.11.11.23.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 23:04:37 -0800 (PST)
From:   Sanchayan Maity <maitysanchayan@gmail.com>
X-Google-Original-From: Sanchayan Maity <sanchayan@asymptotic.io>
To:     linux-bluetooth@vger.kernel.org, arun@asymptotic.io
Cc:     maitysanchayan@gmail.com, Sanchayan Maity <sanchayan@asymptotic.io>
Subject: [PATCH 1/1] test: simple-endpoint: Add support for LDAC
Date:   Thu, 12 Nov 2020 12:34:26 +0530
Message-Id: <20201112070426.21050-2-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112070426.21050-1-sanchayan@asymptotic.io>
References: <20201112070426.21050-1-sanchayan@asymptotic.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

LDAC is an audio coding technology developed by Sony that enables the
transmission of High-Resolution (Hi-Res) audio contents over Bluetooth.
---
 test/simple-endpoint | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/test/simple-endpoint b/test/simple-endpoint
index 59ca189ce..4d0792a64 100755
--- a/test/simple-endpoint
+++ b/test/simple-endpoint
@@ -29,6 +29,23 @@ SBC_CAPABILITIES = dbus.Array([dbus.Byte(0xff), dbus.Byte(0xff), dbus.Byte(2), d
 # JointStereo 44.1Khz Subbands: Blocks: 16 Bitpool Range: 2-32
 SBC_CONFIGURATION = dbus.Array([dbus.Byte(0x21), dbus.Byte(0x15), dbus.Byte(2), dbus.Byte(32)])
 
+# Should be 0xFF for vendor codecs
+LDAC_CODEC = dbus.Byte(0xff)
+# Frequencies: 44.1 KHZ | 48 KHz | 88.2 KHz | 96 KHz
+# Channels: Mono | Dual | Stereo
+LDAC_CAPABILITIES = dbus.Array([dbus.Byte(0x2d), dbus.Byte(0x01),
+  dbus.Byte(0x00), dbus.Byte(0x00), dbus.Byte(0xaa), dbus.Byte(0x00),
+  dbus.Byte(0x3c), dbus.Byte(0x07)])
+LDAC_CONFIGURATION = dbus.Array([dbus.Byte(0x2d), dbus.Byte(0x01),
+  dbus.Byte(0x00), dbus.Byte(0x00), dbus.Byte(0xaa), dbus.Byte(0x00),
+  # 44.1 KHz, Stereo; 0x20 0x01
+  # 48 KHz,   Stereo; 0x10 0x01
+  # 48 KHz,   Dual  ; 0x10 0x02
+  # 48 KHz,   Mono  ; 0x10 0x04
+  # 88.2 KHz, Stereo; 0x08 0x01
+  # 96 KHz,   Stereo; 0x04 0x01
+  dbus.Byte(0x20), dbus.Byte(0x01)])
+
 MP3_CODEC = dbus.Byte(0x01)
 #Channel Modes: Mono DualChannel Stereo JointStereo
 #Frequencies: 32Khz 44.1Khz 48Khz
@@ -111,6 +128,18 @@ if __name__ == '__main__':
 							"Codec" : SBC_CODEC,
 							"DelayReporting" : True,
 							"Capabilities" : SBC_CAPABILITIES })
+		if sys.argv[2] == "ldacsink":
+			properties = dbus.Dictionary({ "UUID" : A2DP_SINK_UUID,
+							"Codec" : LDAC_CODEC,
+							"DelayReporting" : True,
+							"Capabilities" : LDAC_CAPABILITIES })
+			endpoint.default_configuration(LDAC_CONFIGURATION)
+		if sys.argv[2] == "ldacsource":
+			properties = dbus.Dictionary({ "UUID" : A2DP_SOURCE_UUID,
+							"Codec" : LDAC_CODEC,
+							"DelayReporting" : True,
+							"Capabilities" : LDAC_CAPABILITIES })
+			endpoint.default_configuration(LDAC_CONFIGURATION)
 		if sys.argv[2] == "mp3source":
 			properties = dbus.Dictionary({ "UUID" : A2DP_SOURCE_UUID,
 							"Codec" : MP3_CODEC,
-- 
2.29.2

