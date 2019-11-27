Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F2DC432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 22:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4F42158A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 22:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="IsWB07qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfK0WwF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:52:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:60389 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfK0WwF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 17:52:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 14:52:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; 
   d="scan'208";a="206907652"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga008.fm.intel.com with ESMTP; 27 Nov 2019 14:52:04 -0800
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 27 Nov 2019 14:52:04 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX122.amr.corp.intel.com (10.22.225.227) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 27 Nov 2019 14:52:04 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.51) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 27 Nov 2019 14:52:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEKH38PGeRrMaGRXIv51hjhfusHF1cd1q9IaeN7Fia2NtHON88OjJI+Iq8/ytEM7Fyj3ZOom3f1Lgc0N1Hp0dQBNrv3nw9UiVF4f0CQGUssqS7/82zUqY91h+MKNVzcEBUQRCRJLdojLOlw/oSYf4AO55sF8yF3ssWID37egjsMNRINv8ienU2Ujlwpc8vTS+JcDB5ofEc5k0+zgq8VEjR2qmxu3eqcU0DujI/HzwUipSMJqPSbIOe6JdDp8CqkQtUoxwEl7d479kLPhsaXNmyQgMWE5oZ8MY99W2rcQf6TujMDBHtqfFdEz7euHdCsRZC8MtxNOEdlYZAlLADpzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ6YD9N/DUxUTV9NdVqwt3kB+ZXlWznAqcL+VXlwFjo=;
 b=VU2cjd0rxaxOU9xi6h0Ro/9y8GIsxwfW3eq3vXwVAqAbLKF2vMfU/Kn+mGAXBOQN5qjmtE/eh/yGetZGjfrxeYiASiLjhsKCyMQhEVXI4zWvLqU+0o0+tMoQir0cMrfgTrMDXSnxBSkTLlwk/adRYDie8+iu4AP6mJ1EIX1xkQnqDomyjYj+1vSt1M56ya4yrdft/lxz5c7UtTT5U5WNS473AWww4gcdcoLRvGS33MmtIZYf59UlVvV2tDue3wPFTSCpy2jm79l2ExwOVoi+Dbj2n/ekT8bRIrO78hdQVwPyQy2nJEarNvv7W+y3c6msOc6eLWooGQvbKFdxKN+d3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ6YD9N/DUxUTV9NdVqwt3kB+ZXlWznAqcL+VXlwFjo=;
 b=IsWB07qrYyoaIMEJ3Pia94LhFqZ/+V6hqoaiGByLh09rPVuN2I4m72+CdpKb1c581W7b3c3YfdxjGGaaKg4tGCA2dXE/0waEmlc1YPAaj2cEkgHJXxP4GnMyj/EhDHCRs4MDVcOiu+ke5H9kU4h3TcTjRvCie8nhzK3feZJ/LXc=
