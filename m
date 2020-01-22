Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9ACC2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 16:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D42121835
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 16:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="nrZtSTE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgAVQst (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:48:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:52133 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgAVQss (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jan 2020 11:48:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 08:48:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="220369448"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga008.jf.intel.com with ESMTP; 22 Jan 2020 08:48:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 22 Jan 2020 08:48:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 22 Jan 2020 08:48:44 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 22 Jan 2020 08:48:44 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 22 Jan 2020 08:48:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwiPn4w96PckLrJPbzRDMJ+tUllNJlr8HInniwJzoh6bGI/myyfcZELXDfHeVdsDZzEzrD7CvWiQQ1Rb1cXSecRYlmid9f7oMaB6Fg7woXNCjA/vVlK8xEvvSSlvDLbv2oXMbErEQk4o9PEnhYoNwNybAUMwbh8uchaVmy1UxaysAWarh+zxnh4CLICbZ62AHwNyIxX91ozmZ4Q9Bd4zGt/nWaV20biOTUTVsnk+YqJFQURB49rhHbxSgwMNu7+Zu99mTmVYKw6TijP8aanm0Pj7OjiFEI6cjmGDPhU3RLwsvKP4ZEryqw2Xe0Ippz6rQMBrIFtzXAdZ8027bIV0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juGLXsZ9Y5kvNa/BmrZAyDRWq4f90zVqNgiJz7ZaJkg=;
 b=SEaiixhTHW4OAV9ORvzZobYYPIFKxNMs/eh05Tlc2t8JXGvjW2kzk2lw14Efn22ledMFAQDqS3GKWkQsk9GZxBxCQSeiyyVZFQ8Du2YPlMvQqVCvKf8/GR4JL6Kg/nt3PALfqWzsa9E4eAns76FMUH+I4Di0dzmazzc14joDCucQHMHZwnp5dmej5+GziYLp/5Y0ncSUgnTd/POZYj8d1G9Cs/oxS6s4GA7oUmRnsXk1PDOFo12bWyWXpKrzbF56BFAWQGxfQ7/4KxVFF8QaJiddTgMWDGOes4EgfmaYhkAqk+R0Q7HNKo7LvdJW0z/WS0glDMPuexT8muVvm2g4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juGLXsZ9Y5kvNa/BmrZAyDRWq4f90zVqNgiJz7ZaJkg=;
 b=nrZtSTE9G7fG/TTzBJ0jpsYUqyWzuO+BAuy4RtHxNhY0pu9xlEBDphG+UePmb3vtOMuVvxateU6ubjEUFmnvU8cUO3rzY3T9+gEtBs7gXjVpQ388lJNx33sQBiiwoOqss4Bnde2SSWPw0AfTuYwkwQHg60s+BDe9jkq/TZpMwNg=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1614.namprd11.prod.outlook.com (10.172.56.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 16:48:34 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 16:48:33 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] doc/mesh-api: Fix reference discrepancy for
 Import()
Thread-Topic: [PATCH BlueZ] doc/mesh-api: Fix reference discrepancy for
 Import()
