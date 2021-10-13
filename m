Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C02C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 07:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924C860462
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 07:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbhJMH5y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 03:57:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:15032 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238703AbhJMH5x (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 03:57:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="288246263"
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="288246263"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 00:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="592084198"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 13 Oct 2021 00:55:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 13 Oct 2021 00:55:50 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 13 Oct 2021 00:55:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 13 Oct 2021 00:55:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 13 Oct 2021 00:55:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPhXrf0gbeamnbMhZRZ6WaXSQb7jiCGTiTo/sW5TnHGFsgf2qALfrPWjqNMKakeh8ndquYMgLeANn7pAU3Kr8KzkAD4BQZPFbY5ewCeOMsPruR4rgrOQACy01S8bcpUOoFybGk6WZJYtTxzjBqTfROTs28x6I9ZP1t0+CcgmrpAleCihf+awWt+vfuiceKqAJ0FNJA6Nlq9dnwxATUfPR+CkGQkYSlF73mRR+njhTx7S6O0p2dbOnjx6LF/brwDQUnpEdvVmZO8TM4JW7Bb51a+oKD11MVcOXb6s7+kaf90htYvXjUrO0BSewHxdbLIhoUMM3DZS52fn0++i7SpGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMC6rPO2yyBdaENvzltCTg7w25ql5XoQoZ+EpsUnAkg=;
 b=Go5MX0Q8qBmvfizMBLH65ZdZsP4DcBKAKeaxbDy7IUxwhFS6bN4PPabKR/pfJq0NcOE5ui6wgwFtSXGjFTR2RiOZcwqxqNsDTYC8DM/ccipGq3Vn1aSq9zlE3Of3ZtzQOkbIYAKZMOzWw9ZO82g9N8urVa3N2+tnWzJTXEgFH+t9QeoGCT0dp96vPYeUtGKDYlY5HZrtX3RWLYkhO8vS7Ktkkg++pssfigO77pQq5mmfKJGHMmLNU8SNU8uAlKzCRQONFFHc5KEt2ON3Gq/7QmHZSIlZIN4PkCgz0al1gU8F8ZyPCtORYtec3WeS9Y+AKWWanTDCGP0Be3gPPxEEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMC6rPO2yyBdaENvzltCTg7w25ql5XoQoZ+EpsUnAkg=;
 b=EjEIzzNDdOUoWe9Pxjj5oujkx651CYBFrElly9voiutMoU1e5tvVyJxu4k6oDQfmi7+iR52EWkqJHsMHNa2/VXCvArOcFd/Wx8XtmxcIRqQJ7UMcrO057R3YROWXwZQYdRDDaE2Yadok8pKmtTCs1Kqk77Uov+eVeuS7oabzZqw=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5574.namprd11.prod.outlook.com (2603:10b6:8:39::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18; Wed, 13 Oct 2021 07:55:48 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::a974:b0e5:9c6:b9e6]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::a974:b0e5:9c6:b9e6%6]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 07:55:48 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "An, Tedd" <tedd.an@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel: Fix bdaddress comparison with
 garbage value
Thread-Topic: [PATCH v1] Bluetooth: btintel: Fix bdaddress comparison with
 garbage value
Thread-Index: AQHXuaBi4PrY9W41v0ul9TVX3EMhsqvFq4mAgACWNICAAM0YAIAIgV0AgAELt7A=
Date:   Wed, 13 Oct 2021 07:55:48 +0000
Message-ID: <DM8PR11MB55736DA45A8E0F5CBE390F8CF5B79@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20211005042613.9946-1-kiran.k@intel.com>
 <79B0A1CF-17D0-473C-A321-39E1BC291A89@holtmann.org>
 <CABBYNZL9f1j6sEcNm6B9ONg6yV=Pt=msuOd3Urb-0d-5vmm7qw@mail.gmail.com>
 <DM8PR11MB557322FB90F730BDE853E742F5B19@DM8PR11MB5573.namprd11.prod.outlook.com>
 <23272CA9-FEE5-4E66-942F-E66FA1E513ED@holtmann.org>
