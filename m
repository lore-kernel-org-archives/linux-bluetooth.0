Return-Path: <SRS0=Lkqy=OU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA6C5CFFE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Dec 2018 12:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EB020849
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Dec 2018 12:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bksv.com header.i=@bksv.com header.b="e+yQLJnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EB020849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bksv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeLKMgX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:36:23 -0500
Received: from mail-eopbgr80104.outbound.protection.outlook.com ([40.107.8.104]:43872
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbeLKMgX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Dec 2018 07:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bksv.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZzW7aeyTdczoaLLj2I2vgXUzyWOGyxB1qzyl8CxYYU=;
 b=e+yQLJnAIprbFeWTl/hIpy2KucHWi157ZU/z8tdwkBdsilKnLTqyby53M8wlwaCyeBNbvOwqvuhYehIVZNqVEYMocYloURI2Urs6ZY5zxthBUTOo3Ri9rp/R9Ed8A0J/npXrY8OOXjizA5YLAGwsn+EU4pRMbtQIIi3lRztGC8U=
Received: from VI1PR09MB2653.eurprd09.prod.outlook.com (20.177.61.221) by
 VI1PR09MB2957.eurprd09.prod.outlook.com (20.178.204.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Tue, 11 Dec 2018 12:36:19 +0000
Received: from VI1PR09MB2653.eurprd09.prod.outlook.com
 ([fe80::dc22:fe27:a5c3:1cd4]) by VI1PR09MB2653.eurprd09.prod.outlook.com
 ([fe80::dc22:fe27:a5c3:1cd4%3]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 12:36:19 +0000
From:   Troels Dalsgaard Hoffmeyer <Troels.Hoffmeyer@bksv.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Segfault in hcidump
Thread-Topic: Segfault in hcidump
Thread-Index: AdSRTeCGuDM3d2xDTwOsiD6F5MTrXg==
Date:   Tue, 11 Dec 2018 12:36:19 +0000
Message-ID: <VI1PR09MB2653841355183E17DA4EFC92E5A60@VI1PR09MB2653.eurprd09.prod.outlook.com>
Accept-Language: da-DK, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Troels.Hoffmeyer@bksv.com; 
x-originating-ip: [152.115.31.4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR09MB2957;6:7FYV9yE6fKMWhpEelxDylWUnqB+B0miigFXZl6TGXWt5TcApMTVXtyWLTJvkuwnb9TqfFXiLwnyZ2gEptaK8MnOBWTG9ckNRj5Zpu52yx/RAc15+RxvFNgRbRPbmk4qXx4PAu4JkT6DyNbGmYLP7F01C4vo4BRpWJBCpv/VI6HXR4n71jLHre3iwWepSCguRH7r/kBZ6a+2vuWwZpTO/DAIT+lcsL9QkkIzbxjbHVC7mqFjm/8VZAPNG20EbrMS5EKHSglFXJgJgjaO61arY22aVUXjakSWh8K990ubBRi/8QQZAl6jMublcIqnWMRePHCCwYw8nElDRk6LylNozd+qAky1p+vBSTBzo+P1Jrv7TifHascyNhAx/4orOk6Tytuc+EqFqCaMp1SldyeyT6I/bA4/xhVOrpNpcM8/3f720ROG/Xzm9RQ3JH5c/6C3lrJm2lhantAmBansubOCIbg==;5:EdejwqrOlfV4wnc0k6auDOuE9CEMbkfKrBCOzUzfe27vuRalJgZq5elOSkwwHX7aLVahWsdn1t2eh6IrCT+f936NabGv+73fFjaKLxvAK//Yv+Q8lJ8a+NkltpoQSLB5knoIunvSKCG3fNqdIFp9PE8ms7xAJ2CoQWQJSS61kJI=;7:LPIhX5Mbz91dWPvxowu88AH7grbGHlW8ICQf+rJzTDHmQaPw9V0tTpKY4Cho3XEzB0RCA084yXegKVE+N39XnyWceRTASr9EUoTYD+ypCrdXDZ+0iNuvL8LSWXkNvBrYGmKAleHSRO/HXaB2QdX9cQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 80cb5391-b72a-4263-61e8-08d65f65406b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR09MB2957;
x-ms-traffictypediagnostic: VI1PR09MB2957:
x-microsoft-antispam-prvs: <VI1PR09MB295766305C89CA466523B3C9E5A60@VI1PR09MB2957.eurprd09.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231472)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR09MB2957;BCL:0;PCL:0;RULEID:;SRVR:VI1PR09MB2957;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(365934003)(189003)(199004)(7696005)(575784001)(99286004)(71200400001)(478600001)(102836004)(81166006)(71190400001)(305945005)(106356001)(33656002)(74316002)(6436002)(7736002)(14454004)(6916009)(2351001)(3846002)(72206003)(6506007)(8936002)(6116002)(316002)(2906002)(486006)(53936002)(55016002)(186003)(26005)(9686003)(97736004)(68736007)(25786009)(66066001)(5640700003)(476003)(5660300001)(105586002)(7116003)(8676002)(256004)(2501003)(86362001)(14444005)(3480700005)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR09MB2957;H:VI1PR09MB2653.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: bksv.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mE6pUo/gSdEDGGy/jwjKGdjS8zEkjHwW8aharIYmTK+1ciYPyvVj5VAjWxTn08NJmK1PO+0aJHcXHivkjxIK9z4yEc8nMO4DeZVi78Qj+rA4p9DANhqxY4OKMoQnWsasip7jW+VIdorsjbCOt7rTdkH170Eg1eWkN2h8tHV304bCweWfSod+iVp8oPfminLV4KpqcNpv4khmpUSfrziOsjG/dYBrRrYSD2HB5+D7n99CWEYqLVBU4nEchYuenOiUAzEuUb3WwusgeO/LJYARVV3drqMFDxdl7fiFncy8Y2lkFmi5GhfoBUVmR78u781C
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bksv.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cb5391-b72a-4263-61e8-08d65f65406b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 12:36:19.5157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6cce74a3-3975-45e0-9893-b072988b30b6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB2957
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I'm using bluez v5.50 on Linux 4.9 on an embedded arm board.

When I use hcidump and then connect to the device over BLE I get a segfault=
.
The log until that point is:
> HCI Event: LE Meta Event (0x3e) plen 19
    LE Connection Complete
      status 0x00 handle 128, role slave
      bdaddr 55:3A:69:2B:2E:98 (Random)
< HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2
> HCI Event: Command Status (0x0f) plen 4
    LE Read Remote Used Features (0x08|0x0016) status 0x00 ncmd 1
> ACL data: handle 128 flags 0x02 dlen 11
    ATT: Handle indicate (0x1d)
> HCI Event: LE Meta Event (0x3e) plen 11
Segmentation fault

If I run it under valgrind I get:
=3D=3D1944=3D=3D Invalid read of size 1
=3D=3D1944=3D=3D    at 0x4842B10: strlen (in /usr/lib/valgrind/vgpreload_me=
mcheck-arm-linux.so)
=3D=3D1944=3D=3D  Address 0x726f is not stack'd, malloc'd or (recently) fre=
e'd

Kind regards
Troels Dalsgaard Hoffmeyer

This e-mail is confidential and may be read, copied and used only by the in=
tended recipient. If you have received it in error, please contact the send=
er immediately by return e-mail. Please then delete the e-mail and do not d=
isclose its contents to any other person.

