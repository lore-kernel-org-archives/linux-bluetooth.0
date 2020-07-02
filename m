Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB45C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 17:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC81212CC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 17:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="m9pXUzMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgGBRUF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:20:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:61837 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbgGBRUF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 13:20:05 -0400
IronPort-SDR: mQDG8grOP6uq29ubO3h7+bwHsd6nJN0DtG3mmwyYCIhfoMYXjlRvrjfdGwAZK+gLTmT77XPhXN
 71fp7MB/1GRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="146058949"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="146058949"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 10:20:03 -0700
IronPort-SDR: wQoNgPn+kD71zUVLijOimitpYIEjNsi4loBp/pdITqkf6Vp0dmgkKUGGoTOQ5xRj40T8GQSc86
 3APPzPfRfLEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="295964218"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga002.jf.intel.com with ESMTP; 02 Jul 2020 10:20:03 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jul 2020 10:20:03 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 2 Jul 2020 10:20:02 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 2 Jul 2020 10:20:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 2 Jul 2020 10:20:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQR1XfcfPwo5j8Ig5uzIntfw2Ri7jy62aQ3velA+livXr9H63+UJvyeEJWqAwBs2avYfgRYeZshueXSSuz2I99Aj13jn4zGAwcjTFI+BbOUcVYRZdCsViKTpmnxJJhZ5wPs2ycR53qFBSTlOz4WHkGMzHsLU4QTnMLjj7r1Y5IMl33aK6lAwier3HzFuxNgrlLZl2jsZU1xMuFgLh/oXzyRaXXP4j8wyxyXTFMmAIR6jCccPsn7RPhNLMK77+etwGzoMIduq3foOL+DUf2uMffPj04rlZ4GvVuMbKI/WAtxKawFVPphmW5T8qr17IE1DpvQ11ii1wclSu7aQ5aWg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+LOiogd6+ssSETNzLYKDdo3V3efi2b4aMgdkRMDzcU=;
 b=A6KOQ+hyBOcFcUWcsVzZCHFVANFF8mkC/oV0z8iRxQpgwqcA252dAsdUk8u2RJHUYqtYvuk/QYXTIsW7dXpNzWWsTtgbAUW8Tb6qaHhvP3HZnfCLLyQb2cSaSG2sFoZ00WMKaCMRsZX29f05J9oYbVJG0DoP6OH1z+oxEoJBz06yc9uQCIPWwuXPRpgzZvBGeIYQ8b3/JNzzuhP8lzbQACbldAapOnlKCCfu3k0NLaMAMlGbBu+IqaoaKytoJhH4EmILtzaQAKcsM1UiF5DZYmIkA3VAPDufNQweeUHMgTw0LNZRHjUL+Yt8BxzlYIH9IQ5eululko6+9CUcK/hV7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+LOiogd6+ssSETNzLYKDdo3V3efi2b4aMgdkRMDzcU=;
 b=m9pXUzMmXEqRjIYVLfQzBHLs5d5702WsnAMP8yNidaQQmxLmIasHKB50vt5fwRCLv9Dq8y7e904Wzgp2JJZw4QTPbtNnXXL3nezqD4/0ZNSynRMPvQNcQrfBrFfzOsVb6Hs5TwrUM1TWqhWceDZ84zFGvTHrrad5au68HB+Z7wY=
Received: from BYAPR11MB3141.namprd11.prod.outlook.com (2603:10b6:a03:8d::13)
 by BY5PR11MB3991.namprd11.prod.outlook.com (2603:10b6:a03:186::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 17:20:01 +0000
Received: from BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::9ce5:c8f4:581b:9d9f]) by BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::9ce5:c8f4:581b:9d9f%5]) with mapi id 15.20.3131.028; Thu, 2 Jul 2020
 17:20:01 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "kiraank@gmail.com" <kiraank@gmail.com>,
        "Bag, Amit K" <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: RE: [PATCH 3/5] Bluetooth: btintel: Refactor firmware payload
 download code
Thread-Topic: [PATCH 3/5] Bluetooth: btintel: Refactor firmware payload
 download code
