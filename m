Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5A284D11
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039799; cv=fail; b=Vu6p7hXqUNj0AosWsthlF2mjhV8GtqsKw8W78CxMgjM6M0eRAM86VCOkkUYxPTJGxxQ+Kn63AR+rqIpl7R0tJjkF97bWCIPmjXz5X3r3lCCsPK5DM6AQqmQjRg8aDCtB3LTdRhbQGZnsZURr2x4DBWLlQCeFA5ah/BGXUhpZCvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039799; c=relaxed/simple;
	bh=ZHED+051hYC9buKw/mlIB4VUn4kT8S9Y5msPpiIGg5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uKgxJ7mpqHwFVEIoLEDQInjLq9yUh1tmnZEwW3qbmYwUfAqkir3GlkaU1QSHiswPbjDHwX+NpChaF5MvJMmmZip5Ers5TncoiroxYsI1jh47yWDKJYYO5xxjJEf1B+sPFDBRNjAsUDC39cea7wjWaY818V5XTvS8Y7rT+MBtFEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGq+6xeW; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGq+6xeW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714039797; x=1745575797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZHED+051hYC9buKw/mlIB4VUn4kT8S9Y5msPpiIGg5A=;
  b=OGq+6xeWkhblQwkiTZbrEJiicIfs3qNmiKDK0zrGOrgEKlxZ/4yYaqTI
   CnyBVoMogJR323/l2KbxkH0zd0uamWEc2tyJSFS2qsFck2otAjdwuDYib
   JvoiCnXmXVshrmxS97AdTVrZWfvpWaVS1WB2NUPBnFXzwRgtuMwF0ggCu
   EzamgzYICgOWLlZFj3P5xdJYcE/CBet+xxpIUFdYjx2JC+maoNBVPK8lS
   zLwAdsSFRi/4At4JgZgNQOqfmPAvewLtX9KgCW5kQXtBY7tXs2oBm7P5t
   cfmqysco3hNhd+iF/3z2IzV7TJjLZwDAW8o1fGX6Ffg3m0qbQqdrUdpjD
   w==;
X-CSE-ConnectionGUID: x2pXQn6BTwCNlOV5nYnjDg==
X-CSE-MsgGUID: Azf5l+J9SSiDRPUJZ9TnOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="35110517"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="35110517"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 03:09:56 -0700
X-CSE-ConnectionGUID: RzsoGVImRtGg+YBhO2IIBQ==
X-CSE-MsgGUID: f3En9wg8QF+GE8B2fQp+nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="29650390"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 03:09:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 03:09:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 03:09:55 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 03:09:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5nJ0GbwKefdl8RKJV92FFAcDgJqq3YgiPa7226xlw9x5aMP+ltz2XPZ+A2VVOO2S7FRoOZ+Qgq9NnZQw/52b+r5kP6WkseZ8LmQkD0g6HX3VmhWbU75SIUB2wIiYhS6MKRzhyKFaAcLbcv0N7aBvFl3CKUfTTM0mM/cTkkK6ppH06+roNjwVEKDpKkjy/Jz2F/Yn37wszk8mjC7+FQQZ62hE3YP9y4urjySG70V+BVJ2AyjdLWq794gLZ8bM+StHRkbCNjm6ezhVk4IzZYKjSYiS4C20mgnH7NnwhFCVbWfetH2WW7VW6YCMwPS9g8KmIdRifqzK0cnG5Bf8wi2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tTkFNNe53UEuR59cFE4BQQXrukZgjw4Xlg6pY2RvF4=;
 b=NNjTny1clxPObfbV+WqHMU1g3aT/718H4OKRtfl9SelCgTGVxFVEadoat/q35I9QRZhDPpUEaaVChFXJZ53UfY4jL5nnx9cSGTkcJRCH+P/KZ2JcrDkorL0nc913NTJ1UtcvUHnzroGJtNtzk5ObvNCJGqRBadxJvwWg29uvlXj0JukWkxFnTxXotVZXPNSF3UazwBWdTAg30o5fWMGQGnk3x6+pCD0Xy4C2AE6v6KhhzPn0TCT7sIdbS49LOAkp2WgNq2NBZMaEhZ0sQ/7far03xX7ZI3BJkj/cOqR6DcTpL726RGn2457JwdP0A+Ad8SI+3JfgTzM8HSJYRnn65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by PH8PR11MB7000.namprd11.prod.outlook.com (2603:10b6:510:220::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 10:09:53 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::d6c2:e80d:7256:8a15]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::d6c2:e80d:7256:8a15%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 10:09:53 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v2 1/2] Bluetooth: btintel: Dump exception event
