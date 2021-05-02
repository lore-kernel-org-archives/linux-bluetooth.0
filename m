Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F87C433ED
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 May 2021 09:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8890C613AC
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 May 2021 09:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhEBJIy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 May 2021 05:08:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:37365 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229754AbhEBJIx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 May 2021 05:08:53 -0400
IronPort-SDR: e/+euH6B4CeoYW6vMIYS+dM/fJBq1E64ypC3Ic9kz7LACgOixUNRcPLWtiW2qGDqeRlX69u4H0
 Mx7t31B2CV1A==
X-IronPort-AV: E=McAfee;i="6200,9189,9971"; a="177748633"
X-IronPort-AV: E=Sophos;i="5.82,267,1613462400"; 
   d="scan'208";a="177748633"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2021 02:08:02 -0700
IronPort-SDR: Rvd2WfDthUiG0elR1k0QiE6hiGPi4uaTPtmsc+pOU6u33QlwqRjaMT4m1LE8Pnlpwpuq2ZACNg
 C/hc4txgE68Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,267,1613462400"; 
   d="scan'208";a="467552872"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 02 May 2021 02:08:01 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 2 May 2021 02:08:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sun, 2 May 2021 02:08:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Sun, 2 May 2021 02:08:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMt/jqOX/o5pI5t9FbJgwjFLtsVWD1aWeXt3+jcG0GlfHmvXF5Z8aS5Au9HNZ2XzdeAWRG1+yKF+OqFsqUYcqeHtQJCvIo5wcCAnE1lkk6+axTLOYBOJbN5pmMrxnm+bJvCHTshjtDPOooGT17Kd+mRGZLD2UYwhs9crGtuzR4J9IbHa/+b1yufEt3x0LzAQBGUFxBfW4wl1gz+ZnC4OGZ5QsoHzaH9wZKr9P1FmkF65vXyehrxZVVoc/uHZEu56bO77fdZFMyirbOVA9+gB9Ds+jWrPETITV7tXQNzXsPtLmdl0341p1wTTV/iig162fq8+Veoz8l6HREAGYjC6bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jrg8wj7Ho61mm302Eg9jKU2CLuWNySGs+eq40MC//oE=;
 b=N1gocmtORKP/VSO7pVoLW3hst22770NTq+o7KHIyMBHnP65hGiaMTcbAOAYDdTnHvOTBy+3uvjJGG78L5agaD3BPINtndFXlNObIjLL9aD4OCs3rjFZzYkM6ZCJYHsaoexz/L3Vgsy+lDy4K81xKjgwz9gqnMhnjdkOsMm7VJbw1n4EnpqiRnaaqmpdC4Iq1MEKs1iGw9Db+VJtkAVRDovgc16EMAr55sDhSildzKcQvT8CNtDExnMbSt2NC4YVDSMzKs0yTfdgti8WKPFwCHHwRwJ91joG2IptNNG9uJQGhKsMmXgSTP5Oh7otFkE49JHyHmdtyYoa1nYMymwipkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jrg8wj7Ho61mm302Eg9jKU2CLuWNySGs+eq40MC//oE=;
 b=hiUo2wyO6RcL4LcjTq0I6IifydVQsQ2o8/DwSkVm4ci+9vf+Wv3azu+FX2z8qod0EN24w/ZwT1kkPYeVa/6sL0zHnPywDy2L1hS5flDWdJMzkaZ0hgDwNv82T/laheTnVwHBdA+O7JfMiZdDSbYxg7t1YX9N6RZqhh6dOXXZAD4=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5640.namprd11.prod.outlook.com (2603:10b6:8:3f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.39; Sun, 2 May 2021 09:07:59 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7%5]) with mapi id 15.20.4087.041; Sun, 2 May 2021
 09:07:58 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Subject: RE: [PATCH v4 1/2] Bluetooth: enumerate local supported codec and
 cache details
Thread-Topic: [PATCH v4 1/2] Bluetooth: enumerate local supported codec and
 cache details
