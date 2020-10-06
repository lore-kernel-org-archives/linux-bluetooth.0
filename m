Return-Path: <SRS0=Tswr=DN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B28C41604
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 15:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955D0206F7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 15:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=grimler.se header.i=@grimler.se header.b="sAHglIpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJFP45 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 11:56:57 -0400
Received: from h03mx16.reliablemail.org ([173.236.90.20]:55003 "EHLO
        h03mx16.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgJFP45 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 11:56:57 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2020 11:56:56 EDT
X-Halon-Out: b66b1d7d-07eb-11eb-b0ed-00163c72d6d3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TA8ay0E5BcP+kFMJ17ivkv6yP/Fj818taHWurrPb7JI=; b=sAHglIpgDDQpD9A6Zhgpn2GTyv
        6foHbeSJDMKF9XvBk36xj8ta0A/ApX0tgUp78ceL4DkHuuSXHPZkW6lUo8LoyxmOd+eNF/XcTo96h
        xXo5eVqeszo54S57pRtv3xV56q70LWMkk/AJAoyPJUi8iFA+QYIvscFgOaMpOAgPcp00AsJPG7ItH
        5xS0yZV3KAOcuitMygceN/4f1nyJxzSD1+1ru+n/3af5YTRpoJuTXPKXTjXewi0hRIjqUrfVps5Ip
        HsvyNxS0V3E/FyCRpoPo5kl3gffHtxpGBSVJFdKnx87mefb7LoeH7QtJC9EZNZXQF4+0PIRhDTAaB
        QpByzDiQ==;
From:   Henrik Grimler <henrik@grimler.se>
To:     linux-bluetooth@vger.kernel.org
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH BlueZ v3] tools: fix forgotten index->mgmt_index renaming in btmgmt.c
Date:   Tue,  6 Oct 2020 17:50:34 +0200
Message-Id: <20201006155034.126914-1-henrik@grimler.se>
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

Commit 6523d168a7c1 ("tools/btmgmt: Port to use bt_shell") seem to
have missed this.  When trying to compile bluez I get:

```
tools/btmgmt.c:1229:34: warning: implicitly declaring library function 'index' \
with type 'char *(const char *, int)' [-Wimplicit-function-declaration]
                                config_info_rsp, UINT_TO_PTR(index), NULL)) {
                                                             ^
tools/btmgmt.c:1229:34: note: include the header <strings.h> or explicitly \
provide a declaration for 'index'
[...]
aarch64-linux-android-ld: tools/btmgmt.o: in function `cmd_config':
btmgmt.c:(.text+0x544): undefined reference to `index'
aarch64-linux-android-ld: btmgmt.c:(.text+0x548): undefined reference to `index'
```

Probably only happens on system (like android) where the obsolete
index function does not exist.

---
Changes in v3:
- Ensure lines in code are < 80 characters as well

Changes in v2:
- Update commit message to make lint bot happy

 tools/btmgmt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index b0b837d34..9daa58c54 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1212,8 +1212,9 @@ static void cmd_config(int argc, char **argv)
 		return;
 	}
 
-	if (!mgmt_send(mgmt, MGMT_OP_READ_CONFIG_INFO, mgmt_index, 0, NULL,
-				config_info_rsp, UINT_TO_PTR(index), NULL)) {
+	if (!mgmt_send(mgmt, MGMT_OP_READ_CONFIG_INFO, mgmt_index,
+				0, NULL, config_info_rsp,
+				UINT_TO_PTR(mgmt_index), NULL)) {
 		error("Unable to send read_config_info cmd");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
-- 
2.28.0

