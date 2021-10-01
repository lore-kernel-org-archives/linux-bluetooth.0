Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BDAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 22:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6680161A8F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 22:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355715AbhJAWJX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Oct 2021 18:09:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:49906 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230307AbhJAWJW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Oct 2021 18:09:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="223696167"
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="223696167"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 15:07:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="480752077"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 01 Oct 2021 15:07:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 1 Oct 2021 15:07:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 1 Oct 2021 15:07:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 1 Oct 2021 15:07:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjbYlJEbeM8UU2pKmr8tuK5uxUnxG9511HYWB10nvtfCBXzuv9yBEMBH65Jp2pPP+X7y+vm9xpCeD14tuF+AT6+5/OE8hAaZrMLjfUdgoeiypvUlJaWMt1Ctl3SRWCQScqDiF4NEqabLCcDArP0QnURDXPHn6d7L+FFU+uhPeh5E21W2UVJddbW0vOX/6Q41HfURpzm7duuumpqWMGrwR8VYh0xtk09IGhwT5c8z9KFADyVMyog5RDEpkDNydNxt1KlhpXpbe1w1zQzbRQTxWT1lpKm7L0an/FZZBdbrlICFYGiRBQOBwilkdkY4hm4onprO7Eu9On/lsbLlyo9EeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZsAMrvJ93w9I/afLGe+ZR321W6/MJyljIk94rjgMJA=;
 b=fwpHoe/PZorO0TcwnYEWWBA4f+IX7DloUzZ6ytJnZ5kcxfTXuHNybkuJehwBXFdMBx9dxoF0JLn3zSEaIxG3G0YUKqSd649Fh133XShx5ABYV1Zp5P7n7cRtk867gjqtASmg+eb2kJ4OWAk1A8ECxGIsphPfoRAwuHj+BZGIjT/DoErI+eQ8MEUMF6Ob3YC5IN95M0NyOcR11liY5hj7HmCTZD/tIzsXtKkTwXsZXxKvfwRx0maRUWEkEdA1iNo78BN+CJU6jO9YiBz3RUGPKeKtiwV+g2SvtdyzD9tpTiJ2S0XnLVTEL1f/H57gX/betedYDkqsPt8AthAMPGIGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZsAMrvJ93w9I/afLGe+ZR321W6/MJyljIk94rjgMJA=;
 b=sOt3iVDe0djK3M3xyB7oJ/nlVKNSDQ2kk/PzWpsoavEZ1UdKiloB4dn1GSh/azFHuExTrDIajhPbGmEDqUWFb0N9wxkPui1tKPyVbYCTd2PppUv+XTwQuACDoGk6MnezQ+Kdg8ywZD1W2bvRpzjLjVMH99JVm4J+MSF3VuV2+WE=
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by CO1PR11MB5123.namprd11.prod.outlook.com (2603:10b6:303:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Fri, 1 Oct
 2021 22:07:23 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::194c:9213:9b06:8c7f]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::194c:9213:9b06:8c7f%7]) with mapi id 15.20.4544.025; Fri, 1 Oct 2021
 22:07:23 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "marcel@holtmann.org" <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC PATCH] Bluetooth: hci_sock: Set flag to all sockets
Thread-Topic: [RFC PATCH] Bluetooth: hci_sock: Set flag to all sockets
Thread-Index: AQHXtnjEQEJs7Rz2v02CAi8rkx0PFau9oaEAgAES2AA=
Date:   Fri, 1 Oct 2021 22:07:22 +0000
Message-ID: <11b22e65a1d36055c966527bc081f402221f6ec7.camel@intel.com>
References: <20211001035931.50485-1-hj.tedd.an@gmail.com>
         <E6D38153-42EC-4AE2-9292-9EFE7F61318B@holtmann.org>
