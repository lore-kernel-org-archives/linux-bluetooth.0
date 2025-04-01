Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021087.outbound.protection.outlook.com [52.101.129.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC84685
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743485206; cv=fail; b=tZ5J56WHc9n6FE2y8spu/UCSdFdvy3B5K74cE0V4qeWqDHeL9FXQTxyaOM1UDyddXaGgaPa7Qlq7NOjDro7qkVU4DAxii2OEKcb47fzw+9TtmgQ0Wku5kE/puXyv9NCi9iK8/btuuUeGJ02VBMQ54jD0ohZcxSnC6y/1dq4kTPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743485206; c=relaxed/simple;
	bh=gV+x6cEpTghv02aQQiA67QQz2NYmPn7E+L/x4fUwHnw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WYH5CnmkdZMb7/jRlGVWz2yzzVXYrRewPdGcPkiGVmEHIepmGdzhQTJD+rIqplCnD1075won24G9bVFFj2fbasDyAdnqYPsxJ9FzwP8N2ZyXOJEwv5byPJmywoLifMp7bVvdRiDecM3bNjyFgi+cLR9Mm+ykhp03sLJdlcxvs3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=wL3signA; arc=fail smtp.client-ip=52.101.129.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="wL3signA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADpxww1RGmmkG73ZYiPP9U1GkrcXRNEwYzH2rfdbIk8xwgGtfWtjLg1+zpLOlTIjywlcBVKeqFbZaV8NWQ9IkGCGkEGvRt6C5MxKi+Eji7KXjWYjnLp4TIvp82xNhiv9CMqnruMTSAOPqiMJa7KkKdT4+54XtdY8xrP1KtwuQtTlvJhhfr7zh8rWPUA4g7yl82V/Qs2xUt9UMCS4ox4xmYn5WRMDwZrl6rHPUL2839aNGBHD3LB18hryXaVZrEGUA02FvYo1Yvl+PSTO3C+KrPDtkJCdGv7Sy6rkRY66VY/hHnNX2U054JWNjcNnynQHG3164hAFbqlH6XPTNitcNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsTYcu29NUhvZcqHSF3oYBFm/AsXQxnL7tb5MAt4zxI=;
 b=LphqdJUKjuWzkkdmbzID6lrzVuUVY1iLFQk7qwOd6tSC8ra1sHAD6u8KkgGQTeBiF4AuD8kHnZ5dr9X/1h65rNqPnPvgQuAJWfvf08HZqgO56+ZhfArV9tcPSAqjribtBb/HZLa0T6WVoV5ENQFqx5+wLykAKb3LygtHVzpP63GVuytxwyGGKBUSaZxqrvaHZgBgRO1vHmWQahqljcwWh4IJvQrqYHcGR5YCVe0oBSAC6+3x0izf8gRbrefTfpWvy3RWBHvWSUaBAAJtnEcYIZLIQgHtxDZ2UURqQ6HOpOAwzECZy1InNn7RmJNui5rXAOKTBstfpgSZcRq7nU+G9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsTYcu29NUhvZcqHSF3oYBFm/AsXQxnL7tb5MAt4zxI=;
 b=wL3signALDDTrzJlWhCB/tybvjba6O5s5pNaK+Sbp5t5ycFRmlRi7MQXX8fWEDlHkUKgdBDpBgHvLmCzaEO7rbs0+uLTtkRUMuLKLrRaABo31bQ0DrulrfdvWMrduunrdBWoVl/cnSDeWZxqI4i8qdj5fwPSCOXwAqA3o1zzTtTMzJq4dv6oTwGetEBtU6Qs8Sg0T1eZXWJ6jQXfMbHchTkp6fhfLzcVOfDVba6Mz6jE6XkPOes02BhAqG4lRlGbZsnDBaPRziWsAGvcZxYfdOBZN/FZvsDIviOwQTEC5tFAsZW0hPxv+SoQz4OnO2pTmxBB21mrxEZBBvnw9gCNBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by TYSPR03MB8394.apcprd03.prod.outlook.com (2603:1096:405:60::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.36; Tue, 1 Apr
 2025 05:26:40 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%4]) with mapi id 15.20.8583.038; Tue, 1 Apr 2025
 05:26:40 +0000
