Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A085C47082
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 20:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F096124B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 20:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbhFHU1J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 16:27:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:34418 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234243AbhFHU1I (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 16:27:08 -0400
IronPort-SDR: 9IdtNFjGsdrmEz9FsC6nc59Wh0BkBtq7ePhIHckwwqBOqJ2IqbTBa/+AQa9dJ/CDo2sLf/RqQV
 6klJN1q3Lxog==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="201910482"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="201910482"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 13:25:10 -0700
IronPort-SDR: godn6oNwrDrh8Z0pQpXYbuOkvAc8Mfkhr/j6HDLMoaC0jULB8zMsri9SqLFrPzMQCJSZbDpO9W
 sYdNTQy1Dw1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="419026009"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga002.jf.intel.com with ESMTP; 08 Jun 2021 13:25:10 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 13:25:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 8 Jun 2021 13:25:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 8 Jun 2021 13:25:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3EHWaEZRLKZeNGMibGhvZ6toFg5EPMVkTX8xl+ekOn2zKvzztMRedI48WsBvzHQh2Y+DGGsMCC8RdrXwUISm5CW325QgZjxkrgSPfoRDQe5bi/zL1v/QUkZaPv9TXV2gsYM2HR7dulYtn0UlE6fGuskWxExeKQweq2OVSWvRhink9bAxEIVgBtMLN978S2jkezYE3uXfeGMDRBO7/SmDX86t0+rJIfhpQE2UYq2FzeWUN2iRQTAT3x0OQBURw5tZ/rhhOsS42KnZyHsJv3s3KiMhFGN6PHsoh9AcPqzb4KSJKoAcsf4xurU84tKlcIkdCH+PEM4NLZVNfHcZUEClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtLIUgaXutIyhRXkVnOZ4SCsJ+hQaAcCVWsjpL/qWwg=;
 b=PS4nlZyYFZBxRGAj/iyF4ycsQCpvLUKD8VKIUwazF6oV9FfryjIbbWfh8ZFhfgSa3MK8IinHMeV03zTQWY+qEh+i5QI0syTTkxDQVjNMWuy1H2kq/5HDMv+aL0ByZGKTGGX+rIn/L/wee0SRK8eH5y43rZa7IPzZVPa9B150h5nGW3Q5mNvX/D3269zB1pq6dnKh2X4u0EHTHBH8mkULhTWZNjgLbEL0MsJyd4gYbZmtwWCN9y+q8OK2m+43osrvml6HaFURpnUSIW2dU7QMoPq5on7bd6Z2VDAEd5f+2xoVigAJg+CZmXHWBgDu8ac5QreSsjStPDTWNyUAWi3c5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtLIUgaXutIyhRXkVnOZ4SCsJ+hQaAcCVWsjpL/qWwg=;
 b=Mx4YuvK2JBDyXTZp8gOSwFHMw6i+s03lCUNiED3seY6Wo5CIDB0PRxqCmNqhHtQ5mrTfamH+y3BLrMbP8JJad3Ky+dw0fT+f3kiFVC8iiM5GBloxzc+cqXiVGgq7rudlmoVHOmUBJ6MyMxmPIQFAPxKBUoV+833bHOLnwdNMSgs=
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by MWHPR11MB0016.namprd11.prod.outlook.com (2603:10b6:301:63::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Tue, 8 Jun
 2021 20:25:07 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::f00d:44c5:4e9b:e4a5]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::f00d:44c5:4e9b:e4a5%9]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 20:25:07 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Bluetooth: HCI: Fix Set Extended (Scan Response) Data
Thread-Topic: Bluetooth: HCI: Fix Set Extended (Scan Response) Data
Thread-Index: AQHXXJ6dy0nT0l4cMUK07j+l4Je5BasKh7EAgAAHzgA=
Date:   Tue, 8 Jun 2021 20:25:07 +0000
Message-ID: <17f6995513da12fe72404ff19ac684477b92bbb3.camel@intel.com>
References: <20210608184457.3069064-1-luiz.dentz@gmail.com>
         <60bfc808.1c69fb81.1d1c6.838b@mx.google.com>
         <CABBYNZ+yuNRGU4m68GRGd0exodb-0hwkLaYQ8gCE+NPi4bq0Fw@mail.gmail.com>
