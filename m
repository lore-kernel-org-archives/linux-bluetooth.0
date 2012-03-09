Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix extra conversion to __le32
Date: Fri,  9 Mar 2012 13:00:50 +0200
Message-Id: <1331290850-30092-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Value to be converted is already in __le32 format.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/mgmt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7fcff88..97b5b6c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3107,7 +3107,7 @@ int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	bacpy(&ev.addr.bdaddr, bdaddr);
 	ev.addr.type = link_to_mgmt(link_type, addr_type);
 	ev.confirm_hint = confirm_hint;
-	put_unaligned_le32(value, &ev.value);
+	ev.value = value;
 
 	return mgmt_event(MGMT_EV_USER_CONFIRM_REQUEST, hdev, &ev, sizeof(ev),
 			  NULL);
-- 
1.7.9

