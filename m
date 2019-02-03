Return-Path: <SRS0=2HOV=QK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAE0C169C4
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 Feb 2019 19:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C7A217D9
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 Feb 2019 19:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549222730;
	bh=qtLx2MrdEkYUL9M1xn3knkJJkaSZWJmiAJJEcR+Rblk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=OmI0mZZ6k8pp4q2XLm74AKbdM9QfCy9B4/REx+u9Xyt8MQE45v7PZ48TkqOZmFTTC
	 djtfANOJE5Ii+xlWvyckVIex4Lj60YBwR2siD+MeigTfACEmsRDeaJDcoJzNfJk6a9
	 +Cagk9aGhEdSV7i4l5pEUdBDtmhonZWcRBwO5oVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfBCTiu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 3 Feb 2019 14:38:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfBCTiu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 3 Feb 2019 14:38:50 -0500
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0957D21773;
        Sun,  3 Feb 2019 19:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549222729;
        bh=qtLx2MrdEkYUL9M1xn3knkJJkaSZWJmiAJJEcR+Rblk=;
        h=From:To:Cc:Subject:Date:From;
        b=ifNRVXYYs94Q8yoZJ3xaIjPONhWGB99p1MR0DjLoFlF+avrzV9Jir2y/PDpz/lBLh
         u4xKKcAwimgsT9WZ0HJPickHcLJcCeTYnb5JTBdx55mimEJs+9T3w8iYIuJFu/4el0
         pS6p/SIH95GbT4LJC/L6k8xPI1ANeMdvdStlKWNk=
From:   Shuah Khan <shuah@kernel.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        viro@zeniv.linux.org.uk
Cc:     Shuah Khan <shuah@kernel.org>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] bluetooth: Fix WARNING in tty_set_termios()
Date:   Sun,  3 Feb 2019 12:38:48 -0700
Message-Id: <20190203193848.12959-1-shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tty_set_termios() has the following WARN_ON which can be triggered with a
syscall to invoke TIOCSETD __NR_ioctl.

WARN_ON(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
                tty->driver->subtype == PTY_TYPE_MASTER);
Reference: https://syzkaller.appspot.com/bug?id=2410d22f1d8e5984217329dd0884b01d99e3e48d

"The problem started with commit 7721383f4199 ("Bluetooth: hci_uart: Support
operational speed during setup") which introduced a new way for how
tty_set_termios() could end up being called for a master pty."

Fix it by by preventing setting the HCI line discipline for PTYs in
hci_uart_tty_open().

Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
Cc: Johan Hovold <johan@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 drivers/bluetooth/hci_ldisc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index fbf7b4df23ab..c8faa4759cb7 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -475,9 +475,9 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	BT_DBG("tty %p", tty);
 
 	/* Error if the tty has no write op instead of leaving an exploitable
-	 * hole
+	 * hole. In addition check if setting HCI line discipline is allowed.
 	 */
-	if (tty->ops->write == NULL)
+	if (tty->ops->write == NULL || tty->ops->set_termios == NULL)
 		return -EOPNOTSUPP;
 
 	hu = kzalloc(sizeof(struct hci_uart), GFP_KERNEL);
-- 
2.17.1

