Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510CB37B007
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561570; cv=fail; b=CNIADEkUikWAU/pBh1KIW+1WIkfN4vgiY1PMNzKugq/8K3T7q0gd6f9Q6cZa1bEVke0teAJNUP7r6e+BBftZh5hpY/ErXN79JTwkCP4HR0ioiPdlgbaqIg456RudRN2KR8DGbEYrCoK13BILkdjk7IhnPSfDmQWMf/n3RzQRPBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561570; c=relaxed/simple;
	bh=Sk6VAFPQgd1db2eEy/NlKUMQtV6d0BB0EDrtuLIGCco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r9lniFCrwhVJO+9y9qvTo7q2Qi6MMEvNF3gNoW9r/Ob7gh9jGeipHft4baB1eI3v8hj+fC5BR69ju5B42rvsERr+FHFM9pNWtlaHfeJUnCgcAqaBuIWoWoKqwIP+vymbjPzYEtNkplmvZW5W4goXFAiViaUZH1mHaIo4gYf6ALI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLQXK1I8; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLQXK1I8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791561569; x=1823097569;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sk6VAFPQgd1db2eEy/NlKUMQtV6d0BB0EDrtuLIGCco=;
  b=HLQXK1I8cBKoFgFHgk6AoZZi54N//unXREZEfU1eGWQAEGK4+E5gYvRy
   lPpSmpb/zbnjKAjgxItxVRkEE04DTM8e3KUpXcBqKDl2OhoV14wtKXoH6
   oPYreQDPu1obIi9TYMTodqa2OPnC72vAzaHsiz1hGOUySRz9CeqaqQlVU
   GjjSVT+Mtp027JFLB2gH9uLsW4qxWr+IVHAfNZaRPCmSfl8gT4nMTdCjw
   5XUCRlK8VXgzZbgKAZUIdgqobQAUjegdZqXcOTdHf+3mL5fEF/1vYgnT3
   57U1OkVFjOrPKBs3//1HMw205QPONE+k2F64qIjvX6+aCmP4t4Qxc1dkR
   g==;
X-CSE-ConnectionGUID: Zp/mTU1YRkO6MoWwJoEIsA==
X-CSE-MsgGUID: bSPfu033SYuNrT+kRucNgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="366790"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="366790"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 08:59:28 -0700
X-CSE-ConnectionGUID: XVJdgGQzQl6DWD0JD7CxaQ==
X-CSE-MsgGUID: zFjHzNYtQAuo+gZbvhm+5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="797498"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 08:59:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 08:59:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 08:59:27 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.28)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 08:59:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ic9b3ZWfeI2voBQqK7JzOoQ+26xuqYe1Jt4gCMjm9unusbJ0b9xgoDbkGMrmuPOjLT3/BF6ohzmOc9YEU+FS6s9ZsFZ60Qsg1XLAknKtnh2e60IyoM8c5i+Vx1YL8DzLGo6ZS6mikzcR3XFGCakUzQfGnyjsFcnrd7ly/ixmeu0bMY1v0FqXzxIo0d5hbN8jjH19uhkjYQ9hK2FfqcCkVccarsN6IBdCzVbK8EDqO3uZH12TpHkjok1Gol1U0xV2vWd6JUys1ZBfSDp3bddlNm+r2toq9zXNVFxNILqS5ljzyJslRZMuY9EIIsFL2N5XYYuRszPpGOpSYXKw0z11WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sk6VAFPQgd1db2eEy/NlKUMQtV6d0BB0EDrtuLIGCco=;
 b=XCBIOcyKnCSuyuv61kO4n0YFMCqHwdnfLTFDUO1tFVUo3HwWtHnH1avqAK+uvxcHfN2BYV06eRDw98WOmQR7nbsOegEjKo652GFKFYXQkrYns/6P26e8XZMsJf45V6DOuMevCU948TUCnI4yrZ2U+Pbm5KH01ObdpPrDPoofODaQGiaYdEOUwo//fN7q8+0UagQo1iqRJmHzDCmr7czCMumzv5ja9PY7AUhSa9/D6sqZ55NdyQ5+sOFDbAvRfa3m2nSxxJJE122w0lIR8q2Vx1BEPs3hC01M/hFyQKX/tzCKKbVlh08F6dYLNZ9MM8M61e4lDyE3MF6R5WOk/saBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by PH0PR11MB5784.namprd11.prod.outlook.com (2603:10b6:510:129::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 15:59:15 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e%5]) with mapi id 15.21.0472.015; Fri, 9 Oct 2026
 15:59:15 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Kanstantsin Haradzetski <kstgrd@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>
