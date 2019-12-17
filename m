Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5759EC43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 21:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFA421775
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 21:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ImjK1IWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfLQVL5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:11:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:60709 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfLQVL5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 16:11:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 13:11:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="217928454"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga003.jf.intel.com with ESMTP; 17 Dec 2019 13:11:56 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Dec 2019 13:11:56 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.58) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 17 Dec 2019 13:11:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuDQhxZn4AxMH34jW86dMYj7tSNCvlXknaUC+UUu/pQFBqKqhIJEPxaPHFuAl8SehUd7g20h49ELVM2E3zQtJIrg1fCUohUYw6J4TbAtdSrolLj16YaiDxJWwcOV2g9QdGiFPOQFWjNKZpExrDj8Qd51BeNztwaoT4Cp6a1MzlN+GuQLI8TtIxVmhCpXF+thvToPQh58L3zm1wmdmUr2YRZEVga+Bw75jPbxzTrh3tL+O3TDDiLKEsMGIu1L7nX0SP+p7HppVYdPi2UP5xFDYjlFzr9BHptRuaHJq5etItxbKn9F2AQf1hbj12EIyOhHdEEMHS6QfoXi0/zYIWvn+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfp66Qn6D8jTfSyMzUJMJW8QEKJ7ifHLndSCFWzbpDE=;
 b=O28GFcfOiJPEfllJ7/wik65SwMMXaBILwF4zdUyEeIEMnrVYRVm7NiDZT/5IANF92U9O6N8jB50mUpuDM+CCA/X7TdO+tigbz6lzgAe9qPsUrNdXGjYS2yHp0lsAuJpKNfcEe5bYe5DPJdnEYL+1Ziy4g7HXxuewZzQLwqWQovi1jE5OYrnM62s2uGLaOTeHcJ0lcI9n7qaXLjm+v9dsQzMNkvYaocUya13DAxHECk2As93hzaYhvYKYvabguVCfLNaBTYrsoFXuJwc+9JfvzWS82+1Qi3oNmZlU//tWq5lIchx+whQIHIUDU6nyXY17qvqBDIT0CV3c8No6Mndy7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfp66Qn6D8jTfSyMzUJMJW8QEKJ7ifHLndSCFWzbpDE=;
 b=ImjK1IWMgORqhw8b/VqXqV2thScUhenIiH1x637TfG0AkfIKWBCdb7vJZN41DcmmQ9rJBGhikctTgAzjepI2o8Dt0XPSKV673HTyuncu4SV8O1zwst8COQ7wiqG7PWWGDJ6HY/rqL98ukVGvbE0ssbbGhs66gc5HFc+te3HPV2M=
Received: from SN6PR11MB3520.namprd11.prod.outlook.com (52.135.124.204) by
 SN6PR11MB2638.namprd11.prod.outlook.com (52.135.91.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Tue, 17 Dec 2019 21:11:53 +0000
Received: from SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45]) by SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45%7]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 21:11:53 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "Gix, Brian" <brian.gix@intel.com>,
        "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: mesh: Handling application failures on Create/Join/Import
Thread-Topic: mesh: Handling application failures on Create/Join/Import
Thread-Index: AQHVtQn3oaC/HlEvGUm58PNwhCFcs6e+qsgAgAACloCAAAFBgIAAAukAgAAB/wCAAA1KAIAAEkyA
Date:   Tue, 17 Dec 2019 21:11:53 +0000
Message-ID: <b019f8a18e0cbf814bfeba080407b02ae1490909.camel@intel.com>
References: <20191217184330.coc6c7b7hw4to6vx@kynes>
         <20191217184728.qoapokv7acfyaz33@kynes>
         <a51a523c15b52b9e5d837b7b9a1110a669db4e2b.camel@intel.com>
         <d61fcfad45256fe70b0f8cfaba30e031f57d3ce9.camel@intel.com>
         <20191217191138.ib7socqz4h4i4e5j@kynes>
         <450359d19e8b296f53b5dc03b649d7ce78d9d99a.camel@intel.com>
         <20191217200620.qnbhjevotlxfrwu3@kynes>
