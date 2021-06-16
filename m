Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC54C48BE5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 03:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D0F611CE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 03:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhFPDEc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jun 2021 23:04:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:25343 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231946AbhFPDEc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jun 2021 23:04:32 -0400
IronPort-SDR: qaLzGidOaCrkTCqloJuoG0Jg2jGTB/QpW1Bnv9OYodlQU6aFZmaqh/2gbezhXrqGzumzzohzm2
 HmJ615FObiig==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="206141811"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="206141811"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 20:02:26 -0700
IronPort-SDR: 6h3J/Z2H768cPhHMlSsle/rr+zS97TXAVvQi1aEz1eE60eJALjJmHnfTBDq9oQzJufkKqg/8sT
 FKwZhsPkqDCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="478925561"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2021 20:02:25 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 15 Jun 2021 20:02:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 15 Jun 2021 20:02:24 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 15 Jun 2021 20:02:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3fBg4L1BqTzYO7kcZqFzMjMg0Dj9ndHOoO2ASjGO88H86xFmWDR8HuBlvhsYgsleDQRBVqa80vpFvHhA6/2eqWigCkqPn4x9dg0UIVbwrI6ynGiydepwnIwtvldcDb2PNn/NlQr8o7ZHDNujxGtO4Uzigv5T4MfaxF/xx3XfOsJpDBGt+oxLqdck7jADg4VrMxD594Xt0aRxDf3iJY3tDAKIrtAQgt5sOXGEIyTzcRJ+KSeS1heKeG/5WvOC6DwWSsDNcLfjNg1w8PE1r7KhV6M19JzWEXck0xedeg8yrwWDK9CjelXkGXppYGPFVP52SE5ge0EktW+c3bo372JTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXjEE6HUTxl9lEL2LCraClTl6Ox0I7vSCeQYjUdahds=;
 b=H79a1bnFWmgpE15V8SxWD9jU4y4YpMjBXJ1dbJA866RAo/HEulGCis0UAcYiAG16QuAACoRGWQ0Y+OLOQEANJBmgadu5c6Sw7EPQFfrqHM42iI14wPq2dfEs6+JzfhDI70N2Er8aeq1JTHpCevZV37VLzFY5hKwLuGC9dsL4xYeTFMektbT0eb5YiWS5iwk2HT4O2nqwe8bTzILDYWmHExZHfUu/c6mF8zPo/WHz8FMCwqPC9vZ8GA66QFIhbb9M422gZ+DX/QNljRDulF/+0zV4QyCr49aVo4H4tcbBuuYJqBlUuBAucXVR/f0sH5iU8gIco7UbEeS4tJIcK/Qbqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXjEE6HUTxl9lEL2LCraClTl6Ox0I7vSCeQYjUdahds=;
 b=IpmIvMwMHozr6WPkf/w2HNSqgWBH8guEtLKkrEczfg3INImVFdafnj4O8RX35srMBXdHwJyYR4DBuJUbxFXUtFE3UYtIJYbxwbQuQa5y8Zg4AJoyc5GCA5Ntpvy1ZfI/BUhsTQRZU2KD/gA2Ap2upN6oIcQv6g92yB82BD5zg2Q=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5656.namprd11.prod.outlook.com (2603:10b6:8:38::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22; Wed, 16 Jun 2021 03:02:23 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::d813:3260:1526:b63c]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::d813:3260:1526:b63c%7]) with mapi id 15.20.4219.025; Wed, 16 Jun 2021
 03:02:23 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v9 04/10] Bluetooth: btintel: set get_data_path callback
Thread-Topic: [PATCH v9 04/10] Bluetooth: btintel: set get_data_path callback
Thread-Index: AQHXXGDBSyqzet0naUma6YfeaF9t/6sVgPyAgAB9BRA=
Date:   Wed, 16 Jun 2021 03:02:23 +0000
Message-ID: <DM8PR11MB5573E150E4FF4B5F69FAC9CBF50F9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210608122455.19583-1-kiran.k@intel.com>
 <20210608122455.19583-4-kiran.k@intel.com>
 <DDBF23B0-10C2-4B4F-8296-8454CD8F7AA6@holtmann.org>
