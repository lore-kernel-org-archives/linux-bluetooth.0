Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1CA524AEC
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859931; cv=fail; b=GFt5ho9AhIK5lDXdPeuucEfP6ybCPoax1J+SxR8vNmp8xBb8hKJF7a8Cft05ODfun6cvIrWL5hBfEVGXYlORAqqulgW+/Mz8ZtdmO4kr4ErZ6M/I5SPV8gB/yLhXpGja4Y7mpBFT8Tfud/cnryabpz1gDGw0x2K+jV7WLXBeT1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859931; c=relaxed/simple;
	bh=uZIjIONIb5kinM1IruqfnjEuscZL1qPmp4eRoARpak0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B6qNaX0/MPe2v6onDst9YbnLObiDt/lzESsjFjVkwoPnzQguwqasReVBnRY46sLFuNDLqu6GIOPsm0ZzB9XMTcm9hZurcsWlDaBb/2+UbqXRscEmKtykMv4xQ+ziqI4HpswSmYIOE4KEDXIr6MAx9nNLdfFexO69eWsBNCL1jks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZveF7+d; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZveF7+d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788859930; x=1820395930;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uZIjIONIb5kinM1IruqfnjEuscZL1qPmp4eRoARpak0=;
  b=FZveF7+dPhh7RkW9w6ACjnQAacBq1+qhGElbfsBq8K8oEqUKTrgg6kCk
   bN6sT0/wwv8IPt+J2Xagll5C4ebezcMNRSngZhHmLv/0rUgjdqux6ldo8
   oixkV3JY3fESeGMI1OqME8NJl3SZasrreKRzpQqOQC6w1kS+co1o6YtZe
   czjDMdu8Sf+VxdIYEekScrxNviYb31S7HYcrkODwqfA5dhu3HAmmY/9eb
   A7zHsG92xKJchq4uQnw3dtCQJY6WFKlrpcJtC+gxzh2KgqqbpnDDWVMZe
   WwH6ioehzmyHQdvwP+FNujd9jiYvwxWhVBjOdUuLGbq/zoifQLmvN+pk7
   A==;
X-CSE-ConnectionGUID: GCJxoOjhQy+ksvCLkE5laQ==
X-CSE-MsgGUID: 43uh6N2DRW6mlpQWnYzXfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="100612365"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="100612365"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 02:32:09 -0700
X-CSE-ConnectionGUID: e/EWDMJ0TxGtf7F4bWURDQ==
X-CSE-MsgGUID: jUlGopqYQF2pE4aWyjmz9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="295843181"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 02:32:08 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 02:32:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 02:32:08 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 02:32:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lY7WP7xN7BOpbsd3PikzODXNWQ0RlvLqcshFYRZ4WqpzZbvXq6wadOQAMxjYRHMmJt1yj3n6WstwWobXR+ryCfoVMJSPnif5McF7U4feCGl1ATQTrajqzxgBxwDNKc8DYynTUwdPBUKzEYMrvfbmoKG2RlNqKmniJgkpwgnTNt6aXmAzFeR4KqABw36vCjPsEjAvoWnTtUZem1Z3zy3S7vk4X3lz5C9iOTnQ7I/9teQS62i/YFSQoV8qdBCob5326IgriSBEw1BgeYXNAxjEutQ/vj6mzITZFPv56b8XKj7lSlxJPs4hymyMUIh9sM3UxQVFZevAqQMKq6/F9uDm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZIjIONIb5kinM1IruqfnjEuscZL1qPmp4eRoARpak0=;
 b=jjKngTBmyB/wH2e2/GlEucBX3fREUoLxfc/lyLwf99dp6CFfK26e+/u7DPz04R02Qtnf4O7lCzhHtIZYJPCqWv2r8brnk1bsNi2xwZTv9AZDqIONGrDuFXQ+RQqhrB+WnHkriIkXa+NTpFSX+gb8Il1vNwLVIICzrbuhBUopPCQTM3eW9xxiep0KfBYCuCYSLfEojDSEhlP/4wKzE/xiiEasInnsN9cft2A3GaCfxtXHb7g6BN1hJxTL6oQPyHU3QwwAWWjiH95WZDwDzbLIAPFqC4grZCQpQX5NnqRlJDMkrocK3uOOP4OlKyeka9YzNdJnDtJEYczvfgFHNNb35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by IA3PR11MB8895.namprd11.prod.outlook.com (2603:10b6:208:579::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 09:32:06 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::b803:4643:8d14:f071]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::b803:4643:8d14:f071%6]) with mapi id 15.21.0382.012; Tue, 8 Sep 2026
 09:32:06 +0000
