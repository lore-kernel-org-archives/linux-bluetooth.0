Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507EBCE79AD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Sep 2023 04:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjITEel (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Sep 2023 00:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjITEek (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Sep 2023 00:34:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0646AF
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 21:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695184474; x=1726720474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sK1iQ+IHPMUTPwTTKk/rI2U77odWqPYypQp333eqa48=;
  b=a9Kx1Qa8XDfRlgftmbVcoE2o98roJUSFhAv4ZEa+O/rYnrEashyPwCSk
   9N/l6wgwa86ftT5U84VNXhyY4njZ6iyOcFcNvZmhv6rebk2t839PlG4p2
   okHcFzI2b0hff2rjq6EkUwwVRJD7Qm4WcuXF+7cFNWiDUGIhvivjIVOy+
   aSZNnhcM6lYlckryi1NARXkFs4r8Sl+4KEFPMk7ZkcuwLxBpDUDJ3YcoN
   hpkO8GNen/MbZaCsXBdtS2BWdWYH9m996MAd7fLVTalhfb7yOVMkEUVQN
   o6pECuJK5AQnk6X8AqvbFgXk8C0U0qPN7hRtHuLy42BcSp/6B8HgZNoQa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="360377621"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="360377621"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 21:34:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="920124163"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="920124163"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2023 21:34:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 21:34:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 21:34:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 21:34:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB6xCl+0mJTEhwJnZXzkkGkHhGPx0OELwFQrANb31Wu46ejiT4EUUbdLPPSIK9WQ9yVPxny8c9dDHZUsIVipMSPQI1PzmJjQwARe5Dkjn7zGolfNIjCQa1m+F80kVVaEBkAGjaiV1I0DoSY3cM8BHneCwdh9WrtOLP5aU1YzUQaQSlNBAPCXp9HQ9s0W7+qKzoDIikAZud+QHPEFzXETih7SkHt0lX3k9Mf78sBYgyrm1igf7To+cZqZJeRAsgBFWdQWGevQEnT/uWi8c/VEmrRNBoX78sNfuchOCAHnuPZujRIEzCAWYJu/xjROcTMXrwCUGPQrl3W9g4NLx1eGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sK1iQ+IHPMUTPwTTKk/rI2U77odWqPYypQp333eqa48=;
 b=TzRWjKImqfELjcJGWkF2yVwCt5HSQcR7WhDR6AC7S0BClm8q/03mIiwjRTj9k8jYM7kxDYjIWcuzFaYl6God7CyxYZ6JD7WFV50Oqk+WjwJXlG5n4spP5blTcgiipcL1n9Xjz13e5l3mzRz4+GvXWqzspcn5ACrCc6PM53d4izoryBcQ/bjC2OCsQuAKYIVOQ6VtBgCK+/0NdxZel6QJ6sSCgb5Jum48+YQKlxkwFfOy2bM4OFtlXxPT0+UhSW+K+SBQ/csEZcOp9FAqbNAgK1lpWRZao/6vgvHg69xLAIpLO2rqmQH+ziZ7MMizctb6TVjtVxceMGvMn/HTl8VJTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by SJ0PR11MB5646.namprd11.prod.outlook.com (2603:10b6:a03:303::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 04:34:12 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::1696:cc4b:2d45:25a7]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::1696:cc4b:2d45:25a7%3]) with mapi id 15.20.6792.020; Wed, 20 Sep 2023
 04:34:12 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v1] Bluetooth: Release memory allocated to store supported
 codecs
Thread-Topic: [PATCH v1] Bluetooth: Release memory allocated to store
 supported codecs
Thread-Index: AQHZ6hHVUcd+yGP1wkagz3N1PwXD97Ag2VoAgAJJlrA=
Date:   Wed, 20 Sep 2023 04:34:12 +0000
Message-ID: <PH0PR11MB758525B7C04D1112229F91A6F5F9A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20230918093517.2163899-1-kiran.k@intel.com>
 <CABBYNZKTQc-aQg+Yxzt7euZ1uDF0eQr_ipkFAOjuq+iPGKH3SQ@mail.gmail.com>
