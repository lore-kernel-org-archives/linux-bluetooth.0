Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC90713FEA;
	Fri, 17 May 2024 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715930282; cv=fail; b=CT0X+t7IulHmZj+3Peh95VarB0YYkeJ/+z4zzJC4EEoYONJZp9qrH3QG8b7VgDpU09p78YvwxLxDJJBJ/gqU41bYH6wTW0HChdtxUMCuspvZwKEoMCvKpZlSP75SYdc/5CRFvJmz4y6C615FBl+uZ1ITsgc25C3VZXugye0trY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715930282; c=relaxed/simple;
	bh=sWA6WtHie78vxc8MkQ7yNGXAsHVw4OzhBqRc3VRtCMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tq9+gr0UjQ57fPM6XEBFnqgPLRde0wRm/h9FfFEMvafFw4YndaFJqoLiUlySu7pNvZZSgqziS/mpwucLZgnVrmgO5DX02h/IvPfdH22Qt3jhJgvmFd2yXdG5VHHtAEYt0Tev2PttKR4Nq3koYgAGSBnropC3LBXE5xKw++yQ01o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=F9wwqyZ0; arc=fail smtp.client-ip=40.107.8.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F9wwqyZ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4bjdtnv/zncjqnQU7ULnYnP1h8XKsTaGjMudz4F3g+WMuzKgkHLmsTXG8zNVEK/a5bjmwQIuOIRofUatrOQMPXczzZ+o6OB8km2rPYX0BWjCRspwo749+GXuw1NurewHGp3nwxOsQk9ZGq3RYYmI0/nb/Esu4b1u6usmx7PtiXZIl4S9Hlh6sLSLAo8eZ6FE7T9REtQ4XwslGnEjyzADwbNWVRXUUjmzkcnNwEnzOUUobMqWFEfYK0LyzqKKzP52TmjxoqBsAGvyuxIW4S2R8iKfwPzf383AvL88jfUKrppc3JSQkMJwarZ41AsBmg9nS6Z+q8qNzqj691+FDSw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=816qFoygc9jWXZSTJRYpq1fAJ+MBxgHnr8GrJevlypI=;
 b=iSBZaBAVpFyfd8Df9PSWgV0yR/l3L89KMks2OMhSI1nL6QwECa7CHMyMQuxdadTBTEVNmS6hvuADh0S/ZS2bQr5ZyZ72MedfmChnwjFAf1TIv8lAQOWm5GwDtu6couOXFV9a5T0pNiAjXonV5GFplEh6vd79kGYNXiMV/a6Q21amzlOXNDhlJ0ajf3SzKMb1Hu48+fyQMOZBHp//NSjFqyyeqgkie3y0jTt0tC6vK5oDE2SYqVt6WyoJ+y01J+YBWrsEFzzhNm2dtfDrPlNfbx1cTFydtuyLBsEG9QlAOUQgfNw2dULLICYrH3MbEME32J0Qkatd04fMERKmY6WFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=816qFoygc9jWXZSTJRYpq1fAJ+MBxgHnr8GrJevlypI=;
 b=F9wwqyZ0Oq4M3IBvS09Y4zsunYzLbBBvNXnidQZw4PxhJaNdWFnMubscVFtD8zxMla0lkDo8g6VlVc5tPg3Axfaytiadkfdr3mJEHGxX7Eo69YnCofqk1e1IEXQL+lZPtSqVjp29dsjjP9DSXBQLWq+VyGvPHjtUQauqDdEN/bI=
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PR3PR04MB7419.eurprd04.prod.outlook.com (2603:10a6:102:80::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 07:17:56 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::e60b:413c:25cd:c03b]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::e60b:413c:25cd:c03b%5]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 07:17:56 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Amitkumar
 Karwar <amitkumar.karwar@nxp.com>, Rohit Fule <rohit.fule@nxp.com>, Sherry
 Sun <sherry.sun@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>, Bough Chen
	<haibo.chen@nxp.com>, LnxRevLi <LnxRevLi@nxp.com>
Subject: RE: [PATCH v2] Bluetooth: btnxpuart: Enable Power Save feature on
 startup
Thread-Topic: [PATCH v2] Bluetooth: btnxpuart: Enable Power Save feature on
 startup
Thread-Index: AQHapd3Ck6iBL6ukvEC45Bem6IEoArGbCLQQ
Date: Fri, 17 May 2024 07:17:56 +0000
Message-ID:
 <AS4PR04MB96921A132C1F767792609323E7EE2@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20240514090258.1507934-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20240514090258.1507934-1-neeraj.sanjaykale@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|PR3PR04MB7419:EE_
