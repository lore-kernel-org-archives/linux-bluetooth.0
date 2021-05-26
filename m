Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A53C2B9F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 04:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C12A6117A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 04:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhEZEeD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 May 2021 00:34:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:41173 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232206AbhEZEeC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 May 2021 00:34:02 -0400
IronPort-SDR: Ny97DbRQ64N1JKPwGXUt9d8zqifj5KC7mVp0XjCNhk6eXWcb76QvZPrmBeoxwOtbvIUevlRrX0
 mCTlH4VJ/gMg==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="182701508"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="182701508"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 21:32:31 -0700
IronPort-SDR: qDMgEbzCst2qvCXCE1Tywd0ewtE9d978dSVnSmGHpqD//EQY9oKHK0GFNoikh3BCYKN1nk7ud0
 6qpoxoEDbfUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="397672728"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga006.jf.intel.com with ESMTP; 25 May 2021 21:32:31 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 25 May 2021 21:32:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 25 May 2021 21:32:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 25 May 2021 21:32:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Snl6ARpCHO/qZgpE2x66txL12evBJakNQ98jgSrkyEOWDu/eLWzp2ZA/51Oek3nApkGiRsGC/hxCJStjB33aWBa4p1797FRE+vB2/Kb1Kp0fga1wAIOyTEdo7UAUnC2cnWUE9nVHv6/sZ2n1z1b6Xmyxo9/d7fTieFMJOcpUto+5unGjdNAa0Fj94vlXuBeJ3XzLvTWVZh5Cqu0owx7QF1FdBuLLBqZzHNxGQvDvSAYHPWoqwR1RRzmjef65CmdSrryra/HV50ebfYAn7iwQmF6YCgqF9R27IXyF/eoJwX0hUwRhiIvHxMdZvyxt0svCmsVyAOzQH7Ks3JQhs7KnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKgefleMYBAH5KvtjKrKHK7umXObxC9N5IoQN6boOEM=;
 b=EWcAkk8uASI9NnxW0ZBTqLwdGbItx84I6rTtK7zQvUtDRVzZLvjjDA0ipcFpQFWSNJ0pi7pMJdTB9sZWjwvKFcKE/+gO8spgvZBKdYG/zlhLvQdfd1O5otdgbuu1QGfDStGsPUdWWpr3CWwrYtUTNeLGJp5FWOA4OGjj3J7YzWvaLT74DIFkLmFAqra7c+VX9/S+Q2l7/NMrzR96rr+VIGvFuoU0lUsqS+CYrxmkXCsBKzqV0R3bC8ygiXvWTMY6ciq4v9Jm9KfRZmqkLJDP9P6A6uDGbWcRZFsZTSTeW031JT5m7zA47BGexHDHAkY+3YzgBJh1rTw20tQA8/q8mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKgefleMYBAH5KvtjKrKHK7umXObxC9N5IoQN6boOEM=;
 b=ltsJdKdFdyFN3a9Z4kH/31QhMonxxFqExQOgKdbODIbcUoKui9TEh3fkx8kfmg1yjTrKefELiByHUMeI4GP4BxjbKxPfaGtAPfMTEDe0KID/C5c8dLTaig8Ul/MNvUojgilznfOSXmIlYiVMBhwHFKoOiNNNVpPmn2OlTBkl+yE=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5670.namprd11.prod.outlook.com (2603:10b6:8:37::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.23; Wed, 26 May 2021 04:32:26 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7%5]) with mapi id 15.20.4173.020; Wed, 26 May 2021
 04:32:26 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Chris Clayton <chris2553@googlemail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: RE: BT Intel: Regression loading firmware in linux-5.13-rc3
Thread-Topic: BT Intel: Regression loading firmware in linux-5.13-rc3
Thread-Index: AQHXUUyEbJf5P+ag+UOtEiqZABIrNarz+lcggAAG9oCAAH5+gIAAFEYAgAAMXYCAAIugMA==
Date:   Wed, 26 May 2021 04:32:26 +0000
Message-ID: <DM8PR11MB5573BDF3973186620DC818D3F5249@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <81eddb07-f346-c12a-345b-d929fd2edb10@googlemail.com>
 <DM8PR11MB5573280FAB275DCEE789D389F5259@DM8PR11MB5573.namprd11.prod.outlook.com>
 <52914cbc-4004-8389-fa7b-6b42cf8f85e1@googlemail.com>
 <CABBYNZKtApu7Q4kU+msfLco-ihDrx5kWiugDRT0ic3_Tb1YSGg@mail.gmail.com>
 <d97da5b6-a337-3550-ace3-e6789fd9165f@googlemail.com>
 <CABBYNZLYsM_LgKU8r0BRGp3hAk8m2OQWxnwtGz8VwidGCHRB-A@mail.gmail.com>
