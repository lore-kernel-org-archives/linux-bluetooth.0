Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030321931C
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750343113; cv=fail; b=jjO7stPo4uz+DGsAAHcnjO3spZIdHSr7c2dsmiEpxyGcI1v9h7Kyt76zR1Gr8H+m9xu84niXSvhpkHwxkj8agFXRXzYBKEVcCrs2ccv6wYjIHMrazvaAauFASDd0/Y4O5yl6KVrQqAdiibnNCnEb/DwfwvKM/iNuSkbp5vrCukM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750343113; c=relaxed/simple;
	bh=eRVIz0heDgwc9RjHIWMI2YVpNaqYIw2zTgOknBhlRwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WB4ntoiOtPRDjRe4fJhNy9JGgMQkou1nMl2VU3W0vQaY9/eHaGK0U4WsLWeU5cAQ96BtGma4sJ0Md4JFMvkK5w8kKttgcRLYdTR5i/HFG3Noy3sUGgSuWw1UxhO96K27MJkazlv1p34qS4tvTv/cTcu0f4flQWI3i3YjItn6H2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=La4Vt1yh; arc=fail smtp.client-ip=52.101.66.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="La4Vt1yh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILJyyOH9BkqSs+tXSYpBu4meFz+tFuQIu+3x2uee31smjmP+lSiSXPSDPkOZnGAVpVdnZqMmDt3Jdz3/FTdM1bsfA5sQyxfynVzW8SlUZCFg+ZHB/IKE2J6IFJRhpX9jWgPvGgVLWPBNec2RYJw3V9o+w+xFjVTbdprstunXx12o3ssLVLLRBbJHdlFMtbnLrPtNL3/kM9exfwrv1amdRu4uFAzW2h5y3InmvINqk56ppF5YCCsOjbWpZChF4SJF/ZvK2YATbMvJ/KI/e5i53DbojLn7A+g0O/WSerm8yI4L+4RBD+3IOLgvLguTjrstXIgq7AHer+FlmFc3LZyOZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHGKRX0weRz31TBEqlwulScR2XVJXpCUXmzkUOgAyL0=;
 b=mQvarWDme7JJK47ajE09EdP7uhU72ulgjpatBHY2ohiASZuwpMb4z3U63k19cVBn0Edg9zHqRCm6DAP3m9nfxnfj0oOHaZ8xUVAJLpDx82r3e/+ROfnlnQZd8EXN4W2tmCP6mgKtYCKwrU1ezm+rfqtD5cJk80dOzk0OnWbJWt79iiADR3F2A6ln5GRHuY4qMru7kvRpBnrawlnnVc7aEq5NavR/Y8s3PCJwFeY58hADPywCTwqF2LKpuH0riQPAbsVp6sPn/U3xq7Ugp1cVt8S6GGxo4eE/NFPhX853+HECSwvc3bEBFR1KUaUF9V4N/yEUq7AB+2kKcVzHlSu6lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHGKRX0weRz31TBEqlwulScR2XVJXpCUXmzkUOgAyL0=;
 b=La4Vt1yhrpoPhs9s1t0OjVsgtMwCwGe5qYSIGzTk1YSbHcJAx8w0IyiJwJR6oScKokf5M6qk/q3bUuokn643F016uI627tlW1ZvozpiNh8KxxnkodNTHgtQrFzWbZuvTQebEscLDBFMs3UqU94GmsOfuOHsX+L+PyRjuguHkvnFArRQjOMVVsfSmPIlV+s1Xdl9a57b64Aro4VHZvSj1AnQG5rqzAnlQ9dWytO5IULuEE3BBqhq9+CeeN5FG8YX3Sqk+URJ2Yto1VpL4QWPyuHts8TJCek6qqD+VFNfpy3ITZGpNrR0WzvBcyD6LOyiP3wKsvnkBzt5ZvvWIo/xrjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com (2603:10a6:10:372::12)
 by AM7PR04MB6904.eurprd04.prod.outlook.com (2603:10a6:20b:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 14:25:07 +0000
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82]) by DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82%4]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 14:25:07 +0000
From: Adrian Dudau <adrian-constantin.dudau@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	Adrian Dudau <adrian-constantin.dudau@nxp.com>
Subject: [PATCH v2 0/1] tools: Expose the raw advertising data available on D-bus to PTS tester
Date: Thu, 19 Jun 2025 17:24:58 +0300
Message-ID: <20250619142459.7979-3-adrian-constantin.dudau@nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250619142459.7979-1-adrian-constantin.dudau@nxp.com>
References: <20250619142459.7979-1-adrian-constantin.dudau@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0024.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::29) To DB9PR04MB9258.eurprd04.prod.outlook.com
 (2603:10a6:10:372::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9258:EE_|AM7PR04MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff480d8-0440-4235-190e-08ddaf3d16e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YR1AyheNoch2qDnt/rMwyUnbgeNc+aDCIF5xcT7c6ICiljOl0cbkpACPt40i?=
 =?us-ascii?Q?wXt/38JxYu2UM8ExAw8JMmUFVrlTLcBsLISekD3pG02178PCk+AyQ/EN/5PK?=
 =?us-ascii?Q?EWo6HeAt2O/HfeH8mab0sCa/P/xZRsKn3BmfuX6WuCtjwsjbs0x6NkBR1pE3?=
 =?us-ascii?Q?iZt0DpbCJASLoGeSujeleMXSaUGkwQYifOFKwGk1z1zK0Wpm24W+kZNcX5wz?=
 =?us-ascii?Q?Y9vYft4dcA+eOCs+29DHOWkeSE51E1WxfqdK/EAaial8y+Ayb2zw58aW3VXt?=
 =?us-ascii?Q?qaEEsIOaVGwOSUxUtZSHlEXh4KDpDbgrGQQoITjKV7rnUkpyqZzub/IEI8B3?=
 =?us-ascii?Q?dEXr+VYhGQeLi5DGAzxgNSdS4WjmyiR58mJEscN8hOJ880EO2miH4J3hAcwn?=
 =?us-ascii?Q?T7euCKGg3f+5RztqkCi1RmbKeAx+es2WMpUI9Y4fsYijPNOioafifsO2l8ty?=
 =?us-ascii?Q?e1m+blh2MF12Fpzaai5NYiybB7UMZGZFip0H83fgtv93hItDft0RsneQKp20?=
 =?us-ascii?Q?yH7lc8RyFSvgN2OOM4BWh+Z8FEc0rF7VOAFySuRibyOHV6gfpDlQb1lD4UZY?=
 =?us-ascii?Q?xZdEeda8gqP2M/kB9juG1fQS7HHm6METYZ0szGOX6zub0ifCY9oDfRx28Oox?=
 =?us-ascii?Q?Av7oDh5HlNRdo4XL/Kdd/w2UTbrZem/1DCkJK/q09f48kPRwVuAIbSvpQrAY?=
 =?us-ascii?Q?4vgtCznm0KGTQ3Y5spbocA08E/B2lqa0hCaXPFqVTWW5PIX8TkIsK8A875yg?=
 =?us-ascii?Q?xYGVn61CgJt0F7DsQvw4UPEOdN750ykebEH0AKhrM/Onp+q9D4bjFjpjmNC+?=
 =?us-ascii?Q?EYBxWmoo91GwFEmfjUj6iAVJqnFEQwlcm9OeooGAa3Cqv5upU9DFFEGfphEc?=
 =?us-ascii?Q?4s/Jvt+vimLSNtizELJ2pXd+NdY6qN2EFOzfJRiadFQ6Ani0oZnOwJQ3Jw8z?=
 =?us-ascii?Q?kI6KJi5bPgZMN9hoXLJE8D46lXmDK/WiaTj/n1tsl2YWSutpe8sZ9hmIt/Wb?=
 =?us-ascii?Q?L+mjVhzIvpZxDEK4c+MeXroLBW6bEAJWWNnRN1rKhe87Q8rKi2SnoZiXL+3f?=
 =?us-ascii?Q?tl1jkw4CXP1xVDgTfleAovirZPTrPxVU+pCNFVT7ObuKleXvg5454U2f/sV8?=
 =?us-ascii?Q?H3DAuwF7Dt6NlS5H8XG9z/0vKX95Z75lvxZc0yfeGXmm0fFYwFo0KyXhx4bC?=
 =?us-ascii?Q?8MtRMG+F1yyCQd7t1EdR46Hi+gaZKj2nhFL+RbVbqHe3gdXJizpJtUtmdPsg?=
 =?us-ascii?Q?XG+TTJyNG697Tk679Gq0hHNarmXUZgAzfP45PZC70zw3VqeWoOO6WEYFA4sq?=
 =?us-ascii?Q?8XOp4/Jl3xUeckGNBmY1h1jUizVfDHPSJakJlTWFT9YZeprh+KUm25HJyu+U?=
 =?us-ascii?Q?Ic51epb83ap/Fv/hytkkz4+6inCZTVmPdp9RdBCiiPSx+/PSzNcRzkY3cgc8?=
 =?us-ascii?Q?agxPLb/bgsM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9258.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2XwJeJBAAkoLN1AVNgFvZrsG+vdAo8vNkGxfErP0D+CKZJR/sXPrLFy8Fvsb?=
 =?us-ascii?Q?0Q60V/GNK2ET9fmErMfphucoVq3y+CkR12H3MzUaCZz4mxehr4GaNcp0mfgd?=
 =?us-ascii?Q?3kr+F8wzP7hT+qZtYFJiqz6OceQzNVX7UOKCHbOSukTzdB+ENpy8EIKDsyYx?=
 =?us-ascii?Q?PE0FCx97mC8D74qMHyuxeVBs9TCm+tRG5dAxHYQPhE5Sg9v+FU7TVdmtuH6a?=
 =?us-ascii?Q?97RNF33ofhUm/MFtuoljK8tfL4XTCUoITp9Z7aaDkg2SIs0U+tWzvy+vVIqv?=
 =?us-ascii?Q?Qhpmc/p3Mvfzuy51oK+WdCW/cFuDAeSNns2e4IVe9QHPBqVZA2vAnCShwbVD?=
 =?us-ascii?Q?zTKWcRHRBgJ7FcMMHjfp5u8bP1Ph5DPuzW0rc06SZBX0tCZmAT53Y8b2umtL?=
 =?us-ascii?Q?k9fHjxGycPgHFRMiK38uMU+cCEVrloyaMrs3W3QqZUvJ5/gAIvUPkfxaUxn9?=
 =?us-ascii?Q?Th76KgaR2vNa4Dd2hNenKmirLsNLtAMSC/83rsczqiOu6LLej+wN6BIJ6ex1?=
 =?us-ascii?Q?f+SZWQbsYFeELcOLKV+Y28ELqrzy6MP3yRjA1fQZ/MMdQ9Gg8gIpmWz6I2f5?=
 =?us-ascii?Q?ylWLq9qiiJXFTYWRaHeAKX83qCDPlo6bIxfV5tkpiVZFeP/IqMDhK8cf75p/?=
 =?us-ascii?Q?6XQqXLcSzQsLmnYKhst1H8TjIvXk7w02H/h7Z8VxUrbibhdjarIf7vJEpH4g?=
 =?us-ascii?Q?WUqwzHhW9NpOANVMC7khfyvZJcSQZsTvd5pPysBqbZZrbgkeYVHQRh6AWpJb?=
 =?us-ascii?Q?lzx9BXGSJu10ISVLqhNNEY7Q1RHKqe+G7pKhR/JzE/TIIU7Z02EQNgWRCO0O?=
 =?us-ascii?Q?oPSw1GI068ubGKKvpz9i2KluPoAaIUkzd30Vqw5pTuQZNep3oE24MqvFzQZB?=
 =?us-ascii?Q?mvYg0mq3P3m3HztFWQLk1VxPrRP9PN8JYEDISZAuZfejyPz2L6JupiMs9FbL?=
 =?us-ascii?Q?jXUMnKs54Hmk/aMXlBzQQqlTpo3mtEtFid356CYnKFvbbMgYgElIBcOH0hOM?=
 =?us-ascii?Q?1tNi0xl786uSGMxF7ZM1zl2VpPU2FpqMBU2Dya+GCYnDL/RF4vWbqPR+NFBb?=
 =?us-ascii?Q?oqxD2xkrzWpZQPRFi6xkdbOQo16muyze2TwqXO5jn1iAxlu/M4AAlwOC4xlr?=
 =?us-ascii?Q?iV5jt7zyK56N8+Lk+2mGywhUDhK93TBBvf5y/U0GgLhgsd0PTDhMUAxPc9Bg?=
 =?us-ascii?Q?t66PUsyVF6VFmpQX+enzapH7g0nzsvMsPGif90sIUtP/veDIbriboS0n3THG?=
 =?us-ascii?Q?fKsie/obKptqTyzTGx4L6wfQfXO1s5ZiKSaNdyJX3Mu5IsNIPTl6EbNYnGjT?=
 =?us-ascii?Q?K3G5Wu3V3xzi7Q5poCWLxBAWlhJf0KtIgKRaca/qRX3zR3qPTXRDzTidLXqo?=
 =?us-ascii?Q?ZFdWp26+AWaVz42Pc5+kI4wtR+DG3hqAq4s2pRQwSedMMpfnZGaYJ514SMVi?=
 =?us-ascii?Q?kSpi39xnKMhtJqoKVhaSVMVqgPICtxmAIfERv9j9TrFhjRrxcalVJe9XYQoD?=
 =?us-ascii?Q?35kt6+26h0xvfciiNJUVIiG9MhibcV4NAwXhApLfa0c6Zb6ZKC1Cm1533VuZ?=
 =?us-ascii?Q?xCxqXrBQ5lny0lVRHERhBeibKcTe4w0nwehaBxyu1njgeOwZr5M0nPwrh5gL?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff480d8-0440-4235-190e-08ddaf3d16e0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9258.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 14:25:06.9922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHCRlvWUlUnAXVWZrsF4cMxlrvXfPC4mxcyXGKrbMWnOpeYlHRdnAOu0eLXFM7+tjXk5eTZRCp/9qycUULS4dlSwFsiAuYtYSpx1KJtWACo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6904

This patch extracts the AdvertisingData property exposed by
bluetoothd on D-Bus. It will iterate the variable message structure
and will construct the eir buffer in the format described in
BLUETOOTH CORE SPECIFICATION Version 6.1 | Vol 3, Part C.

Adrian Dudau (1):
  tools: Expose the raw advertising data available on D-bus to PTS
    tester

 tools/btpclient.c | 98 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 4 deletions(-)


base-commit: 5df9521ce4d50ffa48153503bc5156c11e6ed26b
-- 
2.45.2

