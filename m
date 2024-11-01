Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8516F900
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461905; cv=fail; b=KdwkIJgDsAo3Hkb6V4ev+jiUlY0XiSpptf3s/xdycOuV+4YDLrZi4vDWyHQ/HTIIpbGhGqN6IUhplT3VMPBMEC6cqwG2umS+4n3FowSxBo06ohWEcC47wkVwALBukRZG12dNYAxQGbkVLGoRDk9Jlxck5fTgYhT8hcFdpS7Ez3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461905; c=relaxed/simple;
	bh=FL0cUW0EAtpzEtRQi0hgAxNWQWbInjeG2FmpVLrKWM4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EswNrDITCPOBqGyi8dmMfJyug8olgP/ZuxOJrAITVVT18EQhV3Fmo51UjPH4rtO+V+1hB/ML6Kr8IopM6jzwogrC2BpBhc7+Vchg3NctSbGenWrVTM+I2L5/CN9Wq9BpKIFScdJI+49GzALXmdy+7mIBnnw1QGNl+80cGf0QEGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S0vK01Y9; arc=fail smtp.client-ip=40.107.105.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S0vK01Y9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTbAVEmXus91KdPKX0QKlqdNtDCWMKNogqlaNlcLBBFJREdjlnoreOzDGEwZeSjdTKtYXmFMAwT9ezXUyhS5BLDDBJ2WVWlD0iC0karIstLmdcm57mn2USDUqaQwk6F4reH68gYfMNf/hTOYKBAdQ17dAU0pSQkSd0e7rHJdqa+xAohf2CKSKSkTirHZLtPLiUEg6FPHkOdPQguDtLuWly4FIwM8kxtXw6cNbc2r/RME3aCHSI3kqNUfX/y8/BrwXWMz5zjZi3w5z2gpzgeoixydHKnT/Ekrz0Tgb19Wb6IAbXAss3iCr/0j2RlnFtHb0SpBztANktqxYU4nzQTvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyqY4Dg44qmIlUhmCwjwmVxWzMOdnSp/nnZYCC1g/X4=;
 b=N/wX7r+roahF1gECNFfaP70bLGULM0LN44RKYq3A3yYlWxaupPhab+iSg6RHJoLISDFlm6Hv2gzvThAgAS9lGPiyABSyZyw6cTC9KoXaZNy1iV/jcpZVrNy4fyqVQBaW+KqJIEUsgYbRS5tdQYZ5YqeWLeitFeuJrHnUd8X4dk6wxIdT2gGEptOFAWreEnfu2HYJUlzTxxhXua7pfUgEBqqIkNXWfNpamFK6MEfSrVKLgH7XStdaBJo5JKaWMJvIPn52GouvDRy8PSGgPsdGbq0XqKtiFXwvPA2N7QKAhrxK0zP3FJxkVExR3oqbO8YG58MRabfpp+33aM6mMBX9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyqY4Dg44qmIlUhmCwjwmVxWzMOdnSp/nnZYCC1g/X4=;
 b=S0vK01Y9FWQQYysT9JwyY6bxDxoEljU4m+Tkyt9qKPytQuevDocno13AMgkoCBIxVLJyXz2ez9SQHFetiY6Fe8/kb5t1wncGZILCSx05dx0RFfVHS9Sr9XHy1t4a6iqqazcQ1DL0thRboryINWFL1QSL7VVL9Dpfa3buDvc/xhsHrbJPYMlbxG6pqlbP1rgNt81ufKbLabODSWgtpDKPXIRDo2/CTPRE4jev0ocmdZ5TCcTsY4wyveo4x57bb6O31QsKEYl8VxrMvUSTisnKDUlm/mnK0BBn/+iEKvYH1snuM1zpAbejNsN5YeGniDBePH0NmX3crYbx5WcUvzIV6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB6979.eurprd04.prod.outlook.com (2603:10a6:208:18b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 11:51:40 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 11:51:40 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 0/5] iso-tester: Add tests for Broadcast Receiver sync to 2 BIGs
