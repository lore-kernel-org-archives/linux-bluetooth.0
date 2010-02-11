Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 11 Feb 2010 15:56:01 -0500
Message-ID: <9c9ad6a31002111256v1c3394d1rade3c3640ee7efb5@mail.gmail.com>
Subject: [PATCH] eSCO fallback to SCO on Error: Connection Failed to Complete
From: smcoe1 <smcoe1@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Below is a patch necessary to pass test case TC_AG_ACS_BC_10_I on
SIG's PTS Software


2007-09-20 12:08:09.471838 > HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
2007-09-20 12:08:09.479874 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 39 slots 1
2007-09-20 12:08:11.821730 > HCI Event: Synchronous Connect Complete
(0x2c) plen 17
    status 0x11 handle 39 bdaddr 00:16:93:01:01:7A type eSCO
    Error: Unsupported Feature or Parameter Value
2007-09-20 12:08:11.821839 < HCI Command: Setup Synchronous Connection
(0x01|0x0028) plen 17
    handle 39 voice setting 0x0060
2007-09-20 12:08:11.824099 > HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 0
2007-09-20 12:08:11.832809 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 39 slots 5
2007-09-20 12:08:11.832840 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2007-09-20 12:08:11.841195 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 39 slots 1
2007-09-20 12:08:12.063088 > HCI Event: Synchronous Connect Complete
(0x2c) plen 17
    status 0x00 handle 38 bdaddr 00:16:93:01:01:7A type SCO
    Air mode: CVSD


Signed-off-by: Stephen Coe <smcoe1@gmail.com>
---
 net/bluetooth/hci_event.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 592da5c..715162c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1698,6 +1698,7 @@ static inline void
hci_sync_conn_complete_evt(struct hci_dev *hdev, struct sk_bu
 		hci_conn_add_sysfs(conn);
 		break;

+	case 0x11:	/* Connection Failed to Complete */
 	case 0x1c:	/* SCO interval rejected */
 	case 0x1a:	/* Unsupported Remote Feature */
 	case 0x1f:	/* Unspecified error */
