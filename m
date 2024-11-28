Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4D1AA1D5
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809271; cv=fail; b=pQGtvmPB6AC9fv7XQzqvz9U7M5QZMq+9dVCsslMxKFVFCeHQ30RTZ7ixj9nwr/v1+AyGJEJ6iG/JGyRMO7vY2AICp6OmnO/0yXtvHEEypfaUhPPBjNPf7xHjhHAlmgn/w4Qe7Vn4OgMnGkPzByqk+2nYgwiApBfC+Q/9t+/VATc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809271; c=relaxed/simple;
	bh=RmmE62RtzW5Yli1JhqWUEcVVFbuVZ7wcnv8V3AdDKWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hSWOeUHEDooKmiQkpVpJdp/ZO+tJUWdAEM4/T+V40Po+JyJ9oT9rdxdnSKk4+fj0jFoW0Y46fZORnGAB9Ykbdch87R9Zp2l/jIa5mcegHWT+19R6KmpPD4vqJvB+6E+JuNf/qak0E1qftr9fuc5q9rC526FgrEb9WG4EyUq+2Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F+C7xE0n; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F+C7xE0n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJtZOX6iflJnidY1tF8gH6Bas8EKc4ovoHvIdGn6Jla+5/XJU4tAIx1+w9L5qXD/RfC6nKVTXe1B6BKFlEbJaIeAv3MVIwmzO47ZSz1r47DPkYkIgYVOhMm3rVykMlbmD4g9bm702ZKrWLfucVqnH6w3U1aBT/eetXmBSVittROI8yHJ9HGUmXFRchodXPPvd6Hf2pX0ngq6DlNBxzQg/bxiY8brRtMiegqrVWd2A+Bryi6UXuoWNUuLGsG9U0gY1RJwnUs6BiMbrqlUWhM9o9WmmUz0Bu2Np+mjfBDzJVkMICjpCrzUQf2hU2PywOxIb407jsIyxSkXoFrgk7yx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM7Oabywfz+pG2w7GtuzOWbOlXNO0IpL7kpZcE2/RgQ=;
 b=Z0S7NW53zCP8bNcoOUEdIIzgKFxGDhhzzFOE9L84WfROG7cI4CnsHqMCr7XFH44+/KNDDYNmefhFk8hfHRv5tXDRFz8Ze9MIOX3ePbaSRCbCnv/KPwk0bpZPXWyUikmuiZrbMfyKYxmRqz3oE7Uk9SheIm7ZDJwbhzQ04xooBll70VK/4B/7UdYj1VzdCxjgCppgRy20ro5IvrtwcP83J4ShgTiz+KPaaAIRfXdx3MEHKQotFvBAPfS/tz7JVXXPl61ykiPjjs+ftgeC1VSxZSgiY0aNcZ/2w+gpufRgGdUdtWKJ5Z+UCAx36MRe2j4ILq8e0t9YE6vTKcgFaDS2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM7Oabywfz+pG2w7GtuzOWbOlXNO0IpL7kpZcE2/RgQ=;
 b=F+C7xE0nIVX+iKYECROG+N+4rLI1yabB7RR5isxBk0NWDB1wZigtHVHuz1QNBlUFt8TLUc0ohCoaewQlU0VC+5UzZmJtSQFQJr7dRaz6B/B7D1g4qpEp4mS56UV91h4oOEzjhx2+GMGatmen5lkCIJR4MRLapRivU/jGjjGtZYVyRNcuR3R6xnQsgD3wMq6Zy6Rqg+m+qqSuVWqEyqr6efiuazTftRoItBm0bKNTOYH3eQgvXADHueSxTXectmwE5o6BvaBCDbInw+PTFwUeQFk0W9iDqy7fxlp50k2Cmwg7V9mzmLJeLDFNJQ9TVdZ3x5ZEepfuogNSpoeW6GEwJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7626.eurprd04.prod.outlook.com (2603:10a6:10:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 15:54:23 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 15:54:22 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: iso: Allow BIG re-sync
Date: Thu, 28 Nov 2024 17:54:04 +0200
Message-ID: <20241128155405.14910-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0030.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1a05b5-7eb5-4edb-3768-08dd0fc4eceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gkqsOEPXO4WGVHWa6JAPu3X71vaUagz42Nbe0DDCQC5ujIXRs6JdlZ4CAOWS?=
 =?us-ascii?Q?PX9ALzolgH+KPtKorgOJxatUxEWtL/3kZOh+hanWvWgafY4yoQV570heUvxK?=
 =?us-ascii?Q?bnUEWkcF0yl+QRKOiEmllC0jZmT4iIVqSkxf6ArNPtxJ0s0G0x/Vdbia34Ps?=
 =?us-ascii?Q?WIVFXUuxGskS2tv/n4BRo3A9Kx1RLVZdfrsS5JZOknVpcGc15sUGrFG5T6HX?=
 =?us-ascii?Q?4Gm1qDk9zW0KWHBISC2k/rCq+Y3Lk/r1w9ruFBH8lJdr4dPk8Q3KdhvYHuHr?=
 =?us-ascii?Q?JsJz7lwJ3DAz6QadScK/D90dqCLBNMQTwZiJIYCMqW15B+iNvfwRBmqNmOG6?=
 =?us-ascii?Q?nRIJOOCgf+jnJ4ZH7mTtEYMv3JJgQtPafL3ESHz0F+2xeBftjtVAOCpKx1uP?=
 =?us-ascii?Q?UiK7bRN21tyCucwPfSE1EmLOxdp7YdP4WNP75eZM9i6ZiVQJtrV0Km+8fb9M?=
 =?us-ascii?Q?1ZhQydI9V3B8YSEmKlEH6rPqQRF6BlGoPa3Jkhshd25uwZzUWbzkh/FwKZe5?=
 =?us-ascii?Q?JEuZPmeONFs8ikoiRbjgcVJW7YE0CQoSAafputeNKKDtLUW8gxvBl/cpEL3k?=
 =?us-ascii?Q?4ClppvZpd5zbCSPi1rX/W1vLhRJb/P1Nq57ar/Ty+UXcF1l14R4RX+s3zZTr?=
 =?us-ascii?Q?W+kbd21bfUhTFhMFaELxWImi/SCFD8Ofa9QcbI48b0wQoHFfWN5kV2UO88C9?=
 =?us-ascii?Q?dFtLkV3jUeDG0aBgkI0m0fZaZ8toYlC0DIbU1mXaabO+QsLNcMlsQr3BLJtZ?=
 =?us-ascii?Q?t2cgyQfyTf6hUhr5VPHlNFby+1hBlf0DJ5w0iRObR0gE7MfJDRApkE6AMpxp?=
 =?us-ascii?Q?SoJvJ1CLd5auKy1EiTg8k8HFyDEf3JT81Y9izgtjGCU5QCjOWhUMetsr4soC?=
 =?us-ascii?Q?uTSeZh0/bDEXA+iuA1+yQSiSarNQLNfRhW5pdC/Fn0WEi4Wig2teVmyhJyHL?=
 =?us-ascii?Q?sSXMRH5CEY5+gNPE2HDD+rjau/1qD28rCc7ZGDT5I7Zl/k4diHrJl/IaCya5?=
 =?us-ascii?Q?xRTB3Q/Q8p7HPgyVY4LxyPUSpLCGIX4IwL98W0FhtWm1wSaR04ZAIi/jPS6H?=
 =?us-ascii?Q?ZDQ/HgQQNeXiE11wfAZoXN6eaQSbiLA427wviovqEvWFLI1bD8Ri3ZVKC52s?=
 =?us-ascii?Q?H/nQX6sO8zdw/6z8zC5II77p/keAOfmdMUXrsK9gPDeE8hBBN/lv39RxkogF?=
 =?us-ascii?Q?P0WFDiB6wS5K2ElDFWWCUqmFRX6SqQQXslEl3ObUvFfG+gYn9ypSXTh2Kjfk?=
 =?us-ascii?Q?LFufkdpo3depAVYflGuTdWIJzZowPx7Fb0o7hWVKerNbQroPEVVhNPo6DkP0?=
 =?us-ascii?Q?8Awk+JSuqkgavf7rqo7UojvJ+b1XGn5tI4HcZFwbiSEJtw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?05I+67GhM9RWk1L9w2oaV43+Oo1kTSG/aAG8WPgP2W3a6F9wteLZb4047IcH?=
 =?us-ascii?Q?Ll1kmAhA4/EczGOkbsdoAtZnwT0Vf9qkhn7TU5m3ox6LVv/AqDOhQww9D7bV?=
 =?us-ascii?Q?tbWWOZVvYfmfZesqbOrSTPAd4+wmfKahJuDWMbGJuMv8EAQDKrowiG0guCNb?=
 =?us-ascii?Q?2pCxX/YVOn1mQ6SUCT/azLsV4zYIyDRdy2YdnJAL9JHFiHSgcwoKUGZi3tA1?=
 =?us-ascii?Q?F6rCBUMPOjwPs6PIgRUahBaydqvmV5fZK41kt0EaG+AkTK4UIFfBlwytSk/K?=
 =?us-ascii?Q?UhZgD/O0uXiU9L74muzQiGlZGjKoBJURxypSD/n2iJw2gMy9pdTWrAuz9N+G?=
 =?us-ascii?Q?do0B++1RCCzJ2IIqcuSOTo2z86JCsSUTgXRT2iyhzv15fv6+POYvKsBBowUy?=
 =?us-ascii?Q?1Z8QFoeT2pwqMdINsAVV1mH9h2IuzoygqV+lEq0+7TiN0MgIvQwJ2vnoiZd2?=
 =?us-ascii?Q?r9sEahgm5QbUIvGllpWbF0x5q0qoNzEJN6LqCwJ33zvz19+a7w9GIm+6ScBC?=
 =?us-ascii?Q?kogzsTYJMEE3O37TNYoOsWem7LG1VBDgKmKtGExoVRGiHnwykSBwTuDocPQA?=
 =?us-ascii?Q?0z9poPptGvVEejwBCSpUNf/fNC48lUnfdCLwEhBLmPdwTsueanXqdRrgexDb?=
 =?us-ascii?Q?jpOAaHOJLu97Dvnad/y1tpO5YhWZJzHvnoKQg9LDSb5SkK92ycs0E2gAZURs?=
 =?us-ascii?Q?SquLOvB5zyhmdKahU2TV8oa2Jcm8tE+QkUfBt3BFI6yvikD9qsJ4LiG8cRb1?=
 =?us-ascii?Q?TWIo2EJdwq7FKpuNrwy0iTeUVtF1/OZNJsx8p3mYxF1TT7X9C1Cc7JWHDGsj?=
 =?us-ascii?Q?uSIJtTGnLZqpc9PJOpj//p2cOfPTLQfav5FWJUqAtuwlYSd2gG5BwnkZpOdY?=
 =?us-ascii?Q?nkcWl/d/Iqjv4wLCq5AUXvSsG+/MbtRn3sRgGPtjmMLfSTbGwHHyEZg5OmW2?=
 =?us-ascii?Q?LHU4QuojCEsJPM0JFAN0kTiq38/zNqTxcleL5W6Bu4qcsvlqKFDk3x3Ifrek?=
 =?us-ascii?Q?k4iVx8Anyqy7fv7muaAG4mbmO3vKf5Jc8xG3qghTov2P1ndiqRNkEf7d92Xx?=
 =?us-ascii?Q?VSjy2O70cdaocGttjv6u7S+wafczguo/IfW/o7f3dlySp+dh9YEW51rnja2v?=
 =?us-ascii?Q?tLzkLmF4UTz7BWyAKVV9rLeq4FQLh7OAWtIu43JyeXmyrQmLrAz/rHxyWEVS?=
 =?us-ascii?Q?fNMPlBKespEfdxDf/SnjQGBX7TkY/U3wD6mM0L5j31qcolNSzdC4UQrGl33l?=
 =?us-ascii?Q?xMclYtc2J0dk0ZP5Z1ppjtZVJb+Rl5mWcOelcOrNi1qhnPH1PSmNzTDN7YNM?=
 =?us-ascii?Q?Yaf6ctVR60KmFsYWm0FJoLW8D1QQsmQrplGPsh5NqJsnWf7W+TRZxVwty0o4?=
 =?us-ascii?Q?0ZZCnSj2r5BHUjwI/mgYijOzXsZw6eggYWzYc9jIqytoLb4kuzkn+kRCv4BH?=
 =?us-ascii?Q?5sv8zgq/CdKSK5upCzooOLkGpdhUfSDCY4QtDDDXpo1BeJTQidI7QbUy6zGM?=
 =?us-ascii?Q?DOZktGyA2GdBdZAGKQaCdx8ypd+jN6LfU4hxixBgsmLvm04zb9+XyKqrp660?=
 =?us-ascii?Q?ByV+6UodzdfmBlsJSGQjAVKZTODd4VgTieWqwa5joRKc9EN/hzcK+8j42+EP?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1a05b5-7eb5-4edb-3768-08dd0fc4eceb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 15:54:22.0802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddOz6mE87UCkFyZ6UXKxh97pEGaYVNTl6YfFTVi2cNElupDOTUT95G5eIZ1ComyakHWvzRBCQFHQzt+8qVFmDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7626

A Broadcast Sink might require BIG sync to be terminated and
re-established multiple times, while keeping the same PA sync
handle active. This can be possible if the configuration of the
listening (PA sync) socket is reset once all bound BISes are
established and accepted by the user space:

1. The DEFER setup flag needs to be reset on the parent socket,
to allow another BIG create sync procedure to be started on socket
read.

2. The BT_SK_BIG_SYNC flag needs to be cleared on the parent socket,
to allow another BIG create sync command to be sent.

3. The socket state needs to transition from BT_LISTEN to BT_CONNECTED,
to mark that the listening process has completed and another one can
be started if needed.

Iulia Tanasescu (1):
  Bluetooth: iso: Allow BIG re-sync

 net/bluetooth/iso.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)


base-commit: ad0d88dc33bb226d530886e2722e8eced0db49b1
-- 
2.43.0

