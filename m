Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FC5139586
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 May 2024 05:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714713239; cv=fail; b=kONCDJH1+LoODq8F2KvCR3zzj7SkT3+MpgXlApNQ92LVq4HaHeQKx6ZLHZeTOvsr5azdsd3DfGYSBWvalE16lZqVkWNCgQMYsEWA/p552IrfurRLWij270lfXoy19l6vqwEa3MvRxEZSs/RlQRtOncPBcACXYEKwlJxXpDg6XWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714713239; c=relaxed/simple;
	bh=Pou1NRsCEUSx49cjIwE2qCB3R7LV7k2eoR0F4XM4FeQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=erirzp88onhuyZaER3vYqb56aWRazPGlQ9WW6OYTUpz9ECENT/I0rbAyKocF09YcDRLBe878UeYhWHX7GIoYs4FceZZJIkaVC1THXeBnvngo3mbrOC43EtXmRf9xQQ1/kG/2MlPoAT+bwYcShHS8fUekCIn69WktrfEC3GslhXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0yDoFMl; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0yDoFMl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714713237; x=1746249237;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pou1NRsCEUSx49cjIwE2qCB3R7LV7k2eoR0F4XM4FeQ=;
  b=j0yDoFMlyMr1KxPHkrWkKIl75MAgUurokRjDLS9UwjiiruTl6D7suIJI
   93CbwpAD5giLgYdyan/NHAtUOpg6D9g6noH0S7VrZnsOoGXwki0jcaNpd
   zAZqfo+kmC/JBHiuHksGQEwTNbJ6Ibc5Q2jW91dHsnNb2gygPNc6QPya8
   Zdqc6wwVQuUxWE+B7ZMKsLjLlI54+vNhehwVobDOoH06Ejgoq753LOVdA
   KWVvrahFSnS/cmJqzbdF6ZmdZtckBilojnyn7/o/ciN7Gi/PtW9yUwUoS
   kd9+JUUFE5EEiex9RbGV9elzN26fOln/1h+jYV0GRPwqK/mylZeWr8TNE
   Q==;
X-CSE-ConnectionGUID: sdG1P/IuQcaCyAWCg57e5w==
X-CSE-MsgGUID: CRkDNN6uQDm1UBwNfU9g/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="28046715"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="28046715"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 22:13:56 -0700
X-CSE-ConnectionGUID: 36C85HilQs6ZvBafa/qOkg==
X-CSE-MsgGUID: hyq5VEDASh24Gj2YvFZDDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="64797328"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 May 2024 22:13:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 22:13:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 2 May 2024 22:13:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 22:13:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7lk6ez9qo3up4B0IkeICrVPZpYt37FT2/3FkxneGsvBrK3E9ffVFUU1doD631Oq3mQyEZLHrTFLT50mZyMxw7lqsUFqeNS6B2viG5Ep897nRV07ofKjnQ4839YhuNDtMH+XLIPPlJgVr0baLTuGRrXMF4OaG2x7w6lRiDnP1TRsZJexZhecSUhin8nTclt0mrL7IVLs3PXNAFTbDvLl+4jZ/kBtNuB+O1yWdH0iYQyBRkhVDpeeYVNiGcSor8oewis/HE99+DktNCUYXxphd1a7cUY3RzwhyArCSmZz3ejeGMsupeMqkPWwlFYKwKiG86QGtny0RGEDPGj6OCkMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pou1NRsCEUSx49cjIwE2qCB3R7LV7k2eoR0F4XM4FeQ=;
 b=m+BMD/fzZIUQWpfNdQJjAVHpn0nMkmwxEdUXo9RneZdtncaaQBRBGTA2bzS4m+EfG0+mjGtNm8o+ShokRUtTP2Qkx34XUjI/mB0kxGHCRfzLKxLGMJzBCDtaLCpoxqEiMoti6yWYXKF68w31ojpiN6StG1Odkys17XD2sTWANS/F4PoV1EcKLsCWX5zN07xljcRO1DWZcXibOUQWCmz9NGivFWYLZMynRM340EhAqq07J6gIJJad6jKDH60QXuomUhVUi7NGCq6olDtWg0X3s0YoF1zy8t2q9bouckFD0nbDllj0b9Q3YDC+//5Zxq6lwU0HeMU/Y4QCkPmTvlNqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by PH7PR11MB5817.namprd11.prod.outlook.com (2603:10b6:510:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Fri, 3 May
 2024 05:13:52 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%7]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 05:13:52 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>
