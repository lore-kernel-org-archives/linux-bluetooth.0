Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023143.outbound.protection.outlook.com [52.101.127.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F366358D20
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 03:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052530; cv=fail; b=ApdAnkkfV7OGm5MDDqhpIgOv/rDDLVSMsQZUFG764hefwDowuxYyQcBtPWgCTRZwoSljNLMREyuscugRALrfx1DWH47s4Zw/3tvT8XS/F5E9g+oqk+mCNduJVGN3U3H0m1ItpJzgnp93b5KMJ6n7/VZz5DS22Gbi+DOHnKy+mok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052530; c=relaxed/simple;
	bh=xswcUIhAFJoHddDWnS64lDuZebBPO8tkRu7PV1M7KH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fQgq3rz9WolX0QRw4w0JggEXyDhXWUaz8OnDw9+d9l13Li+eeTgXvyMQtMq0eu+vkDsTj4rSK1nsZx879IoSWRUJax0OWZiMwTX74RP6W8i4P8iD5FGjqr7BniK6RrzhpBYrJKWOsyQlmjdicdVfzAuDH3ZJ75S3KpxeXnz9cQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Fagk8xWs; arc=fail smtp.client-ip=52.101.127.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Fagk8xWs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=So1Y5pcSSqHgL0tx2dyOLcvLKuTI5OIH+sRFd+Hv3gCLSUSU6Z58EHXT4KtZmVjROm1TCPRVIspsO+2BrXZ1nZDl93XJhuO41SWgmb9en9kf67mky4HikYinA+C+UniE5HHVIWMYRzWZuJH1/XizR0SuSxDk2WWOF05Z021wScyYIRVHcVAkQZRHYMQhUCwBt3l12fpDu36Z7c9/8ne4UEhZL3dB4P7afNQuxLGdYIC6sAhri03BdVncWfRhLwnf32Xl/bSJd2i75fHahoLsQn6CbCG4WQ+SQPli6glkyiuYdfjgh5aKTWz1ATrnlLtYRt27W2DZIWx8vZ3mu6XfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ky2YR09gDHT72Qbg9NNOH0pxiAqlh4vTpmSiEIoFV/8=;
 b=pE0vVp0cNzMMHVJBmFCP3zR+U3u5kXznFOXQt9OxJsJeRPeghfEHTdvfsF/g+kbDX3q4IlIXXo6t+fM6PBAtmUY9WZnIL4aNVy/ASCyJty28mPoUqzKgUV81AE6cwacQFvRhcqwasJUYIFotS5OkKp298IbhU+kPnJpP4bA9aXNOZ9W/0widmifvdypzw0SKPp2LB2n6bEMLbVDb2UeTgbmWQW82P7w3UYGsl4aDzK1HzhV1pN4PHyQNKQhbjLYfaYaWPF0XdHpgqxHFSfnASQ2FX99bsm21JA4Atm0aO6E8gt1TQ5ry8G+3VfWCYZSXB87p+yYJYYmOqv+NX5OgxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky2YR09gDHT72Qbg9NNOH0pxiAqlh4vTpmSiEIoFV/8=;
 b=Fagk8xWsupAr6q1v2yj8qRYCsnGgO0DlvZS+T4ZicFSlbmcLbxE3wMLAAPH4IZt/oEui6lIA8H8evMKD1CcWwyPSO53M+RHYSztlHHSI83839IrEvblT6ShwBUnG22l/FFq7fkOytcUPa+s7wYWlr8ZJ1fe5egUsesa0bDIeOtanJBjheIEMobCSQU9BQicnkTgTet0UimQdbpuncj5LUxJ4l0y/EC1QbDrA985AoOo3JXCumjs+pTKycdLu8JnJCt3Qi9LiUkSuqRoBP69SdyJSBC3BBzpg8HX4ME2FShjT3KR2OlHQVJR96zY7AcxAnrnV8L6LrEyZH8n04Ty+YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by TYSPR03MB8520.apcprd03.prod.outlook.com (2603:1096:405:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Thu, 22 Jan
 2026 03:28:45 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::eef5:1228:beac:be69]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::eef5:1228:beac:be69%5]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 03:28:45 +0000
