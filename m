Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF2852F86
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363961; cv=fail; b=QQbTOQi6PD7tAIuCUKEWenruDRr21ZycJSfutc20uyTeDBroE037GmdOH/mknlrMkaCgKRWVdyWpadfyPDjFA60UfJnu0ba/5ID4kUuDDTwpcXkO5u0LWrwkwkXKCLgmtu3/yQpuOZZNI2U3ygvQ3uqA2GM/cjOsMGWLCR+yh8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363961; c=relaxed/simple;
	bh=5edpZ3Jx98E6aXRdNLno/ok3q++QEvlDdCSnUb+6dq8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ee/4xsQfbhZisGhxvc7z0f9AQYeccKcno5a3STgvczOSzpoqDQVToE5nroJvQ9rBDf21MA1M6a/z4q36/B2LOWIhnSeiCfuMu9IaGirIP2YJGxIvnpI9m7RfqIi68rwifXaCO0icDtj0r7mQmOs0nq9x7yDijj99kO1HMngu7zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TOCPAcho; arc=fail smtp.client-ip=40.107.7.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TOCPAcho"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyxOFBW9RXT/LDwRST8SyTqw4MwV94jRPemo9oPJCnM3HO4Kk58328lGOTjN5YL0KdXyJkLoeiDdtsKGnDnwq32sGKcqEclugRfhMyNA+9GhorOr2umjKyYSrfBSJrDH+qBt3zrJr9kK5/hqpMvrS9wCMmvnlJ+WoQrzd0fLfdNvI0Awr9tAtTxeXE3b4Wd15UQvJjvS2KUUWbUCWU4b6wcmSPF+3SWXgzHKPAsuiuiops2Uwvdt82/2trIOjkuwhVLtD0I07BEGgAt5d9pUHXAVS04jqJwLVbTp3dbvUDBHVtv12mghmvlCf6ZFz3HW29Wznd48lJeTEZocMDiJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TtX8e0PcaO04jAERIAn/ZrWaCt62KFAeiuZeu6SdOM=;
 b=bBOdxsG6S/iqI3yw7cWTr4+kx3QXCm4a/u/uxJR1j/4qe75w52ytwV81AVsKXwRYyz5RAApffruwUFKns5l5XaT87k2c2EhpfmnIxvWK34mDrE8Iob9FPZMkWHP4HjprOFcb6yiM64cKJR9qz26y0PhpFnRot83xo86ziKbY/1TySpe3KH6LKX+VbhaZQg8HtUdqEWJaz1tHV2uDkdkPaSTcEB+yWUxdwUpL2FORvMNvYMPm9oLYOrr3j0xe89uaAA0EO2Gvz+M7KLU0diMJYwXJSb1QCmnvxrfZXKVHpgCoMxtMJeckinI017lzjvVKb2vzcYSXYCRX4qpOFcO9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TtX8e0PcaO04jAERIAn/ZrWaCt62KFAeiuZeu6SdOM=;
 b=TOCPAchoVvJ5LeSUupKbh8jR7uj3/cUVtSdlwM+NlFtMMbLF7Cys6769LXQ4h+AexrwhPxF0xG7NNF265NxdM83ad1HvvTFu+ju2kTqZVXqEo3GGpXdW7kxk/piv9/b6eeYMLjmYkTvcRz0yL150x0AenNT24FyfzMH82Kj526I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by PA4PR04MB7504.eurprd04.prod.outlook.com (2603:10a6:102:e6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 14:25:54 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 14:25:54 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1] bap: Replace global bcast_pa_requests with a queue for each adapter
