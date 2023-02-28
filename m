Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F621C6FA8E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Feb 2023 15:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjB1PWN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Feb 2023 10:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjB1PWM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Feb 2023 10:22:12 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760F030B1E;
        Tue, 28 Feb 2023 07:22:11 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1723ab0375eso11273553fac.1;
        Tue, 28 Feb 2023 07:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZINZr24IPypfc8Mbr2NS8J6caC0I66oepeOa6nqVCc=;
        b=PTOU94NTsu451MMt6lo/eqWICOkaylcV/6yv7DwF+rDmMQfwjK9KRlDTgm4h+zIk1j
         Z3SMiFx6OUELNQnr44GdLqjWdEdPoDkOeXNvXJMAAqhx9XtoRTFAcEsJMdxcznSwbkU1
         x9dqe6YlWRs1rzUXR6W1YL/61IaL8af8a046Fb5/STtcZagUUi6pHSy8YrCmx59Vt37S
         I7mOrUnLTwzzxQUTrHS8NBFkC9YDpAmDtMG+hPK3lVYutWB+1bmokrdWDc+br++oECY/
         CssMGpX7vMe5lm9Ip4d4Uyfg4+8CRTm9cmkHmCIbQYsZ6IfxeyhXEzTzETGWl4cCQe/v
         YJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZINZr24IPypfc8Mbr2NS8J6caC0I66oepeOa6nqVCc=;
        b=OFaiTVM2oOTkX7e7sQDPaefX30MbckSNdBHoTBxBF2hJrgY/I82GVqPmoJj4Hlnla9
         9Fco+kesquElzRsFuFLv9l8oZlUV1y1fdQE6FBy4prcLiKy0o2+f7ngoD1EFOSlgJHyP
         jVcJHIjU4FFMMpkl9rZRvQ8ej3D9z1btxevNMHVnc1CoVj2a+2xTG87p0CfJ8o5GrDym
         2L5Jsc/swvvkXsp3CJHM2HRULDWsQAqhoVy6kR0RHERdLkTdPzQN4DaNgqrd0OaT425V
         UcrU3XfywH30DKe9B3oqWsygzcWBO02Xy4BVSKplhlRAOwv7Chm+ehMeQPf+KDYxLTy9
         tyuw==
X-Gm-Message-State: AO0yUKXS5pJGY0Rg5rd/U5CRDQ5gkA9o661FT8/mFmponNhR/NDBn3zV
        xDvspIQx4Spxrpylb/qcxvWS1MlN/C8=
X-Google-Smtp-Source: AK7set/d2yFBcIx3QZ9+WAlPuDU8jy0GvNS483gxd9YJjKP83i4QFU3/xhWEoFQlffdP9AcT2sZcRA==
X-Received: by 2002:a05:6870:8993:b0:172:4748:32d9 with SMTP id f19-20020a056870899300b00172474832d9mr1473141oaq.3.1677597730592;
        Tue, 28 Feb 2023 07:22:10 -0800 (PST)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id yy23-20020a056871259700b0017264f96879sm3318321oab.17.2023.02.28.07.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:22:10 -0800 (PST)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/3 V4] Bluetooth: Add support for RTL8821CS
Date:   Tue, 28 Feb 2023 09:22:02 -0600
Message-Id: <20230228152205.133582-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

This patch series is to add support for the RTL8821CS Bluetooth
controller found on the RTL8821CS WiFi/Bluetooth combo chip.

This has been tested with firmware version 0x75b8f098 which has been
submitted by Realtek for inclusion in linux-firmware.

https://lore.kernel.org/linux-firmware/20230223062453.181239-1-max.chou@realtek.com/

Changes from V3:
 - Corrected bindings so that all but the 8821 use enum, and 8821 uses
   items.

Changes from V2:
 - Corrected devicetree documentation to change compatible from const
   back to enum.
 - Removed "reviewed-by" from Alistair Francis as binding documentation
   updated with changes.

Changes from V1:
 - Switched to use a fallback string for the rtl8822cs so as to not add
   an extra entry to the of_device_id table. The driver is capable of
   selecting the correct firmware blob to load.
 - Updated the messages to note a new version of the firmware was
   tested and that Realtek has submitted this firmware upstream.
 - Updated the devicetree node on the Anbernic RGxx3 series to use the
   fallback string of realtek,rtl8822cs-bt.

Chris Morgan (3):
  dt-bindings: net: realtek-bluetooth: Add RTL8821CS
  Bluetooth: hci_h5: btrtl: Add support for RTL8821CS
  arm64: dts: rockchip: Update compatible for bluetooth

 .../bindings/net/realtek-bluetooth.yaml       | 24 ++++++++++++-------
 .../dts/rockchip/rk3566-anbernic-rgxx3.dtsi   |  2 +-
 drivers/bluetooth/btrtl.c                     |  8 +++++++
 3 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.34.1

