Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272FA1AB53E
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937926; cv=fail; b=NgndMxfzTSMpJX164Fz+F98OqJeiDt+M3TXS98qrgwXzz1AZiOH0dI5tq1znsb3eehUppAOyU0C2JOU7FIaM7mxLb5TW4G0W9WomIuO/gJ3nlkx+4+G41EXa3smZElsPNgyxYsPS/sPde3E+8PXEjhqh+lON1fwAfMWKu0Jio2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937926; c=relaxed/simple;
	bh=vzcXiqsU+vTi4T4eYmvv57vuHJytrPz0x+S75rlspjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h30/bkuwsE0d/GB2yb2XlCGyvyHuIcPcPYgEpYK3H72s9ki9d/M7nvqYaAQEulEu37vq+a1XQFjwXbpBnFMhx+oZKnhI/WF76EYt+bRydI1I+dEfLtWkB1DHZwu38UEFvahThB0wSGucRmNjfSX/a1ZKmRt01dxBBG+kin/7/qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bXMv+Y/h; arc=fail smtp.client-ip=40.107.104.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bXMv+Y/h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnjkCHAspmp/+LocL4i2bJuzRB5pXKqCcthHNH2Z+BK5jbZ5QauByLgNDgkh+IJtfQt17hJYT9Q2ri0tsCQ1/2Bw23QuFVCQglbMURj6iomIA0SK2UTpSYwJE+3TPw9xqTY+nlaCeS1OrET7KQY9SC+0ZGF6vvIjxlgIbIeCek/9xjEY3QSo6cALPvwxTh/4JXbzWmYU0Bdh0A4rYL3jc0P3fLacA7klwgD2C3DUyFWKjbMViCPgNqZkpZlTIvLRAWozdS6MZeubtzKOvXlmar7r+AkhW0GKd1kafmhiEvi9RDYEbJ2s5uGrWRWLYnSZ5/qfb92l9Hwnu3YY8APzxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCeCLYsLifOStSe+GzvVE1Rm6IV/nV2c2K4pzg2w420=;
 b=JvsH6JV9zbUkjK7Amk0hPJ49VhvLBE9mZjDbNat8xjisNPu6Q3JHJWlngrku5Juyaw2rFkXS+v0CFpsgzF77QPhT620w3bdUFBxsqEvulpjTD8Y6Aa7TkG/RtmjtXmXhmuF6Edz6Y+Oo7gzl/jK7Jg6kLgjJWtzKkI3G1sP+WSCeb2c8/45tgUClIIa10yW187DwWQ3k8QS+KtrvAMiYUCT+2hqn4dlL5spiPhDNnLPcqAU0bHpbeQKYz2uzDRXEd6i0wmmcIG7yoQzniK/IKw3JDaktZNCfg3jovmO0jhIBA7I3ojXa96PrGj4227mjdxyXpWGAzCEbocY0HNmbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCeCLYsLifOStSe+GzvVE1Rm6IV/nV2c2K4pzg2w420=;
 b=bXMv+Y/hBrp/9A1sMuxZsa7Cy0VRHGyFX+ARsFnu7+ne5kERJEjaLNYjNqd1bkDRzOj/uPq9b4nHCoOT+GV91AzoaNVQ3AZk4sONXzj0bkRNhbuVKgy7cL4o6DREjb7Je5Rf6slH+WU3D9IPjB8KI8vGiYPMBcsQyOb0pPPQGxz4817oczRG7Lo4LCyYwkvTYLTsKh5TBO00g2lhmAPSWcaFiBzvOLVC/R3iIyEyGZ+vmktb54McorMp0L5XZ/mBfheyPqNWOUgoai3UOqy39rzKFdRLkYQ0cIF8tvTErdE3l1PMJr2lpLmPhUgWvs+rC2sz2vdXhn2sQ8C3tNFzXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS4PR04MB9385.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 13:25:18 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 13:25:18 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/2] client/assistant: Enter Broadcast Code as string
