Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020137.outbound.protection.outlook.com [52.101.46.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68132D7D5
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059763; cv=fail; b=a4ZZIu5S1yjopw8e47ArNWcj8FoV0YT60C/6kKz3eUsWJky6Odtq13UIbdLzM8vQ8yxXhzPrHjiGQ1UMkFDeQPqURzs5NLO/QWLt7S23yjkZL86pgd1jzbpeRXucd5gdiNOC1S1JOLCeGoy7qo3+M4HexrJpSENS1XnH8I21ur0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059763; c=relaxed/simple;
	bh=dbOcnya+IpldqTSuuMo7O/9ZwTrEmxIOoDKy4SZbNTs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ch9hQY5GZGiXvc2cLnWYZNRg9ASMXeSjzvQx+egjWgPPNMMWYSnXwAhEOXt2cSYRqJPC/Me429rbqKLs9eg7Cg98IFrXIilXhhyLDCoO67zoJNJu+pm2VRVaL+9gMhWt3HJHxFVVOzJ/ht2njHRh4/Usdq1kHWMKT+YRY9NF1iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com; spf=pass smtp.mailfrom=roku.com; dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b=s/W/7gr7; arc=fail smtp.client-ip=52.101.46.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roku.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b="s/W/7gr7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9lgqsIJovR8ynkLjgS63wcstQpSKITYQ+7qkYtqXAuopdvyPvXiHi5ObK7PmzXmxLIOnz8WkJ/JfSFi0QIEUfcRZpYmETIkDUKBnycm69q0uXVH6ypggHAnwfv89dIVDylykMJ1DKVOI9ITpY/sFdHz6ytNkuoePx9AmwV9HFhi8qCxTG/v+GArKRI1FakMul8CHjssOvllyITveucoPk1cmZ3BxSlFzvrU+E+jimU70OOXvft8XBdoRW3L/jF05sTzn/F/LpKyqqLAUgWET2vxJVozVHoQc6Bt/YRNXSHYwC76MLV0DgdyNFkFYYal6en9w8T/A/pBF+YwEFEhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWa4zk79VNkU0s1RE0EVoAEm5RlHsL9NZ4k+iX66iT0=;
 b=EzCUC7+KwlMpB2ZRdKFSIur0RtvmlRHrgxbQ2e4AaG6qEuZTC7NEeFJ+pM7CV9xv3ZTTK9jO5W7z9M+iUUDE3yem2FEXkiSm0Nwbw5WBXF82htMXAw3ZJUdco1rIWGt7M8AGWOWBoCwadvCU2EWDtpq9pgzCG3XvL5Tr50+O+DYFMe9ijuD1aX2x3mY/HygQu6TdEWnEmvfzO+BNfCm7zUjQgDoHnOd9QtqlBkDHHtttbocrgUqMsg3GZkl+IYkAGlaY337f99RTyCfyIhy3ZWBPVUXPCNLG0GN86qNV2a2DaEOSSprKS/1+CLJwXsKwqt0seWCIKqJHBMs2gnFXTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWa4zk79VNkU0s1RE0EVoAEm5RlHsL9NZ4k+iX66iT0=;
 b=s/W/7gr7BRJBU4zhffE3BqO948qgQIFVoP2hlBXIbUfEkiHT79xn9ODrdUHQgF496n1vQJrvWgo37jYdGmnCwkbRUZgzS4UU3DX/2F8k53Lz6mAMK1bG8iQJcqocmmYPcS3Mvea/sSpNitQOM57wpfn4ejJKvH5vx1zpCJEHr6XQvc/iHDejMWT4nZ4Yh+3e64UTDliBrkeLCzQncIg7m1s08KjkxX+F7UTYKIi/NLjUHqqkDSlJ/j98WnOD7ZgUwsQQC+JRr26tuNh1h/JoPfuS2PHeeWdjB/4W26ySDnIKaFi6qSoWZBCtkoQfu2iIsiMkJ9D5hWJq6zRPNgEQ8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from SJ2PR01MB8282.prod.exchangelabs.com (2603:10b6:a03:540::13) by
 DS0PR01MB7889.prod.exchangelabs.com (2603:10b6:8:143::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Thu, 18 Dec 2025 12:09:19 +0000
Received: from SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f]) by SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f%7]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 12:09:19 +0000
From: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
Subject: [PATCH] Bluetooth: mgmt: Fix TLV parameter code type conversion
Date: Thu, 18 Dec 2025 13:08:26 +0100
Message-ID: <20251218120826.533081-1-ssorensen@roku.com>
X-Mailer: git-send-email 2.52.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::19) To SJ2PR01MB8282.prod.exchangelabs.com
 (2603:10b6:a03:540::13)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8282:EE_|DS0PR01MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b50977-0c0a-49b4-e86c-08de3e2e459f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEYvZGtTbDlrOGdMeUU0b1VvUHoyZ0lWSW9qM25FYUNwTVRDUmtVS2FzdHM3?=
 =?utf-8?B?TmlWS1MwQ1p0K1BkZTNOc2tJakJpbytPNGVUZ2xUNHFaYVhSK2RhS3VDWXVz?=
 =?utf-8?B?Z2Z3Qjk0dlV3TDBHSTcwOWp0bTVmQXdjYWNoZnQ5bEY3WGR6NnFHOUxEU1Ex?=
 =?utf-8?B?SEttdEtSWjNiUTcrbis4Q3RxU1N4dzYvL2VjVlVZMXZCWkJ3U0VUTmRKc0M4?=
 =?utf-8?B?aU9ORm1ldkRaenpyOWxUeGtHc0phZlVxeE1KNUVxRTRPcmNyalp5NXl6Z2Zk?=
 =?utf-8?B?OG05RDRFNExUSitYSXpGTDdEc0dTSDJKT1NqZTUvSkRPYkRGOWVRZzhONTRO?=
 =?utf-8?B?c2ZRWTVPRTBITGs2WEZlZHJsRmw3RXZidkM1ZXJRZE16ZEZPcnpoRGduWC8w?=
 =?utf-8?B?WVk5elpnUVQvc0NhcW9EVlQ5UENtVzVCRG5FWE5kTktMMzJLMW9QNldQUW1J?=
 =?utf-8?B?TlVvWnkrVEZFaG9Ha3dIZ0h0Q3pLMzZYTitBcTJsV1p0UFpDWUFHbW5DREQ0?=
 =?utf-8?B?MUhXUTFRUnViNlR2R0l6K2RxVHUzQnNDV2thSU5JbklkZHRIaHo5V2FYSlM2?=
 =?utf-8?B?eFJVdXh6eTZKNmdZWUdZU3FQdVhZeU5VSTQ4WTFmMEc3MFpSb0ptWGJwRXFM?=
 =?utf-8?B?VTU5VHc3cFpxckdzK0gyaDYycHZib3d5N1ZVUVFRd2tSL0VRZWVYdzRIVUpY?=
 =?utf-8?B?MFNFZjBzd3JncVRxbEtFSXY2TmJHelJHcWtQREI3dytTWVpoOHRQTG9ZNVBo?=
 =?utf-8?B?QWdsaHFlTUF4Z01HcFVWQUxVVDRXR0RSMklQV0ZZZ1hlOEl0N0U3YUpRMHVS?=
 =?utf-8?B?Nk0va2ljb1dDUUlRblVqVlBBWHJsbjRBTkwwMG9pU2VTV0ZIUk1xcUc0ODBG?=
 =?utf-8?B?RzlvQ2NYUmlsNWZtZEZTZFFITUZPdHJTZHdXandEUDBUVG9aZFNjOW1kSmtx?=
 =?utf-8?B?VjdlZEF4WmgvVDBJQjJ0MjQrOWM0a1lOSStyT1J5OXExZFdzYUx4WDYvSWt3?=
 =?utf-8?B?clZxV3hyRUozQXNxdWN4NDlZNlRNNkNSMzhtYVlGMGhrS3RBY2RoT1liQVVD?=
 =?utf-8?B?cHZhU3NhN0lmR00xck1MNjBaRzd6YytFYlIxQzUwTTU2S0w4VjRZSHI0ZkQv?=
 =?utf-8?B?ZlZrQjdPTTV6MGNvZTFsSjFzUEZ4Zng2OVYwTm5XZE81NStJRnNKVWlXYkk3?=
 =?utf-8?B?Tk44c0VmVmd2eUJNcUN1Z01GYmpIN2FJRlJMZDVCaGxleTJpWUw5ZHZYeGxZ?=
 =?utf-8?B?VlJvRUxaQkRHYkk2QWNIeXVLWmdSTzhQRHVMdzNwd2NLYmZ0MGU1Vk5NMFlm?=
 =?utf-8?B?SDJlNUYvbmlDdXZLbDZ1UitYbGNyV0p1dXo2bjJTOXFIb01KVGMwampJRHBY?=
 =?utf-8?B?QlBCYXhVck5WQWlkVGZzN2JTN3BDUDh5TDdwZWt6aXRLT0FZaE9zRGtramly?=
 =?utf-8?B?T3huVUpDWkI4dW92eEVoMjFZb1lYblQ0VTBJUnU1ZEl0djZJcEtUQXlPcUQ0?=
 =?utf-8?B?RWlZK0ZNTTJ2NmpEUXhhOEp4MVVCR01KbVRzTUdFdk92eW5GUVF5TWNEeFNj?=
 =?utf-8?B?elVyYUtaWHM1ZlZFekovcHhWTWcvbHVzMXNMMTNBSUtFK0QrZGVYSUtmRmtm?=
 =?utf-8?B?N1FFT3VKR3hNR2tlNzZZSXRmTTF5R0hiWWt5a3ZjRmExZWVrZkFudjlvNmhV?=
 =?utf-8?B?b1JqaEhLazlyMUpFU1RESHI1c0dPVCtpRjE5MFRLQXZDaE0wbVZEZ2F6Qld2?=
 =?utf-8?B?KzRGY0w2d3RKM1F6VTdweTV2dllxRkg1dmV2NVV4NGV6NzhaY2wvMExhTzBp?=
 =?utf-8?B?Rzlrd2xYUk14d3ZDWVpRMklNS2NtcmphTFdCZzNMUTVoUHRpQjg4SHNWVUt5?=
 =?utf-8?B?QVhnM2NhV1BRTnVidDEvZ2xNb3lGK0JxRkZ0QkNYbE13aEd1N1VCZkcvUCtO?=
 =?utf-8?Q?jYEwHVx04T928CkMZKV+WJRVo/S29aaE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0lZWEZxMCtsQmN4RWZtejQxUEZscUJkZldFZjFDUjVCeXpSSStoWmtVRXVB?=
 =?utf-8?B?NjFST2traTMrMWN6L1dSUkVsM25WL0JkTEc3bE8zemZLa0xINVlvVGMwa2NM?=
 =?utf-8?B?ZlpyeHpZdUk2WTArS1ErSDZPWGJCSlVGN3l4N0taRWxmSkJJVEE4WHFxa1FB?=
 =?utf-8?B?YTdYTkhsVnBOTzJzdFovbFp4SmIyY0ZSd2h4ZUZzTDNtcklpUTZ2eU8vODF3?=
 =?utf-8?B?T2RRV24wb2g5Mkljck5BMDFhV2NiYWU4NTJhekNnYVBHNk5GTnlGZm1zdTNH?=
 =?utf-8?B?MVdSa2t2U0Jkd1EyVFVHZHZXRVhhSDJzT1BkSTRzM0JSaXpQMVpNUGhPdjB6?=
 =?utf-8?B?bHpheElRTlR3QlNzQTUrejRWanZEWXBGNVg3QUlLdGc3VjBJQVVBZUtzTm82?=
 =?utf-8?B?aDRSM3lta0EyM29RN0ZWK0tUTU85T2Y1QS9rc0ltZ3JPRUNWYVRnVFcwbnJt?=
 =?utf-8?B?eWYwS29NLzVXMXFZQXhhb1gvQ0I1eEhxUkdUUzlZWDlGOHplRWo3cFcxc2JN?=
 =?utf-8?B?Z0kvc1NVNGJKZUhlQ0hFSWVhQWF0N1o1eFkwbCtpYUlUd21JNjJjYUVXVUdP?=
 =?utf-8?B?ZmJxS2k3RnJqYnhsdENhN04vYm9PR255Q0JqSXo0SlhVVEh5dklIaHFSVUJo?=
 =?utf-8?B?aXMrS0g0WHRXVGE4ajdjKzZyclBLTUJWcnhUTnltS1BHRXEzYmVEd2JhRWZL?=
 =?utf-8?B?ejNQdWZFNy9qSW9PdTNLYVZRSEtmYzRJVFJtdEFLcFRqK0hVa2ZJNmdHTExI?=
 =?utf-8?B?MEhlVVBqdW8zUHJNeXdEWTQvWHk3b3NzSUlPbmZpQ2NzZ3FlMGprVXJlV1B1?=
 =?utf-8?B?dmlSazFTOTF2bnRsbUtXeFQrVTBOR0w1WG5yejFnVCs4cUpZRFFJU2ZhQk1W?=
 =?utf-8?B?eVRnQStaaG9XNXhNb1dwNzZ4TmNoMG5YcXZJQ1I1eG1vcFRRZFRPWGhzd3V6?=
 =?utf-8?B?N2pHZWJtNkg3OEp0eSt2Zi9LcFcxYXBnZ3dKMk01Z1RqbTlqa1UzNzI4Vlcw?=
 =?utf-8?B?clo1NVg4akpjYmQraUVuTFEyVE9xU2VOeVN2ek54UEo1dk0zL1NSZkQ4bVRp?=
 =?utf-8?B?eWo1MytpS2VWdFMyQWg0cnpoRm0xbTRwK0RoRUZkUStGT1JTRVphUmEzTE9M?=
 =?utf-8?B?Z2FqdDBxL3hWZEtpenBLR1JiU1AxL2hUbjRaZXNUSmhyZ0syc3JUYkZPUUNa?=
 =?utf-8?B?NkIyUVNtR0VGcWRlQ2t1bFgrd3IvLzN1ME1KNVRrU3FZR1NnZFhJalBMWXhM?=
 =?utf-8?B?em8yK3NwNXVNRnlkVU8yQmlIQ2lFaHBuZ2pvSDhZZy8rcVJmc29EaWFWTXVO?=
 =?utf-8?B?NjA3TFIvTVR6TEkzbXF5TmRQZjVWeHRGeTA0ODREa01rY0hDVFdvajVvVGIr?=
 =?utf-8?B?ajhZekdQVmJEMHF2SWg0S3MwQjAwazZHVXp5MnVid0Vzdm5zbTRPbkg2MFJz?=
 =?utf-8?B?Z2V3a3d6bEJTWlhTUm4rZjNoK3RCYStSbGZPNlpTNFlicHU0VXdmekdsNWxw?=
 =?utf-8?B?T2Vrc0ZadHJPOTBzeWR3YXgrMlZqOXV3V1pKVFBYU0JDakNRWE10VjkvQk14?=
 =?utf-8?B?QkYwbmRKRlVXKzZTRHVtL25OVi9ySUdnWStaSUlCWlBrQTZNcjUvWW0xcTlL?=
 =?utf-8?B?ZlgvcnpXWnZtdmhHc1Zac2I3RE9CcE5yYnFSTG9rMEFSRlVMc1RSUldwWlFM?=
 =?utf-8?B?WWpLNlhGMHJBQ0dMbTdhSnF5SjZJd0oxdzQrRHhuSU9TeXVkZ3djZnJhTWEw?=
 =?utf-8?B?M0FSdllFQmlqbk9GQ1pTaGpqQjFQOXd2YVhSMGZ1QjNiSGFmWlo1dDlKZnQ3?=
 =?utf-8?B?UzlFbUJCekt3TkhXT1lUSDJLOFpWNnF1a0x1TEZvQjJQVzRNR28rdkY4VVdC?=
 =?utf-8?B?a1lsbjBhRDh1MzFDTjJTTVdrRzVwY3dVS3VlMXc5L01yRVZ5SmtFZXBOOUlz?=
 =?utf-8?B?SXdrKzhiZU1PaEFyVnNrTHpoSnFUd3pld04xTE1nM3VrWWc5UmZ1U3QxMnNG?=
 =?utf-8?B?bVJQaDY5RmMwL2l5SnNNVkFpL0REOVlabFRrV2dZU0VqMUltcDY3S2t5UVpi?=
 =?utf-8?B?N0FuNG8wanJFUzNFSWUralhnNWtadGtuQlN6Y3R6VW5JZloyaGszR1JvYmhO?=
 =?utf-8?Q?KFaWrRiIEmvV4/YSteSXfvdRJ?=
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b50977-0c0a-49b4-e86c-08de3e2e459f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 12:09:19.5748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHcXpou17ppWpSLs7RK8SJNwubfYsJyUJcQtLlV3Up6OyjYOX1VviiYMzx9heU8nu7eSSh/ZQcq2Rt+zSrI2qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB7889

Use the correct le16 conversion for the TLV type field when adding a
TLV using a u32 data field.

Fixes: afa20d8099ddf ("Bluetooth: mgmt: Add idle_timeout to configurable system parameters")
Signed-off-by: Stefan Sørensen <ssorensen@roku.com>
---
 net/bluetooth/mgmt_config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index 4ec6c008cb7e6..fdcc752c6f13f 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -37,7 +37,7 @@
 
 #define TLV_SET_U32(_param_code_, _param_name_) \
 	{ \
-		{ cpu_to_le32(_param_code_), sizeof(__u32) }, \
+		{ cpu_to_le16(_param_code_), sizeof(__u32) }, \
 		cpu_to_le32(hdev->_param_name_) \
 	}
 
-- 
2.52.0

