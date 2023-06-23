Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AB6C0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 07:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjFWHjV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 03:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjFWHjR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 03:39:17 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5051F1BF7
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 00:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyLSbpc9Jsbo9Hq9Dt+JO+Z7ECKiLCjCwS2nDAxKsknHnZxzlH391D46u3DVL7yFOUpQIdR4xowKci3w3g7hIw/8dPkrc8BhkfflFfggt5qxVAE4Pwg0qoooX4Oy2A8Nx85byVasM104ay3vFBXAHZgY4t3GFdo5NsBRjN18TiWe9BE5dM0o/k1ALYC+cp3zzhevGg159MgRA55EpKn+w+twqIA8wYZbxB7QpocijtSvBy9FfFWuYF9SMTfVWOW9rhFxmUy+3HmNZCncwCIvajvNDaHirwkNQsl015WGAND13sgxGwneQuXRAg5Uq+YVFFCImRakehXswScJNx6Hfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWpj30nsnmc7C9C4MwLx689wH3eJVWDgInOoHJa7Np4=;
 b=BTOkK5XXgzuNNqLUZTwDH7pYyC6cS3/7M+x/TQTtoB6eENoyK3EgJ/S9Fc0R2JVij5I/43WYFZlhSYeqNdBKTjSKdHeFR0p+PxuGCdLb4nk97vMm06ClBF8+GSwrXdcAvBO6/tL7KY8gUOzUi7QKpPdYgXwwql2JN4pPSSRxgnOuH8sRAeSzIjUbwfO0cORoIKzHVMJi1PJ7KdX94/GMmQL53rozP0QEJHx/jfEZQ1ZBESCgaNAhLm2/YF9N9EkItnzLXO1/ob28Gt5a87XgpFV8LpG5Rf68cRG8IOUUgLA/AR2hyj09WXDnRT+sPxMzysH7mHt1O5Ynp2u5Pd77zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWpj30nsnmc7C9C4MwLx689wH3eJVWDgInOoHJa7Np4=;
 b=X0/gHzbb35F21Ic4+KdrPtQzKqyDKXU3ZM5ugCqS8fwk0Ba0EyST8OMVEGmWbjXv8yJjvvA9/EwCKB2aExcs7/cC630k6l9jmW4XA4zrefGfLtQN/ZL0wbwZuIbACxWyuqKbkN6/7/rIBjurF/B9FASmwi6CxqyiqRke+MYK4tU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAWPR04MB9816.eurprd04.prod.outlook.com (2603:10a6:102:390::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 07:39:14 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:39:14 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Notify user space about failed bis connections
Date:   Fri, 23 Jun 2023 10:38:42 +0300
Message-Id: <20230623073842.16466-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623073842.16466-1-iulia.tanasescu@nxp.com>
References: <20230623073842.16466-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0193.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::30) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAWPR04MB9816:EE_
X-MS-Office365-Filtering-Correlation-Id: e9db3fa2-6a85-49fb-eb74-08db73bcf12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ROpQEop4hCeX0aS7tPSMYaA6xSqRbcWMtDcHAPwkuVbooYiHjNyUzgyWqCJDfw8QD0TbUZKbJ8S5yRY30gR2gFxz5EUKwOHpSTbmxqUuuRBHSrVAEY0RMFjE/4+q5PjXzKkz4o19lpxQ3zisOhpkrNCRIKsKfsRqa6lBJTDhHAtZ8hkG8FR0Qj5QviceZv7wMHMVzDk7nPhG5YPDAdkMg8QiuLCwgVv1hnicNewUDZw/Zmnf4e4t0k8fTG7yZhg1yy5EVi92t0Nz2JGWF04aM9jnnmo218O8w5MWG1TG1moNXGltC6O9LpjZcgwLqlqci0ViefJFBtBTgMT8dMmQTS8RhuSDAU9E0lF4OIH+eUUgmTCsexjn/xqZpzT/yN1bhs0qz8a7vDVHtTcRLfBNJjWStlzj7INgOY8XwE1vT/D99dn5LovjBhRDm6klK7IEQjR8btFMMmNce7Z/QuxXBj7FhjNoO1VFLlwxUNFh4/FyCAp18T0Rishw5Nw56STvimIgYCGmeHfrDEkQi7mtCo7t+ftE4K/SS7fKw4+921USJL1R3H/2QTp//iAvnn7NFEV7XvE6FxAL4d6M9u4sEWyKc9ADLt1heSEBsez+ZuW/d8iDjjqzv+2y6V7+Nly
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(66946007)(66556008)(316002)(66476007)(4326008)(6916009)(6512007)(8676002)(8936002)(26005)(186003)(6506007)(2616005)(1076003)(41300700001)(6486002)(6666004)(52116002)(2906002)(478600001)(5660300002)(44832011)(30864003)(38350700002)(38100700002)(83380400001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fp1nUVSeKADBWsauqiEwXmAVOV2aBaA2hlT80G1RXI349koApzdvM1bux9R1?=
 =?us-ascii?Q?6jFuEiczt7Osom/eqcmU0slvKbMn3UB4Qw7/DvHr3E7w0JYenIcR/4lnHg+d?=
 =?us-ascii?Q?IxwZdlxX/vv2a4436y7u2GI6TuYchP8e6tZBiJB0MA7i2u998N+zdkvgOKzH?=
 =?us-ascii?Q?enW+LAf8966+cQeRqMyM/4meh9GDfKxJQT8VL4G9SWPY2Eu8hD7EK2lDnWhp?=
 =?us-ascii?Q?TGYeF3cI/TP3guAM8ZwDAiydcxjxCKhz31hl+b9y2uPNGwkZ3ZN0Ss/czzEm?=
 =?us-ascii?Q?NqF4cVpxbxsSu2PPXuWa0XqyKRAXjrBS6JywSiFhpyKm2P1KJ2NjyA5TOi69?=
 =?us-ascii?Q?kJNIjgHVCwa9s93rILLOqgdLo3qy3OESZqMMqZxr9dgaYEo/g782DuuQSdld?=
 =?us-ascii?Q?n8PELuHxeUPuIYptV0lB0jfWDH/mf96/Ma30b/tuyeNRM1ilf5umRc8cOzFZ?=
 =?us-ascii?Q?UASPiQLaCTJNMH45/1ELuu/9n/5+qMjWT1FAuNV1dMaS5MkJ6fNJ74sLjkXF?=
 =?us-ascii?Q?+wBn+xgEC56y6/OV3GYlHLTAvaB7x0JYd4xcPcWsLw1wizvcLIoUXeSUfX8v?=
 =?us-ascii?Q?B4SEOHvyalU/+FXfaXsukc/6/foD0C7NkMviZZkvlYTfKRxa+PeAR99GlnHx?=
 =?us-ascii?Q?aowpZLNaFNi/P01ne6wV186VXLfuNp2N7B/isunbql8B3lrDurJbBMfH4re9?=
 =?us-ascii?Q?wl+M+GwlrryszmTvoqZsHYrHp/r7EeS1PNHqebPDud833xvmzdotGxL+rvqx?=
 =?us-ascii?Q?H469bHV6DLjwndy6Je6MojP8tN0rIN8/YTDFkTUa7jKzxODUPFP97G24laP1?=
 =?us-ascii?Q?NR2NqVdTlWDNy5mu7eKUmQ2P8B39Ke9ADKGrta2//v00FKGaWKQvJ00gjvW2?=
 =?us-ascii?Q?Tcz7HjmHd1aQvUHMyq/JbIKYO6Hc4M5e2+eoK4rSFF+ctEMv3xOOEPgeasi2?=
 =?us-ascii?Q?NeUSezo/8o8Vz/OLyvtYyoY7f1m3vkO2l+qdVw98qbnWX45HUvQL1UIzxVtd?=
 =?us-ascii?Q?tcZNo9CIVMX/D+2SXMRK6JAGJ/8XdRmwN73FeyHIe3CK3ypMLuccI4mcJASL?=
 =?us-ascii?Q?SYu+0AXbz7sX/7PPBw7b7lO/cMtvPK3OcqojWUX+ewJWuREYpXoaA+HGm25x?=
 =?us-ascii?Q?6Xk2RJNLg1JmLKtZWdapp2O9RoQR+gYBKR9FBgLeeVcHMJDwWzCJeppQnKOR?=
 =?us-ascii?Q?c9XH4x/qDnPKt5CB3RH+eeCr1ihDSSOzpSJw8thQOLEZTNoT4PlKDNfZzDEA?=
 =?us-ascii?Q?GdmvC3ddslx4o+EjXT2Ex6jFje9HjKPFIStmiX/GaEPn7bZQhvLAVNQ5hMpP?=
 =?us-ascii?Q?4CV+v2q5SMQmJmtsYKv5eHwzTW9Y2MXo3t2FOlvo0jj/EZ6+2vt17QnF8aVY?=
 =?us-ascii?Q?hSAyPJXhtNzxz8HDs23A/2Q33G1wXU+WNnPMES8UIRXe0hsDEu1gT07eXurZ?=
 =?us-ascii?Q?nduiHVcEr4JYzy3ksWO/8cJq7gIojRIYQi6+xTO63/LC7WHyayHy2Shrv7Ba?=
 =?us-ascii?Q?Kcc9g8N0ggDrO9xFnavrgvQq41nZZiDBbwR70WcLPAOZwbC7NurRcLx2nMXZ?=
 =?us-ascii?Q?jXfN1Y/ijEIAP6HaDYE+TkCHYXrhMy0DRqLWu46I0HMKDj0+Kga5F+SBYgXb?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9db3fa2-6a85-49fb-eb74-08db73bcf12b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:39:14.2237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2vKg/+aJKOGAy4IYpHwiEzxibnavV8wYoIfoya4Qla/h+hA3gqhZSNsxc6aj5Em/SJAFMF6AOKyjwRZHwFKug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9816
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some use cases require the user to be informed if BIG synchronization
fails. This commit makes it so that even if the BIG sync established
event arrives with error status, a new hconn is added for each BIS,
and the iso layer is notified about the failed connections.

Unsuccesful bis connections will be marked using the BT_BIG_SYNC_FAILED
state. From the iso layer, the POLLERR event is triggered on the newly
allocated bis sockets, before adding them to the accept list of the
parent socket.

From user space, a new fd for each failed bis connection will be
obtained by calling accept. The user should check for the POLLERR
event on the new socket, to determine if the connection was successful
or not.

To ensure proper cleanup of the unsuccessful bises, the le_bis_cleanup
work callback has been added, similar to le_scan_cleanup. The callback
deletes the hci connection and notifies the disconnect to the iso layer,
so the socket is also cleaned up.

The HCI_CONN_BIG_SYNC flag has been added to mark whether the BIG sync
has been successfully established. This flag is checked at bis cleanup,
so the HCI LE BIG Terminate Sync command is only issued if needed.

The BT_SK_BIG_SYNC flag indicates if BIG create sync has been called
for a listening socket, to avoid issuing the command everytime a BIGInfo
advertising report is received.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/bluetooth.h |  5 +-
 include/net/bluetooth/hci_core.h  | 25 ++++++++++
 net/bluetooth/hci_conn.c          | 78 +++++++++++++++++++++++++++++--
 net/bluetooth/hci_event.c         | 21 +++++++--
 net/bluetooth/iso.c               | 37 ++++++++++-----
 5 files changed, 145 insertions(+), 21 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 34998ae8ed78..b05147cf4c57 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -292,7 +292,8 @@ enum {
 	BT_CONNECT2,
 	BT_CONFIG,
 	BT_DISCONN,
-	BT_CLOSED
+	BT_CLOSED,
+	BT_BIG_SYNC_FAILED,
 };
 
 /* If unused will be removed by compiler */
@@ -317,6 +318,8 @@ static inline const char *state_to_string(int state)
 		return "BT_DISCONN";
 	case BT_CLOSED:
 		return "BT_CLOSED";
+	case BT_BIG_SYNC_FAILED:
+		return "BT_BIG_SYNC_FAILED";
 	}
 
 	return "invalid state";
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 05a9b3ab3f56..81e83ecdd267 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -761,6 +761,7 @@ struct hci_conn {
 	struct delayed_work idle_work;
 	struct delayed_work le_conn_timeout;
 	struct work_struct  le_scan_cleanup;
+	struct work_struct  le_bis_cleanup;
 
 	struct device	dev;
 	struct dentry	*debugfs;
@@ -978,6 +979,7 @@ enum {
 	HCI_CONN_PER_ADV,
 	HCI_CONN_BIG_CREATED,
 	HCI_CONN_CREATE_CIS,
+	HCI_CONN_BIG_SYNC,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
@@ -1288,6 +1290,29 @@ static inline struct hci_conn *hci_conn_hash_lookup_big(struct hci_dev *hdev,
 	return NULL;
 }
 
+static inline struct hci_conn *hci_conn_hash_lookup_big_any_dst(struct hci_dev *hdev,
+							__u8 handle)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type != ISO_LINK)
+			continue;
+
+		if (handle == c->iso_qos.bcast.big) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+
 static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
 							__u8 type, __u16 state)
 {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 62a7ccfdfe63..e4aa7731b987 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -207,6 +207,36 @@ static void le_scan_cleanup(struct work_struct *work)
 	hci_conn_put(conn);
 }
 
