Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208F0C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 20:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0328960E8B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 20:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhJYUdv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbhJYUdr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 16:33:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5ECC061767
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 13:31:24 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v1-20020a17090a088100b001a21156830bso363899pjc.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 13:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uRci+wXRHEpx0vPCJHP4/3h6ULOKax09k+gEH+0a86A=;
        b=i2WbMFErQMbUljbsAR6hgwtPwzo6aPnP7/GLCuInIBEIwp4ABZBDwwi0mw8S2r/SZq
         NZaTjoSSFAJ6ofkn1FV0xfFk86LaXXs3e5PCaamVCwKUeW+HO2XrOrghdu677zWBL1t2
         XYLa9Q3TnW37FQ+g0R0/VVkiomZIJ1P4THEHvn/qIHuZWVfQ4r+SRyv3PAMwZ7I3llv5
         Ltp59xaF13H66JHsuirA/AgkhkSVKeYtNfmhqiiYPzp2UufqTiXYYyj0nARCzTFBNkOl
         1euetpJ0692ub4unf9X9QSo3hPf1CQgnt5e6LDnJdvllJs4qW2gC9tabGbc2+lrZvP7i
         9hRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uRci+wXRHEpx0vPCJHP4/3h6ULOKax09k+gEH+0a86A=;
        b=ZTcUN72HNCDC+lX1wZGfB/zvFJ4Suq1F+MSUB9W6APCWtHQf3LE5r7H0mM/ByhnC64
         y/GQ+5v/5N5y0aXIpTM9HV7ok+ZopW/h9za/8U/gNof9i17fjEWyKUI42FKuFUqhHY4Z
         UcZ9vclG7QZdLOwlXrB8RMq7tWzfqw+sffj/c2QyZhz2o7884/1VHlL2W1exNk6AFiJL
         pgdtL5gbX887S3GEm16qLEpdGIb35H9xrqUDQxVwQtfI7z7EVHmAvtR895IjJvgz1VHf
         nx+NWDH0qObch6JfDLo6kPfBlf5xVRCyXLCGKIoRKAYnhTmoqhPbfGsEwHGibGuRoyUO
         VELQ==
X-Gm-Message-State: AOAM533UfUTjUwrnunHc7fFIBU8QRkr+X3D217iMeqcJtqIW5JO+CdXe
        pWgEg02YG7EmnvWwDJ8E/961U7b3UX6cyg==
X-Google-Smtp-Source: ABdhPJwXdoohTeGwk4XPvNUXEbncOej9b/dG5EOIlEvjqIacdvIxp9YGP4WPnLLLS+0J9qn9oUzgBw==
X-Received: by 2002:a17:902:f550:b0:140:54d5:78bb with SMTP id h16-20020a170902f55000b0014054d578bbmr8109683plf.76.1635193883709;
        Mon, 25 Oct 2021 13:31:23 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:78ab:b967:528:d348])
        by smtp.gmail.com with ESMTPSA id l12sm21504899pfu.100.2021.10.25.13.31.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 13:31:23 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 4/4] tools/mgmt-tester: Add support for experimental feature in setup
Date:   Mon, 25 Oct 2021 13:31:20 -0700
Message-Id: <20211025203120.513189-4-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025203120.513189-1-hj.tedd.an@gmail.com>
References: <20211025203120.513189-1-hj.tedd.an@gmail.com>
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

