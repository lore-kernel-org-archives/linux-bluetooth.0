Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF197C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Sep 2021 18:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9500160F9F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Sep 2021 18:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhILSS2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Sep 2021 14:18:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:11347 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229726AbhILSS1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Sep 2021 14:18:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10105"; a="208591291"
X-IronPort-AV: E=Sophos;i="5.85,287,1624345200"; 
   d="scan'208";a="208591291"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2021 11:17:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,287,1624345200"; 
   d="scan'208";a="698335710"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 12 Sep 2021 11:17:12 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 12 Sep 2021 11:17:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 12 Sep 2021 11:17:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 12 Sep 2021 11:17:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B58K1tz2l004oUoXenn/yQlwN3DInlwvEnBpfF1IA9ZuKn5m8UJFONgi7Fk7t3kZFDjcyue3j7quU+iIgFH7qDINUhPz7pYq/tKjZDtX5SuZsRcG4Tir14L8uol6tat8QhTn9bb3vZTFkiSIzYOhQJC8bEic8hQGomRchT/KzlBuW1lyj5x/36OK3YTlEhNDvao36mcRaSoH7qzxgQZVoyEt/80WFM/U+Fc2JyPn/DARTLt29hc//DNfjDO05A6D0cgyqmjmuhhFN6+LOpbAXMPM+vOXDi9Vfn7/0lzxb/3KP7w4+7/9+R/rbgMHGAEHmcGyUv/RwcZxZDi+ePztTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8hfP4FA88rnUublwDMwPxIyZiBmQzuuXq7E486Upvfo=;
 b=hhLnw+Q18geW53cf8galg3hFZrN0NoD4gBdaTbWhkze5MAB0jbvQkebZ+ODdbX4Wjsz5dnFyGMGcKcfxeEu2QvS6VXEJ2XG+DAkfruz8PDVkFSFYVQNCCIvdvbbNmdVqjh7HXhWWLP5m6TQRkwe7IGB6UraGj6PW/O+z+Q5wQRrkHhVd2/obbtnFwt0nK7xfmTRHbvHJP5tBD/pc7S/76XOfRG1wUBnoXUxajAjOuaF5pVXBt5XX1CaCXSWHqYkhSzwFp7E+QiJqOi4ktqZkKI2u5csoffENXBUaSnqiwJxyFFPNJWX5VkNGSWR1ibBB+e9AxCHJ5jwQL8TvhmtKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hfP4FA88rnUublwDMwPxIyZiBmQzuuXq7E486Upvfo=;
 b=o50VuwvN5oUktQz1sWIkw8vguBt85TI5p0pLkivGpubyqhVA+p8ZQ5ub5cvsoxacEBViZY8wT3DVOImMPIzAOAtkB+BSRxwgp4YByVs/ZP/EkTqlD/VzqzrT8v/rnGkUTLRA+udH3nGwD/IF/RO7ZwxdnuQaDM/JeTjYe6i2+aY=
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by SN6PR11MB2829.namprd11.prod.outlook.com (2603:10b6:805:62::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Sun, 12 Sep
 2021 18:17:08 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::99aa:837a:d8c:66c9]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::99aa:837a:d8c:66c9%7]) with mapi id 15.20.4500.018; Sun, 12 Sep 2021
 18:17:08 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "raulpblooper@gmail.com" <raulpblooper@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Which tool to use for Mesh Testing
Thread-Topic: Which tool to use for Mesh Testing
Thread-Index: AQHXmRN2mFlph+p/nEuoFzqRrgV1aquG6LEAgAAVgQCAGdRxgA==
Date:   Sun, 12 Sep 2021 18:17:08 +0000
Message-ID: <349e46295e4d76fbcfaf48514a438be4900444df.camel@intel.com>
References: <CAEwN+MAuLad-9jh0fb7-ZDN6kSGORf7Rd1HffGV4VpThkP=Rng@mail.gmail.com>
         <105cf340892caf0014eb154335784d8c46b8eb6e.camel@intel.com>
         <CAEwN+MDpQ=+XgNjTfhHn8n9mbbqSn5iVLYm1kMRVcUDMY4h9fg@mail.gmail.com>
