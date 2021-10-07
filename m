Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E6AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Oct 2021 06:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463FF6105A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Oct 2021 06:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhJGGIQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Oct 2021 02:08:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:10052 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231661AbhJGGIP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Oct 2021 02:08:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="223571272"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="223571272"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 23:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="560457962"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Oct 2021 23:06:22 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 6 Oct 2021 23:06:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 6 Oct 2021 23:06:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 6 Oct 2021 23:06:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWGFZzbYkwRyvKpp3enp89TY7mBqLKTjXkytDJ8kWyRRljCukPdouEWHZ5hdoMk9ZJeUo2RW93A4yiNakwv0NVeYDKgHj+pRKOJS7NhsYsXxBanZ7jk8KnsfQ7vx/uafCvmH7m09R8pHfw4DXQznhbo8XANy8mqBhNxzsnKniTYsVKsgOXkOyb8Xi7Ztr1hZ04z2qjPAukMB1TiDsR7m2r3fGWT2Tl3ARWIy4PsVe013YO4Uez+JfuMRUgOv1Zz9SSf4t0BMAXyLw+Vv742BFwciRYaIPiefHp3GcjYE0B0YLdipsAIs+XqGU9ErwhJiggqlXKksnn4dV06T86jFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnlyDBGwWXVl8GkY7lSFqm4nqHd54yZwjt8vHSmQIJ4=;
 b=cZLqFbNh6cYE1AJGt6q2W/Z2miShpCiPDpiWTeRNXz4vAsvSSCSSTcrASgO8qNHjtHrUf2c34NnsuQgFLS7RnCg9D2IHSG3JMgVZ09WHQUQ0LK1ho0JDdz7BjzF4lmYWwD09YskHzqxLyRzc0yGRqxznk8nKWo8zSv1Apt4TSai8GXYE6DR0oJmWgWedrvAEiUg0pvMZnyvmVaIfx8XRhgixLl422vqyjd+ILR0NQ6abC7VnxKradGsbRV3+hhatI/YRS4zW0N1U/UJz1aza3tXpVrGWvjLoFGvRx3wICJ0uP7wAWZHkB79aBVN7YCcpkeq/NMYmKWHy1qDq1EnyvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnlyDBGwWXVl8GkY7lSFqm4nqHd54yZwjt8vHSmQIJ4=;
 b=c02DV5cRbHWhKtNpuGyGFKNSSbooO+D3H4An+xHhEHyMEU6LFzXMfDuYi9MxdtbgYpA1OO4xVXDl7ai+SBikXa4RV57I4hhYqph2nlScdHP3/0cjA5ktAEaVDZ6M05MI7bH/rjZT+f8cub4NHJf+s7hbe9oXdvUDVaxiDgu92LI=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5670.namprd11.prod.outlook.com (2603:10b6:8:37::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18; Thu, 7 Oct 2021 06:06:21 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::243e:658d:ac2e:4cb8]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::243e:658d:ac2e:4cb8%7]) with mapi id 15.20.4566.022; Thu, 7 Oct 2021
 06:06:21 +0000
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
Thread-Index: AQHXuaBi4PrY9W41v0ul9TVX3EMhsqvFq4mAgACWNICAAM0YAA==
Date:   Thu, 7 Oct 2021 06:06:21 +0000
Message-ID: <DM8PR11MB557322FB90F730BDE853E742F5B19@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20211005042613.9946-1-kiran.k@intel.com>
 <79B0A1CF-17D0-473C-A321-39E1BC291A89@holtmann.org>
 <CABBYNZL9f1j6sEcNm6B9ONg6yV=Pt=msuOd3Urb-0d-5vmm7qw@mail.gmail.com>
