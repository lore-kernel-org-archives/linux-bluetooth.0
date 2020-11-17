Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFF2C63777
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 03:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C185246A5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 03:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="K7Zk5J1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgKQDkn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Nov 2020 22:40:43 -0500
Received: from mga07.intel.com ([134.134.136.100]:44630 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgKQDkn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Nov 2020 22:40:43 -0500
IronPort-SDR: 29YYnAU2grFmA60f1bjNIeWd7w33bgRBvX2zPyUz0dS39tofMehB7lihfbFKUZ9moNaBaEb/vh
 1/88eBttXVFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="235007212"
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="235007212"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 19:40:41 -0800
IronPort-SDR: cOruwqYRqP0cZb3QReuHXGKkvVUngjPrkLoNWt05looc1F4MePRXPb+OqWuD78GSUW9IOYFbpO
 VKvOh+LDBc7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="543865035"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga005.jf.intel.com with ESMTP; 16 Nov 2020 19:40:41 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Nov 2020 19:40:41 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 16 Nov 2020 19:40:41 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 16 Nov 2020 19:40:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abSDs6PlzrQcFovcFGlPMitX1YSnGfCK8Z3eIs1KiUV1Mv1grkdnCk/k5251J2rF2xPkGVfgLjYKl3fxnnCo10EGXzp3z1hTpij+BhmwmbTDg3T9QgmiKI0aORdQ34xsn2gZ38gmQARdECdX8XYBQc9N6xcuwTbzuOHW9fksV8ksVgulxGLmLLSeeZPZcxuyXufqtksUv8O26fpgsFtOmwOK2SXjKoHZtiD4AaihoZUCLn+87zzPx1NGTgppPamJCAPxDV+GDdIkVIuqrnSRInsmJld0x17erhvzWzWulCYg8ncKaxI8CIkP4Fth39qdKDqPOWa2vLXgV7CiY7u4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwvjw5mQiY5iaccmI6GDvaWHrzrZCKXPwzdPhQBzEGA=;
 b=CBqyCvwGVlQwUXodMp01s1SD58fwRJ8Xp9M8XCdWbT5sxQuULlN3wPLWJfBiq8i9cKAYb49u7lya8RBPjwy8cNu4zZzT1G1AvteVtiBEQR3RerMvftwl9K3combRRAwRnG48RlKCFi+YE2ZRroahj2Ii4BGwvu6KyO+FqcZxCvE8QXEWaHevB84O+LdD7Fos7gzAzux5YNOJAD+8R22EESrq3RCYhz8ggTy8ajMRrx06Lx81fIAdV1FTW0ARANtmkUDKHNC8026LutCxTleoS8LMRikrjBBgUTHDYntDcpMGKTe7ht4tfRxtdEH0SWplu/8LWxZNDSKdJsLkP2UlxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwvjw5mQiY5iaccmI6GDvaWHrzrZCKXPwzdPhQBzEGA=;
 b=K7Zk5J1fiCJheICbcJ8z83iSYh5FGGm23sjs0AB0Ut1yl+GVsFb5Ys1EwP/dcOqHV3eChZQVIdEqxIR1iJtn3e+rDMeL7us+yNsMr94+Bzx2RDieVdzE47U+tjRh/74pP8jjMsbHV0Al7IE77vKTQI9FZ2P/R/UjoSQgHj4QAQ4=
Received: from SN6PR11MB2703.namprd11.prod.outlook.com (2603:10b6:805:59::18)
 by SN6PR11MB3469.namprd11.prod.outlook.com (2603:10b6:805:bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 03:40:39 +0000
Received: from SN6PR11MB2703.namprd11.prod.outlook.com
 ([fe80::18b:82ac:74c7:126a]) by SN6PR11MB2703.namprd11.prod.outlook.com
 ([fe80::18b:82ac:74c7:126a%5]) with mapi id 15.20.3541.028; Tue, 17 Nov 2020
 03:40:39 +0000
From:   "Narasimman, Sathish" <sathish.narasimman@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "K, Kiran" <kiran.k@intel.com>
Subject: RE: [PATCH v3] Bluetooth: btintel parse TLV structure
Thread-Topic: [PATCH v3] Bluetooth: btintel parse TLV structure
Thread-Index: AQHWtB1rM6CQhzntHkOiqKGk6aUoPKnLvmXA
Date:   Tue, 17 Nov 2020 03:40:39 +0000
Message-ID: <SN6PR11MB27034462DA5BA784215D760794E20@SN6PR11MB2703.namprd11.prod.outlook.com>
References: <20201106092119.20486-1-sathish.narasimman@intel.com>
In-Reply-To: <20201106092119.20486-1-sathish.narasimman@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [60.243.119.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccdc181a-ef36-441b-1b5e-08d88aaa8da7
x-ms-traffictypediagnostic: SN6PR11MB3469:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3469BE03CCBADD6DB0C7F99994E20@SN6PR11MB3469.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AToS96yz/nZoiMpGSpahu2RJEFYCMPBk+GIK9i9N+Muy9VaL/UrPTaBh/L1V4LQAXTUM4YwlJB1/bHC87Vy76u1xYFWNgikCLip/8A/364XszVi7CBd7J0/DdHb1iO0od4+qmw0n/jZJhgU8ADUnHLoL/VumcT7IBenMsqbghsvW9lWevgBWzNrjEeAcEbvnexh/cNTpuqG3HFsydOjtJgEw6Fs3unoke2dGOAXL7fdSUAC5S9IBDIXv7Z25ZF380MGwDww46GfiX2RCYQCqB2JPmPEJ3cewB+Xbc4xs9CJMqTMGUSi6F0eND/62CwGQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2703.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(2906002)(66446008)(71200400001)(52536014)(33656002)(8676002)(9686003)(55016002)(86362001)(186003)(53546011)(6506007)(316002)(7696005)(26005)(66556008)(8936002)(64756008)(76116006)(66946007)(4326008)(107886003)(83380400001)(45080400002)(478600001)(5660300002)(66476007)(54906003)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: iciNdlI+o20UCoXr3TFDNWVVo38kW6TY5yRKCsM1aBA//XUay0+1LPlgKhq7dhfv7q3UGZ2KAlG+Or+DwYlo90evxkwUfGThhvCp27peoQqo73Q8fMVFD/t4fO/2QlGowLv9ULqC1mjtAjbFOTPANgsYPYAwok3Hczty8RpHHJQuZmuYo6lagUZnMxZdGxkicQcPqGiwFcsTXtGffZFwCUTIu+epS/W7WpnEVi/EAIPnBsYXXRzH7/3xsuM9UFpasINwYhA7Rapu5wiiOi/OcjGrO3mDHvw8YnMRnKviQ+jc/0Y5bXcUKk20RnOHyoKR9xNu5du1fYdPB2mEqY9NduuVnQYiP3NTlXy0ljZBmjysICRKcwXAyTN/oA7c119TuTBe6g60o1+hjOg7ffEZP/hxPsLphUtajFmTltWmI1YE6O9LuoiSgtcpJl3jmsTr2trAtsv2gd0KGIahHXb/KfrXZUxR6FaxL/LazSAEOp3PKg+McYkUfF9CpcQm+tmsunoBEwM2/EFRatRhqkrrWogm5DjpAx4zUKFMTk/7l0LccVPCm1/ayt4odKsXiqh5CNxe3YCxuJU3ZsqSLTk6WlPeD4qU2oIuB1N3cBmlJxwQWosCRsuneQcLt3l/psqk0cY0BLBiM20L/sJsHHv02g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2703.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdc181a-ef36-441b-1b5e-08d88aaa8da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 03:40:39.7887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZE6NVhzxkFCfpEj9116NjEWwFkA1saNTeCR9FiHpVZMgdhYpKLYpF+p63fUOlEQs+lnWbkcOsxwU3DB4Hr2I/Quh8yfJqUBkQ69WCNxiyzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3469
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

> -----Original Message-----
> From: Narasimman, Sathish <sathish.narasimman@intel.com>
> Sent: Friday, November 6, 2020 2:51 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Tumkur Narayan, Chethan <chethan.tumkur.narayan@intel.com>;
> Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; Narasimman,
> Sathish <sathish.narasimman@intel.com>
> Subject: [PATCH v3] Bluetooth: btintel parse TLV structure
>=20
> Latest intel firmware supports TLV structure in operational mode for inte=
l
> read version. so made changes accordingly to support both bootloader and
> operational mode . These changes are only to specific intel bluetooth
> controller for example ThP, CcP.
>=20
> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 105 +++++++++++++++++++++++++++---------
>  drivers/bluetooth/btintel.h |  16 ++++++
>  drivers/bluetooth/btusb.c   |  41 ++++++++++----
>  3 files changed, 129 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c in=
dex
> 88ce5f0ffc4b..67267afc83e1 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -401,31 +401,9 @@ void btintel_version_info_tlv(struct hci_dev *hdev,
> struct intel_version_tlv *ve  }
> EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
>=20
> -int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_=
tlv
> *version)
> +static void btintel_parse_tlv(struct sk_buff *skb,
> +			      struct intel_version_tlv *version)
>  {
> -	struct sk_buff *skb;
> -	const u8 param[1] =3D { 0xFF };
> -
> -	if (!version)
> -		return -EINVAL;
> -
> -	skb =3D __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> -	if (IS_ERR(skb)) {
> -		bt_dev_err(hdev, "Reading Intel version information failed
> (%ld)",
> -			   PTR_ERR(skb));
> -		return PTR_ERR(skb);
> -	}
> -
> -	if (skb->data[0]) {
> -		bt_dev_err(hdev, "Intel Read Version command failed
> (%02x)",
> -			   skb->data[0]);
> -		kfree_skb(skb);
> -		return -EIO;
> -	}
> -
> -	/* Consume Command Complete Status field */
> -	skb_pull(skb, 1);
> -
>  	/* Event parameters contatin multiple TLVs. Read each of them
>  	 * and only keep the required data. Also, it use existing legacy
>  	 * version field like hw_platform, hw_variant, and fw_variant @@ -
> 496,6 +474,85 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struc=
t
> intel_version_tlv *ver
>  		/* consume the current tlv and move to next*/
>  		skb_pull(skb, tlv->len + sizeof(*tlv));
>  	}
> +}
> +
> +int btintel_read_version_new(struct hci_dev *hdev, struct
> +btintel_version *ver) {
> +	struct sk_buff *skb;
> +	struct intel_version *version =3D &ver->ver;
> +	const u8 param[1] =3D { 0xFF };
> +
> +	skb =3D __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Reading Intel version info failed (%ld)",
> +			   PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->data[0]) {
> +		bt_dev_err(hdev, "Intel Read Version command failed
> (%02x)",
> +			   skb->data[0]);
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	/* The new Intel read version is backward compatible for Thp and
> CcP
> +	 * type cards. when the controller is in bootloader mode the
> controller
> +	 * response remains same as old intel_read version. For ThP/CcP
> cards
> +	 * TLV structure supports only during the Operation Mode. The best
> way
> +	 * to differentiate the read_version response is to check the length
> +	 * parameter and the first byte of the payload, which is a fixed value.
> +	 * After the status parameter if the payload starts with 0x37(This is
> +	 * a fixed value) and length of the payload is 10 then it is identified
> +	 * as legacy struct intel_version. In the latest firmware the support
> +	 * of TLV structure is added during Operational Firmware.
> +	 */
> +	if (skb->len =3D=3D sizeof(*version) && skb->data[1] =3D=3D 0x37) {
> +		memcpy(version, skb->data, sizeof(*version));
> +		ver->tlv_format =3D false;
> +		goto finish;
> +	}
> +
> +	/* Consume Command Complete Status field */
> +	skb_pull(skb, 1);
> +
> +	ver->tlv_format =3D true;
> +
> +	bt_dev_info(hdev, "Parsing TLV Supported intel read version");
> +	btintel_parse_tlv(skb, &ver->ver_tlv);
> +
> +finish:
> +	kfree_skb(skb);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btintel_read_version_new);
> +
> +int btintel_read_version_tlv(struct hci_dev *hdev, struct
> +intel_version_tlv *version) {
> +	struct sk_buff *skb;
> +	const u8 param[1] =3D { 0xFF };
> +
> +	if (!version)
> +		return -EINVAL;
> +
> +	skb =3D __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Reading Intel version information failed
> (%ld)",
> +			   PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->data[0]) {
> +		bt_dev_err(hdev, "Intel Read Version command failed
> (%02x)",
> +			   skb->data[0]);
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	/* Consume Command Complete Status field */
> +	skb_pull(skb, 1);
> +
> +	btintel_parse_tlv(skb, version);
>=20
>  	kfree_skb(skb);
>  	return 0;
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h in=
dex
> 09346ae308eb..952da44b79de 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -132,6 +132,15 @@ struct intel_debug_features {
>  	__u8    page1[16];
>  } __packed;
>=20
> +struct btintel_version {
> +	bool tlv_format;
> +	union {
> +		struct intel_version ver; /*Legacy Intel read version*/
> +		struct intel_version_tlv ver_tlv;
> +	};
> +} __packed;
> +
> +#define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
>  #if IS_ENABLED(CONFIG_BT_INTEL)
>=20
>  int btintel_check_bdaddr(struct hci_dev *hdev); @@ -151,6 +160,7 @@ int
> btintel_set_event_mask(struct hci_dev *hdev, bool debug);  int
> btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug);  int
> btintel_read_version(struct hci_dev *hdev, struct intel_version *ver);  i=
nt
> btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *=
ver);
> +int btintel_read_version_new(struct hci_dev *hdev, struct
> +btintel_version *ver);
>=20
>  struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read=
,
>  				   u16 opcode_write);
> @@ -248,6 +258,12 @@ static inline int btintel_read_version_tlv(struct
> hci_dev *hdev,
>  	return -EOPNOTSUPP;
>  }
>=20
> +static inline int btintel_read_version_new(struct hci_dev *hdev,
> +					   struct btintel_version *ver)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline struct regmap *btintel_regmap_init(struct hci_dev *hdev,
>  						 u16 opcode_read,
>  						 u16 opcode_write)
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c index
> 1005b6e8ff74..c63bc8a0c84f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2554,7 +2554,8 @@ static int btusb_intel_download_firmware(struct
> hci_dev *hdev,  static int btusb_setup_intel_new(struct hci_dev *hdev)  {
>  	struct btusb_data *data =3D hci_get_drvdata(hdev);
> -	struct intel_version ver;
> +	struct btintel_version bt_ver;
> +	u8 hw_variant;
>  	struct intel_boot_params params;
>  	u32 boot_param;
>  	char ddcname[64];
> @@ -2577,19 +2578,33 @@ static int btusb_setup_intel_new(struct hci_dev
> *hdev)
>  	 * is in bootloader mode or if it already has operational firmware
>  	 * loaded.
>  	 */
> -	err =3D btintel_read_version(hdev, &ver);
> +	err =3D btintel_read_version_new(hdev, &bt_ver);
>  	if (err) {
>  		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
>  		btintel_reset_to_bootloader(hdev);
>  		return err;
>  	}
>=20
> -	err =3D btusb_intel_download_firmware(hdev, &ver, &params,
> &boot_param);
> +	/* If TLV format is supported then it is in Operational Firmware. TLV
> +	 * structure is supported only in operational mode in latest
> Firmware.
> +	 */
> +	if (bt_ver.tlv_format && bt_ver.ver_tlv.img_type =3D=3D 0x03) {
> +		btintel_version_info_tlv(hdev, &bt_ver.ver_tlv);
> +		clear_bit(BTUSB_BOOTLOADER, &data->flags);
> +		goto finish;
> +	}
> +
> +	err =3D btusb_intel_download_firmware(hdev, &bt_ver.ver,  &params,
> +					    &boot_param);
>  	if (err)
>  		return err;
>=20
> -	/* controller is already having an operational firmware */
> -	if (ver.fw_variant =3D=3D 0x23)
> +	/* In case if old firmware is used, it should be backward compatible
> +	 * to check for operational firmware. only on latest firmware the
> +	 * support for TLV structure is added. so check for tlv is not
> +	 * required here.
> +	 */
> +	if (bt_ver.ver.fw_variant =3D=3D 0x23)
>  		goto finish;
>=20
>  	rettime =3D ktime_get();
> @@ -2641,7 +2656,7 @@ static int btusb_setup_intel_new(struct hci_dev
> *hdev)
>=20
>  	clear_bit(BTUSB_BOOTLOADER, &data->flags);
>=20
> -	err =3D btusb_setup_intel_new_get_fw_name(&ver, &params,
> ddcname,
> +	err =3D btusb_setup_intel_new_get_fw_name(&bt_ver.ver, &params,
> ddcname,
>  						sizeof(ddcname), "ddc");
>=20
>  	if (!err) {
> @@ -2665,17 +2680,25 @@ static int btusb_setup_intel_new(struct hci_dev
> *hdev)
>  	btintel_set_debug_features(hdev, &features);
>=20
>  	/* Read the Intel version information after loading the FW  */
> -	err =3D btintel_read_version(hdev, &ver);
> +	err =3D btintel_read_version_new(hdev, &bt_ver);
>  	if (err)
>  		return err;
>=20
> -	btintel_version_info(hdev, &ver);
> +	if (bt_ver.tlv_format)
> +		btintel_version_info_tlv(hdev, &bt_ver.ver_tlv);
> +	else
> +		btintel_version_info(hdev, &bt_ver.ver);
>=20
>  finish:
>  	/* All Intel controllers that support the Microsoft vendor
>  	 * extension are using 0xFC1E for VsMsftOpCode.
>  	 */
> -	switch (ver.hw_variant) {
> +	if (!bt_ver.tlv_format)
> +		hw_variant =3D bt_ver.ver.hw_variant;
> +	else
> +		hw_variant =3D INTEL_HW_VARIANT(bt_ver.ver_tlv.cnvi_bt);
> +
> +	switch (hw_variant) {
>  	case 0x12:	/* ThP */
>  		hci_set_msft_opcode(hdev, 0xFC1E);
>  		break;
> --
> 2.17.1

Gentle reminder

Regards
Sathish N

