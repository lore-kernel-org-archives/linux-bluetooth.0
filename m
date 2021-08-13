Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2479DC432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D024610A4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbhHMMWd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240497AbhHMMWd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:22:33 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F654C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:06 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id t3-20020a0cf9830000b0290359840930bdso3472915qvn.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PEgddjQmHWVJb+RnTYguCWIfPVLsTPqKeJvEdYx/1K8=;
        b=aozckpEaxtHQGS/EVkFQgrA1HKIEF4nMzXsUk+DiMGnbiTTDupVjPPfDmYWddKVLrg
         R+fWJiguz83kl8Ip7Me/XTKhJPsVE6zH10APTw3GVhXLeH+NV65Mho05GFX95b3f0rPF
         EQ5C0zBcfqF1kz6Rpdsl8IA5x9/qJca+0Je1++SB1+Fz3o4JHX3UiGhpn+ks0ePdqE3v
         an5q6qVDlLZ/4qA9yC6R8ddRuOYz39JJhrULcQwp0BeWUGrNAKdQmrlKg1d0k4YyEp43
         EcJSeQ9R3gq3j5xHkzGp9dHwvp0p1wK3NzFq720ffNMgH+s0+gU+HqNUCULJCbewW3RW
         2W6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PEgddjQmHWVJb+RnTYguCWIfPVLsTPqKeJvEdYx/1K8=;
        b=ArT6a5dMWBKQb/0j00SM2SgF2uR8v2CRowcQAtzqIBG3H+ezBzAdL/LbjrHYy2NG4D
         kHrDKanm0tJxnQ4SbDAaBnyPgthsxo03DlJrsIUqznNRw23uoxTv2OaSsIqGOySbgotG
         Pshnae11JJ+f7Gg8q2Jei7RhUfkblrfwAy5Z5/J66bT0qK87QIfrmjGBMc8/hODb9AnY
         1guW8j3uNjm3QXyacEPVmkDVBdzgLg/B+XCe0XA9yK8DTxTcGzmjzEsI5fPnzJmd9BU0
         2L3OGXCZLJYleDZGmHZ7wKA39tSAsCJH+DrjlBnFJqv/iUNtkiRdPtDxtX6BtJiS0lFu
         piVQ==
X-Gm-Message-State: AOAM533jxQRw9UrydceDbKJHBTUFFW9W2astZnYGJM1N8a1lAt0Z0lNq
        i22B6FcMTVZkM5y+IMyBJlT7urC98Xyw1I6Ov054cWQJnWt76laxZeIWZmRo0Yc7DjklebYaWJs
        anyyJrPCW51Z+vMyJIfpUbiED6TBSTuqYUxKdAYSOBsMP2l7EouhBEH/5rnIIzwGjbgd7yW8jET
        jf
