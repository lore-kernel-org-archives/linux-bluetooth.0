Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F181B86CC
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720545973; cv=fail; b=HNx4rTQ1+1n25xJDFvQdj42h4/Wvdcsr7KT8QQR9sP5gQ10kj7Wae8pYKTWIPk6OsSj8IhgBrCaMlBs6ZKIiIC4GLHu6zfJUnbXODDTatC3SqusYDnqrXUgGZcNgHOrVl6sEcpVJI2jUion2FXf7x2+2NWrwRe45EZyvHuyllMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720545973; c=relaxed/simple;
	bh=8iOk4HUj/lUNYw2W2/a0Zml7S6cdNMandrQc+NhWLvU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kphkjxQQytYzdAoitU/E1t8srJXWs6R1PS0F7CErDyHwgQ7o1xrSEltk5DoxZk+S1z7mJ6Iki/88X9SyNe8L2/sIrWy79FXxM8eQiyUBFbe3qRlR/8+qyWq3cXQZFLSJhW81g2DNXdE4OTcUgaxB61KPbG9LQjI2lFAwyfAlKVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=hDo2yPcf; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="hDo2yPcf"
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469GTgt2005665
	for <linux-bluetooth@vger.kernel.org>; Tue, 9 Jul 2024 13:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from
	:to:subject:date:message-id:references:in-reply-to:content-type
	:content-transfer-encoding:mime-version; s=smtpout1; bh=IVYNfE2z
	mrCab4A6TPGkmOjsLmXN3oizynWeIQOfKac=; b=hDo2yPcfVqzROraO1jt7ohYb
	6pI/ebKlkWMDF/D+980LFFNu9yRN09xL9HMqp+Nu239fEWu1dVnLRh/pOluBgIqB
	J7Vb3JSbyB46fDyXZM04ImZdo33cRGWkCqKQ73O66ZDn0N6qfow/0AjARqEGwalO
	esJhrdXuVznJCUu7Tjdx04ZJRqBnBpNHu9xs6EWwLbd7RCU5Kd36I2IuGoEWp3Gy
	LXj+iCeXXXyKWu8vQs8r1J3e/l/lc+nOOJrKt0Sf2D7ck/svecMQ/RQOKbTzTeGz
	iLKxyJAUEBFHXGoftLF74OQFpSfDBVZSBM0R9kD6VcvX6r0zqPxUFMKbY3cKRA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4072kj5er9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2024 13:26:07 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 469HIpHl012674
	for <linux-bluetooth@vger.kernel.org>; Tue, 9 Jul 2024 13:26:07 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4099g783jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2024 13:26:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jtwllj7Jr8BGk+1TjMU2UT5ZvjA8Gfpm3EAZy4YIUhFVLLTgAVJo4PfjKXNrno9pUd11JlZOGAtWQcXT3rWx6d/NVL1onQmASWUs3PHT5O2nZRrvu0yN2AsdP+WXi0wriEAA84bgzyHAbD0dC2pbFPR27rVJ6xIL3v8aecLl9DdeBfQdVICVHHyxDwVABi2fse4Jr/pnI4763lYwmozbrHdO8ZESlKNJBPJgoZKZ9/okZvUFHw6nDG5hTwDrBhHSzbXXeiZ1DajVfLQs2lBMkzKieIKy1bS+SA+JmobnnfZYjF4GKUOj3FR55HVdeKAK29tfSKaI+wHfTYWXaopHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVYNfE2zmrCab4A6TPGkmOjsLmXN3oizynWeIQOfKac=;
 b=bb7aUFvLage9ccuB+ndO2bG0TF3eXpto7PBfCG6icNaWEoiQ+B40DX99ZSmj2TTOoM7RpqoNHuDTjLepwcIMuJ4ZR2hqYLo8SowIFFwJlW3UMOeyRaz2m5He4f+nIQJ79fiY82cq+VnXMNfa8fq0547M5AYrz3g9sX79k6Y+6vzyUd6flkRaT/8VRJyBJvGFxAAN2oG+Bq7kgx5m/Kl0DGfkHg94ZFzqqZXyLirfkiWcDBPK0tHNAPOxIJiLVwKfrYCTdVxn7qGmCcWloc4nt3XFtzBIM2xdVUULjnn3kH76XbM8xP5X4ZUD/Tz41j0R0Q6iltxuxRUmi/UfxlcRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SN4PR19MB5421.namprd19.prod.outlook.com (2603:10b6:806:20c::7)
 by MN0PR19MB6142.namprd19.prod.outlook.com (2603:10b6:208:3ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 17:26:01 +0000
Received: from SN4PR19MB5421.namprd19.prod.outlook.com
 ([fe80::237c:614c:8f0b:ae83]) by SN4PR19MB5421.namprd19.prod.outlook.com
 ([fe80::237c:614c:8f0b:ae83%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 17:26:00 +0000
From: "Ramsay, Trey" <Trey.Ramsay@dell.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14)  Prepare Write
 req (0x16) 
Thread-Topic: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14)  Prepare
 Write req (0x16) 
Thread-Index: AdrDQ46/6Jy8+sp6TbCfSD4zIwQXtgO37XKQ
Date: Tue, 9 Jul 2024 17:26:00 +0000
Message-ID: 
 <SN4PR19MB54215EF3B4E7380A21387D2EE4DB2@SN4PR19MB5421.namprd19.prod.outlook.com>
References: 
 <SN4PR19MB5421B1226EA92B735CADEA44E4C82@SN4PR19MB5421.namprd19.prod.outlook.com>
In-Reply-To: 
 <SN4PR19MB5421B1226EA92B735CADEA44E4C82@SN4PR19MB5421.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=f68f9848-cfff-41dc-8ad4-901612960cb3;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public
 No Visual
 Label;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2024-07-09T17:24:22Z;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR19MB5421:EE_|MN0PR19MB6142:EE_
x-ms-office365-filtering-correlation-id: 0aad2cd1-ce5f-4fee-08e1-08dca03c33ea
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?uFHm4BQhmtZ1BxJ3H4rs2Nka9O+rRRNPfsbpKZXbLNCWb8uKpCagT3p7Kory?=
 =?us-ascii?Q?0qR2BTcMXp56VlVtP7g6H50DGv6Z6dBnhRJ9x/STXVD35vJ7tqMrSSGQtzLL?=
 =?us-ascii?Q?muJNARmJejwr3tybkzBY55u8ta514/Qx9wTgVShPdkEP0qQfEVm7FTUHUnyx?=
 =?us-ascii?Q?ddKwemWeEfAf5PqFyoGiuY1PSqSHoEdxrfbWXegDbScNmY/TxlL3Mi0nUheK?=
 =?us-ascii?Q?Aj02+9cfOo7EE0RDz80Gusx0nyzlGvY3O4zA6Pk6sED7dxcGyQHObRgtomYj?=
 =?us-ascii?Q?aOcK+A6TcK8r1BNLUwMUDX+j9HkP+7yqLU+Wstpy2/aLpTAlMDmgrc2ajP1s?=
 =?us-ascii?Q?EHC29cwJVhFlhqbV/rd31NQtVGyKI9/DWUVsqeBZCwiXBTV34aBgMxlrWGs5?=
 =?us-ascii?Q?IeQtMacrpDMTzJWTipsvObD8/XymohlfAlyUteE5Rc/JHsIkiqS5DnaUnbxZ?=
 =?us-ascii?Q?OKfyfDRZ/nEsTmqxuYFBX/kUnuTvKGXO2M/i7YpFMpDftT0vZdFbhGrZ6XBa?=
 =?us-ascii?Q?3JdjUVRcdtNvEqCqlcqxkRzCTW4BwpM/ALa6CufaTVTWxoXAiipJ5XRcp8hg?=
 =?us-ascii?Q?svoex0npV7h6rqXeu1tfp1mCBPPnv4F0HLj21TvNzFeUdJWqXoZxgXhauwcg?=
 =?us-ascii?Q?xjdB1tffEW03h99HkAmrBwfq2NeIQvNxYoshlvNIAAwqQOdjHJHRCY+5Owk9?=
 =?us-ascii?Q?amRrrm/TJkVFMQTlyID85OupD8Ns0KiHtuOpHkjXZeNhCsbiVhnko1E9INQM?=
 =?us-ascii?Q?6brMoe5Wd+CBaHueN70F1HxjohmnBFJ4nKb+31NqppQxY7mfk+2L4ev0JolB?=
 =?us-ascii?Q?OYKZLNJdDKFQZw/0fr1Wk97U56YcghzELyZbeBnpoCFE164JDResMdfAWefn?=
 =?us-ascii?Q?a1ILJQCHq8EsvxhLTE1RY24yCeOkTutoRv0pn9503x5OdUEnvdWz/EhOjh2c?=
 =?us-ascii?Q?I/oETLD1VHCmRXMc8JsoKj2/MSJRdBX70lsvYLyYuwm8hFvLUMTFLWfwezbH?=
 =?us-ascii?Q?6q9xjz9rwRiVYzJnxJTehenk1mBvmsD+nhs0phzNdg64HA/i4VCt5YggzEqF?=
 =?us-ascii?Q?SFP9WnpjxiESIvrjp74aJKJHWpIkV/3WwKjlzId9qWTIbzazUHLyiU/vA/VJ?=
 =?us-ascii?Q?KSc2y3w2+B5zlDWh3vaTGvewyh6Xh0HZ53w9qrgncrJfEv2Kxv8YtfUvmZec?=
 =?us-ascii?Q?3C98xBtLLlyOQLrKfK3E6W9n8lwoZ8vGBw/SI7Og5VIR8+AWwAJR0tCaedWR?=
 =?us-ascii?Q?6HSpX7AbyuwC8S/f0wNGEmDJoiiGWO1csnyKB+N56OnR3DcIbu4Wvg7bnbxz?=
 =?us-ascii?Q?fcMmG+QKWREPC0ZlAy27lQ1NdBGGvBNIDVcyHVC6I7i7R83oMovOEwrdSuan?=
 =?us-ascii?Q?0HYHppU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR19MB5421.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?faumqxWesTWV+QWfq2B3BehuzQ6tgiGuLQ3PXircwvrA2jKu5C80K/JCdQnq?=
 =?us-ascii?Q?bNAd+Vw+oYSnQU0GRo5N8dA1fNtpoIBN9QldkhJ55dGC04/RKdfpgkwwK2eK?=
 =?us-ascii?Q?U4bSjZuHr83KUxuTtBj4ncSEMscrKLKwPVeSEgadchu528dAzZGgmjAye7VR?=
 =?us-ascii?Q?+fQSLfYnbVB5rJi3eI25LM+y5Zfch9Prql4ywYIgSjHP4Ew0rg80aIWWPLXt?=
 =?us-ascii?Q?DYRvZQ5b3vWlpJDW5hHKu7y6RldzJkR6FmQN5Jr4rNDTb5e8uxJSc7Ppeczr?=
 =?us-ascii?Q?B0Ck8yfnp7UlRgyI/CF+T5mrCLq1O1s7/q7AwMFevdwiCYaNHfkmv1n9+PZz?=
 =?us-ascii?Q?SutX9FnP/wPGuQC5kdXog17D4cOtjX0J4B60ffA96XQYgRCatBm5bX3Cxjcz?=
 =?us-ascii?Q?nXCQBkI4Qpj0lyq+mOlfAmh3s5z/zJjJugnMGR2LFknMO1L8zlAh1c0zgDbJ?=
 =?us-ascii?Q?9v241mEo8xDskpl7GwpZpKI2JrZ/S6ZSVhNMBd1uE9IQc+jf670ELaLCE4JT?=
 =?us-ascii?Q?okNLaWChN5qzogqIeS3egVLaKSt6NNU2tnx8ZRxnEfDmXauDVDwM8A2AgyaM?=
 =?us-ascii?Q?SKruaC7t5X25klw+E1ot45dKWJ+36TLb+5qmBeyo9R2irUdE2EmKe5PcvxUO?=
 =?us-ascii?Q?iws+fA2woNY9MF8auSGHocwm/XsJJqpmqtBUtVX3JKLAoarrEODLXIh4UdCU?=
 =?us-ascii?Q?Q1JFfQO9rhZ61fnGH48wPhOr8vv/oUSiajynZ6h3z2IlpB/X8M0guJeXMx2Z?=
 =?us-ascii?Q?++BoEqLZGFBYWZvilThRXctKIOqfhyCG1DD3Py5QGgsfrQROs8zVKVkPda2p?=
 =?us-ascii?Q?HWFtrwqbDUfCdWrpOxboQuAif3T65jTevunZopDCOJBEtVer2/JiwStjqdob?=
 =?us-ascii?Q?g4Je9i9PGIprj966AxKX1sPetDRSiubLAM78wk6xEnPAJ125qNOP1O+QE8ki?=
 =?us-ascii?Q?IFOkJiPT7QX+4QtbDYFPovfLv2PyiqnMoB0fRxDejEnJ7mcMChAUqPCfbuL4?=
 =?us-ascii?Q?h9Pv74XJfWlXGDHyq/95Ux+urfJ/558o8pyy1Z9VGByeekJvsB/i8LL3D3aV?=
 =?us-ascii?Q?s+qgME3HY5j7TdM79Oy8/TfCSH5t127F8z30XRQz98k92r7wV2wP7v0U11hL?=
 =?us-ascii?Q?1DVj3mwFON/MlXpa0lt1vjgWae9YrlCU2HB9/3wibTBMeNNVy1oPt6Iis05s?=
 =?us-ascii?Q?v/O3cIvAnwlhaPZ6lFbGuxXAZvTI2bwKzLAtSk0TFUxqlmJHUCPxY8D909O5?=
 =?us-ascii?Q?Kx7EL4Baub78SA7TDEYoDaNHqeosmVwMOWy/CW9lAYMQ4Asxo+pbiNkucII2?=
 =?us-ascii?Q?DPxRDowb7PkRFeKrntPNpUcyloDLc7ZTZooACvIEERkNPJs+2Hvy9/p8dmUa?=
 =?us-ascii?Q?rG7pM0GhcpYyRbQMygpYgP0BEqhVNXZd86aBDVku8ADqbGS5rGF0/WfIrNkf?=
 =?us-ascii?Q?r1xTeXTjrXVXIwyKtuHlWuOinhtn+KjmzonTNqJaSSLQhzTr9U8zKUB8CjQp?=
 =?us-ascii?Q?vMJbvPgs0zO1ABhVBZLTrzmOK9hBhIcDTZUSJXXu90tRU8ewFdAsKzuhncIA?=
 =?us-ascii?Q?i1BJiycKOCJB2+8hAfqOpFQDf5kILTLljzuBKZbh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR19MB5421.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aad2cd1-ce5f-4fee-08e1-08dca03c33ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 17:26:00.8960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8cbsp/+gY1GnP6d7EMISejwhmZsawxGYZhOb+068Zh/XWMT7vgqb2qM9EZknBI9hDeXcKPaK13G8TVR9VYZzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB6142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_06,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090116
X-Proofpoint-GUID: gNJ9y1I7POZGQl89zbgC9z1kuueq6Fns
X-Proofpoint-ORIG-GUID: gNJ9y1I7POZGQl89zbgC9z1kuueq6Fns
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1011 impostorscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407090116

Bluez Maintainers,
Here is a fix for attribute writes not working in src/shared/gatt-db.c. The=
 prep_write_complete_cb was not getting called. The attrib->write_func code=
 block should not be called when len is 0

commit 5a9baa10d4fde7ca8ab88ecd68e17671c33cb587 (HEAD -> gat-db, master)
Author: Trey_Ramsay <trey_ramsay@dell.com>
Date:   Fri May 31 15:39:27 2024 -0500

    shared/gatt-db: Prepare Write req error BT_ATT_ERROR_UNLIKELY
   =20
    Fixes Prepare Write req error: BT_ATT_ERROR_UNLIKELY
   =20
        ATT: Error (0x01)
          Error: Unlikely error (14)
          Prepare Write req (0x16) on handle 0x0069
   =20
    The prep_write_complete_cb was not getting called
    The attrib->write_func code block does not need to be called when len i=
s 0

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 2c8e7d31e..678aef4cf 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -2127,6 +2127,10 @@ bool gatt_db_attribute_write(struct gatt_db_attribut=
e *attrib, uint16_t offset,
     if (!attrib || (!func && attrib->write_func))
         return false;
=20
+    /* Nothing to write just skip */
+    if (len =3D=3D 0)
+        goto done;
+
     if (attrib->write_func) {
         struct pending_write *p;
=20
@@ -2162,10 +2166,6 @@ bool gatt_db_attribute_write(struct gatt_db_attribut=
e *attrib, uint16_t offset,
         return true;
     }
=20
-    /* Nothing to write just skip */
-    if (len =3D=3D 0)
-        goto done;
-
     /* For values stored in db allocate on demand */
     if (!attrib->value || offset >=3D attrib->value_len ||
                 len > (unsigned) (attrib->value_len - offset)) {



-----Original Message-----
From: Ramsay, Trey <Trey.Ramsay@dell.com>=20
Sent: Thursday, June 20, 2024 1:58 PM
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14) Prepare Wri=
te req (0x16)=20


Bluez Maintainers
Here is a fix for attribute writes not working in src/shared/gatt-db.c

https://urldefense.com/v3/__https://github.com/tramsay/bluez-tramsay/commit=
/246bc960629dff34e744c728f048e9f50f1a005d__;!!LpKI!jkJYamzU8bOdd1qt-sWpj6gy=
1YwS30UyamHLUJj9Uy0UecrB6QxvCdSWFAUH7Dvq2wVJqu1C5jjoX5amywJH$ [github[.]com=
]

shared/gatt-db: Prepare Write req error BT_ATT_ERROR_UNLIKELY Fixes Prepare=
 Write req error: BT_ATT_ERROR_UNLIKELY

    ATT: Error (0x01)
      Error: Unlikely error (14)
      Prepare Write req (0x16) on handle 0x0069

The prep_write_complete_cb was not getting called The attrib->write_func co=
de block should not be called when len is 0
