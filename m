Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2054.outbound.protection.outlook.com [40.92.103.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0738C138;
	Wed, 22 May 2024 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366095; cv=fail; b=SBQa5pbwEK2+GKW5ENqYnm+JvapjZtCuZe/i1XwdWcc2CyZFloE9eDuGamRPFKDa5k/GzG/xPCmHyJUZGGgdwPRtTwhr+8qx+iOtHiJ90p6m0ZETp/BkCMjgGusGL8Z4MyvPerhoYrUaIgVNq4bBkwg8sYkrYGSeUlw8jzWvays=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366095; c=relaxed/simple;
	bh=D5I/3dikUfzjLy+5PcrU4hZYEV2EcCj5MNqzxHQtdqM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DobHncZk/zhgn+VwoJumuoqcqmQvsK1CrS/wILib/qBYAqcWxJWQnpfAZC7Y9iQxxYWtzfTwQlBa7r2Ng0P9G49A9xHpM5meW/8ylAits3EA0XyGdTwdZXne+23TFosCgx1Qe9ON79Au5gUIbRt23+v+qsWunBO+6Gt5TNWiLi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=TpTM+i3i; arc=fail smtp.client-ip=40.92.103.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="TpTM+i3i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKQcxtwhONLVXX8C1XVf+GmNZyVZdKOWsoD54qldr72BU8PrwQxXwYd0Z6RvnPY59AqIChx/kqHWF3YIN0EtWCMl+4kSz3K5fgNLaUxzkm5jvq6b/0qNF6/tQFzRKv87QIGmjpp6dO26br3QS1kiTRhjyxELnogi5uq594f2B8JBExXXFD8yLELQVgWId8GcsRP2xv1XxY/+JviqhrFQ2YRLNJBry55nrXkZeRInGBuTOFj1+HD35xGOgrOmwH4/Acndev51ZH/WVHepR9RLKiz579nDEVXaIY7pDKZNNe06h5FEsTYu/XicX3C25xbVIB2jbiKS7z4rcwc/cIwsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5I/3dikUfzjLy+5PcrU4hZYEV2EcCj5MNqzxHQtdqM=;
 b=mdtqr+zwLb5IYUrgLsdGnnY2W/h3swKOAYLxScSepttl8OaPielrdPtNwfAty6lCO/UxNAnmKi3tmejti0ppHILAgEm/APbQRZdJRij3B+OkU6qs7vpm7sX/MDbR1xE5YprACRnCQpiGfiaobyvBjKLC3WrXFw4XbHr9Mvv0IIucZX4xqrltDDxPVv0pipKtO+2gU/VKg280DnAstWoyQ+1VjXFOWm6m7Zt0eDy54+ZdOuGpH/Y8h5TuAnNmAvENl8XSYnwb3uCRu8KzK6J7FoJWnYnpSRQ1i+9f8nb6ykYCEJhQb1KLvGtYKvoNaaRt/wfwNDRlYyKgZkYYeSNTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5I/3dikUfzjLy+5PcrU4hZYEV2EcCj5MNqzxHQtdqM=;
 b=TpTM+i3ijY0UQ/FWqBcy175eG1KpBHZ5ZtET9ivPKA2suJEYnPRV2tVseLOZMyw/MQlWNvUXaMiP5ExiKspvsTGl2NNCIedWQtx/6AfYpt6OGT2e7s5zdl/xbzfbecM/STU1MDC/aoxaVuvrFCUyxoaC5P08n1auM62pdqEWwYrNCvey5cOqFm0iPzhhPUkcGjB9YYGimKAs92r7wPzMQbNyOuzutgmZwaHx5sQxDy7CR5fyks7dxMFK7wFQTibCdrFP2aszvK8zdQL5XGumWocTg6dzk/JuJFR0XKvTi7SjyteakL7/d3/fUjwfAZG8iuDPvnZ4kX0NUYyw0YPLAA==
Received: from PN0P287MB0216.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e7::9) by
 MA0P287MB1739.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.19; Wed, 22 May 2024 08:21:28 +0000
