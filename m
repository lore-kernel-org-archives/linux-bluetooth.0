Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD45C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jun 2022 23:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbiFCXFG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jun 2022 19:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiFCXE4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jun 2022 19:04:56 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EC059BAC
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jun 2022 16:04:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m66LCKY/GJI9eJozT9AI+Z0oQVcvHgeJ0/pLrX7pc6cf0anN6HIdU0gYvvQZoSNeZn1GTIWKOskK7U7jCi4IjxXLZeWzUcQzfzjAMcwvJZWcwSx8vINaHc0xaTgGVJ0Pz2K+JmALu1BE8D8+J7cQtwUNegnXBhElRd58A+hT49GHCV2H+s5Bzx2SBimuJ6l/tQJ2DkfFI0wkfs20RzcekX8PlU+qRMTQapGmsA5VUUZ1DUi1sEo94/kZSboaP+DnAFAUl8/XxP8mBTKb18i7UHFwGDgQwdE3kq3U5NkhaP9l9DzHW6GgjNIVvrKHpLbpXOIK36AwcrVTuq6pImNA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hllwRS5Ankq8uqoGSxjpZ5NSL8ToivVQIX2QYIwMu8=;
 b=azswNy2saObUanrQaVKOxBmWZ8eZ2Y/5W5lSv2ngKJ4FYwh9/x1DQtZ0Lw1kmKyBwFSbc50vf7gMCBpGkQr9kVQThUaKRH1yBekvPvvjaQlcIZ9M/b6y2/Go0TyViWX+8caBonEfeEeLEvNa+1PRz1tD7oZSuQkZ6VOW7ff9dttGqDZyP07ZevzlY6uOnixjp3VKdLXLAh90/o1E1rICjuLRxHEzEyCmOEoCKmyOROiQNRb5uRTXxIO8RnjqwygGnFvlzxVAoOfeulRB54hZqMCyGfpt26LjJpUUEvEjkANoPkaR7zrvCMsGzjFtS9zuJYKpF6Rh9/5+fprgsNUKAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sorenson.com; dmarc=pass action=none header.from=sorenson.com;
 dkim=pass header.d=sorenson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sorenson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hllwRS5Ankq8uqoGSxjpZ5NSL8ToivVQIX2QYIwMu8=;
 b=eqEhT2xvScUsb8g8ZjkmVEEsi+kIV+mioFkDvlpR4/JCb67C7eZos0BWdkYWpOhOAdtckSkix2kKwFxCgnNCIo6Y6HakAL5upUVskoKU5ahePddQZy7YL7pQVjvFNdLqknoOD/G17oW1UdjKBBnU9YnQ3Ydx5P9SVmCH4CwPUpz9s06ZEqN2oRVbmrRPFSR3gPAc9zYiLIo/EXpbZKs6cNqBBURgKCLUvW/AkK9zTwZt8pyZs3x9hpp0kwsJXHiDQrSgZIBbUtPsQJsxHTzidlfiMZEnhr844wQWB6kIHHUqtH0yYz0VHejGl1MTquIQ/666EkRMr81FffdSS5p3oQ==
