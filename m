Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBF0C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98AE2086D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2HHbcWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfARRCp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:02:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32904 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfARRCp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 12:02:45 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so6343864pgu.0;
        Fri, 18 Jan 2019 09:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fTwTJ6DcxG+KFm9dgnIsmZ7TQbsxD7TvxVrP3lKUQbE=;
        b=M2HHbcWzq/zZQrN8K8KEDRWT2AAz+ERJaSb0g2jUKl2A0QXdNrTPAhRH2tbjFGSAqZ
         n0njzd3M/B/9B9tvZxaAxIJjZXYWlvMrvlSsP3p8f3m1P9OtrzSvKSFWr7/vQ7sKFfk+
         aALZaVErmlKhfH0EF3mwFO0wnL52lmIvWjHSlPKU1dRsXbbArWunIuyY21hp3PcYJ50g
         MEo20yOFxGV/2e6Z2miQGFgjMDjYlMTEvLtoR/OyGah8v6Z6zUiPrO43bdUnyCfeZKZq
         kGSmlkaT5VIgS1hs0Kr3Gq5PM+X/78cNv8E0tSzMIZC7VkZG/81zccor+4xMZZCmuLT3
         RttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fTwTJ6DcxG+KFm9dgnIsmZ7TQbsxD7TvxVrP3lKUQbE=;
        b=VMxWzOS3Sn/OCpv4tj7oEDxor6HWwH5COxh1IQRbyj6biz3zD43JLTbqLQESZlVBbu
         KOLecsCEVa69EevTUgaTGGWOUH1PUXExFudQhdmr3eiEAcTayrlHQ3OCx2jkXZFeTjgX
         mMabHpa0bLk5KHdA3koeqVE04xELAqRSvC5s07hDt4U6KiJuagPiHbL7AoB3HqdOeE8i
         E+lqRZXeTImVjNhT1TnlonT6tTHJbRmL64Xh6JdWUbpdjtgiP3WIgXCluAo8WDj+fmXL
         nlx6qJU4eTlYzw74r6sWhcLlmzkNmNUu1SLACGPAisOvyFXwglFrh5rz4xFiGz6519g5
         2hvA==
X-Gm-Message-State: AJcUukcHvyy6HGgEchpYY0kb1JMUF1iOywBYmUQGhgw0wlcLbHufcUkX
        cbt9N3diceRDm9KC6WUp0RGZejRo7kA=
X-Google-Smtp-Source: ALg8bN7HAgdYJ+NDkn3J1J5MtD2MNJnml/Mm6sagtlXyOBk1679E809p1lTbiMhY196fm6at322PBQ==
X-Received: by 2002:a63:9712:: with SMTP id n18mr18138607pge.295.1547830963881;
        Fri, 18 Jan 2019 09:02:43 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net. [216.71.193.140])
        by smtp.gmail.com with ESMTPSA id b4sm5672222pgq.65.2019.01.18.09.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:02:43 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/8] Add support for rtl8723bs/rtl8723cs bluetooth
Date:   Fri, 18 Jan 2019 09:02:24 -0800
Message-Id: <20190118170232.16142-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

rtl8723{bc}s is WiFi/Bluetooth module, WiFi part is connected over SDIO
while bluetooth is connected over UART.

This series adds support for rtl8723bs/rtl8723cs bluetooth.

Bluetooth module in rtl8723cs is buggy - it advertises some features that
it doesn't support and responds either with garbage or with errors on
corresponding commands. Unfortunately that confuses bluetooth stack,
so we need to introduce another quirk.

Patches for Pine64 and Sopine are provided as examples since WiFi/BT module
is optional on these boards.

Vasily Khoruzhick (8):
  Bluetooth: Add new quirk for broken local ext features max_page
  Bluetooth: hci_h5: Add support for reset GPIO
  dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
  Bluetooth: hci_h5: Add support for binding RTL8723BS with device tree
  Bluetooth: btrtl: add support for the RTL8723CS
  arm64: allwinner: a64: enable Bluetooth On Pinebook
  DO-NOT-MERGE: arm64: allwinner: a64: enable Bluetooth On Pine64
  DO-NOT-MERGE: arm64: allwinner: a64: enable Bluetooth On SoPine
    baseboard

 .../bindings/net/rtl8723bs-bluetooth.txt      |  35 +++++
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  |  10 +-
 .../dts/allwinner/sun50i-a64-pinebook.dts     |  14 ++
 .../allwinner/sun50i-a64-sopine-baseboard.dts |  14 ++
 drivers/bluetooth/btrtl.c                     | 128 +++++++++++++++++-
 drivers/bluetooth/btrtl.h                     |  12 ++
 drivers/bluetooth/hci_h5.c                    |  33 +++++
 include/net/bluetooth/hci.h                   |   7 +
 net/bluetooth/hci_event.c                     |   4 +-
 9 files changed, 252 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt

-- 
2.20.1

