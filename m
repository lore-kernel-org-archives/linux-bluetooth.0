Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B41E152DE9
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 May 2024 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714737827; cv=fail; b=GVDJP/fVvfHoOWCxDHLAzDUv7nBPGBOTzzkgmuoeugDgT0d+prb/ldwlXoxgLQI6zgxtBhMtZABTqd9Lipk8k65tKKW7QG/BSaEHFZzmnUk5ZCnLx2XB/vuW7vcIe6rDqnv4m4plArZ1W7Rcd+FITF3iWhHNpP30NJNVk9teKKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714737827; c=relaxed/simple;
	bh=1s61otCqEL6BiWFdCf6gLOdlTgRZ/00wMOBZAxO85nU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KfPcUIGUIG+EvFUQbmQupJiJBCPc5IYvW2tvehdiMysktOb6KQtXkV6Hq9i+gGCsse1LVwbLIiF38UyiZ/d2gNq1RgIR3xwFl8E8r4ggXDuTB68uRgqVGJpWfW0crOZMxmdtA+Ho5X5heag/OTddbCWiqziEX6R78MmBeU1d9w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UR8tI9nc; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UR8tI9nc"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 443AeaHT001642
	for <linux-bluetooth@vger.kernel.org>; Fri, 3 May 2024 12:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=qcppdkim1; bh=Z5iLdl0
	j73au+BAAIfXYRroHauQnEeIvDcg8+4NlhY8=; b=UR8tI9ncxrRz6X5h0glRDmP
	eJG1lOwbLOG/gTVc4RsR20zo0Ss5jDEiSOls8OV0Wb+b/17htuOYytmieHpkMMIB
	9Vw7vM96RgkQeXCRltIwHpsD0Cjm56EKqPp1/AesI9yJ340/YlGsnv8NwACm7iK3
	pv67Oou2rrEXuu2GAyG4g3yca0aHyh2DHmkEd4MZrvgPdW5+1vyCps/GRFL+28zf
	QH4KiIDcw50+00r789qIZHIDPxHTdbYr2EHBHTPMiuMK2fGqpTMhj9Tg+fXsNtu6
	2OOHouJ+UHUIEfV5E4EgYnWoCjRwDmYSF64AT6UELIPbfAYQIIhSWZ5FKdvCTKQ=
	=
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xvmxys30x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 03 May 2024 12:03:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCxNUufGNN9cfROmoMsqThkr9R1H972UfrBog86onR12rWc/5Z9Wdot7gz9LXaypXR9zrkAF/gMNHK3oWYbLQghiF/8e08Fp6qVwLZkw/hMeQfaoy6wHbcn3VvsWcPKFFmMrg/6AvFjPgvR+5KaQRV0s8wrtM/gEItY4PLQCI0bpw9BDhWGj/qKcIzD6tDAReIkbtMaImF2TutkTBDEa8Rriyxq/bNvNq4Af2hk1Dk2U3BZY0ll4WbYlLXxNwKjQANAwZFBIs0KJ3bRaHd1sbJJn5WT6zFKpublFJf+RoM/sTRFCvkJLvuVgrRB0Bc4QoLhezWthGAyopw4oZmKZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5iLdl0j73au+BAAIfXYRroHauQnEeIvDcg8+4NlhY8=;
 b=ltYTiS7DVLr0MaWVicQEx3KckmdIQJlpHdplU/v/ReJdIlFHZq8kR9xGmLszyLo/+lPnH0k2bKj84tPxOdpM05dkJw/AbCsh8YdtfmfNM+tTg2Q0tUCjjchV6K5HKthWlAMi2fK0XLYaqqq7nOkdQSV+mGXJ/KIdAlDjHImdhocyQ5Q6f44X93/1mBX/iJDhfoKo8Dkth0c3GMKXRsLrjYOSAa0ZjbUrDWz5JF/d0ru6WUdrV/H6S9YBOLnuMFe5aqCW7jaEcuXuA/QGUYC+mo846NMKIPPJXmgD7MAhQnUtpdUMuPn6BWZxTRXkEQ1kUkyf7kwm6yqQGIF/OdgF0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SA2PR02MB7820.namprd02.prod.outlook.com (2603:10b6:806:14e::24)
 by CH3PR02MB9938.namprd02.prod.outlook.com (2603:10b6:610:1a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Fri, 3 May
 2024 12:03:38 +0000
Received: from SA2PR02MB7820.namprd02.prod.outlook.com
 ([fe80::2bfb:a89b:22e:75c8]) by SA2PR02MB7820.namprd02.prod.outlook.com
 ([fe80::2bfb:a89b:22e:75c8%3]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 12:03:38 +0000
From: "Naga Bhavani Akella (QUIC)" <quic_nakella@quicinc.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>,
        "Anubhav Gupta
 (QUIC)" <quic_anubhavg@quicinc.com>,
        "Harish Bandi (QUIC)"
	<quic_hbandi@quicinc.com>
Subject: [PATCH v1] bluetoothctl: fix for gatt unregister-includes option not
 working
Thread-Topic: [PATCH v1] bluetoothctl: fix for gatt unregister-includes option
 not working
Thread-Index: AdqdUYs8TAYSZGjvQuiidw6tywDxNQ==
Date: Fri, 3 May 2024 12:03:37 +0000
Message-ID: 
 <SA2PR02MB78204D928243E903066D5678921F2@SA2PR02MB7820.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR02MB7820:EE_|CH3PR02MB9938:EE_
x-ms-office365-filtering-correlation-id: c1712615-08d3-430a-818c-08dc6b6910f6
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?6rHGHV6DIKCDrQt2se+AkG1OKw5aZ19tEB3MFh6fEeFVzey6qeebG93PM5Py?=
 =?us-ascii?Q?9lrJKqOcPsFQSJPb4ihaGIDumrpiFFV7TlLfcNXQfiteqOThK11nUkvx77lf?=
 =?us-ascii?Q?CceM+Bwu1+PtgdDzlTEJxp5SlN1kNjXcBuN9j5B/+6GOI7MEyRaBLPuldQw9?=
 =?us-ascii?Q?44EqSZjJEt8H9vSwXCncdTZNvEgLjeb8vIUdYMC/WZmxbWUw57Bhfym/rpB1?=
 =?us-ascii?Q?ailzdZ2wj6ziDv56G7cz+dqs1iGJQYiwXpgSpU0TFF17Y/PQv8is9RcQKbC4?=
 =?us-ascii?Q?J9mBF3/APtWxL+zOOVk+ONSdEVnlZ7l1/lUjaE+WxXXGyyombRORsB73MS0s?=
 =?us-ascii?Q?QsZ1GclYoDe6zz6mKs5lIRlfeIeo2U70gACJD1pgH3SAsn1AD4Ql76oqjT+8?=
 =?us-ascii?Q?EQwf8HjYNcAz2IF6O4J9rkfiAwly0iJ2xTuoGOCOEictL+VCUrxjGuAqcV7w?=
 =?us-ascii?Q?1KuHkSztf6FHYVNHOBiYnc7tivQNv4txbAru+hyLQkOOt2cEDh3HAky4YZPM?=
 =?us-ascii?Q?cQoN45swXSN+sebWlewurDl7IiqZLo2akXQz7DpX1vyxMv3W7JzqsIVqUyq/?=
 =?us-ascii?Q?N+p4KxEclwoMwVRpZjmVBcVOz6hblM5/Al0nC4Sh5KKxY4ZWXFACR9REq6EW?=
 =?us-ascii?Q?TAhCyGQwZP+PnclWsR/UUfJ8wPtWhpZBUWGlYwYWug7HMktutt4YUYzKKSvD?=
 =?us-ascii?Q?LlTzh2QsRFGY9PbP+6UYGgDCNrC5sQcOvcw1W816jM9oIzJ7FomhN7+JMr70?=
 =?us-ascii?Q?AGCscLwDnnnV9NVJGlLSpi0mlvKH4I0DKQOTc7IfcUspqVFeQVaKLLnCB3Sl?=
 =?us-ascii?Q?GD9r89eBcH093/xsViDUW+E77mxvnQ8UbL7Xw3A7/z5oz2cn5wpD2abtZvpA?=
 =?us-ascii?Q?kAzofx2aPGbeoBO22EUjEWRntdcbOqfNVM01ulz/aFU3aIinkGSDZhFXFgPX?=
 =?us-ascii?Q?O30zheZ/H+Ep0zvv6U/SgQw4NCY1ARBN/e2O6QpAdO3TwcOMzYsw7ihM+M7F?=
 =?us-ascii?Q?zHXYcASSVWzBTPd26wJath3Kr8Hab51SLhCtDK5s4VFjQvVkfW2AfsSEGxz7?=
 =?us-ascii?Q?mvYxzHSca+1zC8oqFfUZLDu0mctNPQyWzKGOkkdSoMdLFIpjpAI+4pcA4X5B?=
 =?us-ascii?Q?LwKEooq2gP7qenzNOBkUFhsF2+dFMIIyYEqNU6hU9ez/3h9NMlIU1/4hEhJ6?=
 =?us-ascii?Q?+5EltUoUHpl+8HFs7AZyQRc6HRoDO9o2DyuWgFUqv+f5jp6xkg+4qvcUOEVK?=
 =?us-ascii?Q?dKRb0i5NqmfecJbmHlYZ4joL6ag4ex5Kcp26rgU4jbYD7AU0HSGpBS/Ir9zv?=
 =?us-ascii?Q?YbI+uoZtPcqruZtW35hEkWcM0ji3OA7FhETjNaIZfh364g=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR02MB7820.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?dKgaJFzn4SqvKvQQWH+lEfZYr1U2jhq1cLIEmo8cNNYLm1B6WwIxHeQ4nqq9?=
 =?us-ascii?Q?eUU+6QUCafTUstVFM2mmxQ6WXKldE2Q8k9eUSjgGDfHCvR5k0o9kmlkJyHi0?=
 =?us-ascii?Q?6efunwxzc0Wk/srREbkjRpPCVHEY0hLg3N02mX9PctROg+7lrPFUd8U76m0A?=
 =?us-ascii?Q?reb38XlSoq/lolLxAFYkwgHwT7CDbWLpGeG3wQJCYgCmx8y122VONwIwYfko?=
 =?us-ascii?Q?C10upCc4BNSfrZ64ZFzORRhVqLweWPQG7aNdTBOVzsCTW8ua89zVngqxozKS?=
 =?us-ascii?Q?FjcCYki2OeAucwNFIQUw0XZOrJooLK+ym4sTi6f/rvu0Tt/Bu/UlorM3rubZ?=
 =?us-ascii?Q?5QKdBd8DS2cOw1YWfdATa30NjuXFGbrDpLrSBKq2gOBTmLCHSIC+5eeDnTau?=
 =?us-ascii?Q?O/jHbvtsUBDRvuiJaIn1A6RvtyX/Ar9pz5v3ZmoAyDmN7sUafEpeM44DZlzr?=
 =?us-ascii?Q?Bnz0yPZev44ZsgEYADb6VJ58RpXUsvTOt5TwIAYfKRWJFOM3VPH/J4FDULmS?=
 =?us-ascii?Q?k7ZKK4xEjo7ePbgSswA84uP0OMl2ixsY/R1KATyejpDUz3MEMOi+h17vmhqc?=
 =?us-ascii?Q?hLkFS7asdKUTMwJTWodpcT7dS4vwtSHtjfcNLJunEVXmyS2myf/djXmLLbxu?=
 =?us-ascii?Q?DARfPfx3edi3BbPvpyncNGdJp/IAoGlQXd+lDYdhy+8Is1t/tJv2k9m7zHdq?=
 =?us-ascii?Q?OhwEvSMHxrvo7yi9zLMQnmLuTXqp7g1kBTel3DethcNQFOQJh07xYpnMPxje?=
 =?us-ascii?Q?xTYYZrnXWr4AW3N0yxb1dy1A5b2y9iXAz5SdB4WGF7rXc+uxs3ffgD5Qis1C?=
 =?us-ascii?Q?tCPVBEbaC6Z23Riw0Gb3qGXXEZR6CVcSu+ePb66OluRrhDV1Wk6Im2HpNFTR?=
 =?us-ascii?Q?0ikkqP/Ge6h2umoE+rJGI53SiS0Iv6NkxCUdSjKIYui3J066hJXHyPw99UKk?=
 =?us-ascii?Q?5W4b2FEuNOnKTfgJsetcRnCNZwkFkAF6GAKDi5nGTCfiv8NVxAnrWj1d+sPa?=
 =?us-ascii?Q?Qcw9Skgp79tdV/zUDA/HqmIx13VODtKQrXeUbKSbHiSJo4yeMxqs/+ttjW0W?=
 =?us-ascii?Q?RpdZKJ9Nf53bwr3u4zDZEIIhQd3SCyNvmEA6fHoL+vf5K/6OHFrd8h5rh8Uz?=
 =?us-ascii?Q?IFFzN34yyE+Sz/pw4R95Qt6x4ZzVsvLY4n7RtoSdhxJh/BTlFQfWB3/kI8gv?=
 =?us-ascii?Q?t3Tozb/UPci9JxjXsoZIrh4WxfQdajdJrUqclpa+oWr7wBjrJLPDly500R31?=
 =?us-ascii?Q?jnm5aUjJLXtB1WqWUTrD3+VoUpVxzbNN8nI9h5d/YJgkBXdEK+kY+sinoNR9?=
 =?us-ascii?Q?HMIJPyDtv49dFxQT7cUKcY2TxlZVEQMwQzaOFXKtsGuNm3C0tRjfNJQ9BueS?=
 =?us-ascii?Q?cFzSZADrPDfJwRc5SLV4gxXG6N534KSarB/G2yDaeFhqIgU7NMW7B93LD8SH?=
 =?us-ascii?Q?oou1RL8rv/b7bzw+rFoc7wqsj483oQH1W0cJDwv0l28zPOFTJtHAKs2rgu+x?=
 =?us-ascii?Q?rhdZectrcVFDYwPRwljT/n7qR3fzdO3LhZ4Y7AqemTeOoREcqXLZxxNLY2H9?=
 =?us-ascii?Q?g+yYC/U1BrfmIGGVTBHjuDFP5KCuk3e4doXOYDtM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jRZk5W0jLE52PhoxzbbTMTwQVs+4c5u70cXDLcSDzHBdEove2CLCxRwbg9FVtgo8Qn9/vPuXOsPoKUhlFgv+iiCoj+A59vVXc4U6y+D4Enim3y97ulJV5BcYU0MJGV8WcvLP030uqZ4uOSZBbyb4T/JmHYzgDvSHdVuJtZiUfaiL9PoT+y3sNxrUSF310meVdpRiJ2N/CzBZ5tW2YMWcL+ghhsrRWdpmgOIoCc+FdfR5Qv6y6qAXkzzYVn0/qG/nhsSupYHuk7pllnwKHhbkm4sf6/Q569lVtkHNzUHFMxHcpa1RmTRbdDH6PWK3Eqaitj/fQRtA+CFt14qUAIIn0qc3ilCvgdnCerRx/kpyBIR9Q5ccU6n933RhvBnJv0ZC0Cct8cV9P98xQH6PmQyIthGrA7GQJvl82g4Gc+5lpZvlcZCrDOyaxWCa6SG5yNG+qhELUK9FcWyfHTQ66FnSWKQwJYygwyyX9voaT0QUn4N1Beshvo3eKP7Jxtblxsa2wIyAscZdIGZqm2cE+GMKbCxTdpmgZxBEo78ZNkn7glEga6IKgrqhduF/MbdAgrXThV1TyerkhlL4YF5AjK32coqZ8AA69MGCBuvKugD9jVgUTn5sH29aWSCdrzmU89I8
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7820.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1712615-08d3-430a-818c-08dc6b6910f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 12:03:37.9841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBdJDLQHoUkiFZbzLET9WuPpBoy7b3cC/MSnj88krk0NGSNvqumrtzGjB6ibQbq8qIGT07WssZ3Vp8no/QsnWPlTrZIzdRABfdWn+/s+eIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9938
X-Proofpoint-GUID: Bcr7gn7Mk4XFRNbudlpGA_zxEk5w35NO
X-Proofpoint-ORIG-GUID: Bcr7gn7Mk4XFRNbudlpGA_zxEk5w35NO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_07,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=708 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405030086

unregister includes option takes two parameters service uuid and
included service uuid, since the space between them is missing,
the menu option is not working.
When two uuids separated with space is given, it is throwing error.

Signed-off-by: Naga Bhavani Akella mailto:quic_nakella@quicinc.com
---
 client/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index 51d08a67a..c8b0f7f1c 100644
--- a/client/main.c
+++ b/client/main.c
@@ -3060,7 +3060,7 @@ static const struct bt_shell_menu gatt_menu =3D {
                                        "Unregister application service" },
        { "register-includes", "<UUID> [handle]", cmd_register_includes,
                                        "Register as Included service in." =
},
-       { "unregister-includes", "<Service-UUID><Inc-UUID>",
+       { "unregister-includes", "<Service-UUID> <Inc-UUID>",
                        cmd_unregister_includes,
                                 "Unregister Included service." },
        { "register-characteristic",
--
2.17.1
