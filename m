Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2073.outbound.protection.outlook.com [40.107.15.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1CA12F5A4
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686763; cv=fail; b=YQwhBnVKOfXq9Mn9PVEakqPlg8L/ML31+HPivjTTEarS4TzPhsBlJI4CH9EDHq3eZOvdRqQ5NpXwArCkop2pVxRRBUxylhQ6V681uARJz1z6ze1mEYcIMX0mxMj1lzGp4eHZm00qAfN7W0B2pXPivtJ7FS3SPiE76+vO1JcxnTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686763; c=relaxed/simple;
	bh=yx6jbOEGvYPIRuR6Ur0pPC6u+ukvb8IayGp0dG+ALcA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LQSGu2vOV0nLP1P4gI48J96mDkwSNOBC4+bgxtuAKdrpyrJxZ0x7qV7MZhDzX55kxRuVGcoknw7ZXxDPmIBulovF+VN9BX/IheleNFCgpFFiptskrof8o+DKtfV+/eXWUvRp1aQwpohtHxIsV3CROvrG2KgETtBOAWdEATR0FRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sSYHQREt; arc=fail smtp.client-ip=40.107.15.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sSYHQREt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUk1zwxG0uUrCFDla3t/lvy26YyDAYyB1cgE7tkyMc5ZNvZVkWiUKrK3CcG1+me9LOqh3nZl7sZnyDU1t9yR4a10w/OOP8Nkuv7J5urDceIYCcwEIkdPivXjI1G4438cUbU4KNxzz749qoYhXFc3lPAGxNtku5NiSE62nWa+Ue7gSgmXH7san3PlXFp4SNpokBmWl+027MG4ARuLEHZ2w27bfw9SgDRdaXQGqWpN822WeCE/2sFMW2L+5ud6nexMz++UKxvMhraFTy44vqikpe+N1/19qhwZGNHFPfcCXt6QgedWMP4ftmWxPeCnQWc6MuT7UmWAHZ7jTYFwjc1pUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOJcb1sSGK9dVjRSxyozgkR30Yx1QfFGmSPpLWCPecY=;
 b=R+nJVTw/tX7wzDJ3zWFxNaBI8dT+4J1DCvsFTEybwH6GaVrIOYIj04dq6FruND3prxCzrWejCChTduYY+0Hp6Ddv335KJx5j0SF8KjC6HIq0IuJoZYu7t90EIkKAvbikF3WPJRBiVBP7BMSsy5j0NYskFIC7Hd6Yj4IUGBzfmdL/SeX2fyh9qEJwXGli1HPGetbIJ3Fb+fcEcp5LRi688fnssZXT+wHACKKZgk+blc86lrWsA5roUdEIvLuwuXgdxNd8VsBYD750+vNjSPjgnSClrfqE/148qo3GvC3EiyEw18daBdKw8j6/W+zcw4K9CqDcWKY3BtmpqJTavvW59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOJcb1sSGK9dVjRSxyozgkR30Yx1QfFGmSPpLWCPecY=;
 b=sSYHQREtxDNif8c+ttjDRhseOFT+YL96ZmLvaqjsVNO/7cVIEBtfKWVS2svBsL9DDNCtVNhrvRQoq/xsuXlpcfAgalet/7t1di/z1vD7o94LVNGjzZT+z3kVRAN8t/GE38+E0WSArUrttR4d53i83skGI6nh9QkSsNxEf7iHUh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AM9PR04MB8618.eurprd04.prod.outlook.com (2603:10a6:20b:439::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 11:39:18 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 11:39:18 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v4 0/2] Create transports for matching BISes
Date: Tue, 14 May 2024 14:39:12 +0300
Message-Id: <20240514113914.21048-1-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8P251CA0008.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::26) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AM9PR04MB8618:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8917a0-07ff-4df3-a1b6-08dc740a7d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BeY3r8BwOlb0Y6ch7rrMYoPpO2gakWzrwkzwv7crKDBu74BZ2HprZvFzXV4E?=
 =?us-ascii?Q?5/kerWzzM5EXAwApSt4QCjarN4oY6oFDbOQJURzOSjIMomjWx87aWXBbMuPF?=
 =?us-ascii?Q?X7Pq2UJLRyxZ4my8gzisqMiYrK64IEdo/nu7AMzYP/kv799o4mMhwiysRquk?=
 =?us-ascii?Q?++yoNsIOG91xc4QTEPDMUkbltHcpA9/oogutMycDw+0x1qxjPwg2PGI7ODfl?=
 =?us-ascii?Q?IZQcZ/FAHDG0+E7mTz5fHZZCgyz/ZmAi8VgIRwAxMnSd7TWSIx31m5PzAXde?=
 =?us-ascii?Q?RpCocXqCqdlG71L3kK2Q1PCCaIZyViW/5G6x2LkefoS1mo0BVQQkz+bc6jW4?=
 =?us-ascii?Q?HEgleVtOE9WZKv+QsuUHv84my4yuLe0YSbz7oFe7b8Z5D1F2v5rO+F2kI94i?=
 =?us-ascii?Q?kZbSzyyn52y+Y2L9dPvZ7zr/1bpIiE2JfR9RIaftFNzDrbnOT5qlhPoU4z/y?=
 =?us-ascii?Q?Ciqh9urlcpSKF48gnmPA30wNCgxtWmH+PqNlanwW8Yg7FB2WarEoCH4dV6iR?=
 =?us-ascii?Q?h/2KQsbnTdSyeEo2WfIDPDk+33vEOWIPCsZFqLP79j2KrMAQlRtDPquG/x6U?=
 =?us-ascii?Q?9E23UMNUl3hkq7RvV9Yaq0hFpCWE9I7LVtgB13YMnLWJ5A1aiDT3JucM5NyJ?=
 =?us-ascii?Q?kGhlxw5zd4m45FpOJfL7BXiXOEaXSw4DzSnZsP7ZSycM4y02yxzVoJJImxs+?=
 =?us-ascii?Q?5u0PeVSLStY2R51Hq+MF6jB7jK/+scO08RPS/ocDk/zMcyEzBaTR3+HwY4ZE?=
 =?us-ascii?Q?5y+EFhOfIgsn1oWj15zMEP0MbRh3SXUzmLeZUJOSSgp/t1U9DmKBEC2ODVv7?=
 =?us-ascii?Q?wSYfMX4rwdWso5jurTCuW8oj4eCSSaluZJx50Jc5K6pi3pNSJFZg74RW16XG?=
 =?us-ascii?Q?zpVCXKEzLD2XeMlsAc+/y5VQ9ktsaREVpu0jIJ8K25EPSZmkcqU9owdOy7gL?=
 =?us-ascii?Q?+ZdYxF+nwKUVxPQvYiShoGvY0uiiRCepAnrsTddfelfygITQdx1Gy5POFEMU?=
 =?us-ascii?Q?eFB0ymheDYPAQBRLdy14TKSYK9cf4anKieO/MRPo3QctHwTz5FGtJUj0QYO7?=
 =?us-ascii?Q?SOczmaRcQtnrke9Hdjg3vfq8+Yl53k9qBE/yBepjSVlQy6eHWTklFLmAVak7?=
 =?us-ascii?Q?86dDPWz0VALLvHjQb3oCGXnL9O41rLTVJNmrwDGfXP/rD8tTn1+//UyR04ps?=
 =?us-ascii?Q?+HitbYy4wAsDCWpms7FtWJBK4mI0qHHHkoqfdFYqAH2eX8MiZoLOmvPUb0Cc?=
 =?us-ascii?Q?9s6CQ+3HcVZDgrCbwq6bjxED7PZGrSQFpHydkcKqXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JXnBWPYoZmbwESiWCKtKsCQErlAwQh3/w0ewpvn3ViVzHgHQozPhzLpn9f2+?=
 =?us-ascii?Q?ws7jgg4KJXJnBiv5EXPOEMVWip/oDSso0X441DEqW2FAUKR9tMjACBD3BQsQ?=
 =?us-ascii?Q?7QSPn+7f6dtBdtx5EXNQLRhoR+DQC2Giwk3Kq5fp4bURDROUrUEZnKrltb3g?=
 =?us-ascii?Q?XOVdL/WYx5+OqV1CoWXUcKjqfFnVvVbPTAFdNIpYpTsdrOCV6vgXlKzj80yY?=
 =?us-ascii?Q?9c9u37xk9RMoCBPzEEGSv3CwpO6rEY4q+96D+kFODNl/t6kfuFH1oyJD6IHs?=
 =?us-ascii?Q?VyOqLdfAyLR2YavoHvHHRX6G7fwlOFvYEGLzPKclEFlm81gOVW++bUoE+YfJ?=
 =?us-ascii?Q?wlWLIeuxdxF1T1xAtRI1nVQHKL1r1WLQdhrkAQLJPtKrxQD5dWzGfBD84abo?=
 =?us-ascii?Q?fFd1HSImifed9dl8fqfMFX0Iv9Rv2Sykxw6glZMVDeZirQg9BGU4bm2pX/TX?=
 =?us-ascii?Q?IbRW9JwuQQh6XvH7ob9l3Kn9NrXT1ndU+v89FSAx0ZOJLbDZ7Ui8wpvjYZxR?=
 =?us-ascii?Q?1dHk7tsrzw5SCFV50vxFqer/00ezuqe3MMNqKKbtFto+tLumF5Elgt5qivNs?=
 =?us-ascii?Q?cX6/CJ2buE3oYTy7tau5q2iRWQJP8/zI/jPVA9QX3DpLIN/dFfz68PKLuYUX?=
 =?us-ascii?Q?6HLJRG8jPQqrkSLMEcLio9wY5TSlb0YNdZC+jZOpzJL3n5EsAkz4qIGlDG/6?=
 =?us-ascii?Q?JOVUhDjbstggsB6/o+JfajqlQZwUEY4l6KuI3qND8KNWVdy89DCgZYW1VdF+?=
 =?us-ascii?Q?s+9XYgNAVknyDbL+UAAPIroZRFi3zEUpUBFwq5qTg3H+mHkI++M+AnTPjLGX?=
 =?us-ascii?Q?EnjIWHMvjdsIB6iFqV9NYNdus/TCkly8tmkIFpEODWhgHVhbK5Uu3FWVUrLd?=
 =?us-ascii?Q?zfB+g7cUHm9/DAb9UU/+xsdoyiRf8PHs3CHPakiEBdixrJu8eIPnHtoT0Q4S?=
 =?us-ascii?Q?5xOnmHo/VSvWkrbCwePecG5wYL+NqMMwfk8aTqHa+LeKcAKxpiXnEW0/6LqD?=
 =?us-ascii?Q?oVpdx8q7HNLhu2Gf8ZbPx7At0pnu+XSUOqkY/6uaGFNbSBMUyVkI/sC8KoPH?=
 =?us-ascii?Q?/UyCZr363RKG7U3P+9xIJMajeOKFzp64EHtSrwMBwB/eYS9THkvztcsDtx39?=
 =?us-ascii?Q?XYieHI/qP7dgtRTNJF/vZVY0Qq7zjihzrnxKMJymvUsxDbEoXDkz6trNitYc?=
 =?us-ascii?Q?A2zT+99H3W+p15exVhrpKTq6b9BuL+cJlPTVpWFPurp7ayVrkKSnfP9ereU7?=
 =?us-ascii?Q?I7ZUqPgmf4V2kgElF2yIg3+h35hmEfDg2CkDzv/Q/5I11UfJcyoQmUjK1UVx?=
 =?us-ascii?Q?pQIdH3V3wY5/VXWYYmVSdFp9kEIiLd23U6pCaoWx4xVy381K4aeiHkPvNwtX?=
 =?us-ascii?Q?QUsK3f87U9mFhujHlymp+OgQWKgSNpHM+wVjfnMAh3qB/wKj49m+f5PwxhSI?=
 =?us-ascii?Q?d8lxMb71NCwlywhuNIR1rcd88YmIs1xt1SaiWIg/1sUUW+VA3R58z3cY087U?=
 =?us-ascii?Q?qVvBeFQc/wTEdOepob+6B0OM7N5TJ40wNsQvddZ5hCz+TZ0G9ezciIyC3juN?=
 =?us-ascii?Q?PuOmcVvyhalHX8SL2MTfiG6jG+of1PWWQD4+XqSCYj+yyypFm7w3VhQGTMi0?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8917a0-07ff-4df3-a1b6-08dc740a7d76
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 11:39:18.4289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0d6+sqU7AF1xpNYZ3AGw45/X7JcjuWmK6WsBLA+cWRvJhITl261ko4G5yPECp15oQl1c7spoq9pbwRrd10LGAfMn+c6YI32kYeqAS79j84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8618