In-Reply-To: <CABBYNZLYsM_LgKU8r0BRGp3hAk8m2OQWxnwtGz8VwidGCHRB-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2405:201:d012:c862:d15d:a933:aca5:149c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d416550-a46b-44ec-b675-08d91fff43b7
x-ms-traffictypediagnostic: DM8PR11MB5670:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB567088F0BC8D8462FC13530BF5249@DM8PR11MB5670.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XMO4IwD0ARtOS3YS86/Mc6PoioP34MU/IRtwKJZJkCUoX+PkuB06+c59+3X4GEaDqWX+a/crtIrqMAeWKHXcr6OUiDaqvaqmSzXXSmlgz7hXhUhcKCKtJn17zPK7oquwuKQPA4ElKLmOpS3Q9grvzpRkh3Qvtg9rlVwVpoKnwhpkqnbL2TMh3LG9r4MJwyRRCrXPiYnMLya2kGw2rnVv4wTXh9FpEZdcgKoQm69agSZaN3j9o3hbaPDcEzF+TuVYIm4LOStS3ODXrb0snCARfblzN5yGnWY284I5tm2aZIJ5Lw+3TSJQK7TUIucu0S8CXnXFo1UbzgWs5XpO/zBv2Yk1GaBqLmZitanrlGZQP2vZSEFxwvDFSLHs30zvi+5iaGSi70adrMe8KXUoMiA2Dn8616HjWHuZPOZSONZTKnnGq7rMNFyzCcATXHalFAWSsZu5s9np8+Z5+JFapDulrYdjMk+MHh967Tti91mZOejfLjW/NVz72mshRxm/uv2TmP1N3SMoCWnfEGCqW13+8qbz6nmu83tBFW3bVM9skrMiDMAopabZh+KtLDHy/7BLHi1Y1rAY/hcdlO49dWKmeV8FXAcEwt18TmpnWxrcbRzV+p8uAUONzTcCQdj3RrsxYctw/czIOPJJ/LKf88r9Fz+e7+pLJDkEUyjBqgskVC6XjC3+LN8B0fh/wWbvj70RdUq0dDZ37bjsfb6hvN8p75FVDkKBd5tRRlDIlrXRYE0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(376002)(136003)(346002)(9686003)(83380400001)(6506007)(33656002)(4326008)(55016002)(8676002)(86362001)(54906003)(53546011)(38100700002)(110136005)(122000001)(66556008)(66476007)(52536014)(8936002)(478600001)(71200400001)(2906002)(186003)(7696005)(64756008)(66446008)(76116006)(316002)(5660300002)(66946007)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SnhzZWtxU1FZTkx6NGJQRkJTVHloZE1BVlB4KzRMR3FQRWRCTmo3K2piVkxF?=
 =?utf-8?B?eGw1bkptZEFOdHlJSWZkOE1yVE5EeWVUMEx3ak1LVzJsZm0xczRwMVI4TjRl?=
 =?utf-8?B?NGErYTI1LzQvd0dneFJkN0YyWHZ2dWpFL2dRQkIwd1ByeHpabGQ0eXkyR3Qv?=
 =?utf-8?B?ZDk5RWwvSGJZSmF2QkZzTWFwcEkxU0RVRlpxV3kwS2luV1YzNDFHSENVait2?=
 =?utf-8?B?WGE3ZkY3c1dtRlpwZkord00wME1idmN5S2FnaFZ1N2dCdWYySlRsYzQzVzVx?=
 =?utf-8?B?SkN4M2Jmc1BZMGpZVEJnN004dC9LcUxSZ0VENG1yTlUyTi90bDNpSkYvUjRh?=
 =?utf-8?B?OHlVL3A1S09SbXpKdHRWZm9GdC9YY3IraHZldHJ1c0YwVTNSYnBjdEJtZjVO?=
 =?utf-8?B?OUZDRzBuSzdjd0lZdHBUN3hIZG43RWNBa0JuSEt6ZjEvRzg0aW04MGY4WFI3?=
 =?utf-8?B?OWVYR2pDOUZtZ2s1VjJxTW4vTktuYjhwOG9qZERNV1Nua1phL0NVdUx4d3J5?=
 =?utf-8?B?Z0ttYm9wU0FKU1Z4dVBybUpmdVgvd1hvOFUzVEloeUVJenFaRGpSWG1udllw?=
 =?utf-8?B?elNLWExtZVZGbGkyZndScUszbXBSeGFsYXpZRytqa3F0NFRQbEV3VkYyWUZy?=
 =?utf-8?B?bkdLNXRreTZESXFmSnExZGQxRzNUMXduNG9SRDdvU3ByMDdFc3M2TEtkYk1O?=
 =?utf-8?B?MnZhbGNhV3d2ZzBtemdia1ZjVjYvMHcxNEczM2FXM2VIZ2xzQmFEZFFNbktN?=
 =?utf-8?B?RXEwRUcxUnkzelVMVENrV2cxSitycVBCV2F2MWFPM3U4QlZVTjBuQnJDUWww?=
 =?utf-8?B?RVY0VWlya3MzeU1kcWZIY25SNWtqNmJvdXpVemUzUnhJMkJ3bDRjMSs4TDMz?=
 =?utf-8?B?RWh1KzJkUk8rQlhaLzdGVDY0Ym9DQjNkN1N1Vkg0SEwzQ0xNQUl4VSt1UEZw?=
 =?utf-8?B?eUkvZ2FGb0lTNmhDczlrU3ZZZk93T0xabkdGdk9OaTZuYnZjemV4bVduQUsv?=
 =?utf-8?B?OFRQdjdkQnZxVzhSdVNwMG9zUDVsTXZNMlh2NU9jSHpqUEdrTEpja2JTMHAy?=
 =?utf-8?B?RW0vYmlkaGFDM2lscGpaU0xrNlphMU1GU0tueEVyOUtOcDlXZlB5ZWxCd09W?=
 =?utf-8?B?SUlXU1pXOThvaVZPOU1UMjRxZXdqdnB4YzRqMVE2U2JrL2dLaFNuTDU1dlps?=
 =?utf-8?B?SnVLWHZiV0hrN1hkcWZQdzBHYVIvbTJ6dzZZVGJydlJUdEo3OUR0VkF1aTFQ?=
 =?utf-8?B?SnVrTWhrMVNKMHJ0MldDTUVoRUNoTmhmcG1iOEp4NXVRRG1XRWl4WmRSK0xy?=
 =?utf-8?B?Rm8wUEFRYTVrYjdVTEpyTEphMW9nWTZnUmxVQXZpdHVYQUI1WDdwdW5nWU1K?=
 =?utf-8?B?dGhhb1hFcm9UN1hsM0xJUU9SbXdHeDZsVGtQQjhGOGRzeWVhVk1yak1wNFhO?=
 =?utf-8?B?UHNGM2QrK0tVOCs1TWlDeGY1MlR6dVk4L0pjRzBJSHZFWXFVQmVNcFFNb3ZI?=
 =?utf-8?B?NEgxSmdtQTZ4Mm1PZllIOE16WU9rMGNXVlJHaXh2Q3dockRVaVU1UTBtTGxu?=
 =?utf-8?B?K0JqOUZoSjFYL0Q3S3NxTE9yWEY1MWNXbU1kcXcrVkFUYU9vNHhMaEt4bEI0?=
 =?utf-8?B?OTFtWEVxVmh5V29QMXV1bFNnY29Gemc2M2VDL2J6amFvclhzSU9lQitVRTdk?=
 =?utf-8?B?T043eEZrSGZrUVpscjg0UURQK2h6OEhLeW1JQW5GeU1UM2JEODRhZzhLbUhP?=
 =?utf-8?B?Z2NFZm9CLzRUUnlKcVp5emlzcVh0dHNGMWxmaEx1dXVYQVN5SVpVYnV3ZDFx?=
 =?utf-8?B?cXBOZC9JRi95Z0xUb09PdjMwUHl3RTlKN3lGYWdoVlptVzFNWVZXeGMwVFRv?=
 =?utf-8?Q?qIdbn7aa1kMxV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d416550-a46b-44ec-b675-08d91fff43b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 04:32:26.2532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kj1dgTkGBMgxSbliI6x0Dp2Q6i4XOtRA8bS6xtnna3k9ULltDwPyk4AnUfa5V/Owvb8Ds/H7GAPNXp6IN1x/MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5670
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQ2hyaXMsDQoNCj4gPiA+PiBEb2VzIHRoZSBwaHJhc2UgIm5leHQgcmVsZWFzZSIgbWVhbiBs
aW51eC01LjEzLXJjNCBvciB0aGUgbmV4dA0KPiA+ID4+IHJlbGVhc2Ugb2YgbGludXgtZmlybXdh
cmU/ICBJIGp1c3Qgd2FudCB0byBrbm93IHdoYXQgdG8gbG9vayBvdXQgZm9yLg0KDQpJIGRpZCBj
aGVjayBpbnRlcm5hbGx5IHdpdGggdGhlIHRlYW0gYW5kIGZpeCB3aWxsIGJlIHBhcnQgb2YgdGhl
IHJlbGVhc2UoMjIuODApICBwbGFubmVkIHRvd2FyZHMgZW5kIG9mIEF1Zy8yMS4NCg0KPiA+ID4+
DQo+ID4gPj4gVGhhbmtzDQo+ID4gPj4NCj4gPiA+PiBDaHJpcw0KPiA+ID4+DQo+ID4gPj4NCj4g
PiA+PiBPbiAyNS8wNS8yMDIxIDExOjE0LCBLLCBLaXJhbiB3cm90ZToNCj4gPiA+Pj4gSGkgQ2hy
aXMsDQo+ID4gPj4+DQo+ID4gPj4+IFRoaXMgaXMgYSBrbm93biBpc3N1ZSByZWxhdGVkIHRvIGZp
cm13YXJlIGFuZCBpcyBleHBlY3RlZCB0byBiZSBmaXhlZCBpbg0KPiBuZXh0IHJlbGVhc2UuDQo+
ID4gPj4+DQo+ID4gPj4+IFRoYW5rcywNCj4gPiA+Pj4gS2lyYW4NCj4gPiA+Pj4NCj4gPiA+Pj4N
Cj4gPiA8c25pcD4NCj4gPiA+DQo+ID4gPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9ibHVldG9vdGgvYmx1ZXRvb3RoLQ0KPiA+ID4NCj4gbmV4dC5naXQv
Y29tbWl0L2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmM/aWQ9MTgzZGNlNWE3ZmQzMDQwY2VkNmEy
MjANCj4gPiA+IGIwYWE1MzZjOTI2ZjEwY2Q5DQo+ID4gPg0KPiA+ID4gVGhhdCBzYWlkIHdlIHNo
YWxsIHByb2JhYmx5IG1lcmdlIGl0IHRvIDUuMTMgYmVmb3JlIGl0IGlzIHJlbGVhc2VkLg0KPiA+
ID4gSSB0aGluayB5b3Ugc2hvdWxkLCBvdGhlcndpc2UsIHdpdGhvdXQgcGF0Y2hpbmcsIDUuMTMu
MCB3aWxsIGJlIGJyb2tlbiBmb3INCj4gbWFueSBibHVldG9vdGggdXNlcnMuDQo+ID4NCj4gPiBJ
J3ZlIGFwcGxpZWQgeW91ciBwYXRjaCB5b3VyIHBhdGNoIHRvIExpbnVzJyBsYXRlc3QgYW5kIGdy
ZWF0ZXN0IChieQ0KPiA+IGhhbmQgLSBpdCBkb2Vzbid0IGFwcGx5IGNsZWFubHkgdG8gdGhlIGN1
cnJlbnQgNS4xMyB0cmVlKS4gVGhlIGVycm9yIG1lc3NhZ2VzDQo+IGFyZSBubyBsb25nZXIgcHJv
ZHVjZWQgYW5kIGJsdWV0b290aCBpcyB3b3JraW5nIGZpbmUsIHNvLi4uDQo+ID4NCj4gPiBUZXN0
ZWQtYnk6IENocmlzIENsYXl0b24gPGNocmlzMjU1M0Bnb29nbGVtYWlsLmNvbT4NCj4gDQo+IFNo
YWxsIEkgaGF2ZSBhbm90aGVyIHB1bGwgcmVxdWVzdCwgb3IgZG8gd2UgbmVlZCB0byBzZW5kIHRo
aXMgZGlyZWN0bHkgdG8gTGludXMNCj4gc29tZWhvdz8NCj4gDQo+IC0tDQo+IEx1aXogQXVndXN0
byB2b24gRGVudHoNCg0KVGhhbmtzLA0KS2lyYW4NCg0K
