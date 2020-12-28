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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0D0C433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 06:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A417221E5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 06:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgL1GrQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 01:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgL1GrQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 01:47:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D773BC061796
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Dec 2020 22:46:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o9so16741492yba.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Dec 2020 22:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Ag1yJexuyuOZgLeTCzJRi8FXYTblNlW6uzMyNzlTnww=;
        b=h8X6USyV/YZhm4fjNxWFThAs8jOCMDVBObpbnHxJf2KrnKDKt1reJPfsUq2p45UtWz
         pdmL/MPtEfKS2Gj+yl8oMPm1ODxqjmjg9/ns9jMaTGRJUQ6oO0p85KQQIEd10PQOhrT8
         5F2fNsqdszO+SNqvaIblWl5DaWP7Q6qPhe7bjeH0JNA7j8qElc0iCx8SrZ41NTT8khRn
         yHWh9UCOabamz0LdNstOhEJDT2Ukco1HqKfKPVFYtwJT3NQSA06RPDO6gfJU+e3lfyJJ
         +NfHYWNMKSHT1JkhqtcySTrn1ldXauJYRuqrurlBqWvn+pV7Q0YVUpGGUnOdHCgKmOtD
         Y+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ag1yJexuyuOZgLeTCzJRi8FXYTblNlW6uzMyNzlTnww=;
        b=Et+FMqOu/dkJz14ZDpTOKum+PDtQ1m5csAg19pFSfkwKV6oJLDP5yzlPTpJboHcsbW
         MEYj47PHVn5IjI2jwSvxJoHEfB1t7uYb7A/nKbwzkrwSinZIGc+Zc2Bfrgq0ifVnlPR0
         FxvCg2Kj5SLqVSJ7P8Mn1F4FY6ztT3fjrJikKLy/9EJ6EI4pbmTVyJf6LGDJ05lS41hj
         m7qDL9SLqhBzTMHoJgQo3PT468LyTUYWciQGNmGZw5rfC3V7wlOOyKVM8BM+bxYOdrgc
         OBAXVmDfOWhXF7fvZwOBlc6dadB9ojTIIjT6GuzYKiSyrKa1Qv4p/hCv72ZcUeFJ9dTt
         yYTA==
X-Gm-Message-State: AOAM530LRNNUjKh/+MgrlODvOEOd09OG78pFMKpVvRzAWlHdrrmzK6TM
        szhCp+MlnsIvdQhjm+ciaUl4MciKN5MXyidBTeeEjFcV2KB55iIVGjX6C7AChLK2KaBWf3zf0WI
        Emg5I/FsJQQsyW+h7M8XbvWFtwds/f39EoAG+t0xMmFDbtOwtNFFhvNQ0Iq8Q10g2glDl0k9BZd
        TSs4xXXjSPxTE=
X-Google-Smtp-Source: ABdhPJysQRh+HsX8ZKcc35eLkxFGATxRVcygztn/Yyje+upM7weYzWbj0Nff2n9sJ49ASx4xsGh5EX8Ev7zaQ7u2Rg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:9906:: with SMTP id
 z6mr34353327ybn.238.1609137995074; Sun, 27 Dec 2020 22:46:35 -0800 (PST)
Date:   Mon, 28 Dec 2020 14:46:12 +0800
In-Reply-To: <20201228144543.Bluez.v1.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Message-Id: <20201228144543.Bluez.v1.3.Idca009971ca95228a3fa7232ef648f18ff64d185@changeid>
Mime-Version: 1.0
References: <20201228144543.Bluez.v1.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [Bluez PATCH v1 3/4] btmgmt: Add command set-sysconfig
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        luiz.dentz@gmail.com
Cc:     mmandlik@chromium.org, mcchou@chromium.org, apusaka@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add command set-sysconfig in btmgmt

Example usage:
[mgmt]# set-sysconfig -h
Parameters:
	-v <type:length:value>...
e.g.:
	set-sysconfig -v 001a:2:1234 001f:1:00
[mgmt]# set-sysconfig -v 8:2:abcd 1:02:0100 0016:2:0600

Reviewed-by: apusaka@chromium.org
---

 tools/btmgmt.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index c766de862a12..4cc94efe3f1a 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1799,6 +1799,113 @@ static void cmd_read_sysconfig(int argc, char **argv)
 	}
 }
 
+static bool parse_mgmt_tlv(const char *input, uint16_t *type, uint8_t *length,
+								uint8_t *value)
+{
+	int i, value_starting_pos;
+
+	if (sscanf(input, "%4hx:%1hhu:%n", type, length,
+						&value_starting_pos) < 2) {
+		return false;
+	}
+
+	input += value_starting_pos;
+
+	if (*length * 2 != strlen(input))
+		return false;
+
+	for (i = 0; i < *length; i++) {
+		if (!sscanf(input + i * 2, "%2hhx", &value[i]))
+			return false;
+	}
+
+	return true;
+}
+
+static void set_sysconfig_rsp(uint8_t status, uint16_t len, const void *param,
+								void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Could not set default system configuration with status "
+				"0x%02x (%s)", status, mgmt_errstr(status));
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	print("Set default system configuration success");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static bool set_sysconfig(int argc, char **argv)
+{
+	struct mgmt_tlv_list *tlv_list = NULL;
+	int i;
+	uint16_t index, type;
+	uint8_t length;
+	uint8_t value[256] = {};
+	bool success = false;
+
+	index = mgmt_index;
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	tlv_list = mgmt_tlv_list_new();
+	if (!tlv_list) {
+		error("tlv_list failed to init");
+		goto failed;
+	}
+
+	for (i = 0; i < argc; i++) {
+		if (!parse_mgmt_tlv(argv[i], &type, &length, value)) {
+			error("failed to parse");
+			goto failed;
+		}
+
+		if (!mgmt_tlv_add(tlv_list, type, length, value)) {
+			error("failed to add");
+			goto failed;
+		}
+	}
+
+	if (!mgmt_send_tlv(mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG, index,
+				tlv_list, set_sysconfig_rsp, NULL, NULL)) {
+		error("Failed to send \"Set Default System Configuration\""
+								" command");
+		goto failed;
+	}
+
+	success = true;
+
+failed:
+	if (tlv_list)
+		mgmt_tlv_list_free(tlv_list);
+
+	return success;
+}
+
+static void set_sysconfig_usage(void)
+{
+	bt_shell_usage();
+	print("Parameters:\n\t-v <type:length:value>...\n"
+		"e.g.:\n\tset-sysconfig -v 001a:2:1234 001f:1:00");
+}
+
+static void cmd_set_sysconfig(int argc, char **argv)
+{
+	bool success = false;
+
+	if (strcasecmp(argv[1], "-v") == 0 && argc > 2) {
+		argc -= 2;
+		argv += 2;
+		success = set_sysconfig(argc, argv);
+	}
+
+	if (!success) {
+		set_sysconfig_usage();
+		bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static void auto_power_enable_rsp(uint8_t status, uint16_t len,
 					const void *param, void *user_data)
 {
@@ -5079,6 +5186,8 @@ static const struct bt_shell_menu main_menu = {
 		cmd_exp_debug,		"Set debug feature"		},
 	{ "read-sysconfig",	NULL,
 		cmd_read_sysconfig,	"Read System Configuration"	},
+	{ "set-sysconfig",	"<-v|-h> [options...]",
+		cmd_set_sysconfig,	"Set System Configuration"	},
 	{} },
 };
 
-- 
2.29.2.729.g45daf8777d-goog

