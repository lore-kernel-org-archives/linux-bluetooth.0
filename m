Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F094C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 16:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjGLQsN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 12:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjGLQsL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 12:48:11 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA881136
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 09:48:06 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4R1Nw41rLZz49Q9m;
        Wed, 12 Jul 2023 19:48:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1689180484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nx8t9C/fg60pCaQqnLs6ZoflL0zQC+OCnWhyH0kALxs=;
        b=bToyYWv/Wg8Ov/YbHKiKVnHZEKVUdzZc/GwhR+LDbfgV3Kua6WMI+dZFas2PdD2C9kpVrh
        h9pG1KreKi3Gl738qgZmLq+Cqs7EHy4ScQNCFo1w8wz9qlFT/EGTkJsf2kSlwwakzyYXGp
        2OBzj0wts1v5k/fzUaZVnhJZB9e/WkcWre+BUDfVcG0io1YwEW7XoNz+f5t3qkBeprlTTL
        Q7QNuIlqxHkGhzrbwxRkASBr6PUS+WMeDG25ozcArUj90fQ57YYfBpHWHE47fQK/Pdxgy5
        WJa61whzKgCkkA0PLRBS+xwsHPOljQAUDzNWpDHMg6PnOCccEBCsdvZFxlmLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1689180484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nx8t9C/fg60pCaQqnLs6ZoflL0zQC+OCnWhyH0kALxs=;
        b=Aw7ow37YGndkKr6ljlGW8vB7lMtyIF0L0FnLizcszSlxInqHmh2zWtvaTeLEw6hTvneRNs
        S7oOsBtKtAWSK3ddkmpjqyyTzr/U285i1N/LdYeUvuVBGqjRTkZ2aHt4wuiAyqWmYbGjgY
        beq4TS/TyuMvgcPRxdVByxpJK2dYjMoRCN093ZLuXlVJ6s0IjcKEj4zPyFVL8nY3MZme8q
        DFRUheIL4VH/Cze8cnjfqOYBuJk5gQj+49YmN4N/PB5BaVBgmhntEyh/HiNk1eyfvJ96j0
        8/O07PxWzSQqzojs4ZIVQefRk7nPIMMaeIPU2COIKtcFY24gpYHGIwCxa0ELFw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1689180484; a=rsa-sha256;
        cv=none;
        b=Dmk+5g/XsbhehGm1YTaCUrlrZ2EjVuQH7ToiMowq688IyoEiM905tYwrPuBOgxPtXPEfGU
        0/iSFk4xMsBPBoBO3K/UPRwgOBhaLaN56C0aAXIzITAueUcwT9IjWgdfC0b0tnRa0O6id1
        NepcOiO5pzdzo+zlsitEOsAz7NkDkLO6NnCZjIpYbhdZgmLBZNrUbtN1HmMAl1VRdNnaXG
        CNpJBWImNKVX1tUZme0iTw6+y390d9MKurHjGUUGA43Zn5PrX7V1IVGztBdjGP7mkJurXQ
        ueM7IjxzZcQNbujDwD4SxPjPQ3tvVJEfylRWPuw29mvRDzyDeujszTHbP1zp/w==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] test-runner: fix behavior when no audio server
Date:   Wed, 12 Jul 2023 19:48:00 +0300
Message-ID: <957b9b9c5c06960a6632ec0a90885388f18db4bf.1689180344.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <859a1c176765dbb9ea394dde387b8ed072365ca8.1689180344.git.pav@iki.fi>
References: <859a1c176765dbb9ea394dde387b8ed072365ca8.1689180344.git.pav@iki.fi>
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
index 288901a61..cfb97907f 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -273,7 +273,8 @@ static void start_qemu(void)
 				initcmd, cwd, start_dbus, start_daemon,
 				start_dbus_session,
 				start_monitor, start_emulator, num_devs,
-				run_auto, audio_server, testargs);
+				run_auto, audio_server ? audio_server : "",
+				testargs);
 
 	argv = alloca(sizeof(qemu_argv) +
 				(sizeof(char *) * (4 + (num_devs * 4))));
@@ -1128,7 +1129,7 @@ static void run_tests(void)
 		const char *start = ptr + 11;
 		const char *end = strchr(start, '\'');
 
-		if (end) {
+		if (end && end != start) {
 			audio_server = strndup(start, end - start);
 			printf("Audio server %s requested\n", audio_server);
 		}
-- 
2.41.0

