Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F202759B4B
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645037; cv=fail; b=GozaRaxMI1V9V8R//mqRZaQRWXQAu9hv1747t0nv2wJkLDP7FtkHEhkdz7GZameHqnhb8V16ZycHfZvhHDLxs3oJujqjPQInORzp54gL+7tkBlXpkfGR1+OPBa9gQLKNqioxrpm75XnfreGxbj/p8wG1W8g9DOfiLBaZnR2/66M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645037; c=relaxed/simple;
	bh=KrEa9Sxrk8i8fzOYW5OXb8/xSywj1graOUQ6dOlBk+c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iyGZaWQ2FyHVkpO6Yi0Vx49RQPkj2p/O739bGmfTTURi3Uj24fVIeVyyZ8WrGMkkHSTNAIyG1IvTw4nz3xGpu/bAXHc/5MT5nUlxqivWLgS26dERoOEXRAatyKEsPAwUSIbwglo9uRXDysQaX5veoGCG866lwpEBA3RY1eY7jk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=PNFS74pS; arc=fail smtp.client-ip=40.107.8.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="PNFS74pS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgmpOBYFAbw+z39aMZSd1F4dRttw2qzU+sbsSBnsqGywK4Hf5YQN19dqhJbQiUDFo+Y6BHte/c5ZJZS3qPE0EOZw1NKsdhl5SQoMbsrb3m1FBKgdm/mJVS9msiNhh/yEw5N5qE7An8NOjqpJgTRD5TtUVlhC2TW2lUhQ/McpJ/d9UhrjK9mEU4mrxDt4KDu22NhJ9lndoJw2BPdqqoM+EVsJap8sVNVipk09YfCefMnXj6TTZs7xqSQETZZ1O1piDPLzY7tK2r1ANsV8JyCMusi8tng4NqoFB0NLYRWg61TAJPmjTI+igcSgIC6VZoFMvqNXAVR5fIT32PgZIl8A6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrEa9Sxrk8i8fzOYW5OXb8/xSywj1graOUQ6dOlBk+c=;
 b=P4aEIGOCCoZcD7G2OEix+eJmY6sNhYR5a8N6qPWa9vsxFeSqdEs920E8qRiWqdxUd3IVOoKo7thgPKIiFNvjc/9i8Nw6iMiSS8DbWnrfdnZwT2bKAhCl6En/6jSsG13Scbt5jzb8atUXPOdVrYLoYamEK1RdbALxhYKcYX9fEr8j0DFWZR15wGcNujB6bMimKoZUjfwSV2bONrHZFC1M5yGkV+fwGn8HrPqMSwpsDFiRjDTCSRNZgOv2/pB6l94gtjliL0J3ypBykK673Zx59IiUGyuI5i9l30qeCdmkovHw+u4gL8lqI6wep1L4QXDy74D+3xOCdcQroFGq+PmrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=intel.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrEa9Sxrk8i8fzOYW5OXb8/xSywj1graOUQ6dOlBk+c=;
 b=PNFS74pSCVYlAhogwCdGSK4LgxxuPtMfsiS2Qfm3pTVxt5O0orxZeYcY786v/YtU5S6giHF/2S+5JPSZiNeRA5wTvzI4qpAo1Y250zNtLTeB1IIl1cdYYk/QEYhCLYlJ+pcVWZW5cimuRpF1Ja1v5CyELbFcG8BXDc4pRBzAGoE=
