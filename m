Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1757B18E20
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720728889; cv=fail; b=gCy+/VxO8oUSAZwpGn6GXrQNgnj16pUWl5AMA8b79ASUZ6azak4E8hU5EekFE1ap6gJB5o7BYHDyLcgAaN7zCBgaY8+d4QEeZdR4Am9Q1MKj9MGmO0xe2g0VATA79SuzB7Spxq2qY7n0BrfFEqjI1lAgn+aczCqBszimm6iEt3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720728889; c=relaxed/simple;
	bh=VOSIz2cwvmhGRo3R18KQ08qpDytVTp18N0I2IehnooQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cR9aNZQEkaeS3XU+9m8R1IiJc7AMDGSgnoPhEWVUF5X89HEtxondPSvw6yM/JCOTwNKwrgCNK7LByxQobeL236OYfAvI0Bo/suetxQ435CwfYX+3jQyfwWp9S9HUlVObdWLz2QfI6GyuVJb9ZHriKDipe+KOvmjTwfT/pgQ+eTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=aQpI+Lv9; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="aQpI+Lv9"
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BEVOvC025389;
	Thu, 11 Jul 2024 16:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	smtpout1; bh=mpyZJPyWiuziFdUl3/XJ75mv/MnFoQrE8eq68Zlrbk4=; b=aQp
	I+Lv9tgyRZRFo5sgbEQ4tmK0RhHM0tIBmrQTc84kFlcvLDd4kS+eOVgGiNXXNESY
	hljSOPj3MKhSlBPoL+ypDnhg4H/XMepvNNZF7FiYIdAVqPomhL88yWqz3xE2LciD
	47nWlPcoqQ5WzYxmC/aGwkJDlQjtoXL5VUyFJyB1l2i3ks2qgOa8asIR6bZbxsSY
	FtL5fshVOwHlk3xQIW/VZ1/Fb2XdA29EVi08RZFPLLbpmXE5P/1nVkG1AOcQi31H
	sZM24cxSRhkmkrByvetmOCTaupFSfvkJAL5XhYcB/1JCvBevxBJI8oAjwuUFqNTp
	p61vWGQGrmAQrRXVsXw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4070g394sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 16:14:38 -0400 (EDT)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 46BJGmjE029601;
	Thu, 11 Jul 2024 16:14:38 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 40admrs2y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 16:14:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFCfWl+rt4ZssliJAfBN/7c0KVaGTQgCMZeybWRNmzOgkTETP3pw3L9Ej89pIBMKRoroKucDvmMWNNiz62EahDm6GRUxaaYV4x0saMx8/jWIuFUeBD48fCvafiZUfd2UY49Rg+o1iimjRgU0LpfW+P4yzpue4QAJtE4fJDIJOgLfn7t8X6sspX9DsOIjwWfGIRzaWd+K1+1qWozVisQ+hhZY292D790YomL7gTB3JpRhOrsueeaAavHgYQEFPfFAXk7jqnx2henUJxUOWfv8gvXpfSLVPzIcY3UhAuZ3aIu2hEk1txr/zDWD3yKgcsFGWZx7QmNXg9b0Cz7A8nwg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpyZJPyWiuziFdUl3/XJ75mv/MnFoQrE8eq68Zlrbk4=;
 b=ZpRK5UFp4V9NYJyk+ObhkrQ3KTgeUtd/utfn0v1IymXGITitgtJN8sfbNCNIpPIb1MRrc+G7QtWNLYYq7MuQAEiKfMInHj7ZdT+33XMA8GTsG7cAZbOcPm1QWtYybS4kIZ8XqKwE7mzb/MbPcMvLHv5fQtK8HkEfjURhMDIhwNU0rvVuvcf/LywWHRC/NvfeGJi83ZomruLrnZeRBh4Icm3Cnc/TzbDR4TYy9iVjsv+CNsL4VLVyOuerZNSmbi5L8rQs0EzMwqi3qJX0a+uyklKa7O6tV8a+JzuYXe/hWY6l8SZ7h4ERH10KVJa++3SWTlyeNmFagYWq4u91N1cfEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SN4PR19MB5421.namprd19.prod.outlook.com (2603:10b6:806:20c::7)
 by SN7PR19MB4814.namprd19.prod.outlook.com (2603:10b6:806:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 20:14:34 +0000
Received: from SN4PR19MB5421.namprd19.prod.outlook.com
 ([fe80::237c:614c:8f0b:ae83]) by SN4PR19MB5421.namprd19.prod.outlook.com
 ([fe80::237c:614c:8f0b:ae83%4]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 20:14:34 +0000
From: "Ramsay, Trey" <Trey.Ramsay@dell.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14) Prepare
 Write req (0x16)
Thread-Topic: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14) Prepare
 Write req (0x16)
Thread-Index: AQHa0j9b0zaQeN00PEyxcrJ2hKNEr7HwXB7wgAAbcQCAAUmRIIAAFVYAgAAcjgA=
Date: Thu, 11 Jul 2024 20:14:34 +0000
Message-ID: 
 <SN4PR19MB542196B1C79E5262A2F578FBE4A52@SN4PR19MB5421.namprd19.prod.outlook.com>
References: 
 <SN4PR19MB5421B1226EA92B735CADEA44E4C82@SN4PR19MB5421.namprd19.prod.outlook.com>
 <SN4PR19MB54215EF3B4E7380A21387D2EE4DB2@SN4PR19MB5421.namprd19.prod.outlook.com>
 <CABBYNZ+8ca5f6nWG3D3x8mL3g=57Z0pogQP-+ww_aQuC0R1DWw@mail.gmail.com>
 <SN4PR19MB54214DD841A41FB8C01DDFC9E4A42@SN4PR19MB5421.namprd19.prod.outlook.com>
 <CABBYNZJpG3ioCK9Skqx7_ki3TrqF+Z0GecApPF6Crv+D+J3hDA@mail.gmail.com>
 <SN4PR19MB5421EA5BEB05EFAC63160576E4A52@SN4PR19MB5421.namprd19.prod.outlook.com>
 <CABBYNZJXfviR-5FND4LxMtdwDL1y-_iRkEJsrp+PkyVk+g=BNw@mail.gmail.com>
In-Reply-To: 
 <CABBYNZJXfviR-5FND4LxMtdwDL1y-_iRkEJsrp+PkyVk+g=BNw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=dc9eedca-371d-4024-8aea-96afa2b20680;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-07-11T19:51:43Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR19MB5421:EE_|SN7PR19MB4814:EE_
