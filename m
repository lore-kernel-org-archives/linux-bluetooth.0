Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022103.outbound.protection.outlook.com [52.101.126.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC7F4C85
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 03:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749699221; cv=fail; b=IwWTempotkDXv9xh0UCP0so4xEHaLZXj2bU+ZhiUL95bdL0tyJyRXrcUmzGc/7EIaB7UiWuJO8QyFrI5v9bs6PDClBc7eRzRWyDGi2OhjS0VYBgh09FbZsyEJqb+/F7iiJfYbmnf/1ZvvI+4Agu7PBCi3FKz5ZyjR0kj1nvva4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749699221; c=relaxed/simple;
	bh=NzJHhEhopJk6g636BAdTWipxSZ48iThHNzXan3YOicU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gm9L8PJAIhTiBhtXLy1cKqybQV8aLMXAN26mbm+51SBnFqwUmCCB37DOfLE9D8/F+rbNLLeXqsIgwucGKk2YEWtnyVv/WqpbygPGbnAvIlLHORoqAsjgufO2gKRw0yzEPv2Mu8Vp7g4dmTCsUE8DyBt6qeJJEjdVeT1pU+d81sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=E0UL4BKj; arc=fail smtp.client-ip=52.101.126.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="E0UL4BKj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axJPdLaB5v/f/S8xsXYc5b44D9C/jUlZ/PzRztPMl4/slWVE8KaBWNDsnPbOSRVUXOX6A4QvQa6FCBhMNscbQyiWUAfAehlh9uvefNZ+EpQgTKh1qezBib9NIA6QIJ5f5JvPqcLeOQcW5pIA+AziET+ifD57BcBA+BHJfMtsUWDRRaFMJ9CLIPQPqbXvQ9AfjoSRIcdcCiX+sBsl69vBmWXX3SoP+PTlFYftS0xEEWqiQgV5wnWzfFgspVprOkg6JHviWQIlVorcs/bqc1BoqkcWCtqiTnyxCU0wS38L5qLn0p9GkKcICuDaskBz4zHdb86+c9DrwlWyMq2Jprr1Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MrI51L9Y9vo94XBoVktbfqtEazUDVvHqllmNSN5OYg=;
 b=io7pwcReL0jgM9xSuwMVwAaKRujMcfZ/E+zFYiwFNLkctlTgmpaSuyNRnWzi/vOoRoUiRRLCuEy4grbx1NWcEdeyEOdf6pBtOQ1ejXsg0oj9C2LaU4T8w5bqUrKiJikrWr0sfa1ooIxU2yzHJsV0TLksDVGehOrJP8+26dkHelom+Vs9zO26BeYCxotz1ykOjng2qFIxcLRUFlfx8k0g2y9ooTMCiPukd7RufG5Uco8u/6LGEszOQFR6Z6JV+ih2dQqsf4c9DqYZFx47Bngm7/4xK9nnyMgWVLr6539l8NKSLN5DwE2m0MptjJVsXPJm85mnxVSpqzeIUmNmeF9M9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MrI51L9Y9vo94XBoVktbfqtEazUDVvHqllmNSN5OYg=;
 b=E0UL4BKjmmbw0r/9P4JfPrWnY3ObSjqWyJ0Bm+pJndOK/1VmqbvqpxjsbIJ5inqzYe0lL/otF8ZGFlde60IU0JnIPicn+UTyqpVd70AYrJCJrqafQfZciQ8qeX9q9dHbD/HptkqRDFIsFa5xQMAFwjsg3qUjutw9kHWYT6HB3DnqtWo3z2gLuqcGxXQCmgfuWCbzXEB3lpBAMZS2fjZy6fL1zh+BPfhKa8BSy0b5GNrhDDP+vlw4efeFScEMq1+KML3AAmFbC98Q+ZCiyi1uoVOci4Jo9vfKzLMGYmBm3fKcfKfj6dPOAn6KLiq5HkGkVvuQ05xXUVZ1SDqQERkPaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by TYSPR03MB8788.apcprd03.prod.outlook.com (2603:1096:405:5d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 03:33:35 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 03:33:33 +0000
Message-ID: <ea1e3f66-bb0b-4404-b789-0ee264eca1e2@amlogic.com>
Date: Thu, 12 Jun 2025 11:33:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ bluez] BASS: support for encrypted broadcast source
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20250611-bass_for_encrypted_broadcast_source-v1-1-69b8b156488c@amlogic.com>
 <CABBYNZK7LdWs1WmrtC1cB3RCZtHJOjH7Pm4Vxf63RegLfLJEhw@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZK7LdWs1WmrtC1cB3RCZtHJOjH7Pm4Vxf63RegLfLJEhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23)
 To JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|TYSPR03MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: 962984fc-fb5f-4ec9-37d7-08dda961e889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHNtT3ZpRFVGdDNEelc1K1dtbU0rOW9hZXB5b3hPZXh5L00xTDlESU9oM01U?=
 =?utf-8?B?aEl1N0cvK3NwLzlPRFRjV0k2U2IxZjlEdThZTi83NWp5TTJCaTN3YzhPckRU?=
 =?utf-8?B?NFlQOTJuZG1Kd2gwV3ZRRWRsdXlYMTlJMWVEdjJpc3ZDU0l6eUNSeXViV3FJ?=
 =?utf-8?B?Y214T1lZNGpVWWhBNHR0VXdlU2d3NEFCaGthVmExY1hBWWhkdE5HbnRubDk4?=
 =?utf-8?B?bmdxMmhzbytONXZlUjNkcmhjS2ZyRGQrdW9acHBKSnNOVlF6cUM3Z0wwdk1r?=
 =?utf-8?B?M3dWOFJKTWJiUUVHR3IxYXkraXFOT2NJRy9jdWUxeFNoYWJ0cEl3UEtMTm9D?=
 =?utf-8?B?bVlZdHZnNDAvbWdTdXhLaHc0VFBNcG9oNHU2SVE3eThtd3dhVFFqMGlrR3ZQ?=
 =?utf-8?B?cWVRa2RzR1g0TEVwUmFyb1k3a3BIM05JOUlXSW5NVjNkU1NDRkY3NEh5MUxj?=
 =?utf-8?B?QlVBL1dMcWJjQ0FqLytHSTFGZXd2dDlDS2RDQUZWU0NjOHZybjFoaStMd0V2?=
 =?utf-8?B?YUl2ME5Vcld0dzU0d3BpdFowam43RDlsUUZlN2hLVnRhTGx2ZmJ5Z0V4QWJj?=
 =?utf-8?B?Z3Bac2tXN1hPRGNJbktSdHlleUttb0xzSG1GWUhSNTVLVFpPNEZlajViU1Ni?=
 =?utf-8?B?eEpQNm1EaUdrazlSTGZXVHZZaVVENnZVQSsxTlE4ejJuQ1dpcGlFUll1N2hn?=
 =?utf-8?B?QVFUYm0vSUM0RlhLN2E2cUwrbjVoQXN6Tk80RVRyRnVQV29aUTVEakMyQU9o?=
 =?utf-8?B?UGRGaHlkQ3d3NkZwdVdMM0dNMmVzMWo0NGw3NVNsendGN2ZYT3VtQzZrRkw4?=
 =?utf-8?B?L2tlTWhrWFFBSXF2SkxubUFTWVg3RVRnWFNoMVZMNXJPZWdzWWR5TEJwR0cw?=
 =?utf-8?B?eENEY2JPbk5qVEhjcEJNOFFPWXRHM3RYc0Nrdy9GaGowdk81Wjh0RnE1eVc4?=
 =?utf-8?B?eVd3cW5xbEVDVk5MSDNMVElCVE1xeEJUYXdMUVA1cjcxU0xHMy9UcUNyWVRq?=
 =?utf-8?B?OHgvVUdabHczS082WG5zTE5zajYrZDA5OHN3WmVtSDFLbCtjeU1xVlpsL2Y4?=
 =?utf-8?B?cm0wUUdaY05XU2dTbk9ZK2lqOFgyRmV5Z3RtekY0Z0t2cjlkTlZvTUpzV3ZJ?=
 =?utf-8?B?WkkvaHF0dzRHL2ZOdWJYNVlCUTFHWVdQN3hDQ3IyakVKeHo0dDBEMWE0Nkln?=
 =?utf-8?B?ZUJVSG5tOVVnbkZGdVp3UzNPbGwrS2x5ZGhLUTQyMDJ2blVVa3NHdXNSY20x?=
 =?utf-8?B?dmpVcUNtUTlrNHByWW1NLzZJdXdweFVkUmFKZjNPdGpSUlM1eE03czVHN0lx?=
 =?utf-8?B?NlA3bW9MSTBFeDloL0JKNHNuaXZCZk1mWXFETlZ2R2ZCdFlDZDRXRmcxMW9H?=
 =?utf-8?B?ZjdGNVRZSkwzYkRDTW1lQWdlTWhMcGExQU1qRThuVmJaMUx1TjVFV21ORHJm?=
 =?utf-8?B?MTllMnZnSkpDZS9VUkZ0TE9oRHErSXN6ODErNGZWbk9xUTJCdFpNUlp4T0RY?=
 =?utf-8?B?N3d4ZVlwVUtmbHhtcUI5MDZJWDlqS25TY2UwYUs0MmU4clZRdU9PYnI2c1Rl?=
 =?utf-8?B?QThicWIvWWpIR3Z5SXBRTWxIOEY4ZnNpdHNSVS8vdEgvb2ZQRGR5K2lLenA2?=
 =?utf-8?B?eUtaekxXYmFuVU1rSmwwQzJRTlpYdWF2ZTEwQjhyYkFyN2lmZGdUcWdBOFVi?=
 =?utf-8?B?VSt5Mkp2SHphQmZGNFRhakdxTGtmT0wxZmozMzRSTVk0TGR2SUFlUlBxODNp?=
 =?utf-8?B?MlF4a0ZsNzA1RU5HNEdTT0d3WEhTVURwRjBvWVhpTXYvZEpab29sem9GUUI4?=
 =?utf-8?B?dGlsbStqS2l6cHpaNlFBSDNBMjBWc2h1N2dpeG5jRjBNNVIrL1RyM3Zmc20w?=
 =?utf-8?B?bTNLQU1PR1lKbjFjekI5S1l6TExjWlhUcHZndWRDWTE2bmFRdXB4UVhUcUFs?=
 =?utf-8?Q?fiZo3JU3MnY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1FtSTFTRXZvVlNyZlM2SXF4OUkrMGtFdERkSmcydG5URDZYL05BSEdKYmNZ?=
 =?utf-8?B?YzZWVnYvZG1TeUxvT08zSXJ4WjlEYVdraWNwSkZPWFZGdzlEYzMycE9XL3g3?=
 =?utf-8?B?aG9MNmFvUGN5VzZ6N1I2K09sQkNRSFFERnJybEVlaDhldXNUc2JzcEJGVCt1?=
 =?utf-8?B?Nm9CNEw5Z1V1Ym9PZDd3OW5XY0g2eVhMVlAxeHhtcHBFaTZHeDBZRGVyVUs3?=
 =?utf-8?B?bmdnUXYwTElhMkpnQ2pPdHpKcGIxaFBSWVBKZFNsTjBxM3pjSzhtRWhQc0tk?=
 =?utf-8?B?bDNDSXlqSVBndjNUQVozZExLNENpR0RTVmNrNkNNaHpsMVllWFJiWnptQkFn?=
 =?utf-8?B?Q0Q5TGdUaThpekMwSlFjVWFsbVB0OExqMXVsZmVsTXVCWm9aMDFUQVJyZmFF?=
 =?utf-8?B?NG9BV2Y4VkNZWGtpMWcyYjZVTzhody90b2RtWlcxb3I5b1cxVHR4cjdCRC9G?=
 =?utf-8?B?N3FCOG9yM0R1Wlg2SW5VQ1djWFpNT3FrbUI2ekRrUHQvREdxREZPaGZ4VEF3?=
 =?utf-8?B?d0Q0TjhQaUhnc1g3ZlBHYXp2UjF3emlGNGRieUFtU3Q2cTRmQnVucWJZMU5s?=
 =?utf-8?B?R1k5ZHFEbjBHcmtSNFhmeHhTWEhVYldmZjVvWjNrdmNTa3BNSW1sdUJ4UGhE?=
 =?utf-8?B?RyszY2UyT3V2eXRpankway85TVJDOEp2ZzZ6K0J6cHpNTXFVbXRzRVhCeHJV?=
 =?utf-8?B?dEhSdjRBc2c3MVJTM2tHd2Ridktod3BEVFQ3ZzA4bVdnNysxeGdsK0VCYVpK?=
 =?utf-8?B?djZqc1NmcHpiNlh1YUlQZUNlSDl0cm9mb0daRjNWanZWK0lZZTluZGJZRTU3?=
 =?utf-8?B?WGlKVGh5dGY4czVxVmYzYmQxdkRvNkMxRWpRNWJZUmZPakROMmdKeXVFYWR5?=
 =?utf-8?B?SENINyt1OUkvcjBiRkV3dTZIeDdTQ0ZRb1BIVmlzZ1BjUVV6SDlOb04xOUg3?=
 =?utf-8?B?dDNWVlY2a0N1VC9lRktpUnVIMFN6TTlkVFhkcmp0TjhJOUM4N2U0bk9Od3Aw?=
 =?utf-8?B?TkwxRlRFT05rUFRiTXRNbTVOM0FBUkdNMDk2QWc3K1kzaHdlVGVxT2hHYkJI?=
 =?utf-8?B?b3k4M3pUUFNpdXZKTUN4MURwRGdoYW52ZXhzdWlrVHhnWFltT1lzajB6b2RZ?=
 =?utf-8?B?Ung0Um5HWlI1UnRseWh3UVdXUGMyMUhJQ3VlTDlUK0FIK09BUVErQ21CV3Yx?=
 =?utf-8?B?YmcvcnMxaEsyK0s3L2h1ckpUenVsTjRzQU1kaWp1amZJb29hdWlLeno5U0k5?=
 =?utf-8?B?cktoZmNTQUlkeEdYVEZ5ekZLV1pKSUJWYkRySUYvT1dSOG1WemVWMUxLL08r?=
 =?utf-8?B?eU1pTGxuT1NhL3lrRy9FMEFwTG1lUVFPUlg5dm9MMFNieWlqMnpEQ2k4K21t?=
 =?utf-8?B?RnZ0K3BrVXpWdDlhUkxCUmxOdDNjQzFTM254UUxSaUNWS2xrdzZwYXVkVU82?=
 =?utf-8?B?SThQTm9jL0owbkM1QTRiZUVJcTRPK0pqNjlzVVpoOHJUUnFWMC9oWml5U0Fu?=
 =?utf-8?B?NXpraEtKeWh3eGRNN2tucGNuWnVaMWxpemJWYjd2L0JOdWlxN3Zhb0tVaDVm?=
 =?utf-8?B?N0x2SmNJWmNpTStXSFIvWXZvd002SXQrTlFpa2w4M2lVQ0pPZXVST0txaWRk?=
 =?utf-8?B?TUFteUFSWmRVYndIMitXeVFaaFdIQ21JSXV6bkp3dkhiSkxBMm1KbzIzZDZT?=
 =?utf-8?B?Ukw5NXdEZDdqVXBNTno4VFlLSmRZcStZVFVjcEZ6akdUbklmWkhqaUhHSkpN?=
 =?utf-8?B?QmZ3a3pPbkdPeEFUUEUybWtpdEVLTE42RVhsaDRVakdkLzdqZGQvOEdLV1pl?=
 =?utf-8?B?c21FOVlXRCs1VmNJWC9VbHJsNmw4UHFId29rWUZSV3RiWmx6RGczWWRYZStB?=
 =?utf-8?B?OG9OSDhCSHVmTGFHS2c0cUNwVU5KYlJaQjlzbWJQczVKRGNSOEN6YWJybDNk?=
 =?utf-8?B?SjRpanM3VEVqM2sxNEtpdkJmRXRZZ2JMR0VtQWswK1E0ZFA1dFdsQU5tdmJt?=
 =?utf-8?B?ZmlFSHN0UVNacTdONUZoNWVEcmhjaDZVT1YwMjNJcmc4VnBJSldBcW1oYS9V?=
 =?utf-8?B?OWJQQ3dESnNneWVxUWw2d0NuQjFuSE9sTVQrcG9Kc0h6RDAxODJoNDk0djlt?=
 =?utf-8?Q?9expJ87Cc8LaN8GPwYWjtyB4D?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962984fc-fb5f-4ec9-37d7-08dda961e889
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 03:33:33.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBlnzM0mYPn0FOJpiwQAMEkEys74qT1bf8VRWl9wp/vOrDpCx3D4SsaADIG6aaF5EQfwc1R43mjp7Ks9qfqmug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8788

