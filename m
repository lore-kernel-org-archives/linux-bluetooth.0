Return-Path: <SRS0=Tr5+=S2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F540C10F11
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 09:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631FD20656
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 09:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfDXJQ2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:16:28 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:48227 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfDXJQ1 (ORCPT
        <rfc822;groupwise-linux-bluetooth@vger.kernel.org:0:0>);
        Wed, 24 Apr 2019 05:16:27 -0400
Received: from linux-vvou.suse.de (unknown.telstraglobal.net [202.47.205.198])
        by smtp.nue.novell.com with ESMTP (NOT encrypted); Wed, 24 Apr 2019 11:16:24 +0200
From:   "Cho, Yu-Chen" <acho@suse.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     acho@suse.com, jlee@suse.com
Subject: [PATCH BlueZ] tool/hcidump: Fix memory leak with malformed packet
Date:   Wed, 24 Apr 2019 17:16:15 +0800
Message-Id: <20190424091615.8518-1-acho@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Do not allow to read more than allocated data buffer size.
Because of the buffer is malloc(HCI_MAX_FRAME_SIZE),
so there is heap buffer overflow if read the size more than
HCI_MAX_FRAME_SIZE and fd size is larger than HCI_MAX_FRAME_SIZE.
---
 tools/hcidump.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/hcidump.c b/tools/hcidump.c
index 33d429b6c..6cc55404d 100644
--- a/tools/hcidump.c
+++ b/tools/hcidump.c
@@ -105,6 +105,15 @@ struct pktlog_hdr {
 static inline int read_n(int fd, char *buf, int len)
 {
 	int t = 0, w;
+	off_t fsize, currentpos, startpos;
+
+	currentpos = lseek(fd, 0, SEEK_CUR);
+	fsize = lseek(fd, 0, SEEK_END);
+	lseek(fd, currentpos, SEEK_SET);
+	fsize -= currentpos;
+
+	if (fsize > HCI_MAX_FRAME_SIZE && len > HCI_MAX_FRAME_SIZE)
+		return -1;
 
 	while (len > 0) {
 		if ((w = read(fd, buf, len)) < 0) {
-- 
2.21.0

