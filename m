Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B09AEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 21:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjGLVW5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 17:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGLVW5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 17:22:57 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4611BF3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 14:22:54 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4R1W164lS4zyWs;
        Thu, 13 Jul 2023 00:22:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1689196970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8J1uWxzx/ELfQFx/YteDdaNQIKHhGHrBRX+CeNMLqUc=;
        b=D4cODmMauT6ULkWNeKf5GXd9+4zwVtK8oDqgS3qGO5SEzLMN1/nVoAVlcHP0vIMz5knMTR
        HryaSEMeHLRv4sDXMzDdRxEHAgDokmNV9mktkjExnzk99E8FqLVlTqeSitj8YblNd2qR2k
        2jcJiCR5csmR59I2IHlbCMVbT1F3l2s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1689196970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8J1uWxzx/ELfQFx/YteDdaNQIKHhGHrBRX+CeNMLqUc=;
        b=w8447uBSWRl/d/IpDmcst4WT9e3Qs3oJAcqFKTgH45ZK6wJkjWi57VChj7OdjVY0u+W/xA
        Srhb2jlk0K65GXpNCwDdAUUIzWme7ZZtoQlbOTWhmLOpEX1ewI8RR+U/VqvVvnglu3p6RS
        oS0XT4ALnlV3xvXvJcY9vEf/3i44nls=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1689196970; a=rsa-sha256; cv=none;
        b=yCHSLZTtBle/+sUSdnMt1i+NIWCmwBooi4q80g9+q419qxcw4DX35DPj3pBGzHCsfkG22A
        47ZcqTqbn7jWONmbdQiqazaAykvGT3rWLRvWR1EV5sNJLC5Of6Y5dEwDEyuGOrd2yeqTUR
        aF3b87JefExlTvsPalrOWf8l9Qz9Jcw=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/2] test-runner: set non-quiet printk before running tests
Date:   Thu, 13 Jul 2023 00:22:48 +0300
Message-ID: <e521a8d35e8baff45db1fdf8a26725bdc8d595ee.1689196901.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It is useful to see WARN_ON etc. messages when running the tests.

The 'quiet' in cmdline suppresses levels >= WARN, so re-enable them
explicitly after boot, so that it is on by default and doesn't need to
be handled in local test scripts.
---

Notes:
    v2: add comment. Suppress level>=INFO, to hide "Bluetooth: MGMT ver" etc.
    
    It could be useful to also check for BUG/WARNING in the bluez test bot.

 tools/test-runner.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index d74bb1087..119e1cfbc 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -136,6 +136,24 @@ static const char *config_table[] = {
 	NULL
 };
 
+static void enable_printk(void)
+{
+	FILE *f;
+
+	f = fopen("/proc/sys/kernel/printk", "w");
+	if (!f) {
+		perror("Failed to set printk");
+		return;
+	}
+
+	/* Restore printk loglevel, undoing 'quiet' in cmdline (suppress early
+	 * on-boot messages), to show WARN_ON etc. Suppress level>=6(INFO), set
+	 * default_msg:4(WARN) & min:1, default:7. See man 2 syslog.
+	 */
+	fprintf(f, "6 4 1 7");
+	fclose(f);
+}
+
 static void prepare_sandbox(void)
 {
 	int i;
@@ -181,6 +199,8 @@ static void prepare_sandbox(void)
 				"mode=0755") < 0)
 			perror("Failed to create filesystem");
 	}
+
+	enable_printk();
 }
 
 static char *const qemu_argv[] = {
-- 
2.41.0

