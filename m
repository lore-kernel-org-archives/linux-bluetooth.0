Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F376923C4FF
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910992; cv=none; b=U9jseNCtl6tjsp85BKuY8JNQEV+VNHI89FgGda6kqWY4C7fpIsElbVYq2EaYUddDBqV9przm9af7yJvkzbnzONLHkZ1daQzwzT0cN7P3mUDlbXgVoSpax2hbKgjw83uEH04lguIz1SDNQwisbKmPybPJ4G7F6wJJgcNy/hWqXJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910992; c=relaxed/simple;
	bh=CmTMxazb9aucCLhZKKjA+cLLZtaezjGo/cD+BLSKmaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UhSK/I2iwLUp4BHcJULaSsr5M5Bxn9jvoLc7yDHbEAMpWmwgqbCM/d+IINsqesZ95tzgQ3kNsc314xP3V89vvyHP1sSbVOWtJyKZF0VBXHKBkwDK8O4RFHg/G1rv7HuvT5tZOmXHcBzAwTIOzGU5Knzt1WlPyhJ0vbVVuHTVSIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Kn22vJNB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Kn22vJNB"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so29603125e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777910988; x=1778515788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r927EdXxquUzRi784TQe7IBsAleX51QDV6fOSE5krwM=;
        b=Kn22vJNBfl3tCHL7IJQB8uS2fnEHpW3NodYWsq5w3zDI4WW3e0k5727z+RlcweeHfk
         z4o5CetdCEIEzbVjIjQ/8G/t9BQTIP9yFNjm8ufRxlbDE9VxNcFGl1xfI7OiM0/xwTYM
         IwNdY8N6yWxl5siJHkfti1sisAoWS0nrbAlMgIIOPfUicf5yRm9qO6XFJwmvAKmVeD63
         CKNMuPZGmbZ4OwU3E6yiS1yiIecyDXp0bkzUxLmeHsDuFIT+icvbyo56PWFM4c1gVbIr
         LyF6fg1qAfu8+GEpWb1/TLuHtrq7XzLCAe4bHNyZ41Qw1IhIwydIp7Krom3Ya4CiMYNB
         zVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777910988; x=1778515788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r927EdXxquUzRi784TQe7IBsAleX51QDV6fOSE5krwM=;
        b=jfBV4toyQMp2ds1Eg+s7VtdUG9hrO/ae2nJwnNM0HvABOQ2BOjrUi9l2/qKrByHGeh
         ZELSRtg9/BxjzIlGs9l/283FDMynbrSpFRR/F3AjSIBdEm43g4qI/DiwQmmns+caBGpM
         m+unE/bL2Der09kjcz60cbTRt+Z+rTJVOPI4OA16c1vFsQTzVq4xFcgXomAFVKHANjok
         EuvyJJfQlJ73aUOuR8l9mnFg5xykNnGS3G7uUF0E+lak0yfqklhdkcye7yjv0EJ/E3YP
         uYSadj9yUFFaBG3WoJYaMUpU/AlgDbjny1/rL6zvUaCT4zhHXFElWdG68y8EOuhfbjrh
         73LQ==
X-Forwarded-Encrypted: i=1; AFNElJ+abxeQ7r8y2OK/vU9zlAHPa4VPx9z9xWT80PnRzpYQrhX9gj7w54Tw8XSrCJEuC6Atmg9JY+UlrrvtfhrTXnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5sN2HpGbTV0Vn98jeAMcKQntTR8szw1up4Vk+bqRI9vpTzwh4
	icEMZ8iBhq5ps+5XuMnzfkJ8huE7QourW808x9gUVKVRRTrwRirOvZyQMTprsRLc9n8=
