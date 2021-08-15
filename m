Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46AEC4338F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Aug 2021 23:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FBD461267
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Aug 2021 23:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhHOXag (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Aug 2021 19:30:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:19036 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230509AbhHOXaf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Aug 2021 19:30:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10077"; a="215801845"
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="215801845"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 16:30:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="530112061"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 15 Aug 2021 16:30:02 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 15 Aug 2021 16:30:02 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 15 Aug 2021 16:30:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Sun, 15 Aug 2021 16:30:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sun, 15 Aug 2021 16:30:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0F60D4bcNZqXEW6tyyp1wDFLz/CyxlfAew3P4JVLoW2STd4r70Pf0OttNdV2vFmZnyKIiaTLJ6FNWSLm1U17kzfEkhOISH96b9Eg/KcHxSbv5u+c8xTg5+pboSOuMzFpJXG8hrrPFSXH1FG4rQynI/NU5FqDn3y2XEJJVKa/c7irfmRJO8PMKq0CpCJm6pubQiPmfHbEXg/gUEdVpFGB3/1dd5Fxjm7rZRHMQ5lwdJDVbR1WPSyFNky77KwbF5Gc1TxSnUvlqmlCsr74pX8hYFV2HGYbRb1rNbHZoUa/vv7TE48kkIpyaxDC2k9QjiK7ywg/o2BAJYQL8Qc6B/TzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1qRWddJ5CyHYMU4NeDYS4cEAGj895NuYB/N1kHfUYY=;
 b=T17QTuvSVdbEC/sf+0qDjw66f8tvOOtY3wg3JTzK/17n+TD+NFVNXja8j9SRX9eC2llcWwa9gMUsjjyo8AmMsbTBHCpSCckYigkaD0Q3WrnGHbtA0lFZ+C6/yf64kKfzU/n89dX//Rn1MWKL+c1E5G7uS2h97E2zF7XlXR1z3noIj10gYMiQFH/C3noTiVw3VXQrvtHobMXXc9K1omab4XJZgOZM2diIpAIp7EXWLkJ56aNoXo6iuO7jOSFTTRG25SXxkF58unxMSSlTx7VoYxjDhG1XajxnRz3m7dEDnG1mpHa2fsEPeBlt2Hi2AtDIL+xhQ0Flb/SBmpDOK1GE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1qRWddJ5CyHYMU4NeDYS4cEAGj895NuYB/N1kHfUYY=;
 b=x8GNvNECkoki+UMyBPsRLFftC0qB6vl0AzakffTG2byyqo0qy3F3ged0fBbBzrSUEWTIEKFdpGyc84IxZhpCoHRGohl1Zz5rAewTfflx3ea30jPFk7tYp7pyPk+7he6RHCdEIlGi5+63JAPWmtuApAtqxwwYFPqdTuse+3U2oZY=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.13; Sun, 15 Aug 2021 23:29:58 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::c134:db0a:48b:a88c]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::c134:db0a:48b:a88c%3]) with mapi id 15.20.4415.023; Sun, 15 Aug 2021
 23:29:58 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Manish Mandlik <mmandlik@google.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     Marcel Holtmann <marcel@holtmann.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v1] Bluetooth: Fix race condition in handling NOP command
Thread-Topic: [PATCH v1] Bluetooth: Fix race condition in handling NOP command
Thread-Index: AQHXiVcmy61Y/5HvckOI5dFZpf8b3qtk5AYAgAGqIMCACS/vsIAAbueAgAH8KICAAx010A==
Date:   Sun, 15 Aug 2021 23:29:58 +0000
Message-ID: <DM8PR11MB557359E9CD3FF7D6D4D1EEF1F5FC9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210804173939.25496-1-kiran.k@intel.com>
 <CB7F6AB9-E997-4C77-B19D-D018F8044001@holtmann.org>
 <DM8PR11MB55738B15758672E2982D748AF5F39@DM8PR11MB5573.namprd11.prod.outlook.com>
 <DM8PR11MB55733AD00D7FB779732063B4F5F99@DM8PR11MB5573.namprd11.prod.outlook.com>
 <CABBYNZJNruwiLRZSsTzeSZzL4O2u-zpUCAOc=JgAPk0H3UHUUg@mail.gmail.com>
 <CAGPPCLDsqa6Ae3rMOXaVAOsnvPTF3b-5ybdPbD2LptcMaCfhWA@mail.gmail.com>
