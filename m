Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FB7166F0D
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871307; cv=fail; b=WVl9SI+eMT4Rc3kgw5GjIMq84KcKuaZJhxlI5BC/YfHnG505110D6Kip7X81I7i4fZHnQqlKBM9Ekywb/9/A7IYtRygMgjv3qGeQWdgUcMJnsI/7mL2S9KK7r3NIC60D2Jl2IDaU/jOdMjNpdSYvNzgOG2poPA8Sm1qpzghv6ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871307; c=relaxed/simple;
	bh=JEcn2U4qPl5JG1ffwF0lRYy4tHKnOYGbZ4NHQhFANsI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QUmmQFt5mnWhgmVbO3yaSmWCLzuk7vlZWD5z8BB7aFoOPkRQKqtFiE4RroQgPdYL7F20dhmpoXlLq0ZB3Cge1G4tKAtaYiRuHgIz48zAIsoAemshJdi2mureXHvnLox4QbpxRsB2mSABnozZtk9jJJjbhyBdk9k4rwrTmKwilHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Imcq2KiH; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Imcq2KiH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BysfMGFQPnql2WLHNFBcsNb0SqtGXkmhoYb/0Q4KYvdCmrXlkJgEB8L/x/2I7qzW6/zCT0waPFpR/9hjPVFlWOThuQFe5DXrIIISdFefV8aMJ2GyAC0GXKYNAmW1lS0pUqGMWb3LY0VHMUKNr6C7M0E07rOCDyy2gkUxw/FTa6D6t+I74Iq2BAfOk0LqnJu3AIoiV6ilHJKM1/l4EDxSwD1l1aGqEQaTg1EcrD1su4N7gvshYwAgQnufKrqAb2bBTJ6Z5STX4osLjES55XIraOjqEBHDpfKMZWK7pDcYnfRAdSS6kIcLeqgrY+dy16U2JrevX6MttC0oG8V0ZZE5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEcn2U4qPl5JG1ffwF0lRYy4tHKnOYGbZ4NHQhFANsI=;
 b=sX/hLfNGQrLIqaZh2bFZajdEnfJQlAcCjYTcsG0zOI0SwYyPPnC8EsL0YNHOHXHO9Lbu7uVxrZI28mbK9PEpiezlR7agOTA7Z/+5YyuCcEuFUSaEbi3Y8sCk6WjaU+AKge3dPFV5VTvEGKbF/9fZuy3xBdo559Dqh8ousUYI8W/zhHA5/EwVzyKNQyJEJanOXVv/j0DIvgPvAb/sLU6Ypf7Yx55Smv+f5SIB7JOBVcnAgc3hxvPDtFGPLEJEw9Fhv+cfGo/+/P5FEoy6w01E9R7mOvN9A4rpEG/GXwLP0SLprEdwd6hKYfnymCf7u8fCHVgXGzP+fB2v7gzIpsAA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEcn2U4qPl5JG1ffwF0lRYy4tHKnOYGbZ4NHQhFANsI=;
 b=Imcq2KiH486M8/lWme2HjdCdNxeNtWddQV2amLsbMg7SG3JJzNAKodU5sljkzWk19ypM0Bvore2GofvF2Z32TTmdfcpWCJeyHA8r/bOMacmcEqdlOehMZCPu5w70QJ/PabjXxtO4S9AA2x5Tzn1G/8VtpWLfGSslDzgHz3lJhgw=
