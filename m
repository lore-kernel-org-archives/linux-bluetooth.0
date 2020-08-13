Return-Path: <SRS0=cSIk=BX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF50BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Aug 2020 22:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF9EC20829
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Aug 2020 22:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="fu4iLUIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgHMWHw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:07:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:24095 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgHMWHw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Aug 2020 18:07:52 -0400
IronPort-SDR: uU9TxIzrmQCHm5z3E/myun4uTwjba/MBAOncizG4dgPMjEq1+A1MmylEvmbb21nwFY7nWET87H
 WHXeHoWW7zVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="218661152"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="218661152"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 15:07:51 -0700
IronPort-SDR: mre7UKtFWo4s4hVIrG8BCRnj1+bcCaXNn41pNeLDJDpjZeZ4cu7jo9cbXX49x0rjxIGFy8JYrA
 M7q1YpknI+Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="276968812"
Received: from orsmsx603-2.jf.intel.com (HELO ORSMSX603.amr.corp.intel.com) ([10.22.229.83])
  by fmsmga007.fm.intel.com with ESMTP; 13 Aug 2020 15:07:50 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 13 Aug 2020 15:07:50 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 13 Aug 2020 15:07:50 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX113.amr.corp.intel.com (10.22.240.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 13 Aug 2020 15:07:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 13 Aug 2020 15:07:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbzegjG1YrqTUOAMovTlXR5VrxhTqYyjLcSYLxzXiuM/T5jUEDLkWeYusxL9g7gePk3Mnt07U092hSkzd9d1sNUgT/yhSBMNc2yR8+rpJFtxtUh0VyafBzTwPjPo07bszVtOtfamEh9Xj9C9+bcWubglQeIvnS4wtKo4Y/USSdyFXHBesfEtKo5jIayxNHJatoLRY77XHT6dVS5c+GXZSrvlPGeX07k4+tsuLPu1Cfn5RhVvLrKY2kYRk4mg7IyitcHwj9ENuyMecWPutxih8bqSvcwJg9lTCvLzxhWmB9HtRFxCnVxBRhP+uw9AyaQudcqEvyqOeHzYPPycEniz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJmkOe4d0t242j6IN8kAQah/n2/h/HH84ArRYJi6634=;
 b=OObeSqJL92vdKKUSGSe0ajYkF1JxIMq2NPHr6GZ5UB0p22/48vnsNxmtiNKCUD8/luolaynPJTvKrWSno5leN8OFGAs9ElaTnYjoxTzf2XjNx5QLwoMINf9Y5f0TigDYUq15KXsARTe8FerOsRzjewTjC5L9pMNss7EkfJRuYmpzZ7yUpSLdB3N+Rt3j6Xwny6F82xoDHf8IjPyeKyMaz2jj5cFFsVwzYbJsw27X66k/zi0AB3Llkv81qDYWshhyL7QVTlknpdffuaq9bdABiL7VT6Qe7QhMvdGhNj6Akr+j9xNXK8YrXU/GJTqfrwmx/VOm280ZFOu+c3s2n3V8EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJmkOe4d0t242j6IN8kAQah/n2/h/HH84ArRYJi6634=;
 b=fu4iLUIXgyh7iNvX8CRHzJhEoF35JjAoaq1CLrmJL4UrmPr6xk5tHKbjfuIWC2wB0AxV/3zIKHlkrhJg7byI/8Esk+CR9YAWjHIdztcU4rfNfduXY6CtAcSX/pVZYnCfyVBhZqhNf/C4EWZ775f1TD7Fp3+yt1tyAVpItm42lro=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4540.namprd11.prod.outlook.com (2603:10b6:303:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 13 Aug
 2020 22:07:48 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3283.015; Thu, 13 Aug 2020
 22:07:48 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Don't add config server when loading from
 storage
Thread-Topic: [PATCH BlueZ] mesh: Don't add config server when loading from
 storage
Thread-Index: AQHWcS7fMTf7nS1atkC4hoybqdxjzak2mfyA
Date:   Thu, 13 Aug 2020 22:07:48 +0000
Message-ID: <86c5c593b4170cf3f75a9d2834a705cae79d3012.camel@intel.com>
References: <20200813050150.135751-1-inga.stotland@intel.com>
In-Reply-To: <20200813050150.135751-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56e1abb0-1c4a-483e-4cad-08d83fd550b2
x-ms-traffictypediagnostic: MW3PR11MB4540:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4540AB895782ECC76D184E66E1430@MW3PR11MB4540.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0RhhPKnty+9SFRDC/Rwpxvv3jABWOoe20yQSFwmPUEnUMCaDli3Zgje/ZUgMYz0R3WL+DW6MkH9JFl0TJ4NYdJROmuo5iQ5lbnUJFiTt3Igbi8eHf7PtcqllFji1Y3ZIv5m67F8bWZAq5e5bT3wh1hBZAyhDzorxHYHWmK4GdksUw1s3pNkrhWYSLuf155QYqXWemSzzd+UGE7T3/b9cvRvMU7E0ucGTrtJ9CtBwxzMWlamEUl3hmzA8619VgDjj2X435tfCLopG2m6bGuNu6Jv0xa8uMT7kA++6RRFRaSyrOO1q4FpmK3MyyFKyDrhx7rkIgFieINvANLS1NJzOzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(2616005)(5660300002)(6512007)(91956017)(2906002)(6486002)(36756003)(186003)(8936002)(6506007)(26005)(8676002)(478600001)(76116006)(64756008)(83380400001)(86362001)(66476007)(316002)(66446008)(71200400001)(4744005)(66946007)(66556008)(6636002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: UqoyJlaxcSCNNlXi6wnoUkKTEEpD4T96nbuc25m61jIbvfa2GKvXxAEtMvWVHNWSgKwXkRdvuMzxMHvULm2DpOxAY61j6A4HYGKIxMRFigiYfwSz4YU0bn0ohVRBScJWYgAsYhqY8cHKyi0RBprCH7vnhWnW6VfM4kNE+Un4Vmyrd+aSfb0tvlsgvEK+ixGIYN0Bvt0kgwuK5QXoQYzKfhb+tA382hzZG+jDJ3xozhK4Oc/xqLiUXJnL+xhX3KcYahh6sNC62lqRpSvfrM99YGT1D1MFVYkXnqatGudLORoakkw9Nh82Q8RJrebsP8sYJxq35Na6azVgr4sgqu+1qtsQkO0hEb3pfTgyv7+bcc54rXWSSGimKyUxtMokzikzX4gQcqoPz+IrwpTTmMmTUOlXZwecLOLfIOvCUC6833uhImOb41WdWPBZhTdiXamQuzD1W/ltVrGU8/xT6Z/TD2jA7Gsi+U7pLCeKPrFkEBCopSUgLO9gZm+SBkqd90F016obAjWOCqy8pLpvrczmIbrMkcn2ahxk9xEu2dobdy3GHDt4gT3bXi1gE6ONYUfW8p3PS4y7fADBEZyYn+M1O3CsSafnh5q+WtL/wmnKdkzIGQDS4tKcdHoz7EOieoykLPNQ19Vw9FAdZlBLClSDHA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <48816393DC249349BD5D802822C7462C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e1abb0-1c4a-483e-4cad-08d83fd550b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 22:07:48.5768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8f4hDaAMZP+bv/Njkll2fjxH+WsbnhBdJvA3tp5UxXIBNO8Kl/oT3tnKiO1tFqem6lqrkJWB+kT1a6AjJ917bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4540
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTA4LTEyIGF0IDIyOjAxIC0wNzAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBBZGRpbmcgYSBzb25maWcgc2VydmVyIG1vZGVsIHdoZW4gbG9hZGluZyBmcm9t
IHN0b3JhZ2UgaXMgdW5uZWNlc3NhcnksDQo+IHNpbmNlIHRoZSBkYWVtb24tZ2VuZXJhdGVkIHN0
b3JlZCBjb25maWd1cmF0aW9uIGFsd2F5cyBjb250YWlucw0KPiBjb25maWcgc2VydmVyIG1vZGVs
Lg0KPiBUaGlzIGFsc28gZml4ZXMgYSBtZW1vcnkgbGVhayBjYXVzZWQgYnkgYmFkIHBhcmFtZXRl
cnMgcGFzc2VkIHRvDQo+IG1lc2hfbW9kZWxfYWRkKCkNCj4gLS0tDQo+ICBtZXNoL25vZGUuYyB8
IDMgLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9tZXNoL25vZGUuYyBiL21lc2gvbm9kZS5jDQo+IGluZGV4IDRiNzA1ODdhZS4uMWVlZmZl
YjhiIDEwMDY0NA0KPiAtLS0gYS9tZXNoL25vZGUuYw0KPiArKysgYi9tZXNoL25vZGUuYw0KPiBA
QCAtMzUzLDkgKzM1Myw2IEBAIHN0YXRpYyBib29sIGFkZF9lbGVtZW50c19mcm9tX3N0b3JhZ2Uo
c3RydWN0IG1lc2hfbm9kZSAqbm9kZSwNCj4gIAkJaWYgKCFhZGRfZWxlbWVudF9mcm9tX3N0b3Jh
Z2Uobm9kZSwgZW50cnktPmRhdGEpKQ0KPiAgCQkJcmV0dXJuIGZhbHNlOw0KPiAgDQo+IC0JLyog
QWRkIGNvbmZpZ3VyYXRpb24gc2VydmVyIG1vZGVsIG9uIHRoZSBwcmltYXJ5IGVsZW1lbnQgKi8N
Cj4gLQltZXNoX21vZGVsX2FkZChub2RlLCBQUklNQVJZX0VMRV9JRFgsIENPTkZJR19TUlZfTU9E
RUwsIE5VTEwpOw0KPiAtDQo+ICAJcmV0dXJuIHRydWU7DQo+ICB9DQo+ICANCg==
