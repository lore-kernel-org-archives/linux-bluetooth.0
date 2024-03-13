Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE58523C
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342765; cv=none; b=lqJG9bFsUxedrFnkvS1EUeM5bUU8sac+TRNvabQD3k9CFpvP2sdlmuCMlKfJwMf+xQV+t5sYHe2BwnL60K5CjrbM4V1M3mUXVeLTll3BmDoAgv+CCxO2nGwIbPv2jaH6A46HpSCAHVZ/ZGwlvNpFa8BM5mpRbS03e0ZsKiAGbdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342765; c=relaxed/simple;
	bh=e4+PHqDauya9n2dspmku/9IFy3579jWCY4iOuSZnHjA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ow2MSoKVfFwCgFdzmaNP3iHM16SxyMVe+VWcQYvV4hCfFjmezdqM2c3Dg2ZBxi1cshw3wEGVzyzIyjwPB7ftgjGHx7bizqn3wzSFxm0Gsp964Urb9g8/iWsLvkgmkgz+/aM+p7wFQbN+wQKiRcq+wXtdlOFqhw3rSkyJeP1uth4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgQFTTnO; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgQFTTnO"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7dba7098dd8so2837183241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710342760; x=1710947560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lCfHqTTsLIjf6PahHwoSB6au2rlpK/wHDjPqDhpqcc4=;
        b=RgQFTTnOIfYoGhAgCmUmvSYsdzTDXRUOLqt3PFmPqawZpuZ+xFIROxb/esFnZZLhZo
         MHb9fclfTrEK+mpazTUwlgh24v2kuYZlAIkO+0VYFLEsfuxpG4ayjbj/OsSTP5wnPqDp
         C4CIawJseMWxNz2E899gLkZN0ixQpMqMfB0YC/s6HZaFbyr3+RLzV7t1+zsBZP7ACIbo
         PWXFSrSFoFpmNFe/j3B8TcYzCJItVWLbNABdHs42bJ33c7vV8f+7jYpVTu0gzPb8M9k4
         oSWvoWUsX2e1EckNxnig8oY0TbLPKsjKeyeqOiz+Fh55I+4J64IflNXenkaQ3sPMRS6R
         yCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710342760; x=1710947560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCfHqTTsLIjf6PahHwoSB6au2rlpK/wHDjPqDhpqcc4=;
        b=gWZltBKpFEfIwE+e6HdweMz0WrKmbNzzn8ycF9dY6e/EuJEdYp1ea/ptDMs9tOB2P4
         TKKNqeSAWB4I+txHua/3ktvutK0y0vafg83AHyU58vC7QORKZ3c51aykJ4sALqzCmmRP
         0rAJCaoxWSt3bGeHb3nAmLkq1RndE08cpqgQrkEQH5C4YB5RoLHGrXfZoW6P8L5XI3nf
         fMeaM/oVlXcrmb/+G/MOIM9MbxAKSVCSNaznn+t3wpptjh/bMu6GmidvoijLfWLtlIeb
         ghEXBiJhOO3L34Q3yRylvU5HmOJqjJ6/rezp+HUe055X4NBMHSqisF1a/KifBUTZsV+k
         ueUQ==
X-Gm-Message-State: AOJu0YzO93ry2g/AReUEbzICXI+uX7D8py8yqQquesjltoLjMtXsQGbH
	NoPAY8IlCkFKbdsL+Ob6tjL3vd/IcwTvP31whtTa6uzh+E6ED+YX3hMn/DNW
X-Google-Smtp-Source: AGHT+IEENkYDojDeejNPUenNSAtbiUEst2TWdpL5+SOO324iyHN1wujvbmY9mqnx7sygqnrsk7GABg==
X-Received: by 2002:a05:6102:441a:b0:474:cb65:d400 with SMTP id df26-20020a056102441a00b00474cb65d400mr157917vsb.24.1710342760407;
        Wed, 13 Mar 2024 08:12:40 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id j27-20020a0561023e1b00b0046d5dbea599sm1759452vsv.6.2024.03.13.08.12.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 08:12:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/4] client/player: Split unicast and broadcast presets
