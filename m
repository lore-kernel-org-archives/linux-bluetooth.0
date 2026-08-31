Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4C53B71D7;
	Mon, 31 Aug 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174402; cv=fail; b=Y0IqzDIzlRnFmWya84UexpIRDkNR6r6SxAt85M5e2Re1uOmUOV9674LbCc6iNxkJ903aBFVILKD1dZbFD4VGhRVK+VXaFaW9Ti7Cupbyr05SuUR7zThq1yDJFBe3dxI522voqiiseiV6Vu9JK8KUdcBGF8qoXMOcV9K3E6Qow7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174402; c=relaxed/simple;
	bh=G+JcopuG3ZA+9gBX0LBekfY8W5dPTaKotXupJ8PVt14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gBPNug+Au4oya8TmsOfbRC7op28H5y3quGYOhBe8GTJhe5pFCw+JCtBEBZ1y3eyToCyGLgxhojkWo0g2VOr7DAChKHZVsLFVp+91xR4WZMl5gyxDRoG1JMGVvPvPz7cKfnksk7Pih0mUtwfp0Q588TvqP7Na8kaMdn0LpcHx2SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2tPONn0; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2tPONn0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788174401; x=1819710401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G+JcopuG3ZA+9gBX0LBekfY8W5dPTaKotXupJ8PVt14=;
  b=Z2tPONn0oVcJwvmH7bYc1f6GMMK43ydRJ8Hoem2laoBruqaM7xfa7Hts
   pZ+9K/rrZoXkBrs3pJuWdiNy8phKhTUYLjS0FW3w3/0U7JKQbKg9fJJuD
   rGlNcOIo/a9Tgi4sw86TbQ+RPdW1c4F30x6YushtKtbW1cXU1ibuduQEi
   SR94C6Dkozflb2rXAAMYIQ7FH7j3bXKrVL3Lj/X7wj2DCFdph/d9ogl7E
   bM8Opa8aiiKSm8mpJx77VgB84ZZrDhlYyaRQ4AE7Zj9AWoILJY851ke2e
   yK4CBUq3ru9GCC4Gc3b1qu4WN9naXWWTW3Vvy7TivS2xg54leMPsatG9n
   g==;
X-CSE-ConnectionGUID: 0G3j3sooRbabimmmRm3OHQ==
X-CSE-MsgGUID: 8rxKJ/SqRzOLhw6X6/aJoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88629154"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88629154"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 04:06:00 -0700
X-CSE-ConnectionGUID: 3/8MKicnTWuRWFlJFK/K+g==
X-CSE-MsgGUID: nsWi+XCBQTyLCiEG5vvjvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="298683612"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 04:05:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 04:05:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 04:05:58 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.59) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 04:05:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3af4cpQomPROTb41hoK0a3tb7JVKaPgZufskXVJsIZkW9gEOHXJdpa/9NSJLClawpvAjULSHB0u/ByubRIiytNSTv0QefMAinpzYskWoK64vf21RDvTL5VeWgd25lr/QW17N10L3WRzPT0zXvBgEiw0J00fnpIf1+Af6hzBr7WHw0R68hsnkB0XsY+x6Flw7aev8SyunoGOacTbxuwZEow5Ri+Bv25AqIm50PzKEpi0Ebin55vUsJ4VfE92k5l9Q4MP0zi7PucRmUeUKfa3Yf7bV0yoEKW5NKGQr2L3TSt9rQTuELqyKh00Mky+LWqh3P153vaBEBLNtbOgdOVXVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxCMuwlvNFy03Jz6j6DtpOg5jX+KyaiETYtDt9gqGnY=;
 b=GKP6NnLCXjrdTw188Gndh1W+v9PBDylihrUwQTmeSuFweksAli4bG/8fPGggsMaPqXIrVg1ytVofZU5bDEdRIerpS0mmSUNCRmw+jtwOXzDMXOd2OVu/ZnHQsoXdyTBeKJ0bJEcw/ABimIQMImc1PqQD1594HKbP2TLZ1jvl3mPdQhexDGG6sKa49iD2OZfRAIdcSAKzCuNlEc/Qu254NJ5xnltxqKbs3E5uqRs43XcS7lHrgst100P7Wo92+lR0tX+Rqd//4mfI8bKd7n9vUVgf9ZQOl8zrhoPBL64Q1rdQ0c9B7lsstIwUb/yCRic579UDa21aG474JHL2+bZ6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by DS0PR11MB6421.namprd11.prod.outlook.com (2603:10b6:8:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:05:56 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:05:56 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ali@iusegentoo.com" <ali@iusegentoo.com>,
	"kiraank@gmail.com" <kiraank@gmail.com>, "Srivatsa, Ravishankar"
	<ravishankar.srivatsa@intel.com>, "Bag, Amit K" <amit.k.bag@intel.com>
