Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2EFC3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 16:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F482072D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 16:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="h/A7D9YM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgCEQER (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:04:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:36534 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgCEQER (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 11:04:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 08:04:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="439544254"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga005.fm.intel.com with ESMTP; 05 Mar 2020 08:04:16 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 5 Mar 2020 08:04:16 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 5 Mar 2020 08:04:16 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 5 Mar 2020 08:04:16 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 5 Mar 2020 08:04:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNWnKNhGZJZ0ejSy2dlo0Un/y4xr/kx09bOYSjXLv3c/xpQ+DO2rV7tHpeaI10f9RWDK6d04v2R8oCMjVXYfyDeGNf3RLVcjfZR65zlxUoIw4EeeS1YBgdpPK9hU2E2veBFMbZy3tsKZqeOMg1mOdh4NljgMauBaC30CQNKPRc27DfioVjBYES9uszHnFuN2qKUEO2leuY81LZXnirM1Pf2lkX19WuP2KpXUdliy7j3pKZqzdQFjZ9ZoFvjWTqdbL0Afos02lzHIC5rMR3J2QpoRhR0D5PLNGyMQA0eGkbZI5L1H1EddN9P/ne0DpCGjU63TDl3MwR7yGUwqEpDfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvUWks+JL+Hk9nHrl5/HqDLxC1RiAr9s6EsFF3SOuKg=;
 b=NCR5L3SxOeZiZqcLPZtq2OUm3Din8JmurFxZMc+RuYoOvxqIgAqujWiWycLdC+ZMUKn38U1uTj16AJIlAojvrRwAXi9HyzsZtvrkhwKNOaFpzv+4AoyWoaqTVIbLUGoLrHZpgMByS0ETwSmAF2TVYLcMoCjV0C940K7ftXZ9IRjN0vLvrNf1I6PlvYffzTYmsA860sNWvmPwyWKUVN+hYSwCJ3s59in3ucBvjcHbMQ0/2XhDoDVbiQumD/M0sJNCC0frO68NkfVD6gLtl+8pnvi3m3jHuOCxkkXLmpaJcN3eP9dQU3xO1tElLKNANzAJL2GFr5/4hlTt/u1t+svXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvUWks+JL+Hk9nHrl5/HqDLxC1RiAr9s6EsFF3SOuKg=;
 b=h/A7D9YMN1Z/kIpeVHXOsI6IcjBvzVjr+nuhaUvVRsRv2oSHwvy/TNNePx0irCEj920Z4rIsCh/PwzOSfGLE64odiKibWSadQ0rnt3KhpyRnFfpLV9VUCCwb7GXCR2/xWQ3Asw4BV98xLH2v2ZbECHxxgZRM48mAFV13rcDQJ8c=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4553.namprd11.prod.outlook.com (2603:10b6:303:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Thu, 5 Mar
 2020 16:04:10 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2793.013; Thu, 5 Mar 2020
 16:04:09 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] tools/mesh-cfgclient: Add address checks for
 pub/sub commands
Thread-Topic: [PATCH BlueZ] tools/mesh-cfgclient: Add address checks for
 pub/sub commands
