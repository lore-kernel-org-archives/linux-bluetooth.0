Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3382AC74A5B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Mar 2023 04:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjCUEau (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Mar 2023 00:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCUEas (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Mar 2023 00:30:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92B927D7F
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 21:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679373046; x=1710909046;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=66UnosQb8Q6o3Ajb/BUHQq/cutDyw+hqBJSCd/G2bEM=;
  b=KwEwr3Aoxelvc3g7dZ+07s3pYtWsDgj/pdN1o5d/PvVDnVkf7AbNB7lr
   UKZYsGuAvIV7S4bV5vw9yAEvprnjXYhrocKMS4rTiZzcY9jAS+ViB3FU9
   ahxvIYvrstX+6NgbfOwFd9I6bODxvsxNjQO68pzqx2V8eDcKaMmuVvQ7A
   tJeD3TeNIr3Wk2e7ZVh1CZ1L79Qsyf1NlR8dXHFQhA1XMiyN8YLgoM6e1
   bIRLnlgP+eLUYmesz2l63BBLdVCp6XCtHhaTVYoW6xR6+I0avOQDVSDM/
   K5NUAdnp3xsZdxF44bhJfrkXsCVJ8GvRLh9no61E2y/0B3p9yTjee5EzN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="336348965"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="336348965"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 21:30:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="750384916"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="750384916"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 20 Mar 2023 21:30:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 21:30:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 21:30:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 21:30:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 21:30:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlUiLga8zBLi1pIluo7RCCGLLMCf6UtwAy5U7yFG9XvoyuMXgrl/c5HvqKVBMQForfXTqBcrLw1a0eH8ocE9+QXMqGJqnZVMmsdx7g/yMfnkROrGOm0WttxlivzMdLJhuZMnfqhc/S3/QDLPQhUfOl76dpGshcj790A9tjwVklwJy5hc844ZPsei1fWRh0E1qzeSh9ypHzWtHUM6Itj6INpWl+iVYFoqDq3GZdHZUVWBD7dyTQFvDo4bbep6BMfUxRb8UVMwIb6vUVuAh2HFqOpywuqrzSo1MvXbz1bq5UZRGX5tH9SFlWVruxE+LAVEQaZWSfcyNPphIfgcgSUX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66UnosQb8Q6o3Ajb/BUHQq/cutDyw+hqBJSCd/G2bEM=;
 b=Z1bLMqG1Dy4NB44VF6MQ3nFcPnAbBhb5fL72l0U8hTkEyJvRb2Dpsj4zHc5pkgRJKuQELlV81Ks3/Ppru+Dlxizn6MOw8Eo2Gffju3gk5sZh7Cvff+3Su6c0p/oaZgvrMOJqu2wQ6SPRwC66JvqNEsoJdW2Mxt8D/oR59jpRknacI2PuyDzY0Qq40CaKUK6eVxDQKAjugVnueu9ncchr7IxFEWVvRwoxt1PO0qPWnoQZKyIiPN+0ROFVEsKS8pDHsTkMLESvL+jClAqPybAfRm1zFJJrX1+f7hoTL+WEAxIuNJe99n2luGsPetXBZPU0JyNJa5VbtoCuvZIFdLimwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5901.namprd11.prod.outlook.com (2603:10b6:510:143::11)
 by DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 04:30:09 +0000
Received: from PH0PR11MB5901.namprd11.prod.outlook.com
 ([fe80::a925:603a:18a3:44b8]) by PH0PR11MB5901.namprd11.prod.outlook.com
 ([fe80::a925:603a:18a3:44b8%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 04:30:09 +0000
From:   "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "K, Kiran" <kiran.k@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: btintel: Fix: Add LE States quirk form Solar
 onwards
Thread-Topic: [PATCH] Bluetooth: btintel: Fix: Add LE States quirk form Solar
 onwards
Thread-Index: AQHZWvOFl+FtZ8TIMUS0O/rqpp9HpK8DpMIAgADvwTCAABBn8A==
Date:   Tue, 21 Mar 2023 04:30:09 +0000
Message-ID: <PH0PR11MB5901A6CFC4D5E36C40122E88D8819@PH0PR11MB5901.namprd11.prod.outlook.com>
References: <20230320061813.69895-1-chethan.tumkur.narayan@intel.com>
 <0c579450-b7bd-dd80-c77b-e5471c30aaa9@molgen.mpg.de>
 <PH0PR11MB5901AAC6A9B3E53B6DECC5C5D8819@PH0PR11MB5901.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5901AAC6A9B3E53B6DECC5C5D8819@PH0PR11MB5901.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5901:EE_|DM4PR11MB6335:EE_
x-ms-office365-filtering-correlation-id: d3f3f0e9-c96f-453b-c6e9-08db29c4f4ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xn0ZRIL7t5gBu0QgcEbYs9gXlEQp7IVWI10D6xTEr5lDN+Nq8M90ljgs3hQWbo/zr4C5mqgHylaSYjF6k9ZTdlEmE21S6bjJzp7LRxEVQiwdWu6yALMFNygYieZj/h1ebOhfmdTERy1RRKRMVS49AnhOwzRzLAiuDayrOakWv4DFjnyUIH5MJ6vMlhQCwvQViGM+MmiOCXHG6NUr5AY8TEQDlMIbXMzGYwLywmkEqWd5chrRNIrDLNXxziaw+ihkWNCilT3/eCM3TdXdW7g/IsmYqDgohjXq0O58k1Bfeyfkq8yEslVFRixvHnkUERM7f2Pww/ogMxGFfo2jO+fCVF9v7jovg38GXdR923mTn/0kmLn7KnUG9dmZWIRo+TQTWSkutCDfbyi8lzKtRznSe+Hb6ztEtJcQprvNSgVEl/5805laD+P1jAv1/LIxEvVRu9nWbnIt/l8VSsx9bUMStMkZlIkfR/twKOfUDmBjcSEeWMbp/D8+WaiKx8BlxBkVUIT5TJwnvOnYb8gGf1SvxPN7gVOQOADEhcVFoYyFX1A0S/nMHoDI/0mULdrLGZyPjh0zB2syhRwRLpSBcBcmofT6heexPZIsbKBEf9Z7s96m/eKMGsOzREpttZPuipoj20IvA24ET/Vfw0Rjk+610QnNkLIuy5cHe4rJhas+AKa/6vMvUWbBJ16WAAUH7i4g+i8NPSG9o7skgZV/YOeLRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5901.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199018)(52536014)(8936002)(41300700001)(5660300002)(55016003)(33656002)(86362001)(38070700005)(122000001)(38100700002)(82960400001)(2906002)(4326008)(83380400001)(478600001)(71200400001)(2940100002)(7696005)(9686003)(186003)(26005)(54906003)(6506007)(53546011)(316002)(8676002)(76116006)(6916009)(66946007)(64756008)(66476007)(66446008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGR2YXVxYTJqRHN2TUsxMjVUdHhCQVlrWTdnbnphQ1MxLzhGa2xiU2hlMlhT?=
 =?utf-8?B?aUJVQWFHaGtiRHFLOXdHM0UzNklyYTdLRnRURFRwTmRBZWJGTDNSeWRueWFx?=
 =?utf-8?B?akZ6M0dyVXk4eG5PeE05NElXRWlWblZ0bldtUmtwN0FOMGJJTWpFWE0yMmxG?=
 =?utf-8?B?U0dLNFZNWjZKUVJpVC9ZTHd6aEYrR2V0ajZCNkZpaGt3N1ZjUmpTZWFGaTNH?=
 =?utf-8?B?NmlKWXVvaVppM3ZMTm00aDNKWXhiRGF5NGRMcW5hQytGZHR4TE16dVJncW80?=
 =?utf-8?B?TlJ1YkVmUGJJWnRMYjVPaHdoWTFHQS9zcXlMeVZmdmQ4RGtwdTZDNDgrSHdh?=
 =?utf-8?B?Y1cvNkFkZDBZSnhBRU1Nb1lWL3ZSRmxjbUI1YUZTaVU2RXhNL3huTTQyNnd4?=
 =?utf-8?B?UlY4VlBRcWQ0VS9KS1BoUE9aV2s5VkhUKzQrVTZSQjNCaGQxTkVkVnh5bHRs?=
 =?utf-8?B?WFhmU3ZOMlY4QWpZSEtCMHFXNHhZQ2puNmtidC91MlUvVEl4YjBRMkFPRXFT?=
 =?utf-8?B?Ty83TEt2V1RHRGV1bzNvK3lCTW10K29jcnUzY2taUUhHbjljamVJa2V6MHdR?=
 =?utf-8?B?Z3plM3dGYnN6Sm5pcjlrYUVLNncrZFI2Qk9vQ2lhNDBnUDFRUXNmT2hKWGt2?=
 =?utf-8?B?YlFNM2wvVDBtRmlmcWV0MG5QeVVQcDMyUlVVQ25rZnJwWmRWQVpQc2dIYjFn?=
 =?utf-8?B?ZFNiOEQyanRKc1RQRlhFZWQvYzZCMDdJcUxYc3JlL0JZdzB6czlpalZnVHlj?=
 =?utf-8?B?NW1laTZhN0p4NG9ON3FrREF0VGs1RnBrd3dMeU5Ed3pSNHVWQkFRY1lLUDgy?=
 =?utf-8?B?MUdxYjd2c0VWWXBqeTA0TnZCTlkxMnM2a3ZLd0orL0xtUlhYNHRVS2R4eGR3?=
 =?utf-8?B?UVJhVFJyc2xvQkpidEVzR242RCttWjh4a2M2VnV5cWJpbnNkOVBCczlhUjE0?=
 =?utf-8?B?RnhlSEY2Snhpa2ZhdEhGRjNYbTU5L1JoTnNxdmtnNGJqWkJZY2JqQ2dxTUJN?=
 =?utf-8?B?cmNpL0hneDhwMUVneWFTQjFZS21NNG9qbWt1TTYvRk1vSTVOazZ3U0pNZ3Vp?=
 =?utf-8?B?TUhKSTlkcVZDcmsxZHpDY3FKNUxQUG5VVXZtend2WGZTdGdxRUpmdnFIdFJM?=
 =?utf-8?B?RURrS2MyR1k2bWU0U2dXNUNDeEYyMDVMQWNzOHpkZG1QZ1RNbXVxaWhIMWdL?=
 =?utf-8?B?SXhzSVhNOWVmSkVTeFczb0xEemtrNGxQdXlpSTRmUUlHZzM2VGRsZU1jVng1?=
 =?utf-8?B?OFRvZ2tUU2FjbGE4Zy9XWEVPQVMvY0JSU3UzdlJiM1JWcE1DblZISDhPZ24w?=
 =?utf-8?B?VENQdVViL1dUYldPSFMxeU9DRmNrVUdxRnowSndDN2krbFlrMVo1Y0hoYnBl?=
 =?utf-8?B?eGk5aWNOM0ZweTBZdTB3UUNyS2gvTU9iQyt3NDRjU29PQjZNcHV6bEFkdkZu?=
 =?utf-8?B?Tk5ab0dIcGJrWmlQUW9WeVZwWGVDNk1EWGNiOUJReFE2Q1FURWFhQVFRNzlH?=
 =?utf-8?B?MUhoVFYxdU9DdHlRSWpPbFZIbjZTcGtLeThhOHc2SDhGa2xOWUE4ekpXR2VM?=
 =?utf-8?B?T2pnQjlZYXpzcU4zQ3RFd2ZKY3dlMEYzcEIvdVl1TDBlNUVlbGJ0THdUZjFw?=
 =?utf-8?B?Vi9PdGxybDhIN2JHR2JmS2VHdjNFMW9XcWoyUnhYWnFyZFBYdkF2TUdQS2ly?=
 =?utf-8?B?bVljWHdhZllNRTVhbDc0OWxmMWMyeDdZamJnM2R6L3YwQW0wME40ai8xcUkz?=
 =?utf-8?B?VFpmQVg0MmFrZTBjVDBPNGJkT2dhMVJ3STFjUHd2enI5dXdPM2FhdUpyTlNx?=
 =?utf-8?B?dXZqUWpEYU8xYlE1Mjl0bEhBTER6RS8wQTZ4dDBVY0haUjJtMkJpZkZGNVJk?=
 =?utf-8?B?OTRHL3NJa3BiY2FkbXE0VExYZjlZcUg2ZHlDLzU4R2F1MEcwUnNWRkFKcFRs?=
 =?utf-8?B?UEVHcUpuNU9wOEd5Z3d2OFBBY0JJNXM5WjFMRm1kUTNsaThTdGszS29yZTRy?=
 =?utf-8?B?ZVZ6UXJXc0I4Z3J5bUVJZEVtNE5qdHBUWVQySmlrVDREMDNNL2pYOHExOUFP?=
 =?utf-8?B?c2RHZmd5STNpVy9zSWRNZ0ZTUHZydDVKWGsyRW5oYWpuSW43MVdnTWlzUXFX?=
 =?utf-8?B?cVhSUXpkVkU4WWdNcHhmNFNhQW5FQ0p0dHJvWk9JVHozV0RudGxuclRRM2Rl?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5901.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f3f0e9-c96f-453b-c6e9-08db29c4f4ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 04:30:09.8193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95zOYPFGUbi/J3K+evW83Wpo+NwjcQ5yz3FpbGBdNGLdxpgcW3vZc69Q6Z0wZ8k0+oUbHal3C6PnDlw+yEsG3tGXbEPrVJy7rnE9LjaeTEYl0E0NfC7QPwiLqNcnu78u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6335
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgUGF1bCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUdW1rdXIg
TmFyYXlhbiwgQ2hldGhhbg0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAyMSwgMjAyMyA4OjU5IEFN
DQo+IFRvOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0KPiBDYzogU3JpdmF0
c2EsIFJhdmlzaGFua2FyIDxyYXZpc2hhbmthci5zcml2YXRzYUBpbnRlbC5jb20+OyBLLCBLaXJh
bg0KPiA8a2lyYW4ua0BpbnRlbC5jb20+OyBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIEJsdWV0b290aDogYnRpbnRlbDogRml4OiBBZGQgTEUg
U3RhdGVzIHF1aXJrIGZvcm0gU29sYXINCj4gb253YXJkcw0KPiANCj4gVGhhbmtzIGZvciB0aGUg
ZmVlZGJhY2ssIHdpbGwgc2VuZCB0aGUgdXBkYXRlZCBwYXRjaC4NCj4gDQo+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4u
bXBnLmRlPg0KPiA+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMjAsIDIwMjMgNjo0MCBQTQ0KPiA+IFRv
OiBUdW1rdXIgTmFyYXlhbiwgQ2hldGhhbiA8Y2hldGhhbi50dW1rdXIubmFyYXlhbkBpbnRlbC5j
b20+DQo+ID4gQ2M6IFNyaXZhdHNhLCBSYXZpc2hhbmthciA8cmF2aXNoYW5rYXIuc3JpdmF0c2FA
aW50ZWwuY29tPjsgSywgS2lyYW4NCj4gPiA8a2lyYW4ua0BpbnRlbC5jb20+OyBsaW51eC1ibHVl
dG9vdGhAdmdlci5rZXJuZWwub3JnDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gQmx1ZXRvb3Ro
OiBidGludGVsOiBGaXg6IEFkZCBMRSBTdGF0ZXMgcXVpcmsgZm9ybQ0KPiA+IFNvbGFyIG9ud2Fy
ZHMNCj4gPg0KPiA+IERlYXIgQ2hldGhhbiwNCj4gPg0KPiA+DQo+ID4gVGhhbmsgeW91IGZvciB5
b3VyIHBhdGNoLiBUaGVyZSBpcyBhIHNtYWxsIHR5cG8gaW4gdGhlIHN1bW1hcnkvdGl0bGU6DQo+
ID4gcy9mb3JtL2Zyb20vDQo+ID4NCj4gPiBBbSAyMC4wMy4yMyB1bSAwNzoxOCBzY2hyaWViIENo
ZXRoYW4gVCBOOg0KPiA+ID4gVGhpcyBwYXRjaCBzaGFsbCBlbmFibGUgdGhlIExFIFN0YXRlcyBx
dWlya3MgYnkgZGVmYXVsdCBvbiBhbGwNCj4gPg0KPiA+IHMvc2hhbGwgZW5hYmxlL2VuYWJsZXMv
DQpBQ0suDQo+ID4NCj4gPiA+IEludGVsIGNvbnRyb2xsZXIgZnJvbSBTb2xhciBwcm9kdWN0cyBv
biB3YXJkcy4NCj4gPg0KPiA+IG9ud2FyZHMNCkFDSy4NCj4gPg0KPiA+IFdoZXJlIGlzIGl0IGRv
Y3VtZW50ZWQsIHRvIGVuYWJsZSB0aGF0IHF1aXJrIGZvciBhbGw/DQpCYXNlZCBjb250cm9sbGVy
IHN1cHBvcnQgdGhlIHF1aWNrIHNoYWxsIGJlIGFkZGVkLiBDdXJyZW50bHkgdGhlIHF1aWNrIHdh
cyBvbmx5IGFwcGxpZWQgZm9yIEdhcmZpZWxkUGVhayhHZlApIGhvd2V2ZXIgaXQgaXMgc3VwcG9y
dGVkIG9uIGFsbCBJbnRlbCBjb250cm9sbGVyLg0KPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBD
aGV0aGFuIFQgTiA8Y2hldGhhbi50dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+DQo+ID4gPiAtLS0N
Cj4gPiA+ICAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jIHwgNSArKy0tLQ0KPiA+ID4gICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4g
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMNCj4gPiA+IGIvZHJp
dmVycy9ibHVldG9vdGgvYnRpbnRlbC5jIGluZGV4IGFmNzc0Njg4ZjFjMC4uN2E2ZGMwNTU1M2Yx
DQo+ID4gPiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0K
PiA+ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+ID4gPiBAQCAtMjY4NCw5
ICsyNjg0LDggQEAgc3RhdGljIGludCBidGludGVsX3NldHVwX2NvbWJpbmVkKHN0cnVjdA0KPiA+
ID4gaGNpX2Rldg0KPiA+ICpoZGV2KQ0KPiA+ID4gICAJCSAqLw0KPiA+ID4gICAJCXNldF9iaXQo
SENJX1FVSVJLX1dJREVCQU5EX1NQRUVDSF9TVVBQT1JURUQsDQo+ID4gJmhkZXYtPnF1aXJrcyk7
DQo+ID4gPg0KPiA+ID4gLQkJLyogVmFsaWQgTEUgU3RhdGVzIHF1aXJrIGZvciBHZlAgKi8NCj4g
PiA+IC0JCWlmIChJTlRFTF9IV19WQVJJQU5UKHZlcl90bHYuY252aV9idCkgPT0gMHgxOCkNCj4g
PiA+IC0JCQlzZXRfYml0KEhDSV9RVUlSS19WQUxJRF9MRV9TVEFURVMsICZoZGV2LQ0KPiA+ID5x
dWlya3MpOw0KPiA+ID4gKwkJLyogQXBwbHkgTEUgU3RhdGVzIHF1aXJrIGZyb20gc29sYXIgb253
YXJkcyAqLw0KPiA+ID4gKwkJc2V0X2JpdChIQ0lfUVVJUktfVkFMSURfTEVfU1RBVEVTLCAmaGRl
di0+cXVpcmtzKTsNCj4gPg0KPiA+ICBGcm9tIHRoZSBkaWZmIGl0IGlzIHVuY2xlYXIsIGlmIFNv
bGFyIGlzIHRoZSBmaXJzdCDigJxkZXZpY2XigJ0uIFNvIEnigJlkDQo+ID4gYmUgbmljZSBpZiB5
b3UgZWxhYm9yYXRlZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+ID4NCj4gPiA+DQo+ID4gPiAg
IAkJLyogU2V0dXAgTVNGVCBFeHRlbnNpb24gc3VwcG9ydCAqLw0KPiA+ID4gICAJCWJ0aW50ZWxf
c2V0X21zZnRfb3Bjb2RlKGhkZXYsDQo+ID4NCj4gPg0KPiA+IEtpbmQgcmVnYXJkcywNCj4gPg0K
PiA+IFBhdWwNCg0KVGhhbmtzDQpDaGV0aGFuDQo=
