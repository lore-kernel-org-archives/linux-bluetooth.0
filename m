Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794302044;
	b=2OdhPML2Jd3bWm/IK/4ESPFpaa1FF3bMNsUjjm3CbGbFxWnCMdcJJcfSb3ETFKSwmXcy
	 vGX5dBA7COQqszNDDE9i6Yx6wvvLLM1myGxdOKpwDba7HW7M1RvUD0Y33RivTkLKEhjKZ
	 9MmpO8ZXgsU+APdorN31Iu6fnzNYf0cSd+HZLHd6WeI0eMAmKmI+JZ0rHXyTFCPJf6Whx
	 Fk1dB6W2xlwz0lV+xEmb9puPCtTgy4bcQvLfSzeSpnrP1xrjluO7ICbgnNpyIp/JP7fmt
	 uZJEqIEzNP6w6gwO6F5U/QBHFrApKD56GYfmODMz9H0rHiku6Am1g1tNa7aKBj15fGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302044;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lKMTZcL/2HSGH4V1P1AJkQlOVsUbQZgpVGcYrwI1OtM=;
	b=tB7vBpD9delkt9+KD3Onadg6SR5wC+U49IF524rmbWy2ip9Rcdl2S/+tNravB+l1dVzO
	 1y7GZ/l6iqjebDqNJUIoMr5fGAl49YaBck1FWBRJYts6ijXwkICd5MjLmco78pSzBP0hy
	 LRxfTgKn5WvMvL0931D+iZmbsf4gLOtIzCpHOTDbVNmDmtr5iszZs6tjWWyHkeuaI/PaZ
	 +Kteuf2FZ4k2WdbHxscibzbxdXdhQq7ynEqxkk+qPP4vXWDeUex1aGVZLld/d/OJVbR19
	 4zVvotLXpd0N5HJ4O7DTy3OOA7BbM8xM6iYNHYMETeX9FB3VwJbgczhJqlipKz3Ch9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=xREoCknr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.83
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023083.outbound.protection.outlook.com [40.107.44.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E12A606A321;
	Tue, 10 Nov 2026 09:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E12A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=xREoCknr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQoPKLJrEOgfXFSUZquIIM+a+BBRDVHDQ24RXCoq4X1uQ7Ddw+zCxFHF0y+6WHMMJ//TU+ImayHP/HKVOzxLMqAuQaHTlsUUl7CYMO6Ipe7X4kOo0kScCUUxkmSDBTsjQxQnoiqRWC52GSUYNZ4lxanetiWMGvLMfNI/iXRMEl6nv/YzY5cYQDp430DBOQT7GjVvlxjKW27U91nDuGU+65eplKc9yhcTIbTdzfp+n+Hn6oYs1nAALgjUmAjyJoyVkwucAcem6ODrKm5ZUZzjlsxJIkBh+R8N/2MYt5yxuMua9NezZjQXHs8v1ZHkwbbSqVl3z1AHuNh54lRez3dn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKMTZcL/2HSGH4V1P1AJkQlOVsUbQZgpVGcYrwI1OtM=;
 b=rOST+va+hEBPoAfeNiVK6WG18hd+dG81l1IbBpLgNBoCSkrTpqsIVUvZFU3bMvrHuBUAsqdcH71+0IfgnAW6s2ZgWty7okDpvRqTyuiNTExuvkLrno7BH52OjzaYZlJndJSY4Ox97VQtxdAyvQx2obaf6JTe9hEss28WnES7c6hMYJnt2D0T/ANIfgNaTiQKOuJanoVXVASkrZsWuOu3GmGGGZqiwqWoHjkiPACWV5a+FBjZEXSFVo9lS1Ismi7pmkYkdbTU39Az0g/8A8+pXBtiBLMwQpBsPf3Y+aQPJLkZa1gGjvj2vrxQdsPxXUQQ/ZKxzKoA9qlzX1tENf6/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKMTZcL/2HSGH4V1P1AJkQlOVsUbQZgpVGcYrwI1OtM=;
 b=xREoCknrnRyk45wGVqC5d+NdnYaWN7L8dQ0k0eSiVmJ1n0elJnY9m0FxILqUeLKU1B7jGENFLV8vnF31KaASLV6HhZerdb0MCQTSENi1AfFj7eC09lVAZEp5jpXUNiuPZikPR+awVm8Vss94qOWKyNyZ2Tgn1KTcpaHu4QunZ1SS20oaGQTHlqJvbnlRMMzXgSvnDm0N/PVzTbM52ktwDTFVjjrhOZiRl16bSGUOoIstxf5aFdmOoG/CFZCEMcLOzkIsDrDe/tJQ2pGaHBFpHBoIlpeBDVOAhejTrYFahz0T+cXKyD7/beX/p8InINEh3irkIp+7HMM255UNkOCqrA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB9035.apcprd03.prod.outlook.com (2603:1096:990:7c::13)
 by JH0PR03MB8049.apcprd03.prod.outlook.com (2603:1096:990:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 09:14:01 +0000
Received: from JH0PR03MB9035.apcprd03.prod.outlook.com
 ([fe80::77d4:2931:4c4e:1cee]) by JH0PR03MB9035.apcprd03.prod.outlook.com
 ([fe80::77d4:2931:4c4e:1cee%4]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 09:14:00 +0000
Message-ID: <831f4178-028e-4376-ba42-b3058bdbc04a@amlogic.com>
Date: Tue, 10 Nov 2026 17:13:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] Bluetooth: add a quirk for controllers that hang on
 Write Current IAC LAP
To: =?UTF-8?Q?Christain_Stefan_K=C3=B6ver-Draxl?= <ckoever@outlook.de>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192338.209574-3-christian.koever-draxl@student.uibk.ac.at>
 <2b75bc46-3e93-449a-b13a-2cc4ba8cf755@amlogic.com>
 <MMZPR08MB5493152BAB536106F1884EEB52DF762@MMZPR08MB549315.eurprd08.prod.outlook.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <MMZPR08MB5493152BAB536106F1884EEB52DF762@MMZPR08MB549315.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0204.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c3::8) To JH0PR03MB9035.apcprd03.prod.outlook.com
 (2603:1096:990:7c::13)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB9035:EE_|JH0PR03MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: e04a02d1-7f6b-44eb-d697-08df3f0af516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|261009223027099003|11063799006|4143699003|56012099006|261021121427099003|261022075727099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7ReRmW5yA665JgGkTv1mjF03ixErT5bSnCbLfCP/Yyke7tZtkBeNHNWSFHFZ8VdEVrq54UruItxmESkuJP23gu75TAqQlppGb45JxyngIlviG12VZxji7L+G4F9VlSWEljZ/TzgXjcnhV9fcrIABCF2aHU0HMyESBrHUeBP+nIIEPEokCB0A8DY4Ozqrriz58lpuUoLUBcwtRSFNopX9S7NTST+LXI7bwKIWD/8GiUPb63QdZmdQHsrbqpeEG8n7UU8ltDTNXB9SoE69izZkp0JdT1iUtWLwtma5vKKRJtSNJRWrD/udquW9GT3DOhdqXzmmMdT9G6X790xxEE03uJN+cRRIk3v28nDESCC8qAnPdWmrw0j+kMTf1kUiybFNTUr6zcIdmhe+y5Z4HBwU2HRfk+Pttbg380ACQciXvYe1lgPf8LJiKy6O1Qx+29twcdVfLp0oHlsLDbsux94zJEYHbCbOypCq92nOnH5D12EeSgq5y9q/m1CTfu2WhqjRR6WsFig2WDMmOGkNME/ziueeanP9UkPbCTfnFjlXolVRhXUVdoXm6fjRO8tPJ7JuDEzUn5wfl42Lm8Jsx+PZtv/dP2yYAuBsGoHbeOHxynUixL1lDxOEKlFTN8TrJEHL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB9035.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261009223027099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022075727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHU0b3VNS2RrSU9DMVFZS09LZm1JZnZJTXp3RjY0MERXNzkwN0M2TGljbGFx?=
 =?utf-8?B?eU1wQ002dmJIVU15dXNrME9tS2laNktYZzBOWGVrczlTd3dySzZUNlJHT1Bq?=
 =?utf-8?B?N3duU21Mc3Y5UVRORk13WlArV0V5MlNCYldRcnhwR1pwN3pnL1FXQmpNc0hS?=
 =?utf-8?B?MHp5eW1qUEVYY3czbGx5VVRjR3hwUk85MmZrSnNNMnpQNUdNWTI1RnZ5c2dZ?=
 =?utf-8?B?VFp2WStydGM2S0E3LytkYkxXVkdzUVhLdVZqNkVJKzFQbjQ0ZnBTM3FTL0h5?=
 =?utf-8?B?VWgrc0dlaXV5MU5ucUtMUmFRbkROY2UxUlRFSzhUcXhlNEhTNTZ0UW9vZ3gw?=
 =?utf-8?B?OTdxMmpGc3lRODNuRllVS0gyY2JkY2NaajV1dmRiOEdxd2JXeVlueFIwNDBw?=
 =?utf-8?B?WmUxZng1ZlQwZnJGZ2ZBeDBVNm9tVEcvSmF5NEZFYWZiTjFCbW1CaFlpVzhK?=
 =?utf-8?B?NFpyWFlOcEZ6VktoSk9vb09NSzVhRkNvWkR5YVdLZTNTNFVEeThiNkxxdWM2?=
 =?utf-8?B?UEtDNFEveHZJMXVVcDR6QUpEdWs5ZVVBclpTSzhNbkRCYi9oSXVmeVo0T0Vi?=
 =?utf-8?B?bmQvT1dQSy8xd2xpenR6Z29XY2RxV1grQTVQUnBsT3hNeHpjTmpkdDVwRHhG?=
 =?utf-8?B?UnlDM01Jc3lKa1pxR1JWb0xwd05DQmhRNVpDZ2hpdWVyZ2xRYTBSaHdNSVh4?=
 =?utf-8?B?Y3NsekUyUWZPTjNzdWwxYUJMdU1WOXFySmhUaTI4U1laYlJWd3FtTUZGUFY3?=
 =?utf-8?B?dkJQQ3IyMHFNaTFXZUM1L2wwNnRLMkRPZHppTjd4STdKTnBZVlBGeHJVaitz?=
 =?utf-8?B?SjAvZzJxSFM4dGY5RGliYXNBbmo0TzlabGFKRENvWHhEUG0zblBiK2dJcHl5?=
 =?utf-8?B?ZCtTWjl6VzJHWm4xTkJUM0NRbFpTT3dmdXIzc21JNlJpdXdCQXBqdmg0SWw4?=
 =?utf-8?B?UVI3SXpuUlc1OUQvRmc3K0c3OG1hL1BvQ3ZFbkFrNDZPM3NQU0wvRGFqNXNV?=
 =?utf-8?B?QzZNd0M0Z0J1TEM3Y0RLenFsamFYMkFqeVh0Y0NwalVIbnRFaHVJSzdadHJl?=
 =?utf-8?B?NjN1cnlmbjJmNVdPSGlMdEh6ZUduY0o0RENzMkVOWWJhWVVEdGFrakpWcTY2?=
 =?utf-8?B?RitLUXI4TDM1ZmxveTR6QVQzUS9OeDIxNmhXbVVuMDUyOVJpSlpkR1J6K29U?=
 =?utf-8?B?a3hmRmxyZ1FMU2V5SlZMMXM1azUyRjJ6U2crV08xNGhsV0dIZmxsNkEzV2VR?=
 =?utf-8?B?MFU0MUR0MmhNc3dqYXRGaHM2MHdDa3JtOHhuU2haRWFGYkV6cTJTd0Znek1x?=
 =?utf-8?B?SzRvVFV3WUR6Mm1FUDZrc295ckpJekJTbEpUczZ2UnFnc2ZTRlNmVXB1eHE4?=
 =?utf-8?B?VGNocHA0VWFmTy9KZnUzajdOMFV4SWxWR1gydGpzcGx2WG9hbFNYdW1NZ0tq?=
 =?utf-8?B?Vm5WMTM4MWVid3VQbDJYZjJwTlFtVlo2VW1EYVo2U2RsSHhQUEpuOFp3VjQr?=
 =?utf-8?B?Rzh2RG9BR3Uxb1R3ZEphUjV6KzMvbXVLenhMVU9JTEdxQkpBZ2U1Z3hDMUxM?=
 =?utf-8?B?NkNRNS81VWpVTkgvRHpUQnFPbXdzN2FSMHBSeVBwbmUzTFJPM3k0cXJhVkFB?=
 =?utf-8?B?d0w4OXZKTnF5MldlYi9jSyt6c1ZBVUhYNEhmdXNLOFlEeFhJSmVTRUEvTWhk?=
 =?utf-8?B?a25aZlpsU3ErYUNmZUVrdmtFZWNKd0tXYlUzaUZaOTFNejFGQkZwWjVBMVM1?=
 =?utf-8?B?MUVuSnVHYzdDQjdwV0g0V3BTdTlMVm0zWDM0TWpnMXRaTm14YU9aazFjVC81?=
 =?utf-8?B?MENuRStUbklaQVEwKzhMSTFZNTR4TXkyU1RaMzBSOUdFM1ErNjZ2b0FSRTBr?=
 =?utf-8?B?ZjJCVXMyN2lnV3paWm8xTHEvQVVCdzhuNlRWblZwWmZ0bDhLQllIMEI2ZTZK?=
 =?utf-8?B?SjFtRmZDVjI5VzZiSmpsKzZ5T1B5dWVpL3VEQ3RzVkpuNzFuMjFicStlRzlX?=
 =?utf-8?B?cGw5QjJGUmt0OVNhUGEwWE9lUk1FMTZYdlhIRm5ZNDlmL2ZaU0hzenpCbzF5?=
 =?utf-8?B?azkrMHFZdkVXOXFCUE1ZWlRQc2UxUWxyU1B2aWFIU2gzWWZMU0J4SUtORlA5?=
 =?utf-8?B?eU15L0RPdTFHTTV2SzRhREJZYnlIMHFCcUpsa0FITFE0bXBZSnVGR09pZCsy?=
 =?utf-8?B?MzZiMlY5VzJZMXJPSUxIemI5K1MwV0Nja2xMNXhsdTVzQk0wVklJeXpPcU9z?=
 =?utf-8?B?YU1ZZmxHQlRmd2V3TEN2V3FYR1dDWENtNkpDZlFVdkJGalFEb21WbEFCVTJt?=
 =?utf-8?B?ZWNGV3VKOEFGblo0OHZQZWhRQjNxb1hJdnNuaEFlRGYxMEdlM1krdz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04a02d1-7f6b-44eb-d697-08df3f0af516
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB9035.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 09:14:00.5778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAATww62ykXvsmA/S/QyEFRI3ZVEhysMQI8GDxRHZzF+fjamhJMCSxuwFCfCL0/D5JlOHMrmGSlVYkvHaNdZCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8049

Hi,


>
> On 11/5/26 10:24, Yang Li wrote:
>> This appears to be an anomaly with the firmware binary. Could you
>> provide the FW version in use? It is logged during Bluetooth driver
>> initialization.
>
> Hi Yang,
>
> the controller reports
>
>   fw_version: date = 09.08, number = 0x15d2

Your firmware bin is outdated; this build is LE-only.

Please test with the latest firmware.

https://lore.kernel.org/all/20261110-upgrade_w155s2_bin-v1-1-4533ba6005cd@amlogic.com/


>
> On that firmware the controller stops answering any HCI command right
> after Write Current IAC LAP, until the chip is power-cycled. If a newer
> firmware fixes this, I am happy to test it.
>
> Best regards,
> Christian K.-D.
