Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6883E16DECF;
	Tue,  7 May 2024 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109728; cv=none; b=hnmmRRFaagbtkCDfrkZs1B6zKlyDRoZfy7sml+OSsrB/V5CchGZ9sGzGhttu3m4oWOUHkPLGflr6bl3nuNYU3A6zBHNXK1vOP0MxVP8IhaHvRoAoYUU3w4Ig4mAimCkW3TKtK94RWi2cySNHbw1ERZuq5A8moiEbt9lmcDXTpOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109728; c=relaxed/simple;
	bh=p2WcEKEhwoNTo10Ew+OtVoaB84xhMJC42oHb4GD7Lfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dt4z0Vx5JqbRMi+uHQzAiZjT9kR7CNkk76ursziMbIiLK9NJ77BGQPTZgW52rWf5PxqFfLbfKSfXfqsyD17kKkNkDwHxr+NrMs9183M9iTH3DxbbRZfff0TKyEfEcLvc/x9j0n+Qt4pbrwBkaVx3HP9Vu+zSOLSmWdyvqo8fhAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c6febc1506so97285b6e.1;
        Tue, 07 May 2024 12:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715109726; x=1715714526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sYQ7hw69f2uaeyraCUDwvaBx7HkdTU5mSjbOPq3iac=;
        b=hXmn2htT/SHsrx28gz05zJNiZkWpLgpD2CCqTjXItdaLMBuKLu4Hq1ZvK1JXCrpLBT
         kjJFr982zbbfwoN2E42jf+ws+R3swx2FPZRB+DsefIldwuqZM8QZWscSNQcUZjqu3Tuj
         Zqf30QsjcWH9yays1SikDEBq9IpQ0gsyQgbJzVSb9kBpnenoYDNntPtpOnXTOOTri2HF
         mkYcUSujsWnPHMwPSlremYu5++RXCmElw0CPQdbcP9buFccyQ4KE09otfvKq7SIrKOsM
         NAputCJy2w5ThtUrL8Q+qy5tXotvvZvdTe6UW3AXuMLwMQAeOsrabn/2ptTQR3v/+otT
         6SKA==
X-Forwarded-Encrypted: i=1; AJvYcCWWJzHqVhmmxT26muRFjBffOdbvSCZJ+JexaBDoZ4eUAxw2QAqJvOoUiswy1b/Y/CXT8RvVLlQ9rR9zdnhx07TOLfmGo9vbcZ9w26l6
X-Gm-Message-State: AOJu0Ywn07lxC32LlmFVlN0xbmQKxH3nriKuVT2uG5eE6Rd+HWZHHj4D
	qim1cNLM3LewuDH8Ck6cHfmlL9U3/LrTxYPLs9xIZyjp/kQEFiCk
X-Google-Smtp-Source: AGHT+IFGJT+GhblVrXRIxWa/VWNiQry1JanDcqFMqp4jnjRxoRWMN+EgM7MNzwp7ukiMEffX9fLAGQ==
X-Received: by 2002:a05:6808:181f:b0:3c8:4b12:107b with SMTP id 5614622812f47-3c9852ba08cmr595514b6e.2.1715109726543;
        Tue, 07 May 2024 12:22:06 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id ec18-20020a056808639200b003c8643f0e5csm1937839oib.16.2024.05.07.12.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 12:22:04 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v4 2/5] Bluetooth: btmtk: apply the common btmtk_fw_get_filename
Date: Tue,  7 May 2024 12:21:58 -0700
Message-Id: <6aef1a64b54a32134f5e995d1dadacbcd9c9ce33.1715109394.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <965cd14922aea67e2750ff2c2ecad773f8ba485a.1715109394.git.sean.wang@kernel.org>
References: <965cd14922aea67e2750ff2c2ecad773f8ba485a.1715109394.git.sean.wang@kernel.org>
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
index 90d1f1697357..1603e97f0d7c 100644
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

