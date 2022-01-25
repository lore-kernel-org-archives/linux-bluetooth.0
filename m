Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84426C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 21:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiAYVce (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 16:32:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:42242 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233099AbiAYVcc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 16:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643146352; x=1674682352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O5LPENhLa8K2Vxew+j5bR15ZNvXYDjL3ddU7SIRHXlU=;
  b=Xj1TPJNqQXig7ZutF8wBNRljTvtzbcEmgt1x5b0m58uSxAfYlvn2YC3X
   iw3ZhzzsSN1G56XNoztu0Zv2UA52vDlOg1g0UcD7/kRfzHFithmOh2MkZ
   0lS4JDyzz5yhJHo1SjD4wo052ECtxUZXMnxPsWxiQDd+HBuOexixsYHq8
   ZqTKQEvkEatliH8795qRKcI2sXff9N7wQZRP7KKQZ8yj+IOzumMdQn6bC
   CM0jk23DPPSRx2vaONhBfNgeY2mCMDcQmH12CDKaASKJew0fHdoYKPg4F
   m4sEipdE7Fk0Aj+agzGnIg8nNDKUebm0trgs9/tSKWRi6xAMxyDm/CzJD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="244018863"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="244018863"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 13:32:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="624619304"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2022 13:32:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 25 Jan 2022 13:32:32 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 25 Jan 2022 13:32:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 25 Jan 2022 13:32:31 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 25 Jan 2022 13:32:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzKw0yjhT76f3Pb83U34aEjODj0pteoZh8IOIN0B5AxAQH1AB+P7bUqOmXSAVgvlvn9cpLg1bVhMWB18q0tUEBof1esF6Eu1vqkm501LQ4mzZLECJrakrISWuPIrSomC2da39wBMfkD9AnWrun8pM0/bWYJy7FGROlN0Q1IvHqlLsBkQqFirln3/zVGgnd0u6kVzNnuZ/lvXL91wBlDGSknonp+EwCD/uFhmadlo/Vq0jD64YWGIJWcc1cow1Ob+BnNHSJPTo6dbiWYhuVN4tAIrfCCHSYopp3BsnZAXdvaB27YAs5YSZ0gvrM7yM8qmwYn0Zt3dIpgSyIGdIxZ41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5LPENhLa8K2Vxew+j5bR15ZNvXYDjL3ddU7SIRHXlU=;
 b=XYi3efUSfAWIEG7VFgfiDCaIjnzgHb8a9WEa0I0QdKgZtYpIqBEFAhuPptJD/BPyEz3GxfjXNv1E9ewhentcN+5UbDj23r58pbOYYCDxe+/k/+cGU6q7EVgIcnkSdm77YJ+pnk+dFU7Qvxsnka7dNPseRYY2IKru2ZjWI83WTSUIyTsdRiShitT1S4qeIW1g2btVTl6+z/yQqMh0MWFlW8Ujc7vGm/AVVXGGg4BJcZTYsFqCFwO7Fw5x3eQwf2yDOzAL0sIkf2vxg2y/bwgovxUHXQbJE1YYm4wkkJ7/kXQA5q6RQ5iRtiC/82wnpg+s0N5QvThJ3hcHkaMOHZm/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21)
 by DM6PR11MB3546.namprd11.prod.outlook.com (2603:10b6:5:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 25 Jan
 2022 21:32:17 +0000
Received: from MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::108d:94f3:cc9e:e64f]) by MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::108d:94f3:cc9e:e64f%4]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 21:32:16 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "karl.westin@loytec.com" <karl.westin@loytec.com>
CC:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Bluetooth Mesh: Option to retrieve RSSI value from received mesh
 messages
Thread-Topic: Bluetooth Mesh: Option to retrieve RSSI value from received mesh
 messages
Thread-Index: AdgR/qveFxHMZltZR7KeA1FkQqvEPgAJM5KAAAPizYA=
Date:   Tue, 25 Jan 2022 21:32:16 +0000
Message-ID: <9b716d8a604268a62b4f50662fd6f6c669e8d6ba.camel@intel.com>
References: <ZRAP278MB014417E1D86BB8D4E82A6174955F9@ZRAP278MB0144.CHEP278.PROD.OUTLOOK.COM>
         <586e79c74800693d1a21d06073503b41828f98bd.camel@intel.com>
