Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7ECC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Dec 2021 18:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhLUSnu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:43:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:13225 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231534AbhLUSnt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Dec 2021 13:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640112229; x=1671648229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/67DQNoNscsWNsfabLLBB/gabRqrnWXi9Ys56KDdBkM=;
  b=ZxyNSWBxYa0c9Dj0asUxIwbbfABw1+LjH7pWZLjeuXYAa1OIZT9QOZtH
   rh+xzi/KJFxnZ8czxUrU86kEpUH2k5PLFfhQIHPl/RWM7AnHJrCEyEWKC
   3HTC4E8CkbIDrGwq8XqHvN3GsyEj/mkEu4lMskOKnUTectDpeEjE76OpD
   wGC8UD8LbJpGEoZyhb1HdkpiRC2ngIBtkGj60Tkk5+4bRHHIMLJ6lLG70
   Y3EDYvsmDxo0Aqfn3/oNNXHGrgEy+sNgYDGAHCemFZsaJaYGX5AJZVOU+
   1cv0LH8K0SRoDO4S2y0bWK3y73haP878j97FW1J3CPveg1a039uNAW/C1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240693458"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="240693458"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 10:43:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="484510960"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 21 Dec 2021 10:43:49 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 10:43:48 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 10:43:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 21 Dec 2021 10:43:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 21 Dec 2021 10:43:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBeHVqfdf9t2QtW+wpXjMpydneefnAAqXSQU7pvhoJgJ+Ncqmzn5g5RiAkVueZFVcTh9YfI9EaDCte43drvC+LPMas4LK1h3UXr5o+FOa42kfGXEODV+NuW9JlB0JMnHHVOLxBmxaKbgFO/8fDIRcQqQOsUcA8+gmJIBimtfUbVf4nuY8w6XdGEb8sSdbmiU32uYinKmpy7aGrnhVj2uU0kwlq4exh1Hsx9XlIZ/quTU0F1oeXsQl7Y5ihIcI7Nc4oBC0aMq54GHdc2tFv9UXuT0nt05eeU+WKrzryd0p5N8VgsmUl6sRPzGFUI5w4kjv6bthjhxcaMJyxDFmTfqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/67DQNoNscsWNsfabLLBB/gabRqrnWXi9Ys56KDdBkM=;
 b=k8FwZ0ztsZqPhSOHKSjnvakdMYgmngxG/7qT03XqY+IhTaKmag8Ym0RR/EWhkMkgutjOr9RQXogKzywnHlAEKT9RfvyvNgsqKemNlvgHtHIrE9YCmNU2ehCNf+1nBiG1t66KLlw/t67Ijcu1m7FedHajNmJPPvlACxTCZHfW6d3RqfUgNwZRlom+ERVBWew9+boe+kTndpiQJVawJzXupuoAcitdPynUZdJApppua8DeP9cGkDm0VFIZUMOEaPPzvjGn9FfWRrXD1OsgZx0zDz0ViiJ51Fis7WDKKc1JJXWae1YcaTTGHgyUlXgLjWkO2ZNzt9IJuLu1iECHcycDaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by MWHPR11MB1725.namprd11.prod.outlook.com (2603:10b6:300:2a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 18:43:45 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::5953:2244:53ea:b68f]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::5953:2244:53ea:b68f%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 18:43:45 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "K, Kiran" <kiran.k@intel.com>
CC:     "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Fix MSFT extension support for
 Intel controllers
Thread-Topic: [PATCH v1] Bluetooth: btintel: Fix MSFT extension support for
 Intel controllers
