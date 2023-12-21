Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75CF14F76
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Dec 2023 07:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFzgmG7l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703143662; x=1734679662;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dcijkLsIdQDXy9vUohXGH3AvaJzb1a1UAJn3Is+c2lA=;
  b=kFzgmG7lM0G1iAtVEpx1rwy9VRiPpT+8oPR8ae+gEbiN7WcbakkzLlZH
   DgHqCmL21CdMi/ru3QsPR5EqKhGTbcVebb8kKv9inKo3zgp0HMHa+YB/r
   tJWUt0nooyTfIHbaOIYtVG5OPneEc4p/E0w1Km/t7876j80+JqQsg6MB4
   0TDm/+ovBqwW6Ro7vniS0E0watPUlr+GSQAlsl54kA9NvTNQQiWudU5KD
   eh/VJZhofF2kXp1mrenYrLEOidlHGfGN9DjglGaXQ1D6m8pWzDkEXZln+
   6L0Piv3UgfOxDquhoUWKEk/BjOUI7cC5vag/OD8ylKmZn/ChKzehk++RY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="380922139"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="380922139"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 23:27:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="24871563"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 23:27:42 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 23:27:41 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 23:27:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 23:27:41 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 23:27:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bq+GiCGgpBD8Dv/6v7Jx5GndKcYbzK6Op1XAOzWUtQPmNERh9y8DkbufpWu2l/pdc8wIT11VUxfteJYNEDNARs24TEDI5IUjz4JeySXyIQsQo70kV+2+HkC9woGtTjRKHW6bxenmVFt1GTMzQRis/jldI6/pTSY/PKfOo3FLCIf1fi+lekG6KWHw4qeELb3o7lUt1LYjWvJ/qCWUs/c5+tK5QskrR9Ee/DSe1wI4pWU7QPNmRLWCPbHmtnrDEqL9SH4R2bKgFsNBtP5j7FOg+IIAyvrLkjDPaIeNnkMjZ0eUP4UnHrRm7vXwzZ2gYEgMWh8gY4k7VbffrkXbwnynoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIa9ZtZap3ouelOIumKebAuv6YuhcOzYj5qNVXZX1Rc=;
 b=IVEhpaXzFEviJrqGF9VTSlt5/XJmIHH8OKDvhqiO+WYl+ZR1OjRi9652covaDHO1yU1vfcbn3PrLTBh2Cu0QIMVavXh4M3nkBGO3SxE7W8507hYGk7zwNaKOyrCmTFdBxipB9ZOa8NBfabLMBqgVgpsuX+98WyTFIhITcZZk2ZvWiwc9bSPNY/dATXjajGkHHWqm2HxHZBHnoVPsH6x8lKPnupnUki/Hv2yCbQEA9hqn2OkVRSvVqnyfYwx0ACrNSZmd9SZZ6vrlQGQYZA8x6D2digl9P0plHs3lOAQbzoh2knXVpUjm/Ne5BzzLjWeF5cF1eLTkhYvoYRbTev5Mng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by CY5PR11MB6161.namprd11.prod.outlook.com (2603:10b6:930:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 07:27:39 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::56d9:3121:52a4:a29b]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::56d9:3121:52a4:a29b%5]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 07:27:39 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Subject: RE: [PATCH] monitor/intel: Add decoding of firmware SHA1 in read
 version event
Thread-Topic: [PATCH] monitor/intel: Add decoding of firmware SHA1 in read
 version event
