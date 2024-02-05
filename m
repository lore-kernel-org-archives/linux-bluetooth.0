Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3BA3FE44
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Feb 2024 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152609; cv=pass; b=DV/SXSPaDOjBwQruVDwvwHgBFGoLA2clKwafv27EmNFZr8uCIywdcSrQStvLS7HJUl00qeDlPyNrg1aXFPIxWQ/yX7cS/375WdeAjspENe5dDztd+YcMUrYVKk3IwtYXLOEhYSyDnaaIsMCpDURVThbyo9ETWxXl3is3GJBa7jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152609; c=relaxed/simple;
	bh=uFDtGSZRql9Thhh1IYzgZeOc4zMuBZoMz+qPWwGzgxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EECEU3AP9mU/Ll1InMILbqHSj30+ZLZ1PlMk71d44NIl21+jBu3ITpsD5ChKSBHMGE6UXUCLYXWDxcI9Uwzf55JUM1h5qKnR+BwfZqevtLYx0zPNYQ2c3gVnW1x8A1kUDBI/rdrSqULarIXHtfNJyUXHWRhWKkevdXyYFvB9rt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=FlOtkn7P; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="FlOtkn7P"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TTCPl0Z94z49Q2f;
	Mon,  5 Feb 2024 19:03:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1707152604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zShLttf7eREGYIGkYVJagwktj2Lunjtcq1Iw/LRIUCU=;
	b=FlOtkn7PbbFRUQ2NwUUo6Vv6QHEonP+1olvEi0Uyzxos8CMLPczWcQhY/ds5AR77jial08
	s4w9fjy48IxF67m5+7QpZXcyNJ9lbJaSuWuzv17afMIgMWB+oH+lIwHW+MdFM55DVM7Cod
	JFtEF2cXOOp8B4G7Zz8MX+KYcn9Mx6iOJwL2vLY2znExK+6f/8pthiNsKqyxGHExP2lpEn
	XeikphKjtpW8rZhbE7CdSo1hJf7ZnRXPwJ7mN1SbfEbpyDX8iOBaBMTYYpf8/z0SNJtFdE
	/LkNE/8hAPvT/ZOuU27DMtLBNe7OoSfwScpikZv+TjPhoV/8Fu+lPfVwgU60hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1707152604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zShLttf7eREGYIGkYVJagwktj2Lunjtcq1Iw/LRIUCU=;
	b=cEGhqUwP6MKqmUDeriifCxFy9ZTSQTunKT2W1Tgr6On/jmnBQnoKwbGTEgirgukuqXJh89
	Ucyb/mqPx6ViiVxq/Oyp4rGGr+BBQAO26SRBwxcMEsQkg4974BWx7VlBqJzarBltWpGlxn
	qeX1qnEvUdh1n6VYNThEsLk+WClXrPw5ZC1wdZvdB3BcTGdcZkSF5u9uoqys8kVFuLHJcK
	IXBgXzIzLeboJruVuknHZhU7N/ZtdWEFGxh7mAnt4J5T/GRcKX/1btfwo3NQscOrqgwHgn
	Kwgle7eBtiLwTUxvlMMfHOrZOVv05YgJNzGozw9095DasWFQf7otP+RfCAVT+Q==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1707152604; a=rsa-sha256;
	cv=none;
	b=bBu/h+rt179FO3EnTwYjoW11+MqtTPj4naCO5vGPQ37z7t/We7fXH0sjsSoYKd7JURRyB4
	dtjULSX27iV6fmvkqMJNfku9Zs3MCWQWFmEtBwceUAwvrbjMENhq/aAQF3zHUxRu6GeHT4
	AARBob1E6p9I4DKTisDS3aF+76LLzzj5iITccTxqUgV9k7haxe+H1uYs0onEQaQQIBrIVF
	yR0GRD+ikJeYn92GyRqeQkJSiCO/kYSmdMeRAxzxfph29yZsTBizeWtrpVVdErsYFtNk2o
	dQnr2AeIQb7u0udHqchytve2JqfcqMFVt57VjgqSkSlH0ezAyUPLeEtUOr3LSw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/2] monitor: parse Google's Opus A2DP vendor codec capabilities
Date: Mon,  5 Feb 2024 19:03:16 +0200
Message-ID: <5ae678a1c4353818744a6bff31b21055371d2592.1707152569.git.pav@iki.fi>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support parsing Opus (Google) A2DP vendor codec capabilities.
AOSP & Google Pixel Buds Pro has this implemented.

> ACL Data RX: Handle 256 flags 0x02 dlen 21       #419 [hci0] 26.905032
      Channel: 65 len 17 [PSM 25 mode Basic (0x00)] {chan 4}
      AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label 3 nosp 0
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: Non-A2DP (0xff)
            Vendor ID: Google (0x000000e0)
            Vendor Specific Codec ID: Opus (Google) (0x0001)
              Frequency: 0x80
                48000
              Frame Duration: 0x18
                10 ms
                20 ms
              Channel Mode: 0x07
                Mono
                Stereo
                Dual Mono
              Reserved: 0x60
        Service Category: Delay Reporting (0x08)
---

Notes:
    As far as I know, Opus is in no Bluetooth standard, only vendor codec.

 monitor/a2dp.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/monitor/a2dp.c b/monitor/a2dp.c
index f6e99ab26..ae88f565e 100644
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
 
@@ -685,6 +708,31 @@ static bool codec_vendor_ldac(uint8_t losc, struct l2cap_frame *frame)
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
+	print_field("%*cFrequency: 0x%02x", BASE_INDENT + 2, ' ', cap & 0x80);
+	print_value_bits(BASE_INDENT + 2, cap, opus_g_frequency_table);
+
+	print_field("%*cFrame Duration: 0x%02x", BASE_INDENT + 2, ' ',
+								cap & 0x18);
+	print_value_bits(BASE_INDENT + 2, cap, opus_g_duration_table);
+
+	print_field("%*cChannel Mode: 0x%02x", BASE_INDENT + 2, ' ',
+								cap & 0x07);
+	print_value_bits(BASE_INDENT + 2, cap, opus_g_channels_table);
+
+	print_field("%*cReserved: 0x%02x", BASE_INDENT + 2, ' ', cap & 0x60);
+
+	return true;
+}
+
 static bool codec_vendor_cap(uint8_t losc, struct l2cap_frame *frame)
 {
 	uint32_t vendor_id = 0;
-- 
2.43.0

