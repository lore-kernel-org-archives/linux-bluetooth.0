Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EA01BC075
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439266; cv=none; b=a2InOHoJK2DeuNhr59YsJfZedFdUGtJrrUZyK7GWmD+hMQOTZ3MzwgaDXrE4YWkkZEUHSbFsE9ip3d5BqvLikwL/FssLuXzdtnXXVg3z9SIESsWZsIyC4J8AJHdS5gbS0N4brZrwf04pDoNxqbzCHmW0jdAPrSPP+WPd8mSG4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439266; c=relaxed/simple;
	bh=LdpDzyWFCiBgonFQqFfm0nqC7qS83IeudAT7ZO0JOjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BoqvkYNtPQSgNX6el70i/Y9uOjTItkNGBVh2+aew1nMKWRpS7UvQTuYTZ3zeXqcNkj5lpqh5KPgpvrBA2siEAI+5vlaohnSO8YSraFhu4UCy0ALOvTIoxS/RFankor0ki30pzt6Ed7jnRzxkN4P5tJBuTzdYPYWGZDD1azhUOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sdnQHH+L; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sdnQHH+L"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428178fc07eso35403325e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722439263; x=1723044063; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjqaRp206Si4rf5IzNwrt387VW4IpvIj/Qpte2KdXr0=;
        b=sdnQHH+LJ+r/AlJ9qJ2xrV/4Ng73OGMPcKN5LhalnqOYVr+Cr2icYHCvr85uoFDf0r
         Frw4gSLpjlZS586h7AnkYw6hGboUq4NwWhiUtgI5h2EOwfyf1FYk9PJQZCCGZBjPYm8f
         zzrV2dq7ICb2KY+ydMqn9sWqoTsfC3Ym5Zv27FYboTANTt1sSdvhcOG0hDnFoMiMzB+x
         fRRxSHXrGNRlMXtWYbejBUu9WO7CZdzhf3O0d+5kSKGlR5C2MaCJA3qynoC9Ijm/qcmB
         cpNg+QOzs7sdPc7/5pfGH7EsO75zsHo0ZIfuhWXAjL1XjANG/zniCDNDMCKJZoNJ2p4W
         M2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722439263; x=1723044063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjqaRp206Si4rf5IzNwrt387VW4IpvIj/Qpte2KdXr0=;
        b=e6u/k7wxSJWJuLEZ6rOqI424CrbMAsDOCY4+RGKHInH5mIAGbT/xrnc7I81Xu4f2Tp
         O/aI/bBVjl+Xg65QpHizckvdPjFAOJ/UavLO7ZXDAH/8jOq65Yh3pEG9GeiigS0fj9G8
         45KQ0v5j+HcLSDAvJRnIy+46s6KJ8DNwwR/rcTWY/JBw78PL9TDECIfbvqXBBBVI2lfm
         WFJLixFCnx+uVsS8O2mpyh8PFumNm8b2sqk6JPkaCDk/8aCrsJHcTLin3FpKvu+6ITO/
         mELMFP8uB5GtK2BBJ+4jDSGlOzf32hiT0pHLAHyhbKtAJT2TFd/P6u9OMrgvNRoHxyIN
         qM3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPciQdZdMojWpOQT5r1WIwLVWaCeJKxztjh4N6KsPiiis2sU5Ep01vMRZClYGo8S5lCIEwkreMcBQo2YkAp7/DrlNt7qGPGwrl/hpH2zbI
X-Gm-Message-State: AOJu0YyBRI0WFDfHw5omVgzU11LhvLg+Rrooh8iQ8RjqKDCIMpU43FJG
	vlPZ/geAEhgCuGYsMW3NAJP8fCCf8Fk6EhWOwsSWnBfWgGVM+6O5z3PJVusVHns=
X-Google-Smtp-Source: AGHT+IHcLguNI7OAQUaUZoauSdiiaQ/CGK++QofAFtMwzzBCR5KsjWfoSZGLptO1yR5v8Km8kyW5Fg==
X-Received: by 2002:a05:600c:35d5:b0:428:abd:1df1 with SMTP id 5b1f17b1804b1-42811d89a32mr115041105e9.9.1722439263158;
        Wed, 31 Jul 2024 08:21:03 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:9c3f:3dd8:b524:cb31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8addd6sm24752925e9.20.2024.07.31.08.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:21:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 31 Jul 2024 17:20:50 +0200
Subject: [PATCH 3/3] Bluetooth: hci_qca: fix a NULL-pointer derefence at
 shutdown
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-hci_qca_fixes-v1-3-59dad830b243@linaro.org>
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
In-Reply-To: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Wren Turkal <wt@penguintechs.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=hI7Px+pNJ9VMgQcWvO9ows8sLOPoMdCRJ9COC7+Xuio=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmqlZc87l17khxWQpatC649asQoOe28Ys7zbs8B
 qwDFRvSF4qJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZqpWXAAKCRARpy6gFHHX
 coKpEACmnRP6OKNLCdGD7MsJ7G1OVWYfaAP2rmChgpX2vg8qFzhiPlkw10QRnSHApfQ8U6kmxbK
 /oCIf1/Z35nrJO62Qo3LURhLUhUwIMPYVKdPrSCKoP2w36lRMHdMbyPy2PuX6UM+gzztlniaCgN
 3wytlDbziUnBiFdtWVJdLgrmhdf4rNMdl1h2r8kpMMIrrByRJSDo6hpwLtXnDesq/U2CZcdT4Z3
 AoupXSnB6gkO+uvnCaQWYUNVAmGEnmXGyu0lY6iHyqq0+2bIPowsXgyDORQKwp43qZ3C3UZvrZg
 ydvsdTgZH3G2vmGyhZhN43ptadBArAHXJU7ISPAW5VEtXIsHDFw/A7hVtgteyAyCllJXxDJkSPG
 URnXnZgSgGPsWgpZlA0mjvHiHhTJBOBV760ivqglRWCzq9HLct40i8D0U6Soi8dDZI27Zdxi4Wz
 KfqzHts5MAJmifLQzdhejZBInNh7fSQVSsQG75fTUz3SEeGQ8Hmn1DjoD++dL9Af57qGUavxyxB
 IZ0MgKuJ7c4mT030Cr7XzEWVxD/STKyJ2IlYM0qubufIG5fvgsmbLW1e1r61wuhZkj6fk0ixjiY
 UAGYRkaujYpX8IVtDeHEw/dJml8uIUOvRXh2JOW/9h9QA3dCF9P2ImVR8g9XRqfyXaHWnrhBExr
 EenmdSKLFItAhHQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Unlike qca_regulator_init(), qca_power_shutdown() may be called for
QCA_ROME which does not have qcadev->bt_power assigned. Add a
NULL-pointer check before dereferencing the struct qca_power pointer.

Fixes: eba1718717b0 ("Bluetooth: hci_qca: make pwrseq calls the default if available")
Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Closes: https://lore.kernel.org/linux-bluetooth/su3wp6s44hrxf4ijvsdfzbvv4unu4ycb7kkvwbx6ltdafkldir@4g7ydqm2ap5j/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 2baed7d0f479..45adc1560d94 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2160,7 +2160,7 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 	power = qcadev->bt_power;
 
-	if (power->pwrseq) {
+	if (power && power->pwrseq) {
 		pwrseq_power_off(power->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
 		return;

-- 
2.43.0

