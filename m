Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25AFC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 17:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9AA21534
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 17:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="oSMwrXn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgGBRMi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:12:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:60985 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgGBRMb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 13:12:31 -0400
IronPort-SDR: TdWHlBp//X+yXbhPyvjtBYEUldZ0/t5UYGEbPGeA63TyljAfSghAqCNKFvW/JEXhOdGD/irLbD
 TgZmDKHjU+Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="146057739"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="146057739"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 10:12:28 -0700
IronPort-SDR: CRaXBcYpNSNnzALPYcDthxnoGUuqbnzsQ5mEbBVEz7t3/N+9GqF7JVgT/vwX/t2ckW1Mq/k+Km
 gzAcGy4Qx16w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="295961668"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga002.jf.intel.com with ESMTP; 02 Jul 2020 10:12:28 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jul 2020 10:12:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 2 Jul 2020 10:12:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIcDitTn7PObwoeAa7y1M8g+9hGa13VouXIVtpzteZIJ4qEX9wBp8bT21dgOMki/WyuWpngLbdUz6jjd8CIbQiY6ijwClQ0aX6heLjq1vzF72qn7lEtRQ2XgGR4Dzf5K8+4LHpK4nayvfZRKFPUu5wsHZj/nztumLwLCSl4qzS2V5m8AVVkHqtiFyVMrF1Ye55EVr/8asYmNipNuOTZKsdarfocWnXNipzhKg1mRCNKZTdsPCLqVfDHDZB3QVe1InfeVkAx6vRItEoyg4zJ2PwHAS/K8gOZDKDjMYySY1gExjklkcWPiC41Qi91o/Itb8h3+ddwJoCW0+hqLXg3XQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QwE996iYUojjzuErdA89dNQTCBB+5Ok/2gVElc7wFI=;
 b=gTjmHtUK59/+Q5ke7blHaUlKYad3q1NFO/JEmMjzA5naR1wtS+7aer+B/jwyYpz1apQy8VdRZrZElJsw9/GEBWKGeTT/i+TdgaemkqdDBVCTdM3bLa6Xyhzfrz681sViZJo5IQ1EHyD8k0umh6a4mtoGQ4FAeIo4ZVzb+HFw0myeLvc9FfMnV2broQ2nRh99RA443IqcjZT5M7X2v+6tpxzyPkdHGH7eZD5Ni/IgYohJFP7BcuN1jKHSTf6S8KLDcPW7eK8GE1dCqLAcTOHP48krzwCHlG5u3vYi32FjdxmEfp5iRI2NPjz8mjkzw/Hor/d4+bqSjLmNPEuMKN+ECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QwE996iYUojjzuErdA89dNQTCBB+5Ok/2gVElc7wFI=;
 b=oSMwrXn547Tft4W9FTGG2uNnBJujYGZNXK/wHskSaKwrdkSB6N4M9a8YyxL6CVAydAagsrw8TGkna3/PqwIFVsp9bZLJ/5DbUmHgxAoWirvmxi3ppZdqj1VOq8G1pL27JaDjKTXgGr1FF3yuagXjSk+rQd5BT44J4v49XjrYSuc=
Received: from BYAPR11MB3141.namprd11.prod.outlook.com (2603:10b6:a03:8d::13)
 by BYAPR11MB3656.namprd11.prod.outlook.com (2603:10b6:a03:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 17:12:23 +0000
Received: from BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::9ce5:c8f4:581b:9d9f]) by BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::9ce5:c8f4:581b:9d9f%5]) with mapi id 15.20.3131.028; Thu, 2 Jul 2020
 17:12:23 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "kiraank@gmail.com" <kiraank@gmail.com>,
        "Bag, Amit K" <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: RE: [PATCH 2/5] Bluetooth: btintel: Refactor firmware header download
 sequence
Thread-Topic: [PATCH 2/5] Bluetooth: btintel: Refactor firmware header
 download sequence
Thread-Index: AQHWUGikJG8ZDOrkEUGU3i8Ku3Xo3Kj0R9GAgAA+jQA=
Date:   Thu, 2 Jul 2020 17:12:23 +0000
Message-ID: <BYAPR11MB3141F7C82AA1D4A78A8A1AC2F56D0@BYAPR11MB3141.namprd11.prod.outlook.com>
References: <20200702120315.26768-1-kiran.k@intel.com>
 <20200702120315.26768-3-kiran.k@intel.com>
 <8040CBA1-AF50-43A1-8314-4E44E4F27173@holtmann.org>
