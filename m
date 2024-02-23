Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C01182863
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702499; cv=fail; b=F/THANOAS5LRnQCjZtJrLA3cw1UIVupvpSOF0FcxPtGSGX4T7tUy6aEbrjDTKywLmFlpfQKkl8KlXAZHDxCSFXGJvf2gz1Zi0DDHG06nu25gvDdg/i/aLPCX4lQuEGgy9mg3wEqTRUVn7ScAU6Aa8Ky2K1MYHNj57UoFyFFfpp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702499; c=relaxed/simple;
	bh=T4DPYEADXHDt9TPNiJOeLTuCYs/60ukiubq6jEO9MiA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=a3yOW3MnmaN7oR7bjDakafJmv2zYpn1/XRzbHyFv1QophcuSmf+7GNmViiZle87gbwVC5a35rECpGbeN98PXkQA1CDtptzTAVW0c/QmXfI10amc1ZGlu3TWZ18XNWZuZuIvmNEY3d4kzrqkQk3gAstOBLAEIIADmXcPJXnJGP0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=n70Xipfx; arc=fail smtp.client-ip=40.107.6.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n70Xipfx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CY1g2+rznQ/uLPJlfFcufqbo1UJ1cv4jjNVyOO+ILyj85YDwzFHf3ICF7LF1DvbPiHW//6cQq3EOALXdIdwcphDLMPJd6+aSc/EGyG0nzofqr8DvzRSDK5LP37iVPgWK2iD4o8ffZSOtaOYJmd/JKhF0vkYxYJHhoMpZ7nKErDC68hBhfHwI2vALmwV3h2bYkTJXwCLl1D7yGk7cguJErgQtWYK9LWl9pFWFjQsyR54dwsgmn5/4OcVeddlphsRtSTqMxsHDEOlLq3VD4wngVakd2hmEGPqibCrGCI+N6Y3Lu4uliWOLIw9aHqvSoTJtV42Jdux185+PCQCpzMgwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3WAvVgaKsJeuL7UDWiafFe2MTnvosKOX9xop5be/Jw=;
 b=eCIY8NvdNEQI+hNZE1xPnla+hxLfTU1rCUS6NfSB37Ltx7RPKz/hE7K6Fslm1+dOmGRoNK3qfv0XU5ig3HkMmrTiyTGeDaOMeU0MR3Vvp4yJDQVyEkrgIaNpJ/qJRmOTLSX93kjv21rpQMfLn6glhOhqJOeWZWr6FCatfBAPhibaiQbxK3P30+A3y4ZpTEg47elcqRY9h3IQjXM1EIWpWaNpizXDnR9sGzJ6yVL73J6it2j1ArwGKqSDRlLyeMiDLrRIwzrbjIhl+1Jzy6OmvbIh7fJbKhq4LOk2ZiUso00DKeMYOOKURHZ3G9a0MM5eHWJwGC8MalckQLRidBUrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3WAvVgaKsJeuL7UDWiafFe2MTnvosKOX9xop5be/Jw=;
 b=n70XipfxKuNK9nKyqmvbZT8I0IMS3i+F8e2J3fWn16Imx6Z4zuSlfdHV5j6uKoat/0UBUBapv9c3eBlQO0w18zs8Au9ueqfQKpX0QpYx0N32YiY2T4TsSvYDUBiBcZV/j8weszYaLhWeAlL2cdiJ+s6zjozXkgsztYPJhkY0VIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AM9PR04MB8953.eurprd04.prod.outlook.com (2603:10a6:20b:408::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 23 Feb
 2024 15:34:54 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7292.029; Fri, 23 Feb 2024
 15:34:54 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v4 0/2] Update Sink BASE management
