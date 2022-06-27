Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C052C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jun 2022 12:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbiF0MGn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jun 2022 08:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239980AbiF0MG2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jun 2022 08:06:28 -0400
X-Greylist: delayed 1326 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Jun 2022 05:03:51 PDT
Received: from deltahqout.deltaww.com (deltahqout.deltaww.com [220.128.70.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B1910FD9
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jun 2022 05:03:51 -0700 (PDT)
Received: from deltahqout.deltaww.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D98713C10D
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jun 2022 19:41:41 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loytec.com;
        s=Delta2019; t=1656330102;
        bh=ZRFoTPktec4Vz6JsDlSS7Js6+kYzvk8SZU0C49/7Y/0=; h=From:To:Date;
        b=pHRX746jhs7OCWpzdoJgrrfzfwjJW6dLEgyzY2h1MrUMCSEoEvU66R8OeT1tiiwfM
         KfAdLN2n9hrkGnbW/2jpFfxSQRyjVq2018Vq22vDO/9FdPZM6e2Qj+t5+EgI+X/FXk
         kuXVeckDUlrPMHuD26mHcpE8tmvUnH5FXxP8WbAE=
Received: from deltahqout.deltaww.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88D1913C0A4
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jun 2022 19:41:41 +0800 (CST)
Received: from TWTPEEXHYBRID04.delta.corp (unknown [10.136.157.228])
        by deltahqout.deltaww.com (Postfix) with ESMTPS
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jun 2022 19:41:41 +0800 (CST)
Received: from TWTPEEXHYBRID05.delta.corp (10.136.156.9) by
 TWTPEEXHYBRID04.delta.corp (10.136.157.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Jun 2022 19:41:41 +0800
Received: from TWTPEEXHYBRID02.delta.corp (10.136.157.226) by
 TWTPEEXHYBRID05.delta.corp (10.136.156.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Mon, 27 Jun 2022 19:41:40 +0800
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.111)
 by TWTPEEXHYBRID02.delta.corp (10.136.157.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8
 via Frontend Transport; Mon, 27 Jun 2022 19:41:40 +0800
Received: from GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1d::7) by
 ZRAP278MB0062.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:11::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15; Mon, 27 Jun 2022 11:41:30 +0000
Received: from GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
 ([fe80::554f:776:f9eb:d60e]) by GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
 ([fe80::554f:776:f9eb:d60e%6]) with mapi id 15.20.5373.016; Mon, 27 Jun 2022
 11:41:30 +0000
From:   Isak Westin <karl.westin@loytec.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: BlueZ bluetooth qualification
Thread-Topic: BlueZ bluetooth qualification
Thread-Index: AdiKGrn+Eh4mC/ECRMS7SuH0Xaq1SQ==
Date:   Mon, 27 Jun 2022 11:41:30 +0000
Message-ID: <GV0P278MB0129C9B8851F33EE8C3BA54095B99@GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=loytec.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 790e1b40-6a14-400c-d3ac-08da5831fa9c
x-ms-traffictypediagnostic: ZRAP278MB0062:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CKXJ79HJ43mjD0XctyOzusIXd8Xdcbsk9mVrBFEmLcKfHVJ50easvQlP7811bVxlVMa3jEIH3zft/S8MrPSAX263ibzB7R6Ls4iFs2bqX5wIfBU81/YujPKjUGo5vTgVTmcz3Fj0IVdHKUXZ8cMMcyF/WXcZdxOT1axcFLBsGE1iGnVee1oSwd+BurKAv3Sd3PrSW0WNQsLy7TBmXgwvr/Z+VPoUXISCJfL7mYFniWrDhzUVg49dYHIJnmgQj/VxhrgCkx1vxImSyc9tp7QXpmU0a/yZKT/6AT+snjb0SmM1up0MiSH1kVCNSZguQKs9ze1bd8pjcyO5nIPSQi1hoGcgSUnLdgv7q6g/mz9LxE38OJBeGvHLogwHaQomwsi4GdmedZAST45/savlwiqD+jyZVH4i60CxGpZIx+vrQ/aBXg+PEocfXEJOutlyAIarrqqLpDD7OfUh5mL9xVRJjH8vJvNIsNw15/OamFLpBQK8kfIIoRekgP6URBVr3ACxIYc8ZdRqiFaW3roq8zLwJaMizSh5+ynZBYjTIpPdccuc5ZJ9Qvf6cxqXX4MOYDIjwTjmmiDd6tLpgsTPqot3WDrFDkIOH3F1GqMbLnFg1Ci4+rZsTt/Rbg3YiAt/8rp+uOKr4i3bCEqTxqZrMmYQgmo/gJVWVHnwFBqBpfiWA42K8MyrpCfbVxxuxPospQhonjAGH+cmIxZMLp1UQD3lOGulMvak6FHFN30mbBQO+g76FwJV/ZIHITamy4mnsumpaaofjE2c06tG06QCUYzjC2oSeSMGK4HN5p78OsPXGGw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(396003)(39850400004)(366004)(66446008)(64756008)(66946007)(8676002)(76116006)(38070700005)(5660300002)(38100700002)(66476007)(66556008)(186003)(55016003)(478600001)(8936002)(44832011)(52536014)(71200400001)(41300700001)(83380400001)(33656002)(122000001)(6916009)(2906002)(7116003)(86362001)(316002)(4744005)(26005)(7696005)(6506007)(9686003)(3480700007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rkbf9+mXdnghNiCRx+3Sw61h/r4KuIFk8gha4cSNwnj8eCfyaRgjL35qRd/F?=
 =?us-ascii?Q?fPVpoFCQzPcG2/f9uTeG71HpJSXD9/wHVqs1jYZfR0UBERJAJjrtKPFnJ4dd?=
 =?us-ascii?Q?3LvxdLlNQNLJwr+RAjlsZNcHXkt3ezncmc+nWrPUKxoNXJSo8T08zoVape7g?=
 =?us-ascii?Q?5oeTnyD7HsdJrPmsqo8PHJQ76G6nNvhnsB+kcd7KnMDKaOeb8taEuVtmkIX9?=
 =?us-ascii?Q?NmApxzg1w2xaD9Ss1rtAxXuP4CqecTluTgad09tfySB6Ux1uMFUMYRt+Tab9?=
 =?us-ascii?Q?p44U3kHsQLC3t0BR2O+rHMghKF0B4ZAw6hpqIuc61Hsb1ovRtKFfx1fu7xSQ?=
 =?us-ascii?Q?DcyPKsqtPQA19ibwuovX64tvEcRVtus6OLBAYs6nOfPHS4/JF/soYwnJizqa?=
 =?us-ascii?Q?IoJuPVA7MA+ZHN3C8HgM1cfECsBHX6j71KEFCFmvAiWmAWAvqPQ9zRfNCjjT?=
 =?us-ascii?Q?uqbM/s0cgehLEIfGCr8WvMdGQAICV+jTqBoRHTJ0nHyH8DL5Mv8iP1LeyHcU?=
 =?us-ascii?Q?FaSjLS1uqjEHoHJzvRddwV6mqkmqaVTzNmkQ4AYY6ZElSODOQsOuduTt5X0Q?=
 =?us-ascii?Q?MyCh42/NNaW3xypCke4hsb7MWZ9gYiSFM7oH68RvGJzCw1ISR+Pxh5/DqEOY?=
 =?us-ascii?Q?ecMLn1v/qhwYCiMNrQbl5ySqnDG7tLXTvyyVXhS419nFhqhp16JZyKG7+WIQ?=
 =?us-ascii?Q?CJJc2cBPwgf1wxBjjy2+fTlzaUDEEw6aoxsL6Xx3asuGx0978iyLt34Ijcgd?=
 =?us-ascii?Q?HBh2hKzSwviZl08nkELXirsKdZx8XEITNIGwyUpJEL0BNuuFIr18PS+F86MJ?=
 =?us-ascii?Q?cXF1PuZWWkQzPFJdDOmrykYouoTVTBcLImJNbqsheUKJZeKDy2gmLFkda+a1?=
 =?us-ascii?Q?UwpkRZH5DR/+RSbX9UsTqb6qGkFhUxaw3jY+IY+hlYnbUs/L3rc0eCXAFFXD?=
 =?us-ascii?Q?YV3D1H+2ZBWGA2oKQO0l5tlFm2tHeRHIgB37ocme4QCN9FmIe8aNJZ++6ln0?=
 =?us-ascii?Q?Ti+QOZcFyKmIwxmwamo/icflPMILjJYJ27cpj/4OUZB2XGI9FDcFiFHL+eaO?=
 =?us-ascii?Q?m7uic72cXGmsCVnXaKTbIoWpZNeszFKYUsSCApnMdjZg3cSoKDuVZL98WWdw?=
 =?us-ascii?Q?/N6VNrjxuI1qkZb6p/0or0oPd7+Rdrf9b9/9u9v1MgpehVxIi3cXQWRJ/ZgB?=
 =?us-ascii?Q?zAaBv3FbiTMGrG6Hpw2HkBpuXgQrOBsPG245pTB0RX5z54oDrDzxY77qyFl3?=
 =?us-ascii?Q?nZph8FofWcNSJp1TPUbLjop2KL7088lWSzZO0VgeQD+zrctTBfIPWaHCfSff?=
 =?us-ascii?Q?XDL3WG/LJuIr4EUscJA8tBttq4Ze6D8dxvirgWV4FUsS8XG0LroukivOrdsf?=
 =?us-ascii?Q?tvR26LBfY/HBueuQ6UYannIV/QUKQK+nvxGVeui2YLauknjQOTizbkGWz0oZ?=
 =?us-ascii?Q?/kErutD4OAMoKJWWNJMI4gPK7TnSkesoCMTV3gMjG3j9nQ4oeFeTA0XG+sW2?=
 =?us-ascii?Q?dCWDgHPFgNh8Kswqs1szzJCytDtJw5E/6n0y1LyMWxEM7aGhbej/Bo0H6gcY?=
 =?us-ascii?Q?gXgmBtSD46H8O4sZXLSEgJiz2VMXIGNPI+NNkvdQ?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZMUPXS7dVNlAGuYVYNTZBAI3/bgE+adbmFIp8MSlyn0QPKc/0KI99vJ5RGITlzZ4Arpl2LnG5ArNuhtzqiL/uqJ0cWAn6matHYb6Pka6taYu5r3v57q/h1jx6qpdRcePmKMeVJBoKkTS4RQtcROLQ62Ia0KTwWzP6VDn1wfO3HfMhcDTYrBnmFlp1Qsk+7IFTdBPyeD9LYYeiaQI4+d8/4W0c4LQ4q2jLYf+YbyST83Vkg5HvpT68owrtmpph0NsfdsXFQVYzB9UWTh1S/8Zr3/G+HYw6fXNfZhDtxG38mfPn1gjAvOato+qjJd6SHvms6qdSMQvwZ76kSHVSvaqQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I01hgUcoZDWYxlwlcema5JCi0skAvRaXpS7cnZroSmE=;
 b=hYaPu5o4DI4ZMlLbxyVehKBA1V80DQaQJ9FbcX0v+2Zr9nMmh9FAVgKGXktk+gK6MVJ4Ehqj1zeQgkmFp1OdXwq2qfbpgPoDMz9gOisznwO7fR4uu4o0OOoe5/38iGYMRt49lrf7aJjaeb+3Ll/LalfbS6bG6cDDIjivl6QUQk9rUd6TOBMZE2sdX/V5bGgAWrKV0g9MxOF/r+c1NNUqtoETSeivLELvcdtKcgEyYJ8Y2vvcHUGPgmagh9aIqHVjDi4D37O4634Q7Ii1QwMMk5Mdf1QS5HoGSxaW9rzBw2NcvHLhIMCdkUnrWlu8I/Uk4CDGp6xrroobaL44ZNYG7w==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=loytec.com; dmarc=pass action=none header.from=loytec.com;
 dkim=pass header.d=loytec.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
x-ms-exchange-crosstenant-network-message-id: 790e1b40-6a14-400c-d3ac-08da5831fa9c
x-ms-exchange-crosstenant-originalarrivaltime: 27 Jun 2022 11:41:30.7413 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 19f25823-17ff-421f-ad4e-8fed035aedda
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: PlVku+OYhJ+H59C4LW8mWiawJmsfVtLI0uDnynezmpjyqIBjCKIph3/LotwfeZoXGsp6+f5SSCrIH9+O7xTC5A==
x-ms-exchange-transport-crosstenantheadersstamped: ZRAP278MB0062
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: loytec.com
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.2090-9.0.0.1002-26980.007
X-TM-AS-Result: No--2.371-7.0-31-10
X-imss-scan-details: No--2.371-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.2090-9.0.1002-26980.007
X-TMASE-Result: 10--2.370800-10.000000
X-TMASE-MatchedRID: 6hCupHOLjqtJuVlaxd7wf9odT+kwNKQbHLMdyB+LKtz7s8CQBJM67phc
        hs7B6T9B5W5Bv14jDMaY5F3zNVn2CCqvXazqK7i845vEiL6k1dilY4F8r0vXP2oLpLbGy3pUdVd
        Df+p3DnJtIv0A3hSOW9gZC4f4K0AnNyl1nd9CIt3+xOhjarOnHkhax4LkeV5t+gtHj7OwNO2Ohz
        Oa6g8KrfK+QhWxtDKL5f9Yw5NNLxolmqEok6G0CHkusiv8eiJaBEi7a7f7dy4=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

My company wants to release a product where the BlueZ daemons are running a=
s a host subsystem (both bluetoothd and bluetooth-meshd). So the product ne=
eds to be qualified.
I have looked on the web-page and searched in the archive of this mailing l=
ist but didn't really find any up-to-date information about this. So I want=
ed to ask if you have some new information that could help.
What are the general guidelines to qualify a product that is using the Blue=
Z stack? Is there a version that is already qualified that can be referred =
to? Or is the best way to qualify it ourselves using PTS testing?

Thank you and best regards,
Isak

