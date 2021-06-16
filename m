Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C01C48BE5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 02:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EFEF610F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 02:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhFPCxm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jun 2021 22:53:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:56234 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231934AbhFPCxm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jun 2021 22:53:42 -0400
IronPort-SDR: ZODgWd9zAOEuMfEubU2uQSDEs6O+N3scZhU6HZS+R9iy3e4BjcMaJKtvBH0KtrG+mDtwC4hgKU
 MfK1oI7qCmOw==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="185796658"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="185796658"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 19:51:37 -0700
IronPort-SDR: o+ni04/OtTYSbYojT1rC4QkCOzEjM1tFw4j189Sn3HNggW2hUKepYa3HoznsAfwGXQkNlWdXam
 gQ2/iA4nWJwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="554651392"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2021 19:51:36 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 15 Jun 2021 19:51:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 15 Jun 2021 19:51:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 15 Jun 2021 19:51:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4vasFgaaf8n8Ed+NGcTwxfsgMYW7IK1ysdMXCeQ4WijLcNX23eM7o3NtObYvcvPrltlG3g6c3Dyjv3hGdia0FPM9QhDN37dW/+79msxMB53kz/lAzdzhpNyZNF+TTROMlqTlGt13k2SObxpGEPeO4OF+DVXCqGXZzdAh/h5iM4NIfInoEE76t3hnTc18CyyRhjO2o3yRZKMT4kpDzKeR3Nwtt9MdfkkF2FJlBkPXUjGQ9kTXbTm8MtpHcpETVUa/+exe8eTiajyOy7bL4ah9SktOqM5y/BMZudM5lXJlU0h3ah3EO9KCEIvlJi5+95Jy7Z3gPJllkhKSw7jNwwvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Go5dLr6WrbLWjOIUOWe5/3z770UrO6V5GOSsdj5HT8=;
 b=MQ9uYxhNJCHintafWjfNaqtaTBYmUE53luiHYwiZ5aZFn+UPunhX78wC1UrsePz0lC1GV8cyTs2PI9CVuSRmqgMVpZ6end6yp6eVXGR01HZU85vSiKX2ZjotNaUkqGGzt4kC/4ROiT4Pp6o7cNkMjBAGt/socyR241KMyAwyfFLCkQ17m/aa1dBXuEErT6R2IU5i5UbJ94XDi0H1Rm0wkUg5wpttFzGL5plnoIzTW336DJFaRQr9c+ZtpKXnVjNmMeCrN3FHRrlxHfouWjlzsyBNKLNgMw/1MNcgAem+0NQ8cWbSXaAZmVO0u4TOYTqBML1aVcC/z8QK2mEqNtNZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Go5dLr6WrbLWjOIUOWe5/3z770UrO6V5GOSsdj5HT8=;
 b=xdaNRHJie9+9E9BE8YyMdn3uTi5tp7LHCBKgAmSbGWHD1TdgcamDLI4zXz5kpM88JCWdl1Cq1jk2K9QmWSRmqMRTplqDp7/UK6MqEDvSvVESJxfW6PUMJKeXmRb8MX05ZOswKTBiTuLshXEeXgHomLfBYRS+1d2JtdC0kcUO2kE=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5670.namprd11.prod.outlook.com (2603:10b6:8:37::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22; Wed, 16 Jun 2021 02:51:35 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::d813:3260:1526:b63c]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::d813:3260:1526:b63c%7]) with mapi id 15.20.4219.025; Wed, 16 Jun 2021
 02:51:35 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Subject: RE: [PATCH v9 01/10] Bluetooth: enumerate local supported codec and
 cache details
Thread-Topic: [PATCH v9 01/10] Bluetooth: enumerate local supported codec and
 cache details
Thread-Index: AQHXXGC6rou4Ly4lUk2Ohk6v80J4s6sVf4wAgAB78UA=
Date:   Wed, 16 Jun 2021 02:51:35 +0000
Message-ID: <DM8PR11MB5573B3ADF9761EC7C0D754DAF50F9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210608122455.19583-1-kiran.k@intel.com>
 <BB62EB90-BF5E-48BF-B5C5-72B410AF7025@holtmann.org>
