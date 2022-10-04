Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D60C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 08:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiJDIZy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Oct 2022 04:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJDIZx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Oct 2022 04:25:53 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A8A22511
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Oct 2022 01:25:51 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1ofdFN-0002Gn-R3
        for linux-bluetooth@vger.kernel.org; Tue, 04 Oct 2022 10:25:49 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 2948PkTZ2433476;
        Tue, 4 Oct 2022 10:25:47 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 0/4] Mesh: Fixes for friendship procedures
Date:   Tue,  4 Oct 2022 10:25:26 +0200
Message-Id: <20221004082530.25719-1-isak.westin@loytec.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 212.17.98.152
X-SA-Exim-Mail-From: isak.westin@loytec.com
X-SA-Exim-Scanned: No (on voyager.loytec.com); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

Here are a few patches targeting the mesh friendship behaviour. Found
during PTS testing of:
  - MESH/NODE/FRND/FN/*

Happy for any feedback.

Best regards,
Isak

Isak Westin (4):
  mesh: Correct size of friend cache
  mesh: Verify padding bits in Friend Poll messages
  mesh: Queue a friend update on IV Update change
  mesh: Always relay messages from Low Power nodes

 mesh/friend.c |  2 +-
 mesh/net.c    | 50 ++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 39 insertions(+), 13 deletions(-)

-- 
2.20.1





