Return-Path: <SRS0=kgXe=64=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7744C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 May 2020 17:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE7E2065D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 May 2020 17:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ixKq4CWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgENRFX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 May 2020 13:05:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:47668 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgENRFW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 May 2020 13:05:22 -0400
IronPort-SDR: 3OxtqhgMfAOjGjOV5Cb3DOFenHSxWh/HiHrzr0emg6KNBE6GiAR07qZY48jTHVARhO2uGuITvt
 gh5YaPQc093w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 10:05:21 -0700
IronPort-SDR: M0OLGQt9dweQewl3F3iP89Rc4Dw/NzeypZ/cPoqIh+MCE2b1YkP7ivjGlGxbfUxcO0O5IAVt4O
 MGz7Bf4Y5k8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,392,1583222400"; 
   d="scan'208";a="298102801"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga002.fm.intel.com with ESMTP; 14 May 2020 10:05:21 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 14 May 2020 10:05:21 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 14 May 2020 10:05:20 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 14 May 2020 10:05:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 14 May 2020 10:05:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNKsYQXFYdGYfdz2N08JbKEvLqNJxo2mafJJHtodKvDcn50069Y4E3xylXRiJuBlKRJ6hCf4wGGuWq0M98LdQjxGCsK7YZ0AiMjY7mEGVIY3cQd/2UnB6ykcF/BKu5hFPph9kXlPH6e8aM2iNjxxronfvYuWAOC4gK/LDrbC7bhu/BV71bRekUzAxl2zgrQ+aCnXiJ2ulRnyyloh7RiWo5Ln9nwyqAEoFX2r418QM0kR3ueEdTWOSHoFFSjK6EKVojyCoff83Pyh2D17Yu9ymk4G/t40lMPAiQ254z8Uu4kSNnajcIaiqMTYJELkmiG/I9/Y5ZAiC/qsaIOCDhzAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyjQqysJieBcg8pwKRuHsy512MOjdX1cXQEFnhaHpy8=;
 b=AyB6XnVbLxdSQDmSCgXrdU21tJbi8I0PnDZ7Mx9ag+HH7+7HvKD6gMcHJr/mpQllMr0aVm9StKdYrQj4n3G3adAvRF7RvvU77X80C8viNH1KoR5/dX+oDKMI42whPtpGtMr4Giy1k7b5tKc1jCVtqKEzgckAwjz3Bsp47K7eC1iClbpvRomuU5pPn9ucP755houXYY84NGCAMM6rVxyOXd+4oy4z4SxB94gLa8xM8w8zRtwySRtoqC+HLu5eIkNLj7BumcNjZREoQ1fVmEsSFpXYcYISRmKLFmp/LoW88yaaPLExgeei9F4Vj+DcZ+TZ10Wwl8fE8tWUQR4cJwvv/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyjQqysJieBcg8pwKRuHsy512MOjdX1cXQEFnhaHpy8=;
 b=ixKq4CWikXDdL0VaPRgKBTntYTU3KYsnu86i5HxOYBP8lICzfNBkD/jCtZ8KqW6NRkffMGoHUY6O2xeX23gIO+uPHnBM7Jvr9WqFZiM/c6CzxYbSeHfKl7vIe5qGohOrmWR+8BpH+kNe7SSBtAJtwTI4a0qjiyfLe2oJ7Yi7s0A=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4523.namprd11.prod.outlook.com (2603:10b6:303:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 17:05:14 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%5]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 17:05:14 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: Re: [PATCH BlueZ 1/4] mesh: On node attach, verify element/model
 composition only
Thread-Topic: [PATCH BlueZ 1/4] mesh: On node attach, verify element/model
 composition only
Thread-Index: AQHWJZT4F/laVtXs8Uu/5bOGRg3mKKin2ICA
Date:   Thu, 14 May 2020 17:05:14 +0000
Message-ID: <8ca71163be82e2559cf9d13755ec4a3e0740f109.camel@intel.com>
References: <20200509000024.5704-1-inga.stotland@intel.com>
         <20200509000024.5704-2-inga.stotland@intel.com>
