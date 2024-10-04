Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A7313A3ED;
	Fri,  4 Oct 2024 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728027741; cv=fail; b=OZR5TeaOXveCLRwlEBtU9QUtCJl0PXM7lwFHtteiYY7723P4jaQqAYC8KYsXTGolz1/NKic2Zk2FIqEp7UZuQrbhtU9+boXzNgxkpFnEq0mkyJQ6K4KfM6ZzJhW6kLAcv1ONRWylfywrl8wkE5wdK1MknB/BZBksKe0AUSWFcyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728027741; c=relaxed/simple;
	bh=kfbKl801wyYcLa8wN4+HJj6SzDsctXGd6KTbczBhwtY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ltPFiXdIGgF3B+R2MFp1Ifjb38NMMuVS/6kd+UUgfc2gigC3KEZPN7lS4QpxvzXq2QxtIkuaxL8h5ZvTfmmqYnbqR7eFCj1vpl3XF85K2uUThYo6rYyMpKMOP/EU3cQy9NJwdIxQtxsGCybSR5CwI2APb8ifSsUSTZW2ibtHRYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YbjQNRLf; arc=fail smtp.client-ip=52.101.69.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YbjQNRLf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHjhFVkHzpxUY+5kgL6ZQRtsvoOT9cTjIk+SIk8YSYli7uNZ9fO2pnZYSXB54Dy+lUxA6sbv1JEozTyu2GjHgRged9bFPOZCu5oUls1eSSmryJE6vsgBytoe97/LoULULcJ44GcjEisyYVIHNqZsu8zFwv9fxAfuOFlFT7hYoE/nm0IyFwc7t60KsQq0Euwcfa2LlJf2Z0f0mRXi/Gaw8SCqyfn/Td6JQw82dS37VJ5+1261jBDOfR++PAi+NtTAJTeyICpZdV+LPLCQu3ZS47Q7PRG295DMOKC8c0nbDK7nWKxzewXoN3QGUw6synTuISW1VArMPbXc5hYbaKJI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfbKl801wyYcLa8wN4+HJj6SzDsctXGd6KTbczBhwtY=;
 b=aK5DrDxzozkXwMn92yDBiraHO7Pf4yD35qsfePdPfAI2cZ8gIzZ/EDGJ70ymt5P5iBc5Y7JzGBJOh/WV1Q139AD8h69szLOF32CBPIKte47Htta3YlYQblSydm/Csh4u9mXJ7YH6+0D/JCZH+/pqh8OVEtKShptfbWSUXhPYoHQusgTUbHp3LXbjypFEpp84IbxMFI+vVadOQsziGnf+yJJfULdyO3Ath/Y9vTEWm4+FhuA8fv0k67bpnf9NPJ+W4P6mZEQqxAcc5eMxFlRpn+/r0jYrKXMPmmw4Jkl65UaFRByLisIzTbOaqNjS6BIE3euS5jQaZ4LvgFv3+F83fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfbKl801wyYcLa8wN4+HJj6SzDsctXGd6KTbczBhwtY=;
 b=YbjQNRLfZu7vGa97UhAfShhHUZmBAFyMsmkjvcmcCubSvC4g3RE+8EIXKu09MTeOQZisp4OLK5BhT4DZcbL65xcFKyw3L4dowHeSfnbDZfeuwVKhZ/dnZBWOiT2uhL/pp1k6UC8FPHeFzOYu5FwKLbj4V8p/H/f2LbvQEWhnEBarrghPlm22tXpylZ2ZRl3k5F40sfM7BWGKQ99bNDDt+G8Siredlj/akFm5Cqtoujav7nIHDlzkHC3IgBXLc6XWqEl0HRQ+S+lzUdokBWeB6V36Em568PtEpzA6//YGgABGsHVYf0rckuVGvhCv0dJ7tXEk0v8RqHkHdOabGRvNlg==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM8PR04MB7875.eurprd04.prod.outlook.com (2603:10a6:20b:236::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 07:42:14 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 07:42:14 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Rohit Fule <rohit.fule@nxp.com>, Sherry Sun
	<sherry.sun@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>, Bough Chen
	<haibo.chen@nxp.com>, LnxRevLi <LnxRevLi@nxp.com>
