Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8515538C
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712177607; cv=none; b=RfU/wKFdBoPqSZknUtkGlTMXSnmbmQNAGbQ7JsHh5B1LEZxGrkDVbBChjE+ctnCHH2aRtSzaHALzAv4dFDezv1KANR8M8exbVC9NrriIwmXY/T4QCRHIKUdD11hB5rFPl+5d3zZnpaLSBYDmrzZXgjl6lpXLz1wMI23BSK6iHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712177607; c=relaxed/simple;
	bh=ucgYXvcV9gUnnHopviv7eHg1gM4m1vSITIxqt3bjUWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kND5CVLn1ECtibWEn4lLDSFtz/YmrRBqkYwT+WUt90SIVr5zUnCW2DtgAHnVgyoH8tJG+dud4j6KRf+RTrww0Y7gVf9O/c0Fqk9FypG6Q9mGDCB8KlK+JDfx49+clE9fIam2gkSNIDjDiOhpAFecGBgX+o9ph0ZNOs7RmN30j+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZjL6EYT; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZjL6EYT"
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-5a9c71969f1so188415eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 13:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712177604; x=1712782404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pHJ8MXql5Y2LoY4bPduKnVs3WStY3AN4YA6LVK9wANY=;
        b=gZjL6EYTEzUZW5SXiDBF/uiU2yk71IsWya9zfIpnknNU6MUAW69lCNts8h7HR+t4h0
         V92H/fV48cXO7n/iedfnmP6l5faSYYWs1ZEuCgQHUWzCq10Bju6nYnDtRMTkYMWOLMaU
         umnESrZOvOTxwGaT2/HXG8XAu/VA020HLXVr9XrbLgrSx5aGJvWRUuMb3z0WJut+OOnY
         cK/6tpE01N3lhyvdMDg+AOKelxf4WyMp3r6klY/L3NOOoZA0IrLuHLykwncdB4KzZcrg
         Th7Vx7J+I9o1d+l9P5kebWaOAPBfAT/1DA+Rhf+LBnWLHUxqteISK6p3xE7ZH30/aGVe
         /GYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712177604; x=1712782404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHJ8MXql5Y2LoY4bPduKnVs3WStY3AN4YA6LVK9wANY=;
        b=UsRWspddNmr9xLCsn0PBW1qqWaqQjXHlBA6PE+e2uV0umx9EIP0F0wd9XQVX4AS4S9
         /53oGH5T7vVwtbY/ROy6K4ypL/RnHSKPmj/3dGNmI0JQNWcA2Fvh0Pmp7mgzX76dDWEO
         2eXxrvZPO5d1tfqc+lZbp2xaKKQomxs1OBTWvLmk8k0kw4pBIe7Ukc6ivFqMnee+trSD
         hPG50JQ10a5xxSA2sYSYVwu5bmACAHfxfmOQFh37vkleemEHCivPXf/YIRjBBBjDAW4t
         EnRRWJd1kVmc5g10w8gXA7Z7cmZnuFpA2lOOaTjpDiCRf9we463jhs1TThMEemgVr++A
         mhBQ==
X-Gm-Message-State: AOJu0YyQLKXWx0p1/HS05VQLbjUx0pY7W7afWiQpNZ6DgZTje19ds+kz
	mmHf4gRdsb654Ey0drs0T7BvuSKyropnB/1HMawsV8xdAoFAmugKAZEfFX1TnQWpuQ==
X-Google-Smtp-Source: AGHT+IGFEgacwekRT79qoa70RFfiT9X9fOWy21DI5WLBfmZESa9uxNPDveNblmkoy5YZso3ZHAdAbw==
X-Received: by 2002:a05:6358:429d:b0:183:645b:cf8d with SMTP id s29-20020a056358429d00b00183645bcf8dmr416612rwc.16.1712177604303;
        Wed, 03 Apr 2024 13:53:24 -0700 (PDT)
Received: from angua.lan ([2600:3c0a:e002:7f00::1001])
        by smtp.gmail.com with ESMTPSA id i18-20020a63cd12000000b005e438ea2a5asm12159259pgg.53.2024.04.03.13.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:53:23 -0700 (PDT)
From: Dimitris <dimitris.on.linux@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dimitris <dimitris.on.linux@gmail.com>
Subject: [PATCH BlueZ 0/1] Fixes busy loop when disabling
Date: Wed,  3 Apr 2024 13:52:51 -0700
Message-ID: <20240403205252.71978-1-dimitris.on.linux@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reverts a commit which causes bluetoothd to enter a busy loop if
BT is disabled (eg. rfkill block bluetooth) when one or more
devices are connected.

Steps to reproduce are described in these reports:

https://github.com/bluez/bluez/issues/785
https://bugzilla.redhat.com/show_bug.cgi?id=2269516

Dimitris (1):
  Revert "device: Consider service state on device_is_connected"

 src/device.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

-- 
2.44.0

