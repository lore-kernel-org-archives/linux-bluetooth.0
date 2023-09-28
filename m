Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B20E732D8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 13:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjI1NpZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 09:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjI1NpY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 09:45:24 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC78D11F
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 06:45:22 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230928134518euoutp01ba85cccc6bc0263040cdbadf34ab756e~JE-5j8YdS1757317573euoutp01i
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 13:45:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230928134518euoutp01ba85cccc6bc0263040cdbadf34ab756e~JE-5j8YdS1757317573euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695908718;
        bh=yzjAFToDCY0sWP6m8orD3SoziS7U2dg1LG7e9I3h2A4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=OWSqbM/xWgeyXax2TuZ+dxKT7xAuSk1Ni1EvlqhO9JSL/T97Bys3fvsNcbUXQ2FLS
         DAYn0mSa2ORgyFc5wXFODlzEy1/MpmaVRa7PQY7l2xfoj7fuXz1ed7b+mf4R8lFeU5
         x7yFzUuf7BWoyyEe2lrkmYwpuCPl2Un94306aqpU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230928134517eucas1p24e073f38612c9124389cd4a0f6c345e1~JE-5OrDVF1260812608eucas1p2A;
        Thu, 28 Sep 2023 13:45:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2D.17.42423.D6385156; Thu, 28
        Sep 2023 14:45:17 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230928134517eucas1p296d2f03574a8948e642cfbfb5826539b~JE-45GYHs0616106161eucas1p2H;
        Thu, 28 Sep 2023 13:45:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230928134517eusmtrp2888444279f9e6be0def165f58696bf0a~JE-44f2DU3206832068eusmtrp23;
        Thu, 28 Sep 2023 13:45:17 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-64-6515836d3ef9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 57.EE.10549.D6385156; Thu, 28
        Sep 2023 14:45:17 +0100 (BST)
