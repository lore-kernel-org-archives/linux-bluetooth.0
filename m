Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52888C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 13:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FBDD61441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 13:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhD1NzR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Apr 2021 09:55:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:27197 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhD1NzQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Apr 2021 09:55:16 -0400
IronPort-SDR: n1NxLFp2VFUtj7OioayxaS1XmGkp4Abe1+ezwxde8WhnEhe+v/OeAr5+ZQqXavVH3cYAAUURhf
 SfvX+gp58EHg==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="217462363"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="217462363"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 06:54:31 -0700
IronPort-SDR: M0dB2HLBUHl28poulLOFQe5VCNJDwe5GuWnKGJb94GUG0wt3jreA2HsXhn29k19LPNAJS9rOg+
 Q6UfQYxmN4tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="423548651"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 28 Apr 2021 06:54:31 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 28 Apr 2021 06:54:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 28 Apr 2021 06:54:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 28 Apr 2021 06:54:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 28 Apr 2021 06:54:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR5mfKpjcMDf11qDzTqjmXcJocrUAsawgEd2QMYSgyPlLGXFIn4fBXgyKmueKQ/+eaphBNrmId6VAwdibhK+XrdhB/+JIvKh4MA2UensOCIMw7Bud4YN45BSo28g9or7gnUzzqKORD6ZzY1sWW2BpY2Nl3Sox/VGvTENvp5go8D46GCa4aiI2hjFc1brGss8POh7CDN10OBzoV3Hw2QRk03w0yVTPUOptaRCiesxn8hVi/syiZCJ5tPBtrLFysE9r1XGZ0PlDfqJAqFnohXSYkSi2SFBj37TEGnfkj9Z6LMsehJ+umntjVKxuM8LzwpukOpYHNCP8QyHYSCtMEpZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf7nrhiWqpYSUP62k82KvsD0MeJxBOSFCXBzkqbR2Hw=;
 b=DXe0YZFRy2rRbl1Pp8IFxRrBSWtFKPPu9/Qtf2YY7dFTSDErzYbTbrqZ/7euPC5TCK/woQGJA6ts3rEIEYnq0TjX1V3SmXkAL759pSSJhtvyS28hMoO/pN91LVVs1dJjvGB3uWVLJS62HVLXfHvet/qUpJNNCBBmh/aNuGgHRbSLD7FKyAndyQz1o/k9X24BcEApt80Xlmjy+4LSdHgzJhj0hBUd70vPT8CDQPKxpxrFxXeXeBYTR9gwZwR23gdDyb9dFa7nxq42L9J9NCNRIjA0DgiXU1Cnd+5bK9qUyXJBQlrlQHqFgvPNPrUM7gPc19LQLOKQRugwPn2TVmXUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf7nrhiWqpYSUP62k82KvsD0MeJxBOSFCXBzkqbR2Hw=;
 b=aq5rJHQpyn7Kf2F8cCmx4/GFlq9C4C4f6JT2P3w+KgVJcCuoUpI7ewzlOUYQISvndq0DIbgBNgPZFSqrxL9zUnaJaNgt7+6uo9VSssqIi9dbop0nLdk155hV4WBVRlzukC/p4DvufDJGQu9EkSu7IUVeLXcO68o9XNqjnUMzC7Y=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5623.namprd11.prod.outlook.com (2603:10b6:8:25::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20; Wed, 28 Apr 2021 13:53:21 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7%5]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 13:53:21 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Subject: RE: [PATCH v3 3/3] Bluetooth: cache local supported codec
 capabilities
Thread-Topic: [PATCH v3 3/3] Bluetooth: cache local supported codec
 capabilities
Thread-Index: AQHXN4FoiNVZDd1d6UizO+ZKZaI9carBv2wAgAg6EXA=
Date:   Wed, 28 Apr 2021 13:53:20 +0000
Message-ID: <DM8PR11MB55739D629FCFD9BD7174C51EF5409@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210422141449.25155-1-kiran.k@intel.com>
 <20210422141449.25155-3-kiran.k@intel.com>
 <349C0A6B-5E9C-4171-BFB5-C86AF4E8D698@holtmann.org>
