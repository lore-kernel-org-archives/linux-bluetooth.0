Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v11 09/10] Bluetooth: Handle specific error for SCO connection fallback
Date: Mon, 19 Aug 2013 14:24:02 +0200
Message-Id: <1376915043-24531-10-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1376915043-24531-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1376915043-24531-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Synchronous Connection Complete event can return error "Connection
Rejected due to Limited resources (0x10)".
Handling this error is required for SCO connection fallback. This error
happens when the server tried to accept the connection but failed to
negotiate settings.
This error code has been verified experimentally by sending a T2 request
to a T1 only SCO listener.

Client dump follows :

< HCI Command (0x01|0x0028) plen 17 [hci0] 3.696064
        Handle: 12
        Transmit bandwidth: 8000
        Receive bandwidth: 8000
        Max latency: 13
        Setting: 0x0003
        Retransmission effort: Optimize for link quality (0x02)
        Packet type: 0x0380
> HCI Event (0x0f) plen 4 [hci0] 3.697034
      Setup Synchronous Connection (0x01|0x0028) ncmd 1
        Status: Success (0x00)
> HCI Event (0x2c) plen 17 [hci0] 3.736059
        Status: Connection Rejected due to Limited Resources (0x0d)
        Handle: 0
        Address: xx:xx:xx:xx:xx:AB (OUI 70-F3-95)
        Link type: eSCO (0x02)
        Transmission interval: 0x0c
        Retransmission window: 0x06
        RX packet length: 60
        TX packet length: 60
        Air mode: Transparent (0x03)

Server dump follows :

> HCI Event (0x04) plen 10 [hci0] 4.741513
        Address: xx:xx:xx:xx:xx:D9 (OUI 20-68-9D)
        Class: 0x620100
          Major class: Computer (desktop, notebook, PDA, organizers)
          Minor class: Uncategorized, code for device not assigned
          Networking (LAN, Ad hoc)
          Audio (Speaker, Microphone, Headset)
          Telephony (Cordless telephony, Modem, Headset)
        Link type: eSCO (0x02)
< HCI Command (0x01|0x0029) plen 21 [hci0] 4.743269
        Address: xx:xx:xx:xx:xx:D9 (OUI 20-68-9D)
        Transmit bandwidth: 8000
        Receive bandwidth: 8000
        Max latency: 13
        Setting: 0x0003
        Retransmission effort: Optimize for link quality (0x02)
        Packet type: 0x03c1
> HCI Event (0x0f) plen 4 [hci0] 4.745517
      Accept Synchronous Connection (0x01|0x0029) ncmd 1
        Status: Success (0x00)
> HCI Event (0x2c) plen 17 [hci0] 4.749508
        Status: Connection Rejected due to Limited Resources (0x0d)
        Handle: 0
        Address: xx:xx:xx:xx:xx:D9 (OUI 20-68-9D)
        Link type: eSCO (0x02)
        Transmission interval: 0x0c
        Retransmission window: 0x06
        RX packet length: 60
        TX packet length: 60
        Air mode: Transparent (0x03)

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 50e39f4..a8bb7bb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2904,6 +2904,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 		hci_conn_add_sysfs(conn);
 		break;
 
+	case 0x0d:	/* Connection Rejected due to Limited Resources */
 	case 0x11:	/* Unsupported Feature or Parameter Value */
 	case 0x1c:	/* SCO interval rejected */
 	case 0x1a:	/* Unsupported Remote Feature */
-- 
1.7.9.5