+static void le_bis_cleanup(struct work_struct *work)
+{
+	struct hci_conn *conn = container_of(work, struct hci_conn,
+					     le_bis_cleanup);
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_conn *c = NULL;
+
+	BT_DBG("%s hcon %p", hdev->name, conn);
+
+	hci_dev_lock(hdev);
+
+	/* Check that the hci_conn is still around */
+	rcu_read_lock();
+	list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
+		if (c == conn)
+			break;
+	}
+	rcu_read_unlock();
+
+	if (c == conn) {
+		conn->state = BT_CLOSED;
+		hci_disconn_cfm(conn, hci_proto_disconn_ind(conn));
+		hci_conn_del(conn);
+	}
+
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+	hci_conn_put(conn);
+}
+
 static void hci_connect_le_scan_remove(struct hci_conn *conn)
 {
 	BT_DBG("%s hcon %p", conn->hdev->name, conn);
@@ -229,6 +259,28 @@ static void hci_connect_le_scan_remove(struct hci_conn *conn)
 	schedule_work(&conn->le_scan_cleanup);
 }
 
+static void hci_bis_remove(struct hci_conn *conn)
+{
+	BT_DBG("%s hcon %p", conn->hdev->name, conn);
+
+	/* We can't call hci_conn_del/hci_conn_cleanup here since that
+	 * could deadlock with another hci_conn_del() call that's holding
+	 * hci_dev_lock and doing cancel_delayed_work_sync(&conn->disc_work).
+	 * Instead, grab temporary extra references to the hci_dev and
+	 * hci_conn and perform the necessary cleanup in a separate work
+	 * callback.
+	 */
+
+	hci_dev_hold(conn->hdev);
+	hci_conn_get(conn);
+
+	/* Even though we hold a reference to the hdev, many other
+	 * things might get cleaned up meanwhile, including the hdev's
+	 * own workqueue, so we can't use that for scheduling.
+	 */
+	schedule_work(&conn->le_bis_cleanup);
+}
+
 static void hci_acl_create_connection(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -686,6 +738,12 @@ static void hci_conn_timeout(struct work_struct *work)
 		return;
 	}
 