This patch refactors the flow for the BAP Broadcast Sink.
After observing the BASE information, streams and transports will be
generated for each BIS that matches local PAC capabilities.
Because endpoints are not available any more, local PAC (which contain
local registered capabilities) has a new list of setups. Each setup is 
generated based on the matching BIS observed.
Then, the setup is used to configure a stream which then generates a
MediaTransport.
The transport is in the TRANSPORT_STATE_IDLE state until someone
acquires it. The "Acquire" procedure results in creating the IO using
BIG Create Sync. The successful reply of it causes the transport to be
advanced in TRANSPORT_STATE_ACTIVE state.

bluetoothctl log with two transports being created and acquired:
endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 3
[/local/endpoint/ep0] Supported Context (value): 3
Capabilities:
  03 01 ff 00 02 02 03 02 03 03 05 04 1a 00 f0 00  ................
Metadata:
[bluetooth]# Endpoint /local/endpoint/ep0 registered

scan le

[bluetooth]# SetDiscoveryFilter success
[bluetooth]# hci7 type 6 discovering on
[bluetooth]# Discovery started
[bluetooth]# [CHG] Controller 00:60:37:A6:AE:22 Discovering: yes
[bluetooth]# [NEW] Device 07:34:BB:4B:6F:C3 07-34-BB-4B-6F-C3
[bluetooth]# hci7 07:34:BB:4B:6F:C3 type LE Random connected eir_len 0
[bluetooth]# [NEW] Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis1/
fd0 
[bluetooth]# Endpoint: SetConfiguration
[bluetooth]# 	Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis1/fd0
[bluetooth]# 	Properties.Device: /org/bluez/hci7/dev_07_34_BB_4B_6F_C3
[bluetooth]# Auto Accepting...
[bluetooth]# [NEW] Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis2/
fd1 
[bluetooth]# Endpoint: SetConfiguration
[bluetooth]# 	Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis2/fd1
[bluetooth]# 	Properties.Device: /org/bluez/hci7/dev_07_34_BB_4B_6F_C3
[bluetooth]# Auto Accepting...
[CHG] Device 07:34:BB:4B:6F:C3 Connected: yes

