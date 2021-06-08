Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCAEC47082
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 11:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 068C36124B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 11:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhFHL6P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 07:58:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:12160 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232122AbhFHL6O (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 07:58:14 -0400
IronPort-SDR: 7MwR+SWXH6zrb0rv1tx3EywNM+h9jsIF+JeVTNd7HzVhDhKNR7jPwzT2H3czX0zxrSFLZHesHl
 NjPTF66wSscg==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="268681760"
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; 
   d="scan'208";a="268681760"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 04:56:20 -0700
IronPort-SDR: XIStfHak5nq3Crxb5inw0y266VG+rG00u9CNItJ6gImbOXHj867tWz2P6N/GB2A2GJkumJfNtY
 5NjqUdlrwwIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="413357571"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2021 04:56:17 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 04:56:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 8 Jun 2021 04:56:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 8 Jun 2021 04:56:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql2GmnSNMl1qTOkecYWPVv8GOB+475g2LcK+nbKWOB/eKo2sfHc5g1wFGTUtg7BSk5jwXZ0amxWXP8sW8GCdA7aRPydLkxJO3SfE/1chsZi72Ef6treLQJVAaj2WbMkM2uC/A9KZml4vxkRDu/yCI0qx9wMrEm+Ce3UyqrIaWuRJoCyEOqPHOBNA/+2bKrJ0RbyiCZkbbxCeoDpaHpRitP+EAn/3mSLd190hfBii3Oa/x8jIE95zRQ3iD/XnkvVVBA1brsp789uWzMoFSlHMa7ugkO7oVQSn2U5LdNnceCulFJItk+q5A5okxYzc2ne0EK2XqD6+r4zRkjleJSBVzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOjI52XLh/Innecxq89TpTNaEHEAS+yHnZ1cLdpSPnQ=;
 b=XjuvDF7FN6rTdygW7NxMLdbScJv38uX/rLJCkA57J2hLJM6iIkHMbgwyvEC7hdc3i2hqn9sxggF7sa/q+sH39rT1Va12nTXeXg6QvwRXR/ncC1BThP4oMDIR8AZoWDaj8JUFqNzA//FlrQyO5nuIxT4Tw0S8anRnvMwRQLWRz1E7cZOzX4kqIa7RsWg4gEP9DAQ6zQxEh8TRPgGCtMB0wV9zCC1YzLrpwZgc1j9P/kz3wLOpdfP6GQ9/IAtWZ51B2mcbcKz0iYNizSEhMvZwCWVhSdRDTQwHAk66dyRUQameySTLfmQLi6nPzUWdRkqgJJkgHxFyRLK2KoXCbqymmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOjI52XLh/Innecxq89TpTNaEHEAS+yHnZ1cLdpSPnQ=;
 b=pcNVrqdu4hXmVP5S6aKYVaHho5233svpN7Ife4A7Afb7fIxW3yEhJGuIgQrZp/va1Ek0qZc8h3qmdREULKbMn4TQcna/kTGgCYayDur2KFNiDwD7dvmEUQSkZhOTyeunw4QZUf97p3+qffcxoMYd9+jk/9pdq3VH1L5W2aXPLoM=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5637.namprd11.prod.outlook.com (2603:10b6:8:33::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Tue, 8 Jun 2021 11:56:16 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 11:56:16 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v8 4/9] Bluetooth: btitnel: Add a callback function to
 retireve data path
Thread-Topic: [PATCH v8 4/9] Bluetooth: btitnel: Add a callback function to
 retireve data path
Thread-Index: AQHXS9IDKlJcwjuSDEG/SMYHiCuNSqsCchmAgAewjFA=
Date:   Tue, 8 Jun 2021 11:56:16 +0000
Message-ID: <DM8PR11MB5573A02D73AE258B6EE306B8F5379@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210518104232.5431-1-kiran.k@intel.com>
 <20210518104232.5431-4-kiran.k@intel.com>
 <F2618817-65E3-40E2-AB94-CFB7BE11A9FB@holtmann.org>
In-Reply-To: <F2618817-65E3-40E2-AB94-CFB7BE11A9FB@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [49.37.169.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b3e2e6e-e234-4754-1fdb-08d92a746bc5
x-ms-traffictypediagnostic: DM8PR11MB5637:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB56372C32A01AA16BBD41954AF5379@DM8PR11MB5637.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QakH/5gQxy4I1TRp19/n2K2LCysNUlMf31qrcP5jLtPod8Tn1BREToMWKam+Npvfp8HOHv4N8PUDGJZ/zdxJuzTj3X2Jn54wHaEKN2f0LNzXQi7Z7/hUChVC7EQpXduKkyiOxcLkqvV/ktrDvy8bJ1Pznxjzl324vwcLz44G2AV+orD6vTyjS+zWdZ0aa9AJLO2jAGm/uHdjvl7NCVNzTXa0hJ/akcUo8PBouueAonF/VA2LZx8AUFql/gb5PIDkGPID9/G80F11+uVHszokMU8DCXRxQQ5YzRCUhc0tZDBNkfjqqMPPQKQCCdAdye/mykUt1Qax/pQCksjW3WZB2ra9Vq+wRJAXmyrdwLIT3ZlVsMl2J5LFSlbb5M1qYbAYmrmECmTLyg3XZpgjeb5Zq5o20h7vvwg87/hT5xHLGAoPirtwDaIox7rKESj2vELLxuMTMks+FWdbBfleKeQI+bymtxj/hhkW9HTIgDA1ziuf6qKhGZtibx6SzPD468bMAMegQU32pxZmTOCC2SQ0ynlSjHUaHCJdrXhrZVKH0zqwbbLZmgOBuHsvR7Xc0RlJwpell+8vVzVWTc4CZ5QZsbKNwGd7lM3RDI0wIJ/nIb0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(366004)(376002)(39860400002)(122000001)(6916009)(9686003)(8676002)(55016002)(38100700002)(107886003)(64756008)(6506007)(52536014)(33656002)(478600001)(66476007)(2906002)(8936002)(316002)(54906003)(4326008)(26005)(66446008)(66946007)(66556008)(71200400001)(76116006)(7696005)(5660300002)(86362001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QktYTkdWeWQ4Z1dnT1M3K1ovL0Q1d3RFWm9OUTB4VFZDaHZQYy81UGhkNGJQ?=
 =?utf-8?B?MkZmQ3BEK21FYzhVTWlQQjViYU0zTTgvSWNYUlI2TWJidzNlakVxNXk5SXdn?=
 =?utf-8?B?ZXB3VVNubmR3U0lkTUpHbzk3aHROVXRacm1yV2tyUk5YQTJwdTFFNW8zd0ZS?=
 =?utf-8?B?V3A2OTM1RHVrZGNJenJnUENiL3d5WW5EcHRuMkFOS1EvL2VwYlBKOG1rSDVP?=
 =?utf-8?B?bGFJMU56SDV4UGJaSzNyNHo4ZjJUdVdEMVJvU0hET0UwN0FvNW1HV0RTNkZS?=
 =?utf-8?B?NHFqcm1LQkNXckU5RGJIdmoyZ0tmSk9GV3FxMXVaS2F3TWpPV01ycUx5NzF6?=
 =?utf-8?B?bmM0VkErQ1NzR0I5eWY4MVJ2MG05V3dFc3huTURGZmY4dnAxeFhucTMrTWNV?=
 =?utf-8?B?U0Uza0ZGcXk5S3gwYUxZVGdreEdpVjFYWHF3VjY1c1RzUllIclQrWi9IcG8w?=
 =?utf-8?B?Nk5acHhNOFFLQ3BXbjJDQlRGQmsrNVR4QWdLS3FuVGJMUWFnQ0ZaSkRCY1Qw?=
 =?utf-8?B?VUJuK3JvdnNkQi9qRVpSeHBhTWhJb1kwaEdkNXVmdGhCakNoTHdwbWdlZkxC?=
 =?utf-8?B?S1dEcWJmZElQQWdkcGF6VkpQWmdnTjRmWmFZc2NBZFBjNDJISk5xUkZjSzJ5?=
 =?utf-8?B?VGQ1RVZEanVaSi9jN0ZTZXVzcHg1bFJTd3gwQ0JDdmZuWEg2Z3NPZDlOV2RO?=
 =?utf-8?B?SzVHUVY5WkExQ0UvbzR2WTlQMnBxOHYzN0ZJM09rY3pQd2dCaGJvVjl0dkdV?=
 =?utf-8?B?WDBDWitLTWpYMUhlZzJteHpMbnhtcnhuNHRKKzJPRktEVnppSXV4WkZLbVNv?=
 =?utf-8?B?OTN0Mnh2emhXT0xENS9idTErcmUzR004R3BYc3l2dVRiTkgreTZySkJlajBy?=
 =?utf-8?B?dHplbXltWHUvRWpUcWlobnJpTDJoTlZ1OVp0dlBJRlhZRllaajBpc2c3RlZ6?=
 =?utf-8?B?N1c4NFF6RldqVjA2QjVTQlVaNDFMbGhudXR2a2k3dk5OdVB4dnhaQ2FYWE1M?=
 =?utf-8?B?RkRUckwrc1NqQThzK00yajdJMVhSQ2srZkVtZkhSOVA2aEFpQjN3M3l1VXc5?=
 =?utf-8?B?YUVTcG03ZDU5Yy83VlRmQjZGQ3h2eEpLUUFIRm94ZkJOMHFIVHg4UnluT25V?=
 =?utf-8?B?QTIwQ2UvcTBKMXlscEYwdXFXdzhpTDUrWkV6VjJtRENpak5jWU13d1BkNnJr?=
 =?utf-8?B?M1h2U3B2VHhDaklrZ3UxOWlkNVhoTStpVWJwMy8rVnM4aGJRdHR0WTBGRklv?=
 =?utf-8?B?QmsxY3o4aWdqRitFRnlZT1pwNndaRkV0R3JRNktqMERCTzZ3WWFkejI4QnZk?=
 =?utf-8?B?dFZBUm1Qdk5nMTV3dWw2TzBCUE5uZ0lmV2M3OUhjbFJGK3VRZGp5d1dkRDRn?=
 =?utf-8?B?SytQeVA1b3JqZ1RGOUF3WWpnV2dYL01jRmFSVVFLZDRXWDU4b2w5SlI1OVk3?=
 =?utf-8?B?NUZOUFE2eWloVm9QRDc2WkZnbFlnWVh2RnZmc3FvMFVKNVErYTRIY1EyNUht?=
 =?utf-8?B?UGVidXZqZE9qTE1NT3dTcG40b1VpRU9xU0pxa1pOR2tvb2RyTGsxWktzeWZN?=
 =?utf-8?B?OWpZNFU5N2tYbzZUVjd2aFNRaGdJNFdBSTBmVm1VZTAwWVU0Qk94Kzlickhl?=
 =?utf-8?B?dWx0dE9yc0ptT0NFUy9KekVyQUxwMjFBUmZSREFtUlNNRy90Vjc5M1VFaSsx?=
 =?utf-8?B?dFdsOGNqaGIrWXZCQ29neklnZHFnMzE3bkcxMG9vMEh1cVZseVUvak1xSnF4?=
 =?utf-8?Q?T9Y10Sf8GYS2/XbmgcZ4utvIM+7KaKR3nwCTZtZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3e2e6e-e234-4754-1fdb-08d92a746bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 11:56:16.1244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q872VrOAoosbv+UOx6UyYSmI+vK19sZfF2ipkMxt8LscopbkOIekzdSwP9Wh6Fquz+s7QkNLH2li31xYhqV6Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5637
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQo+ID4gVGhpcyBjYWxsYmFjayBnZXRzIGNhbGxlZCB3aGVuIGF1ZGlvIG1v
ZHVsZSBxdWVyaWVzIGNvZGVjcyBzdXBwb3RlZCBvbg0KPiA+IFNDTyBzb2NrZXQuIEZvciBJbnRl
bCBjb250cm9sbGVycywgZGF0YV9wYXRoIGlzIGFsd2F5cyAxDQo+ID4NCj4gPiBkcml2ZXJzL2Js
dWV0b290aC9idGludGVsLmMgICAgICB8IDggKysrKysrKysNCj4gPiBkcml2ZXJzL2JsdWV0b290
aC9idGludGVsLmggICAgICB8IDYgKysrKysrDQo+ID4gZHJpdmVycy9ibHVldG9vdGgvYnR1c2Iu
YyAgICAgICAgfCAxICsNCj4gPiBpbmNsdWRlL25ldC9ibHVldG9vdGgvaGNpX2NvcmUuaCB8IDEg
Kw0KPiA+IDQgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0
aW50ZWwuYw0KPiA+IGluZGV4IGUzYWQxOTI0NDA1NC4uODQwN2U5NzM2YzYyIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0aW50ZWwuYw0KPiA+IEBAIC0xMzAwLDYgKzEzMDAsMTQgQEAgaW50IGJ0aW50ZWxf
cmVhZF9vZmZsb2FkX3VzZWNhc2VzKHN0cnVjdA0KPiA+IGhjaV9kZXYgKmhkZXYpIH0gRVhQT1JU
X1NZTUJPTF9HUEwoYnRpbnRlbF9yZWFkX29mZmxvYWRfdXNlY2FzZXMpOw0KPiA+DQo+ID4gK2lu
dCBidGludGVsX2dldF9kYXRhX3BhdGhfaWQoc3RydWN0IGhjaV9kZXYgKmhkZXYpIHsNCj4gPiAr
CWlmICghdGVzdF9iaXQoSENJX1FVSVJLX0hGUF9PRkZMT0FEX0NPREVDU19TVVBQT1JURUQsDQo+
ICZoZGV2LT5xdWlya3MpKQ0KPiA+ICsJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gPiArCXJldHVy
biAxOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGJ0aW50ZWxfZ2V0X2RhdGFfcGF0
aF9pZCk7DQo+ID4gKw0KPiANCj4gYWN0dWFsbHkgbGV0cyBub3QgZG8gaXQgdGhpcyB3YXkuIE9u
bHkgc2V0IHRoZSBnZXRfZGF0YV9wYXRoX2lkIGNhbGxiYWNrIGlmDQo+IG9mZmxvYWRpbmcgaXMg
c3VwcG9ydGVkIGFuZCB3aXRoIHRoYXQgd2UgZG9u4oCZdCBhY3R1YWxseSBuZWVkIHRvIHF1aXJr
IGVpdGhlci4NCj4gSWYgaXQgaXMgc2V0LCB3ZSBrbm93IHRoYXQgd2UgY2FuIG9mZmxvYWQuDQo+
IA0KDQpBY2suDQoNClRoYW5rcywNCktpcmFuDQoNCg==
