Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C358C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Feb 2021 22:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E00D464E68
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Feb 2021 22:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhBPWpe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Feb 2021 17:45:34 -0500
Received: from mga06.intel.com ([134.134.136.31]:39367 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhBPWpd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Feb 2021 17:45:33 -0500
IronPort-SDR: HwJBxVhCj5Vaact5TbMNTm+dM6aTUSB+8HwAENldjbB17aXfJCn6shpGfZOGLHIg6n+72Rjhi4
 zOHKnpG4hptQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="244514001"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="244514001"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 14:44:52 -0800
IronPort-SDR: b5ZliNnY2zb2wG6fZWiVOYlsM0s7Xj9d3QIuulzCkNww/VOIgczTJSKa5WpPbFJsHwNIc/3d4K
 NFjRozPGJeIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="589409235"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2021 14:44:52 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Feb 2021 14:44:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 16 Feb 2021 14:44:51 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 16 Feb 2021 14:44:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEjAH2fkpmNEHbaBj35tPRnmubV1GAqyiFqnAwulgoFN+gePmHnLlExEr1awacPVDDGxga6KWMfF4afMM/HKhVkVZRk0js4GYhhgBYWiweVXfbfBknmNK9Y+3BnYfKELkunTkvIxGIxPIFNEHhChnSq8CYf+8sujaPYamtdpT/TqffWvKN1xsbJbqaAuVT3xXcX86g9reeRUYMLWJSkHCwAkyDFmLOK5pP/Y1znxtydEow2XwtOfE8jUoid1svXIh0PTVGQEodBWj+Ti5qXN8o4axP+5Q3ckpr8jqLEetYTg5+DsqNdugUQVWEU/XIyJ0cKQlUmaTd5GUgApuFoRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu+qAGLdfG8e32lVMRdl13rwdv1pRBnZLzOzB6pRcHA=;
 b=ZUEtsLW1O1MtooBKZWlyaqDHBnbxeu6w78H6RYRe+Lv93XId04ORx+NKBoS4pFlW8/SLWxMMgG/KIP6UNwYMXFTOrfpHveXkojk5i4QPDeUVNUto9YH1ghwd6IIZqg1gJnLDCi2w9GOaFVxy0PPkGaUhHwMp0LlPsENKk8j1ZcJm1xSg08yfIOO1ZS6mp4iyO13vckFD12TkVLjt8FUNPNeVs3x/HLrZcyCex9solLRz+/Fe9p/tqNFdD+A5kuOlK75ZRPBZbKKxe3OUF5yDs8z2e2+9zW2YgQQ4yvFI3CG2AEx0t2w0+qQXPpmnVSER3Ly3iNpV/4EI6Es38OrAEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu+qAGLdfG8e32lVMRdl13rwdv1pRBnZLzOzB6pRcHA=;
 b=kEUito0WlHnvYALcDcmnqp3iV600x0Aefldys0dij7eo3gBOWfl1OfY2BUQuVazgte0h2jAgTt1onF9ohICCQTm3wh7ds7ro7SUKOhRQJ/eFV9++tQNRAuySTXNeHGDXgIGh2YsRvQRH0595dlt8ZumfvBPvgIISowTDYvUaJAs=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4540.namprd11.prod.outlook.com (2603:10b6:303:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Tue, 16 Feb
 2021 22:44:48 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab%7]) with mapi id 15.20.3846.041; Tue, 16 Feb 2021
 22:44:48 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Combine common functions for NetKeys and
 AppKeys
Thread-Topic: [PATCH BlueZ] mesh: Combine common functions for NetKeys and
 AppKeys
