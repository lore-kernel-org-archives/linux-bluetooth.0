Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2058.outbound.protection.outlook.com [40.107.247.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C0F23099A
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200455; cv=fail; b=r0souu125nPttsmKZBJwTChu4/JbUzu1B30IffnRYtxAQFEvhKgBgofv23W43QY2TsOSrSGCVr8XXBBnG70j6TSUkcYM5jd7il8WcrLY0u8BO2n3704GLeq0+r4oRhPJ/F0Hgpl3m5Boekc09UcqVRa6LKH50yRfMqRv5cYoQYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200455; c=relaxed/simple;
	bh=kqzwLtgeM6mGvHTC28TqSxeYcdKArsAH8nn2r/dbfgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MDyupmOC4dTnBN2fL6hSelSMflm5T5wZWH+nJh4aAiIAyfAsfpUHsIk9+P1jtERAHIGjBSFeBP/qHN025QFb3XcKJsRQMtqNvUiqc3pX0L7YR9ICkeqWjd3ZKXa4ssV57zW1UFqpDYig1JNFEUIrouF4e6ohx+TBBiX+W9/Yax8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NLv/8+qm; arc=fail smtp.client-ip=40.107.247.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NLv/8+qm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3vSoI6uWkiyj7kU2widiwJ3RC2LLhUlV14YrzOFThspXXU3nN4iL18FG/i5gjOfWljcWJvwmAYcp6CjsqcziIr7f2PDTia7kuDmMjPAl16fHe4XpiT7+sFxyN9b0RlqXLn1gcZTbFAmiEe9bqhOemFPlkkd4/p0eT0hM5QEsCWojv1TXTOCM8s4pnEDLOKt0UWg4iPxdXscdvqhwddyku2BYhzL4vQICawar4eboi2pGpdn8PQbwfMTEcmBeWRTWdAkvOV6HnknVX/wwy4inIv2O0APeuondef2r2BFH4Sw3rr7QyhFFD44P8CnZwKAuqyr3Q3vdhngwVYyjc93hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsQroUMTvXFsZgP8DHTzKRqMDeKemihVEdEpLq7yqwQ=;
 b=pVsT12fSkpPs/5bRq7IA1/cP9UsnqxVkIO2UDkcmnFoGNJveKuaRioAJcq/d8BKbv3qnHkiNOUukJwjIdc8uX7hJ03WS+VwPM+DhXhzjwpQASps5sP0JtxYOF4ZafhFcJOFNNtgGk9D82HOjr/1S/YFJhNBX711Oh6qWdgYn5C2dybt+c0pYRayia1AxwmxjQouCpHyNGyE3M2XdboczohWVjJa7igiuUhpx/6MGZZ7kLTGs8nKjY/SgumSf89c9bb+mxeqoKAZc6xIjbMANvS5TZ3UC2d51NFzJaKhGVfJzkXOJvwt5LpvlWXNCg1Vt6KhI8Y4h00sgGs8eDZ9h9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsQroUMTvXFsZgP8DHTzKRqMDeKemihVEdEpLq7yqwQ=;
 b=NLv/8+qm8SPRBYlOflUJ9bt+Q8Yo4yUhp9ZX2Tt1K0wJcxLFQN0Xf8EAY2ybBrUtz6sCihzSJgbzFU+03nYu0KJHnIJbvSYgjxAFHrT87T0c5CXpQEe3n5TG+3LFQ3R26DxaY/Wnr1DzbI3oWlNR3kb4hz6/a6M3ZgjNju+7Dbz7aAlPNiLt0woXq07Mik+PzX0tatVECgKerplgLybJTtdYn0WufksJKJ9zvQoq655UqV4utlCnh+7GpTUY9zx69bTid1rIMergSZm0jZgtS2ZXHJnWseDLZUaC50XbqOOImo0VCWxyz9SHZRldrtdKbapxoxQKmycRQrOMVfy5rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7873.eurprd04.prod.outlook.com (2603:10a6:20b:247::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Thu, 21 Nov
 2024 14:47:29 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 14:47:29 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] client/player: Rework transport select for encrypted streams
Date: Thu, 21 Nov 2024 16:47:08 +0200
Message-ID: <20241121144708.79707-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241121144708.79707-1-iulia.tanasescu@nxp.com>
References: <20241121144708.79707-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::7) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: b88fd1c2-3ca2-46d5-4017-08dd0a3b6c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pw4+di4cmAUAwHkBq344uI8DBZ1yqPkdjFPwRtXeXpR808wo4W4AWjqxuAZv?=
 =?us-ascii?Q?smSpxpY9fQTq+lPkrwzuBLgAPMm4Wvbmtqsha2jQTwQQE8UnbvgxgKgdrUFR?=
 =?us-ascii?Q?qNraH0jV/EFZh54ZYSt4U7/xYPTUiG82s/9gWRzAzMnEdjBPU6MgLd2iB/UV?=
 =?us-ascii?Q?PUbMVlqa8CMc6JWpsWx+N/Fq5VXAvQZ83xBNVAGCMXyZef80zj3r4GQoC1jj?=
 =?us-ascii?Q?dS/M34DGFEEpi2gknerERPT32nzVIfTyyxpsR5f6m0lDlne3wMk9BF8w6z0R?=
 =?us-ascii?Q?SQsgQvBCkjj1U+GvkrIavjJRgMIJZ2jmPI+8Ujz6eeAd8Jx6fKGj2UJ9fAZm?=
 =?us-ascii?Q?F6xuPNuEwSC+rUxjoSa9o1PJySYqWUP1jQA9FCDlKe55Do8i7p0lSunOFS+e?=
 =?us-ascii?Q?NRhrXxNJbVRBq6VgB3C7BvTPSnC6zJpn2AjWZl/PlcHF4yZH8tJPhr8qIMIe?=
 =?us-ascii?Q?o4j6afIqEq3Bzm+bnTf/asmizaQNGnuMWpncrPzPyffztTgtffOsU0UrjBWW?=
 =?us-ascii?Q?1x/81FLNgh6M7UdDVMMQhA8Pwq+EjsN7r+VIzJiukr74+bZy9q6e1YHcKDod?=
 =?us-ascii?Q?u8pVrK/Urzpq8VYnzm+9DjsiT4Uw+Ux47vmbjmhOnlK3dfDlRsSW/II8d3Pc?=
 =?us-ascii?Q?EozwNjSBlJHGbrVQCkJTCZQCUCwAVK/ip61fYUvK7q4tmvRYbec5Ktz0E1lb?=
 =?us-ascii?Q?V4oteRhrrvBs+pGpiSl6GldYIQn0qNZ4AeGkG4ia0YfGzT8UPiED9NkMEPyx?=
 =?us-ascii?Q?t0LVjPulmJIM28l6jqLV5moSpkEN2EszQ0IIcDjfTBfpYmPMF97zb2RDfGzg?=
 =?us-ascii?Q?iGCX4rUCK/gXulD6iYm56WzL+jr9VR2TedoQyhcPhRWSWbphufPQKn/MEInU?=
 =?us-ascii?Q?AJavE52z7HCad5ym8WnYWNycaXm3HFujfybPvB73fohQp2hArpi3fUf/g96L?=
 =?us-ascii?Q?r8AtuSSOlgv+Vnf93/ze6/XH+YARM7mwbn0DTgaM987NwmWteotZhMARwXqI?=
 =?us-ascii?Q?SI9I3KbQm4ojVnGtEfKC9P7pjnnHo+1R6Av51Jwj0hT6GNr1xCT4KRpFhqza?=
 =?us-ascii?Q?y1xqDvj+NSzW4jQufrKwtWnxDHdXNSGH4E7k1svjgX8SSQUz0ymW504Ef5TJ?=
 =?us-ascii?Q?EehI3mhlxRauTFRTYXEYaNZ4DkAmrzhcLdxv05C1foGz46JKHlekOg5/px4b?=
 =?us-ascii?Q?rDgiH5HCIrj1jv6orLpyIp0zw9qTYYdvZ/l0dP6fRxaxJoZe0uzQ4NAVxNi7?=
 =?us-ascii?Q?4QmYFShuUOO3GLxj7HCXdy+2vYu69o3z6jNB+00ibg0Mros17qQx81NRc8Qv?=
 =?us-ascii?Q?4zwGSFwMwSeELqB9uXI6GOsg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DjJQDu8JoPW08BweUjrZbqVaBt+MSlilPP1vf7nWNnK06Eye267ta5/gKgA5?=
 =?us-ascii?Q?wslZRMaVQY3ekwGIc03uTP2c9pUwEUzhfElwL42lj0mJu12EKaBIVG8yDK2X?=
 =?us-ascii?Q?z31cOY6CCMq4FI6yWcHaCGEMZ9rvOPEITINXxDcFEFjDajLm/4Ot2U75xMzI?=
 =?us-ascii?Q?AohIqgPRCO4YHbA1acuDl+JDdRXyNdONb1gTF2xboimNS/ZaNGsj7RxJ2DUc?=
 =?us-ascii?Q?DNhWma8VlfYZ/VmdFJ2iGX+2XNg0WDBaLZ/YFNr0h+u6M+nrfHKk2/HPZvK1?=
 =?us-ascii?Q?jX2DWz6aZQKFTnJjq+TJbs9sWCOlZ9EZGEaQX9DHzugOWuVFXz+JJVPxB6wE?=
 =?us-ascii?Q?dSGw6MuYudsj4EfKTFwjFLLv9B4nwMTzQ6DXFXVCncU08Iyk1UPDERaKUCH8?=
 =?us-ascii?Q?xThSlz5BRhAcOW8ugzLBGYEkgIFwGEM4Vg2Epar4vRiEHn39EsWO9U/DZXQO?=
 =?us-ascii?Q?V6CPfiDJdleYcb/qykZiTUvhv00ue6wnlOoequECzzAkLplywQamCGJedKvC?=
 =?us-ascii?Q?9eP221JeHmb59m3nGuBLgDqa9hNuQBauiEDU2JkvsOf2VD1KmR9gkMd1b/iJ?=
 =?us-ascii?Q?Vy5jvHEVThK/pCiYQ4qzD+fA77u2Y21ITMit7YodsjUazwYVObZWh58df/a1?=
 =?us-ascii?Q?AVuNjwVfBI74Wk7g+mcMj5yujHnL8mnD1ei1zZxBH1i9Wit0hW7n3PbEMJ6I?=
 =?us-ascii?Q?jFGA9a3BtkY0KiYqrXCgWcsXWKesv18ORcl/50lWJ/RYNDf1DuDUl6tWylj5?=
 =?us-ascii?Q?V9/AmZb7lFZf17iRkJNtJm82CnaP1vz5aFUkAaTCbGEuq8EeyDPkkjiOSw41?=
 =?us-ascii?Q?k/OD1Y+MWh6EYAJOTl0PdHStaLqeK0xsA/1QObufisp5KkJKnBcO9oI2D0Wh?=
 =?us-ascii?Q?VYrV6JoRQucFXog4Eb3/l+BeLoabSJzFt2Yw0oWpML8uAug0nL57D3Bq+SXK?=
 =?us-ascii?Q?YpCVcrn2A03k0kpKk35iVOvxkMiITqUft1IkOyxpVBdOadN2JpBBihiSoe1p?=
 =?us-ascii?Q?vBJWD83TgCwQaK50KNCKQ/W3yjTbNh2SD0Ssn+IlDAap2ISSQxjwhzs77+bx?=
 =?us-ascii?Q?/ELmOoVdJ6WTc1yhM24Dv/oM02TIEEP5hZ2bGLEzmwf8B6LSBw2FQTGsebsi?=
 =?us-ascii?Q?5Y6M0tQ8JpTSxQ7cfaVyBUw3YWaQnZgGokVbjnjkqz2NS6sFz9P29yhfZdg0?=
 =?us-ascii?Q?/EWiyYxjPpm8iwzHdmpMWiB1fiV5hyUqBwpqxFVNxEwml2Dkb/iXnUkya0X6?=
 =?us-ascii?Q?IM2OUO01cN9mgDiN3Z16EPE3qkCuJhfhOgWT5Nnt/+g5UJ1I8QILva9f34wK?=
 =?us-ascii?Q?smEbMb2DcrDeMmOpXYOJDCHg0Nhys0JfXkpwHZjAJPc5UpJD8BbWynsKy+4y?=
 =?us-ascii?Q?Yd0DEndKSHgsz0TTRcEz6DakGsU/MN10yKnPCN9JMJ0BGelvSKq85yeUHfXT?=
 =?us-ascii?Q?x4oJkH/1qiMVFBKQceedhJypB/kWIgTgtj3QpbLxuh8u9lEcB+/unZs1402E?=
 =?us-ascii?Q?/oP0BG2e3qZhGXtyTEgdsDQ3KOLfAFYyUw0ZuoBmF4tgop9r75rQdd583m8+?=
 =?us-ascii?Q?7lB+SsMIS6bsj09s1E8muNFjWKv1yqRuBmjn7/DK88l6unJZ4suYqfk3SfaY?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88fd1c2-3ca2-46d5-4017-08dd0a3b6c1e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 14:47:29.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4SAO39U9sQpj+BKGqipwO96kieS8RZGwQfRURQ5I7GM0ssXNyzuPfIKdvMxybNt0G1aNQjlcr9c06MAUBCSXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7873

