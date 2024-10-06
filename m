Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013008.outbound.protection.outlook.com [52.101.67.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D98616130C;
	Sun,  6 Oct 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728204551; cv=fail; b=bJ08XTePl/weQiBQCwJeGYxgg0C1pKZFKCJi1iXhCKvI78S3YSMl88MxgXWVV0IdAftlbDBvx7SJqBFTAoyrXAZ7CWWHtvI7+I4cIIM74tFhe2Rg77KSUVxLdElhCNlbvCCXXovuDWmniacy4iv5BjRFYsJXNQk/Yk8Id6vpIWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728204551; c=relaxed/simple;
	bh=rZVSM/lx/NL30Pz9bFRNxUZhJgtjiK2zhz15zxB+snM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t9g6mAvI+18ZGH+Migcawsgl+AT/6FpIdygxWyYjlsMhIBk8Z7q8UYuZeOZCCp20SqxOJJkuYDP1ki4sviH4gHvVpULs9OYx8U1mQmaugDd4anaGp+vvtJNDz96Th2lOR6m/cAua+2UrRlzJwPO5xtzmtTK2/vHdrsp/gace4xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MuYiditF; arc=fail smtp.client-ip=52.101.67.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MuYiditF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zL/oGN1bqGnmi9Zn5+8BIra5Nh/aNXzegYPruTaiahcOUfMWdFFmWEwkwIcVoUy64Xiu62RCbZAzLbgrmxYbbkWBCgrU/l/AHW0xPvRWg++ZtjbzTFOAt/0gP29dh59cqNAANgo3R6cdfUWE6vjuZVQct9Ie+vlwM3RxxEuU6YufHVLTiG7h/8ZCNGstKLbJhHrANaQZrR6iVshlqjBiLzS9OhBjNM0ZaSBK+R1YyMTQv//R93gTIRt78GL7E1w+uCL6xalFrWe+9otuUinxYwsnaySYyrtRUoq9REpKhl96Kp2FYuHgW9EZiVMLWZ6/nStmR7awqeYRz5NfU2sM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvryWvLDNOF7nW5skn5QKD3ddoXmdrBD9WGb7uGQD64=;
 b=gGZzNmCKQgmrLWryl4LM2DH8xb04zSMI7hrh3bfxkW9cAYIY+k2ecp0/aTF1OFwnijJ6imaJQOEhGgZGxwCbx3h06fSxKRk4RFOIkoH57p7v6jRcaQg53S6FfBJqtj2DL8fsGhG7esnWi9QIUyJSjnNXV+M+JFIF1X32l/BVtVVtquCGL5o/64GWN3BSQKxGLhviLEbIU+8R0/qjqQODRJVsbhSP2MDvOpjMKD3UdAx6Wo/+hBv+6dEj0ALGBjHLkbXGffG0XpSb1BfCU8P95DEMJXsL8Co4XnJ/30kzkCjznjz0vOpQwGyZhyVTJ2Jwa5iLn7zsRySY/26qIy+1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvryWvLDNOF7nW5skn5QKD3ddoXmdrBD9WGb7uGQD64=;
 b=MuYiditFuueaXzGkk4l7+mGMMzcMUSVXPHiMPbV6cTdOEGuXsxS0u03ZB464/lIDqBc2rDXVR3kypJpd4zsC+KGG7eV0IJmrW01UePPOsLOsbR7Z4B03m7e8HSMgRVeN6pgHEPkWCxD2XYCM4zmQ0E474N1gEWPi0MsF4llqt67eSIQ0oVSpQ7baHLzHN987URBvhUvp7ve9f71oTIuDHodWIyvO+VMdKJ0k9lNhy5q+4AoGqwbVnAS4xf6J3FBTStrECnQgfF2U6O/q5KW2DMOkg1yK7xQmMXfRtDbZA1IY2IEzYlVIv+NegiHFys/6yzCY2Gxp0fxWz7UnCS4DvA==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by PR3PR04MB7370.eurprd04.prod.outlook.com (2603:10a6:102:92::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21; Sun, 6 Oct
 2024 08:49:06 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 08:49:06 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
	"bsp-development.geo@leica-geosystems.com"
	<bsp-development.geo@leica-geosystems.com>
Subject: RE: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Thread-Topic: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Thread-Index: AQHbFlGi4L5ELajEYECFBoJDru1aa7J5aBLQ
Date: Sun, 6 Oct 2024 08:49:06 +0000
Message-ID:
 <DB9PR04MB8429B4535422D3AE07D8EE79927C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|PR3PR04MB7370:EE_
x-ms-office365-filtering-correlation-id: 420168c8-66ea-4099-54f6-08dce5e3bc7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gsQFslgPhN2BrjBySDkcvnIj6i61gUBBvbFLrThA4hpLMkCkPZT0Kv9ZY/SO?=
 =?us-ascii?Q?8ywcg/sdn0G9eJMTGa4vt3L49v9tdfvIZWsrGVHNYwJcGdiklpAS0sHECCZQ?=
 =?us-ascii?Q?wShkRmorDza+uTRwWzK0qKNZ/gzhs2xI0lZvm8/HiNFjzjysMK3XJjfFRrUk?=
 =?us-ascii?Q?Rk1Yt0RsU1IR61JikJx9QGF1H3YX8x0Ye/NpDfRVolne0GdeUVVFdd9u5IPQ?=
 =?us-ascii?Q?BotK0qlfP1AceopXd1VulaL9YgxzIy/cZgqc+qqIVMKVW/k2yYq29LzBiWNS?=
 =?us-ascii?Q?xtBlK/CY4p5jlO1jeXxdmwIfjzBM5o9IIcyOdyjr/5uJep+gwBmyGquXCVyH?=
 =?us-ascii?Q?WaOd5co1DbkjFS67fnvV5OVusEIHoEmfke3z+3nI8WvFEmFMHbdJqAnIB29Z?=
 =?us-ascii?Q?TL5XCZgv4WtneC/eqcQp13VmnXM5LzrLOm4WZ4TAtF2i7Rf+nG/wkA3/hhFV?=
 =?us-ascii?Q?gAqPbrR5Apr7yo3s9zasG16erjKA2vjmaZjpJys+xDvgBh3VHIXYD3zrTXHQ?=
 =?us-ascii?Q?ww6xaYK18D7fynqLvZ3g814PnIKdasyVkavKEgkNZNCd4fRDY/GEvmM4yy9Y?=
 =?us-ascii?Q?O/hsC0PO34gXo8/MwATw5yCq9V591zOoGzH1+spyWLOP8p4HEkbHLirgflLp?=
 =?us-ascii?Q?WiXUSiI+L6ZYSPKUQaPTLQvzkeslOplhb5VzjPoO/GWjNCLoiPQjsMIgqFJB?=
 =?us-ascii?Q?yMmAXFaBNNtC0A5dhZ6bx9RiScepc/WJ88ayFssrAESHCOm7U2fMZIAbhgHI?=
 =?us-ascii?Q?uMSEGmZ0Y7oIscWXwpxahcnughhy6iFDpXoP8IWqIrSdQ6aNd57XwzIzhRx2?=
 =?us-ascii?Q?47XTa71BUs9y0XOxqJqquZwI9XxgJt86N+t7M7a/GOceE6FjHvE67aSzhzfv?=
 =?us-ascii?Q?LONzcTViL5SXRiPxzEB308d7SJ6ENl9L7ndJSZS8tnrqKIzxwi8mWc+VPO4w?=
 =?us-ascii?Q?G4hFP35cSzzQS3phui304EsBIMPTVDuH66dwtfY5CN2vsfNu8vOloOJG1pGG?=
 =?us-ascii?Q?HlU4/7zvMg+Mk6bjQKmwB3tsdBGEkcaD8JA9Z/8q/ZBv0elHYz3wtbLn6zgf?=
 =?us-ascii?Q?L7xd3c7V/BClfhKDK8QGqMIN5cKfRcch2Tf5PFw7cYtQANT4qSjZxX1Fz0mt?=
 =?us-ascii?Q?S2qSm4eIFZRJUV+kWx2PwWXlSDLrBu3lv/cGIEPk0+RCTVCNrnsb2LeddAxX?=
 =?us-ascii?Q?0hSHuUq6TxU5/B5FyweikxUw0ISHHjWxduJWIcM1gQ98YjA7b/fq2v9tJsw6?=
 =?us-ascii?Q?Sdd79GoEheUEsKTgRo4ukDxj2fqE1SaxdFg3UCPVcLzKNKnPDdX/gcYf0MXn?=
 =?us-ascii?Q?WSBAqqm8YgGbe6U3TlebxADd1JB8t2VxUUyPyD2nC14F3g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iIC+F08UgW4sKRLnUFk2cNOsdfvvsH1RrWoPCuUIhRN7/VUumP1Zu1go/5od?=
 =?us-ascii?Q?SqNYe7qbC70i4Zx7XIO5/i33X5u3qQi0VZMhWynFpSJbIRtuc8fnTpa9G1zB?=
 =?us-ascii?Q?5/yXfFlHTGOoeXxgXqtF+1EarZRh8ORTv02T0y8+x02Fj2V4+z46rx68zHor?=
 =?us-ascii?Q?KvYQ7jt2NwTTmqat6KflXUZ6odmU4UJ9kIgm18rdzGrA7wm37yThHVP4yxXI?=
 =?us-ascii?Q?+ZnMhKb9JA3Jc3QsoqBGSklr82j8Jhm6SqVzjHBwxoBvAOENKW8LrCDsiNO+?=
 =?us-ascii?Q?OxTvkW4bfl/A5A21EkREJfzT5NiVvtzjUS0ZhB5aC67xYooEmIanfYOMqSOB?=
 =?us-ascii?Q?oqLRHY0+Qpz7jUwiGl/+rYS/5k2I7TyTu0/UWwdP8Nf1d/ZaW08SJ+7FkbUL?=
 =?us-ascii?Q?zRNtGjEenP1LXZw99+BT60swOtd9hQIzCZiM9l1JkzLzotrkpVlv4BAX5V3K?=
 =?us-ascii?Q?6XIDAxnIYEzHzs5Ju/0c3k6jAI1I2si71TeJBsm8iZKxxmnNchojlM563/5q?=
 =?us-ascii?Q?X8e8mqkwzMLyshi9AAamwWppz1voC8Q73TfT9T2tFA2N2z5NBJGkml5GwGmI?=
 =?us-ascii?Q?Ar+65Rrv/U1Jvk1OzHP/iKk0dhKw82h7D8iufCJgGVULPxc0xYa7ZTk40buQ?=
 =?us-ascii?Q?fMjnnxUGcujAPBPD98WnrRoR2vROlYRIpNd/Z5MIg6BdhaHeuDAK8Ln25YDr?=
 =?us-ascii?Q?trM5rKzJaiPbC8MdR+wu27/S9/4EEjcEEBvtrJqZkhplAfspy+VfADP7FAhQ?=
 =?us-ascii?Q?HVNhbWpsM9uQWuv1+f8c7e2s00JCu6NgLA/ALMW5yE79m0T8WZnr46DB0dpv?=
 =?us-ascii?Q?dVVndIOnGh0/P1oeVkiiZmoG/4ImHtB23UNGxRn/q8h+XIdG3YoloNKd8eIR?=
 =?us-ascii?Q?0w2+qF+Z9PK7rlFUfE7ADW/nbvloZMzHGefvHH+csxuNGjPsqQfeWvKxErVN?=
 =?us-ascii?Q?DaG21D32mXvH1LYqBnUs8UohgLchS2oKbYILLQat3EGagVzkEhkOooe2v1s7?=
 =?us-ascii?Q?KjYXKGzpQrxTWkOzqtAlga0uwGxdRs+kl7Z5DNC6CrIWu2l3bWrh9VNC+FTb?=
 =?us-ascii?Q?Cc4SsXueYl89YqPJykpxAec82mZ+TM12NSXkwFhkfd9pC9kuI5PSRtpxWDvX?=
 =?us-ascii?Q?oQaCOo7BjDi/kz71aR0qNak9notX1MEI3BTv9VUrT/6xdvZBBfOUdM8kWFuk?=
 =?us-ascii?Q?2XyISYyXmn0hxGR3/DiFuyYw7MkRSnhi4tSDvQG1cdbP7fIEiDS+Lq6LddV3?=
 =?us-ascii?Q?uiuL+hUNj2EEJoUbqrlQT3Nf88IrsjjuNd5medt8b+hq7ZP4/Xd5Pfabl8an?=
 =?us-ascii?Q?Qmz97v9VbMgMq/PTtrAz5smEXWeAGDpPz78nDGYHiGZLlxv1mQSx01zvbZo9?=
 =?us-ascii?Q?xwp9leFYrQDj8lI1tTQF3lmQY70UMrx28Faato2srF5jdPNV7ycHLQme702Z?=
 =?us-ascii?Q?JujzpeioPBbmCuFN7VJqEsUcVqMUiXa2gtrq8hTv/AJ7WKmM0O2NhwF+i/k4?=
 =?us-ascii?Q?+MIsmT+gyZlVXDmyQ5v2ao7GgTe2w5L3oseBdgeOz67JLjVkvnsSqRWeEpuR?=
 =?us-ascii?Q?0zBJMmX4v2jjgCdmE54=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 420168c8-66ea-4099-54f6-08dce5e3bc7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2024 08:49:06.1949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q97UbCPH48i2u7dOqjxInI8bdA99jE9d3rqd4PnEyqFwHQMV+kG7xYRsjCw2wHauNe/qxv3obDBABQDWVT9s0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7370



> -----Original Message-----
> From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> Sent: Friday, October 4, 2024 7:36 PM
> To: Amitkumar Karwar <amitkumar.karwar@nxp.com>; Neeraj Sanjay Kale
> <neeraj.sanjaykale@nxp.com>; marcel@holtmann.org;
> luiz.dentz@gmail.com; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; p.zabel@pengutronix.de
> Cc: linux-bluetooth@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; m.felsch@pengutronix.de; bsp-
> development.geo@leica-geosystems.com; Catalin Popescu
> <catalin.popescu@leica-geosystems.com>
> Subject: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for su=
pply
> and reset
>=20
> Add support for chip power supply and chip reset/powerdown.
>=20
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
>  .../bindings/net/bluetooth/nxp,88w8987-bt.yaml        | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
> bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
> bt.yaml
> index 37a65badb448..8520b3812bd2 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
> bt.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
> bt.yaml
> @@ -34,6 +34,14 @@ properties:
>    firmware-name:
>      maxItems: 1
>=20
> +  vcc-supply:
> +    description:
> +      phandle of the regulator that provides the supply voltage.
> +
> +  reset-gpios:
> +    description:
> +      Chip powerdown/reset signal (PDn).
> +

Hi Catalin,

For NXP WIFI/BT chip, WIFI and BT share the one PDn pin, which means that b=
oth wifi and BT controller will be powered on and off at the same time.
Taking the M.2 NXP WIFI/BT module as an example, pin56(W_DISABLE1) is conne=
cted to the WIFI/BT chip PDn pin, we has already controlled this pin in the=
 corresponding PCIe/SDIO controller dts nodes.
It is not clear to me what exactly pins for vcc-supply and reset-gpios you =
describing here. Can you help understand the corresponding pins on M.2 inte=
rface as an example? Thanks.

Best Regards
Sherry


>  required:
>    - compatible
>=20
> @@ -41,10 +49,13 @@ additionalProperties: false
>=20
>  examples:
>    - |
> +    #include <dt-bindings/gpio/gpio.h>
>      serial {
>          bluetooth {
>              compatible =3D "nxp,88w8987-bt";
>              fw-init-baudrate =3D <3000000>;
>              firmware-name =3D "uartuart8987_bt_v0.bin";
> +            vcc-supply =3D <&nxp_iw612_supply>;
> +            reset-gpios =3D <&gpioctrl 2 GPIO_ACTIVE_LOW>;
>          };
>      };
> --
> 2.34.1
>=20

