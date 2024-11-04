Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ADB6FC5
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711910; cv=fail; b=YToK8G6/Xkk5zV6vChgN9QQioQfmJVAY63PLFIEQChwfOXaG3H6ssCH4wKTP6drJwauYpsffaj9QzjDrQ0Kofme15QocyzWNnY6MU0vkd+2waHr+UtSYaCyT21t1DMlt6jyfqVtEj6WKwDdEKX6u4dEe3vZKsZWnjqZQ3ecwh5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711910; c=relaxed/simple;
	bh=RPlH4r7D+jUlOOzWSaGOLQ8ZNF/1TfANwQW4YLr3ss4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aYBrmebPN/SQPZPS3sjai5Q6Yf2VybmdolR5opElTJ+IGbUuMjm/goCqcpngZx4aX42L7VxVLPdcd/ph5DLxsVNR8JaxMZHELaH37ARkTugTzfbWU0hsvyo0nNr2iEnz8I6LYl5k+s0z4EbLN9AEuAjodWDgTAeMU3iJtVAuNt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djEtYMtn; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djEtYMtn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730711908; x=1762247908;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RPlH4r7D+jUlOOzWSaGOLQ8ZNF/1TfANwQW4YLr3ss4=;
  b=djEtYMtn9ecZXW9aHGBXtmxuojnZP6pFAdd/yC+Xw0nFtpgh680O+AbG
   oZgt/SJfrFNfeN02tUPLWIpWtIXct6Gb1bEunT2sSXnilwzKOCtfIF472
   PKRnu4anNAWxD2rbqrguHMOB/kyN5vap/BHoEZLJZrtMmntQbZxO0J5ti
   BUw7pGDAMEkUde4nzONh0pZHhwhfhySTnn2aGQ8xXowN0q+2XoT27NbS3
   faStyevOB49TzDHvnr9Ff5VT2P9aabD6NnjYZ2j08UPL+922RRnPlQvce
   3+wdDfoqhbzMYM5HzS4yo3rnuqQpS2eS0UjX4ogJAWbaX4qW1fMMzcONf
   g==;
X-CSE-ConnectionGUID: k+JXERSrTaWxIx2bgLHSNg==
X-CSE-MsgGUID: dsBpEmCkTbapaIgL+fUzaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30575922"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30575922"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 01:18:26 -0800
X-CSE-ConnectionGUID: psXC81rdQIOzdJLzS/caog==
X-CSE-MsgGUID: Ezo3w8W9Qdai2vkd4B0mEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114381676"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 01:18:26 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 01:18:25 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 01:18:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 01:18:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVRm0UQBfP3oE6LRUtveEQ3azM4YGUefyRTo8KAWWb2BSHwutf3J0wFtkIHZMbVBVGjBYukaLXNkWu46w77d+hFPBjgwH5gdw3/an7mDnECF7amBXlurh0mS//qv4mDrf41buZds+OMceF35tD+OQ4NqyB2nmax4IOEPLP/Fv0Ra+VEnhvdsl/kft+8YoPzpI8o68grBlTb2Q5ewzOKand28tNt/U2d0hRw6phNvnUyRLSyEzNQ6lBOpuV65Y7iFJ9K+P496GgQ81ud15hllLoMGd5dWW01LwBZaNcAwFzIJT3PI0w3QDyzSTR2VW4wHa/Ps8J6T83ioI7cgBC2wjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjZYiNQvrvTqvd1zKy+m+rq+Ihw70lZRhB0TGPBBGfM=;
 b=NMYyme8SO3Ez3MrjvKXnJpkiYMxEdgCYiTqYIrFGkKPbtz3G/FkhORLi1ijCTp5/Bemq8BH6A7Tg3I/uvh08wgRzewTChETtF+6nzJiB0pcZw0QuNk3VgDMSqWdNvNH2fHuXd44iMV3u+b7/BvF2to4WXToDK/2/jvTNVMWQTuiPrSdA7mqMGxEf3V9NJdrn71pGr+WnwYh49FRV1zwiDpGZ87KFdMwiTE0E6KXCmTlJ1PTkYZemYYeX7GSO/TFs+vMwnl28iMaF5V5yYvhvgLtEuZxCcHD71m89pZObZ6cuyM8ZJr+bjy1qYMHXVUv+2/RiJSEfBzQCeAKWrfZn+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5952.namprd11.prod.outlook.com (2603:10b6:510:147::7)
 by DM3PR11MB8682.namprd11.prod.outlook.com (2603:10b6:8:1ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 09:18:23 +0000
Received: from PH0PR11MB5952.namprd11.prod.outlook.com
 ([fe80::b961:2a71:c5e8:460]) by PH0PR11MB5952.namprd11.prod.outlook.com
 ([fe80::b961:2a71:c5e8:460%3]) with mapi id 15.20.8114.023; Mon, 4 Nov 2024
 09:18:23 +0000
From: "Devegowda, Chandrashekar" <chandrashekar.devegowda@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "K, Kiran" <kiran.k@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH v1] Bluetooth: btintel_pcie: Device suspend-resume support
 added
