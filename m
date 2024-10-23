Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2058.outbound.protection.outlook.com [40.107.103.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A921AE018;
	Wed, 23 Oct 2024 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692992; cv=fail; b=X3f2k9Q2pZM9uf6tSWwWklfc6IW3VQtHb+sTnqZTvKTjQPSmruyyAScCtOpyGcaHWzzbmwKziWA9TQxrFge739nTYSVS+9Mr6TV9//3gSySKkVard3agzG8X60Lwqg8BHgta8j7i6NmjKTuLhlpOyBrHrAWClsWMFyZq5nYpZnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692992; c=relaxed/simple;
	bh=JDhwgAerGIlm1UDaH3fkdwKzRb7VU4ZQIyvs14/6TSY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PvaGsr461ic/QXD07PfH7Hn4m9pUDndbwo0egmwQcrWlAwXa4XcdowgUgnfppZjByM/6H+0YdOMod6NtHgOl9a/B5jfx09kVgjERgkV+KunBLUIqMAXWt9ciMJ/BVx1E4+rRjZx/jDHIWFf6j+Kpj5t2/vRkXvtcXN0cGjHEXRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gq8Jm2Lh; arc=fail smtp.client-ip=40.107.103.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gq8Jm2Lh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EH+HM/U6gyn7djyImm/Nk6OOb8Kg+egdCJE5c2zwxE+MxJaocJ5VsTbg87aJuVht4fBtkpCDo8HJ9gY9UKe0Tdo28h+giwFJxfvLgjxX3Iiu70er6oeO9o91x/J666xL55UeJwN51bKt5nBTt3vhP/yu+zSEHJJmKQJN6JFukORaZ24J7KEDuLvQMF3wMTwpUEhT1eqRQ5GKw237ufnVpaywbuY2stNBuS96SruKiaP1KlTAPfWXcPEHj6UMu85Yp7WMxtMogAief/Gl4Va508MwIY86UVMHyVk5qOWlOiAVoKLrHqXGqbbqhkdtp9t0koR4yiDiEYqSdW2B3e+1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQF3Pt9bwotqKuAY8JLnDhsPWS1tXVZTFx8AQZWmkQE=;
 b=m6wv/7VgNbg991o46SBOEgbKD/sY6z2f6WbphLWOcG/9eRqtbjAlUE77aJJN637PnSq6ZGy5aqXe5lhV9A0kLDXbb2spc5zfsQcnHSbksNiCwZj54TfWaAkGx5fwI8n7+/3yhHEEVEd0FTAVhG192bqXtdfQd4csAXQyc/hB1nqA8AnhgEg7Zjt7YGqm4x92WvQRrB4yPCP9n6mr14qRWx2j6pUHbFLWV+nBb1KgBDBR3814npi0FDSI0v9hQU+TWskj799+0PrhQJbuP54o42Y+DlmNW5NcuyDfDqhl8Yv8lO7SBJE3gmkv0RruPlEKye9WD/WSi4jYr1xKZ36tcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQF3Pt9bwotqKuAY8JLnDhsPWS1tXVZTFx8AQZWmkQE=;
 b=Gq8Jm2Lh6hdnal4/JM1zxhdxbCR1+M3JTqmZBPCZ5rJUGDHJR3pVev0bqSfMmiGKcfW5PERDSbNkH8PMhV4Lm9sCXe6XJQxRmfZLaQXTky7Q5Exeu5ydK4jMS0uDC1G2wQq7RIzUQJpV6R1DuzIzZ44Nxw5RkJHsbEU7NHSlVFHZc26o8YNMDx4yc0RuR7UKDENMk+smKyng4SW6+ZU1MNRrsxSWFzso6wpQ3HnUIw5N7Kv07s0oyF8OGLjbT3Rf65mNm0BPuHyJJTt+TXXPmp1ep9gj8xgp1lHbcf6jdokERRVxiAqktggyHfnY/opIWMa+ucFisxW9a/G3XIgWyg==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by VI1PR04MB6941.eurprd04.prod.outlook.com (2603:10a6:803:12e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 14:16:26 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 14:16:26 +0000
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
 AQHbFlGi4L5ELajEYECFBoJDru1aa7J5aBLQgAAySQCAAao9AIAAIGOAgBV25oCAABNWAIAAK2IAgAE1RoCAACn9gIAACuYQgAAFzACAAF/eYIAAHNsAgAF25gA=
Date: Wed, 23 Oct 2024 14:16:26 +0000
Message-ID:
 <DB9PR04MB8429CF700571FE42C997FB9C924D2@DB9PR04MB8429.eurprd04.prod.outlook.com>
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
In-Reply-To: <9b09774e-d0ed-4c97-b6a0-e976580b5bb5@leica-geosystems.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|VI1PR04MB6941:EE_
x-ms-office365-filtering-correlation-id: 8682b9ad-9f03-4621-d3ad-08dcf36d4830
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FzkHvSiML9uTc41yG5NAzIjzh+Ygk11RqCPmY//JsQWuU3/Zt7wO8DYAxnBM?=
 =?us-ascii?Q?80kYqB2nY+4CeBe5EfauqOVfB/pHEIi9Jk/UfR8djZWD/X/ZK15ubj0sysyA?=
 =?us-ascii?Q?bFtJklLsyMOYFBqp3AzLg70d/fwx3XDwkeeEpWusQV1EUimcdoEBVTUtk3L9?=
 =?us-ascii?Q?jLPq0XXRV6J+jl/tGJV1ntfgUWtO/WVocJt2Zmk9JPs4gw2m5Ju9ocAt98TQ?=
 =?us-ascii?Q?vxF3i4n41ZJF/RvK7Y9r4EImyfEyXpaA6ri3BnFy0p6RdSnsPNpAla1Zm7qc?=
 =?us-ascii?Q?u7IVd4q/MNwOjkLnkpc/qFbQQ7M+8nqsi/tPXWGZtI5bckdYxjPHzIQE9XeZ?=
 =?us-ascii?Q?ZDxkleb8KwIcjQFQzmb5I9Ic+4Duy3ON23KHGQ+WsMz65AaNuuJoA6B2ZIW5?=
 =?us-ascii?Q?wuvEnTzy4OLELdH372B8UFLVtR6Py7cJv/pOnWL5qrMdVXFn3G2b+MchkEln?=
 =?us-ascii?Q?Gmuyq+3JZJhcQEg0iUrO++00Txfwy0d0R/+NTgE/0uf5DTieFswjPHsoJvbI?=
 =?us-ascii?Q?f9xh6v/vo66gUr7NeYW27IFiqh2Jn/fCBEp342kWp8TvModjfh4WVELXhUF4?=
 =?us-ascii?Q?9tIFjuEAtvcN1O8Jbk05oUtD2f7uNHmUwrsJZzQS4N2db56qR2IY3DYjHhuE?=
 =?us-ascii?Q?0sBpPMmuysLwPuA+AC1bIkFWa6DqcjyXED3Hf7XhVBUjcW23jl7wNx/bK37f?=
 =?us-ascii?Q?AzVleC6T3SJghD9gWz+u6e7yFsYbuDG2cBOyiduJ3xeJVZyA++6lCHm/awEf?=
 =?us-ascii?Q?0Bz0nC4kOhUWy5g+yug0dNYeEV1nCSzBWPx92X7xuEHmHb0nr+DWSW06uIeS?=
 =?us-ascii?Q?ehGJ02Y7eoO8jyAn6bJHNF5GwWEm3Dhk8ywTaR7G2tjjqI/labHGB3IZ6DH7?=
 =?us-ascii?Q?+J/gAcI/1pDn+Y3PUZYI+P8z8iBWGM7xFNnsATYjHmnlLZ7SVh/uVud6DvI3?=
 =?us-ascii?Q?sw++nG0qC6w2OTH2ViVdxL760Xkoz2rtPllZ8Aq83ey8uxEpalN8Nhc2qJW8?=
 =?us-ascii?Q?fLrn0VJgU10kKykBefYTHVuvNSGmYVgrsmwMbnUhqi4uk473l4rREYSkUeDb?=
 =?us-ascii?Q?JSotsUqHTEIFyUm6EbCXp/wu7cMwQvh+yGQINhVivy0cAMxgmXcssPQTYZBA?=
 =?us-ascii?Q?dGazSqBvqbvcXU8lOjSQMs+qTEQkeQiV/zl8bFwXatNyx52iqE91h7tbzl5L?=
 =?us-ascii?Q?YI1QeYuou+AsDg2kojt2S2guUYDmCr669m/c4nIkNxCgGMxnixJQfUhramEQ?=
 =?us-ascii?Q?aIHKQwPvCfuOVqidb0IF/zyRPmC8rSNW1qvqYeY3sQ6QDwKH11FFnscpNemh?=
 =?us-ascii?Q?1Aaz4u9/2u71nP+XrJjnlmL5rMwrLghvJSyqHIcLInhUy3aRBJ3OpLF34UAD?=
 =?us-ascii?Q?MFyDjCE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aAEn/umc2wKoqbm473jWdPTtLmoR3dafpiTnqDF5YrZJiqKCYKvrblxUaPow?=
 =?us-ascii?Q?vohz13LqH83vH+pG8xyonO7A0I2e7s8O/SJOYGUsRVknMVD1uhvjYy9aHdnz?=
 =?us-ascii?Q?X8n7sW51ozJlRCaC3kBo+aeIdZykvQdbuYAqSeLhydG5dB2PeI5GqGUoXo3n?=
 =?us-ascii?Q?4ZIuVb/JvV/CelI3atsjHxaj34RgMB/CU60cDO0utAjiLxo+pe5GkfWFbHa2?=
 =?us-ascii?Q?fHJ3RYOQ4SuDUpk1gHuac+C5g0ZSVdaH9a1DUHBP3tJ/IQq5Xar1NxeWSNJw?=
 =?us-ascii?Q?zZYo+lqMVnuwyT6g19G32ibzKvZpiyq88xxJ5ShR7wL/i+8CYma0H8hk8Pvo?=
 =?us-ascii?Q?Beo/B/3sOdOKbu1Zfw6hfu/i11UAOitRREYn4K+tfzQrfh8Pt7hggOsnNStJ?=
 =?us-ascii?Q?Nt3QgY342LUZLpEI/Yq9MT1gaiWbnTMUUrGsPrBuSYE5Rsn877gSj6dCrDWP?=
 =?us-ascii?Q?Ya0Le3lzFZVdeWQpVA/wtZjiTkQkHRIn50sHo1XsEXPmGIe+I1q2UvRNVMv0?=
 =?us-ascii?Q?RsYpqUie5jBMOyNTCOq/2qi1ckGGNaSIO7XJ0kCvZmmW/nbQtUvVjob4RlEl?=
 =?us-ascii?Q?B6fPIp5pKmAAh2Qcrq2ymV+x4q+aUsHy84ztKlbCcUBs+pVLBXLIW58g0N8y?=
 =?us-ascii?Q?GuJ2yHzuLpGwb0lJaTlECFBQR+6gij8Zptr4D2RWo3lJocxybhxC57vSAW6/?=
 =?us-ascii?Q?yuiqXPF5GYWfprI5qBhixIs+xMFe5kNNyY1fj2unkR2I1nIN7bj4bj+N+Xhr?=
 =?us-ascii?Q?GBvpnet2WQX2GIPUSQCQZAKv9hUwc77WU2woSSUROrU6OYfRS9z6b/IsJBfn?=
 =?us-ascii?Q?1ScH2Y82Zu05bGzfpsoxkAtvTb9NRoh7Ipj4C4PFF5D6+2Y1dC3iykpuxe0h?=
 =?us-ascii?Q?STEuXIQSdIIqrmUvjPUNctKfdWz5CVhGWenmkNciSq+AbJ1clBXIPBhf2+8Q?=
 =?us-ascii?Q?XFa/fWie4Xl12SRVW0VAxnnkV+QgZxac2bQIvM+SqRRb25t3P0H/h6DeyPWu?=
 =?us-ascii?Q?4vT4rFPpFR44keyhiqOh6EixfkfSj+b3Rh4mbVUUIJ6rAzmW6kh62RJNwD/G?=
 =?us-ascii?Q?9BDeLeYamInAuRLt1DwddibetYzxL8kkrRvJE60JOev1sTHzbVgDWuF7BVPo?=
 =?us-ascii?Q?2PqjkNduT98cCB5JUzjQ9vavbT1jtrZvDJJRfZXHkc9dqMl5p0J1V+TWfkcB?=
 =?us-ascii?Q?F0yfDB59vTOzuJoKTS0IzdDa5ECqTS+PNdrhDtPftMz7MXYsXIHf66JLK4PZ?=
 =?us-ascii?Q?qqk/nVN5kkgnRY1KUbHHDJQdBsqXHuAa8n+yjK1ghD2pqyVNv3+FKV/I8QU+?=
 =?us-ascii?Q?yWkvzJDIj8kbBNHohRhSeiZ5ZiInWIJj1RCcbAekI0HFE57BqT7AWyx5MTqB?=
 =?us-ascii?Q?HIGM4ueGH0ir4TNg97sFMxYJa5W/jdbb7vJrs+57JQiPaofljlTEDNifPhUm?=
 =?us-ascii?Q?pXz9AdOfZUq8lHrt6zoo6+sMg9P5gpVmYQdLxAgB1RnDqg6d4z59njdMa3Gb?=
 =?us-ascii?Q?hvFrkqDXRBysFjm23R1ya7BFxBvhVEu+F7jC6bUQfE5NQ7FsBvDwpXUaWTac?=
 =?us-ascii?Q?y4zSxgAmSR8NV6QSLG8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8682b9ad-9f03-4621-d3ad-08dcf36d4830
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 14:16:26.7886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2d//XjV+fPXrjxKU7lNaL8dPIOaiCiiMtRIlo1jsL08xoG8js+qffvGoIl1pvjoiZwvY3RDOHBoAN9Tamt1Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6941



> >
> >> -----Original Message-----
> >> From: Marco Felsch <m.felsch@pengutronix.de>
> >> Sent: Tuesday, October 22, 2024 4:23 PM
> >> To: Sherry Sun <sherry.sun@nxp.com>
> >> Cc: POPESCU Catalin <catalin.popescu@leica-geosystems.com>;
> Amitkumar
> >> Karwar <amitkumar.karwar@nxp.com>; Neeraj Sanjay Kale
> >> <neeraj.sanjaykale@nxp.com>; marcel@holtmann.org;
> >> luiz.dentz@gmail.com; robh@kernel.org; krzk+dt@kernel.org;
> >> conor+dt@kernel.org; p.zabel@pengutronix.de; linux-
> >> bluetooth@vger.kernel.org; devicetree@vger.kernel.org; linux-
> >> kernel@vger.kernel.org; GEO-CHHER-bsp-development <bsp-
> >> development.geo@leica-geosystems.com>; Krzysztof Kozlowski
> >> <krzk@kernel.org>
> >> Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add
> >> support for supply and reset
> >>
> >> On 24-10-22, Sherry Sun wrote:
> >>>
> >>>> -----Original Message-----
> >>>> From: Marco Felsch <m.felsch@pengutronix.de>
> >>>> Sent: Tuesday, October 22, 2024 3:23 PM
> >>>> To: Sherry Sun <sherry.sun@nxp.com>
> >>>> Cc: POPESCU Catalin <catalin.popescu@leica-geosystems.com>;
> >>>> Amitkumar Karwar <amitkumar.karwar@nxp.com>; Neeraj Sanjay Kale
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
> >>>>>> On 24-10-21, Krzysztof Kozlowski wrote:
> >>>>>>> On 21/10/2024 08:41, Marco Felsch wrote:
> >>>>>>>> On 24-10-07, Krzysztof Kozlowski wrote:
> >>>>>>>>> On 07/10/2024 14:58, POPESCU Catalin wrote:
> >>>>>>>>>>>>> +  vcc-supply:
> >>>>>>>>>>>>> +    description:
> >>>>>>>>>>>>> +      phandle of the regulator that provides the supply
> >> voltage.
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +  reset-gpios:
> >>>>>>>>>>>>> +    description:
> >>>>>>>>>>>>> +      Chip powerdown/reset signal (PDn).
> >>>>>>>>>>>>> +
> >>>>>>>>>>>> Hi Catalin,
> >>>>>>>>>>>>
> >>>>>>>>>>>> For NXP WIFI/BT chip, WIFI and BT share the one PDn pin,
> >>>>>>>>>>>> which
> >>>>>> means that both wifi and BT controller will be powered on and off
> >>>>>> at the same time.
> >>>>>>>>>>>> Taking the M.2 NXP WIFI/BT module as an example,
> >>>>>> pin56(W_DISABLE1) is connected to the WIFI/BT chip PDn pin, we
> >>>>>> has already controlled this pin in the corresponding PCIe/SDIO
> >>>>>> controller dts
> >>>> nodes.
> >>>>>>>>>>>> It is not clear to me what exactly pins for vcc-supply and
> >>>>>>>>>>>> reset-gpios
> >>>>>> you describing here. Can you help understand the corresponding
> >>>>>> pins on M.2 interface as an example? Thanks.
> >>>>>>>>>> Hi Sherry,
> >>>>>>>>>>
> >>>>>>>>>> Regulators and reset controls being refcounted, we can then
> >>>>>>>>>> implement powerup sequence in both bluetooth/wlan drivers
> and
> >>>>>>>>>> have the drivers operate independently. This way bluetooth
> >>>>>>>>>> driver would has no dependance on the wlan
> >> driver for :
> >>>>>>>>>> - its power supply
> >>>>>>>>>>
> >>>>>>>>>> - its reset pin (PDn)
> >>>>>>>>>>
> >>>>>>>>>> - its firmware (being downloaded as part of the combo
> >>>>>>>>>> firmware)
> >>>>>>>>>>
> >>>>>>>>>> For the wlan driver we use mmc power sequence to drive the
> >>>>>>>>>> chip reset pin and there's another patchset that adds support
> >>>>>>>>>> for reset control into the mmc pwrseq simple driver.
> >>>>>>>>>>
> >>>>>>>>>>> Please wrap your replies.
> >>>>>>>>>>>
> >>>>>>>>>>> It seems you need power sequencing just like Bartosz did for
> >>>>>> Qualcomm WCN.
> >>>>>>>>>> Hi Krzysztof,
> >>>>>>>>>>
> >>>>>>>>>> I'm not familiar with power sequencing, but looks like way
> >>>>>>>>>> more complicated than reset controls. So, why power
> >>>>>>>>>> sequencing is recommended here ? Is it b/c a supply is
> >> involved ?
> >>>>>>>>> Based on earlier message:
> >>>>>>>>>
> >>>>>>>>> "For NXP WIFI/BT chip, WIFI and BT share the one PDn pin,
> >>>>>>>>> which means that both wifi and BT controller will be powered
> >>>>>>>>> on and off at the same time."
> >>>>>>>>>
> >>>>>>>>> but maybe that's not needed. No clue, I don't know the hardware=
.
> >>>>>>>>> But be carefully what you write in the bindings, because then
> >>>>>>>>> it will be
> >>>>>> ABI.
> >>>>>>>> We noticed the new power-sequencing infrastructure which is
> >>>>>>>> part of
> >>>>>>>> 6.11 too but I don't think that this patch is wrong. The DT ABI
> >>>>>>>> won't break if we switch to the power-sequencing later on since
> >>>>>>>> the
> >>>>>> "reset-gpios"
> >>>>>>>> are not marked as required. So it is up to the driver to handle
> >>>>>>>> it either via a separate power-sequence driver or via
> >> "power-supply"
> >>>>>>>> and "reset-gpios" directly.
> >>>>>>> That's not the point. We expect correct hardware description.
> >>>>>>> If you say now it has "reset-gpios" but later say "actually no,
> >>>>>>> because it has PMU", I respond: no. Describe the hardware, not
> >>>>>>> current
> >>>> Linux.
> >>>>>> I know that DT abstracts the HW. That said I don't see the
> >>>>>> problem with this patch. The HW is abstracted just fine:
> >>>>>>
> >>>>>> shared PDn          -> reset-gpios
> >>>>>> shared power-supply -> vcc-supply
> >>>>> Actually we should use vcc-supply to control the PDn pin, this is
> >>>>> the power supply for NXP wifi/BT.
> >>>> Please don't since this is regular pin on the wlan/bt device not
> >>>> the
> >> regulator.
> >>>> People often do that for GPIOs if the driver is missing the support
> >>>> to pull the reset/pdn/enable gpio but the enable-gpio on the
> >>>> regulator is to enable the regulator and _not_ the bt/wlan device.
> >>>>
> >>>> Therefore the implementation Catalin provided is the correct one.
> >>>>
> >>> For NXP wifi/BT, the PDn is the only power control pin, no specific
> >>> regulator, per my understanding, it is a common way to configure
> >>> this pin as the vcc-supply for the wifi interface(SDIO or PCIe).
> >> NACK. Each active external chip needs power, this is supplied via an
> >> supply- rail and this is what vcc/vdd/va/vdio/v***-supply are used for=
.
> >>
> >> The PDn is a digital input signal which tells the chip to go into
> >> power- down/reset mode or not.
> >>
> >>> reg_usdhc3_vmmc: regulator-usdhc3 {
> >>>           compatible =3D "regulator-fixed";
> >>>           regulator-name =3D "WLAN_EN";
> >>>           regulator-min-microvolt =3D <3300000>;
> >>>           regulator-max-microvolt =3D <3300000>;
> >>>           gpio =3D <&pcal6524 20 GPIO_ACTIVE_HIGH>;
> >>>           enable-active-high;
> >>> };
> >> This is what I meant previously, you do use a regualtor device for
> >> switching the PDn signal. This is not correct, albeit a lot of people
> >> are doing this because they don't want to adapt the driver. The 'gpio'
> >> within this regualtor should enable/disable this particular physical
> regualtor.
> >>
> > Sorry I see it differently. I checked the datasheet of NXP wifi
> > chip(taking IW612 as an example), the PDn pin is not the BT reset pin,
> > we usually take it as the PMIC_EN/WL_REG_ON pin to control the whole
> chip power supply.
> >
> > I think the reset-gpio added here should control the IND_RST_BT pin
> > (Independent software reset for Bluetooth), similar for the IND_RST_WL
> > pin(Independent software reset for Wi-Fi).
> >
> > Best Regards
> > Sherry
>=20
> PDn is not the BT reset :
>=20
> - PDn is a chip reset and is shared b/w BT and WIFI : hence, it needs to =
be
> managed as a reset control
>=20

Ok, so can you please also send out the corresponding wifi driver changes
for the reset control for reference? Otherwise I suppose the wifi part will
be powered off unexpectedly if unload the BT driver with your patch.

Best Regards
Sherry

> - BT reset is specific to BT and can be handled as a simple gpio as it's =
not
> being shared with other driver (e.g WIFI)
>=20
> I've only added support for power-supply and PDn.
>=20
> BT specific reset has been ignored so far as it's optional software reset=
 and it
> can be left open if not needed in the design.
>=20

