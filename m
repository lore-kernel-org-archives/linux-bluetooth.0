Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313693;
	b=Xy7Hs3w5MEFbdCfYQlBQxW/vbUQHyVxgaOpKr5qa9vDq97B7ZmZFxAdRxK8wE0+i/lg8
	 4QIgWKbHWwqm1XLWYwrtGjWPXSf2zj9PagpmpFLZ/WBn/BI749mxY+Rvw1x5n48su3VLF
	 7z/x5GTKRoLZdATwr1xYd3Ovhomz4Y9uvUNzbPucHigIIPcBMz0JTh/EZ66v+FqTDYVAW
	 ULL9f65FupWrz2roTykER4tV3U49xARn4T+r0rb5JpUXQhZp1sRpw2zO+YKsFuf3Wr6lC
	 ICWFFNS9DpyRmYpFL13PthkMIzUGPmnDjqplytb00BQGwMLzn1cJesI27EmDTaINUiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=p/lNXcmee9ZNuCiy3sE8z9e8aCfdm1832qnUnHax1I0=;
	b=Ze/RLF4JGWVgndbNVHLdsq7Fo53dZVxAHQy5gu7ozYYobjxnCThQnnZu1BkL8k46m9Ei
	 4/MrRFhqzRbEGLM9pq2nVYyeiJY01itBfJkzTpIvBMoLyer2OJNtEXb8zA4gLd4GwL09e
	 IsArbxOWgbsSfQh1UGZrzcCqdYdt5BKgb5E8XQkjKt1Mk9g5Ldp+y5MEh6SEOdaUW0Pnc
	 CUnQAvSfQHnWTcRl8smBxOlQ710zxzd88VyTooFm0IC+Wf0E1nyQufnCzCOAUWByvg3R/
	 +mZCU0FM4UDHRhqSFS103VspYSHXzsF3u/4P+O8+wqGmWFfoDJOR83pjXTH2h/4Z+Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NRnDXfc1;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE81606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 22:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AE81606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NRnDXfc1
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so307055e9.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 15:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793313692; x=1793918492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p/lNXcmee9ZNuCiy3sE8z9e8aCfdm1832qnUnHax1I0=;
        b=NRnDXfc1L8HQiAoUUSzdXBA4/kU4JeA9BUmhutMluOoEVVN0mQ5ivfmXdTE0ciz/Kn
         eY2juSG1NXxDge0BX+ORHnccDpFU0uHSxRwmEUGCOoqxn9tUIA0QQo0AHSEgvvpmfD3o
         RBFUtfQb6ZDcKxdiRJVFMSI4O7lpsit0zjtJdJmOsCXcNhc6luJA3csWO3yF7cweFhqK
         AKWlRWGBMn3CXeDiIewZbpRohp7JLpLvwD4a1DpMAaL9Ug40uxzQ8YLtapZSC2D21bR7
         jZOaG5Vc0tfotegSFdGg72LDCxIY0PXHKIVfMFp3BRbwAMyDHCNrxhlyY3YDTt6/2LYQ
         PQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793313692; x=1793918492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p/lNXcmee9ZNuCiy3sE8z9e8aCfdm1832qnUnHax1I0=;
        b=e9xNiIo877zGhC/flWufSCMo19MOfpRqovV9UkL/TuD+3aRNFw9rdIeCrfVFa9YKQV
         fMSIhC2XFQ3+Ik9ZknS6Pv6mHKJBQ4Pc6TMS7rDfX8bF/CsedZebQhcKuqozhUJhdlr9
         Dtw8nkkQMbcIASkTpX9cB4SkGsbP3sYDv3IASljOJqWEiJQXUvjaCkXnlkmyxH2pn1cO
         UrniMh17lvDhnpCqyGqhHSxFj/TnZo7LSkiPGagsAL8q9LP//kZ3HSZCv1V3jmJgyoyn
         rWIODDkfsiTCudKuUKEIEl2sXo/89ILX7ilyKwyxy78iVTQviVCOjzT95Wn1MJ4ISdQh
         YNpg==
X-Gm-Message-State: AFq9FYI7vSTqqA8NZAybFHD9YIF5fFseu/NvKy8C6uViAFq55tnM8bWq
	xVdoYSXHZtp85h0Y5mtXr2veZWDAF3yvW2WU+/Gx0MKKygHZrXDxb3zj8296TRslc20=
