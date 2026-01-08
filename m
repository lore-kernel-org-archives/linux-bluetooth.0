Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011044.outbound.protection.outlook.com [40.107.130.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7311346AEB
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767870755; cv=fail; b=LZlurkSA1PAuU/lfSHmyxtspcfNiRnKsii4CKpzYu8lkcgGMIPAD2yJIAiK2aQKi41FuBFU0okvvmc0/H7mLKA8hj2/NO2n6UgslmMtl5skHHyJg2Ox0nA4Lk4RQhre0laXgtPGrLqFSKuyMgaTs/3DOM53m07NLqgjPlhNLiok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767870755; c=relaxed/simple;
	bh=Laydgqk8jWymPHu1dmPg9cHA0uzD/nmz6kvDeYrtlRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBW3V0q91P7jJSnGIOJhNYBU1u3LaqpDulgmrEvzkbk9mdIapiWHOUjpiPgd+dPdPSPqaIw6+Q79zUt7hyIR0WSkK8t/IwUWvTJxS7uXsmpVmm3aBOJedeEThBr4CIPTDE4EU/FnSrWzKr5Qchaoa5tnBKFh/py77Dx++DESI+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=fail smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=tGrqVXph; arc=fail smtp.client-ip=40.107.130.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="tGrqVXph"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjmYh2XKrtrKOe6F48U+SD+XSCt6pXWRyNolLauVXHJbpWBlRKSp3gX6kYQHEllnWDTu0nO0SeN7i+JWobGT9TzW1+t0HoklKRwh+TBBv1z+/O21R3gIiUwZsw5FL5lQlCYXzSQZHlUeJOZLJJX91RI4iMqQC35gk3JhD058Hz/xs/8QumtzpnA5fbL+Sm5SPr1I+qYAneE1r3rSBxTwhMayb0XSqcT3eitcZhzr2woc6/CHFYr5YY4JCa0u8ipW3S502RQrmgalT+FBtLeEalPJI0g8aTWMQ993B3kljfbRWmaxJVgHWZNsghbJ1r2x4opJNeDxvsjbLDa73ldG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Laydgqk8jWymPHu1dmPg9cHA0uzD/nmz6kvDeYrtlRc=;
 b=uOl5uoMjUiZTio3sRjnVBAKv/WMpMX3Wm9iWB1XUxFtFkLLawm7SLnM97x68IP2FQpDmrtCrH4ZgL2wkM41TriFlpYoSejN7MV2t9iaPsfuxrfgnRAv5QJdJ8TmnItSW++/9Ah8OoNr5IALbf7ZyRz+ti3s9GyhK08XH1zMe1qPrZtj+tn+B3NNy+DYvz6E8WfEk1RE+YQezM5Of2ECMO1g9ZtPais4h1l4AxID3ULu23aSps54dmriB+9XAseehfhCh8Ac8CQLOtWYs0KWInlNqOESkLJ9ayR1v6dJLjESzBjyboAX3vJqUyHkkJBYtKcEXwBsJ+ewGwN69hUikew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Laydgqk8jWymPHu1dmPg9cHA0uzD/nmz6kvDeYrtlRc=;
 b=tGrqVXphXSSLFitby4maVnWfZtwdAAB0axDltp+KhgHHn8ufihXjHtpQI+KuKgolg/+0asRRZ7EO2VC0B9904SuxcLkkSmFHP4XrBMMwyYTB6yotPFxfd6lhRSUn2HMrwqToJoYbpmS14ZuaHDBWfOuBTkkmynjO4PYEWCazOUs=
Received: from DU7P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::14)
 by VI1PR0301MB6653.eurprd03.prod.outlook.com (2603:10a6:800:197::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 11:12:24 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:550:cafe::3d) by DU7P190CA0028.outlook.office365.com
 (2603:10a6:10:550::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 11:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 11:12:24 +0000
Received: from n9w6sw14.localnet (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 8 Jan
 2026 12:12:23 +0100
From: Christian Eggers <ceggers@arri.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: How to perform Bluetooth SIG qualification of a Linux / BlueZ based
 product?
Date: Thu, 8 Jan 2026 12:12:23 +0100
Message-ID: <2775896.lGaqSPkdTl@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CABBYNZLYn1=3WgVujb9nLdXNrfmDxo=uQvPLfZHgmABM_MiRtw@mail.gmail.com>
References: <3679882.dWV9SEqChM@n9w6sw14>
 <CABBYNZLYn1=3WgVujb9nLdXNrfmDxo=uQvPLfZHgmABM_MiRtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885A:EE_|VI1PR0301MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c710b90-6073-41e5-2cd4-08de4ea6ccee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzU4ZjRXZFIzaFIyNEJTdDJEemFZcnpDUjU4aCtNRVlWVVBqN1g5TTRCeCs0?=
 =?utf-8?B?SmdmdjVualBwTW9MMzdGNVpjREJpR3lFOGZQbklEUFRnNTRuajFYamlqZTRP?=
 =?utf-8?B?WWpENWxLelZCbGNoRU5DU005STZUeWFQY0l6ckdQMUFSbXB4MGhtV1R2M1FX?=
 =?utf-8?B?eVJsUDVNbjhmU1lqY0RNWmswWkkvb2VUNmNOQUpWc3dsMTJwa01uMEt0NXVH?=
 =?utf-8?B?c28xUU5pQnVTOUF3akRFUGViVk0rUU1mcnI1dG1qZFplRFNZRTl4RUMrSGtx?=
 =?utf-8?B?ME5zWDFhZnN2ak9xMTlwQ243OGk0WXdxaVdJeGZUT0dCcUFKV2RnRjJxY0Jz?=
 =?utf-8?B?OGJXMjYveVdCcmJjMFRRL0FxaDE4RlhoU2owQ2t6S3Z0UENzM2I4T1hEbFh4?=
 =?utf-8?B?SkR5L3ZlTDlGQkIwc0QvWjFTNHJraHE0QWw5V1dmeGxNaFFnRnp6dWVGZC9v?=
 =?utf-8?B?NGdTbTR1TVJyMFZvc3psNVpGaTh1Y1lQeVVheTNtekZWbFpUU2RNUmhYYXZQ?=
 =?utf-8?B?ZThWOUFFWUorQy8vL08rUW5CN21hRk81bDZqWlFNYkZETjZHMVBaRmtkcGhw?=
 =?utf-8?B?RGRxRDI4a0l3cFJCODUwK2RnenpIT0hGL01id0V6RTFnQUR5UEZjS0xHMVo4?=
 =?utf-8?B?M0hEaWovYjJ2aXp2dGUwdFNJbDMzdEY0bFlIYXhlaHZaaEVFQUxFUlJrR0RN?=
 =?utf-8?B?cDJLS3gwRnhIVzNLRkpKM0VFSTQwdGRVT2w2VzR6RjZtWlJrajRzM0pSU1hK?=
 =?utf-8?B?cStwN2JrY3NGaW5VTlJXL3NiY1ZLSHllYUo1UTdqdm9TdGdRZ0dPb1pMTC9u?=
 =?utf-8?B?aW1reGJwN3RUbUk1am5WeXVJb3VtNG4yYWg5WDRqSmhZNkFFNlhNUTYwN2RT?=
 =?utf-8?B?ZkdMdWxTcXpXVDNXMEdMV3hVNW1STUVoelZNQWZ5UGd0bUNnbGV4cWxKQUpI?=
 =?utf-8?B?SGhDUjR3YmowcVF0NkttSmY5eUVNc3lMOU85L1hXU05qb1o5S1NnSXFhVHZl?=
 =?utf-8?B?VnVySHhpL09FSzhEMXVpb3BJbGxDMFlEOC9LQ0NaK050UlMyTW9oV01nM05u?=
 =?utf-8?B?OEdGODhXUkNmM0cza3ptUjczSi9aQUN2akNSa2hWR1pCMmwrdkR6Z0F0Smx1?=
 =?utf-8?B?VVpXUTdtVUExMmJKbEx1KzFQMXgwenYrZnI0cUZSZHJlME5uVnZJTXluOEps?=
 =?utf-8?B?c1NlRGZXTG5pcVo1WUNnb29ab3Zhc0pwRTMrT3daZTNKa2ZHYTI4NU1RcXJP?=
 =?utf-8?B?Vk51dVBGTktlMGZrMno3RGtVNVdRYjhRYnZkTlpqOVBmQjcvSVJINjVTSi96?=
 =?utf-8?B?Rk5FK2Q1Ly9MTDZ2VzFHL2VoeHJ5NzRBcmUrSWxHK1Ztbm8vYVlCUE5nUzE3?=
 =?utf-8?B?emRlcmRlK3FoRW0wVWM4ZzlWYlRjVTM2QjB0VFh6VUZLdU82QzB4NGJ6YzZZ?=
 =?utf-8?B?SDFFTmVuaWZneTdlMTFsWENySFh6Ni9DNlNabkM3OEpEaXhNV0JUdUxKN0ZY?=
 =?utf-8?B?RUNTVXg2a0FPbkcySWxBNDhrdk1HaytnUmxLdUo4UVR5SFNXZkJTOHdpK2lh?=
 =?utf-8?B?TmhxVkpiNThiTnhPWUQxeTVIUytsVnAzRTRpRXNoT0RoNkhqT05wREpIVm4r?=
 =?utf-8?B?c0NFbmF2MDJQcGFUSmIycU05Z2dTYjhNSEZMejcyWWFNTmxEMWxtcXJ0aG9u?=
 =?utf-8?B?NE11T05qVHQvZ2lMcUdUM0lhd2dsOHg5T1RNaWg3VkFUbFlqZHA1bEVNYThq?=
 =?utf-8?B?THVjSWdjYS9OWjViUU4yZmhhQTgvL0Z0UERJTDYwY2VuckZiNmtRVlQ0c2dp?=
 =?utf-8?B?N0M0THRucS9PYjFYcnFEVHhMZGtzV25NWWdNV2N5TFJMWUxGRUFJclZvU2sz?=
 =?utf-8?B?VDVGNVp3NjcxTXZhUUxidGR6MWg0b1NLbDkwcWRBeTU3R0p1am5VT1p1Zmd6?=
 =?utf-8?B?ZWhKQmo0ZldZMXRKVHFETk5oWkxFd1dUTzlDdlNwak0zTzBhVFVpREV6OU56?=
 =?utf-8?B?NVJ0Y0NBcHU0T1dEbnpzcmRrWkRlNG1TaW9vcDlYR0hadmZROXFhNGc2K2FY?=
 =?utf-8?B?NllyYVIyT3FGNW4zbW0zS3BIRFdHc1NCbjlPMHNQVGdaRmE0U0xkUVdTQnF4?=
 =?utf-8?Q?imdo=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 11:12:24.2098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c710b90-6073-41e5-2cd4-08de4ea6ccee
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0301MB6653

Hi Luiz,

thank you for the fast response.

On Wednesday, 7 January 2026, 18:37:09 CET, Luiz Augusto von Dentz wrote:
> Hi Christian,
>=20
> On Wed, Jan 7, 2026 at 12:17=E2=80=AFPM Christian Eggers <ceggers@arri.de=
> wrote:
> >
> > I feel that I can't see the forest for the trees...
> >
> > I am in the process of performing Bluetooth SIG qualification of our
> > first Bluetooth product. According to what I understand, an end user pr=
oduct
> > (Core-Complete configuration) consists of a hardware (controller) part =
and a
> > software (host) part. I already have a QDID from the controller vendor,
> > but I feel unable to provide the QDID for Linux/BlueZ.
> >
> > Of course I understand that Linux/BlueZ is open source, so there is no
> > company behind for performing qualification (But I found one qualificat=
ion
> > for Zephyr OS made by Linux corporation).
> >
> > So do I need to qualify the concrete version of Linux/BlueZ myself? How
> > much effort would this cause? Google KI mentions a tool named
> > "Bluetooth Launch Studio" for this, but visiting launchstudio.bluetooth=
=2Ecom
> > redirects to the qualification workspace.
> >
> > So how to obtain a proper QDID/DN for the host part of my product?
>=20
> In the past each vendor used to qualify BlueZ by themselves as it
> normally involves a specific kernel and userspace version, we are
> discussing the possibility to have a generic host qualification for
> BlueZ under the BlueZ's steering group, the group is closed to only
> BT-SIG members though but Id be happy to add you if Arri is a BT-SIG
> member and is interested to join.

ARRI has created a BT-SIG membership a few months ago. My personal account
creation has just been finished, so I am interested to join.

Of course I would like to avoid the need to perform "host qualification"
of Linux+BlueZ myself. But as I am curious, can you share some information
how the "host qualification" is actually performed and which tooling is
involved? Is any special testing equipment required? Is the test suite
publicly available?

Entering "BlueZ" in the Bluetooth SIG product search shows that the product
"Core-Host on BlueZ v5.48 and Linux v5.15" has recently been qualified by
"Sky UK Limited". Do you have any information about this qualification?

regards
Christian





