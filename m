Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1053BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 10:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8205820731
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 10:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S314150AbhAZW7r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:59:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:28032 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbhAZWLC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jan 2021 17:11:02 -0500
IronPort-SDR: dC5/hGj5HsfWdaPqczG7lKy9v0DQWYMyVTTqxGZUnZBg5MzxOc8IWaGe2950GBME4vWPpTOdI2
 8XGvCteBPynw==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="241509398"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="241509398"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 14:10:13 -0800
IronPort-SDR: 9g2sPZqZFimITIFKh/9K/ndSCx1Wq8sy4I510ruWGfuzqCgV0eJkqx8A4qlvm+wQLcGk7ew9h7
 oliPNCofn/JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="429860711"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2021 14:10:12 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 26 Jan 2021 14:10:12 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 26 Jan 2021 14:10:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 26 Jan 2021 14:10:12 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 26 Jan 2021 14:10:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTAKHvHInimIaCqglpjb6VYvtxQUo83WCeiNedbnp5m3EnXMyEuMd722jR8vB2+sjNojywZuTM3qGjnmfyRpUX04vb7HvzXuM8xZMyPMZSYDKqQhJ3XjaxmCcMRbLFIi7oTEpmRduN3lr8VFFTVevVxo4IzwetFv0ZL5eTYaQfqRSG4NHgtS/8dH8arP/LTLMvaYTLTQx0mRyUDzs/3YJEFmwyEm3I3hBHjzi1DY3fmX9qHKuqFJAEFZhzkMyxqAYFztvzKEyadz1B7LhIxHfJ0f7jLg+QRISxOMhKOhQWAEhu69G5IQorRRsFOLW0AldQu7YK5gkkX3zoScXgdcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHMjNjMc/CiLUWls32VTsnS7hQOu/jI4dRb3Y3kZ5Uc=;
 b=kcmI7fx/wPVm0pZRq/KU3JJUrOg54krDVgAVdjBQf7Pdwc1tWXHu5QZeiEIF5l5JbKUC6cv1hiPtHWpUH/133sPOlDf13VN/DvXfT4rxuzULiqpUyp6wHtsGmJo3NUW0vZsVkopXOx7zMuMX8jyLbvK/TQaevnzPgkivAnIU86fh3L8BAJeeN3OcYpCjbsa9p3i8AT8k1i3xw9HKrLUyliXyEBXdA0ZtHs/vuB4urOrcniSQjgnrebMcPCooA7keW1V5g8QkTPGGbBmgU8Qj2FNNJnvb/cEdpGPLVo//FdsCt5jFeVT1wZ7SKjM1wfv3U1Q4KGu3Q44Hxp+XKjPKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHMjNjMc/CiLUWls32VTsnS7hQOu/jI4dRb3Y3kZ5Uc=;
 b=rxijwcz9T6KK5WJ6RdjJTTPrlCv8QtERsEt68CUd39VPw718zkchptk7/0F9CEyEMQFo7F0T72kZO2TEpo8eJIFL6tNdPvvb76rYR6wmSYNU38OtWu+7Dq0seKhmYmoySEE9WfylhYuEHJ8GopQN0MXco+dNDtdDZHtkMtTBfMI=
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by CO1PR11MB5121.namprd11.prod.outlook.com (2603:10b6:303:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Tue, 26 Jan
 2021 22:10:11 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::9d55:273b:c716:25f9]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::9d55:273b:c716:25f9%6]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 22:10:11 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] tools/bluemoon: Display FW version of firmware file