In-Reply-To: <CAGPPCLDsqa6Ae3rMOXaVAOsnvPTF3b-5ybdPbD2LptcMaCfhWA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c776e6a7-17cc-4b5e-d534-08d9604498a5
x-ms-traffictypediagnostic: DM8PR11MB5653:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB565337DD7A4BE39D2B6FB66CF5FC9@DM8PR11MB5653.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qQk/eXy2xEPsCLePIG2RXHkoYD8fWAVKlBQ3Suk/kyOtdTw5MHhvfG2FSS/q6zB7UzkBMLgb9AxjxtEufDHE7v6G7LEdjq+lcWXxtGd58LRrznvsEOUsc/Gtc8E1TQLycRDJx/sqarE/8QYo7ce2rLxCadmTblP+13mFHPMYd2Iyi/h2kTumQLQWJy0Y0+3kArP2xzsH42uocG0oN8+9JN2z+odX2gvoZ+SIZX61hzfiJ7C970tyVCXULwFTbJhuT0kcnMHP5OnI5bfxltE4ISYNrvkd2kQT6e+UTUAVqVbmykXsCa33mTKLxJe50lYX5zV801OVHy3n/o0Quk4cQ3JDTqNvSLikp1KBuqYGbrdp0u47YX42tzP+ZFljOMXr2V8KI1pzvaDLAqaX9MoGkzoTaGGEDUUU7BW8b1nZQmCOL2dj0aJWq7hWMa0AObWTlWEEEDkDrV+iMivTx9h9Jy6J3KNC//ujqDp68mkYBFLKX2uNPC2RkGXQcwhz2h791eFTX0fo72VIPaHWUYFKc1hy6zykIA/FN/rqY5KM3mjiOpWNas34uzpzSkcSSBCWj1PfHwFrx4cIokG2q1y1595MLuAlTrAQQoVT1s7GPBsto48Iw8Dh/B3rwBatCYyWJ7KMofsB2xcY/0pVTIKBoldj/4mFa/GMv/uUkb+255gALXu7k5zQ7SHs9/RP3ATuIMZLs6YoUjLsn9oVC5Zt2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(7696005)(64756008)(66556008)(66476007)(53546011)(66446008)(8676002)(66946007)(122000001)(9686003)(55016002)(38100700002)(52536014)(478600001)(6506007)(33656002)(76116006)(8936002)(86362001)(110136005)(54906003)(186003)(71200400001)(2906002)(4326008)(107886003)(5660300002)(83380400001)(316002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1pkeHUzdTc3Q3R4dlI1RjdhMUFhYjlsYzJUYkpQNTVpd1MwY3lYdi9EQzBN?=
 =?utf-8?B?K1BTcjVYZit2bGdvSzBYVlIwdU9yRjJiOVR6WHh4SnVwTXo5YjR1MWdFNitK?=
 =?utf-8?B?Y1lBQisvOC8wUkVucGYvNWJRT1ZhWGErd1JGYXJKVVdmU3NNbDlZNFJwTG9h?=
 =?utf-8?B?ekYvQ0I2K3JYc1ZLaUFlWVIybnFuWmY2c0oyZDZWY0o2Y0tjbmR2T2JnREFQ?=
 =?utf-8?B?ajhXSGFOVlFxNlQxSjRxTE9aU1pQRWpMNGd5YTkxLzh4NWFDKy9hTjcxNCsz?=
 =?utf-8?B?VGt1TkdrekZTTk5aelRHS2ZzNnE5Nit0UzZXQ2NXWFZ2OUFVaTB0WkhrTTBk?=
 =?utf-8?B?dk1NVk53N09FZTJSaENaVzQ2OWowWlVjZndjOTdmRWhPengvQ1JLbFFBUFBq?=
 =?utf-8?B?YTdjeVRxdVNiRUExVjE0enJiWlVHY2szRlFRQkovTk4rQ29WZzB6YXFTM2Rr?=
 =?utf-8?B?b09ETSszSHpVY0JDd1FMaDJ5TlcxUGJ2eU5wSHFYU1NHREpvZlUvdFc1NlRk?=
 =?utf-8?B?bkVma1I0NW00R2ZaekZvcWJ1OG9IODFmc2M2SWV0dEVJUkg5M1d5TzlndVc3?=
 =?utf-8?B?OFdodHY4RUVTbVN1YTRYN044TGlxbjFmWDBaMVJ2VDR2K0Jnb2xCN1k2TFhC?=
 =?utf-8?B?Ync3SW4rdnJSQVRxQTVvL21jbFNOZFphWEo1UVRObWdFYzEySlZnVlBUSXRw?=
 =?utf-8?B?VHlWMWJqeXdCcVdZUk5xYzBzMVdITE1sbUtCR0t4RElrR25waGNkYmY3UFVo?=
 =?utf-8?B?VVNlbUxOd0Y0Yy9KOEEzak9QaVJlaDl0bzNadDg2amlmZW9jbWhpaTdjVExJ?=
 =?utf-8?B?aTA4OFJXa080RXZmUFMyWHlmeTJnNFA4Qis4cWdFbUZUM3NZYUZVcmprc05o?=
 =?utf-8?B?KzlDeHBsY3ZqUlpxbHN1b0QxVUd1RHBXRVZxQlQrZktaTmxGQmNHb3A4akFQ?=
 =?utf-8?B?YjVCekRnY1IwbGlpenROeUJKYVpwblIxYS9yc0IxNnltSTdpODBxaDNTNi9R?=
 =?utf-8?B?VTRkZ1VtbU5QY2dkQXBGVTZDUXpUTE1lSEQ1NlA2MksxdVZIZUJTUzIwT1NU?=
 =?utf-8?B?T24rWENNamdsSUVGYTZyOTlldHNLTCtzY0s4N1lXb3pzOEkwQXB5ejhoNHk2?=
 =?utf-8?B?elNDRS8wdTJralVNVDVaK3FkYmw2NEp3ZFI5bzBIUEZhZ0MwL3R1WEFFYVNp?=
 =?utf-8?B?WmVZZFZGNnV5WG9Yd3o4UHV6cnZuMTYvd3JYdnJVRFE5azdtOUovTS9TcDFK?=
 =?utf-8?B?ZGFiWkY3VFFpZzZxMGVHUGl4R1N3am94a2Y5NjU4Ukl3VnRtQ2NFSTRrUFY3?=
 =?utf-8?B?azVKOHhvNXdTQ2lnTDl6YVM5TE9hdVQ1RWl0bUVyMEdIZEo5dnJoL0JJZk5Z?=
 =?utf-8?B?SnROajFIdjlPQkYzdjdSODFyUWRmNHZSTm54T1pwQXUzVy9FWXYvVzUrSllI?=
 =?utf-8?B?MHI2bldwWjB0ZEcwMFhkUy9uK2dkVFdhRmdFVHBhaE9wZFFHN1J0WlA4U1Ja?=
 =?utf-8?B?SG1kaGRQaGNLMGFYRWo1dHI5cVBpV3NmNFVyVnVVZm5sUjZwUTZjVTBwbkdU?=
 =?utf-8?B?emNZTGN1ZnhqRExRL29KQ3hZNmdWSHAzQi95eGwzVWxLNkt2NHRmamVESWtm?=
 =?utf-8?B?dWhtUmNSTU1qQXRDa3ZySldJNDFlQXpYTi9uM2F1dWJLcmtKb0tRenoveGpG?=
 =?utf-8?B?RVRiZFlhdUVTaGpPQU5pbXVvTU1KWi9oMGhWdk1zRHFvaVFmY1NESVZYY3hY?=
 =?utf-8?B?TURVOFB0MmN2YXVLU29EM0IyeUdwZXVaN09pZ0NzdWtSZFZ3Vkxhc3A2cjN5?=
 =?utf-8?B?TEI5YVZGYU5rSUM2R3dXOGRPbEppeU1NYTFZVVppdmh1SEhYekh1YWNyTTN5?=
 =?utf-8?Q?3gemH9eFJsykV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c776e6a7-17cc-4b5e-d534-08d9604498a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2021 23:29:58.3837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u3QRCjUqAyQa2dlIGUkATCe5fQp8bRSG/v8XsWNX1qoJPes74FURkU7whA0m0crfgduTxPKKM9CX4zhwVPnWGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5653
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFuaXNoLCANCj4gDQo+IEZyb206IE1hbmlzaCBNYW5kbGlrIDxtbWFuZGxpa0Bnb29nbGUu
Y29tPiANCj4gU2VudDogU2F0dXJkYXksIEF1Z3VzdCAxNCwgMjAyMSA1OjIwIEFNDQo+IFRvOiBM
dWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4gQ2M6IEssIEtp
cmFuIDxraXJhbi5rQGludGVsLmNvbT47IE1hcmNlbCBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5u
Lm9yZz47IEJsdWVaIDxsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnPjsgU3JpdmF0c2Es
IFJhdmlzaGFua2FyIDxyYXZpc2hhbmthci5zcml2YXRzYUBpbnRlbC5jb20+OyBUdW1rdXIgTmFy
YXlhbiwgQ2hldGhhbiA8Y2hldGhhbi50dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjFdIEJsdWV0b290aDogRml4IHJhY2UgY29uZGl0aW9uIGluIGhhbmRs
aW5nIE5PUCBjb21tYW5kDQo+IA0KPiBIaSBMdWl6LA0KPiANCj4gVGhpcyBwYXRjaCBsb29rcyBv
ayB0byBtZSwgaXQnbGwgbm90IGJyZWFrIG5jbWQgdGltZW91dCBoYW5kbGluZy4gDQo+IA0KPiBA
S2lyYW46IEp1c3Qgb25lIG5pdCBvbiB0aGUgcGF0Y2g6IHdlIGNhbiBnZXQgcmlkIG9mIHRoZSBh
cmd1bWVudCAndTE2IG9wY29kZScgb2YgdGhlIGZ1bmN0aW9uICdoYW5kbGVfY21kX2NudF9hbmRf
dGltZXIoKScgYXMgaXQgd29uJ3QgYmUgdXNlZCBhbnltb3JlIGluIHRoaXMgY2FzZS4NCg0KVGhh
bmtzIGZvciB0aGUgY29tbWVudC4gSSBmaXggYW5kIHNlbmQgb3V0IGFuIHVwZGF0ZWQgdmVyc2lv
bi4NCj4gDQo+IFJlZ2FyZHMsDQo+IE1hbmlzaC4NCj4gDQo+IA0KPiBPbiBUaHUsIEF1ZyAxMiwg
MjAyMSBhdCAxMDozMSBBTSBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxtYWlsdG86bHVpei5kZW50
ekBnbWFpbC5jb20+IHdyb3RlOg0KPiBIaSBNYW5pc2gsDQo+IA0KPiBPbiBUaHUsIEF1ZyAxMiwg
MjAyMSBhdCAzOjU4IEFNIEssIEtpcmFuIDxtYWlsdG86a2lyYW4ua0BpbnRlbC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gSGkgTWFyY2VsLA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+ID4gRnJvbTogSywgS2lyYW4NCj4gPiA+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDYs
IDIwMjEgODoxNCBQTQ0KPiA+ID4gVG86ICdNYXJjZWwgSG9sdG1hbm4nIDxtYWlsdG86bWFyY2Vs
QGhvbHRtYW5uLm9yZz4NCj4gPiA+IENjOiBCbHVlWiA8bWFpbHRvOmxpbnV4LWJsdWV0b290aEB2
Z2VyLmtlcm5lbC5vcmc+OyBTcml2YXRzYSwgUmF2aXNoYW5rYXINCj4gPiA+IDxtYWlsdG86cmF2
aXNoYW5rYXIuc3JpdmF0c2FAaW50ZWwuY29tPjsgVHVta3VyIE5hcmF5YW4sIENoZXRoYW4NCj4g
PiA+IDxtYWlsdG86Y2hldGhhbi50dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+DQo+ID4gPiBTdWJq
ZWN0OiBSRTogW1BBVENIIHYxXSBCbHVldG9vdGg6IEZpeCByYWNlIGNvbmRpdGlvbiBpbiBoYW5k
bGluZyBOT1ANCj4gPiA+IGNvbW1hbmQNCj4gPiA+DQo+ID4gPiBIaSBNYXJjZWwsDQo+ID4gPg0K
PiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiBGcm9tOiBNYXJjZWwg
SG9sdG1hbm4gPG1haWx0bzptYXJjZWxAaG9sdG1hbm4ub3JnPg0KPiA+ID4gPiBTZW50OiBUaHVy
c2RheSwgQXVndXN0IDUsIDIwMjEgNjo0MSBQTQ0KPiA+ID4gPiBUbzogSywgS2lyYW4gPG1haWx0
bzpraXJhbi5rQGludGVsLmNvbT4NCj4gPiA+ID4gQ2M6IEJsdWVaIDxtYWlsdG86bGludXgtYmx1
ZXRvb3RoQHZnZXIua2VybmVsLm9yZz47IFNyaXZhdHNhLCBSYXZpc2hhbmthcg0KPiA+ID4gPiA8
bWFpbHRvOnJhdmlzaGFua2FyLnNyaXZhdHNhQGludGVsLmNvbT47IFR1bWt1ciBOYXJheWFuLCBD
aGV0aGFuDQo+ID4gPiA+IDxtYWlsdG86Y2hldGhhbi50dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+
DQo+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIEJsdWV0b290aDogRml4IHJhY2UgY29u
ZGl0aW9uIGluIGhhbmRsaW5nIE5PUA0KPiA+ID4gPiBjb21tYW5kDQo+ID4gPiA+DQo+ID4gPiA+
IEhpIEtpcmFuLA0KPiA+ID4gPg0KPiA+ID4gPiA+IEZvciBOT1AgY29tbWFuZCwgbmVlZCB0byBj
YW5jZWwgd29yayBzY2hlZHVsZWQgb24gY21kX3RpbWVyLCBvbg0KPiA+ID4gPiA+IHJlY2Vpdmlu
ZyBjb21tYW5kIHN0YXR1cyBvciBjb21tbWFuZCBjb21wbGV0ZSBldmVudC4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IEJlbG93IHVzZSBjYXNlIG1pZ2h0IGxlYWQgdG8gcmFjZSBjb25kaXRpb24gbXVs
dGlwbGUgd2hlbiBOT1ANCj4gPiA+ID4gPiBjb21tYW5kcyBhcmUgcXVldWVkIHNlcXVlbnRpYWxs
eToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGhjaV9jbWRfd29yaygpIHsNCj4gPiA+ID4gPiAgIGlm
IChhdG9taWNfcmVhZCgmaGRldi0+Y21kX2NudCkgew0KPiA+ID4gPiA+ICAgICAgICAgICAgLg0K
PiA+ID4gPiA+ICAgICAgICAgICAgLg0KPiA+ID4gPiA+ICAgICAgICAgICAgLg0KPiA+ID4gPiA+
ICAgICAgYXRvbWljX2RlYygmaGRldi0+Y21kX2NudCk7DQo+ID4gPiA+ID4gICAgICBoY2lfc2Vu
ZF9mcmFtZShoZGV2LC4uLik7DQo+ID4gPiA+ID4gICAgICBzY2hlZHVsZV9kZWxheWVkX3dvcmso
JmhkZXYtPmNtZF90aW1lciwuLi4pOw0KPiA+ID4gPiA+ICAgfQ0KPiA+ID4gPiA+IH0NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IE9uIHJlY2VpdmluZyBldmVudCBmb3IgZmlyc3QgTk9QLCB0aGUgd29y
ayBzY2hlZHVsZWQgb24NCj4gPiA+ID4gPiBoZGV2LT5jbWRfdGltZXIgaXMgbm90IGNhbmNlbGxl
ZCBhbmQgIHNlY29uZCBOT1AgaXMgZGVxdWV1ZWQgYW5kDQo+ID4gPiA+ID4gaGRldi0+c2VudA0K
PiA+ID4gPiB0byBjb250cm9sbGVyLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2hpbGUgd2FpdGlu
ZyBmb3IgYW4gZXZlbnQgZm9yIHNlY29uZCBOT1AgY29tbWFuZCwgd29yayBzY2hlZHVsZWQgb24N
Cj4gPiA+ID4gPiBjbWRfdGltZXIgZm9yIGZpcnN0IE5PUCBjYW4gZ2V0IHNjaGVkdWxlZCwgcmVz
dWx0aW5nIGluIHNlbmRpbmcNCj4gPiA+ID4gPiB0aGlyZCBOT1AgY29tbWFuZCBub3Qgd2FpdGlu
ZyBmb3IgYW4gZXZlbnQgZm9yIHNlY29uZCBOT1AuIFRoaXMNCj4gPiA+ID4gPiBtaWdodCBjYXVz
ZSBpc3N1ZXMgYXQgY29udHJvbGxlciBzaWRlIChsaWtlIG1lbW9yeSBvdmVycnVuLA0KPiA+ID4g
PiA+IGNvbnRyb2xsZXIgZ29pbmcNCj4gPiA+ID4gPiB1bnJlc3BvbnNpdmUpIHJlc3VsdGluZyBp
biBoY2kgdHggdGltZW91dHMsIGhhcmR3YXJlIGVycm9ycyBldGMuDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBLaXJhbiBLIDxtYWlsdG86a2lyYW4ua0BpbnRlbC5jb20+DQo+
ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IENoZXRoYW4gVCBOIDxtYWlsdG86Y2hldGhhbi50dW1rdXIu
bmFyYXlhbkBpbnRlbC5jb20+DQo+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IFNyaXZhdHNhIFJhdmlz
aGFua2FyIDxtYWlsdG86cmF2aXNoYW5rYXIuc3JpdmF0c2FAaW50ZWwuY29tPg0KPiA+ID4gPiA+
IC0tLQ0KPiA+ID4gPiA+IG5ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMgfCAzICstLQ0KPiA+ID4g
PiA+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2hjaV9ldmVudC5jIGIv
bmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYw0KPiA+ID4gPiA+IGluZGV4IGVhN2ZjMDk0NzhiZS4u
MTRkZmJkYzhiODFiIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL25ldC9ibHVldG9vdGgvaGNpX2V2
ZW50LmMNCj4gPiA+ID4gPiArKysgYi9uZXQvYmx1ZXRvb3RoL2hjaV9ldmVudC5jDQo+ID4gPiA+
ID4gQEAgLTMyNzEsOCArMzI3MSw3IEBAIHN0YXRpYyB2b2lkIGhjaV9yZW1vdGVfZmVhdHVyZXNf
ZXZ0KHN0cnVjdA0KPiA+ID4gPiA+IGhjaV9kZXYgKmhkZXYsIHN0YXRpYyBpbmxpbmUgdm9pZCBo
YW5kbGVfY21kX2NudF9hbmRfdGltZXIoc3RydWN0DQo+ID4gPiA+ID4gaGNpX2Rldg0KPiA+ID4g
PiAqaGRldiwNCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHUxNiBvcGNvZGUsIHU4IG5jbWQpDQo+ID4gPiA+ID4gew0KPiA+ID4gPiA+IC0gaWYgKG9wY29k
ZSAhPSBIQ0lfT1BfTk9QKQ0KPiA+ID4gPiA+IC0gICAgICAgICBjYW5jZWxfZGVsYXllZF93b3Jr
KCZoZGV2LT5jbWRfdGltZXIpOw0KPiA+ID4gPiA+ICsgY2FuY2VsX2RlbGF5ZWRfd29yaygmaGRl
di0+Y21kX3RpbWVyKTsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAgaWYgKCF0ZXN0X2JpdChIQ0lf
UkVTRVQsICZoZGV2LT5mbGFncykpIHsNCj4gPiA+ID4gPiAgICAgICAgICAgaWYgKG5jbWQpIHsN
Cj4gPiA+ID4NCj4gPiA+ID4gc28gdGhpcyBpcyBjb25mbGljdGluZyB3aXRoIHRoZSBwYXRjaCBp
bnRyb2R1Y2luZyB0aGUgbmNtZCB0aW1lb3V0IGhhbmRsaW5nLg0KPiA+ID4gPg0KPiA+ID4gTXkg
cGF0Y2ggc3BlY2lmaWNhbGx5IGFkZHJlc3NlcyB0aGUgaXNzdWUgb2JzZXJ2ZWQgaW4gY2FzZSBv
ZiBOT1AgY29tbWFuZC4NCj4gPiA+IEl0IHByZXZlbnRzIHRoZSBpc3N1ZSBieSBoYW5kbGluZyBO
T1Agc2FtZSBhcyBhbnkgb3RoZXIgU0lHIGNvbW1hbmQuDQo+ID4gPg0KPiA+ID4gSXQgbG9va3Mg
Y29tbWl0IGRlNzVjZDBkOWIyZjMyNTBkNWYyNTg0NmJiNTYzMmNjY2U2Mjc1ZjQgdHJpZXMgdG8N
Cj4gPiA+IHJlY292ZXIgd2hlbiBjb250cm9sbGVyIGdvZXMgYmFkLg0KPiA+ID4NCj4gPg0KPiA+
IERvIHlvdSBoYXZlIGFueSBmdXJ0aGVyIGNvbW1lbnRzIGhlcmUgPyBXYWl0aW5nIGZvciB5b3Vy
IGlucHV0Lg0KPiA+DQo+ID4gPiA+IGNvbW1pdCBkZTc1Y2QwZDliMmYzMjUwZDVmMjU4NDZiYjU2
MzJjY2NlNjI3NWY0DQo+ID4gPiA+IEF1dGhvcjogTWFuaXNoIE1hbmRsaWsgPG1haWx0bzptbWFu
ZGxpa0Bnb29nbGUuY29tPg0KPiA+ID4gPiBEYXRlOiAgIFRodSBBcHIgMjkgMTA6MjQ6MjIgMjAy
MSAtMDcwMA0KPiA+ID4gPg0KPiA+ID4gPiAgICAgQmx1ZXRvb3RoOiBBZGQgbmNtZD0wIHJlY292
ZXJ5IGhhbmRsaW5nDQo+ID4gPiA+DQo+ID4gPiA+ICAgICBEdXJpbmcgY29tbWFuZCBzdGF0dXMg
b3IgY29tbWFuZCBjb21wbGV0ZSBldmVudCwgdGhlIGNvbnRyb2xsZXINCj4gPiA+ID4gbWF5IHNl
dA0KPiA+ID4gPiAgICAgbmNtZD0wIGluZGljYXRpbmcgdGhhdCBpdCBpcyBub3QgYWNjZXB0aW5n
IGFueSBtb3JlIGNvbW1hbmRzLiBJbiBzdWNoIGENCj4gPiA+ID4gICAgIGNhc2UsIGhvc3QgaG9s
ZHMgb2ZmIHNlbmRpbmcgYW55IG1vcmUgY29tbWFuZHMgdG8gdGhlIGNvbnRyb2xsZXIuIElmIHRo
ZQ0KPiA+ID4gPiAgICAgY29udHJvbGxlciBkb2Vzbid0IHJlY292ZXIgZnJvbSBzdWNoIGNvbmRp
dGlvbiwgaG9zdCB3aWxsIHdhaXQgZm9yZXZlciwNCj4gPiA+ID4gICAgIHVudGlsIHRoZSB1c2Vy
IGRlY2lkZXMgdGhhdCB0aGUgQmx1ZXRvb3RoIGlzIGJyb2tlbiBhbmQgbWF5IHBvd2VyIGN5Y2xl
cw0KPiA+ID4gPiAgICAgdGhlIEJsdWV0b290aC4NCj4gPiA+ID4NCj4gPiA+ID4gICAgIFRoaXMg
cGF0Y2ggdHJpZ2dlcnMgdGhlIGhhcmR3YXJlIGVycm9yIHRvIHJlc2V0IHRoZSBjb250cm9sbGVy
IGFuZA0KPiA+ID4gPiAgICAgZHJpdmVyIHdoZW4gaXQgZ2V0cyBpbnRvIHN1Y2ggc3RhdGUgYXMg
dGhlcmUgaXMgbm8gb3RoZXIgd2F0IG91dC4NCj4gPiA+ID4NCj4gPiA+ID4gTm93aGVyZSBpbiB5
b3VyIGNvbW1pdCBkZXNjcmlwdGlvbiB5b3UgYXJlIGFkZHJlc3Npbmcgd2h5IGlzIHRoaXMgdGhl
DQo+ID4gPiA+IHJpZ2h0IHRvIGRvLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFdpbGwgZml4IGl0
IGluIHRoZSBuZXh0IHZlcnNpb24gaWYgeW91IGFyZSBPSyB3aXRoIHRoZSBjdXJyZW50IGZpeC4g
UGxlYXNlIGxldCBtZQ0KPiA+ID4ga25vdy4NCj4gDQo+IENhbiB5b3UgY29uZmlybSB0aGlzIGNo
YW5nZSBkb2Vzbid0IGJyZWFrIHlvdXIgcGF0Y2ggYWJvdmU/DQo+IA0KPiA+ID4NCj4gPiA+ID4g
UmVnYXJkcw0KPiA+ID4gPg0KPiA+ID4gPiBNYXJjZWwNCj4gPiA+DQo+ID4gPiBUaGFua3MsDQo+
ID4gPiBLaXJhbg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEtpcmFuDQo+ID4NCj4gPg0KPiANCj4g
DQo+IC0tIA0KPiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQo+DQoNClJlZ2FyZHMsDQpLaXJhbg0K
DQo=
