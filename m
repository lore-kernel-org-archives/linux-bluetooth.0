Return-Path: <SRS0=iTYz=VN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE442C76188
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jul 2019 06:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C3F21721
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jul 2019 06:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=HubbellIncorporated.onmicrosoft.com header.i=@HubbellIncorporated.onmicrosoft.com header.b="aINKFa63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbfGPGAB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jul 2019 02:00:01 -0400
Received: from mx0b-00126502.pphosted.com ([148.163.153.66]:54192 "EHLO
        mx0b-00126502.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733164AbfGPGAB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jul 2019 02:00:01 -0400
X-Greylist: delayed 995 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jul 2019 02:00:00 EDT
Received: from pps.filterd (m0100724.ppops.net [127.0.0.1])
        by mx0a-00126502.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6G5hOdw021416
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2019 01:43:24 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2057.outbound.protection.outlook.com [104.47.45.57])
        by mx0a-00126502.pphosted.com with ESMTP id 2ts7b8g4ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2019 01:43:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IO60xXZA+fDGIX4Ey/Iac4h62QTyadGa+ZRo9Klv3QiMxKH6iIr23eST7APq+Gt7N1SNd0IAjvaToB5NMMiqXFlqe5W/tbuqry9IX4rFkK7aGor1Y4ilORP1cPMOofl+UOkXsKQWX0q9PtT1JmwqNkHLvGySpieQYQhUSg6ePHb8QfnKVwH2eRcUNhe2myP/HRdeLEE1PA+38aOKRHO+luAm0sGQHv1oGC/jjQ+Nl/3KsGjNOTHdEP5rOLzICIxP8J+GA0g/kxYoI9UH8hImNUB7kxOPHxAzAyUbjkeq/qYAOH16yn/5UQEhzGvo9BCsgspkfIfUy4NUdmaAl0BhpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KJp+drO3v97QxNyfmisoPjHMwth3o8TQHtviZyHf8s=;
 b=WksiABP0HvswNpOnmdtfpeGaPIJU62pecM430F/4LVJkRvfuVOFKtTE18w/deZnh7yXkwNSL9J7c2Gku7onedsLcgMo3dn49/qtCqgJ0TJXdOENXrHNoX5WDi38C5QQHz2wNfOC0op2XqQmQ2pAFcgkcnfuyqL2aNAtJXHPE8/z6Hm7boIYfoGMxb4X3DqZI4a7sMdGhTXNfVWCITfoX0B5qq1gVqjoIWWqhigzytgeD/dP65kQSRCSqmi9KMQsM9/a9fsd3Du+7XaOX4QM4FQ0h8ewZal3tWxUPwlk13eQG9vcjPhhNiC8fHM1Ws3+A88t0F5QaToGeql+4nJ6vBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=hubbell.com;dmarc=pass action=none
 header.from=hubbell.com;dkim=pass header.d=hubbell.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=HubbellIncorporated.onmicrosoft.com;
 s=selector2-HubbellIncorporated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KJp+drO3v97QxNyfmisoPjHMwth3o8TQHtviZyHf8s=;
 b=aINKFa63iIIZrAGrl4rkiswKpiN2DfpCDoyJVQnTBMCvwyEkeZdZCYNC6hz/62MpdAp3krr0vuuSXx97UFV5Rf8XXAfTVnVyKp4nhavHVgduC/7bFvr3v4QBhRXP5Ch8iNRZY/upMBJLto+DN7aQTHcXb1SwqgOdjdpfgf9QXfE=
Received: from BYAPR18MB2406.namprd18.prod.outlook.com (20.179.91.87) by
 BYAPR18MB2888.namprd18.prod.outlook.com (20.179.58.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Tue, 16 Jul 2019 05:43:20 +0000
Received: from BYAPR18MB2406.namprd18.prod.outlook.com
 ([fe80::21a1:ecf9:65e4:3aa0]) by BYAPR18MB2406.namprd18.prod.outlook.com
 ([fe80::21a1:ecf9:65e4:3aa0%4]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019
 05:43:20 +0000
From:   "V, Arunkumar" <avenkatramani@hubbell.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Advertise flag issue
Thread-Topic: Advertise flag issue
Thread-Index: AdU7mWjQq/Ynww6WRaG+PpuTy+lWFQ==
Date:   Tue, 16 Jul 2019 05:43:20 +0000
Message-ID: <BYAPR18MB2406CA1EF7CFC4B2A8FE9605B7CE0@BYAPR18MB2406.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.174.131.114]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf3e7a0e-ac0e-4c6a-ef0f-08d709b08289
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR18MB2888;
x-ms-traffictypediagnostic: BYAPR18MB2888:
x-microsoft-antispam-prvs: <BYAPR18MB2888C3FF94168386F93AD5B7B7CE0@BYAPR18MB2888.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(199004)(189003)(102836004)(33656002)(5640700003)(7736002)(7696005)(2351001)(9686003)(14454004)(6916009)(53936002)(2501003)(498600001)(6506007)(5660300002)(66946007)(64756008)(66476007)(66446008)(476003)(71190400001)(6116002)(3846002)(81156014)(81166006)(71200400001)(52536014)(7116003)(26005)(8936002)(6436002)(76116006)(186003)(2906002)(558084003)(256004)(8676002)(3480700005)(74316002)(86362001)(99286004)(66066001)(68736007)(55016002)(305945005)(66556008)(486006)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2888;H:BYAPR18MB2406.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hubbell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AhH21+B+j4lSUhmulGq0uRlfH7KKI07jRE5TEcJ16KuoUzUMm9EWHlllVzNtN6C8IiqFpCFoxm7o60dyDOmfFudfx/WL+rgJvgNmTagTEI9T0pMQQvizdFYlO5UUWEn/mS4gIQzXc8/qYNC9p/WEzGpEV3AmsKehOeUBzPhF5UXTHamXQL2Uiu5rV2eIUXp2No6xBE1ZqX94npqkXEoQRufa69oB5E0cOaIlAShAGtQbjwxKQfI0agg5hJ0f/E5TN/2V/TSmPzAopvDRK9HbA5g9ijvFraL6Y9rcDaECVXhGmFxGTWc6j9Gm6+R3nhG2M3dEfp2qv/KGu5XjMjw3Gjg41cvakycjqtPXc2nJ9LfPD+Cdj+uR24HMwNrYKi8+IPk/DRVqFh64ve9Y+raZxSb9oA3cOJHdn4jga+Wviwk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hubbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3e7a0e-ac0e-4c6a-ef0f-08d709b08289
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 05:43:20.3587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b984e578-dd3f-4fcd-afea-1c381ab634f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avenkatramani@hubbell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2888
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-16_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=507 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907160073
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

HI,

I am using BlueZ 5.49. I am trying to run test/example - example-advertisem=
ent.py with gatt profile.
How to set the advertising flag which property/data field to set? Any examp=
le on setting flags as general discovery, with LE only.

Regards,
Arunkumar.V
