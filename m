Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5E54963C1
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575219; cv=fail; b=aj4rd7oTFamgq6M5qGFKdUM9N6ijhlAvorMU8BHqO9j9pYAqDwmqEx+935nX+XvZcml3FuSiFBf9plL9AnZBeSrJv2k/7zZc2Iqsi3QmsmG7sZrSVtRRgCRvgRnT07rn3haeYNHtpGSzSQXCOOyb3xk4ngPBRzC/w2N40IBmo74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575219; c=relaxed/simple;
	bh=XWdg4zfdChr6UW3HWQWm/YKWuKvRF2fuJt0amXg7534=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QnG0XqmsJD19TdAD4/seXkxlKU0j1/xNSNipHtXHfyY4DuTTyZ1jNyjASyZrvrbdWzMqxaDi2biLS7yltQFB91ZfqGtd9U2nQ/3WZUQdTnlD8EbbXk0VlRj+2xx3/HDB0RMzLZawnPINmBIHfSI+M5IBELb/kScxQ2eo7PQD6dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQgQdVBB; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQgQdVBB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778575213; x=1810111213;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XWdg4zfdChr6UW3HWQWm/YKWuKvRF2fuJt0amXg7534=;
  b=DQgQdVBBac+ymUaxETRu0hAVdA10QvrXZ/GlV/QM3R04Rf+QcYVr7KX/
   +RArI415N/o4B3vRfcqpWNMKXAXsjh3kvSDkfM2V/mM8YydMt5OO0t0Ra
   vgHfoUY/ETOt6mnoxu5Tiv6OJCg08UFU8NISMO3rZOrqa4yXEJ8MIAaVb
   bGH3RMMW74ts/uino+UyxyifBy+AWn5GWkd+If/7OXNoSurXBa83hGsn+
   zqlyb1SexnborrSYXNgszDcbLMSlLPFACy/RGpE/RQfPiKBgdRdRBQpv+
   4kpTfCSMLX5CARRo7GJ/M4oApKOeYuqJLPEJlcry4b5u3Ih37zJjrIfsj
   Q==;
X-CSE-ConnectionGUID: 5+p2Xqm8QhWDoNKFNA0XIQ==
X-CSE-MsgGUID: narit/rfQ0W9+G6LA3nXmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83330330"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83330330"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:40:06 -0700
X-CSE-ConnectionGUID: LTmkXRqATYanf0V3dBEBhg==
X-CSE-MsgGUID: BOuCCVkfQcabZNtTBsK/fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="241699277"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:40:06 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 01:40:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 01:40:05 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 01:40:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiY2nytjSpM1NxbTCfy3+uWIW7nsyZmuPhX3tes7idDp+sajR3m8HfzrrxUtvgOs0g1Z40GJwU1soxsvrTo4JXh4I+TeKn1brK7KVZdHnvMBk/G6BWzuzULHia1vxMzVWYui+zIURpruYY9UQI7RmVqJpAh5DMRxbAmWHbFOe23ZkpscEgY7NaNwYVlKzbjvQR+RR+SuNxFzLvr564Z/DLfnzNkwtGMobsQD4gieT4qwYz7hmK+ln+GfwB4Ymj35snH+Tnh9F4wmPemmdaOm/VucUMod9KGXwpoGoqsK44u41pO/MQVtVQWdB7tfU3C0F2RTU6/qmqq7ySI5psox4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWdg4zfdChr6UW3HWQWm/YKWuKvRF2fuJt0amXg7534=;
 b=jFtnAiD0Mjr/TtLUdtEU7rhO5LJi533UFIdDjHSZQUGfnuPGVkgJFctabrMTVfqNByOl8+nHbHl/JX6+o5zPScptrhIwwqP7srA0VmjCHV7kWIbp883bRzKnpMZ37sJJEh+7bAEothFduca5QTOOyTr9FeJGPSb1dMLjh3G8Umqe0RMXD7usm9iZixuXcgQNLp3xkXzZO6bWzj74KpHBbVloOYNcaOJ77f4UpLWvywedG/biNUea6XjUbwOOTQc6uJ7IWs2oaKZPOZU7yna5k+2FtzL9xYXLswHbjCc26ZKPfQRoTsEULR9FKkNyJjCaubHf0tyQOGi8S8IQUuTyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by SA1PR11MB5900.namprd11.prod.outlook.com (2603:10b6:806:238::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 08:39:57 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::b803:4643:8d14:f071]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::b803:4643:8d14:f071%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 08:39:57 +0000
From: Ravindra <ravindra@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "K, Kiran"
	<kiran.k@intel.com>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>
Subject: Re: [PATCH v1] Bluetooth: btusb: Add support for Intel Lizard Peak2
 (0x8087:0x0040)
Thread-Topic: [PATCH v1] Bluetooth: btusb: Add support for Intel Lizard Peak2
 (0x8087:0x0040)
