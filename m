Return-Path: <SRS0=VFYa=Y5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81595C5DF61
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Nov 2019 16:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425E72190F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Nov 2019 16:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="LKfCqGcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390174AbfKEQbJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:31:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:37257 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390106AbfKEQbJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Nov 2019 11:31:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 08:31:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; 
   d="scan'208";a="213943073"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga002.jf.intel.com with ESMTP; 05 Nov 2019 08:31:08 -0800
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 5 Nov 2019 08:31:08 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 5 Nov 2019 08:31:02 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.52) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 5 Nov 2019 08:31:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTqMLwOOsTOlI3Gr33Ve7oyZHDSvhPuwmxRJI9fFFEEgivEEEcZh5SQFl0u+KjsCn/QxltaH7sRtO58a31sgYZENSfBJRbfXaMVyPfzzEn20VOz6e81S1IG9cbNis95ONfLyWlIH2cZlCeW0MGr3g6HTv3j+1O5xMOFGzMfMAic9bw9S1YY/ZenOJhFYc03bKePVmbplzth5akt0N6r6wxVhqIFWnNWemoE/LR16KY9GUC9oENNPp022rRqp+Js9hMb5+CEx00GD709F391DH4hOaqdTzoXlc7hnombdmnHCN9uo3DPjh6sIFkiZtlUZ7yKErtL21S9Bmd+35e0mzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vPN7Pr+cmh1Fs4gN6tWGaKcuBDUQ2Z+m0BRvMO2Abk=;
 b=C6XelVprF1cywbb2b+MnJdPW/Yp+hxFegz4jo3fmqJy4rOWJoANapsaW/W06NnOzIJ3C7GLk2cVJPE/HKqFNiqpqKOsnCeMJJsiKGbvD0ZpvL24EGeQBfv0U35ojaI42odi0AL1RPyJhmHQniFIugm9rpMTtjZFtZjUKsIdoT3Ay0Az3C0QrrNMvRTFwFppMFYx831Uw/8YyZgpTafh0M/bIzRHfs46ByE0FYfoai/QgG6X9hp7TtrLcCmi5/SIYfu2gr9TEXPrikcpp/ZZL6HRBwwjP3JlCTe458bJvcUAPVySsRDZYEl9kV8ALHrKMVuPPCv0LX1z80zwaMrzZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vPN7Pr+cmh1Fs4gN6tWGaKcuBDUQ2Z+m0BRvMO2Abk=;
 b=LKfCqGcpHWDGSm7rSn7VFjpuOGq3qju0VZYdb5h1kWpnp/qKB1TEOnRRqG/ATYqU2EzD4i6+LVMaJaCphkXY+ULQBKal5wo2svxi3zzhpp620CbK9vtZ909lCKGhcgL6UXqOHttnj9QOCO3hi7UcJYpis6KuHRjlP3Fta6K1+/4=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2135.namprd11.prod.outlook.com (10.172.78.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 5 Nov 2019 16:31:00 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c143:8007:1ec5:fdba]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c143:8007:1ec5:fdba%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 16:31:00 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "stefan.seyfried@googlemail.com" <stefan.seyfried@googlemail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: test-mesh-crypto segfaults
Thread-Topic: test-mesh-crypto segfaults
Thread-Index: AQHVk1VO68tQgsqZz0+1Ib+798NR36d7ktsAgADENACAAFx4gIAAEp2A
Date:   Tue, 5 Nov 2019 16:31:00 +0000
Message-ID: <229f92060a132ddbbaae9b3be74710dcdf829f99.camel@intel.com>
References: <5f75011d-a157-cab2-72df-0209f7a30f21@message-id.googlemail.com>
         <70299d5df034aa0174a9263ea8736b56fd9bbd02.camel@intel.com>
         <cf7105b3-c623-5583-6cb5-2d04f22c9766@message-id.googlemail.com>
         <c67c9cd7-ecdd-396e-ab7b-bb8716733690@message-id.googlemail.com>
