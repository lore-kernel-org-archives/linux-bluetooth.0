Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D438C433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 18:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0061420771
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 18:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbhADSjK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jan 2021 13:39:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:49521 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbhADSjJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jan 2021 13:39:09 -0500
IronPort-SDR: qStHw9qxDtrSga8MNdAnSjtfcJyAWjCShFZirjoMFhNPpqmsLfcaCKBnTMF7UyMZtCDEWIG5uc
 9G35kfBiFkMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="177145236"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="177145236"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 10:38:28 -0800
IronPort-SDR: i6bOQyoMLL4TASZ5xDqwGZ9X2sO7DUmFoaN1BtcvSI11Bc4nJPHjlmZL4SYdp1/Sp+j/SIolcY
 uQzWTASM0PCQ==
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="397489466"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.83.131])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 10:38:27 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ] cfg: Add check for newly used function in ELL
Date:   Mon,  4 Jan 2021 10:38:13 -0800
Message-Id: <20210104183813.573731-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

ELL has a new dependancy for rawmemchr() which needs to be accounted for
at configure time.
---
 configure.ac | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure.ac b/configure.ac
index d6347c098..6f4096c88 100644
--- a/configure.ac
+++ b/configure.ac
@@ -49,6 +49,8 @@ AC_ARG_ENABLE(threads, AC_HELP_STRING([--enable-threads],
 
 AC_CHECK_FUNCS(explicit_bzero)
 
+AC_CHECK_FUNCS(rawmemchr)
+
 AC_CHECK_FUNC(signalfd, dummy=yes,
 			AC_MSG_ERROR(signalfd support is required))
 
-- 
2.25.4

