Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A655C432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 12:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A49C60F92
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 12:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhHaM6P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 08:58:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:29922 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhHaM6O (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 08:58:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="240717861"
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="240717861"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 05:57:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="600944227"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga001.fm.intel.com with ESMTP; 31 Aug 2021 05:57:19 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 31 Aug 2021 05:57:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 31 Aug 2021 05:57:18 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 31 Aug 2021 05:57:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXibJgGDh/CesbV9kDS7yGUtlPYILqZupSrNbelk/hHv8lBJq2yOoOXVOB4E+U6sw1eL3ok1/G5kv3AFFDS3/CKC0DN/FiaNwkGjJcwBRKsUAZsElHRbdILecHH+cThWJjYO99LkLq1mCUBBoX2SVJmqUhxRjMKbV4Y5bQG+RKuexpYrvL8vmkZt86yXmIymUbb9utJEeuVgzSpdub43LH5GZMsu5m57QkC1hPgDHmzV2ypnT5CCtSeJsphW0WXsTrP0ssRr/uWw8p9zmOt0OchM0nihOCVv31TbQsjfWCHnyAw4OgrwEf2pso0XXSMU6CwSPumfB2rYN7RbjS4iLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfbK1m8/GIvfhuKd502HU5PLcZv9XJvobQUGpeOCD+U=;
 b=dSZNESRWwapVwJr+AuSoCywb+q8uioF5ccAAW3TdqUQubX2iKV2pQLduw4IIQxZQUv8RiaNN8caNMD9LDW/jB1KHY2+hI+1gQHJoJCS+QgAvvCiwCzRdIhN9JUttP9qNYh7bJu88u0YANBevJwi/NusHTheIm5VXWGBUKlCz4Apl8oSn4c52KUY93vSNhrr34US/Eh2YNnYgdH8XT+Usv50I7EhZwdRpnfsnEPjbEugpqPI/FjXHssUBErrH4BbshcupQj9chnBr484oJjtl/EL22yPz1vU3F7uvHi0es39jaD8sKtxjfyFfzARZqECAsm4c7611oHqtEp7xouxz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfbK1m8/GIvfhuKd502HU5PLcZv9XJvobQUGpeOCD+U=;
 b=ESMKtcgxi3zZ/nsK3JnBaF4uJKVfeifoCOcwAwRuyjBLG2kXF5Ui8x+wB0gtVaPOexC6DToGrp00nMYOU0BFCOrKuATMPhZuG8q6OU2fFMPHz90M8e/KZvi5pyqpJojpyjnMzME5EdBO2ovfYRM6kSi6Fu+w2/oCimtMG71vdNk=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM4PR11MB5567.namprd11.prod.outlook.com (2603:10b6:5:39a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.24; Tue, 31 Aug 2021 12:57:13 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::d092:c900:44f8:e225]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::d092:c900:44f8:e225%5]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 12:57:13 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "An, Tedd" <tedd.an@intel.com>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel: Fix boot address
Thread-Topic: [PATCH v1] Bluetooth: btintel: Fix boot address
Thread-Index: AQHXlboObKKzb/mnYEuZAbUQn9QnkauMNiqAgAFtS+A=
Date:   Tue, 31 Aug 2021 12:57:13 +0000
Message-ID: <DM8PR11MB5573FB6D0E9726DD82C43A7CF5CC9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210820115808.15895-1-kiran.k@intel.com>
 <7E8C3893-19CD-44D6-B224-A3434F65BA95@holtmann.org>