In-Reply-To: <CABBYNZ+yuNRGU4m68GRGd0exodb-0hwkLaYQ8gCE+NPi4bq0Fw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-2.fc32) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56355db8-6d8e-49b8-5be3-08d92abb81b4
x-ms-traffictypediagnostic: MWHPR11MB0016:
x-microsoft-antispam-prvs: <MWHPR11MB0016074A5A9EEDE561EF3253FF379@MWHPR11MB0016.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FkXQyuEK3uQBNr2Gt4YDTnJFTf3I8301LGw6YFdVzYPEe9lS9xEkzAhHLLiQTvVDN7klH8O8OrLWhOYyoqNuJmNiPXNGYayWAtoLaxpHNnoJmLx3X3CfyU6csP/7GweJY/6PJYyuueUzZLCn0LiPCSt8K/SYY1fkasyyaUP2iC9Pxx1NXbgM/0WDkMR+zz3y8+faUaRZMd+o1ZIZEv43qyu/Cf64XVx3TxHYDjMdi4BCowxI6AgH311DpPkV6JsV+iZOnMRiPhCG/lc8/q16G/IJwByTKzTCUGlLzyv//tmqcggiTgOskxjzR5d1pOpDLZjgpbvkfqsgzk8R+UnCT3uMTfhMTRya8YA5HZ2w8BYM4zkkNGpHuwc6lu0FUdqWV2s4+ikLKuEuoJhzFQumqy1fzqtjDNnC2W3kbEjcVgVlWV4y1tU3h/jS2oMACN1Hbraz2p08YTdnxMTunN/a4FH19WqAUANNudN8ucFlt/WgTDbfP1SDoC8EA5WDBVMaD7VeZ2BMb9N+clXktz6OIk/OxDPmBFLuOrRNwHLcgkl1UEeCTPpSpI3RdU/Ky6ZVOkhXxYnb2XLt9eqlOL/uhk/kvE8HX+ehclxmtjkwUJnDYHVasQPWGhCFRc+BxOaguCtGwJ9T2RADbYw6pvtCcoPu/r+jebqXPT61O8AL4lU+t1hbjfpxFMm3EPyQdorJyxNCL1FnLQlS1Mzl1LEqvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(376002)(396003)(136003)(110136005)(83380400001)(8936002)(478600001)(71200400001)(8676002)(76116006)(5660300002)(66476007)(66446008)(64756008)(66556008)(66946007)(86362001)(2616005)(186003)(6506007)(36756003)(122000001)(6486002)(38100700002)(26005)(53546011)(6512007)(2906002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0tLbFNBaElWVkduSEpkTmJuSjJnT2Z5Ykg5T2ZYMUFRUUFCcThMWDVha2dF?=
 =?utf-8?B?OXN2YnI4MHBKQUczL1NOb1VRZ1dZOUROSWxCNnZmZXJ2YnYvZ2JDVlppUzBZ?=
 =?utf-8?B?NDduTmh6c0V4amcxdnlIaHI1aVhNV3FUVlR5UVluWHNKQ1VWU3dBSmFhL2ph?=
 =?utf-8?B?SFlHd2VhTUZkZ0RSOFA0M2V2bDNHcFhtUnZKYzRCVkxGZEtTSUp4QnBwNXk2?=
 =?utf-8?B?N2UxaTFGUEJTWWlqZVgrQlRNUUp4bG9qZUJ5UUdUU1pwNFh3MVllazIxQW9m?=
 =?utf-8?B?RHp6QVlsTGxrZW9RWHJsS0lzRHR0R0JQQlRQRjljYmVIT1ZKVUpOVGVqRjY2?=
 =?utf-8?B?VzVYeVlveXZ0Yko4TCtZQ25acGYwc1Zrb0VZMU10c2V3ekpYYWM3TnpJTnNK?=
 =?utf-8?B?TXFpQmdSNEx5VE0xSHI4cEpWMm1sU0xwZjhCNVF5SmdPM1ptb0sxTjNvNXpX?=
 =?utf-8?B?UVZ5L0gyUG5DMWltZEw2SVVNRGt5Q2I3TzJBTDZ5SXZBc3dRQnJVRDBpbVA5?=
 =?utf-8?B?aTJqUTJVUFkvbGtnbG54cHNBMlc1b3loMC8xMlFJTzdKR04xbmxNdytJbWs3?=
 =?utf-8?B?R0QwR1psbWdLUXF2T1JXNG1hWHRlWElwTml3eG5SN2dncU1YcnZORmNZcE1R?=
 =?utf-8?B?VCtlNXZVWlIrazRxSVpwa0VYQUpNOEFjcWdaNWRKZEpYM2ZGSDluOVVOQTBs?=
 =?utf-8?B?UG5vckRnNXFEOGtMTnAyalorWmJpRlV5NU1iZUhyajRQTnZCbnp6aWtaelNl?=
 =?utf-8?B?Z0lVQW9abmsyWGtXczdNY3AzdXlodG5qSlhBMG4rY0IwK3l0YTFEK0taRHh6?=
 =?utf-8?B?Um5GNkhqQmVMQ0hHSUg2bUJvUVMxRS8wQVorWmxTUmdSQks3cGlyVDI5OWRu?=
 =?utf-8?B?bTlSNlY3RytIem9lOExTNU9lNk9UaWI3YS9nNTJYTHhVSDc4N25jcDBaemUv?=
 =?utf-8?B?OWw5MG12MktUTG1KTi81QTdWaHh0Ui9zNHkrZXQ0ZmR1dGdsSE9vaStGZGxj?=
 =?utf-8?B?ZmZMRkNHVVh4ajFZaDRmalBnMUw0WG1Ld1g3cTREZC9SY21VVkdwWGhlYlVn?=
 =?utf-8?B?MUV2bW42dFN4SXNyN2dBbE8wVDVoMDllVXpMS0l5Sis0bnkwTVFmV1pjYlAy?=
 =?utf-8?B?QUN6eWJyakJLVTUwcGx1bEZmbWhHUHVsaW43UDVBMk9JRjdJM0E4aEhoaEs0?=
 =?utf-8?B?aThISzJ6Uml0WlkxazZKdTMxeTVZUzlsUG15ckZOcXBWZUFPVjlLR1pqT0Ro?=
 =?utf-8?B?a3ZYcDZCRHlxNmUzeXVYTWJzbzY5enI4SFU1ZEE3VmJqRnlGR2s5blM2RzVj?=
 =?utf-8?B?cTcwYUtxTTZiUlp1aFlZaGdtTCtFdHMzSTRYUlRRbHUyL0c0bGtqNlNwTzR5?=
 =?utf-8?B?eXNnMHRTQk96UjdFNTlYVmlBT3lPNnJKTVRrQ1UyN3JjSlJsd1lZcElmaWww?=
 =?utf-8?B?Tzd3a3R0U0kvTFRFVm9UWVE0VkhwSXVHU0N5WW10UndpUnBmRjNTSUI2YUtV?=
 =?utf-8?B?NGpBUkJ3SDUrWXNwS1NZbDQzRjBTMm5pclQ4b1p4SnRnL0NkYnZ3Q1hRWkc1?=
 =?utf-8?B?cVJlWWIxa203cDFxZmdwdVZLSVlUU2pQVGIxWU5oL2kxNDRzYUdOUHFONExk?=
 =?utf-8?B?MnZKZ2FSL1IzMTRreTBmdFdsUE8xM2FoQk9VQ0pPNloxTGtQcVphNlVrWC8z?=
 =?utf-8?B?TkxCVFUreTl6N3BWNlo3Tk9aR2NVZkZRNWx0WVZZejdNVU1zN2YyeUpGMXdj?=
 =?utf-8?Q?EnOpPdejHlVCDwFwUCJd5db35Lypl2GtwU5Bl8Q?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <885F788BF1AB3D4994DB9FF185B50453@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56355db8-6d8e-49b8-5be3-08d92abb81b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 20:25:07.1952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KLG79sp3NoHIkrH0/W/2gCKx+Do+zNguAcYfSnhR7EH//bILhEDXorUxnsspOOfmBhMl3sjDsCBbtDZSWTyWow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0016
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KT24gVHVlLCAyMDIxLTA2LTA4IGF0IDEyOjU3IC0wNzAwLCBMdWl6IEF1Z3Vz
dG8gdm9uIERlbnR6IHdyb3RlOg0KPiBIaSBUZWRkLA0KPiANCj4gT24gVHVlLCBKdW4gOCwgMjAy
MSBhdCAxMjo0MiBQTSA8Ymx1ZXoudGVzdC5ib3RAZ21haWwuY29tPiB3cm90ZToNCj4gPiBUaGlz
IGlzIGF1dG9tYXRlZCBlbWFpbCBhbmQgcGxlYXNlIGRvIG5vdCByZXBseSB0byB0aGlzIGVtYWls
IQ0KPiA+IA0KPiA+IERlYXIgc3VibWl0dGVyLA0KPiA+IA0KPiA+IFRoYW5rIHlvdSBmb3Igc3Vi
bWl0dGluZyB0aGUgcGF0Y2hlcyB0byB0aGUgbGludXggYmx1ZXRvb3RoIG1haWxpbmcgbGlzdC4N
Cj4gPiBUaGlzIGlzIGEgQ0kgdGVzdCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6DQo+
ID4gUFcgTGluazpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvYmx1ZXRvb3Ro
L2xpc3QvP3Nlcmllcz00OTY1MjUNCj4gPiANCj4gPiAtLS1UZXN0IHJlc3VsdC0tLQ0KPiA+IA0K
PiA+IFRlc3QgU3VtbWFyeToNCj4gPiBDaGVja1BhdGNoICAgICAgICAgICAgICAgICAgICBQQVNT
ICAgICAgMS4wMyBzZWNvbmRzDQo+ID4gR2l0TGludCAgICAgICAgICAgICAgICAgICAgICAgUEFT
UyAgICAgIDAuMTAgc2Vjb25kcw0KPiA+IEJ1aWxkS2VybmVsICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICA1MTIuOTQgc2Vjb25kcw0KPiA+IFRlc3RSdW5uZXI6IFNldHVwICAgICAgICAgICAg
IFBBU1MgICAgICAzMzYuMjkgc2Vjb25kcw0KPiA+IFRlc3RSdW5uZXI6IGwyY2FwLXRlc3RlciAg
ICAgIFBBU1MgICAgICAyLjU5IHNlY29uZHMNCj4gPiBUZXN0UnVubmVyOiBibmVwLXRlc3RlciAg
ICAgICBQQVNTICAgICAgMS44NyBzZWNvbmRzDQo+ID4gVGVzdFJ1bm5lcjogbWdtdC10ZXN0ZXIg
ICAgICAgRkFJTCAgICAgIDI5LjQ4IHNlY29uZHMNCj4gPiBUZXN0UnVubmVyOiByZmNvbW0tdGVz
dGVyICAgICBQQVNTICAgICAgMi4wMyBzZWNvbmRzDQo+ID4gVGVzdFJ1bm5lcjogc2NvLXRlc3Rl
ciAgICAgICAgUEFTUyAgICAgIDEuOTkgc2Vjb25kcw0KPiA+IFRlc3RSdW5uZXI6IHNtcC10ZXN0
ZXIgICAgICAgIFBBU1MgICAgICAyLjA2IHNlY29uZHMNCj4gPiBUZXN0UnVubmVyOiB1c2VyY2hh
bi10ZXN0ZXIgICBQQVNTICAgICAgMS44OCBzZWNvbmRzDQo+ID4gDQo+ID4gRGV0YWlscw0KPiA+
ICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0KPiA+IFRlc3Q6IENoZWNrUGF0Y2ggLSBQ
QVNTIC0gMS4wMyBzZWNvbmRzDQo+ID4gUnVuIGNoZWNrcGF0Y2gucGwgc2NyaXB0IHdpdGggcnVs
ZSBpbiAuY2hlY2twYXRjaC5jb25mDQo+ID4gDQo+ID4gDQo+ID4gIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjDQo+ID4gVGVzdDogR2l0TGludCAtIFBBU1MgLSAwLjEwIHNlY29uZHMNCj4g
PiBSdW4gZ2l0bGludCB3aXRoIHJ1bGUgaW4gLmdpdGxpbnQNCj4gPiANCj4gPiANCj4gPiAjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMNCj4gPiBUZXN0OiBCdWlsZEtlcm5lbCAtIFBBU1Mg
LSA1MTIuOTQgc2Vjb25kcw0KPiA+IEJ1aWxkIEtlcm5lbCB3aXRoIG1pbmltYWwgY29uZmlndXJh
dGlvbiBzdXBwb3J0cyBCbHVldG9vdGgNCj4gPiANCj4gPiANCj4gPiAjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMNCj4gPiBUZXN0OiBUZXN0UnVubmVyOiBTZXR1cCAtIFBBU1MgLSAzMzYu
Mjkgc2Vjb25kcw0KPiA+IFNldHVwIGVudmlyb25tZW50IGZvciBydW5uaW5nIFRlc3QgUnVubmVy
DQo+ID4gDQo+ID4gDQo+ID4gIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQo+ID4gVGVz
dDogVGVzdFJ1bm5lcjogbDJjYXAtdGVzdGVyIC0gUEFTUyAtIDIuNTkgc2Vjb25kcw0KPiA+IFJ1
biB0ZXN0LXJ1bm5lciB3aXRoIGwyY2FwLXRlc3Rlcg0KPiA+IFRvdGFsOiA0MCwgUGFzc2VkOiA0
MCAoMTAwLjAlKSwgRmFpbGVkOiAwLCBOb3QgUnVuOiAwDQo+ID4gDQo+ID4gIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjDQo+ID4gVGVzdDogVGVzdFJ1bm5lcjogYm5lcC10ZXN0ZXIgLSBQ
QVNTIC0gMS44NyBzZWNvbmRzDQo+ID4gUnVuIHRlc3QtcnVubmVyIHdpdGggYm5lcC10ZXN0ZXIN
Cj4gPiBUb3RhbDogMSwgUGFzc2VkOiAxICgxMDAuMCUpLCBGYWlsZWQ6IDAsIE5vdCBSdW46IDAN
Cj4gPiANCj4gPiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMNCj4gPiBUZXN0OiBUZXN0
UnVubmVyOiBtZ210LXRlc3RlciAtIEZBSUwgLSAyOS40OCBzZWNvbmRzDQo+ID4gUnVuIHRlc3Qt
cnVubmVyIHdpdGggbWdtdC10ZXN0ZXINCj4gPiBUb3RhbDogNDQ2LCBQYXNzZWQ6IDQxNSAoOTMu
MCUpLCBGYWlsZWQ6IDE4LCBOb3QgUnVuOiAxMw0KPiA+IA0KPiA+IEZhaWxlZCBUZXN0IENhc2Vz
DQo+ID4gQWRkIEV4dCBBZHZlcnRpc2luZyAtIFN1Y2Nlc3MgMSAoUG93ZXJlZCwgQWRkIEFkdiBJ
bnN0KSBGYWlsZWQgICAgICAgMC4wMTUgc2Vjb25kcw0KPiA+IEFkZCBFeHQgQWR2ZXJ0aXNpbmcg
LSBTdWNjZXNzIDIgKCFQb3dlcmVkLCBBZGQgQWR2IEluc3QpIEZhaWxlZCAgICAgICAwLjAyMSBz
ZWNvbmRzDQo+ID4gQWRkIEV4dCBBZHZlcnRpc2luZyAtIFN1Y2Nlc3MgNSAoU2V0IEFkdiBvZmYg
b3ZlcnJpZGUpIEZhaWxlZCAgICAgICAwLjAyNCBzZWNvbmRzDQo+ID4gQWRkIEV4dCBBZHZlcnRp
c2luZyAtIFN1Y2Nlc3MgNiAoU2NhbiBSc3AgRHRhLCBBZHYgb2spIEZhaWxlZCAgICAgICAwLjAx
OSBzZWNvbmRzDQo+ID4gQWRkIEV4dCBBZHZlcnRpc2luZyAtIFN1Y2Nlc3MgNyAoU2NhbiBSc3Ag
RHRhLCBTY2FuIG9rKSAgRmFpbGVkICAgICAgIDAuMDE2IHNlY29uZHMNCj4gPiBBZGQgRXh0IEFk
dmVydGlzaW5nIC0gU3VjY2VzcyA5IChHZW5lcmFsIERpc2NvdiBGbGFnKSBGYWlsZWQgICAgICAg
MC4wMjAgc2Vjb25kcw0KPiA+IEFkZCBFeHQgQWR2ZXJ0aXNpbmcgLSBTdWNjZXNzIDEwIChMaW1p
dGVkIERpc2NvdiBGbGFnKSBGYWlsZWQgICAgICAgMC4wMTcgc2Vjb25kcw0KPiA+IEFkZCBFeHQg
QWR2ZXJ0aXNpbmcgLSBTdWNjZXNzIDExIChNYW5hZ2VkIEZsYWdzKSAgICAgRmFpbGVkICAgICAg
IDAuMDIzIHNlY29uZHMNCj4gPiBBZGQgRXh0IEFkdmVydGlzaW5nIC0gU3VjY2VzcyAxMiAoVFgg
UG93ZXIgRmxhZykgICAgIEZhaWxlZCAgICAgICAwLjAxNyBzZWNvbmRzDQo+ID4gQWRkIEV4dCBB
ZHZlcnRpc2luZyAtIFN1Y2Nlc3MgMjAgKEFkZCBBZHYgb3ZlcnJpZGUpICBGYWlsZWQgICAgICAg
MC4wMTggc2Vjb25kcw0KPiA+IEFkZCBFeHQgQWR2ZXJ0aXNpbmcgLSBTdWNjZXNzIChOYW1lIGlz
IG51bGwpICAgICAgICAgRmFpbGVkICAgICAgIDAuMDE1IHNlY29uZHMNCj4gPiBBZGQgRXh0IEFk
dmVydGlzaW5nIC0gU3VjY2VzcyAoQ29tcGxldGUgbmFtZSkgICAgICAgIEZhaWxlZCAgICAgICAw
LjAyNCBzZWNvbmRzDQo+ID4gQWRkIEV4dCBBZHZlcnRpc2luZyAtIFN1Y2Nlc3MgKFNob3J0ZW5l
ZCBuYW1lKSAgICAgICBGYWlsZWQgICAgICAgMC4wMjQgc2Vjb25kcw0KPiA+IEFkZCBFeHQgQWR2
ZXJ0aXNpbmcgLSBTdWNjZXNzIChTaG9ydCBuYW1lKSAgICAgICAgICAgRmFpbGVkICAgICAgIDAu
MDE4IHNlY29uZHMNCj4gPiBBZGQgRXh0IEFkdmVydGlzaW5nIC0gU3VjY2VzcyAoTmFtZSArIGRh
dGEpICAgICAgICAgIEZhaWxlZCAgICAgICAwLjAyMyBzZWNvbmRzDQo+ID4gQWRkIEV4dCBBZHZl
cnRpc2luZyAtIFN1Y2Nlc3MgKE5hbWUrZGF0YSthcHBlYXIpICAgICBGYWlsZWQgICAgICAgMC4w
MjUgc2Vjb25kcw0KPiA+IEV4dCBBZHYgTUdNVCAtIEFEIERhdGEgKDUuMCkgU3VjY2VzcyAgICAg
ICAgICAgICAgICAgRmFpbGVkICAgICAgIDAuMDIyIHNlY29uZHMNCj4gPiBFeHQgQWR2IE1HTVQg
LSBBRCBTY2FuIFJlc3BvbnNlICg1LjApIFN1Y2Nlc3MgICAgICAgIEZhaWxlZCAgICAgICAwLjAy
MCBzZWNvbmRzDQo+IA0KPiBXZSB3aWxsIHByb2JhYmx5IG5lZWQgdG8gZml4IHRoZXNlIG9uY2Ug
dGhlIHBhdGNoIGlzIG1lcmdlZCwgaXQgbG9va3MNCj4gbGlrZSB0aGV5IGFyZSBhbHdheXMgZXhw
ZWN0aW5nIDMxIGJ5dGVzIG9mIGRhdGEgYnV0IHRoZSBleHRlbmRlZA0KPiB2ZXJzaW9uIHRoaXMg
aXMgdmFyaWFibGUgc2l6ZS4NCj4gDQoNCkkgd2lsbCBjaGVjayBpZiBJIGNhbiBmaXggaXQgZXZl
biBiZWZvcmUgbWVyZ2luZyB0aGlzIHBhdGNoLg0KDQo+ID4gIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjDQo+ID4gVGVzdDogVGVzdFJ1bm5lcjogcmZjb21tLXRlc3RlciAtIFBBU1MgLSAy
LjAzIHNlY29uZHMNCj4gPiBSdW4gdGVzdC1ydW5uZXIgd2l0aCByZmNvbW0tdGVzdGVyDQo+ID4g
VG90YWw6IDksIFBhc3NlZDogOSAoMTAwLjAlKSwgRmFpbGVkOiAwLCBOb3QgUnVuOiAwDQo+ID4g
DQo+ID4gIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQo+ID4gVGVzdDogVGVzdFJ1bm5l
cjogc2NvLXRlc3RlciAtIFBBU1MgLSAxLjk5IHNlY29uZHMNCj4gPiBSdW4gdGVzdC1ydW5uZXIg
d2l0aCBzY28tdGVzdGVyDQo+ID4gVG90YWw6IDgsIFBhc3NlZDogOCAoMTAwLjAlKSwgRmFpbGVk
OiAwLCBOb3QgUnVuOiAwDQo+ID4gDQo+ID4gIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
DQo+ID4gVGVzdDogVGVzdFJ1bm5lcjogc21wLXRlc3RlciAtIFBBU1MgLSAyLjA2IHNlY29uZHMN
Cj4gPiBSdW4gdGVzdC1ydW5uZXIgd2l0aCBzbXAtdGVzdGVyDQo+ID4gVG90YWw6IDgsIFBhc3Nl
ZDogOCAoMTAwLjAlKSwgRmFpbGVkOiAwLCBOb3QgUnVuOiAwDQo+ID4gDQo+ID4gIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjDQo+ID4gVGVzdDogVGVzdFJ1bm5lcjogdXNlcmNoYW4tdGVz
dGVyIC0gUEFTUyAtIDEuODggc2Vjb25kcw0KPiA+IFJ1biB0ZXN0LXJ1bm5lciB3aXRoIHVzZXJj
aGFuLXRlc3Rlcg0KPiA+IFRvdGFsOiAzLCBQYXNzZWQ6IDMgKDEwMC4wJSksIEZhaWxlZDogMCwg
Tm90IFJ1bjogMA0KPiA+IA0KPiA+IA0KPiA+IA0KPiA+IC0tLQ0KPiA+IFJlZ2FyZHMsDQo+ID4g
TGludXggQmx1ZXRvb3RoDQo+ID4gDQo+IA0KPiANCg0KUmVnYXJkcywNClRlZGQNCg==
