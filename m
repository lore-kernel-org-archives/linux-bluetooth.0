Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA4B8F4E
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 02:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665183; cv=none; b=ZHG7KQ1gQAp/VMRWyXG3MVjJoreBc/vWlDBR1IYQd7Ex0Z8648NGkKD7jcUqOgdNpF2Ju5vm8zXCFTZzcPrSPCoz5r39eZkIX0zqf3FSeyjrXWAbenosUbqW2duaHzBk32sDDRFQtVbsLQXJL+++HVLrj+rJ+qIFiGIA4rdmMGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665183; c=relaxed/simple;
	bh=PcVo+WkYEv0ZaWwNrmR1JrK89fZpzeHCtehqjHgml3U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dq51SVZUnjc8x5TjA2p+wNbIwtBDZIIKPJlNo0sgxACyi8+r6WmA8+Bvpxbf0SPySdKxBrufc1ssb+ofQ02ZuL/2B2EfplKmdE5OcH1P8kWI+FTTr1e+YHDolV2GTGjopj3tyQRG1voCZqggsfooWZL1B3NxRn+6R4jT+HAJVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyqveAH/; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyqveAH/"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-48ff70394fbso141994137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 19:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720665180; x=1721269980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vmbBxB4KNJUaoi9Aq/i3IeHpwJgZcQ6tyttcjKrberQ=;
        b=PyqveAH/Fl8aoSYij6ocpyXqD2+2GxFjwG87Ld1IS+/eguHVFbNGRPua0XYmsgJUDP
         MFtWtqUny3hX4QkeWIFjRny1vMfjKTSxT2V0mS8UUYtbDoAJEXSP1iclYGoKb04lbed4
         kWRSBgiRhIKymXriVCzCseJzoL6EinWaP0gs+p7eS/JD7HoVMdictoyBit4aNLiFBT7L
         EgIBAMF/wN6mUkSYXBFmc2ysa93O542pfMYpe7jdnuF9XQES4nKOXD55+kxX3YuDUSU4
         RDivdRC9n7DqDlbQekURsazk9Ao4DKrt58ZEb57genPb9xqXMgxCDdCDvKHnpaG1BlAP
         bMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720665180; x=1721269980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmbBxB4KNJUaoi9Aq/i3IeHpwJgZcQ6tyttcjKrberQ=;
        b=nmuQsLWsRS9rW41z7D/L71ZARS4t8v35Xc1RwQTaMBodnNymxB8mDYtvB2MMQktygT
         Y1H48zme/+XKOmC+a0rZ762ooRpmqbY5S8TVFshW0PSOjFaJ9AXuZx+zohDdeDSS0lXt
         p3Mr6byccONRSlOzVyPEUfs5BFVRXfeQF3roMYqCfKKLRndPaOSjvi4IhlJS1WrDByKX
         qlwQPZ+XmXc0naF7Go6eT+sQmnMh322GA0owoZ8S9rv4QGKlEYZQpQnCfuq8v43/TRHG
         HyPj+7a/EV8fVut7lBE9GGlce9HwGGF2QH4xUvy5w8LUxntIW0o25bXAU17LQD46YBt0
         sMFA==
X-Gm-Message-State: AOJu0YxxPFioeGc4/4rBos9ehW4QmMQWxiMyKxi5v2vOLqI3t7Hhkdly
	IGQaihSrjSe3uo+uabRzWyhuASYSiMb/gHuZ9jTYvsefJoKa7QNvW6gxGmVk
X-Google-Smtp-Source: AGHT+IGN/PxxNhdHwAcx3mvjm26iPkBTd7wcJBH6wA/zgDVkWMTgXjV0avjbuEuOyvGMELTahvg0DQ==
X-Received: by 2002:a05:6102:1614:b0:48f:3fe0:34de with SMTP id ada2fe7eead31-49032113d59mr8990699137.11.1720665178504;
        Wed, 10 Jul 2024 19:32:58 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-810769291e9sm746831241.34.2024.07.10.19.32.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 19:32:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_qca: Fix build error
Date: Wed, 10 Jul 2024 22:32:56 -0400
Message-ID: <20240711023256.3546349-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following build error introduced by a887c8dede8e
("Bluetooth: hci_qca: schedule a devm action for disabling the clock"):

drivers/bluetooth/hci_qca.c: In function ‘qca_serdev_remove’:
drivers/bluetooth/hci_qca.c:2501:2: error: label at end of compound statement
 2501 |  default:
      |  ^~~~~~~

Fixes: a887c8dede8e ("Bluetooth: hci_qca: schedule a devm action for disabling the clock")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_qca.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 030153d468bf..2664c994734a 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2498,7 +2498,6 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 		if (power->vregs_on)
 			qca_power_shutdown(&qcadev->serdev_hu);
 		break;
-	default:
 	}
 
 	hci_uart_unregister_device(&qcadev->serdev_hu);
-- 
2.45.2

