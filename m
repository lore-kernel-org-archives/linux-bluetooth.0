Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3ADC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 07:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C740420732
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 07:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TYaU/oTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgHUH20 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgHUH2Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 03:28:25 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D956CC061385
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 00:28:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a79so649883pfa.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3sU0357hYiDl5l/vHKQ4nLAzIRHctOnyhKqk4fMM/Q=;
        b=TYaU/oTLt1fs416s8kkfo9n0n6L1TdbJmfyDGQmTDNtDL7XH49zN0s7hkjU07FDC0B
         R0M3hAi5RpMvGga1vSYErUVUtNXxm/pBMBwxxyPs2SKlvnNsq3kar0cgu2IjmgcxrmQh
         xP6Uqx2RRf223OdUvMcqtiKfa/UOyJ1abMtQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3sU0357hYiDl5l/vHKQ4nLAzIRHctOnyhKqk4fMM/Q=;
        b=BDqBSHhYURdetT1Kdptxy7nyZsEn/pdT6WdnrEQYSipqzrg2nau6+Ee7phigpuPief
         xomS632OsE8xmHRtaq+qjYNY52+h3f/cWeS4AVj2O4ktfwnAzRci5jMcEv9gqi6Ok4xi
         2pPagO3CKjeRGsRPujnqwPUDYV22VTfd0GjoMFavR6WO2zrmW4rElFSPX1A87UH1os3M
         ncVNeKGhXNgCfkUBjBbYztMepZTBTbWIDaxqNvwUBfBpsvnX9sv/a8ZCMGpfNQ2BlmG+
         mmsUa7fIL1O46O1f77zvAq3hBXmKdfuSqV93alid5sPwbcw3Q7j4TIHKxyv3ZUckGM7j
         DI5g==
X-Gm-Message-State: AOAM532Qofm3m86NZWFrKEBmlkTiTD7wClhkHiKdJw1U9iyesaX9+NNB
        MkEhQBDtx0X0T2ueum0ZTX3nk46UC773mg==
X-Google-Smtp-Source: ABdhPJzqy+/iP4ViJxqQ8/TjUyQY+yF0/st8pMQObEoU7lfZDsERwyx7u8bFzUd13gpO7SZmlo4YEA==
X-Received: by 2002:a63:441c:: with SMTP id r28mr1390657pga.84.1597994905039;
        Fri, 21 Aug 2020 00:28:25 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id b15sm1107738pgk.14.2020.08.21.00.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 00:28:24 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Miao-chen Chou <mcchou@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ] client: Add cancel-pairing command
Date:   Fri, 21 Aug 2020 00:28:12 -0700
Message-Id: <20200821072812.19131-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Miao-chen Chou <mcchou@chromium.org>

This adds cancel-pairing command which can be used to cancel the ongoing
pairing.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>

---
 client/main.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/client/main.c b/client/main.c
index 9abada69f..da877b546 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1742,6 +1742,39 @@ static void cmd_pair(int argc, char *argv[])
 	bt_shell_printf("Attempting to pair with %s\n", proxy_address(proxy));
 }
 
+static void cancel_pairing_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to cancel pairing: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	bt_shell_printf("Cancel pairing successful\n");
+}
+
+static void cmd_cancel_pairing(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	proxy = find_device(argc, argv);
+	if (!proxy)
+		return;
+
+	if (g_dbus_proxy_method_call(proxy, "CancelPairing", NULL,
+				cancel_pairing_reply, NULL, NULL) == FALSE) {
+		bt_shell_printf("Failed to cancel pairing\n");
+		return;
+	}
+
+	bt_shell_printf("Attempting to cancel pairing with %s\n",
+							proxy_address(proxy));
+}
+
 static void cmd_trust(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
@@ -2816,6 +2849,8 @@ static const struct bt_shell_menu main_menu = {
 							dev_generator },
 	{ "pair",         "[dev]",    cmd_pair, "Pair with device",
 							dev_generator },
+	{ "cancel-pairing",  "[dev]",    cmd_cancel_pairing,
+				"Cancel pairing with device", dev_generator },
 	{ "trust",        "[dev]",    cmd_trust, "Trust device",
 							dev_generator },
 	{ "untrust",      "[dev]",    cmd_untrust, "Untrust device",
-- 
2.26.2

