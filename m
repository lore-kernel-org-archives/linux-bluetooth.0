Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AA5C4708F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 05:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FAF4613AD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 05:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhFAFYD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Jun 2021 01:24:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:24746 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhFAFYC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Jun 2021 01:24:02 -0400
IronPort-SDR: +Lz6LfIUqpaS81ctXcK8qWMRtwFzToBei4uufEYtnVA9nbWwUyyc1zLgK4PoiOMooi+CXBeRty
 3AqFfc9cB+FA==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="183835562"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="183835562"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 22:22:19 -0700
IronPort-SDR: YorbpU16o900KxQa2GC0aD0Y/30Cec0hDLuLWtODdP4zOmidHWzlMP5HYAcPt9ELmE27Z5f3Lx
 eV1vKnTrs9gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="445195368"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 31 May 2021 22:22:19 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 31 May 2021 22:22:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 31 May 2021 22:22:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 31 May 2021 22:22:19 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Mon, 31 May 2021 22:22:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ghzr47k401cI8KQpUrLzwRS4iZo7LX63ofs6U/1w+9/zsvhHM7rwxDpc+QcicbJUyKLLz4aXHYWCBZhMoknMl3jir0NVBq217eauVsVe83OEyWmhNPe+ecQcRYI11G/Da3cb1a2zOjNH3TyZ0pCS8l9JViA4lHi/be4Kf8md4b4MZW6DVfi9/0N5sAaqeyI7V9nOzYM0et/+Tp3s3ZH5D3EpGKYWpb43NZOrPa/TwsyIsxv2kBf//jqH8afh+x6sBjXrXGmj1/y9RdcEFGModDSGDhDT1ggzgvTucH9/X0/W4UjKxiCogjLCGLNYE7RdE+iYJlvvVo2lQVuVt+Frgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NvMnXq4ojAMbmkqyGo/u6+VkQA+Stg8BzJeuU7Agz0=;
 b=Gv6FUR5Xp0R/lKLHC20rsXZLNDOhftdtg9/ptyiFQHBrmRQIZ/TgGo00caJfWtgXQm/Ie10ix9jhgxjfMvAJMOCtvpK8A9fNevteaWiydqaEEsNesgnm6e4PsDOIBkkT7Wb1GNVqN5UrAVoKpobLIgEIqvInVK25hrzIY3ykSA/Xz75nNyJofipBBY1yJ9msagu+jMwYFt7ajsZbr47/XV7QSpLHs6z1z8/gA3BxpCQjoPL/+pnuwK7MDW6Rk48c3Y/hGrlUTgF+i6ateFo5idaAqNaFHbCPmKowJk8tLE7r8KuKh10zmwMKRKXjhFV2mx2jsN7pXodvv5Y1MXtXPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NvMnXq4ojAMbmkqyGo/u6+VkQA+Stg8BzJeuU7Agz0=;
 b=SJJ0Boob1kF908AVctDSisaB2cgfaTqZ2lidNtdAiA6ZMy+greNJg+y2vaOSQC0slImo3GmHPjBHNH0BYS8JslgDmnxIHjal15yBSQYhSDo64VH7EdfBqKq0RFhAP5igOxyvGfvbZi7ZIO6Qg2XvI1dcKW5vGntDRM/VHhcYJ28=
