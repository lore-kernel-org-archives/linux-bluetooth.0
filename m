Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012006.outbound.protection.outlook.com [52.101.66.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A11A08AB
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348608; cv=fail; b=aVnZ9jv0gZTi6/k3TsZyiWVCgHIBJZgL/lkWMhkjxn/8wAL4kMDjwtjYwVvl3ty3N4pTSV6btH0JQCtuXLaR9pW2EhTENne5KMkQ1FJ+Ku/+KO9GMzdMJRk9dsDeD4Wtp7qujbEX3Wci0C1FCR/xyHa3jY2Q87MgSFoPLrON2II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348608; c=relaxed/simple;
	bh=VjK2KK7oJwzad35wcAnc0WRVrp/dn/lQEt2hKxMxljI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=at+kC6OhF3GClGHMv237c69J5BvXiQykbReyxNvpnCPZKu3J0Cg54TfvTy4tE0/3EKEUD7F5oAjDqObjx6t2PyGY7NUybo//e1/mKqmkd9/VHosAD1cObeJukcEH4PZhz/5haBG7mlQwpqVBSKPzbQF81TP/KCIFAU+qCcdFK1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MzXwO6b9; arc=fail smtp.client-ip=52.101.66.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MzXwO6b9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dq9puHOzsY+Gag9PUvjCNDDa/5p8FbNAEQrdpHkTzzGKpTGVto1Mqy4rVb66AEnmfNkBfJB6mLI8yQYsHOO6z3ZPrRgGWYJgtX+mMt8XhbLzmDXHcmHE32InldeE2yI32cB8Kyf0Cb/QnXnhbnim5TDbMjzyodbpBLCfLK/hCPM4+KkR4LFRCDHrljBXoBxfz89F/v5rzH9NXTzxEMWYlMJlxD+gVv6Sob9H3l/n2Wn50V5omc4e/UxciGuToOXz4VFSHLpMNspXpZR34P5J9GsVdQrX0xfJY7Vd84ZuEIXJjQTq6Jbt1ue+C91zblFaci2Mw3+PL4t9zdHgVYfRCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lr9lMtaeE65NpeZxb8SZrnZi69RokeqBdI9aRzpneWA=;
 b=OuduXaysYhh13GA8Ke9Fa+4c8bwopseU+8rDB8H04nz4VB+R7+uLlCqkAfAfULVRCgkHs70MNQVNRCpBiIoZzgAJyIPE9EAI1K9qlQm85jygCAuYzJLr+STILiD56xeQPTUgpY2gyl/jk8QxhN3hvQ5gAjrD/GijaLqehD7q/0l5M+XvEyk09yrVntiNkRYYIrvAaibpXmnT/a5ZtxbHPZOiUhLIQFy1DtxfxLxxSSo97xjqfOnACzpc+BeNeK3xXXOeY9hIwKSE2DcHgam5PQWY7rFcVmwLB1UiKtSmSFgxYDe4CV6/1l8YB1sXOBm3XFQ5SGnmC2vDizO1hfSRSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr9lMtaeE65NpeZxb8SZrnZi69RokeqBdI9aRzpneWA=;
 b=MzXwO6b9FidkHOaPGmSqBWo49mVC3ioU2DSE/r8t0tR9dVYs6AcgMzSxiTqUSXEBHYUTG1LbnQmbAaJxJNqkebtQjyMvHmjCznEMFSoWh1kEj2w5owRDV/UCalBBKOPLlUw6ie9lAcsyZQTl1syRWlTC5yqygdENFqKxW76zkm/nvsyAHhuyszRXjD90soR9BEw7W5qmA9mi74P37kay+9XBAKZW+qd9IKSeLhkqyQF1jGxmZFPSSsl3z29x3v/aRRphdGDk+pu0KEksaFE4W0sKlW40Qxd7eqTcMNV48UzxnbM//gz2CLT2/TYvBveuyddel6PjgBIAe9m/iKyV0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAXPR04MB8543.eurprd04.prod.outlook.com (2603:10a6:102:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 30 Jul
 2024 14:10:03 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 14:10:03 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v4 0/8] Add 'broadcasting' state
