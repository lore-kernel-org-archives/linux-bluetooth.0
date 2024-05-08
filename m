Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE143224D1
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150100; cv=fail; b=GNjRCB5dr5RO433kOdCjrVVaPaAZIaOsUMzxHHurYVMAFmA9TsMdA4Jay9T2iwiFEg0MgGSfo4V6KILYkHv05TSAF+fsMOIeTdOcGef1yUywHaRDP6ucb3CcfSgdyd9aE4+OG7bH95in774KTUhi1RF35ZP8Zv1hPM5uOZzPQd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150100; c=relaxed/simple;
	bh=OKsKOGcLVkhqVZfwLbKjvILB0SjMkfQ2p7TGJp0ta64=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LaEYnu/1z0fagJ+JVGADnUTbrxG8CifUK5mAd6JRguojOWnZLW7ttxpeMc/JkOY3c6kGeBNZI07uY/pgrVyXT9DIMB3809czqKhrQ4dCDdkdT3EfbdIMmKEMCNShppyeJRs9b+M7WokDEgX6DTxd6tU7XoBC5Vq2zX/udOeUIvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UoAjBsMa; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UoAjBsMa"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4483qxrl029364
	for <linux-bluetooth@vger.kernel.org>; Wed, 8 May 2024 06:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=qcppdkim1; bh=K9PGK2u
	XdcnHN+gzzJeLce8+3xFlhlmDhXE6XJjDw8Q=; b=UoAjBsMazQweMG6LPS01hqI
	pLZ8T6HGrKSzpQByEKnF3l+nOqT5FOJPmnL45Q4bQ6qUnO8f6D2G87iUFHP9BdG3
	16xsfjGMeF7DE22DUS3G1NHSImo30h6SM0HVfz4o0ic/eYkD8QqI7IYFjPWE7x4F
	Dq8uANHIkRnLajdR0OwKCg+zo7r5QWFKc9UUdnKwXpcawti1HpsrlEcHcobdo2pF
	I/N8A8qVmVYiQbjcAl2M/s2aaa744XFAhhwSc0U8uzdAXnPLF1yLnna0nwlJ9M4A
	6ZU5xMuRgsOu2XYm3hYKmDGuNlbP40IgHKAB3qVIU7sqG+LVrKxy/SWEbg0YPfg=
	=
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17013022.outbound.protection.outlook.com [40.93.12.22])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xysgc94uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 06:34:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4ZAgiskkvg1Y8N4MOuxN8fPhKy0mNMBrPHDEncOzGBRoGH1V/68rvXLXov/z60WemyBzsyPA+Xc+nWakwauLHmYzuqIUCylz4o1wua1OCNA7t8cWK7uez+pW5sZpwwqx9ohCk+8ADgSm5rHhR9oVyD6tlU++Lh1oXzzbc1WYduSWHh7Ysxdt+md49dNjX4FoQza/XtF+hIFVDAZnzD6VV6q9AmVtK/DV4IP7/L9FW0HPj85qoU8oYo7woWqGu6wT1gF0O6POX7jdIxl+YsW2SFnPWjBqd8LW+STXMEHZnwz6hB0MDy9XEBhM4qqhJ/6X7ioqRI3N4+UC3YNkvh7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9PGK2uXdcnHN+gzzJeLce8+3xFlhlmDhXE6XJjDw8Q=;
 b=TGiMfw+/sLwCmc0Kp6dhLqY04+TM6UFU5tQlMhfl9KiEDvSaqDP/MAt+rA6tM/vI2SNWa7dUlustQjU3UgMOMPjQKTCFZPHmTuWa0AI2ZYw8GaZk1KU4fqeNd0INdQAh5Up/d7xtDW3X3b6Vf+mIVEwYGBYeLWykg8B7XYcIL6rqex9rcKTLZCE0+osnQChSAat3mUB54Oko2qH7NeXfKNRzGMblfSQNl7b3wEKVOHBDyidMnOlws/rNopHOBLDUKRIVGhq6BzGvkGzOs+BwOVWNAPg8Y8JwwCiX2HUKK1KE3gvONWrDboNm2x1Q5ib5+5uyPFcPcgK16LVWPhmJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SA2PR02MB7820.namprd02.prod.outlook.com (2603:10b6:806:14e::24)
 by CH2PR02MB7061.namprd02.prod.outlook.com (2603:10b6:610:8a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 06:34:54 +0000
Received: from SA2PR02MB7820.namprd02.prod.outlook.com
 ([fe80::2bfb:a89b:22e:75c8]) by SA2PR02MB7820.namprd02.prod.outlook.com
 ([fe80::2bfb:a89b:22e:75c8%3]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 06:34:54 +0000
From: "Naga Bhavani Akella (QUIC)" <quic_nakella@quicinc.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>,
        "Anubhav Gupta
 (QUIC)" <quic_anubhavg@quicinc.com>,
        "Harish Bandi (QUIC)"
	<quic_hbandi@quicinc.com>
Subject: Query regarding BlueZ Stack Certification
Thread-Topic: Query regarding BlueZ Stack Certification
Thread-Index: AdqhEYqBKmEql3vdTDG11Qw1rR7NrA==
Date: Wed, 8 May 2024 06:34:54 +0000
Message-ID: 
 <SA2PR02MB782004DF03924528761D402492E52@SA2PR02MB7820.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR02MB7820:EE_|CH2PR02MB7061:EE_
x-ms-office365-filtering-correlation-id: 11aafd32-3423-4371-e8f0-08dc6f28f8bb
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?du6dTOIgvqqgCfFE8aEvZx8fpJZ50d/KQ9M0DR+GYfj9uvxCqp6irHuFvIew?=
 =?us-ascii?Q?Vbe3I5gCzZcGmXwnUMm/nr4GEtGIHd0mws6RFGS1MNXsTQ37wXGU2edywsdj?=
 =?us-ascii?Q?/ypaE0nIy6qTFtHclFRpvQpfiJDzIuHGEcBCoCd3/vT9leMpFKTWB8eXukqh?=
 =?us-ascii?Q?lAK/OtytCx3OW2a0vAVyOJuGOaqMIurZ1+5P3Xi9L63vgguHj+UoWNBbA7mB?=
 =?us-ascii?Q?3h61/nQnPs9mkiR3DGDfNYzpuAIQLkEdI6/yVv0I+2Pr+kq0UtO2WQKQrgfJ?=
 =?us-ascii?Q?CJK/9EGrURKlkgTpQQVn6MimdRkM/7x1aq3y717SozRAifWVhw8GjXpmdlTh?=
 =?us-ascii?Q?UB9l1ShSMe63WzleV8EUffIHYwiT+4DKQ1/V0Z8ESp9PVFzdQij+8/x6y/ll?=
 =?us-ascii?Q?MA87AmF0PLvFYZ4wLPlc6fy3WXGrO0vva5QpsVyYmkvSWepXYO17N+NOykzg?=
 =?us-ascii?Q?Ea3YQ5jk2KefItZcilCDnReL+h2aSUO4QlqbmlQ3V4M++scJxXpdtx1irIrO?=
 =?us-ascii?Q?c/C4uh5KCPoC0BSfnILxGra2FOISc5P3d6vhSt1+mjTeLMX6YLMrp3D03DWU?=
 =?us-ascii?Q?kG9RWgcyH3EapKHB3jTiHM+dE/uFnjT/+XA3x9GGW3CEOqOHt2CfLWHpZKpa?=
 =?us-ascii?Q?FhyoTFrXUbDE1zCjZ7L/SAal2SuLqhSc4u6+6a7CO8LuCdz/jtwX6oyngB0x?=
 =?us-ascii?Q?vbAUib4AR60tuEHgUWeSveqpOT6E/b20OwAar9ZfA5gTsIIlPXUSMlzSKBKC?=
 =?us-ascii?Q?HwjhXPavUzBlXx1jytCILlDqkjM9UfFOZxmnsAypcmc2jlk3yjskIgBTmx//?=
 =?us-ascii?Q?os0I6bx6ut1c8Mx2YyWw+jMIYHVU6vzZS3AWLpiIs3iHfRH2etHG4o6pJ9fV?=
 =?us-ascii?Q?nUd96WmvRba9cI5JiGvcqPXBc6zkkJ/n1EluDWnWRYJ9FQAc+/8yHghS7b7c?=
 =?us-ascii?Q?q4+ArV9qFcmFnrhb3duXYghlq7jWrVdMEwj06LdH4x1jlOJ+BRINOdhObRXt?=
 =?us-ascii?Q?GRusNzPhh+wxPpyDzgOs6woATasy8jc1LRTU4WflbIIKu9ydPwd2Hw7uhHaI?=
 =?us-ascii?Q?ekRQ+i2T4aHdyyaKsqjJE0NvydG0pDs2b6anFgv4hd8IDK4yGY/EVPnP7bg6?=
 =?us-ascii?Q?jf41uZ66r+/ktleWLdtX6SjBzEltOyahX4y7pjWuxF5DBns6MeQk6wKoRbBO?=
 =?us-ascii?Q?Tlxt0Dt5C4hRP1WK5eXkMzAPZqh1d+QZZ6bv2oH1h6EF/TdE2w/3RWun/YPq?=
 =?us-ascii?Q?WK+pIKTCkHWql19z3cqLjK3/aWQEA4Zlp2VZdCmqhFB077VA7YYAyLp9o1pb?=
 =?us-ascii?Q?ANT/U3BtN8MMcA3qHLqzZTeV18fCzsVaY+s9UFZYQz8WHw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR02MB7820.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?kajttZEFu/MOMuY1uXldZhB8jPDuNxBQ9f7wI84PY7cANdr5/kuiO/gPOosJ?=
 =?us-ascii?Q?rObuN5Rex+He726LXZuYmAGXbGb38NciDbU/3DgbWD5DFW9NiLktH+RNk7gl?=
 =?us-ascii?Q?STBs+ujSp5a8afPE1mKAAt4KHskmpVr2QdleI2GBgS7Z03cwQY4ND4ZESfeV?=
 =?us-ascii?Q?Sm+tViJHtiZNV/QNtaXd2IYq2Q94OcWOEhTwKEDU/4UHCadUbSUu6ERUJavn?=
 =?us-ascii?Q?a0CeMxyYs9Cm9gXZ7uh8qxQS0VbOumkrUstGVWW3exnIYdg9VKYGotPE1q7P?=
 =?us-ascii?Q?OVYoEiZ6m2Q4vAixtcKzob9yyq+QbI0BIpkmJVzGGiBxJvlZ23YQBmBDuKsF?=
 =?us-ascii?Q?xEK+cwJBHjiYUjkv1yWnv2NQ88HUGBcS47CDw2ggnRblq1P3SUMkS5EiZRA3?=
 =?us-ascii?Q?QCKWXGJcapju9crcxUimtYVn6joWab+ew+S/7A5CcowA4zPv4lC0joox3o5I?=
 =?us-ascii?Q?vjj7Tt0TyLSPrNVOwhO7rmHE0PtPL/lk2S66Cph+wcCEAb7EGFwA6C8SUe2z?=
 =?us-ascii?Q?V+CLt3T6Ruk2pAvdXK7LnvcuGioY5WehsHCByZ7n5bvQbjml70aJTI8/0JoU?=
 =?us-ascii?Q?9H1vZqY/ZAOYQwuRNp4QFJ4MNqq4THUAgZZ3TbGHq7NFx54My8C+gueaxAsf?=
 =?us-ascii?Q?Rn3tk+f5j6VG7xhZcOy1u1/+z4iW7RbQULgWY9i2ng34PZfVaVFI+hHd+MlW?=
 =?us-ascii?Q?MYftVNkLW/GyxfXWA3rdQO41CKT70cous31OTMR4YWwPzPEwmd012KwhfXVI?=
 =?us-ascii?Q?1K8kDTKXMBzAPLfsc/Chr5cHBkoK6pzbMg88eCwiL0259e1eMzAqsGEL6fJN?=
 =?us-ascii?Q?TPml4qW/wafSABVQASPFT8x6ve4goL+/AtocChUCX11JLeGYR6tQRWiJGuOU?=
 =?us-ascii?Q?OPrboASJqydbsVBrTFLZF3EEwS9UFWgePEgq1DCsABuU+x+7ZI+PEOElVa3c?=
 =?us-ascii?Q?jdPPiEZLtOWqOgvvH4pKAw1XMJdrr/cmD4K6vrw1i8PG2DqhDhteRA+0+zTs?=
 =?us-ascii?Q?CCZxClBBqQW1Zqr/c1yrj4zgQUy6Gv7z5zstNaccGWXRp6i8Z9AglHvlGcpo?=
 =?us-ascii?Q?jlR17Jy17FHWIv2qrXnRt2EkA6jSVu99Q5SSlDJYN31rYZiGUlNFfi6pGQx9?=
 =?us-ascii?Q?BreYMMR3EQn9PkUi3gcmq/B6M6ceD4RCCqOjAVa7UrGKdOMMp89LRLekxLaB?=
 =?us-ascii?Q?zQeTKl6uuJkcFVTn7ltqRyaUUUZIwmsnCBrlicNrHj0XbEwqli3YlN/2ntMX?=
 =?us-ascii?Q?fDGCw8iX3K24ejqI9W8HxYyBtS5hfizTEVjqTfheWvPc7S1hWrcX5UHIwoW/?=
 =?us-ascii?Q?mWxuiBf5/xGlDYtBSMF3PCGl/xnnkVjuSX9nXyUb4e7H/1hbn0c2V34SrNiF?=
 =?us-ascii?Q?GZzlRqX/s4MmTx+OcevZ+X6MmA8hWkF9pLDXQURNOA9NoFzdPf08JbUGU9UF?=
 =?us-ascii?Q?Q5K0n+OreACWbRWXvmc1ujcC+9B0WUL8JPp6KQwk+UJBjmbOgYtrApTgTbJu?=
 =?us-ascii?Q?2PL1MHCCJN7rBF05hXX0noM5u4l7U92X9CB1Hu22KQ4TXYTIigxXzYT53TLT?=
 =?us-ascii?Q?veRACmnhTzYK3vEq6+YX25bGdljm/XblL3KbZVk7?=
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
	2xjkfKMVVZk9rQ1aKGHMvbgJ8gdF34/jcUW7onpkORG5SgiQLkHMbSADN3UeyJE3BxTO2koOoIX88BC2RI8tRyWy9PbKI/rqAknJn0sj9Yy4fq7l6FmxWwpy1Y9IuTYZQz2UO3UlnLtwqDFtSU2BhfpvNs6HDQaLep27RWPqBjjLTsNPbPK85q4sDc42YE39uE+hIBpywqloWBG5OyRlkqoIt5ybPK6UjsmDHjPmGufMyleX5MSQjT4HkC0CO4opmMTHfq7PqT54fmBC5dtTuebxmcMqixU4HrAypNEPBTNdl8Fq5cBswKwMMJ3NnCUN3amveTo/4zz9mhmcZ4as5D8fAqVjcpYkejRn4+YtAvOdzyttQ82nGD/+bgZTCkeEyHd05TYtTjLZVsjejnmijXWjuKLeSpbis8IdvtApCAWKPwVrNp9ubUY/kUGt6plHy7/dTq1QUzl93Pgjt9gyNwIYuDxmlKTZ1OD8pAsZQ+04sciZhmI5KCwOvyQsbSjDVOD1I5b1xtk/VRDG3b88aXTB8gnl1fpm+zqcH2/FOav7qRtbcM025cQRQ09psQQzcQ974tTkavSFX17PiebvdqliaPFIyEPSMDYYtpH3d+djxsfk9I5FMGz4Xwwm6txl
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7820.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11aafd32-3423-4371-e8f0-08dc6f28f8bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 06:34:54.1903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdkXA19PfU8Ywl/HlV767J36J2jIk1yeRww8WgW3sI9rHRnOFCndEcmWSQutGvv+ddm9Fky33Tpupf9qnB+O/+vZND/Vb+4idUyKfCJ2zrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7061
X-Proofpoint-GUID: OLFqD5mZ64j9vrj8OBqUCLcStN5sj05t
X-Proofpoint-ORIG-GUID: OLFqD5mZ64j9vrj8OBqUCLcStN5sj05t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_02,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 mlxlogscore=926 mlxscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080047

Hi Team,

Could you please help us with these questions

1) We are looking for some information on BLUEZ Stack Certification.=20
     Is there any existing BlueZ stack certification ( we are using BlueZ 5=
.65 ) already done which we can reuse,
     if so can you please share QDID ?
2) If someone has to do certification from the start,
    are there any tools or apps available on bluez which can be used to run=
 protocol/profile test cases against PTS ?

Thanks and Regards,
Bhavani