x-ms-office365-filtering-correlation-id: da494aca-c201-47cc-29a3-08dca1e61500
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-7?B?Mkt2Sm9OR1ZRTjhIMnBHL2c2SkppVjA4R0NzNzV2TEcxdVlVNS83VGVEZHJV?=
 =?utf-7?B?dlE2VzNwYVVtWXc5TTBuQ2hvZkdrcHdBODNKVHpuQ1JzZkRzOGtuOExTemZT?=
 =?utf-7?B?aGJSMlUrLU9jeGN0dWlOOEt6dHB3eS8wTUVUOEZzL3FNTUVkdU16RDR0dWlF?=
 =?utf-7?B?M2ZTbHU0UjlST0hrLzFyNVB1bG0wUEV6MUZWdFRuOXgxa09pc1RDWTFGckpu?=
 =?utf-7?B?RnpRYkJHeHB0U1EvSEdKSzEwOENSMnhmUUZvL3o5NGxPYUc0MVhGSjNGOE9i?=
 =?utf-7?B?TzJoQmVMcE5JRXhpNnZCclg4amI2aXdBVTVZTFI4Ky01SFpJTjIzb3lkWkgx?=
 =?utf-7?B?TC9qMzVkKy1HN2FxYTRrRnFoM1FhSVpSM0tMNHk1Uk5Na083YURzN2JWenpQ?=
 =?utf-7?B?WHoxaDhnaFk3U3BpZEd2NmpEQlR5QlVwVDhFenlmUDhCNy9Vb1hxVjNVVXB6?=
 =?utf-7?B?dWQvNDMvRGdRYjB4VlY5NnBaL29RTVdOU1ptaUUvRlYrLTJlcnl6d21ud3d5?=
 =?utf-7?B?MVpOTWM2WmVkUXJTemR4OHM3SXl0UDh0bHEwZTRSc08xVCstUUdMZEhWM1gw?=
 =?utf-7?B?ZTgyN3paSDM2ZjJSNlhmNFZOSlRiR2h1Y2pJUzJrb1JhR041dXBPaE0xbEU4?=
 =?utf-7?B?VW9xWUhVb2w2NEdRREorLWJJKy1tUmMwejY1U1RkS3ZGY1lkRDdoMWlXSmRt?=
 =?utf-7?B?a1gwVEJGaDJ4a0RMSXp2RUtrWGE0YmJMWjRaRFVCb1pSR1I4aU8zajJ2NjFZ?=
 =?utf-7?B?U0ZqV2xad24xYTVobjlocGc5dWhkU0RQQm9Yc1hEclFvSGpUWWkwbGZXNkFK?=
 =?utf-7?B?Q1IzNFdrMjRDQ0pWWDNobGFvd2JwYlpwa1VJbEtmY0lJUWZNckJ3dC9KOHo2?=
 =?utf-7?B?UUg1ajR4a3duYWFhaDVDWFI4aHlmTWdjeHNGQ3VDb2ZrZVhkNG1td01pVnBq?=
 =?utf-7?B?UUdUZy80QzBJbXJySlVoMVJyanlVRlAxUGNKdmZqWGhMSi9zNmd0Wm9SKy1F?=
 =?utf-7?B?SHdKeENWWDZhYTNhUDRnKy1mRml1OTErLVgvREpVUm1kUmF1L0VRV3JMckdV?=
 =?utf-7?B?UUtpSTJ2L2pSY3ZDZVN4ZmdMUTFHSnNrMWFWT1poUUxzUW1HdmRJR2pYRU02?=
 =?utf-7?B?SjJvOTE0TEhxVXRtdUhMZSstRnpUYnFKcGI2bFhBeUVLem9KUWdiS2gxODFo?=
 =?utf-7?B?UistQjFMYVRpRjVlZXJqQzkzVDZEZWtFYVZ2YjAzVzhTREVBSGNqVElDR2Rm?=
 =?utf-7?B?OW9SODZwMTMvZUd6UGVjL0NoTzhkVUhGc3lnMm56MzZxWFZ5bncwNEFtanlQ?=
 =?utf-7?B?Ylk0VGRWKy13VmEyNTVweVBIbENhMmNVeHpqQ0t4cnVGQ2N1SHJXT09kTlkv?=
 =?utf-7?B?aEU3V3p0em5FRDRKYmZSU3JMcVg5a3kxcm9lZkcwa3lPS2lJZE5jVm9nY0dt?=
 =?utf-7?B?MjIzNldCeGtqeEF2akFoUXM5aUtZYVJseXMzZEJ2dXRjOXVTb08veWJzUERn?=
 =?utf-7?B?U0MzQndUbWgvM3llM0FYL1Q1SkR3T1NYcW5VcXBxTmRZM2F3SXhUWHVCNTBT?=
 =?utf-7?B?eGJuVnpyNC9EbHhvNU5Nbm1oZTIwQ3VkOWlSb05LZEFUckRIdWVXOTR4T1V1?=
 =?utf-7?B?REhvdmZValgydGVYSEVDemN3MzVmUzVqdWtQV3pEM0J3S2dvMmlKUU9mbDlp?=
 =?utf-7?B?T1ZiYTFzbFdhb2FDdm5QQ3QwUm1aWWhjR2xCOU95VE1tSWhySWM0dFZLZDZI?=
 =?utf-7?B?cnFOQ2VlVSstNHlVT01DTm9ySTRVM1hIKy1JS2xQV3FJbkdwQ3dwbFFYRFRv?=
 =?utf-7?B?RXVxWlJyQ3BUc1hNN1d4L2lhb2lSRk9OcnZNZzA4V2JYMjFwa0dKdEFlQkJM?=
 =?utf-7?B?dS9pb0ZOSStBRDAt?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR19MB5421.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-7?B?S2I1ajF5VjUwTGNDOEx2SVBKWGRiTTVrSVc3MG5JZVN1S1IwVGw1WXprSVlB?=
 =?utf-7?B?QWhKMUcrLWFNa3N1UUVSempZTi96S2JVc29QR3Uvd2V5a2p0YmJzaUVjc2tS?=
 =?utf-7?B?TTAvaElEci9iS2NuRVZUcGxJeWVabTBoaUQrLTRZRjdyTDNobkZnU01hMncz?=
 =?utf-7?B?MlVzVFl2ZFBoS3N3ZkgwSVNyM1pWcDlJL1VUNXI4dE1CNHdxbzZEbTR6UGNv?=
 =?utf-7?B?TllRSFpTZ0VhazA0LzAyY1RETistYmlKMHJrdGlFd25vOXZoU0hHTWpkZzdH?=
 =?utf-7?B?UGM5c0NJNGJPQ0RWT3VZRFVtZ0R6VHRxZU1MM3NVY3o1dW5ISEM5T0hYR2tU?=
 =?utf-7?B?eTNWMDJ5SCstQVh3bzNObWw0aCstUDZGNW9JbTUxZU50MW1pb2hkdk53NEJD?=
 =?utf-7?B?R0JPQWs0Q2pRb2VsbTBJSC9LZElXM3FIaFkrLTFvR0NwN25PbzhRYWtqQkFW?=
 =?utf-7?B?Wll2TGdybDZ1WTVnMVlmUnNRMjNxNkk5R21MME04V3VFcFAvak4xMkNvNjFs?=
 =?utf-7?B?WkF4bjNPKy1zbmgzZ2c5R0EyVjZ6dEZEaFQ5eTc3QnQ5MmJ2WW1wdUVvOWQ3?=
 =?utf-7?B?R1RqRFhLU0ZYaFl0cHFBaW9rY0VsamFwdGNyUERQWmYwZmJ2Qlp6aE5BeWNK?=
 =?utf-7?B?OWVtbUxTSTdhVXMybDRCRmdaWSstT0pEdGNvNW8rLUtoUHV6U00zQkVMVm90?=
 =?utf-7?B?TmI5bkduajFkSGkwZnY0SVRjMGFOeVVsUlBqb3VqcG1jNzZjZzN3OFZ0SklO?=
 =?utf-7?B?cXgrLWhjb3FnNU9NRHFveVhSa0VQRE5xRkRhZ3Q1UU9kKy0yR0t4azZqY1M4?=
 =?utf-7?B?ekNRcjVaWWxKR2hsWDhDU2c1dTlSckwybUdCVk9yLzFjN0lDNnpyWVY2T09q?=
 =?utf-7?B?MzEyL1BzT0Z3VklDVmJ5ZFQ0UistN2MxR3J6TXlqdzNtc045YThaWDNJR01i?=
 =?utf-7?B?VzUrLWkwZUttb3RsdnppZWEyb2xZdkRISmxFUnVqSER0MVlndW1Za0pqd0hp?=
 =?utf-7?B?SjBZT2pUc1p1bTQ4UmlCUlcrLWtoejJDV3JOS0M2SHdtaVJ3UFpuMEN1SE5x?=
 =?utf-7?B?TDRiTnNrTHovUUJnWkZFaThndW5BVXdldkpnT3hBSHBNQlBYVlkrLVNodjUy?=
 =?utf-7?B?dWhJWFd6NnpBVkdnODAyVUNvQkplenVaRDZxYWppMzR5SWM0LystVldFamRS?=
 =?utf-7?B?bXY2Z2hLQ21ibjVrTzFhcFloNm1xYkt6R3lpdk5OSnN6ZXBVTjlNRVNFTlFh?=
 =?utf-7?B?NFBTQ2RwclgxOFlDQ1pDUHlSeEsxS1RFbTRVdDVWNk9hZDVJYldONCstbWwy?=
 =?utf-7?B?V01HcWJoM2V3dzFnY3czUVlCcnFQaGZJVnVFUWlUdkdvVDhEV1UrLVVOSGN3?=
 =?utf-7?B?QzJHNFY3TXJIWVY3c2hFR0lESWxnSXgrLXowcE5reXRnNDVMWnN3cWxCYTcv?=
 =?utf-7?B?cTRTYmZqSWlxOXNBbVJNOUprSjBEaC8wTWttcnB6S091dGxzazVldCstVTk=?=
 =?utf-7?B?Ky1ONkg0YTRmWndsUU85S3ovTWNKREJmMSstcHpEcHBlQjlXeDBQM0M4eWpS?=
 =?utf-7?B?d1B5MGxqNmZxQjg1alZIeWRaNFpJRE9Va1Jqekl1SWRsQlZwd3IxS0dJbG9m?=
 =?utf-7?B?M0dmWFhvSmhTZjYwSistUEZCT3ZPT1JIWistOCstelhqM1hLUTRwc0VDUm81?=
 =?utf-7?B?L2UvZGhReGtpWVpXZXhhQ0lKZmV1NlBnNXlJUGY2eWgyN01NNUpML3hBVTVz?=
 =?utf-7?B?L3dpYk9lZGdJaUZzWHlxWWU2VmttZFcwWmlDazBMR1czTmE2RkNuaUVUM2tx?=
 =?utf-7?B?NzBROE9iTDdwRTNZbE1xc2YrLVR5b1dyWi9lMXhCMDJEN1hibDJyTkpicGFs?=
 =?utf-7?B?QTcwU3AyRWdlaDhNSmR4clhqOXpDVTBCWjhobjk5N3lEV1FSVEpab2Q1ZSst?=
 =?utf-7?B?SHM5aXprdU5jRzNlUnZ1U3pvYkZadlZWT1Z4bk5mYnZJUEc1Tm9xMVRMa1Iy?=
 =?utf-7?B?NnU3MkRZUG9qaWErLWdMNmVkcWlkQ1dzdVVFYVFFS3lzL0d4bS9uNCstVXpT?=
 =?utf-7?B?M1pVMmZyMjczdjVlWnVWRnpVaUVqVW1HdEQxbFJFRFVsaldxUHB1UWdlbURI?=
 =?utf-7?B?akhxSFMzdDNjWm4yejVHNmVCRnhLSG52Ky0vaVhlSHZIbUdZQ1NCMXNBb21p?=
 =?utf-7?B?TTVsb1ZYZzlDa20=?=