X-Gm-Gg: AeBDievOqdZmaAej6E5RRMY3+Xt2gwa/q2l9/6idUgaBc9LK6SXAZec8II3e25T/Waw
	9+/SOKDukMM9G7vCtO/4OlHx+0TERxedwY4sKs2TuslfXKfNZetQKniudw/bORQHleh1dQawLsT
	shH5+Vs33RiUVWrpNyodM1fYFLhCATUZsI4S+ymvgQUJ+CiO0lk7VPVpNE+jk8iNbAu7gc2ZL0I
	fYePoyIfa+ZIBtTY7ceiXkL4XA6Y/LzL/hxqz/OJ8FSIZSPuqFb0HU/wzqY1TEf/HwYpTcaYo/i
	tZ4/lxEUJmuSVhP/R7Cd1lYW0NzovJQnZtVhPa4DvGlZ07cJPIbgN0IzifJn5db3SIVSncImoQM
	8+w6d2qdq3Ed0AVZ7axZtXx11xyvQ/K092UoQornRuY9AOECW4D1KCf46l/ZiMtc3xEt/1RJ4lW
	BeWolWF1yVILIzcGxyGwSnyF6Kjd9XR5Sb0ukuzlMLqckuyeqCTxLnizPP66VB6Pd27vC4U9T71
	+s/ZJ/H3g9FGsXMTSOEbJwdIQ==
X-Received: by 2002:a05:600c:3f06:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48d1424a351mr2853855e9.8.1777910988389;
        Mon, 04 May 2026 09:09:48 -0700 (PDT)
Received: from localhost (p200300f65f114e08197264a4bf9e813f.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:1972:64a4:bf9e:813f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a8eb75fe8sm289596725e9.8.2026.05.04.09.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:09:48 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm4377: Use named initializers for pci_device_id array
Date: Mon,  4 May 2026 18:09:40 +0200
Message-ID: <20260504160940.2168650-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2452; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=CmTMxazb9aucCLhZKKjA+cLLZtaezjGo/cD+BLSKmaM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp+MTETAj4MRLVp6upKPuoUtwbYrRf1PX5wwFma Js/XyqYbzyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafjExAAKCRCPgPtYfRL+ Tt6hB/9GjwroVu3uHf9J5uqO7394zE0RlEuyZHf2ytSxaeZ16RG/COodYGALkZjDEOlV6COy5I1 yQB7Fg68R4mmQOYH7E4RCFHCeYeretFYKljhvo1s+2Aaaym0PmpgIoEmc6LdUNXu6NGoYb0wg20 hes/00WwxShmGb8k20rErHdNWJ4ToOjM3nMqKUbk6PJ328vLDXcIjh5FweI54NuVkibPOgUA4V9 yTF7bM59tVHMc7FFAu2eQW/mWFDOkJDKyYAua9UhUmaXYM0JWpws2CUP8ZZimqurA2t7OrU1+AY zB8QFRTyuHnXjw2lm3Ow4/KWsQhLYy01aID6U6vOHRUCfoW9
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Initializing a struct using list initializers is hard to read, compared
to that using named initializers is more ideomatic. Convert the macro
used to assign values in the driver's pci_device_id array accordingly.

This change doesn't introduce any changes to the compiled array on an
x86 and an arm64 build.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this is a preparing change for making struct pci_device_id::driver_data an
anonymous union (similar to
https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/).
This requires named initializers for .driver_data. But even without that
this is a nice cleanup making the macro better readable.

Gcc is happy with simplifying the assignment further using
PCI_VDEVICE(BROADCOM, BCM ## id ## _DEVICE_ID), but this is a bit fishy
because PCI_VDEVICE also assigns .class and .class_mask (using list
initializers), so I didn't convert that. Once all pci_device_id use
named initializers, the two zeros can be dropped from PCI_VDEVICE and
this entry simplified accordingly.

Best regards
Uwe

 drivers/bluetooth/hci_bcm4377.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 925d0a635945..89c317561bfb 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -2525,11 +2525,12 @@ static const struct bcm4377_hw bcm4377_hw_variants[] = {
 	},
 };
 
-#define BCM4377_DEVID_ENTRY(id)                                             \
-	{                                                                   \
-		PCI_VENDOR_ID_BROADCOM, BCM##id##_DEVICE_ID, PCI_ANY_ID,    \
-			PCI_ANY_ID, PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-			BCM##id                                             \
+#define BCM4377_DEVID_ENTRY(id)                                                 \
+	{                                                                       \
+		PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, BCM ## id ## _DEVICE_ID),    \
+		.class = PCI_CLASS_NETWORK_OTHER << 8,                          \
+		.class_mask = 0xffff00,                                         \
+		.driver_data = BCM ## id,                                       \
 	}
 
 static const struct pci_device_id bcm4377_devid_table[] = {

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

