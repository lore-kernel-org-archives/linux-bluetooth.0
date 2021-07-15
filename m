Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E83C1B08C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 09:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A25611AB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 09:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbhGOJx2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Jul 2021 05:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239035AbhGOJx2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Jul 2021 05:53:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C53C06175F
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jul 2021 02:50:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p17so2925717plf.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jul 2021 02:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xfqLpBRAhwGbEOemZM2Ho66ytu0wUstTyKrcFOOpnNM=;
        b=hVaJ6Cqep/KOOUV7tsJQ1TxWVbLu4svtplBp9V8zJzo+p3rF3UO+MSDgPuhh3vEHLL
         2o8GKIGFMIZvoGTbVgenii/Pmmn33quXwwhNKVM1iBtjh1zonXdo+kTmJr0QIUjYdQQo
         oGiTV/s6QL2NXqW3fzLpSTjnpKOxV+YvlPsdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xfqLpBRAhwGbEOemZM2Ho66ytu0wUstTyKrcFOOpnNM=;
        b=SfuVKBfKhQOenXDFDjSevAJ5M69VwnfWJ7H4K2hQM6lPZmgnbHzYa752XuzdlWN0Ma
         usal8algKpCSdV0Sxry9atOxgssE4XvKTaBG2ucu10OUkxUa4MJm3Sv+uWy0SE/o6vqD
         g26G23C8pyTRijMzdGVTKZUB1+EVrmUQHIVCzmQtl21kQ82chxG22AcKS38b36XDz0SE
         ZtQiqdJ0DIDC0Eu4OIBbWft5N1iyuTj0KsSipqSPOZBPcAIk3NAoBXYhJ2n5/3EfKCV9
         zqoUHtMbAdqwmmk6w0Y9MEK/Bvq3HUwf5ta72wpfWlf1DV9RDSuw4XanohJOBQwrugbF
         eG2w==
X-Gm-Message-State: AOAM533Ytm9hc4LGgs/4dtLH80rIIwmasE9JuTBfcLbzcdsyOIz1PDQt
        8aL5zJKrZZosh6sUBqrBD/7JYz3HiBSbqw==
X-Google-Smtp-Source: ABdhPJxueAEuM0Z6RWzk909yCLuZcEU6HXOmmahIA/DvEsWWPtihD3ikMR2aK3TmKsRmgBYBXMhS9w==
X-Received: by 2002:a17:90a:688f:: with SMTP id a15mr3615141pjd.84.1626342634951;
        Thu, 15 Jul 2021 02:50:34 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:5e6b:4f03:a90f:28af])
        by smtp.gmail.com with ESMTPSA id e18sm5892160pfc.85.2021.07.15.02.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 02:50:34 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v6 3/3] tools: btmgmt: support bqr experiment feature command
Date:   Thu, 15 Jul 2021 17:50:18 +0800
Message-Id: <20210715174945.BlueZ.v6.3.I6dc7f0bfe78347213063ff6bd4031daf9b5da43c@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210715174945.BlueZ.v6.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
References: <20210715174945.BlueZ.v6.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the "exp-bqr" command to btmgmt to enable/disable
the Bluetooth quality report (BQR).

---

Changes in v6:
- Remove the patch that adds btd_adapter_update_kernel_quality_report()
  since no upstream code uses it per the previous review comment.
- Add this new patch to support the "exp-bqr" command in btmgmt to
  enable/disable the Bluetooth quality report (BQR). This support is
  to be consistent with other experimental features.
- Note that the bqr experimental feature is designed in the way that
  it can be enabled/disabled at run time instead of at bluez daemon
  launch time. And the default is to disable it in order to avoid the
  overhead on the controller. Hence, it is not enabled through
  btd_opts.experimental like what rpa_resolution_func() does.

 tools/btmgmt.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index a6ac026dc..997af70bf 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1842,6 +1842,52 @@ static void cmd_exp_privacy(int argc, char **argv)
 	}
 }
 
+static void exp_bqr_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	if (status != 0)
+		error("Set BQR feature failed with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+	else
+		print("BQR feature successfully set");
+
+	bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_exp_bqr(int argc, char **argv)
+{
+	/* 330859bc-7506-492d-9370-9a6f0614037f */
+	static const uint8_t uuid[16] = {
+				0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a, 0x70, 0x93,
+				0x2d, 0x49, 0x06, 0x75, 0xbc, 0x59, 0x08, 0x33,
+	};
+	struct mgmt_cp_set_exp_feature cp;
+	uint8_t val;
+
+	if (mgmt_index == MGMT_INDEX_NONE) {
+		error("BQR feature requires a valid controller index");
+		return;
+	}
+
+	if (parse_setting(argc, argv, &val) == false)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	if (val != 0 && val != 1) {
+		error("Invalid value %u", val);
+		return;
+	}
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(cp.uuid, uuid, 16);
+	cp.action = val;
+
+	if (mgmt_send(mgmt, MGMT_OP_SET_EXP_FEATURE, mgmt_index,
+			sizeof(cp), &cp, exp_bqr_rsp, NULL, NULL) == 0) {
+		error("Unable to send BQR feature cmd");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static void print_mgmt_tlv(void *data, void *user_data)
 {
 	const struct mgmt_tlv *entry = data;
@@ -5547,6 +5593,8 @@ static const struct bt_shell_menu main_menu = {
 		cmd_exp_debug,		"Set debug feature"		},
 	{ "exp-privacy",	"<on/off>",
 		cmd_exp_privacy,	"Set LL privacy feature"	},
+	{ "exp-bqr",		"<on/off>", cmd_exp_bqr,
+		"Set bluetooth quality report feature"			},
 	{ "read-sysconfig",	NULL,
 		cmd_read_sysconfig,	"Read System Configuration"	},
 	{ "set-sysconfig",	"<-v|-h> [options...]",
-- 
2.32.0.93.g670b81a890-goog

