Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E681AC64ED8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Feb 2023 23:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjBXXYF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 18:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjBXXYE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 18:24:04 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1356F2914C;
        Fri, 24 Feb 2023 15:23:46 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-172334d5c8aso1282878fac.8;
        Fri, 24 Feb 2023 15:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FqMX1kBnBaZ72UwNdZkYXZByDzuRIUZQRVCNYKPo0b8=;
        b=TTY6DNM/PMh3JOkOssOec6WWyBlD3QuF9o0NMvMWnwl74653WIR8WGPLhjslVTT8/I
         m7mNErTyDQWPWTZXeDsTSET8MVuJqNy7UfdSrG1V4/hSvhra2yJSW3FgyxqKcgEqJSpw
         rqIO767ZiN7CaQbeFYXUsHMWSf+RJCiA+IS3BBSMpJP3M1rszxonMosbZ7GENclY5YVO
         LkL4BI5h9ZIXHHfA3/dMICvkjUvJSlViVMrRHdK/K0RDcdkHTPLDfNY+VTYmSmJkqXJK
         HID2ca7bBgdMLqdK7y7kmMr7/IFx37EXpnnC3E0IvAlx/gzsGkb8vzWIIjobLJxfHVRX
         Ni/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqMX1kBnBaZ72UwNdZkYXZByDzuRIUZQRVCNYKPo0b8=;
        b=MT1L6/6yFk0bGgwLhzJ6QFFmP2rwMuD4uhkNqrM9lQQ8A40P9Ng+bX1+NNAKzjZi5N
         Y/lm74goulMfZAM3dZ5zRugBeyivrtxV42Nqep+WtrEH/N+JJDMOBokdNQUn2FdrRBIK
         J9jG7+sx7/Bd1EU6keFR1O0XctoX1DjwsNh4ohKJ0/jpk56vgEM5ivOvlsnQpeXfIYmn
         jU1sbsQ7Sqa9IlcxBzQmM2UX1Jsrv4/SPvZ3otGMM6IdArH27se0tBLV7e8lwP2nQ3M3
         M0ZyhCT/iGZtEuDVpFKN+3fb7FKRjOcBW6ZXxuBzHax9SZwvZaRxbDzUSplmCaptjmcI
         bLaA==
X-Gm-Message-State: AO0yUKW7l2jFEFdQomWwW3ahUozhuX2YWf76sQL7aqQHUpjj1EGgzLec
        UqinK8U+wEtBg7wF5ZHMeSMGUbkEQao=
X-Google-Smtp-Source: AK7set+ZmSVx3hXfcnUMyRKf1lnolsA4EM9V8jLlg8Mfys9Z49G3ULY6fJ1FC1IKVO0bvB80bhwqyg==
X-Received: by 2002:a05:6870:b621:b0:16e:8faf:a35e with SMTP id cm33-20020a056870b62100b0016e8fafa35emr16212371oab.25.1677281025121;
        Fri, 24 Feb 2023 15:23:45 -0800 (PST)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870d39600b0016b0369f08fsm119706oag.15.2023.02.24.15.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 15:23:43 -0800 (PST)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/3 V2] Bluetooth: Add support for RTL8821CS
Date:   Fri, 24 Feb 2023 17:23:36 -0600
Message-Id: <20230224232339.124969-1-macroalpha82@gmail.com>
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

 .../bindings/net/realtek-bluetooth.yaml       | 23 +++++++++++--------
 .../dts/rockchip/rk3566-anbernic-rgxx3.dtsi   |  2 +-
 drivers/bluetooth/btrtl.c                     |  8 +++++++
 3 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.34.1

