Return-Path: <SRS0=1Mik=OM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6E4C04EB9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Dec 2018 18:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25335208A3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Dec 2018 18:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25335208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efji.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbeLCSDP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:03:15 -0500
Received: from mail-eopbgr690093.outbound.protection.outlook.com ([40.107.69.93]:34530
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726721AbeLCSDP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Dec 2018 13:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=EFJI.onmicrosoft.com;
 s=selector1-efji-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbhp0RnWeR+TXaVI/YTozwQauD2ShLfFczUTPbxg1iM=;
 b=YcCWNSoXRmW6SpppCc3gsUVmotYg5Fvf8Hj2BI93DhWt42esP4/EH59qo+P3xNFrG+Hjr+bTYj4j7npd5VLp01hAAIEkRfoRKO/TNpXZ3a8KPryukLolIm6xAuXjyQ9QBfnLbTnNoGgAxeVNzOwcuxc5IFemjPYVpamsTgK+KKE=
Received: from BN6PR19MB0050.namprd19.prod.outlook.com (10.161.155.161) by
 BN6PR19MB0003.namprd19.prod.outlook.com (10.161.155.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 18:03:07 +0000
Received: from BN6PR19MB0050.namprd19.prod.outlook.com
 ([fe80::8d97:d6ea:d8e2:bd75]) by BN6PR19MB0050.namprd19.prod.outlook.com
 ([fe80::8d97:d6ea:d8e2:bd75%4]) with mapi id 15.20.1361.022; Mon, 3 Dec 2018
 18:03:06 +0000
From:   Trevor Sutter <TSutter@efji.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: BlueZ 5.50 not including GATT and GAP UUIDs in SDP list
Thread-Topic: BlueZ 5.50 not including GATT and GAP UUIDs in SDP list
Thread-Index: AdSLMk7ydVE6nmirQDOeRF9L0XwGhw==
Date:   Mon, 3 Dec 2018 18:03:06 +0000
Message-ID: <BN6PR19MB0050F4179F4EF725CF779C3DD0AE0@BN6PR19MB0050.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=TSutter@efji.com; 
x-originating-ip: [104.218.82.33]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR19MB0003;6:T6hpO3KC4h6kScSymNLoASdwOXTFIDqGdn4tGhh3PbNTylNKicy8i24zYYM7ZH64AkSNxIvY4zpvhezMSnuywMyM/e8tSegmZuNeXpsocYS4gnVESK9CMNiTK2ylIPBKnomGZmnwJ0CKf1uJiwpwY6iRAj/hMjklY6fIuZ3ckS//+rDNVETGSllAslXOEKXGF5E2enwG0rmsdDPRLZqZecFbkhAYosyx40LmtilBtBJ8tGXGKsvX8gE92sbBkt5EBK/6HcnCKu9y8jGDE1IelsPjzHPaZm0g9JjUcPOpxbLYvHF/DuavJxl32C6zI+VmzKxkH5VU9a8xfHFtBloqHfrQgBAYDYEqV2WMCAQRMwxjfrQvoem/j/ChFbUkEw7YlOT7FK6hzNuVEC+2bOOB+YpAmaalp4HJ45bGWK1eAWDjSzk6EfXuYUPcuZzrOd//p0pNoPZ+A3RdlAPMMHrlyw==;5:IfFc1pOEeJ2fOX8jivlS3v1x7nXXzp0/dxl12InUrvdjoQrPpxaWVyydLlaOZ0hKQg+JrX6b5Q3ZVTScA018Dyt1Q4Px0j5Aray7qjDrSLUI0oVaSBYA0/s2PeIrzzv+zGw2ygfahw+Mc8sldwrkahpKTYxLNZYEEJRWmn77tR8=;7:OwXqaPywgBee9r5DhaRKE/C3Ju/WRSFWhZomqHnuc4YNyPX/Phv2BBorfwM7MEqxDR5YAnRb/rCE661TOWyW8J+gp3x+durdq8kPQT9FvCKwuB6WsZN91/CfuvufDZuy2h7gGaXu5KGJHRaEEMEpsw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 30b20b7a-75cd-468f-6e57-08d6594993f9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR19MB0003;
x-ms-traffictypediagnostic: BN6PR19MB0003:
x-microsoft-antispam-prvs: <BN6PR19MB0003B7B785050BC8ED5D2948D0AE0@BN6PR19MB0003.namprd19.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR19MB0003;BCL:0;PCL:0;RULEID:;SRVR:BN6PR19MB0003;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39830400003)(366004)(396003)(136003)(199004)(189003)(8676002)(5640700003)(102836004)(68736007)(33656002)(7736002)(105586002)(2351001)(71190400001)(2501003)(305945005)(316002)(71200400001)(6916009)(106356001)(7696005)(66066001)(5024004)(14454004)(14444005)(256004)(97736004)(99286004)(3846002)(6116002)(2906002)(26005)(478600001)(186003)(72206003)(6506007)(80792005)(53936002)(8936002)(74316002)(81156014)(86362001)(55016002)(81166006)(9686003)(5660300001)(486006)(25786009)(476003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR19MB0003;H:BN6PR19MB0050.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: efji.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oTEwdWWwkZtdOQRnEfZBnNdeFunkDArelNk113sZijhFFHrzW+jArY1ipbT4UX/UJ8Edar5/7dzC4C5JuVCzMx8r1L5l7Br8xU5zpnjZBwpuuEcQhxXogWUTESPnD6EQj8LgMHdT2mdLwuUgLbedP8lPXQ8trwnRT/NA8CXqLDqdeN9HzfxzmmOGKCYyyV7wFj1/2cxr3OT081z/GDlfQkxycOhegDlYTCQkIMi0wvFW7vnHmpnQykBbbYJ8bCUFz00x0Z/qtD8rh38o7te1YGaU8xz0cpReLCr88BkQVmZP/EZOVhZGlwdjKxEEfgqro6LfcuiqWdVVdRp4vfSkcNIb6T77m3wkpEm7x7a2jag=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: efji.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b20b7a-75cd-468f-6e57-08d6594993f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 18:03:06.7867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0abba84c-a07e-4441-8e32-37e0cdaa4220
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR19MB0003
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I am using BlueZ 5.50 on Linux 4.12.0 running in dual mode (BR/EDR and BLE)=
.

I recently upgraded from Bluez 5.46 and after doing so, I noticed that the =
GATT (1801) and GAP (1800) UUIDs are no longer getting added to my SDP list=
.
I looked through the source file history and, as far as I can tell, changes=
 made to /src/gatt-database.c for commit 109b9fa51bfcd8d15143003729cf4c730c=
39fe72 (gatt: Add all services as records) are responsible.

On startup we call:
btd_gatt_database_new() , which calls register_core_services() and gatt_db_=
register(), respectively.

register_core_services() needs the gatt_db_service_added() callback to be r=
egistered by gatt_db_register() in order to add the GATT/GAP services to th=
e SDP list, since it is called first, no callback is executed.

See the following call stack:

register_core_services
populate_gap_service/ populate_gatt_service
gatt_db_service_set_active
notify_service_changed -> gatt db will not be in the notify_list, no callba=
ck.

I am not very familiar with the gatt/db code in BlueZ, but as a quick test,=
 I inverted the order of the register_core_services() and gatt_db_register(=
) calls and I now have the GATT and GAP entries in my SDP list.

I would like confirmation that this is actually a bug, and that I do not ha=
ve something else misconfigured.
And, if it is a bug, I would appreciate input on whether or not this is the=
 correct fix.

Thank you,
Trevor Sutter
This e-mail transmission, and any documents, files or previous e-mail messa=
ges attached to it, may contain confidential information. If you are not th=
e intended recipient, or a person responsible for delivering it to the inte=
nded recipient, you are hereby notified that any disclosure, distribution, =
review, copy or use of any of the information contained in or attached to t=
his message is STRICTLY PROHIBITED. If you have received this transmission =
in error, please immediately notify us by reply e-mail, and destroy the ori=
ginal transmission and its attachments without reading them or saving them =
to disk. Thank you.
