Return-Path: <SRS0=yJGP=4E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F867C2BA83
	for <linux-bluetooth@archiver.kernel.org>; Sun, 16 Feb 2020 15:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B0520729
	for <linux-bluetooth@archiver.kernel.org>; Sun, 16 Feb 2020 15:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="TtF5Ju43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgBPPRi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Feb 2020 10:17:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:10700 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgBPPRh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Feb 2020 10:17:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2020 07:17:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,449,1574150400"; 
   d="scan'208";a="234994393"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga003.jf.intel.com with ESMTP; 16 Feb 2020 07:17:37 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 16 Feb 2020 07:17:36 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 16 Feb 2020 07:17:36 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 16 Feb 2020 07:17:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 16 Feb 2020 07:17:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRk6Y8uDc9COKVwTJwFOqNsaqFHfCzklj91I+CKi/IWblNR2/mTTOu2cjqyRj2fWZwt8zEa/Ml9NdPpyWyUsjyYczeg4Da0A0nRBMVyrpfTYaZkcdTlIzu/CpOJm2Cc+VxUvDV+tHD5I+EJkxxwtVGj5JrAeJBy1Y3Zldis6C5P8HCsSivvG/7DQPWq5MrDSWkWDS/inCpWeR3rxruZ27R55XL6CejSQACbTHpWFYe4ET6REjn4l92o8lhevWvuxbHfP3GPuMxtknOQwwrNfO/G7XMGRCN1TQA7ryW6W/ihY2Ztee04GKAoEdug9s8+mKH51yZ+R3feudqgVsi0EGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTNkGvNm2XUDHHw9cTmQJ4loiJUGAcwq7t+heIkNwYo=;
 b=gDHZdu8dzxihoBuThfv61C1jF8MNMip15kwusZS33uAG/nsbQfsYHeE4zy8t/RWdefPqhEbFNyAOHjkT68afOeGbbsO3+6GWUzz14ck0ZFr0EaBxNWT/czKEVEa4rS9/sGweI+lUe+LPrXngApD+ulS9QioPqC2g7XRT5XzuhHixJYrn/aJcvGHpWofrUyh5eVMK5cBcWZ6ayXpsimWMm4wlVIk4EnA31Bnw0tJNBeRE9gNnwt15z1NuVLSnB/9SFAjEnTPFh+3dRYcojLFI2UGm6GcCi9znM2wQjBSFBTyz2Im5XPpiIj3KsK5v42r2hXJXY3ZRLoxZih2SZZfvOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTNkGvNm2XUDHHw9cTmQJ4loiJUGAcwq7t+heIkNwYo=;
 b=TtF5Ju434FVveIR9G/cCqVFzH4nvQgH0DOHhfyuVTQ56uQJC+nE9DxxHfv4QI4PEPidLya3vbfZEYYAEHj1y3/CYAtAciI2cOI5pKXMXTF82GuYXDYadjijmQvBDprQovb+XUnMZ9fBQvS0MXAwiAozT439ig0OmqqMUNEWeEU4=
Received: from BN7PR11MB2580.namprd11.prod.outlook.com (52.135.246.155) by
 BN7PR11MB2708.namprd11.prod.outlook.com (52.135.252.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Sun, 16 Feb 2020 15:17:34 +0000
Received: from BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6]) by BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6%6]) with mapi id 15.20.2729.031; Sun, 16 Feb 2020
 15:17:34 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "Michael N. Moran" <mike@mnmoran.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: mesh: Send mesh model message to group address
Thread-Topic: mesh: Send mesh model message to group address
Thread-Index: AQHV5C2Vy513aGUpRUitpLa2q+/ksagcqg6AgACTpgCAALJejQ==
Date:   Sun, 16 Feb 2020 15:17:34 +0000
Message-ID: <23EFD76B-C427-4AE1-96C7-D4103C243D9A@intel.com>
References: <848c1b0b-83c6-41a3-fc66-1359fa9a72bb@mnmoran.org>
 <e2f322b4ba3abb81b59a51d8bb5c3611b968cd4f.camel@intel.com>,<410faf08-70e6-ebb2-df7d-79ea1ee0b9f4@mnmoran.org>