Thread-Index: AQHXBKXDUBNBNzFA8UaZV6neYV9dwqpbYVuA
Date:   Tue, 16 Feb 2021 22:44:48 +0000
Message-ID: <d16e6a8a0f9958dd1e551fc81ccd0c1581f5c2f4.camel@intel.com>
References: <20210216205256.15300-1-inga.stotland@intel.com>
In-Reply-To: <20210216205256.15300-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e0c7170-08dc-46d2-30f9-08d8d2cc76fe
x-ms-traffictypediagnostic: MW3PR11MB4540:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB454043B478BFC679A3A40DEEE1879@MW3PR11MB4540.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dAqQDPgB/ihLiHZQ+eMq2+bj0KHY21g/s/bAQiBDCYF6WaisaW1b6Oavd6StS4ZoChgBjlVRIl7oEyqiiAqOQPJRT+oVskfPNMDsjW8j8lGLosNr+k0oW4YpFl+h2Y/87/ihG5coYlyFbClCQzeGQexKfykEwAOeCdfmgyZZO7GiKQ3OzHzESkMSuYsayJqFONJT/t7/jCkJMilUT2srGsw5NNbaUnthp70JWAV0yGr2292MlWFQIwVx1pVd6fd5Od7VQHBI2VhGs6OsWb31LVfv5EAgLYgAwEwtbZw9Ldyn+i/mY6ixRkmLDUm+TT1/+IkL31kfZn+2riUndWCEWP1CKTQELA0T/EzlaW2yVjwkAKo/tdx6cazWHxd0s97UtliIfVrXWIDhx1swEmhIma6xW39una/L7ceA0xTDLSs5AiZcStAbSHdTJNPbNMQnXhWSaGgOX4mD8ulgwLLq9SXKlVGue6+pncbcMLvwDo3hwP17OVBVfEuxSJufj5V5kMUgafSQX2aBCRl5Nvf4xQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(346002)(376002)(396003)(66476007)(2616005)(66946007)(6636002)(8676002)(66446008)(478600001)(76116006)(64756008)(71200400001)(6486002)(66556008)(26005)(83380400001)(186003)(110136005)(36756003)(8936002)(6512007)(316002)(5660300002)(2906002)(6506007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aU9wYnphQ3JibjdPdmJhZDY0VEVvWTQ0a21tT3p2MFNiNFBVT0FIUE1lUlZE?=
 =?utf-8?B?YWtyMFBwaExMVWd4ZE9ZcXRwM0o3TVhUNk56cHNpa3Vxd2xZbUxLOHZ0T0hT?=
 =?utf-8?B?NFJVbjN5QXgvOW1SclptcHRua0hmdXhWMnpuOWZMN0N4Z1UydTNQczMrUXhq?=
 =?utf-8?B?TlhyclZsaW1mRjlock5kNmNtVDZObEl0QWJVNnNKa3FJMGE2ZE56SWhURDFS?=
 =?utf-8?B?dGU0TTZiOVdoR3NScTZDcXUydTBwR25pSExCQTR2aGY2SWFNazljeFlEZnBm?=
 =?utf-8?B?cnEzM0xwZ0p4eUcvRzRvQmhnaXRiREd2Q3RUYm9zVjIyK2c4bW8xSnNDeHVt?=
 =?utf-8?B?eVhOelhUMU1MMTYrQTZSeHBzMTIwQytibWZwZnkzbzhXOHFCVU84VXBUa2ZD?=
 =?utf-8?B?S2syOWRRaWpUckgxVmRsNE00N0JKVVNLUk80d2RxYkE3cFkrb2xDVjlVcjZ4?=
 =?utf-8?B?eVV1TjZvM3RtOS9hMWl1Nkozb0xoa0oxNHJUNkdNZGdoTWFCdFYvTjNEaGlV?=
 =?utf-8?B?TE93V2c4WGVyaEJDRUkyZldvZ1Q2MzFaRU9UcTFDYUdHRktkWldTMzlMSkUw?=
 =?utf-8?B?RS9PL0lhQjN0SXRBc2M1bmZpUjFzZk5wZkh4TlROak5OelkxMjhtMTMrampz?=
 =?utf-8?B?UjB3bkhTTGZzT0lqZ1lLSk1ZRXhGQkFINnR5Q0dYb0RsNDBNclRkSEhFSWVF?=
 =?utf-8?B?SXNkL2kxRmw0UVFkbW5YUjA5WTMyVnB3aDFhQW44bWw2QkF0amxaYk5LcFpU?=
 =?utf-8?B?R3FzalFUSVJGRklsWkRvNS9lem14b3F0QlZBMmxNLzgrRXBRYlZsRTlKeWVt?=
 =?utf-8?B?VjU3YWx6OXlNdzdXaW1UVWt6K0oyaWxYZHhFWUZqL0Y0NXRoWlZlSGpPVzdt?=
 =?utf-8?B?QnVHZi95cnArRFJyZEprc3Jha0h6SjRtQlozb0U3N0dxRnVpeld0N3Z6UFpO?=
 =?utf-8?B?aHRzRkRtZVErQ1ZoenJCc0d0Znd3YlgzcXFKT0Izd0xEQjVEc1h0ZTBHWVNi?=
 =?utf-8?B?ZXFHcUs3VWd6ak1GbGJQcS9DS0FTazc4MWFsNFViSUZQTmZLL3FGV2tPQUFr?=
 =?utf-8?B?NWpLb3MxMkNOWWdqN2d3SDlYOTIybkk3cTdFQnRMRU1lMDZVOGh6cFEzektC?=
 =?utf-8?B?bTRTV3BlUzdtcmRmOW9VNVk1d3FHUHRiL3ZMVDZTbG5hQTRnREVnUDBFMDJw?=
 =?utf-8?B?aStjZUhrYk91K0tQZTJIUHVSWjUzUGtyNjdza3RXNmJVejNra29Sdk5QMzlR?=
 =?utf-8?B?WXVLMkRUeWFtVVF4N05kNTBrWjZCelpVWjhKa3NKT3NhZXFqVno4LzdwQWtw?=
 =?utf-8?B?TnJrWHduWTUxdDY5RTVqeTVuTGRvMlJCZ2RqMUJFbXQ5ci8rTjQ4ZHI0YzlF?=
 =?utf-8?B?YncrWmE0WDA3dWN4cnBwZXV6bUdYYTJaWiswS2VSa1dDT0tHcXJlMGFqYUlp?=
 =?utf-8?B?NUk1RlBHaUlEWGk1QVg5L3Z5QkU5Z3FEUjJWcXE1Q2s2ZmsxK0xBTm15Q2Yw?=
 =?utf-8?B?SG1QL0FOSWpLeTlhekxVdktOek9sU1p6V05lN3o3Y0hnYmY2V2xUbnVaQ1Nx?=
 =?utf-8?B?eURibmJpN2ZlRGpXMWh5aG1DRWJsL2s1SER3ZkR3RW1RVElKMEd3anl6anNr?=
 =?utf-8?B?OUROcVRCSWdwOGlzR0VNRFA5VE1jclJMODgyYkRNcU53c1hFdWlQVTE5L0hC?=
 =?utf-8?B?ejNNS21vejdDQjJDOTBPaXNIb1pwUWFTNXI2aEVzaGFuSjFDeFdtUEZ1TUY0?=
 =?utf-8?B?WFI2MmdqcVErT2xTSlNQZkRDVzdFc1FBVmh1elJsN0VjNUVidlhDdFNUaWw3?=
 =?utf-8?B?NWZxdXg2WTBkOFYwZEV0Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <677515EC07A6EB44A27C4573C283A5A9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0c7170-08dc-46d2-30f9-08d8d2cc76fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 22:44:48.3655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kykIbSv5c8C2tEe0+khO2jL/8tyKjmG6VSmcO/mdWzcW0FpZ1QJDtgdfTA26k0MaoxCSf6AlghGxeDqXyUEH7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4540
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSW5nYSwNCg0KT24gVHVlLCAyMDIxLTAyLTE2IGF0IDEyOjUyIC0wODAwLCBJbmdhIFN0b3Rs
YW5kIHdyb3RlOg0KPiBObyBjaGFuZ2UgaW4gZnVuY3Rpb2FuYWxpdHksIGNvZGUgdGlnaHRlbmlu
Zy4NCj4gLS0tDQo+ICBtZXNoL2tleXJpbmcuYyB8IDEyMCArKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNTAgaW5zZXJ0
aW9ucygrKSwgNzAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9rZXlyaW5n
LmMgYi9tZXNoL2tleXJpbmcuYw0KPiBpbmRleCAwYjc0ZWU5MTQuLjAyNTcwMzU3NCAxMDA2NDQN
Cj4gLS0tIGEvbWVzaC9rZXlyaW5nLmMNCj4gKysrIGIvbWVzaC9rZXlyaW5nLmMNCj4gQEAgLTMz
LDMxICszMyw0NSBAQCBjb25zdCBjaGFyICpkZXZfa2V5X2RpciA9ICIvZGV2X2tleXMiOw0KPiAg
Y29uc3QgY2hhciAqYXBwX2tleV9kaXIgPSAiL2FwcF9rZXlzIjsNCj4gIGNvbnN0IGNoYXIgKm5l
dF9rZXlfZGlyID0gIi9uZXRfa2V5cyI7DQo+ICANCj4gLWJvb2wga2V5cmluZ19wdXRfbmV0X2tl
eShzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCBuZXRfaWR4LA0KPiAtCQkJCQkJc3Ry
dWN0IGtleXJpbmdfbmV0X2tleSAqa2V5KQ0KPiArc3RhdGljIGludCBvcGVuX2tleV9maWxlKHN0
cnVjdCBtZXNoX25vZGUgKm5vZGUsIGNvbnN0IGNoYXIgKmtleV9kaXIsDQo+ICsJCQkJCXVpbnQx
Nl90IGlkeCwgYm9vbCBpc193cnQsIGludCBmbGFncykNCj4gIHsNCj4gIAljb25zdCBjaGFyICpu
b2RlX3BhdGg7DQo+IC0JY2hhciBrZXlfZmlsZVtQQVRIX01BWF07DQo+IC0JYm9vbCByZXN1bHQg
PSBmYWxzZTsNCj4gLQlpbnQgZmQ7DQo+ICsJY2hhciBmbmFtZVtQQVRIX01BWF07DQo+ICANCj4g
LQlpZiAoIW5vZGUgfHwgIWtleSkNCj4gLQkJcmV0dXJuIGZhbHNlOw0KPiArCWlmICghbm9kZSkN
Cj4gKwkJcmV0dXJuIC0xOw0KPiAgDQo+ICAJbm9kZV9wYXRoID0gbm9kZV9nZXRfc3RvcmFnZV9k
aXIobm9kZSk7DQo+ICANCj4gLQlpZiAoc3RybGVuKG5vZGVfcGF0aCkgKyBzdHJsZW4obmV0X2tl
eV9kaXIpICsgMSArIDMgPj0gUEFUSF9NQVgpDQo+IC0JCXJldHVybiBmYWxzZTsNCj4gKwlpZiAo
c3RybGVuKG5vZGVfcGF0aCkgKyBzdHJsZW4oa2V5X2RpcikgKyAxICsgMyA+PSBQQVRIX01BWCkN
Cj4gKwkJcmV0dXJuIC0xOw0KPiAgDQo+IC0Jc25wcmludGYoa2V5X2ZpbGUsIFBBVEhfTUFYLCAi
JXMlcyIsIG5vZGVfcGF0aCwgbmV0X2tleV9kaXIpOw0KPiArCWlmIChpc193cnQpIHsNCj4gKwkJ
c25wcmludGYoZm5hbWUsIFBBVEhfTUFYLCAiJXMlcyIsIG5vZGVfcGF0aCwga2V5X2Rpcik7DQo+
ICsJCW1rZGlyKGZuYW1lLCAwNzU1KTsNCj4gKwl9DQo+ICANCj4gLQlta2RpcihrZXlfZmlsZSwg
MDc1NSk7DQo+ICsJc25wcmludGYoZm5hbWUsIFBBVEhfTUFYLCAiJXMlcy8lMy4zeCIsIG5vZGVf
cGF0aCwga2V5X2RpciwgaWR4KTsNCj4gIA0KPiAtCXNucHJpbnRmKGtleV9maWxlLCBQQVRIX01B
WCwgIiVzJXMvJTMuM3giLCBub2RlX3BhdGgsIG5ldF9rZXlfZGlyLA0KPiAtCQkJCQkJCQluZXRf
aWR4KTsNCj4gLQlsX2RlYnVnKCJQdXQgTmV0IEtleSAlcyIsIGtleV9maWxlKTsNCj4gKwlpZiAo
aXNfd3J0KQ0KPiArCQlyZXR1cm4gb3BlbihmbmFtZSwgZmxhZ3MsIFNfSVJVU1IgfCBTX0lXVVNS
KTsNCj4gKwllbHNlDQo+ICsJCXJldHVybiBvcGVuKGZuYW1lLCBmbGFncyk7DQo+ICt9DQo+ICsN
Cj4gK2Jvb2wga2V5cmluZ19wdXRfbmV0X2tleShzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50
MTZfdCBuZXRfaWR4LA0KPiArCQkJCQkJc3RydWN0IGtleXJpbmdfbmV0X2tleSAqa2V5KQ0KPiAr
ew0KPiArCWJvb2wgcmVzdWx0ID0gZmFsc2U7DQo+ICsJaW50IGZkOw0KPiArDQo+ICsJaWYgKCFr
ZXkpDQo+ICsJCXJldHVybiBmYWxzZTsNCj4gKw0KPiArCWZkID0gb3Blbl9rZXlfZmlsZShub2Rl
LCBuZXRfa2V5X2RpciwgbmV0X2lkeCwgdHJ1ZSwNCj4gKwkJCQkJT19XUk9OTFkgfCBPX0NSRUFU
IHwgT19UUlVOQyk7DQo+ICANCj4gLQlmZCA9IG9wZW4oa2V5X2ZpbGUsIE9fV1JPTkxZIHwgT19D
UkVBVCB8IE9fVFJVTkMsIFNfSVJVU1IgfCBTX0lXVVNSKTsNCj4gIAlpZiAoZmQgPCAwKQ0KPiAg
CQlyZXR1cm4gZmFsc2U7DQo+ICANCj4gQEAgLTcyLDI4ICs4NiwxNCBAQCBib29sIGtleXJpbmdf
cHV0X25ldF9rZXkoc3RydWN0IG1lc2hfbm9kZSAqbm9kZSwgdWludDE2X3QgbmV0X2lkeCwNCj4g
IGJvb2wga2V5cmluZ19wdXRfYXBwX2tleShzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZf
dCBhcHBfaWR4LA0KPiAgCQkJCXVpbnQxNl90IG5ldF9pZHgsIHN0cnVjdCBrZXlyaW5nX2FwcF9r
ZXkgKmtleSkNCj4gIHsNCj4gLQljb25zdCBjaGFyICpub2RlX3BhdGg7DQo+IC0JY2hhciBrZXlf
ZmlsZVtQQVRIX01BWF07DQo+ICAJYm9vbCByZXN1bHQgPSBmYWxzZTsNCj4gIAlpbnQgZmQ7DQo+
ICANCj4gLQlpZiAoIW5vZGUgfHwgIWtleSkNCj4gKwlpZiAoIWtleSkNCj4gIAkJcmV0dXJuIGZh
bHNlOw0KPiAgDQo+IC0Jbm9kZV9wYXRoID0gbm9kZV9nZXRfc3RvcmFnZV9kaXIobm9kZSk7DQo+
IC0NCj4gLQlpZiAoc3RybGVuKG5vZGVfcGF0aCkgKyBzdHJsZW4oYXBwX2tleV9kaXIpICsgMSAr
IDMgPj0gUEFUSF9NQVgpDQo+IC0JCXJldHVybiBmYWxzZTsNCj4gKwlmZCA9IG9wZW5fa2V5X2Zp
bGUobm9kZSwgYXBwX2tleV9kaXIsIGFwcF9pZHgsIGZhbHNlLCBPX1JEV1IpOw0KDQprZXlyaW5n
X3B1dF9hcHBfa2V5IHdyaXRlcyB0byB0aGUgZmlsZSwgYnV0IHlvdSBhcmUgc2V0dGluZyBpc193
cnQgdG8gZmFsc2UuICBJcyB0aGF0IHdoYXQgeW91IHdhbnQ/ICBPciBtYXliZSwNCnNpbmNlIHRo
aXMgbWF0Y2hlcyB0aGUgZWFybGllciBmdW5jdGlvbmFpbGl0eSwgImlzX3dydCIgc2hvdWxkIGFj
dHVhbGx5IGJlICJpc19jcmVhdGUiLi4uICBTaW5jZSB3ZSBhcmVuJ3QNCipjcmVhdGluZyogdGhl
IGZpbGUsIHRoZSBTX0lSVVNSIHwgU19JV1VTUiBwZXJtaXNzaW9ucyBkbyBub3QgbmVlZCB0byBi
ZSBzZXQuDQoNCj4gIA0KPiAtCXNucHJpbnRmKGtleV9maWxlLCBQQVRIX01BWCwgIiVzJXMiLCBu
b2RlX3BhdGgsIGFwcF9rZXlfZGlyKTsNCj4gLQ0KPiAtCW1rZGlyKGtleV9maWxlLCAwNzU1KTsN
Cj4gLQ0KPiAtCXNucHJpbnRmKGtleV9maWxlLCBQQVRIX01BWCwgIiVzJXMvJTMuM3giLCBub2Rl
X3BhdGgsIGFwcF9rZXlfZGlyLA0KPiAtCQkJCQkJCQlhcHBfaWR4KTsNCj4gLQlsX2RlYnVnKCJQ
dXQgQXBwIEtleSAlcyIsIGtleV9maWxlKTsNCj4gLQ0KPiAtCWZkID0gb3BlbihrZXlfZmlsZSwg
T19SRFdSKTsNCj4gIAlpZiAoZmQgPj0gMCkgew0KPiAgCQlzdHJ1Y3Qga2V5cmluZ19hcHBfa2V5
IG9sZF9rZXk7DQo+ICANCj4gQEAgLTEwNSwxMiArMTA1LDEyIEBAIGJvb2wga2V5cmluZ19wdXRf
YXBwX2tleShzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCBhcHBfaWR4LA0KPiAgCQl9
DQo+ICANCj4gIAkJbHNlZWsoZmQsIDAsIFNFRUtfU0VUKTsNCj4gLQl9IGVsc2Ugew0KPiAtCQlm
ZCA9IG9wZW4oa2V5X2ZpbGUsIE9fV1JPTkxZIHwgT19DUkVBVCB8IE9fVFJVTkMsDQo+IC0JCQkJ
CQkJU19JUlVTUiB8IFNfSVdVU1IpOw0KPiAtCQlpZiAoZmQgPCAwKQ0KPiAtCQkJcmV0dXJuIGZh
bHNlOw0KPiAtCX0NCj4gKwl9IGVsc2UNCj4gKwkJZmQgPSBvcGVuX2tleV9maWxlKG5vZGUsIGFw
cF9rZXlfZGlyLCBhcHBfaWR4LCB0cnVlLA0KPiArCQkJCQkJT19XUk9OTFkgfCBPX0NSRUFUIHwg
T19UUlVOQyk7DQo+ICsNCj4gKwlpZiAoZmQgPCAwKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICAN
Cj4gIAlpZiAod3JpdGUoZmQsIGtleSwgc2l6ZW9mKCprZXkpKSA9PSBzaXplb2YoKmtleSkpDQo+
ICAJCXJlc3VsdCA9IHRydWU7DQo+IEBAIC0yMTIsOCArMjEyLDcgQEAgYm9vbCBrZXlyaW5nX3B1
dF9yZW1vdGVfZGV2X2tleShzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCB1bmljYXN0
LA0KPiAgCQkJCQkJZGV2X2tleV9kaXIsIHVuaWNhc3QgKyBpKTsNCj4gIAkJbF9kZWJ1ZygiUHV0
IERldiBLZXkgJXMiLCBrZXlfZmlsZSk7DQo+ICANCj4gLQkJZmQgPSBvcGVuKGtleV9maWxlLCBP
X1dST05MWSB8IE9fQ1JFQVQgfCBPX1RSVU5DLA0KPiAtCQkJCQkJCVNfSVJVU1IgfCBTX0lXVVNS
KTsNCj4gKwkJZmQgPSBvcGVuKGtleV9maWxlLCBPX1dST05MWSB8IE9fQ1JFQVQgfCBPX1RSVU5D
LCAwNjAwKTsNCg0KU28gYXJlIHdlIHVzaW5nIFNfSVJVU1IgfCBTX0lXVVNSIG9yIDA2MDA/DQoN
Cj4gIAkJaWYgKGZkID49IDApIHsNCj4gIAkJCWlmICh3cml0ZShmZCwgZGV2X2tleSwgMTYpICE9
IDE2KQ0KPiAgCQkJCXJlc3VsdCA9IGZhbHNlOw0KPiBAQCAtMjI2LDI0ICsyMjUsMTkgQEAgYm9v
bCBrZXlyaW5nX3B1dF9yZW1vdGVfZGV2X2tleShzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50
MTZfdCB1bmljYXN0LA0KPiAgCXJldHVybiByZXN1bHQ7DQo+ICB9DQo+ICANCj4gLWJvb2wga2V5
cmluZ19nZXRfbmV0X2tleShzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCBuZXRfaWR4
LA0KPiAtCQkJCQkJc3RydWN0IGtleXJpbmdfbmV0X2tleSAqa2V5KQ0KPiArc3RhdGljIGJvb2wg
Z2V0X2tleShzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCBjb25zdCBjaGFyICprZXlfZGlyLA0KPiAr
CQkJCQl1aW50MTZfdCBrZXlfaWR4LCB2b2lkICprZXksIHNzaXplX3Qgc3opDQo+ICB7DQo+IC0J
Y29uc3QgY2hhciAqbm9kZV9wYXRoOw0KPiAtCWNoYXIga2V5X2ZpbGVbUEFUSF9NQVhdOw0KPiAg
CWJvb2wgcmVzdWx0ID0gZmFsc2U7DQo+ICAJaW50IGZkOw0KPiAgDQo+IC0JaWYgKCFub2RlIHx8
ICFrZXkpDQo+ICsJaWYgKCFrZXkpDQo+ICAJCXJldHVybiBmYWxzZTsNCj4gIA0KPiAtCW5vZGVf
cGF0aCA9IG5vZGVfZ2V0X3N0b3JhZ2VfZGlyKG5vZGUpOw0KPiAtCXNucHJpbnRmKGtleV9maWxl
LCBQQVRIX01BWCwgIiVzJXMvJTMuM3giLCBub2RlX3BhdGgsIG5ldF9rZXlfZGlyLA0KPiAtCQkJ
CQkJCQluZXRfaWR4KTsNCj4gKwlmZCA9IG9wZW5fa2V5X2ZpbGUobm9kZSwga2V5X2Rpciwga2V5
X2lkeCwgZmFsc2UsIE9fUkRPTkxZKTsNCj4gIA0KPiAtCWZkID0gb3BlbihrZXlfZmlsZSwgT19S
RE9OTFkpOw0KPiAgCWlmIChmZCA+PSAwKSB7DQo+IC0JCWlmIChyZWFkKGZkLCBrZXksIHNpemVv
Zigqa2V5KSkgPT0gc2l6ZW9mKCprZXkpKQ0KPiArCQlpZiAocmVhZChmZCwga2V5LCBzeikgPT0g
c3opDQo+ICAJCQlyZXN1bHQgPSB0cnVlOw0KPiAgDQo+ICAJCWNsb3NlKGZkKTsNCj4gQEAgLTI1
MiwzMCArMjQ2LDE2IEBAIGJvb2wga2V5cmluZ19nZXRfbmV0X2tleShzdHJ1Y3QgbWVzaF9ub2Rl
ICpub2RlLCB1aW50MTZfdCBuZXRfaWR4LA0KPiAgCXJldHVybiByZXN1bHQ7DQo+ICB9DQo+ICAN
Cj4gK2Jvb2wga2V5cmluZ19nZXRfbmV0X2tleShzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50
MTZfdCBuZXRfaWR4LA0KPiArCQkJCQkJc3RydWN0IGtleXJpbmdfbmV0X2tleSAqa2V5KQ0KPiAr
ew0KPiArCXJldHVybiBnZXRfa2V5KG5vZGUsIG5ldF9rZXlfZGlyLCBuZXRfaWR4LCBrZXksIHNp
emVvZigqa2V5KSk7DQo+ICt9DQo+ICsNCj4gIGJvb2wga2V5cmluZ19nZXRfYXBwX2tleShzdHJ1
Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCBhcHBfaWR4LA0KPiAgCQkJCQkJc3RydWN0IGtl
eXJpbmdfYXBwX2tleSAqa2V5KQ0KPiAgew0KPiAtCWNvbnN0IGNoYXIgKm5vZGVfcGF0aDsNCj4g
LQljaGFyIGtleV9maWxlW1BBVEhfTUFYXTsNCj4gLQlib29sIHJlc3VsdCA9IGZhbHNlOw0KPiAt
CWludCBmZDsNCj4gLQ0KPiAtCWlmICghbm9kZSB8fCAha2V5KQ0KPiAtCQlyZXR1cm4gZmFsc2U7
DQo+IC0NCj4gLQlub2RlX3BhdGggPSBub2RlX2dldF9zdG9yYWdlX2Rpcihub2RlKTsNCj4gLQlz
bnByaW50ZihrZXlfZmlsZSwgUEFUSF9NQVgsICIlcyVzLyUzLjN4Iiwgbm9kZV9wYXRoLCBhcHBf
a2V5X2RpciwNCj4gLQkJCQkJCQkJYXBwX2lkeCk7DQo+IC0NCj4gLQlmZCA9IG9wZW4oa2V5X2Zp
bGUsIE9fUkRPTkxZKTsNCj4gLQlpZiAoZmQgPj0gMCkgew0KPiAtCQlpZiAocmVhZChmZCwga2V5
LCBzaXplb2YoKmtleSkpID09IHNpemVvZigqa2V5KSkNCj4gLQkJCXJlc3VsdCA9IHRydWU7DQo+
IC0NCj4gLQkJY2xvc2UoZmQpOw0KPiAtCX0NCj4gLQ0KPiAtCXJldHVybiByZXN1bHQ7DQo+ICsJ
cmV0dXJuIGdldF9rZXkobm9kZSwgYXBwX2tleV9kaXIsIGFwcF9pZHgsIGtleSwgc2l6ZW9mKCpr
ZXkpKTsNCj4gIH0NCj4gIA0KPiAgYm9vbCBrZXlyaW5nX2dldF9yZW1vdGVfZGV2X2tleShzdHJ1
Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCB1bmljYXN0LA0K
