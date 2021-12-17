Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A46C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Dec 2021 02:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhLQCrX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Dec 2021 21:47:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:23043 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhLQCrW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Dec 2021 21:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639709242; x=1671245242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bGPg9ereT4td7h3liboS+nZChSen9ZZL5io/mTv50+M=;
  b=bPWmh3AA24PzDARLZj8yBOsWWyQskAQRzyzwEgCROfyHVoT8YdHhuzJO
   6TUJDO4gowGldrb/jZ3Gt0gP8KjYIyXYqRD2J9Few9RC5lwJhuR8QyyIa
   SA8gW55PrNa3vjcdPE0ktW73YzLQ+qN+l8P6RtVt45ljDEsXSgBWDdCEh
   2iT0eZ8FIWRqX/1SgtXM3/mqki4VRyrPqBruOLnQ3K+AwCK7XrGlPZxzc
   oNcQwr4CMgg/MoIPrGyFk2fMZVODbxEhEIddcTVGJQ5p5f4ZD1Wj9Dt7Z
   66VUveLYU2sC+FOZCvxU3r6EdfJhhgeRznIh5phO3JYBbxmzEtiZ8Vu5X
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="219678872"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="219678872"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 18:47:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="683219150"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2021 18:47:20 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 18:47:19 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 16 Dec 2021 18:47:19 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 16 Dec 2021 18:47:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GR11mZfC1kNrkPIL1bB6ozNHN8Q2fBkqbUpyQW24ladQHxJYHBnwkWKt4NMIlGnEzQM50WddYE+IgtlgxrCj0Ngt0OuFVE302Nnbxs2BQPMHQVuSg+ryfAfs6TfuUtE6bkScvETj1qHy5XG/tIJ2FfemNKyA8XO/yNlkSkUXM60nDhukcsHeBvirKnyMa62EJoPy02Q7tSdszoDl0vqzkzucxzk0POjIRB+HWaX0aZGOLuU1OK3w+oLIgQVzVbtzcLnThAd/1c0xLQd0UD6TpQ5hWTKqquWHEMfpLab7CLncdf3q9khQZ26Pz7aMdVACrYPU3ZVkEnWaunBABbsjkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGPg9ereT4td7h3liboS+nZChSen9ZZL5io/mTv50+M=;
 b=chTQ7Ue6D/v1xkCFOib5FhsqeXlJlQ9LOTkoCRtXkV5yorG6V90y1GZP6mCjdf5bUaVznFtuL3XCNfPOFxbozWiNxO89/QEQjZEIC3JWVizHs3WsMfQooBaIsg64+0nXmcr/crBlRmqlN+PxLNS8om6ldDgLTovmpwbJQnHQEUwQiyO6CcaMoUtzBdWcMuh6plG5rQooKCYmLWTWMpzNpkDkziatNeT5wJRy5HCJQlseEnCduGGonGZbMK4wPzmtMEi+GcQ9d+y836AOMNuiboVnNs+XUrO+Q/Q9ct9V2BCVhEx0c+Y4mELsmRlbIKzyklyI+6I2RyUoD8rPcHYlHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 02:47:17 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::5953:2244:53ea:b68f]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::5953:2244:53ea:b68f%5]) with mapi id 15.20.4801.015; Fri, 17 Dec 2021
 02:47:17 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "hj.tedd.an@gmail.com" <hj.tedd.an@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC PATCH v2] Bluetooth: btintel: Fix broken LED quirk for
 legacy ROM devices
Thread-Topic: [RFC PATCH v2] Bluetooth: btintel: Fix broken LED quirk for
 legacy ROM devices
Thread-Index: AQHX8sFUOehkja9FU0C9xWapVmNOIKw12b4AgAAhjAA=
Date:   Fri, 17 Dec 2021 02:47:16 +0000
Message-ID: <a9b72835896aa4c8215b1a37af174d96edd0bf13.camel@intel.com>
References: <20211216210958.62129-1-hj.tedd.an@gmail.com>
         <CABBYNZKYvcEe5RHA337U_MrJyr3xZ2BEENQ38ZG2twwenrznXg@mail.gmail.com>
