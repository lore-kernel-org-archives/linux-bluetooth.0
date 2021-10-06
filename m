Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D44C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 17:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED4860FC3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 17:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbhJFRp7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:45:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:5347 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238130AbhJFRpm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 13:45:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="289561366"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="289561366"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 10:41:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="439981613"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga003.jf.intel.com with ESMTP; 06 Oct 2021 10:41:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 6 Oct 2021 10:41:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 6 Oct 2021 10:41:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 6 Oct 2021 10:41:28 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 6 Oct 2021 10:41:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETX4EDa62209rhycoyAcFCBvyxMrUTS7O9rvD+dmEExeCji1HsYMRCgxuNeJGR+sACNHl/IQIb3fHAyVVsksngFZcQGaJ/jEtwWUjbYZP8H6FiCFEPE5gx9z0fszckdG707sdmn7YWtqgvwBIvLsN0L2OplSMC3AQ8jInJ5EijkwBNS8yHTUMrgJpQjRGpsCmgeHZTd3u1XLuig38jXGSWfEZL1zNa3w9FmVciNVNDPFRfHeeKHZkWj/HBEGVTU8Z07SkvZXNpvUbkEf45JEW5JoCnqvLG7+u7B+61ph8F+O8fvhPjaAxH82Gok/jcGqBxcSwpKxUo6hGsNiKiaHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1XQnUyzjPJNcpD9n/OEafV0g0tIMVpL4ISzK2FEHRc=;
 b=lKVyFxOkYOjfWduRQiWq419RFOQ5todOHkODPBswT0TDlyhtuJ+/suc+eADEXWdFV4DslN1PdqE6lHr80ydFy6gVXvbzvxY/L7MO7ipbnVQFtK5iY/1D3fWeCyMBGK0C2MRzv4x9Eojycjk6ev18NexjFVpKABn1kOwXkPPMx6ZPIxOaQt2cjUFLZ0DoiXfbqZHKdTH6dk8MkL4M6M1wA+23oDQqPd/MOiKkA+dQscq4TUfrjM8GXx5AHvJ5VUHtMxq9YG5BAU5V3BKx2IjyBe0Y0/c9kwRe8cVi9qPUJofEJTjhQlNT2KDEmGGNlFxV+slrZQ7ME54jMVLtAzgc/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1XQnUyzjPJNcpD9n/OEafV0g0tIMVpL4ISzK2FEHRc=;
 b=p77Tb1IeuBrLZT2O3VcOHFTXg6FsQl/ybpWpn91JEeEHCcGk0nIeIEWtjS3f2EAOb96aE1ZGYONHKb8o3naq8xgS87Yw+P/G6ZMwXMDG8hzYZ68UO27W3K6d6lFjkQH57M3F4P1llRS9W0exDtZxVyYIodXM1ggoyKxfhz455Wk=
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 6 Oct
 2021 17:41:26 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::194c:9213:9b06:8c7f]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::194c:9213:9b06:8c7f%9]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 17:41:26 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "marcel@holtmann.org" <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH V2] Bluetooth: mgmt: Fix Experimental Feature Changed
 event
Thread-Topic: [PATCH V2] Bluetooth: mgmt: Fix Experimental Feature Changed
 event
Thread-Index: AQHXus/KhFMw2UBfFkKgYTwjIo46savGO6KAgAABhAA=
Date:   Wed, 6 Oct 2021 17:41:26 +0000
Message-ID: <887509a7ea503c6633f2779fe6c26cb16dc20da8.camel@intel.com>
References: <20211006163228.154401-1-hj.tedd.an@gmail.com>
         <D7FCA4BD-A3AE-413F-BFC1-E910E55CD906@holtmann.org>
