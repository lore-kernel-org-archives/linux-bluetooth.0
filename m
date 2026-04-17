Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75438397E91
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431488; cv=none; b=ug3jCKAGFiWkxNhaV+I6qzYWyeYROrUJ+qX4VIt2LF+peHMZz/uAAe3eDEhhA1Jc8sUf/qhwQ54UH5OuunUATqQQBaUCN1d83lqyUu8t3aC/yCcmHnelQB1fMeRQYiLMPkWr6vlQefiDdamEsY7WqueWPtBYzHQbwudbpDq9O0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431488; c=relaxed/simple;
	bh=Klkglyq/jaqn07LVoY+DygFKlFSeY4mf3uyDS+66nUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzUoc2JVECNhWCKfjDvP3UuKsN9Py/lEnhhht1MwnH/I1G62gurXuPe2LxMO4WfGzalTIvlH7LwB4BC/fpo2gknErVS5RBhoG9S4WHgg0q1BgPdTcyXm34Dsv78r5sABuNKxrA/L5Rp+lZ14fPm5vhCJx2znUXuA+C6XwYLA7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=kgat+i2O; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="kgat+i2O"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d77f60944so499495f8f.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776431486; x=1777036286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLBJQur6L6abrgINbvpQqXST9x1YXfxN6XkkI5ZCGzQ=;
        b=kgat+i2Oa6Wy9zEOI65gHK3Zn9aMLrxwt/mf7bc7zAHG2PcE2wWKWhs+3MjkbcCAuz
         sd9N3EZ9kSFwUmKa20GXjKUvoKsXqum9lZAHIMOR+mVXLGphlnSmAjNKK776hHo3meip
         EXzDLnetciMhyrijIbsYGXjGhtibipFdHPOOjbaNzwu7LYQpF9lH8Jwt5JK3mGczK6Bw
         6NMX4UmX0cqrdoitSk2b/Bn/QR89mLBjpoLJKkTwMKYlKX9gXxl5GQJ6mBjICKg6OsGp
         mbr1S5TM5yOF0ZQyapKPlZJnpvZnFqeGo+JZAE9NUYV0WczLVAnuxj7fFSOYRgbknC+a
         IGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776431486; x=1777036286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yLBJQur6L6abrgINbvpQqXST9x1YXfxN6XkkI5ZCGzQ=;
        b=qMIDPWVLv9jjkW47Ue8paqkmsCiZkVfaGQEyGjw6/AyYMzkYOejYp/VlUZDv5FmAxZ
         6frRFsB8R1WOxucqSTdxV78kWXoBBuUkqHqONxY/8IGtTIvC1Ivoj3yfafAZTje38nxk
         547XHEnXIdyJLdTmPv/Vll/+Ze+S/1dVHsmLlm7yZE0Y0TNW4bC4DzSvpiH1ywuMZtiy
         tvYV+7HgHeTMP9PEEQWY3NqvqkcSmUqF09AF5T5iIc9kio4xdJyWm9FDwm1znevHnHXF
         brsAzNWijeH3/uDT0smZ+E6Qj4/0Fza4uGJenXlJPXSHaIrYnXjsLq6SU6hxMC4LwFq2
         vJdg==
X-Forwarded-Encrypted: i=1; AFNElJ9KB4M/yiKdIEPKkm3XfnRIxI0caxU9TdaNZSvovSegiKgZ9xfc2v9pxMC8TxOGTKlnvfSGmijW7fuzpYA5OPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqxnSj5GtI2UWahiPGpwbbIjfcjyDBfeNRxXR6oO2MuAd0l/yf
	04oFIa17lP8YpJbkvZH0RqbED2+NKWhDDWlmGnsqiEOwvqOvXSTlARXZPrEevcOfP04=
