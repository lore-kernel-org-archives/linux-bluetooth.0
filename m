Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5943C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 15:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350259AbiAYPtM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 10:49:12 -0500
Received: from deltahqout.deltaww.com ([113.196.174.111]:49702 "EHLO
        deltahqout.deltaww.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356546AbiAYPpx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 10:45:53 -0500
X-Greylist: delayed 1296 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 10:45:48 EST
Received: from deltahqout.deltaww.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1E1212A25C
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 23:21:08 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loytec.com;
        s=Delta2019; t=1643124069;
        bh=HPUNpj5JdyYjeb9RYp8Z8UZzYTV03mBNaXjM0ZUdA9Q=; h=From:To:Date;
        b=DWyzha+Q3oCi8sLd8iax9PgsEt6wPsM1CHglCz0mvpldLR2e2/FV/RwXs00LX5+px
         uSFIIUhfH7kZ29VeGOvRhOiBU/I1frhhi3U3uxm8cu7GWSVIKNNjvFymyYO15F/zi4
         SsFJ9BHOYmX3AJWkUJ59hGND9WgO8FWGk1+r4Ylc=
Received: from deltahqout.deltaww.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC6D912A1A6
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 23:21:08 +0800 (CST)
Received: from TWTPEDLPDP01 (unknown [10.136.156.144])
        by deltahqout.deltaww.com (Postfix) with ESMTP
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 23:21:08 +0800 (CST)
Received: from TWTPEDLPDP01.delta.corp (TWTPEDLPDP01.delta.corp [127.0.0.1])
        by TWTPEDLPDP01.delta.corp (Service) with ESMTP id 9E3CBC11AA46
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 23:21:07 +0800 (CST)
Received: from TWTPEEXHYBRID04.delta.corp (unknown [10.136.157.228])
        by TWTPEDLPDP01.delta.corp (Service) with ESMTP id 8F5B3C11A7AF
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 23:21:07 +0800 (CST)
Received: from TWTPEEXHYBRID03.delta.corp (10.136.157.227) by
 TWTPEEXHYBRID04.delta.corp (10.136.157.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 25 Jan 2022 23:21:08 +0800
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.113)
 by TWTPEEXHYBRID03.delta.corp (10.136.157.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8
 via Frontend Transport; Tue, 25 Jan 2022 23:21:08 +0800
Received: from ZRAP278MB0144.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:14::9) by
 GVAP278MB0069.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:22::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Tue, 25 Jan 2022 15:21:00 +0000
Received: from ZRAP278MB0144.CHEP278.PROD.OUTLOOK.COM
 ([fe80::10bd:6d0f:65dd:8a03]) by ZRAP278MB0144.CHEP278.PROD.OUTLOOK.COM
 ([fe80::10bd:6d0f:65dd:8a03%4]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 15:21:00 +0000
From:   Isak Westin <karl.westin@loytec.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Bluetooth Mesh: Option to retrieve RSSI value from received mesh
 messages
Thread-Topic: Bluetooth Mesh: Option to retrieve RSSI value from received mesh
 messages
Thread-Index: AdgR/qveFxHMZltZR7KeA1FkQqvEPg==
Date:   Tue, 25 Jan 2022 15:20:59 +0000
Message-ID: <ZRAP278MB014417E1D86BB8D4E82A6174955F9@ZRAP278MB0144.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=loytec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed480a3a-d4c4-4c82-8a41-08d9e0164aee
x-ms-traffictypediagnostic: GVAP278MB0069:EE_
x-microsoft-antispam-prvs: <GVAP278MB00699A9991567D49B3A166A8955F9@GVAP278MB0069.CHEP278.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lpOYUJgdU027fSVznHraMdE645Q+1LnKoa0l5hE3jWMlm357WBhZge4YJfSVuCiBp2F8LT7OYADMOO56J8AUB+pnZWFshy6f+xlhVAqK8Zjh+sWjtrxP2SJYwhddbZqhdozV5l+pS9WERcg15kpWvtLNWmmj5GBGxkRRyQ3uhhZnUs1u76qRYLY4STxnKqmIgHoU/bhaL0lUrWHjC8hgKoQzTxgro2Z6rVZS+BAtpxJT6g5ljG0MkW/d2G7GcZkNAnC9Jj6aHDrlyq95K8kHp/lcNNVOtFC2I0AEUlursFmyQ3uA5uBKE9LmyBOy3j9QM7fc94tR5TjVz50cZL8BbdmTCEcZzJIqLX3kFFRz5gAsdB/+CE2NpJAygqIZn8iZElOGpy7MFAKSDAEHJbMixlgNvh2CLmYmtfTPkc9pTIZihGVoSd8/kVYALfwP1kEM18fmvuBkxOutCUs1u5v978knK8EOe9npIWzeyTKRSuW2+LWRDaNBZDmswp40GGy4SzRi/g0COJt+r0pf2s1h7sOFq8Raz0sY7we/mFIRgwRnHZ/S+ELU/lwmTrIDMkdAhjxQGQvVe4EmLFKWQY3QLj6Sq/359ZF6RDAioY4PWqzFgPaSz9gLdFn4QNm5OaffzKTssAfEQc/BhW3KJ3Wd0T6yp2g56RCLd5U3DWEeEmpwlyNCA35I/dwOZdFzQR/pkgxKx0zNuvkBNgjOLnOmMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0144.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(7696005)(6506007)(38070700005)(71200400001)(9686003)(86362001)(316002)(83380400001)(508600001)(6916009)(122000001)(66946007)(186003)(38100700002)(33656002)(8936002)(5660300002)(52536014)(55016003)(2906002)(15650500001)(76116006)(66556008)(66446008)(4744005)(8676002)(64756008)(66476007)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OskoFUVXGdMZztL0BozQ2Et94aP1SsVHsbZZMyIepl1yU+4/Ak6SV4H40i70?=
 =?us-ascii?Q?bZzHKGvtbaT/gcYsYRbNRsNZC6BqUjG9Lz7K5HUibj0UXinAqWkn/6RaUZXe?=
 =?us-ascii?Q?DxQUyqPkhcylQuVuQWQ6AgWiixsw3Qw7vx9jMWj87lV2peNeNeMMlRFk+P3A?=
 =?us-ascii?Q?Gu3YSvspbDn7Lq9M+R2dXSr1MjaaPAWTQGJbxonckw5e8CwjI4PcKAgyU3tr?=
 =?us-ascii?Q?tJGYZaXa9POfqBuyu7XjnyuI7SOiYbYqA7ojxvzCpSzNWkgrAthxSs0CHfQu?=
 =?us-ascii?Q?aV59obUYZhqESsAvb/eXOfjtx2m9I6xkUdJGLtY/HOjMTJtkS9gDTWL22o35?=
 =?us-ascii?Q?fB1DIkBFLMc9+47e0T3+nzVCFuMttcJiZkyadytDkr/bfpBZKj+Fk2yCAKDD?=
 =?us-ascii?Q?u7OTfgMqvkL3pIt/0HBEkBRArYgONyrdwIXpTG6nfKmGnzW70qP58deVVNUy?=
 =?us-ascii?Q?MVwU+Oh4b0lMgb6xVG2iy++5cHj9FMzCbTncox8JVLxg8BPEu5XN2q6VBPld?=
 =?us-ascii?Q?MpVBL5GghtX5oftOnpv4WPiXAxvqNZW0e45E3YjdYH7pm1A/HtjTKs6Z4OvJ?=
 =?us-ascii?Q?pu7/8msdZXwUzhyMt1l3+QcAo6Mwipfv0ea3vus96X4cHBwJqSlfe8x50W+Y?=
 =?us-ascii?Q?fCgKhgBR50vC+qZRCO/Y5yI4DtzYTHqhkflL7w9Q9zmQdkElnagaEhaaEcS4?=
 =?us-ascii?Q?7Oo8My4EkexvAzZEd+IZZzzRMY2l6ilI4UG1bDe0cPvwUKTlGfM7XKvdKSOe?=
 =?us-ascii?Q?6Udqth1YG/QBFVseRa9ZQo8eTHyAWQoFQmXESa7XQ0ovdI2CNZForGIsAAzD?=
 =?us-ascii?Q?8VP104gqFlWOi1z0pzgpEwPrpOSBKI5Et5zyHqJ5yGzrOIiPJVx0Airv/a3r?=
 =?us-ascii?Q?M2gf/nc6TjMt6grHXyVFUOpJpsfc3whhmYi/JZ1Kb6nQB2axd4n3dnDbL+R/?=
 =?us-ascii?Q?a4goavuIgC6n1USHFouL4fRnF86zp3GyXbzhxe01tZMa8o8I0xvOxcnZUMUr?=
 =?us-ascii?Q?XdeHDVbYfgT0I+IZk5hf/lWqb3McgowMaNe9HVnpAkzLQEYj7KNS9i73oopR?=
 =?us-ascii?Q?HhywNrtcUBY0NwtNT+rGFzgfanW/dBhWJJaJyjRSGKkfoWo5lfwfhr5qtpOB?=
 =?us-ascii?Q?zvzJXYWBWtjeMoe1j41oCH2dnIuYBdcCrsKXTKn5yAfAls7t0bhOUNJnRHhK?=
 =?us-ascii?Q?kyPsuTDeGeVUfZBD8Wvves0PV69/1b0+DSEl60G86+cQ2nWDVm1PDePuTpt1?=
 =?us-ascii?Q?Rk+6Pt+UUNTk1bdIDBpfJK+BVE92l8QQy6lxu+eZ7oshIPySUSgJinCKTZMR?=
 =?us-ascii?Q?umvt8QmMk2Ci7ZUnbO7dbO7smsI0VlrQ45DoRygijDw6JGwx5StlPXaFoPwx?=
 =?us-ascii?Q?VuNt/WoMU7RvFewNc/vBhQZUQQsJMvzMlM7w0aI2TBvUgexiSMSRRAOSXCu9?=
 =?us-ascii?Q?d8kAJ/DzVcG2iXuht1UmsbFPhcjV0NS64pA35EIXfh8h22XJeVv+4VDXgUq7?=
 =?us-ascii?Q?HpNV2lgrt0YLF11Tbhxs0eIsScXpQ18QZnv/AIiDYYegCPcDAEVbujvnZMbz?=
 =?us-ascii?Q?2pA9NJisZBSeEv0LIxEZHE1kJeMuljM80E/W/vlVqRVa/bOgjR3eyJmL6d4J?=
 =?us-ascii?Q?/bv55olmpwD/rpEC5g6buieHIqZgK5QeGd5JoD2oqr+pGOUsNB3dmOLoBRoQ?=
 =?us-ascii?Q?dnmpaQ=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzL0UYzcaPrBfCH16Obn8WPQvm3Czqj88rCJt0MvfoqI7Xx0Le4p/7I0w32WqthhxNVMRv9ByGHC/xx2871Ft37EAAdh5ok4uepq08FRElpQwIqZjozfqs/hnk3gGJKfiNYcm2yZ8+QNKr2Dn+GBlZTOgRrURrx9lIVfGoGGtjq4Kr23EO1sdLtbF5vlq70jaXMnhlWxt89oG1SrcjGosEooB+t1gaMB1H0kSXd7XRlVt6yJzi8PAXl+7C7XErJrHHH5weJHqUEmjOb0KD8M0XL/856TE8jor9eFPJj2YoYVZb4BYUWfcsWerTEO755tdh/GmbrAPqOkL6XJTxchDA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=df4tG0fM/PIgxae1lmr3GxbTcx1AWnY+/MugoQ9GVZ4=;
 b=de889wg+wlpuCGz+RPuijNA8D+eugI8MNO1997aps21Y6cIOePzQf/S6aTKcHPV1cudHCzdZ2MgMw/eHpNiXqMjsBT4hWsdx5HIUMD0Xv8PYLYCWTwP7YNN6snRBcG2mcO7LhR2f2yCE5RVPGIjXmxuvXUrFZ7tKixF8G6c3zFlwLXpztNE7km6/YO0ploZ+cnx+jFMjwU5wViEynIdgmTPM7sX6LzMXtVderpPAmrV5WJgs+Vr8r+z14YjomuDn4xRbtxA0LC6VHYM8hXISkE5QFpwzwVbIGf+lT/TKUT00kh/0Fd6I2ezb/DHCpgqEXO9q3nbZPYdk+V6HV0NQXg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: ZRAP278MB0144.CHEP278.PROD.OUTLOOK.COM
x-ms-exchange-crosstenant-network-message-id: ed480a3a-d4c4-4c82-8a41-08d9e0164aee
x-ms-exchange-crosstenant-originalarrivaltime: 25 Jan 2022 15:20:59.9120 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 19f25823-17ff-421f-ad4e-8fed035aedda
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: jTH1yrg2LxTlr4PBKqhMiIIDD1BUmBCzReo7Aw4pF65HdUws3ZDKckRiOUYP7qPGuQqnzyg+UdyyYIrneoC1/g==
x-ms-exchange-transport-crosstenantheadersstamped: GVAP278MB0069
x-originatororg: loytec.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.2090-8.6.0.1018-26676.001
X-TM-AS-Result: No--3.249-7.0-31-10
X-imss-scan-details: No--3.249-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.2090-8.6.1018-26676.001
X-TMASE-Result: 10--3.249200-10.000000
X-TMASE-MatchedRID: OLvUXwdaHcimnzFWe+TBCcdsW8efjaktohrMq0nEhQeykL7HJ0lm4+Vv
        KiH4D7O9nGvqZRA9ku5OLqkSWYaQ42j8oZRXwTGoHC7hAz/oKnISUsfu0Jv3SigVbxW7FDOVurr
        p3QW/h5T7ptn+uKMYpYTBU3GlBbY0df+b4Eg/E98X6pCkJZNSORwOcB9/9tcRRjHvrQ40NxYUjP
        81ssYgmGCP9M0P4yUs2BkLh/grQCc3KXWd30Ii3f7E6GNqs6ceYxU/PH+vZxv6C0ePs7A07Y6HM
        5rqDwqtNdq83l/qdkLeI73Q1vK8FLUu2MkPuXZBcLyVhqRxyW38z1tKfODh+UMMprcbiest
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,

In my company we are building a Bluetooth Mesh application on top of the bl=
uetooth-mesh daemon, using the DBUS interface.
We want to use the RSSI value of mesh messages received from provisioned no=
des as part of evaluating the general quality of a bigger mesh network. Als=
o, e.g. to decide which nodes should have the relay feature enabled.
The RSSI value is delivered in the LE Advertising Reports via HCI, but ther=
e seems to be no way to make the daemon pass this information further to th=
e application.

Is there an easy way, that I have missed, to get the RSSI values for receiv=
ed mesh messages? If not, what are your thoughts about making the informati=
on available somehow, perhaps as part of the DBUS methods MessageReceived a=
nd DevKeyMessageReceived?

Thank you and best regards,
Isak

