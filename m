Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010037.outbound.protection.outlook.com [52.101.84.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5F830B50C
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766557662; cv=fail; b=iBA0AHZkzfaWTlvkoawwRUcJf60Kvbc1yJiIufqDl3UYOD3pD3SEEH+zwq9ZCyGnNlyDIpzvYlJXPyx5n0UkIrBeVquENTx9SNaWAq8z5Rcq5asFbS499klPAbS11XfcH2T5fWhGZNZJmy/Dd6kXwDxgvk6DnJiG+2cH6BLIDTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766557662; c=relaxed/simple;
	bh=ai/YF+AcVmCNBPb3xEr6q3DAg8twRRABQCcfvDiyx+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nP4jtOmvpNtR/wEgZ4yC0hzGFsylY4Nd9DHAGKwAIlr0Av9DJBeAeGg5QrZnbH5H0PPtD8TfkIvRSPq7P3U22YdafNQpoVruZCvCulEuzP3zFEyVM3pUcCWy5SJbKa/LVCANCmZhP2CSp5lNxUNGASHcP5PTMY07VZe2778ICGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OdI34b0L; arc=fail smtp.client-ip=52.101.84.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OdI34b0L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trJLBKfG5KFNuueWbMViSa5BSq8n/+mZQTkgncHfNB1AvIbUKCar9kphHQjlJt0/Bv11rTH3lqKlcSFURBEEBa/wksCCKomVRUIlWiGUJ30f6Se8nhFjuouoBz37pCteS0zCsQiR3Xnv2MHDcVKxRwM+M2lQnX9qkedLno0Pd3eCwHkzD84emgSUNmuiz59nNHH5QSViv+ySfmqtd6Jcsc4CyL32xpLUgGLVCXCfdFVLR/V64eYTOjvhBmd/m/cWBjZvV551XyU1+ZadYZ1DLmFL76EA/q+r++O7VUBv2gKLY46ymUL4P7SRUwUdxHrJrr+He+3zRe9xGjhX1NLzkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pj2E9IAWsY+2+ViGU22NPEdK5hHNATIgFjNYA3YmJ/I=;
 b=B59Z13dqjDf4hJZtmbDVXIV9yxz+Jg7hUIjLuQeZD3SMR+v7w4FLdbnUEK8uxYhCP1xHJQ/FRUIhqbeUv3yQ2TUZgw8TFNx/GEwB+3oful9zGBiMM6u8/bmThcOyLq2Bk2/VFTRqJmAxmiy3LBMn69yxSYfvuAZya+d/muwHdtZY+H/KaFIddDHH7tQINV3i+RashRdLRR7rMRGln5gRj8bjpyrgRnJgYT/dWrXzjletMnLlZ2zg9Q6Sps0oeTAzD7u+r5hYNpUjfG2IDcWe3BJujc4kib2AOaIwN9cnozBgfhP/KbC3lPUcTPwYIGXEYUw0gvk32ZFtyAXrDqddyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj2E9IAWsY+2+ViGU22NPEdK5hHNATIgFjNYA3YmJ/I=;
 b=OdI34b0L7LtcSJyW7GAcqqkv9XVFrEJQKuNdtOSVZ2DKXxdC3cLk+7uh9YG0CTDe4KVHowiAIYn4k7LcJVVOVisoiWvN4VCfNJoXLfFCGiiFULn7SjT06EkCTSFJv+BC5dZ5DENgANKSbAhVFeFjuEkVS1pNjchSOKILSZqB849FWi3FR7uMFXuK8Qq75YxpEGZFKcISSXqEvgFmk2zPHDWWAG+AM/IZztapLbaqSBCTKA0OvxZ3tSE8fhk83dJHrLEKWYsx7LwrCfthbOKq+kwV6DwFadW6/BGV0OjLpbrLgC0wXEjvw8KPfoXtC3nBb52wAkstwCC9uClxqlrd+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9)
 by PA1PR04MB10940.eurprd04.prod.outlook.com (2603:10a6:102:480::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 06:27:37 +0000
Received: from AS1PR04MB9454.eurprd04.prod.outlook.com
 ([fe80::cb31:6735:6706:519e]) by AS1PR04MB9454.eurprd04.prod.outlook.com
 ([fe80::cb31:6735:6706:519e%6]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 06:27:37 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	luiz.dentz@gmail.com,
	sarveshwar.bajaj@nxp.com,
	mahesh.talewad@nxp.com,
	vinit.mehta@nxp.com
Subject: [PATCH BlueZ v2 0/1] Enhanced or Legacy Accept Synchronous Connection Request command
Date: Wed, 24 Dec 2025 12:01:49 +0530
Message-Id: <20251224063150.2476968-1-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::20) To AS1PR04MB9454.eurprd04.prod.outlook.com
 (2603:10a6:20b:4d9::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9454:EE_|PA1PR04MB10940:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c107871-6811-45fd-68cd-08de42b587e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GdPTMjoH6yd2ID/7Tulul51x2qiF2d0bQWpn+AnNkcybd0/UHLPMb6/50TCH?=
 =?us-ascii?Q?c+uFhE9DRsBMxWAoTNNUOedeEbG0xjdvRjFEscY3AvajyCZB07PkhyyK3VWA?=
 =?us-ascii?Q?Qn7AvYHcIWkSeri4Mm8sDkAMDc6RF2nGEcJl7pOSqp1j/plqiNdr1VHnZrnY?=
 =?us-ascii?Q?M/59ag+x7Wo7uoNwVBg7es3tIc3L+jJu+OI82urRonIWCYODyxswf/7JzgR7?=
 =?us-ascii?Q?u4eGQH7FwdRIuHGPgfYFMvWOX6D8vnn1uibxgxVL30q84+8x1RjICAOiYvp/?=
 =?us-ascii?Q?Q81ZkzCFpHE6l7zPh+8rMLlnh1jZWOIoHn+qjLh29dzwjyKb5ub+NQ3plwMa?=
 =?us-ascii?Q?nyWly9SGqpL7/jcmDFmcR2a/b5Ff2lxamCV0nBG/Vc4WZZ3CORG1tTpaONvO?=
 =?us-ascii?Q?RJSy5LFqc8rTY1J11mqKky2s/S7LfFJisRdx+w0A2vgaxJz0aY3TcFJvThOp?=
 =?us-ascii?Q?0C9N6e3C8RoVjQUq4P4yvc0W1b4WD7Q68McYqRKCyBSyZbwTf5LjHU1Bb3Mz?=
 =?us-ascii?Q?1mcx9koMT+be4LcLy+JJvp3GK3VwC6P5m/cUGz7QG47Djkc8DCbU77jP8JVu?=
 =?us-ascii?Q?rPsBL76XTArUE5w+Ax+H5RI4LaysRAXBsvG8JCSufR+YjC8Pnumg7yptIgN7?=
 =?us-ascii?Q?ifvTSzvGLQz4PUeltZJWNDfmOVOiBW3kGIlmNzdXU5TEhtT/NEIXyrJ32nZT?=
 =?us-ascii?Q?Bj1tFpw7a5VWMcCWa7GJLUCzAiW5rpDraR6+64syOccO4W6Rg18EEvGt/Fcd?=
 =?us-ascii?Q?qhIfuxa1Y9lUPJLy7365796QUxHIdlJglnqMcQrFVse59u3gEG0tap6AD8HK?=
 =?us-ascii?Q?OhVJOVlyU2tZpVneVVE5IAboktFD04ahlGn5MySaIFduJGWE562tjvfIehUC?=
 =?us-ascii?Q?ax61OiDGAUnOdvu27rVBwmpcKHvsu3kEx1JRSp5hzC7C9jdRNKS4SfngYau3?=
 =?us-ascii?Q?Ye0PFxfjM/exK3peiKFsnoTVZPVL4H4bbOHS23sGhBvAPVk7DFCAGQAO/h+Z?=
 =?us-ascii?Q?O7TZGkq2qqxhzWsqsVwEbLjwiu2i3n+dz6PwABglWqWyGb13x/r4KqN2re70?=
 =?us-ascii?Q?KyPj/QIKNVzy2aIYIPLNRqcI4TKn7nVMU6Aj6TlwbXfLL7Wx/7O6QfggA8Mb?=
 =?us-ascii?Q?pXILfRxek9SjBmdbGHa6xqk37LoynOi4VHwj3KllIvGfss0uyLm0YVRJlJCC?=
 =?us-ascii?Q?+ERoMyRMFDuE79llCtETk2Xa9AJQ01wBGtXJTtuXNEGGwzYeMOtp9vpR585w?=
 =?us-ascii?Q?JfjdDW5CWhJ18kx9IDtEhB9rBAxZcpdLSYXmphbPaUfHJ/lbNAdqg+M281XA?=
 =?us-ascii?Q?JVA8OYiiHkBk1Js2iXlU+2kWyCK/nWx8uPH6Gkkku1cEn6V+Zo7Q9mP3lcrM?=
 =?us-ascii?Q?GBqcGifoMu92Y5uWwkfEbsnF+letyLF00vUk58D4IauplhfJwSFDf91oxC5a?=
 =?us-ascii?Q?6LXzCA+ehnu9/fqFyWEO3BmtE432djDmaZVKTlT9UC61Gxg1Miy1rCqImgVZ?=
 =?us-ascii?Q?K1vrm+qUyZlD68G1o1r9zxqxOYrrhMStEdAf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9454.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p2Xy2o4oQYe/qAsKfogWwuIpMC2gnNFwZip+1atlp0KmVNsa2XoR8oLXcwqK?=
 =?us-ascii?Q?D2n2AqnO6S/HSHrj8EkU9E9ge5UaRbDKns2Io3p9UP4L4XuBFfefhkkP/vDw?=
 =?us-ascii?Q?LFJbzKhlic+X8c9L7paRRSV+M0HFMk/9xG84IhJMrEFzB/sj7NTvBqMf2p9W?=
 =?us-ascii?Q?yEJxlQWix5d4Iuj2KE7QPRxITls30HRlSr4u5AUE88XdkUKYG6weQSVkAKMO?=
 =?us-ascii?Q?j/454IAA68FPGYZ6Ou6llFCXzThc946YIVN0GaIYSmwA3Acb0Cbxlb4EKgz5?=
 =?us-ascii?Q?PtZsjOR3kDToubQIL9mUEJ2iaHybFP4m6wnQyf5SKbEFbANdofq5fAjfnG25?=
 =?us-ascii?Q?5NTCFBRoobPO4Hh/4OVJOR8GsmTHCJDmBlOBnDlkIUqNb2DHmi1idjDYsN9s?=
 =?us-ascii?Q?/AXitdYNUG7ZDJmo2QJ74sfApZ8+2uLk2Yn6iOlF36pUWdvR/DIZIlocTAYn?=
 =?us-ascii?Q?MOT/NuRbjvFwbc3WtW5BXN5AJkuuaNmgtOKxBW1vzXDuDJV1mPMvKsJkDueS?=
 =?us-ascii?Q?SUGa3cZNIJ0t7nTX5c2G8yZvuDdVtZ3wiEmvu8cKaKIxszSbv22wA+K3nb1L?=
 =?us-ascii?Q?lzC0W82eGdM/LObFzS4r4HSBcMRnrBkg1yNym3ozG5d5iZkQBMR4p5L+87hK?=
 =?us-ascii?Q?c/MoAuTQCvFPp4c8TF9vj4y0Al0cDTquX9cShb7fT9tO2SKmNjI30HvDyQ9/?=
 =?us-ascii?Q?JIxSwKxEJhHBg58kpcy9C0e7saYX3hVlimInyUX+EbK2Syug1u2IrOgB/Zz0?=
 =?us-ascii?Q?ZPse50j0eZdOia0pdU9UD7yYQmAzdFzgPNR1v9p5ZhDcqTL004JurlWbuFe0?=
 =?us-ascii?Q?IULuOPgniWA5CoVUyhR1/mjN5wlmcDp/oYzs3RETY2hDYKDm2hMqxcvHHOos?=
 =?us-ascii?Q?fBspjXBr8fHYWkw8b3NXxVFBU1E2SARmPeHmEuN/kcwebKo1dQKAL7MH2nqZ?=
 =?us-ascii?Q?CDYpJ9powjXrMRHar8DCY0ana2E10fLNU4CyuyIcbbMLBE8aGnKhx9ZddD7v?=
 =?us-ascii?Q?YfhtA98LObjXsQ9EObnp9eZ6QEoH+iQbzJ435jS4uABkh2NE32/s7YBpNAi5?=
 =?us-ascii?Q?dD5v7ITEKd00R6Iac9BDJqviu2mNl9cA849m9i8XMqeYhELhp+I8mG99vqd1?=
 =?us-ascii?Q?+HzuSf/jVRow8LwygzrsFVTbu2pcd1I2eCQQ47bIyNy+wMMt+l2rbbsOrGrP?=
 =?us-ascii?Q?Z0prpROkhMQDjVYy9IFtCoNonF1B5UVpyaRmfa3cNQKtl1faay3HTmjG3Mcg?=
 =?us-ascii?Q?GEPexC4c3pYvbQtFV1TyB3EsrUtQh09eRMsG7zp0PmO76pO+bPixHVxqkfZn?=
 =?us-ascii?Q?GI8PMUEcntcvseHSDc1J8FX9+l90CxiQf0VU5775QKela2uOR6UXzK7pzrAN?=
 =?us-ascii?Q?179ZnraO0ZjOSmL9Pv94q3nDW7VW2VU7F79unLXS8wuN9YqkKZgFUUvbtUZ4?=
 =?us-ascii?Q?MLzer5BwLk+vOUprviH7bzSKtS4y/dhGtF3rpNfTwEDaoWBmtNzAOW3l+eno?=
 =?us-ascii?Q?Jp8oXmSW8LNVvy0Dr1P88iignPqjQPECwgYjIqiNgC28+l4TuP1EYJgdzm2j?=
 =?us-ascii?Q?LKaok1XIwvLMmYKzgGTkLJcG0f4KS9IZKeuvTQaodIhFXQekhalT+2wb6Fj9?=
 =?us-ascii?Q?gDhrgxLqbde/dFsS2fZI7KTBVlMuq6ze3jIFf/ku9sQYAisWKoUEogTLqrvr?=
 =?us-ascii?Q?fruNK32Skcp5FUKnngO9uJVtsk6yiX5fZ8pBjKssey/zW7EPnyAuTzPTsaEz?=
 =?us-ascii?Q?mIP8q4WFVQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c107871-6811-45fd-68cd-08de42b587e5
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9454.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 06:27:37.2415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8w1UDhveDcl7cDl7dzyD9Ko1yYBSBzpkWa3L1WKk3jRoVW+JaHXBYfp5u6oNQvT+jlf8+2cTxVQtm+kDFtFVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10940

Hello Maintainers,

	In the current implementation, when Connect request for eSco is received,
	Bluez Kernel is sending 'Accept Synchronous Connection Request comand'
	[legacy command], irrespective of whether controller supports 
	enhanced synchronous connection command or not.
	
	In this PR, When Connect request for eSco is received, if controller
	supports enhanced synchronous connection command then it will go for
	'Enhanced Accept Synchronous Connection Request command' or else it will
	go for legacy command['Accept Synchronous Connection Request command'].
	
Thanks and regards,
Mahesh Vithal Talewad


Mahesh Talewad (1):
  Enhanced or Legacy Accept Synchronous Connection Request command

 include/net/bluetooth/hci.h      | 34 +++++++++++++++
 include/net/bluetooth/hci_sync.h | 13 ++++++
 net/bluetooth/hci_event.c        | 27 +++++++-----
 net/bluetooth/hci_sync.c         | 73 ++++++++++++++++++++++++++++++++
 net/bluetooth/sco.c              | 34 ++-------------
 5 files changed, 140 insertions(+), 41 deletions(-)

-- 
2.34.1