Content-Type: text/plain; charset="utf-7"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: da494aca-c201-47cc-29a3-08dca1e61500
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 20:14:34.6296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKTNYBxkoSVEKlzvxrBNias6LdKE7WSoGfz3c9ymKmoh2b3OqjzZ147RihTT5LrNA4GIX+XXH6k1otf+ilxHOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB4814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_14,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407110140
X-Proofpoint-GUID: 9T00MJtDZgSNN3SCWQ398kvUdO6ymP1A
X-Proofpoint-ORIG-GUID: 9T00MJtDZgSNN3SCWQ398kvUdO6ymP1A
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110140

Thanks Luiz,
Maybe I don't understand. In bluez 5.39, prep+AF8-write+AF8-cb would send B=
T+AF8-ATT+AF8-OP+AF8-PREP+AF8-WRITE+AF8-RSP at the end of the function.  In=
 the new code, prep+AF8-write+AF8-complete+AF8-cb is supposed to send BT+AF=
8-ATT+AF8-OP+AF8-PREP+AF8-WRITE+AF8-RSP  but prep+AF8-write+AF8-complete+AF=
8-cb  is never called from gatt+AF8-db+AF8-attribute+AF8-write.  Who is sup=
posed to send the BT+AF8-ATT+AF8-OP+AF8-PREP+AF8-WRITE+AF8-RSP since prep+A=
F8-write+AF8-complete+AF8-cb  is not getting called?  With the patch, prep+=
AF8-write+AF8-complete+AF8-cb will get called.