In-Reply-To: <D7FCA4BD-A3AE-413F-BFC1-E910E55CD906@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-2.fc32) 
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5825548-37f6-42ae-9f91-08d988f085d8
x-ms-traffictypediagnostic: MWHPR11MB1599:
x-microsoft-antispam-prvs: <MWHPR11MB1599FC92140A2585B9140BB8FFB09@MWHPR11MB1599.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F9OZWUB/IJagu4oiTU6wS1FDs0D2mRnXd/hbsCFGS40hv5gIhynvdWBS64krPXoH/nJOaiX+jc4nt8SJCAZIJFOb0Lf2lP06HRpCE9MX05QUFy5IBlqw7a4pEWnLasuC3jdXTBijTdXAX2TXSA3o4/OWQ0FSjmoHgCzcbapmggel7oo8yspsCv+af82nkuvoanIt6V6qCXwwUhinYJlbbw9LAuAQvRSAJnpkUBPdteMU04TPRGhUv8McDtJd29H6jAgv/97T1HwS3xSM65wga14AD116tipr4C1llbMjdjQzXbPGOkLFe+K5R1gmzQ0L+RwmY76N22qO0Nr891RWYdletB+OHChcvBtA7xF1sg15ov2LtI+MsE3Y7urHbjwu3uNnJDY36rxQIjqw3myfeUbMFAAzPbg6U5z4MgOZM0tLnteuj1cJSVkyV/aqkS17ZNps1GpNYjLoilUipHld0MzvqKO9mQxI5vQqjhj8Q6H0MnwVYLrq9Q17dUKvxYkuZ9izXlbfu6rFic5OlYep9jSAwS08HyK4Hf2o6nMOvkHgaM9ih8vSav1LjVKKSPM94rhwv3O5vJunJDgfky+RTHmUNPRC8g7AH8XIlKOloKOCw/qyODNeYxHsiyQvuwegLUeYhcc6F7MGuhRhzjRk5KSIpv15nvThqWiYAV5lphsjlsKKC0mzcxa/SMDF0OpRNvUAQxJUDcCJ8WMD/Lw54Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(6506007)(6916009)(83380400001)(2616005)(2906002)(5660300002)(36756003)(38100700002)(508600001)(122000001)(316002)(4326008)(8676002)(86362001)(6512007)(76116006)(8936002)(38070700005)(71200400001)(66446008)(64756008)(66556008)(66476007)(26005)(6486002)(66946007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkFsUEkyK2psaXhGZ1lpMkt3RjNXQ1hrTHZtTWlsNDBNZXdGTkN0Ly9EMzgw?=
 =?utf-8?B?azgza0FDeE96VzgxVXY5NXZBUjRLdGJvb1h1YW9uQk9kV0JBalkrVHlrWXhq?=
 =?utf-8?B?RE5nOVAzckQwOWlGQXRrNE1hNVV1NzJJZ0xJSHF3K2I5SDF6TU9NbGMySWl0?=
 =?utf-8?B?cTgrellvcUp5enhMQjk4c2RlSVRRM3BJYmpETWxtWXM4MGY3dU9qak5BRG5V?=
 =?utf-8?B?Y3M3THJXbTVZN2NXQXR3aWVIQm9ENTJPYXRUVUIydzQwUFl0R3kzUHgyckx1?=
 =?utf-8?B?R1hMeUZuVDRVNTVjTDhld0czRXg3WnFsdnhYd2JMK1ozRFpLSkkyeFV2d0FW?=
 =?utf-8?B?TVhHdEZPejlyNm5OU0JHWUpFOTZKQllhWXlrajZSZkFvd0NpRzB3RmNQa1Zr?=
 =?utf-8?B?aXB1WURkaWdRcG5nZFFYL1BKS09EWGdqeUlwdjE1NlBWd3RPOVpxK2FuMjZz?=
 =?utf-8?B?QXhGRkxCQWpHNjhpd0EzczljTUR0Q3YzSTBJdGkrRWJKbThYYlJNMEs1eHVC?=
 =?utf-8?B?Si9nY0tBZi9IcytuRmk4YjZRajJ4TVdVUGdmRGZ5R0lqZEYxZG0xdXR6OGts?=
 =?utf-8?B?ejhzOTVsaE81Qkd6WmlBQlJxU1FxYjZRZHlhM1ZYRzFNUlVjZWU3UkppY0l0?=
 =?utf-8?B?RmFQUVB5WUovZnhDWmFEQ04zbjRJc3VzWDBCY3FNelN2WVRub3NjWFhiSlVG?=
 =?utf-8?B?VWVmYzFFdmRQN1pZd1Fod004M1l1M2VkQUtNL0JhWEZINi95bDc2V0JBRGVr?=
 =?utf-8?B?bFR4dElWWUhKYmJ1RC9QWkpUYWw0VjQzVzY2ZzBmYVhWbjUxQUZuTllRS09X?=
 =?utf-8?B?SUxCVm9yNUJGajg2OXFKbm45UlhhVzQ1ZDlaVEhtL3FJRENYTzh2UWlIemZ0?=
 =?utf-8?B?NEVCc0YyK1hwSFJGdGxBaUYvczFZaFo2L2JGY2l1Z3V3M0lWUVVxRGVhZkJi?=
 =?utf-8?B?c0JDck9YY24rV29uckU2eHRHdjVTUUpPUzVtdmhuM3o2MFcxN3NCL0VyR2da?=
 =?utf-8?B?OHZ1aWsxaUlWVXp2OEhZUHZYTnJ2SzBMelRpNnNYU0FtRVdyOXRLdk9YODM5?=
 =?utf-8?B?ZUlPZjZFemVRVzZBRHZsSDNJU0JSS2dTZ2plWVVkc21wQmtGYVU4dlBEN0wv?=
 =?utf-8?B?eDZFRmF1d0dlWGU1Q005dFpzWEhqRzRWdXFyblhhU1hTbkFCY0NUL0NmRzdh?=
 =?utf-8?B?dE1EL0pYWDU2V3JaMy8zd0NHUTRIUHF1bGxxL203ZEVVOG9xVmtnb3M3VWtP?=
 =?utf-8?B?clMzcyt2aW9mVDhnYmorOGdPZzArbnJGQzBvaEg0RWJmdnpXdG5pLzIvUXE3?=
 =?utf-8?B?ZDFnWkZ0bVowUUxYNEJRZ1V2YndPRVhVRjcxRmltV3Q1TEh5dkVHVUlGU3dP?=
 =?utf-8?B?ZGI0UXp6bEE2SzM0a2pYV29Sc0JSYTdpb3h6MEttTC9SSjJmd0F5SGwvVjRR?=
 =?utf-8?B?aHdRQzJGNWlVQmJ3a2pYd28yRHBoY3FaaURxcFpTdnJSeWhMUzR1d3B4d09K?=
 =?utf-8?B?YnNlNDEzWlhZbHc1MEFoeWtFT3VSaHQ2ZlQrN3ZCc1ZCdm5pTFI2bjdqclE4?=
 =?utf-8?B?dDlRampCd0c1RnFUaTJhWmhPNk5sb3kyK3U2bm1XbTdlZ1BzSGRuMXd1NXB4?=
 =?utf-8?B?Yko4cnc1TTZiZHRhSlc3MXlGZVk5MTZDY2lsZkZvMXY5Y3U5eDZEWmZ2ZHE1?=
 =?utf-8?B?SmlKeXVKT1ZkU0hFSm1NM3F4NktzSmdZZ3JFOWtFYUgxbXY4SVcyZFFmaXJn?=
 =?utf-8?B?ci84VjdZWnI2WWxGWE14cXJneWhOQWFNSFRCQzYzd2FxWXB3QlJDcHNjOXlm?=
 =?utf-8?B?djdnT3gvOTBaSnFxRmdlUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D4A33F5EAE3984CA8EC30F871B4A122@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5825548-37f6-42ae-9f91-08d988f085d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 17:41:26.8183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jWc0euWvDmRPQCdcLbfpzPcCzD0zeq7xRX+SzGCzavKKpebsKu2KQf8YVPEy/f68En9F/gxq3hllsQqOaWhazw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1599
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQpPbiBXZWQsIDIwMjEtMTAtMDYgYXQgMTk6MzYgKzAyMDAsIE1hcmNlbCBI
b2x0bWFubiB3cm90ZToNCj4gSGkgVGVkZCwNCj4gDQo+ID4gVGhpcyBwYXRjaCBmaXhlcyB0aGUg
Y29udHJvbGxlciBpbmRleCBpbiB0aGUgRXhwZXJpbWVudGFsIEZlYXR1cmVzDQo+ID4gQ2hhbmdl
ZCBldmVudCBmb3IgdGhlIG9mZmxvYWRfY29kZWMgYW5kIHRoZSBxdWFsaXR5X3JlcG9ydCBmZWF0
dXJlcyB0bw0KPiA+IHVzZSB0aGUgYWN0dWFsIGhkZXYgaW5kZXggaW5zdGVhZCBvZiBub24tY29u
dHJvbGxlciBpbmRleCgweGZmZmYpIHNvIHRoZQ0KPiA+IGNsaWVudCBjYW4gcmVjZWl2ZSB0aGUg
ZXZlbnQgYW5kIGtub3cgd2hpY2ggY29udHJvbGxlciB0aGUgZXZlbnQgaXMgZm9yLg0KPiA+IA0K
PiA+IEZpeGVzOiA5MzMyZWZkZjAyZTkgKCJCbHVldG9vdGg6IEFkZCBvZmZsb2FkIGZlYXR1cmUg
dW5kZXIgZXhwZXJpbWVudGFsIGZsYWciKQ0KPiA+IEZpeGVzOiA1MGE3NWYxNTUzMWEgKCJCbHVl
dG9vdGg6IFN1cHBvcnQgdGhlIHF1YWxpdHkgcmVwb3J0IGV2ZW50cyIpDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogVGVkZCBIby1KZW9uZyBBbiA8dGVkZC5hbkBpbnRlbC5jb20+DQo+ID4gLS0t
DQo+ID4gbmV0L2JsdWV0b290aC9tZ210LmMgfCAxNSArKysrKysrKystLS0tLS0NCj4gPiAxIGZp
bGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gcGF0Y2gg
aGFzIGJlZW4gYXBwbGllZCB0byBibHVldG9vdGgtbmV4dCB0cmVlLCBidXQgSSBoYWQgdG8gZml4
IHRoZSBjb21taXQgaWRzLg0KPiANCkkgc2hvdWxkIGhhdmUgcmViYXNlZCB0aGUgdHJlZSBiZWZv
cmUgZ2V0IHRoZSBjb21taXQgaXQuIFRoYW5rcyENCg0KPiBSZWdhcmRzDQo+IA0KPiBNYXJjZWwN
Cj4gDQo=
