Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2111.outbound.protection.outlook.com [40.107.249.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF413C9CB
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320019; cv=fail; b=PTAzUZ12S8GkZStcOLEMzizttPWfO42mvpWMBPJPc/eiT5J//+DQ9gNtoIzkMOgEI1PdxWeG+5lqiQh8b13A/JRcFvBaov+K/XBZ2q13NTv4hg200YuwW3Jn6Pzr+jeJPe/prkSAI6PoePheS8jdkOnrgA91eOMdkgAggLglyZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320019; c=relaxed/simple;
	bh=bUudXkEh78apf8u4+4+KjkYy4bmuokxczVw5qdp5imE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=ibvmTRoHnSSA18CrjWNJedWpCafmmEnaYN5BcIW/Uv9DjzvObH/zl44CKBLPy9Gkv5q/5YRuYamNXRrx+Ryx5qgFFv9JyNSmoxyDHs44VvzA/P971UC1n7mUqG9MnbuBYkxdjmwx41YVZKctkMNiLAce1lYXYoGEM2OxT6wPN9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epitome.inc; spf=pass smtp.mailfrom=epitome.inc; dkim=pass (2048-bit key) header.d=epitome.inc header.i=@epitome.inc header.b=PG4RZtiu; arc=fail smtp.client-ip=40.107.249.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epitome.inc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epitome.inc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epitome.inc header.i=@epitome.inc header.b="PG4RZtiu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWGxu9FxSPJUVw0vFBd9RrlHqIGCYFeZWTuIzmt8GuajpwR2G6E192aJL+UFjmgAfulW4X7Bsf2LQF1+5aF4l7/p3tw6vjEXkBBHckOG2jPiAn99zh5O1PYCmcf9KI1UXF7T9GYi3O7xG3RP82xRp4okz3raNLK+g52k8uuzzUIjTXqBg8tNtHS+XrpQlujBde5EDiOAo9lreZjI1FmS7tY9JtzhXZRXnaVrhi4MgjQMo5KkBVagqudLG+bhl3YCVAKVw9e0UtPau27cTFRqlCgr36B6pdvOxa3ajw3uEEAmjp1+2137feLsgt6V7OVKVlNB9FWQZYdkKoW/6rO0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBq1VkEni7p9ogS2fR2dsa1LygO5mH5h3VBN4GXITJY=;
 b=U7ivkWCeCTsaUpKXH2b4yUN+0FggPK3WL0ND0Dm3Xtzr7JxH0xs5dSSeiO+utJAHFPiyLDVdVcpFMX1DuDThgLzAqbXdx9kcLiw2Vh37c67r3etbgAUqt8eK6zK1gVJDmd/QkUxY1utYsUpLRnB1xEeiG6x8UcyloOsZJ7kSaZ0qAE3LjwSfshhYg1tLlgdPxI+NN3jD4inyGd/2100fhaKXSlUVL+XN+YCyIjl8D11S1GIsrcTOgFOiLJQNINDmenjatmKzKqDLXW3Dv+d03kx44YJzcafFLl36Ha7iw53vwgTMzpEPBIGyy3i+syhF/x1lm+bYBlzI266/dF07Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.79.222.204) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=epitome.inc;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=epitome.inc;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epitome.inc;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBq1VkEni7p9ogS2fR2dsa1LygO5mH5h3VBN4GXITJY=;
 b=PG4RZtiuPaIOzun1yeNlFv9iThbTCpVMO/TiWgCxjPYVTU52CNl6yTAMJQHxGHK+iWGJ6C7CK+I/ZYfn6IA8UtWuvmKuJVFln7p6dZUHAj6O4s+mFowSUZZ+aAvlWr+L/I8+RwFn5WGlOfoO07sZIMeKtWfNRF9QHl3UresGn90aow3u8SmkfXeqR8FUhK6nMNf1AoaDiogYNZl4/zZGA/2i8GLNilo3O9RPelIonbiT77yiD8xWU5XogLeQcDUBVtQS3zu9sZlcFPsafDX+JSIdVJ+K2MLtymw09VyqewPk27vEpfQNnXeLETFgFvC6JnYbIV1r/3mPSktbnCPHTA==
Received: from DB9PR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::30) by FRZP189MB2828.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:d10:137::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 09:46:52 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::73) by DB9PR01CA0025.outlook.office365.com
 (2603:10a6:10:1d8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Thu, 22 Aug 2024 09:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=epitome.inc; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=epitome.inc;
Received-SPF: Pass (protection.outlook.com: domain of epitome.inc designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 09:46:49 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.104) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 22 Aug 2024 09:46:48 +0000
Received: from AS1P189MB1963.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:4a1::5)
 by AM7P189MB0929.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 09:46:47 +0000