Message-ID: <b987227c-73ef-49b2-94d5-4f0ad37c41d4@amlogic.com>
Date: Thu, 22 Jan 2026 11:27:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ bluez] bap: reduce ISO sync timeout to 2s
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20260112-iso_sync_timeout-v1-1-9a3e99259a3f@amlogic.com>
 <CABBYNZ+xrCofAHqVOs4SDn3avXQenNbv4L-sys6_2Lf9PAXFOg@mail.gmail.com>
 <7a1da200-d909-4795-9f64-e7c86d53e0c0@amlogic.com>
 <CABBYNZJgA-i7OFTSgJ=EJLRLR-B7CGSZL0+VfBuVXMoDpxVNGA@mail.gmail.com>
 <9f107c06-123a-468c-886e-4135a08595e2@amlogic.com>
 <CABBYNZLUSGS8Q6kK71vV6FNBL535RQjfO5UNYokR32Ft7p6VaA@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZLUSGS8Q6kK71vV6FNBL535RQjfO5UNYokR32Ft7p6VaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWP286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::8) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|TYSPR03MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b1252d-0fdb-4e2e-44be-08de59665919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0xsempvSzJVS3VJLzFOSW5Eby9vT2hvN2lYbGhKQkt1azRzTjlWNXY1RzlQ?=
 =?utf-8?B?WGtseVgrTG5GQmJHTW9DYW1ESnR5NVpHcWVyeDV3TnRja3Y2aThHYWhaQlpG?=
 =?utf-8?B?TUxqQzZuWFFBMzNJRmw4Zzk1SXdhT2s5Nm03NDgrWG0xdk1FLy9nejduQkFq?=
 =?utf-8?B?Q1h3THFqY3I5V1hNWCt2dzJQZVI1SzlvcS9VT1AxNWJqemhNdzY4K3lZOUU0?=
 =?utf-8?B?S2lqMGFjQjFvbERmMkFNSk9pTUh3U2FzdzJmWHI1NU1PTGdGZmF3TU5ZZ25y?=
 =?utf-8?B?THRUNDVTbHhoUklHZURlUXNKbWtkekI3U3pwR0ZLdVY4cjFEZmpWbkhuUVpu?=
 =?utf-8?B?ekZ6WmNLbG44K0tQSUxyRDJvR2EwakJ2MEU3UDRZQkY1UGxIODh5NE90Q2Ns?=
 =?utf-8?B?cXk2OG42dGFpaFlDTzhZdzFjQ1ljWFd5cFFORE1yclZrOEI3L0M4RzZZVjE1?=
 =?utf-8?B?eGZFQ3I0RFhDV3NDejVlUnJpT0E0WmpHOWZDYnZhT3RYeFFZMDJweFVzdDVw?=
 =?utf-8?B?OURXT2U2Mi9ZUlpldTlHRmJ2UWRqT3l5dUZoYjNFZU9sTkZIaHVzbTJodito?=
 =?utf-8?B?d0lIWXhyZXFNb0swOUJXOG52OHpTeHVXcGV5S2M0NWZNOEg4OVRydjFSTnV1?=
 =?utf-8?B?UnpYL1RRSStCc09HdXVFN3NmV0pIOUhmblk5c2E2dFROUG5HS0xZcEM5NXNk?=
 =?utf-8?B?dmYyc0tESzk3QU00dXdkRnpEQm9SM3k2aFJuMnRQZ1JFUThmcnJFNW1HeVhX?=
 =?utf-8?B?bU1kTzRvWndIeHNJOGw2UlM2dUkyMUVWUlhzUnYzcGtCNXJDSGZ0L1Q3ODd4?=
 =?utf-8?B?QzdSTDBiZ1Q4WE9ZVU10dytPUmpqd1dQU3VTaEJnVUUyWDVkWCt0ejA3Z3VM?=
 =?utf-8?B?VC9BNlFXRkpKaWlLbHZDT1JjdDVaT2piZjV5L084S0xsWWZYUnFHUHFSajl1?=
 =?utf-8?B?aWxkM1BTY1hHeVNTU2J2ZWx3TnNzbmhzbFB5cktxS1htZ3F4b0o2ZngyNlkx?=
 =?utf-8?B?NWxsSkVLNjBBUmh1Sis4bzRYWEkrbFBTcDlCVGM1YVAxaXh6aUJ5UHFKN2tG?=
 =?utf-8?B?Mm1IbzhoSHA2TjExQ2NsNWpUVTR1dGlURkwxdTFvb0lIb3JpZFgyMU1WVVBo?=
 =?utf-8?B?MGhmL3VWU2JGa0FTR2M0bFU5a0RYZElGWThlOXFUWjhYVkZqTktMU1NGcExU?=
 =?utf-8?B?NEFsei9jV2pLOUVFU1BLMEppNGVhOTZiODVtbTJQOGtZUVIvOWNNb3Vtc2JC?=
 =?utf-8?B?ZEkxYVhBM3llemZaU2haTGU5OXFRQUFXbW9zMGZjRlR4TzRoL3czTmxnMzAv?=
 =?utf-8?B?OUVtNHg2NlRpTDNtamcxN3FwWGplOHlDbUhBekt1aThLcW1ZK0RjMlc1QW42?=
 =?utf-8?B?ZFl1VjdjanRqQW4zSTNCaVBGNFowZmtDNkNtQWdhQzFEdGZFK2hsdktvejBn?=
 =?utf-8?B?MG5MWVp5N1lrWEduUzRGMlMyQ3JZV0REbkhhTGtqOGcrRkNzVlFMZ0dWS01Z?=
 =?utf-8?B?SjFYR2YrcHVOYkxnanFRK3grNFU2cUVrcm5pUG9oSTNsTmQ2RmVjekxDK2FO?=
 =?utf-8?B?WHBjRHkrRjhwOTlvMnFvazR1R2M5dDVkeWhpNFZDQWQ0SFpydUpydlA0aENZ?=
 =?utf-8?B?TkNDZUhxajlkbDhjVEhCdTRRcmwxZEYrTzNKakorK2FGN0oxa3BMSkFRUi9F?=
 =?utf-8?B?bFVIRko2L042UVc5a0V4Y2VUTXc5dlVvU0VKbjlvSmZybVJBNTBNVDVib2Va?=
 =?utf-8?B?bUJEUExiOVJTYk1xdTVKNVFTb29lOGd1Vm5CMXVhQTZoQzBvaDNlUExOZUVN?=
 =?utf-8?B?ZmpuajZkSm9oMU9kVUxveklUT2x0SStJOWxOWndMUjFobHZybWFBeVE1OEd6?=
 =?utf-8?B?QUhyN1BGMDdqQ042WWhLNGdIVWFIS3NoYTgvSWhKV0locWJJMTlwa2RUS3g3?=
 =?utf-8?B?WjVOV1RUL3JUQllZYWJYYXFhTFFETWkzMXhxR3V3b2gvbWVZcTlPTVpGQmhK?=
 =?utf-8?B?OUFmMkZyZXZYOXBBcmthMmE3NWtzNjdjSG52T0lTRFdxMTd1dVEvTkJnZ1RY?=
 =?utf-8?B?bU1pYlVyeGU2NndyYkxvaWVab0VDN0ZCSzVlUjIySHJjVG54Q3lGVFh6VGx1?=
 =?utf-8?Q?LQZA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGE3RUFuYk5xZ2QrM2psaEUzZ2phUkRNUHZEK0FCemlEMGJWakNsRXhhOC9X?=
 =?utf-8?B?R3ZheUVCd2J3NThFQktURElMRC9CVGFaQTVzampHR2JldDBhQXZIME15Y0h6?=
 =?utf-8?B?TklQRXE1bklGYkdDMkhyeVVyTUE1cGdqVEVuUVhvS1dzMFRrTURncndRVXJ2?=
 =?utf-8?B?OTV2dXhQNmRKVnhRT3BUblA2U1VZZEh1L2hLWlJ2blQ3Z3pPL00vQWhmc2gr?=
 =?utf-8?B?eFJmVlRPK3VQT2hIbHBNWDFUTUVzMENrMncvOTN1allQRW5UdHlHOEdtNjlZ?=
 =?utf-8?B?Q1p5MXAvV1RZekVtdXBGbzliU0NYSlVxeER0cVJNN0ZEVkw5YXphNXlhbHVE?=
 =?utf-8?B?QU9RVUNHYzJnSE5lZXdUYXZ5MnRwdkN2NnZFYkhjeW50SkVRQlpQQ1RTOG5K?=
 =?utf-8?B?RUgzRk92NS9IdUNZQThjNDBKMzlpRzI5RVJMRVhuWG5zVDd2N3lYcWt6WFNw?=
 =?utf-8?B?S2NhTjdMNWR6YVhNTlBFaHhKWWJnS0FGNlN0Z2xKSnRwNVdnUzFuVDlCZlVO?=
 =?utf-8?B?eUF6TW9ZUTRxNjd3WTlQWXNHSU1zR2RYUklXZy9maFl4c25KNzI0WDdCdVpZ?=
 =?utf-8?B?RTdBSlljRzQvd08xOW5VNUNLazN4RFhxcEV1dmZpRUtQTFJIc1pXanowazdu?=
 =?utf-8?B?YlBGVTJkVHI1cTV1UzBYQTFpaU82QnVZQkU5a01mbXFLLzZzdTVscXo2MTEr?=
 =?utf-8?B?OW4rb1pjcEFFZE5Gbno5bDdnNWFyN2NRaHRGRFJKMGd0OW5vTE83MUt1UjhB?=
 =?utf-8?B?Z3BVV1BVMDdKbHZ3bG9UbDR4WFV4QUoyNzVKZmlOT0d0WVhiUkJlVVRhL0tV?=
 =?utf-8?B?ckZBcENkUk10eE1NTkZtWlM2d3pCTmh1VGZKalBXbUN3akgxVEx6a3dqa0ov?=
 =?utf-8?B?d0Z2N3dzUmdCVzdFNGxoS2FXTzNpSi9VWUZGRzdEdW1uUHZYc3habGFJOVZQ?=
 =?utf-8?B?Y28zUi9wakttTGFJV0w4bXF4Q3RMcUlRb2tmQjRRbVV4MVhndGRvZHQvY1dW?=
 =?utf-8?B?eUVmTEsrNGhLLzM0eUFjMitNeGcvd0VZL1JKUXIvbXdsMGU0OENmUlhLVUNw?=
 =?utf-8?B?SWlUSlgwRnRGWUdHbUtyR2liTU9URE9FdWt1UzA4c0h1ZHc0Nk9sek1JSm9a?=
 =?utf-8?B?RHVHMk9NcDdORGp4d0hVOWM2NWZOaCthcFQ4TjRLUXgzYU1mSEdrYU5SNDZQ?=
 =?utf-8?B?MEEyZmpmUUZFeUtWTjdNQ1hvU0pEeTZiMndpak4xdlAzcTd3Vk8vZTR3MitM?=
 =?utf-8?B?Z3cwUFRnTjIvcll3VnZNZ2ZveFdBeTJBM3RFU1RNOFlFZ1Z5MGNPT3dwaXQw?=
 =?utf-8?B?dGtPWVhJMG1VOFUrRlB4Q1lDdzJQNHNMb2hDTUwrZHZpSnpTS2FpT0FhalJ3?=
 =?utf-8?B?V2FSODR3eXB1ZkQwUFpHNk9iMEZRS05LSE15QWZ4MG5MVnNSOGovS0NtZGxS?=
 =?utf-8?B?Q3YyQzFtTnZwWGNaNVY3eWJ2aEtGd0FwR1hmRUFLaGl6TVRxOHMwRVVmTWFp?=
 =?utf-8?B?VzY3K2k3a0s2blZDOWlCV2xSRlQzdWx3MUhzOUNnZkVKRVRUeEhOdWFLYjJn?=
 =?utf-8?B?emdPQzNuam5RZWVNSmwwMy9FckpOUTN4S2pOclJPbW10WDVkUnZnVFI2RlVr?=
 =?utf-8?B?YS9GRm55SXdqQ2xRb1RneHEyWGJsWEpvTDF6K0Fuc0h6QkhCdHNLSWgvd1Zy?=
 =?utf-8?B?MXFBNWZUS3VzaHpFbXhnYkRla2tEbHM1RklPZllCc0F1MXBFREFVR1Q0ME8z?=
 =?utf-8?B?dE1hOXpRcTJmei9QNXVNb2hOK3BKb3c2TVFmWmFKTVJXdmFwWWJiMzRPMVNq?=
 =?utf-8?B?ZkFOa0FyWU1ndnhJOEE2NXNQcWorNWxUa0NGVWUrVUpjWDNwd2MzckhMQStD?=
 =?utf-8?B?UTR3RHpEZjhFa05ISnJMZStqZzV6TzRWSTN3TDNhYUx6V0tDcm5DQmZyNTBo?=
 =?utf-8?B?M0hjNXBTK1NzSmxtamJYb2dFZmY3d0U5MGxyb29qVjBNVlpjM0hBbGh4bTBD?=
 =?utf-8?B?Vk5yMDdGTEJiMnNDd1NoT2xTYkRGb2NzNGxBeGd2QmFXWktPNnZ4azVudE9T?=
 =?utf-8?B?ZWJKRFUyazRWVG5MNmFFYk02TC85QTRXcUVtSUIwZW1Od05HemRrTEt4T1Np?=
 =?utf-8?B?cTFtTk9wbDgxZFA4cnVWS0lEUEdjV25kZ2FYL0Q1YTQwQzVNTWV5Wk5vTXFn?=
 =?utf-8?B?RlZUS0xWUm5DM3dTN2tzRDRrS21oYWJ3cUlTbVhqMmJuVzdyRzV0YWhtMS8x?=
 =?utf-8?B?SHpwREpDd3FQc3BWeE5NeVFTcy9XZzBFSUZTUHpCV0lTT0hsMVk4RkU2OFlj?=
 =?utf-8?B?Yk5XKzVYTlZxajl2VmVnQmI4eXVySjZwTUpFODg3MXNKQ3B1aUJqUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b1252d-0fdb-4e2e-44be-08de59665919
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 03:28:45.1108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bdi60m//i2iK17LkYXwAJu51F/5tndhFKsGkpIo0v+EU0ETc3zRrteflgAHXaslVYq6FJBd3gGOzcCJG95fpNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8520

