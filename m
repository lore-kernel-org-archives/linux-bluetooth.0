Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BBCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 16:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B3661A3A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 16:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbhKSRCk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 12:02:40 -0500
Received: from mail-bo1ind01olkn0168.outbound.protection.outlook.com ([104.47.101.168]:7890
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234030AbhKSRCj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 12:02:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESq7YlKXl+EmAB4cMPti7xf/8xlYUZ6jL1JCObWXJn2yWDpFhyEn83AgH0RCR1fSwY9gSdQZTIiKEEJAVUoLPC52lxPHLSCIRZljk8CpPukGC8TDRTSOMpiMvlOaJHLMTE8wLeXFfkcT0nOI+tSrfkabxU1vir6C8psf72SJ/k96nO2u+PwIXknWS2fcDG4NMhCugGfc2SXOeDIqwyWoGg6C/8NkleksNIgEGuKdEjbzTOnCnuzkbRTbjyZEtwcPR8GQ3xwvspvKeYS0TfUh5QMKbBVU92LWqFjEft/WXCN7HoFJaU+o8SuJrMZnERGo5Hxr9/oxr1HZfUzmbgGtHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1WZ20gIs8SqMhtqEtCg+PkcoYpk9zK+UKo58u2vcP4=;
 b=cbBTU1/HmsnYi6ArfivJ/sWX5rnzGEsCj1kyLY5UQXlOmtk3lsPQGOHvZtnd537pyXW4QWnCMNbRVQQTKsY52GkRrQfKvnmhfoBnZq6a+62VwPsgLUqgZGr6O8mdD7g9FSFlvlV2mCy74AgjATurro+RMrkwsXAF1oePMblL8jQ8giEfJ0l760gT6X3zec87TX9eVmRMquRgJmhbKKvqOPN0twdt+RNhFRQ5peOf4AdqZrYonC8f15CnBXaUmnyaZ7M5shpPLm6wLdC2a2f63pzCBYjSeI+EbUpyupdzxPA9DyYS2Rjs4Yz1LUkjIcGj7B7KwgfvejoJyAbE3Tc8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1WZ20gIs8SqMhtqEtCg+PkcoYpk9zK+UKo58u2vcP4=;
 b=awyORlJMJA3OXf1/Cc3Px6d8T/zrmImSSqNLrS5VwkGZQ5DxlltWAKw008vf+9SlW8ycXO2tzXARlEjSHxwHc71zCBzVRqOCrHF6cHhqk6WqQFZSI8U8sywuD6RexN2JeRWx81imexWEaWMgkdKOPcTT0OIY6Q1oykyKKPumFs6L7sQ59f66dMeJiF6U121Z+fILlPIWSOuI3608udbY+UWTO3IzY7Qn2o2MVT055qZei6YOAaKra46ucavP/gEHWgf/7UPrBe2PjatPQgn+X0vvCWjDTE/Oi3VJ241Mrkc2wN7GjNQvvtg4wtCpB/9Mqk8rwoK+gNIsj89Z/6NxwQ==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN2PR01MB5256.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:5a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 16:59:32 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7%7]) with mapi id 15.20.4690.029; Fri, 19 Nov 2021
 16:59:32 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Orlando Chamberlain <redecorating@protonmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
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
Thread-Index: AQHX0vJ15A6zQVMGfEiNGmUN6kF0hKv3vuGAgA4gSACAAAxJAIAABrOAgAEuUwCAAEInAIAAIdSAgAAEmwCAADPsAIAAaCCAgAMCoIA=
Date:   Fri, 19 Nov 2021 16:59:32 +0000
Message-ID: <40550C00-4EE5-480F-AFD4-A2ACA01F9DBB@live.com>
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
In-Reply-To: <F8D12EA8-4B37-4887-998E-DC0EBE60E730@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Dq6e8ab1WhxuAnggjNla7NOSUdljpyA3zCPAilLa/8ZcZHCG9wHjuO1S2v+HbGA5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb3f7af7-d8d2-459f-330a-08d9ab7df56e
x-ms-traffictypediagnostic: PN2PR01MB5256:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F2VFo6sabM8eZcnNkec+2SuJ0Xxd6AyIu+qGDQCjrPev7doF5Sz7OZCMYD7V9V/eFGGymv7M74BpQ709Spj9Ct2tAVXBLDB5wYLDeNFzE1kgAUJYJEYUlmF8LK+P6eIYPgZ4lFAIWVmjrzvmGeD72MmSF9Sq9Rf73Dzou5kUajqUCaM60N+nTAOaJOwzOAIgkOWvXea+W3aL+qfBJyS5OLHMQ4ZdzkwYo0sqAOLcmIoTyBQzgD1yag4+sEAi83JK08n4l9PT9wvrUYriTOGm3T45ds4X7xSwTHtQdMxi7kcADSGMbfKcr8yqBRyXYxkeYbGBqjzovcx05ITH8K+9ldqbbC1Ig5e70DZH29qaYEsO4IJkxcXzd21WGztwF47fu7Rr7BWNeAAGXKpAjDpqafZdviail70W5HerfJxqLx8qkD6aK+Rj0yGIMh0n8WsNkgXr8fC4j2C1p5OLXgsI9wnwjEx1D0aJdDL2g6XxazwMTwLjC5cbCBiPV55vg8HL5PRyHb7PVfVnLebX2J2zTeR+mGprYud74hfiePhi5IBA2cpSto7ud3zd0I1bkl5e9rgIvpJAyLeEwhkWprg+eQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: IICF0/hyHBwiYvHKd2HOnG9uGguQlcKAR2ZyLXQ1BRIw3P3lVTwLsqStUe8AEhfaFRuZ3srx6XJjTxHugNVN7cBhYmC47VUp2AD7fnHWslLdvHCQiPRSczmBtRjgCbvyNfly7W7ucmNtjo3Ja+trOjwnnvfPUZ4PSJXC4VVMgXffa+vbOeSW1HnDn4a69i2928lE3TP7GjCvmvY2ovXmGmKVUUCC+l5iQKGASaSIvZaKqlwkEJzorpWLJrpeFFpl4EDwNUj6VwjepbgTTuSgU6gEN67cHFHtWx5aQv9lJb5AsfHi5U8cYBu0Z5UAYMxO1YE4gVlBNCueygRTNf2ugmFDrFTyztL9IdT8iNkGBPFO4Q1qy0jJ2NWFQPW+wgjjfz0AJlguy4NR0N/tEHlvne0AXT37y5uvlFvsQbf6gz30YVkDUvxjgmGoMEqK3WZ4DkTEakmiDRiX20XsyFSuNJuap4laXHbmMnQM8chsR5aEkPmDZbTdtgRVrP4VMEN+Aqt8ZHcCYOdfio53cV5pRw1zGnqjW7je23QvPneHYsglx7UQDETDCYSpRpKV24I9GztUPwS3/6zUk6iB7cBGK+iy+RCBW2fD0fHvXe57vVCOx/bT6cZWBUptu2aPEZbVL1LIlUmfgjpfvZkO2jl2Ye4lVWeZgfVW2zhpuqANf6Ag6MJqxApwiURHg7DOqWvOC1GUvO8nfWqKkomWjGNEwqPCn1mPVMM3dXQBR0BPMuXWGjE+WD+fqPVTgjIO7/eaQcZzarFwJL5JVSDmz7Q69Q==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0631C0AB96C4D4BB50251C598AB6F99@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3f7af7-d8d2-459f-330a-08d9ab7df56e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 16:59:32.5073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB5256
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



