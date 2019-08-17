Return-Path: <SRS0=BOCR=WN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B923BC3A59F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Aug 2019 06:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE7F20880
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Aug 2019 06:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhVazj9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfHQGg0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Aug 2019 02:36:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33444 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfHQGg0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Aug 2019 02:36:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id go14so3030181plb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2019 23:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r+OKXG43+4EYqqwMzIQOfZVDCpcITGkNlaS2JYyQo/g=;
        b=KhVazj9wxEnQiMxa+Gaok/52q4rAvt38veRzAFNmgbrv4yTgS391GM/Pq9AvLXMh02
         hxHwso2Z4oKNacSRABoNo03YbI2/oeKY4XXkoe1ow8Xe/wZJHOiQE9INH9adsZIoQo4f
         I+aF6NjI8ngSgQ7Y/EUhxc7jSGjWzkE6ttjjwqkJUHc+8H8FvZTT6N09vl25YpuB7wnH
         e8q0innHsiWSLTnBm1Q0AJJUxZqypDFh1FBAnJLt51RrIiZg5dLoY7P5Qe8h8e0PPVMv
         v1SpmmFvaQCFVkmSOKBFwU4QkAFvt9bt8TX9i0pHOZHw2wFq3UzyJLQ2WaLuPmGTh4pu
         bVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+OKXG43+4EYqqwMzIQOfZVDCpcITGkNlaS2JYyQo/g=;
        b=apXCP5yh01K2DOuYHbodC/EfOJRYQkNaApJZRMDRFGY2kCZBLNbYrlIvc1Oo1vf51Q
         evWzH5BEgi5/c2TkDGpkxJSYCcYZ+7QiVManBtlIop8Ek8/9KMdhLPO2J3VSRNJ0mud7
         EHBIXbQYiIpVextP/X82SLrkf5QKvkqUQarRylciMvmyPRiHJ2OBdgKvz9R8jBuKy4vM
         VzpLTeSHwrfa0T+L2d+KDmuHmY6Snq8/cTOXzApxz5e1sUGanF7wL+8OpZD+NL3Mzyl/
         Yda/huQKV40Nw1SsWgo1kgECsGNrrBqc1+kXYSzrGiedVkdRRPJXmmJAaiMPZ9VPGBsC
         ZN5A==
X-Gm-Message-State: APjAAAVAVmbTk8I7g+SJzWmsfdPIy1iGVHMAHfmrRJgLWK3mr1V2eqk2
        NEFcahpMRDbGgAtPPvFo4t/dvws=
X-Google-Smtp-Source: APXvYqy+JBabjNPvNOSQdhteBdWcFlgG1iGNsykiZx6E0IzzI2p6zLVcLtvjRE4keWVpWdqQD6KdPA==
X-Received: by 2002:a17:902:b418:: with SMTP id x24mr12554326plr.219.1566023785310;
        Fri, 16 Aug 2019 23:36:25 -0700 (PDT)
Received: from rxps.home ([2600:8800:1e00:242:3550:edee:2708:4ad0])
        by smtp.gmail.com with ESMTPSA id y128sm6684095pgy.41.2019.08.16.23.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 23:36:24 -0700 (PDT)
From:   Ronan Pigott <rpigott314@gmail.com>
X-Google-Original-From: Ronan Pigott
To:     linux-bluetooth@vger.kernel.org
Cc:     Ronan Pigott <rpigott@berkeley.edu>
Subject: [PATCH BlueZ v2 1/4] client/main: add help option for available args
Date:   Fri, 16 Aug 2019 23:34:49 -0700
Message-Id: <20190817063452.23273-2-rpigott@berkeley.edu>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190817063452.23273-1-rpigott@berkeley.edu>
References: <20190817063452.23273-1-rpigott@berkeley.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ronan Pigott <rpigott@berkeley.edu>

This option exists to facilitate external completion of commands that
have specially defined arguments. It effectively adds two new commands
to bluetoothctl with the following output:

$ bluetoothctl agent help
on
off
DisplayOnly
DisplayYesNo
KeyboardDisplay
KeyboardOnly
NoInputNoOutput

$ bluetoothctl advertise help
on
off
peripheral
broadcast

Shell completion scripts can then parse this output to provide
completions for those commands.

---
 client/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/client/main.c b/client/main.c
index 578b3c7c3..0f810901a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -800,6 +800,14 @@ static gboolean parse_argument(int argc, char *argv[], const char **arg_table,
 {
 	const char **opt;
 
+	if (!strcmp(argv[1], "help")) {
+		for (opt = arg_table; opt && *opt; opt++) {
+			bt_shell_printf("%s\n", *opt);
+		}
+		bt_shell_noninteractive_quit(EXIT_SUCCESS);
+		return FALSE;
+	}
+
 	if (!strcmp(argv[1], "on") || !strcmp(argv[1], "yes")) {
 		*value = TRUE;
 		if (option)
-- 
2.22.1