From Bluez 5.39
static void prep+AF8-write+AF8-cb(uint8+AF8-t opcode, const void +ACo-pdu,
                                        uint16+AF8-t length, void +ACo-user=
+AF8-data)
+AHs-
        struct bt+AF8-gatt+AF8-server +ACo-server +AD0- user+AF8-data+ADs-
        uint16+AF8-t handle +AD0- 0+ADs-
        uint16+AF8-t offset+ADs-
        struct gatt+AF8-db+AF8-attribute +ACo-attr+ADs-
        uint8+AF8-t ecode+ADs-

        if (length +ADw- 4) +AHs-
                ecode +AD0- BT+AF8-ATT+AF8-ERROR+AF8-INVALID+AF8-PDU+ADs-
                goto error+ADs-
        +AH0-

        if (queue+AF8-length(server-+AD4-prep+AF8-queue) +AD4APQ- server-+A=
D4-max+AF8-prep+AF8-queue+AF8-len) +AHs-
                ecode +AD0- BT+AF8-ATT+AF8-ERROR+AF8-PREPARE+AF8-QUEUE+AF8-=
FULL+ADs-
                goto error+ADs-
        +AH0-

        handle +AD0- get+AF8-le16(pdu)+ADs-
        offset +AD0- get+AF8-le16(pdu +- 2)+ADs-

        attr +AD0- gatt+AF8-db+AF8-get+AF8-attribute(server-+AD4-db, handle=
)+ADs-
        if (+ACE-attr) +AHs-
                ecode +AD0- BT+AF8-ATT+AF8-ERROR+AF8-INVALID+AF8-HANDLE+ADs=
-
                goto error+ADs-
        +AH0-

        util+AF8-debug(server-+AD4-debug+AF8-callback, server-+AD4-debug+AF=
8-data,
                                +ACI-Prep Write Req - handle: 0x+ACU-04x+AC=
I-, handle)+ADs-

        ecode +AD0- check+AF8-permissions(server, attr, BT+AF8-ATT+AF8-PERM=
+AF8-WRITE +AHw-
                                                BT+AF8-ATT+AF8-PERM+AF8-WRI=
TE+AF8-AUTHEN +AHw-
                                                BT+AF8-ATT+AF8-PERM+AF8-WRI=
TE+AF8-ENCRYPT)+ADs-
        if (ecode)
                goto error+ADs-

        if (+ACE-store+AF8-prep+AF8-data(server, handle, offset, length - 4=
,
                                                +ACY-((uint8+AF8-t +ACo-) p=
du)+AFs-4+AF0-)) +AHs-
                ecode +AD0- BT+AF8-ATT+AF8-ERROR+AF8-INSUFFICIENT+AF8-RESOU=
RCES+ADs-
                goto error+ADs-
        +AH0-

        bt+AF8-att+AF8-send(server-+AD4-att, BT+AF8-ATT+AF8-OP+AF8-PREP+AF8=
-WRITE+AF8-RSP, pdu, length, NULL,     +ADw-------------------------- Respo=
nse is sent
                                                                NULL, NULL)=
+ADs-
        return+ADs-

error:
        bt+AF8-att+AF8-send+AF8-error+AF8-rsp(server-+AD4-att, opcode, hand=
le, ecode)+ADs-
+AH0-


---------------------------------------------------------------------------=
-----------------------------------------------------------
In Bluez master, the response is sent from prep+AF8-write+AF8-complete+AF8-=
cb but the call back is never called since gatt+AF8-db+AF8-attribute+AF8-wr=
ite returns True before func is executed which is the function pointer to p=
rep+AF8-write+AF8-complete+AF8-cb
static void prep+AF8-write+AF8-complete+AF8-cb(struct gatt+AF8-db+AF8-attri=
bute +ACo-attr, int err,
                                                                void +ACo-u=
ser+AF8-data)
+AHs-
        struct prep+AF8-write+AF8-complete+AF8-data +ACo-pwcd +AD0- user+AF=
8-data+ADs-
        uint16+AF8-t handle +AD0- 0+ADs-
        uint16+AF8-t offset+ADs-

        handle +AD0- get+AF8-le16(pwcd-+AD4-pdu)+ADs-

        if (err) +AHs-
                bt+AF8-att+AF8-chan+AF8-send+AF8-error+AF8-rsp(pwcd-+AD4-ch=
an, BT+AF8-ATT+AF8-OP+AF8-PREP+AF8-WRITE+AF8-REQ,
                                                                handle, err=
)+ADs-
                free(pwcd-+AD4-pdu)+ADs-
                free(pwcd)+ADs-

                return+ADs-
        +AH0-

        offset +AD0- get+AF8-le16(pwcd-+AD4-pdu +- 2)+ADs-

        if (+ACE-store+AF8-prep+AF8-data(pwcd-+AD4-server, handle, offset, =
pwcd-+AD4-length - 4,
                                                +ACY-((uint8+AF8-t +ACo-) p=
wcd-+AD4-pdu)+AFs-4+AF0-))
                bt+AF8-att+AF8-chan+AF8-send+AF8-error+AF8-rsp(pwcd-+AD4-ch=
an, BT+AF8-ATT+AF8-OP+AF8-PREP+AF8-WRITE+AF8-RSP,
                                        handle,
                                        BT+AF8-ATT+AF8-ERROR+AF8-INSUFFICIE=
NT+AF8-RESOURCES)+ADs-

        bt+AF8-att+AF8-chan+AF8-send+AF8-rsp(pwcd-+AD4-chan, BT+AF8-ATT+AF8=
-OP+AF8-PREP+AF8-WRITE+AF8-RSP, pwcd-+AD4-pdu,  +ADw--------------- Respons=
e is sent
                                                                pwcd-+AD4-l=
ength)+ADs-

        free(pwcd-+AD4-pdu)+ADs-
        free(pwcd)+ADs-
