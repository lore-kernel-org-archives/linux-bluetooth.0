Return-Path: <SRS0=EGv/=VC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A40C5B57D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jul 2019 05:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E48821850
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jul 2019 05:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=HubbellIncorporated.onmicrosoft.com header.i=@HubbellIncorporated.onmicrosoft.com header.b="EWi7Aahp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfGEFbp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jul 2019 01:31:45 -0400
Received: from mx0a-00126502.pphosted.com ([148.163.149.67]:46488 "EHLO
        mx0a-00126502.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbfGEFbo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jul 2019 01:31:44 -0400
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jul 2019 01:31:43 EDT
Received: from pps.filterd (m0100722.ppops.net [127.0.0.1])
        by mx0a-00126502.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x655LZGd001153
        for <linux-bluetooth@vger.kernel.org>; Fri, 5 Jul 2019 01:21:37 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2053.outbound.protection.outlook.com [104.47.33.53])
        by mx0a-00126502.pphosted.com with ESMTP id 2thq1r949p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2019 01:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=HubbellIncorporated.onmicrosoft.com;
 s=selector2-HubbellIncorporated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1e7hhEdjA4jUDCweUFGMkfH8a0mm15cduxi+MbvO5Q=;
 b=EWi7AahpqjD7nN5j//UvBbTeCKKAp+At3cJdBIfPc8GBceGmsXML2wshzqn/q25iiJ+DM4zpDwLy2C/Xx34jH+v7P6slBsCRET7qbmQsuoKue8s/lgEUCl2JR6+D8c8bXUtIc7tIL0vIKKzEi+NS9jvJYFyGcqhg6AMasYTrhxk=
Received: from BYAPR18MB2406.namprd18.prod.outlook.com (20.179.91.87) by
 BYAPR18MB2903.namprd18.prod.outlook.com (20.179.58.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Fri, 5 Jul 2019 05:21:33 +0000
Received: from BYAPR18MB2406.namprd18.prod.outlook.com
 ([fe80::2dc4:3268:a9a7:327d]) by BYAPR18MB2406.namprd18.prod.outlook.com
 ([fe80::2dc4:3268:a9a7:327d%6]) with mapi id 15.20.2052.010; Fri, 5 Jul 2019
 05:21:33 +0000
From:   "V, Arunkumar" <avenkatramani@hubbell.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Bluez communication with iPhone
Thread-Topic: RE: Bluez communication with iPhone
Thread-Index: AdUy8RDTYAzm+V0eRXurvZ2DiO7dbA==
Date:   Fri, 5 Jul 2019 05:21:33 +0000
Message-ID: <BYAPR18MB2406B91235BF8B369D286A6FB7F50@BYAPR18MB2406.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [182.65.180.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0e1f7a3-a34d-4aea-4987-08d70108a527
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR18MB2903;
x-ms-traffictypediagnostic: BYAPR18MB2903:
x-microsoft-antispam-prvs: <BYAPR18MB29031BCF66B69E8C67348F68B7F50@BYAPR18MB2903.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(39850400004)(366004)(189003)(199004)(71190400001)(71200400001)(486006)(25786009)(229853002)(66946007)(76116006)(64756008)(66556008)(66476007)(186003)(73956011)(66446008)(102836004)(53546011)(7696005)(6916009)(3480700005)(6506007)(26005)(52536014)(55236004)(14444005)(316002)(476003)(256004)(5660300002)(99286004)(478600001)(66066001)(6246003)(2351001)(14454004)(3846002)(6116002)(53936002)(68736007)(74316002)(2501003)(305945005)(7736002)(4744005)(81166006)(81156014)(8676002)(8936002)(2906002)(5640700003)(9686003)(33656002)(6436002)(55016002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2903;H:BYAPR18MB2406.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hubbell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +11ntkRCUXnb4/qhaLNkHOx3GSvX8BfAVNePm4wIdax6mn3KX+YFCgUb6qPWqdcd/eUcYQWGBIv6GzdjJny+rbiYiYYlBV+Aat0lILg0+XRZV/1+BoXH+qZH8+UAZc7He42En4bVZrLdnOTIOCWwMqJwh4hvcdarFCheicsKqQm8BR6wy3K4JbNRed58YCi7Jbu8UhkbN8oRTsuL8T7fGGmZskLXZryUSZfDWJRNzJ/e9r0iKtejYOcWOJsWNtOcd2JgpOAvYvZQkJtw3CJ9UWNW+edJ82o0+L5+8ZKhIFZVdJhVd5CKudk+sM1A6+KyUf02Dpk4oyFGBWOOOxmUpvdeuei5YiJRu7FYaU4eXUruJ5BwxBBEd+iexscBc+X2D0ovh3nXxd6VLZvJc9QjTrsr9OLfocW8hQGLBfT18PY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hubbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e1f7a3-a34d-4aea-4987-08d70108a527
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 05:21:33.5387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b984e578-dd3f-4fcd-afea-1c381ab634f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avenkatramani@hubbell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2903
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=944 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907050068
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi team,

Any update on the BLE iPhone communication.

Regards,
Arunkumar.V



From: V, Arunkumar=20
Sent: 03 July 2019 10:58 AM
To: linux-bluetooth@vger.kernel.org
Subject: Bluez communication with iPhone

Hi Team,
I am using BlueZ 5.49. I am trying to run test/example - example-advertisem=
ent.py with gatt profile.
How to set the advertising flag which property/data field to set? Any examp=
le on setting flags as general discovery, with LE only.
I am facing issue with the iPhone connectivity - connection not happing (wi=
th android working well).
Thanks in advice.
Regards,
Arunkumar.V
