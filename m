Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J447ar/k"
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7165493
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 11:06:57 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77a453eb01cso4595485a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 11:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700680016; x=1701284816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qi3K7VQyUWa0lVFxz42Xy5Na8CHjuAIK7BaAEzLEHTA=;
        b=J447ar/k61C+dwEYjj/vGXcjbOoDE6jCgYRVpktWC3iJUzvODFHqdvykU2RW2gQ9aT
         aGsAwaWUNyyn3wgPx+TC2K9bcsee81s3pCkAeLMUue4Vj0yrPsx+HaPQSlu82byQD2jR
         uqMDV7EFCKmFircJKcBSvz8akAExsGhs5kyzkz6EIRLOYPCdf2wJMHWsEQUTF7dK3yUk
         KMPsQKxh2wX0a74U4NsbzERNJIWJ8Mwdn56vp8fi6ChzZdkg9IX5c14t0jLJL+x+wtRL
         ikcAY2u8yBRHnFJMnXEeoSb7wEwMj8vBW87wHRbbsjTG/lkc6N2Bn+DuJ7lfqAobrdBz
         RLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700680016; x=1701284816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qi3K7VQyUWa0lVFxz42Xy5Na8CHjuAIK7BaAEzLEHTA=;
        b=VHnwEGGNFfNw7PoK+m1RxqAAFB9MmS8afIbMjGic0OtQ/5nv0r0galQ3Gl4KExzWu3
         0+bdDBxK9fuY/sq1k2cQwlVRYyTFLegTViPSmpnYr/aKbVqdEN5RYTgGHZ33PH1tKzcc
         1oDgvzFrhU1egTN/aj2bBz04o798qRThABikEhM5bbwafPKDOa7RAW7tU011fONnoU8q
         6fPMIR4Ip/IizFrWOGrtMLrRNRQwoy3JmSLBGbku1n9ktai8O9tV5sEhNN2V9lp2XaUW
         +yvAEZ0wDAhZoZWfFkhdp/x9JemQW1gRn3+VL5vMG1qbt7OSYyLEkPkZIgJKxTspaEzD
         lqjQ==
X-Gm-Message-State: AOJu0YwBFyxDfA7GrkrF7LPVOdcPQQyIQAQZ6E4h+C4wYoQDG5ZprrZp
	qkU43uX5Lhu55tM4FlKLgfGrS/BA0GL+OSrI
X-Google-Smtp-Source: AGHT+IEgcDwq3GJLAOco0amDPb10U9rhxbo8KA6tR8ec6ahZQOOUtzFnItQElqHOAdxzvxRrJU+tEg==
X-Received: by 2002:a37:e10d:0:b0:773:be2d:7cd2 with SMTP id c13-20020a37e10d000000b00773be2d7cd2mr2942634qkm.45.1700680015693;
        Wed, 22 Nov 2023 11:06:55 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id b32-20020a05620a272000b0076d25b11b62sm97885qkp.38.2023.11.22.11.06.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:06:54 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/5] iso-tester: Add presets from GMAP
Date: Wed, 22 Nov 2023 14:06:47 -0500
Message-ID: <20231122190649.879386-3-luiz.dentz@gmail.com>
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

ISO QoS 48_1_gc - Success                            Passed
ISO QoS 48_2_gc - Success                            Passed
ISO QoS 48_1_gr - Success                            Passed
ISO QoS 48_2_gr - Success                            Passed
ISO QoS 48_3_gr - Success                            Passed
ISO QoS 48_4_gr - Success                            Passed
---
 tools/iso-tester.c | 109 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 9fccbaa809e4..4d47373e3290 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -154,6 +154,19 @@
 #define QOS_48_4_2 QOS_OUT(10000, 100, 120, 0x02, 13)
 #define QOS_48_5_2 QOS_OUT(7500, 75, 117, 0x02, 13)
 #define QOS_48_6_2 QOS_OUT(10000, 100, 155, 0x02, 13)
+/* QoS configuration support setting requirements for the UGG and UGT */
+#define QOS_16_1_gs QOS(7500, 15, 30, 0x02, 1)
+#define QOS_16_2_gs QOS(10000, 20, 40, 0x02, 1)
+#define QOS_32_1_gs QOS(7500, 15, 60, 0x02, 1)
+#define QOS_32_2_gs QOS(10000, 20, 80, 0x02, 1)
+#define QOS_48_1_gs QOS(7500, 15, 75, 0x02, 1)
+#define QOS_48_2_gs QOS(10000, 20, 100, 0x02, 1)
+#define QOS_32_1_gr QOS(7500, 15, 60, 0x02, 1)
+#define QOS_32_2_gr QOS(10000, 20, 80, 0x02, 1)
+#define QOS_48_1_gr QOS(7500, 15, 75, 0x02, 1)
+#define QOS_48_2_gr QOS(10000, 20, 100, 0x02, 1)
+#define QOS_48_3_gr QOS(7500, 15, 90, 0x02, 1)
+#define QOS_48_4_gr QOS(10000, 20, 120, 0x02, 1)
 
 /* One unidirectional CIS. Unicast Server is Audio Sink */
 #define AC_1_4 QOS_OUT(10000, 10, 40, 0x02, 2)
@@ -810,6 +823,66 @@ static const struct iso_client_data connect_48_6_2 = {
 	.expect_err = 0
 };
 
+static const struct iso_client_data connect_16_1_gs = {
+	.qos = QOS_16_1_gs,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_16_2_gs = {
+	.qos = QOS_16_2_gs,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_32_1_gs = {
+	.qos = QOS_32_1_gs,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_32_2_gs = {
+	.qos = QOS_32_2_gs,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_48_1_gs = {
+	.qos = QOS_48_1_gs,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_48_2_gs = {
+	.qos = QOS_48_2_gs,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_32_1_gr = {
+	.qos = QOS_32_1_gr,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_32_2_gr = {
+	.qos = QOS_32_2_gr,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_48_1_gr = {
+	.qos = QOS_48_1_gr,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_48_2_gr = {
+	.qos = QOS_48_2_gr,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_48_3_gr = {
+	.qos = QOS_48_3_gr,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_48_4_gr = {
+	.qos = QOS_48_4_gr,
+	.expect_err = 0
+};
+
 static const struct iso_client_data connect_invalid = {
 	.qos = QOS(0, 0, 0, 0, 0),
 	.expect_err = -EINVAL
@@ -2945,6 +3018,42 @@ int main(int argc, char *argv[])
 	test_iso("ISO QoS 48_6_2 - Success", &connect_48_6_2, setup_powered,
 							test_connect);
 
+	test_iso("ISO QoS 16_1_gs - Success", &connect_16_1_gs, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 16_2_gs - Success", &connect_16_2_gs, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 32_1_gs - Success", &connect_32_1_gs, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 32_2_gs - Success", &connect_32_2_gs, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 48_1_gs - Success", &connect_48_1_gs, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 48_2_gs - Success", &connect_48_2_gs, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 32_1_gr - Success", &connect_32_1_gr, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 32_2_gr - Success", &connect_32_2_gr, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 48_1_gr - Success", &connect_48_1_gr, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 48_2_gr - Success", &connect_48_2_gr, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 48_3_gr - Success", &connect_48_3_gr, setup_powered,
+							test_connect);
+
+	test_iso("ISO QoS 48_4_gr - Success", &connect_48_4_gr, setup_powered,
+							test_connect);
+
 	test_iso("ISO QoS - Invalid", &connect_invalid, setup_powered,
 							test_connect);
 
-- 
2.42.0

