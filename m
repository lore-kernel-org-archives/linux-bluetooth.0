Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A43DC00140
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Aug 2022 23:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbiHLXNj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Aug 2022 19:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbiHLXNi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Aug 2022 19:13:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2B9624A
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 16:13:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so2145523pjf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 16:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=RStGGcDKITWdWe34/F4N5zObYtW4KjBM6CFuKQxFKLk=;
        b=Uo0zZ63HTUOpqBqDgWNAoPQ+2aUFTQeu8GPOJlUK3+q9CkWyrgbt006Xx+pQEd4FYS
         SFmrQJyGuJ7p6v+PMJPImOFLqglmII2ssHIBadA5VJ/RBedRY6MbNB8Uuna3aKLqxykS
         xG37haSnymOFUXBGQLPxfbpEg3m7HBkpHFUBHb2U3bbdYQk/kktxnv5ZEWr+m1MQoC8U
         aEzc+KPYyMpcwQrBMhiHeHVxM1zbU4uI7cOkIKmo1QsMgtxQY0Xt8o5OSP9qxTGDO0H8
         iNyqcN3aSARgo42i0Xc0V1VBk4etUpTPHi9ZCpb0ovacJsBVc8o15Pi4lrZaY+a5PH5S
         5nIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=RStGGcDKITWdWe34/F4N5zObYtW4KjBM6CFuKQxFKLk=;
        b=otqTVxf/aO+O83ySK9mHbCyeBnGxBm6iceQynwPe+zPpcwBttqOtadQuFCwR2T44BO
         7ywCLgxBAmuLAmXncRzBg8ilt6BdanKnQKstyJJhuIi3IV9WS4frFakpwusi8Qb8hE9S
         kBdML4yC/u0ONjtfCRbp1TPAdgfPuMKc/IvuOErgb9V7dCCP5vQeeys+HX8GV5nHOm5O
         Bu4yi3/NutqsgBdix23e91yriPpHipTJSG+jpdE73RcsxS3VA1eRm/3okn3ibH61LTK9
         4fM3RsG8KAYNYr8rz1HIbs7Q+nlwblwkc1IxKsiU11W+yJnYM6HjWQ+HNEjy2VsB4Qiu
         bGiQ==
X-Gm-Message-State: ACgBeo1/sfpSM9IAvPt7rfGKbsZR2iWOmI+KxUt8zQDnqABE3sOhzX3j
        chL44lEcV29nIuy4vcM28pw91LqZfdw0pQ==
X-Google-Smtp-Source: AA6agR591991X3wQGJDcJ9sh0PamjR6F7NHCq73Q2um8hXlyT8dSwCXtIqzTm8DjxYCr5xWirZdstw==
X-Received: by 2002:a17:90a:590e:b0:1f2:2184:6893 with SMTP id k14-20020a17090a590e00b001f221846893mr16404536pji.57.1660346013317;
        Fri, 12 Aug 2022 16:13:33 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b0016a0bf0ce32sm2326217plg.70.2022.08.12.16.13.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 16:13:32 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix build errors in some archs
Date:   Fri, 12 Aug 2022 16:13:29 -0700
Message-Id: <20220812231329.540559-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to fix the follow errors:

In function 'memcmp',
    inlined from 'bacmp' at ./include/net/bluetooth/bluetooth.h:347:9,
    inlined from 'l2cap_global_chan_by_psm' at
    net/bluetooth/l2cap_core.c:2003:15:
./include/linux/fortify-string.h:44:33: error: '__builtin_memcmp'
specified bound 6 exceeds source size 0 [-Werror=stringop-overread]
   44 | #define __underlying_memcmp     __builtin_memcmp
      |                                 ^
./include/linux/fortify-string.h:420:16: note: in expansion of macro
'__underlying_memcmp'
  420 |         return __underlying_memcmp(p, q, size);
      |                ^~~~~~~~~~~~~~~~~~~
In function 'memcmp',
    inlined from 'bacmp' at ./include/net/bluetooth/bluetooth.h:347:9,
    inlined from 'l2cap_global_chan_by_psm' at
    net/bluetooth/l2cap_core.c:2004:15:
./include/linux/fortify-string.h:44:33: error: '__builtin_memcmp'
specified bound 6 exceeds source size 0 [-Werror=stringop-overread]
   44 | #define __underlying_memcmp     __builtin_memcmp
      |                                 ^
./include/linux/fortify-string.h:420:16: note: in expansion of macro
'__underlying_memcmp'
  420 |         return __underlying_memcmp(p, q, size);
      |                ^~~~~~~~~~~~~~~~~~~

Fixes: 332f1795ca20 ("Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm regression")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1c39fc40591b..2c9de67daadc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1992,8 +1992,7 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 			src_match = !bacmp(&c->src, src);
 			dst_match = !bacmp(&c->dst, dst);
 			if (src_match && dst_match) {
-				c = l2cap_chan_hold_unless_zero(c);
-				if (!c)
+				if (!l2cap_chan_hold_unless_zero(c))
 					continue;
 
 				read_unlock(&chan_list_lock);
-- 
2.37.1

