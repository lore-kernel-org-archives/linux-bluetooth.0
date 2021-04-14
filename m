Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19BFC433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Apr 2021 05:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C947A61222
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Apr 2021 05:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhDNFOW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Apr 2021 01:14:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:19881 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231642AbhDNFOV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Apr 2021 01:14:21 -0400
IronPort-SDR: VO9BdQLbJ3J691Q60+3i2V8bnGJ7CGwNd5gXCamRAAOAt3yZTPABLB5HCWHLUEpiATrXYn2WYV
 G+4G+2li8Apg==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="194594250"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="194594250"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 22:14:00 -0700
IronPort-SDR: UfTm+Y55qXm8OFTGdhsG+JXOCJZz6SLv76KT9Pnnokmyof33cBRwfmfQvxuKdgfMD//LeDk0dg
 MMalaprCzPSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="532650367"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2021 22:14:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 22:13:59 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 22:13:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 13 Apr 2021 22:13:59 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 13 Apr 2021 22:13:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqqqjmxW1IOYiiFH1veXP13FV22WvkZ1K3KzRpKfc9e0mMGdKNJ5fjz5535HLmIB1hz3aWZ/HuCpXSstwmTrRCYjd8a+ODhbuoeu7j5Jo4hsfgTwOpP79NlULPwf0NezVG72cGhNiBPQa+dpvpoPgXqPrAiadQ91QE7jacytEyUOYshWe81C3DlctGN4WcLwOIziZfaVeK7Yz82VcqwAdYZWrYI58gsNUT/FUydz574uBoKyMyLONwufu+XK8vEmd5DdUw/649rH+T9PX9LpOaboQrFtEwjZRjIETS1HxZzaXXBT5wK4BTFSUNef0coLim9icadyrT8Hk9TzsbkDtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJruG4RvD/C3/wdO/56BmPebBrrT1fiWPJJRS3aaJ0M=;
 b=P6VbyDni9n2+ngjKXJB4bX8TvJ6nYW4KMEWrWe9mlte1U12XrMwuDrSvbHlLzPifKjQ4V4PsRj7pBrEF6+AIfmjdnDs0GJJdwvHIW2fPCSMXaH27U2GKGnr6Row4xvauybkgUD6KAg66oCATsWQUXTcj3bGKa83zqF4Bb5k1FYl+PgXzK3q+jZYlBSsni737HXV0AzauIZub/dRFeuTJ+NSOwfrj2VRddB+cyWZMSeXNysoksZDPLef7iX9PNBV8MXr+152yGusDbpsNu8OT9X2vMRrdOLNbCcPS9+M0vXU/XRxWRw3D6QM5UXDoMCtPcyrHpkAX1BJNuc7Mh9SIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJruG4RvD/C3/wdO/56BmPebBrrT1fiWPJJRS3aaJ0M=;
 b=MJlu4klWSC3K1btbYutqebsoGZ3tntr6CyTyoPRuNCD7+APK0e3gzh0CqtbJ3QmTowkYMle6fcSL8nUr9tVbc2kCGWHQrz7VrMJHlCgrsY0l8tfsVN8MYuzTstVqpL9EbE2EgrhUDyOu98qXUFkt1xo9gk2z8Gsn/1QSC8EZYs0=
