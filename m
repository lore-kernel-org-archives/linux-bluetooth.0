Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED55C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 18:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiBPSfA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 13:35:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiBPSe7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 13:34:59 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761A52AB522
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 10:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645036486; x=1676572486;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Twd2MBzwyJMfzXiiJHStZR5tpSJWwN2s3k7zygYR/rQ=;
  b=b0Fv+YEyjbi7MZztHRbPeUpFrB6x+lNkXTVxX7E72yR0VYSMfwdsZ/bW
   NoQSWJlSzjGf+OOkA2IDnINLnZU6Rr/5DRb/+QzuVSz3bemjodBZnQLSq
   o3U8Ck9xWvzJmkLocjOWI5gbAFdpMgHVEH/1VaBeRYqUSNZy9HN1RGdJ+
   8E2lw2+olfXMY5Rzv9cWKtbSdC7YKUgdc+9ZjY+bTRmLh5pNx99Ep4NhR
   WrdT/CFV4y+F1Ve66L7cL8AwItz3eucFBLXNxwmz7ufYQagPHMoOYSf60
   rBXaKEtpQQQUohB4wDmv1PVL2F8B48MDBw5qmnePS0XMxsKIvNzDJIojw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="231318756"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="231318756"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 10:34:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="503154980"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 16 Feb 2022 10:34:45 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 16 Feb 2022 10:34:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 16 Feb 2022 10:34:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 16 Feb 2022 10:34:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njeG6fi8JZ+vgq6/CqzDzdfJB466h2pB9CCAOnmEbwqKCh9vA/SvbnaN9eDTwd7wWlV+7Vfv6D2qXE00dceblFTeGeGMtS08P2X0T5CBON9QxMCEeSTutDNVkh69q/swMuNmy/o1jHcd65J+7CnYMIMpX3mOadzAPYmxpumIA1deh1KjYDmaHOUmSR7vPmGSIrd2GMyuATRd9OGcm4y+sQ2nmoe34t22ITQD0jrqhMpcMKAZGLD4UT+ZlbWAjgbJsurW0GdpffluyYFKa/KRRdPVzOAWVaF7paoVPtAnEhiXRZ5bcXl1Aa8IYU2jOWGX1sTs5zwuwembnMNdYbSW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Twd2MBzwyJMfzXiiJHStZR5tpSJWwN2s3k7zygYR/rQ=;
 b=BuYprkmnD4l3ZQ3kYeHXFnxq3B2bCNAt2joBgS/jj0kz24za4y4KbgpmfkiMzNZpYt2/JGIj1cnDG+6+i21bLf7/4vhOAfArr3/L/6IduVp5RvnowtcDMMzonBNyBvDnkjXBSK+n+AxotEI3djD8NnQS1deo5eZQi5Lm14SywlWv8+0zdB1KbgrBhBPd7rO7olvIdXpgd2PlKdF5hpxKV4zQeonrv87K6+OP+lR3e7gYbrcSGMlzf3X8Y4BKjZPXP8VyqdMTbRDXK5UvBktwlrVU2V1zS3wN3IDR6OdobED5ceRuiI4Q1L1B2ymj5eba5lNDOYd7wZz1yitO9RIQ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (20.181.61.143) by
 DM6PR11MB3500.namprd11.prod.outlook.com (20.177.218.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Wed, 16 Feb 2022 18:34:43 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::5d0d:46b0:ffbb:54b3]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::5d0d:46b0:ffbb:54b3%4]) with mapi id 15.20.4975.020; Wed, 16 Feb 2022
 18:34:43 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "bluez@heine.tech" <bluez@heine.tech>,
        "fontaine.fabrice@gmail.com" <fontaine.fabrice@gmail.com>