Date: Wed, 17 Apr 2024 17:25:36 +0300
Message-Id: <20240417142537.6523-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::16) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|PA4PR04MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 056bb638-d9a7-4f24-9016-08dc5eea4a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qLpT80M1dXyAfJ7DVqpplwVIMmNvRBirht9aUQWuIg0+20BLFTJeWCp6mq8FpZiwQmGU6U+Itjq++cC2GXyI2V3/XCgeWvAw1OgLhD4kHReH7p2vKlJ2uA4xV+w5TUJxGM4ZNVPpItS8t3a2s4xKjNf/PB4HtjRm2RywrU9pmuJBV69ywrqeJcEXVqNLalY2DZP55GrfuRA1XUzSq6UaWjPkIug8JMP+Y0DkFjFyb4o2GKGyf4ul3d7wAQohFPNpIL8tVIn4C0JKF+tBT424ZAIZgW7DJKYlQjBow8e9OhHOfPV4stanqr3tTvNN6cA0XImrqC5oTxGJi9996uJi5Qy4fizpEr0/e2FGmZzZrFiGoTL7LcHjAlBbQ8KJK/qA9O7bCKKM4KK3WGC3P/Tp7K931CoZXVfR7Rz34eht5ABHWgvjtgUhJ+MfaAC1NlJ5mHPdv8+Wm+MDE//2OK4ogZSCJLxH251BTfMbVGmWT0il/WYTJxrmJRDN6SLLHEnZ7gw7mkjXI/knWLCTrTCZKvm2B8tpLTGi/QPhu/bWB/CaRLur8iwXKNuqQyCnxrZgK1SUtOittC5UQuAb1RafEDYaOou9LZ0oleYOcx3/xNlZBy+xiBylw/T1MXKha/uqXxMC5P63lj2UdRKHs2wbOI1PwangQ+aOFiFSrAFaQdZ9IS2T6A4kcrQslY0dD1H1GpQmpyL2aKF1792U+PAy4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1+70i307ho4M4zCm57B7bGv8j9hBIBh3W66uCxLib12K+q5itDQ1pSlVP61t?=
 =?us-ascii?Q?BfJi4wTMcpLNJ3S4YNIta1gy7/e1rM0Xg4h7o0YEcfUgFpSYvZYIqcWgYOhr?=
 =?us-ascii?Q?f5ooEM56+RSKbFVyPKN9z4h+2AZxEqJiDtcfSr0KtVG0/HDOmXO/9FyS7+aR?=
 =?us-ascii?Q?NUrzJcEmzmf7DHBzEIPtEXx48rxzA0io5LhIiU7/JolDVvQ5FRr2eH7DFO5O?=
 =?us-ascii?Q?9xTpTGUGDcICJKZN+MkNV6xaBL+UWFVetg8be+Hr1iNptJX1Futu4ZHI0oVa?=
 =?us-ascii?Q?hn8cK/0d78dELZLQeghFzo09TG0uE5GooJfN+qWT6wkGO1LkB4jD7k1pEkwj?=
 =?us-ascii?Q?xOih556bkdwD4jAY2yc5OTr+7VPHDyhiRR3I1Z9DxehFkKpDJxCPJ4jAjHAz?=
 =?us-ascii?Q?pHImfW8/N2gHgNfUd8g/P+nWAA9+by7n69rxzlsq11gGl9R0C0f1hR8lkg3m?=
 =?us-ascii?Q?4FhBy+jUwIx1A5MtonyVuqJUYgLyKiW3AsvQwK9CbSA8jyba6dQvPQmQEX6d?=
 =?us-ascii?Q?uS1t7eFDgArLPq3QJAdVVt75JCa8zF2ru45YPEVDAehRjACic60oPgloBzVK?=
 =?us-ascii?Q?H3jAnSxkNFOudp3ffJdYCZ5no+EuS9JmfHCvh3Q2sdkq+LY+MjDJXk49TzlZ?=
 =?us-ascii?Q?nmlRNfVxKkr2KYbeeyHFTqDS+3XK23ajB+tqTTgj73CJNOcX/4nxxzOASjJC?=
 =?us-ascii?Q?J4E3BjbOXNJuot5jUIH2cI4mPr9egK5QZNwvywD+tas0qfwFY+K/pIMikTbw?=
 =?us-ascii?Q?F4of0iZWOn3i8iaJz+pjWb1siIi4Iz7IGbbKHnBf+BlOnXSz53JFTG5VPEGl?=
 =?us-ascii?Q?35mD1be+OCwHApIfCiNDtx2pJ/MEragR3TYtwd1joQkuvlev1l60ktc7aCJE?=
 =?us-ascii?Q?pb8Vo6GzQOdjALWWAUdEK40ojx727k9oKYWpT5plOkY6Ta1WBJHOmEfOsoGz?=
 =?us-ascii?Q?Qylu4NFAmxBbxivQZB+nfXtLAf9cVCZJtG2stkwMvy96JeyGy/qhK19k8BKh?=
 =?us-ascii?Q?QGpV4iDu3FRCaBr+0ybYk0yAHxJB81sRaa07vNK1QSW7zQu3nOR3LkS/A5UQ?=
 =?us-ascii?Q?Al1gfhBgfR+c4bxIjj+3T7aR+B297er5k7TV8jAtvwkOOM+WEb4cFf3M7hxj?=
 =?us-ascii?Q?SZDG3978I+1/xMcRZDGzcphyfu1gPZHnRktR5RtJ+VH7pi11JOGiybEv5Sm3?=
 =?us-ascii?Q?RZlN6IDOldPuMJF5Qdd43slnuw8prPEEp1kyamahq2x4FbXwpedn3emvxKW/?=
 =?us-ascii?Q?CmN2+Fgr6VfTX+fmGNm/qONjPlw+Ua8+eQF27Lpp4AOXa1uoRAhbhB0PRWck?=
 =?us-ascii?Q?17smnXoVUK9D6b69DN+B7Ie9QKnlhbhSk+j871Hpxhyi0HSknThn7yJI7Wud?=
 =?us-ascii?Q?blZUV2lRNBwXLmL12lSbSY7PvT6v/g1hW7I8CN7aNUC4fsDxe48YNfLl5O3K?=
 =?us-ascii?Q?Rjx7B9L8Rb0RKOtR1wb1AjMb743n9JR3Kr8BWXrz2cEB3my6HVmwANecOMSV?=
 =?us-ascii?Q?YBItvpw/YTlecRIodMjP2ZMoOmBHw/6IklkV+FRaMhLM9q1h8G4qAeerjNf+?=
 =?us-ascii?Q?E2PEZXvAmgbMzObfqh3z8RIynVkMHN3KImowbbSR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056bb638-d9a7-4f24-9016-08dc5eea4a68
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 14:25:54.5377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjmpWfVI0BfmgXdHnGDPA+bsXbWTJ8XTkKRd70AYNLiwmHdrdWfwfW8TIHfm/SHyusEyITLSPxGu6YthqEedBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7504