In-Reply-To: <8040CBA1-AF50-43A1-8314-4E44E4F27173@holtmann.org>
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
x-ms-office365-filtering-correlation-id: 6a4503c5-651c-4fd5-a2be-08d81eab162c
x-ms-traffictypediagnostic: BYAPR11MB3656:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB365665B201669BDC08914CEFF56D0@BYAPR11MB3656.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RpJxg7ovTqggl6YV5ebnqPjOs1DhVcwjDUUXtnckoWUOOzSCp4A6emmmzrS8uJeIiTGZbL70OAGekPmqRscaHrl/7qNgmlvO6c48T7haMinqNTt0yv3odOtPixJL0u3nozhB63TL3ClxKW2cYP4J5+QOUGVYj8pZ2ddMDfRvwn0PB8aRelr5FY47jgh+Bmo+WDCAvCNK2X7xvlXMKCmq+wIB/TnwzwnymATGY7rCr30fLuwaDuOr0zdpy4lRHixhpCJ+nWpfz7TtSBCOZSduauykqm0h+RsS8tU30tptQUEWN4CFShZoFYn3Qsn9lxsLe1guCASw1q7rbDCR1UA5ZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(8936002)(64756008)(76116006)(66556008)(4326008)(66446008)(66946007)(66476007)(83380400001)(8676002)(7696005)(33656002)(478600001)(55016002)(9686003)(54906003)(52536014)(316002)(107886003)(6506007)(71200400001)(86362001)(186003)(2906002)(26005)(6916009)(5660300002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: usD3W7JwpOiFlwg4yjty0Xfq4tRxYlkjPKdyS3mnb/wKeqNZAEEImdW0S8KLSJm15IP4M5fkwEsfnMKiyveBCN3aoQsafTHqq1F5zo4t5IrVvIWVdpxtmhF31JIVtOeSVCeHv/9hxUzMolNjxn2pa5+nrdZw0t/eqK7t8wC1e8yVu+lvT9h6vT0y0BCsbEk9TqYwLzVrVajaHsAFFIffCcxHanPsaRpRvxIknyfNaDzkueXrZR9xSQx460lEK5y988aRBTZ2lz4Z3nseQ9VdMN4Poyq2RdFLR11PCfiE2sojCVMA1MkbFgjJHQAwBqWMY3+5ZY5vlR/zcZTWoTTGDXcpHducZbDVH4rjBYk4MsgdaSudUkHLJ9EHE2T8Bu/DhDeQBFKkrzBFNqj+U8Jx1xmV6AhZUMOq56QpY3XXfYojGV3a64YL4b+RyKz3325HyhCMjJyYX7XsMYq5Wijw9sWlftrt7fP3WShzpTlqtD4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4503c5-651c-4fd5-a2be-08d81eab162c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 17:12:23.1061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1uT0wECCpVtHWiJxt8wlA+fqe5yLNE9npw4K7AUHr6TQVXS/DReA/TSo5HbbG9uGs2Aycov2KRP6vIDfkEpfwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3656
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org <linux-bluetooth-
> owner@vger.kernel.org> On Behalf Of Marcel Holtmann
> Sent: Thursday, July 2, 2020 6:56 PM
> To: K, Kiran <kiran.k@intel.com>
> Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>; Srivatsa, Ravishan=
kar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>; kiraank@gmail.com; Bag, Amit K
> <amit.k.bag@intel.com>; Raghuram Hegde <raghuram.hegde@intel.com>
> Subject: Re: [PATCH 2/5] Bluetooth: btintel: Refactor firmware header
> download sequence
>=20
> Hi Kiran,
>=20
> > Move firmware header download code to a separate function to enhance
> > readability and reusability
> >
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> > Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> > Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
> > Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> > ---
> > drivers/bluetooth/btintel.c | 21 +++++++++++++++++----
> > 1 file changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index dea96c585ecb..1c820c187421 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -646,12 +646,10 @@ int btintel_read_boot_params(struct hci_dev
> > *hdev, } EXPORT_SYMBOL_GPL(btintel_read_boot_params);
> >
> > -int btintel_download_firmware(struct hci_dev *hdev, const struct firmw=
are
> *fw,
> > -			      u32 *boot_param)
> > +static int btintel_sfi_rsa_header_secure_send(struct hci_dev *hdev,
> > +					      const struct firmware *fw)
> > {
> > 	int err;
> > -	const u8 *fw_ptr;
> > -	u32 frag_len;
> >
> > 	/* Start the firmware download transaction with the Init fragment
> > 	 * represented by the 128 bytes of CSS header.
> > @@ -679,6 +677,21 @@ int btintel_download_firmware(struct hci_dev
> *hdev, const struct firmware *fw,
> > 		bt_dev_err(hdev, "Failed to send firmware signature (%d)",
> err);
> > 		goto done;
> > 	}
>=20
> Here should be an extra empty line before the label.

Ack. I will fix it in v2.
>=20
> > +done:
> > +	return err;
> > +}
> > +
> > +int btintel_download_firmware(struct hci_dev *hdev, const struct firmw=
are
> *fw,
> > +			      u32 *boot_param)
> > +{
> > +	int err;
> > +	const u8 *fw_ptr;
> > +	u32 frag_len;
> > +
> > +	err =3D btintel_sfi_rsa_header_secure_send(hdev, fw);
> > +	if (err)
> > +		goto done;
> > +
>=20
> Scrap the extra empty line here.

Ack.
>=20
> >
> > 	fw_ptr =3D fw->data + 644;
> > 	frag_len =3D 0;
>=20
> Regards
>=20
> Marcel

Thanks,
Kiran

