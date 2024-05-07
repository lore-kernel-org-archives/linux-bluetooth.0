Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55D813C3FA
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089644; cv=fail; b=pxsGbBILaVIqxy3TMPP0O+xLuBa4dc3eQm681yCWU9OPcuQbMSXn9Pv1K7q8DqVf2uFjh/Yuy78qCTsOSeKAJgBdklGrGfJVYPpiFTbVnIW5sxkRjsSEa4CU+QmmTMzFCddE4nwgAqxH27zRbtPd6AB4/2wzjyvuVyZPmW360/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089644; c=relaxed/simple;
	bh=o5m2W/lFMHG9mwSKN62RW2+jD3SSIRWDL+XxT+UwK58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qsRTd0fFV62aYP/U4V424Bv2mCr6MiNHTd60WnEp8E+0WJG7xUqFc9LSIaBvryOhwPMMLuXs+sCnHOWhbGJAyaWky/kqMfRHLJlItMjp4o1RU5qrJyArJVFGU67aUDkqbj8C4YUcx2Dvi/t5j7UPlisGXGoU2CQ5UCLQHQSJHt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7c1SYN3; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7c1SYN3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715089642; x=1746625642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o5m2W/lFMHG9mwSKN62RW2+jD3SSIRWDL+XxT+UwK58=;
  b=U7c1SYN3qobkkvmDqeJ9jO/6FCcUPiqSrNKX/vqWbPsaR60YZsP2z/Rc
   wcQV9Su9yhRDpQzoHuPN+E/Miw9zsOU5yeh7aiKqNF7oSld4GBtegHAzl
   0jCdL9q+y7DprpX9hHmsw3T/8kH7h4WtzQ43b6p7CkJS8uftUORAuZtIJ
   A2vTX1a9/e1eLo9+fKwWqFieRkrXpMi2oRy6+V+vXHdSnvmnFiqmVIdUT
   1Fu3XmzIOxOFp73DPfzgQfyfRJCjuYqPib5cu6kTOt0OvcUmi7UXkr6/O
   IVr41hgsGYd3/8SSSiH8lvaYaeqXpJtRbM8l26d1ObspVL0mEgOh7TKul
   w==;
