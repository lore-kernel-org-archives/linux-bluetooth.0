Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D525FC433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Feb 2021 19:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FF764DF5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Feb 2021 19:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhBPTzx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Feb 2021 14:55:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:55096 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229767AbhBPTzr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Feb 2021 14:55:47 -0500
IronPort-SDR: R0mVrRUmqbNA1b1jG/ESPD2L5SOhnEp7RbU4/CQUJ1w/umzs2jecKUOs+TikE/lGSLztMH21bp
 grRnSSO/u3zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="202199049"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="202199049"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 11:55:06 -0800
IronPort-SDR: 4K3kpWGI9h9Z1d20HuomHzHTUSLbrMFAgQNMTWo/VCkGLhFnQNiDbMeMqS7GBSxESpa+3qlDIn
 72ZhwYIDV9mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="424818345"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Feb 2021 11:55:05 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Feb 2021 11:55:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 16 Feb 2021 11:55:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 16 Feb 2021 11:55:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQYXiB6ZspjKriYQ1sznQiwFpAp42FT57Yk6bL9a0dLuuiJZKSQi0YaXGc0TITuvWPoLfm/DBRoxc5IwaAdFc6PDPvw35/IaHUXoMWmJFS/Y9z2QzHZvcoS6zY5jOcc1Tcwph603ywSvjYv3VaF7D/5zkLUzZ7hx6fNNiupIEu3x0VVt04mhtr4M2Ld0oweuJ6KNi8+VlRslTvgCNQrnLRDjMvIg+DHsnRFFadPUp0yPHdAixeNqZEg/qv4MiD/ZdfC97ReVoEjXyiZnVSC/2lJlrkly8dI9FYjT5g2n6pvn5dTfSRtDDaXexd6OqC1Q4BkzFWduxW7cBPsf56ZTNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9XA5iCFEs3mA5AFySww31/O+6VrfFHutfqG5IXfuVI=;
 b=JqgkzjgPZet0vIe/RP7M2GY8Ns76uv/IWcK64P5IzegtlRBJvgr2br2TED66p830UxJrUybnAJX3ptYZKusV9M0ZNRqq4CN5crIPcgFK+CAk8rQDYTf5lISdvGBU9bj5brdYdnHfcWdTJElEt/7J/u5Y0/ILG8/iiPMKDoDieEbc7/XY8iQxCSAc6i4co2RGOmrT9mAYCDUbIUPRgH2E0KoD3FSRXjJ2zxnEoClFgAwNmog3T8dTa+GlzjoPLgvQIYyxbmrR4B8Kq0Xz3RmAKydCuKn4moY5LJqwwCZYFBvAiqsWoT5ylOSXL0KBUX18RrRdKdNCOdmICkenWD7iDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9XA5iCFEs3mA5AFySww31/O+6VrfFHutfqG5IXfuVI=;
 b=OK3FOLLYyop3rWunbol6HTKWsgd4REbvNj+uLLX0OIohxmCjH70r81tqhJhZ7HOee4uUGoywkaA6TfEpRmljt9Smf3bO/ASCgcF//dv/zBcEg4PGvIex6Bh4Sv844Qvs0hg25s/rl1InEbd8uTHsqAM8QRC2UNDSteOj2tD0Omg=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4538.namprd11.prod.outlook.com (2603:10b6:303:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Tue, 16 Feb
 2021 19:55:04 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab%7]) with mapi id 15.20.3846.041; Tue, 16 Feb 2021
 19:55:04 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: Re: [PATCH BlueZ v2 0/4] Use compliant UUID for mesh
