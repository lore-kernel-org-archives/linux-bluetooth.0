Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36EECCA487
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 20:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354370AbiFUUXi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 16:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354340AbiFUUX1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 16:23:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E6813F72
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 13:23:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+QYcTFTKXOdlY5FElRghUTcyxDrm69WGa0mfJsQhzdS7QJX7fQP5U9AeWeI/izSeQhZY9nt9Df4O8VjSB/FXYNO/5QjtH37W/lqXgWX/oI/NCKSMdG1qGz4LpSax6sABrfFD6/qXhHwU8+xQobJ8CON1miIwlKbNEglBn8tBFwtK5JEt85W+lfC7G7V3FAEEolugsDOw9x472laYs+14VAaoG0g51pPaeEukaNoqmE/cVWOTzEnGlVnxf90/uEedAf2JfP9ASWc1B+LqSY/3d6ANPPeiY1KJQPAmuV8Iy4yIMSPD5x6kFne7rC4DJ3Q97p0IH4BjKe0yULfdrjp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLpZYCYWNnsevchmjfWi/x4S8AfGAUTCQiel5tMcaOE=;
 b=l7CMW2xA1UhpMnwfjyOLzGQ3n9D1PgoqLWQXmcb2xI72TsyOUyr0eJoHR1BRHCc4W0QYbwpP2KKQBW/G0VAOEpkYt+srsqF3RaheHc6/68eKH5dI5BLobZeRtYL8xtFI4WOya8dx1Gzf1GCj6TSWtyuYiMZAB9XPyLpXOC7/DV5g4eTuTK5ftRnaL/rKT/QCdXyADGyaXNtNIUwfbK7gpUp8ftNRf247VQLWgPpmtg4RXYs1N8pTooiP3Z21uRFFxI/2qtDz5D+FMeY/zz3dVBr1iQBz0WnCy5ppF0qQZibQVCAoWLThpckD3x4ZMzQbGeiOAMieWM35xjLA34kmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sorenson.com; dmarc=pass action=none header.from=sorenson.com;
 dkim=pass header.d=sorenson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sorenson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLpZYCYWNnsevchmjfWi/x4S8AfGAUTCQiel5tMcaOE=;
 b=h/TvdKv+AMEBnI4kJltmT8czSKVw7sbjgdYU+uNfpW8b7sr7V0QJcXelTNPXOdGZ7njCS12gGgt8H8fWdmwbnVkWOGU0hXvdvHn89LpRsWIgP2MCzSFdSMn2lahD7DEKI9+ns0XLfBCTCwwuTwfyRK6Fpn07xiV+klGEvpvqrvcUtZ0Nq6doqsKz75MDPFyMwA6WaoWka/VHel1Fez6KlcdArYAa1EsOmFvBbPhB3V7TErLckptXndQa+8YmF3frDaJF3kbwXcjtSrAb7OjOMOI0QQPwUMT0f9c6pAcmQZVx/WBHSimSAEjyW6Hpv7l3m77JQfH4zioAl0xihZ2zdg==