Received: from SJ0PR11MB4863.namprd11.prod.outlook.com (2603:10b6:a03:2ae::23)
 by BYAPR11MB3573.namprd11.prod.outlook.com (2603:10b6:a03:fe::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.26; Tue, 1 Jun
 2021 05:22:03 +0000
Received: from SJ0PR11MB4863.namprd11.prod.outlook.com
 ([fe80::85fa:2963:2153:7eef]) by SJ0PR11MB4863.namprd11.prod.outlook.com
 ([fe80::85fa:2963:2153:7eef%6]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 05:22:03 +0000
From:   "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Joseph Hwang <josephsih@chromium.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Joseph Hwang <josephsih@google.com>,
        "ChromeOS Bluetooth Upstreaming" 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "K, Kiran" <kiran.k@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] Bluetooth: btusb: support link statistics
 telemetry events
Thread-Topic: [PATCH v2 1/2] Bluetooth: btusb: support link statistics
 telemetry events
Thread-Index: AQHXMDkI5/5zbm3ARU65GGGrVcllrKqzANEAgEvq1TA=
Date:   Tue, 1 Jun 2021 05:22:03 +0000
Message-ID: <SJ0PR11MB4863F224843A1F8D627CDF88D83E9@SJ0PR11MB4863.namprd11.prod.outlook.com>
References: <20210413074521.264802-1-josephsih@chromium.org>
 <CABBYNZKv2fdOR2GxvNMiTFByzB4m1Ljbb-X-Wxeyqmyt=x6S8w@mail.gmail.com>
In-Reply-To: <CABBYNZKv2fdOR2GxvNMiTFByzB4m1Ljbb-X-Wxeyqmyt=x6S8w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2401:4900:33bc:5de9:952f:976c:eadd:d7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2719bfb6-e466-4548-75aa-08d924bd30cd
x-ms-traffictypediagnostic: BYAPR11MB3573:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB35739748DCC2DBE5CC007A0DD83E9@BYAPR11MB3573.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PH3po1NMax9yxrPUflQfZ0vRA1j+lj8GN3AaUM0spItG68gSV7UfZuhBW9D6gz8ugFRDlZuZ/PR+rc3dvaWoExPRvJyde3Ja0YX13w2LOHpOa+gc/IcCePQ1bb9WWeuYg0kj3K90bb0gEg1xU8FpSqYBrVKTN/My6YNsVUq3PfhjHSUfgN26Bricuz9iY0MZ/NOBfxWFK1LcKv0W0ZTlrSjmlUFuSpvdpzf9SclMyNRCfCf9oCaLjQwvaCOcAT9Mv0EV5qyurmxyKD99hcinM6GHuSoCzLPz+VLXwubU6aSZ2kKK1UVyPzD76wNxYlQEhd3CNvP8x3ja8ydxBEi1hWkIpuTtCWU/OEmXElkC520E34MYK2d/csewINLEdVTVa4wlIkwMw2L0Ga9pE65ilk2KB9Ep13TJ1psjqG/9+vq7l+ZpYa55Aio8xl9y4jr/S96tzAKUpTjksCVI/lsJOkCADOT7kvMCXmL+oh23psLUsY0XP7Zx7MlkFcwAVFA0cNTJWPGvDI1S1wP8N/tlAjG4MLCp5NaB2JQ2FjL/tkDmL3dI0BN50w4aYdhN3aoCGNaMPWbI7AUZFbI6cz4uMHA6MDs6kOt6+md65aqJVe0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4863.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(346002)(366004)(396003)(478600001)(38100700002)(4326008)(122000001)(86362001)(110136005)(5660300002)(54906003)(7696005)(33656002)(64756008)(66446008)(316002)(66556008)(76116006)(9686003)(52536014)(71200400001)(6506007)(66476007)(186003)(53546011)(8936002)(8676002)(55016002)(66946007)(2906002)(83380400001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Ri9jNTFsVEgwb0dWRGhEQlFZWHRoOE1KbUlwRi85eExheElHLzJRSjJXdmRM?=
 =?utf-8?B?L2dBc1J4Y0FaUmZWK3ZTZ1Jvb0tPSTlBb0JKc2xGZTdLRU9jQmdmZ1dXVkdt?=
 =?utf-8?B?OVhlYldJa2hKK1NNZ2FiNnhpU1dsVnp0NjIxZDVQVVgveUgyRytPd3JERkpp?=
 =?utf-8?B?VmFuVEdKREN6SHJpTmxVbVBDTlZWS21Fa0xSNldZVk1rczM1c2VBNmY0d2ZN?=
 =?utf-8?B?Z3hWLytzRi8yeTEycDdhVHFpR2I4YnhYTHUxK1lya2VLVHk0NGh4WmF2azFI?=
 =?utf-8?B?NWVhQ2tRNmNGYWpRU2cxVlRXbUNBRDRSTXJVYnE1bDhnMWM0R0dDMkZoei9J?=
 =?utf-8?B?S2h5cjBJK0gyM3lEbVRQczVBTzgwZmEzT3kxdUZhRzBvZjg0YlZnVjgyd0l1?=
 =?utf-8?B?ODhkNUF3LytqeWpzYjZSelB4eUlHY1IyZTNWZDJENGZxbGpqM3dpN0NRNXh6?=
 =?utf-8?B?aEo4YnJJS2NIMnhxS09iUzYzaXZRZTZ6MDNkUlQzWW9zSHg5SkZPUnU0bUNE?=
 =?utf-8?B?REJxaG9QNmxtdXZGMzZBU2tPZXF4TWVCUjNna3laWnZlazVBdlFXMzhZZ3FE?=
 =?utf-8?B?RkFFWGVpdUdSRklIbjNCbVJTUDU2cEUrcy9DSlVIR05HMk1uemVqUXFYbmRj?=
 =?utf-8?B?ZmRvVE52M3k1UXJQSnFlaXNEdmNtdXZSK0tpSDI5eFIrVVRVK1FhTGFZMDFj?=
 =?utf-8?B?Rzh4cGczZmVySXV6SDFsTm52TnlRclZpaFRNSTNGZUN4OEU5YWVKZThadU5O?=
 =?utf-8?B?eXlGazVESG9DL0EvS3Y1REZud3E0WFM2d0lVNXFIZUFlbDJjQXd0OXBvNStz?=
 =?utf-8?B?NW1aVWNsa090SDdwUEFxWis4OHhuSEM0TzZlcTZuVWpUWll6bFM1akJOYmth?=
 =?utf-8?B?MDNsK0k4QTZqSXdzcTNTa1BxMzRxV3BHU0tjTFF0NU0xZlF1eXZYb0FMcWRI?=
 =?utf-8?B?WEN3Z21vTkJRYlQwVGkwMHcwci9vbUZGREE0emN3bXFLZUg5SmFXL2NRR040?=
 =?utf-8?B?ZXB2b1RCT05sa05XT0lXdXMrdmFoS0hFbGhqdS94NWoydzdwQ0VLZ0RSMDFF?=
 =?utf-8?B?bGVyZjJrT3lIYkJkOG5TcDBhQWh2YnBkcXkyOStIV0NnK1ZoQ0ZtKzFQLzBv?=
 =?utf-8?B?SmRYdHdzWnFPNy80T3FRMzB0elVscEl3d29VS3Z5eHVVUThaRG9mQ0c3K1hi?=
 =?utf-8?B?Zy8yRGxjY09rZkpmNkc3QWEzY1ZnclV4bmZtbzJIM2VRblFIWW5nWDZZR2hJ?=
 =?utf-8?B?MnNEN0laTzF3blllTElxQ241bmtQb0VGU1VLeHZkL2d5R3BlMnBRRFlDMTFI?=
 =?utf-8?B?MFZEeDJlQUh2c3V2ZVZqRHliN0dBT1Jseld6YTN0ckZYV2tiVXZzZngvNkxq?=
 =?utf-8?B?Yjc5OGNQeTVIKzM3eU0xOFZYc0tob3BUMTBJcGNGdUQ0QkkrcUY3d0dPdU90?=
 =?utf-8?B?blBicnE1MFBrK1VXWVgrTzRTSHpnZVZnek1LZ1REOVQ3aUpyNUJ4ajBPcHBB?=
 =?utf-8?B?SUJmaGF1V2dOTEhUaFVHRkFIYmVtdURsWDRCRkd4bFM4MVVqeUhhVzNZd1RQ?=
 =?utf-8?B?VGxDRFg1STdDaTM4RG9LejdTNDhNL3hTMCs2V09FQWVFbmRrR20rOVIzNW5a?=
 =?utf-8?B?NXNXRlBaS2IrVEwycklSZ3dCeE5tbkFrWVBJUDVnWHJmckM3OHZUazV1NVVz?=
 =?utf-8?B?bkc0TkR2SXU1bmk3eUZqT1NsR0xFL3BnYlFIUUFubTJ1VWRTTzBpS29KYWZH?=
 =?utf-8?B?WXhPcE1YaUZ3TlZ2cGZjYVJDT1dGTVNvVWlYbmRTQXpBTFhyT0hMdVF4Ymg1?=
 =?utf-8?B?clAyLzNGN2E3a0c3VlNVWGJpcVZJM2U3TXR5aVV6QUVOZnpXU1JKSDJBSU9G?=
 =?utf-8?Q?uKJR3Dr/mMqAP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4863.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2719bfb6-e466-4548-75aa-08d924bd30cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 05:22:03.5119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLFQ9aJ9zWafNQ2AApBLj6w/D/LTvYqo38ETTFe/QPOaTtAjN4hMRM4KW+7C8pCOcDG5QfrUu1NCTAfFVD9rSvIr6urhVmvpo25IjX5kyC/pXmEtDN7nG+QBYe/joWN/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3573
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrIGFuZCBzb3JyeSBmb3IgdGhlIGRl
bGF5IGluIHJlc3BvbnNlLg0KDQo+IEhpIEpvc2VwaCwNCj4gDQo+IE9uIFR1ZSwgQXByIDEzLCAy
MDIxIGF0IDEyOjQ1IEFNIEpvc2VwaCBId2FuZyA8am9zZXBoc2loQGNocm9taXVtLm9yZz4NCj4g
d3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBDaGV0aGFuIFQgTiA8Y2hldGhhbi50dW1rdXIubmFyYXlh
bkBpbnRlbC5jb20+DQo+ID4NCj4gPiBUaGlzIHBhdGNoIHN1cHBvcnRzIHRoZSBsaW5rIHN0YXRp
c3RpY3MgdGVsZW1ldHJ5IGV2ZW50cyBmb3IgSW50ZWwNCj4gPiBjb250cm9sbGVycw0KPiA+DQo+
ID4gVG8gYXZvaWQgdGhlIG92ZXJoZWFkLCB0aGlzIGRlYnVnIGZlYXR1cmUgaXMgZGlzYWJsZWQg
YnkgZGVmYXVsdC4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBNaWFvLWNoZW4gQ2hvdSA8bWNjaG91
QGNocm9taXVtLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGV0aGFuIFQgTiA8Y2hldGhhbi50
dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2lyYW4gSyA8a2ly
YW4ua0BpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9zZXBoIEh3YW5nIDxqb3NlcGhz
aWhAY2hyb21pdW0ub3JnPg0KPiA+IC0tLQ0KPiA+DQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiAt
IHRha2UgY2FyZSBvZiBpbnRlbF9uZXdnZW4gYXMgd2VsbCBhcyBpbnRlbF9uZXcNCj4gPiAtIGZp
eCB0aGUgbG9uZy1saW5lIGlzc3VlDQo+ID4NCj4gPiAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRl
bC5jIHwgMjAgKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgZHJpdmVycy9ibHVldG9vdGgvYnR1
c2IuYyAgIHwgMTggLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTkg
aW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ibHVldG9vdGgvYnRpbnRlbC5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+
ID4gaW5kZXggZTQ0YjY5OTNjZjkxLi5kZTFkYmRjMDFlNWEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRp
bnRlbC5jDQo+ID4gQEAgLTEyNDgsOCArMTI0OCwxMCBAQA0KPiBFWFBPUlRfU1lNQk9MX0dQTChi
dGludGVsX3JlYWRfZGVidWdfZmVhdHVyZXMpOw0KPiA+ICBpbnQgYnRpbnRlbF9zZXRfZGVidWdf
ZmVhdHVyZXMoc3RydWN0IGhjaV9kZXYgKmhkZXYsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbnN0IHN0cnVjdCBpbnRlbF9kZWJ1Z19mZWF0dXJlcw0KPiA+ICpmZWF0dXJl
cykgIHsNCj4gPiAtICAgICAgIHU4IG1hc2tbMTFdID0geyAweDBhLCAweDkyLCAweDAyLCAweDA3
LCAweDAwLCAweDAwLCAweDAwLCAweDAwLA0KPiA+ICsgICAgICAgdTggbWFza1sxMV0gPSB7IDB4
MGEsIDB4OTIsIDB4MDIsIDB4N2YsIDB4MDAsIDB4MDAsIDB4MDAsDQo+ID4gKyAweDAwLA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDAsIDB4MDAsIDB4MDAgfTsNCj4gPiArICAgICAg
IHU4IHBlcmlvZFs1XSA9IHsgMHgwNCwgMHg5MSwgMHgwMiwgMHgwMSwgMHgwMCB9Ow0KPiA+ICsg
ICAgICAgdTggdHJhY2VfZW5hYmxlID0gMHgwMjsNCj4gPiAgICAgICAgIHN0cnVjdCBza19idWZm
ICpza2I7DQo+IA0KPiBJbnN0ZWFkIG9mIHVzaW5nIGEgYnl0ZSBhcnJheSBhbmQgY3VzdG8gb3Bj
b2RlIEkgd291bGQgcmVjb21tZW5kIHdlIHN0YXJ0DQo+IGFkZGluZyBwcm9wZXIgZGVmaW5lcyBm
b3IgSW50ZWwgdmVuZG9yIG9wY29kZXMgd2l0aCBzdHJ1Y3RzIGZvciB0aGVtLCBzaW1pbGFyDQo+
IG9wY29kZXMgYW5kIHN0cnVjdHMgYXJlIGFsc28gdmVyeSB1c2VmdWwgZm9yIGFkZGluZyBzdXBw
b3J0IGZvciBidG1vbiwgaW4gZmFjdCBJDQo+IHdvdWxkIHN0YXJ0IHdpdGggYnRtb24gZmlyc3Qg
YW5kIG9ubHkgd2hlbiB3ZSBoYXZlIHByb3BlciBkZWNvZGluZyBzdXBwb3J0DQo+IHN0YXJ0IGNo
YW5naW5nIHRoZSBrZXJuZWwgcGFydHMgc28geW91IGNhbiBhY3R1YWxseSBhZGQgYnRtb24gb3V0
cHV0IHRvIHRoZQ0KPiBwYXRjaCBkZXNjcmlwdGlvbiBoZXJlLg0KDQpBcyBvZiBub3cgSSBkb24n
dCBzZWUgYW55IG9mIHRoZSBWUyBjb21tYW5kcyBoYXZlIGJlZW4gZGVmaW5lZCBhcyBwZXIgeW91
ciBzdWdnZXN0aW9uLiBIb3dldmVyIHVwY29taW5nIHBhdGNoZXMgb2YgYnRtb24gdG9vbCBzaGFs
bCBoYXZlIHRoZSBkZWNvZGluZyBvZiB0aGUgY29tbWFuZHMgYW5kIGV2ZW50cyBmb3IgZGVidWcg
cHVycG9zZSBhcyBwZXIgeW91ciByZWNvbW1lbmRhdGlvbi4gDQpBbmQgY29tcGxldGVseSBhYmlk
ZSB0byB0aGUgR1BMIGxpY2Vuc2luZyB0ZXJtcyBhbmQgb3BlbiBmb3IgYW55b25lIHRvIG1vZGlm
eSB0aGVzZSBwYXRjaGVzIGxhdGVyLiBJIHNoYWxsIHJlYmFzZWQgdGhlc2UgcGF0Y2hlczsgcmUt
c2VuZCB0aGVtIGFnYWluLg0KPiANCj4gPiAgICAgICAgIGlmICghZmVhdHVyZXMpDQo+ID4gQEAg
LTEyNjYsOCArMTI2OCwyNCBAQCBpbnQgYnRpbnRlbF9zZXRfZGVidWdfZmVhdHVyZXMoc3RydWN0
IGhjaV9kZXYNCj4gKmhkZXYsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgUFRSX0VS
Uihza2IpKTsNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoc2tiKTsNCj4gPiAg
ICAgICAgIH0NCj4gPiArICAgICAgIGtmcmVlX3NrYihza2IpOw0KPiA+ICsNCj4gPiArICAgICAg
IHNrYiA9IF9faGNpX2NtZF9zeW5jKGhkZXYsIDB4ZmM4YiwgNSwgcGVyaW9kLCBIQ0lfSU5JVF9U
SU1FT1VUKTsNCj4gPiArICAgICAgIGlmIChJU19FUlIoc2tiKSkgew0KPiA+ICsgICAgICAgICAg
ICAgICBidF9kZXZfZXJyKGhkZXYsICJTZXR0aW5nIHBlcmlvZGljaXR5IGZvciBsaW5rIHN0YXRp
c3RpY3MgdHJhY2VzIGZhaWxlZA0KPiAoJWxkKSIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgUFRSX0VSUihza2IpKTsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIo
c2tiKTsNCj4gPiArICAgICAgIH0NCj4gPiArICAgICAgIGtmcmVlX3NrYihza2IpOw0KPiA+DQo+
ID4gKyAgICAgICBza2IgPSBfX2hjaV9jbWRfc3luYyhoZGV2LCAweGZjYTEsIDEsICZ0cmFjZV9l
bmFibGUsDQo+IEhDSV9JTklUX1RJTUVPVVQpOw0KPiA+ICsgICAgICAgaWYgKElTX0VSUihza2Ip
KSB7DQo+ID4gKyAgICAgICAgICAgICAgIGJ0X2Rldl9lcnIoaGRldiwgIkVuYWJsZSB0cmFjaW5n
IG9mIGxpbmsgc3RhdGlzdGljcyBldmVudHMgZmFpbGVkICglbGQpIiwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICBQVFJfRVJSKHNrYikpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1
cm4gUFRSX0VSUihza2IpOw0KPiA+ICsgICAgICAgfQ0KPiA+ICAgICAgICAga2ZyZWVfc2tiKHNr
Yik7DQo+ID4gKw0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiAgRVhQT1JUX1NZ
TUJPTF9HUEwoYnRpbnRlbF9zZXRfZGVidWdfZmVhdHVyZXMpOw0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2JsdWV0b290aC9idHVzYi5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0KPiA+
IGluZGV4IDE5MmNiOGMxOTFiYy4uZjI5OTQ2ZjE1ZjU5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvYmx1ZXRvb3RoL2J0dXNiLmMNCj4gPiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5j
DQo+ID4gQEAgLTI4MTEsNyArMjgxMSw2IEBAIHN0YXRpYyBpbnQgYnR1c2Jfc2V0dXBfaW50ZWxf
bmV3KHN0cnVjdCBoY2lfZGV2DQo+ICpoZGV2KQ0KPiA+ICAgICAgICAgdTMyIGJvb3RfcGFyYW07
DQo+ID4gICAgICAgICBjaGFyIGRkY25hbWVbNjRdOw0KPiA+ICAgICAgICAgaW50IGVycjsNCj4g
PiAtICAgICAgIHN0cnVjdCBpbnRlbF9kZWJ1Z19mZWF0dXJlcyBmZWF0dXJlczsNCj4gPg0KPiA+
ICAgICAgICAgQlRfREJHKCIlcyIsIGhkZXYtPm5hbWUpOw0KPiA+DQo+ID4gQEAgLTI4NjUsMTQg
KzI4NjQsNiBAQCBzdGF0aWMgaW50IGJ0dXNiX3NldHVwX2ludGVsX25ldyhzdHJ1Y3QgaGNpX2Rl
dg0KPiAqaGRldikNCj4gPiAgICAgICAgICAgICAgICAgYnRpbnRlbF9sb2FkX2RkY19jb25maWco
aGRldiwgZGRjbmFtZSk7DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAtICAgICAgIC8qIFJlYWQg
dGhlIEludGVsIHN1cHBvcnRlZCBmZWF0dXJlcyBhbmQgaWYgbmV3IGV4Y2VwdGlvbiBmb3JtYXRz
DQo+ID4gLSAgICAgICAgKiBzdXBwb3J0ZWQsIG5lZWQgdG8gbG9hZCB0aGUgYWRkaXRpb25hbCBE
REMgY29uZmlnIHRvIGVuYWJsZS4NCj4gPiAtICAgICAgICAqLw0KPiA+IC0gICAgICAgYnRpbnRl
bF9yZWFkX2RlYnVnX2ZlYXR1cmVzKGhkZXYsICZmZWF0dXJlcyk7DQo+ID4gLQ0KPiA+IC0gICAg
ICAgLyogU2V0IEREQyBtYXNrIGZvciBhdmFpbGFibGUgZGVidWcgZmVhdHVyZXMgKi8NCj4gPiAt
ICAgICAgIGJ0aW50ZWxfc2V0X2RlYnVnX2ZlYXR1cmVzKGhkZXYsICZmZWF0dXJlcyk7DQo+ID4g
LQ0KPiA+ICAgICAgICAgLyogUmVhZCB0aGUgSW50ZWwgdmVyc2lvbiBpbmZvcm1hdGlvbiBhZnRl
ciBsb2FkaW5nIHRoZSBGVyAgKi8NCj4gPiAgICAgICAgIGVyciA9IGJ0aW50ZWxfcmVhZF92ZXJz
aW9uKGhkZXYsICZ2ZXIpOw0KPiA+ICAgICAgICAgaWYgKGVycikNCj4gPiBAQCAtMjkxMSw3ICsy
OTAyLDYgQEAgc3RhdGljIGludCBidHVzYl9zZXR1cF9pbnRlbF9uZXdnZW4oc3RydWN0IGhjaV9k
ZXYNCj4gKmhkZXYpDQo+ID4gICAgICAgICB1MzIgYm9vdF9wYXJhbTsNCj4gPiAgICAgICAgIGNo
YXIgZGRjbmFtZVs2NF07DQo+ID4gICAgICAgICBpbnQgZXJyOw0KPiA+IC0gICAgICAgc3RydWN0
IGludGVsX2RlYnVnX2ZlYXR1cmVzIGZlYXR1cmVzOw0KPiA+ICAgICAgICAgc3RydWN0IGludGVs
X3ZlcnNpb25fdGx2IHZlcnNpb247DQo+ID4NCj4gPiAgICAgICAgIGJ0X2Rldl9kYmcoaGRldiwg
IiIpOw0KPiA+IEBAIC0yOTYxLDE0ICsyOTUxLDYgQEAgc3RhdGljIGludCBidHVzYl9zZXR1cF9p
bnRlbF9uZXdnZW4oc3RydWN0IGhjaV9kZXYNCj4gKmhkZXYpDQo+ID4gICAgICAgICAgKi8NCj4g
PiAgICAgICAgIGJ0aW50ZWxfbG9hZF9kZGNfY29uZmlnKGhkZXYsIGRkY25hbWUpOw0KPiA+DQo+
ID4gLSAgICAgICAvKiBSZWFkIHRoZSBJbnRlbCBzdXBwb3J0ZWQgZmVhdHVyZXMgYW5kIGlmIG5l
dyBleGNlcHRpb24gZm9ybWF0cw0KPiA+IC0gICAgICAgICogc3VwcG9ydGVkLCBuZWVkIHRvIGxv
YWQgdGhlIGFkZGl0aW9uYWwgRERDIGNvbmZpZyB0byBlbmFibGUuDQo+ID4gLSAgICAgICAgKi8N
Cj4gPiAtICAgICAgIGJ0aW50ZWxfcmVhZF9kZWJ1Z19mZWF0dXJlcyhoZGV2LCAmZmVhdHVyZXMp
Ow0KPiA+IC0NCj4gPiAtICAgICAgIC8qIFNldCBEREMgbWFzayBmb3IgYXZhaWxhYmxlIGRlYnVn
IGZlYXR1cmVzICovDQo+ID4gLSAgICAgICBidGludGVsX3NldF9kZWJ1Z19mZWF0dXJlcyhoZGV2
LCAmZmVhdHVyZXMpOw0KPiA+IC0NCj4gPiAgICAgICAgIC8qIFJlYWQgdGhlIEludGVsIHZlcnNp
b24gaW5mb3JtYXRpb24gYWZ0ZXIgbG9hZGluZyB0aGUgRlcgICovDQo+ID4gICAgICAgICBlcnIg
PSBidGludGVsX3JlYWRfdmVyc2lvbl90bHYoaGRldiwgJnZlcnNpb24pOw0KPiA+ICAgICAgICAg
aWYgKGVycikNCj4gPiAtLQ0KPiA+IDIuMzEuMS4yOTUuZzllYTQ1YjYxYjgtZ29vZw0KPiA+DQo+
IA0KPiANCj4gLS0NCj4gTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0K