X-Google-Smtp-Source: ABdhPJyaPMp+xqa55Qz+Qys3iz1sjtJMz2D+Yu375ybMW805lSg5Euwq4rOucFxKCVmGE1fPoujNzcVns9x/
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a05:6214:2465:: with SMTP id
 im5mr2312814qvb.46.1628857325722; Fri, 13 Aug 2021 05:22:05 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:26 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.41.Ibff40d723f7542fa72902f176293b5bda4abde93@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 41/62] tools/hcitool: Inclusive language changes,
 central peripheral
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" and "peripheral" are the preferred terms, as reflected in
the BT core spec 5.3.
---

 tools/hcitool.c   | 12 ++++++------
 tools/hcitool.rst | 10 +++++-----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index f7fca5216c..f61eae106c 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -1210,10 +1210,10 @@ static struct option cc_options[] = {
 
 static const char *cc_help =
 	"Usage:\n"
-	"\tcc [--role=m|s] [--ptype=pkt_types] <bdaddr>\n"
+	"\tcc [--role=c|p] [--ptype=pkt_types] <bdaddr>\n"
 	"Example:\n"
 	"\tcc --ptype=dm1,dh3,dh5 01:02:03:04:05:06\n"
-	"\tcc --role=m 01:02:03:04:05:06\n";
+	"\tcc --role=c 01:02:03:04:05:06\n";
 
 static void cmd_cc(int dev_id, int argc, char **argv)
 {
@@ -1360,10 +1360,10 @@ static void cmd_sr(int dev_id, int argc, char **argv)
 
 	str2ba(argv[0], &bdaddr);
 	switch (argv[1][0]) {
-	case 'm':
+	case 'c':
 		role = 0;
 		break;
-	case 's':
+	case 'p':
 		role = 1;
 		break;
 	default:
@@ -3287,7 +3287,7 @@ static const char *lecup_help =
 	"\t    --handle=<0xXXXX>  LE connection handle\n"
 	"\t    --min=<interval>   Range: 0x0006 to 0x0C80\n"
 	"\t    --max=<interval>   Range: 0x0006 to 0x0C80\n"
-	"\t    --latency=<range>  Slave latency. Range: 0x0000 to 0x03E8\n"
+	"\t    --latency=<range>  Peripheral latency. Range: 0x0000 to 0x03E8\n"
 	"\t    --timeout=<time>   N * 10ms. Range: 0x000A to 0x0C80\n"
 	"\n\t min/max range: 7.5ms to 4s. Multiply factor: 1.25ms"
 	"\n\t timeout range: 100ms to 32.0s. Larger than max interval\n";
@@ -3379,7 +3379,7 @@ static struct {
 	{ "con",      cmd_con,     "Display active connections"           },
 	{ "cc",       cmd_cc,      "Create connection to remote device"   },
 	{ "dc",       cmd_dc,      "Disconnect from remote device"        },
-	{ "sr",       cmd_sr,      "Switch master/slave role"             },
+	{ "sr",       cmd_sr,      "Switch central/peripheral role"       },
 	{ "cpt",      cmd_cpt,     "Change connection packet type"        },
 	{ "rssi",     cmd_rssi,    "Display connection RSSI"              },
 	{ "lq",       cmd_lq,      "Display link quality"                 },
diff --git a/tools/hcitool.rst b/tools/hcitool.rst
index f59d694078..80f8c6c22f 100644
--- a/tools/hcitool.rst
+++ b/tools/hcitool.rst
@@ -74,7 +74,7 @@ cmd <*ogf*> <*ocf*> [*parameters*]
 con
     Display active baseband connections
 
-cc [--*role*\=m|s] [--*pkt-type*\=<*ptype*>] <*bdaddr*>
+cc [--*role*\=c|p] [--*pkt-type*\=<*ptype*>] <*bdaddr*>
     Create baseband connection to remote device with Bluetooth address *bdaddr*.
 
     Option **--pkt-type** specifies a list  of  allowed packet types.
@@ -82,9 +82,9 @@ cc [--*role*\=m|s] [--*pkt-type*\=<*ptype*>] <*bdaddr*>
     packet types are **DM1**, **DM3**, **DM5**, **DH1**, **DH3**, **DH5**,
     **HV1**, **HV2**, **HV3**. Default is to allow all packet types.
 
-    Option  **--role** can have value **m** (do not allow role switch, stay
-    master) or **s** (allow role switch, become slave if the peer asks to become
-    master). Default is **m**.
+    Option  **--role** can have value **c** (do not allow role switch, stay
+    central) or **p** (allow role switch, become peripheral if the peer asks to
+    become central). Default is **c**.
 
 dc <*bdaddr*> [*reason*]
     Delete baseband connection from remote device with Bluetooth address
@@ -96,7 +96,7 @@ dc <*bdaddr*> [*reason*]
 
 sr <*bdaddr*> <*role*>
     Switch role for the baseband connection from the remote device to
-    **master** or **slave**.
+    **central** or **peripheral**.
 
 cpt <*bdaddr*> <*ptypes*>
     Change packet types for baseband connection to device with Bluetooth
-- 
2.33.0.rc1.237.g0d66db33f3-goog

