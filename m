Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D436409295;
	Mon, 28 Sep 2026 06:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575287; cv=fail; b=W5hRVDqlJouiSJPO04c7DCSN2Xv8oWn/Ln/scLzuQP5/8P3WAu4syP+22wufvTBlOe6771I3ji6YFWjYDZrDAQkZyP7R0yOHl5oCmWo4H2uTjSv+CIOPB2WRSVGbstycAjcVuGNWN7mM5+iVchP2pwwuTTks2t5e7wnPQL0P4Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575287; c=relaxed/simple;
	bh=EU/lyOxN/9sBfE3vJxiYxmnaTxkqu3UwbaALIoBhwLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MbzT8hIktaC+1rsHwFz8Ryj1XB5T6E82gA9FR6KgN16QX46VkKp3uW8DeSCLr6HqtdBF2aWVmZSC6Doe4VkNI/DNRGToWDKhiPFH8dU5xHLlBAaH6uYWHf5DAJmfXH0zZRLyaQ6u/lY1NF6zdv+YQUCXfB2cp/yzN3T2FNYQCm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ei1kOreO; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ei1kOreO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790575285; x=1822111285;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EU/lyOxN/9sBfE3vJxiYxmnaTxkqu3UwbaALIoBhwLk=;
  b=ei1kOreOuysLkr7AVNXVny33pJ8O6HsPFyYh6iT2uVxuKk9VIfpPJMXn
   pUQubCxO6004YaupNXSEyfralnnBeBF1AFq1J6OIh9QjQh9fJneINN+Hu
   9XxtrbnlgAwcUx2vEZZ59WCCE37q++4lP8EmLD91RB7Mh4VnbJ9+MjtPa
   7q5X0taIJGf2WzEBzuOaY/f1JrZdUTeqK978tjHUkfT/1swBKZ3l29lVd
   fMYcl2Ydf2TUGUsJTt6hEYiH463g2VK/58i09q44cWz3s4VKG4SagwnKl
   xY1WtOAmtGhBFdSWDyZHDXxq1R/r3PzGTClsYYKvORryIGCAp9ULjMVF6
   A==;
X-CSE-ConnectionGUID: oBzxbhOyRLWH7srY86F3JQ==
X-CSE-MsgGUID: t5aBVQKPTVaIHgSQaeLg6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="93978961"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="93978961"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 23:01:25 -0700
X-CSE-ConnectionGUID: ZlcWY3zdQaC5BAOpabKDjg==
X-CSE-MsgGUID: 0mc7GZPrRe2cS9FNJfagoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="312873027"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 23:01:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 27 Sep 2026 23:01:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 27 Sep 2026 23:01:24 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 27 Sep 2026 23:01:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvmCI+he4yU3Y4FpmF+2QD1qTMmnB1TlyplDHJ44JtvEes3UQG3UyLWVqsi+z4Il1/uBzILMcC8ML8N45KhzWxEG3lBBtFIz/puxxS3avXbFDvMZZWxq7wf1H8sfhPJjJpXF/IXegPWb/PdKXoc7RpOl1GxfHfvrVsnDNJhMgTXAFuD38Id9UeJJAi+npf06I4lvZDLbDwB8ppug95p3jmAEFkQsRmoy8vh9Y/XNwYrbKT5tIVSUwqLpGa0tR+tMSDELXMQQE4QJbTGAMj8hNZ/vjelqv0gSRzFC7fVIr2YdTP/bOJEKu9bnGKy+NtTMs9flb8rmQTacacYERVE++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EuJfE4hiZKeJ66zYvrry9aNdEKcaAP9+MCqscx0iDo=;
 b=aHFrahyNtqVPzRRZ9aSVR8hK3wakL8eCeuiH9NE2OdUxBsuFnkb3ZGh4SD8f1obvFhNhq/kuc6gzXZOoT+RmAWtQBAn8AcWu6DlJhIXeCYvB3DuCMvzApHN7rc4aRKYdrJoBLiz9iSUSYA0KPM6F09Ip3E0X8tQblrpwznXTXGo50NAsBOLj1BCZkgSiCBf+5jAZ/sVfuqxPlHuiehtmL3VSM51nhwK9+ObVXHZAtOZ8yD5yw3GRjmYmMlmyvz0NhiEjB1KJDoozSxl9hCcFz5Qn5RMXU1yb4N8Fx9krHL1xWBamXjMEpSI4KWApPCc5dymInW3QPqXsIfTFKgcCvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DS4PR11MB872716.namprd11.prod.outlook.com (2603:10b6:8:509::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 06:01:20 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::b803:4643:8d14:f071]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::b803:4643:8d14:f071%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 06:01:20 +0000
From: Ravindra <ravindra@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "K, Kiran" <kiran.k@intel.com>, "Tumkur
 Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH] Bluetooth: btintel_pcie: fix TX descriptor bounds check