In-Reply-To: <CABBYNZKYvcEe5RHA337U_MrJyr3xZ2BEENQ38ZG2twwenrznXg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-1.fc34) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d34d0e0-71f7-4487-79ab-08d9c10789ff
x-ms-traffictypediagnostic: CO1PR11MB5026:EE_
x-microsoft-antispam-prvs: <CO1PR11MB50268178BD8CA375463A2D93FF789@CO1PR11MB5026.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F0StV73BqOE51mA0xIvic4RHyRM5N/g9QZOpSHjjDZy+gRW45kumD0F9nVqGX7N09PS/b01eDW/qYtnTa72LijTRgAFRrLb+dayCvhWLSbY0gYix5vGOEZiVuLEWRiGogmtv/XxIlWWiEPqK5oGgc+ZUDOhll1JFJBIYLOhQfj9aw3fzA5KtsGzwW8MZC1jpy7ar/eHwcOpLwQYAGMrhIraRuDNp39NVWCWBLqd57TkVTMqsY2FbuvLLF5LGb++UYS1xRa2z1ENnUNNx+Rzie/m3YHdnY/tUR3UrfVgo39p1vx1zzNwv2uJ7PNYQRsxe4pFk2HBwvQNUBaOa13TXV+ILhnShUd/c3JSHiFvkJ39qrFKisUZGYi5R/zQjg7BtiaonnWB9mllNbivqox3yrNI3uVZsnSwuPaNkEOMOlsA6u1LgOuPCTZ+fvTmrXvh39nNCrydxlDDLLpa9EauUIcIeLyK8zUW9EGn85Pg1F3nxwMoXjEabnTnLbSxPZb0BHkwNjlkOyV3rHyNPQUgZrHWQk9cpJFS0ZWHO97dNP1u/UlfJOf9dH6d+QDvjFQZv3WSZ/33u/r6db09CaJxWyFP7nZI/uKzNUTeOhn4gBBc1ss1/8qGr2MtTCRGRDr7JKn+JQhSZ9p6ZYaWWfvXW0dCw3LhC4Rk7fBx6UjdykMVMxXCYhUuPfcpUU++NOuIpXGSfIwQMZTU+UpkL8MW+Zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6486002)(6512007)(76116006)(66476007)(64756008)(4001150100001)(26005)(86362001)(508600001)(110136005)(2906002)(53546011)(71200400001)(38070700005)(8676002)(122000001)(2616005)(38100700002)(316002)(83380400001)(5660300002)(66446008)(36756003)(6506007)(66946007)(66556008)(4326008)(82960400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFVXYmxvVGN0MFBzMkFhM09EVk55K2lWa1cvRUR2REZmeDdBKytHb2VPSVgw?=
 =?utf-8?B?NGFQUU9UOGtkMWlPYk8yNitHZkdmRFYyRlJIY2l5VFU0ZlNQamlZczRrV2lM?=
 =?utf-8?B?L2dxTjROUk52UDNRd2Z1bkJXN2swR2s4cmFESlJINXU5MS8wMnpBNTd6d0V5?=
 =?utf-8?B?M3dBV1dCTVFMa1N3cVAvTlZjWDR3dDRtallOeEhvdi9hdnJHZG8zRVNvbFF6?=
 =?utf-8?B?MWdPWFpKb1owQVVGTm1uUFQyQ1dPTitVMFk3MHgwc05XRjBBNlR4RlJtdG02?=
 =?utf-8?B?aTF4VnZ4c3ZnRUpaUThSNnV1OUx6OTNJMjN6OW9DK1NiaUVVaUcybEpaVFJn?=
 =?utf-8?B?YkN4eU1BbXZCLzJ1K0JXZjVjUXdzOHJDWU13WllGeHdxVDdEcnU4R2VJQVlu?=
 =?utf-8?B?TGRZZDNRMEJ4aHlWSXlIMzk3Z01xMWYwai9nTGUxMjIxQTRLOExjeUtaeTZ0?=
 =?utf-8?B?S1BwSXp4Mmd0YmdURUZ3YW9ldENVZERsRExkN2l4RXNxM1ZaLzdzNy95b1Zr?=
 =?utf-8?B?ZFV6UlBoSGhvakowMjI4cFdVUDlqUjVNdzFXbkNja2Uwb3FtYXNmWEd5OS80?=
 =?utf-8?B?VlYrTHlydEJXYmgwVXd4WU42Q2dCZ09tVEtFZEFmb0tnRVExY1dzVUVZNlpu?=
 =?utf-8?B?clQrSkVFTjRRK0N1R2VTaU5QUGdYQ01RNTFCdHoxcjl4RlF1QVZkNEUwMWVa?=
 =?utf-8?B?R3VuRGFOMHpIN3U3RG5ycVVnbHM2dm9wVHV0YjU3NG1PVWIxWVVudWpTKy9z?=
 =?utf-8?B?YU5NN2habGl3N2xkY2hOZUlieG1jRCt5NWZRdXpSRnJGdmJSZkU3Ty83YzNJ?=
 =?utf-8?B?a3VWNjZjWVlmdnAxR1pCczQvWWVxRVBWV1U5d1B5d1VNZEdqakRtMzAyK3do?=
 =?utf-8?B?VXIyYW9Va2NvU3FVcGlabjlwZEhxZUtSVkpzRXZKVE5YNVY2U3FpZkVEYzFo?=
 =?utf-8?B?aEFhWStqUUVSL3FnQXVVUUNSUVdON2x5STJXUHRPRzRsejR6VlBuQitmdkRO?=
 =?utf-8?B?U0lXMU5FR2hXVm9TVDNzSlVPd2FxY0lXV3ZnNjZhYU40bFlXMFdJNHI4ZzdK?=
 =?utf-8?B?TWtMS0RYTENKWWJFczJJbEU1aHlMcXEwVjJPTlJldnRFblllbUtuRGdnMXA4?=
 =?utf-8?B?UHlUcWJoTXN5dXk4cElSKzR0NFpYSm5ieTZ0SVE3bytqRk14ME1XSUxCQUpU?=
 =?utf-8?B?SDdFeW1Cd2dqL1hMTFBRMkJlUGdudWo5RjNtbU0vR2RER1U0b2RtTElUMFpm?=
 =?utf-8?B?NW92cStCc0k2Lzl3eGVKY2pSb291bUdWNkR0cldDR0pRZVAyN3ZhckZZNjBY?=
 =?utf-8?B?NE5odXdVRkdseDhwRG4rM2twbUJYOVU4ZVFzY2JRS0xnOFNUZHlyNmRJT3RN?=
 =?utf-8?B?UHF2OGpXdTA3NTYzRUZkWmdJT2lzSGM5bGhReTBpVjVraEZKc0xldEl2cTJ6?=
 =?utf-8?B?YjlEUWQrZ0RtYlE2WEV6REVUSVdZWmE4KzUxeWhRY1J0T0txclF1MlBZZG9N?=
 =?utf-8?B?MGl2Z1ZOUllyTzRWOWk2UGY4MUQxY1JWOHVaYk4vRTFVYzY0b29CMEZFZkZC?=
 =?utf-8?B?ZENiUzJsNzg4QzRJMExadGRzOEFmUmlvcCtkVU9EWHFYdFA1LzUvNnZyUkRY?=
 =?utf-8?B?dmFHS3BHWlNlbC9pZHlZbnBpc0xJWStMS0lKWEZlZDFDWnpKSUVQMTZwQ1pL?=
 =?utf-8?B?OGdXb3JPOGZrOFNpWW1PSDlJN0VQRnpiZWN1SGxGMEpiT2hCcXk1UlNJWEJS?=
 =?utf-8?B?RnpCSHZNWm5LVXVhQUdheCszVGd2Y054eG1sS1RhaUp5MVd5TGNFbTNVV3dk?=
 =?utf-8?B?Wk5tK0wzMWQ5T3oyM3lMRk54K0pTMHlSZVd0V3MxcFpvdXAxMUFCSThDa0FQ?=
 =?utf-8?B?R3N4b2VwNG92Tlgwd0JmSnR6WXdTV1k2VFRWRU5GZGRjeWh6S252LytkWW94?=
 =?utf-8?B?WXo2djluQzJ0Z3ViY3dKOXVqSTR2QzJCclgwaU1tQm1lVWtWNXZ0c040bjlF?=
 =?utf-8?B?dW13dldPNU5DWGtYV0hNUlJOTmE4bmh4Mm14K3R2aVNTWk5SaVhkWHFrOS9I?=
 =?utf-8?B?Tm1UTkRUbWRPeExnNW40bjNRdjRPRGxiTUdnbE9SQmU3cEQ2MnBhcG5PT0ox?=
 =?utf-8?B?aTNkTUtBRkVweXI2eDJ1amhLeE96bWFnTjhwVjZOZ2Y4R3RKaVVJSWFsbUo1?=
 =?utf-8?Q?8ZUYEAJDe33i6LmKbf5ViEA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BD513F4E942B1489C5F68CAE6687442@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d34d0e0-71f7-4487-79ab-08d9c10789ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 02:47:17.2695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUP1zyWEXw2Ryxz5zFC41Q/qPW0L0IKHNapoz9Ev/yvMCJdFRV7HO7AzGTR+vMVbPgBRL9InbTufYom5G9ambA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5026
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwKCk9uIFRodSwgMjAyMS0xMi0xNiBhdCAxNjo0NyAtMDgwMCwgTHVpeiBBdWd1c3Rv
IHZvbiBEZW50eiB3cm90ZToKPiBIaSBUZWRkLAo+IAo+IE9uIFRodSwgRGVjIDE2LCAyMDIxIGF0
IDQ6MDQgUE0gVGVkZCBIby1KZW9uZyBBbiA8aGoudGVkZC5hbkBnbWFpbC5jb20+IHdyb3RlOgo+
ID4gCj4gPiBGcm9tOiBUZWRkIEhvLUplb25nIEFuIDx0ZWRkLmFuQGludGVsLmNvbT4KPiA+IAo+
ID4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgYnJva2VuIExFRCBxdWlyayBmb3IgSW50ZWwgbGVnYWN5
IFJPTSBkZXZpY2VzLgo+ID4gVG8gZml4IHRoZSBMRUQgaXNzdWUgdGhhdCBkb2Vzbid0IHR1cm4g
b2ZmIGltbWVkaWF0ZWx5LCB0aGUgaG9zdCBzZW5kcwo+ID4gdGhlIFNXIFJGS0lMTCBjb21tYW5k
IHdoaWxlIHNodXR0aW5nIGRvd24gdGhlIGludGVyZmFjZSBhbmQgaXQgcHV0cyB0aGUKPiA+IGRl
dmljZXMgaW4gYW4gYXNzZXJ0ZWQgc3RhdGUuCj4gPiAKPiA+IE9uY2UgdGhlIGRldmljZSBpcyBp
biBTVyBSRktJTEwgc3RhdGUsIGl0IGNhbiBvbmx5IGFjY2VwdCBIQ0lfUmVzZXQgdG8KPiA+IGV4
aXQgZnJvbSB0aGUgU1cgUkZLSUxMIHN0YXRlLiBUaGlzIHBhdGNoIGNoZWNrcyB0aGUgcXVpcmsg
YW5kIHNlbmRzIHRoZQo+ID4gSENJX1Jlc2V0IGJlZm9yZSBzZW5kaW5nIHRoZSBIQ0lfSW50ZWxf
UmVhZF9WZXJzaW9uIGNvbW1hbmQuCj4gPiAKPiA+IFRoZSBhZmZlY3RlZCBsZWdhY3kgUk9NIGRl
dmljZXMgYXJlCj4gPiDCoC0gODA4NzowYTJhCj4gPiDCoC0gODA4NzowYWE3Cj4gPiAKPiA+IGZp
eGVzOiBmZmNiYTgyN2MwYTFkICgiQmx1ZXRvb3RoOiBidGludGVsOiBGaXggdGhlIExFRCBpcyBu
b3QgdHVybmluZyBvZmYgaW1tZWRpYXRlbHkiKQo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBUZWRk
IEhvLUplb25nIEFuIDx0ZWRkLmFuQGludGVsLmNvbT4KPiA+IC0tLQo+ID4gwqBkcml2ZXJzL2Js
dWV0b290aC9idGludGVsLmMgfCAxMyArKysrKystLS0tLS0tCj4gPiDCoGRyaXZlcnMvYmx1ZXRv
b3RoL2J0dXNiLmPCoMKgIHwgMTAgKysrKysrKystLQo+ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDE0
IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2JsdWV0b290aC9idGludGVsLmMgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMKPiA+
IGluZGV4IGUxZjk2ZGY4NDdiOC4uNzVmOGQ3YWNlYjM1IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVy
cy9ibHVldG9vdGgvYnRpbnRlbC5jCj4gPiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVs
LmMKPiA+IEBAIC0yMzU1LDggKzIzNTUsMTMgQEAgc3RhdGljIGludCBidGludGVsX3NldHVwX2Nv
bWJpbmVkKHN0cnVjdCBoY2lfZGV2ICpoZGV2KQo+ID4gwqDCoMKgwqDCoMKgwqDCoCAqIEFzIGEg
d29ya2Fyb3VuZCwgc2VuZCBIQ0kgUmVzZXQgY29tbWFuZCBmaXJzdCB3aGljaCB3aWxsIHJlc2V0
IHRoZQo+ID4gwqDCoMKgwqDCoMKgwqDCoCAqIG51bWJlciBvZiBjb21wbGV0ZWQgY29tbWFuZHMg
YW5kIGFsbG93IG5vcm1hbCBjb21tYW5kIHByb2Nlc3NpbmcKPiA+IMKgwqDCoMKgwqDCoMKgwqAg
KiBmcm9tIG5vdyBvbi4KPiA+ICvCoMKgwqDCoMKgwqDCoCAqCj4gPiArwqDCoMKgwqDCoMKgwqAg
KiBGb3IgSU5URUxfQlJPS0VOX0xFRCwgdGhlc2UgZGV2aWNlcyBoYXZlIGFuIGlzc3VlIHdpdGgg
TEVEIHdoaWNoCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBkb2Vzbid0IGdvIG9mZiBpbW1lZGlhdGVs
eSBkdXJpbmcgc2h1dGRvd24uIFNldCB0aGUgZmxhZyBoZXJlIHRvIHNlbmQKPiA+ICvCoMKgwqDC
oMKgwqDCoCAqIHRoZSBMRUQgT0ZGIGNvbW1hbmQgZHVyaW5nIHNodXRkb3duLgo+ID4gwqDCoMKg
wqDCoMKgwqDCoCAqLwo+ID4gLcKgwqDCoMKgwqDCoCBpZiAoYnRpbnRlbF90ZXN0X2ZsYWcoaGRl
diwgSU5URUxfQlJPS0VOX0lOSVRJQUxfTkNNRCkpIHsKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKGJ0
aW50ZWxfdGVzdF9mbGFnKGhkZXYsIElOVEVMX0JST0tFTl9JTklUSUFMX05DTUQpIHx8Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGJ0aW50ZWxfdGVzdF9mbGFnKGhkZXYsIElOVEVMX0JST0tFTl9MRUQpKSB7Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2tiID0gX19oY2lfY21kX3N5bmMoaGRldiwgSENJ
X09QX1JFU0VULCAwLCBOVUxMLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhDSV9JTklUX1RJTUVPVVQp
Owo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChJU19FUlIoc2tiKSkgewo+
ID4gQEAgLTI0MjgsMTIgKzI0MzMsNiBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfc2V0dXBfY29tYmlu
ZWQoc3RydWN0IGhjaV9kZXYgKmhkZXYpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZXRfYml0KEhDSV9RVUlSS19XSURF
QkFORF9TUEVFQ0hfU1VQUE9SVEVELAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZoZGV2LT5x
dWlya3MpOwo+ID4gCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLyogVGhlc2UgZGV2aWNlcyBoYXZlIGFuIGlzc3VlIHdpdGggTEVEIHdoaWNoIGRvZXNu
J3QKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICog
Z28gb2ZmIGltbWVkaWF0ZWx5IGR1cmluZyBzaHV0ZG93bi4gU2V0IHRoZSBmbGFnCj4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGhlcmUgdG8gc2Vu
ZCB0aGUgTEVEIE9GRiBjb21tYW5kIGR1cmluZyBzaHV0ZG93bi4KPiA+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnRpbnRlbF9zZXRfZmxhZyhoZGV2LCBJTlRF
TF9CUk9LRU5fTEVEKTsKPiA+IC0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZXJyID0gYnRpbnRlbF9sZWdhY3lfcm9tX3NldHVwKGhkZXYsICZ2ZXIp
Owo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVh
azsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIDB4MGI6wqDCoMKgwqDC
oCAvKiBTZlAgKi8KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jIGIv
ZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYwo+ID4gaW5kZXggZDFiZDllZTBhNmFiLi5jNmEwNzBk
NTI4NGYgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jCj4gPiArKysg
Yi9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jCj4gPiBAQCAtNjAsNiArNjAsNyBAQCBzdGF0aWMg
c3RydWN0IHVzYl9kcml2ZXIgYnR1c2JfZHJpdmVyOwo+ID4gwqAjZGVmaW5lIEJUVVNCX1dJREVC
QU5EX1NQRUVDSMKgIDB4NDAwMDAwCj4gPiDCoCNkZWZpbmUgQlRVU0JfVkFMSURfTEVfU1RBVEVT
wqDCoCAweDgwMDAwMAo+ID4gwqAjZGVmaW5lIEJUVVNCX1FDQV9XQ042ODU1wqDCoMKgwqDCoCAw
eDEwMDAwMDAKPiA+ICsjZGVmaW5lIEJUVVNCX0lOVEVMX0JST0tFTl9MRUQgMHgyMDAwMDAwCj4g
Cj4gSSB3b25kZXIgd2h5IHdlIGhhdmVuJ3QgYmVlbiB1c2luZyBCSVQgbWFjcm8gaGVyZSBhbmQg
ZGlkIHdlIG1ha2UgYQo+IG1pc3Rha2UgYW5kIGxlYXZlIG9uZSBiaXQgYmVoaW5kPyBPciBzb21l
dGhpbmcgZWxzZSB3YXMgYXQgdGhpcyBiaXQKPiBwb3NpdGlvbj8KClRoZXJlIHVzZWQgdG8gYmUg
YSBmbGFnIEJUVVNCX0lOVEVMX05FV0dFTiwgYW5kIGl0IHdhcyByZW1vdmVkIHdoaWxlCnJlZmFj
dG9yaW5nIHRoZSBidGludGVsLCBhbmQgdGhlIE5DTUQgd2FzIGFkZGVkIGJlZm9yZSByZW1vdmlu
ZyB0aGUKTkVXR0VOIGZsYWcuCgo+IAo+ID4gwqAjZGVmaW5lIEJUVVNCX0lOVEVMX0JST0tFTl9J
TklUSUFMX05DTUQgMHg0MDAwMDAwCj4gPiAKPiA+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCB1c2Jf
ZGV2aWNlX2lkIGJ0dXNiX3RhYmxlW10gPSB7Cj4gPiBAQCAtMzgyLDkgKzM4MywxMSBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHVzYl9kZXZpY2VfaWQgYmxhY2tsaXN0X3RhYmxlW10gPSB7Cj4gPiDC
oMKgwqDCoMKgwqDCoCB7IFVTQl9ERVZJQ0UoMHg4MDg3LCAweDA3ZGEpLCAuZHJpdmVyX2luZm8g
PSBCVFVTQl9DU1IgfSwKPiA+IMKgwqDCoMKgwqDCoMKgIHsgVVNCX0RFVklDRSgweDgwODcsIDB4
MDdkYyksIC5kcml2ZXJfaW5mbyA9IEJUVVNCX0lOVEVMX0NPTUJJTkVEIHwKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJUVVNCX0lOVEVMX0JST0tF
Tl9JTklUSUFMX05DTUQgfSwKPiA+IC3CoMKgwqDCoMKgwqAgeyBVU0JfREVWSUNFKDB4ODA4Nywg
MHgwYTJhKSwgLmRyaXZlcl9pbmZvID0gQlRVU0JfSU5URUxfQ09NQklORUQgfSwKPiA+ICvCoMKg
wqDCoMKgwqAgeyBVU0JfREVWSUNFKDB4ODA4NywgMHgwYTJhKSwgLmRyaXZlcl9pbmZvID0gQlRV
U0JfSU5URUxfQ09NQklORUQgfAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBCVFVTQl9JTlRFTF9CUk9LRU5fTEVEIH0sCj4gPiDCoMKgwqDCoMKgwqDC
oCB7IFVTQl9ERVZJQ0UoMHg4MDg3LCAweDBhMmIpLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9JTlRF
TF9DT01CSU5FRCB9LAo+ID4gLcKgwqDCoMKgwqDCoCB7IFVTQl9ERVZJQ0UoMHg4MDg3LCAweDBh
YTcpLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9JTlRFTF9DT01CSU5FRCB9LAo+ID4gK8KgwqDCoMKg
wqDCoCB7IFVTQl9ERVZJQ0UoMHg4MDg3LCAweDBhYTcpLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9J
TlRFTF9DT01CSU5FRCB8Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEJUVVNCX0lOVEVMX0JST0tFTl9MRUQgfSwKPiA+IMKgwqDCoMKgwqDCoMKgIHsg
VVNCX0RFVklDRSgweDgwODcsIDB4MGFhYSksIC5kcml2ZXJfaW5mbyA9IEJUVVNCX0lOVEVMX0NP
TUJJTkVEIH0sCj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgIC8qIE90aGVyIEludGVsIEJsdWV0b290
aCBkZXZpY2VzICovCj4gPiBAQCAtMzcyNCw2ICszNzI3LDkgQEAgc3RhdGljIGludCBidHVzYl9w
cm9iZShzdHJ1Y3QgdXNiX2ludGVyZmFjZSAqaW50ZiwKPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIChpZC0+ZHJpdmVyX2luZm8gJiBCVFVTQl9JTlRFTF9CUk9LRU5f
SU5JVElBTF9OQ01EKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBidGludGVsX3NldF9mbGFnKGhkZXYsIElOVEVMX0JST0tFTl9JTklUSUFMX05DTUQp
Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGlkLT5kcml2ZXJf
aW5mbyAmIEJUVVNCX0lOVEVMX0JST0tFTl9MRUQpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnRpbnRlbF9zZXRfZmxhZyhoZGV2LCBJTlRFTF9CUk9L
RU5fTEVEKTsKPiAKPiBJIHdvbmRlciBpZiB3b3VsZG4ndCBiZSBzaW1wbGVzIHRvIGhhdmUgYSBm
bGFnIGUuZy4gSU5URUxfTkVFRF9SRVNFVAo+IGluc3RlYWQgb2YgcmVwbGljYXRpbmcgdGhlIHF1
aXJrcyBhcyBmbGFncyBzaW5jZSBpbiBlaXRoZXIgY2FzZSB0aGUKPiBhY3R1YWwgb3V0Y29tZSBp
cyB0byBzZW5kIGEgcmVzZXQuCgpUaGUgcmVzdWx0IGlzIHNhbWUgdGhvdWdoLCBJIHRoaW5rIGl0
IGlzIGJldHRlciB0byBiZSBtb3JlIHNwZWNpZmljLgpJIGFtIGZpbmUgd2l0aCBpdCBhbHNvLgoK
PiAKPiA+IMKgwqDCoMKgwqDCoMKgIH0KPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKGlkLT5k
cml2ZXJfaW5mbyAmIEJUVVNCX01BUlZFTEwpCj4gPiAtLQo+ID4gMi4yNS4xCj4gPiAKPiAKPiAK
Cg==
