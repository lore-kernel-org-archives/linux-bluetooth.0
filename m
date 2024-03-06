Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8141C6B7
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Mar 2024 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766286; cv=none; b=CqV5i3sE30UeBIdm+X6WSzkriPnVKt4NMniCGhVRV/AO5cDS4UKnb2E5l+5hXzP1xM5lguXotaG0wTjQ2PSEzGhWs4m3zZBbPMXgstJEEx6rpFidcENhspKKr9yefqz1EqErrfay13I5WlZs3o0GbxCMgX07SsNssaCMHrA96jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766286; c=relaxed/simple;
	bh=qllPAiKz8yekuHxJCdIuVb+q5+t1YnZC5QhBfhDAZgw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Mh0RncIW9CTa81mgXYoVsBifpvKsr5F2KaOpotTFiip3PXnhNJZjMyep9miFdvQnquimyrFn1cdutprvEP1Ru/kBJ+fIkvjIBSRGUfb+m5zMBo4+yLwgMt/y2IiWP0zl4YatdvxSO3EfCksznfQdmLqnXaMKWzdCiGSqBxgjNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjMgz/wH; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjMgz/wH"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7dad2d1c9edso102900241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Mar 2024 15:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709766283; x=1710371083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Imsnr7Qywrt7DVfCHf6eLFwBd+emp2fk38ieA0NsfHg=;
        b=VjMgz/wHpAlga6g3pWuh+G9WMDavVEA6Bn7ouRYm+poOm4STB2tC035NEmEmwVMnDf
         tAGikJ2D2H9TTMeRKgHFnBUtuw/vALRWj9Vwl3giDdEQsQUSJ601zvyXzSJ343sQcnp+
         7+EIDGrlqvWmn9e6Z9VxDaJwK8QsYSB88iPpTNIySk2DkjPzpM1SG63EALOsYGsTiImz
         Z88LK7X6KMbTfvvVu82IJcHynXd0s8QJpukKX7uRPCZILRxxtI/gqG4NTrQsBc5UU4AM
         bGyqaOAhWIEF7lYCXEuMaqd9uUWvgafPL32WzhajYp+nbsGt3+3vPQYnT96sxtOmxX4v
         GbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766283; x=1710371083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Imsnr7Qywrt7DVfCHf6eLFwBd+emp2fk38ieA0NsfHg=;
        b=oRaRWIIYxrQbDI1PKwGrJLEwU5hkDcgiP6vAuiO2bOMSbAQfAbrPpFVRw9YpE1vk9G
         fGur6PRVnoWq5nUx98ivD2709bgI/8xeR7I8g9z2GwBkXlI4980ZOJQh+rKiSMsmfarS
         zaNim0+4y0XOJZhFK6BWZ0lDksWdWkDhzQJOeUIKgxWLbBbvaeSLXdYktlOtWLPCbevd
         6+x401kLN/r9UW5vfDbRZslT65Uvm5Bnq1LzznEs4Y6ZZOAXKwjxtJlcRi7ZfymJQIeM
         GZnvQwxiwTy6/plXxRhyZ5NGx2REgIPsXlYZFSc3QtHwo3ZOujcxwfO76x/39qV0KO9Q
         Fu1g==
X-Gm-Message-State: AOJu0Ywx8x0RKYEW5Ukw8tadF1aTapJb8ZF10vAWBhLiKxFzGWNji/Gl
	pvcmM2j2Y2wdjR2d/CrGV7zOAK/09VARiqpZsZc8XrDqg7jIof77rdR7E2f6
X-Google-Smtp-Source: AGHT+IH6dtIDcENGLn3uecHCAzjbHlW28PtDiKJJCCKnRUUhewxM/lD74wWiKsnI5i7LpBeg1Xu2yA==
X-Received: by 2002:a05:6122:790:b0:4c8:8149:848e with SMTP id k16-20020a056122079000b004c88149848emr6860287vkr.5.1709766282484;
        Wed, 06 Mar 2024 15:04:42 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id d9-20020ac5c549000000b004cd7e68c973sm1659592vkl.19.2024.03.06.15.04.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:04:41 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] shared/lc3: Add definitions for Audio Configurations
