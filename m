Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571E8C2D0CE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 00:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E182253D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 00:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="AdLYdEpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgAVAoG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 19:44:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:9279 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbgAVAoG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 19:44:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 16:44:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="220143318"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga008.jf.intel.com with ESMTP; 21 Jan 2020 16:44:05 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Jan 2020 16:44:05 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.59) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 21 Jan 2020 16:44:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/JOGn1exGCs0GHLdzct+5gFvaFgSk9HSX/ckh/63YaxhSnSIU/8nOYjHLD0E2d1pIW0H5is4/muXLVDz1FW0GKDnhPL2+nW683psfAcef7SrQUV9CyF4FZcBhYV5r0yaOTpzjLAnYcKObv2TKKdyAu8EwlB7fJ+kQ0jeQMz18yK6ZbaMmXth5imX83QY2qV2f+ZXne58q0wqPXubblXHDeD809CZuDEm0pNiTwgYJ/hMc23jzY6HL331sCmU150Aj/gm5GEZ4Nr3v4bhu/kxMkyc/o/0XwQmLE6C2AMWjoDlMlO1DUUVBhvJLYle9QcNGJL9guLl90KgCP0xfsApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccvICN/MuzUYX5NfM5Y4av758JolBkuOv/P6o0J1+ao=;
 b=NcN4LIjf1ulgXi8l0xTHIvgXum5Re5IJrGJP29g8Amu2bfqSQ6nautnLRTTVj545KRdbKJknwUUbRy76LCBSW7ZGq9io7YI4YK0lFZ5lhvOanH2/fTJBKhHK4RwUQtV3+Mw2h7gDa1df7lu3Dpoxb7iacvcUvUfltwOIGdPt9Agvs9401WNPvL+BwuczadP+zZv/0l+kpWE6QbQ6d890IS4w+S2mR+e8qEuYYj3h4h74J5eFA4aNoJKdOqBPaJQwoCTD8ECu6prWwVP+LeS3FtIvUExyRFjuF3sEVRGTfVg+v0fd+WNu712FDnLPUnoXPG2ykOU2FD225H2U34WlMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccvICN/MuzUYX5NfM5Y4av758JolBkuOv/P6o0J1+ao=;
 b=AdLYdEpnaxjI/11Z+fZq2ru2BY7SVSJ53mZrmeptd0kQNCyQcwBs4gyKd6EMjaY0N7mPeJUYgJfznbJkg8dYzMuLLsF0OTGIqQ6+Y5iaGKc0DDBotS8qtAGhRhirXBFGygFcA4sqU+SLYM384siPwjeb2Eyo/ujEJpXc7v7ajIk=
Received: from SN6PR11MB3520.namprd11.prod.outlook.com (52.135.124.204) by
 SN6PR11MB2830.namprd11.prod.outlook.com (52.135.91.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Wed, 22 Jan 2020 00:44:03 +0000
Received: from SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45]) by SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45%7]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 00:44:03 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [RFC BlueZ 0/2] Fix types and names of beacon/import flags.
Thread-Topic: [RFC BlueZ 0/2] Fix types and names of beacon/import flags.
Thread-Index: AQHVxshUCYbt3ihamkqLyRdAT/q4XKf1oVqAgABLKgA=
Date:   Wed, 22 Jan 2020 00:44:03 +0000
Message-ID: <8c665ad8c0856a3f8dd8e4d808599c953b5dfcd1.camel@intel.com>
References: <20200109083855.16000-1-michal.lowas-rzechonek@silvair.com>
         <20200121201501.v4ceigg5xngfvjb4@kynes>