Thread-Index: AQHV8NLpTr01oXUJMUWaU22/DG1tiqg6LcEA
Date:   Thu, 5 Mar 2020 16:04:09 +0000
Message-ID: <307481e5a956bc551c3266c5d64e951ac7d1b9e9.camel@intel.com>
References: <20200302204030.9150-1-inga.stotland@intel.com>
In-Reply-To: <20200302204030.9150-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42b58b2e-ddb1-4530-3c0b-08d7c11ed6d8
x-ms-traffictypediagnostic: MW3PR11MB4553:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45533523F327726C691B94A9E1E20@MW3PR11MB4553.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(136003)(396003)(346002)(199004)(189003)(110136005)(71200400001)(6506007)(2906002)(86362001)(81156014)(8936002)(81166006)(6636002)(8676002)(316002)(91956017)(186003)(66476007)(5660300002)(66556008)(66446008)(66946007)(36756003)(2616005)(64756008)(76116006)(26005)(6486002)(478600001)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4553;H:MW3PR11MB4539.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hcCRQZqs89W1Cfes2cB0XcQ33ejvyqqx3QI9MLCu+AxwWxZQdCNmXbno9be6yLzgiRrahxmlpjcdOxoK5WdNirMDjwIisTIUAVAMuuoGHE0DzSaE2HfZePITJqcv7L/+YZYfQmY8hJD/WRCYavA3yzW0Fe2II7BOnnkB2b71i76FwttKumUj8ODfrNXN/u/0RVEFBjQ93cEFhmbzFnacy7ENNzhAfgFFmNrBDvZJFi5UStZDqBhXvLhUy3sR9jV/s54AWOWq6JsPNVpER6FS/sEn0y5qdZS1INVAUKUPlspAS4O3Y7/SN1KESFtTey7M743GFo4cwg4yy93IG4HDPRfF8UjUgutlO9ZwjoCVhTc6dd/K/jM+6n1m1PYTwIB2srf0as5MqNhwXNqJ8lgyo080IuIizLNRVTORnCikKiarjqfgA+XMM8tjhmYGxZ8L
x-ms-exchange-antispam-messagedata: /gW8HARwKeT3tEEmKwaoz42w0hkjfheCARvAf33EZ6asUNwAHR/fwmx7O5HP8g4nbi+QH5XVxIvPfELZWvkDrpJppjvvFNgaPwZGo0+We8Aj3K1fjw5TBJ+F0KV1zk7pSGj6k8SzrxT4kkAll3oUIQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <24F8B2742FC1244BB7D5021E9EED6953@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b58b2e-ddb1-4530-3c0b-08d7c11ed6d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 16:04:09.2679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yFgNa667YybGTrlhLs/HXSi6LycwrmclkX4dGQRyYecEGaTlTWnLkgHYAOkVtgKLQks75D0zG1FRvjKTOkHMuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4553
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gTW9uLCAyMDIwLTAzLTAyIGF0IDEyOjQwIC0wODAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGlzIGFkZHJzIHZlcmlmaWNhdGlvbiBvZiBzdWJzY3JpcHRwaW9uIGFkZHJl
c3MgdmFsdWUgZW50ZXJlZCBvbg0KPiB0aGUgY29tbWFuZCBsaW5lOiB1bmFzc2lnbmVkIGFkZHJl
c3MsIHVuaWNhc3QgYWRkcmVzcywgYW5kDQo+IGFsbC1ub2RlcyBhZGRyZXNzIGFyZSBub3QgYWxs
b3dlZC4gUHVibGljYXRpb24gYWRkcmVzcyBjaGVjayB2ZXJpZmllcw0KPiB0aGF0IHRoZSBlbnRl
cmVkIHZhbHVlIGZhbGxzIGludG8gbWVzaCBhZGRyZXNzIHNwYWNlLg0KPiANCj4gQWxzbywgY2hh
bmdlIHRoZSB0eXBlIG9mIHBhcmFtZXRlciBjb3VudCBpbiBjb21hYW5kIHByb2Nlc3Npbmcgcm91
dGluZXMNCj4gZnJvbSBpbnQgdG8gdWludDMyX3QgdG8gbWF0Y2ggdGhlIHJldHJ1biB0eXBlIG9m
IHRoZSBwYXJhbWV0ZXIgcGFyc2luZw0KPiByb3V0aW5lLg0KPiAtLS0NCj4gIHRvb2xzL21lc2gv
Y2ZnY2xpLmMgfCA0NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS90b29scy9tZXNoL2NmZ2NsaS5jIGIvdG9vbHMvbWVzaC9jZmdj
bGkuYw0KPiBpbmRleCA1Yzk5MGQyZTguLjBhZWE3ZTU1MyAxMDA2NDQNCj4gLS0tIGEvdG9vbHMv
bWVzaC9jZmdjbGkuYw0KPiArKysgYi90b29scy9tZXNoL2NmZ2NsaS5jDQo+IEBAIC04MDIsNyAr
ODAyLDcgQEAgc3RhdGljIHN0cnVjdCBtZXNoX2dyb3VwICphZGRfZ3JvdXAodWludDE2X3QgYWRk
cikNCj4gIHsNCj4gIAlzdHJ1Y3QgbWVzaF9ncm91cCAqZ3JwOw0KPiAgDQo+IC0JaWYgKCFJU19H
Uk9VUChhZGRyKSkNCj4gKwlpZiAoIUlTX0dST1VQKGFkZHIpIHx8IGFkZHIgPj0gRklYRURfR1JP
VVBfTE9XKQ0KPiAgCQlyZXR1cm4gTlVMTDsNCj4gIA0KPiAgCWdycCA9IGxfcXVldWVfZmluZChn
cm91cHMsIG1hdGNoX2dyb3VwX2FkZHIsIExfVUlOVF9UT19QVFIoYWRkcikpOw0KPiBAQCAtMTA2
NCw3ICsxMDY0LDcgQEAgc3RhdGljIHZvaWQgY21kX2JpbmQodWludDMyX3Qgb3Bjb2RlLCBpbnQg
YXJnYywgY2hhciAqYXJndltdKQ0KPiAgew0KPiAgCXVpbnQxNl90IG47DQo+ICAJdWludDhfdCBt
c2dbMzJdOw0KPiAtCWludCBwYXJtX2NudDsNCj4gKwl1aW50MzJfdCBwYXJtX2NudDsNCj4gIA0K
PiAgCXBhcm1fY250ID0gcmVhZF9pbnB1dF9wYXJhbWV0ZXJzKGFyZ2MsIGFyZ3YpOw0KPiAgCWlm
IChwYXJtX2NudCAhPSAzICYmIHBhcm1fY250ICE9IDQpIHsNCj4gQEAgLTExMDEsNyArMTEwMSw3
IEBAIHN0YXRpYyB2b2lkIGNtZF9iZWFjb25fc2V0KGludCBhcmdjLCBjaGFyICphcmd2W10pDQo+
ICB7DQo+ICAJdWludDE2X3QgbjsNCj4gIAl1aW50OF90IG1zZ1syICsgMV07DQo+IC0JaW50IHBh
cm1fY250Ow0KPiArCXVpbnQzMl90IHBhcm1fY250Ow0KPiAgDQo+ICAJbiA9IG1lc2hfb3Bjb2Rl
X3NldChPUF9DT05GSUdfQkVBQ09OX1NFVCwgbXNnKTsNCj4gIA0KPiBAQCAtMTEyOCw3ICsxMTI4
LDcgQEAgc3RhdGljIHZvaWQgY21kX2lkZW50X3NldChpbnQgYXJnYywgY2hhciAqYXJndltdKQ0K
PiAgew0KPiAgCXVpbnQxNl90IG47DQo+ICAJdWludDhfdCBtc2dbMiArIDMgKyA0XTsNCj4gLQlp
bnQgcGFybV9jbnQ7DQo+ICsJdWludDMyX3QgcGFybV9jbnQ7DQo+ICANCj4gIAluID0gbWVzaF9v
cGNvZGVfc2V0KE9QX05PREVfSURFTlRJVFlfU0VULCBtc2cpOw0KPiAgDQo+IEBAIC0xMTUyLDcg
KzExNTIsNyBAQCBzdGF0aWMgdm9pZCBjbWRfaWRlbnRfZ2V0KGludCBhcmdjLCBjaGFyICphcmd2
W10pDQo+ICB7DQo+ICAJdWludDE2X3QgbjsNCj4gIAl1aW50OF90IG1zZ1syICsgMiArIDRdOw0K
PiAtCWludCBwYXJtX2NudDsNCj4gKwl1aW50MzJfdCBwYXJtX2NudDsNCj4gIA0KPiAgCW4gPSBt
ZXNoX29wY29kZV9zZXQoT1BfTk9ERV9JREVOVElUWV9HRVQsIG1zZyk7DQo+ICANCj4gQEAgLTEx
NzUsNyArMTE3NSw3IEBAIHN0YXRpYyB2b2lkIGNtZF9wcm94eV9zZXQoaW50IGFyZ2MsIGNoYXIg
KmFyZ3ZbXSkNCj4gIHsNCj4gIAl1aW50MTZfdCBuOw0KPiAgCXVpbnQ4X3QgbXNnWzIgKyAxXTsN
Cj4gLQlpbnQgcGFybV9jbnQ7DQo+ICsJdWludDMyX3QgcGFybV9jbnQ7DQo+ICANCj4gIAluID0g
bWVzaF9vcGNvZGVfc2V0KE9QX0NPTkZJR19QUk9YWV9TRVQsIG1zZyk7DQo+ICANCj4gQEAgLTEy
MDIsNyArMTIwMiw3IEBAIHN0YXRpYyB2b2lkIGNtZF9yZWxheV9zZXQoaW50IGFyZ2MsIGNoYXIg
KmFyZ3ZbXSkNCj4gIHsNCj4gIAl1aW50MTZfdCBuOw0KPiAgCXVpbnQ4X3QgbXNnWzIgKyAyICsg
NF07DQo+IC0JaW50IHBhcm1fY250Ow0KPiArCXVpbnQzMl90IHBhcm1fY250Ow0KPiAgDQo+ICAJ
biA9IG1lc2hfb3Bjb2RlX3NldChPUF9DT05GSUdfUkVMQVlfU0VULCBtc2cpOw0KPiAgDQo+IEBA
IC0xMjMwLDcgKzEyMzAsNyBAQCBzdGF0aWMgdm9pZCBjbWRfdHRsX3NldChpbnQgYXJnYywgY2hh
ciAqYXJndltdKQ0KPiAgew0KPiAgCXVpbnQxNl90IG47DQo+ICAJdWludDhfdCBtc2dbMzJdOw0K
PiAtCWludCBwYXJtX2NudDsNCj4gKwl1aW50MzJfdCBwYXJtX2NudDsNCj4gIA0KPiAgCXBhcm1f
Y250ID0gcmVhZF9pbnB1dF9wYXJhbWV0ZXJzKGFyZ2MsIGFyZ3YpOw0KPiAgCWlmICghcGFybV9j
bnQgfHwgcGFybXNbMF0gPiBUVExfTUFTSykgew0KPiBAQCAtMTI1MSw3ICsxMjUxLDcgQEAgc3Rh
dGljIHZvaWQgY21kX3B1Yl9zZXQoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4gIHsNCj4gIAl1
aW50MTZfdCBuOw0KPiAgCXVpbnQ4X3QgbXNnWzQ4XTsNCj4gLQlpbnQgcGFybV9jbnQ7DQo+ICsJ
dWludDMyX3QgcGFybV9jbnQ7DQo+ICAJc3RydWN0IG1lc2hfZ3JvdXAgKmdycDsNCj4gIAl1aW50
MzJfdCBvcGNvZGU7DQo+ICAJdWludDE2X3QgcHViX2FkZHI7DQo+IEBAIC0xMjYzLDYgKzEyNjMs
MTEgQEAgc3RhdGljIHZvaWQgY21kX3B1Yl9zZXQoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4g
IAkJcmV0dXJuIGJ0X3NoZWxsX25vbmludGVyYWN0aXZlX3F1aXQoRVhJVF9GQUlMVVJFKTsNCj4g
IAl9DQo+ICANCj4gKwlpZiAocGFybXNbMV0gPiBBTExfTk9ERVNfQUREUkVTUykgew0KPiArCQli
dF9zaGVsbF9wcmludGYoIkJhZCBwdWJsaWNhdGlvbiBhZGRyZXNzICV4XG4iLCBwYXJtc1sxXSk7
DQo+ICsJCXJldHVybiBidF9zaGVsbF9ub25pbnRlcmFjdGl2ZV9xdWl0KEVYSVRfRkFJTFVSRSk7
DQo+ICsJfQ0KPiArDQo+ICAJcHViX2FkZHIgPSBwYXJtc1sxXTsNCj4gIA0KPiAgCWdycCA9IGxf
cXVldWVfZmluZChncm91cHMsIG1hdGNoX2dyb3VwX2FkZHIsIExfVUlOVF9UT19QVFIocHViX2Fk
ZHIpKTsNCj4gQEAgLTEzMTQsNyArMTMxOSw3IEBAIHN0YXRpYyB2b2lkIGNtZF9wdWJfZ2V0KGlu
dCBhcmdjLCBjaGFyICphcmd2W10pDQo+ICB7DQo+ICAJdWludDE2X3QgbjsNCj4gIAl1aW50OF90
IG1zZ1szMl07DQo+IC0JaW50IHBhcm1fY250Ow0KPiArCXVpbnQzMl90IHBhcm1fY250Ow0KPiAg
DQo+ICAJbiA9IG1lc2hfb3Bjb2RlX3NldChPUF9DT05GSUdfTU9ERUxfUFVCX0dFVCwgbXNnKTsN
Cj4gIA0KPiBAQCAtMTM0MSw3ICsxMzQ2LDcgQEAgc3RhdGljIHZvaWQgc3Vic2NyaXB0aW9uX2Nt
ZChpbnQgYXJnYywgY2hhciAqYXJndltdLCB1aW50MzJfdCBvcGNvZGUpDQo+ICB7DQo+ICAJdWlu
dDE2X3QgbjsNCj4gIAl1aW50OF90IG1zZ1szMl07DQo+IC0JaW50IHBhcm1fY250Ow0KPiArCXVp
bnQzMl90IHBhcm1fY250Ow0KPiAgCXN0cnVjdCBtZXNoX2dyb3VwICpncnA7DQo+ICAJdWludDE2
X3Qgc3ViX2FkZHI7DQo+ICANCj4gQEAgLTEzNTEsNiArMTM1NiwxMiBAQCBzdGF0aWMgdm9pZCBz
dWJzY3JpcHRpb25fY21kKGludCBhcmdjLCBjaGFyICphcmd2W10sIHVpbnQzMl90IG9wY29kZSkN
Cj4gIAkJcmV0dXJuIGJ0X3NoZWxsX25vbmludGVyYWN0aXZlX3F1aXQoRVhJVF9GQUlMVVJFKTsN
Cj4gIAl9DQo+ICANCj4gKwlpZiAoKCFJU19HUk9VUChwYXJtc1sxXSkgfHwgSVNfQUxMX05PREVT
KHBhcm1zWzFdKSkgJiYNCj4gKwkJCQkJCQkhSVNfVklSVFVBTChwYXJtc1sxXSkpIHsNCj4gKwkJ
YnRfc2hlbGxfcHJpbnRmKCJCYWQgc3Vic2NyaXB0aW9uIGFkZHJlc3MgJXhcbiIsIHBhcm1zWzFd
KTsNCj4gKwkJcmV0dXJuIGJ0X3NoZWxsX25vbmludGVyYWN0aXZlX3F1aXQoRVhJVF9GQUlMVVJF
KTsNCj4gKwl9DQo+ICsNCj4gIAlzdWJfYWRkciA9IHBhcm1zWzFdOw0KPiAgDQo+ICAJZ3JwID0g
bF9xdWV1ZV9maW5kKGdyb3VwcywgbWF0Y2hfZ3JvdXBfYWRkciwgTF9VSU5UX1RPX1BUUihzdWJf
YWRkcikpOw0KPiBAQCAtMTQxNiw3ICsxNDI3LDcgQEAgc3RhdGljIHZvaWQgY21kX3N1Yl9kZWxf
YWxsKGludCBhcmdjLCBjaGFyICphcmd2W10pDQo+ICB7DQo+ICAJdWludDE2X3QgbjsNCj4gIAl1
aW50OF90IG1zZ1szMl07DQo+IC0JaW50IHBhcm1fY250Ow0KPiArCXVpbnQzMl90IHBhcm1fY250
Ow0KPiAgDQo+ICAJbiA9IG1lc2hfb3Bjb2RlX3NldChPUF9DT05GSUdfTU9ERUxfU1VCX0RFTEVU
RV9BTEwsIG1zZyk7DQo+ICANCj4gQEAgLTE0NDMsNyArMTQ1NCw3IEBAIHN0YXRpYyB2b2lkIGNt
ZF9zdWJfZ2V0KGludCBhcmdjLCBjaGFyICphcmd2W10pDQo+ICB7DQo+ICAJdWludDE2X3QgbjsN
Cj4gIAl1aW50OF90IG1zZ1szMl07DQo+IC0JaW50IHBhcm1fY250Ow0KPiArCXVpbnQzMl90IHBh
cm1fY250Ow0KPiAgCWJvb2wgdmVuZG9yOw0KPiAgCXVpbnQzMl90IG9wY29kZTsNCj4gIA0KPiBA
QCAtMTQ3NCw3ICsxNDg1LDcgQEAgc3RhdGljIHZvaWQgY21kX21vZF9hcHBpZHhfZ2V0KGludCBh
cmdjLCBjaGFyICphcmd2W10pDQo+ICB7DQo+ICAJdWludDE2X3QgbjsNCj4gIAl1aW50OF90IG1z
Z1szMl07DQo+IC0JaW50IHBhcm1fY250Ow0KPiArCXVpbnQzMl90IHBhcm1fY250Ow0KPiAgCWJv
b2wgdmVuZG9yOw0KPiAgCXVpbnQzMl90IG9wY29kZTsNCj4gIA0KPiBAQCAtMTUwNCw3ICsxNTE1
LDcgQEAgc3RhdGljIHZvaWQgY21kX2hiX3B1Yl9zZXQoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkN
Cj4gIHsNCj4gIAl1aW50MTZfdCBuOw0KPiAgCXVpbnQ4X3QgbXNnWzMyXTsNCj4gLQlpbnQgcGFy
bV9jbnQ7DQo+ICsJdWludDMyX3QgcGFybV9jbnQ7DQo+ICANCj4gIAluID0gbWVzaF9vcGNvZGVf
c2V0KE9QX0NPTkZJR19IRUFSVEJFQVRfUFVCX1NFVCwgbXNnKTsNCj4gIA0KPiBAQCAtMTU0OSw3
ICsxNTYwLDcgQEAgc3RhdGljIHZvaWQgY21kX2hiX3N1Yl9zZXQoaW50IGFyZ2MsIGNoYXIgKmFy
Z3ZbXSkNCj4gIHsNCj4gIAl1aW50MTZfdCBuOw0KPiAgCXVpbnQ4X3QgbXNnWzMyXTsNCj4gLQlp
bnQgcGFybV9jbnQ7DQo+ICsJdWludDMyX3QgcGFybV9jbnQ7DQo+ICANCj4gIAluID0gbWVzaF9v
cGNvZGVfc2V0KE9QX0NPTkZJR19IRUFSVEJFQVRfU1VCX1NFVCwgbXNnKTsNCj4gIA0KPiBAQCAt
MTU5Nyw3ICsxNjA4LDcgQEAgc3RhdGljIHZvaWQgY21kX25ldHdvcmtfdHJhbnNtaXRfc2V0KGlu
dCBhcmdjLCBjaGFyICphcmd2W10pDQo+ICB7DQo+ICAJdWludDE2X3QgbjsNCj4gIAl1aW50OF90
IG1zZ1syICsgMV07DQo+IC0JaW50IHBhcm1fY250Ow0KPiArCXVpbnQzMl90IHBhcm1fY250Ow0K
PiAgDQo+ICAJbiA9IG1lc2hfb3Bjb2RlX3NldChPUF9DT05GSUdfTkVUV09SS19UUkFOU01JVF9T
RVQsIG1zZyk7DQo+ICANCj4gQEAgLTE2MTksNyArMTYzMCw3IEBAIHN0YXRpYyB2b2lkIGNtZF9m
cmllbmRfc2V0KGludCBhcmdjLCBjaGFyICphcmd2W10pDQo+ICB7DQo+ICAJdWludDE2X3QgbjsN
Cj4gIAl1aW50OF90IG1zZ1syICsgMV07DQo+IC0JaW50IHBhcm1fY250Ow0KPiArCXVpbnQzMl90
IHBhcm1fY250Ow0KPiAgDQo+ICAJbiA9IG1lc2hfb3Bjb2RlX3NldChPUF9DT05GSUdfRlJJRU5E
X1NFVCwgbXNnKTsNCj4gIA0K
