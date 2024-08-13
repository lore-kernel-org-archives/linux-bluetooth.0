Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538D51CF9A;
	Tue, 13 Aug 2024 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551637; cv=none; b=prXJRRodnRDnVydT5v8xTrwqFtabL+/Y7Ys4cZrpLDAUQte/Fr78zcafa8zlJmaYO/hM4GDXC/XEesxYHqlCquz4z1BJ9tRopJNTEZLJexp4uEas/8+Psgb9nK9qYg1uKrNv+3JJqDZHBno8iaN4mHVy8PJ47+Ah6T3vzViMgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551637; c=relaxed/simple;
	bh=chAb2GOyV/hBwqq1AGYRaBy1jbqHrZJBU7pvL4YwHDc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y+jqoFcr1K7+fD96DYl+WzPIvUiRujtJjwZ3mDgHP6Ral8/2XDC9b3emC4dWEgaZMkuBMyjsy2qajk5MO4VA8vZt3jTGn1L3LvJerUj+Id7g4Jdp98ZQC+DOQqv++v7r82n65PbXXRnm2IaJm4PzUMGpW67yM3EoX8YDzagYmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuXS0sHj; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuXS0sHj"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb5789297eso3588521a91.3;
        Tue, 13 Aug 2024 05:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723551635; x=1724156435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3mWR2mtNanCFR3pbd+apr4voFLl2lzERm6XILSMuMA=;
        b=KuXS0sHjU7E/ZYLCTH7sGFln4r6nUxZ8v9ep164DRaatKQIFC2Zt4v6uHMdQXxlV4b
         g86LYb563BSDYAr43eogjSLjGwpZIKKRgzldblTVtjZXxEXtoCxTeTPCvL+33S/piLRh
         rwIhZa+JjuTDIqTItnwGM+1h+JZZOSAqE/ogiIA+g2x9eVqkz335RTsgDl90x5CMa1Bb
         MuWqMRLiwJo6xustLuteYVP7XrhX+fy4zuU7adZx1sOJmyxmUf2495WHRVqwQplJUt2q
         kGd7HMlID+pie5wM9uGypMZOqs4sMHIZTKixekPa5jvCbRPovFjTx6vHbY9DVyJ52+WG
         VYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723551635; x=1724156435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3mWR2mtNanCFR3pbd+apr4voFLl2lzERm6XILSMuMA=;
        b=GI/pC0UFDvByTnUO7VC5LMU66wuVcl5Qv3bcC61EuRann0FMmm1Fiq3vv5boI102hG
         RJEaygzsD472DvmZ2vCaEyMPZ4mDbU+K69hvf/9ZKjAtluthStI9VualDKXfcLSdgIDd
         PSlBF8sVY8v3BJG2zI3Wf7lIJY8w4+Oi9qQGNOIwdtaV9t3JwiY6kvvxJosw6cL0g6y5
         U8e5Lrlcm0hT2GT+f5odaHFXzmF2IhD36fz56LuSeWuivXGYj0YXMLUdbxiLfefu9VT/
         iAoYRlSuY0oXlljmBuw/GYDceVHKNPGhfjuiF/+33XUPgPkyu2aHcV2XAl8aDr5BS2fv
         4oEg==
X-Forwarded-Encrypted: i=1; AJvYcCXwXfxoetyCvK137GHpYsuWq5AXfTgIQEPdk20WdRvLZs/Ha3IPxrs45zLWcabQgvx+SbNqvjxyu5FF3UgNuIJZB06Lo1unUkXmovCmlk3zL7aNe+Sx0aFtFXlQ6ddkRGwIsAJV1/jeGjKRVEhc
X-Gm-Message-State: AOJu0Yw1EymyKQzG5iZPcLfqPPrxXbbW2KCeMuRg0WlfmH715UvObUJM
	HMV65mc12KRNX8t3WJQCksInhmoQKEqp9WoVDB8QDrCcNhwJj/t0
X-Google-Smtp-Source: AGHT+IE1wpvYvO+X8aOgD1ucXI5Hpo8sCpkifzovrkkhUkzJyZM0MyY3uf4Jalzh0qzJR2XxEwT8ww==
X-Received: by 2002:a17:90a:7448:b0:2d1:b49d:7f2 with SMTP id 98e67ed59e1d1-2d392548219mr3858002a91.22.1723551635481;
        Tue, 13 Aug 2024 05:20:35 -0700 (PDT)
Received: from 0x7f800001.hitronhub.home ([2407:4d00:3c04:81a0:c062:fc81:d816:8b73])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d1fcf06589sm7092679a91.25.2024.08.13.05.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:20:34 -0700 (PDT)
From: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
To: 
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	ricardo@marliere.net,
	skhan@linuxfoundation.org,
	0xff07@gmail.com,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: vhci: manage mutex with cleanup helpers
Date: Tue, 13 Aug 2024 20:18:28 +0800
Message-Id: <20240813121829.6693-1-0xff07@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use macros in liunx/cleanup.h for automatic resource cleanup.

Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
---
 drivers/bluetooth/hci_vhci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index c4046f8f1985..70f0c28372ec 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/poll.h>
+#include <linux/cleanup.h>
 
 #include <linux/skbuff.h>
 #include <linux/miscdevice.h>
@@ -468,9 +469,9 @@ static int vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	int err;
 
-	mutex_lock(&data->open_mutex);
-	err = __vhci_create_device(data, opcode);
-	mutex_unlock(&data->open_mutex);
+	scoped_guard(mutex, &data->open_mutex) {
+		err = __vhci_create_device(data, opcode);
+	}
 
 	return err;
 }
-- 
2.34.1

