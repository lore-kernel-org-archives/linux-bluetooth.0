Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199DD6F312
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313404; cv=fail; b=hyLAUEcbUBHuxlJRhOWIk/TwMjWLdeM6K+OBwmv2FjPbnnGLaPkV6vqNMM8KxFxOikcAztI/PfqA/o701lZ6FbKx/XTw9LLXUQv6rnhhBToDgOLE4wrrHDiLVfEyQDQYw2yHyFwXkXMvuQOp1Ob0QXgx4WamYDDDKWAU/PUKu3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313404; c=relaxed/simple;
	bh=AkSsqEIUPm1at7vlHEDYru0C66UOgmEkA6/AclbEUpk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hRvdepYxKbaRFMzw/Pbq7WEOEGV5KgkVsz0OitN9C46VZ/VeR2mVdpKg1iDU330FRzaiBKr+AEVs9csMx36H2ZmE/h6FELoSp4OdMM7f6WvS1sEjwPRkRrzlphQyFOaR/XAHkv8XOvelY1aAtUfzetqXp1ZMgOWv+IZn50Yafww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHXALI8V; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHXALI8V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721313402; x=1752849402;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AkSsqEIUPm1at7vlHEDYru0C66UOgmEkA6/AclbEUpk=;
  b=HHXALI8VPpPjywm7/DxfrbqeRLDr8G+QWivn7Wq26wO1wW/5+LPuNw6I
   Ok8B7MVL9veHtsMxL23YCMHZExXYjXSNGe1FuamI55RU/jBHNvU5HyqSh
   CDz/YmUs3ie7Gkk74lXYEmjeNyK5TfRQg/Ba5EkbQ9b9fXxz3ZyLtwpzF
   ymcNlFzX79nuHB3ObarqcoX55Kz8J5hWgK4SpS5RvrNyyQgjpiUXpBPMS
   9gAC9NMZUumrRcwJXayDAOvvLP3xtQCfyVYHU48Zrk4DfFDyQUPs7DqNF
   v7RbOXIDOWGDXAAVD4lKUaqifx2FYscDYdnRrdHbATaRL7/wz+/j2aGON
   w==;
X-CSE-ConnectionGUID: EQk+so7VQYeJtQYrmetP5g==
X-CSE-MsgGUID: ARzLMW/LQAOpqE2pOm1HpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="18724961"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="18724961"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 07:36:32 -0700
X-CSE-ConnectionGUID: CA2+WIhwTFKJHHktBfrsxA==
X-CSE-MsgGUID: wieswQ1URjmVqN9oXSNKqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="55623894"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jul 2024 07:36:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 07:36:32 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 07:36:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 18 Jul 2024 07:36:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 07:36:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJHviuKhzWtsDMf3lCRK0tBZK1BmxopWRYSCe2LJBNRdBC12hOjVuDxrJFz4jQ/1PbtY4NqvWEnQYSiyg6FAYioxiqfxPBLpr+x+4BrAaWCJ4FIBAmT2z8YH8s/TZEcN9uaFTrS9cLW3x5fkl8MvlraK4yUIYv9ggdvIDds492NLwpFx+HE2uO1rEHGQyAXLNlgT8rf/6nJPVW1P52SKgZhK4sgC03XYRHY8m9TPcjQFMIkJpYVER55s05+gZ1yqIPX3cxZF8H2alC29I5NLbNllEb3F8kXlXKTjKi+qff5gPahQ4zLCg3yFivEZez6xmMzN1r6G1qgokELq6YYitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkSsqEIUPm1at7vlHEDYru0C66UOgmEkA6/AclbEUpk=;
 b=ogiYTsrNFYMRBIGYx5hkjqYfDGvP+V4o+f1+6UKvtwjlghU6H9bc9Q1PfffvRgpetF86JnuiTM+gLSl+oRqVh/tuen36bq40E1OE1zcRD2W5tf2NjniJMp68zCMnSTIvf1ptZB1PI+Iv+klIwLZ/zzZ3d6c8rrYgePRvM4qQfkeJwuzCVEHMhFH4z3F6U7JxBzQwppt9cDWh84bK4xYUlMtJjd0Ma40xG6+GwAUNx+7eO+/rV/BqQxpVmWaiPXvN7fDIfRkeM9xdLujDdGtI5a7hai2DWXh9CsWVcv2OvwneCU4JmmJXJ8NCTUlP69zUwuia8jnOrF93ovB1MXztFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by PH8PR11MB8016.namprd11.prod.outlook.com (2603:10b6:510:250::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 18 Jul
 2024 14:36:29 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%6]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 14:36:29 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, "Satija, Vijay"
	<vijay.satija@intel.com>, "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH v4] Bluetooth: btintel: Allow configuring drive strength
 of BRI
