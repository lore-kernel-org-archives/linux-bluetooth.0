Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650533F7898
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194539; cv=fail; b=c0ooNSwuTbdhtuH3/uH/pLEW3o/+NiOBQLvUvUUram4Z5UG+KSClUa4UOqOzNkyPjlRLtYdAGlrqXbhDKSyRM0iqPVmSBmxNYDSO/ZSk2RuD0YXA86N5S92b3KdPK+P1eGmz9WVSgqe8vtQ30ccpJZOqHGuQpW5kvK4DYENhKQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194539; c=relaxed/simple;
	bh=m0HwazGZY7eypKQeLx8j4Nq6lmtQe1QkW3DB7lwfK4Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KUvIn/JW5NYXbw+PymBsRJyeR9XX8mnOFDXJMF/+2eDeA6AIG2pDvUxA+gzlnYYltlulPpspuQrIS/T6Wvy7DYlufGk0YuQa6JkDmrPWNd+lyvJiYCy0JgF/gO1DX0UAiV9Tge8KewOb+Y5xM6FxZVaDrKDiqhNUKx+Pw1l4pto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=opf1pR8M; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="opf1pR8M"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7Dvex2115230
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=m0HwazGZY7eypKQeLx8j4N
	q6lmtQe1QkW3DB7lwfK4Q=; b=opf1pR8M0/PTK1Kf3SugV7dWSirfM0XEYda6EM
	C2NmNnvgxEmkr8rVQ9wxymI0W11rKDutAz1OYe1k6yKIk/y5pi00mWMmxdCGJvrx
	plAzmZcyWMdhhDSMNjb7kOE0iLdaVZQzHWPDt3wZCJ72EVroJFQk4dsVuaKfzxAj
	8uhCyYTLC2iNoGYPyE5fZ3zV/TGqgxFiQ6gsqYmjqhuGHF5rF9vLMBw52YckC2qo
	7mtUFXaXHuMGZlLp22OPyy+k35NmmB3rFvSec8VRKwGBEJgaKHvofdciM2J/ZVOm
	12gDs5x+Ebi7ZVY0M/yEoW0I+71ZJFHA4qoHaRfNT9boUNsQ==
