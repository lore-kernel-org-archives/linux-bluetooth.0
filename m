Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BC1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 15:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiJFPAD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiJFO76 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 10:59:58 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78FD1F638
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 07:59:54 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1ogSLo-0006rd-16
        for linux-bluetooth@vger.kernel.org; Thu, 06 Oct 2022 16:59:52 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 296ExnRC4163430;
        Thu, 6 Oct 2022 16:59:49 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 0/6] Mesh: Fixes for PTS issues
Date:   Thu,  6 Oct 2022 16:59:21 +0200
Message-Id: <20221006145927.32731-1-isak.westin@loytec.com>
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

Here is the last patch set with fixes for issues found during PTS
testing. This covers following tests:
 - MESH/NODE/PROV/*
 - MESH/NODE/TNPT/*
 - MESH/NODE/RLY/*

Best regards,
Isak

Isak Westin (6):
  mesh: Update Key Refresh flag after provision
  mesh: provisionee: Handle unknown PDUs
  mesh: provisionee: Handle failed provisioning
  mesh: provisionee: Check prov start parameters
  mesh: Keep canceled SAR data for at least 10 sec
  mesh: Fix msg cache ring buffer

 mesh/net.c           | 33 +++++++++++++++++---
 mesh/node.c          |  4 +--
 mesh/prov-acceptor.c | 73 +++++++++++++++++++++++++++++++++++---------
 3 files changed, 90 insertions(+), 20 deletions(-)

-- 
2.20.1