In-Reply-To: <23272CA9-FEE5-4E66-942F-E66FA1E513ED@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab1e13b5-6774-4ce4-4f58-08d98e1ede92
x-ms-traffictypediagnostic: DM8PR11MB5574:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB55744F47BBD1D84CF1603B80F5B79@DM8PR11MB5574.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eZYF66M6mHkrOoXYjde5HHw6GtatTJztj0hFeQU2RE2Dn9cg/g5KVUFxk42iJvs7mwXLdVpobe3TmjAi6d3LU0NDPQjnjsDNXyh0T08/5+PYanLXL7U79RzrD7cg5mAklTkHUz8EiFXQrHSemIr3X4YUtzyZrXcM3oQU+KxESwRQKEXktmFBGZLOeyM6WXyg+eFSFz0JWWy+aKSNdZpH1EnHkMEi51vmiXtaqIsT8tTsjm6Qykzl1YxhehZZBjFWnLxF/rOJTXjMSn4DquM851tUmwiCcMePLGqPu0tF2hpABrx5QYIhvXg3V9JAaPEFOzDyZiKyyWQKWLoiW7FjdNGpDrQQM/eqQbee74ETHF941YAclVdpoE0mG140TbE5WxAv0MDdhCVY6Akbm3AhAJGUTy70IAx9vJl2tYkLSfLPn6mZvChpSddjY3p2DmG4UYmP1D2lvsol1qsUhxsldUU1xo1GUQDJaAGddJF+/qdOf7MOSziHudkZTtgVst3JRlFl8YKmu/pPnj6ABf4igxyweEUBkx4KHSlSIpjIMw9G5eZNSAOP4LIoO1bGNmHc8uykK3JubJqZWTkVQxSrV7JirJJIdnf9Wn2G0RF++7G460DeUfq38JfkMeXFaknbaBhalvFe3blTxhnbF/1VZdgzvSkj7njcs50umoCMtw6v2w6Rnj+XWaB0GzvtC4GoFpVKuT4TJCRJiJh0M1ROvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(508600001)(86362001)(8936002)(82960400001)(66446008)(9686003)(26005)(8676002)(6916009)(52536014)(107886003)(186003)(66946007)(5660300002)(55016002)(2906002)(53546011)(83380400001)(38070700005)(54906003)(38100700002)(4326008)(64756008)(66556008)(66476007)(122000001)(71200400001)(7696005)(33656002)(76116006)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ODFELdvrw8Ia4pQOjsutIcR5o73HcH0yaibztbSiC/qgWqn16vDkYVyYd2F3?=
 =?us-ascii?Q?TZG33IzROz/GULS3KVOL2eePGXPJlX83U9FNl53V3ivGiUUDGUphZQY1vGXO?=
 =?us-ascii?Q?MpajWTarGxU7Ijy49ADs0dWOHX0xBosOCIUgUaZrFjve5PgxJE5DK97GOeng?=
 =?us-ascii?Q?kd4ATRjjqAgepdXwn7ZpzmqPO2/tWWc/yL74UdGTkHYO6XUGckXhVGLke+Ha?=
 =?us-ascii?Q?jqRXHORjsEiGyhIdZDapfwbUht4HEAyZ2t4U3NnprRFnwnNS7o1WojxsrGxE?=
 =?us-ascii?Q?lodvLQ54epyRAyoKIy+s2qjEaz+N0I3ZDyn0g30XHQQtpXhFFta6WkuQ42nH?=
 =?us-ascii?Q?BvqRtjjSGAm4eUja9GfV1ePlu6++Nx3AJWeebm9M9StXD1cVg9kLPjV/3Sme?=
 =?us-ascii?Q?g8pt+yvY9RPHopmpTtMuhRq+Umw415qr1bP93QucbDxbU+D8U30CFGC7h0dp?=
 =?us-ascii?Q?v59W3OoqgUwviWzhIJ+sTJd/dpVPoS+BPHgru2ijJZBonKM6rAWQgGOkXwmQ?=
 =?us-ascii?Q?HBWnQn5mCbR+fkazq+zjKHsntzWRApuKtP4lKBTZWzxggaKLLsPuYtBO/p6N?=
 =?us-ascii?Q?PVd43nNeKSj9XkzRwd9TI/axWiNvNJtX2MVhH9+T/Im34tOhKcIdd5uZS7hU?=
 =?us-ascii?Q?p/t3mgHUPuCKGoSrei54w364H7kinMEYYqkPen18pohpyQLNoEbLOOWpm5Hj?=
 =?us-ascii?Q?/U+0VQ5g3Pfw2TQTJSiRzqeGtrUEgQ+uOOKHPrmhP10+e1L0qe29XXIcRq6G?=
 =?us-ascii?Q?VU5UoG3Z72Q8eA8aPgGZx8YP9nQZE5gmxTA5znHPaXVOnt17PA34gP0GZ/BB?=
 =?us-ascii?Q?QgBtobvIVIDm8gcO42gkgRCHH53umvnafrX+QfVLnhh0rZBZwE0g+RHxfAN6?=
 =?us-ascii?Q?jxS5InxKEeNUh5iUmkShp6VxSxTFmRcgp7Qc9d9XQKc+iRUmfJNp9LkZgrjR?=
 =?us-ascii?Q?NC5zD/arsNDCVr6snSdHiaxFAwvZZ5V5/N3Mw6HU1STB0B+6eJgO/p12ir8L?=
 =?us-ascii?Q?+hyV6DKf91iF+3G4mGaW9TuOFpCTSp8FXgz6oRwamsaLcOsrv4ZvO/MSAJmr?=
 =?us-ascii?Q?qCH38hKfVcqV3K+VvXEXZDLeALCTC9E0BBD8uSXhI00syk0H7ALG+OJU/esw?=
 =?us-ascii?Q?vFG1YRW/h13wfYunXcZv98geZx7cc7Icie/Zo/9Sb8prJNCiArdgwMFRh29m?=
 =?us-ascii?Q?BIZY28X8k0M87l/4PrQPatzYpWPxVU7LNX1DPM+E7Kuf0TReHMaXJJKkeZh2?=
 =?us-ascii?Q?xJTcybLVu9SHS7W1TI1oYG/lNWdTF+4vXyqX5ZiXH1Q3q15FYv97Ecfw+fdx?=
 =?us-ascii?Q?4mt5ZllQKuiQFV/0duSicNQd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1e13b5-6774-4ce4-4f58-08d98e1ede92
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 07:55:48.3013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIGbyXsJgzVT6DYaqhVnjg9mmP04hzJDpz3UUj8Iakdpgdq5toQqYa/ZKMZ48gXSPBgMTBtoaFjfFc2Nx2hd8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5574
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann <marcel@holtmann.org>
> Sent: Tuesday, October 12, 2021 9:27 PM
> To: K, Kiran <kiran.k@intel.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>; linux-bluetooth <linux=
-
> bluetooth@vger.kernel.org>; Srivatsa, Ravishankar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>; An, Tedd <tedd.an@intel.com>
> Subject: Re: [PATCH v1] Bluetooth: btintel: Fix bdaddress comparison with
> garbage value
>=20
> Hi Kiran,
>=20
> >>>> Intel Read Verision(TLV) data is parsed into a local structure
> >>>> variable and it contains a field for bd address. Bd address is
> >>>> returned only in bootloader mode and hence bd address in TLV
> >>>> structure needs to be validated only if controller is present in
> >>>> boot loader
> >> mode.
> >>>>
> >>>> Signed-off-by: Kiran K <kiran.k@intel.com>
> >>>> ---
> >>>> drivers/bluetooth/btintel.c | 19 +++++++++++--------
> >>>> 1 file changed, 11 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/drivers/bluetooth/btintel.c
> >>>> b/drivers/bluetooth/btintel.c index 9359bff47296..d1703cc99705
> >>>> 100644
> >>>> --- a/drivers/bluetooth/btintel.c
> >>>> +++ b/drivers/bluetooth/btintel.c
> >>>> @@ -2081,14 +2081,16 @@ static int
> >> btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
> >>>>      if (ver->img_type =3D=3D 0x03) {
> >>>>              btintel_clear_flag(hdev, INTEL_BOOTLOADER);
> >>>>              btintel_check_bdaddr(hdev);
> >>>> -     }
> >>>> -
> >>>> -     /* If the OTP has no valid Bluetooth device address, then ther=
e will
> >>>> -      * also be no valid address for the operational firmware.
> >>>> -      */
> >>>> -     if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
> >>>> -             bt_dev_info(hdev, "No device address configured");
> >>>> -             set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> >>>> +     } else {
> >>>> +             /*
> >>>> +              * Check for valid bd address in boot loader mode. Dev=
ice
> >>>> +              * will be marked as unconfigured if empty bd address =
is
> >>>> +              * found.
> >>>> +              */
> >>>> +             if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
> >>>> +                     bt_dev_info(hdev, "No device address configure=
d");
> >>>> +                     set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirk=
s);
> >>>> +             }
> >>>>      }
> >>>>
> >>>>      btintel_get_fw_name_tlv(ver, fwname, sizeof(fwname), "sfi");
> >>>> @@ -2466,6 +2468,7 @@ static int btintel_setup_combined(struct
> >> hci_dev *hdev)
> >>>>              goto exit_error;
> >>>>      }
> >>>>
> >>>> +     memset(&ver_tlv, 0, sizeof(ver_tlv));
> >>>
> >>> this change is not described in the commit message. Why is that now
> >>> out of
> >> a sudden needed?
> >>
> >> I guess this is just to make sure the ver_tlv is initialized so its
> >> otp_bd_addr be set to all zeros (BDADDR_ANY) otherwise the code above
> >> doesn't work as it attempts to compare to BDADDR_ANY.
> >
> > Yes. If not memset, then garbage value is compared against BDADDR_ANY.
>=20
> since that is not obviously clear, the takeaway from my review should hav=
e
> been that you either describe this properly in the commit message or you
> add a comment.

I will add a comment and send an updated patch. Thanks.

>=20
> Regards
>=20
> Marcel