Thread-Index: AQHc4deDA+zXoSFJYUKS9qImGZ49PrYJ7FwAgAAlLoE=
Date: Tue, 12 May 2026 08:39:57 +0000
Message-ID: <IA1PR11MB7869332ABD7B2792D6FFA369DA392@IA1PR11MB7869.namprd11.prod.outlook.com>
References: <20260512062045.1213631-1-ravindra@intel.com>
 <33bfcf77-2709-4b5d-a932-ed2987c6410f@molgen.mpg.de>
In-Reply-To: <33bfcf77-2709-4b5d-a932-ed2987c6410f@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7869:EE_|SA1PR11MB5900:EE_
x-ms-office365-filtering-correlation-id: 29f9d2c9-1a3b-4aea-f30b-08deb0020c0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|11063799003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: o9O/ZoSxVtQMk8dK8uEUGgdhBInS5+X5740pMnKKSHiY5vObXN4xCu7rFxxw6E7RmV+3T8PfgLiPvbws3ra6k7+RoogJy2ymsJ1UUby7LqK+Z+bKBLjizQeHD8oLVrxztccf3alB6klPoJp1b1kICwsTIT2RMh5qwZaFKJ0AudqUzXIl97NEmPl33xa3GG3Ht5l5uTEL99eY0PVrk9x2LOdKNec56Dj9XqQZKDkfcxPBZaRccv48N4tBY2HrkJ1SrlNhhNaHI162gJUM7VhsH948j7tq64H5zWneGyhS3s7I1uXXURC+MrhYaHKOs5wqUNZH1ILvFh060NpAekRJ5f9IWDv1QS2rkpWkqeMfH5+IH4Ai0n1wVubn5ZNo+6Y3TXX9iXDaueSputy6Gvvau27iYAYepalJBPVeCtdMoJicG8ziYSQZsnABLmVbTU5Fk9o91G3dvLzgLWYkp/ukbiYhAYTlBX82t+XkisxBXynQq7VzRyG7V77DsILgmePw/0of70BA7U6TYMXwsm0MKTaPEGH8WrKt7nwLO55j00D9eUQ1ao9V3XM/x/KEGHIxtMcYcLZRnJQPRhnFKru9MLTUfGEILj8AAGXCJ8Bzpr588Nxi7mVxg59gybJgICsHegz7Tl7dyG6v0bP0PVOC2/+1LxzMTPlUNfiX/CGyVm4xiTywHIiMEcgKf84SQ4Xl+QaSwc32U/2gtZ06G7ggmDxhDuudndYSyPI1I2pakgLYiwqtHE9FSqF4Bq6dGZcF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ioUKH1TFwaydaoEQOWH6z0Adpm0mCWWK7G8GXqNjpAT4VzfPre8r1pnrfq?=
 =?iso-8859-1?Q?UDXdDXvq6DXNld/Fv/68VAVZI9iYjDxlTysu/e/x6OfStcWUUO3aNpRxkk?=
 =?iso-8859-1?Q?f6Rbuu+Sz02jlmnmCM9WGpV/en1xc5z8rkWiV1W9YBO5OB3/D5Tko0nRv2?=
 =?iso-8859-1?Q?BqDxbXZZ0mNMOyy609RbmcEuimGndwBD8rpj8kZVXk60Zp3RAKK4mYm9sq?=
 =?iso-8859-1?Q?g/p0uWujEiWYMmcz3itEIbnYEJnJrO/49WoRxIYx5F99cFai1K1Y8lPNra?=
 =?iso-8859-1?Q?dExo+cAiu0t5zEhjTMH6p4nnn4qhgRw+yI1YpDq1irxTJv/bKoTO07XvDs?=
 =?iso-8859-1?Q?FSGcWXvBkxHTb3wtKhUuQGMrZV9okENOjYy5HFs2kc0I8fmX+1GWMYekKP?=
 =?iso-8859-1?Q?1KWtCgmVmN7xskSa/5GB8+shISBzQMVomvwbfsaMWhf17iiMdY2/1z0AZ1?=
 =?iso-8859-1?Q?gjZZKze62PUdxdL4m3YW1o+cG40XS8zI6O6XV7ceFdI9cIQUKVgrY44m05?=
 =?iso-8859-1?Q?OWVWBvcjSIfK6LgpQxrJbQt5KqZ4VNIQiE/o1a3RHbb7ngaAYx+q/iu8MT?=
 =?iso-8859-1?Q?Ya7GVxaXTCuJjQFKV2H5+LYi4ptPhrR4Y4ylmqvWYjotYSXg08FUdFOMtR?=
 =?iso-8859-1?Q?9PbwMCL1+VLyZ9lotuYxz+mgX/lK+gS56Vg+mFFW40QtbfVnIsKDMJBdvY?=
 =?iso-8859-1?Q?mejzNctf429c5PATNIRDTPbQygJaCj7PKaGAKxaGCfa0+tvcSTu2+qxrb0?=
 =?iso-8859-1?Q?A/VPQZGdexgMZkd3NU1wG4RFHoB+4tgufLIzyc2E93NYsVquBepdamT5gJ?=
 =?iso-8859-1?Q?G9raifoOXPIqJZhZeuP0vz9fs7fUyjTCUGQ/KG5HNw6SdAcBsetLiKXtyT?=
 =?iso-8859-1?Q?2p2tozCb26g1DPJi4Rhfuew/G7y6gWzXocNtAkGonMMqO2tRhPO4jfBrOW?=
 =?iso-8859-1?Q?Vr250UOnIF2XkI47tGUZ4nXqauTMQwlV0lI2BNPvmxfYcHS4BEeWs4k0E/?=
 =?iso-8859-1?Q?XtocIo9WGWBN2H/JpVHEVEFkgbvmKSoEOP22LvYyq+OQQIW79JdIsM9Ewu?=
 =?iso-8859-1?Q?DRlOYiyqi46R2r29Qy1a1f1HVIyh5601xcsYmiLs+8zvXIKoJeek0Uzyd2?=
 =?iso-8859-1?Q?YQUCwmfyilj1KVtceY97nxuSBtnm9Bz4vg9Nmq4Ki9/r9mBF++w4ZgBpCD?=
 =?iso-8859-1?Q?F6jzQ4myfxh5Skr+HtJeFhdt8CAJZzrdmvf47bwmuvPpqw3zqPbJM3iMsh?=
 =?iso-8859-1?Q?6UuMmNUWndwJymTR1E7sXEdnQWCN2ep1DboJP0ZNge4ec6uxBVYUUkF+wT?=
 =?iso-8859-1?Q?qlGVCL3Xp0Cg5ePUTeCDKQ8+xdEbZfXfPAtUiuejalZIIg1DzGctRW44lE?=
 =?iso-8859-1?Q?L5Fg/nSqlf6Pva/N9+RnKjeOdA2PCpwDLNmwLoU+kYeLlF1Nypz0FOThVv?=
 =?iso-8859-1?Q?wBbBzLrGYqF37ckt9PtBSYTiZMIeYEyxDjsdFx3Zu15UbODJagPBUGuYO3?=
 =?iso-8859-1?Q?I6rHjUs7Dz4PF/bIxLeXa50GUnznSLLPCQDWaN39rPp9Sh7XKCSul/e00B?=
 =?iso-8859-1?Q?2GXyLih3xY72xHr8sFO8LCi7vKGbYS4u4TaWFHGaH3qwcAYv7Hz/DX52lu?=
 =?iso-8859-1?Q?Ep/lga+cgEeUoHu3F6XHbJd4yGFqF3mEbREm22bk3TbTLSfCCWffqxWgZW?=
 =?iso-8859-1?Q?4FFdWTTRvkPdJeihxPBE1hQaUvRDu5LJoCXt8gLOc9zsBoZU5qERvm+8zK?=
 =?iso-8859-1?Q?l8TS3wLVuFF4k/FveFsUlQADVmVRLIJC03wsqQpvuwFW4i?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: laBT1ddvojOovPA86V7IGi+6XHrVvS75IiZYb7hF5cn3H7hlluRUpWMxNrP3+brsKTVb1v0OomgdiGBi1WiNRetCeNcGdMuFY5eOdxmzUXk66K2DAxlAt1mdqZsYrK1A/SPQkcK2habVQ8cJ1ZrgM5KIVb9tJmOo9vz2dLLWnnBQLlr+Mgw9RpKLRCRT/zqBwaq5dfdtLxOyhWVyzFQvKNuWy6kSqvu2gXeuOfZXPPGuKVwMjFLGcD53rKy3yQtruAG5ZycqXrp0qzS/5fEuXT4BjBvULBCUXn4lsXUNQtpJlk6IuaQE6S6Fe3f3DVIysq5i41626cxAQ6uXQpA3bg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f9d2c9-1a3b-4aea-f30b-08deb0020c0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 08:39:57.1253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0L99CV4s3L2no2Pj3EZqbU8N+a6neTZeTvKbPClaCOkc5t5lKGQ2KHXVv+m71YNbXUHVhpATVaLW5J0Je4Llrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5900
