Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C84AECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 14:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiH2O6u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 10:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2O6t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 10:58:49 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA8986C33
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 07:58:46 -0700 (PDT)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 27TEwGpj081025;
        Mon, 29 Aug 2022 23:58:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Mon, 29 Aug 2022 23:58:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 27TEwFNw081022
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 29 Aug 2022 23:58:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <376d3dd4-725a-a212-2701-09a80b7d3915@I-love.SAKURA.ne.jp>
Date:   Mon, 29 Aug 2022 23:58:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: [PATCH] Bluetooth: hci_{ldisc,serdev}: check percpu_init_rwsem()
 failure
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ronald Tschalar <ronald@innovation.ch>,
        Lukas Wunner <lukas@wunner.de>
References: <000000000000bd19720591aac025@google.com>
 <0000000000003a22d605934b6722@google.com>
Cc:     syzbot <syzbot+576dfca25381fb6fbc5f@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000003a22d605934b6722@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot is reporting NULL pointer dereference at hci_uart_tty_close() [1],
for rcu_sync_enter() is called without rcu_sync_init() due to
hci_uart_tty_open() ignoring percpu_init_rwsem() failure.

While we are at it, fix that hci_uart_register_device() ignores
percpu_init_rwsem() failure and hci_uart_unregister_device() does not
call percpu_free_rwsem().

Link: https://syzkaller.appspot.com/bug?extid=576dfca25381fb6fbc5f [1]
Reported-by: syzbot <syzbot+576dfca25381fb6fbc5f@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 67d2f8781b9f00d1 ("Bluetooth: hci_ldisc: Allow sleeping while proto locks are held.")
Fixes: d73e172816652772 ("Bluetooth: hci_serdev: Init hci_uart proto_lock to avoid oops")
---
 drivers/bluetooth/hci_ldisc.c  |  7 +++++--
 drivers/bluetooth/hci_serdev.c | 10 +++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index f537673ede17..865112e96ff9 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -493,6 +493,11 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 		BT_ERR("Can't allocate control structure");
 		return -ENFILE;
 	}
+	if (percpu_init_rwsem(&hu->proto_lock)) {
+		BT_ERR("Can't allocate semaphore structure");
+		kfree(hu);
+		return -ENOMEM;
+	}
 
 	tty->disc_data = hu;
 	hu->tty = tty;
@@ -505,8 +510,6 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	INIT_WORK(&hu->init_ready, hci_uart_init_work);
 	INIT_WORK(&hu->write_work, hci_uart_write_work);
 
-	percpu_init_rwsem(&hu->proto_lock);
-
 	/* Flush any pending characters in the driver */
 	tty_driver_flush_buffer(tty);
 
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index c0e5f42ec6b7..f16fd79bc02b 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -310,11 +310,12 @@ int hci_uart_register_device(struct hci_uart *hu,
 
 	serdev_device_set_client_ops(hu->serdev, &hci_serdev_client_ops);
 
+	if (percpu_init_rwsem(&hu->proto_lock))
+		return -ENOMEM;
+
 	err = serdev_device_open(hu->serdev);
 	if (err)
-		return err;
-
-	percpu_init_rwsem(&hu->proto_lock);
+		goto err_rwsem;
 
 	err = p->open(hu);
 	if (err)
@@ -389,6 +390,8 @@ int hci_uart_register_device(struct hci_uart *hu,
 	p->close(hu);
 err_open:
 	serdev_device_close(hu->serdev);
+err_rwsem:
+	percpu_free_rwsem(&hu->proto_lock);
 	return err;
 }
 EXPORT_SYMBOL_GPL(hci_uart_register_device);
@@ -410,5 +413,6 @@ void hci_uart_unregister_device(struct hci_uart *hu)
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 		serdev_device_close(hu->serdev);
 	}
+	percpu_free_rwsem(&hu->proto_lock);
 }
 EXPORT_SYMBOL_GPL(hci_uart_unregister_device);
-- 
2.18.4

