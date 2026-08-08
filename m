Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB3C342CB0;
	Sat,  8 Aug 2026 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.183.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786206737; cv=none; b=QO2bAS70svqJC+9jdAbH+1rGcvd6SOqVHJ7GwJoGAzANjwQ98xhdknxsbbzdSvpr3N59XxW9WplbJ+HJaO8vkPwCpstXSuXTI5sNvFSb7T8qUeQoCqlGZhcbUPMF7ngy2WBZL+FSlqxRZdvYWJQ+rOOLTZWbhj8QzJbSTh9W5to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786206737; c=relaxed/simple;
	bh=P7OEq8JaqieDt2VxSJ1w84E4vXZu+GNDpbEc+azEtw4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g4IkypMop7xgqXAoXrfsmG5fbFdS15HJ4fWBQzygSzpqUhkxpB8+biV/zFPerOJ877wQvzdgk0kaAF3chWLgMlM3iq5MQ6TPHhVph+kOHutm61bpAPZ/o2/CCU+k9n3UUmP36Sfifz3OdhbWgZcoG0thkp/qAP1En5293JlnZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=TCJC5/xY; arc=none smtp.client-ip=95.181.183.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="TCJC5/xY"
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id A65AA240003;
	Sat,  8 Aug 2026 19:32:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru A65AA240003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1786206728;
	bh=bFxCmGTXCmmTwdLjagHbc+d4z2Lm2K3d3FWBO3DJbeQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=TCJC5/xYkWZI+Zf61JQ3bDzHd+BSCqC0Rhe8UzPGlmMkGhhiURocQHQYOx2+BwF9o
	 XO631GneD9AfVhiDulPcfdfwQaW5EsPKQfbsK0g9AXbuaq+3Lsny0RfE6/XOBjc92p
	 px658GfHxRFagAykdPAejmCsVWLYHYsBFUBGsTWyd7GI8yI0ZhGL1xAJov3V6uOm8M
	 YOqPoUEJel9265ZQ0VOfi90H5JAING+tB2J3/2aofbN25fBEoJc1WKIG8QvpEEg88a
	 gl3VsNDeFjkzFBE6M5zfjqQUmcX596ZCFZj8RMDwLEXEHFUrcUb4ImE1+TkYImVlc7
	 UhloBBLlvHjjQ==
Received: from smtp.sberdevices.ru (p-exch-cas-s-m1.sberdevices.ru [172.16.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "YR2" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS;
	Sat,  8 Aug 2026 19:32:04 +0300 (MSK)
From: Pavel Shpakovskiy <pashpakovskii@salutedevices.com>
To: <marcel@holtmann.org>, <luiz.dentz@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <avkrasnov@salutedevices.com>
CC: <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>,
	<rulkc@linuxtesting.org>, <linux-amlogic@lists.landau.one>, Pavel Shpakovskiy
	<pashpakovskii@salutedevices.com>
Subject: [PATCH v2] Bluetooth: mgmt: fix 'hdev->discovery.uuids' NULL dereference
Date: Sat, 8 Aug 2026 19:31:11 +0300
Message-ID: <20260808163128.288740-1-pashpakovskii@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 113 0.3.113 b83a27b0bdff87150e3aba5d24ea90b4a220db99, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, FromAlignment: n
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 205118 [Aug 07 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/08/08 15:17:00 #28661001
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
 Changelog v1->v2:
 * Sleeping function was called from invalid context,
   need to allocate uuids before acquiring discovery.lock.

 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/mgmt.c             | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

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
index de5bd6b637b20..9917710f2ff56 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6088,6 +6088,7 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 	struct mgmt_pending_cmd *cmd;
 	const u16 max_uuid_count = ((U16_MAX - sizeof(*cp)) / 16);
 	u16 uuid_count, expected_len;
+	u8 (*uuids)[16] = NULL;
 	u8 status;
 	int err;
 
@@ -6164,12 +6165,10 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 	hdev->discovery.result_filtering = true;
 	hdev->discovery.type = cp->type;
 	hdev->discovery.rssi = cp->rssi;
-	hdev->discovery.uuid_count = uuid_count;
 
 	if (uuid_count > 0) {
-		hdev->discovery.uuids = kmemdup(cp->uuids, uuid_count * 16,
-						GFP_KERNEL);
-		if (!hdev->discovery.uuids) {
+		uuids = kmemdup(cp->uuids, uuid_count * sizeof(*uuids), GFP_KERNEL);
+		if (!uuids) {
 			err = mgmt_cmd_complete(sk, hdev->id,
 						MGMT_OP_START_SERVICE_DISCOVERY,
 						MGMT_STATUS_FAILED,
@@ -6179,6 +6178,11 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 		}
 	}
 
+	spin_lock(&hdev->discovery.lock);
+	hdev->discovery.uuids = uuids;
+	hdev->discovery.uuid_count = uuid_count;
+	spin_unlock(&hdev->discovery.lock);
+
 	err = hci_cmd_sync_queue(hdev, start_discovery_sync, cmd,
 				 start_discovery_complete);
 	if (err < 0) {
@@ -10243,6 +10247,7 @@ static bool is_filter_match(struct hci_dev *hdev, s8 rssi, u8 *eir,
 	     !hci_test_quirk(hdev, HCI_QUIRK_STRICT_DUPLICATE_FILTER))))
 		return  false;
 
+	spin_lock(&hdev->discovery.lock);
 	if (hdev->discovery.uuid_count != 0) {
 		/* If a list of UUIDs is provided in filter, results with no
 		 * matching UUID should be dropped.
@@ -10251,9 +10256,12 @@ static bool is_filter_match(struct hci_dev *hdev, s8 rssi, u8 *eir,
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

