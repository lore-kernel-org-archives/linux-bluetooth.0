Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE07A25E836
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206849; cv=none; b=ddNnvokIhwqhKwo3OcvfLkGEBUQ1j5Cau80PxEiolQmtZVofJfxPCw8AvVDnpRbpHzx/c0oeyYhMkTB989idoL5OGTEuRs1nTmhgx6HxXEgn0vY4qiVEKfnAToGQepcS8FpbTwhgak+qI9HsDPL6CnvxDI6lJ9tgw+bEYgGP+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206849; c=relaxed/simple;
	bh=YbWT+VO18iR/wuTDuBUb59lYB/46ai2U3Sounu1L/dU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=e1w8wpxc0y+R0jlGtbx/SxhaALKkeZkymRLRW0HyWC8QYAONUkCAHoNCHq/czZkIml8l7i7+BGx8gfXy3T70rgAH+KYtJrjjOu9LYE5JYzJLnVd143M0XRo+Qt1g0tm68/27OpXkB0cPI7nGKeOSxSZW17N6gb5el5yqmZVhgvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFzmYkx9; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFzmYkx9"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86dddba7e0eso2649624241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Apr 2025 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744206845; x=1744811645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lOPhE+XmfQUaWYoSuGO3WMA/AFw6ynG+nAmrbqC1jr4=;
        b=FFzmYkx9Pnw0r3XWMz3gaoEsPOzD1OeeApRl9Klqp3AtGE3VR76PpRrrMkVm5XB03p
         TfFU1S09A7Kw99SxZK3l2Iv3NRwPC2nhZ4zGA0ighJzjJXn7Rwfm1M0D14POIINOGYCK
         PKkPz+64x1lEFeHlj2h+pj/tO1hh32HOjKVEUI3Vk4twNz9ThpzKpEokC9yBJ5vI096O
         PGCPCk5/MWMjlA9WgfcsmhyI1nAQob+hkv91x+eH7JjA3z+C8OCoZV2189p8Y/5MUEQW
         tyD1Ki/1J/V/5p8n4XMYS+H2+7lCZP2ToE4M+SRxW/8Z7HIZNO4dVPh4pzNntVm8JDZ9
         X+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744206845; x=1744811645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOPhE+XmfQUaWYoSuGO3WMA/AFw6ynG+nAmrbqC1jr4=;
        b=FxJ27vV8SA+tcgtT5SJh6WvY/MHMrBCJiUuKD/6xLTVuOPE3JbPcxat12IdJyEX/yc
         ZPDto5uF+icdJavVtGk/M1zA14RG2BW6qgMxGLagewyAJnPsglDeA6odGeV5+6X2WWE/
         yjTJTtT58j1CXwr4JXd38H0q6S0eq6A30fFbvbzDotVaIKOagM27pm0cOUn+/elJSxf2
         LCxY2pcnnlgFxP8ww6WdG1quwiJsqMGJJzuKWrHGaN9msu69t04TIS6R8a9IYDidQGs4
         FGg9ZlkZhqarkT261Y3yBG3jalA2er5esdXhvsEguiSO1GvDyCCtqy8bEy3vq6p6ruy9
         X2xw==
X-Gm-Message-State: AOJu0YxfnqJoTqxlot74tI8sIBZ4anqsxIfkBE1TJDMQcmjHLbpgKdAn
	YViqiyfMbYgvvxUgj4yCeuLEFcgPfJ1AT08GtWZe3mZWyzzQLhwalx+mHw==
X-Gm-Gg: ASbGnctbEirHyXdXu9S6nhemFIKmos32i4f3xSguSTjMNvH2uo5QiI+Kkisw8Hp9Ajw
	nV9VYN6eu7AoqHDvK6kIe1gMNgVSORFx3+VAuu06fXpP7haZre3+OdMSdfU3Nyfmdm2WMrHQvak
	B0ZKcDT+eNQOYiHFRVwHd0OHI+p66p5JxMCJWGr209rw4JV1OZFcjLi/MdA6z2Jpvs2tPolJ6h5
	x3i4mDFlirLmYja1OUSgp/hvY5xdLNXzhcOm+rSanzlOexWlfGOKZ5dftJpt/iX+DRrXHx1lKNx
	I/aGQxfd3TRJPa4nT8TdgMM9pl+I28TrYZhg9ON/pqQHUbqpb6aB2GJJZrZRl2i19dANZ5xkRXP
	5hTzHau7VHQ==
X-Google-Smtp-Source: AGHT+IERHFGfyOGSX5KGOAc1vjTv//JH3jUSkW0X0/CKUkyL5w0e4O5A175BmmchPCaim/7Xy2uv8g==
X-Received: by 2002:a05:6102:3f9f:b0:4c6:d008:7349 with SMTP id ada2fe7eead31-4c9c447b61bmr2307193137.21.1744206844876;
        Wed, 09 Apr 2025 06:54:04 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c97641c0sm189439137.7.2025.04.09.06.54.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 06:54:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix not clearing cmd_sync_work_list on power off
Date: Wed,  9 Apr 2025 09:54:02 -0400
Message-ID: <20250409135402.212535-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When powering off the cmd_sync_work_list may contain items which shall
be cleared during power off as they shouldn't be run during power off
sequence.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 609b035e5c90..7a822ef71a74 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -648,16 +648,22 @@ static void _hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
 	kfree(entry);
 }
 
-void hci_cmd_sync_clear(struct hci_dev *hdev)
+/* Clear remaining entries in cmd_sync_work_list */
+static void hci_cmd_sync_list_clear(struct hci_dev *hdev)
 {
 	struct hci_cmd_sync_work_entry *entry, *tmp;
 
+	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
+		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+}
+
+void hci_cmd_sync_clear(struct hci_dev *hdev)
+{
 	cancel_work_sync(&hdev->cmd_sync_work);
 	cancel_work_sync(&hdev->reenable_adv_work);
 
 	mutex_lock(&hdev->cmd_sync_work_lock);
-	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
-		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+	hci_cmd_sync_list_clear(hdev);
 	mutex_unlock(&hdev->cmd_sync_work_lock);
 }
 
@@ -678,6 +684,7 @@ EXPORT_SYMBOL(hci_cmd_sync_cancel);
  *
  * - Set result and mark status to HCI_REQ_CANCELED
  * - Wakeup command sync thread
+ * - Clear cmd_sync_work_list if the interface is down
  */
 void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
 {
@@ -692,6 +699,9 @@ void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
 
 		wake_up_interruptible(&hdev->req_wait_q);
 	}
+
+	if (err == EHOSTDOWN || err == -EHOSTDOWN)
+		hci_cmd_sync_list_clear(hdev);
 }
 EXPORT_SYMBOL(hci_cmd_sync_cancel_sync);
 
@@ -5159,14 +5169,14 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 		disable_delayed_work(&hdev->power_off);
 		disable_delayed_work(&hdev->ncmd_timer);
 		disable_delayed_work(&hdev->le_scan_disable);
+		hci_cmd_sync_cancel_sync(hdev, ENODEV);
 	} else {
 		cancel_delayed_work(&hdev->power_off);
 		cancel_delayed_work(&hdev->ncmd_timer);
 		cancel_delayed_work(&hdev->le_scan_disable);
+		hci_cmd_sync_cancel_sync(hdev, EHOSTDOWN);
 	}
 
-	hci_cmd_sync_cancel_sync(hdev, ENODEV);
-
 	cancel_interleave_scan(hdev);
 
 	if (hdev->adv_instance_timeout) {
-- 
2.49.0

