Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1F18CC1F
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925159; cv=fail; b=ptgog1f+JxNe16GLSf0Ix+I4O/AZiAaLBAcFTQYf0O4kVvkYd/X2265T8IydAp9ao9sZXKF5qBRieA1DPCkBdRdA3RSjNOn2vALbBSOxIecs8PNK8VjrAZ84yqUhwAnY67MYMgeuVLrcNlLOqaprKVGLXLJ+ZdpY9bdx7H66WhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925159; c=relaxed/simple;
	bh=m4k/wwpAyGPPCgjaAMfoUew5kFtCn+XdNuXiRmyVp4c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LI2irdW1wk51DeWlXKwdVxx+FuA/Gpwn/OUE4MzW+EEhT4NGUTTR5lWrfxVKIRgTBpDVYIHIlwabEfFPw5vw3hrdvS2Roj2hHX5B3Cn2Y4y5uUOTk+o2rRkwQ3IH2ZJMnwlx6HpsDlzPPJXI/rNIWSNq74k80pZCjsAsW44CNIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fcrdpqeD; arc=fail smtp.client-ip=40.107.105.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fcrdpqeD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9tSQgapuwGH5gMgr0lVdpHXzEp3mlPOXwHVqQYYz6locX9isLsg5nk0QhjnWl26T7HvpxburVgcg2FPM9atlJEvZ9c1mlW1+kFGfXfRZnKsAvMjxutB3yEu6uJK1UW5E7Y4Thb7/wwa+O0i05Y/dO3qvZWvL36zMDJMSrdlqoo0X2FifbtFfjOI6MShMP7UFIcK20RGRhbv/twuQqnXTQ76ubVBN+k19gCTGlgdY8GFnFnVxmErHOk8RF+39Ug54d/j2+hUdcYepQRl3PhoI2EPxgJT9w8mxhax5dUf3XdOB14/JMYIBIbiZt3eA/5G1ofZm3jJ8EdnmCAIw6Re7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7iJibOrgp9Jwkfz3CciGP5+1soUDFePeQQW0ENBrjA=;
 b=RaOwtdfMjvfw3NT5pGWe69dEr93IJa/tkx94BGhGhAV7Urt31wR4pfFDz10gYaQC6dbBJs6TJQuwBwgpSRDr1ZAVilTcN5J16zIuheICFi15DR68aTPwOS+zQDbdFGIILvQCEuI6doteMTrXI7pOgPsGmKnb4x3e+XP4omMW7RkqMkuPn1jSEVK9NLBs6aO8UF/qYbOqAwEx6fXkWZYbu77y3E/xW02huOQX95A2Onb471nt8Bl0qdE8u1EduYPea22m6zDJuw79kEYTqP0H+vVSVmIPTW8gX0x1YgkK6Iyu0BLHtuszt5HdJoBgdcOmdRhMmLEx8X6i6mKc6KSmhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7iJibOrgp9Jwkfz3CciGP5+1soUDFePeQQW0ENBrjA=;
 b=fcrdpqeD8V4WHPq1rfyvvUehB/E2Hit22p6Wh8AHZcuj5MctLWvxSp/LqE1a/lORR9nx1hK1LAdLUI8Jx3LLwlfh5QfT6RqXLNz1k4yJvWEesf13asC1LB1nv+VHPQZDspDdOa5gOKdP8saHvNedTJ1BfRzojsGmTgWUqDwPs5ws37rJfSqryC2eclLrbLuMYSmy/UKuFr+Z5d697KiVHHvzAylLHlpOjZz0jXgUrwfLA0pmrUCkbjGTX3l1z+xHTa5HcmIqZ676wioLTFLkySyt4ytpS8m3Yq95OYfqak22WL71TCZFI/s02PHdZ90Tr14idcUyIjzEbI2giOLIiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by AS8PR04MB7720.eurprd04.prod.outlook.com (2603:10a6:20b:299::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 09:52:34 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 09:52:34 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 0/8] Add support for setting bcode on bcast sink
