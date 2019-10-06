Return-Path: <SRS0=Uexg=X7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE31ECE58B
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926AB2166E
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eY9NwglW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfJFP3P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Oct 2019 11:29:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:54639 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbfJFP3P (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Oct 2019 11:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570375740;
        bh=UyrGE1hEHxmvjVmu+rXNNtvc/iHVMSlZ1dPfkiyXlWQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eY9NwglWtAYr9lHdDp8njHDVJici7pUeMzmegaPe5W0YujtPVjEaLGDDGTt9tqRMU
         0EudVGxdbG+bFFPxL7qd2ey1cF5jtrur4Pa3x6hcQtpILlc2tRx0wahIfeRkBc1xBt
         YlFX/dLRDr/s4bAUFhFuERSAmvscEZiV3c3rb1jg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.116]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MKsnF-1iXyWf0F0H-00LCrz; Sun, 06 Oct 2019 17:29:00 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V4 07/10] ARM: bcm: Add support for BCM2711 SoC
Date:   Sun,  6 Oct 2019 17:28:25 +0200
Message-Id: <1570375708-26965-8-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
References: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:2qyaG+54OdyPZ+qcVX9vMoaDfHU63alzpLvTBRaQorhtkLjwbL/
 6wRfS40TsUi5QHLfxCG58B3+CmCvjST8/4KsH08WqWK4NTr9xopfO0buFC1BF8PpmvZ3SDI
 QyGdY/4jfs0fo8iOSc+CBS0riI60MuUIRIGPh1xzTqs/6eYiYka6ISjBDpYzbneCqu5qJYU
 2/uX4NnCll8YcYIcg3fdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q6+QKOcsmtA=:J+d7W1sRcDk4XLyAoAjG1C
 M/bUCBr+8wfhhVR/OXNueelGx7x1p9uVDPnTUe2DPRhHnyQodtWeXmpgH4soEgpsv4sFZ92vt
 qZ4tMKXnFlg9LU4lzQsYN11T96j2lnmRbOlyzkqk65NiTpNXJLIJ2ulzXQXAJ8udmEkRjcfFI
 VG9SWZGmmjTCElM/MvqiHJBfbJ7G1U3zy+ctT68IAb+qgwRnoQexB/l1R2c/UqmUvo1uIAdTs
 mVwuAAT9LeU7SQDOp1m16iEIXqLvc2SzB8r4M3BHl1lQej+VqTQBcu0B+mZoiuZjv6UZJsKWs
 Zw0NUiSv7o4KUWqTNNCzCAlCAXNXDhuGphAFm4ZOgSGx4w+ngcwU5/5dekT0/Ly/CZTJSjmKU
 px558yw2RrkfEdpIrkpakR07DYQB8Cvq34jggWlcTFwQxzfOITU+lOtamtHTRze/oQewhyqIW
 lcxAA1i0nScBorRIQR3mO+4wx9IY5zXim3PWxouc4cg0HhrFYTEC28KaJq76vRHxkz3xV8lAg
 hU0xnqJ2T5qFSqJv5wtTuwCBXbJKcP7u5PDvrwyBr4TabFijPkAeTlUiWTw4EuLNTPvHhJ94x
 ZDsLkO18EhJWTVvAm1g+mnfpAVIqhTEoxHr5drPhJATCNAF+d5S3CMwb5kUHj1595xkwjVceX
 kszj4+Hounp1rt/Hvkh2e457Pe625rj5WPi7Wn2QuP/nINZxPxev6CJYJKodrgWmbO/uUEQZ7
 BZnAkNSIwyKvK4/cYnOuCmQ/1CX90eS53X03Mgqygwbrqxx1IhURdUScaRe51z9umikp3cBQY
 EDD/4y+kDmPfzO8OmSgsozKlLIXX5HBV9CnBtKqKTN97Yba83PGeZOuKiW8qYAsj96hYZAs8K
 8s9CbVe3skddwnI+3RoOOY50iKe3ER22MRMyzO3DxpfTGMZRDYCKajt3ukF6pYO8Mf4JnhftM
 IWnweH08ZcJdS1Hd8d7y65bwLzmrj2a+IIHTfiT+mdxSyYWmUqkCezkTZs9CiiscT2X85kVp0
 iYUaQaDoNSbawIxHrgwZRrxlIDdVQ8Y2+pva+cwhh6V7hF2j8EnL6qN+Lz9LfuwWrlfVAdUcG
 4uckbe8x6v8xrUMwInvrPwZg5DBFnNvCvgzCa5kz9/VHNEFCyn/kfi+6Kf+fG//J/0D0HXzX7
 uyhP4M1rGcZrRjFSHkOCmxXQk1DhWQ+l82K38orqNVgkHlYh48ya4qYrtfX7QwNbIHY1KjhDH
 gMbJU/CHiFq87yeRyUuorMbzFFk3Og03HZeZWRw==
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the BCM2711 to ARCH_BCM2835, but use new machine board code
because of the differences.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Eric Anholt <eric@anholt.net>
Acked-by: Florian Fanelli <f.fainelli@gmail.com>
=2D--
 arch/arm/mach-bcm/Kconfig    |  4 +++-
 arch/arm/mach-bcm/Makefile   |  3 ++-
 arch/arm/mach-bcm/bcm2711.c  | 24 ++++++++++++++++++++++++
 arch/arm64/Kconfig.platforms |  5 +++--
 4 files changed, 32 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-bcm/bcm2711.c

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 5e5f1fa..e4e25f2 100644
=2D-- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -161,6 +161,8 @@ config ARCH_BCM2835
 	select GPIOLIB
 	select ARM_AMBA
 	select ARM_ERRATA_411920 if ARCH_MULTI_V6
