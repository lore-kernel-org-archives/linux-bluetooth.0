Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.78
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793845190;
	b=sD8vzd+nqDX+ZqgF/gZ3MuL36FZmXPOM7ozvgS2fNQQ4VuI/Wb4PUZZcflWJV614f8Sq
	 lz+FesUUd2iXwAx9HOKDHkk4ZWrud9AxUF5ojcgsmBDoOYdexvDOFvV2FwxlD2jV6tBmY
	 DVDRSUxtF5ltg0o4YbRNGeJ0cZXlfQsfsn5gtYkzkTw3eqUvPv4ra9lTEAwcppUVpLfUR
	 57Ju2SMH93tFaCgrR14qmrvfd/kCOqt4zaYf7GXiOiq+Wq6UI/oCGhAMy6o5VnFc/230M
	 xxDDIlVtS/c8mSysDafnuhJmthTlBa8JQ8KsR5la+Bq8SArqnU7hWeHCSP5+W/vLxSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845190;
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
	bh=4OfZVM5xLAac5/cWderjKSVPRlsgmoZyVImth/MXgV4=;
	b=SOx90G0nL04IWfsYpkbY9kB2s6SNO3xbLYMgokX6R7wLDNpinbutLjgylxY5eKqB26Y+
	 XLKhNyl8LdT+NqBcU8xEnkBv98zpYIAsNspfgfjGw6mOuxQ12a2tKtrs5X4HYqvy+2yDn
	 wQPVrL//ApCxXrVAdTOfNssUClFGg3uDlMnOIk/8N5pZsQK6kvg1YFK0i78RSP87OJx3+
	 +3H7IAyMbfCkmK7B/eQtEXhG5c6alm0fJ4GRtTuheheCPhJqoL9VSvJEPtrqBcHcRHvOZ
	 zQSi7qab91Wpr3CbEVV8h8OZ6P3Nt94D63sEfuEzSaQBz9I1u9+rlpLT6BhDsqpyzLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=B2unip78;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.78
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023078.outbound.protection.outlook.com [52.101.127.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24755606A31B;
	Thu,  5 Nov 2026 02:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24755606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=B2unip78
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4MMlLNQP+rnplMYERdJf8cKn+LsvKLWqhh21opWFBXRSYQdPY5pSMe0ugjzkfT8wylL8Dk/6U0fqJpXHVvtPR0a+ebe0RDO1ZXgbUwKAv2ChOZvT2u+Y4SqKAku3G0XnVYzcKm2jzLGdjckekfYCjn0LYCbgSr6cn80YD33ZKn1Q3nI7Ul21IdQfquoMBXsnYsncESPXhGGRQjA9lzfdPTu0kRCN+xQWfwacKV1asjn1kE6ELGqrtGjBahgOLFR4lb9C4OhRSW95OvTq2MebXs7rxZkP+0+bHhg4MSXKPQLs2dLGpwSrd5ZoupAYToPxnHh0CpvZ5MZ339/qJ99oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OfZVM5xLAac5/cWderjKSVPRlsgmoZyVImth/MXgV4=;
 b=Z41uKluj0w2HQdJk7QCDsx7hSJtR4vcxGLLO8XckcmZCp7NTFcWlM9q14fJgzrTDQ0l50UKB3h6fY8esEaV0YULxK+YWE7oslnoxKBefz66lHPfPmWLZes8U3A4yEfYVuDKvr30RS4S2QdMYtj/A0DiBpDYPdZ2Msy/JRQeM/y4RwEQ1tEt7lORVFbVAq1a6g0uHz8V+Yed4MdWyLnbErtzhMpDAZzYYUo7B5kUVTXez9WEv1MOTAF65C09tayFQBNjI4sOpXDOb6epW+8zaq6zCHy9JS3zaFsAATrm/UwG7XVS3MMAR8h4X9m8fKnP00O87YqB9+uRfajt+Zfw+5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OfZVM5xLAac5/cWderjKSVPRlsgmoZyVImth/MXgV4=;
 b=B2unip78QYgcghV0lR8/nqybtvW9iXRUqKvjpCP1KQf6fnd0RWlhr4EMafFjHbeo70yDI4ToVK3Bs49SPWKuE3qmOh5nVu0tNOZk3ttqxN6xeN96fxkR8NWmokIxZ8DYt5ZnUBvf5rKFHv69szw+/hHp9rov3Mrr2ULBMBIdc6r+WcJdIjlkPmgyu0hDskT91ubJi80W9OOLZq0PKUmOVH9dkKvfh97x+T61W7a7uuN3QcVDhztaBE2hS1KR3z1U/d0ArrjtzIC0icHu5uZUtJD04k/uFBOAMTDPSXO/iv9fOV6fK4cyqWRLb1ZUmnS006e+Vom9c7gIwXWXBIwzQg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB9035.apcprd03.prod.outlook.com (2603:1096:990:7c::13)
 by KUYPR03MB10385.apcprd03.prod.outlook.com (2603:1096:d10:70::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 02:19:46 +0000
Received: from JH0PR03MB9035.apcprd03.prod.outlook.com
 ([fe80::77d4:2931:4c4e:1cee]) by JH0PR03MB9035.apcprd03.prod.outlook.com
 ([fe80::77d4:2931:4c4e:1cee%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 02:19:46 +0000
Message-ID: <5d5a22a5-b45e-4cf8-9066-e0e641d719bb@amlogic.com>
Date: Thu, 5 Nov 2026 10:19:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] Bluetooth: add a quirk for controllers that cannot
 enable Secure Connections
To: christian.koever-draxl@student.uibk.ac.at, marcel@holtmann.org,
 luiz.dentz@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Christian_Stefan_K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
References: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192338.209574-2-christian.koever-draxl@student.uibk.ac.at>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <20261025192338.209574-2-christian.koever-draxl@student.uibk.ac.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0025.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::15) To JH0PR03MB9035.apcprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: JH0PR03MB9035:EE_|KUYPR03MB10385:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a79265d-5336-40c7-c5ca-08df3ae34293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|6133799003|10067099003|18002099003|22082099003|3023799007|4143699003|5023799004|11063799006|261022075727099003|261028144727099003|261102123227099003|261026140227099003|261022105027099003|56012099006|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	yOSH9FjCf7dHfKb2GPGCwW1fcJGjvuJTXJCZ9JeAlDt2AxmflhSwjI4tzF+qxxYG7knvq+TsSjLzI68XHgMIzhaDnhO1SEOxSRmCzYq69Y1ulrumrzg7wTaAYiynZyn5E+eHAZv2VAhkey+a0kkL91MIaHBHE3pROCtlbg32hHABfP6Sp24obm9ESmwwrDPSLpi6vSpMaAqHJW+F2wq3CPcOYExr0YNJjPc4bNfF/OoRZsvGwvk40fBkd2/eZOXjnAG6HetI4peVlxy5JCd/u2JX7k6Pt4g6IUXPUGpDZmpmghVzsVHlhwftR3rBggjrenwvOK4wMIBIDQEtSJU49BBX+60GDyjGfA5TqYZvmBmsjZRO/zxJN3gk3o49yjnqA6kISCvrfCyKdcR7G3ZaoAmiqTW0iRs/cwGlof30N7gxvKCP7jVbYCX1bL7N6gT/M9eaIfaPLpnEykjCjA3AUd3nXORzMUNNkmiWW3VqoJIT8OaCXUU51Ij21j4bRn3zBHiwCdUMrFpK1njjecYNgjUDPB2B8JetOA+9WPBxkysiH7WSZhL74NwbmL+PdHU1f88nfMDSd8VE3HRpSUAccVjSa4QCr4hsrIyJL0TkZji0cgUIWI78A0qXYopHw5hsZ1rvIdbQj7ygs2D6X+ApLaSja3pObiQvl3WSSMPZc9Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB9035.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(4143699003)(5023799004)(11063799006)(261022075727099003)(261028144727099003)(261102123227099003)(261026140227099003)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDFOTTVMaU5hUDNXQ0hVYkJzdzdFZFNRWkRMei9raXlrbDJ6ampaZmdtOWJl?=
 =?utf-8?B?U1FGQWlZZ2FBVWhzU1RNV2R3Zy9VYVI0NVdpWmJCL0tpTnpJZzJjcVhteUh3?=
 =?utf-8?B?VkZLc00wRTNWbXFBaEN1ZjdaWDVGaWNhUDR2bFVjNHN6M2lwdjlDTlFTMEpz?=
 =?utf-8?B?Rk93M29Nazd1d2Z4cFR6RVZnVFNid0tWTmFkVUNmZmJ5WEhlN0x1SERiMGVo?=
 =?utf-8?B?ZDBsdm5MdXU2TGxWVDhaS1dLRElUMU9UMldHRUVqWTlkUEhoeGdTeFJQUDE5?=
 =?utf-8?B?disxbDZESXVZNHlPQ293MFNHUHYwYUI1YnRhcmxqbFVxS3Z2TGJ5T2I5cWtK?=
 =?utf-8?B?eVQ0RkRQT0llWktnVHh0MGtiWXlZemtoVk5Vb3VjVlB0MjNuNEhZQ25NTnlo?=
 =?utf-8?B?MGpxTHJ3S0J6dXdQRW9oM05hY25NazMwbjJrd0ZsVitFbXB4eldzbjR4Z2ZM?=
 =?utf-8?B?YmpLMGprSldCcUdUV3orelZBc3dWY2JyYlo1bFBCcnllcW5xTjlvVFdqODZE?=
 =?utf-8?B?UENzcGk4cnptdUkzeHI1c28vTk85ay90dFZtNXJLMFhRclVqYnlQRmFPb1ls?=
 =?utf-8?B?SzhoODEvd2JCblBpRTN0SHdubzIrcUNXdGwvaXVDc0s2ZE41bUFQQWkrTmxr?=
 =?utf-8?B?YUxoU2EzeG91dlVBYlNmTXN4MVZUUSt0VUNUS2xOTWtyS0lEaXZ2MFc3d3lB?=
 =?utf-8?B?TUcvMW0yU1NpWjBwUkdVcTJpRzZpUTJCWkdPYXBDY3JXMDQ1QktnbVVGWVZT?=
 =?utf-8?B?Tk92V1BwejcxVHJvdkVFOUEyYlBsbE1aU3o3Q3l1V2pPUGcxZ2JvbVlQVXJY?=
 =?utf-8?B?cG9ldndWdythQVZuWitsLy84QjNXcXNramFKaE5hRDJoTHI2UzJYZVNoVFpr?=
 =?utf-8?B?akE2TjNuRjFpT291bG5VaTZoeFl5dG5mUHJNRlNSczBRN3NrQXd0NnVseW9G?=
 =?utf-8?B?K3lqWjY4WnlQT0dGSld2ZG1raXQ3VG1IWFdTcythZlFVR2c0d2hoSG1BMU5h?=
 =?utf-8?B?eGgvSWNuSkx5dTNHd01wZFdzWitGVzlwUFB5dy9QZjE1Qzc3allWeW9LSEtC?=
 =?utf-8?B?T3p0am1FZ2N4Nm5Ta1liZEMzN3NEMWxFOFMyMzBBSlJwUTlLZVB3ejNaQStX?=
 =?utf-8?B?dXNnRVY0US9lUng3emZ5VTltY2s1bWNCTTVmcWF2NW9URU9jS2FvNVplZDJO?=
 =?utf-8?B?eEtCWjNuOTJYT0lNYTIwbFBuQVh1YVR1MStxZ0tUSXU4UzhPaFVVVVdQYXlV?=
 =?utf-8?B?VkdhVFNKdTgzWjV5SnVaU2UveUhoNmd0RmJoQ1VzeEV0Y2NkaVdDdkxNMG5G?=
 =?utf-8?B?dWxOU3RabnBJZWxyRndwQ3d1U1RwaU04Vi9GQkl0UEFKd0hLNSsvNnl4cWls?=
 =?utf-8?B?OEg3VUg4MytWY1ZLcVl0ZGVUOVZEck9vaktxSUZUZlFmNzhmYVZUTnJtOWVk?=
 =?utf-8?B?Y3FnYTZ4YU1qSFRVRlJvTHUwWWcxN1JlWUtsRUd1TGRVLzJ1cWFvSHZaRUNm?=
 =?utf-8?B?Z0tsVEx4V3BvdmFFdUNEVlhoTklaWS93d1VOMlRuNElHL01DNzBUaE83OUZi?=
 =?utf-8?B?Z3IvVXVkZThBbEdoVTJqaTR5d2svODN5SS9NZjZkUEE0YVJ3aDBXNWs5bW9F?=
 =?utf-8?B?aWczYVNoVmVwRC9oN283MmZZQzVkbE5WQUVkUWZUZlFvTjVzSFF5ZlB2R0Fu?=
 =?utf-8?B?cnBrMG0xRkVHNEdodG9GSUp6Z2pRWStqYXRkZmdJY3NDU2l1TmVQekNEUm1Z?=
 =?utf-8?B?Vmp3NUl3WWhoRmYxUG52ZDZsb3k0clFiNjh2b0E0cXpZZzJQenFZbG9oSkx6?=
 =?utf-8?B?NUNObHl1RERpM0tXcEl6bmJPNmgxczVWNkxsQU5hUmpZT1FpSGZzU0dOVFFu?=
 =?utf-8?B?MzVDQnFqVUdLVEdFYmtSRStJVkc4dGtRWTlpUEt4OWpQL2VFbjVaQ1IrY1dm?=
 =?utf-8?B?K1RjTmNKZHl2SDNqblNyTUdPbU96dlY2RDJiSkR3Z0hHYzRESkxYa1BSVFJp?=
 =?utf-8?B?RGtYSmZQSGlYZUUxbWVveHgxb2hqOUV6R0gyN1I0VnBVMXAzZCtJZjErTzFN?=
 =?utf-8?B?WUNkU2p4SGE3SFBZSWREbXk3dEo1VmQvOXVCMllxSjUvc1dnSTVDc050bTB6?=
 =?utf-8?B?RkxkNG4zUlpNZ3FucG5rRVEzUUtwRkVjZFN3UVBSVTQ4cEUzbTR0UEJweHBj?=
 =?utf-8?B?eitMN2M2MDN3NCt6K25UWnhVaGVZTGJKd0FQOWN2NGptYWRROUVZOExZZzRN?=
 =?utf-8?B?UWxHMDhWV0ltdE12NzZOTEd1bXFobEphWG5yWjZTb1pqTFpodk5FRHFrMTll?=
 =?utf-8?B?aU05cm45OXIwSmVsdWNGRFhEc2xnZ3B4ekdyUHpYdS9TMWdqUk9kUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a79265d-5336-40c7-c5ca-08df3ae34293
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB9035.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 02:19:46.0193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSPKXFNaSSRkz6rySCpZRaNDE/5KT7QZ+q8SJ7C382MpEKb7dXGxOV1lLn2snTF6rxez/0dKmIXKxZ8q+aet/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR03MB10385

Hi,
>
> [ EXTERNAL EMAIL ]
>
> From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
>
> The Amlogic W1 (W155S2) lists BR/EDR Secure Connections among its
> extended features and then fails HCI_OP_WRITE_SC_SUPPORT with an error.
> That failure is fatal to hci_dev_open_sync(), so the adapter can never
> be powered on: every mgmt Set Powered returns Invalid Parameters and
> bluetoothd gives up on the controller.
>
> Add HCI_QUIRK_BROKEN_WRITE_SC_SUPPORT for controllers whose feature bit
> cannot be taken at face value, skip the command in both places it is
> issued, and set the quirk in hci_aml.
This appears to be an anomaly with the firmware binary. Could you 
provide the FW version in use? It is logged during Bluetooth driver 
initialization.
> Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
> ---
>   drivers/bluetooth/hci_aml.c |  5 +++++
>   include/net/bluetooth/hci.h | 14 ++++++++++++++
>   net/bluetooth/hci_sync.c    |  8 ++++++--
>   3 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c
> index 067fbf278b44..990e701da4be 100644
> --- a/drivers/bluetooth/hci_aml.c
> +++ b/drivers/bluetooth/hci_aml.c
> @@ -598,6 +598,11 @@ static int aml_setup(struct hci_uart *hu)
>          /* Setup bdaddr */
>          hdev->set_bdaddr = aml_set_bdaddr;
>
> +       /* The controller lists BR/EDR Secure Connections among its extended
> +        * features and then rejects the command that turns host support on.
> +        */
> +       hci_set_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_SC_SUPPORT);
> +
>          err = aml_power_on(amldev);
>          if (err)
>                  return err;
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 1641d879dbda..bcbe76c84d1b 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -375,6 +375,20 @@ enum {
>           */
>          HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
>
> +       /*
> +        * When this quirk is set, the HCI_OP_WRITE_SC_SUPPORT command is
> +        * not supported.
> +        *
> +        * This quirk is intended for controllers that list BR/EDR Secure
> +        * Connections among their extended features and then reject the
> +        * command that turns host support on. Without it the failure takes
> +        * the whole of hci_dev_open_sync() with it and the controller can
> +        * never be powered on.
> +        *
> +        * This quirk must be set before hci_register_dev is called.
> +        */
> +       HCI_QUIRK_BROKEN_WRITE_SC_SUPPORT,
> +
>          __HCI_NUM_QUIRKS,
>   };
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index a92a81846e9d..f1dfef81ca96 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3419,7 +3419,8 @@ int hci_write_sc_support_sync(struct hci_dev *hdev, u8 val)
>   {
>          int err;
>
> -       if (!bredr_sc_enabled(hdev) || lmp_host_sc_capable(hdev))
> +       if (!bredr_sc_enabled(hdev) || lmp_host_sc_capable(hdev) ||
> +           hci_test_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_SC_SUPPORT))
>                  return 0;
>
>          err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SC_SUPPORT,
> @@ -5040,7 +5041,8 @@ static int hci_write_sc_support_1_sync(struct hci_dev *hdev)
>          u8 support = 0x01;
>
>          if (!hci_dev_test_flag(hdev, HCI_SSP_ENABLED) ||
> -           !bredr_sc_enabled(hdev))
> +           !bredr_sc_enabled(hdev) ||
> +           hci_test_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_SC_SUPPORT))
>                  return 0;
>
>          return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SC_SUPPORT,
> @@ -5254,6 +5256,8 @@ static const struct {
>                           "HCI WRITE AUTH PAYLOAD TIMEOUT command leads "
>                           "to unexpected SMP errors when pairing "
>                           "and will not be used."),
> +       HCI_QUIRK_BROKEN(WRITE_SC_SUPPORT,
> +                        "HCI BR/EDR Secure Connections is advertised, but cannot be enabled."),
>          HCI_QUIRK_BROKEN(LE_CODED,
>                           "HCI LE Coded PHY feature bit is set, "
>                           "but its usage is not supported.")
> --
> 2.56.0
>
