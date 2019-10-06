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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4171FC10F14
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1C32084B
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WLLtdTvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfJFP3T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Oct 2019 11:29:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:49741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfJFP3S (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Oct 2019 11:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570375741;
        bh=zsRxR3IHUAe+a4FnhRTcZN5Fxop1p9dlP5W0ADx11B8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WLLtdTvTJVSL+C7Sg3DLZogPXOLnF+MYv7CISZw0w9AhGBQQkXBEHh3CiAi/fMM9i
         fQ4PYFejYVG2Qv18ROp4i/CZqOE87lJcyPttX35Zk09NI+rYu3ce8G8nYJwsqsl7+c
         OiC6nrqCpggfnUg/Yn5y7zVnS8J5EydkiV4RFMS0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.116]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MVNB1-1iiTAw0xd9-00SNc1; Sun, 06 Oct 2019 17:29:01 +0200
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
Subject: [PATCH V4 09/10] arm64: dts: broadcom: Add reference to RPi 4 B
Date:   Sun,  6 Oct 2019 17:28:27 +0200
Message-Id: <1570375708-26965-10-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
References: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:ON0gA9PtGkXWmbxKZqc2fzs/pNiWrzcX2ZwiwfEr8L7aCP6Vraf
 MZkposixV9lKWtxDmtArGEtW3UEjm7a8PIm8k4CLfsKgVT+mjgccEVQ0l/8UphnwlQYaYu/
 loBqdLssKqpRC0NqlIUk6UXRRQfiPkZeuQVO6nmbPo0fA0VhzjCCGDhwDaK8tpt0qNHboMa
 g+0SJXehK1sEL8xls3SOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cyR+OKiBsl4=:94ywcr6Zbb8TdryMYPN/f0
 yy4QaSlJETqCMaX6TaQ8d9Dih02qRCgksOtGfF4/qoZ+EW4DVb19ot/LGeMW+3jsux/MNWGFB
 zfmzKz75jlY0K62Inhkv+iY5hdEjjuhpUdMYL4LfRYJX5Mg2rraV/tytrNu4T7Suqis9S74d1
 IVAMCmUDLbtZm/Av5Y5rWweGVEXhZESl+fNM5nLo6JnBayStg6xaabRu34lHgBRh3z2tAG4wd
 Oe6ESFIk+hRhh6X8zspv3Dj68JAK5wFNgaeJukx73zJVMZsQuo/5egXmqYqnNY1Xmz8mczISA
 FVXkosdmgvWEik8z+fjDTlkNRpgy9PzTgMqc2PAI+A1zC0KUACa7mZyiT7XUTSJJNu4oFMByf
 ImkBWcg8ME49HY2sCj+Jp68XpRfiuw5Ep99D/w1hfMzelQeKjl5J7GmWorZj4XyhxVq7jvfDs
 dZXO3Qo4FBYcjQcUF3yEGQT64Ey+WjUDSfU+tBrq1tXYIx4mMnUpLPMfofL8t0HxTlOgkFa8t
 AN9G6uO7i7P1pQ12DwQNXu0vuOxGLOrpaJw/K3sQxt69uj/YohXf1n7XRtqFAqqpmD6Ki97aH
 27ZA/zFhNlFh+nx70AasuLf/p0Iy9UQmVCvad6DE8sgZDp3Vb19/ueORYarffg4mKRhJEqNEZ
 1EAHZCObu1HLcsMp04ABq6zv/Y27QRKEi+2KWgfiIoRIAR9wMNUhTwFGXBq/WonutKnMhFlg3
 db+1WjtuE516p884U/M8dpUapJksckKa9/FQquW9K4AcFKNChJRbdL1WW83hyFSjOM6ADshKf
 OXpqKppGs7OLMxIk97/FdH/nXSP1L4bjtO+tZMpVgY85fuo/6M7jUX4h6v1Z/W/6F+ve9UJRz
 0YaQ+L23rP2vc4vXla5Zg5t6qLMV3nW0OHj3WHwYa8OhZF8NCeoXiGg8sg9AaCPgFvKjx/1JR
 eIUQGRGMxGK4Ql7VcDiaghHIIXIIxzJVZPprT1xKamKSp25dY863zQRGq4k+Mve5WI5ZcxF4r
 rVx65Mu6kauX5atmAvT5EAWl2pUriASTagEMXG11bq39CKcvl5jV9bwIexWozV7rKNjnSbCum
 fsR6t5hzUhQaGHgwYwMoche8O2rzMYj0OKdAp7+hoVPFU3lUhCctdqF1r5kHr9VvhUbS8eIjQ
 O6nqbtZJLfMsubFb5nB607FhdX5F8ZlSY8u8k6U8+55oy4mNWgJJ7EJte3h8fdTmO5SppiIf1
 7o08mAP7lD3Q8ykESB2WfYD8vKrFBHOpxxtmRjw==
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a reference to the dts of the Raspberry Pi 4 B,
so we don't need to maintain the content in arm64.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 arch/arm64/boot/dts/broadcom/Makefile            | 3 ++-
 arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/b=
roadcom/Makefile
index d1d31cc..cb7de8d 100644
=2D-- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_BCM2835) +=3D bcm2837-rpi-3-a-plus.dtb \
+dtb-$(CONFIG_ARCH_BCM2835) +=3D bcm2711-rpi-4-b.dtb \
+			      bcm2837-rpi-3-a-plus.dtb \
 			      bcm2837-rpi-3-b.dtb \
 			      bcm2837-rpi-3-b-plus.dtb \
 			      bcm2837-rpi-cm3-io3.dtb
diff --git a/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts b/arch/arm64=
/boot/dts/broadcom/bcm2711-rpi-4-b.dts
new file mode 100644
index 0000000..d24c536
=2D-- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "arm/bcm2711-rpi-4-b.dts"
=2D-
2.7.4

