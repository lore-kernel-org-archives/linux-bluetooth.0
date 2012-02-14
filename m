Return-Path: <cyrus@holtmann.org>
From: rajmohan.mohanan@intel.com
To: linux-bluetooth@vger.kernel.org
Cc: mohanan <rajmohan.mohanan@intel.com>
Subject: [PATCH] LMP transaction collision at Set encryption
Date: Tue, 14 Feb 2012 09:57:01 +0100
Message-Id: <1329209821-2783-1-git-send-email-rajmohan.mohanan@intel.com>
In-Reply-To: <LMP Transaction collision>
References: <LMP Transaction collision>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: mohanan <rajmohan.mohanan@intel.com>

ISSUE:
1. started pairing from my device(DUT) to a remote device (Lenovo T500). After successful bonding bluez send device discovery in the same ACL connection createdprior to BONDING
2. Changed to DUT role as slave.
3. From Host ,sending Set Connection Encryption, getting LMP Error Transaction Collision as status of  encryption command sent by DUT(Slave).(Remote guy who is a master has also initiated Set encryption).
4. In between bluez has initiated SDP search after bonding process complete(device_bonding_complete()).
5. From the encryption change event (event status is 0x23(LMP transaction collision),Bluez disconnecting l2cap and then acl link.
We are not able Find the services of remote device because application written in spite of service discovery has initiated after bonding process

FIX:
Made changes in hci_event.c  for solving LMP Transaction collision.

When we gets Encrypt change event with error code as LMP  transaction collision , Ignoring the change event because From Master Encrypt change event will process and will get encrypt change event with success second time.

If we are not getting Encrypt change event from master we are sending again Set encryption from slave( because we already sent a set encryption which result in to a collision) after 1 second delay.

If we getting a encrypt change event from master after collision event then we delete timer and process it normally.

HCIDUMP:

HCI sniffer - Bluetooth packet analyzer ver 1.42

device: hci0 snap_len: 1028 filter: 0xffffffff

2004-01-01 00:24:28.201531 < HCI Command: Create Connection (0x01|0x0005) plen 13

    bdaddr C4:17:FE:F5:74:DF ptype 0xcc18 rswitch 0x01 clkoffset 0x0000

    Packet type: DM1 DM3 DM5 DH1 DH3 DH5

2004-01-01 00:24:28.214399 > HCI Event: Command Status (0x0f) plen 4

    Create Connection (0x01|0x0005) status 0x00 ncmd 1

2004-01-01 00:24:33.329983 > HCI Event: Connect Complete (0x03) plen 11

    status 0x04 handle 65535 bdaddr C4:17:FE:F5:74:DF type ACL encrypt 0x00

    Error: Page Timeout

2004-01-01 00:24:45.458623 < HCI Command: Create Connection (0x01|0x0005) plen 13

    bdaddr C4:17:FE:F5:74:DF ptype 0xcc18 rswitch 0x01 clkoffset 0x0000

    Packet type: DM1 DM3 DM5 DH1 DH3 DH5

2004-01-01 00:24:45.466521 > HCI Event: Command Status (0x0f) plen 4

    Create Connection (0x01|0x0005) status 0x00 ncmd 1

2004-01-01 00:24:47.052369 > HCI Event: Role Change (0x12) plen 8

    status 0x00 bdaddr C4:17:FE:F5:74:DF role 0x01

    Role: Slave

2004-01-01 00:24:47.213870 > HCI Event: Connect Complete (0x03) plen 11

    status 0x00 handle 256 bdaddr C4:17:FE:F5:74:DF type ACL encrypt 0x00

2004-01-01 00:24:47.214457 < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2

    handle 256

2004-01-01 00:24:47.234339 > HCI Event: Max Slots Change (0x1b) plen 3

    handle 256 slots 5

2004-01-01 00:24:47.234397 > HCI Event: Command Status (0x0f) plen 4

    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1

2004-01-01 00:24:47.234405 > HCI Event: Read Remote Supported Features (0x0b) plen 11

    status 0x00 handle 256

    Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83

2004-01-01 00:24:47.234917 < HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3

    handle 256 page 1

2004-01-01 00:24:47.236452 > HCI Event: Command Status (0x0f) plen 4

    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1

2004-01-01 00:24:47.244773 > HCI Event: Read Remote Extended Features (0x23) plen 13

    status 0x00 handle 256 page 1 max 0

    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00

2004-01-01 00:24:47.244923 < HCI Command: Authentication Requested (0x01|0x0011) plen 2

    handle 256

2004-01-01 00:24:47.246853 > HCI Event: Command Status (0x0f) plen 4

    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1

2004-01-01 00:24:47.246882 > HCI Event: Link Key Request (0x17) plen 6

    bdaddr C4:17:FE:F5:74:DF

2004-01-01 00:24:47.264148 < HCI Command: Remote Name Request (0x01|0x0019) plen 10

    bdaddr C4:17:FE:F5:74:DF mode 2 clkoffset 0x0000

2004-01-01 00:24:47.266043 > HCI Event: Command Status (0x0f) plen 4

    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1

2004-01-01 00:24:47.270761 < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6

    bdaddr C4:17:FE:F5:74:DF

2004-01-01 00:24:47.272375 > HCI Event: Command Complete (0x0e) plen 10

    Link Key Request Negative Reply (0x01|0x000c) ncmd 1

    status 0x00 bdaddr C4:17:FE:F5:74:DF

2004-01-01 00:24:47.272536 > HCI Event: IO Capability Request (0x31) plen 6

    bdaddr C4:17:FE:F5:74:DF

2004-01-01 00:24:47.280195 < HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9

    bdaddr C4:17:FE:F5:74:DF capability 0x01 oob 0x00 auth 0x03

    Capability: DisplayYesNo (OOB data not present)

    Authentication: Dedicated Bonding (MITM Protection)

2004-01-01 00:24:47.282037 > HCI Event: Command Complete (0x0e) plen 10

    IO Capability Request Reply (0x01|0x002b) ncmd 1

    status 0x00 bdaddr C4:17:FE:F5:74:DF

2004-01-01 00:24:48.026091 > HCI Event: IO Capability Response (0x32) plen 9

    bdaddr C4:17:FE:F5:74:DF capability 0x01 oob 0x00 auth 0x05

    Capability: DisplayYesNo (OOB data not present)

    Authentication: General Bonding (MITM Protection)

2004-01-01 00:24:48.027156 > HCI Event: Remote Name Req Complete (0x07) plen 255

    status 0x00 bdaddr C4:17:FE:F5:74:DF name 'ICHAUHAX-MOBL'

2004-01-01 00:24:49.023901 > HCI Event: User Confirmation Request (0x33) plen 10

    bdaddr C4:17:FE:F5:74:DF passkey 733849

2004-01-01 00:24:53.594371 < HCI Command: User Confirmation Request Reply (0x01|0x002c) plen 6

    bdaddr C4:17:FE:F5:74:DF

2004-01-01 00:24:53.596301 > HCI Event: Command Complete (0x0e) plen 10

    User Confirmation Request Reply (0x01|0x002c) ncmd 1

    status 0x00 bdaddr C4:17:FE:F5:74:DF

2004-01-01 00:24:58.224051 > HCI Event: Simple Pairing Complete (0x36) plen 7

    status 0x00 bdaddr C4:17:FE:F5:74:DF

2004-01-01 00:24:58.329211 > HCI Event: Link Key Notification (0x18) plen 23

    bdaddr C4:17:FE:F5:74:DF key 9DAA63E15700DAC5E321CFA90C251CAC type 5

    Type: Authenticated Combination Key

2004-01-01 00:24:58.329246 > HCI Event: Auth Complete (0x06) plen 3

    status 0x00 handle 256

2004-01-01 00:24:58.329536 < HCI Command: Set Connection Encryption (0x01|0x0013) plen 3

    handle 256 encrypt 0x01

2004-01-01 00:24:58.330803 > HCI Event: Command Status (0x0f) plen 4

    Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1

2004-01-01 00:24:58.331115 > HCI Event: Encrypt Change (0x08) plen 4

    status 0x23 handle 256 encrypt 0x00

    Error: LMP Error Transaction Collision

2004-01-01 00:24:58.334127 < HCI Command: Disconnect (0x01|0x0006) plen 3

    handle 256 reason 0x13

    Reason: Remote User Terminated Connection

2004-01-01 00:24:58.335829 > HCI Event: Command Status (0x0f) plen 4

    Disconnect (0x01|0x0006) status 0x00 ncmd 1

2004-01-01 00:24:58.505066 > HCI Event: Disconn Complete (0x05) plen 4

    status 0x00 handle 256 reason 0x16

    Reason: Connection Terminated by Local Host

2004-01-01 00:25:01.005023 < HCI Command: Create Connection (0x01|0x0005) plen 13

    bdaddr C4:17:FE:F5:74:DF ptype 0xcc18 rswitch 0x01 clkoffset 0x0000

    Packet type: DM1 DM3 DM5 DH1 DH3 DH5

2004-01-01 00:25:01.012243 > HCI Event: Command Status (0x0f) plen 4

    Create Connection (0x01|0x0005) status 0x00 ncmd 1

2004-01-01 00:25:04.143950 > HCI Event: Role Change (0x12) plen 8

    status 0x00 bdaddr C4:17:FE:F5:74:DF role 0x01

    Role: Slave

2004-01-01 00:25:04.302687 > HCI Event: Connect Complete (0x03) plen 11

    status 0x00 handle 256 bdaddr C4:17:FE:F5:74:DF type ACL encrypt 0x00

2004-01-01 00:25:04.302884 < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2

    handle 256

2004-01-01 00:25:04.309310 > HCI Event: Command Status (0x0f) plen 4

    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1

2004-01-01 00:25:04.309339 > HCI Event: Max Slots Change (0x1b) plen 3

    handle 256 slots 5

2004-01-01 00:25:04.316336 > HCI Event: Read Remote Supported Features (0x0b) plen 11

    status 0x00 handle 256

    Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83

2004-01-01 00:25:04.316805 < HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3

    handle 256 page 1

2004-01-01 00:25:04.318293 > HCI Event: Command Status (0x0f) plen 4

    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1

2004-01-01 00:25:04.323696 > HCI Event: Read Remote Extended Features (0x23) plen 13

    status 0x00 handle 256 page 1 max 0

    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00

2004-01-01 00:25:04.323868 < ACL data: handle 256 flags 0x00 dlen 10

    L2CAP(s): Info req: type 2

2004-01-01 00:25:04.342133 > HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

2004-01-01 00:25:04.347449 > ACL data: handle 256 flags 0x02 dlen 12

    L2CAP(s): Info rsp: type 2 result 1

      Not supported

2004-01-01 00:25:04.347614 < ACL data: handle 256 flags 0x00 dlen 10

    L2CAP(s): Info req: type 3

2004-01-01 00:25:04.364833 < HCI Command: Remote Name Request (0x01|0x0019) plen 10

    bdaddr C4:17:FE:F5:74:DF mode 2 clkoffset 0x0000

2004-01-01 00:25:04.366772 > HCI Event: Command Status (0x0f) plen 4

    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1

2004-01-01 00:25:10.563930 > HCI Event: Number of Completed Packets (0x13) plen 5

    handle 256 packets 1

2004-01-01 00:25:10.565921 > ACL data: handle 256 flags 0x02 dlen 12

    L2CAP(s): Info rsp: type 3 result 1

      Not supported

2004-01-01 00:25:10.566069 < ACL data: handle 256 flags 0x00 dlen 12

    L2CAP(s): Connect req: psm 1 scid 0x0040

2004-01-01 00:25:40.756957 > HCI Event: Remote Name Req Complete (0x07) plen 255

    status 0x22 bdaddr C4:17:FE:F5:74:DF name ''

    Error: LMP Response Timeout

2004-01-01 00:25:40.756993 > HCI Event: Disconn Complete (0x05) plen 4

    status 0x00 handle 256 reason 0x22

    Reason: LMP Response Timeout

Signed-off-by: mohanan <rajmohan.mohanan@intel.com>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |   11 ++++++-----
 net/bluetooth/hci_conn.c         |   22 +++++++++++++++++++++-
 net/bluetooth/hci_event.c        |   16 ++++++++++------
 4 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 22ddaf3..e2eefdd 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -108,6 +108,7 @@ enum {
 #define HCI_PAIRING_TIMEOUT	(60000)	/* 60 seconds */
 #define HCI_IDLE_TIMEOUT	(6000)	/* 6 seconds */
 #define HCI_INIT_TIMEOUT	(10000)	/* 10 seconds */
+#define HCI_ENCRYPTION_TIMEOUT (1000) /*1 seconds*/
 
 /* HCI data types */
 #define HCI_COMMAND_PKT		0x01
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7a1c03d..e426786 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -197,10 +197,11 @@ struct hci_conn {
 	__u16            pkt_type;
 	__u16            link_policy;
 	__u32		 link_mode;
-	__u8             auth_type;
-	__u8             sec_level;
-	__u8             power_save;
-	__u16            disc_timeout;
+	__u8         auth_type;
+	__u8         sec_level;
+	__u8         power_save;
+	__u16        disc_timeout;
+	__u16        encrypt_timeout;   
 	unsigned long	 pend;
 
 	unsigned int	 sent;
@@ -209,7 +210,7 @@ struct hci_conn {
 
 	struct timer_list disc_timer;
 	struct timer_list idle_timer;
-
+    struct timer_list encrypt_timer;
 	struct work_struct work_add;
 	struct work_struct work_del;
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2f4d30f..22a6df0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -195,7 +195,23 @@ static void hci_conn_idle(unsigned long arg)
 
 	hci_conn_enter_sniff_mode(conn);
 }
+static void hci_conn_encryption(unsigned long arg)
+{
+	struct hci_conn *conn = (void *) arg;
+    
+	BT_DBG("Encryption status check");
 
+	if((conn) && (test_and_clear_bit(HCI_CONN_ENCRYPT_PEND,&conn->pend)))
+	{
+		struct hci_dev *hdev = conn->hdev;
+		del_timer(&conn->encrypt_timer);
+		struct hci_cp_set_conn_encrypt cp;
+		cp.handle  = conn->handle;
+		cp.encrypt = 0x01;
+		hci_send_cmd(hdev, HCI_OP_SET_CONN_ENCRYPT,
+					sizeof(cp), &cp);
+	}
+}
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type,
 					__u16 pkt_type, bdaddr_t *dst)
 {
@@ -216,6 +232,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type,
 
 	conn->power_save = 1;
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
+	conn->encrypt_timeout = HCI_ENCRYPTION_TIMEOUT;
 
 	switch (type) {
 	case ACL_LINK:
@@ -245,6 +262,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type,
 
 	setup_timer(&conn->disc_timer, hci_conn_timeout, (unsigned long)conn);
 	setup_timer(&conn->idle_timer, hci_conn_idle, (unsigned long)conn);
+	setup_timer(&conn->encrypt_timer, hci_conn_encryption, (unsigned long)conn);
 
 	atomic_set(&conn->refcnt, 0);
 
@@ -275,6 +293,8 @@ int hci_conn_del(struct hci_conn *conn)
 
 	del_timer(&conn->disc_timer);
 
+	del_timer(&conn->encrypt_timer);
+
 	if (conn->type == ACL_LINK) {
 		struct hci_conn *sco = conn->link;
 		if (sco)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f7229d2..75719b4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1,6 +1,5 @@
 /*
    BlueZ - Bluetooth protocol stack for Linux
-   Copyright (C) 2012 Intel Mobile Communications GmbH
    Copyright (C) 2000-2001 Qualcomm Incorporated
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
@@ -21,9 +20,6 @@
    ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
    COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
    SOFTWARE IS DISCLAIMED.
-
-notes:
-   18-Jan-2012 Added handling for hci flowspec complete event.
 */
 
 /* Bluetooth HCI event handling. */
@@ -1107,7 +1103,7 @@ static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *
 {
 	struct hci_ev_encrypt_change *ev = (void *) skb->data;
 	struct hci_conn *conn;
-
+    unsigned long timeo;
 	BT_DBG("%s status %d", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -1115,6 +1111,7 @@ static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
 	if (conn) {
 		if (!ev->status) {
+			del_timer(&conn->encrypt_timer);
 			if (ev->encrypt) {
 				/* Encryption implies authentication */
 				conn->link_mode |= HCI_LM_AUTH;
@@ -1122,6 +1119,13 @@ static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *
 			} else
 				conn->link_mode &= ~HCI_LM_ENCRYPT;
 		}
+	   else if(ev->status == 0x23)
+	   {
+	   		BT_DBG("LMP transactioon collision happened, we need to wait");
+			timeo = msecs_to_jiffies(conn->encrypt_timeout);
+		    mod_timer(&conn->encrypt_timer, jiffies + timeo);
+			goto done;
+	   }
 
 		clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend);
 
@@ -1134,7 +1138,7 @@ static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *
 		} else
 			hci_encrypt_cfm(conn, ev->status, ev->encrypt);
 	}
-
+done:
 	hci_dev_unlock(hdev);
 }
 
-- 
1.7.0.4

