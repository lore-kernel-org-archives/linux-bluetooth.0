Return-Path: <SRS0=CLw3=RR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8523C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Mar 2019 09:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E874217F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Mar 2019 09:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bksv.com header.i=@bksv.com header.b="c0qdOJ+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfCNJA2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:00:28 -0400
Received: from mail-eopbgr80097.outbound.protection.outlook.com ([40.107.8.97]:41517
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbfCNJA2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Mar 2019 05:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bksv.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFtjPdngSw4Sq1qRCzM29A0nPhnYWhjm0cggd+cq4Pk=;
 b=c0qdOJ+RsqRL+Vnr7HQuPwGCa4R4Tt8kv53IpuJyqz4uQ/5Xs6rLK0QTIssNk5HqxtfuDKfB4kI7xgyyEMpH5wMOwyQgCxFZozDuqiLoBwGMdhk92zBcY620h2euwSEmzcqU83ZBdXLRGkXr610hG0MvPC94poMdCdob89kL29k=
Received: from HE1PR0902MB1833.eurprd09.prod.outlook.com (10.171.95.138) by
 HE1PR0902MB1770.eurprd09.prod.outlook.com (10.171.97.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 14 Mar 2019 09:00:24 +0000
Received: from HE1PR0902MB1833.eurprd09.prod.outlook.com
 ([fe80::71ef:2a81:2830:b4cd]) by HE1PR0902MB1833.eurprd09.prod.outlook.com
 ([fe80::71ef:2a81:2830:b4cd%4]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 09:00:24 +0000
From:   Mihai Marinescu <mihai.marinescu@bksv.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Connect to BLE after it has been paired fails
Thread-Topic: Connect to BLE after it has been paired fails
Thread-Index: AdTaRBaohrzqJ10qTlabqH+NeWq3gAAACnuw
Date:   Thu, 14 Mar 2019 09:00:24 +0000
Message-ID: <HE1PR0902MB1833B3A66DB155B494844C578A4B0@HE1PR0902MB1833.eurprd09.prod.outlook.com>
References: <HE1PR0902MB1833F26C91C7C9B0B52BCB118A4B0@HE1PR0902MB1833.eurprd09.prod.outlook.com>
In-Reply-To: <HE1PR0902MB1833F26C91C7C9B0B52BCB118A4B0@HE1PR0902MB1833.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mihai.marinescu@bksv.com; 
x-originating-ip: [152.115.31.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c50c6382-a80b-48ef-6f35-08d6a85b7ed5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0902MB1770;
x-ms-traffictypediagnostic: HE1PR0902MB1770:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <HE1PR0902MB1770E425ACF9E9114D7ED7448A4B0@HE1PR0902MB1770.eurprd09.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(136003)(396003)(365934003)(189003)(199004)(476003)(66066001)(256004)(966005)(81156014)(81166006)(8676002)(5640700003)(186003)(6506007)(478600001)(102836004)(316002)(26005)(14444005)(7696005)(86362001)(76176011)(446003)(11346002)(25786009)(44832011)(7736002)(74316002)(55016002)(305945005)(14454004)(486006)(99286004)(2501003)(6306002)(53936002)(9686003)(33656002)(2351001)(5660300002)(3846002)(6116002)(68736007)(2940100002)(97736004)(105586002)(71200400001)(71190400001)(6916009)(106356001)(8936002)(93156006)(6436002)(2906002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0902MB1770;H:HE1PR0902MB1833.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: bksv.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oYWorxPDIQoKlMzzLxapXAcGpjzewRWET2//N2dCdvvZ8n37c7Hk2yGLsmylTraPJ0UalJnsCeN0oecZUZn7z5IFz5MHG2zmMhltSLcPlVuGBsb0795cPK3jJjXD8QXaZaM5HQs1IAEXeQhFa4K+f+x7SZEfwl7tMtIJIRmyYMf5nGskGCK220NOiwZVMRpOEuXutdtOumzMHiVluHUcYV5+ZJF336Pi912RY9pveS8wYQz7Zh2jxPN8ONmbXMkSRcnxT0k9Ksky+Q9E5Rifl4qmHmYybTZtnlIFWO6Vh7NSCfl5Cto+UTo8kqpT0gfwOyf2CFuNRM305/15fAfJKGpdzC2coqJnQuBvv/37v0f5/dsI0dHgGBQXe8V9Q1NF5grO4jQPY6uiD32dq42mGe8637UwjJzqX2ztdjISCi0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bksv.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50c6382-a80b-48ef-6f35-08d6a85b7ed5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 09:00:24.1309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6cce74a3-3975-45e0-9893-b072988b30b6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0902MB1770
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
I have a device using a module from Laird which includes a Marvell chip, th=
is module is used from Linux using bluez 5.5 and we have an issue with reco=
nnecting to an already paired device, here is what we see :

We are trying this from an iPhone X using LightBlue Explorer app :

1. Here is pairing first time which works as it should: https://gist.github=
.com/donnib/21a2fe4d93b2517d59284e7b361d618f
2. Here is a log of when we connect to same device while it still connected=
 to iOS : https://gist.github.com/donnib/58b9aad19b9dfa3534a4891189336955
3. And here is the most interesting one, we disable Bluetooth on iPhone, we=
 enable it then we try to connect to the same device again : https://gist.g=
ithub.com/donnib/a74e151ae42ae6dc674a843f935547fd

We cannot figure out why this problem shows up, any ideas why we can't conn=
ect after a pair ?

Any ideas would be greatly appreciated.

/Mihai

This e-mail is confidential and may be read, copied and used only by the in=
tended recipient. If you have received it in error, please contact the send=
er immediately by return e-mail. Please then delete the e-mail and do not d=
isclose its contents to any other person.

