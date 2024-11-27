Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6355C18DF86;
	Wed, 27 Nov 2024 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732711577; cv=none; b=ZaaHzMye45RKZMPhgYjxSBbNvXgNX2wROmhYiR7C2mPsN2Arz7n3Aqax394GlLmR3a+yIFt+ViyB3kFDC6G4GvWw+BMTjItkt3vJIFClJaYpc0+vp4b4pulbifdeZUt7s7d8OC2pfNm9LgOSDBH8bJYZTSXv6h2YsptDlgihlXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732711577; c=relaxed/simple;
	bh=sgZZvhAKLD5ASHk7jFBYWTb2D4wOq4Yj4EndXe9SN50=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=d8Bsdldh2YpD8qXGUZKiY0x/o8gH9ZndG2GNYfAkPH03vIlwyFm/0x2j69m//+AuHKcgGPHmkVSwHT+SPjvGe53vvIMhN6qLlWRPnK0UUS7fzfdin1UDItLaLD0Z/ploH8bHB5gWq8lF/TlGvf6RGZcogpabXkBw9bHUvW8JHzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=k9TuaZB+; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="k9TuaZB+"
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A1A51100009;
	Wed, 27 Nov 2024 15:38:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A1A51100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1732711101;
	bh=xqEQRHjL+Juhx1NVbwlUR8REr9AM3p5ooPM1cNWwZHs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:From;
	b=k9TuaZB+D7XX/dxB8x75Seko2MZcFE7SdxSX7IvMundA7xqkviEfoH+2aqVP6oPFB
	 KWm324IJAHy3zVropJi9mp7w2xG0pMgYS1jU8HzpKSjbQ7gpROh+sbRRvtye8xyPh8
	 jFwYbk2i6c+TJH0AB76nCsMMl7Cx8KNW6IfOMrZxuXNEDUyPnPgLSo0sqJVO46o37w
	 BxmWqVimtrITBByhNarTilRCXRclBNEo5OrbZtKXmBoqIuzXvqFIUSi1mdmFNUeuHJ
	 P+2bvX5/ZyMgqDSJK8+H0g/vo/XQnp8URoei3dOgNvnqBognSMPM7wSjP3j7NXppOw
	 tgn2y2bdFKO5w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 27 Nov 2024 15:38:21 +0300 (MSK)
Message-ID: <a1db0c90-1803-e01c-3e23-d18e4343a4eb@salutedevices.com>
Date: Wed, 27 Nov 2024 15:38:20 +0300
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
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oxffffaa@gmail.com>, <ddrokosov@salutedevices.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: [PATCH v1] Bluetooth: hci_uart: fix race during initialization
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189444 [Nov 27 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 42 0.3.42 bec10d90a7a48fa5da8c590feab6ebd7732fec6b, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/27 11:28:00 #26898120
X-KSMG-AntiVirus-Status: Clean, skipped

'hci_register_dev()' calls power up function, which is executed by
kworker - 'hci_power_on()'. This function does access to bluetooth chip
using callbacks from 'hci_ldisc.c', for example 'hci_uart_send_frame()'.
Now 'hci_uart_send_frame()' checks 'HCI_UART_PROTO_READY' bit set, and
if not - it fails. Problem is that 'HCI_UART_PROTO_READY' is set after
'hci_register_dev()', and there is tiny chance that 'hci_power_on()' will
be executed before setting this bit. In that case HCI init logic fails.

Patch adds one more bit in addition to 'HCI_UART_PROTO_READY' which
allows to perform power up logic without original bit set.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 drivers/bluetooth/hci_ldisc.c | 19 ++++++++++++++-----
 drivers/bluetooth/hci_uart.h  |  1 +
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 30192bb083549..2e20f00649bd7 100644
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
@@ -582,7 +585,8 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
 	if (tty != hu->tty)
 		return;
 
-	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+	if (test_bit(HCI_UART_PROTO_READY, &hu->flags) ||
+	    test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 		hci_uart_tx_wakeup(hu);
 }
 
@@ -608,7 +612,8 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 
 	percpu_down_read(&hu->proto_lock);
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
+	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags)) {
 		percpu_up_read(&hu->proto_lock);
 		return;
 	}
@@ -704,12 +709,16 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
 	hu->proto = p;
 
+	set_bit(HCI_UART_PROTO_INIT, &hu->flags);
+
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		return err;
 	}
 
 	set_bit(HCI_UART_PROTO_READY, &hu->flags);
+	clear_bit(HCI_UART_PROTO_INIT, &hu->flags);
+
 	return 0;
 }
 
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 00bf7ae82c5b7..39f39704be41f 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -89,6 +89,7 @@ struct hci_uart {
 #define HCI_UART_REGISTERED		1
 #define HCI_UART_PROTO_READY		2
 #define HCI_UART_NO_SUSPEND_NOTIFIER	3
+#define HCI_UART_PROTO_INIT		4
 
 /* TX states  */
 #define HCI_UART_SENDING	1
-- 
2.30.1
