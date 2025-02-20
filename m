Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2086.outbound.protection.outlook.com [40.107.105.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C360134B0;
	Thu, 20 Feb 2025 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054667; cv=fail; b=ilcLY7nkbL8D0WITpSj0YVKlxq4kQpU0oSz5Kf+l8q/FIP8xvlpzcG8t419uswyTP/LNrIjQfuHCfEyXWFC2kwIl0UltEUAjzf16d+VhzRG/ykSA9R88ip9Kqi9xoD9QZdQCAZ/2C0kjIRxddL5/rzSHEarmH/NB8naEdr+OWgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054667; c=relaxed/simple;
	bh=NPCbtsImtOh6IgyUhyUVBiZkZ5E7HPgGaVtiIY9gX8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aCBZHRpBDavDiurmCuATdsp2h9JR5nKCVF1rh0HuQmPRwDMPreTJ/GMSbeMbnwGKAb1jJDATQpuNs2hmrDyOQpstFqzQQKkg+HocDYkoxqwO1YRonMZIMnGqxywsXdGkHNxcNHs+TP86zw19FjWWB5LNE+00WpZGfoZrs2ZX3KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jzL//0u+; arc=fail smtp.client-ip=40.107.105.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jzL//0u+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQBbb5pCvEK2slKKxe0t9NRHorGMxNRWhhGaGoy9QJMhn/hUhEjp1O2uDVm82nO+vLqqpxGChyQ53VzIR1txWytMTGRctzJB+AozRRNd3DiowkHzxkNtymteXsHOxEsQa1Z0GI/Nu5TwRjX5UuInMSXNEvYoOddMA1vPnMrzufYoY5VjnuKx0b7yRbcDYIH3aOHwhf0UvbRWXmZ8qml118qNkkqh/ARdhH6ZauVwOOaGPI0plXGlS8b8b5j0ZN0JGwzjRV4jGW61TkbJu9Ar5SOd9GxIX2bpOy9O1Q14t/yuVg26AFAz/oDkIYsLwXXY/VKHmNMvAoKxNhoqSDkkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7OMH0y1VedvtPD97d7ZUfoG6LWwziAGF6xtHPZg6LM=;
 b=fud9nYDCwhlQ9CoXe+yve1xZKGRebehKI+dRNXYyTei7e+helzhwjvFA5PaW1LSSqYH57EOlnPveW3d54nYtC9pSGlX4593FDlEfrdPfN0VQPjgsKtHSvs4q6bz7KWgXrabgflNctzejqHx20kTqojgDFIehxU0XNtn+LV+i3u8VB4r56KQ6JpJZkojtphK1HmJRjxWlIDQ8KqGyh6A0n8W5FKVB1yKqnVwt46+xL8oNOKVfsM2brHqIGued6zE1DhRAQByzBjw0O61tDzQRCmD7G5Kjb4Vi0m4kcoQVX42ijFOzILwOh/QSUEg/cZvjoDHkYX0FvYIJE1FFoTJtaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7OMH0y1VedvtPD97d7ZUfoG6LWwziAGF6xtHPZg6LM=;
 b=jzL//0u+gQVVp9cRCMauFaCJgXqhjqfpNLiIFl2vFk1uao43lZnURt1wNMgPT7OAvEt/r8Wt3RDlXsTi3HhaNoA0zWo8iLj95qPlLnfJaxX9I2dDqYLufOYFpt4+viHSmrceD1bo3/XWt9dJ11gX3L2V51CDQd/buhwZRUPFSwT0dhsQ9GTxBELtYfSXdj7xj/64D00rdRzvTEpT6NclAyC1hjl6R5OkIHUDiN0I9HM7csXcWC/SjTTz0pqISaFmlxWfpihoDvnlFrIPwjWRhF8vnGOhyIaJX6unN49YWp8RgGDK8AcrlTHLGG4jdSDzNeJ1CPz9IVSLaFtS8FmUoQ==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GVXPR04MB11020.eurprd04.prod.outlook.com (2603:10a6:150:227::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 12:30:58 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 12:30:58 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>,
	"johan.korsnes@remarkable.no" <johan.korsnes@remarkable.no>,
	"kristian.krohn@remarkable.no" <kristian.krohn@remarkable.no>, Manjeet Gupta
	<manjeet.gupta@nxp.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: net: bluetooth: nxp: Add support to
 set BD address
Thread-Topic: [PATCH v5 1/2] dt-bindings: net: bluetooth: nxp: Add support to
 set BD address
Thread-Index: AQHbg5NLufHtSaUyJ0GEN9n1ioVKHw==
Date: Thu, 20 Feb 2025 12:30:58 +0000
Message-ID:
 <AS4PR04MB96928A5C527D1720B9BE0AE0E7C42@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250220114157.232997-1-neeraj.sanjaykale@nxp.com>
 <184919f9-25bd-4f65-9ed9-dc452a6f4418@molgen.mpg.de>
 <AS4PR04MB96921164DAA8A63B2C0841AAE7C42@AS4PR04MB9692.eurprd04.prod.outlook.com>
 <0e5f23a9-b1d7-4d8c-bb05-83f7a15a7285@molgen.mpg.de>
In-Reply-To: <0e5f23a9-b1d7-4d8c-bb05-83f7a15a7285@molgen.mpg.de>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|GVXPR04MB11020:EE_
x-ms-office365-filtering-correlation-id: b251b921-0eb1-45aa-11ef-08dd51aa6dae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0J9z688HS8v8Nqv7zRzXCUEicMVS+FbnwkhzIEIEnzIYYQiXKLMdanglvpOr?=
 =?us-ascii?Q?o8h7NBZ0AdEFTLCwgAPR5E26FYcLriRb7uMPcOZjddTwEJNliaVuCGbLg8mr?=
 =?us-ascii?Q?AUbOI63scomfZxRMu90H3WF4TZWa2wCfxsmx7gJLkxFb3sVnkElz4LJEtZXG?=
 =?us-ascii?Q?laq+tQxU6JroTWd27uL1Ht9L2f7ur0tNbGcCIxfXrkaU9AfRtN0fbvl5qbOQ?=
 =?us-ascii?Q?XCelWgleJTscJ3W18S95a0Cn0m/QENn5qhfla/P4g0tC5OTEXFsDWArdLYT+?=
 =?us-ascii?Q?Qy9h/xEEPp9UIIXMWNHdCF2sBd4V3GAWAbsQW+/LutTJixuSXZPleFr7NH9R?=
 =?us-ascii?Q?aGZ8Hi/TjtErmLyYRTXvcDKxjt4fxVsNM0gm4ZDAHLWOrt16rlQr3zAbHcjr?=
 =?us-ascii?Q?W5BbGDZ4MULEKzrLR6q1XMl1RbAlmYj/J4inM/XwCE75rPmFnkpiZzo3p/Mc?=
 =?us-ascii?Q?2kq8FJbmchdrPoAtANFjTJ2UauBHxnx2vFQsOUvXbrsQK0oZJb5a0hPiguvE?=
 =?us-ascii?Q?IFigOtJqMZUBkfBJ8uagtSyxe4x+MBoST2iudM7Q+GnidSC2ZD3AuO0JT7Sd?=
 =?us-ascii?Q?/hF0VFzU9UvbZkB3FUtR8Dse08nXC+KeJCoOK6S2IHoFiP2xwdj3SGxogI6v?=
 =?us-ascii?Q?3SqJV9Ngre9tmDQkD5D76wyIv8d8m3BkLy8Tq4hIruEWzvqK5t4nY52I8D5B?=
 =?us-ascii?Q?peLmM6iJX4Tvc5hVqOF4YmUEC+66buCxRfm/e1srqwyG46ybOFLprfNhYx1V?=
 =?us-ascii?Q?BcdMriE/CxVuT1ft+tRw7Jl/n5BvYcm2NZ1d/bmkbxnVs2vBy9jkjuWLrPZN?=
 =?us-ascii?Q?SLqjV4zky65wb5otOEOl4FHAlK/uJFoVEIi08rHcFqpPk2eGBqjW54B2WDu5?=
 =?us-ascii?Q?dp1Bl8XfS/7g7zMicbIBnDhcnP1NLuWAO05F7k1lYSVdCK0BcWMjnfToIweF?=
 =?us-ascii?Q?VG9zjmDoCM7qXr1s9YfooWymR/tgB3m3izQ2+hF84lh0G6o2KsRHiFfDVsvf?=
 =?us-ascii?Q?JWR+HM3URnHu6ZaUbZ8Tq4efKoZP8RxBWzPfA59bfL4nPptSaB9tHFUhRM09?=
 =?us-ascii?Q?fRwcVlnJCwcWagvm0iRUjwcd/JXw3acKRfkaiOKctlL/0Skof+QL6AYCHufF?=
 =?us-ascii?Q?bbTh4gU48+PaIf5v5tVTH5kQ8yFfqD7j7mj3BmKH3kZWxQ1zXDeNSxWE6NRK?=
 =?us-ascii?Q?9ITR77dzloTQveTwreOivbSAKLY3OzoJIxb9udsmrzYFD7Y/ahHTeNJOcwtv?=
 =?us-ascii?Q?F+GKJEPoaDiiVdbff9K7EWK/8fO8inTT1uyxY+0jCy/2O3EVME3V5a2RGR6G?=
 =?us-ascii?Q?5SI5lQvBN0YAjRJmsYifnpL3WVZo27DwdCc+Wn6rPpxWTIuHF1ZRtdoDtalG?=
 =?us-ascii?Q?xCupMDAXMgiDqzi1EgIiuKGkPKltLjwyJJGKAJya9dsKz8q7Vf8/ltnLjDgf?=
 =?us-ascii?Q?yDOaiCf+srTV5e2eCZQdcgkP9JpDhl5m?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4V07Mc5I7WI5gAxU+3Yu++30ZSn8wRYZo3A4UWx/tH4PDPT5/oVbpZE5nuqo?=
 =?us-ascii?Q?XbIt8jtUMOkR4tw0rW8Qk5NbIAcT0XjmYDrb4DrAFp981FJigCIButH7lfds?=
 =?us-ascii?Q?CH3IZO8VkXheMo8A/pPchuXwwzTaBUrtg+S6oTQFuJbdkwHDgaOgrLDp02yc?=
 =?us-ascii?Q?xzLNJEzx7+iZo1k5p3KzSIapc3hkqfse/gJm2N3Rk3WsL4qT/jS50aLuOZIo?=
 =?us-ascii?Q?fJMWBBcXTlL3dB2h01LwSSILl9Z3oETd7rVIP/mJBnxo4S2tu8+G6zDHt5qI?=
 =?us-ascii?Q?xanDMXsLPFJotJxpabABk/F6oBH3oSgKZxCFeFd83NhtQFOznMtWIht5WZkR?=
 =?us-ascii?Q?s884eiDUEnsrEQfn9qN/YlhPUNzY/1F5WefgeARaS0Uvr5oPGenjf8mZQS7i?=
 =?us-ascii?Q?XZyhnfcIYTg+kJ0BoQmauzaLUeucY04LEWBFpb+/XPOSKGcRCfTZT03o+Jzi?=
 =?us-ascii?Q?kqzU0NDaGXuouSNbML3ZXXjKFnhM1q1vAmalqqKegnpyLSUgLb168c8epx+2?=
 =?us-ascii?Q?B8ibXoBmbNAyZWxLK0TxMILK1EyD54Kn2FXaR7fbCXGaMxED/mzh4iCQC+bk?=
 =?us-ascii?Q?VIto3AIK02dAzp7kNkqVZ6lzvOO7IhiTIF1ot9/q+wjw/AeNqJoh10ZKU2S0?=
 =?us-ascii?Q?5BoaOI6s1euuD/hmd5TnUqM+44qepRWtf/Je+jWnOOOGE6tUniJ7di6m9s1e?=
 =?us-ascii?Q?hR8ILGw0cvdrRtayPcbIBXbo7QuW/TGjhONpf+DeT7WeAcbULJhUblwFXLqz?=
 =?us-ascii?Q?56zfX/M2OVAW8OMJ7iM5YC/4ALAz025nkyrZsv5cGJCE081HqjO+9489/DQm?=
 =?us-ascii?Q?AL0sOxvM8T3QM2otKcT0PvxTQcuYsa1JKF7sqDpdQxGIzS3dRIrsjYNwDivZ?=
 =?us-ascii?Q?jVKs0H1MM+GkG/wG2uEjCfHetLa4Pstd5i5afR7K2M8leZB9OGyFQizcOSwT?=
 =?us-ascii?Q?r+PiTld/xM3Qzbl0KAjhcoa1rG3TqqBM1TUHNEi0Cm2T+ICZucEYXXb+mUOK?=
 =?us-ascii?Q?q4oJ6bIY+Ay+46RoN6AkUxU68IAsLBRGZvRkYFiwxTB84mmdSnhtl4nZv4hn?=
 =?us-ascii?Q?ku+SwNUak4sXl+x/StB1tyWpI/zoEeSAV4H06hEiDHwqmn6iXZqwP5YjOcbE?=
 =?us-ascii?Q?+D4BLYw83GU4tIMU81UiXZ2stLlYqTuoXpd/0XQEv/vp+TpSyAcIkWlcNLaD?=
 =?us-ascii?Q?fT5r/tczrN3rUjd8IiYHP/lFwUlyOu4S0ybRFCKWLYEneF8LbZlf/i766ZzE?=
 =?us-ascii?Q?nHZZQkX4B7BlI5FWevZaN2H/YbtNqGbsBF9abHnxmoC0gbeeHRkH8l6aKsPg?=
 =?us-ascii?Q?Y5LmA9INz0k5gdgKHeL4zNNaZ4oKjymy5CnIK32Pr4GzK4wi4FJqhPjGCVPz?=
 =?us-ascii?Q?7bCH7qTfQlj90iXbkjbBHi1A7i9DLDHlxmCFit4lTVNP1vseRXjnohYBHsjf?=
 =?us-ascii?Q?g0yxp3+depCXLj1SoqRUH8Uk4NYsY1IATrxtK9t0fP1rJV+4zUgafTljzY4K?=
 =?us-ascii?Q?UkZcPhKsgEpp9ts06PiS9ITWL3VEYIhOPZuDp9fhpY24emORqYa4t5KZNR26?=
 =?us-ascii?Q?SBl54Aa7gpyEfki4ZbeeSccV6f84lfZSLleCusHH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b251b921-0eb1-45aa-11ef-08dd51aa6dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 12:30:58.2507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7CAgkOjZstPq9sJYCUfQOq1jhiTEuL71KxRFpnkp250VwUYPk1WRZZSIS15Tx3BBFIMU0r3xaDr4mzMrwPOpaNWd4nYkY2xbrn4jumZ7zVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11020

Hi Paul,
=20
> >> Am 20.02.25 um 12:41 schrieb Neeraj Sanjay Kale:
> >>> Allow user to set custom BD address for NXP chipsets.
> >>>
> >>> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> ---
> >>> v2: Add allOf and unevaluatedProperties: false (Krzysztof)
> >>> v3: Drop local-bd-address: true (Krzysztof)
> >>> ---
> >>>    .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml   | 6 ++=
+++-
> >>>    1 file changed, 5 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git
> >> a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
> bt.yaml
> >> b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
> bt.yaml
> >>> index 0a2d7baf5db3..a84c1c21b024 100644
> >>> ---
> >>> a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
> bt.yam
> >>> l
> >>> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
> bt
> >>> +++ .yaml
> >>> @@ -17,6 +17,9 @@ description:
> >>>    maintainers:
> >>>      - Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> >>>
> >>> +allOf:
> >>> +  - $ref: bluetooth-controller.yaml#
> >>> +
> >>>    properties:
> >>>      compatible:
> >>>        enum:
> >>> @@ -43,7 +46,7 @@ properties:
> >>>    required:
> >>>      - compatible
> >>>
> >>> -additionalProperties: false
> >>> +unevaluatedProperties: false
> >>
> >> How is this diff related to the change mentioned in the commit message=
?
> >
> > This is based on review comment from Krzysztof in V1 DT patch.
> > allOf ref will import all properties defined in bluetooth-controller.ya=
ml,
> including local-bd-address:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> >
> ub.com%2Ftorvalds%2Flinux%2Fblob%2Fmaster%2FDocumentation%2Fdevic
> etree
> > %2Fbindings%2Fnet%2Fbluetooth%2Fbluetooth-
> controller.yaml%23L18&data=3D0
> >
> 5%7C02%7Cneeraj.sanjaykale%40nxp.com%7Cea6b9bba11954062a8ab08dd5
> 1a7c28
> >
> 9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638756503156741
> 597%7CUn
> >
> known%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAw
> MCIsIlAiOi
> >
> JXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DNf
> 5EkxiY
> > rHPZQjCBa1XFeu8Y5T8cXpQwXHZ757YvGFw%3D&reserved=3D0
>=20
> Thank you. I'd include this in the commit message, but my comment was
> about the replacement of `additionalProperties` by `unevaluatedProperties=
`.
As per DT documentation, if we include other schemas, we must use "unevalua=
tedProperties:false" instead of "additionalProperties:false"

https://docs.kernel.org/devicetree/bindings/writing-bindings.html

With "additionalProperties:false", make dt_binding_check fails as it is una=
ble to find the 'local-bd-address' property.

>=20
> >>>
> >>>    examples:
> >>>      - |
> >>> @@ -54,5 +57,6 @@ examples:
> >>>                fw-init-baudrate =3D <3000000>;
> >>>                firmware-name =3D "uartuart8987_bt_v0.bin";
> >>>                device-wakeup-gpios =3D <&gpio 11 GPIO_ACTIVE_HIGH>;
> >>> +            local-bd-address =3D [66 55 44 33 22 11];
> >>>            };
> >>>        };
>=20

Thanks,
Neeraj
