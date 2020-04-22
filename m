Return-Path: <SRS0=vsJv=6G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7465C5518B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 17:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C1621569
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 17:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587574883;
	bh=3+N2kLgOyTEEtxz+4c1rz6ODvL1KPynT5IZuQ37AJ6o=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ueWj4xSDiWt2dLyLaKGiXUo6kZVeBihvSiisVfnraWXChLEplFWmc1VavwUYpc6VO
	 2weRN15RYlTcPRSB6vG5mUHvqclB8ZA1UD5fxbQe/LKIReVvWqMgpIXK9+dZIxwYTf
	 e0h74LqbOtgRwSsFgmVV0qwWWR6G1cjp5Sbbbay0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgDVRBW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgDVRBW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Apr 2020 13:01:22 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C57A20776
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2020 17:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587574881;
        bh=3+N2kLgOyTEEtxz+4c1rz6ODvL1KPynT5IZuQ37AJ6o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RQd2uCJ1JYA2WC8mlybio3MG22wLChs7J4EEGjeLNzT7yWL/sdlKScmnWOA1oYpD2
         pvr6LGzNbkSV92XXs1fABV3Ua3+jWd3nXvkmz3P307/MC1KIqPuf575zaZ2n61lTPT
         mpTNdfjb52WyhCayyMkU4Jwzv3aSXF0C9mWhxBMM=
Received: by pali.im (Postfix)
        id E76CA7E6; Wed, 22 Apr 2020 19:01:19 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] profile: Fix reporting error message when connection failed
Date:   Wed, 22 Apr 2020 19:01:05 +0200
Message-Id: <20200422170105.29685-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422170105.29685-1-pali@kernel.org>
References: <20200422170105.29685-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some bluetooth headsets do not support connecting more then one bluetooth
profile (e.g. in parallel A2DP and HSP, or HSP and HFP) and issuing
connect() syscall for second profile returns just ECONNREFUSED.

Prior this patch bluetooth daemon for such situation reported following
message to log:

  Unable to get connect data for Headset Voice gateway: getpeername: Transport endpoint is not connected (107)

Message is incorrect as connect() syscall failed, not getpeername(). This
patch fixes this problem and logs correct error message:

  Headset Voice gateway failed connect to XX:XX:XX:XX:XX:XX: Connection refused (111)

Main problem was in ext_connect() function which called bt_io_get() for
retrieving remote address (BT_IO_OPT_DEST) and if it failed then original
error from connect() syscall was masked. Because it is not possible to
retrieve BT_IO_OPT_DEST for unconnected socket, original destination
address for error message is propagated via connect_add() function in btio.

---

Having correct error message in logs is important. Due to this mangled
error message I was not able to easily debug why particular bluetooth
headset sometimes connection with nonsense error that Transport endpoint
was not connected.
---
 src/profile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index c2992e795..6961a107b 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1085,12 +1085,13 @@ static void ext_connect(GIOChannel *io, GError *err, gpointer user_data)
 	if (!bt_io_get(io, &io_err,
 				BT_IO_OPT_DEST, addr,
 				BT_IO_OPT_INVALID)) {
-		error("Unable to get connect data for %s: %s", ext->name,
-							io_err->message);
 		if (err) {
+			error("%s failed %s", ext->name, err->message);
 			g_error_free(io_err);
 			io_err = NULL;
 		} else {
+			error("Unable to get connect data for %s: %s",
+				ext->name, io_err->message);
 			err = io_err;
 		}
 		goto drop;
-- 
2.20.1

