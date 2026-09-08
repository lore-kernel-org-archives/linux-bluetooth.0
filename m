Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C153CA96;
	Tue,  8 Sep 2026 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876783; cv=fail; b=WwVa6XLTXrPjZBH+3shfpy8cVpeEVG1/fElLgvg8HovX3kGhAsh/Y3e4u2UeUKE2Zmz0cTYMrud3yaQtxiM9L7dDj+TJCWigbzt1AjPbHTlD2BIjUqNznygCWvoqmpAWoRDy51RmQb8BwKU293pyI1+cyaHqKBDfa0RKOJDnUvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876783; c=relaxed/simple;
	bh=1uzyffcN20gO2Ka8sEh7yJ6k4UcMeWvfi77g8XFaD9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Du6L6cX0sShfcOc0wgFJtM9h+PO/1+hd1NzurzlJ0mwcXqqpsnOuz1EzviU9nLwCbLAw9Om+8K+z0gUnbgHhiQ2PrXDbdEu+TPEc5x7Y9gAcmdiLqVlgy2Y5TNOqQCON3rz64ZOW2XB/7YmXPSaNkbcK0sSQ3igjTN/ypQYLhQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AYFcdO48; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AYFcdO48"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788876774; x=1820412774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1uzyffcN20gO2Ka8sEh7yJ6k4UcMeWvfi77g8XFaD9Y=;
  b=AYFcdO48ICDqvALkI7nsnJRZ2f+2oByypkcxh4sfhX603CfQ5cpsg0x3
   xQxnuGVHzDxRRXNipAsKGZ9KyIerCjSZcYnYN9spK4uiii0jmHOAD8qtq
   Tb9KVkYWgNcIgOGzNLKRl5tETKFuh8wsKc3Ho+WNP7Ry53BM1fUQHt5EQ
   kuaR0PlvRHxXixxbBMqJjwIy0TjoSiaefg8doCvunlKLBtLS/Vvyb5qyT
   WidD/BxIsmJNUrVizhKZQrU4noRaOonNogCPyQr9KGIHahMrYCbpslUsT
   V8lOZ10MJvOFQn3fxFOPaOu5/d1RVd1nM/wSYey7mNkrZTjDpEtjC7qEP
   g==;
X-CSE-ConnectionGUID: FtHuHxYITAedaMFp57St9A==
X-CSE-MsgGUID: Hm2P0uFoRqax7ZYKmXXYqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="114819166"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="114819166"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 07:12:48 -0700
X-CSE-ConnectionGUID: eafy/Fp+T5aAjFcOPKr3eA==
X-CSE-MsgGUID: P2rlGcEBRGGK/Mh0toVPmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="300895720"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 07:12:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 07:12:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 07:12:48 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 07:12:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjkYYQVbGYl26x1dOmF/Gbp8JRmO2/RFtqLGEbUSr4hN+aizngtfdJjkt2CLeaBheajGgcCHvL++3gNZN//dLiiPskkF/el4hgoaKx0PEXd9C3Hb1tXfUktiVQ648PuuxrtDGDF2BIJdG5CsDykL+/tyA91vyl2lRAOH6OQBuyHYKS7txtp+95iOVBLTm0moQXMxuTerra/L0Wcsw+wH23RLPUfWKeF7IA8jSZEjGs+Krfl0fmUje3KBJ94wWQNxlv5vRbIXqTUe+39YulquNrZHDgwhEHQO8gbLOCRaVWpxfN4fLtLwlpwzMI59Zmsm9wWr2jB71JWhNaX/aK9ewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uzyffcN20gO2Ka8sEh7yJ6k4UcMeWvfi77g8XFaD9Y=;
 b=k/pEWrmXcrhVTKxulVu5Gsow4p31lK/Cdpw11FaMmx2K6nW5Nz6cSLEQNXan4zKumFkGa4gCsAI6VZ5bacuOljkjE7i9OeeeSoJSZk6mZWmWO7ANzTZCOmrBm+3cTDJu9HGAbIKmX0JGjDYckHddotPjGRJDvz1FKStEYx3zwsa2ZKbXwfHMlvA6NArEzR6CanTdzYSNJP/gHBNB8iGnph0uBqk1nO2Rx9rMOXxTGRgep9+drKhliw+dKtwIegB0deEI87oWU8pIEFMRJ5IdaJy1ikxjw0zafO0G0DZWOZ5b7jdb9akCW+mDOgJvHDmi7ToOcbWsfr8it+ZGx93UXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by SABPR11MB9964.namprd11.prod.outlook.com (2603:10b6:806:50c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 14:12:46 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e%5]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 14:12:46 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Sergey Lebedev <lsa.uz@pm.me>, "Vladimir V . Kondratyev"
	<vladimirkondratyev2@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, Paul Menzel <pmenzel@molgen.mpg.de>, "Devegowda,
 Chandrashekar" <chandrashekar.devegowda@intel.com>, Arnd Bergmann
	<arnd@arndb.de>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Chambarakatta, Mahalingeshwara"
	<mahalingeshwara.chambarakatta@intel.com>, Ravindra <ravindra@intel.com>
