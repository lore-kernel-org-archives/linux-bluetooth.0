Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3202E3FE;
	Wed, 20 Nov 2024 04:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732077872; cv=fail; b=ffL8iSU5nTboDJJWfMCUUNhV1kEZjJ0VrPba1H+lv5dTJeEiyw7XEjxdqIZuwE+364H8o1n7HP7nmu981Lb7oe0KaVbpp6YtJymH8rdP2wD0Qlv9PDYcI+ot3I3TeLHbllchT36cHPVuhQGbqxM2x2ZIiBwu4kcmkTeJFPUrkI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732077872; c=relaxed/simple;
	bh=UMyQHp8OwFk3SpHa5m9t0q0pwBgQworOU1y1uu7G1+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BM5gjaIkc5YfBo4XrwU6MVt7RWUeHLO7IlapQgHicuRCDvOm/HfXnKpCpCsHpJ/KkFntZVGFJGMKKc9NjU3Hljq3LS8gUWUss7OmBfMOuySWk/C0W5c5Ax+0kwx98hZdTnm3Wpt/6KJAR0WZem/pLY7ueEicqmcWQ0f7BmDJ7u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FHtkyo8d; arc=fail smtp.client-ip=40.107.105.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FHtkyo8d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpuuCC4H6gs4SFx3rFrzGUjFJB4XwblzCFuNdIsrdFDN6CCDW2sPHeBx3L87o1dVj/CyTJM1VAYzzEnYq66xcmo8qICeiY1fWHuwiZtMpmegZeG4ng74b6mRUcp2yGQztmxG/vSyiwDExillSB42sx59wJZFzvELXlv0iHNkYMlQFfD1EnKedKrVW2/Kac4Ccgz4/Sb+xPU5pHiVcqZrXq69o4KckCESsm6Op2KSN59dNXlYhsFBYTrJXlDOc04o8mVU5hTSpPZD+BdL9nolQGhlFGAaL4H5oqb/SqDGpbCg0KVFCf0GUaj5jKTssQhfrFD+rXO47e0FlwZ7eA73/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6onEUjcjHTkY84+eQt4YbexRd3YJHPP+2srd1ynHPY=;
 b=M3E2Lrb3M/pTHFZ6qDYhydQFhmkx8Io+SwiHNVd8BoNPrQXTJqXZV4lmSprLlUeaEJU+5WHnpoiGtGAwkXEZLaX2ob67zF4kB1Nu0IQn/bKNIlLzbY8aU946kJJeVGUsO8A8Eg01hYkazENMqUjwblPjdFC4D3FZar5NTpZioQWHaF4QfIIeDvUHGyyXxuCxMGaqNNiRO7XscKvJrmsW6k920uI/2dCTqTbeUguHmqgA1StfoaV77vSy7X566X2VqbZglwAP6445EsudHN9Xial1e/zdjFQxTzsu+CMgS9rYZnpVApOiTpBNgTa5M2fTM5fg71BqfAWSzRRJeE2omA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6onEUjcjHTkY84+eQt4YbexRd3YJHPP+2srd1ynHPY=;
 b=FHtkyo8dTgTIFnuXLW6875Hd/cKBaTy2/0jxZNMk3CRMbZ4drM0y/H6CyLwgt2sNVi0pkwuWpgoI5D2vREN6sobQpssp2wXvIb4N6IPhg+5sgXgZ8SQJZj3dFOxuYwa57rrILQtnkKdn8C2WNJPph7JqZYHfngqNenEE7AyRo7MP0HnPPP8trYROPQekhbbOeQ7EVlGAcQazLrGdW//sIhTXDM0hYzgW8rwUDICe2WJaT7j76wyI/ADhNKUheE2/M+f5nM8I3nj82G7xOnF78g3ApiaezP0MfLCcyoWWrE0QresIifQfwAwkhZhuVi9He5KNVMxLh4zSjbwIElM/qA==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GVXPR04MB10235.eurprd04.prod.outlook.com (2603:10a6:150:1be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 04:44:24 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%3]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 04:44:24 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>
CC: Bough Chen <haibo.chen@nxp.com>, POPESCU Catalin
	<catalin.popescu@leica-geosystems.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, "marcel@holtmann.org" <marcel@holtmann.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, GEO-CHHER-bsp-development
	<bsp-development.geo@leica-geosystems.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Shenwei Wang <shenwei.wang@nxp.com>, Jun Li
	<jun.li@nxp.com>
Subject: RE: ttyRe: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support
 for supply and reset
Thread-Topic: ttyRe: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support
 for supply and reset