+	/* Cleanup bises that failed to be established */
+	if (conn->state == BT_BIG_SYNC_FAILED) {
+		hci_bis_remove(conn);
+		return;
+	}
+
 	hci_abort_conn(conn, hci_proto_disconn_ind(conn));
 }
 
@@ -793,6 +851,7 @@ struct iso_list_data {
 	int count;
 	struct iso_cig_params pdu;
 	bool big_term;
+	bool big_sync_term;
 };
 
 static void bis_list(struct hci_conn *conn, void *data)
@@ -880,24 +939,26 @@ static int big_terminate_sync(struct hci_dev *hdev, void *data)
 	if (d->count)
 		return 0;
 
-	hci_le_big_terminate_sync(hdev, d->big);
+	if (d->big_sync_term)
+		hci_le_big_terminate_sync(hdev, d->big);
 
 	return hci_le_pa_terminate_sync(hdev, d->sync_handle);
 }
 
-static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, u16 sync_handle)
+static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *conn)
 {
 	struct iso_list_data *d;
 	int ret;
 
-	bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big, sync_handle);
+	bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big, conn->sync_handle);
 
 	d = kzalloc(sizeof(*d), GFP_KERNEL);
 	if (!d)
 		return -ENOMEM;
 
 	d->big = big;
-	d->sync_handle = sync_handle;
+	d->sync_handle = conn->sync_handle;
+	d->big_sync_term = test_and_clear_bit(HCI_CONN_BIG_SYNC, &conn->flags);
 
 	ret = hci_cmd_sync_queue(hdev, big_terminate_sync, d,
 				 terminate_big_destroy);
