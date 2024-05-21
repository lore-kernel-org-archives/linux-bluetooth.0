Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844F7F
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 00:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716250309; cv=fail; b=V3xmT/OzpKOwqhylGGppYuek9vwshPP6IrFmuPpQl6zrUlxmgR1/3KSWCzXDpWfuO2e9rzAV6S+6epfJg/79BMFPrOpOybjzF4f9UAFLM7EV7LlRQ9OCnR1lfzstXJne2CXzPcXLy14ISBajaVQ1F7nsMZH4Gq5F/9qJIJ9aDPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716250309; c=relaxed/simple;
	bh=+rWoKCTobFsUTtxYNPZB48InERH6esfPfEy/2Rvos4c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=anNH1TFLc2phwnDhQLfuNdjLxLOTxL9EnU3rRZw3YwimUuPCMAXLrML1feGek5h0ibOPkSWK1ZqD1pyFLFJoGxThtv1nZNvGp/dS8dryqtK0ijCfMFjj8Cu+K7QuqNO4PEL1E7J2jncrEFQS8gRpS0wiRLBAbUkhPK0pxeUks8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X09RYZxL; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X09RYZxL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716250307; x=1747786307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+rWoKCTobFsUTtxYNPZB48InERH6esfPfEy/2Rvos4c=;
  b=X09RYZxLpoKtrl51Hv2QbNsV3SANFL4yibLQIp01nrL8qdxz8vVwD8au
   ZjXD+2uxP1URs3/b8Oeus5CCxCr9UPP7981tNd9yCihG0bxw2wJ7QhIvs
   UYtDJYz0SlI6Tfjud+RtMIPCozdkv22e5c2EiHIVf5jYMbMyDCJP7tp5O
   B1awwTGVkXxq8ASC8yYHr5nQaz90dhjbZLnskJwbRCA+hNsSrLCb8bvBi
   pcX4t4hrJrMtanv6ax96QA07NRNC/XIilL7UEqcqFjBYnwqYfLN/Z4ZxK
   RCm0kF8Q2rW+T1vjITScZ7cElcDDyBYadNDGk4juLkF/jr0mUTC4k7UgY
   A==;
X-CSE-ConnectionGUID: klJj1orFTOmacfgoWChldg==
X-CSE-MsgGUID: YyrLNy7UQ8q8Dha3g6P0VA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="37792832"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="37792832"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 17:11:46 -0700
X-CSE-ConnectionGUID: HQY/cuGuT8m/T0lACbdkPA==
X-CSE-MsgGUID: pvX3tvDBSAeRKE0To5qohA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="37550631"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 May 2024 17:11:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 17:11:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 17:11:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 17:11:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 17:11:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq9RF131a5CbkmDCK5BcrWuK1+CrJFVpaxbss42HYHx7k7Ea5zxnjk2WVcfAxlGJA7scKUjvh7vSr/AvbgyOHPupfeEmc9LTBSjJZAxr36px5SRDNSjjvhYvNpztPeqAtGDFhRMUATERQ3877fhvVZKa3Qj4IPruN9xN/QGvJ17a5r/bFwS3umUa9j/UjHpECL5z+E7Ct/t7jSDh4raSpuXAQmDct6K7KvZsrwGEB86WrEoLmIPPMkA3xHoF0CwufoKBroODkqzFkbK8JKWes+96QEPcP59mUmtHmVQEh3Hm1F4pyECHyF8Zcnhq3ocxuWg2o0ZRezXBmhqoxokNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rWoKCTobFsUTtxYNPZB48InERH6esfPfEy/2Rvos4c=;
 b=IPHHQAUo3zl65RDI+HOOv3D8WcaBucjCRSjSLQW6ZlEC7L/GiWWVRaN3x1+dIqHneuYTeCzi/QM2fZdeSZGKDaJNyJi+waf2q4ODArSkmrtHmUgnezoCgGtoI2NolzOUgM7ozP4kNJhWnZIeEKvjCFIrjIQ5ibY5H4k91xueZkiyIJeqSJ0YzmJvn8uGPQfCWY4/Efny/BJ9Nu5FpfVUTdb3XrtizGCPi0ivvieiTU2+Ce+ISCnVklnYnCkk/M9X+5PSRQb1H4vTcygAgnJ3OrJb0Hnjvi/pkkUTJ1shZu/iY5fT8Ile3TTA3btUSCpZnXF/kn1DmJB/Wgm0+gvluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by SJ1PR11MB6107.namprd11.prod.outlook.com (2603:10b6:a03:48a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 00:11:44 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 00:11:44 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, "Satija, Vijay"
	<vijay.satija@intel.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] Bluetooth: btintel_pcie: Fix irq leak
