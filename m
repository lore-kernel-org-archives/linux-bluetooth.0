Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD23F18BBBA
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325647; cv=fail; b=sM2jRkJUDrmeR/cEl5VGg8q+6wbxuSpPDrkPFZQPKIYJbCuqE7Qp1t8amUt4MmU1ZXiUGwgPdngORzfaUBkrfdTxpmd/Gylz4frQnyUq8HQwRfyEoZscPf9oTzY6ZpbEMds6r0H0mzHNkuafxJNQhEVptsWEt2T5i2iwFyjgiJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325647; c=relaxed/simple;
	bh=/6RyafZMUdXK5NCdmlCx8XDZhE9Lk2NysKuaghwwqCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rCJgK7vdqFg8Qdej18KEcEDmJ2BWp7nhKIh+dL6QYcb4CRLQkfmg5I9fb1y1TfI6LBx6OIXejzlnj4qkd0Gm41832SJNjwnq/09n5HJ9WwdnhOurzjjGV4++6rjyLNHV09z63d2p5WRoyxcxBpOt7CZQ4pOqaqayRPJSjOhjLXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NyX0FCLl; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NyX0FCLl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IW/2VzH1tiTOU3t4HWgTprObR9GYxt4//IsHEfZ5HVTBrrQhJTSCluo76efaSq7KP8zvXJ6CERdT+PKMIqt4hSl4bycFq3/WFA/A2rM3NqTVskDARNzuV+KBzkc0Slj3YTLUoWWiH3BMrNeYAqkURGGs7jrvUEWAy0rTLoWiHc4DUzEYuvJBkVTF2DLs5YfgUK/0OGij2OsYWK6EKwDvHS1PGTiJ33mech6pSXKdSM64ODHdeSXq4PMienJv+vuDv9EL7n/2aeZmcZNqicTcUQV9zHukmPX8xuI9h3C44sdHd/vkO2XtWEUJSajZADqyF6oqIYneFtJs+sH995a5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzCUFV0PNUoyPlEn5Ek+zSvhZOIopqFZADMAvzfDqiA=;
 b=x4mBVu5N8LtdV5RYsca6hY/bi57oZ1hLfJantGfyU7cFnsTzsE0HcPxaXfG5o3P0vMJEc4XkQivjViswBNBmCD9Li7QHOsqaIR5UVCow5KdpnzzLXUAdeaIJ2JYRiF2qfrTq8cgjMuZwChkXhk0Zb89hJmPFqcnTe6qn2haEioYBbQv2JJ2EDBpoNwdntuVrywE7PHSSCMOWBYs8A+w2quUN1ZOEJLOWBzI31husFap7LiSoyQC1tsomdjwuVTFzKjFvNHJmuTIStmJtgnHbKdnvKgGcaI1JP+javgu0AboXeYFUacwNOHd7VXLxXZIHC63VulLzcEoFGLwWZrkoow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzCUFV0PNUoyPlEn5Ek+zSvhZOIopqFZADMAvzfDqiA=;
 b=NyX0FCLlq5sNzBWvN9Ngy0kjHQQ+VP6zf3M+3K4/ywWX1V4IbHv+HnNdSE3UGyPgcdZUzBBty6L+qiRtH2VP7XKnoYC/x3heVI3nxJ0gg2rHfG69ppZUCPuq9oLv5vbk28uDJpG+KV44Dxln3sxOK47r9AqupCI0zeDHGllCkq4uwAwHiCJTzv+2A1CwWJrq7wXC/E79bka33oP7IwU+OXymulsRnHw5yriRKiF6m6IMTD9LcdI+YxjROHXYndvjPaHxNri64/vDvRY/LREmKd4Lk6uWPuOYLcXo53z206PGPLKkkTAySJPmvBnteLX+oIIjsnLtC992iLbDQcuaJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS5PR04MB9998.eurprd04.prod.outlook.com (2603:10a6:20b:67e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 11:47:19 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 11:47:19 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 2/2] Bluetooth: ISO: Send BIG Create Sync via hci_sync
