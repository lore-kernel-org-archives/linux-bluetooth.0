Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F93EC46467
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Jan 2023 15:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbjAJPw6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Jan 2023 10:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbjAJPw4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Jan 2023 10:52:56 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C176B3BE91
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 07:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673365975; x=1704901975;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sRv6Owc6prOCRsgSekkx+f5puPEA5KYUdOIV4GNFho8=;
  b=eq0M41NNMzma0anpaGR10jy4aAPAyEwFCkDqWyEvNIuTDhGmXN+fazER
   1XMQgGTwqYQ5tortrEh5DzKEAhPoKKpkuUKapdfAFmu5u63bm9irCsRAY
   xBBpxCvYT6MrCaW0GHS8fBRopYkz7g/0qMSUPVtp/w4jetInIzZgMlXyU
   6TRfOA7uq0StYkIPJxrIxgCh7Ci7CeT5U1rU6fZGDZZK/3eIwQfiK+qR2
   rijX2ikXM+vv3dfeJ584LvWcLznBfNzGTNkySWR4fOM1nlyYcepvo0cJa
   ujwfdFDd5tY6OLJWSR0fiNDaU0QuUsKxG6+ZZsUD9URUgZ1oTKsIsRAj7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="409415467"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="409415467"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 07:52:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="831047565"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="831047565"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 10 Jan 2023 07:52:55 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 07:52:54 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 07:52:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 07:52:54 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 07:52:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNLYrbhVlplt7nj4RdJxZnkq87gE+Z8JHM7N6oqzLEGAeQb9+Ysz33Ivu/qHmnzVuWv+jM450vnmtU0AFUGZnqffccS5d/ifx4kIPnt5wWhN4VhF7dNZ2GfztxVJJt+2LkVksGAWOjh4KYxBy/Aa57RjIkSQMGF1uh2aUk4LXVId992gr7RUZyfkBoOudapGJRUrWmxUNYXnYNVHLYNRwQH472yHUhAx1+DcOzaUTgKEsObHjRa7mHD3ou6qbGWw7PMdPcfm/sN0XG6JUxu0u3lEB35uJWyBi/AVaTRJXUiL8esoI2FHfLlPB3OscVRUtvYCExzI05IkFNXFFFjiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DK0ns/0MYi2BujEBvKkdXSp51Nl6hkB1QfgSHfGP/WA=;
 b=Y1JavMSqjETuyXhFKsSK+d64oLxiRp/+LGggQANPgypdOWciXzoFgkbi5RmAOEWWcuKj9bpuV+eu3HTOCbNhodevo0CENICTzg95OsTJqovXn4dHD93G2Iw5GGw+NrlDvJuB/m/+ggV5ApJumbJAzFCeh4I2W10zAwT13B2YjEGHTP2rYCd0QSIHaox2zRuVBBAhkND9N2fzixPxDgKtv1pyoIGxuvbLNXB7sPvBZJ5KNTjiT4N9HA1Z21/vOHVWILwHdYyU6jUbu+K5zWlDNCCOZ5oxv3JhYqIsUxibjVLLGzjQf0qh0HuO4tG+1T+eDx6q6Rn5ltXcsVoiD079qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB1829.namprd11.prod.outlook.com (2603:10b6:903:124::11)
 by IA1PR11MB7776.namprd11.prod.outlook.com (2603:10b6:208:3f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:52:51 +0000
Received: from CY4PR11MB1829.namprd11.prod.outlook.com
 ([fe80::1b:afe7:5bf8:fda3]) by CY4PR11MB1829.namprd11.prod.outlook.com
 ([fe80::1b:afe7:5bf8:fda3%8]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 15:52:50 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "An, Tedd" <tedd.an@intel.com>
Subject: RE: [PATCH v1] btintel: Add recovery when secure verification of
 firmware fails
Thread-Topic: [PATCH v1] btintel: Add recovery when secure verification of
 firmware fails
Thread-Index: AQHZJQsd5oySqL2vJESlHtyopJLAVa6XzMYw
Date:   Tue, 10 Jan 2023 15:52:50 +0000
Message-ID: <CY4PR11MB1829647413B7BBA865C57DCDF5FF9@CY4PR11MB1829.namprd11.prod.outlook.com>
References: <20230110155905.18203-1-kiran.k@intel.com>
In-Reply-To: <20230110155905.18203-1-kiran.k@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB1829:EE_|IA1PR11MB7776:EE_
x-ms-office365-filtering-correlation-id: 01f28ba6-36ff-42dd-342a-08daf322ba76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i7qA50EjesU61ts6mBU2yYWOnjXq0QkIlS7dCRy7/pwSpGYD//thjT36lr/R4v4oty97kAqxj7EK/iQ+ROwk+Oyc/2N585u/XAmrccKcRtQsrX1twLxGqZJ9/s95byrnMSMYQwYsEI4ltvo2M16DfGN9bIZYl7NAb8eWOp1+kG6/Os6y869yQ6eFfhWzaiZwBi5bcjQd8u2xwsXK/rSZKekyryFhc88QWPFR3QiB1sl8cUiNG1CVJzIqFx5Pnm4nh6Wesi/KboYV/F+yS0FydLtGVKZ/eaKXY0o3lfsyg4q544nbTt1Mj0CWj76AF/pQNTZwNoMyzBDQrcyE9TwmHxyMVbcUbNXgLbR/mNEm162D2n8XHL+uUuypuWwXIaNvTN5umoweazf7K6pgGGG1jfwXG8wC/jiV3915Y7FYdC2ayfk3VDgLKugEYj8IpFnTYwujIfq5Xw9W8kQI3D48O1aybmwthCwdx1TYm/wCvQqy9e/bXGy/oWkTPkdsAS50IQn1qkgQx+TDpOep7r+Z9EWrkQTanwzWjanzaEAG+cJQ43iW9JZaNj9E9RwUHSi+RF5fvuK31Dyq0mdTYrtFjemeR35fY0nU8/hh+l2N8XZHA3n9s5Tkogk9LXdJD8ePFiMqXsVUenrvOaAjgVDX7lQIXlNeu4BycalkXrYd7nmSVVxKw/gs1lJFwXKLdqmvCNyoWGqx0+YoeKPcSokDEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1829.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199015)(33656002)(122000001)(8676002)(38100700002)(83380400001)(2906002)(86362001)(76116006)(64756008)(66556008)(38070700005)(5660300002)(4326008)(8936002)(52536014)(66946007)(6916009)(15650500001)(66476007)(66446008)(186003)(55016003)(41300700001)(6506007)(107886003)(9686003)(26005)(53546011)(54906003)(71200400001)(316002)(478600001)(7696005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dbPnXjY+87Egy+H1WI+keaCEP2alGi1uu8/z2NsnQRQtmlB5JRO7BLEiuaoG?=
 =?us-ascii?Q?4gngnKoDZ2bnWj2LVO6YSJZ1I8ef/rxcQr2P2fMJOUcmG4v2T7KSTh+qLUsC?=
 =?us-ascii?Q?e7iSaMtL7Q2D1u9mYumspeGj5N7kXPUZAyP1S1M/RXKWathbKP1vvXG7bwtN?=
 =?us-ascii?Q?e0Z9Ui4Ij2SA9+Zs/DuVuH0DU+WIBgOdLaOG0JjucceadV9np8GP9lD4Ya23?=
 =?us-ascii?Q?Ub2RmxA6qrya0TdXJdpbxlBWnt58KzXw08BsY52cdv8QuHLoyKgGuUmQltn3?=
 =?us-ascii?Q?BKD4ogqRXogopMYynIcyMk8n8KKFvuquhulbFmAS7MCIHaFAW90CV1Mbkm1U?=
 =?us-ascii?Q?RMfJ+GwDVQ1ndce/fgnPdmcG/NJ8V8a309j7aC1nZNvEsO/WkF/lyTOncVMD?=
 =?us-ascii?Q?QwnYv8eIEIef4enek0jDK3YrCq//b1TMHegft8PoLvJB4DDCy2s++YNandjX?=
 =?us-ascii?Q?dDItOR1174SY5g1ksKdCI0g1U6TO/iPa73j0cgqpODdB/e6YCmfHjUjr0YDn?=
 =?us-ascii?Q?nsArq02xrVYRrVZP4eevFiiv0bxiMLSjgDOoKkoPy7XioH89VdBqwiDQv2pu?=
 =?us-ascii?Q?nUL1u7L/wNhf8JlkBnPF6u/2Ka1wy6i8/a54CMqgqIT3k7jAl6unECNj1t9O?=
 =?us-ascii?Q?xzHEgLDnVXl2EA210/uvq8koYEJF14AkWqg+BoJJlFSlg3kcsTSaNWmldyog?=
 =?us-ascii?Q?GhuHuKlrXfH1d1Zp2d7DdHBv4P9z/yS7UtRe8EepgaTg+MnE2pl5cs4xkpx6?=
 =?us-ascii?Q?nwrJLI7nBPuN5/d3kZDGKwBLG/sSI1aatv5b0ns6Rz5xlur8UTxsU4JhAjqW?=
 =?us-ascii?Q?3wbbp+3g1y0k7i9HNnLy2+oI9G/R0wZq4chTgAQkzWYGAUKjgVhL0dyD17yJ?=
 =?us-ascii?Q?78XRmRQ1dlau+u4KCOXjtV//ix6TAVewG53bntSqgsEDq0G1qPAg1jtxgTlr?=
 =?us-ascii?Q?95yJmbjGgO+RwOvMH18OdsTXpMZCafhZZF8kQ/Ttlt8QHU0mcJN39Ht95iWX?=
 =?us-ascii?Q?bC/M8TZzaoffmQT+O1J2k4GO3+quK4SbiBxORlZLHkuRyMcv/R1tKFP2khdx?=
 =?us-ascii?Q?OKr7EQ9YL0Rgf9RKkj6ZyXKjLNvWemy2QBl6EWZ8ZDThkkCCTts5w6mMa9Vk?=
 =?us-ascii?Q?WqFDDwdODhBeIunZs6uEyRYz38Y7pdirmgaO6iMn2Fax+mO2kTWUyVWIes3K?=
 =?us-ascii?Q?lJjhurauSwyTalJrw4P5ZtpNsihHcgTDbZGNIous2H6Td50ucCopjKjgdzZb?=
 =?us-ascii?Q?TpV2MxTFONdCzEuIyDDpiRqmCjtMkwCcpuQogh2yKFgfz2pYjChimI4dUhMM?=
 =?us-ascii?Q?+dFBdsqN50mfDeNRdF7YbEghmPkpR3vtEJNwGlINQ1mZggs/Z5cfZWhZJbAM?=
 =?us-ascii?Q?C7621A8bTNIBTK1lDZerAky2D2SeGtyMphMurQa0ygSqZ5ZNjMUpHBMKks3I?=
 =?us-ascii?Q?WyLRtlNNFgU47RTqMLgv2UF70PRA+roaqhcDe6H+nbISyZkUDna2kWAqxBxj?=
 =?us-ascii?Q?SVU784ZnAM3Eda7KE+i5eDV9IIW+5eQ4CK4l9gkH2P0L5FOu0JRkaKasSaw1?=
 =?us-ascii?Q?lXb9OVd3ICy23+Q4vjc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1829.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f28ba6-36ff-42dd-342a-08daf322ba76
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 15:52:50.8624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWdtsXFFe8dmRHj8+cJxvQSN82nGsXzZetgO4gSzlypWc1qVL1+//1MqWuvDQyIi/MPM1UHO0nPElqIiUI59Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7776
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Adding An, Tedd in CC list.

> -----Original Message-----
> From: K, Kiran <kiran.k@intel.com>
> Sent: Tuesday, January 10, 2023 9:29 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; K, Kiran
> <kiran.k@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>
> Subject: [PATCH v1] btintel: Add recovery when secure verification of
> firmware fails
>=20
> On warm reboot stress test case, firmware download failure has been
> observed with failure in secure verification of firmware and BT becomes
> completely inaccessible. This can happen due to a race condition in TOP
> registers when Wifi driver is also getting loaded at the same time. This =
patch
> adds a work around to load the BT firmware again when secure verify failu=
re
> is observed.
>=20
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Chethan Tumkur Narayan
> <chethan.tumkur.narayan@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 20 ++++++++++++++++----
> drivers/bluetooth/btintel.h |  1 +
>  2 files changed, 17 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c in=
dex
> d4e2cb9a4eb4..3f2976fb056a 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -1700,6 +1700,11 @@ static int btintel_download_wait(struct hci_dev
> *hdev, ktime_t calltime, int mse
>  		return -ETIMEDOUT;
>  	}
>=20
> +	if (btintel_test_flag(hdev, INTEL_FIRMWARE_VERIFY_FAILED)) {
> +		bt_dev_err(hdev, "Firmware secure verification failed");
> +		return -EAGAIN;
> +	}
> +
>  	if (btintel_test_flag(hdev, INTEL_FIRMWARE_FAILED)) {
>  		bt_dev_err(hdev, "Firmware loading failed");
>  		return -ENOEXEC;
> @@ -1961,7 +1966,7 @@ static int btintel_download_fw(struct hci_dev
> *hdev,
>  	 * of this device.
>  	 */
>  	err =3D btintel_download_wait(hdev, calltime, 5000);
> -	if (err =3D=3D -ETIMEDOUT)
> +	if (err =3D=3D -ETIMEDOUT || err =3D=3D -EAGAIN)
>  		btintel_reset_to_bootloader(hdev);
>=20
>  done:
> @@ -2153,7 +2158,7 @@ static int btintel_prepare_fw_download_tlv(struct
> hci_dev *hdev,
>  	 * of this device.
>  	 */
>  	err =3D btintel_download_wait(hdev, calltime, 5000);
> -	if (err =3D=3D -ETIMEDOUT)
> +	if (err =3D=3D -ETIMEDOUT || err =3D=3D -EAGAIN)
>  		btintel_reset_to_bootloader(hdev);
>=20
>  done:
> @@ -2644,8 +2649,15 @@ void btintel_secure_send_result(struct hci_dev
> *hdev,
>  	if (len !=3D sizeof(*evt))
>  		return;
>=20
> -	if (evt->result)
> -		btintel_set_flag(hdev, INTEL_FIRMWARE_FAILED);
> +	if (evt->result) {
> +		bt_dev_err(hdev, "Intel Secure Send Results event result: %u
> status: %u",
> +			   evt->result, evt->status);
> +
> +		if (evt->result =3D=3D 3)
> +			btintel_set_flag(hdev,
> INTEL_FIRMWARE_VERIFY_FAILED);
> +		else
> +			btintel_set_flag(hdev, INTEL_FIRMWARE_FAILED);
> +	}
>=20
>  	if (btintel_test_and_clear_flag(hdev, INTEL_DOWNLOADING) &&
>  	    btintel_test_flag(hdev, INTEL_FIRMWARE_LOADED)) diff --git
> a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h index
> e0060e58573c..10e5be7e451a 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -147,6 +147,7 @@ enum {
>  	INTEL_BOOTLOADER,
>  	INTEL_DOWNLOADING,
>  	INTEL_FIRMWARE_LOADED,
> +	INTEL_FIRMWARE_VERIFY_FAILED,
>  	INTEL_FIRMWARE_FAILED,
>  	INTEL_BOOTING,
>  	INTEL_BROKEN_INITIAL_NCMD,
> --
> 2.17.1

