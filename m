Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022125.outbound.protection.outlook.com [52.101.126.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F2835BDDB
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470128; cv=fail; b=QPYedJkiW3vWyHnd2IrX8MP+wui2/UMCiN033DkzXyXsVV6g7/oW0HP2zMkAP78E/2HYa4M3n9r9zUA9SHfWFURIqVAldBH9uvpnz5QSgTud1JE04S2RdFywS2ugCMw7j2fUaxS9YzDrbVWZx+mphC4q9Vjcjrp8RagITZcw9Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470128; c=relaxed/simple;
	bh=xKm6FShErAnCuZN+oKj2PaB29jX7sRURrcGynDLSOH8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k7tn381/CNwGYYbJwmdo8n22geZiO6nLjsRoMdg+szmLCmjwjiqOz4q3Ot2ahZo+uP8q7qIiWGWQRTlATJqRuorLRdfPUDfv18ZAMLMauI4/Ty5TmRy9vUjAGmi1EYAbSWR2Zd1WKEu5EpBrROa1XZUALInEOIcjEAstwkTl0hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=zWkOrYKv; arc=fail smtp.client-ip=52.101.126.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="zWkOrYKv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKdMD7QMpyesF2VvTNpg/CsVX5N9tTy6pJIKCb4H4JNn8/bOYmzx2IdmEg21RjXdUyJPTSl8PcOwPTEiOLeq2qciEfDrlVYU3e4CcCAkxB1PyTvrH20jMoq533JM5XOV8K9HkIVk4lbvw9BNdTqRv8AaRQZ7zirz4rC+DxOvlfvwboyO3ZMU8FeOueG2ohapUIA86YhTuIZYdKdI75a0AMD/M3uV2oQS004q8b1dDi9DLAyyAnpq1RCBB6/jDF9n4xJYsi4zY3a6gq9XUCb9otFLImzYqjh6KxlYqcAamulyCzBzJu6MXoHrxVzmLW7pESa02SEBpNwu2bFqDIFEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2e3LnepHHLV4BSlZ2cM3bShsTrpk5iZuQXvFnzVVz5s=;
 b=zGxUKouG9AeEHSzi+MN4/JS5aVW6wqwo5APg/m17lKwtu0QkZZz/t6HAwkMdQBUKPxOeswlyvAB8bPk8ApHiQQ85Nis1MUh6dp0hlgQ5YKeZd/jGDmZkXupRb2/Qb1dOgzXTYtMNlqy8u/j0/RZhzV70RkD14TBK2hI1tODpfpQFvNqdO/nNFKLFBALiwmuqr1Fq2dSrLkf+KUH+/UxUUo+zqrcdC6mfCc8nTeY6pb2/jg80gP377CVkaZJ2SHEOmRTQbiBbIh8K9bdtgVwMLSprp968PdM+preAaBLe8MDhR45qyhmssO9UE6dq0Yvgv5Z+J2E1xmn5nabKz57+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2e3LnepHHLV4BSlZ2cM3bShsTrpk5iZuQXvFnzVVz5s=;
 b=zWkOrYKvfCQf3LjnMBYSJ0WwWgescmuT+2pM5kt9q1D5O1D3trI4BcFUY5+UrzfMULdHKZsK0YfLyFzDoqoiHBc2B6NyifqeNvrtqVIf9VSha7ccyTU00vb53LWOULvTSqBoYyCQ/kk6fA00iGAGrguRGbRn89k1cKN8NK9JQ9LfXEUn7q4GGiligKCu9pzzr8eRV3Ysi6UBbTWMTBVqGcnXVK5C9nBCyGEcmL93QQTbHUXk9x4p+Zc6+XsPE8W31INDFFWjDwXevvztUHtv0Hry0HjlRL2ahh08bghDi9ZzgmcZ7/lWr19qR8us4nN2M4EX1Ly1zfbGkb39KjB9gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by KL1PR03MB7454.apcprd03.prod.outlook.com (2603:1096:820:ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 09:42:04 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::eef5:1228:beac:be69]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::eef5:1228:beac:be69%5]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 09:42:02 +0000
