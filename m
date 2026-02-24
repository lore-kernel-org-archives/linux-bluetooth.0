Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013039.outbound.protection.outlook.com [40.107.159.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A03AA1B6
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960893; cv=fail; b=nUiJeizr4z+rrinI2y/h8KBdtvT1ME2T9Z7v98TDfGzLNmBIjfRlG6NBmxeFcH4RgSZm6uBbeiWIA0HhJ1EWZcd8oRsgSbdxf3fDDQUiXkKDpanmLwjbblaiXLI6gni3OKe04+umZ7KmViMv7mUYx/xpwFacjxGY7wv3T3E7s6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960893; c=relaxed/simple;
	bh=5h2hTlXAC3Dums+AX94rltUBGVNQZPgxjc9Ychd+Urk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CN0qRiDPPJuHaQSR2H9LMb7DI8j4rdfWR0u+nukrHsVMkJ3z6Dp29LsXXAZ/+uXLpXSAFRlcQwL+SA5uiwPLWsuxeFjQDGkjj5Ojsbi4e4DEiYDB2/8umHZE8fWXrYw9TLCnOrWz53cyhtDGyQC6HRANtiH9WhdT23ue88eUs0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=aDIOd9Sg; arc=fail smtp.client-ip=40.107.159.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="aDIOd9Sg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ww73ONfS/wXsKhtgOG5hHEcBF8AsrA5KSQlBjai7ckA8HVfRCCqsVTEsiN2TnvzM0jw7OUXn3g55Qo95y9+DLCsS3tE+tmoHLkckvnawExN4PBhMEgXhCIBRV8KPD37PAGEFvyWZz+7HwxjhV/eM5DZPDkzXp89WwIyyoGZhxob9708OHRNw9aJcR9FNV9q7MJ29CO5sbwKu9Cr/ftw2eNdA/xTwN6WjA8qWCUGTwoH3kfLzMcbGoNO45i7Bm5+fXv4CCJz9C/A3jklV+cwnVHOY7k69JqVYJQptQWoBrA5Bm5kcg+OLbOgqNN423tCksH4/TW06xlWv26rc8nDH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8t+4uyBZfGxiy7S976UtdgEffsyBYXAa7nKK+Q4Y58=;
 b=FwMH0odCKSGtoq+nbNgwZKEzI3BMLI3m9LY4v+d8l26/YcIjZgiOY3gqMYC2GAUvic2DH+OItYpw104uVcp+bGSNNVQjrtQpMYhEd/8U8wdbeKwfh8oPxaxcpBQ0iDvCpWYAfuyE7IGJ6aYM94TdhPDQSiIUSJvgEccpmrfmSA0kd/48rz9VghqbAabaQJX6lOI6vJfJFxsglsLe313NicyWXa3E2LAq+sBlCjQY36dA0JsBa9/XPwoJVdNF8aFuKWASpIr8MqDZRvD/VdIXpW6pooTmDynMQB366pLDLkOXIO8M756w5GHNEDVPNUnHyuYmq/tLX13a7EzeyELOtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8t+4uyBZfGxiy7S976UtdgEffsyBYXAa7nKK+Q4Y58=;
 b=aDIOd9SgtgunF4papH5XEG2V9wr6S0yYXjLMBEcQMk+C7rWIQGeRtdhKn+pumUrYk1VjcSn1SaT5lr4149/ViqkGUm+AQB0CMDxAQY9zSU0k51tobgOmO0lgBpO1YrqF0A9fSKvXbhu4f2yEM97W26mOtouRS+quiU4SW7jtpeU=
Received: from AM9P195CA0010.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::15)
 by PAWPR03MB10134.eurprd03.prod.outlook.com (2603:10a6:102:342::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 19:21:26 +0000
Received: from AMS1EPF00000043.eurprd04.prod.outlook.com
 (2603:10a6:20b:21f:cafe::d9) by AM9P195CA0010.outlook.office365.com
 (2603:10a6:20b:21f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 19:21:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF00000043.mail.protection.outlook.com (10.167.16.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 19:21:26 +0000
Received: from n9w6sw14.localnet (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 24 Feb
 2026 20:21:26 +0100
From: Christian Eggers <ceggers@arri.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <frederic.danis@collabora.com>
Subject: Re: Running GATT/SR/GAI/BV-01-C and GATT/SR/GAI/BV-02-C tests
Date: Tue, 24 Feb 2026 20:21:25 +0100
Message-ID: <27272888.1r3eYUQgxm@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CABBYNZ+O6KbjXoxTKSaPnSd=p2CDJ7j6cBktPT4xXD=PR0CBhA@mail.gmail.com>
References: <5832992.IbC2pHGDlb@n9w6sw14>
 <CABBYNZ+O6KbjXoxTKSaPnSd=p2CDJ7j6cBktPT4xXD=PR0CBhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000043:EE_|PAWPR03MB10134:EE_
X-MS-Office365-Filtering-Correlation-Id: 138f7cc4-5a76-4e73-7509-08de73d9e78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUdTcnFRZGJCYTh1NXlxeHhsc25DK0dCTUJsaUNZRTVOUG15em5PUjBmM2ZN?=
 =?utf-8?B?QW9FNnNObDZHS0JxZk9OS3MzUW9ESHpYR0tpTktPR01HZVBHTTl4aUFnODND?=
 =?utf-8?B?MkliYTdGT0p1NmpGaXJrM282eWt5Zjd4dktmY1l4VFdDendVbHdTR3AwNGdp?=
 =?utf-8?B?eDl5YkZDZnZrRXpaQ001Szk2SG5JQW80SmF0eGN1NW55bDJSTSsvakw2RDJn?=
 =?utf-8?B?MVhZNnNjK0d3NmEvdG1qOVQ0cGNxWElmdE8wTFBnOEsyaEsrNDZNQXdCcVlI?=
 =?utf-8?B?S2E4UmN0YmVCSHZyeS9hNHloUWJzcVVUcUJ2S1RabGZkNTRiUmZPanRjRThV?=
 =?utf-8?B?S2QrdzA3VGlUV29GeC9HZU9mNWJ0blVZalVVK3VpdS9TOWE1TWhYaldGZGda?=
 =?utf-8?B?QTBKcGhEMkhHVXBsVHIyUDVjSU85em1oanVQdVorS2N5TzR5RFRLRG5JK2pS?=
 =?utf-8?B?MjBPVEp4MHJNT21rQVlBaC8xWGErdXJ2QVBtRzgxcFZienRnMDlWSWlKQVVP?=
 =?utf-8?B?TXdnTTBQV2xHZmt2MDAxV3RFU3Z0SEVqdUM4cU1mVmNQV2U5eTdIZTVsTWxS?=
 =?utf-8?B?dTZESzdDWU0zNDhkNWlybVBxM0dycmxpZlFra21HN243eS94SlpMa3BrUzJM?=
 =?utf-8?B?Z01HR1RrU1YvOXdOZFprZGdyaGYyTkNXdkw1VkRMOEhnZTM3WDFHaElzQ3My?=
 =?utf-8?B?akdFK1BSVlQweVRFMUlxYVFDM1hKSFJ3cFFsOWcwdGhRSHVGRmtpeERxRGpz?=
 =?utf-8?B?bVViTjllemxNOUdyQlZVM0FIQmpzeXNtVXUxLzZqYmpxSUtRa2czSkFUZjdq?=
 =?utf-8?B?OVBpZmxlbkxoQy9iRTRwRTBhenozL2RBOWJlRmxhQTNOeHl5WkZpaFhJRFI5?=
 =?utf-8?B?SGV4SDBVa2paZUN6cEEvL3JVVUUybjh1ckVjbHdPS2VONlB3bU9DN3d2Z0FE?=
 =?utf-8?B?eHlSNUhsWnc4MXdzN3A5ZjlkWmczQ1Y1SGU4YzdQdEJNbmw4a2FEdHJMbTdB?=
 =?utf-8?B?UmhFdE5PVENFN292TnVvNklTRCtnRWhaUUFsaEhBRzQwVkNNQ1RJSi9oZDJL?=
 =?utf-8?B?SFRHQ3VKWnpqSllEalozay8vZlJuTmRqa2toYjVOU2IwYmVTc2NseVEreSs0?=
 =?utf-8?B?bmNEQytmNHkreE5pejlXQlJTcXB6Ykt4SGhJWGd5MEZ1aUJoUTN1Zll1akpj?=
 =?utf-8?B?bkEyQnlKc2VERml2NkFwV3RYUitrNUsvRVlSRk8zdFRCN1VDU2tia1YyQUd2?=
 =?utf-8?B?aituNWhORlB0Znd0QjljVVoxVC9OM2Z2cDRIQThXVWM0d2M2dDVUYXBCRm03?=
 =?utf-8?B?VmdiMmNBVmE0Q2pXSWt2WGV3UkN5bFovSFU5dEJlSHB3cG9pdUlCQlB6dXk3?=
 =?utf-8?B?NFEyY1F6SFJ2azJDcURzWDNRMUN4QjJZT0lDamdYa3ExRzRNNFQ2QzBlNlRI?=
 =?utf-8?B?NUwxNEIyc2N6RDQ0bWVXR1hQaTI3SnUwMTFEcXF3OHlrSDRSaHhPQm9mUGg4?=
 =?utf-8?B?YmhmUGFqY28vQmVDL1piLyt4cy9ONE9mSURWUTlrSkhiSktCUDZwNFVldzR1?=
 =?utf-8?B?Uzc0TWRBU0NseVF6LzVaaHZOZDZTV2FDSW0xb2UrTWZxTEFEbEh5TmJTa2hh?=
 =?utf-8?B?WG9EQ3dleTRhU0gybUs3ZjE3NVJlWHVvT0p3N1dCL2M5dWRzcWZFaXVubkl3?=
 =?utf-8?B?ZkJkS1cxUHMyb3BQbHMrV29UMGRCb1hRRWJLYnFJOTBrYmh2eFNlZ0RKekJt?=
 =?utf-8?B?Y3piZjdwQjJXZUJoc3VFZzBuSHNzWUhQQ2gxUnlna0RuRHNmMDVyMXptME1G?=
 =?utf-8?B?RkJZbG95eFlIUitOT1l4TW9zQUJnbnNuZHU4cklRN1phYWpHWHZneWdZUXd4?=
 =?utf-8?B?b0hidU1Xci8wQXJoQW9FenFGcTN3MUo0VHVHT25NTFF6Y0FPN1NFNDl4eUpC?=
 =?utf-8?B?dnlnZm9nQm1xbktWZFZOMGYvVEYwN1RDcnkwQ3MzWTFUNStvTWN5WW15b05h?=
 =?utf-8?B?N1ZEcTNyV2dyN0YzN0hGTzQyZFp2R3krZno4ZXIra0gvS1NJVnE5NjZ5WUpj?=
 =?utf-8?B?aHZuckhlNnlzMTZETWlBRGRCdzBkczBUMm1UODR6NEhOQ2pCeGl2MUtxb2cz?=
 =?utf-8?B?cTRjY3Y3YStwNjRvWXU0SVBSeWkwRXNiVTFVRmx0Z3NUSGhzSzdBdndJTWIw?=
 =?utf-8?B?VTdrd1lCTWVWVkVldU5FVmE3bzA2cDgyRE5od1VpdGUrZUVwMVR5UElMM053?=
 =?utf-8?B?akd1Y1VmRXRRNUxvTU1nMGVYSGFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pAUSoCiSTZsd8dbqe0QdZtUlk9bKjweCpgBYtXt0x/ODVmfCjTd12MUJr4Yl3D6LXjBkZp5+AyrhcKMz3nOVhXbidGLPVxR6S317h+b0G16f3H9HKe6F5pjRyQhciFfAXAJVHd1ZDxeNnOFhfw69flzDOqnhNCqujHbFlYRXF1XC8YU8K757jE8YVa048ZJgL5Ei4aLtKF91Gn+jIqJ1U05j3oIbXZtfM7BwWD9DdMyXTkweRBUEbYH6Xfm0Mz2PCGsPB0rRSKuuHUStZuiihIxGnoNgbCY1ZhykAR8zQDm7VHiBRaMwdCTHksjFBEBeSVV7X3ZUugsHlwDJWPvqR0oOBIu4F+cQpDJFOWSJWc1G7xX9+30wJDQ19OOyyHJ/6+U2pdcqy/QNwmz15UY323yvL9Wh8Edzf7GNFsURXoZVP9+b0+Sbx5HqUxotHzLF
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 19:21:26.2466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 138f7cc4-5a76-4e73-7509-08de73d9e78a
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB10134

Hi Luiz, hi Frederic,

On Wednesday, 11 February 2026, 19:30:34 CET, Luiz Augusto von Dentz wrote:
> Hi Christian, Frederic,
>=20
> On Wed, Feb 11, 2026 at 8:17=E2=80=AFAM Christian Eggers <ceggers@arri.de=
> wrote:
> >
> > According to Fr=C3=A9d=C3=A9ric's instruction [1], GATT/SR/GAI/BV-01-C =
should executed
> > with a custom service/characteristic added via bluetootctl:
> >
> > +------------------------+----------+---------+-------+----------------=
=2D--------------------------------------------------------+
> > | GATT/SR/GAI/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothc=
tl':                                                     |
> > |                        |          |         |       |                =
                                                         |
> > |                        |          |         |       | - [bluetooth]# =
gatt.register-service 0xFFFF                             |
> > |                        |          |         |       |                =
                                                         |
> > |                        |          |         |       |   - *yes* when =
asked if primary service                                 |
> > |                        |          |         |       |                =
                                                         |
> > |                        |          |         |       | - [bluetooth]# =
gatt.register-characteristic 0xAAAA read,write           |
> > |                        |          |         |       |                =
                                                         |
> > |                        |          |         |       |   - enter '1' w=
hen prompted                                             |
> > |                        |          |         |       |                =
                                                         |
> > |                        |          |         |       | - [bluetooth]# =
gatt.register-application                                |
> > +------------------------+----------+---------+-------+----------------=
=2D--------------------------------------------------------+
> >
> > With the current PTS, the test is being stuck waiting for on indication=
 on the
> > characteristic with the handle 0x0008:
> >
> > > Please send an Handle Value indication handle =3D '0008'O after enabl=
ed by the
> > > PTS.
> > >
> > > Description: Verify that the Implementation Under Test (IUT) can send=
 handle
> > > value notification to the PTS.
> >
> > According to btmon, this is the "Service Changed" characteristic,
> > which is automatically created by bluetoothd in populate_gatt_service().
>=20
> Hmm, it looks like this was done to avoid manually generating an
> indication, so service changed was used, or perhaps the purpose is to
> test the service changed behavior.

Yes, using an already existing "standard" characteristic which can generate
indications may be the reason for using "Service Changed".

>=20
> > bluetoothd[511]: < ACL Data TX: Handle 24 flags 0x00 dlen 27           =
                                                               #36 [hci0] 1=
187.212787
> >       ATT: Read By Type Response (0x09) len 22
> >         Attribute data length: 7
> >         Attribute data list: 3 entries
> > ...
> >         Handle: 0x0007
> >         Value[5]:
> >         20 08 00 05 2a                                    ...*
> >             Properties: 0x20
> >               Indicate (0x20)
> >             Value Handle: 0x0008
> >             Value UUID: Service Changed (0x2a05)
> >
> > It looks like the testcase doesn't use the characteristic (0xAAAA) set =
up via
> > bluetoothctl at all. Instead it seems to pick up the first characterist=
ic
> > returned by READ_BY_TYPE which has the 'Indicate' (0x20) property.
>=20
> Well it is a Read By Type what is the type? If it is 0x2a05 perhaps
> the intent is test service changed behavior, not an indication of a
> specific characteristic/handle.=20

> Do you register after connecting or
> before? If registration happens before connecting, it would probably
> explain why it fails, as no indication would be sent then.

That is the point! Simply deferring registration of the GATT application un=
til
PTS asks for sending the indication solves all my problems! This works fine=
 with
GATT/SR/GAI/BV-01-C and GATT/SR/GAI/BV-02-C.

Thank you very much for nudging me into the right direction! I'll send patc=
hes
for the qualification documentation tomorrow.

regards,
Christian

>=20
> > After comparing with the instructions for other tests, it looks like I =
need
> > to use 'btgatt-server' for manually sending the notification.
> >
> > Q1: How does btgatt-server interfere with bluetoothd? I guess that both=
 are
> >     listening on the same CID? It looks like btgatt-server has preceden=
ce in
> >     accepting new connections, but how does this work?
>=20
> I would go in the direction of using btgatt-server, that probably
> doesn't know how to handle service changed at all.
>=20
> > Instead of following the bluetootctl based setup, I then ran btgatt-ser=
ver and
> > sent the notification manually. But there is another check in the testc=
ase
> > which disconnects/reconnects the ACL and verifies that the client confi=
guration
> > descriptor has been reset to 0 (GATT/SR/GAI/BV-01-C, no bonding) or bee=
n kept
> > at 2 (GATT/SR/GAI/BV-02-C, with bonding):
> >
> > > 4.8.2 Characteristic Value Indication - by Server
> > > =E2=80=A2 Test Purpose
> > > Verify that a Generic Attribute Profile server can send a Characteris=
tic
> > > Value Indication and that it retains or resets the configured CCCD af=
ter
> > > disconnection and reconnection depending on bonding.
> >
> > After reconnection, GATT/SR/GAI/BV-01-C fails because btgatt-server has
> > exited on disconnect and the consecutive READ_REQUEST is processed by
> > bluetoothd (instead of btgatt-server), where the CCCD handle (cached by=
 PTS)
> > points to another characteristic (which of course doesn't contain the
> > expected value).
> >
> > Immediately restarting btgatt-server can fix this, but it feels like th=
is
> > defends the purpose of this unit test.
> >
> > Q2: Are there plans to implement "manual sending of notifications by ha=
ndle"
> >     in bluetoothd/bluetootctl?
> >
> > In order to process with GATT/SR/GAI/BV-02-C, I modified btgatt-server =
in a
> > way that it accepts further ATT connections after disconnect instead of
> > exiting. Although the PTS test is happy (due to the retained value of t=
he
> > CCCD's value), it feels wrong to me to reimplement the lifecycle of the=
 CCCD's
> > value within btgatt-server instead of testing with the "real" implement=
ation.
> >
> > Any idea how can "improve" execution of this tests?
> >
> > regards,
> > Christian
> >
> > [1] https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/qualifi=
cation/gatt-pts.rst#n1106
> >
> >
> >
>=20
>=20
>=20




