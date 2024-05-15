Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22564F213;
	Wed, 15 May 2024 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715814935; cv=none; b=oBxsnR6biDq89Zi4kGFvkY3f2QXERFAavqJpUspswIpz+l2kZvhyCF5zto+EvYUBd3aSdoYrOCDvT448+5JP3K526uD7byoxuQIGhXQVu10ZnVAitKKdUDU9QSq20zrhDF+zXpR94BzCvkRQtMxXHoJHH0d7GrjEZZ3Kv5RK+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715814935; c=relaxed/simple;
	bh=KkdBoviU2Vuexpn42UGlpxq9Hnymbw2uFQMmvXakpkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sFIySCDFABoj6Q685N2Qr1Uff/xHPz80j3Adc+/FrL27iO+RNYrb7rEhJorMF13oRZgysH9ajn/m6ek/EfVgck6crwtWSQw7/M2KpHvHKLHWD/pf2KNQZLyhiG7IWwrSaWnfvjcg2CVliaiI5MWXWEouqk0u6aV0IP2hbLvXUo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b2f4090ac9so337323eaf.2;
        Wed, 15 May 2024 16:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715814933; x=1716419733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s8lTrIOPp2rps4ETyvV9vi8AsmvDY3xHbsdrzyXbxxM=;
        b=NGegB6xXXuUEqFUqGAvah4O9regTfvUG0r3oImtQgP4dQIiI9VCmxNwMYKsnF4e6zf
         trXUrG/PS+TIXLo+oIArt1ppeA9wbvJvvTGTNMmUUR/FX/naoE57GcoBpwHzqxZL1lML
         yv4ZUVIVOrmNUcBk8yg3hf7YSRc10SnzpoPAb7TdiesviVgoOb9h4eyAAMe8a5HtQ/Jp
         FvVRuS8vBv7WNqgWwxV4qYBRdRRD00k8+Enq5cCdjJ5Wl0KesKqZELl1aJ5pPTta8WqQ
         dEU8VLD2xlUT1WTzCOaBJ4CaGNZlTQqANKKAA7Ji2Nq+VqqSL6E4OH6Txok/CDUwuGre
         aN3g==
X-Forwarded-Encrypted: i=1; AJvYcCUVY/7TdqjtG2gjI6Yp52TfDumJ8OAfntrZtdo2zf1vjqkzz+H3L0hkmmj4BdzYc4dp/tkZxC8gQl4TA2MNx7mMfGciceGCSqcv+S7h
X-Gm-Message-State: AOJu0Yz0uXhgUKRbAghIQMAsXUV9ZlyK0JFtGgskpfWnsehBvJqccIsH
	eZICZbwBJEGUTzS4HPkxunrWgoUtEQfLNerfnx4VxmW8h++M6XASxO0PCHaFFr8=
X-Google-Smtp-Source: AGHT+IHJZzy1efEISuW3awypyoQF6Uoeq89kZn447ERsBVT1h1CIAYblZT6dnBXhB5s6AqsgZ4ehKw==
X-Received: by 2002:a05:6830:2051:b0:6f1:2171:4f9a with SMTP id 46e09a7af769-6f12171526cmr4177443a34.0.1715814932887;
        Wed, 15 May 2024 16:15:32 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0ec2e566dsm2032159a34.15.2024.05.15.16.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 16:15:32 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 1/5] Bluetooth: btmtk: add the function to get the fw name
Date: Wed, 15 May 2024 16:15:17 -0700
Message-Id: <ce0337178bf617d52ff320a36837d75bf537df2d.1715813148.git.sean.wang@kernel.org>
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
v5: fix an issue about the directive output truncated writing caught by
    the linux test robot
---
 drivers/bluetooth/btmtk.c | 18 ++++++++++++++++++
 drivers/bluetooth/btmtk.h |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 812fd2a8f853..a27c251bf56e 100644
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
+		snprintf(buf, size,
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