Received: from AMDC3832.digital.local (unknown [106.120.50.37]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230928134516eusmtip1863c082d40bf3934964196266e3f5009~JE-4nryjU2301823018eusmtip1U;
        Thu, 28 Sep 2023 13:45:16 +0000 (GMT)
From:   Arkadiusz Bokowy <a.bokowy@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Arkadiusz Bokowy <a.bokowy@samsung.com>
Subject: [PATCH] Bluetooth: MGMT: Synchronize scan start and LE Meta events
Date:   Thu, 28 Sep 2023 15:45:06 +0200
Message-Id: <20230928134506.130545-1-a.bokowy@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsWy7djPc7q5zaKpBleXqFis7VzKbDHnWh+z
        A5NH35ZVjB6fN8kFMEVx2aSk5mSWpRbp2yVwZSzt281UMFuj4mfLHfYGxhmKXYycHBICJhKP
        m9axgNhCAisYJR69lO1i5AKyvzBK3H7fwgThfGaUWPi5gxWm48OEc2wQHcsZJfq2lMB1fO26
        xA6SYBPQlfi25ARYg4iAssSzfYeZQGxmAW2JF4emgzULC3hLzF2+HWw1i4CqRPPUb2A1vAJW
        EktXLWaEWCYvsf/gWWaIuKDEyZlPWCDmyEs0b53NDLJYQuARu8SuWROBlnEAOS4SzWfrIHqF
        JV4d38IOYctI/N85nwmipFxiTlsqRGsDo8Sx7VuZIWqsJQ7/+80GUsMsoCmxfpc+RNhR4tSv
        l+wQrXwSN94KQlzAJzFp23RmiDCvREebEES1ksSCuYfZIGwJiXXHf7BA2B4Sx36tYYaEWqzE
        7O9tLBMYFWYh+WsWkr9mIdywgJF5FaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmBSOP3v
        +KcdjHNffdQ7xMjEwXiIUYKDWUmE9+FtoVQh3pTEyqrUovz4otKc1OJDjNIcLErivNq2J5OF
        BNITS1KzU1MLUotgskwcnFINTHF/qxe9XXnP7gXvQebO3yePuRc6qu1O2mx/oJrDfNmxpQen
        VRydnLQ274vfFI+ulSJ/+y+938P4YmG7hfbOCc4vTHfxhCyVjpFdZRl4ekm/xVPHqLR9Nh9/
        pJ14+Gf3HiGlIoXpSy8Uqsy5Vxq+4mPh0q8xCbU3avdJtEvWc3Q/vve1SqS/3XfTAbu7r86Z
        V4RdqCzMebqYYZrmkwXJXuFvpGXqQ35depG1cvrtON0Nm9xyZ0pv+5pz/1ymcv/sxtBAp3OH
        uyz+vZ48fXfhjv9W7yW2nm5e5/Tir61M3bbMnzatF08GvfK1Y/USiFA7dzg8cKOe/Y85CQ1X
        uLk7mRoeHvm1Qv3sU/OABS/TOY2UWIozEg21mIuKEwGYIPXQeQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsVy+t/xu7q5zaKpBu/W8lms7VzKbDHnWh+z
        A5NH35ZVjB6fN8kFMEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk
        5mSWpRbp2yXoZSzt281UMFuj4mfLHfYGxhmKXYycHBICJhIfJpxj62Lk4hASWMoo0bn8OTtE
        QkJi7+PnLBC2sMSfa11QRZ8YJe5/nc8EkmAT0JX4tuQEK4gtIqAs8WzfYbA4s4C2xItD09lA
        bGEBb4m5y7eDDWIRUJVonvoNrIZXwEpi6arFjBAL5CX2HzzLDBEXlDg58wkLxBx5ieats5kn
        MPLNQpKahSS1gJFpFaNIamlxbnpusaFecWJucWleul5yfu4mRmBQbjv2c/MOxnmvPuodYmTi
        YDzEKMHBrCTC+/C2UKoQb0piZVVqUX58UWlOavEhRlOg+yYyS4km5wPjIq8k3tDMwNTQxMzS
        wNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgSnIbebinUeedZcLR0898mMm24bIidnr
        H7LJZIV6+e36Eqce4sVvuiSv5GAzTzr3K7/+ObVVhgfS7J1WHS/laJD96fPOY03pm33C+Q6u
        PsZh3Fbrtj05PWdequ6iSMvtP1ljow67S5TbRm1Wjz0hqJ8XF7dKgf3I+X0rs7kmrbr6dOHX
        0vUHHzWJXTk1vzFpy6PUdM7+yHZ3j8/ntJrWn9o4fSHb4rMzpTedvhZ+zPLQyZMxtzdtMV5l
        dP61N4dVu8Jni2VNb2ar2cXukooNfrL3BP/caWcm/z68ZL77e37uzxu3Tk0JuvCcS2yxdXez
        zO4du8v+uO1brpV1/8q86413GUNMLQq3FlXPTbjCLZ+vxFKckWioxVxUnAgAKNFa89MCAAA=
X-CMS-MailID: 20230928134517eucas1p296d2f03574a8948e642cfbfb5826539b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230928134517eucas1p296d2f03574a8948e642cfbfb5826539b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230928134517eucas1p296d2f03574a8948e642cfbfb5826539b
References: <CGME20230928134517eucas1p296d2f03574a8948e642cfbfb5826539b@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It is possible that the Bluetooth management will receive scan enabled
signal and LE meta events one by another without any delay. Since the
start discovery procedure is performed in an asynchronous manner, it is
possible that these HCI events will be processed concurrently by two
different worker threads. In such case, it is possible that the LE meta
event, which reports new device, will be discarded, because discovering
is still in the starting state.

The problem is most prominent with the btvirt userspace tool, which
sends LE Meta events just after reporting scan as enabled. Testing
scenario:

  1. Create two HCI interfaces:
  > btvirt -l2

  2. Setup BLE advertisement on hci1:
  > bluetoothctl
  >> select 00:AA:01:00:00:00
  >> menu advertise
  >> uuids 03B80E5A-EDE8-4B33-A751-6CE34EC4C700
  >> discoverable on
  >> back
  >> advertise peripheral

  3. Start scanning on hci2:
  > bluetoothctl
  >> select 00:AA:01:01:00:01
  >> scan le
  // From time to time, new device is not reported

To make this issue 100% reproducible, one can simply add slight delay,
e.g. msleep(100) at the beginning of the start_discovery_complete()
function in the net/bluetooth/mgmt.c file.

This patch adds synchronization for start discovery procedure and device
found reporting by the Bluetooth management. In case of discovering
being in the starting state, the worker which processes LE Meta event
will wait for the cmd_sync_work on which the start discovery procedure
is queued.

Signed-off-by: Arkadiusz Bokowy <a.bokowy@samsung.com>
---
 include/net/bluetooth/hci_core.h |  5 +++++
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_sync.c         |  7 +++++++
 net/bluetooth/mgmt.c             | 17 +++++++++++++++--
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f36c1fd5d64e..456bbdf56246 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -916,6 +916,11 @@ static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
 
 bool hci_discovery_active(struct hci_dev *hdev);
 
+static inline bool hci_discovery_starting(struct hci_dev *hdev)
+{
+	return hdev->discovery.state == DISCOVERY_STARTING;
+}
+
 void hci_discovery_set_state(struct hci_dev *hdev, int state);
 
 static inline int inquiry_cache_empty(struct hci_dev *hdev)
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 6efbc2152146..67cf6689a692 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -43,6 +43,7 @@ void hci_cmd_sync_init(struct hci_dev *hdev);
 void hci_cmd_sync_clear(struct hci_dev *hdev);
 void hci_cmd_sync_cancel(struct hci_dev *hdev, int err);
 void __hci_cmd_sync_cancel(struct hci_dev *hdev, int err);
+void hci_cmd_sync_flush(struct hci_dev *hdev);
 
 int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			void *data, hci_cmd_sync_work_destroy_t destroy);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3640d73f9595..58905a5b7b1e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -681,6 +681,13 @@ void hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
 }
 EXPORT_SYMBOL(hci_cmd_sync_cancel);
 
