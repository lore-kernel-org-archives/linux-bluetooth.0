Return-Path: <SRS0=ITyu=7V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088E2C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 12:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C295D2072F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 12:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="XmPxVlFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgFHMic (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:38:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:10246 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgFHMic (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 08:38:32 -0400
IronPort-SDR: /9CfQGRtO74Eg3q1nxAo5lKguDFTU8QKXz4TWPRXM8/I78ATX9fkdXCBFtZ2BhmhnN40YY+/nO
 RL2QwnopoFNQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 05:38:30 -0700
IronPort-SDR: Z4dr5mS1HcJ7h5cofT/23RbibhlIqzv5+7U2vkBTrmicrmrNUTZHbFgEc+hWXya18VRF5gV2Er
 8LJEW8ivlE6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="288457610"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga002.jf.intel.com with ESMTP; 08 Jun 2020 05:38:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 8 Jun 2020 05:38:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 8 Jun 2020 05:38:29 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 8 Jun 2020 05:38:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 8 Jun 2020 05:38:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+X4GXAZX0KltLMnz8/BpoN5iVuZzQ9nxPV6jVpcZJgOFH3vj6/ktX+HhxN5FDIlYB9yUXkzPzYzd5iMNsx8lsScwv4TCAsGGPFIeo36SPFYBGuwX+NXdyDMYjKwTXYAbBpMPx6L34yBF8c9keLfa7TxViTA4iBYvDJZl+Rrfy77EIzmIrcn/GOTNex7iaoZNa20gXIEaMM+cKvyl3gQvOAlchQaobPbLonJSmumC7KYKUV0cERpqB4ZKkojHPKQT6PC3N7wN5dbvZammwoeHRv7UP+x3Rsfym2g5Rc1O5L4p/5SWZWJJVY5K1rXDxnx6G8O+pFNjQnpSvKr2IGK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY30XDFv6WX+1P+AXSkLfUn5sve5i0tvi8tmWZXxetE=;
 b=oV5T3ZDzcjO9zp512NUu4v1ZUZa5iOEbdIxlz84Oa4tE7a/rSbWRM9heRLkBXFKLbcQfmnP3oTz2wWrxt+BGG18xAKB+dGKSvIW53ZWOE16csu2EcoKGoSIPEdpJA/AL6afoRQ1S3TitwknsIo7FIF/YClwCGEmu9yC1Ky7uNl/NpNBMe+BuwiFwOLpFEd9tYokiDp4XJt0CWqdV2XGpUOY/pMRQhLsJF6MwFETzyDWDL85nUVIdW+zh9wIvksRjXzUcWQdsx0D8JHqE/CDQVH12Y3HgmWqtXNk+iLGukvQRd6VHgMn7551JE+6vz5J4MwVhLaBEA7A+1cgWhg1mNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY30XDFv6WX+1P+AXSkLfUn5sve5i0tvi8tmWZXxetE=;
 b=XmPxVlFzB9tuBdP2GSmsNhFp2zMKvAcaGWRuDfj7CCMLnuOlvd4ZVm1TSSHvUYJhZPhiLrDI6i0q9cNo7tXv0QvkOF/Rh2k0KGG3SlV7JAIrlrc4RsKj9R9Ym563zXAydZbG0Xl+3xO8uSHk7szG9FSjR9dfGEGObXDZTggj/uo=
Received: from BYAPR11MB3141.namprd11.prod.outlook.com (2603:10b6:a03:8d::13)
 by BYAPR11MB3813.namprd11.prod.outlook.com (2603:10b6:a03:ff::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 12:38:25 +0000
Received: from BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::9ce5:c8f4:581b:9d9f]) by BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::9ce5:c8f4:581b:9d9f%5]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 12:38:25 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Ps, AyappadasX" <ayappadasx.ps@intel.com>
Subject: RE: [PATCH v2 1/2] Bluetooth: Add support to Intel read supported
 feature
Thread-Topic: [PATCH v2 1/2] Bluetooth: Add support to Intel read supported
 feature
Thread-Index: AQHWOY/UABzTnqYEH0Kk/r9P5cMu7KjHKYkAgAeFqZA=
Date:   Mon, 8 Jun 2020 12:38:25 +0000
Message-ID: <BYAPR11MB314161FEA3408E8CE560AC5CF5850@BYAPR11MB3141.namprd11.prod.outlook.com>
References: <20200603101523.12547-1-kiran.k@intel.com>
 <E929E0E0-E28A-4874-B168-A5E03C40F1F8@holtmann.org>
