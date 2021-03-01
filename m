Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0000EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Mar 2021 18:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C37DF64F23
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Mar 2021 18:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbhCASbh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Mar 2021 13:31:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:42048 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240010AbhCAS20 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Mar 2021 13:28:26 -0500
IronPort-SDR: T0rkjNTlNv+Rj3ST+CQO9H9YeU7pg83X1wBiq6MxtHUOc9Y2WEYzdJdvwCusv4f4pFxhNJxb5+
 pSKpPzFwa7uQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186609753"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="186609753"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 10:25:29 -0800
IronPort-SDR: 22n3NEiG1nSPrGztOvIXlEsX2wJCVp+bPj+eqZlMDiB+u2EvcXTZqL3/7OsmAAoyCd0rCNpYam
 6y/b5wXSUQwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="397866545"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2021 10:25:29 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Mar 2021 10:25:29 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 1 Mar 2021 10:25:29 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 1 Mar 2021 10:25:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL2bD+JBi3bufFwYgxtsfRe6WOWCkZfRibrJyunCzXp3xb7zEgrk20R84hDpw4mBVSjbfXlCw+1ARrUey87Tmuy4ZonPHSfeDrX91fp3ZodZknruxNupA5elVSjCXU24Y0Q7Nhw2S6FT/AygAQ/Xa8zhetisWzwx+Y3wVZwKieCso7YlAMLC4zTeQr8CqHingsnUYdOmoW8QuQcfqIvP5Wb+4zg4vUNn9O8Nh/Zt0JpIwxWPYRVetEr2LYZGhZTTdoLv+ldv6YLm9q6QgzqMe5pZuvTmFy4J4Zxfaf06i+p9yl76Yu4AgSwwvBKSVac0l+vFH/3cSc2ALQg60zzuhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RQRueAFk5gJrg77ySJSCivmA7YVPW4ns9gDSNn8oZc=;
 b=GscsRitBEKocG3bUVPSDbgE2h3iYx/BWca7iJceeSBekzJoBA1wK0Iopxaf5rlhgjrEFjYWMcVPZkEH3Eboq5wLu2NqNOzM4rJlQ4PzFjmgmPbF9w+MpKK6dGE3PoIECq/gJJrXUAqil4QA794dt/snM4DGmlOSyLHysO+98GBAWq9rLleHp2hKmUAywJXAFdITxlmk9XjeHb1KEW2+44fTvfUh8GCUfIZ4q9InHX0BhLQKFVWf6oGrXjDeZIVYLKnuF785/x8v0/gPQaj8ZCfPeKn0IzTYOyCQY1RaItowBwliu9pwSMMrx/DzEXFxYRyCkNJod6hnsq3cOP712hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RQRueAFk5gJrg77ySJSCivmA7YVPW4ns9gDSNn8oZc=;
 b=xJgA8gWDJVXF2Snw6LSxtxrNaYZ7y44RhAM2dvLh51uJmK2G0CrGJP4wDqz7QlcNRSF0HoXOvc7TRS9dTlcDQgNawM8GSeiSPGAyoH4cUGAAFWCvzl9iha1MU/iaXHhpcQLKOM41X+VvkzjHyHY/1nYctAK3jhQ/5LCJG+tU6b8=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB2032.namprd11.prod.outlook.com (2603:10b6:300:2b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 18:25:27 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::e4db:77e6:8d4b:5851]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::e4db:77e6:8d4b:5851%9]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 18:25:27 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "przemyslaw.fierek@silvair.com" <przemyslaw.fierek@silvair.com>
