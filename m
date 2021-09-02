Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C379C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 03:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BD76056B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 03:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhIBDxI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Sep 2021 23:53:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:6430 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233122AbhIBDxH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Sep 2021 23:53:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="279967733"
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="279967733"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 20:52:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="446899756"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 01 Sep 2021 20:52:07 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 1 Sep 2021 20:52:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 1 Sep 2021 20:52:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 1 Sep 2021 20:52:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 1 Sep 2021 20:52:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mc87RWAcVMx1wcjN74fIksESq3NgnnpzsKDyYLHJt0PxYAvNAdG6HMipuLz/qk9OFlgYXqlMWAYTqTF45dK7aSbm41MtaTw1ILknRxsVW+OXPwq/NR8z8zr9dGoRZ5qxJIUXmxW8KJoxwlo8yPZXFEBhqk4+WrCp4vrCKC/hqX8lCuLmfYac5O7tB1X+gO1doNFiiOdGlTY6mp0Ju3gekx+sSxsO8EJdkd2aHMm4f74uxefJyn4Zrfj9jiUUTIfQ5dNeRFKA7fVVpU27CDBSeCtxriB27gCCTZuEmyQA033Zv0Ybsz38CU0r+MhYO7U3zXSBKW1XdLZBRkk3kHL1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y1L5enLjILmKe3ihsQ+LkMAtvj4SkKxa3PnV2eCzUc=;
 b=SPCIfZG3PhBJMZFHnZSTIUiIeaxoDUa/1sw+yfGTHNDJKtf6qAsQgFxIv3qib5uba+tjyYRHgKFWWkF8OWkdTyA2lZuqgkbCinBrS2FTO/xE58gAHpabPSF+JNLoHgMBU8zvhq2hl9BwTszuCzCw18BpTcXmd4B+E7YQ+SOSgFJCbLMcPC1h3woSb6KrBbLgKK8utKn/sL21nj7yuSOGc23FLbHgN6UZIZN/1lcyl9kuEzj36OSa7WQD737mxhEwwV8/GOV6a0Ibbhq+ctm1ZhEvR7VFjzoqbQyN8nZzU/qmV1z47EfDq2PCutqTcbP7XenipDEJ1w3Y+tqeclx/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y1L5enLjILmKe3ihsQ+LkMAtvj4SkKxa3PnV2eCzUc=;
 b=CxDPWAAfXqx8u2hVj2iBEyCYIP2AgEQQcMQLXm9KZNQ+It7ndmL5SLL9tor1Iu35DQ9t0FJijIlhJuwHv5Kl8Btk2WspRbuEktm8poiK0Fkv94UpUx+87stD+1AvkFg0q9QKZ5iyX3Ka/DpgOPtTtEbIMurfkEYi0F42BnF40Sk=