In-Reply-To: <20200509000024.5704-2-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: daee82d7-4291-4169-126d-08d7f828f83a
x-ms-traffictypediagnostic: MW3PR11MB4523:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45233F017DC49DBF05F927EAE1BC0@MW3PR11MB4523.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: emgRxlzb5/yH01TS7b9JO2pwV8pEtcAmv9wVMEwmm86G0o7WJZRziypZtpICWZhFjJulbRoT6niSBaP1CsAAzPA163XIRHHMVD9nbBoyweVHPZZnl1ltW1890VNOhI1DPmkoIJ8F5STckNP3rogjaXKRe6SCevNFKgIa3fUPjYYbLn699cpsIpvyEkmuu16jbwZM6mb7+7Md1Cf9Svrxaty0yb29L0c0vHAqB1E2Me4hHAnIzAuT4CMjmExlkLB00KD44A0u6c0jrcqc2YlHxpVOIK98drHQ9Vl4pgBKopyYqnAG8g+A/pehf6yaHFJ0YDWtXjgG/o9Fg6fHEZvOKl7ZZNLkeGOMTAgDrkxUIXDO79HeD2tFGlcVhgEdpyZDimzWIOnivUIlxcZ0fteMTSzqgrCQFmnqVVkkINmbZ7Ne8E7pnT34CTxOL4TsxLlg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(136003)(366004)(39860400002)(346002)(5660300002)(6506007)(2616005)(66446008)(6486002)(186003)(64756008)(66476007)(26005)(316002)(110136005)(71200400001)(6512007)(36756003)(478600001)(4326008)(76116006)(66556008)(86362001)(6636002)(91956017)(2906002)(66946007)(8676002)(8936002)(15650500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: EG9fpF1T4xLBKZr18LvgTlWpAwZ6nRifv+Q3EeWZ5ASkFXRXRRekXXVK1ZB5+eQzxo3bfNVQtPLbDRBQv8hsVzx0J8ukr0CBqFNXG8Os+7pXWzbuKOFlq/yCO458Qoi5YNRYDqdts1Tk0/m2D53iOZgMUPmGOMUCNdTOPGDC+nKybn05Zld1XZpQllIYoYSSQAYQW8TKyw+06RfHVMlTWV87lEbQfg3Nf2+ZevItmS40fMXSfsj2bMeOyLthqLdM2fncz+KS3C+YZv+n5Nxl2R/zEs6aR5ZCCzSS6Ahfq8DDt0y4T0LrSBm5d8+5eVsiqyXb3JIhehMSXK/BvVkJrDC6x9LUI14ReJzyB1+0IYvf8Su8aK9fwJ0kDvPVuLcEDLQNK6zYOJP/MW2hFkbC9Uow2y0A47OLp/rHfzJwnNFKd6e0+3L6/4M37RMkWGZMd6vVUebIvK6vnGR32CmN6rEmE1zogvo3WFS1IAyMmcs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66B9211BD592AA4BB05ED89FC99A2D51@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: daee82d7-4291-4169-126d-08d7f828f83a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 17:05:14.1009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NV1dYXFP9fpKyXhLaxTqn20Dj+oc+7os8PiZSTJrUpee3jN1c9lSzD1tGZZRLDAmYWbtxI/LLuY8TSSLriW+rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4523
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

ZnVsbCBQYXRjaHNldCBBcHBsaWVkDQoNCk9uIEZyaSwgMjAyMC0wNS0wOCBhdCAxNzowMCAtMDcw
MCwgSW5nYSBTdG90bGFuZCB3cm90ZToNCj4gV2hlbiBhdHRhY2hpbmcgYW4gZXhpc3Rpbmcgbm9k
ZSwgdmVyaWZ5IG9ubHkgdGhlICJlbGVtZW50cyIgcGFydA0KPiBvZiBkZXZpY2UgY29tcG9zaXRp
b24sIGkuZS4sIHNraXAgdmVyaWZpY2F0aW9uIG9mIENJRC9QSUQvVklELCBDUlBMDQo+IGFuZCBm
ZWF0dXJlcy4NCj4gLS0tDQo+ICBtZXNoL25vZGUuYyB8IDEwICsrKystLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvbWVzaC9ub2RlLmMgYi9tZXNoL25vZGUuYw0KPiBpbmRleCBhY2RhNmQ0NzIuLmUzZjll
NTJlMyAxMDA2NDQNCj4gLS0tIGEvbWVzaC9ub2RlLmMNCj4gKysrIGIvbWVzaC9ub2RlLmMNCj4g
QEAgLTEzNzgsNyArMTM3OCw3IEBAIHN0YXRpYyBib29sIGNoZWNrX3JlcV9ub2RlKHN0cnVjdCBt
YW5hZ2VkX29ial9yZXF1ZXN0ICpyZXEpDQo+ICB7DQo+ICAJdWludDhfdCBub2RlX2NvbXBbTUFY
X01TR19MRU4gLSAyXTsNCj4gIAl1aW50OF90IGF0dGFjaF9jb21wW01BWF9NU0dfTEVOIC0gMl07
DQo+IC0NCj4gKwl1aW50MTZfdCBvZmZzZXQgPSAxMDsNCj4gIAl1aW50MTZfdCBub2RlX2xlbiA9
IG5vZGVfZ2VuZXJhdGVfY29tcChyZXEtPm5vZGUsIG5vZGVfY29tcCwNCj4gIAkJCQkJCQlzaXpl
b2Yobm9kZV9jb21wKSk7DQo+ICANCj4gQEAgLTEzODksMTIgKzEzODksMTAgQEAgc3RhdGljIGJv
b2wgY2hlY2tfcmVxX25vZGUoc3RydWN0IG1hbmFnZWRfb2JqX3JlcXVlc3QgKnJlcSkNCj4gIAkJ
dWludDE2X3QgYXR0YWNoX2xlbiA9IG5vZGVfZ2VuZXJhdGVfY29tcChyZXEtPmF0dGFjaCwNCj4g
IAkJCQkJYXR0YWNoX2NvbXAsIHNpemVvZihhdHRhY2hfY29tcCkpOw0KPiAgDQo+IC0JCS8qIEln
bm9yZSBmZWF0dXJlIGJpdHMgaW4gQ29tcG9zaXRpb24gQ29tcGFyZSAqLw0KPiAtCQlub2RlX2Nv
bXBbOF0gPSAwOw0KPiAtCQlhdHRhY2hfY29tcFs4XSA9IDA7DQo+IC0NCj4gKwkJLyogVmVyaWZ5
IG9ubHkgZWxlbWVudC9tb2RlbHMgY29tcG9zaXRpb24gKi8NCj4gIAkJaWYgKG5vZGVfbGVuICE9
IGF0dGFjaF9sZW4gfHwNCj4gLQkJCQltZW1jbXAobm9kZV9jb21wLCBhdHRhY2hfY29tcCwgbm9k
ZV9sZW4pKSB7DQo+ICsJCQkJbWVtY21wKCZub2RlX2NvbXBbb2Zmc2V0XSwgJmF0dGFjaF9jb21w
W29mZnNldF0sDQo+ICsJCQkJCQkJbm9kZV9sZW4gLSBvZmZzZXQpKSB7DQo+ICAJCQlsX2RlYnVn
KCJGYWlsZWQgdG8gdmVyaWZ5IGFwcCdzIGNvbXBvc2l0aW9uIGRhdGEiKTsNCj4gIAkJCXJldHVy
biBmYWxzZTsNCj4gIAkJfQ0K
