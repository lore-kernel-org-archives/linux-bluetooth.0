Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012012.outbound.protection.outlook.com [52.101.66.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD85F224B0E;
	Mon, 17 Feb 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806892; cv=fail; b=TygOfLZzb3GjuB0+NCeHyn/bjpHIqwqOuW1XOzuQhzi5WGp4kyr81TqW0mOZjuaIK3OxbTTamgom0wgYccuRrTmhcAlI7k8n1zG9yrp3Yhk5odAYWx4GOgsP52a/RHET7m21dFEHJrPnNydWjv7BVOnEXVaDMdM45lrRQZLXOiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806892; c=relaxed/simple;
	bh=Mu+jgvUHg/aD32J9dy+EmG23+lNJTP9XPE6H1Ce6jdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hkzEq2d7drHUBZImrNX7tE6QqLOgFeD8un6rmCrN/Pj/0yrpBrjfvlycQUKCSX4YJl8F0s5mXxZ7VqvPOlNlluaD64hysEhAg15rIrqZpmapji//7wBQKdNVBkYqpeqz9uE6+oiKqbCkIzVli2d/THc7DrvbVSvpPrma/Q/aOh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b48jkj3L; arc=fail smtp.client-ip=52.101.66.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b48jkj3L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veDRTpRFeS1pXuMih0VHYIl7DxhFgf87zi5eUdgem9dJ1l83QeZs9dXZs7rIBdNscv74a2T3Lg96jR2Fru/+UXYmDqS1OboNVkztYUI2mx3uKMmf2odLLf7UY1bXMBmOZF9f3nwA/jNwNxGzS/UDQ9kKs86S3Fy2wqS7fu6Ir4mD8W0NnwhQQyCZ9qxdoOBEdUnH4YIr4m0W99nay8ZZgMxrhuhqJyyONI7r2sfdzPKfZby6A2hzT3qVAovDhnx8Xg4EBUXBdpzJi3kVmVEh3pjLOi1lOYNLHn2Hqx7sf0iVfyKLLiQPswIgg3SBlTDtvkLW/gNzUSEVY5J4B4atGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu/EsMxxOoS9wZ1He9feuRvFhIpaI9hKQpdIQgY/vHM=;
 b=zTLFVMcdfsl7MezQWrsMLraxBU+tV6mCKw8kA1b3Si1sSkmudLTKrtC+3iuf2hA4j/KWelpRkhFuciReIsOO2ZUaZNOu9FmeZ8xmnY4dHzLoJ83VX3HlhgYHAo9XPJYznMw3JaWm+GiKJDsqeb9i427dGaVJhe8fywj3mdx5mSsBUTxL/e9RQNqE7nksYorV9MnuM8MxYMzLYvMJPefEemqzI/COszith3Ol98Qj9XKPDLraD4kO5CUAb4M2SnW9w2sz6ITKJI9wH6Z/S+mJSzwOxZb7H7Y/QFDi5Rd3fZ71SKvRL3b8HVUdCYD8QZqWF4fmLHwZ910zG25WmxoCIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu/EsMxxOoS9wZ1He9feuRvFhIpaI9hKQpdIQgY/vHM=;
 b=b48jkj3LI5YJF//CLJArTh6YxEL5iVnrLVeiwGCvTjmk026FrGKDk5siFUeCTLpxHYN0CUcdl+rO6aag9A8Ojpm6kaLUH8GeRg5z9kt1YiLG0WZKAFaL9yGsEqrb1fvEs/5Dxgap7utaDkGV/2PKX4uw6BD+sqLYDmwk/Jbs35hV1cbYExQkL3K3aIUZ7y4388/lqImj7eu5D7Jzkbt6Tb4zfLXcEwMAU/oQ2USuV3cxT7Ui34sBDeIq3khl66YNpe6Ya+qrgEA0g6aaa1KrqO8zRckbveScsN4q8L+enSWdyyRhCNhVS0EV7Y/A45iLmGvZ4HLGoHDFHdFE4j3Crg==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS8PR04MB7510.eurprd04.prod.outlook.com (2603:10a6:20b:294::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 15:41:24 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 15:41:24 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Loic Poulain <loic.poulain@linaro.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Sherry Sun <sherry.sun@nxp.com>
Subject: Re: [PATCH 1/2] bluetooth: btnxpuart: Support for controller wakeup
 gpio config
Thread-Topic: [PATCH 1/2] bluetooth: btnxpuart: Support for controller wakeup
 gpio config
Thread-Index: AQHbgVJm2mem/ZL3/ku2Xzv67s3cyw==
Date: Mon, 17 Feb 2025 15:41:24 +0000
Message-ID:
 <AS4PR04MB969270A58305BE9FA8126C88E7FB2@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250217131046.21006-1-loic.poulain@linaro.org>
 <AS4PR04MB969252FACA03605C1C0E00E3E7FB2@AS4PR04MB9692.eurprd04.prod.outlook.com>
 <CAMZdPi8X6tMoLocskyEG8GwdpZ9i8P_R1bT=r1-QF+sb7ofP6A@mail.gmail.com>
In-Reply-To:
 <CAMZdPi8X6tMoLocskyEG8GwdpZ9i8P_R1bT=r1-QF+sb7ofP6A@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AS8PR04MB7510:EE_
x-ms-office365-filtering-correlation-id: bffbdfd9-b2b2-4ec6-6c14-08dd4f69891a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FpHyO50WBAnCBmMA+na8/fmRuvkDC/pRd5yRF3VVtZg/Jy9fGFvPqLL4qi7G?=
 =?us-ascii?Q?M9ThGUeGm55tAZ176eAX5k67Ad3RxWhdytS5+JHprc61detA8A4kETLOgLOT?=
 =?us-ascii?Q?BjBXjwIYy7AOcBPQQuE/oQqbbjOIU9LwqRDBMTb5GCvZVCefgAdJa/1GU8PA?=
 =?us-ascii?Q?PUajDKSTa05GT3qnuij7OivgFEKBF1Iq7Yf12al0V2VhEk1YOw/p4iMT2tB/?=
 =?us-ascii?Q?wLoOwRMd27C+CFFlgtYI8GLrLkRD7qOWE4lsfAvNyT/Vv+f/bye2OqwXSgwl?=
 =?us-ascii?Q?KBjkMTXXwUrmpBeTumiKsOUT3zVmK71kty6fLsQ09UM2vNoX1yO5e3ycnfDc?=
 =?us-ascii?Q?aWrS9M2+hwBZH2GRMLxoFSNqf4An5NrTVAigtw+jWpJ1dytA1fFE9R7lc5Ba?=
 =?us-ascii?Q?6CNDvFjvRkdd8UUkMne397vxCujyr6hrGv3iRaZUZUU5hb5fN9L0jVwHl9W7?=
 =?us-ascii?Q?d0teyLNX1o3TI0gYTdA7fteCs18wLkdLTRfp6AGJsoVGPAmarXLZyX1mf53L?=
 =?us-ascii?Q?Xs0Urc4AggkIzkv759E+VBYtIE1qWZDCZN77iSuNAf7nUlodZrmVeB0MoAQI?=
 =?us-ascii?Q?yLAQwbtQOZO7L+9Yn4dNZbwTXDaY1Npr/WLrzHZi1wOGXekZlRB3Lt04PIEW?=
 =?us-ascii?Q?7kcwOjr6rU76l0Zh12cEJS+QKskwQygAli3yHgNMT9vG0xingRFn7FHHqHbQ?=
 =?us-ascii?Q?85mdJYD8qECSogwKuPBeb0Lul0e6/HkQJWZwAy+KQ0dbB1lp6rFMkXQcl0Sh?=
 =?us-ascii?Q?RDR4qqlKpjp9dP1ExRD63E2GktAuGijuY8VkQuaZiFPmqPDklJpUdOKdXdIn?=
 =?us-ascii?Q?ufZQrXac+uqvLNB1BbXJnXIX+QoqHbGY4bEP+TxZiDDtcpscx4+NUo9n20Cu?=
 =?us-ascii?Q?sBlL3ASnK/AUlkhfnO78p0GpMibmagYJ7xhVY3FT62bg9unld2356hv+Lh1e?=
 =?us-ascii?Q?Cc+mnJX0Zf3oO9/z9jUYDi9mPj8hI367iQylrU9GG1aGxDFq/P40yGY4J7G0?=
 =?us-ascii?Q?nnE5ZNH7y++BU+wy3WKOVC0a4ytfKGal/phlD8HHAGfEtlLqSjUWNi17FO6H?=
 =?us-ascii?Q?uIm1bx818+MzqqPQ2yhLz52HOmmaVfXBe0fzA0Djb2fiBKPPVlokTEOgjCT6?=
 =?us-ascii?Q?nKGngr71YkHVzZBOyzf3sEe02Thy8GG7y6fJl5RiFlqgOOi6/J9FxbaDbdKi?=
 =?us-ascii?Q?gP32CV6BAAAECV+PyUxfpH6DBIaMP+wYIxlNGWhwCOrcVLYXpmmgeTP1p5N7?=
 =?us-ascii?Q?9vsgCoyAukyadl2rUow860H0olHO6NFfaPwiCR1RCSj8GFYyG0/B5e1q5q2t?=
 =?us-ascii?Q?WsVZ6sY8cBvXcNWUXdN0KS/Pc/m+0eq/G20XQ3wob66YRI+Fwxc/YAtd1oE9?=
 =?us-ascii?Q?vJueHWR7fffCfFktch+d1yrcCxWK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?x50sESu0nOQBy6KhPj6HESlKCWvK8SytOpxb9JXqSFmOm7Bn7E3BtyxzU/1c?=
 =?us-ascii?Q?N58yx1+rwBX4DNP2x5AVUoW7zPmpjhzrJfmcSDIRYC59XvmRB9UVAofyA8xi?=
 =?us-ascii?Q?95/tPhb22/5YcbugGlan0bhXTLKJJxSit24VSioIC1S5/WakZ+LxVcnS4/dY?=
 =?us-ascii?Q?7j3Aig169ytQC/EpBpvicf9iHG8pdmsuWUJFJPE8MHvUbtRof+26/geHwI+p?=
 =?us-ascii?Q?XgPn8k81CzQzWZfUx8Y+ujFc5c522uS22FjY/0LDpP6eQ2722IbqEwX/53/H?=
 =?us-ascii?Q?7hD4M/qLxBkH8rXaGkSvnrZt01yAGVv8uE+vN3LMiE9XBo4YKtRIkiH/1I9P?=
 =?us-ascii?Q?3L5+Zat5LGCQ2gzIRNqXVl15AI7kAnTFv2J/ybMrC2NNbUNPsXgIw4vKy2AW?=
 =?us-ascii?Q?X+iyyZgvExEindrj85IqROEYsEVhjDMphMe5C6X4mhLyRqWT2QXsOaxWUOwX?=
 =?us-ascii?Q?mlqBXYomVU21PYvekxO1PMgIQuutPeDy0rZGql6enX4c6FgSb1OE2bhpYeau?=
 =?us-ascii?Q?cNsvOMgMHtWxSNTVX5mxuOftEX7qux816uknP42lweFBp8jY8bRNBQOXqWBu?=
 =?us-ascii?Q?vQ3oFtcK1TqCY8M9GNHM33Kuqiq+RFvFkDqch0sneMMc4icGl6RaThlPkKoH?=
 =?us-ascii?Q?zqkpP5jZe1mR59lgUKTujJ2Sv4mt5ESdG2e9NPFnrmJG3KPfGVa0Hh2CuKgV?=
 =?us-ascii?Q?2LzYs0j1NifpE3fyXyWp3pjyIazRfdI42L/gQjBVAiTpse7x+GJEIvy6Kcka?=
 =?us-ascii?Q?M4sFLCQYlUY3zMSe6QQYh4jl4bGAqz5UmYGYZ7fLuuWe/DLXyJEWbWyELibw?=
 =?us-ascii?Q?818468UXc89ysgcnOQPmMWRc3NmEKY2HGOzU1ijh5mVw0DAkqKx6ZO8bNFiZ?=
 =?us-ascii?Q?BN0OnvSjQTNNRXYGda+h63OQLL2Rhwfw5oqjNq3K3b8WYmoMgCQaUuC6nrCu?=
 =?us-ascii?Q?UhDdbN4pfDjbbcNpPyq09dg5x8l2+KUwtvw7lxEWUdvpZT7i2Mk4rEKzXRlv?=
 =?us-ascii?Q?6pIMcNdw4g8TrqgD/h52zv+elDQMYMArXxr14Tkm0/DtV3PlnsTfeeN5YcAo?=
 =?us-ascii?Q?V7xa6cExQtClZa91ok7TllnIQddJ/q/XLszYMHdVa4iyXfrnUW11RNlUt3+L?=
 =?us-ascii?Q?pBvuSc0pgiofxZQrdgQdgYRY+XIoaduvr1H8eP5UUfhQzBSbqSTOyU/k6lWg?=
 =?us-ascii?Q?0cvJkJ9zNil7Uz8Ynp6L/LHuqHqffDP14QDe1XEEu4cw3o5v+/meEL6LaUSA?=
 =?us-ascii?Q?qi/q51CYD969aEY8JryDe5X69hGKREq/vhMz0exvV90KlGchQQ+VUOK7wqWt?=
 =?us-ascii?Q?rPxcEDL3KkC7N+7hlG8nr5J46zTVSR8AkqcB3fw0WmhCBgtPrgU9UeC2xNpN?=
 =?us-ascii?Q?ZN5deyveHo8YPqSQ5vuU7N0+0fJ78OmhQUQFvq9ntZxBnWCIsE8ReXjd/mW1?=
 =?us-ascii?Q?5mPjIc2Fe9FDksXjGtNjA1Nrf+SlOxQGGNpA6OO1sYLFxL9ZFN7wBSLA2jQu?=
 =?us-ascii?Q?N9g5qLrtSdVaV+yyNpWkYenttJWOaIzGpcE5WcwMmB+SpZrQxYTWX6IMutDT?=
 =?us-ascii?Q?2KoevCEuqT8lKSIwCxfwhkbdLoDZ8GBmN78CZGYR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bffbdfd9-b2b2-4ec6-6c14-08dd4f69891a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 15:41:24.6796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F5OtYoBMAGFMGNpjbCY/z0weemWnhFm6T97aDy9e0SI/IqKusovwLWhs7Zg0yHi7JwFUbNf607FZQoJ3Idu1YeDDj0hXYjS/jkNT0G0n5Y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7510

Hi Loic,

> On Mon, 17 Feb 2025 at 14:53, Neeraj Sanjay Kale
> <neeraj.sanjaykale@nxp.com> wrote:
> > Hi Loic,
> >
> > Thank you for your patch. Just a few suggestions below:
> >
> > > @@ -616,6 +617,13 @@ static void ps_init(struct hci_dev *hdev)
> > >                 break;
> > >         }
> > >
> > > +       if (!device_property_read_u8(&nxpdev->serdev->dev, "nxp,wakei=
n-
> pin",
> > > +                                    &psdata->h2c_wakeup_gpio))
> > > +               psdata->h2c_wakeupmode =3D WAKEUP_METHOD_GPIO;
> > > +       if (!device_property_read_u8(&nxpdev->serdev->dev,
> > > + "nxp,wakeout-
> > > pin",
> > > +                                    &psdata->c2h_wakeup_gpio))
> > > +               psdata->c2h_wakeupmode =3D
> BT_HOST_WAKEUP_METHOD_GPIO;
> > > +
> > >         psdata->cur_psmode =3D PS_MODE_DISABLE;
> > >         psdata->target_ps_mode =3D DEFAULT_PS_MODE;
> > >
> > Please move device_property_read for "nxp,wakein-pin" to ps_setup(), af=
ter
> "device-wakeup" is read.
>
> Ok, but then I'll need to move all the default value handling from
> ps_setup() into ps_init() as well.
I don't think that would be needed. Simply using the example code I mention=
ed below should suffice.

