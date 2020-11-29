Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253D2C3E8C5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Nov 2020 05:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6C62078D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Nov 2020 05:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="j3vznq8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgK2FLf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Nov 2020 00:11:35 -0500
Received: from mga02.intel.com ([134.134.136.20]:25720 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgK2FLe (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Nov 2020 00:11:34 -0500
IronPort-SDR: KPIUJzB+2QJziMdbRvGrRF2zYCO6fxH4WIDah4dbSbUYdCmPEHJv/GXZ2+iIuqhglwyDiokVPr
 ql5RTFlUcPig==
X-IronPort-AV: E=McAfee;i="6000,8403,9819"; a="159565639"
X-IronPort-AV: E=Sophos;i="5.78,378,1599548400"; 
   d="scan'208";a="159565639"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2020 21:10:53 -0800
IronPort-SDR: z/RJD2rZhfnTaohz+DCOELqdnqwTN4Nq8ykyL3FJydD42LNTFkxtsydVpvs4B5jTkhdr1vx7v1
 OJFlCFgFTZBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,378,1599548400"; 
   d="scan'208";a="404303678"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga001.jf.intel.com with ESMTP; 28 Nov 2020 21:10:53 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 28 Nov 2020 21:10:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 28 Nov 2020 21:10:52 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.56) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 28 Nov 2020 21:10:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6BqjsO1lmD7O2XPppPf9pfF+2odovMjUjJu96zK2xVyM1LPIcBDt8ghbPHM1+WbkmOPpNnfvz9onvyvDfT62gT5DADjer5K34VYhJrtP0HZa/rTVE0raGU+TMj53pqepj9oUb/ECPkCZ4qWGKMqi+q3vidNnACDsEhOfJafDcbArWBzmAO1rrxXVjLvIxXVBaWTN0a9rdrjx3XCqLsGTX1S/i7K4Z8XmhZQf28fJqJFDevyQJmffK54gKlGKfdvksTuZb068d5lSS0nC445LXBoptKUDr9VgwoTSJryfQqBY4LIISnN0mXW9z5yKyp7dPtFWVeNDw2P1nAj4YncVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6qakOWBT+jZnZgNBYRy72WSkE3R8Hfc1HAuvfNXf4A=;
 b=Ehqut0ujbOk2/+qtV96iveS1vBti/d4SxID2csh8n3WQl+v1T3FVc/Tftt6oFrEhoK9q+R6q3OxgEzeLKiQDeqyREhBhh97amoUAAtOjhYgG3WfwvSC5KNsbmqWqUDynz2CIQZ4Su+roT6yWgdMRNE6+EG5q7X1T3E3eFb3x3UZoa5NBSNi8yAbc30sNMrC0IXRtgJSCpTaX+pIMYQyduXxVTAxGKiTNHsAAECdNRRWIpOOJ0b6+Bq+nDekl5zMK5nDo7RNuHQJmEzpvt9iSVv7C1zVujaEp1dqL5GrYMDzt1pWKf5lv76ChODojlFCB4G3EwBgbotkX4aktteQAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6qakOWBT+jZnZgNBYRy72WSkE3R8Hfc1HAuvfNXf4A=;
 b=j3vznq8UyxAiL97UYiGAlEFZi4rsHRchTN2RoCsZ3ESHGBkEQfcf+5/S/NnPZ46EDtSNPlr3+XmVip11xNWlKhjheifBmHTKDxQq0oWkP1Nc4VmaK9LGdMCD3LwTGGSZIF+JnZw4Q9Ht2+qod4z/6MdfSXzZKngqlEf9hvFkBCs=
Received: from MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21)
 by MWHPR11MB2030.namprd11.prod.outlook.com (2603:10b6:300:28::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Sun, 29 Nov
 2020 05:10:42 +0000
Received: from MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::298d:3a2a:c969:5fb3]) by MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::298d:3a2a:c969:5fb3%9]) with mapi id 15.20.3611.025; Sun, 29 Nov 2020
 05:10:42 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "sbrown@ewol.com" <sbrown@ewol.com>
