Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix bug with filter in service discovery optimization
Date: Wed, 17 Dec 2014 18:18:08 +0100
Message-Id: <1418836688-77018-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The optimization for filtering out extended inquiry results, advertising
reports or scan response data based on provided UUID list has a logic
bug. In case no match is found in the advertising data, the scan
response is ignored and not checked against the filter. This will lead
to events being filtered wrongly.

Change the code to actually only drop the events when the scan response
data is not present. If it is present, it needs to be checked against
the provided filter.

The patch is a bit more complex than it needs to be. That is because
it also fixes this compiler warning that some gcc versions produce.

  CC      net/bluetooth/mgmt.o
net/bluetooth/mgmt.c: In function ‘mgmt_device_found’:
net/bluetooth/mgmt.c:7028:7: warning: ‘match’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  bool match;
       ^

It seems that gcc can not clearly figure out the context of the match
variable. So just change the branches for the extended inquiry response
and advertising data around so that it is clear.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 23a0ca5a4737..6c5a8cc06b43 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7081,13 +7081,15 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		 * kept and checking possible scan response data
 		 * will be skipped.
 		 */
-		if (hdev->discovery.uuid_count > 0) {
+		if (hdev->discovery.uuid_count > 0)
 			match = eir_has_uuids(eir, eir_len,
 					      hdev->discovery.uuid_count,
 					      hdev->discovery.uuids);
-			if (!match)
-				return;
-		}
+		else
+			match = true;
+
+		if (!match && !scan_rsp_len)
+			return;
 
 		/* Copy EIR or advertising data into event */
 		memcpy(ev->eir, eir, eir_len);
@@ -7096,8 +7098,10 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		 * provided, results with empty EIR or advertising data
 		 * should be dropped since they do not match any UUID.
 		 */
-		if (hdev->discovery.uuid_count > 0)
+		if (hdev->discovery.uuid_count > 0 && !scan_rsp_len)
 			return;
+
+		match = false;
 	}
 
 	if (dev_class && !eir_has_data_type(ev->eir, eir_len, EIR_CLASS_OF_DEV))
-- 
2.1.0

