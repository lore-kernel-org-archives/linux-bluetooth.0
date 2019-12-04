Return-Path: <SRS0=DiUs=Z2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47E3C43603
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Dec 2019 19:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFED2073C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Dec 2019 19:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfLDTPU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:15:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:53226 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbfLDTPU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Dec 2019 14:15:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 11:15:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,278,1571727600"; 
   d="scan'208";a="385868433"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.44.42])
  by orsmga005.jf.intel.com with ESMTP; 04 Dec 2019 11:15:19 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ] build: Include dependancies for ell/settings.[ch]
Date:   Wed,  4 Dec 2019 11:15:16 -0800
Message-Id: <20191204191516.13178-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Including settings.[ch] in a build requires the following chained
dependancies:
PEM
CERT
KEY
PKSC5
BASE64
---
 Makefile.am | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 8d419fb30..836a4fcd2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -121,12 +121,22 @@ ell_headers = ell/util.h \
 			ell/io.h \
 			ell/idle.h \
 			ell/main.h \
+			ell/settings.h \
 			ell/strv.h \
 			ell/string.h \
 			ell/utf8.h \
 			ell/dbus.h \
 			ell/dbus-service.h \
-			ell/dbus-client.h
+			ell/dbus-client.h \
+			ell/key.h \
+			ell/cert.h \
+			ell/pem.h \
+			ell/base64.h \
+			ell/pkcs5.h \
+			ell/asn1-private.h \
+			ell/pkcs5-private.h \
+			ell/cert-private.h \
+			ell/pem-private.h
 
 ell_sources = ell/private.h ell/missing.h \
 			ell/util.c \
@@ -139,10 +149,16 @@ ell_sources = ell/private.h ell/missing.h \
 			ell/io.c \
 			ell/idle.c \
 			ell/main.c \
+			ell/settings.c \
 			ell/strv.c \
 			ell/string.c \
 			ell/cipher.c \
 			ell/checksum.c \
+			ell/pem.c \
+			ell/cert.c \
+			ell/key.c \
+			ell/pkcs5.c \
+			ell/base64.c \
 			ell/utf8.c \
 			ell/dbus-private.h \
 			ell/dbus.c \
-- 
2.21.0

