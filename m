Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2063.outbound.protection.outlook.com [40.107.247.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFEB86122
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Mar 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648131; cv=fail; b=Vvn1f7U2oL2yDPercvJCv57uxtKabblZda1YIayf+AxLccfviT+iBsxJkCdx0MKS+o9DlL4/zSiSfpUhizjyuxY9bHGp/RuKCb1HqGECl51YRisruk48YhSCiHKdZYd68WZYXl5B3SOIa27nDXFzr6iRAifuhBiH5ZTNprVuBPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648131; c=relaxed/simple;
	bh=n19i6W5s1NEtcvEj9a3T25I7AFAyNI+eaYdh/87yOa8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=g3cNqwD6fMAp1zOxhgXeBNdD2KZi4syUB8DECXE5ggx90wp0y4JClxr1obcVfPKa1quSNSd7UZOnfCuXSKVXDPvXX7LPnPdX5/YMgf2XHvP5btJL3RxIT2bNWckLSQBqZswXTpCbBxVWzN0Sy4X8cgdts6R+uMESgKznuLOOuig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EjP4rfHK; arc=fail smtp.client-ip=40.107.247.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EjP4rfHK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brjDsbr+sPz0SfSjfxLx76rOoUla+DYZwdrCpvAJxhR/5s1LT3bj8amT0bw0rv73uTP6axbAdRpTHdkGFTPzZMYMZ6QPu0snCbzYawcSa4AdlzoFHEvgXDmhDwTNaa7Oz6cbuOjVDYOm+eGiPS/jpTMXhiZQ+4Wb+Geu7LYQREAAhMAGmVar3kvulRPgqufgbvasPlMN7ywpnbEsUzz31fyF79JX+yVAX0THAO6Ig5pHmLaO0kl+9jDOZJaWxSmf+iVKRKzyptKchSlVFO3s6rtSXtvd687z2revuW8hF0dnrQiJgud7NBXPuRgviZ0Sl99kT9DGg7Nz+f+yhQM8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4wOefkJfZzupYVrp8sgsBIwtD4rB5FKWWPNtIwzKvY=;
 b=TBhNgO2pfK8izpQltQekLK8zz6GVXfmLWmgYQaQC0WljcbW6HaLblOeC6SxO5kJhQJR3YKvu5QVEfO0fXjPPbXFNcpyaBh/HlKxk1WmjlS9rWJRzwAFWejNHy1hRtHTmi7n6lkbIyP6YoQz7Om/1T+KA/xTCSKpPzwXpGQFNhdMZvnqGKKEROcc49oy/UVA4UqIzsq66koddpXcP2Kn+NmIbWg/GJfGfQCL22VPJhQVwAvA5ZuEUt9NojaqJuXUPK2nI16bYfCPFsQb43W3JMHc6g80tprcKEvyShG/5nemn9pL2naMIBoZbjwxZ7h9DsCFcOe/lNgKfBJrqzjJGhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4wOefkJfZzupYVrp8sgsBIwtD4rB5FKWWPNtIwzKvY=;
 b=EjP4rfHKSiTlKTdVWweMm8eA6pYQyd8lYOLt7dmBQJEFfGxC67WCehWxU26v5/35NFp9cbT61sKyYaNhp8QCYz7txBloxa5p4hlctyiGy+2+pHJLVN1O8xVEygWWvIpVaNOHw/LlHTy8swI2+DGu5+qWx6RjaRHIEpsnJ8Ww1yc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AM9PR04MB8620.eurprd04.prod.outlook.com (2603:10a6:20b:43b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 14:15:26 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 14:15:26 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 0/1] Fix crash in bluetoothctl exit
Date: Tue,  5 Mar 2024 16:15:20 +0200
Message-Id: <20240305141521.132865-1-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0039.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::12) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AM9PR04MB8620:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d7cbbe-b015-41ad-67ad-08dc3d1eb457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AWol6tgA6Aos10LONNDjrLJ/34CPdKmW5kNJjbxqUWLM8ZEBnAKuIh9rNGfbIiu0ecZwf0D42Z9olohMrskVkchzFbQtmhSRbqIDpBxN0URQHCuFMBTARsepX3L+NfalpjRh5hv1Nq6ampNgDKCHdevBjBp4ZR3OTdOWoFIJTx3vi117TXR0yuhaN48od3xm3O3HPG+412T6siVh+VS3Kyajv234erjcVi02mmZMcx5zxPo32xwhP6iFNqv+Do4arGSYr9TmdYVOD4depwNJcC2xxILvywmIhmtSikdPh6T/ubMjdUNItGlwqx/G5q4il6uLH3sZXN7jvXfbSSaZGfdpn4T8nJdVSw4avHQeQ6sesrIC0jN/rIlE3oDMPJzZigh30loevVUqzEm6SwPUTMiZDyzlYWLtn2tHiW6Q5psfwvnLxFt32+NShVm5+rhTPFatg6fHMV1DI4ZpQ5yCe/DxBYFDi9wvN1SfGuBojUhpRPcOslsjs9P7Poq5mt0+DOMMtakc2pvIFCNNnthuDC1OOrHrric+IJ/l2/h716gBM2yMGJrW6Un7gRTt9WwFhRUeDEbSGm5fDIaCJ6eViNcpvYnALc3ZE3jtQB/tQ4NhfUTjWOKLzM1IeFR/2CZjwQcvLNqWs5i8ZRm+tbMeIRM23Ka55enKeOIqwszZsOo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D7vXq3IAUfckOXceRR+dbM/fxx8Hq3ijFg46eN3lzWeel3PAp5w5V7hvsc/U?=
 =?us-ascii?Q?Ga4iEI7uu9wChAEehdHYSf+XBDkkWxqEzNvrdIhbHJ8cGyrRi4wgXHWobzBo?=
 =?us-ascii?Q?/IiDpj60bYjqUXri4RKbb9HdKbsTsETnZrLziqn1y6YnIDC/6P5+sk0RBNtr?=
 =?us-ascii?Q?3VIZC3J5fQsUsoyWHlPtRrvZpvQdl8xBnK/ZMRnde0AXqtumFb9T70hrmpqQ?=
 =?us-ascii?Q?Mc5GZmn9gH2Fc3C9ksK0gB2jxjBksfS22ITNlUlXF/HzkZ2qNniHXYsochtA?=
 =?us-ascii?Q?4UUPM3d3TojPpzsk2+mtmBSy4FFcsYQ2q8EFWgSKA1V6a9kn0wb4UQATcl/2?=
 =?us-ascii?Q?Cfq79s+RHzlTTyEy4evxzrbtBq/3wvYp2qShev+6Belv+8V3P1pt16bFoFNP?=
 =?us-ascii?Q?I7keAZUx6kwnCxH7G7DYHB2DxJeyPbj0SHZLJPHQc3td4MPfyzjFZL2Y20Ct?=
 =?us-ascii?Q?F5nXT52XDx/MDf/5BxW1+sfjJa3MIHl6MVlbTuCv1xAS4InNSuGXsWA4crov?=
 =?us-ascii?Q?mwiKlQtBgkTdUTYDMdez3b43KBaSRJTKKCLmFzR0fO7AREcxxwMBOwWdxjC/?=
 =?us-ascii?Q?0iYz6nIvqQkwVw1FUsvLBZWDKXblblPOZsMRPLPvrBBF84HBAlfAfjd5Ege9?=
 =?us-ascii?Q?P0CXqgSX5yncnL9zyhrX/P4vTuPGsM+e+nTMeIEd4kMDdp8bFcDmotwTAfPS?=
 =?us-ascii?Q?h/KeVVK1A7hWAUrlzDkAMdKto7sjVTOiB4099fj/JXKOw5kR//4RiocFOUBs?=
 =?us-ascii?Q?0r1qtNowWccn1OBHmjJH8NU1OLwqGPzeVdhyswqXHqXgeiY91KvjJZM/s2+e?=
 =?us-ascii?Q?YbDpMqmvajic6fZLdhsPlRGCp3DwAcAZ2CoiOw1+nX2T02jTJIMeHBedKk2M?=
 =?us-ascii?Q?Ng1gzqjalBlsN6RiJTZXhTuLmrHtoH4xMJMfS6NoLPWWgAVQatzbpAYHUc3R?=
 =?us-ascii?Q?D4tSr0RKw2POq6vYjtIdLdHA0O8RpatJV6nmCBwQ6yJ6+LXsVt7Lpwta9I3I?=
 =?us-ascii?Q?GCUlt0R594Gktt+cKH+0eaDh7fJHfmD6RC+MyzYu+48/EISo9THh/b6gy2X3?=
 =?us-ascii?Q?kBNDboUUKPg/QWPnXLRbD2WJEfb8m1AcgcVKWBERsZ03plv0Je8iU+LDT7Tl?=
 =?us-ascii?Q?fCWIvH2PIcn1rwFVKMXXIgQhk2M2zsjDsbig28nkmNjKBS8JtWmVkpjEySPz?=
 =?us-ascii?Q?VoIAIOju/dQRZ1T2ZWBORGMXQ8Njy2FyMtzw80UsmNtXm5Rg7LtfsBf3vhXH?=
 =?us-ascii?Q?OIjV6hhx/ChmGenF4691gf3IJZr0N7V0oQp9MQSDrYfz5d+4Z4hiL5UsGbn+?=
 =?us-ascii?Q?EVEoMNagGqCYGJSXERtjPw/bSCMGwHzoE4mY1czaCwy+xRnvV8AxvD5bV+Qs?=
 =?us-ascii?Q?/h2MXp3sTq348nBDR9IVpEHTQRoitSUalJkd2HKQlBgLN5qHvauAc99hIdvY?=
 =?us-ascii?Q?bPY0tf2ULJIsvOg6/LWccn9fjl9B3TNWhJpL5FeLsKoyJIOXgxBgVmUBR3/G?=
 =?us-ascii?Q?7CCOL3wgawOg6EVG1MQiReTKsmJBP/8h54Hle8C+sF70K70TTs5b85bUUDYE?=
 =?us-ascii?Q?s0wZFooB+S1bpfs5fi7O8dmmKR1juNPmCUK3iIObFEHUOSuGHBFOz7e71tS8?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d7cbbe-b015-41ad-67ad-08dc3d1eb457
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:15:26.5040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USsC0bePlsrzKfdB0/pVO0SYwV4Ju04yUDx+p6KMfJOHd9SLZl2938Ftd7DeoN6LkHA/fxXzCHAArN443hJc2MpJtTigjyMcWYKBT6kdPMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8620

This patch sets the data.inputs and ata.queue to NULL after being freed.
This is needed so that further use of these queues won't access already 
freed memory.

Andrei Istodorescu (1):
  shared/shell: Fix heap use after free on exit

 src/shared/shell.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.40.1