[07-34-BB-4B-6F-C3]# transport.acquire /org/bluez/hci7/
dev_07_34_BB_4B_6F_C3/bis1/fd0 
auto acquiring...
Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis1/fd0 acquiring
[07-34-BB-4B-6F-C3]# hci7 07:34:BB:4B:6F:C3 type LE Random connected 
eir_len 0
[07-34-BB-4B-6F-C3]# hci7 07:34:BB:4B:6F:C3 type LE Random connected 
eir_len 0
[07-34-BB-4B-6F-C3]# Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/
bis1/fd0 acquiring complete
[07-34-BB-4B-6F-C3]# Acquire successful: fd 8 MTU 40:0
[07-34-BB-4B-6F-C3]# [CHG] Transport /org/bluez/hci7/
dev_07_34_BB_4B_6F_C3/bis1/fd0 State: active
hci7 type 6 discovering offm[seq 0] recv: 0 bytes #            1
hci7 type 6 discovering on9m[seq 146] recv: 0 bytes #              7
hci7 type 6 discovering offm[seq 149] recv: 0 bytes #             50
hci7 type 6 discovering on
[seq 2446] recv: 0 bytes #transport.release /org/bluez/hci7/
dev_07_34_BB_4B_6F_C3/bis1/fd0 
[07-34-BB-4B-6F-C3]# [CHG] Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3
/bis1/fd0 State: idle
[07-34-BB-4B-6F-C3]# Release successful