Thread-Topic: [PATCH v3 2/3] Bluetooth: btintel_pcie: Fix irq leak
Thread-Index: AQHaqD5He6a5mU6v0kyUvsO0lbpeu7GbNNmAgAWg/QA=
Date: Tue, 21 May 2024 00:11:44 +0000
Message-ID: <PH0PR11MB7585CD2566317187A18090E6F5EA2@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240517095447.956132-1-kiran.k@intel.com>
 <20240517095447.956132-2-kiran.k@intel.com>
 <69ebe55f-0c2a-472a-bb4c-17731e48bffe@molgen.mpg.de>
In-Reply-To: <69ebe55f-0c2a-472a-bb4c-17731e48bffe@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|SJ1PR11MB6107:EE_
x-ms-office365-filtering-correlation-id: 3d94c409-95b5-496c-ca30-08dc792a98fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?M0FKMzZnM3d5ekg2TWhxNXJZWG13VGJKQU1oQUxMQ0d4dllBQlUxOHpQa3Bw?=
 =?utf-8?B?em1pRWVNVTh1L0xXRkVCVjFDcWxZV1p6SlNOWFRVd2VvV0NhcHg4T1NGaGRk?=
 =?utf-8?B?SnExRCtZcmJ4d3JLQmY4eHdOV3BscFQ4YVllVFVUUkNEVEowMTBHcGFHc0du?=
 =?utf-8?B?LzhDeEtMbWhFUlVEUG9VOUJZQXhjSUtVaHNCVXlMWUIrdFF0U1RtVFF4RDV0?=
 =?utf-8?B?QlZkbS8rWVRqcHZrT0pjMVcva0JXTXRGSFZSdCtxdUtsSlN2ZmJGc00xcENK?=
 =?utf-8?B?RVNhb2xnV243NitmWEVPUDI0dVpoUUJnekR6UWU0SlovNmFtaDJMeCtRT3VG?=
 =?utf-8?B?TmdxVHp0azdpc25tTEVSTndnSlV1SnVzSUZEc3FOSlpRN0VwUVl3L256QUZv?=
 =?utf-8?B?c2UxNTJKT3A3R1hNQXd1Y2JDQ2xtSHg5TGcrWUs0ZkttUTJwMnJXT0lQTDlU?=
 =?utf-8?B?UTU1VnJWS1QvUSszSGpsUE1qSnBEYXhBaVpOUWdlTXdBKzdYSC95Vm9ncHNM?=
 =?utf-8?B?NndiaWpIeHJTaW11c1QwTDVFa1BIa1RoR2pFTW8rc1VzUmsycFNBV3ltd0Z6?=
 =?utf-8?B?cDluSndZQXBabzZpaDdNS01CR01NTU1BL2liQnpVN09teEF5Z0NpUmFKdU5i?=
 =?utf-8?B?S3h0ZHdnQ20zUDh6RlBHYmdOMFRxbGJoN3RvVXE3bHRzYjEwREYxNjUvNlBs?=
 =?utf-8?B?eU5VQ011SUM3RHhvSkdKS2M1aTAvRWVoK2pDTVI3cmJ5MCtXNU5tbFhTV2Z1?=
 =?utf-8?B?TktCaUR5OEFwUTZaT1JRRFAwZnNnNldYY1VyTGhiOWYyRy8vNUpSUW94TkJU?=
 =?utf-8?B?TDZaMW9DSnB2R3Q1WWR1RGNrSnlrakFUS0ZrT2IwS08wN3JpMXlCQ2ptRHgz?=
 =?utf-8?B?TkZKN1MreFhlMm1wYzdVR0VCZ1VRVEZ0SkZJcmVSd25NcjVibTNUeldqbUhT?=
 =?utf-8?B?dzUwNzlESDhuTkZnOHdNdTBRRFdlTjFFMHI5L3d1RjY2VUI1RHRQbEp6QlZ6?=
 =?utf-8?B?NGEwdERqczJUTEp2NWthSjlYWW9JZmNDdFlNRitzVjRtVXFtUTI4MUxEdU0y?=
 =?utf-8?B?cGF4L3c4bjF2UWhXSHF6cDhsRnVqQ00rTDJpOE9tZHFMak9PaFpuZlNBeVJ3?=
 =?utf-8?B?aFlCQ0tpLzRzcGlOUUFVZ3p0SjVuaHNZRWhackR1a1RBU01naVR2Tk51b3V1?=
 =?utf-8?B?N0hnUTlDaEo2Y1RxcXVPcFMxTmYvVUNqRE5oRzN1TG5ZY21Kai9UbCsxL05J?=
 =?utf-8?B?blVBcjR1RkNTdk5qZEEyVFVueCt1ZGVnSTZoekR1dCs2RjNHUkMzWldFMzJk?=
 =?utf-8?B?SFlrZHN4OEhQRHQxRWJiNmt0UTl3QWxpWVlTTFc3SUJpUU9YTnIvSlZKbk9i?=
 =?utf-8?B?UDdkUThIV1dMY1hkTC93UjFrS0NQdVQ0ZkJINy8xenlpbHVWSGROdmhSZkpC?=
 =?utf-8?B?SXcyYWhRZUpFTWh2b1doNmhTV1oyWmhjNUZFdVBOcFEwbm4rTEROMGt2dXJL?=
 =?utf-8?B?UHRCdE91VzRxeis0bnk5azdvUmhkRm5iNCt6bVRaR0hJK1RERDFWVVg0RC8y?=
 =?utf-8?B?SFZoTjJFSWNvVThEVXdtc3dJeHZYTG00Q05ST0ozVW9ZdWtrWmZRN0xRU0dS?=
 =?utf-8?B?Wnh6bWxBY05NcUh1bkZuMVZyRk9yWU5MWHpxaWZnR3pNbjh2SFNKMUNUYUZJ?=
 =?utf-8?B?ZWlxOXhsREhSSzNZWkJtcGw0bitSWlpSVGlIcjNvVFVVeThZeGlRUUt3MGIy?=
 =?utf-8?B?cUZ1N0E1V0ZCaWJNWHhIZjdLV3o5NWRZb1BRQ1R1b0FCUE5PTUIxREp0RFVQ?=
 =?utf-8?B?cDZtVzEwSnRoOFhCdy9idz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0NiTVhxNzBwVzFLdjdWUzNubUVtVXBmeTdrRmp5dmxpOG9sdEhxMnVEUTdW?=
 =?utf-8?B?QkViZVBjTlp4ME03b0N2MmQ3ZTY0bVkzeDVXRnZ0MjhjTGtLalB5bWx2WXRi?=
 =?utf-8?B?ZWZqY0tNS0JSQmtBT2d5R09PM3ZOTUpSbnRmR2owOXFXcHNMeklybG9mSFp0?=
 =?utf-8?B?eUk5azhLdFVhN3hvMGM3anpBbVNnU3VacDF0d1RybVhzNXo5L1lMTi9scDh2?=
 =?utf-8?B?Vy9DNmNJTW9pMnp1S0I5cVYydnhBU2FIYWNoM0plYjRTeU1tOUNzcDRtcklq?=
 =?utf-8?B?MEJRNkNsVTBNdU5vME5nY2dDZTIxVXVlL2NjblIyNG1ERWljRzgzM1ZENDBo?=
 =?utf-8?B?UWRsS3RvcmJWeEdDT0JZdGhTMEtIS0cxbmx0d3NQd3FBUVh0S3REUXl4elFz?=
 =?utf-8?B?NGRlTVJCM1NmR2ZVT3hhYXNLNGM5TG1YVzBlUndpMnlTUi8xc3piR2lOd25T?=
 =?utf-8?B?bW0xQnJFMjRGSEhMU0pUeHN1UU00V3ZtcjNEVEtlcXR2UHRIMyt0Ny9oS0Vx?=
 =?utf-8?B?SUdMZFRrV2x6UisvUG9iTm5jUW1ZbkwyM21lb3VyNFAvSDNFaW1rakJLZHFt?=
 =?utf-8?B?R3M4TVphNHZ5K2E2a3dzNUZPL3hDNC9YMnhhbk9MTEhqcHc5RlpGV2k2SFFj?=
 =?utf-8?B?R2MrbFE0dHEwTUFhbENzMjU1dHVubW9sV2VpTVJLVkQzaHlHMktrNkwxc1JS?=
 =?utf-8?B?OERrS1lYRHlEekVIUkdIRHgxQjB6RmN1MW1SMnBGbGd1RmQ5ZGJaYmFiV2Vr?=
 =?utf-8?B?R3ZtTFVOOThmTldtVFZ5dzZnS3cwTExiY3dIamJnZGhWakllZFhVbDlQWFRE?=
 =?utf-8?B?QndnVFR3RnBzbCtObzc0NWlJQUtMZU9FOVg2T2tNd1FKcHZNd21uVVk0d0Nn?=
 =?utf-8?B?bmQ2Q2hiQkxSdDBnVzl4TTdEam44RE8rNjM3Y2IrN1hmc0xaakVuRWNwclJV?=
 =?utf-8?B?YVVrRFEyOGRGVktqZERQcUprclVnM1JsandRSWkrcDQ1N0RlaVNWLzZIRENK?=
 =?utf-8?B?MEJUODl6eXpmOFlCNEpHd05POTI0MnBKeG9OK3E1YlZmU1BRaE5NS2NYMDlO?=
 =?utf-8?B?bW9jb1dYd0dxck01T00xSVNydlhsOUFkekZqZlNMaDk1WVhmNFNlR1IySXV2?=
 =?utf-8?B?dUFMN0ljWGJFWUlMSGVHQ1JNS3huYnZiSjBjNU5qSEZlUGYwVFZvemw3VnhO?=
 =?utf-8?B?c1hRZnFrMDNZRUNQZHZpRHd3amswZ2hXdjVoTHJSejVZZy84OHdJODNXdTB2?=
 =?utf-8?B?K1gxcXJzS0h1TFV4WFpqM2xuczRzT0IwaXY1K0pXVUtOeVFXQ1pVcFl0Q1M5?=
 =?utf-8?B?V0RKTWhadVpUaGRUNHNWc3lhYmt6aGdDbkd4NUJMTjVQRHNjV0NURWdUNHMy?=
 =?utf-8?B?c3AxbGtyY1drbzZGNjRzQWM3NzdrNFJoVjYzWkR4UDdIQ1RqdWEzdkVHZzdj?=
 =?utf-8?B?emRuejNXVk8xZWd1RmZUZDVpcjkxQ1ljUFZtcjVnUDJxY3VJRXlvOHcwZU1j?=
 =?utf-8?B?OGJuc3NQeVhJQWpjalFEbjNRUW5pU1NHeTNzSmpFa0V5NDM3c2FpRHI3UytC?=
 =?utf-8?B?MmtXZWtsckM1Vjg5cTArSFZaSEp1N2Z6MStqbkJZRlk1ZG05TXJNaVNPakdU?=
 =?utf-8?B?RERwRDFWQkFxZFpPei9zMHhCanBiMjBOYk82aEhWOTF0SjJuaVF2bC9EZ0hv?=
 =?utf-8?B?WVlKVkQydm9INk03RXdLaUluMmVOb1Vic29MRFE3aWFsTURQalZXL3laTE5V?=
 =?utf-8?B?eTJjSVk4Qm9xaTJpQXNodTVFTXNmZWZQSEZJRk5ud2ZUZmhvN1hMeDg4L21C?=
 =?utf-8?B?b0ZKL1FiM2tNS2JmK21PN1dKVEZnZEZYUmY1RVdUV3FDVVVGcC9NWEZOREZE?=
 =?utf-8?B?ejhZcU5kTmJVVllFYkNSUjVqN25wZlpyK0hhQzRPRWdLVzY0U2N6ZFNxODZp?=
 =?utf-8?B?OXlmRGU1a0h1bCtIeXJQL2I0cTBaeVhEQVBnbk5kRlZjYkdjYWFOM255VVhu?=
 =?utf-8?B?SSsrbFlIcmFLcUZkcDVHOE84MXNoZmpFSldjeGozeWFHcG5YLzM2dzhjK1Qz?=
 =?utf-8?B?dkdhakVGaDAwVGxPK1RPK2kvMEhhZHR2aGI1RC9vNWNvYi9qRDZBclkyWEJV?=
 =?utf-8?Q?/JYM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d94c409-95b5-496c-ca30-08dc792a98fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 00:11:44.1893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETp3bp5tEcg89kfhb32cQUgc2S0BU/Dpb9kEztkcaK5+r5aoXhzmdj99zJX9rFGgrtbn+y6vTlcg86gpIW8fmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6107
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+LS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj5Gcm9tOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0K
PlNlbnQ6IEZyaWRheSwgTWF5IDE3LCAyMDI0IDM6NDIgUE0NCj5UbzogSywgS2lyYW4gPGtpcmFu
LmtAaW50ZWwuY29tPg0KPkNjOiBTcml2YXRzYSwgUmF2aXNoYW5rYXIgPHJhdmlzaGFua2FyLnNy
aXZhdHNhQGludGVsLmNvbT47IFR1bWt1ciBOYXJheWFuLA0KPkNoZXRoYW4gPGNoZXRoYW4udHVt
a3VyLm5hcmF5YW5AaW50ZWwuY29tPjsgRGV2ZWdvd2RhLCBDaGFuZHJhc2hla2FyDQo+PGNoYW5k
cmFzaGVrYXIuZGV2ZWdvd2RhQGludGVsLmNvbT47IFNhdGlqYSwgVmlqYXkgPHZpamF5LnNhdGlq
YUBpbnRlbC5jb20+Ow0KPmxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0
OiBSZTogW1BBVENIIHYzIDIvM10gQmx1ZXRvb3RoOiBidGludGVsX3BjaWU6IEZpeCBpcnEgbGVh
aw0KPg0KPkRlYXIgS2lyYW4sDQo+DQo+DQo+VGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLg0KPg0K
PkFtIDE3LjA1LjI0IHVtIDExOjU0IHNjaHJpZWIgS2lyYW4gSzoNCj4+IEZyZWUgaXJxIGJlZm9y
ZSByZWxlYXNpbmcgaXJxIHZlY3Rvci4NCj4NCj5DYW4gdGhlIGxlYWsgYmUgZGV0ZWN0ZWQgc29t
ZWhvdz8gSG93IGRpZCB5b3UgZGV0ZWN0IGl0Pw0KDQpkbWVzZyBzaG93cyB0cmFjZXMgYWJvdXQg
aXJxIGxlYWsgd2hlbiB0aGUgZHJpdmVyIGlzIHVubG9hZGVkLg0KIA0KPg0KPj4gRml4ZXM6IGMy
YjYzNmIzZjc4OCAoIkJsdWV0b290aDogYnRpbnRlbF9wY2llOiBBZGQgc3VwcG9ydCBmb3IgUENJ
ZQ0KPnRyYW5zcG9ydCIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBLaXJhbiA8a2lyYW4ua0BpbnRlbC5j
b20+DQo+DQo+SnVzdCBhIG5vdGUsIHRoYXQgeW91ciBzdXJuYW1lIGlzIG1pc3NpbmcgdG9vLg0K
QWNrLg0KDQo+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMg
fCA2ICsrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jIGIvZHJpdmVycy9i
bHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+IGluZGV4IDhkMjgyZWUyMzIyYy4uZDhmODJlMGY2
NDM1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+
ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBAQCAtMTMyOSw2ICsx
MzI5LDEyIEBAIHN0YXRpYyB2b2lkIGJ0aW50ZWxfcGNpZV9yZW1vdmUoc3RydWN0IHBjaV9kZXYN
Cj4qcGRldikNCj4+ICAgCWRhdGEgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7DQo+Pg0KPj4gICAJ
YnRpbnRlbF9wY2llX3Jlc2V0X2J0KGRhdGEpOw0KPj4gKwlmb3IgKGludCBpID0gMDsgaSA8IGRh
dGEtPmFsbG9jX3ZlY3M7IGkrKykgew0KPj4gKwkJc3RydWN0IG1zaXhfZW50cnkgKm1zaXhfZW50
cnk7DQo+PiArDQo+PiArCQltc2l4X2VudHJ5ID0gJmRhdGEtPm1zaXhfZW50cmllc1tpXTsNCj4+
ICsJCWZyZWVfaXJxKG1zaXhfZW50cnktPnZlY3RvciwgbXNpeF9lbnRyeSk7DQo+PiArCX0NCj4+
DQo+PiAgIAlwY2lfZnJlZV9pcnFfdmVjdG9ycyhwZGV2KTsNCj4NCj4NCj5LaW5kIHJlZ2FyZHMs
DQo+DQo+UGF1bA0K
