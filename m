Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006CA143749
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866520; cv=fail; b=Gl5vxl2H0t7Qokb1Ph4dkvtxI7ELD13QdEiUIv3lc0dVaw2DRipPXlLyygh5Pu0KOPopKHZVevDFFbtCQ0xmgtXYPhYfFrHefFFe5WafRHuqZD/FImitpnU86XR2B9owdwcwKzHT4urSf8tiy6UO+grqH+Q78mJHmU81lMSbs/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866520; c=relaxed/simple;
	bh=CQDxEo86ItioS2K/6Log4NeERW1M+BCof1eGLoPGiiw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M6H/MhKEX76F+dnXkfKRQxnOeS9R953vfrXoWpB75f0sf+a5QtNkLff3OCOb3vdsNgpaW+3LdV0Lr8+SHO6uUSAepiflgwmNiGMFgkJugX7FlmvyIb1fH73uhvvmEaLY3xMCaJFYqol2oadKhVbfpmch18/xmNxj72Qay+xt/Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WW7vzCVp; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WW7vzCVp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715866518; x=1747402518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CQDxEo86ItioS2K/6Log4NeERW1M+BCof1eGLoPGiiw=;
  b=WW7vzCVpmjFY3e+jxZQy3tTOBG0B5S5Dm1f8AinsfSJ9YvAFmIIrxCxj
   rI80NAyV7gTM7SzGH46339iRCeW1utB3j2AK/yCx/UrKPC107ix57znNj
   QnlyL5fjN6tzUk8vFiaa+tj+52k/T3/MphItn2MvFmFRYisywTPHKRE1U
   jZafNzicbmFiUWSeKsXwrjzBDvuCTJfhI1zvHASrNTiQsTpEcGeUFZ3TV
   FBEfSwomFlL+Z4ItYCC2Z8DhAKXnQLz5TheFhVxOkib0xSICwfSDlQd83
   +5DYppKjSlIfszvbh4cm1wfbokSTITEWgc2hGdWlTTH2r34ulfihDfL9g
   g==;
X-CSE-ConnectionGUID: Q4Xudkm9RaajALEDzccWbw==
X-CSE-MsgGUID: 2zbn1bJyReSC6rHcEpa60A==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11810492"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="11810492"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 06:35:17 -0700
X-CSE-ConnectionGUID: EsqIUOSnReKOh+cPhWQ6tw==
X-CSE-MsgGUID: pBGVYvUZRse9OMGK8WXylw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31847097"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 06:35:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 06:35:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 16 May 2024 06:35:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 06:35:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6Dvajtu7WqolAqq11EJWA5+6E92+iTGJUpNFzUXl1s39HIonBPsG0RQiIPcn/qnUU0iMDK+iDGGSXElh5Pu0Sze7ewuTdVIdr0dRWP0ciSpCz0Om2WvlnQPJu7SKpivYaCMfbJew/+AZWdMHDoaqRwvMejnpSNinZY8/fC3mhTD9wAP7xBBLvxeC4BpFVEbfd6XMMBHpYSQXlwIifPibKx9JZ+Lm2O7dv6l+ryIqgQPrFV/1CVg71pVn85LOCZyebzFPn4PiLQaw/QYep20/+7N6GZuJPZ/tOveVXpEYDzkN0cLIt3EI+shtrx8es4GkIV/dhsfx3A3e/G0Xyi8Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQDxEo86ItioS2K/6Log4NeERW1M+BCof1eGLoPGiiw=;
 b=fmDG6T5zTkk7Ln3mZ9ioYTvail6FQWu+4NYlQPpzmjIMSLNpU8n/WPEUGBKosiaW6LlqtUxjr7EfXr/5nDpyRa4WnkLrdso6ew+yc7cewuLvfXwd/dPLrAToY5qJw3QXhsGze16hj8HzsUxIOIaIJDXNRvdVYZ6zh/0gPt15ao8EHvupTWz+Zy6IWME3WKYGC6R+zHjqIxiZhSOeeTdqFiSCJFKpOBjtQd5VDC6Gnbbh6LAYKeLPgnSc+lPr6G5gkA46TU8ZBMtAaoVTA3u7uMZceCr8UvnATMZIOz6xcx3GR9yo8/C/0cSITZy0yJ1jM8lsBAyiJLWI++7Wl7PYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by IA0PR11MB7186.namprd11.prod.outlook.com (2603:10b6:208:442::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Thu, 16 May
 2024 13:35:13 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%7]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 13:35:08 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Satija, Vijay"
	<vijay.satija@intel.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v1 1/3] Bluetooth: btintel_pcie: Print Firmware Sequencer
 information
