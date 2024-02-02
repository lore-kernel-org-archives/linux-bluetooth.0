Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556E180601
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706904503; cv=pass; b=qSiMlGroLHhlZJ9+Uz4u4fYwQTmsWi+2aQe81Gx/oLgwI2rhVoPPcskFOZWM9rKfgzVFPh8qmfGPbSZwyi7RM5tF4uT+1Sxm6yK+r+qVP3lQSwccD6IRiDzUrUDOhi0Q9iYqVm5QvAejyaUrFSqbayhobLqa1HXxXni0kZT9yYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706904503; c=relaxed/simple;
	bh=8wJUgFVh6LLVPGOyunAjyYwlNwl7TeFN+Fd3v6HBIKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjgisZRledqtptO8zwz7dGZecdHCbPu89jJphmdvw0KlqwfUF3FmHuqsti8GhXiYzMJPlzHpu3VbEqy7RMM6ElYg1fhT9T8A/o5YChP8y7ficIS25mHfEZnA2qJEkV9CvwYHRy5bvHQp5YHI8MNcwDEp2sfP5KOlha6ozySreqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=mthrtB8L; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="mthrtB8L"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TRRfT5N8hz49Q4X;
	Fri,  2 Feb 2024 22:08:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1706904498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qoh43Sp74ERzu3FoC0AyO7VlNjyGxJc28yXUnjca6Jk=;
	b=mthrtB8LDcEmwZVck9dvIEyZBYm+96yxUGOC+AZhYywo8QvnDWGKIF671irG9KMSlNGYvQ
	cqV2lBTwk0dif2voQcHVKE9K9JkHAJ3E0QZpj6gxw/1O+bN17VREcrs3EjKwc1PXvwSAkZ
	p4xcjSD5cou29C6k03gY+ybRZw6+eOxf6r+iHASs2A0LXWUtGNeghm8C2N4sLK3nwcBd78
	yZsgKlHKvcBlFcVjU9detE7ufi5KcQjSAVwxp53SfWyw+LRWwnIT+qgTOCx/dqTC7sRaO8
	NPRDrWy47fg++N9FLwl5c/K39UJ4WuMuE1DjEkDETemOXP2/UINGCa6a+VgDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1706904498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qoh43Sp74ERzu3FoC0AyO7VlNjyGxJc28yXUnjca6Jk=;
	b=pmaN9oqseIZTrFt7x5ihT90hNScXgw0bdIxlEuqLXQ3PP+rcOKC9nshYzv56yL38vWayGe
	476zs7rrxLUqLw3VrIN6MDFcRoQC3da9qZ3SzVsO6mTw1/STQu/1/ITJPZgIzwq5W0R26I
	57sU/wBFa4nJV7mxQByBqRfnDkE/svD8IwrJ6CohhG5qgURGyR/bt8IQtOmgdIkW+R09hc
	jIQ4EFkJ4294JX+KeIZSQlB2EHc0LtM3D1/187FNRgH+X7OtRVpjXvIyGtAAQwOrKa0SqX
	KUmURbWLC/u3Jf2PWCpgHLh/DkIE6qN3pGtqA58t0EMGInhFetes/HGjmqNHTg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1706904498; a=rsa-sha256;
	cv=none;
	b=a0UxoNPU7jR3J2Lld+N/tJgwXLiuiL59juNWYHcw1IwJtzibD0269CznW90KaTMsNvqQL4
	gA2VgUPw3vXtJubZjPEMEvDPLyRJXQAVSgNjfT7uIUX8KCU/+ojkRQLEW8V2jxGXxENJ0M
	HqQC2wxG2GkNr368nULTFfTU7M64dEr3MnRQWbnmRhZfLtSQvB7BJJIUEUHmSRQWapTwdf
	1GG4N33a4Hu5sczj7x9KAHd/R7zcIDyMYf0zuWvT7ZbclfQ+hUKdj2Bk3bsC/ht1eUN2+e
	vlftEnBnqKnHnEAuYeURoPbeR8AR6kbNEm+Yu3O0S7EEson9UFl5u0x9KnxSzw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] client/player: parse Google's Opus A2DP vendor codec capabilities
