Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB89E2FDC5C;
	Fri, 28 Nov 2025 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321333; cv=fail; b=gOgtScGqLISn4TQ7DXkeJYXmvdZYFomu2Xhfw+FRkl2FSQyx/8Ven8JMHm4GGlLbj4m/cKxhvdBJhCwZOW0AkAqU5JYNObDG/pIhhP4ra2CNFuqhZZ16Wx6zNRmr7FtGXVSB2BG9g5bK6Ljlhepu/x8GD5uslRclmhbLrzO9Jes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321333; c=relaxed/simple;
	bh=v/+IANBCitrH0JPPZW8ZJyA+ti5aycwt0Po200aux2c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sPcS5LAYHj3BYanpShZqVhhb59sMlDu2LWBOuAK9cH8m4+L6qWOtoVvWmIHHlHofl3HMdxPzb6ZbhtkG2eCarSNb+fHX1lSM9eDmPO0nnBKc5yRfVbjJEjueJibk8ZTmIcPP2Z8+pk0ixDOugRbpbSkc4GM2BzRu0H/Of3DD6Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B84SWLuV; arc=fail smtp.client-ip=52.101.65.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B84SWLuV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHSq9VyyP49RUfvwPsVv3Ln/7aq/WLlZf/V7kD1xqX+w3az9EvyrguQuEv+Gpb0oCpf3i95P8lAbupRKsiKyLaMDw1B536B8GprwwXDbrNRctRuRIpsAs2sYGFzpP8tv/xEEu0s3eczKrN3mEZh28VUhjEJ9IJ1B17FpD9cnETuKCuKR0bs/eTWUDseBE4ID9VyuJXJ3RYlHBfKRR1TEStKXM5ngHxMER0bfVXakYNK3gjsRPIZrLP7a4XQ3Zi5mn9//iCd5nIUSgKk1+jXANa2IC6lGR5NMKpxxJ4YJT/IxWPJAFzQKBFb13ipRlUkYBSE64xmB6wHx8zSPAwXs+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx+314doJI2eQrzvv4TMxXzH0PBnI/4dj0K+ZciJRWw=;
 b=gRUBQoseP6FZxWUBiFO9UmGIGdeD4+PZdXUsT8s8JAjhaQiQIlIQe3rVC24twl/pQ++21jGVeWo9/ZVMUxKFyD1wM11WdGYkAs6swY0gJTQV6CPqOiYpy94CuwL1APM/5kWh9FGIFHKv6n4UVd2mjdkjUr7Syt7ZRDEETh8gyznuY6lQsE13Xxvhwl2UuprQCEZ4qcASXI1DWU2SP1+SiQYBo+9IMm4JfJuIWhvsdpi0/yIWqnWyqwmS0F3e69V/s5vIpIU4+Zg7FB/gnUk1G3I0QjCBkaGrhR5RtpoA8KnqADsRukSJro5DZrAS+8S7vaSLesxG+DmIi8IQTY5Z3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx+314doJI2eQrzvv4TMxXzH0PBnI/4dj0K+ZciJRWw=;
 b=B84SWLuVDZUST3caZ7WczsteyB6zcKOle2PlF+263S0JD/2h5CgZg71cvL8Sagrx01V59eZdEWX9ZrHavbCQLprgxWBDy85S+39FCZDYYHRgOnNO8kXJzSO2cQ9awhd67UCEblG/QzwupplR5NDHKYXTutqojCWBKwNw7jUgpLZT/VTAri1zx2rcVBvKVQzeIko9R9CX2NPpoPupy/h26MWU22zJN9F2h/50JfLCPsvVqxUxqwtvNfHJH0w6yCMBHVDI58JHXWrOp6Cbf0QCVFaw0NCUaK8MD3X6U9r0WaWjVli4N41W3iMN0JhskoDWRSO+9/JBDi6gLx+a4VY2XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13)
 by AS5PR04MB9998.eurprd04.prod.outlook.com (2603:10a6:20b:67e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 09:15:27 +0000
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d]) by DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 09:15:26 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v2 00/11] Bluetooth: btnxpuart: Add secure interface support for NXP chipsets
Date: Fri, 28 Nov 2025 14:44:32 +0530
Message-ID: <20251128091443.2797316-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To DB9PR04MB9676.eurprd04.prod.outlook.com
 (2603:10a6:10:308::13)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9676:EE_|AS5PR04MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0575d3-aa4e-4562-5389-08de2e5eaad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HsVrSzBFVYgJkzLQvg0H8oNyQsheGo8URXrskvB3tvxVPT5kiEtwuNBI+bCF?=
 =?us-ascii?Q?aMJ4DY2VrT5NwEkRPWEywbycZsbqcuJWVfUcmp4zJk+VFptQgrd7NYu9dvzz?=
 =?us-ascii?Q?8tovL0ozK7I0WICylvAF3eWFP2W/EczovtJZJpWa/uhhP4nQ9fjGcQJxFmhO?=
 =?us-ascii?Q?7ZuPyeaHV+8+2G4k7/rVxquzqiW/ppL1ipscJ/Ez7lw/3tH+l1FHP3YFmF0k?=
 =?us-ascii?Q?ajWG0cdczkVKRvgrsHvH3yRCKMACDUHEJWbK/m3YSz/v9OnAmPEX6ivZkSc/?=
 =?us-ascii?Q?/DambO5XwtAyLivABNnXbzLte5ERxYFW0Z5m5xl1kmLqGGchOG675EeORKQU?=
 =?us-ascii?Q?7MOdK7YU5nFPDceoh1070XnjWnyR21wDrpsEPMS/yEgditKxSS/l8TOG68AJ?=
 =?us-ascii?Q?QLntcZCfL9gkOBDh4pzKVOI4JeNuwT/1EJ7dPby/fKo8/hcIi3XhCwFtv4ge?=
 =?us-ascii?Q?dxYfcWSlp2+tmXhbDY9FEUa1GpFdCBxynU1KykhBfb2O/IxCh/5webMkXepx?=
 =?us-ascii?Q?sO6C8dr7DeUflHzHnMMYvYGaKehNCVjDK2eaaQJGsTr4W/CS0nFbS5eZzUI1?=
 =?us-ascii?Q?XEQBjSj1OyMOtY7s15EG1qlZQ4RrQ3FmSLOwQ0aYhE0GzZPwFph5RfhtfrWT?=
 =?us-ascii?Q?MO5eMm4Lm4uBnMxitUaqgJZYoKz80dP6YKGyHmdpGgYmiQD/iFqS6Akg+E6i?=
 =?us-ascii?Q?SkxLKBmOga9jYWJLB+Z17pM9x9IMItHjkZbF1rujmIQXwO/vycaYINUcjkuq?=
 =?us-ascii?Q?sOwZJSgEw/nwTUblFWAG4fhX1mjBIyKE7o1/u/aigIb7Te7w+aZwI8Zv52MG?=
 =?us-ascii?Q?H2QAoaHETtprY2FR3zqxERH9oWClNpOkmlhZ+sVrIqO0I6AyxDSfL2gUElE7?=
 =?us-ascii?Q?saqjLEGY/ebu0dVhwg5jqD5diCtdbOCqkQzy/HQZyw6KkTHb85WV9niMXNrx?=
 =?us-ascii?Q?fhBoG4BpOqBRUY/654nf6QVO4YXmS6CRhldaL+ljdtEbFPNyFboaRVJ3rvUl?=
 =?us-ascii?Q?vAf52u4599zP5X7C/10byXSpz+wraH4e66Wan/MTgCPQ/3NRfwosTBFknw2R?=
 =?us-ascii?Q?Ut4o40s1vjygbrBXEw/QOzEIVOR0agK8h0Hao9PeU08Su7TiG8zkmjN1OgVW?=
 =?us-ascii?Q?4Xz6V3krxLYBfXT36lZjHiO8L1jJusKQt2qro9sR6p/5+3hOT1L15K6akb+F?=
 =?us-ascii?Q?BOf5FpQ9vG5eFHbnvEMVjNMFkdHqudGBWPiycCVsLU0XaI7/UFogC+eo4gbV?=
 =?us-ascii?Q?nIoXGczwWX8hT2hbIvJDB+8Ve6P/k6TDBT10dzs7N+PmuwR9bmGxRfYqcywi?=
 =?us-ascii?Q?bQTzBcKu2JIeAYEYTpGXgLObbVhRX+Sivij7vI56pZRxF87NV7A5sIXG8Hox?=
 =?us-ascii?Q?WESAmjP8Oc3zhF+S51D7GaOyijI0xhjEKmBbhUpPET5wDOyY3nqaX6PykT5K?=
 =?us-ascii?Q?CMFNX87SGPfmOF+MjS8Dal6LrUT3Q8yatbELKQIUmDCScJ4RaOztWoN6Duc1?=
 =?us-ascii?Q?OVJzf99e/nooXyPll+htP+T480iZJSXQ6pIx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jP5W9xwhQREZ5T3PXHDS0Cou9ENeH4pgvthvZ9CHIZMMFDigUTMT1zYbqmcV?=
 =?us-ascii?Q?sAMRpgJYLyspq9n0CvtHSrwB2gJIsyNZnzKKAxskHy2Y4stob8yXScud2aA3?=
 =?us-ascii?Q?b70BqIxHmiCxnuD/VK9GB9lBPr7YBdyCOgGLuvhseFiJNxJZx+LF2gGGwEN7?=
 =?us-ascii?Q?85qs9sJmWOlfmpZu7wgYzYte1OivKbJaga8Fwt2EoalT2nJR6dfFVZgdCF6w?=
 =?us-ascii?Q?Chg2m1NPbi4yEbub3W6AveglFpJsvoieWNjNjZLqb3rT2ZGDgkTmuZ/qIZx5?=
 =?us-ascii?Q?+x+lvA1b16NgdP/N+KOrn0RzurZ7DV+Ki+Y2lUeS0MvxnYZUZrN5xvX6/tMP?=
 =?us-ascii?Q?5/ORmc8R5aOycPOciaSsgu11W4RX9r7/V18OJBRC6zuAVvTjwJofB9l8rUhW?=
 =?us-ascii?Q?WPTh/Ywj93TsHeGUlDaeDdoJJA1hwUB9du75vH6nAJNe+TajjaizqO+Ipffa?=
 =?us-ascii?Q?hp7hQj98PPHXwYMoNW5lTyUjKEozoLKfpcdphGQJ7SKBQeDHzQ85EKd4ALA5?=
 =?us-ascii?Q?XCf1jQrLCIxv4Wyz2Evil/w7yk+vD6z7CrDGxEAuAMm8qqzZYwz1FvYxDjQ0?=
 =?us-ascii?Q?bQo1mxhrYaiY0ZLJ6ouCrDBCLgI+l353LCfDC/Nh9lAluF5ZjwcShs8hi6oq?=
 =?us-ascii?Q?nNjf59gJM/u0FbLgXm5uSXRcF2NPEC34myoffng0wCI0JmoSPOO9Ji4HcH1w?=
 =?us-ascii?Q?EcmrxdIPadfwFpjf/nWH4I8YB6dHTN1JIt13D+RqZMygCLF2ppSNySDvDQMV?=
 =?us-ascii?Q?ywc93h0vNZ74M4bunF7Z8irVSKJIMA/Eg6+5EzzsfQRtmyBGodI4azY319ub?=
 =?us-ascii?Q?E87YzpU8DdXl8Uxnpf41sUMzxDYZ6fnyp+wZcKGY9fjJq2Pposdjbbmstl3P?=
 =?us-ascii?Q?bS1QHyveL3T6p3KzX5Z+LVkC/iaho2MJF3xrQ3yMpFP2tDefPjP2Xc8Q2Q3I?=
 =?us-ascii?Q?FNc57rlLfKLxeG7HTJMkNcng0euSvSZYrqucmk9jtFu4AxNxJu2AHYolZRhl?=
 =?us-ascii?Q?3Q3wSRihNTrm+ieeC5I82GfvVP8MYn6zgdv7O6iSDpw172Au9btMWh+VwAat?=
 =?us-ascii?Q?Ad2ckbSooC/NXd+ttNBzgHiS6BV1122nKJdymV+C+hXHWy4aDqNsSjHnXXou?=
 =?us-ascii?Q?X+MEHbWvUD4hMpoCgT3SpkGfPtWXQSUc41tNkNqDDZqHJf4if7Z93G+FmTZr?=
 =?us-ascii?Q?lsSBFs4O1Qo1AKxPbZ8OJ3uUypxFeAiR5b3y8AZm7j3MXG0SLC+dKUSr1qek?=
 =?us-ascii?Q?0+6BW3KEMOTcgaV9DazDNNsB+Iw15Zv7vmG9ZybwC/L6+zkB6+hWbZLEu4+N?=
 =?us-ascii?Q?BeZ+PcPFIL0Snkr2JrU4+ed3XIPzeuE2MxJ0iIm9aFyKPsQnQ98Ij7NmuJQE?=
 =?us-ascii?Q?X7lvN07Pp1+cC739jldSqnn8ML7pr2p4070KyvXL31wArYNvOLM4jm5DgiuM?=
 =?us-ascii?Q?dReh03fagSCaneR25yky0aUsf5oxpgkcaR+NZr7Y6Dmf/Tnyo78nhhOui0mR?=
 =?us-ascii?Q?cqacagi6TdeEoJbgWSHK1nAzhDZbodZEG5eri5/ofMFVZI4SP8LgnhvPlq1C?=
 =?us-ascii?Q?WNwPd49mJynUMcCxVQcS9WcpU5V1cAzgZu9Zs15vYRUvUgGp9vHPikkk5PKN?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0575d3-aa4e-4562-5389-08de2e5eaad7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 09:15:26.5334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhY/pO7yGc3GL6FlRnC8Hii/DJ5QMeyZ5NGrHAW6NpjbabNFb7f8YASsYI5WlJ5sREyT1hCV7eBTYhgo09vF2GI6mgqcRKXpG68Khu+TZ/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9998

