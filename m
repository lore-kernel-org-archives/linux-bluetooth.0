Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013014.outbound.protection.outlook.com [52.101.67.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965464D8CE
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721117506; cv=fail; b=jEZCO/8g1WdJJnQXjZWnbY9Gs+W82SjnccR8Fg7sBqd4VyFxqku8LzT3wsnpLFkKEoEnAkU6WxhHnoL7i5zaZ6BuRNiytGyY0zOSe4Dovu0VXomtHMZN47Ttu68sK5IOxhHbcmEMQXL4+Y4NWmycyD4CRWSzMrMaBtoi475XbJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721117506; c=relaxed/simple;
	bh=JHpFKhQy780zVk1lPsYS8zwfwpNcrDTF2H9cCeqO6Cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RkSWlA8NjXVpA8b2w2rlXay10ynGlMkKhNdUzj7aSzfcNWzJwjVzq9jV/E/dsuGnDM0F+x6tt4g1r13wlIXaIcALlcBbNtoC/1h21S9BptNvZX+tURIwfjgOQ2X6VsKycr6SQ9x/225BD76PlQoSKnjMzB6LFODdQAf24ZbKGZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hHsxqgNe; arc=fail smtp.client-ip=52.101.67.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hHsxqgNe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZmrXNPTKq3bYEE0V81OM5lx5d4cZIHdMLr7O989U9n6HZNX7fn7gvkMhAEFS/A2CnSRNMs1EYr/DxhZdNrvm/4T3yfG6OosTAp36P5fnvVk2Zb4BKqVyZwSSD9QCejRCV3cc5OyHRVdar2uQqMN+lZVY0pZlyxU+iIqUHI5mjirNEiV8Kjx1DeQ4kYWcP/IgEPix2qEY7XCJjF7YzPzTD/vj4EmBYr+sspZkG8vyG2I5is9MKisH/X5JjWuTtr6aI5RXpJJ+H8SemWNiiwlfYORr9izrNp40DnRkkAR2cH1PChWUe8cWcYXxH2IV1hFaFT9+GIjrw4fEZiB1zBU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSFvrCKGHb00vcFPMwdVGSPz2v3yAo9Nc84lEYUHBIE=;
 b=lTSldLRz5PY1dLzjMpy2HRhfEa8bFvl7YlTEOSW45MPGqnlvyWp0+yEgLgRrXQpWSLPQjJ6y38jzLG/0Pnn9saAnqDvDZF3vZ1RHoTwMIgo/lDA3fxmTWNqO7xF3QpwAwYjI2Q4uHk+6a5JudAkSFxMGY6qhuXbC9JJGyDl/gqzmEKTDtdxnngJQOT4/qDN+kVtJDkBzDI9Byio0yema0h6TGh/m0e7JcM9OtvY0QQlAtR5pnhgBkr8lFzok/SGkHy6BLBiFVQ4RmSbLSBn5+ayLgQbgFUXaFShDb1i6XYDJB78O+ZMG+A0NqrCQqcv8UUQ2GH7lu1VhkXGgQ6tWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSFvrCKGHb00vcFPMwdVGSPz2v3yAo9Nc84lEYUHBIE=;
 b=hHsxqgNeudGxi8E5vJRedCy/4wdsn3NH1JHtFfqPsrg83Gg+PZmqMptAry3fHVH7ps5Wtmk6WmhSHf0FpfrICC0beIJwo7+v35f/TeJq2Dbpap5es21s8XCnhoFtabky3TeUvPmcJ1eCEbKhHg81YK3xWEQzaBkQe26ENkdOiKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8903.eurprd04.prod.outlook.com (2603:10a6:10:2e2::9)
 by DBBPR04MB7881.eurprd04.prod.outlook.com (2603:10a6:10:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 08:11:42 +0000
Received: from DU2PR04MB8903.eurprd04.prod.outlook.com
 ([fe80::2cf:c259:f258:efa8]) by DU2PR04MB8903.eurprd04.prod.outlook.com
 ([fe80::2cf:c259:f258:efa8%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 08:11:42 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] bap: Fix crash in bap_bcast_remove
Date: Tue, 16 Jul 2024 11:11:31 +0300
Message-Id: <20240716081131.14893-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716081131.14893-1-iulia.tanasescu@nxp.com>
References: <20240716081131.14893-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::12) To DU2PR04MB8903.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8903:EE_|DBBPR04MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: f00dba0b-fa3b-481b-2e92-08dca56eed3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kl6e++mBgvJJkq+qACPfvlZg2txeYaaD/TCCnLSHVl1Vw8hyik5u9ZE7l0CT?=
 =?us-ascii?Q?+xceWJSnwoP5+yqoDqksEX3ebuVOE5yyDZRIDB1SEC4kVcZyNHzhB2u5kx6i?=
 =?us-ascii?Q?KGN3KjGucfcKKiZhNv71TEFVQqgFVx9TBydfqzOlEV/QGVC4gzpcGFhXXKni?=
 =?us-ascii?Q?lBsO/CaxhvGW/ciBOLhEErQ7bo3dHcS5Ss4sTeAJ7Rz48lxFYwOKlMzvMBEw?=
 =?us-ascii?Q?rYNvQPLCG+sUc8BNAMt+FMfSpJg2xL1Y3at7sY3BCJEG5r7wDHZTzAFMp/U+?=
 =?us-ascii?Q?mqg2EtsrJyltJblZvIh45msqKZkCdFKYwCm0O8ZU/ZQsHThhDHapToI85d4u?=
 =?us-ascii?Q?ypXmqefAXx+SqQFSBVT3UJJmwuqQh7rU/ievQgaMLEP2T25d3XWF25WEOGgZ?=
 =?us-ascii?Q?Dyld81cxExjbDX9FcYvtsxWILPXon6nRSAZva6t6icPokBZ1Q10l7pGoIxWC?=
 =?us-ascii?Q?5SyRzfMtqWYRBXpVjhwyE3msjeEeGgnQfh4h8MVtqm46kNWu/cueQApgdQXl?=
 =?us-ascii?Q?XHaSICP42Xumm4uw/s9L0hT0pJZOViZEl5Y4w1BeUQFPEJNHbGAKNkFs4JXV?=
 =?us-ascii?Q?2uXC691yvg62GqRpT/52RpEFLkGYiQBVmNjZOVbfa6YZC4yuT+arQtua1vTB?=
 =?us-ascii?Q?W2EJLdhiyhOrM5ULMj0g6sbPwMCnRuSPo8seQ5HbDi2K8s1nze08ijuFDKo0?=
 =?us-ascii?Q?0I66R/S0/QS7DIw8VudRSIBD1JyZirlFX6wubTuhoeHJlLSdgsl28n1eMOZd?=
 =?us-ascii?Q?jTVijeXI+qoMtADYj4xL3hfgEQ//yX7zqe97nONcpX2DwThiFovwnWC4+TII?=
 =?us-ascii?Q?fis4LWIuhQaxHevIPA+ZmOcw74urxd7jPbf1bFTwV8ebmo4tn3VTXrgjayIE?=
 =?us-ascii?Q?4C0i0hmthJYJOX6uWbOYh5xzo/4W6ZXRj/ePf439vhan1wpzdBa3v5RdlHWv?=
 =?us-ascii?Q?RQafieaJUVW/eCOMRb6+5TGkap1Ye3idXnkeNhhN4l8Wuh2b7UA+h0W/A5IS?=
 =?us-ascii?Q?FIQUgG9EdfIgarTd1vSizC+Yg7EsLpIqjoM+fiqQbzJBVqZ1ztaHRj4VY3vm?=
 =?us-ascii?Q?rNOoHGs0bJmXvCtWnYzpo18F8doDOPvuOpkptZDL8CuRR7I7fGWlKKHopfGM?=
 =?us-ascii?Q?N9GJD0OsIFzTltN9CtfLWg+IeKyc40lfLY1GmvlSDkVq2TqXuLTt55NHkk9Y?=
 =?us-ascii?Q?60LI6Pn2UDwfKCE8aCzpfH/oE3AOG4b9JkYKvskLebt1yZtFs3Xw+Be1Z6Yc?=
 =?us-ascii?Q?iX+SYUPVQEI3OVzzWGizE4fwjHv0zKbUcRsCA00s0PfNTys7s9soTO2LuLEJ?=
 =?us-ascii?Q?BVMUTj1MlWV8UIvbjjx6aAKuqYe21romsMNctP+BN4FpzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8903.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lxa+xzvcZnW7KXlSJdj4zwMF/5so699ahIe1ZnDXPOqL4+S6vbITHLA9fIbS?=
 =?us-ascii?Q?96zrk/6V8Yn56UR6SoQ6tLsotHYLSZ+lEwDc6vrG8X15p3IhcGe0YNLxi4JL?=
 =?us-ascii?Q?23VNXgT2cFA2iYX8KrMqnfDWtwXWln5bgYDXZ8JbUIr1ZyJ5biMtO/xx+AU2?=
 =?us-ascii?Q?7LyAX+6hM5p8lxTwa6ssFvoGI+sheexLsp083aD4MICxLY16QHlx3ecA2oAa?=
 =?us-ascii?Q?wTQc4Pgkp7jn9YOIB7q+uimMvsR1pMkVJkorUvnjlr2V+vsdkfVlW7+QfoDf?=
 =?us-ascii?Q?9JFjLQLpYMMzXM4ckDomi4tlId/XFkcT7kriAd6+L3i3HpDWRUmOVn8IVgCE?=
 =?us-ascii?Q?jMdn4pWXJSvt51A7nJWrXFzFukLW71IroKZHOqJrgRXIJzKxSFV5Tbro8DSF?=
 =?us-ascii?Q?VrMldn5hmDnWwG5iyZwFa5XN0KC81bwDH7gdGrr+xnIPURvTIppzZez99pU0?=
 =?us-ascii?Q?MceKIrTQvVsBdRYS/mlk1dMHUh/ab2yHL7Lfy7szScebLi/L3vBytGZPrUAw?=
 =?us-ascii?Q?FZrVzUY6mQ2y2wjTG0DtNpfhKuKtS9qBcxdbH376V89dk4GjbWNS7qdq0YDm?=
 =?us-ascii?Q?EZw2clCs7hlNJ1PCFiZMkc0m8EHbGBmNiYYjqU+L+DYrkZbXAlqaDEzRQHmL?=
 =?us-ascii?Q?va67ojeZDBx64wo23f8Hh898OZD42wCKOlNV7DSise577MKHABcErOkUUCJH?=
 =?us-ascii?Q?Ot4DG/KcnF7uNZNkq+IO9V56CMklRv91I8iMk2ruXI/78jbDh+PPDnHYqELh?=
 =?us-ascii?Q?pBITFhTtaoj85DJ3qEgEYwNMQrAHxSFRQe/HXUAaqR3C2wbZ7l5NRQjxolIv?=
 =?us-ascii?Q?6vg1bC9cL1/d69a7+gzAEBImdiCNxxJDxhWCnj9CLqdne4dd/2A8mJXKsu81?=
 =?us-ascii?Q?p5hXjMrwj5o9WZqPIf1eHfCfx4+Pt/Wf+5jAShrPvYuY2DTvtYTzRAfRwiWd?=
 =?us-ascii?Q?bLjuo2kQ2YmIe7YYnSpBBFsPR2dUmPGBB7gLLH4DN14QOZ/vc5gaK6T/h00N?=
 =?us-ascii?Q?rGHcnkXQBZMoqJ4r/a9ubj+1rN0UYjRCaCGvmtUAPJPAkpJJdQcOLhS4f0F3?=
 =?us-ascii?Q?khHVBfguLhYD7OttxM/c3Sj+wcezyLTv/HQx37BK3qou+iOEDTUxs9wzTkDd?=
 =?us-ascii?Q?BDTtDa0i8UvaxJJCq+d/zcpbadObKiKG8gWQhjN/awCPQ01nj1QDyHVYdSMF?=
 =?us-ascii?Q?Z4PSUlZscS9MXCZGGFZtD2Mr1TXy+KYW909qA9rNChLgaag89KnRzw5ILLbp?=
 =?us-ascii?Q?D8V5umWN+3xfS4GBsZXqIQLTDuc7v/EiTe1MTpvbr77+NWMzod8AhjzAiN6n?=
 =?us-ascii?Q?LfwY3JLIWphds+y9iD4q+Tqjsl3/4B52MNRwsOPo9gh2VALlTLhCygU8lg0c?=
 =?us-ascii?Q?GUxB4raj066CaNKPTYZpxb2gEw+kDhOVHHsK6xNyYnBiKgu0g/MTeepCER0u?=
 =?us-ascii?Q?LsFMPyxJOYdV36B5dEou+UjwmRM4vZ1TliLMcHYKC5pITJkE4meE9mSTAwR0?=
 =?us-ascii?Q?q+PwHkE5RWgzunShkvOTuV0LgaXNnw6qju3EZ2JeZQXYJpGbKm7N5VnJXoMO?=
 =?us-ascii?Q?1Vd+fq3gtG6Lwsv7Ql+aNpoIGxzjwBkf2Fm7IeOON2ZycS/6XIoX70UO3qTp?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00dba0b-fa3b-481b-2e92-08dca56eed3f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8903.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 08:11:42.5966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HU8U/HDf21j15Iybt0CB7tHo8+CrFZ2FjjERxQvfPsZMvtYiPUCcpXbg2GaPv90F79VZt+Fq09y8hQUS+rJcSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7881

This adds a check for the PA request dequeued in bap_bcast_remove,
to avoid accessing a member within a NULL pointer.
---
 profiles/audio/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index afa938091..16c02524f 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3194,7 +3194,7 @@ static void bap_bcast_remove(struct btd_service *service)
 	 */
 	req = queue_remove_if(data->adapter->bcast_pa_requests,
 						match_service, service);
-	if (req->io_id) {
+	if (req && req->io_id) {
 		g_source_remove(req->io_id);
 		req->io_id = 0;
 	}
-- 
2.39.2

