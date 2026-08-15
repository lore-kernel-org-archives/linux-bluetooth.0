Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69D52EA754
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786791709; cv=none; b=d4Y8BrYNH+0Slb5REX3kZZMg1DGDsRwpdgeRmMZuHI6kKNlfFBadXypot51N3nWol7sIahatxItVDOn/iJpeO4HNJkHS+wHyLKyjSYEf4cRhCwoN3Wivb/zxSI8VAYc3szYQ+aZatVPsAcOK5A/YCAASC7b7jW6fpbMLzwAE9ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786791709; c=relaxed/simple;
	bh=b5LQIwGVpyvdNO/WfDgWI7hUw5OYOoA0sgu5/kZeQg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TR+Cm0B7NFDUIuE+WjnOQMw/tbr4/NZEdrcTlkRlMutITkcnRziFFVke7BGC0eKK3x+PEhUHeZtjVHhCE/nPBPyiwQ8dFi/NjpclQERzyqer+/k+/eEtYLP4Xh1ByJwv7ysPA0UIerh4h6XuWXv0WSHaVUa5B0+Lj5A4ZlkXxfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PD33yn7/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PD33yn7/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49954b88fffso21620105e9.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 04:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786791706; x=1787396506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9/9+rmVvmvs6s8dnr8ttRWG5a1oyP8FaGHhemcTL1GA=;
        b=PD33yn7/V8Rg9m4qaBE6Fr3fTo3JeIYd15yCFU7pDkX45Bzsh//zjYMcMmvXFE2cGZ
         PZvQZx4oaSn6jVkfVpeZhrnik2jE6uvZZUUeq/y+szBjkRW3EYmXWGFF/pJUDPNEn37O
         rSSFeoZooEu9AjhtNdlPKJDUG7viGhV8itJFRReymJ0+whDDHhUQc/Xbn66QSA1wPhwi
         3LSUlyV7gUUctKt3cHr6jC0Y+V/TxpuNkAdJKqKeCxWdj5wnemgRlkQDOOR7eF/JXNjj
         Gv7/TKCE0Wi72ehIlfGyLLY3DIri7Hgvp1kOXZ/QtBtM2CGV5naPL3kTnHhBKrSQd6UI
         GQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786791706; x=1787396506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9/9+rmVvmvs6s8dnr8ttRWG5a1oyP8FaGHhemcTL1GA=;
        b=OIrUaN1lJEEkNkRPNPYO0jDzoPQb7BdwMfvmQqSocry4dAaZ38Vhx5mYekxW7hN//8
         EeF2LaDMsJDSegLobE3oBXUaNLQ7UptvLhsxqwO+fTfg+G430Wb0s0bub023wT4fd42d
         H5O7lJTQGrIcZt0m2BEwbUIpGEvK16fxCtVSPpwplYhVamApjaURRfw4ROJwHxH5Am2u
         nlb0H9iC/F49O/kyo9ZPF6VPjGx5LlBVymu3BHe4fhIagU8aJVormoQphBiU8hRUUcaq
         LuHVgelFM2onh5xPuRXwie+JDyAXObVSJskviUiYKMQViRcJkoYs2bTKGNvYhZaq5ROP
         znaQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBRZE0LYCLaFzGvg+JcOjXdcBtUCW2jxH1wPUKuBc9bmTPSOiGhm40D5rxEJUCMzlf162Pf9AL6aXavSH+poM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFyhl7t7j8SZt0M/wz6RrhqnBcYadHeXAGJYtUVrWdkSZX3/8
	8EfEe8xYj1gHq/Q/2vcfJqff3V9KIyINK1ow/CN2pKSod40kaMbw6gmD
