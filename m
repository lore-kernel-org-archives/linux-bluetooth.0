Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665173FE4F
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Feb 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152609; cv=pass; b=LE4AHyAaW753hYN8N4CZm4kmCQ9fjDrTTt7LueNgHsHlM6CnOvQRS6ZR04bakm4AdEEIMCyPdyTlYQoy+BWlb53aps49HWFfNYfKNWwx7pt8EYrvadl17KTXiYVlZsfwUtXPI/0tIBsWtdIEMTp7WeZ/HhgSG6FBDlaCvI2/WmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152609; c=relaxed/simple;
	bh=peV5kYgpSiPEnG4t3+EHVJ416RR4W3k58gZceZoc6ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SznVFqEaA5sooCsJwvxw45SYWIoUoQEx10oY5e8IAlpQsyHIRvkt8VGQ1RZ7LP3h6pFNEW1VGb0NwWwZ51zwLNucT9afmAlYDXNgaUEPFGkLUQ+/JSclOS2Ql2PQb2nhgvynOAbCU0esZdUV02jWCS9kx38383GToMSO/yoB2pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=U4oDQxHR; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="U4oDQxHR"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TTCPm4hZNz49Q4s;
	Mon,  5 Feb 2024 19:03:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1707152605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBLbQOEXDllWzF9PWEBorYN4aRuRVcOcjWvY/mlTdRY=;
	b=U4oDQxHRacq9xghmxzaDpiiK7ll7lFR06Of4vod8WTSzn/CAJBQ5f41Oqd9jfNwO5Xhhic
	ke7zJVNT/8s5D0UkWS5vj5vX7Z91WPc5FrNtXkZpfeGGG1CVknXezCXa3I4IHn4l4ntzLN
	lvB4Kmp5tac53ioZOkMG2a0/bzfPiuLSbfXsUUaX9ME83j+GLzuPtrsFEdYGhwFRKxmEPH
	xFi0Y2lzQEQWfO5WZfIp02JSE0Bdd1IcA+5ItzVETfJz51KoCKATxPqKcaZKSdCKuJVVDu
	Sl1xZd5EUQvnZZjyzvQfq+NZPO6URRRlaMB0VVatzfr2e+n1CMP7sMZTO0dQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1707152605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBLbQOEXDllWzF9PWEBorYN4aRuRVcOcjWvY/mlTdRY=;
	b=Iy16zqbdzN7RsziT2l2MGirVArLlAM5GpP/O9f8HjeBiNlOp/6HS10vIhK4SRMBby9tF9H
	a+8qlvTO1rT6CRyvRUAC7c0Rr5sOcFv1QjVpYyrDEwP++NpTnh2v3qdEI4nFDA0DpA1eKV
	HGPYaz4IbsUD7O+OYFh4ifb5f9+PUMCEPR22irRa4+3rhooMR0Dl2BMw4V0KU1HxAdkO0x
	Z+tkI2k/8UeUPY92bRb+4HFNhxXrPFAn+qj5wCmjTATP4VNFts3ATXnnO7H9IZBjAPOdoq
	4OXKIIW7CAc6OJRSUlTE+8hBtgVke2jIzLMLiVuJJN8FAenH3pz6lOAXqJN7nA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1707152605; a=rsa-sha256;
	cv=none;
	b=KkIV4JCJGGm1GzADQ0MqAb3tA+c0ieNkiblIVKXXw55fk428BwmossyOHAoW+rpL5XpPq0
	7pVH/CH9MVtDWvRf6tbm4IkOr6oYlN+o9WrDQNv7UMiRR6Jwy0N8i2B4Mw4pbmPpfYqQK7
	XjaYYRx4HgVXKH2VEvq6fLfUsXSGA6M7/FF9I/Ua5nKQLrYrbUbd2+r+coz4soCcUdjDAO
	wxyP7MQO6G+RJ+bmkVDy+AU8HwJfD0JzS5AbblmTqk5kEKsdIw9+hemVGZslq3Q0LW887k
	j2Yj+Ra37gLicGQGEds/6VoPMBfpCcLHKz02bVLWoT2sCkwjpyLyZujUtSctww==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/2] client/player: parse Google's Opus A2DP vendor codec capabilities
Date: Mon,  5 Feb 2024 19:03:17 +0200
Message-ID: <85bd33f548fd177b392f067d54ad3922a0db6cec.1707152569.git.pav@iki.fi>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5ae678a1c4353818744a6bff31b21055371d2592.1707152569.git.pav@iki.fi>
References: <5ae678a1c4353818744a6bff31b21055371d2592.1707152569.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support parsing Opus (Google) A2DP vendor codec capabilities.

Transport /org/bluez/hci0/dev_B8_7B_D4_32_44_15/sep3/fd2
        UUID: 0000110a-0000-1000-8000-00805f9b34fb
        Codec: 0xff (255)
        Media Codec: Vendor Specific A2DP Codec
        Vendor ID 0x000000e0
        Vendor Specific Codec ID 0x0001
        Vendor Specific Data: 0x92
                Vendor Specific Value (Opus [Google])
                Frequencies: 48kHz
                Channel modes: Stereo
                Frame durations: 20 ms
        Device: /org/bluez/hci0/dev_B8_7B_D4_32_44_15
        State: idle
        Delay: 0x0898 (2200)
        Volume: 0x001e (30)
        Endpoint: /org/bluez/hci0/dev_B8_7B_D4_32_44_15/sep3
---
 client/player.c              | 32 ++++++++++++++++++++++++++++++++
 profiles/audio/a2dp-codecs.h | 17 +++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/client/player.c b/client/player.c
index b43b4b867..a40bf66e3 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2471,6 +2471,36 @@ static void print_ldac(a2dp_ldac_t *ldac, uint8_t size)
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
@@ -2508,6 +2538,8 @@ static void print_vendor(a2dp_vendor_codec_t *vendor, uint8_t size)
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

