Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A63C19B59C;
	Tue, 22 Oct 2024 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607064; cv=fail; b=WurmJlRK7ykmlTkdzV+SiyK+PlCtNH/BcqtUFDtQICfQ70v5VwneUuGinisfjI3ExUJVr3m2uOEdLAuMiQ9g61iqXCI4JpTjeRaJ3HQpUh9dBgrMzptng/JbDg2gyY6/UC0LDV9KZbHWmvzEIoXyJreldLWgRznlrOjO6ZC6HeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607064; c=relaxed/simple;
	bh=e3RS3rmBPc2vU+dFxthJ/pe8yTyBYmBsVgRauFwgfqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PtI0i2DMMkscv6jqPHt1IPgPuxDayOihZSUBFeXMkKBb81U7iidFRZMhHKR+RpDqgPvKoFXxdhB1wOHXny4+AgMk5kCb4zUsWsRU9nLzPKwMKj41n6VGlB1tOKboThTnOkXY3zrwtl0IrDxgSP/VUBQf7axobrvrHjEhTZzsSL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=enfk/WuL; arc=fail smtp.client-ip=40.107.241.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="enfk/WuL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lenv+wBPdHMiS3+sl6ZJmsk1AMYHGgIbjSUK3ACfK1JIEoyvUPljwy5Xy1k1ddQbnhDlUng2sJQ/dV+VKksAqIupNaarjIRmuGpfL6lR5RVu3u+CN37fBuJEH3LuFzDU0YFNr+gG0fVp5RXIXlPcxwRwcR8hjPJWF5BB1BjZQ8TCXG5pIdoFCD8Bj8UcJXzoq5pQ2Gk0LHIjmNE6QOOYwOmOSgz5Ojtr6wKdkOQDn6TCmf/xeXDSee1WLdCTzSyUWL3uDALiI0voKBLTJmxjJMOJN7HsXqOWSN8b6LW5YoSN3lh+9YuoWBTKpQb8SRhvDD4CebJkNkgDgD42J25g9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbfKxymW9aFvLGRdrIsdIKPBSJe4ime0N+NqsjpSpZk=;
 b=XU8Gsvmbs5dThAFaCMMC4B9UWmJpHtKBP16bTxlfBw5Sp1YyFFPdvzgdzezSLeJrkkHVhd3uq80k0HMLXPRiy5lM9jWyYG+NdvG68s/780Fz2XYbRctTyQU94677ov5L4skFCOkL4X6VGdkx6nGiAnlM9N6jK12qI+AjWWpqCw28ZgwFB+mFWSPsfrUW7PIdNk6KtIns/BVm64WKCKINljuVOmg6DlOA7qWZFfj4jMjWEthLNUdWYKve6qN+o7zvA5s8bLl1Ps0nv07rZ9lWS+kRecVOKSne/O+ZQ+uwMj0QXtivDP6xWFoOKxdxKoeRknAJ7VzhPKnAWFlnFjFJDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbfKxymW9aFvLGRdrIsdIKPBSJe4ime0N+NqsjpSpZk=;
 b=enfk/WuL68dlJSfjARAFDa3mrm+k91DC22UBgmYRn/jvq4RGjjELlC2sjEU8ExzqDxwEbtKIsT+24VGOe4yBYrltgPUIPtJteZmHpjLGpB0qU24uNxI3H85CJ8KpTgrQIr6ByMCbjDqHgqliOBXTx6L3tNgoZHc3UFUqIPj6BpikPxgWoFmT6NteNdq/ixX2eyZkf8qN7mVLGKBu2/lFsVqZIUlkerBmxg22p3mMJP0f3MGn7p1dx4AmEV1B+2/X66nOsAnpexM53EEyFrMKFyTf2ha2hcn92IzRB6q8WtcrJIFCwgs0930njGLmKo2rvrg7VE0V/ccHXJDEUMxbbg==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DU0PR04MB9564.eurprd04.prod.outlook.com (2603:10a6:10:316::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 14:24:17 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 14:24:17 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
CC: POPESCU Catalin <catalin.popescu@leica-geosystems.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Thread-Topic: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Thread-Index:
 AQHbFlGi4L5ELajEYECFBoJDru1aa7J5aBLQgAAySQCAAao9AIAAIGOAgBV25oCAABNWAIAAK2IAgAE1RoCAACn9gIAACuYQgAAFzACAAF/eYA==
Date: Tue, 22 Oct 2024 14:24:17 +0000
Message-ID:
 <DB9PR04MB84292445D0FEDB8211ED52C3924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
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
In-Reply-To: <20241022082256.nzfxqp67tdaxtn56@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|DU0PR04MB9564:EE_
x-ms-office365-filtering-correlation-id: bc6e4762-e164-4662-601c-08dcf2a5363a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ichDeVsFhAJkmnEJhkErng1X+Z6/G2mIyNM1pzhox8+BhbhMifcWmXBeFYQK?=
 =?us-ascii?Q?ylt2edG2/TfWnvgIgLyF9CwrfYIbO998WI0/0u2xwMpILkty9dQLzAGr7nHW?=
 =?us-ascii?Q?Fe5N0NXL8OOOiMuTQ48mUXHOvl6bcnF2l8L9zkzyPePv9DZHtUyJL42sFeUJ?=
 =?us-ascii?Q?OQqWpGTNDbkEPI2h+47QGp/mnvM4DttwPlgDXb6zWLFfx/ruw9W4jgXX58Ib?=
 =?us-ascii?Q?iEYK7iodbVPE6VjNLQIg/j/Vv90TvOO//1gH87BZ9Mdr8HkvX9ImEgYV6IbG?=
 =?us-ascii?Q?pFI56+hNWHKj4ud8X6NxcGh3EZ5yozHGG4zyMQs5GtFiwRIK0uV/oVyrrmiX?=
 =?us-ascii?Q?NTyZfd1zW5/OUV+WM5BZYW2crkn4kz4ew7KIBB2KqcaVLyVSewjmW4gWHw9V?=
 =?us-ascii?Q?9hA9mu6LJmLjVrMpltPBLSPlLH8tmRpoWHvRI/upg1n4UxKTAFvATmp9ZDKk?=
 =?us-ascii?Q?ZdazHw0WRMjkf6fgsAUbsl1DI9vuEHkhi7pEoSoYDKSp0tSWRy1MVIWDtgPe?=
 =?us-ascii?Q?OzvKawKc36vzVheN7fCxIHzWu+UkifG2XQJMI4T7zm14Rwher+OvX9NCCfLv?=
 =?us-ascii?Q?wJKxG95D/GoIbPkLX9xE076RrjBXabO0cYh5T6KbmnFqAbCx95Q3H1FJOcyr?=
 =?us-ascii?Q?nXnUiSqApLxyXX1eknIQCrmeg5GC1H+f+GzpBKmoqMyizFb1quECSftl6gz6?=
 =?us-ascii?Q?ermqLdrEF2W1yZtvXHs8fbNo7PXbddMtXFwA8HOwhD0g68llVI/uN29vTKUq?=
 =?us-ascii?Q?X2LXPscd8SuGap1CtlJ6x/X3W/C8UFA96RgfgEn5n8tAouRc3CJG9M/pg2Kf?=
 =?us-ascii?Q?99MOlqLhK7PQiOm+fLNjUNhFf9ctRX0b7YAUKCD7nm4g4oCoAugcYt1BcnpA?=
 =?us-ascii?Q?S4pNoIVsMCUPPnT8dCjBvmP52KZj6chQdYhhOMLyne3nHttTnFYyMEijS2BB?=
 =?us-ascii?Q?4pBd9joo+5ueFC2pAXUeHMLi0hUxWRP5Yd4ZKRyIA6X7ePStXJzIGAxSBa9x?=
 =?us-ascii?Q?BbCik9ilDy6jZ2hNz2RoKDHgdLK1qwDVvecXIXt0tDeJOa8NuG72vmx90XBT?=
 =?us-ascii?Q?Ee0jq6aTzk2Y4RYR0QuylGouY+LVKXOvZymInSaDVgM79ecbkAPAUDZB2gDD?=
 =?us-ascii?Q?no/YHuk0+OTHmzxkBXs1nsJAbfCq2gFIUPVKE/LIqq0BsCfQDVtVmxrN0SJf?=
 =?us-ascii?Q?Zr311jvxJCblRva3DDiTvGfDGWIjl0MUH/PxXYO+AvJm9cX5UrdfC0/A+OmL?=
 =?us-ascii?Q?3O0AUbbRGrQmVXBRruARF5l0FZnyPmh3G+aaD3U+MLQ6Kfx1p9AB+YM7agpM?=
 =?us-ascii?Q?QVVkisvxTV4MEsI7BAW9LLf8DQtDAr5tUT/Mf2OT+RB8k93sTyILlaUyr1Ua?=
 =?us-ascii?Q?WURcbjc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+TvhNI6bpLaCd8Zrwuotz96OE9ucHpg/UbduCcknlN5IJCoQhrgVKXmrawSm?=
 =?us-ascii?Q?7JBfdnXMLyNXUGSt4uQenOrDdznJt5xHnN80AYrK6NRqAzKsLS2aTYzZ/dvg?=
 =?us-ascii?Q?glyGtt2uI8S8fqoP3jCn9+7U5+p+xMJaPXIIsgmWkDHuweiU5Ao4114gwHQY?=
 =?us-ascii?Q?uvj53HBwnULZqj29YgxubQgnW5BZoSSOptzVLTQnZ5bVrg8adsYnjlLR+iYq?=
 =?us-ascii?Q?y1cdDpd+1NlbUSLwefTegD8+/JZX7pS4ncGbO5NMS4qUNy9lQnesZ7l0zqCQ?=
 =?us-ascii?Q?tMWngwGyMDvX43kPXQBWbH8+njCjLUifY8UJBUO/AhLP8CSE41jCWIr9zvfR?=
 =?us-ascii?Q?6b6MOB+ZsPebbrgngbXhOk+da/e8BBg1nsvRgeWdqTx/9TlaaSUxXF6zSjfp?=
 =?us-ascii?Q?Nc8MY05nk6RyHEzEPnZ9P6EN1scqLT+GEjVj0G++9gqi0pSlkkqkyZqbbVic?=
 =?us-ascii?Q?TnCY45r3IPDXGMRpOX5q/OcPBzRXKdmmKyxdNUdTi+/rhyNNZ5S/mu83nm81?=
 =?us-ascii?Q?a1WJlMQE3/9EUb0UeYp9eGCBqfE8JqbNCRjNGVU45MCASotrm1OvhYoUKkfY?=
 =?us-ascii?Q?/nXahnY1WCjHT5WwcQDvfZVYh/yojS0sBahyzlN/V9rdN3Q9PAb0/Om4ThiH?=
 =?us-ascii?Q?pGsbZ5+WCL6iQNqAxJEWudlF4Clw//N1zhRMi404PIJtLIr/yQ4tdbsULyiD?=
 =?us-ascii?Q?Iok/hJfpmtGHzSccEB6G/NYmoFdcZmYQ2LH6Bk2onsXk4kgQHj8IteByrVpD?=
 =?us-ascii?Q?7b3MkNwXtFJhHYR/4JFgXMTusK0ehCUXjULWx86bDs5eQeejYzVZiOKrSxuC?=
 =?us-ascii?Q?i4OzpkCgE0X4P7UFqcou98baPVlY+/lkhd7yol+lN+uBi2Nf9zG3ylXgfcjO?=
 =?us-ascii?Q?NrNf76xU2+wCmHe+d1+MJT7tFLr6syklYrq9CGU50e6FNp9LDrcsjEoRm9Sn?=
 =?us-ascii?Q?SE7u5W1CDDN4tq4bepLp2kAosqDOaKvxBY99KF83ngW78VErXmFv4nCzteOh?=
 =?us-ascii?Q?/3sbm1158NCWY9l+m+gmP1JBZBjv/mYLrRkxo/ZV9TOAv+uQToTGIY2f8B91?=
 =?us-ascii?Q?BkqvsHWpEQLOHfDmyOEWWQDDetoUR7kO90qN/O7Yy1A/+CGD0sExNY5svPkm?=
 =?us-ascii?Q?DWElBdBwG+iDJukGqjRJSWVZ+Vtw9lnvB8KDuC9bU5YB95IY5CBdcqvHW/sp?=
 =?us-ascii?Q?/LezU383+Y4YArLcDZZ6G58gGywhgdrL/hdArk5fV3nOIqHV2U0DYpu8WTY6?=
 =?us-ascii?Q?B6miwN05OC5dPZNajJfHA3m/VVyaJHGTBnHYZJXSCmODtI2BiZ9DoGmaib9x?=
 =?us-ascii?Q?4jJUtRw5rXU331qY4etJ0/2T6zGHyTP8v7wJT03L8dmAvMsdiDAPiMU8sEBv?=
 =?us-ascii?Q?Nmt0WWSRdKfr0Po6r6Ml7XQ3DKVQ9n4mC7S7K9cSnKp9biaFeLi0ebLcZj46?=
 =?us-ascii?Q?bUUCUrFGZJkjO6MDFNo98Ma3afGSkrWbyq7DXfV/OkiyJ/S+ot3k9tTA8xpG?=
 =?us-ascii?Q?d24UNF1nQ7dTaysUBX1xZ0AF74VZL5Wz4Fc4GszNjRQIducj4fU6eYRl0rlD?=
 =?us-ascii?Q?fqHwYpJHN1HeF7V5lx7ryAMzFXBpkdspWaAxKUb8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6e4762-e164-4662-601c-08dcf2a5363a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 14:24:17.2559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jrAT240EZRwzbJXQfN5n4pLJ+lgq90S2jr06iCH3BzOzMymTnobjofOUHAHCG1tNnl9zt1K0YhaT0NgP7QLJVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9564



> -----Original Message-----
> From: Marco Felsch <m.felsch@pengutronix.de>
> Sent: Tuesday, October 22, 2024 4:23 PM
> To: Sherry Sun <sherry.sun@nxp.com>
> Cc: POPESCU Catalin <catalin.popescu@leica-geosystems.com>; Amitkumar
> Karwar <amitkumar.karwar@nxp.com>; Neeraj Sanjay Kale
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
>=20
> On 24-10-22, Sherry Sun wrote:
> >
> >
> > > -----Original Message-----
> > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > Sent: Tuesday, October 22, 2024 3:23 PM
> > > To: Sherry Sun <sherry.sun@nxp.com>
> > > Cc: POPESCU Catalin <catalin.popescu@leica-geosystems.com>;
> > > Amitkumar Karwar <amitkumar.karwar@nxp.com>; Neeraj Sanjay Kale
> > > <neeraj.sanjaykale@nxp.com>; marcel@holtmann.org;
> > > luiz.dentz@gmail.com; robh@kernel.org; krzk+dt@kernel.org;
> > > conor+dt@kernel.org; p.zabel@pengutronix.de; linux-
> > > bluetooth@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; GEO-CHHER-bsp-development <bsp-
> > > development.geo@leica-geosystems.com>; Krzysztof Kozlowski
> > > <krzk@kernel.org>
> > > Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add
> > > support for supply and reset
> > >
> > > On 24-10-22, Sherry Sun wrote:
> > > > > On 24-10-21, Krzysztof Kozlowski wrote:
> > > > > > On 21/10/2024 08:41, Marco Felsch wrote:
> > > > > > > On 24-10-07, Krzysztof Kozlowski wrote:
> > > > > > >> On 07/10/2024 14:58, POPESCU Catalin wrote:
> > > > > > >>>>>>
> > > > > > >>>>>> +  vcc-supply:
> > > > > > >>>>>> +    description:
> > > > > > >>>>>> +      phandle of the regulator that provides the supply
> voltage.
> > > > > > >>>>>> +
> > > > > > >>>>>> +  reset-gpios:
> > > > > > >>>>>> +    description:
> > > > > > >>>>>> +      Chip powerdown/reset signal (PDn).
> > > > > > >>>>>> +
> > > > > > >>>>> Hi Catalin,
> > > > > > >>>>>
> > > > > > >>>>> For NXP WIFI/BT chip, WIFI and BT share the one PDn pin,
> > > > > > >>>>> which
> > > > > means that both wifi and BT controller will be powered on and
> > > > > off at the same time.
> > > > > > >>>>> Taking the M.2 NXP WIFI/BT module as an example,
> > > > > pin56(W_DISABLE1) is connected to the WIFI/BT chip PDn pin, we
> > > > > has already controlled this pin in the corresponding PCIe/SDIO
> > > > > controller dts
> > > nodes.
> > > > > > >>>>> It is not clear to me what exactly pins for vcc-supply
> > > > > > >>>>> and reset-gpios
> > > > > you describing here. Can you help understand the corresponding
> > > > > pins on M.2 interface as an example? Thanks.
> > > > > > >>>
> > > > > > >>> Hi Sherry,
> > > > > > >>>
> > > > > > >>> Regulators and reset controls being refcounted, we can
> > > > > > >>> then implement powerup sequence in both bluetooth/wlan
> > > > > > >>> drivers and have the drivers operate independently. This
> > > > > > >>> way bluetooth driver would has no dependance on the wlan
> driver for :
> > > > > > >>>
> > > > > > >>> - its power supply
> > > > > > >>>
> > > > > > >>> - its reset pin (PDn)
> > > > > > >>>
> > > > > > >>> - its firmware (being downloaded as part of the combo
> > > > > > >>> firmware)
> > > > > > >>>
> > > > > > >>> For the wlan driver we use mmc power sequence to drive the
> > > > > > >>> chip reset pin and there's another patchset that adds
> > > > > > >>> support for reset control into the mmc pwrseq simple driver=
.
> > > > > > >>>
> > > > > > >>>> Please wrap your replies.
> > > > > > >>>>
> > > > > > >>>> It seems you need power sequencing just like Bartosz did
> > > > > > >>>> for
> > > > > Qualcomm WCN.
> > > > > > >>>
> > > > > > >>> Hi Krzysztof,
> > > > > > >>>
> > > > > > >>> I'm not familiar with power sequencing, but looks like way
> > > > > > >>> more complicated than reset controls. So, why power
> > > > > > >>> sequencing is recommended here ? Is it b/c a supply is
> involved ?
> > > > > > >>
> > > > > > >> Based on earlier message:
> > > > > > >>
> > > > > > >> "For NXP WIFI/BT chip, WIFI and BT share the one PDn pin,
> > > > > > >> which means that both wifi and BT controller will be
> > > > > > >> powered on and off at the same time."
> > > > > > >>
> > > > > > >> but maybe that's not needed. No clue, I don't know the hardw=
are.
> > > > > > >> But be carefully what you write in the bindings, because
> > > > > > >> then it will be
> > > > > ABI.
> > > > > > >
> > > > > > > We noticed the new power-sequencing infrastructure which is
> > > > > > > part of
> > > > > > > 6.11 too but I don't think that this patch is wrong. The DT
> > > > > > > ABI won't break if we switch to the power-sequencing later
> > > > > > > on since the
> > > > > "reset-gpios"
> > > > > > > are not marked as required. So it is up to the driver to
> > > > > > > handle it either via a separate power-sequence driver or via
> "power-supply"
> > > > > > > and "reset-gpios" directly.
> > > > > >
> > > > > > That's not the point. We expect correct hardware description.
> > > > > > If you say now it has "reset-gpios" but later say "actually
> > > > > > no, because it has PMU", I respond: no. Describe the hardware,
> > > > > > not current
> > > Linux.
> > > > >
> > > > > I know that DT abstracts the HW. That said I don't see the
> > > > > problem with this patch. The HW is abstracted just fine:
> > > > >
> > > > > shared PDn          -> reset-gpios
> > > > > shared power-supply -> vcc-supply
> > > >
> > > > Actually we should use vcc-supply to control the PDn pin, this is
> > > > the power supply for NXP wifi/BT.
> > >
> > > Please don't since this is regular pin on the wlan/bt device not the
> regulator.
> > > People often do that for GPIOs if the driver is missing the support
> > > to pull the reset/pdn/enable gpio but the enable-gpio on the
> > > regulator is to enable the regulator and _not_ the bt/wlan device.
> > >
> > > Therefore the implementation Catalin provided is the correct one.
> > >
> >
> > For NXP wifi/BT, the PDn is the only power control pin, no specific
> > regulator, per my understanding, it is a common way to configure this
> > pin as the vcc-supply for the wifi interface(SDIO or PCIe).
>=20
> NACK. Each active external chip needs power, this is supplied via an supp=
ly-
> rail and this is what vcc/vdd/va/vdio/v***-supply are used for.
>=20
> The PDn is a digital input signal which tells the chip to go into power-
> down/reset mode or not.
>=20
> > reg_usdhc3_vmmc: regulator-usdhc3 {
> >          compatible =3D "regulator-fixed";
> >          regulator-name =3D "WLAN_EN";
> >          regulator-min-microvolt =3D <3300000>;
> >          regulator-max-microvolt =3D <3300000>;
> >          gpio =3D <&pcal6524 20 GPIO_ACTIVE_HIGH>;
> >          enable-active-high;
> > };
>=20
> This is what I meant previously, you do use a regualtor device for switch=
ing
> the PDn signal. This is not correct, albeit a lot of people are doing thi=
s
> because they don't want to adapt the driver. The 'gpio'
> within this regualtor should enable/disable this particular physical regu=
altor.
>=20

Sorry I see it differently. I checked the datasheet of NXP wifi chip(taking=
 IW612
as an example), the PDn pin is not the BT reset pin, we usually take it as =
the
PMIC_EN/WL_REG_ON pin to control the whole chip power supply.

I think the reset-gpio added here should control the IND_RST_BT pin
(Independent software reset for Bluetooth), similar for the=20
IND_RST_WL pin(Independent software reset for Wi-Fi).

Best Regards
Sherry