In-Reply-To: <349C0A6B-5E9C-4171-BFB5-C86AF4E8D698@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2405:201:d012:c839:adc4:2510:1d3c:4d99]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bc63520-07ce-4789-092d-08d90a4cfbf4
x-ms-traffictypediagnostic: DM8PR11MB5623:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5623D4A5BE722AEB3029517BF5409@DM8PR11MB5623.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SGi8M/x/X6nnjLwByMnr/5nkX/klMN9Rqpagfpg0g9Q/1JK4jDXGDXEnnw8zPt3/kb563FvMEbC35/E1w+skTSwDsCY3uajU8C4j5aAZFXKRX2ksVKsEAMYeFDYNVxJlhdQiO/kZw8drzWQwJCzYghDnXKOnSAG12XfJVCnls3/cnnQl04wmsgncGFP3zgtRK33/iw4Mg7I2/NYl6XbEdm4+uGJt7DmU8oDevzoNO7Buy9m+4OZgYH/QxiiNqsw0H1imPY46jnmxeEWzrTOhxoVaSM4hEneAp8jX2IUGdJe38QDRa9JGfnqwpSAhRXNKyMKu63fHzCQ3xLAk0m+jNf17MnhFJXPOmcsHM42RBT+UV0lzquacfpLv/UVcviFc+CvTx/TjCqIpCvQTSk61tiSx2whFOLz+I5Cze6edFDN/HktQi/hVz6q+jJNocQauXo8ARXPzkMdI01K6ZVGgz6eRgzK2hdyqsWi/BoWqiO+AKweePSfGY29eeZiFPr7oUeQc3D3d2MB4krAvRgDJxyK7382w1VcrdHM/oLYK4ZFwQnXMbFBQFF+wnxFn8u06uZZfSLpXjifKb6SbA+tmTqAWdHazm4t0PfVzYv/+988=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(396003)(346002)(376002)(366004)(6506007)(6916009)(71200400001)(5660300002)(478600001)(186003)(83380400001)(64756008)(86362001)(8936002)(66556008)(76116006)(52536014)(7696005)(9686003)(66946007)(33656002)(8676002)(66476007)(4326008)(2906002)(66446008)(122000001)(38100700002)(55016002)(316002)(107886003)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YWxicnA0UkpLTVZOVlNXbFQ3L2ptemp4bEpNdFVUbDFmQWtrOEtBYmpMK2N0?=
 =?utf-8?B?QmlOeVFJTTBrb2JYNXNLVFI2U2FBbVZxSTRxUlRIRW9XQ25ZVEJiVG5HMU11?=
 =?utf-8?B?RlpRUmpnSFUrSjk1c1dURUtQOExMQ2d3NlB1ZFkxY3gvTnd0eUEwRExQQmx3?=
 =?utf-8?B?cWtGdDRvajJMMW1idVRQYVJWdW0vTm1yRnpJTjBnd0RQc2MxdnJrS09XNjJl?=
 =?utf-8?B?M0FSa0tRbW9uZEpVcjQ2dWFqMzVXUnhlUW1VeHNnSWNmeFdJRy9neFRCMTB6?=
 =?utf-8?B?VTl5VGJwbkwzOTdqSGpGdlZZZTA0NjQwOWUrUW1tOFdoK3d5SG1nRm1nZGZ0?=
 =?utf-8?B?c2FpYm1RTzVMTVMxbFJvakxySXhoZE1OM2JudUlFZndxUnN5YlNUZHRYQW1Z?=
 =?utf-8?B?ZXBQTURla0VBNVZDem1OUlpXVWdXVDRtMURoL3ZzVk94M0RlaGVJQThqZ0da?=
 =?utf-8?B?dDlWaTM2aEs0aUZScTRNZ3ROMldyMitNbndqNWVUWFU2c2t3cWtwNEhzTk5V?=
 =?utf-8?B?S3ZTNHBPQ1FwaklFN2Z6RklDYVEvcjYzQldhTGlrRXZPdFZadFUvYlBrZDBB?=
 =?utf-8?B?R1hLazNGdVVjMldZelZMZ082TnBvclZGWnFWRmVVRzJwcElSMHlTclZ2U0tr?=
 =?utf-8?B?TFBEbDJOZjlzSXluejVCbCtDZ1Ixb3pJc1NvcVRJalA4OURXWnh1cytyOGY2?=
 =?utf-8?B?aU1jcDNRZnBJUlMrT1hwU0JVVnJNL0ZuTDZBTTdCRElhdkNVWFQ5L2RORmNk?=
 =?utf-8?B?MjQvSlgwa0xOczE5UWhHdnBHOUk5WkNsQlViNThrc0JXYlBzOHNscWM1eXAx?=
 =?utf-8?B?MnBncHg1MWpRL0x5MVA3MUtWTDhKYXRQMFh1Q0ozYjZ1ckYrOEIrYnBqZ2ly?=
 =?utf-8?B?czNrQUszNGV6U0I4MFhKdm5uOFhkaCtxNklWRE9EZG81dUZBdE56d2hOVDRS?=
 =?utf-8?B?bVFzdktIZy9oNzBneUdjRFFrcUQrSDl3ZFB2OTNyVGlJbitGcFNYTzdyOE1Y?=
 =?utf-8?B?UXU1bHNsaXVpcmk4czJBTWtPa3ZtNGxVN1pEYXJvby9qWm44SkpuN3dwNzlJ?=
 =?utf-8?B?VmtSbFIyamVrL1duWFBJUnZKVHp6K05BK3REc3VaZE5iVWQ4dE5kN1dlMFls?=
 =?utf-8?B?VkhKdksrV3F1c0Y2cHE5QXlZUThOVEFaMldRWnUxZTRqWnpKbnBWVTh4QnIv?=
 =?utf-8?B?bnNXOUYwRXhXRndZaDdRTk1RS1JJNmV0VUV3YWFKbVRYZURVVU4yYVBMYkVE?=
 =?utf-8?B?eXlzMTJMWkxYRWFlVVVNRmpINi9yKzVRTkdSWlFiTGZQTWRXUm4yV05QcGFS?=
 =?utf-8?B?VkVTa1l3ak9IZ1IyVW50bUxTQlFPaVBUTFI5VVV3ZFRsSWNLRnhvQ2RScVlG?=
 =?utf-8?B?SGVkckFpdHRFMzFWWkFrWTRzZWpQVTdUZ2xxVXY4STFRRWRoQmszNFMza3JF?=
 =?utf-8?B?U1lwekNPQ0k0TkJOZVpjVk4yYWdTS1ZDTGwySi9MRWZoZDBjcm52eVNEbk5F?=
 =?utf-8?B?M2NmUVY2bWtoVzMrdnFzcFVFZy9SSVArbTBoYmFhMmV0Yi9mYThXZkp3M05E?=
 =?utf-8?B?dEFzRXEycXZldDhFY3RMM2NVcEVIVUNpNWRZS05kOWM4MHI5Y2Zvc2lZTFd1?=
 =?utf-8?B?KzFDRk5YdHNMNTJkZ1R3bHZnOW5WTlVSREIxUUVMM002TjF2WlhrOGZiTE5h?=
 =?utf-8?B?Vzd6UXBRRTEyUHl4M2huc21MTXlscmVQV2Fzbi9JdU9KZW1VOE1wN3Z4MWpC?=
 =?utf-8?B?L25XWDlxbkhBQmluRW9xN2w3cms2NE5qR2p1eUxrbUN6RTV1TXJ1aXFya0pI?=
 =?utf-8?B?cDJ5Y0lrMVBhWWljbzFkUktNcU83T2E1emVMalZUNUsxaU10VUE1OUhBNk5h?=
 =?utf-8?Q?i2C1HCvlENZG4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc63520-07ce-4789-092d-08d90a4cfbf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 13:53:20.8889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hl+nPNojjOkEhEnp68mNEL/Cn4k1F4CsgX2qKq0pjAPyOeH3Q2HhI1HThLx9l94tKJCP6fdQ8D70RakTu0Y78g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5623
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQo+ID4gK2ludCBoY2lfY29kZWNfbGlzdF9hZGQoc3RydWN0IGxpc3RfaGVh
ZCAqbGlzdCwgc3RydWN0DQo+IGhjaV9ycF9yZWFkX2xvY2FsX2NvZGVjX2NhcHMgKnJwLA0KPiA+
ICsJCSAgICAgICBfX3UzMiBsZW4sDQo+ID4gKwkJICAgICAgIHN0cnVjdCBoY2lfb3BfcmVhZF9s
b2NhbF9jb2RlY19jYXBzICpzZW50KTsNCj4gDQo+IEkgdGhpbmsgeW91IG5lZWQgdG8gcmVkbyB0
aGUgd2hvbGUgcGF0Y2ggc2VyaWVzLCBzaW5jZSAxLzMgc2hvdWxkIGhhdmUNCj4gaGNpX2NvZGVj
X2xpc3RfYWRkIGluIHRoYXQgaXQgYWRkcyB0aGUgY29kZWMgaWQgZnJvbSByZWFkaW5nIHRoZSBj
b2RlYyBsaXN0Lg0KPiANCkFjaw0KDQo+IEFuZCB0aGVuIHJlYWRpbmcgdGhlIGNhcGFiaWxpdGll
cyBqdXN0IHVwZGF0ZXMgdGhlIGNvZGVjLg0KPiANCldpdGggYXN5bmMgY2FsbHMgY29udmVydGVk
IHRvIHN5bmMsICBjYW4gd2UgYWRkIGNvZGVjIGRldGFpbHMgdG8gdGhlIGxpc3Qgb24gcmVhZGlu
ZyBjb2RlYyBjYXBzIGFzIHNhbWUgY29kZWMgY2FuIGJlIHN1cHBvcnRlZCBvbiBtdWx0aXBsZSB0
cmFuc3BvcnQgdHlwZXMgPw0KDQo+IE91ciBwcm9ibGVtIGlzIHRoYXQgdGhlIHdob2xlIGluaXQg
cGhhc2UgaXMgcmF0aGVyIGFzeW5jIHRoYW4gc3luYyBpbiBpdA0KPiBwcm9jZWR1cmUuIEFuZCB0
aGUgcmVhc29uIGZvciB0aGF0IGlzIHB1cmVseSBoaXN0b3JpYyBmcm9tIHRoZSB0aW1lcyB3aGVu
DQo+IExpbnVzIGhhZCBubyB3b3JrIHF1ZXVlcyBhbmQgd2UgaGFkIHRvIHByb2Nlc3MgZXZlcnl0
aGluZyBpbiB0YXNrbGV0cyBvcg0KPiBzcGF3biBrdGhyZWFkcy4NCj4gDQo+IEZyYW5rbHkgaWYg
d2UgbW92ZWQgdGhlIHdob2xlIGluaXQgcHJvY2VkdXJlIHRvIHVzZSBfX2hjaV9jbWRfc3luYyB3
ZQ0KPiBjb3VsZCBmb2xkIHRoZSBjb21wbGV0ZSBpbml0ezEtNH0gcGhhc2VzIGludG8gb25lLiBB
bmQgdGhlcmUgaXMgbm8gcmVhc29uIHdlDQo+IGRvbuKAmXQgZG8gdGhhdC4gSG93ZXZlciBvbmUg
cHJvYmxlbSBhdCBhIHRpbWUuDQo+IA0KQWNrLiBJIHdpbGwgZGVmaW5lIGluaXQ1IGZvciByZWFk
aW5nIGNvZGVjcyBhbmQgY29kZWMgY2FwcyAgdXNpbmcgX19oY2lfY21kX3N5bmMgIGNhbGxzLg0K
DQo+IFJlZ2FyZHMNCj4gDQo+IE1hcmNlbA0KDQpUaGFua3MsDQpLaXJhbg0KDQo=
