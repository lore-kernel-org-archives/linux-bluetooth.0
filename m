Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2058.outbound.protection.outlook.com [40.107.13.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CE716D4DF
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351287; cv=fail; b=XNyv/JQG7BFYNGzIeb5+UWNifLHVkhRzuP/Gqn1RSLjX58LuzQSlmvN3gtRNS5DIWILO1PeZh5bsDyRDIYk0xsMSNS7DwmpfZng6nBzR8m+e8LDfgyPDG02rHunOmVcJRnxNt6rJWscAul81ZBz4Fd0l8f1YggZc+TxmJRh8c8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351287; c=relaxed/simple;
	bh=zH8L1UqihVsOEJLKu5ibWYku67wK+eVD9Go8huWHCnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mm6Qquz1LCSaPQl0e2vkzdzhVN4P3Xao0JKVQl/KiWfVKJl0cWXnj3qUE3q5PNC88r0cBosBKirWMoOLA3isSt1Y2V558l9czJ/W8zhMQT8tspoYx1A+XhRDNFYkj0rKJYoRwNCZ3um3fw7AvTWnf4Etmc7UymLuXGLQQlKu9XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=crlqjYNk; arc=fail smtp.client-ip=40.107.13.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="crlqjYNk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCKQZUsdFZioCtF65Th6bD0PPG8n5TGeNXXQ5HHOqPBO7dPlgb+916DQ/eJegE1wO3K33Du54wY3pxBuuOOdButIvxKmaiD6iTdjSyi8WHP8JNnIxfzmaY5aMHICGJsjOZUz4Fy/6UwGrZAl9+MJYQNK6Hcw9375K3m01ArX92NY3JnsP3zQ2ldPm3ABO6mfHvZL1fg4S4FciA8TrX0Lvn7XLbbf/lXHpwKxgXyLFIIjawiB/Lnye9gchxOT3YKom9U+GB/U8LvaxP3n3M8oXwErRhWecc8bSpNVgpwTth8phd6jQHwO6k88avvPjU8PEVjfzU2lAhXEKX8fbSMIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gKYGZ+RP+lrZQRa9y3LnILmLVfQe8GWcpI6XocZXec=;
 b=E6kS2chvzxqakBsmJqWzgMLXqq1p6jRrAoNudoaQMn18JppzgwvXarydsCyPSGN2M3NUIioNxA4u3LJjKXTP9ia4vaSJBOQyKfw0JaVTby9BOCrnCa4H9amTecFBndFKiWMozzs2tCgkFE/UMUz7gQiq04ylDONiieqe+NY32i1AFQ9kU+oiUWc6G9VQX9eGx9nhc+NWQyYXeN2eEyGNxp54M5IX9v8EY91uOKSYsrlnxNV5fL1pC/oLPKm4HX4S/gIVhxmgNlGvSCZcrkh0D3aE9jx3I8RQX0TdKBh/yeZQuce91rQW7+YtYN9/bgWXRcHtnZOIYdmiPf+zRzPQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gKYGZ+RP+lrZQRa9y3LnILmLVfQe8GWcpI6XocZXec=;
 b=crlqjYNkdCI9qt5ZqMIgtzUqxSrMeoPYcX7T9ui1MHIXZyyvIqXD3PhX1vUrNphZdTQtFQwZIfm8jy0ArEDki9+SRHgV5H72x8kgfA57dEyHuJRne6wOfWQxveWuL5PmcrOsabwEUIn6sv9kQJJK6DZMgR9t/I73zZpU72KemWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB9592.eurprd04.prod.outlook.com (2603:10a6:102:271::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 14:28:03 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 14:28:03 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/4] shared/bap: Fix uninitialized field at BASE generation
Date: Fri, 10 May 2024 17:27:51 +0300
Message-Id: <20240510142754.3901-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240510142754.3901-1-iulia.tanasescu@nxp.com>
References: <20240510142754.3901-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0133.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::31) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: ec997fd7-8841-4f13-096f-08dc70fd66d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ALbbDblpI7h7JQHPwtRjfUJNJ8HJF2Nioxz8SAZCrDD8fGyD8XaxC3alRmLT?=
 =?us-ascii?Q?e4tbLvOlfWd3VcfVQi8oP5jvcnvS2rHjHNeG5wC/Ms+9a2AJB8JCdqfZ7Ooy?=
 =?us-ascii?Q?xNuagV+1K8O0B7KXZXyzNXPz8Y1rU4y5lcXlyQqBvVS4VTbmRpjLQocPIvM0?=
 =?us-ascii?Q?i5zDMby+Z51A0NWwv/tOUrlR7vr/d2HkvLz56a2jL2MQNtgezRN/zDy/WO9a?=
 =?us-ascii?Q?/ESzZaKZcPY+isB+tcYLCIBBI+9FsDtK9OCH70UDQxaYixbxkUJGJRBg0r8W?=
 =?us-ascii?Q?qtFZHJF8oykXdEVL/Al8yMpioUeWFiSCnvsWpJY9lSPijyttRfSzF2zaqDpG?=
 =?us-ascii?Q?XISsLJjrkFIu9VWL7kB2YyqY9HUhGVu+O6xjUn1e1j7j9DtynrmdPbIwCPjX?=
 =?us-ascii?Q?HBerbfK1EBjeGOohqc5R32YK9s2snwn3owFW6/9N/1pSrGv0gdjo34cuuG42?=
 =?us-ascii?Q?LUUfksjNjFh5gKlFmXjIJiIfn7TMCb8pQW4kpVgB8g8YnRaO6wtZiVeoZIeV?=
 =?us-ascii?Q?8b69Gb7fJ9j8WR4NEFLa3iI3bEpIdLEdSJsvvGpRMJ3tTklJqgbmzV2r9oUu?=
 =?us-ascii?Q?C5uPEyL91oyly3KwWH/EDWmyw+cbeXtg5f5tvpuEXvi2fVPK7YM1k4mPpQ3u?=
 =?us-ascii?Q?W6QB1wRdk1MAmWTH47KPzOu+OejG4ld4D7vG2pPRQjZ71+a5O8U1I97upGvi?=
 =?us-ascii?Q?LE7H0d3JQQpgTnQtYWjFHa3NKEDISg5+/g7onXBURkS6oSlvWwXBmtuxunUK?=
 =?us-ascii?Q?n+74RUoGbh1PCSRMk6qGXWc1QjhpO+JYzvfSgh2ioh94Uop+1GiqhAnDKfRi?=
 =?us-ascii?Q?oOTjSzzrqyM6OnQiMRZhs9Kl1RXLPtwWGArZc0kSVoKQ6ioaPyDxNLxWQl8t?=
 =?us-ascii?Q?EYjZ7cO5U+SO8jJKNvKWWjtiqs/mYTp4UYKVc55U5b3fsMFpyu6n478AA2Xj?=
 =?us-ascii?Q?d2WvtTG7zWc4NU+2WBSl340w2xt1AlW5ssPIYDoGSXajM3qxud/BijJCyPVI?=
 =?us-ascii?Q?eV/IclIELSdC+vYdmuCt8fNnszSvub8gEnN8PesDpjt6Q2ipR9qQFDZ38vqG?=
 =?us-ascii?Q?27GLx8UkdEX4sCgtQbvthCVheEtb1UJzvTq7EOl55ULNPbyQGvSxlt+/Hy4n?=
 =?us-ascii?Q?t6moatqz1qK3B/VnWyX2RIIXKqSEOPtmogCndIcidaBS3dk0esBXIrdw14Zi?=
 =?us-ascii?Q?osUQFizq5mOcDBJmRU9IQl20ygZc9/x7OLPWipKUA0cucHesaqYDrRrT5IT5?=
 =?us-ascii?Q?El8Y4GXrcbYH1v8bxYNau3cicFx8uN862FsbSz/CKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MMWAwzLNXqe0lNW0A8G4G1krAlzTnZc0NfzE7Ne0uXOeeNjLRKR+eV0OivcU?=
 =?us-ascii?Q?7XBC4zhYsmRa+57EJY/GEIPt5otguF9Cr6I/4FXeqW+0hL4bjjFHUj+RTCRK?=
 =?us-ascii?Q?oQH3Qc4W9SKPWCI7ouMSNHTfqGpoDtWBsEnt6Lqsp/RrTQp7v4S0b3Pchva3?=
 =?us-ascii?Q?GeQTPTnUTgc6n2oVLMBOiV36NxnXTZmC9TZ6vCbAu9cuvnyBw7/H6LGA8MqK?=
 =?us-ascii?Q?GJhmCJXMo5QB+8bsEwoAvA8SVy6teybG808ucMai9jgP14Qv/xO6YfhmB1jg?=
 =?us-ascii?Q?P2BcY/NckmSDRrcMGyhc2q23arz04PrRuhCBUnC5fFXRSBCMjou/4rm17dYB?=
 =?us-ascii?Q?nAdng19EChz/LaB2/oN/hlwyIiYXQUWV+bCC3UWyrsxE/FidVjCRVYyK9xmM?=
 =?us-ascii?Q?DZ8ks3YvHlAs5M6atn6mPgBPzShY/H8uWB7K9fht6jURcyleJwgwTRI63jnN?=
 =?us-ascii?Q?RH8m7cbIHO3xqx4cehiUleuGaWzSjBUPLXFO4wjeQy5w+sS4qveZ1Te3RvHk?=
 =?us-ascii?Q?RmVPCPmx8kncvlokCooSTStVBXzTyzij714JbONZWmxshig6Pm4PtRYulT58?=
 =?us-ascii?Q?of8OJnm46Ek5IuvjyZVdPJltaufJfV2kbUKGmyLBFkEW5wsuTrhVbNKMONKK?=
 =?us-ascii?Q?rT6XndaYmD8yOSo5HMHbGgU5ZQ59XsD7pFv6hV1R33rcxQVAoczb1lJNO5+7?=
 =?us-ascii?Q?LezGQbGJkUlAexjUlkbP1W24TAFgruuP2/yROjQx222CHtySkxwUSqWWPrUJ?=
 =?us-ascii?Q?8iL9EqOLMqEZHJVi/5bjFucw8Wd8tD2zOTk8vxtithcZJMU0tAZwjdv/5VJX?=
 =?us-ascii?Q?XkSRrP1BwIvJb/pz96BVGUO0dfHTa8IBfPUwgi9vh+R9CLaRHJb8ihHUnlSe?=
 =?us-ascii?Q?gDANuSAswMjeG5kyagCvbpFNicpKxkxShmNJhBmyQzHDWLK/pZ3d7bTZRP45?=
 =?us-ascii?Q?A7Klvq+IP1BG6y72Sp1Be99IgdxJQ1kBKOP0aDoWRwX2SBleSz+IgUxRmxq7?=
 =?us-ascii?Q?JTQsuhlk8Ai0keEb77nslb9NuZNXCvZI+teWB+qCCdbEg3UuDdeksmg0rH79?=
 =?us-ascii?Q?fuHDjfIKc+SLSljMENbxA+kV/i+pWjFRX3L4UHQIj3Fs5FgakwyePVSgffei?=
 =?us-ascii?Q?xR007uYJL/ijq0LsA22emfuUVRtYfCR0gn0rZ6UiN7sg8akSPQSxsHxR3+0s?=
 =?us-ascii?Q?IW3rKl2uqEkPOs3jGGUoMx272DqRl+4g+VYFvmONZx/h8EQUd6ZcIzltUriB?=
 =?us-ascii?Q?k0OAJ+5COkrqqh7dMso6r+OhB1DPl7mgsF1NInJPtmXt5WrEIUfwZf7QqxGh?=
 =?us-ascii?Q?+q1k5lB81r1nZ/Ijjjmav08dJWQtMC8+VkbKwd95D1q6nA5Y8n+lQdpzCh+K?=
 =?us-ascii?Q?Os7MVKgUK0SM/W9BSUckCd+6NXvu9Wxw2yRulUqcsvoEmceWL6n7o/iTsuHc?=
 =?us-ascii?Q?TFB7//2oSJnbFtLjExlGReKRjel8ABe+MeEdiSGMmrXU+RllBsVEcsDsent0?=
 =?us-ascii?Q?he3LWBBd7mIp2gLYj6O6kez7O+FaH9iw3hxA8w5LsmKWMjeLxAc0Kyo3DlvD?=
 =?us-ascii?Q?kVqWeH3AUvC36pWJpyYhXxJvcLiJrNrnGghK4iug+o2JAflzlOUll2NcUFJG?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec997fd7-8841-4f13-096f-08dc70fd66d6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 14:28:03.5275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDszlhGnfq6WQpL1UkwkXqideb3VbFsM47CdjcF0V/dbAEYLynmXpZJBgn3mDDwQri8gN10Vnbr+dZr6Jt2W7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9592

Currently in bt_bap_stream_get_base, the pres_delay inside the base
variable is left uninitialized and it is later accessed in
set_base_subgroup, to be compared to each stream presentation delay.

This commit adds a fix by initializing the pres_delay field to the
current stream presentation delay, before later updating it based on
comparison.
---
 src/shared/bap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 818326f45..1316d7c73 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6321,6 +6321,7 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream)
 	base.subgroups = queue_new();
 	base.next_bis_index = 1;
 	base.big_id = stream->qos.bcast.big;
+	base.pres_delay = stream->qos.bcast.delay;
 
 	/* If the BIG ID was explicitly set, create a BASE with information
 	 * from all streams belonging to this BIG. Otherwise, create a BASE
-- 
2.39.2

