Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE32749D2
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497930; cv=fail; b=pd109DR8WnJVLMU7zGFfEvUMdSNPFMRoQwW2KCRtE3cq26YVNAbsvA+vzDgUOXfsf9QV19rPRkWwWehvpIYzxqZWuoanE1u/wm6/hSFRUosWGBiAHkBJIi18BLZpxR6Tg/rmARy/xv2ibIzlwYDuMHcwm1Ocs5ECRSioEOeX6Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497930; c=relaxed/simple;
	bh=PjD/75/WAON8kWTTnS4Yj6pyzIAun57Ahd4cHlSBE/o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FKFwdT54oGpKCvkpIzZO6PrfG4w/5tYLCSxS8G6djyNfHkf18iC7JEIx+Z8zRHOUIZY4Wi44wuR706cSMhvdOBjtCdobqXnl5oPSDab9AH8jM/0CmhCnVWXBxhNUrDDgZdGqvjMQ5ymXfkOfNsLHn5zLg3njncElvH+3O9T2VuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SfcdtuCk; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SfcdtuCk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oELknI4iCNTG/H6AaZ2niHtaysL552OJkZ05p2kax4nUni9uPbA2Rmm1jfPY8RTXY+xozI01BfS3nLD223B4sWYO6KAtWVrPCvniEDnPOWgVR7v3w6CKRtes6lIWb7mcV3Pp5EgY2d/bsDrXoduwZ3b3isApuMnXPsoB7MfOwmo60uUFROAPvERbiho2O+QCphYkgdQDsIWWJ07jLM2d4QztXM8IAbMU8dSVwqZTGts3dZB+IkxJARD8xoKGodbixDHzJnXaCX0wjs8azKhkR6fbz/tetwitRRBCl3FYd8mbh8OsuY/oTNRvffz9C6e4YmdpWB2ub+92by3aIi2noA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuDO/qT8iCwe+EjoR0KGzxP4Si1yF1CnpqM7eMEZRAo=;
 b=jLVVbdQy/Eo4QM+WcNX02ArkN/sZMP3gqjiN36Lpzd+vcO4X05HfLZ/YPTfutMLyKIXQ/jVrKi4PZNV6WU6nYQ/kvfQsdNQPeDdAd27Rj0XGzxv5gE3cFY7+cGlchxYvsxSoXJYQuL2zUWTakl//pPsootMhQ6KCVQ+qMiWEyTRL0zVfldSbt7c9hhtZ1WNa2Qu+lL+h3kibcmRVuTe+evU88cWRWzb6FRaHMLNVKmnMpiEGRw4ZkyTIEkiYMWY0H1TVkFmKfu35pa0OW5vIaXuVzmZsB5F634k7IiopAhVfyTYdlZ2ZTHslyH+BwfuIw0EnUt5S+zKu1WTrsXVRGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuDO/qT8iCwe+EjoR0KGzxP4Si1yF1CnpqM7eMEZRAo=;
 b=SfcdtuCkc7Hom6kGEfkII5WCoLwNR8aApq5iU8U895s6/nyWdog4KV6KGkOQ0fOTw6l7nHLszThcbWPvDWYg4XafpYqZ6qQeM8s452ArLbpZykg6gVoW9MS4bmeLr4mS60I0JDHz28DZsqChKfX/Iz9tXjmRvRXtYEY6+j/IOJMQLssSCyqClvgEj4emnANqfdfd1XbNjX9+qOMWr3X8YTeg6DyoOfrJcbVqb+JQI3EmJMAFYnqk9+aYWCZlpTAJ1AsLfADoGGodbpTdhkOO9uCt78mcunUsRzHUqih0e+ITA6K3MuMaerZ2wWP0gjUEe3uJmaGcH2W6fprqB0nfVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16)
 by PA2PR04MB10132.eurprd04.prod.outlook.com (2603:10a6:102:407::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 13:52:03 +0000
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::8e4e:9bae:9fbd:cb52]) by AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::8e4e:9bae:9fbd:cb52%4]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 13:52:02 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	vinit.mehta@nxp.com,
	sarveshwar.bajaj@nxp.com,
	mahesh.talewad@nxp.com,
	devyani.godbole@nxp.com
