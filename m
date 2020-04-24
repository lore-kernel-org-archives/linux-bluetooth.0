Return-Path: <SRS0=/Nrl=6I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DFCC55191
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Apr 2020 23:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D7E2084D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Apr 2020 23:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgDXXKe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Apr 2020 19:10:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:34900 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgDXXKe (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Apr 2020 19:10:34 -0400
IronPort-SDR: MDjOngC4nZPdjrz5PJxmTjvk/Joqx3Iy9n/BcIuj7woKqAIO5NI1PU3c8W7hsq5oMPwGIXS/sH
 7D9QxLkyACDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 16:10:33 -0700
IronPort-SDR: esxjEnu28JKE7h9DOPR9Fgw8zeZQI9oyFowdaTfsxTXqYmxiOI+kOVAnigu8MdgH5XTAosJGEg
 36yZyWzlEnnQ==
X-IronPort-AV: E=Sophos;i="5.73,313,1583222400"; 
   d="scan'208";a="458087386"
Received: from han1-mobl3.jf.intel.com ([10.54.74.15])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 16:10:32 -0700
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Subject: [PATCH 1/3] Test patch #1: LONG_LINE_COMMENT
Date:   Fri, 24 Apr 2020 16:10:24 -0700
Message-Id: <20200424231026.127164-1-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DO NOT MERGE

Test patch #1
---
 tools/btpclient.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index f9c693056..aa8a2bae4 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -3160,6 +3160,8 @@ int main(int argc, char *argv[])
 
 	l_log_set_stderr();
 
+	/* This is a test comment to test checkpatch.pl for long line over 80 column line */
+
 	while ((opt = getopt_long(argc, argv, "+hs:vq", options, NULL)) != -1) {
 		switch (opt) {
 		case 's':
-- 
2.25.3

