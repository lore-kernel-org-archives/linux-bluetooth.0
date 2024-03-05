Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2045.outbound.protection.outlook.com [40.107.14.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296FE8593E
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Mar 2024 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647801; cv=fail; b=p75+p/nTMugM71CSeKHWj/TJ7czv9tgrpU59oYg2QaFStHkocNzzsEGAu5fPTh/7X6EEKQxNIeca3RVxJb+CXz2sYeZSs50YoqCI4zTnevCFXt7z9z7YaFzojMd24xTeD7+Gu4pLhlCMSB6PwjRi72Vp2bxffoffnbCTZbJ5E88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647801; c=relaxed/simple;
	bh=WxZrzqwYetJO13XDTI1rEtBBzMrcCeAMKl/+iKT4rVA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HAEfOtltXAftB5xrJvZ+A0k2jApsg3QmOAh0I9+0XGI4X5K1h34/zVJwgzECsehrkWCJAv8OzPv/+VGjbw9l+Ljej0H+fejKeTlTjBwWlRaoBX2eLHUl2Q3/eUPUy1UZIBlvm4g/otQIddS5BrIa5WvhlYQ7Ct+uJNwEOzQNKSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=tB67FnDg; arc=fail smtp.client-ip=40.107.14.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tB67FnDg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtD7/tFuHXB83OmXbG3tD7ZbZ5B1s8HW3ReABEcH7UY5ubFJa/iSqSImdK8T2pf1KzkMH+8AqfDwIcK25kOAi2gHsxPgxZ0pIsRKxr1Dn1zo2VUE1S4IY/83rSjxkItq48ADIKW/rASjlAfet5RTkYgmOOYVMVklHse3A4SzgFvN0nKFXhEP6a2BL/3pMDfCTPHiOnUw1qPkk/PlmTMa0yW+XHmbvarl+dSD035QSngMIRNvrnvbmvaJ59wmfEyKYxUqOdcFrp+9Kk50uJwaRsG1/entuVt03TQDZdQ8YrjNI005H6pbKPEH1px0+o/h6TX3IRKf2idxFqZPHPbFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dE+3MNu6jJ1fHS4fcWn1fMho2H20jynD/uHD4D1VLXU=;
 b=kEjz7QATreipTouqYH6Xn4brawkB3iCX8ZfywQZtQQC68jDGfQ51vD+raLqqnAmH13zMHm9yVp+xHvEv82hpOOWAmSXBON017sSStAGcAKej6Xa+bKqml+F2KKnyGSeFvlFo4gXxyWbId7YYZt5tAp0Rx409UsMSixsLnkaswpuQgc1V/yihJaTTiOzzzFJMrXtFRJQKSASa43Rc06JxB39lNPrwPX0lWGHPv1PAoR20KF/13SzmyEedUCVBCRIiwRJabwo3I2v++4rWGWvDAurzevXU0/TpqNZ7mJCoAm5bPx3aPWJSl8wcbKE6W1npyjVcW0gGuy74ZXuPV04b5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE+3MNu6jJ1fHS4fcWn1fMho2H20jynD/uHD4D1VLXU=;
 b=tB67FnDg4EbU/YTPbFczCp97UaFwORpvta/x6dGVWxrOY3YD2CtfTJSlWpYGlzkXdJ6ItvsoHUAVCDbpcaBloXsc+6R9gvsm4CEykC4J2GLOqvCTVU0tU+siqr7WbVgE+/8l6uzrMl3anKR4VgorVxRSQx0VPt4ElbF78CRJ0mI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 14:09:56 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f%6]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 14:09:56 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 0/2] Bluetooth: ISO: iso_listen_bis fixes
