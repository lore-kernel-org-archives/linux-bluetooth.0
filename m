Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A57641C64
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586393; cv=none; b=tqJnfMhWpE4LmybY1Dbcc2kKV7ncPlQl25rJc0w+maqgeOoiBas6wfu58gsYfheWiMsrMLErZxtMfx21S53w2cg+XMBoV8o/BWPskfsrGLUtXe0ZK4qqY3xRVctGUP547zgKc2B7L+B3ZaM91kTivnDBdvEaa3tZrW2gkpdKpTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586393; c=relaxed/simple;
	bh=aoPOLwSTK9wAKJssUM70efaMaxAQCrToQ8t27HqZ6q8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cSkkEovX15mlnUJE7mQJR4DEtlxYgxgrq7kjzA3qqqvrOoevbrB3SQWDAhJ630Cf4IjA0cASkcUV5qU78ZhGrnUiIWRASlnM+TY9BYs8vbaipuQIHn8k6j3W9mhZcgHwkc5gG3WtIb0HE59Ulgi7/OxPPVieM1fa0oaYPp7+rD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egimneTe; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egimneTe"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-523efb24fb9so1164235e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 12:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742586390; x=1743191190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KLiSZBXw08sW3O8VTxDohqYHxl9VVX6D5381MqASUjE=;
        b=egimneTew+ucke8sL1ESUT+C8hkjoaQC4Rvor6GTIWlo6/bWcwheuI4mau74DYpWvH
         1WH1+iW2YBT0teR++sYT9IAynsiIcEadimGNkRYezjwFrdNaT5zkEj+/wrAWLs/W7kxV
         tLidh+NrOWIOgoN6ZtrYNI0bRUn2AB95Uwh6Q6tb9dsd2AaXuB5HROoTmOCPwn6+Aj2e
         VtnMKixSQbUqM/A6/Iy7wW/Rp34xO4IiAevcJSJGTTQYscaDHfDM9bLPMkdWpiwLfHqY
         K2U3W31PsEKOiHhfjI5hdeFIhDOurfzpSkMIiTy5mGVbigDOb4uYXIFVI/QFnBTJkrwA
         23dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742586390; x=1743191190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLiSZBXw08sW3O8VTxDohqYHxl9VVX6D5381MqASUjE=;
        b=DylTAKQgnJ+erKFG3uXDUl3vQAlNHA/YlAT4lIvNTBKDQdWjQ1bbHv9rj+cdQvMyNT
         xbvlWe2AiFP9VRMojAa0XOo1gQSfGo7EFH7WA8A6vsycQScg599Z+PA1YYMBeIJgicvX
         NOu5f8vxwvqA4vrO3OKI1JtkxfFoNzcvApwkYXb7Ye2o5D01E05vQ8yWUGCa6his0VGF
         yTuEC0bz58bOfb6C2LHbQSK+9dzLe6W94nYaE8dYFJlZLVxNDkRRpcW+0SBGEWaD19Fz
         H95lYzo0Wl+O+ckqu4DyHYmE6H/ZEH4SDEb+tRHv3wImJV3eCZObopDBhYnW6SOkRcAJ
         FKlg==
X-Gm-Message-State: AOJu0Yzhgc/G5sCgrKtrZU4e+JzeQVyj6ZzA3wTSrRGUohBww+BH7aCT
	+sfxWKSLKzpabE8AL3s6RIuWUOh8Vi9p+fbH04BJaPUpUuKD9KJE8a1gmKRWk2U=
X-Gm-Gg: ASbGncukbbY2Gyj6zc1J1Pu6kVqcGR4WaXu8mjMg9L4b10gJxQ/1ib8Ugt//e9cVFSD
	AVMSry1ANL8cfx7N61N7WOWjQ6kRwOqVl9nCW2RGx90FgmWSwkNZ0G/9p9pEy/ngbqRSuCjpDA9
	+rkroOM4oIEGD9KbkS9MtgFE1RCAqBBwfL188IZZCiEiQfiiGAe5KZJVyvgNIiHkg0AlQSH+nko
	lKz2+L3ZEFm59UDSskNulanilHLa8ERZ/oddZkAsTNCrPHDzmSfajETCYKWJmbsQ1VyMZ9kxscI
	1742qausmGyuxzV09W+u9vRpw54fOT914IBV2rNQUju2lDZBJ9e6fJv5IA4hOSiK7637wll/ZHI
	7axrl8OU0eoINcg==
X-Google-Smtp-Source: AGHT+IHDeFgxFUzFMJ1fk77UXlcVwj2S5+zjqgaKXwRSKd8iyE7880aWEFVhBInyW7OAcXcS+O9Gbw==
X-Received: by 2002:a05:6122:4316:b0:51f:fc9d:875d with SMTP id 71dfb90a1353d-525a852b919mr3882883e0c.8.1742586389534;
        Fri, 21 Mar 2025 12:46:29 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-525a7644684sm506312e0c.35.2025.03.21.12.46.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:46:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: MGMT: Add LL Privacy Setting
Date: Fri, 21 Mar 2025 15:46:27 -0400
Message-ID: <20250321194627.1729246-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds LL Privacy (bit 22) to Read Controller Information so the likes
of bluetoothd(1) can detect when the controller supports it or not.

Fixes: e209e5ccc5ac ("Bluetooth: MGMT: Mark LL Privacy as stable")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/mgmt.h | 1 +
 net/bluetooth/mgmt.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index affac861efdc..3575cd16049a 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -113,6 +113,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_CIS_PERIPHERAL	BIT(19)
 #define MGMT_SETTING_ISO_BROADCASTER	BIT(20)
 #define MGMT_SETTING_ISO_SYNC_RECEIVER	BIT(21)
+#define MGMT_SETTING_LL_PRIVACY		BIT(22)
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4fd30ba243be..c1e1e529e26c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -851,6 +851,9 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (cis_peripheral_capable(hdev))
 		settings |= MGMT_SETTING_CIS_PERIPHERAL;
 
+	if (ll_privacy_capable(hdev))
+		settings |= MGMT_SETTING_LL_PRIVACY;
+
 	settings |= MGMT_SETTING_PHY_CONFIGURATION;
 
 	return settings;
@@ -933,6 +936,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (sync_recv_capable(hdev))
 		settings |= MGMT_SETTING_ISO_SYNC_RECEIVER;
 
+	if (ll_privacy_capable(hdev))
+		settings |= MGMT_SETTING_LL_PRIVACY;
+
 	return settings;
 }
 
-- 
2.48.1