Date: Thu, 29 Aug 2024 12:51:58 +0300
Message-Id: <20240829095206.91150-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0196.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::22) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|AS8PR04MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 9117e3c8-4566-4942-ddef-08dcc8104e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hWceCvMLBS8ILXPQ+zq/ii/Rud+iHhgBHz4OD5iLO6xOh5H5EcZ5jsv/b6Y2?=
 =?us-ascii?Q?CysDk2MaS+KxGtTcky9R41touOEElziuhLuOzwZpSAJu+7MbKv9Aw3pg2xY4?=
 =?us-ascii?Q?ut32OGbZ58qmRizRUyeI71rojEtLHWuB59rb8ei0as1TxMgYlnsIFat4jAYI?=
 =?us-ascii?Q?W+quN6WeYtDES8uj6bcanfbBFcBk5iVzoOACFUK9Mr//nn1sW5rIr29zWpgc?=
 =?us-ascii?Q?j61QvKaTr2SiP05Yj8KJM01iOg6vNri/YeRHoXJDBP7bPNrM4xxlHwh8G0xi?=
 =?us-ascii?Q?TJqfdA8LOtBs8ijapJ2t5k3JlZa9n8mB5kTzf2VGCSyopVoNvnwYU76HTmqX?=
 =?us-ascii?Q?YH/xd4fkX61cjXMTJyaPqLc4wpkElhMx6cw0OE25IeC2Rsd4uA6spp3i7YZb?=
 =?us-ascii?Q?YUdleZT2jMTng66TK37yelHrfsVgaa9s61zJMMCykbIpcqsl309RYtBjtjcR?=
 =?us-ascii?Q?8Wfi8LBUNQbLi6uS13jZztbvmud6qqnfvVTmkYXqDJloIjNPUOvnI1nJ9SBX?=
 =?us-ascii?Q?5G5ouQhTYqcUAqBX9fv/97rwm3GcbIwP48COwy8CxGWb0jviZToZ9KaUd9hV?=
 =?us-ascii?Q?0LOLGJmdt5kSGFbUABNvcjel827shFWLJl0QcSwQ3UQFhBluJiNjB6wT+U8T?=
 =?us-ascii?Q?nL7hygS+kjIAnhXtVFuTUJOAttHZ6dGxX8bWOTgcdcKIOP+/vjYCnopsblOl?=
 =?us-ascii?Q?BnxGZOdE32l91Hne63UiCrlcs9NyZMh4JGf5QKn1RmypFy/Xhh9gmDmrbpkw?=
 =?us-ascii?Q?3i9xyY0ngnLg3YzbFlc93coKvsxpHgqsbAjXttlXnFGUebsj97fM49Vo/Tok?=
 =?us-ascii?Q?pDmObm9lhaearluLLvqyyKur/MRGRC/uC/OJKDS3chiC4QyYlvktwlO7H/dc?=
 =?us-ascii?Q?67kwY1oDvfHjEVu/Zh/kHrBmxKY1eio91UP3nVFD6EOm/Yc3/AZ9e7BQ8pb9?=
 =?us-ascii?Q?ODRpt4AjpuvuGu24ClXSMQ5kHYLO8Z8XisUyV8elizUS0UtCp34VqIbXCrsQ?=
 =?us-ascii?Q?ya+TCg1AuPaklzl3r1x7ZtBOlWU2Aw0O8a7J6iUHobpAZhdPGcWC2suHy5FI?=
 =?us-ascii?Q?eetlx6Li+xqLjgh8fhRM3ubKhVau5ULcdrMc+xquzbp2C9HDOB/rfZBXOEZZ?=
 =?us-ascii?Q?SNRj8y0i1NN4qm/nbLsqc3HhJP3uUAW4mUGaSgFKWjvExU7wGWby1inf1IxS?=
 =?us-ascii?Q?eCgfzTaZYW8sid3kltVrYf4t5qTaEgeCnUgz3rVF7guY5rSdRWyM5MMfLSVo?=
 =?us-ascii?Q?s8mYRwzxh/k+LA7OLciy/VoufBIpZ/B9V7S6z/2DOJla5IL6veYVVhdDSIZp?=
 =?us-ascii?Q?i3yG90hLwcu/yYr59Ec8DGIOsdFhgSg3CSs08FDFyg94fh5+fNRLAbrB/eAE?=
 =?us-ascii?Q?+PKydHtZIaJ3l0d/4NdDx/2OmRbM0G1YKPotnQCG882PQYMcIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0BzeYQOfuqh5BZIitciucIIIVvwb8z+iUhag+Tarj7Im6IMxqUiNmyccfCz2?=
 =?us-ascii?Q?uoCwyVyhUeUFrwDmoKk+Qw8fX41qZE1TcUtp6ChhKzYW7m/ksRXPeEOdH9G1?=
 =?us-ascii?Q?tm7djpXgnqnoJYjKQ8QKWOLw/FkYfc59DL8kpTSVX6cpujUeAYm9fvKl64M3?=
 =?us-ascii?Q?6iLm7cuXG9amS/zEfh9RttKV5SFmX/O277rkl7vGY9bUqulhgCh8VHkaPWdb?=
 =?us-ascii?Q?pR9SEkuOADzUmsDf0bsf9Q0A9Ch+wHfjSDYOYidhzolvlS+fwmihhjcb5E8U?=
 =?us-ascii?Q?8PE11fhKipiSFL9kLQ69sdKHu4OuhUFNFrjY8wJFbMpsxddASvs0ip1gKl+t?=
 =?us-ascii?Q?xx48WmjSgDwzjp3Pwg+LJ3vfAiDFYNiYsJOwXXULCZQLnnhMbVEl2BupKKG3?=
 =?us-ascii?Q?8a+AvdNt0sCt2Qn4h4CxWrFW33nRb3E5bJjMtvH/4ZtK4TSkUHptXA1NDB1k?=
 =?us-ascii?Q?6VGzc7orxmUwCeRD/2pwtfilhdm+ZrXiaGUK9guRne2dzbQpMBenxt3sStI0?=
 =?us-ascii?Q?6BPyqnGWuX3So1qOR3jb0+/ns+7Eebmuv7I+e9HA+c+2KC5A5yLq9rNbzJlS?=
 =?us-ascii?Q?jiPccArIJb+wkGf1G8PQEdVkp1pycIQnT/1DA6WjPnPvMfoWZWOoSzdnzaGD?=
 =?us-ascii?Q?pW+OfNioROw7F6Xz8xrupIrKynZ/Wb7H4jHV2TUKC/exweqWDncTRs33b/JK?=
 =?us-ascii?Q?n/yATe7aloORjca+o1SvwJpWt/ooaYWYC0IfoGiDAQ5a2PrZCHeetvHbWwyU?=
 =?us-ascii?Q?l4hC85ZUeulL4/CBM8kXB50DRGDiReho+g9TnZyp6HebUqB04SY8NcwqJv8h?=
 =?us-ascii?Q?og5vO1vnhmmfSBAkRP3RydnZBE8BumI5sRUbDFjIl3CcofQ+Dohqqv7RTgF5?=
 =?us-ascii?Q?k1vjNyRL8buA0j9qXSAMl7KaQBXYy+sI8x0de2C4lradjapizEyogX7vnaGj?=
 =?us-ascii?Q?6zX49eiNgH860/wdPs5ZHFZ2QWjdTdhixQZz/7iho8HkL9Dejp/jyqtcLMkQ?=
 =?us-ascii?Q?a8eOgrDmRkMErwagSoyygO82aN1mErPyTn0Bbbc7Mj+HUs9NYI520lTM8Kcs?=
 =?us-ascii?Q?scJFawUXnOqfkZRti+HVrqX39kQpQ/jUd8kT8s/E6QNjeMl+sT7c9zG5MVFg?=
 =?us-ascii?Q?qDFO8JI2tQ+N+PVuHjS9oKBc26pL0bfkUS7lX+n7AKV7CUVkebtUygJhBruL?=
 =?us-ascii?Q?RXPgZAo67rqkIR64pAWOJ9QIsUlDN6Hwoc1w8M0j6REFLzxBaCnXtz9kLgkr?=
 =?us-ascii?Q?kYUE1c2a71YtU020S44TtY60PxIUMhJAL9/UAfA9O/pIIOILpImyGZw27Pqe?=
 =?us-ascii?Q?MejzZiy4rWVfCNIAohoWYsZY0gEiWeR28Xw/FOZptn2C0FeHuJkxM0Pyv7qA?=
 =?us-ascii?Q?1wGiKa7/ukawDN9mP20tx/61uFEB59doGuh34UI1qdirJHIZdzNM3KnJA85t?=
 =?us-ascii?Q?6Ocvs3/a3HRRGdqdASSWBPMgqjfqgSGUCmbPFGQyv67WgmvXdmcMeDR68dxD?=
 =?us-ascii?Q?1xA2sRF+DRsDK/I7wcImeGOEt8kzGklh+/uzw5fcjPeWkK8nX/8Ak/5Q+zqu?=
 =?us-ascii?Q?mS1V/NKMk3k4CguPNqoxui0BWGt+VUeAfWkpKkMi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9117e3c8-4566-4942-ddef-08dcc8104e7b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 09:52:34.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wdWHz3Q7bAuF0zSOJcylhErvkBqWkw5WuVBAykIvreySsEllZUnA+/51+YbZuxSNuUPO59NMZiX3qbXrvYhaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7720

This series allows the user to set the broadcast code before syncing
to a broadcast source. Upon calling transport.select if the source is
encrypted the user will be prompted to enter the broadcast code. Then,
the code is set in the associated stream's QoS. From here it can be
accessed by iso_do_big_sync, which will pass it to the kernel.

Vlad Pruteanu (8):
  doc/media: Add Encryption and BCode fields to QoS property
  transport: Make get_bcast_qos return the encryption flag
  gdbus: Add g_dbus_proxy_set_property_dict
  doc/media: Make QoS property readwrite
  transport: Add set_bcast_qos method
  shared/bap: Enable set qos method for BT_BAP_BCAST_SINK stream
  client/player: Prompt the user to enter the bcode
  bap: Refresh qos stored in setup before doing BIG sync

 client/player.c                  |  59 ++++++++++++++++
 doc/org.bluez.MediaTransport.rst |  12 +++-
 gdbus/client.c                   | 115 +++++++++++++++++++++++++++++++
 gdbus/gdbus.h                    |   6 ++
 profiles/audio/bap.c             |   2 +
 profiles/audio/transport.c       |  39 ++++++++++-
 src/shared/bap.c                 |   2 +-
 7 files changed, 230 insertions(+), 5 deletions(-)

-- 
2.40.1

