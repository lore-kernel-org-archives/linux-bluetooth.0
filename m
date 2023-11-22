Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo6IUW0B"
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6708A98
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 13:07:38 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-677fe97ddf8so1464636d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 13:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700687257; x=1701292057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpjHUUmesT38WXvxFqXbZh63His/ipJlPqZEbY6lOS0=;
        b=bo6IUW0BGPVx3JoxqbgxwJjqv11BION5o3+d8Q1T0n2314zrSDzr0UDpaYXMEWKGEq
         dZr28IysZobUGLXTPIru2XXIL9uCmd0TE0iK58tteGf+ogJa3XSeZ4MJwfKnPqZX5pda
         JopT+Vgxwg25Qi4cXSyu1ENhe+Hql15VNPje9Py0pdx3srOI1VT35j8xh5umJnQzZq6R
         ggX4DIUvOpH52HRGjH6CjlKixK/ry79gsKY8BUCHPeCyG00XLkIDt+L/1Em1Rz5Ui/o4
         d+L1nPqmuzEmUnGSyDUcGOsRAK03v5aBrLrrRkJmSSuKGwRxykYEKgJvpXEzCcBGXYI3
         cddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687257; x=1701292057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpjHUUmesT38WXvxFqXbZh63His/ipJlPqZEbY6lOS0=;
        b=ZHUBLDNOXQuAbo/RrIBG/GCgPwM7E12eI80Aq5A7Bm038VYRdod6cC1tm3Nx+RU/tn
         B4j6AA7ENUA7RrTDv/a9erEp6Tiw2J5kCIHdnzdFz5EH3nBcUADOKlErVxjLcIbNO5WJ
         K2PrMR4s8XfgQoY3PXAlL5ZtsGal5HT92cPwf0/ihDj1HaUiluwQzXAPrgC5PXWjmvAU
         uBzXzboxmU4KO1lxNTL8djuriRjeBox9dsWddy8ZNBOtwrwio5Iv5hONyhYbIAZbF6He
         U874ENBXRS2E5xICNMjkzQdRZQLVkVMwTSLJTmcjqaO+2hyhiPG2iJAWc05ao9haXXr1
         mTZg==
X-Gm-Message-State: AOJu0YwQI7DeRVVGCUovGA6uZzHRAg1JA6gvkIxAyYwKXKZAsTtBetpf
	5OLa3uLQmWduwpz+pe10d3gpmLRNZ7mew+u2
X-Google-Smtp-Source: AGHT+IEF8yhBRzez1XKXgjZHKd0FDroSXaeTP7gIotaElNu63UwAV10hv9z58yBb+vzuYzqL+lb9VA==
X-Received: by 2002:a05:6214:ace:b0:657:a0cc:635c with SMTP id g14-20020a0562140ace00b00657a0cc635cmr3778401qvi.22.1700687256816;
        Wed, 22 Nov 2023 13:07:36 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id w2-20020a0ca802000000b006781b67abaasm94384qva.109.2023.11.22.13.07.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:07:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/5] isotest: Add presets from GMAP
Date: Wed, 22 Nov 2023 16:07:26 -0500
Message-ID: <20231122210727.893872-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122210727.893872-1-luiz.dentz@gmail.com>
References: <20231122210727.893872-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following presets from GMAP:

16_1_gs
16_2_gs
32_1_gs
32_2_gs
48_1_gs
48_2_gs
32_1_gr
32_2_gr
48_1_gr
48_2_gr
48_3_gr
48_4_gr
---
 tools/isotest.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/isotest.c b/tools/isotest.c
index 234e4f1b0453..2c682bc899fc 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -1089,6 +1089,19 @@ static struct qos_preset {
 	QOS_PRESET("48_4_2", false, 10000, 60, 120, 0x02, 23),
 	QOS_PRESET("48_5_2", false, 7500, 45, 117, 0x02, 23),
 	QOS_PRESET("44_6_2", false, 10000, 60, 155, 0x02, 23),
+	/* QoS configuration support setting requirements for the UGG and UGT */
+	QOS_PRESET("16_1_gs", true, 7500, 15, 30, 0x02, 1),
+	QOS_PRESET("16_2_gs", true, 10000, 20, 40, 0x02, 1),
+	QOS_PRESET("32_1_gs", true, 7500, 15, 60, 0x02, 1),
+	QOS_PRESET("32_2_gs", true, 10000, 20, 80, 0x02, 1),
+	QOS_PRESET("48_1_gs", true, 7500, 15, 75, 0x02, 1),
+	QOS_PRESET("48_2_gs", true, 10000, 20, 100, 0x02, 1),
+	QOS_PRESET("32_1_gr", true, 7500, 15, 60, 0x02, 1),
+	QOS_PRESET("32_2_gr", true, 10000, 20, 80, 0x02, 1),
+	QOS_PRESET("48_1_gr", true, 7500, 15, 75, 0x02, 1),
+	QOS_PRESET("48_2_gr", true, 10000, 20, 100, 0x02, 1),
+	QOS_PRESET("48_3_gr", true, 7500, 15, 90, 0x02, 1),
+	QOS_PRESET("48_4_gr", true, 10000, 20, 120, 0x02, 1),
 };
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
-- 
2.42.0

