Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B367BC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 05:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A12220705
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 05:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="sMjf2LZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgC0FKr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 01:10:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:53966 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgC0FKq (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 01:10:46 -0400
IronPort-SDR: dsCodUE41oGZBFsZLEXcVnjObAVZQqMuIAt4625wlm2EEpnaLrp6or9c7H08AGVfJbVruqLSGh
 qWk2wfkx9aIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 22:10:46 -0700
IronPort-SDR: HwuDj7zgVZxG7CchuHEXjklEkhWID21eti6/wsKSzPTzDxIK/BhrXVEXIE7E86i50zyJL8Uj7C
 eX4Ci9l8VZqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="394265646"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga004.jf.intel.com with ESMTP; 26 Mar 2020 22:10:45 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 22:10:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 22:10:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKLg2Zd3EylcTpqZOk/kwdNgLGDRLUgtcIUXww3vTB9Eoeew1JVK+DIAb2Nt71eZyK3661YDs8Nf5L5MCmThG4kKe55/s4RZiAM3A6mCWuFg8zXi0olyIpz9o8F5+T6Y5DjEr2jZkNphTma2MtaqJnBiFB3NouzWgITT01gRCd+nf3SVFDpFYHmCvQv2RwEd7EwcWL2tz2uPRKv3NvuBrHibgH6rIaP6eZ67Df1hOBG2OkR5jGhAXydr9DZQqCjAkzDEzUuQ1SlECfDPew3o+n1x3HGE7LqTAnWltRsjuk29/Z0RIBVhnu62wC3Ph8/3xWcyNXkHrkXak/hndU6ZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NALS3DvfTqo6u2xC78GUnviovtSAPoN04iAai+AhcS8=;
 b=chMUMAqK53wVu9/vnzbeBlPjwRPyQlPlGJpchhD8EUMhhP4hUpZi4uXBJ12jBnmC7tzVFlRp3/TqgQbY3sBRZify2NTDF62+3u7qv72cG4mWQK9lz4qU74fgTttSZ115y4csLmaN3U6/rEkq9pjrmMn7QV+VahyT27QhZTylqh94h2ysEMYDxAmg4y0B/CdtRq0tUg/GuHfZPdXNKN9drRpBf84IYppBvg8j8iBj4qT2M17L0Q3b3YqcQhKG6hgmNw7ATepplpqZLtHYRJd3N73FBKhJtw2BA24GO62LTmg8B68Bi+8DdWGa4Vw/8aTOvYFsjtL25RUVbq6gAR/4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NALS3DvfTqo6u2xC78GUnviovtSAPoN04iAai+AhcS8=;
 b=sMjf2LZpvv2DUFRulyEhXgDtvYvsi4FsP69KS15PECI6VlsV/rbHRt1lXiHmK0lxDs2mEXKj6zRO9Gsq0n2PQqyWAuIEKvIvNrL6ObLxYAInCQV4gT7WX/Ufj1PbjMUrJeAVl97NbMZnAKRLVedSBVRiWxXy5GFKMSNPHSlXYXE=
