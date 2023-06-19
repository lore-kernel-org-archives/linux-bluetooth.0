Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3A0EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Jun 2023 13:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjFSNdz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Jun 2023 09:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjFSNdx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Jun 2023 09:33:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12F21AE
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 06:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687181628; x=1718717628;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A8I4ZAM+XOiP/0wtfwiaIlSSK1Aa6lyv+H7nvCyKWyo=;
  b=cJiTf7g1Emwu3LnAPls5xt2wSIuOyh6g9HyARYYQhwwGfZL0EU/FhYoA
   gW3Lsmaya5QdsejqH9qZm1oYpA7Bapj1qHVJnp/HALNaZLIeQ9DHBJJoM
   FB5BbHn5eso8Ak/aiB0HsykeV2q9DFTIW5ITpU9nVaWmXJe1Em0xkIkvy
   FAz6sMf9+JasLMObxNP0Olij9sF9jnPGt6R8HzVHl0jxSnMlSp4d4Tmzl
   ysGz3gQxniaQzo7LEseugAOTkqAcWCj9RT+UpYWf5SH4ICAkvTQ4Aaqzh
   SV30jERxiRqNUBfeG5hk/Cd4FrS6CnzRZRzgW1qaiKp7/TTQKzJygbk7z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359635594"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="359635594"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:33:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="826582919"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="826582919"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jun 2023 06:33:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 06:33:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 06:33:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 06:33:47 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 19 Jun 2023 06:33:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUV/LMO/vcqP3rf8TDwfIEicJe8X0fNe42lXWnxOXuUJWHpA5b8wXFd14I+93veKyvnEZo9WO5C9rorQu0v9ZJZztZdZ0z/eQTyBchxYA+DDws0o49JDQEl4hlCPpt+7FPqDzMjlLl8mLPdI1lGYPsx72vyqudOj34H7xTEcMNKtlNbTi7tD6XIkbq8bfDRVLLe/QJhdbBNBbWc7TCuhegk5HnRUk/kxMmf+GeODitGI2I6XrVudV8ofeCn20ebVePZxDqiikDIsNc/tGBghCGkiAYr243atIgz980Mi6ZGnILjlQD2hk7RF7uJbflZtHKOLmodre2MhDWkD6lJ9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8I4ZAM+XOiP/0wtfwiaIlSSK1Aa6lyv+H7nvCyKWyo=;
 b=A1dZ3wge5UBg+kieUEdtQs9pla4EXbf9oyWJYi+mdJcz0PcCSbdRHmHORc2fKc8uRDQBZJbUy04a+eHi8yFzRR432zaK4tMBvmj6KItQc0VsPe2pxnxXzvyAxztXaWdsSklvNn3ZvJMrXLkzLsX8vqzZ+GFvRKVOTW2+P+16MhBy7/l9xC2Nbvs+ZECfYaUgK77/M5qj9WW5OoWxE+dYFVLZh2C3jsiKbNx0Y+NMrwLFyftk5LjmuJp/P2bkkwsk4hyx3cFhgUfQ0tX+e2rvETZOKw+IXrmEL4KxDW/mvYl5CDFe1glTEz5YV5+VI6V+/bx7cOHjGTqH3mpQ7wnKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by DM6PR11MB4596.namprd11.prod.outlook.com (2603:10b6:5:2a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 13:33:45 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::7e99:8d7b:b53d:834a]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::7e99:8d7b:b53d:834a%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 13:33:44 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [RESEND v3] Bluetooth: btintel: Add support to reset bluetooth
 via ACPI DSM
Thread-Topic: [RESEND v3] Bluetooth: btintel: Add support to reset bluetooth
 via ACPI DSM
Thread-Index: AQHZnC6ErCXcTyEfIk6VvWKVsr6bna+FWaqAgACUHACADDYPEA==
Date:   Mon, 19 Jun 2023 13:33:44 +0000
Message-ID: <PH0PR11MB75856102569253A398107357F55FA@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20230611064342.1587278-1-kiran.k@intel.com>
 <fa2131b8-0186-f9cf-fb79-1975868934ff@molgen.mpg.de>
 <ed3d6c68-a575-eb3e-e564-0c70acf29c71@molgen.mpg.de>
