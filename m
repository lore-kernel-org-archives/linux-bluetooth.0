Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC598C6FA99
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 21:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjCJV1H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 16:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjCJV1G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 16:27:06 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BEB515EC
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 13:27:04 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id ce8-20020a17090aff0800b0023a61cff2c6so8908712pjb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 13:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678483624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+jGBUV0OLqMity8mIbzv5oDPNzPDQ4MewWZ8hXiWrQ=;
        b=eorSD/2l4bcHHIZ0N9W92OyChHYiltb6hOSE0B+r5k1mw/zP3KIe19Jbk5wXsNu1dg
         BP+VLd0YsKCUpmBAhGZLdqzhYo6LP4f16Ea3z2P+nF9diuoEUw6rWM8Gd9AK6HiK5Z3z
         WP9Sfpf1j5eVitg6MrsRaTOjT3m/PiGksA83eahoTb1AUd4IM9uLMWBUhCTxJSgetOEH
         uDJONJW7MQkNNzmiKAakczDmmwuz9K3de+WhFXM1h2aw7TiaxN7h4F0sXmrj7x/2XZbn
         rUR5Pe12Lp4EwyF45V5wHfLq/9gP6xPE83Y9enP42KfMdtgO/i+ObVUJoPJiV8FY5W4Q
         KsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678483624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+jGBUV0OLqMity8mIbzv5oDPNzPDQ4MewWZ8hXiWrQ=;
        b=5CtkkVYWJzpsLThemNbaDJ6eoZuLv58iIPQuY35/a1qbunnCmvLyUITh8u1697IRYK
         +X1/shHYg/jeTPF/Hn6nHQ1Gth4AxFydw3WshUfKeKQ2fj9DvoXEfi4jgGaMc1cL9TyQ
         g0O8MbiAr47zBPAongGUoYS3sHN9Duf2BtUUyPcGlQkLo4mvTOwfdzbAzap24w9FDFMB
         DdVPPqbK6MdgoC4xc+zfzVWNu9uYDIosiUuFP7kLZXDTwAPQEjEE/5//nxVlUihz9pwv
         JFDcD/UHUe1LXaCrgE7HBYymD6mCiChBW4KqX+K7Wr8oa6zba3JBkj8MkMCLsJu0aMoe
         FFbA==
X-Gm-Message-State: AO0yUKU4vT54sGIEdmo6IPRjcBhvYL9uhM8wyQVak2+JhYq7/I1VzVU3
        jKboWxeFN1ovW0ysx/5XYJXBUgFZNPI=
X-Google-Smtp-Source: AK7set9oEIGi53mV98a4Itz9vVLOBT4OwFLHq9zrSx5xmFAPJZukH/wJvgeOILvDfQ6pqJ8kRy74Ug==
X-Received: by 2002:a17:902:e748:b0:19e:d89a:cf41 with SMTP id p8-20020a170902e74800b0019ed89acf41mr18722926plf.64.1678483623837;
        Fri, 10 Mar 2023 13:27:03 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902ebd000b001994e74c094sm377781plg.275.2023.03.10.13.27.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:27:03 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] client/player: Update High Reliability presets
Date:   Fri, 10 Mar 2023 13:27:00 -0800
Message-Id: <20230310212700.3873714-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310212700.3873714-1-luiz.dentz@gmail.com>
References: <20230310212700.3873714-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This updates High Reliability presets as published in BAP 1.0.1:

https://www.bluetooth.com/specifications/bap-1-0-1/
---
 client/player.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/client/player.c b/client/player.c
index 79b93cc0fe53..57f85d4edcf2 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1360,30 +1360,54 @@ static struct codec_preset lc3_presets[] = {
 			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 155u),
 			LC3_10_UNFRAMED(155u, 5u, 20u, 40000u)),
 	/* QoS Configuration settings for high reliability audio data */
+	LC3_PRESET_HR("8_1_2",
+			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_7_5, 26u),
+			LC3_7_5_UNFRAMED(26u, 13u, 75u, 40000u)),
+	LC3_PRESET_HR("8_2_2",
+			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_10, 30u),
+			LC3_10_UNFRAMED(30u, 13u, 95u, 40000u)),
+	LC3_PRESET_HR("16_1_2",
+			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_7_5, 30u),
+			LC3_7_5_UNFRAMED(30u, 13u, 75u, 40000u)),
+	LC3_PRESET_HR("16_2_2",
+			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_10, 40u),
+			LC3_10_UNFRAMED(40u, 13u, 95u, 40000u)),
+	LC3_PRESET_HR("24_1_2",
+			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_7_5, 45u),
+			LC3_7_5_UNFRAMED(45u, 13u, 75u, 40000u)),
+	LC3_PRESET_HR("24_2_2",
+			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_10, 60u),
+			LC3_10_UNFRAMED(60u, 13u, 95u, 40000u)),
+	LC3_PRESET_HR("32_1_2",
+			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_7_5, 60u),
+			LC3_7_5_UNFRAMED(60u, 13u, 75u, 40000u)),
+	LC3_PRESET_HR("32_2_2",
+			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_10, 80u),
+			LC3_10_UNFRAMED(80u, 13u, 95u, 40000u)),
 	LC3_PRESET_HR("44_1_2",
 			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_7_5, 98u),
-			QOS_FRAMED_2M(8163u, 98u, 23u, 54u, 40000u)),
+			QOS_FRAMED_2M(8163u, 98u, 13u, 80u, 40000u)),
 	LC3_PRESET_HR("44_2_2",
 			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_10, 130u),
-			QOS_FRAMED_2M(10884u, 130u, 23u, 71u, 40000u)),
+			QOS_FRAMED_2M(10884u, 130u, 13u, 85u, 40000u)),
 	LC3_PRESET_HR("48_1_2",
 			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 75u),
-			LC3_7_5_UNFRAMED(75u, 23u, 45u, 40000u)),
+			LC3_7_5_UNFRAMED(75u, 13u, 75u, 40000u)),
 	LC3_PRESET_HR("48_2_2",
 			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 100u),
-			LC3_10_UNFRAMED(100u, 23u, 60u, 40000u)),
+			LC3_10_UNFRAMED(100u, 13u, 95u, 40000u)),
 	LC3_PRESET_HR("48_3_2",
 			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 90u),
-			LC3_7_5_UNFRAMED(90u, 23u, 45u, 40000u)),
+			LC3_7_5_UNFRAMED(90u, 13u, 75u, 40000u)),
 	LC3_PRESET_HR("48_4_2",
 			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 120u),
-			LC3_10_UNFRAMED(120u, 23u, 60u, 40000u)),
+			LC3_10_UNFRAMED(120u, 13u, 100u, 40000u)),
 	LC3_PRESET_HR("48_5_2",
 			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 117u),
-			LC3_7_5_UNFRAMED(117u, 23u, 45u, 40000u)),
+			LC3_7_5_UNFRAMED(117u, 13u, 75u, 40000u)),
 	LC3_PRESET_HR("48_6_2",
 			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 155u),
-			LC3_10_UNFRAMED(155u, 23u, 60u, 40000u)),
+			LC3_10_UNFRAMED(155u, 13u, 100u, 40000u)),
 	/* QoS configuration support setting requirements for the UGG and UGT */
 	LC3_PRESET("32_1_gs",
 			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_7_5, 60u),
-- 
2.39.2