Received: from DUZPR01CA0246.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::12) by DB9PR07MB7066.eurprd07.prod.outlook.com
 (2603:10a6:10:217::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 10:17:07 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::88) by DUZPR01CA0246.outlook.office365.com
 (2603:10a6:10:4b5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 10:17:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 10:17:07 +0000
Received: from n9w6sw14.localnet (192.168.54.18) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.32; Thu, 2 May
 2024 12:17:06 +0200
From: Christian Eggers <ceggers@arri.de>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Reminder for Bluez5 patch
Date: Thu, 2 May 2024 12:17:06 +0200
Message-ID: <4582780.LvFx2qVVIh@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9D:EE_|DB9PR07MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bdb8d16-8987-4377-ffd1-08dc6a910566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AcXsqQTBIwdUw/bqGPR3/g3Q0z/07NbuynV96B+zRvphQVQUuRTgq/6FC2QQ?=
 =?us-ascii?Q?UeOMPvGka9+5yP750FoR6aps4Uq/JnnzD43KEr1zhb68+S+B+lttYFJ0esU2?=
 =?us-ascii?Q?SDnwpW2/yVZdzMSuqCXjVfhR2YmDXDGDF+z8sEdvsmoz/a/Yxl5klpTuLVh2?=
 =?us-ascii?Q?8Q3vDWXws/eonsdGLPlQpZMfKFeuz5Zwm207EXFxjcBrhf61ON6e2gDwMFoT?=
 =?us-ascii?Q?Fg3cUs7C21vrz+DQvcs66zZz0E9VUK1xpRuchxKk4SDPUonkOEjlbkeRmI0M?=
 =?us-ascii?Q?P5l2uEhmINS1NMZwqWEV/7Ya2YRgpjPcWLAL/LU5kpu+fTssp52+WqcQ0dtP?=
 =?us-ascii?Q?EhbjCOVo83omkpZ4nhiZNUP/S0Q0zchlxOcZNA5GOyE/eY74XrjwqAduuZtF?=
 =?us-ascii?Q?VnEuVOZn8B6nn8ULS8hXI2Xye0GsjrDAwDy+ylLmzMsrWKgPgeyMl8JgMnsr?=
 =?us-ascii?Q?uuYkUWSrsmYLpEIiIm7qG1vz1xmEoAqZEAooD37B/1OHd1/NgkatU3Hcphua?=
 =?us-ascii?Q?PQaDVMYGVRTfmaOs5D8QcqTkKoUx6TIEXxz+TKBETW8TahwqtjGfu+4N4js4?=
 =?us-ascii?Q?J2PawiffTFWZhNjWzYgGBiNQFNSYQd/dNHzQCY8GIgjx80KMH5VOUeytQDdP?=
 =?us-ascii?Q?Bb/33DNqbamljm7OQbBBU3NIj90KLl2JFe9Qart1DsAnhbA2Pa7hn0hienhV?=
 =?us-ascii?Q?GQ7GKj3PKM+jomcE9UVOASj6L/JSsBbJHFbmOkgEPVTTtUdlqc1t5DDaTtaU?=
 =?us-ascii?Q?9OldW1A8V8z6hA9QIny3vv7UZ35g+H8NjGv0fpMwgOasNqzrLhkx3Oix7ir/?=
 =?us-ascii?Q?uskr8QrRUogIN+Ed1PpbhkGrMTVCdNBsKeW3iYiSOTwT6lnJeFpU8nuqMkhe?=
 =?us-ascii?Q?eSBBTl25xCos9zbK7PPeH4HPG1flFjI3u6wSqWa5geS/QFaG0EAZ2JczQ+xD?=
 =?us-ascii?Q?Q2NhueaKcr20gzzKFTSlPN8dq3PDTNGeK4kDnxWxadmb+f1bnSVl4B/3zKMX?=
 =?us-ascii?Q?Oizq4Vz5/qVfoi78XeVOT72g3tsOaf6op+Ay+EZrocLbDUnuuewypRs7ar1H?=
 =?us-ascii?Q?oZXi1uuvSOOZvuKJdoYq16eyK2ijehpTgIaBOswUs06DnsZHQIRiClawel+M?=
 =?us-ascii?Q?R8khyLKQhSr5nR3UinvohAtenBFgdaBtemyjP8/YG4a9lBQKXZf55sjXSUUq?=
 =?us-ascii?Q?c+1Ax7wEKgwHEV4YUdQvAqrBz0sOOvpopZgVSLF7IgmGisxPT6uHV5QvIBhd?=
 =?us-ascii?Q?HkZqfKqkDPdaotbNwFhDUdERb1376+D9wbatpoLIPRToHmaYaJDLdA/b7Crl?=
 =?us-ascii?Q?EcFm79dgQjvF/Q1GwdDaNam2?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 10:17:07.1487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdb8d16-8987-4377-ffd1-08dc6a910566
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7066

Hi Luiz,

after upgrading my embedded system to the latest Bluez version,
I see that the following patch hasn't been applied yet:

https://patchwork.kernel.org/project/bluetooth/patch/20220923143331.18926-1-ceggers@arri.de/

regards,
Christian



