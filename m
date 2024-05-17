Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D01EA6E
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715949315; cv=fail; b=imzbu9jy7faDJEr7CHyzzn9kWFsLB3hkr50wMy2SNXYQv/pHw38NsuGWUqjRLEIsZPLYZ+khBY0BmdNtt081Pg0pShYdjNZqRzelhBBOWs+1SJ1aADFNbURcIJk8UtrJk/QDycoUmm5IBrUf2iUbzSxPhC3kzxtilKdsR+vEjPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715949315; c=relaxed/simple;
	bh=i/fhYJ3a/0davdTrGvYOMSl9ezxrp9UNcG+0jOPI1Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eyXpeTUMsElN+dNU6hzMXGXRzRP/8bB+H2m6fiJ1QKRr0rvCutM3lrKMUTcaVc1LqyQHU9VlE0eI/cUmgeIK1KulMdoG4Uj+np+P2VFjtMk/uLoVcmOYDqht2lJ6j8yATOt4+3YvK2EBdvoNZMZ25S4K1omgo6SElUJiyoGKLrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gThswm2U; arc=fail smtp.client-ip=40.107.22.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gThswm2U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCid8r/aO4WgRWcZ+WQ9ID8YahgkpuVXr6iikxZp463s0jUNJsvURekcJJRizE5HT9Z0BQHgQVwjOOYKgQAUAa/j8UnYQz23fAOw+OFAKYa2FlV0Mphi8q8E28VWr6+IrSmztTtlnxA9kbKCDFl/s6U8RxjZZeEJ/jRjTE/Q83UzU9L05TvF5SvuiPZTVTY2Dop2QlyfEucRZUXvWGqBj8hRmPn7rdktpzKIJQDGIh9g5OWhdnbXwD0NO/jch638/0ZkCM1ZyhY3IBfLTnfiGzKz0JZxK8Q+Pst1JhZ30R6Jc6iB1E1zZW9lG6GApimq94WuPBO7nR8zcs+j9fP8sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MknOE2q3OXiwOiQKUQPG3NZ8PLhlRRrOdcFN9Kx+W8o=;
 b=gR0XIv7lOSpcIOiUoHRBuEDnndZwY7BWQwiO1ChwQXqZyn7tjuFrvSOqWIUiOI1J5o/L+77NPRNRXBGsptPZTOWjXhBiw93hFr9tgx7TDlfoIxCyHxqX9WhizujKP3QlB3bfiJNyBNZZXgCIyy9oGKwp8qloZGTZq1StQlkSLA+n2eE+bqkkdJkQ3qj1UKB1R7YCsBW8PZYEO0qFHldD4XH391taKhVqVPL19uG5Zt4gSd38A5b8s04IvE8WhnspeEgRJtwbJh7/ysNmKjHo2L3ZmhE7ar474/FcQc8KLk51p+aFFcCxT7cIqpkwXBg4Jdm11Gw+Hu62bQgtuvv/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MknOE2q3OXiwOiQKUQPG3NZ8PLhlRRrOdcFN9Kx+W8o=;
 b=gThswm2U0SHQfo6l299vO+fXkgwQ/FSkHe+zQA2Fr03YrLbmm6RCV+0zSc/FqQ5N8fKBi6zxzjjKDFm/KAZb4hO572mKOBHpCPNNzb48giRzLIf3P8/KqI2Wh+3DQAa1SgJXlVfO1qa9rqnJFlnocoQSCUqQVmdMVQ+qV9k8ncM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB8362.eurprd04.prod.outlook.com (2603:10a6:10:241::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 12:35:10 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 12:35:10 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/5] test-bap: Add Broadcast Sink SCC tests