Thread-Index: AQHbOvpYtZkeRyvmsUWcB+2/mQSbwrK/lr/A
Date: Wed, 20 Nov 2024 04:44:23 +0000
Message-ID:
 <AS4PR04MB9692BC235F0DC401BA391BA7E7212@AS4PR04MB9692.eurprd04.prod.outlook.com>
References:
 <DB9PR04MB8429CF700571FE42C997FB9C924D2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <1b8864e5-0ec7-49c4-932a-89cfbaeacc9f@leica-geosystems.com>
 <DB9PR04MB842929186683C1DF13DCBD92924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028090028.x6rzopvpcdvgouqv@pengutronix.de>
 <DB9PR04MB842960A18BB8570B04A64BEA924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028115150.fgvqaem36lwxwvjh@pengutronix.de>
 <DB9PR04MB8429B10FA73E5333685103FB924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028150048.qnqjxntns6quy7py@pengutronix.de>
 <20241118221759.wvrkvxeh4iop6jtt@pengutronix.de>
 <DB9PR04MB84299E3E1776C60F5D1F0FF792202@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241119125131.pb5lkeryldsl7htq@pengutronix.de>
 <DB9PR04MB84291CE5BAAA2E5FDAFB8E6392212@DB9PR04MB8429.eurprd04.prod.outlook.com>
In-Reply-To:
 <DB9PR04MB84291CE5BAAA2E5FDAFB8E6392212@DB9PR04MB8429.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|GVXPR04MB10235:EE_
