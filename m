Return-Path: <SRS0=fj53=SU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7215C10F0E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 09:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17992183E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 09:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388665AbfDRJIP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:08:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36159 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388244AbfDRJIO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Apr 2019 05:08:14 -0400
X-UUID: faa9e705d0454b10b25c80cbaa2020eb-20190418
X-UUID: faa9e705d0454b10b25c80cbaa2020eb-20190418
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 908188968; Thu, 18 Apr 2019 17:08:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 18 Apr 2019 17:08:03 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 18 Apr 2019 17:08:04 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <ulf.hansson@linaro.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 0/4] Add a couple of enhancements to btmtksdio
Date:   Thu, 18 Apr 2019 17:07:58 +0800
Message-ID: <cover.1555577565.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

First three are all minor changes and the final one adds a runtime pm support to
enter a lower power state for decreasing power dissipation when there is idle
traffic in SDIO transport for a while.

Sean Wang (4):
  Bluetooth: btmtksdio: Drop newline with bt_dev logging macros
  Bluetooth: btmtksdio: Add a bit definition for CHLPCR
  Bluetooth: btmtksdio: Fix hdev->stat.byte_rx accumulation
  Bluetooth: btmtksdio: Add runtime PM support to SDIO based Bluetooth

 drivers/bluetooth/btmtksdio.c | 161 ++++++++++++++++++++++++++++++++--
 1 file changed, 153 insertions(+), 8 deletions(-)

-- 
2.18.0