Thread-Topic: [PATCH v1] Bluetooth: btintel_pcie: Device suspend-resume
 support added
Thread-Index: AQHbJRENZ2yMshNiiky51ZyXMna5ZrKUtUIAgAJ9JQA=
Date: Mon, 4 Nov 2024 09:18:23 +0000
Message-ID: <PH0PR11MB5952C5B28E41E33C0CBF9384FC512@PH0PR11MB5952.namprd11.prod.outlook.com>
References: <20241023114647.1011886-1-chandrashekar.devegowda@intel.com>
 <20241023191352.GA924610@bhelgaas>
In-Reply-To: <20241023191352.GA924610@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5952:EE_|DM3PR11MB8682:EE_
x-ms-office365-filtering-correlation-id: 86c38619-e99b-4e60-0d03-08dcfcb1a1b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8kArBi7If/JA/UeY6jrOYwm0z2dzwWuJIHNlS8WFq49FmeDZomuF/uEX9lKN?=
 =?us-ascii?Q?GZPPVFdbh392xCrZSo5shNSCdSuObjyDpk5W7UjDbiOVOzUjS5PZZg2G9X5Z?=
 =?us-ascii?Q?A1Ol9f9KEUb9UDxAK0xCM4wm4/54poqPljwAtBnNBb/QIoGktAL4jSgbDudF?=
 =?us-ascii?Q?li+1TnCtYRFDHDuRoXw36Hvx7Hs4P+u1GuPTwy89p5Heapi5z0Rg60mE/WPc?=
 =?us-ascii?Q?KCHx8n0VtdyJLvaSSiTwznSrG1A6IRZ2uGSkNTzfxY/OhV6hq4+GnjCRJXrI?=
 =?us-ascii?Q?0m0bkx5iRCJWgXHCmPMnf/OLzIQbbTaqdRydCXAc9hyYyXvcj11PNnc9eOlo?=
 =?us-ascii?Q?T2E83Wj1ZKu+3zIq4vbSarohszLgkVx3G/Pjh0CC514Ue2XqycLN9yQ8hB3u?=
 =?us-ascii?Q?wYWyNhyVdCHipyvC6ZHpv1L+ohbBfHkso7t3EXEKktVCnqfmLaJ6KU6OXdip?=
 =?us-ascii?Q?y4IHlzAjPy6oBGehIdPRjcM0HBs9ue97Qz+Yxpjilyo/XG4YN8Z+/GG9zPeH?=
 =?us-ascii?Q?naFbXCeizHdttCe0sgwFFIHK9unjJGAGh1hQUA2QOPKwdluy/fE83YGTxPaj?=
 =?us-ascii?Q?w6ckngvV8hOzCymVAgUCLTDYCk4JdqKXZXBODyh4ZUBdle0fHS/AkVtl+ZrI?=
 =?us-ascii?Q?PeXWWdX0cd0m0UKp6bQ0BOGJxfegVZxFhwuTaDv9HZOcvO9deepMrGwXau5i?=
 =?us-ascii?Q?2b8JadpHWsmIPgzpdUfmdYvlLyg/ntkOXcq4/1kvVwglKQbpEdlgD4QS9V3i?=
 =?us-ascii?Q?ILWdDeWES66xR62fiTZVKlTyKSbHZprspYTeK2+v5dnjrOlCxf+acbCAM1GY?=
 =?us-ascii?Q?oRXp2LB8Lq4747LuZsd20sgFYIDpBNQEudsd1lFci7sVUwDSbKmN/RRKOPU2?=
 =?us-ascii?Q?gHBsR7t/TYRbMepRrgYSv1nFE7ZzI6u3D1PdMZN/6c9T9VphF47SOSHCIAY7?=
 =?us-ascii?Q?ckqJZ7XVJRhyKyM3+gvnbejjkaWd1eul66gP+bVhtrRz1fJVIt/9Zyqjla56?=
 =?us-ascii?Q?ypqZDSdKJIXN5b5whFQzpZvJRNV7OKKtZ/nT4UI+2mv3zy/G4bVafqED60w2?=
 =?us-ascii?Q?znkJPozGHnXrJVw+o8gp3i37M5rrhwtajOQx/L8EoLLsX3PFvJl9PLRHpQql?=
 =?us-ascii?Q?bcHKb707BzBz+od88ZkOokDgahUZ1gVdA8H9z3cb5L626WBU+aMsIHh2dor7?=
 =?us-ascii?Q?LjWRDAb6dGVbBZ3wXFWYLrntaJbDyQX6pbztIrSXjQMwKCtgdEEkotOyoKB2?=
 =?us-ascii?Q?Tc3VwtzymqkgtiF17hwVQFpEi8yq4B2DAAZX7gfKi3caUWJsTNwnw56CG6tM?=
 =?us-ascii?Q?7wBMGZA1a5swV2NCoOLTwTylRzu1oUt6I88qrSkLRh3ntogsdJxc9vpaLpxV?=
 =?us-ascii?Q?BcGGh1I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5952.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ia3YeyShJHf1BXI984swrcUIWXoVTCmrqSouzq0TsWLCRIjaOzL38Ny+A4cp?=
 =?us-ascii?Q?8BnUG9HofXf5ppreThxUl3BhNPPBBfkynjlawu76I+dBLg4pVtDh8dkpEtm0?=
 =?us-ascii?Q?DTEYdPbHmAHuykP8LeCB1qRf3/U6qfS93F/wO/MDYME2GunsvhwAGx7BWTAN?=
 =?us-ascii?Q?PcGhAva4DNVrcX446RLVQe/ubmF4JjFLpv0NPyZhEMtRoh1fWt9REjOGm7Hs?=
 =?us-ascii?Q?IQirfx1DyGorrdbL8DX7uf3x9qDMSFnF105MGKyn96IaqgP6O0FEs/q0HNpc?=
 =?us-ascii?Q?rduBlTJ26wqs8QKPiPv12oR2naNdjBiyZpFNm6FciiZ2l7Gp6djjGA2QW3CE?=
 =?us-ascii?Q?yRoe3m2KU4d00NlEFisG8YTSRyIYrofkWVYtM3aAVnouyyPc8/Zj92Pzi2v5?=
 =?us-ascii?Q?KbyL3jTQvoE1Ig2qrW1jmjsybAuRkWMdRyeF8SxdhDyLLjplCcyaSgIBrT6s?=
 =?us-ascii?Q?ePVls6QJnyhPnX/jCxRtHzALR4zCdmWARTSfFPNcj3UNH0rM6wR5cUQt9O7K?=
 =?us-ascii?Q?WQzj6nn32WcT/FCPmMY2t1rzF4pixsU+cpR/vnv3ok/r/iM+8uzQBlufnxUm?=
 =?us-ascii?Q?tlpfszHFHPkNiX69CK2QTiDaB+fVMcCZOqokhTi84SUwvjBxzaniAwlCDRSe?=
 =?us-ascii?Q?nVQZItlb5M7mw50wZlKAVHKsHWlCWNmbHvnoAshQqPw120u2VYwIT/0uiy1S?=
 =?us-ascii?Q?pcQJkz2FgyM8Y4k1VFjD0dgABwJMTE4ogY3xpQ+GcvKzBhRXpKS7jBlUVWbk?=
 =?us-ascii?Q?j42rIlUK/S5M1c7eRQrS0xr5slQ9ugWZWNObYsH+jL0D6Yz6uqsaSn+6lUXD?=
 =?us-ascii?Q?4mRfHbeA+hHF5KGMe4vD26qTebt2Yvoh7MqpIj2GlDhQHjPDNpiTQUqPXc6a?=
 =?us-ascii?Q?qM0yH6ewfYr/nK0A2HvDuoB8fjdkVw2gckXjr81kmB3QXN7XwkS3eCFD2kcJ?=
 =?us-ascii?Q?XZl8JdlfFfLzYQI7QUNpG7kAN550lUspQlequkmbmZlFrEEM5tbgDz/R52+I?=
 =?us-ascii?Q?4KzW9ntHdlFqKtLU9upr/j395vXyKHR5b+9UH+tVgSWf8O9TSO9Yuj/8vH8j?=
 =?us-ascii?Q?Urny79KheczJ0sJw6TJqebseQWhZTA9GjbHcvRVwcwKXqNGoe5BrPvJvWkrh?=
 =?us-ascii?Q?g5jRI23zBgkXUyQPv2WAj9QxH7bwHcXOz3jXHkvD1l8tldd1MUCiIH53EwMK?=
 =?us-ascii?Q?eyL7OM3hYwhPjLadCWBLpYyiPGBQlPdfgHyuOF3EW4gGhaav3ZgH+uA3XzyT?=
 =?us-ascii?Q?Fpv13yZBun/hmgYlT0Rh6kEtG9k7wMCNJWuuXUyWHnweLiGNIxszbUKeodeg?=
 =?us-ascii?Q?frb3OHQR/aPPVHs2dlslv8LYoTZtKldJmGGhKvXvba+eYp2vjBm/p2+/HycK?=
 =?us-ascii?Q?z5nXiEpEL74P5JzU8Lj8d5ySQnzUwFBHaFTj4S8+f4YbjrRjID++7kPyDDeZ?=
 =?us-ascii?Q?Y2FflfqMRpXzVCoudE8VRfRLXdhY1TdtfybX5kKu3/CsbUGW82LqD79/hPZz?=
 =?us-ascii?Q?8iker4pfI8aw+HO3kfzEgZDbDycWhoYzaq+hT+Ft/eaWOmOVUq6H3kwKvE8e?=
 =?us-ascii?Q?xrQnDAxoSPEQ9eEzbnINp++M74Vv3TInmEidBx0bGLJJpnSiILxrM+WKohLm?=
 =?us-ascii?Q?Kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5952.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c38619-e99b-4e60-0d03-08dcfcb1a1b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 09:18:23.2093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+vkuciipmTmPo9Ho/kGctawtj6GvNVhQIOkUD/WRd9bF4bUXBO7i2eLWKR4s+aVwguVpS1SdZJ58hBNRkbg7z4Lfw67VsyickxQ5k3+YYq8BcwSBYUPDe9KizKLAvEv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8682
