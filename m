Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Djz4nkXx"
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBE6D4F
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 07:33:07 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d7f3a4bbc6so3221370a34.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 07:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701185586; x=1701790386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=74mfR+dMyZy/NzcmTvsJTEzMeHyapPSMfQSrzcgRGkU=;
        b=Djz4nkXxIBiuWOa6u05m8TptiP4UxMtlYq7kV8N9UgLcfRpHCFnB6UoL3iDPsPppOl
         n4aszU5PAud7IHrStjxR7LSHCQsXh4yWUm/uUNwwlO9HZEiLb5FFF4d6MIZ79Yl3aavL
         kRYsznkM9dhGSMy12B9IhwnNU7/oOPfVGRhS69Mp72s55/ouzod98tfJ1WTx41FdjMNT
         a/R1DXEnPfBMGf9XsO/8RhjrE2BlTO9CfWkE+YLsIlAYQQGJDe3RHldg1BupS1HjA1SW
         g0IysHLxMp6GZt8XZG5wVjbDafz0zC6tMFrgUu/zvtojhuiguhLA4OGS8QbIZo3cg3Hk
         gvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701185586; x=1701790386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74mfR+dMyZy/NzcmTvsJTEzMeHyapPSMfQSrzcgRGkU=;
        b=oZ5qn8CunpES+zZCkyBZiYuQNeutCCQYciUDARvd9AnnIr5loIXy8xUR5Nd8JK8kYV
         r8ABls5gcXz5b0oHA7Pj3xpURCf7Evxv5W7ZwhTXtXP0COTzePMnlZRLakLGWa4MUMrb
         b41j7bPuGUfMU3b8WjuLpCz0kg1F0KXCAzyocgHjlWA3cD4eEuEtCZmo7s1+UbRTza9J
         kVtGC9sCpgRnRSCPn9zCzlEivZSO4zYASF2s6pkNpC7WC9CqGAB8KPJZwg0ao/dZNnv3
         b/ZzQVeuBx9m1WcJfnIQqCLkWI8Lyw/DVY4vBaqwIn269zm6kU1qAEpEzpXSxEF2NisO
         gftQ==
X-Gm-Message-State: AOJu0YzKu/uodUJmgOU/MvbGZNlfnwJu0EeweIpEt+HT5w6osuBhETcS
	ZIYLLK5psfNzMag/4sPmShH30zGGe9pW4w==
X-Google-Smtp-Source: AGHT+IE6GqY8U+LpO5OQ+eaQ+Fef/Mlgh5l5M+B5m+jQ2Nfu1Q6MCq7i1TM32+sXYm9Cq4YByInCBw==
X-Received: by 2002:a05:6358:7205:b0:16d:fd30:6d14 with SMTP id h5-20020a056358720500b0016dfd306d14mr14369578rwa.17.1701185585713;
        Tue, 28 Nov 2023 07:33:05 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id p60-20020a9f36c2000000b007c1814e4ee1sm2206295uap.6.2023.11.28.07.33.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 07:33:05 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] isotest: Fix high-reliability QoS presets
Date: Tue, 28 Nov 2023 10:33:03 -0500
Message-ID: <20231128153303.1731575-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This changes the high-reliability QoS presets to be conformant to
BAP[1] specification:

  Table 5.2: QoS configuration support setting requirements for the
  Unicast Client and Unicast Server

[1] https://www.bluetooth.com/specifications/bap-1-0-1/

Fixes: https://github.com/bluez/bluez/issues/665
---
 tools/isotest.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/isotest.c b/tools/isotest.c
index 2c682bc899fc..771d24b6d2a6 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -1073,22 +1073,22 @@ static struct qos_preset {
 	QOS_PRESET("48_5_1", false, 7500, 15, 117, 0x02, 5),
 	QOS_PRESET("44_6_1", false, 10000, 20, 155, 0x02, 5),
 	/* QoS Configuration settings for high reliability audio data */
-	QOS_PRESET("8_1_2", true, 7500, 45, 26, 0x02, 41),
-	QOS_PRESET("8_2_2", true, 10000, 60, 30, 0x02, 53),
-	QOS_PRESET("16_1_2", true, 7500, 45, 30, 0x02, 41),
-	QOS_PRESET("16_2_2", true, 10000, 60, 40, 0x02, 47),
-	QOS_PRESET("24_1_2", true, 7500, 45, 45, 0x02, 35),
-	QOS_PRESET("24_2_2", true, 10000, 60, 60, 0x02, 41),
-	QOS_PRESET("32_1_2", true, 7500, 45, 60, 0x02, 29),
-	QOS_PRESET("32_2_1", true, 10000, 60, 80, 0x02, 35),
-	QOS_PRESET("44_1_2", false, 8163, 54, 98, 0x02, 23),
-	QOS_PRESET("44_2_2", false, 10884, 71, 130, 0x02, 23),
-	QOS_PRESET("48_1_2", false, 7500, 45, 75, 0x02, 23),
-	QOS_PRESET("48_2_2", false, 10000, 60, 100, 0x02, 23),
-	QOS_PRESET("48_3_2", false, 7500, 45, 90, 0x02, 23),
-	QOS_PRESET("48_4_2", false, 10000, 60, 120, 0x02, 23),
-	QOS_PRESET("48_5_2", false, 7500, 45, 117, 0x02, 23),
-	QOS_PRESET("44_6_2", false, 10000, 60, 155, 0x02, 23),
+	QOS_PRESET("8_1_2", true, 7500, 75, 26, 0x02, 13),
+	QOS_PRESET("8_2_2", true, 10000, 95, 30, 0x02, 13),
+	QOS_PRESET("16_1_2", true, 7500, 75, 30, 0x02, 13),
+	QOS_PRESET("16_2_2", true, 10000, 95, 40, 0x02, 13),
+	QOS_PRESET("24_1_2", true, 7500, 75, 45, 0x02, 13),
+	QOS_PRESET("24_2_2", true, 10000, 95, 60, 0x02, 13),
+	QOS_PRESET("32_1_2", true, 7500, 75, 60, 0x02, 13),
+	QOS_PRESET("32_2_2", true, 10000, 95, 80, 0x02, 13),
+	QOS_PRESET("44_1_2", false, 8163, 80, 97, 0x02, 13),
+	QOS_PRESET("44_2_2", false, 10884, 85, 130, 0x02, 13),
+	QOS_PRESET("48_1_2", false, 7500, 75, 75, 0x02, 13),
+	QOS_PRESET("48_2_2", false, 10000, 95, 100, 0x02, 13),
+	QOS_PRESET("48_3_2", false, 7500, 75, 90, 0x02, 13),
+	QOS_PRESET("48_4_2", false, 10000, 100, 120, 0x02, 13),
+	QOS_PRESET("48_5_2", false, 7500, 75, 117, 0x02, 13),
+	QOS_PRESET("44_6_2", false, 10000, 100, 155, 0x02, 13),
 	/* QoS configuration support setting requirements for the UGG and UGT */
 	QOS_PRESET("16_1_gs", true, 7500, 15, 30, 0x02, 1),
 	QOS_PRESET("16_2_gs", true, 10000, 20, 40, 0x02, 1),
-- 
2.43.0