Thread-Topic: [PATCH v2 1/2] Bluetooth: btintel: Dump exception event
Thread-Index: AQHahC3og6997VpueE6hOnBn9WtO1LF46NNw
Date: Thu, 25 Apr 2024 10:09:53 +0000
Message-ID: <PH0PR11MB75854FFF8E6088A0E7BB9B80F5172@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240401122559.1097489-1-kiran.k@intel.com>
In-Reply-To: <20240401122559.1097489-1-kiran.k@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|PH8PR11MB7000:EE_
x-ms-office365-filtering-correlation-id: c5ae61e0-1f7b-4b01-dad3-08dc650fda24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?LQmcZy00ZMbPbtbLRRYgtk217UEabqfTqrpHS8MZOVJvFZxjNVWh+RCu7MbI?=
 =?us-ascii?Q?hn55jwam8QfwhA9RtU/+cnJ4zroRt+wlknCWf0nN9Dn5aafx3FNqYoa2UrLB?=
 =?us-ascii?Q?btS2zCj4BGPYFgVWMlt9ot5rxZ3jfmsj8f6uKM9phCj9niyxksrhX7NS6TW5?=
 =?us-ascii?Q?FhRUpq9pUdO4S1JbdRo8/RA3vLBsmLX+BbGTpYaXOUTqgfWJTTUWlGca926u?=
 =?us-ascii?Q?FaIVoJuLuuz3amTCq/enggjbcZ0aJcKqtcMw0WrLsiLVh+s0v+/gGFENo9Bw?=
 =?us-ascii?Q?Uqu4G9ycVJpdYm1H3qf1dfmjtp1jkSo5K5FeMElGZODoI+e+aBP+kQOa31e6?=
 =?us-ascii?Q?PKj1zka4rVBf/ftjMysWBAviX7cqAFHu8t8ezIya9Nhvkozp1QRZCOVVavY7?=
 =?us-ascii?Q?AHaLlKQoKK74P40tx29aNBu2O8DLZYuM1lM2ML2BT8bLZy0f8FgVIl/RMJV4?=
 =?us-ascii?Q?tTV89cBoOuaLWCeiTZtWy2k0fx4SW8UA+btr71PgMczYXpxMfiB8r7FaDt4p?=
 =?us-ascii?Q?Zhxe2iRYoyA1x4CpRcjG+OV5nKuIEb7xWf3XTC/3C7v0UzqJirfVu4jIwOIo?=
 =?us-ascii?Q?4SEhOphS6HfiR8zAc4DZp5V61F9kyFKIGQ+qdHWURafIZ8BOtCpEuasYHHDA?=
 =?us-ascii?Q?9DvcEnOvblK6r/NhfiDqto2F4iixK1E3iOq9CPq4VlzyNV0HKzrJ4JnjWhUh?=
 =?us-ascii?Q?LHJOSU2dgv67mk2nqdR124krGC0vDARH63mC7YXDnoO/Xn51V36medIFc7F6?=
 =?us-ascii?Q?iV/qfYypbuBXDIiOFaHauGAWnltq0AGAzCR5gSWWvwHPZNmwd5gAR+Nbneli?=
 =?us-ascii?Q?DVzV8TEd9LE57gqe/JRQdaOoknc2VMlVMx4wh9YQx+1iSK52A+G3qTKz/AT5?=
 =?us-ascii?Q?eRV4XJGBTikRKmbU1mceFLDCUy60NE1tZ0pzsIqFHdkqCkolkn4PJzSjPIxX?=
 =?us-ascii?Q?eZyHIbsqUVr9ySkWIXX5M/ucU7hv4xS20G0Pk/bnD93XG1ptgHle9z5iRF9v?=
 =?us-ascii?Q?9QmuZR+RRzBXpGDV3f0w3WcblbP7tVSke6rTl6rMbzzJP8gBR2mS9wEhEyR2?=
 =?us-ascii?Q?ExMzle/KFd3s8VJ2I9kUQE1Sxajd5vIXZx2Fa4PMwSSiznerjG+/uvOe7C08?=
 =?us-ascii?Q?L8tv0mw3ez73lGDmoHjR4HBs46f/aK0D8H5hhAfJ3heRfnKh5KfBu63NEsPx?=
 =?us-ascii?Q?GBOGtBpp2IJ3hWWvGDGWxWATG+KW6vMkQSj+MbryPBOS4QtL5Sh0KhfBM6ad?=
 =?us-ascii?Q?9v1+OsG2nNvwLD7Z14ljjvF2TH4/OxTij9VGAaf6JhzDh5hELPs2gCDBoSm2?=
 =?us-ascii?Q?B0QRYrO4vTdsKiImXiFQDdUHiM5srybkFHxtejeERiqKvw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8BKYodA6/ZCpPeenpc7VBuLPbAS38bN1W3IoPhYzBfXnsm1TWUJOP+wnZvMZ?=
 =?us-ascii?Q?txkJm5vgyfFYDsVBU74WC3xKfRkWwuqO4cWV9meHRnh+nMQOdWN/j3Q2c/JX?=
 =?us-ascii?Q?MbNxC3qGm4pNp+x6ZeyOsIRYCtxU8V+DToruSXj2RuOYlCAcaRdwkY3DExo/?=
 =?us-ascii?Q?OVmi1htoac6+swnnBforQf4pUW6QptUz169nvJLIqI9lSyDQBTVlk3GYE4Bf?=
 =?us-ascii?Q?QOOBkIj6NOdqgkKSWjC/fhJo3x9U/3kv9kruPhtL7U9bb2Y15XvwVJeRDSw4?=
 =?us-ascii?Q?WqwkaxmUMdJameOyN6dWJNNBgC5VWJ5GXCfPQLW24zTK/6DoAj9ZG9BCtM8K?=
 =?us-ascii?Q?6Nm0mpQk8C/sYhgxyyRWF3dM4+umRD85sOxELPf3MvxgqmlzSKU5G0ujt7xU?=
 =?us-ascii?Q?pov6FmYsxxH1x3q7GGaKO7NcPHjY68wjOOOJF2ymKezV9fcSHxXugYx/2txI?=
 =?us-ascii?Q?PwI5Jql6Ck/hUpl7AGfVqVTsJwLVBt11c+tDMK28EnF6u2fZyuN4wYyzw7QR?=
 =?us-ascii?Q?AJAwzdItPzSZ/tZuXGh7M4Z33YWplbGVcAtdvrVANyB32YjMQHvvgNrincXA?=
 =?us-ascii?Q?kJLY3PW9x1Cp7zodq9XFyJUx0GX+pIIq6etw1X6lueuJ1lCZwZ526FUCjtsP?=
 =?us-ascii?Q?phMi0rZ/Tsjo80pld2ZZx2xkpnhC0gbak9E4xqDzrtDI97IiQKrunIEVmCox?=
 =?us-ascii?Q?41AjtE0E7t11Uu+Kk1Kt+AAXrWCAJaaYmD3MRrylE54bt+5r0Qbe4wBARCQ1?=
 =?us-ascii?Q?L3TLjqK54p7k+rdT1FKarF7ke7Hzz2zTwmdimZQXvUJYIsxHbhcnzhSEV0jD?=
 =?us-ascii?Q?oAeherp+CEunfUP5NAO1jeq0F2F2fmS47MN4H1oMqGUhoVm/aG9TXXSZQYFB?=
 =?us-ascii?Q?++Y9wIS1nuG3QMqaEjBREEXlHOpRS3tANNDNKOCWmMm+q4yaBZaKM+0IcKXW?=
 =?us-ascii?Q?oswd6vo9/YNCHB8Jlz4JiIbJPDQpdC2IfQJbQipHkx4i1/oSOZxzp6A0yBtK?=
 =?us-ascii?Q?Kv9Kw1i+d/xnPn0+gUSe6e/BCdUWlbsedYVLKVFrJZ+BYB3Y9zku8iZkpYmr?=
 =?us-ascii?Q?bd9imIJ1lEnTLvJb/opCpfFCZQfItSSN7VOotLUl5HcH6tXyKGmj69NI4opm?=
 =?us-ascii?Q?8/qDwbtwQ3W2GAAORWOeLKT1rfHTl+TKTpXJsN3HemA+tOEoGCZf4JI0w0q4?=
 =?us-ascii?Q?VDW7sD/N51c7l3ISjUS6f9Y/cpVR/cn0elKUq/D1blI6WLFsNnNqFUlFKNAT?=
 =?us-ascii?Q?EG3EfQp7db3dfSC1oHtANpNhOkl/tOsatLHT3H/53CAuCRk7DLuTwa7t3CdP?=
 =?us-ascii?Q?tp6XNlmjuO0fzRFmnkmXq9THkPyMGvWgSNP9TdhTtq/erkJaDW9tbxuDvvpm?=
 =?us-ascii?Q?OWfpiNVdqEfrVcsKD91xgO6It+O0kFhW91OWzJrTmghngKbx0fdlzhJGioGX?=
 =?us-ascii?Q?VT4y1YwtWV684zL25+6+Mu+eHyAyI0DITwipKvLe60kl76ZcgRWb8xRMCY8c?=
 =?us-ascii?Q?F6JiQqIBfu45Dyg2k7iBV3YjDN1sjlJ1MLPdZzucSfDT3lEytqr5G25OaJLC?=
 =?us-ascii?Q?tKGfPh4WPDPiSPXiCKE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ae61e0-1f7b-4b01-dad3-08dc650fda24
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 10:09:53.8478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gjUmKrDnnVn8TLcrNidNsVztQAT+OFuTr+5zCEutV7wyqYy3im5U0qXd9c6hNh5B+/pp+1mV5+uIPLoUdECg2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7000
X-OriginatorOrg: intel.com

