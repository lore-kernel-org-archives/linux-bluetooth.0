Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF5EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 01:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6AC160F5A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 01:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344769AbhKPBWq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 20:22:46 -0500
Received: from out2.migadu.com ([188.165.223.204]:54376 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245585AbhKPBUp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 20:20:45 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1637025467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mVL9IEJ77qb3SBwZXmOxr7z8sxQ4j5Eo+YwwTXX0mhU=;
        b=ha4aBFZRHEkySm0DkLfIrkdAZzM3to3//neAhbe6OS1d54hIHzQQaAW/L25vxUeYOH0Po9
        VcnKos4DoxZ5ZXgtSrYCVpPCDQ/nDfOXxJa/Jq7HVTkEagT/nEU7v7vZqk8t7fqZykhnFS
        dtObJz1DIm+Wjf5DbH5fe25Fl0qA0WE=
From:   Jackie Liu <liu.yun@linux.dev>
To:     marcel@holtmann.org
Cc:     chethan.tumkur.narayan@intel.com, luiz.von.dentz@intel.com,
        linux-bluetooth@vger.kernel.org, davem@davemloft.net,
        liu.yun@linux.dev
Subject: [PATCH v2] bluetooth: fix uninitialized variables notify_evt
Date:   Tue, 16 Nov 2021 09:17:17 +0800
Message-Id: <20211116011717.1358715-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: liu.yun@linux.dev
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

Coverity Scan report:

[...]
*** CID 1493985:  Uninitialized variables  (UNINIT)
/net/bluetooth/hci_event.c: 4535 in hci_sync_conn_complete_evt()
4529
4530     	/* Notify only in case of SCO over HCI transport data path which
4531     	 * is zero and non-zero value shall be non-HCI transport data path
4532     	 */
4533     	if (conn->codec.data_path == 0) {
4534     		if (hdev->notify)
>>>     CID 1493985:  Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "notify_evt" when calling "*hdev->notify".
4535     			hdev->notify(hdev, notify_evt);
4536     	}
4537
4538     	hci_connect_cfm(conn, ev->status);
4539     	if (ev->status)
4540     		hci_conn_del(conn);
[...]

Although only btusb uses air_mode, and he only handles HCI_NOTIFY_ENABLE_SCO_CVSD
and HCI_NOTIFY_ENABLE_SCO_TRANSP, there is still a very small chance that
ev->air_mode is not equal to 0x2 and 0x3, but notify_evt is initialized to
HCI_NOTIFY_ENABLE_SCO_CVSD or HCI_NOTIFY_ENABLE_SCO_TRANSP. the context is
maybe not correct.

Let us directly use the required function instead of re-initializing it,
so as to restore the original logic and make the code more correct.

Addresses-Coverity: ("Uninitialized variables")
Fixes: f4f9fa0c07bb ("Bluetooth: Allow usb to auto-suspend when SCO use	non-HCI transport")
Suggested-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 net/bluetooth/hci_event.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7d0db1ca1248..f52394e3d08e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4445,7 +4445,6 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 {
 	struct hci_ev_sync_conn_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
-	unsigned int notify_evt;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -4517,22 +4516,18 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 	}
 
 	bt_dev_dbg(hdev, "SCO connected with air mode: %02x", ev->air_mode);
-
-	switch (ev->air_mode) {
-	case 0x02:
-		notify_evt = HCI_NOTIFY_ENABLE_SCO_CVSD;
-		break;
-	case 0x03:
-		notify_evt = HCI_NOTIFY_ENABLE_SCO_TRANSP;
-		break;
-	}
-
 	/* Notify only in case of SCO over HCI transport data path which
 	 * is zero and non-zero value shall be non-HCI transport data path
 	 */
-	if (conn->codec.data_path == 0) {
-		if (hdev->notify)
-			hdev->notify(hdev, notify_evt);
+	if (conn->codec.data_path == 0 && hdev->notify) {
+		switch (ev->air_mode) {
+		case 0x02:
+			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
+			break;
+		case 0x03:
+			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_TRANSP);
+			break;
+		}
 	}
 
 	hci_connect_cfm(conn, ev->status);
-- 
2.25.1