To re-iterate, if "device-wakeup-gpios" is defined, we use WAKEUP_METHOD_GP=
IO, and if "nxp,wakein-pin" is present, use it, else simply use 0xff.

But if "device-wakeup-gpios" is absent, use default WAKEUP_METHOD_BREAK.

>
> >
> > I think we should not set h2c_wakeupmode as WAKEUP_METHOD_GPIO
> based on "nxp,wakein-pin" alone.
> >
> > In existing code, we are setting default_h2c_wakeup_mode to
> WAKEUP_METHOD_GPIO if "device-wakeup" is defined in DT, and psdata-
> >h2c_wakeup_gpio =3D 0xff. WAKE_IN pin is not read.
> > In this case the FW considers default GPIO as WAKE_IN pin (as per
> datasheet), which is a valid scenario.
> >
> > But this logic will fail if we specify only "nxp,wakein-pin", without "=
device-
> wakeup" in DT.
> > Hence, I recommend something as follows in ps_setup():
> > - if (!psdata->h2c_ps_gpio)
> > + if (!psdata->h2c_ps_gpio ||
> > + device_property_read_u8(&nxpdev->serdev->dev, "nxp,wakein-pin",
> > + &psdata->h2c_wakeup_gpio))
> >         psdata->h2c_wakeup_gpio =3D 0xff;
>
> Ok, will do, look like we should print an explicit error then, as it woul=
d be a
> clear devicetree misconfiguration?
Yes, an error print for "nxp,wakein-pin", without "device-wakeup-gpios" wou=
ld be helpful. Thanks!