Thread-Topic: [PATCH] Bluetooth: btintel_pcie: fix TX descriptor bounds check
Thread-Index: AQHdTwxnCZIPpFS4502XUC8Tg8LXyrbjfyfw
Date: Mon, 28 Sep 2026 06:01:20 +0000
Message-ID: <IA1PR11MB786993100872EA581B83564DDA8D2@IA1PR11MB7869.namprd11.prod.outlook.com>
References: <20260928054646.2897679-1-ravindra@intel.com>
In-Reply-To: <20260928054646.2897679-1-ravindra@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7869:EE_|DS4PR11MB872716:EE_
x-ms-office365-filtering-correlation-id: ef0d54ba-e421-44a1-e347-08df1d25eae3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|18002099003|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: 86NN5SIbsz68qVj0nWb3VJdMlxWXPQ6xp7TzoHaSmyyex4AZBLs+wU3HLLsqwLzTCa8/HKiGVdB+K4GaFvIjGSOSRus9e5WzKeUaGY8ESHqq+O+u1tef3s1QIy3MTYIU5xbuA5ZSgz0uejDvOB4rDRyv5I8pD+k/FXjaHXq/jntOgWDBAm8qaoYP8qLStp9WVbQpkB9ozjPS8FGdMbdzKIZRh6CcfbisOPFQOcYZxrdozjTV2TeWnXGVKupbgxmqCksLvrzM3gCA8WbFqOVcY0zl3ETPMwNF4OPhUaQZBsXT7ltRa3umbEDDh0A0sZ3SZLyDZQGnGOgG7u5OZ8sq84DUkjxwCFw+Rur5Bqq0ntrPGocXz+YT+L5ZW6VkOefTsfOR32TH/vTSI5EMvgHk7aOJ4TUUZPIOfDMIDe7ofqeKrba3Q+Hjy58RY2FyOftteTgL6rcfAjtFnNba+zdZ2UDAVU7Mh6REzgLPOe7X9Y9evTxaW7lRb8VSOF0fEEtPmHaq/Dz/QfrLPGxVe3xUXEhW5gbvvsztikZkTWs2PevB8EuNFNwGoImi63pccFodXeRzwYukdi84yJt0oW7SHCBBZ9QyWha2BsPB1h5R0mbkz56OY0UzX8RyxA5HR424pF9NwOeRoLKeC1cCYUWs6tTt8GB16F8XT4BTgVrzoOV/60vcs7zVqtlMkj+jAPtwr70QpXpTfR7Jj31Q7G+opmuQLQGQbgEUAUwgaeKVJpk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Svn7qHXW6hioY2i29pZ5zqedWKMmhgCR2V3xbZ9lLEEuVspQprlSOj/pms7y?=
 =?us-ascii?Q?KY3tpWA6YcdgLuCEObnhCUxIr9l/Fm28OAk7Yeouhnr+VSlJ8tzspIKOh8Qw?=
 =?us-ascii?Q?j+XFhHlDHlax2CrJgEOThHyeOERLjCV2yw8PpWx/jkKN4k+0CzpWM+KmwIL3?=
 =?us-ascii?Q?ygpiYAJhY5v6moKs4DlRNr0xAjE28moL/Nf5DJUBPfIM2+YCVN5JTPF2vPfi?=
 =?us-ascii?Q?NMMBr03h/GXtYyIgoNGtlZpnCVIO0UFmTXtsEf61rfC+awWyYB8hOLrTKUms?=
 =?us-ascii?Q?uFBrln+4lX2cDtboKfgpdiFRGqL9rhkKs/Ukgf9sU1wMzgPjAUopLn7ERa40?=
 =?us-ascii?Q?TTstzPPNgigzICbIgTi7PSPdjrbkRz8Mn+GNXosdGs3PTvvNzOmkBeLrskgI?=
 =?us-ascii?Q?1aoLzcxTkGw+StoWI/AhNqq/ySYVp1OlWkMYS8KPlY0CZJxjUr4zlKhmc4i1?=
 =?us-ascii?Q?MTUUZ2JwkiQLxhTH1bz0NSJDApXuFiGyiUczwNpvKJvJ/EVS6SGuMfePbOGV?=
 =?us-ascii?Q?967uOZB6hYc/Z7WKLCX4vV6J5VijJooeSKElFbjDUv7dzh+N6yQRJjIattgp?=
 =?us-ascii?Q?IbKJBH9v/cJq0rNzYA8yUher3en4ZSUjQfK4ZoaaGFu6zK7JScs/GWqWf+ut?=
 =?us-ascii?Q?urs3Kq+Trvxw5V0djFif3lu2JThwpZUf3Nk3IXKYLfpneNdbc+rem0FnjH/Z?=
 =?us-ascii?Q?pAX1lgVbgTHHM4R1M4VM3O77alJIm0rwFlWhE1vSzQpA7AFiXRcQD5OI6PXU?=
 =?us-ascii?Q?1yIByeDWe6wYf3FOrr6CkzSwOZwcEfC7knuFl/HtMq0o2cX0AC1rv36Y9nZy?=
 =?us-ascii?Q?Z16XEy/1agMzI9U1d5SI2F2wXF+EvnJeQv/NmQyNMQxq5ma5GKpCaQT8903C?=
 =?us-ascii?Q?zgxcVZpqKwJ06/V1wQTk/oZtTh0USrXcnl3dg2p9MCnD6Yu1azdMZx/DhDJT?=
 =?us-ascii?Q?q7lGRMWgcSRink70pD3WdC+hF36nzVjr5nWuQkF0iWqccd/IEzvKktkNoZVN?=
 =?us-ascii?Q?gZCQVhmmaThAB8LWCBxzTg/4jwHcsUs8QLHcSVNubuFixSTnCBV+VnW65ZRU?=
 =?us-ascii?Q?dfHw9xuBMl+eAq1dEpHHkBXNahStAiKCSeWPwcoPtvcMA3tx2yGvGlSud8NB?=
 =?us-ascii?Q?tSwEj1Cs0Fk7fUMMw5w6Br41oaFnQwkJxB/zscM4QzHKiB7h6t1B4WfgVC84?=
 =?us-ascii?Q?stzHT57FCam5pTYp2VK/WpNvSLsB9uTfd8PcUf6ylaLu6m2/H3wO3YdpWYlf?=
 =?us-ascii?Q?5/IFMDegoe73jDVlPeGZ83vvRseMLhrKxlDKV4Rt2qwtXgJ70rHxIOJ8ju+e?=
 =?us-ascii?Q?i5qzM//Iw1qkgio7AwruBWhIlkgz9LLQYuqC4YIt72w+xJ4wNsViUhhg8XZF?=
 =?us-ascii?Q?yBzFe5jGpepWqbHvgv+l7XOYhVRsqxAx7isrGpr5puOjMHiCJiozwmQf5E9Q?=
 =?us-ascii?Q?C28mS2TQ0Qa5YKvbG1fHZp+dNMFMEPesYkiqp5voOm5DzzyaN8QA8dKfXv0U?=
 =?us-ascii?Q?iRzN/Inww5n9IfA0pxOpj0GdRWuByWu8gShADJOXnhFc9BvFJffipHkH3FdT?=
 =?us-ascii?Q?X4WG94ziBckqvAQXe5+XalkQgewo72r1dXsC9h2VRj8QPou0pIislQ4AgQLl?=
 =?us-ascii?Q?FQdUQk6zJ1YPsK2KPimBjiae2fr/o9rEU8z3W0DvSZzr473dsvbIXWrEsdnx?=
 =?us-ascii?Q?SWInC3wL9vBeuXp/q5Z7mp3p+c5HsiDEtswtzx9EY7avdHLk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 24NK4fx+SDKJghc4MHVrc5zvXsZdbDfZRA4kOkcBUgMD4Eo4OcIwaWcBLpZAMT2PR0PVuZ0ywlnxYPkiu/i/5FGn3DOYAmAZw/YtCHAfbrXWt7rkJeUPfEWYi8wLOeBVrckOPXMnbhDOQo8a/tco4aaqDPBOgdkHff9ABRN7Rn+Dl43AXH2mIQX+2WwHumOvGPeOol+Wd6m55jlU9SoIx3ekXOqK5zwjveV1OPHtTFlntFnfOYHYvddIpJJjNerHcraTesWoS6EArv4VHuvJVQK/UjczByaQNSSns/NJ6hErHuUKEA3AX6pemrg2QwDwXUObxR4yZfwH8/dUS4x85g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0d54ba-e421-44a1-e347-08df1d25eae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 06:01:20.0870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GwcS2DqnE3Gp8m4FYfVy+V5E6FTi4oVOn3ZZQ6m0hPSUQMx8FYjpfi646A74UdJIodI4Fu1gRW/BioslKao1ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB872716
X-OriginatorOrg: intel.com

Cc: chethan.tumkur.narayan@intel.com, kiran.k@intel.com

Adding Kiran and Chethan to the thread for visibility. The patch was sent
earlier; no resend is needed.

> Subject: [PATCH] Bluetooth: btintel_pcie: fix TX descriptor bounds check
>=20
> btintel_pcie_prepare_tx() uses tfd_index to access the TFD and data buffe=
r
> arrays before the index is advanced modulo txq->count. An index equal to
> txq->count is one past the end of both arrays, so reject it in the bounds=
 check.
>=20
> Signed-off-by: Ravindra <ravindra@intel.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 59cf600014bb..aaf409a9afb1 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -536,7 +536,7 @@ static int btintel_pcie_send_sync(struct
> btintel_pcie_data *data,
>=20
>  	tfd_index =3D data->ia.tr_hia[BTINTEL_PCIE_TXQ_NUM];
>=20
> -	if (tfd_index > txq->count)
> +	if (tfd_index >=3D txq->count)
>  		return -ERANGE;
>=20
>  	if (skb->len > BTINTEL_PCIE_BUFFER_SIZE -
> BTINTEL_PCIE_HCI_TYPE_LEN) {
> --
> 2.43.0

