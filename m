Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB32B52F99;
	Wed, 15 May 2024 23:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715814937; cv=none; b=WUu1X2d/g0GTx/x1gTLZWLtYpn29WlIJLzC0YJwSTqK4XNuwhq7HDbvo8dl+16d2tuUbDqkOC+GdzI80KlvhHY2fksekGzbV4dUoNU62QI9eJt32j3oE+KPgnuu7o99kbpAvwzEuiFcmezQKEvWDzGl/dHgKTBhezbOyLUOqocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715814937; c=relaxed/simple;
	bh=Saa+Cv9T0K8Lpspg+3DK0q7kAqVgxKAxcJ1zxIGrbFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fieb8SbOONMltp1CZvBJS1/j5/2KlvNl7CXRH9hpwzCqHVRIH7BXB6boZiXMGQdvZxUK/VZ78L8nPsaEvdlN5TvR77p8FrX/crXgR9LbIjSC2rrNj82wAIKdplz5jkYCMrdtFR+BycAgqQMaUo7SKBSjyzIfJcJdOquUlKUq5/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f0e516ee2bso574858a34.1;
        Wed, 15 May 2024 16:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715814935; x=1716419735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhvsCgYPvB92Q5BFBKTie57uhIEMm1z1mEV6N05fCRE=;
        b=BlA64QNVk6bH5XTCGKwnx1qfedNSpCwOJZuUuQUq5iTtoKZ2OaYyvZSvGqCagfS1WT
         VYTNVAjaeZOzegvhhtt5eBE4bFiM+gehMPJ1NBWSXLNgDoQgjhkMPpXazE/YA/C4958q
         fBk++MS8lMSPiSl4GiSNweZU8UF4RV5Q+KvAITLmBEFVqvbGwCcqSIh32PPhOvVMsWFs
         fPvQh7ttsyVCENei/A5EDMtPbnD4Pvc+GWF2zCrnPC2aD71pmt3ua5WW133FiEW43mwT
         kymwcgaVM7wPCCdmBFeyF/BCH+ZvbVcexuLm5nsZ4MpCkHk2ev9f8m8bYw5UWc5nHEk5
         AcLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRU189kpyusLhVvxo3/YDTwwZkD8m/9B/rid0U/4+O+GXWPSAV2n/smMqlajfsFi0qjMIz5f4nJ2zNe8oH3LYNX7S6kCkUO3mRT8zc
X-Gm-Message-State: AOJu0Yw1chs1QriYGQ551C4eC7qQq1ItTSVPR/K9S6gxJYxLPS4t+pLE
	aI5B7uBi4XF1qusvl0xL3q2U61aWWOCVaTVGnggHACweV3GhWE1o
X-Google-Smtp-Source: AGHT+IEE6LNZ3dq4LwLZKPsCEi4p+ERRiPUUnv07W4qArNWrUWhhCwZjNS6tXxt72v25gQ1W/iMpaA==
X-Received: by 2002:a9d:6d95:0:b0:6f0:85dd:131e with SMTP id 46e09a7af769-6f0e92a69bfmr21075455a34.2.1715814934801;
        Wed, 15 May 2024 16:15:34 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0ec2e566dsm2032159a34.15.2024.05.15.16.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 16:15:34 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 2/5] Bluetooth: btmtk: apply the common btmtk_fw_get_filename
Date: Wed, 15 May 2024 16:15:18 -0700
Message-Id: <1e9c955a0b311ede0bafedd4c49436cb5a04c9b1.1715813148.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ce0337178bf617d52ff320a36837d75bf537df2d.1715813148.git.sean.wang@kernel.org>
References: <ce0337178bf617d52ff320a36837d75bf537df2d.1715813148.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Apply the common btmtk_fw_get_filename to avoid the similar coding in each
driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v3: first added to the series
v4: rebase onto the latest code
v5: update the caller usage with btmtk_fw_get_filename
---
 drivers/bluetooth/btmtksdio.c |  3 +++
 drivers/bluetooth/btusb.c     | 14 ++------------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index ff4868c83cd8..04be06f73e05 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1117,6 +1117,9 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 			return err;
 		}
 
+		btmtk_fw_get_filename(fwname, sizeof(fwname), dev_id,
+				      fw_version, 0);
+
 		snprintf(fwname, sizeof(fwname),
 			 "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
 			 dev_id & 0xffff, (fw_version & 0xff) + 1);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e384ef6ff050..611135d1ce01 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3166,18 +3166,8 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	case 0x7922:
 	case 0x7961:
 	case 0x7925:
-		if (dev_id == 0x7925)
-			snprintf(fw_bin_name, sizeof(fw_bin_name),
-				 "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
-				 dev_id & 0xffff, dev_id & 0xffff, (fw_version & 0xff) + 1);
-		else if (dev_id == 0x7961 && fw_flavor)
-			snprintf(fw_bin_name, sizeof(fw_bin_name),
-				 "mediatek/BT_RAM_CODE_MT%04x_1a_%x_hdr.bin",
-				 dev_id & 0xffff, (fw_version & 0xff) + 1);
-		else
-			snprintf(fw_bin_name, sizeof(fw_bin_name),
-				 "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
-				 dev_id & 0xffff, (fw_version & 0xff) + 1);
+		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
+				      fw_version, fw_flavor);
 
 		err = btmtk_setup_firmware_79xx(hdev, fw_bin_name,
 						btusb_mtk_hci_wmt_sync);
-- 
2.25.1

