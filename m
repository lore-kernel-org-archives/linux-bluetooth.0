Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023121.outbound.protection.outlook.com [52.101.127.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD403644BE
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768980446; cv=fail; b=UZTmLTm4rc65k6OlJiLoTvnYVwY23cmeZAJL89FTjJR1sqGuhleBNVZiXusZ1qY8+WxO1niEPFj1bjeNcoCJdDx5WWYoQd+yTmPOB7U80JpwkUIBulELUTji/8Bgk0EOA3x4VA/YIYXtAf9UnCojs4bhvA/MSB79SAUyOwr3aVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768980446; c=relaxed/simple;
	bh=mYlRBZACsMm/hONtPJm0wU05xkE3NoOY83eULJ198Qc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FGt3Sd9/hcLOSjg8hCf0hRJQiMZZOpoEmSuwxIYA/X9LsIsmH8VpTxZREO7azaL0Y+PpRh+sa5cGWxHiPx2obH5yZ4u70sbh4rXRUdwKUBSmOEv1VLwnqvNiqbQcvaeazBQ0yfOcb9hJU8LtGvQdk+Zb5cC0v6P7luScXe2foKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Gb3VY7hj; arc=fail smtp.client-ip=52.101.127.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Gb3VY7hj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOZA/p7C8rfIhU0dEFsstUVVzZ/Rm4xAsVVxLMT3kZZ+SA2Rc9x3a2QXHWDUYpt+42TS21/s9ZeTlM2mRHZP0WrRomlgc1ZZ5VQ9L+9qDiLV2hHNU26l6+FAW/xjzWFM/+AYULX6z2uA1ys7F1JLvdSYNpP+2gSmIkfhQSKxVXHoLubEIVOJlxUXqYdAY5tzV1dSzK5dB0JjdKv9m3QZyIjxwT98SrMBLiIzNgJv77kbWuaTvBRHACzFVXSFZGpuDDD0iyvk3IfJFzes+AyTJLpUsji+/4yJCTIkqN25whe8sBaoZik823yTFmcYhmrqI2UFWg+FJOVwZujY/bg8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDGVIAlCQn8xnyU8MgyYqs2pWj8l6yeTPbF4+nd9zHg=;
 b=VznjwA7riR0QdaHDm/5JrA+1SZiysYou29VAwsy1jKvqk31wpd5K5VXzChegJv7vhskoItfThGjZ5DUYFuWZofW3vRhKhbbEdeDoyNaNbI89+Mu3+x/Gexy+b/31/sf1EIfVrr6YIhzR1MtFTk3/pGEaEeSI/f/QbTq0VjUo7R5zWR7UtHl3Kv353isbjgxgo6XGYQNhOR1sQLppPwUHm0PbyKFeRVdZcTzYEj85q1TfINPe8ggAz8vRnyRhL+TBHdDFnXpM8kwz+Fh4tNCAvrGwctHueSAXHuDSM8yQ9mov5HDBAkYdFdfpXzudlF23VsXn00VI9yeb7lia+Eenqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDGVIAlCQn8xnyU8MgyYqs2pWj8l6yeTPbF4+nd9zHg=;
 b=Gb3VY7hjVwH2OH2O1wcwaZ4XeI46uddbT4HjPi8Pdr/JTbk36JHhf6tdxlPO17l5MbkCcmKpYgeVpZB07+ucMBj0osva6L3vJIe017r5YpE/nbygkxhANHrvtUL5X9Q0nz6ydIYiYzpABHCeMPSW0y/vOgCqNATqcQl4UEvNL9f0Wc5q6Vt39TtmFv5AE9e+Cc5UMI28PA4pL0HpPksKnuzDV9xWqfzLBUFqmxqb/G7cv/kukhbXFyU6Ftse3fAnogMOfbTgL4nmmYgg0TeXUGo/c6LDtCUs24VgNA4kLNLzvxZ7Nfpf6jjVKkrxeimL7SII5+yXkVLzzHcPXza0tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEZPR03MB8266.apcprd03.prod.outlook.com (2603:1096:101:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 07:27:21 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::eef5:1228:beac:be69]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::eef5:1228:beac:be69%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 07:27:21 +0000
Message-ID: <9f107c06-123a-468c-886e-4135a08595e2@amlogic.com>
Date: Wed, 21 Jan 2026 15:26:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ bluez] bap: reduce ISO sync timeout to 2s
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20260112-iso_sync_timeout-v1-1-9a3e99259a3f@amlogic.com>
 <CABBYNZ+xrCofAHqVOs4SDn3avXQenNbv4L-sys6_2Lf9PAXFOg@mail.gmail.com>
 <7a1da200-d909-4795-9f64-e7c86d53e0c0@amlogic.com>
 <CABBYNZJgA-i7OFTSgJ=EJLRLR-B7CGSZL0+VfBuVXMoDpxVNGA@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZJgA-i7OFTSgJ=EJLRLR-B7CGSZL0+VfBuVXMoDpxVNGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEZPR03MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f22cc3-e2c6-427b-7ac9-08de58be83c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTgzOVFwcUlUaHNnSFNHU216Zm11L3hLOVBUVGovWDBHRFRaZ1F3cnZzZC9O?=
 =?utf-8?B?a3JOVFIrMmpmSE1seW5jZm1jLy9nNkFuVHd1Y2RUUzVQY2E1Q3FWbnYrdkxy?=
 =?utf-8?B?eGF5a2RFaWZKNnpqQmU2U1pObzRqWEgybXJQTUVCR2pvc2hKZkRNamRxVUtF?=
 =?utf-8?B?OGtrZXo3QmhDZzR2M3hRNFF4OE9JdG9Ub0pYK09MMkwvcmhJVjA5TlVBTTU0?=
 =?utf-8?B?a3V3Yitia3RJQ29ndDFSNnFleGFTRlNRcDFGVkV2Z2xlTm81TW15VEtqQzZ3?=
 =?utf-8?B?clVleFNNdmxQdUlGamxlK3NTRm5ZZS9SL0UxVlE0ZUI2OXU2R25uVTlKWnpE?=
 =?utf-8?B?d3J4Z3RMY0dQb3NmeVB6Y0hwRkhlZVcrVGFGRTZQRHdoMGVXSGtsdndCanlB?=
 =?utf-8?B?azhjb2k0UWx6cFNOdmVKOUJSNVU0NllLMzh6VUxNUHdodk5oVCtwRGJFaUdY?=
 =?utf-8?B?aUs4R0VaNWs4TGl3a2g2THZwcmhNbXFwZVZoOGxzM0U4YjBoMXVNaGc4b3di?=
 =?utf-8?B?TkFUbUpkYU91TXZ4MHhEVGpBRzJWZEd2LzVCVG0yMEFoSkVyVXVzZllHdy8r?=
 =?utf-8?B?TGc5OHVGanhQNjNHYU01YnhUNGU5Wm5yS3J6ZFBraVpVUlJZMUNnRy9iR3RM?=
 =?utf-8?B?RFkwZ1FsWVhSL3hCQnRSWjN2b0loM3EvTEl2ZGErTTJEL05VL2ZGNG1nb3Vj?=
 =?utf-8?B?YW0waGVna0Jiem8rTU5sN3ovUXFWeklrZTd0L25HODJIQS8zTm1Ec21BSkhZ?=
 =?utf-8?B?MFEvVTZWYlRDcU5jMW5TWjNIWXIwZVpCTTNVa1B2cmtCVWFyckZGUDZlZ1h2?=
 =?utf-8?B?MXVNNXdaa2xYR203emxlZUc5VEc0bTlTVUU0WE9aeC9lYzVyaU0wczhBdXln?=
 =?utf-8?B?NmhOUzJFTWpqNit2Y3paei9sVC81dFg5UVd6OWQ4NC9kWWpndlF0RTcxNlVF?=
 =?utf-8?B?dFJ5c3BFQzlhc3dXYlU5RzZNandCbEh5bWRLUXFTTWR5U0hZTjJxQ3dWVjMy?=
 =?utf-8?B?MXhrbDBhZkV3VmducUd6OTVPZDNhT2JSSXQ0QktYRHVhYUY5MHJZWHMrUFdM?=
 =?utf-8?B?TitoTVBXQ3JMcy9GTnVqaFp0QWl6UHdCREhVZUZ2N21SdG1GMWIzcSsyUGJw?=
 =?utf-8?B?YUF2ejVXbGd0cmUrWVp5cEdkOWFpUDF3cno4WEJxRytqRW9pc1VWWmN2Q1FJ?=
 =?utf-8?B?dzR6cVgzMzNLbnNhNFV3cTcyWmlxLzFMMmRrSC9nNzdvbjdYOXpvVkd0TUxI?=
 =?utf-8?B?Q3JLYzYzWGFyRjNrcWR5a250ZkdUZ3lyNXJrQlpmcnY4ajFEQjI0U3N3S3px?=
 =?utf-8?B?dGZCaWVIc1VwaFpVcUtxaFVxWG0vbGF4RHI1MGVzd0IwNmFLKzdPdldjR25B?=
 =?utf-8?B?b21OUnoyN3EraEVYT0d6a3A4QjZDQmFqUW5zRE1Fb2JKYmVGQW5BRkx5VmFK?=
 =?utf-8?B?MHhzQ05KTFJuaGdrbjN1ZzFBcGVFQ2YvL2JoM1k5Y2JtNk1ZTkhJOUFoTkdT?=
 =?utf-8?B?eDBEaEhBM1ZmT1FoOVBEaHpBZi91OW1UOE5meE9rREw2ak1TZmZVVnU5eGg2?=
 =?utf-8?B?ZC9TNE1ockdPdDdQS21CNWprV2Jqd0ZFZXlUUWpKTEVBNENidTRMYm1CRVdE?=
 =?utf-8?B?cVIxOGVOaTRFL0hacXRIaHpTRFJCOWRobGplYmRucXZHTHp3TUZDTk9KVVhu?=
 =?utf-8?B?VmNtdHNoWW1oelY0U1lnMTJDTURzU3hnc1Z1SS9JSURXcTBKRElKeG1aUzds?=
 =?utf-8?B?QnU4RzRxQjk5TGxUMHh6bG9nbTQ3UE8waDhvT3BmeFJUOFdrQXpiRGlvcjJU?=
 =?utf-8?B?YVluMUxOcGRkUWRnSzlXZnQ2ZDJ5Y1ZkOUdRZjdyM1drUkJJdW9kekloSkgw?=
 =?utf-8?B?TFcvczlxOHBycStDWWFYKzkvY1VEczFXQXM5VWJFNXBvTFh1cVl3MlFlQk90?=
 =?utf-8?B?UlNhM3FuLzFvYVJ2K0tjZTVGdXVkR2tpTG9UbkJHSGhlditSakpyQWpaaEFv?=
 =?utf-8?B?aitUTEU1QTMrUVhjNlVqOFBzR0NFZjBLbks1bW10UE5sUmdqam1FSVVBY2hS?=
 =?utf-8?B?d29Bai92SXlPWnBUaW1VSkc1dFR5V21FUWRTd3FpNTI2cjZ0TXlxWElvS3lW?=
 =?utf-8?Q?U7h8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THpwZW80K2JrVnZ0VHV1UHBjNEUvbnZ6VGJGSzQ4WkZPaFpseUlPeE9iMnZZ?=
 =?utf-8?B?WEdJWHRlNU9ubW43dFpnM2tRTG9LWnNRVkxnb2Z2Qkk2azR5SHFMaHNrbGVl?=
 =?utf-8?B?K3ErUEFNNFdNd0dtbDNpSjVXWG8yc3lORDBiWEJld3FoR1lFaEVhRGx4SWhk?=
 =?utf-8?B?M0VxQTFIY2psS0x1Y1JCVDZpcmRKc2QyUTRCVlJRaXRJbjFWRUZySEs2WFJV?=
 =?utf-8?B?V2FzNDNJekJPRWRkbXkvcE85VE81akFTanVYekVIb0NMNEllYXN0ZGhYWHda?=
 =?utf-8?B?azM1cW9yc0U0T1hPTTBoWVA0eWxjb1BGM3B6OEw3Yi95VEFaT0lQTlFvNUxy?=
 =?utf-8?B?WEw1dTdBM0NNL2VzdUV0MWJGMXlyM3RHbmR3Rm5jSXNwOGs2VE5Nclp4Ymdp?=
 =?utf-8?B?c1F1Um05MDMrSU1CaXJ1UXBkcElZTEozSUZJM0RDN1VSKzVMY29uNkl0UEt4?=
 =?utf-8?B?TURkYTczRlBiMkx0VzcxQmM3Z1IxYUJFTjFFUzdzTk1BMEpPcndSVFZBUmI4?=
 =?utf-8?B?OWF4ekIwQkEwMHRzZ2Izd0p0dEkwbkpwM1pDNjY4Y1B1dlN1cWN0aHh0RVlv?=
 =?utf-8?B?ZHVsNVhSaTlXRlREQW1CeitvS0VpYWhFRHZtYlVCdW1XU1VXZWpNUWZxeXl1?=
 =?utf-8?B?blUxc1RsbzJSTmFBb29uY0xxa042N2FaR0VscWJ3NENWbVBFSGw1QVBMNEFq?=
 =?utf-8?B?QllnV2Ruakt0b0xtbWRYZFJTY1ZvL2ZBY1RwY0hGZW1jTHFQT1V4dFlPWEpB?=
 =?utf-8?B?cDRaenRjWVA0UjdENElzTG1nUDhZdlBMSW5SSTlNNzgxVEpNUEJ0V0dUL210?=
 =?utf-8?B?S0NQWXNFbE82ZHZzWmFIK00rMWlLVERTcUFZWGVpK2NPOXFiWGxhUkZXaVN0?=
 =?utf-8?B?eFdBRVBDR2l2MXpBZnlRakpqYytaMFVVRXBDWDlhSmNkOXd6WTVEV1lVM0pj?=
 =?utf-8?B?Tm16WWZIRWgzUnFXbitxby9tc3FUQndXdkJveDQ0anpIVVRra3RRemx0YjNo?=
 =?utf-8?B?RWxNa3NjNkY1dlBJQ0dFNDZEVXJ0SVVJeUg5VXQ0Q3U5WWN1SmVUbUExSktw?=
 =?utf-8?B?NTNEejhvYnIyVU9sOGROdlYrT2VtSC93SUxpTlFhQmtySzNyTW5ydkRFQ0Ux?=
 =?utf-8?B?L3oxcDhhWCt1Z05wS3BLbzd6NCthV2Y3WGd4UEtINGN4WnZ5WFFacDZMOERk?=
 =?utf-8?B?WFg5bVA3b1FxRDdKSUNLUlFBV0Z6WTNjV29XVEVpSEFUYzNUZE9ES3pyc0Ni?=
 =?utf-8?B?a3d1djF6b05nMlBGazZjWjF3YkZydlRicGpMeHVSaTVoVXdGbC9ON0JmNTZl?=
 =?utf-8?B?aDVucUR0ZThPVHFWaTNLdmpHdytzV2l4MlNCeXJNdGdWSGU4UUE4L3dxeTgr?=
 =?utf-8?B?MDJZOFJlOTFJTURzSVppR2xvSG9odElmeFkvK1VVcFhmcUtsbEQ1YjNSRjdr?=
 =?utf-8?B?M3RDck5mc1l6aTdHTHVqOHlKZUwxOGcrTWR6bWt3ekpySStQRzlCUVVYSUFO?=
 =?utf-8?B?STNScng4V3A4bm51NlhJSGF0T0JMSHpKTFJaaUtEZmpCYVQ5NFpPOW5KUklu?=
 =?utf-8?B?SWtHV0VpTHdzSHoray9Va0dGQTVBaXZEVU1LWE1EY2xPQUErL1N1OHlzRHVC?=
 =?utf-8?B?UmV3dkx3KzV1a3FnMFlzRDVUZWliTDZzcG5FeVR3WlZZSjRXamwrRG0yOGZz?=
 =?utf-8?B?bytuTkE4RFVLVEk4d2FCWlUrTWxob3dKQjB3YktlZGZMOEZjU3ZVNVMrTHc1?=
 =?utf-8?B?cENhaGd2VzdYZ1JpT2ZESTBGdGVMM0E3VEJ1SkRyTjJMblhFRTliWWoycnNs?=
 =?utf-8?B?dHdOdzRLUy81LzRtV3JWK0p1U0s5a3lWYXRnVlp0dnN1S0VWN29jWm1xY21C?=
 =?utf-8?B?L09vUTlnZlliVS9DbW5EMU9xTVlEaUlOOWV0eGh4L3JTT0pzMUQxajg3b2ZK?=
 =?utf-8?B?TjJ2K21YTWhmZTlpNjdPa0RxczMwQnM5TVlodTRTbTdiRTZqRmdWdTZXWWZs?=
 =?utf-8?B?UUJ3eE1LZzFUTjJwc0xxTVVwU0hWd216MTFaSjhhMzVNeWRhdWs4ZFU4bjc1?=
 =?utf-8?B?Sjg0Qk1SL2FsZHNaa1NSam1oaFpBcU15RGs0WGtlUmJSTnA2SWdCVE9qdmpW?=
 =?utf-8?B?Um9wUGhJcXZUQ2taTklsM3VrMlBpZGNnWmRYdVdtdGJFVzFqbWlQZjhndlVK?=
 =?utf-8?B?NlV2dzh6R0JpVmZIbmJETFh4cTZnS1hiR0lCSjlpcktFeTJZWCtGZE1LNG9P?=
 =?utf-8?B?Q1ZMRklvVkc4TUtLLy9mVnlKS1ZEcWRoRWtmeGxUQWFuTkJWQkhTa0MvTmFw?=
 =?utf-8?B?eFNVN2s4d0t5NUIxdXJheXh4RFZvVDJJR3NKZGxha0lleFNFTFdtZz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f22cc3-e2c6-427b-7ac9-08de58be83c2
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 07:27:21.1727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHQllZ6F3TSHGh8J4It+L8fP2t2eZrT50GDtUzOx8A2+ac7Rj16jlCcDNNco6+cg60r2gi/gB+fm5MgkFt1fTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8266