Date: Tue, 30 Jul 2024 17:09:39 +0300
Message-Id: <20240730140947.411655-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAXPR04MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 744571be-7fcb-487e-40ae-08dcb0a14e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UF5Hu1WklCX8yCarzZxualYDOKHz7P/3JMg5WRMCq+gz9fcUubXIzlvZkPQw?=
 =?us-ascii?Q?hv9XhsaeZljzTkBwpqznbfyDcNuM9lw3OgyEqM9/TwXbyM38Le9i4hqEMDTc?=
 =?us-ascii?Q?l13ockO6uadQUCRfLM+sVv7NHqZRHbD9rVq4X2r/g5GgsT+RYIrt4ZU/VhS6?=
 =?us-ascii?Q?nqcZusrxEsBLXXDa1ixH/AhGXGpYJR2+1YFimHoPBHrVuDUAV5yBTUKKSY5F?=
 =?us-ascii?Q?E7lGtdhkVA1H6iH2tSli700uVtcSwyeaJFGWAIMdcFCxYBgmMsPHnc9YM9pl?=
 =?us-ascii?Q?NQwMQfmHr/OXLepJRIQj96sqxspXMwRAmaIqEmHwf5Zy66E9PIVbBdVdvDm/?=
 =?us-ascii?Q?XfMUqVf70/POoDnz9brgHp8FH4f2lsixiViynK03MYQR9ymQuSyw8a75nxuU?=
 =?us-ascii?Q?BkLQUIUrkQxR/yp4G12KJop4wmS5AIvlhu+Py1MdWIi1hYly7Bu5fQPS5iSv?=
 =?us-ascii?Q?WKHFEwU0gDQCo4AXFazNhSOfiQ7g+gQxlzrKthT+41UImpnwQwXdI4xJjgwZ?=
 =?us-ascii?Q?dk4lVk1xRQEzC7CCeSwzmZdIcMUcjPYIEgnzR9GtLWSs27fSQk6QIXy5C510?=
 =?us-ascii?Q?DaV38JIT9XppyWtHz1zO23K9KohKPwkG2Z3wNJIUuJHJ8whotI4JPx9TuNDA?=
 =?us-ascii?Q?1FOcWekDCNLzYJrgz+sWJAKkGDQe3JtNVsR2jdND/2yfw3dA209wBfFMbe11?=
 =?us-ascii?Q?P8fymAEenU9SLSOZxZhVDLKWGfzWEpZ1QYFQgAPX8KgdziOrXtluzGC5xH6G?=
 =?us-ascii?Q?GN/ZoQMfIIM7OtriJO/8RUN42KDI1LOZ2E5viha00WU+JCehyzXIp+rWKlB4?=
 =?us-ascii?Q?6K448sjSFyKpF5z0Qh08ybuol2OhEV8JxYAuAIFbRqPsMYAbW2x3NCNhK4Cd?=
 =?us-ascii?Q?m1Ra93YJvG1ekp9c93AR06YiU/EKL4RFy/dERXyH0VOyEyfCPo1nvZRjGNQ2?=
 =?us-ascii?Q?VsxPMA3YIb/jcFO9mlyxSFmax8pCkSTfW3gkI1LKb40m+OcXecUQW2UVPHJF?=
 =?us-ascii?Q?FCWU3gCDroS+oTjW+7XjS/GAdiTjsYn3lrWLyulXG/ihV7riW26fIFJKvopU?=
 =?us-ascii?Q?ZKDXUTr3Ps5xZQrY8lRxJSY4OsXfjDt/+n3H1ZTUIVRQaSjsrjqygKJS3nzV?=
 =?us-ascii?Q?IyWKeFjJ6BCbPWp+RGhctW8uPRpmBKG/NecnvwVf6aDSJebTmQhr8KSpajlL?=
 =?us-ascii?Q?lN9P3oQDDQ3n0UlLBIs69xYTmqtgxK61JdHRJUBJInJlFIdXtBSS8FuYKfDf?=
 =?us-ascii?Q?SWz6mXfYwPHh3ZuUV4xCvKhnaChoNIwp6eU0WIUaXSwD/WyCAxdnbN+RirLA?=
 =?us-ascii?Q?6D2dHgE9lqmtZxRH9P9JIsI5Gewu//vLtv8ffnBZ+2QNpx8cSOzBLsHvoubK?=
 =?us-ascii?Q?w0+TUVZyRAFT6DkoDY2I7ksyYl1uhNxU11OMU9q5vJub+ifriQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rjwa1nkQ6RDzXQqxNMqFASrx78sV15G/tRfnAlTgTBBRfjeF99QZBbK+y42j?=
 =?us-ascii?Q?QbJMZUfdn3UWW83Lr+trX2BLRzdkEXe66n9FH5IFNqetDEBMMeLNkCRniyFd?=
 =?us-ascii?Q?At0Amfu3VQzJvv13MyTNMcKsLNW/cMs8U5z1HMelXEbvx3CQHGeOhPkXaVBO?=
 =?us-ascii?Q?r07qgL0Fk1LBa286G6EdamXPLnxhcHsdFjB3A4hCuIja9r+t1CoSULAWM472?=
 =?us-ascii?Q?h9Qv5PAQf73UZliX33Qa6ZRD642b5BRXgVM0rISXHD14TcidI9T0onV1EVER?=
 =?us-ascii?Q?O+nTg8Eo0p6PtdF2uQpQQhIyp84IXugG+zahTbvvHO+PxBZnnVBHfKQST/HQ?=
 =?us-ascii?Q?VbFo+SumhN+u80RdTYDuWeDrduHMLL6neKx15JD2Wp1xOdM9xuVD/u/jxAF/?=
 =?us-ascii?Q?Dic7ex4Q7lQlqtF9vIS8FSvMzqZqa58rsWL/3o13ptqhoj+/wmwhaX3VFdl5?=
 =?us-ascii?Q?81QHvdE1fwWg2aIWSBovwQFKRqvqM+4rpsPEObf25V2Dfm2yC84+hntx/iFz?=
 =?us-ascii?Q?SsMhVq0tvN+wyauNGKu/LAO57VMuk7GKNAgnKYuPCQE4sTVI4p/ttRmg1gC2?=
 =?us-ascii?Q?CwRGg7rpAWrq1A8gzcw4jWpkQEPpWA98IKnc5Tyy+jPeWizi7vMw1y5m4CLY?=
 =?us-ascii?Q?L4lWeTogJwH4EHaeVyVA7N+RwHgqCKhXqtVlMQvUmn+Q9FfeVG4K6HwaURUP?=
 =?us-ascii?Q?wLSEwqBRIUgptX46iNu6E53c67pyWAtKjNEgVZONvdzHv2RY80ZUeE4MrtU4?=
 =?us-ascii?Q?jgM9bRlc19sqUyfXbvyAFkaqLtrCQDYYwSug50dLdNL3jG8EnV1LAXAIZJaM?=
 =?us-ascii?Q?h8AtusfD8J19CQhFZCf//nL3WB1GZs/P3G0ZJXO6Bsq8Nbp9I5iu3zMAmWzf?=
 =?us-ascii?Q?W6eWz0v9SU/63DryS8YSfawDmlJY8KW54rCefRAXHdyWuz2hAvxzpBELs2P+?=
 =?us-ascii?Q?phIeMeK92/Nu3+CuPZVtEcfRxWeg+JqJrygxNsSmdly6AZTUqN70h7P5HUr3?=
 =?us-ascii?Q?X7DNjwL5vd2e8sBmFG1gdS8vn0Xierhf39qSX6om3d/g2iU5oKpcqNh2u2le?=
 =?us-ascii?Q?dLlfqE4ICGK/U/8p9IMVyox9eRBxq7yNpacc0uBPcu8aE2XwFJ8c6pyoXU+x?=
 =?us-ascii?Q?vpW14J7hNi9BMuh19lcknC06Urxj7Gd5ZGkUF2caCGyjddyETx/Nqp8H7uUx?=
 =?us-ascii?Q?A2fi2M+yAMDHwCM77eCg5QQCDHnXRX7dIaRVbfJ2u4vDl2imRNpTGoSrqtuh?=
 =?us-ascii?Q?L93kZXJwV07OlPGHxNATB7klfFVmgRLRIRRxU3rHenCuIW+xRlZNinR14796?=
 =?us-ascii?Q?7Al6QHQNtY2HEMXKkrtt1Df9at8fyEyPTVnzLMSae/iH6cv6SDVapKM+Jn5l?=
 =?us-ascii?Q?WLQIMZJjaynHZT+JmUwRCKCzf8WlMHndOfco0tWyszdnWdz4L62IubTo83vu?=
 =?us-ascii?Q?wfMZfanuVbDh0n95+RqnVq/cr7KlXBo2aklX86ODttTNWGRn+BKblKL4iDpN?=
 =?us-ascii?Q?GfAnPj+pTEc7QytQhxlQlbYrJEVtDYgXa5ZubXzqgQDM/ZtGWy7xQOq0RPFa?=
 =?us-ascii?Q?vv/yKtomise5Cv58hVxlsj2tqIgTRoav3MlP8du9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744571be-7fcb-487e-40ae-08dcb0a14e2a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 14:10:02.9671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HDrBcmxO6YBS00xs6xzR7hx4Teq+HVbjJasinHbnMjUPq7sx+HqUspdPde1w0O4gdDAjiL6CabqVgAaQiF0xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8543

