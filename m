Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C62FE04D
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766432118; cv=none; b=D9+hy6Le0YfUVcXRL5sV+ANaYm+hs6oS3ue+xPn0pwBIVYNfAxWm3IVRmjIUMQlcLpG5J8p6OmBml+68s4XPVDsJ7fm/+k0o+7FCiUoHHuHaM/dS30p1DHzdywKxIC0fdvMhJY7uMNZbM9cKDjGnAOMJgjAkz49KFO+OCC+zGzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766432118; c=relaxed/simple;
	bh=8f3GGrIv89YxaoR2It6M2JI9jbO5Inoc9EnFytB+Uz4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBnLUAg6ZrJGbKaqfDzIWoqPfqEdYCPwpJ2poEscwh1SV9fYrAoaYop2yJu2KYnjQYMjTXuHPrlbBzObmqs9G1HYlm1cuQBTtSqzH7jZs/0ewizrJ9fc5n4RCIi/2ma6brWuDDvdrIaRrifRW6uOKj9jb8fqRpfbuJuuDLSnqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6jI48XG; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6jI48XG"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-55982d04792so3407625e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 11:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766432116; x=1767036916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8YHLMEOTSfO8FOZretMByXNNIdFpBr5EoXMchy9Rt4=;
        b=h6jI48XGZFgF9FiJZ1rmwveFit13Ir5eAYQt04QpFdOSgVjttw3f6PmBRCwpwOrW6S
         4bgH9HLuGQLZPb/Nh+2evNUNL4ADyBemDjm0uS0A9mUG/OI0dAKYCBuYdBWNA49CgcD5
         1enYNxCclLdku4HG+lNGs+XBhQfV1nD2atbaeFVhyolPt/8wQkAyqqaHvtGwVKz8Kd/Z
         f20UfIU84Uy6lI4To4/QFPeiIlINjZO+zX27NFtCXMPJpRbrTjaEcFO7X0rifl+AKlns
         28jb7vDkBbejdlqMCaHpz9uIujnnYFFu/KZ6i5TOnD/s6frRryZOrn0auNKgW0CT00EW
         yzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766432116; x=1767036916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i8YHLMEOTSfO8FOZretMByXNNIdFpBr5EoXMchy9Rt4=;
        b=C9bXqG0c4QDCRv/V0d2IZA6PAI3AAwK52wxeV6qVKtbiZCC72WwUTb13p5CHzyAH2M
         d+S8dnKZpTlgkNd3YF/i5ccdaX4SH4maHDsQKbGYPg1KajKrCyqeWo2B6VzZz0nmnrUX
         jjKJnLcf/B7Q0RcIRV37rZnJi0UW4bzajOObcl5M7PwnWVfP45nUgIA/6SNgh5fqNAHk
         mSLavHtetU/RuRpyW62F/uZWalES7hQ5gxrxIrMAvarAtupdVvUGzIik7HZyCkpyw4j9
         5xg4CDXHa7cFPPoOSyBEBKE48nc874Lk1X+D7Oh+oPL+VLWRfuxLTnDEtDfMXqK7Z5tR
         r+yg==
X-Gm-Message-State: AOJu0Ywh2Nn/yL1Pc8eVaZz42UmubqDGu5ALUMwT15Ca5e3MBmY28imX
	auZ8cNA9T6IkNRvlsGJirwGOm4tm6z/+F9PJdTJ2FF7DBjqdliywsRMpoW9cgwCh2dw=
X-Gm-Gg: AY/fxX78tI2NblEPBaqlR6kVZnl0nBv2OTKCxa7NGoDaX2TXGlhjxP355uWSuNcPwvN
	VaI2+QJYyZk/pjMZ+D8ZrAyXhirjMmcozRTLLH/H1kpl9YMte9juDKP/NUHZnM6zsdynFAi3Thn
	/y1d8WDkhDcbJ7E951ZCsHYGax37/TCroKea33YKFr7uVHaizSqk/KhGRhb+JchIQMUx6La9H3W
	kn3UNIiSB54Y6ZWPsCjW5W+pSMdt4xkoSVoTvpt3RzBs75wwU2rpBjAGymI/zKdbjj+EnGnCw1R
	t/xglpOVGm1jp4yWkVNFKxkFQxbLoLKEMDYTYhykrIjyrxRvUM87v2PZhSXgmlZRo1ifEgZTygO
	KWKEQW5TWq9u+jggh11MxW0QUlR2XsaBSBPmhlSH99Klg1doTiiARiNZz4KFpLP/EvKXFtGh6Mi
	5RCFDchU+p9WHL9w==
X-Google-Smtp-Source: AGHT+IGcY2Z922jrUROfZnF4IoHq0+C7E5Qr4kcRRxarNVVKLo1V65J2ELWiQFQAyJ+OLQM8UJrXrw==
X-Received: by 2002:a05:6122:250c:b0:55b:9c3e:891e with SMTP id 71dfb90a1353d-5615bcc26f5mr5060359e0c.3.1766432115920;
        Mon, 22 Dec 2025 11:35:15 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5615d132efesm3764301e0c.11.2025.12.22.11.35.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 11:35:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] monitor: Fix parsing of BT_HCI_BIT_LE_CREATE_BIG
