Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E7AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 21:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbiEXViZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 17:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241945AbiEXViX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 17:38:23 -0400
X-Greylist: delayed 917 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 May 2022 14:38:22 PDT
Received: from sender11-of-o53.zoho.eu (sender11-of-o53.zoho.eu [31.186.226.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985F57C173
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 14:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653427341; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=RDDY9bThuyuptIf+ctqCWHQ+TX2DXrCRDM475nm00NC9aIXdMxh8kCFdzYARvieGZjc1UbwDkHu8DK8hmH4cwhfBTIek/TxRuOHHOJCXECu2EaaFSpYA1bFEfZ8j+FnXWcD2lQOQlydnRAH90Mu0PmiEvPF6nqYA5DnAaB0BGks=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1653427341; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=eUsYtGvjMVMeiJbcfkFwYYtNYc+bXWXsUkZz7xnU2AE=; 
        b=bx7m7ovII/BQ4+3ZQfx9WOO/sNeWbeEGaMPNItlzzN5+mm1hf5CxuMtuPyNSRGxnvF3tq/aoGLlFkIBdmXjNg5GQgvOEHs+lG86eyJK6XMQ76o7wSZAwKF6VoxioQRzAyRs3io4aMKhMY//taRESiiOf0UmifqLiwaQDkRe5cn8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=hostmaster@neglo.de;
        dmarc=pass header.from=<bage@debian.org>
Received: from localhost.localdomain (port-92-194-239-176.dynamic.as20676.net [92.194.239.176]) by mx.zoho.eu
        with SMTPS id 165342733992663.21335406305718; Tue, 24 May 2022 23:22:19 +0200 (CEST)
From:   Bastian Germann <bage@debian.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kubakici@wp.pl>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Cc:     Bastian Germann <bage@debian.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Message-ID: <20220524212155.16944-1-bage@debian.org>
Subject: [PATCH v2 0/3] arm64: allwinner: a64: add bluetooth support for Pinebook
Date:   Tue, 24 May 2022 23:21:51 +0200
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Pinebook uses RTL8723CS for WiFi and bluetooth. Unfortunately RTL8723CS
has broken BT-4.1 support, so it requires a quirk.

Add a quirk, wire up 8723CS support in btrtl and enable bluetooth
in Pinebook dts.

This series was sent in July 2020 by Vasily Khoruzhick.
This is a rebase on the current tree.
I have tested it to work on the Pinebook.

Changelog:
v2:
   * Rebase
   * Add uart-has-rtscts to device tree as requested by reviewer

Vasily Khoruzhick (3):
  Bluetooth: Add new quirk for broken local ext features max_page
  Bluetooth: btrtl: add support for the RTL8723CS
  arm64: allwinner: a64: enable Bluetooth On Pinebook

 .../dts/allwinner/sun50i-a64-pinebook.dts     |  13 ++
 drivers/bluetooth/btrtl.c                     | 120 +++++++++++++++++-
 drivers/bluetooth/btrtl.h                     |   5 +
 drivers/bluetooth/hci_h5.c                    |   4 +
 include/net/bluetooth/hci.h                   |   7 +
 net/bluetooth/hci_event.c                     |   4 +-
 6 files changed, 148 insertions(+), 5 deletions(-)

-- 
2.36.1