Date: Wed,  6 Mar 2024 18:04:39 -0500
Message-ID: <20240306230440.3983598-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds defines for Audio Configurations so it can be used for
upcoming tests.
---
 src/shared/lc3.h | 482 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 401 insertions(+), 81 deletions(-)

diff --git a/src/shared/lc3.h b/src/shared/lc3.h
index e0b2cdfc346d..41b29d4d1c8f 100644
--- a/src/shared/lc3.h
+++ b/src/shared/lc3.h
@@ -88,77 +88,200 @@
 			0x02, LC3_CONFIG_DURATION, _duration, \
 			0x03, LC3_CONFIG_FRAME_LEN, _len, _len >> 8)
 
+#define LC3_AC_BITS(_ac) (BIT(_ac) - 1)
+
+#define LC3_CONFIG_AC(_freq, _duration, _len, _ac) \
+	UTIL_IOV_INIT(0x02, LC3_CONFIG_FREQ, _freq, \
+			0x02, LC3_CONFIG_DURATION, _duration, \
+			0x03, LC3_CONFIG_FRAME_LEN, _len, _len >> 8, \
+			0x05, LC3_CONFIG_CHAN_ALLOC, LC3_AC_BITS(_ac), \
+			LC3_AC_BITS(_ac) >> 8 & 0xff, \
+			LC3_AC_BITS(_ac) >> 16 & 0xff, \
+			LC3_AC_BITS(_ac) >> 24 & 0xff)
+
 #define LC3_CONFIG_8(_duration, _len) \
 	LC3_CONFIG(LC3_CONFIG_FREQ_8KHZ, _duration, _len)
 
+#define LC3_CONFIG_8_AC(_duration, _len, _ac) \
+	LC3_CONFIG_AC(LC3_CONFIG_FREQ_8KHZ, _duration, _len, _ac)
+
 #define LC3_CONFIG_11(_duration, _len) \
 	LC3_CONFIG(LC3_CONFIG_FREQ_11KHZ, _duration, _len)
 
+#define LC3_CONFIG_11_AC(_duration, _len, _ac) \
+	LC3_CONFIG_AC(LC3_CONFIG_FREQ_11KHZ, _duration, _len, _ac)
+
 #define LC3_CONFIG_16(_duration, _len) \
 	LC3_CONFIG(LC3_CONFIG_FREQ_16KHZ, _duration, _len)
 
+#define LC3_CONFIG_16_AC(_duration, _len, _ac) \
+	LC3_CONFIG_AC(LC3_CONFIG_FREQ_16KHZ, _duration, _len, _ac)
+
 #define LC3_CONFIG_22(_duration, _len) \
 	LC3_CONFIG(LC3_CONFIG_FREQ_22KHZ, _duration, _len)
 
+#define LC3_CONFIG_22_AC(_duration, _len) \
+	LC3_CONFIG(LC3_CONFIG_FREQ_22KHZ, _duration, _len, _ac)
+
 #define LC3_CONFIG_24(_duration, _len) \
 	LC3_CONFIG(LC3_CONFIG_FREQ_24KHZ, _duration, _len)
 
+#define LC3_CONFIG_24_AC(_duration, _len, _ac) \
+	LC3_CONFIG_AC(LC3_CONFIG_FREQ_24KHZ, _duration, _len, _ac)
+
 #define LC3_CONFIG_32(_duration, _len) \
 	LC3_CONFIG(LC3_CONFIG_FREQ_32KHZ, _duration, _len)
 