Date: Mon, 11 Nov 2024 13:47:08 +0200
Message-ID: <20241111114708.10722-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111114708.10722-1-iulia.tanasescu@nxp.com>
References: <20241111114708.10722-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0079.eurprd05.prod.outlook.com
 (2603:10a6:208:136::19) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS5PR04MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: 336bb00b-1369-4ef5-28c6-08dd024698c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DR2+gwEDQtPrgqqwEuddQOCTMEjqQ0vthcZIyWOJVy3IkZuQePHQ71zHbJbe?=
 =?us-ascii?Q?/MbT/rIydnSY0NLNaRvI9g6NEBEhARtMNpo1hQwIT0F8pAQwM6lWrmI2jJJX?=
 =?us-ascii?Q?UI/VTSnv92HZGQrKOXkB8a0jU/uaAf+SBeJYec9boZktwYwK+DA09TTneDqR?=
 =?us-ascii?Q?Zob74HMo2JK6Ip45Gm6YHx6EfoGMxoHjrKFMnWP3xzPfuqGNpcOUOOfBZzhG?=
 =?us-ascii?Q?R7bT7Sw8Jo5qpMkRRIdnZ9qSOYbuh6A9iLp16Oz5hGcHylL2IuZEWiYe98FC?=
 =?us-ascii?Q?d5/lDVdVbYYy15EHxNhr6pQdO3EUlo0WPewWEiZ0Inp4ER0OaoTWdYOn/rrL?=
 =?us-ascii?Q?ULCWod7iX4DU1FQpYNI6gapgmBOeT09pReYs23q9F411jmN5OzNbMj1nZUrG?=
 =?us-ascii?Q?gfth+eawR1xzGhqjZebsY8ttQioYain5a4xGnWnhBScWQMDXmnW5m4pokctZ?=
 =?us-ascii?Q?VK6d3nNhhB+c1ti6YYYIK9Q9E3m2ndVvNJ/bJ2RIxJ+dROzW4hb2tJ+jZqhg?=
 =?us-ascii?Q?Y9pdg95B6dNzKCuwqqn1w+eeUiUnTx0nOPLQ2xNirl2YnxRoDz3W/v7NtuKI?=
 =?us-ascii?Q?U/nH4FT9EbaSK9B3hxptCiACH25VAkpnSjzY6CN9GDp5gz8Ngp5+nK5JqTKx?=
 =?us-ascii?Q?vHn0dxp/aBsGY3nweGqq/VSgsrjCxRfKfosCGXFNMs27BbGwDQKHT8wZBMtx?=
 =?us-ascii?Q?izQT8An8SeiyRqnPenP8QinhzpZrPFrTdArpe4Dkt9TcPqrtXlpP5tCete8w?=
 =?us-ascii?Q?Xk17oNJhk5a14fPdhnP6adZMiLpqGa0Jm1TVxoPlePDLR7JeCwkF/6iOZ7DQ?=
 =?us-ascii?Q?7E6TJO+Qvp0QKk8GZlmHsxp+UwIr7khCh/fXFtYf083+sUp1gaCPHvFsmUEf?=
 =?us-ascii?Q?EVaZcIj+vRI+kf2WvMA7nM4r5zupgkF7cNV4pvA2xVrvge5SET1dm+bzzX14?=
 =?us-ascii?Q?0t29+9cUX+tC6+LpTWCTZOE9jCEuLBLuS6pjtiSloN6isoDWR16T+GQKjSvG?=
 =?us-ascii?Q?XJIkbFB2EoNA9horMm+8iGCs3u/WVDq/Kv1sUJEuLSkzaSDIDxaF6g6YKzwA?=
 =?us-ascii?Q?Nqgd7NYFxvJomr98ACLAEelusD/TWfw9c4R5YptAccs/0iAYVb9Hq4UYouFv?=
 =?us-ascii?Q?U+6iZ9DmRIBo5+U3gLlNGRfG6izeXQyGla3rlM4gDg3R59YYRXB2Xl1J8ImR?=
 =?us-ascii?Q?9se8S9KzkwImhKDbTES7YXI2K9foSrwoqBTSs5oUFBFzbXAvdHCOeB7guPRu?=
 =?us-ascii?Q?HJiDL7WhMMe9dDMANQdARudw37GC6/CDEMSRBl5wjuTUWQFapaDIFdMgy+Xf?=
 =?us-ascii?Q?cvk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yT1alvHhVH+zpk7lugiFzq+zJFXVoQ8N4Rsk+IHspAcpdNFgmTBs1YcjwJNB?=
 =?us-ascii?Q?uOeQ3qtH3S0i/nZ2JMdyt/Ku8dP3B+mlmCAvLu0YKiWJKxS/izk0irtosJ4w?=
 =?us-ascii?Q?7wMqWIJ7PG916i+qEmLozg68jIgPzBlfmq3Fvxql7bLBWgbUKAyXu2GBRUub?=
 =?us-ascii?Q?3D9y3dS6bbOFPOgKzu6P6e5Lg2Zj8r9SLiVCYpVhWUee98IjYDJhRI7wF+gn?=
 =?us-ascii?Q?1qa3ErdYuEkKe75x+Rl4wgkUUUyL4uNm79Wm0K7X5TB0cgnQ3nD9R3eG0vVL?=
 =?us-ascii?Q?56Cy4tBY55Z7o6lHcMBEfF5UzsY/TLc/mUq571yNLVoYa0eUP4c9jin7eWBw?=
 =?us-ascii?Q?hV49XfZ8WGezYMtidRISJqUdP+FPsWNnC9l8Ys4AAQvBj4Mg35XuVoEzJf6O?=
 =?us-ascii?Q?cnsQ2os9efkJ2bAy/abU/CRgk9kDDAjr+bb97Qx7goDs9Q1AXrFhjZtwQqD4?=
 =?us-ascii?Q?JrPanVrPcMdQsHv3RILQ1+rckeDP/mrLU2QZQtOJ12KT8Sr3LHZlED4uNw2/?=
 =?us-ascii?Q?YQqzcVDz2+ylLa/+qs1rYNH1EYqSQwFrKcsoL6O4IoSSpIyyFLb8rk+OI3AK?=
 =?us-ascii?Q?R6eCoaYw9L9MobFifevH6v20BMHLZm1J/O1d+uZyzCCueOFxMSTAsFINqjNf?=
 =?us-ascii?Q?qMmb/xyAZhyVgTJ4bc5q3NFuBn3+vrmYlsDNPV3CXETFOOtA0uvERW+rZniD?=
 =?us-ascii?Q?Ud7FGdarA8dwyZKZFUTMg25LOAg09uB8kLwB96PxLnOLI0V62iBEMK+M5es/?=
 =?us-ascii?Q?j95ellFALd2QT70fKrL2Ex3rBiLdaqyaSQLigUiXh6lfNbCr2QaXrUuc5mod?=
 =?us-ascii?Q?5T1XCj2GO0TeJT2u69kkbb4B4AyBncJ6xVMrJMXP8QV1lFyXFrJp5MgTIa+Y?=
 =?us-ascii?Q?70Rtil8pwewEXFONgfyLDju9EdhUY2PjUGOJi5xcsoU/MElRJHwUMFjC7Yph?=
 =?us-ascii?Q?D5cew6uTtvRluHibr2uHGzgw9u6PJgHPdsWFD1UWxtDItJFoiSG6wiNeLV9T?=
 =?us-ascii?Q?Y1hEqTIx54ubSoZisDtkMU1BJLxT0ytm8RmItbOHrEGmuGcJ85+dV3mxdhQW?=
 =?us-ascii?Q?kJ5kjdedC2TP+RZ3QpB+tnAv38LHB5jS1gjQaYT1xt6niI0CgIFLbqunxnfW?=
 =?us-ascii?Q?sGmtAUWBsvEEoPyA4YetZYRQUAG9l8dPetVIadKUrgh4c1zQDLAy47QAm8KM?=
 =?us-ascii?Q?FXQBKoCQtYQZAgrNgJv2EEYYyIiyCYTRmhq6nM0/TEih5N7BAE+P1iIInXsv?=
 =?us-ascii?Q?ZbFWbrtIOhPAxgA6pkV4wsjQLUlStukxWwQI4emk3bAl4pIUcd05NlBHKGDp?=
 =?us-ascii?Q?tdkEUpjpACWQtKWwuF9xE8tZvytb9QY+bov7F7kw+14YiCFonlwa6YnGpVvY?=
 =?us-ascii?Q?nqRt85KVr79DNDocRqgnnTJkHsuHHYz12OTzv8HpOQCBlWtgCPrKUhCNgrfU?=
 =?us-ascii?Q?GgZB2EpwWH8Nm+2adGzjLTYKM638zgRrGx7WF1HqBcK3c/K4egq0MddYYKay?=
 =?us-ascii?Q?kkI0ZmwXtD5Ouln8YS/BIDJo6Bem2GThjXY9t6VgnrQ93YzXIGXJO4BvRI6Q?=
 =?us-ascii?Q?JZKymawgMQGy2Na6X95jNlyZYwEaDGL68husSVuybsepbbpTqUNCt9X6b454?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336bb00b-1369-4ef5-28c6-08dd024698c7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 11:47:19.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8ll0DYcQCHs2nSyfxDCjtO2jMKF9f1dCDzkKVnBTSCe+ld++Ry+pVx/h3d1RGNQ/GvbfAzl1Yze1F9F+3/o8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9998

