Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1E527702
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571068; cv=fail; b=eRaJL9zyIbDtv/RfoQ/wtvlnsTvihQuwQh42x6hTya1VJ4cx+EMpmdyhs0HvKioPxvaThzR9H1YrEajpb+qX9d2z+7mMWiSLR/JpMnZMImOk7n9obUyrDVUe1VypcmtiVic2fyY8zueeHnRYLyIbzrlokZX0FjbucUYBqsPjQgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571068; c=relaxed/simple;
	bh=qHCqEFeSwRtKXc7UpBFenW2n7Sjd2cqPIiHxZMFKqIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pQ6W2FCA7Vn6B/7GKP6CCXMvZuIcaWZpJc0UiFGc1FBTQ3SnZa5lbJxudt88xEVYKihhKkTdpsYCZ7cD1xekEALRRAUpLE319xxGN50bAxHZcopktaiUElCgRSgjdbbl1h3/wgA2QRQ3rWrNDWbA7wJR9D+TqOjLR5Y+68z+2T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hAI4fdFl; arc=fail smtp.client-ip=40.107.7.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hAI4fdFl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPs01AF+xz17ca9XXWUxjdNno27dvmeR0BJU21vD6beSelsuGaOuLsyoDZ2JV6Yc2KXKaIMg/ynAonG51CcIywpFUJMWGHv9tF+gLkJ9D2B0gVCW5z0a9TdyVzypvkDBd88CMV0Hbq3wxiqqTpChFzecuuB94SAXys/cXRlE6qnCdnxcOGtxPTYOnkf1nUWdCeB5ZAMuvdrvnm2j2wjabLpstV6hOmVbR7O9L9poNzAEbAVASqgpNAVNORlzAy78G2pROe+ZmT0slwV4PgJTF9vIaYhccbREByB35bUWJPJNuUJZWja2kcESz45zHmhFL60KRs58o7066NVR6UGl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCRmiX5YNTKrbaBDfO09g9L/DYJwMlah8GzOUWqfqgI=;
 b=ZdflV+gEa5fuM+FVWjMxg3ZE0r7NQ9P8N76dI0slIghs4/lvdbHQc8r878b77GM8hzUNYCEtjEefyYc48+5hlB2N2E15U3KTQg4Ow4PMMVA3FWClTVCAsCSOIItlFNxMUjku1o/VULG/yIoXWA0oB1jlRR6wIfV/f92cbNXtARs8hg8hOnf04SmBCE9QDfKlUE9ivpde4aHYnOM4yDMZ8Yh7aXX9mMsDuPo9QB1Z43sdEWRYUvwZOk/T0P3vJxbJUSbRdZZKLrahhd5z36GdAm5LsdqhWmnxA0RJ80qpbBnIIarY3dNbGo8kgGotvZhpHmr/BkD1pJfC4VDKipjqKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCRmiX5YNTKrbaBDfO09g9L/DYJwMlah8GzOUWqfqgI=;
 b=hAI4fdFlgyLCvjUy5F8FV9P9eDu9AhNaTekW75VfDYlV9MUyZ60MwNVNrbMsaDbzgaF/ePW7nh99fnBpNMPeCIJAgyWARiG0dKIxEY6ocxHxHHv/6wZVCyi5Gm7TUTzaDbnp1K07XFuOhVXfWcAu24Q3XN1x/88zxbh40vkpUDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB7064.eurprd04.prod.outlook.com (2603:10a6:20b:118::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 16:51:03 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f%6]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 16:51:03 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [0/2] Bluetooth: ISO: iso_listen_bis fixes
