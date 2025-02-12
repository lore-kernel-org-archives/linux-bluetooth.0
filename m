Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57420767D;
	Wed, 12 Feb 2025 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353940; cv=none; b=N0OC/lucj+WogWx5m8iJpXFoAxoTPMEw3Rz7GUhFBAUaK8brrOQ3Mbn54nvBcw9gosUnvGg3qqlSQ5KHZKD+sYdAp80W0e/6qecqJvoZRRA3/rU8BMJp0y2JGgBBtWIs6BquBtrSZSEw+ZpI6cq1X8Odoe03O8yllkK7c6iwgRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353940; c=relaxed/simple;
	bh=GYQfA97F+Re9ZSkw6o6abl4T4nrI0L3AvS4GjFqwQJY=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=B22eaB8E/L3jEZ0/gcexIhBV0SM4aLvanLvDfA+Pq0N3bsmbmWCW3YjuKrzr/tzJqq1T+ttwhgU/SWUwRBbEfh8olbCgK7y2Gw+abbdGA2YdufwgQgt0jvpMzdXZ1B2JK6jal3cd5OZSJx5My31mg6HIq6849mVlOeq8cBtN4s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=EIzFg06C; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="EIzFg06C"
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 52AC6100006;
	Wed, 12 Feb 2025 12:52:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 52AC6100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1739353925;
	bh=sW1PCcHZUuvl1DQ9fYsmBNqcActrE1fmpcmadXgurpg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:From;
	b=EIzFg06Cp93s+nhZ5t7GRsS+4vXPSufXqzwY2squSDJhVXqKtva5juG5A3C0hGOay
	 OA9u0ybAZfVWwst49X7vAUN8isxFhlLXLbG7hL2QH07sUPf2Vp3HNAtZDSplrsEjv7
	 hIIup/c0bSLPLhGjnmedZd2B/PqhEDPXlH/vHsWm4icqlIjj9TpyS9K9F61hfPXtuk
	 ochDzRa8jl/MJ5Ak2k0h/2eCGZqKf2/oG7iznlzwIQdmXQOpsPF95VVeouEq19pgN9
	 KjDLfsGB0HLIOB2korDkoHDyPtk95sfLfcw+Z/DuGk0h2F1kykzPhIS8YBZKwajIOh
	 6L/9oq5AZGYYg==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 12 Feb 2025 12:52:04 +0300 (MSK)
Message-ID: <490d0026-2561-76b0-c11b-495b3e967e35@salutedevices.com>
Date: Wed, 12 Feb 2025 12:52:04 +0300
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
CC: <oxffffaa@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-bluetooth@vger.kernel.org>, <kernel@salutedevices.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: [PATCH v1] Bluetooth: hci_uart: fix race during initialization
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 190962 [Feb 12 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;lore.kernel.org:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2025/02/12 09:00:00
X-KSMG-LinksScanning: Clean, bases: 2025/02/12 08:59:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/02/12 05:46:00 #27170303
X-KSMG-AntiVirus-Status: Clean, skipped

Do not set 'HCI_UART_PROTO_READY' before call 'hci_uart_register_dev()'.
Possible race is when someone calls 'hci_tty_uart_close()' after this bit
is set, but 'hci_uart_register_dev()' wasn't done. This leads to access
to uninitialized fields. To fix it let's set this bit after device was
registered (as before patch c411c62cc133) and to fix previous problem let's
add one more bit in addition to 'HCI_UART_PROTO_READY' which allows to
perform power up without original bit set (pls see commit c411c62cc133).

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Reported-by: syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com
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
