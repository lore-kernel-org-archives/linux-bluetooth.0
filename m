Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020087.outbound.protection.outlook.com [52.101.193.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236251C36
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Sep 2024 04:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725164933; cv=fail; b=newtMG+ILopQ/h9ngtXP9pxSiO2IksS2P61+ilbrN7zeClAmv2wOwCu6gj2zQl1FJu614Cbya1IbUJDu2VeTpbQ+yVDIXPtMQrjCtf0eQgfUjmQLuN4/4ui+l8RL5Q7/y1HXvH0BSV8JhPujnoZqMwnzLBzATQvWbR0HcYvKNhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725164933; c=relaxed/simple;
	bh=oLKVF3ljgb7b4j9ins6SZt+yJh7cXN7ZmJQV4htF6ss=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V20gWYlC60DldFX+5urHgERbun/R7bGEo0CI5bVUySCsuRNclZEzQML+G1PhErMQQtFriWngK45aDM9rDpaIItSaKvQLcfYQFA8H+eT6lHPYcQvvgoDkVA8EWzI16Y1nInN9nnxn0I2VCs0f+blsNaGyjTue/361GVKJd9Jkskg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=michaelburch.net; spf=pass smtp.mailfrom=michaelburch.net; dkim=pass (2048-bit key) header.d=michaelburch.net header.i=@michaelburch.net header.b=VzsCWK96; arc=fail smtp.client-ip=52.101.193.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=michaelburch.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelburch.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michaelburch.net header.i=@michaelburch.net header.b="VzsCWK96"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpokR0hMrYu4DmChcWhmkCuNzx/vWqe7NSAbksNGWxKzBSNW2+ZdI50Mp/F21SdhEUij3nTardEDW6aHXTxg9qWS8tvebGIutJid1EcSbaD59kUi9YGDeZlUrvtZUw/JoSO2FJAa75pivQniXM5AulS/zpeLquzWVZdnRfCOXoiYPIMuklNtGEx5X3KsBbCdXNya8wRSe8wv3w79MpVCrg07B12/SySI5iCx6QcHozGdEd8ZPH1B9SqQXCqDaq8CgNS0RXhdvthybPIgcTZl/aL5cnMCU9SPPlwGXyXjQ7G4dD48KFfguLwaeKeP4j8wOJMxxYpACmf+P+HXXwUxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+9MQlOiyKfFbyVrar8RFbmx3tnn6ME613W/zyOWvNA=;
 b=L3QwytJGjj94J+zfz9kG8u1kKLi/0rJpSjJos+AnOiyUvidQcUhzzJu3cbbjVFYCt6UepeqtS5cfey4iKlLnWX9nZ2B4t/w9rBm6kCywr+P5zoq63k2vEHE5jwh5aVrlWsvF6bNK84YXA9kkFQyeKuF7lg3GMOMXN9keUUsDHNrHxUsQjNI6L1scZ93yq5PgqtKhFG24V2FYXV7yWgmJjtoopmSytUAu/XRRD71CgeGX8IAl9VyWxBVghLB83My/VfLc6dRsj3Usvwx8KkzoAvYyI17nb44xWeN5CMdhBwR1bN5kwNwGEwl8pukFgJR58jwUrQ0nfAs9sV7cob4cjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=michaelburch.net; dmarc=pass action=none
 header.from=michaelburch.net; dkim=pass header.d=michaelburch.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michaelburch.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+9MQlOiyKfFbyVrar8RFbmx3tnn6ME613W/zyOWvNA=;
 b=VzsCWK96lc+psv2IK4EuqoeFIjlOszDlnNgdwqOBkUfoKemP6IHmMCwoge2DZeLA81Gd01Wu2iJWcTU4uyZn0wcqnG2NSEV6xGEy1v4ZTVJhIIX+oEiAIe9wKiGlR25Gy0WQUqDNvDdbI50d5nmp+VDzpdR5tffiqkAi1evvjDfMSfZl/fA8gUkbGOlcMXDxrbqK3vbiM5COjLul2QnGaNAixoSKAQHZl6UqWjm0Kd2SeFOGp/ZyZ7JxF1I8HoyTAUTeLBh97hSQdSpfRSNi62/UMMoxI0mr89zXbh3awTbZUZHHe18N23iYA87E/z00vEdNFuietUtFhsBjFGmEuQ==
Received: from SN6PR01MB5070.prod.exchangelabs.com (2603:10b6:805:b7::28) by
 CO1PR01MB6614.prod.exchangelabs.com (2603:10b6:303:d9::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.23; Sun, 1 Sep 2024 04:28:48 +0000
Received: from SN6PR01MB5070.prod.exchangelabs.com
 ([fe80::8e42:e034:6306:aaf9]) by SN6PR01MB5070.prod.exchangelabs.com
 ([fe80::8e42:e034:6306:aaf9%5]) with mapi id 15.20.7875.019; Sun, 1 Sep 2024
 04:28:47 +0000
From: Michael Burch <me@michaelburch.net>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Jiande Lu <jiande.lu@mediatek.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v3] Bluetooth: btusb: Add 2 USB HW IDs for MT7925 (0xe118/e)
Thread-Topic: [PATCH v3] Bluetooth: btusb: Add 2 USB HW IDs for MT7925
 (0xe118/e)
Thread-Index: AQHa/CbXUN5I62JsEUuBvnSxc7bgbQ==
Date: Sun, 1 Sep 2024 04:28:47 +0000
Message-ID:
 <SN6PR01MB5070DA7BB9E7C6FA574D1E4CA5912@SN6PR01MB5070.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=michaelburch.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR01MB5070:EE_|CO1PR01MB6614:EE_
x-ms-office365-filtering-correlation-id: 5d758518-224e-469d-5905-08dcca3e927f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Ffumd8OiECrcJ7RiibXK/8VLRzBhlVwOHcF3Bg1fQuSla+HX50Mk7LHjli?=
 =?iso-8859-1?Q?fczCWFUby/gPuQPy/WbrJZOxF3GIn20Xv6af8ssjzZSR/0SDGdrIjA3Y14?=
 =?iso-8859-1?Q?NssEDWOMUWn9WJ/CajNgxFWFwLRAPmta2FfvZC8eJbyJZEjr5zsIsZXGul?=
 =?iso-8859-1?Q?S0Ws5IyOGE4pGwzaXXZNpqzCCcWncyRcjxxS7QvMU2r2Gu4KiOVZqfkS6y?=
 =?iso-8859-1?Q?14hSdv6f5p4ByAWc5v356mh2uQ2dmycSZXEcSwRslMiAg3mkrX1F9Lm/o1?=
 =?iso-8859-1?Q?w8YX80Cmo4TlhW9/llC5Hbs1L2DFY2C/fMLAwF+I1hYd4PwnZyx5pIfHJi?=
 =?iso-8859-1?Q?dte8puQhf4htmyszoe2BGgQGL0EcPGK1ZE4WY6ZPqARE07DhWB6/xwvjeo?=
 =?iso-8859-1?Q?/OXJPgpfyLKDDlTgOEIaWP63TYfuVS+nkxxmCJ0ZcQZ8rQyKO8REazYa98?=
 =?iso-8859-1?Q?s9kw2ICz1L6Nfs6zJiUYao6KzaUt4gdech2eJLEKYF9XxuRdLzu4BUrZKN?=
 =?iso-8859-1?Q?RY9jraklpJ8py+3HvGgjzLNehB9WLsVWyoZ1cFEK6/dsHKO6SK4qnjLFzR?=
 =?iso-8859-1?Q?5JACfZhJrVSnw9enfVK1fHjwsUqFn7TPIVnZ21u5k13kr+jP9tFYnqn/hV?=
 =?iso-8859-1?Q?nIn21zQdzGniLtemsegRAjKz/Q5kPxeUsDSxxTqeF2TyGRgL6hhs5jPgvF?=
 =?iso-8859-1?Q?geTiM7woDueatRWpPbbAN84rkGLD3gamRYXgGDK6DeDtbT5TDapgDHVqSd?=
 =?iso-8859-1?Q?uv1+fVpSxqa9GFRXJ7ScqlIDHx4dkFHSQeobR9RjT0R8ohCkPCleJ3Vm2D?=
 =?iso-8859-1?Q?A2+4puW1sNlShg/fbgt56exVmH2e+UlJV59nRCj+Xlv/WbbaXCXAOWUfwj?=
 =?iso-8859-1?Q?OFhmldxmc/HoUDXjktaQRWyHL0dFBH0HeHPKTf5baU24nxO0l0nJmOVQCu?=
 =?iso-8859-1?Q?0TOt1HCpgGSLcbWZ5HqILR73kCZhy8t9WTU3e6JfGY9a/TaMDdVsvGbG1m?=
 =?iso-8859-1?Q?EXZzXC5ydqfHochgsppx0OyBr1CrnCU2q8ylgvwzjLetfTVxhYqk20g95P?=
 =?iso-8859-1?Q?UT9cTmNTvfc2pccq10A6jl3Gel5C1nPCuLC3GyyoIBKmcuUausErARJsSf?=
 =?iso-8859-1?Q?T+ARCvRJGMNsn6/iJmGKA3hpmnhrTxzB+YAGccYdisv7mDa2FfHejtx2Aa?=
 =?iso-8859-1?Q?EAzamZ2xcwTJZma4kTkApKGUaV8XDHq/sGSPdpJaJxakmFBhwDIr/GS9QG?=
 =?iso-8859-1?Q?mA4be7iu3Ft2RFGeZAgBGejARcLg5FcIN8dXU0bFRxh8vjSMlwOp0YgeNP?=
 =?iso-8859-1?Q?Q/XMg0h6xnmKwzgBwewV0LAxHetZz1a0AqoHmXPowmLbHOQineqtI1Cdb9?=
 =?iso-8859-1?Q?6+39TIeIVfpMlx20ks8aZ0YRemK4wqQCwVbXycOZ94Hb7ybe0bDgK1bBWw?=
 =?iso-8859-1?Q?NtqMX9OfuMK2JPQHniRXBPYVb/Lv8N/exFnEAA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5070.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Dm365xwJ1Wj3KtFa80SSvt2i2KGgU14CTO3FYP4tTns/0uy/cRXlRDIWdX?=
 =?iso-8859-1?Q?Kuapbc8UmwUdZbtCFzyKUWB317IkZTYSnT8PU+4WDHLnK5bel7Bqsq0z1D?=
 =?iso-8859-1?Q?GxcIeOLVk+Aj+DR/CGG7NUaJ2v7t23rkWbwWGnAfJl2TrvuE5OX7Iosgre?=
 =?iso-8859-1?Q?XRisOGoEVxXq1FHtLIv3GSF9DIHzFf73lFEWkqDVVg5mDiod2nFDOeWZEx?=
 =?iso-8859-1?Q?qkxwFp5Ki5+CE2jJRYVlMHO2k/HrGueGmc/ABhn4L8xF3oQi1GvOVuIcC7?=
 =?iso-8859-1?Q?GBNeNfghmu6Cyam+378ROByhAcT9XvRgpgTh/2m83CiQQl6CPBEERyJ3E/?=
 =?iso-8859-1?Q?Er+zYqv/7LzP2ncYEHGSsnvoqfk6fDG4C5HdZ3XP2rE6G1Mq40nAF9/EgC?=
 =?iso-8859-1?Q?tD/ELQKOfFoySyBLsYIeU3CgPtcLNgZUHJWQxPjrnnkrtkGHhdjDkQ7uaO?=
 =?iso-8859-1?Q?qNhrN4jTugCAcqikKDEGf2cz42+YsAZ1KHKcqFE+Zt9VQ2ZsM21z9+Wt+4?=
 =?iso-8859-1?Q?mjpFI2Y6S7e2pCi4MrW0+wmKK8kLAqX/r8aPXIdzLigOBScAVOYthkBYLQ?=
 =?iso-8859-1?Q?q4q8X9geuK6VjkedcShV+FZT6y0Btok4/9Ztr4f24HIuC2q/u0c31QX2q6?=
 =?iso-8859-1?Q?MRvdVCTZne4GDUUOWsQA4CVleE4v7MsK6WaIyns5Z9864Wxg4AywSd8hNU?=
 =?iso-8859-1?Q?036/moL7Qv0vpf9EWC3snB27ch31clmyr3uyUykWagObLAMT4OBgMj881z?=
 =?iso-8859-1?Q?CWUR5G8rZearw6uX9E80AeL9GJFh7E6zRYyy83fL8X+Cn3qGPt6A38PBWO?=
 =?iso-8859-1?Q?+FZMxp1K4BcbVDjgDhoKoSt/yGJN++JBEZWiMYEP+QQ4d0oKXtxfqDcmjj?=
 =?iso-8859-1?Q?kLhlYH0hUh3d2qfjYdiYggT1EPfHr0hGEeZCqxeaS3cExQXwFB0ZRe5Whg?=
 =?iso-8859-1?Q?2C/71UOtlUN2c4ndsYsaVFdsd8OEMg0WlJoStBHSSW72gr+1eU0iaC1dCO?=
 =?iso-8859-1?Q?jn82DsSR75WPQfj6bOgdjCXYISJkQdsc4WADx0D+AR75hTM+Oe33Qfa4xa?=
 =?iso-8859-1?Q?92n+PcGtnqWwfirESOWmZGxMizFW5AEitbUpBSw2tXOKMirkAzueynmrxD?=
 =?iso-8859-1?Q?/T7Z3R+fqnGvR6mDqGojjywdyWddG4L2KUlqZq4FMz4O08LVsCtqVV2hg1?=
 =?iso-8859-1?Q?6kVAjTqfK057uIaO4fyWXKwBbXIslD0t8XraeMuUdH705IznJ2/6S8f8Hr?=
 =?iso-8859-1?Q?ycrozDQTXJThEoHyuacL8a7ziQfqAKM6JbmBXIDZe3PHINqhN7Zd2vqmu0?=
 =?iso-8859-1?Q?QQ8p8ZiqMO9WiPp6dYNSaoq7Sg6oW1RzFaPEAAL9P4Vq+Gxe7zMyctgo5O?=
 =?iso-8859-1?Q?E0QKVJP4NdiVLhfBhn5HC0FEpcMBcLxW3PE0UNPLII3D88X49mTGxfrB3k?=
 =?iso-8859-1?Q?oJl4cYiVc4WGgbxf03+EV4wmvI440Z0JtnXOf7gojQGsrgW4lPRMdc1WX9?=
 =?iso-8859-1?Q?SBXfFrlixuOWG1oLU1MUZIUpIdF0NzS8uhKw+nt/k4Out6X3/DVjT4Nwng?=
 =?iso-8859-1?Q?e2ZDeLabJuVbxqjoo1oIMepCHUbu1FuIFJHjxKi52w+ayqzV574Zy3kAjJ?=
 =?iso-8859-1?Q?JPjEcS8MImAQc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d758518-224e-469d-5905-08dcca3e927f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2024 04:28:47.3807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8256b244-08e6-4df2-b146-877069d9ce10
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0v0LjaO/7rYdu69aqMUqsyJU9EKEMOSkiv/18I2Oim9tSRpsPc3nhhjKbc5BrTlkfQphoW9bv6JKCAHTw1JOww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6614

Add 2 USB HW IDs for MT7925 (0xe118/e) to ensure proper recognition.=0A=
These HW IDs are extracted from Windows driver inf file https://dlcdnets.as=
us.com/pub/ASUS/nb/Image/Driver/Bluetooth/39389/Bluetooth_DCH_MediaTek_B_V1=
.1037.0.433Sub2_39389.exe?model=3DH7606WV=0A=
=0A=
Patch has been tested successfully on an Asus ProArt P16 model H7606WV. Con=
troller is recognized devices pair successfully.=0A=
=0A=
Signed-off-by: Michael Burch <me@michaelburch.net>=0A=
---=0A=
 drivers/bluetooth/btusb.c | 4 ++++=0A=
 1 file changed, 4 insertions(+)=0A=
=0A=
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c=0A=
index 36a869a57910..d9286feacef8 100644=0A=
--- a/drivers/bluetooth/btusb.c=0A=
+++ b/drivers/bluetooth/btusb.c=0A=
@@ -632,6 +632,10 @@ static const struct usb_device_id quirks_table[] =3D {=
=0A=
 	/* Additional MediaTek MT7925 Bluetooth devices */=0A=
 	{ USB_DEVICE(0x0489, 0xe113), .driver_info =3D BTUSB_MEDIATEK |=0A=
 						     BTUSB_WIDEBAND_SPEECH },=0A=
+	{ USB_DEVICE(0x0489, 0xe118), .driver_info =3D BTUSB_MEDIATEK |=0A=
+						     BTUSB_WIDEBAND_SPEECH },=0A=
+	{ USB_DEVICE(0x0489, 0xe11e), .driver_info =3D BTUSB_MEDIATEK |=0A=
+						     BTUSB_WIDEBAND_SPEECH },=0A=
 	{ USB_DEVICE(0x13d3, 0x3602), .driver_info =3D BTUSB_MEDIATEK |=0A=
 						     BTUSB_WIDEBAND_SPEECH },=0A=
 	{ USB_DEVICE(0x13d3, 0x3603), .driver_info =3D BTUSB_MEDIATEK |=0A=
-- =0A=
2.46.0=0A=
=0A=