Subject: RE: [PATCH v1 1/2] Bluetooth: btintel: Add support for BlazarI
Thread-Topic: [PATCH v1 1/2] Bluetooth: btintel: Add support for BlazarI
Thread-Index: AQHanE8AloWaYKC8FkWU+nq0paFjsLGDcZ8AgAGGgWA=
Date: Fri, 3 May 2024 05:13:51 +0000
Message-ID: <PH0PR11MB758556D5107ABA3811FE7E00F51F2@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240502052356.2630798-1-kiran.k@intel.com>
 <1d11ab52-2369-485d-a1cf-cca6ca836cb0@molgen.mpg.de>
In-Reply-To: <1d11ab52-2369-485d-a1cf-cca6ca836cb0@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|PH7PR11MB5817:EE_
x-ms-office365-filtering-correlation-id: b33bd199-09ab-4456-2e1e-08dc6b2fd296
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RnhyaGJLOW4ydStLemFuait4QzlNNUhDbkVZcGxNZDVXcWxNRHUreGlVQkFH?=
 =?utf-8?B?YXd6aE1hY3RHRTRPM2tlRHJtZU9Uam5aR0VjYTVYZ1F2QXFNek1BTi9IdTdW?=
 =?utf-8?B?ZEtDNk1NejZYaDJjNldmQUVJUmNzQndSUWpBamxhTVB0eWFGdFl6cnY4eUZ2?=
 =?utf-8?B?QmNyRGJTeDZUZVMrZ3U4cFpqTjIvZzBRRmFRcGMxcEU4RURFU1E1TmxiVG55?=
 =?utf-8?B?OFhFMytLY2VsZG52S3hHV3l6b2c1enJLcFVROUZrRERXQ096WFBWS1UyTG9F?=
 =?utf-8?B?UEZDZDlyN0R0djd4VnFwcmJub2hWVkN4cThXWFJGTkRtd2hvOTNIeHc5emRp?=
 =?utf-8?B?WWpIU0YxOVlkK0xRbFA0c2YrMFNKaGJDTW5rZ2pBOWF4ekpWT0JEYXYwUy92?=
 =?utf-8?B?Vm5MdHNaNy9jWEt0WElJMzVDOURxLzNnNldNQVVpdG80OGNqcHFMMGx6UU9q?=
 =?utf-8?B?Q2NuVHdDUGpUcGpJN0R1Wk0zNjlXM1hKVXk2TUFMNGZQNk5QTUw1WGZ2b2RZ?=
 =?utf-8?B?S0FBeUdSaklGRit5WVp1RlNaM1QrRnZ2THQzSnpzUTluOUZLdXl5SHhacHV5?=
 =?utf-8?B?OXlTdlhlaDRVQkFyaXB5bmlQcmFnRTVjSFBxdTRvM3NGamxuVmNIL0hoMWhn?=
 =?utf-8?B?NFhGT1RwNUNiMDhjdU80aDNaSUZHT21IR0VHN2duc3pCNWJIM2tGVldBVVo5?=
 =?utf-8?B?d1c2TksxZ2dwUmNuNExzV3g4RzlJNVIvUngzUm9sdmlVUUxMU2YxVmIrMTli?=
 =?utf-8?B?WUFtZ25SU1htMFNMMG9oK21BLzhsaGFLS2RhZWlPWDJ3QTZXNHc1TFdiOTF0?=
 =?utf-8?B?b2RFcmd6N3NOV0k2c3BiOGVPUXVqRW1VN05aYU8xRm1HRWQ0eVAzbEJBVzZB?=
 =?utf-8?B?SEdlc3JQTGpBVW8vK3g4TmdsUzdscE5YRGN2OXpqSXZ1bTdaUnA4MjJaZktI?=
 =?utf-8?B?SlNheWFpMjZMdkorODljQ2p5cm9RS29lVjRHS3drVDY3cGM0UHp6WWc1S09u?=
 =?utf-8?B?RVVQV1VkL1BYSHRIejlFdmdyVEZkbW1qc3cxbnp0czc3MVgwbkdyVTJzdGcx?=
 =?utf-8?B?WVN1VldQVVdZTWZXcEFvbHlkMXFyczNVaGZVWXdSa2NBVFRhWnFiUEloWity?=
 =?utf-8?B?TllSdDI3OGFKRnpKSWtobmY3d00zVVlJSC9WVW4zSXhOL1VKbFJxeUdUdjhV?=
 =?utf-8?B?WVhDWnROZVNhdmJUOE80MGhmK0k0bFV6RnNhOU5GTVEzNmlydU1FZWdWZEx0?=
 =?utf-8?B?QjJBYTZNT1RzbVBpUEUyOE9lUUhwbktJYVhIVFBkOVVvaE1vdUlId0daZUFH?=
 =?utf-8?B?Tm5xcUc0dUt6alg2bWI3VHZ1eDdDT1JzWHFDS1JGbTd1NWhrb2QxeHhOMVEz?=
 =?utf-8?B?SU8ySHdQTGRYTVphWUh0WEpTY2s0eUJaKzB2SXZkbnNod3c5UWlIN0FsN1pQ?=
 =?utf-8?B?YVk2M1hGUVAyS1VNMVNpUDFhQk9LZWlHdU9GcFBKelJHQlhiTnFQcXNyQUow?=
 =?utf-8?B?U1dKNGRjODIwbSs4NjFkblc0WHpOaDVZa1BsUlpETlpZUE50RzUyZlVjK2Iy?=
 =?utf-8?B?QXc2eUp4WElkVU9obXNmRjVFbGZHbXJOZkUzY1B6MFptTDdlTDc1VEIzdHJz?=
 =?utf-8?B?QnF1dnA5dC8wMWNLZzhIZ2YrL2w2WGszeng1Q2R4S1RycjMzcUw1T0RqcjY5?=
 =?utf-8?B?YmUwVWhud2lwTUVDZVYwTlFOdWZVaEI2SHU3SUI0SWVFNjBSTkJFblA2ZStL?=
 =?utf-8?B?eXZMc0ZtUVk3RjA5a3NZNEdpKzF4MTEwMWlPUzE5T3llbnlTQUE5QjFmM2ZC?=
 =?utf-8?B?dHRaSzJ3RTJhZEJVYTVQdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUdRRm5qaUwzajFqUVk2cEpKVTFSZmFrSkFNdlNGeHpGcmk3NGJFcEZidUpL?=
 =?utf-8?B?UjVSRjlQS1pxNEg3RGt3YWExRUZqbzdqZkoxTlpUSDdBME1EVjhTN05najVI?=
 =?utf-8?B?UGpzVWt2K1FNYk5DSzM0cFF0MnhvdHNSaU1GM200c1VrNlkxdm16bzYyZ1FX?=
 =?utf-8?B?VUliQk9GbEFDcFJnOTNEZGhESjZkMmcvdHZ0RTJXYWU1VmllS3FOSktTVEpL?=
 =?utf-8?B?NFdLNGwyTXVYVmVWdHEwbkRhenk3U0xWd2tuNmppNmNGNFlrT0Q3bjFqSEZo?=
 =?utf-8?B?c29SSFMxTzh5NFNwWnY1MXF3YUtHSnRsbEhQQ2pyMmZ1NGx2Z2VaNkN3V01R?=
 =?utf-8?B?ekVaTWJxWm9KditxRU4yb1J4dXFDcU9PRlJGMnMyRldNaWt2S0RSeitOeWds?=
 =?utf-8?B?UFdUM1hkUGtsU255ZW1yc3J5MlZIR0Y5b2p4YjEvMEFvR0Zqd2EzVXlVMW14?=
 =?utf-8?B?YjZhMUN6STVEWlBZRm5XOEtiODFKZ2s2ZUhOUmJ4dU9iYTBwZFp0WHFnOUNl?=
 =?utf-8?B?OERhdEk1c2pSYkxXNCt6T29JRjY3NEpFS2xpTXBESG9FcjUrUDU0Y0JxT29Y?=
 =?utf-8?B?dGZpcS9pUjU4NWFxYWVUZGRFNEhPd28yMUFaeS9pNWRibGFIOTBidjFQMi9m?=
 =?utf-8?B?UDV4djNaMzZhRU9rQk1KVU9Vb0UrbzZ5T1RwKzZOMmF1Rm05VE9lOFA5NUR1?=
 =?utf-8?B?OWlqSHd4QXlVVnpxVGtESlpua3J4STdITFM2UHcvd1E3aUhDdmUyMXd3Yy9Q?=
 =?utf-8?B?SmNvVURZK1l5UlBtbW51cmdRZmJha0FZYUJvYzl6dUx3RFVjOTF5TFN4bFdv?=
 =?utf-8?B?T05TNmhlbTBWYjFaWGJZNXNIQ1FjS3pPUEdCVVlXVTZ0bHpjaC9uMjRmT3Za?=
 =?utf-8?B?RVg0QUo2d0VrVFN4MGhXMjJwaDdLV2ZxNzJuTzhKbFhjL3h0Y0ZzdVJoK3NL?=
 =?utf-8?B?NkpuVnExV2hhQ3l5VHlwaEFkQld5ck84cHBzZXJNbkF2ZlNVUEZBaXZ4b3Z2?=
 =?utf-8?B?SEI3S215ZUpSd1JmL0hVOSs2TjBFOWN6TVFDbHNzZGdUNEFvMGw1MVRwK1cw?=
 =?utf-8?B?cUZOTlpwNHNIUjRBa1BUVGdMUks3a3pOY1FaSzNtOFQ3UlVDdk9sZWl5M3I3?=
 =?utf-8?B?SjgrVkNxcXhucUFTR1c1NE1haldzM0JSdlEyRnFIS21ZR3U3Wk1Dc2k3Mkkv?=
 =?utf-8?B?eVFETFZzRmgzWFlrZzZDZTB3SU1WdE5sODRuV1JsQjRERDVPK0NCUmcrc25Z?=
 =?utf-8?B?R2NIRXQxM01FTy83VEpBK2dDVGRzNGxKVUJsTk1Ca1dvR0wxT0lGemtQZVNL?=
 =?utf-8?B?YjRicit3N1lpZGhSdHppTXYxZ2s3NVNjb3N1MGxwVFhjb2JSR0RIQ3ZBTGta?=
 =?utf-8?B?TEEvTW5pZG1TY2sxaGgxcml0ZW9UeUFVajdHZlluR2F0bVl4ZS9sSDFvNEFG?=
 =?utf-8?B?OEY4TjZCTExvdmQ1UWI0aFM5ZGtwOHdTc0lIUlREcHNRQjZ1RVg4TFY5Wmxu?=
 =?utf-8?B?ZXVVS0huSTkxSmFyWEMyemhjTVFPUG1CYXdJYWdndWZiZFVoMmJpVjlLbWsw?=
 =?utf-8?B?WXkycEltUFRqQ2hIVmovcjNrQWs3elhNcDFLbkdyRXk2SWNlak9jUUxIUHg5?=
 =?utf-8?B?ZHN2aHRNN1cwYjFzTCtyMnNGd1c4T0hMT0JFenRTU0tKWWo1bGEvTDBLeE12?=
 =?utf-8?B?Sml2M1NMOFdta2xmOGJ6YnhGTGlzZFVEL3E4VE1UZkhWUVFDUndDNW96V1N1?=
 =?utf-8?B?aGQxd2xIU2lXUDdSSTM3KzhPVUdPL3NRV0l2bWhLaU5wZXk0QTcwUGlVZlor?=
 =?utf-8?B?bUlydWVCSTVGTHArMTRkWGNUL1d2VkN4TlBEU3FzS1lyU2hnSVRWclIwVFlE?=
 =?utf-8?B?YkFWTDlRelMzMllXUnJXaG50OHZKQ3ZpSHpNV3laRUdGelBYNlErOVJpU3lu?=
 =?utf-8?B?NExxWmhwUXhuNTdOMlVlTjNTVDAyamx4YWdLUWxyYkhERkcwR2Mvbk4wRysy?=
 =?utf-8?B?cm4yRkdZYlhqeEJGckxGK3BkY1hEbFBZT0w3cThoOTRRRksrSDNMUHNKTzUy?=
 =?utf-8?B?N2hlelQ0QjNscEdZdXowNTJNam5EaENmQnA5L0Znam9jaE5EeGhCVlB5VTRI?=
 =?utf-8?Q?98Hc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b33bd199-09ab-4456-2e1e-08dc6b2fd296
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 05:13:51.9926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovwcMK5Cw9FizA9l8VG/ogvoBUxtB2zE0QELnUYsmdU4TvB2p5btXrxJSCRSL7G6L6CRi4rsiW4NZ+ZB2fmYmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KQXBwcmVjaWF0ZSB5b3VyIGNvbW1lbnRzLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+
DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMiwgMjAyNCAxMToyNCBBTQ0KPiBUbzogSywgS2lyYW4g
PGtpcmFuLmtAaW50ZWwuY29tPg0KPiBDYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9y
ZzsgU3JpdmF0c2EsIFJhdmlzaGFua2FyDQo+IDxyYXZpc2hhbmthci5zcml2YXRzYUBpbnRlbC5j
b20+OyBUdW1rdXIgTmFyYXlhbiwgQ2hldGhhbg0KPiA8Y2hldGhhbi50dW1rdXIubmFyYXlhbkBp
bnRlbC5jb20+OyBEZXZlZ293ZGEsIENoYW5kcmFzaGVrYXINCj4gPGNoYW5kcmFzaGVrYXIuZGV2
ZWdvd2RhQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzJdIEJsdWV0b290
aDogYnRpbnRlbDogQWRkIHN1cHBvcnQgZm9yIEJsYXphckkNCj4gDQo+IERlYXIgS2lyYW4sDQo+
IA0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLg0KPiANCj4gQW0gMDIuMDUuMjQgdW0g
MDc6MjMgc2NocmllYiBLaXJhbiBLOg0KPiA+IEFkZCBzdXBwb3J0IGZvciBCbGF6YXJJIChjbnZp
KSBibHVldG9vdGggY29yZS4NCj4gDQo+IEl04oCZZCBiZSBncmVhdCBpZiB5b3UgZG9jdW1lbnRl
ZCB0aGUgZGF0YXNoZWV0IG5hbWUgYW5kIHJldmlzaW9uLg0KSSBhbSBhZnJhaWQgdG8gcHJvdmlk
ZSB0aGVzZSBkZXRhaWxzIGFzIHRoZXNlIGRhdGEgaXMgaW50ZXJuYWwuIA0KPiANCj4gQWxzbywg
aXTigJlkIGhlbHAgcGVvcGxlIHJlYWRpbmcgdGhlIGRpZmYsIGlmIHlvdSBhZGRlZCB3aGF0IHRo
ZSBzdXBwb3J0IGVudGFpbHMuDQo+IEluIHRoaXMgY2FzZSBhIG5vdGUsIHRoYXQgaXTigJlzIGEg
4oCcc3RhbmRhcmQgZGV2aWNl4oCdIGFuZCBvbmx5IHRoZSBuZXcgaWQgbmVlZHMgdG8NCj4gYmUg
YWRkZWQsIHdvdWxkIGJlIG5pY2UuDQoNCkFjay4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogS2ly
YW4gSyA8a2lyYW4ua0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2JsdWV0b290
aC9idGludGVsLmMgfCAzICsrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyBiL2Ry
aXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPiA+IGluZGV4IGRjNDgzNTIxNjZhNS4uNGY0YmQ1
NTM4YjZlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPiA+IEBAIC00ODEsNiArNDgxLDcg
QEAgc3RhdGljIGludCBidGludGVsX3ZlcnNpb25faW5mb190bHYoc3RydWN0IGhjaV9kZXYNCj4g
KmhkZXYsDQo+ID4gICAJY2FzZSAweDE5OgkvKiBTbHItRiAqLw0KPiA+ICAgCWNhc2UgMHgxYjog
ICAgICAvKiBNZ3IgKi8NCj4gPiAgIAljYXNlIDB4MWM6CS8qIEdhbGUgUGVhayAoR2FQKSAqLw0K
PiA+ICsJY2FzZSAweDFlOgkvKiBCbGF6YXJJIChCenIpICovDQo+ID4gICAJCWJyZWFrOw0KPiA+
ICAgCWRlZmF1bHQ6DQo+ID4gICAJCWJ0X2Rldl9lcnIoaGRldiwgIlVuc3VwcG9ydGVkIEludGVs
IGhhcmR3YXJlIHZhcmlhbnQNCj4gKDB4JXgpIiwgQEANCj4gPiAtMjY5OCw2ICsyNjk5LDcgQEAg
c3RhdGljIHZvaWQgYnRpbnRlbF9zZXRfbXNmdF9vcGNvZGUoc3RydWN0IGhjaV9kZXYNCj4gKmhk
ZXYsIHU4IGh3X3ZhcmlhbnQpDQo+ID4gICAJY2FzZSAweDE5Og0KPiA+ICAgCWNhc2UgMHgxYjoN
Cj4gPiAgIAljYXNlIDB4MWM6DQo+ID4gKwljYXNlIDB4MWU6DQo+ID4gICAJCWhjaV9zZXRfbXNm
dF9vcGNvZGUoaGRldiwgMHhGQzFFKTsNCj4gPiAgIAkJYnJlYWs7DQo+ID4gICAJZGVmYXVsdDoN
Cj4gPiBAQCAtMzAzNyw2ICszMDM5LDcgQEAgc3RhdGljIGludCBidGludGVsX3NldHVwX2NvbWJp
bmVkKHN0cnVjdCBoY2lfZGV2DQo+ICpoZGV2KQ0KPiA+ICAgCWNhc2UgMHgxOToNCj4gPiAgIAlj
YXNlIDB4MWI6DQo+ID4gICAJY2FzZSAweDFjOg0KPiA+ICsJY2FzZSAweDFlOg0KPiA+ICAgCQkv
KiBEaXNwbGF5IHZlcnNpb24gaW5mb3JtYXRpb24gb2YgVExWIHR5cGUgKi8NCj4gPiAgIAkJYnRp
bnRlbF92ZXJzaW9uX2luZm9fdGx2KGhkZXYsICZ2ZXJfdGx2KTsNCj4gDQo+IA0KPiBLaW5kIHJl
Z2FyZHMsDQo+IA0KPiBQYXVsDQoNClRoYW5rcywNCktpcmFuDQoNCg==