X-OriginatorOrg: intel.com

Hi Bjorn,
    Thanks for your comments

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, October 24, 2024 12:44 AM
> To: Devegowda, Chandrashekar <chandrashekar.devegowda@intel.com>
> Cc: linux-bluetooth@vger.kernel.org; Srivatsa, Ravishankar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>; K, Kiran <kiran.k@intel.com>; Paul
> Menzel <pmenzel@molgen.mpg.de>
> Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Device suspend-resume
> support added
>=20
> [+cc Paul]
>=20
> On Wed, Oct 23, 2024 at 02:46:47PM +0300, ChandraShekar wrote:
> > This patch contains the changes in driver to support the suspend and
> > resume i.e move the controller to D3 state when the platform is
> > entering into suspend and move the controller to D0 on resume.
> >
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Signed-off-by: ChandraShekar <chandrashekar.devegowda@intel.com>
> > ---
> >  drivers/bluetooth/btintel_pcie.c | 52
> > ++++++++++++++++++++++++++++++++  drivers/bluetooth/btintel_pcie.h
> |
> > 4 +++
> >  2 files changed, 56 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btintel_pcie.c
> > b/drivers/bluetooth/btintel_pcie.c
> > index fd4a8bd056fa..f2c44b9d7328 100644
> > --- a/drivers/bluetooth/btintel_pcie.c
> > +++ b/drivers/bluetooth/btintel_pcie.c
> > @@ -273,6 +273,12 @@ static int btintel_pcie_reset_bt(struct
> btintel_pcie_data *data)
> >  	return reg =3D=3D 0 ? 0 : -ENODEV;
> >  }
> >
> > +static void btintel_pcie_set_persistence_mode(struct
> > +btintel_pcie_data *data) {
> > +	btintel_pcie_set_reg_bits(data,
> BTINTEL_PCIE_CSR_HW_BOOT_CONFIG,
> > +
> BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON);
> > +}
> > +
> >  /* This function enables BT function by setting
> BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT bit in
> >   * BTINTEL_PCIE_CSR_FUNC_CTRL_REG register and wait for MSI-X with
> >   * BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0.
> > @@ -297,6 +303,8 @@ static int btintel_pcie_enable_bt(struct
> btintel_pcie_data *data)
> >  	 */
> >  	data->boot_stage_cache =3D 0x0;
> >
> > +	btintel_pcie_set_persistence_mode(data);
> > +
> >  	/* Set MAC_INIT bit to start primary bootloader */
> >  	reg =3D btintel_pcie_rd_reg32(data,
> BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
> >  	reg &=3D ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT | @@ -1653,11
> +1661,55
> > @@ static void btintel_pcie_remove(struct pci_dev *pdev)
> >  	pci_set_drvdata(pdev, NULL);
> >  }
> >
> > +static int btintel_pcie_suspend(struct device *dev) {
> > +	struct btintel_pcie_data *data;
> > +	int err;
> > +	struct  pci_dev *pdev =3D to_pci_dev(dev);
> > +
> > +	data =3D pci_get_drvdata(pdev);
> > +	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D3_HOT);
> > +	data->gp0_received =3D false;
> > +	err =3D wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> > +
> msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
>=20
> The generic power management code already knows how to put standard PCI
> devices in D3 at suspend.  So if you have to use device-specific code lik=
e this, I
> guess the implication is that this device is not spec-compliant?  That wo=
uld
> surprise me a little bit since Intel is pretty good about making their de=
vices
> work correctly.
>=20

