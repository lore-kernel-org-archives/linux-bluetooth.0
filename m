Received: from mx4.sberdevices.ru (mx4.sberdevices.ru [176.109.96.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906B2E11D0;
	Sun, 15 Jun 2025 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.109.96.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750007886; cv=none; b=jCuprA0D8boanPq1T9vOcUHSznqMoXaqt0Xgn6l2ev6sKfbovRl8uPeDe4oimSbjtYCypNqNQibN0u00wZo++RLYIaUbh1tqrDNBcZs0NdPweG8JHQEwdCRv30EvzLlVZmdqumeqDLFtzfYJm4sQtI4/0abGUdSlaALJGuzbacA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750007886; c=relaxed/simple;
	bh=IpFyCdPsilYKhDnjZVvpuN3o5hr34wvFV8PNG57dK7E=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=uCXJUO1f/6YXj/AXKdZdycs5xeTQBjmLki6q3dwaqnmhrsYpuv5HISRbmBBrt/8FamYiWwWin0EsRcMCAbOFKhdGXzC9nqYB+N2vCDhw9FGMuCQ3aCBbfsazdZ23Jj+VRHgNkj0+IUnR8DlfUhPLSqbPSInOg8q0rRUrKUkNtgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=JbaLUjaz; arc=none smtp.client-ip=176.109.96.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="JbaLUjaz"
Received: from p-antispam-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id A35C440007;
	Sun, 15 Jun 2025 20:17:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru A35C440007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1750007871;
	bh=2j44N7duqW/GZJF8dElj9yCnlnUFcUZWbhHIa9gfO6Y=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:From;
	b=JbaLUjazvs4Bad4B4H8nlJL/3t9+TlxySm/DH9jphZndkrYC5rbw6Pr9yWovhAXep
	 yV69f51aEtLwQXap9suWFJBKHwmwn/GGoqSxYLfiAKz1PhizGreLhkSrFVLfxhPnml
	 6ucYvBdypzM2KhXI/+WxWIve+rlA6gy/9V4XbCyl2a3qLkiG5+F8Jt08KoIh5LzcNd
	 LhW+cv69qePzMaSY/8CprYIqYCW5XnMP++9vkOcvfmnNK9/OlhWvAhsTPXVnbEDjpD
	 Ge/k2BWh657Sut4yaB89aDAXskzniRUwDOOR6GfqIPqhaHqXq87fOzBXca6l53kSOd
	 Gh1AhXFkX8CUw==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R11" (verified OK))
	by mx4.sberdevices.ru (Postfix) with ESMTPS;
	Sun, 15 Jun 2025 20:17:51 +0300 (MSK)
Message-ID: <257a13b8-6d60-21b3-c714-c6cb74b7b091@salutedevices.com>
Date: Sun, 15 Jun 2025 20:17:45 +0300
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
Subject: [PATCH v3] Bluetooth: hci_sync: fix double free in
 'hci_discovery_filter_clear()'
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-exch-cas-a-m1.sberdevices.ru (172.24.201.216) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 62 0.3.62 e2af3448995f5f8a7fe71abf21bb23519d0f38c3, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 194046 [Jun 15 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/06/15 14:49:00 #27567949
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

 include/net/bluetooth/hci_core.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 54bfeeaa09959..f8eeb15acdcfa 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -29,6 +29,7 @@
 #include <linux/idr.h>
 #include <linux/leds.h>
 #include <linux/rculist.h>
+#include <linux/spinlock.h>
 
 #include <net/bluetooth/hci.h>
 #include <net/bluetooth/hci_drv.h>
@@ -92,6 +93,7 @@ struct discovery_state {
 	u16			uuid_count;
 	u8			(*uuids)[16];
 	unsigned long		name_resolve_timeout;
+	spinlock_t		lock;
 };
 
 #define SUSPEND_NOTIFIER_TIMEOUT	msecs_to_jiffies(2000) /* 2 seconds */
@@ -878,6 +880,7 @@ static inline void iso_recv(struct hci_conn *hcon, struct sk_buff *skb,
 
 static inline void discovery_init(struct hci_dev *hdev)
 {
+	spin_lock_init(&hdev->discovery.lock);
 	hdev->discovery.state = DISCOVERY_STOPPED;
 	INIT_LIST_HEAD(&hdev->discovery.all);
 	INIT_LIST_HEAD(&hdev->discovery.unknown);
@@ -892,8 +895,11 @@ static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
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
2.30.1