Thread-Index: AQHXPDZ1mKglm+kXdk215OSB/ByAv6rKfgOAgAVt2/A=
Date:   Sun, 2 May 2021 09:07:58 +0000
Message-ID: <DM8PR11MB557345248281A7D9ED937884F55C9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210428140132.30316-1-kiran.k@intel.com>
 <CABBYNZK044znKcW9boBmZoGiHkkjRq-7ZqifisZ13_EZ9hg-=g@mail.gmail.com>
In-Reply-To: <CABBYNZK044znKcW9boBmZoGiHkkjRq-7ZqifisZ13_EZ9hg-=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [49.37.168.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a40b1b65-3701-4c9f-6c7d-08d90d49c808
x-ms-traffictypediagnostic: DM8PR11MB5640:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB564048A3AABD5A08E1E17320F55C9@DM8PR11MB5640.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jxm0F5wobUcW0poEpqRCcOsJmOPyLfWYcCcnthKH2yiDVuA5hdjRIvcB+cL6x25iX58XOeRCKaSoCjv6hizVL9UNZP7YkMlcmFMXuIP9ToMNXZjm3YbFxeRk5LyV+/o5YkHk4P9ewEHErne3j5WxScQhXaQjdU1bg/SUgUoTNkBNByyn61cuFHd77RJqyxEGo+j5QMe4jZHEvcK3ZdPWXpuwTZ1fnTDkuj4vwavQRqj5l4zMXmxpa8j2g0irkMPDgCWt97DImbng1xKaRhD0+B19OWKGzP24AZZkq73MCWfiy4tPeDdkwq6KReWfGKMpy8SPIp8oKAhiy7wBHVr72RLYjJfHBC2njSyHDbaQsuXiOlxhZfrrZImVCdFawLTu6bbYO/eFL2zoVrMVKWGXKmDD2GbNrINVI7D/2XHkyt1FAqxon4BA91fbHqCcXvheDpADh9L9qTUrMR8ifLRNAQNEw8ZTL4uy+QEPuntKEOdLTqEhgl50AasjkG1rSuQ59BIvK9l4wwOzWNLbVnAShneBDB8+FPsO1DwMmJ+qYHY+nkW3kjfX24CQ9pFO3z5P/p80jwCVzzBgqRil8MJcPpMpPWi3ehuye+sXFQsNk5nPxSXL/lI7daLaqLsITeJZneIfsLA9qVnkYUWXsjETLjQGEjLn46ko7A4TVxO90TYhNQaPkj1HpRl/Pckkr7a2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(8936002)(26005)(2906002)(478600001)(107886003)(6506007)(33656002)(66476007)(66556008)(38100700002)(966005)(8676002)(5660300002)(186003)(66446008)(52536014)(76116006)(9686003)(55016002)(71200400001)(83380400001)(7696005)(54906003)(4326008)(86362001)(316002)(64756008)(6916009)(122000001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?d091dUxyZC9YdWxydFlqSkJQTFBrZGxrdVJNdWU2OGlraEJQcVlENWt0WnFs?=
 =?utf-8?B?eHN1MHFDMDJ3VVNoaHYxeUNqV3dpWExmeTA2VVg1WTV5c2cycXFieCt6R2Vs?=
 =?utf-8?B?cDZmTHYvRjR0Y2l1SE1jU2ZIQXgwOW02OXg3Zy9Lb1JLci8xUzdTYzhvNzNz?=
 =?utf-8?B?OFZTTmpGN0N1UndCeUk0VllodGM1U21kOVNjTHB0allJUHZIaW42THMwa3E3?=
 =?utf-8?B?K2wxWjdVaG5aaWJMbzdUY3hkbWR4eXZhWks1b1BMNjdnRldpbUZkUVRCL2FP?=
 =?utf-8?B?OFRBVzBIYUhkUFlnRThzQVFWYnpHKzVUdnZMc05Rb3BTNUJSSXlFNlJ4WGcw?=
 =?utf-8?B?NWF2clJRS1dpRzROYVJKNUlGeXh4SCtYRnNTVERTMitVRHB4NjlHR2VGMGJq?=
 =?utf-8?B?QlJrVGYrK1oxN250a2NGUklTaEFiVUZJc3RobjZUT0IrVmN4RkJyQnZPS3My?=
 =?utf-8?B?OE4yN0dEellRVHM2QVNmTDlmTE84eGJUTmZoUVJ0NGk4SnM0RlRtR0VkVWd4?=
 =?utf-8?B?dm5SeFUrVEVzOWJqeVNGUmdCejZXSlEyS3JDK3kvN0x1STdOT3U5V3RyL3lO?=
 =?utf-8?B?Z01OMytjQlp4KzNzWVd2aUhXNjUwa2Z3TitYb2JUN2VGdkpVMzJqNVh3YWpt?=
 =?utf-8?B?eTFtNWFkaWF0OE1tcEZkWlN3WUs1MEhub04ybXFJQzR0a016OGphRFRxNWo2?=
 =?utf-8?B?V0d4OUFmMWVGcTc1UGV5Y0hYb1REcUlrMW5EcWtrWUVpQVZJS3BqeXplbTdL?=
 =?utf-8?B?a0tqR0Q5MmxaRk1idmcwTGtpcGZpOFhxcnlDTGc0bDlQVER6MnFTWXpnL05w?=
 =?utf-8?B?Qk42UW1VdDdVMU5GTHVVbTdVWEVpRHh4Vi9sQzI4UDhyVi83ZW9nUVVETE1X?=
 =?utf-8?B?SWx2bFZVR3dpUDhOZEpjSWo2NnBXRVBTa1hzeUZKeGtYQWhGQmhPS2hwQ1Ba?=
 =?utf-8?B?bitjeUlYV1A2YkFxWm1zL3dEdVJuWldpb0UzcU5wckdSYm5XUTZPS2FzaDIw?=
 =?utf-8?B?RytSUUN6UmpseXpUOG94eGo3VHhQYjFWTDZLdzZoQmFOUGdGVVZINExoa1lJ?=
 =?utf-8?B?d1VPZlkxNCtQWDN1ZWFyOG1wRS9SbkxWUkJjemRqbnJPMXlnY2xBNEZFWWp6?=
 =?utf-8?B?RWxMSTZtMWdwOVdGT29KblYwZW9Gajh5WVJiRXpNVHR1ZmNFZzF5TXk0RmVP?=
 =?utf-8?B?R0E0U2ZoUVc5dm10Q3ZnUnduenh1aTlVVzU0S1daY0VVanZxVkRHc05OUU1Y?=
 =?utf-8?B?WkliNEJEbFlVSnZQcnZ3bFE2bmhra3RNTE1STXRoQ2hrZmgxTkRBeERGQXV5?=
 =?utf-8?B?eFRIUWxvSWVQR2lCV3NsVGpWcjhoNkdxSlVVUTJGL2dOcTZRSGQxZFRvODBB?=
 =?utf-8?B?YTRhOUc2QXRPSkRMMVNRWmlYWnB2N3o5OVlRanMyZ21ONWRCRFB6MHlocG5M?=
 =?utf-8?B?NmIxMDdUVmd4UDJFRGxwY3lFMEYzQ214WHowMXhBTGsxVEc5djZMeDJYQUpa?=
 =?utf-8?B?ZmRRTERpazdSeUJ3N0c5anJ1Z0FoVzhabnVBTVNpa0ZucHdLbFc2WnQ2MVov?=
 =?utf-8?B?VTBCZ3d3M3o2MHI5cnpTZGpXSG9jRDd0SFJCUkx3Tk5XMVhmbEhGT3o0WHpm?=
 =?utf-8?B?bEx0amYvZUQxZnVXUTI1QktsUVpibnNCK2ppdXdXTG5WeXBOZkhMdGJmSGZL?=
 =?utf-8?B?UFJMWi94d2Z6WUgrUzlwc2J1ZG92SnBjbFE2WEN5cHo3UzVGakswVy92eFk2?=
 =?utf-8?Q?9z3xzkJFSLtYmysFiyS53O31eHJz467gv8hb+7t?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40b1b65-3701-4c9f-6c7d-08d90d49c808
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2021 09:07:58.6915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7l4Rcw8sWEHYFea81YbU+UoQ9r/fTOWL/GjLp1YdEbcBnHzNiqi2NWzwxD2VgEB3ktSfxizvKhOEiyysnmTkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5640
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMuIEkgd2lsbCBtYWtlIHRoZSBzdWdn
ZXN0ZWQgY2hhbmdlcyBpbiBuZXh0IHBhdGNoIHNldCAtIHY1Lg0KDQo+ID4gK3N0YXRpYyB2b2lk
IGhjaV9yZWFkX3N1cHBvcnRlZF9jb2RlY3Moc3RydWN0IGhjaV9kZXYgKmhkZXYpIHsNCj4gPiAr
ICAgICAgIHN0cnVjdCBza19idWZmICpza2I7DQo+ID4gKyAgICAgICBfX3U4IG51bV9jb2RlY3M7
DQo+ID4gKw0KPiA+ICsgICAgICAgc2tiID0gX19oY2lfY21kX3N5bmMoaGRldiwgSENJX09QX1JF
QURfTE9DQUxfQ09ERUNTLCAwLCBOVUxMLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgSENJX0NNRF9USU1FT1VUKTsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAoSVNfRVJSKHNrYikp
IHsNCj4gPiArICAgICAgICAgICAgICAgYnRfZGV2X2VycihoZGV2LCAiRmFpbGVkIHRvIHJlYWQg
bG9jYWwgc3VwcG9ydGVkIGNvZGVjcyAoJWxkKSIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgUFRSX0VSUihza2IpKTsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsg
ICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIGlmIChza2ItPmxlbiA8IDEgfHwgc2tiLT5kYXRh
WzBdKQ0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIGVycm9yOw0KPiA+ICsNCj4gPiArICAgICAg
IHNrYl9wdWxsKHNrYiwgMSk7DQo+IA0KPiBXZSBiZXR0ZXIgdXNlIGEgc2tiX3B1bGwgd2l0aCBh
IHNpemVvZiBvZiB0aGUgc3RydWN0IHdlIGV4cGVjdCwgaGVyZSB5b3UgYXJlDQo+IHByb2JhYmx5
IHJlYWRpbmcgdGhlIHN0YXR1cyBidXQgZm9yIHNvbWVvbmUgZWxzZSBtaWdodCBub3QgdW5kZXJz
dGFuZCB3aGF0DQo+IHlvdSBkb2luZyBoZXJlLg0KPiANCg0KQWNrDQoNCj4gPiArDQo+ID4gKyAg
ICAgICBpZiAoc2tiLT5sZW4gPCAxKQ0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIGVycm9yOw0K
PiA+ICsNCj4gPiArICAgICAgIC8qIGVudW1lcmF0ZSBzdGFuZGFyZCBjb2RlY3MgKi8NCj4gPiAr
ICAgICAgIG51bV9jb2RlY3MgPSBza2ItPmRhdGFbMF07DQo+ID4gKw0KPiA+ICsgICAgICAgc2ti
X3B1bGwoc2tiLCAxKTsNCj4gDQo+IERpdHRvLCB1c2Ugc2tiX3B1bGwoc2JrLCBzaXplb2YobnVt
X2NvZGVjcykpLg0KPiANCj4gPiArDQo+ID4gKyAgICAgICBpZiAobnVtX2NvZGVjcyAmJiBza2It
PmxlbiAgPCBudW1fY29kZWNzKQ0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIGVycm9yOw0KPiAN
Cj4gVGhlIGNoZWNrIGFib3ZlIG1pZ2h0IGJlIGVhc2llciBpZiB3ZSB1c2UgZmxleF9hcnJheV9z
aXplIHNvIHdlIHBlcmZvcm0gdGhlDQo+IGNoZWNrIGZvciB0aGUgZW50aXJlIGFycmF5LCBhbmQg
dGhlbiBvbiB0aGUgd2hpbGUgbG9vcCB5b3UganVzdCBhY2Nlc3MgZWFjaA0KPiBlbGVtZW50IGJ5
IGluZGV4IGxpa2UgSW0gZG9pbmcgaW4gdGhlIHBhdGNoIGJlbGxvdzoNCj4gDQo+IGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9ibHVldG9vdGgvcGF0Y2gvMjAyMTA0MTkxNzEy
NTcuMzg2DQo+IDUxODEtMTEtbHVpei5kZW50ekBnbWFpbC5jb20vDQoNCkFjaw0KDQo+IA0KPiA+
ICsgICAgICAgd2hpbGUgKG51bV9jb2RlY3MtLSkgew0KPiA+ICsgICAgICAgICAgICAgICBoY2lf
cmVhZF9jb2RlY19jYXBhYmlsaXRpZXMoaGRldiwgc2tiLT5kYXRhLA0KPiBMT0NBTF9DT0RFQ19B
Q0wsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmYWxz
ZSk7DQo+ID4gKyAgICAgICAgICAgICAgIHNrYl9wdWxsKHNrYiwgMSk7DQo+ID4gKyAgICAgICB9
DQo+IA0KPiBTYW1lIHRoaW5nIGhlcmUuDQo+IA0KPiA+ICsgICAgICAgLyogZW51bWVyYXRlIHZl
bmRvciBzcGVjaWZpYyBjb2RlY3MgKi8NCj4gPiArICAgICAgIGlmIChza2ItPmxlbiA8IDEpDQo+
ID4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyb3I7DQo+ID4gKw0KPiA+ICsgICAgICAgbnVtX2Nv
ZGVjcyA9IHNrYi0+ZGF0YVswXTsNCj4gPiArDQo+ID4gKyAgICAgICBza2JfcHVsbChza2IsIDEp
Ow0KPiA+ICsNCj4gPiArICAgICAgIGlmIChudW1fY29kZWNzICYmIHNrYi0+bGVuIDwgKG51bV9j
b2RlY3MgKiA0KSkNCj4gPiArICAgICAgICAgICAgICAgZ290byBlcnJvcjsNCj4gPiArDQo+ID4g
KyAgICAgICB3aGlsZSAobnVtX2NvZGVjcy0tKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGhjaV9y
ZWFkX2NvZGVjX2NhcGFiaWxpdGllcyhoZGV2LCBza2ItPmRhdGEsDQo+IExPQ0FMX0NPREVDX0FD
TCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRydWUp
Ow0KPiA+ICsgICAgICAgICAgICAgICBza2JfcHVsbChza2IsIDQpOw0KPiA+ICsgICAgICAgfQ0K
PiANCj4gQnR3LCB0aGUgY29kZSBmb3IgcmVhZGluZyB2ZW5kb3IgYW5kIHN0YW5kYXJkIHNlZW1z
IGV4YWN0bHkgdGhlIHNhbWUgc28NCj4gcGVyaGFwcyBpdCBpcyB3b3J0aCBtb3ZpbmcgdGhlc2Ug
bGluZXMgYWJvdmUgdW5kZXIgYW5vdGhlciBmdW5jdGlvbiBlLmcuDQo+IGhjaV9jb2RlY19saXN0
X3BhcnNlIHdoaWNoIGNhbiB0aGVuIHRha2UgYSBib29sZWFuIHNheWluZyBpcyB2ZW5kb3Igb3Ig
bm90DQo+IGFuZCBmcm9tIHRoZXJlIGNhbGwgaGNpX3JlYWRfY29kZWNfY2FwYWJpbGl0aWVzLg0K
PiANCg0KQWNrDQoNCj4gPiArZXJyb3I6DQo+ID4gKyAgICAgICBrZnJlZV9za2Ioc2tiKTsNCj4g
PiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgaGNpX2luaXQ1X3JlcShzdHJ1Y3QgaGNpX2Rl
diAqaGRldikgew0KPiA+ICsgICAgICAgLyogUmVhZCBsb2NhbCBjb2RlYyBsaXN0IGlmIHRoZSBI
Q0kgY29tbWFuZCBpcyBzdXBwb3J0ZWQgKi8NCj4gPiArICAgICAgIGlmIChoZGV2LT5jb21tYW5k
c1syOV0gJiAweDIwKQ0KPiA+ICsgICAgICAgICAgICAgICBoY2lfcmVhZF9zdXBwb3J0ZWRfY29k
ZWNzKGhkZXYpOyB9DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IF9faGNpX2luaXQoc3RydWN0IGhj
aV9kZXYgKmhkZXYpICB7DQo+ID4gICAgICAgICBpbnQgZXJyOw0KPiA+IEBAIC05MzcsNiArMTA0
MCw4IEBAIHN0YXRpYyBpbnQgX19oY2lfaW5pdChzdHJ1Y3QgaGNpX2RldiAqaGRldikNCj4gPiAg
ICAgICAgIGlmIChlcnIgPCAwKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+
DQo+ID4gKyAgICAgICBoY2lfaW5pdDVfcmVxKGhkZXYpOw0KPiA+ICsNCj4gPiAgICAgICAgIC8q
IFRoaXMgZnVuY3Rpb24gaXMgb25seSBjYWxsZWQgd2hlbiB0aGUgY29udHJvbGxlciBpcyBhY3R1
YWxseSBpbg0KPiA+ICAgICAgICAgICogY29uZmlndXJlZCBzdGF0ZS4gV2hlbiB0aGUgY29udHJv
bGxlciBpcyBtYXJrZWQgYXMgdW5jb25maWd1cmVkLA0KPiA+ICAgICAgICAgICogdGhpcyBpbml0
aWFsaXphdGlvbiBwcm9jZWR1cmUgaXMgbm90IHJ1bi4NCj4gPiBAQCAtMzU1OSw2ICszNjY0LDM1
IEBAIHZvaWQgaGNpX2Nvbm5fcGFyYW1zX2NsZWFyX2Rpc2FibGVkKHN0cnVjdA0KPiBoY2lfZGV2
ICpoZGV2KQ0KPiA+ICAgICAgICAgQlRfREJHKCJBbGwgTEUgZGlzYWJsZWQgY29ubmVjdGlvbiBw
YXJhbWV0ZXJzIHdlcmUgcmVtb3ZlZCIpOw0KPiA+IH0NCj4gPg0KPiA+ICtpbnQgaGNpX2NvZGVj
X2xpc3RfYWRkKHN0cnVjdCBsaXN0X2hlYWQgKmxpc3QsIHN0cnVjdA0KPiBoY2lfcnBfcmVhZF9s
b2NhbF9jb2RlY19jYXBzICpycCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgIF9fdTMyIGxl
biwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBoY2lfb3BfcmVhZF9sb2NhbF9j
b2RlY19jYXBzICpzZW50KSB7DQo+ID4gKyAgICAgICBzdHJ1Y3QgY29kZWNfbGlzdCAqZW50cnk7
DQo+ID4gKw0KPiA+ICsgICAgICAgZW50cnkgPSBremFsbG9jKHNpemVvZigqZW50cnkpICsgbGVu
LCBHRlBfS0VSTkVMKTsNCj4gPiArICAgICAgIGlmICghZW50cnkpDQo+ID4gKyAgICAgICAgICAg
ICAgIHJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArICAgICAgIG1lbWNweShlbnRyeS0+Y29k
ZWNfaWQsIHNlbnQtPmNvZGVjX2lkLCA1KTsNCj4gPiArICAgICAgIGVudHJ5LT50cmFuc3BvcnQg
PSBzZW50LT50cmFuc3BvcnQ7DQo+ID4gKyAgICAgICBlbnRyeS0+bnVtX2NhcHMgPSBycC0+bnVt
X2NhcHM7DQo+ID4gKyAgICAgICBpZiAocnAtPm51bV9jYXBzKQ0KPiA+ICsgICAgICAgICAgICAg
ICBtZW1jcHkoZW50cnktPmNhcHMsIHJwLT5jYXBzLCBsZW4pOw0KPiA+ICsgICAgICAgbGlzdF9h
ZGQoJmVudHJ5LT5saXN0LCBsaXN0KTsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gMDsNCj4g
PiArfQ0KPiA+ICsNCj4gPiArdm9pZCBoY2lfY29kZWNfbGlzdF9jbGVhcihzdHJ1Y3QgbGlzdF9o
ZWFkICpjb2RlY19saXN0KSB7DQo+ID4gKyAgICAgICBzdHJ1Y3QgY29kZWNfbGlzdCAqYywgKm47
DQo+ID4gKw0KPiA+ICsgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGMsIG4sIGNvZGVj
X2xpc3QsIGxpc3QpIHsNCj4gPiArICAgICAgICAgICAgICAgbGlzdF9kZWwoJmMtPmxpc3QpOw0K
PiA+ICsgICAgICAgICAgICAgICBrZnJlZShjKTsNCj4gPiArICAgICAgIH0NCj4gPiArfQ0KPiA+
ICAvKiBUaGlzIGZ1bmN0aW9uIHJlcXVpcmVzIHRoZSBjYWxsZXIgaG9sZHMgaGRldi0+bG9jayAq
LyAgc3RhdGljIHZvaWQNCj4gPiBoY2lfY29ubl9wYXJhbXNfY2xlYXJfYWxsKHN0cnVjdCBoY2lf
ZGV2ICpoZGV2KSAgeyBAQCAtMzgxOCw2ICszOTUyLDcNCj4gPiBAQCBzdHJ1Y3QgaGNpX2RldiAq
aGNpX2FsbG9jX2Rldih2b2lkKQ0KPiA+ICAgICAgICAgSU5JVF9MSVNUX0hFQUQoJmhkZXYtPmNv
bm5faGFzaC5saXN0KTsNCj4gPiAgICAgICAgIElOSVRfTElTVF9IRUFEKCZoZGV2LT5hZHZfaW5z
dGFuY2VzKTsNCj4gPiAgICAgICAgIElOSVRfTElTVF9IRUFEKCZoZGV2LT5ibG9ja2VkX2tleXMp
Ow0KPiA+ICsgICAgICAgSU5JVF9MSVNUX0hFQUQoJmhkZXYtPmxvY2FsX2NvZGVjcyk7DQo+ID4N
Cj4gPiAgICAgICAgIElOSVRfV09SSygmaGRldi0+cnhfd29yaywgaGNpX3J4X3dvcmspOw0KPiA+
ICAgICAgICAgSU5JVF9XT1JLKCZoZGV2LT5jbWRfd29yaywgaGNpX2NtZF93b3JrKTsgQEAgLTQw
MzYsNiArNDE3MSw3DQo+ID4gQEAgdm9pZCBoY2lfdW5yZWdpc3Rlcl9kZXYoc3RydWN0IGhjaV9k
ZXYgKmhkZXYpDQo+ID4gICAgICAgICBoY2lfY29ubl9wYXJhbXNfY2xlYXJfYWxsKGhkZXYpOw0K
PiA+ICAgICAgICAgaGNpX2Rpc2NvdmVyeV9maWx0ZXJfY2xlYXIoaGRldik7DQo+ID4gICAgICAg
ICBoY2lfYmxvY2tlZF9rZXlzX2NsZWFyKGhkZXYpOw0KPiA+ICsgICAgICAgaGNpX2NvZGVjX2xp
c3RfY2xlYXIoJmhkZXYtPmxvY2FsX2NvZGVjcyk7DQo+ID4gICAgICAgICBoY2lfZGV2X3VubG9j
ayhoZGV2KTsNCj4gPg0KPiA+ICAgICAgICAgaGNpX2Rldl9wdXQoaGRldik7DQo+ID4gLS0NCj4g
PiAyLjE3LjENCj4gPg0KPiANCj4gDQo+IC0tDQo+IEx1aXogQXVndXN0byB2b24gRGVudHoNCg0K
VGhhbmtzLA0KS2lyYW4NCg0K