Thread-Topic: [PATCH v4] Bluetooth: btintel: Allow configuring drive strength
 of BRI
Thread-Index: AQHa2RhgjG0chqdeL0+qBmmVrYmzmLH8jPWw
Date: Thu, 18 Jul 2024 14:36:29 +0000
Message-ID: <PH0PR11MB75856EC8BE34072B6F491C5EF5AC2@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240718135655.3948028-1-kiran.k@intel.com>
In-Reply-To: <20240718135655.3948028-1-kiran.k@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|PH8PR11MB8016:EE_
x-ms-office365-filtering-correlation-id: 6f07eaf7-c877-4edb-5486-08dca737030a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?OvJJfiqCegH5+jPYUmy3/cDrClI+gsEaUET/6mCcdANvy8zU8N84UnLqic5k?=
 =?us-ascii?Q?bp0Bd2UD1f/fVf+l4ZRCoJd9F9Zj0FVdLMg7Su6ur0CSKG2Vre5hKTB9dK9i?=
 =?us-ascii?Q?ZyePBDJIVf7Z8uWTACtieMRt9hvfe54l/yj9n7vcx6PRtslQb/VMLGj441vS?=
 =?us-ascii?Q?D3PtMJSJxXlFB0LDNlCJ8D5U2HJsATA0D8ozu4P3AC7Hs1Ei61kNYPsA+kPa?=
 =?us-ascii?Q?gdK1UC7CDD/zwvw9S4TdGQH41XfqSOnlIsyQFg8lEkwoJ8xRl2WcCmOZo0Ol?=
 =?us-ascii?Q?m9TdiH2WVHiq3VHsjLyT028osD3UeO2GumcKUuq2oCk/T2M+o5PwSnjx3+ed?=
 =?us-ascii?Q?gQH9gNo8KEwuceGQ1SQvKgdu+sHlt7vOSGNodfSxH5JHWa3IQJLn/4B0h8MG?=
 =?us-ascii?Q?F/8LztegDzNu2ccuPGcPV0Xvy42HvFmFWtS2LRls3Id1WsLRRkE5shIvuVw/?=
 =?us-ascii?Q?3QQ4BTnda9iT0204aEnoKCgB6Rz1n0+ZSP+hTl40ygjopEXnrYLtdJo4nAKq?=
 =?us-ascii?Q?hvhQ8OHrBmoI5QIWpW5GUwggZws54Ke3ltax/wyE/tcsF6F21CAL5HB5/uV1?=
 =?us-ascii?Q?D9ybTXzVgFOnEEqCP2icOqI0CPQl/w7/w7zNUI01d6jan3SIaiofJMMiGj0m?=
 =?us-ascii?Q?8Q8Lin3jj6edFdx9MbFIMKmipjv0SkDeqXJCXsXUTRsjerdCNJ+M9TszoNHd?=
 =?us-ascii?Q?NJd2mNNg368qJlYyrXx7cNQhtQ0qgNYc6OgRvVlZW6VTR456oPRsv7kmAlYP?=
 =?us-ascii?Q?fKARTdjMETE/Hz+gUgEAs6Mgp8dv+ZeFTgCcM88l0UXcwl3oMSoEAVhwZ5tz?=
 =?us-ascii?Q?lNGIpmWeeBmpITVFKC+BlABJltRCMB1YcV020m5GXbHIErEAOwF1LngBVlam?=
 =?us-ascii?Q?cDs7ip8oY+CHhNa6rPiB6lpQeThGJ+7DAzbvaSSzw5WNYlShS1uVc0kW+8Zq?=
 =?us-ascii?Q?JoEbRIQJIxmEGtp/mE4G0OrRJqIRLr6ojK1Y5dqWDAmsHlU0PmeQs+qfIzJg?=
 =?us-ascii?Q?LAG6ShnnMntYovnoE1MPZ8q1+nbapBfAzTVdNyvL5SURp8bsCKvEDB7fU5o3?=
 =?us-ascii?Q?YkLnpcwkbWKzYP6CN3sK1WfnTBU72LbleZ1NcFIMTdN8YWCoD+dW1cWIcIbC?=
 =?us-ascii?Q?Key6vXloRXaGK6gj5NhbXAGQbhBZt1hTMvPY6lIpQDLbDAUf1x0H+DJJ6HXe?=
 =?us-ascii?Q?RSMnXl3ZRfNLB2jGR9odt6ZfbO0QPwUEVUIRtVkB8SdXyArnh4h/xeEG/yXN?=
 =?us-ascii?Q?DWCqURyXJAcsUhPxk9oRNKiyLJHpY9HQrR5NAfQ9NmebzawLAcZ5nx/1ZnYM?=
 =?us-ascii?Q?xcgZgMaNvlLODKxTUTPtedzI8K3/7UZO0x0Kc2CmLCUsHxPvMJa7s1514zyM?=
 =?us-ascii?Q?bOBc4IXl5IX//mVskt9fl2oQO+q2pqO10E++pVgw7o2d29ot6w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r9UYl4fEXQm2/LJVYxpd4tq/aa/QW15AFNic4NCIoSJnxQICRuUBtc7gBFT2?=
 =?us-ascii?Q?ftLNvjdUPJb71Po/wlH9+rCbNLVqxvBUh3EW27h+p4lN3jF6uiBuV8KdHzXG?=
 =?us-ascii?Q?oga4Ck3rBMqERXExWxz9luUecpcc4ob/TKNNetE/otHJz6ZNZpXPuHwhchyN?=
 =?us-ascii?Q?XsvasevUm0MP9UxFm0RfvTnRTsHqjeNClh4Tt8J/Mvnd1St0U4C9drGUzloH?=
 =?us-ascii?Q?/sWUp85Wv62cHvH1Kc/puqH8QykzpxuV7c7EYxThCMvjm7A3aERy2ukxOtga?=
 =?us-ascii?Q?crM8UxB+Muh9OViy/XeHAqIoJrQbrmBjSA5qKBnn0VemIEMvNqT6QnbJu/1y?=
 =?us-ascii?Q?S5Fxv8eeGUihL2PBg3bw1q7tQEg8fycfz3T3ucXhyFvPyz7Nf+UxoWXIuN5F?=
 =?us-ascii?Q?NefvxFBn50+uPPgE80vXDxPk4QfNu3iB/7TF862BIrI6ZEiGTbsxobwBMohH?=
 =?us-ascii?Q?D8bQlQKcvUrz2t9KTPnVJ5keWfFnVrJaH++Q/Qkt4RnWXiLhEqXkpFprBlOK?=
 =?us-ascii?Q?Zy2GmuI9k+hH3skkctHE0TSSnuR1Pg6Liu9llM09J5YXtzXKYX48V6RVz286?=
 =?us-ascii?Q?NwnB7ZNhhETrK8+GrE646hUJ4hENIxvJkg8rUdUzjfSq1gzCddwpR2/KWkkU?=
 =?us-ascii?Q?Z9GeNsPMawWg8GsYFk9RtXPw34kh4Jv3gMcVuv5M0i7/o23879epYPsC7ZDN?=
 =?us-ascii?Q?K1yy4r/oE1A35OtrS91zj9X6PT72dKs/OMTvzzs0rEn7WI9Ea5TTJxGah4i3?=
 =?us-ascii?Q?YZ7Wg1etIeneoc24qwHC7HjLKCx9PbZt/7BsBil0VB69EP8egSaf1tdBZNQj?=
 =?us-ascii?Q?KRDV70luhsOGFFmGOAl1Nj0aXq0fmnI+aWHVUvzz3boOD3/AIhiT7TSgJoLh?=
 =?us-ascii?Q?lnnSG0QXbym9xTGCPSQqnTu5dQjO9CuiDHeJ35qxdmUQrxaIJWhJehaFPWdD?=
 =?us-ascii?Q?XuDrkuOye6UlqhEu/vP3k2MReZUts1/y2HbtQMnoXBWaI3F/v0Qmup9R6DVg?=
 =?us-ascii?Q?pcG38Urkh11m3/u04i8QfyYUYIlvyJ1Y8AQpUEpD3YJsyGcSwfkcsDZtgfMr?=
 =?us-ascii?Q?wwmtFlojMDPLJR8i7sQ3tHaPz+bc56grod0KP8F2Igw8oUoCiWgDLHlUSotc?=
 =?us-ascii?Q?IMEvR2sNzsUnOTfE+2ku9Bs8yhft0cw75xS2y18eFH2bdDkeLfgSUeXWrQyX?=
 =?us-ascii?Q?TRL7+vy9sG+Kge4hB4M7LlK9CAMf04lv8ESdS8gaTpENiBaCYsqTQmjXPxVG?=
 =?us-ascii?Q?/jC4pEZrq+CSwBQ+zef6n+L1lAh0niyhOS7AOqHgiZClHU8/Av6heRmyYOxR?=
 =?us-ascii?Q?MPrJm1hBCurNkPw9dyf5974rtgv+LisqJt2fNhlZPVTfuKafkGwsthSxbmJt?=
 =?us-ascii?Q?1p8mIa4ReE7ttVXETp78F94QCdv24kjZ2oe64+SFhv7hKbNGvB1vDPR8XFLd?=
 =?us-ascii?Q?RD2qxRFXG13uAapN4mrXJydnvKqHn6ZWnnAPNaz2gRvxOKKs5pOzF1zp+jP1?=
 =?us-ascii?Q?Fpjw0xdx4cRTenZFI3BrJQY/+p+bA+k5r7+CFEB+i4Fm1ivnE+yMJ/dba8fR?=
 =?us-ascii?Q?hJPKoBM2vgL6Mp9PNdA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f07eaf7-c877-4edb-5486-08dca737030a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 14:36:29.5346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F33sHgOuZXI2M9ZkMKxmdWZS6dBmvljJ4ZTbgUlIEoV55xlq3BgABOiEPeeCA1/aGWzlVcRyZG5bA1RMVeEi6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8016
