Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771DA26563B
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987282; cv=fail; b=Glc7KjptyNZsy8cBq4ZsXZ7kbInblNIK1VYrO+5XHgQO2wMLirDbuvV2290zlHyfbAsxw72tyYKol7lXbZDwGHvs8LcYCUPd2XSwQ1sIt6OCr7bSewlvXvZUpwKBksxsEOvzdJFnU1+7ncbX1bfxQx02EWt1rAbL40EndPtkYfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987282; c=relaxed/simple;
	bh=K6s/tE08q4sjkwWNwEgXCe+X/SyhsVpsS3AP9blBZRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UseMc8hEGdCVCQpF67QbgWWwVJDp3l5zakTOyDdQHHoOZ25CVlVELMZLJjqR4B10Vi1jrShcrU/8cmtpP1/cUtOyZpGxCgLPgOvMItZywp1FYhRSZQRIACZaXBDfMmv34A4oTT4nI2cr4ZCic1XWI2TEFUYcRIRgqgTTkTDxXy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=guynxk33; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="guynxk33"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaYrTjmNLv+OKRTlCsbL9kub+XUxYZSrwooBXchSq8CtbU3ejTJkMH7Ya77StdM9ct/WIVWp6fG4zsfOnt6jH7d7cpT2p4rbgwYlrUAVKTx0yLJZ39mTxVMNxA7llFk0FYjBvbeYm06SluhmiBaYsNRB7vnnZlMfVA4mzmqWGX33oOFO1mNv0+F1+MhdBtgfmfKD2Ck4iYp9uy9X9kY3b+BigEe9QpLRgrU8yZKzX34uwEP2XhfyKZT9ylCqyXd7f7cs553t5BySGiIMVQz5UZDvUTZf6oq1sDROgeLmyQ8d3ahUkSu13qhEruIkpgAOTYpPDYCCorCtMewDOMftdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suz/IOsPLb+vmsG+JGw45/FMISCdznfGib+wsKbhAxQ=;
 b=uIiMi1I3gtO21mSdxxoYBofUgS0hyMtTQMUv74Mmy84x+Tzcapg7QKO16EmLpapKmdlAH6DExosKvekzC+FeF0Oj4niku7IdS9sOZRjtMTtSPuxQcGB/HmatYgtXBPo/y44EW744j0SdrtOpfzP457+PhpDekUCTeyYRT+sCIithZsA5QALzxJr34Ojg9t729Ee5WS7rI+aBT4jraEig7Q/jzo6+SMMh8CFumy3fQnj5x24Y/KiDSf8VMlNbImqLiBKbcJwrqebXHZHC8CzPDeoJdQ+UZTvu0r3Pi8TmIPq7bdBO/Eval9kvmwBFOr2bV0I5PXR3EcRU23e5VYFZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suz/IOsPLb+vmsG+JGw45/FMISCdznfGib+wsKbhAxQ=;
 b=guynxk33ZZ2CLtO4Broc8XSwmh/Z6UEYFiBKoEVdRGrUiO41K/+NcrFqy7D0l/CJGOKD/7TfaVjD+KpjBMGkxQ6Qz4buFZDEDH08IgMKcjvRGeQNWBUbWK76YP/mKTh8GUealAHAUiLJdHabxpMEgoSygYyB3oGcSdLm6xRGfiY=