Subject: RE: [PATCH v3 3/3] Bluetooth: btintel: propagate version TLV parsing
 errors
Thread-Topic: [PATCH v3 3/3] Bluetooth: btintel: propagate version TLV parsing
 errors
Thread-Index: AQHdOS9+E5UKoUaN60S1Zi6gnjbS0La3/u+g
Date: Mon, 31 Aug 2026 11:05:56 +0000
Message-ID: <PH0PR11MB758513EBDED0DE00116A17FAF5A92@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20260814171503.42684-1-acharyalaxman8848@gmail.com>
 <20260831095923.18830-1-acharyalaxman8848@gmail.com>
 <20260831095923.18830-4-acharyalaxman8848@gmail.com>
In-Reply-To: <20260831095923.18830-4-acharyalaxman8848@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|DS0PR11MB6421:EE_
x-ms-office365-filtering-correlation-id: e7ba124b-1131-4fee-6f3b-08df074fd4c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|56012099006|4143699003|22082099003|18002099003|11063799006;
x-microsoft-antispam-message-info: /kjrKcKGSvFUt+ld4m09Onoyhns6zXNmnzJb46ocTLtxizI+TPpwEmeoj9vEOB2NSHwZmQ67VrJjfNdCnmtBKhMUQS3DXTYs6DF/BNHOQ+9dsa5W0F+QK+8fgc1lxsIDBUKGGRH1D8EH8XSJPdARfLA5rS3giqoHC4AF8tJsrHVZFUCXKI+CPbLxdVZbPqzFFI3xaqtgXs3ob0fKh5XzYntpblKp+s1NVLVg8aYCIRcYC+XRtcQVaFcJisL39tBFR8VUWfjzptt2HuhRqfQsiS+CESTUlPJ9T6dLzHanWaV0LGHau48ftZ9pEb+Yge75sjlYugwMQyrlWQQppoz1XRkAq7puGylmT2fO4gDo6zpKkU62r0u/VT0UoJeyqU3N7mVLzt3W69e56nL+llApm8VaEWHdiQudpER28vDlahcASvl+7anuOzQSVkumvpAHE1pm0+OSgWaAnP/u3gqFXvqTCBfQQXmZhV/f4C/w+gyrcTmmTg6GnreRFbVmzJNa+5kaEHlI2zlLkJOfrVGfcFTLPkdJazE4f/GSa7YjguesfHRuqOVdL3t5Rk7jyVuyK/O1U2j+qWY5+3ZaPKBz/YmExRTg43CEk5rYYoPOUeIca4NFPK1paSR2wg+6iOnzvom4epw4ylxY1gI2HEVC/aiAJ+B5SMft/aYY8kWQtSOSeiIl2bhC4dFZWSG24TBQIRuSgl4oB7HBK20hk/R7Mvq1i/kv8mwlHYJVG6kSi+s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u0p706s0BgTSopD+wv4UIlutsNOFc8m+vlhWz/cDj8NyRJODwkXDZ4NsL6DZ?=
 =?us-ascii?Q?by+96whNJewEwnfa6f1czZUJKuuqdL2hOwZ/m6KvmK0Avnnaxl6XKB1mkpub?=
 =?us-ascii?Q?XyaVPqzIHaWBQcYv4nzC5c+oV5bNWQmBOK/q7KseymJ5QKpWZ4ilhy0UGswU?=
 =?us-ascii?Q?HSj4LcVmfTy1Ijj0T5UfYq0yiPldiKRN8+itvjALXNY7MqR6TdPg3cTwzPX3?=
 =?us-ascii?Q?pex58imN8oVKSdKbwxZUcPxsX//ZJKghVtgTVexS6cPT30rLYMIY5TRtzild?=
 =?us-ascii?Q?gWVuYjmkA45yiKwuwYc3TsD5VLLUL8GO6HBp1jPLetNnUylDKBzquhJzKUmj?=
 =?us-ascii?Q?/AC/xvCvabSn20aYeyfO9T/Gd9N579I5M+nEt4/nae05jeVlWrHSjV450rdO?=
 =?us-ascii?Q?/rmI0u+xkeEzat5xCgZIiTYHbzsllILY46Stp3zwaupajPetbOgAHP+DtG2A?=
 =?us-ascii?Q?ced8mLteXd34y/CAFFuypQysDF+Bvzu2GEQnSwkYS+IuFoiTBX6pjjKXyKAB?=
 =?us-ascii?Q?fBmX5ly6oiU18gQY/U4IJ/iEyzZ8/jh9kJXk+9HQkjcoBPriN1JJtpip5Y1v?=
 =?us-ascii?Q?WUeGw88DMXUUJdI79yH2T1y0mSftKl7ZLoxgT4FjYpaBhlPADFDTiuQcpUaI?=
 =?us-ascii?Q?dD5BV/4nr6d+ecNILlrNNI1/jLQpy2d+mElFK2MPu0rM/19TWRIga6swJI3b?=
 =?us-ascii?Q?gG11dOBcElft/X2bvaGOKLWWOZav++vVN4+tV+9dpcWZ422WZBQEDpN9kZip?=
 =?us-ascii?Q?XyMW3FGiXC2NfIQe44+GE9ToacgzdKOI7/ZNv5YyPGd7jouuH/GMN2pT9wEA?=
 =?us-ascii?Q?7uoJnari/rYeGF/ONnRHlD737g+mEfyUTocIryXTJJ8t3PyjcMbDBqyBAYvi?=
 =?us-ascii?Q?D9BMbc8BhEq4/BYI5+ue58ShF3eRG7ipoJDnxeOUu2Yyo9uo3045OwXFr6Dk?=
 =?us-ascii?Q?4o6vnMgf/PLUx21E9/Y2jokrFQccZLORV2DZ+KjCkczvqwTWerqyrHA19oRh?=
 =?us-ascii?Q?r646iZBA0WfvttTMxVRcik1Pb3jpNuhMCVQlWDtURbspdeaKsE+Ff3Ax1CYJ?=
 =?us-ascii?Q?h3XqQrbu5rcnRG2FCbYn5W+UJe9tWH5UHXOvtcMVpxI240OdhMRN4oMmT7Kt?=
 =?us-ascii?Q?xX+XCrwnUeZxsEDXxl0PpocQFtq54FuCQinXD6Tygz+5esKvaeuKTvhG6sWM?=
 =?us-ascii?Q?aRzDprO2I4nyq3IKFGybiAmIUNH2YWpfgcds8uAI6aqaK+95JOjDvHet8z8b?=
 =?us-ascii?Q?1HWveGWmQGko7j1RXwWiCnj6JTKFr3gHyP0CYqijBvlMgfC6m/q9WyfDoXrj?=
 =?us-ascii?Q?hjGOwcOfEt5BWjrGbFP0w+KqSsfViC7CcRsLW4nOuTnH+jq0ENvr0zarZh+o?=
 =?us-ascii?Q?KcBXNlFnBDICAr8PoL8JFQJUmi8TOOr9a02z4+uLKpTxoNYGnsVBgvYNmqPj?=
 =?us-ascii?Q?ezRjd5ZrGZgVoo5dUd0jaw/9ws2yoCbrrvOsOBFHTnjoUnPW7o8T/mBu9Bb6?=
 =?us-ascii?Q?CqgReWOfoOJ6Idz1BpvAQJ6LmP//C99QQwHtVBRM0nqrPMzqij0xV2EdGd0y?=
 =?us-ascii?Q?ErIBCbZTGl2GXMuD2m+Fm+01Wkcd8JWfsG7AC79/opDPlWoAL2NuGpVJ3Gfd?=
 =?us-ascii?Q?Tq9EEu4Px0TTDdwgK5YVKY+c7xLzafX13WniSo18wBnRDHh2SDgzI7dTl1vo?=
 =?us-ascii?Q?R4/PPY60qB1nT4F4vqqJvHtLqB6ETPtRnde2E8n/C8lnqtyz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Pq5+U0y8D3RYi+ma2tjQm1KT0PlOpUvD8idO9lcKEXiiLAxCRPmEe6IbDJWMIKwNT02nPKzeJ16vtdklseFZ7qeOGJKxS+5L6UDJHtyLrrn374769JyRrnNzpkr1SEUUDL/QcBxA3q21a2+iRsq+Ia0eRjHrEE7noSHX126DUNFby6lK3raDCoAP6w0fCKcWKv+jLvFjKEvSpa1PpHOQjjLbhKCuWUErep0ne5fFRZhdabmNtlOBZYjPK7IrVx8Qf5QkDolTTakypbyPwKbCFYnDtzLeiUUlWYPkBabYL2d9ag4NbBHHkUPeI9X7+DbOU23agu8UZME1FoE24ar3bQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ba124b-1131-4fee-6f3b-08df074fd4c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 11:05:56.2893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DtSGIyVXY1FNxrwEhqec+rHRmEdLNoSE5rrOFqcUHKc8Hnn+IQ5RXwMeHZUVvSikIvrqEmzbpZW1K1sX0+S4qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6421
