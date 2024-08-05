Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63CE18026
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861054; cv=fail; b=e6J2gTzJE8Hr27PQK7TLGFZ64l6A7ifw90ltI8aqaNtvCIm7XI6wRmBO7q5iwwqFZRdeAB2oO4EYysQysW7vHf4kw91iM1sJr86rHyqxNXBKyYD88DYRsLVn/xu38CBA90/eK/XC4Zv+86AMXiZg0eRNDHlWHI4XxtmUI4AvZCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861054; c=relaxed/simple;
	bh=BNCVaTfzJq5LsU5RfZtEAONlP0v4yvwWx/kK/lL5FiI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uztGKhL6jXdyCwOgxWNJZNwi3mkiJ79FoB+v7iJflILvXivWOL3q9LQ5L4iK2GyjpVms3j6JB8NIF5RkqrshJg2IdHvc3DDfEJgYPYDVFNvnYZ8WdrQf+5GxaS6aZ+Km6rKZShru0YxWPMtkajCTppUYjdnVaqO2jp2VFL8p8rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=XsyrVEL1; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="XsyrVEL1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZEsQ5QDxSNenvpMS6jXR7s/0LYYpsVRE+FOokVob6vxpKE9I4IfgtyXOwPv4o+eEUrjx9lpKouEsRyNKzw5Qt6QIIaBxXENYdnhPlFFlWCadd9YVDCwJa/lPjCnlFAqJtw8OsywH7+5I5fwV/84FQXVJTpaj7o4BAwdwmy/v3ihc3eH9+yGJPt1FzlPP728rX3/lgOtQE9iI2rwm63rCxVeFdznDfgyCePx5PA2Wro+K6JS/z+whI19aCcLd9/D2n1fjcvCAamHdJbG4/P5v02h/Rt5959q4Caeyix9rvd3Oy0eYScz+yZvf7w6YCR7ahTgOwceEqj640DTPyQrcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNCVaTfzJq5LsU5RfZtEAONlP0v4yvwWx/kK/lL5FiI=;
 b=FvJHDotJ+1tcLD6Xtn5bkGI9P/hdifI4Kdzib+udt1cGhc22lJL37JCWLQeQ0Q97MfnPJdU5JY0uQmXok8lSA+nNBuYnTOAcRpsiJV9otuaIGHuPEUAzi/Vr2RsI+DyvpPyUOXm69cIiS8lIRPUNB0UiGYK7DG08yWDA1ULXfv/U/8i9s5zvOJAAnZn8/PnL7Ahc18TFFvIlFuTXkMVWfbwyw58uZtQbnJxGFGY2ydxPzgbCeHXu7aa7l4klU5Hx6KYuj2JxVbomL5cpAmAj4tRPHbMCYqx2JIdZdycAOy3NFaeyN8dA6vCsSIVjVet6zBqNe3MqqumwIQfQuppMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNCVaTfzJq5LsU5RfZtEAONlP0v4yvwWx/kK/lL5FiI=;
 b=XsyrVEL1RXyjBu+dnFvTjolT97ozLaCPGVU1mQ8yVj07qD1X9QZMqphUBPF0oDCngaAynuOXYa7LTffSfqve4ftGYykcsOTTE6eyoggBatfQh6EBPlDESdZvAQAOFtyMgIuaOXjhwaIsyrYoGcQELUmxpoEyMjHuywnyH1jvXWo=