This patch series adds secure interface support for NXP Bluetooth chipsets 
to protect against UART-based attacks on Bluetooth security keys.

Problem Statement:
==================
Bluetooth UART drivers are vulnerable to physical attacks where adversaries
can monitor UART TX/RX lines to extract sensitive cryptographic material.
As demonstrated in research [1], attackers can capture H4 packets 
containing Link Keys, LTKs, and other pairing data transmitted in plaintext
over UART.

Once an attacker obtains these keys from UART traffic, they can:
- Decrypt all Bluetooth communication for paired devices
- Impersonate trusted devices
- Perform man-in-the-middle attacks

This vulnerability affects any Bluetooth implementation using UART
transport, making physical access to UART lines equivalent to compromising
all paired device security.

Solution:
=========
Implement a TLS 1.3-inspired secure interface that:
- Authenticates the chipset using ECDSA signature verification
- Establishes shared encryption keys via ECDH key exchange
- Encrypts sensitive HCI commands (Link Key Reply, LTK Reply, etc.) using
  AES-GCM
- Decrypts encrypted vendor events from the chipset

This ensures that even with full UART access, attackers cannot extract
usable cryptographic keys from the communication channel.

Implementation Overview:
========================
The solution is implemented in 11 incremental patches:

1-2:   Add firmware metadata parsing and version detection
3-4:   Establish secure interface framework and crypto setup
5-7:   Implement TLS handshake (Host Hello, Device Hello, authentication)
8:     Derive application traffic keys for encryption/decryption
9-10:  Add command encryption and event decryption support
11:    Add required crypto algorithm dependencies