+AH0-




Internal Use - Confidential
-----Original Message-----
From: Luiz Augusto von Dentz +ADw-luiz.dentz+AEA-gmail.com+AD4-
Sent: Thursday, July 11, 2024 1:10 PM
To: Ramsay, Trey +ADw-Trey+AF8-Ramsay+AEA-Dell.com+AD4-
Cc: linux-bluetooth+AEA-vger.kernel.org
Subject: Re: +AFs-PATCH+AF0- ATT: Error (0x01) - Error: Unlikely error (14)=
 Prepare Write req (0x16)


+AFs-EXTERNAL EMAIL+AF0-

Hi Trey,

On Thu, Jul 11, 2024 at 1:17+IC8-PM Ramsay, Trey +ADw-Trey.Ramsay+AEA-dell.=
com+AD4- wrote:
+AD4-
+AD4- Hi Luiz,
+AD4- Correct, the request is timing out.  The problem is +ACI-prep+AF8-wri=
te+AF8-complete+AF8-cb+ACI- is never getting called after the +ACI-prep+AF8=
-write+AF8-cb+ACI- is called.  The prep+AF8-write+AF8-complete+AF8-cb is re=
sponsible for sending the response BT+AF8-ATT+AF8-OP+AF8-PREP+AF8-WRITE+AF8=
-RSP back.  The patch I provided fixes the code so that prep+AF8-write+AF8-=
complete+AF8-cb  will get called and the response is sent back.   Sorry, I =
had debugged this issue a quite a while ago using bluez 5.55 and 5.66 and n=
oticed the same issue in the master branch.  We have been using the patch a=
nd it has resolved the issue.

Well your patch is more of a workaround and in case the issue is really the=
 application setting 'authorize' flag the prepare write will need to be aut=
horized even if they are of 0 length, so it is a nack from my side. If you =
think the application is responding properly then the problem is somewhere =
else and in that case we probably need to debug the code path it is taking.

+AD4- Thanks,
+AD4- Trey
+AD4-
+AD4- -----Original Message-----
+AD4- From: Luiz Augusto von Dentz +ADw-luiz.dentz+AEA-gmail.com+AD4-
+AD4- Sent: Wednesday, July 10, 2024 4:14 PM
+AD4- To: Ramsay, Trey +ADw-Trey+AF8-Ramsay+AEA-Dell.com+AD4-
+AD4- Cc: linux-bluetooth+AEA-vger.kernel.org
+AD4- Subject: Re: +AFs-PATCH+AF0- ATT: Error (0x01) - Error: Unlikely erro=
r (14)
+AD4- Prepare Write req (0x16)
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- Hi Trey,
+AD4-
+AD4- On Wed, Jul 10, 2024 at 3:55+IC8-PM Ramsay, Trey +ADw-Trey.Ramsay+AEA=
-dell.com+AD4- wrote:
+AD4- +AD4-
+AD4- +AD4- Hi Luis,
+AD4- +AD4- It is a Prepare Write Request but prep+AF8-write+AF8-complete+A=
F8-cb is never getting called. In gatt+AF8-db+AF8-attribute+AF8-write, the =
prep+AF8-write+AF8-complete+AF8-cb function is not getting called since +AC=
I-attribe-+AD4-write+AF8-func+ACI- is not null and the function will return=
 +ACI-True+ACI-.  The prep+AF8-write+AF8-complete+AF8-cb is supposed to get=
 called after +ACI-goto done+ADsAIg- but it's not getting called.  The prep=