Date: Thu, 29 Aug 2024 16:25:06 +0300
Message-Id: <20240829132507.4545-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829132507.4545-1-iulia.tanasescu@nxp.com>
References: <20240829132507.4545-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0181.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS4PR04MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da19dd2-4d18-4c9e-82f6-08dcc82e065a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ATgno3CIwQyOW1iYcsxKycdojxnRLi8nJQQXPiQSAN4vsHqiEOPP0XVomTLh?=
 =?us-ascii?Q?cK9OWlCYJbj5mP6AZeJ0mZEc3Cuscsft3Uh/o5/+gl6SL6IKYHIcfKnuNNAp?=
 =?us-ascii?Q?ABK1DkiiltLaLb/Wrw6A0+7LDT6/C2sjZDIyGPtaRXIy3XI+a/QtKdAEBIiC?=
 =?us-ascii?Q?EHcfVwNzAQSLqLO0e1vEe3iwKZ11Afsv5kh0kprLYygKeiMf8wTddTHmapx7?=
 =?us-ascii?Q?z/+F98/N1iwXD1uA5Pr2KiSu0fIqQ719wY04JZtIBBlNBiOU3RYhoAhKltcA?=
 =?us-ascii?Q?BspEeRd5Dg1EbecAwBh1LZwFG2WG4LhsJ961z3c+B6pwCxd6LM79GpF8x7x6?=
 =?us-ascii?Q?cCjMAUmHUhCzXEzMex+wj54M9fBCwVmf8uKCWfMvAt5ebThSQMAEbQHBsPwW?=
 =?us-ascii?Q?LE2Zxoi3i2Y1qWN4nLS+N4eyhQidCdCIX9UaTAh2gNf9qWe+iTJiEJi7QjP7?=
 =?us-ascii?Q?dFYiD/lcT0BCLmz/Qwnnu4+RrxisE3f8VeuoXyhYypBe8tXL1Cm8B302o2Up?=
 =?us-ascii?Q?5knC/T3R9aBQD4StiUe2iG+KTp1dimgksd323FkTaXtFYeKYmPHsNqy6Fdku?=
 =?us-ascii?Q?868xu3Ae9eF05eBOmIjHIlWRaRHxZ49qNO+hQ8e8kHr5xIhx61kX9TgyZz86?=
 =?us-ascii?Q?F7bMa87SSL9MyqYnxk8OvcFnZ8+TccnOxCPalOlUCH04JAsLr6Rz/Xfhtbd5?=
 =?us-ascii?Q?8Y28jQNLuMlmSzw2ccRBq+PimjoxowBd9AVs8n+lgafDRWf8CPgqXuQfNZtz?=
 =?us-ascii?Q?fUwh52+zn3LPkzd/BVuF5Xh7HtddKXoKLTyt85AqaGYKXxjTabMmK9FRa8KR?=
 =?us-ascii?Q?cTOTqLJZPEC8qWcgdT6GRvZrubR7r9mhVn1AQYjDJICGHcTLpsavbxcsJ59n?=
 =?us-ascii?Q?uLa6mTjD9s0PM85Ntwsh9xafrfckoL7vlL8QUSRQ3lgOyR5dx9MCybufSfuE?=
 =?us-ascii?Q?2QsYsMlljdyMt1Xh/xviQVIV3K0uHWFjj54pdWCHMXFf5E6Pm9bxw/+tYYb4?=
 =?us-ascii?Q?JuxjjL+2iOjUZw2P5pgN+2fIhXS0OsTBsJ49+M2NHPutbgudvkPt+S3FDcwB?=
 =?us-ascii?Q?llWnVfYnQTOydVKZyZZaq7RKNQrLV35EpoIDIdK8lao/xjbcwnNKwhi0dydi?=
 =?us-ascii?Q?LJyzdgEQKngRClnh9n/ZkJWPfh2GgQ+3cwep3RR9CbB+tFoLiiq8xBliA6E4?=
 =?us-ascii?Q?I5uBr0BsmDePOLzvBkvo+tvO5iCcsLUkIj3z/E1vsns7jkcxECvz+qkht5uU?=
 =?us-ascii?Q?pxkpKof4+WMc/93OEURm/OCEhZspnUvY6MePIjZfaeebNbzsnsSNHrnHvGWT?=
 =?us-ascii?Q?bfs+sauNM0kMKN5PCmB+K+pYhpHxA6/DDO1g7YLTFysyuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SMyRaYN8IzUwgzXR279AAr0LPyGDdCf40uxAUBFd2XBQRItnJOPHOeMAsT7Y?=
 =?us-ascii?Q?s9J8/zqXSEWfebWMkUVA3IAfNVU3VFrqZzKq57k7/iy3HXVabtbLyVPBwkmV?=
 =?us-ascii?Q?lW5HBPbw8gaxf8xaICwDvdkIZ4nEWmWG/kOMqlgrXM3yrk/3R08i6ZPaDwNm?=
 =?us-ascii?Q?7tWlvSoHD9Xx877QJAGQhWmCfItiygDSdYDn1DU6z0UjnFjqfVZF7Yoh9Vx1?=
 =?us-ascii?Q?mduTD+nkUGDb0+ie3yC1VtYtExzgUM8tYMzCqDNAjAaHXp0cvwXGAl6rjxHq?=
 =?us-ascii?Q?w+IiZ6xiDD/LbrxdA5yfrT+oFo5iW3US9goZ6Yu9b9orNeSAU0mWwLt6mMU1?=
 =?us-ascii?Q?ePn5aAl+mZKbmiOoypus2yPHHSNGvhh7uhO0F/fwjg7HxKC83+NKQlUW1EwQ?=
 =?us-ascii?Q?n+YH6m/TyNKVuFXMWI1UPaIFLE7NAriuhixzsDRc0IOiIt9IPZk8vhwS3Ghp?=
 =?us-ascii?Q?taQRZR2BirxFRy369ya6ZgeVNVKPg5oNZeQLecTW9db6Fi5xGqhsxtQBpkRW?=
 =?us-ascii?Q?rKIfuRnNElyPS0A6aXotNpPgTYw3KF0UFb0DOOzd2ciHpW0DDBUOdMWCAKrd?=
 =?us-ascii?Q?R2N0HMVBa88ufS5FBdy5oAfJYzUTd6EJtVXKE6WrM6RGxyYpjTa3NDqHP1fI?=
 =?us-ascii?Q?D0vkc3nigy8ynKojp2woitmA2wVsAiKfbLZJaIJ2vo4jYLuL+lL7ShsFVTXU?=
 =?us-ascii?Q?q2mfmnKiAtRq637s6XIpTQZ7PaSzkUMrNRam7YuQSVC3w4HccBBL7oxDjdyw?=
 =?us-ascii?Q?cSFTCmeywYlEdQzcuQJCLYCYdw0KbHzrGeMBC6sYR7xrSuAAZX0PMoLZlM3u?=
 =?us-ascii?Q?YY1Bug6F76txhckqJA2lBu9OK8xYn6t2IQ5rdeM1l75swk5+gcDc6LBX+BzZ?=
 =?us-ascii?Q?N9Ffx/0+95H4Q7vr1aO0872ZbQOg1b71d+Qg+oBTnNU8JOtTahMLNljh46ms?=
 =?us-ascii?Q?8HrYYhp4/frxEGbhCpik3Gjj0Bw6UuPNfdHeG2gQzXxMt65DQ4fvYGQlGnqb?=
 =?us-ascii?Q?4HQWI4Z4Gd8Dd+Cwqbn96xj96DGxEEg01ls38Y1iqv7bwr0IV5R9Xvo5qo/N?=
 =?us-ascii?Q?BC8OTJtxcHzhOHy1rru0nbTjhlmt2LBCIQFDJF4GGn7gTZBH7JiyF6C13huP?=
 =?us-ascii?Q?nqoU8OMnbTU0TrzdJmTEDqTg220G9Vd3wqK+kM0dEj++Q93DyOOKulTFkTE9?=
 =?us-ascii?Q?g4TYS2heVXLYRwY45W2ZAQ7T0PE8HsX4ZaVQgUUcmyzeFDQ9adCUZubhgTeu?=
 =?us-ascii?Q?JKQ/sAXiCGb26IGhNYCIPcydJ79hB2jdbFhBIzrIcdHBYQNKK0yhrzlUHfBM?=
 =?us-ascii?Q?GGSzkS3viNdxWZGxr7+BPT/B/kEwLTtdD2C0vMPKfCejI1SaTzcLv6/44Etd?=
 =?us-ascii?Q?K9L/2wyRMA4NFOkSKlcDuEczLE8wWgq1kuXzzoe/+kvW+4r6c4IITmojYzrq?=
 =?us-ascii?Q?VtU639TgzPOD3phFAuxjSvQPV7+NQSnb1H2JIE2s+c/BE5P10GY2uReIHMUo?=
 =?us-ascii?Q?yh/GaN5SIJj1zxkFXPofsMD9EMtgLVGQDS5JBVwH7mh1cUV4xaQDJArmDUox?=
 =?us-ascii?Q?oz1obEqX1MEFOY3sHv8EsaEZW+kMuKOuUavb5cnqUgGhob0d2bvy3PuBPFJL?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da19dd2-4d18-4c9e-82f6-08dcc82e065a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 13:25:18.6035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWiwUDUxtKrgbV3IFUKNyQfxrIZFnzTXWi6cqJHF7ksUeiFDGtYcS6lLYCKiU7dmguKEo9x5MMoJHhJKDcb5pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9385

