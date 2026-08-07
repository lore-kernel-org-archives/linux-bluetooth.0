Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5892E7377;
	Fri,  7 Aug 2026 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.183.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786129300; cv=none; b=g13c9kdph3bjgu1q/fOXjhSow9Tshoxg3GqiEME3hrpHEZw0sIBFuS8rdwHDETYx/5yuM6ZevKYD0mSOsPMTp4JCm68ULRxbuFJUxHmqABSNcqVuqeCaHlRDl852iVth+fJcc3AYHFo6tunwTJ1O92zlPC54wjaovTz3f2LRd/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786129300; c=relaxed/simple;
	bh=4ge0zADTBq3gzDmnnOhp1wDE3J2Fv8J6ZgZNbtx7iuQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D+0ZlWfxsHomH56EO2SOWpleGTjMIksRrwGHRRlJadec11B2rSmvYvW5iJbiVxdpAYqRMQ9jjmnv3f1gk6NToxq6JP/V3EklMsJzOR2Qe6IbuqRreICR523ruwx+sWRndkvrelRGiG88XBqyImvJ3DcdeU3gSprmUlh4qdo00V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=bTwi9dYn; arc=none smtp.client-ip=95.181.183.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="bTwi9dYn"
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id 2B2BD240003;
	Fri,  7 Aug 2026 21:55:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru 2B2BD240003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1786128934;
	bh=8cXbGW/Whro1VRy8jilLxlVto4f2KyTjsD19uRVzVpI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=bTwi9dYnwk36aFp1jlXQPmiRqMpr1XcUsIOWlGdCjPlXU8yrie+4xRrn+Ve2wMjhu
	 x0AqlNMrTHUOxS8Lwsdcezm/gbsWiPYh74wfY4akhD5RBLkmyuSsVOW3gSK4aolpmR
	 r18lveVfw1zWXoYWy/NE5tfB5wKc1oHwx6GCJPKLTVPeqv8WgAOUVrIun/GExn3nKQ
	 Bq5o5NJdvc4uc/0k8KXPEWGh2ijZeAHUBKjhoWWrfELk/Qtqha+t72DvD7ag9qSw5Y
	 kkvAEl8u4/OpAiWgNlvkgszJ7R722ZG8QO6q1XdmSbJEkaDhthZ7Utl2HRGxVBtGD4
	 h7ByVEQJg2JvA==