+AF8-write+AF8-complete+AF8-cb is assigned to +ACI-func+ACI-.    The patch =
checks to see if len is 0 and will goto done which will call prep+AF8-write=
+AF8-complete+AF8-cb.
+AD4-
+AD4- Well if it returns true then it should not return unlikely:
+AD4-
+AD4-     status +AD0- gatt+AF8-db+AF8-attribute+AF8-write(attr, offset, NU=
LL, 0,
+AD4-                         BT+AF8-ATT+AF8-OP+AF8-PREP+AF8-WRITE+AF8-REQ,
+AD4-                         server-+AD4-att,
+AD4-                         prep+AF8-write+AF8-complete+AF8-cb, pwcd)+ADs=
-
+AD4-
+AD4-     if (status)
+AD4-         return+ADs-
+AD4-
+AD4-     ecode +AD0- BT+AF8-ATT+AF8-ERROR+AF8-UNLIKELY+ADs-
+AD4-
+AD4- error:
+AD4-     bt+AF8-att+AF8-chan+AF8-send+AF8-error+AF8-rsp(chan, opcode, hand=
le, ecode)+ADs-
+AD4-
+AD4- +AD4-
+AD4- +AD4- +AD4- ACL data: handle 0 flags 0x01 dlen 3
+AD4- +AD4-     ATT: Prepare Write req (0x16)
+AD4- +AD4-       attr handle 0x0069, value offset 0x0000
+AD4- +AD4-       part attr value  0x80 0x02 0x00 0x01 0xaa 0xd3 0x81 0x51 =
0x54
+AD4- +AD4- 0x5b 0xea 0xaf 0x68 0x0d 0xeb 0xe6 0x11 0x2d 0x63 0xb1 0x8e 0xb=
d
+AD4- +AD4- 0xc4
+AD4- +AD4- 0x63 0x8f 0xf6 0xb6 0x10 0x63 0xb5 0x54 0x3f 0x36 0x19 0x41 0x5=
b
+AD4- +AD4- 0x25 0xcd 0xa7 0xe5 0x9d 0xc7 0x71 0x26 0x33 0x7c 0xe8 0x0e 0x6=
7
+AD4- +AD4- 0xd8 0x9a 0x0a 0xb5 0xe5 0x24 0x87 0x2d 0xcc 0x00 0xa9 0xc8 0xb=
8
+AD4- +AD4- 0x95 0x76 0x75 0x9f 0x79 0x1f 0x94 0xe4 0xd9 0xbe 0xab 0x22 0xa=
3
+AD4- +AD4- 0x33 0x18 0x28 0x57
+AD4- +AD4- 0x26 0xae 0x6d 0x0a 0x9b 0x63 0xeb 0x10 0xf3 0xb5 0xea 0x64 0x4=
a
+AD4- +AD4- 0x81
+AD4- +AD4- 0x55 0xe0 0xa9 0x43 0x8c 0x87 0xb4 0x32 0x1c 0x79 0xd6 0x34 0x9=
7
+AD4- +AD4- 0xff 0xae 0x71 0x1e 0x50 0x7c 0xb6 0x72 0x7b 0x49 0x44 0xef 0xf=
e
+AD4- +AD4- 0xe2 0x40
+AD4- +AD4- 0xc7 0x3e 0x5e 0x42 0x9b 0xca 0xa4 0x61 0x66 0x72 0x0a 0x1d 0x5=
c
+AD4- +AD4- 0xb0 0xdb 0xa1 0xbb 0xf7 0xb6 0x27 0xa0 0x67 0xde 0x69 0xd9 0x6=
7
+AD4- +AD4- 0xa7 0x09
+AD4- +AD4- 0x58 0x71 0x37 0x99 0x95 0x5c 0x5d 0x10 0x4d 0xed 0x2f 0xe2 0x8=
5
+AD4- +AD4- 0x6c
+AD4- +AD4- 0x03 0x60 0x80 0x67 0x25 0x1b 0x33 0x02 0x53 0xbe 0x67 0xdb 0xd=
4
+AD4- +AD4- 0x2a 0x9e 0x8d 0x82 0xe2 0x9d 0xc4 0x86 0x08 0x84 0x2c 0xbf 0xa=
5
+AD4- +AD4- 0xc5 0xd3
+AD4- +AD4- 0x99 0xf1 0x02 0x09 0x80 0x0c 0xc5 0xf9 0x99 0x06 0x20 0x01 0x7=
5
+AD4- +AD4- 0xdb 0x0c 0x11 0x81 0x87 0x04 0x4d 0xf0 0xcc 0xf7 0x27 0x85 0xc=
d
+AD4- +AD4- 0x22 0x84
+AD4- +AD4- 0x85 0x04 0xb3 0xa2 0xa9 0xcc 0xe9 0x27 0x8b 0x67 0x02 0x1b 0xe=
0
+AD4- +AD4- 0x8c
+AD4- +AD4- 0xd7 0x8f 0x51 0x3a 0xa6 0x0c 0x23 0xa0 0x09 0x2b 0x4c 0xb0 0x8=
0
+AD4- +AD4- 0x34
+AD4- +AD4- 0xf9 0x61 0xaa 0x72 0x90 0x3a 0x5e 0xb7 0x11 0xaf 0xc3 0xcd 0x7=
8
+AD4- +AD4- 0x4f
+AD4- +AD4- 0xb6 0x1b 0xbb 0xb4 0xb2 0x42 0x9f 0x87 0xad 0xf6 0xa1 0xae 0xd=
d
+AD4- +AD4- 0xde
+AD4- +AD4- 0x38 0x09 0x7a 0xc5 0x7c 0xbd 0x98 0x89 0xae 0x49 0x98 0xe7 0xa=
e
+AD4- +AD4- 0x92
+AD4- +AD4- 0x28 0x45 0x5a 0xbc 0x30 0x53 0xe5 0xc1 0x56 0xb3 0x9f 0x56 0x7=
b
+AD4- +AD4- 0xa1
+AD4- +AD4- 0x02 0xcd 0xc2 0x25 0x2a 0xb2 0xc5 0xc9 0x35 0xec 0xa7 0x26 0x7=
9
+AD4- +AD4- 0x97 0x2e 0x96 0x97 0x3e 0x5b 0x8f 0xc7 0x2f 0xa8 0x39 0x70 0xb=
1
+AD4- +AD4- 0x22 0x5b 0x2c 0x15 0x41 0xec 0x6b 0xc4 0x1e 0x2d 0xc0 0x47 0x7=
5
+AD4- +AD4- 0x42 0x01 0x40
+AD4- +AD4- 0xc5 0x17 0x69 0xf4 0x0a 0xcd 0x7e 0x62 0x25 0xec 0x1f 0x7c 0xa=
e
+AD4- +AD4- 0x7b
+AD4- +AD4- 0xf9 0x1e 0x9f 0x98 0xbd 0xc7 0xc3 0x44 0x4c 0xe2 0x0a 0x8c 0xb=
e
+AD4- +AD4- 0xeb 0x1e 0xae 0x7b 0xbc 0x49 0xfa 0x7d 0xa3 0xdf 0xb2 0xc0 0x6=
9
+AD4- +AD4- 0xf7 0x57 0x6b 0x6f 0xe7 0x2e 0x3c 0x90 0x0a 0x16 0xe8 0x03 0x0=
d
+AD4- +AD4- 0xf1 0x9c 0x4c
+AD4- +AD4- 0xa3 0x4b 0xcf 0x6d 0xc3 0x4a 0x69 0x25 0xc5 0xf6 0x9c 0x4b 0xb=
3
+AD4- +AD4- 0x77
+AD4- +AD4- 0x67 0x7b 0x00 0xbb 0x1f 0xcd 0x59 0xb0 0xe9 0xf6 0xbe 0xa3 0x4=
1
+AD4- +AD4- 0xd1 0x2c 0x1f 0x09 0x6b 0x4e 0x52 0x01 0x0c 0xe1 0x20 0x6c 0x7=
6
+AD4- +AD4- 0xfd 0xc9
+AD4- +AD4- 0xb9 0xb4 0xd8 0xdf 0xcb 0xac 0x77 0x65 0xcd 0x98 0xe9 0x66 0x6=
c
+AD4- +AD4- 0xc8 0x8f 0xfc 0xef 0x7e 0x48 0x9f 0xc8 0xd6 0x9c 0x72 0xac 0x4=
4
+AD4- +AD4- 0xa3 0x67
+AD4- +AD4- 0xa3 0x6a 0xe3 0xde 0x3a 0xd5 0x21 0x94 0x29 0x94 0x3d 0x7b 0x8=
8
+AD4- +AD4- 0x29
+AD4- +AD4- 0xc3 0xc2 0x7e 0x82 0x9d 0xe7 0x00 0x7c 0x96 0x28 0x1d 0x20 0xf=
8
+AD4- +AD4- 0x81
+AD4- +AD4- 0x02 0x7c 0xc2 0xb2 0xfa 0x43 0x90 0x6e
+AD4-
+AD4- That doesn't seem like a zero length, what BlueZ version is this btw?
+AD4-
+AD4- +AD4- +ADw- ACL data: handle 0 flags 0x00 dlen 9
+AD4- +AD4-     ATT: Error (0x01)
+AD4- +AD4-       Error: Unlikely error (14)
+AD4- +AD4-       Prepare Write req (0x16) on handle 0x0069
+AD4-
+AD4- Check what time does this error is generated, since this well be:
+AD4-
+AD4- static bool write+AF8-timeout(void +ACo-user+AF8-data) +AHs-
+AD4-     struct pending+AF8-write +ACo-p +AD0- user+AF8-data+ADs-
+AD4-
+AD4-     p-+AD4-timeout+AF8-id +AD0- 0+ADs-
+AD4-
+AD4-     queue+AF8-remove(p-+AD4-attrib-+AD4-pending+AF8-writes, p)+ADs-
+AD4-
+AD4-     pending+AF8-write+AF8-result(p, -ETIMEDOUT)+ADs-
+AD4-
+AD4-     return false+ADs-
+AD4- +AH0-
+AD4-
+AD4- The -ETIMEOUT would be converted to:
+AD4-
+AD4- static uint8+AF8-t att+AF8-ecode+AF8-from+AF8-error(int err) +AHs-
+AD4-     /+ACo-
+AD4-      +ACo- If the error fits in a single byte, treat it as an ATT pro=
tocol
+AD4-      +ACo- error as is. Since +ACI-0+ACI- is not a valid ATT protocol=
 error code, we map
