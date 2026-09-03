Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1842349CC4
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445835; cv=none; b=nhM7TBggA9jNskXBduHYt+9/od1jFAEyq7DYTqtkSFJVQT6hLhjRC4mD0vY0JhzJKU8BoPdd7Zb1WA2bGuSmfJxvYKGHmXlWBJB5km5RJ4CGx/xeTW4L5tGFSrrG3+Hh6nVfYnHsHpuh4sRuoLL+eA5XC24RuPv2uoRmqOxm/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445835; c=relaxed/simple;
	bh=vVqU8NJTRxh+VGEkeGhK8rxWKQs9YWWnbRoEi/l2GDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mD0aKONGhq5bEkX3YeQEogrFFN7bUmqjp/QCt+nqJbqMEoswqZnJtvE422M54WA1uexssKLHs9JELJWBRGaSOhZ2XgtMp4fbJjCStOlD7x/9ZXo/STlS2jPMdxRSp9yYjCkODTpMbODWw+13PJGjiAK9G9P4cmuEDMy56Tt7SF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msBViy5s; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msBViy5s"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-482ea739de2so1363132f8f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788445817; x=1789050617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mYhl2eFp8EfMt+iovCQKUWiL4an5eim8e/EO9APbOWA=;
        b=msBViy5sxIIQg33EgcNCg7KqSu5n5Oq3BH7N911+Oy+hx4RvAV1pfGJe3ZV4H8PTmU
         L+CGwdgnMTHU36sl7wTCYrY8CXGjD/AL8cogsMhre+2xopr9/rxxl8fBZk7iMMyMQN0w
         eZNDZTVjAXaVPWVSYfxTuHXVvzrsPkeLU7MUWsg0II0etDZuV4dx1VicudAx37n5HsYV
         hNMRe08aIAbRqkUE5txUEOpKHfiGJMeuQusvY/3/RUDaQxZ8wHQVLRMbSHHOcHz9IQPk
         MQxzPJ+KbIcgwSdMfp9nizPajZLHGSZdZ4sN3PgmoCU22EAeMLEoTkAVRTPNNVviDFhI
         ZdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445817; x=1789050617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mYhl2eFp8EfMt+iovCQKUWiL4an5eim8e/EO9APbOWA=;
        b=PsdDCwBCiLAq3rIajQJRImWtAs+lbSzinfFnPs2va3qe3CD16qJQu0sIygLVlKszpn
         Id1+hpWh0UB1KTlS0WaH+PTdZon5IDvCGKSZbzgoER0V5cAG7s/ciHswMOCM0soxJ7B9
         UovIhktzmMFK8zuGpX7g8RrBKZEc53vNu/QIftzAMBWxLA/0Gxw6tRaV/9ckap2L4OQe
         JTPhTRnmiMRKnlUx7Kfh+/6jmWs1f5W2zdzkS9CMAUfFrop5EuHeKPhZrP9p/ES2acW0
         ptsXBuCJMRrMw3gYNp76ADcVretBdhYqC9eUIb0FQfO2HbXzEV5eukQmJ0kPplQp0d44
         9zNQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2keu6Tn2xzWa0y5je4gwnbFOn5iMJExAaOiouxNxLTZnh95/EoetW6FNnqBHqP4ciqBvh6e3SFAEzcCT0aSw=@vger.kernel.org
X-Gm-Message-State: AFuF++lX8j+Xt2hW421MzIRgkHJgJzbP1ZS4i60uTyz8brXwcPHByQgV
	+YdPLuRhwdLe8bpHtJh574C8s0AI0ZH7b39QXpLpQNKBbpna1Ge51NIC
X-Gm-Gg: AYBFou20SvXl2R2E1DHLjDBQi8YFbbjQnunCHOvB/CPJZMvDa9rO/DLEe5uM8vprhU3
	maWl/CuYeIcZX0u0lWAoErpLumUghwNE7PxN27qAQtExUWc9AERdg7ksAimIdqSfOoSnJBJMWQG
	l9W2RobSRRksBRxsLc7wHv2Gh1knEI5kQvKRUqCLCv/9kdzrxlPjQOl/IjoV5WzGGmm8Eh7K3vc
	6kz6NvEDeUNVUomeLIujWiBJrvYjq9VViCKWjze6XRgFxceAiFNq8wV5p9ulxA8slvY1AZPTD9Q
	waRYBhF9ZeVZkUXtK3h8in7JTJeAPNsvsXu2lJ6fokc7j0V19wo4+jUuPcAR1k/+CJAaaXGOZev
	n65wBeeOcpPqGriZRTG4evuw0EcPnhTmSrPj+OoWmTwPE3OcVt0Y56gayxYKXFeLkYWG5QUb6xS
	Qlmms69rj7pM0J4DUkPmUql8m0EHJ8OCJMBzDScZkgWBUP3nuCWGkDqvu916KfyLlnt5MxTGwwR
	1jThX8gg91sI4G5UB+A/7inhw0Wk6uIKrMH8IfQ9JUT7hcdUfbEBXIf4gL+PXDLofwUjL4=