Hi Luiz,


> [ EXTERNAL EMAIL ]
>
> Hi Yang,
>
> On Wed, Jan 21, 2026 at 2:27 AM Yang Li <yang.li@amlogic.com> wrote:
>> Hi Luiz,
>>
>>
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hi Yang,
>>>
>>> On Thu, Jan 15, 2026 at 4:42 AM Yang Li <yang.li@amlogic.com> wrote:
>>>> Hi Luiz,
>>>>
>>>>> [ EXTERNAL EMAIL ]
>>>>>
>>>>> Hi Yang,
>>>>>
>>>>> On Mon, Jan 12, 2026 at 1:42 AM Yang Li via B4 Relay
>>>>> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>>>>>> From: Yang Li <yang.li@amlogic.com>
>>>>>>
>>>>>> The ISO sync timeout was previously set to 20 seconds,
>>>>>> which is too long for PA sync. This could leave the userspace
>>>>>> flow pending for an extended period of time.
>>>>> I think we used 20 seconds based on the connection timeout, that said
>>>>> I do wonder if 2 seconds is going to be enough given that the
>>>>> advertisement window can be wider than that, specially when SID needs
>>>>> to be resolved.
>>>> Yes, the Core Specification defines a PA sync timeout when no PA reports
>>>> are received for six consecutive PA intervals. In our testing across a
>>>> wide range of devices, a PA sync timeout of around 3.6 seconds works well.
>>>>
>>>> This assumes a PA interval of 500 ms, which is already a relatively
>>>> large value. Taking into account six intervals plus the time needed to
>>>> receive extended advertising during scanning, this timeout should cover
>>>> most practical use cases.
>>>>
>>>> I understand this is ultimately an empirical choice, and I am happy to
>>>> adjust it based on feedback. From your experience, do you have a
>>>> recommended timeout value?
>>> Actually the code define some recommended values for us to scan:
>>>
>>> TGAP(Sync_Scan_­Interval)
>>>
>>> 320 ms
>>>
>>> Interval between the start of adjacent synchronization scan windows
>>>
>>> Recommended value
>>>
>>> TGAP(Sync_Scan_­Window)
>>>
>>> 91.25 ms
>>>
>>> Duration of Synchronization scan window
>>>
>>> Recommended value
>>>
>>> TGAP(Sync_Train_­Duration)
>>>
>>> 30.72 s
>>>
>>> Duration of synchronizability mode
>>>
>>> Required value
>>>
>>> That said the duration seem to be only mention in the context of the
>>> source, anyway perhaps we can use 6x320ms=1920ms(~2sec), this will
>>> make us resolve the broadcasters a lot faster but then we need to
>>> check in case we timeout we should try to rescan a few times.
>>
>> I understand.
>>
>> In our system, the application layer has a timer to monitor whether the
>> PA sync process times out. If it does, it will re-execute the scanning
>> and PA sync actions.
> You mean in bap plugin? Or something other than bap plugin short PA
> sync that enumerates broadcasters? Anyway, if your system is using
> something else that is besides the point, the thing is that PA short
> sync shall be able to recover if the PA Sync times out.


