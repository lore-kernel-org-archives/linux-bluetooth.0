Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA69C38A02
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Oct 2022 07:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJ3HHt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Oct 2022 03:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3HHs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Oct 2022 03:07:48 -0400
X-Greylist: delayed 454 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Oct 2022 00:07:47 PDT
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99E4A22E
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Oct 2022 00:07:47 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id p2IeoVZUdBDYDp2IfocVDE; Sun, 30 Oct 2022 08:00:07 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 30 Oct 2022 08:00:07 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix EALREADY and ELOOP cases in bt_status()
Date:   Sun, 30 Oct 2022 08:00:03 +0100
Message-Id: <9a1270540f0c2db13e81a9d69098391f1ad22107.1667113164.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

'err' is known to be <0 at this point.

So, some cases can not be reached because of a missing "-".
Add it.

Fixes: ca2045e059c3 ("Bluetooth: Add bt_status")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/bluetooth/lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index 469a0c95b6e8..53a796ac078c 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -170,7 +170,7 @@ __u8 bt_status(int err)
 	case -EMLINK:
 		return 0x09;
 
-	case EALREADY:
+	case -EALREADY:
 		return 0x0b;
 
 	case -EBUSY:
@@ -191,7 +191,7 @@ __u8 bt_status(int err)
 	case -ECONNABORTED:
 		return 0x16;
 
-	case ELOOP:
+	case -ELOOP:
 		return 0x17;
 
 	case -EPROTONOSUPPORT:
-- 
2.34.1

