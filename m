Return-Path: <SRS0=39h9=NL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FBEC0044C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Oct 2018 08:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990552080A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Oct 2018 08:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990552080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeJaRM3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Oct 2018 13:12:29 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:39240 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJaRM3 (ORCPT
        <rfc822;groupwise-linux-bluetooth@vger.kernel.org:0:0>);
        Wed, 31 Oct 2018 13:12:29 -0400
Received: from linux-vvou.apac.novell.com (unknown.telstraglobal.net [134.159.103.118])
        by smtp.nue.novell.com with ESMTP (NOT encrypted); Wed, 31 Oct 2018 09:15:23 +0100
From:   "Cho, Yu-Chen" <acho@suse.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     acho@suse.com, jlee@suse.com
Subject: [PATCH 2/3 BlueZ] hcidump:fixed hci frame dump stack-buffer-overflow
Date:   Wed, 31 Oct 2018 16:15:07 +0800
Message-Id: <20181031081508.25927-3-acho@suse.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181031081508.25927-1-acho@suse.com>
References: <20181031081508.25927-1-acho@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hci_dump() didn't check the length of frame, and it would be
a stack-buffer-overflow error.

Signed-off-by: Cho, Yu-Chen <acho@suse.com>
---
 tools/parser/hci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index 8c7bd2581..4e6c36040 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -4107,6 +4107,9 @@ void hci_dump(int level, struct frame *frm)
 
 	frm->ptr++; frm->len--;
 
+	if (frm->len == 0)
+		return;
+
 	switch (type) {
 	case HCI_COMMAND_PKT:
 		command_dump(level, frm);
-- 
2.19.1