Thread-Topic: [PATCH] tools/bluemoon: Display FW version of firmware file
Thread-Index: AQHW9DADuycBAge1VE63yZ+r/+It8A==
Date:   Tue, 26 Jan 2021 22:10:11 +0000
Message-ID: <c4043018c34d56aa5aa3222c6544ae21de706253.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2601:1c0:6a01:30d0:a96a:4337:f1:68f0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf576f4e-1027-4a92-31ab-08d8c247262b
x-ms-traffictypediagnostic: CO1PR11MB5121:
x-microsoft-antispam-prvs: <CO1PR11MB512158B047DF503ADF811D7EFFBC9@CO1PR11MB5121.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2xt/6hCcNt/68pT9n3E0fQZrIQaxHVdxpfUMGSIqzJ+9WNSVxCCLlCID9JrZ+yFogea7pSI6/T2+NrhNXYhqprXRBUPJwvVOQwbaC3Qi1W17k93aqGFHw4wnrgsEMu0da6dFdgMlvrsQdMcAwIzfRKAJyDq8eAJOkKbBAmbQo2ox3k9LkWwNHbhZV7evfKzjMQYQBJIi1FO78qjY1np+7OOsqjgI9gzwieuQ6XPE49dyjycDllPHQTXx6FgZDLoxrc0m2RqovCQpOYTnB/BBNVwO0zXidqj0b2xsVUUsOnSYv0g0W8ON5Ac+m9UA3t8v/B0tQTtwppHCDMzus5flu8yrw3NOOwIbk0kQ4oZJtYh6wc0/2tlld188rZnOd8lNWxUZf6hUEUFiC54jTXGis/CaQ6rmaIMi/M83d47El9uv1uc2/69AqlXXVs/acOwEE82AUNrqWCoFMQUdV1fZoWJ30qRaRvzdzKpZ1S/NRGa/SqPRQYoSlIC9lhEK0RqEDVWehDMKuk6Ek6s0GkG4BQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(6916009)(86362001)(66556008)(83380400001)(5660300002)(71200400001)(66476007)(2906002)(2616005)(478600001)(66946007)(6486002)(186003)(64756008)(76116006)(6506007)(316002)(66446008)(6512007)(8676002)(8936002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?d1ExKzZlblN6S2F0S2JMUjQxQ20rM0RwNEpxUWZFSWxyalFFSE15UERTWS9V?=
 =?utf-8?B?diswdUtLRS9jckcyenZUalk0dGZlYUVDdWZmbmJvYUQzSWFhVUJRSGxiOFZI?=
 =?utf-8?B?RDVRZFRNUnUzWjd6bXdzTVE0RDFFbVRpMHB5cU9rRldEV1VGQlpRVDNhL1Ex?=
 =?utf-8?B?QkFaVE43b0N4V2phbGxIejdrQThyZHdhYXp3RStlME80YmxuSWM4M0ZKckxs?=
 =?utf-8?B?eEhYcENpMjFJU1B4S0NtSk1Ua2g5WmM5ZHJQRW5ZZndiZy82SWU5M0ZSMXlz?=
 =?utf-8?B?bFVsMTlRdy95NjhLcjd5OFM0VzhXcHNGWU44YjJzWUF1K0NQZ1ZreUk2N0pv?=
 =?utf-8?B?c21jeTJXcDIxQnhqYU51b1RjZEFmaThXVDZmdFFpTWlrbWFCUk9wbDV0QkV6?=
 =?utf-8?B?WkdORVpVelF5eFlGMDdNbUtsRFY0OTIxN1ZEV2dLNERMSVhENitIWHRjMSsx?=
 =?utf-8?B?UmpLM1NlMG9nS01uZUtneFFBaVVmcjQ3aXFkOFNXcm5qeDAwZmt6a0Z0MXpv?=
 =?utf-8?B?clpTVTVxejcyTUpOTDBnbXpJVzlzZ0hra1UzZlBueXN0R2ZKelZXZDJzZFJq?=
 =?utf-8?B?TFFOcVJJSHNsdWgyT21WTkFBekxJd1hSSEpBOWRRVGlCV2FydjBCRDJLR0FW?=
 =?utf-8?B?RkdnMDJKZlZzS3YrZitQSGw4ejZoaFlqbVRTOXZxcVg2bnhtRlYwUWRTcDFE?=
 =?utf-8?B?OHlRNlBMSUFiK3ZlMExOank0eGRDd3B6TGxEQTA3V3ZGbm5Xc0VYYy9rVDBC?=
 =?utf-8?B?YUNkZHlkNkNIV01IblVUbTIwUnlqaWl4R1NXU3Zjd2R6TnBHcUd6azUxejlY?=
 =?utf-8?B?aXhUYUVpa3BTSHpZc0o2cFRBZ1pQMCtucnMvN09uSzZHRUZiT0JiVzBERElu?=
 =?utf-8?B?TjBUOUZVWmxPampONjRlUTkybWpEVmhROWpsbWw5Y0dwVnRmVk9VRDVaemZn?=
 =?utf-8?B?d2lzMlovQTZHaDZYWmNkWXN3bVBXNXBJbk0vTTA1bk44aU5QUExyZVB3T1Bm?=
 =?utf-8?B?ektCK0dqelEzYmpmRFk1d3VFMnRyb2ZBclF6VTB5ZURaMW9Uc21vaExNOFBk?=
 =?utf-8?B?TUZFeFBRK29Sdmxkelp3TWdrTzl6SEdTbDdMNmgzaEpkeXdodDFjRnlaS2dR?=
 =?utf-8?B?UlQ0V0NPTGV5Z3YyeHE5SHVocDlCM2FSQ0FiYkdPZUVOakd1T0pVNFozbnF3?=
 =?utf-8?B?M0FJem1kUGhkRS9LMjFxUVZWUnZkbk1VYWh4QlN4TTNGRk9YTXF3VHdjR2Zh?=
 =?utf-8?B?Z0d3K1lMbFpVK1Jxb2M4eWtBaWRZYkNDOTk2d1J2RWorTWxWaG9IbnNveEVx?=
 =?utf-8?B?TUVvdWdpV1dPTGdEWVFhSFluMCtqRFBnZW1CUEQyUXI3amJDUm5lYjFvd0NP?=
 =?utf-8?B?OFlmcTNCaVZSZEdRNnhJQXhDd0ViM1BPNVhNWG8rVGZ0MGJCZVlwT3ZrZ1Iy?=
 =?utf-8?B?NlFMOHRwaXdjTDRvTXVuUXo5ZmF1ZEJqdmNNbHh4cC9CL2ZNVkpvaXB3ZHpw?=
 =?utf-8?Q?0h7hGEkVVAKNiqVFVmMkVYIQ/MU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <85ECD1AE3B5E964C9AD6A23DBB39F2B0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf576f4e-1027-4a92-31ab-08d8c247262b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 22:10:11.0691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UadTr1H6NigPJxAQci8RfTaw0PvqWap6uoyxaRDh2PmyZpEEooNF6gH3geqAVc1E3kApvuiHfPtvAcZ7FpVfuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5121
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

RnJvbTogVGVkZCBIby1KZW9uZyBBbiA8dGVkZC5hbkBpbnRlbC5jb20+DQoNClRoaXMgcGF0Y2gg
ZGlzcGxheXMgYSBGVyB2ZXJzaW9uIGFmdGVyIHBhcnNpbmcgdGhlIFdSSVRFX0JPT1RfUEFSQU1T
DQpjb21tYW5kIGluIHRoZSBmaXJtZWFyZSBmaWxlLiBJdCBhbHNvIGNoYW5nZSB0aGUgZGlzcGxh
eSB0eXBlIGZvcg0KTW9kdWxlIHZlbmRvciBhbmQgRGF0ZSBpbiB0aGUgQ1NTIGhlYWRlciB0byBo
ZXggZm9yIGVhc3kgcmVhZC4NCi0tLQ0KIHRvb2xzL2JsdWVtb29uLmMgfCAyNCArKysrKysrKysr
KysrKysrKysrKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL3Rvb2xzL2JsdWVtb29uLmMgYi90b29scy9ibHVlbW9v
bi5jDQppbmRleCA4YjYyYjFlN2IuLjkxMmY0ZjJhOSAxMDA2NDQNCi0tLSBhL3Rvb2xzL2JsdWVt
b29uLmMNCisrKyBiL3Rvb2xzL2JsdWVtb29uLmMNCkBAIC04MDUsOCArODA1LDEwIEBAIHN0YXRp
YyB2b2lkIGFuYWx5emVfZmlybXdhcmUoY29uc3QgY2hhciAqcGF0aCkNCiAJCQkJbGUzMl90b19j
cHUoY3NzLT5oZWFkZXJfdmVyc2lvbikgPj4gMTYsDQogCQkJCWxlMzJfdG9fY3B1KGNzcy0+aGVh
ZGVyX3ZlcnNpb24pICYgMHhmZmZmKTsNCiAJcHJpbnRmKCJNb2R1bGUgSUQ6XHQldVxuIiwgbGUz
Ml90b19jcHUoY3NzLT5tb2R1bGVfaWQpKTsNCi0JcHJpbnRmKCJNb2R1bGUgdmVuZG9yOlx0JXVc
biIsIGxlMzJfdG9fY3B1KGNzcy0+bW9kdWxlX3ZlbmRvcikpOw0KLQlwcmludGYoIkRhdGU6XHRc
dCV1XG4iLCBsZTMyX3RvX2NwdShjc3MtPmRhdGUpKTsNCisJcHJpbnRmKCJNb2R1bGUgdmVuZG9y
Olx0MHgleFxuIiwgbGUzMl90b19jcHUoY3NzLT5tb2R1bGVfdmVuZG9yKSk7DQorCXByaW50Zigi
RGF0ZTpcdFx0JTA0eC0lMDJ4LSUwMnhcbiIsIGxlMzJfdG9fY3B1KGNzcy0+ZGF0ZSkgPj4gMTYs
DQorCQkJCWxlMzJfdG9fY3B1KGNzcy0+ZGF0ZSkgPj4gOCAmIDB4ZmYsDQorCQkJCWxlMzJfdG9f
Y3B1KGNzcy0+ZGF0ZSkgJiAweGZmKTsNCiAJcHJpbnRmKCJTaXplOlx0XHQldSBEV09SRHMgLyAl
dSBieXRlc1xuIiwgbGUzMl90b19jcHUoY3NzLT5zaXplKSwNCiAJCQkJCQlsZTMyX3RvX2NwdShj
c3MtPnNpemUpICogNCk7DQogCXByaW50ZigiS2V5IHNpemU6XHQldSBEV09SRHMgLyAldSBieXRl
c1xuIiwNCkBAIC04NDAsMTMgKzg0MiwyOSBAQCBzdGF0aWMgdm9pZCBhbmFseXplX2Zpcm13YXJl
KGNvbnN0IGNoYXIgKnBhdGgpDQogCXdoaWxlIChmaXJtd2FyZV9vZmZzZXQgPCBmaXJtd2FyZV9z
aXplKSB7DQogCQl1aW50MTZfdCBvcGNvZGU7DQogCQl1aW50OF90IGRsZW47DQorCQlzdHJ1Y3Qg
Y21kX3dyaXRlX2Jvb3RfcGFyYW1zICpwYXJhbXM7DQogDQogCQlvcGNvZGUgPSBnZXRfbGUxNihm
aXJtd2FyZV9kYXRhICsgZmlybXdhcmVfb2Zmc2V0KTsNCiAJCWRsZW4gPSBmaXJtd2FyZV9kYXRh
W2Zpcm13YXJlX29mZnNldCArIDJdOw0KIA0KIAkJc3dpdGNoIChvcGNvZGUpIHsNCi0JCWNhc2Ug
Q01EX05PX09QRVJBVElPTjoNCiAJCWNhc2UgQ01EX1dSSVRFX0JPT1RfUEFSQU1TOg0KKwkJCXBh
cmFtcyA9ICh2b2lkICopJmZpcm13YXJlX2RhdGFbZmlybXdhcmVfb2Zmc2V0ICsgM107DQorCQkJ
cHJpbnRmKCJCb290IFBhcmFtZXRlcnNcbiIpOw0KKwkJCXByaW50ZigiQm9vdCBBZGRyZXNzOlx0
MHglMDh4XG4iLA0KKwkJCQkJbGUzMl90b19jcHUocGFyYW1zLT5ib290X2FkZHIpKTsNCisJCQlw
cmludGYoIkZXIFZlcnNpb24oeXkpOlx0JWQgKDB4JTAyWClcbiIsDQorCQkJCQlwYXJhbXMtPmZ3
X2J1aWxkX3l5ICsgMjAwMCwNCisJCQkJCXBhcmFtcy0+ZndfYnVpbGRfeXkpOw0KKwkJCXByaW50
ZigiRlcgVmVyc2lvbihjdyk6XHQlZCAoMHglMDJYKVxuIiwNCisJCQkJCXBhcmFtcy0+ZndfYnVp
bGRfY3csDQorCQkJCQlwYXJhbXMtPmZ3X2J1aWxkX2N3KTsNCisJCQlwcmludGYoIkZXIFZlcnNp
b24obm4pOlx0JWQgKDB4JTAyWClcbiIsDQorCQkJCQlwYXJhbXMtPmZ3X2J1aWxkX25uLA0KKwkJ
CQkJcGFyYW1zLT5md19idWlsZF9ubik7DQorDQorCQkJcHJpbnRmKCJcbiIpOw0KKwkJY2FzZSBD
TURfTk9fT1BFUkFUSU9OOg0KIAkJY2FzZSBDTURfTUVNT1JZX1dSSVRFOg0KIAkJCWJyZWFrOw0K
IAkJZGVmYXVsdDoNCi0tIA0KMi4yNi4yDQoNCg==