Thread-Topic: [PATCH v1 1/3] Bluetooth: btintel_pcie: Print Firmware Sequencer
 information
Thread-Index: AQHap4wj6/0HI6rkyUK8rpqVcSU3WrGZ0zQAgAAH1mA=
Date: Thu, 16 May 2024 13:35:08 +0000
Message-ID: <PH0PR11MB7585F9EB164FD3D02A9F58D9F5ED2@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240516123938.891523-1-kiran.k@intel.com>
 <f42caf85-6a43-4d18-b14d-b5a3c55af0d3@molgen.mpg.de>
In-Reply-To: <f42caf85-6a43-4d18-b14d-b5a3c55af0d3@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|IA0PR11MB7186:EE_
x-ms-office365-filtering-correlation-id: 087c6eee-4c7a-40b0-005a-08dc75ad00e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?c1pTODlQdmpCa1FXZzNRRzZ1ZjJiQ0FNYzMrRFVha1psb05FL2c0V0VZa2lO?=
 =?utf-8?B?aUwySDNrcGpVWG82Z0drbUxia3crQWp1MTMrK3RFbmZPbnc5bTNQMThPV29R?=
 =?utf-8?B?K1JQb2JTNmxNYzJ1TTBuWlRKZG5MdU52dGl6QTY5UVQ3cUdYNVdZcXA2MC9F?=
 =?utf-8?B?SURJQTdQK1hTMEN4VFJDdmh6YTNIdGpSOEZqcmhwbXd0VkVvSmZGVTFhb3Qv?=
 =?utf-8?B?S1BFb0gwNzV2cURaRmg5Z1NWOWVCUi9WQTh6ZEJHU1dsNmM3QXBYcTJMcUxS?=
 =?utf-8?B?bll6SnN6UkRHUnE4NG5JbFZqSEhsVVJUKzJFMzh5NUhXM2VUc1hER2tlb0Zn?=
 =?utf-8?B?cmgvUno3eXpNRW5XMUtSTVphR0dXOHEvaysvcDBlaDJFUzZzdVBNZTMwakhU?=
 =?utf-8?B?UzBqZWVLVTZxT01uOHJqays1N21BTjRQK1JDMHlDcDBwUEk0bW4yZGgzU0ZV?=
 =?utf-8?B?Z0creWliNHUyd0xSWk84Ry9uRDI1Q2lwRlNTYm1Ja2liTnp1Rmg3bE1LN0VD?=
 =?utf-8?B?bUNSNkM5VHBqd2ovZlZZb2pMMjVIZnkxbTBDR2JmbVFCa09Cck1BdnMvWXM0?=
 =?utf-8?B?UGtEWGxyU01WSy8zbkhsNUh6V1VLWCtLNjhDN3NTMElpYnNCNDJXOWVTaE1n?=
 =?utf-8?B?dzJRQ3BSdXFXZDZLNTBWTXJDbkNWdHBvK042cDZ6NDZKRSt0YlQ0dDVaaUM0?=
 =?utf-8?B?UDBSSEJRdGpjQ0NUeFpYWncxbXVMdlBwbndBMXdBcXdDeFJuK3duQ0lSNWxw?=
 =?utf-8?B?TnBIUFZ5N2sycHlXOEhpM3FoQ3MwdlZzNVIrK1RqNld3R3N5cExaOGVoN1Bj?=
 =?utf-8?B?Wk12TEFqYVp4QWFJcFFUdmZTSkU3N21wT0FuR3FpYlVGTEpVczAwR3FYdUpq?=
 =?utf-8?B?aGR6ZzVFdUVoS3pYV0dRaVJhTHVWNlpzVTlGQjFKU0xxeHJ0TytpUldBdGlY?=
 =?utf-8?B?YVlocW5JRkE5MmJiV1RSS0xjdmtGektKVVZIeGpRcWRQRDVGMjFEbThJMFFK?=
 =?utf-8?B?dDZzVFM3WEtaRUZaRkhUSlAwZXFLL2Y1d3pVTzBGSlRCa3MxNFFZbFRpdlNG?=
 =?utf-8?B?bm50NHEyR3NHSmgrdmZNLyt3RXJkY2NsTXhQZ0tSTG9ycCt5SzhYaVlzWGxy?=
 =?utf-8?B?RGVxRWJvTFloNFZMVnZxa1NlY0xrMnRuR3dyNmRKMlQwanNQc3BuS3h6VFVO?=
 =?utf-8?B?M1dIekVKRnk1cHYvQVJPWmU5bHdUK1NLd2JneCs2NkZHd2h0MzBQZlgwR1Jt?=
 =?utf-8?B?NkdqcFJENTRGRFRYOG9zWFVnZXVzS1hBcnVwU2JWT2JkTUJQYldoVlEzQ3Zj?=
 =?utf-8?B?ZXJ6dHBJdkZBTnRKZW5NbkF5WFo5Vnl3OHRLRVZKbEk1YUNoK3Ntc3hRK2F5?=
 =?utf-8?B?d3hkRTRUT2l0Q3pqcVJDMTMrSHcya3ZaWjZQOEhSOGtCSWo5c1BheXhFMjNw?=
 =?utf-8?B?eEJtNXJFaFM1SXBNTWF4aE9qNXhUa25wTXduSjFwVjk4WlAvWlBuWHJ3a0JE?=
 =?utf-8?B?dWFubFZEKzlhSi92b2RmTVkzL3BwM0M3MXBlZWk0b0MyL3V2M3d4T1NUWm10?=
 =?utf-8?B?R1Nzb1djdUNGSEE5QnA5RmsrWjhUMTQyemRsMlVXdHd3Um9zcjA0T01rblNj?=
 =?utf-8?B?THNiWHN2RnRGaVNGT3F2Ui9jYUpQTXJrNERrTkRBMDNYSFZJOHd6MWR2VDRk?=
 =?utf-8?B?azRJeEt6bEltd20xeTcvdXRsYmlPcjRuWXplbUl4N25WZy9xNHlVb213NVJP?=
 =?utf-8?B?VVN6Snl2TnBSOGVWazNFMDdCVzRLVStid3Z6WmpyVGlEU1RhTGNYRWFJcEZM?=
 =?utf-8?B?QVAzdUphek94VjhhdUZHQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0UzanNKQ094NThCYkdQczNyVVptQjdQTTM1emFEdUFDUTRDRXNQTnMzMk5G?=
 =?utf-8?B?R2dGdXRRZkdYeXAyaGRycFNZL1paei9WeG5laGRFN1d6TlB0OWxqVXNEVGI0?=
 =?utf-8?B?dCtJN2YwQVVHU2V6M2R0dmJ1eDlHazRSTndqU1hJOXdrQ29TMzZwWmlUTHZr?=
 =?utf-8?B?NjNQVnYvcGRoMWhCTEJFemx6ZXR5dW9VZjBORjBQZmttVGlVVkxkNEJ0T2w5?=
 =?utf-8?B?T0YyekUwb2llSUd5elp3VklJRjlXVUo2cXNpU0pzSXovd1ppR3JUNlM3ZTdK?=
 =?utf-8?B?NE1DcTR6RlRLRmFtYk5kMjRVTXNmTFRVMlRySUpNQ0lSQlpBWXdFZkxuZmtw?=
 =?utf-8?B?ZGJtMWtTSFlzMnQyTnkxbVpOL2p4SUdKK0RsTEtNejhlclBuUG91YWtwbkhF?=
 =?utf-8?B?L1NXQ2xHdG9OaCtsQ2Y3eXBqUStJaFZiaU9XL1N4Z1JmNkF6ZU44RGd4aUVm?=
 =?utf-8?B?V1l6TGh3RGJkRG5jdFNpa0FNdUR2Uk02MEhiMS81bmN6SkR5VWhuSy9heXhn?=
 =?utf-8?B?c3dYNFBmZEhqbWxGMFlhdEtaejRkNyt2M285REhDT2JDVE14bUgvSWZZN1Ir?=
 =?utf-8?B?Rk8waVhnbUc4L3cxUUNsSFRoc3dyM1RNb0wxY0ZtUERBekdPY25LWjY1QkhC?=
 =?utf-8?B?SGJJWGJtbWcwcHl4S0Z0NTJ2UjUxeHoxaDhBdGREZ0h6U09rSjhlWU95NVl0?=
 =?utf-8?B?YkZCSlBrUWdIWkZIUjNlcjdFY1JRekJtL3d1VGxYbUNTdGoxVFQvNXZZMy9D?=
 =?utf-8?B?WG85WjY3VmRTb3MzMUtzL2J3SnU0ZFpQOEdhRkFxanV1S2w3THJJSHNtWUt2?=
 =?utf-8?B?aW1NYTlsWk9DenF5aWZOM203WjMyZWFsbnhwbXIyN2RncEZoWiswa0J1dEw0?=
 =?utf-8?B?dE1kL3JNVlJuaTFQM1YwWVM4MnloTU9CanNNZjFxUG1aeUExZGNnYlByY3hh?=
 =?utf-8?B?czZLdjBXYjVxQnltckNpYVk1cEYwUmJtL0EvczNjYjVtK3JiQXZZdkdwWTFw?=
 =?utf-8?B?TzdLVGhGUzI1MTF2WWp0NUE1THVHMXhNeFN2NURMMjR0MXVjRXJDWFpva0wz?=
 =?utf-8?B?emZCYmZmUDRVcVBCVW1SazZ0SVFiZmRHN2p3bEtlZTRUU2dsTUlMY1BvREhu?=
 =?utf-8?B?c3NxK1Q3endOaHRjL0xiMkk1R3c3eWtGRng1ckprYU9SNCt2T3JJcDdqcFd3?=
 =?utf-8?B?V29FZmFiQVBMc3NVWTRONHE1M3dmM1dQeXd0cmZlNjg2K0x6WkQrWGJFdm02?=
 =?utf-8?B?Z3U1QllPanAvUFJpRUNQTUZtMXg0b3QwTUREY2xmaWU1T3ZxMWxiQVFwc1pQ?=
 =?utf-8?B?RDNiOWNVMlFNd20vQmpvbjR6aUxKN1NncU8zdHRHT0ZEWmNvUDdBK0wrNzhJ?=
 =?utf-8?B?SWdKa3NSY1BFRnNQaHZDZFlLVEdkdFp6ZnRsM3VURlBmdk8wR3U4SUtpUnhp?=
 =?utf-8?B?NS9oZ1hBUDJmNnY0NW5DdGhKZjdTclpaZHIvMndrMlFPdkpPRXMzeGd5SWVW?=
 =?utf-8?B?ZmJkUnFZaDVrN3Z4dU94YjZsakg2eE1iYlovTDNCREszamZxblk2MFNYSHU3?=
 =?utf-8?B?Y2VDOHJpai9DaTFiY21sMnF6cnAyeFJKa0xrUU5rQ2RUaW0vWkNDUmc3MzlJ?=
 =?utf-8?B?MS9jR01zeTRzSWlKZFdsWlRlZXgyaUNZZXN5eEtwSUliTzNpK2h0NlZYZWpX?=
 =?utf-8?B?VXZ5UnFQTUM1b2xDY01kZndUNVFKSHZwSUFyaGs4eEJxSkptcWwvVElZTW5B?=
 =?utf-8?B?MzVkUjVxNFRGRUdVMHJBRU1PQXVHK080MTBSYUdtWEpzejVBa1I3QjdFakpn?=
 =?utf-8?B?SlY0cWI4ZWFlcDZaeThkZWNhZFdWQnJGM0RSR295S0NuTzhGUnNmVklRUWZD?=
 =?utf-8?B?MlpUcDhKYkdvczQ2TUhKdEN4R0RxR1phcUhqbEVzRHVWeGpYQWI0TkZCUTRY?=
 =?utf-8?B?ZzFrZGIvS2RWUmdjU0xmdnRDVDV0QVR3U1doRThKUXRBOTU5bkYzWmtSL2FY?=
 =?utf-8?B?dlh1T21xRDg1TUdkWlZtSHdFY2hsNlJNWUdtbk4wYmVyMjRMRWxSYk8vY1d2?=
 =?utf-8?B?Ry9MV00yejZYeVc4QlpzYUxCL0lZSUVQVGMyVHhGdG1zWnhYTGNCMng3UXc5?=
 =?utf-8?Q?1nFA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087c6eee-4c7a-40b0-005a-08dc75ad00e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 13:35:08.4480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wTMoa4XKV31wLvTjPU9Z7I0+t6jLeecj3yFk3jFtjbVk3QSboDoSzUJZJ78yp3oeUgj/sBB5KJlkL+PyOO33LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7186
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+LS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj5Gcm9tOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0K
PlNlbnQ6IFRodXJzZGF5LCBNYXkgMTYsIDIwMjQgNjozMSBQTQ0KPlRvOiBLLCBLaXJhbiA8a2ly
YW4ua0BpbnRlbC5jb20+DQo+Q2M6IFNyaXZhdHNhLCBSYXZpc2hhbmthciA8cmF2aXNoYW5rYXIu
c3JpdmF0c2FAaW50ZWwuY29tPjsgVHVta3VyIE5hcmF5YW4sDQo+Q2hldGhhbiA8Y2hldGhhbi50
dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+OyBTYXRpamEsIFZpamF5DQo+PHZpamF5LnNhdGlqYUBp
bnRlbC5jb20+OyBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6
IFtQQVRDSCB2MSAxLzNdIEJsdWV0b290aDogYnRpbnRlbF9wY2llOiBQcmludCBGaXJtd2FyZSBT
ZXF1ZW5jZXINCj5pbmZvcm1hdGlvbg0KPg0KPkRlYXIgS2lyYW4sDQo+DQo+DQo+QW0gMTYuMDUu
MjQgdW0gMTQ6Mzkgc2NocmllYiBLaXJhbiBLOg0KPj4gRnJvbTogS2lyYW4gPGtpcmFuLmtAaW50
ZWwuY29tPg0KPg0KPlNob3VsZCB0aGlzIGJlIEtpcmFuIEs/DQo+DQpZZXMuIEkgd2lsbCBmaXgg
aXQuIExvb2tzIGxpa2UgdGhlIG1hY2hpbmUgd2hlcmUgdGhpcyBmaXggaXMgZG9uZSBpcyBub3Qg
Y29uZmlndXJlZCBwcm9wZXJseS4g4pi5DQoNCj4+IEZpcm13YXJlIHNlcXVlbmNlciAoRlNFUSkg
aXMgYSBjb21tb24gY29kZSBzaGFyZWQgYWNyb3NzIEJsdWV0b290aCBhbmQNCj4+IFdpZmkuIFBy
aW50aW5nIEZTRVEgd2lsbCBoZWxwIHRvIGRlYnVnIGlmIHRoZXJlIGlzIGFueSBtaXNtYXRjaA0K
Pg0KPlNvLCBtYWtlIGBidGludGVsX3ByaW50X2ZzZXFfaW5mbygpYCBwdWJsaWMsIGFuZCBjYWxs
IGl0IGluIGJ0aW50ZWxfcGNpLg0KPg0KPj4gYmV0d2VlbiBCbHVldG9vdGggYW5kIFdpZmkgRlNF
US4NCj4NCj5QbGVhc2UgcGFzdGUgb25lIGV4YW1wbGUgbWVzc2FnZS4NCg0KSSB3aWxsIGluY2x1
ZGUgY29tbWl0IG1lc3NhZ2UgaW4gdjMgdmVyc2lvbi4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IEtp
cmFuIDxraXJhbi5rQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2JsdWV0b290aC9i
dGludGVsLmMgICAgICB8IDMgKystDQo+PiAgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuaCAg
ICAgIHwgNSArKysrKw0KPj4gICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYyB8IDIg
KysNCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jIGIvZHJpdmVy
cy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+PiBpbmRleCAwYzg1NWMzZWUxYzEuLjJjNDM0ZmY5YzQ3
YyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPj4gKysrIGIv
ZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+PiBAQCAtMjcxMyw3ICsyNzEzLDcgQEAgdm9p
ZCBidGludGVsX3NldF9tc2Z0X29wY29kZShzdHJ1Y3QgaGNpX2Rldg0KPipoZGV2LCB1OCBod192
YXJpYW50KQ0KPj4gICB9DQo+PiAgIEVYUE9SVF9TWU1CT0xfR1BMKGJ0aW50ZWxfc2V0X21zZnRf
b3Bjb2RlKTsNCj4+DQo+PiAtc3RhdGljIHZvaWQgYnRpbnRlbF9wcmludF9mc2VxX2luZm8oc3Ry
dWN0IGhjaV9kZXYgKmhkZXYpDQo+PiArdm9pZCBidGludGVsX3ByaW50X2ZzZXFfaW5mbyhzdHJ1
Y3QgaGNpX2RldiAqaGRldikNCj4+ICAgew0KPj4gICAJc3RydWN0IHNrX2J1ZmYgKnNrYjsNCj4+
ICAgCXU4ICpwOw0KPj4gQEAgLTI4MjUsNiArMjgyNSw3IEBAIHN0YXRpYyB2b2lkIGJ0aW50ZWxf
cHJpbnRfZnNlcV9pbmZvKHN0cnVjdA0KPj4gaGNpX2RldiAqaGRldikNCj4+DQo+PiAgIAlrZnJl
ZV9za2Ioc2tiKTsNCj4+ICAgfQ0KPj4gK0VYUE9SVF9TWU1CT0xfR1BMKGJ0aW50ZWxfcHJpbnRf
ZnNlcV9pbmZvKTsNCj4+DQo+PiAgIHN0YXRpYyBpbnQgYnRpbnRlbF9zZXR1cF9jb21iaW5lZChz
dHJ1Y3QgaGNpX2RldiAqaGRldikNCj4+ICAgew0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0aW50ZWwuaCBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuaA0KPj4gaW5kZXgg
YjVmZWE3MzVlMjYwLi43OTY5NTM1NDc5MzIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2JsdWV0
b290aC9idGludGVsLmgNCj4+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuaA0KPj4g
QEAgLTI0NCw2ICsyNDQsNyBAQCBpbnQgYnRpbnRlbF9ib290bG9hZGVyX3NldHVwX3RsdihzdHJ1
Y3QgaGNpX2Rldg0KPipoZGV2LA0KPj4gICAJCQkJIHN0cnVjdCBpbnRlbF92ZXJzaW9uX3RsdiAq
dmVyKTsNCj4+ICAgaW50IGJ0aW50ZWxfc2h1dGRvd25fY29tYmluZWQoc3RydWN0IGhjaV9kZXYg
KmhkZXYpOw0KPj4gICB2b2lkIGJ0aW50ZWxfaHdfZXJyb3Ioc3RydWN0IGhjaV9kZXYgKmhkZXYs
IHU4IGNvZGUpOw0KPj4gK3ZvaWQgYnRpbnRlbF9wcmludF9mc2VxX2luZm8oc3RydWN0IGhjaV9k
ZXYgKmhkZXYpOw0KPj4gICAjZWxzZQ0KPj4NCj4+ICAgc3RhdGljIGlubGluZSBpbnQgYnRpbnRl
bF9jaGVja19iZGFkZHIoc3RydWN0IGhjaV9kZXYgKmhkZXYpIEBADQo+PiAtMzczLDQgKzM3NCw4
IEBAIHN0YXRpYyBpbmxpbmUgaW50IGJ0aW50ZWxfc2h1dGRvd25fY29tYmluZWQoc3RydWN0DQo+
aGNpX2RldiAqaGRldikNCj4+ICAgc3RhdGljIGlubGluZSB2b2lkIGJ0aW50ZWxfaHdfZXJyb3Io
c3RydWN0IGhjaV9kZXYgKmhkZXYsIHU4IGNvZGUpDQo+PiAgIHsNCj4+ICAgfQ0KPj4gKw0KPj4g
K3N0YXRpYyB2b2lkIGJ0aW50ZWxfcHJpbnRfZnNlcV9pbmZvKHN0cnVjdCBoY2lfZGV2ICpoZGV2
KSB7IH0NCj4+ICAgI2VuZGlmDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRp
bnRlbF9wY2llLmMNCj4+IGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+IGlu
ZGV4IDViNjgwNWQ4N2ZjZi4uOGQyODJlZTIzMjJjIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9i
bHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50
ZWxfcGNpZS5jDQo+PiBAQCAtMTE5Nyw5ICsxMTk3LDExIEBAIHN0YXRpYyBpbnQgYnRpbnRlbF9w
Y2llX3NldHVwKHN0cnVjdCBoY2lfZGV2ICpoZGV2KQ0KPj4gICAJCWJ0X2Rldl9lcnIoaGRldiwg
IlVuc3VwcG9ydGVkIEludGVsIGh3IHZhcmlhbnQgKCV1KSIsDQo+PiAgIAkJCSAgIElOVEVMX0hX
X1ZBUklBTlQodmVyX3Rsdi5jbnZpX2J0KSk7DQo+PiAgIAkJZXJyID0gLUVJTlZBTDsNCj4+ICsJ
CWdvdG8gZXhpdF9lcnJvcjsNCj4+ICAgCQlicmVhazsNCj4+ICAgCX0NCj4+DQo+PiArCWJ0aW50
ZWxfcHJpbnRfZnNlcV9pbmZvKGhkZXYpOw0KPj4gICBleGl0X2Vycm9yOg0KPj4gICAJa2ZyZWVf
c2tiKHNrYik7DQo+Pg0KPg0KPg0KPktpbmQgcmVnYXJkcywNCj4NCj5QYXVsDQoNClRoYW5rcywN
CktpcmFuDQoNCg==
