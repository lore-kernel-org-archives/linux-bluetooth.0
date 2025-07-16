Received: from mx4.sberdevices.ru (mx4.sberdevices.ru [176.109.96.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AAE1D63C7;
	Wed, 16 Jul 2025 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.109.96.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694206; cv=none; b=AYrkqGRXZEJS6PS7LhcbJBKMlnskhOIrkWdP4ypmJf/YvnVALxQ0iYSVjvPi+r8Q8WhTryEij7/N4ONtAvX7QsBMUcQXEnAyHfoyB4dcED2OSdA1wwEWffvzuGCzXjB9d96FLMwcIqmiakmGvXPSyR1dP47dMcv4T/8APvpH+8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694206; c=relaxed/simple;
	bh=hnMESY61LUdiBDqSBTytVZr5JQLx7UhMLgO9o+ndu4Y=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=d71k0H0UIq/BLmVSZDEAqFdFRX15dKyHowXXsCascwDVssz/xfxiTWt/X9ChrlBgXBowTD8FsDLvqlOH7IjCWtpJPYifuUBQv0ZiGfl+KNOwppX4it1wNdtP2kpVPiHOMHcepLBDHCHh1cv3YWTxz5gRtCDeQ8JMoivyIgU2wDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ZamgAoxD; arc=none smtp.client-ip=176.109.96.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ZamgAoxD"
Received: from p-antispam-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id 1F3754000E;
	Wed, 16 Jul 2025 22:24:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru 1F3754000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1752693840;
	bh=HcxKrVAY8DLx+FqQIQRA/Es2dhMC8MRz6HgW+r0XFtE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:From;
	b=ZamgAoxDGTr5AwSUlOS0Egg+OpDGkyBmP/sWMJWrSUXsAN1orO920A74jjlmWobCE
	 oqg7Pa7TExbHhM3qAGvafZQ+zUUTq30L9F9Kg/Azl3l1SCbO1Fx7Rd7tzXc+Cgs9bT
	 QqFLkm7UpbDxdNXXxm5ivz7KHlqs3MElf8j4j9IoKL+7pJ0pewkF04u6CJzk+ayTp7
	 OIGKQlVZb9haMXo9R16AMVOZ6dnYB2Y83F28nyrssNFVWjf76yczRS6G0GACxaBXnK
	 ubw1bWKj31AEYsUZAiDO6VWlRQ+JxFEk+B4gcIXYtLjoC/9c8aEJTMGF0O4wasGuKf
	 7i1ed65BwW2GA==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R11" (verified OK))
	by mx4.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 16 Jul 2025 22:23:59 +0300 (MSK)
Message-ID: <1313ef02-285a-7012-74eb-b6589d471be5@salutedevices.com>
Date: Wed, 16 Jul 2025 22:23:58 +0300
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
Subject: [PATCH v4] Bluetooth: hci_sync: fix double free in
 'hci_discovery_filter_clear()'
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-exch-cas-a-m1.sberdevices.ru (172.24.201.216) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 63 0.3.63 9cc2b4b18bf16653fda093d2c494e542ac094a39, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 194895 [Jul 16 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/07/16 17:03:00 #27638287
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

Function 'hci_discovery_filter_clear()' frees 'uuids' array and then
sets it to NULL. There is a tiny chance of the following race:

'hci_cmd_sync_work()'

 'update_passive_scan_sync()'

   'hci_update_passive_scan_sync()'

     'hci_discovery_filter_clear()'
       kfree(uuids);

       <-------------------------preempted-------------------------------->
                                           'start_service_discovery()'

                                             'hci_discovery_filter_clear()'
                                               kfree(uuids); // DOUBLE FREE

       <-------------------------preempted-------------------------------->

      uuids = NULL;

To fix it let's add locking around 'kfree()' call and NULL pointer
assignment. Otherwise the following backtrace fires:

[ ] ------------[ cut here ]------------
[ ] kernel BUG at mm/slub.c:547!
[ ] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
[ ] CPU: 3 UID: 0 PID: 246 Comm: bluetoothd Tainted: G O 6.12.19-kernel #1
[ ] Tainted: [O]=OOT_MODULE
[ ] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ ] pc : __slab_free+0xf8/0x348
[ ] lr : __slab_free+0x48/0x348
...
[ ] Call trace:
[ ]  __slab_free+0xf8/0x348
[ ]  kfree+0x164/0x27c
[ ]  start_service_discovery+0x1d0/0x2c0
[ ]  hci_sock_sendmsg+0x518/0x924
[ ]  __sock_sendmsg+0x54/0x60
[ ]  sock_write_iter+0x98/0xf8
[ ]  do_iter_readv_writev+0xe4/0x1c8
[ ]  vfs_writev+0x128/0x2b0
[ ]  do_writev+0xfc/0x118
[ ]  __arm64_sys_writev+0x20/0x2c
[ ]  invoke_syscall+0x68/0xf0
[ ]  el0_svc_common.constprop.0+0x40/0xe0
[ ]  do_el0_svc+0x1c/0x28
[ ]  el0_svc+0x30/0xd0
[ ]  el0t_64_sync_handler+0x100/0x12c
[ ]  el0t_64_sync+0x194/0x198
[ ] Code: 8b0002e6 eb17031f 54fffbe1 d503201f (d4210000)
[ ] ---[ end trace 0000000000000000 ]---

Fixes: ad383c2c65a5 ("Bluetooth: hci_sync: Enable advertising when LL privacy is enabled")
Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 Changelog v1->v2:
 * Don't call 'hci_dev_lock()' in 'update_passive_scan_sync()' as it
   triggers deadlock. Instead of that - add spinlock which protects
   freeing code.
 Changelog v2->v3:
 * Rebase on current 'bluetooth' repo due to fuzz.
 Changelog v3->v4:
 * Rebase on current 'bluetooth' repo due patch apply failed.

 include/net/bluetooth/hci_core.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1ef9279cfd6f..3728495f0819 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -29,6 +29,7 @@
 #include <linux/idr.h>
 #include <linux/leds.h>
 #include <linux/rculist.h>
+#include <linux/spinlock.h>
 #include <linux/srcu.h>
 
 #include <net/bluetooth/hci.h>
@@ -94,6 +95,7 @@ struct discovery_state {
 	u16			uuid_count;
 	u8			(*uuids)[16];
 	unsigned long		name_resolve_timeout;
+	spinlock_t		lock;
 };
 
 #define SUSPEND_NOTIFIER_TIMEOUT	msecs_to_jiffies(2000) /* 2 seconds */
@@ -889,6 +891,7 @@ static inline void iso_recv(struct hci_conn *hcon, struct sk_buff *skb,
 
 static inline void discovery_init(struct hci_dev *hdev)
 {
+	spin_lock_init(&hdev->discovery.lock);
 	hdev->discovery.state = DISCOVERY_STOPPED;
 	INIT_LIST_HEAD(&hdev->discovery.all);
 	INIT_LIST_HEAD(&hdev->discovery.unknown);
@@ -903,8 +906,11 @@ static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
 	hdev->discovery.report_invalid_rssi = true;
 	hdev->discovery.rssi = HCI_RSSI_INVALID;
 	hdev->discovery.uuid_count = 0;
+
+	spin_lock(&hdev->discovery.lock);
 	kfree(hdev->discovery.uuids);
 	hdev->discovery.uuids = NULL;
+	spin_unlock(&hdev->discovery.lock);
 }
 
 bool hci_discovery_active(struct hci_dev *hdev);
-- 
2.43.0
