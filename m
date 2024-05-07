Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90921509AE
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090362; cv=fail; b=E44wnkUxZWRa5AaE4dvLwkoYvQoeZfdDKgCNGE3i51w0OOTml8pOPCcCxAKt4xF+wov9ArO/Xxu1WcViDZYfkkWihDY/jmxyECHCWwD3gh+nXRaegNyrPCJp5QI0+/iOQxQCtiVQ2IxWn8TyhenhSvXQHE1+1GKWhlnNaIub+hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090362; c=relaxed/simple;
	bh=bpeVvHPL5xeSDU/rLQrNYZ8Tbp58yBIrK/6Qu7BHj6w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a5Ee1+PLxMYl8l+vucnnPSeZHO7CRkQRubev4N572p4Z9C/UWCIj2Fq4IICpTLS4T+C//Yq4HJru8WgB4N5Ev+NpiFJRV6HtNOULBKSsgL0EHQc0B1VTLHR4ndbv7IBolRuL8DbFqTiCxNdiiTO664q63hLfcsJGZy1wGQ3BGz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHe36trY; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHe36trY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715090360; x=1746626360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bpeVvHPL5xeSDU/rLQrNYZ8Tbp58yBIrK/6Qu7BHj6w=;
  b=ZHe36trY2Hfju1qQrKRw18ol5COljbfKWFsGL6wISFBRNbMFr1SqovN9
   YZ5DmKH7p8E1cI1ZGtYRtPQmpg1mMqr9xHn1din3VLbvoVivwVqwk7jaI
   iqTljXoMXKkEzixzKHm2p/09PUSPqQvhIW0I3g0+EM0CCv0MfGEEUoWbp
   ygUusIfVTkJzoF9WCnlikHv/Z5JVM2EEeNYO09UjtsY730Us/flUQKTTW
   9eoVALeW7PI8OVr4iHTXtOl2j7iN7S7s+Fe/2pM+ZFoSC90ShEIeoq5n1
   kka0Phi+C/lAcGinQYH3Zwk8mTVhbjIDJN7LwS/MRsn4t1HaAQoLyFBEt
   w==;