Date: Fri,  2 Feb 2024 22:08:10 +0200
Message-ID: <64ff76d1729e61b236fad667973f5f4d8f1268f3.1706904250.git.pav@iki.fi>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b02d20dd168627b35016dfd0b56beb4a3a8755bd.1706904250.git.pav@iki.fi>
References: <b02d20dd168627b35016dfd0b56beb4a3a8755bd.1706904250.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support parsing Opus (Google) A2DP vendor codec capabilities.
---
 client/player.c              | 32 ++++++++++++++++++++++++++++++++
 profiles/audio/a2dp-codecs.h | 17 +++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/client/player.c b/client/player.c
index 623519209..10a3d3f18 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2462,6 +2462,36 @@ static void print_ldac(a2dp_ldac_t *ldac, uint8_t size)
 	bt_shell_printf("\n");
 }
 
+static void print_opus_g(a2dp_opus_g_t *opus, uint8_t size)
+{
+	bt_shell_printf("\t\tVendor Specific Value (Opus [Google])");
+
+	if (size < sizeof(*opus)) {
+		bt_shell_printf(" (broken)\n");
+		return;
+	}
+
+	bt_shell_printf("\n\t\tFrequencies: ");
+	if (opus->data & OPUS_G_FREQUENCY_48000)
+		bt_shell_printf("48kHz ");
+
+	bt_shell_printf("\n\t\tChannel modes: ");
+	if (opus->data & OPUS_G_CHANNELS_MONO)
+		bt_shell_printf("Mono ");
+	if (opus->data & OPUS_G_CHANNELS_STEREO)
+		bt_shell_printf("Stereo ");
+	if (opus->data & OPUS_G_CHANNELS_DUAL)
+		bt_shell_printf("Dual Mono ");
+
+	bt_shell_printf("\n\t\tFrame durations: ");
+	if (opus->data & OPUS_G_DURATION_100)
+		bt_shell_printf("10 ms ");
+	if (opus->data & OPUS_G_DURATION_200)
+		bt_shell_printf("20 ms ");
+
+	bt_shell_printf("\n");
+}
+
 static void print_vendor(a2dp_vendor_codec_t *vendor, uint8_t size)
 {
 	uint32_t vendor_id;
@@ -2499,6 +2529,8 @@ static void print_vendor(a2dp_vendor_codec_t *vendor, uint8_t size)
 		print_aptx_hd((void *) vendor, size);
 	else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID)
 		print_ldac((void *) vendor, size);
+	else if (vendor_id == OPUS_G_VENDOR_ID && codec_id == OPUS_G_CODEC_ID)
+		print_opus_g((void *) vendor, size);
 }
 
 static void print_mpeg24(a2dp_aac_t *aac, uint8_t size)
diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 6f5670947..38b9038f8 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -250,6 +250,18 @@
 #define LDAC_CHANNEL_MODE_DUAL		0x02
 #define LDAC_CHANNEL_MODE_STEREO	0x01
 
+#define OPUS_G_VENDOR_ID		0x000000e0
+#define OPUS_G_CODEC_ID			0x0001
+
+#define OPUS_G_FREQUENCY_48000		0x80
+
+#define OPUS_G_DURATION_100		0x08
+#define OPUS_G_DURATION_200		0x10
+
+#define OPUS_G_CHANNELS_MONO		0x01
+#define OPUS_G_CHANNELS_STEREO		0x02
+#define OPUS_G_CHANNELS_DUAL		0x04
+
 typedef struct {
 	uint8_t vendor_id4;
 	uint8_t vendor_id3;
@@ -420,3 +432,8 @@ typedef struct {
 	uint8_t reserved2;
 	uint8_t reserved3;
 } __attribute__ ((packed)) a2dp_aptx_hd_t;
+
+typedef struct {
+	a2dp_vendor_codec_t info;
+	uint8_t data;
+} __attribute__ ((packed)) a2dp_opus_g_t;
-- 
2.43.0

