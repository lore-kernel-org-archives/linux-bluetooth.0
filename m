Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCD94E4C43
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557375; cv=none; b=k+hFq7btN6Fk6d6mXWkZHsV1FEI9KwpnkWR9uEbLnerJWvKVYRyGQyZFDgvv5rTl2h3Mmj4E7ijqxbKfuO51VHGGpvhjbKTdkBA3+wzS6Vmj/AFK2DF1llELZuY4HfKtyQH4nz/fi14E880E2X462oe8zf/PydJx68WSsB6pNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557375; c=relaxed/simple;
	bh=gjlVvJnHRL+z5iRriL+Fjs9l4WC/p1Pf4eg5Tn3PwIM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fyvGS4Uv/nrv1as23X73+G449STA9CF1F7rcz0vB+C7bsaBNJQgcdKkQb+lp9U/J1o3AdpMyABT29zSUbprUoYwV+BLKRXCfkqywxO4wl1yRbSEAK5BXdURkq1ZS2GLiCYrkNSCRbx0emWrxq7ijmUoUtr4wb1AelPVdh6iKH5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPu0rsKi; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPu0rsKi"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4f55a53898cso2324956b6e.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791557373; x=1792162173; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yU8ujqgeyE/frbQjpM9p7VMEZy/3VxBgRAs5Zq5wo1Y=;
        b=pPu0rsKiExFsomVElrzrS5q2cF1untBYKgedv2r0E+9nbsSmZVzlZ0WD8acXVZijCQ
         tenzjzTh383AkYnNBNpoBAcqGyKtOpkcIqOCwxrp/jb7A+cVWptPXnRKLBL7hszN8raD
         maGcV4ijznSNLQMw3jeOjOgquLZv9A0JcRSTEqcbVIChDYnf2ZMo/gTf12m161tQIOP5
         UWl8V62bNCAHNHIQoYkRLvWtCBDc6egsld//GuVNb2ecGBZwQMS1foKuv5UstwJOY9mw
         eGqHz/KbwhR5AQ5YzdKnXJIJ90t51EUb2VQUiDv1bW8nZ0jBORssZl01aNV7K6BMU4Hb
         fgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791557373; x=1792162173;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yU8ujqgeyE/frbQjpM9p7VMEZy/3VxBgRAs5Zq5wo1Y=;
        b=IJhdxNgT/enXznDmbgRXC0er9aZaLeFFHp6xEIOPeCbkbEzjS3pxtIYjCUE1vGCWez
         VElB1jxQKa5ftg+S3B75ejQbR4WWeomQn4UeNqa0UDMWZPzM7qZ655z8BsTDsEqlQRRq
         gnQByTb/UhvyCFpa3+yC8affl+ptWUyUkHcmFOdX8I2tFW+kq+9vHtRtvU6tnNU9Sh7Y
         5inf40Q0Y0YIrBhlk7L+hODmyKpvmha35pUOov2iKCKParRqAxI8nCR+TyXRXiR4sad7
         iO3X1YqlkIdgEvrZXukROtKKRiOX4VGT5NgFI0pFd8+CKbqTl/rElbveyLIha5Ed1F1G
         DYRw==
X-Gm-Message-State: AFuF++ntYQgnJQd8b+adanInCuSzEzKvBaa8bh7njctkv3JXvkmT7GKC
	vgwSEihT7gV4LIpTMw8JOuqYh4HZcL07hhordjRD1DoZ+hgU2TIQqCyz+MGr3g==
X-Gm-Gg: AYBFou3KA9cMoXu5tCRoT8A1iGVMrTDCkZ2yJFUMel1e+2E3PWCWDKFzDgJzdTKlj0z
	zGleOPkmsBoIi8HCxVZYY+dAEPsHbc6bc1hEqge3x1EZ8qlzX6vL6vktMwcwvu2d/TF1RqLtKwS
	Y8z8wAeWTEMXNsN8hPh2MKbshgxs5HUpun2rU6Q55FiBb65r8UMvLxDHnCtM/8TO5iddyWeRx2w
	fs55934Lk4JJDvkk4SjnnUq7Sa8Mzcyzsrd0xVeJmA928D4B7nSnNUgcDSful6WNKgT5TRpdiVQ
	MTBY4jf49SOwfWAXvcV+XXpTP/OCcF7Y2SeyxNWZdEmZrrD27cxW1Nif5ELedFZWvwVzMtbEXPm
	A5DaNXYAo9+jviJznZ+e85eyZJwMbra3AfvfzIysPrKHOIzTxLPpbU7o26GUK9nZqi/ZFTcrMZ5
	5Bqv5YKQRPWXY6CVPorhLbiyhb7mLw2D8QfQr5VxBzn6NveO6n/vUVsycFokOVeu9mF469vgOOj
	8tQFw==
X-Received: by 2002:a05:6808:1918:b0:4f4:3f10:830d with SMTP id 5614622812f47-50c5b27c152mr1996731b6e.53.1791557373284;
        Fri, 09 Oct 2026 07:49:33 -0700 (PDT)
Received: from [172.17.0.2] ([4.151.214.110])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1c120ae6sm2062543b6e.17.2026.10.09.07.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:49:32 -0700 (PDT)
Message-ID: <6ac8fefc.e5f0f813.2078e9.7739@mx.google.com>
Date: Fri, 09 Oct 2026 07:49:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9003466634910803654=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: [bluez] monitor: Fix stack-buffer-overflow in packet_hci_scodata()
In-Reply-To: <20260924-fix_sco-v1-1-ddca18333914@oss.qualcomm.com>
References: <20260924-fix_sco-v1-1-ddca18333914@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9003466634910803654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [bluez] monitor: Fix stack-buffer-overflow in packet_hci_scodata()
   Pull Request: https://github.com/bluez/bluez/pull/2576
   Created:      2026-09-24 14:24:18+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============9003466634910803654==--
