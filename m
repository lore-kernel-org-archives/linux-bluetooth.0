Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05684C433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 11:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF535229C5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 11:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgL1LfL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbgL1LfK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 06:35:10 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB3DC061795
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 03:34:30 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w8so17901023ybj.14
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 03:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BOm5gEp4j3FyKr6ZvMW0OV+Cysy570CCnAgSDPu/Tro=;
        b=jhdiNwODOertvzE6In7+J1WQa/6nUtMnWw+V8kFDHvIm5wKSm/JxaUmB5wDfA2km6R
         ker0W1SMJgMovET/PZ5UewyqfqmvmYCf0J/f+rZzpIrFlWyF2vtgu1uGsANGMYAqDcjv
         ztpUI0zJc+mv441ar9/Kf9YVr7LCiW14mMs/oHr68LPQ6SMmynpWezIAYUlbk7gEicUd
         1sXevHSpR8ZgwOAw3zelqDyXqqhocUJnAnM0Ox6ZrwiVDGvN5zfIPDyNOTDLqFp2e32B
         xUbPmeR4L5DvTrLZnS3twZY+3r6mXA+AzL3el7rMlEvbLqDULkLEXsP9e/DIFThKKlim
         CSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BOm5gEp4j3FyKr6ZvMW0OV+Cysy570CCnAgSDPu/Tro=;
        b=hK7DXS7URdsOx5B046v6WLH3NaoA8vqobGRfSX7TbutUppvtMHDIfmkMVyenpW7vA8
         pU+dpeXuOahyDcJVlf58In42OZVQ1B/XRNRjafvpguGeFEo5gQnvZMmKZuE2Oml0WuLd
         R8AGryDk6L93L460S+X/zI4rYXXkNFmffAQQ873myQMuAkGoQmZb/79kRewM6A7RJUN2
         m38HCCgI8lvb20VQnKmIIQxx04zbzswzoNcszYAayYThDOJXMrOqz/kCz2QIKCWNRjTB
         JINddkRa2pDEXaFNDTTLNbI0C7gGSpv74SDKC/n15TQufDCoszQhk5X9MwsHX3VbGxNy
         /vnQ==
X-Gm-Message-State: AOAM532TJK9N19TDY6OtBFP36ZJFj8jZM9IdT6VjpOJn/BIxGRTD6UKg
        PtsIRsHVae78Azscb2ZECXcfkgkyGDKpn8nNz5aXXB1hTCsZVxK9mYoxqYeZE/eFhnK1fZzaox1
        ZrA4Cjj9oBm9maqTFUxXzd3xcGxD/X57XSIeErjYL4nuu9jBzZ3kRWj+ypDuGMt4+6hVtd4n0AO
        hm6hMXgDUQEXA=
X-Google-Smtp-Source: ABdhPJyjFA654Q02vGiZnkfsZvIeihVbeGAk94A6ZQCHLgXv5RIw9MIxGluqvSjSPeQRP1kGIjNyoSIaybXge74orA==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:ba08:: with SMTP id
 t8mr11057795ybg.316.1609155269239; Mon, 28 Dec 2020 03:34:29 -0800 (PST)
Date:   Mon, 28 Dec 2020 19:34:18 +0800
In-Reply-To: <20201228193351.Bluez.v3.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Message-Id: <20201228193351.Bluez.v3.2.I0c07c297925f838138b42674ab244572e6ea361b@changeid>
Mime-Version: 1.0
References: <20201228193351.Bluez.v3.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [Bluez PATCH v3 2/4] btmgmt: Add command read-sysconfig
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        luiz.dentz@gmail.com
Cc:     mcchou@chromium.org, mmandlik@chromium.org, apusaka@chromium.org,
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

