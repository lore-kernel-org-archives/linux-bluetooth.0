Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683989;
	b=E0lMa8im1EsQEGzHdAOcpqFtZQ6ywXcdZr4DTMgxMNONsOXiYccDxPUqA1RYZ2h2b2Yl
	 raFEaMzu1c9pZ75rXEn4g7vbAYOrbz2QEYPMXwTG/DjllzLdB38epNUyZVLZShv1mUbxM
	 62XPzl/Eq28bq8Op6+H1iR04GUGanc7EqwdGK3oRsFQ0IMyx2NV6l069KjIk3Rom1AfNb
	 zuEUwFzGBtExB0QcN2AiSmtS9/X7fuNcfGKOP9PyZMa5QkHMdlEGoyN872+VHCmKDQGsv
	 k12eA2nsV5NdjxftpyGgZYLMDwNtIpT+Sd/+Q0Zq1UyD+DA/X4rxWUOXi0hSEaAQQkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bSXh36e2pydNnMOTO7m72D0HgLwPH69usWYgrx+lvp4=;
	b=2qF9vp7AkxrVPNWBXG5X7dnMpKBFjFs7cRqt+jvhOZQ27i6HGVr1XTSCwiWAKuvbCToO
	 QBdmgQNsxziFIvhYSdy4FS/cAZOlzDvVDMSulgB7lXQzE/j/ijxCUJ9yppMea+CR0SCcG
	 ZPw+6SZ73zI9Ap2TYoV47/7KvZ+HPMYSfQZyQuNsW1+kalmEmjZ2LcOY0OC56suoUDrBq
	 NHr0LwO2vg6JBeIwzA49S1+hYuOAteZ3gMaaJe6hybeXY/vdLFrxa2uWcO+DEU8Fgg+rG
	 BM0p0EkBpjAB4J0DTTr9eeruK5c9XjH7cY+405ucwTAILF5UQcfpmlA5zBs3FCix/MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="BkbB+r/l";
	arc=none smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B460A260C
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 487B460A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BkbB+r/l
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-98febe968deso12871241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792683988; x=1793288788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bSXh36e2pydNnMOTO7m72D0HgLwPH69usWYgrx+lvp4=;
        b=BkbB+r/lC1gXnOv6fcMp6a3CS+ezhKHyk4TzGgsMDw5e8s8HHMlw5bTBHas/wGUuLe
         DicCl3Kbw8AQUeb6E1D/SqhMMS46hsTTFRRVX/9SmniWsflmaJXJLrNpRWUc2+ZpiG/w
         UOl3+2eLcZVNQh8fljzDhA1phgCXELkeINDPkcLSHGAJF0UwsApczQC/JJUVd3jBoOTk
         5YGHgB//6pNTJvGtz20PUPewurBIZlbrJkG5jfASCOQm05ProBF93dhwyIlY4sb7YcNj
         yC+UvAt21Ye+iy/n6wE1Wuyz5u+rZC88JUQmhzJCpOcVUAVYbboEN/zsS/bTxjO2p8Nb
         7i0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792683988; x=1793288788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bSXh36e2pydNnMOTO7m72D0HgLwPH69usWYgrx+lvp4=;
        b=P6BkwHbURVY+1r7pVKYlYFx3yKtPoBXxeLk0ZNo1G569i3UY/4qOqv/FmnD9rtwcNw
         RA+aKj5UJExgpXx9ERIad1cPHKMmfHHm8EvLIbjUioMFvX9EiNkuWRQrHMKiUtzjk4uz
         BDuInqaZGidGnh/LqM6gdVk7FeRYfWdhfmL0yEanujPGUms4Hw8Xa3XD2GRguKPYmCkP
         VufX86gHEdkN1cXabMpBx3yecuIbAWEnrR8QSG+pTZMxsO4wNSWiX6HslGiwQEs/ZXtt
         HdCjOlCCTqvpg9qaH+RL8EDbVJnLXEQ2foTp81irPq6d4i6frStByWe19IISmjrG8TmH
         Ff4w==
