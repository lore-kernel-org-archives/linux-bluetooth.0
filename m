Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465B8C74A5B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 21:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCPVTZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 17:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCPVTX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 17:19:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F21A7A80
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679001556; x=1710537556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OReXMRlO4Cbo0hqdFSfF1gsKPU1blnY+unTIcIZx2x4=;
  b=hvwds8cI2c0wkdXj5pDR1V8vDLXugWpEquf3ldRxCGOL/97rVwXkXGFy
   N2/NVQUyO0KQ6/iNdBjqz4ZndE8E+uZX/ESZZngRFvYDNdK+9rxY5f2FH
   ATiybg4WTW11wLPEqVy9f/z/aI2LELoHsoEpvE0bHWO4y5jZJtvBY+Qfj
   V+/LV7CrJWuivVIqSTMPvoN4l4CpqISX2mJ6pcNzZFXlyEoZoBHDUu+IR
   5+3KVjaLVxqoET9/u61L4hIGNcm+MagCq9uBbu4T/NQHBGMGq0+Qw+Gnx
   luxPrbnBfMXrS0kwXv2EMoLrpFJDZjSu6TBeycyGsgr/tpGEWCMMfdqIY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="318510630"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="318510630"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 14:19:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="657324089"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="657324089"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2023 14:19:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 14:19:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 14:19:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 14:19:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndA7y/Q3Fo70mFyHiJp9NN6kfKh2HIja82HxcSEcSygw1Y983G8y277cKU7bBt8XhBFUg/5GATPGo/Y67LUMDUPvYFqRSsv2ZLtGMfhX2tZ9AREKaDwxaxoS96D9P6l5J0RsTNSbXqW4gi1zSdRm/46lh1hTmQSCzCwDIzlUJp9xIuZo6c/iDtwW+jroDCGbcamypZcKhekLCvYXLFh/h9Nn8k7UvVsY3r5DTm0hyu7BXsBdjC3V7IgLAv/8EstXFFvDfbIMjlA0NtQW2vMTeHrM49GoiMpRn/hhvCJnLJ2Mb38dWfhkmNMluowDhumuMS3GimRelX0lLrqBAoCrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OReXMRlO4Cbo0hqdFSfF1gsKPU1blnY+unTIcIZx2x4=;
 b=IXww25DMHPEdSRZ6yxQjHeqcDTWUle8QfL7VsgYQHL90UrHVBRmEaz5ljtTnixME/qGoej/lywjJhOHzYuKevn+XYyt7xpi4DcKHm5iGxGVHBl1Wl/QDq6nSCoAsvdbq3pWO3rrfPqLGkq+6gakY9krZIUFGTJBNI0qMj7R1hyJgSsOD+jmUmSffFjVaDHTAbAOtiAmGiWDLSv+PUvuIEK4dGEIVbPbnSzJjHELzvWRYz3gBrKrKlUmzmSx/bmZM5dUCkuUsr1poRdgz6ISLKos+lqCVxnDarw+LXq/BTt1oEUONJJQrJus2aMJ486s7G7NUU18k05KAnSzP9ekGXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21)
 by MW4PR11MB7077.namprd11.prod.outlook.com (2603:10b6:303:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 16 Mar
 2023 21:19:13 +0000
Received: from MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::f0a6:4316:85cf:f597]) by MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::f0a6:4316:85cf:f597%8]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 21:19:13 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "inga.stotland@gmail.com" <inga.stotland@gmail.com>
CC:     "Gix, Brian" <brian.gix@intel.com>,
        "brian.gix@gmail.com" <brian.gix@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/2] tools/mesh-cfgclient: Prevent storing duplicate
 models
Thread-Topic: [PATCH BlueZ 1/2] tools/mesh-cfgclient: Prevent storing
 duplicate models
Thread-Index: AQHZWDJqR/sV7mNlf0KKXd2ZEaiJr6794kqAgAAHOIA=
Date:   Thu, 16 Mar 2023 21:19:13 +0000
Message-ID: <c5906cb36c2b6af5a74cdac783740f99b13f564c.camel@intel.com>
References: <20230316180759.147486-1-inga.stotland@gmail.com>
         <f2e315f6-c93b-2950-1841-0515d9a03f85@molgen.mpg.de>
