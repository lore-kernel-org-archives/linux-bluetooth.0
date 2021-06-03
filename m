Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0E4C47096
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 13:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54035613E9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 13:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFCNae (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 09:30:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:49613 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhFCNad (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 09:30:33 -0400
IronPort-SDR: o8py901kDulXCn8Ojl2iRw3Jox2SG5cWlorGMN75/4/AGwwFnCeiTRzGbspEPWVbOwIEAvm7P/
 h5oRqIwvKwbQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="202183250"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="202183250"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 06:28:48 -0700
IronPort-SDR: U4KXXN6KmD3PcvMfmBpLXFE0/7AR6G2zp4GA2k4O03Z1p33gtHq6y+okoL9IS79kqnYuH6Lv/9
 AUUWpfKQOzfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="400555385"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga006.jf.intel.com with ESMTP; 03 Jun 2021 06:28:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 3 Jun 2021 06:28:47 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 3 Jun 2021 06:28:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Thu, 3 Jun 2021 06:28:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Thu, 3 Jun 2021 06:28:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WObG96tmrjvrcvbdO3QIfu4jcFBdWmxMHhID7BM3IlyIpyYLp/HAecLpFE58nTdBYRf7xq5ijLcIQmZTD75OxI2E/sEAMmeutTFHlQXUws/j+T3TXG6fkD3PbAm+mOGxzPNwnuDR+UiclCMbmhUZe6q7ieueW0iAHDHK2j8HChwKxxSrDh9oLs9wIxperOHtQk/r9/X+UXp22iOBjkMM6U04gmm6yNpI5+H3Fj4JH7c0mcc71uaZQP6r5nsAPop8mYj3Lr97CxrWsICiyfeSp/RmSsS0wKQ4FU9iSBq732zcW+2YmdECX7SZBYsKrbJxEo6+E//8xQNKmFmtkrTyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vdc1/5IBr/8aGBQ02pT30L7+Foev7zWEaBlUcX6eLRg=;
 b=HN3su0Zf1vkXo2XLM38xMW7MzIAFohaOcLC/ZZ1Me6wiNe1dEOdFa20K/EYOF2JumwioSlNPFnSW9zv+jnNX5UyngB2nd4Vqkb5RuVTjQsOt4H33dbRfluNVQHRBLc/c+ZxKiU56jUxOqpMHLmTH8+n7Jqwlesi2/b0nFsLu2Mw77JsN80Y99sCtXc4gAqowKJByZsuRSjqfEETvxlTo3D5w+/fglsNk6LD0cgyw2FOZzJBzvs/EESK2lSoEAbY7jRgcTanrOyZrkk7Jd3vYQ+mto9NO2zZ5nkxgENcM4m68E+y1BJKA3jC23Wg0tOvUzaZq0uV/C5SK9aS6o2eBqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vdc1/5IBr/8aGBQ02pT30L7+Foev7zWEaBlUcX6eLRg=;
 b=sfhhJRLSRzpOLfmFwM8rXw9KoGdehU3xfyChC/hJK2x71bkOmjiznAkPrHE/eZyN0Qa6ycOxTHagdEfJMQwX4AwRG+uiM4nx0GQlNUC64WyX9fu476O2LVxrTyDuum/ASTk8vyr2lcJWLyQbP/4ubiu+prcbx7t6puD1ez40F34=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5637.namprd11.prod.outlook.com (2603:10b6:8:33::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Thu, 3 Jun 2021 13:28:41 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7%5]) with mapi id 15.20.4195.020; Thu, 3 Jun 2021
 13:28:40 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: Please backport BTUSB_INTEL_NEWGEN to stable 5.10.x
Thread-Topic: Please backport BTUSB_INTEL_NEWGEN to stable 5.10.x
Thread-Index: AQHXUzxp1Hmy/K78mkezsPdlt1nyq6sCTuoAgAAC69A=
Date:   Thu, 3 Jun 2021 13:28:40 +0000
Message-ID: <DM8PR11MB55737E1DC9F97B750713C1EDF53C9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <cdab6dbada26fe31d21bb133ef087574c85c1411.camel@infinera.com>
 <c975e61b3866cc7615e6b995977a9d59f22384e8.camel@infinera.com>
In-Reply-To: <c975e61b3866cc7615e6b995977a9d59f22384e8.camel@infinera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: infinera.com; dkim=none (message not signed)
 header.d=none;infinera.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [49.37.160.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 702a29d7-c2c8-475a-995e-08d9269380a2
x-ms-traffictypediagnostic: DM8PR11MB5637:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5637BC88499AB3E30B54B6E5F53C9@DM8PR11MB5637.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xg+6Lj7n0WFblZl+1Bs+rvz6d6Pg2vrqRsYLfEHcQCikCUz7K2ciUGTinhoybf6qAUEGkF224ZL6dEWBuKt8KgY7d/T+KKJ6N0kgB7LD2UG9s/oV8zfTX7eT4N+PZnaS7N8sryUB6VJpVh/dM5r/mfhQGMNWuh9y/FlGvz3PQL7rjeHy9e/mC337MEkkqX0yXxRQhNC/U/+GbJ1S3v+oi9sqctYbswAaTuT0A55KqyUVOQDqAA7DTNrXMhCCs/U+yrLUP4R97sID1kjYH51sktvoGFTW2qz9VRWFU8S4EYCX37rNuV7qWAtUl9u/R6ri6YVOylgvvleuopNI+H66PziBtn97GPCrMQPTRqbiNjt+aZVa1mWxpXVQIryPLABDRsmOVQmkE1MwwldFUz1XX5GCOI6BrazVpoNXMNG6IwLYnG5UGsXxxOKzoQlPZXLpsdXK4qOopB/R1MJ8DKxHL0Hu1Dj67OM6wz4WU7eio8n0c7pqYKGEj+uxX5VZZ2ybgVPWj0QCmu2tan0oaCnE65TRWSXBFE1/j+rbshsC8u22z1jfxevV/yBVrn3XwsujlinOzwsYpsYIthrqloLSgUYCFUu5xQnYiU9KSaKKnno=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(39860400002)(366004)(136003)(26005)(186003)(5660300002)(2906002)(83380400001)(66946007)(86362001)(33656002)(4326008)(76116006)(71200400001)(478600001)(52536014)(38100700002)(110136005)(64756008)(107886003)(9686003)(66476007)(66556008)(55016002)(66446008)(316002)(7696005)(4744005)(54906003)(6506007)(122000001)(8676002)(8936002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?clNDVG91K1dEUWF4OXhNZStmVThoRnh6V3RwR3l4clNtMUVRYU5uR2FwaGZx?=
 =?utf-8?B?WFRvcXN2NWZicU9Pc0c1U3h5WU1oKzQySXRabHd6dm9HK3FyYTZVaWRXTTdC?=
 =?utf-8?B?VXlIWEUrdzM4b2lDcmZyWHhhK0FSa3ZoU1hySE9LWDZuTjNpcWN2Q2tUTW13?=
 =?utf-8?B?dmpjSEI3MWhzMU54dlQzMXlqUmRYcjRFSFY3czlTb3ZoYVA3UWhXUUJTdU9o?=
 =?utf-8?B?UEI0YXRiZmZXQ0JpRCtiTXJKbmVoaXJwS1RzalJHdFM3bksreC9Wd0ZPTEhr?=
 =?utf-8?B?SzgxUGMxU3E4a0VyVUFpeFMwRHUvQmxjREZhYnM5ZThUWm9EWjdRczZnVFpL?=
 =?utf-8?B?ck9Hei9sdDNwNmlGZEJJM2NpNGdQdlZTcDh1SE42a0RhaDRac0x5U2NhMFNi?=
 =?utf-8?B?WDBORWtXZlNndEJWeHR4a1QyTnlDMWtzUVRLTTVqTllpR3NCYVVHZWY3QmMz?=
 =?utf-8?B?R283MTYrREhRcVl2Z3o4R0ZscXFJbVp5SlFkVmw1Z1h5WHpObHVhZ2I5YmI5?=
 =?utf-8?B?VGxndTg1dzdaV29EL3VTNzBsS0JrRUVjSHRXM2RpWTQ5c3hFM2ZWd0wrcTNF?=
 =?utf-8?B?alVuQ1BjTldyYjZYNUwwRTBYZ0NDeFZ6dFkrQmtoNDNNajVya0xLU294L3M4?=
 =?utf-8?B?REtwVEhuRzhRaWRPbW1ZaTRrZWRxd3hTeERiK0E1T3BVSURTOUpkOWlzVzRD?=
 =?utf-8?B?TFhPOWVOWFkvZTRWNWVNS3JBaFJxazlvOHYvcjZuSEZ2SXZUeUNScVV4SlJw?=
 =?utf-8?B?ZndvQTk3Um9INEI3RFVLWUw4dHZVR3plNFZobEFHak54cy9Sc0tUbVlRbGVS?=
 =?utf-8?B?OW9uWWkvNGpLWm0rTXhMcm9Ubm5GYndmNldUSXdDREVHUjV6cUpOZ0orL1Rp?=
 =?utf-8?B?OXJNMmNUbkc0U2hRdkJMVGozNXd3dlNuby9kMzh0WWVCaDJReTQrOFJ6SVRU?=
 =?utf-8?B?QUZrRW5JV1FIdFY3d3pPMlVxTnp3dGhxWEY0b1NmZzNHem5ZVTZ0cDN1UkJ6?=
 =?utf-8?B?TWNFaElQc0lKRHExREZxcW12WS9OamEvZ2ZvOXFCMlliWHlQNGlackY2RkNn?=
 =?utf-8?B?YkxuWHN2TklNajF3eERGUWtGTlZGaStqT2cwSmNSb29HRng3MnF3L1k5YTFR?=
 =?utf-8?B?aUwrem04UExGME9lYzRpKzYwV1YwUS83Rlh3ZThXaUp0UjhVYytYeVc2OEpn?=
 =?utf-8?B?NnB0M2I2L1B3VzhtQy84ZWFVSFF4eHFoN1RGM3FJMm9xRmZ0MXk3eXB2ZjJ4?=
 =?utf-8?B?ODdtTFgwTlBFVDBjUnFHb3RuMS9QSnJoQVZtcFdyc0k4WHRGNVNQNmFtejVH?=
 =?utf-8?B?NEx5N3B6ZFZGR2RnSUE4QnZNMFIrdWRXWit3M01ZNE9PUXNqVUxlcDUvTFpT?=
 =?utf-8?B?VTFMb3JOTGRrRHh0Zi9acGVGdExQUjJZbmRqdUYxSWppQTYzcUpoYUd0eTBT?=
 =?utf-8?B?Y21LU1dVa1JEVnJ3WE1rZWtNWFM5c1d6djB1M3JDd0drNi9ERTYzWW14ZzZC?=
 =?utf-8?B?UndQSUpkekRiUEUxSW8vdVBCVVc1cmh6c1ZnR1BzbkZnTnRsN1o4Q256TU1C?=
 =?utf-8?B?MHd0N2RCNE1jRk5hakx6N25KZXFwSFEvc2lpL3N1dUdjbEM5S1NrbXRCVEhZ?=
 =?utf-8?B?Tzd5YzlNeEpSUzNZVmpIR0p0bHFVcHJYRmFFektIcGhURlVwdDVkSGpPUDBy?=
 =?utf-8?B?L0hqZWRlWlYxUkFHeEZ1V3pDYUN4MzNtenFhdTZBSDQ1TDBjdGgyd29Pb2hP?=
 =?utf-8?Q?I1Fr85XAU547Ih73YbKqOEv9ArTP86wCiSo24+D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702a29d7-c2c8-475a-995e-08d9269380a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 13:28:40.8569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dCXa/nIdcsJeccByPdyusB2/1lX7tP3HHAmLMI7gkhNBS/WvcugFTlObHobknhYnUEFNMH46ZqJkGgn5KtXliA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5637
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGksDQoNCkkgbmVlZCB0byBjaGVjayB0aGUgcHJvY2VzcyB0byBzdWJtaXQgcGF0Y2ggdG8gc3Rh
YmxlIHZlcnNpb24gb2Yga2VybmVsLg0KDQpMdWl6L01hcmNlbCwNCg0KQW55IGlucHV0IGhlcmUg
Pw0KDQpUaGFua3MsDQpLaXJhbg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogSm9ha2ltIFRqZXJubHVuZCA8Sm9ha2ltLlRqZXJubHVuZEBpbmZpbmVyYS5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDMsIDIwMjEgNjo0NyBQTQ0KPiBUbzogbGludXgtYmx1ZXRv
b3RoQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogUGxlYXNlIGJhY2twb3J0IEJUVVNC
X0lOVEVMX05FV0dFTiB0byBzdGFibGUgNS4xMC54DQo+IA0KPiBPbiBUaHUsIDIwMjEtMDUtMjcg
YXQgMjM6MDggKzAyMDAsIEpvYWtpbSBUamVybmx1bmQgd3JvdGU6DQo+ID4gVGhlIGRldmljZXMg
YXJlIHBvcHBpbmcgdXAgbm93IGluIGxhcHRvcHMgbGlrZSBMZW5vdm8gVDE0IEdlbiAyIGFuZCB0
aGVyZQ0KPiBpcyBubyBzdGFibGUga2VybmVsIHN1cHBvcnQgZm9yIHRoZW0uDQo+ID4NCj4gDQo+
IE5vIHBsYW5zIHRvIG1ha2Ugc3RhYmxlIHdvcmsgb24gbW9kZW4gZGV2aWNlcz8NCg==
