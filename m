Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021116.outbound.protection.outlook.com [40.107.208.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C65B33DEF4
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766062869; cv=fail; b=mT4pk0VRrGFOhXZhUdL71MGRGSYcLlK1YwENBbyEVLXIIVyE9wANiAObmypE6bIwMLQeb0GwX9YdzvyQmDL+8WT9w7Bby1D8sRlGgJKOzNkgDEB2dMoL+/l0uhErsHM0xtQ8g3ax26hLlH6t2BAjmYeXGn/B0KnlrxiDx5RDjWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766062869; c=relaxed/simple;
	bh=VWu6O1cG7g6UG8YdAokAzYJp5naQ3e30uIsgxPIMZaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pIiwwguH+8g31f7og4rYUlfJo9Ab0B7bjuY33X9PlfrdqgC7shvxFNapWzp29/Kl9YA0x6rAfjWsDGea+HE+3Oi6LM4ch5XksH+7lJ9PHbYgjRepBXigc7c7I/30RV656vSCmaLM0xlOOVr8SG+g35c4sEtNqCk9vCdWK1Eov30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com; spf=pass smtp.mailfrom=roku.com; dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b=dj8CGN2V; arc=fail smtp.client-ip=40.107.208.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roku.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b="dj8CGN2V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZPBwYzo/ftPuQRjT+snC63BgE5e5sqj8eOyl/j9dP8umgOSTLkoEDaetyEXY2MhubUmbWZuh8ElmWWKvP/iDnZj4CHuMIf1Q8PjQ42yvMhz/3Ib7hwaC1c7xQgbaLMvclfVc3i6HreVA7H/K7LuxRTYKjCn1B4HwGfJpcmfVwi9hu0veQ433VIx4h4eTSzzw0DM7FswBINSRsR3q7JJfHm4HcVxuzzD/iKSLC7Cuap1xPKFuZirfCmzyPHxaHcCMOVO+MWWW3WWuG9u3BZzogUU/WZuNOP7GRJ8kBWV88Af+qdVToqPQdFF4UaCalWLhZIUc6Aa8vaXGE8FoXosDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yqitAkfgXLOeSKgMfiib5Ix7hVCWIi+DXR7aIztZR8=;
 b=cYyFD2C4wUUTd3Cycion+Qp3z4LSDS//KUnEi1Xl4Sw6Gd/admsgApSdkP6d0SnLQLNbvDhQp23oUoxvpM15H1MlwGDbIblksaat5RKFBj+qiKq/lYjONhRWfKfAwQy53Qtfx/hen0EMzNwVwufqIelPFXGTNaT5zfPyatyUN8MyY6tSZkpEZpGw63UZSL/2CTfWNTsAvxy0hYcehV7+T+8LqVRFeCjJL6ns8zfi9pGhLDQp4ty8stg57uevKlA0peNBaUi9krTc8uy3xmTig9iSxQY3elnoVHbcjFIgQy9VzwqzcgaeyTF3FxnGYdbaFlzzgmFUNZWJrJ4Ppy25RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yqitAkfgXLOeSKgMfiib5Ix7hVCWIi+DXR7aIztZR8=;
 b=dj8CGN2VF5wPhN6cVY+hyHR99KoMmiPVJnl0UY27siTHoPMuDD7si0Hip4Fl6Ua4KGbTPlJy8yadC18ibC8B59qsuvFxwXSUBop/G3/bznX7cgH6t+UQ0nJzIX/X57b6SsDgIPnZFMSRh3q1j38Y0T0cfQlQ1JWlVJOzF9aXAqXkzv49lWg6DZNaJeU2EzULgzgGeU+wEoDUiPJwf7NYUhDEHJR5/Da5bUxZcSSWjcBx39FTYqY0bni8fUJ89RPZe1B0734tA9mJXj447UHKkxMrAPeERbB+5uIxu+garXpqSRgoWynpntWQYQgiEbiOoSQRhnEDxoMYjBEQvcjocg==
Received: from SJ2PR01MB8282.prod.exchangelabs.com (2603:10b6:a03:540::13) by
 MWHPR01MB8754.prod.exchangelabs.com (2603:10b6:303:289::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Thu, 18 Dec 2025 13:00:56 +0000
Received: from SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f]) by SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f%7]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 13:00:56 +0000
From: =?iso-8859-1?Q?Stefan_S=F8rensen?= <SSorensen@roku.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH] Bluetooth: mgmt: Fix TLV parameter code
 type conversion
