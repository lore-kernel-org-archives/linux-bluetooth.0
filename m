Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC98C43460
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 18:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32ABF613B8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 18:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347527AbhDMSE7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Apr 2021 14:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347524AbhDMSE4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Apr 2021 14:04:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8DDC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 11:04:32 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id b28so510708pft.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HrePWV0Aq7cpeDBpXaSMt0pGor2tHf9dczL2I/+wcuA=;
        b=tuTbEToxVFUHgFZS0BWCidbD0hXqmL33r2kj2Zu2eybu3cWtHSDj5CFGCDfBTuxP/R
         Dl0sA3Vayr/PJi4fdCTvPnCkdc/xpmGN5/9eihNPY0mMnYyufLM/hW98Pc6orSQaZVTx
         uxznA9N4YvAO9Wev/sRFUbsZoVRMoxmTtISG1jH1CpbWgSB22CjhQeEPTd0Ttmad7TUB
         FROSxl9s4Lg3o209sB+gNUvotYa7M5f+0ZkJT85/IZ+rxkK9aLons7gLT41fW838Vto7
         UgBO6h4AH55sa66VwKVvZXxaglotLZwRrg5sCOQBODSB8/7fMH9Oo7x9x0Vl5gsA6/VV
         TG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HrePWV0Aq7cpeDBpXaSMt0pGor2tHf9dczL2I/+wcuA=;
        b=UvFmlaa+8H6tnVO8k8vMOQXcGhArWOXQW6EFO6dXg3Mr5lBbOHcJv/3V9KWLWvVXmi
         yEDgT/qBOyjo6aMj/Vtke0Y2+r7UZEq1+yE6MyyTuNkPKmnY/Jwtt8xl9Sx+qEnmmLYu
         kysGAOynouSUofFF9rB6g9k6I9ryyj6amhYn8IRdEUq7g9b8FUjhgbfYyawO+QZI8R4k
         IojSLldX3DLUEhmpgxpl4B8m0g8D6oL/6AHribsUWUurUCOwyJbPaXpEVuwU0aiy2+PA
         EmSmYu+bu9OTEzkvDL6Yxzmd4u2k42CEe2WDFQoizn226nEHRah1y/SmstKqULsFKxP7
         mQ4Q==
X-Gm-Message-State: AOAM533NdOEWiapFTL05VqZComDB55l2AYUU+G58zjt8WfYjXF7nXcND
        7t/Fw5XbLTYSQvNNLvCwHiFBUM9z05k=
X-Google-Smtp-Source: ABdhPJxvtUPbivlE5G9REhKCgvju1uWWk48Tmlf1qVqiHOxa+MLu+dMzgyf2fRySrFt8TZN1UivXxQ==
X-Received: by 2002:aa7:88c6:0:b029:250:bf78:a4a3 with SMTP id k6-20020aa788c60000b0290250bf78a4a3mr3815506pff.70.1618337071893;
        Tue, 13 Apr 2021 11:04:31 -0700 (PDT)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:d830:a8b:3cf9:40aa:b8f8])
        by smtp.gmail.com with ESMTPSA id jx20sm2827842pjb.41.2021.04.13.11.04.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 11:04:31 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] monitor: Add control packet count to analyze command
Date:   Tue, 13 Apr 2021 11:04:29 -0700
Message-Id: <20210413180430.356676-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds control packets(open, close, command, event) count to
analyze command.
---
 monitor/analyze.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 784f9a0a4..022761c21 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -37,6 +37,10 @@ struct hci_dev {
 	unsigned long vendor_diag;
 	unsigned long system_note;
 	unsigned long user_log;
+	unsigned long ctrl_open;
+	unsigned long ctrl_close;
+	unsigned long ctrl_cmd;
+	unsigned long ctrl_evt;
 	unsigned long unknown;
 	uint16_t manufacturer;
 };
@@ -76,6 +80,10 @@ static void dev_destroy(void *data)
 	printf("  %lu vendor diagnostics\n", dev->vendor_diag);
 	printf("  %lu system notes\n", dev->system_note);
 	printf("  %lu user logs\n", dev->user_log);
+	printf("  %lu control open\n", dev->ctrl_open);
+	printf("  %lu control close\n", dev->ctrl_close);
+	printf("  %lu control commands\n", dev->ctrl_cmd);
+	printf("  %lu control events\n", dev->ctrl_evt);
 	printf("  %lu unknown opcodes\n", dev->unknown);
 	printf("\n");
 
@@ -299,6 +307,54 @@ static void user_log(struct timeval *tv, uint16_t index,
 	dev->user_log++;
 }
 
+static void ctrl_open(struct timeval *tv, uint16_t index,
+					const void *data, uint16_t size)
+{
+	struct hci_dev *dev;
+
+	dev = dev_lookup(index);
+	if (!dev)
+		return;
+
+	dev->ctrl_open++;
+}
+
+static void ctrl_close(struct timeval *tv, uint16_t index,
+					const void *data, uint16_t size)
+{
+	struct hci_dev *dev;
+
+	dev = dev_lookup(index);
+	if (!dev)
+		return;
+
+	dev->ctrl_close++;
+}
+
+static void ctrl_cmd(struct timeval *tv, uint16_t index,
+					const void *data, uint16_t size)
+{
+	struct hci_dev *dev;
+
+	dev = dev_lookup(index);
+	if (!dev)
+		return;
+
+	dev->ctrl_cmd++;
+}
+
+static void ctrl_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint16_t size)
+{
+	struct hci_dev *dev;
+
+	dev = dev_lookup(index);
+	if (!dev)
+		return;
+
+	dev->ctrl_evt++;
+}
+
 static void unknown_opcode(struct timeval *tv, uint16_t index,
 					const void *data, uint16_t size)
 {
@@ -380,6 +436,18 @@ void analyze_trace(const char *path)
 		case BTSNOOP_OPCODE_USER_LOGGING:
 			user_log(&tv, index, buf, pktlen);
 			break;
+		case BTSNOOP_OPCODE_CTRL_OPEN:
+			ctrl_open(&tv, index, buf, pktlen);
+			break;
+		case BTSNOOP_OPCODE_CTRL_CLOSE:
+			ctrl_close(&tv, index, buf, pktlen);
+			break;
+		case BTSNOOP_OPCODE_CTRL_COMMAND:
+			ctrl_cmd(&tv, index, buf, pktlen);
+			break;
+		case BTSNOOP_OPCODE_CTRL_EVENT:
+			ctrl_evt(&tv, index, buf, pktlen);
+			break;
 		default:
 			fprintf(stderr, "Unknown opcode %u\n", opcode);
 			unknown_opcode(&tv, index, buf, pktlen);
-- 
2.25.1

