Return-Path: <SRS0=Kz1L=YT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5C9CA9EC0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Oct 2019 20:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8023214DA
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Oct 2019 20:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bonstra.fr.eu.org header.i=@bonstra.fr.eu.org header.b="uEs56XPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfJZUsj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Oct 2019 16:48:39 -0400
Received: from vault.bonstra.fr.eu.org ([51.158.68.104]:39570 "EHLO
        vault.bonstra.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfJZUsj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Oct 2019 16:48:39 -0400
Received: from val.bonstra.fr.eu.org (unknown [192.168.128.2])
        by vault.bonstra.fr.eu.org (Postfix) with ESMTP id 191D7BFB41;
        Sat, 26 Oct 2019 20:41:47 +0000 (UTC)
Received: from bonstra.fr.eu.org (vlad.gr1 [IPv6:fd7b:45cc:aa3d::3])
        by val.bonstra.fr.eu.org (Postfix) with ESMTPSA id 3716D6086E;
        Sat, 26 Oct 2019 22:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bonstra.fr.eu.org;
        s=dkim1; t=1572122506; x=1573332106;
        bh=gvjqgmyM6VpYYfnUpsZRKeggNshVkGNMAOiusppf46w=;
        h=From:To:Cc:Subject:Date;
        b=uEs56XPhlioXD792dC59KX4V1Y0ydsgmshAbLCVJCDWDn4mEoMy+GSVRj9AJivYjl
         lultWVqd3JyWtVOXsRrw2r5GZUPUgKL2dvGOwT0rIW+r3cYQOPf+jDqDjuBRBxJgpf
         fIePuQj/E3AKqbPaf5kDoUG6vhj6Mm/xfDYwG5A5m7uzTjgPJYuE1o+e/fEjZYbLLD
         IuMYHARTwI9P6rSV2K5e1Y9N0BWsycgZ4h8iui99u1kJZvcC2D67yoPSU9ny7WYKHq
         LhSqF8s74YJ3qxJXbc9dpWYnfpJv4VBW7Zzi9pDc66yQKXgm+stFiTCeb6Vv7BW0A8
         gViiuwO2mKlFA==
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
Subject: [PATCH 0/3] Add Bluetooth support to Teres A64 I
Date:   Sat, 26 Oct 2019 22:41:13 +0200
Message-Id: <20191026204116.95119-1-bonstra@bonstra.fr.eu.org>
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

Hugo Grostabussiat (3):
  dt-bindings: net: bluetooth: add DT binding for rtl8723bs
  Bluetooth: hci_h5: Add DT support for rtl8723bs
  arm64: dts: allwinner: a64: Enable Bluetooth on Teres-I

 .../bindings/net/realtek,rtl8723bs-bt.txt     | 25 ++++++++++++
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts | 13 ++++++
 drivers/bluetooth/hci_h5.c                    | 40 ++++++++++++++++---
 3 files changed, 73 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/realtek,rtl8723bs-bt.txt

-- 
2.23.0

