Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69F6C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 Jan 2021 23:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8522620782
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 Jan 2021 23:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbhACXGP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 3 Jan 2021 18:06:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:38615 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbhACXGP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 3 Jan 2021 18:06:15 -0500
IronPort-SDR: 6FxYSEtO8VornJZ4TrpvxonEaALgK6biF5+T5sFIgOKO59W+jfCGl3yReJa57MdmPPB3ub8abC
 n34pTtJUm8jg==
X-IronPort-AV: E=McAfee;i="6000,8403,9853"; a="195410909"
X-IronPort-AV: E=Sophos;i="5.78,472,1599548400"; 
   d="scan'208";a="195410909"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2021 15:05:34 -0800
IronPort-SDR: 9FTwyXAUxl2i656uDSLMzimXcrpkqgfbaRdbW7MV2E5g39cYyRsAUNrlZSZeXrn6nM94ffQ0Tr
 DrqMlztQ8z4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,472,1599548400"; 
   d="scan'208";a="342632071"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jan 2021 15:05:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 3 Jan 2021 15:05:34 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 3 Jan 2021 15:05:33 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 3 Jan 2021 15:05:33 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 3 Jan 2021 15:05:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFPIZ/EvWSNNLJuvBRPTIrhlnUVgpk25jZV9UTyE0qfQY3FiuhI8QvR6tz9SPP/5TeDBSdBfjI7bDWQDB3JNjVMQndbNnCveTw0+6XZf23vNKgb1W9H3nG0Vw8BJ+3ZIRADkiy+fxPo1Cgk+v+9mk/UULr8Oph+SJ4Y6ATrD43eJSrNa7edSuIJ4PXClyfC8QcD7qVXU18ZXLnxc5ACC35y2vAInaiHa7ndjbsidy2LU3EMO9HtDTsORTBAON/lqj5CcUsITpBuO5zCZ3AlYpuVljfHd8GEzcTrU5crFSxMUh5iWfQbhzDx9oEccoMEhRxlcGNifuTSAu5WD2VyqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32ZMRwqPSGR4GDe9+0zkb8PnIhXZSpzF0Qz3UfzfDaA=;
 b=M6BwSs2wCTGKSLN87Fs/1r7GRa2OgY0dqclKe1dJLz3h/kBkhf8mlkWFujQs2ihbTmQNpL4PBB96IhLsPKQN7ZT1bXlnq8F4Y5YkJ9hC6topPjnmJboffwItnizhdEQYzYQgJ6ifAWVxGTRvTAAZqd+JWHGmrjrVPtkhLUeNcClQOunJa/SZfE9uzmLQ9+3HlJE0WbcdP97S7J59DBpy0bOFroao3bEBl13IvkWb6xcwW89MyW+z4Bv6aPRGTM8On+rYs3wUVHYeYsfwyHmujwIJ8SxSXhVPwg93QK5iR0fdZ3ZyEjdl5wRKLY/BZw7uvkt64sUI/MRS4t11Kups8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32ZMRwqPSGR4GDe9+0zkb8PnIhXZSpzF0Qz3UfzfDaA=;
 b=DJ00o1hbUhQjSAA/Aa5jWzrj9DKxvSiog3k/i3BDntuFj+TTrgIXJtLehX3HYwsOe0ztX4TyqNBoFb04uaxOoJ9xpBKYiVzp4aRlABHlkFX5LwnqYD3v+Oki8WngAURFr0D7WI87EQQ37u90gLPTsO8E05eGUgPb9UYml8MH2Tc=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Sun, 3 Jan
 2021 23:05:32 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab%9]) with mapi id 15.20.3721.024; Sun, 3 Jan 2021
 23:05:32 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "mike@mnmoran.org" <mike@mnmoran.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Update AppKeys on transition to Phase 0