+	select ARM_GIC if ARCH_MULTI_V7
+	select ZONE_DMA if ARCH_MULTI_V7
 	select ARM_TIMER_SP804
 	select HAVE_ARM_ARCH_TIMER if ARCH_MULTI_V7
 	select TIMER_OF
@@ -169,7 +171,7 @@ config ARCH_BCM2835
 	select PINCTRL_BCM2835
 	select MFD_CORE
 	help
-	  This enables support for the Broadcom BCM2835 and BCM2836 SoCs.
+	  This enables support for the Broadcom BCM2711 and BCM283x SoCs.
 	  This SoC is used in the Raspberry Pi and Roku 2 devices.

 config ARCH_BCM_53573
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index b59c813..7baa8c9 100644
=2D-- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -42,8 +42,9 @@ obj-$(CONFIG_ARCH_BCM_MOBILE_L2_CACHE) +=3D kona_l2_cach=
e.o
 obj-$(CONFIG_ARCH_BCM_MOBILE_SMC) +=3D bcm_kona_smc.o

 # BCM2835
-obj-$(CONFIG_ARCH_BCM2835)	+=3D board_bcm2835.o
 ifeq ($(CONFIG_ARCH_BCM2835),y)
+obj-y				+=3D board_bcm2835.o
+obj-y				+=3D bcm2711.o
 ifeq ($(CONFIG_ARM),y)
 obj-$(CONFIG_SMP)		+=3D platsmp.o
 endif
diff --git a/arch/arm/mach-bcm/bcm2711.c b/arch/arm/mach-bcm/bcm2711.c
new file mode 100644
index 0000000..dbe2967
=2D-- /dev/null
+++ b/arch/arm/mach-bcm/bcm2711.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Stefan Wahren
+ */
+
+#include <linux/of_address.h>
+
+#include <asm/mach/arch.h>
+
+#include "platsmp.h"
+
+static const char * const bcm2711_compat[] =3D {
+#ifdef CONFIG_ARCH_MULTI_V7
+	"brcm,bcm2711",
+#endif
+};
+
+DT_MACHINE_START(BCM2711, "BCM2711")
+#ifdef CONFIG_ZONE_DMA
+	.dma_zone_size	=3D SZ_1G,
+#endif
+	.dt_compat =3D bcm2711_compat,
+	.smp =3D smp_ops(bcm2836_smp_ops),
+MACHINE_END
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 16d7614..63b463b 100644
=2D-- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -37,11 +37,12 @@ config ARCH_BCM2835
 	select PINCTRL
 	select PINCTRL_BCM2835
 	select ARM_AMBA
+	select ARM_GIC
 	select ARM_TIMER_SP804
 	select HAVE_ARM_ARCH_TIMER
 	help
-	  This enables support for the Broadcom BCM2837 SoC.
-	  This SoC is used in the Raspberry Pi 3 device.
+	  This enables support for the Broadcom BCM2837 and BCM2711 SoC.
+	  These SoCs are used in the Raspberry Pi 3 and 4 devices.

 config ARCH_BCM_IPROC
 	bool "Broadcom iProc SoC Family"
=2D-
2.7.4

