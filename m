Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA5395AF1;
	Sun, 20 Sep 2026 02:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871326; cv=fail; b=oheW+vBIrJ82mhJ3lw6NPUi8QqN6DcP5DyxbTuIGgVwdju9t6qCuHUUnH6mTX0lMPTy6lw2ctO9jLIi/aPkJjJ4ikj4jfjQ9zjsghiX9aS+kcOfJnMxNdEsAqtrmh9g0MiA+O10RE+brW7/s3e4oaMyDs/R1c1KQ2Pu9BARAosQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871326; c=relaxed/simple;
	bh=g20Uo0BSXmtSNuMJt9bvOuZ9MtwmQljemZypTOqB/80=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sboEcPsAt4Qf8ZP1sONYcW6wvJdAYjaA6BGKTcwdfOYbPpQGtsSh5UKS4BL7L5JsDOEQqqVvZwcudlCICXA+5Cb3cUYlONpqaAUf7E1MxncZXyuTqUsCZN9MYmklqO1vE0OYdilchvpDvIcWmiJzzOqykuoZ27QunwAaDM5SYoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=srXOjNY3; arc=fail smtp.client-ip=52.101.66.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="srXOjNY3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJbDMEWrU8Mbm4T6IGuO4MOG3ZvkG7wPzjqS0ji2WbAvUbn7LVVYi+EhF8/jfkL8U+V87FnSGOjVidtXz08AaMtMkA+5jdZ/JKbRKBuFWqzJXoWXliHT+d67N1S/DwVjVMohGqHsmPMbZHLEqsa1K7P/hoz4cok4/wMmqxa5rxSlJDAi0mhmCDreAFE3UHJcVqBaPKeuh/FPQ7gbvn/ueVm/sbfIbkStsQzHpc1VBHmpmpl0SktFBENXvEsCU0//JmR8w2O2iAZ7UUgv1Fe/4jaVCbiHp3W5HyeR3JlbPcT8UJeFTvC786VJpbBnKHlq3r3GVC4Bq+4fdaAIoZypLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoZffnz1ix42KbUfhuG9CGdwBYbRCeJ92zL9XigA9cc=;
 b=mnpjHc6FMAnjZFoKaFzpKlY4DEcUQlihbKXfbkyH3LVUzc1tc575h38T4jNat4iebrUjVOxSbMRziSc3919GHeKeExKnvoww7Zdvwt3VAEKrG3gZ0iz1vYklJahnJqDKOBzOaRDqr1Kq0Ws3TkBsww18WP6H46Vv6NNMlII+CDHzBde9gHl+6nJUiIX0dOYDOChHAHTreJ4NHjYW8PZ8mTGLwyQU7oDYOvxX4E4crORNyFJ13Ihz0hEeYD8909pUE9x0cSsIM8tY2Vv5lIEw8BvnThlU5SbYU0e2BO8CrNqKTWIJN/u/F8F1XIpJUmFZtouqCNVhHp4xTZqdIDPpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoZffnz1ix42KbUfhuG9CGdwBYbRCeJ92zL9XigA9cc=;
 b=srXOjNY3HyXBdIFSPVpJQHnVy/CBw2DGq5uVRZJFlpI9ZAtbGT/2t2QGpsYQlDXCsR0RPbLyPUzr8QsGKDA7WRrPm1WuFZ4/LX60UIqhVhxIgVF7axWJ6HnIyqqw1rC0Z+7Wo5W2/3tTzu4YSTpuinl7oXyhLiliDdWIirpLWyaSSAhD+IseLR2Z+I9pN0RakA/Nef10zC9L3XuhTfSRg2VU469g3VIp8tuBE0BBKqvwS7zqD5vuo1qUO2VTLtJQK1MzRwvarqqECevHqg9VpAC8c2W7R8Lk+vA6v6muHujZJTN2UkA6WUYa/C7ZLqs9MuJblr4nr7slnW+4OYHVZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9596.eurprd04.prod.outlook.com (2603:10a6:102:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sun, 20 Sep
 2026 02:28:41 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.014; Sun, 20 Sep 2026
 02:28:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	=?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	SeungJu Cheon <suunj1331@gmail.com>,
	Tim Bird <tim.bird@sony.com>,
	Peng Fan <peng.fan@nxp.com>,
	Breno Leitao <leitao@debian.org>,
	Juan Perdomo <jcperdomo100@gmail.com>,
	=?UTF-8?q?Safa=20Karaku=C5=9F?= <safa.karakus@secunnix.com>,
	Zhang Cen <rollkingzzc@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Siwei Zhang <oss@fourdim.xyz>,
	Pauli Virtanen <pav@iki.fi>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: use assign_bit() where applicable
Date: Sun, 20 Sep 2026 10:26:02 +0800
Message-ID: <20260920022610.3145618-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: b623d78e-8638-4dc6-7e19-08df16bee28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|19092799006|366016|921020|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	9HytBYh9mIOeerSOIGh6/ZwLjqKUOkiJxsIKFsVP0leJsiUgSqNK8FByabmc28Xe3SLhizQIEXjMdM0NZ0rODBx0tAiR/b8qj+0mifqoofQ9d9lWG8okwfjrEto5vKLrMjgD352d4kQA0A+Lcx0kFR2VO5l4FxINP+Zw5PvR2LJVloin43GEfDqbc9V9clqDy5fDwUgrbC6s0NAZI3psRGD6SmsdX4lsBJPtA7gDdBhYvgYh2aG95hUGAwT/3IwArIUZyhFDC5TEdjSrj/opVHfaj8aVslEYosi/mvX9/UoS2sFlugXzNzWS408bHQ/fLZmEFiXGKUArTr7uvnkSOfl8yHKvojTJ2MOWmWuhOXBgICUMrJ/qmcISrhxAgCINwmopLQAvF+TGIh/6tnuh8Ag4st2A3pxqFFF3PjYaTsntopdodCph5sgvJrnplF6Ysz7RYq9I2EN/MoeGlVr4s2UfuVl6C7vEFN5CLSoQUsFtNAeWqDpijNlKqC1P7tnl8dY4sl5vZvfTarO1Jg7Og6jhF6mM6uPunZRP8eyCfWUoVChMIYbCHmfjKTr7CZ2N2uAvResmw8A5FzKEw+gSCkEE4WP0kN/nkITC/jHF3ovNHkJ1g/7b/FLevlYQVuTYzHzAsmYq3RLYIOzFPfpk06DR3aDZUjPu1PHy3cEgL2lbTHlS6Di7cQkeat8bxgpAKhxXST0I/7mKdkAZ/XnuPw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(19092799006)(366016)(921020)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Osxap8Jkd6GsvevNnChku5Yw2hg57yOWoiKuDV5wkpvlE2qcciAYZ98KmG2?=
 =?us-ascii?Q?K1WIIo9ow1n6iN9LqFjDmDA8Ct3ccvC2gyTVXlzqicjiG3ItGaMyRiThNidl?=
 =?us-ascii?Q?uISDzOoVkaz78kTYRSXf+4qFl+ITZYV+QbF8DoU8hLdNypK8zOKS2zfgH+Nj?=
 =?us-ascii?Q?eSigiO1PYlk0VaFVHyZsidKsySa8zJ7o7XadtNih3mf8q+67P2u7uXgMPGjp?=
 =?us-ascii?Q?ntZ72DrZdv8NjtPJqSCk7KuTfsLtXD8A8mQHuYeWBd46lsC1bYOKpPVZHAWd?=
 =?us-ascii?Q?vx3rvh2RRm7ZSKXRQb/l4fOdG9NL1OHy0JQQHmo5lCvJrxh9tUonivRXVo4p?=
 =?us-ascii?Q?WXSpUJxhBY0MWDI0G3+qoeUVRPbLRcjqbBx81OWpAhFvn5ssLCeSDN5BbyTE?=
 =?us-ascii?Q?8n1uIRTmx5BtARauA2fyHK/iC7usYcVprTogq3IMExCL0NKJZT2r9T01yb66?=
 =?us-ascii?Q?89I8VX+WvS6uPEEQP0I2ql7G2knPY++B6gul385Euw7lGZ08ccPxqNyp/6s/?=
 =?us-ascii?Q?uVKojT6bu0hBBAcG9HOMS59q544FFNEcVU8cyyqMpqXXkkY8i/GC7y1EW1fv?=
 =?us-ascii?Q?n20IHRARm6eVajX8jHRvMUNoUsQFnLeMwGCRahqJ/u/so/uLjppVeG8XOvFt?=
 =?us-ascii?Q?QhbR5GEf8PeUB+RPx68avDkO1Sl/TcywqiHu7Es4S6IAjBg+zunqcDIH6VmG?=
 =?us-ascii?Q?ElEaT6/ZOYTgII1Wx2dMB+A+LZn35UJgs9TSphTGrMEJ8h2cdrrQHQrH+mG2?=
 =?us-ascii?Q?SmJZ+SJblRveRicF0bpklJDBSPydB566CFZjbgzvTB2ZDggknvbG8I5BeIke?=
 =?us-ascii?Q?kiVW4oNY4MfPra+4XazDHvd3Ooefj0YG7m9IlgVMuoHMlqBFCZ2D1op11l3C?=
 =?us-ascii?Q?l3+2waHRi30hw6RbveO6w1rXHK7XLLNtizLAm5uolZBFvf0RyaCscuJzDeZP?=
 =?us-ascii?Q?90DJ0MwX/VYOqi1cn1s8ExjGfdSTZ/066sNpjjkepnCH/OMT7qcVIgCNTSpJ?=
 =?us-ascii?Q?i+cvx3DLJ/ahzWqQ5VLluwzT7YfPQrJCvPdKs/cvl+k89b5h8NhDPL8/5DWr?=
 =?us-ascii?Q?3KmztE9lsKkV5W/wKfvHmQzIrjwoAsgfy59eqg319h5ZmxIMuxcf7Daax0ks?=
 =?us-ascii?Q?4+Jk54KxOn8gu/DgHYLhRK3xI2xZ88kKzyHCYSueJLn3yUtexloSmJTBBhng?=
 =?us-ascii?Q?SZJ+8ZNYJDw8flkCwdXmYkVAmB7kSHb0swAO7+ZpLt2n/ftkaJtHh8WHnEdT?=
 =?us-ascii?Q?xr8UvJJbQpQuMdhcCasYI2io2Vx94Q7WXv1a/29FS2+NAuP3fLgIg54QotL4?=
 =?us-ascii?Q?OjakzvWLhEULQC0Cz+ai5fUl8PSy8yAKKAq02fjmt9ihRxzktqPJB7XtXhPR?=
 =?us-ascii?Q?ZHvU2mjcjfoGRxwERNt6GpfiWK0Kikis2xoP5MH7cXpRjSyoNUvV0/H3bOej?=
 =?us-ascii?Q?2vyOxfDcvkSTQRtwN9sJbSoThi4nC+9TEfjCgF+W++aNai8M6u/o48pu8pQA?=
 =?us-ascii?Q?FHoRBu762ryk9sIbukmpSLy0Ji52rSubTFvKPb/jRpkl3bvJKd53jmv94p2P?=
 =?us-ascii?Q?VdXPL1cqTkCf9bb3ajJQVAaF5+7/TInsGOuADwogs52ftknrzZiW6ztUZMTc?=
 =?us-ascii?Q?aMz9R3uD8dPyJwCLGZ4uF4zcNAVGQOlkHAOLZBwyrvSFEzjJP5T2F18kQe40?=
 =?us-ascii?Q?gemquZ96llPc8nch0YA76UnsKdabKUCmLYWFVT0clfv4r/bHgfcNp2L1+HKJ?=
 =?us-ascii?Q?/ZBLAgzdL/cOwpOLh/IfNPTqJ5lbqYw8FWaSde/W8TAJrEbCzr1e?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b623d78e-8638-4dc6-7e19-08df16bee28c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 02:28:41.2967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yM+9ePJ+o7JpQ6OmPQCzv8eWope7hd807KSuj3jjYl6D06yZ2BpPebSNWdsnTPdMCMDi5kvbZuafoFaNUXcsa/r4EzVrrMsVTwSUnUtl7s7CT2c2qY0iPatqiLMZxT07
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9596

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit the assign_bit API.

Done with Coccinelle semantic patch:
    // set_bit -> clear_bit => assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        set_bit(bit, addr);
    -else
    -        clear_bit(bit, addr);
    +assign_bit(bit, addr, cond);

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        clear_bit(bit, addr);
    -else
    -        set_bit(bit, addr);
    +assign_bit(bit, addr, !cond);

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 net/bluetooth/hci_event.c   | 31 +++++++------------------------
 net/bluetooth/iso.c         | 15 +++------------
 net/bluetooth/l2cap_sock.c  | 22 ++++++----------------
 net/bluetooth/rfcomm/core.c |  6 ++----
 net/bluetooth/rfcomm/sock.c |  5 +----
 net/bluetooth/sco.c         | 10 ++--------
 6 files changed, 21 insertions(+), 68 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 25ddba2f603b..5ac2357e92c9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -404,10 +404,7 @@ static u8 hci_cc_write_auth_enable(struct hci_dev *hdev, void *data,
 	if (!rp->status) {
 		__u8 param = *((__u8 *) sent);
 
-		if (param == AUTH_ENABLED)
-			set_bit(HCI_AUTH, &hdev->flags);
-		else
-			clear_bit(HCI_AUTH, &hdev->flags);
+		assign_bit(HCI_AUTH, &hdev->flags, param == AUTH_ENABLED);
 	}
 
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
@@ -436,10 +433,7 @@ static u8 hci_cc_write_encrypt_mode(struct hci_dev *hdev, void *data,
 
 	param = *((__u8 *) sent);
 
-	if (param)
-		set_bit(HCI_ENCRYPT, &hdev->flags);
-	else
-		clear_bit(HCI_ENCRYPT, &hdev->flags);
+	assign_bit(HCI_ENCRYPT, &hdev->flags, param);
 
 	return rp->status;
 }
@@ -466,15 +460,9 @@ static u8 hci_cc_write_scan_enable(struct hci_dev *hdev, void *data,
 		goto done;
 	}
 
-	if (param & SCAN_INQUIRY)
-		set_bit(HCI_ISCAN, &hdev->flags);
-	else
-		clear_bit(HCI_ISCAN, &hdev->flags);
+	assign_bit(HCI_ISCAN, &hdev->flags, param & SCAN_INQUIRY);
 
-	if (param & SCAN_PAGE)
-		set_bit(HCI_PSCAN, &hdev->flags);
-	else
-		clear_bit(HCI_PSCAN, &hdev->flags);
+	assign_bit(HCI_PSCAN, &hdev->flags, param & SCAN_PAGE);
 
 done:
 	hci_dev_unlock(hdev);
@@ -4614,10 +4602,8 @@ static void hci_mode_change_evt(struct hci_dev *hdev, void *data,
 
 		if (!test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND,
 					&conn->flags)) {
-			if (conn->mode == HCI_CM_ACTIVE)
-				set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
-			else
-				clear_bit(HCI_CONN_POWER_SAVE, &conn->flags);
+			assign_bit(HCI_CONN_POWER_SAVE, &conn->flags,
+				   conn->mode == HCI_CM_ACTIVE);
 		}
 
 		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->flags))
