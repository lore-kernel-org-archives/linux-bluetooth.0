Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16955C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 12:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiDFMu0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiDFMmu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Apr 2022 08:42:50 -0400
Received: from mail.pelzflorian.de (pelzflorian.de [5.45.111.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945853EF00D
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 01:44:06 -0700 (PDT)
Received: from pelzflorian.localdomain (unknown [5.45.111.108])
        by mail.pelzflorian.de (Postfix) with ESMTPSA id 042A7360637
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 10:44:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pelzflorian.de;
        s=mail; t=1649234645;
        bh=AVasa5UeuOhsEhjAmTJ/rjg1ZyGbQ8/okZWUXQEDn3w=;
        h=Date:From:To:Subject;
        b=1pJKT8+ZwAEU8BNRJ2TSF0OHsJJ0b/oSP3yDHCrBHIvl1ReW1yDTYLXGvRmV3b8fL
         m1gfpHukTSv3wqNDzQ1pXgpWvvqE85qYCh0y4mHdV12ve+BUQlLCGyqX6qAMPt66Ny
         WTn/VqQrriXYCdcYeSWYDccmf9eHAXJ8x136eLvE=
Date:   Wed, 6 Apr 2022 10:43:57 +0200
From:   Florian Pelz <pelzflorian@pelzflorian.de>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] main: Remove unused main.conf option NameResolving
Message-ID: <20220406084357.iai4k6jvg6gnnbyi@pelzflorian.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Commit 826023de5689 ("core: Create devices dynamically during
discovery") removed the last use of name_resolv.
---
 src/btd.h     | 1 -
 src/main.c    | 8 --------
 src/main.conf | 4 ----
 3 files changed, 13 deletions(-)

diff --git a/src/btd.h b/src/btd.h
index d13646889..c11076cce 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -109,7 +109,6 @@ struct btd_opts {
 	struct btd_defaults defaults;
 
 	gboolean	reverse_discovery;
-	gboolean	name_resolv;
 	gboolean	debug_keys;
 	gboolean	fast_conn;
 	gboolean	refresh_discovery;
diff --git a/src/main.c b/src/main.c
index a448320c1..52fa4829b 100644
--- a/src/main.c
+++ b/src/main.c
@@ -766,13 +766,6 @@ static void parse_config(GKeyFile *config)
 	} else
 		btd_opts.reverse_discovery = boolean;
 
-	boolean = g_key_file_get_boolean(config, "General",
-						"NameResolving", &err);
-	if (err)
-		g_clear_error(&err);
-	else
-		btd_opts.name_resolv = boolean;
-
 	boolean = g_key_file_get_boolean(config, "General",
 						"DebugKeys", &err);
 	if (err)
@@ -954,7 +947,6 @@ static void init_defaults(void)
 	btd_opts.discovto = DEFAULT_DISCOVERABLE_TIMEOUT;
 	btd_opts.tmpto = DEFAULT_TEMPORARY_TIMEOUT;
 	btd_opts.reverse_discovery = TRUE;
-	btd_opts.name_resolv = TRUE;
 	btd_opts.debug_keys = FALSE;
 	btd_opts.refresh_discovery = TRUE;
 	btd_opts.name_request_retry_delay = DEFAULT_NAME_REQUEST_RETRY_DELAY;
diff --git a/src/main.conf b/src/main.conf
index 401796235..337dc77e5 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -37,10 +37,6 @@
 # Defaults to 'true'.
 #ReverseServiceDiscovery = true
 
-# Enable name resolving after inquiry. Set it to 'false' if you don't need
-# remote devices name and want shorter discovery cycle. Defaults to 'true'.
-#NameResolving = true
-
 # Enable runtime persistency of debug link keys. Default is false which
 # makes debug link keys valid only for the duration of the connection
 # that they were created for.

base-commit: 234d60423c3b8186a27b31028d4c0acb847eedb1
-- 
2.34.0

