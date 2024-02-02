Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7A02FE3F
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706904502; cv=pass; b=tEduiqzcSL9X6AMPjq7upPPNaq7BwQhpYr7XcPFUB9kGTlX8S+fQU7voq5KQbXeC1wr3VT5+o1bqiZIXcL7mFNe3Mx1NFHfILzZ6FDq63T5g/Tk0ArluLzrKBhw6AJEisRmHlSS2xs9d9JYbfUODPMxyJALbVmpQYtHaMasXWUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706904502; c=relaxed/simple;
	bh=ufL2xcktZ2sBjiQIFfHDoB1wXakjq8VkgDtSdvHzh1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KIL+snepFCQPQ2Xdk205FGoF92gpNzlqE9yeAec9HIQ4Okf1Xebg+FfQaa2Yoj907YDN264EmL3AQPF2l1NLZrePZo/EwV+x5FNRDlh1iP8fcDLJaXSUCcOx2jq3mjk3czW4lUCvCjbtieinkG+0XGh7lQ102hddxobJtWKf5WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=KO0ojzkT; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="KO0ojzkT"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TRRfR66mvz49Q3W;
	Fri,  2 Feb 2024 22:08:15 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1706904496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6tC8Yo94cklWEygx41i1WyrGYQfR9pXlXWYeLE1y1v8=;
	b=KO0ojzkTjFzK7o2rKhj2L3EFElVUililXvcWWxuhaWqkfxsr33q2yCmhkQ7jzZkjC0PbUw
	LnYHWdZWhYaVeqZUD4RB9wuX1vx0aUiQxII1V6ar+Nt3Od7aEgXIEdCghTM1GZwjZ8AvYT
	0MhBf7lfFWx3RNjN+KkqDj68cFVyYrFqeHTzl0RpVfWvYUD9FQfTlbyHkjQtVPrw7PZxeX
	QAdjkvzSzMr0ptlArpYTQghNGrx5e1MLD6530lHptoelvot4jIZk7klJ09nezr3Xq+nXFF
	YohJqcSBi857EDGcMovyP6Yh24GnGogiuQmBHU9R2SahNsPQN90IcDw7KAGFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1706904496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6tC8Yo94cklWEygx41i1WyrGYQfR9pXlXWYeLE1y1v8=;
	b=uLNlXahBTZMyrme7BabCjcuOV4zw1/qR2QgoYyn7j7iEIOQnztE4pgHJbIZ4cYbl4CqU/c
	84IL6/Ea9DlvPZd6tc2aicJ4HnUmkm5D6t6qnWXN3vZLieI/WKGAeWzqk+KpusARZZCFvF
	9Y+D5phfhzqzkVLO9Iyj9PaJiFBlzfMcW+IhII0pKiCTdTRXsntt80arFe98QZIVlhDqua
	OUrtEEGhlNl+Hd4zzt07ZufcuYFeCeIffzFNU6AZOAX+feLgM0m3/UcF1G/VlN6evuew5M
	jne3X/T2AMS4Ketjl/0PXtgJ645orTr8kGF+DyYYloP+xLTyQLaaKzUskekAvA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1706904496; a=rsa-sha256;
	cv=none;
	b=HzAOt0FKlB135M1VTSo2hDqaFlbqAQBsCiQfauBy/PA50numE01LNTdiCuzMilNV8voFI2
	wI78jkGlTQzMj2PleICFc7zxdJf+FuBv1cbh36h3KnDiy/zx/HGSi8nJNi3iPgghtWog7d
	5DYZ5ORrAXvueVlLt15PBXHg3K7R3oTBh7oLvc6e/C1kHPtd053kp89FXM8k7AeGvOIC8E
	KMHuJ96LriVEpPJVhECAx1HG+quN8r8PIuVBuNjv4WB6hybwPIZbCFIa28imVfqTxL0JSG
	WBUlUerJnALDAFllKGS2HqJlJ6FMYfHo4St6LRzJOVB5QIM2I/WDG56GnaoReQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] monitor: parse Google's Opus A2DP vendor codec capabilities