From:   Thomas Green <TGreen2@Sorenson.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: help
Thread-Topic: help
Thread-Index: Adh3niGsx/z95aibShmRq57jmW9xhw==
Date:   Fri, 3 Jun 2022 23:04:47 +0000
Message-ID: <BN7PR04MB526729064E218F91A80228EA9FA19@BN7PR04MB5267.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Sorenson.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea2b19b8-d33b-4ff0-ede5-08da45b574d3
x-ms-traffictypediagnostic: CH2PR04MB7045:EE_
x-microsoft-antispam-prvs: <CH2PR04MB70455EE708C31BC853C757F19FA19@CH2PR04MB7045.namprd04.prod.outlook.com>
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR04MB5267.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(508600001)(2906002)(5660300002)(9686003)(26005)(33656002)(52536014)(30864003)(3480700007)(76116006)(71200400001)(38100700002)(64756008)(38070700005)(66476007)(66946007)(66446008)(66556008)(7116003)(86362001)(8676002)(122000001)(316002)(6916009)(42186006)(8936002)(220243001);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n6kMXEkwmx9YFrxQcG0wAd3gtTcbZiWjNJU33Tvlt3PEdmmzerUP8uk456FVKLGmAtChmCRWQ7oOlzscrMgLz2Rk0K4MliiqecetglNG3i/NymE5qeuyHB+ATvGPda/6YImhwsIV3olyWHnYFsyEQ8wGpTAoAIJQRipBzepBid4ZxulhxVTsQII4vynNo5eNn0y8ZQSw2zJP41cPsJc/5NRQGLI3IQF6+VIaRdE1QrJWl6iryD5hoLPnAlyN75CHIBq710ALbghpzn0toob/EE9e/jgBVC4aAHqNTwvo0E70FB3GthvjQsi5aItUK8Y+05cCOCSyeSVYIW6Y6nkIrZQ0wqMsUHZbnikX5Isp8N3H4hRBh0p62PWvNqnmaylTT9Eea5+3bq6XCdboRLYxqKKBh8cTU7NGeEMSI+VflqtEdAjnvjmt7aNfRdzmT3eAh7C3H9YitYo1IZH5NK0ZwPTaPzifGCL+BIsquysDrPlQyXfYLSpSojhP8NeBPQVLsvEQAlCcNQybAnxkvDy2/fzPQSBSF4hJmXL9nffFg5FhoMbTFjDt/SNfPMjGucWaVjNXCgXveY1IAllCllWSPtTNbIT/1hJW1b0Un1Wl+VSLZbQcTRh2N0oVfSnUbuihHMrwIrYY50OfEbXtdKet2QxlCBg8FL0M+mS9i52tjbwnmOh8cRBjWYyCNSCuNW34yCO3okzAKkWIFqkJZtAfmYNOeh2d9TfnssUBAHeNlcI=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/7EopHjfOVGn7VS/gndEH3dnObJ+K+APR3WWJBYUlxYWoO49x10b7R9xXFU/?=
 =?us-ascii?Q?S7VsELxa+0R0yJo/I1axjQSTxzjdZnKqC94zPvPLDsh2r9FJ9MUL8DAN4agj?=
 =?us-ascii?Q?l1sB11oAOwP8ZYD5YIsxF5384p2ZsS8/UkaQ0AqixHF//QvyG/HsBM3BMgy4?=
 =?us-ascii?Q?ogEZa5y9eVVEk6U9cT+o7lJhryJaRdOZjKgfLnGTqo5VSZD5UY2ixBJ/Wm/f?=
 =?us-ascii?Q?Jj3QD5tRjetwK159vs+t4MBMLH7AkELjVjWm5XTNsAxShha1ke8oipD1R9zk?=
 =?us-ascii?Q?2ABnJOAqGBjhUXSBoVhZIF7AKdEVD3SYlFsRxKwP2R+vAF23tyJOcoxIde+/?=
 =?us-ascii?Q?on+JbmZhpU7+JGVAI5ZQAcZ0jdjU8BQQCpY+Xj4JkCb37IepYBB/6uwSln6n?=
 =?us-ascii?Q?2+vBLBVMECHBCdNmDrYxJ/RNYYf/xTJZvENKPv65eq3KfZ9eEggpHWSyvC0p?=
 =?us-ascii?Q?w5UUkiE2exT4S/2mVlyGuyneBl7cLnjt4TZ02LZwGeoqKSAfoHCCg9fpjAXu?=
 =?us-ascii?Q?j0Pok/zy75HI91mr6UpJPQ4sp4D2mZ2NonF6hx4jukjjCdl27927kBQe1SR7?=
 =?us-ascii?Q?eHzc+CzjGjILvV32oXSZsmazdX/iluSWW++7HgnH+0bzN6jwI6BHmbQhb7PT?=
 =?us-ascii?Q?nhNszU4cNW4cQ74AfFyMwIV3KloRjc5EpIyVWZGefgFH7vbeUwKeEQOuMUID?=
 =?us-ascii?Q?1wAj88F0d6yrRplQ1vjSe4p6U/vdVEdtPHopMaO2GWRB8Z5C23uNv2Bi1hgD?=
 =?us-ascii?Q?HkkiwwY4tV5appM+X757n5O2EtKvVntPTGysv+guS23QBB3H1d9Q5kis6KYQ?=
 =?us-ascii?Q?sMjYR5xscsNT6Ce8axJAXE168QNG6IQXX8ik0G2CtOeiM2Pyw6hIDKtktaVN?=
 =?us-ascii?Q?Lx+t/LD0RDNdYd53aXsloZ+CdKRI0N3oEwgG8vsr/5nE2T3jzBj9oqpvwvyW?=
 =?us-ascii?Q?fwOuzzBBiGzeOYvURb4GAbGs7fQih2yOFCIRQcQfkwUxNnCfnpXf7Cgb6QRd?=
 =?us-ascii?Q?wO2AlpQHq3SNPslMc0B9UJ+5zZlXFnoBwHsq+KPvHrZugd+MLB0lN+8gtMD3?=
 =?us-ascii?Q?aPT/w/aZZRTY+cAhqiqcLU2s7V6Vij2+2agxO7Gy/DUasN8r3da4V/Ww60q7?=
 =?us-ascii?Q?uRoqbNdWpTAmXH6dCiAYXgJ70IgpiN3IFKh6Bbqo5zFH8Rg6aexnTKTCjkUW?=
 =?us-ascii?Q?dlHfM8lu5BqeKgqCMBkVcr+LnH0RACxNZnBQ/rAOq4Q7vgjkwL03O3q5YqBG?=
 =?us-ascii?Q?qdZSpyrYyZTpcogpuN6jib1nXPuwA3PjnMGktiqhk/i1pMcxV9g2KKVcvM23?=
 =?us-ascii?Q?ptfuRZ3YnhKcEC9DjfRPtaRKQZBC452ejh3PH+aHqcWshkQImwiXn35NOWnF?=
 =?us-ascii?Q?rey5ZJ6cHV5WCX8TIP+chg2+M1jlIl1LpIeGTmUvOsJpbgv6Fo6jI7ErFVwy?=
 =?us-ascii?Q?zD6nt6JSfVLY50Cq2JsxyEGCFW2L2w7IAZYRfWwb0Qrk+xHwOWkp/oe2cAhm?=
 =?us-ascii?Q?/CFYGvirn3TCPi5n9zmByBrMnA8TtjImEcGnDHHPIg+BGcnLuvErdCwZJeeg?=
 =?us-ascii?Q?sF7wljC6FJrd0dQaLMw1QRjKEwH3pAsZmuKY98MqpYjTRAtjAU17KzlnWo67?=
 =?us-ascii?Q?DngxRnOlg9IafLLoz1OjtrKZRz11ed/4gTDC+fVaJkZp9DghGKJBkPFzy7hu?=
 =?us-ascii?Q?Sb+B4+voBwx7Ty+FZv8MV7qFRNjpAM/PNVjrs0+Ml7OCMaDfKEQFA7fsgmFL?=
 =?us-ascii?Q?zVgO15Lyvg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sorenson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB5267.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2b19b8-d33b-4ff0-ede5-08da45b574d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2022 23:04:47.7164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d0f7f33f-8d1f-4ac0-bccd-2ecda8bf422b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: disqjR7IndwPNxPvXk3QMV616ZlAZHbHcnpXwH8YoXfU2dq9c0PltT+8qnDTroyAu/B+W2orfyts5rqYHxjRzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7045
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A couple of weeks ago, I posted this question, and haven't heard anything b=
ack.  Is there someone out there that can help me?


