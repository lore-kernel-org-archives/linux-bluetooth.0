Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023128.outbound.protection.outlook.com [40.107.159.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8D26B098;
	Tue, 31 Mar 2026 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957939; cv=fail; b=SKXgpalSzfVTXlqlm0K+uBctj6f6lVBO/myS9RRRq1GyKOFdxZ4LJOwsa6I0syNBX3e4OoFFYa6XIx620LNHBVjwGyQXtdhvl3uuotGMXT8/hn107woK8A8OiktdHoM+fWcotS4Iz0wfblePNG89JazUQYh0pj9e5BcnA0DAnRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957939; c=relaxed/simple;
	bh=E3nfjjFRcJ84z0R7W4dcWmnl9pfiAjvIC6zJ9UZy9kc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nhlP1PZHWMmjkjOfx22jzuJlnkaTwtuZnaMIs6recNyGnekfcqJilZYJ48XZI7gduWKY5CocDfiprC7deJ9+8wHw7XIR/r7rQQexka/G/C0CxwmaHGZnVGPedOgRycK79PsAi5Nj3CYfrBmQ1ubSeSu4r4ctIZ/+NsTN5J1nsfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org; spf=pass smtp.mailfrom=1seal.org; dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b=jPNpMJZF; arc=fail smtp.client-ip=40.107.159.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1seal.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b="jPNpMJZF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9FrahTUTykLJqcB9H3f48jnde9pShZNvx1xa0ZjQDO+W84wi4qDKF8IXRhK2wWKM85qlrSTFnMwxB/4ig8A8Sr0IjDKwkopQg2uORk5zOrptfn/knNQCBZeMzBT23HujOTta1UCo2pqKMWsrDWccmBQSobLfa6YQKu7BXHaiHqB+nhFITBs5gkwnZPnEkAznCxeIoN0hMhFhP6NhY9Pj3MhSFSAMsBLu6UxkTv5eErpxGVB3LouNynCO4XtqA9YHk9TGzTijlRNkgJLI8V2D4vH/JgC23/1cOFJyBxOG82Ba+eiREYi54rNU6HouvLHlYMJFFadKhnJaUrbgnOZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3nfjjFRcJ84z0R7W4dcWmnl9pfiAjvIC6zJ9UZy9kc=;
 b=vzlyUwMZ2ziZGWHYS80xc4dFCVzgrXrdi6eT+Bg5cxWpxRWroasKdOhqOs2hhMa7/VLWL9UNKd0Pr+94fcDawt+RmhhzIbJMY7eMFnleoYgAWEUnyaJ0qhqYb0DUbqQllm8MAk80RfS8pGnXUV2IJhM+XwOU4KH4CmbdjH6EfoI9ha6T2N60nplwbupnpx19+fvsslLk1orZSrUu1alE+hIH62PiTacp223gRFMgDt3eD6ZVWuYwI74i4RDxgphaRibliUfvv4ufClBPG8OSOThL+pUsjl3ze7Cjf3bizeNVbKf7JYz1wM+7AyjXT2ZsQloFOTP5lfbtC00e6tSjZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=1seal.org; dmarc=pass action=none header.from=1seal.org;
 dkim=pass header.d=1seal.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1seal.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3nfjjFRcJ84z0R7W4dcWmnl9pfiAjvIC6zJ9UZy9kc=;
 b=jPNpMJZF83w+IfJuzpXamFXyNG2aDOylacSn2BRxTA06dyAhaob/gZSQPMF2lC0t8s/rx0dGXBbnp0jxgMkQpTEH2LHZC7aciDPHaxF+mPpasNbuBmVUE70LJQKTUUXu5S9Ty+42UxHk1PyVrRR354E2qwOXyMPjTIfva7Yc46oX1/L1GupQwkb3oQPl2HfttvAjY/R2m/i9vS1SWB/sS26enbY4b0cJslXRAcvX6+fbulzJ3FnCLUiLD1JueTgtTk8u3f6z0fiQoUswJ0s6/blA5gOOFvh/sCLHfRGwFEw31w25B5/nlL/2st8KRy4irdoH881dxy/KdvlAE4fPBA==
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com (2603:10a6:10:202::5)
 by VI2PR04MB11219.eurprd04.prod.outlook.com (2603:10a6:800:29a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:52:13 +0000
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419]) by DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419%3]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:52:13 +0000
From: Oleh Konko <security@1seal.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] Bluetooth: SMP: force responder MITM requirements
 before building the pairing response
