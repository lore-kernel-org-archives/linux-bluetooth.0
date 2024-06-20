Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5281B47DF
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909864; cv=fail; b=WkPceVY6lPCG/QLUzXaZkaYkOPs4WK55rf2uZb/kvA1Qj+HPnmziEoQFXZcL38V8fqu7PumndajBLpYqmGU3xxy/bfX2+nFT5KgxkFKuhoMXvZ7kWMsr/yIclEmMt8tTfhcIDdd1j5FRFRpEGbcj94qCF+QWi2sxj1iAGN7OjWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909864; c=relaxed/simple;
	bh=aX6ez6L0fDkXVXyxv/ciWakgU1Dr+GCQlUzj3RBxB3M=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R4DIrXJdjgOCt2/iqtOSd8+MywU5bj3dWASFuofIyn2pOAV594RSMarNXCeYkM4hGx+B2mQQ43ifkRiSeFxmRtyyHD/LF/dxjXs2Vso6W1B+Ptf+jj+URMDJv4yhUi7oBetATQOko6GHgsGYs/JKUBILXEKNeHxZO7tKgopcfQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=YKRzpvQ3; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="YKRzpvQ3"
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45KHnH2B010297
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 14:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=smtpout1;
 bh=2fnk9TPKWjudMBq4AoNV9JiQojqrRBLBoul9oNMpeMU=;
 b=YKRzpvQ3K1PNiWMR39FIlCtB9vWS/g9ykM/C4/eibVM7uIevfud2iJd3yMYVwQ8Y3/FD
 QY6TUpxuULz5wsKxuOFQDyvFyzfWOi2KsQhrfVoiMGbuUlWqxDcHydxLCjuwOOYJqPM8
 ipKbrVDigEpf/e1JemXthkcLn5QKoXJ/gHOlm++1nd78vT8lTTEU/PF9X7tvIHcKDuuM
 PvEKRSM8N/tVPNT0lxNj8huRFwJkGA3zh5BGqXvIueCuT4g54oERnyGeEJWveLZZaz6Q
 29vXxtw2D6VfbpJj4c2uFqMSZ3uDMxRWWvck69TSNSgwkwlhaGv+/eEE/xG3FbVoQQc3 tg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3yvs5pg88w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 14:57:40 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45KIhClM010792
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 14:57:39 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3yvrp9965x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 14:57:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2HYYvbQ9Fz7p/WHxoChB0sPKKlAUFZB9JFkzqupCl37YAFoUTWZPziH5gRqmH/uVnILJo3amfoBOUjo+E23yxj+CMIYVuHCcVlGtmom5CH3bsPWoJ9VjMdENR/qfwz6foNX9kbj6oMx3AtYeVyvZI9cA8Bx3VhOVl/PRl1sbhnh3JW0me5ENR5+//k0WClbGdRmU7qxCnHgE0Kj3KcZm4s0QzU3hoPN5iNK5rYPqpndD76QFOVWIcgVPLfQMq0hqBQddx1jwUJhjEJFykoDTLTMSZNhUh+FI9/eNbrKlADQ5LFej2y92rjsBiWB2E8vOIJHT5V9QJD6GLUWVJsg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fnk9TPKWjudMBq4AoNV9JiQojqrRBLBoul9oNMpeMU=;
 b=TyzECz55HPNwuYk/3Nm1IiQOSZX1RSbATFClSqm8THQN6FO8OwCTLRqNXHGCi89KNcVj+vytzx0ls2NS1DG8Q6pdF1Or2vfOMkOLrsk3IXYVjNjJ03he9XfaU+jWO2G2ToifOeSfMDReiGMEOr0fpKFqqUiyM5468zSvoCiFjK7ssxGjjkLHWJXU3PCQswjG47836fnd3RUBNpRGukFsPj+q7Igeu9Uqq2ZZ95+82dLs2UanC/JD6seRuWIR+BBo5QEETidpRF6elGzSDkeZj9LrdvvdLeEs0kDvxqDScYqGbXGbxBRc+OYSb/ISUqwlm2mdRn7ylDtX4Ou0a+uNZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SN4PR19MB5421.namprd19.prod.outlook.com (2603:10b6:806:20c::7)
 by PH0PR19MB4922.namprd19.prod.outlook.com (2603:10b6:510:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.20; Thu, 20 Jun
 2024 18:57:35 +0000
Received: from SN4PR19MB5421.namprd19.prod.outlook.com
 ([fe80::237c:614c:8f0b:ae83]) by SN4PR19MB5421.namprd19.prod.outlook.com
 ([fe80::237c:614c:8f0b:ae83%4]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 18:57:35 +0000
From: "Ramsay, Trey" <Trey.Ramsay@dell.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14)  Prepare Write
 req (0x16) 
Thread-Topic: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14)  Prepare
 Write req (0x16) 
