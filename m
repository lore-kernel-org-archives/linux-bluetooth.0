Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B667CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 05:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9154B6108D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 05:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbhHRF5e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 01:57:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:15621 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237618AbhHRF5c (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 01:57:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="215987441"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="215987441"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 22:56:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="449544362"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 17 Aug 2021 22:56:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 17 Aug 2021 22:56:57 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 17 Aug 2021 22:56:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 17 Aug 2021 22:56:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 17 Aug 2021 22:56:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIkHe2rn5Elx/wulXAJC631oLL4Z+piOgbZh3T/z6xfmBjheZmLa9uIfOroPEiHa/UWdOtJ9dPjyB2fO8IY6LiEZ9xVbpwm4LdFR+7sipMfmNWIH+65bwjp0WOOd+hESJkVmNKhSF1fM+BIvwqopcNVUyN492/B81rbNECmDoHsM3FMURu105SVCkBmvnhOsnOcEIVkurlClcXh3eR1Mz7sKQG54mFfiGx8YnsaLBsoIWsmL2wxJHfdXHPUBHZhFgyReG3Neu8ragjn8lTZ9oryPJoSm5AqGZeOcL7TekPs6HUYtvAbjQhCOiUzAFvq5su9DgpmLjJQZC2aDczx2oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+56q8UFvzAqWoARILWyn3xeNGcTER7oRAehDs6aedg=;
 b=JW7hRWyBWvIvoc/1C9PxtBvnqD+ax/1jaVcs/qeEc3SeZmEht9NW5HGWhViZUEW2qBA/4llOWjQy39xzaz8ZPntXzp+l1tuucfUzJN+MVONqQXk/ANYmZj5GSBqDwy0bDwMWustGOL/ABiKIlDGVuwVH+zGZ2gbpOEgNz/rxCVQh4xr/e+jcIpp7n+IsUhgUhMhxzRfMGHlZSA5m0dFsRlrj0wFTzFsGK2aWrSsnYkuwwJMZHHy377NXrtxYtXSccW+gGR1D+zH8VM8JJELjLZS7bGTOiCa6kdrphpAW5lMmaxSUGDD0AiaBQR6jsGmkp8UuRDsNAQ0Dvh15X67UsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+56q8UFvzAqWoARILWyn3xeNGcTER7oRAehDs6aedg=;
 b=qRuXXYCf/gu6gOox4d8Qih9qmkqe6yptkqMRAlRcTCf1DWsrVVUBAlQbpJusfYKgCzv67U0JNp9bUdlZcq0hSg9gsP0jfENZaxPmucBsll0PGvDQ3UYgFCwb/I5pZPrFnGdS+ldYs0XHZ6JAbdop9a48URHPvqY7zh1eQKCvSHc=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5671.namprd11.prod.outlook.com (2603:10b6:8:3c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.18; Wed, 18 Aug 2021 05:56:55 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::c134:db0a:48b:a88c]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::c134:db0a:48b:a88c%3]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 05:56:55 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Subject: RE: [PATCH v2] mgmt: Set offload codec mgmt feature
Thread-Topic: [PATCH v2] mgmt: Set offload codec mgmt feature
Thread-Index: AQHXkxSxof8TRW+whkyA6BhSftB2C6t4XqwAgABmp5A=
Date:   Wed, 18 Aug 2021 05:56:55 +0000
Message-ID: <DM8PR11MB55732881FE0AEB2F55FA55AAF5FF9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210817030930.9211-1-kiran.k@intel.com>
 <CABBYNZL_C+NLxGw5GKDGfkhqpYn+OdNQHD4+z+htVQyayJKseA@mail.gmail.com>
