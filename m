Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2076.outbound.protection.outlook.com [40.107.215.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D0217C7DF;
	Thu, 22 Aug 2024 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319604; cv=fail; b=Y4LOKxHR0mGw/dbPL9EMTNW+p9WWO27ds4rqg1gO89YCRzXgMeKcpW1QSSnoe35cRiSkl9/o/qz/l12TJlqg88T2+pgPfjnz4Jsw1FeeBdpjQI+mKBJcirFa9+tgnKuDiwZGCuQgy1nyMxy+beC/0yFA2nD8/5GB6AwqQ+kgDvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319604; c=relaxed/simple;
	bh=6Ktam5O+C+cRY8sYJBwsdzGrgifkEEuoMQU+DwK6GQU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PJLYl+A7Q8s0kFblVYuh4tWUEZnDOe23VX+sOO3PnOcD4I0mQjKkDBf8zml0X9WvLgyjDp4OnApE4S4LCmoRZ3dbma25K5AlF3e1ggCZVVeeaHFfGr8RujMGqQDSw+fci6XaoEEuwh/J3mcix70mae1QYT0kzU8C1ZacOyNnbnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VonDlRdh; arc=fail smtp.client-ip=40.107.215.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VonDlRdh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dtl91VzR4fifanRItz+E3Z8qkXghVCxHyBxo5yrxTeiInDOg23XRZlR+F+5JT2w5L0nzwt0oLbz7TrHNcoBR44nzUM9uPuMHSGnsyohIq6TcRr3WxvsMyDZffuNV0vMv3bBMP8n67trq7nlehHKytgMNqyHRDEXr1MeUnFSuBRFPoms78PlmQWzSc2GMCapoR6ruD4HQOHdeZxRvwgs9tbP3zsEaX/CPsCaDGaQ6kZPOmhfOyM3hNIeMGecIOzRp/REhDAOvbsdpnULpuQeFCqNZ7ihi2o8UMOo+6M9ppQirbfX5RTQPCVUqi0lAofiTxPbg2ZP6WIJ0S2gTYihNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAJMtcr0iUFG1GmeaJdmprnjmtv5xn+g6t2DEF8CMLQ=;
 b=yHajdvYcYBpzfxYX6nHLJumh37nocAuAagaRk9dVUPRP6j/TwvGhAQsmWIq6qbXoa0fXILV1LVe0umqVamFO591B3m51CVj4j+LzeAvo/8/qqnAbGw6OIgWF7pI3kxERBEnqmVyBKJVwN7pQofu0d/PrT7m2ACxZvjk4Q8e16aOC2Rdsiku125LOF45L05RmAjcf76Dvr07QvPP+OMZa56vEC8q0rnW2ULs947GFL2dsn6x+e1plpIGy9hIAPAcLpudrwLw5hEBmC99z7BioCacnMKGTtYgh5ZyuWPfGTL9D+3nT/ujmr/KiLWGyii4dw1qRVI8jSn5EvzyLuz2vvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAJMtcr0iUFG1GmeaJdmprnjmtv5xn+g6t2DEF8CMLQ=;
 b=VonDlRdh27SLTUQ4yntPMwhfHGq9mbrbA2cHNrYq2hZhgiXRginX59Rc9v7N/LWDjmGvbbcaw5Y0VnjiEKZzNVz73zLFZByEcaYawxYKjy/Gq2na9cqRBMNRy3lQ0KBwdCZogHb2h1ha7nnN3sU9nehh9OfIhp04t+b+Sn4lW/AT8pESKLo0TXAfy4Dj1H05UE9lTKCMn9jSrdrbL5amxh3CnM5LtJmFd3uJbkAyD6mrP4k7X3Utey0JlbrIeQN1QcIWHFR1jHO+VupIBgGwYj7W+H/Py+9QJ3So11R9ouivoNSmSWykX1251zmAwhXSHlrGA4IinwCVbPXfgd5ZdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by OS8PR06MB7321.apcprd06.prod.outlook.com (2603:1096:604:289::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 09:39:58 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 09:39:57 +0000
Message-ID: <eff06531-0b72-47fc-9f1a-dfa87a49b751@vivo.com>
Date: Thu, 22 Aug 2024 17:39:55 +0800
User-Agent: Mozilla Thunderbird
Reply-To: 11162571@vivo.com
Subject: Re: [PATCH v1] net:hidp:Use min macro
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240822075456.1370350-1-11162571@vivo.com>
From: Yang Ruibin <11162571@vivo.com>
In-Reply-To: <20240822075456.1370350-1-11162571@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0012.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::16) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|OS8PR06MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: b36bab0a-e009-4971-4590-08dcc28e629f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K05lU1RCajlOWWpYZHpyYXhwNUhKZ0lkUi9ZV1lZV1ArTHcyWFNNZFdIYjU1?=
 =?utf-8?B?dkFWZUhsMDJnYWVNbnBaLzRUMlhuYWNoQ2x3RytyMWRvd0xaQVVrcFZ6YzAv?=
 =?utf-8?B?dG9vbTE0RXBEM29BREswTTFHWnIxeE1pckY4dHdKd0I0OUV4TncvdHVmcEpo?=
 =?utf-8?B?NFpFdkFwcGJFbm1maU40REZDdGo2cTRSWS8vUUFnWTBqQWZUTVIxT2dENG45?=
 =?utf-8?B?T3FKTFNDYjZNT20yWjJOeEdiYzFmK2xEaEdzTGZVV2E1RFYyMk55eDlRNEdY?=
 =?utf-8?B?OWFIVmJIOHlGNE9id2ZBcFAwanNzVmN6bHJQWUE3MmxuUEJzQUxxSVJtUUN0?=
 =?utf-8?B?bkVOQ0N1OFNIK3RoUHhRZGY3alBMU1YxM04xVm1LRDBaM0trVk9LU05Ea3NW?=
 =?utf-8?B?SzU0andBVzVFNUM4M0pBeGtjN05ERXV4UE1MQVZ1dnBIT3loOU0wc3ZFdWVN?=
 =?utf-8?B?SFI3YzJZUHVaUnh3WGhQNEQzRXN4cEltT0xCRzZMS2k2QTE1U0dZWS9WYmFl?=
 =?utf-8?B?dTVJVUd4eGlpWm5rVzNYK3Z2RmYwQ0NNdHBpak03b1lUSk1WMG8wU0ZpZUFD?=
 =?utf-8?B?ZUVEcEszR1FDdDAxRjErMkVOb3dVUElQYjEyWTdCeWdWWDd1ZXhIRktsdkxG?=
 =?utf-8?B?SXc1S0ptWXNQUStNdXBIRlBZNG1QQ3ZSekV6TzVEQW9mdUExVHl3RUx3VWtu?=
 =?utf-8?B?U0x3YnlMTWJGSkhqM2ZTZ0oxcThnUXFUR0hoYktvQmNNcWZpKytBclVXOHdu?=
 =?utf-8?B?TWRGbCtqQ3BxUVl2bHhDMDVnM0xGUGErMTQxeWp1TmhuYWp0MEpWOTFSOWJH?=
 =?utf-8?B?U0prK2NnbVFmUVBiNHNOTU5HcnBRM2xXaVpjcmlUMllHb0RLY0pYVExhaVN6?=
 =?utf-8?B?TUlWdzg1a2pXbGdmM1ozN3RqSkt1MXZVVnZjdjZHRHhCSzU3TVJwQjM0NUZl?=
 =?utf-8?B?akZmTVBnU2xQU0QvZkN2NEVXeTA5SDB2eGs3R3JqSnU2NWlWQnB5SnlieXZ4?=
 =?utf-8?B?cm5EZmphRjBJMFFwWm5JY24wbXFnZFJpWitaakcwYllORjlLdGUra3RHcVRG?=
 =?utf-8?B?SWZpRjRiUmhuczZmbHcrNWplVy9FSU9OTXVpd0hSZyt4ZUlsZjJBNXdnTUpF?=
 =?utf-8?B?dEJDczhXOXp6R05kenRpM2pnQUF6Y05sQmhLS281U0E1eEQwUlcrazEwWmRO?=
 =?utf-8?B?U2NXbnJDMFgvYU9DOVljQkNXaFBuTnBIeDFMQ0kxUEcxQnIzSnd6UzdlWDl5?=
 =?utf-8?B?QmU1MWZSS0JlQXJaN01Sd2NZeG5wSHo0NVdUVldlYVExbkNQb2tQVEZBSTBr?=
 =?utf-8?B?bUk2VGVXT2FhZGZGdkZ6YTdNQzZIVkpzTEpvY0h5RCthUFpoNWFTaGtqd3Rv?=
 =?utf-8?B?WUJLdzdJdGdsd1czUjZDd25CTHRQdkJnbjk0ajMrYXphbEtDYmJOSzIwcGEv?=
 =?utf-8?B?ZHBENFdvZVhyMEVaUVZMOThMM2ZIUlFhMVZuUTJMdFRHSzZRbE9HQTFSYmJU?=
 =?utf-8?B?QUFSNlJyRWdOQ3Foc0RlMXpCdW12QW9TOVJ2UEtyd1ErNlFRUGxJUDlkeTlP?=
 =?utf-8?B?ZzVQUVhwdXFRV2FoanBXZlBhbUhRakRSMjBWeWtvTkpZUkdLMUFFT004STFX?=
 =?utf-8?B?aElSSVpuSEI4NFBjRjZqWUtQcExDV1ZGSGdHUXBkOWtndGM3MFlPd29WZnRB?=
 =?utf-8?B?VUpWWjBPbzVlZVhlUWhjS3IwZE92aUJUdVpRVUcwSXpRU09sOXY1eFgzUkZz?=
 =?utf-8?B?QSt5Z1IrS2ZjQTRoejExQXNtb25BbTI0ZC94Y2x1WWJMb3E2L090RGVBaVBC?=
 =?utf-8?B?QTBhbDRINVQ3WCtNK0ZUUWJRYWZyNzlVRTlmN3NJTXpSekN4MUs2TFJ1TEpl?=
 =?utf-8?B?YVZQNnBtRHZPQnNVNnYyRjFVRXVIckI0anFBWDBvOXdvR3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFVHaUVtTFM0ekNNRlRmQ2h5c1ZhOUVlYWFld3h4dTF3N1d2VGRSMW00QWd5?=
 =?utf-8?B?K0lvVkt6VUhvNEpsWStNWW9QeXovRWQ5T2c5ZytMTCt3MUJzVkl1ZnAreWlX?=
 =?utf-8?B?djFrTGYyT2hWUEU2YUdWL0k3bXd5c1hQbDMrdlcxYVFta2l2L01KMmVNNUNl?=
 =?utf-8?B?T3ovRDNaZFhmUmtmbGd4R2NBd00veUllKzlHbDZEbWVmT2NIdHUwc0Q4OVg5?=
 =?utf-8?B?SStiVGxLS0VZaU4xZ2V3SEVyQU1VQWM1a0Rub3B6clQ0VWZaWUNrYitDU05F?=
 =?utf-8?B?NitGZWptR1BFVkVkVFczNktjZEx4Q1dMa0tEdU1ydVoyUkJnT05zMU1yenVw?=
 =?utf-8?B?enQxYUlGTEdkY0pkc3hWUm5wN05MNjYyb2Q5K2FDQ0RHRElrRFlmWG1YVnhu?=
 =?utf-8?B?V2xUYTgxQjNzQyt0b09ESy9LM2NxZ0hXUkpYSnB0UkJwOENkdG9QSmRTMG9F?=
 =?utf-8?B?OGM2WEYvUndnek85OVZPQ3o1MFlLbVU0ZWpJUDcvUlhndmNMR3BQUk1RZGpF?=
 =?utf-8?B?M0h3STZVcUpNWDlpR2ZXRlBZY3hmT21NdVdmRTNRbldLbGh0VzA1MWFNS0kz?=
 =?utf-8?B?YnVvRVA0SVZtMUwxNXplblNHUWZqem0wNUNFZGxXR204TFF0YmJjY255UUZM?=
 =?utf-8?B?YkE4MU1WQ1FHdzRBN2lLMnpoc1B3L1dMR253blZTQk1jYU5jdDNvc0dLcFNq?=
 =?utf-8?B?WE13Wm85Z25ubXFoelMzb3RkankvNFJ6Vzl6bUFvcXJrbzFIWFJJV3JiV1M0?=
 =?utf-8?B?dHlKbjE4L2M2R2VseFVQN3lVVUZObitJR3ZrRnp2Vk9pR3FxdXZCc0ZrSTNu?=
 =?utf-8?B?Mk93NUhzei9hY1l0cXgvR1BXbTRLblhBRkt3Y3FkU3A4b3AwbUwwMldoaCtt?=
 =?utf-8?B?ajlzUTI0Q3pkZmtOK0w5NVdKTlBwaUNFQjdSRzJwWnNPOG93NWJmdGl6VHNn?=
 =?utf-8?B?ZTBTV1lnMC9KVzRkaDZhMDRRb2RsM1VZZ2E4bUZ2SUNQQS9Ocnd1VnlWb2Nj?=
 =?utf-8?B?RlY2ZGxRT3JjSFRGeHRuSXFtUGpSMGNycTlFWEhIYmtGVXp1WmZSdUVBRUN4?=
 =?utf-8?B?eXZxMDVHTzQ3TitRQ2I2eFpVRjc0bWQzVnRBZDQxZ0pvMGMvOGRnUGxyOGRS?=
 =?utf-8?B?b293dmh0d0xMVXJMMFhReTNnUmZ2alNGazBBdVhGUHJ4VGpud0E5UmszU1ZR?=
 =?utf-8?B?bnduNWYxanB4b3NMczl3aEQ1NmF6QVZ6K3UvVVdPaVFhZ1ZucVliNHFnZGI0?=
 =?utf-8?B?aDVSOS9SU0VJcHZROWttNVFYd0pYdGh2cHE3MTJlV1FkVU05eXZGYlptN09L?=
 =?utf-8?B?eXpKVlNjcUxpcU5QQ3NEcUtjZlhaODZmWWVoZjliTllybWp0K3dWdXpqYXh1?=
 =?utf-8?B?bnM1WFZMc3JQYURIaUY5djFwWHlwdExpUXJtY05xUkcvZHYyOVdrTVNlK3d4?=
 =?utf-8?B?bU5WdlV2SUVxWSt1YUFOYUdEL3JpSml0Y2FEZ3JkZktxWVBoQk1pNmZSbHhH?=
 =?utf-8?B?VTVvSjZOUWdvSVk5MUNZTmNUdStCQklvZEVOOU9rdktzWUdkcUlTQ0JQR1Jz?=
 =?utf-8?B?S3V3cXIwMG5TZ0RlUkpscFpWQXJ0Tnp6OWxqR24yRGFFMDZaSDFOb1RBRVFo?=
 =?utf-8?B?cUtMaUlMQ3VOOE1uQkYxYTJabUpXTXJkUUFsSWtnZmZYQ1ZETDcra0JoNlVC?=
 =?utf-8?B?ME9ZNDhycDNqMVdsS0FxSi9NSXFIemNTWm5kRzJWcjFQRHBHNU8vOU5mSXpV?=
 =?utf-8?B?NXpQVDAxRnpYMlB5eWVnSW0rUnQyVWovSDFGbWx6elI2NE5lZllhV0FmbFJZ?=
 =?utf-8?B?T2RHNmQyYTZpRE5rQmtIQmNsTEJCNFBEaEJBYVFMRndmdTNEWUxhelN2SzZV?=
 =?utf-8?B?NHQ0SzdYb0Q2UkNra1R4RGZNNFVMc2FpUTlDUHBxV1V1QU9yZGluaFZoQk81?=
 =?utf-8?B?SnJQRVhhTGtPZEJqTXhaWG9tV3pHRGN2K3h2OHpHVjhvb21OVVVxVy9kSndo?=
 =?utf-8?B?cEhFZC96bmRuVHNFc0x3aU96NDZQdU5zOFgwcDZCTWVzRUFlOEd1MzBKSEF4?=
 =?utf-8?B?bmx6Yk9mYkErOUQvUExhbFRxTHBWeDJTNkJ3aSsrU3VuSG40S3FGa3dqOEtw?=
 =?utf-8?Q?N4gZmYR5O1Ys0GS45GqIMsJ60?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36bab0a-e009-4971-4590-08dcc28e629f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 09:39:57.6676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAT2iN8RiRx+27g8WsWAcUSfVBvyjrB9PHNoL6uJ5XRZvI7CmjfsiVxsGOjBtPgcLYc6i/Ae810AmY/6D+RVMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR06MB7321

Sorry, please ignore this patch.
Because the corresponding header file is not included, there may be 
compilation errors.

在 2024/8/22 15:54, Yang Ruibin 写道:
> Instead of using the min() implementation of
> the ternary operator, use real macros.
>
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>   net/bluetooth/hidp/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 707f229f8..7bf24f299 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -294,7 +294,7 @@ static int hidp_get_raw_report(struct hid_device *hid,
>   
>   	skb = session->report_return;
>   	if (skb) {
> -		len = skb->len < count ? skb->len : count;
> +		len = min(skb->len, count);
>   		memcpy(data, skb->data, len);
>   
>   		kfree_skb(skb);