Received: from SJ0PR11MB4863.namprd11.prod.outlook.com (2603:10b6:a03:2ae::23)
 by BYAPR11MB2853.namprd11.prod.outlook.com (2603:10b6:a02:c8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Thu, 2 Sep
 2021 03:52:05 +0000
Received: from SJ0PR11MB4863.namprd11.prod.outlook.com
 ([fe80::6dbc:df5d:5a48:96a8]) by SJ0PR11MB4863.namprd11.prod.outlook.com
 ([fe80::6dbc:df5d:5a48:96a8%5]) with mapi id 15.20.4457.024; Thu, 2 Sep 2021
 03:52:05 +0000
From:   "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "K, Kiran" <kiran.k@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Pierres, Arnaud" <arnaud.pierres@intel.com>
Subject: RE: [PATCH v13 12/12] Bluetooth: Allow usb to auto-suspend when SCO
 use non-HCI transport
Thread-Topic: [PATCH v13 12/12] Bluetooth: Allow usb to auto-suspend when SCO
 use non-HCI transport
Thread-Index: AQHXnl6R5x/6dgiLCkuq+VZg+QRQ+quP3JEAgAA+B4A=
Date:   Thu, 2 Sep 2021 03:52:05 +0000
Message-ID: <SJ0PR11MB486301A4412E6D42D85EE253D8CE9@SJ0PR11MB4863.namprd11.prod.outlook.com>
References: <20210831115637.6713-1-kiran.k@intel.com>
 <20210831115637.6713-12-kiran.k@intel.com>
 <CABBYNZL3=z6CWj9EAiGnOkcaEmgs1Mq7kc5-fT4Mjk2HCUPsFA@mail.gmail.com>
In-Reply-To: <CABBYNZL3=z6CWj9EAiGnOkcaEmgs1Mq7kc5-fT4Mjk2HCUPsFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a1f3c38-78e6-4249-9b09-08d96dc507d0
x-ms-traffictypediagnostic: BYAPR11MB2853:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB28535C735D760453C02F23C5D8CE9@BYAPR11MB2853.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fDVziM8JAMoBNYSwhLNwx/yQDYpYDrQh9gp9i19WFL2brT4uZYG/nkbkHWLS5r8VCKrfTjIJ4iv94IaSLkHR9nrhiWJVhn7JT6RhdgB4Jx4X6OS6/xPgvu71FHuQmiz0wmIE9vR8GyTUykZdYocxgoi/FrWtvZBWl2NwDyHFEKwb4+URKGI+6yfiQMTYV4yEapzDxoG+iFFmPnjZRFSyzM0devAUwjwh36KCV6ovYOMN4nRF+Okx2OduBXqrNK4EMrC6qJKRuvUJgMoecLqlUzSmYFg7QJl/JR2NiSIYa11Xjz885TLymRc7s9DwkYRJNTI6jyR75qdBefkng43zoxWT2qcIQk5jaTl+egRn5PsddVfo05Fo5Tdylkq50HQ0jYI4JijD7MQ3jHuO4UqnWtj2HVS1c1z81YtCU8LMZbtVppCoOlYAxg4jzE+PwsGwbTz4mxHDvOfJ8dUuEJfKzUNRWhm3e1zrtNvfKUUwMWIduAJsZRInTnZd7iLmzYwqQ6QHEoJdrhEDEw24K7wLA6ahZhEov4mH6mRT32nJfMhregH3TYv2u1PShdiCa0UAV/kyhFoMh1JAnfWDTu7i1vYmraDQCDblbn+1DKIbzA1LX3Ojo3MlejFgdWFOUrV/uMnV73m9CfDcgH97Domw6mR9dlVt7E2LfiZLlGOW1G17MZcMP7kcu58HoYmDJ5FKjVOJWHcW0pwcXffiPqaAjedxkYKg04HCx5MjYZfR6DXXceQbK6U1T18DypXI49VjU3tNSoRY3zxUXPvwfU5sQv1O1ulmWZ2n+WE9A2Qdvl4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4863.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(38070700005)(6636002)(53546011)(6506007)(5660300002)(7696005)(66446008)(52536014)(55016002)(33656002)(76116006)(66556008)(110136005)(316002)(122000001)(64756008)(54906003)(83380400001)(966005)(15650500001)(8676002)(8936002)(2906002)(4326008)(186003)(9686003)(86362001)(508600001)(26005)(38100700002)(71200400001)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnBnNS93RFpMbmUyNlZrQmN4U2w5TXhUV0d3WmpmU3pkeEh4dnB2amQ4bElK?=
 =?utf-8?B?VDUvS2JlV2I5dWJNR3djWktmTWcySzFnUjU0SnIxL2kxZ0ZzMk9GQ1ZIMlVk?=
 =?utf-8?B?RDFkUHlvQlM3Wi9MMUZMT2ZaWWVKSUJMVDlKS0tYYm5vdFN0MDBaY0Z2ei9B?=
 =?utf-8?B?cDNsQ0Q2bkdsWUovcmp6UlZ1VGdWdnZBVi9qVDBpalZuS0wxRnZYZ2puS1By?=
 =?utf-8?B?VkR4b3V1YmxuMGloZjFvZE1LOTczdDJRNFdiem1JYTIvOERjVVgzamVQZXpj?=
 =?utf-8?B?cENINDRId0ZZU0NId2dBdzQvNkhtVy9TLzY2b3d5bk55aTdRSzEzRUVIckVP?=
 =?utf-8?B?eGszQTZoTzc3N3hnL0RCc1pROXZIQ01GMzl1SHJCeERQRjczTllrSXlTUklQ?=
 =?utf-8?B?NGhxc0lqYVM2TkF1cXF1ZEwzbDMveFIzSHIvTXFRcHRoQzBodHQySE9RbnFD?=
 =?utf-8?B?bTVxMmZ4V3pFcVBHbTVmSzdMQ3d2R3RkdTRkZXg3SmsrVjlhSW9kdWh3NzhL?=
 =?utf-8?B?THZwUmdJUlMxdGcvYXh4NGVOVndSUHJCY2ovTXFKNDh1UnJTTlJUTHE2Ynd1?=
 =?utf-8?B?cnhIcHdXWEh4OFJtZUdKalg2Yk5OOWFIWDBQeU5adXpmSmR6WlZCUkVkdCtq?=
 =?utf-8?B?Zm1qbXVOOXl0QzYwaFB2RDFUckFlV1JZVnE2azJEMGRwdk91NVdWREhoVDNs?=
 =?utf-8?B?V0lvb3BrN2hMclRoUFc5ZzJHVlVSVm8yaFgvK0VvTGF5K2c2WVZJankxRDNF?=
 =?utf-8?B?dDR6VTVHditOSUJicnlCTFg0UHZxNk92cFhLdm5sZnh6SnJrNkl4bjg2aDBW?=
 =?utf-8?B?blRmdStkQTViSVVNbXF1aGJjdXVrZnR4Vzl4Tkt6VXk5QUUwQzJxQ2xQYmR0?=
 =?utf-8?B?STRZeTlrM0FoYmhvak9nS3lleDhjdDBGTnNiOVJrSXBSL3Y2SGVET0g3WUZx?=
 =?utf-8?B?bkI4RXEzRzZrNVhtaGtSOE9vdENSZUp4UmM3Z1d0WllPZkg4dXZ6Z3J0NUM2?=
 =?utf-8?B?VzJEd0lGZmc1TDlBMnZtSHQwNXBVUEFTVGtmUTBUNjAxTldHTkd1WjNGK09W?=
 =?utf-8?B?UkJjcUhiaU4ybkU2RDhWZVFLZWRlM3hPN2lRUk1ER0prQVNWU3IxSXIxeDBP?=
 =?utf-8?B?aFRmQjgzMEoxQklKZjVvMnFwWW9HMGZGU1B6aURZS252a2VsSnhmLzlUYVJO?=
 =?utf-8?B?WFk0cnB6OVBRTVZmOS9uZ0xHclVGZCtBbnRtZzZxWStnVGw2bERraGVicmYw?=
 =?utf-8?B?RjZuMTR2bzluREthWlhjVzVtUnAvaGJ2eFQxN0F0dE8za2MyY0lGSWlEc0lt?=
 =?utf-8?B?aE42N1NhQlJhenBacmlyWHZlUnduWmIvNm44MTJjdXZyRkpIM0VYYXJJbUhO?=
 =?utf-8?B?T0RzQTJhMWYwOEtBbTVGYXNwVzNvSW4yY2o0d29sTTJ4MjVhN0hwKzIxODd0?=
 =?utf-8?B?UzYvNCtUTWNJS1VBWm1La2tFWEV1Qk9wc0FHZ3dWc01raUJ4elZNK2FYUHZn?=
 =?utf-8?B?aTZKU2M2dDNCMHJFekdtekRKbEdzT1FQZTVJYVlRc1FYakRRU3I2K1pmdEIy?=
 =?utf-8?B?REpNaEgwQnQ5VmpKUmFCeTh4L1YvK1dsWFEyaDA0RXVkZzFyMUwwZGJGbU5M?=
 =?utf-8?B?bkJuekwxK2dZaTdwdkJVc0c1UEF4R3luMzkrVVl0b0REVTFiREhrNU1hSWk4?=
 =?utf-8?B?UTBJbVFtaGJSV1lsSjJ6M3dwM0cxRWY0cXBOK1ZnbS9Udnk2elpPbHdvL0c4?=
 =?utf-8?Q?raNnGCoi+4fLUC1beIuhNaZFHIiSQETh/pvN+L3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4863.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1f3c38-78e6-4249-9b09-08d96dc507d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 03:52:05.5726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5s3IBv8VoPuOBnXDwM4vwTCS1dV0Nd3n7hZgR3tPArsqtwYqYuxmeZSzf0D/wX5cODkdS+qQ9tmOypieTdzBLM97yz1gm/YxV6gga1OATF76dG4La49VW7QaGWPX+RQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2853
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWl6IEF1
Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXks
IFNlcHRlbWJlciAyLCAyMDIxIDU6MjQgQU0NCj4gVG86IEssIEtpcmFuIDxraXJhbi5rQGludGVs
LmNvbT4NCj4gQ2M6IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc7IFR1bWt1ciBOYXJh
eWFuLCBDaGV0aGFuDQo+IDxjaGV0aGFuLnR1bWt1ci5uYXJheWFuQGludGVsLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MTMgMTIvMTJdIEJsdWV0b290aDogQWxsb3cgdXNiIHRvIGF1dG8t
c3VzcGVuZCB3aGVuIFNDTw0KPiB1c2Ugbm9uLUhDSSB0cmFuc3BvcnQNCj4gDQo+IEhpIEtpcmFu
LA0KPiANCj4gT24gVHVlLCBBdWcgMzEsIDIwMjEgYXQgNDo1NCBBTSBLaXJhbiBLIDxraXJhbi5r
QGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBDaGV0aGFuIFQgTiA8Y2hldGhhbi50
dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+DQo+ID4NCj4gPiBDdXJyZW50bHkgdXNiIHRyYW5wb3J0
IGlzIG5vdCBhbGxvd2VkIHRvIHN1c3BlbmQgd2hlbiBTQ08gb3ZlciBIQ0kNCj4gPiB0cmFucG9y
dCBpcyBhY3RpdmUuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNoYWxsIGVuYWJsZSB0aGUgdXNiIHRy
YW5wb3J0IHRvIHN1c3BlbmQgd2hlbiBTQ08gbGluayB1c2UNCj4gPiBub24tSENJIHRyYW5zcG9y
dA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hldGhhbiBUIE4gPGNoZXRoYW4udHVta3VyLm5h
cmF5YW5AaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEtpcmFuIEsgPGtpcmFuLmtAaW50
ZWwuY29tPg0KPiA+IC0tLQ0KPiA+DQo+ID4gTm90ZXM6DQo+ID4gICAgIGNoYW5nZXMgaW4gdjEz
Og0KPiA+ICAgICAtIHN1c3BlbmQgdXNiIGluIEhGUCBvZmZsb2FkIHVzZSBjYXNlDQo+ID4NCj4g
PiAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jICAgICAgIHwgIDIgKy0NCj4gPiAgaW5jbHVk
ZS9uZXQvYmx1ZXRvb3RoL2JsdWV0b290aC5oIHwgIDQgKysrKw0KPiA+ICBuZXQvYmx1ZXRvb3Ro
L2hjaV9ldmVudC5jICAgICAgICAgfCAyMCArKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+ICBuZXQv
Ymx1ZXRvb3RoL3Njby5jICAgICAgICAgICAgICAgfCAgMiArLQ0KPiA+ICA0IGZpbGVzIGNoYW5n
ZWQsIDE3IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50
ZWwuYw0KPiA+IGluZGV4IDYwOTFiNjkxZGRjMi4uMmQ2NGUyODljZjZlIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmx1ZXRv
b3RoL2J0aW50ZWwuYw0KPiA+IEBAIC0yMjE1LDcgKzIyMTUsNyBAQCBzdGF0aWMgaW50IGJ0aW50
ZWxfZ2V0X2NvZGVjX2NvbmZpZ19kYXRhKHN0cnVjdA0KPiA+IGhjaV9kZXYgKmhkZXYsICBzdGF0
aWMgaW50IGJ0aW50ZWxfZ2V0X2RhdGFfcGF0aF9pZChzdHJ1Y3QgaGNpX2Rldg0KPiA+ICpoZGV2
LCBfX3U4ICpkYXRhX3BhdGhfaWQpICB7DQo+ID4gICAgICAgICAvKiBJbnRlbCB1c2VzIDEgYXMg
ZGF0YSBwYXRoIGlkIGZvciBhbGwgdGhlIHVzZWNhc2VzICovDQo+ID4gLSAgICAgICAqZGF0YV9w
YXRoX2lkID0gMTsNCj4gPiArICAgICAgICpkYXRhX3BhdGhfaWQgPSBCVF9TQ09fUENNX1BBVEg7
DQo+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbmV0L2JsdWV0b290aC9ibHVldG9vdGguaA0KPiA+IGIvaW5jbHVkZS9uZXQvYmx1ZXRv
b3RoL2JsdWV0b290aC5oDQo+ID4gaW5kZXggYzFmYTkwZmI3NTAyLi45ZTI3NDU4NjNiMzMgMTAw
NjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2JsdWV0b290aC5oDQo+ID4gKysr
IGIvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2JsdWV0b290aC5oDQo+ID4gQEAgLTE3Nyw2ICsxNzcs
MTAgQEAgc3RydWN0IGJ0X2NvZGVjcyB7DQo+ID4gICNkZWZpbmUgQ09ESU5HX0ZPUk1BVF9UUkFO
U1BBUkVOVCAgICAgIDB4MDMNCj4gPiAgI2RlZmluZSBDT0RJTkdfRk9STUFUX01TQkMgICAgICAg
ICAgICAgMHgwNQ0KPiA+DQo+ID4gKy8qIEF1ZGlvIGRhdGEgdHJhbnNwb3J0IHBhdGggdXNlZCBm
b3IgU0NPICovICNkZWZpbmUgQlRfU0NPX0hDSV9QQVRIDQo+ID4gKzB4MDAgI2RlZmluZSBCVF9T
Q09fUENNX1BBVEggMHgwMQ0KPiANCj4gSWYgdGhpcyBpcyBpbiBmYWN0IHZlbmRvciBzcGVjaWZp
YyBwZXJoYXBzIHlvdSBzaG91bGQgYmUgZGVjbGFyZWQgaW4gYnRpbnRlbC5oIG5vdA0KPiBoZXJl
Lg0KVGhpcyBpcyBkZWZpbmVkIHRoZSBIb3N0IENvbnRyb2xsZXIgSW50ZXJmYWNlIGFzc2lnbmVk
IG51bWJlcnMsIHBhZ2Ugbm8uMyAiVHJhbnNwb3J0IExheWVyIi0gaHR0cHM6Ly9idHByb2RzcGVj
aWZpY2F0aW9ucmVmcy5ibG9iLmNvcmUud2luZG93cy5uZXQvYXNzaWduZWQtbnVtYmVycy9Bc3Np
Z25lZCUyME51bWJlciUyMFR5cGVzL0hvc3QlMjBDb250cm9sbGVyJTIwSW50ZXJmYWNlLnBkZi4g
U28gZGVmaW5lZCBpbiBibHVldG9vdGguaCwgbGV0IG1lIGtub3cgaWYgeW91IHRoaW5rIG90aGVy
d2lzZS4NCg0KPiANCj4gPiArDQo+ID4gIF9fcHJpbnRmKDEsIDIpDQo+ID4gIHZvaWQgYnRfaW5m
byhjb25zdCBjaGFyICpmbXQsIC4uLik7DQo+ID4gIF9fcHJpbnRmKDEsIDIpDQo+ID4gZGlmZiAt
LWdpdCBhL25ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMgYi9uZXQvYmx1ZXRvb3RoL2hjaV9ldmVu
dC5jDQo+ID4gaW5kZXggYjQ4ZTI0NjI5ZmE0Li43ZmYxMWNiYTg5Y2YgMTAwNjQ0DQo+ID4gLS0t
IGEvbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYw0KPiA+ICsrKyBiL25ldC9ibHVldG9vdGgvaGNp
X2V2ZW50LmMNCj4gPiBAQCAtNDUxNiwxNSArNDUxNiwxNyBAQCBzdGF0aWMgdm9pZCBoY2lfc3lu
Y19jb25uX2NvbXBsZXRlX2V2dChzdHJ1Y3QNCj4gPiBoY2lfZGV2ICpoZGV2LA0KPiA+DQo+ID4g
ICAgICAgICBidF9kZXZfZGJnKGhkZXYsICJTQ08gY29ubmVjdGVkIHdpdGggYWlyIG1vZGU6ICUw
MngiLA0KPiA+IGV2LT5haXJfbW9kZSk7DQo+ID4NCj4gPiAtICAgICAgIHN3aXRjaCAoZXYtPmFp
cl9tb2RlKSB7DQo+ID4gLSAgICAgICBjYXNlIDB4MDI6DQo+ID4gLSAgICAgICAgICAgICAgIGlm
IChoZGV2LT5ub3RpZnkpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgaGRldi0+bm90aWZ5
KGhkZXYsIEhDSV9OT1RJRllfRU5BQkxFX1NDT19DVlNEKTsNCj4gPiAtICAgICAgICAgICAgICAg
YnJlYWs7DQo+ID4gLSAgICAgICBjYXNlIDB4MDM6DQo+ID4gLSAgICAgICAgICAgICAgIGlmICho
ZGV2LT5ub3RpZnkpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgaGRldi0+bm90aWZ5KGhk
ZXYsIEhDSV9OT1RJRllfRU5BQkxFX1NDT19UUkFOU1ApOw0KPiA+IC0gICAgICAgICAgICAgICBi
cmVhazsNCj4gPiArICAgICAgIGlmIChjb25uLT5jb2RlYy5kYXRhX3BhdGggPT0gQlRfU0NPX0hD
SV9QQVRIKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHN3aXRjaCAoZXYtPmFpcl9tb2RlKSB7DQo+
ID4gKyAgICAgICAgICAgICAgIGNhc2UgMHgwMjoNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBpZiAoaGRldi0+bm90aWZ5KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aGRldi0+bm90aWZ5KGhkZXYsIEhDSV9OT1RJRllfRU5BQkxFX1NDT19DVlNEKTsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgICAgY2FzZSAweDAz
Og0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChoZGV2LT5ub3RpZnkpDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBoZGV2LT5ub3RpZnkoaGRldiwgSENJX05PVElG
WV9FTkFCTEVfU0NPX1RSQU5TUCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7
DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gDQo+IEhtbSBJIHRoaW5rIHdlIG1pZ2h0IG5lZWQg
dG8gbm90aWZ5IHRoZSBkcml2ZXIgdG8gZW5hYmxlIFBDTSByb3V0aW5nIHNvIHRoZQ0KPiBsaWtl
cyBvZiBidHVzYiBjYW4gY2FsbCB1c2JfZGlzYWJsZV9lbmRwb2ludC91c2JfZW5hYmxlX2VuZHBv
aW50IGZvciBleGFtcGxlDQo+IHNpbmNlIGluIHRoZW9yeSB1c2Vyc3BhY2UgbWF5IGNob29zZSB0
byBzd2l0Y2ggZnJvbSANCj4gb2ZmbG9hZCBhbmQgdmljZS12ZXJzYSwgbm90ZSB3aXRob3V0IGNh
bGxpbmcgdXNiX2Rpc2FibGVfZW5kcG9pbnQgdGhlcmUgbWlnaHQNCj4gbm90IGJlIG11Y2ggcG93
ZXIgc2F2aW5nIGFmdGVyIGFsbCBzaW5jZSB0aGUgZW5kcG9pbnQgd2lsbCByZW1haW4gYWN0aXZl
IG9yIGRvDQo+IHdlIGFjdHVhbGx5IGhhdmUgYSBnb29kIGV4cGxhbmF0aW9uIHdoeSBpdCBzaGFs
bCBub3QgYmUgY2FsbGVkIHdoZW4gdXNpbmcgUENNDQo+IHJvdXRpbmc/IE5vdGUgdGhhdCB1c2Jf
c2V0X2ludGVyZmFjZSB3aWxsIGNhbGwgdXNiX2VuYWJsZV9pbnRlcmZhY2UgdGhhdCB3aWxsDQo+
IHRoZW4gY2FsbCB1c2JfZW5hYmxlX2VuZHBvaW50IHNvIHBlcmhhcHMgd2UgbmVlZCB0byBjYWxs
DQo+IHVzYl9kaXNhYmxlX2ludGVyZmFjZSwgZWl0aGVyIHdheSB3ZSBjYW4ndCBhc3N1bWUgdGhl
IHBsYXRmb3JtIHdpbGwgYmUNCj4gcmVzdHJpY3RlZCB0byBvbmx5IHVzZSBvbmUgb3IgdGhlIG90
aGVyLg0KQWNrLCBEb2VzIGl0IG1ha2Ugc2Vuc2UgdG8gZGVmaW5lIGFuZCBub3RpZnkgZXZlbnRz
ICJIQ0lfTk9USUZZX0RJU0FCTEVfU0NPX1VTQl9JTlRGICIsICJIQ0lfTk9USUZZX0VOQUJMRV9T
Q09fVVNCX0lOVEYgIiBhY2NvcmRpbmdseSBhbmQgaGFuZGxlIHRoaXMgaW4gYnR1c2IgZHJpdmVy
IGJ5IGRpc2FibGluZy9lbmFibGluZyB0aGUgSVNPQyBlbmRwb2ludCByZXNwZWN0aXZlbHkuIFRo
YXQgd2lsbCBzZXJ2ZSB0aGUgcHVycG9zZSBvciBzd2l0Y2ggYmV0d2VlbiBzb2Z0d2FyZSB0byBo
YXJkd2FyZS4NCj4gDQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgIGhjaV9jb25uZWN0
X2NmbShjb25uLCBldi0+c3RhdHVzKTsgZGlmZiAtLWdpdA0KPiA+IGEvbmV0L2JsdWV0b290aC9z
Y28uYyBiL25ldC9ibHVldG9vdGgvc2NvLmMgaW5kZXgNCj4gPiAwMDRiY2UyYjVlY2EuLmYzNWMx
MmNhNmFhNSAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvYmx1ZXRvb3RoL3Njby5jDQo+ID4gKysrIGIv
bmV0L2JsdWV0b290aC9zY28uYw0KPiA+IEBAIC01MDYsNyArNTA2LDcgQEAgc3RhdGljIHN0cnVj
dCBzb2NrICpzY29fc29ja19hbGxvYyhzdHJ1Y3QgbmV0ICpuZXQsDQo+IHN0cnVjdCBzb2NrZXQg
KnNvY2ssDQo+ID4gICAgICAgICBzY29fcGkoc2spLT5jb2RlYy5pZCA9IENPRElOR19GT1JNQVRf
Q1ZTRDsNCj4gPiAgICAgICAgIHNjb19waShzayktPmNvZGVjLmNpZCA9IDB4ZmZmZjsNCj4gPiAg
ICAgICAgIHNjb19waShzayktPmNvZGVjLnZpZCA9IDB4ZmZmZjsNCj4gPiAtICAgICAgIHNjb19w
aShzayktPmNvZGVjLmRhdGFfcGF0aCA9IDB4MDA7DQo+ID4gKyAgICAgICBzY29fcGkoc2spLT5j
b2RlYy5kYXRhX3BhdGggPSBCVF9TQ09fSENJX1BBVEg7DQo+ID4NCj4gPiAgICAgICAgIGJ0X3Nv
Y2tfbGluaygmc2NvX3NrX2xpc3QsIHNrKTsNCj4gPiAgICAgICAgIHJldHVybiBzazsNCj4gPiAt
LQ0KPiA+IDIuMTcuMQ0KPiA+DQo+IA0KPiANCj4gLS0NCj4gTHVpeiBBdWd1c3RvIHZvbiBEZW50
eg0K