In-Reply-To: <CABBYNZL_C+NLxGw5GKDGfkhqpYn+OdNQHD4+z+htVQyayJKseA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79a2d766-0ddb-4aab-d428-08d9620cfc01
x-ms-traffictypediagnostic: DM8PR11MB5671:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5671F795B216F4461A390DD1F5FF9@DM8PR11MB5671.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:234;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VZPnO7pipVtI+5tpAzZ4Qib4Fw+FPuozRL3MW1eFYcHCO17X9QhodJK99+X3wJuRBMzrnuuLXJzlgBmCEjCPqo1RgUmXIK8Tj5CHIA3kBrhfSUHoarum1vOEZ6EKQ9p14NDjdBI9ukZLnpwVOMhjZtF553eUbo0UKzHzqbPse6aPn+XDWhYUW82WE33x7q9D1pUyBlWJTF2YbcBOHVgu8UYL4CKjNu3DR0K8BjOITruAli/xMPOqJYJ0wcDCJg5O4skv+DmpUwp1v3hRiOfGwwp3VvBSWHyK3zXSB5ySI55q7hIn/3vXTyeDkygZpAucVUBSpPPLASxRo6B5YT2LOCIRUJzs04+pOAIvSmf7ZQT07hFHAeMD0sFMrb4LYdmXJnUF3D/jD7lGEifuB3At4u+baWAW7kTB2psS+uMxx8JAEjTXcYBkpvi+k2lDeGf8NIJYzsFf4Zt7S561WuQLh3Gh0WGCf+/ajM9JL1DUzlCWPl/IF4rkzzE3xoj8+k73WXd9cIj2tinpuvb2vGuY2kLCLeQ0oRA2Redt/oyjYZ+nzIvvaHSxSDFrusUzFFQ2QZvqbaX4QoU5QHPa7p7k9p3CEe5Q5HQ5np7BE2RLuKwCCXJJCh2R8AF/fevldXsshqYgUg5ha5dS2bpB19NLkd+jufxz9v1A+v/+PzxrXDWUN4nKnEbXsJ9XgeQ5ETzIhO/Gp3ohxT3mwL2q+IwzCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(66556008)(6916009)(107886003)(5660300002)(478600001)(4326008)(66476007)(55016002)(9686003)(71200400001)(64756008)(66946007)(7696005)(54906003)(53546011)(6506007)(66446008)(33656002)(52536014)(186003)(76116006)(8936002)(83380400001)(316002)(8676002)(122000001)(38070700005)(86362001)(38100700002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVBzSy9IL1lhTkttK2FEdkpEVHNrNGhHMzJsb3hDdVVueEpLTENLVm1mNTlj?=
 =?utf-8?B?VFU1YVdIRkZZOGI0QWRqb3BBZTMrdGpud1JTdENFSXp3QkRJS3cyRUNJQ2dQ?=
 =?utf-8?B?YzNmSTgrWkpvRk10amc2RjBPaUZ1dFd0ajlnc0ZzNTFzM3ZkcFI1ZHhwN05T?=
 =?utf-8?B?WUJGTHFWcHZOck9SOWZIR2N1aWIvcmRFaFZsL013cHBrZkttZ3RTcUg3WEpS?=
 =?utf-8?B?amtwbFJMQjFKMmptS3Q3L1NBZmYyRlJvZGdMSy93M1hMQmd6bC9ScmlXbmR6?=
 =?utf-8?B?UGx3OGRYSFFWVXJqZTRrOHpMNmZ0dE1jcnFxdFg2QnRZaVNXY20vTk5pcTRK?=
 =?utf-8?B?UHdzQW1zNkMxb2NjTHNYbldqSUtCOTBNUEMra2R5MzgzSFd4R2RzSk1KRkNJ?=
 =?utf-8?B?YVlqQXpzUi9EcEZzVkh2MGtIV1ZLaXRyMGJsNUtmUTkvOU5iT0pRWTV4M0RW?=
 =?utf-8?B?SXozajdxT0p0eGxzVnlyOGhUUFhURERFSGhrNmk5UUJqcjJiS0dIL1o0R3ZE?=
 =?utf-8?B?OHVJSDc1T1FGaVNjdTJDL1hvMFFLdjBOSGNVUlY4cDFjcVhBRkJTUWlvMmpG?=
 =?utf-8?B?cTd3bFNBajJvSjhseTh4ZGpPZnlUQm93ZjRiY0srZ1YvckNXRFpXb2RpcG5i?=
 =?utf-8?B?SjlMZ1h0enJxa3JCTVo0d1kxTzhJMVczRTc0czZuYWJmaGRmVVRiUjEyYmJD?=
 =?utf-8?B?MG83TGVRQUtkaXVIZGtBdDFDNTdheWc3Vm53R2ZmMGpVVHVmWnZnWERsSjVZ?=
 =?utf-8?B?cHIrZGlsMFF5bHNqaFVDSkpsRm50ZDZzRkhzeHlMeEF2ZmJMREhSVWwvU3pv?=
 =?utf-8?B?TnA5YW5sbGIxZ3BCdmliKy9YMFNTMllwcVFrUjVZRlEwUHRaRldxVzRucnc3?=
 =?utf-8?B?QzlXMWpEU2RXdVhpY09rVW9tOTUvK1B1TmFDY2dsNHFIY2V0SEdZb0ZkZElZ?=
 =?utf-8?B?TzI5Q0VXenZKM3pHTFREYys0STZ4dHBHd2djVmpScW0rZ3ljeEp3bmYzQWJk?=
 =?utf-8?B?RldnOW0ya1BPcFBxNVZLejJwWnJhVVZxUzd3SmJ6S3ZOSEdabmFWUjlmVXpj?=
 =?utf-8?B?cFN6NmNwRUovWTdIakRoZEloNWFhTS8yR1IzZjJmZnNCRFVjVGFMR1RncUg1?=
 =?utf-8?B?U09EWnlWa3VVMG9RTnpLRkxCd01vRjBpU2tBemkydnp3K2RWSjJSY29DWC9S?=
 =?utf-8?B?OVB6MnBtd1BLd1ZJQUtRUHYrNmVONmdmT1YzaThtK1hzMkZ4SU5iVG01SG5P?=
 =?utf-8?B?NWpod2RIWlVIYzNBNjZuenlJMjY4bGFEcUc0L2Jpa1RLWUVqMHlsYmF5bGZL?=
 =?utf-8?B?RE9tTXE3Y2w0OEVBSjl5YWQxNGJ2c3JrS2FNdjYrc05aZWNKSVJNSEllTVU3?=
 =?utf-8?B?QW1DTWJTanlGN1pnZElYOW0zdXY5Tmh4T2ZWTTMvMFp0TjR6c2ZBdkt3a0hN?=
 =?utf-8?B?d053ZXVkeEJjNitsTVNqYlF1amdiR1FaMiszRzNRNTBpZ2UzRUpKWmNEcUxP?=
 =?utf-8?B?UUQxR2VGcHEyM2xXVE1ld2RDcW51WnVlK2xXaW1xaG9teFNHYjFOV0FjY0Fy?=
 =?utf-8?B?aFM5NEc5enNJWWIrUkRiUC9veHl6SDV5RHFqdG1qMUExajA2NC9ybVFrM0lY?=
 =?utf-8?B?QWkxR2ttY3VwSWxRcjF6RHBPMk4vVEw0REZKb0xrZWtEWHlhWmd3a24reXlQ?=
 =?utf-8?B?MlM0R1V0NnVTb2RTSVFKeTdJU2hKNXZWeTVjVlNSa08wdU9RUE5OMVpNekdO?=
 =?utf-8?B?QjVsZnUzRlp5YjNzMTZWZTI4M0xkUDA2ZnM2NlZQaFRpaVRsZHJvU2N3SmUv?=
 =?utf-8?B?QkcwKzhyYThNWGtIOUNnN3piTWFLNXd4cEtpRXNVeVQyMFVKSmdTdEMrZmNq?=
 =?utf-8?Q?tF5xobywKpKRK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a2d766-0ddb-4aab-d428-08d9620cfc01
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 05:56:55.5917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7ZP3oxS1nOLdUpvIJUOy6sIugy8aL8HOtW6gzZ66dtsWheJ7WIGJwETPjfXkqxTojYPB9L3BTDgBswOLI7w+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5671
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWl6IEF1
Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCBBdWd1c3QgMTgsIDIwMjEgNToxOSBBTQ0KPiBUbzogSywgS2lyYW4gPGtpcmFuLmtAaW50ZWwu
Y29tPg0KPiBDYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsgU3JpdmF0c2EsIFJh
dmlzaGFua2FyDQo+IDxyYXZpc2hhbmthci5zcml2YXRzYUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjJdIG1nbXQ6IFNldCBvZmZsb2FkIGNvZGVjIG1nbXQgZmVhdHVyZQ0KPiAN
Cj4gSGkgS2lyYW4sDQo+IA0KPiBPbiBNb24sIEF1ZyAxNiwgMjAyMSBhdCA4OjA2IFBNIEtpcmFu
IEsgPGtpcmFuLmtAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBtZ210IHN1cHBvcnQg
dG8gdG9nZ2xlIG9mZmxvYWQgY29kZWMgZmVhdHVyZQ0KPiA+IC0tLQ0KPiA+IGNoYW5nZXMgaW4g
djI6DQo+ID4gIC0gZml4IHdhcm5pbmdzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2gNCj4gPiAgLSBh
ZGQgdXVpZCB0byAvc3JjL3NoYXJlZC91dGlsLmM6dXVpZDEyOF90YWJsZQ0KPiA+ICAtIHJlbW92
ZSBzaWduLW9mZiBmcm9tIGNvbW1pdCBtZXNzYWdlDQo+ID4NCj4gPiAgc3JjL3NoYXJlZC91dGls
LmMgfCAgMSArDQo+ID4gIHRvb2xzL2J0bWdtdC5jICAgIHwgNDQNCj4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA0NSBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvc3JjL3NoYXJlZC91dGlsLmMgYi9z
cmMvc2hhcmVkL3V0aWwuYyBpbmRleA0KPiA+IDg1NGI0OGQzOGYwOS4uMjQ0NzU2NDU2NmNlIDEw
MDY0NA0KPiA+IC0tLSBhL3NyYy9zaGFyZWQvdXRpbC5jDQo+ID4gKysrIGIvc3JjL3NoYXJlZC91
dGlsLmMNCj4gPiBAQCAtMTAyNyw2ICsxMDI3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB7DQo+
ID4gICAgICAgICAgICAgICAgICJCbHVlWiBFeHBlcmltZW50YWwgTEwgcHJpdmFjeSIgfSwNCj4g
PiAgICAgICAgIHsgIjMzMDg1OWJjLTc1MDYtNDkyZC05MzcwLTlhNmYwNjE0MDM3ZiIsDQo+ID4g
ICAgICAgICAgICAgICAgICJCbHVlWiBFeHBlcmltZW50YWwgQmx1ZXRvb3RoIFF1YWxpdHkgUmVw
b3J0IiB9LA0KPiA+ICsgICAgICAgeyAiYTY2OTVhY2UtZWU3Zi00ZmI5LTg4MWEtNWZhYzY2YzYy
OWFmIiwgIkJsdWVaIE9mZmxvYWQNCj4gPiArIENvZGVjcyJ9LA0KPiANCj4gUGxlYXNlIGhhdmUg
aXQgYXMgYSBzZXBhcmF0ZSBwYXRjaC4NCg0KQWNrLiAgSSB3aWxsIHNlbmQgYW4gdXBkYXRlZCBw
YXRjaC4NCj4gDQo+ID4gICAgICAgICB7IH0NCj4gPiAgfTsNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS90b29scy9idG1nbXQuYyBiL3Rvb2xzL2J0bWdtdC5jIGluZGV4DQo+ID4gN2Q5MDgyMzgxNTZk
Li5hODQwYzQyOGNjNzQgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvYnRtZ210LmMNCj4gPiArKysg
Yi90b29scy9idG1nbXQuYw0KPiA+IEBAIC0yNTU0LDYgKzI1NTQsNDggQEAgc3RhdGljIHZvaWQg
Y21kX3ByaXZhY3koaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiA+ICAgICAgICAgfQ0KPiA+ICB9
DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgZXhwX29mZmxvYWRfcnNwKHVpbnQ4X3Qgc3RhdHVzLCB1
aW50MTZfdCBsZW4sIGNvbnN0IHZvaWQNCj4gKnBhcmFtLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZA0KPiA+ICsqdXNlcl9k
YXRhKSB7DQo+ID4gKyAgICAgICBpZiAoc3RhdHVzICE9IDApDQo+ID4gKyAgICAgICAgICAgICAg
IGVycm9yKCJTZXQgb2ZmbG9hZCBjb2RlYyBmYWlsZWQgd2l0aCBzdGF0dXMgMHglMDJ4ICglcyki
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
YXR1cywgbWdtdF9lcnJzdHIoc3RhdHVzKSk7DQo+ID4gKyAgICAgICBlbHNlDQo+ID4gKyAgICAg
ICAgICAgICAgIHByaW50KCJPZmZsb2FkIGNvZGVjIGZlYXR1cmUgc3VjY2Vzc2Z1bGx5IHNldCIp
Ow0KPiA+ICsNCj4gPiArICAgICAgIGJ0X3NoZWxsX25vbmludGVyYWN0aXZlX3F1aXQoRVhJVF9T
VUNDRVNTKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgY21kX2V4cF9vZmZsb2Fk
X2NvZGVjcyhpbnQgYXJnYywgY2hhciAqKmFyZ3YpIHsNCj4gPiArICAgICAgIC8qIGE2Njk1YWNl
LWVlN2YtNGZiOS04ODFhLTVmYWM2NmM2MjlhZiAqLw0KPiA+ICsgICAgICAgc3RhdGljIGNvbnN0
IHVpbnQ4X3QgdXVpZFsxNl0gPSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAweGFmLCAweDI5LCAweGM2LCAweDY2LCAweGFjLCAweDVmLCAweDFhLCAweDg4LA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHhiOSwgMHg0ZiwgMHg3ZiwgMHhlZSwgMHhj
ZSwgMHg1YSwgMHg2OSwgMHhhNiwNCj4gPiArICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAg
c3RydWN0IG1nbXRfY3Bfc2V0X2V4cF9mZWF0dXJlIGNwOw0KPiA+ICsgICAgICAgdWludDhfdCB2
YWw7DQo+ID4gKyAgICAgICB1aW50MTZfdCBpbmRleDsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAo
cGFyc2Vfc2V0dGluZyhhcmdjLCBhcmd2LCAmdmFsKSA9PSBmYWxzZSkNCj4gPiArICAgICAgICAg
ICAgICAgcmV0dXJuIGJ0X3NoZWxsX25vbmludGVyYWN0aXZlX3F1aXQoRVhJVF9GQUlMVVJFKTsN
Cj4gPiArDQo+ID4gKyAgICAgICBpbmRleCA9IG1nbXRfaW5kZXg7DQo+ID4gKyAgICAgICBpZiAo
aW5kZXggPT0gTUdNVF9JTkRFWF9OT05FKQ0KPiA+ICsgICAgICAgICAgICAgICBpbmRleCA9IDA7
DQo+ID4gKw0KPiA+ICsgICAgICAgbWVtc2V0KCZjcCwgMCwgc2l6ZW9mKGNwKSk7DQo+ID4gKyAg
ICAgICBtZW1jcHkoY3AudXVpZCwgdXVpZCwgMTYpOw0KPiA+ICsgICAgICAgY3AuYWN0aW9uID0g
dmFsOw0KPiA+ICsNCj4gPiArICAgICAgIGlmIChtZ210X3NlbmQobWdtdCwgTUdNVF9PUF9TRVRf
RVhQX0ZFQVRVUkUsIGluZGV4LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihj
cCksICZjcCwgZXhwX29mZmxvYWRfcnNwLCBOVUxMLCBOVUxMKSA9PSAwKSB7DQo+ID4gKyAgICAg
ICAgICAgICAgIGVycm9yKCJVbmFibGUgdG8gc2VuZCBvZmZsb2FkIGNvZGVjcyBmZWF0dXJlIGNt
ZCIpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gYnRfc2hlbGxfbm9uaW50ZXJhY3RpdmVf
cXVpdChFWElUX0ZBSUxVUkUpOw0KPiA+ICsgICAgICAgfQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICBz
dGF0aWMgdm9pZCBjbGFzc19yc3AodWludDE2X3Qgb3AsIHVpbnQxNl90IGlkLCB1aW50OF90IHN0
YXR1cywgdWludDE2X3QgbGVuLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgdm9pZA0KPiA+ICpwYXJhbSkgIHsgQEAgLTU1
OTUsNiArNTYzNyw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYnRfc2hlbGxfbWVudQ0KPiA+IG1h
aW5fbWVudSA9IHsNCj4gPiAgICAgICAgICAgICAgICAgY21kX2V4cF9wcml2YWN5LCAgICAgICAg
IlNldCBMTCBwcml2YWN5IGZlYXR1cmUiICAgICAgICB9LA0KPiA+ICAgICAgICAgeyAiZXhwLXF1
YWxpdHkiLCAgICAgICAgIjxvbi9vZmY+IiwgY21kX2V4cF9xdWFsaXR5LA0KPiA+ICAgICAgICAg
ICAgICAgICAiU2V0IGJsdWV0b290aCBxdWFsaXR5IHJlcG9ydCBmZWF0dXJlIiAgICAgICAgICAg
ICAgICAgIH0sDQo+ID4gKyAgICAgICB7ICJleHAtb2ZmbG9hZCIsICAgICAgICAgICAgICAgICI8
b24vb2ZmPiIsDQo+ID4gKyAgICAgICAgICAgICAgIGNtZF9leHBfb2ZmbG9hZF9jb2RlY3MsICJU
b2dnbGUgY29kZWMgc3VwcG9ydCIgICAgICAgICAgfSwNCj4gPiAgICAgICAgIHsgInJlYWQtc3lz
Y29uZmlnIiwgICAgIE5VTEwsDQo+ID4gICAgICAgICAgICAgICAgIGNtZF9yZWFkX3N5c2NvbmZp
ZywgICAgICJSZWFkIFN5c3RlbSBDb25maWd1cmF0aW9uIiAgICAgfSwNCj4gPiAgICAgICAgIHsg
InNldC1zeXNjb25maWciLCAgICAgICI8LXZ8LWg+IFtvcHRpb25zLi4uXSIsDQo+ID4gLS0NCj4g
PiAyLjE3LjENCj4gPg0KPiANCj4gDQo+IC0tDQo+IEx1aXogQXVndXN0byB2b24gRGVudHoNCg0K
VGhhbmtzLA0KS2lyYW4NCg0K
