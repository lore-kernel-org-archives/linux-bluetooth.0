Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E53C0502A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Aug 2022 23:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345500AbiHZXUw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 19:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345208AbiHZXUp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 19:20:45 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7167EBC83D
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 16:20:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id t129so2899375pfb.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 16:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=vSA+HPWsuSD7qUqFUVcG0/msermoFukwlhbj3ey3Egc=;
        b=pc9Wut6zC16JuKQ7UQRlMekB0MUdz7AZCPUicoxXiBHwgbTIMrDnw6imCAZZCP/Usx
         5FFYleB673IczW8z+us4vGTGJUj4BTKlD585x3k7/7BAQK6gsSPl8DNAvtXJ2vsnxdqe
         5FqpQkftGwJ8u8UeODMVRad1bslqWQhKv4YkTyDqsR32mAVEVIF2EbSChGQKXM1MRc9A
         UIpUd/4MjygoARn/Rt8zX+7LH4L/4rUHia3f5R3COvMKruwjbmLyJwl1UjJRpO8b0g/X
         8HnHDs64wLys1OdS1S4ugpdVSiEkCzGSAcNh4Jk26af80sOALXRCWCK3CHyW3f54qv+G
         9+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=vSA+HPWsuSD7qUqFUVcG0/msermoFukwlhbj3ey3Egc=;
        b=KO18jDsGjueru4gnoPDIA3Tat/msy6V/0X27nvgqEitcbsMqkhs2q5A84kWDV9uDeE
         yQBmrW174yTagshI6OX9qoYpXyrH6iVYcq1FDQJZyUdMU+/XRywLHYFLQt1gGpdwKEzd
         g9/KCcEf11oeTg0DF4nTg1YFx2/UP4jN1uNkFbi1ZCDm0Xqu5H2eim19u+EBTkJ8XjRb
         uTl805Z5jn3sKBCIoXx8bRM9ryLJp7gmGopUaxdxMmnW9QEJMdppqKROscu95g9Olt7T
         asfIAqDErNf9WRxvetMDYh1sA5F2pBLidYNOPWIcF/G5SC3qCFY9/OE0znNgh/gxunoG
         M/Bw==
X-Gm-Message-State: ACgBeo3j3ZywUb6ekuruI9V7Wh+/JR9k6WTsleRQ1DjMol9OpNvVIRGD
        swaD1hThoMRghbLep0OI+7UGvuOjvnQ=
X-Google-Smtp-Source: AA6agR5zajPu0GqAp3pseDCkOAus8zUTI+RGvHFD0TaWVfH2B99cNppiPEmpjE6AArYYg381G+ku1g==
X-Received: by 2002:a05:6a00:1404:b0:537:2330:18d1 with SMTP id l4-20020a056a00140400b00537233018d1mr5977417pfu.39.1661556043394;
        Fri, 26 Aug 2022 16:20:43 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7984f000000b0053645475a6dsm2312338pfq.66.2022.08.26.16.20.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 16:20:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/9] test/simple-endpoint: Add support for LC3 endpoints
Date:   Fri, 26 Aug 2022 16:20:29 -0700
Message-Id: <20220826232031.20391-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826232031.20391-1-luiz.dentz@gmail.com>
References: <20220826232031.20391-1-luiz.dentz@gmail.com>
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