Currently, the user sets the Broadcast Code as an array of bytes
when prompted from the assistant submenu. However, the Bluetooth
Core Specification requires that, on the UI level, the Broadcast
Code shall be represented as a string (Vol 3, Part C, 3.2.6).

This commit makes the Broadcast Code be parsed as a string from
the assistant prompt. The bluetoothctl log below shows a Broadcast
Assistant pushing an encrypted stream to a peer:

client/bluetoothctl
[bluetooth]# [CHG] Controller 00:60:37:31:7E:3F Pairable: yes
[bluetooth]# AdvertisementMonitor path registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
[bluetooth]# connect 00:60:37:31:7E:3F
Attempting to connect to 00:60:37:31:7E:3F
[CHG] Device 00:60:37:31:7E:3F Connected: yes
[00-60-37-31-7E-3F]# Connection successful
[00-60-37-31-7E-3F]# [NEW] Device 19:9A:7A:71:E5:8B 19-9A-7A-71-E5-8B
[00-60-37-31-7E-3F]# [NEW] Assistant
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
[00-60-37-31-7E-3F]# assistant.push
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
[Assistant] Enter Metadata (auto/value): a
[Assistant] Enter Broadcast Code (auto/value): Borne House
[00-60-37-31-7E-3F]# [CHG] Assistant
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
    State: pending