Thread-Index: AQHV0NSkk+BPT4nYJkiGnXmPfgfK5Kf25eYA
Date:   Wed, 22 Jan 2020 16:48:33 +0000
Message-ID: <366f4b92a54ecf35d87d4855caa117eaa863105a.camel@intel.com>
References: <20200122033205.30072-1-inga.stotland@intel.com>
In-Reply-To: <20200122033205.30072-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8542d2e1-40a3-4d38-9034-08d79f5aeb4f
x-ms-traffictypediagnostic: MWHPR11MB1614:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1614C02E5406F50BAABE8CDDE10C0@MWHPR11MB1614.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(64756008)(66556008)(66476007)(66446008)(110136005)(36756003)(66946007)(2906002)(26005)(71200400001)(76116006)(6636002)(186003)(91956017)(6512007)(8676002)(6486002)(86362001)(4744005)(81156014)(2616005)(498600001)(6506007)(81166006)(5660300002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1614;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 80KDIzGKIz09HHWN+7Fy3puOaLSSN7FdrlS+mugelQKrM88WrcG5nbdZ1W0gpUxZKaxjqmYLoXRb1Yie46ZWsLeqGs45RtXh7hJCayl7IT1g8Hfbm+o29baSM5w3c5lrcTCZd9oev5ccyFI36S3kgOOA/339NRHe6w+CZygOwiahLJ9vQqb8XxuDiDhC5xYnsXqFYE5vMBlL4FiM8PWUtIxCNA5yqdoihnNM2IldEHmd2YBkt01+UmTjsKWHiO2USSLfD880ZrR5WD0pRgOvh7ILErEN90B0sH3z1FX4rC0ngLXYa+sS/HEKrIXkBx7C/8SX7G/Vq9IcDO8Iv7QwbXpVa7r0i6Sgz8VZTKngoIJlJiN8mJy5/ZJAnEtzqgnhEAIb3H5n7o0GcpgbSErmxXLbK4REOScIe4YOojJCzmktbZlU3N+0KIhgbzWmwaQX
Content-Type: text/plain; charset="utf-8"
Content-ID: <21899D41FC1ECA4FA30E73E7A87FF4FD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8542d2e1-40a3-4d38-9034-08d79f5aeb4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 16:48:33.8368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4vSNtetBeicbtSvEc/eG1Goikg+I2GVzNyxyfrITIH7bCAXwjbZzm9D9Fz5XcP115J7iSaSt4oqF5Sie1RUZuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1614
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVHVlLCAyMDIwLTAxLTIxIGF0IDE5OjMyIC0wODAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBSZW1vdmUgbWVudGlvbmluZyBvZiBJbXBvcnRMb2NhbE5vZGUoKSBtZXRob2Qs
IHVzZSBJbXBvcnQoKSBpbnN0ZWFkLg0KPiAtLS0NCj4gIGRvYy9tZXNoLWFwaS50eHQgfCA0ICsr
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZG9jL21lc2gtYXBpLnR4dCBiL2RvYy9tZXNoLWFwaS50eHQNCj4g
aW5kZXggZDgzYzY4YmRjLi4xMzFkZTZiZmQgMTAwNjQ0DQo+IC0tLSBhL2RvYy9tZXNoLWFwaS50
eHQNCj4gKysrIGIvZG9jL21lc2gtYXBpLnR4dA0KPiBAQCAtMjIyLDcgKzIyMiw3IEBAIFNlcnZp
Y2UJCW9yZy5ibHVlei5tZXNoDQo+ICBJbnRlcmZhY2UJb3JnLmJsdWV6Lm1lc2guTm9kZTENCj4g
IE9iamVjdCBwYXRoCS9vcmcvYmx1ZXovbWVzaC9ub2RlPHV1aWQ+DQo+ICAJCXdoZXJlIDx1dWlk
PiBpcyB0aGUgRGV2aWNlIFVVSUQgcGFzc2VkIHRvIEpvaW4oKSwNCj4gLQkJQ3JlYXRlTmV0d29y
aygpIG9yIEltcG9ydExvY2FsTm9kZSgpDQo+ICsJCUNyZWF0ZU5ldHdvcmsoKSBvciBJbXBvcnQo
KQ0KPiAgDQo+ICBNZXRob2RzOg0KPiAgCXZvaWQgU2VuZChvYmplY3QgZWxlbWVudF9wYXRoLCB1
aW50MTYgZGVzdGluYXRpb24sIHVpbnQxNiBrZXlfaW5kZXgsDQo+IEBAIC00NTIsNyArNDUyLDcg
QEAgU2VydmljZQkJb3JnLmJsdWV6Lm1lc2gNCj4gIEludGVyZmFjZQlvcmcuYmx1ZXoubWVzaC5N
YW5hZ2VtZW50MQ0KPiAgT2JqZWN0IHBhdGgJL29yZy9ibHVlei9tZXNoL25vZGU8dXVpZD4NCj4g
IAkJd2hlcmUgPHV1aWQ+IGlzIHRoZSBEZXZpY2UgVVVJRCBwYXNzZWQgdG8gSm9pbigpLA0KPiAt
CQlDcmVhdGVOZXR3b3JrKCkgb3IgSW1wb3J0TG9jYWxOb2RlKCkNCj4gKwkJQ3JlYXRlTmV0d29y
aygpIG9yIEltcG9ydCgpDQo+ICANCj4gIE1ldGhvZHM6DQo+ICAJdm9pZCBVbnByb3Zpc2lvbmVk
U2Nhbih1aW50MTYgc2Vjb25kcykNCg==
