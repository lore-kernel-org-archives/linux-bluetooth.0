Return-Path: <SRS0=evc1=YX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DF2CA9ECB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Oct 2019 22:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEF02190F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Oct 2019 22:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bonstra.fr.eu.org header.i=@bonstra.fr.eu.org header.b="D65+CVGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfJ3WoZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:44:25 -0400
Received: from vault.bonstra.fr.eu.org ([51.158.68.104]:39602 "EHLO
        vault.bonstra.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfJ3WoZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Oct 2019 18:44:25 -0400
Received: from val.bonstra.fr.eu.org (unknown [192.168.128.2])
        by vault.bonstra.fr.eu.org (Postfix) with ESMTP id 34C35BFA6F;
        Wed, 30 Oct 2019 22:44:23 +0000 (UTC)
Received: from bonstra.fr.eu.org (vlad.gr1 [IPv6:fd7b:45cc:aa3d::3])
        by val.bonstra.fr.eu.org (Postfix) with ESMTPSA id 2BA0D60867;
        Wed, 30 Oct 2019 23:44:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bonstra.fr.eu.org;
        s=dkim1; t=1572475462; x=1573685062;
        bh=hN7gHaVUK5ZMbPRnceGRaiMn7uHg7Ow1mQRtIL7MrsQ=;
        h=From:To:Cc:Subject:Date;
        b=D65+CVGdG9IlQOz2tzLZSK4bVuFiUCkab7bNtQjNIuQv2YmF9StKDt4pApeBzII8N
         E81+y+3XGxpcGM7nRVxQZBq9piaWdA5l3tlnFFLHdnOA7x5TdOyFnRjC+jutKvSjV7
         8dLQ5rclcINvhGGE2Dx4D7eUsqJ80wioIf+AwbbdFhLfQVQFM1n/jutNgCKwOp/V1J
         NbA9J0cqtJ1LFcw/YD1iJ273wYbAqeHVpdYTbFoaIBqdH8p+UXojsazoT7YVUF3nmH
         33+u4mMd067yaKyruNiwu9jiP2gC9AUXWplFflW7wxlZ6Zl2fMJtRGMzUo68HG0bYV
         U6S5piU8DMZpw==
From:   Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/3] Add Bluetooth support to Teres A64 I
Date:   Wed, 30 Oct 2019 23:43:30 +0100
Message-Id: <20191030224333.70241-1-bonstra@bonstra.fr.eu.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Teres A64 I laptop comes equipped with a serial-attached Realtek
rtl8723bs Bluetooth controller. This series creates the DT binding for
the the Realtek vendor extension of the HCI H5 driver, for which ACPI
bindings already exist, and enable support for the Teres A64 I board.

The first patch adds the DT binding documentation.
The second one implements such binding in the HCI H5 driver.
The last patch adds the appropriate device node to the Teres A64 I dts
file to enable Bluetooth.

Changes since v1:
- Adjusted driver code following advice from Marcel Holtmann (thanks for
  your time!)
- The DT bindings are documented for all serial attached Realtek controllers
  instead of juste the rtl8723bs
- Made the "config-name" property generic by removing the vendor prefix
- Kconfig change to make BT_HCIUART_RTL depend on either ACPI or OF

Hugo Grostabussiat (3):
  dt-bindings: net: bluetooth: add DT binding for Realtek controllers
  Bluetooth: hci_h5: Add DT support for rtl8723bs
  arm64: dts: allwinner: a64: Enable Bluetooth on Teres-I

 .../bindings/net/realtek-bluetooth.txt        | 25 ++++++++++++
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts | 13 ++++++
 drivers/bluetooth/Kconfig                     |  2 +-
 drivers/bluetooth/hci_h5.c                    | 40 ++++++++++++++++---
 4 files changed, 74 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.txt

-- 
2.23.0

