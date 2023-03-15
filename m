Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A636C74A5B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 17:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjCORhK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjCORhI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 13:37:08 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85670233EA;
        Wed, 15 Mar 2023 10:37:06 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id o4-20020a9d6d04000000b00694127788f4so10577939otp.6;
        Wed, 15 Mar 2023 10:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678901824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mTPdfXZz7TdYFcy/x5+HjC8JRJTWloTy01FYnVAwbHA=;
        b=Ku6XlJh1PziEg8LMmPPAm/Jophfxs7ETRkjqLTCfwsmN/Si2RJEeZSEvrc2uRbRyfq
         xUKX4OoCT0Sk79BO12m4FbOQqnlN5/tsrwSu8/NteBHHerr22/iL8zsIkEQt7DSj51H/
         CKaUuGisGEIIUjEYzEqSxsS1qFuA2hdc0x1eFeldLcjkiwneCq2QdqKhn7h3T0yBvEY5
         8aA2YK6zhbOVEVeCCJFDsNFflQWpYK+q8RS8G8QlhW5LWl8kTMxKhhBMA0KsHoNLzhOd
         7dq+K8RazFJhXP0f7hheLvV2F4XrU8/zYzXCN74sZIA5nouw5hFch+G78qPVzdC4isc6
         drUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678901824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTPdfXZz7TdYFcy/x5+HjC8JRJTWloTy01FYnVAwbHA=;
        b=yvD4T6SHImH4Rwkbe4u27AArmTHBlaUe+J5AEwv3Y83r3hbYIwH2VfTaCjSECuELmm
         QMKUUHi7gfee3hXST33KrYWVkPit4JsaUbVxVvf42PJ5zMKnMnvU3/jkzNUhzLZu+gw5
         0DKmnX7BpEKXJoF080fL+1410HKhZ7SwEvGobv58IPy0B/WzeUuoWw2Gp1FwanEefgHx
         7Nro37KNEP734b52wwGWZt5ER3WZpK0DdmXfTsjNFBisgaRGVWAQ5B/EltzAaavTUezD
         fJ9DY9T33VdTBTen3aKJdWVJhKIqxnct6J3JkrCU0nUn26+XPLCVa3OIt/S79lXRpmBO
         sedg==
X-Gm-Message-State: AO0yUKVHJEIBf2SYXuYQxWzIWZM0cT7cGAO5JdVaeK5TkGnrNAtDtzcw
        D3g8NSdR9kqhezTkLklSA7+B1RjSS70=
X-Google-Smtp-Source: AK7set/fkNgmYshbuJ/7NBJdbsQWcG3G+YfTmP8N/EOcGgvXruu6pr2EUvLoGlXFHhfBM/JX0ie3hw==
X-Received: by 2002:a9d:6503:0:b0:68b:9e3b:3758 with SMTP id i3-20020a9d6503000000b0068b9e3b3758mr17868724otl.9.1678901823748;
        Wed, 15 Mar 2023 10:37:03 -0700 (PDT)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id a23-20020a9d3e17000000b0068abc8e786fsm2562044otd.10.2023.03.15.10.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:37:03 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/3 V5] Bluetooth: Add support for RTL8821CS
Date:   Wed, 15 Mar 2023 12:36:54 -0500
Message-Id: <20230315173657.28692-1-macroalpha82@gmail.com>
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

Changes from V4:
 - After extensive testing it was found that there are problems with
   using the bluetooth that were not caught with the initial testing.
   This can be mitigated by setting the "H5_INFO_WAKEUP_DISABLE" flag.
   The easiest way to accomplish that is to change the fallback
   compatible string to "realtek,rtl8723bs-bt". Updated the binding
   documentation and binding to reflect this. No change to the driver
   from V4 was necessary. Removed "reviewed-by" from documentation due
   to this change.

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

