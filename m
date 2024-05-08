Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030412B14B
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190864; cv=none; b=PTtvAyZPqlmvAADMfC0QcR6FrYo0HDjzPQjoty44u6ArHSYwet6Lr0Xqh5Rg5Twi2GjZc97kQpFDNIAc6ZpeCq8A5Iapw2APuPrv+eKAoi9wUEBlMm4QW4vmSTejSmFfX1Ttkq5ZLNkf4IyZHZ4jqbsTk0oZeC4Beq5wYHxV1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190864; c=relaxed/simple;
	bh=7KVrKgViXrA2K3BadsXiaRF1tdcCw8Hl6auF3i51O1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SrWOKnonDG55igpxrGU642Fif3CGmyGRNBYaGwzWpYVkpHHBAX3HkHMFs2IH0ynnyHPX6AjkH06nc/AxPZokgecsFaILjfdEeW2I4XsalmhjaXMfLj8fe19zOSouhvUtenWQDvupP5koEr907c6RWTAR5cUWNCK6szNHr5SHO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7XL2igX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7XL2igX"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34fde285fa2so800014f8f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 10:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715190861; x=1715795661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZD5iH1eg5eazNbzgPu7DAM/L0gA1QuI7SJWOrHHHo7M=;
        b=h7XL2igXLxP6lDvBl02kS3Df746uuwsfHSBal87h3hp0h76Qqbahpj4p5WoHjRDpN5
         2lW4UGqSSYCZ/mELK5vd0q3/PJJWLnu/loPJUkzVkJ/m7hbzBtFho8Kt/iFIAWQgr11z
         7meJk6rtB1RBVjOsrEfoAIwskNjUAbKb7evmklzI1+77zTopi1FQfvyDz2ZFSkLRn3jh
         oC3iSoVQbeXSRbMEg5WCaitfkUGj4R5cWCM+5K+mwoH3OztPTRUnHkKycdVsUFtSvjps
         QLuoz8tJV7Qni5ViThOAmRoHl8ikJqO+D4iLMtY81avGwsnIU/fNyoh9/Qym63i/iZIW
         thJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715190861; x=1715795661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZD5iH1eg5eazNbzgPu7DAM/L0gA1QuI7SJWOrHHHo7M=;
        b=Nekp/HUsZR5e3RKcDVs+XoHM3E5fxMHs3I7h3XS+gUUWFXfK+aoBkX5YB862x/ifLG
         lqlpOG9vmfH/sBpfxFPijmJVVJCMNundbSrhKVcNFDHEhfPw4cbzcxoMz+pZY9PYRnQB
         CCAAzWjlMwn+nivkPuT2HtODCn1nLguEAj2xRh0i37npZ3sbJhE6YFhv960RqIEZQKgL
         pShtGUC3OTAhgJRGsMpvJQ2URde6o7j6JAOYBzvHc4YEJKk0HQIpXEed+ysfaS7R+X/i
         s1KTV9qrFCh26aaXmA2cC3taInTD6063F4Qodn3CGFoefsNeWdRhLZehwtziKOdo6Xe7
         oiyA==
X-Gm-Message-State: AOJu0YyFMOzfpdzOBIzqQK5kENH7B4LHs0XjoGmySMAouyQvurnMS4Li
	MjbFwbd+GpBeIYeQPrYdmmDnTZubPOWzDE6ocUmkzpTk9yqm3tK1wPydcg==
X-Google-Smtp-Source: AGHT+IGbdCm0zTrG4Y/rRPn+LyG0QQmAfnAebrZRh8TnYoLTS4coNY+r+JF8sJpKXwrGhuHDZy6Sdw==
X-Received: by 2002:adf:e506:0:b0:34d:7fbb:e93b with SMTP id ffacd0b85a97d-34fca054a08mr2565305f8f.14.1715190860715;
        Wed, 08 May 2024 10:54:20 -0700 (PDT)
Received: from kali.home (lfbn-ren-1-785-215.w83-197.abo.wanadoo.fr. [83.197.112.215])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d638d000000b0034de69bb4bcsm15793876wru.85.2024.05.08.10.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:54:20 -0700 (PDT)
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] configure.ac: fix sixaxis build without tools
Date: Wed,  8 May 2024 19:54:16 +0200
Message-ID: <20240508175416.635797-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following build failure with --enable-sixaxis --enable-udev
--disable-tools raised since version 5.73 and
https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=9f71892b63f6b65dab874a633d88ae2dcad93a16:

/home/autobuild/autobuild/instance-2/output-1/host/lib/gcc/x86_64-buildroot-linux-musl/12.3.0/../../../../x86_64-buildroot-linux-musl/bin/ld: plugins/bluetoothd-sixaxis.o: in function `sixaxis_init':
sixaxis.c:(.text.sixaxis_init+0x23): undefined reference to `udev_new'

Fixes:
 - http://autobuild.buildroot.org/results/c337d0f473c5fbb3e6cda1317ba06f5e2b16a43e
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 9dea70ddc..8b3cdb4e8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -226,7 +226,7 @@ AM_CONDITIONAL(MONITOR, test "${enable_monitor}" != "no")
 
 AC_ARG_ENABLE(udev, AS_HELP_STRING([--disable-udev],
 		[disable udev device support]), [enable_udev=${enableval}])
-if (test "${enable_tools}" != "no" && test "${enable_udev}" != "no"); then
+if (test "${enable_udev}" != "no"); then
 	PKG_CHECK_MODULES(UDEV, libudev >= 196)
 	AC_DEFINE(HAVE_UDEV, 1, [Define to 1 if udev is required])
 fi
-- 
2.43.0

