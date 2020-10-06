Return-Path: <SRS0=Tswr=DN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3598C41604
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 15:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F14C206DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 15:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=grimler.se header.i=@grimler.se header.b="E6DKhDC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgJFPZ5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 11:25:57 -0400
Received: from h04mx15.reliablemail.org ([185.76.67.208]:11511 "EHLO
        h04mx15.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgJFPZ4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 11:25:56 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2020 11:25:55 EDT
X-Halon-Out: 61426548-07e7-11eb-ae9c-016faf663c66
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MpgtNIMYLlL4bB1Pb4In1NFBTR9GjbE0/qeHo4XPlDo=; b=E6DKhDC+rj92zygarEn5qPPl19
        eyXiaab/lT+vWoZJSCI6BDwFmMfy2SlH1RRDKAj6ICEyDWtgCOytYHc0MRkmX2HDsDDxJr8wIOUFx
        f8/xBXsL39m8WZTkVY9C0bNiONKEpmPFt/RyOhdLNQlDLdbreNK0h7sRJbebZUpJUQap5BKWmvJlS
        6bvuhlefpNAdwLmAr8yKGAA8PGFjFdmIVlKmK2PiF7MVxjOQxJErGPkIS8pWQvOAwaKk6hrBWxEHk
        u1eGlGRQrMf8UlDS4ZDifeHg/8fZ5C2lW2nG8Qwz9KzNsabcacXjMkKefycghDEu8daM5E7df04rZ
        dAFK6Wlw==;
From:   Henrik Grimler <henrik@grimler.se>
To:     linux-bluetooth@vger.kernel.org
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH BlueZ v2] tools: fix forgotten index->mgmt_index renaming in btmgmt.c
Date:   Tue,  6 Oct 2020 17:19:43 +0200
Message-Id: <20201006151943.125484-1-henrik@grimler.se>
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
Changes in v2:
- Update commit message to make lint bot happy

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

