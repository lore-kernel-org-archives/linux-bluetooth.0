Received: from mx4.sberdevices.ru (mx4.sberdevices.ru [176.109.96.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0501C8632;
	Wed, 11 Jun 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.109.96.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660006; cv=none; b=HNjaWCB4p6eL0yGidCS3l9RMb/6iiPDh0BJznaiethrL/ASVtXLNjxZVBbK8gHx4Xvg1a6qcmpypohrfpQ08fRg4n27IdCdeA9GfL1q1XbrBUJ8A4P0Vavs4cz9FK3wCoBiKMG90LTnrqX0jDO0IWfwBD5Mujds9WSTNt7v6Wh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660006; c=relaxed/simple;
	bh=jdwCrklGp8+sWWDiW7jW7zE4A5+X8nE4ppEx6ZGNNcQ=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=GJ99kJrAIFA1UF9UZgTXKHygFmgHfgnRgVJv4iN6v12+ygOAR8n/2A7aolnBxazO0WNtNLciHg6Fdmuch6xlbmi41z+1Z61roqE2N5E/fg+XRsXsC/yaTmI7RSczg6OPkPssiMHyWrMhhN2kPKz6ytLVNudhWfl+GSypRqUfARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=NguFvGIf; arc=none smtp.client-ip=176.109.96.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="NguFvGIf"
Received: from p-antispam-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id B3E9640009;
	Wed, 11 Jun 2025 19:31:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru B3E9640009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1749659514;
	bh=OwEpP8eYceRJZneNAm7UT6qBSzcUQ7h5XJGbYSL4PbI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:From;
	b=NguFvGIfgegpZOnhKE9yZL+GHEuLnqg6oAHmkx5RDaYqPf6Oz5rd86f2rJHQd+hIu
	 +uOm06QgwQoB8xltwdZcG1xpkFxRrXq63YPuV5UpawFozgn54ipT98ELONOfqk6zgY
	 BSbnCe452e0IXEHypKOgkUs9vz6PVHcV+OKl7RGUcOvKD24m0eOvkaxmOydnE6epon
	 0UJLmU6g/7E8Xge6QbH6vpXPNWRcFnbcO1/ySfD8GYMg1H7RWZhbO+BQ0yDMmlwdLt
	 04Qyn5gBl9SgpBSDFFaiDzPkYkAErbJEc1eMzBYaF1QIn8Sm7s6u5BoWgsn6P8axIR
	 qZjd9ztI+lfHg==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R11" (verified OK))
	by mx4.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 11 Jun 2025 19:31:54 +0300 (MSK)
Message-ID: <4e1578fb-c81d-fe9c-1aa1-26b6016866eb@salutedevices.com>
Date: Wed, 11 Jun 2025 19:31:49 +0300
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
CC: <oxffffaa@gmail.com>, <kernel@salutedevices.com>,
	<linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: [PATCH v1] Bluetooth: hci_sync: fix double free in
 'hci_discovery_filter_clear()'
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 62 0.3.62 e2af3448995f5f8a7fe71abf21bb23519d0f38c3, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 194026 [Jun 11 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/06/11 14:54:00 #27559328
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

To fix it let's add locking around call  'hci_update_passive_scan_sync()' in
'update_passive_scan_sync()'. Otherwise the following backtrace fires:

[ ] ------------[ cut here ]------------
[ ] kernel BUG at mm/slub.c:547!
[ ] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
[ ] CPU: 3 UID: 0 PID: 246 Comm: bluetoothd Tainted: G O 6.12.19-sdkernel #1
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

Cc: stable@vger.kernel.org
Fixes: ad383c2c65a5 ("Bluetooth: hci_sync: Enable advertising when LL privacy is enabled")
Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 net/bluetooth/hci_sync.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e56b1cbedab90..61a9922eb820d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3167,7 +3167,15 @@ int hci_update_scan(struct hci_dev *hdev)
 
 static int update_passive_scan_sync(struct hci_dev *hdev, void *data)
 {
-	return hci_update_passive_scan_sync(hdev);
+	int ret;
+
+	hci_dev_lock(hdev);
+
+	ret = hci_update_passive_scan_sync(hdev);
+
+	hci_dev_unlock(hdev);
+
+	return ret;
 }
 
 int hci_update_passive_scan(struct hci_dev *hdev)
-- 
2.30.1