Hi Luiz,

Friendly reminder.

> -----Original Message-----
> From: K, Kiran <kiran.k@intel.com>
> Sent: Monday, April 1, 2024 5:56 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; Tumkur Naraya=
n,
> Chethan <chethan.tumkur.narayan@intel.com>; K, Kiran <kiran.k@intel.com>
> Subject: [PATCH v2 1/2] Bluetooth: btintel: Dump exception event
>=20
> Having exception event dump in kernel log helps debugging the use cases
> where snoop traces are not available.
>=20
> dmesg:
>=20
> [27.032666] Bluetooth: hci0: Exception occurred - type: 0xde [27.032703]
> Bluetooth: hci0: ff 4f 87 80 03 01 01 de 07 01 de 06 1c ef be ad [27.0327=
29]
> Bluetooth: hci0: de ef be ad de ef be ad de ef be ad de ef be ad [27.0327=
53]
> Bluetooth: hci0: de ef be ad de ef be ad de 05 14 ef be ad de ef [27.0327=
78]
> Bluetooth: hci0: be ad de ef be ad de ef be ad de ef be ad de 43 [27.0328=
03]
> Bluetooth: hci0: 10 ef be ad de ef be ad de ef be ad de ef be ad [27.0328=
27]
> Bluetooth: hci0: de
>=20
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c in=
dex
> a19ebe47bd95..c0dbbd1a2032 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -3119,6 +3119,7 @@ EXPORT_SYMBOL_GPL(btintel_configure_setup);
>  static int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb=
)  {
>  	struct intel_tlv *tlv =3D (void *)&skb->data[5];
> +	char prefix[64];
>=20
>  	/* The first event is always an event type TLV */
>  	if (tlv->type !=3D INTEL_TLV_TYPE_ID)
> @@ -3129,6 +3130,12 @@ static int btintel_diagnostics(struct hci_dev *hde=
v,
> struct sk_buff *skb)
>  	case INTEL_TLV_FATAL_EXCEPTION:
>  	case INTEL_TLV_DEBUG_EXCEPTION:
>  	case INTEL_TLV_TEST_EXCEPTION:
> +		bt_dev_err(hdev, "Exception occurred - type: 0x%2.2x",
> +			   tlv->val[0]);
> +		snprintf(prefix, sizeof(prefix), "Bluetooth: %s: ",
> +			 bt_dev_name(hdev));
> +		print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_NONE, 16,
> 1,
> +			       skb->data, skb->len, false);
>  		/* Generate devcoredump from exception */
>  		if (!hci_devcd_init(hdev, skb->len)) {
>  			hci_devcd_append(hdev, skb);
> --
> 2.34.1

Thanks,
Kiran


