Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B04A48
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168945; cv=none; b=OPll16POovDwmWn7iWtJe7ktr4oDyvsFbAuW4sBhW80zqxW4brdv2YCfcD6XRpcnWMDjSIt1JxLufFAcDaRKzgNYwzCrq7gZ6xdh8GOcgVve9PJUFgoOz+ZVk0nHEsiD5Uo1erssrcVvzaZRI1zjy9C+Vmzf5JvRJFHD2bUOTvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168945; c=relaxed/simple;
	bh=tNUedDh8w3V/7eQmQIX2iHmHwldmcdPvXAL0fhbucbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rw2e0OT6+3bg5CO3UiSo6Z7Q7ib/ads7m/IJxvbtdZhnp9VSQA6sPmarzQ+W2YYnbBSla/IH7gCLW6hrEBWMUSkLRj6EU/EZgojaQDVKDC5S8uYUu6+ixBXNLf6NjxpErgUZ6W6PzDsMJwV7sXJi1bjQ9FHoqAI/B5kqseH7o24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqFb0u6M; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqFb0u6M"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77b550128dso174438966b.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2024 01:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720168942; x=1720773742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zXbJqA9xAL70XxQpzdHVKi9L3eBoP7el5Xhunp2Z0DE=;
        b=KqFb0u6MnnqFyyT/xTRDICWVEkXp0NVNQ6YX69QNXJw+ocNK6Ogq5V9lM0RJmfUNR2
         7o2MfJ/wqlsvydF3OxoyooU//WXFx0je5/5hqd94shzEZK4v3GF28q0UJbJZCtw/kAzv
         J85lcFcnZbvPm47jhuyizkZzLmiJ/yWfuWnRxOw/VlWlMLhklRzzKkorw4Du3VHMc0sQ
         J6lYyeu2fCTl0cl+YnyODamJLX+7g7YGYbjYyJDSy7sO1cVmpkGGB1bbx/a+4+DMeJW2
         7zk1pPPg2nMu+1jT3h2jf1sE/EaY5J7JchUNjgAAHfQu/WoYERSkxnIC3wapsvEq/uw3
         nbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720168942; x=1720773742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zXbJqA9xAL70XxQpzdHVKi9L3eBoP7el5Xhunp2Z0DE=;
        b=K8OwUq+af13/dkQcdX6dV/oRAq52RDOeuGANicjFNud4lgz9wHUnE+FPPA3siKg0kF
         3CUeKHorv9gMU7dx5XYciw5SAOlj07Ld/mGhK1Ny9SmzqE579+g4cjTyoz1xbxYH4zCv
         TujGMOvmSFAR3JVBfn+hOx7y6qmyY0x2skyiuCs4L5Ot+Vw18HuTXlrdwToLz6d9qAt7
         fyC1KsErfWknilRxv23JPWvKCXLlabi7/tB4qlmGT/inTeQDI/CEQMDu8Zp3ifA9ZIYI
         DJobdNa7Hp8eu3Hcanu5Q7/M4iWXFVISnhbhXQ9287CPPZDQ1INDjyie3EoNamuy4fOW
         bhKA==
X-Gm-Message-State: AOJu0YzgsYJeLNmSyC1G5yvcP7wFA6tXdcBGXyaoovvM2HxRhA+MR/o/
	92IaCWMBBsIvNPt6g/+vXEenXE+gzKNEyryrHbHGmBws+4P4aFZhm/8t1g==
X-Google-Smtp-Source: AGHT+IFodk1/Iviu+PY0xpz+DAA9UKgeRS1WGl/+dvRm+yoHtd2OXWCQk8kwVaNooKAJyUPjksyeng==
X-Received: by 2002:a17:906:3b8e:b0:a72:4676:4f8 with SMTP id a640c23a62f3a-a77ba70d755mr226158966b.62.1720168942218;
        Fri, 05 Jul 2024 01:42:22 -0700 (PDT)
Received: from Firmware-Linux-VM.nox.noxmedical.com ([213.181.99.234])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77cc9466bcsm35826366b.183.2024.07.05.01.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 01:42:21 -0700 (PDT)
From: =?UTF-8?q?Gu=C3=B0ni=20M=C3=A1r=20Gilbert?= <gudni.m.g@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Gu=C3=B0ni=20M=C3=A1r=20Gilbert?= <gudni.m.g@gmail.com>
Subject: [PATCH BlueZ] configure.ac: Fix --disable-cups
Date: Fri,  5 Jul 2024 08:42:16 +0000
Message-ID: <20240705084216.552838-1-gudni.m.g@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

or else we get:
  configure: error: conditional "CUPS_SERVERBIN" was never defined.
  Usually this means the macro was only invoked conditionally.

Fixes: https://github.com/bluez/bluez/issues/773

Credits go to Lars Wendler <polynomial-c@...>, See upstream patch:
https://lore.kernel.org/linux-bluetooth/20240416052603.4373-2-polynomial-c@gmx.de/
---
 configure.ac | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1d88daa0b..5619edf4b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -253,12 +253,12 @@ AM_CONDITIONAL(CUPS, test "${enable_cups}" != "no")
 if (test "${enable_cups}" != "no"); then
 	AC_MSG_CHECKING([cups directory])
 	cups_serverbin=`$PKG_CONFIG cups --variable=cups_serverbin`
-	AM_CONDITIONAL(CUPS_SERVERBIN, test "${cups_serverbin}" != "")
-	if (test "${cups_serverbin}" != ""); then
-		AC_SUBST(CUPS_SERVERBIN, ${cups_serverbin})
-	fi
 	AC_MSG_RESULT([${cups_serverbin}])
 fi
+AM_CONDITIONAL(CUPS_SERVERBIN, test "${cups_serverbin}" != "")
+AS_IF([test "${cups_serverbin}" != ""],[
+	AC_SUBST(CUPS_SERVERBIN, ${cups_serverbin})
+])
 
 AC_ARG_ENABLE(mesh, AS_HELP_STRING([--enable-mesh],
 		[enable Mesh profile support]), [enable_mesh=${enableval}])
-- 
2.43.0

