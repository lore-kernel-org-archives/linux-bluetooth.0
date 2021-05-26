Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA72C47089
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 15:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3AB060FEB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 15:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhEZPdE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 May 2021 11:33:04 -0400
Received: from deltahqout.deltaww.com ([122.147.136.111]:59164 "EHLO
        deltahqout.deltaww.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbhEZPdD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 May 2021 11:33:03 -0400
Received: from deltahqout.deltaww.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 946CA7008C
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 May 2021 23:31:20 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loytec.com;
        s=Delta2019; t=1622043081;
        bh=NpLhFgnGMO2r+EmGHvEsqGu7tDyJarP771zQ0dzX97A=; h=From:To:Date;
        b=qcAma2bwu76gZx0rZp2opMKxAylPBftPykwpyaWjwIa0kxZ1UHYR/krxfrcrort5o
         L2Bx3GjvJZluHjENuHqTt7tPKzO6HDjyoU6Wkm7ogeRUmbSZrHYMX6dmZ8pdhMAkt+
         EjJpMpPKXrHIiEBt14E+eKntLJQtf4m/imnlPvmE=
Received: from deltahqout.deltaww.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8C4D700D7
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 May 2021 23:31:03 +0800 (CST)
Received: from TWTPEDLPDP01 (unknown [10.136.156.144])
        by deltahqout.deltaww.com (Postfix) with ESMTP
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 May 2021 23:31:03 +0800 (CST)
Received: from TWTPEDLPDP01.delta.corp (TWTPEDLPDP01.delta.corp [127.0.0.1])
        by TWTPEDLPDP01.delta.corp (Service) with ESMTP id 3416FC11AA46
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 May 2021 23:31:01 +0800 (CST)
Received: from TWTPEEXHYBRID03.delta.corp (unknown [10.136.157.227])
        by TWTPEDLPDP01.delta.corp (Service) with ESMTP id 21C3AC11A7BB
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 May 2021 23:31:01 +0800 (CST)
Received: from TWTPEEXHYBRID03.delta.corp (10.136.157.227) by
 TWTPEEXHYBRID03.delta.corp (10.136.157.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 23:31:02 +0800
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.104)
 by TWTPEEXHYBRID03.delta.corp (10.136.157.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Wed, 26 May 2021 23:31:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6dwHyqhqQGV8Zea7fo/YAm40XdlBJZJUGFK5Xn6WbLNa9Bk5ZL2cnIfjp0n0o60xXKDoGoRE6jBbYZM1ldQK1Wu1Z6sVdYnOlm3jLNYrwfQqLEhsItJI6AIULgVMpQtvktqxCBwoHI6HfntUifq07zwiQ/PfMpjHF92F5CzMy9L2GEmzA0X6PsZAjphmKyAUqSR9vsNXo7gcFhcgNOqjmjWsuJx8GTbVyeiST8hM/S0CyITrsBnhS0wIR1oeg/oWshUl5cIk8GTm1Kr3hZ7El+10+OeA1k4u21NXAizYJnU6riXhTax0fFWKMvxNZEwd3cFHFTaVM9Jx3dGG3cvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpLhFgnGMO2r+EmGHvEsqGu7tDyJarP771zQ0dzX97A=;
 b=T6qgbYySOQ426DEgDKvV+LyEv71jdteljFcxJMQkcDPUaydOGXJrHxFTkVUefKPwGKXT6qYnrrhldbOsvnEpFYZIMecKT8TjMAC9WIbh53q8Mh9suhK9thtSLs05sAEMb701sZAr5OkjO+rvX3LA/y7PHDBBfjGIOIvSkdSFHBCyEPl5nZZC8XKj4WOVUrfU4fe2TIigTLXXJp0QxD7Pc1PxOMiUtD+gIZZwy+bbyTM+x27uW7xeW+NrO6OfIROzPwB9g/JZTKCRl3DXJiKkV5AU1khbuEEFX6jSnXzUMBTmFaUzNUf9xxApND1WGYrlrxl0Fzh97oTYT/wiy57lIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=loytec.com; dmarc=pass action=none header.from=loytec.com;
 dkim=pass header.d=loytec.com; arc=none
Received: from GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1d::7) by
 GVAP278MB0182.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:36::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.21; Wed, 26 May 2021 15:30:53 +0000
Received: from GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
 ([fe80::600b:b12d:9b25:db79]) by GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
 ([fe80::600b:b12d:9b25:db79%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 15:30:53 +0000
From:   Isak Westin <karl.westin@loytec.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Mesh: Possibility to combine functionality of bluetooth daemon and
 bluetooth-mesh daemon
Thread-Topic: Mesh: Possibility to combine functionality of bluetooth daemon
 and bluetooth-mesh daemon
Thread-Index: AddSRA+l/nJ10uo2QpybqLxzHaKHBQ==
Date:   Wed, 26 May 2021 15:30:53 +0000
Message-ID: <GV0P278MB012962632005A4784A9F243995249@GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=loytec.com;
x-originating-ip: [212.17.98.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 351bc557-5f57-4ee5-6b9c-08d9205b4007
x-ms-traffictypediagnostic: GVAP278MB0182:
x-microsoft-antispam-prvs: <GVAP278MB01824D6479FB8040665CB4BF95249@GVAP278MB0182.CHEP278.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eLjaqtXshTLfiB1unuqLKvZErQMs5L5Fszb7HKWOcQXeYqqNk4vnkk1gREEEKe99Y5tHaQxj/A+QXuzgopYQF7eGhxMwtEIm4L84sckrNPUPd9w24xDpasSEycGAScBqaZBll6y8PMnnpSCdpTsHm1twOLrJPjxMyUEhC94z+Eu6mnUaAU0fuHNRy4RXDN9N+2WamUAAGgrIlgTT8hcIaEOwnIWa1BS+6l0lcsQyVtMo+oTINctubXrm64fZ45/j792pncUJ7qWCXVyWFJCxB33yV1uGJgr61VAq0921WNhClQjW25anoT89yYN0/5EfEZJ0M12BZe1/cp16946RYq8fsdNK+Ab6l1MJDNskU/CEUGRHmR2FFx5fa2+l+7DHzl17sKcZYav8THDBwQUQrOVIPXd6wGHPpyyxk0Jx6kb39kqXnxCMGtpZS1wea5t8XHR1Z5SeMG2UzMZAji1vcH/IDbEFpSS1OnLTCDyZOvUKuXK7MuvET7F0hKu0Fskh/ULDvDBj1WQe99/TYSiqeNaJTohmuaaiOzuu7kgj/XKDZHIBrwmaOzDomiGMrqEbiB51aMqdgIxcQa7ahYz3BX8Gwx0UIUoTO0A34zLDJcI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(346002)(39830400003)(366004)(396003)(376002)(33656002)(9686003)(478600001)(122000001)(316002)(26005)(83380400001)(2906002)(5660300002)(52536014)(38100700002)(7696005)(64756008)(8936002)(86362001)(71200400001)(6916009)(66476007)(55016002)(66556008)(66446008)(66946007)(186003)(8676002)(6506007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wc1vIlmpQCZNrzbLidQQHWzj4obalHfpe5fAQMFjbP6Rp0HgKiuSwPYWE3X2?=
 =?us-ascii?Q?NveXPET1Pfr810Fa08Ygp4nkcqW2QiI/1Nr00IkdU6a0OQeddDEgKBrj/eSD?=
 =?us-ascii?Q?/cj+MeRz61zoGJ1hfPrZ56ITfZLJQ2lBGeCdunMJaagwx8RMusVAP6TkmKby?=
 =?us-ascii?Q?+hqf+q5sv6T9jl8UD5aJXCbASZfxC/ji2rbB8YNLN2JTieUFQVPvkbHKEGhV?=
 =?us-ascii?Q?bA8abRUS9Mub8oz6sVmP9ov7Y4/g00/pmiWY4rB006rqtOdfbaPvSKAs2ZE0?=
 =?us-ascii?Q?QPgjntEqChq4qHzSqa7srWm1EvHBkPjoDkW8xAJG4gVpTAulVXLgEDdvuaBU?=
 =?us-ascii?Q?SaG7Y3BnFyEvyYptjoP8JTg+Sw0WbMFSZOLI86UBbLgThCXP/yf8wSBAOpfu?=
 =?us-ascii?Q?z4Fks47lN5nR7YQEi+Wn7CShJFmcmAtt5AsgkdoaURHPhV63eUJs8eJnNQ6X?=
 =?us-ascii?Q?SNHqhpJGAXnTjlBEQCuklDzbevmB27BcDDaATyQz4yIayMZMKyrz1MMxlZCd?=
 =?us-ascii?Q?qrXacMvdmKsH8XRkSjX3mZwV9qW2nLG+QE+SVNhXwBTsqkF7e/9ueaIsU79m?=
 =?us-ascii?Q?bgWbbe2852jQpErF7aaIMXDN/MZQImZ1vt0RsRS3Ggq968s1BEp6qVMUvUDE?=
 =?us-ascii?Q?VZcRNfjTdU3meL44TUu9aJOF9lg/Oc9tOpDg1dnoIl7K5NsdizHZ/0raPCTp?=
 =?us-ascii?Q?KFTmeBOQPcOj45EjSNzSzBnMjMKPFcWA3J7CqfFsdZkZffOcTpup3/gxqfXN?=
 =?us-ascii?Q?1JK5MsJPNIF8TifLfeTrtzYporicQ1CTpYEVjRIzAv0WBh01Y3NxsvYzWMUt?=
 =?us-ascii?Q?FeIENZvmJm374woLbj73vYV42VBU4yX9PI9SVLYuweJ0+8ZP2D/4rBCdNB+E?=
 =?us-ascii?Q?CazeOAJpZHKPmUCnU3IR4HY5SB3Qv0M67iOKpbN9v06QBJz8VIz6GOLk23OU?=
 =?us-ascii?Q?NxewjfbhKvgyithtbn+YACQu7NrOyJtkcaHFv6D3Bw4KR7gCa0cntfannKGj?=
 =?us-ascii?Q?qgqr6RP4JZ7mtJ0qUTVinTbfCel6JpNdM641KCDXcMt28zbmLpqL2HLdoShJ?=
 =?us-ascii?Q?dDR28ySwZ9aQzlweFonoo++kgr11havA7Dvz6o7Kpv3szdSQYE4o1OXCQl3z?=
 =?us-ascii?Q?hgpHs7qHydFFBW3nd09YGrKejuVOz/1fAJXTCGFs1ucQBxGlqAR95SgI24rW?=
 =?us-ascii?Q?P4BqnoUXNQd3N609QrmDcuKf91A4oVvxMDc0Zsr8GeuTVIyhIVTFOAA2C2R0?=
 =?us-ascii?Q?lub22tcoo3HK9LzCj/lLBt6bFky3je5gxIfjq/NN9i1D7H8kkn3b9Fl0Mmgo?=
 =?us-ascii?Q?bSg0YXzOE9zlulwHWHR5bD6q?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 351bc557-5f57-4ee5-6b9c-08d9205b4007
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 15:30:53.6871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 19f25823-17ff-421f-ad4e-8fed035aedda
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: quj7eO76wKbto3Lm3Vw5Kh8GDdwvBGnKQTvNdaK4rAV/4AM+3ud0jUr5KSKPYtl5uOXcObueNb+vT/rPjF4ACQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0182
X-OriginatorOrg: loytec.com
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1960-8.6.0.1013-26182.000
X-TM-AS-Result: No-1.401-7.0-31-10
X-imss-scan-details: No-1.401-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1960-8.6.1013-26182.000
X-TMASE-Result: 10-1.400800-10.000000
X-TMASE-MatchedRID: tW3636Wvo7Zfv1zVItekLKzHDCtzZvHZuSNyZKeaiD7WXfwzppZ8SCA9
        jDSyvwu9CIaa5JvsIzDTUef4xpw62ln5PmrlcMwbiZH+akICId3348e2CE/wYuDujCQCy7oGtY4
        N1nU8OYTXk0G1wmGFdeYWAQZj3Gas/uMEpT79T/PBXUwxE0W1ZkF+QlYpjQppmR36SjdWDGX/R1
        RTJsCnKTz75yF2//lYZJHjlDH+IiXT1VVKbhb4L5eZUDMyphfS57qwfXv3cNueEPi9wVyFrp99h
        kt3h4dXmy1pYYi7ZRKm5k33+uPKy8hIjxFAr+0zf8dNT84FpMZdWM3xsKqukXepM/I+teqco8WM
        kQWv6iXGlDvsLUDW2o6HM5rqDwqt7UJHB/uWWyslYe6EsigwgjVUBfsyfMNT24sihSR9H4c88v/
        oZOAxKUMlgVr7/jiUQQfCy4xXIw6kceLnztUEXr60BX13m3TqLr3kj3gYm08HH3J2uF6L8XQWaI
        bnjyDJVkIsYwVz6UifuqKKGgitHJRMZUCEHkRt
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi linux-bluetooth developers,

I hope my question is not unsuitable for this mailing list.

I have read in the archives of this mailing list that the Bluetooth mesh da=
emon needs exclusive access to a Bluetooth controller.
If I understand that correctly (just to be clear), it means that when I onl=
y have one controller, I have to choose between either using mesh operation=
s or "normal" Bluetooth operations (normal here meaning all operations that=
 the regular Bluetooth daemon already performs).

In my company we are now developing a Bluetooth mesh lighting solution by u=
sing the Bluetooth-mesh daemon in an embedded Linux environment (with only =
one Bluetooth controller attached via HCI). We have a custom mesh applicati=
on that is using the mesh DBUS api to perform mesh operations. I am current=
ly looking in to how we can additionally allow this application to perform =
other Bluetooth operations (i.e. acting as an observer, and in the future a=
lso as a central device).

When you have time, I would be interested to hear your general thoughts abo=
ut this topic. Whether or not you believe it is doable or if it perhaps alr=
eady is a part of a long-term plan.
I am also in general open to help contributing to the project.

Thank you for your time,
Isak

