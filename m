Return-Path: <SRS0=5Aiy=BV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FB4C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 18:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA872076C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 18:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="gMJ3jp+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgHKSKl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:10:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:2383 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgHKSKk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Aug 2020 14:10:40 -0400
IronPort-SDR: JMd2aaucZdUOAYnUHTHkGwaa2o4HIAxMfYkJq7GHLuIa78NIxW3JotnbTsV6t7pw7I7aiK6yUb
 4tL2E/iGZmeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="154925136"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="154925136"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 11:10:40 -0700
IronPort-SDR: AFzGw2COHN6ut8Zc0d1Qns59e79PGgvd/MIE4MBg6qgcHP5EX5uABiUi703XJrhI8IMW2sc5yl
 1bwedVuNtzdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="469527357"
Received: from unknown (HELO fmsmsx605.amr.corp.intel.com) ([10.18.84.215])
  by orsmga005.jf.intel.com with ESMTP; 11 Aug 2020 11:10:40 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Aug 2020 11:10:39 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Aug 2020 11:10:39 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 11 Aug 2020 11:10:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 11 Aug 2020 11:10:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ei6FWVkrnk5/JwtWssWLW2Wz0KQ3pSX9ARQ3nyfhJk/vVUl7Sdpa6WDZG1DMNpmSgIcSKy9Up7nKrE0dFVc/UbLGle+H48dxLhJl8HzCtbWo1DGURGnDHyzLxUz0P2y8UoOkMJfN9n+VSKHtRGi5ANMUbbh/jHwXw0jCA4KW3LtqCR2xqYrPcUizx7H/ERd0nSnszEuBtQ4f4Nt1SfhPBau1ZHxNwapZSioMo9ezkK8OlZU6xoAcVnK/aiO1nJbt0Ql9VdhU3WqcXqfDKyN7LJyd8enKC4tCCj8cB8Phc4O+V2sAC5JhJe3OCxre0psaDRMa4JjUMFNx0Z5adnriww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWOSM60GNsMCwKaxQaarQ7DwYvK6CQlmk/JuvtjjgVs=;
 b=nurV0UG87h6AGKl8XC+PMfXKi9VVkplnjH9O2DZ8Y2Uz3nmPUbmMXMHCb39KmF6rsO3e4SgZe6wqhjSpn1ZjQVlT29gznGygFqIh8ZXOxAoKXKfdTs8sCG2v4K5xw3rJOixTzXSaSvyO5HxCaRYhNEiQJuDChLefjcv9dK1aafZIkFCvN/GNvTxcl5AIdVc9EYlHM3jw4GVAzYevH7dU12aNeGN/ilabx4tOFQ59gd9yikPjB8AJnD3PPLaUe9P0s8TCLesVK5qEgVyOnYArEqFRlZAHgCJERewVR7hrPbu6w0RVt0To16MNckGgFTk/kMwiChNSwDRqf5kv3u23GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWOSM60GNsMCwKaxQaarQ7DwYvK6CQlmk/JuvtjjgVs=;
 b=gMJ3jp+Qfja2TrjWqsi8MCYH1jKOaZTiXuGlK/psTQHoNq7hwVWo6osRNHTvgd44cjdVlOtuVyNr8Ch8tR0IaStctoQYyGQ2DNejMX6aUDKrFHKlnhr/2FRZuDHyBW/jzMs86Feaio1tfMeqDXw9DlOFjMPr9Fpu+GNiXufBP5Q=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4602.namprd11.prod.outlook.com (2603:10b6:303:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Tue, 11 Aug
 2020 18:10:35 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 18:10:35 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix logic error when saving model
 subscriptions
Thread-Topic: [PATCH BlueZ] mesh: Fix logic error when saving model
 subscriptions
Thread-Index: AQHWcAOBLdRAgysY7UmYq3dZkeGf4KkzNWIA
Date:   Tue, 11 Aug 2020 18:10:35 +0000
Message-ID: <5e58663071e4179cd71bd96c4dd81a6f9d8d73b4.camel@intel.com>
References: <20200811171855.13189-1-inga.stotland@intel.com>
In-Reply-To: <20200811171855.13189-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc5a6e7d-dcce-408c-140d-08d83e21d815
x-ms-traffictypediagnostic: MW3PR11MB4602:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4602294ED8E0C9E4724C73F4E1450@MW3PR11MB4602.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dMFcLRhP3F7Qt7y7f2nCyIpCZAOoSmBoSLAsGESDMoVBmTwJRtGSqiVGSEFzjE/uK3BpyrZ5qyq79wLWBUZJgB1YIi180IEOGoEw9FkGGLCjR3fKnHmCbUK38w0nYQJT/CCy5qjVO+SQgCnIf8YKve3JAiIloj/zOXTjXwDpqunN0x6Gd3z/d0HQPuGreSW0Wu5vaZ/VOBxBKPFV+5156uQk93kqsAcNtJ7FbRcS3rGoiPNleFgfV08M9nIDWLsjuBhiJx0ThKZzwAf4I7V131QcbvWcT5pZfPSzXqt1+2YA7lN3L45pb0E1eLjrLBXWKrZ9Yj25XVPiQupCEApizw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(4744005)(6512007)(71200400001)(6486002)(86362001)(6636002)(8676002)(8936002)(2906002)(316002)(36756003)(478600001)(83380400001)(66556008)(6506007)(66446008)(110136005)(186003)(26005)(66476007)(64756008)(76116006)(2616005)(66946007)(91956017)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KxgXP3TajfpR9E8YACZTuSh3Lff6UPmbqE3wwxEjEXovr4U0yti5hcQ1dJDbwJ7YWkOh/xNFw2Ale7ta5gFK+qspnGqLve6AhcxcIjywc7h3rvI9FXKMzXlWRSETn2GeXZJie4TbhbDWAAqZ6bxoIcvpjMMmGG8eIZ0W4F/zOwrfzaNdwdhCX3U28cGkTwGFFDGM17C51r9Xtj0z7jhEgMtCGwsBozDj3xUz20RvpiLyehBx/rh3JQMN+5KI0fF3Vuo1YPCx4VUgroRqzmqf5CLbovEoTtu134QSftUtWGoyr2I3MkFRaqhppAHBKgNlyOzfDtwXjjRE2jlmcOREBPz7vG+MdmwSAzc+KciTF5o64c2wTx7HES2QcTAIkwzdjR4qiZs1U1ru2XvLhJF8Q77FGLiWRGyJs3lCJWrPfjbLyVL1s0sTkrmhMyaWSsGv7BCoNhJwXhYhSVIasPKMtNFkAj/qmIlWBMbQ+Qy7SL9H0QfOd62/nHwojWysrpfr2mlhzMa16e4HfLHJnkcFfxL2xxgmuNGoLjnefQXwu+WADqDOn/b6jDHYGyKuQwRp8OW1B0arLZBv02aWLA+IKNSseA//RS0YT1JM/mRc4UQiKqIUhD6jMyRPz0aO+vm4M1P6a1YzvtR1+UtEnoYoKg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA8BA326F8810146A9D21897D10FF03E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5a6e7d-dcce-408c-140d-08d83e21d815
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 18:10:35.2062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YeiOsf/dkyTlUNxvTDiWqQicmkEoxxcNzJyWxjtWbkH4DGGNfgDWQKIyWDqATm9jjC7zU6xTYjuSUN04st3k2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4602
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVHVlLCAyMDIwLTA4LTExIGF0IDEwOjE4IC0wNzAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGlzIGZpeGVzIG9wY29kZSBjaGVjayBjb25kaXRpb24gd2hlbiBzYXZpbmcg
Y29uZmlndXJhdGlvbiBmb3IgbW9kZWwNCj4gc3Vic2NyaXB0aW9uczogdXNlIHx8IGluc3RlYWQg
b2YgJiYgZm9yIG9wY29kZSBjaGVja2luZw0KPiAtLS0NCj4gIG1lc2gvY2ZnbW9kLXNlcnZlci5j
IHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9jZmdtb2Qtc2VydmVyLmMgYi9tZXNoL2NmZ21vZC1z
ZXJ2ZXIuYw0KPiBpbmRleCBkMzFjOGQ5OWYuLjlkYTk4MTcwMCAxMDA2NDQNCj4gLS0tIGEvbWVz
aC9jZmdtb2Qtc2VydmVyLmMNCj4gKysrIGIvbWVzaC9jZmdtb2Qtc2VydmVyLmMNCj4gQEAgLTIx
MSw3ICsyMTEsNyBAQCBzdGF0aWMgYm9vbCBzYXZlX2NmZ19zdWIoc3RydWN0IG1lc2hfbm9kZSAq
bm9kZSwgdWludDE2X3QgZWxlX2FkZHIsDQo+ICAJaWYgKHZpcnQpDQo+ICAJCW1lbWNweShkYl9z
dWIuYWRkci5sYWJlbCwgbGFiZWwsIDE2KTsNCj4gIA0KPiAtCWlmIChvcGNvZGUgPT0gT1BfQ09O
RklHX01PREVMX1NVQl9WSVJUX0RFTEVURSAmJg0KPiArCWlmIChvcGNvZGUgPT0gT1BfQ09ORklH
X01PREVMX1NVQl9WSVJUX0RFTEVURSB8fA0KPiAgCQkJb3Bjb2RlID09IE9QX0NPTkZJR19NT0RF
TF9TVUJfREVMRVRFKQ0KPiAgCQlyZXR1cm4gbWVzaF9jb25maWdfbW9kZWxfc3ViX2RlbChjZmcs
IGVsZV9hZGRyLCBpZCwgdmVuZG9yLA0KPiAgCQkJCQkJCQkmZGJfc3ViKTsNCg==