CC:     "buildroot@heine.tech" <buildroot@heine.tech>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] tools/mesh-cfgtest: include  limits.h
Thread-Topic: [PATCH BlueZ] tools/mesh-cfgtest: include  limits.h
Thread-Index: AQHYIy2UKIFw3Lfyu0iNG/uIOOEN66yWgV4A
Date:   Wed, 16 Feb 2022 18:34:43 +0000
Message-ID: <76e6e65dd676c434d51c6e2977a8e8267e72d901.camel@intel.com>
References: <50-620ce680-7-4d762500@265872973>
In-Reply-To: <50-620ce680-7-4d762500@265872973>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45982303-e925-4dce-2d75-08d9f17b002e
x-ms-traffictypediagnostic: DM6PR11MB3500:EE_
x-microsoft-antispam-prvs: <DM6PR11MB3500467CE4156E85535AB641E1359@DM6PR11MB3500.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yqbEBZsV4EBaspMOlTkZffF4nUTcyomHA8feYYVhL4ikSwinldEIup7YVyHh7ykkOR0EZa8kXEQtls3W3N/V7bUkgMU3W/djoKlyJWtuqaioIvOylVWg7nw10ctyKaFQb9y8FkxOOi/3FFHdVYrg/ZmOpVmcJ2sCgMuebvGxnljNsn2o2SKDXGtHVqjS5EcPlbjS6zmp0eSoQfFsaC/gZH1IQ1w87ndbXz/kfO5lbkcxdS+7VEcMGbisF06CGpQ8imwT+KwY5ZX6oncmBhMlwslT4pMDlEQlz+E7fcOSJydSH2Te2VW6hERFUrn4tMzi4Hd83j6WfLGE5PHRDCWmoEhwbrUcU8kDypRSH2s0+5Er1oHP5/ut85DYZ0LDWcp0/ZrTGRwUgHIoOh0D6CAHvRIAXM5h7k3s7M/G5zhxaqqDKxXogv+yLLOju03aVUJ0QuwgxfplteF2gOIUK95Pz9DZ+rG0clhJFy2P2+5NCaLPCJG821Jvier+9W96dT/QfyBt5mQvjBZoejgkFif5iyw8W2/49vfUs1vkGstTDizz2QMWxFd5aRgxAAxBMOeU9gf0pyX57ekZdgUqn/StrXrrwRSGrAzw3PvT0Tdkk0poEzjvYWB/wcFwyweWpGcITUOyIhSg59KV4zb8Xvt6Yx9hYMRubLgw2NcdbDd/jpnbkfmmWr44qz2+C8SYxm0DXCKKxHZKxzg8oGbkpKNHb3vpVTtX2KvGtutzuSK6+JYU7UnMlwFIDv5qTfZAS7CTsKCNw9pIlJ8lbiwHDK2+ePZjLy3B2U40IqzaWQ8zXUA0Qtgul028mjQCTG12bnNJXUVbPGswp5n5CyTZEfWo+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(26005)(54906003)(6506007)(110136005)(86362001)(83380400001)(53546011)(186003)(508600001)(71200400001)(2616005)(966005)(6486002)(107886003)(82960400001)(36756003)(38070700005)(2906002)(122000001)(66946007)(8676002)(66446008)(66556008)(5660300002)(316002)(8936002)(4326008)(66476007)(4744005)(64756008)(91956017)(38100700002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnZ0c1NoMm9QejB5bWFMa3l5UFN4UlhvQnhhWUNodTIzcVljaWFiSVNPQmdv?=
 =?utf-8?B?YkNpN2RSUzRKZkRaVDFFazFUcXFmSXZvWUkrb1VlcHg4TVZmTmZObndQVjNj?=
 =?utf-8?B?M1NWcWNkNXVhUGtwSHVIR25wc1lEdzhSQis0aW9EUFl0YjF2cGNteUo3RFRN?=
 =?utf-8?B?UnVxc1hVQW9WME9MZWpPSGpJenVUWVJhNjFLdjB6NUxOTWFJcis4UTIwWHNG?=
 =?utf-8?B?QjNhbDdTRXREZ2oyUGhEMWhXOVNEd0tRNVhqaFJzUmtLaEFtU1VGV1pCNEwy?=
 =?utf-8?B?RkpVQmYvK3VPcWNqQk11aStRRExYQkJ2aVZ6ZllFaEpaaHM4MDM5S0NPeGg5?=
 =?utf-8?B?b2c3ODFxSFNpeTFKSXl6RS9uWmhhU3Z6aHJ3d2dXZWVvSENTMU5LeDF1ZFgx?=
 =?utf-8?B?ZjU1RGJsVFRWMGdVdmNicnNjTjBYVEhFalZjUTZwbVI5ckQvWEhhZVhpMExU?=
 =?utf-8?B?eFZXcEk1UU1JNWJuOFFYRlZabGNMSnB0SDBmSkJWM2gyNmMvNlRnR0syZFN3?=
 =?utf-8?B?bHhKdEZNVWc5ei9Eck1sd3lidFAxazVsUHdUOXNLTVY2RnRmd29XMXlYSlZ0?=
 =?utf-8?B?aG5aT1ZGbXNCV0ZRaUE4allHNURXSm5PMlhic1NpL3E5UzdicTQzMWJoNmRK?=
 =?utf-8?B?RWtEUnkweno2S3oyeTNPNkpITzBuRENlVUx1aDN0NGJiY0RlZUFkQnNFaTJC?=
 =?utf-8?B?WThEWitoSThHUVlKY0lVcDhSZUVFV0tPc1h2WFI2Q2p3NjE2Z3Fza1BaR0pO?=
 =?utf-8?B?U0Z3bStKbm5MYkpEL0ozcG1VTnZPNnM0RXltOHF0MEZuaVNFMXNLaktPTUJS?=
 =?utf-8?B?VCtnOWdOVE9SWXExWjl6NjhxVGZyNlJUdmxyUlZMbnMvRUJMTk5meFBFczI3?=
 =?utf-8?B?dlh2cnpGTk4zRkw1QWlsUTBLcytMd2V5SHduQXNsMlBBUHVYMUZscDNXT1Jt?=
 =?utf-8?B?VWhrV09FSGVJekJqMVJBTEdQS0tVU1NlTyt5WUhZZ2ZXUVVVaTVFakxhVWpF?=
 =?utf-8?B?OWZuVUFNMFZEdGlmNHZ1djBMV0hmOVl3YUpPUEpRYnVTVXQ5VWgzQldidTNl?=
 =?utf-8?B?RDA0ZXI2eTdVc2NITXNkL1Mvbms5emRUNW82VkNPN0MyQnJxZVgxcnR0K0VG?=
 =?utf-8?B?aHZvOTR0bjUyOWFuSWdFSFhySFY0TXV6MDVxUVV1Y255b3V1MVRtKy9ZbG10?=
 =?utf-8?B?dm42N0gzWTNRY3B6UzhpbUx0ZVZyUUxhSUNQUmRkYzFVd001cm9xcUlZMHJJ?=
 =?utf-8?B?dGgwTHJaYXVnTWZJeUpIV01EajFiSHViWGk4R0wwaHR1eGpFMVNJdGhnWkRl?=
 =?utf-8?B?TnVUc21UdVFyUGpNYzZLQjcwck9uZTdRK25IK21PUDAvYTBPeTZhcHRPdkVo?=
 =?utf-8?B?VjNkemM0ai85ODNObU5XMXJMQXRiVkFHd0dxQ3BsZTVaU1lGWWl4NzVCa2gw?=
 =?utf-8?B?NW9sTnNiOEw1NHhSbFdYK3gxc2FjNTlHN2RURW93VnpxTHlMTkZSOUtOVDd4?=
 =?utf-8?B?cVI4RHhFWGFod0xYeG5rZk83UXV6ZC9neVBXRVlHOVlMY2JuWnBnYlNqeWhZ?=
 =?utf-8?B?NFJENVl0emFtV29rUnBPd1lEV2tYRDVEZ2FDMFAySS9xTVR2VDNWWk01dHB3?=
 =?utf-8?B?OXRsaHBLVkljd0haMWpoN3RUQU5ZckhJMlVhT3dPbGZTR3FKbnd1dW9XMGJH?=
 =?utf-8?B?czlyUk5PbUxodjMyMHJTUmdWeERFY3dRZlo3bE05dktqNDZldFZGNWVIVFVz?=
 =?utf-8?B?VENxMDF5QUJjOWVzK1lMYjhyalFZbmVpWnNldmdDRFBPbXVrc1NOTXg5bk5s?=
 =?utf-8?B?M3VTOFJzZlB1VjYzdTZNdzVKK3FtckFySVh5eEJSM2R1SFRITmRBMEJ3dllP?=
 =?utf-8?B?cVljMlpXUG1PaU85MjRHdzZKdWtCaGUzVVRMSkN2eUJiSWY4Y2I1ZTdGVWR1?=
 =?utf-8?B?Z1FibmxsSktNMnVLMEFueFlVUWVld0lZR2ZoemZSR0FtbEcrZDk4cU12UDBY?=
 =?utf-8?B?YVQyVE9zNUN0WXA3eHVnRTltcmxxdFdlUmV3Qmo1Q0JVb0ozYnJOOWhmUGdi?=
 =?utf-8?B?d2NtR0FITUlOWThWVDFkZ3U5c0Z2TFJUdHhua3NQMm9xeFJlYWRSNWpaSDJw?=
 =?utf-8?B?NG0vM1JZQjNtdUVXbXk3NncvNHNkT2YvdWd0bnRIT3NyOW5wVEh4MXEvT0N5?=
 =?utf-8?Q?Se5eM8uSAFgkgMSun6VoAUc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <562C9D0B3950DD4CB780BEFD670BEC81@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45982303-e925-4dce-2d75-08d9f17b002e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 18:34:43.4840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W6iwtjrWrpj+/qbj16MLWcEnfocm7L2sHuXcP2+Objh62NmOU1s9JIfgnUnQl9JeecHRN++597ZxfpfnnSxIfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3500
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

VGhlIGNsZWFuIGFwcGx5aW5nIHZlcnNpb24gb2YgdGhpcyBwYXRjaCBoYXMgIGJlZW4gYXBwbGll
ZC4gVGhpcyBpcyAqbm90KiB0aGUgb25lIHdpdGggdGhlIE5vdGVzIGF0dGFjaGVkIHdoaWNoDQpi
cm9rZSBsZW5ndGggcnVsZXMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpPbiBXZWQsIDIwMjIt
MDItMTYgYXQgMTI6NTcgKzAxMDAsIE1pY2hhZWwgTm9zdGhvZmYgd3JvdGU6DQo+IEhpIEZhYnJp
Y2UsDQo+IA0KPiBPbiBUdWVzZGF5LCBGZWJydWFyeSAxNSwgMjAyMiAyMzo1MCBDRVQsIEZhYnJp
Y2UgRm9udGFpbmUgPGZvbnRhaW5lLmZhYnJpY2VAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+ID4g
LS0tDQo+ID4gSSdtIHNlbmRpbmcgYmFjayB0aGlzIHBhdGNoIGFzIGZvciBhbiB1bmtub3duIHJl
YXNvbiwgdGhlIHBhdGNoIHNlbnQgYnkNCj4gPiBNaWNoYWVsIGluIEp1bHkgMjAyMSBpcyBzZXQg
YXMgc3VwZXJzZWRlZCBpbiBwYXRjaHdvcms6DQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wcm9qZWN0L2JsdWV0b290aC9wYXRjaC8yMDIxMDcyMjIwNDkyMy4yOTczNS0xLWJsdWV6
QGhlaW5lLnRlY2gNCj4gPiANCj4gSSBoYWQgc2VudCBhIHYyIHdpdGggYW4gaW1wcm92ZWQgZGVz
Y3JpcHRpb24uIFRoZSBidWlsZGJvdCBkaWRuJ3QgbGlrZSB0aGUgQ29tbWl0IE1zZyBiZWNhdXNl
IG9mIHRoZSB0b28gbG9uZw0KPiB1cmxzIHRvIHRoZSBidWlsZHJvb3QgYXV0b2J1aWxkZXJzLiBN
YXliZSB0aGF0J3Mgd2h5IGl0IHdhcyBtYXJrZWQgYXMgImFyY2hpdmVkIiBvbiBwYXRjaHdvcms/
DQo+IA0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvYmx1ZXRvb3RoL3Bh
dGNoLzIwMjEwNzIzMDgxMDM5LjMwMzk2LTEtYmx1ZXpAaGVpbmUudGVjaC8NCj4gDQo+IFJlZ2Fy
ZHMsDQo+IE1pY2hhZWwNCj4gDQoNCg==