In-Reply-To: <E6D38153-42EC-4AE2-9292-9EFE7F61318B@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-2.fc32) 
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7eac409-c9ff-4bb9-50d0-08d98527d875
x-ms-traffictypediagnostic: CO1PR11MB5123:
x-microsoft-antispam-prvs: <CO1PR11MB512306F7A25BDEC0FB75811AFFAB9@CO1PR11MB5123.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sY7ugtFs7yQs95oWVjzjptO3F0YS8XBi2g+yi4LephaepcTz1pp0b8Dt+aP2MGVnMi3TKKsQHSOcA7ls10h0v2CnaG1UVpIV27mgd1lDtfcSAldCKk5POEuWiyRGvrHjULGIeciBQLn2a/UfH3IqB9TxmFsPVNyONDKgXf6hnchLt1wSdXgjcesh7xVYb2qay1P3REEAjPR+/dDcBuyvQml5+hiYQZkxlsBKK9yioCNSXg1/mXUwKtMz2JdrLPgGheAZEvYxIXPkpEmeP497Vg8St/v7/DGfndd69jqhckJv/f/tV2ulNPf5RUSxcIpsmrcmlBMk+mx2iomDswtg6xI6jc+QfpHzDHsSTa2F5n6Ga1OUgPv5exO7IYtRffHxhejyO10g0fwV393Wk4JzfSJOuRi7CybAUiE+di7dIw7skDSMd0IWR/XEL7GFkGwFS8ywyPk++PiGR881ZzAxWXIFNIBXfD2eMgCGs7Wxhhoe9Itq6IU6Cy2Y41vOJ/eM3VIYBsRep8evE0YombShSm0MJxagXCzOUp4UhmmQOw9RhOnd9cbr2kDZCRnga4ab3HltyRtL2pbj7t6Q1HyIy6Vn4aFfPW2SdHhXSbGA51WV1Vd/Zff7lBhjxAvEJkFZ5d/T1iGoX+bsfaolHNmQNyCsgy9V5Bdk91is7EuFtZC92/zeaU54pkoNDDfIFQYeTg5JiN3JAnEGJJsvFG9Pdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(36756003)(316002)(8676002)(38100700002)(83380400001)(6512007)(4326008)(66946007)(64756008)(66556008)(66476007)(66446008)(186003)(122000001)(6486002)(76116006)(2616005)(6506007)(91956017)(38070700005)(6916009)(8936002)(2906002)(86362001)(508600001)(26005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWpxS3N6QzhNcjN0MXJvSkpYUU52YkN6dkZNYVBaRnpnTU1nYzdQVzR5WkV3?=
 =?utf-8?B?RkhiVmtyMnNyVTFoWGVEc2FlZWZTQUpzRTV4T2QwM1ZOQ2RZZGN6b0hqS2l1?=
 =?utf-8?B?Y2lDQ3lCVFducUxKTURnYkRRWkh2VWlKTXQxRlhNQ2dwSjZHblhVTGE5eHBK?=
 =?utf-8?B?elo2SjVYOEpTWFRsYVR0SGhieVlhUGRZMVRrMldhYm5OcW1tTzA5QTBKVXo3?=
 =?utf-8?B?ZStQYXJweTYxQ2hkaG5GZG9oOFdwQWhjVFM5ZGpIVWhWZHhDcmZ1dHRZTjkr?=
 =?utf-8?B?aUhucGNnamhTME9kTlFHZDZYeGNXbGpnN05hZForWitwUDcxYWJaQWJkY2lG?=
 =?utf-8?B?cUVpM2U1MjYxT3BVaytqb3RZUDhRcWtvSjVrOW5Sa3p5aUd0a3ZtWWJUMGdn?=
 =?utf-8?B?ZVVHUDE1S0ZHU1RrR2kzcGdHVFRyQjZ2OGdqKzZWcGJ4QjMyS2ZrYjNsMVha?=
 =?utf-8?B?c1RnNk9sTFU5VjZObmY3djcxWHNtL2tlOFBqQTBBZWNaVytPVU9xUzIrZ2lk?=
 =?utf-8?B?QXNmSktTU29iTWpJUnpLdlpXaWZ1U0dKMEZEcUNKcEIvM3dDdC91a0xYaDl6?=
 =?utf-8?B?VkZyL3JJQXdPL0tXaElidy83eDVTN2czak1IT2MxUjNXUHEvb0lVSkkrUnBa?=
 =?utf-8?B?Q1RFWXc4QjZTOE8yTHByQ2xwb2pjM21MdytWNjVwQ3FvbTNqN3ozRVMwN1ZI?=
 =?utf-8?B?S2xuMDF1SWpyemN1U0tmTGdMcCt0Y21SYkEwQjFNNjgzV1hFb1QyZmxVNTdr?=
 =?utf-8?B?TlRMcXQ2Y0ZIQ3loektoQ2hic21ZSTVrQ28rc2tUUVNCVVEyamx1d25BVkI5?=
 =?utf-8?B?WG56NUUxRXdCRnRpL1BNS1JVbmRhaEdOYWcyclIyMUZTaFNRZElhVDcrak15?=
 =?utf-8?B?Y29wdFhFdno0bkxNM1drWnVZaVJ5cU5kNTdnZERPMGNrZURBNDcyMGNrVnBV?=
 =?utf-8?B?NWpIQlRUbEl4OC9CNGdaZkl2WGQ2Unc3ZDNnRWEyWm1uY2UyTnhYTFlhVVFk?=
 =?utf-8?B?dEMwbHFpOUFVUDRLMjNtbzk0dWE2WHBuMVJUQWJ1NjJNNHZ4TEJSTWdlN1RS?=
 =?utf-8?B?RXUrUkpJUzBhbkloOEV6Q3dYVzJoNGl0ODRCNGxhbTczWUR0R29BeGJKOUZs?=
 =?utf-8?B?SmJsWVJiekNXcEtHcEpmVXhuUHI2VEU3NHNrK3R3OHZrK09EU2dRTlZNUGlS?=
 =?utf-8?B?WDFUREtQMHZCTVpyUzdPTVBWQzZyQU0vSElmcVc2RVNEdTF5SFM3TkNqQkdF?=
 =?utf-8?B?UWFHL21ySVV3ODVxc1gyblc4MTNSYTh4bTdiMXRIQU0xOTlSb28vSzNOMVY2?=
 =?utf-8?B?ZFNqM2dEVzVCdlppWnJsSlBCTkFwK0tlMVpKVEJET0l5clZ0UDJ1RUF6V0ZL?=
 =?utf-8?B?a0dYcHAybzVsV2FNVVdxcDdmbVFhclJtU0haTk9VWGxaOGFjU09vYmE0REhj?=
 =?utf-8?B?a0ZIeDNpWUFWOUxORlA3czM1T3cwaXZmRHlzMFp1dWYxbEdlR3Frdkc4MUYr?=
 =?utf-8?B?UitrTmx0NE5USk5hSDB2VnlIaWE5cStsbWF3aURsbTlwR2VLVzdxN3VEUTVl?=
 =?utf-8?B?TmtlOGdVT0tSS2tnTitCOE5oYS9BOTdkdEZDT29INHp4QmxLWnR5NFgzdXdm?=
 =?utf-8?B?WDZWSzZkNkZYcVJKd3JvWFd5blBvaUEvWlpvakhLc2pBNVAyM2IwN0pOK0Mz?=
 =?utf-8?B?WFhuekkyL2RJNTZJMFVuVkhHYW1wUVpFOFAzVWNtN1MwV0dXaS9qYURDRzI5?=
 =?utf-8?Q?TuLbObuFopKz8JOel5wEDj77OWFehdZA6w5qZXW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <89A1056407528C4AB92BB395A35940F7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7eac409-c9ff-4bb9-50d0-08d98527d875
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 22:07:23.0928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZF6g9Ny9GqEfoooex6A+29nyeMfWheBq/SYFGaPp90w3D7XzvOPyV3uZwC9HA+hkZhgMkr2RrmLWIE5bCUz4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5123
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsDQoNCk9uIEZyaSwgMjAyMS0xMC0wMSBhdCAwNzo0MyArMDIwMCwgTWFyY2VsIEhv
bHRtYW5uIHdyb3RlOg0KPiBIaSBUZWRkLA0KPiANCj4gPiBUaGUgbWdtdF9saW1pdGVkX2V2ZW50
KCkgc2VuZCB0aGUgZXZlbnQgdG8gdGhlIHNvY2tldCB0aGF0IG1hdGNoZXMgdGhlDQo+ID4gZmxh
ZyB0eXBlLCBidXQgYWxzbyBpdCBza2lwcyB0byB0aGUgZ2l2ZW4gc29ja2V0IG9iamVjdCBpbiB0
aGUNCj4gPiBwYXJhbWV0ZXIuDQo+ID4gDQo+ID4gRm9yIExvY2FsIE91dCBvZiBCYW5kIERhdGEg
VXBkYXRlZCBFdmVudCBhbmQgRXhwZXJpbWVudGFsIEZlYXR1cmUNCj4gPiBDaGFuZ2VkIEV2ZW50
LCBpdCBzZXRzIGZsYWdzIG9ubHkgZm9yIHRoZSBzb2NrZXQgd2hpY2ggdGhlIGNoYW5nZSB3YXMN
Cj4gPiB0cmlnZ2VyZWQsIHRoZSBldmVudCBjYW5ub3QgYmUgc2VudCB0byB0aGUgY2xpZW50IHZp
YSBhbnkgc29ja2V0cw0KPiA+IGJlY2F1c2UgdGhlIGZsYWcgaXMgbm90IHNldCBmb3Igb3RoZXIg
c29ja2V0cyBhbmQgaXQgZG9lbnMndCBzZW5kIHRvIHRoZQ0KPiA+IHNvY2tldCB3aGljaCB0aGUg
Y2hhbmdlIHdhcyB0cmlnZ2VyZWQuDQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBhZGRzIHRoZSBmdW5j
dGlvbiB0aGF0IHNldHMgdGhlIGZsYWcgZm9yIGFsbCBhdmFpbGFibGUNCj4gPiBtYW5hZ2VtZW50
IHNvY2tldHMsIHNvIHRoZSBtZ210X2xpbWl0ZWRfZXZlbnQoKSBzdGlsbCBjYW4gc2VuZCB0aGUg
ZXZlbnQNCj4gPiB0byB0aGUgbWFuYWdlbWVudCBzb2NrZXRzIG90aGVyIHRoYW4gdGhlIG9uZSB0
aHJvdWdoIHdoaWNoIHRoZSBjaGFuZ2UNCj4gPiB3YXMgdHJpZ2dlcmVkLg0KPiANCj4gYWN0dWFs
bHkgdGhhdCBpcyBvbiBwdXJwb3NlLiBPbmx5IHRoZSBzb2NrZXQgdGhhdCB1c2VkIGEgc3BlY2lm
aWMgbWdtdCBjb21tYW5kcyBnZXRzIHRvIHNlZSB0aGUNCj4gbmV3IGV2ZW50cy4gU28gaWYgeW91
IGhhdmUgYSBzZWNvbmQgbGlzdGVuaW5nIHNvY2tldCB0aGF0IGp1c3QgY2FyZXMgYWJvdXQgdGhl
IGV2ZW50cywgaXQgaGFzIHRvDQo+IGF0IGxlYXN0IGlzc3VlIHRoZSDigJxyZWFk4oCdIGNvbW1h
bmQgdG8gdGVsbCBtZ210IHRoYXQgaXQgZG9lcyB1bmRlcnN0YW5kIGl0LiBUaGVyZSBpcyBubyBw
b2ludCBpbg0KPiBzZW5kaW5nIG91dCBzaWduYWxzIHRvIGFsbCBtZ210IHNvY2tldHMgaWYgeW91
IGhhdmVu4oCZdCByZWFkIGFuIGluaXRpYWwgc3RhdHVzIGZpcnN0LiBUaGUgdXBkYXRlcw0KPiB3
b3VsZCBtYWtlIG5vIHNlbnNlIHRvIHlvdS4NCj4gDQpUaGFua3MgZm9yIHRoZSBkZXRhaWxzLiBB
bmQgdGhlIGNvZGUgbWFrZSBzZW5zZSBub3cuIE5lZWQgdG8gdXBkYXRlIG1nbXQtdGVzdGVyIHdp
dGggdGhlc2UgdGhlbi4NCg0KPiBSZWdhcmRzDQo+IA0KPiBNYXJjZWwNCj4gDQoNClJlZ2FyZHMs
DQoNClRlZGQNCg==
