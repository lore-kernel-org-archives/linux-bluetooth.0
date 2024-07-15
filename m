Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA844C6D
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 01:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721008278; cv=none; b=hnRxxZnF5y29oFK+SeBC6FQqRoVfneRP2aWGOt8c38BSrC/AEkdu+rZKoWq8iXacBCuruh4j9onFTiESq2EsN6l5YvBh+ZBzE3kauIUkRjOcp8cvkEMaptG7KBBNAW1EhapYnbysEv6AYnTkZiFXRKOXqQk0kdT01IrQKcUCn0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721008278; c=relaxed/simple;
	bh=ULZN2CJ3Ew/2kiZapFss+7p/ZTpMJMD7mLDajH2k+Ks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skUvDmpY2s1xuT/FcnolYXZcftbOYZ/QUkUln8+AkbQ4NuhiZw4cl2BjP0vXJ0jTYihBZ4MQXN38vm5JcrzH9A93lKlwNcmWqzf4PnME5OWr9SOe/pWV2H6EnzCRFyWSeCuyNdm3U4JM5fXZfnKgdVNef7UmG/45ktCcMNVlg6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3U+H5yN; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3U+H5yN"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-8100f08b5a8so1189936241.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jul 2024 18:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721008275; x=1721613075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKP+IDUdvaVKzCYnMQ6mwd/Aiwe9Ae/Mh81nlywGGIs=;
        b=P3U+H5yNANwDy04KYgjc4SiivuPLdQWJURJz2N6KLaC4FsFCq2vd78px7QtQdtRxZ2
         43XQbYuPVlrthdIvAMfObKuyHfh9WgfaTZ1BmdFRatJuk12jn4OZf/Py/tf/Hk0Lxn9Z
         UBqv/Ge4zM2EzBVkz+G8jJx3O53bt/xLrfocJCVObE5Ut6f50KGKxVh0LWLOvF8z8jMe
         66l4LeNakLLjoFceb2CXx7O6KLRoFgbjwhKG6ptPDQ0NSzYodDDeAXdrrhX0C3w6PzgP
         3U1QUj3dKT4Wq0zegIrvxjEXDdcx1uIFjWMRt+6tvmvwH8Ue0kTtYEdeGrKaXxxbCIHb
         54zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721008275; x=1721613075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKP+IDUdvaVKzCYnMQ6mwd/Aiwe9Ae/Mh81nlywGGIs=;
        b=mNZ4G2agZvufKPSb5agvzkHMWQggcUmM0g0nhC7S1r/296eizH7/MrMbkHMVfiQQXa
         LJEgQm+o/bltk5SMdfZZAQPIXTb3YN7xRjos1t+LQAUJMEvH3hulLGnKgvzqYh3x1y5x
         w2JxRYj8/adJeD8cZ6mZrBtFDb9/ePEDKFOPbfig8nAP9G4U3OwwIK4LR95bL+fPRsJ9
         XsP2JTOl87ryd+wrPe3xa+fkOyCRgWk6JUrWxqCUtjG7D1W1D7vBmKRFYTtB9YZWuWl3
         xn55Hg80o5ynmHqFBPI6qPpEn1/irld/dK8CD4eT8whXq7djW+SXEFl3WcOx9JPPLWHj
         ck/g==
X-Gm-Message-State: AOJu0YxET5wZd4P46BoUeEWKfBpYlhFwt61298A5EtPxq0/463ncmcZU
	/0wV/tOIRepvdPzaGNp+HdwRLTtL8FEQlxoPGXfNe9CNggB3Mx7X/35ObT8x
X-Google-Smtp-Source: AGHT+IEGi7aMapVJe5iufk4URQ/YRLEvQnWt9HsyGqpE8uvzsgrvnjU87Cv1QQFzjOg7wes46xijYw==
X-Received: by 2002:a05:6102:c54:b0:48f:e49e:ef1a with SMTP id ada2fe7eead31-49032134dfcmr21172419137.15.1721008274349;
        Sun, 14 Jul 2024 18:51:14 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4912b22ccb7sm746521137.30.2024.07.14.18.51.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 18:51:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_qca: Fix build error
Date: Sun, 14 Jul 2024 21:51:04 -0400
Message-ID: <20240715015109.239742-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715015109.239742-1-luiz.dentz@gmail.com>
References: <20240715015109.239742-1-luiz.dentz@gmail.com>
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
 drivers/bluetooth/hci_qca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 030153d468bf..ca6466676902 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2499,6 +2499,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 			qca_power_shutdown(&qcadev->serdev_hu);
 		break;
 	default:
+		break;
 	}
 
 	hci_uart_unregister_device(&qcadev->serdev_hu);
-- 
2.45.2