+AD4-      +ACo- that to UNLIKELY below.
+AD4-      +ACo-/
+AD4-     if (err +AD4- 0 +ACYAJg- err +ADw- UINT8+AF8-MAX)
+AD4-         return err+ADs-
+AD4-
+AD4-     /+ACo-
+AD4-      +ACo- Since we allow UNIX errnos, map them to appropriate ATT pr=
otocol
+AD4-      +ACo- and +ACI-Common Profile and Service+ACI- error codes.
+AD4-      +ACo-/
+AD4-     switch (err) +AHs-
+AD4-     case -ENOENT:
+AD4-         return BT+AF8-ATT+AF8-ERROR+AF8-INVALID+AF8-HANDLE+ADs-
+AD4-     case -ENOMEM:
+AD4-         return BT+AF8-ATT+AF8-ERROR+AF8-INSUFFICIENT+AF8-RESOURCES+AD=
s-
+AD4-     case -EALREADY:
+AD4-         return BT+AF8-ERROR+AF8-ALREADY+AF8-IN+AF8-PROGRESS+ADs-
+AD4-     case -EOVERFLOW:
+AD4-         return BT+AF8-ERROR+AF8-OUT+AF8-OF+AF8-RANGE+ADs-
+AD4-     +AH0-
+AD4-
+AD4-     return BT+AF8-ATT+AF8-ERROR+AF8-UNLIKELY+ADs-
+AD4- +AH0-
+AD4-
+AD4- So on write+AF8-timeout it would also generate the unlikely error.
+AD4-
+AD4- Note that normally prepare write don't need authorization, but perhap=
s you have an application setting 'authorize':
+AD4-
+AD4- https://urldefense.com/v3/+AF8AXw-https://github.com/bluez/bluez/blob=
/master/doc/org.bluez.GattCharacteristic.rst+ACo-arraystring-flags-read-onl=
y+AF8AXwA7-Iw+ACEAIQ-LpKI+ACE-mOAXmul0EbN+AF8-7I2R6edizAu4TW4H0BMt5s6EDMhpj=
23Ap8xFtV5BRjMJtpqVFcVIZQnbtBdGNs0UyAwX178+ACQ- +AFs-github+AFs-.+AF0-com+A=
F0-, which means the following code would execute:
+AD4-
+AD4-     if (opcode +AD0APQ- BT+AF8-ATT+AF8-OP+AF8-PREP+AF8-WRITE+AF8-REQ)=
 +AHs-
+AD4-         if (+ACE-btd+AF8-device+AF8-is+AF8-trusted(device) +ACYAJg- +=
ACE-desc-+AD4-prep+AF8-authorized +ACYAJg-
+AD4-                         desc-+AD4-req+AF8-prep+AF8-authorization)
+AD4-             send+AF8-write(att, attrib, desc-+AD4-proxy,
+AD4-                     desc-+AD4-pending+AF8-writes, id, value, len,
+AD4-                     offset, false, true)+ADs-
+AD4-         else
+AD4-             gatt+AF8-db+AF8-attribute+AF8-write+AF8-result(attrib, id=
, 0)+ADs-
+AD4-
+AD4-         return+ADs-
+AD4-     +AH0-
+AD4-
+AD4- You can also try adding passing -t -p debug to btmon so it logs the d=
ebug messages from bluetoothd and include timing information.
+AD4-
+AD4- +AD4- +AD4- HCI Event: Number of Completed Packets (0x13) plen 5
+AD4- +AD4-     handle 0 packets 1
+AD4- +AD4- +AD4- ACL data: handle 0 flags 0x02 dlen 6
+AD4- +AD4-     ATT: Exec Write req (0x18)
+AD4- +AD4-       cancel all prepared writes (0x00) +ADw- ACL data: handle =
0 flags
+AD4- +AD4- 0x00 dlen 5
+AD4- +AD4-     ATT: Exec Write resp (0x19)
+AD4- +AD4- +AD4- HCI Event: Number of Completed Packets (0x13) plen 5
+AD4- +AD4-     handle 0 packets 1
+AD4- +AD4-
+AD4- +AD4- -----Original Message-----
+AD4- +AD4- From: Luiz Augusto von Dentz +ADw-luiz.dentz+AEA-gmail.com+AD4-
+AD4- +AD4- Sent: Tuesday, July 9, 2024 3:34 PM
+AD4- +AD4- To: Ramsay, Trey +ADw-Trey+AF8-Ramsay+AEA-Dell.com+AD4-
+AD4- +AD4- Cc: linux-bluetooth+AEA-vger.kernel.org
+AD4- +AD4- Subject: Re: +AFs-PATCH+AF0- ATT: Error (0x01) - Error: Unlikel=
y error (14)
+AD4- +AD4- Prepare Write req (0x16)
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4-
+AD4- +AD4- Hi Trey,
+AD4- +AD4-
+AD4- +AD4- On Tue, Jul 9, 2024 at 1:34+IC8-PM Ramsay, Trey +ADw-Trey.Ramsa=
y+AEA-dell.com+AD4- wrote:
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- Bluez Maintainers,
+AD4- +AD4- +AD4- Here is a fix for attribute writes not working in
+AD4- +AD4- +AD4- src/shared/gatt-db.c. The prep+AF8-write+AF8-complete+AF8=
-cb was not getting
+AD4- +AD4- +AD4- called. The attrib-+AD4-write+AF8-func code block should =
not be called
+AD4- +AD4- +AD4- when len is 0
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- commit 5a9baa10d4fde7ca8ab88ecd68e17671c33cb587 (HEAD -+A=
D4- gat-db,
+AD4- +AD4- +AD4- master)
+AD4- +AD4- +AD4- Author: Trey+AF8-Ramsay +ADw-trey+AF8-ramsay+AEA-dell.com=
+AD4-
+AD4- +AD4- +AD4- Date:   Fri May 31 15:39:27 2024 -0500
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-     shared/gatt-db: Prepare Write req error BT+AF8-ATT+AF=
8-ERROR+AF8-UNLIKELY
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-     Fixes Prepare Write req error: BT+AF8-ATT+AF8-ERROR+A=
F8-UNLIKELY
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-         ATT: Error (0x01)
+AD4- +AD4- +AD4-           Error: Unlikely error (14)
+AD4- +AD4- +AD4-           Prepare Write req (0x16) on handle 0x0069
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-     The prep+AF8-write+AF8-complete+AF8-cb was not gettin=
g called
+AD4- +AD4- +AD4-     The attrib-+AD4-write+AF8-func code block does not ne=
ed to be called
+AD4- +AD4- +AD4- when len is 0
+AD4- +AD4-
+AD4- +AD4- This doesn't sound quite right, 0 length still needs to be pass=
ed to the attribute to confirm since we don't know if it could be a procedu=
re or not. Can you explain what attribute is being written and if it could =
be due to the application not responding and the procedure timing out (e.g.=
 write+AF8-timeout is called?), perhaps if you can paste a btmon trace as w=
