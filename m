Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022139.outbound.protection.outlook.com [40.107.75.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3445614E2F2;
	Mon,  4 Aug 2025 01:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754269650; cv=fail; b=j+wY+N07oiWl4g1wzl6oT2srLgplH4g6tQx5soWL6B+gBhMG8Hb3H4ouBEPFXpIhnwiiahdI6ZGWpKlgtX63Xf71Qqkzz4DQ4O6fljpEFgohQKbMvGI2pDgezWQQvmE6QYhbBljY7QIHl258r+n6CV2+93FpUKaU1FFv9Q7F4QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754269650; c=relaxed/simple;
	bh=Zlzlefx8/hOVGATW2gZFwW7t+c7+sVlGIQSFlJZ7jPs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D2Wp0T8Swdnv9+35r44GfAZZ6jLFM/wjDCYSZQK6f17siVjncuzOKAZNvvm3Zr8/EDC8KJgcPTkcTa+F7kVM/Q0yoxXd2Rs4HpLd3wbysu0R8jUhtt8DPVa/By7o2KEaX4W0GqkkQ0kYD28DdZd1lwhpo0mdWC5/tTYjCykkX9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=koKWei4q; arc=fail smtp.client-ip=40.107.75.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="koKWei4q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6HXAcpZ8PUOeXxrybaxg81N7AQJDIHzJIGficr7Aw5mSeik2R5/+BqBOTFJ1BX9CD3/ktb9+9llH6+BYmuiu4nOnedB/GOnw8kxmmxjh8Ck8a7FZglXuLJReJ/FkxRc3EkLFPchfxqz3xpX6RvyXXOHAXLAcyAZIEy5Q+ijhBj8kz8hWqwBVQkSiF4hMsaKWbSC3efOF7gnZQSFnTP2CeBftAjhbl059S1hl1bVrlHSQuAHm0xnGlDB5moUgwuCGZeRJlpXe1t4mKMhIOnnsZQhtTR47hAJv0lIh+hc9uRl8BxkcU7K+TzAktBMGs6/rN7ig9sm8NiNrXbClOsnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxCHdHYnsEAGABZ/e7mcDjbZGhVlrmL/FIxQBcyvFWo=;
 b=NfHdNdCT6SJgrhyD+e+jY5PhoN5Q++6Setb9fmh8mu8VuNl0zjjm5R4GLkspIuUPTLpzcNO0G5SIT7oExl/6YaawbslM8Ie+P1VC3/UHymgCuKNGM2gQ+CeaUjVwMMgEd00FdaAy/LX/8kokzya9DdGPmlPaBiHuNqsQnKCP6U1+RCppB+I95VkfPxyjuiZ63ylX5A1erjU/Gvc1Xcx6eWPgQIU5qHL7XwLsGFTSram8ShF3gHbvsbFObVvn4zujThlEOFG0pq3rqWMqOVBRb9XIlaSTsj5BQslCiP/nmneZmFXV6dqYf78istsUxZD/Gh7kNpdi7EXBcBTTLrTaow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxCHdHYnsEAGABZ/e7mcDjbZGhVlrmL/FIxQBcyvFWo=;
 b=koKWei4qgDJ8Bz4KIKgyt//wHxk2wIeTKHIzp2NXrlf48hFFCXMzqM0W+g5JPM1b3gAq/KvjCbiBl4HhZS487d1ANOg4VaMi58V7H+NWtz9KV3YSmwr9uVwmVGt80g1F+kk9OlVMcZcRO5JYc3eAac1Y0EzlkdQO41t0IiJ7HNEYQkX6rdFM42fHKNaSIyemjQDsyvb2fr+yDLeGHZqwtibK9xKvIMzshp58I5UPjBlUDE3lWsHXqCdz/XXmvxIjQCRraYJlXs91HY57VljrfGYqRe/OzUqh5px9XFDF3UhJTioN1EqfMyTd6aaIXAkAlzxunzgGIOAl38/8X7l6Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by KL1PR03MB8009.apcprd03.prod.outlook.com (2603:1096:820:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 01:07:24 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:07:24 +0000
Message-ID: <4e0b2df6-1139-49df-b03b-a2f31925d52f@amlogic.com>
Date: Mon, 4 Aug 2025 09:06:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: iso: fix socket matching ambiguity between
 BIS and CIS
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250731-bis_cis_coexist-v3-1-1f9bd60ef712@amlogic.com>
 <CABBYNZJu3izq6ZhNRKjMz-mW1CcP2VAE7Xs5oq=NupnVD7aayg@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZJu3izq6ZhNRKjMz-mW1CcP2VAE7Xs5oq=NupnVD7aayg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|KL1PR03MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: d025abec-f359-4e87-4268-08ddd2f34550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVdCUjIzelNkQ1kzalB4VE9rSkdkVGw4UjcwYjJjcEtvdFhqVUZ6ak5iZ0k3?=
 =?utf-8?B?RWFFb3JjYnhIZWF5eUY3d05UR29yZytqV1p6QW1VTGVOQUNGN0RvelBvaGdq?=
 =?utf-8?B?ZmErRXMrbDJkeThaalV6bkZYUUpaRVBobXNxUUdQVDZSTG5wY3pQcTRQRHZB?=
 =?utf-8?B?NTB6OVJFZ2p2cDRKTUVOMTAxci9oN1I5WFJ0bmJKZEl0OVl4eUFIejJxMlEw?=
 =?utf-8?B?RERRSzFVbnQ4OEpiaEZVNzJRM3MwcTNwZjRDMHBxQXRxMDF4cVU5UWZoTHFT?=
 =?utf-8?B?ejFxdEZ4bDhnN1V1MU9wNlRBTUZwMGVsZjBObFRaU0NYZ2k5WlRyRjdPZkxn?=
 =?utf-8?B?UDNPdndncFZFbDIwbjJ0MWhjVUNHaHV4UzBVemk1VUw4NFZSVzVVUXpoMkpi?=
 =?utf-8?B?Skc5Q0o3WklrNktmNlM5NlRwZFRFa2RXd0pKRW8zdVR1cDZENnZwaXpIMmd4?=
 =?utf-8?B?b21jcTRVQVJEL052cUEyVFVIbGZpcUFMZVBXNE0xUmU3cm9wdUE3WE50WGRR?=
 =?utf-8?B?SEZFM3djekZOMGY5U3pLbUZxK0RISkdzeWNHblg4VUhvKy9uc2FDVHg4OTVi?=
 =?utf-8?B?clZ6bVMrUHRXL2pBSkhwek1ZemhybnAwa1drVEpoRHNBbytNTEVJT0xsS3hn?=
 =?utf-8?B?MGVsNmFCaERuZ1U0SnhCSHpjb2JXTGxiZGxuTWhiMnY5aTByZGhTaDJsVzM0?=
 =?utf-8?B?MEs3MVFjL25md012anU0RkVxUzJLM3J2OEUyZWpWRDFrcklmUFMrbW9QcUJI?=
 =?utf-8?B?dWFXSnd0MHgzY29BZVd0c3YraElUMi8vTGlvWk9wanpqNCtxdlNSOC96bk8y?=
 =?utf-8?B?anYwV2Y4Vlp1bzRHd3BNTHBjL1ZCVlpBWXYxU1lXaE13QVNnQ0RzTEx6UUh3?=
 =?utf-8?B?THk2Qy9yQTIxQWd5OENCVXY0cjJmNjhjcUkxOVM0b1FrRUd2WEp5RnQzTk9W?=
 =?utf-8?B?TS85RXZ1eDZONFJHWVZsbDFtWVhMYkdkR2JVbnBnMkdCWWVGKzJibWdJN3pM?=
 =?utf-8?B?czM0MGJheUgwbmJJWVA0UzR3dXloQ0VwNDVmdURBeUNEVFRjaTJyTG44VEJR?=
 =?utf-8?B?STcxNnlVUjFSR3BtMmNzaStkYXc1QTYyR2tZRXgzd1k3bUJJemdvZG1MdUxw?=
 =?utf-8?B?M3RVVEp5TW42R21JVTB2QUhGMVZtMEpjVG1ySUh4T3lFYVpLQncvYnZPVzZw?=
 =?utf-8?B?ZmkxN2s2NlAyQTJiWm5JcnplKy9pZFFNOTJVSUQyZDY4UFZNbitQL0g3dmh1?=
 =?utf-8?B?T0ZUT0hCSzVYb1ZWejYwMkdRalNDQnNPdVJPY00xNk5HdU8vby9IL2xta011?=
 =?utf-8?B?T0xFVGtIbkk1YnVOOXU5MVpJLzFMSmxSSjZmUWVKSkdEMGh0b29kdEk2N3pS?=
 =?utf-8?B?MHhhMEY1TXlvcHUzajRGaHhlaEVQSnlrbUdGeUZ2alNKYTN0c1FqNnZxeVRu?=
 =?utf-8?B?dktIWWhhVGd3WjNWTkJUMEdpSEZXRFdQenZEZ1JyUUJNZTBXejU1aGJ5TU16?=
 =?utf-8?B?VXM0Wm95aXFSUXBYNmZYcEowVnlFNUE3OEFlT2xSbWthOWRNNFhhSUhVdWwr?=
 =?utf-8?B?dGJsdW5JMzVqb0JGUEdNWnJQa3dMYk5nbC9DZWpxY1lrb2pRYWM0M3pCMUZm?=
 =?utf-8?B?SWRhQkV5N0VxMHFITU1zQzR3MHRHUmNXNGJaMFd3dy9NbFNXTytYbjg4S1BL?=
 =?utf-8?B?aWtyNGMwb1p2cWFtRjJDNnExT2FjMGdIaDRMempIWUI2QXdPUVVTMndKeHlX?=
 =?utf-8?B?eDA5a2lpN2ozNGFhQ0FhOGhTNG0yRHpKSlhxZjBMdWJpR3dsNHB0OEJmdWhN?=
 =?utf-8?B?bnB5MkxWR2g0VHJCQjdnbTJMMjBsK3hEWldDaTZiTWJ4WGtILzVlc1BMZEZR?=
 =?utf-8?B?c1NMQkxvTWZZZWVDVUhQVEZrblhmWUh6dU9jbzF3R2FaTGE1bGNXdDN1RElE?=
 =?utf-8?Q?2iJF9AW5hEo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDlTU3cyT0tzWC9OUjlnaVZNdVFkY3pVZEJUejVtVnBNamZDMlhURTh0YlRH?=
 =?utf-8?B?N2hUMTk2RWZyZmxYSjQ2ZDBreUVDR09ZSHlWUDJ4YUFzb3Z6TDFOcjJUNXpL?=
 =?utf-8?B?MkRVd0FwNXlnK1NNUTJzTHNKejc4MG5uZmJiczVWcGZTei9LUVorQUhtRHJV?=
 =?utf-8?B?enl3MTdkRmUyUlR6SDR6ZXd3MXFiUEpIVG44ZVhJcXhwODFxOFMyZDF0NWhQ?=
 =?utf-8?B?Zm1pdUR4NHppQjYrOCt2SnA1bmVyUm1QcnNZRzBmLzB1SXlyNjdaU0tkaDZs?=
 =?utf-8?B?YVFOQ0wwRWxyOGh5S3FsZXViTDExaTUzM3FhSmw2bGdLV2V6YzJ0WllSdDYw?=
 =?utf-8?B?bi9NMm9WK09BMUxQcHVvRmZxalBRektpM0hpcHNMYnpkZXRWd1NlZGxOOTJF?=
 =?utf-8?B?ZWtSRVJ3dmxuRU9iSDByM3o0OEk2V0xSZlI3NzZ4VUVGc2I3dElzWDg5UGwx?=
 =?utf-8?B?U3Z0N2lUZXlSVWdkTCtqbWJ2R1VOeU5NT3F4NDU0WGp3MTE3OXcyeG5WbHUx?=
 =?utf-8?B?bGtyYWxjemF5NzNKbVNYQkYwTCtTNWtRTzhSUFdOY2NsK0YrakxkbnZpU1Zo?=
 =?utf-8?B?N3VnZXVHUWFVeDY1VWN6T1ljSXBDT3FhZXp5WGI5NGRQVFZEVE84d1NsSENi?=
 =?utf-8?B?YS84a3p2d0JtcS94YkNDWnRLYkc5U1VNNzFpeUdMODBySHZ3enhJV3dxVFd4?=
 =?utf-8?B?MGcwOVk1Q3RQWE5kdzdxMlB6Zmh3Y3VlUnB1a3NPbVpleTkxYTlObk5sWlFk?=
 =?utf-8?B?bHdKSlN2c1NPdzFZQ1ovNmFzZHZaS2I4THRHV1Rxei9TbzhpKytkY1BpeFlT?=
 =?utf-8?B?bkg2aEFEU0NRK2JzOWFhdXBGZ2YwUVBzM1BnNndORFlpSHZEZ2hoWE8yNkhF?=
 =?utf-8?B?L2FIalIrWlJrdHh4NnUxZ2d0SjRqM1krNnFxNlYwMzF5cVVyVWpYQXRVWUo0?=
 =?utf-8?B?ZUp1OHJ3bTd5eDZWZkRUaU9sbi9BUWhaVlhEZU51NktGc3NPbWFXSERqRFdE?=
 =?utf-8?B?ejIweXRrNDQzbTZwMUhwODNGUGlDL0RkekFVQXdnNFVJZDZCczRJekp3NjAz?=
 =?utf-8?B?RHp5bk1FdnlBQjZ6K21DaXBWQ3o2ZkVxL3QvZkZmUWtWdFVjbWtSczNmdlBF?=
 =?utf-8?B?Nm5KWWN6Um1QTjkvZnJyUEJrc3V4UkprcTFsMlltRWJPOFBwQm1iQ250OWdB?=
 =?utf-8?B?Q0dEMU5KbG5xS2IrY0NST0lrY3dZN0NvcHFMQURsZGtUcjd4dnVxQW5YOUYz?=
 =?utf-8?B?dXhqMDRHVWdFUXBnd2U3aFppY2Y4VjE1OHFpdWFacUdLaEorOXVFR1N6WnNY?=
 =?utf-8?B?ZjVWY0JlZFdESDhwUHhBcHpRZFRTa3NXN3pxbUhTVlRaMHZpZThadU1SVEFB?=
 =?utf-8?B?dHdBNGJnM0syUzhRSkczbVpzVTYvaGhRS0FKcnVESGg3djV2cEwrZXF6aFFr?=
 =?utf-8?B?S0p3ZmR4VlV5enRKZW9abFh1MW1ReGZWaC8vQmhVaEQrQVk0UGkyeVJLYmVP?=
 =?utf-8?B?RVBEL3MweTZwMzBBSlNybmRDdm1rcnA5cFhBL2xtT3FpRHdnWlVGZWcvTy9n?=
 =?utf-8?B?WDVjRG1DSWdOUGJFWEFQUi9lUFBOeDk0eU1MS0kxVmdzVE1qbk93RmgvSkJs?=
 =?utf-8?B?UXJLZk1mcTUreDNtN1NDSGlpb05kWDBuWE9rK1N5YmgrOTF2alBvdFRtU29X?=
 =?utf-8?B?Zks3ZGRHNUIyRjFWdEowSDZoOUd5U3BpWVpIbFhveWg3aDB3b0xjdVFRS0NY?=
 =?utf-8?B?SXU5VVNXYnJwdGRjYlJneUIrYmVsRVhReDhGRHJOeDlORzFnb2Z5eVI3UjN5?=
 =?utf-8?B?L0JLbTZ4Sko2ck41Z0x4aGd3eWJoTUVaOFg5U1JRKzc4SGY1eVZpUFVGMHR4?=
 =?utf-8?B?YjFxbC9aczE5WmxiNVJBVzU4Nnl1S21jZzgrOGtHSXd4N09aZHFENWRINk5v?=
 =?utf-8?B?OHN6SVVoaElVbENiRVRYUGlieFVJM3QxODJDL1djWUQvcE02R1k0N3NpZ00w?=
 =?utf-8?B?Ty9ub1c2dlE5VHdodWVRUU5kQUNkbWVzTDJoU1pzbndVTDAraTRIZDV4NmFs?=
 =?utf-8?B?NkhPeXdSSmh6OE1SZG11b1dJQ1VsWW05Ukx6TEtBQndoQWkreDlFb3dXc0pN?=
 =?utf-8?Q?2cylP/upBdY6S5hjFdNwgx9hb?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d025abec-f359-4e87-4268-08ddd2f34550
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:07:23.9705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PXMXUddq2CrTs5Q9xwZWYZlEgaA7cVR9PcaXktooeUXX3EtB78jBX51LeO3IY/xBl7PgS+bdFcJTBOir6jXLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8009

Hi Luiz,
> [ EXTERNAL EMAIL ]
>
> Hi Yang,
>
> On Thu, Jul 31, 2025 at 4:00 AM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> When both BIS and CIS links exist, their sockets are in
>> the BT_LISTEN state.
> We probably need to introduce tests to iso-test that setup both then
> to avoid reintroducing the problem.


Since the coexistence of BIS sink and CIS sink is determined by 
application-level logic, it may be difficult to reproduce this scenario 
using iso-test.

Do you have any suggestions on how to simulate or test this case more 
effectively?

>
>> dump sock:
>>    sk 000000001977ef51 state 6
>>    src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
>>    sk 0000000031d28700 state 7
>>    src 10:a5:62:31:05:cf dst00:00:00:00:00:00
>>    sk 00000000613af00e state 4   # listen sock of bis
>>    src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
>>    sk 000000001710468c state 9
>>    src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
>>    sk 000000005d97dfde state 4   #listen sock of cis
>>    src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
>>
>> To locate the CIS socket correctly, check both the BT_LISTEN
>> state and whether dst addr is BDADDR_ANY.
>>
>> Link: https://github.com/bluez/bluez/issues/1224
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   net/bluetooth/iso.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
>> index eaffd25570e3..9a4dea03af8c 100644
>> --- a/net/bluetooth/iso.c
>> +++ b/net/bluetooth/iso.c
>> @@ -1919,6 +1919,11 @@ static bool iso_match_pa_sync_flag(struct sock *sk, void *data)
>>          return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
>>   }
>>
>> +static bool iso_match_dst(struct sock *sk, void *data)
>> +{
>> +       return !bacmp(&iso_pi(sk)->dst, (bdaddr_t *)data);
>> +}
>> +
>>   static void iso_conn_ready(struct iso_conn *conn)
>>   {
>>          struct sock *parent = NULL;
>> @@ -1981,7 +1986,7 @@ static void iso_conn_ready(struct iso_conn *conn)
>>
>>                  if (!parent)
>>                          parent = iso_get_sock(&hcon->src, BDADDR_ANY,
>> -                                             BT_LISTEN, NULL, NULL);
>> +                                             BT_LISTEN, iso_match_dst, BDADDR_ANY);
>>
>>                  if (!parent)
>>                          return;
>> @@ -2220,7 +2225,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
>>                  }
>>          } else {
>>                  sk = iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
>> -                                 BT_LISTEN, NULL, NULL);
>> +                                 BT_LISTEN, iso_match_dst, BDADDR_ANY);
> Perhaps we should add helper function that wrap the iso_get_sock (e.g.
> iso_get_sock_cis and iso_get_sock_bis) to make it clearer what is the
> expected socket type, also if the hcon has been set perhaps that
> should be matched as well with CIS_LINK/BIS_LINK, or perhaps we
> introduce a socket type to differentiate since the use of the address
> can make the logic a little confusing when the socket types are mixed
> together.
>
> Now looking at the source code perhaps we can have a separate list for
> cis and bis sockets instead of global iso_sk_list (e.g. cis_sk_list
> and bis_sk_list), that way we don't need a type and there is no risk
> of confusing the sockets since they would never be in the same list.


Alright, I will give it a try.

>
>>          }
>>
>>   done:
>>
>> ---
>> base-commit: 9c533991fe15be60ad9f9a7629c25dbc5b09788d
>> change-id: 20250731-bis_cis_coexist-717a442d5c42
>>
>> Best regards,
>> --
>> Yang Li <yang.li@amlogic.com>
>>
>>
>
> --
> Luiz Augusto von Dentz