Thread-Index: AQHX9hv5eM+rxfV4ik6ogKIorFojBqw9SSOA
Date:   Tue, 21 Dec 2021 18:43:45 +0000
Message-ID: <37989bf2fb9df06c07f344af70b77a2478d1799a.camel@intel.com>
References: <20211221034246.2416-1-kiran.k@intel.com>
In-Reply-To: <20211221034246.2416-1-kiran.k@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-2.fc34) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf4ae568-6f72-47ad-4376-08d9c4b1d1d6
x-ms-traffictypediagnostic: MWHPR11MB1725:EE_
x-microsoft-antispam-prvs: <MWHPR11MB172581C093DADFE821B155F1FF7C9@MWHPR11MB1725.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XZNHQIuOk72FIc9/EVCb0+SnLK1mAjlu1RH9kw3CEwiSY/LN60KGZaTSr2/J/bNquk22OVckwvA45jmWcP9CtKJ1o3MNmg1/W7oPM5LrWWofR9+XgerUJAL/nnJcVfqDM6mQcFjIN8NZOir7XcZma+sSVzsclEdsKcS3H7y8cSXzIBMAo6Q463oLPddEmTK5iOs0Fs1X9vhQ3O3yWJ00qJlJIaa2f5lhqfToe3B91Tp91MlP4YkvDBduW1Bkc7YYndc1rfzHDJT2F8zTybRxFmPQF9bo6lJKmmApYE2oRzpy5UIGr/Q8PMCror0vK7NIPhlrz+/WlMGLsv6DBi3FYJGNUzwiNgaGzFtqIxCWL2eHbiGiZiLZw8s6FbvjRRRUJ7K3Iz/UWcA5VBWSAvnbuyTxSchQRCphmfE6gqZm/j9V+88jE21wD7cMxIIM3cC4IC5ylrL06/9hYQAMmyDDJNaSFuw1PGoKBiCksP1jw0nwZYQO3wnZYKhHJ+F1V0PBlsz9OHI6PIry7sa38F+Ceo0Z9YpBmQo/0nYzK5TCDPrP74181/1gss75XiU1ohUrM3Sxvdfl5VzLQhWQzcYc/yqY9RsC68qKgCoHdlFc/NSvhxrtTcCEje4qYd3svjGyLXleLl4FhVyEOxXdFAWboxPubT8xjuiC7trEro1svoZns8bIq4Czr2th0QsqkVkbOquRl6UqaxjY8eMwZPZmjjT6eAHQmdopJssIrnOxi8MriTHAATXGdvEdYRx4mubbR7RZCD66vTWoeLgcFac1d5YJe5UZYJCcKa+tPD1HiaU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(107886003)(54906003)(66556008)(66446008)(66946007)(66476007)(86362001)(64756008)(4326008)(8936002)(26005)(186003)(2906002)(38070700005)(966005)(6506007)(76116006)(6486002)(2616005)(8676002)(82960400001)(71200400001)(38100700002)(4001150100001)(122000001)(316002)(6636002)(6512007)(36756003)(5660300002)(110136005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2xyY255RHcwb2xQa3ZHdmRnRS9VMzdvRmdKWmNFMkRBSERUd2RvOVBPODdO?=
 =?utf-8?B?eXMrSVlrNnpSNkhZSVYxMk5HRXJaa3VVVUp4Tm9KSkJjcnBGckhLNkZPVkNa?=
 =?utf-8?B?TEVPQXFBTGx5eDlST1h5b2ZEVzBYQllERVBGeDhoZWZBUFdRSUxNQlhiZk5F?=
 =?utf-8?B?SERxOHZhYUVTVXRFWWRvUlBOWGcwdGdYNjZNMFhVc21QVzFndlAxTCtnQWMv?=
 =?utf-8?B?c2N0TjV4SjVTVXowOHFUTnp0eXNwOEx5RVRncVlkMkNSTGZzbmVkRTllZmxj?=
 =?utf-8?B?Y09CdXB3dWdKSzNyejczWWxUbUxJUS83NllLc3hHWFYzVzZvWnh4N2xZeUVI?=
 =?utf-8?B?RlpPWVZPc24yamxWcWd4KzJSamFhYS9HSkZOdVNPbGhneTVZVEFPSmc5a1Z3?=
 =?utf-8?B?YlJNRkQrSG5scklmWUxsSVZlRURQSmhQalQvN3BMWldKOVA3TjB3eklVQjln?=
 =?utf-8?B?OTg4M3RzbWpSMFdIMTB1VnhUZ0FRcjc2SGdJL2FyN2ZQRUZRSkVrZ0UwMzlG?=
 =?utf-8?B?L3lmK1dHdWI4UGZ1NDg2bFk0Y1pWUk5aejdYQzF4OW5zWW1pOUkwRitXc1lR?=
 =?utf-8?B?cHdMY21Nb2dwbUZ4WVI3R2t4Mk9oc2daUUVUaVVXMHdMYUMyVEIrbUFVNWs2?=
 =?utf-8?B?KzBNeUxqYnhWTlkwQTYySzIyWlU3OGVTVy9UWmJTb3V3SkM4WmlSbHJ6RWxi?=
 =?utf-8?B?aVhEbEU2Q2NLcjROYU1DQ3lQRzc0bHFnVWNBa1pEOUVkSjU0ZnphTHkrR2VO?=
 =?utf-8?B?WlJMRTVOZXpYTDRSNnh5SGRxQXRrS05jaHdKQkdEOWpmdHplR0xDMm9iNnE2?=
 =?utf-8?B?S3gwYVkrZmYvWjBjb1ZOSnRoTFRPandnT3c4OGdacmV4RjVEeVRzbVBNdGtU?=
 =?utf-8?B?ZmVyeXlVSldEUjB2cENOQWFvN2FhT0FiV2lBbEhLZ01yTXhOK093RG9sUVNn?=
 =?utf-8?B?cTMvbW9VYTJ5ZHZOTFkxdFBUcUNjczZUWWNiMUxWY0lZT0N5ajVmSERUVm5l?=
 =?utf-8?B?N2tza3NzWEIyT3dtM040TFNzaDZLaEdRdTF5Ym9mSEJCcjNCVk50VzdzdnFs?=
 =?utf-8?B?dVRoZlhJTUNVL3JETVZtZjA2dHN4b0psdGtMVDVGV1JYT2txMmJjOFdITzQy?=
 =?utf-8?B?cnhOOVZtekhsenI0U0k2NHlhZVV1WGFycUpET3VjVyt3eERFc0NiQjEzSHlH?=
 =?utf-8?B?SXFkcC9PRFZPWmliWFF0dlVQL2llSnhGeENGa3JrRVh2Szg3UDdsSmlHK1B0?=
 =?utf-8?B?ZkpFeithZ0l1czZGaGl6WE9zMWtGUXBCR2VES3pBRExjN2lZWFpib21tV3d6?=
 =?utf-8?B?Q0QyZEIrZVREajFTNmlDdGdFc3VBT0kwYllSdTNZMjczenFXVEdoeFRGSzFs?=
 =?utf-8?B?NzNKbUZhL0d0c2lHVC9rYUZqbVBoUHhrWEo3LzRRVTJFRnB1UVNveUtpbVJI?=
 =?utf-8?B?cWNIU20yaDBaTzF2ZDRmZC84WDBmMGw5U2tmTVVXVmRXb2dNTFpqT3VnM2Jz?=
 =?utf-8?B?VEJDRHFXZWkzczRPWVkyVmp3RGtQZjZEb2lWVVRORE1CQ3BodWYyM0xJZlFX?=
 =?utf-8?B?VDc4aCtQbXozLzJqTlIwMzl3LzNDY3FuOXgzQzRlbW5udHYzdndra2RhVzR2?=
 =?utf-8?B?S0lCN2V1V2VJOUF5c2ZmUlU2NkFscWxVaDk3a3ZzVEpNYXhsV3d3emczVlVi?=
 =?utf-8?B?Q2V0QnJtQTB5a1EzN0ZZTi9JWFhkQm9lUFo5VEhYSTM5TlpQWU04dmJ5WnVX?=
 =?utf-8?B?RjB6VnMvSnY3M2kwb0FTNWVPMEMyaExodW1ZM0NnMitKd2ZxN2NDckphQ1Ey?=
 =?utf-8?B?UDVDeFBDcnN2ZytKMHpuY0NsSFhtcFh6NHIwLzI4V0RtQXlkWlRVOHdHUTJT?=
 =?utf-8?B?ck5sOTNLWUU3U3cvYXdISmw2OUhsNk9FMzc5L1pJcXU5Q2h4QVpTR0hDczkv?=
 =?utf-8?B?eE1COFpNSWtxYWptdCt5YjZmZEYyVUZIdFoxMVNKd3UrSE8rVnluM3dRYzBr?=
 =?utf-8?B?RlE3TWNDeERaM0F6U29iM2o5VUhMK01FVVlJRlJRSnh6M3QvWFZ3cXB2Vkhj?=
 =?utf-8?B?NENmbXZteHFJaGJPSk9KUC9nK2pLaFkxRTNSMnJXa3Y3RGViTnhaOUpmZW5V?=
 =?utf-8?B?SEZFTmR3YnVheVNDdlZOS2tXeERMSHcwc2J4YktDV3l5dTVkcEl3Wndjd0pt?=
 =?utf-8?Q?jkLwZgkJqB33U7ejgfs5GQQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4DEF9348B42DE43B339FC88DB6E578D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4ae568-6f72-47ad-4376-08d9c4b1d1d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 18:43:45.7746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDbxaHqVm4vVWXici5no+O5QIQEwIANvOiPbLc3qlkOX+jDrBPb2+mpxRzcPKvdL1nL14i7kyXUnjm1D9dLJNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1725
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgS2lyYW4sCgpPbiBUdWUsIDIwMjEtMTItMjEgYXQgMDk6MTIgKzA1MzAsIEtpcmFuIEsgd3Jv
dGU6Cj4gRnJvbTogQ2hldGhhbiBUIE4gPGNoZXRoYW4udHVta3VyLm5hcmF5YW5AaW50ZWwuY29t
Pgo+IAo+IEZvciBUaFAyL0pmUDIvSHJQMiBhbmQgQ2NQMiBJbnRlbCBjb250cm9sbGVycywgTVNG
VCBleHRlbnNpb24KPiBvcGNvZGUgd2FzIG5vdCBzZXQgaW4gb3BlcmF0aW9uYWwgbW9kZS4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiBDaGV0aGFuIFQgTiA8Y2hldGhhbi50dW1rdXIubmFyYXlhbkBpbnRl
bC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogS2lyYW4gSyA8a2lyYW4ua0BpbnRlbC5jb20+Cj4gLS0t
Cj4gwqBkcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMgfCA2ICsrLS0tLQo+IMKgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5j
Cj4gaW5kZXggZTFmOTZkZjg0N2I4Li4wZGQzODk3NDY0MzkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ibHVldG9vdGgvYnRpbnRlbC5jCj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5j
Cj4gQEAgLTI1NDksMTAgKzI1NDksNiBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfc2V0dXBfY29tYmlu
ZWQoc3RydWN0IGhjaV9kZXYgKmhkZXYpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBpZiAoSU5URUxfSFdfVkFSSUFOVCh2ZXJfdGx2LmNudmlfYnQpID09IDB4MTgpCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2V0X2JpdChIQ0lfUVVJ
UktfVkFMSURfTEVfU1RBVEVTLCAmaGRldi0+cXVpcmtzKTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAvKiBTZXR1cCBNU0ZUIEV4dGVuc2lvbiBzdXBwb3J0ICovCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJ0aW50ZWxfc2V0X21zZnRfb3Bjb2RlKGhkZXYs
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoElOVEVMX0hXX1ZBUklBTlQodmVyX3Rsdi5jbnZpX2J0
KSk7Cj4gLQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyID0gYnRpbnRlbF9i
b290bG9hZGVyX3NldHVwX3RsdihoZGV2LCAmdmVyX3Rsdik7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBicmVhazsKPiDCoMKgwqDCoMKgwqDCoMKgZGVmYXVsdDoKPiBAQCAtMjU2
MCw2ICsyNTU2LDggQEAgc3RhdGljIGludCBidGludGVsX3NldHVwX2NvbWJpbmVkKHN0cnVjdCBo
Y2lfZGV2ICpoZGV2KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgSU5URUxfSFdfVkFSSUFOVCh2ZXJfdGx2LmNudmlfYnQpKTsKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOwo+IMKgwqDCoMKgwqDCoMKg
wqB9Cj4gK8KgwqDCoMKgwqDCoMKgLyogU2V0dXAgTVNGVCBFeHRlbnNpb24gc3VwcG9ydCAqLwo+
ICvCoMKgwqDCoMKgwqDCoGJ0aW50ZWxfc2V0X21zZnRfb3Bjb2RlKGhkZXYsIElOVEVMX0hXX1ZB
UklBTlQodmVyX3Rsdi5jbnZpX2J0KSk7Cj4gCkl0IHNob3VsZCBiZSBmaXhlZCBpbiB0aGlzIHBh
dGNoLiBQbGVhc2UgY29uZmlybS4KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvYmx1ZXRvb3RoL2JsdWV0b290aC1uZXh0LmdpdC9jb21taXQvP2lkPWEzM2Q4
MDViMzIyNTgzYTM1MDVlOTVmM2U1N2VhZGE4MWNhYzM0YmQKCj4gwqAKPiDCoGV4aXRfZXJyb3I6
Cj4gwqDCoMKgwqDCoMKgwqDCoGtmcmVlX3NrYihza2IpOwoKUmVnYXJkcywKVGVkZAo=
