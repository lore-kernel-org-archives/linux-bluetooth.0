Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79739F9EC
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 02:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734660597; cv=none; b=m3AGVNyJyX53s3EfwYnFqxHLcnfUFNtrdy5xxrRWTFkBQBDoDJ0WWcjJO/ZiZUF5VA27KuGL7Lm5QWtp261cW0H/EE9mTjjhWG6fpW5c5gHyKWgVeusoHZVgvUeptsQe1CgH97quOepugCuQpy9Wjlqwv41JtBPmF/DSYhZA4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734660597; c=relaxed/simple;
	bh=FylqBmX/b1BNZvzSDAN3bTi53W2uc0yp9p59+AEq1Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sX7NMe8FtND1Ds6noQlefqr8R3wye7Twd+TxQGw61NwkWHMe68R02Y08wJyXR7pdExPbAwMALkNQv7pRfS0KJC1WyW5LIiS2wszi8HcZz5gb2aYnTxDBCOyEygmNdKfH/R9p9al5iCoPAB8qrUkAtXPMZlLbV52RyzT2i/w4KhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkwrqtvZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkwrqtvZ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43618283d48so10478745e9.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Dec 2024 18:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734660593; x=1735265393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZI68SFl4aDcR6r+EuMki5FUlyokMfYJegceA/sBRXa8=;
        b=ZkwrqtvZbf8zFqK77rUZZRko71KOQaCK0puk3dyQzDBcOwgkQ/QuemEpol7CSsV0VR
         /hQfkKHgq1e0bsRzthd/SlO2GNoLZjpSbNpwmNm8Ymq9eNBG6puzQt6SFvIMFkESEiRE
         sjGVE9c7WfKIHUqUGM8VyDTnvNslI6/KJFTJY6iDrTkp/laInDwEh4ww0AUb4C/eXaHS
         91I4w4+NxijrotmjrohQrNXLzIeN3EC0vnzpX76N2lCgH0mEPVa6Y6sr+4AhCVk9jFEW
         O3Hrd8A05QTn77JPF7/ukE4m8NAflF6TD7iJhDuYfF12Z+1zTlTltxqkVHKr3UEESXqA
         q6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734660593; x=1735265393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZI68SFl4aDcR6r+EuMki5FUlyokMfYJegceA/sBRXa8=;
        b=E7zVHrHCQfuj+4uXip6RMYGr0gMDOy6kP0b78zwEcA2tYXBHw4IFZbG8Tao8jiD2nr
         CeW8vnLBbXx3joHZ40qKbze8Mr2l+7dSrlT5sVZarzKVfOYw/BDeQSu0MRTaK5XRJ0gN
         fOZt9YnXbdog8+BQqbpVDBM3j1l62oParcMsQRcySVpW8ggbpC6bw0+6p+wN/l/OSmy2
         0HOR23H7iIebF/G5412yIdTDuuY6mAX+Xx27+fJ+0oBXN5BLb328f9j7jsPDSYq/Et5i
         VmhqSuOrnIZApcg1hcFgvzB73yBEpQF+bvq1mk97qRbFKf9DRj85skZ+52OUzgkeBBiq
         r1Vg==
X-Gm-Message-State: AOJu0YxADVsf/MgkEEWAi5aYPLOKJRErvWbaVlh1E0C74IANNKlRLFyh
	ASpYE+ZMyN/Cvbj/aFfiSqCCy6zUiGwLOpJTZOraCkRlc3OG5qoqRNvbEiXV
X-Gm-Gg: ASbGncuYa8z4aDLqjXa6oKBVSCL482ux/c84q3kIUVYj0j+EbFTWLuKPWSNVhTgWNWM
	vjmzXDYwqr+N1lJ7z1sr+oe+2WBfi/IgU3pStZNmMrTFe7SRxhZC7kGiu/iK6TXYVVe7nEASl/G
	EcgVHjKIm2aECs8LgOG2nH2c5g6xEWdje/Nmkxq3PYIRqv/oQKqat6gReoeXpqX1esExOM0sm4O
	mGI9++EAK0AJ6Q2yRLLsWDcwJcdBCE/bPuO6itBj44yUudCt+he6Li7VocW+84t2b+XKSXm+0Zc
	12/vKtBpnsmS4mbv0RO5NAND
X-Google-Smtp-Source: AGHT+IG1F8fOV4bSGpxDENVs7jYS5IThM3vrQR5MmrKlqfisa2AanzuCTXgN6/Ce8afU8gR1S1RreQ==
X-Received: by 2002:a05:600c:35d2:b0:434:a929:42bb with SMTP id 5b1f17b1804b1-436686464cemr7931195e9.18.1734660593243;
        Thu, 19 Dec 2024 18:09:53 -0800 (PST)
Received: from localhost.localdomain (33F121a1.skybroadband.com. [51.241.33.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a379d69sm88027105e9.0.2024.12.19.18.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 18:09:51 -0800 (PST)
From: Kieran Geary <kieran.r.geary@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kieran Geary <kieran.r.geary@gmail.com>
Subject: [PATCH BlueZ v2] Set `SDP_LARGE_MTU` flag for DS4 Rev. 2 product code
Date: Fri, 20 Dec 2024 02:08:18 +0000
Message-ID: <20241220020818.478090-1-kieran.r.geary@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CABBYNZKSKtzo6=A75pO4McbpC=qVXhniY=P4yBqMJAOJfxboGw@mail.gmail.com>
References: <CABBYNZKSKtzo6=A75pO4McbpC=qVXhniY=P4yBqMJAOJfxboGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iterate over a table instead of checking individual product codes
---
 src/device.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 2b3d19f55..09121e1b9 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6038,7 +6038,12 @@ static int device_browse_gatt(struct btd_device *device, DBusMessage *msg)
 
 static uint16_t get_sdp_flags(struct btd_device *device)
 {
+	size_t i;
 	uint16_t vid, pid;
+	static const uint16_t device_sdp_flags[][3] = {
+		{0x054c, 0x05c4, SDP_LARGE_MTU},
+		{0x054c, 0x09cc, SDP_LARGE_MTU}
+	};
 
 	vid = btd_device_get_vendor(device);
 	pid = btd_device_get_product(device);
@@ -6047,8 +6052,11 @@ static uint16_t get_sdp_flags(struct btd_device *device)
 	 * results in SDP response being dropped by kernel. Workaround this by
 	 * forcing SDP code to use bigger MTU while connecting.
 	 */
-	if (vid == 0x054c && pid == 0x05c4)
-		return SDP_LARGE_MTU;
+	for (i=0; i<G_N_ELEMENTS(device_sdp_flags); i++) {
+		if (vid == device_sdp_flags[i][0] &&
+				pid == device_sdp_flags[i][1])
+			return device_sdp_flags[i][2];
+	}
 
 	if (btd_adapter_ssp_enabled(device->adapter))
 		return 0;
-- 
2.47.1