Date: Fri, 23 Feb 2024 17:34:48 +0200
Message-Id: <20240223153450.86694-1-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0044.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::13) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AM9PR04MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c50c397-0bcb-4e93-ad18-08dc3484fb8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HvEk4rJdyavN9ScaBKHCLPCDzulrPJKXwVyDv291BvFtl/nFmwci59SprmuAp7H94VkYXcBwBm0XHCLX2SkMH9iAWT7e0WbvE61Ooes0vOBHLhUagEckVzh2I3IUeMWIJFNxv37Iczp28npewg1GI24JJsIbyVGKGIMFqtSzCAdob+DBlc6DeUGUn4FB63UyGlB9VgPZbG2teUgHclN6Ai5ssi4ed5pZ4F4Nz4d/aK0l+bAgnd81m6SEpmJOy3XN7JfbRgQ0HGh16xMuUA5SsIopEBxTX/1HgbMuucjr677s1Ghor2wEQdMIGN2OdpkDH7yyw1tCWnkqSag3TmXZ+QvayHyWaqBn87OYiY5E4Rez3a1Kl7VS9e1GoPb6mJdTmd6BcSSjlA39UMA+eUEQ2h63KK8H+3tbn27Yxvt65z4Lk2nFv4DI5/oa/fg4iEJEiBj76r9UMWJuZuCA4PXAAEVD0VJh+owAeDX5zu9yTUQmvW9Z3pq/V2vdcHsJbqyGU/H0IZbALC8iMuEDxpRyrSdhXNP7pl4PFwPajywyIAA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bs2uIak3iCZsFGmvUpIi6yebI+RDPeuAW5NHh0tSRZhSB76sc0eElSM4Iuw2?=
 =?us-ascii?Q?1V9lLakS0WbKXjZAja24Thh1oisADCxA/j2h6ZBmpU+Ruqv6pz+oHsgrhr30?=
 =?us-ascii?Q?gxNtjI2ORs2Jn15AGtu4QibqT3EjBT8BV28SmgX5jpIHkgl5quQa7TAPJaHb?=
 =?us-ascii?Q?W2TPao1SnQgL6Fk4IXif5UJ2AlXsebEVKnBp4uHNEjjKQBta6GRQ/j+Tc4bw?=
 =?us-ascii?Q?B9/TOsrQI40TNvB2egfyihQLPIfeY9PAWMnxbNym1AawhFPubOE5E3QoHN+n?=
 =?us-ascii?Q?9gnR5E+UN74RyBiW3IRgNmjj0OIrQGGgdcvol8SnDQz4w2CkaT7vDNr+27Jl?=
 =?us-ascii?Q?ZG7V6pa3Hlz6cGjHHFf5ESA/WI4rnBq/dRfgE6oXOjPvj+oMuyOmZX+xCUKY?=
 =?us-ascii?Q?/tBPQquPDeyYm0fr+DU8e1dkqJCKmLIETBjhaIRWGQq1vCwAsEFdzCTqTd5l?=
 =?us-ascii?Q?1gwbKvB5A6kqNEoW64HXzZ60tiyp1vusYYdX0rvnlrADJz2JmRlD9qoxxZP+?=
 =?us-ascii?Q?kZS2MhjrOPUiReBdOakHCR9ZjTx5bHvpodQ6bNiED78XCJt1yU33wW19lBr4?=
 =?us-ascii?Q?0g3IAQUwQpYw4FKB2xDL5nyy1XGoo1WHTe+O3u92teTOjZOXQiXcswwsq9ra?=
 =?us-ascii?Q?u1Eq0LKA7hchwcZFmsCLTVztYBBMoGK0TKGn6IIKSvLouLhzsW3uG54OSYRT?=
 =?us-ascii?Q?YvMNH88hgveGcw402/7TavnXQ1BT6/TBuWGrWDVaveYQVUhyYi2i+iJ9o3oc?=
 =?us-ascii?Q?rJupWGzZuzEp1tmW+ZvnX2cFR1Qlhr0WNjhRbhMWn605trn+KaAKZR/fTDUT?=
 =?us-ascii?Q?zjSp5QCy0uUkHxyYmPHIRU1sC26fBP45s6sP49hX9fiz+qTkIkT2ujnUJbIj?=
 =?us-ascii?Q?nLBCjoVlh8ndQ2+4UAoNJkh4mI1NFSstysAgRpbe0dfFjKSNhtzySpgLQ7QI?=
 =?us-ascii?Q?9/MuIdqG5LD4BvCUiN2TPRFxZ19vReNgslb34j41uCzWvrqeB/mT+d+dkMef?=
 =?us-ascii?Q?Zr33OoO1/tefIHMyhL/DJGhXFFzBqq5bAQAdwcehNBBRpIjl3DL/W57dToz/?=
 =?us-ascii?Q?kq9Qc0IsRni043qcEXMp4w0yycThWzNbPLfYqH5ihN/8rx54ZdK/oZYe2Gip?=
 =?us-ascii?Q?91paAxvUiATvDdBL4a8vdHr7RCIHtnAMK+ekfT8R3cAJR9ZodGKhx40Rt7Y7?=
 =?us-ascii?Q?lnNLM9IXR8FLr1CEHhMrF7dmSQGzuG+8rozV5MD/1FWA/W1HC0p2BtATljTw?=
 =?us-ascii?Q?SOsiXsintf1sQN0fjjIHM82yuCExfGkIkGLT/puYvpW2v3cnlDf3c4WFZJB1?=
 =?us-ascii?Q?xhNDujU+ZirK23684Xez4SguehpRjIB4KAl4TtyUKLZhD4cus2OIdNBlC6zI?=
 =?us-ascii?Q?VwVjDQqbqzfHrWp3H9If84NgEjAqvNBQBzfr98Sul3b0Nsn//lbWSWkAZ7lu?=
 =?us-ascii?Q?xj/x5g2uLUiAkXkEsgNnjvVmVnwHxffAtQPF6rHpljAA8YdZE5JXXzFA84qP?=
 =?us-ascii?Q?pxA4wzDzbFhoismTeHw9tLtRpxNLI6BeU2VqN/a1gxWegsWd2mpjPbV9TO3k?=
 =?us-ascii?Q?1vde+O+cyMUgE72vuIlhFDUMmXfJOZQPI9RtyZBdlv6Xaoo6kQ7sWQSgI5ND?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c50c397-0bcb-4e93-ad18-08dc3484fb8a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 15:34:54.1213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0D7NG5k1MJP6vmY/yuJWKH9vL43YIuz66vhj8Ali4IjtVS+SueEOWF1+NZv3GFLU8RYhspvZ8ZFYa+9/yIVCkqTzO/qR9DIuj00GQIB5Bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8953

