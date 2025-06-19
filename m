Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022090.outbound.protection.outlook.com [52.101.126.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8059225403;
	Thu, 19 Jun 2025 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750301427; cv=fail; b=ntvH8xOELtNDbqVhOCsxH7UNfxX+fu7VnZb91I7qkuLuu7zXE2Q3RTYSfReKCv2qyRaPAux3mrKOTdEoJaaKDtTzZbViIPXCNNyoBO28BwmElgdXzb/BitfTnTM3QQmqELSUMpviRLR1JvSKePdc0Ul1U006LDjGy0d9MqQODaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750301427; c=relaxed/simple;
	bh=P6S487fspgzTadkYOM3Y32ferh+tqZk7c8GDQCttzMs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sbMoV81Zwupi1P+hnPiHKOcCIwtJtUvUPWgYu4AY8C/4gJHjvB/3ywAzwKAHGwj0CanmgIPv+0+SRhRQdh+ahgdzO9keYcReoQDtuLVeVXemRn/bdG8EHKM3fzLbjvZX+A5bSFBAlw21mby0IqFjkb+GR1E+9tz2Okw9AETEP6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=ya8EQQXD; arc=fail smtp.client-ip=52.101.126.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="ya8EQQXD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fySvDHDg8boU0wwwOtJsyHA5MoYB/a86JLjZ3Fl4+gvTspcy9Tt2EwhpduQNOyseCKYzaoDhiW5Iu8QwkZWB4GbxDSM/9bmBP3CmpbilIGLUsX5B8Z8MosmJM9tH0grixLV2QeXbRcbBfLYuGDLh863wEB01pYqphThdThuUROcp6SDSrKQyLbhhSLRpRYtG79Dly3AROK6uf57mGFs3X/TcMYaOcUlazN2gg/qA9Zokozv+oO/Mt6J3CgXZOSMF6FnlsiejkIfr3MqUFJle3jit8WzuqyV7RUQdRTLt7brqwhKeaiTNh/JJNr6Wk2FYNeGeFtlXW3b5bGcQXwYlbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbzKAoWJiSwYypMkbuEPz/ITZZHWcb/teo+M2HeJEt4=;
 b=beDYYe3W4bMWv6a4qKLjoncW+sDSNeKqm/JbXhGxf7ORseDwlvfCjGRCJ3fmiHYYLFur0jst7xy2H3c/y+4ZayquxrxNSIMdYis1WYyqgqcwUwaFWavAnHUji/+PWN5ynb2WUFeLLIJ4QrcPJ7ggmI48XUxSfueTWDh1vLx8kXG3hOxDRBEwY0Mazqf1C25mM2zvAzfjIlecB6ofTgClXQllL0FhyUNJxGtg/eRWKAEftwjE3ZW07VD7J+FMEWOqw7X3w3MTeKYCfwyQQKXsWV3bV/WM6Hf6lCbNGH5dafp81Sz1kw16EdYUfQJk4sEbQIfe4q97AYYQwAcCe7mPQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbzKAoWJiSwYypMkbuEPz/ITZZHWcb/teo+M2HeJEt4=;
 b=ya8EQQXDGeZLF4YKiFr2x/eD91J1YrM2qIK8SpscRN46mNUY14QXmQpkU2mndkWkBw6a6wnl3qsI4+RYEXyr9lxjaH2b/1pitoZ9Dx6m2+8gwN7P3Cg27IlV2Xq/WjWlR+aesrJ+lbQ+Jgyq/A2Ac6z3VI6Whsbd64LxRmaE5ImPknVC/my0Zb/CS8EdPqrlwtP9JjcMvspLX9bUc8bsTVx57XylGzqWY7ontbJBbQaM2Z5pZqpkl7x9Ko69CkMDX+4MOVRb0xYg8FAMfdJwb262x3ZmB644GRHQ6ZwmQme8Hxt0Pe+UMbareZaFEIHJDWv3TWPM9RjaGGrwJiqusg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by TYZPR03MB7723.apcprd03.prod.outlook.com (2603:1096:400:426::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Thu, 19 Jun
 2025 02:50:21 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.8835.023; Thu, 19 Jun 2025
 02:50:21 +0000
Message-ID: <c486b2ca-9afe-4a7a-88b4-905061ffaa16@amlogic.com>
Date: Thu, 19 Jun 2025 10:50:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: Prevent unintended pause by checking if
 advertising is active
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250616-bluetooth_adv-v1-1-6876bf4e85b4@amlogic.com>
 <CABBYNZJnakr4Yt8GUVurYkG0G3GJS9-zvZe2CO0LaxS3QZJBVQ@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZJnakr4Yt8GUVurYkG0G3GJS9-zvZe2CO0LaxS3QZJBVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|TYZPR03MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e38a68-1354-44df-6e33-08ddaedc0851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGY1M0pQMmNRWVlSM2I4cXo0WUxiLzJyMmZ4SnoyaU9YaDNaSXptWm5wMU96?=
 =?utf-8?B?ZG01dkN1NjBYbHBKUnFuVUsveXhENEpOTy9IZUhyYkZZUXd0d3VRVmRFdUVT?=
 =?utf-8?B?bW5aOUR5OEZGLzV3WXRxV2NNaUgyQ0tjbWllVFhPTjd6Qm9CaEVUNThraVhF?=
 =?utf-8?B?eDlualp2RDUya1Awdks3VHh2SUFseGRQMFpWQ1paREw4Z1pSbWFZM2hDUlA5?=
 =?utf-8?B?NHRXUGJ3SXY0RC9ZTjhzV01PcGVORE5TaTBxOWJRQy9ULzZocW14UzViL21o?=
 =?utf-8?B?cm45U0c4aTVnN0ltVHFodkJsWUQxb0t0NFRBSzkwamFocWU5REhXU2RnU1dZ?=
 =?utf-8?B?aHFyYkYwcXk3S0liVkdTS1JOMjdWL3VzcDZ1bU5UVFE0dnIvbXpMeVhjVzY3?=
 =?utf-8?B?TzkrbjJrdHVueDk3UFlnYUxKMHduZEtXZzBHSUUvS3JVbisyUlA1NW9HSEJo?=
 =?utf-8?B?dWZmS3BUWUJHUStZRXVadlFEYjNFTmVVZ0VyQkdaL3pHSWZGUEltR0xGNjJq?=
 =?utf-8?B?V2N4TFhIK2Z4OEZ2Z29kNWUrVTJFS3pJV0Z2SU5BL1E5ZTlIWmZJUGU3Vk5C?=
 =?utf-8?B?azAraE13K1VGUkpFdkxwOE5iSTM1YStlNnlBeUxLbnFodGJuQ1pYZ29jTlY3?=
 =?utf-8?B?OTIzYlhGV3pLZkNVMm0xU1QvTDB3RDNnMUJYRUFjanhVRzVwM2UyK2locSta?=
 =?utf-8?B?LzdkdXBXY1BBQ2hoMFpZWVpQb01LRGdqazBuNnU3eGlzSW5zN3NBMGRURG9Z?=
 =?utf-8?B?NTdrNTRnWFk2b2ZacjZSMTJmMXpjMVVrbnZ1N3g0UWptSy9XdnFicTZZRmZw?=
 =?utf-8?B?WjBkZVRIVjNLZmk1T2VMSnA5aFluUW5GdUhNYjZGaldLTnl5b3c5cVgrc0I5?=
 =?utf-8?B?U3MzakVFUFp5bU5zTy9oNGxqUjArbjNqSmFEWTgrZTVWby8yRlRIcHFpa3V4?=
 =?utf-8?B?R2ExUVV3M1EvaUhWUXRidDNsUXNJVmlHaUVsQ1AwYk8vZEk2ekh3TkQxa01W?=
 =?utf-8?B?UUp5L2pkbzRUK3phQ2s3dDRNUXNwRDA3cS9idmZSYVF2U2N1bjhYRlF0dzFK?=
 =?utf-8?B?cVFKajVGNWdXKzlXRm4vMXlGTERicnZxSW92OWRhUVB6SEJ0VW1KVXFWaCtn?=
 =?utf-8?B?WDNZaFd3Skx1UzBkRjFJcm1NeVhOdW9TMVlIcXZINjBSdC9NQS9jWlpMcVhu?=
 =?utf-8?B?cG0xMW9VRHJ0TlYzNHI3MW9rUG5XL01palZERzZkdC9qNk9zL0k3MXRHM1Yv?=
 =?utf-8?B?NUhjVFVTby9UMWE4MEQrTGVhWlBiT2poQkZDMWJHVGRualRtdG12Y29JQk9o?=
 =?utf-8?B?Y1ZxSFhYQ2g2MUlMSm5CMHUrUi9PT3pIYW9qZld3bi8rQ3NGRkpNYzZUTHJG?=
 =?utf-8?B?b2V1bmV0ZzRxL0xHZFF4UTVISTVuSDhpMGFkZVBycmw3M0lwbmVYeUxvTnlp?=
 =?utf-8?B?YzBzV2x4YzE2Y1VzRms0Q0Y3Y2dBU0NDRzE4WHp0RmRCV050V0VBNkdETXl5?=
 =?utf-8?B?NnhtUG1TMkQvamk2YXhQMWxEN3krWWI3aCtKblNNQnJvQUU3RVh3ZHI2L3BP?=
 =?utf-8?B?ZWtyMEpXaHVxa25JSFdSck9NK3dhQkJvTDBYWlQrUkFYV0NWZmZ0bXlQVnlo?=
 =?utf-8?B?dnpUdWVlMUZEZnZZOVl5TUZiSjdhTitYM3BidERoais4bG9RRXJvV21XS1Nw?=
 =?utf-8?B?cm5WekJkNkFyWHhvNGJFNFM1MUxGcE00VEd5WHZVV0NRaXhJcjlQYjM4aU1i?=
 =?utf-8?B?aXhkcmFGelN0WmNWNS96SE43Wk1iQkIvc2RGcFNWMmJkZFVnbGRDTkNNa3lC?=
 =?utf-8?B?Q2xrbkVZTlYvL2locnRvTkg3dFdNQ2pjajVwWDV0ajVWL3UyeUVyNVJWdTNE?=
 =?utf-8?B?TEJkUXhPbGdUUnM5aHZ2dG9OTmVMOVpISDJWeHRZTjdPbkhSbDREeHRjS0dn?=
 =?utf-8?Q?msAyl0l6H/0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzB5M1J6cW5DZENlU3dxQVI5MEJqTkF3YU1aOTZmbUdnYnduL2Nyc2F0RUl0?=
 =?utf-8?B?OVFjUzV2SnlzN1BaN2FyVS82YktibnlsaHU4TlFsZFJKaWlEaUFaeUovMEdp?=
 =?utf-8?B?clNMaDIrZHB3SDRSRDVneUp4eHpJUDY5NjZCR0dWRlE4Zmg3Y2g1VDk2dXNH?=
 =?utf-8?B?S3RDL0wrc1ovZHQwb0RVN1l5Z0ZacTM4bmhFN2NxWHZyTmtSRlJZeTVESlFH?=
 =?utf-8?B?NDZQSlRaWHozNFJxWFN3K2hwS3FXTFVCNHZUQTlzbk1JTHl4UlRvaTJCeDgr?=
 =?utf-8?B?UGZndWhNdG1wT0F2Q1NaVkU1WUJEUnErUmI5OFFjaTU2YnhMNDdJdjJqaWNv?=
 =?utf-8?B?WGllWFBtTGFqU2p0MkZSNllneUpsWDJtaDRwc0NXcExzT0JObGQ3TG9hbGFt?=
 =?utf-8?B?VjB0Q3ZaSTcvQVFKSWNmMU4ybWI0UHhHTm5NQjJNcFd6dlZyaytKSkU0LzY5?=
 =?utf-8?B?SFA1N3IxRC8vOEhaL1VaZ2pERkZyWkpmd0RSVXJrMUVaK1RJT3V2L2RVRkl2?=
 =?utf-8?B?cWxoa3JINmZWY2tIck80azM5NWNtckk0VmljRU9DazNFRm5jc0ZmVklYWGlq?=
 =?utf-8?B?WkVUeDAzK3ZIbGQ1VDhtR0RDVUVVWlBNSHZuMFB5VHdrWk1xVU1lMm9CVlhn?=
 =?utf-8?B?dW9BbW1Ca0FpKzZSdVB3Z3FINDdLZmpIYzhhZjNPT3c3Ymp0MXFKOXUxMGpD?=
 =?utf-8?B?b3oremZEb3dKSUxNNWpyc1ZLM0ZlWFpLTDJ3UWxFTUd3T2JXWkRBRFdhQzFM?=
 =?utf-8?B?TUpGbXVmSXViS0tiRTNVY1EyejJocGRuSm5ZVXh2YkplZVdMZUNIOVNNU0VC?=
 =?utf-8?B?aHFOZkdDRXJnRnkra1BGSUV6ekxSQlFrRmZLTXBTWlVBclU2bFNoUnd1TjJn?=
 =?utf-8?B?ZlNUUHlyYUw3SEI5NFNYMW1IVWtNUUxkbUdVUDc3bThQclJCWnN5a3BzNjZa?=
 =?utf-8?B?Mm5Jd001eGUrR3lYRW5oQ3ppR2F5dlhDaCs1YTAyQ2FWQ1JqTEd5TVV0VHdu?=
 =?utf-8?B?czlmdnV6ZVF1QVBSaW00dFJrbjJyOW1PbmxySzI4aEJGL1dzN2VOZ0FmbWFD?=
 =?utf-8?B?VExzKzZxbzJkYlFoMFM2WjdrSDZkOXFjYTdGUnZnRG9pUy9DTXVGQ2tPQjV3?=
 =?utf-8?B?OWlHQk9IeEN5TklreGFOMjVpNW93TGh2ckxCUTlFc1lpaWZ4dkVObUxUd1Ru?=
 =?utf-8?B?M0twSHFnQlhSMU92czFLNTY3enYrYXQxZDFTcytKZGd4UmF2SGs5MVVka2Ra?=
 =?utf-8?B?dlNTVWdPNDI0WFgyeDBacVBpdjFQZUQwT3NQZEkwVVkwVXovY3JJT3cvdHlX?=
 =?utf-8?B?dk1lelRvbXQyZzBNTEdDVGJHbDFmdENJeGx1ZU0wZitJbEF1dmJ2NmJzWUVM?=
 =?utf-8?B?ZklNSEYvQzVIc2FDemxKbzNzRWZVNDRCL1o4cnEvUitrV1ZoM3k1dnJ3MWRW?=
 =?utf-8?B?UitTRzdVdFVyb05RdFQwWVJBY0wwalVYQXprd2xPbjNMQXBiczNvQnMzRERI?=
 =?utf-8?B?MjdQSVN6Z293bEJBWHl0dzltN0E5a2JoWHBRYjEweEZOSjJXdkoxQTVoYjRX?=
 =?utf-8?B?NnJHRk83RHRKRk0wV1lXbHVnVE5GRTJpZW5Hb1dVaWlEK1pjellNd00wWkR5?=
 =?utf-8?B?T1g1ZW5XdFkzRWt5ekVSNUQ0QVRuQVFtQU9GZVladjQ4Uk01RngyQW1tV2dD?=
 =?utf-8?B?OUhjb3ZpdDJabHRIZHF3eEZSVi8vdVg2Y0wvQTJtR0NkMmNtVXgza3F4dnJx?=
 =?utf-8?B?SDB1NnVFaXRBQklJK0JHMHhqTDFPektOUjdkYWE0TjBLUndkRjA0bEhIdWJZ?=
 =?utf-8?B?YjFIRDRWNXExSGt0TzJzZmgwdnFrWWV1d2E1Q2I2bUlDVFJNaklFeFpacjlp?=
 =?utf-8?B?Zys0VGMvRk5xMzdUeGNhMnBJOEJKNk9udGlmdERMU3VBRHFsQlhWdzRVTEp3?=
 =?utf-8?B?WFJQVWR5NkRaQnZzRHlTby91MzY3WXpyWStZQmZrRWp2L0RROU41b2JqUVdY?=
 =?utf-8?B?YTlUdktCdWNvRXJNWlVodWtZOExxR2F2eUx0K0Qvajg2bFJjeGFZUUwyRUl5?=
 =?utf-8?B?MDR2U0R5ZzVCd3VSd1locmp5SWhTNmtxa3RkOEgwWk9ocnVNQjdiVWFHK0dz?=
 =?utf-8?Q?ASFMMQyFrL2y99hMsrNkDNxd0?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e38a68-1354-44df-6e33-08ddaedc0851
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 02:50:21.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X+4/OvISqDrFDsnyErNgqIs1X0shWYvA6hVUAPu++CaiDQ6Xds6L+jyqGPBVhEaCVvyTJRLgW07i7BW9FW0Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7723

Hi Luiz,
> [ EXTERNAL EMAIL ]
>
> Hi Yang,
>
> On Mon, Jun 16, 2025 at 7:05 AM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> When PA Create Sync is enabled, advertising resumes unexpectedly.
>> Therefore, it's necessary to check whether advertising is currently
>> active before attempting to pause it.
>>
>>    < HCI Command: LE Add Device To... (0x08|0x0011) plen 7  #1345 [hci0] 48.306205
>>                  Address type: Random (0x01)
>>                  Address: 4F:84:84:5F:88:17 (Resolvable)
>>                  Identity type: Random (0x01)
>>                  Identity: FC:5B:8C:F7:5D:FB (Static)
>>    < HCI Command: LE Set Address Re.. (0x08|0x002d) plen 1  #1347 [hci0] 48.308023
>>                  Address resolution: Enabled (0x01)
>>    ...
>>    < HCI Command: LE Set Extended A.. (0x08|0x0039) plen 6  #1349 [hci0] 48.309650
>>                  Extended advertising: Enabled (0x01)
>>                  Number of sets: 1 (0x01)
>>                  Entry 0
>>                  Handle: 0x01
>>                  Duration: 0 ms (0x00)
>>                  Max ext adv events: 0
>>    ...
>>    < HCI Command: LE Periodic Adve.. (0x08|0x0044) plen 14  #1355 [hci0] 48.314575
>>                  Options: 0x0000
>>                  Use advertising SID, Advertiser Address Type and address
>>                  Reporting initially enabled
>>                  SID: 0x02
>>                  Adv address type: Random (0x01)
>>                  Adv address: 4F:84:84:5F:88:17 (Resolvable)
>>                  Identity type: Random (0x01)
>>                  Identity: FC:5B:8C:F7:5D:FB (Static)
>>                  Skip: 0x0000
>>                  Sync timeout: 20000 msec (0x07d0)
>>                  Sync CTE type: 0x0000
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   net/bluetooth/hci_sync.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> index 6687f2a4d1eb..4ea5a87f017d 100644
>> --- a/net/bluetooth/hci_sync.c
>> +++ b/net/bluetooth/hci_sync.c
>> @@ -2481,6 +2481,10 @@ static int hci_pause_advertising_sync(struct hci_dev *hdev)
>>          int err;
>>          int old_state;
>>
>> +       /* If controller is not advertising we are done. */
>> +       if (!hci_dev_test_flag(hdev, HCI_ADVERTISING))
>> +               return 0;
> HCI_ADVERTISING is for directed advertising, it shall probably be
> changed to HCI_LE_ADV like in hci_disable_advertising_sync.

Thanks for your valuable feedback.

I will do.

>>          /* If already been paused there is nothing to do. */
>>          if (hdev->advertising_paused)
>>                  return 0;
>>
>> ---
>> base-commit: 6c31dab4ff1e1f4e0f3412efb1cfc88033358d1f
>> change-id: 20250616-bluetooth_adv-6496e1ca6165
>>
>> Best regards,
>> --
>> Yang Li <yang.li@amlogic.com>
>>
>>
>
> --
> Luiz Augusto von Dentz
