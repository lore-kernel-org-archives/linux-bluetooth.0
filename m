Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F179DC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 18:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5D7214AF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 18:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="tnXil0CF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgAOSfS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:35:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:24727 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbgAOSfS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 13:35:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 10:35:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="213798047"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga007.jf.intel.com with ESMTP; 15 Jan 2020 10:35:12 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 10:35:12 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 15 Jan 2020 10:35:11 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 15 Jan 2020 10:35:11 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.53) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 15 Jan 2020 10:35:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y52Wt7WNE/v3sctq9CPtrzGPpWneFffMVmPKpCRvx5+QAMJ3kM1hMfBbdnoSqUSRz6bN90i/VN/xQVuQm1EFpjhlyQ/RiZ2F1SZWyijVdz3ZgPTGrkO+9aYbIAlqZSGFy6T3zbQFL7hwQf2r4XOZUhnX6yrt4mk/3oANWYPE1248bRf3yubDASAI2rRMHkuue8dAqG2Ljl9RKvmQTgfGMcAGJZNQ+CzJnhGY5MFi6k+0dxva3YJtaV5y8fsMwQfeXLL4lv/7njxUQ4nXVfU5fB4dTRxXUKGf1Dg8jVB+gGadBK6u5N/ZH1uZl4y+q0oQpuDaO+esWJlpOHWu4rExXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV+5rHuJB4li8xa65R7kOIRYyhruQg48rP+ZsUllVGo=;
 b=FtVT33B0OtCcJ0NU3oFnJ9uYcbru8EGBELRhDR3RKHz4WoItX8tnr5EkuVINFrRfS+lA6pxkxc8+Q4/jozU5qkIkWphMH2VIa+33UAJJJki5fXdqlsqq0vBvzdifxvhLHkCZXdPws1viuSaoVM8sTikRGhgEcCkfRoU0qCfEZe6ObulT0kw1pq8PfggUIwFekgUg/dvFKDsL2FJzCRg9xoVJ92Joka6ROioQP8XDSeDrsfVsxSWUTlIj8nVYQGE4b5MNKv2i/0ySphCdZkI5fj+5bVtEn0udQy+CamCo2d6CrhzqeiCU/+lpdkD1MtEHoiNO05W6JVwmpmI+H90wcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV+5rHuJB4li8xa65R7kOIRYyhruQg48rP+ZsUllVGo=;
 b=tnXil0CFmE1Vp1S6GfRprvzh61jAXQS4UzjnQUJ2i6/nH5KZOdN+idy9yN01eJXJ+7EFkO4ckuY7AhLxKHeb7CdZaNXx7ZsbqGxKAylcIh8AWj3OXv9T2m4d2h+emwZZvjzrj3vk3szTlymAOjdaIQaJ7n3/8my3qNt4puPKOv4=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1376.namprd11.prod.outlook.com (10.169.230.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 15 Jan 2020 18:35:06 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2623.017; Wed, 15 Jan 2020
 18:35:05 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "istotlan@ingas-xps13.amr.corp.intel.com" 
        <istotlan@ingas-xps13.amr.corp.intel.com>,
        "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: Re: [PATCH 0/1] Sequence number out of range fix
Thread-Topic: [PATCH 0/1] Sequence number out of range fix
Thread-Index: AQHVy8aSDlcsWuHBsESeDxHuzoHNCKfsDXQA
Date:   Wed, 15 Jan 2020 18:35:05 +0000
Message-ID: <4da92cbf6134822629bd2204fb7161c04008780e.camel@intel.com>
References: <20200115170830.7479-1-jakub.witowski@silvair.com>
In-Reply-To: <20200115170830.7479-1-jakub.witowski@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 262ffd81-2eaf-4ac7-3601-08d799e9a453
x-ms-traffictypediagnostic: MWHPR11MB1376:
x-microsoft-antispam-prvs: <MWHPR11MB1376042FDE11A310CE634BD0E1370@MWHPR11MB1376.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(376002)(39860400002)(366004)(199004)(189003)(86362001)(91956017)(66446008)(186003)(81166006)(2906002)(71200400001)(36756003)(6512007)(76116006)(66946007)(4326008)(6506007)(26005)(64756008)(2616005)(66556008)(66476007)(316002)(5660300002)(6486002)(54906003)(110136005)(8936002)(81156014)(8676002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1376;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dRf0N4AicFrxGaQd2IhiWsCdrtPTZ/tB9bYuCbfeJZXP8pXs+Uh5Rttmm/deML6unLEF6SwrjrZ6FGBkX+5A/4TLsAvLsChtKWUwNi1Ne6eVyfVmn8svoAP+wcNR2h8K9kIEmDKzqcfz7AG/gPFKaTpOhzBtanNXZs8Ea244TNBEHZPo+AwIKbDE8zlmRx9fAa4mZR0cRJ251KCMh+EtPboon2SQvCKEuanqF8VaBjT8Ox9A4wZin5SKEe8zIPKFFg42MyI6lygQ+0HYhc3YHPlL1hfNiGdru/0//POHy7xS3di1VVj6C7+Pm44GsLyvPLZh5fWJWW/YaGsN/1+/gK69vrsjKUeY++LgrOJIez4hS2JLjEMJXwIKFVyTQ+AGaheqg6NiEfOikMn+aMdigloOayu8cXhl5aglIaS9eZbKZ5newiyR+or9AJMK0ikz
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7448D1AB40A4A14D85C06388018A5563@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 262ffd81-2eaf-4ac7-3601-08d799e9a453
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 18:35:05.7202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54Z6/5+XEH1VeAmpKAuqG4HaS8SiTTD1BLwC3CEeRY34Kk4vUve2bOmF5xEUF7+7jSAuVAQcaBv8wBuuDYJpyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1376
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSmFrdWIsDQoNCk9uIFdlZCwgMjAyMC0wMS0xNSBhdCAxODowOCArMDEwMCwgSmFrdWIgV2l0
b3dza2kgd3JvdGU6DQo+IER1cmluZyBzZW5kaW5nIG1lc3NhZ2VzIHdpdGggaGlnaCBzcGVlZCwg
dGhlICdjYWNoZWQnIHZhbHVlIG1heSBoYXZlIGV4Y2VlZGVkIHRoZSAyNC1iaXQgcmFuZ2UNCj4g
YW5kIHRoaXMgdmFsdWUgd2lsbCBzYXZlIGludG8gc3RvcmFnZS4NCj4gDQo+IFRoZSBjdXJyZW50
IGltcGxlbWVudGF0aW9uIHByb3RlY3RzIHVzIGFnYWluc3QgZXhjZWVkaW5nIG1heCBzZXF1ZW5j
ZSBudW1iZXIgKDB4RkZGRkZGKS4NCj4gDQo+IEpha3ViIFdpdG93c2tpICgxKToNCj4gICBtZXNo
OiBzZXF1ZW5jZSBudW1iZXIgb3V0IG9mIHJhbmdlIGZpeA0KPiANCj4gIG1lc2gvbWVzaC1jb25m
aWctanNvbi5jIHwgNCArKysrDQo+ICBtZXNoL25ldC5jICAgICAgICAgICAgICB8IDMgKysrDQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiANCg0KVGhpcyBpcyBhIHZlcnkg
ZGFuZ2Vyb3VzIGNvdXJzZSBvZiBhY3Rpb24uICBUaGUgc3VnZ2VzdGVkIHBhdGNoIG1pZ2h0IHBv
dGVudGlhbGx5IGNhdXNlIGEgbm9kZSB0byByZS11c2UgYQ0Kc2VxdWVuY2UgbnVtYmVyIG1vcmUg
dGhhbiBvbmNlLCB3aGljaCB3b3VsZCBjYXVzZSBhICJkaXJ0eSBub25jZSIgY29uZGl0aW9uLCBh
bmQgYWxsb3cgdW5hdXRob3JpemVkIGVudGl0aWVzIHRvDQpkZXJpdmUgdGhlIGVuY3J5cHRlZCBk
YXRhIHdpdGhvdXQgdGhlIGtleXMuDQoNClRoZSBNZXNoIHdvcmtpbmcgZ3JvdXAgcHV0IGEgbG90
IG9mIHdvcmsgaW50byBkZXRlcm1pbmluZyB3aGF0IHNob3VsZCBiZSByYW5nZSBvZiBTZXF1ZW5j
ZSBOdW1iZXJzIGFuZCBJVg0KSW5kZXhlcywgYW5kIGNhbWUgdXAgd2l0aCB0aGUgMjQgYml0cyBv
ZiBzZXF1ZW5jZSBudW1iZXJzLCB3aGljaCBjYW4gYmUgcmVzZXQgdG8gMCB3aXRoIGFuIElWIElu
ZGV4IHVwZGF0ZQ0KZXZlcnkgMTkyIGhvdXJzLiAgVGhpcyB3aWxsIGFsbG93IGEgbm9kZSB0byBz
ZW5kIDI0IHBhY2tldHMgKGV2ZXJ5IDQybXMpIGEgc2Vjb25kIGNvbnN0YW50bHkgd2l0aG91dCBy
dW5uaW5nDQpvdXQgb2Ygc2VxdWVuY2UgbnVtYmVycy4gIFdoaWxlIHRoaXMgaXMgdGVjaG5pY2Fs
bHkgcG9zc2libGUsIGVzcGVjaWFsbHkgd2l0aCBhIGRhZW1vbiB0aGF0IG1pZ2h0IGJlIGxvb3Bp
bmcNCmJhY2sgbWVzc2FnZXMgaW50ZXJuYWxseSB3aXRob3V0IGV2ZXIgdXNpbmcgdGhlIE9UQSBp
bnRlcmZhY2UsIGl0IGlzIG5vdCByZWFsbHkgcG9zc2libGUgaW4gYW4gYWN0dWFsIEJUIGRyaXZl
bg0KcmVhbCBsaWZlIHN5c3RlbS4NCg0KDQpTbyBoZXJlIGlzIHRoZSBzb2x1dGlvbiBJIHdvdWxk
IHN1Z2dlc3Q6DQoNCkJlYWN1c2Ugd2Ugc3RvcmUgc2VxdWVuY2UgbnVtYmVycyBpbnRlcm5hbGx5
IHdpdGggYSB1MzIgc2l6ZWQgZGF0YSB0eXBlLCB3ZSBzaG91bGQgKmxldCogdGhlIHZhbHVlIGdv
IG92ZXIgdGhlDQptYXggbGVnYWwgc2VxdWVuY2UgbnVubWJ2ZXIgb2YgMHhGRkZGRkYgKHBlcmhh
cHMgY2FwcGluZyBpdCBhdCAweDAxMDAwMDAwIHRvIHByZXZlbnQgInN1cGVyIG92ZXJmbG93cyIp
LiAgVGhlbg0Kd2UgKnJlamVjdCogYWxsIHNlbmQgcmVxdWVzdHMgd2l0aCBhIHNlcXVlbmNlIG51
bWJlciA+IDB4RkZGRkZGLg0KDQpBc3N1bWluZyB0aGUgSVYgSW5kZXggdXBkYXRlIGxvZ2ljIGlz
IHdvcmtpbmcgY29ycmVjdGx5ICh0cmlnZ2VyZWQgaW50ZXJuYWxseSB3aGVuIHRoZSBTZXF1ZW5j
ZSBudW1iZXIgZ29lcw0Kb3ZlciAweDAwODAwMDAwLi4uIGhhbGYgdGhlIG1heCkgdGhlIG5vZGUg
d2lsbCB3b3JrIGp1c3QgZmluZSBhcyBsb25nIGFzIGl0IG5ldmVyIHRyaWVzIHRvIHNlbmQgbW9y
ZSB0aGFuIG9uZQ0KcGFja2V0IGV2ZXJ5IDQybXMgZm9yIDE5MiBob3VycyB3aXRob3V0IHJlc3Qu
Li4gIEp1c3QgYXMgdGhlIHNwZWNpZmljYXRpb24gaW50ZW5kZWQuICBJZiBpdCBkb2VzLCB0aGVu
IHRoZQ0Kc3BlY2lmaWNhdGlvbiBhbmQgY29kZSB3aWxsIGRpc2FsbG93IGl0LiANCg0KQlIsDQpC
cmlhbg0KDQo=
