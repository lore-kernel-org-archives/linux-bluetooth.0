Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011017.outbound.protection.outlook.com [52.101.70.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D78E22A4E2;
	Wed, 26 Feb 2025 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592552; cv=fail; b=iUEqB22TpqlOLYf/wIEqv3XuagBMmnuEhLuhmVz9fsTjvLfSTuuqLh+DoAUTzP1sIEXIuMDSdtgdqI9AisZo1oUgfIjjFuqxlnOXARwBGweetRLCXmmN9edyjSiFEi0YAqWF29plKF+xEJARyDLjaa7xdkfFXNyyksAg/S80hzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592552; c=relaxed/simple;
	bh=T+9Aw9xI64eKVOqv5WE5gJXcXYUzztBV1yZcGuXOEiI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nUw8nNl24VNDzum4WBfUYeVkchen7hGaPs7ruaa88pcYl8L6Sy/N6oROMkJSeNkE/vbC4EVZA9o6KY5xHX/giLinJNdCn9xZ3p4XKfnlZZFWlzByoDV3kEgSqGsHrZXvzYm5iTtEASHg8vlp81AxaYykDuk8Mg4lPG49Ouh64wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IOp9iqkc; arc=fail smtp.client-ip=52.101.70.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IOp9iqkc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tud6xEW9rEv6ujCdGnDNjW3yl0cmoLFbtsNeAR6I9HXkEAirjqJfuteq9wba2oBg+qb8ep6K4QG8IIM7Z3oqNo2RW0hulpCz/nPEnrJ6HwwwX8XcdwtsrnG/hsUEyMuz53f2F792eyTVMJaUNYyFCUJVaDlAzf0Q7QtEdnk00Xypxf9mbMY+BBOfhDtabvg3iGrRFcWzC7eIJl3fCcslz+JC1wga8JiawpIge7vsPDVOjo0aGAFW5FTRCHVpMuIFmyP6Xjnj3uEneHjJJSDbBNYJfv7ocFvSlxJyOtehk+AbSZhjkrjywxY5VtgleDzK+kBDmplnuTBibcwkyA62Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNIZSKhXn4XhgUV2Z68cDbkY1iHILeuW1yz/yVl67b4=;
 b=ldG391kR41y+pGyeteXSJyunFHmhTkNk2aOS/5wFcvN5TNMSBSxhONmh6iovmzujshBVsfv7p8ULTdLkWw0vHxCYKNOGLAEd6S0UU4RVBI/yjrs9ojO/70JrjSCGswg0M2VvZ5ZA1AOXJAIpQ4Iw40f+twSyp769UL2pY+drvZ1+wPbVaHgRBMGasWAoB9J6DdZlVCV6fcUL1IKNAYT74dSsse+m3SjG7Tre4F1OdIklG4uCviUONLW1WFJnEn1i8DLbaXArfx7JTQsMHvt6y+preZHDjS0Ez+palcrM79KTPwrTd4tjh0Hpvoa76nyh1y+JcQ608HNVAmRlNMoDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNIZSKhXn4XhgUV2Z68cDbkY1iHILeuW1yz/yVl67b4=;
 b=IOp9iqkcCO1cs32dhWG2uqrUMO4fARUDbVQNJEODvwjRvCblDP/BseQATY8ugznMSHhEQap/CjFRBPzCHteKNvRfmlaDXi5E59kKBFhjVYfS7lZrs0qnvibH0wy2fjqnxw2Nj8lmI97a4RDjTMogdCZNx3viBE5fx3ouPVWzBBRE8Yuos7fe+BJtB05+5Ep4NSres1ckq9lAccMgBeunScdh1TuVCT9br3v29mcP0hocHOilPPMqi4dc5cQhr33+cv7I+1tOJGRpaB3MM1uLiAnUvMfr5e7bW53H//49WjAKkIvUZ1R8MmFp1uKWZjR+lvc70ffj0hibUNQf9XVdWQ==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DU4PR04MB10552.eurprd04.prod.outlook.com (2603:10a6:10:58f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 17:55:47 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 17:55:47 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Loic Poulain <loic.poulain@linaro.org>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, Catalin Popescu
	<catalin.popescu@leica-geosystems.com>
CC: Amitkumar Karwar <amitkumar.karwar@nxp.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: [PATCH 2/2] dt-bindings: net: bluetooth: nxp: Add vin-supply property
Thread-Topic: [PATCH 2/2] dt-bindings: net: bluetooth: nxp: Add vin-supply
 property
Thread-Index: AQHbiHep+4vmC60zgEKmq6CcmxHKpw==
Date: Wed, 26 Feb 2025 17:55:46 +0000
Message-ID:
 <AS4PR04MB9692A606FEFDEC56BB091FA4E7C22@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250226150553.1015106-1-loic.poulain@linaro.org>
 <20250226150553.1015106-2-loic.poulain@linaro.org>
In-Reply-To: <20250226150553.1015106-2-loic.poulain@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|DU4PR04MB10552:EE_
x-ms-office365-filtering-correlation-id: b7c79b10-fbcb-46c4-0200-08dd568ecc5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?S5slDrnvXo67ldeCkdQz9gmk8sIc9RKt951PUbToUdreTMHfl45uqW4MIGXA?=
 =?us-ascii?Q?IzQGy2ZndUEUVyj1VN++sg+FSFT+V5crlbNIOCtPWpk5De9+b3swljN4Z7Q2?=
 =?us-ascii?Q?qevFlhznjICl5mbzXeRcc8aH+32CKLfIeHpFjrHsKtXvBvklpPi5geeZQZE+?=
 =?us-ascii?Q?F/GA/noebYQEbSiTVCLlGGAEIjvv9SvZu7j24KaPPhShn0lqG0FaEnXLiDqn?=
 =?us-ascii?Q?N04Dts4iRPlZH3ey6ZWZLEJ718pUAVQ/cGtF05OLAvUL/1VlnnbGcrgIcDpt?=
 =?us-ascii?Q?m6I4tKtzxS2AEaDgvNmyq091OdSk1eujavO/rR8mOUnSG6BEOz4FsMUL8mya?=
 =?us-ascii?Q?3ILJtHKsR1R6NFlsfrD/ZBpECqDXA+ARWYPeKkBJ7W/VkOMs4YMxitZkI2JB?=
 =?us-ascii?Q?XQyk43VIzUo6d3z+VDrPmzDY6TK2bNO5UXLRv4bOxmeFeORyLjQMHMnZ/Efo?=
 =?us-ascii?Q?z5lUkuL4pGApn3WgS55a1DCdZ2aPkV7PbPWImtj2ESvq9QAzGhMKdKGI+mdk?=
 =?us-ascii?Q?tfzieLvTT2pqte9JwLiaqbLd5cLgpCebtPvK0PMf7rlZwzs+5BSO3iy2dT6C?=
 =?us-ascii?Q?SXW/0cR8wHEUFUTDM12qppJ6aAJYjM8gef+w/oR6aNZXw2jB3emhkLZsqF5U?=
 =?us-ascii?Q?DLQ8Wgms7bkxPqz6270LVCjV1W56MpX/ggrAUGepIsK4ozn5e5uLE2oiDqXu?=
 =?us-ascii?Q?vZ8+kBcqTNuGwPFnMDMyHlmzmRKB1WyRlCiW4VmIyN349sKQ2XHNiqNAw9Le?=
 =?us-ascii?Q?9Rdto1wa0xtvkCSTSDftEmWCKE1wSIqMA0ehbaVY0FQsCYqrPD1UBgQGgt21?=
 =?us-ascii?Q?PJsm6Pk9ccOtcsWzdmwU1eHeA0ZfEomp7x/BQtlX56Au7Zdv8rHz2wZIDY17?=
 =?us-ascii?Q?ONzVjyZ1huWNY45RQlu/ZocnBAIpY02b6BW1sqFc7UNyMsF1b0pM1jighijK?=
 =?us-ascii?Q?9Tyu7XSoO8LY8m8Ecz0Eo88EC60lVw9ld02ZxBJkYHijpa6Qej0PsyYpjXpN?=
 =?us-ascii?Q?mKD+yBeY6VUNWtWs8vxmq9zAs5PZNyxQd+TZg0WuKMHQhdf7L62tkTHjWBap?=
 =?us-ascii?Q?yZCQunG4Abz6z+9BXmfq1t8JV2e3REdgXurTTwJgTRYFxlSbn6JWTQbE8bCU?=
 =?us-ascii?Q?BhPP6hNHx2Y39N33C0INj/dijD7DqRlkEoZzw/qXqpaCSryCEhz8dlrTkUN+?=
 =?us-ascii?Q?0k/hEeHb4d0VZBEXLupiRBOd3iBWb9No77hRKSnAGYAeJV2L3vhnsZmGVIyy?=
 =?us-ascii?Q?5sWkXkQkTC29YDmm2CsnoVN/1W2qNNaY4SMepnlUO+PmDasv91kBOLAJOBst?=
 =?us-ascii?Q?L86SDPPFZ9eDm860uIDFtwljq++g4q3S4qTkBd+zQ75A7A7VvYladNxNPuBK?=
 =?us-ascii?Q?zJKR5TjOHPM1iG1mSdHCjnTo8usq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DL1QaIg4pykCsAUDrZsNDMHFSz0WYNFttBaUxuCGXuL5r35wiLc3L50NTa52?=
 =?us-ascii?Q?wUWeCxpxufwJiQ0YD5jClrV7XClxEDBZ8IgkuwXYczCgUSVEcU30KvHnVl48?=
 =?us-ascii?Q?JcvMwvtVF769o4ggZxqN/4VB9IR8XUtCetPdjH797k4FqslYGKK76dHCJHVG?=
 =?us-ascii?Q?Y2P+saeBUyubYQLHmy4BmvfgQ0NYEiFX98EZ4gZUbYUxW+m86ZMge4k7JHgv?=
 =?us-ascii?Q?bU59AkbdXmqDUXCxL7DXPRLkjc/DvxqUS6MAZrHb5PG+pI5CqsxFsLSpa5C+?=
 =?us-ascii?Q?zfvRON98qXN1ZBQeElRG68dP3g8INLvvUPHSOmIvo32v9bDM3UOfaM2/fa8Z?=
 =?us-ascii?Q?qm2fCO2P+HFF5k+/9MKCKmvWV+dSUF1+n6PG+4xlI0UNkeFzoDxrJGByl9OX?=
 =?us-ascii?Q?B6Ztpab9tgJdHrSsCCNETI1FkbMZjOLV2FZNr+MEzr1s1yfBboGKBvPK4Cmy?=
 =?us-ascii?Q?kLZTMncnJ4cTLZ0CTtckP6FKQAyR/0q77h6FbEdSNo6vPihS3KNprnZ1d+Li?=
 =?us-ascii?Q?7n7WcgnrIRv7gG+YwZoG9ozOeAKjHlN9OVgU6CjwkgOgfGtj1Q2woB6SptBh?=
 =?us-ascii?Q?WkRX45TcYd8lDGW+5BfvkDDBYohRhEA5NDLJux41c1LH2C/2zsK+lY0PehGw?=
 =?us-ascii?Q?tE/4ec/ZHOnDnhVmPa4jUBaK5kHELuI9Fji000IskpEeJ/tuBbDRXcN0laY6?=
 =?us-ascii?Q?mlWOZoVI5ma4vHQkKb3JFUmqtGXX49JPIpa+CGz10zs+jqk95S++F7BaRGig?=
 =?us-ascii?Q?YKjlVpzViH34btUg9yu2LQzeUJA08g2sTm4bRgkwv97TweagRp5o+epBypdz?=
 =?us-ascii?Q?kVuOanlT3ALloRlBblTAsitM+pAsdqj4K6PnnIgEccLzoYv61JQeVVah+JQJ?=
 =?us-ascii?Q?WmKQQYokMTNeCtf1MliA75//L8QN80rcUfaxvGV9HemQKPCcewozv4p1Qr2j?=
 =?us-ascii?Q?3fcu3gnn1Di4GwDipVWtKu2JkvOSsLj30U91ESwS3VrYAnPSOpMy2Y8wF0Ws?=
 =?us-ascii?Q?wOfpicu/HTI823qf2coRVO8J9BXJwFKuaBTsh3Wj+jluS3MQvGQfX//nVHq2?=
 =?us-ascii?Q?wmogubWPW0zque4h8Iuy2xpAwesWzzlBSgKMDDvUhA+Wo2yZ7UqIhsSjHYd8?=
 =?us-ascii?Q?7wZwTueYBWd7Ah9nfe+qe4i4Id6mM03RycSI83wNAGdRz0Vk7T0C4s2zuqrE?=
 =?us-ascii?Q?ZyCzCxnnd9L6CF1HjRct+/4mohK+7nw2dC6tnjA6QobQO1tuVt7dWbbK4fZp?=
 =?us-ascii?Q?jkaKEMA8DJKWAOjHTElrkJFuMnmRmKqMYExQ/+AAXLkWWpPmcV7Mx2ThEhyN?=
 =?us-ascii?Q?jIHErTp6owVRCFuqLUde5glH4vaWLhXTNlp8OfxlsE3CaC3wF+BzfPjEyLCV?=
 =?us-ascii?Q?KSw+JXCG/4RpSvuHkRHlviH1FCdCH678L80GWFf2NziOdbDFSaPbt1UByGXK?=
 =?us-ascii?Q?A4LzDQs1DqyXcb/CheYp2/X5V7VllRPik5Qw/K481PjhAblwldSS8wYfpnHy?=
 =?us-ascii?Q?sxlwnNo+FVOem+OcFVf0myIKzQcHd1RTiefhGLvOfQNf1QnyFDIl1or1qXES?=
 =?us-ascii?Q?Cbb1+VT7R7r5CSY8q18KuYgi70FPJQL6e2cJPq2y?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c79b10-fbcb-46c4-0200-08dd568ecc5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 17:55:47.0055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TOaeyE042Zjj6E56GEPx3Z39wxPlYrMGXJGqyK3FsyJvJiVcgBMK5ivNshbuRZNBUNARva9BcTqxKupuqCaFUVk4WfaDwYQJWEaBYSzZxv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10552

Hi Loic,

Thank you for your patch.

There is a similar patch series from Catalin Popescu, which has been approv=
ed but pending merge:
https://patchwork.kernel.org/project/bluetooth/list/?series=3D895539&state=
=3D%2A&archive=3Dboth

++ Luiz, Catalin

Hi Catalin,
Can you please resend your patch series which implements power-up sequence?=
=20

Thanks,
Neeraj

>=20
> To specify the VIN supply for internal buck (1.8V). This supply is usuall=
y
> referenced by both the bluetooth and WiFi nodes, as they share the same
> combo chip input voltage.
>=20
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml      | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
> bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
> bt.yaml
> index 04f55fac42ce..275c1e5a6f72 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
> bt.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
> bt.yam
> +++ l
> @@ -50,6 +50,9 @@ properties:
>      description:
>        The GPIO number of the NXP chipset used for BT_WAKE_OUT.
>=20
> +  vin-supply:
> +    description: Input supply phandle (1.8V)
> +
>  required:
>    - compatible
>=20
> --
> 2.34.1