In-Reply-To: <f2e315f6-c93b-2950-1841-0515d9a03f85@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4556:EE_|MW4PR11MB7077:EE_
x-ms-office365-filtering-correlation-id: 8df82e12-c2c8-4f8b-657c-08db2664176f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eS5f4F+qyZl46c/tLum2O/Z+ii/PeWtMRvdFCKbcGCtg/GnSf6/qR6u6vGSDhX89T3utDPZ0BfqXETj0fpNqzOBsB4i2dUYr/5642QOE0mgO2RBax42X1X7lr0wDcH12eQDU6OouDkDQQABI+sUerZDgG0lA0fQSffXtRM9oodmo5Iher3aD1ElRFgJKK93eezlNn600SQdXPfOvp/Zgnerxq1upu/W6zRjDSUloCVh9t2oeWcGqJvifBShboMLyH0UXUsvKC+xPXoO/lyvbBqt/A3qyu4qzNtfD3oQpTJmvJhPTle+fD9FYK1lkmaSQDwb9OEU+ZsJvnQhrsRjjHnd/2fo94zl64+F76eO1fzZuu44xLk0zhVjt/Flyq2sVsS098e5yGcjdkMY6RTHmh007q55zim5eZT9BtHPUK6jJZcj3y1gA1UvlF2EQ3T72aFWNyRkbtiHQjbLL1THvXbjrJryOhRJCWp+nTggLrMqNLe5iaVXUmxRnDYXoDK5kBiG7DIGM5tCwjmWo4/8GLBqsh44C54kGabOR2mQApy5Txrt1bdfA6OWDzIekGIorkYoy0NPjTlYGLGJL7Oqn11pOp8T5yziMqNbEkNJhvlQs3LHZO72gyn7wOcGZkPQh3DnH/qAs+j4TlUqQ1q8Txyurnl3PoVgDGY0/Xs4Whivkz+ns+kxr5yFLW2MkfDQmxKzlWTa4CBdmlNkTXTgmiqkLdWoldJb6QpMBpeANcNo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4556.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199018)(83380400001)(2616005)(86362001)(38070700005)(36756003)(478600001)(186003)(66556008)(66446008)(66946007)(54906003)(91956017)(110136005)(76116006)(316002)(66476007)(64756008)(6486002)(6506007)(6512007)(71200400001)(26005)(2906002)(8676002)(8936002)(38100700002)(4326008)(5660300002)(82960400001)(41300700001)(122000001)(170073001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2Vla1lYWUtGaXkrTStBYVR0RkpNMjdwa29SaGNTZEJ2Q3I0MEdIMlRHajRn?=
 =?utf-8?B?Q21zOVlSM0lleEZnRnRFSEY5cmNCb1lieitRUXYzVE1yV0VHVGtTZ0tQTlND?=
 =?utf-8?B?WkVXV21SeHh0VU5ub3lXTmNBcU1pWTFXa2Jyb01KRzRyNDZ2UkpHOG90eVJl?=
 =?utf-8?B?eTFsZk4wR3lEUHBwY0owVzlZTFkzbzNMNE41QW9qamUvdWNlMElTUUZaU3Bo?=
 =?utf-8?B?RFU5STQ5YkhneXJRcnRXRndQU3lCMGRrNkhCa3lIZkdOWVBzNWJSbXEwb1J6?=
 =?utf-8?B?dG1OMjdUL3B3Y2xQellZMnI4RlhVdVFDSmlNRloxSkdBQXVob3dqdTREQ1Mx?=
 =?utf-8?B?VDBrRVQ4cUV2M0tPM0dtdzU0dVpRL1V5b3pzWmhIclpaOHhSQWpoWk9EZER0?=
 =?utf-8?B?eVdZOFlNOTVJNXNTYVl0aVZBRVM3REw3QzVaNlZxK1JGSCtTcjBRb0prUjhW?=
 =?utf-8?B?bkZNV1JxdlFvU0VNMTBhTTgzMnlhVGorNzRjWHVNTng3cWZ5UW5CaFk5emJr?=
 =?utf-8?B?Ni84K3d0K2phb3RBcGNCVCtPeWh4aGNwVkd4LzB5dTMzZk9rUlM4eXcySHl2?=
 =?utf-8?B?ZlFYMno4RnlTdVh4bXZiUlNsajlDdWZzWlRCNDJSVGVRQWZ5QW1UQ3dmRXY4?=
 =?utf-8?B?SGRPMk5WdmpJWG5FZVMzdFd1T3ZRVGFoTkVKeWFleWQ4YW55NkFLN2NzWU9x?=
 =?utf-8?B?TE9PN2pobi9zNVEzWjhiTTlxR3NQUmd4c1lUeWpDbHNHai9JbFlCOEJCZXBN?=
 =?utf-8?B?N3IwMSs5KzMwYmRGc2gyeTV0VEovMUVIUkFrd3RUNGFkOVVHc0xCSnJFNmNM?=
 =?utf-8?B?bGxNMHNWZUpVWks2ZjVPU1RlaXVGWjZSYm9uM1EvNFFYQWZZM2tUK1hxSTAr?=
 =?utf-8?B?K2doOXpXYzE0R3l1S1U4WFNVK0JNUkM0WGhBMXZMemxYcnUxVXNZdUwrRlVw?=
 =?utf-8?B?eGZMVlFKbDVYaWc1aHg3V0U5Nk9YZk1scndTelhZZ05lUEF3ZVVkcWxtbExt?=
 =?utf-8?B?MG41dXhnV3hEM1M0OFdXVk5HaVVDenhPSjhSdDEveWpLOTZTZVJ6UDBIOEE5?=
 =?utf-8?B?RElGLzk4L2tjY1ZoM3NleE1UMFBjS2lXeldwS1hCK3diQXNLMHFnWHI0YUhl?=
 =?utf-8?B?b1d3NjdNYTZlUW9CV1dhQ081ZFhCWXUrVXZIRVRHWlVpWDIxUDFOcE9iU1E3?=
 =?utf-8?B?Q1IxUzd3cXFtNC9EREtWTzdUV0tlV1lzWk9QTW5ZZVErVlVFczFuME1Ha0ZU?=
 =?utf-8?B?bTlkZjJaYTd0WW0xRFVacGNKWHA4TlI0enBNaW9iSFN5K0RSVmVLdEVUakMz?=
 =?utf-8?B?Y3QvMEEyejNVMU9qaDE3ZEJWckhCR05ZaWd6TlJtMHhrRFM0VjBzZE1mRS8x?=
 =?utf-8?B?eStVdy96Yy9oNVJCSjMyNGxjcnVvSmJYd2ZiSkxtYWl2S2hMU3d5NlB5U2xo?=
 =?utf-8?B?N255NUxjZDd6azF5cHcrTENNQVdGcTkvbHJDQ3c1MkVwbXM4bTFFYXdDdm5j?=
 =?utf-8?B?Ujk5bm9VNXdIakZrT1hRZ2hIUE1CeXEvTGlhaS9IZjBhSVJSRkovYmNlVlFN?=
 =?utf-8?B?bU4yRzlVMXI1L0Z5ejY2bE5EY0RtTSthc0hhN0lzck5iZnJCWHJGUkNZZzE5?=
 =?utf-8?B?WS9ha0JEVm8ySUpRQkVNekx0OE5QcUt1TzErSEg1YUEzM2lNOTk4b25sRElZ?=
 =?utf-8?B?WjNhSXFlMDVTWW1td0o0QU53MkUydU1hUDFHYkxLYSs5Ylpxc3k3dTNOZjR4?=
 =?utf-8?B?QzNCV1E3NlNNdkN4em5Md1dTZkZYRXF0YnVNWnZPK2lobkhjWkJtbk1QM2E1?=
 =?utf-8?B?WVJXaWpIaWJJTjVSL2dXOCt1Q2NuREhYREpZOHd1ZEhEUGt3THFYckNQVFVO?=
 =?utf-8?B?K2lJZ2RFK1ZnSEgvWEUveDZIVGlHWmRiUzVhQVdkcXU4Uk9aOUVJR0g4eFNv?=
 =?utf-8?B?dy9sWEs1NXBaL2NMek1neWwzSVFIaFBDdWpxSG1mSUlrZ21kRFczNkpIdk5h?=
 =?utf-8?B?NXpiZC81VGhYcEJKR2FmTEd3dmVsRCtFVXZNNjhVcnUxV1FCc1hYODQ2NTFE?=
 =?utf-8?B?aDgzejdwUzgzVVhqVmtKdm9ReUJGM3NIdnAxODVOT1ZJNlAxYkJUVnRlZHda?=
 =?utf-8?B?TTVRS2hXUXRxUDZnSWxKY0NXd3BsME1nVE5XOHhZMytPV1FPVnFrVUZzZG5U?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF9BCBA9F0B4E64C9928509507CA4260@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4556.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df82e12-c2c8-4f8b-657c-08db2664176f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 21:19:13.4506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kGFcPdRDaMehhx6/X4CaQkG6oO22UqvxlSttDF9OAhEVSm2zPQL/4SDJGK3KzxiFnQfR2sA0dvbYWecUtGAWpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7077
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgUGF1bCwKCk9uIFRodSwgMjAyMy0wMy0xNiBhdCAyMTo1MyArMDEwMCwgUGF1bCBNZW56ZWwg
d3JvdGU6Cj4gRGVhciBJbmdhLAo+IAo+IAo+IFRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaC4KPiAK
PiBBbSAxNi4wMy4yMyB1bSAxOTowNyBzY2hyaWViIEluZ2EgU3RvdGxhbmQ6Cj4gPiBUaGlzIGZp
eGVzIHRoZSBzaXR1YXRpb24gd2hlbiBzdWJzZXF1ZW50IHJlcXVlc3RzIHRvIGdldCBhIG5vZGUK
PiA+IGNvbXBvc2l0aW9uIHJlc3VsdCBpbiBhcHBlbmRpbmcgZWxlbWVudCdzIG1vZGVsIGxpc3Qg
d2l0aCBkdXBsaWNhdGUKPiA+IG1vZGVscy4KPiA+IFRoaXMgYWRkcyBhIGNoZWNrIGZvciBhIHBy
ZXNlbmNlIG9mIGEgbW9kZWwgb24gYSBlbGVtZW50IHdoZW4KPiA+IGF0dGVtcHRpbmcKPiAKPiBh
Km4qIGVsZW1lbnQKCk9LCj4gCgo+ID4gdG8gYWRkIGEgbmV3IG1vZGVsIElEIHRvIGEgbW9kZWwg
bGlzdCBvbiB0aGlzIGVsZW1lbnQuCj4gCj4gSG93IGNhbiB0aGlzIGlzc3VlIGJlIHJlcHJvZHVj
ZWQ/CgpUaGUgc2ltcGxlc3Qgd2F5IHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUgaXMgdG8gY2FsbCBj
b21wb3NpdGlvbi1nZXQgb24KdGhlIGxvY2FsIG5vZGUgKGkuZS4sIHRhcmdldCBhZGRyZXNzIDAw
MDEpIGFuZCB0aGVuIGlzc3VlIGNvbW1hbmQgbGlzdC0Kbm9kZXMuIFdpdGhvdXQgdGhlIGZpeCwg
dGhlIG1vZGVsIGxpc3QgZ3Jvd3Mgd2l0aCBlYWNoIHN1YnNlcXVlbnQgY2FsbAp0byBjb21wb3Np
dGlvbi1nZXQuCgo+IAo+ID4gLS0tCj4gPiDCoCB0b29scy9tZXNoL21lc2gtZGIuYyB8IDE3ICsr
KysrKysrKysrKy0tLS0tCj4gPiDCoCB0b29scy9tZXNoL3JlbW90ZS5jwqAgfCAxMiArKysrKysr
KysrKysKPiA+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL21lc2gvbWVzaC1kYi5jIGIvdG9vbHMv
bWVzaC9tZXNoLWRiLmMKPiA+IGluZGV4IGMwYzA1YTI5YS4uMWQwNDc2OTFkIDEwMDY0NAo+ID4g
LS0tIGEvdG9vbHMvbWVzaC9tZXNoLWRiLmMKPiA+ICsrKyBiL3Rvb2xzL21lc2gvbWVzaC1kYi5j
Cj4gPiBAQCAtMTk2NCwyOCArMTk2NCwzNSBAQCBib29sIG1lc2hfZGJfbm9kZV9zZXRfY29tcG9z
aXRpb24odWludDE2X3QKPiA+IHVuaWNhc3QsIHVpbnQ4X3QgKmRhdGEsIHVpbnQxNl90IGxlbikK
PiA+IMKgIAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB3aGlsZSAobGVuID49
IDIgJiYgbS0tKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBtb2RfaWQgPSBsX2dldF9sZTE2KGRhdGEpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkYXRhICs9IDI7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxlbiAtPSAyOwo+ID4gKwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBqb2JqID0gZ2V0X21v
ZGVsKHVuaWNhc3QsIHVuaWNhc3QgKyBpLAo+ID4gbW9kX2lkLCBmYWxzZSk7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChqb2JqKQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgY29udGludWU7Cj4gPiDCoCAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGpvYmogPSBpbml0X21vZGVsKG1vZF9pZCk7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIWpvYmopCj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgZ290byBmYWlsOwo+ID4gwqAgCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBqc29uX29iamVjdF9hcnJheV9hZGQoam1vZHMsIGpvYmopOwo+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkYXRhICs9IDI7
Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxlbiAt
PSAyOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiDCoCAKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgd2hpbGUgKGxlbiA+PSA0ICYmIHYtLSkgewo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9kX2lk
ID0gbF9nZXRfbGUxNihkYXRhICsgMik7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBtb2RfaWQgPSBsX2dldF9sZTE2KGRhdGEpIDw8IDE2IHwgbW9k
X2lkOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBk
YXRhICs9IDQ7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGxlbiAtPSA0Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBqb2JqID0gZ2V0X21vZGVsKHVuaWNhc3QsIHVuaWNhc3QgKyBpLAo+ID4g
bW9kX2lkLCB0cnVlKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaWYgKGpvYmopCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb250aW51ZTsKPiA+IMKgIAo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgam9iaiA9IGluaXRfdmVu
ZG9yX21vZGVsKG1vZF9pZCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAoIWpvYmopCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBmYWlsOwo+ID4gwqAgCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBqc29uX29i
amVjdF9hcnJheV9hZGQoam1vZHMsIGpvYmopOwo+ID4gLQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkYXRhICs9IDQ7Cj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxlbiAtPSA0Owo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiDCoCAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaSsrOwo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL21lc2gvcmVtb3RlLmMgYi90
b29scy9tZXNoL3JlbW90ZS5jCj4gPiBpbmRleCBjZWU3MTFkZWMuLmVjMTQ3NmFjOSAxMDA2NDQK
PiA+IC0tLSBhL3Rvb2xzL21lc2gvcmVtb3RlLmMKPiA+ICsrKyBiL3Rvb2xzL21lc2gvcmVtb3Rl
LmMKPiA+IEBAIC01NCw2ICs1NCwxNCBAQCBzdHJ1Y3QgcmVqZWN0ZWRfYWRkciB7Cj4gPiDCoCBz
dGF0aWMgc3RydWN0IGxfcXVldWUgKm5vZGVzOwo+ID4gwqAgc3RhdGljIHN0cnVjdCBsX3F1ZXVl
ICpyZWplY3RfbGlzdDsKPiA+IMKgIAo+ID4gK3N0YXRpYyBib29sIG1hdGNoX21vZF9pZChjb25z
dCB2b2lkICphLCBjb25zdCB2b2lkICpiKQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqDCoHVpbnQz
Ml90IGlkMSA9IExfUFRSX1RPX1VJTlQoYSk7Cj4gPiArwqDCoMKgwqDCoMKgwqB1aW50MzJfdCBp
ZDIgPSBMX1BUUl9UT19VSU5UKGIpOwo+IAo+IFdoeSBub3QgYHVuc2lnbmVkIGludGA/CgpOb3Qg
c3VyZSB3aGF0IGV4YWN0bHkgeW91J3JlIGFza2luZyBoZXJlLiBNb2RlbCBJRCBpcyAzMiBiaXQg
bG9uZy4KQW55d2F5LCB3aWxsIGNoYW5nZSB0byBzdHJhaWdodCBjb21wYXJpc29uIHdpdGhvdXQg
cG90ZW50aWFsIHR5cGUKY29udmVyc2lvbi4KCj4gCj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gaWQxID09IGlkMjsKPiA+ICt9Cj4gPiArCj4gPiDCoCBzdGF0aWMgaW50IGNvbXBhcmVf
bW9kX2lkKGNvbnN0IHZvaWQgKmEsIGNvbnN0IHZvaWQgKmIsIHZvaWQKPiA+ICp1c2VyX2RhdGEp
Cj4gPiDCoCB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgdWludDMyX3QgaWQxID0gTF9QVFJfVE9fVUlO
VChhKTsKPiA+IEBAIC0yMjcsNiArMjM1LDEwIEBAIGJvb2wgcmVtb3RlX3NldF9tb2RlbCh1aW50
MTZfdCB1bmljYXN0LAo+ID4gdWludDhfdCBlbGVfaWR4LCB1aW50MzJfdCBtb2RfaWQsCj4gPiDC
oMKgwqDCoMKgwqDCoMKgaWYgKCF2ZW5kb3IpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoG1vZF9pZCA9IFZFTkRPUl9JRF9NQVNLIHwgbW9kX2lkOwo+ID4gwqAgCj4gPiArwqDC
oMKgwqDCoMKgwqBpZiAobF9xdWV1ZV9maW5kKHJtdC0+ZWxzW2VsZV9pZHhdLCBtYXRjaF9tb2Rf
aWQsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBMX1VJTlRfVE9fUAo+ID4gVFIobW9kX2lkKSkpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIHRydWU7Cj4gPiArCj4gPiDCoMKgwqDCoMKgwqDCoMKgbF9xdWV1
ZV9pbnNlcnQocm10LT5lbHNbZWxlX2lkeF0sIExfVUlOVF9UT19QVFIobW9kX2lkKSwKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21w
YXJlX21vZAo+ID4gX2lkLCBOVUxMKTsKPiA+IMKgIAo+IAo+IAo+IEtpbmQgcmVnYXJkcywKPiAK
PiBQYXVsCgpCZXN0IHJlZ2FyZHMsCkluZ2EK
