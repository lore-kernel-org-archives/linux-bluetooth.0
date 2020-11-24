Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E743C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 10:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28B820663
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 10:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTJTm2Bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbgKXK5v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 05:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgKXK5u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 05:57:50 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759F3C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 02:57:49 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id 18so10490951pli.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 02:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ioncRx1OLhB8Xpr2Z6WOgUxx5Su9ADh8PVyv15rPnY8=;
        b=pTJTm2BfjKGEXbMAovNzLD8+mxHsFHoEmXxus4NDf2WQP5YJsuWHVIi02q5DeKHfEH
         G+ntwBFwymXFdOeY5CAx5jSWprgrwOHnJLn8c9LrD8hyDGNi74S41QZFBHKKg9ce9U4M
         OzSKQS3tE6TnKWamuH7/L+1t4JfyjCVS4RL/YPkXmF7ycmr/D4zIHY6DSFBQCi6KsP1C
         rVMrdkEHiQWILXeeJsaTRgxJhnv5YzPVLmmBZOP8er9GNRv55sdXK0fN9aYh4M1DBmbP
         tBNoLjA6Fonbf84zQuL3+6/8PxvbK092+HxoajPHHd10MsFwo2ldsZinhqsvDzLlyafR
         rB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ioncRx1OLhB8Xpr2Z6WOgUxx5Su9ADh8PVyv15rPnY8=;
        b=F/1lENYwLnysyC468+b5oLLrqyMl1FYjVtGT8hGo6vNpinnVGCoKn3wd/gE0RKPjvM
         wn/QTC2eN1PLeuNPwFfVIyXv4RzvPX8OOsOCV7O1RJ6cFNd+YBQMU1Px4StkpV7j0VD6
         M8md/MFGDAy4e8EDzctEUJXNw7ouhYJFCwnBg0yapsoAVjEARsGF36KIkD9RqJNcJgJd
         tgjG4jiB9FD8dgoQTskZxIkjUqoFQXhOu1bTH7oOYVF0kUydY34Hh/xv207rtJ/MuLb/
         peErcqhCoQxRJEAE8uTefUGGTLSYopdWZPEh9KFeVgR7q6Xqu3T/T1r7edrvW+rHFcK0
         Jmgg==
X-Gm-Message-State: AOAM532Gls4xCk4vQFATtkvpMDXH5eatGk7Wsj6t4TTkl3X/Wv7D47V+
        cqxUIQPGTeHfJNJ0SzEDg16Gtts/CHQ=
X-Google-Smtp-Source: ABdhPJxHf2HdIj3HSDAQU6g+DENw0/qa8Bxze+5YJ91I3OG+sokiewjhtifg9g/Qccj6WRGIUcIMtw==
X-Received: by 2002:a17:902:c20c:b029:d7:d13f:4172 with SMTP id 12-20020a170902c20cb02900d7d13f4172mr3534276pll.21.1606215468873;
        Tue, 24 Nov 2020 02:57:48 -0800 (PST)
Received: from localhost ([171.76.82.54])
        by smtp.gmail.com with ESMTPSA id f134sm14289850pfa.208.2020.11.24.02.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 02:57:48 -0800 (PST)
From:   Sanchayan Maity <maitysanchayan@gmail.com>
X-Google-Original-From: Sanchayan Maity <sanchayan@asymptotic.io>
To:     linux-bluetooth@vger.kernel.org
Cc:     arun@asymptotic.io, maitysanchayan@gmail.com,
        Sanchayan Maity <sanchayan@asymptotic.io>
Subject: [RESEND PATCH Bluez 1/1] test: simple-endpoint: Add support for LDAC
Date:   Tue, 24 Nov 2020 16:27:33 +0530
Message-Id: <20201124105733.85025-2-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124105733.85025-1-sanchayan@asymptotic.io>
References: <20201124105733.85025-1-sanchayan@asymptotic.io>
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

