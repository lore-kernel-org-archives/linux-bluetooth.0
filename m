Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00752EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jul 2023 17:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjGKRs4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jul 2023 13:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGKRsz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jul 2023 13:48:55 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 10:48:53 PDT
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9880E3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 10:48:53 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id JHMVqjHlJfeeSJHMVqss1D; Tue, 11 Jul 2023 19:41:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689097281;
        bh=YoD+Ttv8p1Nh3mEyaQHiXi8KW24Liu1RyHhVbajtzok=;
        h=From:To:Cc:Subject:Date;
        b=oR2zg4513ehzhFQ6QP9nOz7MGNj5YBwormiQ/aYH5QNhZN1YB+68nRpSNC0R3DKF1
         bgyfSIHJ308rDLeiI1S7AHqCJTCvQLXlXfLMsUoRBwz6abj/jtxdQtxE8IW5IlbLiL
         EpT5FYFJPbfWmXpf0LlJskNM0a4GAbapC9xW1frjA+4W+TwvgnomrkkL9A8h4bJnxb
         eORxgPgzSzA/E56+7iX2BSvvAbW/d0RRmCiYX1tOUR7UTXpiChvEzQdwRhU5uyPHFq
         JRx7izsEl0yz+xHmQy4zzF4yyGTiOqrtz9sB57qK3jqd7bG4iQR8gR9G2rFboOhuNs
         r7ATrYsjpsx/w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 11 Jul 2023 19:41:21 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     akpm@linux-foundation.org, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: hci_debugfs: Use kstrtobool() instead of strtobool()
Date:   Tue, 11 Jul 2023 19:41:10 +0200
Message-Id: <58247d1b8105739f0371030a93fb28ea3dbedc57.1673687451.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

While at it, include the corresponding header file (<linux/kstrtox.h>)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch was already sent as a part of a serie ([1]) that axed all usages
of strtobool().
Most of the patches have been merged in -next.

I synch'ed with latest -next and re-send the remaining ones as individual
patches.

Only 2 patches remain un-applied.

Changes in v3:
  - No change
  - Adding in cc: akpm@linux-foundation.org
  - Fix a duplicated Signed-off-by at the end of the "below --- section"

Changes in v2:
  - No change
  - https://lore.kernel.org/all/58207d5b81c5739c037c030893fb08ea3dbedc57.1673687451.git.christophe.jaillet@wanadoo.fr/

v1:  
[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
---
 net/bluetooth/hci_debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index b7f682922a16..f1ef60ddd4a6 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -22,6 +22,7 @@
 */
 
 #include <linux/debugfs.h>
+#include <linux/kstrtox.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -1152,7 +1153,7 @@ static ssize_t force_no_mitm_write(struct file *file,
 		return -EFAULT;
 
 	buf[buf_size] = '\0';
-	if (strtobool(buf, &enable))
+	if (kstrtobool(buf, &enable))
 		return -EINVAL;
 
 	if (enable == hci_dev_test_flag(hdev, HCI_FORCE_NO_MITM))
-- 
2.34.1