In-Reply-To: <CABBYNZL9f1j6sEcNm6B9ONg6yV=Pt=msuOd3Urb-0d-5vmm7qw@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 37ab5904-aa4c-49b3-faca-08d9895895b5
x-ms-traffictypediagnostic: DM8PR11MB5670:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB567063C4AC622210D84DDD85F5B19@DM8PR11MB5670.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9m0Q8vHm2XBnKBQa8LBPyOzuSHp7fPsXq+zL+SHykbFgj6Xvc/JE2Eg9cEpHj+PerPqx2L9dhEFYJsY2np2wrzHYoAdDu6KQgJIjItQ5bGfwRUM5OIC+ByiaXmma6j9YKsNLbYIk7L/nS9Hs53Piqn0N2tQxjogNBJ+IdFHfYQpLbIiM/hdUxMqGIg5g5dXXUYddHoY0vU0egP0282bvXElcKGKY7202e5ntKKq7OAxEUDzUUB8PqBXDAdXh0DCzaiQkBDBqT/gtHIb3Sj6tbK1URZGmd9u7476SU7YhJdyWjTWC9AGM7ngpzf8h7gT6rIB5bfo+uEdIQvf944izY0B2xiOLbeJ23Zk/v2LWYnGy/HLKClXxrgFyWc82jDslvGjtRMejnXsmrOq7zL/nfsNzdZAiy4/FqAZDyVHTqSxyeDMdhzPUjvaeaXejie2CzxMW2AmbWxUAk+NcMp+xFjC5WDHxLkshikqztOq1fKUkjtiReWoDpwpBpIi/N9tU60WsWePFdwKAsjB5eGE9y4+bSveI+uPRynB0JnEkuC2/MfJ/uJwBvhWo/qb7bzs/DVjwWa4qxaehC6WpkqlOs4YcVva9FHAKpHSw0vOm9hQd7zNWROzT8pz37t/UAOrx+H05ZdsnmNatCvCU7U8vH61SyS+nm9SHcPMTYPLVObTUHijgTGFpY1tCsoFgqqpYDkqIeWOWdAHkXv7kM6yFkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(8936002)(316002)(54906003)(110136005)(5660300002)(2906002)(55016002)(9686003)(52536014)(33656002)(86362001)(186003)(508600001)(26005)(107886003)(71200400001)(66946007)(122000001)(38100700002)(64756008)(66476007)(66556008)(66446008)(76116006)(83380400001)(8676002)(38070700005)(53546011)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVFNWE0yc3h0VFlZeklTZjBHamxvZEtDOXdoZGp5M2hwNHN1ZWpGLzFRQmxk?=
 =?utf-8?B?a2NvaDJkSGR0SjI2OXg5czdoK2hFeU9GcVBQekFxUFNzZExmUWJLdzd0aFY3?=
 =?utf-8?B?d1Q0cTdBMldlR0d6Z1NETzY5SytKMEhTZUpxYUJJSnJnWUMwYlMrT3ZtVnVD?=
 =?utf-8?B?YXZuRWZoSm1tSWE0UFEvZ2xBOHlveFVNcTdPRG5WN0VSaWJCcFJXMktwcjdJ?=
 =?utf-8?B?bHV2WC9PVXBxS2dZTjN3dUdYbFVaaHlYUldMYnY1Y0hINWp3TEtqeEJGblQ0?=
 =?utf-8?B?YUlEUXhvcVlaeG9la09idndFVUgxZWFxZmQ5ZlpQcnZRTnl4TUd1bFhHU0Z5?=
 =?utf-8?B?MFg3M2huZUVNMkxkM3MxZUUxRlY4dnFDZVV4QzZFWkl6bjdkTFlVVi9UVmxJ?=
 =?utf-8?B?SnpaN3RqZ29sc21iZkJWU3FXdEliVWFYQVN4REp3dzgwcTNWYmpyZGRUdXlC?=
 =?utf-8?B?UmNtdEc3YkhhM08vVlAxUzVEWEVsd2s4SUtQM2twUmw5RHFDRDAycktKaTV4?=
 =?utf-8?B?cUh3TWtIZzZ4ZlptMSt6VWVYZExIV2k5T0MyV3JpcDBRaUxNbElORDdhR1lu?=
 =?utf-8?B?akYrMXJITWYrZW00QjdqNkVvQVRwVWpRLzA5dFBldHFFcXJmazhGVTNQWndk?=
 =?utf-8?B?dkZNNTlUb1dQd1JwdVlIRFE1dXp6Q1FDY05hVTdNWlBoSkExNWV3NXp1MnhR?=
 =?utf-8?B?UjBOUnl2eFduNWlPODc5YUxyb25XbUpubkJ4SWtWOE9yMm1RVWJWTFFoc0d2?=
 =?utf-8?B?TTJ5SnkvMXY3TDRrYzRhNnFGZmtsNjRBUFRXdHcvVU1zSGN3U1l5aE91S1Zx?=
 =?utf-8?B?NDFVMDNzS2RmTmJydFRWN0VaQi80amRxOWZQSXBFcm0rNFFVQm44blUrS2NV?=
 =?utf-8?B?bDNYeHZlSXRhWm4rQjJ6ak1yRmI1N3J4MEM2NDZNM1Z0KzlPa2syNW1SVHB3?=
 =?utf-8?B?TkJhZTJLNFc3N1FkVElDZk9lc0l4TEpmRVpNeWJpN0R5UFRQZnBhRzhyRjFS?=
 =?utf-8?B?WGZOVXp6OXFpblgrbFY2UXFOZndrRjhNYi9SbDJRVFBPQlE1c25PMGpjY1BL?=
 =?utf-8?B?bmlDdUo3bktQTThuMUh1OThzejA0N3h0MXVWVmFwbnNZUVpaZktraWhMWEFW?=
 =?utf-8?B?UDlibE5hZnNKeGlzZEZ4am1sYWZnVld3VEZYSHJ3Z0NaamtYSmx3TS9GNGh4?=
 =?utf-8?B?QlNOaU0yT3o5ekI0VDBKNXlrNUtSTWdBT2F0eUppWGhPdnF4V0kyblpZMVAw?=
 =?utf-8?B?VTlPb21YVVkxRlF0MDlyNEJkKzR5Y1VRdzR0NmtzVExSay91SmFPNW9rR1J2?=
 =?utf-8?B?WS9HMExUc2xhditCNHpjdjFjSHl4L2hpd2Fqdkh6TWUrMnA1bnR2cmdnQm9y?=
 =?utf-8?B?TGE3RThuWU5iY1ZmVk5MREtzdkZtZ3ZrR2l2S2hKNm9MQjFwUGZML00rRCtW?=
 =?utf-8?B?UTY3MGZnVTZTZEZxQ0loTGV4a2dHM09qQjdoOGlsMXJUcnhTOWNmSnc0NDZI?=
 =?utf-8?B?OC9EQm1PWlZMbVNjbFIrVWI1S0diM3dCRTlYakRMc1czUEFzRWdRTkl5STBw?=
 =?utf-8?B?TFFhRGJzaGIrbjk4b2RVZlNjdDhnQlg4M3B4WjJKbFFQeVo2ZG44NlZXTG8x?=
 =?utf-8?B?SmlLZVV5QlFEZlVVWG5PL2g0ZklpVU1iK2ozeDlERlVLQnQrdmEvVFlKdGJy?=
 =?utf-8?B?eG1JUzlNcDdzTGFiZloxeDZnOGpUMGdXM1ZhaTdLRE8zQlhaQmhZa3VaTEVS?=
 =?utf-8?Q?qr+as9FD2uBHgmh5MA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ab5904-aa4c-49b3-faca-08d9895895b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 06:06:21.0548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNPFvRjawE7S1ebUrjvCJ42ESWBjtMBXB2xcsBE70F+WPj7C0SqAinccsVAFOwnOlJIw+sOQBJlcW8FqFHl9ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5670
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLCBMdWl6LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXouZGVudHpAZ21haWwuY29tPg0KPiBTZW50OiBX
ZWRuZXNkYXksIE9jdG9iZXIgNiwgMjAyMSAxMToxOSBQTQ0KPiBUbzogTWFyY2VsIEhvbHRtYW5u
IDxtYXJjZWxAaG9sdG1hbm4ub3JnPg0KPiBDYzogSywgS2lyYW4gPGtpcmFuLmtAaW50ZWwuY29t
PjsgbGludXgtYmx1ZXRvb3RoIDxsaW51eC0NCj4gYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZz47
IFNyaXZhdHNhLCBSYXZpc2hhbmthcg0KPiA8cmF2aXNoYW5rYXIuc3JpdmF0c2FAaW50ZWwuY29t
PjsgVHVta3VyIE5hcmF5YW4sIENoZXRoYW4NCj4gPGNoZXRoYW4udHVta3VyLm5hcmF5YW5AaW50
ZWwuY29tPjsgQW4sIFRlZGQgPHRlZGQuYW5AaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYxXSBCbHVldG9vdGg6IGJ0aW50ZWw6IEZpeCBiZGFkZHJlc3MgY29tcGFyaXNvbiB3aXRo
DQo+IGdhcmJhZ2UgdmFsdWUNCj4gDQo+IEhpIE1hcmNlbCwNCj4gDQo+IE9uIFdlZCwgT2N0IDYs
IDIwMjEgYXQgMTo1MiBBTSBNYXJjZWwgSG9sdG1hbm4gPG1hcmNlbEBob2x0bWFubi5vcmc+DQo+
IHdyb3RlOg0KPiA+DQo+ID4gSGkgS2lyYW4sDQo+ID4NCj4gPiA+IEludGVsIFJlYWQgVmVyaXNp
b24oVExWKSBkYXRhIGlzIHBhcnNlZCBpbnRvIGEgbG9jYWwgc3RydWN0dXJlDQo+ID4gPiB2YXJp
YWJsZSBhbmQgaXQgY29udGFpbnMgYSBmaWVsZCBmb3IgYmQgYWRkcmVzcy4gQmQgYWRkcmVzcyBp
cw0KPiA+ID4gcmV0dXJuZWQgb25seSBpbiBib290bG9hZGVyIG1vZGUgYW5kIGhlbmNlIGJkIGFk
ZHJlc3MgaW4gVExWDQo+ID4gPiBzdHJ1Y3R1cmUgbmVlZHMgdG8gYmUgdmFsaWRhdGVkIG9ubHkg
aWYgY29udHJvbGxlciBpcyBwcmVzZW50IGluIGJvb3QgbG9hZGVyDQo+IG1vZGUuDQo+ID4gPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogS2lyYW4gSyA8a2lyYW4ua0BpbnRlbC5jb20+DQo+ID4gPiAt
LS0NCj4gPiA+IGRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyB8IDE5ICsrKysrKysrKysrLS0t
LS0tLS0NCj4gPiA+IDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9u
cygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVs
LmMNCj4gPiA+IGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jIGluZGV4IDkzNTliZmY0NzI5
Ni4uZDE3MDNjYzk5NzA1DQo+ID4gPiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRv
b3RoL2J0aW50ZWwuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+
ID4gPiBAQCAtMjA4MSwxNCArMjA4MSwxNiBAQCBzdGF0aWMgaW50DQo+IGJ0aW50ZWxfcHJlcGFy
ZV9md19kb3dubG9hZF90bHYoc3RydWN0IGhjaV9kZXYgKmhkZXYsDQo+ID4gPiAgICAgICBpZiAo
dmVyLT5pbWdfdHlwZSA9PSAweDAzKSB7DQo+ID4gPiAgICAgICAgICAgICAgIGJ0aW50ZWxfY2xl
YXJfZmxhZyhoZGV2LCBJTlRFTF9CT09UTE9BREVSKTsNCj4gPiA+ICAgICAgICAgICAgICAgYnRp
bnRlbF9jaGVja19iZGFkZHIoaGRldik7DQo+ID4gPiAtICAgICB9DQo+ID4gPiAtDQo+ID4gPiAt
ICAgICAvKiBJZiB0aGUgT1RQIGhhcyBubyB2YWxpZCBCbHVldG9vdGggZGV2aWNlIGFkZHJlc3Ms
IHRoZW4gdGhlcmUgd2lsbA0KPiA+ID4gLSAgICAgICogYWxzbyBiZSBubyB2YWxpZCBhZGRyZXNz
IGZvciB0aGUgb3BlcmF0aW9uYWwgZmlybXdhcmUuDQo+ID4gPiAtICAgICAgKi8NCj4gPiA+IC0g
ICAgIGlmICghYmFjbXAoJnZlci0+b3RwX2JkX2FkZHIsIEJEQUREUl9BTlkpKSB7DQo+ID4gPiAt
ICAgICAgICAgICAgIGJ0X2Rldl9pbmZvKGhkZXYsICJObyBkZXZpY2UgYWRkcmVzcyBjb25maWd1
cmVkIik7DQo+ID4gPiAtICAgICAgICAgICAgIHNldF9iaXQoSENJX1FVSVJLX0lOVkFMSURfQkRB
RERSLCAmaGRldi0+cXVpcmtzKTsNCj4gPiA+ICsgICAgIH0gZWxzZSB7DQo+ID4gPiArICAgICAg
ICAgICAgIC8qDQo+ID4gPiArICAgICAgICAgICAgICAqIENoZWNrIGZvciB2YWxpZCBiZCBhZGRy
ZXNzIGluIGJvb3QgbG9hZGVyIG1vZGUuIERldmljZQ0KPiA+ID4gKyAgICAgICAgICAgICAgKiB3
aWxsIGJlIG1hcmtlZCBhcyB1bmNvbmZpZ3VyZWQgaWYgZW1wdHkgYmQgYWRkcmVzcyBpcw0KPiA+
ID4gKyAgICAgICAgICAgICAgKiBmb3VuZC4NCj4gPiA+ICsgICAgICAgICAgICAgICovDQo+ID4g
PiArICAgICAgICAgICAgIGlmICghYmFjbXAoJnZlci0+b3RwX2JkX2FkZHIsIEJEQUREUl9BTlkp
KSB7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgYnRfZGV2X2luZm8oaGRldiwgIk5vIGRl
dmljZSBhZGRyZXNzIGNvbmZpZ3VyZWQiKTsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBz
ZXRfYml0KEhDSV9RVUlSS19JTlZBTElEX0JEQUREUiwgJmhkZXYtPnF1aXJrcyk7DQo+ID4gPiAr
ICAgICAgICAgICAgIH0NCj4gPiA+ICAgICAgIH0NCj4gPiA+DQo+ID4gPiAgICAgICBidGludGVs
X2dldF9md19uYW1lX3Rsdih2ZXIsIGZ3bmFtZSwgc2l6ZW9mKGZ3bmFtZSksICJzZmkiKTsNCj4g
PiA+IEBAIC0yNDY2LDYgKzI0NjgsNyBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfc2V0dXBfY29tYmlu
ZWQoc3RydWN0DQo+IGhjaV9kZXYgKmhkZXYpDQo+ID4gPiAgICAgICAgICAgICAgIGdvdG8gZXhp
dF9lcnJvcjsNCj4gPiA+ICAgICAgIH0NCj4gPiA+DQo+ID4gPiArICAgICBtZW1zZXQoJnZlcl90
bHYsIDAsIHNpemVvZih2ZXJfdGx2KSk7DQo+ID4NCj4gPiB0aGlzIGNoYW5nZSBpcyBub3QgZGVz
Y3JpYmVkIGluIHRoZSBjb21taXQgbWVzc2FnZS4gV2h5IGlzIHRoYXQgbm93IG91dCBvZg0KPiBh
IHN1ZGRlbiBuZWVkZWQ/DQo+IA0KPiBJIGd1ZXNzIHRoaXMgaXMganVzdCB0byBtYWtlIHN1cmUg
dGhlIHZlcl90bHYgaXMgaW5pdGlhbGl6ZWQgc28gaXRzIG90cF9iZF9hZGRyIGJlDQo+IHNldCB0
byBhbGwgemVyb3MgKEJEQUREUl9BTlkpIG90aGVyd2lzZSB0aGUgY29kZSBhYm92ZSBkb2Vzbid0
IHdvcmsgYXMgaXQNCj4gYXR0ZW1wdHMgdG8gY29tcGFyZSB0byBCREFERFJfQU5ZLg0KDQpZZXMu
IElmIG5vdCBtZW1zZXQsIHRoZW4gZ2FyYmFnZSB2YWx1ZSBpcyBjb21wYXJlZCBhZ2FpbnN0IEJE
QUREUl9BTlkuDQo+IA0KPiA+IFJlZ2FyZHMNCj4gPg0KPiA+IE1hcmNlbA0KPiA+DQo+IA0KPiAN
Cj4gLS0NCj4gTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0K