Thread-Topic: [PATCH v4 1/2] Bluetooth: SMP: force responder MITM requirements
 before building the pairing response
Thread-Index: AQHcwQTPYongjHdz3kKpQ7jmWPAf/A==
Date: Tue, 31 Mar 2026 11:52:12 +0000
Message-ID: <8f03334a700549ac8c712032f8ea8a3c.security@1seal.org>
References: <bt-smp-v4-ea63d24bfcd1416f9da279190fab15fc@1seal.org>
In-Reply-To: <bt-smp-v4-ea63d24bfcd1416f9da279190fab15fc@1seal.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=1seal.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7673:EE_|VI2PR04MB11219:EE_
x-ms-office365-filtering-correlation-id: a164f035-6b80-44bd-9a86-08de8f1bf2c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|7055299006|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 RAapRlFkyp2lS0n719hr+Yvo46kPiPDm0I2dZMyoKEM84qHbBLqzpEfdcc6HB3/F8TFiOwH8lF4DP5Zd71QVeQQPN2+DxrjSgLdJ6AXw2MYC4IWATeCGFFa1wEmqEQp0blq27oDhkHkXlE9isqgulD6aRfe/Pe6jzvilY6HHql2hTGe/zGrDK80TvLTnafBC0mbEoV9uIAjz/Xepf/HnXrV9ZLLbAx+vJQ3LgrHeZf/sd26P16XDDbeSC9AwZ7eHReRMI+8cA5Q/oM+3m2OhRU7+VsNTpwBk2j2umyr/Sye34eEaEiss95Z+CacXkHPb8Ipr3B4Qa+redzSDjAzZuh2+z5HZeYiirvb0awrG3x+2qMWsDkc6xg0yhpvfLIRrcsh9EqXWF2F1YoXY3tUF49375qzOuU0ARk9fGAICNpy0BIpLaZUrD3TmUmRsLkrQlTcWEDOv7JXcQUClDkZeeUNhFTOLorbGM5F2xgAuAceTzNZaUR6Dhvgl5bTr/38TSZVuaD/gTdEI5wHdo4a758FRr394e0NG9MrW33SmNONtp0rg3h5IkRF3VX6El5YPR5b7c7p/77PX5m3+NaTMe6YkVXPxUT0LQu6ruHSeOtDNjXAcdEO167HgxOJvheLGLcDAQ1XlXPBOc+nXEf+naPAuEGxAZrnIoxDN37IIHrZzsaNF396V3uxTfkrIw6k3NdW4uxPsr3qDq/y+zhK0LxAPngm7IFB8cxphOMk9FFRDW2TmTJ0IErZ/bjvVzckOFEojqfCCb/+SL3UJrFu2Rw9UQBOWG6C2bjPNYmzYoKvGIpXVV1oV4Bu0DR/7O2BN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7055299006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUp1bjRTeFRqUXhYQm9JYVFzcnBPejhlWEFBblpWQ2pDRFVMRU1EZWhNcnhj?=
 =?utf-8?B?UkNGNnNtRHRsaVJ2S1ExZVhDWXd5SnQ3UlRKY2lKaGRNZmE2VVJoMU9OdXJL?=
 =?utf-8?B?aTdsUURYdWp3Rk51V2t1TkRyeFMwcXZuS2M3RDNDZU1PNzBPM3ZOVk0vWGlH?=
 =?utf-8?B?SmdGNWt1dURHK3p3MGJSMUF2VzE1VDR2OVZYQW13eHdsb2FsTHVLVjNWTWZT?=
 =?utf-8?B?VWJJQnNvMG9SVHFudTQxK2lRd2ZDWHpRTGtiUmJsMzZONy9vY2F2WnJGb1h3?=
 =?utf-8?B?aXJwYkp5UWcwWVdPN3R6TTFmQ21aaXd1Q1JaMXlKQWZ6YVpCOEVGeUFnd2NJ?=
 =?utf-8?B?b1lCb1ZYdUppSTRNejBsQ2UwbDc4NGdWenpCZi9PL0UvY0tyUzFjeEZtUVFM?=
 =?utf-8?B?OSsrOFRwMEk5MWQ5cG9EV0FjUlNEQ3RGK2pQaXBiQ2hYa0JrK1VVckRGclhN?=
 =?utf-8?B?UnJZNmJUdXlMYmlNVjZBYkV1QmxaVzNJcFZ0OHNnTG43MWMxZEt0VWVadGRU?=
 =?utf-8?B?ZjdBWE9JZndDNjhpUThsZmp6SWpKMWlrcmROS3N1RDBnTjdaSkFaTDBVWnB2?=
 =?utf-8?B?ZG40bVpuZk1XU2s5L1Y1b2ErTFpzbTFqd0ZQMVB4SlZ0VkRlRXVLQU9nTUVZ?=
 =?utf-8?B?c1lTTTVKa3hiVi9UaEFRWFB6eTh4ZWFKaDhrWHZkY1FhSXJwaXZJZHU2Zm9h?=
 =?utf-8?B?MmhyQ2NHRTIrRlorRUJRbzROM3p4eVdESkdTTWk3YWZlUWhXeWx0aUtwRTJE?=
 =?utf-8?B?OExtYi90a0ZvQndxZU9VZjIzdk1tRzMzNWdEY3pINFhtdENwM0FJQW8yUGp1?=
 =?utf-8?B?ZFJtSjY4T3Q3czAwZm15RGIxRFVzREVrKzN6OTduSGhISURZbWpJSnhMODBH?=
 =?utf-8?B?bGk2dGludjNFUk01bWFDUTVLN05RMjVXR0tMcTl2d3VLNjZTcjF3bEtoQml5?=
 =?utf-8?B?Y01QemtYYnhRWjFkVFAzbXJ6K0lkNEwrWUdUN2c5SkJpb0dsN095QlFXQ2JY?=
 =?utf-8?B?cmErOVl1OTdYdkNOajdPaS83ci9FY2lpeURBV21wV1hHZjZ3ZlNkTTNRKzdx?=
 =?utf-8?B?bytnWE1IY1BHQnZMc0x6TDE1dHhzVHNuNmJrUWJIb0NKbElEUWY4c2lKU2Rt?=
 =?utf-8?B?d2p2NGJVdEdqRGQvUlJCOUM1YWtzMlowRHo5T0VtbEoyMThkekpnd1g4TmZV?=
 =?utf-8?B?RlVZaFhjNnRUVEZYZTJzNWgrUC9IWm1JeXRZVGZhaFNwbmhmSXdUNXV1aG13?=
 =?utf-8?B?YmFnVWlqazBSVHRGZXBnOWthSGVROVhmcUJ3Zm5MbXVkdC9ySDlQdTNjUVNV?=
 =?utf-8?B?VGxOditLd21XRzZDUWVvNWU0SndhQ05xdCtTS1pCbjRaRG1ub09HakFUdzNE?=
 =?utf-8?B?bkVXUlJhTkFqWDRhYktYWll5Mi93U3FCVkloMEQ4bHp6NEw4eXd0N1VXRlRC?=
 =?utf-8?B?WHZIWmlURGQxMEdocC9vVGFORzJRZzNtZE95OTA4eGQ3Z3YyZDFMNEZOZXdt?=
 =?utf-8?B?UXYwdjRYUCtqa0FMQXlCb09SOC9XZTJJU1d5Qkh2Rmpzb0NTbm9JdlpFSHlt?=
 =?utf-8?B?dmx2TzZId1RnWk1pRHBQRmZqSERlOFlYdFNrV2w2QjkvczVNRGcxNmc5eHBR?=
 =?utf-8?B?ZUJHMmNncThuViswMHBVbUVpbkpFaU92dUExa01WUjBRL1dxbnpXOUN5aXVl?=
 =?utf-8?B?YTJ6d283RFBCWFhIajZ1KzZJZ0pJSDZaczQ2cVgvZ0dmakFVRENUamNuOGlD?=
 =?utf-8?B?c3ZRVEFhcFh6VjllWjArdDBGL09FZGczMEJVTmpPWFZCTHNiNEp2Ry9idmZm?=
 =?utf-8?B?RUhSbkRFcXY1dlZhVGU3b1lQcVpBYi80OVhBVU85REtCV3F4WDhKeDhsOTVl?=
 =?utf-8?B?UG1YNWZOYTJhR0xnNURGd09FZDdENm1EVDgwdnl0L29nazdMcGU0VndEcWFS?=
 =?utf-8?B?WlVhSDlZSTdESVFmTzhyR1JtbVo3SFdoOEprS05wa2tQOFZIYSt4YzFjdWJP?=
 =?utf-8?B?OWt5d0tlYUwwd1lJRjB4TXNQZXdZNVlMQ1JIOFBMQUxjRkVVcFIvaU5rSFJF?=
 =?utf-8?B?U2Q5clA2akFRTG5LV2ZkV3NaUjNscGovOGprVHVmRjlPK0lyNEhtL0taVG5D?=
 =?utf-8?B?UEdHcXE1V3hUWXZnUTJER0ZSYVg3UUNiZ2VUUEVUa0RvdE9Sb1AvR3lXaGp1?=
 =?utf-8?B?UzN5V0lmcjNXd2VPbk1LV1NQNzU4b0RsbWxsU0dyYS9DRWZpcW5Xb0FnajhB?=
 =?utf-8?B?ZGZ1S3J2dXg1UFF5TjBiQiswZkVVMHdnT25sNjhKdXJNK1FQc3lveHZzcFlz?=
 =?utf-8?Q?FajqU1Z//3CtvNDTeT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBB7CBAEC45B624EB6BC2D339D1110FB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: 1seal.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7673.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a164f035-6b80-44bd-9a86-08de8f1bf2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 11:52:12.7509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e701d992-0f02-433e-a019-4256abe96ea1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZqPKI6pGvFX1fV1rOqKAQElIBIcGJvodzxyzKXTpdpZXXqVNeDGuFBQjZ1XVyCK81yi1iE2t9cdBkBP+ON/YCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11219