Thread-Topic: [PATCH BlueZ] mesh: Update AppKeys on transition to Phase 0
Thread-Index: AQHW4VaVXyLJQ4XV7kefazdVBPrweKoWhzCA
Date:   Sun, 3 Jan 2021 23:05:31 +0000
Message-ID: <0c8cef8b281cb114326cab63a4f434b917ae6c97.camel@intel.com>
References: <20210102222755.71019-1-mike@mnmoran.org>
In-Reply-To: <20210102222755.71019-1-mike@mnmoran.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: mnmoran.org; dkim=none (message not signed)
 header.d=none;mnmoran.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09e7a131-93ae-4e1e-f6df-08d8b03c1234
x-ms-traffictypediagnostic: MW3PR11MB4539:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45392AAD28B46B76F379C164E1D30@MW3PR11MB4539.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3s51oqyD6P6rEZaaVVTn7vPi9Hfs8IlEmsdFbfz2NRxlK1n1rJ8npElPZS+p1MPOL8DQup4/oIsh1x21K5Q2D3nKOMqX87UY4t9Tly26I+T7jfB1cgxX9dNTqx29qsXlEwRKhwPYjFiRF5DWLgSbISJtySx+8oX7d5AbZS0H/+yosl+o2c9ppeNhLJKOkQpnpa0ajRFi/sLgB9aZH1f7H0//vPgZXOBMHSsb/ZY0XwvXABFCr325nw1sYlyXBJMLDM6Aksol2+gCO6mCeBBZR3e1yd7pruYYRBwRNjTREw3VhXbbyWIr8Wk+BFMBO7Quy08Wgp6FRFr4A1w588e3YLKd2q0aKxhiRhmCoY6CB4s57ALvTktMGteOeZFDT+K8tPpWcnzBYHvZRGgqtY0/9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(66476007)(64756008)(36756003)(83380400001)(5660300002)(316002)(71200400001)(478600001)(86362001)(91956017)(76116006)(66556008)(66946007)(8676002)(66446008)(186003)(26005)(107886003)(4326008)(2616005)(110136005)(8936002)(6512007)(15650500001)(6486002)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NUt6clNtVS9XS2YzWDUvRmtmREVpWGp6dlMxT0paK2tldzJsNjUxZy8xcVhJ?=
 =?utf-8?B?SHZBdXBVdnBvdkNhaWxZWm1mV0trTTFQbWtKaGwranhWdWNqK253dURickN3?=
 =?utf-8?B?Q1FaZUt1Z2lQMlphN0N0K2ptNHk3K2ZtcE1EYysySUwwV1ZKZCtuL1B3MXZw?=
 =?utf-8?B?ai9oeWRZK3RQdCtNR2FMNjRRT2w2VGYzR2tpNkNTNlhKTzdGYXhicXd3Ym1W?=
 =?utf-8?B?d3dsSWNNTGRuaFFuTXlqYnhyYVFqZ0ltcUpkdDdDeDJMMUo5TWFvbnRiME9x?=
 =?utf-8?B?SnY1U25iV0ZVdkRROXZxbjBBSE45elVqRkpzV3R0aHQrTVN6UnlCRW4zL3dl?=
 =?utf-8?B?SzRWaGp4bWFjRm1rRzUzRzR6bVoraC8vWkhZcFRBMi80SCtuQWFSdkRHZVF3?=
 =?utf-8?B?QXhhV2FaaFFIZm1NdjdEa1Nvb2gyVGdPc3kwZVl2NWdjUHF2R0xubzhWL0pN?=
 =?utf-8?B?cjhtQUU4UGk3WDdEWTJ2cXpmSWRGZk1RMmxUZFVlTHdZbGpUMzBMeVhGOXM5?=
 =?utf-8?B?eFVMTEtYNTFLaDdCUGpDSGlBbnh0VG02d0duRjNLV1MxREg4c1BSNnFyMHRp?=
 =?utf-8?B?UE1GWEd2ODM3OHNGRHZjd0s5cnplaWYrc25NM2djMXp3cERKdFluKytvYkR6?=
 =?utf-8?B?RkpyK2I0enhWOE1TN3ZnamFleE42TnlHOWtEMG03SGNkSkFxTlVQWXBYa3lP?=
 =?utf-8?B?R2svcDZEZWxqNEhjSG04UWRVc2dpOXc2Z1ZQcnlreEZka1pKejZPV2lDL2FQ?=
 =?utf-8?B?dmgwd3U5L3lHb3hLR2M4clY4VEoyQzBlWmgrRjh0eUlwN29LaGtaQnRuc2Yx?=
 =?utf-8?B?d3huekkrRW1vdFlhUXNrUU1KbkQ0ZDY4Snd4eHNPd3BET28xRWlWdkdrZEVS?=
 =?utf-8?B?Yy9wd2M3THBsODU4N0xJblZpa0dlNmdGVUprOENXY3JzaktkVEdScGlmeHJG?=
 =?utf-8?B?a3pWamFMLzFqNm9Mb3BSYnMvWEJxL0RZWkhwcmNuR3VjbmFzMlFKdTBkL1RX?=
 =?utf-8?B?a2Y0QnVCRDBPa3V6eXEvZGsrdGw3VkxKaENFMDgySlVWNUdsZ1RuVm13WVRa?=
 =?utf-8?B?RTZJMmgyVHE4NHRQM0cxTTVtRzVEdllKbEg2VVFyTW1JMHNLTHVTRGtoaG9x?=
 =?utf-8?B?NWczMHBha2g3WkJWbnRZRXNvQXRWNDJRUTQ4UnRjUExZV3N3UkdwMHBsSERj?=
 =?utf-8?B?RW9LRXptRGU3Mng1MlBOMk1wZGhmWlhXSzRYN0pZbk0yK2FhTVVXNUh0S0pt?=
 =?utf-8?B?K29mcm5xK0h5QU9yQk42QmNhTmVMd0ZJaHZuWjJ2REg2K0hLNzUzNk1ZbmFa?=
 =?utf-8?Q?qwqfAiRjZqIvK3T2mifuhcHHvoqVG2PMR5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFFE93A218B2E848A5FC01C1424D4C60@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e7a131-93ae-4e1e-f6df-08d8b03c1234
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2021 23:05:32.1140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6GQNPo20zUAH0yr/k/74EAq8hsSW+AYdHFppXvIle55ZRkgjblWin8byZ+pTIc7gBpsLG+0HD2OxNMXpNTGHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4539
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGFlbCwNCg0KT24gU2F0LCAyMDIxLTAxLTAyIGF0IDE3OjI3IC0wNTAwLCBNaWNoYWVs
IE4uIE1vcmFuIHdyb3RlOg0KPiBBdCB0aGUgZW5kIG9mIHRoZSBtZXNoIEtleSBSZWZyZXNoIHBy
b2NlZHVyZSB3aGVuIGEgc3VibmV0DQo+IHRyYW5zaXRpb25zIHRvIFBoYXNlIDAsIGxvY2FsIEFw
cEtleXMgdGhhdCB3ZXJlIHVwZGF0ZWQgd2VyZQ0KPiBub3QgdXBkYXRpbmcgdW50aWwgdGhlIGJs
dWV0b290aC1tZXNoZCBkYWVtb24gd2FzIHJlc3RhcnRlZC4NCj4gDQo+IFRoaXMgcGF0Y2ggaXRl
cmF0ZXMgdGhlIEFwcEtleXMgYXQgdGhlIGVuZCBvZiBtZXNoIEtleSBSZWZyZXNoDQo+IHdoZW4g
dGhlIHN1Ym5ldCB0cmFuc2l0aW9ucyB0byBQaGFzZSAwLCBzZXR0aW5nIHRoZSBuZXcgc3RhdGUN
Cj4gb2YgZWFjaCB1cGRhdGVkIEFwcEtleS4NCj4gDQo+IC0tLQ0KPiAgbWVzaC9hcHBrZXkuYyB8
IDE4ICsrKysrKysrKysrKysrKysrKw0KPiAgbWVzaC9hcHBrZXkuaCB8ICAxICsNCj4gIG1lc2gv
bmV0LmMgICAgfCAgMiArKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9hcHBrZXkuYyBiL21lc2gvYXBwa2V5LmMNCj4gaW5kZXgg
NTQ5ZjVhODBkLi41MDRmNjdhYWIgMTAwNjQ0DQo+IC0tLSBhL21lc2gvYXBwa2V5LmMNCj4gKysr
IGIvbWVzaC9hcHBrZXkuYw0KPiBAQCAtNTAsNiArNTAsMjQgQEAgc3RhdGljIGJvb2wgbWF0Y2hf
Ym91bmRfa2V5KGNvbnN0IHZvaWQgKmEsIGNvbnN0IHZvaWQgKmIpDQo+ICAJcmV0dXJuIGtleS0+
bmV0X2lkeCA9PSBpZHg7DQo+ICB9DQo+ICANCj4gK3ZvaWQgZmluaXNoX2FwcF9rZXkodm9pZCAq
YSwgdm9pZCAqYikNCj4gK3sNCj4gKwlzdHJ1Y3QgbWVzaF9hcHBfa2V5ICprZXkgPSBhOw0KPiAr
CXVpbnQxNl90IG5ldF9pZHggPSBMX1BUUl9UT19VSU5UKGIpOw0KPiArDQo+ICsJaWYgKGtleS0+
bmV0X2lkeCAhPSBuZXRfaWR4KQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlpZiAoa2V5LT5uZXdf
a2V5X2FpZCA9PSBORVRfTklEX0lOVkFMSUQpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCWtleS0+
a2V5X2FpZCA9IGtleS0+bmV3X2tleV9haWQ7DQo+ICsNCj4gKwlrZXktPm5ld19rZXlfYWlkID0g
TkVUX05JRF9JTlZBTElEOw0KPiArDQo+ICsJbWVtY3B5KGtleS0+a2V5LCBrZXktPm5ld19rZXks
IDE2KTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIHN0cnVjdCBtZXNoX2FwcF9rZXkgKmFwcF9rZXlf
bmV3KHZvaWQpDQo+ICB7DQo+ICAJc3RydWN0IG1lc2hfYXBwX2tleSAqa2V5ID0gbF9uZXcoc3Ry
dWN0IG1lc2hfYXBwX2tleSwgMSk7DQo+IGRpZmYgLS1naXQgYS9tZXNoL2FwcGtleS5oIGIvbWVz
aC9hcHBrZXkuaA0KPiBpbmRleCAzYmI3MDQ0NWIuLmM4M2RkMDNmNiAxMDA2NDQNCj4gLS0tIGEv
bWVzaC9hcHBrZXkuaA0KPiArKysgYi9tZXNoL2FwcGtleS5oDQo+IEBAIC0xNiw2ICsxNiw3IEBA
IHN0cnVjdCBtZXNoX2FwcF9rZXk7DQo+ICBib29sIGFwcGtleV9rZXlfaW5pdChzdHJ1Y3QgbWVz
aF9uZXQgKm5ldCwgdWludDE2X3QgbmV0X2lkeCwgdWludDE2X3QgYXBwX2lkeCwNCj4gIAkJCQl1
aW50OF90ICprZXlfdmFsdWUsIHVpbnQ4X3QgKm5ld19rZXlfdmFsdWUpOw0KPiAgdm9pZCBhcHBr
ZXlfa2V5X2ZyZWUodm9pZCAqZGF0YSk7DQo+ICt2b2lkIGZpbmlzaF9hcHBfa2V5KHZvaWQgKmEs
IHZvaWQgKmIpOw0KPiAgY29uc3QgdWludDhfdCAqYXBwa2V5X2dldF9rZXkoc3RydWN0IG1lc2hf
bmV0ICpuZXQsIHVpbnQxNl90IGFwcF9pZHgsDQo+ICAJCQkJCQkJdWludDhfdCAqa2V5X2lkKTsN
Cj4gIGludCBhcHBrZXlfZ2V0X2tleV9pZHgoc3RydWN0IG1lc2hfYXBwX2tleSAqYXBwX2tleSwN
Cj4gZGlmZiAtLWdpdCBhL21lc2gvbmV0LmMgYi9tZXNoL25ldC5jDQo+IGluZGV4IGIyNGNkYmE3
Ny4uMjJlYzAzZDdhIDEwMDY0NA0KPiAtLS0gYS9tZXNoL25ldC5jDQo+ICsrKyBiL21lc2gvbmV0
LmMNCj4gQEAgLTI2MDAsNiArMjYwMCw4IEBAIHN0YXRpYyBpbnQga2V5X3JlZnJlc2hfZmluaXNo
KHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MTZfdCBpZHgpDQo+ICANCj4gIAlsX3F1ZXVlX2Zv
cmVhY2gobmV0LT5mcmllbmRzLCBmcm5kX2tyX3BoYXNlMywgbmV0KTsNCj4gIA0KPiArCWxfcXVl
dWVfZm9yZWFjaChuZXQtPmFwcF9rZXlzLCBmaW5pc2hfYXBwX2tleSwgTF9VSU5UX1RPX1BUUihp
ZHgpKTsNCj4gKw0KDQpJIGxpa2Ugd2hlcmUgeW91IGFyZSBnb2luZyB3aXRoIHRoaXMsIEJVVC4u
Lg0KDQpQcm9iYWJseSBjcmVhdGUgYSBmdW5jdGlvbiBpbiBhcHBrZXkuYyB3aXRoIHRoZSBwcm90
b3R5cGU6DQp2b2lkIGFwcGtleV9maW5hbGl6ZShzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgdWludDE2
X3QgbmV0X2lkeCk7DQoNCmFuZCBzaW1wbHkgY2FsbGluZyB0aGF0IGZyb20gbmV0LmMuLi4NCg0K
MS4gTm90ZSAicHVibGljIiBuYW1pbmcgY29udmVudGlvbiBvZiBhcHBrZXlfKg0KMi4gV2UgdHJ5
IG5vdCB0byBtYWtlIGxfcXVldWUqIGNhbGxiYWNrcyBwdWJsaWMsIHNvIHRoYXQgZnVuY3Rpb24g
aXMgc3RhdGljLCBjYWxsZWQgZnJvbSBhIHdyYXBwZXIgZnVuY3Rpb24NCjMuIFdlIGhhdmUgYmVl
biBmYXZvcmluZyAiZmluYWxpemUiIGFzIHRoZSBwcmVmZXJlZCB0ZXJtaW5vbG9neSBmb3Iga2V5
IHJlZnJlc2ggY3BvbXBsZXRpb24NCjQuIE1heWJlIHVzZSBlaXRoZXIgMHhGRiBpbnN0ZWFkIG9m
IHRoZSBlcXVpdmlsZW50IE5FVF9OSURfSU5WQUxJRC4uLi4gICBBSUQgdmFsdWVzIGFyZSAqbm90
KiBOSURzLCBhbmQgd2UNCnNob3VsZCBiZSB1c2luZyBOSURzIGFuZCBBSURzIGludGVyY2hhbmdh
Ymx5Li4uICAgTWF5YmUgd2UgbmVlZCBhbiBBUFBfQUlEX0lOVkFMSUQgd2hpY2ggYWxzbyBpcyAw
eEZGLiAgVGhpcyBpcw0KYW4gb3ZlcnNpZ2h0IG9uIG15IHBhcnQgd2hpY2ggaXMgbm90IGhhcm1m
dWwsIGJ1dCBhbHNvIG5vdCBzdHJpY3RseSBjb3JyZWN0Lg0KDQoNCg0KPiAgCWlmICghbWVzaF9j
b25maWdfbmV0X2tleV9zZXRfcGhhc2Uobm9kZV9jb25maWdfZ2V0KG5ldC0+bm9kZSksIGlkeCwN
Cj4gIAkJCQkJCQlLRVlfUkVGUkVTSF9QSEFTRV9OT05FKSkNCj4gIAkJcmV0dXJuIE1FU0hfU1RB
VFVTX1NUT1JBR0VfRkFJTDsNCg==