In-Reply-To: <586e79c74800693d1a21d06073503b41828f98bd.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-2.fc34) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 464707be-9845-4aa8-2180-08d9e04a28e6
x-ms-traffictypediagnostic: DM6PR11MB3546:EE_
x-microsoft-antispam-prvs: <DM6PR11MB3546D794DD1EA0C9A370B6AEFB5F9@DM6PR11MB3546.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S4NnIaZGy/96nxfpobnhgYhAsf1nda+p/S9hBO+5Mn8zGVJK5+Wkq6aCwvFoXZvpxeBUTMz74ZMeWP7cgHCU97jIjmINUTYv5NZLaJdpNJ/g6+rU8MESNZzdBtGzWiuIlSwkeW8pOJTU3lFwwwkSeBstxZB41eDsdj+fjuVcmzJTMALxNDMLXhvlNoNMPvLpTEL9+KgOjGKfCD0aGbc6p8tspfNadwNrPyv+NjJugoZdqsxgNKzHeLKhGUxXmXvVHw3TyYO9kCAunNowXv32iJeAtvVepNitMIZDb1m7U0Sv6n+2BIUXBZ0ycByd/1yDqM6j1+13hUWIsv5j/bF3JdX7C+Hb0ouQ2vX7UoXYMopIjB0u7kxDHqArcOT4Skx/VY1MVXDqpz81ihOebRRf1w88XKZRZ0Az6wOeQl2z7OI+ynNdLSC+669yM8JQzyJV/bIih3FF2eZ6wdAHLUYkTkdi6WEwDYsG9k2X5SxniRrI/Ht4xTxQHV1yxPct7SNCqMKE6wbphPXRuQYfV5j9YB9eZCeLEE7wrvzOrs3nRmZx/QZKetGo1LmMZy4dAfqNhvh65XopLQFs5KtgbLosbEb0e4Z+0xjMkBEdSNVFTMZmE6RFPZSUFRPfIQge5DHWVM4hiLPfkqL7QlnFyCJFsd0z9mZhO49AW9chlizGwJX9n1lM2upxH7zGarYqC8wncLQsLE4Aj3KmJY2t6sXvXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4556.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(38070700005)(6486002)(2906002)(36756003)(8936002)(83380400001)(8676002)(82960400001)(2616005)(54906003)(86362001)(316002)(26005)(186003)(6506007)(6916009)(508600001)(76116006)(91956017)(66476007)(66946007)(66556008)(64756008)(66446008)(122000001)(38100700002)(6512007)(15650500001)(4326008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1NENDZoSVg5V1JWWE9GSXludmY0dmJoOEFKZVNEYUdXeVJ2cEdSU1FVTytH?=
 =?utf-8?B?NEFrc0JXdktNQVl0aks5VCtkWUNOZEtUcmVSRmJpTDZ0dHhjeWl2YXRiVm9K?=
 =?utf-8?B?MVlKTHNtZmVMdnpMZUUwTnp2RjM5SUNBUEU2ek4wTkNsZ2hIdDIxQ2tPLzZ4?=
 =?utf-8?B?M2t3NmtFc2VTSWZQNFl4ZGRPbURtdnVZWlJyMmhrUWVxSkJsY0w1R01KRlZH?=
 =?utf-8?B?NENQQmxVR3l1QStnRG5VM3hHZ1U3OW1xSjJ5ZnljYjdlMzcxNnpiVUVtTVVB?=
 =?utf-8?B?cHdoV2NDMVlxa0Qxa2MwL2ZMM2tCbk5zRFJjNjhCYmlmd1Zpbks5YURqNExs?=
 =?utf-8?B?YXhpY0RhOEtOcEVtcmUzUDRXMk1pS1BBUzRCS3E4eld6dHpVWGw3Mjd2bGRX?=
 =?utf-8?B?SjZqekhSTTIzVmxRZnNtTlhpZG00ZEIxSHVlY3kwa0FuNDFib1B2TjZQM29q?=
 =?utf-8?B?TUYrSGtkVmkzcDkzQ2U0V05pK0ltalJIYmpXZnpFQ21nY0h4VlJ4SElmMnVJ?=
 =?utf-8?B?ZllLMEV3WWw2K0dpUGp2SjMrRkd6MUJQQUd3QTRnUndWcEFMZTZoT3ZVZy9S?=
 =?utf-8?B?bVpJazJZTkNrbVFkN1lTUEpOcndRYjNlSjNyUkdYaUxjOTBRdVREOU1yMmM1?=
 =?utf-8?B?cFByNHExeXhNV203QWhGTUxuSnUvemlHSm1jMWJiQis3eXB3T1dlYjlYVFg1?=
 =?utf-8?B?VzYycnMxUjhhbk5zN0hmTlFtRytqckNrOGxDSjdGVDhwM1F3U3I5bFFQK2RQ?=
 =?utf-8?B?UnRqdVNOY3VMajVhbFF3RklXV0RtNklUOUNoRFFiUmJ3Sm5mVWcyclVqV3N1?=
 =?utf-8?B?VmhSL2pzTWc2SW5pMFpHUFcvWGRUUURjelQyRWNhQzh0elJ6TGN6R3pwZytH?=
 =?utf-8?B?QnhvRXZOOTJwRk1jSzM1aEk2bjZjLzlmMkplNEV3T3dyMGxNQ2ZrQlFXZjlK?=
 =?utf-8?B?emhZMHo3VldJRGZnQ0Jvckw1SmwvRzNoR2NpWEtEcTYrQmxOZys2Q0dGSzcv?=
 =?utf-8?B?ZWlPM0I0ZTdqV2JSTDdXbDlTcDM1bjIyb0F5ZDFFL0FabDFuREpYd0NHbzFM?=
 =?utf-8?B?azl2YVlBbEVNZE01MTNHdUg3MlcwQWVLaHlvd0dVdWR6NFk5dVo4UWFWYnJT?=
 =?utf-8?B?WmZuUU9saGVWTmN5SGFJdmNTS0dTRGVqcDZXUEE0REVtaWFjc3RvK2RFWUd0?=
 =?utf-8?B?VlhvUHl5OHNocHJLbDhPSy9xNEZpS25CNTBrSkdhV3RWanIxR0J6WVVjR1hq?=
 =?utf-8?B?VlhYSzliYjhOYlFLV0pYelB4QmFuQnlTbUJPb2RoQnpVdjFJSURGZjBNRU1w?=
 =?utf-8?B?MEJwaDdsdG9hbmlSMFI1bDA2YTlaQmlhQzJjdjYxM1F3NmhnZm1JZFp0UkIw?=
 =?utf-8?B?ZmlaN0JtRzBoTEl2d2RyM1N6SXJibGRZcklGNXFmQk9BaExwU2R3UUx5WDNa?=
 =?utf-8?B?LzdTR1JRbWsvM0svWi9VZ29JbG9OdjV1bEZuQVBwb0pNeWZXZGxCSzAvQm82?=
 =?utf-8?B?aTJGN2N6NlN3NlY1RGZKSU9Rek9uQlBHWHJmR00vYmd1SW0yaXphWFVnWlpn?=
 =?utf-8?B?UzdmTGdveXVNZVEwYW93aUxENlY0SVVLbkwvbkVtUTdVSnhmQUJPb1NSeGVK?=
 =?utf-8?B?bjZRRzRIaE4wTU9vMjBONFdiRmxvd0JKbUVrei8zVFdLVVY2OWFEejIxMFpq?=
 =?utf-8?B?N01sWkJCV01ia1VBbk9pWWVIV1NXVk53bmtnRXRUMHhFOTU3S2V1ckR1RU1B?=
 =?utf-8?B?SlY3RUVUQkZqdGdUY1d6VmxDTlA2VlZkTTJORnNmcWJrcXRmV3ZsMVdlNFJE?=
 =?utf-8?B?SmV5QVVja2xtNnJ5bGlINmZHS3lZLzcvSFdoL0I3VERmUytNRGVNaEVPaWV2?=
 =?utf-8?B?b3h3QXY3YnhtRjFqU0t5U3Nja21iLzI3UHF6UUx0STQ0cUc3WXRZbHhKZ0Mw?=
 =?utf-8?B?Q1B5dEFwb0RzbjI5TVplRXdKeHlpTXJseDdzN29ubWwzbVg4alJIYVZtcHla?=
 =?utf-8?B?V01DYXBpak04aG12NWJBZlFMV3dnMjNHMUZiUnJaKzUzUTBLcEhDZnNsZHN1?=
 =?utf-8?B?N2lldHVITDkvTjAvY0NyYmFNOWVnTmhLVXVHL1hCUFJ5MUwzN2s3aU9hdGZX?=
 =?utf-8?B?TlE5RUhONFRoMjJsVmZlQThOUTFPNDRWRHZwNnhoODEvZ3ExTnpqVS9pdG1F?=
 =?utf-8?Q?B73vPlFyj+KKsAIV2rurnhg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F99A2E5B4AF1F4EB8634A7AD5ABEF5F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4556.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464707be-9845-4aa8-2180-08d9e04a28e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 21:32:16.6913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lfuLv5qtVE4Kjnr4bN7Rqf99BZ+33pxXcq0cqNpddloSw8eOdSZzOTa5PiX8Xl9SAXka6aU+gzDgrM5hKYWCYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3546
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSXNhaywNCg0KT24gVHVlLCAyMDIyLTAxLTI1IGF0IDE5OjQxICswMDAwLCBHaXgsIEJyaWFu
IHdyb3RlOg0KPiBIaSBJc2FrLA0KPiANCj4gT24gVHVlLCAyMDIyLTAxLTI1IGF0IDE1OjIwICsw
MDAwLCBJc2FrIFdlc3RpbiB3cm90ZToNCj4gPiBIaSBhbGwsDQo+ID4gDQo+ID4gSW4gbXkgY29t
cGFueSB3ZSBhcmUgYnVpbGRpbmcgYSBCbHVldG9vdGggTWVzaCBhcHBsaWNhdGlvbiBvbiB0b3AN
Cj4gPiBvZiB0aGUgYmx1ZXRvb3RoLW1lc2ggZGFlbW9uLCB1c2luZyB0aGUNCj4gPiBEQlVTIGlu
dGVyZmFjZS4NCj4gPiBXZSB3YW50IHRvIHVzZSB0aGUgUlNTSSB2YWx1ZSBvZiBtZXNoIG1lc3Nh
Z2VzIHJlY2VpdmVkIGZyb20NCj4gPiBwcm92aXNpb25lZCBub2RlcyBhcyBwYXJ0IG9mIGV2YWx1
YXRpbmcgdGhlDQo+ID4gZ2VuZXJhbCBxdWFsaXR5IG9mIGEgYmlnZ2VyIG1lc2ggbmV0d29yay4g
QWxzbywgZS5nLiB0byBkZWNpZGUNCj4gPiB3aGljaCBub2RlcyBzaG91bGQgaGF2ZSB0aGUgcmVs
YXkgZmVhdHVyZQ0KPiA+IGVuYWJsZWQuDQo+ID4gVGhlIFJTU0kgdmFsdWUgaXMgZGVsaXZlcmVk
IGluIHRoZSBMRSBBZHZlcnRpc2luZyBSZXBvcnRzIHZpYSBIQ0ksDQo+ID4gYnV0IHRoZXJlIHNl
ZW1zIHRvIGJlIG5vIHdheSB0byBtYWtlIHRoZQ0KPiA+IGRhZW1vbiBwYXNzIHRoaXMgaW5mb3Jt
YXRpb24gZnVydGhlciB0byB0aGUgYXBwbGljYXRpb24uDQo+ID4gDQo+IA0KPiBUaGUgb25seSBt
ZXNzYWdlcyBjdXJyZW50bHkgd2l0aCBSU1NJIHByb3BhZ2F0ZWQgdXAgdG8gdGhlDQo+IGFwcGxp
Y2F0aW9uIGFyZSB0aGUgVW5wcm92aXNpb25lZCBCZWFjb25zLCB3aGljaCBhcmUNCj4gdXNlZCB0
byBpbmRpY2F0ZSBzaWduYWwgbGV2ZWwgb2YgZGV2aWNlcyBzZWVraW5nIHRvIGJlIHByb3Zpc2lv
bmVkLsKgDQo+IFRoZSBSU1NJIG1lYXN1cmVtZW50IGlzIHJlYWxseSBvbmx5IHVzZWZ1bA0KPiBm
b3IgZGV0ZXJtaW5pbmcgc2lnbmFsIHN0cmVuZ3RoIG9mIGRpcmVjdCBuZWlnaGJvcnMsIG9yIHRo
ZSAibGFzdA0KPiBob3AiIG9mIGEgbWVzaCBwYXRoLCBzbyBmcm9tIGEgcGVyc3BlY3RpdmUgb2YN
Cj4gbWVhc3VyaW5nIHRoZSBsYXJnZXIgcXVhbGl0eSBvZiB0aGUgbWVzaCBuZXR3b3JrLCBpdCB3
b24ndCByZWFsbHkNCj4gdGVsbCB5b3Ugd2hhdCB5b3UgYXJlIGxvb2tpbmcgZm9yLg0KDQpNYXli
ZSBIZWFydGJlYXQgcHViL3N1YiBtZWNoYW5pc20gd291bGQgYmUgbW9yZSB1c2VmdWwgd2hlbiBh
bmFseXNpbmcNCnRoZSB0b3BvbG9neSBvZiBhIG1lc2ggbmV0d29yaz8NClNwZWNpZmljYWxseSwg
a2VlcGluZyB0cmFjayBvZiBtaW4vbWF4IGhvcCB2YWx1ZXMgcmVjZWl2ZWQgb24gdGhlDQpzdWJz
Y3JpYmVyJ3Mgc2lkZS4NCg0KDQo+IA0KPiA+IElzIHRoZXJlIGFuIGVhc3kgd2F5LCB0aGF0IEkg
aGF2ZSBtaXNzZWQsIHRvIGdldCB0aGUgUlNTSSB2YWx1ZXMNCj4gPiBmb3IgcmVjZWl2ZWQgbWVz
aCBtZXNzYWdlcz8gSWYgbm90LCB3aGF0IGFyZQ0KPiA+IHlvdXIgdGhvdWdodHMgYWJvdXQgbWFr
aW5nIHRoZSBpbmZvcm1hdGlvbiBhdmFpbGFibGUgc29tZWhvdywNCj4gPiBwZXJoYXBzIGFzIHBh
cnQgb2YgdGhlIERCVVMgbWV0aG9kcw0KPiA+IE1lc3NhZ2VSZWNlaXZlZCBhbmQgRGV2S2V5TWVz
c2FnZVJlY2VpdmVkPw0KPiANCj4gQSB0b29sIHRoYXQgbWVhc3VyZXMgdGhlIHNpZ25hbCBzdHJl
bmd0aCBvZiBlYWNoIGhvcCB3b3VsZCByZXF1aXJlDQo+IG5vdCBvbmx5IERCdXMgQVBJIGNoYW5n
ZXMsIGJ1dCBhbHNvIGEgVmVuZGVyDQo+IHN0eWxlIGFwcGxpY2F0aW9uIHRoYXQgcmVzaWRlcyBv
biBlYWNoIG5vZGUsIGFuZCBjb2xsZWN0cw0KPiBtZWFzdXJlbWVudHMsIGZvcndhcmRpbmcgdGhl
bSB0byBhIGNlbnRyYWwgZGF0YQ0KPiBjb2xsZWN0aW9uIHBvaW50LsKgIFRoaXMgd291bGQgcmVx
dWlyZSBjb250cm9sbGluZyB0aGUgc29mdHdhcmUgb2YNCj4gKmV2ZXJ5KiBub2RlIGluIHRoZSBt
ZWFzaCBuZXR3b3JrLCBtYWtpbmcgaXQNCj4gaW1wcmFjdGljYWwgZm9yIGFuIGVuZCBjdXN0b21l
ciBzZXR1cCB0aGF0IGhhcyBub2RlcyBmcm9tIG11bHRpcGxlDQo+IG1hbnVmYWN0dXJlcnMuDQo+
IA0KPiA+IA0KPiA+IFRoYW5rIHlvdSBhbmQgYmVzdCByZWdhcmRzLA0KPiA+IElzYWsNCj4gPiAN
Cj4gDQo+IC0tQnJpYW4NCg0K
