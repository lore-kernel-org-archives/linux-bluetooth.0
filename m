Return-Path: <SRS0=TRpe=UV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95E4C43613
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Jun 2019 07:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB20A20644
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Jun 2019 07:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfFVHUJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Jun 2019 03:20:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:62874 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfFVHUI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Jun 2019 03:20:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2019 00:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,403,1557212400"; 
   d="scan'208";a="162878334"
Received: from spoorthi-h97m-d3h.iind.intel.com ([10.223.96.21])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2019 00:20:06 -0700
From:   spoorthix.k@intel.com
To:     spoorthix.k@intel.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fast advertising interval
Date:   Sat, 22 Jun 2019 12:59:42 +0530
Message-Id: <1561188582-10356-1-git-send-email-spoorthix.k@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561108931-9568-1-git-send-email-spoorthix.k@intel.com>
References: <1561108931-9568-1-git-send-email-spoorthix.k@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>

Changes made to add support for fast advertising interval
as per core 4.1 specification, section 9.3.11.2.

A peripheral device entering any of the following GAP modes and
sending either non-connectable advertising events or scannable
undirected advertising events should use adv_fast_interval2
(100ms - 150ms) for adv_fast_period(30s).

         - Non-Discoverable Mode
         - Non-Connectable Mode
         - Limited Discoverable Mode
         - General Discoverable Mode

This is Gentle Reminder to know the updates of the patch for Fast advertising interval.