Received: from MWHPR11MB1423.namprd11.prod.outlook.com (2603:10b6:300:22::14)
 by MWHPR11MB1488.namprd11.prod.outlook.com (2603:10b6:301:c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Fri, 27 Mar
 2020 05:10:43 +0000
Received: from MWHPR11MB1423.namprd11.prod.outlook.com
 ([fe80::61cc:c5cd:21af:4e00]) by MWHPR11MB1423.namprd11.prod.outlook.com
 ([fe80::61cc:c5cd:21af:4e00%7]) with mapi id 15.20.2835.025; Fri, 27 Mar 2020
 05:10:43 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "anupam.r@samsung.com" <anupam.r@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "dh79.pyun@samsung.com" <dh79.pyun@samsung.com>,
        "semun.lee@samsung.com" <semun.lee@samsung.com>,
        "amit.jaiswal@samsung.com" <amit.jaiswal@samsung.com>
Subject: Re: Mesh Key Refreshment procedure from Config client
Thread-Topic: Mesh Key Refreshment procedure from Config client
Thread-Index: AQHWA4Dpq//CCphC7k67mv4pvD1fg6hb5R2A
Date:   Fri, 27 Mar 2020 05:10:42 +0000
Message-ID: <81d243b6c593e1edb6b36be87898fc57e1e5f0f2.camel@intel.com>
References: <20200326144743epcms5p401053700dae86ae93749df5fc77a2807@epcms5p4>
         <20200304153920epcms5p47e26659f715177b0244f18c71e4b5fed@epcms5p4>
         <CGME20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p2>
         <20200326145252epcms5p2b9b6bded2e2a5d9c68e680e9de403662@epcms5p2>
In-Reply-To: <20200326145252epcms5p2b9b6bded2e2a5d9c68e680e9de403662@epcms5p2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=inga.stotland@intel.com; 
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6089679b-9e4e-47a2-19a9-08d7d20d332f
x-ms-traffictypediagnostic: MWHPR11MB1488:
x-microsoft-antispam-prvs: <MWHPR11MB1488EE94B9E99A62EB1BBFDCFBCC0@MWHPR11MB1488.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(136003)(396003)(8936002)(478600001)(6512007)(6486002)(26005)(5660300002)(4326008)(91956017)(76116006)(186003)(36756003)(81156014)(66556008)(2616005)(2906002)(54906003)(110136005)(8676002)(86362001)(71200400001)(316002)(6506007)(66446008)(66946007)(81166006)(66476007)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1488;H:MWHPR11MB1423.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NzJlhLp5GZVBYqpbxaSmGCD8qL1g09OxXygclwMkFy/Hl7fNfs5vSGyqJAGY0/S2htdYNrWrLZmVMilPy5rOBQtUDVH1QzovCJNWgdZy95RWBGkGF6R8A60DcmsmREi4QQV/tR4vBEw8yMNTVKGWvksqlGHwyRFCJpLNp/Cz2ED/+TgUR7nyMZoh4vPYAWm5oHwt9E99yHD4WviE6QCxUSgn/eCFdLEkOMvOvLIjT0rPhGndAl6AfRlhibGxJ+ZfUmWBtjrcC1142hTPsIr2iuC6lIpMNBe49TwmyFCh931DHl2oo2o0qkqi2t+8LZbblXQTRWqxWms0wrieNbFa6DyYbXxvghiEVQMOgWHiOmOdEK6eAvk+8vm3DPbBV692FWFQ0UfksYXzaeoVziThBOnhjr5GpkXfo+LdKyqjfUUUG/KVPK5LEh8i13XJlKsQ
x-ms-exchange-antispam-messagedata: /vmntYbZjZm64fHuIpQ8kuge93h9uFMFzQkeE8dedFUbSJQpa9yWGJVo6HBjS2GfJmzqUwyGciP0rbf8u/hG8PiK1JT6J8Fx6jUucEk1Qs8Knj1SEORhWh3OWZy4ic8MYodI2DHKHM+E7irjcoqxvQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <981FDC9EB15C3C43A6BC62700636D431@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6089679b-9e4e-47a2-19a9-08d7d20d332f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 05:10:42.9328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGYUuohYQgo+70p8bCUAUHsX8a7cOCMtTZ7Dt96VYOTgiUAAfTnyj4H6hnBHS68sKSV4v4MDWV3hjeN7h7Zscg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1488
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQW51cGFtLA0KDQpPbiBUaHUsIDIwMjAtMDMtMjYgYXQgMjA6MjIgKzA1MzAsIEFudXBhbSBS
b3kgd3JvdGU6DQo+IEhpICwNCj4gIFByZXNlbnRseSwgSSBhbSB0cnlpbmcgdG8gY2hlY2sgKktl
eSBSZWZyZXNobWVudCBQcm9jZWR1cmUqIGZyb20gTWVzaCBDb25maWcgY2xpZW50Lg0KPiANCj4g
Rm9yIGNoZWNraW5nIHRoZSBvcGVyYXRpb24sIEkgZGlkIGZvbGxvd2luZyBzdGVwcw0KPiAgLSBD
cmVhdGUgU3VibmV0IGluIENvbmZpZyBjbGllbnQgYXQgTmV0IGluZGV4IDENCj4gIC0gQWRkIFN1
Yk5ldEtleSB0byBMb2NhbCBOb2RlIGF0IE5ldCBJbmRleCAxDQo+ICAtIEFkZCBTdWJOZXRLZXkg
dG8gUmVtb3RlIE5vZGUgYXQgTmV0IEluZGV4IDENCj4gDQoNClBsZWFzZSB0cnkgdG8gYWRkIHR3
byBzdGVwcyBtb3JlIGhlcmU6DQogICAtIFVwZGF0ZSBTdWJuZXQgMSAoc3VibmV0LXVwZGF0ZSBj
b21tYW5kIGluIG1haW4gbWVudSkNCiAgIC0gVXBkYXRlIE5ldEtleSAxIGZvciBhIGxvY2FsIG5v
ZGUgKHN3aXRjaCB0byBjb25maWcgbWVudSkNCg0KPiAgLSBVcGRhdGUgTmV0a2V5IHRvIHJlbW90
ZSBOb2RlIGluIE5ldCBpbmRleCAxDQo+IA0KPiBBZnRlciB1cGRhdGluZyB0aGUgTmV0a2V5LCBJ
IGJlbGlldmUsIGNvbmZpZyBjbGllbnQgaGFzIHRvIGVpdGhlciBzZW5kIG91dCBTTkIgd2l0aCBL
ZXlSZWZyZXNobWVudChLUikgRmxhZz0xICYgc2VjdXJlZCB3aXRoIHVwZGF0ZWQgTmV0S2V5IChp
LmUgYnkgc3VibmV0LT5uZXRfa2V5X3VwZCBpZCkNCj4gb3Igc2VuZCBvdXQgIkNvbmZpZyBLZXkg
UmVmcmVzaCBQaGFzZSBTZXQiIHdpdGggdHJhbnNpdGlvbiBwYXJhbWV0ZXIsIHNldCB0byAyLiBJ
IGNvdWxkIG5vdCBmaW5kIHRoZSBsYXRlciBwcm92aXNpb24gaW4gY2ZnY2xpZW50IG1lbnUuDQo+
IEhvd2V2ZXIsIENvbmZpZyBDbGllbnQgc2VlbXMgdG8gYmUgbm90IHNlbmRpbmcgb3V0IFNlY3Vy
ZSBOZXR3b3JrIEJlYWNvbiBhcyB3ZWxsLiBTbyBLUiBwcm9jZWR1cmUgc2VlbXMgdG8gYmUgbm90
IHByb2dyZXNzaW5nIGF0IG15IHNldHVwIGF0IHByZXNlbnQuDQo+IA0KPiBBbnkgaGludCBvZiB3
aGF0IGNvdWxkIGJlIG1pc3Npbmcgd2lsbCBiZSByZWFsbHkgaGVscGZ1bCEgVGhhbmsgWW91Lg0K
PiANCg0KQmVzdCBSZWdhcmRzLA0KSW5nYQ0K
