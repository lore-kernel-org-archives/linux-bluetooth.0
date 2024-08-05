Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013031.outbound.protection.outlook.com [52.101.67.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7D3156980
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722859501; cv=fail; b=Qm3+mIrsVB9mQYq5kz6YEzMmPt7S0LOtLJIRHyIMhFSw1G3sxWcazgeMcbwZIjxohyTl9v3RJjfCZIKQG6huzd+uLuFCtPsWrb5FN65kLlnmfqt1MplQcF6IlBYrKtWYMTTtYtHtb6JyFnbFahHR/pJnZfpltbQYRRiaSjEYmPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722859501; c=relaxed/simple;
	bh=ZebobFKVVlRQoBo1057thmYwxiIJws7CsPO1R4jUQ2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V/D9je9zC9L50s34Cdk/S4xeq8rZTHC5Qfk6TOccg+zlu7BhCWmQFz8VVhuF6cGmycMWnEWtK2pO09DH95YtQZg2IrMTD89ozs+rhkOrubif8mFZPcMorZCE9hBGbsMbOy6nenV8axLMXxBKZ4NEtM236R9zI38Do3s8OT5a5uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PEO3gyBR; arc=fail smtp.client-ip=52.101.67.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PEO3gyBR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPoS5DXeQrVD2q1EZyeIDHnjEGqKbE22oP54v4aB22hrTYZT4znwRJPLCUNoRY39HDiaok1xSaSp4aQNtb8fCWua6QCjMl8sxv+BJikVx4MU8tBY3kwL2cJNGSkkiJJUSaW6+KE/4aEpkVTNHmeTYJPsSOL/NbibDGBHiJzeqEnYr1LvBa+7aruNrP1LSzIlQsCcze2YPQYee+HBZf1EchGXuEpy/j0ufBwv1ZHjA6HMjCsvT8fGAXBcBhYYuFxQYaS99c89g59BL18jr/BRC0LqN9e8rHl6jG8zrhCxsV5Q9oYX0ddpGVJ1VXSrIiYlD3q4dEXNwG0T3ci7B+P+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlQveIIE7GNZf1JFQ04sEvTtPHBYjPtyvRlb8ikQL3Q=;
 b=o+EdPWC6GDR0MK0tzW/p3a06Gpyw6BQ4Sp3oX1ZI6OGRSHrN4j65QLBOKa+Kb56613LcVazIBTy0Mm7UJemOiXU7dz6SjPJuC6JyB6YMfzX5OH6JBYwbuTtIikysxWqwJRwFpMvigQnrAEOFq1N3+YbIX7G8hEdSNCt3TennngzBPHOkmCidGg7cwMQPV9oLPq1JmzYkR9CvJ9HtqBjfNOwD5Wt/iQ6XvIFLMoSGyV23OGpreulRlZlm3mZUjaZVy7WuOfUIgD/SZHDl7gNQXTPmYTMdPTLMj6unAMBPa1PH8mE/66cihWsHBp8eklKHXs9j1AzQGB1q0pvNjR9PWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlQveIIE7GNZf1JFQ04sEvTtPHBYjPtyvRlb8ikQL3Q=;
 b=PEO3gyBRk45Vl7NtwJpm1tqLXM/bwGxz3w0cn0KrxFrTDGpX1Zrf1Es54TGF75+H+7TqovfmF2o0qLTP1OeoMUc5Uy7qKwCC1Iu8yDC1GFciZ1ueZZcBVgVWKoFmIgFa0fEroVw8ewav5p1rQRwXNuTXjCF0uNDFglIo0Bx6NRdX+qUZZ4jy0KxhXfJLHI+YBNFI49G6j1YB5HciiWDflpiWY/MNPyMwYeXqbb0io12jOeT2qVtBA0xWhKHQ4HTS7VisCVmepx3D60CiO+a3qVAZdLYh6taPkndaXCtSKYJfqd20U9ACxdqsuJripKyTuxwSupo9JF5/JOLqWwuwBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU4PR04MB10499.eurprd04.prod.outlook.com (2603:10a6:10:568::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:04:54 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:04:54 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 7/7] assistant: Implement MediaAssistant Push command
Date: Mon,  5 Aug 2024 15:04:29 +0300
Message-Id: <20240805120429.67606-8-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240805120429.67606-1-iulia.tanasescu@nxp.com>
References: <20240805120429.67606-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0031.eurprd07.prod.outlook.com
 (2603:10a6:205:1::44) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU4PR04MB10499:EE_
X-MS-Office365-Filtering-Correlation-Id: 7409ee90-7036-47ef-9b34-08dcb546d15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nkQdnLJ9lBgQTPr3qkntVp5aiC91rJvldIJjGZ+Zq7fDCvBvmg0w/NB2aFZ2?=
 =?us-ascii?Q?ccJdkF0GM5599GI1yv57uRad8dbHf4phazKuJ6pC0sxcFJSJvAw0fh2O1xbl?=
 =?us-ascii?Q?z/Q/GjXfLS5+Umht1bengt62zeZilyKKBcb4rybSeZz6fNWQfFoLnA35puPO?=
 =?us-ascii?Q?Z2fX5O1HGPD/pR0StdXvB5Gv5KmB/9kBIEKaj+a516Mt7jj6SOadfImCuyWJ?=
 =?us-ascii?Q?oQrsomd1OYjiheNkhJ3Z0YrTEWqwyYJ4EnuSUNfrL8u/zesMarHYGASI/P/f?=
 =?us-ascii?Q?644T2CVuNqJcd9xS1fgCs2Niy0T3R0fd4AOXQGLo1XHI5WWyUYXPTkjsDwrK?=
 =?us-ascii?Q?cVw8KLn12hiErdyi+c4JzcKJNEt+GgcxH6GmOC1uddPKozjGiBPFO1KAc9Ku?=
 =?us-ascii?Q?vjlgSGuV0gdFeK+mrn/O/r8gGGuWgE1cc53Us3w66qvTnz20i0KlvK3JFckv?=
 =?us-ascii?Q?cFhwuO19YnsiGvozoIlmrEgEqxV8vWfCrrTEsnRIFXiKmrSSHlY7mzU568iW?=
 =?us-ascii?Q?3t9Pjx18k6JD/eEl0ty5T5chNe3ZLBQYsfCw+Q1A29jYJ5NFIzpp+t9lBbI+?=
 =?us-ascii?Q?w0rxmJo0BMTTd+7l7Oa86F3hQsQu9zRObGw8gt1MOaBdSz+5tcreaZ1y5ixr?=
 =?us-ascii?Q?7fuhw4Ex+aLtEfnnQWJBj8dPuaVGYqz1IUhT3/oIH5jzAWHYh12P7FV/9up3?=
 =?us-ascii?Q?uw7Y6oI0frHi/39s5rNLHXB3ivKXyQw1hUaUiXQ8Wvh1wKApT1GDp22u3bh0?=
 =?us-ascii?Q?164jeTBLnzec94dosY/pIhv1DAzRiPl0SPOhTTmxNx9jF7Qf0/SsW2ce3P4d?=
 =?us-ascii?Q?EbspqVB8Hfj6acWXloXkmStGEktRJkbP1pyenge7RM4m8D5jYiLraluCxxDJ?=
 =?us-ascii?Q?eyCdJhASzLiOgXhieYzakZ+ptBTRwgJM/T7CoHQU8AieHxFUlmeqoh0FQdgX?=
 =?us-ascii?Q?ZwSOGrp4LlH5WWmQvPp2dc5JBTU6Cmk6aBR5FHeAaB6M4DJowKpNVM/AMT0r?=
 =?us-ascii?Q?CSSjhcTldYyN4gSYVoCEb0iqdbfziykemNBEUtM5kiJwpvxWkuv0KPIUfLDB?=
 =?us-ascii?Q?3SC7ioVK0SmMiV/kllzGrNgURwksHMZPQzNbqlS277PTfGwQa821LrQCHI+5?=
 =?us-ascii?Q?wW08D7dvobBDpYTiZQs8TAigMRaRN6fRPKfIcU3aeNNsZJ2El08HcglToshN?=
 =?us-ascii?Q?ep6KypaT1ltymq+LHcbSXemOp4xkQdVcrbe9YybL1QdJPtnrSGIy95ms6xrV?=
 =?us-ascii?Q?C42mQ+BDLa3f0cDwP2Eeb9THhxc75BKITKjawDfYNE8Avnx9nNUcCiHxVHrV?=
 =?us-ascii?Q?SB4m7yYTknZxM36vK/E02KivQyj148rjlnVDAL7TMMoAUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mk9Oq6LjvzN/FO+9p3AXzY0if/jPn7GPguJLc7ozapmqTEdUE44es11bW3Ja?=
 =?us-ascii?Q?XyiRMBV1T6oVMCC6fUJDdopLMc+pihyuP6dInXTA+1SUXUtIBFfWMLAE0jG2?=
 =?us-ascii?Q?yudbduFAfqB6C2rhN2bU0lQO1InWCNtw6cR2QrpzL9Nf0cZA+A6DFPyvrNpx?=
 =?us-ascii?Q?+w/lDDc0fLXI3+8jQoPnKQBFU03pPymz9XM600LZZmZ0zJT0OuACdiPLhSEB?=
 =?us-ascii?Q?LFB3afwvpjbfb5KYmqfjjt7HsX5AJa7sDSYoBQclNBbMvt6R9QR1X9xF1tY0?=
 =?us-ascii?Q?DdJzvFZbf9oWqfcTtmEi6qc7kdiNjPIXTe/VvUJzkRwH3VzPjzQL8ERCdMlo?=
 =?us-ascii?Q?qM+ttes8Rf8+VkbeWIQUUYK80yODaVHeZMBDREmoXJ8GDbhfk8r02fLuN67H?=
 =?us-ascii?Q?ge3mrrMmOZjiZoytLO8UnV9i8SFQSAYIgE4Kdqc7dTmdjKtPo/BvuzJovA0X?=
 =?us-ascii?Q?4jiLGpwXFsn4C1mYCASURvKYJUTfafHJxdG5UIISjqREUTwqgpX84B7O9buO?=
 =?us-ascii?Q?sYjRRjfHpQOFR0jZhAX6Md0oaB+Hb4PqgYdDFvE6o+qDWzK2CYl3fDNFdWoy?=
 =?us-ascii?Q?DxksIGFgSg9LRyqI3+D6+a+LGnZ1GukhUaRCKMBYlLuVmnmoLnP2gXicHWQ9?=
 =?us-ascii?Q?F+Gu9JXbCs3dRBf3WfFajYx7HRsIZlXTSnLvtMvZhDHBJGBIzatk34F8jQdk?=
 =?us-ascii?Q?APVlecsAA2JSSwOmaJ10lPyRqGoDyVAS4v1PrtkUTH2w3prMwlmKhn2r+2sA?=
 =?us-ascii?Q?x+juY8nc0bzPHk/BTWYNjRhjl46r7uITVP2T/uxa+bXIR/UvbM5AyF8c26+H?=
 =?us-ascii?Q?UrA/bKaX+MLlMcPn5LRjiNQsYIIne7ekVe243iFbMcDci51snctx9MyHDIdB?=
 =?us-ascii?Q?nDQosRlGbBv5F48I1vam1jx5VYzZtTjdgHDy5VGvDoXRGTLz/cKWMfbAZ3TV?=
 =?us-ascii?Q?EeivpmeC0ApwKrPn6XmOq6nlRbxfyl0lEtMAG9va4CxWuIkHdb03xDStTPlH?=
 =?us-ascii?Q?et5mC8Igt6yCd+MqlPhunB1PVAedXhbrUW3XfjoCsve2yP5tkrgu70foL3+v?=
 =?us-ascii?Q?zVKE0hqSqDDy9ToyA+81iB60eS0z1QrCgKOcG85ycUS0fOSPSaXlt7bVjJuQ?=
 =?us-ascii?Q?KPbnfDo1KzrvQNUgGQ4GoFF/M27mQHK/4WP7WzyQr9wxgOlSKELDI4O8rLpN?=
 =?us-ascii?Q?RoC+ZWtGRf3wJsd6WMuyRQQIMV4LiuvOstJ2x5IKsV6AF+U97yuMULcIKVV/?=
 =?us-ascii?Q?6C9G6eYoY2jIJHFGTiFnhPNmLFq5MmiPREHqOHnDnOkqVDAePwkryZCUDd6h?=
 =?us-ascii?Q?N4cdo7cvNMpmMFDlknE3UEE09Ns6hK6lsr0ErMWD7Uf19VDbueZHLNrLaJam?=
 =?us-ascii?Q?P32DeziJ2Wee3K1r8Vd5ZKDqmX/27f6mCVrU93bSot7Oeafn4S+SdO0nUfKe?=
 =?us-ascii?Q?OTE+girqDKPpTzRwVCYgUFfu5blX3dTlo0tOjXwD/euXplLA9T6Znj235vcW?=
 =?us-ascii?Q?+lcQyIERanaifpJjwGtPIy00UBRvYiIzP0gE0AziEZVcsd3F50tCcXP4Xrps?=
 =?us-ascii?Q?d8vPEPBJMn7XofZrE/sccdkk5f4xqpWQdO7RgJiPnv4DzdmRWOUvg7uabslA?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7409ee90-7036-47ef-9b34-08dcb546d15a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:04:54.6492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPWCwtTB+Ni5PCYosPUr7JhYE156+WwXYTjAEeEidEmPpc4xSO3OYqWqdjPZZZ6gXxR6qMLdUOUIWoLM8j8FNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10499

This implements the MediaAssistant "Push" command, to trigger the
BlueZ Broadcast Assistant to send stream information to the peer.

After issuing the "Push" command, the user is prompted to enter
any stream metadata to be sent to the peer. If the "auto" value
is chosen, the default metadata found in the BASE will be sent.
Otherwise, the LTVs found in the BASE will be overwritten by the
user input.

If the stream is encrypted, the user is also prompted to enter the
Broadcast Code for decrypting. If the "auto" value is chosen, a zero
filled array will be provided over DBus.

Below is a bluetoothctl log to exercise the "Push" command for an
unencrypted stream:

client/bluetoothctl
[bluetooth]# [CHG] Controller 00:60:37:31:7E:3F Pairable: yes
[bluetooth]# AdvertisementMonitor path registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
[bluetooth]# connect 00:60:37:31:7E:3F
Attempting to connect to 00:60:37:31:7E:3F
[CHG] Device 00:60:37:31:7E:3F Connected: yes
[00-60-37-31-7E-3F]# Connection successful
[00-60-37-31-7E-3F]# [NEW] Device 15:19:44:63:76:7A 15-19-44-63-76-7A
[00-60-37-31-7E-3F]# [NEW] Assistant
      /org/bluez/hci0/src_15_19_44_63_76_7A/dev_00_60_37_31_7E_3F/bis1
[00-60-37-31-7E-3F]# assistant.push
      /org/bluez/hci0/src_15_19_44_63_76_7A/dev_00_60_37_31_7E_3F/bis1
[Assistant] Enter Metadata (auto/value): 0x03 0x02 0x04 0x00
[00-60-37-31-7E-3F]# [CHG] Assistant
      /org/bluez/hci0/src_15_19_44_63_76_7A/dev_00_60_37_31_7E_3F/bis1
      State: pending
[00-60-37-31-7E-3F]# Assistant
      /org/bluez/hci0/src_15_19_44_63_76_7A/dev_00_60_37_31_7E_3F/bis1
      pushed
[00-60-37-31-7E-3F]# [CHG] Assistant
      /org/bluez/hci0/src_15_19_44_63_76_7A/dev_00_60_37_31_7E_3F/bis1
      State: active

The btmon log below shows the GATT write command sent by the Assistant
and the GATT notification received from the peer:

< ACL Data TX: Handle 0 flags 0x00 dlen 32
      ATT: Write Command (0x52) len 27
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[25]: 02017a766344191500c21a3702ffff01010000000403020400
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 15:19:44:63:76:7A
            Source_Adv_SID: 0
            Broadcast_ID: 0x371ac2
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000001
              Metadata: #0: len 0x03 type 0x02
              Metadata:   04 00

> ACL Data RX: Handle 0 flags 0x01 dlen 6
      ATT: Handle Multiple Value Notification (0x23) len 28
        Length: 0x0018
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[24]: 01017a766344191500c21a37020001010000000403020400
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 15:19:44:63:76:7A
          Source_Adv_SID: 0
          Broadcast_ID: 0x371ac2
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000001
            Metadata: #0: len 0x03 type 0x02
            Metadata:   04 00

The bluetoothctl log below shows the "Push" command flow for an
encrypted stream:

client/bluetoothctl
[bluetooth]# [CHG] Controller 00:60:37:31:7E:3F Pairable: yes
[bluetooth]# AdvertisementMonitor path registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
[bluetooth]# connect 00:60:37:31:7E:3F
Attempting to connect to 00:60:37:31:7E:3F
[CHG] Device 00:60:37:31:7E:3F Connected: yes
[00-60-37-31-7E-3F]# Connection successful
[00-60-37-31-7E-3F]# [NEW] Device 05:1F:EE:F3:F8:7D 05-1F-EE-F3-F8-7D
[00-60-37-31-7E-3F]# [NEW] Assistant
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
[00-60-37-31-7E-3F]# assistant.push
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
[Assistant] Enter Metadata (auto/value): 0x03 0x02 0x04 0x00
[Assistant] Enter Broadcast Code (auto/value): 0x01 0x02 0x68 0x05 0x53
      0xf1 0x41 0x5a 0xa2 0x65 0xbb 0xaf 0xc6 0xea 0x03 0xb8
[00-60-37-31-7E-3F]# [CHG] Assistant
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
      State: pending
[00-60-37-31-7E-3F]# Assistant
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
      pushed
[00-60-37-31-7E-3F]# [CHG] Assistant
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
      State: requesting
[00-60-37-31-7E-3F]# [CHG] Assistant
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
      State: active

The GATT write commands and notifications for this scenario are shown
in the btmon log below:

< ACL Data TX: Handle 0 flags 0x00 dlen 32
      ATT: Write Command (0x52) len 27
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[25]: 02017df8f3ee1f0500f4015d02ffff01010000000403020400
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 05:1F:EE:F3:F8:7D
            Source_Adv_SID: 0
            Broadcast_ID: 0x5d01f4
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000001
              Metadata: #0: len 0x03 type 0x02
              Metadata:   04 00

> ACL Data RX: Handle 0 flags 0x01 dlen 6
      ATT: Handle Multiple Value Notification (0x23) len 28
        Length: 0x0018
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[24]: 01017df8f3ee1f0500f4015d020101000000000403020400
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 05:1F:EE:F3:F8:7D
          Source_Adv_SID: 0
          Broadcast_ID: 0x5d01f4
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Broadcast_Code required
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
            Metadata: #0: len 0x03 type 0x02
            Metadata:   04 00

< ACL Data TX: Handle 0 flags 0x00 dlen 25
      ATT: Write Command (0x52) len 20
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[18]: 04010102680553f1415aa265bbafc6ea03b8
            Opcode: Set Broadcast_Code (0x04)
            Source_ID: 1
            Broadcast_Code[16]: 0102680553f1415aa265bbafc6ea03b8

> ACL Data RX: Handle 0 flags 0x01 dlen 6
      ATT: Handle Multiple Value Notification (0x23) len 28
        Length: 0x0018
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[24]: 01017df8f3ee1f0500f4015d020201010000000403020400
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 05:1F:EE:F3:F8:7D
          Source_Adv_SID: 0
          Broadcast_ID: 0x5d01f4
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Decrypting
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000001
            Metadata: #0: len 0x03 type 0x02
            Metadata:   04 00
---
 client/assistant.c | 247 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 247 insertions(+)

diff --git a/client/assistant.c b/client/assistant.c
index 69a955c18..77fb78329 100644
--- a/client/assistant.c
+++ b/client/assistant.c
@@ -43,6 +43,14 @@
 
 #define MEDIA_ASSISTANT_INTERFACE "org.bluez.MediaAssistant1"
 
+#define BCODE_LEN		16
+
+struct assistant_config {
+	GDBusProxy *proxy;	/* DBus object reference */
+	struct iovec *meta;	/* Stream metadata LTVs */
+	struct bt_iso_qos qos;	/* Stream QoS parameters */
+};
+
 static DBusConnection *dbus_conn;
 
 static GList *assistants;
@@ -141,10 +149,249 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
 	assistants = NULL;
 }
 