In-Reply-To: <c67c9cd7-ecdd-396e-ab7b-bb8716733690@message-id.googlemail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99fd209d-2deb-4d3b-ee6f-08d7620d8b42
x-ms-traffictypediagnostic: CY4PR1101MB2135:
x-ms-exchange-purlcount: 1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB2135EFDD8AC9EDC48A9B67C5E17E0@CY4PR1101MB2135.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(136003)(396003)(366004)(376002)(199004)(189003)(71190400001)(486006)(3846002)(4744005)(446003)(64756008)(66556008)(71200400001)(66066001)(305945005)(229853002)(6246003)(26005)(2501003)(6506007)(478600001)(107886003)(6116002)(186003)(102836004)(6306002)(5660300002)(81166006)(81156014)(7736002)(36756003)(6512007)(66446008)(66476007)(8936002)(66946007)(76116006)(966005)(2616005)(2906002)(3480700005)(14454004)(76176011)(99286004)(86362001)(476003)(25786009)(91956017)(118296001)(6436002)(6486002)(316002)(8676002)(110136005)(4326008)(11346002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2135;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A/uZjbm512r0bK5M92Vv55agtOKm+aySwpDau9z141juDW21KiI+fVJBPQNvaP7RX+XmLB0VYDKXk6qKYoL78X7gLssjRXglXJ5gK4OlH8rutPi7F86Fdu+XB8MxMhPBGsMHSMGD/0gzBWiB3A0VpCf2RwEN5ALFSNNAd+JK9frTV82URE/FOUQYLp+7BsZJD64Ox7evp6f7YioLX6//tYLXw5CzNTQ79GkiopDsuxkK7QZ1Zoe3UovRldDLMVZVfhTxGIsz4YVitkaJ6lQxMRY6EyJaw/uQziXYm0qgfRFhwK+tYxbLvTE7UA/xpmezv9dfuK6IQ1IgQLBpRwKRf4Hxs473XsPBdQE3UFc42ixRg3GsfY+sLqUv6GNjM2qpykUzwvD430w/ymK7qbWlSnXf1BwvrmhCqpGdY56eLo2mh8d+zS1AHo+31FvzJWzGLxAC1ugyhvWGiU1YTFDUW1sTOc7nXdwxhNaZwNmCvCQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C97A7DFC29D8D442A491E970307F334E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fd209d-2deb-4d3b-ee6f-08d7620d8b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 16:31:00.6321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yjskgylu/nudBcY2MyQlRtdTOf65jY3ozhxF9FG4zS3FjtzX4/eFhf5o8HwkHhc2xRkeN8K6Uf3mFYka1r7ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2135
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgU3RlZmFuLA0KDQpPbiBUdWUsIDIwMTktMTEtMDUgYXQgMTY6MjQgKzAxMDAsIFN0ZWZhbiBT
ZXlmcmllZCB3cm90ZToNCj4gQW0gMDUuMTEuMTkgdW0gMTA6NTMgc2NocmllYiBTdGVmYW4gU2V5
ZnJpZWQ6DQo+ID4gSGkgQnJpYW4sDQo+ID4gDQo+ID4gT25lIHRoaW5nIEkgZm9yZ290IHRvIG1l
bnRpb24gZXhwbGljaXRseTogdGhpcyBpcyB0aGUgcmVjZW50bHkgcmVsZWFzZWQgYmx1ZXotNS41
MiB0YXJiYWxsLCBub3QgZ2l0DQo+ID4gbWFzdGVyKCEpLg0KPiA+IEFsc28gbm90ZSB0aGF0IG9w
ZW5TVVNFIEZhY3RvcnkgdXNlIExUTyBieSBkZWZhdWx0IG5vdy4NCj4gDQo+IExUTyBzZWVtcyB0
byB0cmlnZ2VyIHRoZSBwcm9ibGVtLCBzZWUNCj4gaHR0cHM6Ly9idWd6aWxsYS5vcGVuc3VzZS5v
cmcvc2hvd19idWcuY2dpP2lkPTExNTU4ODkjYzYNCj4gZm9yIGFuIGV4cGxhbmF0aW9uIG9mIHRo
ZSBpc3N1ZSBhbmQgYSBzdWdnZXN0ZWQgcGF0Y2ggdGhhdCB3aWxsIGZpeCAvIHdvcmsgYXJvdW5k
IHRoZSBpc3N1ZS4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHZlcnkgdGhvcm91Z2ggYW5hbHlzaXMu
ICBXZSBhcmUgbG9va2luZyBhdCBpdCBub3cuDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCg==