Message-ID: <7a1da200-d909-4795-9f64-e7c86d53e0c0@amlogic.com>
Date: Thu, 15 Jan 2026 17:41:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ bluez] bap: reduce ISO sync timeout to 2s
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20260112-iso_sync_timeout-v1-1-9a3e99259a3f@amlogic.com>
 <CABBYNZ+xrCofAHqVOs4SDn3avXQenNbv4L-sys6_2Lf9PAXFOg@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZ+xrCofAHqVOs4SDn3avXQenNbv4L-sys6_2Lf9PAXFOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|KL1PR03MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 724f1560-4077-49dc-0dbe-08de541a55f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elFwaVRrVnRBTWFTQ0IwaXBwckFGZGlhZCs3OTdJUnVYbFJubzlIRTBmc1kx?=
 =?utf-8?B?Tng0UnBvb1JEbEhVSU5SdGV5eVA1UlRyd3pTYW9JL1NUOUZ1b2ZjK0pTNW9T?=
 =?utf-8?B?N3NLOE5JT1ZtQ25jekM2WjZMVFpwZk1rcUVHaHRLUGQ3MFZ4SXVhdzF2TlRo?=
 =?utf-8?B?VGYvMzA1cE53alNMZE1DNVNBc2lTTE5FbGJsR3Rhb1RjblMxVUNLOE42OWxj?=
 =?utf-8?B?TTV3NytyYWtYYkVVeXdSaHI5YnRibk83TUNsWGJwem9pb0didGxHQis4QjZ5?=
 =?utf-8?B?SUI5OEQzWExrSk9kSE5vZnJockRuajZuWk9lWjI2dUVhSjNya2NTdmc5NlhF?=
 =?utf-8?B?dXFucUpaeUMxanN4OW5ET1Z1alJUeFpKT3ZaUlhmbHRYVG1WQ2d0ekYyTzdC?=
 =?utf-8?B?ak8zSUpJUlFPYlJhZ2NmWkJBYWVJMTZWdmVyczZZT1poQ1FlZnJJMkxpVDU5?=
 =?utf-8?B?S01IWEhGOWordG9IK2lIZTJBRDY0WVBiTEtMUTFwaDFXWTF6aGkwTzNMb1RD?=
 =?utf-8?B?UzBwLytnelN1UGJVZmU2dndIVkc2R2pva0NPbUsvTXhyV1FZZWVBdUtMMUE1?=
 =?utf-8?B?TGhGODMwL013VzZLRzlsd3FsbTdkUDlvVjNaR29QWUx4bjQzZm0zc3FieTZH?=
 =?utf-8?B?UXpaK1gvUnk5RExHMFg2OXQ0QWE5ZitPc3FUTHFjOUpVb0REZlg0S3hDYzNB?=
 =?utf-8?B?RnpxUFQ0aHByTkR1MFZlc3BVUUljbGhDN0gyOVBLWnk3L2t1VGZnSUp5MGVL?=
 =?utf-8?B?alhiOGwxRHlmeGFCNkljbU90S0Vua0pFb08xRnY3dFRid0UrRm5JY3A0SkN6?=
 =?utf-8?B?Q1hrTzNoajB2UmNvNDNuN2VFR2JoL3IyYVVCZVVNWG5JVUNoSW42MndvTGJG?=
 =?utf-8?B?dnV0bDVidzc3bG94eGtaNyttaUZVYWJOUGhzT1VqMGZwWEpYRmxVU012ajV1?=
 =?utf-8?B?Nkh2dXMvOE5nb2w2d2k3aTBxVzJmNnhOVEZpSFpKcnBKQkcrclpzR2RqN1ZP?=
 =?utf-8?B?Wm9SY3pEcVFXekFFUmR4VzFtSk0vc2pGWE1VSFNta21YL1BJaWxzdjFydldk?=
 =?utf-8?B?ZCtCS0VKa0FXQ1JYeTVkbWNJUE9ycU1tSSsrRU1sTWZpQ2xyU0VsUFowQzll?=
 =?utf-8?B?WUcxK3N2Zk52UkZHd2M5cGRpc2pBZzBqaGM3VzZvU0tCL1NOQzNPa2pkRTd5?=
 =?utf-8?B?d1l3U09XbUh6dUJxSitHSFZKQzRZMXJIUjdvMUJqOElibnBFVi9uUEVrSW9x?=
 =?utf-8?B?ZVhBVk9FT3BqYTk5N3gvdGs1dk9kb0IxTHlkMEttMSs3WC9NZkNDczJKZVFj?=
 =?utf-8?B?N2FDeGhwZlYweFp6b25Md0hnckJjOXFKZVRWK3hYRk11eFM5Q1RBSjZTMk9J?=
 =?utf-8?B?aUllYm5ZNDFRYkU5Tmdxbk9zZ1RwZnJRS0VMS3N0Sm1pQ1R4YVRXNFhoNUpS?=
 =?utf-8?B?bUgrNUorcHl3NmF1TytLNlIrd21LdDN1eVd3TlNuUHZ4eFJaMkpLK0RKYlZ1?=
 =?utf-8?B?dnJ5UExOODVjZklBelZ3aUt1YTd0WHRIYk5VRkp6cmI4QWF2SGRJZG9WbVlu?=
 =?utf-8?B?ck9rME5ZMzNTdkd5VzZ2NXY3V3BITnNlZFNnbEtBbU4rYXltaHU0ZlRuK0Q2?=
 =?utf-8?B?b3lObldkVUpEWFFaSStqdkNYQXdoTXFGKzlrTXpGQ1dEU0U1SEFCdUt4cmdJ?=
 =?utf-8?B?bmZlcWZiUGxROU80Q1FaUHlrTnpsTTMyVDZGd2g0aXhucHpQcFRZVWswcUNv?=
 =?utf-8?B?QzhNbkxpdTBwd3VxVlZBdUV5cVNRNFllUGxCQUxJWENKMTArTU9iaDlUdDVx?=
 =?utf-8?B?OEFRNGN2WkxYWWU5TVc2a0ZySzhSS2ZQbnNZdmRmTVpranUvOUFJY0pzUTNp?=
 =?utf-8?B?U3RuanMvcVVXOVFNcjU1M1ZKM0V6SEgvV3MzMTZuNzBKYXhkNTZ4d0QwdlFt?=
 =?utf-8?B?K0xKSWkxaFQxRXByaHdkQjJtYTVqQ2RJKzFUekUybEVrWTdxd28vaFNqQUtH?=
 =?utf-8?B?UUNGRE9meFdOWG5reU94S0hvMnVzN2VzQVZUVitwTVlqNWJ1Qzd1TWZ0WGFl?=
 =?utf-8?B?SzR5a2NoUDAySUFicnFNeVBzdXI0TmRIbkFDNlpuUEE0dm5yQ3NhdEFRY21k?=
 =?utf-8?Q?RUik=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTkyL295L2YwcnA2bDdoZm1ETnhTKzMxMGVZeEszeVpWR292UU0ySEpxQUVq?=
 =?utf-8?B?QWtiQ3hyY1k5dW10K3dxbEN2U3Zsa2Z1Nm54bER4NTZBYWtkdXlvY01LM093?=
 =?utf-8?B?MXlpcGtSaTVtUnJNZ2lTZzArNUdLaE5mUGt4ZWNoVkNKQmtDUFA1aHczb2V0?=
 =?utf-8?B?YjRLNFN1N0tyVnNwcHhybVhtVG9CcThGOC9GdTFwaGU5OGhGT0Z2dmNJK3hM?=
 =?utf-8?B?QUVoWU9xZm9YZFZVMGx2SFc3T2ZHRllDQlZCRkVwcTBHd25qR2xJaHV6YSs2?=
 =?utf-8?B?UExJSWU1Ym5PYzNjT2E2aCtFR3NTU3NnQlpGdkRGcFQ4Yi9VNzNKY0VCTHcz?=
 =?utf-8?B?aXVNaFU3QlhEZWFGckdmTlUweCtSaE1zYXZNVXR3SVh3SnAyWlZmOTMvUktW?=
 =?utf-8?B?aHJnWGpxMFNsMVhZbVkyVFgxekRPY2RHUHlDZHo0Ny9SVXdFakZrbVZaWERZ?=
 =?utf-8?B?RmJpYk1yaVFRcFduU3dYSitEUitBbWNsMUFGenQrekpNcEZjR3lpUXhVUVd2?=
 =?utf-8?B?TWNia0pGMEI2M205QWhWS2N0dUV5MGJCUTB2c0hIYmRHY0w1djU5eFBSc21t?=
 =?utf-8?B?YlFaTkZqVC9JbVZWMzdwSGhlcitraDVGcHorMWtHMXBLbnk3RERqZ1gwekZa?=
 =?utf-8?B?bC9mS0F4bTJISkdvcEZaYUc2OEN1VGp0Zi9yQjQ0UDB2NnRXeVdoZjlMWTh2?=
 =?utf-8?B?NC9QQkJ1S05kejF0Yk1kKzMwOFA4ZUcrRk9tV29YR2JZb25FbDQ0SlJzSksr?=
 =?utf-8?B?c2k3YWVrMmhjZklrSHpUWVpmM2wzK0VNUXNQR3dIYWNmb3pOdm1Rb0xieEJp?=
 =?utf-8?B?eXBySVhPeXVOMzF5MjdwbHFhem5wdU5ybFZUZVNlRGJobExlcC9JaDZvMTFI?=
 =?utf-8?B?NHBxRm5vWGt3TXlEUHhlQ3kxaW9rMlhkUzE3NVp2ZkhseGpLTm1OU2p1azBC?=
 =?utf-8?B?eVZSc0ozNUwwdzErbDlRdUxGZk0rL0hjMENmV0hweS9nWTczUW03bGd2ZDdi?=
 =?utf-8?B?cW1nbVRsK0ZWN2MvR052cUxrSzRreGNrUmNiQ3ZxUjdoZTZWVFRXSFJzdUYy?=
 =?utf-8?B?Zml2MCsrQlZFVnJFNjNHcXk1ZTlwUG03dUZNcDB6S1NlTEdMRUt3V0dnRGsx?=
 =?utf-8?B?bU5aeUtBRW00NkNSbVpmeXFKMlBHZTF5UzUyVHJ1Y1MxUnJKUStCR2xQQWg4?=
 =?utf-8?B?Z2tzeElQYXVKeWdYUXY4eWJFeENhK2lOMERSZzBQQ09HUW5GaEJSVmREdWw2?=
 =?utf-8?B?cDl3cWE5SDFaRnFWNWJZRlp4WGJOY0NiejNuQXU3U3RpaXFuSnZWLy9XcmZk?=
 =?utf-8?B?R2lJOFNLSTIybFBMVG9UZEVLdzh2WXFTemc2MGp2VDh0QmM0V0lBZU4wTEp2?=
 =?utf-8?B?UGNhTWkzNXFvZVdzUU0zUkppSGdNeDR0WTVtanZZbjAvb0FONXR1a0tpTmhk?=
 =?utf-8?B?WFBtMnZGU1I4NlBZbVlmSFFja050MkZyTCs5YWIwcWdINnJCNVg0S21DeEJM?=
 =?utf-8?B?UE1Hd21wdXRLamcrL1dFd0M2ZUUzMnRRZ1F4OVJ1c1ZENHFuZzNVaWlLK2hX?=
 =?utf-8?B?VmN2TzhRR0F1Q0thVHNlTDV1UkorSUtoc2lqcU9STWdCblhaWFVJMkpMUThF?=
 =?utf-8?B?Z1hoS0pYTjVJYTJXYWJIMFdQcU1LcDVXNnNvNmdDRSs5cUtwOW5ETVRJcnVo?=
 =?utf-8?B?UVkzSFJoU0tDV2t6RjBOeDJVekVwS0VlQzArT3JIdzZDSkVRa2JWeloxdEZN?=
 =?utf-8?B?eVU1VE5oSUJ2VExBS2p4cS9BajRVVHNmRVZNNENyWGRER0dVR1RxVkxvUXkx?=
 =?utf-8?B?RmxWQ2daQ2xNSUxOYm51MGVlaGc5Si9adHIvOW9IQnpVNnhYUXRYVEtGQ2hz?=
 =?utf-8?B?NXRybEJLeHlqUmxMUFBib1plM214NnFrZzE0NC9aeEZqZkFwUGFqTVJXNlNE?=
 =?utf-8?B?eTNqU1VxZ01Pb3plTXFlcTNTKzBhTEtGTllPOHJHNGJjeFhYM2RkMWVPQ3Jz?=
 =?utf-8?B?UHJhMysvRmVwa2dESU1sL3pUY0lhUnZPb3B6MmxTeEt3K0xXZU41cjJKR2hE?=
 =?utf-8?B?aE84aWNKYUZySElJYnliUEduTWVrRk5TZkwvMHM5bUo4bmQ2UitNYW9FOW5Z?=
 =?utf-8?B?MWdJVnRQZWxkazNHcEVxdURMcS80N0REMlRtWkdlYUZpVTM2alIzWkx1ek1F?=
 =?utf-8?B?VFVIU05iTXhCV3IydkVHQWtZcjlVREQvLzJmalRpbTlmTHNCNnAyVGExVUpC?=
 =?utf-8?B?S1ZPLzJWa3lZQlQ2Um1VL25iRDNEUVE0cWM4MnREZUE2LytYQXNMSXpHUzJ2?=
 =?utf-8?B?UStVaG1QRE9mR3VHWXFjbXozUFRveU9GZzBHbDlmNHQzblozR0Zhdz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724f1560-4077-49dc-0dbe-08de541a55f4
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 09:42:02.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0bN/fiOFo4bj5bWChxoJqhkYnzMqZdFUgHLCU3vKTWt2tNmYgWa5rimzo9meUsP6ertqpIP/jZfbcInijA3QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7454

