Return-Path: <SRS0=v5pE=ZW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51163C43215
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Nov 2019 19:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD5B2075A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Nov 2019 19:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bonstra.fr.eu.org header.i=@bonstra.fr.eu.org header.b="noO0lae0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfK3Tro (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 30 Nov 2019 14:47:44 -0500
Received: from vault.bonstra.fr.eu.org ([51.158.68.104]:41378 "EHLO
        vault.bonstra.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfK3Trn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 30 Nov 2019 14:47:43 -0500
Received: from val.bonstra.fr.eu.org (unknown [192.168.128.2])
        by vault.bonstra.fr.eu.org (Postfix) with ESMTP id C2ED5BFAE7;
        Sat, 30 Nov 2019 19:47:41 +0000 (UTC)
Received: from localhost.localdomain (vlad.gr1 [IPv6:fd7b:45cc:aa3d::3])
        by val.bonstra.fr.eu.org (Postfix) with ESMTPSA id D075D60881;
        Sat, 30 Nov 2019 20:47:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bonstra.fr.eu.org;
        s=dkim1; t=1575143260; x=1576352860;
        bh=RkCtF3t+mrY07Rlpt9woNbDrN8gZErWsL76QRxLrVI0=;
        h=From:To:Cc:Subject:Date;
        b=noO0lae0Y45sumrYnKpQuZxnJvzL0cTz5j0c7kLPlXmxoycC9RwgHNrUp/b/FkUQh
         gUpVeNodS5y6bg7mFlqnHFqit4XcY/ksVC+6pcZ+9NMVW1SxvcW7uK/TVVcWsN4jQw
         5yPh65M2AUOOi2jx9dK3L6SkktF8YeDmffOxP4lHYICIHHnzOw84IHMLAXbvMaTnEN
         OY0akwTfPjr3aVO5ET99FrbaJfuPpW1bnkc9jCsN/R87g5QvAPX0qUPCIj1DTqnN5u
         ZGyRbqswWLwH9floSvLtlXUCGU3OpC2Hv0H4k/+rurGozpKeUsckiJJDuXHBuH8MR5
         jU45UN8EWE0zg==
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
Subject: [PATCH v3 0/3] Add Bluetooth support to Teres A64 I
Date:   Sat, 30 Nov 2019 20:47:16 +0100
Message-Id: <20191130194719.112335-1-bonstra@bonstra.fr.eu.org>
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

