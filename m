Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.106
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794905413;
	b=Tx5NPpqp9IrjH3ovDuoJcGSvml8s2icMVhMXf+9bMYPvtBXTdvO4iqPLlfUX2FT5Bl96
	 vZlyUUyti7ob1E69txlN9PNWZs14OZBevtxaZClrn/JWew7qxi3B2pd5iOUwfbOTj7uLI
	 FLYvdLC82MnbxMPNZ9vdy9DTLhMDEpTZ49NZR6sKgXQKyqO58yPodiHtXWEbV+KUnsgDt
	 H5BVg2h7kw06DifyebBw2nASqugBoUXPlgcP1eLU/Md3PYmFXLY48xKhev3Oy4750TGrp
	 xr9SYILeom9IJs1KPC6pYmkfksKrWFLhdfDE4Zx7qjY1GmRtVGEUgPDKbWzmcrM/sXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794905413;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GS5eJmVJfZ19xpKsrc8bb3y9fO5Lk/6GYKUR2nLPuZM=;
	b=O2wP5Q5e6Rd0iBKxW4pjKL+GhhIBj9ORMfAqnfSPPYUiwHKvtdWhuRM8jZRTK0hejT4U
	 aliH0CaE58YUOnNMRK1IVJ+sy/8ze/jsFZRDmZIklU/OAINaOFSc61VXftVh1fNp2QZ2a
	 XhvMm1hsUlMpDEDdE9PCU8Nl9h3BADTHi7crugSBLFMEKE3hT3tXLW9DahMJaezelzBiz
	 fJQGKzeacEWoTaT6PhWDRbICt0YWwP64dY0Xq5BnxsKmYmCOhTwy+iAXypNXihclkHvS5
	 4cMJKWw9LVfCYjI/6RUSRPlK7WpkPQVR3UvlzpYokJyuJN2PezR3UXES4/lhT1vZ9fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bang-olufsen.dk;
	spf=pass smtp.mailfrom=bang-olufsen.dk;
	dkim=pass header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.a=rsa-sha256 header.s=selector1 header.b=JGADAqTh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.106
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023106.outbound.protection.outlook.com [40.107.159.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A6F606A88C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 08:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10A6F606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.a=rsa-sha256 header.s=selector1 header.b=JGADAqTh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENnjVtJpUkKlvgq2SxwxaZHh1d7fzLzOUZ2qnR1eiQAMSbR+ramwD1a7hk8tNALntZ/ZluWxokShgRp5bE+pLXH4vsAyRFqswfn69gbqESYP/eeKqGHLTTjLYY+M09GtpfwoWNgo7e0sbp/Nz70gVR8p0OCKDc0H6b80AplqMThLmIzaTSrGta8oN+lIsW1IvjS+XabXnT2ffXxyT4LJ9hAScnTmgeZO4wGAY5In47pwI4JufbcIzR/BcCyqzRdLv/4WH8naTc1KD/yjsYdq3pHr1kwUz85b/MwHB5T7MROLOJLSG96GFxLD+Yarx1EaybfDTA1bT2M0plKxYxXvIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS5eJmVJfZ19xpKsrc8bb3y9fO5Lk/6GYKUR2nLPuZM=;
 b=bDlIEB91el8QdiMIayN1D+vNUTrY85z/Eu4VtxlOhQzezdNyBmbZsLfA/AxGeo4OKs9CBCxBan5TYhbUpQuvLnJ44sAkQNdVktBLrZIxnzYuEN09XLv1asDytSUcWBLkncIg7Qb2NHIgj0Ca9etaNUhifoM+jE7vPnsdaFU2ylf9qkYs1bpHzw7mBTiSwuhB1gJzTtbm9J8rThb87f3LwcicCqyTLmkshGBQqKBwVo4jTKB69iWQ5OlWjhKDjUBb/1OHFVKNmA14KpPHb1qbgkXrECrKRAebiA8jaqPZM0+/0zTm5WDiszu/qqEyF3Z6zqS/qCSHcLvn/goUzIiQEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS5eJmVJfZ19xpKsrc8bb3y9fO5Lk/6GYKUR2nLPuZM=;
 b=JGADAqThHEaeeDbv0XE1zPBDvk5uIynKdVhDTpPPC1HZQiqVYUOyFgw1t8libp8ztxBUUUHr64H3ey0gpYITzANvpGZWGK1PdvFY74Ci+lVq6fjZMZ6H1nDfmev2vM1hDm9GX40SX2seqwnd4GC8lyeRltZ4RD4v9I8fw7/Mpxw=
Received: from PA4PR03MB7150.eurprd03.prod.outlook.com (2603:10a6:102:f1::17)
 by GVXPR03MB10551.eurprd03.prod.outlook.com (2603:10a6:150:158::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 08:49:57 +0000
Received: from PA4PR03MB7150.eurprd03.prod.outlook.com
 ([fe80::e397:f26c:9c11:ef66]) by PA4PR03MB7150.eurprd03.prod.outlook.com
 ([fe80::e397:f26c:9c11:ef66%2]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 08:49:56 +0000
From: Mathias Grelck Johnsen <MAJO@bang-olufsen.dk>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "luiz.von.dentz@intel.com" <luiz.von.dentz@intel.com>
Subject: [PATCH BlueZ RESEND] adapter: Set Audio service class bit for A2DP
 sink
Thread-Topic: [PATCH BlueZ RESEND] adapter: Set Audio service class bit for
 A2DP sink
Thread-Index: AQHddnCfHv77toMT6kC2ouruMpGqBQ==
Date: Tue, 17 Nov 2026 08:49:56 +0000
Message-ID: <7d8bc3183903a1016c6b69bc64dfd4f275891ada.camel@bang-olufsen.dk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7150:EE_|GVXPR03MB10551:EE_
x-ms-office365-filtering-correlation-id: 6bc98c1b-45a6-487b-4960-08df4487c198
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|261022105027099003|38070700021|11063799006|56012099006|261021123027099003|261021121427099003|10067099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|55112099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 ZaTQtRQdQq3vsvE01bBpRhfRV3WvBH2Im1Clariw1ynsP9k299mRBdqR6s+ytOm9+AEvKidZTIJy+zTpYiZhorrlr8denBErl5/XyTM4aP8qJJFVZzAZ/eb/d88DA+Uu9rDPnPUbj0q1+Aresx5sCGD9XJH+sQyGjsOUUpTHj5YuRxsJqUcSuDWIhQAyLqKVnxmV1qWpnl6FJ3DLmoFyXwcUrTNGJm5+Rf0HQ6HZ/UhaETeyqNhY0piOdoIvlCZBbW54bB6Yxl84hbnW901ki8vQVM8+gPHojtbFJKV2Q0lfpFvSzTMbghvmvADcoHo4nzQuRVICFkw/LpPHMMD1oo5CqnANMzt7WFL+Qc4NlFVTTlXUmE2/s3CtVYFjeLxCG/2pzExLFRAgy2by+4Qi4WKArlYl2YtOUKlEppKf+hFWjXqMN5d/lLvVA6qXYWsT6jNz5xe1d6bqGBE9/r1L9y2jhuTshotZY2nZwO46g+TuuwOLJ6E0PFJK4fp6jVCiDIfHsjiOF+sMTNQGIaq9PY2wQDHbo/FVYDC+fieyNcuYVhiGkLNWdar5OZhHtu3F5ccnNTrJrtplmyyvIIs8FjMfWA0u6tmXPRww4gDRs21Y5vcz+gwpMpW7lW8R3euGJOufI8+jnwO178sIncM0dpnzPLOsULz5K92hwuhAS4GmpKRwVsy7h1UOt7CNum9998E88hNxkD4tXCTz64H9bNYVRy/hyZhpnMDr6edC3hc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7150.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(261022105027099003)(38070700021)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(10067099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(55112099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?orSbSleKZwreVRMljGnUyBonq7rhsBvDMeYkyOYJI4+dUAElBkOv2+KHlOhR?=
 =?us-ascii?Q?HeV+zn586KM4SEJATpVVwl9yQh+bd0zYWq5R4v0Et00DGI2eDt+1IAT11f8E?=
 =?us-ascii?Q?M64oxtsVBI5bmNB/wuRuiy5gPAH5v1hWHOcJrY4n+UmcQepyx0DRIwE2DCUp?=
 =?us-ascii?Q?WHMzkVyWjMdxhTb/oVHaESDrNTArC+P49LFpvMVzryP86acoahK3czAUGgJy?=
 =?us-ascii?Q?nUBPTGELlybVCdpORdf9tj1f4ix+vyTL7Bf21dKr5uJtKjBu4nZjxKx3+6c7?=
 =?us-ascii?Q?BZHaFk77rtb2qciW4XP+Jf40yzxGr9DYjc+aLaV0ditkeGOIstW12VoFvK1s?=
 =?us-ascii?Q?a6tnvDzaa0qoRc5Aq26gG6oj7aQwgBuw3+74iiQfQFmFkO8KKngzI5fBMyvp?=
 =?us-ascii?Q?PUBuBQCxvpCgOdPMR8L1cVTx9l2N7QDyLmYrxOORGVFca0vM4i4HIz5FjG3K?=
 =?us-ascii?Q?9nicOv4t1VemprRghe5o/qcP6fvzkd7bMKw6372HyANxJxLPqUbuOolS5gDC?=
 =?us-ascii?Q?gL0hDo9Yhsxir/evoOGRZybDBD4Tc7RJqams3miqtyoqXGBjcIk/gmW0C83i?=
 =?us-ascii?Q?W0plmCtBOXmJaEs7sTNIeMu7sJqyWjf9Bnkmq4sOT1LJ0FYb0qVTdUK4mp0p?=
 =?us-ascii?Q?9n757H24ICH3bZnimX9zrunQ4qExQE/jc/3UjT/N/ueWuV3fVtWKBi5AUmuG?=
 =?us-ascii?Q?eYda2OnTXkl/koWSllBw2zGlUUGImnWW0Gasiw/zqUHpjtUzFoNBlf3NIUZ6?=
 =?us-ascii?Q?kVE7Elr3VICNWDvzbTW4nXCRiE6+XEFoOwONjHnpfns3LsiOkamkMWQvEMV3?=
 =?us-ascii?Q?IxBEy6Vr8K11hS6iRm6aDcpsJV3QxGGrdlRmDP2tdhbYCHelreXzubv8y+m5?=
 =?us-ascii?Q?xbuGGlQp9MnPA1XyXrNuhi0vwvfbIaEQ1yrhN/hGcOEenXEOJKspJiMByvrj?=
 =?us-ascii?Q?NqlJ3mHhkqdS/+skA47WrDfqSJ2qLzF1iBrGA3UgfZZs1llpWXowXWZqzK9v?=
 =?us-ascii?Q?UD/QalFygKMt9MCYZazGdFcEZwxf8oWbdF/GOrnGDX6IwOmwvFbbnwuHgth7?=
 =?us-ascii?Q?bJiyCZba+6ufxuKpKkPjomDPuVq7Q2xsMSxsB7wHnGntq2kRM3vPo1GxYbr5?=
 =?us-ascii?Q?CFOwLSAPekeVMTezxhJcfPmOxPzh5FyJJramfc7pf9TVoOHQ+X9sdMydPklM?=
 =?us-ascii?Q?gzGYBcWZweH0H1rKQ6Rjnfb9qRb4ZDxac6SLW9f6uSOGpRImkpKtJ232WoOi?=
 =?us-ascii?Q?mCr+n0D4O7dC+wodrcSC1VzaTFfzsbuFOeFWXRMkjMRXB2FTMvLCKtWJLc6V?=
 =?us-ascii?Q?ngyKf7ZH/Rrv6+vQbSVbzW67yC0UCemhID7dmyi+x1ucHz7qbwuXwujZBKx6?=
 =?us-ascii?Q?iXsWAf9YtmdzOjyjC+Y7HJMkyy0ogibkF2g0jVboofvPP4BSP4T0uMhqavK5?=
 =?us-ascii?Q?Bg4ZRLCfYyJL+x770QjokOdmO09QA65GYl7jtRRxpHZY2uD2JhDHmkT4t1ny?=
 =?us-ascii?Q?ivFwbyKqVMPDc18L7xEyq6bOooiicq7yGWAINDiAjYmmNrOK3ja9AvSL78IY?=
 =?us-ascii?Q?ZJPke6FcLm4jTrhtmnvftTv9AIXwbXYqkL/Ddhx+FUpZNvslNsQh9RQB8+Cg?=
 =?us-ascii?Q?vaCO/1fsCVuiLgCBTd46qF0mADtQeReYIc6624AMrCUDUS3bEDbvHI6aNzwC?=
 =?us-ascii?Q?/qgNq0fRdv54AAC4dpZswuAnmCKAYhyHGWSyvbCQxIxurHr1JhZNULCGG9I2?=
 =?us-ascii?Q?tbzsR4uhBg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <63D7DA1BC9A03C4C8DCC10214668465C@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7150.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc98c1b-45a6-487b-4960-08df4487c198
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 08:49:56.9080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r+NXc2/zdP1GIk7xqNB4I+v+ckZOg/7A6OwmraxWQUd85VOckeDIZTB4nuomH6gxkU9+Pp43TXKvYJMdpHQu+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB10551

From: Mathias Johnsen <majo@bang-olufsen.dk>

Problem: The Nintendo Switch refuses to connect to a device that does
not advertise the CoD 'Audio' (0x20) service class bit. It completes
pairing, takes the link key, then terminates the ACL with reason 0x13
without ever authenticating, encrypting, or connecting AVDTP on PSM 25.

Cause: get_uuid_mask() currently only grants the Audio service class
bit to HEADSET and HANDSFREE, so a device implementing A2DP sink
without HFP or HSP advertises 'Rendering' with no Audio bit set.

Fix: Report 'Audio' in addition to 'Rendering' (0x04) for
AUDIO_SINK_SVCLASS_ID in get_uuid_mask().

Tested on a Yocto-based speaker running bluez 5.65 with this change
backported and compile-tested on current master. Note get_uuid_mask()
is unchanged between 5.65 and current master. The speaker under test is
purely an A2DP sink; the patch changes the CoD from 0x040414 to
0x240414, after which the Switch connects and streams normally.

Note that A2DP v1.4 section 5.5.1 mandates only the 'Rendering' bit for
a sink, so the current behavior is conformant as it stands. Conversely,
adding the bit is not a violation either: Assigned Numbers section
2.8.1 defines bit 21 as 'Audio (Speaker, Microphone, Headset service,
...)', which a loudspeaker A2DP sink fits.

This is the same kind of device-specific workaround as the
HANDSFREE_AGW telephony bit for Nokia 616 carkit also present in the
get_uuid_mask() switch-statement.

Assisted-by: Claude:claude-opus-5
---
RESEND: no changes. The original posting (18 Sep 2026) got no review
and was archived in patchwork; rebased on current master.

Switch system version 22.5.0. The speaker under test implements A2DP
sink and AVRCP only, no HFP or HSP, so get_uuid_mask() never grants it
the Audio bit.

CoD before: 0x040414  (Rendering | Audio/Video | Loudspeaker)
CoD after:  0x240414  (Audio | Rendering | Audio/Video | Loudspeaker)

btmon excerpt of a failing connection, before the change. BD_ADDRs and
the link key are removed; nested SDP data elements are elided and
summarised in parentheses.

> HCI Event: Connect Complete (0x03) plen 11           #21308 302.177551
        Status: Success (0x00)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)

> ACL Data RX: Handle 2 flags 0x02 dlen 28             #21350 302.288211
      Channel: 64 len 24 [PSM 1 mode Basic (0x00)] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 0 len 19
        [...]
      (search pattern: Audio Sink 0x110b; attribute IDs 0x0001, 0x0004,
       0x0009)

< ACL Data TX: Handle 2 flags 0x00 dlen 58             #21351 302.288706
      Channel: 82 len 54 [PSM 1 mode Basic (0x00)] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 0 len 49
        [...]
      (Service Class ID List: Audio Sink 0x110b; Protocol Descriptor
       List: L2CAP PSM 25, AVDTP 0x0019; Bluetooth Profile Descriptor
       List: A2DP 0x0103)

> ACL Data RX: Handle 2 flags 0x02 dlen 12             #21353 302.293176
      L2CAP: Disconnection Request (0x06) ident 6 len 4

> HCI Event: IO Capability Response (0x32) plen 9      #21357 302.298185
        IO capability: NoInputNoOutput (0x03)
        Authentication: General Bonding - MITM not required (0x04)

> HCI Event: Simple Pairing Complete (0x36) plen 7     #21398 302.649188
        Status: Success (0x00)

> HCI Event: Link Key Notification (0x18) plen 23      #21402 302.672037
        Link key: <redacted>
        Key type: Unauthenticated Combination key from P-192 (0x04)

> HCI Event: Disconnect Complete (0x05) plen 4         #21403 302.675468
        Status: Success (0x00)
        Reason: Remote User Terminated Connection (0x13)

The Switch tears down the ACL 3 ms after receiving the link key.
There is no Authentication Complete, no Encryption Change, and no
L2CAP connect to PSM 25 anywhere in the capture. The following
attempt repeats the full SSP exchange rather than authenticating
with the stored key, so the bond is not retained on the Switch
side.

 src/adapter.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index ea438375c..ef973f56c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1354,9 +1354,17 @@ static uint8_t get_uuid_mask(uuid_t *uuid)
 	case AUDIO_SOURCE_SVCLASS_ID:
 	case VIDEO_SOURCE_SVCLASS_ID:
 		return 0x08;	/* Capturing */
-	case AUDIO_SINK_SVCLASS_ID:
 	case VIDEO_SINK_SVCLASS_ID:
 		return 0x04;	/* Rendering */
+	/*
+	 * A2DP v1.4 section 5.5.1 mandates only the 'Rendering'
+	 * bit for a sink, but the Nintendo Switch will not connect
+	 * to an audio device whose Class of Device is missing the
+	 * 'Audio' bit, which is otherwise only set for HEADSET and
+	 * HANDSFREE.
+	 */
+	case AUDIO_SINK_SVCLASS_ID:
+		return 0x24;	/* Audio & Rendering */
 	case PANU_SVCLASS_ID:
 	case NAP_SVCLASS_ID:
 	case GN_SVCLASS_ID:
--=20
2.43.0


