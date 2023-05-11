Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBDDC7EE22
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 May 2023 00:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjEKAai (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 May 2023 20:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjEKAag (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 May 2023 20:30:36 -0400
X-Greylist: delayed 440 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 17:30:34 PDT
Received: from out-3.mta1.migadu.com (out-3.mta1.migadu.com [95.215.58.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050511B1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 17:30:34 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ayaya.dev; s=key1;
        t=1683764593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gzTvq8trq8+ayndhr/Duw6DZGZUXmqCeCaWsKHRmxEU=;
        b=RgROUtxZn5M+qPIuYCsAxnD0BTkWmuwAJCGefRNwIQJ4mpN5PtxfQ2Aau5IKiLrBAGWNLC
        e1c+nHj4eKPhF2T9C01gJ5f4ulJmRMPAl2rOG5kIuCTkZdQCNhXc4Q6hVZISiZ02JZlHhN
        e0a2npGaU5PGkgygqdToNWb5H+K5hs8=
From:   psykose <alice@ayaya.dev>
To:     linux-bluetooth@vger.kernel.org
Cc:     alice@ayaya.dev
Subject: [PATCH BlueZ 2/3] client/player: use long long for off_t print
Date:   Thu, 11 May 2023 02:22:51 +0200
Message-Id: <20230511002252.30868-2-alice@ayaya.dev>
In-Reply-To: <20230511002252.30868-1-alice@ayaya.dev>
References: <20230511002252.30868-1-alice@ayaya.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

%lld is guaranteed to be a 64-bit int, which we enforce via
-D_FILE_OFFSET_BITS=64.

Signed-off-by: psykose <alice@ayaya.dev>
---
 client/player.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index 7719076c8..856997319 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3578,7 +3578,7 @@ static int transport_send_seq(struct transport *transport, int fd, uint32_t num)
 
 		offset = lseek(fd, 0, SEEK_CUR);
 
-		bt_shell_echo("[seq %d %d.%03ds] send: %zd/%zd bytes",
+		bt_shell_echo("[seq %d %d.%03ds] send: %lld/%lld bytes",
 				transport->seq, secs,
 				(nsecs + 500000) / 1000000,
 				offset, transport->stat.st_size);
-- 
2.40.1