In-Reply-To: <ed3d6c68-a575-eb3e-e564-0c70acf29c71@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|DM6PR11MB4596:EE_
x-ms-office365-filtering-correlation-id: 70f994fb-2791-439d-90f5-08db70c9cdb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4bUDuDL86PJmNeJFr92ZTZMUbOzmr0a9GRT2temHhE1HLqxkTKpgnfu5cmVdKHggwmEjMd1+m37vtO6AP/qp8KC/fpTU4cEX1POdvkuKYEo+IxqJkLItFjT3of56YYrcOAEOU+gEUYbt7mjs4degsnznTvhJkNOYclU3knaocuFGnvplMkm468kO5xKpIdFyMClQOZcl/nwXEGsyg0D5VJlG+qfbhNxmfA07/Qs0tjUDaVlKzmgqaLlPF/JAQDmyWFSUfqmlutXLeD7OJjprmw2s+eyzvuSms3M9/I4ZSFEtZMyM+XYQah1tU8YO5Yc3V8pky5uqK6o4Q36xolGygKZ6P1a30Kl1HUOSjF12zHSavSm8TtZsTPLDAUNYSwET/V5kOMGjv0bwtrx+p5MvdiN/5QUAjwM4pADIVUCG2FH1OigsYFz0klJwJp2ATjnviZoEEIcAZpe7nAB9eoch/PGgYPdCJq2dghPYEdQo0Wq7o6VV2aUg+3xq9hW4zW+7ST+Veb8jRuI+tiTp9oBUI++piOhm6P3X9Y/f+JtRhXSdu/GWrvWcAndtaQd2bprWlJUiAQi743YAhsDcQ5hnckGeDsbVrXvakqlHH+Y6N1hdTK2nUY6IlmnMJU9WuqEE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(186003)(38070700005)(107886003)(9686003)(26005)(53546011)(6506007)(82960400001)(55016003)(122000001)(83380400001)(38100700002)(33656002)(478600001)(52536014)(4326008)(41300700001)(76116006)(66446008)(64756008)(66556008)(66476007)(6916009)(66946007)(8676002)(316002)(54906003)(8936002)(7696005)(86362001)(2906002)(71200400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3hkaW5FZWtsNW9Ed2pqWHFzS0lVZUR5NklialdubFdUK1NhRDNRVlQ0TDdR?=
 =?utf-8?B?YWEzcFJUNUxWQ09yd0c3bDdsYXA5N1ZBYTFPeDJRZUJpQlRydlZZSUxqTzMx?=
 =?utf-8?B?YUxVRm9rdkphbG5KSGFRYUtQempXbzBHRDJzb3c0U2R0MTZaNThvTkZTZnFB?=
 =?utf-8?B?dVFxQkFubjR0d1ZMU0F1QkM3cE12cXVRSVVxeUNjRGpyV1ZCVXA3RGx3YXJL?=
 =?utf-8?B?dXJlRFhwMnJnZWQ3TExHOXJyV1VPMEc2dUNiR1NzVVAxYjNsVDdMNnBpMmlS?=
 =?utf-8?B?VDdvcjlucEMvQ2JwUUJYK2xRNFhGb2dtRFBFKytCTDYxTVR4VHUrU2ZwR0R6?=
 =?utf-8?B?ZDhURnJxNWJ5LzdqUWp4dlFDeDVxNXBIQjFDMmRJczFXKzZLWjVGV1dpMUxD?=
 =?utf-8?B?eE8xMDJjN25vb3lxUHU2REFQa0x0cUJGblJQM1laOXd1aWgxMmNaSmNnUDdu?=
 =?utf-8?B?VUJvSVRhOFI3czltRWVzcTBFZGRhakltbGJETVhnSzRvbFBaQTJFMXVYdlNy?=
 =?utf-8?B?ZzBuMmhEUkg2Wkt1SlY3OHp1bHhOaFBMVnRlbDYyV21RYXlQQWxXcXBiS01Q?=
 =?utf-8?B?Y1BqS2RUNHUveDNwbGpXTkRkalJwYzVoZlc5d3huSUJTYUozZVpzYS95NWN5?=
 =?utf-8?B?VFd2bXg1ZFJwekdCQVZtRTZPTVlaZWFXS2o2RlI5bE5uNy9QOFBnSVpFaFpE?=
 =?utf-8?B?K2xINGYwdjVvcnRnWGl2VVhjRWZPVDZRRUQ5b2N6aDRoNGNyWlVBWi9VWjRz?=
 =?utf-8?B?bUV3TFlZZUwyTGxHUHRmVFZDcksybjV3YzlIblRYZ0tyTXlwdGxSWFZFeThU?=
 =?utf-8?B?b2NqZGpwVGJjdW9lSVJyVlkzSnVZZGZoN0luZHVETzByNWorUlFCVm9FQXpr?=
 =?utf-8?B?ajZ0QWFRVmRxaHU4dUluNW9qSlRYRjFyTVhWdldYVmdjb2ZCbzV6MWd5UWZT?=
 =?utf-8?B?eHI5NzN0RDdYSkJlcDdTaklqQTN6SjFUbGI4U3loYWRYWEdsZHFpRmw2ZzY3?=
 =?utf-8?B?cEdKTmdhL0JXQ2RZLzc4R0lGeE95ak9HQjI2QXJTWGtxWFhxNGVxeUE0am5M?=
 =?utf-8?B?OEhIVlNqMGVUbmNlVXFWQ1Fibmh1Y0o0bW05Zll4KzJmUFo2WGtFV3V1S0ts?=
 =?utf-8?B?N1AzbFVGK1lRRzhQaWFLcVFCbDNKZTZKTys3U2lMVWVRK1UwS0tvL2F4Y2Rr?=
 =?utf-8?B?amRaQ0xzVld2QzB1UlZ2SlRxMlhpclQ0S0MyVmN1Rm9UNFp4Wmorc3NCYXFM?=
 =?utf-8?B?WHU4WTdJMFRPeDBkeFJTN0JwanpEQUpXNHI1V1o4NGVTeCtoM2Jya2hqTUwr?=
 =?utf-8?B?R2NiM2JvMXpyYjBmK3JENGhiSUkzSmVrVGlaaFluejdwY1dDN1RMbzgrMUJ5?=
 =?utf-8?B?Szd5cWdqY2YzazJ4VXhybDI1QVpxR1VTdTdTY2J5NmlPWjZYRmx3SzBrWXBr?=
 =?utf-8?B?YUZqUnlSMWozUWRSbGwwTE15OEoyVlRvcW4ydSs1MVViZjA4QWV5OTgrWXVC?=
 =?utf-8?B?WUFYUXRXMGRzQWN4RUZWcVRDRko1cjVlNXJ5VVZRQ0w0TGpzalZQL29GT255?=
 =?utf-8?B?NVZDNnk0ZjlzbHFmbG5QdjZsL1ZFQnFzdUYvZ2VvOW5GQVBJeXM0YXI4dXBF?=
 =?utf-8?B?MUhMZlJvNm5RYVhSV3FTblhsRk8zcHlTVkpXa242WTJCcGVycVlRN1dXakhY?=
 =?utf-8?B?bFVZczg5MUVQRGF5a01MTFdsQVhvaENGVTlNNlFZYXhvaWdKbUh3SlFoU3Yz?=
 =?utf-8?B?RVkwRUMreGljRDRXRzVxLy9EUGhWL3pzYUxvMlVFb01XeUltTU1Xb0pKbzZQ?=
 =?utf-8?B?WTlTRXVwWHlkazFVcUJ5Um1wT0lhL2pGR3BaSTBaTkN2bmtOQW9zdU5YMkJ2?=
 =?utf-8?B?VE1yRk5jWFNhTy9oMzhEL1UyZkUzSzAvUCtKTUkwT2dCSXo2YTF3K1pPSzJi?=
 =?utf-8?B?ZmhIdllwL1o5dEVrUFdVNXRZdEtFRGI3Vk9ZYm1lT0RTQjJVRW0wTFB5ZU1M?=
 =?utf-8?B?b2JGb251ZlAyUUpmWkI4RTJqb0NmNFM4MjVieFg1N2diejVNenBrU3kwd2Vt?=
 =?utf-8?B?WldYNUk5Q1RKNDZvL0wrUTlyNUtRaGhtbHRNMStOTVE2SFE2QzFtVG9zM3da?=
 =?utf-8?Q?iEog=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f994fb-2791-439d-90f5-08db70c9cdb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 13:33:44.4678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RiWdXQcFZEL2WNKSVsFh+9s2UKlqTn0NOUTEiMVXlI/e89XFG44ox5pZ45NAZD8SJufxvAg1T6fKudILWEXog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4596
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgUGF1bCwNCg0KQXBwcmVjaWF0ZSB5b3VyIGNvbW1lbnRzLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+
DQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAxMiwgMjAyMyAxMjowMiBBTQ0KPiBUbzogSywgS2lyYW4g
PGtpcmFuLmtAaW50ZWwuY29tPg0KPiBDYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9y
ZzsgU3JpdmF0c2EsIFJhdmlzaGFua2FyDQo+IDxyYXZpc2hhbmthci5zcml2YXRzYUBpbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUkVTRU5EIHYzXSBCbHVldG9vdGg6IGJ0aW50ZWw6IEFkZCBz
dXBwb3J0IHRvIHJlc2V0IGJsdWV0b290aA0KPiB2aWEgQUNQSSBEU00NCj4gDQo+IFtDYzogUmVt
b3ZlIGNoZXRoYW4udHVta3VyLm5heWFyYW5AaW50ZWwuY29tICg1NTAgIzUuMS4wIEFkZHJlc3MN
Cj4gcmVqZWN0ZWQuIChpbiByZXBseSB0byBSQ1BUIFRPIGNvbW1hbmQpKV0NCg0KQWNrLiAgSSB3
aWxsIGZpeCB0aGUgdHlwbyBpbiBtYWlsIGlkLg0KPiANCj4gQW0gMTEuMDYuMjMgdW0gMTE6NDIg
c2NocmllYiBQYXVsIE1lbnplbDoNCj4gPiBEZWFyIEtpcmFuLA0KPiA+DQo+ID4NCj4gPiBUaGFu
ayB5b3UgZm9yIHlvdXIgcGF0Y2guIFNvbWUgbWlub3Igbml0cy4NCj4gPg0KPiA+IEFtIDExLjA2
LjIzIHVtIDA4OjQzIHNjaHJpZWIgS2lyYW4gSzoNCj4gPj4gTmV3IEludGVsIHBsYXRmb3JtcyBz
dXBwb3J0cyByZXNldCBvZiBCbHVldG9vdGggZGV2aWNlwqAgdmlhIEFDUEkgRFNNDQo+ID4NCj4g
PiAxLsKgIHN1cHBvcnQNCj4gPiAyLsKgIG9uZSBzcGFjZSBhZnRlciBkZXZpY2UNCj4gPg0KQWNr
Lg0KDQo+ID4+IG1ldGhvZHMuIFRoZSBsZWdhY3kgcmVzZXQgbWVjaGFuaXNtIHZpYSBHUElPIHdp
bGwgYmUgZGVwcmVjYXRlZCBpbg0KPiA+DQo+ID4gQ2FuIHlvdSBwbGVhc2UgbmFtZSB0aGUgbmV3
IHBsYXRmb3JtIGl0IHN0YXJ0ZWQgd2l0aC4NCj4gPg0KQWNrLiBJIHdpbGwgYWRkIHRoZSBkZXRh
aWxzIGluIHNlY3Rpb24gZGVzY3JpYmluZyBEU00gZGV0YWlscy4NCg0KPiA+PiBmdXR1cmUuIFRo
aXMgcGF0Y2ggY2hlY2tzIHRoZSBwbGF0Zm9ybSBzdXBwb3J0IGZvciByZXNldCBtZXRob2RzIGFu
ZA0KPiA+PiBpZiBzdXBwb3J0ZWQgdXNlcyB0aGUgc2FtZSBpbnN0ZWFkIG9mIGxlZ2FjeSBHUElP
IHRvZ2dsaW5nIG1ldGhvZC4NCj4gPg0KPiA+IENvdWxkIHlvdSBwbGVhc2UgZG9jdW1lbnQgdGhl
IGRhdGFzaGVldCBuYW1lLCB2ZXJzaW9uIGFuZCBzZWN0aW9uIHRoaXMNCj4gPiBpcyBkb2N1bWVu
dGVkIGluPw0KPiA+DQpJIGFtIGFmcmFpZCB0byBzaGFyZSB0aGVzZSBkZXRhaWxzIGFzIHRoZXNl
IGFyZSBpbnRlcm5hbCBkb2N1bWVudHMuIA0KDQo+ID4+IEFDUEkgZmlybXdhcmUgc3VwcG9ydHMg
dHdvIHR5cGVzIG9mIHJlc2V0IG1ldGhvZCBiYXNlZCBvbiBOSUMgY2FyZC4NCj4gPj4gKERpc2Ny
ZXRlIG9yIEludGVncmF0ZWQpLg0KPiA+DQo+ID4gSeKAmWQgcmVtb3ZlIHRoZSBkb3QvcGVyaW9k
IGJlZm9yZSAoLg0KQWNrLg0KDQo+ID4NCj4gPj4gMS4gVlNFQyBUeXBlIC0gVmVuZG9yIFNwZWNp
ZmljIEV4dGVuZGVkIENhcGFiaWxpdHkuIEhlcmXCoCBCVF9FTiBhbmQNCj4gPg0KPiA+IE9ubHkg
b25lIHNwYWNlIGFmdGVyIEhlcmUuDQpBY2suDQoNCj4gPg0KPiA+PiDCoMKgwqAgQlRfSUZfU0VM
RUNUIGxpbmVzIGFyZSBkcml2ZW4gYnkgYSByZWdpc3RlciBpbiBQQ0ggY2x1c3Rlci4gVGhpcw0K
PiA+PiDCoMKgwqAgaW50ZXJmYWNlIGlzIHN1cHBvcnRlZCBvbiBkaXNjcmV0ZSBCVCBzb2x1dGlv
bi4NCj4gPj4NCj4gPj4gMi4gV0RJU0FCTEUyIC0gSW4gdGhpcyBzb2x1dG9uLCBXX0RJU0FCTEUy
IHBpbiBpbiBNLjIgaXMgY29ubmVjdGVkIHRvDQo+ID4NCj4gPiBzb2x1dGlvbg0KQWNrLg0KDQo+
ID4NCj4gPj4gwqDCoMKgIHBoeXNpY2FsIEdQSU8gZnJvbSBQQ0guIFRoZSBEU00gaW50ZXJmYWNl
IHNoYWxsIHRvZ2dsZSB0aGlzIHRvDQo+ID4+IHJlY292ZXINCj4gPj4gwqDCoMKgIGZyb23CoCBl
cnJvci4NCj4gPg0KPiA+IE9ubHkgb25lIHNwYWNlIGFmdGVyIGZyb20uDQpBY2suDQoNCj4gPg0K
PiA+IEhvdyBkaWQgeW91IHRlc3QgdGhpcz8gKE1heWJlIGFsc28gcGFzdGUgdGhlIG5ldyBsb2cg
bWVzc2FnZXM/KQ0KPiA+DQpJIHRlc3RlZCBEU00gbWV0aG9kcyB1c2luZyBhIHRlc3QgbW9kdWxl
IHdoaWNoIHdhcyBsb2FkZWQgYWZ0ZXIgYmx1ZXRvb3RoIHN0YWNrIHdhcyBpbml0aWFsaXplZC4N
ClRoaXMgdGVzdCBtb2R1bGUgZW51bWVyYXRlcyAgZm9yIHJlcXVpcmVkIGhkZXYgb2JqZWN0ICAo
YmFzZWQgb24gVklEL1BJRCkgYW5kIGludm9rZXMsIA0KKmFjcGlfcmVzZXRfbWV0aG9kKiBpZiBp
dCBpcyBzZXQuICANCg0KPiA+IEnigJlkIGFsc28gYXBwcmVjaWF0ZWQgb25lIHBhcmFncmFwaCBh
Ym91dCB0aGUgaW1wbGVudGF0aW9uLg0KT2suIEkgd2lsbCBhZGQgdGhlIGRldGFpbHMgaW4gY292
ZXIgbm90ZXMuIEJyaWVmbHksIEluICpoZGV2LT5zZXR1cCogY2FsbGJhY2ssIGRyaXZlciBjaGVj
a3MgaWYgdGhlIHBsYXRmb3JtIHN1cHBvcnRzIEFDUEkgRFNNIG1ldGhvZCB0byByZXNldCBCVCBh
bmQgaW5pdGlhbGl6ZXMgdGhlIGZ1bmN0aW9uIHBvaW50ZXIgZGVmaW5lZCBpbiBwcml2YXRlICpz
dHJ1Y3QgYnRpbnRlbF9kYXRhKi4NCg0Kc3RydWN0IGJ0aW50ZWxfZGF0YSB7DQogICAgICAgIERF
Q0xBUkVfQklUTUFQKGZsYWdzLCBfX0lOVEVMX05VTV9GTEFHUyk7DQogICAgICAgIGludCAoKmFj
cGlfcmVzZXRfbWV0aG9kKShzdHJ1Y3QgaGNpX2RldiAqaGRldik7DQp9Ow0KDQpMb2cgbWVzc2Fn
ZXM6DQpbIDExMjEuOTAwMzMxXSBCbHVldG9vdGg6IGhjaTA6IEdvdCBpbnRlbCBCVCBkZXZpY2UN
ClsgMTEyMS45MDAzMzZdIEJsdWV0b290aDogaGNpMDogRHNtIG1ldGhvZDogMDAwMDAwMDA3ZjU2
MzJlOSAgLS0+ICpUZXN0IG1vZHVsZSBpbnZva2VzIERTTSBtZXRob2QgaGVyZSAqICANCg0KDQpb
IDExMjEuOTk0NDcxXSB1c2IgMy0xMDogVVNCIGRpc2Nvbm5lY3QsIGRldmljZSBudW1iZXIgMTMN
ClsgMTEyMi41MjIwMTddIHVzYiAzLTEwOiBuZXcgZnVsbC1zcGVlZCBVU0IgZGV2aWNlIG51bWJl
ciAxNCB1c2luZyB4aGNpX2hjZA0KWyAxMTIyLjY3MTcxMl0gdXNiIDMtMTA6IE5ldyBVU0IgZGV2
aWNlIGZvdW5kLCBpZFZlbmRvcj04MDg3LCBpZFByb2R1Y3Q9MDAzNiwgYmNkRGV2aWNlPSAwLjAw
DQpbIDExMjIuNjcxNzQ0XSB1c2IgMy0xMDogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTAs
IFByb2R1Y3Q9MCwgU2VyaWFsTnVtYmVyPTANClsgMTEyMi42NzU2NzhdIHVzYiAzLTEwOiBHUElP
IGxvb2t1cCBmb3IgY29uc3VtZXIgcmVzZXQNClsgMTEyMi42NzU3MDBdIHVzYiAzLTEwOiB1c2lu
ZyBBQ1BJIGZvciBHUElPIGxvb2t1cA0KWyAxMTIyLjY3NTczMV0gdXNiIDMtMTA6IHVzaW5nIGxv
b2t1cCB0YWJsZXMgZm9yIEdQSU8gbG9va3VwDQpbIDExMjIuNjc1NzQwXSB1c2IgMy0xMDogTm8g
R1BJTyBjb25zdW1lciByZXNldCBmb3VuZA0KWyAxMTIyLjY3ODQ4OV0gQmx1ZXRvb3RoOiBoY2kw
OiBEZXZpY2UgcmV2aXNpb24gaXMgMA0KWyAxMTIyLjY3ODUxNl0gQmx1ZXRvb3RoOiBoY2kwOiBT
ZWN1cmUgYm9vdCBpcyBlbmFibGVkDQpbIDExMjIuNjc4NTIxXSBCbHVldG9vdGg6IGhjaTA6IE9U
UCBsb2NrIGlzIGRpc2FibGVkDQpbIDExMjIuNjc4NTIyXSBCbHVldG9vdGg6IGhjaTA6IEFQSSBs
b2NrIGlzIGRpc2FibGVkDQpbIDExMjIuNjc4NTI0XSBCbHVldG9vdGg6IGhjaTA6IERlYnVnIGxv
Y2sgaXMgZGlzYWJsZWQNClsgMTEyMi42Nzg1MjVdIEJsdWV0b290aDogaGNpMDogTWluaW11bSBm
aXJtd2FyZSBidWlsZCAxIHdlZWsgMTAgMjAxNA0KWyAxMTIyLjY3ODUyN10gQmx1ZXRvb3RoOiBo
Y2kwOiBCb290bG9hZGVyIHRpbWVzdGFtcCAyMDIyLjE4IGJ1aWxkdHlwZSAxIGJ1aWxkIDE2MzYy
DQpbIDExMjIuNjc4NTMzXSBCbHVldG9vdGg6IGhjaTA6IERTTSByZXNldCBtZXRob2QgdHlwZTog
MHgwMQ0KWyAxMTIyLjY3ODY0OV0gQmx1ZXRvb3RoOiBoY2kwOiBObyBkZXZpY2UgYWRkcmVzcyBj
b25maWd1cmVkDQpbIDExMjIuNjc4ODY0XSBCbHVldG9vdGg6IGhjaTA6IEZvdW5kIGRldmljZSBm
aXJtd2FyZTogaW50ZWwvaWJ0LTAxOTEtMDE5MS5zZmkNClsgMTEyMi42Nzg4ODJdIEJsdWV0b290
aDogaGNpMDogQm9vdCBBZGRyZXNzOiAweDEwMDgwMA0KWyAxMTIyLjY3ODg4NF0gQmx1ZXRvb3Ro
OiBoY2kwOiBGaXJtd2FyZSBWZXJzaW9uOiA3OS0xMS4yMw0KWyAxMTI2LjM0OTY3N10gQmx1ZXRv
b3RoOiBoY2kwOiBXYWl0aW5nIGZvciBmaXJtd2FyZSBkb3dubG9hZCB0byBjb21wbGV0ZQ0KWyAx
MTI2LjM1MDA2OV0gQmx1ZXRvb3RoOiBoY2kwOiBGaXJtd2FyZSBsb2FkZWQgaW4gMzU4NTE1NyB1
c2Vjcw0KWyAxMTI2LjM1MDUxN10gQmx1ZXRvb3RoOiBoY2kwOiBXYWl0aW5nIGZvciBkZXZpY2Ug
dG8gYm9vdA0KWyAxMTI2LjQwMTQ5Ml0gQmx1ZXRvb3RoOiBoY2kwOiBEZXZpY2UgYm9vdGVkIGlu
IDUwMTMwIHVzZWNzDQpbIDExMjYuNDA0MzY0XSBCbHVldG9vdGg6IGhjaTA6IEZvdW5kIEludGVs
IEREQyBwYXJhbWV0ZXJzOiBpbnRlbC9pYnQtMDE5MS0wMTkxLmRkYw0KWyAxMTI2LjQwNzE3Ml0g
Qmx1ZXRvb3RoOiBoY2kwOiBBcHBseWluZyBJbnRlbCBEREMgcGFyYW1ldGVycyBjb21wbGV0ZWQN
ClsgMTEyNi40MDgxNDddIEJsdWV0b290aDogaGNpMDogQUNQSSBTdHJpbmc6IFxfU0JfLlBDMDAu
WEhDSS5SSFVCLkhTMTAuU0FEWA0KWyAxMTI2LjQwODE1M10gQmx1ZXRvb3RoOiBoY2kwOiBBQ1BJ
IFN0cmluZzogXF9TQl8uUEMwMC5YSENJLlJIVUIuSFMxMC5CUkRZDQpbIDExMjYuNDA4MTU1XSBC
bHVldG9vdGg6IGhjaTA6IEFDUEkgU3RyaW5nOiBcX1NCXy5QQzAwLlhIQ0kuUkhVQi5IUzEwLkVD
S1kNClsgMTEyNi40MDgxNTddIEJsdWV0b290aDogaGNpMDogQUNQSSBTdHJpbmc6IFxfU0JfLlBD
MDAuWEhDSS5SSFVCLkhTMTAuR1BDWA0KWyAxMTI2LjQwODE1OV0gQmx1ZXRvb3RoOiBoY2kwOiBB
Q1BJIFN0cmluZzogXF9TQl8uUEMwMC5YSENJLlJIVUIuSFMxMC5CVExZDQpbIDExMjYuNDA4MTYx
XSBCbHVldG9vdGg6IGhjaTA6IFBQQUctQlQ6IEFDUEkgZW50cnkgbm90IGZvdW5kDQpbIDExMjYu
NDEwMTUzXSBCbHVldG9vdGg6IGhjaTA6IEZpcm13YXJlIHRpbWVzdGFtcCAyMDIzLjExIGJ1aWxk
dHlwZSAzIGJ1aWxkIDM0MTI3DQpbIDExMjYuNTA5NDMxXSBCbHVldG9vdGg6IE1HTVQgdmVyIDEu
MjINCg0KV2hlbiBjb250cm9sbGVyIGdvZXMgdW5yZXNwb25zaXZlIGZvciA1IHN1Y2Nlc3NmdWwg
Y29tbWFuZHMgcmVzZXQgbWV0aG9kIGlzIGludm9rZWQgd2hpY2ggaXMgZXhwZWN0ZWQgdG8gcmUt
ZW51bWVyYXRlIFVTQiBwb3J0Lg0KDQoNCj4gPj4gKyAgICBpZiAoaW50ZWxfZGF0YS0+YWNwaV9y
ZXNldF9tZXRob2QpIHsNCj4gPj4gKyAgICAgICAgaWYgKHRlc3RfYW5kX3NldF9iaXQoSU5URUxf
QUNQSV9SRVNFVF9BQ1RJVkUsIA0KPiA+PiAraW50ZWxfZGF0YS0+ZmxhZ3MpKSB7DQo+ID4+ICsg
ICAgICAgICAgICBidF9kZXZfZXJyKGhkZXYsICJhY3BpOiBsYXN0IHJlc2V0IGZhaWxlZCA/IE5v
dCANCj4gPj4gK3Jlc2V0dGluZyBhZ2FpbiIpOw0KPj4gDQo+PiBXaHkgdGhlIHF1ZXN0aW9uIG1h
cms/IChObyBzcGFjZSBiZWZvcmUgaXQuKQ0KT24gaW52b2tpbmcgRFNNIHJlc2V0IG1ldGhvZCwg
ZHJpdmVyIGZsYWdzIGl0LiBUaGlzIGlzIGRvbmUgdG8gYXZvaWQgY2FsbGluZyBEU00gbWV0aG9k
IGFnYWluIGlmIGZvciBzb21lIHJlYXNvbiBEU00gZmFpbHMgdG8gcmVzZXQgQlQgY29udHJvbGxl
ci4NCj4+IA0KPiA+PiArICAgICAgICAgICAgcmV0dXJuOw0KPiA+PiArICAgICAgICB9DQoNClRo
YW5rcywNCktpcmFuDQo=