x-ms-office365-filtering-correlation-id: 99069223-3339-4b6e-aed1-08dc76417991
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SRyy+pOTOUB4lrRNbH/vDVbuzXNmt0IMYZg3iJ7iU+C+OMSBIB7T2hzjkXu2?=
 =?us-ascii?Q?QBbK76Uaw3uthecr+BwtokIn9MyyrZyeHHLAG84YFC/tOETRDkGHRrGaUERC?=
 =?us-ascii?Q?Att0AUYFunj3uN4PmEn8iW7GbL2ZQLOcBJBN/dmSmjLzbxXqKuujtnTpYxxS?=
 =?us-ascii?Q?eHolcclwnJJEF779Q67m1KfFgEo3wQsW0X18krT+M8sJ5hoIhwIfjQpgTIOm?=
 =?us-ascii?Q?qKJ/nsJYI2xjnOffVA3Z7u6omV4MquCoV7K+5WPpWBpUaMV3bS91B/qL3yD3?=
 =?us-ascii?Q?swTBzp5egtlxMk08sBHsJX0CRmybNuYqAVwPLjzcHLWWx3nYuwHKn3L8K65D?=
 =?us-ascii?Q?AkC9wx+xyI+AYo/p2ssKg4G4o5hsxVajWbyaJ7IFaOE5LL8gCqklnZ2AmS/D?=
 =?us-ascii?Q?yRcObEHA1JKDYpnv5ce8sWeAJNA36Fg0Z5XtZxeX0xYQi1fzpWYQJ/Is0nAD?=
 =?us-ascii?Q?kPVFO9Y4SadvaDf8eT46ujNr6oXNcoK8O8UF9P4KsAHlJNs0g2JZr5l/86dP?=
 =?us-ascii?Q?elA8CIZvuaCL1bLYFp5DZCoFTbXKYsthTHcpccK1yaG9WNDMEqSMMn6CpL9g?=
 =?us-ascii?Q?mBNIS32vl6IzYXyw6yr7cYvQLVspDTXY2qnZxzXTsfJUzOJ6wIsUigHq967X?=
 =?us-ascii?Q?uxekGJky/FzXxHuTGDh35HmiA8r7tZ2IsxJSYOKb8Xg0EVRnzLE7SAggWJgs?=
 =?us-ascii?Q?++MD5Gtu0wNJOsakaJ6caHnREWxwuqjklnn7vT4gGED09eRIgVdHQVdvRSIq?=
 =?us-ascii?Q?63+iijRARIVrVfIAGDQey1Z0bDwWgvG57K2zPpP7E98LzWVpkp5U8IHPMNoA?=
 =?us-ascii?Q?cAVUp/D6yPQ7GT0vpV8LoyJNkQ40IFMs/hkMf7cY+H65/SFhHpH3ljW63UUp?=
 =?us-ascii?Q?724X/QX/hw+9ViBGNAUocU6Ve8M60s1UzTRYbYSVXGhabWS3TAAJYZIgAEwh?=
 =?us-ascii?Q?H30vDxN8aQ1MrWt8bgVzEmz9q0anK3AJ0v0psRNSlSs+nrLShmAhMWKuLHq3?=
 =?us-ascii?Q?VQuNBivqZiOqFNXBnp9hdJXkXwcK4+uIeu+b6sVqBB4TirunF/r/xAeeoHiP?=
 =?us-ascii?Q?CgPQZLx7RvxtW8PvPQO5sElCES1YfT5P55aTmzQU3sXb3vURU0iyDFem8XvX?=
 =?us-ascii?Q?BONahbhKioy3jJQr9MOrkiBSCGb0pGZ6JxEjCr0a64QPWhVQC6OEn6d+b0FU?=
 =?us-ascii?Q?1ZfBNpLmUEN87yfAK012hjLEJjzu/ELt7akYMHrx2CwIKUEGsFBGxCGRKKb7?=
 =?us-ascii?Q?3+qeYy8ueFEk9SMlsDn3a/VRod89hQushWErVwCQBW2/pQIWwrJ0ib3CFB+2?=
 =?us-ascii?Q?PXtGiSwaUdPWwAlXe0dS39Ywdfrrvw5IbeqY38YsuHwbyw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d0ZJ+k3yJRIofoBHl8ZEax21Yiz16P8ssvB0+MurSDqAuznQQOV/nj1/K1Ry?=
 =?us-ascii?Q?vr1W7Cb3Atp/1BDpuzGdTyP/kIXwip+N3fqLarOD48tYyMQbhkagquwXXCMW?=
 =?us-ascii?Q?keJ9L7g12/4XrmCcPV776U7niaFVmCNuEaYama/uesPgeMpfQQVosw6yBzyv?=
 =?us-ascii?Q?kZwwnCe960fGnZ9JuT26WX+8by7d1VEAIQz2aq2OgOgj7cTJ4yCerZ2mahzY?=
 =?us-ascii?Q?YAJR6dmhZVGTV59qZq3grqlLrZ1xuwqjpBNNMPdT7XMhkxH6tP1HyiCV21Os?=
 =?us-ascii?Q?M69gFYGhb95YWiM6vh3pnoZiJNqgbwzBd8vRgWra/zM0jtmLsuIHtmHPSIp5?=
 =?us-ascii?Q?HTB4q/dCwDKWEg9iKDdxu4FBkjiZJYSZn0rXURZlHtVXll6hc24DLAKlgbTo?=
 =?us-ascii?Q?9oWtsNOzzf1Nv07QuSIxKvN4lvxYk/zw3gqE+6DMdt8obU8w33jVTrRkAmUq?=
 =?us-ascii?Q?NHobOBC6hmyaFErNlPxp+j59G+wJ/EM1v3MdKAOYQGsSb9FHhwqj2bLniwBt?=
 =?us-ascii?Q?r0vkRvcvaqJwkGEhfKU4QwamLeBDoQUgfRGyN7NLkbdfUk7Nip+JXTi5ivr6?=
 =?us-ascii?Q?MONYAK2LxWIadb/Qfb4BTH+UFxQ/Xl/1wbibgpnXIbFsnHgGJzDFpSn8Q9y+?=
 =?us-ascii?Q?YhsVM20faV2qQ+RYH/FtaCo4+97D8JCcEhjjXHpZ+q8qrdriBIbgrXSdjzmm?=
 =?us-ascii?Q?E4bepQIBwY0q4JFMHElW5aelQnB57OoHA/oATrka+fgGdJWxBrKk36Gq04EM?=
 =?us-ascii?Q?IVJOU0ORlYEIk774j3vVZPXm1R49eorkY/oeH6Hd7ZoZfEUlXue7+MK2ohgz?=
 =?us-ascii?Q?fLFet95ZpZAD6SwT71fGuHGyQ94O001J1/Swvo2Kz+pnGJj3x9mZrYxbAh7t?=
 =?us-ascii?Q?Bk94TOCo+G9PzqOSIcFU+RQQcjczBYdszECJBxYd61s8JrQ7O3luO74+GclH?=
 =?us-ascii?Q?VwxV+QSVdpJp+uIMJzC32dzjmbehoiWpwOq19nseSZjOa88t+lPRVwKw3E/z?=
 =?us-ascii?Q?I0bMQ+NwXvvS3ipi/y0VXIcIa6uQVvUB9oH/xUkFSTtbXfP2tjxaBMdepTcP?=
 =?us-ascii?Q?QU58s32TsBoa6UrionYyz6MHeMHWXXmNr1xP7TPFkavYhxJXaqM3WIXJUNrO?=
 =?us-ascii?Q?I2PyGmHJZtBwgaM19K12QdeNmc+6uIETiF2e/zJZ/WCqmpfcDZ2OHLovUBTY?=
 =?us-ascii?Q?fHBSLazK8G+j+24SrbR/CsOM6DDBTorPNdV40JInsCYGBt1sfgwzKBjpvbdw?=
 =?us-ascii?Q?zpkfiW/5JzeLxnoPWv8Qv8R9V27V0BjVdvHUk7MZS8UcT9Hmbo+buJswK1GI?=
 =?us-ascii?Q?T3pZbnqyuyBJdfKen/j89oxSimldMjPd25iK6AH3yXXl8ryOVL/oUT2kX9I4?=
 =?us-ascii?Q?PELMlomvCnNnV8txpSihNTgrhQYVx9hu0jqFwds3ZhuXNR7t7mK5C0AlP4/z?=
 =?us-ascii?Q?Xx5CMgcQWgc+usGFqNN7fZGKIQDfmPm/656/Es7pHMhG18Hh9YDc9J6ir4qn?=
 =?us-ascii?Q?VsoV7iwNr7Hz70P8lFu/sRKi1/kzX+g62qcAOFZAOyeXwYesUsf7bVBt23Kz?=
 =?us-ascii?Q?IAG9rwqa/eMM/9ij5E2HE3sU/PRQiTyZHEegyodW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 99069223-3339-4b6e-aed1-08dc76417991
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 07:17:56.3813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: COpHj45/lnmi6N187lS14XNnR9wqhYTiyjDXboGDH45/g0UHLjinC4AXjMJeTdTiPUksaTwmo9rZLaeQQj6s9eacy1K/HnksJyFmTIX5lHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7419