+#define LC3_CONFIG_32_AC(_duration, _len, _ac) \
+	LC3_CONFIG_AC(LC3_CONFIG_FREQ_32KHZ, _duration, _len, _ac)
+
 #define LC3_CONFIG_44(_duration, _len) \
 	LC3_CONFIG(LC3_CONFIG_FREQ_44KHZ, _duration, _len)
 
+#define LC3_CONFIG_44_AC(_duration, _len, _ac) \
+	LC3_CONFIG_AC(LC3_CONFIG_FREQ_44KHZ, _duration, _len, _ac)
+
 #define LC3_CONFIG_48(_duration, _len) \
 	LC3_CONFIG(LC3_CONFIG_FREQ_48KHZ, _duration, _len)
 
+#define LC3_CONFIG_48_AC(_duration, _len, _ac) \
+	LC3_CONFIG_AC(LC3_CONFIG_FREQ_48KHZ, _duration, _len, _ac)
+
+#define LC3_CONFIG_FRAME_LEN_8_1 26u
+
 #define LC3_CONFIG_8_1 \
-	LC3_CONFIG_8(LC3_CONFIG_DURATION_7_5, 26u)
+	LC3_CONFIG_8(LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_8_1)
+
+#define LC3_CONFIG_8_1_AC(_ac) \
+	LC3_CONFIG_8_AC(LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_8_1, _ac)
+
+#define LC3_CONFIG_FRAME_LEN_8_2 30u
 
 #define LC3_CONFIG_8_2 \
-	LC3_CONFIG_8(LC3_CONFIG_DURATION_10, 30u)
+	LC3_CONFIG_8(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_8_2 )
+
+#define LC3_CONFIG_8_2_AC(_ac) \
+	LC3_CONFIG_8_AC(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_8_2, _ac)
+
+#define LC3_CONFIG_FRAME_LEN_16_1 30u
 
 #define LC3_CONFIG_16_1 \
-	LC3_CONFIG_16(LC3_CONFIG_DURATION_7_5, 30u)
+	LC3_CONFIG_16(LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_16_1)
+
+#define LC3_CONFIG_16_1_AC(_ac) \
+	LC3_CONFIG_16_AC(LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_16_1, \
+			_ac)
+
+#define LC3_CONFIG_FRAME_LEN_16_2 40u
 
 #define LC3_CONFIG_16_2 \
-	LC3_CONFIG_16(LC3_CONFIG_DURATION_10, 40u)
+	LC3_CONFIG_16(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_16_2)
+
+#define LC3_CONFIG_16_2_AC(_ac) \
+	LC3_CONFIG_16_AC(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_16_2, _ac)
+
+#define LC3_CONFIG_FRAME_LEN_24_1 45u
 
 #define LC3_CONFIG_24_1 \
-	LC3_CONFIG_24(LC3_CONFIG_DURATION_7_5, 45u)
+	LC3_CONFIG_24(LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_24_1)
+
+#define LC3_CONFIG_24_1_AC(_ac) \
+	LC3_CONFIG_24_AC(LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_24_1, \
+			_ac)
+
+#define LC3_CONFIG_FRAME_LEN_24_2 60u
 
 #define LC3_CONFIG_24_2 \
-	LC3_CONFIG_24(LC3_CONFIG_DURATION_10, 60u)
+	LC3_CONFIG_24(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_24_2)
+
+#define LC3_CONFIG_24_2_AC(_ac) \
+	LC3_CONFIG_24_AC(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_24_2, _ac)
+
+#define LC3_CONFIG_FRAME_LEN_32_1 60u
 
 #define LC3_CONFIG_32_1 \
-	LC3_CONFIG_32(LC3_CONFIG_DURATION_7_5, 60u)
+	LC3_CONFIG_32(LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_32_1)
+
+#define LC3_CONFIG_32_1_AC(_ac) \
+	LC3_CONFIG_32_AC(LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_32_1, \
+			_ac)
+
+#define LC3_CONFIG_FRAME_LEN_32_2 80u
 
 #define LC3_CONFIG_32_2 \