Thread-Index: AdrDQ46/6Jy8+sp6TbCfSD4zIwQXtg==
Date: Thu, 20 Jun 2024 18:57:35 +0000
Message-ID:
 <SN4PR19MB5421B1226EA92B735CADEA44E4C82@SN4PR19MB5421.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=f55f75bb-60a4-4c83-b5b8-07503f14e6be;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-06-20T18:55:26Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR19MB5421:EE_|PH0PR19MB4922:EE_
x-ms-office365-filtering-correlation-id: a5dff9cc-01c6-43a9-4d48-08dc915ad934
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?y+iCaeIjFRzwKmCGmlBQu0PaVmhEtsIr8juMGp7F1me4qk6xTdK/pj9HX18j?=
 =?us-ascii?Q?BGOruhZX2JDCPeaKciIDpbZIowpRjp4YQYbH/4RsJopxnjEg0Hw13u3a9t7/?=
 =?us-ascii?Q?K6zX+Dl08E0KxSdGLtRqGPM56zcfAfHPEAHmtW59gjZKu2qhcMIySWmO0R1L?=
 =?us-ascii?Q?cMHEMJyh2JPibmMJis+I4LHFNUWxdzcJabKZvL3vjY1ejRKGaIOp0YuxymDf?=
 =?us-ascii?Q?mpAcfiC5uDkU6iDCdFsT2BaTE4cYsvGEFOV053PBI8PJBneZOm3hSJLX30dp?=
 =?us-ascii?Q?Dma6GN4byBFpPETBcE2/Uy2+x+0l6yjc6L/b9UG3JRrn3ARkKwFHNfoknlzG?=
 =?us-ascii?Q?iE7vgR7o0dIA+bsroU9iCG1Dl7AMdKykuocdXnn/UsZCid/n/VaWDdr8SvuH?=
 =?us-ascii?Q?n0SqbudWgKLrIcg72YHArXN4Av72ljoMLLZd0SXGKNyecBDv2ANQZp4maXYd?=
 =?us-ascii?Q?DbhgC1WGV5jVImbAGt8iHJz45QXyvImhPRxVy5OqrAQF+DjobRGV0N1fc/cp?=
 =?us-ascii?Q?O1q5XkFG75UixeQdArd4LaN6E3+lYu1h4q3BBTCkqKMIiiwLNae4naDUgSb/?=
 =?us-ascii?Q?pUK9snlOxbpfSQrcQS0eyn/0pe6gFJTH/00O++wgN4unCNeMGnKSXUtP1U4K?=
 =?us-ascii?Q?nh19F4CSKM4VEoyEjadR/AR67Z+WZNIfRo1Gp885tyiCDNgHq0xXvNilCcEb?=
 =?us-ascii?Q?WVWV3Udrl09OtRlwr9i9lsOacAHQwGcQU/gQDkkq/dkPxiETJcxeEhu0JnhN?=
 =?us-ascii?Q?QptkWuZX5DIS1Moa4iNjXAhu1gAY2T2Q/sOuozfvJMp4j8q1rdT0Ftp0iZqh?=
 =?us-ascii?Q?krQvL5EWTeo+ch+7c2SJwMJhjfkcg3EeuhYd6CTFPgzPq+c6EJrs9la5vgqM?=
 =?us-ascii?Q?EAuVBIKLj9c5WB7VDawISTZaaXAiNcXB25uTMas5xmL/UDyc/obwPtfnanoK?=
 =?us-ascii?Q?PnfJ2gfmKk8adqTCI9jgE7phSFrWmwUezRSItYZchEtDAdZ5p3qgSAIrsnM8?=
 =?us-ascii?Q?aOiAktAzkxmamJVHC87eahaj4S+7BSWPkC6F1ViuQpev2qN1hcywZRJf8ZX/?=
 =?us-ascii?Q?7nCkztiap+OoXK3tPdtc3bgqw/TSZKHoJYQDpZaAixvBQuz2soynMuUWdbgJ?=
 =?us-ascii?Q?CsLCeR287cLiWju92ytbTipx7vwpIPditZSAdUAF2n/z+kxAv7e4NSvuO90I?=
 =?us-ascii?Q?jxOz0vQH433FpHjeRGU1Bx4A1BgXvR8KfBcepk+J08SE4UINj2LltmHQtl0m?=
 =?us-ascii?Q?r4H49ammazUh3axavMdQPKoUTwh29kba3dl3jCxJFPSW0m59+FJHfyV6O/Qf?=
 =?us-ascii?Q?O5mq3EHP2iylF+tDC5Kn99gO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR19MB5421.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NIUBJAh5OQnsk75EeM4E7F+JrGLuh2dL95XNpvXWYzzGyjxP8BusyOx/5tc9?=
 =?us-ascii?Q?8O4k6cQHFJqYlwf7lyhomFovrF403FxLAwP7vXgCcRfq4mhrZxWwLZNUqYqm?=
 =?us-ascii?Q?EaT8DVC+9Dlu0Bp/D5gP5gGI0W9EvjpOHcexknayaqcItPseCWrsTrci6Jyi?=
 =?us-ascii?Q?fwKfMUbPmSTGlF4QC5kQvWJBkkPOdntb1rgoX0/sTd6me+OS35jFwePBjH7B?=
 =?us-ascii?Q?2FAZ7SQw9e9DhMQbxK0nPOqzzOnDFjhJiHSPJ6LqJmQVBSofFYseoUIUgfly?=
 =?us-ascii?Q?/DNo4yEti35QJzfpuEowoImss4+kypj47dN0d/zd5wrYS1zhKFWPE/5dSQeZ?=
 =?us-ascii?Q?bizW89cs9i4jzUBHvHMySe7dtoRDEq6CMK6imWpskQKUe8lJLhdHc5oPfT+B?=
 =?us-ascii?Q?Q5rLfMskXZo6Nwr3FkISo/R5lynOLnDF/6ZjezY/YjS3hk0RWSDhI1S3TmB+?=
 =?us-ascii?Q?pCGe4z1MVipPzXr5a16KnXK1vWwYCx9EqfucpXSz2ZoV11p3qd/1iAfoGhR8?=
 =?us-ascii?Q?RvpXf4XFNBdwahDjlnCFr7H7ETHXJfSpZL9SAUxeuNkdK91XTFdg7r0TAGT5?=
 =?us-ascii?Q?QL4LyBO4EAiQkLDJfHJ/jBABkY0vfh2S7eIumBJ8ltGrIc8oQEaKWQAf8Eu6?=
 =?us-ascii?Q?BdifHypUUTXGtJdlJP3Z58Pk6U5KoYdonhBqpK4V29F7Qtvj2mD3+UjUDWj9?=
 =?us-ascii?Q?jNmE+6HbGWGbhzV9zJ3MaKfLvVqIChtUc0XxPND07sVSmD157S8gV6fv8qoe?=
 =?us-ascii?Q?VutJcOJv6diuuKhzlSiiDrPdAsSovHoiVR2QexEiu3brZ1q2qj69vFBC+hqG?=
 =?us-ascii?Q?b7W6Ykpz/2+dt/oxPMzjK6iF333FCrfHK7O7pC7DPurnxTKKuNPF89sgCD2n?=
 =?us-ascii?Q?zS+L83qNRSgfq630OsrcA9qrG7gYHNL9kMkfIWzteB3Ar7g+cL3GXG0E1RCe?=
 =?us-ascii?Q?67zbvlfwfpV2tQPG0PUDVpDF/yzF1ycLVxuWFbObzzk6aK/lXSeLiPJ/H9ue?=
 =?us-ascii?Q?7wWPWpcqqGAUZDgBTr5mVzfjJ5NVksvdtLdmbGvG3s/FIrTac5IwhHwmi/CJ?=
 =?us-ascii?Q?cOyvyGX0YOuF0Fs/fMzEGEQqCwCTubaRXsMhnicMWLX/5rXpimZnDMSOHXEd?=
 =?us-ascii?Q?Y4StIsiVTnYTr92HOsbZ/o3F3/7rptL4F2f37+nAA6lzoAJkjYC+Z+mQpfSX?=
 =?us-ascii?Q?itPMSsdAkYkHmG2phDBJirpXvgh+fxoU4o1NarcWrm9MijkszLcIzXeLB0sD?=
 =?us-ascii?Q?MF2d2vGJijnX47JpY1DkKHZnM7R82FEcWgUHF0PM4FNHg+R9SyEVbWqhSrsN?=
 =?us-ascii?Q?07J59YcwvJp34y4j9NS5If1+eSG4YfMy4I3kNb0I6PYwIy2iJAMLcgwOv35J?=
 =?us-ascii?Q?u7buX+Misj23nY9mZdp0iOjnLrGDFo7lnWVi/f+LLi3nDm14WiHhpl6NsKPc?=
 =?us-ascii?Q?KCxmMDwSUTM6doRt4gE/ZJpNXBxNUWqlMpuKdARq0kQOsYBHRaQ3vB6jXjQG?=
 =?us-ascii?Q?CyUp+ZoZNhQw2Lg3eJ5Oss7WYsDsqmW7GwUFiDUzNMTDjwqZJ5SELlzr5ofN?=
 =?us-ascii?Q?9HemXgzvGnhWZY2rPum2vCEH/+r2PE5WyEew6m8e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dff9cc-01c6-43a9-4d48-08dc915ad934
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 18:57:35.6435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUGqcLbzF4PAUz5c4X/Vjp+EIyIgWbfRaQdDuI+RlhdsJis2OJAiDXz7/KNbHSVR/4Q5wbswsh+7fkkU89BF4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4922
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_08,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=618 priorityscore=1501
 mlxscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406200137
X-Proofpoint-GUID: eK1_rMgv4M9apWVh9KSukOZwYKiMiMa6
X-Proofpoint-ORIG-GUID: eK1_rMgv4M9apWVh9KSukOZwYKiMiMa6
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=571
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406200137

Bluez Maintainers
Here is a fix for attribute writes not working in src/shared/gatt-db.c

https://github.com/tramsay/bluez-tramsay/commit/246bc960629dff34e744c728f04=
8e9f50f1a005d

shared/gatt-db: Prepare Write req error BT_ATT_ERROR_UNLIKELY
Fixes Prepare Write req error: BT_ATT_ERROR_UNLIKELY

    ATT: Error (0x01)
      Error: Unlikely error (14)
      Prepare Write req (0x16) on handle 0x0069

The prep_write_complete_cb was not getting called
The attrib->write_func code block should not be called when len is 0

Internal Use - Confidential
