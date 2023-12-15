Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD141846
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Dec 2023 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5o3TWdq"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-77f43042268so153595585a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Dec 2023 09:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702660325; x=1703265125; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3ri5NHi1+q36wzH4gCKsY2IR9JrbZmuUCDOeTb6DHY0=;
        b=P5o3TWdqJn46IprV9vQU9eQv8cLzAYSDgCmk96LJJs5jtaotZ4SNIkkqA35FylaWIe
         +u5+1dxzVwte/LzkK0NDWoUG3+9txb6YZcY3g53mDzV2XpXEUcds5TSvE5XSCUoZ3nkK
         icvNPUiHG9Wjh8l2z1JhV5EObrnHGWKDAoq766Bff+aYAva2WbPpjJ10h4HZ4hhjlo4Q
         l3k/dl8vFNxwiNoE8Gw1CS3R+gAl7dF8/Ub84bn6aE1erHToDU9rRyNiACCCq5wMVbn6
         lSp0J9WvkJTvSECW2OI427sU7sWq+Wd9h07TJFsSFWFiPkvTt1LKATTv4Sfg65EyaPif
         Zvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702660325; x=1703265125;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ri5NHi1+q36wzH4gCKsY2IR9JrbZmuUCDOeTb6DHY0=;
        b=cbg0E8js9mh2qj1/AZOyvzUUhJDJOC4mqEJ7RQVblmcLDkeQlePJ7u3gjrYBOUtfrW
         pVwSz1hGoWeNvaaVsTnUedV77gQhQUonOGml6dModVhCrMQLT53xfU6vqTdrYDqPkWF2
         aPAFo+LPwRZ8wtb/h+aA5XZ+tiuy58cUlluNLOSTtbgcfMCVd/qW4/5BFvga70dVhVbg
         TtzblSaBlo7RKdVc9XHkjYSyifyiKfAsJTyzaGRJ4DsHfd3RirH36KOSg2JqAPUIxhWA
         wpbTaWSwABz1YLsPCtlSWnEX/9gDnBTElvxl7pYdRoICVNDSUbRiSptLO/eKWrgyMtXA
         ONaA==
X-Gm-Message-State: AOJu0YywemfKjUrJxjzVx+zwnZO42AFuPfKGPjwi/XEjXV30fO7/xrpE
	iFnsRCMwjrEe8zeT3gLwqOibmz107JQ=
X-Google-Smtp-Source: AGHT+IH/+K+dlZf3o/lEM2rVWvsSCkwjZ5jv4074DlJWj765VzbxYA0hNKHAkcwelht/3hdS3POuaQ==
X-Received: by 2002:a05:620a:1a23:b0:77d:7ace:4a6 with SMTP id bk35-20020a05620a1a2300b0077d7ace04a6mr21265751qkb.2.1702660324965;
        Fri, 15 Dec 2023 09:12:04 -0800 (PST)
Received: from [172.17.0.2] ([20.109.36.213])
        by smtp.gmail.com with ESMTPSA id v16-20020a0cf910000000b0067a53aa6df2sm6997104qvn.46.2023.12.15.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 09:12:04 -0800 (PST)
Message-ID: <657c88e4.0c0a0220.8d5c5.8b51@mx.google.com>
Date: Fri, 15 Dec 2023 09:12:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5985261266693022255=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, francesco@dolcini.it
Subject: RE: [v1] treewide, serdev: change receive_buf() return type to size_t
In-Reply-To: <20231214170146.641783-1-francesco@dolcini.it>
References: <20231214170146.641783-1-francesco@dolcini.it>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5985261266693022255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btmtkuart.c:383
error: drivers/bluetooth/btmtkuart.c: patch does not apply
error: patch failed: drivers/bluetooth/btnxpuart.c:1264
error: drivers/bluetooth/btnxpuart.c: patch does not apply
error: patch failed: drivers/bluetooth/hci_serdev.c:271
error: drivers/bluetooth/hci_serdev.c: patch does not apply
error: patch failed: drivers/gnss/serial.c:80
error: drivers/gnss/serial.c: patch does not apply
error: patch failed: drivers/gnss/sirf.c:160
error: drivers/gnss/sirf.c: patch does not apply
error: patch failed: drivers/greybus/gb-beagleplay.c:257
error: drivers/greybus/gb-beagleplay.c: patch does not apply
error: patch failed: drivers/iio/chemical/pms7003.c:211
error: drivers/iio/chemical/pms7003.c: patch does not apply
error: patch failed: drivers/iio/chemical/scd30_serial.c:174
error: drivers/iio/chemical/scd30_serial.c: patch does not apply
error: patch failed: drivers/iio/chemical/sps30_serial.c:210
error: drivers/iio/chemical/sps30_serial.c: patch does not apply
error: patch failed: drivers/iio/imu/bno055/bno055_ser_core.c:378
error: drivers/iio/imu/bno055/bno055_ser_core.c: patch does not apply
error: patch failed: drivers/mfd/rave-sp.c:471
error: drivers/mfd/rave-sp.c: patch does not apply
error: patch failed: drivers/net/ethernet/qualcomm/qca_uart.c:58
error: drivers/net/ethernet/qualcomm/qca_uart.c: patch does not apply
error: patch failed: drivers/nfc/pn533/uart.c:203
error: drivers/nfc/pn533/uart.c: patch does not apply
error: patch failed: drivers/nfc/s3fwrn5/uart.c:51
error: drivers/nfc/s3fwrn5/uart.c: patch does not apply
error: patch failed: drivers/platform/chrome/cros_ec_uart.c:81
error: drivers/platform/chrome/cros_ec_uart.c: patch does not apply
error: patch failed: drivers/platform/surface/aggregator/core.c:227
error: drivers/platform/surface/aggregator/core.c: patch does not apply
error: patch failed: include/linux/serdev.h:27
error: include/linux/serdev.h: patch does not apply
error: patch failed: sound/drivers/serial-generic.c:100
error: sound/drivers/serial-generic.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5985261266693022255==--