x-ms-office365-filtering-correlation-id: ff03c20c-f76b-467f-cdea-08dd091e01cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?K1Xj6jpS61Q+0jtxiEQf4wP6KR8kevUAeJPyTB3fYck4/P7PPFrRCvl5lJyq?=
 =?us-ascii?Q?GMxFUg3Ne9A+mVwkKR1zfu6LXJoP0r/q2tinqVZNTbu3yh/rZQF0KVrIgZ+x?=
 =?us-ascii?Q?GjdpFcf7DtOLLgsTbVvzgNZzNGiQKdPdJnrhW9NABuGEa0AR1y+sXF23Ll5Y?=
 =?us-ascii?Q?JEi67RIg1654rlcZGGPIUT0SgMGrphB16y0LfZgkoRiLHpKhHzQDTdiGHXx9?=
 =?us-ascii?Q?xcs2SfKIbS/y0RQMB7Iey3ILkTDhOCj3gptO3MdL04xf+nc0R6XsPDmKBU3K?=
 =?us-ascii?Q?XK6T7UTAhYZHMLc6c4W9kXZbCUJXZjdQulzafzmv4TiMy8xUHScrhhrdgArA?=
 =?us-ascii?Q?w4rrbk7JR5AJGuaatT8xPZJ1twvzcnNGcHyJMTH7qwMt4OYwzVDeFhY+Fm5C?=
 =?us-ascii?Q?IoxCOqu7/oSevPJbJ/pGSEu2Sq4V9lngFaBd8dwaATsNKPrcshSDVydythPt?=
 =?us-ascii?Q?628d0LuzVyP0/Mmcce3lBH73bZSHIGdeLnLhTPe8KMSVb337MrozgdDnwQAd?=
 =?us-ascii?Q?NXaUrJA+mmH/PhFgiHaxASqIdFaJTmShVfw2pnEDij89Vv4eNNY+f+tjkQYw?=
 =?us-ascii?Q?8z7p0Ww/b1raiU+hV5fvPKLfyxDBCW3KN+zT0Cd+5Em+mgeVQY14S7U16quu?=
 =?us-ascii?Q?XgYkCdy6pTZjcNrTbWifl5v6gZy+e7Su2UV9lt5orL0TLyDSswCxO5R4XhWy?=
 =?us-ascii?Q?ZHCGcqLDtf1HMnK5VBftZWDSI0qNr1V5Hj9Nq6tM/VIAMfq40Ix9y0hKPLnA?=
 =?us-ascii?Q?t9AmxVoVzKznD83L6QIqqBf9Jnt2QdeWqmIc0R3kxN8FB2AhmCa/aEiTX+ys?=
 =?us-ascii?Q?oBNnWFIld9cjzb+TuyFLMTDI5jkmWrUs0qXoxDbbwLaiKeJi99Ctf+2Kp/vO?=
 =?us-ascii?Q?Z8EQRwPGzdZ5b4hM3gQXXsE+KoD7aLtgCgGTZs92LyBMQbq++MT/GqQgbXYw?=
 =?us-ascii?Q?T7U8tnP5arNy9JmB8H5TNtGHN8OZ9lIcASgAACThowkf3ZzXHQq7AWYOk4YT?=
 =?us-ascii?Q?6ittSoFHCsjY7z6OAKGNM8zwiAzS41xHryztWxXH1JuPl+nsw73fp1+VnEL5?=
 =?us-ascii?Q?F5KAh+/Ge/4yJ1des7q72BW+hcuQnq9SGIn5rlS82LbM9jsVr87PN7+m0apW?=
 =?us-ascii?Q?2NZo4KsXh1/pGxzb0nrN6b4klf/G59YIKNmmzBYMskSBSoiRymyi9a2ALpBr?=
 =?us-ascii?Q?fsGc9W+l7WPK0yPqPqwpR7MsOzGMCbwVWbDKJyc4E00ZRGudt29C0XWom2gc?=
 =?us-ascii?Q?qIrS+6V8ePuatey/QjktaHcKLMSwcKuRRVTzKmTdIRUR9nqnMePwwo8wG/Bc?=
 =?us-ascii?Q?TYUN0ZMkzb1CLMlLfL0BoUdBdOW9RVJzh1VO3J9rkrWgtucfwnDsNC0Uqqfg?=
 =?us-ascii?Q?ezqUMKY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SUE7omaGeAhrcapcbacNx80fDLydokDbGMsNw/vKOfVMkytK6305PlHwFNUx?=
 =?us-ascii?Q?5+Rij6BsAlIBsKJ3NfYIwNKV6xAIf1w4e8/VGCRravpRfXqKPBmPMzJ+Z/v/?=
 =?us-ascii?Q?hR+Ksx+xToajNpP9ug/4ofe2p7cwkNWXK4QesvCq1sZU9Pz+QgdPu4xXiL89?=
 =?us-ascii?Q?b+M2cP+/XV3xwKFrriXZ8F2RClgIZttz8AhK5IIAlxdM1sIb5PxOKXJIpTiK?=
 =?us-ascii?Q?15JgZBdoC3Pybdvi8aw/n1ANAR8HPWQVWU+m/DFDnttPJoHmHkEH8H8I/o8I?=
 =?us-ascii?Q?aGEhZ3DoDOecscmdgY2dDwvmQM4/apG4Rt9SmhCP9fsKX73qvPDC8fi66a5d?=
 =?us-ascii?Q?ap1U0sduNVg53guCaScth2NieUYBFmXgWHIwxmAKI7vLTWCgjJA9Ewo9+K6v?=
 =?us-ascii?Q?mtS1V3UvEdHffpaorpITK/MhrNshDzCRsbGEVI7CBhTutoeWY7wmha+cFM7E?=
 =?us-ascii?Q?//krypB6525JdHLROmFE8DD1SAL9IjxCRNgbVnMCu8e7+CeHAWyM0iLJk3TL?=
 =?us-ascii?Q?nbwX5lwlyEnCb4DmsETqav0yaeYVcuqyqKtbrZXGJDzM2jtH0oGhptl7z3Q6?=
 =?us-ascii?Q?1H/pgQBmeekqMBuq8ef/mtBbsGicXp/HKg3I4Pk5yJQ7er20lin0mcCxq5VX?=
 =?us-ascii?Q?o6nT2+uGgXr2K4xXRrZkwe9js+1uRIzFIg5DRfCNuDl1PKyouieeB6ZtSh2h?=
 =?us-ascii?Q?VKwIvEYWOvNtq1ergNM37OAJVEH6V/CyV96PkN4k4uDKORbj0kMemm5GWEPh?=
 =?us-ascii?Q?EzO7P19NoWpKNuH2KDuv5fn0Nsck/ia9sXa3gjyHm/8u/JICA+vaBggT4rb3?=
 =?us-ascii?Q?DyMDaJMPj580WUcYixFkfXJ19sc1Lw51GrohCaLeaUOCevzZsOMcQXlQ0iA4?=
 =?us-ascii?Q?nYGv1Iiy1XmdEzXGOi5465erxfC0oCSjoRNx0H7l0KzAdTOkkCANTiZohfxN?=
 =?us-ascii?Q?tGPiLElVx6q50iVVemZvq1EdS/IoHiU0U/XgRNAcSCb/gyZXK8BhmKkRtax8?=
 =?us-ascii?Q?n0Dco319oPQTdUTmoB4qBYruoCkTpGyNXNpuYBmB3dHqHTam2cWLGi38PwsY?=
 =?us-ascii?Q?YBRf8pe4SmdF05i8nGA4Jf4Djhrl6TKBor2pVBViVrMS0ZE9pgvAeUDZxpmj?=
 =?us-ascii?Q?lFsBwL4yte2U2PaJgmP0djxRBwSzzrTj0mSD9bvKg9wUqDhTBmqFfmhJgrY7?=
 =?us-ascii?Q?vN77FHO4SXth5zWU39JXxp+lbb0Xphp6nGtumjDRA1mX3tLBiidWoXuTKIXq?=
 =?us-ascii?Q?ehQCem3Bi6zD7K3ybqjWo3NnB7XLpmhqxwbLN7UBZvHff/jFGicwWyOvPgwS?=
 =?us-ascii?Q?wBxp8fH1XYvd6ZpeWVgdjgpJzs+EVmMmc8JGt1VYEApzN3hGgHPbeQgrEKt5?=
 =?us-ascii?Q?Ymfrva6g0I1JGTyE1WiJkt3MgSlJZM5tOqH5dybLpsoYrbUvawHIz6JsPMHV?=
 =?us-ascii?Q?Z43IqvZYztgF5AgBlSnQfVcADBFi5Lj5xK0Y9lnfAEVSAVw8XOFISsD9Ox2Q?=
 =?us-ascii?Q?nchQK7pKmq19gUuoy4VywCOkWgLjjHdu9lJP9V4MCAdvc+DyVmTzh2IoMJ+Z?=
 =?us-ascii?Q?ss2VAQ5tmPm5ddytWgwmfRi0VFZ9ONM2axUqxzAQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff03c20c-f76b-467f-cdea-08dd091e01cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 04:44:24.0171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YT9qYrADQsmxDj/2yGntCEly2hAtVSmS359ZcMUZr8L9zbHn4N+38P8s6kaQGTNkB/7LFioGcKAPNnXtKjYmu34SMs2ouKcxOSPvi5jZ92c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10235

