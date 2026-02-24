Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027D27587D
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913639; cv=none; b=Kjfr4Pn+RxWVXisvlxckKYjyNCnlPK6p8FXwhjvhM2BWC3opSoNK4lfQcVBmECGoz6B5HtCsMOAnSYzohOr6guO0G5JU0NVjtqgyNZNAV1/NzUULCWGoTjMahBOOHTPqXw4P+JFOuTj0vKUtfRIjBXEMHdaHSO3MMrlTY2/sUpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913639; c=relaxed/simple;
	bh=nZgYslmk3Skkq7Dos3moxWXFnIkhX8JSVheT/WmSuP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5jjXg6hlk9vsnNZiBf8Q8NeAc4VPIqon1QdrpBIYQsPvYw10R9UX6+KSWvi4yB+1tyg5G3ppC349OoPvLp7a0xgDY7aB+H3+ZTwA7F//SMMy9LUzksMNVPRjxhIzuR/4f5T3aLkfGn2sx2l3cc+mS0ZH6qaJB9mvfvExe1ai7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-662f5c5507cso3780686eaf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 22:13:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771913638; x=1772518438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KXbMDu4NldZsQWzooZBGPLWKOu0HOKaZs77YpksnpCs=;
        b=jNiQepEjgGT/tgXN4+wysEgk27vKC+weG1D7pOecaJZgWubj/4g8umZmngsZEN/Sat
         ymTR3i28+/li4Lbxt0ZkOpAm1On2AP+iy5YnZ6uUvhYXgisJcLMufBDg3esTvb4IorAI
         4qhDJx8bdiutesAH6enBhYURIR15FOoc5+7aY+7DTSMSk96xfDHxqDlmcJcFvRYLKALd
         TdfxYz0tWI84A6TcTNCDsHP1ldPSfAWw21+yBmzkvDm6p99f17em1vC5WzLR+Kf6V/lK
         wWv/NCkKN0MT4Q2baz+dMe/AebjUBwK7oyB+csO0LhSL4FvdJRpc8fc8AxaSRXpfbjT9
         UOuw==
X-Gm-Message-State: AOJu0YyHfuShW3+KzcdQrnxnTc8SC7VQfxrm5tQkzuYP0k9WxX58+mMW
	ZhZiiO4r+YQjdBjCNtSrhxvsAUK1uXvjZEswUVu8vFXpl5GEAgNKocvp
X-Gm-Gg: AZuq6aJEBIbySw8sFo0TvyzqBpD0d0xbdCx4UjSFL3GngGHRoKWVhFy7wIGbjJTrmPy
	Pp2WzSxX6ENTpOdmvi0cjM87F1TMf5sxhqmnrBQAPdLQHrFdNlVPZNsaWpc7CcKjc1k+ruQUgvA
	g6jEldNPRJ+TcY1OLLF7KpNadk/8AQL0xm3klDJ2XTs1labn3N9nW/AwYJcadOquUrAE1QGOc4g
	zlgwRu4idhgQZ6d5hKP5afwn4YI1He6yC52r3Qc49ZIzkivgoL1tU6svWOXaXWrYZid9DDU7I1Z
	1+pgRHG1hm/viO/Elbo4T2I+APeXzqTdKu4MFx+V5kv49vsSAb6klbLhBMIPNOfq3VHNBiqugZ4
	b45boHc1XIEFHl9BrxYsN010Z5YlFMiCitzs7rCURILX+QbSYiBBVCuv6z7MgscUhfUQhws4aNg
	R9NQFnxx3ngaUgPjR47DKer8UxcxHaDOYyN75FrJIHzeZzf7Cg0OOVTP5n5KMoww0=
X-Received: by 2002:a05:6820:828:b0:674:2eda:cbe7 with SMTP id 006d021491bc7-679c450123amr6421042eaf.52.1771913637860;
        Mon, 23 Feb 2026 22:13:57 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:8ac2:4fdd:a742:61b8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c56dbde9sm7895306eaf.11.2026.02.23.22.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:13:56 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 2/8] Bluetooth: btmtk: add MT7902 MCU support
Date: Tue, 24 Feb 2026 00:13:19 -0600
Message-ID: <20260224061325.20189-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224061325.20189-1-sean.wang@kernel.org>
References: <20260224061325.20189-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Add MT7902 device ID and firmware filename to enable MCU firmware
loading.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: no changes
---
 drivers/bluetooth/btmtk.c | 1 +
 drivers/bluetooth/btmtk.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 14e2f4100806..2507d587f28a 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1338,6 +1338,7 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 	case 0x7922:
 	case 0x7925:
 	case 0x7961:
+	case 0x7902:
 		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
 				      fw_version, fw_flavor);
 
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index b9df2b8f0627..adaf385626ee 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -5,6 +5,7 @@
 #define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
 #define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
 #define FIRMWARE_MT7922		"mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
+#define FIRMWARE_MT7902		"mediatek/BT_RAM_CODE_MT7902_1_1_hdr.bin"
 #define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
 #define FIRMWARE_MT7925		"mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin"
 
-- 
2.43.0

