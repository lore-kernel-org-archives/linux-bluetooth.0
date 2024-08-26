Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020110.outbound.protection.outlook.com [52.101.193.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E15E18E057
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724695570; cv=fail; b=mcktTXPjgGUGD82DCcnXW39PAznecJs5v604L/qKy6lR9dzLp6x3yN9zcKkG7I06wgAzFB/bmu/vvEstY9kmdmCh0SR20a4ze/jxLzg0Jx4a+TOakXXI6HbbsuWVOobkHypzPiKzMS100pSm+UMrpf94zJN3qlHyy8cb/lqW690=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724695570; c=relaxed/simple;
	bh=zMnBUDysvhh67BMdE9TmB7ngYr3HpnrFrK6WWtVjIWg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QgNjyz/VJWdD27n0nOdjvnaxTugle84+h8qL8Ioe9ndYqbBkDeJ4cdoAV8X+YVo+874LdSKj3oHFcQ0sdVLHRufr8m7hIih5OmIO1gap1Kr0YgtA6esAa3DQG5ph2nxj/tB8RKLuxUuvHfnXjVDD7Unp3Mr2gULgWw30jBNhzpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=michaelburch.net; spf=pass smtp.mailfrom=michaelburch.net; dkim=pass (2048-bit key) header.d=michaelburch.net header.i=@michaelburch.net header.b=J9CLxWj5; arc=fail smtp.client-ip=52.101.193.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=michaelburch.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelburch.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michaelburch.net header.i=@michaelburch.net header.b="J9CLxWj5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQgriWpdZviSG8P6l77eblKeNI9oQbFpo8JSXu5BajC2kmVKowqV2nyffYsjpTuq+T8VHe8xqfC8w7l6iwoNRi7/Nsmr/P4UqYgxRV9fE1b0I7qVw6Acsxc4xFnHUZY9aQ/BQUR35HZYQjHUNQVYd0wks/Q4nm+mBq2t8EwI97qf4LyoB+GFf+1pvy0OFerlPPk/CvKbbJgoyue0qXORtnr7kNb6l8Awf+Bv8QnIFtwbEY/tnEcZxtm/uhyk/MNdLd3CWXPFSM9FQC2qFymar/VOvutRKdXjrc8rizRhCgGR/729LUFcV51CL473QBoXn69iR03c4v43hK0lXeG1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMnBUDysvhh67BMdE9TmB7ngYr3HpnrFrK6WWtVjIWg=;
 b=M9NwRkg1fqlrG1iO15mDMCCWjVRqXWEMK7J1pHuRCKS1kTc6rklf4A8cSQz+/N6ZM5KYoCM74hxjEVFXh5KCH+yEK9CMT3T1WOXyrN/F4rDAdUbkKyM+Xf+G58+EPGQ10PHmGm07sI3PF5go8pVMRLdshsb+yNSpHjDNWFI+9uj4FpljlCsNzokqz3nhIsvIlkFG/JY5XOkQ5GMpJPhU6EhV9Zisu230TtgRwkev8uJQBeFiCy23EP6pjAQjP4lruM4U9d3nDdN+1YoPsuR7FTlFIpzGVRWZkm6Zdeyld9X13y7l2OLNNWTyQRgwe2cXPPZcFbGkHBsY8IvDkv9ZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=michaelburch.net; dmarc=pass action=none
 header.from=michaelburch.net; dkim=pass header.d=michaelburch.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michaelburch.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMnBUDysvhh67BMdE9TmB7ngYr3HpnrFrK6WWtVjIWg=;
 b=J9CLxWj5SmJcG3aTjlKukjRrGpLE4+NOE4tJs3TeMg5FD9kvXSAWXvC5eAb07KfQ8X+OcTCUcOae3HbtXa6HLJiSHHZndpMPIkmXaSXdjkXFSOxBsWLV/sHlMcqIzO3snBP3Fy9yJdNpPb+ihVlpFqDXOf39+BRB8sF7W8yMLRaGj6++SDVWWB88TjQ6epJfxv4Df6P1Yb7vwvYNWEyKEwAmN8aTZ4kMSI0jD7S0mxPW4K6E8YsWfXtLGgXg+xhpAQtOoSo3RhsUgzIiNCATQt2Gq0qQCteiIpu6ePNlcTVVorI1aTBF+KOSmlSsQgHag+9RbdUSnqsnSH4mPlFIsA==
Received: from SN6PR01MB5070.prod.exchangelabs.com (2603:10b6:805:b7::28) by
 BN0PR01MB7072.prod.exchangelabs.com (2603:10b6:408:16a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Mon, 26 Aug 2024 18:06:06 +0000
Received: from SN6PR01MB5070.prod.exchangelabs.com
 ([fe80::8e42:e034:6306:aaf9]) by SN6PR01MB5070.prod.exchangelabs.com
 ([fe80::8e42:e034:6306:aaf9%5]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 18:06:06 +0000
From: Michael Burch <me@michaelburch.net>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Bluetooth: btusb: Add USB HW IDs for MT7925
Thread-Topic: Bluetooth: btusb: Add USB HW IDs for MT7925
Thread-Index: AQHa994+RkzJ3XaFJkOJ7P2U+fb5DA==
Date: Mon, 26 Aug 2024 18:06:06 +0000
Message-ID:
 <SN6PR01MB50705B846790BE05B92FDE7CA58B2@SN6PR01MB5070.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=michaelburch.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR01MB5070:EE_|BN0PR01MB7072:EE_
x-ms-office365-filtering-correlation-id: 01dab296-b5eb-4f03-a25b-08dcc5f9c165
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?oMoOIQxi++W7caT+zpOftEeXshxeImcZnUm1UZRU09yioX1twlPe/ba6y3?=
 =?iso-8859-1?Q?96rEUlV3PzNuOaQ/TAeTOmgqgp7JOzPlIAN2s+hdJw2AbS//V4otJXlHgu?=
 =?iso-8859-1?Q?ijBsswTJupS8ISZB/ogN+Ky7+K79MVYFpIvx0LUCP7Rttm/R9utXwFVGBQ?=
 =?iso-8859-1?Q?7rNrjQVSMN8RBqYAUbw/gyGICGCgRVBuRIkNwzRV3ka/JQ6DflszxgaJD/?=
 =?iso-8859-1?Q?6ovqSgMuphdVuU5li3AGQBUvPjYOIwniObl3MjjRQ+jipFVM9YcopIrbM/?=
 =?iso-8859-1?Q?Fvb5eHWGdcA0YXzU9Rb+WpPd5oYY6bjBJlAiA+ekeJIWJUOj6t+eV0Ebo0?=
 =?iso-8859-1?Q?aKykZPIWTpebazLMGVaO28reQvJMp4A3AamVSID7a+1ZPs8YzeO9//SPMe?=
 =?iso-8859-1?Q?ou0HNKqa9k0CcTt/l07GqrtLrpYbt7KCSWmTgeMWk40dvPEgcH3fIWL43U?=
 =?iso-8859-1?Q?So2qfIz2ci0W7jwN22FFD2RPVwmdW/yzi1lzjBWsW4kGFlgj2d4uOPkP5H?=
 =?iso-8859-1?Q?kmbIkV9hEV8+e3Oe4hNXvv0QEhMX1pCxaer5DFJGqgSWHayRcPeubcOy9z?=
 =?iso-8859-1?Q?2PJvd4XGLibeDhpzGniHwQjUxOVNzZfPyg3K0CvlX9AXU8bG/0lzQMUbq7?=
 =?iso-8859-1?Q?DNfb4X2VtOKjwIyAtEFms0QoHrUtitB2/iKElyeZD+6wFDXSksF+YyOQot?=
 =?iso-8859-1?Q?wIwrFgtQmooNspnqKSlvnJcf8toh91l1Mhbbc8+d1hTEGCLPE75j65enHj?=
 =?iso-8859-1?Q?xED0zdqwIxmrSoPPSWqcIQ+InjIej8LCHji5b0ieNIJ6gkLM2YDpgh+s5M?=
 =?iso-8859-1?Q?mUpACSuB9LN7Ig0RC00oI4dm5MbIIXZ9PABCuavp5AkQSBfE882OmFYGKI?=
 =?iso-8859-1?Q?YXUNszMfelhVljTK84eIxX4Hkod94LZ1Am2JCTHgB3woxBm9nens+HmUHf?=
 =?iso-8859-1?Q?m758jn2imlMzlqLWzRd2nb6YWwmo4fbMaOl5zhXkX42SipJrQ0/BiY1lAP?=
 =?iso-8859-1?Q?yeVAyBtM/G067tT/rrPTI/IofViU0vwkXNycZD8vh9+U4cbeg36svXgiuV?=
 =?iso-8859-1?Q?IGJZNA8ro2AJhjVJWIiltDs3Z2iHtMjgeDyFL4EyuY0XVKDGwTwKgiepH7?=
 =?iso-8859-1?Q?LJY2I7QtmzAZRw7C0Lbpy7+nqJnt62Mtlfyt6md9oHp/Lj/BQJ7c0OD/IF?=
 =?iso-8859-1?Q?/ZKxWhncUDebDRVKfkhXqLzXNplZfnH4YTgHg2+NFCuI/gv9edMQZUPTej?=
 =?iso-8859-1?Q?f33BpTSYOJ87wpINHBGuTwctmzZzBWHlXNEYALV2C07ggAFoMJT4BKFmVy?=
 =?iso-8859-1?Q?PpRJYo3vvB1eI6DWXe495xfnlSDXqRoHaXJ9HNhD899KHepiG47Qyi0ixy?=
 =?iso-8859-1?Q?BP39bv/jgXrRgIrCqkqXpn0z6IlAJyzPNsnclF2pSPr1+YOzCIA4mxD1bg?=
 =?iso-8859-1?Q?DJAXgEaip3RIWpytfVhZaVmShcuTNqO1r0Iafg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5070.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?QjmTDvj8s60SlxtuKAZmtWWo7nqhCtImG5ZBtURpGYaoxF6sPFaQpWVXYL?=
 =?iso-8859-1?Q?G5b3+7/NutPP9pB82Fui9xmj/CPKgzLULaKbOnVlo+hblFCNCJI8F6dYXV?=
 =?iso-8859-1?Q?xtmJnETOgi01904DTH3ElFQuVwtGen+FFdVlo8HuZ54J/GhWRmNKRmg2cE?=
 =?iso-8859-1?Q?rK0T40ZDtgQbSHMMsUxBVOYAnPAZIVp4wfJi5jIX3dp0POXxLZp21LV8E/?=
 =?iso-8859-1?Q?NR/mYzXmIIWVpazI5uxkvzGV7a2Abo5fpemGnkS6PEMpUN0T9SQGbA025x?=
 =?iso-8859-1?Q?AErRskWHxXIOgiR59J+osGknNaV3bugHoknSh29mypj5Q6hHjG8qjZMsAe?=
 =?iso-8859-1?Q?FXLviKH8XlEA9oFezWH9wBDtRa9omL6T4vnpHffXN2laDmS1EP4cn9CwzX?=
 =?iso-8859-1?Q?PIMyEuhYOWSnp9U1h25ThUNLbh3vFos47R6ZK0d2AN6lIv8fP0IQtENV60?=
 =?iso-8859-1?Q?eG40RjShSdelV27X8YjOWqQQys9UUB4NWuM36D1xTRlF/Av11lFA7DxwZr?=
 =?iso-8859-1?Q?jR7zY+m5rjduEQtnhtWvOPEMIBYNymqt38hvKjkTivmH2UbQwqWu2svSaT?=
 =?iso-8859-1?Q?VvbLNRSiAx7sGaMXCudTniRDCc/G+DrpHe+RKDuTRHWqbMCLaOBrdDq43s?=
 =?iso-8859-1?Q?mCxQsSDo81F8GE4s8/3oGW2hcDHPRgWeAh7s87PdeEbmhHWctxOORpNRNJ?=
 =?iso-8859-1?Q?M3PDT28Kciooz8aPqNQ/k5mBgc78dhjEYHPES92Uywsh6tJFwpR/X3qQGF?=
 =?iso-8859-1?Q?y+y+DGQmilz51ztaKSciE9TKXsltLmxB4KEOJ9x+niMPdNIK3op6D1NxNz?=
 =?iso-8859-1?Q?olwkYjVfTCo6KU6EpKMcDQfk+7/uZ7rTZgdAIi4EtX2K1Zy/O4iMuV1R3Q?=
 =?iso-8859-1?Q?c1ho68UjSokRBDiasd0p8y9gMWpf6F3jH9M+IzZw/DifDUDGQJRlY8aWaR?=
 =?iso-8859-1?Q?aii5uqyeXj/PYz6rijFz0F6/Ut80XSSXkjbrBQp3AhQtcx+w7s1OJkzqqw?=
 =?iso-8859-1?Q?Mb49YPC2XTMEdnjx2JcbpJEv3ux3wMTkPwC84wEie15tsmFJKwmzrZ1b03?=
 =?iso-8859-1?Q?85pi90TA/Hz1F7KltrEpsU0QUhV/ktcU+04zK6z7TACh4EUj9eLWiWdhrW?=
 =?iso-8859-1?Q?D5RsT9T1dv/wmlKXQnaU2NASqytkeyEPd6X0eT3qq74I7OhJnba0Yuwnoh?=
 =?iso-8859-1?Q?b/IGcyuLo/JA2I6GibJ9BuMw258iGOMfN6jltCNZVAQaPa8D/+jrhk/Nzw?=
 =?iso-8859-1?Q?b+tPSCT4u7CNzRTPu8m9+DnUTjHog7/8qF+rgbim12B/BexFqrAJYfISsE?=
 =?iso-8859-1?Q?sHnbFOCrSYUr/D6YEwyanG3unyBlEXxxzhlCIrDTt0Xx0Yj1YTloBA86P0?=
 =?iso-8859-1?Q?mup8/UL+eWqeryUNigX5QKM6zak/ax8HBD1JRkGu3i4+/c7/GwI+H40cY+?=
 =?iso-8859-1?Q?yCCsZqhPERfoQd4LfqNprLgy/4W6RTgIXyjW3hruX7pynK4FSlq/Wp/Cu0?=
 =?iso-8859-1?Q?PTSqeWVJJs2AMeCCSGgAG0iFA40t7NQk4s63+G27uDImahLa/T1zSXN7gZ?=
 =?iso-8859-1?Q?we53U8Pubxfds32OuKYl4WXx8XGUb66f3W/CQo8dhmrOgMxpByvA3/sl4C?=
 =?iso-8859-1?Q?hI6w7mE/kpDeA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: michaelburch.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5070.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01dab296-b5eb-4f03-a25b-08dcc5f9c165
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 18:06:06.1875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8256b244-08e6-4df2-b146-877069d9ce10
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52UA1liDOkopsh/BylzqUCFS3VjRaG1tN9lin5LxtkB5MJlZRxelbj0qY771kC3GwT+A7oyvlT3w1jHg0w24VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7072

Add HW IDs for wireless module specific to ASUS=0A=
notebook model to ensure proper recognition and functionality.=0A=
These HW IDs are extracted from Windows driver inf file.=0A=
=0A=
Signed-off-by: Michael Burch <me@michaelburch.net>=0A=
---=0A=
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c=0A=
index 51d9d4532dda..d712f5acc338 100644=0A=
--- a/drivers/bluetooth/btusb.c=0A=
+++ b/drivers/bluetooth/btusb.c=0A=
@@ -690,6 +690,12 @@ static const struct usb_device_id quirks_table[] =3D {=
=0A=
 =A0 =A0{ USB_DEVICE(0x0489, 0xe113), .driver_info =3D BTUSB_MEDIATEK |=0A=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BTUSB_WIDEBAND_SPE=
ECH |=0A=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BTUSB_VALID_LE_STA=
TES },=0A=
+ =A0 { USB_DEVICE(0x0489, 0xe118), .driver_info =3D BTUSB_MEDIATEK |=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BTUSB_WIDEBAND_SPE=
ECH |=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BTUSB_VALID_LE_STA=
TES },=0A=
+ =A0 { USB_DEVICE(0x0489, 0xe11e), .driver_info =3D BTUSB_MEDIATEK |=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BTUSB_WIDEBAND_SPE=
ECH |=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BTUSB_VALID_LE_STA=
TES },=0A=
 =A0 =A0{ USB_DEVICE(0x13d3, 0x3602), .driver_info =3D BTUSB_MEDIATEK |=0A=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BTUSB_WIDEBAND_SPE=
ECH |=0A=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BTUSB_VALID_LE_STA=
TES },=0A=
=0A=