X-Gm-Message-State: AFq9FYJaTyuattSE1YAcs6qyKaJOH/xJTAuSpzZhpYvrRh1/NOxKssRF
	Hj/kwK8nnHHf8sicy2UuIEFtO0XkA+a9BqlmbumTZDxj4PVF+n/y3ydF5b382DaYBRI=
X-Gm-Gg: AYBFou1oHAuqtXfoedVAp/9X+gEhtLTBe0IzrKlIFyI+GHBeE0u3ctCSiofbDFQDk02
	EP9pzLmNaWqIT1ZWgfjKtOyHtjRUXYFbZYhd1gxcAB5ogECnvOgXun6e2BvLOVV5XTUqOlS8jZo
	Qg1Hreza9IKHWeTZXHn6NefZK0qlqryuqNp9wZGCm7ZZWOcJzzDuwCcRpwF8es+3dwctQ4PNqnm
	QKvzoQIh7dj/x6nrCiMu/5RV1WUMgRnBgjfqAIWAo1NlDlMpcdDlul8H7PnAOADpoEClDm9mUxk
	9JOLvQcPWaTIzYCWwBfwVnZTkrrnCQVbf8liiXSZZ9UctGBVyM1rZQlFkEhiTdjpeNS6UUp2fIE
	bZCPqDj2hc2aB4tnM+0oKdlawRLN6ck0iXFO7UM+vvPHGgOCbR2bYj2MZvECXJGwH0K3RsxbN62
	Bg0npVzg8DdMAecHmYjBamHzgwQo0y3YPVI2a6fv9GVOsascFJtNLDX4ozcdCbEgmLnCLYoj0Z2
	Oe8gYoxvlWlsWZAfPtqHE+qH7tvcsGJk/51VwzsqC1xonivYT239c79sUClrO5K22Y/e80dYssS
	4qTRhU9o4Trxg45W63aiaZbyzedfRitQiAZaQIKrXnhkcg==
X-Received: by 2002:a05:6102:80a6:b0:7cc:1218:1d2a with SMTP id ada2fe7eead31-7cc92641180mr2193084137.9.1792683988205;
        Thu, 22 Oct 2026 08:46:28 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ccc2203b79sm11697137.11.2026.10.22.08.46.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:46:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: btintel_pcie: Allow COMPILE_TEST without ACPI
Date: Thu, 22 Oct 2026 11:46:20 -0400
Message-ID: <20261022154621.3958803-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The driver only uses ACPI for the product reset method, so make that
depend on CONFIG_ACPI and allow the driver with COMPILE_TEST, so it is
build tested on architectures without ACPI as well, such as User Mode
Linux. Without ACPI the reset method reports it is not supported, as it
does when the device has no ACPI handle.

Assisted-by: OpenCode:claude-opus-5.5
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/Kconfig        | 2 +-
 drivers/bluetooth/btintel_pcie.c | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index db0189ca3cbe..68929d12f608 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -477,7 +477,7 @@ config BT_NXPUART
 
 config BT_INTEL_PCIE
 	tristate "Intel HCI PCIe driver"
-	depends on PCI && ACPI
+	depends on PCI && (ACPI || COMPILE_TEST)
 	select BT_INTEL
 	select FW_LOADER
 	help
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index df95d16a163c..4fbefaa3129a 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -4001,6 +4001,7 @@ static void btintel_pcie_inc_recovery_count(struct pci_dev *pdev,
 	}
 }
 
+#ifdef CONFIG_ACPI
 static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
 {
 	union acpi_object *obj, argv4;
@@ -4054,6 +4055,13 @@ static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
 	pci_dev_unlock(data->pdev);
 	return ret;
 }
+#else
+static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
+{
+	bt_dev_err(data->hdev, "No support for ACPI, cold boot");
+	return -EOPNOTSUPP;
+}
+#endif
 
 static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 {
-- 
2.56.0