Date: Mon,  4 Mar 2024 18:50:48 +0200
Message-Id: <20240304165050.3430-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P194CA0047.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::36) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: 2868d8f1-16f5-470f-f9ca-08dc3c6b4721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zh71/eK+cPz0nI/1Ui1pbMlsppELv+pCFNi+e7y5lYxnv3vOjdpT6h7pAXqG8Y6gtAdEmfrN7RfeU65Y/w+T/05XdyZ8sMDc1JWYxLKf2a1loqhGjh+yZDXrNnOpdWcoWoywDlo/Y91V5vtXKR0VHnGhuKc663SZZssSCpGa2eTrBmKXPMXSuiUGodjTogbicW4che0qrMGYSXZZZCjru1yEbgqpizicWTSPgA+kkY8d6ZAMeL4dcX3VK4rDZ29kopMeAZTWOmbH1ZvLnjH+EIhpQUtodDdgdFcaHUB1kFT5B9UvJ1sZNeatOeUqHui+f2owjad2ovPNEu/n182kVGRbuWoLCMk2tSI/ya23pe2wugg8fbunt58E15tvP7FoIMyTEJpag/oaNRzSyKuXQOTjb+yFgLRxeK829+RukbfxsoiqTPnpyydcEUEUYSG2MxRa1XsT0mP2Wg3lHCMuuE6WgZM1UH4xepGnu1ltxzbdj+aUPWDaXXHybw72IZK5c9n0pl2MLHmFW4ETaHICfl5nejxtFtu0+Nyijr6Hy+vQHlxl5SOlA+Mmda1srzLnWEC9jUio+GdtMvSgjHMT285zid3TvR4j04ZsDqcut0YuHFRqBHef94DGjT811rgW543rhfrlahWrQKkxPF/+GWxHFJcmyHHcXFEYnavAAHw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XQv7+TfYvTmMarf17hUrX0XAVV+gc1mk6eNc6I7+dY7MBBj2JxbAC3JbFyCh?=
 =?us-ascii?Q?ZT3LH3ty1ZupC2eurS7x+NkU/Xk6QT60g/jj8RnhBzxWFtVlQEF2NKjxv5Yo?=
 =?us-ascii?Q?nTNfOxfKxRL/pgXZgAioIP+WxSEXy/mP9YaIsTaZHNFf83UG3gfNba8Dc7Px?=
 =?us-ascii?Q?wSZ2Op9QYWdPIr4vuGxuOY0oLOuVgn+LLerH2t6Eo058fz45yZb5ifxedMaA?=
 =?us-ascii?Q?+frGVg6ifNZqnWnAMWqumMXcBhwrvXSqZcgICkoLsei/tq9iIoz3r6z5Zmbc?=
 =?us-ascii?Q?ZFJ+BE+4jwTaXc2xdsGoBzIzvE9rjCxfs0EqXNAX6IG8KTub7kV/iVyT52I3?=
 =?us-ascii?Q?E+BFOBKgtT4jO7Ve0Vnjfsuvasli/Eq81QRDWhP0MljD3gsunNAZ6HXwtwUB?=
 =?us-ascii?Q?JMy2lAUsMWTHMt4KlGdDqyG2lkdVrhSIF07BWiouB38QQ1dl7muFaLQPIr3X?=
 =?us-ascii?Q?XAcQT8K9eP3u7fqcSLxcOWO7+ehIuPkNrefDLUthWv0PQJy07zWtgEFhugky?=
 =?us-ascii?Q?p3ee/RKSQu4kO2UvcwS9bYUXVZrAHf/wx7vfeG5QaNwAbFQI5EzvmeUzBbUk?=
 =?us-ascii?Q?iGWSaHHJCu7k77IxzbiccZlwUj6y1lcK4UUeCPhyGmI5MZ3HXJhpOgkCkRH3?=
 =?us-ascii?Q?sAMXgHG1NhHgk0pL6fhPMSxQh/DPRLycnegjXwGbWIgVF53VmBCFoupWIr33?=
 =?us-ascii?Q?wP+qTBBFyglgZ/+Er6sAww9crcLW7GJhs8CzwPq7DUq7MDHS/LtXQcda34eq?=
 =?us-ascii?Q?jg/Ixnj31QJ56s4XiglAGWRLUBXj/RsntcaZfjcAtVpOeDtz77WZ4MJuROrn?=
 =?us-ascii?Q?JjrmQOeuY1JHIIYdXUI7e4qbllCGRPAp6ufXacsE3w5/9M+nIB/SfzaR3SXJ?=
 =?us-ascii?Q?REm0ghRvlUWsOwXU/YY5s5vmh4zfB88pyyuPF4HMrmqZXaRdfXmXCJckTUNB?=
 =?us-ascii?Q?qENSxdIietEuaraMcY74eDdaSYiwBsWnuweybSlxZxbPx+IX/1VjWCZGyaDU?=
 =?us-ascii?Q?oCTla37Sd4BRXtRVIyOM9yrHt1eIrA4n+IoLbv4TECVpWwbuvQR7heblrj2K?=
 =?us-ascii?Q?1K1scteNdGzHHH6oREZ/EiJwGTnTKobAGmOwyoOHH43DWC2TMydGT1Eah/c5?=
 =?us-ascii?Q?cfiyK1IjHntxH8SLkrc/izwCh+/h/BexWf3OmAh+16i4Ts2M3dyIrTnJPatx?=
 =?us-ascii?Q?jC5fmJvbTJ2O4x94TdEN/YP5jxB41tRmRKte33ZsAIhai0MnLRzbQZluOOHg?=
 =?us-ascii?Q?qJlp4YYG47vnlhlxWT3zxNX9Fb6PS9KA7azZS1sSx1DWTomSfkUh04I37t4V?=
 =?us-ascii?Q?Osj6B0PgnqSinEQM0bjwsBLH37CKvSWC8jRK37zO+flwY5qDbceDblZxDDEE?=
 =?us-ascii?Q?l/Rq+gJBCGL/NwS/BFupiALrKa0VtabUDdaiDDP8bQvv4A6HegjqSdz7nfOf?=
 =?us-ascii?Q?CDDmCUu8D9jtJafxYR8QywwnZ+pKRv6nYLCJtfltvqCMRWNbswrB0tGokA2V?=
 =?us-ascii?Q?g6Byp2Hio2yQ1ZvQSGqlhwM8zq7QPn+h+JARFHdjTDrbunL09FekmCrRtPt1?=
 =?us-ascii?Q?zwOs3xemJkRo5EI18Ev2SMQDdZ8nLZIGhEs8QrF17ak9B5jQwc7zkngShJZu?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2868d8f1-16f5-470f-f9ca-08dc3c6b4721
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 16:51:03.3136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPWVk1lKo/Cz1pvqZCx7fxKmE0ETaTGqonTKI3FhpaG4q4+a5nWG5l5RmYDDnawYruFDebqBlH74qDEpqOuDLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7064

This patch adds some fixes for the iso_listen_bis function:

The first commit fixes the circular locking dependency warning
caused by iso_listen_bis attempting to lock the hdev while the
socket is locked from the caller function.

The second commit fixes the fact that hci_dev_put is only called
if iso_listen_bis returns successfully. Otherwise, the hdev will
still be held from hci_get_route.

Iulia Tanasescu (2):
  Bluetooth: ISO: Fix circular locking dependency warning
  Bluetooth: ISO: Always release hdev at the end of iso_listen_bis

 net/bluetooth/iso.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
2.39.2