This fixes the transport select flow in bluetoothctl: If the user tries
to select multiple encrypted transports, the prompts for the Broadcast
Code overlap, causing the UI to be distorted:

[11-AE-0A-C1-F4-30]# transport.select
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd0
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd1
[] Enter brocast code[value/no]: Successfully linked transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd1
[] Enter brocast code[value/no]: Borne House
(null)Setting broadcast code succeeded
(null)[CHG] Transport /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd0
                     State: broadcasting
(null)Select successful
(null)

This commit updates the transport select command handler to first
link all transports before setting the Broadcast Code only on the
primary link (the Broadcast Code is common for all BISes in the BIG).
After the Broadcast Code is successfully set, each link is selected
one by one. The bluetoothctl log below shows the updated output:

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 11:16:BD:36:58:3F 11-16-BD-36-58-3F
[11-16-BD-36-58-3F]# [CHG] Device 11:16:BD:36:58:3F Connected: yes
[11-16-BD-36-58-3F]# [NEW] Transport
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis1/fd0
[11-16-BD-36-58-3F]# [NEW] Transport
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis2/fd1
[11-16-BD-36-58-3F]# transport.select
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis1/fd0
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis2/fd1
[11-AE-0A-C1-F4-30]# Successfully linked transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
[] Enter brocast code[value/no]: Borne House
[11-AE-0A-C1-F4-30]# Setting broadcast code succeeded
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     State: broadcasting
[11-AE-0A-C1-F4-30]# Select successful
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
                     State: broadcasting
