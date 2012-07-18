Return-Path: <cyrus@holtmann.org>
From: <ramm@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Ram Malovany <ramm@ti.com>
Subject: [PATCH 1/3] Bluetooth: Do not resolve name if entry was not found.
Date: Wed, 18 Jul 2012 15:06:04 +0300
Message-ID: <1342613166-23651-1-git-send-email-ramm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ram Malovany <ramm@ti.com>

If entry wasn't found in the hci_inquiry_cache_lookup_resolve do not
resolve the name.

Signed-off-by: Ram Malovany <ramm@ti.com>
---
 net/bluetooth/hci_event.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 41ff978..2de521f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1365,6 +1365,9 @@ static bool hci_resolve_next_name(struct hci_dev *hdev)
 		return false;
 
 	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_NEEDED);
+	if (!e)
+		return false;
+
 	if (hci_resolve_name(hdev, e) == 0) {
 		e->name_state = NAME_PENDING;
 		return true;
-- 
1.7.4.1

