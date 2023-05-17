Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AE5C7EE24
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 01:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjEQBnB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 May 2023 21:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjEQBm7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 May 2023 21:42:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCB03A90
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 18:42:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62CEF63C3C
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 01:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67426C433D2;
        Wed, 17 May 2023 01:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684287777;
        bh=qPchDZ4JltCfg8LHTV0e81Ry4562N+CnZS1hc8Fw2OA=;
        h=From:To:Cc:Subject:Date:From;
        b=rN7SdlpPpgGhcpn67Dcl1fcZ8EpDEpM8Do7gmj4gu4r6+3H6eNrD/lAaDxM0f+sjk
         8Sp5xGQY9T6urMKFmtCTk42mMNBR7jO7W4IC7cHrJ3gIZ/AYtiJqgb/F6XYiOSMFM0
         fVKDYQ5OLhq6DMxC9HkY4TYYW94UKIF8OyacDnVKyFm5g3qiCUp/l5lFSdvHq//ynp
         9MHhrRuaiURhg1s1EvuO6yfwrnxaKqVP/vp+ci9cVgUmdsi/M1oB6z8P7Vg5iBExJP
         3uCJ/F5nN3DXyeU38ZGWN7XLBVphUru14/RCxAPA0G3yPcgyedf53wnyl3IJYgboyY
         iPPA2hprE4Eww==
From:   Jakub Kicinski <kuba@kernel.org>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        Jakub Kicinski <kuba@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH net] MAINTAINERS: skip CCing netdev for Bluetooth patches
Date:   Tue, 16 May 2023 18:42:53 -0700
Message-Id: <20230517014253.1233333-1-kuba@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

As requested by Marcel skip netdev for Bluetooth patches.
Bluetooth has its own mailing list and overloading netdev
leads to fewer people reading it.

Link: https://lore.kernel.org/netdev/639C8EA4-1F6E-42BE-8F04-E4A753A6EFFC@holtmann.org/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: marcel@holtmann.org
CC: johan.hedberg@gmail.com
CC: luiz.dentz@gmail.com
CC: linux-bluetooth@vger.kernel.org
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a62fc5c6551..112bde4d6d26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14638,6 +14638,7 @@ F:	include/uapi/linux/netdevice.h
 F:	lib/net_utils.c
 F:	lib/random32.c
 F:	net/
+X:	net/bluetooth/
 F:	tools/net/
 F:	tools/testing/selftests/net/
 
-- 
2.40.1