In-Reply-To: <20200121201501.v4ceigg5xngfvjb4@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=inga.stotland@intel.com; 
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3606f5f7-901e-4f0b-7b44-08d79ed42dc3
x-ms-traffictypediagnostic: SN6PR11MB2830:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB283085946B2F89926E70C78AFB0C0@SN6PR11MB2830.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(26005)(186003)(36756003)(8676002)(6506007)(86362001)(4326008)(8936002)(6486002)(81156014)(81166006)(6512007)(2616005)(316002)(71200400001)(110136005)(107886003)(478600001)(5660300002)(2906002)(4744005)(91956017)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2830;H:SN6PR11MB3520.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jFJZQ3k87zzkhfYfZtPzj/9muviQN6/9eynLVynJpScizJUb9evm52HVkvHZwobv5BdwTvTd7JOXuhVOsOOUt83lge4oSKTfXadQ6OuUoZH9B6oT9zVJ84UQowWkbarWqA0N5OaA5r2yHmqZ5IRirfwdUJM6sT6MjqtSxts4qExwf9A1QS+eGpKQWQtVt1ZeUdsi2aEJ4Ha6q+9FJMxtvgp4qvpmf5T2fzJ8PVm3ULal/wUqUjWoz2Q3OwGaBDloCWUulWFam1hP7Sv3Q9G7blMlHe6b0BiqwBQjyFuHG0ch+hh/zak3HgAEq611gaYEA9KOT71bJoUOXeIxyAha0M/Bq6SkjOP/07bMrrJouYAp3eOVNX8ldExEedvcq/rZvyllK1FftXiDANUZvCkmSm47gX9np6eiIKVT3vJTpVLS8wFsPAnFuprPhg0ufrr9
Content-Type: text/plain; charset="utf-8"
Content-ID: <54F7AF5CCD57824A92E19FF78E1B4E7A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3606f5f7-901e-4f0b-7b44-08d79ed42dc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 00:44:03.3156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jkiE3DJjGGKA726l9YRW+19CtWKOUKZY9kJvU9UmfMv8pH9LHsBdqDNsYyqCrhIFLSTV/0qGSmPO888Tzfrsew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2830
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGFsLA0KDQpPbiBUdWUsIDIwMjAtMDEtMjEgYXQgMjE6MTUgKzAxMDAsIE1pY2hhxYIg
TG93YXMtUnplY2hvbmVrIHdyb3RlOg0KPiBIaSBCcmlhbiwgSW5nYSwNCj4gDQo+IE9uIDAxLzA5
LCBNaWNoYcWCIExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gPiBUaGlzIHBhdGNoc2V0IGFpbXMg
dG8gbWFrZSB0aGUgQVBJIGEgYml0IG1vcmUgY29uc2lzdGVudC4NCj4gPiANCj4gPiBTaWRlIHF1
ZXN0aW9uOiBhdCB0aGUgbW9tZW50IG5vbmUgb2YgdGhlIG5vZGUgcHJvcGVydGllcyBlbWl0DQo+
ID4gUHJvcGVydGllc0NoYW5nZWQgc2lnbmFsLiBJIHRoaW5rIHRoaXMgdmlvbGF0ZXMgRC1CdXMg
c3BlYywgc2luY2UgYWxsDQo+ID4gcHJvcGVydGllcyBhcmUgYXNzdW1lZCB0byBlbWl0IHRoZXNl
IHNpZ25hbHMgYnkgZGVmYXVsdCBbMV0gWzJdLg0KPiA+IA0KPiA+IFVuZm9ydHVuYXRlbHksIGF0
IHRoZSBtb21lbnQgRUxMIGRvZXMgbm90IHN1cHBvcnQgIkVtaXRzQ2hhbmdlZFNpZ25hbCINCj4g
PiBhbm5vdGF0aW9uLCBzbyBJJ2QgbGlrZSB0byBhZGQgdGhpcyB0byBFTEwsIGFubm90YXRlIG5v
ZGUNCj4gPiBwcm9wZXJ0aWVzIHdpdGg6DQo+ID4gICAgIC0gRmVhdHVyZXM6IGNvbnN0DQo+ID4g
ICAgIC0gQmVhY29uOiB0cnVlDQo+ID4gICAgIC0gQmVhY29uRmxhZ3M6IHRydWUNCj4gPiAgICAg
LSBJdkluZGV4OiB0cnVlDQo+ID4gICAgIC0gU2Vjb25kc1NpbmNlTGFzdEhlYXJkOiBmYWxzZSAo
Zm9yIHBlcmZvcm1hbmNlIHJlYXNvbnMpDQo+ID4gICAgIC0gQWRkcmVzc2VzOiBjb25zdA0KPiA+
IA0KPiA+IEFuZCBhbHNvIGVtaXQgUHJvcGVydGllc0NoYW5nZWQgd2hlcmUgcmVxdWlyZWQuDQo+
ID4gDQo+ID4gVGhvdWdodHM/DQo+IA0KPiBBbnkgY29tbWVudHMgYWJvdXQgdGhpcyBpZGVhLCBv
ciBzaG91bGQgSSBqdXN0IGdvIGFoZWFkIGFuZCBzZW5kIGENCj4gcGF0Y2g/DQo+IA0KDQpJIHRo
aW5rIHRoaXMgaXMgYSBnb29kIGlkZWEuIEkgYWdyZWUgd2l0aCB0aGUgcHJvcG9zZWQgbm9kZSBw
cm9wZXJ0aWVzDQphbm5vdGF0aW9ucy4NCg0KVGhhbmtzLA0KSW5nYQ0K