Thread-Index: AQHWUGimk4Dw0MgRiESE22VK2LjDvqj0SFyAgAA+vJA=
Date:   Thu, 2 Jul 2020 17:20:01 +0000
Message-ID: <BYAPR11MB3141DFA65FBD9E9BFD75F688F56D0@BYAPR11MB3141.namprd11.prod.outlook.com>
References: <20200702120315.26768-1-kiran.k@intel.com>
 <20200702120315.26768-4-kiran.k@intel.com>
 <D3F1B6F8-A35F-4A18-A460-89F0A7644644@holtmann.org>
In-Reply-To: <D3F1B6F8-A35F-4A18-A460-89F0A7644644@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.79.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c5d2048-b554-449f-1cac-08d81eac271e
x-ms-traffictypediagnostic: BY5PR11MB3991:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB3991AEB9F94E4BBB8D691DB6F56D0@BY5PR11MB3991.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zf70rsBiaSWvsh9CWnNZamMwfwG22hadIgmC7DGi01q8XqBvRAwDHwRdDmr8fdOg9lVpykUDS5S6/9DTFuwL22ggNBLH2hsgxRSaSiggpQq3aD97ZxupvpwphMTmKjQWA/P5/g3lT7sZ6GOgTiTqJARJ54tdFv+D9ETd9RlDwPRsg6PJGhlu79q3ACeVmEyMubYxmASlhzLn0B1snIqgtuHfT/WZgJ5Huwt9DPz2kT3AhJr8Ku2cW+a+mYRcx0wzJbnDiNT+pW+B2nGmuSr/cubJTVAXNY9bYmisZmNoPvicTpQrGUy/b2ZUD6s7pJw2L1fn6o/bR5uwbioHeYfdLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(107886003)(9686003)(4744005)(86362001)(83380400001)(66446008)(316002)(5660300002)(64756008)(66556008)(54906003)(66946007)(33656002)(66476007)(186003)(52536014)(6506007)(76116006)(71200400001)(53546011)(26005)(4326008)(6916009)(55016002)(7696005)(478600001)(2906002)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BtX8X72JecXPRr6Zb3fthV5fD/a5eqXTsvOLA7aHM770zuNPIgq1fsnpXKPs21/BlxN46wNszF5kJjhIRmH0h31GBWPzcDkjjGYSz/HtaXXFVuxurXMGfJLCYlI4sVqhCxHYWrYshzxaI2uqdEqKJIrvn6Uzl1sexTz4pzvN0+w5Ws4WuP1sL7MnQImbypx2lQ/vprXuvz+6I9YQJh2PoY3dzQTyGcayg5VQ+qKlh9DN4ooJzs6ncDKNaTvnG9zvWYPMIHlHiNek9Q8EON3tQ2EJv6Nv7LIjMiYOohIOscKfvCdfVfoIaraWuFbwZUKzna44bb2XKiBPw/SoEHgBiRTKOlkH+Y+pqmyYXkociIQQWui0oVD71U69KvI7EZmTbzGFAax9ikftWVtvVy+wFFUQPAbV7K31Q5n5psHedBfHYYKMJtfuCSwGXGnfW6jukFUGg+3ZK+sW4Nw/y9N5UjrNEMr6yd4EnhCxe39zCzg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5d2048-b554-449f-1cac-08d81eac271e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 17:20:01.0779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9DxwQYQ7US0IxAh0ECxbs+DJTO17Gab0fry8OuULBFPxW/Bu0PhgcQl4LEPE9iLBSQV1edjuOYFj6qNU6k8NsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3991
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann <marcel@holtmann.org>
> Sent: Thursday, July 2, 2020 6:58 PM
> To: K, Kiran <kiran.k@intel.com>
> Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>; Srivatsa, Ravishan=
kar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>; kiraank@gmail.com; Bag, Amit K
> <amit.k.bag@intel.com>; Raghuram Hegde <raghuram.hegde@intel.com>
> Subject: Re: [PATCH 3/5] Bluetooth: btintel: Refactor firmware payload
> download code
>=20
> Hi Kiran,
>=20
> > Move firmware payload download code to a separate function to enhance
> > readability and reusability
>=20
> this patch is doing more than that. It also introduces an extra public fu=
nction.

The existing firmware download function is suffixed with "_legacy" to disti=
nguish from an upcoming method to support firmware download in tlv format. =
 I will retain the older one as it is and use "_tlv" suffix for new one wit=
hout losing the intention of the methods. I will send the changes in the ne=
xt version.
>=20
> Regards
>=20
> Marcel

Thanks,
Kiran


