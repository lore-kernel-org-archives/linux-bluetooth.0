Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49421C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Jan 2022 07:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiACHXw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Jan 2022 02:23:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:6491 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbiACHXv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Jan 2022 02:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641194631; x=1672730631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yVr4EhqhLTZThwT7AhnPoLzncY+XvWeQoRk2CaiPhdQ=;
  b=YDfXsgj5IPwctuVyB84+9FcmNgiSgfM+l/fWwgGXoKZBMr+luIn+mLlZ
   dDjlVYbCHMDrRSaSjYtNChPaySrYXvkmA2MUr5etVwpYwlwEZDxnwpGjr
   3QW9D9+2Z3+jlwn21PPpQF7JegSJce1fa8G8Uu8AzEyB1oTsKJMBYqcKN
   IuaOPy+LW7Mz4ByBCpPZGfx/KBxI6fEhX8paKS/6+uDxJ1shmJC2HPC0/
   2wHbVTRQTE82C7j7OmuNXwp+bs04tOozNJ3C1ufWEctcJZ+Negeho7XlP
   OH0X94pLBCn7ZfsutPD8AuuMEXXXryc/v+sVl7+EO7zjrIE8V6fVAhevj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="242229726"
X-IronPort-AV: E=Sophos;i="5.88,256,1635231600"; 
   d="scan'208";a="242229726"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2022 23:23:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,256,1635231600"; 
   d="scan'208";a="620226365"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga004.jf.intel.com with ESMTP; 02 Jan 2022 23:23:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 2 Jan 2022 23:23:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sun, 2 Jan 2022 23:23:50 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sun, 2 Jan 2022 23:23:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofvgepqAQtz+qn8eGGi16gceOefKOOfEjA9iB5WT9y7hR/gYRxh+PfrGTBdg89kVH1bhkQAXsRMeav+GGlbDJoVBo6uMoEQqJ5iNMN+zc6q8alBqqJYI3l65rrUlqkvZxUgXxTvPR8mSRJh0EE+oT3MG4kBViIPRfcl4+oNvUzw+lXaZmvQBOIE/VJP50Hn8e5XjTfTj0q53LGGukWWxmsxRLbKKt6SPqI3T93aD5XQAfjomRCt5fYpzCCuxRta/NAU9A6qCEg8Nmdb/gK8eQoIkF9UTySfDbPxtNtfEfZG5ajTcYrT0EZsxzfJZRzMAr/aOvxzVDSWL0rFSzv7ulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVr4EhqhLTZThwT7AhnPoLzncY+XvWeQoRk2CaiPhdQ=;
 b=n1R5hEF+yiXier22a7O1rpX2W14A1ECEspQ+gReq90Zq8Pzb/sbdL3oA+b7giKO7P6m9E+GKnlfY19pAoghppW0/7fbtQqn1C7ep94QE2HEHdGashUa79Q6mB1apNnpCEyBfIIgykpIdfkbkdDmmM47GRigib9TnH4aRUQUHxwpI3bgH6VKrPSrFdcEUk0XgIzJlvc//qjmcUpUO0NhtVGcKFmi4XDvn1WySVtYrj+PikhKUKqhlYOB6dehJsPLRPK0IPwtCAU1mbQkwunvPD4NRp7JUVoY1qs8ST68ivmAN37IoMYL/6AKIRTlHGciKiqzeLzluzIwgKQMLTZJYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5624.namprd11.prod.outlook.com (2603:10b6:8:35::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.15; Mon, 3 Jan 2022 07:23:49 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::843c:97bf:61fd:5151]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::843c:97bf:61fd:5151%4]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 07:23:48 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     "An, Tedd" <tedd.an@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel: Fix MSFT extension support for
 Intel controllers
Thread-Topic: [PATCH v1] Bluetooth: btintel: Fix MSFT extension support for
 Intel controllers
Thread-Index: AQHX9hv4LO8mnyiYvk2t7wjJ3G+qUKw9SSWAgBOv/rA=
Date:   Mon, 3 Jan 2022 07:23:48 +0000
Message-ID: <DM8PR11MB5573230E8341D73A14836F34F5499@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20211221034246.2416-1-kiran.k@intel.com>
 <37989bf2fb9df06c07f344af70b77a2478d1799a.camel@intel.com>