Subject: RE: [BUG] Bluetooth: btintel_pcie: BE201 (8086:a876) dead after
 "Failed to get mac access -62" + hw exception, no recovery
Thread-Topic: [BUG] Bluetooth: btintel_pcie: BE201 (8086:a876) dead after
 "Failed to get mac access -62" + hw exception, no recovery
Thread-Index: AQHdVgj7u+IPcqUiuE+gghm5BpDzA7b1W77A
Date: Fri, 9 Oct 2026 15:59:14 +0000
Message-ID: <PH0PR11MB758529A5777A75637AA2A623F5922@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <CAMuQ30-uAH1aYbU9yCJXw_9LPJ1Gsn97kVhLG6pu07QnYYPpsQ@mail.gmail.com>
In-Reply-To: <CAMuQ30-uAH1aYbU9yCJXw_9LPJ1Gsn97kVhLG6pu07QnYYPpsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|PH0PR11MB5784:EE_
x-ms-office365-filtering-correlation-id: d130294b-21c7-4168-81f3-08df261e4473
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|3023799007|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003|38070700021;
x-microsoft-antispam-message-info: 30aG+hSnEP8FmoMGAmbi/pe1LcZo1k3xbxGhrAIvp8eg85Jt4XwOxOP56QD/lSw//ab3F+Tl94s7XiG3RJbGRag5A5aEl5fglovfrmvNyOWzYMuVLjvvfv1FWMOhK7MgCgdkB2Te+yNck5s2pmVGJ6+HkNRzT0crTMG336ZRqJpRZxYDCePVEvoNn3UWQe4DkLA/EN6sMoETVm9SfECzUnwrpnDoK/EJxvgXeaCDqVcW0Ljnv3K4xfPujZlNseYhZ4pwZ9D/IcJn6EG8+ViLPgEPBELrR2hgQXCXrCgO59P5kyBTSU4NAalpksfySyVZf3xo6tTcE3KAxm9wIZc8UGZjr2d5/N7kPVol0HbKG6A4sTB1XiiSQtJ6MudCzEXn9PHZiKJo363vn9H0b4oy0rcCB6Kx1nfvMZQY/49MTvrwKZKDiMTpina/8pBrTG+iddBSsGYkAtXbAQ9FMWkXqvKfkrsYb8LbuLIKlbUCLPAlI4QSCwrJYL4YSrGOJ/7d82nI6sSOlJ6RuctfFe4Z0U0B1A0Rm/1wKjbXtRgWLVObKxPnnBPYlzx7qa0lAKQUZwKTZmuwYaMGDj0cJl69IcEZahtw9cq29WAdz9oAj2D3eyRssJ4tkVxTJXIiHzSWQBKYD2i5kE8ltUwnhZgfy+J6z8TkVfLaP8+/0ZnfQnXTFBuYqxPxQGJO6qYYDhzOCJU/3txzHlNEIbpBPgcU0VFqe7HD47CHlivwEXEnVgo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFRtZnJDblg2My9yTkdFOElFdFNHa2ltZ3d1a05sUzNCUGVuRldzOUhmSVAy?=
 =?utf-8?B?SDBsOUpQMkVkNHI3NWMxcEpsaFBGQVZNYTVjVUhZNzl1NU8rRnVoWmFVcDJP?=
 =?utf-8?B?aTdVR2R0cjNOQUVhOE9DYTU1cG8xbGh0MnBqNXFGZnRGblVNQTRpS1FMc3pw?=
 =?utf-8?B?K3BrRXB3NWdXcS9scGFZTjhrQ2RBejVSZ0JzbHc1VGpHOVZaeVAyZE4yRWhZ?=
 =?utf-8?B?YXRva0gyMWNZbGtYUFBLZWxURytBWFJaWGowTXhKbUwwdG1XZlg0aUl1eCtJ?=
 =?utf-8?B?ZmpGN0VHTjExYVNRTS9CMG5kaWxaTDBTZDMrVXhPSDBKajlBVE1YdDZPMG9G?=
 =?utf-8?B?YmprTnc4M2I1d3A1VVVpMzhtRGhuRHBHbGJ3bzQyczVMODVvVHhBM054dy9z?=
 =?utf-8?B?SWNVK0VMTzl4N3FZT0ZsRGdlcTBiOGUwWVhiMWsrZjdIeHFSUmJJclluWlhB?=
 =?utf-8?B?MVFBUTFHeXhFVEs2SnB4d0tldFViZUE4cUlNUGlRdmhkN0d5bmk1V3hMV2Qz?=
 =?utf-8?B?TGxEVzN4NjZQai9nUUlzT2o2OWZJbkMwdm1GYWdFVmJXcVUrSmlEWk1YcCtm?=
 =?utf-8?B?M3JuM2dUWW10U1hMeUtnbVBCcW9mNDI0K3RRU3dvMHcrb2FwOHZLR3RRWWM2?=
 =?utf-8?B?V3VkTHd2a2ErclVnLzhYNEtuc2w2bGZmNk53UVlyRFJ5c2lsQ3REQzVJdjBQ?=
 =?utf-8?B?TFg3NTlKd2thV3ZmM0tJenF5ekFlamE5WUpiQ2E1MlBzbmt0RjhSR1d2NlFo?=
 =?utf-8?B?NHB4MWhaTFZ2dFVvb084enk4N1oydGd3cHJsTTlaYXN5ZnBIU3ZRblBQenFw?=
 =?utf-8?B?eXk4b3ZSNUZCUUYwRzJGYW56QW9wMWxJZlV1ZmIrYVYveGY3UVB1SzM0a084?=
 =?utf-8?B?WkhaU0FEYStUemN0dnlQZ01raFpZQWYwVU5CNE1LR01QMStUcUovaFg4MzNK?=
 =?utf-8?B?eVhDT1FsRlpGMiswc1E1amdNU2k1SDEveUVNUmt5NUMxWnlCaXRlWlY5eThx?=
 =?utf-8?B?c2lyb3ZIRXAxZm9TcVovNWNRRXhOWmtEaTJnZ0c2bXM0NEdSRWhFUHMvSXFn?=
 =?utf-8?B?dFRBQlZuTlVVbE80SXhoWGRYeHdRVGhvSDlpTWQwK29pSktPZTkxdy9HU0xz?=
 =?utf-8?B?Yml6cFRsWWRoaFcvNmU1NmR0R0ZXRFhoT0ZTaHlEV0RXR1BMUzM1anlYdUVw?=
 =?utf-8?B?cjRKUTNMN1lXc0lCckxWNnFTWk5yMTlIa2g1NS9pL0V5d0NwR3M0cTdIOHZV?=
 =?utf-8?B?U3R6dThzOUhCWWQ0dnJyR2RRN29MaTFUb2tBOVdjZGNQSnpmd0lHUVRJc3lM?=
 =?utf-8?B?b2FDY1NER3kyeitaOFB3Vld2QW5MSWtSQlZkNGtCaDB1bXI5UjZ6UkNlSEd2?=
 =?utf-8?B?RXhYaEZCa0FwOHJsT1dWbC8wOUhyaUEvOVNEeEEyRXNYZk9FZnhYRWZuaXNu?=
 =?utf-8?B?Y3BUK0twekFYekF4bmVzaUNvb1RoQlR6VFllcVZmVVI1Y3dXUjJqWGxrT3dk?=
 =?utf-8?B?ajY0YUgrWGhOUUxhclhOZFR5TXJ0MGs1WUFkdlAzbnUrejVhaUNuU2M1czZJ?=
 =?utf-8?B?WFZ3VEtuVk1xWmVPMU40eGRVY3d3ZHdiWnhrcnRmbHdGQWVKamxNVlNlMEg2?=
 =?utf-8?B?OEdPTStDTUtsS2N4bVllUmFIeDhUM2tCajhsSVZvMk1FWkdHalRMdFVaL0JD?=
 =?utf-8?B?WHM5RmpQZHV1eG0wVkRiYWRnVm8rbS93eG16NkNRSnZFUjNrWnh1OUV1U3Nr?=
 =?utf-8?B?N1RocWtrQ0lLalF5TkJyQnljN2dLWkZreVNCbXN1Ymc4a2RIRllpVVNIcHcr?=
 =?utf-8?B?WjM0cDhqQ2h6Q3N1QXFSMWJtSkJOUTZyZm9WNTYrUGg0ZHZPRmpxZ1JsenRi?=
 =?utf-8?B?bzIzVmxkcWhTZEhpY0hLcUxKUEl4Uy9ua2YyY3F2QUlrb29GSDNqNCtQcHRO?=
 =?utf-8?B?UlVaWmdyOTBKYktqZm80Y3YzT3VaLzdWTjRZTkphWkxITzRIVzRzK0FPMnBS?=
 =?utf-8?B?bWZ0TGMremMyNzJBdVhLaFJEV0dsTzc5eDNCdHF2ZGpqQm1KODNhdjZ5Rnpu?=
 =?utf-8?B?ZiswdXlkeXBaeS8rMTBUeXA0eXV1dzBoQnE2dGVRT1B0OVIzeTR3NXkxYngy?=
 =?utf-8?B?eDZBaW5uenZsTjVxS0w1bHUvUUV6dWE1M0lLVUxVdENpTVhlQityMUVKWnFx?=
 =?utf-8?B?RzcrT0JNM05zenZ6N3RkZnBYRGJYem9HMmgwcnZmTmxwTmRwTFE4SWJQSlc1?=
 =?utf-8?B?dTlTZERvbzBtZ0x5eFJjWkdlV2RFRWZ5bGtwSWhEMmlDZGFMT1Ntc1NrU0Np?=
 =?utf-8?Q?1+YhnCY+lU5BY2dEdK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zhXn7hKwxv3blu9FG+iaAC8GWIklfwhuHCId4J0KYRV/OT82vQ69axacEzcdd159BSe+KUQVRB2GyiQK25OQMnqqqBZEdigcafotzdMGSaOlLfpUa1wGLpKp8onDLgjiVfXXOdSonLYh0UNag9OiXZ2VhaNPf+PkcnQ5OAtRsdzdvjsYCL75CGtRGEDHuuITHHwKBIMo2SIumSJE+bR5OlTwy5K8EhpjZMxfoKPwO+9Uvl8nrMR2JuULcX/wX8dAf/xs6/yIFZ6KTFJlY/HIKBPbBlYgppLqYXFFzs7vbS87+laxFcPWlkM1WfMJxwsc8SMmEeKn7zOj5+Rw6xTJDw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d130294b-21c7-4168-81f3-08df261e4473
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 15:59:14.8821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdI/fqRQV8Y8wgd1uFSNJGpJyfuyA5PJs8GQay8DtWgBrEmIQznEX/1/lcX655gibHFWM7lM2DOOQCg/5VM4MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5784
X-OriginatorOrg: intel.com