Hi.... I have problem when removing a device from use.  I have two identica=
l devices connected to my host.  For each of them I disconnect the device, =
then remove it.  Sometimes it works just fine, and sometimes it seems somet=
hing doesn't finish, and a timeout error is returned.  When it doesn't fini=
sh, I can't do anything any more.  A scan doesn't do anything, and if I try=
 to turn off the scan I get an InProgress error.  Here is a log produced by=
 running=20

bluetoothd -experimanal -debug -n

bluetoothd[3432]: ../bluez-5.50/src/device.c:btd_device_set_temporary() tem=
porary 1
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0bead0=
: device C4:33:13:80:17:20 profile gap-profile state changed: connected -> =
disconnecting (0)
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0bead0=
: device C4:33:13:80:17:20 profile gap-profile state changed: disconnecting=
 -> disconnected (0)
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:dev_disconnected() Device C4:=
33:13:80:17:20 disconnected, reason 2
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:adapter_remove_connection()=20
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:adapter_remove_connection() R=
emoving temporary device /org/bluez/hci0/dev_C4_33_13_80_17_20
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_remove() Removing devic=
e /org/bluez/hci0/dev_C4_33_13_80_17_20
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0bead0=
: device C4:33:13:80:17:20 profile gap-profile state changed: disconnected =
-> unavailable (0)
bluetoothd[3432]: ../bluez-5.50/profiles/gap/gas.c:gap_remove() GAP profile=
 remove (C4:33:13:80:17:20)
bluetoothd[3432]: ../bluez-5.50/src/service.c:btd_service_unref() 0x55fffe0=
bead0: ref=3D0
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0b4dc0=
: device C4:33:13:80:17:20 profile :1.70/ntouch/app/6e400001-b5a3-f393-e0a9=
-e50e24dcca9e state changed: connecting -> disconnected (-103)
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_profile_connected() :1.=
70/ntouch/app/6e400001-b5a3-f393-e0a9-e50e24dcca9e Software caused connecti=
on abort (103)
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0b4dc0=
: device C4:33:13:80:17:20 profile :1.70/ntouch/app/6e400001-b5a3-f393-e0a9=
-e50e24dcca9e state changed: disconnected -> unavailable (0)
bluetoothd[3432]: ../bluez-5.50/src/gatt-database.c:profile_device_remove()=
 :1.70/ntouch/app/6e400001-b5a3-f393-e0a9-e50e24dcca9e removed
