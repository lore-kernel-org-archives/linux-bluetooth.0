Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF60C38A2D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Oct 2022 22:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiJYWQu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Oct 2022 18:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiJYWQt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Oct 2022 18:16:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060E21ADB6
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 15:16:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id jo13so8618709plb.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 15:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dmU9F13OArWeXWJQWe0dPx4Z+GHsbxDYbzT8MvhbwI8=;
        b=PqVvAVoXuNS1Se4Gmg04D+TgGG+bu/0KAIjvXlQZxPVkrQ2n+3gjM6rBmVyryTvMAZ
         Jr7bikz6DU42JEO9KOjB84zlVtNr9zhqCOJ1NE3g6xLgEYPS4ZKflSeso5dbeIjcftFc
         V/fJelg3KUz+tv3nbX6dxJ65q5bPkNTrcZb6IYSssjx2Fwr+NxTtw9S9kSsKKMo8F9/I
         j33Xh3ZrjHeOYw4SuE+9JkwUrX0mtiRAQPvao9MbMm8dmDVHdsNm1Li/AWBc+NgrAQhz
         bbD+E0wiNcaizBlNfKbPxA/8D2TdCjwUwlWU336WrrmE8zknOF3RsN05/N0h9z2AYyaE
         Ww1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmU9F13OArWeXWJQWe0dPx4Z+GHsbxDYbzT8MvhbwI8=;
        b=KaOeEoZjjfOa2K2/tDdLsGrfF3fXSnrzPEmmOvn8DB0ddQJLEg9lqSp4iC1/joxWk8
         TF75B7FXujDjPWQfxZjmq/OurYo6uTecbXa6FS5y6zUTMAivWd/lsqTJFQCoCJemv96V
         6+/mvXS2OK4WMoAvX2HI/ZfFqhFFR5Ch1ymTn+VMKqq6x/KMWv1KOh2moWtLVpfroLSn
         KXRoiu9vMS+7QBVhfjIj1plopMzOGrhVtiJR+55W/KU6qAyGFqzJStsrfaiIAOKq/bfJ
         zV9qV3GOzW5tD40MB/mB7C4JaB4VcYQhmY2E+ZvWTeJbxtwI9NfOYrvuqiGm3NsKESL3
         HyAw==
X-Gm-Message-State: ACrzQf0ezyWWHDcDctQPUQaxf2AcSR/oRvQRy+KH7vArp3NqjN2hHsdf
        jrVK7OamxnaGuQimEJKOLeMeDUBYwqw=
X-Google-Smtp-Source: AMsMyM7cge14fT8yplxbB+F64LTpwkXAnN1Iy3BbDUo16rHG7tW6zZjP6FvwyxkoM0IxZvLyxSQOcA==
X-Received: by 2002:a17:902:ce03:b0:178:3ba6:f731 with SMTP id k3-20020a170902ce0300b001783ba6f731mr40935607plg.115.1666736207076;
        Tue, 25 Oct 2022 15:16:47 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a80:cc40:7681:15f8:9917:92b7])
        by smtp.gmail.com with ESMTPSA id c29-20020a056a00009d00b0056b9c2699cesm1852019pfj.46.2022.10.25.15.16.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:16:46 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] doc/ci.config: Add configuration for CI test
Date:   Tue, 25 Oct 2022 15:16:45 -0700
Message-Id: <20221025221645.2344340-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds the bluetooth kernel config file used by CI test, which
enables all bluetooth features.
---
 doc/ci.config | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 doc/ci.config

diff --git a/doc/ci.config b/doc/ci.config
new file mode 100644
index 000000000..31e49ba96
--- /dev/null
+++ b/doc/ci.config
@@ -0,0 +1,122 @@
+#############################################################
+#                                                           #
+#   This config file is for testing bluetooth build only.   #
+#                                                           #
+#############################################################
+
+CONFIG_VIRTIO=y
+CONFIG_VIRTIO_PCI=y
+
+CONFIG_NET=y
+CONFIG_INET=y
+
+CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
+
+CONFIG_9P_FS=y
+CONFIG_9P_FS_POSIX_ACL=y
+
+CONFIG_GPIOLIB=y
+
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_PCI=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+
+CONFIG_SERIAL_DEV_BUS=y
+
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TMPFS_XATTR=y
+
+CONFIG_DEVTMPFS=y
+CONFIG_DEBUG_FS=y
+
+CONFIG_MMC=y
+
+CONFIG_RPMSG=y
+CONFIG_QCOM_WCNSS_CTRL=y
+
+CONFIG_PCMCIA=y
+
+CONFIG_ISDN_CAPI=y
+
+CONFIG_6LOWPAN=y
+
+CONFIG_LEDS_CLASS=y
+
+CONFIG_USB=y
+
+CONFIG_BT=y
+CONFIG_BT_BREDR=y
+CONFIG_BT_RFCOMM=y
+CONFIG_BT_RFCOMM_TTY=y
+CONFIG_BT_BNEP=y
+CONFIG_BT_BNEP_MC_FILTER=y
+CONFIG_BT_BNEP_PROTO_FILTER=y
+CONFIG_BT_HIDP=y
+CONFIG_BT_LE=y
+CONFIG_BT_MSFTEXT=y
+CONFIG_BT_HS=y
+CONFIG_BT_CMTP=y
+CONFIG_BT_6LOWPAN=y
+CONFIG_BT_LEDS=y
+CONFIG_BT_FEATURE_DEBUG=y
+
+CONFIG_BT_HCIVHCI=y
+
+CONFIG_BT_HCIBTUSB=y
+CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
+CONFIG_BT_HCIBTUSB_MTK=y
+CONFIG_BT_HCIBCM203X=y
+CONFIG_BT_HCIBPA10X=y
+CONFIG_BT_MRVL=y
+CONFIG_BT_ATH3K=y
+
+CONFIG_BT_HCIUART=y
+CONFIG_BT_HCIUART_SERDEV=y
+CONFIG_BT_HCIUART_H4=y
+CONFIG_BT_HCIUART_BCSP=y
+CONFIG_BT_HCIUART_ATH3K=y
+CONFIG_BT_HCIUART_AG6XX=y
+CONFIG_BT_HCIUART_NOKIA=y
+CONFIG_BT_HCIUART_LL=y
+CONFIG_BT_HCIUART_3WIRE=y
+CONFIG_BT_HCIUART_INTEL=y
+CONFIG_BT_HCIUART_BCM=y
+CONFIG_BT_HCIUART_RTL=y
+CONFIG_BT_HCIUART_QCA=y
+CONFIG_BT_HCIUART_MRVL=y
+CONFIG_BT_MTKUART=y
+
+CONFIG_BT_HCIBFUSB=y
+
+CONFIG_BT_HCIBTSDIO=y
+CONFIG_BT_MRVL_SDIO=y
+CONFIG_BT_MTKSDIO=y
+
+CONFIG_BT_HCIDTL1=y
+CONFIG_BT_HCIBT3C=y
+CONFIG_BT_HCIBLUECARD=y
+
+CONFIG_BT_QCOMSMD=y
+
+CONFIG_BT_VIRTIO=y
+
+CONFIG_CRYPTO_CMAC=y
+CONFIG_CRYPTO_USER_API=y
+CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_CRYPTO_USER_API_SKCIPHER=y
+
+CONFIG_UNIX=y
+
+CONFIG_UHID=y
+
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_LOCKDEP=y
+CONFIG_DEBUG_MUTEXES=y
+
+CONFIG_OF=y
-- 
2.34.1