-	LC3_CONFIG_32(LC3_CONFIG_DURATION_10, 80u)
+	LC3_CONFIG_32(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_32_2)
+
+#define LC3_CONFIG_32_2_AC(_ac) \
+	LC3_CONFIG_32_AC(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_32_2, _ac)
+
+#define LC3_CONFIG_FRAME_LEN_44_1 98u
 
 #define LC3_CONFIG_44_1 \
-	LC3_CONFIG_44(LC3_CONFIG_DURATION_7_5, 98u)
+	LC3_CONFIG_44(LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_44_1)
+
+#define LC3_CONFIG_44_1_AC(_ac) \
+	LC3_CONFIG_44_AC(LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_44_1, \
+			 _ac)
+
+#define LC3_CONFIG_FRAME_LEN_44_2 130u
 
 #define LC3_CONFIG_44_2 \
-	LC3_CONFIG_44(LC3_CONFIG_DURATION_10, 130u)
+	LC3_CONFIG_44(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_44_2)
+
+#define LC3_CONFIG_44_2_AC(_ac) \
+	LC3_CONFIG_44_AC(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_44_2, _ac)
+
+#define LC3_CONFIG_FRAME_LEN_48_1 75u
 
 #define LC3_CONFIG_48_1 \
-	LC3_CONFIG_48(LC3_CONFIG_DURATION_7_5, 75u)
+	LC3_CONFIG_48(LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_48_1)
+
+#define LC3_CONFIG_48_1_AC(_ac) \
+	LC3_CONFIG_48_AC(LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_48_1, \
+			_ac)
+
+#define LC3_CONFIG_FRAME_LEN_48_2 100u
 
 #define LC3_CONFIG_48_2 \
-	LC3_CONFIG_48(LC3_CONFIG_DURATION_10, 100u)
+	LC3_CONFIG_48(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_48_2)
+
+#define LC3_CONFIG_48_2_AC(_ac) \
+	LC3_CONFIG_48_AC(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_48_2, _ac)
+
+#define LC3_CONFIG_FRAME_LEN_48_3 90u
 
 #define LC3_CONFIG_48_3 \
-	LC3_CONFIG_48(LC3_CONFIG_DURATION_7_5, 90u)
+	LC3_CONFIG_48(LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_48_3)
+
+#define LC3_CONFIG_48_3_AC(_ac) \
+	LC3_CONFIG_48_AC(LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_48_3, \
+			_ac)
+
+#define LC3_CONFIG_FRAME_LEN_48_4 120u
 
 #define LC3_CONFIG_48_4 \
-	LC3_CONFIG_48(LC3_CONFIG_DURATION_10, 120u)
+	LC3_CONFIG_48(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_48_4)
+
+#define LC3_CONFIG_48_4_AC(_ac) \
+	LC3_CONFIG_48_AC(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_48_4, _ac)
+
+#define LC3_CONFIG_FRAME_LEN_48_5 117u
 
 #define LC3_CONFIG_48_5 \
-	LC3_CONFIG_48(LC3_CONFIG_DURATION_7_5, 117u)
+	LC3_CONFIG_48(LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_48_5)
+
+#define LC3_CONFIG_48_5_AC(_ac) \
+	LC3_CONFIG_48_AC(LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_48_5, \
+			_ac)
+
+#define LC3_CONFIG_FRAME_LEN_48_6 155u
 
 #define LC3_CONFIG_48_6 \
-	LC3_CONFIG_48(LC3_CONFIG_DURATION_10, 155u)
+	LC3_CONFIG_48(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_48_6)
+
+#define LC3_CONFIG_48_6_AC(_ac) \
+	LC3_CONFIG_48_AC(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_48_6, \
+			_ac)
 
 #define LC3_QOS_UNFRAMED	0x00
 #define LC3_QOS_FRAMED		0x01
