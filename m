Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE7A12F593
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827158; cv=fail; b=iJlOguLvEC+rLOJKZCEO62Ieh5tSWgXz/40fOSMS+KdgkTYI6ER86s9A8pbUyWPDoXulDnne70WTOK5MuX0nWe9yhQKopBuXyITB0bw9DmmfPpeQL4Eu7o5djXD4eUkTlsXMyONrriot6/y9EolJS2jFQK/2RlxFqhT3Ehy2HLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827158; c=relaxed/simple;
	bh=EuidPfYEDWknDNFpQaCYduFSZFZBwvn8/+JpuXmcURk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hXW9TJvEC7MQUDzVxjRlXOECE1f6SLjUTUlcRkaU7y+KMeCXjSvB8eAoTzFtY0I8zlaH2v0/LLMLdnz9/iuYSCp3e+euhxFEUgH+xqnbRMLxfp6dR4wnXuxPhgG7xFX7iHoknnugNQF3QRSREY+s7eC/A+J31XKOvyQZi6aDWsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=djIFEess; arc=fail smtp.client-ip=40.107.241.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="djIFEess"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqempCvVTNuBi9eGUbY/hg2C//aq4RwiyxWuFiw5ui9ShN5oxD6AEBBKR3zQVDDvcZto5DqxrS0zrfAflwULbXuR/uNgd3KcRzzOsROH0KCpYCMgTXaiAQvAg49/gQddYqRevg4UmwHiyyRdwJDNmrMt41ESRgPMIEmWQL3qpOKBSQrPGV9c4xhdFbcRcwZQm7tpQzI5ABJFtIzkikC62SaaTgPWm/b7D2RWYjgWBWKudZEoyo2jWTDVTRkdhekYCWuQTH513dm8B9rwoRk8EUSwLzvQQAIFI0hOgzO81ZCsY1clOMIGk4VQ+KGIcTNH4qetLy3rFrWOTEI/UACPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiOVFFf0jdSf8xQV20suE5rj5bIRrCDGrLibE3xIMcA=;
 b=L4yJAK5r+WKWBaG8Lz7kwKKk3Xv+7/pzqZ1laDdaNYm/kd8ePS+czyOvIMjOOlLkysJ7wjEmfl+AacKrooCFKhTnE57tXmLlDxWFHFIx344/Pekf/oaRvngisjl1rOct7W20Xa1RKxlw37WsS96qZQMhY8ocDD5zEoDJEFnmbFubDDbAlkhUNTbq4sN3pfqvInvZU1oih6/T14+jY0i3qeZn8RTNwIgyX+p11oowH3wjfLbRBjV6GvSbRmxm5+dXhPkPRQHMsXZK7I30cjP0iekWrFRg2JOsI1zXdL2ZkqFqLTloZp9u0pO1DToM8olmjqPB9Y67veBysuw/VJ4LDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiOVFFf0jdSf8xQV20suE5rj5bIRrCDGrLibE3xIMcA=;
 b=djIFEessq45LXwpagWBDqJCbHFH0m30fQ+9gBTWQqFq0NbzoJi4Yga7MLUB32AYeV6tTi6lNvl6Cf4FsukvI9dWU0YzPDfKg1p/5/VrKyo7iChkmDqipZY0B+5omEJQMdfZf8KcKOQZ6OChyn949Sgg5sXD9E27zAJQKdPmNS6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19)
 by DU0PR04MB9672.eurprd04.prod.outlook.com (2603:10a6:10:31d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 15:59:13 +0000
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::ecae:646f:ba80:b0f2]) by PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::ecae:646f:ba80:b0f2%6]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 15:59:13 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 4/4] client: Add scripts to start broadcast source/sink
Date: Thu,  7 Mar 2024 17:58:50 +0200
Message-Id: <20240307155850.68395-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307155850.68395-1-iulia.tanasescu@nxp.com>
References: <20240307155850.68395-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0115.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::13) To PAXPR04MB8909.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8909:EE_|DU0PR04MB9672:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ecceb1a-3a80-4f61-c59e-08dc3ebf88f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IrLwJwZR0xZYlFK/QS6ED9i/AhaI0H7IayxhNuJvGZJInBmBcWIOD0K/94TwG9bXeUfmNInIcmfsJxoSQRsxrNe3IarnO9a1j6x3fIOlYJ5ENhXA8ZhtFDb0UpMEoJOXiJ6JkdEbWk2pBzzJJ4J1heEQLBnk9gaeW1FVtag8d2geGxydaEB9OeU8GZ3yXhR9huIDpTPeSo1VZGgJQaxLGo+mI+CKmasAKRgIyFQvFELwzM8agEy0BddSeKccZm1yonaSWvJZhNPgann6z5KK2Du+kyDHq76IkatLbetkF936UcqJv1pfeICIpdJvNirhO97zypaSTz9swMxvJTy3d5yYtj/Y5m3l1LOpzzpCMUO5rlk65cCTAPrEcStRCfN7IbsBgO4XmtMxl86WpWpZB4hcjBd6Cd8ssCjBrPVWr3097qKh2DfyfQf+ZpsA+Nv6DvJCtdFNj8V2fLyeMj1nGezwGPBNGL5wqunfHVTgb4xTZUK0BMEVk5xe70J7U235j34mjjQVkLSkt0n79Y5dKHi9qrBQDR21OCVCGyuZdhQFqNpG3FSX9iqhcixRmqkNxETR27eWD1rqXimPSgoszkdayIxUY1rHe/ga4D+nA7zVD2kYvxHU0/QjZ14GCvsmJkvO54IemuyzhDYYBJfaPu5Skb+/ioWL/MVqsdudDIo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MIRloljUXPiLpJium4vkcGtN7LGWIWXQ54ciDFRyF3B0mN4HnKZ/1G+zC9CA?=
 =?us-ascii?Q?nWH68bcr5YWKKzyl43bFEPtUwUD5JpSl22Z6ln55INsrzk/yIGnm6zbDWF7R?=
 =?us-ascii?Q?SuHC4JHnqtUSZNP0FgYQ/NckiEvekBNylvCVAGkPnGIDXr+61oL4PTCyQH1B?=
 =?us-ascii?Q?eraSV5CXWfmZHcFcLBEpoYRABfBtr1PCCoJTu94sGdmT7k4yf6N16vdwgDZO?=
 =?us-ascii?Q?HYY6L4l9F019pRLsHGp6tzFwrQeXDG4exyqNEBKCfZtsJTBHYdFlyAxm/Yy2?=
 =?us-ascii?Q?GCBu94HDPWZE3W0Mnued5qxCS6ua0WmsQcaEDB3RgtwjFFI9kuKcZt5T9Wtt?=
 =?us-ascii?Q?tQu6XvRH0IX23yQZHWe0wpUG9PcpJxw40EQ5GRZVr6pb+r9gn87CK72mkfUE?=
 =?us-ascii?Q?9vZlMa2FIpox2dxxzip2zncB6B3Qd7EeXZ/Jb63wXDoaOjGeDobarC7cU9J3?=
 =?us-ascii?Q?JRqBx0NJZQstzO5zLmgzYFR1SVSfnCNR1RogMlou2rbLWSeA3MKAkf/9h8Vx?=
 =?us-ascii?Q?xdLdKaXekiXiStscbff6qGn5b3mHlN0PUZNKssLdEAy9s8JHfbcyH9mrmncd?=
 =?us-ascii?Q?rS8y0Dppd9Bhj7lDgxYhXjzKxJ5GpUPH0i7yU7KP0ONn3BYWqsnAGwnoL0cF?=
 =?us-ascii?Q?pVmO+MJYUnUpoIs8i4DOnQ8epdHJF4mnbM2kkvBMaor7swlMFSGllAy5xDtH?=
 =?us-ascii?Q?9NS2lalb3e9ppfGm3QVHsmSTuOohyjCRzlRgKdgB6ZRUbAZY3yGvw2Clk0g/?=
 =?us-ascii?Q?TFnEbXDnsUHsoRD0cGiBARmvZUBrxi4bv80xhKf2f452d2U5/A6KZWvO0fnm?=
 =?us-ascii?Q?I9oHvGcC8b+TykrMurjWL7fT4a9bAGFcXkuEuP/+/KvuF4bNosx+E3FiNSIC?=
 =?us-ascii?Q?yQLKpTkkM6KYBQvo7lnt6Rk83qpSLiv0z+by+0+EZ5NlA4u5i5JFoMWnQayQ?=
 =?us-ascii?Q?p8wg8S5rZUYzZzo++Y/XubU8jKJje4cU/b6TbKyA0/z79DxWfBQhidg8JFyv?=
 =?us-ascii?Q?Kn7Gyd7gF1tWm5sniA0p1vWhNWPIpnWvswydbZjXJCkZkehtkzIKvdNDPYdc?=
 =?us-ascii?Q?/UCY66UxwVsZWOkuGKZMY+cETTY6F1rUKyn0gs61xmICh03yQiLfeAbYEkas?=
 =?us-ascii?Q?tSyWegxgVEb9xr0qAQdem22lbyUzz6iHqIn8p+bcMI099EbnVHKs8hSfNNby?=
 =?us-ascii?Q?dET52jBo10vZ2pI07FuTfdiQX4GBiTWH4HZrs/gjvCaT/0ipk+gYYYJS/JNM?=
 =?us-ascii?Q?48VgZF0S41M5gTP31dgarqcz8KTow1CL+RVWWAixfk5ozEGzBTolwMbSbNlh?=
 =?us-ascii?Q?E/nrRYfXIV+uCQDEQGnDoJNQVn0eh8/V674Hf4dbBGG4x4Bcm0EutHURUAPF?=
 =?us-ascii?Q?FDnup0XsYnLORzQmu/4iE+9V8bxWvmVCa066MWnF+wQ8uchSZxtMYQ7Gdl9B?=
 =?us-ascii?Q?gW3zU2J+okcGfD5kM+Fm+d0WxuEusw4q7HoURILOUTGNHcNcTN4vzUVniLvD?=
 =?us-ascii?Q?syINtEOiMPBgZCYsQUYaPRUDQjIhtgMz17gU9yV8WxD0K1PxblwCLaFidCva?=
 =?us-ascii?Q?p0Feo5VekZXWHaqwdivZ7PyPQ2F+mQuO3V9YvFAjLRlEKG8jYDqs75Psf5b8?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecceb1a-3a80-4f61-c59e-08dc3ebf88f5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 15:59:13.8222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUEYj8QYSq+4pFwNY/BQCRk8NuXkiLypYblfH5jT54mXu/b/wtL+aJcE/gbAtITtTFg0TLXdExW/ZowT+nH/Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9672

