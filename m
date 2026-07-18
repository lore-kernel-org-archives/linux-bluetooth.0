Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647D331EDD
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784395526; cv=none; b=bFnEG3MsT5/cMLjUEEGaO2EjKxmtG0iuY1GIlbWUDZ2hJXR+LgfusTFTkruf7UvBEDXAbUXInwASSoln4ZMjqXglRAiCQJH/xXh0085G4CkK+WAGYk42M9gfbgoZgss+Zlq0fFIK+PSsFwMLLWO4TJ0zaqrcSvzgTH0gEO8+KPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784395526; c=relaxed/simple;
	bh=szLs5CcDZwYWzOei8Q+NZivNVZp3qcW3phKkPE5EB1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KvcHRzQ8SxZdrGCYyuOIR9mIWqPiEKyu4rI76MKxvMzsJo7HB08j1N94Avp1y4V1boj9yXHNWO8CZuZHrCSFnWQOdB3u9nyGyA1+r25eKlVTFecJWPZwIdH2AtDH0L8Ml3GNq8YcbVhTfA/NyRV3Tp+1IjKUCIScMcrXrUtQ34A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=AjCoF3cy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="AjCoF3cy"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so10184145e9.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 10:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784395521; x=1785000321; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oiJo0XVJPw2rjt+rcIvwSaUqFzjRlb/yk8buMFhbHKw=;
        b=AjCoF3cyDsaA39rJMpOgCgAK0wsPCCutYJPdbTolgC58n8hhf8xUyjtRtm4OW9G+95
         mkEsNQXJoLWt70SdQfMXu1BIwdXgJGDfOKAInO4YS3e6avCR2ho0YhNvXP/ezVN32F1K
         1y6HqHbnsTad7pzD2+wZSgTAoIe9DPOTo2Uo+v8DFgt23m6MSZ+jTCMqLWlNb3lz101h
         mTvHochdDmhpT41mrSFXCWfrRxFsibIwplavooMFjwRgRTQnhVhyqrM4aQHlMs9sbqcv
         /6en/fG4WqAbsIqiT+LifuMz8jQ2XGBQqatS3PiPMmijTayw9lKUMKD5ArByoBjfLnE0
         qALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784395521; x=1785000321;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oiJo0XVJPw2rjt+rcIvwSaUqFzjRlb/yk8buMFhbHKw=;
        b=IyyeTnNZbNO74Zn173+noZaHfKlkgo8lx0qJanFb9cEUBtnJu9K48CuFB+fJMC4Fa6
         E6hssZwjAgg+Fj5hYQRoCDKmm6qkqH1DMTfpUxv3FmtKzamRJoozrs9URMSw4ftM8d31
         21CBmTri+wA2iT7OfCxjxIFdrWiaqwNas0puTYWOJpC+iDXpKRY3DalmdATyeekGLpnp
         j4Zv9X8kMIO7pETXzJxJUmzWPWvKeX9hX5h2yimTWUs4BW67b6vWhhBFHo4c+sAtMW4H
         9j7cHOqGB13QGY3Mi4CJXzbmMiAm+bNNlouorhch7vaueiWknPSfWxpCEM455YzzGzv+
         bbZg==
X-Forwarded-Encrypted: i=1; AHgh+RoNrGVAxPD+K/+bi0Zw7IQBk6QwjnA80S9pauC7qrksOpbybudCNfawto+VjToph6Q+LdpluLADnw3Gp4V3Ats=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIu6TSMq5Xqqd/dTYNEm1yAWa+9LWmz6SdhQyrwe+jfmrFPWXp
	LCrIFnHjj3GRml3R2CSytT6z9+jZKPFWkFYwXq1ZH6pu0Mu03bDLHJXOubElfTrhF/k=
X-Gm-Gg: AfdE7cmlKLpagAw3ATFEwUxNHd4z/Zomd1TU0WXioLoJ7dQYgD7jxezlZXFk7e1/3k+
	dDuaPEDSdoFTAEH8h8vozhUWmJ8Z2JHhvSFfVTVQCl5ZExQgaTGtuXfirsu5xT1f0XkqhYvz071
	t4vgR1nFLXylYogcsVArx6ydQ+XL7UN577YFZkLJfokWRRXXY2dJORtfFZclLe/GiZk0yt5Epwa
	ahn33EM6znFkTl2uwlP7rD6SdCukG8AbtIEKL+Kv0ufUun02uopto8K25GV87+MpzqQqOLPJKY5
	jOwG1UAE/edtIcs/nggTTez+hbJxZPjID6CQbNq4/ZOeTF2thtDVYG68vZSh2uc0qqTYIhhZtu7
	UuwM37hF7B2CiTh6H+Aaf4vnISII43IgQqwzRWkaI1/B6E53Eyaynx8+H09GTlkiVzvxXM2fXJD
	pksbwyzao=
X-Received: by 2002:a05:600c:1551:b0:495:5858:e163 with SMTP id 5b1f17b1804b1-4955858e1damr1152765e9.27.1784395521571;
        Sat, 18 Jul 2026 10:25:21 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-495499a5847sm102758895e9.2.2026.07.18.10.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 10:25:21 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Neal Gompa <neal@gompa.dev>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] Bluetooth: hci_bcm4377: Use named initializers for pci_device_id array
Date: Sat, 18 Jul 2026 19:25:12 +0200
Message-ID: <20260718172513.986134-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2277; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=szLs5CcDZwYWzOei8Q+NZivNVZp3qcW3phKkPE5EB1U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqW7b5l0Xf7DwIpP+bsrs2vbQ/0/z6agzIC30mc po64ff2EqSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCalu2+QAKCRCPgPtYfRL+ To50CACKAOW2gW2kAvbfG1qPbjTY5veMSIusBRt/vgLy1JwBLwrE3YL1Vr8xDm480Vo5R8Y564E 6h5yd/+HFf7L6zW2S9ed9J5TMpsfK959oUZj3p9v754oxy2N0Y9UDo2g5BRzuaGOjlVk0LHxpHW 7Q55+MdVLRvZTVkoqBfhWjatzbaDmqkUoNJI24uqTwCmPoUEDtQiUUQkGuVbOX/josyADAf+4Te nAaMpGU/X7oEjt+akpqneCOqxkgnwh0RN3VAz6KZG6x1WC4K9wx3h7vxwOnmfbTfVCFJlSj1tKw CWi6ngKPT6xfbRklyiBSkGWz8eKGq+moaY9vUUeaaZTTE5y0
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

it seems in the bluetooth patchwork patches are archived automatically
after a month. And that even if there is recent activity. I consider
that very annoying for contributors.

So to get back on the list of considered patches, here comes a resend.
The original submission can be found at
https://lore.kernel.org/linux-bluetooth/20260504160940.2168650-2-u.kleine-koenig@baylibre.com
or 
https://patchwork.kernel.org/project/bluetooth/patch/20260504160940.2168650-2-u.kleine-koenig@baylibre.com/
.

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

base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
-- 
2.55.0.11.g153666a7d9bb

