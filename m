Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A942C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 10:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648B561A38
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 10:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbhKSKNM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 05:13:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:38774 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229879AbhKSKNL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 05:13:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="295206325"
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="295206325"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 02:10:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="495811640"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 19 Nov 2021 02:10:08 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 19 Nov 2021 02:10:08 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 19 Nov 2021 02:10:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 19 Nov 2021 02:10:08 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 19 Nov 2021 02:10:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C01YuJoAfqpowlcjWj2OCQoDQNKumo15oEhU8YfJjfoE/U8S4an/+169sckO5MoKbMEEkN7BLB/p33L8dh/5LqQaSp6yfvdHi8La8ORHksKInaMGTSLemv5YrvrpCupuI4ey/vk4jzhm4Z8nQSoVKCbsffZ49QftwGf0fzKWRFdI/1tTvpYGi7rxGC9IvueLtNKri24lO+p6zbj+YfyS99JJw1uYMnqb4loMFboFbunuIo4JlUYeQANtm6nEEiaTBsIciK7eF219tii0/tWP4+nSVDcuyEae/FkMlHVjPHXjf1lSAYiGcJMbpLCO+i7toNWlmKmMouHaOhA7nKWEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zxRSSRFhA75OGwioIVZQc2qkpMbjlwblzdAydXu1FU=;
 b=J6fdBbuGELUyJPGjyWrG8Y2OgYOXeTf32sxOW/yUrBhmZLH/sj1PW8Zu/FxBO1qhEPwT89Uw2NPXX5IKqo4d351kaHNGhtWivMpzzFgNMXoq+ylUUHqiAvxsFwoH4xVUTwyp9uGkFeRf08gXxb8BWPNAaKuCKMJrWEjfOERso10N1O1j5lXYoctWQd2KDY1jK9k1bxLxkCY5YrKqRmdeLV7ufn8WSR3jHLC2jCXunB2d4NSK6nw+2grDAsnbVUVSMzir+tT/fSQZAreC/0oKrLdX1TKxnw1ZiNm2QsuGAS6jyVzVZzhKkkwu6h2afq6uLg0YM/adBbDmZs9qKeOD7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zxRSSRFhA75OGwioIVZQc2qkpMbjlwblzdAydXu1FU=;
 b=T+dz6jPbs5tfgb2bmeu1Dk2K9zpty+fUg8H5cnxp+DDmXJ8foEy37Xe5piodAjSlZq3ZfhTNwOWKzHWXip5vrLTiZMKSRld9APDOMmaZAzGaiiQmlpeU3jp32tlYPflVlpOHf+wDY6xRxwaNcbvjzhCrQwyaM2TstV8GaEQBGiI=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM4PR11MB5567.namprd11.prod.outlook.com (2603:10b6:5:39a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.21; Fri, 19 Nov 2021 10:10:07 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::1879:4eaf:cabd:992f]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::1879:4eaf:cabd:992f%8]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 10:10:06 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Subject: RE: [PATCH v2 1/9] adapter: Enable MSFT a2dp offload codec when
 Experimental is set
Thread-Topic: [PATCH v2 1/9] adapter: Enable MSFT a2dp offload codec when
 Experimental is set
Thread-Index: AQHX3SkDRTg+1M7f0EyccYn2B9o55qwKn9OAgAAA0RA=
Date:   Fri, 19 Nov 2021 10:10:06 +0000
Message-ID: <DM8PR11MB5573C323C7A90D177E0EB4A7F59C9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20211119094235.2432-1-kiran.k@intel.com>
 <089A59F0-C858-43BF-80AC-0C384799A87F@holtmann.org>