In-Reply-To: <CABBYNZKTQc-aQg+Yxzt7euZ1uDF0eQr_ipkFAOjuq+iPGKH3SQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|SJ0PR11MB5646:EE_
x-ms-office365-filtering-correlation-id: d5f910fa-aed0-4e5c-24db-08dbb992d717
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mv65feWa7etKHPpJv+rTDAlPb3/8rit7Nz8pT6ynAEMdaqKsmjWcs0J6Z/NgcbtDG8aYbmAu66q1bwia6v7dhoFyhAMleTMi2uc9SKPsLiczZDLXB5p7jCJFlcYEBFU7ewnk5COc5zj9P4DhLOmn+TbfTFB70bRmvOWj40VA6OmGqSnFJEoZ00a6KTGapYW0FYpE451W+vG+VrzZyXXV7rNDaqu/pKnw82P47g83863E4waKWvgRlQHKbFzPizWKYktpNTyjDN5HwS5tBvL40uytLlrjj6UmljKLP2LAhImO9OnzLxpSiUZidbCuibuMDdWXyxQzgWlg7wj5DoDb8uqBcrnSWith+2JPgJ567UBXMeLWuArWUYD3lwlSKwVvVFxnWL+hNzIFRGPHMxl94PwfJjXuqrEoZH2P0hmLoLP/fOaZfNBZNH1mkcI1OTPGbHFAFTlzzNsU14AaUXIlM92tE5lhp58fr64pIFXeKsDY5SKsXF10TrwCMnLgY6wcf7yigcoeBF5jty5wqN9FR0t9+nFIsKsjjWzmVjU4H9/RPvcsdcWLbOImF+Q2jZdR/+zXhztjm35Th+QsRRMDyiHqbmG6SmFnVmh0FzRmv8g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(186009)(451199024)(1800799009)(107886003)(8676002)(5660300002)(52536014)(4326008)(8936002)(7696005)(6506007)(9686003)(82960400001)(26005)(122000001)(71200400001)(966005)(316002)(55016003)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(41300700001)(6916009)(54906003)(86362001)(2906002)(558084003)(33656002)(478600001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tnl6UmRUenN1bXI1NTA5MUlMWDc2bGhqbEptWS8rOHUrTE9URVA0UXFIeXhW?=
 =?utf-8?B?SXRoV0lVQkVWQkZVWCtrL2FmK2x1azlWSE1nanV2TmIrOGlhS2NEbi9FVUdJ?=
 =?utf-8?B?Yk1DT0ttU2JUY05ROTlEMjdoRHNtc1lZempZVW8xakw0VExpSGtZRlI1TU5L?=
 =?utf-8?B?aWg5eUx1aHZoUzJWVXM5eHpIODRJUkVCMUdtNENOVVg3VUFpeHJseWZTSjdS?=
 =?utf-8?B?VlR2S1hkS3VHS28wQUMyRUxXM2hER1FEWW43T1dBQ2J5UlpiS1p4bEJGSVgv?=
 =?utf-8?B?b3dpYnl4RURYVmlPZjFFQW0veVhFWXpMdEV4YlpUR3JKdnlGNFQ3R0NZdGU1?=
 =?utf-8?B?dWlNMGVSSnRxMTVsR29lV0RFK0k1YWs2QnlFTHZoaVlCS2pZNTU5c0k3Ulp0?=
 =?utf-8?B?WXhSUTRLaGordk1PNnlFOTJtcVg4RlgrQVEwY01EdUl5ZHhoVzRrNkc2K2VI?=
 =?utf-8?B?SFlnaG9peXBkYmE4bzFoWVhVdUpZMjJQaUh2aTRJcVFHUk5vQjRzNW9NUmpL?=
 =?utf-8?B?L0I0WFVLdzhkYnpEVmQ3UzhYTjhHc3NQQ1R0SWdmRVhsZzJRTjdkNjJoVC92?=
 =?utf-8?B?R0x0bUxud1dFYXpUaEdXR0NQQXZnOHB2c1ZIK2t5M1pwOXN0cGpFRmw3anJR?=
 =?utf-8?B?ODJyZVJXWEJnWE9TV2ZnQVVUMUIybDdyVEhTdTFYUFlORE00d3ZaZHcyTExN?=
 =?utf-8?B?ZTlmYk52cVlFaUxsZzgrT0tqNkFkWnBCelBGaEFwV2MySWdIQnQ5TUovZjRO?=
 =?utf-8?B?azNoUFpsM3VrWG9nQ3JTcElzTFd2Tmp1NG5nY2ViMHA1RFhqVk9Xc2NvVlVK?=
 =?utf-8?B?aldtcjVnNlZFcCtXV2QrdnpaRDdnOHRvZ0pmd1U1VkxKeUlRY2NCenJ0STUy?=
 =?utf-8?B?VzVIZGd2WTU2M1hrWnJBb3lEcFk5alNxV0M2NGFWUjFJR2dCSkh1TWlqY0lS?=
 =?utf-8?B?VVR0YlVzNEQ2S1BHenpXRFpNdUU4Z2ExV1JqV1VackZZUERqYzMwQnVMdURj?=
 =?utf-8?B?UXlONThxcTRBZkt3bjNXVUZmWjlQcFlkYklBT09FZW9pSHNSVjVmODJVSG5j?=
 =?utf-8?B?OTFxUmdyanRTTHl4ZVFsTDRWTldBdGdIMEVqQ3FQQmFIM0NIUmhFdjJZVnB3?=
 =?utf-8?B?cWliOENyUGcwR3hWaWx4a3FFbEVoOHNzclh0TkV2VWdzcHE1eWpMMkQ1Z0lF?=
 =?utf-8?B?TGZwaEhuamdiektKUnJVVXh1b1h2OEVSUENsbGZaNWJQUEw1bUNIdVdUWEd1?=
 =?utf-8?B?Qi9melM2WXJPWm5rWUNZcElOdkhjKzc3bDRQUTJhSnpHT3RpbVFuZnVEM3JJ?=
 =?utf-8?B?TU5nMDFGS3dqVG5Dby9Nd0pRaTdPMmVkQXQrUnlwUS9PWVBuckFIeHR2WXJH?=
 =?utf-8?B?RVBnUEZUd3Z4blRuRnhYTyt3ZTJObmx5SjFVQldYcVdHUmtIZVBwYW5KeExn?=
 =?utf-8?B?cUwvLysreDdEdjF6Wjd4N0syNXk1L1pjNlMzVzlGSDhkYnpVQUlMSWw3SE9O?=
 =?utf-8?B?Vjd5ekhpSkVtNzF1VnBkalZrZC9IelcxK1BwcmZ1MG5QTEVXcjNIc3ZNM3lX?=
 =?utf-8?B?RWJ4TWVJeVBZTzF2NGxrU1JOOWp6S3JpQ3lRL0hCdlNEWFBrKzUvSVk4NzEy?=
 =?utf-8?B?dFRPU3NtUlpubTJobkpUSHQ2L2lqa0ZFalpqUkZpaElnVmhJWmhhUEwrRVdp?=
 =?utf-8?B?UkJoWUNKSTBHUEl5Q3k4OUpmc3gyQWJualQwV1k5bHAxMEJNVGJRcVZ0NEtz?=
 =?utf-8?B?RGJaaUVmYnU3Ujc0VGt0dFhReVlvRjBndXV6VmdnVlBCazFDclVMYkN3b0Ri?=
 =?utf-8?B?bGZQaE5kcW43cGZBMUZOSmdoVE1ObDBhVDdQY082cG8xYjFvZFE2dEpLVDk5?=
 =?utf-8?B?cXplMVBkT0sxNVQ4Z3lRZVlnbDNFajA4ZzIzb3g5WjMyVzhJZGxCbXZhSEpO?=
 =?utf-8?B?d2NRWE1Bay9UdGxnNFNvc2tDNWg0NjNXSkJCTGs0VkpCY3lLekxPUTRjUUh5?=
 =?utf-8?B?MWVjNjJ5NzQyYVJtSzJtRVJEVmUrVHpoKzVnVk1BRHJURDE1VXdEak52TFo0?=
 =?utf-8?B?b2p4UWVxNGxsK0VlZ3BWcm9LbC84UXRKSm1xUkxVSVZvMDcvMHRRZkZHRVVp?=
 =?utf-8?Q?zrBI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f910fa-aed0-4e5c-24db-08dbb992d717
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 04:34:12.8012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dce/4HZ6WZLjBMdN4VYh7QzYOI/q9E8j7KxUijekgtoSKF3Dup7TrbuE24LSpAm2f7iPWO37j35vMI6fnvXz3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5646
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KPiANCj4gSXZlIHNlbnQgYSBzaW1pbGFyIGZpeCBhbHJlYWR5Og0KPiANCg0K
SSB3YXMgbm90IGF3YXJlIG9mIGl0LiBQbGVhc2UgaWdub3JlIG15IHBhdGNoLiBUaGFua3MuDQoN
Cj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9wYXRjaC8y
MDIzMDkxNTIzNDc0Mi4zNzM5DQo+IDI4My0yLWx1aXouZGVudHpAZ21haWwuY29tLw0KPiANCj4g
DQo+IC0tDQo+IEx1aXogQXVndXN0byB2b24gRGVudHoNCg==
