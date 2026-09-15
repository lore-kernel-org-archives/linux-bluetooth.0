Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934A43624C5
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508255; cv=none; b=atEcl9dnf8LTbNQ3gDGJHu4z8Fi+dI5tWS352CQsUbgPuikMUtfh0DPjJ/O+xcgeT+o8hjgsRN4hVAVytTUtyUU75kLhWv3voZIz8wnXJgoFeIElSXBlBGPtBxj1dm3j/CWG7+uh0kfkvb4z6YDshRK3CIuC83vVct/DxqCFgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508255; c=relaxed/simple;
	bh=sUAVO4rlIo9qgk8V5PuyuoFgehQLNZgn38wN9bkKeOk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ffgpS6RGYUU59cl1o1mY7Q+O0JAw60zO6Rb6o4rZYDai29Ki+GNjN/h76ty4PhkHfzAaBA7R2ki6YaP/355B+2ixY4oUrHvGefenuyn9ayRGuGeHLdafo2z1OBlHgb30veZMZl5sDvNf6BtIOUjhEk4kziegapzFND9U/DCXDhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBBEyDyT; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBBEyDyT"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-785692e59a4so110700137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789508252; x=1790113052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4zPN9kvOKt5/MDDTnmyPIOOTK1URNPCH/j8Phr5SriE=;
        b=dBBEyDyT+smA8XnNBUT6waAI69Pf04nVq6R+H88YWCELV3oI+roldHgh+JcF9ve7QL
         h3yJTiX13ltO+13cktRNsX3hLzlAjOs1fQvHp7caY8Fn7dKTid6VGtUXP0ACH8WWgJ7Z
         h8DLrkZzat/6rSAXLjfo5Ku45SMAGJYn+uM/sRlOQ4+VFZO6shs/oG9ERu9Qjj2Hf7gq
         mpFYIVziySe6ircqk/isHX4g4882vltxUe4pwAc441ckzUiuepzvib3miGI+OK3QyTyJ
         xoG8xz9uWaV+qhnmA8CRIS+pDWc/nf2pbZaYRLMaZlBSUB3TMag/7RIp7zSQWDo16hj8
         y7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789508252; x=1790113052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4zPN9kvOKt5/MDDTnmyPIOOTK1URNPCH/j8Phr5SriE=;
        b=m9i55dhe18p3Zd9PjQF3zFexQ/MotZZZt4z6R28cNJTgYGNfudtvGtxWd8XLnF86W1
         39S/i5TI4FcvH5Rdajq7CorJJ0e2+uSn7DN8IaNfY+JEbJgbjwgSHJ3jjfBhzxxg3rrl
         QcaauaFRNwD+PD+Xl+y/GSIXyHglM9FfOH8BYFsS+kGh5G31JY5xV14WoKZGdJdzfqFK
         olG/5gL1aLBYWuxOokFh+/wHqtmshIls3VCA8bqe3VrMOD/XJ1wEdlqGAaWXBIAln7UY
         n9GZK5jHNx/cWKUwg+HTW3AIaRCBif9Nh47AQLJt+ub95zHKaCq3ZMbZtXE4N8KOjxTG
         gp6A==
X-Gm-Message-State: AFuF++mYyZuTu3O4+XzTJNGr+giSMYjUR7j7jputt5OIUvyxbwxW8Msp
	TnkhUQ4VKxuge0yMEvQYRc9/9qf0x+PTubuNtmybg8cgcVMag16HV3k+O+MfRfSk
X-Gm-Gg: AYBFou0ECciWEWgeaydGB3BkI8sxNO5FWlw6twlY2dNY2YXGHVT8nFc1cmhMay/BV4y
	dpt++DKluSEfs4IwUT9DDDkkMagzTRIJfHw9xdGQGZ2EimOgxOtl1PlpbvCqQWRMuhbMn/RO0JX
	mJ6ANNbHJUdWOWOAIRRqCaYbgqvBWWVHCP4fAY73QtE7cM97l3T6r9VWtjiDrqX/BvH30rO5KwB
	q8oveZVwIyOdyWGVM3zl3VVf1V3s2yyiKp2MWGeGaDsa3kl8PugV7N9OHJzhnHDd6k5jiWkoncG
	U3Y4aRqhOoaPXCmxYcvNvQu8d1WFg0KnTnNpCfFpYyWtP+Q/UHI88mQsPoFOT29Tr+lxuRrpHtF
	HiHSUmCprBTjGaPIUb3quDd79mjdmDquW4MX0wQOUxAL/16/J7sCEYigsIP5HU2eZ2gsdtHlEra
	iu53zR7t/7AAp/GeB/xxUoMxVv871aJeDN5K41InE/7SB/3mu7/diNCHW29UZeMTLfmkG5lATLM
	SqpnzqJbTNd0XFJ4L6E3DKlnZ7Sy4ZTziDHe8/fHK6W1ql6l2bQI5sHYRQv7zrsEA==
