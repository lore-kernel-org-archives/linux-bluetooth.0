Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6329BC001B1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jul 2023 17:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjGDRG7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jul 2023 13:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjGDRG6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jul 2023 13:06:58 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0295FE70
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jul 2023 10:06:56 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QwTjT3TDrzykW;
        Tue,  4 Jul 2023 20:06:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1688490413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eHO4A7bt4cjZVAZOZ+/OEa1ArWt99JHanNEHKTDRs7I=;
        b=TZbuZDX0ZZk00n/E82ujJgso/6PYSLqPdgAUJfWVmFmNJbRR912IvQPo4UGQ58t26RbHMH
        wP1ci7EL0vtSkiNIxUOqqS6T0w9ohz8twT7Nq3xWmQ5oTZLae311qGenuDhIq9MkVfMZV4
        RMYGrl8dgzwetIiOTuioXiuJ0smRxo0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1688490413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eHO4A7bt4cjZVAZOZ+/OEa1ArWt99JHanNEHKTDRs7I=;
        b=F8J1EuTwqP1DQHMEnHr3FmouG5XtYuBuaC1vzNXMu8EmWZKbkKDACKQalqgLFC2y81ufaT
        JAFrzUUBr+JtW5meWETHCbUe6zxNgloc4rMl3vNrHorz7/wwvDk5Uu0yRR8jknL1wpoW4i
        cjR3zB8jOrFCbZBbFmUtXxqqI0tyfRI=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1688490413; a=rsa-sha256; cv=none;
        b=lva2UpfPsml+tOil2Atj1SEsFFaTRgD3oA1J6IWd8F3fiEKQZjToCvSjBQhVVHkJ1jpMbE
        Zf1x9T7XhnfRJH5npwmD59w2gBZrsOfqJEELsNC/DPysZu8+vlNWy6uOtVgI/n0I5wSD3z
        3gD4pVzH1ZGpfhphsBGKu4zN7dNw51I=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] doc/tester-config: enable DEBUG_KERNEL, PROVE_RCU, DEBUG_ATOMIC_SLEEP
Date:   Tue,  4 Jul 2023 20:06:51 +0300
Message-ID: <fdec6ddf8eacfb37cbd34d9049fcadf29041c103.1688490237.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add more lock/sleep debugging to the default tester config.

Enable DEBUG_KERNEL since olddefconfig won't enable PROVE_LOCKING
without it. Enable PROVE_RCU to also check RCU usage. Enable
DEBUG_ATOMIC_SLEEP to catch those as well.
---
 doc/test-runner.txt | 3 +++
 doc/tester.config   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/doc/test-runner.txt b/doc/test-runner.txt
index 019c23188..43ce42be6 100644
--- a/doc/test-runner.txt
+++ b/doc/test-runner.txt
@@ -74,9 +74,12 @@ Lock debuging
 To catch locking related issues the following set of kernel config
 options may be useful:
 
+	CONFIG_DEBUG_KERNEL=y
 	CONFIG_LOCKDEP_SUPPORT=y
 	CONFIG_DEBUG_SPINLOCK=y
 	CONFIG_DEBUG_LOCK_ALLOC=y
+	CONFIG_DEBUG_ATOMIC_SLEEP=y
 	CONFIG_PROVE_LOCKING=y
+	CONFIG_PROVE_RCU=y
 	CONFIG_LOCKDEP=y
 	CONFIG_DEBUG_MUTEXES=y
diff --git a/doc/tester.config b/doc/tester.config
index 4429a7222..099eddc79 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -47,10 +47,13 @@ CONFIG_UNIX=y
 
 CONFIG_UHID=y
 
+CONFIG_DEBUG_KERNEL=y
 CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
 CONFIG_PROVE_LOCKING=y
+CONFIG_PROVE_RCU=y
 CONFIG_LOCKDEP=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_KASAN=y
-- 
2.41.0

