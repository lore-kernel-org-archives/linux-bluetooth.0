Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiJcs057"
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C19193
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 11:07:01 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-778999c5ecfso3049385a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 11:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700680019; x=1701284819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ori42QOJjHOoXAlPFmHbnz7X2hMN0jo6XBrSbRRzThg=;
        b=XiJcs057JsCfLo6dBuQZ2RI7Kc58nCDYGEeuGYJV6IYeESdcTih1eKve0EIZu8CHuz
         WpKDLUns19uHQGVxRgR3HT8BFkJTMXu1p1GjrFiRUifHesfR41pE2cCRLcLoFpBeXRkm
         kkJCIWgampTTiO9jyyj8wR54cPgEC+OISlWYLhvDHlM12nrwxVyDSdNVRvMPo3zOlWfO
         OmaZgTf/ZA6Vgz+Hfwn5UGKYlQwUBmMVCEUsFpJaKoZr4EUVU/LEbceri4RbGA73wqWo
         qm13kM5doMdMyHOHHqJvLeMfw8jQIdcHioUoK0Tnb6AvW0VDrQ1kcvBDkqXmBmkQkCa6
         hLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700680019; x=1701284819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ori42QOJjHOoXAlPFmHbnz7X2hMN0jo6XBrSbRRzThg=;
        b=EuAmoRR6Hg64ZEWBUMHNxpzb/VWBfVHpz3v3a6BWUB81toYMKaxIGs44kXMZHgeCxB
         0nfX4BL5te///NjZdUO70749pyp1TwVn5gY3uxwyLQD1euG6cHWpQMqPYPQZyQpXMlJS
         7Q60zUMrnIj3yfafujyCbiTA+DHO7hWzgbde9Clue1Ztzt1QUpdoBnNMkC62NbFzYP/2
         jtBdjHJQCtITpmZJ9Gx4Bdr5koX30nQS9NMBkV8m28Vx6F7tZf/LQrP5dPvtFrg2vJ95
         fvN7QR3Hc1nVYwhTpqh+gCFxr4fZvKjffIiFZqi3KBRgv3DXU9yeA+DrYeneAl9jIIc4
         xdNg==
X-Gm-Message-State: AOJu0YwZydxlAzdXblqbFG1bZzeHz3DABb3PYMxrNzBUV+hghaxqTcoA
	9DNXmIKqYn+3O+CWscJWi2/X+TnfjDH3xq8b
X-Google-Smtp-Source: AGHT+IE5BZpn/bszqWsEHVztF0er9gwlmedW6iepM2nXhLCWBmJuSIU5T3GImGQ9vAh+tNFPWQqwgg==
X-Received: by 2002:a05:620a:268e:b0:77d:6860:c628 with SMTP id c14-20020a05620a268e00b0077d6860c628mr2541273qkp.46.1700680019376;
        Wed, 22 Nov 2023 11:06:59 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id b32-20020a05620a272000b0076d25b11b62sm97885qkp.38.2023.11.22.11.06.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:06:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/5] client/player: Add presets from GMAP
Date: Wed, 22 Nov 2023 14:06:49 -0500
Message-ID: <20231122190649.879386-5-luiz.dentz@gmail.com>
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
32_1_gr_l+r
32_2_gr_l+r
48_1_gr_l+r
48_2_gr_l+r
48_3_gr_l+r
48_4_gr_l+r
---
 client/player.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index 715598aa9405..4a7042412248 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1314,6 +1314,13 @@ static struct codec_preset sbc_presets[] = {
 		   0x02, LC3_CONFIG_DURATION, _duration, \
 		   0x03, LC3_CONFIG_FRAME_LEN, _len, _len >> 8)
 
+#define LC3_PRESET_DATA_ALL(_freq, _duration, _alloc, _len) \
+	CODEC_DATA(0x02, LC3_CONFIG_FREQ, _freq, \
+		   0x02, LC3_CONFIG_DURATION, _duration, \
+		   0x05, LC3_CONFIG_CHAN_ALLOC, _alloc, _alloc >> 8, \
+		   _alloc >> 16, _alloc >> 24, \
+		   0x03, LC3_CONFIG_FRAME_LEN, _len, _len >> 8)
+
 #define LC3_PRESET_8KHZ(_duration, _len) \
 	LC3_PRESET_DATA(LC3_CONFIG_FREQ_8KHZ, _duration, _len)
 