Thread-Topic: [PATCH BlueZ v2 0/4] Use compliant UUID for mesh
Thread-Index: AQHXAYgJ12Nqm5NnHUuIoyQ3Y1cT2KpbOCwA
Date:   Tue, 16 Feb 2021 19:55:04 +0000
Message-ID: <f56024b1f25c8ee51eb1da2dc66deeea678d92a7.camel@intel.com>
References: <20210212214244.74995-1-inga.stotland@intel.com>
In-Reply-To: <20210212214244.74995-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9eba3f73-62d0-4095-0d65-08d8d2b4c122
x-ms-traffictypediagnostic: MW3PR11MB4538:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45387AEB8A738941047D9368E1879@MW3PR11MB4538.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g2FJXPU2JyVApOd6lc6+hINzRsJIezf4Y1bQuaO4fjvhNeNsgriRG/PoqftRQ88OlWj1/l3NvUJAW0QUZN4JWBiLONKOOBFfdbDuSggm04h55vmjVNXE/RKh2rv/eGw7QN4z/0JRGgT7sEFFsPTRERtCaYEb2GdNc/iKqjsTBYDApMB+KZGo3RXiIpXt9cwYnpVLDeNDM6itGammrvJArKlL6HBlKnXfBu68DIXBPEImMkse9GEtLIlHCvaqsblRdsA4Ce5+NBJzTHVF4GTROGKGzyDUaPSdH8nyi1WdZRIBO5VYJ/i0n0UFh/UaDCFvA0u5PIJERQhc6vApaBaQ6IJaT/pg1sHJ0C19igbzWEJW2662VXFefzqSGyc+bpBpcBlSsFTWx79ofOAdOxjya4IXkV0Ep2h9OfJ2xGFirjpoSGfvd2sAS2+q9QAkMdMFYzGgyp8Jtl0hOxwaTe9VLLUvWYO4GYmtTx1yrlNRS0g+u7rnfgB3NLdCdzS1Bt1FoPKjTEEQ+RGBP5orK65KpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(366004)(396003)(26005)(110136005)(6486002)(2616005)(4744005)(5660300002)(6506007)(186003)(36756003)(478600001)(6636002)(6512007)(8936002)(83380400001)(4326008)(76116006)(8676002)(2906002)(316002)(66476007)(66946007)(66446008)(71200400001)(86362001)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z2l5UTZHWC9TcVRiRXhIZ0RwNWYxOXRWZXlyMWNIdnlIQXpMNGsxaUU4TUNZ?=
 =?utf-8?B?Ly9wQjJLWVl5V3IweEltN3h0Z2o0YlVhNUhPeUpCRnJ4NzFHK3J5ZDlWSUMx?=
 =?utf-8?B?RVBqQ3k4c2VOSlNGeDNCUkZRRUZSWmRiaE84UU1lUjJvNi9YVHRWS1p5UUV3?=
 =?utf-8?B?ZnV1Mk8rNVBPMGsvZG1pbk5wbGJPUzZiaEVycFlGY1U1OWxjWjhtSC9EWW12?=
 =?utf-8?B?TlE3aUZScFcxb2FlNGUxSnFtRU1oMW1hRThKK1ZCQ2w1dmVzZnlsY1JyNStv?=
 =?utf-8?B?SFNZQ21Yb1RVZitZY1hndmRYbzVuUnZ4ZEZSY0oyK0doYWJFZHZuOFprZDlx?=
 =?utf-8?B?V3hkMFVPN1R0SDNJRE9aYnAyMW9qL25MeGVNdDVuVDBzUm1adkNJa0xCSUFZ?=
 =?utf-8?B?aTBwWUpoYmtkKzJQYlBlK0RKLzZQb2lES1RBd3lLYmVtN3F1U3crL1pqeTVB?=
 =?utf-8?B?c1NWRHFqNXU0dHRUMUlDYThQVFlLdjcrLzgrazJIK0VBVytHK2JDeElLTG1L?=
 =?utf-8?B?V3N3bzJhM0l5UW9SenExQWE2enRqdy9kbUpVTmE3QklzeWQvcUdTOUNXenBC?=
 =?utf-8?B?dHcxOTNsUGpCUlZtQlg0UUg5L2IrVVhYTmxWcmZRMk03enpoSHlWOTVqUDZB?=
 =?utf-8?B?TFZPYmtXNHZCRXJydTMrNXZ0MEhxN1RMM0Z1QWhlMUs3UDl3K3M3VXRVZnhN?=
 =?utf-8?B?M1dTYTRzcTJmZXNBYm9Mc3BMY3VMNlFzSTU5a3lELzF5Z0h2bGJ6R25UdUJv?=
 =?utf-8?B?c3lCUllmQ05YMFMybkZWRU1BR243SzRLU0RlalJwTFdLRzl0amhUNXovdDdv?=
 =?utf-8?B?R2NjWWhENk1zcnBsQ2dWOVNPS2hDSDdKNHVwWEZiSytHN3g2a0lZeFVOMC9r?=
 =?utf-8?B?NVZnVzU0cS9ESVc0RFVDdnRTbTJnSWNIbDcwb0NXWVJ4TERldGFXZURNRGRa?=
 =?utf-8?B?UzB3Q2RmZHBXdWhpamJGM2cvS2lnRWZkd21hei9qN3FjeGRmMWhKYlJneGJr?=
 =?utf-8?B?QnpjRENPMzRkT005YWtCUHZPU3JocWFSV25GWlJwR3g0azNhMndidDZncHo1?=
 =?utf-8?B?V2NQVWZzc090Qk9XSFJUZFhvWFd3TlRNTnZSZUw2UTdBOVpMY04wRXZkV0Fi?=
 =?utf-8?B?b2I2cW9UN2xJWFMwTUx0SUVMdzVuak1mVVl0dlYyeWd0YVBvOFZ2ajNmekZa?=
 =?utf-8?B?dFJzRGdUR0FlNEhwUHR2WnBuQ2ZDaFdUb2d3ZWxNUzVHSEV5WWhLOWsvK0ls?=
 =?utf-8?B?UUZZa2NUZGhNUW9IblYxOVBxNDVGRUFsMEVJZTRsdFljaERvbk44R1RXYW1S?=
 =?utf-8?B?YVRiOVRKUXBJSU9pS3NSZXZLc3lHSVF3RmVhVzZNK2J3Z1ZLOXRvSmRJVm9H?=
 =?utf-8?B?SExLdXcyaFVUUStjNncwbzFCaXh6NVcySGM1a0xDWWEvc1NJbzR0bHlEUWdu?=
 =?utf-8?B?TkJrWlJhbVJUKzlKekJERnIvTnBYRllXRXR2OXVhck9oNGU1YW5PVE9GeVNq?=
 =?utf-8?B?MXc2R1BKUGpJOGFrVG9BRkFQZjFvZElhcXlYVEd4QzhhdkFXR0NOSWdPVkxk?=
 =?utf-8?B?dXlwcWZkaEd0cUtXazJid1dJZ1kwMHc1M3Z2aE9Nb3BOZlZwQy9FM2tOeHZj?=
 =?utf-8?B?VERpTWNmU2lTeU9NaURmSUcva1NWVVFOMGZFU213bG4zMTBNNzJQdXNNVm5Q?=
 =?utf-8?B?OVhZVnRWdFpHcGJ3ZnZOZkdHeHBLWWwzSFZvTjRsWHZSOGJDOHErS25UWlBP?=
 =?utf-8?B?Q1N6VjN3VU5BOVpOdlM5aE9qUGZsMTloamRlV1JiY1FJWXdhaEJ0M3hUUXg0?=
 =?utf-8?B?SjN5YjdnbGVKcTFSV1VFUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F77FBCFA78E54E4B8DCB3D50B463BA63@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eba3f73-62d0-4095-0d65-08d8d2b4c122
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 19:55:04.8369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kx+OmBtJ6jjnRpnfLq1P/JEWU1TZlo1fcHT7VzuH65TQT4R340fS0Qo2CSwFbJX50X/yJ3eEY4ZasfSj4wQMpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4538
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KDQpPbiBGcmksIDIwMjEtMDItMTIgYXQgMTM6NDIgLTA4MDAsIElu
Z2EgU3RvdGxhbmQgd3JvdGU6DQo+IHYyOiBJbmNvcnBvcmF0ZSBNaWNoYcWCJ3Mgc3VnZ2VzdGlv
biB0byB1c2UgUHl0aG9uJ3MgdXVpZCBtb2R1bGUNCj4gZnVuY3Rpb25zLg0KPiANCj4gKioqKioq
KioqKioqDQo+IE1lc2ggcHJvZmlsZSBzcGVjIHN0YXRlcyB0aGF0IHRoZSB2YWx1ZXMgdXNlIGZv
ciBEZXZpY2UgVVVJRHMNCj4gZm9sb3cgZm9ybWF0IGFuZCBnZW5lcmF0aW9uIHByb2NlZHVyZXMg
b3V0bGluZWQgaW4gUkZDIDQxMjIuDQo+IFRoaXMgcGF0Y2ggc2V0IGFkZHJlc3NlcyB0aGlzIHJl
cXVpcmVtZW50Lg0KPiANCj4gDQo+IEluZ2EgU3RvdGxhbmQgKDQpOg0KPiAgIGRvYy9tZXNoLWFw
aTogQWRkIG5vdGlvbiBvZiBEZXZpY2UgVVVJRCBjb21wbGlhbmNlDQo+ICAgbWVzaDogQWRkIHZh
bGlkYXRpb24gb2YgRGV2aWNlIFVVSUQgdmFsdWUNCj4gICB0ZXN0L3Rlc3QtbWVzaDogR2VuZXJh
dGUgY29ycmVjdCB2YWx1ZSBmb3IgRGV2aWNlIFVVSUQNCj4gICB0b29scy9tZXNoLWNmZy1jbGll
bnQ6DQo+IA0KPiAgTWFrZWZpbGUuYW0gICAgICAgICAgICB8ICA2ICsrKystLQ0KPiAgZG9jL21l
c2gtYXBpLnR4dCAgICAgICB8ICA5ICsrKysrKy0tLQ0KPiAgbWVzaC9tZXNoLmMgICAgICAgICAg
ICB8IDE4ICsrKysrKysrKy0tLS0tLS0tLQ0KPiAgdGVzdC90ZXN0LW1lc2ggICAgICAgICB8ICA3
ICsrKy0tLS0NCj4gIHRvb2xzL21lc2gtY2ZnY2xpZW50LmMgfCAgNiArKystLS0NCj4gIHRvb2xz
L21lc2gvbWVzaC1kYi5jICAgfCAgMiArLQ0KPiAgNiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRp
b25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4gDQo=
