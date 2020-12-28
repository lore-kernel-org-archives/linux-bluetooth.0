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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11C7C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 06:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71447207C9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 06:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgL1GrM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 01:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgL1GrM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 01:47:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FC9C061795
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Dec 2020 22:46:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n205so16682018ybf.20
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Dec 2020 22:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LC6KJs6vajpeJsp5rgqNYIF+TrIBrc+h9wkJUlDzBSY=;
        b=mrErIfReCZAw+wNBMefjU1dGD5mVHKJiP6G3uSqDixBGTIEPxB6lhQPA1c9vxhv/Ab
         f41JXJZf5QBUwCVJXrCKv+I79Tv+brooRhzUYtMPi5LL3FV88U+MOBwJVKv9zw4QsD8o
         Prvn1OVMg9zYVaXnMZFtK5/3S/+Xrby7pvt1XtG6cyY59oEp6HMaOpQjFWYDvwbIdgVB
         I0INTmlPxdw38ZN5P6f2Y0TAK699PVDEELc0e75ORkk5ejgT+8FKI4A/JNSobJ8jKHIJ
         WKUTTu0J0Px/MF7w5jmxeL4LyI9eLm8WmdEb4MB78We6iyrx5gyKu7pmCDdJIsMB/auI
         Zeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LC6KJs6vajpeJsp5rgqNYIF+TrIBrc+h9wkJUlDzBSY=;
        b=Pa3TfWxU/2eKvL9joYOuFtACD/S/J74ChEnnrWO3XE1ACLifsgMjXt7ccOOOCOKqQi
         2NK1+covDrdz30yrqOOVJKB9zugw7Z9zarInqSE3SLfhiAbI75CCA3fl7l0I4//HIwrO
         kiSAF2bXu8/0vKTSV5CSzuJ8GOd15rEmuNfjiilITTzU0Or+UOq7TsNEeKXhKDYeLloq
         o3FLFN0kzl4NAnILE0tzkmuwp3b0inN2xi1u5D+WXgOVSP85CAA3qGQs2H72Xp1A832b
         B8TqRNYLp9UwwwZkC8So8oq4nAn7rD4BOEOkAdyJ4wfB/3dLsx1B3UWx9qgPF7WF2XpD
         eDnw==
X-Gm-Message-State: AOAM531fVGgN8aCRm+pA0yi9ZIdX0NsFKm+rw2K/5mSXD1qwhV9KhipI
        gJWa68cQEckN3wMIGGq2drTAPvhA78zUVbFoBaBwlniatWxarP9Hv2R1d3laBZCRCFQy0gFSENM
        sP1GpyB3aTrQfhrA2W3XqxaqsIJhtwsHe6f46xXulp2QBcpLve9vJVIyJMIGkbQRCX2QTjmbh9j
        FnTj33CPE8qJY=
X-Google-Smtp-Source: ABdhPJzge/LmM0XGsn4bgF7Uj7Cos2JkuZvxtSvgJ4IxD6plUv31S/4ltt3G1fNu6Nb17qipkKhhdoFqVv4hKqxeqw==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:ad93:: with SMTP id
 z19mr61939262ybi.486.1609137991351; Sun, 27 Dec 2020 22:46:31 -0800 (PST)
Date:   Mon, 28 Dec 2020 14:46:11 +0800
In-Reply-To: <20201228144543.Bluez.v1.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Message-Id: <20201228144543.Bluez.v1.2.I0c07c297925f838138b42674ab244572e6ea361b@changeid>
Mime-Version: 1.0
References: <20201228144543.Bluez.v1.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [Bluez PATCH v1 2/4] btmgmt: Add command read-sysconfig
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        luiz.dentz@gmail.com
Cc:     mmandlik@chromium.org, mcchou@chromium.org, apusaka@chromium.org,
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

 tools/btmgmt.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 2f7cb2efcc38..c766de862a12 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1752,6 +1752,53 @@ static void cmd_exp_debug(int argc, char **argv)
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
+	struct mgmt_tlv *entry;
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
@@ -5030,6 +5077,8 @@ static const struct bt_shell_menu main_menu = {
 		cmd_expinfo,		"Show experimental features"	},
 	{ "exp-debug",		"<on/off>",
 		cmd_exp_debug,		"Set debug feature"		},
+	{ "read-sysconfig",	NULL,
+		cmd_read_sysconfig,	"Read System Configuration"	},
 	{} },
 };
 
-- 
2.29.2.729.g45daf8777d-goog

