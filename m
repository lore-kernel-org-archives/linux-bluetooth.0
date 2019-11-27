Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D656C432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 22:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D231217D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 22:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SFs22QNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfK0WjU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:39:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45222 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfK0WjU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 17:39:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id k1so11706347pgg.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2019 14:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EHVbHRnSyLZIvpQSJdKBuo3vPPZlfvB1a4T9xCgdTuw=;
        b=SFs22QNC5hMmqvZPW40mcmcBBPmEpdsOtYsMagwY9mLUglW4JRbrQ2P/YfKX6icomt
         NLkRrpV4fVV4DqFWxY2+o1sPGR5wSnEhGfUZ7IaeX0l4QG1cLky+X1vAO9Oe3Z1+jozY
         3Fc0j+mCHcHt0e2uOj7TE4FtHTgCkuVdKYlXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EHVbHRnSyLZIvpQSJdKBuo3vPPZlfvB1a4T9xCgdTuw=;
        b=TMFH4jUDJAhFiIX2NY9fRKmUqOqadhO2fT8JJfMAI9uePwcOa6H0YM9tEVgGQg+FkW
         q9zP60cMqXPhLkep70GlbVGlnRiwjBTpqDWyG98ON6iRD+013r8/0oCvCMxPH4+ibESU
         it/9bjUgWHINKhGfQcZTpCdnn0dD4dPEa9xJFRzbKd0GvoaXcOq8U6gKMyKdFJcnqMQO
         zjz3qNZ/M1eCArocWqUUDJ6/+wHbvcLBm65gD4ckD7kI9D52hUyk5BmNFE/cSAznVQG5
         QafTwiCdWjQ0lceF5WtnnYybz2HJP+B5RtkI9gdt4NfArRlbEZ9vRZfmO1Bwm9ero1aV
         TJUg==
X-Gm-Message-State: APjAAAUmqIKPtxMCSdplZvB14wdNRzMMxsg884TzWgyDyV3Ay1PZDK/3
        HWvz1ruTigUXok6jgL+FnGK4WQ==
X-Google-Smtp-Source: APXvYqzJpOpejjYn146jmpkBi176AhZDdn7NcHNIXMFDPoF5M4picmxeNcIUsNSjUqkWCk7fHfCosw==
X-Received: by 2002:a63:1e47:: with SMTP id p7mr230935pgm.339.1574894358017;
        Wed, 27 Nov 2019 14:39:18 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id d6sm17699992pfn.32.2019.11.27.14.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 14:39:17 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/1] ARM: dts: rockchip: Add brcm bluetooth for rk3288-veyron
Date:   Wed, 27 Nov 2019 14:39:08 -0800
Message-Id: <20191127223909.253873-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi Heiko,

The necessary patches for this change have been merged into
bluetooth-next. Please pick this up at your convenience.

This patch enables using the Broadcom HCI UART driver with the
BCM43540 Wi-Fi + Bluetooth chip. This chip is used on a RK3288 based
board (Veyron) and these changes have been tested on the Minnie variant
of the board (i.e. rk3288-veyron-minnie.dts).

The changes are applicable to the minnie, mickey, speedy and brain
variants (all of which use the Broadcom chips). The bt-activity node was
removed for all Veyron boards and shouldn't affect the boards using
Marvell chips since they aren't using this out-of-band wakeup gpio.

A previous portion of this series adding the compatible string to the
hci_bcm driver has already been merged into bluetooth-next:
https://lore.kernel.org/r/4680AA6A-599F-4D5E-9A96-0655569BAE94@holtmann.org

Another patch series to fix up the baudrate settings and configure the
PCM parameters has meen merged on bluetooth-next:
https://lore.kernel.org/linux-bluetooth/20191127071105.GA32820@akivisil-mobl1.ger.corp.intel.com/T/#t

Thanks
Abhishek

Changes in v2:
- Changed sco routing params to brcm,bt-pcm-int-params

Abhishek Pandit-Subedi (1):
  ARM: dts: rockchip: Add brcm bluetooth for rk3288-veyron

 arch/arm/boot/dts/rk3288-veyron-brain.dts     |  9 +++
 .../dts/rk3288-veyron-broadcom-bluetooth.dtsi | 22 +++++++
 .../boot/dts/rk3288-veyron-chromebook.dtsi    | 21 -------
 arch/arm/boot/dts/rk3288-veyron-fievel.dts    |  2 -
 arch/arm/boot/dts/rk3288-veyron-jaq.dts       | 22 +++++++
 arch/arm/boot/dts/rk3288-veyron-jerry.dts     | 22 +++++++
 arch/arm/boot/dts/rk3288-veyron-mickey.dts    |  9 +++
 arch/arm/boot/dts/rk3288-veyron-minnie.dts    | 21 +++++++
 arch/arm/boot/dts/rk3288-veyron-pinky.dts     | 22 +++++++
 arch/arm/boot/dts/rk3288-veyron-speedy.dts    | 21 +++++++
 arch/arm/boot/dts/rk3288-veyron.dtsi          | 59 +++----------------
 11 files changed, 155 insertions(+), 75 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-broadcom-bluetooth.dtsi

-- 
2.24.0.432.g9d3f5f5b63-goog