Received: from DU7P191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::34)
 by DB8PR03MB6219.eurprd03.prod.outlook.com (2603:10a6:10:134::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 15:07:55 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::98) by DU7P191CA0006.outlook.office365.com
 (2603:10a6:10:54e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 15:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 15:07:54 +0000
Received: from n9w6sw14.localnet (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 8 Jul
 2025 17:07:54 +0200
From: Christian Eggers <ceggers@arri.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 01/15] mesh: crypto: remove dead function declaration
Date: Tue, 8 Jul 2025 17:07:53 +0200
Message-ID: <4993053.OV4Wx5bFTl@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CABBYNZ+FuqRN7v_bjjHTnJNvj1FM-m7d9BvyVKpsgNrmAAydxA@mail.gmail.com>
References: <20250708125947.11988-1-ceggers@arri.de>
 <CABBYNZ+FuqRN7v_bjjHTnJNvj1FM-m7d9BvyVKpsgNrmAAydxA@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F9:EE_|DB8PR03MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4f727f-4e1b-4604-9595-08ddbe31377f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0xobWJSRFVBVEJwUlo2UWV6K0FLU3lMdm1aaXFQSXpHNm9PT0RYTW1LSnlm?=
 =?utf-8?B?U1AybDVsTUo2Y0VOR0l4UTdkUHUxYmlGV3FraVFnSE1uQ29EOTRIcXk4dmpL?=
 =?utf-8?B?OTVZWVBwWUlUSnp3Wk5RdmR5MEswZUtPak0xNGhKV0s2L2R1WlIyTXZiUXZq?=
 =?utf-8?B?N2xEMmZ2T0ZjeXQ5Z0FaQytSMDBpSjhrK0JTTktyQjF3eVdweThkZEhLQ0t4?=
 =?utf-8?B?TWNlbFhnRGtOYVBCNDBuN0luUGpURGFIdzR6QzNEUHdjV2k1bFpab1YvYjIv?=
 =?utf-8?B?VDFhbTY0NGJSc2NNaWNEMWhSRjdGT2RTWnExZzdtd1pMbnpaMWh3akZRMzkw?=
 =?utf-8?B?WmpNRDVwRGhzYTVxL1JRNEZ6QXpyRUxKWVJBTjJWNGFCcWszemdqcVFNc2pW?=
 =?utf-8?B?K3VJVUViRlA4Q3hMNWdTeTI4R1JGQkg5WEdaTFhXdS9hOWduUGJXUkxwc2Np?=
 =?utf-8?B?NERxaVZhVnJPdFV1SjVrTGRTK1lRVGNueGlqSzI4YVBLSEZXSFNSRkJscWpp?=
 =?utf-8?B?YUpCbEd1cHJ3VU1ROFIzTU5QQkV1dkZIcjd4dWY4Qmlac1FJWmRQWlpINXhj?=
 =?utf-8?B?dktVYUlLNlFreUxDdjQzd0JZalpCVmZBVS80WEwrSGVSTnRIZzIrYTQwTENu?=
 =?utf-8?B?cis5SUt6L3VKV21RODhhYUlZYy9uUUg3dldPUEVrc3ZBRVZOd2EzMmJSY1RV?=
 =?utf-8?B?ZnJseTAyUlRCcmthMVZxVDdydlFtY1BrbHkyVkRwMU0vamIxNmd6eHRabHQz?=
 =?utf-8?B?S0VWSTdibWdoVWZuanp4ZlAxZEJTVjV4RmJPd05mOTE3Sy9YQ25TK2NFeVhr?=
 =?utf-8?B?bkZyTUZFanB2ZDcvWHBTQ0pyYVhja2QxeG5jM3hpMWpEdlBmNDJZSStZWnpV?=
 =?utf-8?B?ZVl6VUZRUU1UK2JvRXJ2RWM1RHFWYm1uVFdLRVFOSEs1SFBQS1QyL1BlTXU0?=
 =?utf-8?B?RGZ3YzIwNldwWDgvbVUyNTRjZ1pJRjIvOHloRXlOMHoya2FVNGJmMVROQ0o5?=
 =?utf-8?B?cDc4WjRld2tGTytHSGVIR1V6SDhCZkJqNXlha0FKejJzZUhpdE5OdkZVK1JC?=
 =?utf-8?B?NFRhSG9qT21FbGxTTmZESll3UVdPcy9XZTA5Nzdab2gxQW43aDZRbFlrR3JV?=
 =?utf-8?B?cmptOE9FUVpHTUlVZWxZQ1YyS1BSQ25FakJRcVk0aUhDcnFwelJrRjh1UGY4?=
 =?utf-8?B?eDFreU9VWkh2VXpFamZaazJ3QmV6TTlkMkpGY1RLL3JCb1dLMW1BVEZKWWIv?=
 =?utf-8?B?N0RmTWlGNHZMYy9SK1ZSdXhrcndOcXFFdmN3U2V1aUNZNWNpVUdFSGtXYWpa?=
 =?utf-8?B?M2JhMTFMeFdpK1hpekVKcnY4Q2F2SE05RTZXSVk1RWU5SkpXTFhpSnVwRHRG?=
 =?utf-8?B?NXVza3FNbEVjUnVRK2N1azAvbjlSQXJkQ2lETy9IS2pmMFhxdnlrWGdZZGJy?=
 =?utf-8?B?UXBuWUxmNndyMklDRGhyNkpQd294VkVBZi80ZWdINDFXcjB3b2Vqa2dSMWdy?=
 =?utf-8?B?TWo2ekttbjhxcm81NExRaVh2bzJ6ZG5GeklETUtxVVJnMExzclRqbUMvRlpJ?=
 =?utf-8?B?RTVSVEJJRUxPb0x3VVBiUVB6R2pISDNNSVZJbk9ycC95NVFGRVlXVXhVU1gv?=
 =?utf-8?B?V2ZZQ2lHUE9PRGdWMFdIaStiMGQzS2ZPMWdKMVZuWnlsSHF2K1FHdGxrb0hq?=
 =?utf-8?B?V0JyRncrdFd6eXBjeDQ2blRZSjBDVHhQQVpiVmVqWVlBWGZwdWhhVitiVHYr?=
 =?utf-8?B?Y3ZuRmR6elF2am9pV04rbWVkcnVpbUlDK1FkNVJpbDNrOEZlem9EZ2N4SmxP?=
 =?utf-8?B?R2xNVG9ud3pxUUIrZXR2KzAxQnZ1VTRSQSsvRDV6YzZ2RTNBZ3hoRzFPTU9B?=
 =?utf-8?B?SXhoR1p1SUV4YTBxb2FqV1h6OHUxR0dyTlZHUVd2ejRrV1V0TzRrdUVrRmtv?=
 =?utf-8?B?NkJMWWk3UGNMaUxuTmsyKytaL3hGNUUrRnF0d1o0SUNySmNuOGs5WTFwNGdH?=
 =?utf-8?B?Yk5ENk5Jb3BqcE52MDFKT09XcHNpWCsweis3bVN2cW5zTzNvL3kraGlTeVZ2?=
 =?utf-8?Q?PJW4/L?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 15:07:54.9540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4f727f-4e1b-4604-9595-08ddbe31377f
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6219

Hi Luiz,

On Tuesday, 8 July 2025, 16:59:20 CEST, Luiz Augusto von Dentz wrote:
> Hi Christian,
>=20
> On Tue, Jul 8, 2025 at 9:15=E2=80=AFAM Christian Eggers <ceggers@arri.de>=
 wrote:
> >
> > The implementation of mesh_aes_ecb_one() has been removed in commit
> > dfed4839463f ("mesh: Convert crypto to use ELL wrappers").
> > ---
> >  mesh/crypto.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/mesh/crypto.h b/mesh/crypto.h
> > index 55789886eb0e..3d85785f174c 100644
> > --- a/mesh/crypto.h
> > +++ b/mesh/crypto.h
> > @@ -22,8 +22,6 @@ bool mesh_crypto_aes_ccm_decrypt(const uint8_t nonce[=
13], const uint8_t key[16],
> >                                 const void *enc_msg, uint16_t enc_msg_l=
en,
> >                                 void *out_msg,
> >                                 void *out_mic, size_t mic_size);
> > -bool mesh_aes_ecb_one(const uint8_t key[16],
> > -                       const uint8_t plaintext[16], uint8_t encrypted[=
16]);
> >  bool mesh_crypto_nkik(const uint8_t network_key[16], uint8_t identity_=
key[16]);
> >  bool mesh_crypto_nkbk(const uint8_t network_key[16], uint8_t beacon_ke=
y[16]);
> >  bool mesh_crypto_nkpk(const uint8_t network_key[16], uint8_t private_k=
ey[16]);
> > --
> > 2.43.0
>=20
> Is this set just a cleanup, no logical changes were made? In that case
> I can probably go ahead and push it myself, otherwise I may ask Brian
> to step in to review.
sorry for not adding a cover letter.

Most of the patches only cleanup obsolete function prototypes or unused str=
ucts.
Patch #5 fixes a NULL pointer dereference (I think it's trivial), whilst=20
patch #10 replaces some magic number by preprocessor definitions.=20
Patches #14 + #15 try to improve readability.

I considered CC'ing Brian, but I decided using this limited time for more=20
important stuff (I hope he can do the initial review of my MESH-GATT RFC
this week).

regards,
Christian
>=20
> >
>=20
>=20
>=20




