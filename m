Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCF0C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 21:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70DC323A50
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 21:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbhANVOS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jan 2021 16:14:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:63193 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbhANVOR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jan 2021 16:14:17 -0500
IronPort-SDR: dj/5kdD0Ekl2EbfBqxI++rhKJlVOM1N0Uui7JoFI7alsK5fb2IPpGpBCTyNUBahd4QO0u7SPTW
 wkCxRAY3sErw==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="157624952"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="157624952"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 13:13:36 -0800
IronPort-SDR: gBUaHoHx6wNS7+At87otAs8McICvwvF+nymdoqG+r0O4QbL5MLGgtOTLqkqvT4gHFFaIdM/hRJ
 yS8wETZWYptA==
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="465374282"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.209.125.143])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 13:13:33 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, marcel@holtmann.org,
        Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ] ELL: Uprev the ELL file list to version Rel 0.36
Date:   Thu, 14 Jan 2021 13:13:22 -0800
Message-Id: <20210114211322.328712-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This has no functional change.  It simply changes the ELL file list used
for the staticly linked version of ELL into BlueZ executables.
---
 Makefile.am | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 95917f695..83ac36485 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -134,7 +134,6 @@ ell_headers = ell/util.h \
 			ell/base64.h \
 			ell/pkcs5.h \
 			ell/asn1-private.h \
-			ell/pkcs5-private.h \
 			ell/cert-private.h \
 			ell/pem-private.h
 
@@ -156,8 +155,8 @@ ell_sources = ell/private.h ell/missing.h \
 			ell/checksum.c \
 			ell/pem.c \
 			ell/cert.c \
+			ell/cert-crypto.c \
 			ell/key.c \
-			ell/pkcs5.c \
 			ell/base64.c \
 			ell/utf8.c \
 			ell/dbus-private.h \
-- 
2.25.4

