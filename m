Return-Path: <SRS0=v5pE=ZW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9535FC43215
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Nov 2019 20:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6773022464
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Nov 2019 20:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bonstra.fr.eu.org header.i=@bonstra.fr.eu.org header.b="fK81ndsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfK3UXi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 30 Nov 2019 15:23:38 -0500
Received: from vault.bonstra.fr.eu.org ([51.158.68.104]:41436 "EHLO
        vault.bonstra.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfK3UXi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 30 Nov 2019 15:23:38 -0500
Received: from val.bonstra.fr.eu.org (unknown [192.168.128.2])
        by vault.bonstra.fr.eu.org (Postfix) with ESMTP id 7AE5FBFAD5;
        Sat, 30 Nov 2019 20:23:36 +0000 (UTC)
Received: from localhost.localdomain (vlad.gr1 [IPv6:fd7b:45cc:aa3d::3])
        by val.bonstra.fr.eu.org (Postfix) with ESMTPSA id A3C916087F;
        Sat, 30 Nov 2019 21:23:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bonstra.fr.eu.org;
        s=dkim1; t=1575145415; x=1576355015;
        bh=EkYZVheVtj6JdQcHQTJq2AeD/CfG6Cz8/zhSSf21WOQ=;
        h=From:To:Cc:Subject:Date;
        b=fK81ndsbMjfHEgAnkO0a/Gi8j+LBHvShdbga4f8REdVqI5o/X86UXVqcY7TuTjPhq
         +GhW9p4eDr2Suq58dj0nbI7os1rDyhKnL7IGWUi1xrrR0eQnDvdQesW8zHEp9+04jz
         SnPsY3r8PfF/aGOhlAfw4YhHydY+g4SIR6GuBzbur/2vMrEumHkvzAGLa2tjs0VE/e
         T+nwBlFftMsP3gthvf2GX9BTFXvLPtrHsx0D7ji0T3Ky7Vs0CBRAWq3lG5idBF9ngF
         RtLqJAg0TQOCVQVfm5gyf/FNGE4vmycTr1NpX4qVuGeSsyBy+D0cmBI2DVwylb4Y8e
         xNvFOqyOxRVlg==
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
Subject: [PATCH v4 0/3] Add Bluetooth support to Teres A64 I
Date:   Sat, 30 Nov 2019 21:23:11 +0100
Message-Id: <20191130202314.142096-1-bonstra@bonstra.fr.eu.org>
X-Mailer: git-send-email 2.24.0
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

Changes since v3:
- Rebase on v5.4 (sorry for the noise :/ )

Changes since v2:
- Convert bindings to dt-schema
- Update GPIO property names
- Rename "enable-gpios" to "powerdown-gpios", and invert the logic in the
  driver code
- Use the "firmware-file" property instead of "config-name", and adjust
  driver code to accept a full file name instead of a postfix

Hugo Grostabussiat (3):
  dt-bindings: net: bluetooth: add DT bindings for Realtek controllers
  Bluetooth: hci_h5: Add DT support for rtl8723bs
  arm64: dts: allwinner: a64: Enable Bluetooth on Teres-I

 .../bindings/net/realtek-bluetooth.yaml       | 52 +++++++++++++
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts | 14 ++++
 drivers/bluetooth/Kconfig                     |  2 +-
 drivers/bluetooth/btrtl.c                     | 75 ++++++++++---------
 drivers/bluetooth/btrtl.h                     |  3 +-
 drivers/bluetooth/hci_h5.c                    | 65 ++++++++++++----
 6 files changed, 161 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.yaml

-- 
2.24.0