Hi Marco, Catalin,

Thank you for the patch.

> >
> > On 24-11-19, Sherry Sun wrote:
> > >
> > > > -----Original Message-----
> > > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > >
> > > > Hi,
> > > >
> > > > gentle ping on this discussion since I'm still convinced that this
> > > > the correct approach to add the reset mechanism and handle the
> power.
> > >
> > > Hi Marco,
> > >
> > > Sorry for the late reply. After internal discussion, we still have
> > > some confusion regarding this new feature.
> > > This patch do improve the independent handling of wifi/BT, but with
> > > the controlling granularity segmentation, many different wifi/BT use
> > > cases need to be considered.
> >
> > Sure!
> >
> > > For the case -- WLAN (SDIO) not used + BT (UART) used:
> > >
> > > The ideal behavior of BT should be reset and the standalone BT FW
> > > should be re-downloaded when unloading and re-loading the BT driver.
> >
> > To make it clear, I assumed that it's clear that independent
> > (sub-)device handling require independent firmware (fw) files, which
> > can be the case. NXP already supplies independent FW files for bt and w=
ifi.
> > We just need to ensure that the drivers are using these.
> >
> > That said the bt driver already checks if the fw has to be downloaded.
> >
> > > However, due to the regulator control and PDn reset control are
> > > bound to the SDIO bus instead of the WLAN device, the SDIO bus may
> > > be ready after kernel boot up.
> >
> > Right, but this is a separate discussion not belonging to these driver
> changes.
> > Also it's the common chicken-egg issue. You need to power the bus and
> > release the device-reset before you can check which device is
> > connected and to check if there would be a proper driver.
> >
> > > Although the WLAN is not used(WLAN driver is not loaded and WLAN FW
> > > is not downloaded), the corresponding regulator count and PDn reset
> > > count are both incremented by 1 through MMC pwrseq. Then with the BT
> > > driver remove & re-probe, the PDn reset cannot truly reset the BT
> > > chip due to the count been +1 by MMC pwrseq.  So the BT will not
> > > reset and BT FW won't be re-downloaded when re-loading the BT driver,
> right?
> >
> > You're aware that the btnxpuart.c driver already has the support for
> > an independent software based reset? Not sure what this sw-reset does,
> > due to the lack of missing documentation, but this is the only option
> > to over-come your above mentioned use-case.
> >
> > I have to ask, is this really a use-case for someone? Either your
> > device supports both: WLAN and BT or only one of WLAN/BT. If it would
> > be only BT or WLAN you just don't need the specify the other one
> > within your devicetree.
>=20
> Hi Marco,
> I am not sure if this is a real use case for customers, we just thought o=
f this
> possibility during internal discussions.
> Currently our actual use case is to use both wlan & bt at the same time.
> Thanks for the clarification, now I am okay with this patch set.
>=20
> Best Regards
> Sherry

I think the patch series is an improvement. It looks good to me.

Thanks,
Neeraj
