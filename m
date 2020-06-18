Return-Path: <SRS0=NPxI=77=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713D2C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 15:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A1B2070A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 15:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="p45Teld+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgFRPtA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:49:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:30293 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgFRPtA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jun 2020 11:49:00 -0400
IronPort-SDR: XsbjAKbgQoJMe49llEMbxDQa1IyOZvv/3DFgy/rPwFh78Dn+hwNQIhgrqabNryL7BWrowPXlP2
 j0s7F6YC0NKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="122854548"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="122854548"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 08:48:59 -0700
IronPort-SDR: ijSfiij4oNQqtcZAauQ1HRuwQQkBAQe6B5x67UpYcuhB5yRdRYTs6BevHJaunouHnXqeO04alb
 3XFXvtLWJBkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="317860185"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jun 2020 08:48:59 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jun 2020 08:48:58 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jun 2020 08:48:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 18 Jun 2020 08:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8JKZ5thgw9OSsk5BZ40yv5xZcGNzcSmFV/dSvc28N2MqcGXEKDz2JI56UWpM5xPwv704PDclE1AYzgwC1V3XiOB6dlYGlpAz0TMnvUYo1Pi4o0DP304PzbABPN9ELY1hcaBTETQ8E9BK/dEPTuLyz+NupXJHMSNsFXjUTT/0T3TVctxu69InJgyvnMI7ZzeWr2PLYeZZlh7+nJrzSAQ0VEFAnGvXgLInqaaToKvgHr80haTYDB3icyQiMHNeZbqdrrz8QWk6NtvFIeTvtb1xNkmeG1B5iBmfdSELzOVExIY1NeJu23DvmijWjjF7w484QR57iLrqSn4mvjYTC94gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Dx6MjaeOKYEPNSxwvsELD4DFzpRHkjOM1iGjy/lQMg=;
 b=Q8+0k88O4TQxeat2WbQiKQ3FU4WtN0e72i9ClmLSAcAC6C6V5Diq07GuRauqisTorw2sFK6D+7B5jj8m+fShK//e27wr+U7ZM8s2V6F16W/qUusOyIPOi9A03wglu8vRHO1z/8lsM+wAnX/pLl+tjDXh8/zZI7GsMYER9co6gCgpAD7AsdIJcSmRDyL/04PwzLTRLj54zch1CMSNjwBO2rUMiPAb31f0waIU4GnDamtzthDAYvwCuDGx/4l3cXQ4corLe1SV45jNr0WY3ZsXI3+wIVAA4lJF8EkdvfOygj68aWJUY733cSS7W0tvzTdb7S3EtOfYB6hI7Go3HJAltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Dx6MjaeOKYEPNSxwvsELD4DFzpRHkjOM1iGjy/lQMg=;
 b=p45Teld+QNsAJ0DrJdoluN1fhgpcjMyDfwM+Ip9F5lgMAfizhm7pfF3VuuGGvjqqO73T0+HFj3GGOby9LzeaY73invehCReRhE5dYqy5245MKZa/4NiFMwEaaiyLMGylJlX8zV25yzQyMUX/ukGUSBkRJwkkwBi2AK5M0kF+Wk4=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1533.namprd11.prod.outlook.com (2603:10b6:301:e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Thu, 18 Jun
 2020 15:48:56 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 15:48:56 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: Add deferral of Attach() and Leave() if
 busy
Thread-Topic: [PATCH BlueZ v2] mesh: Add deferral of Attach() and Leave() if
 busy
Thread-Index: AQHWRAoF4QbQWbpp20aM35Tw6qEvMKjehbaAgAAAnoCAAAGJgA==
Date:   Thu, 18 Jun 2020 15:48:56 +0000
Message-ID: <12a59828baabec5621917d283e03338d796715f3.camel@intel.com>
References: <20200616181436.50319-1-brian.gix@intel.com>
         <f4c0a48f8d7c30b7c12bdcce84cf8ee172709daa.camel@intel.com>
         <20200618154325.eaudqfy4inbjl7oy@kynes>
In-Reply-To: <20200618154325.eaudqfy4inbjl7oy@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: silvair.com; dkim=none (message not signed)
 header.d=none;silvair.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a952fe5-d6f2-4156-5a23-08d8139f1c0a
x-ms-traffictypediagnostic: MWHPR11MB1533:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB15336F17EE3EAE29DAE1546CE19B0@MWHPR11MB1533.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yw5yrLCLiqsB5XHZ7JPpz2lQ+kAbIs4OmpDJfonpWaTpGTD5HjxehFPZB+1jjf79ZkJfDERwuID6bH0kI8fykAfY16h9GfukKl7KdNnec2IrRvkW07SFcncKMps3e4WxxAaO7R/64D6LJLcCB2spUsna3d0WTuSMizhePJYabTIf0sgfjiUe7PDjYUFMAIvZF3G4xr5gMDb2wEDPUApTWzt4xipFE5Y7WpBVhrGHNaa9TaGnyB9AY/hmH3rR2NL5PMVhTY+WRmCPMqRO3uqIgyy7GadL0mZ0dxuWA4hv7mUvHuQUWLlXMOP/sgaNvknZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(54906003)(86362001)(4744005)(6916009)(64756008)(6506007)(66556008)(6512007)(76116006)(2906002)(66476007)(36756003)(316002)(8676002)(66946007)(8936002)(6486002)(83380400001)(186003)(66446008)(2616005)(478600001)(26005)(71200400001)(4326008)(107886003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2c7Zxzu0HvGmZxjSO+AFasER7aKTWqzIXpM5Pvck497AlFUgVnHSEQ3/nIOhNGUrX+ICCfh3tO2t4nEbM0vw0bGDLAXTml+IWAYEJGUomAHOSUprxTmTJb/PP1hB3WmqNEwcX3xDYipKpI29KqJiYPbOcB7ddpY8zhbLr1mreFsu+zZz/ePKo3V/sQ/Z8NiDjJ9d6GrIeygN6m9WmUASqlPE/XqGX0RM89cBGoULI1Ju2gHtJbDzhzbbfmwcAx7YeuIhEtiPuMGaqOXWKEwjd3Zr+t2A2CNBY6b3aBbPCIq4GEnsaRx/3l5JxcjQ2/hg/iL8F3N0Uv+2kOsyeb5HDXmo1HzlEFt8JnkYAVczDgEJGlv4nF56vOZqFSXuUKMS+3PsBs+9gqEILASWUMsfc3FCUfFAx7EN7w5pCGZXYqv6k7X9iOjqnYAkj0Q5SmPtRsYeNuJX8P1vhDx1WYu/GfrhuRdfpR05KTEuzn4RjtPZNAgXwh5uhDwxMvSN2qLn
Content-Type: text/plain; charset="utf-8"
Content-ID: <71A4B3E83AA9354597729AF2C3D67D0E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a952fe5-d6f2-4156-5a23-08d8139f1c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 15:48:56.1982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HqAv2WjY6uCXV+QCrkKI8l0UCOW/+06FNpG7z+95g64koveAFOxzovykxm64pnd6CcMi+6SkieyNqDzurkzpLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1533
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KT24gVGh1LCAyMDIwLTA2LTE4IGF0IDE3OjQzICswMjAwLCBtaWNoYWwu
bG93YXMtcnplY2hvbmVrQHNpbHZhaXIuY29tIHdyb3RlOg0KPiBPbiAwNi8xOCwgR2l4LCBCcmlh
biB3cm90ZToNCj4gPiBBcHBsaWVkDQo+IA0KPiBJIGhhdmUgYSB2YWd1ZSBpbXByZXNzaW9uIHRo
YXQgbXkgY29tbWVudHMgYWJvdXQgKHZvaWQqKSB0cnVlIGhhdmUgYmVlbg0KPiBpZ25vcmVkIDsp
DQoNClNvcnJ5LCBJIHRob3VnaHQgSSBoYWQgcmVzcG9uZGVkIHRvIHRoaXMuLi4NCg0KSSBhbSB1
c2luZyB0aGUgdXNlcl9kYXRhIGZvciB0aGUgQXR0YWNoIGFuZCBMZWF2ZSBjYWxsICh3aGljaCB0
aGUgZGJ1cyBzeXN0ZW0gYWx3YXlzIHBhc3NlcyBhcyBOVUxMKSBhcyB0aGUNCmluZGljYXRpb24g
dGhhdCB0aGUgdGltZWQgZGVmZXJyYWwgY2FsbCBpcyBqdXN0IHRoYXQuLi4gICBPdGhlcndpc2Ug
aWYgd2UgKm5ldmVyKiBnZXQgdGhlIEpvaW5Db21wbGV0ZQ0KcmVzcG9uc2UsIHdlIHdpbGwgZm9y
ZXZlciBsb29wIHJlcGVhdGVkbHkgcmUtZGVmZXJyaW5nIHRoZSBBdHRhY2gvTGVhdmUuDQoNCklm
IHdlIGhhdmUgYWxyZWFkeSBkZWZlcnJlZCB0aGUgQXR0YWNoL0xlYXZlLCBJIHN0aWxsIHdhbnQg
dG8gcmVzcG9uZCAiQnVzeSIgdG8gdGhlIEFwcC4uLiAgYmVjYXVzZSB0aGUgQXBwIGlzDQpkb2lu
ZyBzb21ldGhpbmcgd3JvbmcuLi4uICAgSXQgb3dlcyB1cyBhIHJlc3BvbnNlLiANCg==
