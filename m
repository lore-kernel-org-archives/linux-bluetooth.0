Return-Path: <SRS0=39h9=NL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3873ECDE44
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Oct 2018 08:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AF32080A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Oct 2018 08:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AF32080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeJaRMb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Oct 2018 13:12:31 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:59090 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJaRMb (ORCPT
        <rfc822;groupwise-linux-bluetooth@vger.kernel.org:0:0>);
        Wed, 31 Oct 2018 13:12:31 -0400
Received: from linux-vvou.apac.novell.com (unknown.telstraglobal.net [134.159.103.118])
        by smtp.nue.novell.com with ESMTP (NOT encrypted); Wed, 31 Oct 2018 09:15:25 +0100
From:   "Cho, Yu-Chen" <acho@suse.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     acho@suse.com, jlee@suse.com
Subject: [PATCH 3/3 BlueZ] hcidump: Fix set_ext_ctrl() global buffer overflow
Date:   Wed, 31 Oct 2018 16:15:08 +0800
Message-Id: <20181031081508.25927-4-acho@suse.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181031081508.25927-1-acho@suse.com>
References: <20181031081508.25927-1-acho@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix set_ext_ctrl() global buffer overflow.

Signed-off-by: Cho, Yu-Chen <acho@suse.com>
---
 tools/parser/l2cap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/parser/l2cap.c b/tools/parser/l2cap.c
index a05796482..5daefcbaa 100644
--- a/tools/parser/l2cap.c
+++ b/tools/parser/l2cap.c
@@ -56,7 +56,7 @@ typedef struct {
 	uint8_t mode;
 	uint8_t ext_ctrl;
 } cid_info;
-#define CID_TABLE_SIZE 20
+#define CID_TABLE_SIZE 32
 
 static cid_info cid_table[2][CID_TABLE_SIZE];
 
-- 
2.19.1