In-Reply-To: <DDBF23B0-10C2-4B4F-8296-8454CD8F7AA6@holtmann.org>
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
x-ms-office365-filtering-correlation-id: 30131cf2-eae6-4d3d-1035-08d930732a0f
x-ms-traffictypediagnostic: DM8PR11MB5656:
x-microsoft-antispam-prvs: <DM8PR11MB565636977B95E86DD255FD08F50F9@DM8PR11MB5656.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ko6+1/7GjNB+6EcJajLewQMKnQu1lw/JjgGQU23qu1Ly7bYIPukxE4GgitbWM4psR9iaBY2JpeNJZsbBJR7rGyy7Cj72757jmJBp2qtDnc0y2dkc6Cn1AK4DvpbVbUrgOYc0XNkEdomc8QBK0ICmJwuEPdPme2kA8fTHmKIR3OacUGk6FqlzXP89brQ5AFatQMm++RWxVJbKqGvLbVMKygDcWn9VtgTTFu4evR51jQGNZEx7j5x5PRek87YhyawHCusDKTgETkfrG02yoPu6nEaiuHqpYNSnaC49Bp858/Tf/qC460HMZiSjAm8miICPR4UzjrDXOE2S+SQFsSUNiGWBc+dHRUIgl6a3CkWD/uLlot6sEWcM4mQaUKBf/C1O5+v2nlT3/7yiJfeL/bVC66ra6IyOA7rbOPi8yHKxTbySrTPXpwjWDJAi/Q+nonJ894JXfqhrvK0XggQBEFZKylA6PIkSkWf3bg/FtapAZbTkY5raaUfDpJKdn3/tpbHQrG+WYQ4irnJALfhRYHwIA6/Qk/B/vye3SK2eZe+UANjfHEoNhZx3342zpsybbxPvY/c0Xut95dDuX4nLqp2eNhu4FZW1U3zxujI2bkJIFE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(376002)(136003)(346002)(6916009)(7696005)(8676002)(4326008)(2906002)(122000001)(26005)(52536014)(33656002)(316002)(76116006)(6506007)(86362001)(8936002)(5660300002)(66946007)(38100700002)(186003)(478600001)(66446008)(71200400001)(55016002)(64756008)(9686003)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?triKe+rdFleEkLg3CoNXosOoNwuyvUhaZzQvegRHybCtw6ePlWuYnVEJXZWe?=
 =?us-ascii?Q?4n1S8anM9GN5ZQ4a+Z1Oz2KSTMd6savPcRDp6fuT/tzp8k9w0FRdcGFh70gQ?=
 =?us-ascii?Q?+ZGnnk5LiPPdaEIhwsBZjpWrANJO9THqVc1mxicjr57Id4OEpE4f/x2G54Lp?=
 =?us-ascii?Q?z0S/V8apRRcG6xA3+gwgcEmCHZwnMCzdrdNUbXU/SYB808VwKwYJLZ7Qq0I6?=
 =?us-ascii?Q?ohS/o5n/SDJKVtMrdbVwMQ9Kb75aPdG2lf+5rVvPSAD0FD6xx5BomN7pCqqu?=
 =?us-ascii?Q?k3QIlzt6nenmK9FdNgg6pimPaD0rr3bhR/pVlXHYAtS8frRfNo0dtS0o6heS?=
 =?us-ascii?Q?sJqezCTh7kV0v+R5GjDNGHO9/V9Uj4bMo6gRrQhC4hp4vi00JnuBX+9Uzlnu?=
 =?us-ascii?Q?qGpWzwRnGxKv6sVJ8nTtQmS/5m8zX2mLetCVuqeDboxVIcLZ65rpbhYUN8Cf?=
 =?us-ascii?Q?LxiQ4JzywA+uzOBlMhbvLapptS7M3F7Fw+ZlASPxQjAHPhIrGVmk7CevVPOP?=
 =?us-ascii?Q?ADHxKD6ktnNc2iFjKr3qHzhBB92PIG1GjhRrvponfnxzWPYAd2Qn1reoT/Ae?=
 =?us-ascii?Q?fDOpXXFX5D9vAJYUbdolUETr9EVemGKSht1+AGfNrhXsLIZgsz/KwMkI+pT+?=
 =?us-ascii?Q?C7YJTUyhsdH0kSbejN6Yhc/QV2cAdOnOOQuAk+oY1ERKt/MwloLGemYd4sYE?=
 =?us-ascii?Q?k12c1a373u83sWDf+9yLkj1KAQjYb6IlzP6+AoY3QOZl3COgnBm+gn4H+pDE?=
 =?us-ascii?Q?xhJhDDqKBOgMu+kuiUMiOQrkSufiL02JTzEKPsgErOHq0cUaGsbRfPSrF1V2?=
 =?us-ascii?Q?bB3DPbAayRHw2/ixGU+eg2g2tOw9XuYI65C0tHK3InioSqTzTaCzMepPe89R?=
 =?us-ascii?Q?TL2OzEFThQU8dSoOkHCpPFW+b+Bdu1BPKTmlbvkX31aVxTs3ZVTJjEk4lrYQ?=
 =?us-ascii?Q?QzC9hW58KvjSwuK352rTJz4HivZ02lNrdC9EJZoyHT4vSFiXCiBDE6dq3rVT?=
 =?us-ascii?Q?wnZNHDV+/nTyYz+DAv2+m4EJ2GiP3XK7TTjHRPTGX6vzVTBuTKQ1XzB8PYn7?=
 =?us-ascii?Q?EAFvRfLUCrLKYbed3Ryc0EWbsQR9BNXXD2LO3KcC4H/fuu5+nVrxbS7t5Rl6?=
 =?us-ascii?Q?lXyRB25RrMc5dce7vsepqcvn4EbfaJgFepvVq/gsLIWbRHIPFaF04oqOMdVg?=
 =?us-ascii?Q?Kh49HKU4ueCQ20Mr8mGMdq/sDqCiSpcBn6DiNXkc3mle55ypmYq2uCowq4ZI?=
 =?us-ascii?Q?hthPRsu9oKx2fumrbwbRozkChedY/MnZHEyDqsQCjR4jK2qaTvjfgNOyqpBb?=
 =?us-ascii?Q?oYAuGJGRNT4jAATEX62KMSvR?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30131cf2-eae6-4d3d-1035-08d930732a0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 03:02:23.3632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smHaZLGq8zma9CeNxIqXh+cfGsto3FFXnHuA91GLM0ZW8e+fwQU4cKqRArmwBXq2UTcdNbpOrRHCU7w0LlkXbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5656
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> Hi Kiran,
>=20
> > Read supported offload usecases and set get_data_path callback if
> > controller suppports offload codecs.
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index a9855a2dd561..1e51beec5776 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2952,6 +2952,7 @@ static int btusb_setup_intel_newgen(struct
> hci_dev *hdev)
> > 	int err;
> > 	struct intel_debug_features features;
> > 	struct intel_version_tlv version;
> > +	struct intel_offload_usecases usecases;
> >
> > 	bt_dev_dbg(hdev, "");
> >
> > @@ -3008,6 +3009,13 @@ static int btusb_setup_intel_newgen(struct
> hci_dev *hdev)
> > 	/* Set DDC mask for available debug features */
> > 	btintel_set_debug_features(hdev, &features);
> >
> > +	err =3D btintel_read_offload_usecases(hdev, &usecases);
> > +	if (!err) {
> > +		/* set get_data_path callback if offload is supported */
> > +		if (usecases.preset[0] & 0x03)
> > +			hdev->get_data_path =3D btintel_get_data_path;
> > +	}
> > +
>=20
> I really wonder if this exporting everything single detail to be just use=
d by
> btusb is really a good idea. Would it be just enough to have a
> btintel_configure_offload(hdev); helper that does everything and be done
> with it. There is already too much Intel specifics bleeding into btusb.c =
and I
> think we need to correct that going forward.
>=20

Ok. I will refactor this to move Intel specific code to btintel*
> Regards
>=20
> Marcel

Thanks,
Kiran


