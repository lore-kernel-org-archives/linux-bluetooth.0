Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CB6C00144
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jul 2022 02:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiG0C2A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jul 2022 22:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiG0C16 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jul 2022 22:27:58 -0400
X-Greylist: delayed 566 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Jul 2022 19:27:57 PDT
Received: from mx1.librem.one (mx1.librem.one [138.201.176.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1A03C8CD
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jul 2022 19:27:57 -0700 (PDT)
Received: from smtp.librem.one (unknown [192.241.214.14])
        by mx1.librem.one (Postfix) with ESMTPS id ED1E181E8E
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jul 2022 19:18:27 -0700 (PDT)
Authentication-Results: name mx1.librem.one; dmarc=fail (p=none dis=none) header.from=librem.one
Authentication-Results: mx1.librem.one;
        dkim=pass (2048-bit key; unprotected) header.d=librem.one header.i=@librem.one header.b="FR7KMZUb";
        dkim-atps=neutral
From:   Zach DeCook <zachdecook@librem.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=librem.one; s=smtp;
        t=1658888305; bh=v1a+dKwrV3CxewJ0OEAzU3FuVV7SRlsmaeyaUFvVn2w=;
        h=From:To:Cc:Subject:Date:From;
        b=FR7KMZUbyZEOlj4y67mpj7axpwXbPDnvGQfn9BEKkiyiUP+fofV/oaU//PPC0UntJ
         otic8CKZKSe6kRhaWF6DwY7bdL/dptYcCSoAs3k/KEaCgXqJZK0BK5Fc2D/8S0myRg
         heKXi0sjHxgNG5YBK/KtO9WeWzzT9n0uWuSGuKa9H5oCOocMxtbuU+zksmM2PtHJ4Z
         ow2kmxA/4fCviynoh2EMf6aL73aCiJSLoSYrilR1vOl24gCq/FgTh8FLTn/4f7fVJb
         xI0AAtP8IOz8bRwxL0O0VAOx/wtot5Pti1iLA8DGQAMJ1rd5LQx1xvj4LkCq0aPeUs
         jRlgvFEx4Eesg==
To:     linux-bluetooth@vger.kernel.org
Cc:     Zach DeCook <zachdecook@librem.one>
Subject: [PATCH] dbus-common: Add icon for watches
Date:   Tue, 26 Jul 2022 22:18:01 -0400
Message-Id: <20220727021801.3564-1-zachdecook@librem.one>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 src/dbus-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/dbus-common.c b/src/dbus-common.c
index 5e2c83d52..a4b6eccfb 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -123,6 +123,8 @@ const char *gap_appearance_to_icon(uint16_t appearance)
 		return "phone";
 	case 0x02:
 		return "computer";
+	case 0x03:
+		return "watch";
 	case 0x05:
 		return "video-display";
 	case 0x0a:
-- 
2.36.2