Received: from dm2pr04cu003.outbound.protection.outlook.com (mail-dm2pr04cu00306.outbound.protection.outlook.com [40.93.13.62])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feeg1k3bd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:35:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PY80o5P4FqnowM40bz0qAUsUfZ17NBOQ7xnU3w2ZPH3GsHXBgCvJsyS7GnxMepT6qotFvay/m5cb9Jb68OgvIpPOD69psAKYDF+ZpJlCi5RxXy2CM8QJgwWfHb3BLnOMRYdbE9eVMkFVzFqpso/Hr6ZsRb7JnfehGQmCA0bQVaXnl6G1pDXKsUJaMdYRPfkBJZAChNlyJeNSWXvpIStl6oCGiv/kgHyrda65EG5PJ3G3F/e7BIESxXedBQM6nWUN7jekM7io6EW61JBHTDokrCoSYzvEj3/7VmXm9EDqpncJEfg4+M005v3+FZo2UbK4uFZCF63zesJxxfkI9pd3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0HwazGZY7eypKQeLx8j4Nq6lmtQe1QkW3DB7lwfK4Q=;
 b=k0F8IAE3ok4MYaSr/qtA+VEGrIms9f+k/nTsgLlyYk1DoBg7HtfWEpAAWCkQfF7bRwMdztZGHEkzOZwjdmrazi3XCRIO0T/K3/3xmAH9W+kT3Bz/CMc258n4hEu6CupVwaZdL+vcDDafO97VPfVjwCZd25QRP8UUm8J5BOsmLPvpQtlepOCT4v4u1aJ++qcKe/eWeCXSx7w90wcOai+sVCx0UGDRBj1KTM/0HcNmWKMLGFaZ60VbUE957j2+shdPn7al52rADDTH7q1znmJypdaL0DsIkALHGiz2CSFIbmOnHpSZX6TYxQVathGVRK+zmM9E9wn7yvf0vEdGlOHjFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CO1PR02MB8667.namprd02.prod.outlook.com (2603:10b6:303:15e::24)
 by PH7PR02MB9357.namprd02.prod.outlook.com (2603:10b6:510:270::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 09:35:32 +0000
Received: from CO1PR02MB8667.namprd02.prod.outlook.com
 ([fe80::e174:cf1f:9fe1:726a]) by CO1PR02MB8667.namprd02.prod.outlook.com
 ([fe80::e174:cf1f:9fe1:726a%3]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 09:35:32 +0000
From: Yixi Cai <yixicai@qti.qualcomm.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Cheng Jiang (IOE)" <chejiang@qti.qualcomm.com>,
        Jinwang Li
	<jinwli@qti.qualcomm.com>,
        Eleanor Xiao <eyxiao@qti.qualcomm.com>,
        Huali Xie
	<hxie@qti.qualcomm.com>,
        Jie Zhang <jiezhang@qti.qualcomm.com>,
        Peng Cheng
	<penche@qti.qualcomm.com>,
        Mohammed Sameer Mulla <mohamull@qti.qualcomm.com>,
        "Ling Li (Linda)" <lingli@qti.qualcomm.com>
Subject: Missing test steps for BNEP/DID/FTP/HFP/MAP/OPP/PAN/PBAP profiles in
 BlueZ doc tree
Thread-Topic: Missing test steps for BNEP/DID/FTP/HFP/MAP/OPP/PAN/PBAP
 profiles in BlueZ doc tree
Thread-Index: Ad0VBlEiPI0L+ouaQSmhN5euOmquhQ==
Date: Thu, 16 Jul 2026 09:35:31 +0000
Message-ID:
 <CO1PR02MB86670E3FE83E8FFC3AE6915098C72@CO1PR02MB8667.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR02MB8667:EE_|PH7PR02MB9357:EE_
x-ms-office365-filtering-correlation-id: 84044576-a64f-4228-7e61-08dee31d9495
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|38070700021|6133799003|11063799006|5023799004|56012099006|18002099003;
x-microsoft-antispam-message-info:
 W8PcKloHwb8URckhQt+6hdqlSISHOCal1ns9ox6cwiLicSWG5iG6y8tWS4G/ItPvDXlwQG/DyXKu/MB1cMydcfNzsdG38lvovoxm+O6el3nMoWd3+EWUy7h8XitAhdK7w8KT5bVYpNTwsQbePhneFs4IwJG6IOctMjZQM7a0vycDQtMa9+oRBmt8ruxhT+3F7VaxZ88smfdzMZ5ZPrMXyLYRoVTHi/Jddtw/mN7wPsDbLLvYf0EK3PLl12KBOIH1snSoLnMyA+ubQ1Dg3D995vfsTR27Ogebv673Xv2AnjB3kwWMpBlTM5L9jz+VmMupL2F88WSZ+OPaJFgk/XRAZzPg1PbzdV9AssKPahsQSfkLu20wD1F1+3MXti33hGDdGhcvdSrQ2bST00E2RAjp+22Nz6KcR7QAmCftxUU0fmqdR+KHXrWH37hCIEOSo78YLcH87kK/QDfgl80317Ei1zk6He1xZJx+WypFizkUAKVJ9t62TeVjlky0FBvnPw+d5+YWv3EREJENwwEMhzDC3R57TQ+ExQda/KIrtXVRp6JU24SsnbCvTVHzfH7xwbq2DKb51boRKnuC6DiuVaooE6n6+lvsQoJ0p3hzLtJXrOrNVeyXEItZBNZfvsPrCnfF2BIMIJT0qdz47PNjypvVp/az3ixBRytjOaeq+dh1dA5kSz5AeafsuQpdNVraqkCiHMA+llMxa1Gp85Gd0e7kuUh1HjE1rnJBkrHiFnoeJQs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR02MB8667.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(38070700021)(6133799003)(11063799006)(5023799004)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Yub7SFmR7SEcYF/mU1i6/0gdku+Vi6t9xmBBN4up1Qd6uQcURCV/tL3BuYRL?=
 =?us-ascii?Q?ZpxQacVmmw38cHT0em9+Vuhd9J3hMB4JqConSgfSLmPonn+rDJgDRZMuudm6?=
 =?us-ascii?Q?htqzzeoVFIBTH3IlophyjsKSG7TZtV10r/RMPakoZOFt3kpzkxrGQUxTOxf6?=
 =?us-ascii?Q?sNgOFMuDeJeedSBmP8qh200+lAUuYVhE4B775xoXGDJSDSVxYBlwHztA0pm6?=
 =?us-ascii?Q?JyskeU6IdYh8LCwR7YQJhQ2ZAxMEEh8DAzpSYCitHJEXGrwZ5pFwpeLTwQxT?=
 =?us-ascii?Q?KSgY3AUnd4HiSUAKcbigrYVKSbYeBRRdiJZdQ8d1aK4eaZCBdd5WG67lUL+m?=
 =?us-ascii?Q?mqeCnmSKev9zrdBo5yZp3RewJPFpA93dxWYLrx/Yc7K5QB5tMQQbEEGfrv7n?=
 =?us-ascii?Q?9zxrg9YS5KIo8j9m91amnF+jBISX6iI9APTkylSAcCiihugsau25PFUR5g6N?=
 =?us-ascii?Q?CpGSOv8aFrPpqXXWm96i1NAHLlIF3FVAW3iboAMqriqlRaGj38Vx9U5JEzPQ?=
 =?us-ascii?Q?9e3TkrOY2chWUT+iHKtJ5aG6Q4O2+bVqrn9rWH4Zu5TuD+qj4jU31PYw/fHC?=
 =?us-ascii?Q?KyCTP7xq8fwJgg2LYuq5D8NjdD41UPXLvBHbwhDK0mpr/4O7dUSwa3QvPeKi?=
 =?us-ascii?Q?YURV2/3AQEJwmhJ/xWbfqV9GXRR+T3CvSOTW0sQ75zV/rBjhOvL7gXWLqhwS?=
 =?us-ascii?Q?fOMmVeEe0lMJiW6K6lLwtDNCFVOb48J9cbuRQ2TqYdixVeZ6rzRA7NQJOi+5?=
 =?us-ascii?Q?HUu6s0jPKYaqwCbp3sa0U7CE1YiQ30/PkNbeU2XYe4VpwtYqcsdvG3FeuQcI?=
 =?us-ascii?Q?d6E8aV1ue/muuwgpMVCtd0onFGf+y96GhRJcl5ExhTiFY92m609HL/68tZFJ?=
 =?us-ascii?Q?gVI786bMfchmtjq7iDntXo8pYmOGvGxkOIGUGOzTYD9MAWKfDkCpzzvJedJI?=
 =?us-ascii?Q?AENVnUrnYwLnzLV7wAPiz1Uct54LjP2rxg+GJJetRS1w3GqITx9HwaIhKGK8?=
 =?us-ascii?Q?agKwYNMS/YkNKbOBO7b2M2IIc6A6Qm0LE6koS64wZTi0s+EI2YsAbGT7hxkM?=
 =?us-ascii?Q?lySIDR2Bm3VHCFscs0SGOJrtGJuTFoFS6+dQv5OTnWHpXP5huEuX38BaJ/KM?=
 =?us-ascii?Q?ly4m/SxIC5QiKwEIjU1RoOFBDHqhneDicCaFtYaPkSgRv/CxwMJ048Yoot2y?=
 =?us-ascii?Q?8kuLviIRh+M6cp9ZV1y5VVCwEWUXw71f3D3PCBbKnT1f1ws2DrvdKnvsZDA0?=
 =?us-ascii?Q?FGFhtA6/v0uoxUBoUNSPpjoCzVssvM29G0oXKbTkw21g2iCkMjMEMHtNW4BE?=
 =?us-ascii?Q?vu/ZoESFWIBgRS0NpZeeviCtRsg4u8VZrhLDv4y58l1BTlab8WhZdAT1tpFe?=
 =?us-ascii?Q?X1+gG8TZuAqY/5VA71T6ZCHEDgPXnCjx5EmPVLLUHlvazVeVvaOnh9EW/zIN?=
 =?us-ascii?Q?t8Kf4U9KFOUxJ/YAOgSvSuPq5yOo9/O4bWNlXEaS0+2nC1+A+EFzuJc2l6Kf?=
 =?us-ascii?Q?zy5K8K2PNA875idmiQLed0FomJ9fdLv6/Qho/SEvoa/HSc4AZpA7OKbGDpbS?=
 =?us-ascii?Q?DwfeD1mrprZ17xV98DNPbuzO5YZA+Gwyax901nytCnXYTiXRTVcbOqLgAt5R?=
 =?us-ascii?Q?nYyVF8hif8zqE7FkueCfTwUcAMZRHAcE0Vn/NBmwymaungj0QmH8UDXqUU5r?=
 =?us-ascii?Q?xQFOA6B6lpWqbPvXicHKwj1+nR8vg4JC+GZEd8RlRAoCwX3JBHvWIRpQL+pW?=
 =?us-ascii?Q?zOMldZPHrA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ItoJnm/twhF8vFJGTV0y5DfMm7eAJ48lPUZsfQ85xFh71E0HwjRHVo7NrplWSNuHfQyYvOnfrkhlCMY8CIwF1+3DTksRZeiJbeimRNHnHTIhUlsocGYF4L2CGG5h7/1j6e+uOMG5qW11eLpqhT00h0EBbT+TA9XjAUJUPouTdDB7YVBznJbcHTclRSUsgf7X6T0rv6v6UotO7t8X0HVosE9BpgDhblGqySdemOijCOyL4YQtP3dUxD/2wNkNzGUUOEZT8xB/cWtnW4zzoSAYYQmJfSI9sT1aHqo7CrNFf8+HIwTj1puuNf9Bx+GT/74dTaaulhy9chwZhm+Ma8l5sQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	axIJaCwKQP+oU0AY063sfr/+CPAP166zi3HAhBcs/P/PMKsc+o/fMf7DkjYx+T7eCVSujKeMfIrIl2XPI9KMV1/nPLZFsm5xvrb7ZaCKiwpKr9CX5AKo0W4cOkOUzghEPck48Krhy180ILCdxv8MlRP87D68D8Lo/o82GwkF8/jqw3WdvfiaeG56BNjQcrd6XoRU5R+CeUYntbZLNqUjMV4bQ3tgpm0z5Bb/SDUoA2XuzPf20x/pqLxNH9jWjQbheJWpU0OhrZ5b2TMB6tMHTN2FimMqMLzM/M6RaHeexqiCYK/AYwnQK6I9Si/z/GZvRtGMSUIzr0v1cbD791I6R4o5LmP2u6Z1+++yNYMnAh+V80k3VwD58bvbq8ImFJ17gceKrCPlFJQU9uc0hi71/pG8WhDLJD4YeL6EN4Jh+fjNXgh+ZdrGwc5fmqg4fAHGWTmvM+fb2MC6l/UZdUXYpwN6AuLjAAl1/ucZVOF5/Y4BOA/IP187/Zt+3rZCE0ou55gc2m3rUGMt8jCYiHy5TRx60br2FakMMddud5eXldWou/C3K2ON+KoReWR+Bp4LnZbSgT6Q9fujVYHe7ecv2pFYDDWMZDskJsMlRZr1eINxbcnc+BSpeXImP6HTXivp
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8667.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84044576-a64f-4228-7e61-08dee31d9495
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 09:35:31.9413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IFelmj0zEDVx6YcKKncOnOuLYUShcW2vFfnTe+wSj1T/WMLtCm9zHTo1IYmxpe53pe12fgfJ3SPktbxw0ZlNoYTkuxwSOWaBJLpXvskNxmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9357
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5OCBTYWx0ZWRfX5xuakdz70FUr
 Yxfr4uJFcTFaIkXNDU5VQJDEK9TJpuwW4GHwFUnobNZiH7EF8ekSKPLp3gZr53/fsgHjMzwZ7/E
 KZOOK7HMIBNj75gzmu3gVpnyf1oDcaraVYC0ZvH7gcF47z9d32gAuqUSikN9/slBGiLSrWjs25v
 XLihQ43eukwPP50Mp1SUIh/nRwOCa1E872TdU/PAFLkfJ/5BnUpINws0dzJjm188f+IhysRohd/
 0mIlJAEY00/vaYeE2f4Gg8kEpbIbxvdVIYtTSNJIiJHgBim9gHfTCApRlH/MnlsG2GQOxZMW+XI
 1x1qkP+yo2s0TkQTj4LArVz2JC5m+KqoQaI6q8E8+G3h24kLGhWdHsCXGvFnalotjEWwvkll0p2
 voA++/R6tYzTEdDbQgB94Jtq8fussEMXsMoRrn2VseXj+VFtDnRKuhXbo5YjBJa2hCop+DE1QIC
 MMeZ1E00Bxw6oOr5dTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5OCBTYWx0ZWRfX57ZGZrgHj02s
 ric9WtBpv8b6EUtO1Wl4KtT+3s3N0Eax8SlVvInp6bCrOjE2UQv/j71MDQ8UKCMwB7c7e4u4zIR
 QdEHHT8hGdaCRdwUj2fZ496+EujqFOY=
X-Proofpoint-GUID: VwJGNnKLJIwySQDYiKYw8mqIE57AhLEg
X-Proofpoint-ORIG-GUID: VwJGNnKLJIwySQDYiKYw8mqIE57AhLEg
X-Authority-Analysis: v=2.4 cv=SsOgLvO0 c=1 sm=1 tr=0 ts=6a58a5e9 cx=c_pps
 a=ftK1B4U+KuHZUR4f5igEJw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=3cqyFr4hi9waq_PBeLgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160098

Hi BlueZ upstream community,

We are currently working on BlueZ Bluetooth host certification and are look=
ing for profile-level test steps in the official doc tree: https://git.kern=
el.org/pub/scm/bluetooth/bluez.git/tree/doc/qualification
However, we noticed that test documentation for the following profiles appe=
ars to be missing: BNEP, DID, FTP, HFP, MAP, OPP, PAN, PBAP

Could you point us to where we can find the corresponding test steps or cer=
tification guidelines for these profiles?=20

Any guidance would be greatly appreciated.




Thanks
Yixi