+/* Wait for all pending HCI commands to complete.
+ */
+void hci_cmd_sync_flush(struct hci_dev *hdev)
+{
+	flush_work(&hdev->cmd_sync_work);
+}
+
 /* Submit HCI command to be run in as cmd_sync_work:
  *
  * - hdev must _not_ be unregistered
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ba2e00646e8e..fc494348f2f7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -10374,18 +10374,31 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 {
 	struct sk_buff *skb;
 	struct mgmt_ev_device_found *ev;
-	bool report_device = hci_discovery_active(hdev);
+	bool report_device;
 
 	if (hci_dev_test_flag(hdev, HCI_MESH) && link_type == LE_LINK)
 		mesh_device_found(hdev, bdaddr, addr_type, rssi, flags,
 				  eir, eir_len, scan_rsp, scan_rsp_len,
 				  instant);
 
+	/* Discovery start procedure is perfomed on a workqueue in an
+	 * asynchronous manner. This procedure is finished when the scan
+	 * enabled signal is received from the controller. Just after
+	 * this signal, the controller might send another event (e.g. LE
+	 * Meta). In such case, we need to make sure that the discovery
+	 * procedure is finished, because otherwise we might omit some
+	 * scan results.
+	 */
+	if (hci_discovery_starting(hdev))
+		hci_cmd_sync_flush(hdev);
+
+	report_device = hci_discovery_active(hdev);
+
 	/* Don't send events for a non-kernel initiated discovery. With
 	 * LE one exception is if we have pend_le_reports > 0 in which
 	 * case we're doing passive scanning and want these events.
 	 */
-	if (!hci_discovery_active(hdev)) {
+	if (!report_device) {
 		if (link_type == ACL_LINK)
 			return;
 		if (link_type == LE_LINK && !list_empty(&hdev->pend_le_reports))
-- 
2.34.1

