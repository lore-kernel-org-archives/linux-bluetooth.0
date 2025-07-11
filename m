Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA3741760
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256743; cv=fail; b=rb44Go+IVhit6UeqJ/bCn9Wq3zUTzVtY/F/7LTvRAPyJdpUXrxJsPcLse4oGrV0R5wSmwok63YA/kqaxVKXxIOE1hpMBBByqkOueSRA1MwAG2D2IrMGu2xcs0wCMwOhD5H6yYMCKizBzi7tNJ4m35SJTSpdsFCcpmmtTj+25Y64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256743; c=relaxed/simple;
	bh=YUGrmMH0Bn53UEqWj5aF+1GhZClaKwQshVIa7T/v2tE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQaVxIq0pR6zCbj9lC0bbOcsnb6Wb27siM9Y1ph78XtmyhoY42Rp7YrWpRZ+EAiLVK5JvUpSs+eZduzMHdbGkL4vhytOhBsTHyOif/G9R9jQzBTBsJVwaXSyeVhiFKmXG8wMGXvv2mbL/r7cli7Vww6w3+3QjIAraH5g9LsCD6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=vIdhKo3M; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="vIdhKo3M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3tMX0X9+vRzb42228H+LQfmySstDTidIA1FUiD+FJbJcoyz9igZSu/GheGF+T0mG6Pv9JCiaWdMu4TqEcczKszEGrgnUy3VfsqpxNj+2cLkl7ZMJfVvvJgAVITA+b+oYuQzQOnXhmRpqbKF0I6YXlBDTH9F28aAQjUeK8oQ8YRron8OHwzge4GbPthwhha3K1mFANmEWn5LJPk5bATAlPwR0QV8iH+WUFPiIPUQUpZLIhWsEp5UuNPU6r/QhzNAwKkhaa2FZ6JOiV3ejpFvuTEJA8zQ4kEC5BSt6Kn70JDW8AhGq5IiQkg1ppsv/pDd9/VwXT/BSRYnObFBojJHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrIVy2OJfI1TC58FdHRNdkDapTpstpZRrcG5GOwyZvc=;
 b=DhJFxSlQFYTucxY0/v6ybewcu7OBwPA5WWpPU/umrUEO67mZs1MpRkqqpkYGVOn+NvHhXzQXT860zYEHrRI+gnY4sAq8sgfMNzYCAvOfRY3YlyLnq/QSpHtIKkhaaZ0x2oTHuRuo1v2h6ux0qbenbii2Kx3DNLevIvBa1iY6RrxyFImmbDXGvTSunflyKUmEx8VP+Zmwp76fuqz8+0t8ZJjdQUjiIptQtjZpVyCOlWd4psXiSacj1gOvojkjSpALcfUSmQuYJiOlaHKvrD/TESNz5G1psgP56CAzZxzAQ4y5+iX5OtsEAlxS8YrSgpErLSfDUa5fFn3e5fvqQo1iag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrIVy2OJfI1TC58FdHRNdkDapTpstpZRrcG5GOwyZvc=;
 b=vIdhKo3MNu6FR3uYU4gRKdNTiJmnkL6gMS+iU3YjifQyIeQCrFYVHWhPO16WXWOYvBofHiQUaP9D8pUvbaOiPCqGmWo+RQiZUgWG8FHLfCKkYAS4fs719KEHAjeaQVK3O4NYwUzefm3Zfey+J5hY5Geb5EGF41lT8TipNZGMsoc=