From: Ravindra <ravindra@intel.com>
To: Sergey Lebedev <lsa.uz@pm.me>
CC: "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>, "K, Kiran" <kiran.k@intel.com>, "Devegowda,
 Chandrashekar" <chandrashekar.devegowda@intel.com>, "Srivatsa, Ravishankar"
	<ravishankar.srivatsa@intel.com>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>, Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v2] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and
 S4
Thread-Topic: [PATCH v2] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and
 S4
Thread-Index: AQHdOrr4SMD3PpRNTEWWSArZHrp2rLbEboDQ
Date: Tue, 8 Sep 2026 09:32:06 +0000
Message-ID: <IA1PR11MB786922E0DBE2CDC8FB00C5B6DAB12@IA1PR11MB7869.namprd11.prod.outlook.com>
References: <20260902091021.20160-1-lsa.uz@pm.me>
In-Reply-To: <20260902091021.20160-1-lsa.uz@pm.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7869:EE_|IA3PR11MB8895:EE_
x-ms-office365-filtering-correlation-id: 907bf09b-19b0-4a89-4c22-08df0d8c0c4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: LgWK1EvLKCLoLE/OgFh6aAb+BXpr57akVOs/PPVJ0QJ0coRvlK5ZM364QFSb0TisIEwHP3v/YRq3BjVfF4kilaE313D4DhtxwFa9Q7EWBYsGwyHcU5y0UleyrYcC++4vllXYJ8ppjdpaAmXexEZ7od78AQoz9XQKH5ozmO4qC5IpY8GcT8f28FnsHTK9WsxwEWJ0RD9IGfMAGYrcVruoLr2gnTpZJvZ3zeUYtmWpAaYzhIgiRLnYTX4B1k4VcMmyPTkL/pc6hST2RGs7R900bkwFEByi9cCDeFAiotWHs8BURHIufjbHuC8ZmPgbYwjCxqWbvIXcFu/0bu1DnFds48vFQ83GWgIj8Tdj5ycjPTkvLAUKagMCi6fAwuI9nv7kys8PX42HS46fsYPbDZogC1mLL3s3w1gIr1Krnz8rOM6YNYNDd2OpTJJGLg8jsop97+FkvDk0dpUsMItInYjzgzdUt1L2L1MdeRdsBiO9udWQKJ2HGe1O/yDaIu8Xb4UJ9wtpI/ZsdaYPl1SM8Eo8lfOcnJP2qx9uGS143eqeV1EELgEmdjrcGqdhd5tUM2XBxrju9t84uosMryB/y0FK2RiXBfkMN1+TIxCe9dJp5qe5REPA8UUiG1GjvdTm3q2cf6RQZPdx/mENKg09RzkTbEDP8+JI0J1S1gBHuukvGDL3ulL9sk0yH6tXsmrrPL5+vbqU4W8cjj88WstUt8ltmEctjKcxYxGsIwJiHdBuHAM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFRBWTkvUnB3Mkh5dFNqRkxUVVkyeDFQZjI0S0ZpeWh2bkVlN0pFblFvV205?=
 =?utf-8?B?WndBQ0kwSWV3b09RNVAzNEw0aERGT0pvTWZXeGdUbSs5TUxScFFPQlNVbFM3?=
 =?utf-8?B?T3NuNlV6WjJWbHA0bll1S0lRcHRpNjZlaHc2cjk4djM2VmdQYkdpZDM3T1Ez?=
 =?utf-8?B?MDZzbnRKRkZ2cVFDMXF0RDBlUDFBejZabGJTNUxueHJMblpFMHBSZGdKS0tr?=
 =?utf-8?B?UDVBWG5MWGkzeDlNZ2dUTTNSajlVVjBpT1R5ZWZtWTRWd2ZDNzBBR1Rxb2Fm?=
 =?utf-8?B?bXVnYms5M3BCc2Rienlhcmg5aFUvMUpzY25rV2ZsTXBSQm9xd3R5b3N1YXlW?=
 =?utf-8?B?d0NUVy96Zzc4ZE5uaVFvdW9CVGFEaWN3c1h1cmZpRFk1d1VtMzBkajh4U1dB?=
 =?utf-8?B?K09TZ3pKeU0ya1V3UTkxYlVFRXkyOExKY0Z2RStsUi9FSWhVQ203VDVoMUg1?=
 =?utf-8?B?bjJKQVAzMUtsVjVaUE9xWGhTaDdnb083YlJZdjRsM2dhRGEwdFBRRlh5V0Ju?=
 =?utf-8?B?d2JRdWoyZDBUVngzSmhLbnlxR3UwbjFCKzZrL0FHclJweS8xcit0L0NtYTYz?=
 =?utf-8?B?TklNSGR0NWZzdy9yNkZWL3U1R1BiRDM3TEtwRWhoUlBrcGxKRHVQRDhpLzFs?=
 =?utf-8?B?cE40ZnVTbHlkdk5qOTFLZzRlZW5iMnBRWEhlcjcySGtNYmRDZWdTcXpIMkF6?=
 =?utf-8?B?UDdjVGxOWVc0VEpXUUhFa2FHZHlXMzlBOGhvcC8xaGh5L1FESE9vQlFuNklG?=
 =?utf-8?B?Wm11RnA3cGIzQ0xPN0pWaEJMMUo2TmFGd1NkaTZ6Z1pHVlBGMXdUL3FzMEht?=
 =?utf-8?B?OXJVTHRyNm81MndrTHBMTUdmcE4zSU9zb3FibW5SU01GY2QxMUFhekt6djYz?=
 =?utf-8?B?eXNOY0JTVFV6R05NL1V4NDN3YjgralA5WElRRGhLUkV3Y3RpRDBHbzhDODY2?=
 =?utf-8?B?UDJsRUtVV0JVMzVYbUgwZFh0VzRGN0J4NVNqaERnSzh3Z2RMYkVrT3BWbjds?=
 =?utf-8?B?OXJReS9OZ1NPZEtMcG9CVEdra0JMMUxNd01MVnNOT2lKcFR1NEcrbTRuMnI4?=
 =?utf-8?B?ckRGRmZGMnRxMUdTMjhYcmVzRWpXUEorSGVmUFJpQjlkOGM0YmFsakdwWEJK?=
 =?utf-8?B?bmNnMTNCaUpOaStiZHlFSWhWNEpaYmdkR0hhQ1EvZlNUY2phVU1zVURGdUtL?=
 =?utf-8?B?dUZBOTEyZXZ6N1NqcUZ2NzlkRE4vM2FlTTBZMGNtaGhITk1aMDF4d0ZSN0tN?=
 =?utf-8?B?czJVSGpVeHRCK2dqRFNrUWNzaXJSS2pEOHVIT3JCRHNCeFdER3QxTzEzejhJ?=
 =?utf-8?B?UmswQm42OGxWWHB0UXlFaENTS1NmVnBtSkJsQTZsejl1QUVSb25UcnFZNDZq?=
 =?utf-8?B?RmFJRU1jZjhsTTVleWE4SlhaTjcyT2tGblZFSmZJUWNySUF0STJ5Y0ZiVk55?=
 =?utf-8?B?cEFTb0VDUUNVd2ZPdVMwc0duQ205TGhIZmhGRnpXQVlTT1FRNVp6dUlDVlla?=
 =?utf-8?B?SlVCWEhtTno5SXYwVnRwbE9aa3ViUXhwQmxmK1liTzI4dlJza2xNNVlmY3dP?=
 =?utf-8?B?NzFPN0JXclVKUVVCNDZFZ1NMc3duWmsvVWkyWURyYmRMOGVTZFFUcGxUb1hS?=
 =?utf-8?B?OHFxUFk0STVFbkx3OW9RL3dVVnVKZDF5eHgzcC94V3ZvVnp2UUdmek5vVzlp?=
 =?utf-8?B?d3RFN3djbmovMjN1ZnF6QnAwckZVb2tiSzhGY2dhYzNLVGEzM1VMLzY5S3BR?=
 =?utf-8?B?Wld6ZWZnWjdBTUlQZTVrd0VTQ0FuVWQrWjBKY0JoNlFacFRnTWVZRUhWR05Y?=
 =?utf-8?B?SzhzNTR3Z1R6d3Y0VDB5M2lPSWRXblhFK0ZhRmtPVzNLbENoaG12ZGFvTVh1?=
 =?utf-8?B?bVZVL3VGby9YTXN4VnlvN1djeFlIMUZUMnlSb0JFRWFXenpFWTdJNWJIWGlP?=
 =?utf-8?B?aCtwN1EzNXdoRU5FeHpOcWI3VTM1RjRnb3R0dHV5RjhZK1RMTG5BWDhwUTFa?=
 =?utf-8?B?eUVKbFdVK0xLMXgxaGFxaWNGSVBSelBuaXZ6QnlvZWloQ050V25SbXFESHJF?=
 =?utf-8?B?c1pza3pUajFxMi9ZZU9haGE2c2k1alpIdnNKaUREcnMyRWRFZFI2Q21GeC9J?=
 =?utf-8?B?aE85Z2pnK1daSTQrZnNReUJXWUpxSml6NXlkd1FjK1VxaTlXa1VrUVpHR3pE?=
 =?utf-8?B?S2wwRjZIRWRleWw2OVJjblNmL0pQYnhTWGlvWFNIRDhkdWhxcGJuL2NyZFRB?=
 =?utf-8?B?R2Z6Qk9IYlRDWmt5UnRKZjNvTDBXNmpZNVlDdHdicUZabXBoN2lraS8wTmdT?=
 =?utf-8?Q?IirriJwK6vGwau8CYi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MuIStxaCnW1qCqhpjGdpho8EKo9b816MwpuNJRWMa7sc/eqZfDubT3MngpmktIN2QD4r4kSd3tE4v+rn1FEHV9mgF0+SoD44XCsdhM1UbnxU4nAlpXwDj+UXakkEaG5LXqFYqzPcqlgVyux1OxUfhlFSfuzpVH7WJRa5x+2dZ9Fc8aZVyNuiWZCneB0AkC1E9Xa7GJI7V8CuKql9s6+z/O+Bw1ewzJIuaa5xidtypppkvuJNr5akrjpKTvsxvqQn9A/3LTTdEBgamTKsyD1ViUe/+Z+08ImbsSAYVlmaKq77UNWbVCw7PuwHke8dnzdsuT2k8rct0Fur5dzlQZJWHA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907bf09b-19b0-4a89-4c22-08df0d8c0c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 09:32:06.2314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +MLjcVsxoXi3/dyjqHzWjevbt5Ug8VaInq11j+/HBM9ufBfdyENDzXuB4fT7508em9UBwVtv3dWhKH3Y1tRCXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8895