X-Gm-Gg: AR+sD10rpbCY786BDE1baqZBDo1tsW87ctl97563mgtrVHHQzLkjBR9hNnV5Hv6jxAL
	xOpQLPe7ZxNxDSQupTfhdRGkBZyZ04Liu1IDs2+cQ8lZHkVzJg4uEi7uAj/nZ6ns/2szCnsaxP/
	+03wDdpnzBCnOzTMutUtiEtrrpCYsaWkopC/lvJvOLK3H5rpAYhN950S2ODBWt2OuPkl5AiwsXq
	ItZGMeZUY9thsukNbyMRxr1b/n6Bo0XUHAf9WQ60Q/RkQ2Ag0XroiiRmNuRmMkuayQXv0inuTN1
	CeI5dY09ug+/uMzQezl3jlKVBS2Bj4of99B58lrkfexu1tLlQn3T1ICQuoTuHaZwayfgrpyAW57
	G9IJVep6R5aP0o9dUDkUvUTqAZGIMTvCCh/P+c19B3DHJ/Mty8gfNGFmGHGHENxjqCW/Gz9BZKj
	6p2lfMJcaUXLe4KVIiswp8mqaqE5B/EEv8TL3loV4/qYyZW5RUxLkVybUIGUV7vvw/UIFtEDBAK
	ZY9drNGVz+Y
X-Received: by 2002:a05:600c:3b1d:b0:499:87b6:f3c0 with SMTP id 5b1f17b1804b1-4998807e4c9mr165228545e9.14.1786791705919;
        Sat, 15 Aug 2026 04:01:45 -0700 (PDT)
Received: from archlinux.tailbe3ea7.ts.net ([185.19.153.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988b1d8f4sm133728035e9.11.2026.08.15.04.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 04:01:45 -0700 (PDT)
From: Ismail Tarim <ismailtarim7@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Jing Cai <jing.cai@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ismail Tarim <ismailtarim7@gmail.com>
Subject: [PATCH 2/2] Bluetooth: btmtk: Do not discard the subsystem reset timeout
Date: Sat, 15 Aug 2026 14:01:19 +0300
Message-ID: <20260815110119.11301-3-ismailtarim7@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815110119.11301-1-ismailtarim7@gmail.com>
References: <20260815110119.11301-1-ismailtarim7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the MTK_BT_RST_DONE poll times out, btmtk_usb_subsys_reset() logs
"Reset timeout" and keeps the error in err, but err is then overwritten
by the return value of the following btmtk_usb_id_get() call, so the
timeout is never reported to the caller.

Commit 25b6d7593a3a ("Bluetooth: btmtk: introduce btmtk reset work")
discarded the return value of the chip id read, so the function returned
the timeout error as intended. Commit 3dcb122b3064 ("Bluetooth: btusb:
mediatek: return error for failed reg access") started assigning err at
that call and silently dropped it.

Keep the timeout in a separate variable and return it, restoring the
original behaviour without changing the control flow.

Fixes: 3dcb122b3064 ("Bluetooth: btusb: mediatek: return error for failed reg access")
Signed-off-by: Ismail Tarim <ismailtarim7@gmail.com>
---
 drivers/bluetooth/btmtk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index dc702c0a6034..c0ed51567ed4 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -860,6 +860,7 @@ static u32 btmtk_usb_reset_done(struct hci_dev *hdev)
 
 int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 {
+	int reset_err = 0;
 	u32 val;
 	int err;
 
@@ -958,8 +959,10 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 
 	err = readx_poll_timeout(btmtk_usb_reset_done, hdev, val,
 				 val & MTK_BT_RST_DONE, 20000, 1000000);
-	if (err < 0)
+	if (err < 0) {
 		bt_dev_err(hdev, "Reset timeout");
+		reset_err = err;
+	}
 
 	if (dev_id == 0x7922) {
 		err = btmtk_usb_uhw_reg_write(hdev, MTK_UDMA_INT_STA_BT, 0x000000FF);
@@ -973,7 +976,7 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 		return err ? err : -ENODEV;
 	}
 
-	return err;
+	return reset_err;
 }
 EXPORT_SYMBOL_GPL(btmtk_usb_subsys_reset);
 
-- 
2.55.0