@@ -185,130 +308,327 @@
 #define LC3_QOS_UCAST_FRAMED(_pd, _t_lat, _interval, _lat, _sdu, _rtn) \
 	LC3_QOS_UCAST(LC3_QOS_FRAMED, _pd, _t_lat, _interval, _lat, _sdu, _rtn)
 
-#define LC3_QOS_8_1_1 \
+#define LC3_QOS_8_1_1_LATENCY 8u
+#define LC3_QOS_8_1_1_RTN 2u
+
+#define LC3_QOS_8_1_1_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					8u, 26u, 2u)
+					LC3_QOS_8_1_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_8_1, \
+					LC3_QOS_8_1_1_RTN)
+#define LC3_QOS_8_1_1 LC3_QOS_8_1_1_AC(1)
 
-#define LC3_QOS_8_1_2 \
+#define LC3_QOS_8_1_2_LATENCY 75u
+#define LC3_QOS_8_1_2_RTN 13u
+
+#define LC3_QOS_8_1_2_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					75u, 26u, 13u)
+					LC3_QOS_8_1_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_8_1, \
+					LC3_QOS_8_1_2_RTN)
+#define LC3_QOS_8_1_2 LC3_QOS_8_1_2_AC(1)
 
-#define LC3_QOS_8_2_1 \
+#define LC3_QOS_8_2_1_LATENCY 10u
+#define LC3_QOS_8_2_1_RTN 2u
+
+#define LC3_QOS_8_2_1_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					10u, 30u, 2u)
+					LC3_QOS_8_2_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_8_2, \
+					LC3_QOS_8_2_1_RTN)
+#define LC3_QOS_8_2_1 LC3_QOS_8_2_1_AC(1)
 
-#define LC3_QOS_8_2_2 \
+#define LC3_QOS_8_2_2_LATENCY 95u
+#define LC3_QOS_8_2_2_RTN 13u
+
+#define LC3_QOS_8_2_2_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					95u, 30u, 13u)
+					LC3_QOS_8_2_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_8_2, \
+					LC3_QOS_8_2_2_RTN)
+#define LC3_QOS_8_2_2 LC3_QOS_8_2_2_AC(1)
 
-#define LC3_QOS_16_1_1 \
+#define LC3_QOS_16_1_1_LATENCY 8u
+#define LC3_QOS_16_1_1_RTN 2u
+
+#define LC3_QOS_16_1_1_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					8u, 30u, 2u)
+					LC3_QOS_16_1_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_16_1, \
+					LC3_QOS_16_1_1_RTN)
+#define LC3_QOS_16_1_1 LC3_QOS_16_1_1_AC(1)
 
-#define LC3_QOS_16_1_2 \
+#define LC3_QOS_16_1_2_LATENCY 75u
+#define LC3_QOS_16_1_2_RTN 13u
+
+#define LC3_QOS_16_1_2_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					75u, 30u, 13u)
+					LC3_QOS_16_1_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_16_1, \
+					LC3_QOS_16_1_2_RTN)
+#define LC3_QOS_16_1_2 LC3_QOS_16_1_2_AC(1)
 
-#define LC3_QOS_16_2_1 \
+#define LC3_QOS_16_2_1_LATENCY 10u
+#define LC3_QOS_16_2_1_RTN 2u
+
+#define LC3_QOS_16_2_1_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					10u, 40u, 2u)
+					LC3_QOS_16_2_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_16_2, \
+					LC3_QOS_16_2_1_RTN)
+#define LC3_QOS_16_2_1 LC3_QOS_16_2_1_AC(1)
 
-#define LC3_QOS_16_2_2 \
+#define LC3_QOS_16_2_2_LATENCY 95u
+#define LC3_QOS_16_2_2_RTN 13u
+
+#define LC3_QOS_16_2_2_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					95u, 40u, 13u)
+					LC3_QOS_16_2_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_16_2, \
+					LC3_QOS_16_2_2_RTN)
+#define LC3_QOS_16_2_2 LC3_QOS_16_2_2_AC(1)
 