The implementation automatically detects secure interface capability via
firmware version strings and enables encryption only when needed. Legacy
chipsets continue to work without modification.

Security Properties:
===================
- Chipset authentication prevents rogue device substitution
- Forward secrecy through ephemeral ECDH key exchange
- Authenticated encryption (AES-GCM) prevents tampering
- Per-session keys limit exposure from key compromise

Testing:
========
Tested on AW693 chipsets with secure firmware. Verified that:
- Authentication handshake completes successfully
- Sensitive commands are encrypted before transmission
- Encrypted events are properly decrypted
- UART monitoring shows only encrypted payloads for sensitive operations
- Legacy chipsets remain unaffected

[1] "BLAP: Bluetooth Low Energy Attacks on Pairing" - DSN 2022
    https://netsec.ethz.ch/publications/papers/dsn22_blap.pdf




Neeraj Sanjay Kale (11):
  Bluetooth: btnxpuart: Add firmware metadata parsing for secure
    interface
  Bluetooth: btnxpuart: Print FW version and enable chip specific
    features
  Bluetooth: btnxpuart: Add secure interface TLS authentication support
  Bluetooth: btnxpuart: Implement TLS authentication crypto framework
  Bluetooth: btnxpuart: Add TLS host hello handshake implementation
  Bluetooth: btnxpuart: Add TLS device hello processing
  Bluetooth: btnxpuart: Add device authentication
  Bluetooth: btnxpuart: Derive traffic keys from TLS 1.3 handshake
  Bluetooth: btnxpuart: Add command encryption for sensitive HCI
    commands
  Bluetooth: btnxpuart: Add encrypted event handling
  Bluetooth: btnxpuart: Select crypto algorithms for secure interface

 drivers/bluetooth/Kconfig     |    7 +
 drivers/bluetooth/btnxpuart.c | 1442 ++++++++++++++++++++++++++++++++-
 2 files changed, 1440 insertions(+), 9 deletions(-)

-- 
2.43.0

