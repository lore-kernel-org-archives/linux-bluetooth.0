Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895D635E529;
	Tue, 18 Nov 2025 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475663; cv=fail; b=Pih+q/8GK48G0yxB9BatkWO8/DHcjE2fKex8XY9t+Ibmu7ExkS4ub7XqXiRwFWeKW7eOXm88jEI/bVBw257fV14UCSNWhKevByKD6l8lp3R1d34ki2XcMNF/e65zfmfIbV8WeYH7GzdYilx4miCnpFWxndlNJ+4Pe/Mu9uQJFlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475663; c=relaxed/simple;
	bh=0lPZb/lE/cGy8u693sI1joyi5F2KMApZS1gRQrvq5YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HBVnf6+yeMSLsJ3waRJHgxeLx02JG2w8DBQiky95x4L6fsVrIPH3VYEHA1rKRrcT2IrkWUNCBzc5I+LYq3LGKo5OByAdZ6qSTj1CK1BPLa5cPv16aZXQ9COE0jt7rrcgETRf2/8gcKrbW8FZ3MVB8ovYJr3oPmUM0LnS60IQMeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H0YN6bZ3; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H0YN6bZ3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yn7dV8DhoVtfOruZ7ASLdpSXNgeehXU3e8kaBpLNhdILDZta10APheHgKiGsAbW2evQtKgN7QpbVgHkS0nebwNk817qjWHiO41sHFWreS3tUxWiHGBZD15CifruNXU9RgwYV1+3gOk9LzWyoB5cYIhPC5AwH/K0dHwKI2QaBfaVlFRWCfKA1tFAJ/3jiS70pyZngae8+s3Cbwe+pCel1ptVt8T2QNRUf4vcqnxNr4jsOx9KFrwYWI1NmzTMeRrDzA/maJYZ+HYvsaorsoMUlCCpMC8AzbLH8W5gr0cTI7v5mBClpWfyjWXooj5IRUInfXvFEoPElLdNaL7vgFvqZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gpL01u7Rii60Yrd6/PeBSb3Ev/MuHl4uYfgvp/pnO4=;
 b=eoG7HZ0qhSoNaxJ+v5V9Jafl8YwrZz1TK7WbtHEWwqw7M9ripheiEftlcmlKo2GACieEIgwex7Ql+Foi+KbUZ3bNOo4K8K0x2cang+bLVk0lJ5l1tvDgNVMYN+Aary9i0vnMmrJequw+/DIymNesNGVKikWj8Kmaq64ZHXvAWI/cZKrOGAFapzc5+sIjQQEwEH13CjCVSsnJROqhnN1W/mhzBghISVllnrLKAfk+Jnap2UYpds80TRuMHHMy5x06aDDoJ/Skhk/zrKH9LUefvCc4gVqxoaTIlhpdc8/8lF3EtzUAAVvxv9HmxFgIuZeAosD1xRs7uVxFCz27fgT6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gpL01u7Rii60Yrd6/PeBSb3Ev/MuHl4uYfgvp/pnO4=;
 b=H0YN6bZ35F4Lj4hHUaIp1cVLqr9FJJf6nS+oTxj1SLnOJPPDUEXVvZlVLJPzdJ/f6p3dy6yM587ecRECEyeDdgq8iwYBoF/orelqMb8EDa5PQOMpcLqyt+GoyAME4uIE1DkOJW/XLiODNJ78bHFrZzm4typqfMOFRjCksyzToKvJyBWnArPvrpQHBYkAjthEKuG41iUtgnMLecF/h2asJ4MHAGq8/GvpK4MEC9D+vFZddwUl/4l0Lp9u4LPdI9xzt8smHsdUQ49zya3kCusQGjuPlOvyt0gDQxDT+4ALKuKNvnkGG/NGQ/0z+ASqh99FGolYfUGsCb53lNrawGY47w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 14:20:53 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 14:20:53 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v1 02/11] Bluetooth: btnxpuart: Print FW version and enable chip specific features
