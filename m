Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E09EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 21:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjGLVWz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 17:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGLVWy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 17:22:54 -0400
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929441BF3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 14:22:53 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4R1W1731qWzyfb;
        Thu, 13 Jul 2023 00:22:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1689196971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5PH9FTE03bzhrvZ8/lmoxEfuHEMIQvOH29LebjZueS8=;
        b=rjihywSonP9bmdHvmFAp1ZzoP0MnHArq56NNB3BR4DtxaHoSIBItAypNqH8z3gm3iui3Ur
        hIzvupnFH/5ugg6WBH3GFStbRZmKyO1Sx/7Q/3ZxuUvI+lBBs8lLzuTantZaExcfhKi15W
        JHmPQwrl5fq9UqiihbFllca3twdFvjM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1689196971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5PH9FTE03bzhrvZ8/lmoxEfuHEMIQvOH29LebjZueS8=;
        b=CY8w48E+tqypv1g6b72zr4l9iNvfGk/y7XDs/W1nxCIjdKiw27j3qaROoQi71UlhTDkF9F
        XVjlRAFuHnt6cDK28Z+vnjeIENIXkuAy/81vN6yFQipMLfrzaYMeobkkYzKs4ok9KHdOrM
        +FUwFVTKmHElJj5hUJLWIkUaYrHvO6Q=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1689196971; a=rsa-sha256; cv=none;
        b=wnqcAUyQEUMfzSviPzrjkx4HenMz/hX+ovlpwqSpmFWwjGRPSoPBFSbzU45DR6aRc7ENQx
        D2Ny0IpYCP4G70H6DIVZHK3CZkpFXojQkocW6+Ys1XUUidqnmjpGpiq81pjZHEPqmc2k4i
        ULhvSbyseU+hyZGbBu/ZG/eedm5uMJw=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/2] test-runner: fix behavior when no audio server
Date:   Thu, 13 Jul 2023 00:22:49 +0300
Message-ID: <696a65e1c6790cd194c863c5b4128df7aa533e0f.1689196901.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <e521a8d35e8baff45db1fdf8a26725bdc8d595ee.1689196901.git.pav@iki.fi>
References: <e521a8d35e8baff45db1fdf8a26725bdc8d595ee.1689196901.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If no audio server, don't pass NULL to printf and parse TESTAUDIO
correctly.
---
 tools/test-runner.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 119e1cfbc..243eab468 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -277,7 +277,8 @@ static void start_qemu(void)
 				initcmd, cwd, start_dbus, start_daemon,
 				start_dbus_session,
 				start_monitor, start_emulator, num_devs,
-				run_auto, audio_server, testargs);
+				run_auto, audio_server ? audio_server : "",
+				testargs);
 
 	argv = alloca(sizeof(qemu_argv) +
 				(sizeof(char *) * (4 + (num_devs * 4))));
@@ -1132,7 +1133,7 @@ static void run_tests(void)
 		const char *start = ptr + 11;
 		const char *end = strchr(start, '\'');
 
-		if (end) {
+		if (end && end != start) {
 			audio_server = strndup(start, end - start);
 			printf("Audio server %s requested\n", audio_server);
 		}
-- 
2.41.0

