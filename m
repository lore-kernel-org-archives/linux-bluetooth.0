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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5A9C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4EF610A4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbhHMMVy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240445AbhHMMVx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:21:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEFCC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x5-20020a0569020505b0290592c25b8c59so8956948ybs.18
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7BkEGxjBIFv6NdrePU/6M5vHMKKs9MONg7YK1ajPNFc=;
        b=UvvdT3JIBhzHCsVY+WublSyOCk5SA94hLNU+naC4dsODNyDbUF1Z5IAkrxChsYF95D
         RKZryxFtd/30IhyI35mIqaZh3fjvJhZuVYQPjVq8NRLB4xCVnV69yx5d9m+XFSNF2/UM
         JvsWLLBT/45TftRMIF91BDeSA4ffBxKFGmXBug3r/Rhdt0Q5DeedVVyQ0acV4RJfvody
         VRb+y1MXRNfQs0MW7BV8K37bpQ8f2d1mX+bCHQuvxyeKW/TyptmVIdcHJaMUsq88gBsb
         N76uuj4cs5suISYvVh+1w80oo1kECGElt20UKPfcpS5NrmxnmmIKLaZeoHpXT+XOMtkg
         Updg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7BkEGxjBIFv6NdrePU/6M5vHMKKs9MONg7YK1ajPNFc=;
        b=ZhXoH7Jj+igTLpMutX6tboZh21QF0supiIQ8++dVBF+9znExRE2YP9qs0LZlU2sV2m
         jN874Kpmtz1YdV2BmgTqVMdsw3ivJ7Wlao2neCX2DdKHkSHa++0SaF63Jr9AAqVMOobU
         Fgs6/Mo7naTpMjOWoC9sTMK8gD7Nw5IhkqECjsIC5Sm7GKnKiviRiJYCWWe//3+9lG1n
         sACysOMITRJg2mPBcp0OKTQ3IE7RkCqxFgPx2sn7UcuedKL9F25+ZFhaY3QdJXszslM8
         WWOhAeAm/1YQCtcwEoo2X5PsIk47jD+KYZvobwN2iPFhW1293clQnIQm9h3n4zyUu/6B
         fbYA==
X-Gm-Message-State: AOAM533g/RgTam3W0BicpaeKoRVJQGNRlc07ploCMa5RtBjJU6VK8O8J
        DxesaktIh2F4tjWSleyvoPhOOZ7PjMt93eSjatmSWSxRlOBIFd3Bv1gxeE/c/Cdwx5IqN8CuJx6
        MpOzwWrwGKkiKne1VeckLeMWPQf3GJjbjBVBbiAOsd3TSp1yOu0fsNQUXuu2YlYlesjyjnC11uH
        ie
X-Google-Smtp-Source: ABdhPJwk1qVeIh8j5jRchL3iozR4vZ5QkWmC0VycU8XCcvYv1TcaG8nWPuLQVzyzGco3u/cOVNtxqHPFXYb5
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:4086:: with SMTP id
 n128mr2495813yba.247.1628857286133; Fri, 13 Aug 2021 05:21:26 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:15 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.30.I89b23b8f5038b24df78e7108c9bfc7fef9aee423@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 30/62] tools/hciconfig: Inclusive language changes
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

"central", "peripheral", and "reject list" are the preferred terms,
as reflected in the BT core spec 5.3 and
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf
---

 tools/hciconfig.c   | 26 +++++++++++++-------------
 tools/hciconfig.rst |  4 ++--
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 491f216135..2bc9fe84c3 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -116,8 +116,8 @@ static void print_le_states(uint64_t states)
 		"Directed Advertising State",
 		"Passive Scanning State",
 		"Active Scanning State",
-		"Initiating State/Connection State in Master Role",
-		"Connection State in the Slave Role",
+		"Initiating State/Connection State in Central Role",
+		"Connection State in the Peripheral Role",
 		"Non-connectable Advertising State and Passive Scanning State combination",
 		"Scannable Advertising State and Passive Scanning State combination",
 		"Connectable Advertising State and Passive Scanning State combination",
@@ -128,17 +128,17 @@ static void print_le_states(uint64_t states)
 		"Directed Advertising State and Active Scanning State combination",
 		"Non-connectable Advertising State and Initiating State combination",
 		"Scannable Advertising State and Initiating State combination",
-		"Non-connectable Advertising State and Master Role combination",
-		"Scannable Advertising State and Master Role combination",
-		"Non-connectable Advertising State and Slave Role combination",
-		"Scannable Advertising State and Slave Role combination",
+		"Non-connectable Advertising State and Central Role combination",
+		"Scannable Advertising State and Central Role combination",
+		"Non-connectable Advertising State and Peripheral Role combination",
+		"Scannable Advertising State and Peripheral Role combination",
 		"Passive Scanning State and Initiating State combination",
 		"Active Scanning State and Initiating State combination",
-		"Passive Scanning State and Master Role combination",
-		"Active Scanning State and Master Role combination",
-		"Passive Scanning State and Slave Role combination",
-		"Active Scanning State and Slave Role combination",
-		"Initiating State and Master Role combination/Master Role and Master Role combination",
+		"Passive Scanning State and Central Role combination",
+		"Active Scanning State and Central Role combination",
+		"Passive Scanning State and Peripheral Role combination",
+		"Active Scanning State and Peripheral Role combination",
+		"Initiating State and Central Role combination/Central Role and Central Role combination",
 		NULL
 	};
 
@@ -1922,8 +1922,8 @@ static struct {
 	{ "features",	cmd_features,	0,		"Display device features" },
 	{ "version",	cmd_version,	0,		"Display version information" },
 	{ "revision",	cmd_revision,	0,		"Display revision information" },
-	{ "block",	cmd_block,	"<bdaddr>",	"Add a device to the blacklist" },
-	{ "unblock",	cmd_unblock,	"<bdaddr>",	"Remove a device from the blacklist" },
+	{ "block",	cmd_block,	"<bdaddr>",	"Add a device to the reject list" },
+	{ "unblock",	cmd_unblock,	"<bdaddr>",	"Remove a device from the reject list" },
 	{ "lerandaddr", cmd_le_addr,	"<bdaddr>",	"Set LE Random Address" },
 	{ "leadv",	cmd_le_adv,	"[type]",	"Enable LE advertising"
 		"\n\t\t\t0 - Connectable undirected advertising (default)"
diff --git a/tools/hciconfig.rst b/tools/hciconfig.rst
index 6141fc2be7..2d56eeb413 100644
--- a/tools/hciconfig.rst
+++ b/tools/hciconfig.rst
@@ -230,10 +230,10 @@ lm [*mode*]
     sockets.
 
 block <*bdaddr*>
-    Add a device to the blacklist
+    Add a device to the reject list
 
 unblock <*bdaddr*>
-    Remove a device from the blacklist
+    Remove a device from the reject list
 
 lerandaddr <*bdaddr*>
     Set LE Random Address
-- 
2.33.0.rc1.237.g0d66db33f3-goog

