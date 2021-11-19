Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E9CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5CD61AA3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhKSIPl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 03:15:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:55223 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232838AbhKSIPk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 03:15:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="234326397"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="234326397"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 00:12:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="587650159"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Nov 2021 00:12:38 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 19 Nov 2021 00:12:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 19 Nov 2021 00:12:37 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 19 Nov 2021 00:12:37 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 19 Nov 2021 00:12:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kye8QVC5FmhrqA49I/7SpXsIx8NCCtu/RaYgaNnJDkwbXxlcLmbg76XeKEBWkXntKzuVJE4Me4wlTGeOtzxs+RKkbNW29M0ua6UTAg5I/5H0NpLj/M//eUdr03qd6YyXsHtKGGj/xTFguCPzmbIE8Z8fLB9eiGcm2crpooUcPef+mItwp24P42ozlYtsxWTPccc8oEYU+vZfoBYNYIsmErXstlkTLSaoCP2MVjX5CRS9Oa8buXvm6AcyNThoNhm/ibG/egXivlYdUzf3ARZePaU5cuVtIjYP8Wzo2zGcOVBOwS3cBOGrJBVzVmxmX/iB9zOzFxZzAojjxu3aTGzXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6wLWe1YqEz12t0jybkzblc2KIzh85ZoQq91eB/w8vo=;
 b=WKUYhEPPNawJ0F7U2Aj8111PHvOHhHiRyySPJw5tKu2y9yeViX0TMESJfWVZo6hL6suBMBIRsyULhb3/MA0hXCfHoH4cKQ04Arb3d6IU8KlvDwCN2PVBzU2imGSYlRo19D7ijIMjo6/MHOFwY+vO2VvaS+UPqdl82/TxzxLYNx0R6s5eA89GqI39He2olM6mDsX2YcxNFFFx7q/mfednTF/NpJr1EoDQgkvBGsCf1p97GCm0Adm9lL0vHe198iWJJqy3B4tk4HMjgDbvP6kRM7gjuAxWEBuH+L2NdQsKPWAC1NSkGjBUge6MucKM45KuDrtIPooPBUNzJvmF4lvx9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6wLWe1YqEz12t0jybkzblc2KIzh85ZoQq91eB/w8vo=;
 b=uzIxBjhRbqGOenZDGxlDcUE2eb0Zmzj9jnjXFeIL5pvYLP83xc7KbJX2ZGtSEsR05SMcQ1OqYMICHuJR/KgYlmYvN4sbEQd87JRrj4Z+y38KLAxrOqsQdO0PeR9rVzH9XSLY82Ry7abI4AizPf7zwfkBQUviQH++S4cRseCqs/k=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5589.namprd11.prod.outlook.com (2603:10b6:8:26::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14; Fri, 19 Nov 2021 08:12:36 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::1879:4eaf:cabd:992f]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::1879:4eaf:cabd:992f%8]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 08:12:36 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Subject: RE: [PATCH v1 1/5] avdtp: Add a flag in struct avdtp to control a2dp
 offload
Thread-Topic: [PATCH v1 1/5] avdtp: Add a flag in struct avdtp to control a2dp
 offload
Thread-Index: AQHX2gQnjQS4qzYdvkmLLgIsI4boWawE/cmAgAAAroCABYeRYA==
Date:   Fri, 19 Nov 2021 08:12:35 +0000
Message-ID: <DM8PR11MB557336483339D96F6E357473F59C9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20211115094108.24331-1-kiran.k@intel.com>
 <CABBYNZ+rFbfe1joiLmJBGB_twX4_kNu3Nsr=TSs1SyfMvAes8Q@mail.gmail.com>
 <CABBYNZJRm8Ej7FfW7bnA8ZdZFmHbsOnVfXavM0hFdSFd2ib1Gg@mail.gmail.com>