Yes, the short PA sync is implemented in the bap plugin.

The application layer will initiate an LE Scan with a timeout of 3 
seconds. Once the PA sync is successful, it will create a transport and 
notify the application layer via the DBus signal. If the PA sync fails, 
it will rescan and trigger the PA sync again in the next LE Scan cycle.

>>>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>>>>> ---
>>>>>>     lib/bluetooth/bluetooth.h | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/lib/bluetooth/bluetooth.h b/lib/bluetooth/bluetooth.h
>>>>>> index f9f22c3f7..572009e75 100644
>>>>>> --- a/lib/bluetooth/bluetooth.h
>>>>>> +++ b/lib/bluetooth/bluetooth.h
>>>>>> @@ -152,7 +152,7 @@ struct bt_voice {
>>>>>>     #define BT_ISO_QOS_BIG_UNSET   0xff
>>>>>>     #define BT_ISO_QOS_BIS_UNSET   0xff
>>>>>>
>>>>>> -#define BT_ISO_SYNC_TIMEOUT    0x07d0 /* 20 secs */
>>>>>> +#define BT_ISO_SYNC_TIMEOUT    0x00c8 /* 2 secs */
>>>>>>
>>>>>>     /* For an ISO Broadcaster, this value is used to compute
>>>>>>      * the desired Periodic Advertising Interval as a function
>>>>>>
>>>>>> ---
>>>>>> base-commit: a94f994201a69a36753abda65cc51937de9cd3e3
>>>>>> change-id: 20260112-iso_sync_timeout-8e3ecf43d82e
>>>>>>
>>>>>> Best regards,
>>>>>> --
>>>>>> Yang Li <yang.li@amlogic.com>
>>>>>>
>>>>>>
>>>>>>
>>>>> --
>>>>> Luiz Augusto von Dentz
>>>
>>> --
>>> Luiz Augusto von Dentz
>
>
> --
> Luiz Augusto von Dentz