Hi Luiz,


> [ EXTERNAL EMAIL ]
>
> Hi Yang,
>
> On Thu, Jan 15, 2026 at 4:42 AM Yang Li <yang.li@amlogic.com> wrote:
>> Hi Luiz,
>>
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hi Yang,
>>>
>>> On Mon, Jan 12, 2026 at 1:42 AM Yang Li via B4 Relay
>>> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>>>> From: Yang Li <yang.li@amlogic.com>
>>>>
>>>> The ISO sync timeout was previously set to 20 seconds,
>>>> which is too long for PA sync. This could leave the userspace
>>>> flow pending for an extended period of time.
>>> I think we used 20 seconds based on the connection timeout, that said
>>> I do wonder if 2 seconds is going to be enough given that the
>>> advertisement window can be wider than that, specially when SID needs
>>> to be resolved.
>>
>> Yes, the Core Specification defines a PA sync timeout when no PA reports
>> are received for six consecutive PA intervals. In our testing across a
>> wide range of devices, a PA sync timeout of around 3.6 seconds works well.
>>
>> This assumes a PA interval of 500 ms, which is already a relatively
>> large value. Taking into account six intervals plus the time needed to
>> receive extended advertising during scanning, this timeout should cover
>> most practical use cases.
>>
>> I understand this is ultimately an empirical choice, and I am happy to
>> adjust it based on feedback. From your experience, do you have a
>> recommended timeout value?
> Actually the code define some recommended values for us to scan:
>
> TGAP(Sync_Scan_­Interval)
>
> 320 ms
>
> Interval between the start of adjacent synchronization scan windows
>
> Recommended value
>
> TGAP(Sync_Scan_­Window)
>
> 91.25 ms
>
> Duration of Synchronization scan window
>
> Recommended value
>
> TGAP(Sync_Train_­Duration)
>
> 30.72 s
>
> Duration of synchronizability mode
>
> Required value
>
> That said the duration seem to be only mention in the context of the
> source, anyway perhaps we can use 6x320ms=1920ms(~2sec), this will
> make us resolve the broadcasters a lot faster but then we need to
> check in case we timeout we should try to rescan a few times.