CC:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Fix errors found by static analysis
Thread-Topic: [PATCH BlueZ] mesh: Fix errors found by static analysis
Thread-Index: AQHWtAwACvrVywDoMUSmcKIVVlrIhanBthiAgBwzFACAAMq0AA==
Date:   Sun, 29 Nov 2020 05:10:42 +0000
Message-ID: <5d40d4a569ef5c8adf78511a47332ca774eb4487.camel@intel.com>
References: <20201106071053.122820-1-inga.stotland@intel.com>
         <f836d2e0148e2b156bd5837f651e6d43808541a9.camel@intel.com>
         <64b4d0e7e44b9726b8664e16461905cf8b90f20d.camel@ewol.com>
In-Reply-To: <64b4d0e7e44b9726b8664e16461905cf8b90f20d.camel@ewol.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: ewol.com; dkim=none (message not signed)
 header.d=none;ewol.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 970ae01d-de30-442e-69c6-08d894251f14
x-ms-traffictypediagnostic: MWHPR11MB2030:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB2030425194C7BD685838B7F2FBF60@MWHPR11MB2030.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gb67M59RjUZD0cvpis9gCiuTtlWNQsz9Cfivn4s3YpftESbG8dPwa4RC/jUHEKICd0BfYN8evFRE1lIk7WdZW75kAIfGrnzJ9SOsi4yECHfbFes0O3xVxijbyFK1meYIR/dE9cnMrN0JZMMwJKenDmH3b2xaKe3tVrCX4ZovHuwgYas8O8d/g9euqikge+lWlAO9l1VSvHcVVQxg6NeKwxDsWDiPmUiLwVGLL+TopnRFnzoMqrEoHF9sLCvO9Za7XucGqZHUyleiai6GSqPFHc9pr5eUCZwVgD/u7hN62ivl+zL1cDM0dFFjWqCbJ2jQSZb2VjmHSmAyBEhmBEgwVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4556.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(4744005)(6506007)(26005)(5660300002)(316002)(86362001)(2906002)(36756003)(2616005)(64756008)(66446008)(6486002)(4326008)(6916009)(186003)(6512007)(8676002)(71200400001)(478600001)(4001150100001)(8936002)(66946007)(54906003)(76116006)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?M21PNDJkMmg0bFNLSVFwK29UTW1hN0J6UlNVUnByV2p2Y1V0dk9ENFdYa2dx?=
 =?utf-8?B?a05wMm5TZnlQWm92T2ViMEw1MFljMGlJQmhqNkNLTGtyRVRKemNkYjI1djNQ?=
 =?utf-8?B?cXRUSEFvaDBBL0VqdVFNazUyQjZKM1BBY1JDSThIUDRscDRMMVZBMHlkNkVj?=
 =?utf-8?B?N0orSUZHMTRyMHpYa1MrdGRmS0JpbGVjdzFBR1JEa3kvcTZPNk5JbjhZVUJW?=
 =?utf-8?B?N2IzeFdwajB2bjNuSGhGNGt4YWxmQ3h5WGFmRUxoVzJKTng0V0lreVJ4UU0r?=
 =?utf-8?B?WmdvNlZuWFVwV2syVkRJZ0lpNjBrYzhtdDN0K3BCelRyc3RyK25iSzdVeWM4?=
 =?utf-8?B?K1NyMzVPNXZyWnlFMy9Odkh6d3hSSUh6NFpuTmpDMUpQQkZsbmFYV3d1a0JF?=
 =?utf-8?B?UXl4T1pKK3Z6WDV6OU9BbDdMNTBXTWVaSHVXZkNBcVdSRWhoWHp5K1V5ZW9x?=
 =?utf-8?B?ZEtCVU1jVVZGVTZmQWRESTRrQ0dJdTN6R3VvUStWOHNVSjRQcUFhY1NiREFi?=
 =?utf-8?B?OHZYV1RwTHZWK2ZoNFpoakY0aWxNNlA3bFVPS2lVYnVGblpZL2Z2bHZXaHBa?=
 =?utf-8?B?cGo3M0lTYk5TY1hzWno5a3F4RENDR3BhcXprd1JkUC9nU29TQmFYUkdrVlNj?=
 =?utf-8?B?L0JzUTlpU2RqWEtrWSsyUG5Jd3Z2Vkp2V3J6QUl1SWlIZmtPQmVHelRsUU13?=
 =?utf-8?B?VTZHZjIzbG1mYTVad1pmYU1zODhUQ0VkdFIyRDk0QmxnbU5CY0dMTUNuM3Nr?=
 =?utf-8?B?cG9IN21ZZ2dURjBQczFUTVNYTjBFMWFGRmtHMkF1c0hIRWR0ZTNvMTg0dGEy?=
 =?utf-8?B?TElySVFWWHoxMU9kZXVXQUVVbXd6dGZ1OUw1R3JCNUFqUFNqSkR0NnpGMDVH?=
 =?utf-8?B?MlA0ajlJMzZvWjR0dUdhdnZDMW8ybjF1VmJYT3h1WlFVa3kwQm9qcHE2dWhQ?=
 =?utf-8?B?RFpObmJMODJhcElmc2xpMUFaaktsN2pEVkxOZlVsOHhkOUtsLy9uN1AvS2th?=
 =?utf-8?B?bFBYUVZLK0FjRSs5K3h0ZDJjNFR2U2M4YWdoa1RWQkNoa25oQ3B4QkIyamhF?=
 =?utf-8?B?ejF5YjU0MG5IZEp2TURyMmllUHF3VkdTaGJzaXBpK0lWbWt1TkV5OUN0MjNI?=
 =?utf-8?B?QVQrZEl0L3d5SlFTMExLaHJYbm1DNFJuNDdWUjg2eDdFVGg1eWUraHkvSjly?=
 =?utf-8?B?VGNpZXZQUkh2VTZVRnVKemtMTWY5QTZlZGhwL1Qva1VFSmR2dzhpd2h6cWt2?=
 =?utf-8?B?QWlRUXphU28vWWxDdlpIWXpMZEFMMjVCOVp4NjVxNlBhbXRxeEJOUmhUSld6?=
 =?utf-8?Q?kejsjIMSaSXnx8NajyIpfwswX9/GtTmZOT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9584A73EB5B32945A7E3D36DCA40BE3D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4556.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970ae01d-de30-442e-69c6-08d894251f14
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2020 05:10:42.8171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+/3h0AMoGyBJJh4mUtXocCQuOa2nGYCnPAAt+ma9uy3cTuBK4xw94Dg9IM5eWpL6Vmi4iALKL+4ksJ12gvJ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2030
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgU3RldmUsDQoNCk9uIFNhdCwgMjAyMC0xMS0yOCBhdCAxMjowNSAtMDUwMCwgU3RldmUgQnJv
d24gd3JvdGU6DQo+IEhpIEluZ2EsDQo+IA0KPiBUaGUgY2hhbmdlcyB0byBtZXNoL2tleXJpbmcu
YyBicmVhayBjcmVhdGUgbmV0d29yayBmb3IgbWUuDQo+IA0KPiBJIHRoaW5rIHRoZSBta2RpciB0
ZXN0cyBzaG91bGQgYmUgDQo+IGlmICghIW1rZGlyKGtleV9maWxlLCAwNzU1KSkNCg0KWWVzLCB5
b3UgYXJlIGNvcnJlY3Q6IGl0J3MgYSB3cm9uZyBjaGVjay4gV2lsbCBmaXguDQoNCj4gbm90IA0K
PiBpZiAoIW1rZGlyKGtleV9maWxlLCAwNzU1KSkNCj4gDQo+IFdpdGggdGhhdCBjaGFuZ2UsIEkg
Y2FuIGNyZWF0ZSBuZXR3b3JrcyBhZ2Fpbi4NCj4gDQo+IFN0ZXZlDQo+IA0KDQpCZXN0IHJlZ2Fy
ZHMsDQpJbmdhDQo=