This adds sample bluetoothctl scripts for the broadcast source/sink
scenarios.

The broadcast-source.bt script does the full setup: It registers a
broadcast source endpoint, with supported locations as FL/FR and
media context supported. It then configures the endpoint to create
a stereo media stream, for the BIG handle 1. The transport is also
acquired.

The broadcast-sink.bt script registers a broadacast sink endpoint,
supporting FL/FR locations and the media context. It also starts
scanning, and the user is responsible to detect sources and select
which endpoint to config.
---
 client/scripts/broadcast-sink.bt   |  7 +++++++
 client/scripts/broadcast-source.bt | 11 +++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 client/scripts/broadcast-sink.bt
 create mode 100644 client/scripts/broadcast-source.bt

diff --git a/client/scripts/broadcast-sink.bt b/client/scripts/broadcast-sink.bt
new file mode 100644
index 000000000..b912231b2
--- /dev/null
+++ b/client/scripts/broadcast-sink.bt
@@ -0,0 +1,7 @@
+power on
+endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
+y
+a
+3
+4
+scan on
\ No newline at end of file
diff --git a/client/scripts/broadcast-source.bt b/client/scripts/broadcast-source.bt
new file mode 100644
index 000000000..6da9e23e2
--- /dev/null
+++ b/client/scripts/broadcast-source.bt
@@ -0,0 +1,11 @@
+power on
+endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
+y
+a
+3
+4
+endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
+1
+3
+0x03 0x02 0x04 0x00
+transport.acquire /org/bluez/hci0/pac_bcast0/fd0
\ No newline at end of file
-- 
2.39.2