bluetoothd[3432]: ../bluez-5.50/src/service.c:btd_service_unref() 0x55fffe0=
b4dc0: ref=3D0
bluetoothd[3432]: ../bluez-5.50/src/device.c:btd_device_unref() Freeing dev=
ice /org/bluez/hci0/dev_C4_33_13_80_17_20
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_service() Remo=
ving GATT service: /org/bluez/hci0/dev_C4_33_13_80_17_20/service000a
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_service() Remo=
ving GATT service: /org/bluez/hci0/dev_C4_33_13_80_17_20/service000b
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_characteristic=
() Removing GATT characteristic: /org/bluez/hci0/dev_C4_33_13_80_17_20/serv=
ice000b/char000c
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_descriptor() R=
emoving GATT descriptor: /org/bluez/hci0/dev_C4_33_13_80_17_20/service000b/=
char000c/desc000e
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_service() Remo=
ving GATT service: /org/bluez/hci0/dev_C4_33_13_80_17_20/service000f
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_characteristic=
() Removing GATT characteristic: /org/bluez/hci0/dev_C4_33_13_80_17_20/serv=
ice000f/char0010
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_characteristic=
() Removing GATT characteristic: /org/bluez/hci0/dev_C4_33_13_80_17_20/serv=
ice000f/char0012
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:notify_client_unref() own=
er :1.70
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:notify_client_free() owne=
r :1.70
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_descriptor() R=
emoving GATT descriptor: /org/bluez/hci0/dev_C4_33_13_80_17_20/service000f/=
char0012/desc0014
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_characteristic=
() Removing GATT characteristic: /org/bluez/hci0/dev_C4_33_13_80_17_20/serv=
ice000f/char0015
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:notify_client_unref() own=
er :1.70
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:notify_client_free() owne=
r :1.70
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_descriptor() R=
emoving GATT descriptor: /org/bluez/hci0/dev_C4_33_13_80_17_20/service000f/=
char0015/desc0017
bluetoothd[3432]: ../bluez-5.50/attrib/gattrib.c:g_attrib_unref() 0x55fffe0=
c3bf0: g_attrib_unref=3D0=20
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_free() 0x55fffe0b99d0
bluetoothd[3432]: ../bluez-5.50/plugins/policy.c:disconnect_cb() reason 2
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:bonding_attempt_complete() hc=
i0 bdaddr C4:33:13:80:17:20 type 2 status 0xe
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:resume_discovery()=20
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:connected_callback() hci0 dev=
ice C4:33:13:80:17:20 connected eir_len 23
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_create() dst C4:33:13:8=
0:17:20
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_new() address C4:33:13:=
80:17:20
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_new() Creating device /=
org/bluez/hci0/dev_C4_33_13_80_17_20
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:dev_disconnected() Device C4:=
33:13:80:17:20 disconnected, reason 2
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:adapter_remove_connection()=20
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:adapter_remove_connection() R=
emoving temporary device /org/bluez/hci0/dev_C4_33_13_80_17_20
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_remove() Removing devic=
e /org/bluez/hci0/dev_C4_33_13_80_17_20
bluetoothd[3432]: ../bluez-5.50/src/device.c:btd_device_unref() Freeing dev=
ice /org/bluez/hci0/dev_C4_33_13_80_17_20
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_free() 0x55fffe0d5640
bluetoothd[3432]: ../bluez-5.50/plugins/policy.c:disconnect_cb() reason 2
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:bonding_attempt_complete() hc=
i0 bdaddr C4:33:13:80:17:20 type 2 status 0xe
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:resume_discovery()=20
bluetoothd[3432]: ../bluez-5.50/src/device.c:btd_device_set_temporary() tem=
porary 1
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0bcbe0=
: device C4:53:23:00:38:10 profile gap-profile state changed: connected -> =
disconnecting (0)
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0bcbe0=
: device C4:53:23:00:38:10 profile gap-profile state changed: disconnecting=
 -> disconnected (0)
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:dev_disconnected() Device C4:=
53:23:00:38:10 disconnected, reason 2
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:adapter_remove_connection()=20
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:adapter_remove_connection() R=
emoving temporary device /org/bluez/hci0/dev_C4_53_23_00_38_10
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_remove() Removing devic=
e /org/bluez/hci0/dev_C4_53_23_00_38_10
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0bcbe0=
: device C4:53:23:00:38:10 profile gap-profile state changed: disconnected =
-> unavailable (0)
bluetoothd[3432]: ../bluez-5.50/profiles/gap/gas.c:gap_remove() GAP profile=
 remove (C4:53:23:00:38:10)