Date: Tue, 18 Nov 2025 19:50:15 +0530
Message-ID: <20251118142025.1982263-3-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118142025.1982263-1-neeraj.sanjaykale@nxp.com>
References: <20251118142025.1982263-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0036.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::29) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DB9PR04MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb7b937-ce82-4f17-ec25-08de26adae6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CmzONIPejHjyz1xJ/qfBqNgyAe4DNZH01p/uP7hdAoguFqQjjLUOKcyNZOcP?=
 =?us-ascii?Q?5z9IyIawOj1uTAAi5I1O1aV+qcgZMq/2UOxnwwr0YUGOvih3JHjHrwOyOaXy?=
 =?us-ascii?Q?8qQ1yy5P6FpAXBk5mvtEmbVn4Rr2gTX1vImRYrF185Lq0mgLGs4z2ygrFze9?=
 =?us-ascii?Q?S/dSG4gd2a425OFUx5S0jG7u3GSDlnvnS+HriQ3YLwaeexSR8vM75aYuSzDW?=
 =?us-ascii?Q?2I30/GSFgFPvSq5buBYM36Vr+2WYcuFP5ZMIRHZaM46X8dXmY+iYtyYSAaej?=
 =?us-ascii?Q?3DACLkdln3kB5oeo5A5C/VbBAqQERgan9Da7jZi41Vu1y4yPevcatsCjMcww?=
 =?us-ascii?Q?/01bNa76qcGUXjMHaLENxc2WcRb5JGrTftUjlraKTplAi4Cchaq3ddFCg0uT?=
 =?us-ascii?Q?zPVxBJUrNfHNHIi3zt/SJ0UfKA+MUY3eSi9nlH73LCbTnPzn6N5G3zG9VN/6?=
 =?us-ascii?Q?uYALthTZa2pcJ2BH1d8OuI6s6UnWDs1HR7Hf4yQT2dO5jLN86Nar/djJ0rm6?=
 =?us-ascii?Q?y+pjqGHb0mQMUieFK0N4TOk3Q1FMHvppcP96Z55N1CiwsDKLsQpBGztW1QN3?=
 =?us-ascii?Q?2UkRDFLCuV1yuk/FguGSQnp8Qkzh4o7JTY+NpoL3JjUBmM7O2LUwrCAsAVhH?=
 =?us-ascii?Q?LIDysvhLqm7MCcWU21YmIUV9mWs5YNnfDeidUdm/cP4DQVKwwtMjMgjlpsl/?=
 =?us-ascii?Q?7l8096TktkOScARAxdfDwT0TkSpuNrFsq0vGlKe7LnH3P3PjRBe8YaDJ1CTD?=
 =?us-ascii?Q?V0N9kH2jGo4chWU/FE8jaMiC/Wv7K6CjkHlMnhjsWa6Luk40cw6biD18f5DX?=
 =?us-ascii?Q?zfMnJU4b2FDKrxEv7htHZzOsGRBpEZ0YJbmc5Oo3sqBsolo2EO6DqQRHwerc?=
 =?us-ascii?Q?2nvwRVMtp0FdwT6s4juvsWXIneWJBv/8NOV+BlzbNszFQM7FctxtmA1W5/SS?=
 =?us-ascii?Q?PDtBtBTQT/HFldEHlwZdZ/AA2Ckh4b2J3W4VSS3/f4aZQHeu56qeeiY3DnTg?=
 =?us-ascii?Q?vfiIGM+d6qpvPlVC5NGdeJ3hY8zx4kESQco5EHUuWHrxlQmvKx/gJS+pcM2J?=
 =?us-ascii?Q?OaXiIUnNAv5MdAVaMQnnmWIya/YWFxKctVQrw4ug4ceFchPB0nZEeUd97UQT?=
 =?us-ascii?Q?BRQZsnq9sqdypdazTsj3WL86AzU9f1A+HF6isVvcUs4eAb3WdKKEEaf4Y/rs?=
 =?us-ascii?Q?siMfrIQ0AXAbPmE8oYBxvGsPPIoaz+WuCl4WHxkij8lmqIYxChrm+qjPgSfa?=
 =?us-ascii?Q?Mr1g+l4agaYVf5vlZOc5QBXCY/MlfLclJPrOaftIYJRKldllL/ZvcWU4IVIk?=
 =?us-ascii?Q?g/0XVSSYEsE3qr081d295hrGtIQMPtTlH4iSU3jlhobGSpK758ne+FzXOxDf?=
 =?us-ascii?Q?KtdZzB0hi0p757xEwjWP5BnfWpFIKNU6JATRxyP+6/mUioi+onURZ7rJS32T?=
 =?us-ascii?Q?zEZprWBQ/1kpRN31sy65w/4NeJj5+t+AdHtje//JoYB1Y2HG4R0u6ZUKrQMx?=
 =?us-ascii?Q?y96Fi0j/wRVrAtBCs/lPRmzdDa9USTmSRm3U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+HABj889g7i89OOjWbgyOb8WQ+iqkGm3nlj8jrs+bG/f9QfwLsIlvVJgBeNg?=
 =?us-ascii?Q?+walgPJLmcd2TLqI77e5Wml7K+AyxSOchHBGWOo2LX6w/9ZGyDDJiVexpMiy?=
 =?us-ascii?Q?SQ8GYFxD9pc928jHAdsX2zD4cR4RsP1tUuZVByPvrANF/291cHH+spHX5yar?=
 =?us-ascii?Q?NG3NgE1jJ1pSwpcCd+w3RQufzqpIuoJwkqIGeyS2OvH8Qznb83qEzwMi+bZZ?=
 =?us-ascii?Q?N06BaLV254eg5V0TAxpPJZPE63V2gDdNC7g2BqmZFv3FV1/tsRbPG2x+oPCc?=
 =?us-ascii?Q?uAMRfSZi6VfBrTC8TuCzNH2er0/nAgLFnLzg7btgGOXqdE3DT+EPebmoV6o9?=
 =?us-ascii?Q?YgLgdPO5RSkKxfjJNhnczBkRB/So2hl2oycLMtX5MoeTGe4befsSyhVwoC3s?=
 =?us-ascii?Q?0QVfrC5Fz8CyiZUjcjvH+9IeH2S/97NzRTFPLPXP6NkfROEWHkpRfBdcLPQd?=
 =?us-ascii?Q?g90OOToNV/ZtxjpJDUHqxxJUWoJU0gYf64sKAv0rJdbi3YBVesNajbCfgXM6?=
 =?us-ascii?Q?RDa24sNn7RMGALidKWD9z0YMyOZnMTaExGrq7ej9iUzovU2MUHx176K8dGxg?=
 =?us-ascii?Q?wT0wN0oVWO1l1+3bbab1ORu1XGhRbSSCNJ+TLG+MONlramMKcYcbMFoQUtmx?=
 =?us-ascii?Q?ipLg3pnSd+5MIny6g/V8bKv/Xsf6zpQ26RU/XEZgp8iB8xS15e1QEaYcGyh3?=
 =?us-ascii?Q?7Oa7SpaG+sIURX+FTvjWOqhwkORypqVe005Xd/hxRAmVF91+DGEMmN0L/DU5?=
 =?us-ascii?Q?z5BtQz+fqlSV7QIRCqeozEF0xBHo1PT9YvrOuRY8+izT33FH5VCOjIHZgHDy?=
 =?us-ascii?Q?vhDtnl84MDIberoLlgik/prTkHmrERjQzEejwQMIkumwOv2YHpYRaWwxTycE?=
 =?us-ascii?Q?ZjDMO6JB/TvpkmCV+nLsOoNAe0iXBMjO6yLQYO0vuzIf0iIrlIXsQFDp0eT4?=
 =?us-ascii?Q?DlGiYboiAkOICwGpuGThVCy/HthH18yc7fnaDSRU0rtpXImQc8ZYLvTtl9A3?=
 =?us-ascii?Q?TMp8lvFWBGMYe6Mth6sTnnjsQPmCgVVhWiidZn/i4IEocilKLoFPTY4GyKGK?=
 =?us-ascii?Q?onKWIejrWB6WhrMP1xU7Ju32W5+spC5644DGpJvrqQr4WmZHmNO7ZSWhkDD6?=
 =?us-ascii?Q?VLGU01SodEpvC3W31q7D8as5wOu7p5ExBkYk1lxaIBMbctOyiTtGJPnJ3C2c?=
 =?us-ascii?Q?9jZ8SW3CsugEAXwmmxn/iYaZ1zuAAldkJvysFtqrHoOEdWPOgKve+vnn/Lyt?=
 =?us-ascii?Q?R6mMzlrkug9cU2toaeYyt3o6Sbt+1Ea7O859UGzf0QhOf4moGUqG5SLfZNAM?=
 =?us-ascii?Q?GJjiC1RAOOHBVGUcAkynwfcCTCOLoPB0t8OADH501CEQHYmmKtkeWHseNtV5?=
 =?us-ascii?Q?01ER9gslPbdfwghM1ftBeGPygpDl4sHUpJXXxhdj8alsLsqkbVsxumuo8od9?=
 =?us-ascii?Q?f0F+gP42ScL/Ayyur9xOIzQN/n4J/u+5ovu6tQFA4Gqkqd0tsqxc6DF2PDIP?=
 =?us-ascii?Q?9mKTc7Ns+vHHdbmpiel1SwN32oOg0ZVLJfERy4crpaYm6enhf39prSG0rkn0?=
 =?us-ascii?Q?202XXI/i1mT6oBJ6PFhgsca+2IUe4q4f0TtQmyNNPo454YA93dtGga2MAOUL?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb7b937-ce82-4f17-ec25-08de26adae6b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:20:53.3404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TRYGOziJU3EFSoRxENR+B2/FmHLvM6b5oWti7Lj/G0XwsuobwntrWmWIReTstIACY/D+Skp19CI0Ys73+2PIhnkJCCZ/L61oNf1yX0u7Qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9284