In-Reply-To: <CAEwN+MDpQ=+XgNjTfhHn8n9mbbqSn5iVLYm1kMRVcUDMY4h9fg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c2e39ce-ce70-424b-6e31-08d976198893
x-ms-traffictypediagnostic: SN6PR11MB2829:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2829ADB43E51146E56170AD0E1D89@SN6PR11MB2829.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BLV6Ew1WNpEAE//x7My/O3khNq7Bd6Nv9pJjwUSpicbip2AJWthZfwH/OanRZhg5dvpzB5+1NztmWZ6yR8SCa2FOr/LVOiuDl8KldwbwvnlPGXlhMRQWg0PJMXr2yXGqpgxA77tINJQzQ1WlUJJBda+orlQCL1a6BK7DixMAahc9booJ3rvEb2EDL+tMsR6+XKv1RDN62o+80OwMfNE7hiuqi4P2zq6zCQKTl4/ONsooKpPNVDIYgFBhdpMMmMgS/XD9k7zNZxihJL5XDjBNmduvOp7s2Bq7t0mEfoZuwBo03EJS2gPebbmRJC0AK1dsWxHkaFWzrtZcFiUtEL8yfH/SJnO45d9efmkY5cUI7lNMRyR7qgPVIA1gJ4YSIiti6bzhOXq+/fPtipblGk13fB/YSY/SjB16K6lbPVKsy3w99Pm28Eo6zdXVwAj946FqyPuxXqBTWQ2O8qKs3rcs8g90bqQyv94YNxRisufzJbfzFtycIx0G+hTMk+5jCweAI0LzLdTulifQHTh/lfavsdr4N/8z+A0lQjlI5RjG4cIXuermxIIsKj6YT+AVGUwmQQFgA9OccVJPguRNsoqnL6YGtmzk5TxphACimMvo3pCWBSJg4wHprNlBqWFwn2cmc1e3MSe5mUHqyMlrPd7Uzexr3+BlEtenS1Xbz73PQIfaYVrvH4bG8nUlUVG2dGOz0pCNGomVItNmurATDJGGRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(2616005)(5660300002)(478600001)(6486002)(6512007)(26005)(86362001)(38070700005)(122000001)(91956017)(4326008)(316002)(66946007)(6636002)(110136005)(2906002)(38100700002)(6506007)(53546011)(64756008)(66446008)(83380400001)(8676002)(8936002)(186003)(66556008)(66476007)(76116006)(71200400001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWRidGNjSXN4bWhZemF6NzJxMU9WbFlLV0hiL3F2NGJsTEF2MlVsVEJhZjM4?=
 =?utf-8?B?bjZRV2tTOUVJQVhIaWhvMmc2RUF5QytQRUZuYXJMOFFmcHo3amlsNFcwdUJI?=
 =?utf-8?B?OUE2Z29aSmU4QVc4UFpVWGxwS1dBa0NWM0JWVFRkK1dqdHNpVm5hRHFNanJG?=
 =?utf-8?B?aTcvdGdHZjlxVEQ1RFhmODBPUHBYdHFuQXJMMjVSam81VlZWTzFMYzFkVmdD?=
 =?utf-8?B?NWcxN1JZOGVvU0xNcVpnNnJsTitUQ2NDSG1zRVd2Z0lHbU4zRUxrcklQbHZ5?=
 =?utf-8?B?MFBCcTc3SWRZSmEvR2RaQVB6Qzk3N29BODlLV3ZGMW5EZ0licmhDVWlHWEsw?=
 =?utf-8?B?enZyNUFpaEdFSi9JdTNaOElvRjNZUi9GN2JVZWFBdGIrcmFEZXBuWTRINDBR?=
 =?utf-8?B?VlVBaFEwSzl1Qkl0REFiYU16ZytDdys5Q29FVnRDMTRlY3Fkc3hnVG90S2lw?=
 =?utf-8?B?bndZWTBRbFlGK1BNN210TmROUjZmZHF3clphZXFZSjgzR3lNSm9ZMUJmSUdu?=
 =?utf-8?B?anV4RnArM0plYytXZjBITkt5L05XR2g4QVl1aW1sVVlIQXlLaXlnQS9KY3Bn?=
 =?utf-8?B?NWtpZHNWc0srMzNySFJ3aW5PZ2daaGtua1l4aGtJVDhsYjZXSW5QaDZyR2s0?=
 =?utf-8?B?SDVvNUxzcnUwMkNKK2JtSk4xMHNJYkh1VDVCRHJjZzNaYyt6OHEvMno0aDNo?=
 =?utf-8?B?RWJoOTYyQmtxZDNPaEV5aU50c3VZa1lnbWJsVkVhQklQVVlUZitnVzBCMGtx?=
 =?utf-8?B?V2FoS04rMGxTb1h6ZGlOOHdVVzJ0K2J0dG1UanhOSG1yaFlEcElFRCtYUjgz?=
 =?utf-8?B?WG5pOTBQdVBWUEkxZGVWWkVyQnZPaXhQaUxYY2NCN3lteDNQK3Y5RFZFSlNO?=
 =?utf-8?B?N05JNWpuRUN2dnFWWUkxNHVzT3hYWVRBeG9VNkFlMVI4cVpaYmxCSjNUMSsx?=
 =?utf-8?B?Y2dsVllNT3h1RjFUOGdIOHJSNW4ybzlHMXlkOGFnVExlWU5tNHhFL2wvdEIx?=
 =?utf-8?B?b1hFNmJoc1lWQ25DdWx4L0cxUE9SWkZobjdxQWdIY24xTG51ekpSalduWlBF?=
 =?utf-8?B?NXVLVmFURTJ3REFHTDFzZGJ6Ui91UlhVN1JKdllYL3JDRCtVUEtZK0NOdEpJ?=
 =?utf-8?B?TEZNM2RaMjN2Vmw3TzNiNExnaXQ0V0xCUkhCMjlIOFlLQ2NJMlBMY3FieHRC?=
 =?utf-8?B?UDhLaGNmL3MwN2cwTGduTlkxaUE4NWUyNTRpWm9YKzlkYStHcjVCa1o2TlR6?=
 =?utf-8?B?YXhNenhRTmhZTlZNbHFqcXBJVkFWbEZ4eWJaVkIyV09mYmozenNVVkJ3aE10?=
 =?utf-8?B?OXpadTFDWGRCY1FZdldKNzBySXd3K3hubWVldFg4K3B6YVpCUXpOZVdlcko5?=
 =?utf-8?B?U0pyeENkREswZ2xibEtwUGRsTGFtNUFuZWVndFFaZUgrRC92SURZbUxxeWRi?=
 =?utf-8?B?ZTNwUTFHQmFSSFIvbzM2QWNIUW12MjlINU5HVHRKcUxMaXg2em8xZVNUZ3ZC?=
 =?utf-8?B?VitqTTBLOU1wcVpQNTJnQWJNU2oySVhaSHR2alMxTzA1dGptc0xMRVkrTGxk?=
 =?utf-8?B?OHJLS0ZFWW12MTE2ZGJSV2R5SlpTaTRMd3EyVkNNc2RqMDBLcE5HTzc4VTRF?=
 =?utf-8?B?Z01UOUZ4YStqcWF2alVhVXVRZzkzRDFQV3BzWG5KSlMzMjYxdlJqSkpXRFVj?=
 =?utf-8?B?MUNNRlBRKy9VQ1Jyek42ZGcwaDFDMVRuR010QVVDT1AvUDZWWGRaSHRSZXli?=
 =?utf-8?Q?Cl0k0vJ9SIPZJlYlP1xXmpzq5SaT+OADRTHPw/T?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91861E62717E1B45A871DAABB71104DF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2e39ce-ce70-424b-6e31-08d976198893
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2021 18:17:08.5974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Blz/MwEEkFNN0oGpI+6lPzrJ/Byc9C7A69dLKEGUukhy9Gebjuo1xDzMuFPybQM/47BPY+xmSi4eDhOR8KeF9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2829
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gRnJpLCAyMDIxLTA4LTI3IGF0IDEzOjIwICswNTMwLCBSYXVsIFBpcGVyIHdyb3RlOg0KPiBP
SyAsIFRoYW5rcyBJbmdhLA0KPiBJIHdpbGwgbm90IHVzZSBtZXNoY3RsIGFzIG9mIG5vdyBiYXNl
ZCBvbiB0aGlzIGluZm9ybWF0aW9uLg0KPiBTbyBjdXJyZW50bHkgdGhlcmUgaXMgbm/CoCBQQi1H
QVRUIHN1cHBvcnQgaW4gbWVzaC1jZmcgY2xpZW50Pw0KDQpUaGlzIGlzIGNvcnJlY3QsIGJ1dCB3
ZSBhcmUgYWx3YXlzIGxvb2tpbmcgZm9yIHZvbHVudGVlcnMgdG8gaW1wbGVtZW50IEdBVFQgc3Vw
cG9ydC4NCg0KV2UgZXZlbnR1YWxseSB3YW50IHRvIGFkZCBQcm94eSBTZXJ2ZXIgc3VwcG9ydCBp
biB0aGUgZGFlbW9uLCBidXQgd2Ugd2lsbCBwcm9iYWJseSBuZXZlciBpbXBsZW1lbnQgUHJveHkN
CkNsaWVudCwgYmVjYXVzZSBpdCBkb2VzIG5vdCBoYXZlIGEgcHJhY3RpY2FsIHB1cnBvc2UgaW4g
YSBtZXNoIHN5c3RlbS4gUHJveHkgaXMgY29uc2RlcmVkIGEgbWV0aG9kIHRvIHN1cHBvcnQNCmFk
dmVydGlzaW5nIGluY2FwYWJsZSBsZWdhY3kgZGV2aWNlcyAobGlrZSBhbiBvbGRlciBtb2JpbGUg
cGhvbmUpIHNvIHByb3ZpZGluZyBhIFNlcnZlciBhIGxlZ2FjeSBkZXZpY2UgY2FuDQpjb25uZWN0
IHRvIGlzIGRlc2lyYWJsZSwgYnV0IGEgQ2xpZW50IHdvdWxkIGJlIHBvaW50bGVzcyBleGNlcHQg
YXMgYSB0ZXN0IHRvb2wuDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IFINCj4gDQo+IE9uIEZyaSwgQXVn
IDI3LCAyMDIxIGF0IDEyOjAzIFBNIFN0b3RsYW5kLCBJbmdhIDxpbmdhLnN0b3RsYW5kQGludGVs
LmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gSGkgUmF1bCwNCj4gPiANCj4gPiBPbiBUdWUsIDIwMjEt
MDgtMjQgYXQgMjM6NDAgKzA1MzAsIFJhdWwgUGlwZXIgd3JvdGU6DQo+ID4gPiBIZWxsbyAsDQo+
ID4gPiBXaGljaCB0b29sIEkgY2FuIHVzZSBmb3IgQmxlIE1lc2ggdGVzdGluZywgbWVzaGN0bCBv
ciBnYXR0LW1lc2ggb3INCj4gPiA+IGFueQ0KPiA+ID4gb3RoZXIgPyBJIGZvbGxvd2VkIGZldyBt
YWlscyBhbmQgY2FtZSB0byBrbm93IG1lc2hjdGwgaXMgbm90IGZpdCBmb3INCj4gPiA+IHVzZS4g
UGxlYXNlIGFkdmljZS4NCj4gPiA+IEkgd2FudCB0byB0ZXN0IGJvdGggUEItQURWIGFuZCBQQi1H
QVRULg0KPiA+ID4gVGhhbmtzIGluIGFkdmFuY2UgIQ0KPiA+ID4gUmVnYXJkcywNCj4gPiA+IFJw
DQo+ID4gDQo+ID4gUGxlYXNlIHVzZSB0b29scy9tZXNoLWNmZ2NsaWVudCB0byB0ZXN0IHdpdGgg
UEItQURWLiBZb3UgY2FuIHVzZSBpdCB0bw0KPiA+IHByb3Zpc2lvbiBhbmQgY29uZmlndXJlIG1l
c2ggbm9kZXMuDQo+ID4gVGhlcmUgaXMgYWxzbyBhIHB5dGhvbi1iYXNlZCB0b29sOiB0ZXN0L3Rl
c3QtbWVzaCB0aGF0IGltcGxlbWVudHMNCj4gPiBvbi9vZmYgbW9kZWwgYW5kIGNvdWxkIGJlIHBy
b3Zpc2lvbmVkIGFzIGEgbWVzaCBub2RlIHVzaW5nIG1lc2gtDQo+ID4gY2ZnY2xpZW50Lg0KPiA+
IA0KPiA+IEFzIGZvciBQQi1HQVRULCBtZXNoY3RsIHdvdWxkIGJlIHRoZSB0b29sIGZvciB0aGF0
LCBCVVQgaXQgaGFzbid0IGJlZW4NCj4gPiB1cGRhdGVkIGluIGEgbG9uZyB3aGlsZSwgYW5kIEkg
ZG9uJ3QgZXhwZWN0IGl0IHRvIGJlIGZ1bmN0aW9uYWwuDQo+ID4gDQo+ID4gUmVnYXJkcywNCj4g
PiBJbmdhDQoNCg==