X-OriginatorOrg: intel.com

=0A=
=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Paul Menzel <pmenzel@molgen.mpg.de>=0A=
Sent:=A0Tuesday, May 12, 2026 11:54 AM=0A=
To:=A0Ravindra <ravindra@intel.com>=0A=
Cc:=A0linux-bluetooth@vger.kernel.org <linux-bluetooth@vger.kernel.org>; Sr=
ivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; K, Kiran <kiran.k@int=
el.com>; Tumkur Narayan, Chethan <chethan.tumkur.narayan@intel.com>=0A=
Subject:=A0Re: [PATCH v1] Bluetooth: btusb: Add support for Intel Lizard Pe=
ak2 (0x8087:0x0040)=0A=
=0A=
=0A=
Dear Ravindra,=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
Thank you for your patch.=0A=
=0A=
=0A=
=0A=
(Is the spelling for Lizard Peak2 really without a space before the 2?)=0A=
Yes, that is correct. According to the hardware specification and the firmw=
are strings, "Lizard Peak 2" is written as a single word with a space.=0A=
=0A=
=0A=
=0A=
Am 12.05.26 um 08:20 schrieb Ravindra:=0A=
=0A=
> Device from /sys/kernel/debug/usb/devices:=0A=
=0A=
>=0A=
=0A=
> T:=A0 Bus=3D09 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D=A0 2 Spd=3D1=
2=A0=A0 MxCh=3D 0=0A=
=0A=
> D:=A0 Ver=3D 2.00 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D=
=A0 1=0A=
=0A=
> P:=A0 Vendor=3D8087 ProdID=3D0040 Rev=3D 0.00=0A=
=0A=
> C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA=0A=
=0A=
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb=0A=
=0A=
> E:=A0 Ad=3D81(I) Atr=3D03(Int.) MxPS=3D=A0 64 Ivl=3D1ms=0A=
=0A=
> E:=A0 Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D=A0 64 Ivl=3D0ms=0A=
=0A=
> E:=A0 Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D=A0 64 Ivl=3D0ms=0A=
=0A=
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb=0A=
=0A=
> E:=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=A0=A0 0 Ivl=3D1ms=0A=
=0A=
> E:=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=A0=A0 0 Ivl=3D1ms=0A=
=0A=
> I:=A0 If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
=0A=
> E:=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=A0=A0 9 Ivl=3D1ms=0A=
=0A=
> E:=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=A0=A0 9 Ivl=3D1ms=0A=
=0A=
> I:=A0 If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
=0A=
> E:=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=A0 17 Ivl=3D1ms=0A=
=0A=
> E:=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=A0 17 Ivl=3D1ms=0A=
=0A=
> I:=A0 If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
=0A=
> E:=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=A0 25 Ivl=3D1ms=0A=
=0A=
> E:=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=A0 25 Ivl=3D1ms=0A=
=0A=
> I:=A0 If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
=0A=
> E:=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=A0 33 Ivl=3D1ms=0A=
=0A=
> E:=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=A0 33 Ivl=3D1ms=0A=
=0A=
> I:=A0 If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
=0A=
> E:=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=A0 49 Ivl=3D1ms=0A=
=0A=
> E:=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=A0 49 Ivl=3D1ms=0A=
=0A=
> I:=A0 If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
=0A=
> E:=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=A0 63 Ivl=3D1ms=0A=
=0A=
> E:=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=A0 63 Ivl=3D1ms=0A=
=0A=
>=0A=
=0A=
> Signed-off-by: Ravindra <ravindra@intel.com>=0A=
=0A=
> ---=0A=
=0A=
>=A0=A0 drivers/bluetooth/btusb.c | 1 +=0A=
=0A=
>=A0=A0 1 file changed, 1 insertion(+)=0A=
=0A=
>=0A=
=0A=
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c=0A=
=0A=
> index 572091e601f9..3f012c2a014a 100644=0A=
=0A=
> --- a/drivers/bluetooth/btusb.c=0A=
=0A=
> +++ b/drivers/bluetooth/btusb.c=0A=
=0A=
> @@ -484,6 +484,7 @@ static const struct usb_device_id quirks_table[] =3D =
{=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 { USB_DEVICE(0x8087, 0x0037), .driver_info =3D BTUSB=
_INTEL_COMBINED },=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 { USB_DEVICE(0x8087, 0x0038), .driver_info =3D BTUSB=
_INTEL_COMBINED },=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 { USB_DEVICE(0x8087, 0x0039), .driver_info =3D BTUSB=
_INTEL_COMBINED },=0A=
=0A=
> +=A0=A0=A0=A0 { USB_DEVICE(0x8087, 0x0040), .driver_info =3D BTUSB_INTEL_=
COMBINED }, /* Lizard Peak2 */=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 { USB_DEVICE(0x8087, 0x07da), .driver_info =3D BTUSB=
_CSR },=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 { USB_DEVICE(0x8087, 0x07dc), .driver_info =3D BTUSB=
_INTEL_COMBINED |=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 BTUSB_INTEL_NO_WBS_SUPPORT |=0A=
=0A=
=0A=
=0A=
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
Kind regards,=0A=
=0A=
=0A=
=0A=
Paul=0A=
=0A=
