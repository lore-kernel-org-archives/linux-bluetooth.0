Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3849225FA0F;
	Mon, 14 Jul 2025 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512963; cv=fail; b=GO6v6wNJZrF66/BS5ScusnifpeKaTmFdctmK9/MND64PpfUxAP+2zGOz0Hj8ze9xabCTXx7H0zyUjMgWq1l3MZMfRcU+t+4tMDd2bUxqLwUVqQ3Djf7Fr9AfPFg3N/w8Sl3loyqXbwObEeqCCA2rTBhRvAkrHQQr/JVASd4Jjk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512963; c=relaxed/simple;
	bh=JVEUIjl6BzaFMZMT2UJrjuWhoyg480Kg0xhPaVqfrSo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mPocWM5/3JS61/puJLgcwjP7mg35Rhn5EsbHd9dBENiEVmZjlxwEashXSXzpY3rP1RmpikjoEg2sl8L1T6sBewM0s0go/EIh/dZln6D/kWD8/7/x7aeZPBs8SYnjIEng/s5TcYBEqYrpK26ZV/u7BKoQg7BH6F5quMqATmuJti8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=NXOkYl1L; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="NXOkYl1L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tG1dEmfX9xoCeOt/gsdteKiK9V/iqHeqw8Mp52pMecfOYrghOyNj9bmw7+N0JjhBsglY21QIpji3/y5Y/0TPiiNPWzHHGFvNB74mFyCXbsGu1ld6KKHJTGifWW50uVpMYfyGq84sgvSCrVLyMbVy0/E2sOsojB+rWob3Mj/9wwE+i+LkkZjivAgqzqjBJyB7BJnYblXPUMFEGQyXTa5P7NeUVYK9j4TIoCTsxhCt5ga4Fgpsdcnz0ALIB6DaASMg/lKjLdc6uRugacGWZOZG5dinohNDtkANWr9y3t16DFHV2+dP2Nw0WVUS9CUSVuKKp+uvhxr5TZurUQxwj7agZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwzAqJjI7GMz2oKsMUx+VMw5+vWskdT2Tl95UuN8fsc=;
 b=E7gCu6OpM2J59V/NfPpwBckfCI5eUr99U2lHDYknSUGkWtisUZ9iyftcM+CNwrmLbhfXRbaDWJlNKXFveuSyEI810kRBw17uuIjDpojdiuh0IlbQrhGaR0v9bMsz2O1nPZ3Pk6ukwEuWREr2zGLSraXbgPOxf0PeSxbx7KBdbBobiZIUHXkfDCKKccuIfhXXWPx3V+wCygDRc0t0fXQuf5zImqUNAgXrWsJIdt+N6xHMMPW1RjpB7I8lTUmkzwgBM3r67ITLExWCM0b6cAwzBbbiK8uAP51YxJNALCSEMhwn1JI1vqME4RgCUMBayedLZ+FY5yNTJExBpuYV64blSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwzAqJjI7GMz2oKsMUx+VMw5+vWskdT2Tl95UuN8fsc=;
 b=NXOkYl1Lk4sCvyZu9rrGeV8lUa1CH9tWqdtZG/uT1AZQW5dc4JQUerIbXPmtiTD1/550Ew2Gz8hyLPehN506L34dd3LgJpvIfYtTAEGir+qVNqgCDD7GbL78HvMu+05H71wBXJVJrpzHwtqrqsv666AqODJvF7wtBLP4ft0/waM=