Subject: Re: [PATCH BlueZ] mesh: Fix infinite loop on IVIndex update
Thread-Topic: [PATCH BlueZ] mesh: Fix infinite loop on IVIndex update
Thread-Index: AQHXDEOXD1z6K3JYM0y1Jq46eFpDH6pvd/gA
Date:   Mon, 1 Mar 2021 18:25:27 +0000
Message-ID: <a4492b3d5dc7bf867deb28477d2e5a74ca4b4178.camel@intel.com>
References: <20210226132740.56503-1-przemyslaw.fierek@silvair.com>
In-Reply-To: <20210226132740.56503-1-przemyslaw.fierek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aae2a602-c1b0-4b0e-9457-08d8dcdf6360
x-ms-traffictypediagnostic: MWHPR11MB2032:
x-microsoft-antispam-prvs: <MWHPR11MB2032D7FD0FDDABF6A34621F3E19A9@MWHPR11MB2032.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zu+uIOb/j6pJviU8jGS8t0xHEFfNAujGw6/WyeZUSLPGPqG9yMzc68586UKyWCGul+2UiPBR21fzuj5//OnYhkcAGknfkbkD5bMy8kzsuyvGWU/kP9/I5pFvjfuprCLwdCRSMOt74PquQnJcmqCnkfRkb+grNvrRO+zr8YDcDOPcC2/g3z+CwuX6GA07C5kzU3iZnu1pBSQh5rGP3nGkWC2lORaoxYf+hB2Lpt4MmGuN4OW1wbfNmKJBjen6hTMuVlEmOJBVw8+6ZwG1urjMjKfRTQ8woMGIYueX2m32hxxWXznyZLAEfltxfRZB22lsu3Ut+tyE4EPQj2kLM8oXs0G5P+sEOzfygQiBRnzdm6K2qZNCQ46C7mz3z7ZPMwPZ1rC0zgn86sMtKXt2qOyr8bjih8ahWqpuDxAHVnpAZlQoKe4iuBLL7KbY8tzV8NKavHo5dnHqvr0BhXD9pXSTco18LmfQIVdtelewOW6jz9Md2vPAGz0Ahf8JPv0QZIP/86Hqgh+oaW6IaShvdxnAyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(6512007)(478600001)(71200400001)(2906002)(66476007)(110136005)(86362001)(83380400001)(8676002)(186003)(5660300002)(2616005)(6486002)(64756008)(66946007)(66556008)(316002)(66574015)(6506007)(8936002)(36756003)(15650500001)(26005)(76116006)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z2tTWXUwbmpucjF1U2pFRG9UWHlITWNObDh3UE51TlovLzdOUFRGdm9PWHZi?=
 =?utf-8?B?NGw3bXYrcXRQZnhxZ29IalBhaFF2WDE5RGVzZHh4cGxuektvR0ExVXZQNjc5?=
 =?utf-8?B?NTN0bUQycmdLQjFzcGJmbFhkYlVYYUQyQ3QxcG5CMVQ2S2c1THZwTldkQ0o5?=
 =?utf-8?B?Z3MreGNyblB6Zm9rVVpaNVJ3dE92OVljV2tpN0o2cE1pak9sUjkwRXF5RE5o?=
 =?utf-8?B?dzN6R2QzeEwrZFR1d2dVbFBOZEt3SC9EMDBramF1UnJIR0lHdk1CV2RXS2ZT?=
 =?utf-8?B?THg1UkNHR3hpS0dTK3dPZm9CNVR5NERxVmtlUGROOXBJUUxvT1kwYzBhTDly?=
 =?utf-8?B?TExvNjJZT1FJZnFnT3JBK1hEZWVrYjRXb0dqVERNSkNBUi9rcEQvbFdMYitH?=
 =?utf-8?B?VnlsZ0x3U1VnQVJyNXE3RG43UDducGRadk5LYnRyRHNuY1A2cEY5eHhzYUJQ?=
 =?utf-8?B?cEN1RWFRUWl6cEhiZFl0OU1pSlg5WUhPS1FmSTNSczQzTlBCVnVjWHAyT0VY?=
 =?utf-8?B?YVdiMndIRTFJeENyRzdwQTdPcGkxZGFITmRobUowZHd3MWIyaE8vZ3VydWNK?=
 =?utf-8?B?cHErelNJdjJ4amowcDNJNk9XdkZYRUNtemV1ZXpnZE9oSHI4QnVvK2VZbEdn?=
 =?utf-8?B?T0s4SkpuZXA0REl3ZDBZdjNxdnl4bHdsSXZPempMaHdXcXlwM0l2Z3hNaXA0?=
 =?utf-8?B?bHlFOERLWlJqSTFLNTgrNHZNV2xsb2phdUJNdVZYdXlmQzdtbzhzK2tSOTFy?=
 =?utf-8?B?dVFPQlhNckZjM0VLNGRUS3RRaHBIb3ZjUTladDc1dERmUk51ckJnTW5mb09J?=
 =?utf-8?B?MkJlUm93QnBMV2lPbFhRWWZLU3VrbGo1bXppZjF3TWxUc1pBUFFCTm16WXAv?=
 =?utf-8?B?RDRHT2ZES2NzUExpMlhFT1U1VHBWUkhSb2toSGV1K3NNK3BzS3V6T2xTazh4?=
 =?utf-8?B?d1p0bDhxaHAxRXpYL09OV1A1VWJMbmkxNUtxQzBLcGtFK3NuQmxzS3JIbmFw?=
 =?utf-8?B?dko5Qmo0eWNkOXJpVmowZm9vTWRrWU0rdnFDQ1VIYnV0Uy9ORElVV1Y1K21v?=
 =?utf-8?B?N2s5Z1o0aUw3cXRqUGg3NHQrQjc4cDJ3L1FSTGpETjg3WWcrZklLWklxenZW?=
 =?utf-8?B?dEEvbUpHMlhOMm9XVHNxQ2lQUkpJdmdneTdueENJLy9hM0cybFZOTnh2ZE5i?=
 =?utf-8?B?aW1KTmpwSlJZNzA3YTBOcHMrMDFMY2dvVnB4MTZBL25ITjZ1QUJmVlB2c0JM?=
 =?utf-8?B?d2FLQ01ENi8rUno1R2ZUeU5TbVhIS3pUVE5icHlxbmsrQ3lQbVphSVYydHdH?=
 =?utf-8?B?M0RvRDU0QUJqNUhSUmQyZFpWYzZoaWNPTk8wb012U3RVR2FrL1VuaGswOFBu?=
 =?utf-8?B?amRtdUkxejI3LzcwL3FhVDFmZDd6bkZEYU1KeXpIMHhNUXVueEVyVDNQY0li?=
 =?utf-8?B?WitJSUMzNUlpemtCbTRIalU0YXJiS3BSTkxDUCtpQzAyWXlvcU5zc2cvK0ZV?=
 =?utf-8?B?UXhVakVvQnp3VVhCR3YxRkJOQmZpV0VnS3pyR1JHTGlzNVZKcFp0a2lSK2w0?=
 =?utf-8?B?aU5VcmdhN0I1REZtZnZHbDlsSXNoN1UrdTAxUGtLT3FRdU1iTE04YnNNNVpl?=
 =?utf-8?B?Zy9uYTlQV0tja2UxNFpvMkJMS2NIYnBGblNUemlvSzdhdzFzRkJWdUp1ZnR5?=
 =?utf-8?B?ZDA2eFhQNTZMSlhHRWxzNnhRM21JSE52S1NzSVFNdmRhV2hURzhad1UyOTRh?=
 =?utf-8?Q?m//HoeS5InAVEnbF/C5JwzLL9qQI3/bVpZ919DS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C5604FF63C72C46814314AE545B27C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae2a602-c1b0-4b0e-9457-08d8dcdf6360
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 18:25:27.4553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3kaQNBzb8zS9+u6V2EKLfvywoU0LFOE+9QKDyxefQrGBDZTMG+2Pf4FsDpRNDRvEeOhA5rvwvd02XCQfbzeqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2032
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgVGhhbmtzDQoNCk9uIEZyaSwgMjAyMS0wMi0yNiBhdCAxNDoyNyArMDEwMCwgUHJ6
ZW15c8WCYXcgRmllcmVrIHdyb3RlOg0KPiBUaGlzIHBhdGNoIGZpeGVzIGluaWZpbml0ZSBsb29w
IHByb2JsZW0gY2F1c2VkIGJ5IHJlY3VycmluZyBjYWxsDQo+IG9mIHRoZSBgbmV0X2tleV9iZWFj
b25fcmVmcmVzaGAgZnVuY3Rpb24uDQo+IA0KPiBQcm9ibGVtIG9jY3VycyB3aGVuIGF0IGxlYXN0
IHR3byBub2RlcyBhcmUgY29ubmVjdGVkIHRvIHRoZSBzYW1lDQo+IEJsdWVaIGluc3RhbmNlIGFu
ZCB0aGV5IGFyZSBjb25uZWN0ZWQgdG8gdGhlIHNhbWUgbmV0d29yaw0KPiAodXNlIHNhbWUgbmV0
d29yayBrZXkpLiBJc3N1ZSBpcyB0cmlnZ2VyZWQgd2hlbiBJVkluZGV4IHVwZGF0ZQ0KPiBwcm9j
ZXNzIHN0YWJpbGl6ZSBhbmQgb25lIG9mIHRoZSBub2RlcyByZWNlaXZlcyBuZXR3b3JrIGJlYWNv
bg0KPiB3aXRoIElWVXBkYXRlIGZsYWcgc2V0IHRvIDAuIFRoZW4gaXQgcHJvY2Vzc2VzIHRoZSAi
bG9jYWwiIGJlYWNvbg0KPiBhbmQgY29tcG9zZSBuZXcgYHNuYmAgKHdpdGggSVZVcGRhdGUgZmxh
ZyBzZXQgdG8gMCkgYXR0YWNoZWQgdG8NCj4gYG5ldF9rZXlgIGluc3RhbmNlLiBBZnRlciB0aGF0
IGl0IGNhbGxzIGBuZXRfbG9jYWxfYmVhY29uYCBhbmQNCj4gYW5vdGhlciBub2RlIHByb2Nlc3Nl
cyB0aGUgbmV3IGJlYWNvbiAodGhpcyBub2RlIGhhcyBJVlVwZGF0ZQ0KPiBmbGFnIHN0aWxsIHNl
dCB0byAxKS4gTm90ZSB0aGF0IHRoZSBgbmV0LT5pdnVwZGF0ZWAgaGFzIHNldCB2YWx1ZSAxLg0K
PiBUaGUgYHVwZGF0ZV9pdl9pdnVfc3RhdGVgIHNheXMgdGhhdCAiSVZVIGNsZWFyIGF0dGVtcHRl
ZCB0b28gc29vbiIuDQo+IFRoZSBub2RlIGNvbXBvc2VzIG5ldyBgc25iYCB3aXRoIElWVXBkYXRl
IGZsYWcgc2V0IHRvIDEgYW5kIHdyaXRlcw0KPiBpdCB0byB0aGUgYG5ldF9rZXlgIGluc3RhbmNl
IGluIHRoZSBgbmV0X2tleV9iZWFjb25fcmVmcmVzaGANCj4gZnVuY3Rpb24uIEFmdGVyIHRoYXQg
aXQgY2FsbHMgYG5ldF9sb2NhbF9iZWFjb25gIHdoaWNoIGNhdXNlcw0KPiByZXBlYXQgb2YgYWxs
IHByb2Nlc3MuIFdlIGFyZSByb3RhdGluZyBpbiB0aGlzIGxvb3AgdW50aWwgZW5kLW9mLW1lbW9y
eS4NCj4gLS0tDQo+ICBtZXNoL25ldC5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21lc2gvbmV0LmMgYi9tZXNoL25ldC5jDQo+IGluZGV4
IDk2MjRjZDA1OC4uNmFjZDliYzdiIDEwMDY0NA0KPiAtLS0gYS9tZXNoL25ldC5jDQo+ICsrKyBi
L21lc2gvbmV0LmMNCj4gQEAgLTI2MDksMjkgKzI2MDksMzMgQEAgc3RhdGljIGludCBrZXlfcmVm
cmVzaF9maW5pc2goc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQxNl90IGlkeCkNCj4gIAlyZXR1
cm4gTUVTSF9TVEFUVVNfU1VDQ0VTUzsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIHZvaWQgdXBkYXRl
X2tyX3N0YXRlKHN0cnVjdCBtZXNoX3N1Ym5ldCAqc3VibmV0LCBib29sIGtyLCB1aW50MzJfdCBp
ZCkNCj4gK3N0YXRpYyBib29sIHVwZGF0ZV9rcl9zdGF0ZShzdHJ1Y3QgbWVzaF9zdWJuZXQgKnN1
Ym5ldCwgYm9vbCBrciwgdWludDMyX3QgaWQpDQo+ICB7DQo+ICAJLyogRmlndXJlIG91dCB0aGUg
a2V5IHJlZnJlc2ggcGhhc2UgKi8NCj4gIAlpZiAoa3IpIHsNCj4gIAkJaWYgKGlkID09IHN1Ym5l
dC0+bmV0X2tleV91cGQpIHsNCj4gIAkJCWxfZGVidWcoIkJlYWNvbiBiYXNlZCBLUiBwaGFzZSAy
IGNoYW5nZSIpOw0KPiAtCQkJa2V5X3JlZnJlc2hfcGhhc2VfdHdvKHN1Ym5ldC0+bmV0LCBzdWJu
ZXQtPmlkeCk7DQo+ICsJCQlyZXR1cm4gKGtleV9yZWZyZXNoX3BoYXNlX3R3byhzdWJuZXQtPm5l
dCwgc3VibmV0LT5pZHgpDQo+ICsJCQkJCQkJPT0gTUVTSF9TVEFUVVNfU1VDQ0VTUyk7DQo+ICAJ
CX0NCj4gIAl9IGVsc2Ugew0KPiAgCQlpZiAoaWQgPT0gc3VibmV0LT5uZXRfa2V5X3VwZCkgew0K
PiAgCQkJbF9kZWJ1ZygiQmVhY29uIGJhc2VkIEtSIHBoYXNlIDMgY2hhbmdlIik7DQo+IC0JCQlr
ZXlfcmVmcmVzaF9maW5pc2goc3VibmV0LT5uZXQsIHN1Ym5ldC0+aWR4KTsNCj4gKwkJCXJldHVy
biAoa2V5X3JlZnJlc2hfZmluaXNoKHN1Ym5ldC0+bmV0LCBzdWJuZXQtPmlkeCkNCj4gKwkJCQkJ
CQk9PSBNRVNIX1NUQVRVU19TVUNDRVNTKTsNCj4gIAkJfQ0KPiAgCX0NCj4gKw0KPiArCXJldHVy
biBmYWxzZTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIHZvaWQgdXBkYXRlX2l2X2l2dV9zdGF0ZShz
dHJ1Y3QgbWVzaF9uZXQgKm5ldCwgdWludDMyX3QgaXZfaW5kZXgsDQo+ICtzdGF0aWMgYm9vbCB1
cGRhdGVfaXZfaXZ1X3N0YXRlKHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MzJfdCBpdl9pbmRl
eCwNCj4gIAkJCQkJCQkJYm9vbCBpdnUpDQo+ICB7DQo+ICAJaWYgKChpdl9pbmRleCAtIGl2dSkg
PiAobmV0LT5pdl9pbmRleCAtIG5ldC0+aXZfdXBkYXRlKSkgew0KPiAgCQkvKiBEb24ndCBhY2Nl
cHQgSVZfSW5kZXggY2hhbmdlcyB3aGVuIHBlcmZvcm1pbmcgU0FSIE91dCAqLw0KPiAgCQlpZiAo
bF9xdWV1ZV9sZW5ndGgobmV0LT5zYXJfb3V0KSkNCj4gLQkJCXJldHVybjsNCj4gKwkJCXJldHVy
biBmYWxzZTsNCj4gIAl9DQo+ICANCj4gIAkvKiBJZiBmaXJzdCBiZWFjb24gc2VlbiwgYWNjZXB0
IHdpdGhvdXQganVkZ2VtZW50ICovDQo+IEBAIC0yNjM5LDcgKzI2NDMsNyBAQCBzdGF0aWMgdm9p
ZCB1cGRhdGVfaXZfaXZ1X3N0YXRlKHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MzJfdCBpdl9p
bmRleCwNCj4gIAkJaWYgKGl2dSkgew0KPiAgCQkJLyogSWdub3JlIGJlYWNvbnMgd2l0aCBJVlUg
aWYgSVYgYWxyZWFkeSB1cGRhdGVkICovDQo+ICAJCQlpZiAoaXZfaW5kZXggPT0gbmV0LT5pdl9p
bmRleCAmJiAhbmV0LT5pdl91cGRhdGUpDQo+IC0JCQkJcmV0dXJuOw0KPiArCQkJCXJldHVybiBm
YWxzZTsNCj4gIA0KPiAgCQkJLyoNCj4gIAkJCSAqIE90aGVyIGRldmljZXMgd2lsbCBiZSBhY2Nl
cHRpbmcgb2xkIG9yIG5ldyBpdl9pbmRleCwNCj4gQEAgLTI2NjAsMTIgKzI2NjQsMTIgQEAgc3Rh
dGljIHZvaWQgdXBkYXRlX2l2X2l2dV9zdGF0ZShzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgdWludDMy
X3QgaXZfaW5kZXgsDQo+ICAJCWlmICghbmV0LT5pdl91cGRhdGUgJiYNCj4gIAkJCQluZXQtPml2
X3VwZF9zdGF0ZSA9PSBJVl9VUERfTk9STUFMX0hPTEQpIHsNCj4gIAkJCWxfZXJyb3IoIlVwZGF0
ZSBhdHRlbXB0ZWQgdG9vIHNvb24iKTsNCj4gLQkJCXJldHVybjsNCj4gKwkJCXJldHVybiBmYWxz
ZTsNCj4gIAkJfQ0KPiAgDQo+ICAJCS8qIElnbm9yZSBiZWFjb25zIHdpdGggSVZVIGlmIElWIGFs
cmVhZHkgdXBkYXRlZCAqLw0KPiAgCQlpZiAoaXZfaW5kZXggPT0gbmV0LT5pdl9pbmRleCkNCj4g
LQkJCXJldHVybjsNCj4gKwkJCXJldHVybiBmYWxzZTsNCj4gIA0KPiAgCQlpZiAoIW5ldC0+aXZf
dXBkYXRlKSB7DQo+ICAJCQlsX2RlYnVnKCJpdl91cGRfc3RhdGUgPSBJVl9VUERfVVBEQVRJTkci
KTsNCj4gQEAgLTI2NzUsNyArMjY3OSw3IEBAIHN0YXRpYyB2b2lkIHVwZGF0ZV9pdl9pdnVfc3Rh
dGUoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQzMl90IGl2X2luZGV4LA0KPiAgCQl9DQo+ICAJ
fSBlbHNlIGlmIChuZXQtPml2X3VwZGF0ZSkgew0KPiAgCQlsX2Vycm9yKCJJVlUgY2xlYXIgYXR0
ZW1wdGVkIHRvbyBzb29uIik7DQo+IC0JCXJldHVybjsNCj4gKwkJcmV0dXJuIGZhbHNlOw0KPiAg
CX0NCj4gIA0KPiAgCWlmICgoaXZfaW5kZXggLSBpdnUpID4gKG5ldC0+aXZfaW5kZXggLSBuZXQt
Pml2X3VwZGF0ZSkpDQo+IEBAIC0yNjk0LDEwICsyNjk4LDEyIEBAIHN0YXRpYyB2b2lkIHVwZGF0
ZV9pdl9pdnVfc3RhdGUoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQzMl90IGl2X2luZGV4LA0K
PiAgDQo+ICAJbmV0LT5pdl9pbmRleCA9IGl2X2luZGV4Ow0KPiAgCW5ldC0+aXZfdXBkYXRlID0g
aXZ1Ow0KPiArCXJldHVybiB0cnVlOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBwcm9jZXNz
X2JlYWNvbih2b2lkICpuZXRfcHRyLCB2b2lkICp1c2VyX2RhdGEpDQo+ICB7DQo+ICsJYm9vbCB1
cGRhdGVkID0gZmFsc2U7DQo+ICAJc3RydWN0IG1lc2hfbmV0ICpuZXQgPSBuZXRfcHRyOw0KPiAg
CXN0cnVjdCBuZXRfYmVhY29uX2RhdGEgKmJlYWNvbl9kYXRhID0gdXNlcl9kYXRhOw0KPiAgCXVp
bnQzMl90IGl2aTsNCj4gQEAgLTI3MzEsMTMgKzI3MzcsMTUgQEAgc3RhdGljIHZvaWQgcHJvY2Vz
c19iZWFjb24odm9pZCAqbmV0X3B0ciwgdm9pZCAqdXNlcl9kYXRhKQ0KPiAgCSAqLw0KPiAgCWlm
IChuZXQtPml2X3VwZF9zdGF0ZSA9PSBJVl9VUERfSU5JVCB8fCBpdmkgIT0gbmV0LT5pdl9pbmRl
eCB8fA0KPiAgCQkJCQkJCWl2dSAhPSBuZXQtPml2X3VwZGF0ZSkNCj4gLQkJdXBkYXRlX2l2X2l2
dV9zdGF0ZShuZXQsIGl2aSwgaXZ1KTsNCj4gKwkJdXBkYXRlZCB8PSB1cGRhdGVfaXZfaXZ1X3N0
YXRlKG5ldCwgaXZpLCBpdnUpOw0KPiAgDQo+ICAJaWYgKGtyICE9IGxvY2FsX2tyKQ0KPiAtCQl1
cGRhdGVfa3Jfc3RhdGUoc3VibmV0LCBrciwgYmVhY29uX2RhdGEtPmtleV9pZCk7DQo+ICsJCXVw
ZGF0ZWQgfD0gdXBkYXRlX2tyX3N0YXRlKHN1Ym5ldCwga3IsIGJlYWNvbl9kYXRhLT5rZXlfaWQp
Ow0KPiAgDQo+IC0JbmV0X2tleV9iZWFjb25fcmVmcmVzaChiZWFjb25fZGF0YS0+a2V5X2lkLCBu
ZXQtPml2X2luZGV4LA0KPiAtCQkhIShzdWJuZXQtPmtyX3BoYXNlID09IEtFWV9SRUZSRVNIX1BI
QVNFX1RXTyksIG5ldC0+aXZfdXBkYXRlKTsNCj4gKwlpZiAodXBkYXRlZCkNCj4gKwkJbmV0X2tl
eV9iZWFjb25fcmVmcmVzaChiZWFjb25fZGF0YS0+a2V5X2lkLCBuZXQtPml2X2luZGV4LA0KPiAr
CQkJCSEhKHN1Ym5ldC0+a3JfcGhhc2UgPT0gS0VZX1JFRlJFU0hfUEhBU0VfVFdPKSwNCj4gKwkJ
CQkJCQkJbmV0LT5pdl91cGRhdGUpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBiZWFjb25f
cmVjdih2b2lkICp1c2VyX2RhdGEsIHN0cnVjdCBtZXNoX2lvX3JlY3ZfaW5mbyAqaW5mbywNCg==
