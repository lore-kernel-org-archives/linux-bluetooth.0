Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FB1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Jul 2022 00:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiGAAn6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 20:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiGAAn4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 20:43:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F61426123
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 17:43:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso4272991pjz.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 17:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O8PU/ggPY0R+xiJOK44jO1NRQzX5A/Mptp3KOu8Cp8U=;
        b=SdgJZ60+kEDrMYC715trnY2XBfHIMk4QILPkF719y72p1vebzJi9mnvCcYGGD6uqOy
         /ruvRr7//nMo0FTRUUZhkEw/YggIFWxyLdARzBdhKnk8DkKazKEuuCK+gSuFmM9LB5pL
         6f5Ll59B3TLkGp3kOwBaQdng7Vp/LB8OKdem7DvcqhT8leRHm39HBlPohdyr1Nvq2t1X
         PKcRwVtRc3lqux1SWcY1zvWtSMzz5WFyEKx9t1ddGCLKieT6CD/8poTf0tUq+v7piyBK
         x5zlxXedwmJ6/dnxcOEEj1V9xxzbzg+V1mvGM92SaubFTcs84hQAgKJd/raWf1lX54C2
         w/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8PU/ggPY0R+xiJOK44jO1NRQzX5A/Mptp3KOu8Cp8U=;
        b=HZkryC81bJ/jecyA34tE+6hpAtDLvCdLkDCuXzhDf1sK1guD0tAHJCxxxx30Iikf74
         fkNaSx0NdqJfjMsodOwYwWWYDs1JRgdZqQDJweiOvxYXiAcN43YqYZsmAMXDe+VFAfGV
         NMLpI5GehxumrC9nxGQrt1jd6oA5QGaeXS182bk028Fppit8nXOd+eIw5qJ+JkBB0RR7
         9QziIa8082GtJJ2Sv0EQ/K6Y3AIHEMm54Gt9sGeJPa3l97eQZFRYAHcwM/btd7JfTZFI
         WKWpVl/hFxaIQnSqmj/pcZeFDw80DLKJBfqolUbc25h6IQVSGhdqrw6LclDK/P9swP7t
         5JXw==
X-Gm-Message-State: AJIora/pqVZpWTyddauzKBXHuDR43uwP3aivGB3bmriYXJmbvB+2YWwv
        rIVoZCQ6fb0hfn262hWjI2qA6zSjP48=
X-Google-Smtp-Source: AGRyM1t75rxz+/rJ4/Sl7DkoNHAKYJ3Bbrr8ver9HP1fVAP/aa5fe4QEEZXyHq6z/03gtzD7EQyrRg==
X-Received: by 2002:a17:90b:4d8d:b0:1ec:ce0f:790f with SMTP id oj13-20020a17090b4d8d00b001ecce0f790fmr15292283pjb.116.1656636235330;
        Thu, 30 Jun 2022 17:43:55 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:6a2e:d91e:28c5:a052])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7888b000000b0052516db7123sm14181442pfe.35.2022.06.30.17.43.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 17:43:54 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] tools/test-runner: Fix errors reported by scan-build
Date:   Thu, 30 Jun 2022 17:43:52 -0700
Message-Id: <20220701004352.2253107-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220701004352.2253107-1-hj.tedd.an@gmail.com>
References: <20220701004352.2253107-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the errors reported by the scan-build.

tools/test-runner.c:315:2: warning: Null pointer passed to 1st parameter
expecting 'nonnull' [core.NonNullParamChecker]
        execve(argv[0], argv, qemu_envp);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tools/test-runner.c:554:6: warning: Null pointer passed to 1st parameter
expecting 'nonnull' [core.NonNullParamChecker]
        if (chdir(home + 5) < 0) {
            ^~~~~~~~~~~~~~~

tools/test-runner.c:638:6: warning: Null pointer passed to 1st parameter
expecting 'nonnull' [core.NonNullParamChecker]
        if (chdir(home + 5) < 0) {
            ^~~~~~~~~~~~~~~

tools/test-runner.c:695:6: warning: Null pointer passed to 1st parameter
expecting 'nonnull' [core.NonNullParamChecker]
        if (chdir(home + 5) < 0) {
            ^~~~~~~~~~~~~~~

tools/test-runner.c:984:3: warning: Value stored to 'serial_fd' is never
read [deadcode.DeadStores]
                serial_fd = -1;
                ^           ~~
---
 tools/test-runner.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 6886d66c6..5ab8e57a0 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -269,6 +269,11 @@ static void start_qemu(void)
 
 	pos = (sizeof(qemu_argv) / sizeof(char *)) - 1;
 
+	/* Make sure qemu_binary is not null */
+	if (!qemu_binary) {
+		fprintf(stderr, "No QEMU binary is set\n");
+		exit(1);
+	}
 	argv[0] = (char *) qemu_binary;
 
 	if (audio_support) {
@@ -800,6 +805,11 @@ static void run_command(char *cmdname, char *home)
 	pid_t pid, dbus_pid, daemon_pid, monitor_pid, emulator_pid,
 	      dbus_session_pid, udevd_pid;
 
+	if (!home) {
+		perror("Invalid parameter: TESTHOME");
+		return;
+	}
+
 	if (num_devs) {
 		const char *node = "/dev/ttyS1";
 		unsigned int basic_flags, extra_flags;
@@ -979,10 +989,8 @@ start_next:
 	if (udevd_pid > 0)
 		kill(udevd_pid, SIGTERM);
 
-	if (serial_fd >= 0) {
+	if (serial_fd >= 0)
 		close(serial_fd);
-		serial_fd = -1;
-	}
 }
 
 static void run_tests(void)
-- 
2.34.1