From:   Thomas Green <TGreen2@Sorenson.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: third time
Thread-Topic: third time
Thread-Index: AdiFqz19yiGChj+TQGudncH0+5ea3Q==
Date:   Tue, 21 Jun 2022 20:23:19 +0000
Message-ID: <BN7PR04MB52674E1CAADA5B0550C3F6959FB39@BN7PR04MB5267.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Sorenson.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf58d8a6-c3a1-47ff-231d-08da53c3e175
x-ms-traffictypediagnostic: DM6PR04MB5081:EE_
x-microsoft-antispam-prvs: <DM6PR04MB508135BFD08CB8F5FA6216789FB39@DM6PR04MB5081.namprd04.prod.outlook.com>
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR04MB5267.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(376002)(136003)(346002)(396003)(366004)(8676002)(3480700007)(66446008)(122000001)(66556008)(66476007)(186003)(76116006)(71200400001)(66946007)(26005)(9686003)(7116003)(6916009)(64756008)(41300700001)(316002)(478600001)(19627235002)(33656002)(38100700002)(2906002)(42186006)(38070700005)(86362001)(52536014)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vrY92AhtE4nswjyUbDBLW1p1pvBMfCg+yqMXTnNXt+q8cV8S4JKkPng7lipLoe5z2JpuVZRDnjWFCPz2SM4cjcvnS1JsOrWoZmZT5WTg3m8B4aEHst4z4p7+If0fIh6RR20gua9MSVEHAvR25yDE+0ZIL2IpsPmtZy8cEwBjS8OdwCckX1uHNpDutBcj+p7qLnwQW1cNPHqx9pGNWm0L3tczFsAW024cuH1MNOTE1PP03I8us3qNPmzzdYooDnvOah0/iJNsen6wJHHk9pr/mwo+gXKCnGtzijTOkPVaJtbyWNOKUMThjZ0OQM7qC6M845NrSMduYZiwGrZ7p42SdFSfZwFLScsOzfcgQQe0kl0u8Wp+/q+cxgP9EeJwkSrHi2QGxroUpwj1jK0iiIYt8xlH0yq3rCYwX9tlifkRQJBwZFsVQ0B7Cle+lZ+bErKJVwevKE0SYSgXYOK8oK4xGAqmzoyZMRq77CodQNEHyzkuVy7tYGa0Eoumk80YRTEHbx0gPop/lBB5Xe9sYPK4pbND9HMGAQGTPwuoW/yGKoGtV/mGhf7PkaOrAAbJga5OeIhvoNoTQ/YIZG3A1jFvqi6pJGB3HwlzqrmLGQRXfhl6TXU9l91RORHENf3aa34lrtDWNine00Ivj16VatYbeVJ0k+LOQqvDu67fBZ8ZG4OmNEVDFOBXmQGqfK8YgJ4ExQEeNAtAi1yy8hycLjQj6Q==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5PzcXv3OvCn1MgZE2qPMunm77Qz4aN9JHJVc0QtEwzRbrvlWl+H7v58hu9Kr?=
 =?us-ascii?Q?sGKajsdLqh9hLvY5tO2g4HItN+BY0bcYF187ONcLV+qgyvpSs7ui8iMX6Wb1?=
 =?us-ascii?Q?ScANPyXtVpqnOZ+lnSuftaygfjq/YJZC9sxdFilWib9aiRXBlVmlHyuW+blc?=
 =?us-ascii?Q?9xafo9sssjYKlgfPPKk6+P5wm8YW9iYRDHqk4UdPxjxwVWt5CVQFKa7hi5F+?=
 =?us-ascii?Q?RbUFbXfa7e1WssaEiBkETnhDpGNigebYXrZF/WCn8O9Ius/GKnXYAmEe3Cry?=
 =?us-ascii?Q?9w2lod21LTNSGb3tt4pJMp4temDvGctnnN+Bit8JiV2sD+fZOdM4bGNrnQ40?=
 =?us-ascii?Q?SHOnvAtuR28W3KAjEAiH191DOiCzbXkUSEP60KPlqLi/EVC+k1obZFfwcQiU?=
 =?us-ascii?Q?dSFI2YUVic6GzvjU/rESf/38XbW7vU2URz+kX9kkFYrGiZtqXg24oz45+mof?=
 =?us-ascii?Q?ql+u/JDNQpILPD16cGLy/ECY10et5LdKosO+Kz856Eyqu8NCFk9wNygoYg+3?=
 =?us-ascii?Q?uTERZjLKMyGeD4PhKnkoSi2JAoXyESwesmIQgkn0lU/nDN/z95yhoTusHi6u?=
 =?us-ascii?Q?NJkEPpmCXW9kVn0zHZ8JxeWH9r9VklUL/WpN8IA5onhpTfWU0Ceeh0LvAhJj?=
 =?us-ascii?Q?KUGCZX4PRvRdbReDTutOAsy4Oh07RPnIeG+4hd9CsCvbhCdaIJZ0TglBnDq2?=
 =?us-ascii?Q?A6Yv5NAm0Sej0x0ML+HxNxM3z547LBYyEP93hLP1aM55R+DlM9bJimtvw8GS?=
 =?us-ascii?Q?wViIfFYtiTF1yoBZyYmgTIfQIAtvkMEFr1jmVOPGc1Mh+u/peDGNSdIet33j?=
 =?us-ascii?Q?HMtK9+8PBvkyFBeTe48xEH5mdRQ4QexqK4KeHv44MbQpQNSEyrXqTtn7zkEV?=
 =?us-ascii?Q?pVaLmTHJFF513gQH+/dTJMO6K9xVDJYwz+7UzukHIL3dfCX06atZkpIrG737?=
 =?us-ascii?Q?QCo+TBVWJEmWmMLrpYn2mMY1SLcK8/+d9Q8fTaYpOO4KxJDXJln+iCaP3zea?=
 =?us-ascii?Q?H3pVW4nmnvVrbJW3jiyXA2yoqBqVcR4hipVtFZCuFJrsctcV2M3b8xfVTuiw?=
 =?us-ascii?Q?SGBqxNev6jR66VAWk9X73lzIBoS8k09+0jgKAhSiJ5OIfo//i19OaBHnopbK?=
 =?us-ascii?Q?/jxBTEJeBGsAJzQeTEExpOVxfKoP1bYlJP57q2WXIa75btlYZ6QhnawrEIph?=
 =?us-ascii?Q?EltLcNZsK563MljXTDwjucINKjgMQawiUGbd+TDnVSgEWsxk0ZmAhRXmG0yS?=
 =?us-ascii?Q?cjIJXGnjnizGOt70nkpuTaeg/hZt+FERUbMe1h9/BBCTrlRdmyai2NJw/XCX?=
 =?us-ascii?Q?wLC5Ot5pmgvp0trMK74Bx6gm4RDLo1WKc6CK6Ww/WpRGnOLdCt/XKtyo8fJc?=
 =?us-ascii?Q?yDSH88sFZgqBvKfrHO2tv6G39K5O+C+p1IiwtQrmbDJ0P9Z6VW8IF7ILFEpE?=
 =?us-ascii?Q?h6RD9ONdCFpf2sKm4s7StnJAH0SPZWJ5iZsj4tneGoY7dycVWki1jdJhL0Ye?=
 =?us-ascii?Q?x/yfY8UkDQ0vw5Vorir7v/335JKkdApD/awInlt+gTIuR6XeaiUu5l1ts1su?=
 =?us-ascii?Q?KFdvROGS8HCn9nTIHJkxHFAo8mYV+fsMH0MbHkEdnXEPcunfJvZasJ+Vn/7K?=
 =?us-ascii?Q?HQgJUm0PIdTdzOhkMRMc8D0a8l1YAHjhrTTYit+r7ehLZmq/+T97BLuuXVYW?=
 =?us-ascii?Q?2P4xyGbEEMITdFwpjqzY/MXZvwtzH0cQSpAtOuR56nHA69UYkDpUCDSUq0aw?=
 =?us-ascii?Q?gWMhXufFdA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sorenson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB5267.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf58d8a6-c3a1-47ff-231d-08da53c3e175
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:23:19.2312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d0f7f33f-8d1f-4ac0-bccd-2ecda8bf422b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QlibCE6L3sRaJmoXpRPC6pkBklb+bm711P0inG2RYHm6pW0h91c4cgNK7vcUxwiNdHfPxsbkn7RgGRckVewISw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5081
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I've twice before written about this issue I'm having, but never heard anyt=
hing back.  It regards a GATT device that connects and operates correctly. =
 The issue is when we call the Adapter1.RemoveDevice method for this device=
.  Some times the device is removed completely, and everything works fine. =
 Some times it fails and bluetoothd becomes unusable.  Even when I shutdown=
 and restart bluetoothd it doesn't operate correctly when restarting.  The =
difference is that when it works, at the end of the removal process, it rec=
onnects the device, tries to recreate the device, then removes it.  All int=
ernally.  When things fail, those steps don't happen.  I've posted before t=
he salient part of the Bluetooth log.  The only thing that will make blueto=
othd function correctly is to shut it down, remove all of the similar GATT =
devices, then restart bluetoothd.

I have yet to hear if anyone has -any- idea regarding this, not even to tel=
l me it's not something that needs to be looked at.  It is something that r=
enders bluetoothd unusable, so I would think that it is something that migh=
t be interesting to look into.

If anyone has any ideas where to look, or what might be going on, I'd love =
to hear from you


Tom Green