This series adds a new 'broadcasting' state for transports created by
the Broadcast Sink device as a result of scanning a Broadcast Source.
Such transports will remain  in the 'idle' state until the user
selects them, at which point they will be moved to 'broadcasting'.
PipeWire detects these transports and automatically acquires them.

The transport selection is done using the 'transport.select' method,
that this series implements. This allows the user to select the desired
stream when running the setup with PipeWire since it acquires any
transport that is broadcasting.

Termination of the sync to a BIS is done using the 'transport.unselect'
method, that also involves a 2 step process. The first step is the call
to this method, which changes the transport's state to idle, with the
second step being done by the audio server which detects this change
and releases the transport.

Vlad Pruteanu (8):
  doc/media: Add 'broadcasting' state and 'select' method
  transport: Add 'broadcasting' state
  transport: Add "select" method
  client/player: Expose transport "select" method to the user
  transport: Broadcast sink: wait for user to select transport
  doc/media: Add 'unselect' method
  transport: Add "unselect" method
  client/player: Expose transport "unselect" method to the user

 client/player.c                  | 100 +++++++++++++++++++++++++++++++
 doc/org.bluez.MediaTransport.rst |  31 +++++++++-
 profiles/audio/transport.c       |  90 ++++++++++++++++++++++++----
 3 files changed, 207 insertions(+), 14 deletions(-)

-- 
2.40.1

