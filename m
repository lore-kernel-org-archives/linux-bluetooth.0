Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CF0C3F6B0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Aug 2022 23:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242179AbiHQXmF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Aug 2022 19:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242483AbiHQXmC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Aug 2022 19:42:02 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4998A1C6
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 16:42:02 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f4so42573qkl.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 16:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=vSA+HPWsuSD7qUqFUVcG0/msermoFukwlhbj3ey3Egc=;
        b=nw8WZwsdbo+/w83igskhTnF6G1CAGc2kma7sZ6WF9ouepEe/YR/usYZGhA8nFunAdS
         d7/V+vk1UyKA+t0SfR7qwM3UI9qHqFriBT0y2HIF8S9ucikBEqXSTwcFOazx377Cegir
         UgoI4nPaPyrNGuwflBemu5IWX+kY2BBFrgW3Pvep/CA3U+CyGPKjaE6SsK7Hkjqwm6Bu
         mVIO7BanC4UuebHVSsY4dlauyrvHLXuUnhn3VS5EyAosfbiqN9TB9vNNzdS7LBz7gGQ6
         v8L3o1p5ZvME5KV1BZmJgzA9oHe3SbmsaXT458B+EKWl/be7lV/JGuJPZatTh1AkvQji
         v1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=vSA+HPWsuSD7qUqFUVcG0/msermoFukwlhbj3ey3Egc=;
        b=ugkLe7rBtcmO7N0WI4LHdkzXMj1IDV+kK03UczISnaZN/88IRLw4gXqGVIbZKjN42F
         7heezkkpXT5Rda74dck5ODa0iwFwOSM6NzqMVykpcOnF5VUEkefNxK9wJiwpp9uTPsxN
         oOS2nYYPvBP8vOUiuHuf0IoEYC4TmGIjkH8GLniHm7ettBq3vV0s2C/M+ZWGdUI+YGhS
         T+BgwHbtjxbDEO9C0bpUkUn5riH/wadetFLlFWMXJtrhUdrT6dikTgnuz2usUOk8Z63d
         hTyHt42Yq7G43vZ9HSpDhL2RpDEDeuM2GeB4m4SBYQdfIX1ZuMpO/zVw/8D6Ti1HIi+p
         kiYQ==
X-Gm-Message-State: ACgBeo1djxCVkvnAf8oGziuDd2/S5ICUptsO84qKOFrhJuCGz/JKiaBA
        ME1htKwaSEqrfJrhwd88WYSD0u7X8LkPBGAc
X-Google-Smtp-Source: AA6agR5namdMPBQRSb+1JBXq5dDJBG5VYuHHoiQaSUmREbqFddlWiBPfrv6vP8J5fjTFqS+OERuKSA==
X-Received: by 2002:a05:620a:2710:b0:6b8:d418:f495 with SMTP id b16-20020a05620a271000b006b8d418f495mr327764qkp.675.1660779720700;
        Wed, 17 Aug 2022 16:42:00 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r25-20020ae9d619000000b006bb2f555ba4sm189637qkk.41.2022.08.17.16.41.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 16:42:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/9] test/simple-endpoint: Add support for LC3 endpoints
Date:   Wed, 17 Aug 2022 16:41:44 -0700
Message-Id: <20220817234146.224081-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220817234146.224081-1-luiz.dentz@gmail.com>
References: <20220817234146.224081-1-luiz.dentz@gmail.com>
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

