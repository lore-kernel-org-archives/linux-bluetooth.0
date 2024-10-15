Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEDF1B3930
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006382; cv=none; b=VMr+Q0jPgcRdowj6o4LGMRps3UQ6/LraPHaYjhdG1z2BkXuxJGs5toCISh7cQ7WOlPss+Al5A7jOk9rnx7PGMyiQumKxLJb8CJUOUr4HsqtCDiAEU4nQ+0mZ1O0Y7rvXY9lpeFKzhpAbSjGjUqDVFhnRVcTnxpG0FvRSSORI0Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006382; c=relaxed/simple;
	bh=RmiNuVzaI0VkgxtLfAQzrK4x7HWoDBJSkhNQj4+nkFE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sDj1GO6IWJK9uD/54xXade9kCiCvGtvLrPbhf20UBS57O7UHClk2n5fXAqsav9JUyhGxm/CktTm1B8VDEu4z+Jh8WM1knOKy9epH+U2/Ek1yHKC01tCZ5KXYu2Y9Nqjg0vVnYqHD9EioQxG5ENXc28CSl5ftR7JejR3FzEw+O3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4Xwi25b; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4Xwi25b"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e290333a62cso4782367276.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 08:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729006379; x=1729611179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GoFh4LVqE5Lcj1tIPh/PkPmcdaK6t0eKPhDTwMdBb5w=;
        b=G4Xwi25bQdggmUzZHr63/ott8m4iWan6zpyasBynvvzzAcC9LeKG67+DAr12aicRLQ
         J4qo1/8F5qU73rOkj/AstLGKmEEpgexWiNpcTpwv0cNoc9y0GrezuKA8OgUmQSXeGIf6
         DCXlkLQpKRfDlr2RqVUjWKA9wqIzGGSck60PYnzJAfAcU3SbgOGSeU8U5sODucClYkA8
         I4DoEls8xyUMnKAZK1j2V6ZralWb6VyBsdRAhIl6Hyl7P7HQoIBB3PmVAnhnZ2BBVT/G
         E++EgVdfwJzu/gqS694P6rFHmx54xl1B4y9JOaXU4yhakD0B5Pn+Crs6GEDb5v5YVZXf
         01zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729006379; x=1729611179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoFh4LVqE5Lcj1tIPh/PkPmcdaK6t0eKPhDTwMdBb5w=;
        b=Kd3a/q+gW2FZB/EXJZ1LJlA3D8xAtHJzmQsnLuaYyVWl5mDLxdsGZk90L35cTvaelw
         ZjVLUpDNtzBVgkmKx3rRfY5kLgoTv+LdhK/GNzeWhp/1KH0c52oyb5vbUOoHDYXTo8Qs
         UNIHvVE2f2ku8jYS7tf9EPp/YgmiJ0U56S2iZ59vuSSo39W/1STteyboYSUMmngAxWGh
         0dwt5U2LZ/FyPXgmFV918k7y15suz9ou5JK9XdqrFQYBXq8NK/VrPoezqan+ixnZQbOV
         6GFa6nsI2dyMHLTVFrzNiktr7kk/AtngZ2ognCv77QRLe5YtH09jzkziotuMLTPUGTw0
         MZWw==
X-Gm-Message-State: AOJu0YwYXzPSyXB9fdtE3bfuT2rrm2tlcquYI4nm0/UyxEh1cWK3x7eR
	gv/L44I+a535vnsWwIJjCQSz8htdXsfSFUlTKbcLySpbLv468tVskPdMXA==
X-Google-Smtp-Source: AGHT+IF4trwO6bu5/uVccsxHrinQ4gfVBY6oxdMi646C/tnU7Sv5WOwqQs/d9sssEr5hmFm64rxZ1w==
X-Received: by 2002:a05:6902:1243:b0:e28:f322:8f97 with SMTP id 3f1490d57ef6-e29782cc52fmr749839276.11.1729006378969;
        Tue, 15 Oct 2024 08:32:58 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296cbfafc1sm265792276.8.2024.10.15.08.32.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 08:32:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: btusb: Fix regression with CSR controllers
Date: Tue, 15 Oct 2024 11:32:56 -0400
Message-ID: <20241015153256.496688-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

CSR controllers don't seem to handle short-transfer properly which cause
command to timeout.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219387
Fixes: 7b05933340f4 ("Bluetooth: btusb: Fix not handling ZPL/short-transfer")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c0b6ef8ee5da..f72218c1037e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1366,10 +1366,15 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	if (!urb)
 		return -ENOMEM;
 
-	/* Use maximum HCI Event size so the USB stack handles
-	 * ZPL/short-transfer automatically.
-	 */
-	size = HCI_MAX_EVENT_SIZE;
+	if (le16_to_cpu(data->udev->descriptor.idVendor)  == 0x0a12 &&
+	    le16_to_cpu(data->udev->descriptor.idProduct) == 0x0001)
+		/* Fake CSR devices don't seem to support sort-transter */
+		size = le16_to_cpu(data->intr_ep->wMaxPacketSize);
+	else
+		/* Use maximum HCI Event size so the USB stack handles
+		 * ZPL/short-transfer automatically.
+		 */
+		size = HCI_MAX_EVENT_SIZE;
 
 	buf = kmalloc(size, mem_flags);
 	if (!buf) {
-- 
2.47.0