X-Gm-Gg: AYBFou17cLMR54PLxTyTOSoj6e6hkxc8Zt5Sannw0P88bS+ImnbEiX8vhDPkzflQ73a
	8gEfutDlTgpRZlRPfjuV592X/8kBY8qPopWmFjq5AUKFxXEhC4SKC+yN8qhXieptlTbBsOMVgNi
	5YO1swnAEMpuNkw2v964A9hBIfS2LAuc0VzJHUOE1616TJGrheZdo2gNEj2n4CMNgd6ouzfJXl9
	YtuSpMVaWTdLe+mMX3n5pbjLm6VwJR0OVi32ug7t7j8brgmGfI07BJfmIWYVW2qMml2TaY2lCNM
	ZRKBGBWsNO2e8aoLgafgqnOSoVHsnvsnaVYyxFWAcTcZTAMoFqVMKvdZvQK3221l7nDfByd2Wbc
	pv7tTZkX1MLuj7HOkFDfbiYTik2cHd3UQhSbSK58xJrig84MCx0fVlzASibX9zCG/n4mU9bl//y
	5UCa30hr2a+SSwcKGd10E5u8Y8i3RYTqB0/lb31yOVPXql91Cx193LgmVtVwkg/3iyMtlecGSTK
	obZ+KqKq276k3WKfzHlN4E4R57ukBZWvBMoDGK5NqgPrE6qcyVYkksutjxRhm0UhvG9c2j7naN4
	6gUxDMa1K6jJETsa83GSkpwygPTb18/BFXHeW5zm6gTz3IjAAdYfTPp6o58Nxmyk+ZLCQGT6417
	sHDzcnkts9eOHD0L8ugfuDQTqxq4C9aOphh0iZ/ypj+DLNfPf53YNB2IzcyO7uRjFHpgZ8C5E5h
	QAhOwzg+f9sDFR
X-Received: by 2002:a05:600c:811a:b0:4a3:5d5d:48d9 with SMTP id 5b1f17b1804b1-4ac187a80a7mr6995185e9.35.1793313691567;
        Thu, 29 Oct 2026 15:41:31 -0700 (PDT)
Received: from archlinux.tailbe3ea7.ts.net ([185.19.153.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f322c46sm89557405e9.2.2026.10.29.15.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:41:31 -0700 (PDT)
From: Ismail Tarim <ismailtarim7@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Chris Lu <chris.lu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] Bluetooth: btmtk: fix error handling in btmtk_usb_isointf_init()
Date: Fri, 30 Oct 2026 01:40:15 +0300
Message-ID: <20261029224022.1233751-1-ismailtarim7@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btmtk_usb_isointf_init() submits the ISO interrupt IN URB and then
sends the vendor command 0xfd98. If that command fails, the function
returns an error without killing the URB it has just submitted. The
caller then leaves BTMTK_ISOPKT_RUNNING clear, so the driver treats the
ISO path as inactive while its RX URB is still in flight, and
btmtk_usb_suspend() skips killing it. Kill the anchored URBs on this
path, as the URB submission failure path already does.

The return value of __set_mtk_intr_interface() is also ignored: a
failure to select the ISO alternate setting or to find its endpoints
is logged, but the function goes on to submit the URB. Return the
error instead.

Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")
Signed-off-by: Ismail Tarim <ismailtarim7@gmail.com>
---
Tested on an MT7902 (USB 13d3:3579) with 7.2.11 by forcing the 0xfd98
command to fail once with -ENOMEM through a local test-only module
parameter. Right before the function returns, usb_anchor_empty() on the
ISO anchor reads 0 without this patch and 1 with it; the rest of the
controller setup completes in both cases.

 drivers/bluetooth/btmtk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 6a48ff0192cf..1b3dab0d10bb 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1741,7 +1741,9 @@ static int btmtk_usb_isointf_init(struct hci_dev *hdev)
 
 	spin_lock_init(&btmtk_data->isorxlock);
 
-	__set_mtk_intr_interface(hdev);
+	err = __set_mtk_intr_interface(hdev);
+	if (err < 0)
+		return err;
 
 	err = btmtk_submit_intr_urb(hdev, GFP_KERNEL);
 	if (err < 0) {
@@ -1753,6 +1755,7 @@ static int btmtk_usb_isointf_init(struct hci_dev *hdev)
 	skb = __hci_cmd_sync(hdev, 0xfd98, sizeof(iso_param), &iso_param,
 			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
+		usb_kill_anchored_urbs(&btmtk_data->isopkt_anchor);
 		bt_dev_err(hdev, "Failed to apply iso setting (%ld)", PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
-- 
2.56.0