Hi Luiz,

> [ EXTERNAL EMAIL ]
>
> Hi Yang,
>
> On Mon, Jan 12, 2026 at 1:42 AM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> The ISO sync timeout was previously set to 20 seconds,
>> which is too long for PA sync. This could leave the userspace
>> flow pending for an extended period of time.
> I think we used 20 seconds based on the connection timeout, that said
> I do wonder if 2 seconds is going to be enough given that the
> advertisement window can be wider than that, specially when SID needs
> to be resolved.


Yes, the Core Specification defines a PA sync timeout when no PA reports 
are received for six consecutive PA intervals. In our testing across a 
wide range of devices, a PA sync timeout of around 3.6 seconds works well.

This assumes a PA interval of 500 ms, which is already a relatively 
large value. Taking into account six intervals plus the time needed to 
receive extended advertising during scanning, this timeout should cover 
most practical use cases.

I understand this is ultimately an empirical choice, and I am happy to 
adjust it based on feedback. From your experience, do you have a 
recommended timeout value?


>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   lib/bluetooth/bluetooth.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/bluetooth/bluetooth.h b/lib/bluetooth/bluetooth.h
>> index f9f22c3f7..572009e75 100644
>> --- a/lib/bluetooth/bluetooth.h
>> +++ b/lib/bluetooth/bluetooth.h
>> @@ -152,7 +152,7 @@ struct bt_voice {
>>   #define BT_ISO_QOS_BIG_UNSET   0xff
>>   #define BT_ISO_QOS_BIS_UNSET   0xff
>>
>> -#define BT_ISO_SYNC_TIMEOUT    0x07d0 /* 20 secs */
>> +#define BT_ISO_SYNC_TIMEOUT    0x00c8 /* 2 secs */
>>
>>   /* For an ISO Broadcaster, this value is used to compute
>>    * the desired Periodic Advertising Interval as a function
>>
>> ---
>> base-commit: a94f994201a69a36753abda65cc51937de9cd3e3
>> change-id: 20260112-iso_sync_timeout-8e3ecf43d82e
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