X-OriginatorOrg: intel.com

Hi,

>-----Original Message-----
>From: K, Kiran <kiran.k@intel.com>
>Sent: Thursday, July 18, 2024 7:27 PM
>To: linux-bluetooth@vger.kernel.org
>Cc: Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; Tumkur Narayan=
,
>Chethan <chethan.tumkur.narayan@intel.com>; Devegowda, Chandrashekar
><chandrashekar.devegowda@intel.com>; Satija, Vijay <vijay.satija@intel.com=
>;
>pmenzel@molgen.mpg.de; K, Kiran <kiran.k@intel.com>
>Subject: [PATCH v4] Bluetooth: btintel: Allow configuring drive strength o=
f BRI
>
>BRI (Bluetooth Radio Interface) traffic from CNVr to CNVi was found causin=
g
>cross talk step errors to WiFi. To avoid this potential issue OEM platform=
s can
>replace BRI resistor to adjust the BRI response line drive strength.
>During the *setup*, driver reads the drive strength value from uefi variab=
le
>and passes it to the controller via vendor specific command with opcode
>0xfc0a.
>
>dmesg:
>
>..
>[21.982720] Bluetooth: hci0: Bootloader timestamp 2023.33 buildtype 1 buil=
d
>45995 [21.984250] Bluetooth: hci0: Found device firmware: intel/ibt-0190-
>0291-iml.sfi [21.984255] Bluetooth: hci0: Boot Address: 0x30099000
>[21.984256] Bluetooth: hci0: Firmware Version: 160-24.24 [22.011501]
>Bluetooth: hci0: Waiting for firmware download to complete [22.011518]
>Bluetooth: hci0: Firmware loaded in 26624 usecs [22.011584] Bluetooth: hci=
0:
>Waiting for device to boot [22.013546] Bluetooth: hci0: Malformed MSFT
>vendor event: 0x02 [22.013552] Bluetooth: hci0: Device booted in 1967 usec=
s
>...
>[22.013792] Bluetooth: hci0: dsbr: enable: 0x01 value: 0x0b ...
>[22.015027] Bluetooth: hci0: Found device firmware: intel/ibt-0190-0291.sf=
i
>[22.015041] Bluetooth: hci0: Boot Address: 0x10000800 [22.015043]
>Bluetooth: hci0: Firmware Version: 160-24.24 [22.395821] Bluetooth: BNEP
>(Ethernet Emulation) ver 1.3 [22.395828] Bluetooth: BNEP filters: protocol
>multicast ...
>
>Signed-off-by: Kiran K <kiran.k@intel.com>
>Change-Id: Ia51d0d86b980fcca1b12247ed8fe9ae9d2b06307
>Reviewed-on: https://gerritwcs.ir.intel.com/c/bcp_linux-bt_drv_kernel-
>5_3/+/117825

Please ignore this patch. I will remove the ChnageId and Reviewed-on tag an=
d submit again.

Thanks,
Kiran

