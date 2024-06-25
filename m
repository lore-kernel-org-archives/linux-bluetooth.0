Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D4647A62
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 07:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300442; cv=fail; b=lBXnWUFy0ZmLRDfR8+NM96lUY3IecYrIedOrZNTjy4xzoSoDKooIQhWPrxbKhu+TyXrzIK0z4ETv4J4cAMc15DxHK1tNh6A8yoDM/48tWepRMWYcGvSxisTwetKV+pTt/uY1iAd1ajWmbfMy7KTBSduI0Oe962iusRhrD7A/amk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300442; c=relaxed/simple;
	bh=ySIJkYtGBa/bVXVhTv3qoJLg1aEnb9a0dlUOPbY6jCw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=b+2EZueLudPRnJZU6Wr/OmUEsmdFClbya09fXRvL2xhcm/C+gCU9dMmgl+mFDHZvolw5y4IS+yJEdwCYsCdeQM2FlPlu1jqWC62Rmyd5bZHj+YPKStW40x6D4oZQ3Q101PJ5tc7GYzNvNbpKuitHQEjaRZhYN7CdqVGUgV1p1mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qvTNG7p7; arc=fail smtp.client-ip=40.107.104.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qvTNG7p7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsASRz4XtLagJuMqVktrDtpbjdlllxypflyqmEb0XrdUcnvqiU0xyw9WGU2gw/XtXs0S/lNmoF1XbTVOMg2yOwdpWchIDQyNMX1kKxN1X+JFF/ZAQ78h4RSrPBJp5b4XiP8KU01d0yrlT8uQELvMjapdKAErmAXrjlml/ppL9iRUw/FwpFEHodNHkNrbJ1M6p3GeQDQAKfFRpM4uhV9U/pF8xecYWUWlxv0NKjS5uRVtnNGWsdRfazwkKaYSuijMHlv5CXOZaP1TECL1uFwInRLDfQC/UbXjH/OLOYWSNj+e3isp8Y8DdDfdwm4PokxoJqxXsQQKUJJscG3Aoe0lZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3kI0/EA2B4MzIgQU9XZcvNlmnH/Y8xDbE1MDTCyKpc=;
 b=T+gt2AO48DZGuEZsXiLdakMHhsgZuCOSEUm/SXp+l4JXRsijQiMmhZIniDbnCIGe2OZKr6th2g+3fmONT783qnppoabnFdSt5+YaGcTq7dEkHtJ3xOJd+GDi8W+pOL38tQniw6rRmuk5qvX1tvdhCOp6YwxcKAMnMegL7X20h2hF37ralQmSdYI8Cp1JODnmXbYRCrStmuzweH1DBw4VTRz7dtPtOwU1GVN/SUZiHD7INdqqwJJIizG956TXl1bjGPowzf4Fizxd2hSYLgGcPFVnlqcGjkkONJeG8ZhMYfbgyVFspVyALKumczKiPNtcJ54p2bFRCcqvRLj2UsHL7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3kI0/EA2B4MzIgQU9XZcvNlmnH/Y8xDbE1MDTCyKpc=;
 b=qvTNG7p7l24t6nhB3eTl0tHgDlLwXnN8Pw+W4SES0mUZwDV14fJLGyYETJkkZxQHR4oUXJNyJuxv+uoSENpP3ST+7RBBFynrt++ohGfivxAsaiVdRnuX268NqHgdyMYkwQgiZMdVi/fFP6jv8+3g+zhzIPbQbSfAGhZOQlXvWn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB10431.eurprd04.prod.outlook.com (2603:10a6:150:1eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 07:27:17 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 07:27:17 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 0/5] test-bap: Add Broadcast Source STR MBIS tests
