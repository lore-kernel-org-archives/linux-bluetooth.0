Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10092C63697
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 17:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD07720728
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 17:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="p3ipvKpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389075AbgKWRYp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 12:24:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:4966 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbgKWRYn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 12:24:43 -0500
IronPort-SDR: Kwkdh89c5tj2TW4esmtdlL64vi5lyoTRIMxVK/1lz0NCKRPEhHZuNI+P6QHvEnxWzwd78BKfhT
 dwrGm4mSGLTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="151067093"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="151067093"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 09:24:43 -0800
IronPort-SDR: 7luJT234VfTuZVirhgnFdmFTtYjBEAtxXrBw5iFYdSFVg9LdOvZtfvkc65ni4xTcHSbt4QLGO6
 ml4/T4Dfk4ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="536170307"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga005.fm.intel.com with ESMTP; 23 Nov 2020 09:24:43 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Nov 2020 09:24:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 23 Nov 2020 09:24:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 23 Nov 2020 09:24:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULMxUv1r8wAvBNJvFWFg/G2FXB1dGWjFog25mMbr2dPSqMyXfob26UWui5t/2fBBW7H4PoSsKB7rVyXi0OJG3d052w9hvEjoogwMoHWAvsz/aOftgWRCjThbacBAK+CtToMiDvjUSRn2F3GVl0tOR3RakW09XntYeX8M734msJHTBjmzd5Vc9g8Gi+5x/7khCRHgbKL/eS90NOmxCTUq0/RyJxhhAnLt046HNaodH+mfMhvpTSSKVygXGU5PKlSAZULlFFuEoU770yhEOPcEeor9nvC3dTJhHhJfmvptKzeiNpm1+5buXTTspQch0xiimFC/XGbF6rPJ2LFPukOiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKorQ+8jeLpelipX6msVjMa2+sX0sI1UUr1N9rmfkBg=;
 b=c/RTjkecLq/FAz7/ZdSUDQZBg85InWR6SDLANlpuvzsExzuQuxAl3tKdbMF6hNKv/ZEEeYr2t4PLUT/hIqBhdZwkvmvR6g+YV/OsjA4RTADPcCmshRftbhQqlpS5Xw/1tw1J7RoPhmzUmud+NXy/PxxOcKo+PSddt5Ki4+HtaW0Eohe2SZ1mwNWKmRVMtSCNsWotfdMVzhwByrlfTsX3nWCQvVjzbyGtVOiwH7t2zfmBj5ZQwA1N0Gxi6Svr7Ejy3KLsl4qw/sr5+UgO+UMQSL9RZkAYaK4+byh17O8EyCUCRiP90+C1eRvNmVtAtHmyVJ0lByGERytXxyOBTgZTZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKorQ+8jeLpelipX6msVjMa2+sX0sI1UUr1N9rmfkBg=;
 b=p3ipvKpacfA679dDnERVWxDkPLv7tL5LmM3Ge2KvTCMBQq4LaL4ey7PiUYfoHiw6abWKUZfWiTe2OP+AVOdLvEEBzuoekQyDOB77CvbEQPmBwJefbyN+AXJThmLZXyiHW5/E25OUeutIjXbpmpSq3b/FHnPeKp7N0uU4I840KDw=
Received: from BYAPR11MB3141.namprd11.prod.outlook.com (2603:10b6:a03:8d::13)
 by BY5PR11MB4038.namprd11.prod.outlook.com (2603:10b6:a03:18c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.29; Mon, 23 Nov
 2020 17:24:42 +0000
Received: from BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::5964:ed9a:9b87:a984]) by BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::5964:ed9a:9b87:a984%2]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 17:24:42 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: Updated fw versions ignored for Intel devices?
Thread-Topic: Updated fw versions ignored for Intel devices?
Thread-Index: AQHWvsB1fgDvuKgee0Sd1H46GdMnyqnVnI2AgABevJA=
Date:   Mon, 23 Nov 2020 17:24:42 +0000
Message-ID: <BYAPR11MB3141B751152EC960E746D9A9F5FC0@BYAPR11MB3141.namprd11.prod.outlook.com>
References: <0011e099-4ab0-4705-de1e-cb03953f11ef@gmail.com>
 <17CC90CE-CA5F-40B8-8C07-8313A35E944F@holtmann.org>