Received: from PN0P287MB0216.INDP287.PROD.OUTLOOK.COM
 ([fe80::ab9f:304e:eba9:e991]) by PN0P287MB0216.INDP287.PROD.OUTLOOK.COM
 ([fe80::ab9f:304e:eba9:e991%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 08:21:28 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "Nobuaki.Tsunashima@infineon.com" <Nobuaki.Tsunashima@infineon.com>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER
 to CYW4373
Thread-Topic: [PATCH v3] Bluetooth: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER
 to CYW4373
Thread-Index: AQHarAKK84ZnIBFVMk25DNY7ErtxebGi0uYkgAABegCAABM2B4AAAfwAgAAAfxA=
Date: Wed, 22 May 2024 08:21:28 +0000
Message-ID:
 <PN0P287MB0216EB98A08CA9C068D99E7CB8EB2@PN0P287MB0216.INDP287.PROD.OUTLOOK.COM>
References: <20240522081735.469503-1-nobuaki.tsunashima@infineon.com>
 <1c194c94-54f1-4dfe-a790-913e3d9529c6@molgen.mpg.de>
 <PN0P287MB0216914307B53414954BCB6CB8EB2@PN0P287MB0216.INDP287.PROD.OUTLOOK.COM>
 <653173db3fd440028e166c2d0e3d922e@infineon.com>
 <PN0P287MB0216BF302E3DF1D53EA3CE43B8EB2@PN0P287MB0216.INDP287.PROD.OUTLOOK.COM>
 <041e261da8f34550a299748d3a327988@infineon.com>
In-Reply-To: <041e261da8f34550a299748d3a327988@infineon.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [V+rmM+kwTE4LECH7k/qN7rUHTAqeQTMw0AsarbMUdTWzWQ1t9U94Zoc/g5CP+Vk8xzzA+YipwoM=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0216:EE_|MA0P287MB1739:EE_
x-ms-office365-filtering-correlation-id: 899522eb-4c32-46db-bb71-08dc7a382de3
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|440099019|3412199016;
x-microsoft-antispam-message-info:
 CAvhYJGLmhghR9j6tleGd390uJC2FBzGihfrTocGl9EB1irwQMeTtXDuEpCdaFu9mg7Sl8lGnRRdwCtE8qSpGnWr0KZyhmsJK3OZ3gKXpf2pQZkA2fzQj+2d0jwifOJEhQLH2rS27/Gp0ljq48lvAdO9o68TrxwzgU2grIGb0stN77xwOIJa1jIs98KBGDFNM5quXsF1o1knKz39WrlWnE5wvIiKKQMJTJRK6KrkHdLNWla1BFXpa12nLwBBrGlq37TQb5Joavqfem7JUJ/wmOAhxSlp7ogHJXQ3CrkWTiZod6AQ/zg8MPm8hHl56k3xoEe/5OtQWbgB2Ee2RR2mJRtDWb8uSTbyuA0ZBSy3vrBJ+jB9at84m7KZt9erIz9C5sjKe8l7am3tpwvDGRb/t1IvBRLjFdSiJL85DgdjZW1mV+lW9O0pSdlmwdCvffpWnecpMAbY2EIhohr+rPht3ClOMhs5zPxlxNtEDyGFtuV5EwuJGwDZ8RiTO/v/CnvDW/2a3CkrDTB2DfXzH15G2ii7aRnA9fF6vzAKrQFuj2To9ZZ11bPm3PNv0ltgu62v
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T25WRG5hajJ3QWh4SUpsT082OHdrZ0Jkb2VjMHlGZVhpKzN1WWNXVWNuL1pn?=
 =?utf-8?B?MHI0K0ZlRkpicUZjakRkd2lIRnd6UUNnd2pySWtnZWJWU1d5SUp1bXhVMFlO?=
 =?utf-8?B?dFNiNEFwTnNqeUlBdEJacEpjUWVUY3NxeWhWcnV2bXR2Sk5LRlRKWkIzd3dp?=
 =?utf-8?B?d1dEcGNXSTA5UTFqVmsrRFp6QnZWbUUxeFBhSXYxL2d6ZzdzcWVUclVnNHZ0?=
 =?utf-8?B?aENVb2k0eGtadC83UTZ1a1lCVll2M211dHBDYmpabjhOdktScFFjYk1nZXVa?=
 =?utf-8?B?YmwvTFVWd0Z2RW8zZmtLcFVFZElxeHk0Zmd0bHdrSVZ6UXc2TDNIeFNrWC9H?=
 =?utf-8?B?QlhoaU1BYk9kK2FLNnQ4Z2xkNDVRbnpXTGNBWVNrZ2NHQ29ncStFZ0VyQ2xG?=
 =?utf-8?B?RG5Bdm1yM1FpUDRSWlFlNXZ3VGhYckRCRFFVbnBoNXRNOWlBWGF5SnZGa1R5?=
 =?utf-8?B?Y2U3UDh1QzRlSzFaOVJyVDR6WXhYb0hiSHR4MFVZN1p1UGRBdXB3Rk5KQ0FD?=
 =?utf-8?B?bk9WUmNsVUxDZExMOUZBaGo3K2I3QlIySUJVY0RTTWlVTktpK0RvMm5IVHBQ?=
 =?utf-8?B?WS8xUW05aWI2SDBUU2p3QWhjNUFuc3NURzE1TGRqbUNPMnVFb2p3SU0wMnNK?=
 =?utf-8?B?NzdDRndHVncyU1BMaGVRMVZUOG9vRmJBYzE0WHI5NC8xUVZBa1JISENhTHFm?=
 =?utf-8?B?bUdrUk9vMWpiQ0puMWdUTEtMblY0OHBiZ2plYkdwM2xpV0VKY1BxZ1N6TmxC?=
 =?utf-8?B?UFBVbjh4THhEdExRQm9DdFRqaTczL3l4Y3hjbVJlSW9DSmN1R25xakVaZGt4?=
 =?utf-8?B?aDNsellScVR1Yy95RGQyMVdqZ1dBZDliYmhBQmhaS000T1FpR3Q0SFAxdVZp?=
 =?utf-8?B?MTViNGQ3Vy94Tk54cENwS3NQNWlRTVFoRk84dUJ3WlpvbFNYNStiemNGOU12?=
 =?utf-8?B?TWx2bXR0WmNOUjhXS29pZWJueW1CamJpeDNLTlV5LzZkK0tnVlUvNnBYbjMv?=
 =?utf-8?B?S2dzTC9CQWxGbWE5alo0L1Q4V3o3eDVFTldOV2ZOeit2QXpQZkI5RjRyT2dF?=
 =?utf-8?B?VVdEL2o2NTRmaHZxSmxrd3Z2ZHNNMjJEOW44Z0NTT2ptaUk0ZG9qYkRwWVRh?=
 =?utf-8?B?REVDRlkvUjMwc2thRHZlN2F3UGxvVlo5b3VZUE9vbnZFOTFqOVVJTWVqaHJ0?=
 =?utf-8?B?YXh2bW5pMklybjFNVnpteE9jRGVnYWdwRkoxZEpIVFBhOWY4SmJlS2dra0t4?=
 =?utf-8?B?UnQwc0YrcG9SeURmSmFtc0lDZExDUWJLMy9ndklYTFlGOHd5WEc5R0tLTDlT?=
 =?utf-8?B?Ui9PeUhSTEFuMG5qdjFXbzUxSUZMNmtQa2RlckVFdVNvSzhZSldlRXNYeTdJ?=
 =?utf-8?B?VHZmaGxCWTVIb2FwQ21OUlVzbEppSzFETG5idUg4UFpmU0M0WVhEdkNmOW93?=
 =?utf-8?B?K1VoV0hzRUdLdnBaN2tvRVFqakhSdVo2RXd0VzJKMC9OMWtOZ0R1UFdodFU2?=
 =?utf-8?B?SDdFWUdEWU1sanV3dTR0VDFieHdaYXhMQlZydUhwYWtQQ1VwVWFXWnZ4eFJK?=
 =?utf-8?B?YTg4VjVpSXJUOTdmcjdGL2Z1VWFxcndZeGdKb1F2dHUxWVdaWWU2SExudjRI?=
 =?utf-8?B?Ry9VMTZyTzhNV010ZjFsRmVYRzd2emM2NHl6MlQ3T1ZwUngrcHlqenBTN3Q4?=
 =?utf-8?B?M05JaEM1amFCS1loRlU2c0pXY3FTVExKN2EzcjhyTGp2V241ekNmWmE3R3RZ?=
 =?utf-8?Q?dS1FfLxVKW5staEpeY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0216.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 899522eb-4c32-46db-bb71-08dc7a382de3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 08:21:28.6139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1739

DQoNCj4gT24gMjIgTWF5IDIwMjQsIGF0IDE6NDnigK9QTSwgTm9idWFraS5Uc3VuYXNoaW1hQGlu
ZmluZW9uLmNvbSB3cm90ZToNCj4gDQo+IO+7v0hpIEFkaXR5YSwNCj4gDQo+PiBZZXMgdGhhdCdz
IHRoZSBzYW1lIGNvbW1pdCB3aGljaCBoYWQgY2F1c2VkIGlzc3VlcyBmb3IgbWUuIEJ1dCB3YXMg
dGhlIGRldmljZQ0KPj4gd29ya2luZyBmcm9tIDUuMTEgdG8gNS4xND8gSWYgeWVzLCB3aGF0IGJy
b2tlIGl0IGluIDUuMTU/DQo+IExhc3QgdmVyc2lvbiBjb25maXJtZWQgd29ya2VkIHdlbGwgd2Fz
IDUuMTAgYW5kIHRoZSBmaXJzdCB2ZXJzaW9uIHRoZSBpc3N1ZSB3YXMgb2JzZXJ2ZWQgd2l0aCB3
YXMgNS4xNSwNCg0KTWFrZXMgc2Vuc2UgdGhlbg0KDQo+IFNvLCBpbnRlcmltIHZlcnNpb24gZnJv
bSA1LjExIHRvIDUuMTQgYXJlIG5vdCB5ZXQgdGVzdGVkLiBJIG5lZWQgY29ycmVjdCB0aGUgY29t
bWl0IGNvbW1lbnQgYW55d2F5Lg0K