Date: Fri,  1 Nov 2024 13:51:13 +0200
Message-ID: <20241101115118.43891-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 593626d3-4b28-4447-a18c-08dcfa6b8c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E0DiownEKovFbNKbBMcdled51tXrrdOELO1LYLrgJDJHGyMauU6u/WlYCNEx?=
 =?us-ascii?Q?eBUOhDOwOyexGH/OwPf7GFp8BEhZBi0vwGkSSGfFHcp40cmNXfLuCUABVzqU?=
 =?us-ascii?Q?pTilY4LvJISRj6ak27D9roIQRasLGn8YmGrORDiT1jCydkFMwiwBYZ/gh/Rr?=
 =?us-ascii?Q?MOHS+D1aR1UER3WyYsqpl30OEP3gwPbvVIVvvh01H7OIWjJMpvMeHYBGlm0e?=
 =?us-ascii?Q?Lq9Zi8DPvphB6UKm/oj1QCla8iFJlwxAL9Zdu76rxKWI+rraPgjVfjJE4t+W?=
 =?us-ascii?Q?rieViONMo/S/Yd7E+OnXQ61qie07djoRWg2ugtr/9H0KPu1Yxm/XC/btIT+U?=
 =?us-ascii?Q?ndEwomqUVEcy3dbX77jXmfo60NZeOccH46wV2zIrvng1Sct8nGw9zvi8ZxpO?=
 =?us-ascii?Q?kxtKuzjMDdewoO7rft/yNM8vPgKQbSf7IJnj63Gq2B60xlOWYXPd2UcUesQk?=
 =?us-ascii?Q?EHYcrcXuJlYwkgrVpYpKDjmVzhi+7WIGoIdnJB8aX3pJl4U2WCHJReSMNK7M?=
 =?us-ascii?Q?eXNTx6iHcWVlzy7oCRtaOQNOXT0VoCw+BiX+oNfYh5ntHFT8G2oOvkJ9cZ3j?=
 =?us-ascii?Q?ZxxWAmY02RWh2zdHqNiWgQgZmg5F049Hik+3pwL8X4KNvmBTpfH744E/N/Fm?=
 =?us-ascii?Q?n3zTru0nvdz+ZbKkb2NR+bBWydjc6bVcIe9gNSekaGkTMfc3NI6PFVJ+fIhL?=
 =?us-ascii?Q?yEPOY22WItdVU9f7jQ6fx+WnIuF3+WFF4m5TjaDLHftmw9zkmZB+FwBFmmLg?=
 =?us-ascii?Q?tZt/58W4H1ztD7h5K+s+t92DOrX+mGlfbHuDB7yxSXkyvKp5ZaEe4eNZxr3q?=
 =?us-ascii?Q?tjyyuPbWGyFD7JF487xIfe7tC/KauambwjtRhUeZsmDVEnCO5r1b90wg3x7n?=
 =?us-ascii?Q?jgpv2teOAdpAqwLbwzum6TTDu3O+mU2drXmjyosMgrMpCyldzakgVZo8zaFb?=
 =?us-ascii?Q?UCeU1oaYmoa2KPsVg92uekDgj7UoHXjF/4vC+8p7vrxWbnCmAc439CSGh8OZ?=
 =?us-ascii?Q?YtPnk14Tul+lcR6Sid95EDMV5U62+8K5p0XXP/GauMz+cyrtF6uMdsOl4YEz?=
 =?us-ascii?Q?/3yeFoz0QWsUKEGlNhCbzjwHjrW7zrIUJRNLZROqEB6I9Wbxza33vGau0/yx?=
 =?us-ascii?Q?ALtoNAqAQB6dzog6LxhL+0/dIGUFhj0CB4khPXXGRB5OqMVAF2m2H1JB4k7I?=
 =?us-ascii?Q?mNVn6DL3cigRFTvQ8RKpVIOKs+KzEkajYivvoHOSx5MPdX0I0kHl2SzaS2pq?=
 =?us-ascii?Q?F20FI10YtMUWO9fYrUoYI1qYbohSZ9LlplfJ7Keqrr1QNfkWMGDtOT4f7gtk?=
 =?us-ascii?Q?264y9h7GQq0uc3pnMVMeh0rIAq+Bqkq8zWyc+xZirq5PZCZNapjF0YVTn68C?=
 =?us-ascii?Q?waj/YeQ8CCgK2naQvdffNBJqWqcd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+J4fqkWAb4OWDO+xLaC7uOyVSwgcSqKtCGl8LkK42OBKU0iTYWGsf8gXfeqP?=
 =?us-ascii?Q?Ocboenh1cqt0uEcHKyyajQEX6v47KJuI+HPunzpLP4SFYH8HH7hIPG6Hy4WG?=
 =?us-ascii?Q?bEH76z1zdtQ4/59SfYOjuFnLk4vcchoTiFCTqHarzViqlr16WuiI7vZRRRJI?=
 =?us-ascii?Q?FPtQ4d2RT8Ddv9sKFiM9iKfVkT2XmCSMI5Hq9JtUHfiGoGZUs56EPlF/+Rf4?=
 =?us-ascii?Q?Xhi2nTYTZiCkL8YVpWx51Ya9nUqs9CXVEGFZBf0++gm/EOqJMGmF3A4wTFnh?=
 =?us-ascii?Q?3CiC+u3Aom9LZGAJXibLjd2Mme3/rUvDhIHmwWo6v56G2NgcI6OnjmGFepEl?=
 =?us-ascii?Q?cNlTW3fbMp0d6xNdWfNNIxQnexnHS6Gpb+CY/FMkfZbOlL8KkzZel82pF1UZ?=
 =?us-ascii?Q?pFKERCLMGthmnZucGm//JuLp1b43r3v5X8L/tVUBEA7OF1GMUUpP63yWvyfN?=
 =?us-ascii?Q?jthIio2E5/dee/UZM5lLvleQi/i29zKE20hDFcBgD22EJF3yZv+Ijmf/+5W6?=
 =?us-ascii?Q?LJIN4n124Za36w+jdoP1L7WfAJZhF1kVt6eWYpYRCfir6CLkB18xfMWveDUb?=
 =?us-ascii?Q?Ydc/G4Xf6n79U5zEmmLxSRIFF4e+b44CafO6nvVxKrF2w6TSq3olw5kjq3Aw?=
 =?us-ascii?Q?XU8CkrJ40DN5IaNqH3LYutOp0VWnNJR005qKYKuvyq+v5LrHiFZjWgRO0On/?=
 =?us-ascii?Q?1AMNWA2H/P7K8EBjTB6ACfDUCcWcvGelN4PuHRVdEspHHYVoXBkk9wfyYSe+?=
 =?us-ascii?Q?enX5wQnQVdmTYBu8kIfHSSLL8UOjAeA7nB+CKzfaQ780UGnn8BpWMmO0V+4I?=
 =?us-ascii?Q?rWx/YnErdhXFfFO75Hor5JN8GskOCmyrDpIVMgfruJR/o36D9ww6j2M8N8Bu?=
 =?us-ascii?Q?4sZaJ7lX7mVcuWzV1OGhS0hrtvV7HIfu1Vu6NqI/Q4jvoOMDrHPA+ZqT/tcJ?=
 =?us-ascii?Q?PHu28Sl65mttmmEAbb35jOrQwrJELKgZ2P4P68vcbToc79GR10SEwVN9Vxsk?=
 =?us-ascii?Q?6m0rLWCyYujtxbJPBaPkxMNPpLEmjoelQXmR2AX8tePO+1TQd0f5tCqrU94r?=
 =?us-ascii?Q?64HxQEnzwmFtF9TUysmGOh/tBZGO0pDRwyak6IWjTYKLxAHPXYy7x/r7LuiZ?=
 =?us-ascii?Q?IzsU4C6oKTYSB3QHle8Vq98Vwj9EjlWS/pBp2Xuua09lUr6Qzob9wm5nOUHL?=
 =?us-ascii?Q?yFo5cXGQTj1NUYXgAx35Gd9btlDGkQB4D05vgUGET0P7w+8ZnTYq6N2M9kdT?=
 =?us-ascii?Q?eigGjNSglPqjXnaG/EZMvrqsf4vQDSw2RwRw4nD1gQrCat/+90eFza3TQJAI?=
 =?us-ascii?Q?plFy2gaoRgfbz3gMhOdNMGzzwxFoHinUHKrK+SXULmlHucv7CfcxqsQw5vA8?=
 =?us-ascii?Q?1R4S7qWD5ZF7mDTIOhlw8BIqr7Qx/OB12mW7oCH7EkLYbD8zev+ICP+mq+ks?=
 =?us-ascii?Q?9EeRq8IQCTPOI6/fLVKNAHrCSCrpCxLuXcYiD4v1Z1GskFBt6GdmRZyPkOmc?=
 =?us-ascii?Q?xbdsfAZKW4XK/IHHADwqPLesxJbREbzsHWPMHfk4CW4qgXhf6AE5Bs14awMS?=
 =?us-ascii?Q?hRY5Kozk2n4a6y3+vvuAtbr7Sf2BAXnGSEdqOPfGSUlPJD2QRdncF6cXxuhY?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593626d3-4b28-4447-a18c-08dcfa6b8c51
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 11:51:40.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBjg4S30pT4g7QtUIeBEIscUcsvMAvo+n9tQPkv0I7vSdbJ0OTUIgmuyQ95U+UilS6dYSVt+2amU5LKosjykRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6979

This adds new Broadcast Receiver tests, for a Broadcast Sink
synchronizing to 2 Broadcasters, with and without defer setup.

ISO Broadcaster Receiver2 - Success
ISO Broadcaster Receiver2 Defer - Success

This also adds emulator support for creating PA sync with
multiple trains and for sync with multiple BIGs.

This patch depends on the kernel support introduced by
https://patchwork.kernel.org/project/bluetooth/cover/20241101082339.4278-1-iulia.tanasescu@nxp.com/

Iulia Tanasescu (5):
  btdev: Add support for syncing to multiple PA trains
  btdev: Add support for syncing to multiple BIGs
  iso-tester: Fix memory leaks in iso_accept_cb
  iso-tester: Add test for Broadcast Receiver sync to 2 BIGs
  iso-tester: Add test for Broadcast Receiver Defer sync to 2 BIGs

 emulator/btdev.c   | 233 ++++++++++++++++++++++++++++++++++-----------
 tools/iso-tester.c | 177 ++++++++++++++++++++++++++--------
 2 files changed, 318 insertions(+), 92 deletions(-)


base-commit: 9e0bc3e63c924037fb483f3b1f08e5348399f8a2
-- 
2.43.0

