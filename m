Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BB115B0EC;
	Fri, 28 Feb 2025 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756784; cv=fail; b=sk8494zbaAjqR3YtW2PE/53eREXaQJegTs+TVaHEIfmqYhaIi3EgZRv94IbfwMyfXq0TcJTs36BK3YkJq76tfBQ4XYvdNia3bUWVFK8L38fCSXUNCUkVJe52yET5I2lMF+/ryreD4Be7q7K/FnYGBBQ+UCYZakf7um+fzkhfgBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756784; c=relaxed/simple;
	bh=/yLOQ6dAJXbRoLTP08BZQpo0FIcDU/fmyWkIyDrjV0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BaFxExP2zkBwA9ncszmhm6GCKkUTl3suDqlDzjnkZ2wYppm50vlxzxjHoHEGbYPOq+XbNiGxREYMypPhMlEeG2KoSSeXo6haPQPIqsDKVD6T1AdcxNg2QlwRDZyxFucBAFke+FFf8OH/pXMvP2VXHN4vxTIhUKDkMGjoHNSCxzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IeO38jLs; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IeO38jLs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qhf0SJnLQ+c2MPOhDQzkIictZSkk9HQUSqteo1ijTKkleCWIxSW7f4pc+DuncuqAbs1EIfbU8yjoshnebiZE/Jk0b/fg7LVYARx5Bs7uGfUQ/VrLNgw03MY/Gdk5DJeExCwZz+vAv4/S2oKr75s0GvyC2kbIVTV4id8tLdQk5SognlznmBy9v3zFlnpRmX7QIia48XAnlli5sUNtlI5J92fGGMjHFqYWQDXaJVoJWKLJJ2nw3/x/EPuqd+n42cmhni60PRg1m6aMz8mWow8CndcJ89kV7zOLDaEVKxtDNR2eamVUPl4Ylvw26UKuGLMrgWaa+wLfz2odDVFTjI4Eeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yLOQ6dAJXbRoLTP08BZQpo0FIcDU/fmyWkIyDrjV0U=;
 b=wPTJjB+M0n9WZU9VL0cR3+s+E3VrhJzs0/7MAanit4HWaBgQTaNj6004HLaXh8BJ4xJqY5xX6uYFJmgH4BIe1QmCpU0WCuvGf/fjbRxqPnPGHILH1sUNNq5F/FODt/caXJFAC0um8aYOcoW04sgS7Cu/PWfFBHv7OAhtEqtyAwy8G/ke+esxeyYQOJpAp71byX8bcU1DmYFSJ0An3IrRKnYvOGUtypKGMsFyBYY9nOE0zAu/XhjqiOJ4Zrire+aPjAUU7virv/9WYPk0rRrbbRyCTtjqbMrooSpIpZ4dT++2MnE5CnxX+CMRvilX9LKEqiSQGLbevPOMhuQWEBPTaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yLOQ6dAJXbRoLTP08BZQpo0FIcDU/fmyWkIyDrjV0U=;
 b=IeO38jLsMKCcOTyG7IvFJAxNLSLfCuVqTr+DZmFVOIol19lOxnmw6CBYlb54gkTY3HV7gJ8KqSygHxd6lDGlJ1PDi2rTcC3IARGwELkdB1qvJdqbqaojq5oMRh40Gj/AnmbVFCQuiyPUtF2C+xS9nooya8YDKPooplot7S9JrNvaAm9YRoc49erbFOJtw9nFOO2Z9+mfcv5uGsXSDvLb0ynYU4eU3FxZeqwwCFF15bzI4xc+sOmTkZ37vAN0XUxYPOs55Y2MfoRgq8SbOKX1FB9+dmvLgn5wo2Yic82v7Fvj9AfAYoubCSekFEF4zQAGxbvmWmMuNPL3vkUfUSuFjQ==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM7PR04MB6887.eurprd04.prod.outlook.com (2603:10a6:20b:10a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 15:32:58 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:32:58 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>,
	"johan.korsnes@remarkable.no" <johan.korsnes@remarkable.no>,
	"kristian.krohn@remarkable.no" <kristian.krohn@remarkable.no>, Manjeet Gupta
	<manjeet.gupta@nxp.com>
Subject: Re: [PATCH v5 2/2] Bluetooth: btnxpuart: Add support for set BD
 address
Thread-Topic: [PATCH v5 2/2] Bluetooth: btnxpuart: Add support for set BD
 address
Thread-Index: AQHbifYLxNMj1mDFHE+4MdpHuyuLRQ==
Date: Fri, 28 Feb 2025 15:32:58 +0000
Message-ID:
 <AS4PR04MB969222D9EB2FD7FD54007EA0E7CC2@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250220114157.232997-1-neeraj.sanjaykale@nxp.com>
 <20250220114157.232997-2-neeraj.sanjaykale@nxp.com>
 <9b67d408-3557-46d5-81ad-e3d6636a5e0d@molgen.mpg.de>
In-Reply-To: <9b67d408-3557-46d5-81ad-e3d6636a5e0d@molgen.mpg.de>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AM7PR04MB6887:EE_
x-ms-office365-filtering-correlation-id: 2302734b-1c19-4ac2-49d5-08dd580d2df0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RW1WRndqK0JiSmxVWWxrR1ZhZmM0OEhiVUlDZGtKOFNjM2Jwb0hwR0NXZXkr?=
 =?utf-8?B?L2p3dFRFRFVwRTBKVFVsbUhoSEthT3IrQ29hQnFDdFFTTExOVk9LY0V6QjNS?=
 =?utf-8?B?MWpMYnBIcGUyOFB4UFBCT003dURPWmVwVm1EaXQyeUFpd0pRUHZaRDMvdERk?=
 =?utf-8?B?amdQVG5GNi9OTkdWdkREWmhYSllXbER0NTlCd1g3TlZKd2pGNjJzSjFCMkpm?=
 =?utf-8?B?TnNYaVFWY2VQVDB3TEdoYytMcnBobTA1bHVNK0pSZ0U4dGU4REdHVTh4MFl5?=
 =?utf-8?B?RXlYeG95YVVZeFA4N0VYWmxzd1ZTd0tBZGxBOVljZ3J3RVV6clVWTFk4U1h1?=
 =?utf-8?B?THRUY3A1Q1ZkeHorR3cweXB2UXpnWFp3YkQrVkFWbkdpWWdPM2xjVnI2SGw5?=
 =?utf-8?B?NFh1RHllak1lZHJnTXRtcXB4TGtIcEV1cngrQzZibjBQMEE2MkR1Njg1cmtj?=
 =?utf-8?B?K2lhZmRJcDdxN29zaXB5THllQkRHRm1TMHVCMWZWTG9Hc2hGclpnem0rUG8r?=
 =?utf-8?B?WEdKcDgzNTExYUp3UDg0QUFiOStWZXQya3NsVnFqMlhjZFR6VkNOdXI2alNu?=
 =?utf-8?B?UlpXMHFTMTZ3UmY3MUp2OTliVlIwM1NFSW1aMGZXcVFPSDhCQ0U4MHhjRURv?=
 =?utf-8?B?N1g3Q3VDYmEvS1laTW9YMlVhLzBPak8rTm9vNGRBV0VQblFURzhaREpnM1FT?=
 =?utf-8?B?WEpLcmlVY1FKR3EvYzRqYXIwczdkRkJINzhjTWtDRkhwbEhsUDlMSjhWdlNz?=
 =?utf-8?B?QTh0M0k1cS9IVDNzaC9QWTJCRDZ4U21BNVRMWDNlSmpQVDZZcEJNRWIrVWJL?=
 =?utf-8?B?blF2MU1yU29jRkdRck1hbnlDYTZEU2w3ZXorMDc1M25kd1BZMEMzVjZXR3da?=
 =?utf-8?B?dHdpcG5ESkthYUxpYUFkTzBESklFTkJlNmxqNHhtT1cxTGZlNFp2UnlJNUsz?=
 =?utf-8?B?ZFJqNkx0ZkwrSjJ0K0x6dGRsWS9kTWVMR0xhc2h6L3dUL1BsbEVJQTQvYmJ0?=
 =?utf-8?B?Wk5KZmdicm5BRG9tRE4rbXYvWk1vN3N4c1Zib1djbHllWHFtaVEwbnUvVkNu?=
 =?utf-8?B?SkhVdVRTSkZwRUphd0pkZTRNck5YNnVjNk4xT0h3dDFvbHR5Q2sxSzF3R1VJ?=
 =?utf-8?B?SkFZWi9JWE5CUjNYd09ISmJpM2JyamZtVzlsZ2RwcWdLSnMwZ1V2R1NwNnoz?=
 =?utf-8?B?NzVwMlRkQ3pZYXFFcDI2TVFsbHFOTzU1Q0t0SUVteWRNbGZLazRrVzhueVc0?=
 =?utf-8?B?cWs1NVRQSWp4Z21nM1FxbHFpUFUrelFzUjRWL1cyNjdIQS9jaUVhNXlIS3NI?=
 =?utf-8?B?Q0dOV2VHZkF2ZS9JaVNORFREVkpENzVGV2EwUGRETC9abnp2RnZYWm9zTS9p?=
 =?utf-8?B?cjlxUEJ0MWZSUkFjc1kydGNiS0x3ejJiRElWOC9sZnlPa0hZVS8zSHVRQk5B?=
 =?utf-8?B?aTF3eVRDOFloVUJCNDFqRHFJRHB5M1ZRdk5rL3A4bzNOSjFEOHM2VDJKMWta?=
 =?utf-8?B?NVJPc0NRc2ZRNG1uMkJPNThoNHFrVkg2WTVZVmUwOFlvUDQ1elZ1cnJXQUVS?=
 =?utf-8?B?NzhUR3hyYXNBdkw0Tk8vS21YOHhqMEJZSGJFbStFNFJhc2MvUGttRmdvUmtT?=
 =?utf-8?B?QTl4WEVkaDBQTFlTN1VxVTNHbHpHZUNSN2F1SE5wOUtFM0oxNkNKSnlsZGlJ?=
 =?utf-8?B?Q2dSNGx5ZldMRkFCVUphZXVGYzNTRStEb3lDcmdqY05zOXEzRnhNcGJNMTdJ?=
 =?utf-8?B?QVZQWlRpZ0hBL3FyLzZ6TGUxMzhBRkNJOElob3dMYXZSTU1SRUNwQUZnT2hE?=
 =?utf-8?B?a20wSUcxTUdSaVZSZzZhcWRhWnhXVDdDeHN3NXl0K3FwSk9ZL3lrTU5CUzNt?=
 =?utf-8?B?SHZPanpnaXQ0MWRmQ1NaOEFNOXlxN3JxMm1ibGl1RDVyMnF5Mk91QXRtL0lK?=
 =?utf-8?Q?Pd9Hhb4elT0ZomAFeviWORk4WAiWLsNl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUdrVmxIejBiNjZOa3BUZlJSMUlrcFRuMzVnbmNUbTBDaDdrMkpPYVpBUEVG?=
 =?utf-8?B?L0wzOTM3THQzanhJNS9UU1FQSGFmeUQ5Y0JQdW9ScUxCNVNMMll0a0lhMlJi?=
 =?utf-8?B?VkZXcTNSWDI4WHRLcWsvWFFDd04wd3FPWC9HSFF2WGJRb05BcGo1UWZjaHlh?=
 =?utf-8?B?SjdMTGlFc3o4WVZhUUppVy9JdXovVmJiZ1NKbTRSOVZadHVVVEw0dTJGMGdF?=
 =?utf-8?B?azhDalcxdUVhT0Y1dFdtZU10ci9jNmdwSytjYUNGMWkxb2Rka2djL0ZMdXFo?=
 =?utf-8?B?QUVrR3BSa01uTWFkbElCak0zMVZKRE5MSVR1QmRYem5ONEtFODRZYnU1em5B?=
 =?utf-8?B?RVl2aStGSm03Z3M2Q3BHdjBZc01qZWUvcEtoMzhQRTJDTXIxT01DR21vV2R3?=
 =?utf-8?B?SUpXK0dwc09nVGZrcGNuai9vTWJ4VENkVVN5RW1uYkFicWdCeUN1Ny92Ykxs?=
 =?utf-8?B?Zm9nRGtueDBtRFBOK084cXRvQnFyN1VlVFV6NDYzYTlCbXRNZmpVZHR6MTYx?=
 =?utf-8?B?TUFxT25DZWpUaG5wb0dLblJmcGdsZGpXLzZ4RDQwOFRXdldoWmhNNmV6NWRB?=
 =?utf-8?B?R3JiMEZxQlV5Y2hmS3Q3eTg5Q3ZsSFEvTFh6cXhVbzROZ1V3TnFBS2Y4b3pP?=
 =?utf-8?B?bG5URjNtM1pmU1hNQTZqU1NUeElCdEpza2VMeWNORS9qOFFlbzJIb1dUTGpz?=
 =?utf-8?B?YnFNYjJWYWw2R3k3RHNOdTV4Y0tmZHg3N0RzVk80eXU2QnhJbUF5TGNZWGND?=
 =?utf-8?B?RGdkUEgvKzJHNUk3UFB6Ri91VTU1UnN5RjROSHFya2N5MTNETXVCT2tzSEo0?=
 =?utf-8?B?MDJ6SmN1K1prUU5WRlQ3RlFncGpNejdYODRCeXZpUTNraFZQa1lmSkNVTTNB?=
 =?utf-8?B?SVFIYUk4Q1FzNEZqTUtoRE1jREdBNlI3T2tYNjlvSW43T3F4TmJGWFQ1Rk5n?=
 =?utf-8?B?TWp6eHlHTUpzYlBRTDFHYm9CdFRES1BqbE9sc3hVaHhrM09QYUlHT3NuRm53?=
 =?utf-8?B?Qk9YNUxkOC84aHZuVzFSMFZnQ3lPRllndFhHekVvMnUwU1JPOE5NSTRmdjl1?=
 =?utf-8?B?MUxlK0xOMDB5SHJpdkNRckQ2S2V4ZlFSMXJyM0RVMjM1M0trWnRhQnBEZGtE?=
 =?utf-8?B?M2c2MFI0KzhjSWl0VGdIbVEva3YwSXNybDJMSTVndjgxYXdXcUR4MDNTd2J2?=
 =?utf-8?B?UzJBRzhGamFqWWdNOW9FUUcvdE0zeDhFQmxOd1ZPNHhURmFQVkhFTzZab1hv?=
 =?utf-8?B?N0JPUnI5eXhweUhCb29MUzQvVDUvTHMvdGYycUNEYnJZNDBhemRUdndod3hR?=
 =?utf-8?B?YW5OZFlDL3BxR2U2MW14d0praUI1ekJlb0JmUHhoZTA5Zkd4WEJGdzl5b29Y?=
 =?utf-8?B?Smg0YW5VTlBuSzZPazA0TG10VTcvTG92Z3FzMWFUY1ZZbHJaSG1YZlQya3lV?=
 =?utf-8?B?STA0akhtOEpkeHRKcnJMK1JOenVhbXY3VzNFUnYrTWt2UGwxNWwrcjBXdWMv?=
 =?utf-8?B?YXd1SU5VZmdITUhFRTNYTVlmb0pXUVdjUkZqeFB5UUpWNlFwYVRuWWViRyty?=
 =?utf-8?B?RklUV2J3cnhvS3hUZzlqZDRPUnVZWCtvcUpoWnhLQWowSHZIWlZ3MXRpLzlj?=
 =?utf-8?B?NmE0TGFuSnAyT2ZObmVxMzZBRHJReDRzbzk2eWxtb2EvN0NWUVBaS2IweW1J?=
 =?utf-8?B?b2orcHdWRDduWFBFLzBkWDRwUTZZQXJ5SGFULzdTQ281dTZQU1NDdjVSUHF3?=
 =?utf-8?B?b3BsU2dMZHIwbkdNYzJJYUdmMEZKekw4NWJpYXI2QVBwOW9senpydURLNmdG?=
 =?utf-8?B?RVR5OTNMZm8xaW45NDVmczhTTEE2b1NrMFl1Q09mTEJTVlJSN2d1S1RPSWVG?=
 =?utf-8?B?N2VGN2lYTS9jdXNzK0s4OUZGSGRkK1NGVjdVM3VYQWkwR2wxU3JOREhiOEdL?=
 =?utf-8?B?Z2k1NmdOZWtFVytvVDcyNmVXK3phdWU3VlBYZytzK2dnb3E1eWpIaDEra1Fm?=
 =?utf-8?B?QkowYmVHYmg5QlhwalMxWjg0eldNYnAxZ2xMc1ZZSnNieUlXRnVYOGlSL01y?=
 =?utf-8?B?NHBQYVp6NWhoRjRvYWRyVm5aRitFWmdvOU5ocUR3RmxVVTMzaGVudjd6ZzJr?=
 =?utf-8?Q?IBo3qQ1sEpH43IJDgVirNFgL4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2302734b-1c19-4ac2-49d5-08dd580d2df0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 15:32:58.4634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RrVFMPjeGAgaGCOs0y3YL5Ik5a0mhiZ1dwL338hcaQYnp5l3YGEm7NuGlIVNdBkVS4x4xctBEDOv4zUMuOGp+aufFVxWXXbWQtknO/ugtqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6887

SGkgUGF1bCwNCg0KVGhhbmsgeW91IGZvciByZXZpZXdpbmcgdGhpcyBwYXRjaC4NCg0KPiBEZWFy
IE5lZXJhaiwNCj4gDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2guIEluIHRoZSBzdW1t
YXJ5L3RpdGxlIHlvdSBjb3VsZCB1c2UgKnRvIHNldCogb3IgKmZvcg0KPiBzZXR0aW5nKi4NCj4g
DQo+IEFtIDIwLjAyLjI1IHVtIDEyOjQxIHNjaHJpZWIgTmVlcmFqIFNhbmpheSBLYWxlOg0KPiA+
IFRoaXMgYWRkcyBzdXBwb3J0IGZvciBzZXR0aW5nIEJEIGFkZHJlc3MgZHVyaW5nIGhjaSByZWdp
c3RyYXRpb24uIE5YUA0KPiA+IEZXIGRvZXMgbm90IGFsbG93IHZlbmRvciBjb21tYW5kcyB1bmxl
c3MgaXQgcmVjZWl2ZXMgYSByZXNldCBjb21tYW5kDQo+ID4gYWZ0ZXIgRlcgZG93bmxvYWQgYW5k
IGluaXRpYWxpemF0aW9uIGRvbmUuDQo+IA0KPiBJ4oCZZCBhZGQgYSBibGFuayBsaW5lIGJldHdl
ZW4gcGFyYWdyYXBocy4NCj4gDQo+ID4gQXMgYSB3b3JrYXJvdW5kLCB0aGUgLnNldF9iZGFkZHIg
Y2FsbGJhY2sgZnVuY3Rpb24gd2lsbCBmaXJzdCBzZW5kIHRoZQ0KPiA+IEhDSSByZXNldCBjb21t
YW5kLCBmb2xsb3dlZCBieSB0aGUgYWN0dWFsIHZlbmRvciBjb21tYW5kIHRvIHNldCBCRA0KPiA+
IGFkZHJlc3MuDQo+IA0KPiBXaGVyZSBpcyB0aGUgY29tbWFuZCAweGZjMjIgZG9jdW1lbnRlZD8N
Cj4gDQo+IEhvdyBkaWQgeW91IHZlcmlmeSB0aGlzPyBNYXliZSBkb2N1bWVudCB0aGUgY29tbWFu
ZHMgaG93IHRvIHNldCB0aGUgQkQNCj4gYWRkcmVzcywgYW5kIGhvdyB0byB2ZXJpZnkgaXQuDQo+
IA0KPiBEb2VzIExpbnV4IGxvZyBuZXcgbWVzc2FnZXMgd2l0aCB5b3VyIHBhdGNoPw0KDQpJIGhh
dmUgYWRkZWQgVXNlciBNYW51YWwgcmVmZXJlbmNlIGluIGEgY29tbWVudC4gVGhlcmUgaXMgbm8g
bmV3IG1lc3NhZ2UgbG9nZ2VkIGJ5IHRoZSBkcml2ZXIuDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogTG9pYyBQb3VsYWluIDxsb2ljLnBvdWxhaW5AbGluYXJvLm9yZz4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBKb2hhbiBLb3JzbmVzIDxqb2hhbi5rb3JzbmVzQHJlbWFya2FibGUubm8+DQo+ID4gU2ln
bmVkLW9mZi1ieTogS3Jpc3RpYW4gSHVzZXbDg8KlZyBLcm9obiA8a3Jpc3RpYW4ua3JvaG5AcmVt
YXJrYWJsZS5ubz4NCj4gDQo+IFRoZSBsYXN0IG5hbWUgaGFzIHNvbWUgd3JvbmcgY2hhcmFjdGVy
Lg0KPiANCj4gPiBUZXN0ZWQtYnk6IE5lZXJhaiBTYW5qYXkgS2FsZSA8bmVlcmFqLnNhbmpheWth
bGVAbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOZWVyYWogU2FuamF5IEthbGUgPG5lZXJh
ai5zYW5qYXlrYWxlQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gdjQ6IGhjaTAgaW50ZXJmYWNlIHNo
b3dzIFJBVyBtb2RlIGlmICdsb2NhbC1iZC1hZGRyZXNzJyBub3QgZGVmaW5lZCBhbmQNCj4gPiAg
ICAgIEhDSV9RVUlSS19VU0VfQkRBRERSX1BST1BFUlRZIGlzIHNldC4gQWRkIFF1aXJrIG9ubHkg
aWYgZGV2aWNlIHRyZWUNCj4gPiAgICAgIHByb3BlcnR5ICdsb2NhbC1iZC1hZGRyZXNzJyBmb3Vu
ZC4gKE5lZXJhaikNCj4gPiB2NTogSW5pdGlhbGl6ZSBsb2NhbCB2YXJpYWJsZSBiYSwgdXBkYXRl
IENvcHl3cml0ZSB5ZWFyLiAoS3Jpc3RpYW4pDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2JsdWV0
b290aC9idG54cHVhcnQuYyB8IDM5DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bnhwdWFydC5jDQo+
ID4gYi9kcml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYyBpbmRleCAxMjMwMDQ1ZDc4YTUuLmRk
OTE2MWJmZDUyYw0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bnhw
dWFydC5jDQo+ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMNCj4gPiBAQCAt
MSw3ICsxLDcgQEANCj4gPiAgIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9y
LWxhdGVyDQo+ID4gICAvKg0KPiA+ICAgICogIE5YUCBCbHVldG9vdGggZHJpdmVyDQo+ID4gLSAq
ICBDb3B5cmlnaHQgMjAyMyBOWFANCj4gPiArICogIENvcHlyaWdodCAyMDIzLTIwMjUgTlhQDQo+
ID4gICAgKi8NCj4gPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+IEBAIC0x
MTk3LDYgKzExOTcsMzQgQEAgc3RhdGljIGludCBueHBfc2V0X2luZF9yZXNldChzdHJ1Y3QgaGNp
X2Rldg0KPiAqaGRldiwgdm9pZCAqZGF0YSkNCj4gPiAgICAgICByZXR1cm4gaGNpX3JlY3ZfZnJh
bWUoaGRldiwgc2tiKTsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IG54cF9zZXRfYmRh
ZGRyKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBjb25zdCBiZGFkZHJfdA0KPiA+ICsqYmRhZGRyKSB7
DQo+ID4gKyAgICAgdTggZGF0YVs4XSA9IHsgMHhmZSwgMHgwNiwgMCwgMCwgMCwgMCwgMCwgMCB9
Ow0KPiA+ICsgICAgIHN0cnVjdCBza19idWZmICpza2I7DQo+ID4gKyAgICAgaW50IGVycjsNCj4g
PiArDQo+ID4gKyAgICAgbWVtY3B5KGRhdGEgKyAyLCBiZGFkZHIsIDYpOw0KPiA+ICsNCj4gDQo+
IEFkZCBhIGNvbW1lbnQgYWJvdXQgdGhlIGZpcm13YXJlIGxpbWl0YXRpb24vcmVxdWlyZW1lbnQ/
DQo+IA0KPiA+ICsgICAgIHNrYiA9IF9faGNpX2NtZF9zeW5jKGhkZXYsIEhDSV9PUF9SRVNFVCwg
MCwgTlVMTCwNCj4gSENJX0lOSVRfVElNRU9VVCk7DQo+ID4gKyAgICAgaWYgKElTX0VSUihza2Ip
KSB7DQo+ID4gKyAgICAgICAgICAgICBlcnIgPSBQVFJfRVJSKHNrYik7DQo+ID4gKyAgICAgICAg
ICAgICBidF9kZXZfZXJyKGhkZXYsICJSZXNldCBiZWZvcmUgc2V0dGluZyBsb2NhbC1iZC1hZGRy
IGZhaWxlZCAoJWxkKSIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIFBUUl9FUlIoc2ti
KSk7DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+ICsgICAgIH0NCj4gPiArICAg
ICBrZnJlZV9za2Ioc2tiKTsNCj4gPiArDQo+ID4gKyAgICAgc2tiID0gX19oY2lfY21kX3N5bmMo
aGRldiwgMHhmYzIyLCBzaXplb2YoZGF0YSksIGRhdGEsDQo+IEhDSV9DTURfVElNRU9VVCk7DQo+
ID4gKyAgICAgaWYgKElTX0VSUihza2IpKSB7DQo+ID4gKyAgICAgICAgICAgICBlcnIgPSBQVFJf
RVJSKHNrYik7DQo+ID4gKyAgICAgICAgICAgICBidF9kZXZfZXJyKGhkZXYsICJDaGFuZ2luZyBk
ZXZpY2UgYWRkcmVzcyBmYWlsZWQgKCVkKSIsIGVycik7DQo+ID4gKyAgICAgICAgICAgICByZXR1
cm4gZXJyOw0KPiA+ICsgICAgIH0NCj4gPiArICAgICBrZnJlZV9za2Ioc2tiKTsNCj4gPiArDQo+
ID4gKyAgICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gICAvKiBOWFAgcHJvdG9jb2wg
Ki8NCj4gPiAgIHN0YXRpYyBpbnQgbnhwX3NldHVwKHN0cnVjdCBoY2lfZGV2ICpoZGV2KQ0KPiA+
ICAgew0KPiA+IEBAIC0xNTAwLDYgKzE1MjgsNyBAQCBzdGF0aWMgaW50IG54cF9zZXJkZXZfcHJv
YmUoc3RydWN0IHNlcmRldl9kZXZpY2UNCj4gKnNlcmRldikNCj4gPiAgIHsNCj4gPiAgICAgICBz
dHJ1Y3QgaGNpX2RldiAqaGRldjsNCj4gPiAgICAgICBzdHJ1Y3QgYnRueHB1YXJ0X2RldiAqbnhw
ZGV2Ow0KPiA+ICsgICAgIGJkYWRkcl90IGJhID0gezB9Ow0KPiA+DQo+ID4gICAgICAgbnhwZGV2
ID0gZGV2bV9remFsbG9jKCZzZXJkZXYtPmRldiwgc2l6ZW9mKCpueHBkZXYpLCBHRlBfS0VSTkVM
KTsNCj4gPiAgICAgICBpZiAoIW54cGRldikNCj4gPiBAQCAtMTU0Nyw4ICsxNTc2LDE2IEBAIHN0
YXRpYyBpbnQgbnhwX3NlcmRldl9wcm9iZShzdHJ1Y3Qgc2VyZGV2X2RldmljZQ0KPiAqc2VyZGV2
KQ0KPiA+ICAgICAgIGhkZXYtPnNlbmQgID0gbnhwX2VucXVldWU7DQo+ID4gICAgICAgaGRldi0+
aHdfZXJyb3IgPSBueHBfaHdfZXJyOw0KPiA+ICAgICAgIGhkZXYtPnNodXRkb3duID0gbnhwX3No
dXRkb3duOw0KPiA+ICsgICAgIGhkZXYtPnNldF9iZGFkZHIgPSBueHBfc2V0X2JkYWRkcjsNCj4g
PiArDQo+ID4gICAgICAgU0VUX0hDSURFVl9ERVYoaGRldiwgJnNlcmRldi0+ZGV2KTsNCj4gPg0K
PiA+ICsgICAgIGRldmljZV9wcm9wZXJ0eV9yZWFkX3U4X2FycmF5KCZueHBkZXYtPnNlcmRldi0+
ZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJsb2NhbC1iZC1h
ZGRyZXNzIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAodTggKikm
YmEsIHNpemVvZihiYSkpOw0KPiA+ICsgICAgIGlmIChiYWNtcCgmYmEsIEJEQUREUl9BTlkpKQ0K
PiA+ICsgICAgICAgICAgICAgc2V0X2JpdChIQ0lfUVVJUktfVVNFX0JEQUREUl9QUk9QRVJUWSwg
JmhkZXYtPnF1aXJrcyk7DQo+IA0KPiBQbGVhc2UgZWxhYm9yYXRlIGluIHRoZSBjb21taXQgbWVz
c2FnZSwgd2h5IHRoZSBxdWlyayBpcyBuZWVkZWQuDQo+IA0KPiA+ICsNCj4gPiAgICAgICBpZiAo
aGNpX3JlZ2lzdGVyX2RldihoZGV2KSA8IDApIHsNCj4gPiAgICAgICAgICAgICAgIGRldl9lcnIo
JnNlcmRldi0+ZGV2LCAiQ2FuJ3QgcmVnaXN0ZXIgSENJIGRldmljZVxuIik7DQo+ID4gICAgICAg
ICAgICAgICBnb3RvIHByb2JlX2ZhaWw7DQoNClJlc3Qgb2YgdGhlIHJldmlldyBjb21tZW50cyBJ
IGhhdmUgcmVzb2x2ZWQgaW4gVjYgcGF0Y2guDQoNClRoYW5rcywNCk5lZXJhag0K