This patch refactors the flow for the BAP Broadcast Sink.
After discovering a new Broadcast Source a short PA Sync will be tried.
Depending on the BASE information present in the PA and the local PACS 
capabilities of the Sink, one remote media endpoint will be created for 
each compatible BIS.
Configuring one of these endpoints results in creating a stream and a 
media transport for the corresponding BIS.

Idle timer.
This patch introduces an idle timer, responsible for processing PA Sync
requests. One request is possible at a time. When a broadcast source is
discovered a new request for short PA sync is enqueued. Also, when a
SetConfiguration is requested for an existing BAP broadcast source
endpoint another request is enqueued.
The timer runs periodically and peeks for requests. In case there is no 
request in progress the timer marks the already peeked request to 
pending and starts processing it. When the request is completed, it is 
removed from the timer's queue, so that the next request can be 
processed.

Andrei Istodorescu (2):
  shared/bap: Add API to add an observed BIS
  bap: Do PA Sync for each BAP Broadcast source discovered

 profiles/audio/bap.c | 651 +++++++++++++++++++++++++++----------------
 src/shared/bap.c     | 304 +++++++++++++++++++-
 src/shared/bap.h     |  13 +-
 3 files changed, 714 insertions(+), 254 deletions(-)


base-commit: a16c2ccf9c256285188f4549b7b767cf31b100eb
-- 
2.40.1

