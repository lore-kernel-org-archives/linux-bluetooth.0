Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020113.outbound.protection.outlook.com [52.101.85.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB363194AEF
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 20:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704171; cv=fail; b=s13Hh4qUF269r8kUQJE3VFwqf76Jv3HouDSakl0UYVeHXfl0rf2+RZJRqUhDhdx61lWFEVr1/aNo6dXQRyQHJgKC35pl2pa/gXQ3A0stKcu3cpldU8eiTmWk3kqezwJmfFusWV0oLazqYPnRRiyKwWXBPiJoHZN6xyt9skpBhAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704171; c=relaxed/simple;
	bh=86llNOXw/0jjkZ/5e26z9A6PW1jZuUsb5pU73hDXlYM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VoJTdALr4iASiZoAmGtzYNtHopdoS/wbw6yYWUFAneI6OcLoTb51kSyUaZQBi2pMQm8xJaefSuec5q8+BfoDDI/gUgqn7A2Kpp5f+nbWN6yAWOlXrg+asqUQrlC0x05WcfXspQeDHI0sKID8f+q52aQ7UmBp+mfAA/S7fUIfRDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=michaelburch.net; spf=pass smtp.mailfrom=michaelburch.net; dkim=pass (2048-bit key) header.d=michaelburch.net header.i=@michaelburch.net header.b=whlH1ljX; arc=fail smtp.client-ip=52.101.85.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=michaelburch.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelburch.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michaelburch.net header.i=@michaelburch.net header.b="whlH1ljX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lM4XruLKdskN4ZTG9PdUKlXlSDU+HP75P0uRjHBG1X4m0jTa9eyGYno1JLciegs270LVkwmbY2ceuq3DHMj5PXUVIdFSt0sFx910BfAVGzV5pi+5A+7ff4S2v3l+TI4OWDQMTiGqAqFBlzKFDfwRuY6w0808BjM9L+wIL9G7vAJxYLmB4ZtNP6llVcNVC9muDMyhaXVVh+Xq0XJzs28yQdQX7vWGwJp2GNWRB9nUxRHjpucVxVlpEkjSwFhQVxO7FEF94PNSCpauiHYeL+wRHSEGhkO5Ap57IY96QaavWSZIjpDUBjIL2PtBzHGcWAtbWRX/xwy4xcCC9s+Zbkdvqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86llNOXw/0jjkZ/5e26z9A6PW1jZuUsb5pU73hDXlYM=;
 b=emfWw0UAVaKYRI04BSv+pli4mX2VBLBN4f3cgyO3Gj9GWcAyx+H4GuKVhBzLL5XXj4iJavm3dFYInsMAktwanluPHohApsyaW/y1xxzAOLs+r8oPXeLDeFcHVdRY3yi2H0fBCjCcxq9SupErkcCc3Uj48pOviywGCknQhlkCzwemLsjORA43Z6of0aMBqoTnB5zWcXkUjzh5mkalAfRLsJQG+yMDrtpun4zu8oBPYY9b4jav5sVxIORg0lPOTSTrDbDrxQk4vVZVgEbq6OWuSRmDAPLnHk4uA7eOov25ps+vWwB/HvEBY3dCLyJoKRjcDwT/aqcaZgD4JvBRkZvZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=michaelburch.net; dmarc=pass action=none
 header.from=michaelburch.net; dkim=pass header.d=michaelburch.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michaelburch.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86llNOXw/0jjkZ/5e26z9A6PW1jZuUsb5pU73hDXlYM=;
 b=whlH1ljXnSZ1LhV6acjo+oQXE/wJRCfc95Oubuj1CNr3F59+vJxft0t3KNYR+UPOhxXfvocGRRn4pz5L/pSm4KgeOElby9aDNK+yxvQb8xp1NtbBhWUBsOFF1iSYYridpSGLEeILTtDKGJ7DsO2t5UDRKxVZH52eMUqrrpbcOEvtVGXVRf0wVtLyJGbErLmKw3KHDT2R5bATQJgEHgcWtXczFxgnZ9+OFZti8Ywz/7kdLRXkaTo38W8mS0NGhddHAsF2dsXiGhR7eUsovjwK5L7Y4lFeMgRRyiLGObeNBdmHXPrm8YFTetepgHCfqQpjR0fDFtr+qGpXCthSgk1hgQ==
Received: from SN6PR01MB5070.prod.exchangelabs.com (2603:10b6:805:b7::28) by
 CO1PR01MB6600.prod.exchangelabs.com (2603:10b6:303:da::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.24; Mon, 26 Aug 2024 20:29:26 +0000
Received: from SN6PR01MB5070.prod.exchangelabs.com
 ([fe80::8e42:e034:6306:aaf9]) by SN6PR01MB5070.prod.exchangelabs.com
 ([fe80::8e42:e034:6306:aaf9%5]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 20:29:25 +0000
From: Michael Burch <me@michaelburch.net>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Jiande Lu <jiande.lu@mediatek.com>
Subject: [PATCH v2] Bluetooth: btusb: Add USB HW IDs for MT7925
Thread-Topic: [PATCH v2] Bluetooth: btusb: Add USB HW IDs for MT7925
Thread-Index: AQHa9+lrBs4Ia4PG6U6baP7NeM49Ng==
Date: Mon, 26 Aug 2024 20:29:25 +0000
Message-ID:
 <SN6PR01MB5070DEB84C56913B4179EA0CA58B2@SN6PR01MB5070.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=michaelburch.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR01MB5070:EE_|CO1PR01MB6600:EE_
x-ms-office365-filtering-correlation-id: 4f63af9f-1022-495e-9339-08dcc60dc714
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ZLDRlkDHHBmDj2srMnxXcJdOZM/r9HodMgbroC+hyqckEdIVoVxUtsG/GG?=
 =?iso-8859-1?Q?tKp0IafJNrL5Y0hk36oK379Whj/yuQiYghJu7VYR/CzhNpVRoiI8/IQz0t?=
 =?iso-8859-1?Q?RwTgECukvjDWip42k8dG+VHduvnLcQFBVQ/tkDkc/JRDJyAWJ7jU5DL/0s?=
 =?iso-8859-1?Q?NnctuZjP61XlP+mafHQupdu51WdI9UWIeWTY8H/Ma9f5mHZteFRZr9vevE?=
 =?iso-8859-1?Q?gKq5KjL+eV6js0rtRd79P3VWXMGNUKE98UVKK+BEwAX0yPcpyxr3py5bbH?=
 =?iso-8859-1?Q?Kh2hvC2lPviLSW+J3xYeWvTf0Ds/CBk0WRLaNgAVCQDCD5oAMHmZAww2w2?=
 =?iso-8859-1?Q?1bfMbyf9tHtP2Ki9GNUwTHeRUZOvkFMuaYUkKrHA2Kz+boEqtbOjeEdWvf?=
 =?iso-8859-1?Q?41cvoTqjIQsYHoRYys3TXqKTkEyCkh9kQCB4hplBgegGekrbmhfuA74Hz5?=
 =?iso-8859-1?Q?pcNJyQzlhRoShibasovUhtkNxYB+KKG3tLDFkznB/CstUzmc8Pf32o3j98?=
 =?iso-8859-1?Q?AyzLT8Ig6NcaViFhE7ID8wUAtOoBO2U9RCpssLAIi/cpdm/+NVeKUYLlZZ?=
 =?iso-8859-1?Q?K8oHEKnHZD1O62wd7uh3+2Uu2PCMlwYjaIggQagtfflMvIHQtGNCX1STZd?=
 =?iso-8859-1?Q?vdfoH88z6H0iYWTgdA+TfT1dzSpGa63mBJ881F1IzPov/3lrMtcpHA01qk?=
 =?iso-8859-1?Q?gfFB4T9IMSNckS7VNHAgIRe5qBTLPYDlGY4SpdSnp9JuPAxyRkF0EdesXA?=
 =?iso-8859-1?Q?UChIJu4yVYeN+3KkFqJf2KtSITVOSMy9mosCGZfqXTAF4ZaPjRhPqNflqQ?=
 =?iso-8859-1?Q?FA7IqByfGTRNknX42weJAlBbJKQIR7OQDoeCeewP5tAKBYfoK2NHm0UR8P?=
 =?iso-8859-1?Q?XINEPPWJp1qQmlE2yHa612S2IGQ4cIBMunJ1EICvHxd/YItiPfgNCsADvn?=
 =?iso-8859-1?Q?Log8vQ/WiwPHH7DMq+D7RsT3R7tYje2m7nbENNBubKiTDZC/tJXAkN0JEI?=
 =?iso-8859-1?Q?L8LuND+/Ank92hjmzEtQID3P08Btg6Knk6aytDha/m5pmGJB5t5+PCee+P?=
 =?iso-8859-1?Q?y1qtyzG+Y9m5sfKXWxkBGcyC0ny2vBJSEYZOkH0thRMBzVQCUbO6VKYLJy?=
 =?iso-8859-1?Q?cn0qyqEuAy6IXSgV99iU1nbd+k84gBeaKuMfHqSY11rP8E3DG+UUZaJ2Y1?=
 =?iso-8859-1?Q?dNoFqW5W53UXlWSoX8hUIRgXpSwy1T6XIuZN8/BF1V4NQWQgcbheU4uGZb?=
 =?iso-8859-1?Q?WZT6Q5M1QBZH0Hs0AFiHS3+THiLqeSDgM7S0WIYsWCQill0ICUiZTMMRE4?=
 =?iso-8859-1?Q?s6wDGp0k3ARC/Tu2MZ3B2MiTSKUpxeHN2B/cpjrsKTGIemV+H0Wt2c9KJz?=
 =?iso-8859-1?Q?vsi8oWNW6pR3/sbk7wUfTe89oyZKKKtpqyRLr/kw7PMUyQy2JIHbCFZMjz?=
 =?iso-8859-1?Q?hMAeJTpdSAuml0WjOTdunRxkHoJLFPQxvpOilA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5070.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BXfmaO1nUnngD2emBDHjwXt684cYn5s1OXpgDVLuDxVZhXzMgFUAkT+feT?=
 =?iso-8859-1?Q?X+XsH2ABLvGQQ8dJ7YUPeRDwxHnvP6SLHPfS6QIfUSzATtaK70qnMUykVY?=
 =?iso-8859-1?Q?2WZw3lrJDie+qMXOHwFhKoLCNxo5yt/1t0ZFgb4TgUN2u3yhVQzsKduyQh?=
 =?iso-8859-1?Q?ofav2M5GckWb3nHmL8wqpPR1+fpbwDh4ga2Re/D2evJzoRuaQez0JBsSOp?=
 =?iso-8859-1?Q?7rrCKOh/bdk4iK9Ev+gxfrlZceZR0+HcxBVN4vfB/9/9JBrGOOwloKGdNq?=
 =?iso-8859-1?Q?W3/84XBTXfGBweAyaZaCANU7QlhD7u3dH7t04P2S/vojhG6C3VjxiWd1IC?=
 =?iso-8859-1?Q?HJV4csdShjeo0cK53KbsXQ/XXWTTLsnjnQChNgqiaWJM3xNfEMnudufO8w?=
 =?iso-8859-1?Q?l2XIa3Osdsy8cdZ9Y+0q+tMg9FHPHdHRKTO4uq+jReZZ3tClUyduT23M4/?=
 =?iso-8859-1?Q?nwJydbfngTLvahH0X3gQXcp8ypDI1JUhXvI+/SI5ZhqFHB1oZGkcs1FF3r?=
 =?iso-8859-1?Q?UXhNmIwcFsyU5WG8vp/gBffHfuO+XBX39XFnE5PEBDAnVvpaSYUUv/B42c?=
 =?iso-8859-1?Q?Xo7WNul3NzeM86aSi8LaPXip/BY/hU3kYJdQ25/xfNT8nScZQpDADSWVj9?=
 =?iso-8859-1?Q?Prnbbd1bvgAwXT/TDBPbYUMRfVsuJwZP7djOuoUylxiYdcAhlKdx4QqBRl?=
 =?iso-8859-1?Q?c4vlEe6gMCj1N1Bl5p2U3zw8X1oLOm2/9uic90Sg7lsTAwLPkFdzYsOnAJ?=
 =?iso-8859-1?Q?nQTJmZAOeVjtq4QHiEh1BHLb+m5SWGnJoC/LLj7AFuoSSBEhJ6qgWL85o3?=
 =?iso-8859-1?Q?Ck45R+gJhRMn6/x3FwM4a7F2eYclBDIq3XBTZcDOOf8yN+ZX8zWObKDLjF?=
 =?iso-8859-1?Q?L1i3dxyIF+RTM4dM1dzpgfZSkRQD8zREdCn6BL8poCzp00wM0SZ1LkwhOL?=
 =?iso-8859-1?Q?WOeK2gojCBO74VOhhJUkrkDp2FK+aWuvzDrh/yMUkWU/09FkMVxWQg3oGp?=
 =?iso-8859-1?Q?e+xh0Q4G/Z4LIu2SVqMkpx/H4/B+oCTb76DQ+3Rpng5Df/YwPTY24ooVck?=
 =?iso-8859-1?Q?TDUlJ0Gy/+S3feykc8JQ2kZ10nDKMJ+Mxdv+zhn8pmSPsufP1vsb5YPG3N?=
 =?iso-8859-1?Q?IFWJh/lw0m3um50h00JG86JOSp2fdXDsECkuSADAovr5Xifcx2HdimAj0r?=
 =?iso-8859-1?Q?0EyhrH5SZFCtti0hwXMjc83pzvuOBXfgay+f1ZRfAATCWsOWchC6QHob33?=
 =?iso-8859-1?Q?u/mU/MGij66gOFSiGshtpmIpYLDVuXGPe7X53A8V18A7294b/yFRGPCjoK?=
 =?iso-8859-1?Q?AU+SB1olnfPtYhF5N0m/A+02p0wzVtCkcUb4LKRRUWoBU4E9qAgZzMxkDb?=
 =?iso-8859-1?Q?CyTAg16uIEbIfPLkScTW/Pzw3YPg+77cFecll/eZf/8exciGlePCjEgpgI?=
 =?iso-8859-1?Q?CGkLRSX8SrKC4R4WGPV0UsJg2q5DjlzX9PB1e+0oP8lpUljvHlZ3y2qhSk?=
 =?iso-8859-1?Q?d7+F8GHWsRrYLmMTpQMxpPdriGd7CwwYn03BrbGqE/yYGAw9FZLqd2SRRG?=
 =?iso-8859-1?Q?qUSfcj9LAHXBLa9CBM1FvTYRE1BwhnGta0VBQgO8ey3YBR2Hg259tXAaP3?=
 =?iso-8859-1?Q?oBZU8bAXEg6Zs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f63af9f-1022-495e-9339-08dcc60dc714
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 20:29:25.6088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8256b244-08e6-4df2-b146-877069d9ce10
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXoGaNTixFayjb1DPorhDLQ/sJiuK2/7lAFm9aPeeACairWBeUmY+P0ofk92nwehQkL6LcqR9/jLtZNVBcAQZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6600

Add 2 USB HW IDs for MT7925 (0xe118/e) to ensure proper recognition. =0A=
These HW IDs are extracted from Windows driver inf file https://dlcdnets.as=
us.com/pub/ASUS/nb/Image/Driver/Bluetooth/39389/Bluetooth_DCH_MediaTek_B_V1=
.1037.0.433Sub2_39389.exe?model=3DH7606WV=0A=
=0A=
Signed-off-by: Michael Burch <me@michaelburch.net>=0A=
---=0A=
 drivers/bluetooth/btusb.c | 6 ++++++=0A=
 1 file changed, 6 insertions(+)=0A=
=0A=
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
-- =0A=
2.46.0=0A=
