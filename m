Return-Path: <SRS0=39h9=NL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0311CC0044C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Oct 2018 08:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89D42080A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Oct 2018 08:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89D42080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeJaRM0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Oct 2018 13:12:26 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:54125 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJaRMZ (ORCPT
        <rfc822;groupwise-linux-bluetooth@vger.kernel.org:0:0>);
        Wed, 31 Oct 2018 13:12:25 -0400
Received: from linux-vvou.apac.novell.com (unknown.telstraglobal.net [134.159.103.118])
        by smtp.nue.novell.com with ESMTP (NOT encrypted); Wed, 31 Oct 2018 09:15:19 +0100
From:   "Cho, Yu-Chen" <acho@suse.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     acho@suse.com, jlee@suse.com
Subject: [PATCH 0/3 BlueZ] hcidump: fix buffer overflow 
Date:   Wed, 31 Oct 2018 16:15:05 +0800
Message-Id: <20181031081508.25927-1-acho@suse.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Bugs were simple buffer overflow that was actually discovered already couple years ago
by op7ic:https://www.spinics.net/lists/linux-bluetooth/msg68892.html
Caused by missing boundary checks before accessing.

Cho, Yu-Chen (3):
  hcidump: fixed AMP Assoc dump heap-over-flow
  hcidump:fixed hci frame dump stack-buffer-overflow
  hcidump: Fix set_ext_ctrl() global buffer overflow

 tools/parser/amp.c   | 65 +++++++++++++++++++++++---------------------
 tools/parser/hci.c   |  3 ++
 tools/parser/l2cap.c |  2 +-
 3 files changed, 38 insertions(+), 32 deletions(-)

-- 
2.19.1