@@ -1332,18 +1339,24 @@ static struct codec_preset sbc_presets[] = {
 #define LC3_PRESET_32KHZ(_duration, _len) \
 	LC3_PRESET_DATA(LC3_CONFIG_FREQ_32KHZ, _duration, _len)
 
+#define LC3_PRESET_32KHZ_ALL(_duration, _len, _alloc) \
+	LC3_PRESET_DATA_ALL(LC3_CONFIG_FREQ_48KHZ, _duration, _alloc, _len)
+
 #define LC3_PRESET_44KHZ(_duration, _len) \
 	LC3_PRESET_DATA(LC3_CONFIG_FREQ_44KHZ, _duration, _len)
 
 #define LC3_PRESET_48KHZ(_duration, _len) \
 	LC3_PRESET_DATA(LC3_CONFIG_FREQ_48KHZ, _duration, _len)
 
+#define LC3_PRESET_48KHZ_ALL(_duration, _len, _alloc) \
+	LC3_PRESET_DATA_ALL(LC3_CONFIG_FREQ_48KHZ, _duration, _alloc, _len)
+
 #define LC3_PRESET_LL(_name, _data, _qos) \
 	{ \
 		.name = _name, \
 		.data = _data, \
 		.qos = _qos, \
-		.latency = 0x01, \
+		.target_latency = 0x01, \
 	}
 
 #define LC3_PRESET(_name, _data, _qos) \
@@ -1461,6 +1474,67 @@ static struct codec_preset lc3_presets[] = {
 	LC3_PRESET_HR("48_6_2",
 			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 155u),
 			LC3_10_UNFRAMED(155u, 13u, 100u, 40000u)),
+	/* QoS configuration support setting requirements for the UGG and UGT */
+	LC3_PRESET_LL("16_1_gs",
+			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_7_5, 30u),
+			LC3_7_5_UNFRAMED(30u, 1u, 15u, 60000u)),
+	LC3_PRESET_LL("16_2_gs",
+			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_10, 40u),
+			LC3_10_UNFRAMED(40u, 1u, 20u, 60000u)),
+	LC3_PRESET_LL("32_1_gs",
+			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_7_5, 60u),
+			LC3_7_5_UNFRAMED(60u, 1u, 15u, 60000u)),
+	LC3_PRESET_LL("32_2_gs",
+			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_10, 80u),
+			LC3_10_UNFRAMED(80u, 1u, 20u, 60000u)),
+	LC3_PRESET_LL("48_1_gs",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 75u),
+			LC3_7_5_UNFRAMED(75u, 1u, 15u, 60000u)),
+	LC3_PRESET_LL("48_2_gs",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 100u),
+			LC3_10_UNFRAMED(100u, 1u, 20u, 60000u)),
+	LC3_PRESET_LL("32_1_gr",
+			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_7_5, 60u),
+			LC3_7_5_UNFRAMED(60u, 1u, 15u, 10000u)),
+	LC3_PRESET_LL("32_2_gr",
+			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_10, 80u),
+			LC3_10_UNFRAMED(80u, 1u, 20u, 10000u)),
+	LC3_PRESET_LL("48_1_gr",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 75u),
+			LC3_7_5_UNFRAMED(75u, 1u, 15u, 10000u)),
+	LC3_PRESET_LL("48_2_gr",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 100u),
+			LC3_10_UNFRAMED(100u, 1u, 20u, 10000u)),
+	LC3_PRESET_LL("48_3_gr",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 90u),
+			LC3_7_5_UNFRAMED(90u, 1u, 15u, 10000u)),
+	LC3_PRESET_LL("48_4_gr",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 120u),
+			LC3_10_UNFRAMED(120u, 1u, 20u, 10000u)),
+	LC3_PRESET_LL("32_1_gr_l+r",
+			LC3_PRESET_32KHZ_ALL(LC3_CONFIG_DURATION_7_5, 60u,
+						0x00000003),
+			LC3_7_5_UNFRAMED(2 * 60u, 1u, 15u, 10000u)),
+	LC3_PRESET_LL("32_2_gr_l+r",
+			LC3_PRESET_32KHZ_ALL(LC3_CONFIG_DURATION_10, 80u,
+						0x00000003),
+			LC3_10_UNFRAMED(2 * 80u, 1u, 20u, 10000u)),
+	LC3_PRESET_LL("48_1_gr_l+r",
+			LC3_PRESET_48KHZ_ALL(LC3_CONFIG_DURATION_7_5, 75u,
+						0x00000003),
+			LC3_7_5_UNFRAMED(2* 75u, 1u, 15u, 10000u)),
+	LC3_PRESET_LL("48_2_gr_l+r",
+			LC3_PRESET_48KHZ_ALL(LC3_CONFIG_DURATION_10, 100u,
+						0x00000003),
+			LC3_10_UNFRAMED(2* 100u, 1u, 20u, 10000u)),
+	LC3_PRESET_LL("48_3_gr_l+r",
+			LC3_PRESET_48KHZ_ALL(LC3_CONFIG_DURATION_7_5, 90u,
+						0x00000003),
+			LC3_7_5_UNFRAMED(2 * 90u, 1u, 15u, 10000u)),
+	LC3_PRESET_LL("48_4_gr_l+r",
+			LC3_PRESET_48KHZ_ALL(LC3_CONFIG_DURATION_10, 120u,
+						0x00000003),
+			LC3_10_UNFRAMED(2 * 120u, 1u, 20u, 10000u)),
 };
 
 static void print_ltv(const char *str, void *user_data)
-- 
2.42.0