Date: Fri, 17 May 2024 15:34:31 +0300
Message-Id: <20240517123436.146332-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0049.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: 065f6091-04a4-4011-c1c2-08dc766dca7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UuXsNz3sknPPL05g6KV3T2IDt0Ot4b1ai3QXpqZlEgpm1HRBvFQRH30HeRJV?=
 =?us-ascii?Q?1bj6xtp1CjL1dcFAub42psYFrpTvpv9Xir1K45dP+ffkNWY21V+nCFy8U50O?=
 =?us-ascii?Q?4m1mVEt6xyccW9Cz7ZN35+iLDOQIhLKGLHVFolAr5dKdxkdD0gVubnth0RZk?=
 =?us-ascii?Q?44n2P/9Dgf+S9fU9+jplHOFgAz8w5XVOh2ounB+atFJgMmck/lEVg+c6famQ?=
 =?us-ascii?Q?RzXLlEROVe1GzZEGeV0kGUkwmpUkd84p1WJGcaiFnOeCEswkkxr57Gv/+9xk?=
 =?us-ascii?Q?q6NbF9SHIcR4SgDj4D8gdUTd3GTwIPCkBu/liRfsY6umb/aK6aNfy3MgR9u+?=
 =?us-ascii?Q?ENSSvA747DPBuJciSwHS9XM46NGVRzocPWd1resD7+A699OwkM2B0EfQryHN?=
 =?us-ascii?Q?6ycn+z8Utyo7kTJyMsU5kandbjOTP7WgqxB3uTfkSxsKF3ReS9Ru0HWJzMV5?=
 =?us-ascii?Q?ApOiiTWVImwWCquh7EYWsunuaTL10vRU/UtgmncJRoRHQt4iFB/7y6iMfVHa?=
 =?us-ascii?Q?4V6G6bY/Y+8mfjfDxT1GYNTRMD7khwcAnDDC/7iFPWxWGms8Uoh2gVEkYv8a?=
 =?us-ascii?Q?a1k+lNe6LDx4Vg0fk2ruD2OCqS4kL+1woy7Afx+kg2SPyaFS72mnYZZUXk/h?=
 =?us-ascii?Q?Nk+ahroNjUEpa0jeP+eXtpbTOzDBrCyRqapTIuPdkEXJFSUMIcxvzNBD8IYj?=
 =?us-ascii?Q?nlxgucOXyLDmChMIpbd4yvIfkPzEkIt86z6sw8zt7P1sbx1komXLa6KjPdsK?=
 =?us-ascii?Q?Ap21cj1ZrWLEnt0mUBavx2xnkCIALWr8FQcMfRJfGuy4Rl7lMRrCAK8an74g?=
 =?us-ascii?Q?VF9oMe3g+jXQKQ3OrlQ4h+BpBzR154AABybcNQvNphMjrBz5Y0aUm7gUW3Pj?=
 =?us-ascii?Q?SctYmjYQLwaYx+i72v15YCqXkzogInx1BrCX9C7fD/AnpbTkGIVN3qDX1d+X?=
 =?us-ascii?Q?VainhdhKjNMFW6Jp7WhY5/7obhshbjNyXQ3yKOLqiLf6fbXREAhqVY3LrvpS?=
 =?us-ascii?Q?XoYyPQHpzrYUhUkLOWOZi0yWmX4DXNoQzXZmbiuj88gJGzVRH7WFQyH6EFtt?=
 =?us-ascii?Q?z9ZT3M4Arny0Xxx95ABfumvGCjNZeHuictzIpwESLoQXEBPWdJOP38fi1PiC?=
 =?us-ascii?Q?+aI1p/smhTeUKwS6PS8UcHbe4AHL4kI6q7bhD/Zt+2E0h8af+QXTXhtJur3H?=
 =?us-ascii?Q?xCczLZLFfZ3nH5hOFRiWqltbnA5HNe932bs+rTOD2kZIrbHTy9YUCq3okf7e?=
 =?us-ascii?Q?sKd4pTzE9gVPyuiDf/XQjFk7xhE/rYmR+6t27jOlCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eRfy8qMHRtbcSvyiMHTkbGswzo7qNvN1Hoo7DtQvPcSu1FjXPFNjkMRnwxTp?=
 =?us-ascii?Q?xSD2LX1nHrUMyBeokub6zCTPUBwjIWeQvn9nJDteyj1dk6/ia8qt3vYcLdGo?=
 =?us-ascii?Q?M3DcM1Lk4MG4JIU9JhSEhOBAP2P86V4xYzJnMqnFcxV+peeRT55Et1hZUSqz?=
 =?us-ascii?Q?dmd/zpIfpe5z2FqCWY49N3jNh3PMgbSbSwTYLEbiBlEZnL79+MdPbUZPtcsA?=
 =?us-ascii?Q?T0MVmI8958zSzY+CWZDcD+Q2ndV+K467eyJdABNavDqv0Vo1s+89yxtF0lbQ?=
 =?us-ascii?Q?w3wtyqUdQACI2GKLWqA7ojzdKQY4fCmaX+2F4yPWnOeRMCRadpGR3NJP++sr?=
 =?us-ascii?Q?+gjzjH3aBE1FqAEwa/i4yC5RWw2KASG9teqmRGxkAyCsWArZRk3VK2qKrcn6?=
 =?us-ascii?Q?fcyRKGzuUQWdRkIppW4SG/c7wmOL0Lu2A5eLBmUw0luJTKXdB8BDFhstwicv?=
 =?us-ascii?Q?70R3TESqZ6ynG5alBxKnU3SqQqFNx3IQdNle6V/vgWbaAnzsgL82KAvecdTN?=
 =?us-ascii?Q?QRAINeoOsS2UezL2aIpg6vawQRt8BtOBCzeuWfrTwY/izP0u2TSaF125k2nE?=
 =?us-ascii?Q?V+nh8wkzcTQCL/+/LfX9ZLOoQHXRaNz4y2qZaHfa8e2d7JvcBPyQ4F2iujPV?=
 =?us-ascii?Q?Nw7+IzqIewrsKrxd4mO6BfpJ4D45ysUH2/hAUNm8wKv3j/IOLnK3DHMZONCU?=
 =?us-ascii?Q?cPgqXMlIu4JwDBNE//yRokIc1+sbefBPWPYJGX04pjB3TuTk90rTpVhrrrOc?=
 =?us-ascii?Q?42N+So1y8sF4nEGQRX2CEvwK+kjQzTYHMN9wBnOGATt2bmlkFBq/ouyNuAVn?=
 =?us-ascii?Q?ONnbahCw6+/egMA08g6V+32DJRnecMTHPXE/rf8j/9Cd3WCSf+IQxMpDYekb?=
 =?us-ascii?Q?Wf5H27E7ypRC7kyvb7ygpcNdnuyy9aBzAgr9aH9pMjPwy5KBdnUuvQ2ss57A?=
 =?us-ascii?Q?hn9MHu7RbVjjRlKV9qkudHNG1jH18ZUB0lJVd1LMQ3RDoKNpDqil1Ip/QqFC?=
 =?us-ascii?Q?4Sh6YRMn+vjfqIOhdjZ6ZJ7QvLu7bcyCDQmcJfTHiiMuLx/J27kbl1V2PQ1j?=
 =?us-ascii?Q?XkqDY5YlWXgrtvXI48mgtgwU48pH7QjHzPlNMNJEDQ5IFe9f0MX9AuiEiais?=
 =?us-ascii?Q?YKir1hKP2olWms0XOzOg0n8383cxXXYHJHyxCSHebB6VNb1ViiRS2GU0wV+a?=
 =?us-ascii?Q?CNFUhDqhhFpceouOmjGN7yxPQ69jL9SHxOr5uoNTV27ghFjPb0P4AaTdX5K1?=
 =?us-ascii?Q?/Ia4xxQ6BrmtS+MMyOcFkzkObQd99YhN3Tz/cPcgDeOWuaf1+obn4AKseEUc?=
 =?us-ascii?Q?nDFcLFFuHCA6wWiSIN5qS0i6OPqUyyXrrVUd1BHx5fSaZafr3A1kXJe9hal5?=
 =?us-ascii?Q?m/7NVGgJZ1QhGydevski8oLp05goxqYHVyIxLPtEIoeapiZa+srwI/Zlo0FG?=
 =?us-ascii?Q?xrFkkMbmAWfh6htdUTaHL8tPD1lmEaSbi6ZiRt2KmwA1FO1+koqAinL6bz/W?=
 =?us-ascii?Q?Zxtu+AIwLDJiT02+EQWvKbykIiSVyFeah6VmrdAd4my0LYYCpG3MHTHWl1/4?=
 =?us-ascii?Q?5Zm87R3qfG8MtNbKMM/K3tACEDjstfObhpbcb+/vyJN4Jzg5WzordLLx263Z?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 065f6091-04a4-4011-c1c2-08dc766dca7c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 12:35:10.1428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niDVU37n6tBkwoujAraAnJaqcgboYSM8KYJ/FckjicejBWjGHYnSc+4/HHXs4B9VB0BceX2oK/QwwSpw0WkN3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8362

This patch adds BAP unit tests for Broadcast Sink Stream Configuration
(4.13.2 Broadcast Sink Synchronizes to PA - page 177).

Some shared/bap and test-bap fixes have been added for successful test
implementation.

Iulia Tanasescu (5):
  shared/bap: Handle NULL caps at bis verify
  shared/bap: Add detach stream op
  test-bap: Update caps to accommodate 8_1 config
  test-bap: Make test_bsrc generic
  test-bap: Add Broadcast Sink SCC tests

 src/shared/bap.c |  70 ++++++-
 unit/test-bap.c  | 485 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 493 insertions(+), 62 deletions(-)


base-commit: f6241a10e460ab14fa3e2b943460673df0ded603
-- 
2.39.2