Date: Mon, 22 Dec 2025 14:35:04 -0500
Message-ID: <20251222193504.650019-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222193504.650019-1-luiz.dentz@gmail.com>
References: <20251222193504.650019-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The PHY field of BT_HCI_BIT_LE_CREATE_BIG are bitfields rather than
a value, so this changes the fields to phy's' and fixes the parsing to
print it as bitfield rather than value and also make the emulator to
use bits_to_phy to convert when emitting the likes of
BT_HCI_EVT_LE_BIG_COMPLETE.
---
 emulator/btdev.c  | 38 +++++++++++++++++++-------------------
 emulator/bthost.c |  2 +-
 monitor/bt.h      |  4 ++--
 monitor/packet.c  |  4 ++--
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 6db723ce8797..d3a9c6735ff1 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5778,6 +5778,23 @@ static int cmd_set_pa_data(struct btdev *dev, const void *data,
 	return 0;
 }
 
+static uint8_t bits_to_phy(uint8_t bits)
+{
+	uint8_t phy = 0x00;
+
+	/* Convert PHY bits to PHY values on a ascending order. */
+	if (bits & BIT(0))
+		phy = 0x01; /* LE 1M */
+
+	if (bits & BIT(1))
+		phy = 0x02; /* LE 2M */
+
+	if (bits & BIT(2))
+		phy = 0x03; /* LE Coded */
+
+	return phy;
+}
+
 static void send_biginfo(struct btdev *dev, const struct btdev *remote,
 							uint16_t sync_handle)
 {
@@ -5806,7 +5823,7 @@ static void send_biginfo(struct btdev *dev, const struct btdev *remote,
 	ev.max_pdu = bis->sdu;
 	memcpy(ev.sdu_interval, bis->sdu_interval, sizeof(ev.sdu_interval));
 	ev.max_sdu = bis->sdu;
-	ev.phy = bis->phy;
+	ev.phy = bits_to_phy(bis->phys);
 	ev.framing = bis->framing;
 	ev.encryption = bis->encryption;
 
@@ -6955,23 +6972,6 @@ static uint32_t le_cis_latecy(uint8_t ft, uint8_t iso_interval,
 	return latency >= interval ? latency : interval;
 }
 
-static uint8_t bits_to_phy(uint8_t bits)
-{
-	uint8_t phy = 0x00;
-
-	/* Convert PHY bits to PHY values on a ascending order. */
-	if (bits & BIT(0))
-		phy = 0x01; /* LE 1M */
-
-	if (bits & BIT(1))
-		phy = 0x02; /* LE 2M */
-
-	if (bits & BIT(2))
-		phy = 0x03; /* LE Coded */
-
-	return phy;
-}
-
 static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 						uint8_t status)
 {
@@ -7255,7 +7255,7 @@ static int cmd_create_big_complete(struct btdev *dev, const void *data,
 	}
 
 	evt.handle = cmd->handle;
-	evt.phy = bis->phy;
+	evt.phy = bits_to_phy(bis->phys);
 	evt.max_pdu = bis->sdu;
 	memcpy(evt.sync_delay, bis->sdu_interval, 3);
 	memcpy(evt.latency, bis->sdu_interval, 3);
diff --git a/emulator/bthost.c b/emulator/bthost.c
index c9eba77cff7b..fe6ad4145673 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -3831,7 +3831,7 @@ void bthost_create_big(struct bthost *bthost, uint8_t num_bis,
 	cp.bis.sdu = 40;
 	cp.bis.latency = cpu_to_le16(10);
 	cp.bis.rtn = 0x02;
-	cp.bis.phy = 0x02;
+	cp.bis.phys = BIT(2);
 	cp.bis.encryption = enc;
 	memcpy(cp.bis.bcode, bcode, sizeof(cp.bis.bcode));
 	send_command(bthost, BT_HCI_CMD_LE_CREATE_BIG, &cp, sizeof(cp));
diff --git a/monitor/bt.h b/monitor/bt.h
index 0a1508ea28a9..147b76537e97 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2818,7 +2818,7 @@ struct bt_hci_bis {
 	uint16_t sdu;
 	uint16_t latency;
 	uint8_t  rtn;
-	uint8_t  phy;
+	uint8_t  phys;
 	uint8_t  packing;
 	uint8_t  framing;
 	uint8_t  encryption;
@@ -2840,7 +2840,7 @@ struct bt_hci_bis_test {
 	uint8_t  nse;
 	uint16_t sdu;
 	uint16_t  pdu;
-	uint8_t  phy;
+	uint8_t  phys;
 	uint8_t  packing;
 	uint8_t  framing;
 	uint8_t  bn;
diff --git a/monitor/packet.c b/monitor/packet.c
index 4544c90c2d81..807d32e9b447 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9025,7 +9025,7 @@ static void print_bis(const struct bt_hci_bis *bis)
 	print_field("Maximum Latency: %u ms (0x%4.4x)",
 			le16_to_cpu(bis->latency), le16_to_cpu(bis->latency));
 	print_field("RTN: 0x%2.2x", bis->rtn);
-	print_le_phy("PHY", bis->phy);
+	print_le_phys("PHYs", bis->phys);
 	print_packing(bis->packing);
 	print_framing(bis->framing);
 	print_field("Encryption: 0x%2.2x", bis->encryption);
@@ -9055,7 +9055,7 @@ static void print_bis_test(const void *data, int i)
 	print_field("Maximum PDU: %u", bis->pdu);
 	print_packing(bis->packing);
 	print_framing(bis->framing);
-	print_le_phy("PHY", bis->phy);
+	print_le_phys("PHYs", bis->phys);
 	print_field("Burst Number: %u", bis->bn);
 	print_field("Immediate Repetition Count: %u", bis->irc);
 	print_field("Pre Transmission Offset: 0x%2.2x", bis->pto);
-- 
2.52.0