-#define LC3_QOS_24_1_1 \
+#define LC3_QOS_24_1_1_LATENCY 8u
+#define LC3_QOS_24_1_1_RTN 2u
+
+#define LC3_QOS_24_1_1_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					8u, 45u, 2u)
+					LC3_QOS_24_1_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_24_1, 2u)
+#define LC3_QOS_24_1_1 LC3_QOS_24_1_1_AC(1)
 
-#define LC3_QOS_24_1_2 \
+#define LC3_QOS_24_1_2_LATENCY 75u
+#define LC3_QOS_24_1_2_RTN 13u
+
+#define LC3_QOS_24_1_2_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					75u, 45u, 13u)
+					LC3_QOS_24_1_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_24_1, \
+					LC3_QOS_24_1_2_RTN)
+#define LC3_QOS_24_1_2 LC3_QOS_24_1_2_AC(1)
 
-#define LC3_QOS_24_2_1 \
+#define LC3_QOS_24_2_1_LATENCY 10u
+#define LC3_QOS_24_2_1_RTN 2u
+
+#define LC3_QOS_24_2_1_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					10u, 60u, 2u)
+					LC3_QOS_24_2_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_24_2, \
+					LC3_QOS_24_2_1_RTN)
+#define LC3_QOS_24_2_1 LC3_QOS_24_2_1_AC(1)
 
-#define LC3_QOS_24_2_2 \
+#define LC3_QOS_24_2_2_LATENCY 95u
+#define LC3_QOS_24_2_2_RTN 13u
+
+#define LC3_QOS_24_2_2_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					95u, 60u, 13u)
+					LC3_QOS_24_2_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_24_2, \
+					LC3_QOS_24_2_2_RTN)
+#define LC3_QOS_24_2_2 LC3_QOS_24_2_2_AC(1)
 
-#define LC3_QOS_32_1_1 \
+#define LC3_QOS_32_1_1_LATENCY 8u
+#define LC3_QOS_32_1_1_RTN 2u
+
+#define LC3_QOS_32_1_1_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					8u, 60u, 2u)
+					LC3_QOS_32_1_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_32_1, \
+					LC3_QOS_32_1_1_RTN)
+#define LC3_QOS_32_1_1 LC3_QOS_32_1_1_AC(1)
 
-#define LC3_QOS_32_1_2 \
+#define LC3_QOS_32_1_2_LATENCY 75u
+#define LC3_QOS_32_1_2_RTN 13u
+
+#define LC3_QOS_32_1_2_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					75u, 60u, 13u)
+					LC3_QOS_32_1_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_32_1, \
+					LC3_QOS_32_1_2_RTN)
+#define LC3_QOS_32_1_2 LC3_QOS_32_1_2_AC(1)
 
-#define LC3_QOS_32_2_1 \
+#define LC3_QOS_32_2_1_LATENCY 10u
+#define LC3_QOS_32_2_1_RTN 2u
+
+#define LC3_QOS_32_2_1_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					10u, 80u, 2u)
+					LC3_QOS_32_2_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_32_2, \
+					LC3_QOS_32_2_1_RTN)
+#define LC3_QOS_32_2_1 LC3_QOS_32_2_1_AC(1)
 
-#define LC3_QOS_32_2_2 \
+#define LC3_QOS_32_2_2_LATENCY 95u
+#define LC3_QOS_32_2_2_RTN 13u
+
+#define LC3_QOS_32_2_2_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					95u, 80u, 13u)
+					LC3_QOS_32_2_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_32_2, \
+					LC3_QOS_32_2_2_RTN)
+#define LC3_QOS_32_2_2 LC3_QOS_32_2_2_AC(1)
 
-#define LC3_QOS_44_1_1 \
+#define LC3_QOS_44_1_INTERVAL 8163u
+#define LC3_QOS_44_1_1_LATENCY 24u
+#define LC3_QOS_44_1_1_RTN 5u
+
+#define LC3_QOS_44_1_1_AC(_ac) \
 	LC3_QOS_UCAST_FRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					8163u, 24u, 98u, 5u)