[11-AE-0A-C1-F4-30]# Select successful
[11-AE-0A-C1-F4-30]# transport.acquire
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
auto acquiring...
Transport /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2 acquiring
auto acquiring...
Transport /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3 acquiring
[11-AE-0A-C1-F4-30]# Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     acquiring complete
[11-AE-0A-C1-F4-30]# Acquire successful: fd 11 MTU 40:0
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     State: active
[11-AE-0A-C1-F4-30]# Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
                     acquiring complete
[11-AE-0A-C1-F4-30]# Acquire successful: fd 7 MTU 40:0
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
                     State: active

The BIG Create Sync command is sent with the correct Broadcast Code,
for the 2 acquired BISes:

< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)
        BIG Handle: 0x00
        BIG Sync Handle: 0x0000
        Encryption: Encrypted (0x01)
        Broadcast Code[16]: 426f726e6520486f7573650000000000
        Maximum Number Subevents: 0x00
        Timeout: 20000 ms (0x07d0)
        Number of BIS: 2
        BIS ID: 0x01
        BIS ID: 0x02
> HCI Event: Command Status (0x0f)
      LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
        Status: Success (0x00)
---
 client/player.c | 159 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 127 insertions(+), 32 deletions(-)

diff --git a/client/player.c b/client/player.c
index eed8d2306..d126cee9b 100644
--- a/client/player.c
+++ b/client/player.c
@@ -115,6 +115,8 @@ struct endpoint {
 	uint8_t iso_group;
 	uint8_t iso_stream;
 	struct queue *acquiring;
+	struct queue *links;
+	struct queue *selecting;
 	struct queue *transports;
 	DBusMessage *msg;
 	struct preset *preset;
@@ -148,6 +150,9 @@ struct transport {
 	int num;
 };
 
+static void transport_set_links(struct endpoint *ep, GDBusProxy *proxy);
+static void transport_select(GDBusProxy *proxy);
+
 static void endpoint_unregister(void *data)
 {
 	struct endpoint *ep = data;
@@ -2918,6 +2923,8 @@ static void endpoint_free(void *data)
 		free(ep->preset);
 
 	queue_destroy(ep->acquiring, NULL);
+	queue_destroy(ep->links, NULL);
+	queue_destroy(ep->selecting, NULL);
 	queue_destroy(ep->transports, free);
 
 	g_free(ep->path);
@@ -4863,6 +4870,7 @@ static void acquire_reply(DBusMessage *message, void *user_data)
 static void select_reply(DBusMessage *message, void *user_data)
 {
 	DBusError error;
+	struct endpoint *ep = user_data;
 
 	dbus_error_init(&error);
 
@@ -4874,7 +4882,13 @@ static void select_reply(DBusMessage *message, void *user_data)
 
 	bt_shell_printf("Select successful\n");
 
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	if (queue_isempty(ep->selecting)) {
+		/* All links have been selected */
+		queue_destroy(ep->selecting, NULL);
+		ep->selecting = NULL;
+
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
 }
 
 static void unselect_reply(DBusMessage *message, void *user_data)
@@ -5146,9 +5160,7 @@ static void set_bcode_cb(const DBusError *error, void *user_data)
 
 	bt_shell_printf("Setting broadcast code succeeded\n");
 
-	if (!g_dbus_proxy_method_call(proxy, "Select", NULL,
-				select_reply, proxy, NULL))
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	transport_select(proxy);
 }
 
 static void set_bcode(const char *input, void *user_data)
@@ -5173,15 +5185,35 @@ static void set_bcode(const char *input, void *user_data)
 	g_free(bcode);
 }
 
-static void transport_select(void *data, void *user_data)
+static void transport_select(GDBusProxy *proxy)
+{
+	struct endpoint *ep;
+	GDBusProxy *link;
+
+	ep = find_ep_by_transport(g_dbus_proxy_get_path(proxy));
+	if (!ep)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	if (!g_dbus_proxy_method_call(proxy, "Select", NULL,
+					select_reply, ep, NULL)) {
+		bt_shell_printf("Failed select transport\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	/* Select next link */
+	link = queue_pop_head(ep->selecting);
+	if (link)
+		transport_select(link);
+}
+
+static void transport_set_bcode(GDBusProxy *proxy)
 {
-	GDBusProxy *proxy = data;
 	DBusMessageIter iter, array, entry, value;
 	unsigned char encryption;
 	const char *key;
 
 	if (g_dbus_proxy_get_property(proxy, "QoS", &iter) == FALSE)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	dbus_message_iter_recurse(&iter, &array);
 
@@ -5205,11 +5237,10 @@ static void transport_select(void *data, void *user_data)
 		dbus_message_iter_next(&array);
 	}
 
-	if (!g_dbus_proxy_method_call(proxy, "Select", NULL,
-					select_reply, proxy, NULL)) {
-		bt_shell_printf("Failed select transport\n");
-		return;
-	}
+	/* Go straight to selecting transport, if Broadcast Code
+	 * is not required.
+	 */
+	transport_select(proxy);
 }
 
 static void transport_unselect(GDBusProxy *proxy, bool prompt)
@@ -5223,7 +5254,23 @@ static void transport_unselect(GDBusProxy *proxy, bool prompt)
 
 static void set_links_cb(const DBusError *error, void *user_data)
 {
-	GDBusProxy *link = user_data;
+	GDBusProxy *proxy = user_data;
+	const char *path = g_dbus_proxy_get_path(proxy);
+	struct endpoint *ep;
+	GDBusProxy *link;
+
+	ep = find_ep_by_transport(path);
+	if (!ep) {
+		bt_shell_printf("Local endpoint not found\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	link = queue_pop_head(ep->links);
+
+	if (queue_isempty(ep->links)) {
+		queue_destroy(ep->links, NULL);
+		ep->links = NULL;
+	}
 
 	if (dbus_error_is_set(error)) {
 		bt_shell_printf("Failed to set link %s: %s\n",
@@ -5234,13 +5281,60 @@ static void set_links_cb(const DBusError *error, void *user_data)
 
 	bt_shell_printf("Successfully linked transport %s\n",
 						g_dbus_proxy_get_path(link));
+
+	if (!ep->selecting)
+		ep->selecting = queue_new();
+
+	/* Enqueue link to mark that it is ready to be selected */
+	queue_push_tail(ep->selecting, link);
+
+	/* Continue setting the remanining links */
+	transport_set_links(ep, proxy);
+}
+
+static void transport_set_links(struct endpoint *ep, GDBusProxy *proxy)
+{
+	GDBusProxy *link;
+	const char *path;
+
+	link = queue_peek_head(ep->links);
+	if (link) {
+		path = g_dbus_proxy_get_path(link);
+
+		if (g_dbus_proxy_set_property_array(proxy, "Links",
+					DBUS_TYPE_OBJECT_PATH,
+					&path, 1, set_links_cb,
+					proxy, NULL) == FALSE) {
+			bt_shell_printf("Linking transport %s failed\n", path);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		return;
+	}
+
+	/* If all links have been set, check is transport requires the
+	 * user to provide a Broadcast Code.
+	 */
+	transport_set_bcode(proxy);
+}
+
+static void endpoint_set_links(struct endpoint *ep)
+{
+	GDBusProxy *proxy = queue_pop_head(ep->links);
+
+	if (!proxy) {
+		bt_shell_printf("No transport to set links for\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	transport_set_links(ep, proxy);
 }
 
 static void cmd_select_transport(int argc, char *argv[])
 {
-	GDBusProxy *proxy = NULL, *link;
+	GDBusProxy *link = NULL;
 	struct queue *links = queue_new();
-	const char *path;
+	struct endpoint *ep;
 	int i;
 
 	for (i = 1; i < argc; i++) {
@@ -5248,35 +5342,36 @@ static void cmd_select_transport(int argc, char *argv[])
 					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
 		if (!link) {
 			bt_shell_printf("Transport %s not found\n", argv[i]);
-			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+			goto fail;
 		}
 
 		if (find_transport(link)) {
 			bt_shell_printf("Transport %s already acquired\n",
 					argv[i]);
-			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+			goto fail;
 		}
 
+		/* Enqueue all links */
 		queue_push_tail(links, link);
+	}
 
-		if (!proxy) {
-			proxy = link;
-			continue;
-		}
+	/* Get reference to local endpoint */
+	ep = find_ep_by_transport(g_dbus_proxy_get_path(link));
+	if (!ep) {
+		bt_shell_printf("Local endpoint not found\n");
+		goto fail;
+	}
 
-		path = g_dbus_proxy_get_path(link);
+	ep->links = links;
 
-		if (g_dbus_proxy_set_property_array(proxy, "Links",
-					DBUS_TYPE_OBJECT_PATH,
-					&path, 1, set_links_cb,
-					link, NULL) == FALSE) {
-			bt_shell_printf("Linking transport %s failed\n",
-								argv[i]);
-			return bt_shell_noninteractive_quit(EXIT_FAILURE);
-		}
-	}
+	/* Link streams before selecting one by one */
+	endpoint_set_links(ep);
+
+	return;
 
-	queue_foreach(links, transport_select, NULL);
+fail:
+	queue_destroy(links, NULL);
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
 static void cmd_unselect_transport(int argc, char *argv[])
-- 
2.43.0

