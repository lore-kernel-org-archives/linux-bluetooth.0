Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE8BC43217
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Nov 2022 16:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiKKQo7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Nov 2022 11:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiKKQo6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Nov 2022 11:44:58 -0500
X-Greylist: delayed 1241 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Nov 2022 08:44:56 PST
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55166659B
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Nov 2022 08:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1668183833; bh=/Xl/HIo/bA+evsaq8DnE04LwbrBrmlhLVkw50rtDhtM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=n7KPh4EVxRV/1s0qZhvnYgK/lDzUhSPnlB177nJc907rOdL7sgtSXvfbw/sNy9Jjg
         /oB4kM8oCzqeLEPwN+tF7XLI8HwoP88gsk+OuAJK2AAFqbCXFjTOIMY3V1J7PlezJH
         TVRakl92HmQu44G6RXlmsKXwLXjspuv2P2SjJOU0=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 11 Nov 2022 17:23:53 +0100 (CET)
X-EA-Auth: y26A4/b47mvI+T4pBWOPntJAL2IpHjodAiXkAKUUlM2VT0sQ1jpSq3WzrIiwQtmb/c0ujW+FsdQWFt1siJbKcfQitro45GaR
Date:   Fri, 11 Nov 2022 21:53:46 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     drv@mailo.com
Subject: [PATCH] Bluetooth: hci_conn: Use kzalloc for kmalloc+memset
Message-ID: <Y253EjjM0yvRGl+M@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use of kzalloc preferred over combination of kmalloc & memset. Issue
identified using coccicheck.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 net/bluetooth/hci_conn.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7a59c4487050..287d313aa312 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -824,11 +824,10 @@ static int hci_le_terminate_big(struct hci_dev *hdev, u8 big, u8 bis)

 	bt_dev_dbg(hdev, "big 0x%2.2x bis 0x%2.2x", big, bis);

-	d = kmalloc(sizeof(*d), GFP_KERNEL);
+	d = kzalloc(sizeof(*d), GFP_KERNEL);
 	if (!d)
 		return -ENOMEM;

-	memset(d, 0, sizeof(*d));
 	d->big = big;
 	d->bis = bis;

@@ -861,11 +860,10 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, u16 sync_handle)

 	bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big, sync_handle);

-	d = kmalloc(sizeof(*d), GFP_KERNEL);
+	d = kzalloc(sizeof(*d), GFP_KERNEL);
 	if (!d)
 		return -ENOMEM;

-	memset(d, 0, sizeof(*d));
 	d->big = big;
 	d->sync_handle = sync_handle;

--
2.34.1