X-Received: by 2002:a05:6102:3c9f:b0:79e:2d57:6225 with SMTP id ada2fe7eead31-7a029741056mr565428137.2.1789508252383;
        Tue, 15 Sep 2026 14:37:32 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-79fb193720fsm1098247137.6.2026.09.15.14.37.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:37:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] test-runner: Enable interrupt remapping for PCIe passthrough
Date: Tue, 15 Sep 2026 17:37:23 -0400
Message-ID: <20260915213723.1242672-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A device passed through with -P fails to allocate its MSI-X vectors
(-ENOSPC) as the guest has no way to remap interrupts, so give it a
virtual IOMMU with interrupt remapping enabled, which in turn requires
the irqchip to be split.

Without this the guest is not presented with a DMAR table at all, so
enabling CONFIG_INTEL_IOMMU and CONFIG_IRQ_REMAP on the test kernel has
no effect, and both are now documented as required.

The machine type is moved out of the static argument list as it now
depends on whether -P is used, the resulting command line is otherwise
unchanged.

The model wrote the change and confirmed the guest is only presented
with a DMAR table once the virtual IOMMU is added; it was reviewed and
tested by the author.

Assisted-by: Claude:claude-opus-5
---
 doc/test-runner.rst | 11 +++++++++++
 tools/test-runner.c | 10 +++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index 6429e80fc75b..dc1e51305c51 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -355,6 +355,17 @@ In addition the above kernel config option the following is required:
 	CONFIG_ACPI=y
 	CONFIG_BT_HCIBTINTEL_PCIE=y
 
+IOMMU and interrupt remapping, without which vfio-pci fails to allocate
+MSI-X vectors (-ENOSPC):
+
+.. code-block::
+
+	CONFIG_INTEL_IOMMU=y
+	CONFIG_INTEL_IOMMU_DEFAULT_ON=y
+	CONFIG_INTEL_IOMMU_SVM=y
+	CONFIG_IRQ_REMAP=y
+	CONFIG_AMD_IOMMU=y
+
 On the host, an IOMMU must be enabled in the firmware and on the host kernel
 command line (``intel_iommu=on`` or ``amd_iommu=on``). The controller itself
 does not need any manual preparation: test-runner unbinds it from its current
diff --git a/tools/test-runner.c b/tools/test-runner.c
index 2de05e26dcf3..338e5b9da544 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -293,7 +293,6 @@ static const char *const qemu_argv[] = {
 	"-no-user-config",
 	"-monitor", "none",
 	"-display", "none",
-	"-machine", "type=q35,accel=kvm:tcg",
 	"-m", "256M",
 	"-net", "none",
 	"-no-reboot",
@@ -810,6 +809,13 @@ static int start_qemu(void)
 	strv_append(&argv, "%s", qemu_binary);
 	strv_concat(&argv, qemu_argv);
 
+	/* Interrupt remapping is required to pass through a device using
+	 * MSI-X, which in turn needs the split irqchip.
+	 */
+	strv_append(&argv, "-machine");
+	strv_append(&argv, "type=q35,accel=kvm:tcg%s",
+			pcie_dev ? ",kernel-irqchip=split" : "");
+
 	if (qemu_host_cpu) {
 		strv_append(&argv, "-cpu");
 		strv_append(&argv, "host");
@@ -835,6 +841,8 @@ static int start_qemu(void)
 	}
 
 	if (pcie_dev) {
+		strv_append(&argv, "-device");
+		strv_append(&argv, "intel-iommu,intremap=on");
 		strv_append(&argv, "-device");
 		strv_append(&argv, "%s", pcie_dev);
 	}
-- 
2.55.0

