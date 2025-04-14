Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2081.outbound.protection.outlook.com [40.107.249.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ACA289360;
	Mon, 14 Apr 2025 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651534; cv=fail; b=FrMMQ/kVCKxpku0hnPb/sq4QUUdR3k5Binl3gRp2gW58jR2tg0CmWgBd/PEeU4Zjm5HsSQKVN5gLBsAy5BmyDbnRMzTQ+LJtx4H2nuOeCUtqtEo1V+rgzBeu6uz1XwknzLdMfhlyBIStfi1YcCymk5NQUeUmbqcob8EZX3luu6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651534; c=relaxed/simple;
	bh=M5T1BIKjvKernZEeHyR3bypfV8sqOMYbUUSuG9qqIHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YcP7P2lrUsauV9SfCGlUQnfbJLnPGBo7TPFA+gUwK2cTNl852R1kF7w9h2oNW/V+7SwWgZjfAfxq+JNxvpAXcqLNvCpbt5wsPpIxKMFJpEMalm0xzwFsC32JqycQ9P7n8QVpnTsq86hpLXqbiGbCdoxEWbSzOCKVO+yZowSghBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PPENHxNf; arc=fail smtp.client-ip=40.107.249.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PPENHxNf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBUP8ChhyjIduPSJHUGQcgoKnFBwtT2sj9TDAF27FcfqAD+IvlfJlVmtg6lloBymYki0AV/UCwWkK9tTkCqa8hdqu63jqWWEGTomOd6PVvNSxjf1+URZDuFVyXVYU3ojGxMZ0c5gPA3AXhTqp34UNDC9jgEIVdzTAE8IqC6TQToJAtTzYOWDG4CeC0Co1evYj9+99JBiByeStmLRX4HGQYl36gG5oGf0AJcEomzgrIhLTGYMfcTVM9MS/mNFRhKlrm47RfHVdgHOG2c4aTFOFS6cxVL9tMfd93SBQ+vJxBCQEcTFOijXThJQUNgBoFGrc/lptF6iJGQNwUC1pWGqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYnuDXCdSK62TcJly/xPG5CEi7YBaSTDmrMnZzReUdM=;
 b=FPRMSEH9XIVFHdmG6s2tBN8oQXbZ3jKn0nTqknaocqssMJNqH04y6cGWPgD7R4R7lAEddOQBd0soEwc0CMyIfvDA6dl9OD2wJAwXDWGSkBjqGJxntPcR/FbdHo1Hqp2iBmIbp7C5U3rTNSznamhRTBAiwfm4IS3a2bHKZfi7HP7EraRX/tgdBb6bOOK1TnUxpkCDt2aKxdlsgerPfpcp+vOOLwj3xK6BYWwsMVKNH3UvcfDd5SKRhRQl5DlNGN6IloHh39tzwtQuit1hxSO0sILpvnpPg63toa8m3KUAVFe1/E8K9kECG1+jVt3OXjwhzr0q7HEZj9LBwH9hUdyqPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYnuDXCdSK62TcJly/xPG5CEi7YBaSTDmrMnZzReUdM=;
 b=PPENHxNfnkOgCa3IFHe7YqLsE/IuGEotHGH6lZJf9bYIV2uiW4ICQZsQ4BCOBt9VqcM/RzSMzDAdgKjSXUAWS54NCC8mm90xK0cLdtcMyeeyuHghaJX5yy1Ji6wvWE0KM4VUfJcsT0BC6u9L53DNvnCvvV5oU7T5gXhsWrct4dI1V1p9+bP7WcEXkWZJO8tc3iYfL1CDfFlzQVLMgm7+ma0bMyHC7jFgJ24O5gcDaAOrXMlLHNpyFb34l+6qcEqTGrMqJMZCaMEOaLFBlQaSMjAhq3FWeYhRe0/kc9OFgIfxiUlL2L7lSyPmsVWr1fsifZJaI42fi5SlnKghvgFxIQ==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DBBPR04MB7692.eurprd04.prod.outlook.com (2603:10a6:10:1f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Mon, 14 Apr
 2025 17:25:29 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 17:25:27 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Sherry Sun <sherry.sun@nxp.com>, Manjeet Gupta
	<manjeet.gupta@nxp.com>
Subject: RE: [EXT] Re: [PATCH v1 1/2] dt-bindings: net: bluetooth: nxp: Add
 support for host-wakeup
Thread-Topic: [EXT] Re: [PATCH v1 1/2] dt-bindings: net: bluetooth: nxp: Add
 support for host-wakeup
Thread-Index: AQHbqv++j/vY540Nh0eJlDsDNDwdK7OfBqaAgARmcWA=
Date: Mon, 14 Apr 2025 17:25:27 +0000
Message-ID:
 <AS4PR04MB969222D99D16088825C1A8D5E7B32@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250411163719.326558-1-neeraj.sanjaykale@nxp.com>
 <20250411220859.GA4161337-robh@kernel.org>
In-Reply-To: <20250411220859.GA4161337-robh@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|DBBPR04MB7692:EE_
x-ms-office365-filtering-correlation-id: 7317185a-7b89-47ef-6e75-08dd7b79594a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?F6+b9peSCQlDfWyjUTTWYc0KSC5h66c7SN7Hf2WFPu08tqYMlsc933RehYaZ?=
 =?us-ascii?Q?Ak47Q2oa4IFSxkM8x6I+Jv9qNNKzPungw7/xA7NU5AfCv2juJc+VZRjFrDWT?=
 =?us-ascii?Q?XKEzHabKmUx66wrhS0sq2GZJbEMtszb1X/nqedh/xV79bRvOzxnO4WxPiiZ2?=
 =?us-ascii?Q?DYKuviUTxELRlhnEDCdlskTcb6mfzeEqm/O2kUWb0YRixz5JAE9RVxYS15/X?=
 =?us-ascii?Q?WIl0VMHmL92qYbrLYcrBG1v3g5dwCXZyRSiaXow4RAKd9O4MkDGdCiK9zWtf?=
 =?us-ascii?Q?27RCIWkStBA/gPUW3IsXT4ivSAFk6/3mkT5TyqeMKYqVV47Ev1vc/kTRX1+B?=
 =?us-ascii?Q?hMlLO3OHXNQ1eHcOnMJORaGENuw5gxLiBqUGddRpkLgI/vXxwWMNR9zVTAYf?=
 =?us-ascii?Q?ucRxd19PxcOV6EwjMKJnplw1sPh+Jvdp4tiO8X6gU6D3NCCQV7AHOmIYLrDs?=
 =?us-ascii?Q?RcUxnt1XHLJCpKaYcJC+EfBdSH1lFjJ9kSvC+fqMn9/2gOJ6mtevRUqItDv3?=
 =?us-ascii?Q?9llKbxSYjcUVxYzMr/r1ZxF1aPNx9S0WfBcIGONpttZVn4MtA0xEwQS9m1hS?=
 =?us-ascii?Q?ftGtmZRMq3w4o5x0CHrZXl0jKL1B7J/TUqO898xsaN3yv7hShdEuUJxs73io?=
 =?us-ascii?Q?XjeRwREHykEfjdvIihlW3GqFGf8y8yBiDiQxGvNDrbfC/rET9FlpoywkxJ6a?=
 =?us-ascii?Q?2N6xByuBzoTiX5jFJNkoPHlHPJjzGzGLGk9qtglTdzX3AilvLUE12hWbIoYW?=
 =?us-ascii?Q?1ccBY1CyWOKs1ZylnhQc4xZahBZZc/NxzSQAJg3wHvJ+KfcKRtOLqhojUy66?=
 =?us-ascii?Q?SbnH+FfGb/sHP8UZ9uH0trjjOq+J/9JpGz7PWc+ef+b3+VNaGPiwNCGbhyXk?=
 =?us-ascii?Q?pmlOlqwKQ12yeO7BFa/SPmo3fQshKoEfnZeqzhWhbqss1fnfeah3bu+m1MuO?=
 =?us-ascii?Q?/nR2LzRXDz4gOFAGnpUAYgA5W7Us/r9OEtm06CKur0H2LJ3xPvlbayshT2jP?=
 =?us-ascii?Q?28gvEjodxYUXhs29VWVbuY0om1a0SS0cg8csDbvZNkrs6QpmcBHJImuP6D7W?=
 =?us-ascii?Q?CEIcbmAsh8WqxaJM+xuIYpnuUt+8tu0lLpaFT3RMI+VxGDmbNjVGTwGvl28O?=
 =?us-ascii?Q?txbACKP0FimdNEyoKw38EMh56Qe8mySRv781O1LtGKUDVWPZ36XZ0qSQWTva?=
 =?us-ascii?Q?qDNRLbrO01LhNT4XR8hUol/O0fEU2jAqHkeIiReyLrXidEECq6DS6LMR+XY0?=
 =?us-ascii?Q?abJ8ZS5433YHqDLysWqbzd8bWkzegkQkEuJeM9GVIFs8u01s16m49oukDhGi?=
 =?us-ascii?Q?nM3gITyVZqPEmm6IJJ1ZEJyNTBPpWB7CupDR0BYfH49TyUizR7q78GqmlMAR?=
 =?us-ascii?Q?AaSuz53drZosMV/v+zMV5Tp7IGjhQtg6JLh16GjOiEb4j5MsHHOxfPuhEZqc?=
 =?us-ascii?Q?5wFZopJUsmr16RiS5NLwMKP/lofR02GFqPmNbs/pD1lTQs5ZdRg35Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F8x13utV1DrMawxvrmXP66b6PS8U9HsqFw60whpCFsgALcQpFYRk0owOWcHT?=
 =?us-ascii?Q?UW5b2NeB802X3bWe7As2xJX67yAwaAv1//jJArasv5BEMi14uCqAV4qFvbwS?=
 =?us-ascii?Q?Dxs2995UdaHnaRLYv942JebUKZX7nxw5emMTvDCXZF9QIMx2B6brDpS4Nrhf?=
 =?us-ascii?Q?1VjTcqCbzcIJ181vbgr4k1Oi42RZ+laiqBpAfrNjREk5vlGwl5FloqW7ge62?=
 =?us-ascii?Q?zAbqNrSdMLiVs0xRd0oHD5Yv4UFrtSzDf8z0fr/HEF7hBPbwG9EyNPpRSUeI?=
 =?us-ascii?Q?tkEu3goAwKxD64ja90HfESKxWbdvWtTxwIZrNHpRdAoEagX4T5N8/MPLNfds?=
 =?us-ascii?Q?Wk7jaug9Xqe9iRUAvuGhumCj//MYoXzKP8QnTAP+ayA+sigzcSD3gGFltYkt?=
 =?us-ascii?Q?7e9DctkxOHa+vt+ikze+rV3VAsaKSDqOftoD4knuvw7rcw2UTE9CABZnIR56?=
 =?us-ascii?Q?yp5iKJXv0Vc6D+TdBzD3eGJQN3njCkSUVWVEvuv+1AeeeNFoezlXsiBnnTuR?=
 =?us-ascii?Q?zX0QdWFVTV+1DrAgXQyyphULzDyE8HxhOvDijH7JAMCIVBxJy2NsXgQ9a9NY?=
 =?us-ascii?Q?3YwPaCBPbgRSVHiTTvkIKrXFDzY06MkT5AU98M4wQZfQvW353YQWUSazdymi?=
 =?us-ascii?Q?DSskvWbcWXQHyNA+7YMUrGK45OLFV5pUSd6L2nwmYkXgr6kpDXLtKM7KxNrp?=
 =?us-ascii?Q?5ybZIOkuuDD4P+vYURGpo/iyDTfdcYhFMlvuIOJb8YN8tqIL/h41lwlLyDbq?=
 =?us-ascii?Q?0kSBtTaQlrQ9pgXdFoBY3AdEgrzUfqjDlx3LhFTmwBU7KDdL83wAhjRiBxvg?=
 =?us-ascii?Q?cMhyvZKPpWF7tuemhQRR73SnBybieHYlOXLME8uX43L6RypGyNdYvCaCvg69?=
 =?us-ascii?Q?Kf2tnb1ZUksCSsS0fiNIPQAyfyqku4FvGvxW84jqyz1BP2fB/q8IT7tffm88?=
 =?us-ascii?Q?f9GDZwOA98b/SeQBCPHUo7jDKw6j3Qv9v9dMoGnSWP3JiuJdfJZiHLQXPu4o?=
 =?us-ascii?Q?8F9nRY3BIYoj5sT7DxqcYdBkI8uAiKug3nTv1S9jDPBbjk+ZXzrnXlsabc3K?=
 =?us-ascii?Q?qfIe6rtfbN8+h8uUcFLWtZeFfTmyWBqbVpfa65JnpCIRqb29Z5cQzkFwokED?=
 =?us-ascii?Q?fvMUdOcXmPRO5ai8zeqJlU4uFcuMQwY+6Ek6j90Ug4R2Tg7p/pRcNKeBtH+P?=
 =?us-ascii?Q?mGfFvT2pWi+A8JLJtWcmohqrMrDreLvWnyY07vyY34Y7Ogc5hdoN2ZCL3OOS?=
 =?us-ascii?Q?9wZ68B29EXEDI4cZ9Ys1HFCX8/Mm5whNcjaH6VearJCnrFgvtSlFzpy0hQID?=
 =?us-ascii?Q?kV+lklxdB6RilQfHB4R5d6iipXGgSF9yJTazInhvi2OLGdK7cPPeYmhb5MQi?=
 =?us-ascii?Q?FCSMw5ygl/veojxfE5Jig9kR62cyeRdT2TZm5GffjosugAe863qLmjZKJQr9?=
 =?us-ascii?Q?zfHvKTIaujaDLNupmxKhiHOfxmVa0VZITpLyok+hFc/gscAuE2rqGLyDc5ef?=
 =?us-ascii?Q?3x06Qq+KME3Gz27INSa08tQprV4hcN8tSBnY/+ju0h6ppEuHFK4qjcavILGC?=
 =?us-ascii?Q?qIsuvh1euisdL9PMLpkHqYy9YmZGhna016rL1SiB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7317185a-7b89-47ef-6e75-08dd7b79594a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 17:25:27.5464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5rJbAxqFRLmN0QlJfAQ8P2N6BznBN2MLnzlk/6xSiM81sYwI0oNY8UdQeF6eXp2Nk2UJJ3vlLUbhJtwd4VdtquuxfBakWU3p2at3OWAemk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7692

Hi Rob,

Thank you for reviewing this patch.
I have sent out a v2 patch with bindings containing interrupt and wakeup-so=
urce.

I am not sure if I should mention the "wakeup-source" property, as this alr=
eady has a property called "interrupt-names" with value "wakeup".

Please help me suggest if I should remove the "wakeup-source" property.

Thanks,
Neeraj=20

> On Fri, Apr 11, 2025 at 10:07:18PM +0530, Neeraj Sanjay Kale wrote:
> > Add support for host-wakeup on GPIO interrupt.
> >
> > Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> > ---
> >  .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml  | 7
> > +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> > b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> > index d02e9dd847ef..ab1411c05f49 100644
> > ---
> > a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> > +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.y
> > +++ aml
> > @@ -48,6 +48,12 @@ properties:
> >      description:
> >        The GPIO number of the NXP chipset used for BT_WAKE_IN.
> >
> > +  host-wakeup-gpios:
> > +    maxItems: 1
> > +    description:
> > +      Host wakeup by falling edge interrupt on this GPIO which
> > +      is connected to BT_WAKE_OUT pin of the NXP chipset.
>=20
> Read the description in the Broadcom binding you copied this from.
> Define this as an interrupt named 'wakeup', not a GPIO. After all, to be =
a
> wake-up source, it kind of has to be an interrupt.
>=20
> Just because I said no to putting wakeup source handling in serdev, doesn=
't
> mean the binding should change. The handling just has to be in the driver=
.
>=20
> Rob
