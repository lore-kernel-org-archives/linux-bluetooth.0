Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC3FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Nov 2021 15:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377972AbhKZPVS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Nov 2021 10:21:18 -0500
Received: from mail-bo1ind01olkn0153.outbound.protection.outlook.com ([104.47.101.153]:51399
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1354196AbhKZPTS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Nov 2021 10:19:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYhHkFHVzeN2JtTmnLyg43WHkFFvFv3vUDNQ8HJomKOjQf+3nRoCUzUNfThOuKddYomkNmCQFJcYBJH9DvobJenRlePEf0/dHhkMCiiK34w9D+o2Spnd2QlVDYyyWf1IbFN60H03UAtvYjFqRupwO2g3/D0iALJA7sLtM/ky09xZBwpVOhHPGVF2PuQlMhcSIVBC1bKf59d8ccbXhSwqZp0x9ymaszAvSg6TXLBDP4rkLHBKv5U0ddJWBL48PlAcY8VnY4TQcfplgTAGNyCUE2V7UjeKjOxJ/SLeL4HEBCanwxobGEJ4KwDKn4grWEGAY3lmv5fNSk5qcDz8y64i+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKQxzm8JgFWxpCKxagriKo7JHqMMeRPnw9jxzmgJnxw=;
 b=H5gwAP5e4ZjtjM36tf5G0lpJZHyMCYM8KmZjLBxSf06bT3K0kcnHbWUjWoKhKoZotAqxR9nEm4yH3R/tTVXIWvKZu9egB3bC2tgj0NR4xQxvpF22bO14Kr8JkGge6RkPXMcZtTKfhC0GNoSNRKSHk2VF1UaBJiAuGE+WygnfN7G4+laAUSFrns908SHccmfIwbb379F32GUamQbrWBZ2ii/Ue1J2xK3n3UAcgBVQa+lHMKor42hf6wleYGkPqZ2fAtC3lMdUjUchL6t/GOw8+RM0mXINsF+5/H/JQS1LPJo/omO9TyF5wmubK+fi7mue7xV1e+c6pIdgBkBFsBP5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKQxzm8JgFWxpCKxagriKo7JHqMMeRPnw9jxzmgJnxw=;
 b=kUfNPQ9YrhDIZ0EiEbLw2hw4RhgwRq4ZHhJ46EGhj81+6/hI7aa+Jd+IDmR5HHx/M7coULU4ah0ZHwUnOAZFWw2NdUCqpPUowv8PVgvGfxPi6k83+nJRIDmRUVCzhoxiLWQe4jwadQECVCwtodmpXSv3L4YvAHhwv+SX9sknrvRC/6pU0ZV0gkdNpheAF7d80Dhj5U2xip4mQl0Ifiu2ZPsd4SaRWCw+7XyB2BsdZYmN2n+0nPglPi8yxDN0PTVzQOmigi+eSDa96DAQ0JwChi7p6LV8V77MO1s7syJ94Tqfq2Xn4HYxNGyqibyGVTt4lZSQ0xVgIYChebNNqfFeIw==
Received: from PN2PR01MB4411.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:17::10)
 by PN1PR0101MB1294.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:15::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 26 Nov
 2021 15:15:59 +0000
Received: from PN2PR01MB4411.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::152a:9391:5b99:13e8]) by PN2PR01MB4411.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::152a:9391:5b99:13e8%6]) with mapi id 15.20.4734.023; Fri, 26 Nov 2021
 15:15:59 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
CC:     Marcel Holtmann <marcel@holtmann.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Daniel Winkler <danielwinkler@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "sonnysasaka@chromium.org" <sonnysasaka@chromium.org>
Subject: Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Thread-Topic: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Thread-Index: AQHX0vJ15A6zQVMGfEiNGmUN6kF0hKv3vuGAgA4gSACAAAxJAIAABrOAgAEuUwCAAEInAIAAIdSAgAAEmwCAADPsAIAAaCCAgAMCoICACSHJgIABwZoA
Date:   Fri, 26 Nov 2021 15:15:59 +0000
Message-ID: <D9375D91-1062-4265-9DE9-C7CF2B705F3F@live.com>
References: <20211001083412.3078-1-redecorating@protonmail.com>
 <YYePw07y2DzEPSBR@kroah.com>
 <70a875d0-7162-d149-dbc1-c2f5e1a8e701@leemhuis.info>
 <20211116090128.17546-1-redecorating@protonmail.com>
 <e75bf933-9b93-89d2-d73f-f85af65093c8@leemhuis.info>
 <3B8E16FA-97BF-40E5-9149-BBC3E2A245FE@live.com> <YZSuWHB6YCtGclLs@kroah.com>
 <52DEDC31-EEB2-4F39-905F-D5E3F2BBD6C0@live.com>
 <8919a36b-e485-500a-2722-529ffa0d2598@leemhuis.info>
 <20211117124717.12352-1-redecorating@protonmail.com>
 <F8D12EA8-4B37-4887-998E-DC0EBE60E730@holtmann.org>
 <40550C00-4EE5-480F-AFD4-A2ACA01F9DBB@live.com>
 <332a19f1-30f0-7058-ac18-c21cf78759bb@leemhuis.info>