Date: Tue,  5 Mar 2024 16:09:37 +0200
Message-Id: <20240305140939.5090-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0131.eurprd07.prod.outlook.com
 (2603:10a6:802:16::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB9366:EE_
X-MS-Office365-Filtering-Correlation-Id: 550fd471-7df6-4200-7b44-08dc3d1def75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pyFRgK6ysQ0Kg7CgmCN+iCIbQrUc8EAo9jJ/8VkmgwJUWF/TThZmPXnP0mFkEiuQZYpx+KOz339vEYZZMRvvpq/n9urD6NAy8E/QThHOjRhu4wyEmKRXNQjj9p8GDGaaLfMO62IbmcgJsseOhUzgK8iO9deCDgwtaGI2dsiUc/Pt1SOMc/9Y8Zb+V4en3Feigxp6pNCPewOIQvYOXhNbRqvHOF7pyg+D5kM48zxAsKtoXUnaUydjx7f6xdAT3PjpjF+L3ifw5uYGOfU1dL7cGNux34lWjIELHOTgbpDimgd+ZWtbCLB491tHfd3zxtq3nh8LgqcB3QgY+1dt4Xdw1Qc6tKgIjEaQIMmuYfP68mymKQ+1WRz4uE3nBKUZWolm+LU7afP6BOZeva4xVoVjwXW98ejcc1ahZbaAimSI+vCrhfzWJL14Hi1jezVChu8B/IjLC2nWcRZ3fBW+vmDiB6xmKwd3L/qK5GiCYyjckkIFCm9gs1Axd8vSdIlCJv2VNrdoWByC3GZd0qDFfdbqaFDKWnW5eDgS9md0FJfpUvKSlzt+2JB/iZTwQZ99fQ2QzK5QkbJRP/H/aWcm+11Ms2M479uEkZfauQ0XDsxCTfYTnbD3bNsHh8srq20akgrJ/Jxaa9r85YFfEbnwdcEO1zk0hKKshwOrDct8ph+u9p0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T6NCIGkRUaf29snN4PRfWONDyEZ1rIvJiEKahO68LX6lAOLbPbhcu5Ck0oBR?=
 =?us-ascii?Q?EdPJ1YQQ+/ihkwckkUGzimBGJFtBh3AcEgSTrOfPnx2nlmR9hgJwgnSjSH/2?=
 =?us-ascii?Q?BpGgmt5R9qAfz0dbisfuiYlRp8Ybg1LCfLdvhK7vRPMJVb3QUAFGC/7KhNsJ?=
 =?us-ascii?Q?tl0OKr4wa9Vh3ztgdmhCM7+VU1RHCsyUNy9EOVCdSUomzvPsBvo0mejq76Au?=
 =?us-ascii?Q?NgVsFOzaF2N1ZJLvGOit+197YNPF+GoJteRkkGoNU2T5t7LJM2D7ZwXSVcKu?=
 =?us-ascii?Q?3xUDpnc094/m55b16KkyOk1xpXji5t6X60Q9UyUARfaqd/3MJitjHoktAEV9?=
 =?us-ascii?Q?4jiz27m87y0S0Y9sYsLKBogDv9iVghZdOtQdFT+ZcYWwX6DQNNUW2jYzwtTC?=
 =?us-ascii?Q?tybzH0dPRoWKVCe1Izye9xThgemMvIOMeJjWNmHhl7NXuDI50N+YlqbTVyoC?=
 =?us-ascii?Q?bM170K8xJoGBwvHNatI6GS/paF4yVrx0Nzdesv26JADIUhoJPGM2gDZZXK0q?=
 =?us-ascii?Q?ceP2OD3e/Qa4DZc4S7MbgT9yDjqIdDcSj0kQrvemD1v/KjHsFsgo3Tt1I0gN?=
 =?us-ascii?Q?86/BiNEdz4CHwngCVB1Gg43YnPnzozVN5wgiXLkkvsp9Ha/ZppC43VIZmwMN?=
 =?us-ascii?Q?CvEJzqZfGJu9UV+aBpXTmP2Tkm5Jvw6Bu8EqlG2fiK8FKxuMi2l/rnzjX77P?=
 =?us-ascii?Q?1kM9Yy1SPeA4makcg/MoYh/2jVNUkOCzKkZB0CE8r+xQXf1a5C6iVovN4os+?=
 =?us-ascii?Q?9fVPDe1M4o6XG+zFchWPFbyEbaYbh4RKLI6eIYDceyAGkZwHNBqsI27i12dw?=
 =?us-ascii?Q?O891UybzdTEJ6MLEExOB15+jVxiPK4TFqTYLGLZ84zQOk3yyUGo0nwo/4WTR?=
 =?us-ascii?Q?fUkZLyrgqlpl8BkwqNOlC+bGoRoR+4i7uZFvEQiHau4NpOvu6o6U3NRgyLVU?=
 =?us-ascii?Q?sxFCrBhaBpxtA2Knwiy3u+lSb6EkPQ+0Y1drSeTbOheciTKhghS6fX53iBWg?=
 =?us-ascii?Q?JmRwXgiy+cVmExe6XJgcYmWPwd+c4MsUpIf2xjJsigeaIf0aP6iAJqDKEon4?=
 =?us-ascii?Q?9MltiSTsF/lNn68q54C4SgthjFKqS3JPJuAjEk60yb2Cx+bUp/D9buhZzzEC?=
 =?us-ascii?Q?aUYWD59iMz7OOiwZ6TCs76fE7n8PDRAP0PHVPNIcMbF9vHCNpFfcHjfUmLWK?=
 =?us-ascii?Q?DnEERZrLl4rgvxYhLUy8ROnO49pb9rFop1yNjn8l8cpnBPZgaeLk+J4pPvAs?=
 =?us-ascii?Q?bTbJKln6GK11z4oFJqD0RY2S4H/zfpjqz/g69gXLckXEp1pLp5b1AlneJMxt?=
 =?us-ascii?Q?JwcgxNoyfnyek8l3zvfrDOTGYMGcnSks/pUlsRz8I78s59jq6jANaOTOKpKS?=
 =?us-ascii?Q?ADf8R7tOAandVY9iKGsZvFeHLDCr+uGvoArrOcAEZfjLKOhpFv9rBsRcaTVV?=
 =?us-ascii?Q?pQ9ovDt+L4Xij47w78fd+y62P/aPA3dpoa3MWV5KQN33j5D7lTRy8Dfsd0zl?=
 =?us-ascii?Q?fEjPRte7gIa7MtkAGqZCwDve3XvwHjt9UhslnRozzsKiOKkZ30JD3P7rOlDj?=
 =?us-ascii?Q?PickG/2zDM7/x18IL1H7TA1r8uhnRPa7U3WceQjFeX0ek20WVqtnK9bITX4w?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550fd471-7df6-4200-7b44-08dc3d1def75
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:09:56.1852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8qgHJPqcYBcdrA59cUHjoc0txwv/wRhDSEK7cBNubxwPYHFmp64sPFLI85nQ1jjMjXVhleEuGLfjWdkVJQbvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9366

This patch adds some fixes for the iso_listen_bis function:

The first commit fixes the circular locking dependency warning
caused by iso_listen_bis attempting to lock the hdev while the
socket is locked from the caller function.

The second commit fixes the fact that hci_dev_put is only called
if iso_listen_bis returns successfully. Otherwise, the hdev will
still be held from hci_get_route.

Iulia Tanasescu (2):
  Bluetooth: ISO: Fix circular locking dependency warning
  Bluetooth: ISO: Always release hdev at the end of iso_listen_bis

 net/bluetooth/iso.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.39.2

