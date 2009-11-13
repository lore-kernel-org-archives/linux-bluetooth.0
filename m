Return-Path: <cyrus@holtmann.org>
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Nick Pelly <npelly@google.com>
Subject: [PATCH 1/2] Bluetooth: Enter active mode before establishing a SCO link.
Date: Thu, 12 Nov 2009 16:37:50 -0800
Message-Id: <1258072670-20405-1-git-send-email-npelly@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When in sniff mode with a long interval time (1.28s) it can take 4+ seconds to
establish a SCO link. Fix by requesting active mode before requesting SCO
connection. This improves SCO setup time to ~500ms.

Bluetooth headsets that use a long interval time, and exhibit the long SCO
connection time include Motorola H790, HX1 and H17. They have a CSR 2.1 chipset
    BD Address:  00:1A:0E:F2:68:65
    Device Name: Motorola H790
    LMP Version: 2.1 (0x4) LMP Subversion: 0x165d
    Manufacturer: Cambridge Silicon Radio (10)
    Features page 0: 0xdf 0xfe 0x0b 0xc0 0x1b 0xbe 0x59 0x83
        <3-slot packets> <5-slot packets> <encryption> <slot offset>
        <timing accuracy> <hold mode> <sniff mode> <RSSI>
        <channel quality> <SCO link> <HV2 packets> <HV3 packets>
        <u-law log> <A-law log> <CVSD> <paging scheme>
        <transparent SCO> <inquiry with RSSI> <extended SCO>
        <EV4 packets> <EV5 packets> <AFH cap. slave>
        <AFH class. slave> <sniff subrating> <pause encryption>
        <AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps>
        <3-slot EDR eSCO> <extended inquiry> <simple pairing>
        <encapsulated PDU> <non-flush flag> <LSTO> <inquiry TX power>
        <extended features>
    Features page 1: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00

Verified this behavior and fix with host Bluetooth chipsets: BCM4329 and
TI1271.

Signed-off-by: Nick Pelly <npelly@google.com>
---
 net/bluetooth/hci_conn.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a975098..b3e0338 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -376,6 +376,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 
 	if (acl->state == BT_CONNECTED &&
 			(sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
+		hci_conn_enter_active_mode(acl);
 		if (lmp_esco_capable(hdev))
 			hci_setup_sync(sco, acl->handle);
 		else
-- 
1.6.3.1

