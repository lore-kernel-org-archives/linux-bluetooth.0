Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.39.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793956681;
	b=VBqzu1n6XslMd2jd+68HQM0W8piLvc/iYJIM5/RLhcT3F55xlfPjUrOJ4S2UIJCUN8u7
	 /ftMq3ghgC9PQ1zDiv2MrwsxVFr/xxx3jdI1Mf/amvSHGbDsp0+YVJcCqKnDRFShUroq4
	 uV9KQBPdf8bYHUla/bfCj4G+bzePpeRHCLN9XYArk3trE97RZLc7rriywN/iaIbv4e4+N
	 8f394kKwpajqaeGN/x3QNzL8S13C5NZ8Dp2P1fJYvK9swFyx4MBzXVLKtlZHDFBguk6Fo
	 4/3OlKeRw3JyiKd29DOrx9jW6IvcHgX1c/f9eniSf/qjr4A0bvXiP4N5Yecdv4WM+dg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956681;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Cx5h3M1TL30dmQ4XCBg8vfNb6yHYk3HZydwKiDxqFx8=;
	b=JM8gERJsugNjeAdvOYIgN3v7SM+/YD25UPWtRbj8sRgRTOesLh92fBeJLm20V15LJxcj
	 ziiIqN+eZmLt0pitzplhLiPBvHGytGOois+VbljG2pb8BJJtAI9xu7h/3hryZvQcPa8Kj
	 tYT6PjObNRzD05GWViBmoVqoh4ZFBbaSsjWrWzhlfj7oRRr+6/FdsE/PpWROvJWz5EETW
	 JeowZ791d9ugpmo0/jzXLu7KZtePx6+XF+GovCoDsW5yZlQB455jktiC5fPE7SJ6Pkm6J
	 OC+uq+NpTpBHFKZ4OIp1ZndRQLSGELZe4kJt3cUbN5O8JbSX/Pjm0HDg+w6WuJh8luQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=outlook.de;
	spf=pass smtp.mailfrom=outlook.de;
	dkim=pass header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.a=rsa-sha256 header.s=selector1 header.b="ioO/v1IG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.39.35
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011035.outbound.protection.outlook.com [52.103.39.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618DA606A326;
	Fri,  6 Nov 2026 09:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 618DA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.a=rsa-sha256 header.s=selector1 header.b=ioO/v1IG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQg555jPJXn6V7qPZscJhBCrtmzao6Wfl571Qrm32jYBxOgzxIsEZVpiwgHcsXZBWvl6cnh5kJeAs4sQG5tklkc63lyHxkyTvYvLwTsdRbEKzZbxyaMqg72V6++7bq1E9ThsI1lYMGtJHK3OwFRD+Xn23wrrZkraQy0ulARJWthEri6I1NsN6/yhafuLF3fiU7mE3tMx2N34fNxFB7UXsBGKkOnxQDkA9yYxsbfuWmFx9s4wtIFVZAz7C90tcx1qyG2hPPaFYonFe1jgBuo31OOEdXAycwuPk8Iy5S7wAkdebYAvdvpNwY5b/fAneJwJpVVNaF7yorFAZx9BbV1CRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cx5h3M1TL30dmQ4XCBg8vfNb6yHYk3HZydwKiDxqFx8=;
 b=eUSol9xVL+/ITfMdTMguNMWup5CanhN2D466EoTZXiyXBwW0O+8xtG9V2MGq3atVKEF9Gi6h0l9lTDHCCbZVR97NsDIEaCmZIvkIp07fn1AXY/uj4ryO0KDAmR/88z2S7vvBA1jwlz1ElgGmZJlaEGN9By7pSa9ydT834qOkTd2KghHPNdy5fHyuXFeUbQEhBX4WXYU8D9q2/6ke6w81JVOwZDcAz912o8+W4GagFYBLs1KQ6iKUKeYj/Z5PdoX+hLyAkX/o4C85bd6cYeAcvv2cGHWQGDbSsOc1k+gnEXj23yfa3KdDGjpYWEXzBceD7XFZ3BKJwPlc8OBs7m4feA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx5h3M1TL30dmQ4XCBg8vfNb6yHYk3HZydwKiDxqFx8=;
 b=ioO/v1IGXkCmiZJL1mzofpvazVNAM001/fAmK0ow2bZcUbL81dl4+xPAnMPl/eIdbwxdEZDI/dFb8c1E3ez6/0Rjz8iez0NMJGfbUTv4/d4sWEbitgMAoxTHtOcIwPLOU15ECMp4ddptfyOgVeW5Xvf62SuzCJVbBKWCKr1By0sCt7zdcOz0StRC2Nx7MqfDchzTq8ta3jzML51F82KkE4Q7/lFlSVjrYmFWQCNe26c68D1Emu4cbXSEQG2H9wjheKaclawD/WEH22ppFD5h7Lr7lQlw1sqRF58tndc8/AvGMa5J+8nRCD77OArui7i3wcEdcfkTXFzKfkZQ46Rd3A==
Received: from MMZPR08MB549315.eurprd08.prod.outlook.com
 (2603:10a6:190:28::19) by GV2PR08MB11691.eurprd08.prod.outlook.com
 (2603:10a6:150:327::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 09:17:57 +0000
Received: from MMZPR08MB549315.eurprd08.prod.outlook.com
 ([fe80::21ab:3314:172:c7e5]) by MMZPR08MB549315.eurprd08.prod.outlook.com
 ([fe80::21ab:3314:172:c7e5%5]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 09:17:57 +0000
Message-ID:
 <MMZPR08MB549315933A342E32853DED71E1DF762@MMZPR08MB549315.eurprd08.prod.outlook.com>
Date: Fri, 6 Nov 2026 10:17:54 +0100
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Christain_Stefan_K=C3=B6ver-Draxl?= <ckoever@outlook.de>
Subject: Re: [PATCH 1/7] Bluetooth: add a quirk for controllers that cannot
 enable Secure Connections
To: Yang Li <yang.li@amlogic.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192338.209574-2-christian.koever-draxl@student.uibk.ac.at>
 <5d5a22a5-b45e-4cf8-9066-e0e641d719bb@amlogic.com>
Content-Language: en-US
In-Reply-To: <5d5a22a5-b45e-4cf8-9066-e0e641d719bb@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0131.eurprd07.prod.outlook.com
 (2603:10a6:802:16::18) To MMZPR08MB549315.eurprd08.prod.outlook.com
 (2603:10a6:190:28::19)
X-Microsoft-Original-Message-ID:
 <1efe602a-31e4-470b-bc2a-2bdf73b2fc71@outlook.de>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MMZPR08MB549315:EE_|GV2PR08MB11691:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c452cd2-75c3-4d9f-97fa-08df3be6d86f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|16051099003|19101099003|4140399003|6090799003|23021999003|15080799012|8060799015|19110799012|5072599009|40105399003|52005399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm1SZTUxaE9ORlRNNm0yKzNsbDJwQnJsVWFpa3dGM2xCRS9qTHZWU0VhVGI0?=
 =?utf-8?B?OGJIZ1FGRHZiVHVLd052N0dPVmxpZGFha01uNjR0Skk3OFJpSms3OVBTUVJj?=
 =?utf-8?B?dkJvVzJJWU9OaTFZVWRjY3Voc3krOWl3VVMxYXl6dndwM25qSXNrN1k5QkpG?=
 =?utf-8?B?a24zK3pLRFVzWHR1MkxNNG1UZ2kyQVpTYXZueTRZM1hZYXYrUHZLbmFuVlow?=
 =?utf-8?B?b3JuWnFhRUQ5TlV2aEozTDNmbzlDWFNpdDlEa0l4NzY2MUlqbXZkM3dDZEFC?=
 =?utf-8?B?MVhFVUcvcnFVeHIzSTBwY3ZSR0RGT1ZqdDdpdkh4N0RzWUJoYUhCL29wQzB6?=
 =?utf-8?B?aVc5VDBBcTE5c3lVL2Q0TjhialgxdmZKajd4TEVHdnVoVmJsZHo1YytXNWhl?=
 =?utf-8?B?QW4zbVJvMDFNeG04cjI0dnVmRkdzNTZZRVNPbXQyeVBSWVY0N3daT0lWQXVT?=
 =?utf-8?B?Qkk4OTBiMnRwWnVkeW1XSGJ3OWVvTjQ5ZVFCRld3YWM0RVQ1UmQreHQvbnFQ?=
 =?utf-8?B?ZFNEZUFoYlZTa2s1QVVGSDR2S3BCVHV0d05taHRSQTJ3Q2svTnBEZzJNZkdn?=
 =?utf-8?B?dGxQbGJPdnFuaFlmVzJkYk5XWXNKTlhLbVZleG5yWlBDV3BJSEdkU2d0YW42?=
 =?utf-8?B?VXIrRzl0R25qWmI0V0Nid0o1bWtxcE92R003ZVFwVjF6TWxPajNMaU9FWHcv?=
 =?utf-8?B?b3VWSk1FbUpJUGplb2VBYXlhQkEvcm43T2lQWHlzUFh6cVUxZm9CeVVacERP?=
 =?utf-8?B?NWlTaVg3VVF2K2poNVF5ang2L0ZUd29mQUtDZFpqbXZKL2Z4d09malN3bHpD?=
 =?utf-8?B?YVdIazYrUk5SY1N6OXBsdzVqM2wxR3ZoUWt4UVF3Sy9PSW44aU9RK0F3Ry9m?=
 =?utf-8?B?MnZyeTF0SkNna2VVaXljVmdyQURVOWt0ekdFbEZra2tVUWhQUG9EbEY5OGhq?=
 =?utf-8?B?anIzNmgzb3lCb1VMSkw3TlUwNjgya2x1R0dsdGM2Qmt0MzF0RzBaUEVxQTBh?=
 =?utf-8?B?UURCYy92Z1UrOTI1djE3d2dZWU9ZbEliVktRODZ1Q245cjh0MWUzTitQTkpD?=
 =?utf-8?B?YXNsNkxNSDhMQzA1VGE2TVVJVEdTTFdPOFpJZjNRSUliYXpwWVpmOVNod0Ru?=
 =?utf-8?B?d0FLWEpNOEFCMjFMQjdRK3pHcFRreXNkNkNsN3dxem5xbWJkL1dQcmhqd1Jl?=
 =?utf-8?B?dVJBcmhheWhKSDdySDAySEJrQ3djVEFrTml6cldPM3dwa3I1MjNSaWRuWjgr?=
 =?utf-8?B?NUh6OWk5TTlLWUl0VyttZlpMTzJzNDZLbkVldkNwWi9sZDRwT2hUTm5sQUdU?=
 =?utf-8?Q?hLZ1d81/xW6a6t9l3D9cZEZQiXKnHzJ3P+?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTNncWMrczkvVGd0K2x5VDl0Rm1TaDBUOXNXSnkrd0diNjRLZHhLSTRFdTg5?=
 =?utf-8?B?WVo1aGg4aDk5M2Z1SXdtNStVZjVBa2FJTUYzMytpdWNIeG12cFA1NEZoS0hD?=
 =?utf-8?B?K05YSVgrL2pWODBwYktUTS9jcm5LeFBQSmw5dHJOdHdIZVRFTUNUZkhMdW5s?=
 =?utf-8?B?c1lLQlZuazUxSzdmbExzeDdmY1Q1QUxNR2ZZZnVBb0oreWtzOUxreWo5Y0tT?=
 =?utf-8?B?UGtrdWpLZTRYK1FoRUgvaHRMYzk2N2JiL2g2aXlTQ1VPaUtSTWgrVHhVSHpY?=
 =?utf-8?B?bThZTjFCK0NVZEZaazRKZE9QcW9Idit6aWtzdlViNFZyenRUMDdndzRjalV5?=
 =?utf-8?B?T3ZtVWFwbjZDYWg4YTdJaTJJSWpCQTY0bnhPU1MyUWFDVm5WRFlZM1EvT29r?=
 =?utf-8?B?MWpSTGVIeGtuVUhrMEhtNDkxcnl1RW5ReWhZWTNqdHJWOU9oQ3IzbFZYWWto?=
 =?utf-8?B?TjFEUDJ4NHNPSE02UFplSnlIVXpRNGRmNHhKY0xnNWZGT2lBWGtGWm1WbjhI?=
 =?utf-8?B?Q3Q2aXRHUHRraTJJaVZ3SnR6dUNUSFpHRi9vTENMM3d3YXJDbUpNaGtKZ3Ay?=
 =?utf-8?B?MUt0SC9vZUpxd2w5VmlxL3dFZGJoRkhLaHFGTGsvOVZnMGh3VjZNSC96QW9P?=
 =?utf-8?B?aGs0aDJ4NTR2SUp6TTFza2Nvalc0aDRueDhvYXlkeTFLYlB6d2g1VVJmMjV1?=
 =?utf-8?B?aW5IS2R0ZmNSdG5ISmNDT2ErUTM3cHVRa0RQbzRTa2xnTkRUV09yTjh3Q05D?=
 =?utf-8?B?ejJTTWVvS2JmSlpjVzU1RE9ab0MvU09wc1pNa3BsdEhoUkVSL3RHcXZMeUI2?=
 =?utf-8?B?VWxWb25iRm12VTgwR3RITEtPMEZtbEFoV3A5eTFpOG56UjMwYThXZ0N2YmZF?=
 =?utf-8?B?QVFiakpZQ2F1bjA1MmpMaGhUbTJXWndkKyt6cHFybUcrblZySmQxUGtZYlB3?=
 =?utf-8?B?MGo5N0hLNEsrRWlGV01ORW5sRFZVNWI3Qy92Z2RibzZGb2FvVEhrbWtPeWNv?=
 =?utf-8?B?R2ZVdWw4RGg2ZW54d3QxN21sTGxmY2V0Q1lXcjJaU0o2NUdOVjY2M0FpbDUy?=
 =?utf-8?B?K2dUVGMyd1ZqMzA2TFYvZjBscWh0Tk81WFVRbFpEeTJISVJnS0RqU09EUEFT?=
 =?utf-8?B?SXNvWElLdVduRkpUQXBNMDBHSURyTFo0bE1sWVJidjZGeUpSZVhvU0FWVm1Z?=
 =?utf-8?B?dzJ1TUtJdjdtTFpSR1hZNktUREJTaS9iT2V6Mzk2Q01xaXJ3ZW1hdjNOODRl?=
 =?utf-8?B?aWZTSFEyQ3c3SDgxTWl3alJxVmVEVk1vQytQdCs2K3BNL1BSSnoyWm1VcW1H?=
 =?utf-8?B?Y05SUWVxWVI2Um9UMnZFenRrNE1YeUZSZTJUZ1FSUWNFNXpLdHVaUmgrdGEv?=
 =?utf-8?B?d0I1Q3dmOHdaVzIwNm50TFBNaEp0SnFONlRaTHNqMEJUbDk4dzdOQVczUTVP?=
 =?utf-8?B?U0R3dVpueC8xazlzaDdtUkZGVllWVzVSbm9jRHNwYXJBbFlBMnV2cy9Jc0lJ?=
 =?utf-8?B?K2ZWdmhQa1lqOGtiNVF4YU90b0dXY2w1SzF2Z2hadHV2Tk9DTEd0Z2dTaExP?=
 =?utf-8?B?Zm94bDNPcnZaeXBOMkJwOGtNSDlkRGVPY0lqU3hFb0RRaktFUWRYM1B0NEJq?=
 =?utf-8?B?MFNZdVNyRXlMMFlibmsrdzA5R1Q0aS9HVTZNcDREM1FYbURlQ1BlZmRrS0JY?=
 =?utf-8?B?TU80NnA1bTcvenVyRUp4Zk9QYjRCZEpPTFdFeXBlOWdWVVJiQnE2c1ZlblBH?=
 =?utf-8?B?STBqcHUrQXZ5SXp6S1dGZ3lLM3lPaFV2cytFOFk2ZVpYWUM2SW05WnN0RmF5?=
 =?utf-8?B?K0NKeWpsVGRGNm8vRXZzQzhsUEJBRm05eDcvYVMwbGQybHpkcjFibExIUWNy?=
 =?utf-8?Q?tM0E43ImfzYjp?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-fbb9b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c452cd2-75c3-4d9f-97fa-08df3be6d86f
X-MS-Exchange-CrossTenant-AuthSource: MMZPR08MB549315.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:17:57.0998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11691

On 11/5/26 10:19, Yang Li wrote:
> This appears to be an anomaly with the firmware binary. Could you
> provide the FW version in use? It is logged during Bluetooth driver
> initialization.

Hi Yang,

the controller reports

   fw_version: date = 09.08, number = 0x15d2

The firmware is not the linux-firmware one: aml_w155s2_bt_uart.bin from 
linux-firmware downloads without errors on this board and then never 
starts (no HCI event after the download). The one that works is the 
firmware embedded in the vendor Android libbt-vendor_aml.so of this box 
(X98Q, S905W2), 0x60000 bytes. I load it as aml_w1_bt_uart.bin.

If there is a newer firmware without this behaviour, I would be glad to 
test it, and if it fixes it I would rather drop the quirk than add it. 
Is the linux-firmware image meant for this chip revision, or should it 
start as well?

Kind regards,
Christian K.-D.