+					LC3_QOS_44_1_INTERVAL, \
+					LC3_QOS_44_1_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_44_1, \
+					LC3_QOS_44_1_1_RTN)
+#define LC3_QOS_44_1_1 LC3_QOS_44_1_1_AC(1)
 
-#define LC3_QOS_44_1_2 \
+#define LC3_QOS_44_1_2_LATENCY 80u
+#define LC3_QOS_44_1_2_RTN 13u
+
+#define LC3_QOS_44_1_2_AC(_ac) \
 	LC3_QOS_UCAST_FRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					8163u, 80u, 98u, 13u)
+					LC3_QOS_44_1_INTERVAL, \
+					LC3_QOS_44_1_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_44_1, \
+					LC3_QOS_44_1_2_RTN)
+#define LC3_QOS_44_1_2 LC3_QOS_44_1_2_AC(1)
 
-#define LC3_QOS_44_2_1 \
+#define LC3_QOS_44_2_INTERVAL 10884u
+#define LC3_QOS_44_2_1_LATENCY 31u
+#define LC3_QOS_44_2_1_RTN 5u
+
+#define LC3_QOS_44_2_1_AC(_ac) \
 	LC3_QOS_UCAST_FRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					10884u, 31u, 130u, 5u)
+					LC3_QOS_44_2_INTERVAL, \
+					LC3_QOS_44_2_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_44_2, \
+					LC3_QOS_44_2_1_RTN)
+#define LC3_QOS_44_2_1 LC3_QOS_44_2_1_AC(1)
 
-#define LC3_QOS_44_2_2 \
+#define LC3_QOS_44_2_2_LATENCY 85u
+#define LC3_QOS_44_2_2_RTN 13u
+
+#define LC3_QOS_44_2_2_AC(_ac) \
 	LC3_QOS_UCAST_FRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					10884u, 85u, 130u, 13u)
+					LC3_QOS_44_2_INTERVAL, \
+					LC3_QOS_44_2_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_44_2, \
+					LC3_QOS_44_2_2_RTN)
+#define LC3_QOS_44_2_2 LC3_QOS_44_2_2_AC(1)
 
-#define LC3_QOS_48_1_1 \
+#define LC3_QOS_48_1_1_LATENCY 15u
+#define LC3_QOS_48_1_1_RTN 5u
+
+#define LC3_QOS_48_1_1_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					15u, 75u, 5u)
+					LC3_QOS_48_1_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_1,\
+					LC3_QOS_48_1_1_RTN)
+#define LC3_QOS_48_1_1 LC3_QOS_48_1_1_AC(1)
 
-#define LC3_QOS_48_1_2 \
+#define LC3_QOS_48_1_2_LATENCY 75u
+#define LC3_QOS_48_1_2_RTN 13u
+
+#define LC3_QOS_48_1_2_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					75u, 75u, 13u)
+					LC3_QOS_48_1_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_1, \
+					LC3_QOS_48_1_2_RTN)
+#define LC3_QOS_48_1_2 LC3_QOS_48_1_2_AC(1)
 
-#define LC3_QOS_48_2_1 \
+#define LC3_QOS_48_2_1_LATENCY 20u
+#define LC3_QOS_48_2_1_RTN 5u
+
+#define LC3_QOS_48_2_1_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					20u, 100u, 5u)
+					LC3_QOS_48_2_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_2, \
+					LC3_QOS_48_2_1_RTN)
+#define LC3_QOS_48_2_1 LC3_QOS_48_2_1_AC(1)
 
-#define LC3_QOS_48_2_2 \
+#define LC3_QOS_48_2_2_LATENCY 95u
+#define LC3_QOS_48_2_2_RTN 13u
+
+#define LC3_QOS_48_2_2_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					95u, 100u, 13u)
+					LC3_QOS_48_2_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_2, \
+					LC3_QOS_48_2_2_RTN)
+#define LC3_QOS_48_2_2 LC3_QOS_48_2_2_AC(1)
 
