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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D569C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 10:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0D122A84
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 10:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgL1KFw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 05:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgL1KFv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 05:05:51 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE6CC061795
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 02:05:11 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id x74so7762228qkb.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 02:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=J2n6YIvt4zqJQtx4TNVo84THrt9CDungO41tQh0sK+g=;
        b=F3FHdEawCo80i2i9MW7UY5w4rH0BhVxOBWmGcGwr7NOny587TsXw2RuT+FnXcUk8jv
         2Y9rwuIqJP0nNKGsb7ZetXh5iD9vn5VHS+2LtLUGwY7+iLi2Pkjv5NLTTYZSDat42+qz
         8+KW+bY9AiTaI3hyf1FH+WGcW8I9lRezgGEKTE0RWYfj5j5V3KIIkiZHSIkf3BLy66VX
         2YVi2prnZhuFtu4g0bQ+d1gOx8b6E0yJYntkLjnkqtYaXY8H/fOCTB/a0HhYZJmVoZHw
         P1Lrym+G/GPWv9Q9NsGqIOt2fRl2jc7dwxQ62J/EQvBPR2tAvdvgCmnIBRTFSyFFNIk9
         CbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J2n6YIvt4zqJQtx4TNVo84THrt9CDungO41tQh0sK+g=;
        b=FkWCnucbW67iYIZx4Vs6sDQzGQ4dB2N4HvElHUxuHv6PJo+50WH+KcPfqnqg2VFYXh
         F15S26Lo9N7sKNmxy0siSVu6qLW/DnreW6PieqP3jsnrNiQmWedT7uEupQfxa+RtvCve
         t7ZIqodBp1HifcPC+ZGFuaUKJgHoz8Zk7YKy9M+mG257kz/2H5i9PVJ8nLDfuwpURfd0
         efVV9lAMFNqpwuMBztXKrys3Xs8LzYVHLqnSL8PtUKWrbJgVdYfsiWz3TWTQuXSVoo7w
         2AP5MQBPZijJhya4PsV3QEHHtSGsommESHQoOt2d1rHBwX8NDRmJ3tPLFuJjmUydUmDR
         6Fbg==
X-Gm-Message-State: AOAM532EWXiCPvUfkuYSj1+6PCoj701MnvVVzz2vlxOHoGXY0sr1Gu2Q
        5ptwE73SViFM/OiQnMpHylaPDV5L4FkLa9LoLRgldtZkRVsKD0K5D7QrZjjGS3VrJB11T4Upcqy
        ggI7ET9IerxOUOHQMa/bRIADRp6bdQE7+LdFkCM9RLW3PmkhFG68g4HHC9N9wsXNWiB0A3IUqCj
        sJub7VhMqkrwg=
X-Google-Smtp-Source: ABdhPJwn/CXbEm2cIsswgkwQk5B3SLAVfXIkFYtlpwYfDPzUIdmQGekZo86ZUhwwJr8JIiYGmCzbeGOY7BmnUjBZ1Q==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a0c:fd8f:: with SMTP id
 p15mr37474076qvr.48.1609149910290; Mon, 28 Dec 2020 02:05:10 -0800 (PST)
Date:   Mon, 28 Dec 2020 18:04:56 +0800
In-Reply-To: <20201228180429.Bluez.v2.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Message-Id: <20201228180429.Bluez.v2.2.I0c07c297925f838138b42674ab244572e6ea361b@changeid>
Mime-Version: 1.0
References: <20201228180429.Bluez.v2.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [Bluez PATCH v2 2/4] btmgmt: Add command read-sysconfig
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

(no changes since v1)

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