The FW needs to perform the vendor specific housekeeping task before the de=
vice enters into D3 entry/D0 exit , So it is required to have the handshake=
 between driver and firmware.

> Some detail about exactly how this device is non-compliant would be helpf=
ul
> here and in the commit log.
>=20
> It looks wrong to me that you call btintel_pcie_wr_sleep_cntrl() (which I
> assume starts something that will result in an interrupt that causes
> gp0_received to be set to "true") *before* you set gp0_received to "false=
".
>=20

Ack, will move the assignment before the write of the sleep control registe=
r in patch v2

> That looks like a race because the interrupt could happen before "data-
> >gp0_received =3D false", and you would return -EBUSY when you shouldn't.
> You could test this by inserting a delay before setting "data->gp0_receiv=
ed =3D
> false".  Adding a delay should never break this functionality.
>=20
> It looks to me like f4c8e876ef6b ("Bluetooth: btintel_pcie: Add handshake
> between driver and firmware") (currently in linux-next) has the same race=
,
> where btintel_pcie_send_frame() starts something that will result in an
> interrupt, then sets "data->gp0_received =3D false".
>=20
> But I don't understand the workings of this hardware or the driver.
>=20
> > +	if (!err) {
> > +		bt_dev_err(data->hdev, "failed to receive gp0 interrupt for
> suspend");
> > +		goto fail;
> > +	}
> > +	return 0;
> > +fail:
> > +	return -EBUSY;
>=20
> Since there's no cleanup, you could just return -EBUSY directly above and
> there would be no need for the goto or the "fail" label.
>=20

Ack, will incorporate the change in v2 version of the patch

> > +}
> > +
> > +static int btintel_pcie_resume(struct device *dev) {
> > +	struct btintel_pcie_data *data;
> > +	struct  pci_dev *pdev =3D to_pci_dev(dev);
> > +	int err;
> > +
> > +	data =3D pci_get_drvdata(pdev);
> > +	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
> > +	data->gp0_received =3D false;
> > +	err =3D wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> > +
> msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
>=20
> Same potential race here.  And of course I'm still dubious about the need=
 for
> this device-specific code in the first place.
>=20

Ack, will move the assignment before the write of the sleep control registe=
r in patch v2

> > +	if (!err) {
> > +		bt_dev_err(data->hdev, "failed to receive gp0 interrupt for
> resume");
> > +		goto fail;
> > +	}
> > +	return 0;
> > +fail:
> > +	return -EBUSY;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(btintel_pcie_pm_ops, btintel_pcie_suspend,
> > +		btintel_pcie_resume);
> > +
> >  static struct pci_driver btintel_pcie_driver =3D {
> >  	.name =3D KBUILD_MODNAME,
> >  	.id_table =3D btintel_pcie_table,
> >  	.probe =3D btintel_pcie_probe,
> >  	.remove =3D btintel_pcie_remove,
> > +	.driver.pm =3D &btintel_pcie_pm_ops,
> >  };
> >  module_pci_driver(btintel_pcie_driver);
> >
> > diff --git a/drivers/bluetooth/btintel_pcie.h
> > b/drivers/bluetooth/btintel_pcie.h
> > index f9aada0543c4..38d0c8ea2b6f 100644
> > --- a/drivers/bluetooth/btintel_pcie.h
> > +++ b/drivers/bluetooth/btintel_pcie.h
> > @@ -8,6 +8,7 @@
> >
> >  /* Control and Status Register(BTINTEL_PCIE_CSR) */
> >  #define BTINTEL_PCIE_CSR_BASE			(0x000)
> > +#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG
> 	(BTINTEL_PCIE_CSR_BASE + 0x000)
> >  #define BTINTEL_PCIE_CSR_FUNC_CTRL_REG
> 	(BTINTEL_PCIE_CSR_BASE + 0x024)
> >  #define BTINTEL_PCIE_CSR_HW_REV_REG
> 	(BTINTEL_PCIE_CSR_BASE + 0x028)
> >  #define BTINTEL_PCIE_CSR_RF_ID_REG
> 	(BTINTEL_PCIE_CSR_BASE + 0x09C)
> > @@ -48,6 +49,9 @@
> >  #define BTINTEL_PCIE_CSR_MSIX_IVAR_BASE
> 	(BTINTEL_PCIE_CSR_MSIX_BASE + 0x0880)
> >  #define BTINTEL_PCIE_CSR_MSIX_IVAR(cause)
> 	(BTINTEL_PCIE_CSR_MSIX_IVAR_BASE + (cause))
> >
> > +/* CSR HW BOOT CONFIG Register */
> > +#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON
> 	(BIT(31))
> > +
> >  /* Causes for the FH register interrupts */  enum msix_fh_int_causes
> > {
> >  	BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0	=3D BIT(0),	/*
> cause 0 */
> > --
> > 2.34.1
> >