Received: from MWHPR1101MB2270.namprd11.prod.outlook.com (10.174.98.18) by
 MWHPR1101MB2094.namprd11.prod.outlook.com (10.174.255.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Wed, 27 Nov 2019 22:52:02 +0000
Received: from MWHPR1101MB2270.namprd11.prod.outlook.com
 ([fe80::4d58:954e:325b:1bfc]) by MWHPR1101MB2270.namprd11.prod.outlook.com
 ([fe80::4d58:954e:325b:1bfc%11]) with mapi id 15.20.2474.023; Wed, 27 Nov
 2019 22:52:02 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Venkat Vallapaneni <vallapaneni@socoptimum.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez meshctl error: socket operation on non-socket
Thread-Topic: bluez meshctl error: socket operation on non-socket
Thread-Index: AQHVpNmB1BrGXaui40afLcRxzNHhYKefoNxq
Date:   Wed, 27 Nov 2019 22:52:01 +0000
Message-ID: <78DAB7EA-B99D-4EDE-804B-7D127203DA1B@intel.com>
References: <b260550e-0884-662d-e395-90e7678cb1a7@socoptimum.com>
In-Reply-To: <b260550e-0884-662d-e395-90e7678cb1a7@socoptimum.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [97.126.71.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a592d22-03ab-4371-16ef-08d7738c6b09
x-ms-traffictypediagnostic: MWHPR1101MB2094:
x-microsoft-antispam-prvs: <MWHPR1101MB209410344D23497720D8B4AFE1440@MWHPR1101MB2094.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(396003)(366004)(39860400002)(189003)(199004)(26005)(66066001)(11346002)(186003)(446003)(81166006)(2616005)(53546011)(6506007)(76176011)(316002)(8936002)(102836004)(8676002)(81156014)(36756003)(6116002)(478600001)(25786009)(2906002)(14454004)(33656002)(86362001)(256004)(3846002)(71190400001)(71200400001)(6512007)(99286004)(6436002)(5660300002)(7736002)(6916009)(4326008)(6246003)(305945005)(66556008)(64756008)(66476007)(6486002)(66446008)(229853002)(76116006)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1101MB2094;H:MWHPR1101MB2270.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wa4Mox3k478nCGJkYFsudcwcTQTwduvCO/74M9aKCbp2ws3LLXQ2NMmLp36VY2cffwqD9llrDnSDy8yXQQ2v77TLKM3UB4/ioiCM1h7WruWHYP3NrfzUQ2zcWsMVtBu98HoElAl0kNamMKqJ2ojpgFAhAvl8Fl8LNi88Cde+E59COCO7KH/x6a04IXI4ZwrvcsCUby9rpwVmzc5tAtgDGkbYsgPLkxFftuA6h+zRVuz158fkORs+gHjNU8/SpggSc1Dm4QrLdfGCG50kt/9G4ek1M/VGjAhUwuncLwuv5OWZvGF7g3ukesPhA3/OOMzWG3ZNc9UTB9beOc7YmgHIDdUcs7ggi0sDI747pv3RHBmRjfqL4pEilvR7OWu0OlxdJAxRvF5ISpKRd9iY9OnYGlw6XQ6OfdgZDCStV20UBKy2URVwj7N5rWAsgGq4iJIZ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a592d22-03ab-4371-16ef-08d7738c6b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 22:52:01.4267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWAQlQq10HzXgsqL0T5U7Ubm7Vt0jrJpVykH7sF55M6mRlMijz5KQlXugmzqkBtHtzWXgr17aVdPjXQh8dpCLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2094
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgVmVua2F0LA0KDQpBcmUgeW91IGF0dGVtcHRpbmcgdG8gcHJvdmlzaW9uIGEgZGV2aWNlIHRo
YXQgcmVxdWlyZXMgUEItR0FUVCBwcm92aXNpb25pbmc/ICBJZiBzbywgdGhlIGJsdWV0b290aGQg
ZGFlbW9uIG11c3QgYmUgdXAgYW5kIHJ1bm5pbmcuIEhvd2V2ZXIsIHRoaXMgdG9vbCBpcyBvbGQs
IGFuZCB3aWxsIHByb2JhYmx5IGJlIGRlcHJlY2F0ZWQgYXQgc29tZSBwb2ludC4NCg0KSG93ZXZl
ciBtb3N0IE1lc2ggZGV2aWNlcyBzaG91bGQgc3VwcG9ydCBBZHZlcnRpc2luZyBiYXNlZCBwcm92
aXNpb25pbmcuDQoNClRoZSBNZXNoIGRhZW1vbiAoQmx1ZXRvb3RoLW1lc2hkKSBhbmQgdGhlIG1l
c2gtY2ZnY2xpZW50IHRvb2wgKGluIHRoZSB0b29scyBkaXJlY3RvcnkpIGhhcyBiZWVuIHVuZGVy
Z29pbmcgbW9kaWZpY2F0aW9uIGV2ZW4gc2luY2UgdjUuNTIsIHNvIHlvdSB3aWxsIHdhbnQgdG8g
Y2hlY2tvdXQgdGhlIHRpcC4NCg0KLi90b29scy9tZXNoLWNmZ2NsaWVudCBpcyB0aGUgdG9vbCBt
b3N0IGFwcHJvcHJpYXRlIGZvciBtZXNoIGRldmVsb3BtZW50IHRvZGF5LiANCg0KDQoNCj4gT24g
Tm92IDI2LCAyMDE5LCBhdCA4OjE2IFBNLCBWZW5rYXQgVmFsbGFwYW5lbmkgPHZhbGxhcGFuZW5p
QHNvY29wdGltdW0uY29tPiB3cm90ZToNCj4gDQo+IO+7v0hpLA0KPiANCj4gSSBhbSB0cnlpbmcg
dG8gdXNlIGJsdWV6IDUuNTIgZm9yIHByb3Zpc2lvbmluZyBhIGJsdWV0b290aCBtZXNoIGNhcGFi
bGUgZGV2aWNlLiBXaGVuIEkgZ2F2ZSBwcm92aXNpb24gPHV1aWQ+LCBJIGdldCB0aGlzIGJlbG93
IGVycm9yLiBQbGVhc2UgbGV0IG1lIGtub3cgd2hhdCBJIGFtIG1pc3NpbmcuDQo+IA0KPiBJIGFt
IHVzaW5nIGVsbCAwLjI2IG9uIHVidW50dSAxOC4wNC4gSSBhbSBhYmxlIHRvIHByb3Zpc2lvbiBz
dWNjZXNzZnVsbHkgd2l0aCBibHVleiA1LjUwLg0KPiANCj4gQWNxdWlyZVdyaXRlIHN1Y2Nlc3M6
IGZkIDggTVRVIDY5DQo+IEdBVFQtVFg6ICAgICAwMyAwMCAxMA0KPiAqc2VuZG1zZzogU29ja2V0
IG9wZXJhdGlvbiBvbiBub24tc29ja2V0KltaZXBoeXJdIw0KPiANCj4gUmdkcywNCj4gVmVua2F0
Lg0KPiANCj4gDQo=