ell that could help checking what attribute it is trying to use prepare wri=
te.
+AD4- +AD4-
+AD4- +AD4- +AD4- diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c =
index
+AD4- +AD4- +AD4- 2c8e7d31e..678aef4cf 100644
+AD4- +AD4- +AD4- --- a/src/shared/gatt-db.c
+AD4- +AD4- +AD4- +-+-+- b/src/shared/gatt-db.c
+AD4- +AD4- +AD4- +AEAAQA- -2127,6 +-2127,10 +AEAAQA- bool gatt+AF8-db+AF8-=
attribute+AF8-write(struct gatt+AF8-db+AF8-attribute +ACo-attrib, uint16+AF=
8-t offset,
+AD4- +AD4- +AD4-      if (+ACE-attrib +AHwAfA- (+ACE-func +ACYAJg- attrib-=
+AD4-write+AF8-func))
+AD4- +AD4- +AD4-          return false+ADs-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +-    /+ACo- Nothing to write just skip +ACo-/
+AD4- +AD4- +AD4- +-    if (len +AD0APQ- 0)
+AD4- +AD4- +AD4- +-        goto done+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4-      if (attrib-+AD4-write+AF8-func) +AHs-
+AD4- +AD4- +AD4-          struct pending+AF8-write +ACo-p+ADs-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AEAAQA- -2162,10 +-2166,6 +AEAAQA- bool gatt+AF8-db+AF8-=
attribute+AF8-write(struct gatt+AF8-db+AF8-attribute +ACo-attrib, uint16+AF=
8-t offset,
+AD4- +AD4- +AD4-          return true+ADs-
+AD4- +AD4- +AD4-      +AH0-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- -    /+ACo- Nothing to write just skip +ACo-/
+AD4- +AD4- +AD4- -    if (len +AD0APQ- 0)
+AD4- +AD4- +AD4- -        goto done+ADs-
+AD4- +AD4- +AD4- -
+AD4- +AD4- +AD4-      /+ACo- For values stored in db allocate on demand +A=
Co-/
+AD4- +AD4- +AD4-      if (+ACE-attrib-+AD4-value +AHwAfA- offset +AD4APQ- =
attrib-+AD4-value+AF8-len +AHwAfA-
+AD4- +AD4- +AD4-                  len +AD4- (unsigned) (attrib-+AD4-value+=
AF8-len - offset)) +AHs-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- -----Original Message-----
+AD4- +AD4- +AD4- From: Ramsay, Trey +ADw-Trey.Ramsay+AEA-dell.com+AD4-
+AD4- +AD4- +AD4- Sent: Thursday, June 20, 2024 1:58 PM
+AD4- +AD4- +AD4- To: linux-bluetooth+AEA-vger.kernel.org
+AD4- +AD4- +AD4- Subject: +AFs-PATCH+AF0- ATT: Error (0x01) - Error: Unlik=
ely error (14)
+AD4- +AD4- +AD4- Prepare Write req (0x16)
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- Bluez Maintainers
+AD4- +AD4- +AD4- Here is a fix for attribute writes not working in
+AD4- +AD4- +AD4- src/shared/gatt-db.c
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- https://urldefense.com/v3/+AF8AXw-https://github.com/tram=
say/bluez-trams
+AD4- +AD4- +AD4- ay
+AD4- +AD4- +AD4- /c
+AD4- +AD4- +AD4- ommit/246bc960629dff34e744c728f048e9f50f1a005d+AF8AXwA7AC=
EAIQ-LpKI+ACE-jkJYamzU8b
+AD4- +AD4- +AD4- Od
+AD4- +AD4- +AD4- d1
+AD4- +AD4- +AD4- qt-sWpj6gy1YwS30UyamHLUJj9Uy0UecrB6QxvCdSWFAUH7Dvq2wVJqu1=
C5jjoX5am
+AD4- +AD4- +AD4- yw
+AD4- +AD4- +AD4- JH
+AD4- +AD4- +AD4- +ACQ- +AFs-github+AFs-.+AF0-com+AF0-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- shared/gatt-db: Prepare Write req error BT+AF8-ATT+AF8-ER=
ROR+AF8-UNLIKELY
+AD4- +AD4- +AD4- Fixes Prepare Write req error: BT+AF8-ATT+AF8-ERROR+AF8-U=
NLIKELY
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-     ATT: Error (0x01)
+AD4- +AD4- +AD4-       Error: Unlikely error (14)
+AD4- +AD4- +AD4-       Prepare Write req (0x16) on handle 0x0069
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- The prep+AF8-write+AF8-complete+AF8-cb was not getting ca=
lled The
+AD4- +AD4- +AD4- attrib-+AD4-write+AF8-func code block should not be calle=
d when len is 0
+AD4- +AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- --
+AD4- +AD4- Luiz Augusto von Dentz
+AD4- +AD4-
+AD4-
+AD4-
+AD4- --
+AD4- Luiz Augusto von Dentz



--
Luiz Augusto von Dentz