Hi Luiz,

If no further reviews, can we merge this?

Thanks,
Neeraj

=20
> This sets the default power save mode setting to enabled.
>=20
> The power save feature is now stable and stress test issues, such as the =
TX
> timeout error, have been resolved.
> commit c7ee0bc8db32 ("Bluetooth: btnxpuart: Resolve TX timeout error in
> power save stress test")
>=20
> With this setting, the driver will send the vendor command to FW at start=
up,
> to enable power save feature.
>=20
> User can disable this feature using the following vendor command:
> hcitool cmd 3f 23 03 00 00 (HCI_NXP_AUTO_SLEEP_MODE)
>=20
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> v2: Corrected subject line. Added commit reference. (Paul Menzel)
> drivers/bluetooth/btnxpuart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 7f88b6f52f26..42e929f0d141 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -281,7 +281,7 @@ static u8 crc8_table[CRC8_TABLE_SIZE];
>=20
>  /* Default configurations */
>  #define DEFAULT_H2C_WAKEUP_MODE	WAKEUP_METHOD_BREAK
> -#define DEFAULT_PS_MODE		PS_MODE_DISABLE
> +#define DEFAULT_PS_MODE		PS_MODE_ENABLE
>  #define FW_INIT_BAUDRATE	HCI_NXP_PRI_BAUDRATE
>=20
>  static struct sk_buff *nxp_drv_send_cmd(struct hci_dev *hdev, u16 opcode=
,
> --
> 2.34.1

