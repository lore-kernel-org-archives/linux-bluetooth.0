Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128984FECDC
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463397; cv=none; b=NmUxW9o7PNe4RnnZhxhN3/ZcFi+0WHx+5bVHHF46vCUR0fJYSFRFuE0//0B+aZidjL3ZKjCC8h2QTGKGXrMFD3MseFdd7cTACxi60/ITEL0xNZZFfrIwARriRtHRVh+NakGuk9Njv7MBDuwsOcHmbs3jWe3d7noZeM/6q30yMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463397; c=relaxed/simple;
	bh=+gV9X8jzdQo5p8du54Z/UpbSj1HoijZrBrvmD8rwfjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUUHDMrDPOLT9ah8xvPRFWrOKxQ8cpM103vcaQ6eekifsgLE3IOq1RyluxF9qt2CL8f/73Yn/i8+SnqpfFg7bG1nIqK0bXhLOy+iAI65hhCJxRLIhPwtv6csZnFUJSJk960Aub41xrtlKN6ZC8EdkVKwC2WJqEsT2qqa58u+qmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2C2HrCI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2C2HrCI"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49b9320423cso3123005e9.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788463388; x=1789068188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GsH6SOw+USyQpDA8nRvyjRstt1W5VyT+6ln1zJ94T1Q=;
        b=H2C2HrCITgBoVoj47lvawAKPbVLjRUydbr+3FBGvuSC9j7t9STB/A3pgpTor++h71S
         mlAawN0UAqdSv5zVo2s5hgLizXV4rs8HoG0vhZqlhmatN+2zIOeZo5gdCdCPGkxxyjRd
         LPNxVppbrX41FQkFLya77ZXDZSlQVDjUPXHEnSXxI5kqYZE92UESZUG2L/SCZER+6093
         pnteSwRGeyJPBMR/JYiNU9hQOg9VKdVth7+lQGq8tibSgMDH/3gDVpPnVQOqXgMjLURK
         G4Va0Hj5bkiVsqFRMWz7IxqXlmml8m+gWb7gA4HVXE3O2QAelxLQtWcwkTV6itKyuB73
         Ckjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788463388; x=1789068188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GsH6SOw+USyQpDA8nRvyjRstt1W5VyT+6ln1zJ94T1Q=;
        b=auGWEnSQFLmlTzvrJqOYXqx/8QLXyXlTDfpR3fNN70Lr5kaVdowlbgCPu4UkrNFYQ9
         YUak8HCuS77Fn1qzE7UtdLOo7bx7erwb0OM10/wW8QWPiFAHZNhh+z3DgRo2j3NzudKG
         r54PpJySBgGOgtHfIUbeQc56yeWYaOPG+y/Eh7g+d9SvbLy/SG8d3NtTA4YFPWrnfyLb
         x8Ul6n9APDFkG9pVem6rucQbYYeQY/m57SFrjt1W6nXuca5b3eK4J8YsEeLYeHdBGjJt
         a+KnK1wScFnmC6gC8ksBxThSHsgjJCIwU8wpYnQafxpekuqV7V7xq6O+67Jyweshenr6
         Grgw==
X-Forwarded-Encrypted: i=1; AKwUvBwleDb3chmLOgFzjw0U+myDHW7/39PICyV0h/aVTSOqfc9228tsIVKQB0rxW1kSvF6NCdSATV1z9zl5pHygNm0=@vger.kernel.org
X-Gm-Message-State: AFuF++kf8N604/quUgTncL2JnbyqZuDXQCKclnk+yKTGhyCIOMe7RRLf
	uNnGeah1uwa807a8ssjFdHUiKLeM6ymiPxTlvoFHDKsZtuBf8pWa+hEc
X-Gm-Gg: AYBFou0qYEAPm/VgdH38vEZ/94KxuJ1gVLDDRvnbdIILmV3YGW89A/tYOBO0id97p96
	MgBXAwzmgvBQ57VZq00aTL5Z5OriBJ2JGHZQJqgsgptPsUYh+76nn6Wd3VyChcrCV9YStcONjkM
	Nyc79N8kD0k97YNq1ubPk543MNGWH2+cQLknKGprx8D06Y0uCN8QriCuUv8WZBz0/GbTpxGwwFQ
	WvBCegUzAKdOYkMKs0CfV7HQnLUEMqkpQa9h0o1AMnbBAZL0uoTv3qI7FflczNnesebeN13QBpi
	c0MZx56FGQ4lXesUu3Lei1Qq9Kz8gq3nkAl48csU+eJh7WH8Jm2ZfmQ6P8DMa07HPUaarXRPRss
	m7ddz7y/lL3V2tSf6zVY1vFYKl3kRLIZcvANXDXL/IerE3mys4peQ9cJzwivL4Y9AcrIMV7Mjpi
	hijGAiLP9wOWptui0VakCit37H+wdFbWDDmDYf0RYNJpegq423kqtVxRVW8q5vFYwf3Q5nGUXnC
	iJDnFGvYR5sHw20y2u//NW+aNxwaF+k5yknoLxLCBzDBV0fDYdmTLbJ9QPwee6RgzxUrkk=
X-Received: by 2002:a05:600c:4e0e:b0:49c:c9ac:a4f3 with SMTP id 5b1f17b1804b1-49cf7fdc20emr4647525e9.1.1788463387879;
        Thu, 03 Sep 2026 12:23:07 -0700 (PDT)
Received: from cdev ([2a02:8071:68c3:bd00::8998])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cc7sm8009355e9.4.2026.09.03.12.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:23:06 -0700 (PDT)
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
Subject: [PATCH v4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
Date: Thu,  3 Sep 2026 21:22:38 +0200
Message-ID: <20260903192245.135310-2-vladimirkondratyev2@gmail.com>
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

btintel_pcie returns -16 (EBUSY) during suspend, causing the entire
suspend operation to abort on Intel Lunar Lake hardware. The system
immediately resumes
after every suspend attempt:
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry,
retry count 0
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry,
retry count 1
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry,
retry count 2
  btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_suspend
[btintel_pcie] returns -16
  btintel_pcie 0000:00:14.7: PM: dpm_run_callback(): pci_pm_suspend
returns -16
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
index 30923eaabed7..44ad31a5d7ed 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -3538,10 +3538,12 @@ static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
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
index 9baa214d9bbe..a7f4e590af5e 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -51,6 +51,7 @@
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_HALTED	(BIT(14))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_MAC_ACCESS_ON	(BIT(16))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_ALIVE		(BIT(23))
+/* Reflects live D-state. Updated by hardware on every D-state transition. */
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY	(BIT(24))
 
 #define BTINTEL_PCIE_CSR_DOORBELL_MBOX_READ_CONFIRM	(BIT(4))
-- 
2.55.0

