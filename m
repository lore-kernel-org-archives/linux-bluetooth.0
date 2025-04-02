Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926F214A8D
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743591707; cv=none; b=OrPAGiuly6QFWsNqVvNcDvS51AfkB708bpFACl2qZGvXgO6lKR06i6RTU5nWBLHycDIJGP187QTL6gy1e6d4UICNS33dcfrz1yZXOnEiG4Ihm7bS6Z4NpFM1FLkm+fil+9/H2VITaz4U2Hrq4i3tMG8sbiVBEXX9hM434hhesE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743591707; c=relaxed/simple;
	bh=YryIXZwiZj5TQVa6xgb5j2pgntCojc8vvWQXzdlrvxI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VmwrKuMKlRVc3q+R64chLadiZxg6aIBvXndzNpNUWoJMOcjb35dRjCfPLu56yFBIO8w0fTU+4rv2RG7qsmGXGW7ft3NkcaOEJ0ScziNrktBQ2v6gVJttX4a6dZp53ktnrtn9OaTEh5WSMBVAKO15DZAgz2KaLP+XZN+N1qDgrWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P8na8wG1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P8na8wG1"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso62689605e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Apr 2025 04:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743591704; x=1744196504; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y6Xjq3Wk1adijXSrV6wojCwtoTAYgsAX9qsyZmP0AH4=;
        b=P8na8wG1ZlWbiC6nQEHo6QJSnXGmjZypjSykn66msC161sxkd0QSodR0WVx4yXo0dZ
         OzdmwzSavwGK32pW1676RBP1L0nOYcaipzNn02A6QBvBvdQ3xgLNXD1L3+N9eSX63l5g
         Ybgz6tZyX27zBA7TODu5zvvDe9+6brhl188jvYpgDLssPd7EFie6EqdFoowGqDOizgUP
         UVW0Kai38zgqie4e1ceknuEV1oEt2VR9PPPu0S7YCEFNAqWetps1trD8rshw7+TmaREZ
         Mty2WmylEGKck0mVGQdHHYkOn2JB+cUKZDSZM33RcgPjIwup24IJWluXcRmrhThcoYnX
         NySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743591704; x=1744196504;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6Xjq3Wk1adijXSrV6wojCwtoTAYgsAX9qsyZmP0AH4=;
        b=IedKONh/89u3rGjj0TMEQhgwrY1ecM/hEXUfgVXtuM2ClV7r4V+qwSEnZxodYkxTUg
         4ldMpDqSGcdgXxi1Kz+Py/OYs/Zwgibxopk4uqcQb+S6V+D0nQJdpovw7C+dOwtX6p7b
         Vad7hqvFl4oZ2dDVoj5lt3ykaoQsd7oKq6li42Vv9gjdypgd7wfJeJB+l+Y1A88q6kAk
         L8D872lkIPVC5HRq8L6xyxURjD8oGbuhS5npPSK7syncoBaAsYy83Cs+T8dwzxpDgkNm
         QbtELyGTqJU5Z5wpg3jPejdSriviwSwTHGWmYHiZoAAg6Ah9dyB0TBvQcSyMmpK61Y3u
         6IrA==
X-Forwarded-Encrypted: i=1; AJvYcCXkaq+BOCBbJX40290ihXawWX0SCHQ8NRNvBpTPe1bsPjgiPqr4F2uW1F+WCYp37BiQrQGB3VSZhXCQemfwKkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAeUj+i+IoNQC/aKV347Q15SYgEw9Go8Hx/3kXUOdB709YkDuM
	6y7HJA4EkJbn+OiW5SoLsbGk8YI2mO2h3R6vzcgTTY+rCdGt+dn1DHi9VGDKbicGNbOWBNx7/z7
	P
X-Gm-Gg: ASbGnctPTvrrXwmKGIbd8afqA0tQK3/+pO/L7Eh03DUqyYITVfdgobiN25bwSGoNXls
	u2OB23fd8MrcnNu06qX9yQFUbVtqYi7lIv7hMZD7K2LKvDroaXsR5FNcOevXC+8UPi9rdeEYO+F
	UkHSDfxOCop3ZdaZcDDNyKHPyaIxanQecmB2FTqJetZWTJkj2LSFxrtnX00ue0jfKZCL+1zjTBV
	vO8yl6bbC5lR7w2U7Ot1gGlM5jtPTPuDmpeaNH0A9GjdSnnDXeXpcmSwmq6Rp2pWlPTgGKYZT80
	ivACbbTC7N6mrZnT7GFgGBzTjDnbYMsB770fnk/OLKruNqqwMEsn9eibrA9L
X-Google-Smtp-Source: AGHT+IHO1mXjqZOU9fX/s+6kuEaCBJHUNNDyFh8HkN6EexBt9U2YTxYwKeixp694XKSML/OGgpW1sw==
X-Received: by 2002:a05:600c:458b:b0:43c:e8a5:87a with SMTP id 5b1f17b1804b1-43db624b447mr157936675e9.16.1743591703864;
        Wed, 02 Apr 2025 04:01:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c0b66a75fsm16423386f8f.41.2025.04.02.04.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 04:01:43 -0700 (PDT)
Date: Wed, 2 Apr 2025 14:01:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Jeremy Cline <jeremy@jcline.org>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: btrtl: Prevent potential NULL dereference
Message-ID: <0174d93d-f3a5-48ed-a755-ed7f6455c1bf@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The btrtl_initialize() function checks that rtl_load_file() either
had an error or it loaded a zero length file.  However, if it loaded
a zero length file then the error code is not set correctly.  It
results in an error pointer vs NULL bug, followed by a NULL pointer
dereference.  This was detected by Smatch:

drivers/bluetooth/btrtl.c:592 btrtl_initialize() warn: passing zero to 'ERR_PTR'

Fixes: 26503ad25de8 ("Bluetooth: btrtl: split the device initialization into smaller parts")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/bluetooth/btrtl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index d3eba0d4a57d..7838c89e529e 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1215,6 +1215,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 			rtl_dev_err(hdev, "mandatory config file %s not found",
 				    btrtl_dev->ic_info->cfg_name);
 			ret = btrtl_dev->cfg_len;
+			if (!ret)
+				ret = -EINVAL;
 			goto err_free;
 		}
 	}
-- 
2.47.2

