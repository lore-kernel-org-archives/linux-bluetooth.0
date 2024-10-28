Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2041.outbound.protection.outlook.com [40.107.247.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9EEA59;
	Mon, 28 Oct 2024 04:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730089685; cv=fail; b=Qa3SlgkP+NTsRc+Pw2XtUpuJAgmIzJaoPcP5hX5DOqvd4rUZkKavPEGsZUa7nAKXJ4PyAjt7aAcwndxf/n5dlEbLwxVymzFSRXN7cCjv8rFKrpRTQrIyt2bwQt0cm9mKHXe+a+wXzFTlPb8hMdxM1sductYI2kjHQYuZhEx209M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730089685; c=relaxed/simple;
	bh=G11jDw1bJZOTHu0P/j61e50ItQCa29Uk7739D3boak4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O15g+QR2fpnvHQwOINuXNKg9DztTrhOCM/dKbH0pcVMZw+VUOQeU0HwCFhr1TYtxRZs+UWWN2GeQCs0qwfSxDjaenoCAqcAqutC+yT+C/aUY+9a7NdvduS4MwzO/AmhSHAbcRjrAPDmZc+CVweaggG78H4E+9+EW49BmjuV2IKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hVczwnsC; arc=fail smtp.client-ip=40.107.247.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hVczwnsC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=By0HuJZVIl6oeAtPS6UvjK/RR8rOmXcJSo/T7YKHEKFL9XhdYRVefHSDtdIi47sovHPxSmbjnXgpqw1k9J/PgaDkPb8SLylrGXsm5iiA5axSTA4U0sSsU5evq9fyECPEMZkbfvnj/9zXiJvw7mGUNgPH3vlfLYUB0lnCC4g0mIf6+BznwemNWoM0kGkxNbn457e8t6niijQexQC5pd5YKVLg2C/J6iwo5NYp87LmeigyeSQM0KjkrJ4IBjKbvZfLn83IpQ7sbRo9JWI1HIs3vCLr7SBoJrrP/dDfm+dSdwgKYZ2rFKuMB6KdjV4/4lzWhkz6hJBZ9YHCF0Cen6bMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuNcvemUTwAlCHcMK014vU3QAfiYNthku1tWUtEyDP4=;
 b=Z2TC9Z/peMfpq7ukOmslis1ORrYbsv2An2ts3jK4oVu4mP5NHKR7/K4gHuBY6ekxOAWXGI9kXNo3Vesi0uMsUuKksVQKFPmuf189SQ4FskTu68ToV+5yTyg5zmdN3Wt29dorCFUVUPuGdTiLY9fF32HF8XKa8XyfIZKiVpEAc0db4Grq/OeqXuWNdcLQRnC5pA45aqB9ildOa0/7MqhJoWafMBjI68xqb1TbO9VpYvTwHYC0/pw58u6cA1qNvgVY3GIEkvgB64kR8w99Doppx3bZk2LJTW3Aw3U260m+ZidD4avpev7rXpblqbAQxI3DS+uUqYkGWpTY6v9Pw56eig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuNcvemUTwAlCHcMK014vU3QAfiYNthku1tWUtEyDP4=;
 b=hVczwnsCWJNM4lCEpL/+P5FqtFytaDEmzhQp27eXzmuS2MKbBk1fvUBiWqItAU+XsBkt3dFGMHSlLc/3elSfN7lf3bAIfeWeK4+B/8rcMeo/THc4z/tTjmV0wmmXOjBhmmc32UWhOBYuIzzxiRBqk9sorFJTdlFB7LGCLwOApmDqK83STNMa7B+i+SX2D42avlGYtgivcV9mdxL/hoIuWK/XI825vWc/EtMPaCLW4FQbRkyQ+8nZI/i5gIujSEwK5CNc8ScVlZtutapp8PdQnhgOSOPwYoKHBMatAPe0qg392PlyqJVOCV+9Fhx50qE9EZ8QLoCdam7E6MDyO/EKxw==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AM9PR04MB7698.eurprd04.prod.outlook.com (2603:10a6:20b:282::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 04:27:59 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 04:27:59 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>, Marco Felsch
	<m.felsch@pengutronix.de>
CC: Amitkumar Karwar <amitkumar.karwar@nxp.com>, Neeraj Sanjay Kale
	<neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org" <marcel@holtmann.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, GEO-CHHER-bsp-development
	<bsp-development.geo@leica-geosystems.com>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Thread-Topic: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Thread-Index:
 AQHbFlGi4L5ELajEYECFBoJDru1aa7J5aBLQgAAySQCAAao9AIAAIGOAgBV25oCAABNWAIAAK2IAgAE1RoCAACn9gIAACuYQgAAFzACAAF/eYIAAHNsAgAF25gCAAAeCgIAHLv0A
Date: Mon, 28 Oct 2024 04:27:59 +0000
Message-ID:
 <DB9PR04MB842929186683C1DF13DCBD92924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
References:
 <DB9PR04MB8429B4535422D3AE07D8EE79927C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <3fa35cd2-e52c-4873-8a7f-db459b016a97@kernel.org>
 <2b7f61a8-e91a-4b32-be1d-753a19e4d81f@leica-geosystems.com>
 <0d460226-4ea7-4a9b-a119-468343727996@kernel.org>
 <20241021064129.trchqa2oickna7pc@pengutronix.de>
 <bb34f4ae-92b3-48b7-b0d6-5937756cdbb9@kernel.org>
 <20241021102558.rfnz7nxcg5knibxs@pengutronix.de>
 <DB9PR04MB842939900805C080F2CC32B2924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241022072311.ubh2sia5lwgvebsg@pengutronix.de>
 <DB9PR04MB8429657FCB48ACAD74FDD471924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241022082256.nzfxqp67tdaxtn56@pengutronix.de>
 <DB9PR04MB84292445D0FEDB8211ED52C3924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <9b09774e-d0ed-4c97-b6a0-e976580b5bb5@leica-geosystems.com>
 <DB9PR04MB8429CF700571FE42C997FB9C924D2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <1b8864e5-0ec7-49c4-932a-89cfbaeacc9f@leica-geosystems.com>
In-Reply-To: <1b8864e5-0ec7-49c4-932a-89cfbaeacc9f@leica-geosystems.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|AM9PR04MB7698:EE_
x-ms-office365-filtering-correlation-id: c3693c00-bd49-4eb1-de82-08dcf708e73d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BbLMbZmF/HCmMGRDW4i+skY+JTkkxk1E3+up3w26b1+f0rS/4+fWHY8PWOA9?=
 =?us-ascii?Q?DLUVi5TgQtKNeWnXcdC/jHh7rYwVh9YFRffCp/uV1/wfB39s5YeIX13vYj5J?=
 =?us-ascii?Q?v9Ah+WRJbA7UXnWsh1ZwCQ0wzBt2daYASVDLmdO2vhwUJhxiUkXIYEl4VQ/R?=
 =?us-ascii?Q?pH8FypufazF2lLDDiOZAJUpD5eHHGG6fmHWbpcSWsM1lEQo0uvKabJg2i8qG?=
 =?us-ascii?Q?uXe1N3Vqzp/K/1He0Py45kZO55S0PrNIa/GzW6P1woRtGkg1FWBZJmbE9l0Y?=
 =?us-ascii?Q?gC3NtMmwVJ6Rs1c183FHz2coZl4Uh/BCjhRMaKBmPPz1DXJTTSBIXL3LtCJp?=
 =?us-ascii?Q?eVYiL3BlI3kX26qeuj05ADyQ7A1YF4WIsVvf0E7Qu1s0aOJPAFvzHtQDrrJ4?=
 =?us-ascii?Q?K+ITpwh9+xBScI8VFQmhLohAbR0pFc6kKfC3eD8/wcMTy00VHd6AZR8ur3Ya?=
 =?us-ascii?Q?y1o2fqVHd33KeY1md9hhPMAbslqMKKOTMZdRhN0eMgWJHvEhj4U+/CcAzeQc?=
 =?us-ascii?Q?dsWI7ffGiTQvT9QYz7dUkMDOaxo7phyCPpG1ofRcom0dKkX2S4aH6p+xpKuQ?=
 =?us-ascii?Q?ybB4/lLhahqKNEpt3Zwe7dK2AkCIZQ6uGxUSeuH7EaB6CHHSKnejhyRk3kif?=
 =?us-ascii?Q?ceeR1tIIvJReO25jEUxUBcl7/ykkbVXJuF28KR3m1LN1BzuAEYhFAbTS7GS1?=
 =?us-ascii?Q?AjbMrz5SIAL33TA3w+xHPyw1o4V9/8PoN/SoTNqLtszVg49RILnOwbS32n1q?=
 =?us-ascii?Q?3OBXTpIem/5bOjwHwJwkBef1cIdiR/EQC9fyYaPm5n4kcQj1cgMTm3r5CrKv?=
 =?us-ascii?Q?JnPkl7uugQZtcbwWXp+JuK6uWyr0ZCStGw4y8mqsfBJJdxGi8Ge7looJ71gR?=
 =?us-ascii?Q?TkA7asiWRA6h3uldkcfj5qJ/hHO5YKb63EnisoDcD1fg9gWbg8vap0GJLWEl?=
 =?us-ascii?Q?QYWllBZc6xvsYNUEECjI8j3s1p2zcSh1jJ36guQ+BGs4zGzFAcydLlzFDmA5?=
 =?us-ascii?Q?YLH8+N+yuyK0osnkVFMNz68Jo4nW0Oi/naCnrAdESn8/Vw3JSp2rQ175Msgs?=
 =?us-ascii?Q?FPAUgyELhYMYRfOd7X9kJcsA7tiYBiAX/rQVr8BlszlDH4QQzifSv1UDuNDR?=
 =?us-ascii?Q?XBFrfVzmhc0ftNX5KeMWkJfjDNAfZiz99srYC/8ppeAJ85p37GGxcXlNXPkB?=
 =?us-ascii?Q?Iqf6Jda7rOqcXx592PqnSsT0Xm08XVaxUZJ3FwMt9zvF1i0zlCQVtsB3+R6s?=
 =?us-ascii?Q?PRe77FZWJM01d8jQ4L+8G1rxxorZK9ccQzHtkjgW2u/cGyfCCtl/5ZNPUtob?=
 =?us-ascii?Q?3KU6jCeLDX6fTm8YOfAZzkF2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7C5LV1hra0MpyJdukvLQSGjrCuByUUC8D7LStrKDy4APRukdUt5QWJxfDEBf?=
 =?us-ascii?Q?l3yg7PeQQ33EIQj8nBKETeJpJx51UZocfr6w8QWjybuicLthv4+QMV6uwi8H?=
 =?us-ascii?Q?StmKNMDavGPhPYHPRHI9a5q08u5iNO8VmRVJQu0ukNmajjveqcGBIVoN+VFv?=
 =?us-ascii?Q?FzpMpa47kMig5yhhEn4E5Mcd14ATNhsCP2deD5e0QQ9liC7BBjUCyYtu8Zcw?=
 =?us-ascii?Q?C8XiXy+Zkr5qf9fRNm3ZpOKtW8aSgErvXVt562j5vRo/ASG2HP8fxBsoTR1v?=
 =?us-ascii?Q?1wNTgOlVY7Ced3XlIp9ogAw2w+biiu7hCpzHwMjmvoWc85/TfuAkfvTUdW8N?=
 =?us-ascii?Q?GDrsu92/rUon/FNYMnO9ccWri8uX2ZICmQWqEY2+gxNcZznK5vb29ZLAkIrv?=
 =?us-ascii?Q?wnj2NNG/aIDO9t764WJ6595jrFWLaxk2fCsDlxJkuYbg0v488MYmN824W9Nr?=
 =?us-ascii?Q?6PVQrsU0wXItGh3QAnDqBh0Ipmn62Dgy1KbI5n5zrnWFMC3MQM2fTeYLUoQL?=
 =?us-ascii?Q?S1UBTp7Bo2KKuo7Z0T/345cFKGjhXQFgdmFQ3U8oLOOKGueBL4qyoxgwEtXg?=
 =?us-ascii?Q?n6YJuQ9EIi21Lu3vxwNGD0rk3nBU4aDPj1QsOFEvb+8zrEZwxkl1mwN1nyh/?=
 =?us-ascii?Q?/h4Hmu0wC8+OQQUAVW5A0pDA0BurjWnuE4amgnCMVUQ3lgK/8FourgITpe+O?=
 =?us-ascii?Q?k2oP3I2d6D2guKcLFw9/CHcek9g3F5LmxKRkEpgJCIIxObUL3efhPnmPaltP?=
 =?us-ascii?Q?4y6yiHVakuzMkwWYdk/2wKTYAQvJ3yRyU8vi+XVC+BDiuOMjxi3k+S52uVJH?=
 =?us-ascii?Q?D9SpV/oV/Y9En9NkaDs6H6CziYfnpyB8XyZBlRJCpqNqxjfJviirco195Ukg?=
 =?us-ascii?Q?cmMwsaEF79Dxqy7FhWZy1D1Q0Jh49PP+8fk+j1D9zCfwK1JNw20smqZhauPT?=
 =?us-ascii?Q?i72+kGxhJvv07QmlRroiJOowfV8/N8fyP/MOe/QVH1RURF/zefWSNEq9nPLD?=
 =?us-ascii?Q?njVJPy5nc2B6Qud9a6ofsDEYOLlTqEP/ms56PJeRKuq9dcpX3jT8rWUjN6QG?=
 =?us-ascii?Q?DBKR4v8LaeSVeEQNcnJHL7EkVV3Ti1/3yAeyynZJBXjCFjFzXP93Nvx1hJS9?=
 =?us-ascii?Q?YiB8tuf0cKGgiFcB2bkWETtKmukQZ9Nch8X9wh6G+GP/nWDc0LJn2AmJuIHR?=
 =?us-ascii?Q?cHAreiuVywotAW717/8fgpPK2UtofXKxG39QcnWAcsILedW1hiTFJrz8HgaE?=
 =?us-ascii?Q?osrC5azrwU8pKLr+xUMQ8tQ6t9PP8fnZyEINAs00nOtXCv45lHp9RrNs0Wx4?=
 =?us-ascii?Q?Xjrh9Q35Gv8e+Gw/noNmNC1k0Ql8hInxSTuoPlHo10DqQD651yWFYkL2ahvO?=
 =?us-ascii?Q?C5ka9dOopIUi8OHnsQEaPg4fnoeDChy4F+aeHbAyjS61ZCVI2etRzRxIb+1U?=
 =?us-ascii?Q?7gK0t5g/gojAIyoz+6UzCSRMFpUJT3SJYXPFKfjJLDwc44HyUx3UigYNr2yS?=
 =?us-ascii?Q?ssZ595jKOLWvyJtjtc4epo9phaHWM1xPlmhS53cqltR3GMUd3xOrLN6bWS80?=
 =?us-ascii?Q?qrLf++QKgtOk7GMeuyKr0lfjOchdYF5puPFRsjSd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3693c00-bd49-4eb1-de82-08dcf708e73d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 04:27:59.0959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cF1oEu+lUT2/Tr70mH17dh1KKHfbrAdZ1Q891OU6xwoU++aWuOC9a4JHghqIbvJBo+94HaUvmQq9BGSo1ntn4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7698



> -----Original Message-----
> From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
> Sent: Wednesday, October 23, 2024 10:38 PM
> To: Sherry Sun <sherry.sun@nxp.com>; Marco Felsch
> <m.felsch@pengutronix.de>
> Cc: Amitkumar Karwar <amitkumar.karwar@nxp.com>; Neeraj Sanjay Kale
> <neeraj.sanjaykale@nxp.com>; marcel@holtmann.org;
> luiz.dentz@gmail.com; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; p.zabel@pengutronix.de; linux-
> bluetooth@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; GEO-CHHER-bsp-development <bsp-
> development.geo@leica-geosystems.com>; Krzysztof Kozlowski
> <krzk@kernel.org>
> Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support fo=
r
> supply and reset
>
> On 23/10/2024 16:16, Sherry Sun wrote:
> > This email is not from Hexagon's Office 365 instance. Please be careful=
 while
> clicking links, opening attachments, or replying to this email.
> >
> >
> >>>> -----Original Message-----
> >>>> From: Marco Felsch <m.felsch@pengutronix.de>
> >>>> Sent: Tuesday, October 22, 2024 4:23 PM
> >>>> To: Sherry Sun <sherry.sun@nxp.com>
> >>>> Cc: POPESCU Catalin <catalin.popescu@leica-geosystems.com>;
> >> Amitkumar
> >>>> Karwar <amitkumar.karwar@nxp.com>; Neeraj Sanjay Kale
> >>>> <neeraj.sanjaykale@nxp.com>; marcel@holtmann.org;
> >>>> luiz.dentz@gmail.com; robh@kernel.org; krzk+dt@kernel.org;
> >>>> conor+dt@kernel.org; p.zabel@pengutronix.de; linux-
> >>>> bluetooth@vger.kernel.org; devicetree@vger.kernel.org; linux-
> >>>> kernel@vger.kernel.org; GEO-CHHER-bsp-development <bsp-
> >>>> development.geo@leica-geosystems.com>; Krzysztof Kozlowski
> >>>> <krzk@kernel.org>
> >>>> Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add
> >>>> support for supply and reset
> >>>>
> >>>> On 24-10-22, Sherry Sun wrote:
> >>>>>> -----Original Message-----
> >>>>>> From: Marco Felsch <m.felsch@pengutronix.de>
> >>>>>> Sent: Tuesday, October 22, 2024 3:23 PM
> >>>>>> To: Sherry Sun <sherry.sun@nxp.com>
> >>>>>> Cc: POPESCU Catalin <catalin.popescu@leica-geosystems.com>;
> >>>>>> Amitkumar Karwar <amitkumar.karwar@nxp.com>; Neeraj Sanjay
> Kale
> >>>>>> <neeraj.sanjaykale@nxp.com>; marcel@holtmann.org;
> >>>>>> luiz.dentz@gmail.com; robh@kernel.org; krzk+dt@kernel.org;
> >>>>>> conor+dt@kernel.org; p.zabel@pengutronix.de; linux-
> >>>>>> bluetooth@vger.kernel.org; devicetree@vger.kernel.org; linux-
> >>>>>> kernel@vger.kernel.org; GEO-CHHER-bsp-development <bsp-
> >>>>>> development.geo@leica-geosystems.com>; Krzysztof Kozlowski
> >>>>>> <krzk@kernel.org>
> >>>>>> Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add
> >>>>>> support for supply and reset
> >>>>>>
> >>>>>> On 24-10-22, Sherry Sun wrote:
> >>>>>>>> On 24-10-21, Krzysztof Kozlowski wrote:
> >>>>>>>>> On 21/10/2024 08:41, Marco Felsch wrote:
> >>>>>>>>>> On 24-10-07, Krzysztof Kozlowski wrote:
> >>>>>>>>>>> On 07/10/2024 14:58, POPESCU Catalin wrote:
> >>>>>>>>>>>>>>> +  vcc-supply:
> >>>>>>>>>>>>>>> +    description:
> >>>>>>>>>>>>>>> +      phandle of the regulator that provides the supply
> >>>> voltage.
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>> +  reset-gpios:
> >>>>>>>>>>>>>>> +    description:
> >>>>>>>>>>>>>>> +      Chip powerdown/reset signal (PDn).
> >>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> Hi Catalin,
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> For NXP WIFI/BT chip, WIFI and BT share the one PDn pin,
> >>>>>>>>>>>>>> which
> >>>>>>>> means that both wifi and BT controller will be powered on and
> >>>>>>>> off at the same time.
> >>>>>>>>>>>>>> Taking the M.2 NXP WIFI/BT module as an example,
> >>>>>>>> pin56(W_DISABLE1) is connected to the WIFI/BT chip PDn pin, we
> >>>>>>>> has already controlled this pin in the corresponding PCIe/SDIO
> >>>>>>>> controller dts
> >>>>>> nodes.
> >>>>>>>>>>>>>> It is not clear to me what exactly pins for vcc-supply
> >>>>>>>>>>>>>> and reset-gpios
> >>>>>>>> you describing here. Can you help understand the corresponding
> >>>>>>>> pins on M.2 interface as an example? Thanks.
> >>>>>>>>>>>> Hi Sherry,
> >>>>>>>>>>>>
> >>>>>>>>>>>> Regulators and reset controls being refcounted, we can then
> >>>>>>>>>>>> implement powerup sequence in both bluetooth/wlan drivers
> >> and
> >>>>>>>>>>>> have the drivers operate independently. This way bluetooth
> >>>>>>>>>>>> driver would has no dependance on the wlan
> >>>> driver for :
> >>>>>>>>>>>> - its power supply
> >>>>>>>>>>>>
> >>>>>>>>>>>> - its reset pin (PDn)
> >>>>>>>>>>>>
> >>>>>>>>>>>> - its firmware (being downloaded as part of the combo
> >>>>>>>>>>>> firmware)
> >>>>>>>>>>>>
> >>>>>>>>>>>> For the wlan driver we use mmc power sequence to drive the
> >>>>>>>>>>>> chip reset pin and there's another patchset that adds
> >>>>>>>>>>>> support for reset control into the mmc pwrseq simple driver.
> >>>>>>>>>>>>
> >>>>>>>>>>>>> Please wrap your replies.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> It seems you need power sequencing just like Bartosz did
> >>>>>>>>>>>>> for
> >>>>>>>> Qualcomm WCN.
> >>>>>>>>>>>> Hi Krzysztof,
> >>>>>>>>>>>>
> >>>>>>>>>>>> I'm not familiar with power sequencing, but looks like way
> >>>>>>>>>>>> more complicated than reset controls. So, why power
> >>>>>>>>>>>> sequencing is recommended here ? Is it b/c a supply is
> >>>> involved ?
> >>>>>>>>>>> Based on earlier message:
> >>>>>>>>>>>
> >>>>>>>>>>> "For NXP WIFI/BT chip, WIFI and BT share the one PDn pin,
> >>>>>>>>>>> which means that both wifi and BT controller will be powered
> >>>>>>>>>>> on and off at the same time."
> >>>>>>>>>>>
> >>>>>>>>>>> but maybe that's not needed. No clue, I don't know the
> hardware.
> >>>>>>>>>>> But be carefully what you write in the bindings, because
> >>>>>>>>>>> then it will be
> >>>>>>>> ABI.
> >>>>>>>>>> We noticed the new power-sequencing infrastructure which is
> >>>>>>>>>> part of
> >>>>>>>>>> 6.11 too but I don't think that this patch is wrong. The DT
> >>>>>>>>>> ABI won't break if we switch to the power-sequencing later on
> >>>>>>>>>> since the
> >>>>>>>> "reset-gpios"
> >>>>>>>>>> are not marked as required. So it is up to the driver to
> >>>>>>>>>> handle it either via a separate power-sequence driver or via
> >>>> "power-supply"
> >>>>>>>>>> and "reset-gpios" directly.
> >>>>>>>>> That's not the point. We expect correct hardware description.
> >>>>>>>>> If you say now it has "reset-gpios" but later say "actually
> >>>>>>>>> no, because it has PMU", I respond: no. Describe the hardware,
> >>>>>>>>> not current
> >>>>>> Linux.
> >>>>>>>> I know that DT abstracts the HW. That said I don't see the
> >>>>>>>> problem with this patch. The HW is abstracted just fine:
> >>>>>>>>
> >>>>>>>> shared PDn          -> reset-gpios
> >>>>>>>> shared power-supply -> vcc-supply
> >>>>>>> Actually we should use vcc-supply to control the PDn pin, this
> >>>>>>> is the power supply for NXP wifi/BT.
> >>>>>> Please don't since this is regular pin on the wlan/bt device not
> >>>>>> the
> >>>> regulator.
> >>>>>> People often do that for GPIOs if the driver is missing the
> >>>>>> support to pull the reset/pdn/enable gpio but the enable-gpio on
> >>>>>> the regulator is to enable the regulator and _not_ the bt/wlan dev=
ice.
> >>>>>>
> >>>>>> Therefore the implementation Catalin provided is the correct one.
> >>>>>>
> >>>>> For NXP wifi/BT, the PDn is the only power control pin, no
> >>>>> specific regulator, per my understanding, it is a common way to
> >>>>> configure this pin as the vcc-supply for the wifi interface(SDIO or=
 PCIe).
> >>>> NACK. Each active external chip needs power, this is supplied via
> >>>> an
> >>>> supply- rail and this is what vcc/vdd/va/vdio/v***-supply are used f=
or.
> >>>>
> >>>> The PDn is a digital input signal which tells the chip to go into
> >>>> power- down/reset mode or not.
> >>>>
> >>>>> reg_usdhc3_vmmc: regulator-usdhc3 {
> >>>>>            compatible =3D "regulator-fixed";
> >>>>>            regulator-name =3D "WLAN_EN";
> >>>>>            regulator-min-microvolt =3D <3300000>;
> >>>>>            regulator-max-microvolt =3D <3300000>;
> >>>>>            gpio =3D <&pcal6524 20 GPIO_ACTIVE_HIGH>;
> >>>>>            enable-active-high;
> >>>>> };
> >>>> This is what I meant previously, you do use a regualtor device for
> >>>> switching the PDn signal. This is not correct, albeit a lot of
> >>>> people are doing this because they don't want to adapt the driver. T=
he
> 'gpio'
> >>>> within this regualtor should enable/disable this particular
> >>>> physical
> >> regualtor.
> >>> Sorry I see it differently. I checked the datasheet of NXP wifi
> >>> chip(taking IW612 as an example), the PDn pin is not the BT reset
> >>> pin, we usually take it as the PMIC_EN/WL_REG_ON pin to control the
> >>> whole
> >> chip power supply.
> >>> I think the reset-gpio added here should control the IND_RST_BT pin
> >>> (Independent software reset for Bluetooth), similar for the
> >>> IND_RST_WL pin(Independent software reset for Wi-Fi).
> >>>
> >>> Best Regards
> >>> Sherry
> >> PDn is not the BT reset :
> >>
> >> - PDn is a chip reset and is shared b/w BT and WIFI : hence, it needs
> >> to be managed as a reset control
> >>
> > Ok, so can you please also send out the corresponding wifi driver
> > changes for the reset control for reference? Otherwise I suppose the
> > wifi part will be powered off unexpectedly if unload the BT driver with=
 your
> patch.
> >
> > Best Regards
> > Sherry
>
> We use the NXP downstream driver mwifiex which doesn't have support for
> regulator or PDn.
>
> However, regulator is already supported by the MMC core (vmmc-supply).
>
> For PDn, we use mmc pwrseq simple driver that has been patched to add
> support for reset-control.
>
> Please check :
> https://lore.ke/
> rnel.org%2Fall%2F20241017131957.1171323-1-catalin.popescu%40leica-
> geosystems.com%2F&data=3D05%7C02%7Csherry.sun%40nxp.com%7C89459f5
> c23724f1bf16308dcf3704ce0%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%7C638652910876819305%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7
> C%7C&sdata=3D6Kz7Fh1e%2F8iRZtTmb%2BHEWDeaTsG0D9tBa4TQjotZJwY%3D
> &reserved=3D0
>

Ok, thanks, the mmc change looks good for me, so there is no problem with t=
he NXP SDIO wifi.
But how do you plan to handle the NXP PCIe wifi? We also need to make sure =
the BT patch won't break the PCIe wifi function.

Best Regards
Sherry
