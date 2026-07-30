Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF043A7FF
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428310; cv=none; b=sF7k8aHjJwzkSTpgFZ9ROKexwvTmtZdJi5+jZNfLP5kig8Sx8WfzevkeL8XOphI35/kRViZRroyxuSIBRDkIXfOojb4r97qsAHtTV65qOyYaaG3DU6zagoIY6N8IkZ7PGIO2UXmPM3903+Ng06AIONbhm3pRZY+BfwDBq1aKLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428310; c=relaxed/simple;
	bh=Hj5bQFLufHq00/MFPxI3PzESKTnahG8Mxs/8XVRXevY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nemiHYPTd/oKV7A+gfdo4vCVWuM2losuCMafdalPRRLmBm2LLXMneqnp6bc7cMAgkNq4ShXlcsg0ypYQJmi0p4scQNuQO9M3kVTVDQEWJPu3dKtSIR2+5lNuP3g0jGBzp89Pyo6PFzbftDFHeuZ5yY0Wb1ebXq1dXt9SW8XEkac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1aMY/7I; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1aMY/7I"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so1830578a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785428307; x=1786033107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/cr8O2fJ45DKO0g9LGdnpAZnqh9rioDZWF13F3loYRI=;
        b=X1aMY/7IqFzqivCf4zSmr9zjPFrh/YO4QzKVWqETf6IgwK/icrytLbNSS5NErnaP8M
         4pPyMUqzXR0qbETnnIESp5atcKnfvN7O9m3c6ez6Bg1gTZ8ed8SMAkB7C5zRiByruLc4
         Bp//dXr6UXTtgr3CgH1Y7iaabicGNDDZHQQODMOjX55MJ7VG9XJeZq8gHY+Ai0h7lHoW
         oX9Ueuf8nvkWz4ZzL1gv8qSFjP/wGW41Y2cqYuuIn0ru84StZLZonDRQm0Q48mZAJ5+M
         WU/i2CacrvZY0BWAqaVqoU+Ilt2siapR6O4aFf0Ol8t/aDiKDJWj8Z4Ov8z/G4h7MjM7
         +OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428307; x=1786033107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/cr8O2fJ45DKO0g9LGdnpAZnqh9rioDZWF13F3loYRI=;
        b=PdsdjIsAEDJuQqNmMbarXh7swdenE1/U0Py0irQ5+Hm80M0j6FfGNxBt0O2IgQQVLN
         u+GUcEWrfOL/vWrKy+1+sPM2XDvZC3VRQDO/Hx8H6x4Im6V33YAmyKKkLDwG3a/qfqWf
         wnClg984DGQXulPQnZoUcTCS+Hyid+qQw6jvy0FkUOrb2IFA8V4FnXYCSMu1ufXgs4/L
         FozfwyCGXg2qtRoeg+CFZWXcEwHiQ6bvElrg+60wPHsprXLb7O+4KthY+oOkYUM7/Rx1
         I0gULWEoUnXnIJkZXFdeKnf+0+VtiQXMtvR4S7N1v+MVNaoW90mo1ci9w1DGijDV7lO/
         Gbew==
X-Gm-Message-State: AOJu0Yx1ZmYDRJqz03wHyn8eBoeA+868n+vEN9490aZIHwrygs9dofBG
	EtfKUywYi7JopZ6CBuF+wCcOfuVh8dRJiQwzylQoA+7KeGs+KQC6pdte
X-Gm-Gg: AR+sD11gvIY9gst1dg02yKOZt+oOPj1E5HJdntd+yW9ahgMIzF6UDwDz+CuBuWm4phe
	Fo1AMYsPnulJHu0pAC3CNvXJsP+zINcJw/h8sqiJ8i54esJnZ+wl98aY2Dpyv2bD7LR91oQVjhV
	9O2eTlRWLRr3cmV3pgDTD8cO4lOliw2S3oXrqXyWauTmaHClokL1zaoTBEVUvTDchMJTEKW1slS
	rFTLEvTs8hUnnv+9XBmTwQ+llZRuXsDsdZjibFc6VES4ziCp9+C/7uLTwoL2GEnNzrzeBr+R8VF
	AEY+Vqcdc5HzjJMotdhsGRPxkHo7G6kth0TElQZ1jmSs3mysJisy6+lThEeZup2ot3uhe693XD1
	yRt9i5pslUWCZ/fas7LQmUP8XDB9CIz7kPT5qPOKwe3fVARslJXuIQ8LCZN3af7HVSM98WU2F2p
	r6bF2L5Xq6IIHGqY14SzO85Pfpt5rIinUSq/TLMgbptRn/fqBHSTtiFo93x57FBKDBam/InLhZX
	hgEXROmiLigMPjv1I+4xH6UdSxH8tIqSxmIS3OuvYn9LF/ff3Sw2b+MREGu38qwjJCMsBxi3FG6
	n7tqCs8=
X-Received: by 2002:a05:6a21:684:b0:3c3:33df:4d9a with SMTP id adf61e73a8af0-3c9004561admr3400912637.1.1785428306587;
        Thu, 30 Jul 2026 09:18:26 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b124e4sm21359741eec.6.2026.07.30.09.18.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 09:18:26 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: validate QCA rampatch size
Date: Thu, 30 Jul 2026 22:03:20 +0545
Message-ID: <20260730161820.11631-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btusb_setup_qca_load_rampatch() reads the rampatch version structure at
fw->data + info->ver_offset. A truncated rampatch can therefore make the
driver read beyond the firmware buffer while parsing the version fields.

The download path also expects the complete device-specific rampatch
header. Reject files too short to contain both the header and version
structure before accessing either.

Fixes: 3267c884cefa ("Bluetooth: btusb: Add support for QCA ROME chipset family")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/bluetooth/btusb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8f7ed469cac..9801835d7c7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3526,6 +3526,7 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
 	struct qca_rampatch_version *rver;
 	const struct firmware *fw;
 	const char *fw_subdir;
+	size_t min_size;
 	u32 ver_rom, ver_patch, rver_rom;
 	u16 rver_rom_low, rver_rom_high, rver_patch;
 	char fwname[80];
@@ -3551,6 +3552,15 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
 
 	bt_dev_info(hdev, "using rampatch file: %s", fwname);
 
+	min_size = max_t(size_t, info->rampatch_hdr,
+			 info->ver_offset + sizeof(*rver));
+	if (fw->size < min_size) {
+		bt_dev_err(hdev, "rampatch file is truncated (%zu < %zu)",
+			   fw->size, min_size);
+		err = -EINVAL;
+		goto done;
+	}
+
 	rver = (struct qca_rampatch_version *)(fw->data + info->ver_offset);
 	rver_rom_low = le16_to_cpu(rver->rom_version_low);
 	rver_patch = le16_to_cpu(rver->patch_version);
-- 
2.51.2