X-CSE-ConnectionGUID: b9aCyOJvRKOFKk/63krGDw==
X-CSE-MsgGUID: doN//ALETBGK41O6c1vk8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="36268021"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="36268021"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 06:59:09 -0700
X-CSE-ConnectionGUID: ngkKarMtRrKZuy6b/2ZBdg==
X-CSE-MsgGUID: jFvMtAftRm6ZPhRgtxz3oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="51729304"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 06:59:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 06:59:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 06:59:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 06:59:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 06:59:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ka56SCTuVTmrf9Hk0hc0fBmoSbfvb4bSnFE6WBx9O4ij1nYGspSSen0QmBew6OSqo0XyQ7vE3m+43WExbxDlxCTD3sjVC2g1AzpFJ0lufzpTPvHbXk0SGuTE3n9X6sBEdLIPSwgr3lL7HYaxHicgl7dBUEEc4oMfQfb14MAFrrii5Fp3HgzBTbq+1e14UFIbES6UCv2klDs7+QeTcjDclSsHLK3FY8jT/2lSHkFULAEc+tEh/Gf+yPWQ0IksFmblKi+wjf/ruL55W9826XRGo0U8XHSDW16sX4BRVQj5v1yrr8DjhCImKjijraslid0xNHqwfAtrAZDzEDFqtAOuTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkrGsy6H59QSNV/oytotA+e2KCM6Lx6FB6R4KYFocYY=;
 b=ijgbhxcHtO+EVLRhNLZpyLquav6PeRa6xn+D8BtKQ4u6lNHocwMHQrpSEf95vpG60kVneKULANY42/ofIgrs1XkB3+Uj7rP1AX71syHvXgcMxl6wAe8f9GAkrRrItnm7e64gZyX8SGvT+QIOyk5rnQLXotqaO6SLNGq3g6my5ZvgmeZ9LHM1howvyPSnSQ7VlW2+lvfW61cfCxhd5NmYrdYV3qmBIjbnsTJQHIO1fS+R7mQp7zkUaCS3lkIwPdrX4tHLkFsXRL7oslL/nqOODFYX0A1BOvnisPs0xZNE7rz/NZhrW/PD04S/3R3ZDNphEZ42p6/WTutzoFY9pFBI/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by PH0PR11MB7421.namprd11.prod.outlook.com (2603:10b6:510:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 13:59:05 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 13:59:05 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>
Subject: RE: [PATCH v1 3/3] Bluetooth: btintel_pcie: Add *setup* function to
 download firmware
Thread-Topic: [PATCH v1 3/3] Bluetooth: btintel_pcie: Add *setup* function to
 download firmware
Thread-Index: AQHagP/adJNL3NvsIE6GVsdD7VhRo7FNYx6AgD6oD/A=
Date: Tue, 7 May 2024 13:59:04 +0000
Message-ID: <PH0PR11MB7585E68BE8E075D7349057E6F5E42@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240328111904.992068-3-kiran.k@intel.com>
 <20240328170831.GA1570559@bhelgaas>
In-Reply-To: <20240328170831.GA1570559@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|PH0PR11MB7421:EE_
x-ms-office365-filtering-correlation-id: 19ccdc30-5d89-4c63-47b5-08dc6e9ddb66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?T4rqj1/Mt7OegeDbwHrT6l6jxgl4C0wL9RdBiyUGRwoAXkQC7dq5nySkijJY?=
 =?us-ascii?Q?Y5VTqOba12LoE+faxLKcAWWcPqcX8WApD91W0DmmL1mKBoyCcFMd7yfzcW1w?=
 =?us-ascii?Q?APqlMWn6QWf8loNTZf9IRObfJWx6O2wduOJAI81Sbh5Ve/AnW659toGIAGC/?=
 =?us-ascii?Q?RDlkmS+HvCWoeuHlOFTTKtoH772Evbdm3DlF3UAahI/2kT3vNMX8XNHOgXgx?=
 =?us-ascii?Q?FrHuLZC5QOZRGGPG7rDisVwq00xTYBbusVa7knwLVRA4m0Mi6AML/Re0okY1?=
 =?us-ascii?Q?etfYzdAMcUF8wmadxCSH0IurRJUpCg95KH+Dzpnekvuw7npfO9EsuFTFF4lq?=
 =?us-ascii?Q?ABJyHwxKDI7nbtGJDcUHk5cZh5MGM5VpKeXxAQIkfx3To5h1jdgpRdnEepCB?=
 =?us-ascii?Q?pbKNmEtKuLt7D+eE8lNRU6bJNHOWhMf8CA/q6GaYeZR4bF0AJFYGu5FxYoB/?=
 =?us-ascii?Q?tsqVwE0urtcq3VGjqO1rJsGzCK4nzYHA8w7znD+DkVw5Bht3541VxNXpVn4f?=
 =?us-ascii?Q?gk86cqaZ5Yo4lZDXzTXT8F/K695IlXNmdapmjThQCFangjv/C/4mOyPtSvT2?=
 =?us-ascii?Q?39cMccCGuSq/7DncHY9KXyh/rSfQRM3dk+VLowKR71HfcFgdEZgAMTqQmRGR?=
 =?us-ascii?Q?nsgZlw7+4BXIRdgmckXW2lSsxHBOcXyQAanRoskf1bdRv9uDDwcLGF4JNpHr?=
 =?us-ascii?Q?i1GsqIrzIVE0wgyiE8zJqCud4ygC2YNTC/ajE74zUDcOwQYGntakfUv5+44M?=
 =?us-ascii?Q?BZXiB3TUzghlbqKE/s5yiMok8ygmBZE9pEv2L23FcDQ+YHIk/v/gT0ueSA0P?=
 =?us-ascii?Q?Kgbz1PPn7sjZBV327M+08V0V/6pxKYSXVKg1Yjapr5dIlC9xKX882qvDoi0q?=
 =?us-ascii?Q?ze3cXgogWmAp7egcKJRKlvMGjVcF7Yx3a3ZS36+vfvl8CmlR2heBK9E1pJO8?=
 =?us-ascii?Q?Vi9FgGD6OlLWiUNv+IWmpoM6RaNuCzUNmo2fpjTplT0Q8HhW8OYMcTiyVO8h?=
 =?us-ascii?Q?Yvim0XZRbs6heGga43qZcbO9iHFQkr8erH/K/TyTSfrQx4/0j3a8bzkgOuVs?=
 =?us-ascii?Q?17m1nDNzndd7YqVog04pUV2OK3mIXOAlF4Ay/2H3Ukl8oMIelEikJJm5rAsE?=
 =?us-ascii?Q?5ThT0DiDkL0osTkUnMTpYAdaJX+16wpHmIqMyDfR104J8MjilOs9N79uCjll?=
 =?us-ascii?Q?5ZZstyp8sPQ5kALdch+GJkx+K13w7WgFm8Pw+lg2M2JxaOqWMzyKmfw8fKnh?=
 =?us-ascii?Q?c0jOgmEYBbh2aN5j2ZF2LMoZbTCxVtMhRHKqffe/VWeBJ0yKtOst3sbWMpXf?=
 =?us-ascii?Q?X0/3/mp0z5yirejvdb3gfrSRUgDYf5ij2gKbr1eqcXv/Ag=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+/Y0PlJEkUIGO/OvkWcVHeebuaGO5lnDzhlHExqBaw6mzMZEqYS8/u3EAq8a?=
 =?us-ascii?Q?6pT3H8wsgFy2ZV56fNAoVDHiShzKNvi0kWGs/dwgiC8+0WRb8IgtXaPvdEmC?=
 =?us-ascii?Q?xJFkJleGaVVQwxEHm7Rc+IhqeAOOKslDLlpZgasVyppIQix9lkAw5XMGbScE?=
 =?us-ascii?Q?3hwmz0c2XTl2f8Dn5cOUBgkOxucn4DwXag9YCteLH/NrW4PLPjqXudJU2KAf?=
 =?us-ascii?Q?Iq7lE185u0oyWU5uQMO//6UAbdr2fZoZEwOmXTarGcKPx14Rm/cYICcRWIbm?=
 =?us-ascii?Q?/O6hLzsZOnCsNbiKbCS6iya4tRrq15zYD0YEJqbmcQxETWiX7wDOiSnJ5q37?=
 =?us-ascii?Q?RAfQte8URO1/OEuo6SVPVO5u3nNywZuBJM0OeDHKLnh88HKt+Ksuos5l1efl?=
 =?us-ascii?Q?WbKzpdmrh0Iszz8z6sCbhWqW59sb9ti7nvJl5DPCyphOkudsaoWQ8vRTu+hP?=
 =?us-ascii?Q?la9+89XwAj7gjryfl5KM2tY403NBTPf/jxym1qCW8f0i3g1rtQE4sXJuq1wC?=
 =?us-ascii?Q?A2rfCmjh0IJVMOcCc2waTX8/ZbBbVRhqpiYk3I9gAzOg6CiCDt2Q6713ZcKL?=
 =?us-ascii?Q?Yvn1pqqDwB8nHtIgAor3W6/Hq3cWscyrH9wZmQAzpxnmwDDCvEX1gZ9LNwFY?=
 =?us-ascii?Q?p9+zpRJFDIGe9REdXsCRL7ywB8GiqEidgv7C+jFJW+uPnnQwQBHmlMDPRH4q?=
 =?us-ascii?Q?DufJUUiNQBD+iRb3B8pT4Ka8D4z0KTRPUQ1pYxtdYnDvBqPePB2TdawnE3jW?=
 =?us-ascii?Q?LTcF191WSkkzRhkm68Q0MgxESjgGkkTkSm6bbjgABI2Mk1EYHnLuKvguS1x8?=
 =?us-ascii?Q?o22CQ8e/4U/M0Jd0iYZAzwaLPe3hH4hmW7+dVMjEvEhoXSIiVBqk0e6bU3nb?=
 =?us-ascii?Q?nJIBCKFWqrzd266HkbsSwd5j16DKyUwgo9EbjDx+TeyXnKOOppREgOfsIp3G?=
 =?us-ascii?Q?i/ZBdP4QUsbEIWw5tjPL2+Hl+Q1jJzo+uLfn5T5obylTJFjT2beEjJkXTH8i?=
 =?us-ascii?Q?Xh3cJDeSI3h85HyLLk+yL8kvij6th6vwe3pMOd+aLFLgYuDxBWu9ijxhwGo6?=
 =?us-ascii?Q?AEoR4/gMFV/W+zJDVJoINJLSz/vK0QKor7Swv8hJf8uLROYqrQ3hLIyG/NvS?=
 =?us-ascii?Q?8C77oERJFYAe5vj8v7lzcAaCEc9LwLqJUh1Zp/xDReNJXez31P7J/Z6l+45W?=
 =?us-ascii?Q?WLyn7jX8iaCu3zRtA+5XOnWKYYVbWLW6k4NFwJ4DfpjqEznynZ7T0202f/5K?=
 =?us-ascii?Q?kchDBWEPiNiCG8BVyYPcHxaQayJ8Sp2pdi7q7w8qpvbPCtAKCEPX4feFoDmO?=
 =?us-ascii?Q?93sfsN+a82+0a5Cqbc5jdvrhGRDLYIKZyzMjBso8GyTMppyq1yJX02RNs3iR?=
 =?us-ascii?Q?fap3SGACoBzf5LtocKqyqm0pTo5ebrE/NJWNL6aWBgl3CltrYE5uSSyv9vw+?=
 =?us-ascii?Q?F7FSwQ+E/eG/6YEHuVJ6cM0u8qnHxjvqK3j15x92tn9EySpsahoeGCM7obaR?=
 =?us-ascii?Q?HAWYqFPHRx9NBqB/vnavO/a9Ch0rYN4cLHJ9npIu9iAJZjhgRGDdYx/4lZM1?=
 =?us-ascii?Q?xm9RXJduoIcHm2jafYg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ccdc30-5d89-4c63-47b5-08dc6e9ddb66
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 13:59:04.3516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0HdfO33TuoAft6S80mc2ouEX3+Y37AvFSBStUfw9rR5I5PWEJTBWOYmaOuFoTEKD5bdX1bV33B/YrFRSGzZrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7421
X-OriginatorOrg: intel.com

Hi Bjorn,

Thanks for your comments.

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, March 28, 2024 10:39 PM
> To: K, Kiran <kiran.k@intel.com>
> Cc: linux-bluetooth@vger.kernel.org; Srivatsa, Ravishankar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>; Devegowda, Chandrashekar
> <chandrashekar.devegowda@intel.com>
> Subject: Re: [PATCH v1 3/3] Bluetooth: btintel_pcie: Add *setup* function=
 to
> download firmware
>=20
> On Thu, Mar 28, 2024 at 04:49:04PM +0530, Kiran K wrote:
> > Add to support to download firmware.
>=20
> s/Add to/Add/
>=20
Ack.

> > +static void btintel_pcie_prepare_tx(struct txq *txq, u16 tfd_index,
> > +				    struct sk_buff *skb)
> > +{
> > +	struct data_buf *buf;
> > +	struct tfd *tfd;
> > +
> > +	tfd =3D &txq->tfds[tfd_index];
> > +	memset(tfd, 0, sizeof(*tfd));
> > +
> > +	/* Get the buffer of the tfd index for DMA */
>=20
> s/tfd/TFD/ for consistency.
Ack.

>=20
> > +static int btintel_pcie_hci_send_frame(struct hci_dev *hdev,
> > +				       struct sk_buff *skb)
> > +{
> > +	struct btintel_pcie_data *data =3D hci_get_drvdata(hdev);
> > +	int ret;
> > +	u32 type;
> > +
> > +	/* Due to the fw limitation, the type header of the packet should be
> > +	 * 4 bytes unlikely 1 byte for UART. In UART, the firmware can reads
> > +	 * the first byte to get the packet type and redirect the rest of dat=
a
> > +	 * packet to the right handler. But for PCIe, THF(Transfer Flow Handl=
er)
> > +	 * fetches the 4 bytes of data from DMA memory and by the time it
> reads
> > +	 * the first 4 bytes, it already consumes some part of packet. Thus
> > +	 * the packet type indicator for iBT PCIe is 4 bytes.
> > +	 * Luckily, when HCI core creates the skb, it allocated 8 bytes of
> > +	 * head room for profile and driver use, and before sending the data
> > +	 * to the device, append the iBT PCIe packet type in the front.
>=20
> s/unlikely/unlike/
> s/can reads/can read/
> s/it already consumes/it has already consumed/
>=20
> Add blank line between paragraphs.
Ack.

>=20
> > +	 */
> > +	switch (hci_skb_pkt_type(skb)) {
> > +	case HCI_COMMAND_PKT:
> > +		type =3D BTINTEL_PCIE_HCI_CMD_PKT;
> > +		if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
> > +			struct hci_command_hdr *cmd =3D (void *)skb->data;
> > +			__u16 opcode =3D le16_to_cpu(cmd->opcode);
> > +
> > +			/* When the 0xfc01 command is issued to boot into
> > +			 * the operational firmware, it will actually not
> > +			 * send a command complete event. To keep the flow
> > +			 * control working inject that event here.
> > +			 */
> > +			if (opcode =3D=3D 0xfc01)
> > +				btintel_pcie_inject_cmd_complete(hdev,
> opcode);
> > +		}
> > +		hdev->stat.cmd_tx++;
> > +		break;
> > +	case HCI_ACLDATA_PKT:
> > +		type =3D BTINTEL_PCIE_HCI_ACL_PKT;
> > +		hdev->stat.acl_tx++;
> > +		break;
> > +	case HCI_SCODATA_PKT:
> > +		type =3D BTINTEL_PCIE_HCI_SCO_PKT;
> > +		hdev->stat.sco_tx++;
> > +		break;
> > +	default:
> > +		bt_dev_err(hdev, "Unknown HCI packet type");
> > +		ret =3D -EILSEQ;
> > +		goto exit_error;
> > +	}
> > +	memcpy(skb_push(skb, BTINTEL_PCIE_HCI_TYPE_LEN), &type,
> > +	       BTINTEL_PCIE_HCI_TYPE_LEN);
> > +
> > +	ret =3D btintel_pcie_send_sync(data, skb);
> > +	if (ret) {
> > +		hdev->stat.err_tx++;
> > +		bt_dev_err(hdev, "Failed to send frame (%d)", ret);
> > +		goto exit_error;
> > +	} else {
> > +		hdev->stat.byte_tx +=3D skb->len;
> > +		kfree_skb(skb);
> > +	}
> > +
> > +exit_error:
> > +
> > +	return ret;
>=20
> There's no cleanup here, so it would be simpler to omit "ret"
> completely and return directly above instead of using the goto.
>=20
Ack.

> > +}

Thanks,
Kiran