Received: from GVXPR02MB8256.eurprd02.prod.outlook.com (2603:10a6:150:6e::14)
 by VI1PR02MB5968.eurprd02.prod.outlook.com (2603:10a6:803:137::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 12:30:47 +0000
Received: from GVXPR02MB8256.eurprd02.prod.outlook.com
 ([fe80::6044:5761:b269:8f3f]) by GVXPR02MB8256.eurprd02.prod.outlook.com
 ([fe80::6044:5761:b269:8f3f%7]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:30:47 +0000
From: Alexander Ganslandt <Alexander.Ganslandt@axis.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: GATT characteristic for only LE or BR/EDR
Thread-Topic: GATT characteristic for only LE or BR/EDR
Thread-Index: AQHa5zMlTF82vRT27kyi/MYNVwq85Q==
Date: Mon, 5 Aug 2024 12:30:47 +0000
Message-ID:
 <GVXPR02MB8256E67B738C97EC57D1FA0F9CBE2@GVXPR02MB8256.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXPR02MB8256:EE_|VI1PR02MB5968:EE_
x-ms-office365-filtering-correlation-id: e092bdb6-8eb3-4949-608f-08dcb54a6edf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5agIjXQW4484wcwW+HN/7JuwYvqkYHdRkQFxuP5FUawyb65hOqqUKDbiXW?=
 =?iso-8859-1?Q?OklHS/z8f4F/00maiUOveYyACsaU4E82TtCFZCK2YHW+s9e5G0rJxT7VbY?=
 =?iso-8859-1?Q?nyvb6dy72jgO19mfRAyBHB4DogmX/pN7F7h/5p1mbD/sAbLaOoywqH5Rle?=
 =?iso-8859-1?Q?2MFOs40LlUAY2yilMAWi5nT5i/tu2cgsuwXt0JOtVATiL/FobP9MLijtVo?=
 =?iso-8859-1?Q?hTPL2ClAznsDy3GUPWEPgjXQXjtwC+1CmIdB9o/hpQAzCh3Xi4Yey3q5M0?=
 =?iso-8859-1?Q?U+VQWVwe0gchzQQ3ByrtIuazvwGhQSG/lJ8VCZgoeEP1zOK73kxEIcquJa?=
 =?iso-8859-1?Q?4GpRQaAYOUB/NaekvGu3/B1edUh5OiawKv+DxOmU77Z6aH75pdfqV5rGnU?=
 =?iso-8859-1?Q?Ypclg2Vcgqkumy455dg6JehmVt6zdt2+ah9jAuWKp3RHi9JojddGLwS8jn?=
 =?iso-8859-1?Q?hbGbKqUmYNfUhMB9u/sVccdUdnLfrHVlN3HIBnJkjn8MLLm0gfA8FUPLMo?=
 =?iso-8859-1?Q?y3yetpHMixJsOH9L8Rnr3bHpwFeGjk9gjnFUOOL+wsF1GwPXlO0Cf5kInY?=
 =?iso-8859-1?Q?M2GIGd9Oa6S9Hr3VdJ//if1F6VeXUbT2ey6RGILmhf3FZ0fqHqwEW4STWo?=
 =?iso-8859-1?Q?qlkejj8YYuXjgsI7K3TfEObj+IYUrYAWSNTz9m3w83dDW509d7Enwc988X?=
 =?iso-8859-1?Q?CstLzJtFXfTSomkLP/n3b7jsE1KBdqWq8GpAnoq67lR7NYzv91dSA3uyds?=
 =?iso-8859-1?Q?H48JI5+mC8Ceg1kUGpaRysxADhSlrYI9tH/x6odyfToAhdA4DKLx/WLSA2?=
 =?iso-8859-1?Q?FWCWiPKbJlw9mbEgBEb8UD5NGcrE9FIidhXbFE3dEQ2uNJAgcw8FWZCINt?=
 =?iso-8859-1?Q?Z82h850mpJVtZJjPuJooKNyuilrAYfhijKIYO07DQ22G+P9tmasjUYPrld?=
 =?iso-8859-1?Q?Ued6lIwouIj3fwgeNYDJ4G18vW+M0cKAiPNouiGjReiWQlTEFuu5+sy1mR?=
 =?iso-8859-1?Q?dCX6Tcon9QNKJf9emlyj3PYhjvZvmJSQHlHBS32M4UrYqPrn4i+HoQYOT1?=
 =?iso-8859-1?Q?Wl3Rt0BN4iKHlRUAkqFsyFjPkry/jHu9Zrcg4a64rrpDukYGxhz0UvW73K?=
 =?iso-8859-1?Q?pfv8iT/V3hSifasiroLBUkLAgyvUIqs/adEIhhOndvX7ThG5NAUvx/nQXI?=
 =?iso-8859-1?Q?mSnRDenATgRmXpjCXyDNw3tR4YofP5bMoX2zPlbJA1Buu/65C9tNhcH4Ez?=
 =?iso-8859-1?Q?521us474f0pgneT0GyhQGqtbYCU5SpxKHb9eKw50U4WYWZ2ZXD47MeLZiM?=
 =?iso-8859-1?Q?FdpxjQxv5wLhFH0Q199bfCF1cUqbjdabij7M0H/u3DeK6eqbjW6EmBQcQ/?=
 =?iso-8859-1?Q?WLLWZ9GYCaPIIrCwRNHChwKuNRi63Ij+iqZ5IVXtyUem0NYzRc/c8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR02MB8256.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gXnBokbnXJu2tqX0Oh/vH60jbblMAMK0L6u+zqJBq+RSNJ/IDHwlriguuX?=
 =?iso-8859-1?Q?QEPtWxzO8oLSkBbqdeHAXWbVrdMSI0cH0s46bcK7jYtn+kgHpzcxSp/TMG?=
 =?iso-8859-1?Q?RkmFyixGl8K/TGFW9OlsVlLn8njNqyKP2IXUx8gKdKWTgMDL+2i+iLGwbQ?=
 =?iso-8859-1?Q?aT8YYGSbAmN2Bn0COgByzO0qaWVHNHdpb5uvc2jx01e4Ks7kc6WtriXWsI?=
 =?iso-8859-1?Q?D570kV6vv4dSkQSQCcEvGgv8Umyp1f1DsPdlrC440G43pILau/QhWnaCLB?=
 =?iso-8859-1?Q?7IpV+1hhRfYgJ76sJ+9yFlbymBrWd52//JnE4X4fyM9+iSaYugRbS+mpV3?=
 =?iso-8859-1?Q?ThIUsh+NwFFoXN+USdJENLrxmlH9q72LCtF++mkrUu/e52fanNollTsxIq?=
 =?iso-8859-1?Q?RWwjFILdgvBDLR5LsAf7WqgPEZXFZrt64xi4AJY5Ynr+DOzf4VGYcFA+To?=
 =?iso-8859-1?Q?BHk0kcR4ku3ODKj6TH7YszAYbdcJuCmBjv/cB9l9IReZedPR0Iee3QaZl9?=
 =?iso-8859-1?Q?yJPt1z53a0YeQ10AP7dYCDU9ORHhMvvUWMCNgMayS4EjoBkjKbNtnz4tHg?=
 =?iso-8859-1?Q?vx9VUoIM9M6xv/+YLQElNVqbY1Pv5LYtjv+VZPoBBYF7/By1mByS7BDjue?=
 =?iso-8859-1?Q?z18yLA+0h2DdvPwBi4f+p041+Ug8xFpVSUIPH5qdYrjQk67DIuqMdvx/lZ?=
 =?iso-8859-1?Q?m+L6HbhLq6D+DAAJQcLEwjA2Jv1dxP62ebdm0agZp7tlrA7am+2Ru7FVHM?=
 =?iso-8859-1?Q?XLaq66yW+r4cyiAl15Fkq8QAKy/IF+HWckijY/+zAJ3qce3BJzAiKvbAu0?=
 =?iso-8859-1?Q?SoCEvfgFi+iw9AXpJydsUfw/8YIF1hasckJL6rXd8MqoB2m9LZGjgraQ5Q?=
 =?iso-8859-1?Q?zLv7K3rOtQ/wkNafToANH8LwaX8ADI4DX8mwnNI+2hTmXbQ+jRTVP96alX?=
 =?iso-8859-1?Q?RIloDuls8tJZ1OsLdPMlVhBi0Q7VsJGAAvAAeACgFhB26DTL/sV4hoxqoY?=
 =?iso-8859-1?Q?nwUYMntuMZ7u0aa0pIvp68Oc6XsKSVpGce5sC26QEcWP7cammqSxiDJ0HD?=
 =?iso-8859-1?Q?qohPpv2mB1Y2o1r78cF0Rsx5/yKjM5uLpM8Fp5i+j6NbNUgui+zdjnebmZ?=
 =?iso-8859-1?Q?t6/whAXh7AfrKDU1Cm7ALwoHB/8wNzEnVZWpnUNOyEjM0Dw9zSTa0U+qow?=
 =?iso-8859-1?Q?iGfd8QRcm3aI+W4DWDrcTnQ1+nRglX+Alfm079LeObqgJMMbntOY73UYtF?=
 =?iso-8859-1?Q?OPW9+Ok9uMj3qrpkaLI42/oAFv6lihNVHy4TKoy7ecxi9Hjj+HWn/iFL2d?=
 =?iso-8859-1?Q?oPrBf8bW7Y4XNnBq4cjrzOOyvrkekM+o3aPPrbSYW3fBfYgQFwUBYFQdWu?=
 =?iso-8859-1?Q?FE4qeGLSlSH/O7scE33uVTOKf3W8zCO+u0ke8kWK/FpCafRnTeDgkqeOSZ?=
 =?iso-8859-1?Q?O7WaSu13h9DQeoxpE/WA90Yxr8gZLDRhp0Q+ZoDjzj/MLZR84Oqhg3hjeP?=
 =?iso-8859-1?Q?q5CykHePv/rg44KftA77MqzOwPxz8cAdSXiiLaQ0T7+Z9OaneOA/UvMsAC?=
 =?iso-8859-1?Q?Y0nIKhQoWG+VcwY/0pas2U97/fqfyXgAkIjwq8n4fxLEzJNQVXWFuYBte/?=
 =?iso-8859-1?Q?GYVfdcp06+iz4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXPR02MB8256.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e092bdb6-8eb3-4949-608f-08dcb54a6edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 12:30:47.1520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JkdgX7f6hyZQVWwvtGGfPBjH/wRSMsees7m2mIEr6cezJHd6scEK56kdeNlAPavNGUkVHlveFNeDpEa++NWmlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5968

Hello!=0A=
=0A=
I found a previous discussion about this here: https://lore.kernel.org/all/=
59CDEBDF.3090200@digi.com/t/, but there was no conclusion. Now I'm having t=
he same issue 7 years later :)=0A=
=0A=
I'm trying to pass BT SIG tests but fail on two test cases: GATT/SR/GAR/BI-=
34-C and GATT/SR/GAR/BI-35-C. To my understanding, in order to pass these t=
ests, you need to register a GATT characteristic that is readable only thro=
ugh LE or BR/EDR, but not both at the same time. However, when I register a=
 service+characteristic through bluetoothctl, it is automatically registere=
d for both LE and BR/EDR. To verify this, I use gatttool with and without "=
-p 31" to connect over BR/EDR and LE respectively, and the characteristic s=
hows up in both. Based on the previous discussion, and based on reading the=
 BlueZ API, there doesn't seem to be a way to only support ONE transport fo=
r a characteristic? Is this conclusion correct?=0A=
=0A=
If so, how can one pass these BT SIG tests? In the previous thread I linked=
, the "solution" seemed to be to write an application that simply rejects t=
he read request for a certain transport, but this seems like more of a hack=
 than a solution to me. Is there any other solution?=0A=
=0A=
Very thankful for any thoughts!=0A=
=0A=
Best regards,=0A=
Alexander=