In-Reply-To: <410faf08-70e6-ebb2-df7d-79ea1ee0b9f4@mnmoran.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [97.113.35.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 451459f0-a94a-422c-3a2b-08d7b2f35991
x-ms-traffictypediagnostic: BN7PR11MB2708:
x-microsoft-antispam-prvs: <BN7PR11MB2708E27641A6806D0F45056FE1170@BN7PR11MB2708.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 03152A99FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(136003)(189003)(199004)(316002)(26005)(6916009)(36756003)(4744005)(6486002)(81156014)(91956017)(81166006)(76116006)(66946007)(6512007)(5660300002)(8676002)(66476007)(186003)(64756008)(66556008)(66446008)(478600001)(33656002)(8936002)(4326008)(86362001)(2616005)(71200400001)(2906002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR11MB2708;H:BN7PR11MB2580.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wq3w9FD1OCKykxJxnWH5H1H9ozjBPfEqtqnATbO32mlzFB9nJ3aYUowz5tX4YkrTgWvCi4jmH3CCUiMJtHzxfENMz9RQiXek/806tTbYuYh2OrXcXGbY7SSkQfH+SwiwI35KU/T5qWEF8QkYsoHhP87IDeYAF8tTfAzsVYbNDSg2G9+pUKVMkFjK5wXNwex5+Gu9xKv4vHFhG+WmzQ0RdcG30sDTQ+zajuNS1ccH0atM4ZaP5Yktkyu5HjKVeWAs7VTR458LVsU7OZ8leCWf5crPxPYQDmzMR0sXccUniXGUEc80pS43FEXNPYNbcxOTOBdO3xKH3fNwLzITA5MxGX+VCUhY0jNsO2wwJd+9lxxbZUFIyf5zPeyu4ZbqW3TlWuLPF/VuQEVLRtm5IFmpdFAeY9GEz/PYWcPEJmabq2l56CkQw/3b5vyVb5UYcl4Q
x-ms-exchange-antispam-messagedata: 0KmfTI00h4WaBzi8BQYzduc723lCZQBxnzfaG6UL4Lg7bVos9V6qXB9VH/id7IYKTIyhnOo/iA6mxcQI3wFAH/cYGadvmGC+TBLKzwYKOMIvs2AQLu70VZiHRyLHeJORLiXlwxrmcgWRmyEs08kj+Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 451459f0-a94a-422c-3a2b-08d7b2f35991
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2020 15:17:34.3852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BAQCmPNl8/Imre+UduHbCrScygwpbHPQM+acVlgJFx8aomAOjKLUsW2h/1611O7/FqZIPsVoBsP90aqdG8I4fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2708
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgIE1pY2hhZWwsDQoNCj4gSSdtIHByb2JhYmx5IG1pc3Npbmcgc29tZXRoaW5nLg0KPiBIb3cg
aXMgdGhpcyBzdXBwb3J0ZWQgaW4gbWVzaC1jZmdjbGllbnQ/DQoNCm1lc2gtY2ZnY2xpZW50IG9u
bHkgaGFzIGEgQ29uZmlnIENsaWVudCBtb2RlbC4gSXQgY2FuIGJlIHVzZWQgYXMgYSBzdGFydGlu
ZyBwb2ludCB0byB3cml0ZSBhbiBPbi9PZmYgY2xpZW50IG9yIHNlcnZlciwgb3IgeW91IGNhbiBh
bHNvIGxvb2sgaW4gdGVzdC90ZXN0LW1lc2ggdG8gZmluZCBhbiBleGFtcGxlIG9mIGEgcHl0aG9u
IGltcGxlbWVudGF0aW9uIG9mIG9uL29mZiBjbGllbnQgYW5kIHNlcnZlci4NCg0K4oCUQnJpYW4=