In-Reply-To: <332a19f1-30f0-7058-ac18-c21cf78759bb@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [woERxkV5XLI5WA7t55+1mvcAMm3vIlDesVa/AYpWSrtPYN2Ei005WxpdMe/kr32G]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee55d546-3470-456d-dfbc-08d9b0efa6f3
x-ms-traffictypediagnostic: PN1PR0101MB1294:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7AQavusiEB6Jc5XhWKl8JjjTg2lm+SzaFHXY11Wyv2ZR7C/KWsKfMiXKG4uSeZ++wEg3dIZAN7Fn/M/wPRmgHcLN1o5xaKLTIECEjH5WAHGo5Ug6rB7ZpSG3CZfDNwZ7M0j7n3KhHvnrGv5nz39DNtpSuwBYM3FHTzaooSYKZjo7DyzGiImD/C60Q4R5scxaWQJEH1LKNr32CkIvL1az4D0MsfZ9SrAWQO69FBJ443CwwFi7cn2L/Mwi201AoDnSIifdcgtqiefuEd1AZfN7EmW/ktCmliLJgt3MlABgKyPZWsVhPPoOC0vhtrXmKqtynY3kI5TV9xjEEAkDPLkwuhIee33BgH0qECz0tB2DFJLLoegzJFKbEyFYi5AxOCro4t1zl5bTu89VfsQEBdgVFb5uxOXHFcUcBGfFpXRD83l5x7RDgy9HXCC1ZxqoN/xozXn/70GwBVqyKxis9dpD5R7S/88VvCFl5a02cDoCTauEgnWYTKjN0FyOArMt/tV4WMgaaCTp/G8y8o8jWysZ8mAjDC96S290NxxNhNKRagY+3x6y/HNr0VXBU1xHB6AXmwZd99KHSBFkCJLfMDA1hfppzMxYwqXKLUE67TQX25ZXuFVl4gQbGNs+dqyqd13e
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: N/mblAL95uaRnfMJm0Ev8H8u8HY5JiXtU2ds3NKlFjo2ujrKqIxitbC9uXtEZiLeGcGylRSvq7lNbr4enmD8t/WW7x1kgFMj+PUU8iih83mj4dWi4SP+A3fxcUQsZAVk25eWLVgGCQRTzpmKAqptY7A0bVctj0RjTtCwDCM6mq4GrSEXT7jeATuIgErj4Q7JDylE2h2FyNqWndlzLmw1FrD2SnfSr1NI9Y1dU7vagjgg/sxDEqR0plXL7mPWtq/MpXjuoQntgYUtUqjTJL5uBBQSMQNefWn356Qri1B9py9ylWDPdUod9GdLjiIeHHWDSH8omiP7XypgF2+FDF4omlOsiXIOpd5sqOaPq6/inrRJMHwlJkbgPe73ZOVNa5HBgSpPbxuGa7iipD4WRuIQmcC7/AFEM9c31nBr2zbwpDFcwwnkkTTZPc7ufsPPuz2Rei9MGqL7TeSjpnZ2cW8PqDbM9IrkpT8rJOw2Xs3xGCEbs/7kZdU4fY7D6ZlFRQr78ED/gs8fBtjK0PmmOW5Pv5PCqwCA7xeEREQx8U2Fdw7KLr+zFVWoM2IEteS5mOX9LZT7zjhnheQaYuLmVM3w0ioAtQHsBCPn7MQFjJ8kTNS/euX9h8S7PPdMgtX7wCSt6skEmvvP0JtuDLpI4GaH6A5larlGO0vbc4kxQXF6Jx5a5ikzlUyzjQtmkjQP8z/Olyf/pDwtznjHg/trBc+pZDCy3bqjnZxfDIg0AQO7jGHAh3yaW8IPN+wVrXDfNIeHFyVXHsmqjLSfwJW94m5gEQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B41D78ADFAD5224EB6E6756031715E4D@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN2PR01MB4411.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ee55d546-3470-456d-dfbc-08d9b0efa6f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 15:15:59.3173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1PR0101MB1294
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



> On 25-Nov-2021, at 5:56 PM, Thorsten Leemhuis <regressions@leemhuis.info>=
 wrote:
>=20
> Hi, this is your Linux kernel regression tracker speaking again.
>=20
> On 19.11.21 17:59, Aditya Garg wrote:
>>> On 18-Nov-2021, at 12:31 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>>>>> So if this just affects two macs, why can't the fix be realized as a
>>>>> quirk that is only enabled on those two systems? Or are they impossib=
le
>>>>> to detect clearly via DMI data or something like that?
>>>>=20
>>>> I think we should be able to quirk based off the acpi _CID "apple-uart=
-blth"
>>>> or _HID "BCM2E7C". Marcel suggested quirking based of the acpi table h=
ere
>>>> https://lore.kernel.org/linux-bluetooth/1D2217A9-EA73-4D93-8D0B-5BC271=
8D4788@holtmann.org/
>>>>=20
>>>> This would catch some unaffected Macs, but they don't support the LE R=
ead
>>>> Transmit Power command anyway (the affected macs were released after i=
t
>>>> was added to the Bluetooth spec, while the unaffected Macs were releas=
ed
>>>> before it was added to the spec, and thus don't support it).
>>>>=20
>>>> I'm not sure how to go about applying a quirk based off this, there ar=
e
>>>> quirks in drivers/bluetooth/hci_bcm.c (no_early_set_baudrate and
>>>> drive_rts_on_open), but they don't seem to be based off acpi ids.
>>>>=20
>>>> It might be simpler to make it ignore the Unknown Command error, like
>>>> in this patch https://lore.kernel.org/linux-bluetooth/CABBYNZLjSfcG_Kq=
TEbL6NOSvHhA5-b1t_S=3D3FQP4=3DGwW21kuzg@mail.gmail.com/
>>>> however that only applies on bluetooth-next and needed the status it
>>>> checks for to be -56, not 0x01.
>>>=20
>>> so we abstain from try-and-error sending of commands. The Bluetooth spe=
c
>>> has a list of supported commands that a host can query for a reason. Th=
is
>>> is really broken behavior of the controller and needs to be pointed out=
 as
>>> such.
>> Well all I can do is provide you any logs or information I can. But we d=
o really wish to get this regression fixed soon.
>>>=20
>>> The question is just how we quirk it.
>=20
> This thread once again looks stalled and smells a lot like "everyone
> agrees that his should be fixed, but afaics nobody submitted a fix or
> committed to work on one". Please speak up if my impression is wrong, as
> this is a regression and thus needs to be fixed, ideally quickly. Part
> of my job is to make that happen and thus remind developers and
> maintainers about this until we have a fix.
On the basis of DMI data, I have made this patch to disable read transmit p=
ower on 16,1. I have tested this on my 16,1 successfully. Still consider th=
is as a draft as more models have to be added. I am sending this to get the=
 approval of the maintainers whether this quirk is acceptable or not. If ye=
s, I shall send the final patch.

From 3dab2e1e9e0b266574f5f010efc6680417fb0c61 Mon Sep 17 00:00:00 2001
From: Aditya Garg <gargaditya08@live.com>
Date: Fri, 26 Nov 2021 18:28:46 +0530
Subject: [PATCH] Add quirk to disable read transmit power on MacBook Pro 16
 inch, 2019

---
 net/bluetooth/hci_core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8d33aa64846b1c..d11064cb3666ef 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -32,6 +32,7 @@
 #include <linux/property.h>
 #include <linux/suspend.h>
 #include <linux/wait.h>
+#include <linux/dmi.h>
 #include <asm/unaligned.h>
=20
 #include <net/bluetooth/bluetooth.h>
@@ -461,9 +462,23 @@ static void hci_set_event_mask_page_2(struct hci_reque=
st *req)
 			    sizeof(events), events);
 }
=20
+static const struct dmi_system_id fix_up_apple_bluetooth[] =3D {
+	{
+		/* Match for Apple MacBook Pro 16 inch, 2019 which needs
+		 * read transmit power to be disabled
+		 */
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,1"),
+		},
+	},
+	{ }
+};
+
 static int hci_init3_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev =3D req->hdev;
+	const struct dmi_system_id *dmi_id;
 	u8 p;
=20
 	hci_setup_event_mask(req);
@@ -619,7 +634,8 @@ static int hci_init3_req(struct hci_request *req, unsig=
ned long opt)
 			hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
 		}
=20
-		if (hdev->commands[38] & 0x80) {
+		dmi_id =3D dmi_first_match(fix_up_apple_bluetooth);
+		if (hdev->commands[38] & 0x80 && (!dmi_id)) {
 			/* Read LE Min/Max Tx Power*/
 			hci_req_add(req, HCI_OP_LE_READ_TRANSMIT_POWER,
 				    0, NULL);
>=20
> Ciao, Thorsten
>=20
> #regzbot title bluetooth: "Query LE tx power on startup" broke Bluetooth
> on MacBookPro16,1
> #regzbot poke