X-Gm-Gg: AeBDiet3kMlQZ2cBlyFkTI9esMV8g6t88KFBO43IyFbWBxoZTQasvzdzqE8xbPH8jeF
	ARYNDw8CzEsQ37VS9THc/TjWFnoTgHffZ9Z1MILQb/28WDLFB97J8um2+WdmAuRBgn/tfLj30hg
	IDK2vKBbBv1Qbf5RN87JVeMVP5NBwBjz4QSjDt6AyQNtiI/6ctWiNaU57jBDkLiX/3O6M8ex3aR
	fQmLW73Ls9td9AsRA+hGB+uF6akN6Z/+n38Z4Kf+Dzm5OOhRp8rDebMb6zr24qLPpswluuCpVWA
	Czk1lLaKDWYN+o7g7J9FMqXdHQpAKWGH47g89ZxCwNcPF6sLYl/J9axNLuVBv+pfzLbXF4Dl6Cc
	sxq2tBKhfOnQcC1+BwN2YtT31y+DuMRwbp6Y0mwQ+3UhOB2C3Pl9wufRggZJysDtAwa+YIQHqYH
	gp+d5DULCjw/WWlJtfyG6XP0y1b6BXZi5CNVZ2OUP3Lh9RVJihxRsjpvxzdN8TK+Pz3ImQCQwOG
	OhUFe50x/dh3jhkW1Sd0AIv
X-Received: by 2002:a05:6000:420a:b0:43e:a69b:d813 with SMTP id ffacd0b85a97d-43fe3e0d459mr4571980f8f.25.1776431485775;
        Fri, 17 Apr 2026 06:11:25 -0700 (PDT)
Received: from localhost (p200300f65f20eb08db61cfc60d8aa232.dip0.t-ipconnect.de. [2003:f6:5f20:eb08:db61:cfc6:d8a:a232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e4daf2sm4238766f8f.33.2026.04.17.06.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:11:25 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in sdio_driver_id
Date: Fri, 17 Apr 2026 15:10:47 +0200
Message-ID:  <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1594; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Klkglyq/jaqn07LVoY+DygFKlFSeY4mf3uyDS+66nUI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp4jFZkxQbj+KYt4Q9fEkJxuokeQF4k0Z8QVO3Q 7wAQaupW5KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaeIxWQAKCRCPgPtYfRL+ TtZtB/0YGCqVt5rVpLrWqCD44F5LfNFUgv/+TGPxayzQfsH7zoCBqE9UgsVpBkFZprUwAzLBPWG MPbj74nUaxJfky/T/6x/bsJ20CXFl14Aky5oeSqWXwpx/STsvR1t7BH1meFZ1chEsexFTdIwswa 8F2lrrBsAe+eGHk4UdYwOcEBLke8MRKu7X9WInf8735NDYlo6VkX6TwaQTxpOcTlNIDfwZlA6ON nlrxK4GTkQYXCmaFZYylJBpOTDYLdH8GJZthPQhYPW5w9D8jVeVUIanYYaSikHt0R/zyWaylAij O7+GqKklrjT08jMFR3/4DzejRKFhjlyBUA+HrbH74dCapvBS
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

On all current Linux architectures sizeof(long) == sizeof(void *) and
this is used a lot through the kernel. For example it enables the usual
practice to store pointers in sdio_driver_id's .driver_data member.

This works fine, but involves casting and thus isn't type-safe.
Additionally with the CHERI architecture extension there are machines
with sizeof(void *) > sizeof(long) for with the traditional approach of
storing a pointer in .driver_data doesn't work.

By replacing the plain unsigned long .driver_data by an anonymous union,
most of the casting can be dropped and it yields a working solution for
CHERI.

All users of struct sdio_driver_id are initialized in a way that is
compatible with the new definition, so no adaptions are needed there.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 include/linux/mod_devicetable.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 5b1725fe9707..0eb5d196f5b5 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -414,7 +414,10 @@ struct sdio_device_id {
 	__u8	class;			/* Standard interface or SDIO_ANY_ID */
 	__u16	vendor;			/* Vendor or SDIO_ANY_ID */
 	__u16	device;			/* Device ID or SDIO_ANY_ID */
-	kernel_ulong_t driver_data;	/* Data private to the driver */
+	union {				/* Data private to the driver */
+		kernel_ulong_t driver_data;
+		const void *driver_data_ptr;
+	};
 };
 
 /* SSB core, see drivers/ssb/ */
-- 
2.47.3