This adds a print for FW version after FW is downloaded, and a way to
enable chip specific features.

Currently, secure interface feature is enabled for AW693 chipset.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 3f94ca18a225..483d812042df 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -105,6 +105,8 @@
 #define PS_STATE_SLEEP          1
 
 /* NXP Vendor Commands. Refer user manual UM11628 on nxp.com */
+/* Get FW version */
+#define HCI_NXP_GET_FW_VERSION	0xfc0f
 /* Set custom BD Address */
 #define HCI_NXP_SET_BD_ADDR	0xfc22
 /* Set Auto-Sleep mode */
@@ -227,6 +229,7 @@ struct btnxpuart_dev {
 	struct btnxpuart_data *nxp_data;
 	struct reset_control *pdn;
 	struct hci_uart hu;
+	bool secure_interface;
 	struct btnxpuart_crypto crypto;
 };
 
@@ -1554,6 +1557,47 @@ static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return 0;
 }
 
+static void nxp_handle_chip_specific_features(struct hci_dev *hdev, u8 *version)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+
+	if (!version || strlen(version) == 0)
+		return;
+
+	if (!strncmp(version, "aw693n-V1", strlen("aw693n-V1")))
+		nxpdev->secure_interface = true;
+}
+
+static void nxp_get_fw_version(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	u8 version[100] = {0};
+	u8 cmd = 0;
+	u8 *status;
+
+	skb = nxp_drv_send_cmd(hdev, HCI_NXP_GET_FW_VERSION, 1, &cmd, true);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Failed to get firmware version (%ld)",
+			   PTR_ERR(skb));
+		return;
+	}
+
+	status = skb_pull_data(skb, 1);
+	if (status) {
+		if (*status) {
+			bt_dev_err(hdev, "Error get FW version: %d", *status);
+		} else if (skb->len < 10 || skb->len >= 100) {
+			bt_dev_err(hdev, "Invalid FW version");
+		} else {
+			memcpy(version, skb->data, skb->len);
+			bt_dev_info(hdev, "FW Version: %s", version);
+			nxp_handle_chip_specific_features(hdev, version);
+		}
+	}
+
+	kfree_skb(skb);
+}
+
 /* NXP protocol */
 static int nxp_setup(struct hci_dev *hdev)
 {
@@ -1583,6 +1627,8 @@ static int nxp_setup(struct hci_dev *hdev)
 	serdev_device_set_baudrate(nxpdev->serdev, nxpdev->fw_init_baudrate);
 	nxpdev->current_baudrate = nxpdev->fw_init_baudrate;
 
+	nxp_get_fw_version(hdev);
+
 	ps_init(hdev);
 
 	if (test_and_clear_bit(BTNXPUART_IR_IN_PROGRESS, &nxpdev->tx_state))
-- 
2.43.0