Received: from AS1P189MB1963.EURP189.PROD.OUTLOOK.COM
 ([fe80::45d6:2ceb:e6db:f61]) by AS1P189MB1963.EURP189.PROD.OUTLOOK.COM
 ([fe80::45d6:2ceb:e6db:f61%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 09:46:47 +0000
From: Benedek Kupper <benedek.kupper@epitome.inc>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ] gatt-client: allow AcquireNotify when characteristic
 has indicate flag
Thread-Topic: [PATCH BlueZ] gatt-client: allow AcquireNotify when
 characteristic has indicate flag
Thread-Index: AQHa9He3yYrcKxbTHkWLLe2GwKmwtw==
Date: Thu, 22 Aug 2024 09:46:46 +0000
Message-ID: <AS1P189MB1963A74490BC265D1B4E9FDA9E8F2@AS1P189MB1963.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epitome.inc;
x-ms-traffictypediagnostic:
	AS1P189MB1963:EE_|AM7P189MB0929:EE_|DU6PEPF0000A7E3:EE_|FRZP189MB2828:EE_
X-MS-Office365-Filtering-Correlation-Id: 4150fc0e-b362-49fb-d4a9-08dcc28f5875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?IFRrELzqOwtsf4NJ7bz6zzeUnidRwwosqCfKh8bMNXjoozi+Ud6f99fsF7PE?=
 =?us-ascii?Q?dVvF45Ra8KipQ1psljKDz9lHfr1S4enYpIY/Myi4v0/ygtpXAn+fAfuCJARg?=
 =?us-ascii?Q?J/yE/t3lwIhWrwrqJC0eN8sW5mIBFiE95L9MszlXQwAFucxB5GUEU4YXh/Qt?=
 =?us-ascii?Q?nK9XrFc49jRZj7nsoU8Poj0giEXJOgcmxGNvecYVgGuOH2aNuFe36bFhQMhL?=
 =?us-ascii?Q?P+JtS9boadr0vlNU2yU/l8DfCzJTsv3s1aKruU1JPeUFkK7IzXf19aSPbZCJ?=
 =?us-ascii?Q?LDx86mgKqBaejTKbCnqndI9Jh/0CDMx3i/YjQWm2zNNOPIYKvfxYHKv3H+Mr?=
 =?us-ascii?Q?rARYc1nMhRU9iF8lsZY2If77EAZtNOKtNYVLjWbX7zEIxziicLHLS5hOPtB9?=
 =?us-ascii?Q?ZYQvkHRp4nOfiRZEkHA/bU9y0uf21tIuiWpZxVnz/Ygw74cSa026NFdUu689?=
 =?us-ascii?Q?IWRXA+GrvUSomXvjK29Ix1bVP7s/CJ6mXG6vNkXrPyAB8MEt0RKRThJ//aIj?=
 =?us-ascii?Q?nO4Bmnba+ImtoaWSto2aL+BSR8gMocq7OCvP3YeYbKXXUXqUB2xPN8EcLJHM?=
 =?us-ascii?Q?QTc8Kk1P4eFd6Xd/1bz/D/w9TDHSd9qfGG6oNTum0sa+HIXKfLG1EB3gWP8e?=
 =?us-ascii?Q?KGNVSwqKuyUQHvORISamofzeZeHpvtLHQFwDwROjHcQuKMmdRwQZsrNQ8fJ2?=
 =?us-ascii?Q?C8UzioUeebgqDR2mKA2ZmML4+fSUu1+gvdR2NS44FG5QdHJHysIQA+Pq5od5?=
 =?us-ascii?Q?YibCvkbnwO4wtU5lEIRF/36gAZ8gxUAxS9D0H+K09Qe6pMZ7kLa6UJUafpKp?=
 =?us-ascii?Q?cBcPl79FwyMgMI2MqmxLg13gTdCgg/AinnA53S+/NG55IAp2jtVuAxodUblU?=
 =?us-ascii?Q?BWA2xn+eCkYVOuSPb/AMjAGINTm68B6lm44LR53lDUrYrCMQj0AOyAksXSe2?=
 =?us-ascii?Q?S7De6vXNVknYAjZks057/TKFxX845f07uK5S4Bs/dAU4q2Q+WyvGiXG9qeOE?=
 =?us-ascii?Q?26py9fSpAJ3N0pc6q1dpsVxzaguO8K/SFW1SfoBcmySDklpWef4BnA4aL2tV?=
 =?us-ascii?Q?P1Y8EfFFrwQ0VR6LtOgJchCgT4gJDHbs+3kjRb1LmH5bsYzJMDPTGRsOZKVb?=
 =?us-ascii?Q?fW8iiCI3rTGgdzVNEZG9iqG39a5Z3CPKig=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1P189MB1963.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
Content-Type: multipart/mixed;
	boundary="_004_AS1P189MB1963A74490BC265D1B4E9FDA9E8F2AS1P189MB1963EURP_"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0929
X-CodeTwo-MessageID: d48b2951-30b5-4bed-8e6c-beb9efa4f354.20240822094648@de2-emailsignatures-cloud.codetwo.com
References:
 <0d55b509-ba21-4999-bad5-095c8efc4b48.66d5fd0b-0f5e-4168-b99e-0d55f52992ba.7f6ae423-2ec8-48f0-998d-7616d5fa8ce1@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	776b5fd9-ca4d-44d1-7d2e-08dcc28f56b3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?39kXd/4LJg5QF22XDmv/Hc3nA2DTeEaI1cQo1mTMFWoBSU0YuLMeiJIU9O?=
 =?iso-8859-1?Q?H0bZhHU+Vi78uwCQL+us/GsxsEqAlhTVVEBeYDnfgsB+rOm2lgWmdVAOB7?=
 =?iso-8859-1?Q?R/0nOUS8E0li/AaGt+XHVXhclCKSIbvSfsZP00qfGcIoHhfYt+/vv0E199?=
 =?iso-8859-1?Q?a/jz0L0HH+DfLL4oPSgUpdhG8ZYDlCTVPH4/BrCrUgtOKshtdnDLMx1BJy?=
 =?iso-8859-1?Q?Y/ly0lkUrw0rtvTqNdhnYCZlpLh5G53zD1JoO2CgkygqGlEsdxz2blb0dg?=
 =?iso-8859-1?Q?KEboFLf7rxEsaWsk4iublgvCCaZ/ECMtVC/MGFUUkLrMaBszUahkkA+/Bx?=
 =?iso-8859-1?Q?zZv2r5HWOm6u/JpyY9dYeOOXsUVoOY8D+4ON4WXMoBKqxVfQj2jjuoXp9V?=
 =?iso-8859-1?Q?X3X8CwDFOxCsS7N+MyXGrP5h6ltXy/sBxx1cUU+mK7mxPof/Qj/Ly+AZW4?=
 =?iso-8859-1?Q?4yrQGPrguJ1IR5MFNYWpGjbbFFk7Nw5iMpmXG8zjQd5lisCJ0l7h/QVJT+?=
 =?iso-8859-1?Q?jRRKjTecIzBKSRkEZYHwkaxCyMjW/MegNHTUb7eY6Rt5zFfQAAu98zTacN?=
 =?iso-8859-1?Q?LUIM2pezJttSXUgvSsjKlmmOOgBssDvZ4FCR3L/mnKQFVCKdrBozy6Seq3?=
 =?iso-8859-1?Q?jcsNsCNWgyXTVFKyu9CClr1bf/pB9tjYSIB5ROBkhN+EfRB317m4oQb7ps?=
 =?iso-8859-1?Q?dEeqVxhTAJsGQuXLYmG0KjypAi3PacTtlXRjJ7ljBlUyU8TueQByFDtjc6?=
 =?iso-8859-1?Q?zUoLNquMvWc06stwnK7ktnZLGx0vxaCEaGAlda6KImVW6hLol/od+SVVP9?=
 =?iso-8859-1?Q?IuYFn3T9L9EGmExe9NRHf1O6NefDVTmDn2u3tQkfQSEv4fXh2qgUCUi7yD?=
 =?iso-8859-1?Q?FAQPk3iBTCbZr/fzB5T0pevEODg6uBeHzbnJeTsrYciVIti7mTfuw2u2Sf?=
 =?iso-8859-1?Q?5gdg3mz8d4rOCnfZOLpxceQY8kMHh/tnGkhb+pXLArtq57PVG1VbV8BZlG?=
 =?iso-8859-1?Q?1V4uVPeMZ7mAR0Uxdzxr1TfmYgaOfgirwJGc21WP+VdmfAkofPa3dMMt1p?=
 =?iso-8859-1?Q?+cshQxuIRAYsdN1cUtxToSDJLS2m2AdjAmQ/NLewxyKoWRuJr2G9pg6rTM?=
 =?iso-8859-1?Q?NIClCZDLx4lcxrkqT/o9c+z+x9fmwCnKVpt8eS2DBZlH7/owXonn3QoPFc?=
 =?iso-8859-1?Q?CihWUFmhc0N+br/CffgRwtL5Qvzywilz6vCxhWHLH3Q7/2CE6IYmvqGsO0?=
 =?iso-8859-1?Q?5UNatJecHWrNkd50cAcU39EQh5vza+inqm7yrsjPOceuDRELda1OLGG3Ff?=
 =?iso-8859-1?Q?ZCxv/g0sLiD+9IESOOk/ANKtJkj5H2Bc023inDEa2kBr9nVzjaQJp7DW20?=
 =?iso-8859-1?Q?vGE5IRDYrTIxswtfWHxN6cTLj85ASl2NQwthROv2PFyUPm8oMr5Vv7rT6a?=
 =?iso-8859-1?Q?wjGwZUzb6sYH40I2?=
X-Forefront-Antispam-Report:
	CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: epitome.inc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 09:46:49.8434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4150fc0e-b362-49fb-d4a9-08dcc28f5875
X-MS-Exchange-CrossTenant-Id: 45f49ae7-56ae-4b12-9ef5-c2d16e3e82af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=45f49ae7-56ae-4b12-9ef5-c2d16e3e82af;Ip=[20.79.222.204];Helo=[de2-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZP189MB2828

--_004_AS1P189MB1963A74490BC265D1B4E9FDA9E8F2AS1P189MB1963EURP_
Content-Type: multipart/alternative;
	boundary="_000_AS1P189MB1963A74490BC265D1B4E9FDA9E8F2AS1P189MB1963EURP_"

--_000_AS1P189MB1963A74490BC265D1B4E9FDA9E8F2AS1P189MB1963EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



________________________________


Benedek Kupper
Embedded Software Developer

[cid:epitome-card-02_b006a446-bce6-44e1-9d92-f7393d79c71c.png]<https://epit=
ome.inc>
[cid:linkedin_1f596618-4864-44d6-9b3e-e082e106b6c5.png]<https://www.linkedi=
n.com/company/epitome-gmbh/mycompany>        [cid:facebook_b8860cf9-5522-4a=
a8-b473-0744d2dfb230.png] <https://www.facebook.com/profile.php?id=3D615568=
04053377>
        [cid:instagram_6d192f80-e153-45d1-91d4-fbdc5b86c5ec.png] <https://w=
ww.instagram.com/epitome.inc>
        [cid:web_c7097f79-83ac-4349-81ee-a4e57ed66b37.png] <https://epitome=
.inc>



________________________________


epitome GmbH | The ICON Vienna, Tower 17, 10th floor | Gertrude-Froehlich-S=
andner-Strasse 2-4 | 1100 Vienna
benedek.kupper@epitome.inc | www.epitome.inc | office-AT: +43 676 8967 6100
UID-ATU73252623 | FN: FN489535f, Handelsgericht Wien



The content of this e-mail is for information purposes and is intended excl=
usively for the designated addressee. If you are not the intended recipient=
 of this e-mail or its representative, please note that any form of disclos=
ure, publication, reproduction or transmission of the contents of this e-ma=
il is prohibited. In this case, please contact the sender of the e-mail. Th=
ank you very much.


--_000_AS1P189MB1963A74490BC265D1B4E9FDA9E8F2AS1P189MB1963EURP_
Content-Type: multipart/related;
	boundary="_f36c3165-801e-4f4f-81ba-182a9b0f8140_"

--_f36c3165-801e-4f4f-81ba-182a9b0f8140_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<br>=0A=
<hr>=0A=
<br>=0A=
<p style=3D"margin-left: 14px;">=0A=
  <span style=3D"font-size: 9pt; font-family: Verdana"></span><span style=
=3D"font-size: 12pt">Benedek Kupper</span><span style=3D"font-size: 9pt; fo=
nt-family: Verdana"></span>=0A=
  <br>=0A=
  <span style=3D"font-size: 9pt; font-family: Verdana">Embedded Software De=
veloper</span>=0A=
  <br>=0A=
</p>=0A=
<br>=0A=
<table style=3D"width: 200px;" cellspacing=3D"0" cellpadding=3D"0">=0A=
  <tbody>=0A=
    =0A=
    <tr>=0A=
      <td colspan=3D"4" style=3D"border: none;">=0A=
        <a href=3D"https://epitome.inc" title=3D"Find out more"><img src=3D=
"cid:epitome-card-02_b006a446-bce6-44e1-9d92-f7393d79c71c.png" border=3D"0"=
 id=3D"0.irki9ahphtr" style=3D"aspect-ratio: 260 / 131;"></a>=0A=
        =0A=
        <table id=3D"0.35d6bs4u7d2" style=3D"width: 100%;" cellspacing=3D"0=
" cellpadding=3D"0">=0A=
          <tbody>=0A=
            <tr>=0A=
              <td valign=3D"middle" style=3D"width: 25%; font-family: Verda=
na; font-size: 10pt; text-align: center; padding: 10px 0px 0px;" class=3D""=
><a class=3D"socialLink" href=3D"https://www.linkedin.com/company/epitome-g=
mbh/mycompany"><img src=3D"cid:linkedin_1f596618-4864-44d6-9b3e-e082e106b6c=
5.png" class=3D"socialLink"></a></td>=0A=
              <td valign=3D"middle" style=3D"width: 25%; font-family: Verda=
na; font-size: 10pt; text-align: center; padding: 10px 0px 0px;" class=3D""=
><a class=3D"socialLink" href=3D"https://www.facebook.com/profile.php?id=3D=
61556804053377"><img src=3D"cid:facebook_b8860cf9-5522-4aa8-b473-0744d2dfb2=
30.png" class=3D"socialLink"></a><br></td>=0A=
              <td valign=3D"middle" style=3D"width: 25%; font-family: Verda=
na; font-size: 10pt; text-align: center; padding: 10px 0px 0px;" class=3D""=
><a class=3D"socialLink" href=3D"https://www.instagram.com/epitome.inc"><im=
g src=3D"cid:instagram_6d192f80-e153-45d1-91d4-fbdc5b86c5ec.png" class=3D"s=
ocialLink"></a><br></td>=0A=
              <td valign=3D"middle" style=3D"width: 25%; font-family: Verda=
na; font-size: 10pt; text-align: center; padding: 10px 0px 0px;" class=3D""=
><a class=3D"socialLink" href=3D"https://epitome.inc"><img src=3D"cid:web_c=
7097f79-83ac-4349-81ee-a4e57ed66b37.png" class=3D"socialLink"></a><br></td>=
=0A=
            </tr>=0A=
          </tbody>=0A=
        </table>=0A=
      </td>=0A=
    </tr>=0A=
  </tbody>=0A=
</table>=0A=
<br>=0A=
<hr>=0A=
<br>=0A=
=0A=
<table style=3D"width: 670px; border: none">=0A=
  <tbody>=0A=
    <tr>=0A=
      <td style=3D"width: 100%; border: none">=0A=
<p style=3D"line-height: 17px">=0A=
  <span style=3D"font-family: Verdana; font-size: 8pt">epitome GmbH | The I=
CON Vienna, Tower 17,&nbsp;10</span><span style=3D"=0A=
      font-family: Verdana;=0A=
      font-size: 6pt;=0A=
      position: relative;=0A=
      vertical-align: super;=0A=
    ">th</span>=0A=
<span style=3D"font-family: Verdana; font-size: 8pt;">floor | Gertrude-Froe=
hlich-Sandner-Strasse 2-4 | 1100&nbsp;Vienna</span><br>=0A=
<span style=3D"font-family: Verdana; font-size: 8pt;">benedek.kupper@epitom=
e.inc | www.epitome.inc |&nbsp;office-AT: +43 676 8967 6100</span><br>=0A=
<span style=3D"font-family: Verdana; font-size: 8pt">UID-ATU73252623 | FN: =
FN489535f, Handelsgericht Wien</span><br>=0A=
</p>=0A=
      </td>=0A=
    </tr>=0A=
  </tbody>=0A=
</table>=0A=
=0A=
<br>=0A=
=0A=
<table style=3D"width: 620px; border: none;">=0A=
  <tbody>=0A=
    <tr>=0A=
      <td style=3D"width: 100%; border: none;  padding-bottom: 20px;">=0A=
<p style=3D"line-height: 10px">=0A=
  <span style=3D"font-family: Verdana; font-size: 8px">The content of this =
e-mail is for information purposes and is intended=0A=
    exclusively for the designated addressee. If you are not the intended=
=0A=
    recipient of this e-mail or its representative, please note that any fo=
rm of=0A=
    disclosure, publication, reproduction or transmission of the contents o=
f=0A=
    this e-mail is prohibited. In this case, please contact the sender of t=
he=0A=
    e-mail. Thank you very much.</span><br>=0A=
</p>=0A=
      </td>=0A=
    </tr>=0A=
  </tbody>=0A=
</table>=0A=
</body>
</html>

--_f36c3165-801e-4f4f-81ba-182a9b0f8140_
Content-Description: epitome-card-02_b006a446-bce6-44e1-9d92-f7393d79c71c.png
Content-Type: image/png;
	name="epitome-card-02_b006a446-bce6-44e1-9d92-f7393d79c71c.png"
Content-Disposition: inline;
	filename="epitome-card-02_b006a446-bce6-44e1-9d92-f7393d79c71c.png"
Content-Transfer-Encoding: base64
Content-ID: <epitome-card-02_b006a446-bce6-44e1-9d92-f7393d79c71c.png>

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

--_f36c3165-801e-4f4f-81ba-182a9b0f8140_
Content-Description: linkedin_1f596618-4864-44d6-9b3e-e082e106b6c5.png
Content-Type: image/png;
	name="linkedin_1f596618-4864-44d6-9b3e-e082e106b6c5.png"
Content-Disposition: inline;
	filename="linkedin_1f596618-4864-44d6-9b3e-e082e106b6c5.png"
Content-Transfer-Encoding: base64
Content-ID: <linkedin_1f596618-4864-44d6-9b3e-e082e106b6c5.png>

iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJ
bWFnZVJlYWR5ccllPAAAAUdJREFUeNpiZIACC1uLBiCVD8QCDJSDD0A88cThEyAzGRihFpwHUgYM
1AcXgBYZMkN9EMFAGyAhIy/DyAi05D2Vgghn0DHR2AIQEGDBJsrDw8Pg7ekFpg8dPsxw+85timwB
Bdd/dMHkxCQwBoEvX74wuHl5UGQJEzZBSQlJFF9RCrBasnL1KnAQgXwxcfIkii3BGlzEAlUVVTBN
KM6wRjxynJy/cJ4hOy+XYeqkyQyGBoZgsW3btzPY2drCgxLk45b2VnAiITq4CAEvT0+UuAKxO1rb
UeKSYktALgfFGwijW050cBECIMPnzp8H54eHhoFpI0NDoDiVfAKKJ2RfkZWEqQ1GLSEJsOCKWFjq
ef7iBZjeCsyA585DIvz58xd41VK1WCEluD7Q2A5wzTiRxpZMpEtrBZy6QAwg1UjFoAOZ0wg1lwEg
wAArTHtTGbG9tgAAAABJRU5ErkJggg==

--_f36c3165-801e-4f4f-81ba-182a9b0f8140_
Content-Description: facebook_b8860cf9-5522-4aa8-b473-0744d2dfb230.png
Content-Type: image/png;
	name="facebook_b8860cf9-5522-4aa8-b473-0744d2dfb230.png"
Content-Disposition: inline;
	filename="facebook_b8860cf9-5522-4aa8-b473-0744d2dfb230.png"
Content-Transfer-Encoding: base64
Content-ID: <facebook_b8860cf9-5522-4aa8-b473-0744d2dfb230.png>

iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJ
bWFnZVJlYWR5ccllPAAAATlJREFUeNpiZIACC1uLBiCVD8QCDJSDD0A88cThEyAzGRihFpwHUgYM
1AcXgBYZMkN9EMFAGyAhIy/DyAi05D2Vgghn0DHR2AIQEGAhVYekhCSDkaERmIaB5y+eM2zdvhWn
HpIs8fb0ZijILWDg4eFBET934Rx1LAG5vKayhqzwYiLFF+QCon2iqqKKwj90+BBDeXU5dX3Cw4sa
DyvXrKR+cFECWAgFES8vL5jNy8OLM/g+f/7McPvObZzmgHL8f1ySUydNZTAyMCLoUkLxQ5XgwucL
qlly684t8uNk2/ZtDOfPnwezvTy9UIoSUA5/8eIFxCe3b5NvCXJRYWhoiGLJth3bGM6dPzd4kvDw
suQDje0A14wTaWzJRCZos+UCjSwAtVYawHECarYAqUYqBh3InEaouQwAAQYA8KZf6WhAAToAAAAA
SUVORK5CYII=

--_f36c3165-801e-4f4f-81ba-182a9b0f8140_
Content-Description: instagram_6d192f80-e153-45d1-91d4-fbdc5b86c5ec.png
Content-Type: image/png;
	name="instagram_6d192f80-e153-45d1-91d4-fbdc5b86c5ec.png"
Content-Disposition: inline;
	filename="instagram_6d192f80-e153-45d1-91d4-fbdc5b86c5ec.png"
Content-Transfer-Encoding: base64
Content-ID: <instagram_6d192f80-e153-45d1-91d4-fbdc5b86c5ec.png>

iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJ
bWFnZVJlYWR5ccllPAAAAeZJREFUeNq8Vj1MwkAY/cCOkDBCQuIiu+3EAswyEhVXAhNEZCPGkEiI
mm6gYQNJ2NCEEWdgYaLsuJdNh+7adxTSlJZWbX3J5dr7+d59791d6yMN8UT8Vq2u1BKiv+NTLa3Z
dIaY5NMIJLU6JvexUIn4Ay2DC/IG4ehh1OdTST5ckshSOr/HBECIs+op5AqUPklTJByxjSKvZBq9
jajT65j2m5JULiuUPcuyyYPXASmKYkkQCAQomUhSPpdnz82n5s4YePKlb8DKhy9DWr4vqVgu7iWI
HcUolUjRfDFnC8N75jzDFqeH3zgxElnLg9SNBFiAwAtbCZEtMhCOha1Um/m2cgF6AshQu64xWTbA
6ru9Lq1WKxpPxxQMBi0z5pxsD/FeZKtFYEmSiOd59q6cKlS9qbIxyPDXJEwijaBULq0beyrxncgy
Q7/RAyP8tiSaxshAD2wMKw9+TCLL8nYn6QHJ9P37wDk5aJPphEnTfmyzjEC4kdBOKsfGNx4aJAbX
5qMAIEa7E3D7TrJ+O8N0mAwPIJExA/14W082GuPuMk5E4Lk0NyXAeCuPODMPcF/hNPef+0wWJ3cX
ssQ8M4927i4vbmFLEjfh1z76XoJ9GVsek7T+5W+FbWE8qFXdRekQp67FpW8BBgCladecP+kHQQAA
AABJRU5ErkJggg==

--_f36c3165-801e-4f4f-81ba-182a9b0f8140_
Content-Description: web_c7097f79-83ac-4349-81ee-a4e57ed66b37.png
Content-Type: image/png; name="web_c7097f79-83ac-4349-81ee-a4e57ed66b37.png"
Content-Disposition: inline;
	filename="web_c7097f79-83ac-4349-81ee-a4e57ed66b37.png"
Content-Transfer-Encoding: base64
Content-ID: <web_c7097f79-83ac-4349-81ee-a4e57ed66b37.png>

iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJ
bWFnZVJlYWR5ccllPAAAAiZJREFUeNrElj9IG3EUx1/UMYJjBKGL59xzytDEWZ10kE5Ci5ugo0QU
LGolm1F0EguODjqps0kHJ8/Zc4+bgtnrfR73ynl/EtrG9MHxy/v7/b0/9y45CalYKm4Ex3LwDMm/
03Pw1G4aN8SUXAjgBcdH6T7dBUBuf5jBZ3kfKox8GMnlApCnLpUos3QDnQDy+bxMlCak/KksjuPI
cGFYmo9N8X1f6j/rct24llar1S7EEJn8ytKWS2VZr6wrUBYBsLmzKfVGPdOmL0sxPTkt1e2qvLRe
ZHd/V4ORwezcrJ7wyNFjh/0fgZDBWmVN/Adf5r/Oy2B+ULPZ2tlSAE545Oixwx6/NEqUC+fz03O9
IQG48dnpmerIwigqw+fk+ERBZ+ZmEj0aiKPSZJy0DN+rKrNmH+wdvLFFHpXZkFxcXbQvF1Nk9Ye4
nTU43vCo3vqEf5wSmYy743L/cC+LS4vKL3xZEGfUkZXVld/AlgUlY6qOfhypjKwY846NJ2XP8xKG
UYA0HsIP8I4gpOy6bsIw7pwWDL808ES5br1bLZk11GrOEDAMRiZnbO1SY6Nj6t8xE1YFJbObWuD4
W2+86bFHhv9/eU/6snYRNzvcO9QAl1eXylNGm0B45Oixg8cvbVmmrhXGktXB6HJDssKZ1UEwTnjk
6LHDPmtJ9mQLtwWJroqpySnN4i++J9KTLyM9qcn7Uq0n/1Z0uvgRHN/C/0tdKRHxwrjyKsAALsA8
s/66nd8AAAAASUVORK5CYII=

--_f36c3165-801e-4f4f-81ba-182a9b0f8140_--

--_000_AS1P189MB1963A74490BC265D1B4E9FDA9E8F2AS1P189MB1963EURP_--

--_004_AS1P189MB1963A74490BC265D1B4E9FDA9E8F2AS1P189MB1963EURP_
Content-Type: text/x-patch;
	name="0001-gatt-client-allow-AcquireNotify-when-characteristic-.patch"
Content-Description: 0001-gatt-client-allow-AcquireNotify-when-characteristic-.patch
Content-Disposition: attachment;
	filename="0001-gatt-client-allow-AcquireNotify-when-characteristic-.patch";
	size=1504; creation-date="Thu, 22 Aug 2024 09:45:00 GMT";
	modification-date="Thu, 22 Aug 2024 09:45:17 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0MTJhOGE3YjNmNWIzY2MzZWYxNjBmNDk2NDg2NDhhMTg0MjEwYzE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCZW5lZGVrIEt1cHBlciA8YmVuZWRlay5rdXBwZXJAZXBpdG9t
ZS5pbmM+CkRhdGU6IFRodSwgMjIgQXVnIDIwMjQgMTE6MzY6NTEgKzAyMDAKU3ViamVjdDogW1BB
VENIXSBnYXR0LWNsaWVudDogYWxsb3cgQWNxdWlyZU5vdGlmeSB3aGVuIGNoYXJhY3RlcmlzdGlj
IGhhcwogaW5kaWNhdGUgZmxhZwoKU3RhcnROb3RpZnkgLyBTdG9wTm90aWZ5IGFscmVhZHkgY29y
cmVjdGx5IGFsbG93cyB1c2FnZSB3aGVuIHRoZQpjaGFyYWN0ZXJpc3RpYyBpbmRpY2F0ZSBpcyBw
cmVzZW50IChzaW1wbGlmeSB0aGlzIGNoZWNrIHRob3VnaCksCmFwcGx5IHRoZSBzYW1lIHRvIEFj
cXVpcmVOb3RpZnkuCi0tLQogc3JjL2dhdHQtY2xpZW50LmMgfCA3ICsrKystLS0KIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3Jj
L2dhdHQtY2xpZW50LmMgYi9zcmMvZ2F0dC1jbGllbnQuYwppbmRleCA4ZDgzYTk1NzcuLmE2N2Uw
NGVlZSAxMDA2NDQKLS0tIGEvc3JjL2dhdHQtY2xpZW50LmMKKysrIGIvc3JjL2dhdHQtY2xpZW50
LmMKQEAgLTE1NTYsNyArMTU1Niw4IEBAIHN0YXRpYyBEQnVzTWVzc2FnZSAqY2hhcmFjdGVyaXN0
aWNfYWNxdWlyZV9ub3RpZnkoREJ1c0Nvbm5lY3Rpb24gKmNvbm4sCiAJaWYgKCFxdWV1ZV9pc2Vt
cHR5KGNocmMtPm5vdGlmeV9jbGllbnRzKSkKIAkJcmV0dXJuIGJ0ZF9lcnJvcl9pbl9wcm9ncmVz
cyhtc2cpOwogCi0JaWYgKCEoY2hyYy0+cHJvcHMgJiBCVF9HQVRUX0NIUkNfUFJPUF9OT1RJRlkp
KQorCWlmICghKGNocmMtPnByb3BzICYgKEJUX0dBVFRfQ0hSQ19QUk9QX05PVElGWSB8CisJCQlC
VF9HQVRUX0NIUkNfUFJPUF9JTkRJQ0FURSkpKQogCQlyZXR1cm4gYnRkX2Vycm9yX25vdF9zdXBw
b3J0ZWQobXNnKTsKIAogCWNsaWVudCA9IG5vdGlmeV9jbGllbnRfY3JlYXRlKGNocmMsIHNlbmRl
cik7CkBAIC0xNjAxLDggKzE2MDIsOCBAQCBzdGF0aWMgREJ1c01lc3NhZ2UgKmNoYXJhY3Rlcmlz
dGljX3N0YXJ0X25vdGlmeShEQnVzQ29ubmVjdGlvbiAqY29ubiwKIAlpZiAoY2hyYy0+bm90aWZ5
X2lvKQogCQlyZXR1cm4gYnRkX2Vycm9yX25vdF9wZXJtaXR0ZWQobXNnLCAiTm90aWZ5IGFjcXVp
cmVkIik7CiAKLQlpZiAoIShjaHJjLT5wcm9wcyAmIEJUX0dBVFRfQ0hSQ19QUk9QX05PVElGWSB8
fAotCQkJCWNocmMtPnByb3BzICYgQlRfR0FUVF9DSFJDX1BST1BfSU5ESUNBVEUpKQorCWlmICgh
KGNocmMtPnByb3BzICYgKEJUX0dBVFRfQ0hSQ19QUk9QX05PVElGWSB8CisJCQkJQlRfR0FUVF9D
SFJDX1BST1BfSU5ESUNBVEUpKSkKIAkJcmV0dXJuIGJ0ZF9lcnJvcl9ub3Rfc3VwcG9ydGVkKG1z
Zyk7CiAKIAkvKiBFYWNoIGNsaWVudCBjYW4gb25seSBoYXZlIG9uZSBhY3RpdmUgbm90aWZ5IHNl
c3Npb24uICovCi0tIAoyLjM0LjEKCg==

--_004_AS1P189MB1963A74490BC265D1B4E9FDA9E8F2AS1P189MB1963EURP_--
