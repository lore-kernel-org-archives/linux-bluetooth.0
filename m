Return-Path: <SRS0=wIos=VP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239C9C7618F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 17:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E4D208C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 17:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfGRRIA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jul 2019 13:08:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:29778 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfGRRIA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jul 2019 13:08:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2019 10:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,278,1559545200"; 
   d="scan'208";a="168323578"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2019 10:07:59 -0700
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jul 2019 10:07:59 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.44]) by
 ORSMSX153.amr.corp.intel.com ([169.254.12.99]) with mapi id 14.03.0439.000;
 Thu, 18 Jul 2019 10:07:58 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Allow sending on org.bluez.mesh.Provisioner1
Thread-Topic: [PATCH BlueZ] mesh: Allow sending on
 org.bluez.mesh.Provisioner1
Thread-Index: AQHVPRx9SgKaSAlb8EmLuiJ/3sgiqKbREc8A
Date:   Thu, 18 Jul 2019 17:07:58 +0000
Message-ID: <1563469676.8708.1.camel@intel.com>
References: <20190718035418.4952-1-inga.stotland@intel.com>
In-Reply-To: <20190718035418.4952-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.137.82]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7EFFF9880C50D44ABC090583DBB2DBD@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBXZWQsIDIwMTktMDctMTcgYXQgMjA6NTQgLTA3MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgYWRkcyBhIG5ldyBpbnRlcmZhY2UgcGVybWlzc2lvbiB0byBibHVl
dG9vdGgtbWVzaC5jb25mOg0KPiA8YWxsb3cgc2VuZF9pbnRlcmZhY2U9Im9yZy5ibHVlei5tZXNo
LlByb3Zpc2lvbmVyMSIvPg0KPiAtLS0NCj4gIG1lc2gvYmx1ZXRvb3RoLW1lc2guY29uZiB8IDEg
Kw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
bWVzaC9ibHVldG9vdGgtbWVzaC5jb25mIGIvbWVzaC9ibHVldG9vdGgtbWVzaC5jb25mDQo+IGlu
ZGV4IDI4YmU3YzY0OS4uN2ZiYmQ2NDhlIDEwMDY0NA0KPiAtLS0gYS9tZXNoL2JsdWV0b290aC1t
ZXNoLmNvbmYNCj4gKysrIGIvbWVzaC9ibHVldG9vdGgtbWVzaC5jb25mDQo+IEBAIC0xMyw2ICsx
Myw3IEBADQo+ICAgICAgPGFsbG93IHNlbmRfaW50ZXJmYWNlPSJvcmcuYmx1ZXoubWVzaC5BcHBs
aWNhdGlvbjEiLz4NCj4gICAgICA8YWxsb3cgc2VuZF9pbnRlcmZhY2U9Im9yZy5ibHVlei5tZXNo
LkVsZW1lbnQxIi8+DQo+ICAgICAgPGFsbG93IHNlbmRfaW50ZXJmYWNlPSJvcmcuYmx1ZXoubWVz
aC5Qcm92aXNpb25BZ2VudDEiLz4NCj4gKyAgICA8YWxsb3cgc2VuZF9pbnRlcmZhY2U9Im9yZy5i
bHVlei5tZXNoLlByb3Zpc2lvbmVyMSIvPg0KPiAgICA8L3BvbGljeT4NCj4gIA0KPiAgICA8cG9s
aWN5IGNvbnRleHQ9ImRlZmF1bHQiPg==