Received: from SN6PR11MB2703.namprd11.prod.outlook.com (2603:10b6:805:59::18)
 by SN6PR11MB3280.namprd11.prod.outlook.com (2603:10b6:805:bb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 14 Apr
 2021 05:13:58 +0000
Received: from SN6PR11MB2703.namprd11.prod.outlook.com
 ([fe80::1b:fbd6:d110:1263]) by SN6PR11MB2703.namprd11.prod.outlook.com
 ([fe80::1b:fbd6:d110:1263%6]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 05:13:58 +0000
From:   "Narasimman, Sathish" <sathish.narasimman@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Subject: RE: [Bluez PATCH] btmgmt: Add support to enable LL privacy
Thread-Topic: [Bluez PATCH] btmgmt: Add support to enable LL privacy
Thread-Index: AQHXKiri+KgHBruxm0ivQNMMSE97h6qmz9OAgABRyQCADGPZ4A==
Date:   Wed, 14 Apr 2021 05:13:57 +0000
Message-ID: <SN6PR11MB27038FDA6A26F7A63370859A944E9@SN6PR11MB2703.namprd11.prod.outlook.com>
References: <20210405145802.27317-1-sathish.narasimman@intel.com>
 <CABBYNZLTU1t=UEsvxsu8F0kP8f5-Nvi_Xysy8ftg57j9Snu99w@mail.gmail.com>
 <588F99C8-E5B4-47D3-84C3-72F9E6FCC9EC@holtmann.org>
In-Reply-To: <588F99C8-E5B4-47D3-84C3-72F9E6FCC9EC@holtmann.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.0.76
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [27.6.184.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d237d64-630c-4d9d-5d7a-08d8ff041b9d
x-ms-traffictypediagnostic: SN6PR11MB3280:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3280B0FB223509B7E689FBB5944E9@SN6PR11MB3280.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gLdNVgHJgB3oAJ5CU8hpJ1GIZZfO0WOON61+jm832Lz8RMQypQ+ES+blq3cd8XurLZlZiaa1FXIQAot8/m6FW0clO27QXhd7YR97UsCenaQ1o8HcWRHHKf7h4r9PLVLB+AzSmjajJvoJ2lXQm4BuXQ941BQN70Fh5Fk7LVmblMvETlP5Q7Y0pynurmMkp+T6EZ8pRnxB11fkv5PTrAvsh0bJ3Z1P5edoKScO/o0lBlmxu2+Gv+pu5i8eKvOnSjtfQhxrrRzNV0ejJwma8E5Qb/wC0iag/flHnGJ/kCf+224BwmDRH8WkrEBD0xmEGIajybc5vCM+rBYjXm9j+vISlySK9C/DModV6SYodyVmN+bmqmDqH4aildmykHdba1FjGMxHbqbaMSLbpTN81bNI/5s/KHpC+5yHIJmoPaZ+U56JJj6YJ416TSWumeW9QxXKPoVLJ+xSsZ3oDpkJH6ttmBC5VeMiqYyxO5BiMb6U2Z3AfX5JWVgKa0soWm0ejIw5p2UtpvIeVJAXLY17Oeo7ybGc9dbszsWsdIbUtCuJUWYiFqTGO8GqEWEecprkasSBfvqwSZiCiUEmzXUriKRQSzC/SOlnMF9YnbDm7eWNI1Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2703.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39850400004)(346002)(396003)(366004)(376002)(478600001)(5660300002)(54906003)(186003)(8676002)(26005)(83380400001)(110136005)(9686003)(122000001)(55016002)(107886003)(86362001)(38100700002)(53546011)(66476007)(2906002)(66556008)(316002)(71200400001)(6506007)(33656002)(66946007)(7696005)(76116006)(52536014)(64756008)(66446008)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bysvbHR4V2g0bitwcllPOHk2cUgwbWRJUzlHRUF5WFlnaG55R0tsT1N1NlhI?=
 =?utf-8?B?RE5NS0F3NEJ5Qm11eEt4VllMKy9hVHJ6Q0w0WjVEY3crdm1rMFJ5dW0zbmp1?=
 =?utf-8?B?SThoTEt4NE5laU9VakI1V3FxSkkreDNzRUVSeVlBRkNlWnprNjJRK2svOVVZ?=
 =?utf-8?B?YTZsL3lhK285MTE3UTRHT1ZyVjllaVdRcWJ5SzV5Vm5FQ01YUUtpamcvd2xp?=
 =?utf-8?B?L0tNY2VDUVh0NE9QbzFIUHRzcDU2b3FxbVdCd3Q1NUVreWtpeHBRSThSZkh2?=
 =?utf-8?B?aXpOTjFScy9ReGJoYWVTUmZ5S1VZT096WXV3OUdqOWJmQ0syVkkzVkpBKzZa?=
 =?utf-8?B?UUxkb2pFcTVyb1ZWbjJVV3FDaHZRSmFXM1c3WUM0ekNmOWd2QTByNjlLQ0xE?=
 =?utf-8?B?cGRBbmJNaTZ1emVGQmc4RENmcGtaMnh2ZDZKTVQ1eWdmL0JNZGVyR0F6V0xs?=
 =?utf-8?B?UmxvQXprWmlHS095RmdMMUZwR29aOFpYbDFIaWxxU0xGUkR6bkFYUUQzektD?=
 =?utf-8?B?Z0g4UG03OE9jcmhnM25lbEk3MTEycmFoblhqaHpIazJGUGZQOGVtNjJ0ZFBH?=
 =?utf-8?B?TWhJb0NQNk0rQ0lsNEFlWTI2YzJYaWlLaVlJOGJ3a2MrcjVHS2x3RUM0UCtV?=
 =?utf-8?B?RmdYWk8xNldwMDRXY2xvaDlGL083eklVNWVMMmpZM3JtWFFOeDhEUXltRFgv?=
 =?utf-8?B?eWhmNmE4N25kMzhyN0VheGRFaFJGUGVnQWpNdWFMaE4yUnB0OS9TRnJFQUJX?=
 =?utf-8?B?T3lnZEU2Zm1oQ29uSWdpTFdCbWg3QUdSRFJUWExrcFc0SStGQTlKZHkrQ0tO?=
 =?utf-8?B?ZzlaRWRlMldKVjIzejQzSjNTMEpiR3ZkNFA4WnczV0lHY1N5NEs1SmtCSHM0?=
 =?utf-8?B?ZlFlTDI0WDBtZXd1ODlqczlUaHAwZDRkdThLdG81TFU3Sy9GcWpNWlEzajZl?=
 =?utf-8?B?SDNwR3dvMUJTbytYUmxXOEFqQko0UFB6NHhrWXZmMmM2dmFEZmVubmtYOG9T?=
 =?utf-8?B?TXhZVlgzeDNucnEzN21HMmRnNDcrOXRDSGloa2xOeitlMEw3bklJUkxvZFFN?=
 =?utf-8?B?ZzUwczNJdnRyZFZRdDd1dnZwQWt2ZE1MSXVGVU9kSnJHeGtyNWdBRTFvaFlp?=
 =?utf-8?B?b1A3MHFRbkVMaW9UOXJXd3dCejJxYkxncDZBTk1UOVE2UHhVYW5ZVlI5SW9Q?=
 =?utf-8?B?bWQvb2tKNmpaQ29PUGduMmxGMUorZmNUZjIrSC9hdDViZmhOTkxMcFd5a0Yx?=
 =?utf-8?B?MXpBYVhPV1Q5RDAvdWRURnVZdE5EWFlpdzJRK2s3WWNBdlJhNkprbjlaYUZR?=
 =?utf-8?B?WkVsWlNjSHRlbWlnWURDenA5cW5ubGdjY3dyTzV2MkdQcTJERngvMHRremJw?=
 =?utf-8?B?b21LM2xHeGcvaUtFNmRMWk8vZkpmdVNYRWdZM1dmaW12UTdMNTY5amFXRkND?=
 =?utf-8?B?REJRT2crRG4raUZ0Q096Z0xGRjVGSkQwVzM1Y0I2NWJUOGE1TWFCWDBGM3Fq?=
 =?utf-8?B?Z0NLWW85WHcyK0xGT0IzTDJrTjFQSjAycUZma2RYRm5FbGozb1k2VXQ2SmJV?=
 =?utf-8?B?YmJxZzhiWWVJN2ZZRG5uelhKZ3VDMWl2RDFZN1QrRmRDREdHejRZVHlOWng0?=
 =?utf-8?B?QXVKNXBGZEdPVmlQWmZQa3FBaVhOek5VTkF2Q1VzSDd5YmNGb3ZDd29RUmtM?=
 =?utf-8?B?TmtKWFZGZ1p1aU8vajdtTkpBditrTjQ5N3prYTBxME1Jak4xWEFWUHZXbGxU?=
 =?utf-8?Q?xkGkLeLoLtopnvdNFA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2703.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d237d64-630c-4d9d-5d7a-08d8ff041b9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 05:13:58.0345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r3DWJzy5kHQyqkaSV1ridniTp2BACy2lfcckHKzfiqcvZivk1u3/Qh5rRy2uISh2UukPClU9tno+r4QM5xvAZc7D5DiApYOXikRvckPUR3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3280
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyY2VsIEhvbHRt
YW5uIDxtYXJjZWxAaG9sdG1hbm4ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCA2LCAyMDIx
IDE6MzEgUE0NCj4gVG86IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXouZGVudHpAZ21haWwu
Y29tPg0KPiBDYzogTmFyYXNpbW1hbiwgU2F0aGlzaCA8c2F0aGlzaC5uYXJhc2ltbWFuQGludGVs
LmNvbT47IGxpbnV4LQ0KPiBibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBUdW1rdXIgTmFyYXlh
biwgQ2hldGhhbg0KPiA8Y2hldGhhbi50dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+OyBTcml2YXRz
YSwgUmF2aXNoYW5rYXINCj4gPHJhdmlzaGFua2FyLnNyaXZhdHNhQGludGVsLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtCbHVleiBQQVRDSF0gYnRtZ210OiBBZGQgc3VwcG9ydCB0byBlbmFibGUgTEwg
cHJpdmFjeQ0KPiANCj4gSGkgTHVpeiwNCj4gDQo+ID4+IElmIHRoZSBCbHVldG9vdGggY29udHJv
bGxlciBzdXBwb3J0cyBMTCBwcml2YWN5IHRoaXMgY29tbWFuZCB3aWxsIGJlDQo+ID4+IHVzZWQg
dG8gdGVzdCB0aGUgc2FtZS4NCj4gPj4gInN1ZG8gYnRtZ210IHBvd2VyIG9mZiINCj4gPj4gInN1
ZG8gYnRtZ210IGxscHJpdmFjeSBvbiINCj4gPj4gInN1ZG8gYnRtZ210IHBvd2VyIG9uIg0KPiA+
Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBTYXRoaXNoIE5hcmFzaW1tYW4gPHNhdGhpc2gubmFyYXNp
bW1hbkBpbnRlbC5jb20+DQo+ID4+IC0tLQ0KPiA+PiB0b29scy9idG1nbXQuYyB8IDM4ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+IDEgZmlsZSBjaGFuZ2VkLCAz
OCBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS90b29scy9idG1nbXQuYyBi
L3Rvb2xzL2J0bWdtdC5jIGluZGV4DQo+ID4+IDkzZDI0NGZmOGVjOC4uNGE1M2MzNzY4ZmU5IDEw
MDY0NA0KPiA+PiAtLS0gYS90b29scy9idG1nbXQuYw0KPiA+PiArKysgYi90b29scy9idG1nbXQu
Yw0KPiA+PiBAQCAtMjI2MSw2ICsyMjYxLDQyIEBAIHN0YXRpYyB2b2lkIGNtZF9icmVkcihpbnQg
YXJnYywgY2hhciAqKmFyZ3YpDQo+ID4+ICAgICAgICBjbWRfc2V0dGluZyhNR01UX09QX1NFVF9C
UkVEUiwgYXJnYywgYXJndik7IH0NCj4gPj4NCj4gPj4gK3N0YXRpYyB2b2lkIGxsX3JwYV9yZXNv
bG5fcnNwKHVpbnQ4X3Qgc3RhdHVzLCB1aW50MTZfdCBsZW4sIGNvbnN0IHZvaWQgKnBhcmFtLA0K
PiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICp1c2VyX2RhdGEpIHsNCj4g
Pj4gKyAgICAgICBpZiAoc3RhdHVzICE9IDApDQo+ID4+ICsgICAgICAgICAgICAgICBlcnJvcigi
Q291bGQgbm90IHNldCBMTCBSUEEgcmVzb2x1dGlvbiB3aXRoIHN0YXR1cyAweCUwMnggKCVzKSIs
DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICBzdGF0dXMsIG1nbXRfZXJyc3RyKHN0YXR1cykp
Ow0KPiA+PiArICAgICAgIGVsc2UNCj4gPj4gKyAgICAgICAgICAgICAgIHByaW50KCJMTCBSUEEg
UmVzb2x1dGlvbiBzdWNjZXNzZnVsbHkgc2V0Iik7DQo+ID4+ICsNCj4gPj4gKyAgICAgICBidF9z
aGVsbF9ub25pbnRlcmFjdGl2ZV9xdWl0KEVYSVRfU1VDQ0VTUyk7DQo+ID4+ICt9DQo+ID4+ICsN
Cj4gPj4gK3N0YXRpYyB2b2lkIGNtZF9zZXRfbGxfcnBhX3Jlc29sbihpbnQgYXJnYywgY2hhciAq
KmFyZ3YpIHsNCj4gPj4gKyAgICAgICAvKiAxNWMwYTE0OC1jMjczLTExZWEtYjNkZS0wMjQyYWMx
MzAwMDQgKi8NCj4gPj4gKyAgICAgICBzdGF0aWMgY29uc3QgdWludDhfdCBycGFfcmVzb2x1dGlv
bl91dWlkWzE2XSA9IHsNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDA0
LCAweDAwLCAweDEzLCAweGFjLCAweDQyLCAweDAyLCAweGRlLCAweGIzLA0KPiA+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDB4ZWEsIDB4MTEsIDB4NzMsIDB4YzIsIDB4NDgsIDB4
YTEsIDB4YzAsIDB4MTUsDQo+ID4+ICsgICAgICAgfTsNCj4gPj4gKyAgICAgICBzdHJ1Y3QgbWdt
dF9jcF9zZXRfZXhwX2ZlYXR1cmUgY3A7DQo+ID4+ICsgICAgICAgdWludDE2X3QgaW5kZXg7DQo+
ID4+ICsNCj4gPj4gKyAgICAgICBtZW1zZXQoJmNwLCAwLCBzaXplb2YoY3ApKTsNCj4gPj4gKyAg
ICAgICBtZW1jcHkoY3AudXVpZCwgcnBhX3Jlc29sdXRpb25fdXVpZCwgMTYpOw0KPiA+PiArDQo+
ID4+ICsgICAgICAgaW5kZXggPSBtZ210X2luZGV4Ow0KPiA+PiArICAgICAgIGlmIChpbmRleCA9
PSBNR01UX0lOREVYX05PTkUpDQo+ID4+ICsgICAgICAgICAgICAgICBpbmRleCA9IDA7DQo+ID4+
ICsNCj4gPj4gKyAgICAgICBpZiAocGFyc2Vfc2V0dGluZyhhcmdjLCBhcmd2LCAmY3AuYWN0aW9u
KSA9PSBmYWxzZSkNCj4gPj4gKyAgICAgICAgICAgICAgIHJldHVybiBidF9zaGVsbF9ub25pbnRl
cmFjdGl2ZV9xdWl0KEVYSVRfRkFJTFVSRSk7DQo+ID4+ICsNCj4gPj4gKyAgICAgICBtZ210X3Nl
bmQobWdtdCwgTUdNVF9PUF9TRVRfRVhQX0ZFQVRVUkUsIGluZGV4LA0KPiA+PiArICAgICAgICAg
ICAgICAgICBzaXplb2YoY3ApLCAmY3AsIGxsX3JwYV9yZXNvbG5fcnNwLCBOVUxMLCBOVUxMKTsg
fQ0KPiA+PiArDQo+ID4+IHN0YXRpYyB2b2lkIGNtZF9wcml2YWN5KGludCBhcmdjLCBjaGFyICoq
YXJndikgew0KPiA+PiAgICAgICAgc3RydWN0IG1nbXRfY3Bfc2V0X3ByaXZhY3kgY3A7IEBAIC01
MjQzLDYgKzUyNzksOCBAQCBzdGF0aWMNCj4gPj4gY29uc3Qgc3RydWN0IGJ0X3NoZWxsX21lbnUg
bWFpbl9tZW51ID0gew0KPiA+PiAgICAgICAgICAgICAgICBjbWRfYnJlZHIsICAgICAgICAgICAg
ICAiVG9nZ2xlIEJSL0VEUiBzdXBwb3J0IiwgICAgICAgIH0sDQo+ID4+ICAgICAgICB7ICJwcml2
YWN5IiwgICAgICAgICAgICAiPG9uL29mZj4iLA0KPiA+PiAgICAgICAgICAgICAgICBjbWRfcHJp
dmFjeSwgICAgICAgICAgICAiVG9nZ2xlIHByaXZhY3kgc3VwcG9ydCIgICAgICAgIH0sDQo+ID4+
ICsgICAgICAgeyAibGxwcml2YWN5IiwgICAgICAgICAgIjxvbi9vZmY+IiwNCj4gPj4gKyAgICAg
ICAgICAgICAgIGNtZF9zZXRfbGxfcnBhX3Jlc29sbiwgICJUb2dnbGUgTEwgcHJpdmFjeSBzdXBw
b3J0IiAgICAgfSwNCj4gPg0KPiA+IExldCdzIGhhdmUgaXQgYXMgYSBwYXJhbWV0ZXIgb2YgcHJp
dmFjeSBjb21tYW5kIDxvbi9vZmYvbGw+IHNvIHdoZW4gYQ0KPiA+IHVzZXIgZW50ZXJzIGxsIGl0
IGVuYWJsZXMgbGluay1sYXllciBwcml2YWN5Lg0KPiANCj4gcGxlYXNlIGRvbuKAmXQuIFRoZSBw
cml2YWN5IHNldHRpbmcgbWVhbnMgdGhhdCB3ZSBzdGFydCB1c2luZyBSUEFzLg0KPiANCj4gQWxz
byB3aGF0IGlzIHdyb25nIHdpdGggZXhwLXByaXZhY3kgY29tbWFuZCB0aGF0IEkgYWxyZWFkeSBh
ZGRlZC4NCg0KR2VudGxlIFJlbWluZGVyLg0KPiANCj4gUmVnYXJkcw0KPiANCj4gTWFyY2VsDQoN
Cg0KUmVnYXJkcw0KU2F0aGlzaCBODQo=
