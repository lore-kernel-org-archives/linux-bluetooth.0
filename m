Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793935729;
	b=gRdZutJL9e5k4Y0hRwygb3YShdSCng2cNSeTUnzaGnJVKtZtI2Gh1vREv+jCACTkaV8v
	 9jvS9nqAUMs/sZmKugve3Ug43iWxtBG58Gci6qhddsl0rmBr6kyH4F4L8jgsaCQz/HF7C
	 YW409xCe+bRKkn4ixYgE3Sp3TEb6TaqSz1+aeeAW4EOrZU7+k6XZ2pgzrKEPOOT9FjWOh
	 hpTvkDN1go3FvHskkDNGo6GAhLhY0xWxkXa4XUROPdL+Mw8VUONeECdFUXzU555rX5xB4
	 jeNzDyCKnN7XCDDTRs+7rqd2PjiiZ+H/QtjVE9crOAGx612nclnhUy8N6PKIl9huaxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935729;
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
	bh=QnM/OqRfOJ5cBL0y6A0RX3EOOzPPQFAAGKAxKMDmKnM=;
	b=jVsyNB3epdeFj5w8wpHinZ8Arql4J9l1ktzSJ7LLK/cjsx7JJIDOqam2Fo4SQfWUGYqS
	 +6P6D4meHAz3QczKYkPc0E0gwAaiTdSDZgivtBYgwXZ9ljmxRs3DI1oFmm085WzdcmnjB
	 kyH10OSYwfXtfTJ1e0Av733dUkbsQBgn50PIU/zJBcmapZ3dMnVzb/Oj8h+BSyPt43ae+
	 bNs+PV+0rvZhByM+bQwEsfGa7g7C+GtXI7lUMCDiiHPBTh+ypfcPJGbfeSTARnFUBP1OZ
	 sFF17iJfoxpVWC7yanLFyN8QRJz5TCUvo0RvAQzyT6iEQgbiLHUbvST1xj/9t0oEnpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=EeGf4ZlG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.75
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022075.outbound.protection.outlook.com [52.101.126.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26419606A32C;
	Fri,  6 Nov 2026 03:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26419606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=EeGf4ZlG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmxC1QuXW8t8K8rXM1FxycFO0apqelS7DUI/RB+Ycp1lNpY0fVcfz5OJHqnbNIy5oqiL0dMp4EzQgLxFCXJvKxdl/E6Bhe7qkVBDSbbkdszcJEsMl4eH9LzHdaProECM90wJkDaucTrjHta0s9r7owGT29Zmko82p8Vs8b5kUDuSyU7KKfc+JDofhlzCd33dY7nIDgES06SIiZzHn2C9dI53mgPbvvuuRavhvMkaTmoL1ePxSzbEo35MKOJz7ta9gBC/o38S0/UrNs0hKCVercz+pPZkLACIi2JYbKBVdOpbdobl1kxSHUjJdWu44c7rIIGUJn3dwgB6yF7cMpcShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnM/OqRfOJ5cBL0y6A0RX3EOOzPPQFAAGKAxKMDmKnM=;
 b=tZJR0d2H1JsSzW61UrGJW5vmNpmlRco/cF070EB92sDGPBGMFHx4ak7jji2EZKFET5yeEpfMtG0ArPLimQYfAzTaXbc8uvXS6rkmm8E/esef1NZJxEujrOyzhvrNjtZpxJgLPqlDQPj1a/dUXirFDTMZs1ekxHDr/0ySosPkQL24UwvpV2M1dYpdT/+AawUVuswjfrM4/BqcZYPcJWyTPTOQggevXLeZgjNIyt6GGLFVETwFkiiuYMwjrhv0n0A3FLSt2MaSxRqYatCozA7cAYGthK0SFnR9vdUFCYSBR8vHMV2eL+NwYhuDCrdqattL+S5cWit+ceueviIaSH8NkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnM/OqRfOJ5cBL0y6A0RX3EOOzPPQFAAGKAxKMDmKnM=;
 b=EeGf4ZlGUMLGT3zhxImW3dFqipPXT5fcMfejiU/A083cEVw7qeqP8X8DphtBfNuLxLXXWHL9aoqg4BDRCqhFU7IA9uMLUpBILJzUSrczuO1mi9ekmPJj+blbw9iURTrp1Hcs8+51sef/D3Ykq7lH2JiI9G0FtmGTWfKcQqOfPTjJIN3hF5eUE9lpyvi3obKZBVczKCRVPf+eUjoQo9W3Pi0SiAoZ1kUCkHoJBGUxT2PgC8H+vzlE4Tg0RkV48iZDXjIDq/WOnqtW45FGN+vgPKfQZUrdyyQAXACIA6Fn6uNHmtnQifSRwtELwxlwvhMDhZZmOC3259aiY2wLtMVvKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB9035.apcprd03.prod.outlook.com (2603:1096:990:7c::13)
 by PS1PPFFECF4030D.apcprd03.prod.outlook.com (2603:1096:308::2f3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 03:28:40 +0000
Received: from JH0PR03MB9035.apcprd03.prod.outlook.com
 ([fe80::77d4:2931:4c4e:1cee]) by JH0PR03MB9035.apcprd03.prod.outlook.com
 ([fe80::77d4:2931:4c4e:1cee%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 03:28:40 +0000
Message-ID: <95e5b0bf-a8db-4448-8ca0-a9af76b66e85@amlogic.com>
Date: Fri, 6 Nov 2026 11:28:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] Bluetooth: hci_aml: cope with a controller that is
 already running
To: christian.koever-draxl@student.uibk.ac.at, marcel@holtmann.org,
 luiz.dentz@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Christian_Stefan_K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
References: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192338.209574-4-christian.koever-draxl@student.uibk.ac.at>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <20261025192338.209574-4-christian.koever-draxl@student.uibk.ac.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::19) To JH0PR03MB9035.apcprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: JH0PR03MB9035:EE_|PS1PPFFECF4030D:EE_
X-MS-Office365-Filtering-Correlation-Id: e1576e3f-52b9-4504-9690-08df3bb60d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|261022105027099003|261021123027099003|261022075727099003|261021121427099003|261009223027099003|261022115727099003|4143699003|261026140227099003|261026121527099003|261028144727099003|11063799006|5023799004|10067099003|260925021311599003|56012099006|260925022911599003|260925021911599003|3023799007|6133799003|22082099003|261102123227099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	I6thovfjqBumkh1IQMnzaXMu7A3sF3W56pPz6xp7aKMxCFbRapcGQMi4n7MDjkHg6jfSGBeNt6Z9dJT8JvHmygnhDC1AvmelIlSfNX0eO8VprAWTiH9uAkZ+oaPrGEKL56ke2WJ40N1VCPMgaULrrUDCrCQyn+t/dEIwl3O4DY5y0QR9lVP7h+SzTjqQ0krhWPk6BHl9ptR/SbLhzcK9vKeiUIetwvmi18pk3xiB5fEadkyokhxhYGFAAI2T720V6398Tvi8T79Nc6q84R4qERJZoMxggqi5QMDa1XkH4sn+56CGmusinwU6FMOCPOSD/t/QC7vjUWSJm7I1mIidLtFr9Ejv6+i1iz1uJIpkSOcpwf3Jy+frMnsZx5req9mklMAN/3CPc/ZgSgb82xzqPZWgYXy9mW/UO77wLpZcZf8YwsJd5J7Peh4nLV3PVzJXYl40RG/1yFZ2oFcqwNz0tqPozO0HFigcjYQohQeuM7BOBDPNJmtkyAAevD79z8pE8tp+E/A24CE9oW0d1foK2tWvDO0YqrbYKGmv6Wtu1Rpu54t5fCsDQXRjD8p1SOH7sJDieS3LtnuSuVMabjyIpUcyFqQq4XrjP4jPcCcPFnGLHL8F9bn1ArHZOuQZJOMV0pE4BKQOGH+sM0+M9PXxb6isv/VoMCKVA3AEuBxPnY8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB9035.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261022115727099003)(4143699003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(5023799004)(10067099003)(260925021311599003)(56012099006)(260925022911599003)(260925021911599003)(3023799007)(6133799003)(22082099003)(261102123227099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1BZS1N0L0s4UTgyaHlHeS9PMi9WV1o4UnpOWVpXTkJLZGhTK0NTZks1K014?=
 =?utf-8?B?MlF3OHRDRE04N2N5NmhjclBSWW9EY1RDdmNOWWVNRkQzWnArK0d3VW9HVWlN?=
 =?utf-8?B?aDYxMXJkVE4yWUNiekFvTm5TODRFR2dxYWpjUkRXUEtKaW5KUElaZDJDSFov?=
 =?utf-8?B?SmdlMGVyZEw5NUE5VTh5aGZZWTNnQk1jN1pHZGJhQndYdFVQbmJjdUFaQVhM?=
 =?utf-8?B?bHF0RHNYL1JtaUlFT2UweGdWeWRZRWNWRzM1SHhQdmxqTUdRWUlqTXpHOTlk?=
 =?utf-8?B?YmE2SHU2UHNwVStNb1ZFU3FieXprQVpWTGR3RmE4SjgzcmI3ekg1bnJuRWcv?=
 =?utf-8?B?OVhQSGRXYnpWVDFIZ0VJZ3FtWFd2cWtTZlgvbHZtS2liYjJYNE1WZWEyU09J?=
 =?utf-8?B?RGk3THhHWjdFMHZsUitQKzc4YUI3dUd2RWU0c05pN0dxWDd2N0JSL2cyZEIr?=
 =?utf-8?B?RFR2bVc5aEh1YmgwbnRFc3F6OXZnR1VTOWZvMDg4V0xZemZ3LzU4SysyVTY3?=
 =?utf-8?B?L0x2VUZpS1lIeGwvQUVnQVZxciszUTh0YXAyY3ZpbU5wcDBGY3RUVFovUVN0?=
 =?utf-8?B?MVdJUStsTzlzMFU2ZDBWZmhDWVFHajJ6Z3V2YTE1dVBxanY0Ulo2ZjdDeVdz?=
 =?utf-8?B?Y1FNSjJ5VzJjZ0k2ZW12eTNhSE1KcTVZWXlmRmZXdFRyNEx6WnhzcXBQSUs5?=
 =?utf-8?B?SG1WK2tqT3d6MVFqYVlZdzBvTGREWHlXYlk5TVc2eVdCTnduMDYvdG55Yk5r?=
 =?utf-8?B?SWF3TGY0aVB3Uk5UU25VLzBMQkc0TEJNZkJlZlBackVPcnc1aVVUdTIrQ25t?=
 =?utf-8?B?dHNUN0szaHRaU2NzZVpCWnI0bUwvdThrQnptMGhER29wb05xRzJQSnE0ekFG?=
 =?utf-8?B?Zk1qNEx4bXFCSUdmTnB3NzRIWUZ2Zit4Skw1TzAwNTYvdk5qRHd4YXpJTjdQ?=
 =?utf-8?B?c1Y5eVA5WmJ3aVRPanRGRGJXNnZYV2JHcFlYQzZqRjF2UlVwSmszVUVOS29h?=
 =?utf-8?B?d0RaajhJWlkyK01yN0RIcyszaDk5RGZoY1IraDNnY29OcGhKNXNjbU4veVk0?=
 =?utf-8?B?TldGd25uakJGL0hzSWxwKy82bk83aFBBek8zMXRvUEdzZDZtOWpRM0dyVFpG?=
 =?utf-8?B?dU5iY21OR0tWY1doc2wyWDl6K29UTm5ieDc4eTMyQ1BQZ2dJVkVPdFVCVlJ0?=
 =?utf-8?B?UWlmK2RwQTFqdkpoczNoN0dodzlMZWEyQXdRK1lpUkJnc0lBQjhTc0ZBS2Z0?=
 =?utf-8?B?MDh0NG1yNUhyL1p5bWRHbUxqenNyclRBeExHQlpoMXFETW04VVZsNmdxYXJB?=
 =?utf-8?B?R2xnVXM3UzVDTW5wbkVRaml3V2ozbzlFUmN0NHFlTzU3OGQrMVJmV1ZuclBN?=
 =?utf-8?B?Yi9tSlFyN0p1dHV1YU81OU9aQ0ZFWW1pQ0x5dkx5SjNtUVRUUW4xckZlL29k?=
 =?utf-8?B?STRWUlRxOXZ1WVgzbG1xYjBVNXo3NjNWTEFwWW1HSlUyZTBQMDJQc0xrZkpa?=
 =?utf-8?B?RDBpTXF6TUxvTHA0K0dQRmEzTFY2RDRNVkFGV2lselJkVmY4ZTBFZks0RkdP?=
 =?utf-8?B?aUJubHBxUGRTajNWeVFQZ05NVDlpOE1nYWVSWWo5SjhKUTQ3eXN5MDZtYTht?=
 =?utf-8?B?dXNIakJYVWQ0WE0xSmoxa0pXYXl0Z3p0aGlQN1llWjRKcFNLMkxDNytyRlF1?=
 =?utf-8?B?anhmRXU5ZW1ibzJ2MTBmL2k5LzZmcHY2ei9URW1VTlBZT3ZQUDRZdUJ6ZWFj?=
 =?utf-8?B?d1NvNXNnemRxWXk1RGJOWXJwSHZEVkZ1QjBtWmYzeERlNWJlUWlvd3VzYU9a?=
 =?utf-8?B?ei9lTlM2c25CZmdJcU5FdVEyUlpHbUZxM2tzY1M3VjVEVkdNTWc2Vzl6QkRy?=
 =?utf-8?B?RmFmaGovNVMrRThuaHJVcFpQZXdueEpjZUZvWjN5U0JNcmFpY21jck96TkM4?=
 =?utf-8?B?MW9IMVM5OE9qUFI1d3kwRU8veUE4VlZ6b3BsWUVQbGNOcTBiWTJxYi9hMHZk?=
 =?utf-8?B?ZWs4emN6eW41My9SNjQwZlI2bGVQODFsY2duaFZ0cUtRY3pyWUw0bE1lbzdN?=
 =?utf-8?B?M2k0RjBhNmVOd0NZczN6Nm1iVjNGN0dWMm5Jc2tLVThVazllOURyanlIR01k?=
 =?utf-8?B?dkZ2WkU1QjFOTjZ5ZXRGVzRHSmREME1KTGNRMzltZ25TWnV6dXdhMXVnRXNE?=
 =?utf-8?B?Mm1kbHZQQnVpQXVQanU3QzhIZkpIaXI3S1Z3UDU2RXYzYkVDOStqSUhHeHJH?=
 =?utf-8?B?ZW9ycjdXM2RvME5SQXY1QnFoVU9zaVpKR3NlM3ZxdmZvVDBXYlFSZ1ZMWjVV?=
 =?utf-8?B?eTlnSmRUUUJ0bDNpSE5rd3NKUFdCWm1MYUNPZTFaZEpyYitlaG9iUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1576e3f-52b9-4504-9690-08df3bb60d41
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB9035.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 03:28:40.4207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqUgZzHxqhX32UgkCyj3eAqATTs+nqW1iFcsvC3N96Y+hgJvj9QzIti6UBjAWFkt0EdY0WEMQA/bd17hrupoqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFFECF4030D

Hi,

>
> [ EXTERNAL EMAIL ]
>
> From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
>
> Several things stop the W1 (W155S2) in an S905W2 TV box from completing
> setup reliably:
>
>   - Dropping the enable line does not reset this controller. It keeps
>     running whatever firmware it was last given, at the baud rate it was
>     last told to use, so a warm reboot or a driver reload finds an HCI
>     device at 4 Mbps that no longer understands TCI commands, and the
>     download dies on the first TCI write. Read Local Version tells the
>     two cases apart, as the ROM does not answer it, so probe for it and
>     skip the download when firmware is already running.
>
>   - Talking to a running controller first means sending it a TCI command
>     at the ROM's 115200 baud, which arrives as noise at 4 Mbps. The
>     firmware takes it for the start of a packet and swallows the next
>     command as its payload. Retry the probe; every attempt completes
>     more of the imagined packet until the controller listens again.
>
>   - A single unanswered firmware segment aborted the bring-up. Segments
>     are plain writes to controller RAM, so resync and send it again.
>
>   - The fixed 60 ms wait after starting the firmware is too short for
>     W1, which takes up to half a second. A version request sent too early
>     is lost and blocks the command queue for HCI_CMD_TIMEOUT, so wait
>     600 ms, then poll the firmware version until it answers.
>
>   - Closing the HCI device dropped the enable line. Setup, which powers
>     the controller up, only runs once per registration, and the dropped
>     enable line leaves the controller unreachable until the combo chip
>     is power cycled, so the adapter was lost after a single down/up
>     cycle. Keep it powered in close and power it off on remove instead,
>     tracking the state so remove and shutdown stay balanced. Rebinding
>     the driver still loses the controller, as the hardware gives no way
>     to reset it short of a power cycle.
>
> Tested on an S905W2 board: setup succeeds on cold boot and warm reboot,
> and the adapter survives down/up cycles.


How did you test the warm boot scenario?

Were there any operations involving the Wi-Fi driver? Cause of the 
Bluetooth driver and Wi-Fi driver share |chip_en| GPIO.

Could you please share your test steps and system logs to help with the 
analysis?

Thanks.

> Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
> ---
>   drivers/bluetooth/hci_aml.c | 186 ++++++++++++++++++++++++++++++------
>   1 file changed, 158 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c
> index 5979b114f2e4..8561618867e8 100644
> --- a/drivers/bluetooth/hci_aml.c
> +++ b/drivers/bluetooth/hci_aml.c
> @@ -24,6 +24,29 @@
>
>   #define AML_FIRMWARE_OPERATION_SIZE            (248)
>   #define AML_FIRMWARE_MAX_SIZE                  (512 * 1024)
> +#define AML_FIRMWARE_SEGMENT_RETRIES           (1)
> +
> +/* Probing for a controller that already runs firmware is expected to time
> + * out on a freshly powered one, so do not wait HCI_INIT_TIMEOUT for it.
> + */
> +#define AML_PROBE_TIMEOUT                      msecs_to_jiffies(500)
> +
> +/* Long enough for the controller to drop a partial frame received at the
> + * wrong rate.
> + */
> +#define AML_RESYNC_MS                          (100)
> +#define AML_RESYNC_RETRIES                     (4)
> +
> +/* An HCI command has an 8 bit length, so this always completes a partial one */
> +#define AML_RESYNC_CHUNKS_CMD                  (2)
> +
> +/* W1 takes up to half a second to start its firmware, and a version request
> + * sent before that is lost and blocks the command queue for HCI_CMD_TIMEOUT,
> + * so wait a little longer than that before asking, then keep asking.
> + */
> +#define AML_STARTUP_DELAY_MS                   (600)
> +#define AML_STARTUP_POLL_MS                    (60)
> +#define AML_STARTUP_RETRIES                    (5)
>
>   /* TCI command */
>   #define AML_TCI_CMD_READ                       0xFEF0
> @@ -100,6 +123,7 @@ struct aml_serdev {
>          struct clk *lpo_clk;
>          const struct aml_device_data *aml_dev_data;
>          const char *firmware_name;
> +       bool powered;
>   };
>
>   struct aml_data {
> @@ -214,11 +238,33 @@ static int aml_send_firmware_segment(struct hci_dev *hdev,
>                               op_addr, (u32 *)seg, seg_size);
>   }
>
> -static int aml_send_firmware(struct hci_dev *hdev, u8 fw_type,
> -                            u8 *fw, u32 fw_size, u32 offset)
> +static const u8 aml_resync_pattern[256];
> +
> +/* A command that goes unanswered has usually been half received: the
> + * controller took what did arrive for the start of a packet and waits for
> + * the rest, so every following command is swallowed as its payload. Send
> + * enough bytes to complete whatever it is reassembling. Zero is not a valid
> + * H4 packet type, so what is left over afterwards is discarded.
> + */
> +static void aml_resync(struct hci_uart *hu, unsigned int chunks)
> +{
> +       unsigned int i;
> +
> +       for (i = 0; i < chunks; i++)
> +               serdev_device_write(hu->serdev, aml_resync_pattern,
> +                                   sizeof(aml_resync_pattern),
> +                                   MAX_SCHEDULE_TIMEOUT);
> +
> +       serdev_device_wait_until_sent(hu->serdev, 0);
> +}
> +
> +static int aml_send_firmware(struct hci_dev *hdev, struct hci_uart *hu,
> +                            u8 fw_type, u8 *fw, u32 fw_size, u32 offset)
>   {
>          u32 seg_size = 0;
>          u32 seg_off = 0;
> +       int err = 0;
> +       int retry;
>
>          if (fw_size > AML_FIRMWARE_MAX_SIZE) {
>                  bt_dev_err(hdev,
> @@ -229,8 +275,22 @@ static int aml_send_firmware(struct hci_dev *hdev, u8 fw_type,
>          while (fw_size > 0) {
>                  seg_size = (fw_size > AML_FIRMWARE_OPERATION_SIZE) ?
>                             AML_FIRMWARE_OPERATION_SIZE : fw_size;
> -               if (aml_send_firmware_segment(hdev, fw_type, (fw + seg_off),
> -                                             seg_size, offset)) {
> +               /* A segment is a plain write to controller RAM, so one that
> +                * goes unanswered can simply be sent again, after resyncing
> +                * the controller that is still waiting for its end.
> +                */
> +               for (retry = 0; retry <= AML_FIRMWARE_SEGMENT_RETRIES; retry++) {
> +                       err = aml_send_firmware_segment(hdev, fw_type,
> +                                                       fw + seg_off,
> +                                                       seg_size, offset);
> +                       if (!err)
> +                               break;
> +
> +                       bt_dev_warn(hdev, "Retrying firmware segment, type: %d, offset: 0x%x",
> +                                   fw_type, offset);
> +                       aml_resync(hu, AML_RESYNC_CHUNKS_CMD);
> +               }
> +               if (err) {
>                          bt_dev_err(hdev, "Failed send firmware, type: %d, offset: 0x%x",
>                                 fw_type, offset);
>                          return -EINVAL;
> @@ -242,6 +302,35 @@ static int aml_send_firmware(struct hci_dev *hdev, u8 fw_type,
>          return 0;
>   }
>
> +/* Dropping the enable line does not reset these controllers: they keep
> + * running the firmware they were last given, at the baud rate they were last
> + * told to use. A warm reboot or a driver reload therefore finds an HCI device
> + * at the operational rate that no longer understands TCI commands. Read Local
> + * Version tells the two cases apart: the ROM does not answer it, running
> + * firmware does.
> + */
> +static bool aml_fw_already_running(struct hci_dev *hdev, struct hci_uart *hu)
> +{
> +       struct sk_buff *skb;
> +       int i;
> +
> +       serdev_device_set_baudrate(hu->serdev, hu->proto->oper_speed);
> +
> +       for (i = 0; i < AML_RESYNC_RETRIES; i++) {
> +               skb = __hci_cmd_sync_ev(hdev, HCI_OP_READ_LOCAL_VERSION, 0,
> +                                       NULL, HCI_EV_CMD_COMPLETE,
> +                                       AML_PROBE_TIMEOUT);
> +               if (!IS_ERR(skb)) {
> +                       kfree_skb(skb);
> +                       return true;
> +               }
> +       }
> +
> +       serdev_device_set_baudrate(hu->serdev, hu->proto->init_speed);
> +
> +       return false;
> +}
> +
>   static int aml_download_firmware(struct hci_dev *hdev, const char *fw_name)
>   {
>          struct hci_uart *hu = hci_get_drvdata(hdev);
> @@ -301,7 +390,7 @@ static int aml_download_firmware(struct hci_dev *hdev, const char *fw_name)
>          iccm_start = (u8 *)(firmware->data) + sizeof(struct aml_fw_len)
>                          + amldev->aml_dev_data->iccm_offset;
>          iccm_len = fw_len->iccm_len - amldev->aml_dev_data->iccm_offset;
> -       ret = aml_send_firmware(hdev, FW_ICCM, iccm_start, iccm_len,
> +       ret = aml_send_firmware(hdev, hu, FW_ICCM, iccm_start, iccm_len,
>                                  amldev->aml_dev_data->iccm_offset);
>          if (ret) {
>                  bt_dev_err(hdev, "Failed to send FW_ICCM (%d)", ret);
> @@ -311,7 +400,7 @@ static int aml_download_firmware(struct hci_dev *hdev, const char *fw_name)
>          /* Download DCCM */
>          dccm_start = (u8 *)(firmware->data) + sizeof(struct aml_fw_len) + fw_len->iccm_len;
>          dccm_len = fw_len->dccm_len;
> -       ret = aml_send_firmware(hdev, FW_DCCM, dccm_start, dccm_len,
> +       ret = aml_send_firmware(hdev, hu, FW_DCCM, dccm_start, dccm_len,
>                                  amldev->aml_dev_data->dccm_offset);
>          if (ret) {
>                  bt_dev_err(hdev, "Failed to send FW_DCCM (%d)", ret);
> @@ -508,6 +597,7 @@ static int aml_power_on(struct aml_serdev *amldev)
>          }
>
>          gpiod_set_value_cansleep(amldev->bt_en_gpio, 1);
> +       amldev->powered = true;
>
>          /* Wait 20ms for bluetooth controller power on */
>          msleep(20);
> @@ -516,6 +606,10 @@ static int aml_power_on(struct aml_serdev *amldev)
>
>   static int aml_power_off(struct aml_serdev *amldev)
>   {
> +       if (!amldev->powered)
> +               return 0;
> +
> +       amldev->powered = false;
>          gpiod_set_value_cansleep(amldev->bt_en_gpio, 0);
>
>          clk_disable_unprepare(amldev->lpo_clk);
> @@ -568,7 +662,6 @@ static int aml_open(struct hci_uart *hu)
>
>   static int aml_close(struct hci_uart *hu)
>   {
> -       struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
>          struct aml_data *aml_data = hu->priv;
>
>          skb_queue_purge(&aml_data->txq);
> @@ -577,7 +670,13 @@ static int aml_close(struct hci_uart *hu)
>
>          hu->priv = NULL;
>
> -       return aml_power_off(amldev);
> +       /* The controller is left powered. Setup, which powers it on, only
> +        * runs once per registration, and dropping the enable line does not
> +        * reset it but leaves it unreachable until the combo chip is power
> +        * cycled, so powering off here would lose the controller on the next
> +        * open. It is powered off on remove and shutdown.
> +        */
> +       return 0;
>   }
>
>   static int aml_flush(struct hci_uart *hu)
> @@ -589,6 +688,55 @@ static int aml_flush(struct hci_uart *hu)
>          return 0;
>   }
>
> +/* Everything between powering the controller up and a usable HCI device */
> +static int aml_setup_controller(struct hci_uart *hu, struct aml_serdev *amldev,
> +                               struct hci_dev *hdev)
> +{
> +       int err;
> +       int i;
> +
> +       /* Try the fresh controller first: a ROM that has just been probed at
> +        * the wrong rate swallows the command that follows.
> +        */
> +       err = aml_set_baudrate(hu, hu->proto->oper_speed);
> +       if (err) {
> +               msleep(AML_RESYNC_MS);
> +
> +               if (!aml_fw_already_running(hdev, hu))
> +                       return err;
> +
> +               bt_dev_info(hdev, "Controller is already running firmware");
> +               return 0;
> +       }
> +
> +       err = aml_download_firmware(hdev, amldev->firmware_name);
> +       if (err)
> +               return err;
> +
> +       err = aml_config_rf(hdev, amldev->aml_dev_data->is_coex);
> +       if (err)
> +               return err;
> +
> +       err = aml_start_chip(hdev);
> +       if (err)
> +               return err;
> +
> +       /* There is nothing to poll but the version command itself, and the
> +        * time to start varies: W1 takes up to half a second.
> +        */
> +       msleep(AML_STARTUP_DELAY_MS);
> +       for (i = 0; i < AML_STARTUP_RETRIES; i++) {
> +               if (i)
> +                       msleep(AML_STARTUP_POLL_MS);
> +
> +               err = aml_dump_fw_version(hdev);
> +               if (!err)
> +                       break;
> +       }
> +
> +       return err;
> +}
> +
>   static int aml_setup(struct hci_uart *hu)
>   {
>          struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
> @@ -613,26 +761,7 @@ static int aml_setup(struct hci_uart *hu)
>          if (err)
>                  return err;
>
> -       err = aml_set_baudrate(hu, amldev->serdev_hu.proto->oper_speed);
> -       if (err)
> -               return err;
> -
> -       err = aml_download_firmware(hdev, amldev->firmware_name);
> -       if (err)
> -               return err;
> -
> -       err = aml_config_rf(hdev, amldev->aml_dev_data->is_coex);
> -       if (err)
> -               return err;
> -
> -       err = aml_start_chip(hdev);
> -       if (err)
> -               return err;
> -
> -       /* Wait 60ms for controller startup */
> -       msleep(60);
> -
> -       err = aml_dump_fw_version(hdev);
> +       err = aml_setup_controller(hu, amldev, hdev);
>          if (err)
>                  return err;
>
> @@ -730,6 +859,7 @@ static void aml_serdev_remove(struct serdev_device *serdev)
>          struct aml_serdev *amldev = serdev_device_get_drvdata(serdev);
>
>          hci_uart_unregister_device(&amldev->serdev_hu);
> +       aml_power_off(amldev);
>   }
>
>   static void aml_serdev_shutdown(struct serdev_device *serdev)
> --
> 2.56.0
>
