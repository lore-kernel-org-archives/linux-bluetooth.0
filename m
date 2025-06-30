Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023074.outbound.protection.outlook.com [52.101.127.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789871FDD
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 07:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268081; cv=fail; b=WHOAuQYAcBn8YZGT0POzX6JssbxQ9S3gENXNAPANERzKGfCEqDK0Wpyddsh1/SgDxfDlP4g7zPrSYhvY9xl1iscCSI1lU4O9p4PzpPZezAVTlvHZlry5ZAZ0iyKw/zkUOAorXU6IJ9Sk1IVKox5jTaay9OAIrhuoUK++XRhkTlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268081; c=relaxed/simple;
	bh=7ienRPkEmuxWqN2Yeeiaz90hiaKi4++zF7OsMXavcVw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kyiS+Eu4wtAeCu9JFjEJmGOlTL11PIOCWcBWotfq/vOoDCKAVVYHKkZLNHEb3yX9tcUl5YwTYvu4/rlHmeWGE7j1idgr5fKBR03QIMeSQJ0KUUCuDlh5VTueP5gDq5ojQSouCU/a1Hd9KWGOlr1XYU+RYqXEMVc86Vth6Vq7zqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Ruq6KpqM; arc=fail smtp.client-ip=52.101.127.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Ruq6KpqM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s62C94KznGb/SyjL0bsVbWIgWrjrRG8k8LjIEd4IBzZV56RrW0Cx7ti1NCzVtJJJq9bN8GQyKv937mCVZiBRMusnoAHvuc3F+ETN3JwfBPY0TrVPkllTUxXmNfS0LfFYYZBmI3LzvgNNbm/l99G/Ii0YIoxVPrWy2NijclOop82ooDW5vfe9lNKu54SBnZtmzyJ1lAWy2jukj1eqpxa82iiWZTO2aUaEvZw9/PgJyt25rcEG5QpQYLEVOz/okPeH1hc3g8dOy5rSPlPa186hxvB+bidpOQZST8/OxIV7jAwaXlJhY1zq2a/Dn4NrzoQrqYi+YrW13nYilTRLxstjlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYYoLpsvDhH8S12Z9ECCzOGZikyrRIaasse9vu8agsM=;
 b=yQyvnPTpRTboiSJboB0sSIyMXzcp/Xh3+395lpoz7tlwb5Tbs8INxT8MhQYUn8qDSf0IbYJXUD0Rg0fEE9HXuWHpVBI+F7yaUU87GgE3jc7a8qCjxPPUUgOdOuhjZA61cADmIeMM6OyYtiURWoKIQYLYP2vYPg7mRmIpRAY8gf6JirAyshC4ruxH6sTXlTiNcZA5iF7FER5hIK3d3Ma0E32ADYMxHOR9KJ45ZFPmlwhriIVyR+NlSdHwZCY7sQuqqf9do6eRLsDLAx4yF7UBv/TuFcFjGU/vQw6IT3RVVyGCBeZ8Ltylr3iuCYUl8P0PR5SilSlX65jg9Kl1PrfyhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYYoLpsvDhH8S12Z9ECCzOGZikyrRIaasse9vu8agsM=;
 b=Ruq6KpqMtrVfyLUE4cF3YivILuga/lWIwKati7NbppH3Iu9gHllXAyic8FLlA4cBZYj4cXut6ODpvfqGk981g4tKi/+BhhSTNSUNgs3Ie3CzMLCvxwuFZ9hN/sGZtxRyVDMAo3bSO1kPM/K+KHHkeG9jDgCSI1B1kSefLhw0GyZ29q6KMrbqzKHXVswvxiF85Ruzw6mlIliFtfPqJCJqFRR/ZTJztO1Hf/7wImJZCaMa52oJgjwhYRXStQZF8QIv3rfAiCwC1j7mRtBvRL1KB7LUb38vD2PQkCk5DdjLpd5ZZEsY20AW6WAPf/5TNS37Ku6fmjDbJHp+0lGdPrFSyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SE2PPFB985F6192.apcprd03.prod.outlook.com (2603:1096:108:1::4a7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 30 Jun
 2025 07:21:15 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 07:21:14 +0000
Message-ID: <43fcb117-926d-4386-9c14-51e0fa1075df@amlogic.com>
Date: Mon, 30 Jun 2025 15:20:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ bluez] shared/bap: Set stream to idle when I/O is
 disconnected
To: Pauli Virtanen <pav@iki.fi>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20250624-bap_for_big_sync_lost-v1-1-0df90a0f55d0@amlogic.com>
 <CABBYNZK=5-N8wcHhSp5ii8FmM5CzPFqKheKHOcCs8brNhVp_ww@mail.gmail.com>
 <1f2fe697-6437-4000-8aa3-d09bb7090a46@amlogic.com>
 <3ac16d0a7c5569bce0b28f18bc2245bef8ab64c2.camel@iki.fi>
 <28726e2c-aa65-4e64-b2a4-98d59ed5270f@amlogic.com>
 <9e997563aa6bb21c87fed41b89e9691465207d15.camel@iki.fi>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <9e997563aa6bb21c87fed41b89e9691465207d15.camel@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SE2PPFB985F6192:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a0175e-ac24-4a91-65ba-08ddb7a6b235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alFaaUVLMjQ2UjZKb0E2Tngrdk1aZGsrdVB0OWY4ODFjOG5Mc1J4V0FiYkFi?=
 =?utf-8?B?eFdiZlMwdW9EcEJCRXU4SnJvZGdnZXRsajhSeFU1K3NjZVpZMmhFS0pXT3J1?=
 =?utf-8?B?UndKVHkvNzU5UVpRQzdUR2J1THAwMjJ1cXNLNkFzYitJbnk4RGhJNDczR0p6?=
 =?utf-8?B?ODlQVkVWV2xycDUwR2xmTkJQc0xNWVNIVW9kSU94TVhvdWhrTVRSeFRacnlT?=
 =?utf-8?B?VzZFZkp2RHpKY1R2QjE2M2xWaVZ2djBHRWMzejUyWlYxaXRVRlJFVjgvS2dV?=
 =?utf-8?B?QzN5MFgyekRhYk9rNURVNk5udzl2bEdsQmZiYUNDQnpWQldqZWRHTWcxZ2R3?=
 =?utf-8?B?bXJrcklQV2dpdUk4dktrbmYwSEFDQVlsc2JTNysva1VmRVhaUnV1MXJuQktm?=
 =?utf-8?B?bE1VMGQ0R2tLKzl0Sk9BNEFrNTlMaW5XUHE1a2dJOHpyczdPdnJsdGw3dUhm?=
 =?utf-8?B?SVB1a2tQSVFtamZUSEloVGNlOWxzZmZzMjIvdWsrZmxFWVpkU1JyYW5TV096?=
 =?utf-8?B?clFQc3RXa20zNmdYZ2F3bUFWWktxV1QyODM0aFlVUzRvK0NFeE1FT3F2Wk55?=
 =?utf-8?B?cWVlV1kwbGtFdUoyNGJHMUxPaGxQYjFLc2dhZjdjWllKbm5aYyswZzh1bkMy?=
 =?utf-8?B?ZEpYeThOKzlkczJzWTR0UzhpQ0xCUmxja2JVRFZ5UkFBSFk0SlRCVThZQ2pK?=
 =?utf-8?B?SFhmSTBseGo2VUwxWlVISzdpMFJNY1QxVXMvanZES1lNVFZ6VEhGbzdvWUht?=
 =?utf-8?B?ZXZYVWIxd25FQkIrdmY1SngwellvWml6L0hHWm93Rmw5T0d2V2x4SkEvVkli?=
 =?utf-8?B?Y3RtQ0ZrZXhRSU51dU04ZzNoTiswVnltTS9nbisyVEVLWi9WeVJGQkxNdllR?=
 =?utf-8?B?cjg3T3gvbDRDMTUrUFZ1ZmtBMnljTUJUUkpRbmxIQW8xRndQQU1UUDdMU3o2?=
 =?utf-8?B?UUhtUHJpQ2t2ZnN6L0lXQXB6d2FrTGRCWHVlb0cwZURoRm54SVhjWWMyOGZC?=
 =?utf-8?B?VjQ2VE9VNnRKQktjSnFUdzVKcE42RWF6aWozNU9QUTVuY1lHblc2NjhDNWhv?=
 =?utf-8?B?aVFvTW5Oa091WDJwSHhFVUFWaGd2ZHJKTUk4K0VQQ1pyU0VSQmZuYXQxaUQ4?=
 =?utf-8?B?RjI0ejJPdnJaam5GdjhuYURLNHNiNXFzZkVUOW1zMlFEWXpQQURRcktTK2RT?=
 =?utf-8?B?UGtXWklMRnJ1cExyRm5JRzNmb1gveXhBYTl6Y1RSa1FoeDNLVXU4UkNmY0s4?=
 =?utf-8?B?SlNHVlhkOE01di93TkJwaVdTbjNIZGVzalBUR2p3MDdmM1R1MmVLdkN4ZzBG?=
 =?utf-8?B?SFl2YngwNW9UcG1Wc0IwcXluSjJwRWVyMnpzTTBEUHhPeFoxaEQrRExuMnBR?=
 =?utf-8?B?NDZIOFNvK2hNQzN1NTVDMlFnbU1ZMTUzYXEwTUVzWElOZmlMTHlkNTRYQVNa?=
 =?utf-8?B?empqU1gvdFlSNGlyZWNjNHhoVE9od3VIaUgvbHZJbEtvMUVzOXFjekVMdjI4?=
 =?utf-8?B?NllwZkZ2VzZGTlJlVmdOdkZLcW1OUUxQelZlbmcrZGJmQmdhU2M0cmFKN1ZY?=
 =?utf-8?B?Q0lsdjN4R3psYUNCdVVxR0hUWTJyZUdSQlFYaExSR1pUWkV5THZmU3FjOFNF?=
 =?utf-8?B?OVpYcncvd0ZPczRVb2dJbDBKZzZKWjFhcEJPMTQrYktsdnVTTi9iY3dtS0ZK?=
 =?utf-8?B?L1VhOHJ6OWRBdjBlQ2MzQjVXbEZzY1VaaWhJbFdaYi8xRHJFZUZmNGlBQWdH?=
 =?utf-8?B?RDJuQ3FUWXN4aW9YT1NyMkxrK3NSVUUvQUlsMDAvdDU5RURFMEpkbVdObHUw?=
 =?utf-8?B?OERwMS92cVJ3UThYL3lOQlJBM3pUdDlpSGtFOUpyZFFGSHAzUUxPZXgwaytq?=
 =?utf-8?B?WUpjc3UvZkk0WnR4ajNlZHMrV2l0NjBtY0htS1BVWmxqRnNvcUlDMFc0d2No?=
 =?utf-8?Q?WPrzoCZaeEI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmZ4V3haVnBIclNjcHFJMG84MXhjdStWOTB4MllQSTA4bDRUQVhUeXB4aDhK?=
 =?utf-8?B?bVE0dFBnQloxWE1HbDlTTktYTUc4VnFtN01kUmZwT1lTbkNzOGN0SXoyVXBW?=
 =?utf-8?B?N2pvdEFjRXl4aW9FMUpjVDVpVVpPN1ZpbmhWNnR6KzFvNll6bzdSd21WZlRp?=
 =?utf-8?B?M0JIQ1lDZitzbUZncWs1eFN6SyswM0xmN3pyMWlCOUtZOUZxYUhsRThNeXBO?=
 =?utf-8?B?NGZjQ25oMTFhdVVSVk4wYThJMVJDZDFwb0VHOXpodFFzSnBlcGI4VHFTVXp2?=
 =?utf-8?B?aVdzSFFvL1ZQYi8zQzRaWHNDakQ3b1FDZWZUN2F5cU1jVFFpcTk1Z2c0bFc5?=
 =?utf-8?B?RkJEbzUzRXk4OC92NDRXaldSV3ZRYUNCeDhXRUxZTHoydS96YU4rdjlyK0FO?=
 =?utf-8?B?OEVSVGJwYllOTVFYUEsrY2V2R0djWnk4ckVXZGJVdVNXeEtwTFAzVWg1TW9o?=
 =?utf-8?B?OUZmSHJqUlVNaVhnZllMQjdWTktjaHpmM3FVTnBXUDAxU2hkWTZDd3FyOEJF?=
 =?utf-8?B?REI3Zm5Wbm5yR0tUczE0ai81d1packNJYXlxa0dVZnMrVjFDaEdnTFdGR3oy?=
 =?utf-8?B?UVhoNFVRZ2pRaVlnU0QvallhUGdGdUlvUEJoNThaTmJvMnZnT2pXV1J4RUs5?=
 =?utf-8?B?OHgyTmpmYjdCTmJtK1FMcXJ6OFgrWXJUNXIrSHpRdXVYZ2Q5RUo0LzhSNkJO?=
 =?utf-8?B?SklGWmZKNXJNMEFMTEF5YmxMZjEzc2RYUGRtUjJFWmJvaGY3Wk9KVlFhRkZL?=
 =?utf-8?B?Zjk2K3JMOXUxNk9qUCtvZllRaVJrZTk2SmZuU3N6UVMxcGMzVE40U3MzUE8y?=
 =?utf-8?B?WkVxd1VvMllpQ0UwMlkvSmhYOFFKZlNPQVd3N1dYN2dvQzZqUXgvRGRIUWph?=
 =?utf-8?B?eFJiK1o1KzFES3l3ZzA1QlAvbjhsQmp2TWdqbmVpK0M5Wmg1cGlYdyt0OXlZ?=
 =?utf-8?B?dFZjSUxVV21GVGpySXVpNmp2Q1JmbW5nWkJ1TEhEREN0ZGw4dElCemNleStB?=
 =?utf-8?B?cm41bGsvSm9CY3pDalZJYjJuK3RRb1hKYmszMUVlcmRlR21KOGZUNWdsb0No?=
 =?utf-8?B?djRWZldxbXBLNXJXNHQzdHUvZlVjT3VoU2JZcnN6eHErdm9zdWFvY3p5a2gx?=
 =?utf-8?B?RXNBU0xodjk1MDllVncrUW9KYVlLbFNaUWtOQXh0Q2Nac3BSUFpyRjlRY0Zt?=
 =?utf-8?B?WE9GczZpREVuUFBZdklxRmxaWTNVN0NCVlRxY1F1b3JjSGFYV2IwWFZ6TE5R?=
 =?utf-8?B?RzN4YURlT044QUpkdDhZbVF3eEJkbUdEK0VGdlpXdnQvcno1K0ROVW8wQTNr?=
 =?utf-8?B?VjR3TjdwSWFtOFBwWncyYmZSSWhwSnEvMkkrZEpsczZFb0R1QmRNYjh3TzJG?=
 =?utf-8?B?K1hBL0E4WGM3NiszS2VuaGx2QzNab3lieU5mWHFHdUFMSU4vOHFyUWZlMzBG?=
 =?utf-8?B?UTNzRzhyT3NLK3F4OFV1NGVqUDhEaGZKTFFJV1ljMGQ4L1o3K0R1UTU4bXB2?=
 =?utf-8?B?cGxJWVNoR04vRFZ0dG0xaUs0WFpZZFE3MG9lTWE0bzF0bmhZanhqcW52R3Nn?=
 =?utf-8?B?Und4RmRtSjVFZkNTdWVhNTRXRU5aVUx1OXdadThFWEdjQ0hTWGE5Z1dhbWVh?=
 =?utf-8?B?MS9pUXBIQm5uVlBGSWJpeFpxWncxMFl0NTlCK2pVSXZYeVd1cGdpb2ZhYUtV?=
 =?utf-8?B?REtNYkphMUFXNWsrNkw1dmNJVktTaVJEQVpSaC82YW5KT0hvV3puSVM3TFlX?=
 =?utf-8?B?Y09BSkNSS2hmbzk4Y21yYzErSVdiNnVZK3RadXIzcUkzcDk2VmZpemJpUEVn?=
 =?utf-8?B?SExwWEIvSWRscU9DSXZjeDdRVnoyQWNyVmIrS2Q5VmYxRlpWMStZQlJhTzhL?=
 =?utf-8?B?eXVOYWpURmJOVEl2bGxGb2ZLNTBSSFVBSXRWWlR0b3B3cG8xNDQ5eGhMUjZN?=
 =?utf-8?B?RWVMeW5WSmFTbURiL2xNU3hicTcxRmgzZUw4NXZwRG4ySFo2UnB2U2FYcjFu?=
 =?utf-8?B?eUNZMFV6WHdzNDNLQkx5V3pzWWNqbThkYVZ5ME5hVnIvTHNRVHNrdTFoMkM4?=
 =?utf-8?B?ZXJrV3MvMFl2MndzZ0hTeXBmYUpBNllHaVo0NmFTMjJwWWRRSURQV21ValpD?=
 =?utf-8?Q?G3gTyJngiPAN7b2QPw0tChP9e?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a0175e-ac24-4a91-65ba-08ddb7a6b235
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 07:21:14.1196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2neP2SHJmQy16lG8T1FlAtWTV/Z5oJMAYqwkHleI+jlCLJcnhf85sU40reCUn+Vz4ZvfyNybBEFehITIXUyfEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFB985F6192

Hi,
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> to, 2025-06-26 kello 12:19 +0800, Yang Li kirjoitti:
>> Hi Pauli,
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hi,
>>>
>>> ke, 2025-06-25 kello 13:24 +0800, Yang Li kirjoitti:
>>>
>>> [clip]
>>>> When music is paused on the pixel 9 phone, the CIS link gets
>>>> disconnected. As the transport state changes from ACTIVE to IDLE, the
>>>> stream state transitions from config to qos.
>>>>
>>>>      > HCI Event: Disconnect Complete (0x05) plen 4           #1425 [hci0]
>>>> 49.572089
>>>>              Status: Success (0x00)
>>>>              Handle: 512 Address: 6A:AB:51:47:3B:80 (Resolvable)
>>>>                Identity type: Random (0x01)
>>>>                Identity: E8:D5:2B:59:57:A6 (Static)
>>>>              Reason: Remote User Terminated Connection (0x13)
>>>>      bluetoothd[2313]: src/shared/bap.c:stream_io_disconnected() stream
>>>> 0x1f9fc20 io disconnected
>>>>      bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream
>>>> 0x1f9fc20 dir 0x01: releasing -> config
>>>>      bluetoothd[2313]: src/shared/bap.c:stream_notify() stream 0x1f9fc20
>>>> state 1
>>>>      bluetoothd[2313]: profiles/audio/transport.c:bap_state_changed()
>>>> stream 0x1f9fc20: releasing(6) -> config(1)
>>>>      bluetoothd[2313]:
>>>> profiles/audio/transport.c:transport_update_playing()
>>>> /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 State=TRANSPORT_STATE_ACTIVE
>>>> Playing=0
>>>>      bluetoothd[2313]:
>>>> profiles/audio/transport.c:media_transport_remove_owner() Transport
>>>> /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 Owner :1.1
>>>>      bluetoothd[2313]: profiles/audio/transport.c:media_owner_free() Owner
>>>> :1.1
>>>>      bluetoothd[2313]:
>>>> profiles/audio/transport.c:media_transport_suspend() Transport
>>>> /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 Owner
>>>>      bluetoothd[2313]: profiles/audio/transport.c:transport_set_state()
>>>> State changed /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1:
>>>> TRANSPORT_STATE_ACTIVE -> TRANSPORT_STATE_IDLE
>>>>      bluetoothd[2313]: src/shared/bap.c:stream_disable() stream 0x1f9fc20
>>> AFAICS the bug appears to be:
>>>
>>> - bap.c:stream_disable() should do nothing if stream is
>>>     not ENABLING or STREAMING
>>>
>>> since it's called from bt_bap_stream_disable() which is called on
>>> transport suspend which should be noop for BAP server if stream is
>>> already gone.
>> Following your suggestion, I updated the |stream_disable()| function,
>> which successfully resolved the issue.
>>
>> --- a/src/shared/bap.c
>> +++ b/src/shared/bap.c
>> @@ -2059,7 +2059,9 @@ static uint8_t stream_disable(struct bt_bap_stream
>> *stream, struct iovec *rsp)
>>           /* Sink can autonomously transit to QOS while source needs to go to
>>            * Disabling until BT_ASCS_STOP is received.
>>            */
>> -       if (stream->ep->dir == BT_BAP_SINK)
>> +       if (stream->ep->dir == BT_BAP_SINK &&
>> +          (stream->ep->state == BT_ASCS_ASE_STATE_ENABLING ||
>> +           stream->ep->state == BT_ASCS_ASE_STATE_STREAMING))
>>                   stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
> Same applies to BT_BAP_SOURCE too. Only the check on top of function
> needs change.


Will do.

I will submit a new patch to address the ASE state issue.

>>>>      bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream
>>>> 0x1f9fc20 dir 0x01: config -> qos
>>>>      ATTbluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 51 #1426
>>>> [hci0] 49.585656
>>>>          ATT: Handle Value Notification (0x1b) len 46
>>>>            Handle: 0x007b Type: Sink ASE (0x2bc4)
>>>>              Data[44]:
>>>> 01010002050a00204e00409c00204e00409c0006000000001302010302020105030300000003042800020501
>>>>                ASE ID: 1
>>>>                State: Codec Configured (0x01)
>>>>                Framing: Unframed PDUs supported (0x00)
>>>>                PHY: 0x02
>>>>                LE 2M PHY preffered (0x02)
>>>>                RTN: 5
>>>>                Max Transport Latency: 10
>>>>                Presentation Delay Min: 20000 us
>>>>      ...
>>>>      bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 24 #1427 [hci0]
>>>> 49.585725
>>>>          ATT: Handle Value Notification (0x1b) len 19
>>>>            Handle: 0x007b Type: Sink ASE (0x2bc4)
>>>>              Data[17]: 0102010010270000025000050a00204e00
>>>>                ASE ID: 1
>>>>                State: QoS Configured (0x02)
>>>>                CIG ID: 0x01
>>>>                CIS ID: 0x00
>>>>      ...
>>>>
>>>> when playback resumes on the phone, it attempts to set the ASE state to
>>>> Codec. However, since the stream has already transitioned from config to
>>>> qos, the phone ends up disconnecting the connection.
>>>>
>>>>      bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 12  #1433 [hci0]
>>>> 60.216004
>>>>          ATT: Handle Value Notification (0x1b) len 7
>>>>            Handle: 0x0087 Type: ASE Control Point (0x2bc6)
>>>>              Data[5]: 0101010000
>>>>                Opcode: Codec Configuration (0x01)
>>>>                Number of ASE(s): 1
>>>>                ASE: #0
>>>>                ASE ID: 0x01
>>>>                ASE Response Code: Success (0x00)
>>>>                ASE Response Reason: None (0x00)
>>>>      bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 51 #1434 [hci0]
>>>> 60.226086
>>>>          ATT: Handle Value Notification (0x1b) len 46
>>>>            Handle: 0x007b Type: Sink ASE (0x2bc4)
>>>>              Data[44]:
>>>> 01010002050a00204e00409c00204e00409c0006000000001302010302020105030300000003042800020501
>>>>                ASE ID: 1
>>>>                State: Codec Configured (0x01)
>>>>                Framing: Unframed PDUs supported (0x00)
>>>>                PHY: 0x02
>>>>                LE 2M PHY preffered (0x02)
>>>>                RTN: 5
>>>>                Max Transport Latency: 10
>>>>                Presentation Delay Min: 20000 us
>>>>                Presentation Delay Max: 40000 us
>>>>                Preferred Presentation Delay Min: 20000 us
>>>>                Preferred Presentation Delay Max: 40000 us
>>>>                Codec: LC3 (0x06)
>>>>                Codec Specific Configuration: #0: len 0x02 type 0x01
>>>>                  Sampling Frequency: 16 Khz (0x03)
>>>>                Codec Specific Configuration: #1: len 0x02 type 0x02
>>>>                  Frame Duration: 10 ms (0x01)
>>>>                Codec Specific Configuration: #2: len 0x05 type 0x03
>>>>               Location: 0x00000003
>>>>                  Front Left (0x00000001)
>>>>                  Front Right (0x00000002)
>>>>                Codec Specific Configuration: #3: len 0x03 type 0x04
>>>>                  Frame Length: 40 (0x0028)
>>>>                Codec Specific Configuration: #4: len 0x02 type 0x05
>>>>                  Frame Blocks per SDU: 1 (0x01)
>>>>
>>>>      ...
>>>>
>>>>      > HCI Event: Disconnect Complete (0x05) plen 4           #1445 [hci0]
>>>> 63.651497
>>>>            Status: Success (0x00)
>>>>            Handle: 16 Address: 6A:AB:51:47:3B:80 (Resolvable)
>>>>              Identity type: Random (0x01)
>>>>              Identity: E8:D5:2B:59:57:A6 (Static)
>>>>            Reason: Remote User Terminated Connection (0x13)
>>>>
>>>> Introducing a check in the stream logic to distinguish between Unicast
>>>> and Broadcast would indeed make it easier to handle different stream
>>>> types cleanly.
>>>> However, if we temporarily ignore Unicast caching, a simpler and cleaner
>>>> approach would be to transition the stream directly to IDLE when I/O is
>>>> disconnected.
>>> This disconnect callback is used for all the roles: unicast client,
>>> unicast server, broadcast. All of those require different handling, so
>>> it's probably most clear to split it.
>>>
>>>
>>> For unicast server:
>>>
>>> The behavior has to follow BAP v1.0.2 Sec. 5.6.8 and ASCS Table 3.2.
>>> Transition to IDLE is only allowed from RELEASING --- but one can as
>>> well go to CONFIG like it is in current master.
>>>
>>> CIS loss from STREAMING should go to QOS, and I think it currently does
>>> so, via bap_stream_set_io.
>>>
>>>   From a brief look, the current version in master is maybe OK, although
>>> one could test the above case again with stream_disable() fix.
>>>
>>>
>>> For unicast client:
>>>
>>> The current version in master is probably OK, although one could double
>>> check it again.
>>
>> I've added type checking and made the following modifications. Please
>> check if this meets the requirements. I believe that unicast source and
>> broadcast source are active behaviors, so there's no need to change the
>> stream state through I/O status.
> Please don't change the unicast behavior, unless you are fixing a
> deviation from the specification, or can explicitly show there is no
> change in behavior.
>
> I understand this patch is about fixing the behavior on BIS loss.

OK, for this revision I only added the handling for BT_BAP_BCAST_SINK.

@@ -6584,6 +6586,11 @@ static bool stream_io_disconnected(struct io *io, 
void *user_data)

         DBG(stream->bap, "stream %p io disconnected", stream);

+       if (stream->lpac->type == BT_BAP_BCAST_SINK) {
+               stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
+               return false;
+       }
+
         if (stream->ep->state == BT_ASCS_ASE_STATE_RELEASING)
                 stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);