In-Reply-To: <37989bf2fb9df06c07f344af70b77a2478d1799a.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b5d44e8-b1fd-43a8-84cc-08d9ce89fc5e
x-ms-traffictypediagnostic: DM8PR11MB5624:EE_
x-microsoft-antispam-prvs: <DM8PR11MB5624498BD7562717FDFC2705F5499@DM8PR11MB5624.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nqND7hHMIixaUCyRPFLWatirJzcqziOtTw9Rps91OwJjCEOWJWdVOKgmBedZGBC881IgJYj+27aWREPF+CGyzQp57ijm1RrrkvfCH0xqdoIii9+e8Ev9DuVLC9Z6TMkenGO7u5gJuE2MMXGQuc4DzJDH5PWOy5Z6Z/tgjevu1lWWZU19LjdB8jWHZq4UaaoNQc2WpTkg/vE43e1Ta/LD37r0eByiD6f1RQ7ZkbGs1t/FWwADx5wsj0trdaUhI5geYII1J8FXAP6qvVuKYXoxBTHYYe9fkOlMzOX9eX5oHQHIaT/rORJ1v6OhJJiOL3GtKRAO9DsAMWKA+fLiDHlNFjaQJBKFHBqWrLxY3c/0MvAEv9B+jlZ1nV07eVihmfJJ8rBnIfkgpsx6AhmqeXEwTrp3APrk2uZHls/Jvms0RnPthj3qHOX6D8XCcvb5eQIBW63gCcDaoMucm0GOqNcPPmZZac9dZM3N8CFiZCSXEn2h75qlhmXdnndmUPqWCb0XejyGtWxgybfl/eyCtD1AOvDnUZuL6jqOaWxzG34CObr2pRiTHsdDbz5Ep9Cl5rDqHHTMNh782MS2Y9QEzfAmatpeshSYCBoOScCXmjg9dFWICYOk0oX/GdBFD2Dgjd9BqUisDFB2uQKI/Pf7aZRPLehOumU5zkI3IWnGrFBHwOwSquVGX5xpwJccMx8Lrpip4WO92jaX1bWfQbn6QCB4zSILQAFkAObp0cd0isFST8UBJaeMW4Ab8tnAkay+dQLa7ZmDExvVXHq+o3aXqFEeUh+tGQrF/jBq49BbiwJ45yg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(66446008)(2906002)(52536014)(66556008)(66946007)(66476007)(76116006)(9686003)(33656002)(64756008)(8676002)(5660300002)(186003)(55016003)(84970400001)(110136005)(71200400001)(8936002)(4326008)(107886003)(54906003)(86362001)(122000001)(38100700002)(4001150100001)(6506007)(38070700005)(82960400001)(316002)(7696005)(966005)(508600001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym55YlNvck5lM3loNUZvTnZLckV2YXlhODJ5enFEakM1SjRoTEFEQ21FM1BT?=
 =?utf-8?B?eXFPaysrYmVmeVBVOWNSZ3c2bS9oQkYwc2JrWU94azJtT2hLT3RGd1R4MlY1?=
 =?utf-8?B?aUM4TzhpZzZ5MlErTTQ1UFVQejBFNUtsMTJOQU15RktUUVA3UGlLUWpSMWJ5?=
 =?utf-8?B?ZWdodnR5TW1JMkk4a0hQdTVoUzR4N1EzVG1hYkRGZFVteGJjSkw3SzFNbVhH?=
 =?utf-8?B?ZW8wSFMvbzdIYmVkcThjMjMvaVFBMVlWeHFJVEFKV3hCcGkxd0UyZFdWSE9u?=
 =?utf-8?B?RHNhRVd3aWZoWlJHdE1LbHMrdVhaOEZYdmx6RllJVUJyaC9Kbms5bUFEY0Qz?=
 =?utf-8?B?TmN6RzJOUGcvWm1BZFBDT2p4R0hOTzNLblNJeHFTdmMvYmg5Y2JpWU9LTk52?=
 =?utf-8?B?ZWRxanJXZjYzbU90a2xUWHZnTHVKYTI1YXZudXBkSHFrWVZnV3Ywd2pGaExs?=
 =?utf-8?B?U25PNE56dWczdHRMdHkrOWVjOHZuU0FRVFV1Q2FacWd3VjQveVhBdmFlWGVu?=
 =?utf-8?B?V0xKemVGTzFaUktYZmYwbnRMMjRndGJaKzhhaE1WaXlVSVNGSW45S3VBM1RX?=
 =?utf-8?B?VEp3UjJDMmttVVJIV3N3STNLZHUxSFBDaUFFUVdiZjNLM1JzOUV6ZmluL3RC?=
 =?utf-8?B?M2NWNHh1bW44eWZUd0V0TjZudEd1YUhzbk9Dc0NRejF4eHF5b0UreUlJUHBi?=
 =?utf-8?B?YlVaRVZ3SjBIeFNQbHk3bmZlSlRYYTRNLzVHN2VmNUVvMGppblJ3SDJmdEJV?=
 =?utf-8?B?NGRtSXFaMGhGQnJXeUN5OHNLc3RiUzV6N0hSMVRRWWhxaFcweHg0L1dQc0t3?=
 =?utf-8?B?UndPR0t2cm9KVTBaWmZzZEdJcmNEMTFwY3FsT1JhMjk5ODlscU0vM01uZTNG?=
 =?utf-8?B?clNrMGp1cFd6eU91V1NHRVhtM0JoNHJERGdRck8wVENqakxOQjV5d0o3dnZS?=
 =?utf-8?B?QzNjcHBjbTVsYzBybGtYTTNXcHJWNG1BNmVmbDBFQWlQVmNDVFpJNXlGQmhO?=
 =?utf-8?B?UHVZc3FuSnNITSt0d0JNMDdQR0tCYVdabXNMaEYzTXhUeHNDVitUWXdXQkl2?=
 =?utf-8?B?alRHdGh2UXFLejBIUzEvWTdRdjhwdG9MY1Y1Z1h5UCtjMFV6TmREWjdTTStE?=
 =?utf-8?B?UDZLekRGTjR5QmVrQVloemdLaHErZENhQkRlWVgyeEJIWU9Na2djWlNCdCth?=
 =?utf-8?B?SjJsKzkyUG1WSG5BUUtwUWliS0JlMjk0OUljaE5xRERySVVZencxNzI0SzIw?=
 =?utf-8?B?SUYwZWRKamR3ZVI5enozSUxtVGdYNUE4aGIzRkZpRG1oNm04aGl0TG83ajVC?=
 =?utf-8?B?cnBPNGhYNXpMNFdTSy9oS01KWklTRGg5b0dacTlheWNyd21OMFAwbldBQkZj?=
 =?utf-8?B?SW9FMVVZR1RPMHVvTVI3U2E1REROYlVsa0hpRlQrdFBRTXZPNThDRmQ2cW5H?=
 =?utf-8?B?WllLbnRTenNoVmh5ZktUN1p1eGthUGNGVStSeWVIMGM4Mk5veGcrb3dwenNx?=
 =?utf-8?B?RTR0MnFmbDZQTGtxRWVJRjN3c0FzR0t4Z2ZXcmNHVnhxYnBrc0JDREtLRW9h?=
 =?utf-8?B?Q0N6YkMzaEZKbVdhNk0zVkRpYjNsOVhiWHl0ZDdXcVh5NnJJZzdMa2t5Zkd4?=
 =?utf-8?B?RFlla1hqRkVGVWFkVFdaaFpMbW9iZVZuSU1qRUQxRTM2QU1LUkI0N2RTcEtX?=
 =?utf-8?B?YTczVk8yU3U3WHFOZmpYelh5WnFSWVl4TTV1UENGbXJkRzVJb0FuMklHNHpE?=
 =?utf-8?B?aWIrMThTMk1TSGZhdzNCMFVZUlRUcUF4S0c1QWxvaGdrc3JTNWNVZG5WSVhz?=
 =?utf-8?B?ZW5TdEhGbFQrQjArMVBveWZQUFZtZDZLekV4Wi9VOHdmeEFVeFJXQ1d0aHNo?=
 =?utf-8?B?eFMya0l0dVJpWFJmK1BCZ0lZbm4wM0pZVWVZQXRJMjNvQjMvTDFmd0VhL1RY?=
 =?utf-8?B?UThFenNLY2FhbmF0RVhUMjhpVktQeDZtRjRjenBBS215Zms1VTd4OUcvWSt5?=
 =?utf-8?B?YXlBRHRZaXUxWGVyK1daVUZWQWc3U1NLWnJ3N3ZJR0UwTGlRbVU4dTF0ZE5K?=
 =?utf-8?B?MGtaM3NwWUpjSmF3WVRWVGY2RFdDUnVPTG5xQ1V5aXc4ekRCTFJYMUpWWFBx?=
 =?utf-8?B?TWVrMWE0Mkk1S0Vlb1Rzc0ROQzFSNFJKME01Zlk5ankySjVRQmhRcWdKeTgr?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5d44e8-b1fd-43a8-84cc-08d9ce89fc5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2022 07:23:48.8436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enl4HTHq81zp91bJWP3/dI5bLf9/bdsSI7mU7kWSMBTCCl6LVCDoDYJgTne9Kz7ZlSuBNfIH4fQJw0m1f7aF5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5624
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgVGVkZCwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBCbHVldG9vdGg6IGJ0aW50ZWw6
IEZpeCBNU0ZUIGV4dGVuc2lvbiBzdXBwb3J0IGZvcg0KPiBJbnRlbCBjb250cm9sbGVycw0KPiAN
Cj4gSGkgS2lyYW4sDQo+IA0KPiBPbiBUdWUsIDIwMjEtMTItMjEgYXQgMDk6MTIgKzA1MzAsIEtp
cmFuIEsgd3JvdGU6DQo+ID4gRnJvbTogQ2hldGhhbiBUIE4gPGNoZXRoYW4udHVta3VyLm5hcmF5
YW5AaW50ZWwuY29tPg0KPiA+DQo+ID4gRm9yIFRoUDIvSmZQMi9IclAyIGFuZCBDY1AyIEludGVs
IGNvbnRyb2xsZXJzLCBNU0ZUIGV4dGVuc2lvbiBvcGNvZGUNCj4gPiB3YXMgbm90IHNldCBpbiBv
cGVyYXRpb25hbCBtb2RlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hldGhhbiBUIE4gPGNo
ZXRoYW4udHVta3VyLm5hcmF5YW5AaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEtpcmFu
IEsgPGtpcmFuLmtAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9ibHVldG9vdGgv
YnRpbnRlbC5jIHwgNiArKy0tLS0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9v
dGgvYnRpbnRlbC5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+ID4gaW5kZXggZTFm
OTZkZjg0N2I4Li4wZGQzODk3NDY0MzkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ibHVldG9v
dGgvYnRpbnRlbC5jDQo+ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+ID4g
QEAgLTI1NDksMTAgKzI1NDksNiBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfc2V0dXBfY29tYmluZWQo
c3RydWN0DQo+ID4gaGNpX2RldiAqaGRldikNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGlmIChJTlRFTF9IV19WQVJJQU5UKHZlcl90bHYuY252aV9idCkgPT0gMHgxOCkNCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzZXRfYml0
KEhDSV9RVUlSS19WQUxJRF9MRV9TVEFURVMsDQo+ID4gJmhkZXYtPnF1aXJrcyk7DQo+ID4NCj4g
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogU2V0dXAgTVNGVCBFeHRlbnNpb24g
c3VwcG9ydCAqLw0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBidGludGVsX3Nl
dF9tc2Z0X29wY29kZShoZGV2LA0KPiA+IC0NCj4gPiBJTlRFTF9IV19WQVJJQU5UKHZlcl90bHYu
Y252aV9idCkpOw0KPiA+IC0NCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVy
ciA9IGJ0aW50ZWxfYm9vdGxvYWRlcl9zZXR1cF90bHYoaGRldiwgJnZlcl90bHYpOw0KPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7DQo+ID4gwqDCoMKgwqDCoMKgwqDC
oGRlZmF1bHQ6DQo+ID4gQEAgLTI1NjAsNiArMjU1Niw4IEBAIHN0YXRpYyBpbnQgYnRpbnRlbF9z
ZXR1cF9jb21iaW5lZChzdHJ1Y3QgaGNpX2Rldg0KPiA+ICpoZGV2KQ0KPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSU5URUxfSFdfVkFSSUFO
VCh2ZXJfdGx2LmNudmlfYnQpKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJldHVybiAtRUlOVkFMOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqB9DQo+ID4gK8KgwqDCoMKgwqDC
oMKgLyogU2V0dXAgTVNGVCBFeHRlbnNpb24gc3VwcG9ydCAqLw0KPiA+ICvCoMKgwqDCoMKgwqDC
oGJ0aW50ZWxfc2V0X21zZnRfb3Bjb2RlKGhkZXYsDQo+ID4gK0lOVEVMX0hXX1ZBUklBTlQodmVy
X3Rsdi5jbnZpX2J0KSk7DQo+ID4NCj4gSXQgc2hvdWxkIGJlIGZpeGVkIGluIHRoaXMgcGF0Y2gu
IFBsZWFzZSBjb25maXJtLg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9ibHVldG9vdGgvYmx1ZXRvb3RoLQ0KPiBuZXh0LmdpdC9jb21taXQvP2lkPWEz
M2Q4MDViMzIyNTgzYTM1MDVlOTVmM2U1N2VhZGE4MWNhYzM0YmQNCg0KWWVzLiBUaGlzIHBhdGNo
IGFsc28gZml4ZXMgdGhlIGlzc3VlLiBUaGFua3MuDQoNClJlZ2FyZHMsDQpLaXJhbg0KDQo=
