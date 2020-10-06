Return-Path: <SRS0=Tswr=DN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976CEC41604
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 14:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8D1206DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 14:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=grimler.se header.i=@grimler.se header.b="geb6CJRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgJFOeu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 10:34:50 -0400
Received: from h01mx15.reliablemail.org ([173.236.5.211]:16650 "EHLO
        h01mx15.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJFOeu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 10:34:50 -0400
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2020 10:34:49 EDT
X-Halon-Out: 3e6bd01e-07e0-11eb-b845-00163c81f1a9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=r3iwX3l2VivD81ERmRAV4CarF37vHS5r47MdNOdSuCE=; b=geb6CJRKB+z7GjxyBEvON6Q3Qm
        DNmqhEDRa7THs2QAp+ZEAueqe/LgSG+X8bCqM+AlRh17NRlQSqscrCcElmTYOC4AzV6R/1Kldihle
        ky7fe2sDnIp7vblpb3GSL80Rz9xUpkFvdoVsjOM4CD0X8xzr2jQfFHyukb204DD1CRAYIHP/7Ujhu
        ua4mojH158ZnE4llKR9fL1lidwEDtFhUAzOKmhd+PIYYiB2gMJ0gp+oLm/xa4+09lllubbbxUGHaC
        raK9OIl3H57dBcIbXmUop/Ir1Pr3pzhjaCr72HCe7Ay5hb302gUJ9bwSUz19WFoiRm+aHLSxpUcLr
        t6sKXtpQ==;
From:   Henrik Grimler <henrik@grimler.se>
To:     linux-bluetooth@vger.kernel.org
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH BlueZ 1/1] tools: fix forgotten index->mgmt_index renaming in btmgmt.c
Date:   Tue,  6 Oct 2020 16:28:36 +0200
Message-Id: <20201006142836.123490-1-henrik@grimler.se>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpsrv07.misshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - grimler.se
X-Get-Message-Sender-Via: cpsrv07.misshosting.com: authenticated_id: henrik@grimler.se
X-Authenticated-Sender: cpsrv07.misshosting.com: henrik@grimler.se
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Commit 6523d168a7c1bdb886fbf42e8a810ed15e5ec0e2 renamed the variable
index to mgmt_index but missed it in one place.  When trying to
compile bluez I get:

```
/data/data/com.termux/files/home/.termux-build/libbluetooth/src/tools/btmgmt.c:1229:34: warning: implicitly declaring library function 'index' with type 'char *(const char *, int)' [-Wimplicit-function-declaration]
                                config_info_rsp, UINT_TO_PTR(index), NULL)) {
                                                             ^
/data/data/com.termux/files/home/.termux-build/libbluetooth/src/tools/btmgmt.c:1229:34: note: include the header <strings.h> or explicitly provide a declaration for 'index'
[...]
/data/data/com.termux/files/usr/bin/aarch64-linux-android-ld: tools/btmgmt.o: in function `cmd_config':
btmgmt.c:(.text+0x544): undefined reference to `index'
/data/data/com.termux/files/usr/bin/aarch64-linux-android-ld: btmgmt.c:(.text+0x548): undefined reference to `index'
```

This seem to only happens on system (like android) where the obsolete
index function is not defined.

---
 tools/btmgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index b0b837d34..228f94efa 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1213,7 +1213,7 @@ static void cmd_config(int argc, char **argv)
 	}
 
 	if (!mgmt_send(mgmt, MGMT_OP_READ_CONFIG_INFO, mgmt_index, 0, NULL,
-				config_info_rsp, UINT_TO_PTR(index), NULL)) {
+				config_info_rsp, UINT_TO_PTR(mgmt_index), NULL)) {
 		error("Unable to send read_config_info cmd");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
-- 
2.28.0