Thread-Topic: [EXTERNAL] Re: [PATCH] Bluetooth: mgmt: Fix TLV parameter code
 type conversion
Thread-Index: AQHccBcjM8Pw6t9m4EO6Io6Sf8x21bUnVvqAgAAEjmA=
Date: Thu, 18 Dec 2025 13:00:56 +0000
Message-ID:
 <SJ2PR01MB828254F766178796CA611E0FD8A8A@SJ2PR01MB8282.prod.exchangelabs.com>
References: <20251218120826.533081-1-ssorensen@roku.com>
 <9831beac-8f6c-414b-b160-5755fdb6e87f@molgen.mpg.de>
In-Reply-To: <9831beac-8f6c-414b-b160-5755fdb6e87f@molgen.mpg.de>
Accept-Language: en-DK, en-US, da-DK
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR01MB8282:EE_|MWHPR01MB8754:EE_
x-ms-office365-filtering-correlation-id: 2a221e06-e34a-49fa-4ff0-08de3e357ba7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?c72p5z9yyVR/M9Hxt+k0yeRRAjddQI2vEvDccDZgGQkxt90jUDSkxrUX4c?=
 =?iso-8859-1?Q?Nl5x3cYubB0+KZU/JloNJU+6+AR8zaesdprzcZSDtkYnswDRFeDbsKMbwi?=
 =?iso-8859-1?Q?FQXe3twLUDYeoPt9zB9Bd7n+8m+g1bRN1ZNoAjJYjBWvUNqFhLeXF76URZ?=
 =?iso-8859-1?Q?C0JU6mjRNYFAzfChsY0K4c2dq4sStCuZdBgTMJsbpEI3TO5m8DJQHshlmU?=
 =?iso-8859-1?Q?XxyxJk5Zr3/SMgqyu5XYQ1rbyagozR2zwZuDtX3Iy0b9GQgv9m3JePMbrP?=
 =?iso-8859-1?Q?hhh6Qfso5GDEHl7aIwd9ZgLnKRUfrbutlpKagfpmlM+ftWYNJGn3CLVLRf?=
 =?iso-8859-1?Q?lkyTuUjy7ghozW7pBFupgVHPmiQmKqglL9i3RRMbUzjzWn1hLreUfTbTLB?=
 =?iso-8859-1?Q?wXBa93gmc7802sJtYK0gbClzSvJZJ70Wia8et5BmU3aRpJl6YMOOtBY16Q?=
 =?iso-8859-1?Q?4ZY6QOaaCH8SUnzZcaGUkFi8Aj4wGxgECE79i37GQu9vQ+v3Q77NVlCynI?=
 =?iso-8859-1?Q?AV1g1AQKr5FyfpLJIDy0xm88y070iOzs0BNhSnsKMO5+d23gIIt6f3rkHw?=
 =?iso-8859-1?Q?eG+TRnVlj2qUX3jAhQD+UXe+0XqfbcuWT80Nz6X+L7DfS64aBG6glEo38v?=
 =?iso-8859-1?Q?N0ms31e1FuQ2V3GEVeZIMZlS8aWm6xMP2rvXE/WPJA3/pEJyn8aSdNmiyV?=
 =?iso-8859-1?Q?XElhlOw9wUYHqnz8HwerWIrb1abTYYKqoWBsVxtEknDbQkLuC0FQnr8YA+?=
 =?iso-8859-1?Q?WK3HMQMeu1g6qiUAk5WIHfkIxNSdpmvzEN5ELA6HCYkl8He8D5QOfohB0P?=
 =?iso-8859-1?Q?u3tnjjLzIzTRff+L0vWGAs6jkhFga4lPzsp08SQPYinqYZ+mcnqhHulYm0?=
 =?iso-8859-1?Q?I7rCapBcQakXYWdT6DWF3hFwXVBNG1vmGkwxzrl8tVOC2inPesz4Ie7ao8?=
 =?iso-8859-1?Q?wHpzp7UapMdNyr2xGb42auU5R5llyrJVrDKZgq0CKW6X7ccimRq8g0uL2X?=
 =?iso-8859-1?Q?MV20sGFWWJM0OALhJZC3UBRLRyArBhqTllBdp3j8JQ6t7iWhpiZMdSlACU?=
 =?iso-8859-1?Q?UB6nT9r2ERAsSHY/dlmS8x4ouIxRqD7hWugmI0pyLvvAeWSqgVadcEs4u5?=
 =?iso-8859-1?Q?ftlCYz549UiNjW6QUxu1ySa8uyl61cSDNEmBy2TSz0O7+DnMsTl4D/5+U8?=
 =?iso-8859-1?Q?fkS5Z7W0Qwf3b+24ROzXhOqcTw3OMyIeJQz92Pqp2xujmxpXkLJ5Zp1Hxw?=
 =?iso-8859-1?Q?kwUgVQGaN1k+ql5UrbyYiypqCLGjGhZaoZLdIuJ8u/mDcX+22ENdrDpxOB?=
 =?iso-8859-1?Q?W8/ToiTKfgmz47q5OVfWpbvIP4uiheV3pNQDfndedE20wNVvp3C0FXmVXj?=
 =?iso-8859-1?Q?yf8SwXrIIasPP7KiKTa119IOv4FT4eOHcD+udAlZeEOkEgYffhpTiv3Y99?=
 =?iso-8859-1?Q?6Nd0PnHCmlCQi0ctY9Nxu3sol8f9t9ua8b9EeqQ79NKFhlOEH3ugHIJYFX?=
 =?iso-8859-1?Q?1SLBRb3500P7opuGrxB74pU1yF8sK4NalfGRsoBt6GdeEsnjIJ0//l+sxP?=
 =?iso-8859-1?Q?oYzawYOGCqSSbNHBAsv00xJXfhGG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rPNOYWonLxSAJpDqFqj9kQ/s8jYtA5mXd2ayrrjvsRzl+/Q7ShrFriCoTl?=
 =?iso-8859-1?Q?jhMd9ZUJOikvKBqLEi7dUmfK0rBqjwS4ulIpZkmofTwqUEgt+ubFY75ORV?=
 =?iso-8859-1?Q?KQZSo/6bo2K/fzUyx9672aPXw4EYKw9hf1GahVwURa4U4EmROF5UqMOlLq?=
 =?iso-8859-1?Q?l3A3oWmUWC8NPDCVqcLJEECaMkdIP1PaX7UoYMm6ue6jL5HwKGlMOn/AuF?=
 =?iso-8859-1?Q?wjvzTODDen9Lc68vzGUxmaAvw95hWdrT1oStY4IXXWpVj0+ovqMn2l46ej?=
 =?iso-8859-1?Q?U2yBSehukCYThUu/BvJ4yQoB6e98GQrI9+xx60WuFa3qUYVPIK+LuA8BHW?=
 =?iso-8859-1?Q?rugRiZG8ZK/Tampa388dJGnJIs48wtJzzqvj7vv+y24GicltKQba/N9Jij?=
 =?iso-8859-1?Q?oYwGOprHGuwSuUQDiWhb7e1eLfyKyWrdDH9ft81d2NpskdkQ0+MQ5sGOC2?=
 =?iso-8859-1?Q?e/VLkcywkya1PwTDkaczNVX8IoWBsqkyi2BO6AE/K8aQrS90ooOx0ZJnJw?=
 =?iso-8859-1?Q?u90aWjkth7mEMlzhNxFu53DrHFApYp9r5joO07jibBAXguo6ycjP/860bp?=
 =?iso-8859-1?Q?9aa7kD0sDIVxAM728X6fnWTzseAEuCjPDPKY0cvST8JxyiSyyXrNHkna2p?=
 =?iso-8859-1?Q?c/hAKt5+fHFmumygrPu7/MVACJF0sKqKBaHAH0lvbQ29qDFlfBLCb6vTS0?=
 =?iso-8859-1?Q?GY8Lfd9UyUz9NOSu+MfaGMPJ08l5EsaR3FZwlhuSgjdBmFy/2Q6NjGh6rO?=
 =?iso-8859-1?Q?T5/Un+XeY4atMfICWDpVG4S51vsKAbpBCOiQSDipuEpoApGOePQYMkU4Oy?=
 =?iso-8859-1?Q?b6oVg8fmT/UcccfIFCunKBw6Gg1sGVk/ZzrCF8L8mn3Rwct8xV3gnrn2tr?=
 =?iso-8859-1?Q?8Nxfp2sy949bNOCvkt17RPiNmgNMqjZDs5W9mJDXrS+R5UUk8wL78Q0s95?=
 =?iso-8859-1?Q?fRKdcdjnyt9LIV+xvqI6VaXTxzLVRtBCr3khSLuW0gFIF087ejuk2GQf4d?=
 =?iso-8859-1?Q?i9Kj4qhVFNKb9K5rHD4fCURueBrD/gnlrdbRSX3sRQsL81ntNb7l+CcWPc?=
 =?iso-8859-1?Q?TFupZqn3PU8kUXBQgpVAUwa4mzxUx2Dkny2Ir4GyZPw3llwAM0Z3pmkTke?=
 =?iso-8859-1?Q?kDZqbRmrf6FlQYgYwNTh0PnXydCL2B/veUYnHig6nnRtLK5eyntympHNQK?=
 =?iso-8859-1?Q?zt+z7hrG7W+9Z/15M77x0cRDGF67G+UbcQx990Ea+7ZasAhHFqbZn4PGRH?=
 =?iso-8859-1?Q?hNUaKRm3bIKkQAVysahY2GsE7VJm0JrddfKPB1dmkZcRDwRkMQlmyy2CP1?=
 =?iso-8859-1?Q?3Qw/ERafFzwR3c25X0FyUTgUJPx0+Y/UZmGZlVh+jphPXOEzKLd0Odmv4g?=
 =?iso-8859-1?Q?LEofhNvVWl7nH9pOdUxAlq1ONjDgzo6aVDy65kXYtUBP6nB9cBmCYSitYc?=
 =?iso-8859-1?Q?Wr6ivkvG1QEh8UhUdN7VwuH+L9rf/UMdGg7LDeCT2gWWuKN7wXQkYx8J4K?=
 =?iso-8859-1?Q?PRqZpv/WdM/evrYRydkU4gGEYfqiT/cseaC/UG50e7uMRbAHznzrI6uDIR?=
 =?iso-8859-1?Q?9fcyM4FH+XzdxYG7xuZfE6KtDNCIddNncpIcqTiwsQ49jMbD7fmvhxHW5z?=
 =?iso-8859-1?Q?GcSb49ORdASQY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a221e06-e34a-49fa-4ff0-08de3e357ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 13:00:56.1752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JI8j6vTRjAML+7AS20arWSbVNKGq0LhtRuPK4clWt8I6y7feLLOwWeq5BJZd57ov3PhVtYcqcrTV2vFRGAMGdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB8754

>> Use the correct le16 conversion for the TLV type field when adding a=0A=
>> TLV using a u32 data field.=0A=
>=0A=
>Why is the correct conversion?=0A=
=0A=
This is the TLV element structure:=0A=
=0A=
struct mgmt_tlv {=0A=
	/* New members MUST be added within the __struct_group() macro below. */=
=0A=
	__struct_group(mgmt_tlv_hdr, __hdr, __packed,=0A=
		__le16 type;=0A=
		__u8   length;=0A=
	);=0A=
	__u8   value[];=0A=
} __packed;=0A=
=0A=
Regards,=0A=
Stefan=