X-CSE-ConnectionGUID: iX1gd1FOSsu5WzIbVI6XNw==
X-CSE-MsgGUID: VP/+/PvISxCgizMbrA3i7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14671669"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="14671669"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 06:47:22 -0700
X-CSE-ConnectionGUID: XC9ztqm4S9Gq5RrrbETq5g==
X-CSE-MsgGUID: +wzXB0qHRAOZMXZZA9bbKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="32997871"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 06:47:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 06:47:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 06:47:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 06:47:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/BxQd5zaJ/YGN67OfIxbhi9i9Tf6dAAJiwtqN40uoZjse8emN/1mDY9fOG8kvc2QB5jLCBCMUwVcT0lksZ3FKtvckAy8DmHSZoT5KjFWyTC6PRn8hZzVPA02YUrc4XcPSRZ/+si505u3RjFohUbI7XyJRlytRq9BBOoAEZS2F7ja6l4QwlFQwKot+bfebUZjjkN4JsI1zQh3dh5Co93p1Va5Hb0K1iBnhuA/VktlbAZLvORdCnwtrdl4scONEBQQrXsBTMuCyuTmWF04aqvvpIGmcCelBqwyPIlzwLFef4j9jNOFiAlmQ+AORTjdSBf6oRzdg+gPp9flOlvfvEzew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF+6d62r0NS6Fj3Uz33ICCqPezibpfAVVv9w/pbF3I4=;
 b=ionh/IAiKJ06vB29gqlEjlzWED7WXxZkxVeAoBI+PUAmKMVYsoq0cjDmBB+L7E3YazoZXf7W4ovQzh/ESYuaHmwetjRcaxd4+zOa+/tMj+c5T9q8ITSLmkdYR/6hvRTBHLg7WRD9hG829CS/5nbGUI/8oAH22cXWlUvD66R0RFoSB7Sv8vEUAAy4oFatL+8Gka0VPPOt/3QMrBZnJeO6uiFzNN6oxrsM3eBJ4IzZTVa+aB76xSwu1lwNeSy4F1O5bkchn0XNbr3+PHamEJoXUUBSx2ANuC99vKjVZbgZjHKpkAMnZqG6wk0jApMabuS2O1oQ5edBoGVnGIYRaneryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by CY8PR11MB7243.namprd11.prod.outlook.com (2603:10b6:930:96::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.40; Tue, 7 May
 2024 13:47:13 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 13:47:13 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "An, Tedd" <tedd.an@intel.com>
Subject: RE: [PATCH v1 2/3] Bluetooth: btintel_pcie: Add support for PCIE
 transport
Thread-Topic: [PATCH v1 2/3] Bluetooth: btintel_pcie: Add support for PCIE
 transport
Thread-Index: AQHagP/Y3qFIguWSqkGG/RZnmTQfuLFNYxmAgD6h+GA=
Date: Tue, 7 May 2024 13:47:12 +0000
Message-ID: <PH0PR11MB758505AB2E9D8C07F6091B19F5E42@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240328111904.992068-2-kiran.k@intel.com>
 <20240328170827.GA1570610@bhelgaas>
In-Reply-To: <20240328170827.GA1570610@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|CY8PR11MB7243:EE_
x-ms-office365-filtering-correlation-id: 9af61852-06c4-47d4-8c45-08dc6e9c330e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?cvwjqcRm//EFZ4Dfa4gxhL+Q506fO7PGqqYIsgQkChNQ4Pxo1iUX67ZvZffV?=
 =?us-ascii?Q?C41jQUOF7aE3nHfcmrGEJ6E8AGSfEmBVBsZaAPsh7yIzIMGqIrN/IoMqboqj?=
 =?us-ascii?Q?ZqG7S5z33akGaRKNNj1K5xYWONtib0awA+bKtObLBmIPc3BXlpixU5qNla6W?=
 =?us-ascii?Q?Sj2P9DTbTQLvJqbk+lxf9ipq/X7QIkAp/LSRd3bHvkwKjGgse5de0G3YVdDM?=
 =?us-ascii?Q?QwCcsVwIws45YL7Gq/Wu+q3bqu5O4Da7HBmYDFIWQ6BMj2fqhqALOT1KJFrE?=
 =?us-ascii?Q?IkPKU0BgllJTH11rMlrM/yYQahOtF3Z2tWp1OvfurrD67GbEqNogk/s5I7uX?=
 =?us-ascii?Q?8PfntnEvEgEAoFr4hvHl3GIzoRZLVISIq/iSWLGb9FPxQqHc45iGceys/oBL?=
 =?us-ascii?Q?JgqSp2pN3v1Nj57s7CEz3H6em9B4evmgDF7r4eovn2T+fQZhuTpeFERomNvU?=
 =?us-ascii?Q?IKdDQ/jBQ+O3pS48zGbbsnPrvTCiSQDh+lY5885LRa0QaYt/219Z/6V/h4Gx?=
 =?us-ascii?Q?e5305PR29Hq08pmWDllbF2uM8zk9sJA4tN1ER4vJ+N7I5W84JjBPidvyhG7v?=
 =?us-ascii?Q?541R75yvGytDAhC/waf3In6IlB69k5/rF+ERUZs/ijuCPDRgAe23uuxJM63m?=
 =?us-ascii?Q?BG3FXDPwUyn689YnDsZiHu5YGD4030VXB33k0kNMsa3t+8Htj8RfU8rVOxt3?=
 =?us-ascii?Q?3VdXbxuzbjVwyrH/Ooo9OvCk2QFpU95FlqISpth4DYtdhNG3UbHhNoB1PQCT?=
 =?us-ascii?Q?jXHYrfIitBHlbseK25o/fkXgqoDzyW4w9X/5F8jPgdH1/ifOV5lU9bMynGtk?=
 =?us-ascii?Q?FxMAGtAMxW1Yb7PTVi1izNTKqbyNflsIqbj9r8BVxUBm07YnWjLdu4Owrphr?=
 =?us-ascii?Q?HyJOFbJ5/oi+upG6ujFVMRfdDsx7RznsjH0pF3bcmxeapwvt2b/iU0xSTpMQ?=
 =?us-ascii?Q?kYwm0Vsf39GK1fxzB3JoZqXr6nhPwk2qC9kcV1fs9VSCRpPstpkbdP2QN6Nc?=
 =?us-ascii?Q?bGVD2ecNolOqbPbrOwdKQ7/Tha0GCtD/tp1caKH2GrYEresrV3MTDqu2Kx3a?=
 =?us-ascii?Q?dw4b3MNXSUY+u98MB7XMj9zUjr/Ib6XdeG+h2O1n3ds18BPMVvOgOUQBxey8?=
 =?us-ascii?Q?yIsj9bqXVaoZsZsT0EWqYbBjmHwJ+y5hroLJs8/Q+Znq3iVnqhixtczMp8uI?=
 =?us-ascii?Q?MOE/NCNy3yaUPxmiWvlwAV6J27Fx+i4paYnsfxiANBYjjV254pZXqkFyjCUN?=
 =?us-ascii?Q?qhM3vEyl4m4FXmNtxEr0bYk1AnxJSIC8ceA8/sTt1J+FGi4fh2huISvzHXzl?=
 =?us-ascii?Q?1I/ozDQCwAxyWl9t+tJ3Mwk5pvMn+rq+WjKSuZUsaJsdYQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JYcPw80moo2MKjfx6Yhk64zan8nIFCrRxcHH+j3yqN+D4PyQ8aLb3SxFc3GX?=
 =?us-ascii?Q?h2ng3xyVfZ5HLMkxErpjDsTbupVCUioFpO7vdOS5Z8Uu5cAe+jlhFGE4V99+?=
 =?us-ascii?Q?n38Ox7RGHy+cISaVzt3qYv7hXn+cfXjrYc+PZPycncOIlNLYkJ4nave4QWWy?=
 =?us-ascii?Q?8rQ6/1CKiGBoj26S1cBbdwIf+Vas+nysKGo4EOWe4eMNoXNnMgJ67uTFYi6p?=
 =?us-ascii?Q?ERVaYzJBVl1zC+RmrvL4X7bmgoESmXCg+iBahtYwFnPtaXA0ksGYHnVHpY+e?=
 =?us-ascii?Q?PsiLEP24v8G5a7/r96CXJ767wkHyf8fbPma2MGeIyJzgWYzOVb6hAedL03cw?=
 =?us-ascii?Q?ndmD/qMtEe1lxcAnL4/Wuf9J9qVvLvCxdKs7ic+uPikryIVqa0NF3m01e5ZO?=
 =?us-ascii?Q?qoX+ra1g2bFB0REOQDXeW+Eh3RluRa9r4wvG9EjGCRByK/+tIcB5SlXEFDiH?=
 =?us-ascii?Q?mZ2YEIgJwpW4OrFBnP7BPXG1xTO7Kivr3zIjqeN8S/2s6S1x+dMrfizERmOw?=
 =?us-ascii?Q?lqAPI4LWzfbKZ8Yadmdq8FK4ApJJ+rtICA2P8Ktpp/J2Vz8OyRHwSZMxAzSV?=
 =?us-ascii?Q?4/ic2mpTTHr59DnIAZAClA6RKeXNFl/ztudjbY61oPMRFMI/wrsJUZlHcG/n?=
 =?us-ascii?Q?3LuhDkWPDp5S8mUUsHXSP48Lp6/wshXe1xgZBbtOzUihlCfxBhCRsNHsKNY+?=
 =?us-ascii?Q?gb0BYMyGfmyPqsDVEuqR7n+FPlK9YVJJras4/fDDTknYVteVtUI8dkMwH3s3?=
 =?us-ascii?Q?5Bz7c+TGZ+AvL9qt3E1fvv9VJaV4eDYo3vuqnOJLJbDXalnrMx5tgG6qBLAu?=
 =?us-ascii?Q?77N0xVQ1m70rTqlBYEtfGaZ9ja3/TUJwABGpL6/VuK94ukgHL5uLxjs/YGoN?=
 =?us-ascii?Q?8p4HYpW/XK9D0Di2UnrjQNHAfh4uHdvpzhaTzB3Chry2UvITAtCR70g/4C7S?=
 =?us-ascii?Q?HYYgg+0ncHkcL0Zq19bWszA5yV5GMiJVhJ1tlxxB+F1LdXNhiZVd/OpaXANJ?=
 =?us-ascii?Q?Hww5+RSi7JHT0WFWqHB49J4NdFDcsJNUQeKeCXZbb35JZFdOnvmjV/LWBs+f?=
 =?us-ascii?Q?E8lDiqhPo0BMUyKJrbCAagdqOLby2Zz1E4ZHMN/SI8aE+yPzJy4JlTPXJtlh?=
 =?us-ascii?Q?gvAvQZBGknqxrFHXn/mQw5l6Q0q4qLrggxdyiHfU2HNssvcQ4a/z26mGRQDD?=
 =?us-ascii?Q?oA7i0Tdyl3NFw/6De0iXBvE3k7qWYbTrC2naKM/7TBBgIOIgm0qW+yHw95t7?=
 =?us-ascii?Q?OTlz2aJe8RS/NVh49ICkG0zv+P+KXNCCuC1fRAkKCOyzXQTpqg2P1oRAwpDd?=
 =?us-ascii?Q?sIfkYBdJ2qzg42Opj3PFePUFQsmvppWx9ZIKbZwLuDYJBwDa2pMwsVYnnD2+?=
 =?us-ascii?Q?9lHA4SPil6RrsATNi0MpmJZw5Uq113IwZ83N2u1QXJZDBL9SAbWIXnBxd+M/?=
 =?us-ascii?Q?3qZk5i+EhoA4gTir1LnAJTjfIbgsGF9/zFZCdnerfHLxRQaePAxD6Z6vBC/e?=
 =?us-ascii?Q?z29y+LwapCYl2gDfUyhMlukbMqexFtadyIqp9AEAOZxD7nBzm8sOpZfj91co?=
 =?us-ascii?Q?N4jcWBReujLRM9yF3xM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af61852-06c4-47d4-8c45-08dc6e9c330e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 13:47:12.9878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbZc+cgWXtIIb8JRxw/ecDXZKbkMWoYMtDzaXYSvW/uE0hyS37bu1oslHERSrC8LJR7fGU1saITtEBGSGoIFuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7243
X-OriginatorOrg: intel.com

Hi Bjron,

Thanks for your comments.

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, March 28, 2024 10:38 PM
> To: K, Kiran <kiran.k@intel.com>
> Cc: linux-bluetooth@vger.kernel.org; Srivatsa, Ravishankar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>; An, Tedd <tedd.an@intel.com>
> Subject: Re: [PATCH v1 2/3] Bluetooth: btintel_pcie: Add support for PCIE
> transport
>=20
> On Thu, Mar 28, 2024 at 04:49:03PM +0530, Kiran K wrote:
> > From: Tedd Ho-Jeong An <tedd.an@intel.com>
> >
> > Add initial code to support Intel bluetooth devices based on PICE
> > transport. This patch allocates memory for buffers, internal
> > structures, initializes interrupts for TX & RX and initializes PCIE dev=
ice.
>=20
> s/PCIE/PCIe/ (subject, commit log, throughout) s/PICE/PCIe/ (commit log
> typo) s/This patch allocates/Allocate/ s/initializes/initialize/ (twice)
>=20
> > +#if BTITNEL_PCIE_ENABLE_HCI_DUMP
> > +static inline void btintel_pcie_hci_dump(const char *p, const void
> > +*b, int s) {
> > +	const unsigned char *ptr =3D (const unsigned char *)b;
> > +	char str[64];
> > +	int c, i;
> > +
> > +	for (i =3D c =3D 0; c < s; c++) {
> > +		i +=3D snprintf(str + i, sizeof(str) - i, "%02x ", ptr[c]);
> > +		if ((c > 0 && (c + 1) % 8 =3D=3D 0) || (c =3D=3D s - 1)) {
> > +			BT_DBG("%s: %s", p, str);
> > +			i =3D 0;
> > +		}
> > +	}
>=20
> Maybe print_hex_dump() or similar would save you some work here?
I will remove this function as we have monitor to dump all the HCI traffic.
>=20
> > +/* Poll internal in microseconds */
>=20
> s/internal/interval/
>=20
> > +#define POLL_INTERVAL			10
>=20
> I think it's nice when the name of a timeout or interval includes the uni=
ts, e.g.,
> POLL_INTERVAL_US.
Ack.

>=20
> > +/* Set the doorbell for RXQ to notify the device that @index(actually
> > +index-1)
> > + * is available to receive the data
>=20
> Typical style is to add a space before the opening paren in English text =
(many
> occurrences).
Ack.

>=20
> > +static void btintel_pcie_set_rx_db(struct btintel_pcie_data *data,
> > +u16 index) {
> > +	u32 val;
> > +
> > +	val =3D index;
> > +	val |=3D (513 << 16);
>=20
> Where does 513 come from?  Maybe a #define or explanatory comment?
Its specific to hardware. I will define a macro for the same.
>=20
> > +static void btintel_pcie_prepare_rx(struct rxq *rxq, u16 frbd_index)
> > +{
> > +	struct data_buf *buf;
> > +	struct frbd *frbd;
> > +
> > +	/* Get the buffer of the frbd for DMA */
>=20
> s/frbd/FRBD/ for consistency (several occurrences).
Ack.

>=20
> > +static void btintel_pcie_rx_work(struct work_struct *work) {
> > +	struct btintel_pcie_data *data =3D container_of(work,
> > +					struct btintel_pcie_data, rx_work);
> > +	struct sk_buff *skb;
> > +	int err;
> > +
> > +	/* Process the sk_buf in queue and send to the hci layer */
>=20
> s/hci/HCI/ for consistency.
Ack.

>=20
> > +/* create the sk_buff with data and save it to queue and start rx
> > +work  */ static int btintel_pcie_submit_rx_work(struct
> > +btintel_pcie_data *data, u8 status,
> > +				       void *buf)
>=20
> Comment would fit on one line.
>=20
> There's a random mix of "rx" vs "RX" in comments, would be nice to be
> consistent.
>=20
Ack.

> > +static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data
> > +*data) {
> > +	u16 cr_hia, cr_tia;
> > +	struct rxq *rxq;
> > +	struct urbd1 *urbd1;
> > +	struct frbd *frbd;
> > +	struct data_buf *buf;
> > +	int ret;
> > +
> > +	cr_hia =3D data->ia.cr_hia[RXQ_NUM];
> > +	cr_tia =3D data->ia.cr_tia[RXQ_NUM];
> > +
> > +	BT_DBG("[RXQ] cr_hia=3D%u  cr_tia=3D%u", cr_hia, cr_tia);
> > +
> > +	/* Check CR_TIA and CR_HIA for change */
> > +	if (cr_tia =3D=3D cr_hia) {
> > +		BT_ERR("[RXQ] no new CD found");
> > +		return;
> > +	}
> > +
> > +	rxq =3D &data->rxq;
> > +
> > +	/* The firmware sends multiple CD in a single MSIX and it needs to
> > +	 * process all received CDs in this interrupt.
> > +	 */
> > +	while (cr_tia !=3D cr_hia) {
> > +		/* Get URBD1 pointed by cr_tia */
> > +		urbd1 =3D &rxq->urbd1s[cr_tia];
> > +		ipc_print_urbd1(urbd1, cr_tia);
> > +
> > +		/* Get FRBD poined by urbd1->frbd_tag */
>=20
> s/poined/pointed to/ ?
Ack. I will remove the comment as its related to handing ring buffer indice=
s.=20
>=20
> > +	 * Before sending the interrupt the HW disables it to prevent
> > +	 * a nested interrupt. This is done by writing 1 to the corresponding
> > +	 * bit in the mask register. After handling the interrupt, it should =
be
> > +	 * re-enabled by clearing this bit. This register is defined as
> > +	 * write 1 clear (W1C) register, meaning that it's being clear
> > +	 * by writing 1 to the bit.
>=20
> s/being clear/cleared/
Ack.

>=20
> > +	num_irqs =3D pci_enable_msix_range(data->pdev, data->msix_entries,
> > +					 MSIX_VEC_MIN,
> > +					 MSIX_VEC_MAX);
>=20
> pci_enable_msix_range() is deprecated; consider
> pci_alloc_irq_vectors() instead.
Ack.

>=20
> > +static int btintel_pcie_config_pcie(struct pci_dev *pdev,
> > +				    struct btintel_pcie_data *data) {
> > +	int err;
> > +
> > +	err =3D pcim_enable_device(pdev);
> > +	if (err) {
> > +		BT_ERR("Failed to enable pci device (%d)", err);
> > +		return err;
> > +	}
> > +	pci_set_master(pdev);
> > +
> > +	/* Setup DMA mask */
>=20
> Superfluous comment.
Ack.  I will remove all these type of obvious comments.
>=20
> > +	BT_DBG("Set DMA_MASK(64)");
> > +	err =3D dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(64));
> > +	if (err) {
> > +		BT_DBG("Set DMA_MASK(32)");
> > +		err =3D dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(32));
> > +		/* Both attempt failed */
> > +		if (err) {
> > +			BT_ERR("No suitable DMA available");
> > +			return err;
> > +		}
> > +	}
> > +
> > +	/* Get BAR to access CSR */
>=20
> Superfluous.
>=20
> > +	err =3D pcim_iomap_regions(pdev, BIT(0), KBUILD_MODNAME);
> > +	if (err) {
> > +		BT_ERR("Failed to get iomap regions (%d)", err);
> > +		return err;
> > +	}
> > +
> > +	data->base_addr =3D pcim_iomap_table(pdev)[0];
> > +	if (!data->base_addr) {
> > +		BT_ERR("Failed to get base address");
> > +		return -ENODEV;
> > +	}
> > +
> > +	err =3D btintel_pcie_setup_irq(data);
> > +	if (err) {
> > +		BT_ERR("Failed to setup irq for msix");
> > +		return err;
> > +	}
> > +
> > +	/* Configure MSI-X with causes list */
>=20
> Random mix of "MSIX" and "MSI-X".  I think "MSI-X" is nicer.
Ack.

>=20
> > +static int btintel_pcie_setup_txq_bufs(struct btintel_pcie_data *data,
> > +				       struct txq *txq)
> > +{
> > +	int err =3D 0, i;
> > +	struct data_buf *buf;
> > +
> > +	if (txq->count =3D=3D 0) {
> > +		BT_ERR("invalid parameter: txq->count");
> > +		err =3D -EINVAL;
> > +		goto exit_error;
>=20
> You do all the cleanup inline, so there's really no benefit to "err"
> and the "exit_error" label.  You could "return -EINVAL" directly here and=
 similar
> below.
Ack.

>=20
> > +	}
> > +
> > +	/* Allocate the same number of buffers as the descriptor */
> > +	txq->bufs =3D kmalloc_array(txq->count, sizeof(*buf), GFP_KERNEL);
> > +	if (!txq->bufs) {
> > +		err =3D -ENOMEM;
> > +		goto exit_error;
> > +	}
> > +
> > +	/* Allocate full chunk of data buffer for DMA first and do indexing a=
nd
> > +	 * initialization next, so it can be freed easily
> > +	 */
> > +	txq->buf_v_addr =3D dma_alloc_coherent(&data->pdev->dev,
> > +					     txq->count * BUFFER_SIZE,
> > +					     &txq->buf_p_addr,
> > +					     GFP_KERNEL | __GFP_NOWARN);
> > +	if (!txq->buf_v_addr) {
> > +		BT_ERR("Failed to allocate DMA buf");
> > +		err =3D -ENOMEM;
> > +		kfree(txq->bufs);
> > +		goto exit_error;
> > +	}
> > +	memset(txq->buf_v_addr, 0, txq->count * BUFFER_SIZE);
> > +
> > +	BT_DBG("alloc bufs: p=3D0x%llx v=3D0x%p", txq->buf_p_addr,
> > +txq->buf_v_addr);
> > +
> > +	/* Setup the allocated DMA buffer to bufs. Each data_buf should
> > +	 * have virtual address and physical address
> > +	 */
> > +	for (i =3D 0; i < txq->count; i++) {
> > +		buf =3D &txq->bufs[i];
> > +		buf->data_p_addr =3D txq->buf_p_addr + (i * BUFFER_SIZE);
> > +		buf->data =3D txq->buf_v_addr + (i * BUFFER_SIZE);
> > +	}
> > +
> > +exit_error:
> > +	return err;
> > +}
>=20
> > +static int btintel_pcie_setup_rxq_bufs(struct btintel_pcie_data *data,
> > +				       struct rxq *rxq)
> > +{
> > +	int err =3D 0, i;
> > +	struct data_buf *buf;
> > +
> > +	if (rxq->count =3D=3D 0) {
> > +		BT_ERR("invalid parameter: rxq->count");
> > +		err =3D -EINVAL;
> > +		goto exit_error;
>=20
> Same "err", "exit_error" comment.
>=20
Ack.

> > +	}
> > +
> > +	/* Allocate the same number of buffers as the descriptor */
> > +	rxq->bufs =3D kmalloc_array(rxq->count, sizeof(*buf), GFP_KERNEL);
> > +	if (!rxq->bufs) {
> > +		err =3D -ENOMEM;
> > +		goto exit_error;
> > +	}
> > +
> > +	/* Allocate full chunk of data buffer for DMA first and do indexing a=
nd
> > +	 * initialization next, so it can be freed easily
> > +	 */
> > +	rxq->buf_v_addr =3D dma_alloc_coherent(&data->pdev->dev,
> > +					     rxq->count * BUFFER_SIZE,
> > +					     &rxq->buf_p_addr,
> > +					     GFP_KERNEL | __GFP_NOWARN);
> > +	if (!rxq->buf_v_addr) {
> > +		BT_ERR("Failed to allocate DMA buf");
> > +		err =3D -ENOMEM;
> > +		kfree(rxq->bufs);
> > +		goto exit_error;
> > +	}
> > +	memset(rxq->buf_v_addr, 0, rxq->count * BUFFER_SIZE);
> > +
> > +	BT_DBG("alloc bufs: p=3D0x%llx v=3D0x%p", rxq->buf_p_addr,
> > +rxq->buf_v_addr);
> > +
> > +	/* Setup the allocated DMA buffer to bufs. Each data_buf should
> > +	 * have virtual address and physical address
> > +	 */
> > +	for (i =3D 0; i < rxq->count; i++) {
> > +		buf =3D &rxq->bufs[i];
> > +		buf->data_p_addr =3D rxq->buf_p_addr + (i * BUFFER_SIZE);
> > +		buf->data =3D rxq->buf_v_addr + (i * BUFFER_SIZE);
> > +	}
> > +
> > +exit_error:
> > +
> > +	return err;
> > +}
>=20
> > +static void btintel_pcie_release_hdev(struct btintel_pcie_data *data)
> > +{
> > +	struct hci_dev *hdev;
> > +
> > +	hdev =3D data->hdev;
> > +	if (hdev) {
>=20
> This test shouldn't be necessary if the driver is written correctly.
> We should never get here unless .probe() was successful.
Ack.

>=20
> > +		hci_unregister_dev(hdev);
>=20
> There should be a corresponding hci_register_dev().  Since that's not her=
e yet,
> I don't think the hci_unregister_dev() should be in this patch either.  L=
ooks like
> maybe just incomplete code?
>=20
> Oh, I see hci_register_dev() is added in patch 3/3.  They should be added=
 in
> the same patch.
Ack.

>=20
> > +		hci_free_dev(hdev);
> > +	}
> > +	data->hdev =3D NULL;
> > +}
>=20
> > +static int btintel_pcie_probe(struct pci_dev *pdev,
> > +			      const struct pci_device_id *ent) {
> > +	int err;
> > +	struct btintel_pcie_data *data;
> > +
> > +	if (!pdev)
> > +		return -ENODEV;
> > +
> > +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	/* initialize the btintel_pcie data struct */
>=20
> Superfluous comment.
>=20
> > +	data->pdev =3D pdev;
> > +
> > +	spin_lock_init(&data->irq_lock);
> > +	spin_lock_init(&data->hci_rx_lock);
> > +
> > +	init_waitqueue_head(&data->gp0_wait_q);
> > +	data->gp0_received =3D false;
> > +
> > +	init_waitqueue_head(&data->tx_wait_q);
> > +	data->tx_wait_done =3D false;
> > +
> > +	data->workqueue =3D alloc_ordered_workqueue(KBUILD_MODNAME,
> WQ_HIGHPRI);
> > +	if (!data->workqueue) {
> > +		BT_ERR("Failed to create workqueue");
> > +		return -ENOMEM;
> > +	}
> > +	skb_queue_head_init(&data->rx_skb_q);
> > +	INIT_WORK(&data->rx_work, btintel_pcie_rx_work);
> > +
> > +	data->boot_stage_cache =3D 0x00;
> > +	data->img_resp_cache =3D 0x00;
> > +
> > +	/* PCIe specific all to configure it for this device includes
> > +	 * enabling pice device, setting master, reading BAR[0], configuring
> > +	 * MSIx, setting DMA mask, and save the driver data.
>=20
> s/pice/PCIe/
> s/MSIx/MSI-X/
> s/save the/saving the/
>=20
> Whole comment is probably superfluous since this is common to all PCI
> drivers.
Ack.

>=20
> > +	 */
> > +	err =3D btintel_pcie_config_pcie(pdev, data);
> > +	if (err) {
> > +		BT_ERR("Failed to config pcie (%d)", err);
> > +		goto exit_error;
> > +	}
> > +
> > +	/* Set driver data for this PCI device */
>=20
> Superfluous comment.
>=20
> > +	pci_set_drvdata(pdev, data);
> > +
> > +	/* allocate the IPC struct */
> > +	err =3D btintel_pcie_alloc(data);
> > +	if (err) {
> > +		BT_ERR("Failed to allocate queues(%d)", err);
> > +		goto exit_error;
> > +	}
> > +
> > +	/* Enable BT function */
>=20
> Superfluous comment.
>=20
> > +	err =3D btintel_pcie_enable_bt(data);
> > +	if (err) {
> > +		BT_ERR("Failed to start bluetooth device(%d)", err);
> > +		goto exit_error;
> > +	}
> > +
> > +	/* CNV information (CNVi and CNVr) is in CSR */
> > +	data->cnvi =3D btintel_pcie_rd_reg32(data, CSR_HW_REV_REG);
> > +	BT_DBG("cnvi:   0x%08x", data->cnvi);
> > +
> > +	data->cnvr =3D btintel_pcie_rd_reg32(data, CSR_RF_ID_REG);
> > +	BT_DBG("cnvr:   0x%08x", data->cnvr);
> > +
> > +	err =3D btintel_pcie_start_rx(data);
> > +	if (err) {
> > +		BT_ERR("Failed to start rx (%d)", err);
> > +		goto exit_error;
> > +	}
> > +
> > +	err =3D btintel_pcie_setup_hdev(data);
> > +	if (err) {
> > +		BT_ERR("Failed to setup HCI module");
> > +		goto exit_error;
> > +	}
> > +
> > +	return 0;
> > +
> > +exit_error:
> > +	/* reset device before leave */
> > +	btintel_pcie_reset_bt(data);
> > +
> > +	/* clear bus mastering */
>=20
> Superfluous comment.
>=20
> > +	pci_clear_master(pdev);
> > +
> > +	/* Unset driver data for PCI device */
>=20
> Superfluous comment.
>=20
> > +	pci_set_drvdata(pdev, NULL);
> > +
> > +	return err;
> > +}
> > +
> > +static void btintel_pcie_remove(struct pci_dev *pdev) {
> > +	struct btintel_pcie_data *data;
> > +
> > +	if (!pdev) {
>=20
> Shouldn't need this check.  If you get here with "pdev =3D=3D NULL", the =
driver did
> something wrong and it's better to oops so the driver can be fixed.
Ack.

>=20
> > +		BT_ERR("Invalid parameter: pdev");
> > +		return;
> > +	}
> > +
> > +	data =3D pci_get_drvdata(pdev);
> > +	if (!data) {
>=20
> Or this one.
Ack.

>=20
> > +		BT_ERR("data is empty");
> > +		return;
> > +	}
> > +
> > +	btintel_pcie_release_hdev(data);
> > +
> > +	flush_work(&data->rx_work);
> > +
> > +	destroy_workqueue(data->workqueue);
> > +
> > +	btintel_pcie_free(data);
> > +
> > +	/* reset device before leave */
> > +	btintel_pcie_reset_bt(data);
> > +
> > +	/* clear bus mastering */
>=20
> Superfluous comment.
>=20
> > +	pci_clear_master(pdev);
> > +
> > +	/* Unset driver data for PCI device */
>=20
> Superfluous comment.
>=20
> > +	pci_set_drvdata(pdev, NULL);
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int btintel_pcie_suspend(struct device *dev) {
> > +	/* TODO: Add support suspend */
> > +	return 0;
> > +}
> > +
> > +static int btintel_pcie_resume(struct device *dev) {
> > +	/* TODO: Add support resume */
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(btintel_pcie_pm_ops, btintel_pcie_suspend,
> > +							btintel_pcie_resume);
> > +#endif /* CONFIG_PM */
>=20
> Seems pointless to include this #ifdef CONFIG_PM code until you implement=
 it.
Ack.

>=20
> > +static struct pci_driver btintel_pcie_driver =3D {
> > +	.name =3D KBUILD_MODNAME,
> > +	.id_table =3D btintel_pcie_table,
> > +	.probe =3D btintel_pcie_probe,
> > +	.remove =3D btintel_pcie_remove,
> > +#ifdef CONFIG_PM
> > +	.driver.pm =3D &btintel_pcie_pm_ops,
> > +#endif /* CONFIG_PM */
> > +};
>=20
> > +/* Default Poll time for MAC access during init*/
> > +#define DEFAULT_MAC_ACCESS_TIMEOUT	200000
>=20
> Would be nice to have units here in the name (us, ms, etc).
Ack.

>=20
> > +/* Default interrupt timeout in msec */
> > +#define DEFAULT_INTR_TIMEOUT		3000
>=20
> And here.
Ack.

>=20
> > +/* Enum for RBD buffer size mappting */
>=20
> s/mappting/mapping/ ?
>=20
> > + * @dbgc_addr: DBGC first fragmemt address
> > + * @dbgc_size: DBGC buffer size
> > + * @early_enable: Enarly debug enable
>=20
> s/fragmemt/fragment/
> s/Enarly/Early/
Ack.

>=20
> > + * @dbg_output_mode: Debug output mode
> > + *	Bit[4] DBGC O/P { 0=3DSRAM, 1=3DDRAM(not relevant for NPK) }
> > + *	Bit[5] DBGC I/P { 0=3DBDBG, 1=3DDBGI }
> > + *	Bits[6:7] DBGI O/P(relevant if bit[5] =3D 1)
> > + *	 0=3DBT DBGC, 1=3DWiFi DBGC, 2=3DNPK }
> > + * @dbg_preset: Debug preset
> > + * @ext_addr: Address of context information extension
> > + * @ext_size: Size of context information part
> > + *
> > + * Total 38 DWords
> > + *
>=20
> Superfluous blank line
>=20
> > + */
>=20
> Bjorn

Thanks,
Kiran