Date: Fri,  2 Feb 2024 22:08:09 +0200
Message-ID: <b02d20dd168627b35016dfd0b56beb4a3a8755bd.1706904250.git.pav@iki.fi>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support parsing Opus (Google) A2DP vendor codec capabilities.
---
 monitor/a2dp.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/monitor/a2dp.c b/monitor/a2dp.c
index f6e99ab26..d26b679bc 100644
--- a/monitor/a2dp.c
+++ b/monitor/a2dp.c
@@ -47,6 +47,8 @@
 #define APTX_HD_CODEC_ID	0x0024
 #define LDAC_VENDOR_ID		0x0000012d
 #define LDAC_CODEC_ID		0x00aa
+#define OPUS_G_VENDOR_ID	0x000000e0
+#define OPUS_G_CODEC_ID		0x0001
 
 struct bit_desc {
 	uint8_t bit_num;
@@ -201,6 +203,24 @@ static const struct bit_desc faststream_source_frequency_table[] = {
 	{ }
 };
 
+static const struct bit_desc opus_g_frequency_table[] = {
+	{  7, "48000" },
+	{ }
+};
+
+static const struct bit_desc opus_g_duration_table[] = {
+	{  3, "10 ms" },
+	{  4, "20 ms" },
+	{ }
+};
+
+static const struct bit_desc opus_g_channels_table[] = {
+	{  0, "Mono" },
+	{  1, "Stereo" },
+	{  2, "Dual Mono" },
+	{ }
+};
+
 static void print_value_bits(uint8_t indent, uint32_t value,
 						const struct bit_desc *table)
 {
@@ -244,6 +264,7 @@ static bool codec_vendor_aptx_ll_cfg(uint8_t losc, struct l2cap_frame *frame);
 static bool codec_vendor_aptx_hd_cap(uint8_t losc, struct l2cap_frame *frame);
 static bool codec_vendor_aptx_hd_cfg(uint8_t losc, struct l2cap_frame *frame);
 static bool codec_vendor_ldac(uint8_t losc, struct l2cap_frame *frame);
+static bool codec_vendor_opus_g(uint8_t losc, struct l2cap_frame *frame);
 
 static const struct vndcodec vndcodecs[] = {
 	{ APTX_VENDOR_ID, APTX_CODEC_ID, "aptX",
@@ -256,6 +277,8 @@ static const struct vndcodec vndcodecs[] = {
 	  codec_vendor_aptx_hd_cap, codec_vendor_aptx_hd_cfg },
 	{ LDAC_VENDOR_ID, LDAC_CODEC_ID, "LDAC",
 	  codec_vendor_ldac, codec_vendor_ldac },
+	{ OPUS_G_VENDOR_ID, OPUS_G_CODEC_ID, "Opus (Google)",
+	  codec_vendor_opus_g, codec_vendor_opus_g },
 	{ }
 };
 
@@ -685,6 +708,27 @@ static bool codec_vendor_ldac(uint8_t losc, struct l2cap_frame *frame)
 	return true;
 }
 
+static bool codec_vendor_opus_g(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint8_t cap = 0;
+
+	if (losc != 1)
+		return false;
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cFrequency: 0x%02x", BASE_INDENT + 2, ' ', cap);
+	print_value_bits(BASE_INDENT + 2, cap, opus_g_frequency_table);
+
+	print_field("%*cFrame Duration: 0x%02x", BASE_INDENT + 2, ' ', cap);
+	print_value_bits(BASE_INDENT + 2, cap, opus_g_duration_table);
+
+	print_field("%*cChannel Mode: 0x%02x", BASE_INDENT + 2, ' ', cap);
+	print_value_bits(BASE_INDENT + 2, cap, opus_g_channels_table);
+
+	return true;
+}
+
 static bool codec_vendor_cap(uint8_t losc, struct l2cap_frame *frame)
 {
 	uint32_t vendor_id = 0;
-- 
2.43.0