Subject: RE: [PATCH v4] Bluetooth: btintel_pcie: fix stale cache in
 set_dxstate fallback check
Thread-Topic: [PATCH v4] Bluetooth: btintel_pcie: fix stale cache in
 set_dxstate fallback check
Thread-Index: AQHdO9myqLo6hTx4wUixuKiu0Ims/7a9RCsAgAd6D0A=
Date: Tue, 8 Sep 2026 14:12:46 +0000
Message-ID: <PH0PR11MB75859CA0BF3BFECE89D32FA9F5B12@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20260507203426.128975-1-vladimirkondratyev2@gmail.com>
 <20260903192245.135310-2-vladimirkondratyev2@gmail.com>
 <20260903195342.78248-1-lsa.uz@pm.me>
In-Reply-To: <20260903195342.78248-1-lsa.uz@pm.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|SABPR11MB9964:EE_
x-ms-office365-filtering-correlation-id: 07c6c464-d78b-4428-43e1-08df0db341a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|38070700021|56012099006|4143699003|5023799004|11063799006|10067099003;
x-microsoft-antispam-message-info: puFVPVJ6/9Eecb3IKr6+8d95P++waeALNQbRjVGP5xhvAczjx8i3k8Lm3/a52pr9E3kNC8VwYRDbuwyfGPXhUU1lledxDKF2d5mjrhUw7XxI8cYasYzhCs5TXdchW7WIf8u//ArPhnSPecMHzKGx1fhj9B3KPl7oeDQpymBB2y/CSAJRtiRgsw3z0IdDJ3Oljojc/suyumRyeHEVmHzwagXVRSJhquPtMVyfSC7vSoLHfGa80XP2qkzlh6qkFNxDCY+SpjsthgFJ00kEDo8DkY7feAkP9dXiyiRbrt76nQs6jiC+QannrWz+ROTVNY+V2o7L11lqvuSzUwz2pBxqGOPhFM9hN1yfG9K1GN9eDcLtaA3EczqrePOCU/TdNPa5PZpTu0q5z3AQUe+szCrFxjFzemkB2c5Ad5RUkmJVyMFH7V32TU3VBf7dlPIQUkRoTsye14BwBawuWijhvCYsibCvxMygLEUwYh6odr2wg6WV5DuqyNABpYy2DU74BV42S+mxcw6Hi+6ImkLALmarO8HFfJ7ESX2PHwOWUSUYuCRpO6n6gUBb/mXuQPvP3zVpXM+EZZN+dKKycm2IvM+V44rb/FJ4AoNAgBsj9qaMETZDvBBlX/k7/GCutP5e9d+MSfa/WkZ+CjYauguTySjopEsbRcgk0nA0XemkOgmk1Lv+jtZZ5gOxh001yEdL0klruXriAsnbr7IcGwTQk6NAgZU72hYNnwhKdz/haFfjW6k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEtTeHB4RGxsRDlHWHVJSmVFZzk4TzlIUm1PQzVOWG12US9WcE96cHlpVGZo?=
 =?utf-8?B?dnBMRTFXVHViQ2xDVDdXTG1HNlRYZ1ozUmhldTQrRENvaUFSMmNjY2xaM0I0?=
 =?utf-8?B?cVpLVnpGdTBaUW1kenRRUElqTFRlTXZjM1BNWmR6UmVnbExzRmo2M3lFNnlS?=
 =?utf-8?B?T2FSL29wd3pSOVJ4L00rUUllRTdtUGIzK2pUMTJaS2xiSVYraWduakQrRU9s?=
 =?utf-8?B?Vmo4M2JwOHEwRld1OTZJZ0VQVmJKanVXZTgzQVJoUXBqQmpXQkl6TXl1TWdX?=
 =?utf-8?B?U2JHcjZiT2kvYTA5bU1EWmlXYW1JQlRvYXRqbThQUnFkWTZveFRwbHdoeEZG?=
 =?utf-8?B?V2NlR2lnUVB5SWZoQzYrdVpFeHZzWGJUYXI5Ylh6YWNmODBYWFYwVW9YZmRL?=
 =?utf-8?B?MkQvTnkyTVdydUZqVjhVcW02THhNWDM5TE5RWjJCOGs0SCt4cHM3V1IzV2Zx?=
 =?utf-8?B?L3BZeEZtaHR1RkM1ekptTFkwdmsrbkdobmRsbjZ3azNXWnBUSSs3Q0JhVXY0?=
 =?utf-8?B?YVpjNTA1ZmJxUWtOaFFGdE1GR3FJUTA3UnFZRmJGRXQ3VGFYdDdzbFZTcmgx?=
 =?utf-8?B?TlV6S0YzNGYrVFBXd3E5bUVEUVpzOHJ5cFVvZXRwL203Znh4a0Jqc2RtNVpa?=
 =?utf-8?B?MWtoV2RpMEFhTTJpd2RyNDNydjZ5bDF1MHBWbnFRQTNkQjF4OVM3ZkF0bUVH?=
 =?utf-8?B?ODRKeGxiRmhydk9YQXNIWnRQMUE5dm1zSU5UYXNYQzk0SlRxa29kRFZoanc1?=
 =?utf-8?B?dHJ3V0RZcnd0ZW11eGtaWGIxYzFrK3ZSaXk4OTVZUmJqSkd5cFpQV29VcG55?=
 =?utf-8?B?VXkrb1VrVThwUi91QXovbGZGTUVYR0w0cnFiNmNmbXU4bjZlVzhlOEsvWUxi?=
 =?utf-8?B?M0ZUYWU1dTNZZWhTYVVnQnFtU0tLRU4vaW8zbUdmcGppa3BjWmRyRUE4Ykg4?=
 =?utf-8?B?a2p6bVg5cVFKZGF2VUNWRTdrUEVrMWRiYWh4YkNGYjhST3h4L1Q5eFdlbERY?=
 =?utf-8?B?YWs1T0xGalJlbFUvQWw5Q0pSbGdJT2lEZWl5ZnJpWGxzVTRTTFgwdWRodm9r?=
 =?utf-8?B?eHhXbWFyWFdTR2VtVWEvR1FPVkVvcEFFTklMMnlKVlc5ZHU3NE1ML1RrUmxy?=
 =?utf-8?B?aDJ3eitaSmVZVkh0VnFKUis1S25jQzFVci9hMjY3d1R2QTk1bWVFUVlWcjVV?=
 =?utf-8?B?QWRmRnFBZWJnamF6SEd1ZWR2WTU0RFVvZEUwelc0NVFhSm1CaFU5aWRKVURR?=
 =?utf-8?B?L3hxVXJDMGs0MUxRTkJEQ1lKOHkyWm4vaHRicTZ2Mk4yZ09LZ1lHanE5MkpS?=
 =?utf-8?B?aGRBRUwwOWR2ZVRlOHVHanhvZ2tFUUw4TDFHU2kzR2I0TTlrZDF2VVNEcVFy?=
 =?utf-8?B?bzZCOUdPWktrQitDN3VNM0grYUh2OWxEVW1CWnBXNjFrOHZ1RVNFa0FLTXc2?=
 =?utf-8?B?THZLaDBySWtyckJwMDNxQkRXbVhwMHE5SlRGUy9kRGtjaHdFblg2T1Jka2FL?=
 =?utf-8?B?dWp6Z25EM2tLelc4ZXUyWVN6bzJ5c2RsWWpId3JCbTZOTCt5RkpYUVVmeW5B?=
 =?utf-8?B?SDFXN1BKMStZUVhjeGxUM0Q4NjV1emdWNVNlM1N0MGo1MUozbjdXV1A5dm1B?=
 =?utf-8?B?MzUxMmJ5Q1VyUmNETWpyY2RMbkVqcTZES1RrazUwdFlGR0VObE9FQkQyNzg5?=
 =?utf-8?B?WlhOQ1BnWHBTdTdabFBNZWZCckh6V0pkbnprSW5lY0c0SWhMOEtwUHprYVl3?=
 =?utf-8?B?WG50UTdpU2hxdnk5ZFlldXlrQzU0QithQlFTUGJ3UWF3QnJKU1h0dlNKOW96?=
 =?utf-8?B?SUIvMFYyYTE0bHVWa1JsbmtnYVU3SkYyQzVTRnh4ZlYzRkNMd2RYcjU2RnVM?=
 =?utf-8?B?K1lBT1BUWFNoN2NPdGJvMDRNZ1RuVzlQRmZ4cFY2Y0h6RDM5WXY4V3hZRnNw?=
 =?utf-8?B?WC9VRm13cTQyY3JOamkzRW1iRW9ycjFtcmdJYXU5MlV4QzlYZVV4TERFQXY2?=
 =?utf-8?B?SDlLbVRPTUlVU0VMWGVqZDJCK3hRbnpQRXRhMW4zaWVOVlpUUUxPQWRqa1Ez?=
 =?utf-8?B?SEk1QUcyY21DWUUwWlNWUy9HNEJTM3hMQkl6aTYrbmR1SkJEUmhpbGI4OUo1?=
 =?utf-8?B?QlpMOGhRdzkzUkRrSnQ0cHQyeHU4MENlcHB1cVdIMU5wN3VtQ1d5cTRnOS9F?=
 =?utf-8?B?MFVHcUdlTnlhZ3I3bWVmZnZQNlZBWU5VRWl6L2RTczVXZk9YMk9GKzRKckpm?=
 =?utf-8?B?YXd3RzlLcERRWlZiNmZSMXN2eU5KL0xSNTVydE9xUGMwdEl0MlFKTk1yU0Zo?=
 =?utf-8?Q?732GzgevcIylRXupbp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: G5lyGZPvpPCfa6XUGcwmBJ3ydEMQ2X9ubDzHd0A16Z27ab89x5g0OQeLubhaWzrDBHUVnRvJvbt71FPGXh0nV2l/hkb7tCAbRi6peNOrNfq2sGvS7VeYiPvIrCONVQW/v5lpzCq/t3yfd/PwTTdbu7GUXT+KaI7+mvUXKIYgYU+x+TfcOGg8C33NrIsCnL7Cjc8JMlFTvE9cuAwlmhrWJnYAUlpLViUV0ZaI+Ji6IXPB0HboEvvnAjnaG9w1Eqb2/atnI/aetagFdT9H3j0ZisfncrvQlYQekhEFU7vV8MfxR4sV0RfuXdo9vPWnMs2Ojbg3SOFjLgk4nSldm1uJBA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c6c464-d78b-4428-43e1-08df0db341a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 14:12:46.0964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G1npb+8f+r2+nhF6wHy4Nbqd/eUwc9TiZYdf/qnjWxQitpOwYjsGz3UuzkSTa5Ojt4gqsTll3E+gFvJLN16XSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9964
