Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDD01BC06D
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439266; cv=none; b=kElrIqKf7jC8K+S8b2NrigYPVRWWWuwASQo+Qw5Yoa1cMMq2DKEfTUGr7s6lv4g6GJMjVe/mdohJKQANsYDzbUuUEk4dlt7OUxZ81cytlPNvPPskvKeFeZC4HA7dpmANwCMxMrCYs4rz6ggwKHkZSkyvVVEamtIxGk1fANz1+Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439266; c=relaxed/simple;
	bh=zswNoI+O50GZIlRez3sOlhQLLckzIM5bFpKXGIFJOeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lCGIjVy31+wN4nybejU5HfEaUrpZ/HDKo69KKMkckQ0uAqdJCeP2UzxyFBhJk3Lp/coNj7S3/Tjuek0Vh+ry5f1smvstfuo3oGzlMEnWPfSjYBtbl2abTZTYcdzZd+/XMrxHG4GK3yUrZBatt1QtPg8CBb23Tz5KcajYhODdlNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kWyTzPXw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kWyTzPXw"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42808071810so38076045e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 08:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722439262; x=1723044062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=seGLREnX7OFM1G9ARfOjIKh5OQ+OBIGU0JJ2UIP2zUI=;
        b=kWyTzPXwZxQF1IsdIu/goFjxsAh4frI8c+EWpyOfJpaAmP6IcYOLz01OVjjM71XQML
         A6kSjl6QRJENw62Di8EZanJQHAhPb2zsHxO0Ogz37TAC1DnCCDFP3HNA8Nl48iUxYgyk
         2doif6IjHTSmk7kByUdTZ9XXhTRQF5mYeH/UQadNikCMHUF7iorSJHaylfiqONfJWl2G
         KfNbImisFQF3ZZ9sU2/sWg+SfyBkoPV6vt1gFZXoboMiD7q+zBXZvCFxCaf0Cd/XFNnu
         UDM8a6JFRhc0pV/fCgSONkvpUtNeE7FpXMXTF5wuph7xzYvaXla5TZNovJ3RPS9qwNzD
         hubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722439262; x=1723044062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seGLREnX7OFM1G9ARfOjIKh5OQ+OBIGU0JJ2UIP2zUI=;
        b=AIcQtvm8Lui2a9u4hmS8NZ2VDWaTbPZ/W7ezMY5UCHBDZQ+6NmdV/FYNgvz1OnzKoP
         H8xdhKl6sPwHJa7TBd3HbgR4VOH2ZNtiAd7uJFBs/oecL4wQLM7ICXJoxB/Ata83Zbx/
         OX7gU3s9S5r6cSO/Rpx+1XeBFVDWtOwIAMuHOCA28OqnofHuDNzwKBewQ3lsUc4fd6WO
         Xi2yax9M7potNvvrG84dAB2IjcxGRqWVlgFayGkrayiwvtFqSVX8ITDcBRUsHGeXYXL2
         Fww/Aqv/YO7lgFFm9nTSkX25rD/elo/wSUp2WztJKTlw7+m8CSuCYRyvDkFzoweedDZ2
         nr/g==
X-Forwarded-Encrypted: i=1; AJvYcCUUWGCeQ4JofCxKfJpJzQ04lYC9yLohjZQ4QOYzv97k/MFGEevtMNN1Z2tC7qTGj6uu9TEPBu6JXakP9xBK8pFUPKDQ3oTIRTItjCLWs6RG
X-Gm-Message-State: AOJu0YxOX4U92FXfP7LRToYB3v4QovEUklmLwuLA3LYuX29jVvw64fFt
	HDdzDPTSF0qtZWUJb8fji3aOydytVkuw7ui0A8/XHtteZ3tEPX1H57LLzV0CVnk=
X-Google-Smtp-Source: AGHT+IGnNnpozXh545R47gaPDDj+PQCgiw+Y3QMUcPdZxnbLUZ+343A1z8hW65JSeAk561KptY8EjQ==
X-Received: by 2002:a05:600c:3502:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-42811e12ceemr105409675e9.26.1722439261785;
        Wed, 31 Jul 2024 08:21:01 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:9c3f:3dd8:b524:cb31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8addd6sm24752925e9.20.2024.07.31.08.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:21:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 31 Jul 2024 17:20:48 +0200
Subject: [PATCH 1/3] Bluetooth: hci_qca: don't call pwrseq_power_off()
 twice for QCA6390
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-hci_qca_fixes-v1-1-59dad830b243@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=948;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=XGFL64JDfLMIkMon2S7BTiAEZj1+aydkdFjiwnS6XCE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmqlZbLbl7JeGvR6pZu+/H7Xa5O/jb02pslfVyw
 wcBWkaFhceJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZqpWWwAKCRARpy6gFHHX
 cu5DD/9m3EwwUlinlHdBdD7URJamNyyKLeonKCDJ4RmLR9CNEt9zk1JfNBiWXW6+XG4xf2hrtgr
 otrGMOBlWGXN2USgGSwOY1DUjHzoPtuQg7GuWsjdCGmJ6+h6M87zsu+WGC+8rDh5Z88znLILbws
 lfh0aH0sieC+Yy1LAVqvesdef/U2002iJjBQH8MqRxF4p27yw6Mx0B9JcdyqNCNWKAysD0R3hdY
 rM2hq3/HKKWh1cUADLG4rok5z1fnVB85T21wDi91AuL9Sv2RVfEhEVJPJ6HlGf3jeHnoDTt0vOO
 bVLiw5alz6z4xldcgf/uBFIYd/ZzgtKp4H5DgwD1PTws6NqW2QFTwSOcVuGxEFacTQ4nnkit9/9
 ojN32NyOaDK0gqFvFnXJ5WTj1AaoHk/zJ1c9WJ9OhsrTsPT4ABBKy4TP+Gjg0NtyChZD6IDSiVs
 V3ieLYVRRdrOoq4AAFYyMxcaD+ruJ65+SW0zx+hI1kTySmpALtRfqW76UepP+9Osk06n3K1Kpyr
 14oLrfYTDUMOIp+Eydz0o+Pyev+kxMLd6o0aCPxZp1x8iNbzhpiOkgQABNUN5JtVv/0b0vevE1P
 vhBWCB6hUyZ5AKhW/6WauWjCnFwq06xDiiB9YFAamW7Z6ihtcXjb9pMs/dRJJQhhp2ngUyQ+eRp
 Z9B+AXjZ2METuXw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Now that we call pwrseq_power_off() for all models that hold a valid
power sequencing handle, we can remove the switch case for QCA_6390. The
switch will now use the default label for this model but that's fine: if
it has the BT-enable GPIO than we should use it.

Fixes: eba1718717b0 ("Bluetooth: hci_qca: make pwrseq calls the default if available")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ca6466676902..a20dd5015346 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2187,10 +2187,6 @@ static void qca_power_shutdown(struct hci_uart *hu)
 		}
 		break;
 
-	case QCA_QCA6390:
-		pwrseq_power_off(qcadev->bt_power->pwrseq);
-		break;
-
 	default:
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
 	}

-- 
2.43.0