Received: from AS4P250CA0030.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::20)
 by DBBPR03MB10260.eurprd03.prod.outlook.com (2603:10a6:10:535::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 17:58:54 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::f0) by AS4P250CA0030.outlook.office365.com
 (2603:10a6:20b:5e3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Fri,
 11 Jul 2025 17:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 17:58:54 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 19:58:53 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [RFC PATCH BlueZ v2 0/7] Initial support for GATT Proxy Service
Date: Fri, 11 Jul 2025 19:56:50 +0200
Message-ID: <20250711175842.28860-1-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701144647.19572-2-ceggers@arri.de>
References: <20250701144647.19572-2-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A8:EE_|DBBPR03MB10260:EE_
X-MS-Office365-Filtering-Correlation-Id: 535087a5-d3dc-4e3e-3b8e-08ddc0a49996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0sPUGL3PLEiEXz9zET2sIN3jU9zX/qJp82QmI2KLwQwGYUfzjSNJ55qdo+z/?=
 =?us-ascii?Q?9L4I1O5jo3ECRnOCISEF+wF1SktkOyVyknhojnyG22KCMsfJc+0L3z2C2fr1?=
 =?us-ascii?Q?rgIwx6cPZzTMlcjBHMCbiofDcUOXKx5HJcdcQNGseNOzPdOv1DBWJgDQWnkd?=
 =?us-ascii?Q?7q09ZwCBRMFRjClgrOLK/hWMKco5GciqH5NtN0TRhUDdUVMctndSK759aIy7?=
 =?us-ascii?Q?a//rTz80nmYkkPmTdkhPmnPnt80vftkyyX0j0m97UHSg/auef/Da1rSPGFCU?=
 =?us-ascii?Q?QceojJTlAYsSPtH5AqnDA5/yq+FGJCj/NvdGZmheveHDmoaGepqkNkZVo0Xy?=
 =?us-ascii?Q?V32Y/fcqlaaiIOwEFT1yN3HEJplHRWAqqABfY+AZdgcdekefNBFYH+Z/lo/h?=
 =?us-ascii?Q?7eIf2qX8FDx5bYMUOg62KAPlcSJP/dp5E4dO0DlkLOVB6ly3lsk6Pc8CaUgj?=
 =?us-ascii?Q?67gQmlT9+TrNrTXe83kOQwPrHMiPSRAAMCjW2dazBtdc/N6LUUEYF8kwZAVm?=
 =?us-ascii?Q?yITiA7V77TGCU3NEBrCeTyLZJy6keC4Qs2T03+U24wxZW8nooGK66bzZnc2c?=
 =?us-ascii?Q?mFTrr0AE4zNg5AqXkTF28LvkpsGrosjaLeLSsMW6bobLrDqWeKQxd3i9/DV9?=
 =?us-ascii?Q?DigMHnkHpRHuk+pN837n02lG9wa0KpeIHf3lzCqkuKMeWnWIat/R4SgG1F8Z?=
 =?us-ascii?Q?UBNFa2H7zEIDyMQCpcXfYgM4eRVYFWV6i9dJBKTZJbr4GWUlb/0CTHcWDSVo?=
 =?us-ascii?Q?5LpDhv/OEtHXbJM2x2jRz6RDyFD1e6Tb4OEScM/p7i4ZGfB6WXZiWQWczyvV?=
 =?us-ascii?Q?uUEE+0QdCj/BHt+DbBQ98Ga5idcc95CBZ+SDs3Lnz6h8scEMHduxNpB5nznc?=
 =?us-ascii?Q?x/KiqMi5lXH74EhLbyZdjTyAgEzqcj4Kh6xOUVk1iDA+wLqbLzuAckG8rhp1?=
 =?us-ascii?Q?JCxIG4sWvXh8l6mWnAm4POf6yqSH6xPrEcGIAa1SOsHEIBTAZMQTVjQ1XMxR?=
 =?us-ascii?Q?dkU2iBrQUfIoJxNJCN/jeKFD9HRG6ZmuQPdNJ12gmScd3djWcpYKB9JkrjI0?=
 =?us-ascii?Q?9wsIUNOhj3ZZarkuDzNZOSFIH2AP5e9pxF+LBoL/9kp6IMXXrrzw7vZvutEg?=
 =?us-ascii?Q?JrSh88cJvN2VFTRVsKN9qebsJdtBo7GXB7vKZuUVxaCF9yR6+zneU6F6X3wH?=
 =?us-ascii?Q?5rNm16NFJMjKwkRfTrVJ+nVyq3mEB0r8c3PTsu4WXH1SlgrgoQpoMSDnRS5I?=
 =?us-ascii?Q?BmJv9hO2uz9mGRkuA1Lw9MFeiz6TlicAzi+SczHNiALE6JL/zJzwdgvn3qKN?=
 =?us-ascii?Q?Lqhh7Kt60ndr40PZ75Dmux3YKU3jpfZaK26qSaRGOP86xLXlhZyyIxBQH+zS?=
 =?us-ascii?Q?sYsZo/kwXmfO6pD7f8D+Z3oiTTsq6RkYtu2PQuSotphD0nPf5V9meDkA6LMw?=
 =?us-ascii?Q?TKtBqW+elVSUCBJL26OQdNYjIYZbZWxjbIHybRRgBTvXubOANfPZFD21cLHa?=
 =?us-ascii?Q?XytNvuM4L1fOI8giS18c2TsU/qX6013g9VYKUe6rDzzyccue+4YbtmnxWA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:58:54.0026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 535087a5-d3dc-4e3e-3b8e-08ddc0a49996
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB10260

Hi all,

this is my 2nd RFC for adding GATT provisioning and GATT proxy service.
These patches should work on top of my latest Mesh series I just sent:

https://lore.kernel.org/linux-bluetooth/20250711173958.25689-1-ceggers@arri.de/

Please don't forget to update the Ell library to the latest master revision.

Compared to the 1st RFC series, I have made a couple of cleanups and worked on
the following features:

- Proxy configuration messages / Proxy filtering
- Propagation of Beacons via GATT
- Relaying between ADV and GATT (after running 'relay-set' and 'proxy-set'
  in meshctl).

After provisioning two nodes via GATT (with meshctl), I can connect to one
of these nodes and control both from the 'onoff' client. So at least basic
proxy relaying should work now.


On Tuesday, 1 July 2025, 16:22:19 CEST, Christian Eggers wrote:
> This series adds initial support for the GATT Proxy Service feature.
> This allows provision and management of MESH devices from mobile phones.
> 
> Before continuing, I would be happy to get some feedback about this initial
> part (and about what has to be done in order to mainline it). Any help for 
> doing the missing features (e.g. relaying between GATT and ADV) would be 
> highly appreciated.
> 
> What seems to work:
> - Provisioning from another Linux computer via meshctl (sometimes I need
>   to repeatedly enter 'discover-unprovisioned on' and 'provision <uuid>'
>   if it doesn't work on the first try).
> - Reading the composition (composition-get in meshctl). It looks like
>   meshctl tries to connect to the GATT Proxy Service automatically after
>   provisioning, but I have to enter 'connect' several times in order to
>   get a connection. You also need to manually set the target unicast
>   address ('target' command in 'config' menu).
> - Adding extra network keys (Advertising for GATT Proxy Service cycles
>   between different network ids every 3 seconds).
> - Transferring and binding of application keys.
> - Using the OnOff client in meshctl (you again have to set the unicast
>   address in the 'onoff' menu).
> - Provisioning and configuration of an OnOff device from iOS (using
>   the SMART+ app from Ledvance). This app requires at least basic
>   support for proxy configuration messages (patch 4/4).
> 
> What maybe added later:
> - Proper selection of the output interface (GATT vs. ADV) when sending
>   messages.
> - Relaying of network messages / beacons between GATT and ADV
>   interfaces (in order to access further devices via the proxy).
> 
> Note: I don't use the test-join script, because python3-pygobject is
> (currently) not available on my (embedded) system. Instead, I use a
> custom C++ program for the 'Join' and 'Attach' D-Bus calls.

I just noticed that 'test-join' has been superseded by 'test-mesh'. I'll
do some testing with this tool next week.

Happy reviewing :-)
Christian