Date: Tue, 25 Jun 2024 10:27:06 +0300
Message-Id: <20240625072711.7011-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0006.eurprd02.prod.outlook.com
 (2603:10a6:803:14::19) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB10431:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c2cc64-e049-47cf-6f9f-08dc94e83de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A8Y5p/0Q+odo0s91mlDRPR8r52P9Cyrw/r9Rj5ljF3kEX+NYcbbRy7dJIIxz?=
 =?us-ascii?Q?haPv5WSv4NNXNdn+d+LhtxCMSdiM0UdQxdjI1uujZiPulyj3+qpbfIQe4X0z?=
 =?us-ascii?Q?BhLCdJw3munPwGjfvpsWoWEUoO9Nf22KQNdP044kKTXKbR2gtbBhFr9dx4vF?=
 =?us-ascii?Q?uncbJB4IR+AaY9BZtyjH13ZL5Rqgr7E/Y2OO+H6Uw+oePph6ku3hwWnYILG6?=
 =?us-ascii?Q?CCZap/uN+854dsXY0Mdc1gKcam4us0AzSUVCdWFxDgs+KsV8pMLjjVBG1D2B?=
 =?us-ascii?Q?QMiIhJRnG3iOyc0zsPIG/R5EZEsi6MVAmIyUkIrEhR7W4hH9VoxQ6+I0/8V5?=
 =?us-ascii?Q?9+LbK3YUvsnXJQkb+v6SCkXbsM0lR6BtMlIKCJzrplDDwm/aagETJlPtJ4e0?=
 =?us-ascii?Q?dK55dsswFXZHSnK2tb55mzFa8oMQdlR4450gi26/+qLE0hQ/4webeeP7Mn/1?=
 =?us-ascii?Q?MMj5Q54Wpe8cubIvJ8s9vJgTkOX7TEQkmjJEQokXlohiVmQxp+1moYc2otKh?=
 =?us-ascii?Q?sJ5Z6gBRHmnNoTAJBY+pZ3F3f0GSBGZSaDykAfMb2kNvbbDAGs6hgzUgn+ny?=
 =?us-ascii?Q?buKdpfJK9Idc3avSBtkJm+mXzfLyboKwykNwISE8rMpX3dPNNWgoIksBs+5Z?=
 =?us-ascii?Q?sdwWaGM9A4pFdA77wEAnyacll1Z4WQc82gNhfyF5/M3f/zlTC2IMCdYYm0qp?=
 =?us-ascii?Q?ndrtARqloiATcXRynYfFSw69WoYiYEgzskmcP4HwtnHxRTXyPxJFIsACamRx?=
 =?us-ascii?Q?ESHerfSsCQa4Ly7XiuhPobDBGjCH+vqq3up2iF83oPKTn2ItaNxl80gzdS6w?=
 =?us-ascii?Q?y4YU7eFy/ZudBpF3gWZ1o2fBoDvwvmeOlGrci67v3tannBPE5B/ULjWKcf3J?=
 =?us-ascii?Q?wvLVqmqFdcGicP8LxKiH1/K5ScBTjOaYOwgroPJNRsg5LifTUb7HEDBXJeq8?=
 =?us-ascii?Q?uLK9zbA6B17UH8uVVyx3KAHhcVQYSRhUYnJM4ziKGthvb1fJlfQgy8+2a/ln?=
 =?us-ascii?Q?0yNJEZgE9fAjc1IOh69MmcdTapDiJi11dcZ3uEQA5rzDLtkDtHnscenYnTBQ?=
 =?us-ascii?Q?V5KooZCELWvYNz0Zeg5t37boSOaXndN0K/tFRtO/XDnkfjBL54NOEDjuZQEO?=
 =?us-ascii?Q?g2RDkZhaayiXnec5bloylP117qe4VV0pCQ9f4gXAMyvJ38uSpP5QS+q1nptS?=
 =?us-ascii?Q?4mnvuRkpbYmdag2a3QQbaAmyl5icE1KH4DRGuhGAYc8lpTm/Sb+BAkYC5Rxs?=
 =?us-ascii?Q?ksuoILnoKVKrndaURW9NV+/GdwVnkEDrZ1jmGjweFs8OkTlsXyDfV4Q5k+De?=
 =?us-ascii?Q?rzQwAmCJyh5jWEOWDKIH/H2M4OMH+1bw28UebMTYC9kYGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H+H4vBf7VeuwA0lCp1AsHi1GWoPnH2TRucSQYkVmnJ9F2bM2C5S6k+fVoZwu?=
 =?us-ascii?Q?jgJVbI5zkKZZtmT2qZiHyAodICV01jgua6YcWSwho4/NiWj/yojgBhWAWw26?=
 =?us-ascii?Q?jv2Vhza63kwZM7bjhevT0rbSR477XI0CU4o9gN9ZsPIOpUkkEXUFQkQyICaW?=
 =?us-ascii?Q?84E2csKpdXEf7yFjegiFHLGbIz1FzRgzuWCQM4GJ8Y50N7dEznXlf0FwMbjB?=
 =?us-ascii?Q?E9/3tPcov5FP3/K7YoPi8sI8pBxCEc1sS7vNdxoC9Ba8Ce+EdmvKw9p5MCLP?=
 =?us-ascii?Q?l5yokhqMi/9Tbtn8AnLTXPSKNcyLqNLGtYMlqZSAI+u2b8CYDokB4vVTJKUt?=
 =?us-ascii?Q?2B/CbKW1ARwx2W7BYsCCkY26Q9GMp7ziL4KxKp0Cyt7M58oEuJ1frLRS42Hk?=
 =?us-ascii?Q?xtxbAxCutWDbuEyTdKFlxzzna6aNrvdISSW0xJRmy4GmNqINyUUsMhGnE0HJ?=
 =?us-ascii?Q?zhfhqEES+uienHckh3AG8ah2HMqVFGfWWIP5L5BAwWzW8qMzxFXJkBlIfHdc?=
 =?us-ascii?Q?D/h36AEplzU1QQwbbLWmZUd+cc7DQz/tX4RZ/YawiahmRkiAo1lg1LMs9Wy2?=
 =?us-ascii?Q?fTxHa+CXsbOLYSCrGEt8aREP+MukbEoAQ6YgbYh22rd/RRgxzf4HzJBpner9?=
 =?us-ascii?Q?PX8rJtrflgzNySnwHhzV0bQ8Dygg+XaPRtIJCWW4uDJc65Dhp55v6SshRHSL?=
 =?us-ascii?Q?KuKS4jZ06JxeeSQCXGFRBAgBzqX+wEt/eEQCYO+s8/YAo0M0g53R2yJ4bfyU?=
 =?us-ascii?Q?8Yo2LPjan1V6jPiONzx67OwNmWa3lRGfPt2lkj/8dpg0DCUppa/Ugbgc/Et9?=
 =?us-ascii?Q?6YN6g9GNmTtZb/0uWCBWXYmiOEWSHT5c/XjC8FD3P8y5+UzWJAo4B/2uDAV2?=
 =?us-ascii?Q?eesy62w8a6dmrSmzgSaIT/XYXRgJFlnsMjLDlWI2LGaKFKhrlMq137HtDiaO?=
 =?us-ascii?Q?DduzwTYULcR9S/1126V523Y/UTDbd8ZmtmqrbJvLm0VBImhuKFrgdp8N0F/Z?=
 =?us-ascii?Q?j8qwvhqHXq8W8Mdm9JAaPeDRUtOnQUyC4fKjzvjxmuXxwHzfFv2Zn1ekRqMO?=
 =?us-ascii?Q?yi3D8zSMEV5bbLD0mfiQzGrQO6aJt6rb8Pymjaj7Ac7hnKMkPTxhHx00Dijf?=
 =?us-ascii?Q?5DC5/TbRYb3lRRmfbQMTlOnd40r4rU/Or7gnJBRI2FDFkO5eMmDMUhY+2ZBB?=
 =?us-ascii?Q?7v4T39hzWfNOtjWpn/hyOHNHZckdP3drs7sx+boWnU4o1y/ybdRrsqyoMk7s?=
 =?us-ascii?Q?5qwXxRGUhhyj3W1RGHqOEqW393ukFP47JuHzkehzMR4g+4JcY5Y3cjgoMO4N?=
 =?us-ascii?Q?KINeO1kavJDpvNSCj8RZDQdKQ72Ko5twThXbXuwiqvIR75g/dj5FFTnwzzOZ?=
 =?us-ascii?Q?tVKQkjDuXeHSXzTX3N3xiJgh6VNdNRN1JHBpeAv964OryWUN5LQZqYh12wxI?=
 =?us-ascii?Q?/W4CM4BMyWgZE8mrJrSpAhq6CE14RMjzphAT849hrFm8Wq88++c2UTfEalDQ?=
 =?us-ascii?Q?IPOK+zRkccaLvnT1YyRBm6cX6RyykULNOcvGk/9y7kUNgBa7QaZ0AKLl+ktT?=
 =?us-ascii?Q?73tl5HeFFVHBLedaH3LDrnhwwcLxK5PuhbICkhsK+w2Xq/jT2yR6uGBbZF1x?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c2cc64-e049-47cf-6f9f-08dc94e83de4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 07:27:17.2765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+XOr9yinteN3E7vl5G5efakGCncrqOB4UEQYvPVBMQpX4gWM8XvpGsB5mKEN9K8YkclAJNa4vV1c5T6zd82ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10431

This patch adds BAP unit tests for Broadcast Source streaming with
multiple BISes (4.14.3 Broadcast Audio Stream with Multiple BISes -
Source - page 184).

This also moves the BASE defines from test-bap to lc3.h.

Iulia Tanasescu (5):
  shared/lc3: Rename LC3_BASE
  test-bap: Move BASE defines to lc3.h
  test-bap: Add support to config multiple bsrc streams
  shared/lc3: Add defines for BASE with multiple BISes
  test-bap: Add Broadcast Source STR MBIS tests

 src/shared/lc3.h | 215 +++++++++++++++++++-
 unit/test-bap.c  | 505 ++++++++++++++++++++++++++++++++---------------
 2 files changed, 550 insertions(+), 170 deletions(-)


base-commit: 2bd25c068c5f6a54fbe8d8ea11633d3b5f1468df
-- 
2.39.2