Date: Wed, 13 Mar 2024 11:12:35 -0400
Message-ID: <20240313151238.1294526-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Although their name matches unicast and broadcast are not actually the
same when it comes to RTN and Max Latency, so this splits their settings
into 2 presets tables and fix the values for broadcast.
---
 client/player.c | 115 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 110 insertions(+), 5 deletions(-)

diff --git a/client/player.c b/client/player.c
index a40bf66e3967..cb771447bf4b 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1403,7 +1403,7 @@ static struct codec_preset sbc_presets[] = {
 		.target_latency = 0x03, \
 	}
 
-static struct codec_preset lc3_presets[] = {
+static struct codec_preset lc3_ucast_presets[] = {
 	/* Table 4.43: QoS configuration support setting requirements */
 	LC3_PRESET("8_1_1",
 			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_7_5, 26u),
@@ -1565,6 +1565,111 @@ static struct codec_preset lc3_presets[] = {
 			LC3_10_UNFRAMED(2 * 120u, 1u, 20u, 10000u)),
 };
 
+static struct codec_preset lc3_bcast_presets[] = {
+	/* Table 6.4: Broadcast Audio Stream configuration support requirements
+	 * for the Broadcast Source and Broadcast Sink
+	 */
+	LC3_PRESET("8_1_1",
+			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_7_5, 26u),
+			LC3_7_5_UNFRAMED(26u, 2u, 8u, 40000u)),
+	LC3_PRESET("8_2_1",
+			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_10, 30u),
+			LC3_10_UNFRAMED(30u, 2u, 10u, 40000u)),
+	LC3_PRESET("16_1_1",
+			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_7_5, 30u),
+			LC3_7_5_UNFRAMED(30u, 2u, 8u, 40000u)),
+	LC3_PRESET("16_2_1",
+			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_10, 40u),
+			LC3_10_UNFRAMED(40u, 2u, 10u, 40000u)),
+	LC3_PRESET("24_1_1",
+			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_7_5, 45u),
+			LC3_7_5_UNFRAMED(45u, 2u, 8u, 40000u)),
+	LC3_PRESET("24_2_1",
+			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_10, 60u),
+			LC3_10_UNFRAMED(60u, 2u, 10u, 40000u)),
+	LC3_PRESET("32_1_1",
+			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_7_5, 60u),
+			LC3_7_5_UNFRAMED(60u, 2u, 8u, 40000u)),
+	LC3_PRESET("32_2_1",
+			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_10, 80u),
+			LC3_10_UNFRAMED(80u, 2u, 10u, 40000u)),
+	LC3_PRESET("44_1_1",
+			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_7_5, 98u),
+			QOS_FRAMED_2M(8163u, 98u, 4u, 24u, 40000u)),
+	LC3_PRESET("44_2_1",
+			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_10, 130u),
+			QOS_FRAMED_2M(10884u, 130u, 4u, 31u, 40000u)),
+	LC3_PRESET("48_1_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 75u),
+			LC3_7_5_UNFRAMED(75u, 4u, 15u, 40000u)),
+	LC3_PRESET("48_2_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 100u),
+			LC3_10_UNFRAMED(100u, 4u, 20u, 40000u)),
+	LC3_PRESET("48_3_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 90u),
+			LC3_7_5_UNFRAMED(90u, 4u, 15u, 40000u)),
+	LC3_PRESET("48_4_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 120u),
+			LC3_10_UNFRAMED(120u, 4u, 20u, 40000u)),
+	LC3_PRESET("48_5_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 117u),
+			LC3_7_5_UNFRAMED(117u, 4u, 15u, 40000u)),
+	LC3_PRESET("48_6_1",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 155u),
+			LC3_10_UNFRAMED(155u, 4u, 20u, 40000u)),
+	/* Broadcast Audio Stream configuration settings for high-reliability
+	 * audio data.
+	 */
+	LC3_PRESET_HR("8_1_2",
+			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_7_5, 26u),
+			LC3_7_5_UNFRAMED(26u, 4u, 45u, 40000u)),
+	LC3_PRESET_HR("8_2_2",
+			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_10, 30u),
+			LC3_10_UNFRAMED(30u, 4u, 60u, 40000u)),
+	LC3_PRESET_HR("16_1_2",
+			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_7_5, 30u),
+			LC3_7_5_UNFRAMED(30u, 4u, 45u, 40000u)),
+	LC3_PRESET_HR("16_2_2",
+			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_10, 40u),
+			LC3_10_UNFRAMED(40u, 4u, 60u, 40000u)),
+	LC3_PRESET_HR("24_1_2",
+			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_7_5, 45u),
+			LC3_7_5_UNFRAMED(45u, 4u, 45u, 40000u)),
+	LC3_PRESET_HR("24_2_2",
+			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_10, 60u),
+			LC3_10_UNFRAMED(60u, 4u, 60u, 40000u)),
+	LC3_PRESET_HR("32_1_2",
+			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_7_5, 60u),
+			LC3_7_5_UNFRAMED(60u, 4u, 45u, 40000u)),
+	LC3_PRESET_HR("32_2_2",
+			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_10, 80u),
+			LC3_10_UNFRAMED(80u, 4u, 60u, 40000u)),
+	LC3_PRESET_HR("44_1_2",
+			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_7_5, 98u),
+			QOS_FRAMED_2M(8163u, 4u, 13u, 54u, 40000u)),
+	LC3_PRESET_HR("44_2_2",
+			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_10, 130u),
+			QOS_FRAMED_2M(10884u, 130u, 4u, 60u, 40000u)),
+	LC3_PRESET_HR("48_1_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 75u),
+			LC3_7_5_UNFRAMED(75u, 4u, 50u, 40000u)),
+	LC3_PRESET_HR("48_2_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 100u),
+			LC3_10_UNFRAMED(100u, 4u, 65u, 40000u)),
+	LC3_PRESET_HR("48_3_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 90u),
+			LC3_7_5_UNFRAMED(90u, 4u, 50u, 40000u)),
+	LC3_PRESET_HR("48_4_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 120u),
+			LC3_10_UNFRAMED(120u, 4u, 65u, 40000u)),
+	LC3_PRESET_HR("48_5_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 117u),
+			LC3_7_5_UNFRAMED(117u, 4u, 50u, 40000u)),
+	LC3_PRESET_HR("48_6_2",
+			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 155u),
+			LC3_10_UNFRAMED(155u, 4u, 65u, 40000u)),
+};
+
 static void print_ltv(const char *str, void *user_data)
 {
 	const char *label = user_data;
@@ -1615,10 +1720,10 @@ static struct preset {
 } presets[] = {
 	PRESET(A2DP_SOURCE_UUID, A2DP_CODEC_SBC, sbc_presets, 6),
 	PRESET(A2DP_SINK_UUID, A2DP_CODEC_SBC, sbc_presets, 6),
-	PRESET(PAC_SINK_UUID, LC3_ID, lc3_presets, 3),
-	PRESET(PAC_SOURCE_UUID, LC3_ID, lc3_presets, 3),
-	PRESET(BCAA_SERVICE_UUID,  LC3_ID, lc3_presets, 3),
-	PRESET(BAA_SERVICE_UUID,  LC3_ID, lc3_presets, 3),
+	PRESET(PAC_SINK_UUID, LC3_ID, lc3_ucast_presets, 3),
+	PRESET(PAC_SOURCE_UUID, LC3_ID, lc3_ucast_presets, 3),
+	PRESET(BCAA_SERVICE_UUID,  LC3_ID, lc3_bcast_presets, 3),
+	PRESET(BAA_SERVICE_UUID,  LC3_ID, lc3_bcast_presets, 3),
 };
 
 static void parse_vendor_codec(const char *codec, uint16_t *vid, uint16_t *cid)
-- 
2.43.0