Before issuing the LE BIG Create Sync command, an available BIG handle
is chosen by iterating through the conn_hash list and finding the first
unused value.

If a BIG is terminated, the associated hcons are removed from the list
and the LE BIG Terminate Sync command is sent via hci_sync queue.
However, a new LE BIG Create sync command might be issued via
hci_send_cmd, before the previous BIG sync was terminated. This
can cause the same BIG handle to be reused and the LE BIG Create Sync
to fail with Command Disallowed.

< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)
        BIG Handle: 0x00
        BIG Sync Handle: 0x0002
        Encryption: Unencrypted (0x00)
        Broadcast Code[16]: 00000000000000000000000000000000
        Maximum Number Subevents: 0x00
        Timeout: 20000 ms (0x07d0)
        Number of BIS: 1
        BIS ID: 0x01
> HCI Event: Command Status (0x0f) plen 4
      LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
        Status: Command Disallowed (0x0c)
< HCI Command: LE Broadcast Isochronous Group Terminate Sync (0x08|0x006c)
        BIG Handle: 0x00

This commit fixes the ordering of the LE BIG Create Sync/LE BIG Terminate
Sync commands, to make sure that either the previous BIG sync is
terminated before reusing the handle, or that a new handle is chosen
for a new sync.

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/hci_conn.c | 17 ++++++++++++++++-
 net/bluetooth/iso.c      |  9 +++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b5b78d469d54..d097e308a755 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2180,7 +2180,15 @@ static bool hci_conn_check_create_big_sync(struct hci_conn *conn)
 	return true;
 }
 
