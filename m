Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2042.outbound.protection.outlook.com [40.107.247.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B494156C69
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449448; cv=fail; b=ra0t9FF/6S0F+7m2IXaMnfM5vf6fYxqYka7IP5R3dnEi2UvqLLTTq5oSr6lfX1qZWz3sYPFG28MBB5HcjmfcHaApG7AF+b4zeSJTfNtLczzoigory4nAURDj7P9R5ZLlopqeVOhWdrpDIaDbFcg2XKdNYbl7pmOFwlrv58iwFq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449448; c=relaxed/simple;
	bh=xSR+JTucWVl582CjC2JPO1+iNcdHwIGXYAKUU2Hy6qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgd1NahNHzm7q1rFUxOLII8jFvaGPaUgtTI3ye7X0anMp4IeCAYMpEhoJzm/HwyTd2K9pvCnJRvRz3573k+GcxpSElQtT1IMLTAj81zu7lJu5MiwpZjIs6kiSK/D/ZEqK1iOpZ6YmYQ2cI9v4owaHXziPaA0Jktas2/+G0OXRXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l5E/yBxf; arc=fail smtp.client-ip=40.107.247.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l5E/yBxf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vjm+2w4RREfoZJR+x4c0HoGBT8UyjQ398KopQ5rD2WNA3S15CeTx9WmzS1Fj6Is/7L9wE0OyUkBMl/FQNZEQYSfEZC3AszTjGYgbrlzLnL3mhzkfY9lJaCEY2kdPNmn7+COM81cW9dzA/3zMDTOWinXQRsFeIegAFGF6mLVYB/h7vFeZn/aY2NtpnfWgl4gYWOIlBf3FtGsqgfr4014U3uLT18dnMetQrrpsakOlgpTj0rzTQbM6W9DZrlqGZTfKLpZCw0y5zC/JmkAU7ClnEFe56XnFAsJWs7jF5NEOZHv43g27zoEogPzY7Ml2oeFMcvF+BTgbvW5qWmr0dikUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkPrVbovLvFqMJH2Fk0MC66SWU6eALhWkAoctEQGQ64=;
 b=gow0uWdgCQ6NH6DH+IXjQ5QtqV19fRBMjP+N0Cxj+zSGacGgBx8aa2qG6UvL5VfWixAXLDDFFQYgLY7gLVx9Xm8hM1ch9ELqN3y69pme/rU9eJM943lURJbDeBsjfJRNoNGBR0TmUR5UFwSGYFSuc/tU8xaucVZa6fFUtYDnxA9fBc9qFa/L70B15TS4902MvPxiaFlRlDkhwfgT7OJnz66ieCsZz9HBdls1HByd8XlhWqcgys1npA9Ykbdiwes+Pt/4uAwUKU/Sk1g9VNaHwJVUEWKfSVbXDT+wZsbzunriQHUuVlccTfH6lEN1MtubR77R7HBFdWZyverk22cX8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkPrVbovLvFqMJH2Fk0MC66SWU6eALhWkAoctEQGQ64=;
 b=l5E/yBxfKFAS6pmai7hfs/VqFtSaPkYw9pj3GbZon+fViYj7jp0XanHyUm8SeNJA83ZR1xhXEGHUb4YkEgx37V9O5gMp/IB50FjEERIifkrnws5y/ejZcE06N0moBfkM/qjkJERE0DOsVlhPALLUoKRB56ypD0dNTYhlRadGkQ/7RiLNH0Kfco5AaAArDA2Le9wDB5YwaclpcY+JMZK8WuaWzfNJDQOLbjVRHVjY9D6M9e1dNkjuR5bFkKJ3I0D1LBq36wpC5sH7TDwTUdHvfWf9Cz1YluF842fS0TiNJbhQcpT+/kfer5gSHsozLLc0zEBO4toiaHaPKh5nivW4lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7921.eurprd04.prod.outlook.com (2603:10a6:20b:247::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 08:24:02 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 08:24:02 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 3/4] Bluetooth: ISO: Do not emit LE BIG Create Sync if previous is pending
Date: Fri,  1 Nov 2024 10:23:38 +0200
Message-ID: <20241101082339.4278-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101082339.4278-1-iulia.tanasescu@nxp.com>
References: <20241101082339.4278-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0033.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: b015cf79-b14a-41fd-357b-08dcfa4e8a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c4dE6KuYcWWSc5v1YQevXDMkWDox5ZgNutqVnjQ7+30QGZAe3l6nsUaTIqr6?=
 =?us-ascii?Q?eZhtLDOvH48ReOQxjrX+YK+BJGPeoN3J9WUvCRoFMk56KkeGOoFQ/+zyaToY?=
 =?us-ascii?Q?WykCp13rXvgh/aZsavUyssQgwoC1j/Yop7hgAeii8WOHO4n1HlXu9lInE9xd?=
 =?us-ascii?Q?YNMsQzWE/BOUUJSje9AoshHxF8LiXTY77R2auagJ14Les5xzJFlnNXZFLtLN?=
 =?us-ascii?Q?nPzVHaOulmI6m3v5BWeKyktqpq7vD6NBRRHKnHgcuqu4VArPKLtnOupTjs9F?=
 =?us-ascii?Q?aPCKI6O3n7xMu3QueYl3+UJt597DwoOuE3c44aIX+ITMoz2lTLap9wnZs0GR?=
 =?us-ascii?Q?b4bn6OehtgtwzkcYi/Q425muKjrVQ0u7NxtgQ4rJ2bWHqcbEJmUeRYz1j0GZ?=
 =?us-ascii?Q?tu+NmiIrhZ5VtesayBXPjhHrPjCat1KYlXfyDEz8av1+k4e2wdy+SEetgMvn?=
 =?us-ascii?Q?wRhnflpcncMG6lHyrxVc2rwBfIX10LTkyJ8gvB2YgxkcxHhbOCU/BSJcHEWX?=
 =?us-ascii?Q?+c6DMZxzVeBYquU+9yJEie0qSasqTZzbTp/Z3CwHgcCNbnOqqB1sYkbDo7hl?=
 =?us-ascii?Q?PaKh32SNFziMg6VvALqb1oJLLhYPaGPcCmmPJu67ZQQHAu8Qz/v3UgxCvbPD?=
 =?us-ascii?Q?ArLru5Hi8nCPTBaudPpMB3of3ZWzU4b4Rrca96DAlVMEIx4h67gBYai49hxC?=
 =?us-ascii?Q?JHr6ZEqCmvnkxAnjLLSXwTKqpUG6Lvb/OKgbr5GEVX86ppyoIuzLoyhaTQGq?=
 =?us-ascii?Q?2ZyJ3AaqJccOFOlreOQ+7GYRGYzg0zBqknrUAI44/zq4FSYg7t5p16Zp7o5p?=
 =?us-ascii?Q?CkFvzw5lDCXwzOrJ/SLnpvAB2Nc89O19TppsP83yuTeL06SHwnIxJkqiU3lk?=
 =?us-ascii?Q?tA+vpEOtYseRxxA6TBxmHf0iIzSh+JyzFg7Xy+iquWdEyVvEdSWUYPfdBc+o?=
 =?us-ascii?Q?OJNDHcBFZINI4pyWo/1c5ZA8Z1dgj+7NSNqNn56iNbj1SNJjsGNRFjutaf0h?=
 =?us-ascii?Q?UCouz1ROxSDYlRjbFMLgO5IwurF9V6EAv45cIeg2l4TGrMHPOLEAneYaaRep?=
 =?us-ascii?Q?u74r9dy/sicfvOvqP0EqxkSnBEPmBl9UYlglXM7KqRCDopAlT99u+1H5+Fzz?=
 =?us-ascii?Q?4FI8/LjSxxCyjew9UFosZca93e1l6zyVu+PTdhplhRtDmv2cU2g5NYVCSkqw?=
 =?us-ascii?Q?IeWSonLM2YOX6OdYyCfrpC9t0prQ+hW5Xm1o1Nswzbm3oCLB3flEsoLYVz/x?=
 =?us-ascii?Q?7J/o9REKdXEv9BMbbhGxcd0P1BDaQmu8qxnDy+3NCszDPp0Oc5hUv4pGUtiG?=
 =?us-ascii?Q?8bv3mIn35ojeUWH7FW4l9IYyYB7bq568CICGYXCfuXm+HLzxc5dOpdbBmvU6?=
 =?us-ascii?Q?KOy989Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FgFdil9Uo2r7vQLS5953XuqT9Iy4H2xBylO5+9MGvSZqgfuPQejJ/5ykuyzG?=
 =?us-ascii?Q?2JYOikl6etRz7AVJ1sKFZMe3AhjXQgWG691vaYKhUSusXc6WDc/9b9VM0MWk?=
 =?us-ascii?Q?sO7NSIcKif6Hq5GAAqSl6Z1ga1/AX3FudegPGDzLvP+6o44B9V+tC074eH4l?=
 =?us-ascii?Q?scCcjMwHXfCI28x/r/gfWb4Ms7DGWJ85d4l4nfDkc9sA5Ui6EU+6/iBos2mC?=
 =?us-ascii?Q?w5BXWp8lrtgAyY2Un513cqG/WsR37/Pn8JVyNpSvZVqfcsDrVVk1THA4iZ52?=
 =?us-ascii?Q?6vapLPjRSbvzMu1qI692Jw+rxnXmcn2etSpDL2/N9UQZfi9GrKDUPcavDU9F?=
 =?us-ascii?Q?3sI0M6JZ6eKx5OjFVl/1C4ipaSOxQGZ4ycpw2A62is/i0nrvf/blQWpLLjJf?=
 =?us-ascii?Q?Brm3COT5ZXySaEMIzGrguamWEhvetMIgkegl2qiBaz3QZ1RyGV8Q45ku8W72?=
 =?us-ascii?Q?MGtVl1tFZiXwbEJo1VbR/Y/5LobtFbB+c/yxohXr1OE6MOu/VIZFphEytE/o?=
 =?us-ascii?Q?54CDMWuzoOCqHp6X5Uy8CaYi/ur+DUSWVQQXcXarfwFJfdptuqsUYDM4Egcy?=
 =?us-ascii?Q?SjriTRgEeO/V5Zd3EJSvLX3x+tBRm+yUA0vpUFipRexZVzAcQNefsjIo6/K0?=
 =?us-ascii?Q?qGO1bTYxsU+RskKoT5UbxBrrLrDXkHreifim6SO7pd5GeOOga+xoObx0dZBJ?=
 =?us-ascii?Q?JoyDw4cU6ZHlyeOFtScCfxyT30QrexM+HAckLgw2eiV4W4sHwc3+rjSH5+uz?=
 =?us-ascii?Q?QxLMwJ3YiGbjGb1GnIlgLmlEyq6SDbeUv1q2y5rXzSxs7mBrr1MdEM2IdWCl?=
 =?us-ascii?Q?fOInbk31dksneg/p34UsBRnvc/akbW0ZQ2jDJ6vKfwdhWzm43A6wlxqj7AMS?=
 =?us-ascii?Q?lDGJYnr2insa9xzW1GFF1Qi45d6qYTkAv2QeEAF7NdBfiQm6hGk+jeGSD2TJ?=
 =?us-ascii?Q?/KLhroU7taWg/5tJPkwSDkey36cLWPUjwU/+ApCKKBF4DyEIqLc/rk2YwQyq?=
 =?us-ascii?Q?cQ2KlkDm/jkyoh2ZfUSu7YXTYaVL8PyUJbGZkFec1u3D8vVwaiXtPQZ7F6D4?=
 =?us-ascii?Q?+KKwM5TR5zcGdGIRpWvYzhyc2x9BU+MGnSDFats9f1I0Lz2omSGzxF5ysMt3?=
 =?us-ascii?Q?V5j1iR3/7VUt65N5O+47tOsTURiLlAJofD8Px1YFxYuj4P0YJvpo497m6+RF?=
 =?us-ascii?Q?Gu2Z7FLvE/9Jj85gXqQmv47XNKDoV+oZq4vmb42m5PG50jhh5VYv5ZqByZ2A?=
 =?us-ascii?Q?k+XTKosXluuI+9aTARNle3fJ5hCY25L3zqzii8B4D0lY9x1XeO/7w7AlatLe?=
 =?us-ascii?Q?2tMQpeQJbYFgYfbZQvlim83UUK4McvSH/jqGUovQF02wmlRQAhdJJ/XrH3z7?=
 =?us-ascii?Q?gAvbbJXHBTQu0VEugYz7GI5WAwo0C6MD1/GdQ6/0e8CcdgFx2El9LF2u8lo/?=
 =?us-ascii?Q?qkk2kBHeTkhrXDLh506EnZELSUuY8VXNLlwwcSVr4m+3Toe7iPMEO3MMhJUK?=
 =?us-ascii?Q?IBKFvTRFzir8CBtgs+uUPfUV4tLMcfgN1C7YidIuVufIXtUgL3d017EEH0p8?=
 =?us-ascii?Q?tBo6MZ8CextV684hfM90aNqJM52LDXbAK3thoN9E7Jai/pYuOwGlrROg43/O?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b015cf79-b14a-41fd-357b-08dcfa4e8a97
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:24:02.0532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTcIN53ipS8SK4hYYkSjEpUg+4MUPc6KJtum83qLvKoE0WSM7WN1CJX8mmcO87x4gzk1yMLKJrICm5l5WS3EQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7921

The Bluetooth Core spec does not allow a LE BIG Create sync command to be
sent to Controller if another one is pending (Vol 4, Part E, page 2586).

In order to avoid this issue, the HCI_CONN_CREATE_BIG_SYNC was added
to mark that the LE BIG Create Sync command has been sent for a hcon.
Once the BIG Sync Established event is received, the hcon flag is
erased and the next pending hcon is handled.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h | 29 +++++++++++
 net/bluetooth/hci_conn.c         | 87 +++++++++++++++++++++++++++-----
 net/bluetooth/hci_event.c        | 20 +++++++-
 net/bluetooth/iso.c              |  4 +-
 5 files changed, 125 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4becf201b063..5bb4eaa52e14 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -29,6 +29,7 @@
 #define HCI_MAX_ACL_SIZE	1024
 #define HCI_MAX_SCO_SIZE	255
 #define HCI_MAX_ISO_SIZE	251
+#define HCI_MAX_ISO_BIS		31
 #define HCI_MAX_EVENT_SIZE	260
 #define HCI_MAX_FRAME_SIZE	(HCI_MAX_ACL_SIZE + 4)
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 43474b751a50..c95f7e6ba255 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -711,6 +711,9 @@ struct hci_conn {
 	__s8		tx_power;
 	__s8		max_tx_power;
 	struct bt_iso_qos iso_qos;
+	__u8		num_bis;
+	__u8		bis[HCI_MAX_ISO_BIS];
+
 	unsigned long	flags;
 
 	enum conn_reasons conn_reason;
@@ -946,6 +949,7 @@ enum {
 	HCI_CONN_PER_ADV,
 	HCI_CONN_BIG_CREATED,
 	HCI_CONN_CREATE_CIS,
+	HCI_CONN_CREATE_BIG_SYNC,
 	HCI_CONN_BIG_SYNC,
 	HCI_CONN_BIG_SYNC_FAILED,
 	HCI_CONN_CREATE_PA_SYNC,
@@ -1295,6 +1299,30 @@ static inline struct hci_conn *hci_conn_hash_lookup_big(struct hci_dev *hdev,
 	return NULL;
 }
 
+static inline struct hci_conn *
+hci_conn_hash_lookup_big_sync_pend(struct hci_dev *hdev,
+				   __u8 handle, __u8 num_bis)
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
+		if (handle == c->iso_qos.bcast.big && num_bis == c->num_bis) {
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
 static inline struct hci_conn *
 hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u16 state)
 {
@@ -1479,6 +1507,7 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status);
 bool hci_iso_setup_path(struct hci_conn *conn);
 int hci_le_create_cis_pending(struct hci_dev *hdev);
 int hci_pa_create_sync_pending(struct hci_dev *hdev);
+int hci_le_big_create_sync_pending(struct hci_dev *hdev);
 int hci_conn_check_create_cis(struct hci_conn *conn);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f9da12339db8..e996e9763666 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2180,34 +2180,93 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 	return conn;
 }
 
+static bool hci_conn_check_create_big_sync(struct hci_conn *conn)
+{
+	if (!conn->num_bis)
+		return false;
+
+	return true;
+}
+
+int hci_le_big_create_sync_pending(struct hci_dev *hdev)
+{
+	DEFINE_FLEX(struct hci_cp_le_big_create_sync, pdu, bis, num_bis, 0x11);
+	struct hci_conn *conn;
+
+	rcu_read_lock();
+
+	pdu->num_bis = 0;
+
+	/* The spec allows only one pending LE BIG Create Sync command at
+	 * a time. If the command is pending now, don't do anything. We
+	 * check for pending connections after each BIG Sync Established
+	 * event.
+	 *
+	 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
+	 * page 2586:
+	 *
+	 * If the Host sends this command when the Controller is in the
+	 * process of synchronizing to any BIG, i.e. the HCI_LE_BIG_Sync_
+	 * Established event has not been generated, the Controller shall
+	 * return the error code Command Disallowed (0x0C).
+	 */
+	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
+		if (test_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags))
+			goto unlock;
+	}
+
+	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
+		if (hci_conn_check_create_big_sync(conn)) {
+			struct bt_iso_qos *qos = &conn->iso_qos;
+
+			set_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+
+			pdu->handle = qos->bcast.big;
+			pdu->sync_handle = cpu_to_le16(conn->sync_handle);
+			pdu->encryption = qos->bcast.encryption;
+			memcpy(pdu->bcode, qos->bcast.bcode,
+			       sizeof(pdu->bcode));
+			pdu->mse = qos->bcast.mse;
+			pdu->timeout = cpu_to_le16(qos->bcast.timeout);
+			pdu->num_bis = conn->num_bis;
+			memcpy(pdu->bis, conn->bis, conn->num_bis);
+
+			break;
+		}
+	}
+
+unlock:
+	rcu_read_unlock();
+
+	if (!pdu->num_bis)
+		return 0;
+
+	return hci_send_cmd(hdev, HCI_OP_LE_BIG_CREATE_SYNC,
+			    struct_size(pdu, bis, pdu->num_bis), pdu);
+}
+
 int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 			   struct bt_iso_qos *qos,
 			   __u16 sync_handle, __u8 num_bis, __u8 bis[])
 {
-	DEFINE_FLEX(struct hci_cp_le_big_create_sync, pdu, bis, num_bis, 0x11);
 	int err;
 
-	if (num_bis < 0x01 || num_bis > pdu->num_bis)
+	if (num_bis < 0x01 || num_bis > ISO_MAX_NUM_BIS)
 		return -EINVAL;
 
 	err = qos_set_big(hdev, qos);
 	if (err)
 		return err;
 
-	if (hcon)
-		hcon->iso_qos.bcast.big = qos->bcast.big;
+	if (hcon) {
+		/* Update hcon QoS */
+		hcon->iso_qos = *qos;
 
-	pdu->handle = qos->bcast.big;
-	pdu->sync_handle = cpu_to_le16(sync_handle);
-	pdu->encryption = qos->bcast.encryption;
-	memcpy(pdu->bcode, qos->bcast.bcode, sizeof(pdu->bcode));
-	pdu->mse = qos->bcast.mse;
-	pdu->timeout = cpu_to_le16(qos->bcast.timeout);
-	pdu->num_bis = num_bis;
-	memcpy(pdu->bis, bis, num_bis);
+		hcon->num_bis = num_bis;
+		memcpy(hcon->bis, bis, num_bis);
+	}
 
-	return hci_send_cmd(hdev, HCI_OP_LE_BIG_CREATE_SYNC,
-			    struct_size(pdu, bis, num_bis), pdu);
+	return hci_le_big_create_sync_pending(hdev);
 }
 
 static void create_big_complete(struct hci_dev *hdev, void *data, int err)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fd269fcabc2e..2b5ba8acd1d8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6920,7 +6920,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 					    struct sk_buff *skb)
 {
 	struct hci_evt_le_big_sync_estabilished *ev = data;
-	struct hci_conn *bis;
+	struct hci_conn *bis, *conn;
 	int i;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
@@ -6931,6 +6931,20 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	conn = hci_conn_hash_lookup_big_sync_pend(hdev, ev->handle,
+						  ev->num_bis);
+	if (!conn) {
+		bt_dev_err(hdev,
+			   "Unable to find connection for big 0x%2.2x",
+			   ev->handle);
+		goto unlock;
+	}
+
+	clear_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+
+	conn->num_bis = 0;
+	memset(conn->bis, 0, sizeof(conn->num_bis));
+
 	for (i = 0; i < ev->num_bis; i++) {
 		u16 handle = le16_to_cpu(ev->bis[i]);
 		__le32 interval;
@@ -6980,6 +6994,10 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 			hci_connect_cfm(bis, ev->status);
 		}
 
+unlock:
+	/* Handle any other pending BIG sync command */
+	hci_le_big_create_sync_pending(hdev);
+
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 0d98cc16bbac..9499ddfd25e7 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1957,6 +1957,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 		if (sk) {
 			int err;
+			struct hci_conn	*hcon = iso_pi(sk)->conn->hcon;
 
 			iso_pi(sk)->qos.bcast.encryption = ev2->encryption;
 
@@ -1965,7 +1966,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 			if (!test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
 			    !test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
-				err = hci_le_big_create_sync(hdev, NULL,
+				err = hci_le_big_create_sync(hdev,
+							     hcon,
 							     &iso_pi(sk)->qos,
 							     iso_pi(sk)->sync_handle,
 							     iso_pi(sk)->bc_num_bis,
-- 
2.43.0