In-Reply-To: <BB62EB90-BF5E-48BF-B5C5-72B410AF7025@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [49.37.181.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3729b165-6481-48c7-b3f9-08d93071a80f
x-ms-traffictypediagnostic: DM8PR11MB5670:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB56701F442E71FC8EDE02C310F50F9@DM8PR11MB5670.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JEtdMuR7qHITeUGfkI3qMMnKQg/lAABfLB9alPlKAUq2HSWodSV6jITelD9X1Fc4fkRCTBuCW/2VaXE7mMZMKlmXpZVH79Ukwats201lhtCjFDnBCYkGhmOmlSLrGmF+n8JJMGoItZKCvb7HS5G5m5rW76d7a9sOW0A1mFX5Zcx+RzVuCgN6MiEOL6Esv4EFGiuGyUjYtdTK4PduJiCrDHZ4L8uhdo/Hz+6+jo5+/JVI+kThtCCdYrMNX8/3eUpKDRsC7QhgeJaB/3mO/fjRj1oxlT3DNVLD/qQZcRRNNfSW/jDfXse7Y5eQ+QVZvwaifq9KwBvHtmQod3TM/aAhXaw/NhTk/mbMtNUTEzJzbi+yOUrwqfG3V0f1iJxq7qsFZvbeewc0RfRvJyRv0RLpfbtG6TRsFQeVCOTO6kTMJcj1HBx1ntfT8mJB7L9SY9N+oeV9Ei6iFNC+rOTqQ8JN341R4mjDui7T9wxeMusRaReloHD8r3fj5cVXlomjO56Bo9KZ7rFvQFgH9SHcxIvSqD4gpO63+utpX1lvISgdM/5oCUPQ2Bgp4VDdlDNZcpneKYQnPaMMcELwXtOOv0M9Hdf4ARlbJM2H8q0q8hwoEVs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(366004)(396003)(26005)(9686003)(8936002)(54906003)(186003)(4326008)(55016002)(316002)(8676002)(107886003)(6916009)(33656002)(66476007)(83380400001)(4744005)(86362001)(71200400001)(66446008)(52536014)(7696005)(66556008)(64756008)(122000001)(76116006)(2906002)(478600001)(66946007)(5660300002)(6506007)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NvHGvmPepX2c6cMf16mi66LNwvyqurXeMYgz1YzPlstKufjGOdCiyYX/2Pxn?=
 =?us-ascii?Q?kakxrQNFDkGsgMw9b5AVknztPZYB6HAz/r20xkMnPkRIglzunzrfdSq2WGJq?=
 =?us-ascii?Q?6EI7em58dOq7BJgVwqitiNvMal2ct2pDjdN7e9976Jf4xbML3xDdoqY7DwyG?=
 =?us-ascii?Q?cgDf5RtHnCzYU2yIaNWuGXbgrlt6+rY/QaOAfwrH3rCADRxOdX2ndluK/UgP?=
 =?us-ascii?Q?lWqn/BzQZSevNcxHxmOyl9pVniByADAqHhEjgQnsU0Hma1NEaOZxG+xurRnD?=
 =?us-ascii?Q?DWOE5xIDwztUqPnJEyMzcTPxLl6nvOf5ht2RBr5y2C6uaLER4fc89WE+DOcb?=
 =?us-ascii?Q?C7GK2MxR7sAuwWSVIP+xBZHZbJ3UBEtORJJPMOWBkVjxVaJklzJxi0ZV6pWL?=
 =?us-ascii?Q?xUsrHnnTpOg3sEs5s+GtXql4LYExxW6tTK0Zq/bySQhTpEqUFkdWa1nsKIXt?=
 =?us-ascii?Q?t0GU9MHl91e+cu4ZNeXyUUq+z8WvQ0Ggxn3PdgTmbfksQA9EAMTwMD31x9i/?=
 =?us-ascii?Q?vRlsJP0q98xmK5BY0h52ykLwSn7XljrZd0Dmo2sJU/jD98W1Vck6eWjVQ0CK?=
 =?us-ascii?Q?2FnUzalSnvjAZFtK3oqY/KX20X9oULkNL3OfwIRyvZNsOo6Q58S5VHqkVkzm?=
 =?us-ascii?Q?3bx4pPQoQHRPMyOwcY6WrS7qeXYpxIF12thr691auqx4QeMNeiRelltVZIeL?=
 =?us-ascii?Q?/DPCTpkVi/ucn73Tc9FvlmMHiI4qcQAP1yRS9N/zfX5+ypunNgruH2XxX2Ip?=
 =?us-ascii?Q?fxeXZ3L+tR3bqv5NSwjEMQx/LSQtjK6nnZHygAn40Gon1LCASzz+S4mloEFe?=
 =?us-ascii?Q?265P+1JUq9htNZ88ChX2RFOWjLExzozNT8Oc3j6hYWWmaI1gd8ucvh46KixI?=
 =?us-ascii?Q?xLV7OBWaU4phUJ04EF8HZZjUpc4fH8JGgDxggGJABDTfvnvmW7bNcTuaAFVv?=
 =?us-ascii?Q?Qtg87C4uusBOtdFcFvTTkRliijiKXcddTo5+GWU8siX3F13nQB0NIV/XBiT2?=
 =?us-ascii?Q?pPmhQIOBHeOQ0c7UK1yYEl2DrAPkAkjH7mGJ31cyjlVYQIHpsqLwSSU1+2He?=
 =?us-ascii?Q?VpZvUKY4tMbDPWNvpxopT6+ly6K0b+z7ho0RhSRcHLEe3d4SyOr6qC5SMnhU?=
 =?us-ascii?Q?AppwmZt9gSLsqqBigvKOiAjR8eSaQyJ+FKCCLMo902tRzLiQdfov+Lx7tzMa?=
 =?us-ascii?Q?vCdqZIjwO7egezaT53PKZH6+O5P7gkk/jhk75KLc7QH/s0HFdXNsWjPzEtJM?=
 =?us-ascii?Q?0GpO2rhoM1736UfmnSTziYLyKQiJgPeGn6yu+K9XO7HDmp6NCIlfP8l/9Rf7?=
 =?us-ascii?Q?/nXTJBldPFA9wga68sKXh/uL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3729b165-6481-48c7-b3f9-08d93071a80f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 02:51:35.7699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2XzitaRF9U2q2/9X8AnkWSPDF+bTdjXqn3uQBwqGZu9ub89Vgv7gD5cHl0547cPNCpCssRuINa35uFS+OT8Mxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5670
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

>=20
> Hi Kiran,
>=20
> > Move reading of supported local codecs into a separate init function,
> > query codecs capabilities and cache the data
> >
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Signed-off-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> > Reported-by: kernel test robot <lkp@intel.com>
>=20
> what is Reported-by? This makes no sense since this is original code.

Got a compiler warning in one of the patchset. Hence added "Reported-by". O=
k to remove this in the next patchset.
>=20
> Regards
>=20
> Marcel

Regards,
Kiran