Subject: RE: [PATCH v1 2/2] Bluetooth: btnxpuart: Add GPIO support to power
 save feature
Thread-Topic: [PATCH v1 2/2] Bluetooth: btnxpuart: Add GPIO support to power
 save feature
Thread-Index: AQHbFCjnH6tCl1xwV028F+sM5UsFFbJySfuAgALd0RCAAAeGgIABCKQQ
Date: Fri, 4 Oct 2024 07:42:14 +0000
Message-ID:
 <AS4PR04MB9692450A7DD14671CAEB3737E7722@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20241001174021.522254-1-neeraj.sanjaykale@nxp.com>
 <20241001174021.522254-3-neeraj.sanjaykale@nxp.com>
 <PAXPR04MB9185C2D3830832EA4E605E1C89772@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <AS4PR04MB969234817F3568F6DB877C33E7712@AS4PR04MB9692.eurprd04.prod.outlook.com>
 <PAXPR04MB9185C5F6A37901CBFD956AE089712@PAXPR04MB9185.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB9185C5F6A37901CBFD956AE089712@PAXPR04MB9185.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AM8PR04MB7875:EE_
x-ms-office365-filtering-correlation-id: beeced04-017e-488f-75cd-08dce4481080
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mFsMs6jg7ReXo+YFBMFi7Vi/Az5eBeYhW8Bo9Ha4oEhdsTGCBUj7NUgOH6x8?=
 =?us-ascii?Q?QbZ7bAIbAISIqrSuRc0DGBialYH/YBxwo+0lhpb1fghrYl1tk0W6uUya9vca?=
 =?us-ascii?Q?y8nmPnQ9XwBi6h+fYzp4ntfu7tCX+d2/EorkUq6R375aIdZ6exQESwRQ05Yk?=
 =?us-ascii?Q?JYYfKbT/7QKh87V6f6SU0lbPsH5MsUm3BPsSJPdfvy53/qeSalOGHC0Cy8UK?=
 =?us-ascii?Q?BCNBrVJf626Tq+eY0DfC0QgZKEwsAYK4pTh3uULEy88I5Q+u2bA9V4VjiaaJ?=
 =?us-ascii?Q?9YY8GMeHMui7+/yr7KW9R64yHKqxgoWPGHSZ5w/NG68BQ3W594FGq9N4OwX5?=
 =?us-ascii?Q?SeVYKa2n1pTsBJm8y4tPKjYCYIyrsjXdj/fIlToNLilOs/CwtJbCvQAaXxZy?=
 =?us-ascii?Q?Zw2UAQ84XAAyjlEcEOsQYCYnT0drzo5eFAr//78vMYCUQWTrnrETH0vy4Tlf?=
 =?us-ascii?Q?gsNkIDYRQa4TgNKEnyNGLaX1e0fEuT+X9dcdppVL7UbQ4NdBOQp6g4chmkVg?=
 =?us-ascii?Q?4OE6gK5wSJrW94936FhzIKDp5SU4A2Z5wG08UBz7ek4x2c+bnZnMDS/Rqjtn?=
 =?us-ascii?Q?ziftJglQfH5JCtTikI1pveuLFozp9whRvU3Gio/OTovbrbtMA5u9L/J0bEQc?=
 =?us-ascii?Q?PE1RoQDJPO/aCOcNhYoH6p2mVlnyPhVck86o9a+8XbGobeTqD6TYGumGFkry?=
 =?us-ascii?Q?dBqEaByxsLaA5ItG1kJPR6CI4DyO+i7AIoOCRmGZJWD5uGaNOVXrk5SH+/J0?=
 =?us-ascii?Q?3+tFTJZSfEvIiTTGMULBj5yj5zA9PNAjw/sfXw5SQ3m2vWqiReJsvCkq+kIK?=
 =?us-ascii?Q?3w4hAAJZIdBHkprI9VV/fWlaELtGtOFUi7n87xKoYgMRMdB5+IHUh4Jv6tg8?=
 =?us-ascii?Q?B0bDQy/uCGnETlEHkYQS+3LFhjz3HZpkp5q0WAzJRcMtVcdr5hiLffJxXozE?=
 =?us-ascii?Q?6EZHUWbMDaoWhl0WiHP8zjLb+RikvN34K/Q32U6N0m/nWvZlUqXjSR0F2aXM?=
 =?us-ascii?Q?Kf9/HAgYfSxnxLXTmYnKv1S1uB5WeorKPiFCQkP5bEj8xtCe3pZHwdqNHeoC?=
 =?us-ascii?Q?oabJJWR1STxZq4J9h9zHMBKlCa/4tCYcP74mhdtFib/VMjxW3lfY7LUgAxYG?=
 =?us-ascii?Q?Fh04kh3LjNVkP7y7C2+M9cc1b3whTXhIqdMJcCHTmX/KsxK95BEOoNhG6dQ6?=
 =?us-ascii?Q?TZr6eWYuMO1h8+BXsAg8vJ0Ls3+AzmiK+98TDYai7hai7O8XnzgZQ5gBi+df?=
 =?us-ascii?Q?8xpoOda7kV7onZL0Ds+uiS4rBseQxnfnZTXaQr4FAJaHJl/50LFPfy2NyzFr?=
 =?us-ascii?Q?dyrlv9schyuS52NPTVWLKFZmsMcluDQKvFBMznUuYL77kQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OW4vwQEdoFUcx4XveoyFn0aM5H4fjOb2wuzLoy/quRAmz4FWApXQ4owinqhJ?=
 =?us-ascii?Q?l9c/0cY6pTwEipOBXTlTdqgMmZL+GVO3D9a9i0dO4iUwEPqK1H6OLJrHj2QT?=
 =?us-ascii?Q?L6F3I6SyAKuZ9iY7VpX2ZlnKxTfDiPXVmGmWk5dnt4Ct7IqFzANVFRvixnZO?=
 =?us-ascii?Q?z3SXgUoUjx+/9b3hT2l3ldhWMdThM8JXawux5z/yTjxQNwCTWtuNfrZk3fES?=
 =?us-ascii?Q?Goym5LfNlb/QDM/nV8QyDGtqixfV70GUvX8o23/GZvpDWlIf0VxYXk/BRZC0?=
 =?us-ascii?Q?R6mnMXjK1aO/Qbqvoz6oWQOFndw71ue89T7WFePBvXGZvh71aVhkzENYFsDL?=
 =?us-ascii?Q?b6zoKZsyf7JWxrvZUNqhGWFwdwr5OXDum3I/pfQ++7X4mWvjL8Lx2fjaq2po?=
 =?us-ascii?Q?bEVqBTmdU+u2ZabcP5iURlsZLZC2fgp2YJhwOPvJzEL9XsMbiDqWAQ0gfX4Q?=
 =?us-ascii?Q?ZtT1DJDjwW4IbDVNFv+vq9xKXVL+D6bBhFka9QCXrYuc6c9knYDCqMVR8FlE?=
 =?us-ascii?Q?Kp4vU2S1YYA0lG3Hw24FCxgkKLUrGrMhCBaeZpyvtvuYEacsfDYoJek8i9n6?=
 =?us-ascii?Q?OEYRIrD33vxBT63uc+tt8htSFNsRDiMWieMJ8yoEGAkyfsBgxKINQwOlQdTI?=
 =?us-ascii?Q?lWUOX/Jqc5lVke46/nMyLEO0uzUu+SNDYp1CTrZuLT9c0fdmzh3KECT1Hcbm?=
 =?us-ascii?Q?z2uo9ztNGSS8tNnWNVVsV/znl5ADSrdmeWY79Brfj1BblxyqqXXmGXOXtRia?=
 =?us-ascii?Q?lQyML3Fozx8aeO/QNZ5w1BdyK93HWyXyzi8hw5vMGbVlvBUruqr9ZA2M8XXh?=
 =?us-ascii?Q?9suBE2Sx0pswfnX2RO+X2fVdn1CYBK8xGsEiv0JRzvtOIeEsDA8ExgwItyCn?=
 =?us-ascii?Q?YdPFh5zpJ8/3F0MXDdW0xJsyk7fdCQJgaexAHi/63Go56RH+P7psBEMrE5Cn?=
 =?us-ascii?Q?ZNSdCGlqkDZwLFpSVCfytdSMDNloU3+T0W3aSRqNGtdKUcM25sCinhr6XpWd?=
 =?us-ascii?Q?mkTqPt80U4pcKrDAVoor5X4BYu40zm0CHWpUeGraENTnyyZrmlU72x7P66Cp?=
 =?us-ascii?Q?2Q5xlj2cPP5us+OghA/utDSCe/uEi0G0i2fRuQuDROYgLxPWxJB+5+O3Kf0J?=
 =?us-ascii?Q?tVngKb2ceX9YYoSedO6qN2e5JV4pB7wQCMyPpvOtOPwXU/YFvxl7QXzPi0jQ?=
 =?us-ascii?Q?GU/0jetJiZ2PlvscVCRIMrBP6CY/YqEO7J91CD/xUeD+2BL74sY2Y5ugEKUe?=
 =?us-ascii?Q?fSVA4dc6N0IQWleC/yC9pSgqtRwFOcwzF+KsaOvPEtpJ/R+2jH6FkbTcfyZb?=
 =?us-ascii?Q?ZTapzs2eJDWdLFP6mz69vyS/6YBE01PuD82wTmPQ7KIS2ZAuVASAxyFuAtqG?=
 =?us-ascii?Q?wPnZx27FZXkT4MaT4ebsoNmf2QN5lNyQ0eB+8H5AtyQVGdXb+CJ2TaeJatby?=
 =?us-ascii?Q?EDnazAjvhM+Nc74TNSarDt3NIYjdwZixnIpzQSy/CMQregPtgf07V+eJ2Hy3?=
 =?us-ascii?Q?PSQKxi1l76QTzJVrzDnUBFkqLVdfT1mA5wWRS96GaJ03sE/qCRFEBPN/JtBc?=
 =?us-ascii?Q?np1ogwdZ5OlZoNplB5009McOo8cHkk4Ybe1XGF24?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: beeced04-017e-488f-75cd-08dce4481080
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 07:42:14.5353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4GgWysQxN0wYBCGxVCctB1+CK3AIX1mpuoMZv6ImnSEhaBiFlTu2N1DI8HGB5HzOeb3gK4FmBpkhbDC5YtQntad8QN7HIP0sAnO1x2CUUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7875

Hi Shenwei,

> >
> > The expected behavior is level trigger.
> > The piece of code you are referring to is from power save init, where
> > we are setting the initial value of GPIO as HIGH.
> > However, if the FW is already present and running, with unknown power
> > save state, a GPIO toggle ensures the chip wakes up, and FW and driver =
are
> in sync.
> >
>=20
> If the module is already in a power-save state, waking it up only to
> immediately return it to power-save seems unnecessary. A more efficient
> approach would be to simply set the GPIO to LOW. This action should
> transition the module into a power-save state regardless of its previous
> condition.
>=20
Yes, it seems more efficient. Let me make the change and test.
Ps_init() is expected to make the GPIO low to wake up the chip.
Will include the change in v3 patch.

Correction to my previous reply:=20
> > The piece of code you are referring to is from power save init, where
> > we are setting the initial value of GPIO as "LOW".

Thanks,
Neeraj
