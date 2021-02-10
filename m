Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D35DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 19:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A7764E70
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 19:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbhBJTKj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 14:10:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:63281 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234500AbhBJTKc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 14:10:32 -0500
IronPort-SDR: uKFRROqJoMtwrBOjY1tCRAeGiv18+dVPocEpeFz615nNuVRZaewjECoIrPqBk5AAftxH/cA+L2
 YCvsqqXFbXIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="179578455"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="179578455"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 11:09:57 -0800
IronPort-SDR: pe21B5BDzT4ns3yknWI5LkZ+wQnuozfu5YicGpF91HzQioa9Q4Qm6ZK9Roku9rDjajEaNHVkap
 OBwJrwB8mltA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="588058744"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2021 11:09:57 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Feb 2021 11:09:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 10 Feb 2021 11:09:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 10 Feb 2021 11:09:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL04PH6YBnQDd0h5zWd0fPs3Cr8Ime5VLAypA4HlEk0wgJVCiT/DAl1AdyYxarJCZYjx0t3PVUomH36DiqOOYGMPKxZuUwE7hJAcNbtsikk1btZYz0DawfAcM8Rftr+0L4EN+QCj/Dt0dD/g+XWhCipQVhZhTv/Qp6TK0v2CFnPX6rjoIYTiXsNRZgxyE5M/QmWa6NSKG5vXVgTjQK42kyH7VNEbI0ZES6+qejK54FUVwD9mVaWlimgiHu56B/+njIC2M3Xkh+bONShI3FXzeQUdaV4sc9uHjUk8zUjiTitghoIvdGMG9gchOeGa+9MLmaz6Nkf1FDQ65UFbkghj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReY5si20OupWXbkZAuwatQ1RDOxxOCNd05itK7eIqIk=;
 b=WeZmwMVGOcm/tM0X5eZeUsqu6eh3eggrK3Gl3NbKMSiVpZlLIUmBSg+cr8Mh/Oy2hNlVOItB4s/MW+VmCS74LGip7hCh+nOWKtpoxIjAliZyvy9/X9JuLvRS3XIChFymQq0T6LrJFLlzoRRiYmxYcjU2hNClWUl2UlAUu8Qged8UI0RNTtEnpSmSF1eh5PAFSbi8NU+Fg9GEBrHOi8svzjfJmLRpcBIlaMvdfTiZwocpteq+dCfO71TtaH8aK9Ucm3//w9g4xdfA40w+4oOUlFzFGd1JbHWpov3J7FOapNWexfngwbXYv881SLTWpEP43FRN6eWfzteudfOgJMYMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReY5si20OupWXbkZAuwatQ1RDOxxOCNd05itK7eIqIk=;
 b=qHN8ydwiUiLoG+xyMEmE5F82SrujeHBU+IRSyzIbcZiCDT6B/yGirJG/yh8IuGHQRlXBHz7xXzCNM+uXC0mMdiGqZIjBQy7CjmO/2Wp/Yk0cMPFfFcopottgiUjfnY9xwcceVL/Ps8nHy5WDrGwXBv4MVFK6bF7Ktt5hhwkzA14=
Received: from MN2PR11MB4741.namprd11.prod.outlook.com (2603:10b6:208:26a::10)
 by BL0PR11MB3217.namprd11.prod.outlook.com (2603:10b6:208:63::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Wed, 10 Feb
 2021 19:09:55 +0000
Received: from MN2PR11MB4741.namprd11.prod.outlook.com
 ([fe80::b882:37e2:4d6a:1ccf]) by MN2PR11MB4741.namprd11.prod.outlook.com
 ([fe80::b882:37e2:4d6a:1ccf%4]) with mapi id 15.20.3846.027; Wed, 10 Feb 2021
 19:09:55 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] Bluetooth: btintel: Move operational checks after
 version check
Thread-Topic: [PATCH v4 2/6] Bluetooth: btintel: Move operational checks after
 version check
Thread-Index: AQHW/86imc0uXLzXTka3MNifcXTs0qpRwQSA
Date:   Wed, 10 Feb 2021 19:09:55 +0000
Message-ID: <b9c71d7433f22ca3d93c623c9239ecf14c53de40.camel@intel.com>
References: <20210210165916.2148856-1-luiz.dentz@gmail.com>
         <20210210165916.2148856-2-luiz.dentz@gmail.com>