In-Reply-To: <17CC90CE-CA5F-40B8-8C07-8313A35E944F@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.171.222.146]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e792f362-dc26-4b04-d303-08d88fd4aa10
x-ms-traffictypediagnostic: BY5PR11MB4038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB403836ECBCD9E70D784CAA75F5FC0@BY5PR11MB4038.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U3izKRXkF4ExBJQ2hyYSoXWl+MID2//1tGxoOtTqWDaVnwBAu9ScgsO7SN4tivuLbZ+7KUbOnIckiqDHgh8UfCZoCBvFUg3mdBITeMz5QEsm0l4cvUppycAt1jVWaxKFjutvF6DJIhw7Hw+66Wiy9Urn0zPEMpLI99AvsDshghhgLdrcCQK8JvrPESDgMduBCnVhok26FCY4MyYMtsifNHuquBupd5uv54gOXat0hJf5/1VYhd3/b4PHADujewkek3u4fxEnmhme8UxZ06oUMvaUOhDJ8U2AuDwcpHRAfDq16BNpv0LqOJebTIK/4v6Lbls8Bpwlw1i7s0Keh8Uhlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(2906002)(8676002)(8936002)(110136005)(316002)(83380400001)(26005)(186003)(86362001)(76116006)(66946007)(71200400001)(54906003)(66476007)(66446008)(64756008)(66556008)(4326008)(15650500001)(6506007)(53546011)(52536014)(7696005)(478600001)(5660300002)(33656002)(9686003)(55016002)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1OvmWd24RuZ1FquAnWS+kfmp+sq6XfeDNf2DY1cw08uDSWaGX3rmTnYIPSc1T83YjdGC6t3bKHYEXkQK03HP/SLiL/mnnEQIqROEmdoAmzTLMsrjgYVT0qcMpIcM1KAFE/P/lyOVtJvgrT/M9fffn2FTr7Nqz6cw2TWar+YuGVEsOM8yCO6VMNNFoSIlsWlEvMLZoS/Vn5rjH05O22zeI8VTeiIvEZVczkb4YCdZ4cQg+6X1S7B2SkoFsbHCqVwn22YWSRK9P83HzNpyKvoc9bxdepqMVoZX62ypIsVXc0LMt77C9H0hMX512ZEdDWaSYiphgN0vgLofivE864Rl0JkRw4t1TA69NcMWn7GSAXOgFYhTMgkJxVDuHzILHxuqMxR6XnpECxs6SuAAKu492UFs1uvLmtuj2ktBjxgqzgNqfAer+2DCFRluUYGOg6tEypuD+Ez12HQVg5wiQGFA1nzjdZxkASBIIJu7kFJkyd4lMfyxslVUYy113sWMttlCChNidugd/CbJHFguVNB0aJM3TX4gzao1Ayw9aenlVkjsQPOxozVUtL5tlXP/ogaFIPePGZGmOrEHVY4DPQ0XPPhYBRNs8TVVlnYD36AZ6uhLKtBpyQC2GzwsE9yDNV2K6AtHM9srqgQVw1opqOF8L5ctDchbyQi69Nw5jqH2XOC33Xtbom3ngoRdzQFrvdH7KVfRxkzndMjtPgpWS9pUoGCM6tP1manvBMp6rNhZBergYRTryOdMYXxraduxbMdm9ohAuIuJ0cRDVqG2JMKZFEPe3K/8MiyiNC1/a71b/AxfPtH2NfPQWchlQrEXpgvBCHD1+M5R5I8SlQXxeLkfJAeUHKteI06uPddjljcHAff2gN4ENtGBtvPuou2W63wzyBuFjxLJmaUAEtROqvXc9g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e792f362-dc26-4b04-d303-08d88fd4aa10
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 17:24:42.1013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Glnim8pXd+CWVLy3rwDd2wwHSHkevalLsSszYF/rCiaW8QGbGrboGV1fDKDHB6Y+KP9MMhY0ChGuaLIafCv9fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4038
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, Heiner

> -----Original Message-----
> From: Marcel Holtmann <marcel@holtmann.org>
> Sent: Monday, November 23, 2020 5:08 PM
> To: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>; BlueZ development <linux-
> bluetooth@vger.kernel.org>
> Subject: Re: Updated fw versions ignored for Intel devices?
>=20
> Hi Heiner,
>=20
> > In btusb.c we have the following code. I interpret this in a way that
> > once firmware was loaded the driver will never check for updated
> > firmware.
> > Shouldn't the driver always read the firmware file available on the
> > system and check its version against the firmware version the device
> > has (and apply it if it's newer)?
> > But maybe I miss something ..

Need to check. If I am correct, the firmware images are encrypted and signe=
d. Need to explore if there are any dependencies to read the firmware versi=
on.
> >
> > bt_dev_info(hdev, "read Intel version:
> %02x%02x%02x%02x%02x%02x%02x%02x%02x",
> > 	    ver.hw_platform, ver.hw_variant, ver.hw_revision,
> > 	    ver.fw_variant,  ver.fw_revision, ver.fw_build_num,
> > 	    ver.fw_build_ww, ver.fw_build_yy, ver.fw_patch_num);
> >
> > /* fw_patch_num indicates the version of patch the device currently
> > * have. If there is no patch data in the device, it is always 0x00.
> > * So, if it is other than 0x00, no need to patch the device again.
> > */
> > if (ver.fw_patch_num) {
> > 	bt_dev_info(hdev, "Intel device is already patched. "
> > 		    "patch num: %02x", ver.fw_patch_num);
> > 	goto complete;
> > }
>=20
> if you reboot it looses its firmware and things start over again.

Reboot doesn't guarantee to load new firmware on all platforms as the power=
 supply to BT adapter will still be intact. Few platforms need power cycle.
>=20
> Regards
>=20
> Marcel

Thanks,
Kiran


