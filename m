Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFHQI3AQ"
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55373C1
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 11:06:59 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77d60604cebso3251185a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 11:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700680017; x=1701284817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpjHUUmesT38WXvxFqXbZh63His/ipJlPqZEbY6lOS0=;
        b=bFHQI3AQapodN95qEWTJhA89l98mGs1g6l2iMOi+YhHnC/AU5f/6U/bdBHTSZS8YM8
         NXMI6NM2c/QPxsnLidaFmTGRmy4qhTizTGtP2Ga81hc652lSXA10TZ5sA3wPk0LbJdBb
         NGke0fGG6YSAbn0ea7y3Z+z18gzvt57r7P3HO76aZ1Yb5eqFaWuKgyTAOFz7udN0AmSG
         /Lf3TTOos/rE5QinfXo2e7b0Vb1TPp+y3LWpMZswfCmdg2NEr6MxHx234usbnv2ZTA0R
         bdguRw5Xqghw4Oo0QNX0Rp0WPiexi5OgHFRYL/5X0RuwwCOGPoSvj/dfW8/jKI1y9RDg
         1NNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700680017; x=1701284817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpjHUUmesT38WXvxFqXbZh63His/ipJlPqZEbY6lOS0=;
        b=UB37BxUNYSSNkzH/NZsK+i58LqPojtkWhgwQTSfeDPDSW/UgBSCeKbhDoNhtUTXrTy
         fbBg1cG4uN00wW4D7k1Spy2m77STPAmlxWVmRYzhU8IfGLe9chnMlOnV37i6Q0O6IdXT
         C/BLciBmEro2m69kcOeVnFBjbVgDRO64YENw/ecUoEc8Gz/57JphnaoAu0zD//SnMQZC
         QWtShKBRuaLl0JDxRgsE05y2wABHr0j/oUvv8UcG7g9JxLI+bkFQQ0dK1qQLScfQh+cy
         GxW+FUrXp8x39Dw4Qrqe+NtkavTZfHxPE8+GGRS822xUX5Wwjg3GKY475znpjWMSAZf4
         F2cA==
X-Gm-Message-State: AOJu0Yz75AL9lo2XbbgBYYPkwEMJTJiweuUlBXPt7M7XPKBStPzC6U7I
	EW0XUpEweYdj1BWEEkYsJJEaCdKBh7/eM45A
X-Google-Smtp-Source: AGHT+IGIllRBHIEPqxaE9vHmx0wzCgbiax+kFNsIHyvcmmtlBWVL69Wr9fpnEQk4M0OvRgeUv6hQ2Q==
X-Received: by 2002:a05:620a:910:b0:77a:2520:2793 with SMTP id v16-20020a05620a091000b0077a25202793mr3371497qkv.2.1700680017444;
        Wed, 22 Nov 2023 11:06:57 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id b32-20020a05620a272000b0076d25b11b62sm97885qkp.38.2023.11.22.11.06.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:06:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/5] isotest: Add presets from GMAP
Date: Wed, 22 Nov 2023 14:06:48 -0500
Message-ID: <20231122190649.879386-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122190649.879386-1-luiz.dentz@gmail.com>
References: <20231122190649.879386-1-luiz.dentz@gmail.com>
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

