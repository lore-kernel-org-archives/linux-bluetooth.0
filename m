Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BE629CE1
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552149; cv=none; b=XSsOC+rpAS73zBAn3AXj5P8Bk+mb6Ql+mzP8RRZAq0RlL0MUuNla1Ey4YLkW93yGC1v/aNZo37Bm0tIe5Y4LNMnUSJeACc4TUmX+YoyqBlpwXCVlLYmvGCdjUFrCos73tUTArpdvqhhM45Sm/J0mJHjztgrr7b9j2M+Yi8Vv2dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552149; c=relaxed/simple;
	bh=ovTpBhqWDgvd4Z8acSYhPfkqSmpGDTnVqDQV28URe5Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WEZ+uJU8kUrPLK1encmR937lojBqYGJAM/0fosoJqonOSinHJpGh4BKUG0loadwqsBcRfvoQbTz+s7TvclVRkdBn8zSg/kRnoJGuKjhftRbFlKW0YFNRbyUo3nQPHOLN+3RJ7OWhK8XwVQ9CqpQ4PLvdgxlWFoZBbdwsfGSWT94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3a3jkU4; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3a3jkU4"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d38b84984dso1348496685a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jul 2025 07:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751552146; x=1752156946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6S5dTRQsRKDllwRj3mHYdhutkXNZvtHjcwLDPll3r8=;
        b=Z3a3jkU41pTTnmnGp7ptm1txHOtEvCgEsx3nbiXZkjcUfiIPEbozAaeD7WdhnpsBal
         DGedMGJwwvz1Cc+kR4gVePX0joGlvxOfZ6pHm0cVSycOFlElpO/Y+lYRL2y5ZvJbaVJ7
         cSlqtKjuTZ8k6fXao5IZpABlD9SfVO3IOEWTNhpXMDu5P48MS9Ea1qe+z8RHcFmOJGX4
         C4NuTaU6UWRZUkbQ3gxrsJHFgi43N0ruKm0R22p7C5gsPwArDtH24ZcZEOXvOMTv/2zO
         DwL73Hx2U422277qfez2QWJ5LtNBWgdJKIo35s5ic8J+IA+G84mIcMC0Bbcdqrh7jLe6
         n4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751552146; x=1752156946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6S5dTRQsRKDllwRj3mHYdhutkXNZvtHjcwLDPll3r8=;
        b=kDvEmF9jR8vI3LZ0Vp5m/RaMf+fRKpUv1MKgOcm545Xi5Fiwuv2SUEl9KxdiumWvV4
         B3BmsYdzpOmMoCqqjm2ucfjhc66fYkttuxgmi1kmn1sdz2dP/RMMGSvJrS/idEDq4oma
         gvBw7gsBWvyECuONjggqps9uc++k0FkWm+6O90g2oXWSiiXNZipEy6W7bOzJrLYjBitn
         4snUMeEq4aHvMgdbyo/NxcgljCv1/fx/bejG4AmsV+fKyq/cx0r+uSjnd9VTAxCvsA/W
         QN+P67C3XLqzhtdIbVDOKSm1NGLSAUeKC9YnSXIduNTwLiNvB+D/BrokrDmV65SUEBWJ
         OhhA==
X-Gm-Message-State: AOJu0YwS1MumY/dIGHyqa5wg5PL6hH6GgPDdjYUfP53mHGzICG92oSdV
	BJb/0l3G0Y6EYMK1A0tr56Rzd8SuDUiGuOgXI2wSdhKTCe324bO1Cu6YvfFf0gH9X98=
X-Gm-Gg: ASbGncvoPCyvzApQrLRrnbjFs2NcxVphM/veOXMFqLcoNzIOAXK/JWEuYXxhCl+8cJD
	k8l1T5I0iv6LZqFZzq/fT3wzX4no1ph1XeESeGAWvrRyeto3BWdhzhARVpH9KA8QZ2HS4Pm8efM
	25IzUuisyE2JnuZHfcsoNb83LLzI90jy0/F/qVTpIUajIUnHZr8cHKwfChxxSVESGSmpRfjmOzr
	1Smkdg4Vsg0bffaJy93crIGz4Py2AlKg6xtjLJcCX1wtpKCP1rheNS6cZx7HsqTJbYU5NA7v7r7
	Ii34/PAChj7BuzndJ7/aIJVBsmsRMJYXqpdIMkOwtJs6cofvAIejgv1+EmSvIFni9UyyqqMdqeX
	Pl8lwG9x92PTS9EqAGARJ4Zv6n+48sleXpHGeiXaEtA==
X-Google-Smtp-Source: AGHT+IFOKruXr45UGASqnnp2niqOyuAes1DmRrTSYseIL/iLayndYCJLeqTsEekhWZKOTkF48Y58MA==
X-Received: by 2002:a05:620a:2588:b0:7d4:3de6:b4fa with SMTP id af79cd13be357-7d5d13e0369mr539607885a.20.1751552145711;
        Thu, 03 Jul 2025 07:15:45 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4ee4cbf232csm2149988137.25.2025.07.03.07.15.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 07:15:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix attempting to send HCI_Disconnect to BIS handle
Date: Thu,  3 Jul 2025 10:15:43 -0400
Message-ID: <20250703141543.1726566-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BIS/PA connections do have their own cleanup proceedure which are
performed by hci_conn_cleanup/bis_cleanup.

Fixes: 23205562ffc8 ("Bluetooth: separate CIS_LINK and BIS_LINK link types")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ca57eab15169..92a24a82a03f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5493,7 +5493,7 @@ static int hci_disconnect_sync(struct hci_dev *hdev, struct hci_conn *conn,
 {
 	struct hci_cp_disconnect cp;
 
-	if (test_bit(HCI_CONN_BIG_CREATED, &conn->flags)) {
+	if (conn->type == BIS_LINK) {
 		/* This is a BIS connection, hci_conn_del will
 		 * do the necessary cleanup.
 		 */
-- 
2.49.0

