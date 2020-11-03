Return-Path: <SRS0=oxy1=EJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD40C00A89
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 02:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236E22225E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 02:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="N9A3Fp2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgKCCFL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Nov 2020 21:05:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:62312 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgKCCFL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Nov 2020 21:05:11 -0500
IronPort-SDR: 5D8CGEz5l9s9gf+3BkNtWW7uGRFFi9lLWTRFNQxPWq5rKA2pCVtKTCfi5v7eNqprrr4fev223Y
 gQkO+N/fId1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="186826441"
X-IronPort-AV: E=Sophos;i="5.77,446,1596524400"; 
   d="scan'208";a="186826441"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 18:05:11 -0800
IronPort-SDR: tR+FiopQs34kBaczT0VPl+F32QR0a2uT220NTFwt2Pdi1iuJx0rY87AYjimYzdIVUvKuJ/rrUM
 IRNCYbmD2cog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,446,1596524400"; 
   d="scan'208";a="526884686"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga006.fm.intel.com with ESMTP; 02 Nov 2020 18:05:10 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Nov 2020 18:05:10 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Nov 2020 18:05:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Nov 2020 18:05:07 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 2 Nov 2020 18:05:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuA4+MYMgZsbrr1psD3E4/z613Vf87R18M4gnSHS0m2tyz0uivl94DiFuDJVVFDMDsRUTFk75uK22qiSXp32fggczDNtbvKT+o8l5JiWRWIbIyy3wSpc5UCj9/YU7Iv9G5Gq+RLFB43zTLBA341wIpGGfxZvwyIlKM6nlMvinhRuwPwwj6LEp8y7za8EFgsr/RSuZ72jqHdAtC/ik30nMc4guFy3wCFZn6kP8xr7Eav1HVsUx3lSYMZFcYxqSL3Betwqi9pIa9k4wwQfeYn/z5/tXQ8wlxKbVR7Xd5SfEm3AhTfZd0UkpRRHWNUmhXRA+cf35OGUCRILsGX+tG78/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7KB70YcbdwONFT6Io9P5zo/4K2OK1Zm+Hw8BVirjBs=;
 b=n3o/2p8ofnFSAnwHbBDwE1OOdxQdyNBLSF1vH1Pcj+tsLi2a27WrOOfXeQFwKcxXqTjhDnk+EMN93IEvV2FmrUQky0+abgYQasWcs0alfGSeohaDYugva4z/OYMMmNGdcV9jDgH+7UZO/3Iaj0nAv7tc6mIqnNjAk9su2GVNJE9RRPYrQKEk2RzulDZFIk7jj5FrRKYcR0XS671P+Bklzuwdkeg76wP3mYqNQanilq5GOnYyWOFg/i3XYslqODfc6T5S10DWWUsf8kyMclLaqBP5FmuJLxwUOYjXm4JcBQDbEkjjmP27cpl0O+ZeldaMLTbVHjDiQAXsVQzhatpUHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7KB70YcbdwONFT6Io9P5zo/4K2OK1Zm+Hw8BVirjBs=;
 b=N9A3Fp2lftHrrK7OSmU0XR3O6mIZGYofZGXqtIRfxmqwEO8zBM6FdJwx5doShc0E+HGVBHg1BecLzcn2LW0T14rjYpr9/z7FTI9tYu4IFPyqnkmvFgXoUFMtdi6xntJo8OKSYBXDqnTwew8KrRxrzTPZmIWq3ACFey5LfT1kTWo=
