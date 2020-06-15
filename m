Return-Path: <SRS0=u3xs=74=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95B9C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 22:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8308B2078E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 22:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="SOqA45kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgFOWZk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:25:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:59283 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgFOWZj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 18:25:39 -0400
IronPort-SDR: t1lrRxtbMXPMUEL/T+CrwZvFkjUu/3XRaSaCLSoY337ZcCmW1xdIsCt3RVHm6XGLSoQEguk3JZ
 Vcx5BcajJ/Zw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 15:25:39 -0700
IronPort-SDR: 5Voi4Vmkqkf7MtEmup0UbQ6Ul8un1TnTNWq9FOwTnqSfHdPteu7pJ5Z/LAqsRXb8KyeCLqDz3W
 tWoE2wMHNE3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,516,1583222400"; 
   d="scan'208";a="351510141"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2020 15:25:39 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jun 2020 15:25:38 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jun 2020 15:25:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 15 Jun 2020 15:25:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP3/HDTTkwRpXV3k+eC27KjbTHzFKDwpN52BaN65yTbD5H0ifQYfVQHjz0rQD03uNlwqQQ4ilboyjpHKs4PDbaBEgDVHWg1ZuzdwoOz69DpoXgJz/s4lfw27jEKbqx2Jq1Zbw9YcQuUntldHvFx00F07tueRzxrcPR0HWSRNct5Xx5RVgS4XiQ9bHMcAKgXep8da0NNouKg2grZUPgvZslKhCykE5UljBlSL4fej6fZOG1GtD/Ygs46BBfBbUzuMtr/cno9TRCCTJP8CZb0n+vO0rtZBc2LzddZxKnWPjLefji80Elluwx3cRLnl60f5P3qZaRc6/eLooWuugyBzcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THwsR+RAwI2spAOW8Y+TNnAPCJg0og5MjORXgJNXzGY=;
 b=M6lttRd5FEeVj9MsQ4xdvuNHuyD6j/GowkeCMRIjlA0LGzlFlpHXn5wepCEbKDDQ4qcWKOIUDcNOKGxD+GBMuy4+hWJ3cL6k/nOPWO6TwjgPlEFA4o9L7ghN2GbkI5ZB0IEcskSDU/T73K4Tm2oSR0Y8ERcKJ8JbFw50S7NYHj3etvE5N010xriBQJj8zZTFjQqHxopJmtBdB81v/5l9BWcaBwFZAdkbPvvbKt/L50Y2L0FR+rDXNoyObB9ETuI30L55efzvFsYRpWyYIWHg44DDSyUPY90d4r3NzFMFkSfrkQoYI911JCA0nh5kRNH6zT74nMmWJiuWldbyZQ+rsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THwsR+RAwI2spAOW8Y+TNnAPCJg0og5MjORXgJNXzGY=;
 b=SOqA45krLn9Eks/W+v07WLJrMkGqkAWyEo0pnArLndUM33vkk7vPAG1hu3R5KHW/BuqC3C0GEBkc9KY3bXHwRC43+x5zAzYFSFeWh0C3SCpfQ0Gl5/byMun4BQNhryPILhNtQL2nhQ0K5z1vwCnMBufYbFSzhkVPXX6viH06me8=
Received: from MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21)
 by MWHPR11MB1440.namprd11.prod.outlook.com (2603:10b6:301:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Mon, 15 Jun
 2020 22:25:37 +0000
Received: from MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::4de0:98c5:c41a:8b6]) by MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::4de0:98c5:c41a:8b6%8]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 22:25:36 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "Gix, Brian" <brian.gix@intel.com>,
        "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v3 5/5] mesh: Add "node is busy" check for Leave() &
 Attach()
Thread-Topic: [PATCH BlueZ v3 5/5] mesh: Add "node is busy" check for Leave()
 & Attach()
Thread-Index: AQHWP0o0q0Iw14gNPUOGZ7E8qEK80qjZXcaAgACAogCAAEtGgIAAH4SA
Date:   Mon, 15 Jun 2020 22:25:36 +0000
Message-ID: <8ffbba6a5ce2506fc1a6d5f4d38c9d53c0b119de.camel@intel.com>
References: <20200610171121.46910-1-inga.stotland@intel.com>
         <20200610171121.46910-6-inga.stotland@intel.com>
         <20200615082259.bpstucduyunyqvmt@mlowasrzechonek2133>
         <72efc0bd23669143a0c1b9749a6c523f1ea49f5f.camel@intel.com>
         <20200615203247.4zw2vhauuducewws@kynes>
