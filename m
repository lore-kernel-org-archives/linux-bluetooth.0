Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44358E;
	Mon, 11 Dec 2023 18:38:42 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BC2Uhc763147471, This message is accepted by code: ctloc85258
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BC2Uhc763147471
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
	Tue, 12 Dec 2023 10:30:45 +0800
Received: from alexlu (172.29.36.158) by RSEXMBS01.realsil.com.cn
 (172.29.17.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Dec
 2023 10:30:43 +0800
Date: Tue, 12 Dec 2023 10:30:34 +0800
From: Alex Lu <alex_lu@realsil.com.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg
	<johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Max Chou <max.chou@realtek.com>, Karen Hsu <karenhsu@realtek.com>
Subject: [PATCH v3] Bluetooth: Add more enc key size check
Message-ID: <ZXfFyoEhCj_S70qp@alexlu>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: RSEXH36502.realsil.com.cn (172.29.17.3) To
 RSEXMBS01.realsil.com.cn (172.29.17.195)

From: Alex Lu <alex_lu@realsil.com.cn>

When we are slave role and receives l2cap conn req when encryption has
started, we should check the enc key size to avoid KNOB attack or BLUFFS
attack.
From SIG recommendation, implementations are advised to reject
service-level connections on an encrypted baseband link with key
strengths below 7 octets.
A simple and clear way to achieve this is to place the enc key size
check in hci_cc_read_enc_key_size()

The btmon log below shows the case that lacks enc key size check.

> HCI Event: Connect Request (0x04) plen 10
        Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Class: 0x480104
          Major class: Computer (desktop, notebook, PDA, organizers)
          Minor class: Desktop workstation
          Capturing (Scanner, Microphone)
          Telephony (Cordless telephony, Modem, Headset)
        Link type: ACL (0x01)
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
        Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Role: Peripheral (0x01)
> HCI Event: Command Status (0x0f) plen 4
      Accept Connection Request (0x01|0x0009) ncmd 2
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11
        Status: Success (0x00)
        Handle: 1
        Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
...

> HCI Event: Encryption Change (0x08) plen 4
        Status: Success (0x00)
        Handle: 1 Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Encryption: Enabled with E0 (0x01)
< HCI Command: Read Encryption Key Size (0x05|0x0008) plen 2
        Handle: 1 Address: BB:22:33:44:55:99 (OUI BB-22-33)
> HCI Event: Command Complete (0x0e) plen 7
      Read Encryption Key Size (0x05|0x0008) ncmd 2
        Status: Success (0x00)
        Handle: 1 Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Key size: 6
// We should check the enc key size
...

> ACL Data RX: Handle 1 flags 0x02 dlen 12
      L2CAP: Connection Request (0x02) ident 3 len 4
        PSM: 25 (0x0019)
        Source CID: 64
< ACL Data TX: Handle 1 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 3 len 8
        Destination CID: 64
        Source CID: 64
        Result: Connection pending (0x0001)
        Status: Authorization pending (0x0002)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 1 Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Count: 1
        #35: len 16 (25 Kb/s)
        Latency: 5 msec (2-7 msec ~4 msec)
< ACL Data TX: Handle 1 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 3 len 8
        Destination CID: 64
        Source CID: 64
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Max Chou <max.chou@realtek.com>
---
Changes in v3:
  - Use a simple and clear approach according to maintainer's suggestion
Changes in v2:
  - Fix compiling issue reported by sparse

 net/bluetooth/hci_event.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2ad7b9f86f74..ef8c3bed7361 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -750,9 +750,23 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
 	} else {
 		conn->enc_key_size = rp->key_size;
 		status = 0;
+
+		if (conn->enc_key_size < hdev->min_enc_key_size) {
+			/* As slave role, the conn->state has been set to
+			 * BT_CONNECTED and l2cap conn req might not be received
+			 * yet, at this moment the l2cap layer almost does
+			 * nothing with the non-zero status.
+			 * So we also clear encrypt related bits, and then the
+			 * handler of l2cap conn req will get the right secure
+			 * state at a later time.
+			 */
+			status = HCI_ERROR_AUTH_FAILURE;
+			clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
+			clear_bit(HCI_CONN_AES_CCM, &conn->flags);
+		}
 	}
 
-	hci_encrypt_cfm(conn, 0);
+	hci_encrypt_cfm(conn, status);
 
 done:
 	hci_dev_unlock(hdev);
-- 
2.39.2