Hi Luiz,
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On Wed, Jun 11, 2025 at 4:57 AM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> If the BIS is encrypted as indicated in the BIG Info Report, the
>> broadcast code needs to be requested from the Assistant.
>>
>> step 1: Broadcast_Code required
>>    > HCI Event: LE Meta Event (0x3e) plen 20                 #631 [hci0] 27.176606
>>          LE Broadcast Isochronous Group Info Advertising Report (0x22)
>>            Sync Handle: 0x0000
>>            Number BIS: 2
>>            NSE: 8
>>            ISO Interval: 20.00 msec (0x0010)
>>            BN: 2
>>            PTO: 2
>>            IRC: 2
>>            Maximum PDU: 60
>>            SDU Interval: 10000 us (0x002710)
>>            Maximum SDU: 60
>>            PHY: LE 2M (0x02)
>>            Framing: Unframed (0x00)
>>            Encryption: 0x01
>>    < ACL Data TX: Handle 16 flags 0x00 dlen 44               #633 [hci0] 27.184478
>>          ATT: Handle Value Notification (0x1b) len 39
>>            Handle: 0x005f Type: Broadcast Receive State (0x2bc8)
>>              Data[37]: 01016698a411bb13019f103b02010100000000110d03506978656c20395f32303938020502
>>              Source_ID: 1
>>              Source_Address_Type: 1
>>              Source_Address: 13:BB:11:A4:98:66
>>              Source_Adv_SID: 1
>>              Broadcast_ID: 0x3b109f
>>              PA_Sync_State: Synchronized to PA
>>              BIG_Encryption: Broadcast_Code required
>>              Num_Subgroups: 1
>>              Subgroup #0:
>>                BIS_Sync State: 0x00000000
>>                Metadata: #0: len 0x0d type 0x03
>>                Metadata:   50 69 78 65 6c 20 39 5f 32 30 39 38              Pixel 9_2098
>>                Metadata: #1: len 0x02 type 0x05
>>                Metadata:   02
>>    > ACL Data RX: Handle 16 flags 0x02 dlen 25               #636 [hci0] 27.455744
>>          ATT: Write Command (0x52) len 20
>>            Handle: 0x0065 Type: Broadcast Audio Scan Control Point (0x2bc7)
>>              Data[18]: 04013a4931614b3a2b7c4b7431722b666724
>>                Opcode: Set Broadcast_Code (0x04)
>>                Source_ID: 1
>>                Broadcast_Code[16]: 3a4931614b3a2b7c4b7431722b666724
>>
>> step 2: Set Broadcast Code when BIG Create Sync
>>    < HCI Command: LE Broadcast Isoc.. (0x08|0x006b) plen 26  #641 [hci0] 27.669211
>>            BIG Handle: 0x00
>>            BIG Sync Handle: 0x0000
>>            Encryption: Encrypted (0x01)
>>            Broadcast Code[16]: 3a4931614b3a2b7c4b7431722b666724
>>            Maximum Number Subevents: 0x00
>>            Timeout: 20000 ms (0x07d0)
>>            Number of BIS: 2
>>            BIS ID: 0x01
>>            BIS ID: 0x02
>>
>> Fixes: https://github.com/bluez/bluez/issues/1306
>> ---
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   profiles/audio/bass.c | 29 +++++++++++++++++++++++++++++
>>   src/shared/bass.c     | 29 ++++++++++++++---------------
>>   2 files changed, 43 insertions(+), 15 deletions(-)
>>
>> diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
>> index b27a3fc12..53fde43d6 100644
>> --- a/profiles/audio/bass.c
>> +++ b/profiles/audio/bass.c
>> @@ -427,13 +427,42 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
>>          }
>>   }
>>
>> +static void bass_req_bcode_cb(void *user_data, int err)
>> +{
>> +       struct bass_setup *setup = user_data;
>> +
>> +       if (!err) {
>> +               if (asprintf(&setup->path, "%s/bis%d",
>> +                       device_get_path(setup->dg->device),
>> +                       setup->bis) < 0)
>> +                       return;
>> +
>> +               bt_bap_stream_set_user_data(setup->stream, setup->path);
>> +
>> +               bt_bap_stream_config(setup->stream, &setup->qos,
>> +                               setup->config, NULL, NULL);
>> +               bt_bap_stream_metadata(setup->stream, setup->meta,
>> +                               NULL, NULL);
>> +       }
>> +}
>> +
>>   static void setup_configure_stream(struct bass_setup *setup)
>>   {
>> +       uint8_t empty_bcode[BT_BASS_BCAST_CODE_SIZE] = {0};
>> +
>>          setup->stream = bt_bap_stream_new(setup->dg->bap, setup->lpac, NULL,
>>                                          &setup->qos, setup->config);
>>          if (!setup->stream)
>>                  return;
>>
>> +       if ((setup->qos.bcast.encryption) &&
>> +           (!memcmp(setup->qos.bcast.bcode->iov_base,
>> +                 empty_bcode,
>> +                 sizeof(empty_bcode)))) {
>> +               bass_req_bcode(setup->stream, bass_req_bcode_cb, setup, NULL);
>> +               return;
>> +       }
> Let's add a comment on why we should ask for the bcode at this stage.


Will do.

>
>> +
>>          if (asprintf(&setup->path, "%s/bis%d",
>>                          device_get_path(setup->dg->device),
>>                          setup->bis) < 0)
>> diff --git a/src/shared/bass.c b/src/shared/bass.c
>> index 7b9e0da63..11ad59e3b 100644
>> --- a/src/shared/bass.c
>> +++ b/src/shared/bass.c
>> @@ -964,6 +964,20 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
>>
>>          gatt_db_attribute_write_result(attrib, id, 0x00);
>>
>> +       for (entry = queue_get_entries(bass->cp_handlers); entry;
>> +                                               entry = entry->next) {
>> +               struct bt_bass_cp_handler *cb = entry->data;
>> +
>> +               if (cb->handler) {
>> +                       ret = cb->handler(bcast_src,
>> +                                       BT_BASS_SET_BCAST_CODE,
>> +                                       params, cb->data);
>> +                       if (ret)
>> +                               DBG(bass, "Unable to handle Set "
>> +                                               "Broadcast Code operation");
>> +               }
>> +       }
>> +
>>          if (!bass_trigger_big_sync(bcast_src)) {
>>                  bcast_src->enc = BT_BASS_BIG_ENC_STATE_DEC;
>>
>> @@ -977,21 +991,6 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
>>
>>                  free(notif->iov_base);
>>                  free(notif);
>> -               return;
>> -       }
>> -
>> -       for (entry = queue_get_entries(bass->cp_handlers); entry;
>> -                                               entry = entry->next) {
>> -               struct bt_bass_cp_handler *cb = entry->data;
>> -
>> -               if (cb->handler) {
>> -                       ret = cb->handler(bcast_src,
>> -                                       BT_BASS_SET_BCAST_CODE,
>> -                                       params, cb->data);
>> -                       if (ret)
>> -                               DBG(bass, "Unable to handle Set "
>> -                                               "Broadcast Code operation");
>> -               }
>>          }
>>   }
> Changes to shared shall be on its own patch, also please add some
> explanation why you are moving the code above on the patch
> description.


I will submit the modification of shared/bass.c in a separate commit.
There are two reasons for moving cb->handle earlier:

1. If the function returns directly in the attribute_notify section, 
cb->handle may not be executed;

2. Executing cb->handle earlier allows the stream status to be processed 
before notifying the client, saving time in the subsequent stream 
processing.

>
>> ---
>> base-commit: 95b72bbf1fe42216d02a5ebb99bd18e9b69b6064
>> change-id: 20250611-bass_for_encrypted_broadcast_source-f68417fdee73
>>
>> Best regards,
>> --
>> Yang Li <yang.li@amlogic.com>
>>
>>
>>
>
> --
> Luiz Augusto von Dentz
