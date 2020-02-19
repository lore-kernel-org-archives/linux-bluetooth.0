Return-Path: <SRS0=cHq6=4H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9948C3404C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 02:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBBD24654
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 02:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Eyo4jVrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgBSCTM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:19:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:4708 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgBSCTL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 21:19:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 18:19:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,458,1574150400"; 
   d="scan'208";a="348823300"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga001.fm.intel.com with ESMTP; 18 Feb 2020 18:19:10 -0800
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Feb 2020 18:19:10 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX122.amr.corp.intel.com (10.22.225.227) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Feb 2020 18:19:10 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Feb 2020 18:19:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NT04+KhUcgSXBHD7bslKUNPbKNhDdYZBT3kYn9OVbvp3cjtMoUwbym5Fe/F6tE/UL8te/cJ1yddnC2odeTiMyGdK8jhBrbKFL2y3HDWtAMfFBR4f/AJxKW1hTDnNwKgahMQGkVHNqWB6xGZc+n1HADF2cXp1/tG2zdKG4rc15/LHWUjMclr8K7tQtX8+KUqkcJYKqFW9rFhDjfYJOVngfX/azikYv7GcTc7TanBKA78T98c4Uay2AT3VEHaACWv8xw8ymHapB3GmbVtbtb/mw7TL6ceTN6ib8WGRQ85ww5bafliPjjTPfA0Baccz3TygpZUKAx6BFDCQRr/P23QY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSCzDUwgeaP78WrnC0uXj+ccCOuPU6NZdmTN9X+B+jc=;
 b=iEsEim13V/4Pn3eTmccFM+NASnsGinH8Jp+4X9AtLf670h/XzqTPwiD66Rmu+4PK8DSozRhUBg0Otsb6uiHGoGLroiHSLVelg5D2lc21Sq5Nyc8sI+YRTIIC7e5dZB2lBcMsMLS+ZVGhMV9dh6rslwXjEbSRn+n3hgj7DU727jA5jhRd3k15CaJTjHcUt92RupZP4fjHeWzp7j+zesBYdXmviLNVbSBBslWhSXIWJPB2mSy57giK7Zp1drLFh4JeUAjSPhoO+mYPF0TYcyvSm53WNZSxShVaskmgytsZXEAocNK/CAg3xYVS/0Hz2+LF3oCcdNhES66HKniV+w4ZiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSCzDUwgeaP78WrnC0uXj+ccCOuPU6NZdmTN9X+B+jc=;
 b=Eyo4jVrwX2ZhO54Ts4SAbK5ZTF9uPCCrLXMO8ZMhuWZKWHUcwg82Dm3E3pFDUa038PKVojlThat8dlJJuWGBajuMVl/1bQGGPJpstJ5g6ehCHhse4RORqHlaRu/3E67R1dy8vurzOZsvSjA4OpBR8ZJH8cNyWVxx506RcPXCGUQ=
Received: from BN7PR11MB2580.namprd11.prod.outlook.com (52.135.246.155) by
 BN7PR11MB2708.namprd11.prod.outlook.com (52.135.252.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Wed, 19 Feb 2020 02:19:08 +0000
Received: from BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6]) by BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6%6]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 02:19:08 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] test/test-mesh: Fix output of MessageReceived
 method
Thread-Topic: [PATCH BlueZ] test/test-mesh: Fix output of MessageReceived
 method
