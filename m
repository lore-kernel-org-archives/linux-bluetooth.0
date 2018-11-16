Return-Path: <SRS0=Z/iR=N3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BB8C43441
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 10:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6622820892
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 10:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=TelevicGroupnv.onmicrosoft.com header.i=@TelevicGroupnv.onmicrosoft.com header.b="YQknggE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6622820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=televic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeKPUtm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:49:42 -0500
Received: from mail-eopbgr20125.outbound.protection.outlook.com ([40.107.2.125]:17050
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727543AbeKPUtm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Nov 2018 15:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=TelevicGroupnv.onmicrosoft.com; s=selector1-televic-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUeuHmLfpNqFvTF9bJlMpfb2oI7/efaXiGZJxtxC11U=;
 b=YQknggE1VyGnZwjLl1ikWav5x6A2rKftT7VjW7kTMAG3AXsqdVeH+pLuNgJ7VbnOiZg3TTMK1YJPF5NovsVoxjHJQ6ZYjSAfV7jNUakAOWcPjzUwoGBU9FQBPXJDbqd5L/WPP8djRu18RlNucvCSA7C5iy9J0BB8ZWuRwZkUIS0=
Received: from DB7PR07MB5785.eurprd07.prod.outlook.com (20.178.105.90) by
 DB7PR07MB4825.eurprd07.prod.outlook.com (20.178.40.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.15; Fri, 16 Nov 2018 10:37:51 +0000
Received: from DB7PR07MB5785.eurprd07.prod.outlook.com
 ([fe80::4c7f:aca9:7f62:23e0]) by DB7PR07MB5785.eurprd07.prod.outlook.com
 ([fe80::4c7f:aca9:7f62:23e0%5]) with mapi id 15.20.1339.021; Fri, 16 Nov 2018
 10:37:51 +0000
From:   Vieren Frank <F.Vieren@televic.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: BlueZ - HCI adapter address via ioctl(hciSocket, HCIGETDEVINFO,
 &devInfo) doesn't match address via DBus for Adapter1.address
Thread-Topic: BlueZ - HCI adapter address via ioctl(hciSocket, HCIGETDEVINFO,
 &devInfo) doesn't match address via DBus for Adapter1.address
Thread-Index: AdR9l4TJB3saVVIcT4a2M0KLQ+3sQA==
Date:   Fri, 16 Nov 2018 10:37:51 +0000
Message-ID: <DB7PR07MB57856A83E042E478FF972A1E9ADD0@DB7PR07MB5785.eurprd07.prod.outlook.com>
Accept-Language: nl-BE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=F.Vieren@televic.com; 
x-originating-ip: [84.199.255.188]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR07MB4825;6:YQTX5rB0Ffez4dcRkKKBrjulPdN5+wWaLkbGJW/cg6PHKAq6mBHW//pFufdAGEo7WeREe777e4FatRBj0qx7EUQGXsMztyJw6dGyUtQOYLOiL19N8wzJpuQPikcIxCZ1mKmW2vzePGW3RLhpJx9wEWD/FlNyo5y2v2BEGzoTS+aUUlk6p8AU7aS3QQpE0HuI7sevATxrcKSMLr3ZfY9newknbO61iLIYyaXh/Z+YvgjF2eSEvxVc1fo510krZOLZ4tsxrVg39pslndNwfPsPZImQ87epxfWPeMFdyKFpsOjp/G3cQhP49nBlu3G8SxaaN9Lk8kuq6PD82Fkr5zcLc9TNSyFV1IsJM6cPJFhS16tsZqrlbfx+DfixBW09roUVwCirO1Oi3BePj9c2uy+L3B1fBtEC9WLjmFkSDS6kdv+l+K5ZBi+2LyCtKJlf2NODyrsZrrzvb/RuGXqmAWat9Q==;5:9K+dFiEDOIufFjnG4nnm32JjEtoqlAht70E5lGew6UW2qob6AIGqg+kIzYBy3UNMFjMg4uueMU326Sra9FQ3NcWsYUHytOTvA1i/kXUI9aB+sI6drnMBvLKYVZFLLnNhrq07j7VIdSD6fkgXncqYG/SlHHosLA8tGtX2Qj/onZE=;7:MqvQX7ijib/FEqBW+2IBpBaUUot3aXHoxw89YW5ZIvklBI3ZN47XvD8qCEjiY4w8Hd5HXNMRBAjMHevJsR/wBuzBE9IkUlh2012hUlSrtlqTtGmhM2gDWsoImljxcT7MywX9jWCQ9TujBaZFHiJBTA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2120f374-c1d2-4288-bc1f-08d64baf8f2e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR07MB4825;
x-ms-traffictypediagnostic: DB7PR07MB4825:
x-microsoft-antispam-prvs: <DB7PR07MB4825EE5A7AA8296FE477F5109ADD0@DB7PR07MB4825.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231415)(944501410)(52105112)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB7PR07MB4825;BCL:0;PCL:0;RULEID:;SRVR:DB7PR07MB4825;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(136003)(346002)(366004)(376002)(51874003)(189003)(199004)(6506007)(8936002)(33656002)(8676002)(66066001)(105586002)(486006)(256004)(102836004)(81156014)(2351001)(6916009)(106356001)(81166006)(26005)(2906002)(7696005)(5660300001)(99286004)(476003)(9686003)(68736007)(71190400001)(6306002)(2900100001)(14454004)(25786009)(53936002)(305945005)(7736002)(74316002)(316002)(6436002)(478600001)(72206003)(86362001)(55016002)(97736004)(5640700003)(71200400001)(6116002)(966005)(3846002)(2501003)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR07MB4825;H:DB7PR07MB5785.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: televic.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DgZ9btB5UFwDxCuEJDYCkzvmPIHPFd804VBVaECBKgdeNgsFRspkHt84dFS4S7ywhJxkD0A5mRV8ZTUj6Gg4gLgFSqZ6ctkAERhrBf+TkLQN8iPoohKIYvBlTqETRke34mbwrOlv+jPQlu1KmM0y+zDZ/HWjOd5UQUja8DY58nmhN/5aVgjHtvNoDCmT96/7WMpcnxx2bXtQIOU5z9udknaaH2jALec9VWKN79c//XsxdEt7HT5PhGZInkylGc7QxL4Y6mtOL5lau1/UwjECPbzsi81rkDiUzPVxyA64z+bymNQtJPI95oBnnL0/ZHcVGK54vXr8UtfIWyEdXtGS0RUHrFIWFaPmRLBhZBArF6A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: televic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2120f374-c1d2-4288-bc1f-08d64baf8f2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 10:37:51.1537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 68a8593e-d1fc-4a6a-b782-1bdcb0633231
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB4825
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hallo,

Recently I have been started exploring the BLE world of hardware and softwa=
re.

In my quest to find the best SW framework to address BLE hardware I have be=
en confronted with this issue as described here : https://bugreports.qt.io/=
browse/QTBUG-71727 when trying to use the QT BLE SW stack in use with Nordi=
c BLE nRF52832 hardware.

To summarize my findings:
- When the public device address of the Nordic HW is NOT set, meaning in Li=
nux the hcitool dev or hciconfig tooling will show the ZERO device address =
meaning 00:00:00:00:00:00 assigned to the HCI adapter/controller. The bluet=
oothctl tool will show the "random" address different from zero's.
- When running in this case(setup) the QT heartrate-server applic (QT v5.11=
 on Linux Ubuntu 18), the QT application fails to find the proper HCI adapt=
er as it compares the address found by reading out the HCIdevice address vi=
a ioctl (resulting in 00:00:00:00:00:00) and the address retrieved from the=
 BlueZ adapter (DBus) that corresponds to the random address created by Nor=
dic (also the address shown via bluetoothctl).=20

So my question is after I have set the "public device address" via the hcit=
ool cmd 0x3f 0x006 BD_ADDRESS, the random address is no longer the random a=
ddress set by Nordic it has changed into the public address (although when =
looking via DBUS at the address for the Adapter1, the address type is still=
 set as random) I configured and the QT application will succeed as both ad=
dresses will match.

Any idea what is happening in this process.

Thanks in advance,
Best regards,
Frank
