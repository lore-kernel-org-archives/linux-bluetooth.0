Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3621E22E9;
	Mon, 31 Aug 2026 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174342; cv=fail; b=Dwr4pGeyTH5Gx+g7fEM77GNPkHXtoMM+5gwDVyL5ueeohyzXZ67EcLj2Geu7a5BzZ+wvrVl8wejsDrJ2LJ2L1TDnEw3drqc2qPbA+67+JFE1iVHurPbSyGKkmHKx7htzPEp5R0Fw+MrYwWN7eYVCzWJ3/+J1w3Y+obrpTs95qPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174342; c=relaxed/simple;
	bh=rfHXf51t0qRkrv82pdwtMa/lMm00MKsg50ZbKXvNtug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g4ZYZgw924JtqNTWUxN0C16ydt8iBiTNyd/yvbCYgJCEOLA1U8GrAqqyTsQfvbrxzhB9YYRzcUJ9rInXjYpf7RkuyY4Z5TnKbFMIPvYtCyQoPT+745eRS53BGTW9MinRoELm4Lg+jvGfuxTx7iT3BiK4jWQsF4evlu7+3eXEWro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeCQ9YkR; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeCQ9YkR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788174341; x=1819710341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rfHXf51t0qRkrv82pdwtMa/lMm00MKsg50ZbKXvNtug=;
  b=IeCQ9YkR7ePqmUCINoHAf9vezN2BL5fEyio7YhTdT365HNBaD0zAjC+6
   oV93QgQQ9OF2jpKQrm9fnDgYRaY3UDNB1fyRx1+pmHtQUOWVJprBC9CJC
   NzUz5t/VrzBNTSKprAe80s8CmOrFjSv0Jc2YkCKX4LFZ+ZdH9dOe967Qz
   xwNWEJuwem71x+orJoQDBXOYYMENnoFRzb3IjRvAxqbR6a1n3UAb2Q6zi
   duK4XnRRVNrbccQ5MC4BOtUWp3rMETWm4xUvlLrkBHtWebOE1aQ0lXxRV
   vArLbXlZPCGplOJ9ftM/G+FsfuPyKp9dscGL55hkzLDDq1TVsooS4hNkI
   A==;
