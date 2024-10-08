Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF47BDF71
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728402012; cv=none; b=QjgE4ZAL1RNISfmbF/V59kKOESWd8Ptj1q0t+Ed7C4sdP0D7XFbv5iSKCdFHR3LboYIdexflYPwcAuDgJUhK/GSinFUFgkjg70P+b1OQC5RwrJWUULyQ0jkRKBb9qztwKJ5EKKeYJFZm9COJTvs/aa+eh2fBrTR5qdj0RlS0G+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728402012; c=relaxed/simple;
	bh=jUHoZGkGaxBT8v+3/9MdtDgpCNLHi7Vr5uyPNKM9nAA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LfueYPxDecCqXKPPGBdeaxqMZVRfIAQOzldtBxCGu4x2RSS3KbeBpLerM1x0W8mcU7hMlQ02//bRN/ETqX01LjhD853AjTj5SiKEPoN1h8LcWgUuChUPAkO1LpV96HLtrSiu2btdSjI7w+G4cWVuge1442eG/A7dP6hEDu0rWJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YC2NT/Uf; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YC2NT/Uf"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4a3b679ac52so2138265137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Oct 2024 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728402008; x=1729006808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1kLsX2zDToJPylaSgd23OgKuqqKeZ948/+QeCTz0rho=;
        b=YC2NT/Ufb4h+0wxuIBFuA0ywh7mqnO86LhQXE1GCzGYBSxQj4HUhCSO5KNhuCzcv/G
         05Oe+wCyq4fK/54Vuf7EatbPnP1PJPp8uJ9qoGLHQ7YXW5uEgDZewepye3DAkv6vl+lc
         G9EtC/hjkE/CXgCfewkNn8qDO3EGcSPUp6YnXhnMOUmpH6GLbE8abZqgFW+iCFiwYy75
         1kq1X2fAd2AtmaXspY38NzaOqufNPFXnEVX76FfQXjWHnSUgCnR0+3s7c9f4WdHhrN70
         SzWgFopeZEisRdYmOZeiLimiSsL0Sx1h1I/9wrtmfzEeeYEb/jyo7f7GaV6HuNbiKAp0
         xYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728402008; x=1729006808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kLsX2zDToJPylaSgd23OgKuqqKeZ948/+QeCTz0rho=;
        b=xN2bon4SM6FDxJhFpj7PbD+b3TmPcQHWj3jA1rP8XF5CrXHLC0RS19hj4qmimksYPu
         +wwcQLVro9ydr5HhbLq1KfkZcBvXuVwE2yFYftbC+FQT5Y0pnCaIs0sShLy8ZryUWjxE
         ukse7yrYycjeH/bWOg/5JbQk1DF3r+aSkcrX4VS0XOkr7N8HUgtBWQRx1iqWM44PH6zs
         DMCkJB016DNQamgYFhGrflC5AGaRQ7+j+Fp1Lzj5VbZLKtNjpMO1nw3VdtvaC8hgrLYZ
         /wf77Yg76yu9N3HAA44nkh85FlLBhIGMCOO2UGfA9qnyg+qwGnosksGcvfozsBk15+UH
         YXWw==
X-Gm-Message-State: AOJu0YwkoiSdY8EJGVTtUT1cvT0ctP+6hsHG0o+JcagCAZCyC34WHqby
	uIEdn3kzkQmoGREO1IhV1JVBNfzjOf8lT7fjZrPUjFHlaICu549kLG+TdA==
X-Google-Smtp-Source: AGHT+IHEEI3rPZ5pUIPtHRIJFTVmtYuTI5NC6evyxkxgqN0Zz7EDQp8NobfyOgleVQX/Wn7T4vQIAQ==
X-Received: by 2002:a05:6102:3f43:b0:4a3:d215:4269 with SMTP id ada2fe7eead31-4a4053f2995mr12422077137.0.1728402008459;
        Tue, 08 Oct 2024 08:40:08 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84f95e3f19asm374840241.8.2024.10.08.08.40.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:40:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/2] Bluetooth: hci_core: Fix not checking skb length on hci_acldata_packet
Date: Tue,  8 Oct 2024 11:40:04 -0400
Message-ID: <20241008154005.595169-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not checking if skb really contains an ACL header otherwise
the code may attempt to access some uninitilized/invalid memory past the
valid skb->data.

Reported-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com
Tested-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6ea290ba76d8c1eb1ac2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b2f8f9c5b610..d5f917076e0e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3765,18 +3765,22 @@ static void hci_tx_work(struct work_struct *work)
 /* ACL data packet */
 static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_acl_hdr *hdr = (void *) skb->data;
+	struct hci_acl_hdr *hdr;
 	struct hci_conn *conn;
 	__u16 handle, flags;
 
-	skb_pull(skb, HCI_ACL_HDR_SIZE);
+	hdr = skb_pull_data(skb, sizeof(*hdr));
+	if (!hdr) {
+		bt_dev_err(hdev, "ACL packet too small");
+		goto drop;
+	}
 
 	handle = __le16_to_cpu(hdr->handle);
 	flags  = hci_flags(handle);
 	handle = hci_handle(handle);
 
-	BT_DBG("%s len %d handle 0x%4.4x flags 0x%4.4x", hdev->name, skb->len,
-	       handle, flags);
+	bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
+		   handle, flags);
 
 	hdev->stat.acl_rx++;
 
@@ -3797,6 +3801,7 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 			   handle);
 	}
 
+drop:
 	kfree_skb(skb);
 }
 
-- 
2.46.1