X-Received: by 2002:a05:600c:1c13:b0:499:da8b:1476 with SMTP id 5b1f17b1804b1-49cf5c08c06mr4934245e9.14.1788445816752;
        Thu, 03 Sep 2026 07:30:16 -0700 (PDT)
Received: from cdev ([2a02:8071:68c3:bd00::8998])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7febb4sm80476235e9.14.2026.09.03.07.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:30:15 -0700 (PDT)
From: "Vladimir V. Kondratyev" <vladimirkondratyev2@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	pmenzel@molgen.mpg.de,
	chandrashekar.devegowda@intel.com,
	arnd@arndb.de,
	kiran.k@intel.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lsa.uz@pm.me
Cc: "Vladimir V. Kondratyev" <vladimirkondratyev2@gmail.com>
Subject: [PATCH v3] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
Date: Thu,  3 Sep 2026 16:29:00 +0200
Message-ID: <20260903142911.125301-2-vladimirkondratyev2@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260507203426.128975-1-vladimirkondratyev2@gmail.com>
References: <20260507203426.128975-1-vladimirkondratyev2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btintel_pcie returns -16 (EBUSY) during suspend, causing the entire suspend
operation to abort on Intel Lunar Lake hardware. The system immediately resumes
after every suspend attempt:
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 0
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 1
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 2
  btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_suspend [btintel_pcie] returns -16
  btintel_pcie 0000:00:14.7: PM: dpm_run_callback(): pci_pm_suspend returns -16
  btintel_pcie 0000:00:14.7: PM: failed to suspend async: error -16
  PM: Some devices failed to suspend, or early wake event detected

btintel_pcie_set_dxstate() falls back to checking the controller state via
btintel_pcie_in_d3/d0() when the alive interrupt is missed. However, these
helpers read boot_stage_cache, which is only updated by the interrupt
handler. As such, if the interrupt was missed, the cache is stale and the
fallback check always fails, exhausting all retries and returning -EBUSY,
causing suspend to abort.

The fix involves re-reading the hardware register before the fallback state
check, consistent with btintel_pcie_resume().

Fixes: e57362f4911b ("Bluetooth: btintel_pcie: Add support for _suspend() / _resume()")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221481
Link: https://lore.kernel.org/linux-bluetooth/20260830151550.44687-1-lsa.uz@pm.me/
Signed-off-by: Vladimir V. Kondratyev <vladimirkondratyev2@gmail.com>
Tested-by: Sergey Lebedev <lsa.uz@pm.me>
---
 drivers/bluetooth/btintel_pcie.c | 8 +++++---
 drivers/bluetooth/btintel_pcie.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index fda474406003..e13631e94214 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2777,10 +2777,12 @@ static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
 					  BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES,
 					  BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
 
-		/* A hardware bug may cause the alive interrupt to be missed.
-		 * Check if the controller reached the expected state and retry
-		 * the operation only if it hasn't.
+		/* A hardware bug may cause the alive interrupt to be missed. Refresh
+		 * boot_stage_cache from hardware, since only the interrupt handler
+		 * updates it. Finally retry only if the state check still fails.
 		 */
+		data->boot_stage_cache = btintel_pcie_rd_reg32(data,
+							       BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
 		if (dxstate == BTINTEL_PCIE_STATE_D0) {
 			if (btintel_pcie_in_d0(data))
 				return 0;
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 2db85f71b2f8..f287d1ff8e27 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -53,6 +53,7 @@
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_HALTED	(BIT(14))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_MAC_ACCESS_ON	(BIT(16))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_ALIVE		(BIT(23))
+/* Reflects live D-state. Updated by hardware on every D-state transition. */
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY	(BIT(24))
 
 /* Registers for MSI-X */
-- 
2.55.0

