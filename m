Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D78C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Aug 2022 00:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345091AbiH0AF6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 20:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiH0AFy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 20:05:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357B7BCC05
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:53 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f17so2957195pfk.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=vSA+HPWsuSD7qUqFUVcG0/msermoFukwlhbj3ey3Egc=;
        b=brJ9wZQMzMGT++H3iR6lGrIw9skW3+Qm8vLFeSuXyb0749Ni+gokHPfR+okMd3YRq7
         rA6E2IgJ8F+HCc0PzxctYKRb1yMXBz3QO8lOuMmuuMEXZNtTv0uufPn+O2ZJgPXm9IfU
         Kb1GMYL5dYxKeILO6QLRHO4ZZ5ACHdUU0DHdcakZfuToOAVSK25oml6YEH+5UJkdaJBV
         a7kKQjb8LZWFsTzm0YSroqpMg6WFfp9gKdvhsES7hWBeYz9BamqDyC5VY38wasSMCNG7
         H53RgAl04yc3T8kBEc5lurflYOnvDHa8LfeZRGuzXQADBAmXnc9cC6x9heriSIBAFIgP
         Gc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=vSA+HPWsuSD7qUqFUVcG0/msermoFukwlhbj3ey3Egc=;
        b=fsEnMmI31RzlDsphqP2x2WRvNflM1PMzomy+pxIw2VLYmr4kXqxoNTiGNzc1lvTYBr
         yu1XJ7SvSNPdn2v5EqZ0lg0WchJZU8S9xR6v12SYI0kT5d9VNoLM1v4gayRaFOAQrvDM
         7sVqCna5dgda3vjwqLRWrXTrnM42XgjOc4EYWeREWWLe4GHkRqCGoze09Uh242RCcDyj
         tekCGfY0ASNpTuHQQAHCOcrnGk2VyjftlehSXwxIADVGlMayiqNUbP8AMnBBNhZXszrN
         N8EP/1fDbsOqyB7rYsz0yxEJeBjzlXQnu2QGF9wzb3v2Q31YKMsB+gJ7A/32EdB2N6C0
         lRSw==
X-Gm-Message-State: ACgBeo0lNzdGZENriJKGr/tUVhhr+daeaZh430l3Hyb0G+2bH78jG7J5
        WH66wH1PFFPsu0DsrgWbWoEd46HzUlc=
X-Google-Smtp-Source: AA6agR64oOsT+zXrYp1QGDpmqWK4fJb6T8TKhQ7+jZz7YYDikDshlKqXIMdm3dVoAkpgOiQ07nftbg==
X-Received: by 2002:a05:6a00:b52:b0:537:232f:9061 with SMTP id p18-20020a056a000b5200b00537232f9061mr6158054pfo.22.1661558752190;
        Fri, 26 Aug 2022 17:05:52 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090a168100b001fa8b909ef0sm2249487pja.7.2022.08.26.17.05.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 17:05:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 07/11] test/simple-endpoint: Add support for LC3 endpoints
Date:   Fri, 26 Aug 2022 17:05:36 -0700
Message-Id: <20220827000540.113414-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827000540.113414-1-luiz.dentz@gmail.com>
References: <20220827000540.113414-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for LC3 sink/source endpoints.
---
 test/simple-endpoint | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/test/simple-endpoint b/test/simple-endpoint
index 59ca189ce50e..463f124d1b6e 100755
--- a/test/simple-endpoint
+++ b/test/simple-endpoint
@@ -18,6 +18,8 @@ A2DP_SINK_UUID = "0000110B-0000-1000-8000-00805F9B34FB"
 HFP_AG_UUID = "0000111F-0000-1000-8000-00805F9B34FB"
 HFP_HF_UUID = "0000111E-0000-1000-8000-00805F9B34FB"
 HSP_AG_UUID = "00001112-0000-1000-8000-00805F9B34FB"
+PAC_SINK_UUID = "00008f96-0000-1000-8000-00805F9B34FB"
+PAC_SOURCE_UUID = "00008f98-0000-1000-8000-00805F9B34FB"
 
 SBC_CODEC = dbus.Byte(0x00)
 #Channel Modes: Mono DualChannel Stereo JointStereo
@@ -41,6 +43,11 @@ MP3_CAPABILITIES = dbus.Array([dbus.Byte(0x3f), dbus.Byte(0x07), dbus.Byte(0xff)
 # JointStereo 44.1Khz Layer: 3 Bit Rate: VBR Format: RFC-2250
 MP3_CONFIGURATION = dbus.Array([dbus.Byte(0x21), dbus.Byte(0x02), dbus.Byte(0x00), dbus.Byte(0x80)])
 
+LC3_CODEC = dbus.Byte(0x06)
+#Bits per sample: 16
+#Bit Rate: 96kbps
+LC3_CAPABILITIES = dbus.Array([dbus.Byte(16), dbus.Byte(96)])
+
 PCM_CODEC = dbus.Byte(0x00)
 PCM_CONFIGURATION = dbus.Array([], signature="ay")
 
@@ -131,6 +138,16 @@ if __name__ == '__main__':
 							"Codec" : CVSD_CODEC,
 							"Capabilities" :  PCM_CONFIGURATION })
 			endpoint.default_configuration(dbus.Array([]))
+		if sys.argv[2] == "lc3sink":
+			properties = dbus.Dictionary({ "UUID" : PAC_SINK_UUID,
+							"Codec" : LC3_CODEC,
+							"Capabilities" :
+                                                        LC3_CAPABILITIES })
+		if sys.argv[2] == "lc3source":
+			properties = dbus.Dictionary({ "UUID" : PAC_SOURCE_UUID,
+							"Codec" : LC3_CODEC,
+							"Capabilities" :
+                                                        LC3_CAPABILITIES })
 
 	print(properties)
 
-- 
2.37.2

