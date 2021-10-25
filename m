Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A082DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 04:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C68460F4F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 04:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhJYEty (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 00:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhJYEtw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 00:49:52 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83197C061764
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Oct 2021 21:47:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m26so9560746pff.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Oct 2021 21:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uRci+wXRHEpx0vPCJHP4/3h6ULOKax09k+gEH+0a86A=;
        b=QOFOy0IjA9Sq3eD8YgLGL3mXYluje0Tkpd6U/6sQHdkkiTKxwPbnLcP2ChzUQE/KKP
         RwyofBxlX5vNrbPJlRFcNuvWLzoql3DAMNfqxZoLKyg1sOfm+LGPpoT0hvMsPDGFCrc7
         kwlxrqSX8megxFDlG+E2S8dkLFnvGCGUaWo/jvMC1D3ELC5NlZbcUY539JkHjWQBEhrn
         aVCKUstirXExyQxqgqXfJBpVWLRZ7Kc7UXuVRqP4vDXtG8Eq0+RM0KEwaOMgQx7M+2YR
         sw+i1OK8wl5rcdHcHNHjJU7JxhchSV4K3eJK1azouaWS7+ILzQaHrXFLBrjuQOCqJBpo
         tbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uRci+wXRHEpx0vPCJHP4/3h6ULOKax09k+gEH+0a86A=;
        b=CdvhLgaXKwAvh74SlmGVdqRqESkHNcBPR9yYCBipYACgY8PdrTVhpJwQC+uop5k31O
         vA8xME3jumvLtNG4cUqm+t4+0pxi2vM0TBmjNWMDh1iNVBkVthY1aIGGyxS0FhgnFUDW
         T4ikKUsxWU7CanveWyROFZimhymX2mCAdr1mZ/+qtGyAKIwznEXa14S7N6rWluNJu5Vu
         AnRzxva9zP86L+si2SttvTHpa+cpj4En/ScHnIj9v0xMvBMROtWMCyYWZwW9c+h6QdQT
         4LjYBTFblfuEpf8R69mseaJAyaZOvd47SWjym/WOBp/gLfDwY5ANHWPRHGA7d9DwvkyO
         s83g==
X-Gm-Message-State: AOAM530z6YfPjc249DOH/ioz8eQDZdF6Eg3RR+5OVnPGOAtUWW6xmY5+
        9F4rDz7vMAZxUX+FnnWQes4YQSLI9TaHAA==
X-Google-Smtp-Source: ABdhPJzj745ANWVlwB5eJxV605gkSwsYsDIxj5wxVLhGvMOTZWL4yvjCbZ2XlJEh7IOn3rSD9kxDtg==
X-Received: by 2002:aa7:99c3:0:b0:47b:e21d:7315 with SMTP id v3-20020aa799c3000000b0047be21d7315mr8567950pfi.35.1635137249817;
        Sun, 24 Oct 2021 21:47:29 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:d228:1bef:af2a:db8e])
        by smtp.gmail.com with ESMTPSA id a17sm13926204pfv.64.2021.10.24.21.47.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 21:47:29 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 4/4] tools/mgmt-tester: Add support for experimental feature in setup
Date:   Sun, 24 Oct 2021 21:47:25 -0700
Message-Id: <20211025044725.482641-4-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025044725.482641-1-hj.tedd.an@gmail.com>
References: <20211025044725.482641-1-hj.tedd.an@gmail.com>
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