-int hci_le_big_create_sync_pending(struct hci_dev *hdev)
+static void big_create_sync_complete(struct hci_dev *hdev, void *data, int err)
+{
+	bt_dev_dbg(hdev, "");
+
+	if (err)
+		bt_dev_err(hdev, "Unable to create BIG sync: %d", err);
+}
+
+static int big_create_sync(struct hci_dev *hdev, void *data)
 {
 	DEFINE_FLEX(struct hci_cp_le_big_create_sync, pdu, bis, num_bis, 0x11);
 	struct hci_conn *conn;
@@ -2237,6 +2245,13 @@ int hci_le_big_create_sync_pending(struct hci_dev *hdev)
 			    struct_size(pdu, bis, pdu->num_bis), pdu);
 }
 
+int hci_le_big_create_sync_pending(struct hci_dev *hdev)
+{
+	/* Queue big_create_sync */
+	return hci_cmd_sync_queue_once(hdev, big_create_sync,
+				       NULL, big_create_sync_complete);
+}
+
 int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 			   struct bt_iso_qos *qos,
 			   __u16 sync_handle, __u8 num_bis, __u8 bis[])
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 9e119da43147..70ea1bbd5e4b 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1338,6 +1338,13 @@ static void iso_conn_big_sync(struct sock *sk)
 	if (!hdev)
 		return;
 
+	/* hci_le_big_create_sync requires hdev lock to be held, since
+	 * it enqueues the HCI LE BIG Create Sync command via
+	 * hci_cmd_sync_queue_once, which checks hdev flags that might
+	 * change.
+	 */
+	hci_dev_lock(hdev);
+
 	if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
 		err = hci_le_big_create_sync(hdev, iso_pi(sk)->conn->hcon,
 					     &iso_pi(sk)->qos,
@@ -1348,6 +1355,8 @@ static void iso_conn_big_sync(struct sock *sk)
 			bt_dev_err(hdev, "hci_le_big_create_sync: %d",
 				   err);
 	}
+
+	hci_dev_unlock(hdev);
 }
 
 static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
-- 
2.43.0