>> @@ -6584,10 +6584,15 @@ static bool stream_io_disconnected(struct io
>> *io, void *user_data)
>>
>>           DBG(stream->bap, "stream %p io disconnected", stream);
>>
>> -       if (stream->ep->state == BT_ASCS_ASE_STATE_RELEASING)
>> +       if (stream->lpac->type == BT_BAP_SINK &&
>> +           bt_bap_stream_get_state(stream) ==
>> BT_ASCS_ASE_STATE_RELEASING) {
>>                   stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
>> +               bt_bap_stream_set_io(stream, -1);
>> +       }
>> +
>> +       if (stream->lpac->type == BT_BAP_BCAST_SINK)
>> +               stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
>>
>> -       bt_bap_stream_set_io(stream, -1);
> This doesn't look right vs. unicast server. What performs the
> transitions to IDLE/CONFIG/QOS for unicast Source? See BAP Sec 5.6.7
> and 5.6.8.


I got it.

>>           return false;
>>    }
>>
>>>> Once the Unicast caching issue is properly resolved, we can revisit and
>>>> introduce stream-type-based handling accordingly.
>>>>
>>>>>> +       stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
>>>>>>
>>>>>> -       bt_bap_stream_set_io(stream, -1);
>>>>>>            return false;
>>>>>>     }
>>>>>>
>>>>>>
>>>>>> ---
>>>>>> base-commit: ae1b7f6ba805f82742bbc32ff275e268248ef9f8
>>>>>> change-id: 20250624-bap_for_big_sync_lost-63476c679dbb
>>>>>>
>>>>>> Best regards,
>>>>>> --
>>>>>> Yang Li <yang.li@amlogic.com>
>>>>>>
>>>>>>
>>>>>>
>>>>> --
>>>>> Luiz Augusto von Dentz
>>> --
>>> Pauli Virtanen
