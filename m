Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323CCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 20:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C88160F02
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 20:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhJVUuu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Oct 2021 16:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbhJVUut (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Oct 2021 16:50:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BFBC061764
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Oct 2021 13:48:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x1-20020a17090a530100b001a1efa4ebe6so1638452pjh.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Oct 2021 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uRci+wXRHEpx0vPCJHP4/3h6ULOKax09k+gEH+0a86A=;
        b=aWO29QxiFRbeGQ08a4BCn404MsZE/cUo3jQ0IiRHEtqAn1Y6qC2hlxtIC/1qwd31SL
         At1wA9iMa2We2Od5/U/64WUiy0YDBLOPn915hIjPpokQdfyKyRmcmZuc2nN60fSUUg3p
         PasN0jDSbjlPP2P4wnTAcesNFo1sdbiDU2V8CipotM1GTIAHP8oCwBzl+2mq9VyxM3CV
         j2n2UjSUjm4Vbhzv9YaHzv6lhPbUAR0zIKA7Yy5eq+PaV1rbS4CjpeIMiS0dF6T0cXwa
         f0jAXIJnQAAUWDkWHoQF2A6OC1QQb3eulbgytgMxeVqV/qj7DvQsaSh1YxdJxwrhmBpi
         iOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uRci+wXRHEpx0vPCJHP4/3h6ULOKax09k+gEH+0a86A=;
        b=LmM8dmqhP6aoW24HqwH/P0wB6JKY56ZeNhFMw8qGMJ/ciWBhCqZyvJilaVa41PnuZ0
         3J/tcKk2uS/dyKC9zbDF8Wr0QHnbuJNcJ3DuCHru23ZC+2Q8tJEBuS3TVeX3B1LWYBzm
         C7PfGCeIoqVUuvLpUyF9SA46ndSdqlcMlPx3N1ZTRHKty+05Ol8yLQb/vJ+JTDVntOTi
         Sz+x+pQlx2kVuDAmTObQYBrsCZuePgs2YHp5BMjFhA/hN80kUiP0cVjFogbVkCnlvo9L
         o/qUxXGyC6aFeXMWOG+wKvVl5gD1ASUvhQy6LQsD/gNUE42LN0aaVBHunn3MgbOsrU5o
         75gw==
X-Gm-Message-State: AOAM532Fup4yJFXgIuS7U4IQge9ox2F8g3Xhao3JPF5i2pOKVbfUArX8
        bBUh45oAN0VNyI0q6NSFMv6FQ6Yh+5Cl9Q==
X-Google-Smtp-Source: ABdhPJzfXcFJmi3B4qTfSOVYip0HxD5ysWSJR/KQn6Py9rd1qKRC8ZTTADKO7SF5bI/bvG8AwG9LEQ==
X-Received: by 2002:a17:90a:49:: with SMTP id 9mr17284405pjb.80.1634935710874;
        Fri, 22 Oct 2021 13:48:30 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:6966:f5b2:62ac:cf35])
        by smtp.gmail.com with ESMTPSA id z19sm10285654pfj.156.2021.10.22.13.48.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 13:48:30 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v14 4/5] tools/mgmt-tester: Add support for experimental feature in setup
Date:   Fri, 22 Oct 2021 13:48:24 -0700
Message-Id: <20211022204825.397952-4-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211022204825.397952-1-hj.tedd.an@gmail.com>
References: <20211022204825.397952-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds support for experimental feature in setup_settings
options.
---
 tools/mgmt-tester.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index f490dc261..1ccce0ad6 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -260,6 +260,7 @@ struct generic_data {
 	const uint16_t *setup_settings;
 	bool setup_nobredr;
 	bool setup_limited_discov;
+	const void *setup_exp_feat_param;
 	uint16_t setup_expect_hci_command;
 	const void *setup_expect_hci_param;
 	uint8_t setup_expect_hci_len;
@@ -7222,6 +7223,7 @@ proceed:
 		unsigned char privacy_param[] = { 0x01,
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
+		unsigned char set_exp_feat_param[17] = { 0x00 };
 		unsigned char *param = simple_param;
 		size_t param_size = sizeof(simple_param);
 		mgmt_request_func_t func = NULL;
@@ -7250,14 +7252,30 @@ proceed:
 				memcpy(param, test->setup_discovery_param, 1);
 		}
 
+		if (*cmd == MGMT_OP_SET_EXP_FEATURE) {
+			if (test->setup_exp_feat_param) {
+				memcpy(set_exp_feat_param,
+				       test->setup_exp_feat_param, 17);
+				param_size = sizeof(set_exp_feat_param);
+				param = set_exp_feat_param;
+			}
+		}
+
 		if (*cmd == MGMT_OP_SET_LE && test->setup_nobredr) {
 			unsigned char off[] = { 0x00 };
+			tester_print("Setup sending %s (0x%04x)",
+							mgmt_opstr(*cmd), *cmd);
 			mgmt_send(data->mgmt, *cmd, data->mgmt_index,
 					param_size, param, NULL, NULL, NULL);
+			tester_print("Setup sending %s (0x%04x)",
+					mgmt_opstr(MGMT_OP_SET_BREDR),
+					MGMT_OP_SET_BREDR);
 			mgmt_send(data->mgmt, MGMT_OP_SET_BREDR,
 					data->mgmt_index, sizeof(off), off,
 					func, data, NULL);
 		} else {
+			tester_print("Setup sending %s (0x%04x)",
+							mgmt_opstr(*cmd), *cmd);
 			mgmt_send(data->mgmt, *cmd, data->mgmt_index,
 					param_size, param, func, data, NULL);
 		}
-- 
2.25.1