In-Reply-To: <20200615203247.4zw2vhauuducewws@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 (3.36.3-1.fc32) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82f1d3cc-37bd-4070-6a52-08d8117b070c
x-ms-traffictypediagnostic: MWHPR11MB1440:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB14401EC61FE2DC25629EB716FB9C0@MWHPR11MB1440.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AQzeF+ko/iXzt24Fgl1ePce/kGS8/qHFXD9SPeSy3c8rVHDF9iQWz4TaYK6RbQc2h+kI68oF7kS0NHRWCUZbOot8fRQGyA7JThvdWu9WibTy8NqgC46gri7c65dL2QnOK3qQrG211rxV/mDtG/y88pDFGlEHvcoUmUz89aT6l501vA6lKYiMvu1eJ0qCAe3U8oCZew2dJlQXWDDfHGt057f1kBXb/9umckZJYa9jYZcdTArisx83yl1tslWi9RjMkmhY/Jc8/8Z8ynDLQ+ojcvjvm3x8Vt/yQiB+kHWrPQgk219ekOb5SE4EDOlWzwVasj7v494uEVbeDJnj7p8Qcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4556.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(376002)(136003)(39860400002)(396003)(8936002)(6512007)(66946007)(66476007)(91956017)(66556008)(76116006)(66446008)(8676002)(186003)(64756008)(4326008)(6506007)(6486002)(26005)(2906002)(86362001)(83380400001)(478600001)(71200400001)(110136005)(36756003)(5660300002)(2616005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qaA4eTH1NhfgNcZTBX9MXrKXL0Mq7xLJ4SgtnP7zr9xuz4nvVvbNHHeeKh8c2aDj3EueHwKoxNXKkCIrN4KeOdu0DuYXRjWnMDKeFit1VqksuxYeE4mNYluD+O8Y6hqZkr3b9h81FToAcc9TL/10qDueHUNCkl7uczmIjQdl7ajrVNJ7bqmW83C8GJE6mdnbkCp44zwoRea6BALt3ADIVdTMQG3n2RuO/Re+hqK326ROfppo5LrfEbwRiOd7Jz4RlplB1WVKPBGvGCatnHzflJ0mP1KFsV9GkNRXXXX4ZiOTpUXi7lGWJJi2CDUylai5mwhwESILndc9S4d11kuHpBBRJRMgDq3hRqdPSKJU72fC/oZZke+Fxdirg1OiffjNPPCyJ0wzt7PcPzuKZ+lMnlNhIxxIWmnuJ7AIaZkj0oEzpobsMJjvOrcmt38R+NDyeDFFc7fAg8YqPxxS8xruYYU+D3CEolRpvjkJcrwFsyE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60FF0F2DAAAD6047845325128785E0C2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f1d3cc-37bd-4070-6a52-08d8117b070c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 22:25:36.7036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BA+LY5CDOW9nlPBhKVBlq6GfOAkpHANDNKfOoQi+w/LINOGCImN8W/JuXK+YRT7ZpQTFOQvEeEQj1ZCXtrv5Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1440
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGFsLA0KDQpPbiBNb24sIDIwMjAtMDYtMTUgYXQgMjI6MzIgKzAyMDAsIG1pY2hhbC5s
b3dhcy1yemVjaG9uZWtAc2lsdmFpci5jb20NCndyb3RlOg0KPiBJbmdhLCBCcmlhbiwNCj4gDQo+
IE9uIDA2LzE1LCBHaXgsIEJyaWFuIHdyb3RlOg0KPiA+ID4gV2l0aCB0aGlzIHBhdGNoLCB0aGlz
IGNhbGwgc2VxdWVuY2UgZmFpbHMsIGJlY2F1c2Ugbm93IHdlJ3JlIHN1cHBvc2VkIHRvDQo+ID4g
PiBzZW5kIGEgKnJlcGx5KiB0byBKb2luQ29tcGxldGUgZmlyc3QsIGFuZCBvbmx5IHRoZW4gY2Fs
bCBBdHRhY2goKT8NCj4gPiANCj4gPiBBIGNvdXBsZSBtb250aHMgYWdvLCB3ZSBtYWRlIHRoZSBk
ZWNpc2lvbiAod2l0aCB5b3VyIGlucHV0LCBJIGJlbGlldmUpDQo+ID4gdGhhdCB3ZSBuZWVkZWQg
dG8gdXNlIEpvaW5Db21wbGV0ZSBvbiBldmVyeSBub2RlIGNyZWF0aW9uIChKb2luLA0KPiA+IElt
cG9ydCwgQ3JlYXRlKSwgdG8gZW5zdXJlIHRoYXQgdGhlIEFwcCBoYXMgdGhlIHRva2VuICguLi4p
DQo+IA0KPiBZZXMsIEkgcmVtZW1iZXIgdGhhdCBkaXNjdXNzaW9uLiBUaGUgcmF0aW9uYWxlIHdh
cyBhYmlsaXR5IHRvIGNhdGNoDQo+IGJ1Z3MgaW4gdGhlIGFwcGxpY2F0aW9uLCBhbmQgZ2V0IHJp
ZCBvZiBjcmVhdGVkLCBidXQgZWZmZWN0aXZlbHkNCj4gdW51c2FibGUgbm9kZXMuDQo+IA0KPiA+
IFRoaXMgY3JlYXRlcyAoLi4uKSB0aGUgdW5mb3J0dW5hdGUgc2l0dWF0aW9uIHJldmVhbGVkIGlu
IG9uZSBvZiB5b3VyDQo+ID4gdGVzdC1zdWl0ZSBjYXNlcyB3aGVyZSBpZiBMZWF2ZSgpIHdhcyBj
YWxsZWQgYmVmb3JlIHJldHVybmluZyB0aGUNCj4gPiBKb2luQ29tcGxldGUoKSBjYWxsLCB3ZSBT
ZWctRmF1bHRlZC4NCj4gDQo+IEluZGVlZCwgYWx0aG91Z2ggSSBkb24ndCB0aGluayBpdCdzIG5l
Y2Vzc2FyeSB0byBpbnRyb2R1Y2UgYSAiYnVzeSINCj4gc3RhdGUuLi4NCj4gDQo+IEluIGNhc2Ug
b2YgTGVhdmUoKSwgdGhpcyBjYWxsIHJlbW92ZXMgdGhlIG5vZGUgYW55d2F5LCBzbyB3aGF0IEkg
dGhpbmsNCj4gd291bGQgc3VmZmljZSBpcyB0byBjaGVjayB3aGV0aGVyIHRoZSBub2RlIHN0aWxs
IGV4aXN0cyB3aGVuDQo+IEpvaW5Db21wbGV0ZSByZXBseSBhcnJpdmVzLCB0byBhdm9pZCBmcmVl
aW5nIHRoZSBub2RlIHR3aWNlIChjYXVzaW5nDQo+IFNFR1YpLg0KPiANCj4gdm9pZCBub2RlX2Zp
bmFsaXplX25ld19ub2RlKHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHN0cnVjdCBtZXNoX2lvICpp
bykNCj4gew0KPiAJaWYgKCFub2RlKQ0KPiAJCXJldHVybjsNCj4gDQo+IAlpZiAoIWxfcXVldWVf
ZmluZChub2RlcywgbWF0Y2hfc2ltcGxlLCBMX1VJTlRfVE9fUFRSKG5vZGUpKSkNCj4gCQlyZXR1
cm47DQo+IA0KDQpJIGFtIGFmcmFpZCB0aGF0IHRoaXMga2luZCBvZiBjaGVjayBtYXkgbGVhZCB0
byBhIHJhY2UgY29uZGl0aW9uIChyYXJlLCBidXQgcG9zc2libGUpIHdoZW46DQogLSBhIHVuLWZp
bmFsaXplZCBub2RlIGhhcyBiZWVuIHJlbW92ZWQgdmlhIExlYXZlIGFuZA0KIC0gdGhlIGRhZW1v
biBzdGlsbCB3YWl0aW5nIGZvciBKb2luQ09tcGxldGUoKSByZXBseSBhbmQNCiAtIG1lYW53aGls
ZSBhbm90aGVyIG9uZSBoYXMgZWl0aGVyIGJlZW4gY3JlYXRlZCBvciBpbXBvcnRlZCByZXVzaW5n
IHRoZSBtZW1vcnkgYWxsb2NhdGlvbiAoZW50aXJlbHkgcG9zc2libGUpIGFuZCBoYXMgYmVlbiBh
dHRhY2hlZA0KIA0KU28gd2hlbiB0aGUgb3JpZ2luYWwgSm9pbkNvbXBsZXRlIHJldHVybnMgZWl0
aGVyIHZpYSB0aW1lb3V0L2Vycm9yL29rLHdlIG1heSB1bmludGVudGlvbmFsbHkgcmVtb3ZlIGRi
dXMgcmVzb3VyY2VzIG9mIGEgbmV3IG5vZGUgdGhhdCBoYXMgYmVlbiB2YWxpZGF0ZWQgYW5kIGF0
dGFjaGVkLg0KDQoNCj4gICAgIC8vIC4uLg0KPiB9DQo+IA0KPiBUaGlzIHdvdWxkIGFsbG93IHRo
ZSBhcHBsaWNhdGlvbiB0byBjYWxsIExlYXZlICpiZWZvcmUqIHNlbmRpbmcgYSByZXBseQ0KPiB0
byBKb2luQ29tcGxldGUuDQo+IA0KPiBBcyBmb3IgQXR0YWNoKCksIEkgYWxzbyB0aGluayBpdCBz
aG91bGQgYmUgbGVnYWwgdG8gY2FsbCBpdCBiZWZvcmUNCj4gcmVwbHlpbmcgdG8gSm9pbkNvbXBs
ZXRlLiBUaGUgd29yc3QgdGhpbmcgdGhhdCBjYW4gaGFwcGVuIGlzIHRoYXQNCj4gYXBwbGljYXRp
b24gc3VjY2Vzc2Z1bGx5IGF0dGFjaGVzLCB0aGVuIHJlcGxpZXMgdG8gSm9pbkNvbXBsZXRlIHdp
dGggYW4NCj4gZXJyb3IuIFRoaXMgd291bGQgc2ltcGx5IHJlbW92ZSB0aGUgbm9kZSwgYW5kIHRo
ZSBhcHBsaWNhdGlvbiB3b3VsZCBiZQ0KPiBwcm9tcHRseSBkZXRhY2hlZC4NCj4gDQo+IA0KDQpJ
IGd1ZXNzIHdlIGNvdWxkIGludHJvZHVjZSBhbiBpbnRlcm5hbCB0aW1lciBpbnNpZGUgdGhlIGRh
ZW1vbiB0byBwdXQNCkF0dGFjaCBvbiBob2xkIHVudGlsIEpvaW5Db21wbGV0ZSBpcyBkb25lLiBJ
ZiBKb2luQ29tcGxldGUgcmV0dXJucyBhbg0KZXJyb3IsIHRoZW4gQXR0YWNoIHdvbidyIGdvIHRo
cm91Z2ggYW5kIHdvdWxkIHJldHVybiBlcnJvciBhcyB3ZWxsDQoNCj4gPiA+IEknbSB1c2luZyBh
IGhpZ2gtbGV2ZWwgQVBJIGZvciBELUJ1cywgc28gSSBkb24ndCByZWFsbHkgY29udHJvbCB3aGVu
IHRoZQ0KPiA+ID4gcmVwbHkgaXMgc2VudCwgc28gYXQgdGhlIG1vbWVudCB0aGUgb25seSB3YXkg
dG8gaW1wbGVtZW50IHRoaXMgd291bGQgYmUNCj4gPiA+IGJ5IGRlbGF5aW5nIEF0dGFjaCgpIGJ5
IGEgZml4ZWQgdGltZW91dCAtIGFuZCBJJ20gbm90IGNvbWZvcnRhYmxlIHdpdGgNCj4gPiA+IHRo
YXQuDQo+ID4gDQo+ID4gDQo+ID4gWWVhaCwgSSBjYW4gc2VlIGhvdyB0aGlzIGlzIG5vdyByZXF1
aXJlZC4uLiAgDQo+ID4gDQo+ID4gSW4gdGhlIG1lc2gtY2ZnY2xpZW50IHRvb2wgKHdoaWNoIGlz
IGFsc28gYnVpbHQgb24gRUxMKSB3ZSBhY2NvbXBsaXNoDQo+ID4gdGhpcyBieSBzY2hlZHVsaW5n
IGFuIGlkbGVfb25lc2hvdCBmb3IgdGhlIEF0dGFjaC4gIA0KPiANCj4gVW5mb3J0dW5hdGVseSwg
bm90IGFsbCBtYWluIGxvb3BzIGhhdmUgQVBJIHRvIHNjaGVkdWxlICJpZGxlIiBjYWxscywNCj4g
aS5lLiBjYWxscyBleGVjdXRlZCB3aGVuIHRoZSBsb29wIGRvZXNuJ3QgaGF2ZSBhbnl0aGluZyBi
ZXR0ZXIgdG8gZG8uDQo+IA0KPiBJIGtub3cgdGhhdCBib3RoIEVMTCBhbmQgR2xpYiBkbywgYnV0
IEFGQUlSIFF0IGRvZXMgbm90IChpdCB1c2VzIHRpbWVycw0KPiB3aXRoIHRpbWVvdXQgc2V0IHRv
IDAsIGlmIEknbSBub3QgbWlzdGFrZW4pLCBhbmQgUHl0aG9uJ3MgYXN5bmNpbw0KPiBkb2Vzbid0
IGVpdGhlci4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgcmVxdWlyaW5nIGEgc3BlY2lmaWMgc2VxdWVu
Y2Ugb2YgZGJ1cyBtZXNzYWdlcyBpcyBhIGdvb2QNCj4gaWRlYSA6KA0KPiANCj4gcmVnYXJkcw0K