Received: from smtp.sberdevices.ru (p-exch-cas-s-m1.sberdevices.ru [172.16.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "YR2" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 21:55:31 +0300 (MSK)
From: Pavel Shpakovskiy <pashpakovskii@salutedevices.com>
To: <marcel@holtmann.org>, <luiz.dentz@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <avkrasnov@salutedevices.com>
CC: <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>,
	<rulkc@linuxtesting.org>, <linux-amlogic@lists.landau.one>, Pavel Shpakovskiy
	<pashpakovskii@salutedevices.com>
Subject: [PATCH v1] Bluetooth: mgmt: fix 'hdev->discovery.uuids' NULL dereference
Date: Fri, 7 Aug 2026 21:54:21 +0300
Message-ID: <20260807185456.336042-1-pashpakovskii@salutedevices.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-exch-cas-s-m1.sberdevices.ru (172.16.210.2) To
 p-exch-cas-s-m1.sberdevices.ru (172.16.210.2)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: pashpakovskii@sberdevices.ru
X-KSMG-AntiSpam-Info: LuaCore: 113 0.3.113 b83a27b0bdff87150e3aba5d24ea90b4a220db99, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, FromAlignment: n
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 205118 [Aug 07 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/08/07 15:45:00 #28658525
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

'uuid_count' member of struct 'discovery_state' is assigned and read
without any locks, so there is a chance of situation when
uuid_count != 0, but uuids is NULL and there will be NULL pointer
dereference.

Possible race:
'hci_update_passive_scan_sync'
  'hci_discovery_filter_clear'
    hdev->discovery.uuid_count = 0;
      <----------------------preempted----------------------------->
                        'start_service_discovery'
                          // Set uuid_count to value != 0
                          hdev->discovery.uuid_count = uuid_count;
                          hdev->discovery.uuids = kmemdup(...);
      <----------------------preempted----------------------------->
    spin_lock(&hdev->discovery.lock);
    kfree(hdev->discovery.uuids);
    hdev->discovery.uuids = NULL;
    spin_unlock(&hdev->discovery.lock);

Now uuids == NULL and uuid_count != 0.
So 'mgmt_device_found' -> 'is_filter_match' -> 'eir_has_uuids' receives
non consistent discovery state, where NULL dereference of uuids happens.

To fix it let's add discovery.lock around every read/write of uuid_count,
uuids pair of struct members. It is also important to assign uuid_count
value only after success kmemdup() allocation in
start_service_discovery(), otherwise uuids is NULL, because kmemdup failed,
but uuid_count is already assigned to non zero value.

The following panic happens:

[ ] ------------[ cut here ]------------
[ ] Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000000
[ ] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
[ ] CPU: 0 PID: 15056 Comm: kworker/u9:2
[ ] Workqueue: hci0 hci_rx_work
[ ] pstate: 10400009 (nzcV daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ ] pc : eir_has_uuids+0x2d8/0x590
[ ] lr : is_filter_match+0x258/0x320
...
[ ] Call trace:
[ ]  eir_has_uuids+0x2d8/0x590
[ ]  is_filter_match+0x258/0x320
[ ]  mgmt_device_found+0x5b0/0xafc
[ ]  process_adv_report.part.0+0x8c8/0xf14
[ ]  hci_le_adv_report_evt+0x338/0x3f0
[ ]  hci_le_meta_evt+0x1f0/0x4c8
[ ]  hci_event_packet+0x440/0xc9c
[ ]  hci_rx_work+0x44c/0xaf8
[ ]  process_one_work+0x54c/0x103c
[ ]  worker_thread+0x6c4/0x10c4
[ ]  kthread+0x274/0x2ec
[ ]  ret_from_fork+0x10/0x20
[ ] Code: 14000004 91004021 eb14003f 54000180 (f9400024)
[ ] ---[ end trace 0000000000000000 ]---

Fixes: 2935e556850e ("Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'")
Signed-off-by: Pavel Shpakovskiy <pashpakovskii@salutedevices.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/mgmt.c             | 13 +++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a7bffb908c1ec..f14239d1a817e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -920,9 +920,9 @@ static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
 	hdev->discovery.result_filtering = false;
 	hdev->discovery.report_invalid_rssi = true;
 	hdev->discovery.rssi = HCI_RSSI_INVALID;
-	hdev->discovery.uuid_count = 0;
 
 	spin_lock(&hdev->discovery.lock);
+	hdev->discovery.uuid_count = 0;
 	kfree(hdev->discovery.uuids);
 	hdev->discovery.uuids = NULL;
 	spin_unlock(&hdev->discovery.lock);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index de5bd6b637b20..7368a4ac0c839 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6164,12 +6164,14 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 	hdev->discovery.result_filtering = true;
 	hdev->discovery.type = cp->type;
 	hdev->discovery.rssi = cp->rssi;
-	hdev->discovery.uuid_count = uuid_count;
+
+	spin_lock(&hdev->discovery.lock);
 
 	if (uuid_count > 0) {
 		hdev->discovery.uuids = kmemdup(cp->uuids, uuid_count * 16,
 						GFP_KERNEL);
 		if (!hdev->discovery.uuids) {
+			spin_unlock(&hdev->discovery.lock);
 			err = mgmt_cmd_complete(sk, hdev->id,
 						MGMT_OP_START_SERVICE_DISCOVERY,
 						MGMT_STATUS_FAILED,
@@ -6179,6 +6181,9 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 		}
 	}
 
+	hdev->discovery.uuid_count = uuid_count;
+	spin_unlock(&hdev->discovery.lock);
+
 	err = hci_cmd_sync_queue(hdev, start_discovery_sync, cmd,
 				 start_discovery_complete);
 	if (err < 0) {
@@ -10243,6 +10248,7 @@ static bool is_filter_match(struct hci_dev *hdev, s8 rssi, u8 *eir,
 	     !hci_test_quirk(hdev, HCI_QUIRK_STRICT_DUPLICATE_FILTER))))
 		return  false;
 
+	spin_lock(&hdev->discovery.lock);
 	if (hdev->discovery.uuid_count != 0) {
 		/* If a list of UUIDs is provided in filter, results with no
 		 * matching UUID should be dropped.
@@ -10251,9 +10257,12 @@ static bool is_filter_match(struct hci_dev *hdev, s8 rssi, u8 *eir,
 				   hdev->discovery.uuids) &&
 		    !eir_has_uuids(scan_rsp, scan_rsp_len,
 				   hdev->discovery.uuid_count,
-				   hdev->discovery.uuids))
+				   hdev->discovery.uuids)) {
+			spin_unlock(&hdev->discovery.lock);
 			return false;
+		}
 	}
+	spin_unlock(&hdev->discovery.lock);
 
 	/* If duplicate filtering does not report RSSI changes, then restart
 	 * scanning to ensure updated result with updated RSSI values.
-- 
2.43.0