@@ -933,8 +994,14 @@ static void bis_cleanup(struct hci_conn *conn)
 
 		hci_le_terminate_big(hdev, conn);
 	} else {
+		bis = hci_conn_hash_lookup_big_any_dst(hdev,
+						       conn->iso_qos.bcast.big);
+
+		if (bis)
+			return;
+
 		hci_le_big_terminate(hdev, conn->iso_qos.bcast.big,
-				     conn->sync_handle);
+				     conn);
 	}
 }
 
@@ -1067,6 +1134,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
 	INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
 	INIT_WORK(&conn->le_scan_cleanup, le_scan_cleanup);
+	INIT_WORK(&conn->le_bis_cleanup, le_bis_cleanup);
 
 	atomic_set(&conn->refcnt, 0);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b1aefe4bb751..5629a118ece4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7020,9 +7020,6 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 				flex_array_size(ev, bis, ev->num_bis)))
 		return;
 
-	if (ev->status)
-		return;
-
 	hci_dev_lock(hdev);
 
 	for (i = 0; i < ev->num_bis; i++) {
@@ -7046,9 +7043,25 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 		bis->iso_qos.bcast.in.latency = le16_to_cpu(ev->interval) * 125 / 100;
 		bis->iso_qos.bcast.in.sdu = le16_to_cpu(ev->max_pdu);
 
-		hci_iso_setup_path(bis);
+		if (!ev->status) {
+			set_bit(HCI_CONN_BIG_SYNC, &bis->flags);
+			hci_iso_setup_path(bis);
+		}
 	}
 