[07-34-BB-4B-6F-C3]# transport.acquire /org/bluez/hci7/
dev_07_34_BB_4B_6F_C3/bis2/fd1 
auto acquiring...
Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis2/fd1 acquiring
[07-34-BB-4B-6F-C3]# hci7 07:34:BB:4B:6F:C3 type LE Random connected 
eir_len 0
[07-34-BB-4B-6F-C3]# hci7 07:34:BB:4B:6F:C3 type LE Random connected 
eir_len 0
[07-34-BB-4B-6F-C3]# Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis2
/fd1 acquiring complete
[07-34-BB-4B-6F-C3]# Acquire successful: fd 9 MTU 40:0
[07-34-BB-4B-6F-C3]# [CHG] Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3
/bis2/fd1 State: active
hci7 type 6 discovering off
hci7 type 6 discovering on
[seq 1330] recv: 0 bytes #transport.release /org/bluez/hci7/
dev_07_34_BB_4B_6F_C3/bis2/fd1 
[07-34-BB-4B-6F-C3]#   1;39m[seq 1331] recv: 0 bytes #Transport fd
disconnected
[07-34-BB-4B-6F-C3]# [CHG] Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3
/bis2/fd1 State: idle
[07-34-BB-4B-6F-C3]# Release successful

The difference from v2 patch is that match_data is not initialized any 
more, to overcome scan-build warning:
warning: Value stored to 'match_data' during its initialization is never
read struct bt_ltv_match match_data = {0}.

Andrei Istodorescu (2):
  shared/bap: Update stream management to avoid PACs
  bap: Create transports for matching BISes

 profiles/audio/bap.c | 323 ++++++++++++++++++++++++++++++-------------
 src/shared/bap.c     | 290 ++++++++++++++++++--------------------
 src/shared/bap.h     |   6 +-
 3 files changed, 363 insertions(+), 256 deletions(-)


base-commit: c7445d9736947163f0028bae0fd1ae2133bbbdbe
-- 
2.40.1