In-Reply-To: <20210210165916.2148856-2-luiz.dentz@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-2.fc32) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fc632d8-010a-4cd3-a485-08d8cdf773ec
x-ms-traffictypediagnostic: BL0PR11MB3217:
x-microsoft-antispam-prvs: <BL0PR11MB321785CA8396ABF9AA3C7AF9FF8D9@BL0PR11MB3217.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lC8l4KKgWgipNo8XGjRwi1EqgfFWEO0JX4Y2iyff9mrS3easCUIOxE5jeEXzQl7I5Wn7ORxsWXtVJJRdFUX/X7VJMI7YVg2v98FEt8zrFscTfqMs5MItLZmXkTAftQIKflb25skZD07BfGZKOvJ/ZMgU3fb8Ig4t/Px7cWAE0qzmLCRJhQHiWlaavQ+fFPd5YZqjlFRd17uIVTf/ORnlpvzyV+cMSnDjE8XoEEbCRWSip/4A3xdWkXAhv0VROlhzEBM84JELm6Lv+q0BAfWat5zXG4Ixx8p2X/7g31MNzRmfhl0tCUxVEOnXih+Zgr4a+zOoOsIsHMfk6x408mMQ48iqRjcSTHxOVWO05e1sGO1i5k1rXphl66PkRpjy9SIgkpVqZU6pbNayG8Sbxa6kMTlkLcSSvBuk++r9HDk3H5zNBDNtjuq+CS+NaE4FT8XZK0Z6tD3eGlJzC4VbTvMXwuCEsAhV2Njfe68eRjV6SG72GIkbKc3UiDlHUdDCldryY9JvOuN0FHHsFhHwof+wlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4741.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(366004)(396003)(136003)(8676002)(478600001)(66476007)(66946007)(91956017)(76116006)(64756008)(66446008)(26005)(66556008)(36756003)(83380400001)(6512007)(6486002)(2906002)(8936002)(110136005)(71200400001)(316002)(2616005)(5660300002)(186003)(6506007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?M21tQTRZY3RHdWFucHdYNC95Nko1V0FwbCttaWFUR0YxaWhRQkV4d1VWU0Nn?=
 =?utf-8?B?L3paNWpPaWVOZlo3MFNqcUVNZlljdHRtRktOc2YxNFRaNXBVV25zNnR6NW5E?=
 =?utf-8?B?dW00bk1TOFl3MXo5YVlEOUhrK1pETGhDU0ZoN0czc3JTL2xzeXpUNE9Hd1Ro?=
 =?utf-8?B?SFRCMTAxaWU3K3hnNHdPejhlcWI3dE0yZHZubWJaNGoyTVltRTlQWjZudGEr?=
 =?utf-8?B?Nm5jLzNReG9mOHo2UWVIYUZrWVFZQjl1ZzdaeTBwSGVBM0Q3WUZxWU9qc0RJ?=
 =?utf-8?B?VnZEckR2OWxCdXdTWTdjRVVwdU5YQm9lYXdqRHoyNzJnbUxaYVBCYldTSTBB?=
 =?utf-8?B?VzJLQlo2ZWFJS3daYzFQUW5rSXlhMW1ib21lR2U4bW9EdjBqV25qUGZjaEdr?=
 =?utf-8?B?Q3FPRnZPZXVIVHRES1BZNDdib0hoZ1diM2dlV1M1WGMxc0xBVVBwSjZrbXFi?=
 =?utf-8?B?ZWNUUHZndTI1TGlVTU5OR2FPVkNKK2JUdkVkODI2YzlNQlVBT24zR3B4MVM3?=
 =?utf-8?B?Nkk3dDU1S0x1YVdrNWhYWDA0c3c0L0NhZVdpeXB5Q1JISmRGenBLNWlHNzc1?=
 =?utf-8?B?bStsYlZNNzJZYnl0RDRDV3pCWGJIbG16VFNHMi9HRDAxUzZlejVoamp1OHFi?=
 =?utf-8?B?OGtRUE1UbTZuaXFySVo1empNS1RzajhrTk1RNUk2Vm8zUzVEZUo0bkd3Qzdh?=
 =?utf-8?B?MG1COFpBb3RyRjNtQkJabTBHLytqai9lclIzdU90MnpjbDBuc05NNmliZ2E4?=
 =?utf-8?B?V21DeE9XVnE4aEo5MnZMT2R1OXFjM0owRE5QRlhoVlBRTjBoWnpYS2U4amdr?=
 =?utf-8?B?STNEZmdEMys2NWl0REtCamxES2xQM2U4dnhwajd5QjNHUlFxUWhmd2wzQlhH?=
 =?utf-8?B?TUJZZklHclg1UzNnY3ZueHhzNzVWdTVrMHl6cDVoTW41aEo4RU1vTVFxdnVo?=
 =?utf-8?B?T1lQUFRPbWtDODNMOWh6OU1MQlZqR0FuaE9RM2VHTjJ5a3l3NERPdUo4dHdK?=
 =?utf-8?B?VmRDUzRiUTA1MlV6ZTB2Z2kxNTdmTE9Nem9sd0VZSXJoY2pBVkdHOWdERjZY?=
 =?utf-8?B?NDJLdHFNejM1anpWOE15eWs1Z1JONnRwNWk5WlpqVldJMC9mblBOMHhpU3hG?=
 =?utf-8?B?V2NERTFERzNqQWx3T2NQdTRISFNwa0ppSWVnSXc1cDJkTldySTJJVjZOUVJS?=
 =?utf-8?B?MW5ZOU5rbzduSFZjc0REUmE5bTlBRkZidVlKY2hZN25LVU5kYURmZ3orNGl0?=
 =?utf-8?B?dmwxQ2MwbFJoRVNXdE5JN3dDSFpLODcxYW40VnVLSGs2VDlTajFDMkMzN3Ew?=
 =?utf-8?B?Sk5PVFYzN1drajhhWUh5bXNmSGo5QWhYdTI5QitXMDFnemxaMXJ4ekY4NVFW?=
 =?utf-8?B?UnlleVhUMDZtQkFTelZDZU1mdURZb2xPOG5qNHkyaWpvcjFKUC9jQ2tkUlJm?=
 =?utf-8?B?SVRKUG94N2dTeld0L3NiK3dNN3NjNldPOHQwSHQ5L0ZCVG1NcFlLV1VHd3Uz?=
 =?utf-8?B?VDJ3OExmVjI4YzlGZXR2MGRCYkhoS1hPK0JMT01PQW1wV2pQeFpKaDd0N1J5?=
 =?utf-8?B?K0VCVEkxNFFjemJJcmZlaTBxVmIrcWhHNmdWNnM2RitTRlE1SDFxRTJ6VXg2?=
 =?utf-8?B?dWgrRVh1QzZvM0ZSOUZkVmFENGNaOXVjUElwZVJmZVNQZ3J2cDVEY3d0eHI0?=
 =?utf-8?B?WXBDQWFmZVZGVUpjVWJkZzlmUm5sbjAzaXlNTlltbGJmUkZ1aDNNaWhXVk1p?=
 =?utf-8?B?dWZKeXhxSURGWXMxMElMMUszV1lBZFZmL2FBY3E1OGZFNFJtVFlFWTgxSDly?=
 =?utf-8?B?d05nOHNnanBOcE9zQW5vUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8E3C71826EFBE45A9238D354E82449F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4741.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc632d8-010a-4cd3-a485-08d8cdf773ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 19:09:55.6946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gLABHR962Y85MTlPTpV00ypftVZZbZg9llNR/10OLbkPGYz++xsCrhXjzhrV1TQxE6n0PBW54RkYnAU2GgXcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3217
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gV2VkLCAyMDIxLTAyLTEwIGF0IDA4OjU5IC0wODAwLCBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6
IHdyb3RlOg0KPiBGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50ekBp
bnRlbC5jb20+DQo+IA0KPiBJbiBvcmRlciB0byBhbGxvdyBuZXcgZmlybXdhcmUgdG8gYmUgbG9h
ZGVkIGl0IGZpcnN0IG5lZWRzIHRvIGNoZWNrIGlmDQo+IHRoZSBmaXJtd2FyZSB2ZXJzaW9uIG9u
IGZpbGUgbWF0Y2hlcyB0aGUgb25lIGxvYWRlZCBpZiBpdCBkb2Vzbid0IHRoZW4NCj4gaXQgbmVl
ZHMgdG8gcmV2ZXJ0IHRvIGJvb3Jsb2FkZXIgbW9kZSBpbiBvcmRlciB0byBsb2FkIHRoZSBuZXcg
ZmlybXdhcmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxs
dWl6LnZvbi5kZW50ekBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ibHVldG9vdGgvYnRp
bnRlbC5jIHwgMjIgKysrKysrKysrKysNCj4gIGRyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMgICB8
IDc0ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDIgZmlsZXMgY2hh
bmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgNDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRl
bC5jDQo+IGluZGV4IDg5Zjg1ZDU0Y2E2NC4uMGQwZjY0M2Y5NzJhIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2JsdWV0b290aC9idGludGVsLmMNCj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRp
bnRlbC5jDQo+IEBAIC05NDksNiArOTQ5LDE3IEBAIGludCBidGludGVsX2Rvd25sb2FkX2Zpcm13
YXJlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LA0KPiAgCQlyZXR1cm4gLUVBTFJFQURZOw0KPiAgCX0N
Cj4gIA0KPiArCS8qIFRoZSBmaXJtd2FyZSB2YXJpYW50IGRldGVybWluZXMgaWYgdGhlIGRldmlj
ZSBpcyBpbiBib290bG9hZGVyDQo+ICsJICogbW9kZSBvciBpcyBydW5uaW5nIG9wZXJhdGlvbmFs
IGZpcm13YXJlLiBUaGUgdmFsdWUgMHgwNiBpZGVudGlmaWVzDQo+ICsJICogdGhlIGJvb3Rsb2Fk
ZXIgYW5kIHRoZSB2YWx1ZSAweDIzIGlkZW50aWZpZXMgdGhlIG9wZXJhdGlvbmFsDQo+ICsJICog
ZmlybXdhcmUuDQo+ICsJICoNCj4gKwkgKiBJZiB0aGUgZmlybXdhcmUgdmVyc2lvbiBoYXMgY2hh
bmdlZCB0aGF0IG1lYW5zIGl0IG5lZWRzIHRvIGJlIHJlc2V0DQo+ICsJICogdG8gYm9vdGxvYWRl
ciB3aGVuIG9wZXJhdGlvbmFsIHNvIHRoZSBuZXcgZmlybXdhcmUgY2FuIGJlIGxvYWRlZC4NCj4g
KwkgKi8NCj4gKwlpZiAodmVyLT5md192YXJpYW50ID09IDB4MjMpDQo+ICsJCXJldHVybiAtRUlO
VkFMOw0KPiArDQo+ICAJZXJyID0gYnRpbnRlbF9zZmlfcnNhX2hlYWRlcl9zZWN1cmVfc2VuZCho
ZGV2LCBmdyk7DQo+ICAJaWYgKGVycikNCj4gIAkJcmV0dXJuIGVycjsNCj4gQEAgLTk3Niw2ICs5
ODcsMTcgQEAgaW50IGJ0aW50ZWxfZG93bmxvYWRfZmlybXdhcmVfbmV3Z2VuKHN0cnVjdCBoY2lf
ZGV2ICpoZGV2LA0KPiAgCQlyZXR1cm4gLUVBTFJFQURZOw0KPiAgCX0NCj4gIA0KPiArCS8qIFRo
ZSBmaXJtd2FyZSB2YXJpYW50IGRldGVybWluZXMgaWYgdGhlIGRldmljZSBpcyBpbiBib290bG9h
ZGVyDQo+ICsJICogbW9kZSBvciBpcyBydW5uaW5nIG9wZXJhdGlvbmFsIGZpcm13YXJlLiBUaGUg
dmFsdWUgMHgwMyBpZGVudGlmaWVzDQo+ICsJICogdGhlIGJvb3Rsb2FkZXIgYW5kIHRoZSB2YWx1
ZSAweDIzIGlkZW50aWZpZXMgdGhlIG9wZXJhdGlvbmFsDQo+ICsJICogZmlybXdhcmUuDQo+ICsJ
ICoNCj4gKwkgKiBJZiB0aGUgZmlybXdhcmUgdmVyc2lvbiBoYXMgY2hhbmdlZCB0aGF0IG1lYW5z
IGl0IG5lZWRzIHRvIGJlIHJlc2V0DQo+ICsJICogdG8gYm9vdGxvYWRlciB3aGVuIG9wZXJhdGlv
bmFsIHNvIHRoZSBuZXcgZmlybXdhcmUgY2FuIGJlIGxvYWRlZC4NCj4gKwkgKi8NCj4gKwlpZiAo
dmVyLT5pbWdfdHlwZSA9PSAweDAzKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiAgCS8q
IGlCVCBoYXJkd2FyZSB2YXJpYW50cyAweDBiLCAweDBjLCAweDExLCAweDEyLCAweDEzLCAweDE0
IHN1cHBvcnQNCj4gIAkgKiBvbmx5IFJTQSBzZWN1cmUgYm9vdCBlbmdpbmUuIEhlbmNlLCB0aGUg
Y29ycmVzcG9uZGluZyBzZmkgZmlsZSB3aWxsDQo+ICAJICogaGF2ZSBSU0EgaGVhZGVyIG9mIDY0
NCBieXRlcyBmb2xsb3dlZCBieSBDb21tYW5kIEJ1ZmZlci4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYmx1ZXRvb3RoL2J0dXNiLmMgYi9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jDQo+IGluZGV4
IGM5MjA2MGU3NDcyYy4uYTQ0ZjNjZjI1NzkwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2JsdWV0
b290aC9idHVzYi5jDQo+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMNCj4gQEAgLTI0
NjksMTQgKzI0NjksMzAgQEAgc3RhdGljIGludCBidHVzYl9zZW5kX2ZyYW1lX2ludGVsKHN0cnVj
dCBoY2lfZGV2ICpoZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiAgCXJldHVybiAtRUlMU0VR
Ow0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgYm9vbCBidHVzYl9zZXR1cF9pbnRlbF9uZXdfZ2V0X2Z3
X25hbWUoc3RydWN0IGludGVsX3ZlcnNpb24gKnZlciwNCj4gK3N0YXRpYyBpbnQgYnR1c2Jfc2V0
dXBfaW50ZWxfbmV3X2dldF9md19uYW1lKHN0cnVjdCBpbnRlbF92ZXJzaW9uICp2ZXIsDQo+ICAJ
CQkJCSAgICAgc3RydWN0IGludGVsX2Jvb3RfcGFyYW1zICpwYXJhbXMsDQo+ICAJCQkJCSAgICAg
Y2hhciAqZndfbmFtZSwgc2l6ZV90IGxlbiwNCj4gIAkJCQkJICAgICBjb25zdCBjaGFyICpzdWZm
aXgpDQo+ICB7DQo+ICsJLyogVGhlIGhhcmR3YXJlIHBsYXRmb3JtIG51bWJlciBoYXMgYSBmaXhl
ZCB2YWx1ZSBvZiAweDM3IGFuZA0KPiArCSAqIGZvciBub3cgb25seSBhY2NlcHQgdGhpcyBzaW5n
bGUgdmFsdWUuDQo+ICsJICovDQo+ICsJaWYgKHZlci0+aHdfcGxhdGZvcm0gIT0gMHgzNykNCj4g
KwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gIAlzd2l0Y2ggKHZlci0+aHdfdmFyaWFudCkgew0K
PiAgCWNhc2UgMHgwYjoJLyogU2ZQICovDQo+ICAJY2FzZSAweDBjOgkvKiBXc1AgKi8NCj4gKwkJ
LyogVGhlIGZpcm13YXJlIHZhcmlhbnQgZGV0ZXJtaW5lcyBpZiB0aGUgZGV2aWNlIGlzIGluDQo+
ICsJCSAqIGJvb3Rsb2FkZXIgbW9kZSBvciBpcyBydW5uaW5nIG9wZXJhdGlvbmFsIGZpcm13YXJl
Lg0KPiArCQkgKg0KPiArCQkgKiBWZXJzaW9uIGNoZWNraW5nIGNhbm5vdCBiZSBwZXJmb3JtZWQg
aW4gdGhlc2UgbW9kZWxzIHNpbmNlDQo+ICsJCSAqIHRoZSBmaXJtd2FyZSB2ZXJzaW9uaW5nIGRl
cGVuZHMgb24gdGhlIGZpcm13YXJlIGJlaW5nIGluDQo+ICsJCSAqIGJvb3Rsb2FkZXIgbW9kZS4N
Cj4gKwkJICovDQo+ICsJCWlmICh2ZXItPmZ3X3ZhcmlhbnQgPT0gMHgyMykNCj4gKwkJCXJldHVy
biAtRUFMUkVBRFk7DQo+ICsNCj4gIAkJc25wcmludGYoZndfbmFtZSwgbGVuLCAiaW50ZWwvaWJ0
LSV1LSV1LiVzIiwNCj4gIAkJCWxlMTZfdG9fY3B1KHZlci0+aHdfdmFyaWFudCksDQo+ICAJCQls
ZTE2X3RvX2NwdShwYXJhbXMtPmRldl9yZXZpZCksDQo+IEBAIC0yNDkzLDkgKzI1MDksMTAgQEAg
c3RhdGljIGJvb2wgYnR1c2Jfc2V0dXBfaW50ZWxfbmV3X2dldF9md19uYW1lKHN0cnVjdCBpbnRl
bF92ZXJzaW9uICp2ZXIsDQo+ICAJCQlzdWZmaXgpOw0KPiAgCQlicmVhazsNCj4gIAlkZWZhdWx0
Og0KPiAtCQlyZXR1cm4gZmFsc2U7DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiAgCX0NCj4gLQly
ZXR1cm4gdHJ1ZTsNCj4gKw0KPiArCXJldHVybiAwOw0KDQpUaGVyZSBpcyBvbmUgbW9yZSBwbGFj
ZSBpbiBidHVzYl9zZXR1cF9pbnRlbF9uZXcoKUBidHVzYi5jIHRvIHVwZGF0ZSB0aGUgaGFuZGxp
bmcgb2YgcmV0dXJuDQp2YWx1ZSBvZiB0aGlzIGZ1bmNpb24sIHdoaWNoIGlzIHJlbGF0ZWQgdG8g
bG9hZGluZyB0aGUgRERDLg0KQ29kZSBsaWtlIHRoaXMuLi4NCg0KaWYgKCFlcnIpIHsNCglidF9k
ZXZfZXJyKGhkZXYsICJVbnN1cHBvcnRlZCBJbnRlbCBmaXJtd2FyZSBuYW1pbmciKTsNCn0gZWxz
ZSB7DQoNCg0KDQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lkIGJ0dXNiX3NldHVwX2ludGVsX25l
d2dlbl9nZXRfZndfbmFtZShjb25zdCBzdHJ1Y3QgaW50ZWxfdmVyc2lvbl90bHYgKnZlcl90bHYs
DQo+IEBAIC0yNTUwLDcgKzI1NjcsNiBAQCBzdGF0aWMgaW50IGJ0dXNiX2ludGVsX2Rvd25sb2Fk
X2Zpcm13YXJlX25ld2dlbihzdHJ1Y3QgaGNpX2RldiAqaGRldiwNCj4gIAlpZiAodmVyLT5pbWdf
dHlwZSA9PSAweDAzKSB7DQo+ICAJCWNsZWFyX2JpdChCVFVTQl9CT09UTE9BREVSLCAmZGF0YS0+
ZmxhZ3MpOw0KPiAgCQlidGludGVsX2NoZWNrX2JkYWRkcihoZGV2KTsNCj4gLQkJcmV0dXJuIDA7
DQo+ICAJfQ0KPiAgDQo+ICAJLyogQ2hlY2sgZm9yIHN1cHBvcnRlZCBpQlQgaGFyZHdhcmUgdmFy
aWFudHMgb2YgdGhpcyBmaXJtd2FyZQ0KPiBAQCAtMjY5NCwzNSArMjcxMCw2IEBAIHN0YXRpYyBp
bnQgYnR1c2JfaW50ZWxfZG93bmxvYWRfZmlybXdhcmUoc3RydWN0IGhjaV9kZXYgKmhkZXYsDQo+
ICAJaWYgKCF2ZXIgfHwgIXBhcmFtcykNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICANCj4gLQkv
KiBUaGUgaGFyZHdhcmUgcGxhdGZvcm0gbnVtYmVyIGhhcyBhIGZpeGVkIHZhbHVlIG9mIDB4Mzcg
YW5kDQo+IC0JICogZm9yIG5vdyBvbmx5IGFjY2VwdCB0aGlzIHNpbmdsZSB2YWx1ZS4NCj4gLQkg
Ki8NCj4gLQlpZiAodmVyLT5od19wbGF0Zm9ybSAhPSAweDM3KSB7DQo+IC0JCWJ0X2Rldl9lcnIo
aGRldiwgIlVuc3VwcG9ydGVkIEludGVsIGhhcmR3YXJlIHBsYXRmb3JtICgldSkiLA0KPiAtCQkJ
ICAgdmVyLT5od19wbGF0Zm9ybSk7DQo+IC0JCXJldHVybiAtRUlOVkFMOw0KPiAtCX0NCj4gLQ0K
PiAtCS8qIENoZWNrIGZvciBzdXBwb3J0ZWQgaUJUIGhhcmR3YXJlIHZhcmlhbnRzIG9mIHRoaXMg
ZmlybXdhcmUNCj4gLQkgKiBsb2FkaW5nIG1ldGhvZC4NCj4gLQkgKg0KPiAtCSAqIFRoaXMgY2hl
Y2sgaGFzIGJlZW4gcHV0IGluIHBsYWNlIHRvIGVuc3VyZSBjb3JyZWN0IGZvcndhcmQNCj4gLQkg
KiBjb21wYXRpYmlsaXR5IG9wdGlvbnMgd2hlbiBuZXdlciBoYXJkd2FyZSB2YXJpYW50cyBjb21l
IGFsb25nLg0KPiAtCSAqLw0KPiAtCXN3aXRjaCAodmVyLT5od192YXJpYW50KSB7DQo+IC0JY2Fz
ZSAweDBiOgkvKiBTZlAgKi8NCj4gLQljYXNlIDB4MGM6CS8qIFdzUCAqLw0KPiAtCWNhc2UgMHgx
MToJLyogSmZQICovDQo+IC0JY2FzZSAweDEyOgkvKiBUaFAgKi8NCj4gLQljYXNlIDB4MTM6CS8q
IEhyUCAqLw0KPiAtCWNhc2UgMHgxNDoJLyogQ2NQICovDQo+IC0JCWJyZWFrOw0KPiAtCWRlZmF1
bHQ6DQo+IC0JCWJ0X2Rldl9lcnIoaGRldiwgIlVuc3VwcG9ydGVkIEludGVsIGhhcmR3YXJlIHZh
cmlhbnQgKCV1KSIsDQo+IC0JCQkgICB2ZXItPmh3X3ZhcmlhbnQpOw0KPiAtCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gLQl9DQo+IC0NCj4gIAlidGludGVsX3ZlcnNpb25faW5mbyhoZGV2LCB2ZXIpOw0K
PiAgDQo+ICAJLyogVGhlIGZpcm13YXJlIHZhcmlhbnQgZGV0ZXJtaW5lcyBpZiB0aGUgZGV2aWNl
IGlzIGluIGJvb3Rsb2FkZXINCj4gQEAgLTI3NDEsMTYgKzI3MjgsOCBAQCBzdGF0aWMgaW50IGJ0
dXNiX2ludGVsX2Rvd25sb2FkX2Zpcm13YXJlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LA0KPiAgCWlm
ICh2ZXItPmZ3X3ZhcmlhbnQgPT0gMHgyMykgew0KPiAgCQljbGVhcl9iaXQoQlRVU0JfQk9PVExP
QURFUiwgJmRhdGEtPmZsYWdzKTsNCj4gIAkJYnRpbnRlbF9jaGVja19iZGFkZHIoaGRldik7DQo+
IC0JCXJldHVybiAwOw0KPiAtCX0NCj4gLQ0KPiAtCS8qIElmIHRoZSBkZXZpY2UgaXMgbm90IGlu
IGJvb3Rsb2FkZXIgbW9kZSwgdGhlbiB0aGUgb25seSBwb3NzaWJsZQ0KPiAtCSAqIGNob2ljZSBp
cyB0byByZXR1cm4gYW4gZXJyb3IgYW5kIGFib3J0IHRoZSBkZXZpY2UgaW5pdGlhbGl6YXRpb24u
DQo+IC0JICovDQo+IC0JaWYgKHZlci0+ZndfdmFyaWFudCAhPSAweDA2KSB7DQo+IC0JCWJ0X2Rl
dl9lcnIoaGRldiwgIlVuc3VwcG9ydGVkIEludGVsIGZpcm13YXJlIHZhcmlhbnQgKCV1KSIsDQo+
IC0JCQkgICB2ZXItPmZ3X3ZhcmlhbnQpOw0KPiAtCQlyZXR1cm4gLUVOT0RFVjsNCj4gKwkJLyog
UHJvY2VlZCB0byBkb3dubG9hZCB0byBjaGVjayBpZiB0aGUgdmVyc2lvbiBtYXRjaGVzICovDQo+
ICsJCWdvdG8gZG93bmxvYWQ7DQo+ICAJfQ0KPiAgDQo+ICAJLyogUmVhZCB0aGUgc2VjdXJlIGJv
b3QgcGFyYW1ldGVycyB0byBpZGVudGlmeSB0aGUgb3BlcmF0aW5nDQo+IEBAIC0yNzc4LDYgKzI3
NTcsNyBAQCBzdGF0aWMgaW50IGJ0dXNiX2ludGVsX2Rvd25sb2FkX2Zpcm13YXJlKHN0cnVjdCBo
Y2lfZGV2ICpoZGV2LA0KPiAgCQlzZXRfYml0KEhDSV9RVUlSS19JTlZBTElEX0JEQUREUiwgJmhk
ZXYtPnF1aXJrcyk7DQo+ICAJfQ0KPiAgDQo+ICtkb3dubG9hZDoNCj4gIAkvKiBXaXRoIHRoaXMg
SW50ZWwgYm9vdGxvYWRlciBvbmx5IHRoZSBoYXJkd2FyZSB2YXJpYW50IGFuZCBkZXZpY2UNCj4g
IAkgKiByZXZpc2lvbiBpbmZvcm1hdGlvbiBhcmUgdXNlZCB0byBzZWxlY3QgdGhlIHJpZ2h0IGZp
cm13YXJlIGZvciBTZlANCj4gIAkgKiBhbmQgV3NQLg0KPiBAQCAtMjgwMSw3ICsyNzgxLDEzIEBA
IHN0YXRpYyBpbnQgYnR1c2JfaW50ZWxfZG93bmxvYWRfZmlybXdhcmUoc3RydWN0IGhjaV9kZXYg
KmhkZXYsDQo+ICAJICovDQo+ICAJZXJyID0gYnR1c2Jfc2V0dXBfaW50ZWxfbmV3X2dldF9md19u
YW1lKHZlciwgcGFyYW1zLCBmd25hbWUsDQo+ICAJCQkJCQlzaXplb2YoZnduYW1lKSwgInNmaSIp
Ow0KPiAtCWlmICghZXJyKSB7DQo+ICsJaWYgKGVyciA8IDApIHsNCj4gKwkJaWYgKGVyciA9PSAt
RUFMUkVBRFkpIHsNCj4gKwkJCS8qIEZpcm13YXJlIGhhcyBhbHJlYWR5IGJlZW4gbG9hZGVkICov
DQo+ICsJCQlzZXRfYml0KEJUVVNCX0ZJUk1XQVJFX0xPQURFRCwgJmRhdGEtPmZsYWdzKTsNCj4g
KwkJCWdvdG8gZG9uZTsNCj4gKwkJfQ0KPiArDQo+ICAJCWJ0X2Rldl9lcnIoaGRldiwgIlVuc3Vw
cG9ydGVkIEludGVsIGZpcm13YXJlIG5hbWluZyIpOw0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4g
IAl9DQo=
