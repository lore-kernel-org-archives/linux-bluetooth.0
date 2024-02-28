Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0836A6EEEA
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140723; cv=none; b=OzwmjT8wve03WxCwHsgA24Ny/16l6VUgeoqe9ICTJ4S7/UaCIUgdq1VFJx0Cde63BpvBI+Kmr3RjbsB9tvBRTbgH4Hl6+QZ66NXK1WqRwSgJ11nU6CbfMxnyE4gu3XLXZWzB8aW7bO+jdC2Nxeq73QmSbyShJ1UZRM+cQQCBFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140723; c=relaxed/simple;
	bh=EbhGXVWDv4uTbN4g/cb9lNJDy8bsfocGMQd5k7SjruU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JEvS1fiDHe+h4KMJ3WDabtpzBsL3Uw5bhS3LvYDeYeUhkGjzaq0H/+/Mrt4IwVyB/JhWya67Y/O3n8t3+tFdlBXQnvXWpshzcfhkFQYZH1XXFI5uV2Flo5g/Bvwtrc1zgil7dmKAEn89Frv/8T0vFk/VIeF+XPElStElV+txDY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoyyyNLF; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoyyyNLF"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c19b79535aso3087088b6e.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 09:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709140720; x=1709745520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1thNE+TSw6a29ubGw3hczldHJVUyaRqAEb3p4QN3oAw=;
        b=FoyyyNLF6yz4Z1iiKrc/Zn5ePEylZsEdls9x928Nb211azrom15NGbZUauPMBme4e2
         jfc3ih3Cx3fjEU+br8Duv9WNApOMfCFPribfu3Tk63bHcUQmTBYqhC6EwV/fCDHEaRkL
         uVN4KVFP7AUVhRPf/WUbvpl/a0ICWF2QlI74PgjsDycSUwz0AcBULq3YVl2Ew9Bl/Vwm
         ebbf845XXt9f63eZPdx4z6ujpiQwDJdtN1CZoAHtAS6y9DoF4oVyayfM0XJ9mb2ui2wa
         7y0jak3tUTqDMxaDPXT/imrlnUHx7JvCp+Qr+KXF/H9CeLxQzeaxa5T9rhmcItcKAHEd
         q0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709140720; x=1709745520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1thNE+TSw6a29ubGw3hczldHJVUyaRqAEb3p4QN3oAw=;
        b=LzdIgDXXjEA7reqQtBmagwgTzFlySJPrADjQh7CDtqA5TeQdSfxdNbgSPRyK9tyDlX
         /5Waf6cuffY5LoCbUvVcRgyTbI5HxlbbDIAd/SCOYYJ19rSpDwCipoySYyalaHN3rLLd
         2cWIVCpRmLT+RxPDyqPdxtwZXezsL48tpjmz7/f1b65rSUnBg3dTiNQ4f0lmv1jrHUQ6
         I9h4k43dMvloPfUY3gHnJVaTsDbfydB7AFFh3ACCzPUwTGTd5USA2pVaif5BHdSGXtFs
         wlUorT3IKWP6Ih2nU3wJessgTlpYbL9/649YDfAhStYBzWyl0Q/LQw1VsIkHbkFVxjmn
         r4vw==
X-Gm-Message-State: AOJu0YxYEPN7PMpocC7sg2wdXsKm6Im03T3gdIBsOEPGChtEt/ZFlBru
	YOoyHLxoESAF1k0QnfkiRJkA3c0pi8dXkr9MkW95aQEgTCo0Zgwp+gWxR6xx
X-Google-Smtp-Source: AGHT+IG1SkRh5ynL/WJcCEU3kwflNGMlHi9UddWOTZr2A6nbScNEJol/mbOyCmrpmfaiEYRUNXiDfg==
X-Received: by 2002:a05:6808:151f:b0:3c1:b181:6639 with SMTP id u31-20020a056808151f00b003c1b1816639mr5340061oiw.44.1709140720038;
        Wed, 28 Feb 2024 09:18:40 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id q15-20020a056130028f00b007da5ea1638asm1488240uac.1.2024.02.28.09.18.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:18:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/4] Bluetooth: hci_core: Fix possible buffer overflow
Date: Wed, 28 Feb 2024 12:18:35 -0500
Message-ID: <20240228171838.2414532-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

struct hci_dev_info has a fixed size name[8] field so in the event that
hdev->name is bigger than that strcpy would attempt to write past its
size, so this fixes this problem by switching to use strscpy.

Fixes: dcda165706b9 ("Bluetooth: hci_core: Fix build warnings")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2821a42cefdc..3715d2f3616f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -908,7 +908,7 @@ int hci_get_dev_info(void __user *arg)
 	else
 		flags = hdev->flags;
 
-	strcpy(di.name, hdev->name);
+	strscpy(di.name, hdev->name, sizeof(di.name));
 	di.bdaddr   = hdev->bdaddr;
 	di.type     = (hdev->bus & 0x0f) | ((hdev->dev_type & 0x03) << 4);
 	di.flags    = flags;
-- 
2.43.0