Thread-Index: AQHaIbHFh/xdPEKhW0SW+9yWxV1UgbCzesLw
Date: Thu, 21 Dec 2023 07:27:39 +0000
Message-ID: <PH0PR11MB7585777630CA07B48FBF3C3DF595A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20231128042922.2514576-1-kiran.k@intel.com>
In-Reply-To: <20231128042922.2514576-1-kiran.k@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|CY5PR11MB6161:EE_
x-ms-office365-filtering-correlation-id: ac2a439d-9b90-4040-35a2-08dc01f64fed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ycrqz9dGJOi+Au3TlOTXXCJyp5JHltRONtxR9/rP5hcd97aNupOa+wdqC3gQGSGb/nja9EnChpfURh6ppHzO1OnPVUcyd3PA6gjBO+mkrdesOEN79b19QzklFWqRWKezIBhWwnTFeO93oD0YSBAoiRnKvx0+RMraa05K9BspZgWHCtsriy0ij7K5i7tsEmIdOwfgXuHnCcXoGvl8qiVfwoSNcgN+kNj+2BnEqzaRSzAGad2uuY8mFfwwR+PMkSQyD3GLddYljy2UdlbzKvIiDrALlqgKelSS7ZvDjsnh9jr3S4gCZIXiAu2I3D1T0n8extvpwB1j5azNn2auaR5AKpMNuZTQIE2CFVjoNdjlB3OJ9+6XF3g8HL+/ppA9jNuqeD86t+WW3u8IgC7UKnWSJy2fcuvZSsnACpPbZ/oGr5UU0pbbt6B5ZBMcls9bHrytKmH07encFvrKjmuuv7DrZvU776sAZU5EWckZANuJoK19VUhJTWQUibhr1Dm0Wg6wtL71hI0bxtP2mfU7HFr06vZmdQha1qozknlYis8mYl94B+3k7cjPOhCpycD2SEPRK7a5trZKJzDIYLxwCqP63yxykmBEFV13H9u7cr/DqrQoxSpDRs+m1A5wlxb4nXJS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(71200400001)(478600001)(6916009)(66446008)(316002)(64756008)(66476007)(66556008)(8676002)(8936002)(66946007)(76116006)(83380400001)(9686003)(53546011)(6506007)(7696005)(26005)(107886003)(41300700001)(2906002)(52536014)(4326008)(5660300002)(86362001)(38070700009)(33656002)(55016003)(122000001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?10iSJuyK1gbYQlpGfN0woQXIo/k1OwWPHRYDAWtdw7POCW1OU9SWCJillBj6?=
 =?us-ascii?Q?u2cbNazSae1sWf8Zr4ywddsUAacPEoBu6iIWp4UNgLWBWS6s7F7NFSoZxGZV?=
 =?us-ascii?Q?eQInCQS5EsUbqe74wYRKMHObvN3TGx9it5FfXSWjOBGXjzsV1erO4V+R36Wa?=
 =?us-ascii?Q?nrgFWd6ZqDgLsZUPcseWXIaFwDG9gLZTjx5BWEWdmKFIyGFawr8A5fvd/A7Y?=
 =?us-ascii?Q?sjUdPX3WsElJCZyzh2RWoeWNY89L6j/qFvXQJY3maZQ2dHNNq5ocf7a+9SSA?=
 =?us-ascii?Q?IWBmW01xC5flsFpW4FyhHEPoLDNC4+Unl6IRmI2OPgmaUABVrRJnL6TnXJMm?=
 =?us-ascii?Q?lHjkoAHNgsIXhn5lnw6V/irjR/e5jo9dfEvrdEnzRg0Hs+R/aLzV3NiUEy88?=
 =?us-ascii?Q?NKiDOWPIZq2uDsUrfIjZ9L+OlFSBxiHTFk0ISEC/shHZE2b4kXEHawiWatzT?=
 =?us-ascii?Q?X7Uai5yNNr9E2us763lRU7wsXOvViPB4YjV43etjj7TajzAgpCyhGfmRM+PQ?=
 =?us-ascii?Q?L/KIXxCSriS7TaLebqk9ONq4n+UJxsit/DYXvjjJh/1naUfYOt9ZGoTuuAyI?=
 =?us-ascii?Q?+xLYkAKKnkRHIaSdpPLOPP6g2W9Gq1eotVfrd+nU2O8jlanR0T+UA6zpActs?=
 =?us-ascii?Q?2VhWkSOB6MPEy0TH8Ag4VacE1sOCMtDb6LX0Uv2gBtODSH17mEXJF4Y2yP0f?=
 =?us-ascii?Q?dfi/tLLtyx0oTYwnYseNhhZB+B/mC5oaltBCUHugbLQ/YfXm7zy6ODdoJxMU?=
 =?us-ascii?Q?H6kUWnNXKaZ5URdhSyQJYXcgfLfkby6GYMLDJYuW3MJGpE5Ljl/TZ/MDQZug?=
 =?us-ascii?Q?xfRLbFO9GuhM9NHgPzvY5d2Z+n4vrY2p/99QafUAC7YT5oC6nr8OtcMZR+0m?=
 =?us-ascii?Q?uZxnI6EiPNbVUNGN7FYsMZlDSXfLdNWX2rm7o2II8QGDq4NtJHPwS/yF/s4S?=
 =?us-ascii?Q?OQ8/5lzt2PJUC4N8aBsZ5COd89sz0pZ9Jeg1IULa3NZ0lSXAqOj6pC+fNYEB?=
 =?us-ascii?Q?9YD2epLjBnoYzkOTROO8pK+HBDZE1dzn/ab+k6IHvvAzJd3co0tZAqWmlabR?=
 =?us-ascii?Q?FcukhLdNySkQo340d49egO7x0KyAX/hyatNvpF3Y22lNLKx3o1gvqsK4it5j?=
 =?us-ascii?Q?7Jbm4e4n0ChLDsHUm2z+HmQOoX9Nrux7ptzFi0jxUWGOrZu69RF36KbRFwzY?=
 =?us-ascii?Q?0UAN0HWJHSbMe2IjlqXXiPt455rgOUM56GsXPNmREvMTmfOjxBmmqFdmtWwu?=
 =?us-ascii?Q?vITkmrVdUmrStyEOS8YXZe2XHq2mkYoRDT7H1kpO8f9fsHg2TPuEuL3CfSNI?=
 =?us-ascii?Q?c1NIF0GFQw8Hjr6WM8fLRUXZZreWNNji1hIXvDU26al7vW2O1Q+rhtlJmXBS?=
 =?us-ascii?Q?zS1etfSVpX1r7gizj+pqgEHDnI57aTgUKpc2xs14E+cZdpGFKnakfnM0FUCu?=
 =?us-ascii?Q?rQf2lsPMF3Z4Yz7tGzK1AOHupDHPNOTusouqO9QGNsb83jnvXlf/b1sjZ7ZA?=
 =?us-ascii?Q?hnVTY/lvUlDsx4db50MRs/xCJVKPRaOlJYs9P24LUdbbPtF16RPTlngFBDYW?=
 =?us-ascii?Q?8qpHJU8UwI6NyCyYj60=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2a439d-9b90-4040-35a2-08dc01f64fed
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 07:27:39.3857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0LxPBr+6XdYV2/zkrmWsbjN7PRKFfYvaytMSJYGLJjWQwBN3WBKqn2Vn8Jl4UILBnFlXVDTgPCAeOaANdILDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6161
X-OriginatorOrg: intel.com

Hi Luiz,


> -----Original Message-----
> From: K, Kiran <kiran.k@intel.com>
> Sent: Tuesday, November 28, 2023 9:59 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; K, Kiran
> <kiran.k@intel.com>
> Subject: [PATCH] monitor/intel: Add decoding of firmware SHA1 in read
> version event
>=20
> < HCI Command: Intel Read Version (0x3f|0x0005) plen 1
>         Requested Type:
>           All Supported Types(0xff)
> > HCI Event: Command Complete (0x0e) plen 107
>       Intel Read Version (0x3f|0x0005) ncmd 1
>         Status: Success (0x00)
>         CNVi TOP(16): 0x00400410
>         CNVr TOP(17): 0x00400410
>         CNVi BT(18): 0x00173700
>         CNVr BT(19): 0x00123720
>         CNVr OTP(21): 0x0413
>         Device Rev ID(22): 0x0000
>         USB VID(23): 0x8087
>         USB PID(24): 0x0032
>         Image Type(28): Firmware(0x03)
>         Time Stamp(29): 23-42
>         Build Type(30): 0x01
>         Build Num(31): 0x00011d97
>         FW Build Product(32): 0x06
>         FW Build HW(33): 0x06
>         FW Build Step(34): 0xa0
>         BT Spec(35): 0x00
>         Manufacturer(36): Intel Corp. (2)
>         HCI Revision(37): 0x3597
>         LMP SubVersion(38): 0x3597
>         OTP Lock(42): Disabled(0)
>         API Lock(43): Disabled(0)
>         Firmware SHA1(50): 0x2e575f2a
>         Unknown Type(51):
>         00
>         Unknown Type(52):
>         Unknown Type(53):
>         00 00 00 00
> ---
>  monitor/intel.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/monitor/intel.c b/monitor/intel.c index
> 0191987d45fb..4aea4d5fbb99 100644
> --- a/monitor/intel.c
> +++ b/monitor/intel.c
> @@ -291,6 +291,7 @@ static const struct intel_version_tlv_desc {
>  	{ 47, "SBE Type", print_version_tlv_u8 },
>  	{ 48, "OTP BDADDR", print_version_tlv_otp_bdaddr },
>  	{ 49, "Unlocked State", print_version_tlv_enabled },
> +	{ 50, "Firmware SHA1", print_version_tlv_u32 },
>  	{ 0, NULL, NULL },
>  };
>=20
> --
> 2.34.1

Thanks,
Kiran