@@ -4817,10 +4803,7 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	if (persistent)
-		clear_bit(HCI_CONN_FLUSH_KEY, &conn->flags);
-	else
-		set_bit(HCI_CONN_FLUSH_KEY, &conn->flags);
+	assign_bit(HCI_CONN_FLUSH_KEY, &conn->flags, !persistent);
 
 unlock:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index eb99653f33f9..cd4e9e3968e6 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1935,10 +1935,7 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 		if (err)
 			break;
 
-		if (opt)
-			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
-		else
-			clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
+		assign_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags, opt);
 		break;
 
 	case BT_PKT_STATUS:
@@ -1946,10 +1943,7 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 		if (err)
 			break;
 
-		if (opt)
-			set_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
-		else
-			clear_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
+		assign_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags, opt);
 		break;
 
 	case BT_PKT_SEQNUM:
@@ -1957,10 +1951,7 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 		if (err)
 			break;
 
-		if (opt)
-			set_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags);
-		else
-			clear_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags);
+		assign_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags, opt);
 		break;
 
 	case BT_ISO_QOS:
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ddd47f42db46..e2f90e92af3a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -867,15 +867,11 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		if (opt & L2CAP_LM_SECURE)
 			chan->sec_level = BT_SECURITY_HIGH;
 