This patch replaces the current implementation that uses a global
bcast_pa_requests queue and instead creates a queue and a timer for
each adapter.

The queue for a specific adapter, the timer's id and the adapter's id
form a new struct called pa_timer_data. For each adapter a new instance
of this struct is created and inserted into the global queue, pa_timers.

Operations on the old bcast_pa_requests queue have been modified such
that:
1) based on the adapter_id, the correct entry in the pa_timers queue is
retrieved
2) the operation can be called on the bcast_pa_requests queue from the
resulting pa_timer_data instance

The timers are created and stopped on a per adapter basis. A timer is
stopped if the adapter's pa_req queue is empty. A pa_timer_id equal
to 0 means that the timer is stopped.

The bap_bcast_remove function has been updated to remove from the
pa_req queue entries of devices that were freed. pa_req that are already
in progress are treated by the bap_data_free function.

This patch also fixes a crash that occurs when a device is freed before
the pa_idle_timer handles it's entry in the pa_req queue. The following
log was obtained while running an Unicast setup:

==105052==ERROR: AddressSanitizer: heap-use-after-free on address
0x60400001c418 at pc 0x55775caf1846 bp 0x7ffc83d9fb90 sp 0x7ffc83d9fb80
READ of size 8 at 0x60400001c418 thread T0
0 0x55775caf1845 in btd_service_get_device src/service.c:325
1 0x55775ca03da2 in short_lived_pa_sync profiles/audio/bap.c:2693
2 0x55775ca03da2 in pa_idle_timer profiles/audio/bap.c:1996

Vlad Pruteanu (1):
  bap: Replace global bcast_pa_requests with a queue for each adapter

 profiles/audio/bap.c | 115 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 97 insertions(+), 18 deletions(-)

-- 
2.40.1

