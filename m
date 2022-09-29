Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA0DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 11:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbiI2LEN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 07:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbiI2LEM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 07:04:12 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEF8E7E1D
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 04:04:10 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1odrKp-0007JT-Mz
        for linux-bluetooth@vger.kernel.org; Thu, 29 Sep 2022 13:04:07 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 28TB45CE3109252;
        Thu, 29 Sep 2022 13:04:05 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 0/4] Mesh: Fix IV update and KeyRefresh procedures
Date:   Thu, 29 Sep 2022 13:03:40 +0200
Message-Id: <20220929110344.26130-1-isak.westin@loytec.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 212.17.98.152
X-SA-Exim-Mail-From: isak.westin@loytec.com
X-SA-Exim-Scanned: No (on voyager.loytec.com); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Here are some modifications to the IV Update and Key Refresh procedures,
based on PTS tests:
- MESH/NODE/IVU/*
- MESH/NODE/KR/*

Best regards,
Isak

Isak Westin (4):
  mesh: Ignore Secure Network Beacon from subnet
  mesh: Ignore SNB with invalid IV Index values
  mesh: Allow Key refresh to skip Phase 2
  mesh: Allow Key Refresh Phase 0 to 3 transition

 mesh/cfgmod-server.c |  4 ++++
 mesh/net.c           | 22 +++++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.20.1