Message-ID: <03ecc26d-4949-4206-85e9-b816b0aca453@amlogic.com>
Date: Tue, 1 Apr 2025 13:26:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ bluez v3] bap: fixed issue of muting music silent
 after pause and resume.
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20250213-ascs_bug-v3-1-d5594f0f20c6@amlogic.com>
 <CABBYNZKT3g4tMc+TNLvgk09_3yUqj-N5ycXMnottHyWpfStV9Q@mail.gmail.com>
 <a8173f35-d88d-4475-bb6b-b20b94281a03@amlogic.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <a8173f35-d88d-4475-bb6b-b20b94281a03@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::29)
 To JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|TYSPR03MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: a768096f-b2a1-411b-89e7-08dd70ddc7cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXdFYzFmQ3IrT2d6QmZnLzQyMkIvRHB5NTFqRjh5NkNpdzVoVFpPNkhHTy9I?=
 =?utf-8?B?NURBWXllQTRhTGZkbVhlRDVQbGVlaXdNbnIzbENtYStlMEsyMEtONVJpclJu?=
 =?utf-8?B?a0JCUWpSZDBYajdTY0R6NGVCVmNFSU9UTFhXZHQrSUFvTUQ4RVJlZXpiUytX?=
 =?utf-8?B?dDkwUm5WVVpZUU9MV2YyQzRpcnBSbFJ5MWREa2U1eVJ0WHdwZVNwWUZyS2NF?=
 =?utf-8?B?SVVaTGx1TXJqT2tROHRIL0dNZTd5MWdlRTBMeEJySzZad1V3ODE4bzhHUlg5?=
 =?utf-8?B?QThtMjZVMXdtUWs1bVZFbmpFMWo2eVkwanROOVYzT255bU12NlZ0MVlUZ1lr?=
 =?utf-8?B?RVNjSWFnWFhhRVlnZTJtTHZLS3IweXBueXFKaU1XUGEvalhTKzBaekNmRUxQ?=
 =?utf-8?B?ejhSWjYwd05KcENvSzY0YzhpZWNjdjMyUmVmUzBPSXhxcnJTbGZtTHlnL0hv?=
 =?utf-8?B?NVRYMzYxZllKbzR2bEtGdWpydlZIN25oQVo4S0JVMXBjekNBQklWRlVqbWM0?=
 =?utf-8?B?RS9ML2tBNU1GUUt2WjFCUHEyQ0JBYWV2Wk5TUzNqSFFaOURhd0tOTTNIYVFx?=
 =?utf-8?B?dEZjU1BxTFhneitMMG5yTVdyV0JuTE90NVArM2NGNG1pdStrTmh4UUVxQ05r?=
 =?utf-8?B?MkJoVHFSNTV1ZW1FRVplV1VSQ2FpZVZrNDJpOVI5RWw1eUFwamZOaGUzUXNz?=
 =?utf-8?B?Nmd5N1ZkRkVQUGhtelpuKzlYdTVTc0pZK0hxS3BMVXY4c0FqU084dGlVOGkw?=
 =?utf-8?B?blV0cEZnMlJEUTlHdEp3Y2ovZzZBNGd2SFd1QVlZY1ZDZFpZblBORUozZWQy?=
 =?utf-8?B?YjRpd1ltZ2drNW5TczJzWlpxWk5sN1M2dno1TmJaWFp6RTg0NTVOZUl2K2dr?=
 =?utf-8?B?eTEwOWFHNWgzWVMxKzFqZGhNZlJDeUJBc2ljUFF4amF6ZmJiOUF2cHZoZDk1?=
 =?utf-8?B?YnhNa3VYNVhRZGUxbFJYR2tnNjBJSURPTkc3UHB3UkVUd01LNStnNVVoMTQ2?=
 =?utf-8?B?cDRhZEY3a3p6cmVZc1h1anVkTVVQc0JlNDdGU01mcjdpWjl5aW5yblh0U1JD?=
 =?utf-8?B?Vjd5N1pDY0NTOWVFb0g1RHdpZDJpejhmQ29OMnJUSHZmV2xicmVPNkl3cng0?=
 =?utf-8?B?UHF0L0lLalF1bDlEWUNaeXRXMFZnSXJEUWZyT1dzVVlHUUZiMmMxcFdNNlVv?=
 =?utf-8?B?VXQvd0ZxMXZVU2JqU2FCTEIyWEFGSWwzeDVmcDFhTmFSOU5rNis4eTc2bS9J?=
 =?utf-8?B?WCtmNHgyRGw4MG9lNlQvVEs1NDBDd1R6eFdSRzlXV3hsYmJCWjZ1alZlOWtj?=
 =?utf-8?B?cUp5c1FUZktYeE5FbGNKZ0RjbzdyOXpwZFkvSVZ3Q0U1RnkxZFlLV2dLdW5T?=
 =?utf-8?B?eXlIenJBZEhuQjgzVEFVNDlJWTA3QjkxVFd0R3hjbkJuUzVjOVdtT0RQWkpx?=
 =?utf-8?B?NkVYMnBPZU5ZRmZjeW5MMnliVE8rL1NkZGZDSHJ5ZFdLTHJWSVowZzQ3ZnQw?=
 =?utf-8?B?TjBQRjBseHA4TDZmZHZRRG5jYXJabFRYa0hLY21OZ21aY213NzBMK2xlUVRV?=
 =?utf-8?B?TDJ3Mnh0VmN0aStGUVVMYmlqQW1lakFCdzM4RjBrdDNzY244ayt0c1hxYTRC?=
 =?utf-8?B?Qm9hMlZpUk1JMTZiUGF0QStEVlFEeGRYYU5UcFc2NFQxZFA5OTVrTHlkaUxK?=
 =?utf-8?B?cE9nSExkQWZGOHlWbzc1d3QwWGgxU1Vqd2doSE5lMHJJdXltbFFrRDNDWkFR?=
 =?utf-8?B?bVVXdVhhell3blV3MHVrYXpEdFRFTjEyZjBnVmcvTGZvTTBWd0t1NmJnTFA2?=
 =?utf-8?Q?7K4JoOQ6nfGP7sNhgk9ulPNF+fs1iHCC6+wps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekJTakJxenQ3SVdOWXpiWFVmQmZDUEJ3UTV6TkZpZGpRV1Z1S2txTWhyRXk2?=
 =?utf-8?B?WldnbXRHQUxTZnZMdUdmamlEQlpXNkJ3SUR5QUg5bkdwdDFhZERTNGVsT1Yz?=
 =?utf-8?B?ekdBZVF5RDBpQ0VZZE8rOWEvcHFFc0d4alBWbUxDdVhmNHk4blh0bXBqZzgr?=
 =?utf-8?B?ZFcybWxIbUszM21UWndRSzdnbHhZckN2T0MxSTUvVE1XTENoVnZVTzgxN00w?=
 =?utf-8?B?VWszMkR6VmNaRjFEblZkZDlaK3M4R1AxMTlFY2VqZ0kxMk9qaDJUWVJTQkF1?=
 =?utf-8?B?RkpNaHk0c2pUb0o1elJrMkdCTXZDVlpTQWhVSE9HTVhpMVprZUtwamowb3hj?=
 =?utf-8?B?QUpURlJleGFZUmsrQWxKSE5lSlRUZWs0aFQ2by85N0lYbmpLOGw5U29EVTM3?=
 =?utf-8?B?OEJnbkhTZUhEZVlvQzFEY0FMdmNJQlUvaGZMN2JOeEt0MDQxZml1bk03b3Bh?=
 =?utf-8?B?N09ERTBnQjAvT0Q0bUNoYUt3dnorblpCeCswU2p3RUZCam9mc0Zia2hVOVAv?=
 =?utf-8?B?UldmR3dsUjVlUmxWMkJWM1BZVmY2ZzdlVXVJd1BNZ2xwbWUwanBiVWQweW1s?=
 =?utf-8?B?aFFzVnlDR3lacUNZaHVYZ0I2aDhPdkwyMkhaVG0xMVFaMHRyVWU2S2FLVmlM?=
 =?utf-8?B?U3lNZk41eGRubWRmRVlrMnk2LzdRWUM5U09OdUtpWVNKM1NKU0wzUDluek4z?=
 =?utf-8?B?YW02WlFsSHVtQkdlTG9NYVI1d3JwTkRnSDE3OHc2aFNYd1gxbDJMSEQ5YkZO?=
 =?utf-8?B?NkpzbnR1cXdrekRJSFRITFlLVzdKN1hGMGlYUnJCL3BGOG1DRGFTT0F4NVRE?=
 =?utf-8?B?eVNuMGhQUFZLbGlqMmdHekZwZVNSdCtya1p4SVBPQkRoTXQ2K2FEVHRSeVh2?=
 =?utf-8?B?TGIzZU1lMFFaNlorQmxQSjFLajkwaThMS29rYU05VHJTRVJuQk1HZDB0RTJB?=
 =?utf-8?B?KzNtUHI1emRyK3JWenorZlVYS21naEM1dldQU1o3clRzcSs2ZDNRaDArOGVD?=
 =?utf-8?B?VWdhc0lGWGRGeHh6Vi9KWjFuTkdDN2NGSnNFOXE4cENPenJ6aVRFT05lSmNV?=
 =?utf-8?B?VWh6MzREV0lBMEZmVmVhREVBamdVQmRCSHJnUFlvWHdOS2sxUlBvbHI0bzFH?=
 =?utf-8?B?Y2dVVm5IRGYvcDIvMTRjWDJOUzNGeE5icjFSNk1aY3B4RUR3dkFMMnVLcUdX?=
 =?utf-8?B?VkRtQ3lJSFNER1JYRzJqcDFMQ1NndCt3VVRVaTFGYyszRlhTS1VZcEt3MTMv?=
 =?utf-8?B?Sk15RWM2dFFWT0QwQmlCL3JONUNod05RMzJSMGhFMStNL1V6TUFLcXNvNVRM?=
 =?utf-8?B?eUN0amZwR01Kazlrb0NwQWtJSk1ZbjZQYUcxL3JGQUhla2pOK3dxQkdqdk55?=
 =?utf-8?B?SDNpeFpPVDQ1SGJRL2FSRHJkOEZpUnlOQzNSanFzdkpKem03Q0M2bzRkb0E3?=
 =?utf-8?B?RzNCbzBsdjQxZ0VIOEpQcXJuMXZCYVVwWmtWeDRlbFArVFJLQ25ZVm0rUUUr?=
 =?utf-8?B?VGpXSEllS0FyYW5pOVVFOVZmWW9aS1hHYlZ6OXc5ZDU4L2VLRk0wSU1jenRi?=
 =?utf-8?B?YTZobXhrR091a3o5dWZLaE13UVpnemR0RU91anVOb3lwcUExZzVXMi9uNEVo?=
 =?utf-8?B?TWxDcG9YM1NUdVZLcng2OUVhMkp3VUxCS0swei93c0ROV2JYdjUzSXpKdFRk?=
 =?utf-8?B?TkYyUnNxa2tYV1JjNUhYSkY2VDdjYjZYcm5TOXhoSjlqbWZYdG1ObUpSdlJh?=
 =?utf-8?B?UFlpSnJaaUNQUzVxdjlpbHI3cktDNThBaCtYQ0xTU2FSTWlrZ0Y1MWZ1WTdI?=
 =?utf-8?B?R0ZyS2Vic0VKQTNoRENnaG5VRDl4OFJlK2U5WkQyZzluRGdkU01mUVZQRW8r?=
 =?utf-8?B?SVh3OTZibUdvZzl3R2ZHL2tTQzFhUngrY0F1UjRRWTIyaFdsQzBQYnJmSXF3?=
 =?utf-8?B?cVY0MC9Gak84anM3YlNVMEV1VXVBVHZtV25wSkNzRW9sTFNmVkZuQkpveFZY?=
 =?utf-8?B?WndRVEp3cFFpblJDV05yR1VzUk02YWkxZVFVNkpKMzIzbUFlVENhTS9iSWpy?=
 =?utf-8?B?R3duWUFqUFJHcW5Kc0prV0xUQTNJZXhOakhvUW0zU2hqRUM3NHEvVVVpblBs?=
 =?utf-8?Q?OX+39Z0rSGQh4wYnEAYg0fdlA?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a768096f-b2a1-411b-89e7-08dd70ddc7cf
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 05:26:40.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sI6JRgSBWu/FEb5RD4zCRESPifyHE3WErLh2MC8WP1Wb6cA4l+syXdWFTG3AnfXZ3c/c1Nakn7Jc08iK7hY1ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8394

