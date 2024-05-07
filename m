Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFAD16D9B4;
	Tue,  7 May 2024 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109726; cv=none; b=s27oQUsYRNF1VTauRYITE9ajjrOBoKeaTvawP0gylFiZr2Dl0sXk95lR4RK32w3wpLWwvwtHuOjTnQwVm3XKzvbaQbXo3HQBK1neopjN18mmXcWP3Fjx1da8dXtTRSChhz1CDy/UKxyfVwrk5kSLhB++gnRSyiDShTkR6YvHAJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109726; c=relaxed/simple;
	bh=qp+EXX+SaGOTNAAk6fUdXyQK4DSdv3tg215Ei2Un+OA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HcuZjSzIfcBPv9kJYGYZDiOgGDcCdv3sksG2AQkYAue9jjD8dyHsAqbMDkh6X/117Kf3Luv8CEHfQWlAQwDBVXRRlDIPq5xh5rt+l1C6Kitkuan/NHoWYzD6bUU3j3klvpdkQO0Rnvbp7M9u41C3YNpmG3MMgFURQUlNQpqeYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c96ef6bda1so114975b6e.0;
        Tue, 07 May 2024 12:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715109724; x=1715714524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbHKc868SB9HcUl+k2ACtYV5D4mU/L/TbmBCs0TDn/g=;
        b=AwOhFxKub4GRIue+5Z7GLykguaNo8ozgMhimxRKy7PaISIOTJzL4JcK9L075TjJrer
         CVLXKCn27jBzWZQ9fIgUpjOEZ6oUltAR4uldenXi/CcYdDGGyyJ0cZJVkCNdKEIANWn7
         JRwI3rsrmirMzMZHCMdm158lksWrz1J7cmNeRGD2Uklp74DUkBqFAJQY3kG+HD5ncMrX
         RHg1pWJA4LrEzTGqPt1sLDC6fMJOEBFbDraP0R60O3Y9+2kKulcr+etxkjKkcnpRf7Z8
         F4E+hDNdATp/W0Iwtv6mwn2M183LgLqmg+2sb02+LlAhATCvbboyuJEZUry3FTvYEMnj
         IIyA==
X-Forwarded-Encrypted: i=1; AJvYcCWfq6xSoaA7DvJt8dSTJ8g2Ht/tLOObMe/JOrhxqvTBOpn/api/bhoDyT0v0dunK2cVK5dxkbKlzEShUB93Xl40IHtxXFbHg1sqWfq9
X-Gm-Message-State: AOJu0YzNzCqftRGEBZDpg2gW98/hHUVJhMMekxXjPef/eM9FOZKeGFo7
	obDyDRZiqA5PGc8J4nzXvxGVuxGlnyZJqMZr9tbhh901GP3QdkVZ
X-Google-Smtp-Source: AGHT+IF6/Amm/9IUVwqPVK/3VfK6o6rocm8ala/XYv84JC/t3MO2ZMmHzbvtXvjZdxTbIyJfUGHM+w==
X-Received: by 2002:a05:6808:1796:b0:3c8:64c2:73fa with SMTP id 5614622812f47-3c9851e5985mr601086b6e.0.1715109724427;
        Tue, 07 May 2024 12:22:04 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id ec18-20020a056808639200b003c8643f0e5csm1937839oib.16.2024.05.07.12.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 12:22:03 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v4 1/5] Bluetooth: btmtk: add the function to get the fw name
Date: Tue,  7 May 2024 12:21:57 -0700
Message-Id: <965cd14922aea67e2750ff2c2ecad773f8ba485a.1715109394.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Include a shared function to get the firmware name, to prevent repeating
code for similar chipsets.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v3: first added to the series
v4: rebase onto the latest code and add an additional parameter
    fw_flavor into the function btmtk_fw_get_filename.
---
 drivers/bluetooth/btmtk.c | 18 ++++++++++++++++++
 drivers/bluetooth/btmtk.h |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 812fd2a8f853..a0a858a0706d 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -103,6 +103,24 @@ static void btmtk_coredump_notify(struct hci_dev *hdev, int state)
 	}
 }
 
+void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
+			   u32 fw_flavor)
+{
+	if (dev_id == 0x7925)
+		snprintf(buf, size,
+			 "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
+			 dev_id & 0xffff, dev_id & 0xffff, (fw_ver & 0xff) + 1);
+	else if (dev_id == 0x7961 && fw_flavor)
+		snprintf(buf, sizeof(size),
+			 "mediatek/BT_RAM_CODE_MT%04x_1a_%x_hdr.bin",
+			 dev_id & 0xffff, (fw_ver & 0xff) + 1);
+	else
+		snprintf(buf, size,
+			 "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
+			 dev_id & 0xffff, (fw_ver & 0xff) + 1);
+}
+EXPORT_SYMBOL_GPL(btmtk_fw_get_filename);
+
 int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 			      wmt_cmd_sync_func_t wmt_cmd_sync)
 {
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index cbcdb99a22e6..e76b8a358be8 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -160,6 +160,9 @@ int btmtk_register_coredump(struct hci_dev *hdev, const char *name,
 			    u32 fw_version);
 
 int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb);
+
+void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
+			   u32 fw_flavor);
 #else
 
 static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
@@ -194,4 +197,9 @@ static int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	return -EOPNOTSUPP;
 }
+
+static void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id,
+				  u32 fw_ver, u32 fw_flavor)
+{
+}
 #endif
-- 
2.25.1

