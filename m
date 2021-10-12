Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1C1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 15:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C922660EFE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 15:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbhJLPxH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:53:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:1330 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237241AbhJLPxH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 11:53:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="207991352"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="207991352"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 08:51:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="625998041"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2021 08:51:04 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 12 Oct 2021 08:51:03 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 12 Oct 2021 08:51:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 12 Oct 2021 08:51:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 12 Oct 2021 08:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxEBO9QulbOOVkrVeexgrlANv40Of0DWZsPHNMCMQA/QjdrH5bjJw+VIg2wNZGvgj6Cdol65LBqCj9kKUe++YDnnwG50YJTRURggaa+eD+f1IBIz9UQz3hYUahGvfg7AINBkWghJr4GF93aQCvtVqrA7/4+lecVs3fRZJLx0OhC+i/+iRPt/ekmf7RYtpn/RG44pw6s+i3curRNMR7XViqev4P/f9f1MFQ8Yi4tycwyqVamJUqGF6LPpUidpEw1ildtRtZI77xI3knc7nMXfb7ny41Drr025rHOGCCQfCrXYSXbnqezjNuzxCb3lk0gi+eeIS2x1ftFHxcgsaXwc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BxbkWWxEQ5lGWC6mwk9tB3G9snELEa4ecx3YVk2MSI=;
 b=Tryj2dIXnT+4KjUgqFb6Aflevwm3Cm4cT15E5W8Rq07KiEAy1Vih3Ozqep8ePsx1lsLkmTB01sQL1sJ/8ZOuDhARORWlDvq5E+nEoFKu5K5KU5H/2ABubpO6eMzLa3hxPUBhPMe/YQV7W5BAlphVIlkwMouW7GQ02nF4k/jhZiq8LvVrncOKfUWaUaWuZL9/t+b/PS5ZOE7lak+dUfMDpX/WXR8SwCuebZhz29aITbJNqOX0okV6UJme+f1rLYWSqWbEtlw9gMvPy0KcorpSbcxFNKN7rhz+n44eMCrY08knPdsBNa4FxWpGtPIBXXkKHnp6cDhvf37+qHGUPZhUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BxbkWWxEQ5lGWC6mwk9tB3G9snELEa4ecx3YVk2MSI=;
 b=Nt6Cpr16eQfXzsEW5OJz2Lx6Hw/XSkiasJjXYgm2857ErAHi8343hM778cd37/31zWTeVU/kDNa0aV9RA2EoJZhrgbTDSJDi235lajHWpeTtOq+AYGufQrUXu24bHWiYiMLSaSiv4xlHw5zFyhne8T0n+6SaL+w6jgddWtsoUtA=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5589.namprd11.prod.outlook.com (2603:10b6:8:26::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18; Tue, 12 Oct 2021 15:51:02 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::a974:b0e5:9c6:b9e6]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::a974:b0e5:9c6:b9e6%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 15:51:02 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
CC:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "An, Tedd" <tedd.an@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel: Fix bdaddress comparison with
 garbage value
Thread-Topic: [PATCH v1] Bluetooth: btintel: Fix bdaddress comparison with
 garbage value
Thread-Index: AQHXuaBi4PrY9W41v0ul9TVX3EMhsqvFq4mAgACWNICAAM0YAIAIf5Vw
Date:   Tue, 12 Oct 2021 15:51:02 +0000
Message-ID: <DM8PR11MB557361EF606AC51FF7AC4FF0F5B69@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20211005042613.9946-1-kiran.k@intel.com>
 <79B0A1CF-17D0-473C-A321-39E1BC291A89@holtmann.org>
 <CABBYNZL9f1j6sEcNm6B9ONg6yV=Pt=msuOd3Urb-0d-5vmm7qw@mail.gmail.com>
 <DM8PR11MB557322FB90F730BDE853E742F5B19@DM8PR11MB5573.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB557322FB90F730BDE853E742F5B19@DM8PR11MB5573.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36f25e7b-f1c5-4fee-5336-08d98d9817de