Thread-Index: AQHV5jBm98dz/SPilkq3MPHFqitYtqghyYyA
Date:   Wed, 19 Feb 2020 02:19:08 +0000
Message-ID: <2e807afc4264d803d477218a4caf579331df0fa7.camel@intel.com>
References: <20200218075208.17135-1-inga.stotland@intel.com>
In-Reply-To: <20200218075208.17135-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6ec6849-1560-4297-ca0d-08d7b4e219e4
x-ms-traffictypediagnostic: BN7PR11MB2708:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2708B02493FFEE81E90F7191E1100@BN7PR11MB2708.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(110136005)(316002)(26005)(91956017)(66946007)(186003)(6512007)(76116006)(6486002)(5660300002)(81166006)(81156014)(36756003)(8676002)(66476007)(66556008)(66446008)(64756008)(2616005)(478600001)(6636002)(86362001)(8936002)(71200400001)(2906002)(15650500001)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR11MB2708;H:BN7PR11MB2580.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BOa58rTcactt6zkXMN0AARscPcNlvJ7mCkvsNE69Cg9m4f0W3BtLfxJhYvboQXvnwyM3CAXSPeZgb0TjFevtWJ6nKCwwNWof8EDJ3MOG4Gm99apz/7K3fYZwFQZjU5Vb0hAsjvO3XeYVd6oOYLemN9C+Cj6wwQz0frWDfKh/Y9fs1EjESpyHRl54LeY5ft3oYRN+qJW5vgUPcHJBTYQ4IV3+GWIyDZYi1njgwNVoSP+Xnovew8d+11QH+Z60o1SoZzjW7KolNVlLV2of3H86lLhX8cxgmmOcYq1qoyvPUONGRF4/m9J3aye3vrwW6tUoVU8Mlfonmshnn/efc2BesJVC7CNeg0sA+bqw4yfoSQ1AYVxlG/p1BoCp2IKooVYXTs2Bo+qpLR4Wp7SAw1JRgHg3+dQvZdXm2jy1WbZWg7vBuGi2zxrVtSwCx56Y9bgh
x-ms-exchange-antispam-messagedata: cUlMJtuEtkMh0fUHUIkR78LEsC+Gc/nMLqdwR15nfygFu9wbYWFRMnyjeQj/HF/+EqM9+7JBVtKCZeR1zwl3/YU5b6xbS3USbOKz8bwXahFD2elST9bupPJwl7vNOGUxN7JPojVmtWQYbhCKtFfk8A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <94C418E05A298641A89088A227C31D8A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ec6849-1560-4297-ca0d-08d7b4e219e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 02:19:08.5997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XdB3QGDSWpuNDwvII/SqBUzuavRAfRzLdwNDomytA14szU35lx4iV0X+D787sxIVwDGO6vZ5lKYo6bkew6i2wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2708
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gTW9uLCAyMDIwLTAyLTE3IGF0IDIzOjUyIC0wODAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGlzIGZpeGVzIGZvcm1hdHRlZCBvdXRwdXQgb2YgcmVjaWV2ZWQgbWVzc2Fn
ZSBwYXJhbWV0ZXJzLg0KPiAtLS0NCj4gIHRlc3QvdGVzdC1tZXNoIHwgMTEgKysrKysrKysrLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvdGVzdC90ZXN0LW1lc2ggYi90ZXN0L3Rlc3QtbWVzaA0KPiBpbmRleCA1
Nzc3ZmNlYmMuLjkyOWUyOGZkMyAxMDA3NTUNCj4gLS0tIGEvdGVzdC90ZXN0LW1lc2gNCj4gKysr
IGIvdGVzdC90ZXN0LW1lc2gNCj4gQEAgLTU1OSw4ICs1NTksMTUgQEAgY2xhc3MgRWxlbWVudChk
YnVzLnNlcnZpY2UuT2JqZWN0KToNCj4gIAlAZGJ1cy5zZXJ2aWNlLm1ldGhvZChNRVNIX0VMRU1F
TlRfSUZBQ0UsDQo+ICAJCQkJCWluX3NpZ25hdHVyZT0icXF2YXkiLCBvdXRfc2lnbmF0dXJlPSIi
KQ0KPiAgCWRlZiBNZXNzYWdlUmVjZWl2ZWQoc2VsZiwgc291cmNlLCBrZXksIGRlc3RpbmF0aW9u
LCBkYXRhKToNCj4gLQkJcHJpbnQoJ01lc3NhZ2UgUmVjZWl2ZWQgb24gRWxlbWVudCAlZCwgc3Jj
PSUwNHgsIGRzdD0lcycgJQ0KPiAtCQkJCQkJc2VsZi5pbmRleCwgc291cmNlLCBkZXN0aW5hdGlv
bikNCj4gKwkJcHJpbnQoKCdNZXNzYWdlIFJlY2VpdmVkIG9uIEVsZW1lbnQgJTAyeCcpICUgc2Vs
Zi5pbmRleCwgZW5kPScnKQ0KPiArCQlwcmludCgnLCBzcmM9JywgZm9ybWF0KHNvdXJjZSwgJzA0
eCcpLCBlbmQ9JycpDQo+ICsNCj4gKwkJaWYgaXNpbnN0YW5jZShkZXN0aW5hdGlvbiwgaW50KToN
Cj4gKwkJCXByaW50KCcsIGRzdD0lMDR4JyAlIGRlc3RpbmF0aW9uKQ0KPiArCQllbGlmIGlzaW5z
dGFuY2UoZGVzdGluYXRpb24sIGRidXMuQXJyYXkpOg0KPiArCQkJZHN0X3N0ciA9IGFycmF5X3Rv
X3N0cmluZyhkZXN0aW5hdGlvbikNCj4gKwkJCXByaW50KCcsIGRzdD0nICsgZHN0X3N0cikNCj4g
Kw0KPiAgCQlmb3IgbW9kZWwgaW4gc2VsZi5tb2RlbHM6DQo+ICAJCQltb2RlbC5wcm9jZXNzX21l
c3NhZ2Uoc291cmNlLCBrZXksIGRhdGEpDQo+ICANCg==