[00-60-37-31-7E-3F]# Assistant
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
    pushed
[00-60-37-31-7E-3F]# [CHG] Assistant
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
    State: requesting
[00-60-37-31-7E-3F]# [CHG] Assistant
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
    State: active

The btmon log below shows the way the Broadcast Code string is converted
into a byte array and sent to the peer via GATT:

bluetoothd[6013]: < ACL Data TX: Handle 0 flags 0x00 dlen 28
      ATT: Write Command (0x52) len 23
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[21]: 02018be5717a9a1900db5e3a02ffff010100000000
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 19:9A:7A:71:E5:8B
            Source_Adv_SID: 0
            Broadcast_ID: 0x3a5edb
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000001
> ACL Data RX: Handle 0 flags 0x01 dlen 2
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 01018be5717a9a1900db5e3a0201010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 19:9A:7A:71:E5:8B
          Source_Adv_SID: 0
          Broadcast_ID: 0x3a5edb
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Broadcast_Code required
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
bluetoothd[6013]: < ACL Data TX: Handle 0 flags 0x00 dlen 25
      ATT: Write Command (0x52) len 20
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[18]: 040142c3b8726e6520486f75736500000000
            Opcode: Set Broadcast_Code (0x04)
            Source_ID: 1
            Broadcast_Code[16]: 426f726e6520486f7573650000000000
> ACL Data RX: Handle 0 flags 0x01 dlen 2
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 01018be5717a9a1900db5e3a0202010100000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 19:9A:7A:71:E5:8B
          Source_Adv_SID: 0
          Broadcast_ID: 0x3a5edb
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Decrypting
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000001
---
 client/assistant.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/client/assistant.c b/client/assistant.c
index 77fb78329..16e94664a 100644
--- a/client/assistant.c
+++ b/client/assistant.c
@@ -255,28 +255,32 @@ static void push_reply(DBusMessage *message, void *user_data)
 static void assistant_set_bcode_cfg(const char *input, void *user_data)
 {
 	struct assistant_config *cfg = user_data;
-	char *endptr;
-	uint8_t *bcode = cfg->qos.bcast.bcode;
 
 	if (!strcasecmp(input, "a") || !strcasecmp(input, "auto")) {
-		memset(bcode, 0, BCODE_LEN);
+		memset(cfg->qos.bcast.bcode, 0, BCODE_LEN);
 	} else {
-		bcode[0] = strtol(input, &endptr, 16);
+		if (strlen(input) > BCODE_LEN) {
+			bt_shell_printf("Input string too long %s\n", input);
+			goto fail;
+		}
 
-		for (uint8_t i = 1; i < BCODE_LEN; i++)
-			bcode[i] = strtol(endptr, &endptr, 16);
+		memcpy(cfg->qos.bcast.bcode, input, strlen(input));
 	}
 
 	if (!g_dbus_proxy_method_call(cfg->proxy, "Push",
 					push_setup, push_reply,
 					cfg, NULL)) {
 		bt_shell_printf("Failed to push assistant\n");
+		goto fail;
+	}
 
-		free(cfg->meta);
-		g_free(cfg);
+	return;
 
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
+fail:
+	free(cfg->meta);
+	g_free(cfg);
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
 static void assistant_set_metadata_cfg(const char *input, void *user_data)
-- 
2.39.2