In-Reply-To: <20191217200620.qnbhjevotlxfrwu3@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=inga.stotland@intel.com; 
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8352e664-b6e9-443b-1333-08d78335bdb2
x-ms-traffictypediagnostic: SN6PR11MB2638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2638E6192C77C51847C84422FB500@SN6PR11MB2638.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(6512007)(4001150100001)(4744005)(478600001)(26005)(8936002)(110136005)(5660300002)(2616005)(6506007)(36756003)(6486002)(66946007)(76116006)(91956017)(66476007)(66556008)(64756008)(66446008)(71200400001)(2906002)(316002)(8676002)(4326008)(86362001)(186003)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2638;H:SN6PR11MB3520.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: peMQriB7XCtxmkq6bkQY6WPHPKhhKRBfGk+LF5aOcu/kIHN4xLdmyUzq9bG57XloO32WkcetVrJWdl3RvyXuUA1qGwcJjDXXI8BfGIINAOQAnKxffsH4hzJ0/eyLLmiVfoRYGpBXzZgfaKDi+wZTE059Mg5R0pqqZHyGMiTAKpUlnED7eMCHLBA/5ZpncdhdkzKytcesergdfNJ/E5VH4xmnG2xFcq2FKs8APRLNo5vwJGNRosnI2tFVl3A7jjOKxUJgMt7HQl50FcRsH4JAFVdBKc5VXsJUbLwF8e1ruVL3LZ8Rd0zQEtLasXnmAkrjBzdY1xwX9iCP1I2s69s+ypVZrtwaGufKO1C6xl0HExtbZqKmPq2Ja31tSKTNFkO7JxqfiQ+zw2K1z7gWgiCVSqqQluQ8ZW8eaAjK/kYBpuSJgbSuouVcxFmroAn1mixX
Content-Type: text/plain; charset="utf-8"
Content-ID: <56F13C8C1D9B9042BA20F486945BEB08@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8352e664-b6e9-443b-1333-08d78335bdb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 21:11:53.3564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9WVkJRBJVTS+6JFjbaQhzlJmr9LB0DI6+Zt9n82wJu8s4r82NXDkO+myjEUzEpn1k/nTKcc8L50t0P8P02+y6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2638
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGFsLCBCcmlhbiwNCg0KT24gVHVlLCAyMDE5LTEyLTE3IGF0IDIxOjA2ICswMTAwLCBt
aWNoYWwubG93YXMtcnplY2hvbmVrQHNpbHZhaXIuY29tDQp3cm90ZToNCj4gT24gMTIvMTcsIEdp
eCwgQnJpYW4gd3JvdGU6DQo+ID4gPiBJbmRlZWQuIFdvdWxkIHlvdSBiZSB3aWxsaW5nIHRvIGFj
Y2VwdCBhIHBhdGNoIHRoYXQgY2hhbmdlcyB0b2tlbg0KPiA+ID4gZGVsaXZlcnkgdG8gdXNlIEpv
aW5Db21wbGV0ZSBjYWxsIGluIGFsbCBjYXNlcywgYW5kIGNoZWNrcyB0aGF0IHRoZSBjYWxsDQo+
ID4gPiByZXR1cm5zIHN1Y2Nlc3NmdWxseT8NCj4gPiANCj4gPiBNYXliZS4uLiAgSSBuZWVkIHRv
IGRpc2N1c3MgaXQgd2l0aCBJbmdhLiAgSG93IGRvZXMgdGhpcyByZWxhdGUgdG8NCj4gPiBDcmVh
dGUoKSB0aG91Z2g/ICBUaGVyZSBpcyBubyBKb2luQ29tcGxldGUoKSBjYWxsIGN1cnJlbnRseSBh
eHMgYQ0KPiA+IHJlc3VsdCBvZiBDcmVhdGUoKS4uLiAganVzdCB0aGUgcmV0dXJuIHZhbHVlIGZy
b20gdGhlIENyZWF0ZSgpIG1ldGhvZC4NCj4gPiBJcyB5b3VyIHByb2JsZW0gdGhhdCB0aGUgZGFl
bW9uIGNhbm5vdCBiZSBzdXJlIHRoYXQgdGhlIHJldHVybiB2YWx1ZQ0KPiA+ICh0b2tlbikgZnJv
bSBDcmVhdGUoKSB3YXMgcmVjZWl2ZWQ/DQo+IA0KPiBZZXMsIGV4YWN0bHkuDQo+IA0KDQpBcyBt
dWNoIGFzIEkgZG9uJ3QgbGlrZSBBUEkgY2hhbmdlcyBpbiBhIHJlbGVhc2VkIGNvZGUsIHRoaXMg
c2VlbXMgdG8NCmJlIGEgbGVnaXRpbWF0ZSBjYXNlIGZvciBkb2luZyBzby4NCg0KU28geWVzLCBs
ZXQncyBjaGFuZ2UgdGhlIGxvZ2ljIHNvIHRoYXQgYWxsIHRocmVlIG1ldGhvZHMgKEpvaW4sIENy
ZWF0ZSwNCmFuZCBJbXBvcnQpIGhhdmUgdm9pZCByZXR1cm4gdmFsdWVzIGFuZCB0aGUgdG9rZW4g
aXMgZGVsaXZlcmVkIGluDQpKb2luQ29tcGxldGUoKS4gQSBub2RlIGlzICJmaW5hbGl6ZWQiIG9u
bHkgdXBvbiBzdWNjZXNzZnVsIHJldHVybiBvZg0KSm9pbkNvbXBsZXRlKCkuDQoNCkJlc3QgcmVn
YXJkcywNCkluZ2ENCg==