> On 18-Nov-2021, at 12:31 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>=20
> Hi Orlando,
>=20
>>> So if this just affects two macs, why can't the fix be realized as a
>>> quirk that is only enabled on those two systems? Or are they impossible
>>> to detect clearly via DMI data or something like that?
>>=20
>> I think we should be able to quirk based off the acpi _CID "apple-uart-b=
lth"
>> or _HID "BCM2E7C". Marcel suggested quirking based of the acpi table her=
e
>> https://lore.kernel.org/linux-bluetooth/1D2217A9-EA73-4D93-8D0B-5BC2718D=
4788@holtmann.org/
>>=20
>> This would catch some unaffected Macs, but they don't support the LE Rea=
d
>> Transmit Power command anyway (the affected macs were released after it
>> was added to the Bluetooth spec, while the unaffected Macs were released
>> before it was added to the spec, and thus don't support it).
>>=20
>> I'm not sure how to go about applying a quirk based off this, there are
>> quirks in drivers/bluetooth/hci_bcm.c (no_early_set_baudrate and
>> drive_rts_on_open), but they don't seem to be based off acpi ids.
>>=20
>> It might be simpler to make it ignore the Unknown Command error, like
>> in this patch https://lore.kernel.org/linux-bluetooth/CABBYNZLjSfcG_KqTE=
bL6NOSvHhA5-b1t_S=3D3FQP4=3DGwW21kuzg@mail.gmail.com/
>> however that only applies on bluetooth-next and needed the status it
>> checks for to be -56, not 0x01.
>=20
> so we abstain from try-and-error sending of commands. The Bluetooth spec
> has a list of supported commands that a host can query for a reason. This
> is really broken behavior of the controller and needs to be pointed out a=
s
> such.
Well all I can do is provide you any logs or information I can. But we do r=
eally wish to get this regression fixed soon.
>=20
> The question is just how we quirk it.
>=20
> Regards
>=20
> Marcel
>=20

