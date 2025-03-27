Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F9121ABA4;
	Thu, 27 Mar 2025 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743099818; cv=fail; b=p79yE1oBkfOOnfyxJxAJOM4ng004Pl/c0+CIFtIoNzZPizMfqcoDPwhx0xc+Qks6KT42PE9ADmKWZID9o2QFc3+hZMaCBx+pXcxCsC1qzvPx1lXqf2lHM2lxzB/1Zxe+FpKQj0tVNiknIeW4+hXkLhLYzBMCOomjWOLnEpFIgeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743099818; c=relaxed/simple;
	bh=rwgQBsN7ko5nXFT19+iUfPe45HMeHIzNrOz0z8cPR1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pSl2vI6pS+RWJ5oqU4hWpIgIKVjxMr1JgchxL7kozrkWigosa7nJbu/H/7JINmxTy2j6KgCdf4ayphad3CwAwXfCoDtdoqNR4AN8kK+7WxQ5zjWQlOvOWNmbHJumuvYvm3C720nZteAO/3otFSN+55Z2JWVkdyd8GfNKGiwJDvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mhgu00dm; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mhgu00dm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHOfKPpuOCnQiljCS+8PP6pFYAElhjZVgBCCwAckYoFF4g0RwVjrKlE5JvD5YUdfnoGgqxdVq3QaMztyPFqGkEUy9BZKnT9VrhM3JvGr4yE2/eISHh8Rtjb+xOhtes6kgsSV/1b/JcKhmn5D6l49UkkjUT9OL4YrfFiKHJr9gqMyr2cyAVuvvE6C256Gyn5oGuFnJKPsqHuLTHk7vbxnFtg7cWkcQP0rT4Gyy/8W08YFArao3DUQYyVeATmkURRUtjU3/lwac49BO3vSWTUi2KPuqRxRiYx5QrMleyABfEda4LqsTtlJE8qeRjgHoqIAKbzT0k1wgYuirhLj0GGtjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qo1g78UzGzCThxiWw1+ZyMCMy4AvP+xQ5WJ61rFFDeM=;
 b=TBFJpiD7JW9J+e6qWayqdxY9BNQMS3moGhMFmpaeeFKdIK7gJITqn0IoP7DVz6Q6nTpNmkeddelmEnm0aoxHwdCRDGRaXnldCCBJaaoxhkr78j0YVmRCZrVddvI5LWuJgxteSEkuGjgrdnlxGhZnEdjAm+UOhEzuHeJ+0eQdaUPUv4wkYsqGMvwxGWxq8ZjuEzgq1rCd/LewJz5dY/ORBs05pfTZrAk8CpV/+LHZkJCkD73bdGE42XYymKwcalxu5YF0120zKLBbIxv2daapUq8U9HdJ/ebUvES8j/0SA58KHQfFI24yvA/tr1O2es0eJqQdvyJWk+6yu6gsBQDDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo1g78UzGzCThxiWw1+ZyMCMy4AvP+xQ5WJ61rFFDeM=;
 b=mhgu00dmW1mqTAxwW+dIwh9lnPdea3L5vGlizbv8GwGLJMvcuWwjJpx8OmVy9NNdvbM1pqNBMH9dPXePxLvMv+TIaRp0fFmi/Kb0RnnM8qw+Fy5UyWHxFnWg6zgqxopTIIGnojW1qiu7OEfFcXF6lXQF4k4dDWzRGDkCkNn3orl3/4fu0TgUqi/+e8pKXG+i7dL2C4Io4zG9CnSKFCSWpxCpf/4eOPFZCiNb6gFSABDSJmiSrGwnPgj39INCA1KiN901mAR5UXjBZ3/0AMjJRB09/6nBBNkto+pPj4X5wG8pwIR/QfVbTk/yhYBVRDNkatx4mW5aIFuZX6VAG6uBTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DB8PR04MB7131.eurprd04.prod.outlook.com (2603:10a6:10:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 18:23:33 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 18:23:33 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com
Subject: [PATCH v1 2/2] Bluetooth: btnxpuart: Add an error message if FW dump trigger fails
Date: Thu, 27 Mar 2025 23:55:23 +0530
Message-Id: <20250327182523.524534-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250327182523.524534-1-neeraj.sanjaykale@nxp.com>
References: <20250327182523.524534-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:3:18::21) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DB8PR04MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ec8793-b4de-438d-64c5-08dd6d5c7b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CRrzzbGXXov+0ASlWK5LP02iWGywp8m4/cFFj2uVVeDMmVMafeYi74qJlF5i?=
 =?us-ascii?Q?UBjcwGco7coVEKN6unUzASYDAO0yBOss5lB72fjyjJyacjWFdocxDMMWlpxc?=
 =?us-ascii?Q?5xHox0rYnFV20pwYN1q63wu6iMKou7SIzmjDMu/U22obBOnWEdS+Qn8d9kDZ?=
 =?us-ascii?Q?IM5KZJQ10iHHwhgXznkvDjYTxR2w5sV0hV1Z4M0Uqlzgm5ILSksQPQLQ0RMI?=
 =?us-ascii?Q?zj6gcoWYHzAKDfewYOkYlyomV3Rr8V21ZbDrtX2Cq4U9vNyp85OhJqLJISrm?=
 =?us-ascii?Q?HPsnvk5v5QL+4zAmG6u7d8hTRiNA74lx/e96J56PDnQKkKwL/bqb0BEdqXej?=
 =?us-ascii?Q?542G76wBPXf2oaYGNYk9XfH0gAzjJ5+tPacU8ZLe0Fy0xcEmfYQV2dNXNFa3?=
 =?us-ascii?Q?YUdogI7yT2G9qq/EjrL8FeN6CI4EyFgENSde8zjIEkoxMpdlbS1uo2G1aaaH?=
 =?us-ascii?Q?g9h0rc7kAF8daLOjYQj7FkGQk9dwa6KAYwGy8ohq7HpggwfZJJgXTbaOOQiR?=
 =?us-ascii?Q?zwm0x/+ua6Sbfvk/R5eNqrYfSVMlWJWv7MTLFVJy4ZHwyUsK8mcmo64A/OFi?=
 =?us-ascii?Q?g+zMpczxZ2SZfuroqv7FIspaNjuxYJy1LFOhvMIdK2DuPPlkfc/uFGmub2Xp?=
 =?us-ascii?Q?OjcNtuSylSpnUC8C0PDcx+9NPw7gUtCOTJQQyQFRz4JO/dINiWE1MaOPEf7V?=
 =?us-ascii?Q?cpA7Xue8f48ZjjaLcE5tb65YUPSBUyQiQReQRbD+n6KrQtXwAv8gYnn8WVYx?=
 =?us-ascii?Q?QQiuRp8BBkVyciYRcbJResuqNGRLJgDx3xRTkTlj6YNFXhXpcnAeT23JGrLG?=
 =?us-ascii?Q?HsjOpGRTIyOzyRTNuAGBT29Z8n5cJSiqBJrrJEFNcDfoNPZrXEgEerW80nwi?=
 =?us-ascii?Q?vmlHv30/XJ8MX4nLoP+bRrdVDD0kdmlAlVmDkDbLGz2+g/aWcTY6wib2tUJ8?=
 =?us-ascii?Q?CjlVTFEXTvyTlVwtqewNZLxAaZCWRi5G/bHQtvLnWpzk1VhE/mQI4WczLpzt?=
 =?us-ascii?Q?ZLJGJA/05f5f/YVSBUjLS2+9JGiRLVXdLTwnr0kKBI7tP0N71CSTfDvYe4HK?=
 =?us-ascii?Q?F/ZVYbaOi+QzXPuLhUmsp2im9J7ZErON3dU3np29Hmx5M7lYqKOmxQ7Gav/k?=
 =?us-ascii?Q?0whqBcNo75GGfKkONds+WR1ycMhJzJpStCv1sudGVNBp9RA9rh4lm0hgBjYM?=
 =?us-ascii?Q?k4C0UfXfZYvpbwHTiA0+zUc3uf9926ScXIGVrO2BzVdAGbGyalig5KFuAXF5?=
 =?us-ascii?Q?UK/QfGUpdeJ6Ie5ujrfZCMveoN7U52n0V4DZS9nY4bkfoCygRBQVyVYDoX0T?=
 =?us-ascii?Q?Ufi6AfZ6W9hikHLZjRfCrwNcKvP8T+PTN28VJ9QzFrAsJsaawuFXMMA4fPEY?=
 =?us-ascii?Q?qQ3izwFZxoRiZhWHb/JQcfjfZgb48w5M8gC16hph5trM9+xn6V+HSurwqtJU?=
 =?us-ascii?Q?fqgHD7IZw7OoiHPyMkzDxLWsucOQzvbvnK3yR6B4ZSdkaIB4/b6NRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OVabxCTlayJ6uPghYeyScSNJAa5Vb6l0Rpt0iv55FEl7gSRJAZ1Zv8ZlqhhZ?=
 =?us-ascii?Q?KID2yJuU7tQvqeGHlLDcvWphsbc2MCMo1hYhfF2fHg6xLvUpqYhLkehbHwVr?=
 =?us-ascii?Q?/pOUGcdI06BPW5tnxSk/qcRMOQveYBvajx1OmnatVh34Ihn/hJRJWU8Z8MRk?=
 =?us-ascii?Q?DQd4VL6LdhfSkMPvj8n7Z1+qjpjgT7dKdi+Wc/qOtvl3xHVb0PYXMRW4r7mh?=
 =?us-ascii?Q?kllAzfXxEec1kt2hQw1UengVPVCEzC7glaPjveDZdoyj+OcShZFBWkwGBFSF?=
 =?us-ascii?Q?Zs3JgUwRMA9dA5zFnLPELGScgxgcn1BjwR9HIo591Wnepv438sNqWxFkARWH?=
 =?us-ascii?Q?PJtgGo7Kv4Iiqesv6KXqyabTD9iY4e8qpBP9VesnFVZOrK20lK5pUO3xtnUF?=
 =?us-ascii?Q?PMBWFuhwvia6NTVyr8prcicRmDXiN7kUiEjyLkuR7rSICLSTU4qWCrthkr+9?=
 =?us-ascii?Q?VDSN9eCnp7Wbv/0EfqrqVNNFS79g8q31oKzfiyU5EmEI19T5HXvtffIzmDlp?=
 =?us-ascii?Q?eLOjiHJ02tio60bhL78j5qEimB/LIh5gzNSyPbboauXTpCnZBGozzW6f4QXI?=
 =?us-ascii?Q?8xm7mesaaIFwYvz8/CqOj4hb5xgJ4dtE34Aprssc+8d8YCsqX/pnjEbPrz1y?=
 =?us-ascii?Q?hPfBcZQnhW36NrAj3zne62rZnuNmQpd93UgDcI+FBQhaTvG9cGGs+5OqM15s?=
 =?us-ascii?Q?4l0YsKWVIGWTQVYXGy/OCvQ5KXlxq2OTtpKs0tk+fm/JlkvQNykXZ3+qc2DF?=
 =?us-ascii?Q?Mxj5jK89S5eTl49eVU6tnh5jKHcmTODhil6RlQnV6yWkxthXfr/5IziRbrtb?=
 =?us-ascii?Q?MNM7vQV8ms1ZgZUSVwWgUIJu5f08KGNwPilawuCE1ANpjUeryKjq6ZpmMy2p?=
 =?us-ascii?Q?ctWDuUXb4z4pDDC9X7KkS1JJ/hslNS4E7sOz3aqlSEevW83UEZbrE/J4nUa/?=
 =?us-ascii?Q?t4F6q+27VdHNiPR9LcbjJY2bgde6/pN27WoBnVovRsyOOicVSsBL3j83Dg2q?=
 =?us-ascii?Q?XqzC0NnqMnl77I4q5hPY+Xyx6HTHjr7Mym1U3NbFz0K2AcqBxD4xSMogezM3?=
 =?us-ascii?Q?MqUgDbXPcQW5KrPaJuMSDhaXKe65Rj4g8XUaaa4qw2lExv/3fQyIbV041hgT?=
 =?us-ascii?Q?LUPkV7lTvibhsR6+MCsQ9xm8o6inejWbvYFDvlElzPMLtPEqGDG1egbOGU3T?=
 =?us-ascii?Q?ie5ZgveYIv/oePDvgsxIthsJpOxquPOyHaftfS1LXiQIDk5mXsmj0GWAPX31?=
 =?us-ascii?Q?EZea9mDHVNbcVTI5J/ZxCkI2YIxU68dFWPGTxmWA2dQV+Og1VQN8mLAEJ/LD?=
 =?us-ascii?Q?3nexFYEdZu1h8TJJFARtTB9TP++Pasx9XaljtpsPFvgnKCp4YCGPWP5D66To?=
 =?us-ascii?Q?Pwkv1ovY8erVPCzmUC/WVbChYMWfTmfnsxFq9fpomSmbOu/sFNiqpVp5P7KP?=
 =?us-ascii?Q?FtANQ0jeWhB95KipbKEVoOE50wNZYGVNPYPkPe59+rjXHmAvN3EwTcmvDFkW?=
 =?us-ascii?Q?/htyNHoolsuwwjdF7sw7Lc+doJZc/BwAzgK7SyS7hAtv6/7Lf5TlBLWnCWyn?=
 =?us-ascii?Q?d2898kV7PmN7yhhDtUmpYcRv2cBU6GBDO1+HD5nPhZG90pCk6stBUZZepyPS?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ec8793-b4de-438d-64c5-08dd6d5c7b55
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 18:23:33.3706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEAaO/y0Qv51HEqQ0MvsyboYmedVlIbanN8cXLaibLv5XiHCAjxBagK/ZWFEkVAnPgTBLsBN+tTMDLpZ8m6wcphxmv4/r/VfD7Ay/A34rYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7131

This prints an error message if the FW Dump trigger command fails. This
scenario is mainly observed in legacy chipsets 8987 and 8997 and also
IW416, where this feature is unavailable due to memory constraints.

Fixes: 998e447f443f ("Bluetooth: btnxpuart: Add support for HCI coredump feature")
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index e26fabe8fb3d..57c88a1cb660 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1288,7 +1288,9 @@ static void nxp_coredump(struct hci_dev *hdev)
 	u8 pcmd = 2;
 
 	skb = nxp_drv_send_cmd(hdev, HCI_NXP_TRIGGER_DUMP, 1, &pcmd);
-	if (!IS_ERR(skb))
+	if (IS_ERR(skb))
+		bt_dev_err(hdev, "Failed to trigger FW Dump. (%ld)", PTR_ERR(skb));
+	else
 		kfree_skb(skb);
 }
 
-- 
2.25.1