c21wX2NtZF9wYWlyaW5nX3JlcSgpIGN1cnJlbnRseSBidWlsZHMgdGhlIHBhaXJpbmcgcmVzcG9u
c2UgZnJvbSB0aGUNCmluaXRpYXRvciBhdXRoX3JlcSBiZWZvcmUgZW5mb3JjaW5nIHRoZSBsb2Nh
bCBCVF9TRUNVUklUWV9ISUdIDQpyZXF1aXJlbWVudC4gSWYgdGhlIGluaXRpYXRvciBvbWl0cyBT
TVBfQVVUSF9NSVRNLCB0aGUgcmVzcG9uc2UgY2FuDQphbHNvIG9taXQgaXQgZXZlbiB0aG91Z2gg
dGhlIGxvY2FsIHNpZGUgc3RpbGwgcmVxdWlyZXMgTUlUTS4NCg0KdGtfcmVxdWVzdCgpIHRoZW4g
c2VlcyBhbiBhdXRoIHZhbHVlIHdpdGhvdXQgU01QX0FVVEhfTUlUTSBhbmQgbWF5DQpzZWxlY3Qg
SlVTVF9DRk0sIG1ha2luZyBtZXRob2Qgc2VsZWN0aW9uIGluY29uc2lzdGVudCB3aXRoIHRoZSBw
YWlyaW5nDQpwb2xpY3kgdGhlIHJlc3BvbmRlciBhbHJlYWR5IGVuZm9yY2VzLg0KDQpXaGVuIHRo
ZSBsb2NhbCBzaWRlIHJlcXVpcmVzIEhJR0ggc2VjdXJpdHksIGZpcnN0IHZlcmlmeSB0aGF0IE1J
VE0gY2FuDQpiZSBhY2hpZXZlZCBmcm9tIHRoZSBJTyBjYXBhYmlsaXRpZXMgYW5kIHRoZW4gZm9y
Y2UgU01QX0FVVEhfTUlUTSBpbiB0aGUNCnJlc3BvbnNlIGJlZm9yZSBidWlsZF9wYWlyaW5nX2Nt
ZCgpLiBUaGlzIGtlZXBzIHRoZSByZXNwb25kZXIgYXV0aCBiaXRzDQphbmQgbGF0ZXIgbWV0aG9k
IHNlbGVjdGlvbiBhbGlnbmVkLg0KDQpGaXhlczogMmI2NGQxNTNhMGNjICgiQmx1ZXRvb3RoOiBB
ZGQgTUlUTSBtZWNoYW5pc20gdG8gTEUtU01QIikNCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQpTdWdnZXN0ZWQtYnk6IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXouZGVudHpAZ21haWwu
Y29tPg0KU2lnbmVkLW9mZi1ieTogT2xlaCBLb25rbyA8c2VjdXJpdHlAMXNlYWwub3JnPg0KLS0t
DQogbmV0L2JsdWV0b290aC9zbXAuYyB8IDIzICsrKysrKysrKysrKystLS0tLS0tLS0tDQogMSBm
aWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvbmV0L2JsdWV0b290aC9zbXAuYyBiL25ldC9ibHVldG9vdGgvc21wLmMNCmluZGV4IGU2
N2JmN2IzNGVhLi40ZWFhZGJlMGQyZiAxMDA2NDQNCi0tLSBhL25ldC9ibHVldG9vdGgvc21wLmMN
CisrKyBiL25ldC9ibHVldG9vdGgvc21wLmMNCkBAIC0xODA5LDYgKzE4MDksMTkgQEAgc3RhdGlj
IHU4IHNtcF9jbWRfcGFpcmluZ19yZXEoc3RydWN0IGwyY2FwX2Nvbm4gKmNvbm4sIHN0cnVjdCBz
a19idWZmICpza2IpDQogCQlyZXR1cm4gMDsNCiAJfQ0KIA0KKwkvKiBJZiB3ZSBuZWVkIE1JVE0g
Y2hlY2sgdGhhdCBpdCBjYW4gYmUgYWNoaWV2ZWQuICovDQorCWlmIChjb25uLT5oY29uLT5wZW5k
aW5nX3NlY19sZXZlbCA+PSBCVF9TRUNVUklUWV9ISUdIKSB7DQorCQl1OCBtZXRob2Q7DQorDQor
CQltZXRob2QgPSBnZXRfYXV0aF9tZXRob2Qoc21wLCBjb25uLT5oY29uLT5pb19jYXBhYmlsaXR5
LA0KKwkJCQkJIHJlcS0+aW9fY2FwYWJpbGl0eSk7DQorCQlpZiAobWV0aG9kID09IEpVU1RfV09S
S1MgfHwgbWV0aG9kID09IEpVU1RfQ0ZNKQ0KKwkJCXJldHVybiBTTVBfQVVUSF9SRVFVSVJFTUVO
VFM7DQorDQorCQkvKiBGb3JjZSBNSVRNIGJpdCBpZiBpdCBpc24ndCBzZXQgYnkgdGhlIGluaXRp
YXRvci4gKi8NCisJCWF1dGggfD0gU01QX0FVVEhfTUlUTTsNCisJfQ0KKw0KIAlidWlsZF9wYWly
aW5nX2NtZChjb25uLCByZXEsICZyc3AsIGF1dGgpOw0KIA0KIAlpZiAocnNwLmF1dGhfcmVxICYg
U01QX0FVVEhfU0MpIHsNCkBAIC0xODI2LDE2ICsxODM5LDYgQEAgc3RhdGljIHU4IHNtcF9jbWRf
cGFpcmluZ19yZXEoc3RydWN0IGwyY2FwX2Nvbm4gKmNvbm4sIHN0cnVjdCBza19idWZmICpza2Ip
DQogCWlmIChzZWNfbGV2ZWwgPiBjb25uLT5oY29uLT5wZW5kaW5nX3NlY19sZXZlbCkNCiAJCWNv
bm4tPmhjb24tPnBlbmRpbmdfc2VjX2xldmVsID0gc2VjX2xldmVsOw0KIA0KLQkvKiBJZiB3ZSBu
ZWVkIE1JVE0gY2hlY2sgdGhhdCBpdCBjYW4gYmUgYWNoaWV2ZWQgKi8NCi0JaWYgKGNvbm4tPmhj
b24tPnBlbmRpbmdfc2VjX2xldmVsID49IEJUX1NFQ1VSSVRZX0hJR0gpIHsNCi0JCXU4IG1ldGhv
ZDsNCi0NCi0JCW1ldGhvZCA9IGdldF9hdXRoX21ldGhvZChzbXAsIGNvbm4tPmhjb24tPmlvX2Nh
cGFiaWxpdHksDQotCQkJCQkgcmVxLT5pb19jYXBhYmlsaXR5KTsNCi0JCWlmIChtZXRob2QgPT0g
SlVTVF9XT1JLUyB8fCBtZXRob2QgPT0gSlVTVF9DRk0pDQotCQkJcmV0dXJuIFNNUF9BVVRIX1JF
UVVJUkVNRU5UUzsNCi0JfQ0KLQ0KIAlrZXlfc2l6ZSA9IG1pbihyZXEtPm1heF9rZXlfc2l6ZSwg
cnNwLm1heF9rZXlfc2l6ZSk7DQogCWlmIChjaGVja19lbmNfa2V5X3NpemUoY29ubiwga2V5X3Np
emUpKQ0KIAkJcmV0dXJuIFNNUF9FTkNfS0VZX1NJWkU7DQotLSANCjIuNTAuMA0KDQoNCg==
