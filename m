Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2073.outbound.protection.outlook.com [40.107.247.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C3BDDCD;
	Tue, 26 Nov 2024 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628850; cv=fail; b=hApnqpcls5AUR9r7S+o3IHhBGFBxZ9MgMKCoXLcyDOu6Wg6Ev073fSAxjouCCDJoD3wFsq8HZVZSOltVDe78nSLU/00huABdOwYZj1Q4yzrAMWv2ebe2M6QcrOc0dVgiMXBwYF1TUQm8FnTP5SwA0xUZwzfKipvx0bqnbYjEA6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628850; c=relaxed/simple;
	bh=FpAoNb+2+3cYhb6+ewCOrUIJmyR4ds5IxUjb4aZKy5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AANZgWawQvIDTAEYu46Rkt9rVkjOu5TMWuEpv2fDW4dcIUorU53a5YaZsEKtDIPbV5u7HBlTJ6gd2BzJSjAcSzHpTmy66/IsrJl528u7FxBBDWsMve9J8f1oBI+zOAWGInCq12f+WjA1cYSfAHWAqXgiHTO4va66S3jEYpRETr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NVs5Oyv0; arc=fail smtp.client-ip=40.107.247.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NVs5Oyv0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HX8P2G3wMV78knC29kjcT9n1a1vBF3duWw2hv8qJqnAq0+uWmids7qWpzw7qWEhokHWqNhUqDhcPyfKLfn3MjLKem3mEcEsymAekBr4FB8cpqVi+4kSYP2ff0N15NOezh5eo4mciepjPu9H/IBF8D0ha1RZPqnfDXq7HEykUSxeW7CrkEL6wqJiKlji1YiqStXejuct1NywhSUk9ElvtsLzqcXD8JvCwRkJmA0ohNV7ybOfcHhBl2qBBu1E5rH60nYA3Ap8spKOdwk45odjrN4Wgd7UsOfjAtTw+DpUOXJ/r18QilBsRKXzU0EZR2fUFrrnxN1l0t27YNPposHX3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItJgO4M3A0HY1JjcbuHmOe95mMiI73emaVSHG9wkd5A=;
 b=svdcPpICnivK9kTpExcMCb52uEj1FmlIAM2vdTYc44N/7j+p0aqhiMgDr6aiIj9ZXdPc02g4WdCOg9P9Mt/jx2qRwKNaMk8L7tUT3en4TcFFPVO4e9oJiUU4KP3cfRquD9QHmeLBOQCyikB/OCGLhBL7kbxP/lzGUeP5laU6YHomqWK2wwBdBqb+YcYs8X0gqu4kQV6guMSZu/3q0+Qrczdh3U2pJ7qoN9FgM8bF2Zbbj8bN9bS6RaUJ4Rl1AOCCxarFvWRrA67yyff/GNAA2hXUBlH/OLU85sS1UJS3+wovjW2cyMwk6jMpQX3v6/j6sTXSa13w6yme1LV2KAv4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItJgO4M3A0HY1JjcbuHmOe95mMiI73emaVSHG9wkd5A=;
 b=NVs5Oyv0sIG8XjB7Lt/zuT8g03xmauuiERr1XzYZbV32gVVRYeQ+lmjTAqGCqxtYrjxUal8x4+A9uAqTyHIL6DYsOYO7zunscGM02YPdV3cr4xbyhTimN2jRSzQJrKHyztrE/Fnu9i0gHLYtV7BLv9L6HCro2xlErEhkNMI6jHaT0f8oFyJhseSJAyrDy8cZHCBaHc50fys9yx4DmvKzqxc4HsiEiJn1JpIKRjCGs3NvtQtCqHZYiTh7BFynHKUiRz9vIu6XjG2NqCM/TutYIjrfldlvHoUZLTW69QwpLNGCyUgZpbPGe0LFUpVLZoUqLBX6y6GItqzlacA+PJoUqQ==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM9PR04MB9004.eurprd04.prod.outlook.com (2603:10a6:20b:40b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 13:47:23 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%3]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 13:47:23 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>
CC: Amitkumar Karwar <amitkumar.karwar@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Fabio Estevam <festevam@denx.de>, Sherry Sun
	<sherry.sun@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>
Subject: [PATCH] Bluetooth: btnxpuart: Switch to SYSTEM_SLEEP_PM_OPS
Thread-Topic: [PATCH] Bluetooth: btnxpuart: Switch to SYSTEM_SLEEP_PM_OPS
Thread-Index: AQHbQAm4d3ur+Jqsu0KAsOlCKblJhw==
Date: Tue, 26 Nov 2024 13:47:23 +0000
Message-ID:
 <AS4PR04MB9692F9CB0AF6B7ED1D2F37F1E72F2@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20241122135939.337327-1-festevam@gmail.com>
In-Reply-To: <20241122135939.337327-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AM9PR04MB9004:EE_
x-ms-office365-filtering-correlation-id: 0203775d-6231-444d-8b0d-08dd0e20daf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LNx4Hfsu3e7vFoc+vVaodk94yTi8sqrUneM394n6QAd98XGD49P/qgP36fka?=
 =?us-ascii?Q?wI9CBQ4nTNFrp7PL/4OpF1kpapj9hKwgNKo8cHy7NwaUEo50ClpPNVZujKg7?=
 =?us-ascii?Q?MTuc+S1bI+VYJSpNHiolUdklLFh4I7wjBZPLL23Jzma8pu2vl/9zy3x59ewA?=
 =?us-ascii?Q?YNNMZjR/+uthgwgJjCdmhEdif2Eb6RcdckkrsxHc6zrQYaOEPzMgYvAD0Jc+?=
 =?us-ascii?Q?k0mMfvFx4yjP6YBTKVxTYLp+axhVIr9xvYya2Z+9uD1SIvYiLO1HSaew6Ipt?=
 =?us-ascii?Q?rf8zSg/aaFOORSkMY0ZDsJzjtRbKOKiZoSpp28sq0QYaIwc32EImnCHhevK6?=
 =?us-ascii?Q?ESAvgpbJ2MNXi+LWwb8x+SZh/Hr9oGZtcWMZJMwkw2lnIR9Py83Dz6QHmukY?=
 =?us-ascii?Q?Rl6d4SXZJaZTi0frgXSRyin57RBDaMWUAg1c1bLNgd2POPGU+4qhUng4YYLg?=
 =?us-ascii?Q?urpshloYR20nbaXT5cApwhZB36/lpHRkwhanb9l3myu9XYfhPUqm/UZTCSav?=
 =?us-ascii?Q?LBxQb78IZgIozFW8MMtMw7RsgAFoSKD0c6FLflbunQGjzY60HKKVYzbLKHY3?=
 =?us-ascii?Q?mVKlBnDYZYvavI27rjicAMeNwyjFZURHnK3Mi7Ggq6fg14oagOjDEBZpGR3n?=
 =?us-ascii?Q?Gi32HsFORL8Er53vnw4dJf5ItaSaKr9rBanajsJh44KtWOLMcPHCL3gXifOj?=
 =?us-ascii?Q?i8Mcad5gERBSgjv5UKNp6x4YwHf6ln/vhz3vfbXo9+wgEIGC0F20JwIaunz6?=
 =?us-ascii?Q?oZ+LvtKHV1rRAxuIsv8pnpa61h2hkA5Ywv4RTYABbUGzvUtnWe4ZU93a2hyM?=
 =?us-ascii?Q?S4FhMdRoHXXqZYcBL1k9M0EX25gqRWWvGHDm72ww5guLa+8JOSV1P8yWpOXt?=
 =?us-ascii?Q?uwaj0yxiTEXC6n9c0piRiAUBHi/68G5Ojih0nXEkIXoeyBfG32QIsGFe0oGa?=
 =?us-ascii?Q?h2bO30synoP/RU6lT4p45wrkMCc90g+M4C+Qvh9kLPthVV1OtbHGYaoo4hh7?=
 =?us-ascii?Q?9Va8KSK0CjuWhkPp2Kpj4soy4QF58ko0UnLZo188/Duxuk/6lZhBdBnHotq+?=
 =?us-ascii?Q?ezr5qJVochzIySOghDPelsFjsyG3lnRGcirpS25od8Wx/71b93JA0GkI/c1h?=
 =?us-ascii?Q?X2b51PiO537wIWpHgY9U2SCIrKsTmLnPGnWKKhcKqg4+AYMpa+Fe9UUWMqr2?=
 =?us-ascii?Q?adn2Tx5VVnqKGFkJB+fDoYvWjKrwxLlTFKh4fRvnglPJnBvTjmTurYb+kqSn?=
 =?us-ascii?Q?tdfl94kb08B8TrRZlCSSG02R9HOuNh+FnECN44kdU73//n6piyP6fi5S7r3G?=
 =?us-ascii?Q?Dc+99nySryShqeRR6YMHO6c4J6tP1mtU5ebcM8OCazi47ucVgELfARyoNDx9?=
 =?us-ascii?Q?TTZlHU/oPdDlsM9Gb/2GAUm49DYXOenMd8x2wO+0wj2V3HS9IA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NvFIWR+hKSjY+q36uEiEHjTE2UiIGFZBkdLYAwJ0E/DXzrKZHZ3DlWDaYqyA?=
 =?us-ascii?Q?xYgG+sIIiIKqCqxLoSCShKgH7XYyrEwI6llBn0xTBRmWupB/1QIMypBcvcaP?=
 =?us-ascii?Q?NMZUjxsQp0xPLTW7K2Mkhf1j2reeUpVyeXhNIcexUrXC9BAj1AG5DAEeu7kN?=
 =?us-ascii?Q?0qsmrmL8nhvHDMTYeKWkOgvnr8BvRyPRXrBBn++dCxjq9LBw4GHBYEv8YNMQ?=
 =?us-ascii?Q?42O23pc+vFACMf+kdsX3RvkiJFJyOciHWMBEXUFbS/2ksh8kKDBmD1V/SGrD?=
 =?us-ascii?Q?yanonhxjOOG0xzkblJxveLrhEqAyVE0Pvay6QVT/4pHkgOtfvUEz03ieHpOR?=
 =?us-ascii?Q?33EMWG9GKmmfwdjlhDhOgqkz2FNuj7QX+zSPaSn0u5AAK0vVOQ4hMnCvN9Fp?=
 =?us-ascii?Q?a+/wilrENvAcfoPenjkGOspMQjnoXNyRX7kYhTRhrBHK9abocz03W3Ljuucd?=
 =?us-ascii?Q?8TT0SeVnunDXjeC2raRkls1l1iTAL1dY6ot0W/agBFOA97exR4P9Btn/v3Xb?=
 =?us-ascii?Q?txMskRnDf6GibZUjQ9+WRdSWJMl5GH7MJdYY3KFvJPPSEQNo+yt6wjzUrtjj?=
 =?us-ascii?Q?MF4B8vYs+wlTtDJvtirQNpQyQGgMJEpY+e4yiE7woK0KnVeCPMoo0oyDvoNz?=
 =?us-ascii?Q?3bZbf92axJja0ThwnaFVcN0I47oJlroa4R4XZAJt0UKI7Ab3tBA9JCMRWxk0?=
 =?us-ascii?Q?uJOYC4ivr5UUEQOSZUpq2yZhBwqpsXnAKQhdcXAHik+uSO2d0BM2kXPMJ0Bh?=
 =?us-ascii?Q?fMP/voqSX7A3fuJZYcrlT6kF7KX0XR9I1DIDVlnrSPbAztJbftd4G4MsmHy3?=
 =?us-ascii?Q?SeKuPSVJYGm3xDiGEnRYdxnEpsNXExVo9TPzoESkUuMRqC6OJb81BmgG9emV?=
 =?us-ascii?Q?w2Ab65grLi5Ispuy9xZkXiHg419prZpgY8FjjMVpcNFVGzhzw3iDEYpzUNz/?=
 =?us-ascii?Q?WvCOSUavekVwbZBa84Tnru7+Y2pLDCMhMfgimPVKAhpfsKT6Cz4S7dlCYH39?=
 =?us-ascii?Q?sjbS8hR/1n0W5rN8MRmRTOV0Wm9bH84Rpx4U0ZekWk4lHlHAQ0mMjZMaUFh/?=
 =?us-ascii?Q?e3SIoZwjMjFc6QR+KYJGaJCOvlSlwzB/6KN7LKHRxwXZ0t8nc4kUtLamENXY?=
 =?us-ascii?Q?ElS6lcOsONr5bQW+lK4UlCX24hOYgf7lOHEwCaQxhWjf39xyfDFC11+acBSw?=
 =?us-ascii?Q?Vd9tFlpbrppvwbFFqOhBitnGmgqSLMiLXqWqecgZpZ/9bowu92y8BO7JbqUg?=
 =?us-ascii?Q?/JDbActZf01/lOnCwBjp3l4YpnL74GZtSQoXwRx7fyCuCGP3N0DMVy5IlDVy?=
 =?us-ascii?Q?wWqq/k7V0RrfyS6EZQgeKDjKfl6Yzk530ECCKBsXR2/muRb39r3hlQedjszZ?=
 =?us-ascii?Q?OTJi3HARqRFvMxk+3qsJ1ycT8xGPYYDyQIPzenQOmyLBC7BeyihCGrbQ23Ns?=
 =?us-ascii?Q?UfshyX9yTT7Mau4UP3YrXv6k03NSmI6z0vB3igMLAN7SSaJOlZh2kmrlF1kG?=
 =?us-ascii?Q?GWBVHQiKZTkTu6dZ6L/TW1wuTVbfKMxqlN6jojROrAksiF+7CMYNX5xZjgZJ?=
 =?us-ascii?Q?fKaBq30+tjOyJHwMsTL5xTMnYkRzC2SR1BAc5moG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0203775d-6231-444d-8b0d-08dd0e20daf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 13:47:23.1543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T3yHnH0bYXE3H9yZJlhdopDoudDvLn2ZwXuOuQ1lPY7nJoKp4aLo9rKYLWfrfj4rber4nSQr7xv/IYjfSKwBnb2lNVVlLlMyMPOVm6rI7KE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9004

Hi Fabio,

Thank you for the patch and the improvement it brings along.

Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

Thanks,
Neeraj
=20
>=20
> From: Fabio Estevam <festevam@denx.de>
>=20
> Replace SET_SYSTEM_SLEEP_PM_OPS() with its modern
> SYSTEM_SLEEP_PM_OPS() alternative.
>=20
> The combined usage of pm_sleep_ptr() and SYSTEM_SLEEP_PM_OPS() allows
> the compiler to evaluate if the suspend/resume() functions are used at bu=
ild
> time or are simply dead code.
>=20
> This allows removing the CONFIG_PM_SLEEP ifdefery from the
> suspend/resume() functions.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  drivers/bluetooth/btnxpuart.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 569f5b7d6e46..06c1093c70ab 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1588,7 +1588,6 @@ static void nxp_serdev_remove(struct
> serdev_device *serdev)
>         hci_free_dev(hdev);
>  }
>=20
> -#ifdef CONFIG_PM_SLEEP
>  static int nxp_serdev_suspend(struct device *dev)  {
>         struct btnxpuart_dev *nxpdev =3D dev_get_drvdata(dev); @@ -1606,7
> +1605,6 @@ static int nxp_serdev_resume(struct device *dev)
>         ps_control(psdata->hdev, PS_STATE_AWAKE);
>         return 0;
>  }
> -#endif
>=20
>  static struct btnxpuart_data w8987_data __maybe_unused =3D {
>         .helper_fw_name =3D NULL,
> @@ -1628,7 +1626,7 @@ static const struct of_device_id
> nxpuart_of_match_table[] __maybe_unused =3D {  MODULE_DEVICE_TABLE(of,
> nxpuart_of_match_table);
>=20
>  static const struct dev_pm_ops nxp_pm_ops =3D {
> -       SET_SYSTEM_SLEEP_PM_OPS(nxp_serdev_suspend,
> nxp_serdev_resume)
> +       SYSTEM_SLEEP_PM_OPS(nxp_serdev_suspend, nxp_serdev_resume)
>  };
>=20
>  static struct serdev_device_driver nxp_serdev_driver =3D { @@ -1637,7 +1=
635,7
> @@ static struct serdev_device_driver nxp_serdev_driver =3D {
>         .driver =3D {
>                 .name =3D "btnxpuart",
>                 .of_match_table =3D of_match_ptr(nxpuart_of_match_table),
> -               .pm =3D &nxp_pm_ops,
> +               .pm =3D pm_sleep_ptr(&nxp_pm_ops),
>         },
>  };
>=20
> --
> 2.34.1