In-Reply-To: <E929E0E0-E28A-4874-B168-A5E03C40F1F8@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.79.103]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4eb0b82a-bb1f-48a1-1069-08d80ba8d683
x-ms-traffictypediagnostic: BYAPR11MB3813:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3813A42D291BB9F3571A0197F5850@BYAPR11MB3813.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oRYB1KSULgHvQ/tTw9Y3nd1SxhsnFHoO9RCyKvG/ZoBSKdaDRpXXQQTyL5NgocddreIjQWI3lJmnJyfbmwUkwZdhydY3suBuhdP1xnmjGLA/WnHtW/6NR9SGQMGtwtJHCjwJDQB1YQxsU/F90nL+vjwadSUgrGYie4ELwcnhq1n6NPZUD7SMDldeIJ+/t/SPS4XNl6pgt9ia4MYtWr52IKX56i/rd3YPDiC6W7neY8pxteB8QZtEp8JfwhX/zS0i0gJDxhxGc3W8RitsvzwrRHdY2D5TwxZntdj7vqH73750468pkqs9XmaCJf/43agMS9g3b19T2cOd2MD+1jYcqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(396003)(39860400002)(366004)(4326008)(478600001)(6916009)(33656002)(83380400001)(54906003)(2906002)(316002)(71200400001)(7696005)(107886003)(52536014)(76116006)(66446008)(66946007)(8936002)(55016002)(9686003)(6506007)(53546011)(26005)(86362001)(8676002)(5660300002)(66556008)(186003)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ICw+YqWTjS/l+HB5g5bOuUbOWxJXMn00+raC1B/dEfEL3XVdwQU620jMsb0jwNx+HMnlDR7put7cyr1GNNhEF1zpKnZxa1x7v2/XO01/G4O2ap1Jwrq6GAq3rlA/AisnpR11KT6cbEwggu0K8mdxc/d7wQpdurBwwG/xr0LfeQ1YxeicuO6X5b3Ycila2n6N93vsPF2+BfKm8TRiq2SPBB7I5Y9RdNYnpOru9FzqziKvr2eq1wQTi/J/RmmjVcBhLw33KX0La9bdJE8uK9XncXgDcKkQ7BzQf2DcvacfJ37LQTb95c6T3yF5JED5mJroK8S2UmBr3oHtmTynbBrWSUixw7zxDbogEfUHclLtWTZSrzHKlHBbPBxo+EQ9gJYo87H8WO77GpPgp1cq63ciPR1LwTj6FZssRWELiq5lwizGmF0SAUzMFJMSKvIJ9ubmnvs5ajGt4fzObCYnRcc29rHcAhL0+MFsigW34wv5UdZRrL1DS8Urk1MshTK0Yh/S
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb0b82a-bb1f-48a1-1069-08d80ba8d683
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 12:38:25.1771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0DOvywy6AdT0jZ6f2AqZimdN0Y3W/ZCFInr3ePtX3NQejBnaeqtyudKWXgZbObKe8YwAzNdjG5wxWPItZft63w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3813
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org <linux-bluetooth-
> owner@vger.kernel.org> On Behalf Of Marcel Holtmann
> Sent: Wednesday, June 3, 2020 11:12 PM
> To: K, Kiran <kiran.k@intel.com>
> Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>; Srivatsa, Ravis=
hankar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>; Ps@vger.kernel.org; Ps, AyappadasX
> <ayappadasx.ps@intel.com>
> Subject: Re: [PATCH v2 1/2] Bluetooth: Add support to Intel read supporte=
d
> feature
>=20
> Hi Kiran,
>=20
> > The command shall read the Intel controller supported feature. Based
> > on the supported features addtional debug configuration shall be
> > enabled.
> >
> > Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Signed-off-by: Ps, AyappadasX <AyappadasX.Ps@intel.com>
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > ---
> > drivers/bluetooth/btintel.c | 34 ++++++++++++++++++++++++++++++++++
> > drivers/bluetooth/btintel.h | 14 ++++++++++++++
> > drivers/bluetooth/btusb.c   |  8 +++++++-
> > 3 files changed, 55 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index 6a0e2c5a8beb..09e697b92426 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -754,6 +754,40 @@ void btintel_reset_to_bootloader(struct hci_dev
> > *hdev) } EXPORT_SYMBOL_GPL(btintel_reset_to_bootloader);
> >
> > +int btintel_read_supported_features(struct hci_dev *hdev,
> > +	struct intel_supported_features *supported_features) {
> > +	struct sk_buff *skb;
> > +	u8 page_no =3D 1;
> > +
> > +	/* Intel controller supports two pages, each page is of 128-bit
> > +	 * feature bit mask. And each bit defines specific feature support
> > +	 */
> > +	skb =3D __hci_cmd_sync(hdev, 0xfca6, sizeof(page_no), &page_no,
> > +		HCI_INIT_TIMEOUT);
>=20
> Please get the coding style right first. We have plenty of examples in th=
e same
> file on how to do this.

I have addressed all the issues reported  by 'checkpatch.pl  --strict' and =
sent updated patches.  Thanks.

>=20
> Regards
>=20
> Marcel

