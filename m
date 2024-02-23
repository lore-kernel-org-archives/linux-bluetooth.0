Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2095.outbound.protection.outlook.com [40.107.223.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E667BAE1
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690197; cv=fail; b=SzwOSw+ApkrhPenQH2JhAsUc9ad5IbpBEyw2kqkGjy99O0f3MFuoPwzo5zI3sGNWoKbPSagdIUs10P31u9gA9zS/IjdbMNsaMFvzS3H2y+HPK2dfvA9+EuWjV0YXq6nndRgQetXGR/WRzqbInKrHdtZ8lIIhiFf5HWiZMOHhxTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690197; c=relaxed/simple;
	bh=zja3F3w8VrJtFbZBH30oMA7J1Fv075Q9p3BZ85IUc/E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CFvHT8iX/0Dl69pfNVKdmTJKv6E9aYuyZkE4F4nue7foD9ab31NLoJ+df/sBRFSXTP/RAwvGNKEBBb82LUKtfd6UrINceyohBn2qBVq1mbXFt9/UmKdTLoeAqDQ+FxlVKUYQSRZQ1N2ydIBtOXwsYCLqASkmVVidSoRrXWVvNwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=MUtWDLfn; arc=fail smtp.client-ip=40.107.223.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="MUtWDLfn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYZ5rA+SyW0ekoV/1fEbHKNlssvGDm7U9OnuP18kLSbgZ/wCBfW/AGoF5nlpqghgpOSltCdk3EMh6cPpaOMMznNSbVi7Sfz35ZI7XSTVM6vvwvcgz5GXqyKfO3GXpVacFJYKFstSAqppfUF0tOWraTWQnLJihtCLqu/+h8GZxoDvVgadyde+uyIGqQQEsu9yKSWnoU8fp1fG0ISV4FHceEh4uhcqL+pkAkWkafNP0PbRDwb4+Hhc9lh/7E5uMssc3x6OH6XjgvcsX32HaliTZGHHv23Hw2eGrLEjgG/03D4yd535T9iHCNjNMId731e0lsaE5O/dP9uKOppe1gfB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zja3F3w8VrJtFbZBH30oMA7J1Fv075Q9p3BZ85IUc/E=;
 b=IHrzE8WtO70gfouDJBocT8Zc/l0ExbMZ23Q3xT/Gv6kbMfXtYLGrcXHuHoy4jUODjbN3iLwH5afseQR+2AIZwQ4Mudgw/dtyzyTf4HXF8mpixuYGlnGVedDTFHP+CUwxWfwMtuoEnpr8tY+1JahYWp2g6T9c5RDWZZhdHOSOzgOTVIwz9z6xwFIkMXc+7LnoVGzhWCmplFu/HuYynhgFxqu71prInjz6txkfRPvpl4lyOMW6ssomW3bWeOexVyQysngJnMZS4zA+v6YZfhevKgbge3m0rfO1+Dotpgg84fqpNNnVvwoTmNFtPdw07s6pLFSRugIfR8WWBjAyFhVT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zja3F3w8VrJtFbZBH30oMA7J1Fv075Q9p3BZ85IUc/E=;
 b=MUtWDLfnkdfAIaprthoLhXwMip2dxtCj5EudJetsmzMcIqOkTq7sTjUveZbNNDOlmEmZCybJmGwy3IqFJljYJAK1afy8IFqhFSPdvDIfHD3nQR90XIDb1HTCEw60A66yXMOLKi4fSBwG73jEEoQfJlWO+vn6w+8lRTIwgJhLtGlvqI08Ysksm4wX8t02K/cqDftm4LKFC8vJGu1kQ209Doi4FaMiUV5fs5KRidp5eIYlBmXosNdV2Bke3Bktl3yFcTpGvbqvkLmDRu6AV/gpt5mHPTSw4xYzLId3qYCtzYKUnHYDGYCBny3F5IkxtlDfTEyepYEKEeN7RjCAbCAEUw==
Received: from CO1PR10MB4612.namprd10.prod.outlook.com (2603:10b6:303:9b::22)
 by CY5PR10MB5937.namprd10.prod.outlook.com (2603:10b6:930:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 12:09:53 +0000
Received: from CO1PR10MB4612.namprd10.prod.outlook.com
 ([fe80::42d5:5d74:194d:7828]) by CO1PR10MB4612.namprd10.prod.outlook.com
 ([fe80::42d5:5d74:194d:7828%5]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 12:09:53 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "emil.l.velikov@gmail.com" <emil.l.velikov@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] bluez.pc.in: Add definition of libexecdir
Thread-Topic: [PATCH] bluez.pc.in: Add definition of libexecdir
Thread-Index: AQHaZLfPWdSMnNWnT0SJKydIksfsmLEWUxEAgAAEkACAAXHmgIAAD3IA
Date: Fri, 23 Feb 2024 12:09:53 +0000
Message-ID: <1502e3caf12aaf8ce25062dab434fff3d27896a4.camel@infinera.com>
References: <20240221111901.2807853-1-joakim.tjernlund@infinera.com>
	 <CACvgo529avv_gypHc4tO6VNmZU6Md0V9ZapQnLLCE_3vdjOT2Q@mail.gmail.com>
	 <38504363a13524443f21f1c0a50653bead0742bb.camel@infinera.com>
	 <CACvgo53fT8Siqm9SL2Gs4x+2iVqNEwSxe=rpwD6L81Tvd+Oo0w@mail.gmail.com>
In-Reply-To:
 <CACvgo53fT8Siqm9SL2Gs4x+2iVqNEwSxe=rpwD6L81Tvd+Oo0w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 
autocrypt: addr=joakim.tjernlund@infinera.com; prefer-encrypt=mutual;
 keydata=mQENBFp0f28BCADPn4XzN2HEzkY4BZKE6/T/S4M/Qjlf01K6gmECJZi5LQgOt0jOUAdvsXVd8yKYeqCq+eWvlfrLU9OXPGoCqwj95P2YjMsttqaPBEAnf4XyBs67Snz2wHyBDONoRxGoyq2Ondy+TPicWEm0mh404h9EzKxRNxwrRyKhsjWoVeaucuybAiGbJvqQj0CLmuMCl4PUBYDmXFzt3yx0g54z8E9/8ON+z0J7yZbA0aftZAjFLv6nn0Th/2dpD8d3vWtkJw4yBjLX2KFvlzJfQqkd6RI4Cn1OP9sguXDob123dMiMk/5XbjXz+0C21QFxejxt3HGisvKes+8swplyni7KdiDtABEBAAG0MEpvYWtpbSBUamVybmx1bmQgPGpvYWtpbS50amVybmx1bmRAaW5maW5lcmEuY29tPokBVAQTAQgAPhYhBFtMG/jmfqy7x0aBp4VMQ6CbDpcaBQJadH9vAhsDBQkDwmcABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEIVMQ6CbDpcasFAH/j64dpHpjY55tVoUg5yK8hcmxS/buKQQP9H3e2DdHeYrK0qeQ97AXiWTh63UvzvEXchiKjua6kYhUUkDObaltmwkKgPv0qb9lP6yfFBzvllriS6LrdIMCOLgtnQW2x28m5mC1hYT08jlqEXluYDoj2dTll9HGMsqn0JkhRjBsuzTXq8VyJjjnNLpzsAlTOGEQoAi7SqtDHs9PSNyOAKH5jRjATdNbPAsTKuI1veJf7Zzyc98yG0ya43Hqal1scoa+9GJZXNQPRaMVkyxKGbEEncdtnQl9e/DUMH4SUQ5vbM/+U4WvkX5Cvc+KwI6JAm1PhrAaVHSkDNAU5LqUqEbbHY=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR10MB4612:EE_|CY5PR10MB5937:EE_
x-ms-office365-filtering-correlation-id: 24867db0-b2f9-4f6c-012a-08dc346857a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /7RblKQHEHPRALNkK+VPyiw6koGNUvZjkoen8Ypc22F0ZcoGq3ipfT4aO+C1kr359CJUeOaYkiHDYFImtZLnLKJUUpjs4x2Q+yr+hi0xs7sXQJ3UjBy2yYrzENsDrJAhrWZIrwJ7DqVDA1pVM3sxg2hu1SUAZzErR3UxQainAWkCNWXyhV9YwHfeV5O3o80hmmoCXWK1U343PrLEz9yLxOwN4QqVjlFMn5NcZQ+L50Lc221aGsY7G94oyz8pT76/fCpeXboxRqcnSiz2CS84y6Nsw9PzaD+NaRbAyshGi9JTnSVmgUrsgV1++fFPYiug8bONsIvBteTPB+JISfwDbg5NFx/4mO2XyPGF2J/f+KANbSYkOD42hMIY6KbXEzht7nAg3ccPJvNXNOzzU2wCzeoBYyvT+SazpZBCRHeMyNZCEoWpWwVPRGmHR4GLUUkUdeC5Rpot/pmdNjhyhYvpe5BsDcfuy4XLFmADRFusQNNY3tv4eWWIYGQmsOWFdW69yxR23ZTNWqQNQpLMo9cLD5o/BzUl82JB5WnNx7fQtLa98V6DxjoEwz3RtUgiVn03VVZvJra6UUkvwlFwxTnHsY/xVgN+TsmJLSRaZlEZtotnT66UVB8zV6Bp4mG7+A6V
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4612.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzNyU2tnR1UvbFh0bGVVTHhFUG44UnIyL1AyNDlWUjBhUVNyRjNJSjdqamRp?=
 =?utf-8?B?elBZTS91VmtBUGhzV0d5YU9rbW9pSEdPZjJzcENGTkdWWWE2T0JEYzBOZE96?=
 =?utf-8?B?K2dzUWFQeGh4aHpqTi9EZGxPMlpMdCtGQ3VGT0s3N0dFK1Zzd1FCanc4MEdD?=
 =?utf-8?B?dVFyWFduSkt4ZWlzaVp4S2xqQ0ZBVUo1UFdrMTN5ZGVEZE9BUmtHdVJmdjdG?=
 =?utf-8?B?ZWJGbkNja0dsV2Z1M3NXRmxGYkdWMzQ5ZW9nQ2xmeHorSDF4a3lJcFg3eWxo?=
 =?utf-8?B?TWV6WDZBZDZUZ3NIaURjeklhTlBka1ZFYmx1WXFCRlhKMzlWZEpjTnFVYTFn?=
 =?utf-8?B?dndLb3RQRHdBZVFiTUk5d2R4RVB5cHZTT0w1aFZNSHRkNFNac0dXa0VGaVM2?=
 =?utf-8?B?MWpGZ2srQktEUzhNbWZDbmhHVENjcUlpVC9lV0RIWkNoUkJxMTNUSlN0d1g1?=
 =?utf-8?B?emRKTWtoMTdnbVlWNS9vRVJNa1JOUFcxZEdIekJUSTE0cm1BMmRBdlZ0R3FQ?=
 =?utf-8?B?RVFhdTYxMk5pQWhLeTNGcDRLN2RoWUNHekR0WXptRWMwbTR1VFYrWE9tOHRm?=
 =?utf-8?B?V0tKYVRYTWdlZUhSOVJMK09sdEtvSnB5OTZmazczNzg0U25TTmxEV0xoWG9Q?=
 =?utf-8?B?N0E3NlMxWkNvZFBBS2d4QXJIYXNTMzMrYjNrWEZWZGJYNS8vdmRLVVRvY2th?=
 =?utf-8?B?eXM0cVllTDlEM21KamI3Wlh0U2VGajZuMlZaRFU0NDZZL1VrMlhSL0toTTBw?=
 =?utf-8?B?WnRrcmFqeVJOUVgyRjE3OWxPNzhrVkpiSlZoRVJyUTBER2lvWWVZMFdBaWxX?=
 =?utf-8?B?bUtJR0ozZ1BFejczV1h5OE1UTEtRb3pnTGtGREpJWUNGbVNxOVBSbnFRZEZn?=
 =?utf-8?B?WWQ3QldoRG16UWUwV216d0dYdGp1MU5zdFI4SXlLYTBQVEhraXhJajRPaENC?=
 =?utf-8?B?T3hXdjd6ZnlSRkdtQlp3YWM0L0g4OU1zOW9zUHhVYnZZaFpUS3dieDNVLzZC?=
 =?utf-8?B?RGZRbC9IeWlva0w2UXp5MFl6d3hDV3c3V2kyekxQTHU5K3VDUkU5ZGNuUTBI?=
 =?utf-8?B?VVYzZ0cwVVpxRFQ3L1l1VG1naElKNS81K0FGMVZnb25qN0ZubWN4dEp4d2t1?=
 =?utf-8?B?S3BBTi9wMTg3NW9JcENNajlhY3NtazZ6bDg1MHRRSDcwOS80Vy9pK0Q1bWd2?=
 =?utf-8?B?UUZQbW5SdGpTaFpoQVpVaStYd1hMU1o5RithQnNEV2VrQTByNmtReVZaQ1RT?=
 =?utf-8?B?Y0lXdzAxc0I5V1BWRnZUTy9VUzNxQmorOFNzZ3crN05iQW51elpBSmF2TUla?=
 =?utf-8?B?UnE4c2twa09DSFphQ0JjSC9OdGxmMEVjRGpHMnFLTmt6V0V2S1hvb04vRS91?=
 =?utf-8?B?eTFKTXVXWE1DRjBLdlgyWFAxdVFDcVdwZ3JsNVZFejJrOVczTGNpVC9tTHVB?=
 =?utf-8?B?VlR1OVRydTE3K1VObUNQdkg3emRhc3d3c08zczVuYmhpckJ1OFliMUtycTV2?=
 =?utf-8?B?UkNtb3lYMndCYytHZzRTaW14eU9remY0dmlyZktuK2NKSXpzK3h5QkxadjZG?=
 =?utf-8?B?L3MvZFQvTEgvb1YySUdwSTh0ZmxYYnlhb1F2UkMrQTZKZ0t1Wng2NXlCTmVL?=
 =?utf-8?B?NXUrQzFiQVBhb3Uyd2VtZFBhK0RZY1dNdUVQT21Ha3QybXErRVoyNDErQlFQ?=
 =?utf-8?B?TlhGZjViVVNVcklQcFhMMlhDeFNEWDNuMWlNWFhCSDlyalo5ekkwamwzamlG?=
 =?utf-8?B?VHNobVh1T3k0VHZaYWQ2MlNEMnJtUmROZDhwRkM4NWVjNmhuMytOVE5waElo?=
 =?utf-8?B?WDhlNlY0VCtOSis5c1lFMXo2R25Xd0VrS2xjZVlkamozcnBCbjRVYUFXdUR6?=
 =?utf-8?B?VHpaZXVicWM0VU16NUVZVm1DL2krbVB3RzB0cENBS1hwTXRDbkZIUVFjYXJt?=
 =?utf-8?B?M3FRNVoyVjlRaWtPTVJYZEI0OExBRmxrSTBMdGtodkgva01xMElSRGVuRUtq?=
 =?utf-8?B?aDRORzlRSFNpclNhWE1xcnJhUmw0ek9STzZWeDQ0L3Z2Y3R5VDRnc3BNUTVo?=
 =?utf-8?B?VWhzVU9mWmhqQS9KTXljTWtIRzBnaGVBcmN1TjY4S3VxU3RUQkpxMUx0Q0N4?=
 =?utf-8?B?Sk1NNVI3OTAxNWFBc1R1dEtOaU1KYlRKSWx1dFFWMjM4S0Z5TjRSbVhJMkNG?=
 =?utf-8?Q?26yjEiBxwNHKUTO2JtqM7GiMJOLirxlPFSuGvZWUHY8Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F819381184ABD44F9A0F93D51864D66D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4612.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24867db0-b2f9-4f6c-012a-08dc346857a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 12:09:53.1335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPuo1lRk+i9sPLHohQj3UuN629VC1FtnJDEnUiKohcOuDngl/W44qosITvtd/0Av34J6lqliBQDNB1ghm+8J4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5937

T24gRnJpLCAyMDI0LTAyLTIzIGF0IDExOjE0ICswMDAwLCBFbWlsIFZlbGlrb3Ygd3JvdGU6DQo+
IE9uIFRodSwgMjIgRmViIDIwMjQgYXQgMTM6MTAsIEpvYWtpbSBUamVybmx1bmQNCj4gPEpvYWtp
bS5UamVybmx1bmRAaW5maW5lcmEuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUaHUsIDIwMjQt
MDItMjIgYXQgMTI6NTQgKzAwMDAsIEVtaWwgVmVsaWtvdiB3cm90ZToNCj4gPiA+IE9uIFdlZCwg
MjEgRmViIDIwMjQgYXQgMTE6MTksIEpvYWtpbSBUamVybmx1bmQNCj4gPiA+IDxqb2FraW0udGpl
cm5sdW5kQGluZmluZXJhLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBGcm9tOiBKb2Fr
aW0gVGplcm5sdW5kIDxKb2FraW0uVGplcm5sdW5kQGluZmluZXJhLmNvbT4NCj4gPiA+ID4gDQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEpvYWtpbSBUamVybmx1bmQgPEpvYWtpbS5UamVybmx1bmRA
aW5maW5lcmEuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGxpYi9ibHVlei5wYy5pbiB8IDEg
Kw0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gPiA+IA0KPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvbGliL2JsdWV6LnBjLmluIGIvbGliL2JsdWV6LnBjLmluDQo+ID4g
PiA+IGluZGV4IDNkNmU1OTYxNi4uMWMyZjMwYjMzIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9saWIv
Ymx1ZXoucGMuaW4NCj4gPiA+ID4gKysrIGIvbGliL2JsdWV6LnBjLmluDQo+ID4gPiA+IEBAIC0x
LDYgKzEsNyBAQA0KPiA+ID4gPiAgcHJlZml4PUBwcmVmaXhADQo+ID4gPiA+ICBleGVjX3ByZWZp
eD1AZXhlY19wcmVmaXhADQo+ID4gPiA+ICBsaWJkaXI9QGxpYmRpckANCj4gPiA+ID4gK2xpYmV4
ZWNkaXI9QGxpYmV4ZWNkaXJADQo+ID4gPiA+ICBpbmNsdWRlZGlyPUBpbmNsdWRlZGlyQA0KPiA+
ID4gPiANCj4gPiA+IA0KPiA+ID4gSXQgc2VlbXMgdG8gYmUgdW51c2VkIGluIHRoZSBwa2ctY29u
ZmlnIGZpbGUuIFdoeSBkbyB3ZSBuZWVkIHRoaXM/DQo+ID4gPiANCj4gPiA+IA0KPiA+IA0KPiA+
IEJsdWV6IGRvZXMgbm90IGJ1dCBwa2ctY29uZmlnIGlzIGZvciBvdGhlciBhcHBzIHNvIGlmIHNv
bWUgYXBwIG5lZWRzIHRvIGtub3cNCj4gPiBzb21ldGhpbmcgYWJvdXQgYmx1ZXogc3R1ZmYgbGl2
aW5nIGluIGxpYmV4ZWNkaXIgaXQgY2FuIGZpbmQgb3V0IHdoZXJlIHRoYXQgaXMuDQo+ID4gDQo+
IA0KPiAiX3NvbWVfIGFwcCBuZWVkcyB0byBrbm93IF9zb21ldGhpbmdfIiBzb3VuZHMgbGlrZSB0
aGUga2V5IGhlcmUgKGVtcGhhc2lzIG1pbmUpLg0KPiANCj4gRG8geW91IGhhdmUgYW4gZXhhbXBs
ZT8gSXMgdGhlIChibHVldG9vdGhkL29iZXhkKSBkYWVtb24gbG9jYXRpb24gb2YNCj4gaW50ZXJl
c3QsIHRoZSBjdXBzIGJhY2tlbmQsIG90aGVyPw0KDQpObyBleGFtcGxlLiBJIGp1c3QgdGhpbmsg
aXQgaXMgcHJvcGVyIGZvcm0gdG8gcHVibGlzaCB0aGlzIGluZm8uDQoNCiAgSm9ja2UNCg==