X-OriginatorOrg: intel.com


Hi Luiz,

>Subject: [PATCH v3 3/3] Bluetooth: btintel: propagate version TLV parsing =
errors
>
>btintel_read_version_tlv() ignores the parser return value, so setup conti=
nues
>with partially initialized version data after a malformed TLV causes parsi=
ng to
>stop.
>
>Return the parser error to the caller so an invalid response fails setup i=
nstead
>of being treated as successful. Keep this behavioral change separate from =
the
>bounds checks so it can be reverted independently if an existing controlle=
r
>sends malformed data.
>
>Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
>Reviewed-by: Ali Ahmet Memis <ali@iusegentoo.com>
>---
> drivers/bluetooth/btintel.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c ind=
ex
>887170534..964d2de30 100644
>--- a/drivers/bluetooth/btintel.c
>+++ b/drivers/bluetooth/btintel.c
>@@ -723,6 +723,7 @@ static int btintel_read_version_tlv(struct hci_dev *hd=
ev,
>{
> 	struct sk_buff *skb;
> 	const u8 param[1] =3D { 0xFF };
>+	int err;
>
> 	if (!version)
> 		return -EINVAL;
>@@ -741,10 +742,10 @@ static int btintel_read_version_tlv(struct hci_dev
>*hdev,
> 		return -EIO;
> 	}
>
>-	btintel_parse_version_tlv(hdev, version, skb);
>+	err =3D btintel_parse_version_tlv(hdev, version, skb);
>
> 	kfree_skb(skb);
>-	return 0;
>+	return err;
> }
>
> /* ------- REGMAP IBT SUPPORT ------- */
>--
>2.51.2

Tested-by: Kiran K <kiran.k@intel.com>

Thanks,
Kiran