In-Reply-To: <089A59F0-C858-43BF-80AC-0C384799A87F@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e03fb72-b9da-47ae-f1f6-08d9ab44c323
x-ms-traffictypediagnostic: DM4PR11MB5567:
x-microsoft-antispam-prvs: <DM4PR11MB55678721543962F588707A47F59C9@DM4PR11MB5567.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V9SUmrCUx1+4itr9NBT4v5FaTy9uDdhVFoDcOcU17hAlzu8qx/DMSg6z6G3SaWQZaZ9xEdqlcdfBd37r/CZu0Gm2XQBXHwDl5hh6QLic6fNZELlU/RLz41CSkvDw/oZzN5vvHSKL7RYlifboRNCR1T5mEsjOmGGC50UFjNwBSSPx2fzKVz+TGAODUQT8hJhI22YW//lrUi6TjZFGsJJCWoRlYvWWexkbNusMZqMNXOjCK0+Z81TYWVG4y8l89nhUtaDwYqQgKwgLu1K9BIU0aZwYuONHNsjP8RlQoBcuGSeTiHKizLo/BtcCCkz+VVeQYai0hStQOBSBnVLcIcRqltfWbIY3FcJcCy1nleQMgHjFd4+SQIHnpbuUdRJ4Hbsv1ox2bdBnioqNwS6WDjOU1J09r7SFlI+zKCAI9NbYrjFXu6wkrSi8MRxzIn7hAs128WegwwhTxa22e4s0XHNnIefjAfduF5nQ5XhtvjR4xzAI0pTFJInQ8nIPv/3Kb+PP0yMaqeL3DmSasR96pm0xE5w9VyUqA04twIDbHamGp8dZKecuoU1e69KKiUPRIy1YEOrqAoCnslegvL/259pi7nON0UkpLkQsrmMIxS8szCxLiIzNnV/wNY/8H5juheHbvnaYjEcrVGoJXEEEllMebfOOW/1mI6AG8Hl+3/sl9Ybd8SpC/joyOcCwRqe8b2rB2xEYCDdtP6LffqGqPysOFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(52536014)(9686003)(8936002)(8676002)(83380400001)(33656002)(38100700002)(55016002)(71200400001)(4326008)(53546011)(54906003)(316002)(7696005)(6506007)(66476007)(66946007)(64756008)(66556008)(107886003)(2906002)(66446008)(5660300002)(122000001)(76116006)(86362001)(38070700005)(508600001)(6916009)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tOkPlWhHX7zx/KrwIn84nsrNY20FxpntPtGb9BnWnHTUps+7sQ7p50rROcIx?=
 =?us-ascii?Q?jPJxVjeFk8hcQSGC6ELYUCagyawlLgd51ot2Pp41lJk991yck7/atVHfglxb?=
 =?us-ascii?Q?9ayraK64q9w4PA4qArWkxhnUE5FtlpuYGVbFM1gT/P8qgS5DpsRplgrD5Ncg?=
 =?us-ascii?Q?t956qC1us3FBdElg9QC4GhkHP/Zm4JkqODAY8mZm6136JUN2akKc50ckkd1h?=
 =?us-ascii?Q?Yuu0eOWXe+1XK99b+q4M7WuvtJHFg0qtXctAFpPeUOQQJUDjBX2B/USj/fI+?=
 =?us-ascii?Q?Ge5lQc+qQ38lSwao2J2KllNfSTAxTzVk5roPio9NJAG1mXlsXqXvlkdsLBF/?=
 =?us-ascii?Q?jjQmGBFc+cPewwZyvWM0HsgiYrwHTg48pB4dPxZ40U+8vc6pEGE9IkK/cfLg?=
 =?us-ascii?Q?tbr+W3fXZPCclhZspdXA9zzCpxWh8ZtnJ/ZsXuQU4X/MX4kzI1P+XEqIC0hX?=
 =?us-ascii?Q?nu48qm+YIT41GsRkma2pKV/B2BOrYiGjdSb5HiRHpSczNJ7LC8aIn65A4jGd?=
 =?us-ascii?Q?VMhQ7cAQ/VQvZOEZg8vm+Z3i9W4TCFw6prHLHv3TpEonIdu6zogOCWxPZmzu?=
 =?us-ascii?Q?RaSVcobRpGxoJ/YgyDvQAySu6/iOgOFQRsquVbxWPIPhZ3UaZ50zGp3U68zo?=
 =?us-ascii?Q?SnGbLiarAogtwaemra+vDbt0T7kyr9ote6auTABpBvRft+5EiUm62h8jxfwT?=
 =?us-ascii?Q?brKpyq8GpjW9EuYpFUz0G/doGDjioX3qelQs/FbBxqbhnmAXgsr04czS2WIs?=
 =?us-ascii?Q?EBRURW3cemp8EBMVW87e4OBTuVm9ac1ENLuCwpzg4CUYwgRyVjJHS/CMKZ6q?=
 =?us-ascii?Q?1w1uC4yqYY7uazTYvIrwI7A3mCGhFFarXVC/OJdF6XE0p/GDk5LpW2keayxI?=
 =?us-ascii?Q?lZsNHHwx4enOppyeJTKl+EcrVo+vrJNSpKLWnZb49MhkjYSeFqDNHtOl7oZY?=
 =?us-ascii?Q?sbvuiipjEuPjI+kKEONvz2Fpd4Qh+tisicoOOPhmLk3VyskRo2T4MgUKu4Vf?=
 =?us-ascii?Q?jjt9As7pUQKT7Lbl4ofbZI7iHL4f8KLvXnNrKoogjefn4RDPgsvoFJpD9h4F?=
 =?us-ascii?Q?4BPTIQSQJZq3OvXMFYpZu+HCXXP9O7WcjcAWbWLverxZfxSE4/l0f3TnEj2H?=
 =?us-ascii?Q?+lsylqr1kNE4qfYDThaKqs07J9bTnWubpRtQ2irsppLAKw9H4xmgbjlVmioZ?=
 =?us-ascii?Q?xgd54CovLl5LVcAvkoB1pjNh827pORDOVlmQ58+WcQiv+YTiQSnIA8xpZiUP?=
 =?us-ascii?Q?x87dGCK4pxKY/7K/XdsQYxh98xO8qr/zNUdtX6/XPqRdlvt1yCkkNhjQIH+/?=
 =?us-ascii?Q?/7kBEPMPsaEjAkFRa5nzyI4+jZUyAsQUGIVHDldaf7Z7u2WilBksRpyIqbPY?=
 =?us-ascii?Q?cdf8E9YklTlo63GQ1Dfce1rSUtr8XgM45ZxLGdUzO5CNoGesxWXc3e52OzVf?=
 =?us-ascii?Q?Vn3E1S0Zy2C9eFqCcn+267eULyqqXZ54+b/CBVZ9Lp7WC7/V/vCc98fy0OpG?=
 =?us-ascii?Q?T/8m2rHhXIl2MYCpm0X4VJsW5Ulg3cM8ftw/AVc+gOcIJw4Yhhb8SNVMP2nm?=
 =?us-ascii?Q?n0dggl97aKcWlZqs8g5VOv7OKQgC8o5Igd0yXxgfQwQ6BBTUq8M7RlXXmgd3?=
 =?us-ascii?Q?eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e03fb72-b9da-47ae-f1f6-08d9ab44c323
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 10:10:06.8838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjUiqbUOL+9jMJPyHDn82fyC1WOAqjFYI8XTZ6FcwbQeADk45vJ4FzywnrfNuIYIaG3Tfcg+DaBh4y9u8pl1UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5567
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann <marcel@holtmann.org>
> Sent: Friday, November 19, 2021 3:36 PM
> To: K, Kiran <kiran.k@intel.com>
> Cc: linux-bluetooth@vger.kernel.org; Srivatsa, Ravishankar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>; Von Dentz, Luiz
> <luiz.von.dentz@intel.com>
> Subject: Re: [PATCH v2 1/9] adapter: Enable MSFT a2dp offload codec when
> Experimental is set
>=20
> Hi Kiran,
>=20
> > This enables codec offload experimental feature if its UUIDs has been
> > enabled by main.conf:Experimental or -E has been passed in the command
> > line.
> > ---
> > src/adapter.c | 43 +++++++++++++++++++++++++++++++++++++++++++
> > src/main.c    |  1 +
> > src/main.conf |  1 +
> > 3 files changed, 45 insertions(+)
> >
> > diff --git a/src/adapter.c b/src/adapter.c index
> > 309956bbb5be..1627cc127057 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -142,6 +142,13 @@ static const struct mgmt_exp_uuid
> codec_offload_uuid =3D {
> > 	.str =3D "a6695ace-ee7f-4fb9-881a-5fac66c629af"
> > };
> >
> > +/* 0cc2131f-96f0-4cd1-b313-b97e7cbc8335 */ static const struct
> > +mgmt_exp_uuid msft_a2dp_offload_codecs_uuid =3D {
> > +	.val =3D { 0x35, 0x83, 0xbc, 0x7c, 0x7e, 0xb9, 0x13, 0xb3,
> > +		0xd1, 0x4c, 0xf0, 0x96, 0x1f, 0x13, 0xc2, 0x0c},
> > +	.str =3D "0cc2131f-96f0-4cd1-b313-b97e7cbc8335"
> > +};
> > +
> > static DBusConnection *dbus_conn =3D NULL;
> >
> > static uint32_t kernel_features =3D 0;
> > @@ -9789,6 +9796,41 @@ static void codec_offload_func(struct
> btd_adapter *adapter, uint8_t action)
> > 	btd_error(adapter->dev_id, "Failed to set Codec Offload"); }
> >
> > +static void msft_a2dp_offload_complete(uint8_t status, uint16_t len,
> > +				       const void *param, void *user_data) {
> > +	struct btd_adapter *adapter =3D user_data;
> > +	uint8_t action =3D btd_opts.experimental ? 0x01 : 0x00;
> > +
> > +	if (status !=3D 0) {
> > +		error("Set MSFT a2dp offload codec failed with status 0x%02x
> (%s)",
> > +		       status, mgmt_errstr(status));
> > +		return;
> > +	}
> > +
> > +	DBG("MSFT a2dp offload codecs successfully set");
>=20
> we need to switch to using btd_debug or DBG_IDX to include the index
> number in the traces.

Ok.
>=20
> > +
> > +	if (action)
> > +		queue_push_tail(adapter->exps,
> > +				(void *)msft_a2dp_offload_codecs_uuid.val);
> > +}
> > +
> > +static void msft_a2dp_offload_func(struct btd_adapter *adapter,
> > +uint8_t action) {
> > +	struct mgmt_cp_set_exp_feature cp;
> > +
> > +	memset(&cp, 0, sizeof(cp));
> > +	memcpy(cp.uuid, msft_a2dp_offload_codecs_uuid.val, 16);
> > +	cp.action =3D action;
> > +
> > +	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
> > +		      adapter->dev_id, sizeof(cp), &cp,
> > +		      msft_a2dp_offload_complete, adapter, NULL) > 0)
> > +		return;
> > +
> > +	btd_error(adapter->dev_id, "Failed to set RPA Resolution"); }
>=20
> We are no longer dealing with the blunt copy-and-paste mistakes, please d=
o
> a proper review before sending any patch.

My bad. I will address in the next patchset.
>=20
> Regards
>=20
> Marcel

Thanks,
Kiran