X-OriginatorOrg: intel.com

K01haGFsaW5nZXNod2FyYSwgUmF2aW5kcmENCg0KSGkgU2VyZ2V5LA0KDQpUaGFua3MgYSBsb3Qg
Zm9yIHlvdXIgdGhvcm91Z2ggdGVzdGluZywgZGV0YWlsZWQgYW5hbHlzaXMsIGFuZCBpbnNpZ2h0
ZnVsDQptZWFzdXJlbWVudCBkYXRhLiBZb3VyIFRlc3RlZC1ieSBmb3IgdjQgaXMgbXVjaCBhcHBy
ZWNpYXRlZC4NCg0KR29vZCBjYXRjaCBvbiBQT0xMX0lOVEVSVkFMX1VTIGluIGJ0aW50ZWxfcGNp
ZS5oLiBDdXJyZW50bHksIHdhaXRpbmcgZm9yIHRoZQ0KYWxpdmUgaW50ZXJydXB0IGlzIHRoZSBm
bG93IGRlZmluZWQgZm9yIGFsbCBJbnRlbCBCbHVldG9vdGggUENJZSBwcm9kdWN0cywgYXMNCmlu
dGVycnVwdC1kcml2ZW4gbm90aWZpY2F0aW9ucyBhcmUgZGVzaWduZWQgdG8gYXZvaWQgYWN0aXZl
IHBvbGxpbmcgb24gdGhlDQpQQ0llIGJ1cyBkdXJpbmcgc3RhdGUgdHJhbnNpdGlvbnMuDQoNCldl
IHdpbGwgZGlzY3VzcyB5b3VyIG9ic2VydmF0aW9ucyBhbmQgZGF0YSBpbnRlcm5hbGx5IHdpdGgg
b3VyIFN5c3RlbXMgdGVhbSB0bw0KZXZhbHVhdGUgaWYgYW55IGFkanVzdG1lbnRzIGNhbiBiZSBh
cHByb3ZlZCBmb3IgZnV0dXJlIGVuaGFuY2VtZW50cy4NCg0KVGhhbmtzIGFnYWluLA0KS2lyYW4N
Cg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjRdIEJsdWV0b290aDogYnRpbnRlbF9wY2llOiBmaXgg
c3RhbGUgY2FjaGUgaW4gc2V0X2R4c3RhdGUNCj5mYWxsYmFjayBjaGVjaw0KPg0KPlZsYWRpbWly
LCBQYXVsLCBDaGFuZHJhc2hla2FyLCBLaXJhbiwNCj4NCj5Ob3RoaW5nIGhlcmUgYXNrcyBmb3Ig
YSBjaGFuZ2UgdG8gdjQg4oCUIGl0IGlzIHJpZ2h0IGFuZCBteSBUZXN0ZWQtYnkgc3RhbmRzLiBU
aGlzDQo+aXMgdGhlIG1lYXN1cmVtZW50IGJlaGluZCBhIHF1ZXN0aW9uIEkgcHV0IHRvIHRoZSBs
aXN0IG9uIDIwMjYtMDktMDIgYW5kDQo+Y291bGQgbm90IHN1cHBvcnQgd2l0aCBudW1iZXJzIGF0
IHRoZSB0aW1lLg0KPg0KPlRoZSBxdWVzdGlvbiB3YXMgd2hldGhlciBCVElOVEVMX1BDSUVfQ1NS
X0JPT1RfU1RBR0VfUkVHIHNob3VsZCBiZQ0KPnBvbGxlZCBmb3IgdGhlIHRhcmdldCBELXN0YXRl
LCB3aXRoIHRoZSBhbGl2ZSBpbnRlcnJ1cHQgZGVtb3RlZCB0byBhbiBlYXJseSBleGl0LA0KPnJh
dGhlciB0aGFuIHRoZSBvdGhlciB3YXkgcm91bmQuIFNvIEkgdGltZWQgYm90aCBhZ2FpbnN0IHRo
ZSBzYW1lIHplcm8g4oCUIHRoZQ0KPndyaXRlIGluDQo+YnRpbnRlbF9wY2llX3dyX3NsZWVwX2Nu
dHJsKCkg4oCUIG9uIFN1cmZhY2UgUHJvIDExIChMdW5hciBMYWtlKSwgSW50ZWwgQkUyMDEsDQo+
ODA4NjphODc2IHJldiAxMCwga2VybmVsIDcuMC4wLTMwLCBzMmlkbGUuIEEgbWVhc3VyZW1lbnQg
YnVpbGQgcG9sbHMgdGhlDQo+cmVnaXN0ZXIgZXZlcnkgMTAwIHVzIGFuZCByZWNvcmRzIHdoZW4g
Yml0IDI0IHJlYWNoZXMgdGhlIHRhcmdldCBhbmQgd2hlbg0KPmdwMF9yZWNlaXZlZCBiZWNvbWVz
IHRydWUuIEZvdXIgc3VzcGVuZC9yZXN1bWUgY3ljbGVzLCBlaWdodCB0cmFuc2l0aW9uczoNCj4N
Cj4gIGR4c3RhdGUgIHJlZ2lzdGVyICh1cykgICAgICAgICAgICAgIGludGVycnVwdCAodXMpDQo+
ICBEMyAgICAgICAxNTE3ICAxMDI3ICAxMDg1ICAxMTExICAgICAxNjcwICAxMTcxICAxMDg1ICAx
MTEyDQo+ICBEMCAgICAgICAxNjMwICAxNTIxICAxNjc2ICAxNzAxICAgICAxNjMwICAxNjQ2ICAx
Njc2ICAxNzAxDQo+DQo+VGhlIHJlZ2lzdGVyIHJlYWNoZXMgdGhlIHRhcmdldCBzdGF0ZSBpbiAq
KjEuMCB0byAxLjcgbXMqKiBhbmQgaXMgKipuZXZlciBsYXRlcg0KPnRoYW4gdGhlIGludGVycnVw
dCoqLiBJbiBmb3VyIG9mIHRoZSBlaWdodCBpdCBpcyB0aGUgc2FtZSAxMDAgdXMgc2FtcGxlOyBp
biB0d28gaXQNCj5sZWFkcyBieSAxMjUgYW5kIDE1MyB1cy4gQWdhaW5zdCB0aGF0LCB0aGUgY3Vy
cmVudCBwYXRoIGJ1ZGdldHMgMjAwIG1zIHBlcg0KPmF0dGVtcHQgYW5kIHRocmVlIGF0dGVtcHRz
IOKAlCB1cCB0byA2MDAgbXMgcGVyIHRyYW5zaXRpb24sIHR3aWNlIHBlciBzdXNwZW5kDQo+Y3lj
bGUuDQo+DQo+VGhhdCBpcyB0aGUgd2hvbGUgb2YgbXkgY2FzZSwgYW5kIGl0cyBsaW1pdHMgYXJl
IHdvcnRoIHN0YXRpbmcgcGxhaW5seS4gT25lDQo+bWFjaGluZSwgb25lIGNvbnRyb2xsZXIsIG9u
ZSBmaXJtd2FyZS4gVGhlIHBvbGwgaXRzZWxmIGlzIFBDSWUgdHJhZmZpYyBhbmQgY291bGQNCj5i
ZSBwZXJ0dXJiaW5nIHdoYXQgaXQgbWVhc3VyZXMsIHRob3VnaCBpdCB3b3VsZCBoYXZlIHRvIGJl
IHBlcnR1cmJpbmcgaXQgaW4gdGhlDQo+ZGlyZWN0aW9uIHRoYXQgZmxhdHRlcnMgdGhlIHJlZ2lz
dGVyLiBBbmQgYSBzZXR0bGUgdGltZSBpcyBub3QgYSBndWFyYW50ZWU6IGFuDQo+aW50ZXJydXB0
IGV4aXN0cyBwYXJ0bHkgc28gdGhlIGRyaXZlciBuZWVkIG5vdCBhc3N1bWUgYSBib3VuZC4NCj4N
Cj5CdXQgaWYgdGhlIGJvdW5kIGhvbGRzIG9uIEludGVsJ3Mgb3duIGhhcmR3YXJlLCBwb2xsaW5n
IHdvdWxkIGRlbGV0ZSB0aGUgc3RhbGUtDQo+Y2FjaGUgY2xhc3Mgb2YgYnVnIHJhdGhlciB0aGFu
IGNhdGNoIGl0LCBhbmQgUE9MTF9JTlRFUlZBTF9VUyBpcyBhbHJlYWR5DQo+ZGVjbGFyZWQgaW4g
YnRpbnRlbF9wY2llLmggYW5kIHVudXNlZC4NCj4NCj5JIGhhdmUgbm90IHdyaXR0ZW4gdGhhdCBw
YXRjaCwgYmVjYXVzZSBpdCBpcyB5b3VyIHN1YnN5c3RlbSBhbmQgbXkgY292ZXJhZ2UgaXMNCj5v
bmUgbWFjaGluZS4gV2hhdCBJIGRvIGhhdmUgaXMgdGhlIGhhcmR3YXJlLCBhIGZpeHR1cmUgdGhh
dCBkcm9wcyB0aGUgYWxpdmUNCj5pbnRlcnJ1cHQgb24gZGVtYW5kLCBhbmQgdGhlIHBlci1odW5r
IG1ldGhvZCBhbHJlYWR5IHVzZWQgaW4gdGhpcyB0aHJlYWQuIFNvDQo+aWYgYW4gUkZDIHdvdWxk
IGJlIHVzZWZ1bCByYXRoZXIgdGhhbiBub2lzZSwgSSB3aWxsIHdyaXRlIG9uZSBhbmQgcmVwb3J0
IGl0IHRoZQ0KPnNhbWUgd2F5IOKAlCBtZWFzdXJlZCBwZXIgaHVuaywgd2l0aCB0aGUgZmFpbHVy
ZSBpbmplY3RlZCBhbmQgd2l0aCBpdCBkaXNhYmxlZC4NCj5JZiB5b3Ugd291bGQgcmF0aGVyIGl0
IGNhbWUgZnJvbSBzb21lb25lIHdpdGggdGhlIGZ1bGwgcmFuZ2Ugb2YgY29udHJvbGxlcnMsDQo+
dGhhdCBpcyBhIHBlcmZlY3RseSBnb29kIGFuc3dlciBhbmQgSSB3aWxsIGxlYXZlIGl0IGhlcmUu
DQo+DQo+U2VyZ2V5DQoNCg==
