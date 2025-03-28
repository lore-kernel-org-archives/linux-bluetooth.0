Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B5F35971;
	Fri, 28 Mar 2025 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743170151; cv=fail; b=oFgtN+7LnVFsclecNerOkBoav2Rb3dBD7r+j+VTvxPieCkiuedToJUSwOemSNXSw3XhvQcvYu2abGlJhEgLynr88pDCFhyUUsj4k9Bz4mICjazZXm1zv0GzFtPdIOrbStynzizlxiNtNChdd6s2bnl2WeCMDkiVIVPvd3+VUCfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743170151; c=relaxed/simple;
	bh=patloW8CaI8w6oNhRtiWw0lpxDJty2t38df94oZJOqo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R3sfF68KT9H+7vtQPtIT0oedRgMYZjXmiGaRZClFZvY0pe/mp/rChW2WV6uY44nKDKSUkD+XzTTNnk8Bo2yZMXXJ3wZ+t2TdrAV5A6s9Ci+bMQVlrGB8Lp1JhonHzNxIvo5kGv4nP4RinUiNvaUu+AFAawhULzVDbgNVafNqTs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IL0EGQLK; arc=fail smtp.client-ip=52.101.70.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IL0EGQLK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJjhnvq6UBWi+vo6d6GXb4n9jJWXSbLGokNM9+87LAOmS8qt1YqGlVHWMz0VfxZ5p1hZG+r7jsxmNJfasLVBef3amSNvmQ+F98xKATcRHHvWZjj9kh9VE+3sCyoc96AM+2F3g0lGCNwRsIBH6B5cUlgmF6X/FBOzdgk0WeOV51RpZyoy2c5TSOVW3ezlWxxI6AgmzYVGE/JMLsYSVJoKepSxfvtusfVLQruf3L2kppt2qNae9l+CANnT82iedjApCa+ESW80ieRL/3tTlJLkc2xp0BT/T2ORyUC9uZEKYeCe59ha8/RgpsARwbbkRoeM00fJKTT4GQEOgqIX7QjIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEPuWA5ecRd0Pj7QkciOeDzCo5eIeiQkeq9yoAKXGjM=;
 b=Lr7AUYkljHFAh8+WKoq461IGrcSRQYCOPJbYHHtcOB38XhaW6tHjeG/jb4Y8C+hOmdcCORvTPJ7VRjgg+zlfj/xl9mCnr8h2D3iJSvqtZXCbjU1axhBiPEh8wgGk44c0TRdZb5eVehnTZlQoE4fB9W7aEATDSbdDkEPKrx5JZhN3PeCd7BGl0UfhQnr7GrOahYaLJE5Ugwt4Zrn/yF9ZNmc+K4wX1c6MIk7xW/97vIAHYV01nBccwcszn2RYVq2Qk39Pcm4XNQ7V89HdJUKg9NZjB+Jsbc1h0m3YQxxl2Hc9qrQy9ERxSnU8UgUSSnQW8qd6VaXVadg4yO6su71awA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEPuWA5ecRd0Pj7QkciOeDzCo5eIeiQkeq9yoAKXGjM=;
 b=IL0EGQLKY+YWn70iXqvhEBX8AY6THXY6887XxcBU91mL260WScypn5EY5P/g2qWyA80u75UnqJua8UvbTkpvHW9JQSDTJSSfHklqyDkql6zgOLtfvHqH17aki25Hk5dxU+GqqieE8LkM8X0IgyUIEMxjV6YH7fc0PZWhLQyDHheGSRr9t4TcjZw+4t3rLc9QJbTuUYDNJX5M3tng87mEeP8FJsQk2FNqaEb0ZqMJKrOQH2u1BcBXVM6zUVh7qsS/Xk8bpVfE0u/lEST0Dqgk8D3+K9/wo+7YtAYRWw18x5mKz/7eIr85bhn4zYd0p+IKU9TYNRaiJp+7RhHV3clciA==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by PA1PR04MB10359.eurprd04.prod.outlook.com (2603:10a6:102:449::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 13:55:45 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 13:55:45 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Amitkumar
 Karwar <amitkumar.karwar@nxp.com>
Subject: RE: [PATCH v1 1/2] Bluetooth: btnxpuart: Add msleep() after changing
 the baudrate
Thread-Topic: [PATCH v1 1/2] Bluetooth: btnxpuart: Add msleep() after changing
 the baudrate
Thread-Index: AQHbn0VYuH7+rwFwdEOu3zHL2m5J1LOIkt2A
Date: Fri, 28 Mar 2025 13:55:45 +0000
Message-ID:
 <DB9PR04MB8429BC22B2C984ABE68350E492A02@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250327182523.524534-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250327182523.524534-1-neeraj.sanjaykale@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|PA1PR04MB10359:EE_
x-ms-office365-filtering-correlation-id: 3dd37169-986a-4944-8651-08dd6e003cc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uHKmF6tkqBFUQJS8nWZWtpDfB+gMrZefPO+jcPuaWDivr/t9YUQdDDjDtDJx?=
 =?us-ascii?Q?aPpc6j22CI1U30D7+FOZeTDf9jubmsiNQwGHhY81M7vGgy3taDKw68NfRrRa?=
 =?us-ascii?Q?lqhVQ9Jc6srg8ZRT9Aw1mRHPVDeE3lwZnb3sdTWoTEqRhVk1hus080Ya1yxl?=
 =?us-ascii?Q?jZEDqP49zAC+RHVKD2NKcWF88DFwwnZur/mQlnhpsO3cplWxvh9pM7MW+WZC?=
 =?us-ascii?Q?E1kR3IByyt9SIG3L6m+uN/tSf2u5PjfCNkmLO4b/IDEf6GuYkZHhWjBHWdUp?=
 =?us-ascii?Q?8ggqDwt+rXn/IyR+mpmJkc7tYM2gQu9G9CPwVcTmYt9lbqn0K14sArClGzlK?=
 =?us-ascii?Q?A5Q5blZOgyZgIxXd5fn+7yi/r4PxAgOqAxxtG5+GVqJ8llfqVp2lbsowB1GA?=
 =?us-ascii?Q?51VnY+5L4gho/vfo/C7H9GAMRP3Xrs/eTE2E9ziqcnBPz5dSHEeJUOwtIpVv?=
 =?us-ascii?Q?1W0d+3hwAweN2CnwbBZs4LZpIIE8uhinac7zK4Z7Dhby6mgnkQY4XE3UvJqD?=
 =?us-ascii?Q?ZhgJV3frlkZo5WtAgHgKZq9GWIH0cI2eCl5oeFzav78ZEwYRAGiN09LswIH5?=
 =?us-ascii?Q?KbE/e8IxB7UJwNgvR5XzVEUo0/9DA2JE4B6/sHv6ET/81BurkOZG7T6fqHtd?=
 =?us-ascii?Q?DT4ecy0+3nv/AH3tbZdc0e4/oqPcogQojtPIyMFNHNBVg8wGpcSsaD/Zo96h?=
 =?us-ascii?Q?KzHSEppPRxK9oVEbbrVpzQua0F4od7urR9Izsd6A5acNy81LWwUX4jkCB/MF?=
 =?us-ascii?Q?UcLjpRS2UZpLTF7Mw8+5wY/NpncBEyQWrIwkgezgvAo77BkrS9qIGJsNyLS5?=
 =?us-ascii?Q?cmSa79CzZQYQHm9P32vovqdo/qCpCsz0ZGTx/v0BkpfSwjr3LsoqmurWA8q3?=
 =?us-ascii?Q?YHhHiwGaYXPG534Xc/2wotHWgaQCeEbDZYhXpdkZufHdHQsySPbmTD5AhilE?=
 =?us-ascii?Q?xwikaYZJ+SSEu2zmKWvwdf+euIwDy3ckFwCW5NecnFLYNBiwaTG+YHLXY8tf?=
 =?us-ascii?Q?kkV+tCpD7rlI1GfS4Ye3ILT8YUJW0Ba9xxiv5t0z9i6e696PEkFb6pQYjKsx?=
 =?us-ascii?Q?V62rp7hJFlVoc9fmsZdljJ5hjnFBDwdghAvCyxZyLXH/mMMEHzahS6TdSyR1?=
 =?us-ascii?Q?5e9YM805v8DCX53rvZjKvNx8e2w8TAOf+buO0ZANN+5AmLotGLRbpfRimt+B?=
 =?us-ascii?Q?Fy+yT+nBlreWju4Mig+dEYr7kyHHZ5hi5/KwFMrb5wTsJHVKezBXSirUD83b?=
 =?us-ascii?Q?ivARj/5UeuljOH8gHRdGa5vEoby5O2Hj7NuwqfxX/PMCJpPYkMWCfdGbiK+F?=
 =?us-ascii?Q?0o2ysAA1U55KxvKW3gMm+X4a2Dfqmezc3Ya9WmCabLhSb0QCZXu8VC3yepdU?=
 =?us-ascii?Q?SvEXzm6TTaLCyQjgaxu9xlc9yyte0iDjOJ4gPBCdub8DOqDRk9/bzGUft2gu?=
 =?us-ascii?Q?r4n/m7Sb/S1psed8iD7bPWK05lYBR5+m?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7iK+ywIP5Rd0gCiI6DhtWIio4RfN2KFSZmbcYJ0nL9MJorv6k6p2mLQtm62J?=
 =?us-ascii?Q?hHj58RVhO+Ul6tGK/1ubleuWNZcr6G1MxMiKDLy3GpNyiYgLoCZnLhCC8cQS?=
 =?us-ascii?Q?ND0rRSxHpNAKtl3xpzBpgS5WfsY6+IEaMJYMNx3ZsVQ6lL99wLvpIxy0qGTg?=
 =?us-ascii?Q?KRpLUzr7ZFDx+TENqO8mLez1CyHbOOZo1iOvKe9bZWAoipCdw/RoYOqVEGaI?=
 =?us-ascii?Q?QGw4edmnNLw8Cfew4uBqWgx7m3FHrapN/NV3678AX0qlgC6R8TmeSKo7mRiv?=
 =?us-ascii?Q?zY6QDke5inWh9/DabbvxZ9mztmEabnjxpx0R8cFqNwiPxjx4AKkwYhsaQ1ev?=
 =?us-ascii?Q?judtOr2qDq1xnPBoWUvCuPwkViPwY+WU7wF6QoeakFCVHnHz9ONmxy8Bj7KX?=
 =?us-ascii?Q?VscSbdyicJhl2m0wKyMlQ+m49HOUQP+U19XRJw2dyjd0DGP2erNZrZZPwGdN?=
 =?us-ascii?Q?RoDwTqqGAbrDP5FgRm2d9UepGRhWBSQTqoVgfUoB8kanLT6eT+zC8g1t7ClV?=
 =?us-ascii?Q?EsezAovxiaCLa+t6xPylulDrqCS7XJRjLE7K9dkn8yaL7oCOoYTOh/zJxOQR?=
 =?us-ascii?Q?cM4nVCLGPBt3ypENH/K5enegDioWA7NPkPy+AVJWethvHTdLe29mgHrXwL9Q?=
 =?us-ascii?Q?ZLiB7kLjosmFku9D+dF/a07Zm01/qOw6vjwypIZhGfB91fq789ldWXDnSYnC?=
 =?us-ascii?Q?h7rTuowxRCCCwzehrF/pnzmsVlzJhCW2+KI5uS7Peu64YsfPiSV3DVbZARdA?=
 =?us-ascii?Q?UH4nNaQbqB/jOeHBWfmssD0fJLuR6LXxZYQ3RyLYIy1UxGqKYVahyNV/9LFm?=
 =?us-ascii?Q?YUw9HVspfzn2fJxiLPKGKpeO/4Xw9squMnQ37+/I6yY6mKayWon2x5PayhiJ?=
 =?us-ascii?Q?9JBw0MQTRvQcaiEtN1fx8TRHj03kK0jAys0Bt4nzd824pr+Hrr39GGLmSyIp?=
 =?us-ascii?Q?xiUY5iINB78AZ1id5l1OLvyPT8yvcZY8wy1et0wRvaBauAcGCJJ4WCUFHLlk?=
 =?us-ascii?Q?2H+Kj7Y42SyJmAisNCz+/DPbqA2CNZIBvv/c0WWnnBIzhk7JTC29oG3dR4B7?=
 =?us-ascii?Q?5FEyD1Z4nQSq/QKxbtdOnD/xf0ypu3SpM5lXOTJIzWC9Zr66azbZpWuP4Jk7?=
 =?us-ascii?Q?bRnCmdP2R+3sqFCaeQDJu7P0WVcvjdld4tlRD9Bh1wL8pXxOpNWx0H4WvktX?=
 =?us-ascii?Q?9Poq1AU7XAKGTF/YoSEYaiYkIfL3LaNNAr4GB84DKqWxRhmaDWmGtb3PqkHn?=
 =?us-ascii?Q?jByCLDAPnnaLB85WlCfumR68rPPIwjEUXNFOhBHMXhTuzF5yGmUr4brvhWtB?=
 =?us-ascii?Q?RGu6imVeMcIze7bPkbF66U8LRKZnaccHv0N0l3+vgSv1ZlzsrwRqwRpD8erM?=
 =?us-ascii?Q?O7DbOhZ/6MNmqo4VCMA5GN9TPqELWdJ3lZe2RePcB7bY0Yws7S0pTtMbS0UT?=
 =?us-ascii?Q?Lh/aGJkXH2v2bl2a2E3Ekro6LFEL4x/S+tidSGB6897hRXRjlP540pKyc0gJ?=
 =?us-ascii?Q?8AehTlHh2RS6xtxFwddj0cqjscKqndm4hNCX++Rby6PR7wSizh2DFotLqxc0?=
 =?us-ascii?Q?u4EKZaR7S3imuHvGtKQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd37169-986a-4944-8651-08dd6e003cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 13:55:45.4763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FaN2IB+e+IIy3io+kFiL4cGIFp76zNykE8QQN8pVHtm6zGibG7gcR5sjCZLH8yz51I1fau0IaBTDqww+kkIhbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10359



> -----Original Message-----
> From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Sent: Friday, March 28, 2025 2:25 AM
> To: marcel@holtmann.org; luiz.dentz@gmail.com
> Cc: linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org;
> Amitkumar Karwar <amitkumar.karwar@nxp.com>; Neeraj Sanjay Kale
> <neeraj.sanjaykale@nxp.com>; Sherry Sun <sherry.sun@nxp.com>
> Subject: [PATCH v1 1/2] Bluetooth: btnxpuart: Add msleep() after changing=
 the
> baudrate
>=20
> This adds a 100 millisec sleep after change baudrate vendor command.
>=20
> It is observed that when the baudrate change command changes the
> baudrate from 3000000 to 115200, any immediate HCI command returns an
> error -22 (Device Busy).
>=20
> Adding a small delay after the change baudrate command complete event is
> received helps fix the issue.
>=20
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>  drivers/bluetooth/btnxpuart.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 5091dea762a0..e26fabe8fb3d 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1238,6 +1238,8 @@ static int nxp_set_baudrate_cmd(struct hci_dev
> *hdev, void *data)
>  		if (*status =3D=3D 0) {
>  			serdev_device_set_baudrate(nxpdev->serdev,
> nxpdev->new_baudrate);
>  			nxpdev->current_baudrate =3D nxpdev->new_baudrate;
> +			/* Allow sufficiant time for chip to switch to new
> baudrate */
> +			sleep(100);

Hi Neeraj,

Assuming that msleep() should be used here, sleep (100) means 100 seconds o=
f sleep, too crazy :)

Best Regards
Sherry


>  		}
>  		bt_dev_dbg(hdev, "Set baudrate response: status=3D%d,
> baudrate=3D%d",
>  			   *status, nxpdev->new_baudrate);
> --
> 2.25.1