In-Reply-To: <7E8C3893-19CD-44D6-B224-A3434F65BA95@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: deb8bafa-57a5-435e-30b7-08d96c7eda76
x-ms-traffictypediagnostic: DM4PR11MB5567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR11MB5567C95B49C81429108BEBB5F5CC9@DM4PR11MB5567.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:580;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vzkBdMBrLr6GIeBjGiEvVbEHcpyGPBIv0XYjqVFzNXr/HSssu4oeKgpWOq/AIBYE8Xt1OfNc07++65QnmAIxGn6YnYcCM3LHX17xWo+ePcn51iPu3hE2V9WzQ8ob06HPVmNVxUutymdE5oS8PDtBF0KSX6/lYdEDcSIp8i0FQDDLztQCMAn2gRdbFAXBWFcgPiyTUjfKEgMaZJV0Dw2BTLlbTA8sgGMmGO0m5Za8oZ9hqHvG+WZjV+YzjSXFpi1/nZFlu5OTqWTiZW34sLy4wwMrxKaP1AJPdjM9oQRuQ+KSQxpa49zkMvZSZP9nCLtPAmH2nYBM2lqKTj6dtsm7rSnNUNw/4cZ/Gd6N7JQHdkxj03PGxrg2cqHMf3Ww8dLNwDWhRxsGXuFv1x1m/GACzA0laXY0YHNnezZ5Xg9YA3xCvsCn8ffnqNIF8NNasSXtFSS1PuJlivvvDCMAnTR7uqd69akv5XEjCzohLTRp4i1gs/XeD+Y0oAhI9rps3XR5Zf44a5DSX+CPSuL3khXtDkH6O64QXdSudy8wCUsWipkCULWjgWg71tDuR3LAto7UedriAtqrr60jCG5UWXgv/KfNP/pc8HWfhy90BWupkga+CCYYyPC1tTVAcn/iZKO8sbpxaq6z3VLwc/M+r8DcznFiiDzF0Rx7gqyEKCO5Kg0Nz1vs4QJmyEPoP4t4Fsc6GTTJieSQTamd4rqKq0DH+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(4326008)(64756008)(6916009)(2906002)(66446008)(66476007)(6506007)(53546011)(478600001)(38100700002)(66946007)(55016002)(316002)(122000001)(7696005)(71200400001)(76116006)(66556008)(54906003)(52536014)(38070700005)(33656002)(8936002)(86362001)(8676002)(83380400001)(5660300002)(9686003)(107886003)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekErLzlmcUlMSUt4RDd4Ry9ScGFpY2E1SjluenRiY2piMVpqWmY3QkF6MzB2?=
 =?utf-8?B?UWptNDZ5cmpYQ0hrdENzNjI5UEpKODdlQVlXL1Fsa0lvdFlHN2k2YXhVYWFM?=
 =?utf-8?B?MTZ2VlIraXZFWi9ncC9CRWg3aDJrTVhLdUY1MWtqNmdlRm1hUGMwMmxpUjRW?=
 =?utf-8?B?bWZtQTQwNWZQS1pndXNmakptSTd3QmVncWJvZFdQT2J1UFFvb0FBbEg2L3NP?=
 =?utf-8?B?QWdJMlV0Zmt0UHZYTy92VWdNV2xrMzFXTzJLQzZwS25lZDh6U2gzaEhJeGht?=
 =?utf-8?B?YjBBUEM0ZTNvdC9OWGRUS0ZBOUhhOXZlQUM0M2NLaWhEOXVtVEx1bkowSUJy?=
 =?utf-8?B?eG9zZmZJOEl0c201QUFFbmhiRnIya2hsMVcwQ3pGTEtaTy9nRGlKQUkxeG1W?=
 =?utf-8?B?cTZnRXJGWEc3ZjVoOXRMdnc3K0dtOXRvUjFKVW9TYXhQcnlwdEpiQ241Wlhm?=
 =?utf-8?B?dEgzQ0YwRW1ZbEVTczZNUHlGMEhCUjZ6di9CTzZWanJVM2ZkV2srN2VDMzJV?=
 =?utf-8?B?ejdiS1B4ekZrT2R3NUF4VGQ5UG4raW5TNC9HcjlGa0xTRUhZUHFPZjhoQW1i?=
 =?utf-8?B?eG82UUt4Wi9aVEMxNFpkM09BcEFRQ0VGK2NLelN5aWd2Zi9meGNtQVRaL05r?=
 =?utf-8?B?dmNLclJ1UnMrR1hrK01GOHlGV0Q3dHQ3UUhkbTQzcTdJeG1EOWJDRWJnd21C?=
 =?utf-8?B?ZlRWS0Q5K1ArV2NZdmVTbjhuVmJMT1pEM0FBa1JKQy82dXA0L3pIQk5qdWZa?=
 =?utf-8?B?Wjk2YWVZL1dUS2wvTjJyeE9jU2RhdFArL0NvR1o5TTVFcXloVTJvVGlWTjdJ?=
 =?utf-8?B?TGo4MWxDS05PVUhHNldlY0c1T1c0U2VMYWtlL3hrbUFGb2xTT1NnTWZjNmhU?=
 =?utf-8?B?N0xLaFBjRGpqR1Q2VmNJWGFrN2FqVFVOOU15S1UzZnFjdkJPcjJ6cHg3NjE0?=
 =?utf-8?B?Y1piYUQyV2tOczdBWTEzZVJ6QjgyV0xGNFpMUDM3SHZOMGtJNGQ3Nmk2RXRu?=
 =?utf-8?B?clJuZ3ozbjV1MGRUTWdFMDZRUVRENkt2WkIxOVhuOERySVMvZ29wWU4vMExh?=
 =?utf-8?B?YlErVkx4ZEtERFppeDRHa0RqVjRoZktnSzVDK0F1WU5jRmxQSE11RnNrdVZI?=
 =?utf-8?B?VkJXWUdVR3BWWjFJbEI3cUkrV2RtVGg0bWU4RVJabkFnOGsxVWgzL2lOWkdP?=
 =?utf-8?B?Y2hIeDh5ejBhMm5WVUZJWXVUQWV2MzAxazJSNmdSeEFLQmNBaktwczFnWm43?=
 =?utf-8?B?TEw1NFlYOEJYM0ljR0dkRndtWHc5MEhoTi9LK3gxZ09QSjBVUE9haTNSTDhP?=
 =?utf-8?B?RnZjSmN5MUNBVTkvWDZ3S3ZFMWtNSGVWVElFMkJxdGZwZkhaK0lCa0d6MkZZ?=
 =?utf-8?B?YzA1SXF1dC95dHVUYTBtK2liajM4b0pJTWNwa0ZmL0xLUGhINnRuM2VXbmZK?=
 =?utf-8?B?Nmh5a1pMU1BLUmdCNEt5N05FRlMvWWlBMWlvcEQrVWU5N01RMXd3QUg3Z3Ni?=
 =?utf-8?B?L2FzVWpOQXVGK0w5MElJSjdGTkZ6bmw2TFlKVDQrSVNCN0NWTnZzYjk0TWJm?=
 =?utf-8?B?SjIyMjViVWFIS2U2SDEwZU8zbXlhNUxxc21yZTNkamVYaDNSd2ZzanB0MmdU?=
 =?utf-8?B?MEdNZ3FBb1pMcEl5N1ZwUHg5NGV6eFF6TUtiRHg5SFNRbk9UWXllSVhQbXVF?=
 =?utf-8?B?VWR1dEdXdktPdFdjN2hWL2g3aHhjbVlyUVdFSFVoY2ZmQlVFOXJKR01MOFJo?=
 =?utf-8?Q?P3ZcSExvlPrmqfxXbA+OW1WZMGlMAnURQET/Ea3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb8bafa-57a5-435e-30b7-08d96c7eda76
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 12:57:13.4502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axu94xB/UFCUN5Tz37UjHkGioMl1q+29wG5WvxJ0ryBAeIe7lhuPALEnMpIfnj25wkAcHOCGz4/A4d/vzpxunw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5567
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SEkgTWFyY2VsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmNl
bCBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5uLm9yZz4NCj4gU2VudDogTW9uZGF5LCBBdWd1c3Qg
MzAsIDIwMjEgODozOCBQTQ0KPiBUbzogSywgS2lyYW4gPGtpcmFuLmtAaW50ZWwuY29tPg0KPiBD
Yzogb3BlbiBsaXN0OkJMVUVUT09USCBTVUJTWVNURU0gPGxpbnV4LWJsdWV0b290aEB2Z2VyLmtl
cm5lbC5vcmc+Ow0KPiBTcml2YXRzYSwgUmF2aXNoYW5rYXIgPHJhdmlzaGFua2FyLnNyaXZhdHNh
QGludGVsLmNvbT47IFR1bWt1ciBOYXJheWFuLA0KPiBDaGV0aGFuIDxjaGV0aGFuLnR1bWt1ci5u
YXJheWFuQGludGVsLmNvbT47IEFuLCBUZWRkDQo+IDx0ZWRkLmFuQGludGVsLmNvbT47IFZvbiBE
ZW50eiwgTHVpeiA8bHVpei52b24uZGVudHpAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYxXSBCbHVldG9vdGg6IGJ0aW50ZWw6IEZpeCBib290IGFkZHJlc3MNCj4gDQo+IEhpIEtp
cmFuLA0KPiANCj4gPiBDYWNoZSBCb290IGFkZHJlc3MgcHJlc2VudCBpbiBmaXJtd2FyZSBmaWxl
IHdoaWNoIGlzIGxhdGVyIHVzZWQNCj4gPiBJbnRlbF9Tb2Z0X1Jlc2V0IGNvbW1hbmQgdG8gYnJp
bmcgY29udHJvbGxlciBmcm9tIGJvb3QgbW9kZSB0bw0KPiA+IG9wZXJhdGlvbmFsIG1vZGUuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLaXJhbiBLIDxraXJhbi5rQGludGVsLmNvbT4NCj4gPiAt
LS0NCj4gPiBkcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMgfCAzMSArKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ID4gMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDE4
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0
aW50ZWwuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPiA+IGluZGV4IGYxNzA1YjQ2
ZmM4OC4uODBkNmRkN2FlNTFhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0
aW50ZWwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPiA+IEBAIC0x
MDM3LDggKzEwMzcsOSBAQCBzdGF0aWMgYm9vbCBidGludGVsX2Zpcm13YXJlX3ZlcnNpb24oc3Ry
dWN0DQo+ID4gaGNpX2RldiAqaGRldiwNCj4gPg0KPiA+IAkJCXBhcmFtcyA9ICh2b2lkICopKGZ3
X3B0ciArIHNpemVvZigqY21kKSk7DQo+ID4NCj4gPiAtCQkJYnRfZGV2X2luZm8oaGRldiwgIkJv
b3QgQWRkcmVzczogMHgleCIsDQo+ID4gLQkJCQkgICAgbGUzMl90b19jcHUocGFyYW1zLT5ib290
X2FkZHIpKTsNCj4gPiArCQkJKmJvb3RfYWRkciA9IGxlMzJfdG9fY3B1KHBhcmFtcy0+Ym9vdF9h
ZGRyKTsNCj4gPiArDQo+ID4gKwkJCWJ0X2Rldl9pbmZvKGhkZXYsICJCb290IEFkZHJlc3M6IDB4
JXgiLA0KPiAqYm9vdF9hZGRyKTsNCj4gPg0KPiANCj4gc28gdGhpcyBodW5rIGxvb2tzIGdvb2Qg
YW5kIGlzIGRlc2NyaWJlZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+IA0KPiA+IAkJCWJ0X2Rl
dl9pbmZvKGhkZXYsICJGaXJtd2FyZSBWZXJzaW9uOiAldS0ldS4ldSIsDQo+ID4gCQkJCSAgICBw
YXJhbXMtPmZ3X2J1aWxkX251bSwgcGFyYW1zLQ0KPiA+ZndfYnVpbGRfd3csIEBAIC0xMDcxLDkg
KzEwNzIsNg0KPiA+IEBAIGludCBidGludGVsX2Rvd25sb2FkX2Zpcm13YXJlKHN0cnVjdCBoY2lf
ZGV2ICpoZGV2LA0KPiA+IAkJLyogU2tpcCB2ZXJzaW9uIGNoZWNraW5nICovDQo+ID4gCQlicmVh
azsNCj4gPiAJZGVmYXVsdDoNCj4gPiAtCQkvKiBTa2lwIHJlYWRpbmcgZmlybXdhcmUgZmlsZSB2
ZXJzaW9uIGluIGJvb3Rsb2FkZXIgbW9kZSAqLw0KPiA+IC0JCWlmICh2ZXItPmZ3X3ZhcmlhbnQg
PT0gMHgwNikNCj4gPiAtCQkJYnJlYWs7DQo+ID4NCj4gPiAJCS8qIFNraXAgZG93bmxvYWQgaWYg
ZmlybXdhcmUgaGFzIHRoZSBzYW1lIHZlcnNpb24gKi8NCj4gPiAJCWlmIChidGludGVsX2Zpcm13
YXJlX3ZlcnNpb24oaGRldiwgdmVyLT5md19idWlsZF9udW0sIEBADQo+IC0xMTE0LDE5DQo+ID4g
KzExMTIsMTYgQEAgc3RhdGljIGludCBidGludGVsX2Rvd25sb2FkX2Z3X3RsdihzdHJ1Y3QgaGNp
X2RldiAqaGRldiwNCj4gPiAJaW50IGVycjsNCj4gPiAJdTMyIGNzc19oZWFkZXJfdmVyOw0KPiA+
DQo+ID4gLQkvKiBTa2lwIHJlYWRpbmcgZmlybXdhcmUgZmlsZSB2ZXJzaW9uIGluIGJvb3Rsb2Fk
ZXIgbW9kZSAqLw0KPiA+IC0JaWYgKHZlci0+aW1nX3R5cGUgIT0gMHgwMSkgew0KPiA+IC0JCS8q
IFNraXAgZG93bmxvYWQgaWYgZmlybXdhcmUgaGFzIHRoZSBzYW1lIHZlcnNpb24gKi8NCj4gPiAt
CQlpZiAoYnRpbnRlbF9maXJtd2FyZV92ZXJzaW9uKGhkZXYsIHZlci0+bWluX2Z3X2J1aWxkX25u
LA0KPiA+IC0JCQkJCSAgICAgdmVyLT5taW5fZndfYnVpbGRfY3csDQo+ID4gLQkJCQkJICAgICB2
ZXItPm1pbl9md19idWlsZF95eSwNCj4gPiAtCQkJCQkgICAgIGZ3LCBib290X3BhcmFtKSkgew0K
PiA+IC0JCQlidF9kZXZfaW5mbyhoZGV2LCAiRmlybXdhcmUgYWxyZWFkeSBsb2FkZWQiKTsNCj4g
PiAtCQkJLyogUmV0dXJuIC1FQUxSRUFEWSB0byBpbmRpY2F0ZSB0aGF0IGZpcm13YXJlIGhhcw0K
PiA+IC0JCQkgKiBhbHJlYWR5IGJlZW4gbG9hZGVkLg0KPiA+IC0JCQkgKi8NCj4gPiAtCQkJcmV0
dXJuIC1FQUxSRUFEWTsNCj4gPiAtCQl9DQo+ID4gKwkvKiBTa2lwIGRvd25sb2FkIGlmIGZpcm13
YXJlIGhhcyB0aGUgc2FtZSB2ZXJzaW9uICovDQo+ID4gKwlpZiAoYnRpbnRlbF9maXJtd2FyZV92
ZXJzaW9uKGhkZXYsIHZlci0+bWluX2Z3X2J1aWxkX25uLA0KPiA+ICsJCQkJICAgICB2ZXItPm1p
bl9md19idWlsZF9jdywNCj4gPiArCQkJCSAgICAgdmVyLT5taW5fZndfYnVpbGRfeXksDQo+ID4g
KwkJCQkgICAgIGZ3LCBib290X3BhcmFtKSkgew0KPiA+ICsJCWJ0X2Rldl9pbmZvKGhkZXYsICJG
aXJtd2FyZSBhbHJlYWR5IGxvYWRlZCIpOw0KPiA+ICsJCS8qIFJldHVybiAtRUFMUkVBRFkgdG8g
aW5kaWNhdGUgdGhhdCBmaXJtd2FyZSBoYXMNCj4gPiArCQkgKiBhbHJlYWR5IGJlZW4gbG9hZGVk
Lg0KPiA+ICsJCSAqLw0KPiA+ICsJCXJldHVybiAtRUFMUkVBRFk7DQo+ID4gCX0NCj4gDQo+IFRo
aXMgcGFydCBob3dldmVyIGlzbuKAmXQuDQoNCkFjay4gSSBoYXZlIHNlcGFyYXRlZCB0aGUgcGF0
Y2hlcyB3aXRoIHByb3BlciBjb21taXQgbWVzc2FnZSBhbmQgc2VudCBhbiB1cGRhdGVkIHZlcnNp
b24uDQo+IA0KPiBSZWdhcmRzDQo+IA0KPiBNYXJjZWwNCg0KVGhhbmtzLA0KS2lyYW4NCg0K
