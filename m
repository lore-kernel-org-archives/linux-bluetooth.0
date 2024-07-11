Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1F2D512
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 03:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720668177; cv=none; b=li7VbSzSbaKkEBsdtA8DP5P3C7HvprEbhaE+JvT0EKEFTDeQVtmPjRN7XsRCbF14qGvA0pjpgGG2HPu98YKMkgLRiQ+Z1PBDx/A+QMxDPQFdfqzNht7jiZqtEIpO6a+MgaBnQuSr2nAfQg0mKyznC5RPXDXN69iZhx+6nCjn35A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720668177; c=relaxed/simple;
	bh=ULZN2CJ3Ew/2kiZapFss+7p/ZTpMJMD7mLDajH2k+Ks=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ifo+OLjQY9RNbLa9+NbEfkZuWGYbdmv2CA87bVzxKPUxAglLUuixSSGqTvWJTxmPpUERZrIqOXYjj8bAIZ5WaVfy+hIOmLaM4St6ke6n8E464u5EikdwDtLyr7jEu6zUgk7ffBTk7VwAW389aJJUCepk6TP0rLZqR3ZsHmt1ELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdevBGyI; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdevBGyI"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4e1c721c040so141231e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 20:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720668174; x=1721272974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qKP+IDUdvaVKzCYnMQ6mwd/Aiwe9Ae/Mh81nlywGGIs=;
        b=TdevBGyIfelsCUyZhHtCTDR8hzxXd6a9+x7kwet3V4L+MWsiETOswmCnqbHV+SUaC+
         ZVrI/HztAPgr9DUx8rxWPi1JGF31gN3pEIWMs+CFwmolUAZFea2bxJ6iBy195AMAXVSb
         vQ5IzD4zF8ZjGn5sVBLiVGxwzTZnRNecZ3c4rhaN6DMGhukoxZH6yzEwzKORMlC5UTiR
         T4QL5fwsrvTruBJxbon46D/SL2ZIkGlWv1Mv9iZVxV6JPlVA0uKB9wTa8QHvEBQtpQA3
         Sf730whOegiEZiSDcf/Jf1nLPS5A2kb5xCcbgH7vXwlv7LA1cdRiKVBZNMaq1ysnP11r
         U2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720668174; x=1721272974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKP+IDUdvaVKzCYnMQ6mwd/Aiwe9Ae/Mh81nlywGGIs=;
        b=wG4DRFAmXW4MmMRSxyMlH9Bm2NfFBfMBYI0HskjsaIvrsRqTHN9xo1SZ/3rkb2a7WX
         KeiuVkqvUyAKzZIRZaJNunxui5Z+ZvvKQ8cojbr/I1NCDBRHtkmrCNeUxl3I+R3zZiKF
         RjkWkoD9PNoXQXv48+/Ev2YxKrt6fRATAbjsizuI00nn3199+OS9qDGxWKWLyT8Igy7u
         i1T6pZOFp6doHiAxFFKycM0HqNwD/Y4JTK53AAihcfbHWItPxQP8YdGnGdim8Cf3VSAC
         uVvcynlaJtn73sE0qDX1BqvihdQXd5xkYxmUqy6yKHS3fytOKlBJvlFck66Tgh1UlsMj
         dLwg==
X-Gm-Message-State: AOJu0YybzVtslA2/8/0ptEUXOVkyZwkQosnppWx07k7T36v81HjtO6Gd
	RqY6JfoQqQKMZ+Sh6nwDAmmbZW4h/K28GiSVkAKb56txxg15CHTeAYZXmRIR
X-Google-Smtp-Source: AGHT+IHCbhPp3OrIJNpnLo0BPBgQcruxxixy3MhkNDibw98fAavlzdZUFx8LCwck10a+xt8IqpWoGA==
X-Received: by 2002:a05:6122:4109:b0:4f2:c7ad:1ac1 with SMTP id 71dfb90a1353d-4f33f33c50cmr8603250e0c.15.1720668174052;
        Wed, 10 Jul 2024 20:22:54 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f33da55a73sm839177e0c.29.2024.07.10.20.22.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 20:22:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_qca: Fix build error
Date: Wed, 10 Jul 2024 23:22:52 -0400
Message-ID: <20240711032252.3560262-1-luiz.dentz@gmail.com>
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