-#define LC3_QOS_48_3_1 \
+#define LC3_QOS_48_3_1_LATENCY 15u
+#define LC3_QOS_48_3_1_RTN 5u
+
+#define LC3_QOS_48_3_1_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					15u, 90u, 5u)
+					LC3_QOS_48_3_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_3, \
+					LC3_QOS_48_3_1_RTN)
+#define LC3_QOS_48_3_1 LC3_QOS_48_3_1_AC(1)
 
-#define LC3_QOS_48_3_2 \
+#define LC3_QOS_48_3_2_LATENCY 75u
+#define LC3_QOS_48_3_2_RTN 13u
+
+#define LC3_QOS_48_3_2_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					75u, 90u, 13u)
+					LC3_QOS_48_3_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_3, \
+					LC3_QOS_48_3_2_RTN)
+#define LC3_QOS_48_3_2 LC3_QOS_48_3_2_AC(1)
 
-#define LC3_QOS_48_4_1 \
+#define LC3_QOS_48_4_1_LATENCY 20u
+#define LC3_QOS_48_4_1_RTN 5u
+
+#define LC3_QOS_48_4_1_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					20u, 120u, 5u)
+					LC3_QOS_48_4_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_4, \
+					LC3_QOS_48_4_1_RTN)
+#define LC3_QOS_48_4_1 LC3_QOS_48_4_1_AC(1)
 
-#define LC3_QOS_48_4_2 \
+#define LC3_QOS_48_4_2_LATENCY 100u
+#define LC3_QOS_48_4_2_RTN 13u
+
+#define LC3_QOS_48_4_2_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					100u, 120u, 13u)
+					LC3_QOS_48_4_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_4, \
+					LC3_QOS_48_4_2_RTN)
+#define LC3_QOS_48_4_2 LC3_QOS_48_4_2_AC(1)
 
-#define LC3_QOS_48_5_1 \
+#define LC3_QOS_48_5_1_LATENCY 15u
+#define LC3_QOS_48_5_1_RTN 5u
+
+#define LC3_QOS_48_5_1_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					15u, 117u, 5u)
+					LC3_QOS_48_5_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_5, \
+					LC3_QOS_48_5_1_RTN)
+#define LC3_QOS_48_5_1 LC3_QOS_48_5_1_AC(1)
 
-#define LC3_QOS_48_5_2 \
+#define LC3_QOS_48_5_2_LATENCY 75u
+#define LC3_QOS_48_5_2_RTN 13u
+
+#define LC3_QOS_48_5_2_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					75u, 117u, 13u)
+					LC3_QOS_48_5_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_5, \
+					LC3_QOS_48_5_2_RTN)
+#define LC3_QOS_48_5_2 LC3_QOS_48_5_2_AC(1)
 
-#define LC3_QOS_48_6_1 \
-	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					20u, 155u, 5u)
+#define LC3_QOS_48_6_1_LATENCY 20u
+#define LC3_QOS_48_6_1_RTN 5u
 
-#define LC3_QOS_48_6_2 \
+#define LC3_QOS_48_6_1_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
-					100u, 155u, 13u)
+					LC3_QOS_48_6_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_6, \
+					LC3_QOS_48_6_1_RTN)
+#define LC3_QOS_48_6_1 LC3_QOS_48_6_1_AC(1)
+
+#define LC3_QOS_48_6_2_LATENCY 100u
+#define LC3_QOS_48_6_2_RTN 13u
+
+#define LC3_QOS_48_6_2_AC(_ac) \
+	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					LC3_QOS_48_6_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_6, \
+					LC3_QOS_48_6_2_RTN)
+#define LC3_QOS_48_6_2 LC3_QOS_48_6_2_AC(1)
-- 
2.43.0