In-Reply-To: <CABBYNZJRm8Ej7FfW7bnA8ZdZFmHbsOnVfXavM0hFdSFd2ib1Gg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82d21ccd-59d0-4169-9040-08d9ab345881
x-ms-traffictypediagnostic: DM8PR11MB5589:
x-microsoft-antispam-prvs: <DM8PR11MB55899027A105CF8A6AF7C9D5F59C9@DM8PR11MB5589.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oDK9o/1cZ11i+IIc5ZDQ3FTneXyALUOI8fEGpd/Bpi2VWNEiXc0LUk071Ll4b511VbEhsPPKirYDGjv1CuksE65ZBnpnDr1PmPk1z32KArlQaJY5hijdU4P1s0vVQxJI70uwbcgWin7y/Qt7aHNvNXljj+xgnxjabQ0dbwtk2vNFdZE5ZuOd0sIY96Re4Rz0bnJt0doyqlfa02b1QZJ1/XAkFijc1mLIG9yqqSFYGW8Dw3mCeYym0bISuDOz9wLBYQutDcxMBKWXHg9NyUlPu0HmwNjlTRPavWew3/9/l2oB1LrxqA2eFoEMOM3KNLHMlXdsi5PSnq+LshW8nDUz+XI8P5mSmyA4KwTz5fr4bGqQFNr/wEYk7pVvrKN0/C0Swis7aSwBqOpGwFYy9podFal8QrxJ4EcJco1NpakL6WUJwg3NNF/N/jS+VnNOabyCdMQSKQqDTkw6YJRPJjjis0A/GvR0Dy9El3ZawsfaCxzx9ogQyQK20BhRLtUb3fNTUXB6glcIclOzguuhbi4N4temd0ukSB1p2dqXYuvt8c+PLPEMlBXTL+cEkBkgk5CtQLvuuCnK8ISrPYQtS5NkWZHGV0J4PjIlYzBkoxZpg7ItwxnOGvjjRS27XGKgTNJaFAm9iURiFU/wc6RkyYEi07IaBeoJ6QHgW/9RQYaZc4c3Gh6E48zBnMnxtV+9tWip7IEPiZnyyiai1AWDXRjrL1ZYOcOD3EwqXvn/DDcgXamVTcJbJQXrGVMI2wEPHxo7Nueb5fzvdp6w1x1IW9WpAY+6/6lYv6f1anuBHq5AdHY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(53546011)(8936002)(122000001)(66946007)(6506007)(83380400001)(33656002)(38100700002)(6916009)(82960400001)(5660300002)(8676002)(7696005)(107886003)(316002)(66446008)(4326008)(66476007)(186003)(966005)(2906002)(9686003)(55016002)(64756008)(66556008)(26005)(71200400001)(54906003)(508600001)(38070700005)(76116006)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGFvWGtXcVFwVFJXSGdYQ0FSa2N4cWZJLzBNWkg2TXRjWmdGais2SDZUV29U?=
 =?utf-8?B?VXhLNDk4Q3poeFlnTkkrcytwQWZ3VWtMVGxaeUxoZmpyY2w3WmtpY0wveDBY?=
 =?utf-8?B?bVlrRU1RUmw5TEg2ZFBhWkJRbFRVTVYzZlRPZmMyN0hYVm9aZmpLZ3M1NjlE?=
 =?utf-8?B?UmtuQTUrejBDcXpqNnJoUzBCd1pESUZRUHhSamlETDd6aitQUm1YaURIaWFB?=
 =?utf-8?B?V0JsQVBad0ljT0tJa2JxN1E3cTg3SzlaU001dkQ0Z2FCTHltcGJHNHNxOVBi?=
 =?utf-8?B?cTliMXhFcXJ6NjRLeFp1TXJFakFxRHFnMzUweTRRMmRVRDh2VCtvRzlsakdR?=
 =?utf-8?B?aXlCVm9mdHJ1YXU5S0RCLzA4U1h5OXBoVm0wQXdxVnArZHhCeiswbmNPbGxJ?=
 =?utf-8?B?K0tiQVlueXFMeHdlOFlyTkprVXY2ZlJhQk43eU9wcnM4aWtGUXRDaitOcmVQ?=
 =?utf-8?B?MDZsaFkvcGVvTHN0eUtPVDA4Tm5ob0ZRNmI2L3IyOUp6SWorT25SRnZvNlJM?=
 =?utf-8?B?cU1UODFSK3lZZGYra240enBWUnI5ekR3K2lGM0JFZ3pSOEhFQ0RMWU9mOXBX?=
 =?utf-8?B?ejQ2RVBNZkdCWkNjREZ4aDN3Z2YxVHpFUzFqVlVLQ2ZVOXFIR1cwVU1zcTJz?=
 =?utf-8?B?bC9jSkxPdERPTUh0MDV3QmhqR1diZVMxSS9NN1pIK082cS9aNlFidytIZS9M?=
 =?utf-8?B?TVpOOHM5MVc1MXNSU3UydFphWmhyTjdxaHk1NERIRFdhTkZqYmtkbnRjNlJC?=
 =?utf-8?B?eXUrT3F6THRBZy94Rmt3NHdpSGpKV3ZOM0EyMERkSUpsL3Fzd1M4eHdyZjB1?=
 =?utf-8?B?SzBUQUg0WDkzQ1NzQnY3TndMaCtXa3c2OXl5KzZqdWZzSUY5M0dpUzVZaFQ0?=
 =?utf-8?B?UDJ6S1NUVzBtMXhZV0sxR3krT284aHM4UEFVYzMzaitZcHR1ditoS3ExQ2hY?=
 =?utf-8?B?SXJUeE5oQUY4eDZ6Wm15UUJQZFpiajB4RDFVQ2d0c3lCZ0FaZG5zTXJnL0g0?=
 =?utf-8?B?cEM1dFRVU0swQXBTZnFqZ1VoSkdoRFhhb3RsWjhoaDh2c2l0bjVRN2lCSEJC?=
 =?utf-8?B?M3NuOXpGWjZOamxKbDJJOWdra1haWlBERjd2blFkMW83VXFOL1FLZktIcTAw?=
 =?utf-8?B?UTNIU0NveEpqaE5RMm45c3VidVlydU56bXFkd0hldjJvVi9nZEZxaGNtYTdW?=
 =?utf-8?B?RlV0Wm1icFMrU0M4N2lhaDhmVXUyUHA1S2JOelQ3Vk1nQ2xvdXdyVDNuZkdX?=
 =?utf-8?B?dGZSQjVhb3Y0UDNKTTdjQVg3ZzYxeGJKSVp6a0gza1hNYmJ1bEpqWUd2RUVE?=
 =?utf-8?B?RW9acURnTkVVZnBwa2hDL2NJelFIMDh3QTNFMDdxVkxjaHVEYzRHL3RUNWZF?=
 =?utf-8?B?d3RJSFQvcTdIZWg2UXNhcTBCQjF0ZTIvMllBYTZmSHZMYWQzbDB5YXlvQ2Zp?=
 =?utf-8?B?VDcvNEVZT3h3NHEyYXlsL01YS1Ywd0svVjJRQXBhQUVHNHdyVVlTT0FFTCtW?=
 =?utf-8?B?UE1VRzMwZU5sWlFWMC9zYzg0cWl3T0N4WEJIYzlsaUg5RksyZ1RBRFl2Wlc1?=
 =?utf-8?B?cVk3Y0tzT3RXbzZFOVZnWG5TUWNMOGl5V3cyTjNTKy9UcVFQc2pqdEZRSnZt?=
 =?utf-8?B?UWdBZlJzbUZBZHRyMWtBRGQ1QXkxcFg0UC9ScnRLZXRBSVFpdzM4ZFBJcHR1?=
 =?utf-8?B?OHpCcHV3UkJRclBzU0tYS256OHkraHFQOG5xNHlPZ1ZDOW41ZUVmZmpwTW9x?=
 =?utf-8?B?dmlzSWZ5UmM0alBQMmdET1M3eXR6cDY5RDNKZU1YRldLeENHVTNBWXB5QUo1?=
 =?utf-8?B?SWFGRExuSlJPL014TnduWG1hZmRucUg1VUNtZzgzU1p3clJvejRreG81Q3pO?=
 =?utf-8?B?ZTBCMjgzWHRBeTJIcWh4REswU2ZlSER4RlZJZnZkSlpmVmhEbDEybW9xSHNQ?=
 =?utf-8?B?VjJQUFJCOEd2bDdCVU9BVUtZajF0MEpCU2I2WXJVN0ZWQkJBRTRaeVNyRW1S?=
 =?utf-8?B?MDJWUG9jWmJyMDNUL3NSQ3djYzF5U0t2d0FLVDQwZXE2ZTNUbTJwV1ozSkUw?=
 =?utf-8?B?SThzOTk1WllWKzU1YzlPUkx3bk9JUnlrZm91cWh1SU8wc3ZxMU5kUnVBRFV4?=
 =?utf-8?B?RDJPdlV3ZUhNWEplMWg0UkIxeDNINExwSXJnT1RrYWFKSVAzejM0aDRyVzB0?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d21ccd-59d0-4169-9040-08d9ab345881
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 08:12:36.0105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zaeDoRndIv8LpBN+E5n8TOjjTXk9oSlF4/lydgI7J/sZpns/1A/2c+Vfmk0DZ23AeiY5xwsshe/fvHZhlxDEKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5589
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWl6IEF1
Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwg
Tm92ZW1iZXIgMTYsIDIwMjEgMToxNSBBTQ0KPiBUbzogSywgS2lyYW4gPGtpcmFuLmtAaW50ZWwu
Y29tPg0KPiBDYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsgU3JpdmF0c2EsIFJh
dmlzaGFua2FyDQo+IDxyYXZpc2hhbmthci5zcml2YXRzYUBpbnRlbC5jb20+OyBUdW1rdXIgTmFy
YXlhbiwgQ2hldGhhbg0KPiA8Y2hldGhhbi50dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+OyBWb24g
RGVudHosIEx1aXoNCj4gPGx1aXoudm9uLmRlbnR6QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MSAxLzVdIGF2ZHRwOiBBZGQgYSBmbGFnIGluIHN0cnVjdCBhdmR0cCB0byBjb250
cm9sIGEyZHANCj4gb2ZmbG9hZA0KPiANCj4gSGkgS2lyYW4sDQo+IA0KPiBPbiBNb24sIE5vdiAx
NSwgMjAyMSBhdCAxMTo0MiBBTSBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQo+IDxsdWl6LmRlbnR6
QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBLaXJhbiwNCj4gPg0KPiA+IE9uIE1vbiwg
Tm92IDE1LCAyMDIxIGF0IDE6MzYgQU0gS2lyYW4gSyA8a2lyYW4ua0BpbnRlbC5jb20+IHdyb3Rl
Og0KPiA+ID4NCj4gPiA+IERlZmluZSBhIGZsYWcgaW4gc3RydWN0IGF2ZHRwIGFuZCBzZXQgaXQg
YmFzZWQgb24gdGhlIGRlZmluaXRpb24gb2YNCj4gPiA+IGVudiB2YXJpYWJsZSBVU0VfT0ZGTE9B
RA0KPiA+ID4gLS0tDQo+ID4gPiAgcHJvZmlsZXMvYXVkaW8vYXZkdHAuYyB8IDggKysrKysrKysN
Cj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlm
ZiAtLWdpdCBhL3Byb2ZpbGVzL2F1ZGlvL2F2ZHRwLmMgYi9wcm9maWxlcy9hdWRpby9hdmR0cC5j
IGluZGV4DQo+ID4gPiBkM2RmYmY5NmRkYTMuLmI2ZmVhYzBiYTRkNSAxMDA2NDQNCj4gPiA+IC0t
LSBhL3Byb2ZpbGVzL2F1ZGlvL2F2ZHRwLmMNCj4gPiA+ICsrKyBiL3Byb2ZpbGVzL2F1ZGlvL2F2
ZHRwLmMNCj4gPiA+IEBAIC00MDksNiArNDA5LDkgQEAgc3RydWN0IGF2ZHRwIHsNCj4gPiA+DQo+
ID4gPiAgICAgICAgIC8qIEF0dGVtcHQgc3RyZWFtIHNldHVwIGluc3RlYWQgb2YgZGlzY29ubmVj
dGluZyAqLw0KPiA+ID4gICAgICAgICBnYm9vbGVhbiBzdHJlYW1fc2V0dXA7DQo+ID4gPiArDQo+
ID4gPiArICAgICAgIC8qIHVzZSBvZmZsb2FkIGZvciB0cmFuc3BvcnQgKi8NCj4gPiA+ICsgICAg
ICAgZ2Jvb2xlYW4gdXNlX29mZmxvYWQ7DQo+ID4gPiAgfTsNCj4gPiA+DQo+ID4gPiAgc3RhdGlj
IEdTTGlzdCAqc3RhdGVfY2FsbGJhY2tzID0gTlVMTDsgQEAgLTI0MjUsNiArMjQyOCw3IEBAIHN0
cnVjdA0KPiA+ID4gYXZkdHAgKmF2ZHRwX25ldyhHSU9DaGFubmVsICpjaGFuLCBzdHJ1Y3QgYnRk
X2RldmljZSAqZGV2aWNlLA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcXVldWUNCj4gPiA+ICpsc2VwcykgIHsNCj4g
PiA+ICAgICAgICAgc3RydWN0IGF2ZHRwICpzZXNzaW9uOw0KPiA+ID4gKyAgICAgICBjaGFyICp1
c2Vfb2ZmbG9hZDsNCj4gPiA+DQo+ID4gPiAgICAgICAgIHNlc3Npb24gPSBnX25ldzAoc3RydWN0
IGF2ZHRwLCAxKTsNCj4gPiA+DQo+ID4gPiBAQCAtMjQzNiw2ICsyNDQwLDEwIEBAIHN0cnVjdCBh
dmR0cCAqYXZkdHBfbmV3KEdJT0NoYW5uZWwgKmNoYW4sDQo+ID4gPiBzdHJ1Y3QgYnRkX2Rldmlj
ZSAqZGV2aWNlLA0KPiA+ID4NCj4gPiA+ICAgICAgICAgc2Vzc2lvbi0+dmVyc2lvbiA9IGdldF92
ZXJzaW9uKHNlc3Npb24pOw0KPiA+ID4NCj4gPiA+ICsgICAgICAgdXNlX29mZmxvYWQgPSBnZXRl
bnYoIlVTRV9PRkZMT0FEIik7DQo+ID4gPiArICAgICAgIGlmICh1c2Vfb2ZmbG9hZCAmJiAhc3Ry
bmNtcCh1c2Vfb2ZmbG9hZCwgIjEiLCAxKSkNCj4gPiA+ICsgICAgICAgICAgICAgICBzZXNzaW9u
LT51c2Vfb2ZmbG9hZCA9IFRSVUU7DQo+ID4gPiArDQo+ID4NCj4gPiBXZSBhbHJlYWR5IGhhdmUg
YSBjb25maWd1cmF0aW9uIGZvciBleHBlcmltZW50YWwgZmxhZ3M6DQo+ID4NCj4gPiBodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vYmx1ZXRvb3RoL2JsdWV6LmdpdC90cmVlL3NyYy9tYWlu
LmNvbmYjDQo+ID4gbjExOA0KPiANCj4gQ29ycmVjdGlvbiwgd2UgbWF5IG5lZWQgdG8gaW50cm9k
dWNlIHlldCBhbm90aGVyIGV4cGVyaW1lbnRhbCBVVUlEIGdpdmVuDQo+IHRoZSBVVUlEIGFib3Zl
IGlzIGp1c3QgYWJvdXQgY29kZWMgb2ZmbG9hZCBub3QgTVNGVCBBMkRQIG9mZmxvYWQgd2hpY2gN
Cj4gbWF5IHJlcXVpcmUgYSBjb21wbGV0ZWx5IGRpZmZlcmVudCBzZXQgb2YgY29tbWFuZHMuDQo+
IA0KT2suIEkgd2lsbCBpbnRyb2R1Y2UgYSBuZXcgVVVJRCBmb3IgYTJkcCBvZmZsb2FkIGNvZGVj
cy4NCg0KPiA+IFNvIHlvdSBqdXN0IGhhdmUgdG8gY2hlY2sgaWYgZXhwZXJpbWVudGFsIGlzIGVu
YWJsZWQsIG9yIHRoZSBvZmZsb2FkDQo+ID4gVVVJRCwgaW4gYWRhcHRlci5jLCBhbHNvIHBlcmhh
cHMgd2Ugc2hvdWxkIGhhdmUgc29tZXRoaW5nIGxpa2UNCj4gPiBidGRfYWRhcHRlcl9leHBlcmlt
ZW50YWxfaXNfZW5hYmxlZChhZGFwdGVyLCB1dWlkKSBzbyBpdCB3b3VsZCB0YWtlDQo+ID4gY2Fy
ZSBvZiBkb2luZyBhbGwgdGhlIGNoZWNraW5nIGlmIHRoYXQgaGFkIGJlZW4gZW5hYmxlZCBpbiB0
aGUga2VybmVsDQo+ID4gb3Igbm90Lg0KPiA+DQo+ID4gPiAgICAgICAgIGlmICghY2hhbikNCj4g
PiA+ICAgICAgICAgICAgICAgICByZXR1cm4gc2Vzc2lvbjsNCj4gPiA+DQo+ID4gPiAtLQ0KPiA+
ID4gMi4xNy4xDQo+ID4gPg0KPiA+DQo+ID4NCj4gPiAtLQ0KPiA+IEx1aXogQXVndXN0byB2b24g
RGVudHoNCj4gDQo+IA0KPiANCj4gLS0NCj4gTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0KDQpUaGFu
a3MsDQpLaXJhbg0KDQo=