Received: from SN6PR11MB2703.namprd11.prod.outlook.com (2603:10b6:805:59::18)
 by SN6PR11MB2767.namprd11.prod.outlook.com (2603:10b6:805:5a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 02:05:04 +0000
Received: from SN6PR11MB2703.namprd11.prod.outlook.com
 ([fe80::cc77:c9c8:8d2b:bb35]) by SN6PR11MB2703.namprd11.prod.outlook.com
 ([fe80::cc77:c9c8:8d2b:bb35%6]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 02:05:04 +0000
From:   "Narasimman, Sathish" <sathish.narasimman@intel.com>
To:     Sathish Narasimman <nsathish41@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Narasimman, Sathish" <sathish.narasimman@intel.com>
CC:     "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "K, Kiran" <kiran.k@intel.com>
Subject: RE: [PATCH] Bluetooth: Fix: LL PRivacy BLE device fails to connect
Thread-Topic: [PATCH] Bluetooth: Fix: LL PRivacy BLE device fails to connect
Thread-Index: AQHWrccq7cFvyrOLEkOPldsCaL1JUam1r8dw
Date:   Tue, 3 Nov 2020 02:05:03 +0000
Message-ID: <SN6PR11MB27030B1A75144BAAD0AF247294110@SN6PR11MB2703.namprd11.prod.outlook.com>
References: <20201029074821.29950-1-sathish.narasimman@intel.com>
In-Reply-To: <20201029074821.29950-1-sathish.narasimman@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [60.243.127.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45439915-07dd-4294-a560-08d87f9ce10f
x-ms-traffictypediagnostic: SN6PR11MB2767:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2767F0629E80FA6013E2E7D194110@SN6PR11MB2767.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:392;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /cLiUGZjfmLNwnkFABfp0ofjHibbWUy574DR/AATADl2l71N6wLMJTxXuCgC3N1dqhgOmWBnPcaYVL80qBnU88Y5XpX4hfziaJUsydCnv0Tu3tUGtziddO3yiUSVKHlEoCHTD+FK2ODzKlsN/Xo4yP7icGX56UCGmnrbU31/T7ekyfJLt3QKeOPjK6ah73tZfRQPcfpabahzFwQgeO2X6R+yHO8Xo+3da/ldqjfpReqBvl764mqOL45CpcpqL54S+4KrV1KmyD3avQX1HT0b7qGD1MCDLfTLI7p013X8jLWjbWDgt4ZnNI7WGaWHP8xxAIs30J52K2/aBJs9+lelhiJd+dXYC31uJ5Z1MumPW8iQMzMVc5uX6TdvbeszaJsEaGKkpDlleIxMltdaUe8XKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2703.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(8936002)(8676002)(2906002)(52536014)(186003)(53546011)(316002)(478600001)(55016002)(5660300002)(66556008)(64756008)(66446008)(4326008)(76116006)(66476007)(54906003)(110136005)(107886003)(33656002)(86362001)(9686003)(6506007)(26005)(71200400001)(83380400001)(966005)(7696005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jdeoLZT4RgWXamkoakPqoku9LHCwK5WK/Lbkyq5MKceaBuQ3+CnACVYmruevMBDdlct8tuzQ58oWC6DTP8suppjynxODakkRofzAs/f6IOEzkr3hGPJ0mz2huaM65x4RDsnozemLVe4lu1oxbwhE5Z2eQcCMMa0sKbqQn5IH0+gmYN987ddnjwbzyrD8T5IEj+6O1114Mfw+blMju2f+MWWQae87P2458UGp3q7XFlM+g90IAY1axqplpzjLlV6zdbkqWpvmiAPEfc+CCToEZgkpz+lV2wjQN2ezDIqb2Q/FZrJc3llPrVHlHHOrAocVVy2LbvRFdaRY9fxTYHho9Wr9XUWjBsXoB4JZLJql3zNubal8eSh4FUds1Q7V4Am1cuKFXy8LnHowD+o7299W3EtX7/Faa+BSwMlS+gzrsK+dQfu9dyK8Lqz1RF4Yg26jdwlqnW/5tur7bBxJrWSLvLmKkJqafM0iYVp/74XxBv/wZRpEHNKEZ/OaV4U2LAXnrLtfUuR4yDO3590tm+EWC+It52J4dC/+g2qzu4CSPYs2d19kebY21+arfMl//8e+7C2sKPaNuqUhQ8sscNfxSve7AiCbpt+w1/eblEYB0FHarMB3mjpeny/57hfkhQ1qc9pIopVXjLXI4GBHY6SBpA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2703.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45439915-07dd-4294-a560-08d87f9ce10f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 02:05:03.8920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6aFO+YeN+b+P24CcjZeFXcisN7blWrySvsPKumUJ4G2eRe9hUdaXS2FrckG1FU5hmdYIHmqTBCFok6oBVK8TSAMhfgXMvKNSG2+xv1mqWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2767
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

> -----Original Message-----
> From: Sathish Narasimman <nsathish41@gmail.com>
> Sent: Thursday, October 29, 2020 1:18 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Tumkur Narayan, Chethan <chethan.tumkur.narayan@intel.com>;
> Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; K, Kiran
> <kiran.k@intel.com>; Narasimman, Sathish
> <sathish.narasimman@intel.com>
> Subject: [PATCH] Bluetooth: Fix: LL PRivacy BLE device fails to connect
>=20
> When adding device to white list the device is added to resolving list al=
so. It
> has to be added only when HCI_ENABLE_LL_PRIVACY flag is set.
> HCI_ENABLE_LL_PRIVACY flag has to be tested before adding/deleting
> devices to resolving list. use_ll_privacy macro is used only to check if
> controller supports LL_Privacy.
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D209745
>=20
> Fixes: 0eee35bdfa3b ("Bluetooth: Update resolving list when updating
> whitelist")
>=20
> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> ---
>  net/bluetooth/hci_request.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c in=
dex
> 6f12bab4d2fa..610ed0817bd7 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -698,7 +698,8 @@ static void del_from_white_list(struct hci_request
> *req, bdaddr_t *bdaddr,
>  		   cp.bdaddr_type);
>  	hci_req_add(req, HCI_OP_LE_DEL_FROM_WHITE_LIST, sizeof(cp),
> &cp);
>=20
> -	if (use_ll_privacy(req->hdev)) {
> +	if (use_ll_privacy(req->hdev) &&
> +	    hci_dev_test_flag(req->hdev, HCI_ENABLE_LL_PRIVACY)) {
>  		struct smp_irk *irk;
>=20
>  		irk =3D hci_find_irk_by_addr(req->hdev, bdaddr, bdaddr_type);
> @@ -732,7 +733,8 @@ static int add_to_white_list(struct hci_request *req,
>  		return -1;
>=20
>  	/* White list can not be used with RPAs */
> -	if (!allow_rpa && !use_ll_privacy(hdev) &&
> +	if (!allow_rpa &&
> +	    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
>  	    hci_find_irk_by_addr(hdev, &params->addr, params->addr_type))
> {
>  		return -1;
>  	}
> @@ -750,7 +752,8 @@ static int add_to_white_list(struct hci_request *req,
>  		   cp.bdaddr_type);
>  	hci_req_add(req, HCI_OP_LE_ADD_TO_WHITE_LIST, sizeof(cp), &cp);
>=20
> -	if (use_ll_privacy(hdev)) {
> +	if (use_ll_privacy(hdev) &&
> +	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY)) {
>  		struct smp_irk *irk;
>=20
>  		irk =3D hci_find_irk_by_addr(hdev, &params->addr, @@ -812,7
> +815,8 @@ static u8 update_white_list(struct hci_request *req)
>  		}
>=20
>  		/* White list can not be used with RPAs */
> -		if (!allow_rpa && !use_ll_privacy(hdev) &&
> +		if (!allow_rpa &&
> +		    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
>  		    hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type))
> {
>  			return 0x00;
>  		}
> --
> 2.17.1

Gentle Reminder

Regards
Sathish N

