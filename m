Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421751B21AD;
	Wed, 12 Feb 2025 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375997; cv=none; b=oo92iWeJ3wRgGZar/nvTI4VXAsxeJbdTiy/hS+bRe+zZRdRZjfnfxRYOYUJF3vuxMDuP3kCyzcWYFN13zo85pTs2grkJOwtaB7YlgOybbs9kHW6tAYObVy+WIExlPCyl3U8l2u21P8liXEYVgIPwL/8jAd9lIzpk9if5afA7Cn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375997; c=relaxed/simple;
	bh=h35x/vPAYPaEa4YfRFZHNO8sYIWuwKkhmz7US0+DHzY=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=qi+FSVUI4gCPirmaDX5BEg1AqnuwRcp9kN3LAf3GFtkzGOi0q3ucsF81lkyzfPxte9VSKx6zvwp2uhmHdYZqcwsg4XpfQiKcxv/3MPUphM5p0+K7jJ9bnR/QXOiMvwV+/+i0eAHUW9Y6NJUvPC1DpUxoVy+MwiVoGCbWuC7uvzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=BUPk3eIy; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="BUPk3eIy"
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id F3CBD120007;
	Wed, 12 Feb 2025 18:59:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru F3CBD120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1739375986;
	bh=WyvPakyTUc2Q29OyeZulbuPY927KmB7S4czuEX4OzwM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:From;
	b=BUPk3eIyECke2O7fP5XD8FYkOqQZZGeVoGly5SQhUb6y6lfWbE37WlcdeY5bvF9ut
	 WrVrD63Tp7NfkiRPUbKvaGCCHkAKbKBviwHKWwq7qZug2gxP2Urn1+5k3DOmhAStab
	 YYe7hlKHK6OfaJWdJv/bXoSBhd57JddH9B/Vq9u8FOl9YgXZFCip+Yqq2ULklNr3hu
	 1kxCf7CZYiIh8Wrp/nC6MH1B48AmCknLU1ONt2fPiJbbhDxEXwv/4Em4LGDeoB8sEr
	 vq8lRs6qmYtSqLoctIC9O/x1GNU1qenS4yDThsAFy+HhCYpX1IX0YseX9sSdyb6CxG
	 oSlNgaiwHPgng==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 12 Feb 2025 18:59:46 +0300 (MSK)
Message-ID: <c7f1e8e5-e752-9ea7-ffe7-0ecc282bd92a@salutedevices.com>
Date: Wed, 12 Feb 2025 18:59:46 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <oxffffaa@gmail.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: [RESEND PATCH v1] Bluetooth: hci_uart: fix race during initialization
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 190971 [Feb 12 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2025/02/12 15:14:00
X-KSMG-LinksScanning: Clean, bases: 2025/02/12 15:14:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/02/12 14:25:00 #27188103
X-KSMG-AntiVirus-Status: Clean, skipped

Do not set 'HCI_UART_PROTO_READY' before call 'hci_uart_register_dev()'.
Possible race is when someone calls 'hci_tty_uart_close()' after this bit
is set, but 'hci_uart_register_dev()' wasn't done. This leads to access
to uninitialized fields. To fix it let's set this bit after device was
registered (as before patch c411c62cc133) and to fix previous problem let's
add one more bit in addition to 'HCI_UART_PROTO_READY' which allows to
perform power up without original bit set (pls see commit c411c62cc133).

Crash backtrace from syzbot report:

RIP: 0010:skb_queue_empty_lockless include/linux/skbuff.h:1887 [inline]
RIP: 0010:skb_queue_purge_reason+0x6d/0x140 net/core/skbuff.c:3936

Call Trace:
 <TASK>
 skb_queue_purge include/linux/skbuff.h:3364 [inline]
 mrvl_close+0x2f/0x90 drivers/bluetooth/hci_mrvl.c:100
 hci_uart_tty_close+0xb6/0x120 drivers/bluetooth/hci_ldisc.c:557
 tty_ldisc_close drivers/tty/tty_ldisc.c:455 [inline]
 tty_ldisc_kill+0x66/0xc0 drivers/tty/tty_ldisc.c:613
 tty_ldisc_release+0xc9/0x120 drivers/tty/tty_ldisc.c:781
 tty_release_struct+0x10/0x80 drivers/tty/tty_io.c:1690
 tty_release+0x4ef/0x640 drivers/tty/tty_io.c:1861
 __fput+0x86/0x2a0 fs/file_table.c:450
 task_work_run+0x82/0xb0 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xa3/0x1b0 kernel/entry/common.c:218
 do_syscall_64+0x9a/0x190 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Reported-by: syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com
Tested-by: syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/d159c57f-8490-4c26-79da-6ad3612c4a14@salutedevices.com/
Fixes: c411c62cc133 ("Bluetooth: hci_uart: fix race during initialization")
---
 drivers/bluetooth/hci_ldisc.c | 20 ++++++++++++++------
 drivers/bluetooth/hci_uart.h  |  1 +
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 2651e2e33f2a1..2f322f890b81f 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -102,7 +102,8 @@ static inline struct sk_buff *hci_uart_dequeue(struct hci_uart *hu)
 	if (!skb) {
 		percpu_down_read(&hu->proto_lock);
 
-		if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+		if (test_bit(HCI_UART_PROTO_READY, &hu->flags) ||
+		    test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 			skb = hu->proto->dequeue(hu);
 
 		percpu_up_read(&hu->proto_lock);
@@ -124,7 +125,8 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
 	if (!percpu_down_read_trylock(&hu->proto_lock))
 		return 0;
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
+	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 		goto no_schedule;
 
 	set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
@@ -278,7 +280,8 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	percpu_down_read(&hu->proto_lock);
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
+	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags)) {
 		percpu_up_read(&hu->proto_lock);
 		return -EUNATCH;
 	}
@@ -585,7 +588,8 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
 	if (tty != hu->tty)
 		return;
 
-	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+	if (test_bit(HCI_UART_PROTO_READY, &hu->flags) ||
+	    test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 		hci_uart_tx_wakeup(hu);
 }
 
@@ -611,7 +615,8 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 
 	percpu_down_read(&hu->proto_lock);
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
+	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags)) {
 		percpu_up_read(&hu->proto_lock);
 		return;
 	}
@@ -707,13 +712,16 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
 	hu->proto = p;
 
-	set_bit(HCI_UART_PROTO_READY, &hu->flags);
+	set_bit(HCI_UART_PROTO_INIT, &hu->flags);
 
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		return err;
 	}
 
+	set_bit(HCI_UART_PROTO_READY, &hu->flags);
+	clear_bit(HCI_UART_PROTO_INIT, &hu->flags);
+
 	return 0;
 }
 
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index fbf3079b92a53..5ea5dd80e297c 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -90,6 +90,7 @@ struct hci_uart {
 #define HCI_UART_REGISTERED		1
 #define HCI_UART_PROTO_READY		2
 #define HCI_UART_NO_SUSPEND_NOTIFIER	3
+#define HCI_UART_PROTO_INIT		4
 
 /* TX states  */
 #define HCI_UART_SENDING	1
-- 
2.30.1