X-CSE-ConnectionGUID: FQG68UW/S+ymk0+nNgQ2NQ==
X-CSE-MsgGUID: QZxwpPG0SiaA9Yw70cy0pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="87526106"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="87526106"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 04:05:40 -0700
X-CSE-ConnectionGUID: 3cFSy6+NSSSuZduJo6LmPg==
X-CSE-MsgGUID: fT/HhgyeQW+uD5aST3sW9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="272277426"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 04:05:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 04:05:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 04:05:39 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 04:05:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVUD9mk7PaSYy5DK1sWt/zBFkTGtA9G4ERk74E5/c00ymO8x9lBIJL841z4FplVjxhmXpZGQ166n0XVsHcgy17WVWdrhnXPZgSFF4lVyOPwubPwjkegd1Mqdq9S4RSQaZdWsdfuQvjZcg+syRzNIJD2H+W4H6bRRyCplgZhwlksctdxIn2FFFdCt0ajHoIexnaK6PLYze9OL7WNe475o3YhFCo5dlfcvIjAEj973Ic8wDlV+IvkAqb0MVJo9ZQXjb7Gwn3Uk58x1HsmSctkRtHy6rsIdts6d+4lWrgFQz2GvFdXlLrS9/EBIYc7dfVAr69mFk4sUCuM/IOPONQly3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPDk22xpZ9jAkkDHwWampHjdp6XXfJ7nTMTUVMoq5YU=;
 b=qMmJY7bF1dgziHUxf/BfTWA+Q6EcOm6SFvbTyOU/yP4DcOFqrpaT9mQRYPucWtcibnPg2r58SVLcj2Sj9xZFnIrNW/g9V4MioZXNHWz4AwSX0clcy5/2ayrVa0DJmesv0u84s5QEBxjLlSWa/tTYP/7ZGXJ9YfaV2q0wmZw+bsFS/GPSW/cvlPGCegGPebM/VXfuUIg8+gdcgDdK9l44jIDIQVbKGiP1j9jvVvbv8gwwB9h5RmxiNkIWxoUNvH3k6WO5Plnzn4UZCiMaEF69WgJ1oGL2sqNtcskQVXllxXNm06Kwya/GHAdQb/GZQQ/2w5tdEEYy5H9/mM2hucWOTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by DS0PR11MB6421.namprd11.prod.outlook.com (2603:10b6:8:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:05:34 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:05:34 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ali@iusegentoo.com" <ali@iusegentoo.com>,
	"kiraank@gmail.com" <kiraank@gmail.com>, "Srivatsa, Ravishankar"
	<ravishankar.srivatsa@intel.com>, "Bag, Amit K" <amit.k.bag@intel.com>
Subject: RE: [PATCH v3 2/3] Bluetooth: btintel: bound firmware ID by TLV
 length
Thread-Topic: [PATCH v3 2/3] Bluetooth: btintel: bound firmware ID by TLV
 length
Thread-Index: AQHdOS96yZNA/nHHNEmc8BVZLjLNVLa3/srA
Date: Mon, 31 Aug 2026 11:05:34 +0000
Message-ID: <PH0PR11MB7585887D909739AB701BB769F5A92@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20260814171503.42684-1-acharyalaxman8848@gmail.com>
 <20260831095923.18830-1-acharyalaxman8848@gmail.com>
 <20260831095923.18830-3-acharyalaxman8848@gmail.com>
In-Reply-To: <20260831095923.18830-3-acharyalaxman8848@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|DS0PR11MB6421:EE_
x-ms-office365-filtering-correlation-id: d4a83778-405f-4adc-008b-08df074fc79b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|6133799003|10067099003|56012099006|4143699003|22082099003|18002099003|11063799006;
x-microsoft-antispam-message-info: QOO7xLGPzqfFUgCOIhCnQbYwslb+NGrGX6nmhmrSK10kgf5ZzNfpK84k3USNFDawkQOUAX8H3BZ27Pzg+tLK5C3yCO/9K8wy2UbpZ7/bfOnbE1bEKwAxAYGlWOk6ceZkeCSkZ3sYDWSSBIdLyTLy+0BZu9MzMCX8Ojdtqy9K8tA18ZnZBkq+WOxdmW/NRPM1rsz5BwcQ2MLsY6eXCW1+TI3id5w9SDgwj0iqJrmJktpa78ciDLkl6CAYdGrv2owDp7oFbWivmU/sLibT3S8Ozem5F7/BdJWjqs3COSnb3J0SQpiU7xrWKjbGSiwLamSWk/aknK7/F6BaCIcPNAFvZ53xqW2/CW8SJaeY8kZWQ5GYeJS35v6Aj4C3Ch0A8ru7i+KHMMZJ9J0baAEXCNsbnYgjdEGdQgIdCoEcLoOLUbwX+TrcYny1EGVKFJUNAraIHXW7VKwgcP70nxrcAdJ+bTEjn/FKZKLJCHg40T1jrwwX2TMbGFwR90YxiS8baMDq3Ei6k6gMrs/LHGPKLYA4Wk272oqhtYAH777IZ8iKz0RCAAXInec92hQ8ct1DTEvEoLpqEs2e9gvz2I/kcdqvkXDFKIWzWuZXl3qH3qg5wFbPAJ+XCbhM6IssrF1DxFhxWqb+EkieAsngJB1AytQS6CPCD1s7BOucgqaQN/dvLivDh+UXozyHp2n4tXzinl7KUQuDZQRqJeeoidyR6cfKtK7fo7a+PXu56fNFYJF5jw0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Col4qniOH3YSbbraOMeR7V4KiIVUYEQckLsFA04bd+BnHSFA07YLj0N80719?=
 =?us-ascii?Q?LL4DuFQ2FcrB5RWHXofaFPkBogPmwm+8FQmBnmdoulGqN20SE4ck9UTIf26r?=
 =?us-ascii?Q?DoFj1D1LQwzt3XWkjarvZT0cjcAiGfE3f4v1eyhUC9QfnwZNkcn21LZV6T5f?=
 =?us-ascii?Q?uSfJUvSjcT4g3zaS3yTVLYHPWSwcZ8inkYMQZQlYrkAr5V3GJciu3KmmOn6R?=
 =?us-ascii?Q?/OAEbZ6+cZvGBlSZIKJfLtiPxwrrFpv1xf5XdEtEsdttcocwNSv1Pfh+pAkY?=
 =?us-ascii?Q?/6pWTboIbN53928v55uMrgkcCdstJzCOB+tBOQN67ETbIYRwCjuz5p2VAiVA?=
 =?us-ascii?Q?w4wywNY+8Lf5bMRKlIxmTWJLLtFV2Eq9zn27IHdrlflE03tbdJfwNxOKI+ft?=
 =?us-ascii?Q?HWp1TnxaVpFpS6Z2nbpLzyUrGJhSwTzW36Fhu8vHGfXPL04novI83iC1cUUC?=
 =?us-ascii?Q?79rT3tetSh+/PGcF8olQyQlxIKyPX8BpwHbtmoFpbx39zg/PiO/V0lFHsymn?=
 =?us-ascii?Q?rQanRCri9B69QUA868lJXUi+eUZcKax3zeJdCMGzoMWkncxzIBLKym0sKWk7?=
 =?us-ascii?Q?Q5YiB8n7Pfru5RStQ8LT5iZCKoVDf8zRuzhVq2xlcHO/gqlR+BaYCRVsJZ6+?=
 =?us-ascii?Q?vhmqtysa4TutkllXUg6KNwjHIslJrOUF1/n+UF6hv1mBQnHt89UztT+A4sMW?=
 =?us-ascii?Q?/QTg4lWKf3ejkRskAmGKZvzBomZYDPrAGSf60TN77kUTquwtguE/t0UY3qRB?=
 =?us-ascii?Q?YotOTVouyi5V32hyKizdL5B/sboocQMz4JUG1RG0P1Grhmo4XK1zfRgmX2f3?=
 =?us-ascii?Q?e+OUOFa5nNQMl27a5q5CkSquInhNLBAskDAUlallhOsv8rTPmxyIMFdhTCFD?=
 =?us-ascii?Q?gMgLvLXSlnA4JFWjBXSYLDHqHRPyhJi2IGoL8lZd4A/Kbunhg3sstwHK0xpe?=
 =?us-ascii?Q?oh0GmdA0+fW2k4rXjgIONibhgrVqCn9NzLJMPp0QCWzV+yvKAkZMswE0s9yY?=
 =?us-ascii?Q?TPSTNUXh+4WChxzH9CoKV8m0Z+/iKyEZWF8C+8RIc7UwN+zEA9EcElfgUY+P?=
 =?us-ascii?Q?caG6yNSyNIEFjbJ9lF9FhbjAw5kV7i9tbyxyYKqRWATCJ7RFIPNV2gSKO1Al?=
 =?us-ascii?Q?Fv3KAZjUpWmy8iUKwYfiOswpT+dzLkCyzu8SV5n3Kbg2e+KgWVFaiGTNPuVi?=
 =?us-ascii?Q?Ev6B9Od9pfUZt+P8X7zIY+IebevcNsaK1P1vfT2Lk2rZeiHH3/VQP2XSbb7C?=
 =?us-ascii?Q?fndfa+/oiw/osW4phd1IG8iMKI2n+J8CiNVUq9FJjsgCYNS7Fk6vyF/EREoO?=
 =?us-ascii?Q?yJjdFpW+H91ZaezjVrhyfWiEbEIkOoE0mNvLRVNebGBT2s77qb1r9PEAcl/4?=
 =?us-ascii?Q?n+7NszT5fwAFMoOxYLlEuA35uypETsZEsBqz95xuE7VxAESt61Lcp5A8BTpd?=
 =?us-ascii?Q?01SrULYf3OP4bLzjFubVGfCI147ClKYGx6NGDhsGv3BmSxIfM/6GmSyMgv6I?=
 =?us-ascii?Q?EDGUVRH6P7IXWvKb0fhQoPp0LUv8dfHJgmBEN6taFpiEPC0ybuYDmq7y3PLK?=
 =?us-ascii?Q?rAgUu2y99IRoLNZYH9amJgyRvs09KN329LznFwLQ2RFZz4VXD1aiGNwotq9A?=
 =?us-ascii?Q?/RMn9eOGI+peMEe6eBgc4Kv8mZYAqRz+MaTwwQxpa/FtdtKjrYXQLpA+3E7E?=
 =?us-ascii?Q?FfX9GCCokcBtgwr3NKDuv7FZ2fX9J7fsPuABHiZCkxa77NIQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: naLL166trZYWyqDDCIDYK+4NnOUCGFLdBlm5wTyi28qopAdGC1yjl6VK64pTglhNxNTkytHtNGIhdjR3bskwpTe6VztzoTHcRzDnItOs8/8OYkuova6EOfkpPNEEtdi9iCVEnstO9/4seNeZ2VnKTaK5H+c9+n8H3fvhYJ5ZKYQANYwydIV9QKik6Ss3aJsnw3On0yyQkn35lV96D22B+w2lb+9WqGwaGgHRXNu9w+yc8czSjnhubQ0XmidHkWUBASSbOEx96FX5MqLYOiyRaFO3nxc56xGlMC/3T51bXhebM4fByI6pjOvEBl6hMJwWxkeNYKcgN/8E04S6mXnZQg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a83778-405f-4adc-008b-08df074fc79b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 11:05:34.2285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGezY0CCnt3dxlhnBjdvcIHnkvEdmMiEi8Kzhzov8f43pEVWnd/bcQyNKA+px3HexWbpb6lKe6Gk1drGf5NySA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6421
X-OriginatorOrg: intel.com

Hi Luiz,

>Subject: [PATCH v3 2/3] Bluetooth: btintel: bound firmware ID by TLV lengt=
h
>
>The firmware ID is treated as a NUL-terminated string even though the TLV
>length is its only boundary. If the value does not contain a NUL terminato=
r,
>snprintf() can read beyond the received response.
>
>Limit the conversion to the advertised TLV value length.
>
>Fixes: 164c62f958f8 ("Bluetooth: btintel: Add firmware ID to firmware name=
")
>Reviewed-by: Ali Ahmet Memis <ali@iusegentoo.com>
>Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
>---
> drivers/bluetooth/btintel.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c ind=
ex
>998c99b17..887170534 100644
>--- a/drivers/bluetooth/btintel.c
>+++ b/drivers/bluetooth/btintel.c
>@@ -704,7 +704,7 @@ int btintel_parse_version_tlv(struct hci_dev *hdev,
> 			break;
> 		case INTEL_TLV_FW_ID:
> 			snprintf(version->fw_id, sizeof(version->fw_id),
>-				 "%s", tlv->val);
>+				 "%.*s", tlv->len, tlv->val);
> 			break;
> 		default:
> 			/* Ignore rest of information */
>--
>2.51.2

Tested-by: Kiran K <kiran.k@intel.com>

Thanks,
Kiran