-		if (opt & L2CAP_LM_MASTER)
-			set_bit(FLAG_ROLE_SWITCH, &chan->flags);
-		else
-			clear_bit(FLAG_ROLE_SWITCH, &chan->flags);
+		assign_bit(FLAG_ROLE_SWITCH, &chan->flags,
+			   opt & L2CAP_LM_MASTER);
 
-		if (opt & L2CAP_LM_RELIABLE)
-			set_bit(FLAG_FORCE_RELIABLE, &chan->flags);
-		else
-			clear_bit(FLAG_FORCE_RELIABLE, &chan->flags);
+		assign_bit(FLAG_FORCE_RELIABLE, &chan->flags,
+			   opt & L2CAP_LM_RELIABLE);
 		break;
 
 	default:
@@ -1042,10 +1038,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			}
 		}
 
-		if (opt)
-			set_bit(FLAG_FLUSHABLE, &chan->flags);
-		else
-			clear_bit(FLAG_FLUSHABLE, &chan->flags);
+		assign_bit(FLAG_FLUSHABLE, &chan->flags, opt);
 		break;
 
 	case BT_POWER:
@@ -1061,10 +1054,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		if (err)
 			break;
 
-		if (pwr.force_active)
-			set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
-		else
-			clear_bit(FLAG_FORCE_ACTIVE, &chan->flags);
+		assign_bit(FLAG_FORCE_ACTIVE, &chan->flags, pwr.force_active);
 		break;
 
 	case BT_CHANNEL_POLICY:
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index f7463f092283..54b70d1186ee 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1684,10 +1684,8 @@ static int rfcomm_recv_msc(struct rfcomm_session *s, int cr, struct sk_buff *skb
 		return 0;
 
 	if (cr) {
-		if (msc->v24_sig & RFCOMM_V24_FC && !d->cfc)
-			set_bit(RFCOMM_TX_THROTTLED, &d->flags);
-		else
-			clear_bit(RFCOMM_TX_THROTTLED, &d->flags);
+		assign_bit(RFCOMM_TX_THROTTLED, &d->flags,
+			   msc->v24_sig & RFCOMM_V24_FC && !d->cfc);
 
 		rfcomm_dlc_lock(d);
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index e2486bc11cbc..2167ba6f478b 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -721,10 +721,7 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 		if (err)
 			break;
 
-		if (opt)
-			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
-		else
-			clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
+		assign_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags, opt);
 
 		break;
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 3d4362a09df4..e19079b9c432 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -992,10 +992,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		if (err)
 			break;
 
-		if (opt)
-			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
-		else
-			clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
+		assign_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags, opt);
 		break;
 
 	case BT_VOICE:
@@ -1035,10 +1032,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		if (err)
 			break;
 
-		if (opt)
-			set_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
-		else
-			clear_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
+		assign_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags, opt);
 		break;
 
 	case BT_CODEC:
-- 
2.51.0