bluetoothd[3432]: ../bluez-5.50/src/service.c:btd_service_unref() 0x55fffe0=
bcbe0: ref=3D0
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0b3770=
: device C4:53:23:00:38:10 profile :1.70/ntouch/app/6e400001-b5a3-f393-e0a9=
-e50e24dcca9e state changed: connecting -> disconnected (-103)
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_profile_connected() :1.=
70/ntouch/app/6e400001-b5a3-f393-e0a9-e50e24dcca9e Software caused connecti=
on abort (103)
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0b3770=
: device C4:53:23:00:38:10 profile :1.70/ntouch/app/6e400001-b5a3-f393-e0a9=
-e50e24dcca9e state changed: disconnected -> unavailable (0)
bluetoothd[3432]: ../bluez-5.50/src/gatt-database.c:profile_device_remove()=
 :1.70/ntouch/app/6e400001-b5a3-f393-e0a9-e50e24dcca9e removed
bluetoothd[3432]: ../bluez-5.50/src/service.c:btd_service_unref() 0x55fffe0=
b3770: ref=3D0
bluetoothd[3432]: ../bluez-5.50/src/device.c:btd_device_unref() Freeing dev=
ice /org/bluez/hci0/dev_C4_53_23_00_38_10
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_service() Remo=
ving GATT service: /org/bluez/hci0/dev_C4_53_23_00_38_10/service000a
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_service() Remo=
ving GATT service: /org/bluez/hci0/dev_C4_53_23_00_38_10/service000b
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_characteristic=
() Removing GATT characteristic: /org/bluez/hci0/dev_C4_53_23_00_38_10/serv=
ice000b/char000c
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_descriptor() R=
emoving GATT descriptor: /org/bluez/hci0/dev_C4_53_23_00_38_10/service000b/=
char000c/desc000e
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_service() Remo=
ving GATT service: /org/bluez/hci0/dev_C4_53_23_00_38_10/service000f
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_characteristic=
() Removing GATT characteristic: /org/bluez/hci0/dev_C4_53_23_00_38_10/serv=
ice000f/char0010
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_characteristic=
() Removing GATT characteristic: /org/bluez/hci0/dev_C4_53_23_00_38_10/serv=
ice000f/char0012
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:notify_client_unref() own=
er :1.70
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:notify_client_free() owne=
r :1.70
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_descriptor() R=
emoving GATT descriptor: /org/bluez/hci0/dev_C4_53_23_00_38_10/service000f/=
char0012/desc0014
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_characteristic=
() Removing GATT characteristic: /org/bluez/hci0/dev_C4_53_23_00_38_10/serv=
ice000f/char0015
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:notify_client_unref() own=
er :1.70
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:notify_client_free() owne=
r :1.70
bluetoothd[3432]: ../bluez-5.50/src/gatt-client.c:unregister_descriptor() R=
emoving GATT descriptor: /org/bluez/hci0/dev_C4_53_23_00_38_10/service000f/=
char0015/desc0017
bluetoothd[3432]: ../bluez-5.50/attrib/gattrib.c:g_attrib_unref() 0x55fffe0=
ab990: g_attrib_unref=3D0=20
bluetoothd[3432]: ../bluez-5.50/src/device.c:device_free() 0x55fffe0bc500
bluetoothd[3432]: ../bluez-5.50/plugins/policy.c:disconnect_cb() reason 2
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:bonding_attempt_complete() hc=
i0 bdaddr C4:53:23:00:38:10 type 2 status 0xe
bluetoothd[3432]: ../bluez-5.50/src/adapter.c:resume_discovery()=20
bluetoothd[3432]: ../bluez-5.50/src/device.c:btd_device_set_temporary() tem=
porary 1
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0b9880=
: device C4:53:23:00:56:A0 profile gap-profile state changed: connected -> =
disconnecting (0)
bluetoothd[3432]: ../bluez-5.50/src/service.c:change_state() 0x55fffe0b9880=
: device C4:53:23:00:56:A0 profile gap-profile state changed: disconnecting=
 -> disconnected (0)


If you could help me figure out why it works in once instance and not the s=
econd, I would very much appreciate it.

Tom Green

