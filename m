Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5612C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 22:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728E0206DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 22:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="gx5H+/+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgAHWFh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 17:05:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:31334 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgAHWFh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 17:05:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 14:05:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600"; 
   d="scan'208";a="303679881"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga001.jf.intel.com with ESMTP; 08 Jan 2020 14:05:36 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jan 2020 14:05:36 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 8 Jan 2020 14:05:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4RL4H4VyqedDg9HG1k1NiAW2rrfUoxOHn5q76CqyY5qRVrpqVwyJFfTDXYl4K/YXEFkxrYcuzvTUCgDd3W0cUc0xAOBNiQX+z6ln9it8vNEWSNPO/7AsWaxptXI3YG1b/JFIhgr/Zo+kLNKsk4XmwRXlK3of4fW26syWui+RBFYSuxzK9zhqOAHM1DuLliHQx3HaGzjHJGNKOcIP7Zg43JOImNnfWJjKOlUoOy3KMVbiCbF2WfL1liD4NRd+ZdYHYFy370XO2IZ0/cdjWevt3hkzyeca9eVao5xwdk+PKfjevY/Sqrb9hps5qRBjQVG9HUi8ltGlmG7V7WgCch7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwm07iQTiF3aLuv/QR3SoGzVAiQnJdZTKxPi48Zl1A8=;
 b=FtLnS9GToVpR7nc1gOKjc5eB7ugEZwAiMI6Vv6QKeOGHo1B+qa7o6pGiolbT8u7uDvadyfc5Z0yyi9UUxbKpubsSmPybqZSDAE80HgJ8aCCQQTyjVm7xZnpei3Ttx8Xs0ZJLVjNzqGCzYajoUtbZPsth8ar5NilFiTWtqvC61R9jgp+WzFi8bt+lBV+z8+SE0VLcAsTNEjDGA9YQ5CrUuUiazjFhD9wKp3cVbWTv7tUMXwbObeJMRB4gHuRipYbKluxS6wArmInDUTUIHx1vvJoWPbnk743ZIQTylq8MpmYXyBHtp6llBWZnWSFsmPX1K/AhEEWb6KlbMJh0CHQYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwm07iQTiF3aLuv/QR3SoGzVAiQnJdZTKxPi48Zl1A8=;
 b=gx5H+/+BL3V1ap4HC1NLtDv/9TEl4g5U5VxWOt06ty49Hy53Oy0Xezs3DZLOms2YhQ3drLJ8SKEM5Oqtj+HhLpcInHT+2+JGyP2NriRvACdh3dTun1jAMTK29wdPcvomet/ZpFvVuG49Nnks7JiC9ayLDQSRphkb96k+TGstp/s=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1253.namprd11.prod.outlook.com (10.173.16.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Wed, 8 Jan 2020 22:05:35 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876%7]) with mapi id 15.20.2602.017; Wed, 8 Jan 2020
 22:05:35 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v2 0/2] Fix IV recovery procedure
Thread-Topic: [PATCH BlueZ v2 0/2] Fix IV recovery procedure
Thread-Index: AQHVxmbhDNdsIAtDWU2vK5twsRgog6fhUrEA
Date:   Wed, 8 Jan 2020 22:05:35 +0000
Message-ID: <2ef63131ee53fb99de99961c1355e610d33006b1.camel@intel.com>
References: <20200108210103.32220-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200108210103.32220-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5aeb1578-6800-4a00-7b72-08d79486e315
x-ms-traffictypediagnostic: CY4PR11MB1253:
x-microsoft-antispam-prvs: <CY4PR11MB125355E32C99B57B56B42DC4E13E0@CY4PR11MB1253.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(366004)(376002)(39860400002)(189003)(199004)(2616005)(4744005)(8676002)(81166006)(81156014)(6506007)(36756003)(5660300002)(6512007)(186003)(71200400001)(26005)(8936002)(86362001)(76116006)(66476007)(91956017)(66446008)(478600001)(66946007)(6486002)(66556008)(316002)(64756008)(2906002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1253;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DGvVEpEwmQCwko7IKKdztxJ3ArBV/8Iej+nTAnnmN956Qy+zef0Uz5i3XLdRrAHKf/E5dTngcDzNBLPo5XzD3MMa4fTOUyuOu59A4IAi7qbQn2JflS8XuBJuSOL+Bx5qPg1qMu9c+53c4dDDGG3E8xV637mXdmbOXZitwxP0ggFXlhwhIsbVGLQQk4xQt1v0GOlmtzXyG6g3zuVdUi6VrHNbJEooqwZOSPvXa0pz0/TPD6byUQDyk9LhNoYacIkdoc3+OELtn5jPjVJBmQ7iSiSboUGkowden9G3QTYQLlKXxK6bi0wt+q2aFl4FceFFQszy4dUInpfEQYQRjxLihjDebDD6Y91T1/eUBx45R8cQrfBZjheWifYEcQ6QFWBbC9rbrIVFM3NDTNpmwI4q/mCX8Ystc8aGIqsPAK7WH6Ojek3oE3GgOWd7G2b7xLFA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FE537ED2F34E648A6DD29B98E5F17B6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aeb1578-6800-4a00-7b72-08d79486e315
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 22:05:35.2019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g8W1ip7chhz4MpCJ966d6FFlaNc7vsPB9Awe9tcxq4K+OgCfV2LQzZ/7pZ3v7U717LwKjEKxRHAZIMbkTPKSeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1253
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KT24gV2VkLCAyMDIwLTAxLTA4IGF0IDIyOjAxICswMTAwLCBNaWNo
YcWCIExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gdjI6IFNlcGFyYXRlIGFjdHVhbCBidWdmaXgg
ZnJvbSBzdHlsaXN0aWMgY29ycmVjdGlvbnMNCj4gDQo+IFJhZmHFgiBHYWpkYSAoMik6DQo+ICAg
bWVzaDogRml4IElWIHJlY292ZXJ5DQo+ICAgbWVzaDogUmVtb3ZlIGxvY2FsX2l2X2luZGV4IGFu
ZCBsb2NhbF9pdnUgYWxpYXNlcw0KPiANCj4gIG1lc2gvbmV0LmMgfCAyMCArKysrKysrLS0tLS0t
LS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25z
KC0pDQo+IA0K