>
> > For "nxp,wakeout-pin", I have yet to submit patch for "host-wakeup-gpio=
s".
> I can move "nxp,wakeout-pin" later if required.
>
> It may not be necessary, I've submitted an other PR for handling simple
> dedicated wakeup interrupts at serdev core level instead of having to re-
> implement it in each driver:
> https://www.s/
> pinics.net%2Flists%2Flinux-
> serial%2Fmsg66060.html&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%
> 7C979e9f5f906b438d707e08dd4f61b6e9%7C686ea1d3bc2b4c6fa92cd99c5c30
> 1635%7C0%7C0%7C638754003307634680%7CUnknown%7CTWFpbGZsb3d8e
> yJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoi
> TWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dh%2B9yWxHbWkimN
> 7oHOM0ZU9Cgi1OK86NLGKP7Hw%2B6vRs%3D&reserved=3D0
>
> With that, all we would need is adding the wakeup interrupt in the device=
tree:
> ```
>         interrupt-parent =3D <&gpio4>;
>         interrupts =3D <8 IRQ_TYPE_EDGE_FALLING>;
>         interrupt-names =3D "wakeup";
>         wakeup-source;
> ```
Yes, this was my initial approach, which works fine. But I think using "hos=
t-wakeup-gpios" would be a cleaner approach.
Driver will simply use the gpiod_to_irq() API to get an IRQ handler.
```
        compatible =3D "nxp,88w8987-bt";
        host-wakeup-gpios =3D <&gpio3 24 GPIO_ACTIVE_HIGH>;
```
Please do let me know if this method has any drawbacks.

Thanks,
Neeraj