KyBDaGV0aGFuDQoNCkhpIEthbnN0YW50c2luIEhhcmFkemV0c2tpLA0KDQpUaGFua3MgZm9yIHJl
cG9ydGluZyB0aGlzIGlzc3VlLg0KDQo+U3ViamVjdDogW0JVR10gQmx1ZXRvb3RoOiBidGludGVs
X3BjaWU6IEJFMjAxICg4MDg2OmE4NzYpIGRlYWQgYWZ0ZXIgIkZhaWxlZCB0bw0KPmdldCBtYWMg
YWNjZXNzIC02MiIgKyBodyBleGNlcHRpb24sIG5vIHJlY292ZXJ5DQo+DQo+SGksDQo+DQo+T24g
YW4gSW50ZWwgQkUyMDEgKDgwODY6YTg3NikgdGhlIGNvbnRyb2xsZXIgc3RvcHMgYWNjZXB0aW5n
IEhDSSBjb21tYW5kcyBhdA0KPnJ1bnRpbWUuIEEgZmV3IG1pbnV0ZXMgbGF0ZXIgdGhlIGZpcm13
YXJlIHJhaXNlcyBhIGhhcmR3YXJlIGV4Y2VwdGlvbiBhbmQgdGhlDQo+ZHJpdmVyIG5ldmVyIHJl
Y292ZXJzLiBoY2kwIHN0YXlzIHJlZ2lzdGVyZWQsIGJ1dCBldmVyeSBjb21tYW5kIGZhaWxzIHdp
dGggLTE5DQo+dW50aWwgdGhlIFBDSSBkcml2ZXIgaXMgdW5ib3VuZCBhbmQgcmVib3VuZCBieSBo
YW5kLiBSZWJpbmRpbmcgYnJpbmdzIGl0IGJhY2suDQo+DQo+SXQgaGFzIGhhcHBlbmVkIG9uIHR3
byBjb25zZWN1dGl2ZSBkYXlzIHdpdGggdGhlIHNhbWUgc2lnbmF0dXJlOg0KPg0KPiAgLSAyMDI2
LTEwLTA2OiBhYm91dCA2IG1pbnV0ZXMgYWZ0ZXIgYSBjb2xkIGJvb3QsIHdpdGggbm8gc3VzcGVu
ZCBvcg0KPiAgICBoaWJlcm5hdGUgaW4gdGhhdCBib290Lg0KPiAgLSAyMDI2LTEwLTA1OiBhYm91
dCAxMiBtaW51dGVzIGFmdGVyIGFuIHMyaWRsZSByZXN1bWUuDQo+DQo+U28gdGhpcyBkb2VzIG5v
dCBsb29rIGxpa2UgdGhlIHJlc3VtZSBwcm9ibGVtcyBhZGRyZXNzZWQgYnkgdGhlIHJlY2VudA0K
PiJidGludGVsX3BjaWU6IHR3byBQTSBmaXhlcyIgc2VyaWVzLg0KPg0KPlN5c3RlbQ0KPi0tLS0t
LQ0KPiAgTWFjaGluZTogICBMZW5vdm8gVGhpbmtQYWQgWDEgQ2FyYm9uIEdlbiAxMyAoMjFOUzAw
NVJVUyksIEJJT1MNCj5ONEJFVDY5VyAoMS4zOSkNCj4gIFNvQzogICAgICAgSW50ZWwgTHVuYXIg
TGFrZQ0KPiAgQlQ6ICAgICAgICBJbnRlbCBCRTIwMSwgMDA6MTQuNyBbODA4NjphODc2XSByZXYg
MTAsIHN1YnN5cyBbODA4NjowMDBlXQ0KPiAgRmlybXdhcmU6ICBpbnRlbC9pYnQtMDE5MC0wMjkx
LXBjaS5zZmksIEZpcm13YXJlIFZlcnNpb24gMTQxLTI2LjI2LA0KPiAgICAgICAgICAgICB0aW1l
c3RhbXAgMjAyNi4yNiBidWlsZHR5cGUgMSBidWlsZCAxMjUzMjUsIFNIQTEgMHhmYTk4YjAxNQ0K
PiAgICAgICAgICAgICBCb290bG9hZGVyIHRpbWVzdGFtcCAyMDIzLjMzIGJ1aWxkdHlwZSAxIGJ1
aWxkIDQ1OTk1DQo+ICBLZXJuZWw6ICAgIDcuMi45LTEtY2FjaHlvcyAoZGlzdHJvIGtlcm5lbCwg
Q2FjaHlPUyAvIEFyY2gpDQo+ICBsaW51eC1maXJtd2FyZTogMjAyNjA5MTYNCj4gIEJsdWVaOiAg
ICAgNS44Nw0KPg0KPlVzYWdlIGF0IHRoZSB0aW1lOiBBaXJQb2RzIFBybyBzdHJlYW1pbmcgQTJE
UCwgcGx1cyBhbiBMRSBrZXlib2FyZA0KPmNvbm5lY3RlZC4gT24gMTAtMDYgYSBTdGVhbSBnYW1l
IHdhcyBzdGFydGluZyBhdCB0aGUgbW9tZW50IG9mIHRoZQ0KPmV4Y2VwdGlvbi4gSSBkb24ndCBr
bm93IHdoZXRoZXIgdGhhdCBpcyByZWxhdGVkLg0KPg0KPlNlcXVlbmNlICgyMDI2LTEwLTA2LCBt
b25vdG9uaWMgdGltZXN0YW1wcykNCj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+MSkgU3RhZ2UgMSwgdD0zNTVzOiBNQUMgYWNjZXNzIGZhaWxzLCB0aGVuIGV2
ZXJ5IGNvbW1hbmQgdGltZXMgb3V0Lg0KPiAgIFRoZSB0d28gY29tbWFuZHMgYmVsb3cgdGhlbiBy
ZXBlYXQgYWJvdXQgZXZlcnkgMTEgcyBmb3Igcm91Z2hseQ0KPiAgIDEwIG1pbnV0ZXMgKDU4eCBl
YWNoKS4gT3Bjb2RlIDB4MjAwNSBpcyBMRSBTZXQgUmFuZG9tIEFkZHJlc3MgYW5kDQo+ICAgMHgy
MDQxIGlzIExFIFNldCBFeHRlbmRlZCBTY2FuIFBhcmFtZXRlcnMuDQo+DQo+ICBbICAzNTUuNDcw
MDQwXSBCbHVldG9vdGg6IGhjaTA6IEZhaWxlZCB0byBnZXQgbWFjIGFjY2VzcyAtNjINCj4gIFsg
IDM1NS40NzAyNDVdIEJsdWV0b290aDogaGNpMDogZmFpbGVkIHRvIGxvZyBmd3RyaWdnZXIgZXZl
bnQNCj4gIFsgIDM1NS40ODkwMTZdIEJsdWV0b290aDogaGNpMDogRmFpbGVkIHRvIGdldCBtYWMg
YWNjZXNzOiAoLTYyKQ0KPiAgWyAgMzU2LjQzNjE0Ml0gQmx1ZXRvb3RoOiBoY2kwOiBUaW1lb3V0
ICg1MDAgbXMpIG9uIHR4IGNvbXBsZXRpb24NCj4gIFsgIDM1Ni40MzYzMzZdIEJsdWV0b290aDog
aGNpMDogRmFpbGVkIHRvIHNlbmQgZnJhbWUgKC02MikNCj4gIFsgIDM1Ni40MzYzNjldIEJsdWV0
b290aDogaGNpMDogc2VuZGluZyBmcmFtZSBmYWlsZWQgKC02MikNCj4gIFsgIDM1Ni40MzYzOTFd
IEJsdWV0b290aDogaGNpMDogT3Bjb2RlIDB4MjAwNSBmYWlsZWQ6IC02Mg0KPiAgWyAgMzU2Ljk0
MDEzMF0gQmx1ZXRvb3RoOiBoY2kwOiBUaW1lb3V0ICg1MDAgbXMpIG9uIHR4IGNvbXBsZXRpb24N
Cj4gIFsgIDM1Ni45NDAyNTBdIEJsdWV0b290aDogaGNpMDogRmFpbGVkIHRvIHNlbmQgZnJhbWUg
KC02MikNCj4gIFsgIDM1Ni45NDAyOThdIEJsdWV0b290aDogaGNpMDogc2VuZGluZyBmcmFtZSBm
YWlsZWQgKC02MikNCj4gIFsgIDM1Ni45NDAzMTldIEJsdWV0b290aDogaGNpMDogT3Bjb2RlIDB4
MjA0MSBmYWlsZWQ6IC02Mg0KPg0KPiAgIEF0IHR+OTY3cyB0aGUgQTJEUCBzdHJlYW0gZmFpbHMu
IGJsdWV0b290aGQgbG9ncyAiYXZkdHAuYzoNCj4gICBjYW5jZWxfcmVxdWVzdCgpIFN0YXJ0OiBD
b25uZWN0aW9uIHRpbWVkIG91dCAoMTEwKSIuDQo+DQo+MikgU3RhZ2UgMiwgdD05OThzOiBoYXJk
d2FyZSBleGNlcHRpb24sIGNvbnRyb2xsZXIgaW4gZXJyb3Igc3RhdGUuDQo+DQo+ICBbICA5OTgu
MTczMDk0XSBCbHVldG9vdGg6IGhjaTA6IFJlY2VpdmVkIGh3IGV4Y2VwdGlvbiBpbnRlcnJ1cHQN
Cj4gIFsgIDk5OC4xNzMyNjZdIEJsdWV0b290aDogaGNpMDogUmVjZWl2ZWQgZ3AxIG1haWxib3gg
aW50ZXJydXB0DQo+ICBbICA5OTguMTczMjg0XSBCbHVldG9vdGg6IGhjaTA6IENvbnRyb2xsZXIg
ZGV2aWNlIHdhcm5pbmcNCj4oYm9vdF9zdGFnZTogMHhlMGZiMTA0NykNCj4gIFsgIDk5OC4xNzYx
MjJdIEJsdWV0b290aDogaGNpMDogUmVjZWl2ZWQgZ3AxIG1haWxib3ggaW50ZXJydXB0DQo+ICBb
ICA5OTguMTc2MTU5XSBCbHVldG9vdGg6IGhjaTA6IENvbnRyb2xsZXIgZGV2aWNlIHdhcm5pbmcN
Cj4oYm9vdF9zdGFnZTogMHhkMGZiNzA0NykNCj4gIFsgIDk5OC4xNzYxNzNdIEJsdWV0b290aDog
aGNpMDogQ29udHJvbGxlciBkZXZpY2Ugd2FybmluZw0KPihib290X3N0YWdlOiAweGQwZmI3MDQ3
KQ0KPiAgWyAgOTk4LjE3NjE4M10gQmx1ZXRvb3RoOiBoY2kwOiBDb250cm9sbGVyIGluIGVycm9y
IHN0YXRlDQo+KGJvb3Rfc3RhZ2U6IDB4ZDBmYjcwNDcpDQo+ICBbICA5OTguMTc2MTkxXSBCbHVl
dG9vdGg6IGhjaTA6IENvbnRyb2xsZXIgZGV2aWNlIHdhcm5pbmcNCj4oYm9vdF9zdGFnZTogMHhk
MGZiNzA0NykNCj4gIFsgIDk5OC4xNzYyMDFdIEJsdWV0b290aDogaGNpMDogSW52YWxpZCBleGNl
cHRpb24gZHVtcCBzaWduYXR1cmU6IDB4YjQxMDU0ZjkNCj4NCj4zKSBTdGFnZSAzOiBubyBGTFIg
b3IgcmVjb3ZlcnkgaXMgYXR0ZW1wdGVkLiBFdmVyeXRoaW5nIGFmdGVyIHRoaXMNCj4gICBmYWls
cyB3aXRoIC1FTk9ERVYuDQo+DQo+ICBbIDEwMTkuMjAyMDE5XSBCbHVldG9vdGg6IGhjaTA6IHNl
bmRpbmcgZnJhbWUgZmFpbGVkICgtMTkpDQo+ICBbIDEwMTkuMjAyMDg3XSBCbHVldG9vdGg6IGhj
aTA6IE9wY29kZSAweDIwMzkgZmFpbGVkOiAtMTkNCj4gIFsgMTA2My4yMzgyNTddIEJsdWV0b290
aDogaGNpMDogT3Bjb2RlIDB4MjAwNSBmYWlsZWQ6IC0xOQ0KPiAgLi4uDQo+DQo+ICAgRnJvbSB1
c2Vyc3BhY2U6ICJibHVldG9vdGhjdGwgcG93ZXIgb2ZmIiBmYWlscyB3aXRoDQo+ICAgb3JnLmJs
dWV6LkVycm9yLkZhaWxlZCwgYW5kIGNvbm5lY3QgcmV0dXJucyAiSW5Qcm9ncmVzcw0KPiAgIGJy
LWNvbm5lY3Rpb24tYnVzeSIuDQo+DQo+NCkgUmVjb3ZlcnkuIFVuYmluZCBhbmQgcmViaW5kIHJl
Y292ZXIgZnVsbHk6IGZpcm13YXJlIHJlbG9hZHMgYW5kDQo+ICAgZGV2aWNlcyByZWNvbm5lY3Qu
DQo+DQo+ICBlY2hvIDAwMDA6MDA6MTQuNyA+IC9zeXMvYnVzL3BjaS9kcml2ZXJzL2J0aW50ZWxf
cGNpZS91bmJpbmQNCj4gIGVjaG8gMDAwMDowMDoxNC43ID4gL3N5cy9idXMvcGNpL2RyaXZlcnMv
YnRpbnRlbF9wY2llL2JpbmQNCj4NCj5UaGUgMjAyNi0xMC0wNSBvY2N1cnJlbmNlIGlzIHRoZSBz
YW1lOiBzMmlkbGUgZXhpdCBhdCAxODI4cywgdGhlIGZpcnN0ICJGYWlsZWQgdG8NCj5nZXQgbWFj
IGFjY2VzcyAtNjIiIGF0IDI1MzZzLCB0aGVuICJSZWNlaXZlZCBodyBleGNlcHRpb24gaW50ZXJy
dXB0IiBhdCAyODQ2cw0KPndpdGggdGhlIHNhbWUgYm9vdF9zdGFnZSB2YWx1ZXMgKDB4ZTBmYjEw
NDcgLT4NCj4weGQwZmI3MDQ3KSBhbmQgIkludmFsaWQgZXhjZXB0aW9uIGR1bXAgc2lnbmF0dXJl
OiAweGI2MzM1NGY5IiwgdGhlbg0KPi0xOSBmb3JldmVyLg0KPg0KPkF0dGFjaGVkIGFyZSB0aGUg
ZnVsbCBCbHVldG9vdGgtcmVsYXRlZCBrZXJuZWwgbG9ncyBmb3IgYm90aCBib290czoNCj4gIGRt
ZXNnLTIwMjYtMTAtMDYudHh0DQo+ICBkbWVzZy0yMDI2LTEwLTA1LnR4dA0KPg0KPlF1ZXN0aW9u
cw0KPi0tLS0tLS0tLQ0KPi0gQWZ0ZXIgIkNvbnRyb2xsZXIgaW4gZXJyb3Igc3RhdGUiIHRoZSBk
cml2ZXIgZG9lcyBub3Qgc2VlbSB0bw0KPiAgc2NoZWR1bGUgYSByZXNldC9GTFIsIGFuZCBoY2kw
IGlzIGxlZnQgaW4gYSBzdGF0ZSB3aGVyZSBldmVyeSBzZW5kDQo+ICByZXR1cm5zIC1FTk9ERVYu
IElzIHJlY292ZXJ5IGV4cGVjdGVkIHRvIGhhcHBlbiBoZXJlPyBJcyB0aGlzDQo+ICByZWxhdGVk
IHRvIHRoZSBwZW5kaW5nICJidGludGVsX3BjaWU6IHNlcmlhbGl6ZSAuLi4gcmVzZXQiIHdvcms/
DQo+LSBJcyB0aGUgaW5pdGlhbCAiRmFpbGVkIHRvIGdldCBtYWMgYWNjZXNzIC02MiIgYXQgcnVu
dGltZSBhIGtub3duDQo+ICBmaXJtd2FyZSBpc3N1ZSBvbiBCRTIwMSB3aXRoIGJ1aWxkIDEyNTMy
NSwgYW5kIGlzIGEgbmV3ZXIgZmlybXdhcmUNCj4gIGF2YWlsYWJsZT8NCj4tICJJbnZhbGlkIGV4
Y2VwdGlvbiBkdW1wIHNpZ25hdHVyZSIgbWVhbnMgbm8gZXhjZXB0aW9uIGRhdGEgd2FzDQo+ICBj
YXB0dXJlZC4gSXMgdGhlcmUgYW55dGhpbmcgSSBzaG91bGQgY29sbGVjdCBvbiB0aGUgbmV4dCBv
Y2N1cnJlbmNlDQo+ICBiZWZvcmUgcmViaW5kaW5nLCBzdWNoIGFzIHdyaXRpbmcgdG8gdGhlIGRl
dmNvcmVkdW1wICJjb3JlZHVtcCINCj4gIGF0dHJpYnV0ZSBvciBhIGJ0bW9uIHRyYWNlPw0KDQpS
ZWdhcmRpbmcgdGhlICJJbnZhbGlkIGV4Y2VwdGlvbiBkdW1wIHNpZ25hdHVyZSIgbWVzc2FnZSwg
dGhlcmUgaGF2ZQ0KYmVlbiBhIGNvdXBsZSBvZiByZWNlbnQgY2hhbmdlcyBpbiBibHVldG9vdGgt
bmV4dDoNCg0KICA0Mjc4NjRmZDhlYmEgKCJCbHVldG9vdGg6IGJ0aW50ZWxfcGNpZTogUm91dGUg
ZGVidWcgdHJhY2VzIHRvIFdpRmkNCiAgREJHQyBieSBkZWZhdWx0IikNCg0KICA4NDdkMjUzNjY5
YjkgKCJCbHVldG9vdGg6IGJ0aW50ZWxfcGNpZTogc3luYyBtYm94IHRsdiBwYXJzaW5nIHdpdGgN
CiAgR1AwIGFsaXZlIGludGVycnVwdCIpDQoNClRoZSBmaXJzdCBjaGFuZ2Ugcm91dGVzIGRlYnVn
IHRyYWNlcyB0aHJvdWdoIHRoZSBXaUZpIERCR0MgcGF0aCwgd2hpY2gNCmlzIGtub3duIHRvIGJl
IG1vcmUgc3RhYmxlIHRoYW4gdGhlIEJsdWV0b290aCBkZWJ1ZyBwYXRoLg0KDQpUaGUgIkludmFs
aWQgZXhjZXB0aW9uIGR1bXAgc2lnbmF0dXJlIiBpbmRpY2F0ZXMgdGhhdCBhIHZhbGlkIGV4Y2Vw
dGlvbg0KZHVtcCB3YXMgbm90IGNhcHR1cmVkLiBDb3VsZCB5b3UgcGxlYXNlIHRyeSByZXByb2R1
Y2luZyB0aGUgaXNzdWUgb24gdGhlDQpsYXRlc3QgYmx1ZXRvb3RoLW5leHQga2VybmVsIGNvbnRh
aW5pbmcgdGhlIGFib3ZlIGNvbW1pdHM/IA0KPg0KPkknbSBoYXBweSB0byB0ZXN0IHBhdGNoZXMs
IG9yIHRvIHRyeSByZXByb2R1Y2luZyBvbiBibHVldG9vdGgtbmV4dCBpZiB0aGF0IGhlbHBzLg0K
Pkl0IGhhcHBlbnMgYWJvdXQgb25jZSBhIGRheSBoZXJlLg0KPg0KPlRoYW5rcywNCj5rc3RncmQN
Cg0KVGhhbmtzLA0KS2lyYW4NCg0K
