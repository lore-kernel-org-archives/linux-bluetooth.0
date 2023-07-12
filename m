Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7CAEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 16:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjGLQsM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 12:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjGLQsL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 12:48:11 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA5710C7
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 09:48:06 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4R1Nw134yvz49Q76;
        Wed, 12 Jul 2023 19:48:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1689180483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LI7UrAM162kd+BkAM3yr4UIRryDtwBu859tgXGcFFtw=;
        b=lqt7sU1AL3OxNF9n9qNSIPggtZMd8pOREJX2y8ZB/MUegqWUL219+qbPI5p7JDT6Wd7xgZ
        D8q5aGVW+k+t668FR6U/duDnyuAPqAUezQykJaJBagBY8w93skiE9C1pegv/f/46XxuM1P
        IiWay+opKXYyODHywIzBQM4Mp3PcDwvjGexkx0V6kJd44c5AAt8+F29E/DO5UJFxCDL5/9
        bHQQCsyH3wQqFT6k+9iIykCi+o21m0EiRPPy65pnsOS8qcwQcGXFY9jqtfsBJ6FMD9voLf
        cxM75PA2/7yItGZaNUG4C3bNqZBdWalxK3iWgcRP9NwGprxuyf8/tbmxUzOw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1689180483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LI7UrAM162kd+BkAM3yr4UIRryDtwBu859tgXGcFFtw=;
        b=mDgFFVGY7ExTO/KQ/HDXinH8f6yHhtWLhay5Y413NXJHTLxp3pl8LZDW63KdTuBEhdbwFM
        vKgRv+FKD2RkMiPg06ECk4yUYUNVFL6AedvER0DS4qDANX132hZFzfQuOglgnwTsMdbwjR
        FI5nZTZG4hIIOtYh/It2b5hbaJJb6MUBnE0DuHIq4eP0enxtz8i9eBKQhWyncpGy2YKJ8f
        AAHr6CCSf6zLBawzenC0KPYamzyVikh38QR9xA2Da94gfMOPLE4gfWq5VSQBtKnHZFfq+G
        WktCtcY1KTN09L1B0rQ/miUGfdIrG12xcYEzeAec51IrtqEiIYhn6z+Wr9j9XA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1689180483; a=rsa-sha256;
        cv=none;
        b=PFWRE6SP73DtBWYx7BqIRXxk6AqYT8naXXseSB437fJkwHtBORJRZRGMWYL6AzU+be+mQ+
        7QlX0MK8UqIzlwrJ++rzrdIhsuODD+0bIoz8w3ViFsghhGs9RwCjbWetQyMTwp8iaznBmp
        Yptth0vj5bYlCWA4tfZ+GIyK89SHTZdiz/JRfD5MzFjcchfvq3JVMsWygyBf08Ws6HOWys
        f//TucV/x0dgtvS02LzlyIohq25CYGQDDwlfV1OA1pmKUC9KMCwarT6BdH9NnuJCw/s+kf
        9un2zWfpTkajk12wZZvwZ7jjBSgnCU2x7jyoCyHE4+XjFn7mT/dgSH9rez9hJg==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] test-runner: set non-quiet printk before running tests
Date:   Wed, 12 Jul 2023 19:47:59 +0300
Message-ID: <859a1c176765dbb9ea394dde387b8ed072365ca8.1689180344.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It is useful to see WARN_ON/bt_dev_err messages when running the tests.
Enable non-quiet printk levels after boot, so that it is on by default
and doesn't need to be handled in local test scripts.
---

Notes:
    It could be useful to also check for BUG/WARNING in the bluez test bot.

 tools/test-runner.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index d74bb1087..288901a61 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -136,6 +136,20 @@ static const char *config_table[] = {
 	NULL
 };
 
+static void enable_printk(void)
+{
+	FILE *f;
+
+	/* Set non-quiet printk level */
+	f = fopen("/proc/sys/kernel/printk", "w");
+	if (!f) {
+		perror("Failed to set printk");
+		return;
+	}
+	fprintf(f, "7 4 1 7");
+	fclose(f);
+}
+
 static void prepare_sandbox(void)
 {
 	int i;
@@ -181,6 +195,8 @@ static void prepare_sandbox(void)
 				"mode=0755") < 0)
 			perror("Failed to create filesystem");
 	}
+
+	enable_printk();
 }
 
 static char *const qemu_argv[] = {
-- 
2.41.0