Received: from GVXPR02MB8256.eurprd02.prod.outlook.com (2603:10a6:150:6e::14)
 by DB9PR02MB6537.eurprd02.prod.outlook.com (2603:10a6:10:21b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 15:21:40 +0000
Received: from GVXPR02MB8256.eurprd02.prod.outlook.com
 ([fe80::6044:5761:b269:8f3f]) by GVXPR02MB8256.eurprd02.prod.outlook.com
 ([fe80::6044:5761:b269:8f3f%7]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 15:21:40 +0000
From: Alexander Ganslandt <Alexander.Ganslandt@axis.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: GATT characteristic for only LE or BR/EDR
Thread-Topic: GATT characteristic for only LE or BR/EDR
Thread-Index: AQHa5zMlTF82vRT27kyi/MYNVwq85bIYobAAgAACKgCAACPArw==
Date: Mon, 5 Aug 2024 15:21:40 +0000
Message-ID:
 <GVXPR02MB8256A0C28CB1DECA4A299D679CBE2@GVXPR02MB8256.eurprd02.prod.outlook.com>
References:
 <GVXPR02MB8256E67B738C97EC57D1FA0F9CBE2@GVXPR02MB8256.eurprd02.prod.outlook.com>
 <CABBYNZ+HwmhFhUZsSnhW1KU-cXQhHKGt3xJeCX1sxt6xyBBnHw@mail.gmail.com>
 <CABBYNZLCDU+vQFzdYKoUCKvuWMGUPbjxoHJYCVsE3J1=1i3iww@mail.gmail.com>
In-Reply-To:
 <CABBYNZLCDU+vQFzdYKoUCKvuWMGUPbjxoHJYCVsE3J1=1i3iww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXPR02MB8256:EE_|DB9PR02MB6537:EE_
x-ms-office365-filtering-correlation-id: 641e5e75-e647-4a03-71a5-08dcb5624e30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVBiM0lVbExCOXAzUHpmVkVQcnVwc1BiRERGYUZ1R2dDVURBWHNTRlUxWXcy?=
 =?utf-8?B?YzhXS2R1T2FCR01NczRtM0VmeXdJMkE2RThHdzd2TmwySGdoaEgxdW1wRi9l?=
 =?utf-8?B?Uy9weU00ZFJhUC9tU1l2T3dEd1hlZlBnZURScFlTRFg0RmMxUWJmNVlOVko2?=
 =?utf-8?B?MU4zVEtnWnBZZXNQZk40aVdWNmR1ZE5VaEZJVVFQVlJhWGFJbU5KZFVQanY5?=
 =?utf-8?B?Z1BSS0krT3lWVm4zaWsybEFLSVRRckN3M0dlNy9yeCtPOFBlRkdtd3lsa0Rn?=
 =?utf-8?B?VzhwR2pqWW9pQjRUYThMWm5ZWmJ0bGJXSEIvdTlqcGxxL1dBOTNhb01FZ2pi?=
 =?utf-8?B?TWNWaEs3dGlRaEFxS1c2QWlqOS95NjJ5QmtWb2ZPaVNwZlU3NkF0SHRjUWZD?=
 =?utf-8?B?djFZcHpHTGJ3d3pjaDk3V2V2WHEyOVZIWmFsWDJudjhhc20rQTBGeTZjNTJw?=
 =?utf-8?B?OFh6QWtnd1RmMHMyby9pUkUrRDEyenRVQ3NBRmtXSEFZbFFhcXA1ZlkySFdq?=
 =?utf-8?B?NG8yaE5mTU9PT0hsWTd6LytUTUZ2YkhaK2IyVWwxb0llM1BGOFF6QVoyOUND?=
 =?utf-8?B?bjdZaXJLbGErY0VOZmF1bzd2VFA1aTNBdy96WFlpdlMwenFpVy9lOUllRmlE?=
 =?utf-8?B?M2dRb3pVSlBPbCsxbkNxbFdOT1R1cEFGaHJsMVR6WG9iaXBiZEEwUitJZ2Iv?=
 =?utf-8?B?UTBEa1hyd1hLa01CWWlraUJMaS9uLzFPWTNUTURHOWdySHpVVXRiUWt5aXdt?=
 =?utf-8?B?eUpwblBEYS9RaFlYN1JjU0VKWjJYdFpMOWdVK0lTek8xdjZVSlZpUEd3YVJB?=
 =?utf-8?B?VjZjYXFOdjc3QzNDWnRsZmJqVlpYb0U0TGFaOVdqQ1pnc29QcVQ3S3RkU1NK?=
 =?utf-8?B?OENNMDcwNEdva28zMG5udWExdFlLa0tTanhaNnNBc3RvTU1GR1hZVk9ZQkdz?=
 =?utf-8?B?RThMcjZ5QzlqeTd0dVE5WDRYT2xVb0g0SVo1VTRuUDdJZUlqMjBRVmZBY3Bv?=
 =?utf-8?B?WndQTTF4VGZNUTByYTZyVzhtS0tvOHE4RDVRcVdLMmQxaUJacDhyQUJSOUs3?=
 =?utf-8?B?RytPMHZnb1Q4WkNMQmI3NnVRNlhSQkdyQkpjRUZBZ2FBc3c0eWUxMFBBbS9l?=
 =?utf-8?B?VUl3Y0RacmdRaitXNXpmSXNvM3V1d245YlRyM2dtSWJNUUhETVRJZWRyOUZv?=
 =?utf-8?B?YVh2RWw1U21iVGEyZ0ZCN0x2eE9xZ0hHbmt5MG5RM3pKaUxoNThUbVppNzQ4?=
 =?utf-8?B?OGZITVRVNy8vYTd3a0RkMndzaHJrTjFMWHJwSmFBaHlMQXFVbklHcjNwa0ta?=
 =?utf-8?B?OUp0SHR6UTFkcmNzUkdsa1F2WS9VSHl2enVPRlE3UTdPRWNuMGxNUHhmWlRu?=
 =?utf-8?B?Zk9DQ3lZSEVoVXdnN2pJQUR1ZzNFNGZlM29tTkVGTjd6MFZQeHJ1RlhSNmha?=
 =?utf-8?B?TGNvSTAvY0Z6eSt1RU4rTEFocGl1cjYxd0dWWEdhMUNQQzhkTENGSmRWbmgz?=
 =?utf-8?B?WWM2dThrUTRxUURINGMxUFZVZ2tnWjRsTGQ1L09xZU9zakYxcEZmdzBhVWZo?=
 =?utf-8?B?UjJlYVY0ZnJpcjUwSVdjYjJESURPdGRqelZaQ0FqYk9KSys1STlNRjN5d1Ju?=
 =?utf-8?B?c1l2YklqNllsL1N2U3JGeE5GWjc5Z2kwZlgwN0Q5NG52RFptVXZXdUNiZFhC?=
 =?utf-8?B?T1JzRno1R0Qramk0dWpzaElOQ0dMWXJ6SDcwOUovdTV5UmZkbmcyWFdtdVBZ?=
 =?utf-8?B?WWJvVU1XRmw0cGFETHVIT3REMS9wMTg1VnlxMlJUbldOS0hmdis4L2hWR3Rz?=
 =?utf-8?Q?hYHMa8x+q4IlMfNhaKPfRaQOhVjyccorJubIU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR02MB8256.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXZiNmYwTGZsWW9LUjJkMFVhQ3drWS9iMGF2cWxobFhtcnp3bndNUlNjbHRi?=
 =?utf-8?B?K3NQRkdUelg2aW03aGlRS1NuY3pNQkIvZWU5czZKUTVsMVBCb21UOG9hK1lp?=
 =?utf-8?B?cE5ZQkFzcVg5ekkxZmFJV3NIbi9pWUF4NTdRVzBrTE4yaGZhdWIrTDFBRG1q?=
 =?utf-8?B?WEtSa05mMGo0Zm1qb2xUeElCL2JHRWl4MlViakRSaXFRVm1wSktmcG0ydHRU?=
 =?utf-8?B?VFMwQW1OQ3VDUEgyMFJHRWdkV3c0bHphS0pGK2cwU1YrMVdQNXJFVHBPaXRs?=
 =?utf-8?B?OW11QUpEdFp1U2xVUjN0dnZQMVFLTFpndkl6NkRIb2lFaXJHcGcyVnFGZmxa?=
 =?utf-8?B?YzgzT3RwOGdXaXYrMWpCRUxBeTczSWF2TUx0UzhIYzBDWkJVbmZFaVo2WUlv?=
 =?utf-8?B?QTN2UEErdGR0cWkvS1BYY2dYbnJDeTlDT1NmNTUxQ0grVitNemtBazFBSk1p?=
 =?utf-8?B?b3YxVW5GeHBKVkswNUFsNUZ3a3kwL1RjOGhjbUVER3YzUmJHeXJwMmw5TTlv?=
 =?utf-8?B?b0lqdlBnUmY4SnJVYlYwSUwxL2dZV29JQzdJNWpLdW5aMkxTNkYxSDFULzBO?=
 =?utf-8?B?UDJ1d1BFV1RZR0JWT1Z4UUhFSlFJTFZGUUJUdmg1NFZkN2h0ZkcvdzV5K2ZM?=
 =?utf-8?B?c3NaS0ZBU29jWnBWYTRvclJZQlRTMnNIM0ZVN0NZdis1Z2ptVlY1YTZwZGhB?=
 =?utf-8?B?NDFnRWx3WnpIcWJ6T013QllYUitNbmlNZXovQkNBaCtMMDZOaVVmUG50b09I?=
 =?utf-8?B?dWUwOEl1VVJYMkpzOTZuQThCV2x2KzRwcEQ4M29MWlJveTdVeDhRZDE1czJT?=
 =?utf-8?B?TlhQUnE2MUZTZEdhdDd1blFCY1I5ZjdiNWFGUWxjYkhQSHpaYzE1RFRYVVlW?=
 =?utf-8?B?L3pXRG9RWVI3Vm45VUcyWW82THBVMTFya05RdFlXdW00SGd1b1JWN3BRR0NN?=
 =?utf-8?B?SGxHWkxaZkNXSVZhNnVEMVBnVXFlRUpVYmI1WmFVaDFKMHR6WHdiL1B3SDhj?=
 =?utf-8?B?QlpCUzBhaGQweDZ5ZW5TVXR3c043QmtXRHkwMSs2ZzZ3V0dPQnpiV1JmNXJU?=
 =?utf-8?B?N3hGRU9ZemJSQk1hNG5YNjQweTFXSkRyNlBJZXV1MVhNQVNBVmxJNmp3Mm1r?=
 =?utf-8?B?eFdtQ3FqdkFoQ29XTnBOTWZqNS8wMDh1OXNtaUorK0NjVmVWaXRtQ2UvNXBH?=
 =?utf-8?B?V2tKUnNIajBOYXV0TkZHZS9KSUZZRUYrcEJFUFZaYnJZOUt6cTZQZ29CQjNv?=
 =?utf-8?B?QTIvMzlZd295c0dJUzhsTis1clJWSTRCbmplUERYTzB5eCtlbzNiVlFUOFdN?=
 =?utf-8?B?RytlT2laTFUzakxiSTVMSTNaYTJMZklmK29rTEliOGRLVXRrVm5CVndFcm0z?=
 =?utf-8?B?T2l1MGpIYUwweDFTVXlDa1hHZnlBbHNOTWdYNG9VRXVPeTltMFQxZFpaeFM2?=
 =?utf-8?B?cEpxcGg1aHoxRHloNGtvNEVqWHRKTVZ5cWlPSkxPRTJLUWJOVVBFamlFOW1H?=
 =?utf-8?B?dUFxRHp1ZVhva3NQakNmSlFMY2NNQmUrcW8vSlBseTNtUVRzTXRMUENjcHBu?=
 =?utf-8?B?VGVMN0tETTNOaE44UUdNQ2VIVXN4YjhyVm5vL1lGdEV0OG53bWI2TVdBbDJk?=
 =?utf-8?B?WFFsRW9UaWs0eXFvb1c2OW5wbEQ5alFndnROTU1NL0oramRhOS93cGZKZnNl?=
 =?utf-8?B?TmxVakdZYWlWZERXV0tVRk5KMTZZSnhXOWhUR3JpbzJtQ09zSXozcXJJYUJw?=
 =?utf-8?B?YzVteVNvQUx3ek1lNUlMRmRFQU5qZys0MTk1Qy96bnd5YjhtYTBMc3hLbkQ2?=
 =?utf-8?B?ajZSWW02QVVIMjhCelBCV0IvZnd5UUJKbzFhdzk1ZURCOXN3WVlDSVFLVWx6?=
 =?utf-8?B?Q1RtNWwvR3hJeTYzdHYxK2lPbkVVQit2NEJSejlJUHdyQW9HYVZ1aUQ4clE1?=
 =?utf-8?B?bWRQYjRnTnZWbC93cDdINUpldkU1OWVjR29FdDNBN2tLRnlWdzFoM3Zzeldh?=
 =?utf-8?B?aTJKekY5YUxJaVBITjJUTklHWTQ3Yk1BSXhYKzMwbkRGVkhtM2pKb3kvZEFZ?=
 =?utf-8?B?YS9oVlRnT1gxK0JENXdDeFZRMlhjeGlCOTIyVzNJWlR0QTZINWQrcTBtRjQ0?=
 =?utf-8?Q?C3lU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXPR02MB8256.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641e5e75-e647-4a03-71a5-08dcb5624e30
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 15:21:40.2870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSF8t/UaRTbJXxNtqKx+vp/yCHsVod+FopVDPUjCapWZl/XRS4WtE2gJZZ71r+vmhpmdr+l8Av6Ie/opf8UOPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6537

SGkgTHVpeiwKCk9uIE1vbiwgQXVnIDUsIDIwMjQgYXQgMTU6MTIgTHVpeiBBdWd1c3RvIHZvbiBE
ZW50ego8bHVpei5kZW50ekBnbWFpbC5jb20+IHdyb3RlOgo+IEhpIEFsZXhhbmRlciwKPgo+IE9u
IE1vbiwgQXVnIDUsIDIwMjQgYXQgOTowNOKAr0FNIEx1aXogQXVndXN0byB2b24gRGVudHoKPiA8
bHVpei5kZW50ekBnbWFpbC5jb20+IHdyb3RlOgo+ID4KPiA+IEhpIEFsZXhhbmRlciwKPiA+Cj4g
PiBPbiBNb24sIEF1ZyA1LCAyMDI0IGF0IDg6MzHigK9BTSBBbGV4YW5kZXIgR2Fuc2xhbmR0Cj4g
PiA8QWxleGFuZGVyLkdhbnNsYW5kdEBheGlzLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IEhlbGxv
IQo+ID4gPgo+ID4gPiBJIGZvdW5kIGEgcHJldmlvdXMgZGlzY3Vzc2lvbiBhYm91dCB0aGlzIGhl
cmU6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC81OUNERUJERi4zMDkwMjAwQGRpZ2kuY29t
L3QvLCBidXQgdGhlcmUgd2FzIG5vIGNvbmNsdXNpb24uIE5vdyBJJ20gaGF2aW5nIHRoZSBzYW1l
IGlzc3VlIDcgeWVhcnMgbGF0ZXIgOikKPiA+ID4KPiA+ID4gSSdtIHRyeWluZyB0byBwYXNzIEJU
IFNJRyB0ZXN0cyBidXQgZmFpbCBvbiB0d28gdGVzdCBjYXNlczogR0FUVC9TUi9HQVIvQkktMzQt
QyBhbmQgR0FUVC9TUi9HQVIvQkktMzUtQy4gVG8gbXkgdW5kZXJzdGFuZGluZywgaW4gb3JkZXIg
dG8gcGFzcyB0aGVzZSB0ZXN0cywgeW91IG5lZWQgdG8gcmVnaXN0ZXIgYSBHQVRUIGNoYXJhY3Rl
cmlzdGljIHRoYXQgaXMgcmVhZGFibGUgb25seSB0aHJvdWdoIExFIG9yIEJSL0VEUiwgYnV0IG5v
dCBib3RoIGF0IHRoZSBzYW1lIHRpbWUuIEhvd2V2ZXIsIHdoZW4gSSByZWdpc3RlciBhIHNlcnZp
Y2UrY2hhcmFjdGVyaXN0aWMgdGhyb3VnaCBibHVldG9vdGhjdGwsIGl0IGlzIGF1dG9tYXRpY2Fs
bHkgcmVnaXN0ZXJlZCBmb3IgYm90aCBMRSBhbmQgQlIvRURSLiBUbyB2ZXJpZnkgdGhpcywgSSB1
c2UgZ2F0dHRvb2wgd2l0aCBhbmQgd2l0aG91dCAiLXAgMzEiIHRvIGNvbm5lY3Qgb3ZlciBCUi9F
RFIgYW5kIExFIHJlc3BlY3RpdmVseSwgYW5kIHRoZSBjaGFyYWN0ZXJpc3RpYyBzaG93cyB1cCBp
biBib3RoLiBCYXNlZCBvbiB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbiwgYW5kIGJhc2VkIG9uIHJl
YWRpbmcgdGhlIEJsdWVaIEFQSSwgdGhlcmUgZG9lc24ndCBzZWVtIHRvIGJlIGEgd2F5IHRvIG9u
bHkgc3VwcG9ydCBPTkUgdHJhbnNwb3J0IGZvciBhIGNoYXJhY3RlcmlzdGljPyBJcyB0aGlzIGNv
bmNsdXNpb24gY29ycmVjdD8KPiA+Cj4gPiBZb3UgY2FuIGRldGVjdCB3aGF0IGJlYXJlciBpdCBp
cyBjb25uZWN0ZWQgdmlhOgo+ID4KPiA+IGJsdWV6L2RvYy9vcmcuYmx1ZXouR2F0dENoYXJhY3Rl
cmlzdGljLnJzdCBhdCBtYXN0ZXIgwrcgYmx1ZXovYmx1ZXogwrcgR2l0SHViCj4gPgo+ID4gTG9v
a3MgbGlrZSB3ZSBhcmUgbWlzc2luZyBvbmUgb2YgdGhlIG9wdGlvbnMgaXMgbGluayB3aGljaCBj
YW4gYmUKPiA+IGVpdGhlciBMRSBvciBCUi9FRFI6Cj4gPgo+ID4gYmx1ZXovc3JjL2dhdHQtZGF0
YWJhc2UuYyBhdCBtYXN0ZXIgwrcgYmx1ZXovYmx1ZXogwrcgR2l0SHViCj4KPiBIZXJlIGlzIHRo
ZSBjb21taXQgdGhhdCBhZGRlZCBzdXBwb3J0IGZvciBpdCB3aGljaCBzcGVjaWZpY2FsbHkgdGFy
Z2V0cyBCSS0zNC1DOgo+Cj4gZ2F0dDogQWRkIGltcGxlbWVudGF0aW9uIG9mIGxpbmsgb3B0aW9u
IMK3IGJsdWV6L2JsdWV6QGU1NzdlNDcgwrcgR2l0SHViCj4KCk1hbnkgdGhhbmtzIGZvciB0aGUg
aW5mbyEgSWYgSSB1bmRlcnN0YW5kIHRoaXMgY29ycmVjdGx5LCBpcyB0aGUgaWRlYSB0byBpbXBs
ZW1lbnQgYSBjdXN0b20gR0FUVCBzZXJ2ZXIgd2l0aCB0d28gY2hhcmFjdGVyaXN0aWNzLCB3aGVy
ZSB5b3UgY2hlY2sgbGlua190eXBlIGluIFJlYWRWYWx1ZSB0byBvbmx5IGFsbG93IEJSL0VEUiBm
b3Igb25lIG9mIHRoZSBjaGFyYWN0ZXJpc3RpY3MsIGFuZCBMRSBmb3IgdGhlIG90aGVyPyBBbmQg
aWYgdGhlIHdyb25nIHRyYW5zcG9ydCBpcyB1c2VkIHlvdSByZXNwb25kIHdpdGggdGhlIGVycm9y
IHRoZSB0ZXN0IGV4cGVjdHM/CgpJZiBzbywgSSB3aWxsIHRyeSBkb2luZyB0aGlzIGFuZCByZXBv
cnQgYmFjayB0aGUgcmVzdWx0IGlmIGl0IHBhc3NlcyB0aGUgdGVzdHMsIGp1c3QgZm9yIGZ1dHVy
ZSByZWZlcmVuY2UgdG8gb3RoZXIgcG9vciBwZW9wbGUgdGhhdCBydW4gaW50byB0aGlzIGlzc3Vl
IDopCgo+ID4gPiBJZiBzbywgaG93IGNhbiBvbmUgcGFzcyB0aGVzZSBCVCBTSUcgdGVzdHM/IElu
IHRoZSBwcmV2aW91cyB0aHJlYWQgSSBsaW5rZWQsIHRoZSAic29sdXRpb24iIHNlZW1lZCB0byBi
ZSB0byB3cml0ZSBhbiBhcHBsaWNhdGlvbiB0aGF0IHNpbXBseSByZWplY3RzIHRoZSByZWFkIHJl
cXVlc3QgZm9yIGEgY2VydGFpbiB0cmFuc3BvcnQsIGJ1dCB0aGlzIHNlZW1zIGxpa2UgbW9yZSBv
ZiBhIGhhY2sgdGhhbiBhIHNvbHV0aW9uIHRvIG1lLiBJcyB0aGVyZSBhbnkgb3RoZXIgc29sdXRp
b24/Cj4gPiA+Cj4gPiA+IFZlcnkgdGhhbmtmdWwgZm9yIGFueSB0aG91Z2h0cyEKPiA+ID4KPiA+
ID4gQmVzdCByZWdhcmRzLAo+ID4gPiBBbGV4YW5kZXIKPiA+Cj4gPgo+ID4KPiA+IC0tCj4gPiBM
dWl6IEF1Z3VzdG8gdm9uIERlbnR6Cj4KPgo+Cj4gLS0KPiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6
CgpCUiwKQWxleGFuZGVy
