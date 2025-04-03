Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8B824EF71;
	Thu,  3 Apr 2025 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743692427; cv=fail; b=lVWyMUS49LoSNf+BshOFcajB/PXZRoChMTaICg3Lm7srmI84p1YFFHVFPfolozRGagDHCVBp6OjnrMk1rdtB/7TbLXv7HZ8XsCXOe8IECNWf5cIRCblRkUUWuQ1dS53GBFumJG5jZzb/obkciotsZ3+X4zAGUw16T0DQiKnZQFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743692427; c=relaxed/simple;
	bh=mmAS/ko9gmyVJ66wSQ7/hNypL6oJTXchnHHxdyHGJyg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=l0IkLdw783iYfT27FPBeYRxdFHToBwctBIpH+iQY88VWv++ClMF/rCm9LvSRV0AqmGA1VSY9w8vzcJOcy3n2JDtom8gDhv6jSaW9oY3lSl0mQp8Fr0EEWjvZ1PzZSEs+qpzvvmq2G6v4i2gotKVEyeURg2hwS1Vyfp0a0cqrb7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h/e1G/4r; arc=fail smtp.client-ip=40.107.241.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h/e1G/4r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLWkhRZ2Dvuz7jWD/oTmy3kFgwajmdr1FuwbfRRDPfFoPc5XqSfkYsjraIWSE3h8wLIiF8s7TNW34xZDU/RfcWaVKIMEXYXKYrfZfkLE92TjBU/x+phlAO0IKA/U9fyG8AbnIzilrBh6OB+SxSbYib6SmQlgPghZCc7iESeptUQ7cL780cY4J6Tc7CJULt0VlK0q1ADfbN7YVTDgzBRLoqeOePBRaWQXiKV9ytbElRE4GhKEAZxj6us7Ab2DebTNL/Gluv+Mhq640+C8gRPCz/wwHvFUMEaxCvG6fqvRKVEX3DDKWh+0QhsRm4TNQvUi5pNJll56r11M0Rd7NC0uoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcoGq6fHJjEdJ/9cWHqdw/NjIxmL83LOYwjYSZTA8rc=;
 b=DjMQGVIfEPZx/s5ZhH8ClIcb6Dww/t/EntAZa5l1m46DRhG4oEEiFQQAMK3v2EVvy5m1tmaR50dn5+vEAdJ8tmUCWgfz9AsRnBnnce7rvQqjNEHtb40E2GahRX477xGGmsSr8mZFVnRjtb2r9lM8pd3N2bVcG4DZJSIMr1buFKHSVgoe0OJ5iHjnGdSRGfQ5ga6kJ1lz13EmJ9BcAfhsLzTiBKuabMSiBiFTS0Gl5z+v7Aee6WhZMFvHltj+JQng4TAJ4dONtZ71nJCZ+DUL9cUlzOFigj4P4Zy0l6ho726nW1G6SV6qi1CYopo2L7U+DO6j8Y6ZeX6IRE1Ml/cvIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcoGq6fHJjEdJ/9cWHqdw/NjIxmL83LOYwjYSZTA8rc=;
 b=h/e1G/4rnMB4Wbi76PLKT2iar0J3VGAMgisnVLipejyY74m9YlNlS/OYScdGLmj3QgsYZMvVxJhV3BvSkvAA/2Mag3Pv3IPtnJNpXd8Eoq13FkQih2dULKm+UIOP7fWmEIbbygihCfbSx4OOJqfY4wPH6yfapH++kxF66FZ2LbzLMXel6AwtVxCdnBej5VGyWCHv5HBWO1KMetr2DeBcv4Lh3Mt/QA0Xsk0vgC/dV2qW0IDxScRFwuU55/74t45qpeKrfpuDuWG5soPMWaHf/WmJY++8y9ah/N3q4XTw0PSUfSi/5RXy1Zu9IRtZ2kU/LFnjwMXLrBT7PIoGD14H+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA4PR04MB7712.eurprd04.prod.outlook.com (2603:10a6:102:ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 15:00:20 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 15:00:20 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com
Subject: [PATCH v2] Bluetooth: btnxpuart: Add an error message if FW dump trigger fails
Date: Thu,  3 Apr 2025 20:32:22 +0530
Message-Id: <20250403150223.4136-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0034.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::13) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PA4PR04MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b5afec-5fc5-4145-3907-08dd72c04097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HubJw4K3IQKUNuOeQaPz+xY5jgB0DBOG4Z1HjYIpn/CsptVPMXvKz/ghllW0?=
 =?us-ascii?Q?2gb08xeUc4ZIwlFBVDadwQ4WBiZ3D+xR8CrofejkaOGhAG2SOOPGXMADViYD?=
 =?us-ascii?Q?kQpaaXDahr6VM6ajFVwg5/rxhjhd/3RApuIqSfIxoapgpBvL5gFgIbZ/hNLu?=
 =?us-ascii?Q?69tXxbs6b5uzqC/B48s0gQqSHqXkg/4jc0tC+v1FRVul+GNx3sSd4EVT/dTm?=
 =?us-ascii?Q?5nQ1oO5RtNp8sjxYpct/l+jm+wtOLocYh/m310f3LRRjG0yr39K9caMoBtEz?=
 =?us-ascii?Q?NtcpzLrAKdElkRyIHzb1pgqmTyIZUkOn+1NrUpGu27VyEMFR15Z9m7a8Y/nz?=
 =?us-ascii?Q?zrSdZMzj2IFnYUCfQP2dorQq8EPjwPw2Ba46iXTJswlvJ+30hgADmC1Er3yM?=
 =?us-ascii?Q?4EIsvZ6X5frLcBQqmowQ0TC5kKbptJFWFLuXM99SnSAV/yF8iDDus7padZUW?=
 =?us-ascii?Q?Ax1kqVgrWBz73QWWiYLxZmh2vpsKW7K2bXI6zLubnF1skcwOpa7r1PIl37lE?=
 =?us-ascii?Q?T9JVUp8R11DmJTxwOJ5Kc436FEFk6TMWTop0HScWIJ79Dgt7uSoOBZZMGAtY?=
 =?us-ascii?Q?5LJpBf0+5WZmfhKVSSB/Pq2nIlHCw6Su+lxesCpHZ5Toi4ZwP8ZtZN1MFn1Q?=
 =?us-ascii?Q?7rlDUmuiVR/N/Oddz2awjinSQGsqkW+BsPbvcXzMNoFAePPHhKLVoks/wzZE?=
 =?us-ascii?Q?i1H2bUmzCuCynkHKejXaoN7/q26JeXqcNE2/Nl28+0l9JR12Wlt62K7t9uLS?=
 =?us-ascii?Q?rdCAHIxApujfcv3TdjMhhUwMi/jgkWePqOckI6k2fHd91wcs+iJ7RfG/VnVC?=
 =?us-ascii?Q?ONt9FJ1xemneOJFnBd2zd4H9GILzQYWl/5JWDriH68bNtqVI+IaDNtSxq9ja?=
 =?us-ascii?Q?mTWYGs/ZFcH5BRlrvG5Y1OKy0+HEc5yO5Njzn/BbMfBsHFHZRK9GEiogGQAi?=
 =?us-ascii?Q?HISxj8ccN081geWoI1Qpx2H6rOb06OQaaYFPKMXnEzR1e/F7gx/jsUa76AsU?=
 =?us-ascii?Q?9ec2kRwRIhBnM2lKOYK4hdglDzm+TU0igY5t1JfPLJOEDaPXUXLoO/ERqXiH?=
 =?us-ascii?Q?a7ZE0miPWKKOf/3bpE4Eqfax3j8RHGsWp+iy4L+o+49hn0Z7969szRxJUtky?=
 =?us-ascii?Q?8FJdOzsKaqTcLm7aPVWyYCswc9eLAyHmb1yoLOEDTvG9UREmNtyBELsceKGg?=
 =?us-ascii?Q?boFFd9KmtRwKXmIWYHU06quAPs7D0gjpgsbmWVqC3cXBsxpyhoKKNcTTmLMk?=
 =?us-ascii?Q?1txurCGLf/httu2bLmJa4j02+xBnPSimkLGeTMdRx7r+ADU7lFRzov5p0iNM?=
 =?us-ascii?Q?K4a+IGfgGnXp0dxhxnWB9gWfvgFXmPwLCWi+sXs92ea7SjeKsLUVLlPyi+kY?=
 =?us-ascii?Q?l0AD2y709hptL8qnkpYEpKGi7/6VsZLNZssgmaNSPXQagjUdkZs+aWHDxwqF?=
 =?us-ascii?Q?AgG74lqDGryk5ceA7vXwMGCmv8mn5b5M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UstuH4VDx9LV3Mp1ilzPpLoaPHkEaP9WVnvCavgGtnUMrDCd0HyR3CQYQgIQ?=
 =?us-ascii?Q?bA+tvHfz6/yumUXjnpTSGMhBEMjPfhSCKkNCWv5W8WdwUEAhtV3A/DWhJdJu?=
 =?us-ascii?Q?ZArXwgx01fif6Uq5j2Y4EJCBaEjvpp3I05/CkV24/TWKv0YqEH53t39Np3av?=
 =?us-ascii?Q?+3Y8u5/J3yLg29p4kd/yE27eK9fO66Uct3gH0dVPWcq7C98mwyl2GjuRcPeY?=
 =?us-ascii?Q?TrFhzs7wU9V1U0i1fEiF9rxBYdbFAGiUWSgChi4rZaqG0keU5l/BG9zN5fJL?=
 =?us-ascii?Q?30GFvSNHmAWTzwQoGRHo3ry2/zByAapRATI4U7qPbEufBBj5qN7NLrt10pxA?=
 =?us-ascii?Q?QF6n/dFWV/KVKXM+CO+ZBWov2AJTErV2UengZWs26I6iVhJUElFcUcMWZ2we?=
 =?us-ascii?Q?/4dxQQaHAUcs4FUgri7JDaWJhUYn4AnPWPr1LGRJahI2gxX324coKLC51+EU?=
 =?us-ascii?Q?lCm8xCISeLMkKrgNO2eNaCWgaMJm3LeQD9pTiOA3tA8QN9f6cb298Jz+nAJJ?=
 =?us-ascii?Q?3On7euO4WF1hCrksB12rFVHkvOmPELhUqwvBrcQqk0SIqXEpkDK7AOyACZLo?=
 =?us-ascii?Q?WszwQtKe34dA6x/5Jb6+7+Zak95F5wDY9qGTLh0s5t1ynxRKXTeTaB0xeKmc?=
 =?us-ascii?Q?tK4n6x61EJegHAJ3joHWxuJQy9cgRGmdhPYkQZeUhFLjp2IHyM5bLl/a3dXu?=
 =?us-ascii?Q?BwuK4oKwXw9jq2YqNvEtwSeT3UJau5rdp/PtRW4/fhwLRWmQE7mFm0pjheqZ?=
 =?us-ascii?Q?utWz7FPSAYUQeD5SuM8jYyNid1PWaI6vPHnLFi9uzyORndMQ/4VbEMOb3P9S?=
 =?us-ascii?Q?+1nca0m7yBSaUooHdPxJT9t2Nq8kt20zMDOdQKadsRW8a9NV09xWZU1IkOCs?=
 =?us-ascii?Q?kpaZyWaf8qNkOGVAhLSIIFgauNjblu8sT/SLRZ1TkXrdAVnr+SKRtAl+//9B?=
 =?us-ascii?Q?xx/eg66vsUSqL9r3EHw5G3AhuOuadUB01KO6g8vXJg1eUnrlgrag3UGY1NlZ?=
 =?us-ascii?Q?DZ/a9OGbNrzt7RD+VljP0rdBn3UkcNqYmCgPbxSu3s5L8KqNs6uLR0wYrExW?=
 =?us-ascii?Q?FkKtmAwDXqnbwOS720EZGh1JsdzLFd5lk4wlTiNRzpGFg/WSgqGrmCuIrSJq?=
 =?us-ascii?Q?vYiyi/uv1NXbq+zWknhW7tYwS9tUAsg5154ZNgCh+LolPZcGOEdZH++tlJ5b?=
 =?us-ascii?Q?kqTC0r22L1Aye5jbXv90pFc7ni5dH92DToOdG0kjuvXZnckdfQJy9AT8TuFX?=
 =?us-ascii?Q?KgJYdPe+oP73hHcykcQmYUqIE5dYgI6zU4mY8O31UK7fTZq7S2URwVIivddf?=
 =?us-ascii?Q?2fg08ZFIA4nSMBrRqyUbOL7H4gaI8zTNb2sdmyzJagALPZbsRIsqWDL/Mshc?=
 =?us-ascii?Q?pwbp0wHpFe5nvml1AfiEQHigO6KdCoYRqkHsK/PNZ6YWPSJ5o1jwFflWcGxE?=
 =?us-ascii?Q?IEdhPLrZgygGNrPw6SYCpfsZ6CSAJGNWyO/BEzvC9Yx1bx5s3dDb/gTTWlJM?=
 =?us-ascii?Q?oFEfy3Vd2wLxYe+9vOe3BRH0wwgAhC25ubG7wAEt+jnfMKSOH/oNn0UUF56D?=
 =?us-ascii?Q?7BosFV9uCcSkDEeM6R0rrz1VS/dwnhRSyT0U5C8pS7nJoW/HaCTmue/W9/Y1?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b5afec-5fc5-4145-3907-08dd72c04097
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 15:00:20.3602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G60OeQVjwM6c+v62WpP0BDdyDQNozzBObaM33Yr7KfKr4mXH8OSZFXc/0cOSH4QzXTRLtteMxSGIIip0v6jCG31Xc5WjtEn9VPD9lm+W9Tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7712

This prints an error message if the FW Dump trigger command fails. This
scenario is mainly observed in legacy chipsets 8987 and 8997 and also
IW416, where this feature is unavailable due to memory constraints.

Fixes: 998e447f443f ("Bluetooth: btnxpuart: Add support for HCI coredump feature")
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Create this as a separate patch. (Neeraj)
---
 drivers/bluetooth/btnxpuart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 5091dea762a0..96dd098cee98 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1286,7 +1286,9 @@ static void nxp_coredump(struct hci_dev *hdev)
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

