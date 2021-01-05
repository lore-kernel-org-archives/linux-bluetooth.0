Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D8EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 03:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 225C422573
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 03:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbhAEDNw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jan 2021 22:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbhAEDNw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jan 2021 22:13:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2255C061796
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jan 2021 19:13:11 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w17so54437542ybl.15
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Jan 2021 19:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=kiatny/Rcuc64s8UOi4ZGZPPONmshKs7gN1XYmzrd+4=;
        b=jo1eR4vPYZMe3ZOptORJvRBF5xJMnOlvUUTU+nPSw3tGe/t1vsxEnudXODbd5Jq111
         eYTLanXBvjdd8pFxCKYn21R61OeCkJXSXo8n9TZBxOPSZkeloCBGwZTG4m3PdtaxUdY2
         SQ9DYVYwPfviurVY1THCg2LXkGnkrsDoaSYoikJvd9Le9o1AdCLPNwXLcy1LE8op4oOo
         iP9APGtWxzGinTPqCc9b5EelOa0dt4MfVbpwj6WXH9NZMvpUHdNmfkSJ79LFjKYOZWGq
         md/cOygS6i5YfXdxH0+hSjXOm2vzBikXSD2mwZ3cmvMEjwSvYnXbJtB7TgLLT7ZizKPP
         TNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kiatny/Rcuc64s8UOi4ZGZPPONmshKs7gN1XYmzrd+4=;
        b=pkwgPIbMUbAfBQosSiTO6lN3KPMt5e4Tx6oDJuw7KldRCmwwqR7ZKDOTitKM8JPciq
         TjvDunrEmIRHOFpXExgvFo7t3O7BnO46H7kHHEfMTlInpsUfcFXSkJT7PLqMUSoNObvH
         gEsFY9LfDFdy7RreOvSR7v4frMI9+lhY7avhYibqqD1C6YY+6UuUhHGfph++jlhk/YzL
         d7Icx/uPowGDLVj68QKAumfvuApU+1MmOswAG5QyS336Ymdbtmce3koUjuUGiFxKWgcB
         sLadbJlaTLyGcGBaIqS38ciwSJqsO0KuRGo2J4YVfVO0VSlH7qmGI8O+0pO30c9CXqMg
         npTA==
X-Gm-Message-State: AOAM530K6THQ7KgcmBH/GtQ4eH8FwDHPAEooWXChjE5Ym5nKI0jbpAxS
        YrpNj3ny92sC6w3cvRpVcQC/TS857cfjK87/i9PIk/DgHX8KdyrMef9b8fYc4zdstqW1dxx7kJV
        /E25DfcgbHgLRwMduC9SOyZJgAZM0JrdVwZPbtmup2no2pyCL69VzUiPOOQUKFzwcfLZ5ZuNTbK
        XE6DWEG0cDh5I=
X-Google-Smtp-Source: ABdhPJxX6CLYQ+8iEUs6Zpd6S0eVqdWTf1WjnEerpfU1r8y8AKGYdjYxzZzP937IYZtGll0mFsVtKA39SNQTd2VrYg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:2c58:: with SMTP id
 s85mr110965846ybs.366.1609816391125; Mon, 04 Jan 2021 19:13:11 -0800 (PST)
Date:   Tue,  5 Jan 2021 11:12:55 +0800
In-Reply-To: <20210105111219.Bluez.v4.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Message-Id: <20210105111219.Bluez.v4.2.I0c07c297925f838138b42674ab244572e6ea361b@changeid>
Mime-Version: 1.0
References: <20210105111219.Bluez.v4.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [Bluez PATCH v4 2/4] btmgmt: Add command read-sysconfig
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        luiz.dentz@gmail.com
Cc:     mcchou@chromium.org, apusaka@chromium.org, mmandlik@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add command read-sysconfig in btmgmt

Example usage:
localhost ~ # btmgmt
[mgmt]# read-sysconfig
Type: 0x0000    Length: 02      Value: 0000
Type: 0x0001    Length: 02      Value: 0008
...
Type: 0x001f    Length: 01      Value: 01

Reviewed-by: apusaka@chromium.org
---

(no changes since v3)

Changes in v3:
- Removed unused variable in read_sysconfig_rsp

 tools/btmgmt.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 2f7cb2efcc38..7d83d3ee6bd5 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1752,6 +1752,52 @@ static void cmd_exp_debug(int argc, char **argv)
 	}
 }
 
+static void print_mgmt_tlv(void *data, void *user_data)
+{
+	const struct mgmt_tlv *entry = data;
+	char buf[256];
+
+	bin2hex(entry->value, entry->length, buf, sizeof(buf));
+	print("Type: 0x%04x\tLength: %02hhu\tValue: %s", entry->type,
+							entry->length, buf);
+}
+
+static void read_sysconfig_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	struct mgmt_tlv_list *tlv_list;
+
+	if (status != 0) {
+		error("Read system configuration failed with status "
+				"0x%02x (%s)", status, mgmt_errstr(status));
+		return;
+	}
+
+	tlv_list = mgmt_tlv_list_load_from_buf(param, len);
+	if (!tlv_list) {
+		error("Unable to parse response of read system configuration");
+		return;
+	}
+
+	mgmt_tlv_list_foreach(tlv_list, print_mgmt_tlv, NULL);
+	mgmt_tlv_list_free(tlv_list);
+}
+
+static void cmd_read_sysconfig(int argc, char **argv)
+{
+	uint16_t index;
+
+	index = mgmt_index;
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	if (!mgmt_send(mgmt, MGMT_OP_READ_DEF_SYSTEM_CONFIG, index,
+			0, NULL, read_sysconfig_rsp, NULL, NULL)) {
+		error("Unable to send read system configuration cmd");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static void auto_power_enable_rsp(uint8_t status, uint16_t len,
 					const void *param, void *user_data)
 {
@@ -5030,6 +5076,8 @@ static const struct bt_shell_menu main_menu = {
 		cmd_expinfo,		"Show experimental features"	},
 	{ "exp-debug",		"<on/off>",
 		cmd_exp_debug,		"Set debug feature"		},
+	{ "read-sysconfig",	NULL,
+		cmd_read_sysconfig,	"Read System Configuration"	},
 	{} },
 };
 
-- 
2.29.2.729.g45daf8777d-goog

