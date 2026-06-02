Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1D2F1FE3;
	Tue,  2 Jun 2026 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780383664; cv=none; b=kciw+XL8axXvEbTH+Qjbik+kBakn7+bcoyHRCEv6/YxMLl1CodKDEsyhgX0NGSVuvR/JvldMKMne2YlLjpdJmGwYMdJhH/sMED37hGUWxhnD9SZzl7DQ/nrfm/aGaGW/YA0SPidAf61XUI//QO9trh58+N2ZArD4witM2663+3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780383664; c=relaxed/simple;
	bh=hSqCg+FSHwXj053mJaJ8N/tPg63DQ2iXRgMs7mLzyCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g57ZtGzePAenx1EKIKfsiWh8diX84yP6eTz4z2dwXBimIH3BV8zEwunth+fOW1eeCbsoWoL5hUzEj3Ln5iZQMvy8KbVQruFQ3gahgvyfDoqTS+WiaKBb2GbOcaWxjlDUg8zvwtfVi0oWqG1GBgfoLDlumM2ZpY6iT0Criov84Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cddb49f25e5011f1aa26b74ffac11d73-20260602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8a83aa69-f91f-4bc2-94f9-2e58ba20f890,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:b66ad2a3a942694f5e3604cdf9bdbe76,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cddb49f25e5011f1aa26b74ffac11d73-20260602
X-User: liujiajia@kylinos.cn
Received: from nature.lan [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1238520139; Tue, 02 Jun 2026 15:00:56 +0800
From: Jiajia Liu <liujiajia@kylinos.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Brian Gix <brian.gix@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiajia Liu <liujia6264@gmail.com>,
	Jiajia Liu <liujiajia@kylinos.cn>
Subject: [PATCH v2] Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING
Date: Tue,  2 Jun 2026 15:00:32 +0800
Message-ID: <20260602070032.51248-1-liujiajia@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hci_inquiry_complete_evt is called between le_scan_disable and
le_set_scan_enable_complete and no remote name needs to be resolved,
the interleaved discovery with SIMULTANEOUS quirk gets stuck in
DISCOVERY_FINDING. le_set_scan_enable_complete does not check inquiry
state. No one sets DISCOVERY_STOPPED in this process.

Add state check in le_set_scan_enable_complete and change state if
the state is DISCOVERY_FINDING. Tested with AX201 (8087:0026) in Dell
Vostro 13. Discovering disabled MGMT Event below is reported when
running into the above condition.

 @ MGMT Command: Start Discovery (0x0023)    {0x0001} [hci0] 10885.970873
         Address type: 0x07
           BR/EDR
           LE Public
           LE Random
 ...
 < HCI Command: LE Set Extended Scan Enable    #38205 [hci0] 10886.131438
         Extended scan: Enabled (0x01)
         Filter duplicates: Enabled (0x01)
         Duration: 0 msec (0x0000)
         Period: 0.00 sec (0x0000)
 > HCI Event: Command Complete (0x0e) plen 4   #38206 [hci0] 10886.133295
       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
         Status: Success (0x00)
 @ MGMT Event: Discovering (0x0013) plen 2   {0x0001} [hci0] 10886.133414
         Address type: 0x07
           BR/EDR
           LE Public
           LE Random
         Discovery: Enabled (0x01)
 < HCI Command: Inquiry (0x01|0x0001) plen 5   #38207 [hci0] 10886.133528
         Access code: 0x9e8b33 (General Inquiry)
         Length: 10.24s (0x08)
         Num responses: 0
 > HCI Event: Command Status (0x0f) plen 4     #38208 [hci0] 10886.141333
       Inquiry (0x01|0x0001) ncmd 2
         Status: Success (0x00)
 ...
 < HCI Command: LE Set Extended Scan Enable    #38242 [hci0] 10896.381802
         Extended scan: Disabled (0x00)
         Filter duplicates: Disabled (0x00)
         Duration: 0 msec (0x0000)
         Period: 0.00 sec (0x0000)
 > HCI Event: Inquiry Complete (0x01) plen 1   #38243 [hci0] 10896.383419
         Status: Success (0x00)
 > HCI Event: Command Complete (0x0e) plen 4   #38244 [hci0] 10896.394378
       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
         Status: Success (0x00)
 @ MGMT Event: Device Found (0x0012) plen 22 {0x0001} [hci0] 10896.394497
         LE Address: 88:12:AC:92:43:69
         RSSI: -101 dBm (0x9b)
         Flags: 0x00000004
           Not Connectable
         Data length: 8
         Company: Xiaomi Inc. (911)
           Data[0]:
         16-bit Service UUIDs (complete): 1 entry
           Xiaomi Inc. (0xfdaa)
 @ MGMT Event: Discovering (0x0013) plen 2   {0x0001} [hci0] 10896.394506
         Address type: 0x07
           BR/EDR
           LE Public
           LE Random
         Discovery: Disabled (0x00)

Fixes: 8ffde2a73f2c ("Bluetooth: Convert le_scan_disable timeout to hci_sync")
Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
---

Changes in v2:
- move the handler to hci_event.c
- remove unnecessary bt_dev_dbg
- update commit message

---
 net/bluetooth/hci_event.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index eea2f810aafa..1cd5f97daafe 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1769,6 +1769,13 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 
 		hci_dev_clear_flag(hdev, HCI_LE_SCAN);
 
+		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
+		    hci_test_quirk(hdev, HCI_QUIRK_SIMULTANEOUS_DISCOVERY) &&
+		    !test_bit(HCI_INQUIRY, &hdev->flags) &&
+		    hdev->discovery.state == DISCOVERY_FINDING) {
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		}
+
 		/* The HCI_LE_SCAN_INTERRUPTED flag indicates that we
 		 * interrupted scanning due to a connect request. Mark
 		 * therefore discovery as stopped.
-- 
2.53.0

