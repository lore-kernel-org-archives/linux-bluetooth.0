Return-Path: <cyrus@holtmann.org>
From: Andrew Earl <andrewx.earl@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrew Earl <andrewx.earl@intel.com>
Subject: [PATCH] bluetooth: Fix aborting eSCO connection in case of error 0x20
Date: Mon, 10 Mar 2014 10:31:04 +0000
Message-Id: <1394447464-29164-2-git-send-email-andrewx.earl@intel.com>
In-Reply-To: <1394447464-29164-1-git-send-email-andrewx.earl@intel.com>
References: <1394447464-29164-1-git-send-email-andrewx.earl@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add additional error case to attempt alternative configuration for SCO. Error
occurs with Intel BT controller where fallback is not attempted as the error
0x20 Unsupported LMP Parameter value is not included in the list of errors
where a retry should be attempted.
The problem also affects PTS test case TC_HF_ACS_BV_05_I.

See the HCI log below for details:
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 256 voice setting 0x0060 ptype 0x0380
> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 256 slots 1
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
    status 0x20 handle 0 bdaddr 00:80:98:09:0B:19 type eSCO
    Error: Unsupported LMP Parameter Value
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 256 voice setting 0x0060 ptype 0x0380
> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 256 slots 5
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
    status 0x20 handle 0 bdaddr 00:80:98:09:0B:19 type eSCO
    Error: Unsupported LMP Parameter Value
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 256 voice setting 0x0060 ptype 0x03c8
> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 256 slots 1
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
    status 0x00 handle 257 bdaddr 00:80:98:09:0B:19 type eSCO
    Air mode: CVSD

See btmon log for further details:
> HCI Event (0x0f) plen 4 [hci0] 44.888063
      Setup Synchronous Connection (0x01|0x0028) ncmd 1
        Status: Success (0x00)
> HCI Event (0x1b) plen 3 [hci0] 44.893064
        Handle: 256
        Max slots: 1
> HCI Event (0x2c) plen 17 [hci0] 44.942080
        Status: Unsupported LMP Parameter Value (0x20)
        Handle: 0
        Address: 00:1B:DC:06:04:B0 (OUI 00-1B-DC)
        Link type: eSCO (0x02)
        Transmission interval: 0x00
        Retransmission window: 0x01
        RX packet length: 0
        TX packet length: 0
        Air mode: CVSD (0x02)
> HCI Event (0x1b) plen 3 [hci0] 44.948054
        Handle: 256
        Max slots: 5

Signed-off-by: Andrew Earl <andrewx.earl@intel.com>
---
 net/bluetooth/hci_event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5f81245..59e1b45 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2905,6 +2905,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 	case 0x1c:	/* SCO interval rejected */
 	case 0x1a:	/* Unsupported Remote Feature */
 	case 0x1f:	/* Unspecified error */
+	case 0x20:	/* Unsupported LMP Parameter value */
 		if (conn->out) {
 			conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
 					(hdev->esco_type & EDR_ESCO_MASK);
-- 
1.7.11.7