Hi Luiz

There is a mistake here. The patch that needs to be merged is patch V3, 
but the patch that has been merged is patch V1.

https://github.com/bluez/bluez/commit/173045553c156185ba1bbdbf39ada139cd4bca65

What should I do now?

> Hi Luiz
>> [ EXTERNAL EMAIL ]
>>
>> Hi Yang,
>>
>> On Wed, Feb 12, 2025 at 9:58 PM Yang Li via B4 Relay
>> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>>> From: Yang Li <yang.li@amlogic.com>
>>>
>>> After the ASE state changes (streaming->releasing->idle),
>>> the Client needs to be notified. The process as follows:
>>>
>>> ...(Sink ASE: ID=1, State=Streaming)
>>> ATT Write Command Packet (ASE Control Point: Op=Release)
>>> ATT Notification Packet (Sink ASE: ID=1, State=Releasing)
>>> ATT Notification Packet (Sink ASE: ID=1, State=Idle)
>>>
>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>> ---
>>> Changes in v3:
>>> - Solve the compilation error reported by test.bot
>>> - Link to v2: 
>>> https://patch.msgid.link/20250208-ascs_bug-v2-1-b7e062d6604d@amlogic.com 
>>>
>>> ---
>>>   src/shared/bap.c | 31 ++++++++++++++++++++++---------
>>>   1 file changed, 22 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/src/shared/bap.c b/src/shared/bap.c
>>> index 167501282..079f7ede0 100644
>>> --- a/src/shared/bap.c
>>> +++ b/src/shared/bap.c
>>> @@ -930,6 +930,18 @@ static void ascs_ase_rsp_success(struct iovec 
>>> *iov, uint8_t id)
>>>                                          BT_ASCS_REASON_NONE);
>>>   }
>>>
>>> +static void stream_notify_ase_state(struct bt_bap_stream *stream)
>>> +{
>>> +       struct bt_bap_endpoint *ep = stream->ep;
>>> +       struct bt_ascs_ase_status status;
>>> +
>>> +       status.id = ep->id;
>>> +       status.state = ep->state;
>>> +
>>> +       gatt_db_attribute_notify(ep->attr, (void *)&status, 
>>> sizeof(status),
>>> + bt_bap_get_att(stream->bap));
>>> +}
>>> +
>>>   static void stream_notify_config(struct bt_bap_stream *stream)
>>>   {
>>>          struct bt_bap_endpoint *ep = stream->ep;
>>> @@ -1634,7 +1646,9 @@ static bool stream_notify_state(void *data)
>>>          struct bt_bap_stream *stream = data;
>>>          struct bt_bap_endpoint *ep = stream->ep;
>>>
>>> -       DBG(stream->bap, "stream %p", stream);
>>> +       DBG(stream->bap, "stream %p state %s",
>>> +                       stream,
>>> +                       bt_bap_stream_statestr(ep->state));
>>>
>>>          if (stream->state_id) {
>>>                  timeout_remove(stream->state_id);
>>> @@ -1643,6 +1657,7 @@ static bool stream_notify_state(void *data)
>>>
>>>          switch (ep->state) {
>>>          case BT_ASCS_ASE_STATE_IDLE:
>>> +               stream_notify_ase_state(stream);
>>>                  break;
>>>          case BT_ASCS_ASE_STATE_CONFIG:
>>>                  stream_notify_config(stream);
>>> @@ -1655,6 +1670,9 @@ static bool stream_notify_state(void *data)
>>>          case BT_ASCS_ASE_STATE_DISABLING:
>>>                  stream_notify_metadata(stream);
>>>                  break;
>>> +       case BT_ASCS_ASE_STATE_RELEASING:
>>> +               stream_notify_ase_state(stream);
>>> +               break;
>>>          }
>>>
>>>          return false;
>>> @@ -2068,17 +2086,11 @@ static unsigned int 
>>> bap_ucast_metadata(struct bt_bap_stream *stream,
>>>
>>>   static uint8_t stream_release(struct bt_bap_stream *stream, struct 
>>> iovec *rsp)
>>>   {
>>> -       struct bt_bap_pac *pac;
>>> -
>>>          DBG(stream->bap, "stream %p", stream);
>>>
>>>          ascs_ase_rsp_success(rsp, stream->ep->id);
>>>
>>> -       pac = stream->lpac;
>>> -       if (pac->ops && pac->ops->clear)
>>> -               pac->ops->clear(stream, pac->user_data);
>> This part I don't really understand, why are you removing the call to
>> clear? Or are you relying on bap_stream_clear_cfm? That is only called
>> on detach/disconnect so I don't think we should be removing the code
>> above since it is still possible to reconfigure after releasing.
> I removed the code to allow the mobile phone to disconnect CIS iso and 
> switch the ASE status to IDLE in function ofstream_io_disconnected().
>
> If pac->ops->clear() is executed, CIS iso disconnects actively, and 
> stream_disable() transitions the status to QoS. bluetoothd.log as below:
>
> bluetoothd[2223]: src/shared/bap.c:stream_release() stream 0x1ed5ae8 
> bluetoothd[2223]: profiles/audio/media.c:pac_clear() endpoint 
> 0x1ec8780 stream 0x1ed5ae8 bluetoothd[2223]: 
> src/shared/bap.c:stream_disable() stream 0x1ed5ae8 bluetoothd[2223]: 
> src/shared/bap.c:bap_ucast_set_state() stream 0x1ed5ae8 dir 0x01: 
> streaming -> qos bluetoothd[2223]: 
> src/shared/bap.c:bap_stream_io_detach() stream 0x1ed5ae8 
> bluetoothd[2223]: src/shared/bap.c:stream_io_free() fd 18 
> bluetoothd[2223]: profiles/audio/bap.c:bap_state() stream 0x1ed5ae8: 
> streaming(4) -> qos(2)
> Could you please guide me on where to switch the ASE status to IDLE?
>>> -       stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
>>> +       stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
>>>
>>>          return 0;
>>>   }
>>> @@ -6172,7 +6184,8 @@ static bool stream_io_disconnected(struct io 
>>> *io, void *user_data)
>>>
>>>          DBG(stream->bap, "stream %p io disconnected", stream);
>>>
>>> -       bt_bap_stream_set_io(stream, -1);
>>> +       if (stream->ep->state == BT_BAP_STREAM_STATE_RELEASING)
>>> +               stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
>>>
>>>          return false;
>>>   }
>>>
>>> ---
>>> base-commit: 2ee08ffd4d469781dc627fa50b4a015d9ad68007
>>> change-id: 20250208-ascs_bug-e7c5715d3d8c
>>>
>>> Best regards,
>>> -- 
>>> Yang Li <yang.li@amlogic.com>
>>>
>>>
>>>
>>
>> -- 
>> Luiz Augusto von Dentz