Subject: [PATCH BlueZ v1 0/1] Fix heap-use-after-free in setup_free()
Date: Tue, 23 Dec 2025 19:21:32 +0530
Message-ID: <20251223135134.706-1-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.49.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0343.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::12) To AS1PR04MB9630.eurprd04.prod.outlook.com
 (2603:10a6:20b:475::16)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9630:EE_|PA2PR04MB10132:EE_
X-MS-Office365-Filtering-Correlation-Id: 53342e4b-ef8c-4fa5-9147-08de422a733c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nTCwqSUaGNzsepOzuQKE4a2RZfjL6MN3j4xDqT8W34ElDDfLwJDJR4J0SoUh?=
 =?us-ascii?Q?bmfh1luEyGu3QUxFbjbb7d+suc+2uRWKj7A2MSSavPF6wu1te2NSgoycRi5B?=
 =?us-ascii?Q?/5T4+TFn9s9me4JgE4L1TfqzKfIR/4K7+11jtnUP4yRcEiaxM7k9VmNhA8LO?=
 =?us-ascii?Q?iBLOknhdmV8ac8wmGFtVyHTQvh0wLyyrnWo3Gi3JYoEed73VZOZWKbwMDeD5?=
 =?us-ascii?Q?uGkQPO5KpIJAYLd7LAgk2t5KECfn9gnfKOtvwbehPQagm26XsQUiIDHXeCQT?=
 =?us-ascii?Q?gy2Myvq1CBtSJ+uXMIGsH0ZVLay6FxTcV2zkHUH1i0+Z7YUkVx3gk5SCu3Z2?=
 =?us-ascii?Q?76IYblRD0MuX4mdvpaX7obUeorDCUWTv8TP0O5/JsoBV395bbAFendDyTm3G?=
 =?us-ascii?Q?48Au0j3J7kx12Axxrab68vbRjlcBTMrV7o4vHjempxd5qKvLLLKv6zZMnBQK?=
 =?us-ascii?Q?FD4CT3pJp+ogTsSudQjhqFLehsuOsJklluR65MZrJbjAOT6ytCWYJUf/i6E4?=
 =?us-ascii?Q?eqCHb/YwPvS6iLA0nqy7QFAozaJm1ikrTzxLyTcruDVSS/mdO7HTwpFFZ4b2?=
 =?us-ascii?Q?2TP3ZPlM20Ok3CTpgMkuNfhfn/w64eXUoVDLpGyY0a3MGFbchNeQ1D6llVsA?=
 =?us-ascii?Q?qF5s08s7uL24LQ16egVlpoErgfLtoMbs7KzwbrclTrTN4aKDcRvnNvuMO4ch?=
 =?us-ascii?Q?eVQ9f+YyE2iDJOOldnltTduxYjpooEYf9AGhMCEqYTWMUJmXvB/toPO49ws6?=
 =?us-ascii?Q?Bn2I+4G2Ox2xjY/En9/uruTcTOc2wMpInUtAepx/wUo1XbaZkdZ5155urLsD?=
 =?us-ascii?Q?HqYSZDEE1hMnJYR3PKllWyJ9LTY2Pmh3RyX74se64wNLzvr9x64Xe6E8F61r?=
 =?us-ascii?Q?N80qk6wf4SGdOaSCA751zwT2ghe9azCp0OZKNNbzAfxJVznpT7HwHzyJbV4K?=
 =?us-ascii?Q?t56mTfp98cdABSdUO/7o2oZOPXmfF2Dj+BKiQFzpEbA6Yw+qL2yvCfsPDF+g?=
 =?us-ascii?Q?rfp+19jtG/MBUuxDQeb33MPIlGkscurh4H1cibq/k35MsMhBMBDJaTH6YCPv?=
 =?us-ascii?Q?MkTxaFgmJUmfmPq0LXtUYtOsJcfqH5kOhnjBZ5CNo5Da+mjt2WX+wIP/hCYY?=
 =?us-ascii?Q?VguRMJsN7m0buemScZFiXDZxn/QU+m77jap0GstBB22T44oML2yUB25phoDf?=
 =?us-ascii?Q?eGfRTVkXkyMMIz674fOgOvtARPdxx4hePaVR7wnJoZNDaQLQMdxiaWr53rh7?=
 =?us-ascii?Q?Ge2xAh6HKtGokg19H0mMahzo63xwCWwR9lBaS89T5LPAd6ED/5qpbttSv1ZQ?=
 =?us-ascii?Q?aPcKP3kOVk5wdp2IUiYj9BvSCAf8E1hAft9jwmGhhcD+puE4qT8m+AuBHFTI?=
 =?us-ascii?Q?ziL4VPfEW+YZHkYS2mIYf5bvPbCBBPBQMv72QFPFdL9bof5HT/lFJFeO5cMa?=
 =?us-ascii?Q?oXs7WQwXeR39ERzL4H+8eYS673HgGw3QoAxjIf0+CE7199qH6rll021rneA5?=
 =?us-ascii?Q?G0SibPe+nYqQCFypY9LKy+PQg7K7veoJ1o7P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qM6+oPUKYPaoEy4+mfUz8jbGtNTpSv5JDL1qceKnZwUpIDi7oFTc/hmpHLU3?=
 =?us-ascii?Q?vj9LeV0CaR8jBOqtNlP5pj4UQAsKZ3NLqI0fes9fPSaGKYvhOyIcxmrmYlCB?=
 =?us-ascii?Q?TUZpXywqMFKNNe2JEBHaE5+a4/tdnhWAtbIblFTR0qaBZfdMdTA09rImRo97?=
 =?us-ascii?Q?hgTOMzq/sf/zLfRjP1WcnLtwkt3qIdXN/XtYlEAaJHaIGcQ1rWLy5UIF62Bk?=
 =?us-ascii?Q?S5GPMcXKm6nYKWWMrteHTE31HbclL76RjEmRUBPxhYLppaIiwibBvcMG2DN8?=
 =?us-ascii?Q?RXgKNwcKOZhB+kfHwvD587BEfJZnSTfjr2RnPYj9JdS8tOOKBe51bS2BnEan?=
 =?us-ascii?Q?H1yDB/KDptkC3B7rxBD3cl69BMSlmjyiD3IBvrNS071C1sjT0d0HcgEiDNbz?=
 =?us-ascii?Q?RAkdPE3E1zJpg3nedx3R/y3Od40fdkjkJpMFxL8OqmxbeZ78UFnvCZVPVdcf?=
 =?us-ascii?Q?D65gf932VNtsCZk6+5BTJA736kxqFAqCVmHI/SZY/yZKhG1S8YekMkfai9Ol?=
 =?us-ascii?Q?1/Z6fbJO1k2YGs3cCiYp2inYS59cWfR94BkLu233fxOR24E2niN8y6DpBSfG?=
 =?us-ascii?Q?VqvQjFsua0NyZ0N9JhP21Ao/rEy31f9dDJdCda5IwR7vqZ5REAVS1fW8BVEw?=
 =?us-ascii?Q?awodyCO/+TkQjMgPeNJXKL4G5xzy38v6X8fLImgEv50HctEyhCj8y+gZyn9x?=
 =?us-ascii?Q?j41FN4z+yqG73/7d6fZ1OqzpjbgUwRAYeVpIT38pxaWh4DChnfNhhCg1NWq8?=
 =?us-ascii?Q?NH+5xHoHjHh2txAf89aSjy7JMqDSN6iWS4IfSEeBNPzZvMNlIMZo7rkG2QgS?=
 =?us-ascii?Q?PQvSOgod7brFHXw8FMoqvNS/UKYNIMYyo3hs/tUSzocBZaFqNSPwOQhVxMpb?=
 =?us-ascii?Q?uPNYjmEiWqBeXHXTOPXO3m30X7GiZ7X6UIkHO86e6yP5UIKM9ohJ6UZoOvOE?=
 =?us-ascii?Q?EBpBFtyo/fOPSXsgCDOPI6cSQxo15eqU7ioBS/TWz2AoDUIx4o2Yl8otD/r6?=
 =?us-ascii?Q?1B/zW3vbWax4c6LrgPldY05tc6XIXinTPk/0rwydcTbz5x5XZ90O7ibzSXe8?=
 =?us-ascii?Q?u4dOnfhnio0osqEb1zPWQQDSAw2cIXBs4CxamX89CZbBwmzWdZXP3dj/1lVk?=
 =?us-ascii?Q?Cxq5fKB/Ipxg4A02nEcOIPNpKVMZBraJ12ViDkPXVMXwPCjkCPl7NiHq6vk5?=
 =?us-ascii?Q?cv0EtcynA3BsSWqWflaSHq7elDrZvq12v4FsD98QF3mGVHwYISNbd/9tP0sg?=
 =?us-ascii?Q?PUEcUO+CwWAIAp/RFT9cvLlSEZZCVfZx6QKiorBAQdmYNPrPehPpIVCPlITz?=
 =?us-ascii?Q?y5AuuxtcF9JfmDRWAMfwv+wSRO5b1/houI/cGCqzD8Ym4eDpi8MfJB9WMS3z?=
 =?us-ascii?Q?aKokeRmeXGwFoFJA06y21OTZLqui9hH29a63jiYA8Tuv5NsFu3uuqTbD6wPc?=
 =?us-ascii?Q?HqWzO4Vg8Rdv+1IqcvBISxlkZKBbT1u5TYfi6sUNyEnoqkibI5u6bUxkCpK0?=
 =?us-ascii?Q?ztSioY1K2ZnAOj7R7MccAChb1GF5X/rReKDjIiTc8JstMXNO75mtFoGCACpL?=
 =?us-ascii?Q?fLu5Ya3MeLAon89aFpzYzswXpJw+sCvQFWsAuHcRgdDqau4bRTdMZ2OsJHs3?=
 =?us-ascii?Q?+k/3IdKcloVRvTGAIAHgo7C0vLpHkkvMr6mvQDWvAwtRuYo/lLrKkBTajltb?=
 =?us-ascii?Q?iMBEUhwGmsSLsroaa4SPCfKZ62i7mPICq8YiQmY9HilbigqH9FS4hKe7WQGk?=
 =?us-ascii?Q?H/MUavjTellQi9Gj7xGqNq8nPYjXKkg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53342e4b-ef8c-4fa5-9147-08de422a733c
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 13:52:02.6826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xLsnMrp/vsHicy30nH9PO8y5f/LVSjvfbstBhwFvCsUyRPpmjU7/rcbRp5lA1JKeTTCp3JNjDAGGoMhZPr8zceCht6s8bp0u2UyYccK4gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10132

Hi Maintainers,

In the current implementation, each broadcast setup maintains a
pointer to its associated BIS stream. During teardown, detach
procedure frees BIS streams when removing or disconnecting a
broadcast session. However, later in teardown sequence,setup_free() 
assumes that stream is still valid and attempts to unlock and release 
it, leading to a use-after-free.

This issue is fixed by skipping unlock/release in setup_free() and
clearing setup->stream to prevent further access to a freed object.
This ensures proper cleanup without triggering UAF. The fix was
tested under ASan with repeated disconnect/remove cycles involving
multiple BIS streams.

Sarveshwar Bajaj (1):
  profiles/audio/bap.c: Fix heap-use-after-free in setup_free()

 profiles/audio/bap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

-- 
2.48.1