I understand.

In our system, the application layer has a timer to monitor whether the 
PA sync process times out. If it does, it will re-execute the scanning 
and PA sync actions.

>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>>> ---
>>>>    lib/bluetooth/bluetooth.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/lib/bluetooth/bluetooth.h b/lib/bluetooth/bluetooth.h
>>>> index f9f22c3f7..572009e75 100644
>>>> --- a/lib/bluetooth/bluetooth.h
>>>> +++ b/lib/bluetooth/bluetooth.h
>>>> @@ -152,7 +152,7 @@ struct bt_voice {
>>>>    #define BT_ISO_QOS_BIG_UNSET   0xff
>>>>    #define BT_ISO_QOS_BIS_UNSET   0xff
>>>>
>>>> -#define BT_ISO_SYNC_TIMEOUT    0x07d0 /* 20 secs */
>>>> +#define BT_ISO_SYNC_TIMEOUT    0x00c8 /* 2 secs */
>>>>
>>>>    /* For an ISO Broadcaster, this value is used to compute
>>>>     * the desired Periodic Advertising Interval as a function
>>>>
>>>> ---
>>>> base-commit: a94f994201a69a36753abda65cc51937de9cd3e3
>>>> change-id: 20260112-iso_sync_timeout-8e3ecf43d82e
>>>>
>>>> Best regards,
>>>> --
>>>> Yang Li <yang.li@amlogic.com>
>>>>
>>>>
>>>>
>>> --
>>> Luiz Augusto von Dentz
>
>
> --
> Luiz Augusto von Dentz