x-ms-traffictypediagnostic: DM8PR11MB5589:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5589C104AB969920B12B411CF5B69@DM8PR11MB5589.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G2swv+9F/m9daPIOak+h+dgXyX1y0AlKrlOGzpZoxqT8+rF4za/5fJNMF+cN0xHZUxpLuwT4YkYqaXxrXplxkN4jD4J45Ida54oXJkEWasNyDlvyf853NMR56cwq7BxNPv1FLPgxCvKrDmb2yfIZ0b1n9V33mkTbXSNA2d73kfJiUrPueomIJuOkQDVdlW+0hTfZYrkpiXWjX6JOhAhO57QkKB10XvTS8nuL86C+ebzwkwRlr+8l4yb0l/AdZoW9PkjwxOFK11Z5E9WUc1C0/MjlmXx1p4+mfyOzW25shORFJmw8iwYveKMDlqSUD8C7YhF4QDjCOWaFiC8SLoXqKE6MTk3Z7XFw7nc31wL1uapPS2JbHpaQw5XWEufc8ZJlv/+r3wd3IL3ORBXJX8SsOMBLW6mQzZLW8PCKOM4YtVpLAvx5W1fY/6B8+L5P9W/aCMnHpoK9XwzZyjT4i7p3nSgR4dvFbvTnVqzTqLVrlnPMh4Fm953S8Xe7RM3P2qGPtLoBMWDOgl6Gga/dWQcg6DXDrMuq6gNTYgL2DNo0piiPuw9B1xvA0T+fBXPnZgSglfw0NfaqYvhX24s7OXiMEIGBYbXCtqV+wNEH/B+1d6X7I6BcUvR+jijkj9TUJAbVPW73S7CK9yVoU8VlWjzChFEaQvzfVqyQFUl/l8dbLHuG9eBMufxwKOUiCjLPB3xM4+Fwtkjff4YyoG6IXRCkow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(66556008)(66946007)(6506007)(52536014)(66476007)(7696005)(66446008)(33656002)(8676002)(122000001)(316002)(53546011)(38070700005)(76116006)(38100700002)(2906002)(110136005)(83380400001)(64756008)(4326008)(71200400001)(186003)(54906003)(9686003)(55016002)(107886003)(5660300002)(8936002)(508600001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y09WNVEvYzgwM0NUWGxTdVR4WlZPeTU4dEZyN09mTlBBRmhobm84ZVYyYVJT?=
 =?utf-8?B?cmtQaEtESG1EaEpkR0xDUHk2SHY5RkZkM3BHV3F0SDZTK3BtY3hWRCtaZnhk?=
 =?utf-8?B?NGwyTFdZU2MzR0F1WkVvZ3UzbXBzb2hmcHorWkVXcVRVeHlCcHdEYVNDNUJY?=
 =?utf-8?B?R1FOMWFkQTNWZzRBOXlDN2xPM0V0bW4xQk5VUnBuUWFRZ2tjMjVDbnpPU1B1?=
 =?utf-8?B?Ujc1cGhLRG45Y1lzY1g4V20vLzgzejZiMW1RSE5lcUw4ZVd6KzZaczRyMlVs?=
 =?utf-8?B?NythTDFTTHZ0VjIzTVFWUlNpTnkyRHovNTV4Z2xTVTUwSFpYeGp5cjl4Q1Vv?=
 =?utf-8?B?QkxtOHdxRFZ5NGt5VEVmNEgzR0VPZ0EvZmNKVlVpSmNhOVBYdnJEMGFOV291?=
 =?utf-8?B?ZFhVeFJHNzBrMW00YnpDd2M1clQ0bjRDSHA2dWRlL0xXNVNKNVZkSys3eTkv?=
 =?utf-8?B?TTdSbzdVN2kycGgwbHRyWHNEK1o4M1M5Q29KbVM5b3Blb2xQYS9yZ0d1Z3Q4?=
 =?utf-8?B?VDJMb094d1ZMYVJ3RkVjcFlkem1DNEpidWZJd3ErVVVmTlovdWc4eVBCVzZ1?=
 =?utf-8?B?QWlFYndQTTZSWnZYL1pQTjQ0NGMyZVZ3bW9rTDdsZUpMZFI5YkFDODVjTGo1?=
 =?utf-8?B?bmdoeklwdExyVDhPc0htRG1TS2taNW1iYVRqMDliZEx2cDRxbHNaZmdDblQ5?=
 =?utf-8?B?Nkp4cGRrTU1IREdvc0tXelo5T3hFdnlKQzUzZTlyREh1NDRlTkhmMU41U2Rw?=
 =?utf-8?B?V3ZIZkE2K0p0WHd2MXhDeXcxem05ZHAzcmhYZkhKNVZWN001RUR6cXdOajNp?=
 =?utf-8?B?OGFMNitqOWZhZ29HZ01hWTUyY29maGlvL2xkTmVxZUVTUTNOMTdSY05lNzRU?=
 =?utf-8?B?SjFMLy92azNoU2RmdkIvVnhsWFNkbmZkajhnRzhIQjh3SXluMTloenBJK2tz?=
 =?utf-8?B?bHVPUGpEOXVyZGt3VzZOeUZ1eU8vYmFVZ3ovQnQ2Vm5SdThIZC9KWk9HdGhD?=
 =?utf-8?B?WVcyRWlSNGFyZFVPY1J3cmlBdkR3L3UxckpmRllPaUZhallRTEp6OWFiSi9w?=
 =?utf-8?B?SlJ2RllMTEZLZHdUSDFGL1EwSFFra2ZIRXlGYkIrSVZJSUMyMlRKbWJxeno3?=
 =?utf-8?B?Y3UrbFQyYXZYQ0FGNHhhZTBvZ1U0VVNnTmsxelppNDVyZU4zMFdtTVFlbWV0?=
 =?utf-8?B?cnlGcE1CanBZaUJVbWZyYXRYcjcySkg2b0tQS2hLRHBoRTUyR1F4L1JhcEMx?=
 =?utf-8?B?amUzRUxmbjU2eGI5NW9Mc0FPQVBkRkdzSzZWOS84OXlQK3BTTjF4M1hUdEVp?=
 =?utf-8?B?c2pJa0xrV25jS21wdkJxVDhZeEZHU1oyclJaQUpEcDdKbk16MWRMSGNMTWFu?=
 =?utf-8?B?Tkc3VytlaGU4Z0Y4OVBQUWRKMXFiK1lOYlBoQjhDM1dBaEJVY0w1ekVDMmFa?=
 =?utf-8?B?ZmJ3aUxJck43OWhYWmpSTmNwbGRHeS81cGNmV01ReVNBMHJCaUtzdml4UWxE?=
 =?utf-8?B?TWxDRXE5NG5BT3JoZW9EeVpVK3A2K00xU2JxN3lyUnhwc3ZERm9QRkxpblJk?=
 =?utf-8?B?M2FYb0tIb1prQkJ0bGRmQTJZREg2Q0o0aUxwZmZ0TjRkcndsVDVHYzRsRHNv?=
 =?utf-8?B?alpqVEttUHhqeTYrQVQ5VU9CQ3BhSGpXNGRPMWdjOWV1LzkrS2J6SjBSV2xW?=
 =?utf-8?B?a3NCWTlaZ1dwQ3dQM0VYVE5iNjFnU0IyQWV4Uk1SS1pGczdDZjllTnUwd3J4?=
 =?utf-8?Q?q8I4a4GXGTy5/dsXJnhcYCE93D+5XOTAr7zpKN6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f25e7b-f1c5-4fee-5336-08d98d9817de
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 15:51:02.3442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPR3ykxEbUaOYis3wgvKtcceOrVlLantaeZdPnFEWgJ6eayt5MA15xBz/51Jl5bFcedpK7GGvT/rFQxhfdiJtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5589
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQpGcmllbmRseSByZW1pbmRlci4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBLLCBLaXJhbg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciA3LCAy
MDIxIDExOjM2IEFNDQo+IFRvOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdt
YWlsLmNvbT47IE1hcmNlbCBIb2x0bWFubg0KPiA8bWFyY2VsQGhvbHRtYW5uLm9yZz4NCj4gQ2M6
IGxpbnV4LWJsdWV0b290aCA8bGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZz47IFNyaXZh
dHNhLCBSYXZpc2hhbmthcg0KPiA8cmF2aXNoYW5rYXIuc3JpdmF0c2FAaW50ZWwuY29tPjsgVHVt
a3VyIE5hcmF5YW4sIENoZXRoYW4NCj4gPGNoZXRoYW4udHVta3VyLm5hcmF5YW5AaW50ZWwuY29t
PjsgQW4sIFRlZGQgPHRlZGQuYW5AaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYx
XSBCbHVldG9vdGg6IGJ0aW50ZWw6IEZpeCBiZGFkZHJlc3MgY29tcGFyaXNvbiB3aXRoDQo+IGdh
cmJhZ2UgdmFsdWUNCj4gDQo+IEhpIE1hcmNlbCwgTHVpeiwNCj4gDQo+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRl
bnR6QGdtYWlsLmNvbT4NCj4gPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgNiwgMjAyMSAxMTox
OSBQTQ0KPiA+IFRvOiBNYXJjZWwgSG9sdG1hbm4gPG1hcmNlbEBob2x0bWFubi5vcmc+DQo+ID4g
Q2M6IEssIEtpcmFuIDxraXJhbi5rQGludGVsLmNvbT47IGxpbnV4LWJsdWV0b290aCA8bGludXgt
DQo+ID4gYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZz47IFNyaXZhdHNhLCBSYXZpc2hhbmthcg0K
PiA+IDxyYXZpc2hhbmthci5zcml2YXRzYUBpbnRlbC5jb20+OyBUdW1rdXIgTmFyYXlhbiwgQ2hl
dGhhbg0KPiA+IDxjaGV0aGFuLnR1bWt1ci5uYXJheWFuQGludGVsLmNvbT47IEFuLCBUZWRkIDx0
ZWRkLmFuQGludGVsLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBCbHVldG9vdGg6
IGJ0aW50ZWw6IEZpeCBiZGFkZHJlc3MgY29tcGFyaXNvbg0KPiA+IHdpdGggZ2FyYmFnZSB2YWx1
ZQ0KPiA+DQo+ID4gSGkgTWFyY2VsLA0KPiA+DQo+ID4gT24gV2VkLCBPY3QgNiwgMjAyMSBhdCAx
OjUyIEFNIE1hcmNlbCBIb2x0bWFubg0KPiA8bWFyY2VsQGhvbHRtYW5uLm9yZz4NCj4gPiB3cm90
ZToNCj4gPiA+DQo+ID4gPiBIaSBLaXJhbiwNCj4gPiA+DQo+ID4gPiA+IEludGVsIFJlYWQgVmVy
aXNpb24oVExWKSBkYXRhIGlzIHBhcnNlZCBpbnRvIGEgbG9jYWwgc3RydWN0dXJlDQo+ID4gPiA+
IHZhcmlhYmxlIGFuZCBpdCBjb250YWlucyBhIGZpZWxkIGZvciBiZCBhZGRyZXNzLiBCZCBhZGRy
ZXNzIGlzDQo+ID4gPiA+IHJldHVybmVkIG9ubHkgaW4gYm9vdGxvYWRlciBtb2RlIGFuZCBoZW5j
ZSBiZCBhZGRyZXNzIGluIFRMVg0KPiA+ID4gPiBzdHJ1Y3R1cmUgbmVlZHMgdG8gYmUgdmFsaWRh
dGVkIG9ubHkgaWYgY29udHJvbGxlciBpcyBwcmVzZW50IGluDQo+ID4gPiA+IGJvb3QgbG9hZGVy
DQo+ID4gbW9kZS4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogS2lyYW4gSyA8a2ly
YW4ua0BpbnRlbC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBkcml2ZXJzL2JsdWV0b290aC9i
dGludGVsLmMgfCAxOSArKysrKysrKysrKy0tLS0tLS0tDQo+ID4gPiA+IDEgZmlsZSBjaGFuZ2Vk
LCAxMSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+ID4gPiA+IGIvZHJpdmVycy9i
bHVldG9vdGgvYnRpbnRlbC5jIGluZGV4IDkzNTliZmY0NzI5Ni4uZDE3MDNjYzk5NzA1DQo+ID4g
PiA+IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMNCj4g
PiA+ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+ID4gPiA+IEBAIC0yMDgx
LDE0ICsyMDgxLDE2IEBAIHN0YXRpYyBpbnQNCj4gPiBidGludGVsX3ByZXBhcmVfZndfZG93bmxv
YWRfdGx2KHN0cnVjdCBoY2lfZGV2ICpoZGV2LA0KPiA+ID4gPiAgICAgICBpZiAodmVyLT5pbWdf
dHlwZSA9PSAweDAzKSB7DQo+ID4gPiA+ICAgICAgICAgICAgICAgYnRpbnRlbF9jbGVhcl9mbGFn
KGhkZXYsIElOVEVMX0JPT1RMT0FERVIpOw0KPiA+ID4gPiAgICAgICAgICAgICAgIGJ0aW50ZWxf
Y2hlY2tfYmRhZGRyKGhkZXYpOw0KPiA+ID4gPiAtICAgICB9DQo+ID4gPiA+IC0NCj4gPiA+ID4g
LSAgICAgLyogSWYgdGhlIE9UUCBoYXMgbm8gdmFsaWQgQmx1ZXRvb3RoIGRldmljZSBhZGRyZXNz
LCB0aGVuIHRoZXJlIHdpbGwNCj4gPiA+ID4gLSAgICAgICogYWxzbyBiZSBubyB2YWxpZCBhZGRy
ZXNzIGZvciB0aGUgb3BlcmF0aW9uYWwgZmlybXdhcmUuDQo+ID4gPiA+IC0gICAgICAqLw0KPiA+
ID4gPiAtICAgICBpZiAoIWJhY21wKCZ2ZXItPm90cF9iZF9hZGRyLCBCREFERFJfQU5ZKSkgew0K
PiA+ID4gPiAtICAgICAgICAgICAgIGJ0X2Rldl9pbmZvKGhkZXYsICJObyBkZXZpY2UgYWRkcmVz
cyBjb25maWd1cmVkIik7DQo+ID4gPiA+IC0gICAgICAgICAgICAgc2V0X2JpdChIQ0lfUVVJUktf
SU5WQUxJRF9CREFERFIsICZoZGV2LT5xdWlya3MpOw0KPiA+ID4gPiArICAgICB9IGVsc2Ugew0K
PiA+ID4gPiArICAgICAgICAgICAgIC8qDQo+ID4gPiA+ICsgICAgICAgICAgICAgICogQ2hlY2sg
Zm9yIHZhbGlkIGJkIGFkZHJlc3MgaW4gYm9vdCBsb2FkZXIgbW9kZS4gRGV2aWNlDQo+ID4gPiA+
ICsgICAgICAgICAgICAgICogd2lsbCBiZSBtYXJrZWQgYXMgdW5jb25maWd1cmVkIGlmIGVtcHR5
IGJkIGFkZHJlc3MgaXMNCj4gPiA+ID4gKyAgICAgICAgICAgICAgKiBmb3VuZC4NCj4gPiA+ID4g
KyAgICAgICAgICAgICAgKi8NCj4gPiA+ID4gKyAgICAgICAgICAgICBpZiAoIWJhY21wKCZ2ZXIt
Pm90cF9iZF9hZGRyLCBCREFERFJfQU5ZKSkgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgYnRfZGV2X2luZm8oaGRldiwgIk5vIGRldmljZSBhZGRyZXNzIGNvbmZpZ3VyZWQiKTsNCj4g
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHNldF9iaXQoSENJX1FVSVJLX0lOVkFMSURfQkRB
RERSLCAmaGRldi0+cXVpcmtzKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICB9DQo+ID4gPiA+ICAg
ICAgIH0NCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgYnRpbnRlbF9nZXRfZndfbmFtZV90bHYodmVy
LCBmd25hbWUsIHNpemVvZihmd25hbWUpLCAic2ZpIik7DQo+ID4gPiA+IEBAIC0yNDY2LDYgKzI0
NjgsNyBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfc2V0dXBfY29tYmluZWQoc3RydWN0DQo+ID4gaGNp
X2RldiAqaGRldikNCj4gPiA+ID4gICAgICAgICAgICAgICBnb3RvIGV4aXRfZXJyb3I7DQo+ID4g
PiA+ICAgICAgIH0NCj4gPiA+ID4NCj4gPiA+ID4gKyAgICAgbWVtc2V0KCZ2ZXJfdGx2LCAwLCBz
aXplb2YodmVyX3RsdikpOw0KPiA+ID4NCj4gPiA+IHRoaXMgY2hhbmdlIGlzIG5vdCBkZXNjcmli
ZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLiBXaHkgaXMgdGhhdCBub3cNCj4gPiA+IG91dCBvZg0K
PiA+IGEgc3VkZGVuIG5lZWRlZD8NCj4gPg0KPiA+IEkgZ3Vlc3MgdGhpcyBpcyBqdXN0IHRvIG1h
a2Ugc3VyZSB0aGUgdmVyX3RsdiBpcyBpbml0aWFsaXplZCBzbyBpdHMNCj4gPiBvdHBfYmRfYWRk
ciBiZSBzZXQgdG8gYWxsIHplcm9zIChCREFERFJfQU5ZKSBvdGhlcndpc2UgdGhlIGNvZGUgYWJv
dmUNCj4gPiBkb2Vzbid0IHdvcmsgYXMgaXQgYXR0ZW1wdHMgdG8gY29tcGFyZSB0byBCREFERFJf
QU5ZLg0KPiANCj4gWWVzLiBJZiBub3QgbWVtc2V0LCB0aGVuIGdhcmJhZ2UgdmFsdWUgaXMgY29t
cGFyZWQgYWdhaW5zdCBCREFERFJfQU5ZLg0KPiA+DQo+ID4gPiBSZWdhcmRzDQo+ID4gPg0KPiA+
ID4gTWFyY2VsDQo+ID4gPg0KPiA+DQo+ID4NCj4gPiAtLQ0KPiA+IEx1aXogQXVndXN0byB2b24g
RGVudHoNCg0KVGhhbmtzLA0KS2lyYW4NCg0K
