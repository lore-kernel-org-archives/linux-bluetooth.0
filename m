Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013037.outbound.protection.outlook.com [52.101.83.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54FA335070
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 06:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891287; cv=fail; b=cUcbYx3yhOF2N4t1k6Z2m9aiPm8fy5nk0mIQ+9p13w3nEjUrfFtvX4SzYYzDpi+gzvUYsvJHWgm7qwkZjpemV+sZk/rdqklunEctorWWJ7Tg6GYyYQT0OYZUye4hbD65NO1J6OJLClabpW6ikW5d9/dcwvLmK4tSCM6H+0/mTFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891287; c=relaxed/simple;
	bh=hWmTcH78zvBDdJOwU3WE4iQAfZ2LAqof/DmTHx9rTfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dK+mlMRtZyaLX7gpuCqMMfrSZNk7HdzmlcOVOD+exkL7Pn5/kiPGLriW9acieOHqth4Pw6dZYoeRl3X5jRzLEC2N4UeoC3SSUDEhodFi3r2p7vZKm360p86blLdvI7R243Ss12wSfxp9WifdC5YocbW6GZToSmRYe/oOy46TkKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fOCaZ1an; arc=fail smtp.client-ip=52.101.83.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fOCaZ1an"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHJezLHjBofiXyJWsbAMVyG30j3zrCaiiTRCjv9lWT1rkWGrp7lZvVXU4CPRR3uYnJpOhD959lzkYtJDn4m1JesjLG7zTTmhQdG0A1f0STyfnHXW3ojFpHfJBFjfmgcDQEwFT57BBHvWdkMqDwyV5rBw3FRiXkan8lW30GnGyP+eSl0NfOJHsRV4COxKA3fHe5kr/TN3uXIXDDyYOD1421wi8XMVAicBbLL2GT4QO7S+FoesRbrx145y5rOk2bC+Ic9rKLCBRAEj15ghmMP8nE9qs+khxgQkKHgKmVpDFPl0zIHCqcLhKKOIBWEEGv4Mdv9nZ12QBGauVL6LgXYyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1op/Xbcfsn+AoSwQXLIHD0bi0UQ2Bb/nWVdXpyC54BU=;
 b=hErEB59MVHqAqDZeBbQ/KRSKgxN7NODkT2pd8LWiEVcmw328kMHh7e394Y0BxXICkmE42x1j+odtGMeJHdtph35soIA6lFFr4BKKL17Q2HeP5iKyzPh4K5KQbsEbGaNZGyeO7e/wVpkqlfcPgSjRRTA5gl4438sWWitVsHRwuNTsP5PEb7+dEmH8aTEx5K/uTOkedv3k/ocU4V2KDO2/L+gva6XcgsAzgOvwxEfxvAVAFFBijnkGxSwZUNT3tQCq8BSCafaEo6EwSSlW/h090sDlaY1WT6bX4khW75iEWtrgYbD3dz1Em6zRCeKSK1LL0aj01+dj8T76fcFuloQS4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1op/Xbcfsn+AoSwQXLIHD0bi0UQ2Bb/nWVdXpyC54BU=;
 b=fOCaZ1anQkldL4FVUxTR6EmDLapRWUacjSVycqTjgA1EUh3nZZsOCM5VFGsuDXKURjrlDUWBCWsUC1+JwmjAyvFxR8eY56zYZrUSZhg9vwC8QyloOJLZKgojco7r584liub7ilW7JKHwF5jx5daJuDMVqQmn/m7WjaChdMUXxqnWNLv4rgc5DgQ2TKMyqSP1rov60DG9DqU+lVR1N3EORx6e6YEWV+v48dTae1BS6JV1XDp/S4viWp2CyBxN+YGpy4XkbW4hV/LhpJbg2ID9997eeLmUmUhRKNbg+Zf0oQWHYH09uDh4vbwjJEZfpMymXPioPn5Phf4OT++hfelFGA==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 06:40:02 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 06:40:02 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Bastien Nocera <hadess@hadess.net>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
CC: Sherry Sun <sherry.sun@nxp.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>
Subject: [PATCH v3 1/2] Bluetooth: btnxpuart: Remove unneeded CONFIG_PM ifdef
Thread-Topic: [PATCH v3 1/2] Bluetooth: btnxpuart: Remove unneeded CONFIG_PM
 ifdef
Thread-Index: AQHcidea9gW6TldYDkmANQ9OqJeQww==
Date: Tue, 20 Jan 2026 06:40:02 +0000
Message-ID:
 <AS4PR04MB96924AB73D84DD58C691D937E789A@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20260119123537.2611794-1-hadess@hadess.net>
 <20260119123537.2611794-2-hadess@hadess.net>
In-Reply-To: <20260119123537.2611794-2-hadess@hadess.net>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|GV1PR04MB9103:EE_
x-ms-office365-filtering-correlation-id: e70b679d-c849-4563-21b9-08de57eebd4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?P+c6o+LRkHmlPoo4y1KFbaY8CesfU4Ak47kZieAZRbx1n6fELr5GEzgCRmTH?=
 =?us-ascii?Q?lK9dEgIVGAnTwr+WAoqBYBpdyBz1RY8KRK1aANDm+c82qja1NTqNuheoc78r?=
 =?us-ascii?Q?v1OH3MirEUo3+Ex6DHso2xlpCah4ozonlUL48DPjZhXJvmMQUEOgNB7pOGq0?=
 =?us-ascii?Q?JGCxzY8zwneRqU+EmdgkF1elhJlb5ldAN6b+wDDVxoNzgHu7kKR5ZeIy26E2?=
 =?us-ascii?Q?27WAfQcRPH+H2J27wF6qftH6WSRqt7INiwkUIvCDjrDkYOosZUvDJJ+m1c/g?=
 =?us-ascii?Q?rYO8CJvK1PeiksC3NrE9O8wXs4jhfnjERCJ7khK8bU79gNkAzhUUFut/3fSh?=
 =?us-ascii?Q?kOSjRg2XujgMkfY5m3b5ewi7tJhCCTd6pXe1BaPimZanLXQVSZMLRCOudD8Z?=
 =?us-ascii?Q?DaUlf9AZ+xrmGMZFGOdWy99Me1i6JlP8G3CCLhVIKeh7bMW5JdU/eqH23BsN?=
 =?us-ascii?Q?F6H0UGvBbf/OjUZHtoixs09VH+k2qUl7P1PBo0reRzfHPBs5+Z9+5R8Kd1cn?=
 =?us-ascii?Q?bZzR8ulEFudA5jhr8UMzxjOf8P9u/CdHzHFZ/tBw1forkSLjWJgE6yAX+B7e?=
 =?us-ascii?Q?dG+LtVUxtb4Fwhtf2coRBPOU9CE1APiKjGmUMKpKzdXnBDdhJMSqUn2AzF1q?=
 =?us-ascii?Q?/pckmlZdqeRmolAvBAcu8nVS8W3HCAOXhhy8kF2RjHLjdDwimwbAxVH0HG+e?=
 =?us-ascii?Q?fYKjGmW3YmMah8A+hhWJBP9PV3RfI85Q9/IWlqrYZKnqRq78V4oh6H3/1N1g?=
 =?us-ascii?Q?IpaliWRWJ6sOaTJruQb2OG0qDf6GraF14f5f9KQikqipqjkztkdP5O4znR6B?=
 =?us-ascii?Q?gDnzh3P8vscLsldx8tlL2UDxmw2RudBRTkV1cprsgsP9t7+h3mKAbuO0ELHI?=
 =?us-ascii?Q?nagaACfa9yq32grrWL2Mjr8m2CEVLMeuoS3ccSNxa+dgthyzgLjU1QCywAW+?=
 =?us-ascii?Q?wxkrHSGNT0W9pos5quShA2PdYS0U0a2kJebr9/rQaR0UXaCyUqPDB2gas/8P?=
 =?us-ascii?Q?mp1EDW9fwCh2NBZoolU6DQp8uCjFoF2hOtUWAGl8X6kxs8DN1h/qyJK6R208?=
 =?us-ascii?Q?k0HwP2vyrPkrm1qgEtLLFgqGplrsGWx050bSKRsbkERGrTyPSXNRlmN4rjfw?=
 =?us-ascii?Q?QHCBlbuUjx3D2oJH+euZmXaN2ZLAQMYMKJyWx7Acu/w6rKI7RUtG7E9UDkqT?=
 =?us-ascii?Q?514q8WYO/KD01LKIXIMNO/iOBQf3MLmstlAQ+bx5MB/TR1/nJR0jQ6UmQ+VF?=
 =?us-ascii?Q?cMcw6o3SprgEBbGj6FMugJ8cLNGGLwJHtklnY1fEt68ICr7ObiF/s7Y601IE?=
 =?us-ascii?Q?wLGFs6xL7o3PRzuAuxh7fp6sOU74x4n2/GM63z2KXbseeWXu7r4i7Jup1/VH?=
 =?us-ascii?Q?Dnn8JqcIpKODMZeI65c3JGA/3WhL2d1U0KXFe+xHngtbxyDZvXW2nTAsVqRW?=
 =?us-ascii?Q?kvf0Bc4aNKih/PCSilh5fAdMkpJoKVWM7eqmjrrnJfZzl3uIeWPISSJUEb5m?=
 =?us-ascii?Q?RV/RHvQSnKjpgPW60o9pZP0/CoogHugniTUtfoPzyD1wmOhmd7ieHNX03yWF?=
 =?us-ascii?Q?Rp8fti8IJS174khA7oRUozWreWJtUKk4AcUhB7RoBp1ydQVFv1jq3AlIV1CS?=
 =?us-ascii?Q?fpO9vAWHWFykn45G88BalQY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Rk5NYJCy5TSw/3o62YjFwb5ubw0lWPp+P0VxpUsFOUt29wSZQmq511dmlbDP?=
 =?us-ascii?Q?HoY+IIsQ7nP1IH9cUZOf6K8GP6Aei6uErij/pb7L0E92GuYoGRMpEzLdfCHV?=
 =?us-ascii?Q?KneEEWhOPnydZvHJ7+47DGzOLv019RtqwKH93A8k8bdagKw48o3b4Zrmzxx7?=
 =?us-ascii?Q?8/XCDASc/xfIBkUbhK1Zv3nElm4fmfum6Zp4GKG49f/minlG0vIfSbKPDWwN?=
 =?us-ascii?Q?U3gb+CMubNXYH5o6/DXtc/+kzVzsCHwmtaCOpyinCEHAqJV9jWQn/yP6Gjd8?=
 =?us-ascii?Q?u3JyTYiSDtBnFBZ/mhZA4Pxt48h2L1h/auEtereMpMWY4QY4sSjkJOQquRqz?=
 =?us-ascii?Q?MHxA1JHIxtmtnL/4OPq6PyoeuPPP/P33JJcNUjczDKDtYfyTuMwBIoLPdyBB?=
 =?us-ascii?Q?ENSJPiBvDoCTqJhKYfjyW6+yhZl0txQjY+3SozUMT5HWQhp0VVHj/I0N6meg?=
 =?us-ascii?Q?ElnlasKldCRKRSFwKCilsW85AUibOTD9NohhYQ0ir9CV+4nnUh9xbnMSzSxf?=
 =?us-ascii?Q?PVWpTBD2nXzzaXE/zaoJsODabSdvA+TXyktuj6na46R2UbDh0bTlUmygHUhB?=
 =?us-ascii?Q?7Yfv3dKXSr1/KIkoBYw29vOA8yKOWLekFRgBGxLb6um6J9GfJnMrCUk1KyZZ?=
 =?us-ascii?Q?c6xtW7v1nsmYzYpPoaZPJ/nM4kTqC9aY28APPw6NS6RrEkUPLa4yFURkkP7a?=
 =?us-ascii?Q?NjYnmzLdVrSkExo8Jky6K07eKyOc643Eyq54CDqx7AMrWVXRXM9yaxzM7Z19?=
 =?us-ascii?Q?q/GGU/FjJiDsk6lhrz4ODi/MIodFXi3tc/avdP4v1tsSXo7+5cpyhN+k/ezn?=
 =?us-ascii?Q?/A7ip1EePwL0oSyEqvvRQMuuZOG2qecbPYsTASQY1aSMTvE6TeMnhXVDThX8?=
 =?us-ascii?Q?wTX6zj7AvYnBrwy327U9gNDwH0l6cJ3Gvx1j/yIwldcc+1TzX4de+hKfhPbf?=
 =?us-ascii?Q?Mwi+hW0e2ntbRidaqw8D35Durpgp3pnmQ0ygwSLcKMRIKAe2xmQvP3BCCKD/?=
 =?us-ascii?Q?v5IBvOXAdTfK6j8BjJxs0x1ILK2fIIYF0FovReLN9uHixFhTa4dkhqDrYNA6?=
 =?us-ascii?Q?5bkEqSrfvElT/phckj8Go11dQ3OeAcRA4IootD4bPP0VYbXr8wHRdUG2vliq?=
 =?us-ascii?Q?C6ikmG8gJjebOd1NJJ2ZG0MkimZ5nlEgcTmhPcBxWwBtvZXapPnNmj6vCMeM?=
 =?us-ascii?Q?kpzTMNyFHZ01LEU6USPiVVVjcWcs80hWp0tQi3ao+H5f5fC4Mxdgj5JVO3me?=
 =?us-ascii?Q?NL4mHIhaYPTUuHc6kGA9LTpZVQhdo0ShGyEoleye9pp1XFiETRSLNn+kRky3?=
 =?us-ascii?Q?WuFfJsvvwWxk84pQQ+2MOEJqCAelAccswK1oAhF3B6chtXdAmxrko7DqxOB6?=
 =?us-ascii?Q?V6wphdixJrzJYQ6Ns/+zDivTpl2J96hjDmy0OEVQO1aSk9NaDjUHKcS6gtEh?=
 =?us-ascii?Q?F5ey5g143KtbauQhOZHsDBekttI0LwnfmJWZtXEoWr9nT7Z+KRL4rVujvCOJ?=
 =?us-ascii?Q?VcRaSx9EsyqJnYln/G0VNC0goC+AZ81Yvr6xYOTdVDtG1RzcEYn2o42cDUPz?=
 =?us-ascii?Q?sOurwMkGGkRUffy9jGKkf9ETUbVX3naMvjjvt0suQ1I+Jop7GOtTma69XhVO?=
 =?us-ascii?Q?WW0Ok8geqlAXxpm/YOg2RLNtY8z1P0o4/oD93VPWpmzlT/cMmzu+I3yPr3WR?=
 =?us-ascii?Q?IP0ZD74QvlQmHILAgPutbD+OySKLQGS/vSzeqwWK8jQmxQI74HBVd3L9Xhip?=
 =?us-ascii?Q?JSsO4kgD/A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e70b679d-c849-4563-21b9-08de57eebd4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 06:40:02.2170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /SXOHlt71CCHM2YE0SZS3qU8PMuRPuNvXdoBrBFW7fsvWrkj7oQSbQili1mWlXKDNh9Z4HtroAGxmZAXZMgXJAsspninnzPo++NGEovtVDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103

Hi Bastien,

Thank you for the patch. I am okay with this.

Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

Thanks,
Neeraj

> The functions are already disabled through the use of pm_ptr() when
> CONFIG_PM is disabled, and will be removed from the final linked code as
> not needed.
>=20
> This increases build coverage and allows to drop an #ifdef.
>=20
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>  drivers/bluetooth/btnxpuart.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 3b1e9224e965..e7036a48ce48 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1947,8 +1947,7 @@ static void nxp_serdev_remove(struct
> serdev_device *serdev)
>         hci_free_dev(hdev);
>  }
>=20
> -#ifdef CONFIG_PM_SLEEP
> -static int nxp_serdev_suspend(struct device *dev)
> +static int __maybe_unused nxp_serdev_suspend(struct device *dev)
>  {
>         struct btnxpuart_dev *nxpdev =3D dev_get_drvdata(dev);
>         struct ps_data *psdata =3D &nxpdev->psdata; @@ -1962,7 +1961,7 @@
> static int nxp_serdev_suspend(struct device *dev)
>         return 0;
>  }
>=20
> -static int nxp_serdev_resume(struct device *dev)
> +static int __maybe_unused nxp_serdev_resume(struct device *dev)
>  {
>         struct btnxpuart_dev *nxpdev =3D dev_get_drvdata(dev);
>         struct ps_data *psdata =3D &nxpdev->psdata; @@ -1975,7 +1974,6 @@
> static int nxp_serdev_resume(struct device *dev)
>         ps_control(psdata->hdev, PS_STATE_AWAKE);
>         return 0;
>  }
> -#endif
>=20
>  #ifdef CONFIG_DEV_COREDUMP
>  static void nxp_serdev_coredump(struct device *dev)
> --
> 2.52.0
>=20