X-OriginatorOrg: intel.com

SGkgU2VyZ2V5LA0KDQpUaGFuayB5b3UgZm9yIHRoZSBkZXRhaWxlZCBhbmFseXNpcyBhbmQgZm9y
IHRha2luZyB0aGUgdGltZSB0byB2YWxpZGF0ZSB0aGUgYmVoYXZpb3Igb24gdGhlIGhhcmR3YXJl
Lg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIEJsdWV0b290aDogYnRpbnRlbF9wY2llOiBm
aXggUE0gZmxvdyBmb3IgUzBpeCwgUzMgYW5kIFM0DQo+IA0KPiBSYXZpbmRyYSwNCj4gDQo+IFBh
dWwgTWVuemVsIHBvaW50ZWQgbWUgYXQgdGhpcyBwYXRjaCBmcm9tIHRoZSB0aHJlYWQgb24gVmxh
ZGltaXINCj4gS29uZHJhdHlldidzIHN0YWxlLWNhY2hlIGZpeCwgc2luY2UgYm90aCBjaGFuZ2Ug
YnRpbnRlbF9wY2llX3NldF9keHN0YXRlKCkuDQo+IFRoZXkgb3ZlcmxhcCB0ZXh0dWFsbHkgYW5k
LCBtb3JlIHVzZWZ1bGx5LCB0aGV5IGZpeCBkaWZmZXJlbnQgaGFsdmVzIG9mIHRoZQ0KPiBzYW1l
IGZhaWx1cmUuIEkgaGF2ZSB0aGUgaGFyZHdhcmUgYW5kIGEgZml4dHVyZSBmb3Igb25lIG9mIHRo
b3NlIGhhbHZlcywgc28NCj4gaGVyZSBpcyB3aGF0IEkgY2FuIGFkZC4NCj4gDQo+IFlvdXIgY2hh
bmdlIG1vdmVzIHRoZSBmbGFnIG91dCBvZiB0aGUgcmV0cnkgbG9vcDoNCj4gDQo+ICAgKyAgICBk
YXRhLT5ncDBfcmVjZWl2ZWQgPSBmYWxzZTsNCj4gICArDQo+ICAgICAgICBkbyB7DQo+ICAgLSAg
ICAgICAgZGF0YS0+Z3AwX3JlY2VpdmVkID0gZmFsc2U7DQo+IA0KPiBUaGF0IHJlY292ZXJzIHRo
ZSBjYXNlIHdoZXJlIHRoZSBhbGl2ZSBpbnRlcnJ1cHQgaXMgbWVyZWx5ICpsYXRlKiDigJQgaXQg
YXJyaXZlcw0KPiB3aGlsZSBhIGxhdGVyIHJldHJ5IGlzIHdhaXRpbmcsIGFuZCBwcmV2aW91c2x5
IHRoZSBwZXItaXRlcmF0aW9uIHJlc2V0IHRocmV3IGl0DQo+IGF3YXkuIFRoZSBjb21tZW50IHlv
dSBhZGRlZCBzdGF0ZXMgdGhlIGludmFyaWFudCB3ZWxsLg0KPiANCj4gV2hhdCBpdCBkb2VzIG5v
dCBjb3ZlciBpcyB0aGUgaW50ZXJydXB0IGJlaW5nIG1pc3NlZCBvdXRyaWdodC4gV2hlbiB0aGF0
DQo+IGhhcHBlbnMgZ3AwX3JlY2VpdmVkIG5ldmVyIGJlY29tZXMgdHJ1ZSwgdGhlIGxvb3AgZmFs
bHMgdGhyb3VnaCB0bw0KPiANCj4gICAgICAgaWYgKGR4c3RhdGUgPT0gQlRJTlRFTF9QQ0lFX1NU
QVRFX0QwKSB7DQo+ICAgICAgICAgICBpZiAoYnRpbnRlbF9wY2llX2luX2QwKGRhdGEpKQ0KPiAN
Cj4gYW5kIHRob3NlIGhlbHBlcnMgcmVhZCBkYXRhLT5ib290X3N0YWdlX2NhY2hlLCB3aGljaCBv
bmx5IHRoZSBpbnRlcnJ1cHQNCj4gaGFuZGxlciBldmVyIHdyaXRlcy4gTm8gaW50ZXJydXB0LCBu
byByZWZyZXNoOiB0aGUgZmFsbGJhY2sgaXMgYXNrZWQgdG8gZGVjaWRlDQo+IHVzaW5nIHRoZSB2
YWx1ZSBmcm9tIGJlZm9yZSB0aGUgdHJhbnNpdGlvbiwgc28gaXQgcmVwb3J0cyB0aGUgb2xkIHN0
YXRlLCBldmVyeQ0KPiByZXRyeSBpcyBleGhhdXN0ZWQsIGFuZCAtRUJVU1kgYWJvcnRzIHRoZSBz
dXNwZW5kLiBWbGFkaW1pcidzIHBhdGNoIHJlLXJlYWRzDQo+IEJUSU5URUxfUENJRV9DU1JfQk9P
VF9TVEFHRV9SRUcgaW1tZWRpYXRlbHkgYmVmb3JlIHRoYXQgY2hlY2ssIHdoaWNoDQo+IGlzIHdo
YXQgYnRpbnRlbF9wY2llX3Jlc3VtZSgpIGFscmVhZHkgZG9lcy4NCj4gDQo+IFNvIHRoZSB0d28g
YXJlIGNvbXBsZW1lbnRhcnkgcmF0aGVyIHRoYW4gY29tcGV0aW5nOiB5b3VycyBtYWtlcyBhIGxh
dGUNCj4gaW50ZXJydXB0IGNvdW50LCBoaXMgbWFrZXMgYSBtaXNzaW5nIG9uZSBzdXJ2aXZhYmxl
Lg0KPiANCkkgYW0gaW4gYWxpZ25tZW50IHdpdGggdGhlIHByb3Bvc2VkIGZsb3cgYW5kIGFncmVl
IHdpdGggeW91ciBhc3Nlc3NtZW50DQp0aGF0IHRoZSB0d28gY2hhbmdlcyBhZGRyZXNzIGRpZmZl
cmVudCBhc3BlY3RzIG9mIHRoZSBzYW1lIGlzc3VlLiBNeQ0KY2hhbmdlIGhhbmRsZXMgdGhlIGNh
c2Ugd2hlcmUgdGhlIGFsaXZlIGludGVycnVwdCBpcyBkZWxheWVkIGFuZCBhcnJpdmVzDQpkdXJp
bmcgYSBzdWJzZXF1ZW50IHJldHJ5LCB3aGlsZSBWbGFkaW1pcidzIGZpeCBjb3ZlcnMgdGhlIHNj
ZW5hcmlvDQp3aGVyZSB0aGUgaW50ZXJydXB0IGlzIG1pc3NlZCBlbnRpcmVseSBieSByZWZyZXNo
aW5nIHRoZSBib290IHN0YWdlDQpzdGF0ZSBkaXJlY3RseSBmcm9tIHRoZSBDU1IgcmVnaXN0ZXIg
YmVmb3JlIHRoZSBmYWxsYmFjayBjaGVjay4NCg0KPiBJIGNhbiBiZSBjb25jcmV0ZSBhYm91dCB0
aGUgc2Vjb25kIGhhbGYgYmVjYXVzZSBJIHJlcHJvZHVjZWQgaXQgZGVsaWJlcmF0ZWx5Lg0KPiBT
dXJmYWNlIFBybyAxMSAoSW50ZWwsIEx1bmFyIExha2UpLCBJbnRlbCBCRTIwMSwgODA4NjphODc2
IHJldiAxMC4gVGhlIGRyaXZlcg0KPiB3YXMgYnVpbHQgb3V0IG9mIHRyZWUgd2l0aCBvbmUgZGVi
dWctb25seSBwYXJhbWV0ZXIgdGhhdCByZXR1cm5zIGZyb20NCj4gYnRpbnRlbF9wY2llX21zaXhf
Z3AwX2hhbmRsZXIoKSBiZWZvcmUgdGhlIGJvb3Rfc3RhZ2VfY2FjaGUgcmVmcmVzaCwgYW5kDQo+
IG9ubHkgd2hpbGUgYWxpdmVfaW50cl9jdHh0IGlzDQo+IEJUSU5URUxfUENJRV9EMCDigJQgdGhl
IGV4YWN0IHN0YXRlIGEgZ2VudWluZWx5IG1pc3NlZCBhbGl2ZSBpbnRlcnJ1cHQgbGVhdmVzDQo+
IGJlaGluZCwgd2l0aCB0aGUgY29udHJvbGxlciBzdGlsbCByZWFjaGluZyBEMy4NCj4gDQo+IFVu
ZGVyIHRoYXQgZml4dHVyZSwgbW92aW5nIHRoZSBmbGFnIG91dCBvZiB0aGUgbG9vcCBkb2VzIG5v
dCBoZWxwOiB0aGVyZSBpcyBubw0KPiBsYXRlIGludGVycnVwdCB0byBjYXRjaCwgYW5kIHRoZSBj
YWNoZSBzdGF5cyBzdGFsZS4gVGhyZWUgdGltZW91dHMsIC1FQlVTWSwNCj4gc3VzcGVuZCBhYm9y
dGVkLiBXaXRoIHRoZSByZS1yZWFkLCBvbmUgdGltZW91dCBhbmQgdGhlIHN5c3RlbSBzdXNwZW5k
cy4NCj4gTWV0aG9kIGFuZCBsb2dzIGFyZSBpbiBNZXNzYWdlLUlEIDwyMDI2MDgzMDE1MTU1MC40
NDY4Ny0xLQ0KPiBsc2EudXpAcG0ubWU+Lg0KPiANCj4gVGhlIGZhaWx1cmUgaXMgbm90IHRoZW9y
ZXRpY2FsIGhlcmUuIEJlZm9yZSBhbnkgd29ya2Fyb3VuZCBpdCBhYm9ydGVkIDIgb2YgdGhlDQo+
IDMgc3VzcGVuZHMgSSBhdHRlbXB0ZWQsIGFuZCBvbmUgZGV2aWNlIHJldHVybmluZyAtRUJVU1kg
c3RvcHMgdGhlIHdob2xlDQo+IHN5c3RlbSBmcm9tIHNsZWVwaW5nLg0KPiANCj4gV2hpY2hldmVy
IG9mIHRoZSB0d28gbGFuZHMgZmlyc3QsIHRoZSBvdGhlciB3aWxsIG5lZWQgYSByZWJhc2Ug4oCU
IHRoZSBodW5rcw0KPiB0b3VjaCBhZGphY2VudCBsaW5lcy4gSWYgaXQgaGVscHMsIEkgYW0gaGFw
cHkgdG8gdGVzdCB0aGVtIGFwcGxpZWQgdG9nZXRoZXINCj4gYWdhaW5zdCBteSBmaXh0dXJlIGFu
ZCBvbiBvcmRpbmFyeSBzdXNwZW5kIGN5Y2xlcywgYW5kIHRvIHJlcG9ydCBwZXItcGF0Y2gNCj4g
cmF0aGVyIHRoYW4gYXMgYSBjb21iaW5lZCByZXN1bHQuDQo+IA0KPiBJZiB5b3UgYW5kIFZsYWRp
bWlyIHdvdWxkIHByZWZlciB0aGVzZSBhcyBvbmUgc2VyaWVzIHJhdGhlciB0aGFuIHR3bw0KPiBp
bmRlcGVuZGVudCBwYXRjaGVzLCBJIGFtIGhhcHB5IHRvIGRvIHRoZSBhc3NlbWJseSB3b3JrIOKA
lCByZWJhc2VkLCB3aXRoDQo+IGJvdGggb2YgeW91IGFzIHRoZSBhdXRob3JzIG9mIHlvdXIgcmVz
cGVjdGl2ZSBoYWx2ZXMgYW5kIHRoZSBGaXhlczogdGFncyBrZXB0DQo+IHNlcGFyYXRlLCBzaW5j
ZSB0aGV5IGFyZSBzZXBhcmF0ZSBidWdzIHdpdGggc2VwYXJhdGUgcmV2ZXJ0cy4gSSBkaWQgbm90
IHdhbnQgdG8NCj4gc2VuZCB0aGF0IHVuaW52aXRlZCBvdmVyIHR3byBwYXRjaGVzIHRoYXQgYXJl
IGFscmVhZHkgb24gdGhlIGxpc3Q7IHNheSB0aGUgd29yZA0KPiBhbmQgaXQgaXMgYSBzaG9ydCBq
b2IuDQo+IA0KSSBhbSBmaW5lIHdpdGggdGhhdCBhcHByb2FjaC4gU2luY2UgdGhlIHR3byBwYXRj
aGVzIGFkZHJlc3Mgc2VwYXJhdGUNCmlzc3VlcyB3aGlsZSBjb21wbGVtZW50aW5nIGVhY2ggb3Ro
ZXIsIEkgaGF2ZSBubyBvYmplY3Rpb24gdG8gY29tYmluaW5nDQp0aGVtIGludG8gYSBzaW5nbGUg
c2VyaWVzIHdpdGggdGhlIHJlc3BlY3RpdmUgYXV0aG9yc2hpcCBhbmQgRml4ZXM6IHRhZ3MNCnBy
ZXNlcnZlZCBmb3IgZWFjaCBwYXRjaC4NCg0KSSBhbSBhbHNvIGZpbmUgd2l0aCByZWJhc2luZyBt
eSBwYXRjaCBvbiB0b3Agb2YgVmxhZGltaXIncyBwYXRjaCBpZiB0aGF0DQpyZXN1bHRzIGluIGEg
Y2xlYW5lciBpbnRlZ3JhdGlvbiBwYXRoLg0KDQpUaGFuayB5b3UgZm9yIG9mZmVyaW5nIHRvIGRv
IHRoZSBhc3NlbWJseSBhbmQgcmViYXNlIHdvcmsuDQoNCj4gT25lIHF1ZXN0aW9uIG9uIHlvdXIg
cGF0Y2gsIGZyb20gc29tZW9uZSB3aG8gZG9lcyBub3QgaGF2ZSBTNCBvbiB0aGlzDQo+IG1hY2hp
bmUgdG8gY2hlY2s6IC50aGF3IG5vdyB0YWtlcyB0aGUgbm9ybWFsIEQwIHBhdGgsIHdoaWxlIC5y
ZXN0b3JlIGZvcmNlcw0KPiBGTFIuIEFmdGVyIFBNX0VWRU5UX0ZSRUVaRSB0aGUgY29udHJvbGxl
ciB3YXMgcHV0IGludG8gRDNfQ09MRCBieQ0KPiBidGludGVsX3BjaWVfc3VzcGVuZF9sYXRlKCku
IElzIEQzX0NPTEQgZ3VhcmFudGVlZCB0byBwcmVzZXJ2ZSBmaXJtd2FyZQ0KPiBhY3Jvc3MgYSBm
cmVlemUvdGhhdyBvbiB0aGlzIHBhcnQsIG9yIGRvZXMgdGhhdyBhbHNvIG5lZWQgdGhlIEZMUiBw
YXRoPw0KPiANClJlZ2FyZGluZyB0aGUgZnJlZXplL3RoYXcgZmxvdywgdGhlIGZpcm13YXJlIHN0
YXRlIGlzIHByZXNlcnZlZCBhY3Jvc3MgYQ0KZnJlZXplL3RoYXcgY3ljbGUgZXZlbiB3aGVuIHRo
ZSBkZXZpY2UgaXMgcGxhY2VkIGludG8gRDNfQ09MRCBieQ0KYnRpbnRlbF9wY2llX3N1c3BlbmRf
bGF0ZSgpLiBUaGVyZWZvcmUsIHdoZW4gaGliZXJuYXRpb24gaXMgYWJvcnRlZCBhbmQNCnRoZSBr
ZXJuZWwgZXhlY3V0ZXMgLnRoYXcoKSwgdGhlIGRldmljZSBjYW4gZm9sbG93IHRoZSBub3JtYWwg
RDANCnRyYW5zaXRpb24gcGF0aCBhbmQgZG9lcyBub3QgcmVxdWlyZSB0aGUgRkxSLWJhc2VkIHJl
aW5pdGlhbGl6YXRpb24uDQoNCj4gVGhhbmtzLA0KPiBTZXJnZXkNCg0KUmVnYXJkcywNClJhdmlu
ZHJhDQoNCg==
