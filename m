Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643501DFF8
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707299; cv=none; b=P2y2UGFUD9O0C3r7tJhO9UmC6QirzKOgrIG2c+iTAs/ckPddg3Z6K6Vb374NXImSfXJCkG3GeBfQIdtBHvI2wvg/zACe/9qwcyUZM5mFfBCm9ihsst4aksF8Obk0Co0yaj4ljL2BGhQtpx5Lnj+FAaL+vpgN8uV6pwYAdegO8Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707299; c=relaxed/simple;
	bh=+CO2Uy0lPHRIKGZvLp5lKKQeE2apXFkA06zcnfQ2rG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J2ehh4k6+oehxMX7dg0UZ6jRt5ZfGTr5C6HChKhXl4vRGiYMxte3V6x2JhxmG+Q28FOvO+/IC9LLeTn1V2i4RMUT2npNpvsEPLa0ph1HVRmYwfPHyALAZsfw9WKUtEaEqe8eL+e8RARp7d1ZlfO2E98pMEXcnKegHPa4RO8lrBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Otq8NTsj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Otq8NTsj"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so21967665e9.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 07:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734707295; x=1735312095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3YZRqjjUfgy2DA1rJGlqiXXagmbsLcsm+Hzdvqs7Cs4=;
        b=Otq8NTsjhgCQGyVahAk+mhVoirqmNxYXQg01aO/hcKuSYrMGAGODcq9hUbcbPJEAgT
         G0zhIaAan/gJQW82ZxdXdna90gb2UgqrdsBBuJ/wnhOJpa+wpBJRLfKqO3IjSjtsr3nY
         qcbebMJb8oIt0VG0JrTG/byXN1N5DRJBJ9S2LNylSlQhfEPwiQ5EOWEXsNzlITviwgyw
         BctDpUt7n/KtRJ9UDEP7xmPh11Xi5zm3S58V425Q66MEXSr/2ODhxsNk3DEpqUUbEkhb
         OkuxMMpKpaPPtowEoB8h1uxXmwx8XPvTiATCEuvYrr4D4r+632kM/flIbAPrEVplT3LA
         Qnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707295; x=1735312095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YZRqjjUfgy2DA1rJGlqiXXagmbsLcsm+Hzdvqs7Cs4=;
        b=Fhm8H7YOoUFTao0XSXn7QbtHYFhPEyGIzkZqGb/N2kJs2KRizQgxUw8qbim7iE0ANv
         J34r1Aa6VyJAoIYToDSrVGJGJO21bs3L3POEMpHjMk9TRg7opzw9/Y73gJscGZ1mN09X
         4t4AsN1ezEJ56j3yfOfVeH6+BkD6ytHxfrirQ8AjsVUjX1BZ2vPvxvR2RIluf8/wbTQL
         LTyLo7dMdMehlzC6I7buYxN2zOwjbJchrcOrMsM5b3x/lwlHbeAb6c89QmmhuQcw7Hwo
         PTQv+W5bmwyrDFRYQ8tE4IXJHHNE3oZTYGLn3/VjezojQDo0tcmIMkQAorTwFeFFQ+z1
         zaCw==
X-Gm-Message-State: AOJu0Ywf9FukWyRXx+i0Jc8eK6ONL7geqInkBl8Ybl2XWo0RKh99BNAv
	B5vjkbbPp818ar9dSPxHib3PlinBMGpKrAo7OIAqOUPiq5SIjRJVmrdGKZfR2wualQ==
X-Gm-Gg: ASbGncv5qZfaaWCua/Oh+YwlmjoP0bbxeX3v6+wC+fAlaAJj1+lOFKUvg1w0Tlu3f6Z
	At3MNtwZV9zipXOgcZQw9ZqSDcuGinXuVrXIm8afzgW1LO14/eCv1lQyHMPm7dw5KvrclZTTCEE
	IJFUOKH4+MhC933nZfU9flqx0LtTE+uAbnmWl8lfOglZPN2kJ2ap2yFT/WtAy95m9HXGfKfg2FC
	zLILWk8S8j334dpIyI5alDfu06gaU537wXP6Amp41NPPJ4mRcypxbFH5Kd6yhiojSaoQGTOL9Ix
	tlcZKBvDnf6PnmVOKqLw6ZmJj7aCyWr8C5xeaaqJ7d5t/R5BE8uKvw==
X-Google-Smtp-Source: AGHT+IHV6j/ABVdjrF5KJCTWiTL2m6f82GB7DMPRj1hqqjPWrY662W1eiU0Ic/R6gF1ABwCGVSauZw==
X-Received: by 2002:a5d:47cc:0:b0:388:e178:ddb7 with SMTP id ffacd0b85a97d-38a223fd492mr3430699f8f.56.1734707293612;
        Fri, 20 Dec 2024 07:08:13 -0800 (PST)
Received: from ror-bladestealth.home (2a01cb040148e70016160a88cade74c5.ipv6.abo.wanadoo.fr. [2a01:cb04:148:e700:1616:a88:cade:74c5])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4364b0532a6sm107099525e9.1.2024.12.20.07.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:08:12 -0800 (PST)
From: Tobias Daeullary <rorgate@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tobias Daeullary <rorgate@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add hwid for WCN785x
Date: Fri, 20 Dec 2024 15:07:35 +0000
Message-ID: <20241220150744.51842-1-rorgate@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch has been tested and pairing/connection issues with 3 different
devices are gone.

Signed-off-by: Tobias Daeullary <rorgate@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fa..20ba8ceff7d1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -377,6 +377,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3623), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2c7c, 0x0130), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
-- 
2.47.1