Received: from AM6P195CA0082.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:86::23)
 by DU0PR03MB9398.eurprd03.prod.outlook.com (2603:10a6:10:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 14 Jul
 2025 17:09:11 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:209:86:cafe::e0) by AM6P195CA0082.outlook.office365.com
 (2603:10a6:209:86::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 17:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.1 via Frontend Transport; Mon, 14 Jul 2025 17:09:11 +0000
Received: from n9w6sw14.localnet (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Mon, 14 Jul
 2025 19:09:11 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
Subject: struct hci_dev::quirks is running out of bits on 32-bit platforms
Date: Mon, 14 Jul 2025 19:09:10 +0200
Message-ID: <22185131.4csPzL39Zc@n9w6sw14>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F99:EE_|DU0PR03MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: 52647c18-06a0-407a-db95-08ddc2f92707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pceIeMXFNC1GY7GXlhAmvIAQ049GHm5RVVqJxk6r28J8/JpBsHHz5faEB9g0?=
 =?us-ascii?Q?o/8eth+iRA01eEIDHBY4x5cvdF5ctDLdhJav+1VLnByMALd/uJwOTchKneP5?=
 =?us-ascii?Q?6e7QEQoSQ3skr818qjtT1k6QsI0BIop8ix9iUwdbeY1X+rE6uSkjL7uQ91oB?=
 =?us-ascii?Q?PwpomdGABJbdC3fQ+ZK8G1Z4J60Dj+VAQIX8QHd9RADaft4qD5gJ76XJR1D1?=
 =?us-ascii?Q?q0TPulQiOmzk8oswD1YYEvxIJSn72nHMvQVbygyuqvKEv1Yo9dI8VYnWbwwb?=
 =?us-ascii?Q?wJcBZxlpDQRl2etkTREJGc3mLpgGGhz3VWAt8xU7Sntg+zN8qnKGOk9ZvJ2D?=
 =?us-ascii?Q?U82Vmo6+u+MJBH/lHCHs0/i+tO3DE881MIyF2PorE6SHVq+HE21aoidkep5p?=
 =?us-ascii?Q?CGvzb+QAy6uOYjoSpa3CKv6dx1PxUK48gGchFV/B6n98EiHU9T0PrmjF4VOj?=
 =?us-ascii?Q?JD0EnERvtGyIj9an7yxXkNbJ/sUWIdlDUp7iLgF29orwQc1FXqpiDhozWnL8?=
 =?us-ascii?Q?cEekmg1Jt5ZczZplkviW6YJkSrP+YqYf5LuTkGMkja80Rh/ocH/3i/H+6SYY?=
 =?us-ascii?Q?4uA5fLvasJUW8EdAanNEx8/NRcBSSrr1jZEWfU3czIY20iDQQPkc1ff2I1mC?=
 =?us-ascii?Q?BeV0VAfeJcdeQBPgUzd0cYJJRLhYxy2wNEvTlGcXWJCAT8lxqoG7sMhcUfYZ?=
 =?us-ascii?Q?MvXNNE/LpsVLRZZx5XZ7wj12DD/FxLjdrolODTCVzDmKRI0zPR2q1YVe1nCD?=
 =?us-ascii?Q?tmyMRG1d+Pc+MKBchLNQBrXHm2o7ayoisMEBW2X0EPfpSUHF3dh4YDXTAefU?=
 =?us-ascii?Q?Ltd4qpyCBl8XjW8GmKtl7YgwbLntLdNIsx2o1P/+zz9PhKzbSgPKefKaTm+w?=
 =?us-ascii?Q?Pg7p2IA7MI2SMAHe97qKiXpaNQhOEtlgpIqKYupv9BD6F3UqyiuZmRBkjMK3?=
 =?us-ascii?Q?X3coUU+2Rlx9wRoGYJPYUOgEAGn1DbzzP53xfBXO+WXshnl5cXRAtlanyPIo?=
 =?us-ascii?Q?k0w4Puun0HHZdiw085mGR5ZooauhX3KBf27TB35x6g1GXWC96Nk99XiVctZE?=
 =?us-ascii?Q?d9UaiwQgZCPvvvE+HWXvdy58cnveP8m62eob86+Ufs5Be0ufE21N8bLfMNqf?=
 =?us-ascii?Q?sG1qbXA/Gj4h5CXUq90ZKgJsevxS29tFJusKi8dqhm/WvjRQqR7H/ZdT6cxp?=
 =?us-ascii?Q?oMTSIH53Ed16xOAPvMc3GipcYoiXfhLXoEhSeILoExqIm9gqy8jABhnwfHzR?=
 =?us-ascii?Q?7HzHxV3/gcqFZsHRwoCa+GW+IGFRo6RgK3B24TwcI8EXRwFRI4Bxo5NLvUQY?=
 =?us-ascii?Q?KQpa0Nd+vK9DF1KUPnM7k9PPQglKSWqZha2ovGospB/xarwnANWwXRqBqvHX?=
 =?us-ascii?Q?oWg7d+ANxSbpF/zcoJIK4CdPxPJRUEdB6gy+7/JQj8WJhuue1q2yb3Vceut+?=
 =?us-ascii?Q?tX9TSO/evnJnV3VZicgqXLlSzan/8Z8VGp7Xbn5Xs6TkLVNekVXnEmBPQKEL?=
 =?us-ascii?Q?Qq26JeBdNeUepNclvgoKBV803G2QPYLs3UzN?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 17:09:11.3581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52647c18-06a0-407a-db95-08ddc2f92707
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9398

I just tried to introduce another quirk for Realtek Bluetooth controllers 
when I recognized that the underlying data type (unsigned long) has already
run out available bits on system where sizeof(unsigned long) == 4.
The number of entries in the (anonymous) quirks enum has already reached 34 
in the latest kernels.

My first temptation was to simply change the data type to something like __u64,
but this is not as easy as it seems. The test_bit() macro used almost everywhere
for assigning quirks is guaranteed to be atomic and my platform (ARMv7) seems
not to have support for atomic operations on __u64.

I mainly see two options:

1. Introducing a 'quirks2' member (bad)

This obviously would work, but requires another enum and will (I think)
introduce stupid bugs if the wrong quirks member is exercised.

2. Switch to using __64 with non atomic operations

About 99% of write accesses to the quirks member happen from probe() or
setup() routines which should (I hope) not allow simultaneous access from other
contexts. I found 2 exceptions (as of linux-6.12):

a. btusb_setup_qca() is called from 'struct hci_dev::open()' (maybe uncritical).
b. Two quirks (strict_duplicate_filter, simultaneous_discovery) can be toggled 
   via debugfs.

So it looks like using non atomic operations can also introduce trouble if
not well reviewed. But as the 'strict_duplicate_filter' and 
'simultaneous_discovery' quirks are only used at very few locations, maybe
these should be moved to a new member for "atomic quirks", allowing to
convert the remaining ones to non atomic.


Are there any alternatives? Anything I missed?

regards,
Christian