+	/* In case BIG sync failed, notify each failed connection to
+	 * the user after all hci connections have been added
+	 */
+	if (ev->status)
+		for (i = 0; i < ev->num_bis; i++) {
+			u16 handle = le16_to_cpu(ev->bis[i]);
+
+			bis = hci_conn_hash_lookup_handle(hdev, handle);
+
+			bis->state = BT_BIG_SYNC_FAILED;
+			hci_connect_cfm(bis, ev->status);
+		}
+
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 84d238d0639a..a2571d8ea055 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -48,6 +48,11 @@ static void iso_sock_kill(struct sock *sk);
 #define EIR_SERVICE_DATA_LENGTH 4
 #define BASE_MAX_LENGTH (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH)
 
+/* iso_pinfo flags values */
+enum {
+	BT_SK_BIG_SYNC,
+};
+
 struct iso_pinfo {
 	struct bt_sock		bt;
 	bdaddr_t		src;
@@ -58,7 +63,7 @@ struct iso_pinfo {
 	__u8			bc_num_bis;
 	__u8			bc_bis[ISO_MAX_NUM_BIS];
 	__u16			sync_handle;
-	__u32			flags;
+	unsigned long		flags;
 	struct bt_iso_qos	qos;
 	bool			qos_user_set;
 	__u8			base_len;
@@ -1569,6 +1574,12 @@ static void iso_conn_ready(struct iso_conn *conn)
 		hci_conn_hold(hcon);
 		iso_chan_add(conn, sk, parent);
 
+		if (ev && ((struct hci_evt_le_big_sync_estabilished *)ev)->status) {
+			/* Trigger error signal on chilld socket */
+			sk->sk_err = ECONNREFUSED;
+			sk->sk_error_report(sk);
+		}
+
 		if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
 			sk->sk_state = BT_CONNECT2;
 		else
@@ -1637,15 +1648,19 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 			if (ev2->num_bis < iso_pi(sk)->bc_num_bis)
 				iso_pi(sk)->bc_num_bis = ev2->num_bis;
 
-			err = hci_le_big_create_sync(hdev,
-						     &iso_pi(sk)->qos,
-						     iso_pi(sk)->sync_handle,
-						     iso_pi(sk)->bc_num_bis,
-						     iso_pi(sk)->bc_bis);
-			if (err) {
-				bt_dev_err(hdev, "hci_le_big_create_sync: %d",
-					   err);
-				sk = NULL;
+			if (!test_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
+				set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags);
+
+				err = hci_le_big_create_sync(hdev,
+							     &iso_pi(sk)->qos,
+							     iso_pi(sk)->sync_handle,
+							     iso_pi(sk)->bc_num_bis,
+							     iso_pi(sk)->bc_bis);
+				if (err) {
+					bt_dev_err(hdev, "hci_le_big_create_sync: %d",
+						   err);
+					sk = NULL;
+				}
 			}
 		}
 	} else {
@@ -1688,7 +1703,7 @@ static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 
 	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
 
-	if (!status) {
+	if (!status || hcon->state == BT_BIG_SYNC_FAILED) {
 		struct iso_conn *conn;
 
 		conn = iso_conn_add(hcon);
-- 
2.34.1