+static uint8_t *str2bytearray(char *arg, size_t *val_len)
+{
+	uint8_t value[UINT8_MAX];
+	char *entry;
+	unsigned int i;
+
+	for (i = 0; (entry = strsep(&arg, " \t")) != NULL; i++) {
+		long val;
+		char *endptr = NULL;
+
+		if (*entry == '\0')
+			continue;
+
+		if (i >= G_N_ELEMENTS(value)) {
+			bt_shell_printf("Too much data\n");
+			return NULL;
+		}
+
+		val = strtol(entry, &endptr, 0);
+		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
+			bt_shell_printf("Invalid value at index %d\n", i);
+			return NULL;
+		}
+
+		value[i] = val;
+	}
+
+	*val_len = i;
+
+	return util_memdup(value, i);
+}
+
+static void append_qos(DBusMessageIter *iter, struct assistant_config *cfg)
+{
+	DBusMessageIter entry, var, dict;
+	const char *key = "QoS";
+	const char *bcode_key = "BCode";
+	uint8_t *bcode = cfg->qos.bcast.bcode;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_DICT_ENTRY,
+						NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+						"a{sv}", &var);
+
+	dbus_message_iter_open_container(&var, DBUS_TYPE_ARRAY, "{sv}",
+					&dict);
+
+	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING,
+					&bcode_key, DBUS_TYPE_BYTE,
+					&bcode, BCODE_LEN);
+
+	dbus_message_iter_close_container(&var, &dict);
+	dbus_message_iter_close_container(&entry, &var);
+	dbus_message_iter_close_container(iter, &entry);
+}
+
+static void push_setup(DBusMessageIter *iter, void *user_data)
+{
+	struct assistant_config *cfg = user_data;
+	DBusMessageIter dict;
+	const char *meta = "Metadata";
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
+
+	if (cfg->meta)
+		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &meta,
+				DBUS_TYPE_BYTE, &cfg->meta->iov_base,
+				cfg->meta->iov_len);
+
+	if (cfg->qos.bcast.encryption)
+		append_qos(&dict, cfg);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+static void push_reply(DBusMessage *message, void *user_data)
+{
+	struct assistant_config *cfg = user_data;
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message)) {
+		bt_shell_printf("Failed to push assistant: %s\n",
+				error.name);
+
+		dbus_error_free(&error);
+
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Assistant %s pushed\n",
+				g_dbus_proxy_get_path(cfg->proxy));
+
+	free(cfg->meta);
+	g_free(cfg);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void assistant_set_bcode_cfg(const char *input, void *user_data)
+{
+	struct assistant_config *cfg = user_data;
+	char *endptr;
+	uint8_t *bcode = cfg->qos.bcast.bcode;
+
+	if (!strcasecmp(input, "a") || !strcasecmp(input, "auto")) {
+		memset(bcode, 0, BCODE_LEN);
+	} else {
+		bcode[0] = strtol(input, &endptr, 16);
+
+		for (uint8_t i = 1; i < BCODE_LEN; i++)
+			bcode[i] = strtol(endptr, &endptr, 16);
+	}
+
+	if (!g_dbus_proxy_method_call(cfg->proxy, "Push",
+					push_setup, push_reply,
+					cfg, NULL)) {
+		bt_shell_printf("Failed to push assistant\n");
+
+		free(cfg->meta);
+		g_free(cfg);
+
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
+static void assistant_set_metadata_cfg(const char *input, void *user_data)
+{
+	struct assistant_config *cfg = user_data;
+	DBusMessageIter iter, dict, entry, value;
+	const char *key;
+
+	if (!strcasecmp(input, "a") || !strcasecmp(input, "auto"))
+		goto done;
+
+	if (!cfg->meta)
+		cfg->meta = g_new0(struct iovec, 1);
+
+	cfg->meta->iov_base = str2bytearray((char *) input,
+				&cfg->meta->iov_len);
+	if (!cfg->meta->iov_base) {
+		free(cfg->meta);
+		cfg->meta = NULL;
+	}
+
+done:
+	/* Get QoS property to check if the stream is encrypted */
+	if (!g_dbus_proxy_get_property(cfg->proxy, "QoS", &iter))
+		goto fail;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		goto fail;
+
+	dbus_message_iter_recurse(&iter, &dict);
+
+	if (dbus_message_iter_get_arg_type(&dict) != DBUS_TYPE_DICT_ENTRY)
+		goto fail;
+
+	dbus_message_iter_recurse(&dict, &entry);
+	dbus_message_iter_get_basic(&entry, &key);
+
+	if (strcasecmp(key, "Encryption") != 0)
+		goto fail;
+
+	dbus_message_iter_next(&entry);
+	dbus_message_iter_recurse(&entry, &value);
+
+	if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_BYTE)
+		goto fail;
+
+	dbus_message_iter_get_basic(&value, &cfg->qos.bcast.encryption);
+
+	if (cfg->qos.bcast.encryption)
+		/* Prompt user to enter the Broadcast Code to decrypt
+		 * the stream
+		 */
+		bt_shell_prompt_input("Assistant",
+				"Enter Broadcast Code (auto/value):",
+				assistant_set_bcode_cfg, cfg);
+	else
+		if (!g_dbus_proxy_method_call(cfg->proxy, "Push",
+						push_setup, push_reply,
+						cfg, NULL)) {
+			bt_shell_printf("Failed to push assistant\n");
+			goto fail;
+		}
+
+	return;
+
+fail:
+	free(cfg->meta);
+	g_free(cfg);
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void cmd_push_assistant(int argc, char *argv[])
+{
+	struct assistant_config *cfg;
+
+	cfg = new0(struct assistant_config, 1);
+	if (!cfg)
+		goto fail;
+
+	/* Search for DBus object */
+	cfg->proxy = g_dbus_proxy_lookup(assistants, NULL, argv[1],
+						MEDIA_ASSISTANT_INTERFACE);
+	if (!cfg->proxy) {
+		bt_shell_printf("Assistant %s not found\n", argv[1]);
+		goto fail;
+	}
+
+	/* Prompt user to enter metadata */
+	bt_shell_prompt_input("Assistant",
+			"Enter Metadata (auto/value):",
+			assistant_set_metadata_cfg, cfg);
+
+	return;
+
+fail:
+	g_free(cfg);
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static const struct bt_shell_menu assistant_menu = {
+	.name = "assistant",
+	.desc = "Media Assistant Submenu",
+	.entries = {
+	{ "push", "<assistant>", cmd_push_assistant,
+					"Send stream information to peer" },
+	{} },
+};
+
 static GDBusClient * client;
 
 void assistant_add_submenu(void)
 {
+	bt_shell_add_submenu(&assistant_menu);
+
 	dbus_conn = bt_shell_get_env("DBUS_CONNECTION");
 	if (!dbus_conn || client)
 		return;
-- 
2.39.2

