Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274C3C7EE2E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Feb 2023 16:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjB0Qag (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Feb 2023 11:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjB0Qae (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Feb 2023 11:30:34 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C114EE9;
        Mon, 27 Feb 2023 08:30:33 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id y184so5620157oiy.8;
        Mon, 27 Feb 2023 08:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J+zoHpM2jDyPYbTfFjPKgZiwYudVWnE9jnnXLooJWxc=;
        b=F/f1TRdA0LKyjJ8XblFp9wHjSjlnuPA2HRM371S0R2O0MctGDnX+jt21qDT/0Vk6wF
         b0jfXANvxAnYfzcfLQCmcuqsXiYhgKE8O3HqxJisyAAkN+7VQljIQcyra7O0ZhNc+ey4
         A5q6cvXyUF5kSyX9S536N4hqQ8Y2ak96+GxHusdCIeuMnBawT1jz8tDci3h43FgC7LOX
         jyN1L10uhIhiDc48KzvUQrEP2kEDB+rS7FFMniVxOFJWlY736jsewpv5pajWsNqoFPPJ
         Vvnbhswi+XvD9+9TzVS/3nMZsuGNFDi8J4cgKdlSr+gcuIS2KO7JQ78hdl+R6IM01R8N
         ZvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+zoHpM2jDyPYbTfFjPKgZiwYudVWnE9jnnXLooJWxc=;
        b=wN4DUYRe5CaaxW6hqYwhAoyVaMVoq9hmUh1cVUVX8RbBbr3kAKzrttsezIyVNrkLUH
         NmXD1WJQYoRT11h8qWsreoMtr+pwDWmNnQwpbT7qLOAJRHSwFcHKNmSYuL8zKELqmdTg
         pFlhHhBmAbZrT7z8gyRBGKlBN6IkwwH+5725ergcXDwFd2YFDWVXerDdVHhrv4w0ocxc
         IPkUjN81fM7Gbi3fVgTO6x0yltDSHW23e9tMxR7ShDsLbPW/CyNCcOt28xsvdFH1SiYs
         +rNVKVGBVTC/RwMRbllmj3f4aichgvVlRZp4EMU8uQWcIDO/vT5K8Ozp+7IGyzpTlbfT
         q2Xg==
X-Gm-Message-State: AO0yUKVBIPPqJwS9UN1BT+jW0WJ1CvPKZT+AB/EJyDhnbOqqcgNmKrUh
        MNEvackK123n5j5ctdOBC4latzRa17Y=
X-Google-Smtp-Source: AK7set9bY2E0brjz88T3I1wKjaM9d4j80UKoTf654F49pk5OIhL/cBdpuQMfYIit6rS52Uf78vbi3Q==
X-Received: by 2002:aca:1314:0:b0:384:126a:204e with SMTP id e20-20020aca1314000000b00384126a204emr4064282oii.5.1677515432472;
        Mon, 27 Feb 2023 08:30:32 -0800 (PST)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id ex16-20020a056808299000b0037fcc1fd34bsm3267713oib.13.2023.02.27.08.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:30:32 -0800 (PST)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/3 V3] Bluetooth: Add support for RTL8821CS
Date:   Mon, 27 Feb 2023 10:30:24 -0600
Message-Id: <20230227163027.130292-1-macroalpha82@gmail.com>
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

 .../bindings/net/realtek-bluetooth.yaml       | 25 ++++++++++++-------
 .../dts/rockchip/rk3566-anbernic-rgxx3.dtsi   |  2 +-
 drivers/bluetooth/btrtl.c                     |  8 ++++++
 3 files changed, 25 insertions(+), 10 deletions(-)

-- 
2.34.1

