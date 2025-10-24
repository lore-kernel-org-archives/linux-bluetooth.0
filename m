Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023085.outbound.protection.outlook.com [52.101.127.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF954202960;
	Fri, 24 Oct 2025 03:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761277676; cv=fail; b=P3sNmJKzKMzRKqj0Mc7rz4rQ0LPJWjKIB9umVKvBkjwT+F58xvP6e9AzlEB4h/d4pdHxcgBZldkwcYCBDkEqHP13MORlnAdMXtUlQ7MUdt35bM3G5T6pfqH6Ri2t04NMVxoO0jjEcbhWnU3uu34jqAT2SkBsPNx7aA+ny4bw3ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761277676; c=relaxed/simple;
	bh=QL60jpDSwwA/qNepRarSSQ4nLRurALwUFKYgIQjbI7A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iP+bzWzdX6AvFlSuVThtjgzL3ypF7r0OlVHWdvSpkA0ry8RA2gDlpPq63Ov29RiJrrToVrHKUDVKViEpf+Uoo84zPVOPQ2AoeJLzYaUowONOKhuf69UGlmG+MZM+C255FV1LBxQuMx6ugT05GmWyyYYHlYgSyWFpsky6HxWWYb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=xYfS3h0t; arc=fail smtp.client-ip=52.101.127.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="xYfS3h0t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LI6QEyLZg9E6UnY2rs2L3ALnZRIUeEu+iM41jvXTFLXljbODagY/Q4927JaqAtY9WmtkPYFJoaMVx3jP0DNlkZRWUhgajofx3crPZnmEKzwIrKAHwmGGdmIhxz3T9haT6cCfgFsGxeBn6ZL3hq7NNexFikBYxr23vGHF21OuCKRebro1TYIveqQsSVUG8otvQVFJuOn8m+sHOkjq3AHuNLug2R8T9wYla8vytZj838plWgMk9Ury0YjvPvhaBEqqQoSLnEGCgA4Ij89/FWnYQhe/ABrN/XPlSQsDfHgT13tD7XZXBsadbYkk2Lqs+3+TLX7rvCi1ILshMbG/TtiTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVJnUrokxcbT/DOVmWFLqKvjfmNrWkzCJwFzv+H7Lcw=;
 b=Af9YKrH6+VkHcUjBOlDGHsSa8xN097n0+SWwhM3U8zFPpQoKjSBKYkBgNEyBMZZXpBV5ae2AspSb2i1KpdnyyxDkrdksKXGwYzvMzMRV7Dfkbt5ndiodkOqFtkuUYbqFSascARUk7+6bNHpjX780r8Oly4PSpcudwueuW2NWDDvMMZxQ8bfWCQNDD1Kg7aKyfwQnAx/Xd2ippTUZXH+pMVzpRSk6vi5KHRnBCzYX1qNk/xxqWVK44t7YVHo6iLWsVWCZR1a6srOKMiiua+5tPMXirSTnpYEK01DU9lcmSrwvpIY7kE3ldvpL41S3VSgaekKDZjlYsP9rHGLlxat58g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVJnUrokxcbT/DOVmWFLqKvjfmNrWkzCJwFzv+H7Lcw=;
 b=xYfS3h0tPJl/5mthRpwkhndVXgCjiwLSRgxulF3rWZd6BX1krMjRbYQr41JmQGzv9zYc9CRD6YNxqDleC5SXYc2X+ujQRxOVT8hF8BiyMUYI4G0nJ4bl1oE4eNVocEWVSd50G7jVhwGE1nHsMpVtYLr04rbGN8vFZ6fhMUqgmgD+HbCKNTqmNWxvUTR9ujp0X3tD8dadu0DCCAtAycIy3z54xMo5dr+u3zYIv1MH1figsfQp/S41f9Z+agc7PSQyPknCRGYINlWJKJFyfus1UmVLuxYVE2gWuanN0bqCbQ/4sC0cmc4+EKllLrMXbaFj1EFEPPVS1L1AtzSSHQLD/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEZPR03MB7898.apcprd03.prod.outlook.com (2603:1096:101:182::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 03:47:49 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 03:47:49 +0000
Message-ID: <44d4423f-e557-4506-966a-7abebca7680a@amlogic.com>
Date: Fri, 24 Oct 2025 11:47:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: iso: fix socket matching ambiguity between
 BIS and CIS
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250731-bis_cis_coexist-v3-1-1f9bd60ef712@amlogic.com>
 <CABBYNZJu3izq6ZhNRKjMz-mW1CcP2VAE7Xs5oq=NupnVD7aayg@mail.gmail.com>
 <4e0b2df6-1139-49df-b03b-a2f31925d52f@amlogic.com>
 <CABBYNZ+buYOXaBST-bCyzDWtWihMOoXGaoNzp6+kowKgo+-6=w@mail.gmail.com>
 <5874e307-fa81-4baf-b270-478128d30412@amlogic.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <5874e307-fa81-4baf-b270-478128d30412@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEZPR03MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c652107-961e-4fdc-801c-08de12b01991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDNFNXZlNHJ4UDVRbjUxVUNUYlhWVkV6NWQvQ2JZaUNKNVVmcVpsRy9QN0ZE?=
 =?utf-8?B?anJ6Z01MbDVtcE5OMERhRysrQWJSNytGeFppdUxjL3pqMyttalcwZXg3WnRC?=
 =?utf-8?B?RXFiQThSZWlBUUVnOVlhb3hpMUo5TS9DT3NJUCt4NVdyVldWakpVZnB6eVRG?=
 =?utf-8?B?bTdSNDBsa21vNHU3eXdLRzlzNjBSSTMzM2QyS0h2V3RUSjlJUUkyNXU5NWl4?=
 =?utf-8?B?SlFGRDZDazZnNWtqeElyY2JpNktiZE5wMjZtVEUvK280dFR4YVhKdTdjdjR3?=
 =?utf-8?B?Smp1bEptQ1d5aEV4M3VlSFAzNGV0WXpWTEtZWHlVRi9Cb09jZXhEYVNsazdj?=
 =?utf-8?B?eEhvajNKSHpVNWhuMllaVkk5N0VzclhaT0RZc3JXMkNodjEzZjNmclo1UzU5?=
 =?utf-8?B?NExMT3gyWStaeUdNRU1OSmI5L3VWR0ZHRFBzU25ROXZFbDBDTG1MZkpUSDhr?=
 =?utf-8?B?aUpmRU0zQ2RVc05NcWlsRFNISktxQ3pEd04zVGFzVDdKT1FhVnA4Tmo1d25x?=
 =?utf-8?B?TWJFMkgza0xFai9pUHN5N1FjSWlYNTZDNTY5UEF0dzZjajNLS1Z1dXlLaEpz?=
 =?utf-8?B?cU9EZXJsMWVsZml3M2Q5QXhpZ1R2OWdDQ3BGdWJOWE9Fbm1pZ2RaQnIyZklk?=
 =?utf-8?B?cEQ4YmM4a0orRGNRZi9VUG5FSStCTU9Xd1pTS0lXdS9XUlIzeC9PVkVleHlR?=
 =?utf-8?B?bkJUbDNiQTVZWkpGK20yaFZWeFZQZldJbVo0U2p3MjdBNGVOaDAwVGFqanoz?=
 =?utf-8?B?T1hHeFA1ZmVaRDFPR1lRRnd2aXUyY21nYkVBMDRPWk5Tb200TDZaNmdJR3RD?=
 =?utf-8?B?ai9KSk9iNi9xV3hNV2hmUmVuWWRwYjFvVnNxZ2M4SDlIeVZoRGI4dTJQODhF?=
 =?utf-8?B?eFV2cWZNTEw1WW9CWEpiNldoeDlnN3pubVdTU2ZsVGZJUit6OTA2bDh5NXBh?=
 =?utf-8?B?WmhxRGhtTlZzRFlwdmg4bXo2aVI5TFpXbDhJc0p0enhwMmJrVE8xemVJRWhS?=
 =?utf-8?B?T3BoMlZWK1BFbTRXbE4xWUtuc2xCQjdMS2dOd3J2ZS9sVDQ1N2pickRjNURa?=
 =?utf-8?B?aHUrMWZyeHhRSnY0TndyV2hjb3pvdC80MlFoVFlHY01MV090dm9Db0duZkFU?=
 =?utf-8?B?elpXemtYeWl3SVNnYzQyNE5hekZEZ2hCcGptOWVCRlpyWnBwRzNwbm03bDIv?=
 =?utf-8?B?citmSzdadUFmQ0VvQ1pRSkY1TFp6SjNNOXc2WlFzcFF0NmE3enFTaEpQaEQ5?=
 =?utf-8?B?blRxRHVUblhHdURPdUtuN3pZR2h4Rno3WW1XM2xhUGpXWEJEblJEdkJDWkxW?=
 =?utf-8?B?a0dDRTB1YjhDK2xLQVFOMmRyempYWVJFaU5UakI1Z0xDdTFBV1VHODByMzcx?=
 =?utf-8?B?VWJNZXZnSTBLYmVvSlRCMGxka09nbVdkd2E4dlpZVGxmNzlyNytpaEpMOVNi?=
 =?utf-8?B?eWNaZU9KcHg0NW9LRXlOYUJMa2k2YnZ1bFhWRzg1OXB0S2hnWnBVSVB2QUx3?=
 =?utf-8?B?QzNFaDBod05qK1l3NG5sUjA2UWJST3QvZlhEdmozSDBHODUwOUhVWW5rcy8w?=
 =?utf-8?B?ZHM4RmEzejZDdkJuZWxnZ2I1aFhDRzl6N3BhQnlVRWhQRlFYOUZUQXFMclU1?=
 =?utf-8?B?K1h4bHM4R2NjcWpZbUdUV3BpUHFEU096ckNaVVNvbFBtRlNRcEt5Z0s0VDlq?=
 =?utf-8?B?R1BiRGNoMk9uL1ZqNE52cU9NRGhoSWg5Yzl5d2dWdVBuMWhFdDFWbjJqUndG?=
 =?utf-8?B?ejk3N2dhcCtNV1ZTT04xczAwN3lmbmdsR20yV2xvRC8xdHFMTWs5T0Jtcnhw?=
 =?utf-8?B?Mnhra29WUU5jZnk0Z1hTYTBXRExGZUJ1TG04L1JFdTJLbDNoU3FKWitoSC9Z?=
 =?utf-8?B?MVAxa2RHNUllY3RrbVRBbE9rTmNUcjR3YmR5aFdJUytUOHdFR3hKWGJGRU1h?=
 =?utf-8?B?UWlpZ2t5SDNFUVRUeEtIcEhZRnZicEw5R2swMEViS3NadUI3aWtZeEhTamZv?=
 =?utf-8?B?bDAza3U5NGxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3BEWmQrZ3J5S0ZtWWljWUJNeFBvTCtOMVUyckIzeFZXNmVzL3pkdzdqQUVT?=
 =?utf-8?B?cjVuQitJb2lKNUFSNWNPZkR3bDlqc2lQbGFaWDJkWVQ1RFl6dnlNZktnL0Q3?=
 =?utf-8?B?SFkvMHIvSDAwS1ZXTnpJbnhiMkgvZ2EyU1RjN1FidzRhVVRZQVNpS2toanY5?=
 =?utf-8?B?dG5tMGFYTWQ3OHp5VTJJSDU4MEpvTys5L3A1UzFUdDRramZObmR6TGhNRUpz?=
 =?utf-8?B?aklWeGR4bjA2eG4wbzQ2RDczbk5SZlhuQ3RKSVVhZW0vWGZ6VmlpZVZtMHB0?=
 =?utf-8?B?Q0pXZ0grcGgvRVh1dGtqKy9lT29UaFlMMHRDTVZQUS9ib29tbGNqdzBCUDlo?=
 =?utf-8?B?RGlNOWVzTkw4cnpCRnNyNmZZWFR0ejRLb0VxR2JJUm0xVEhmaXU1eVZaZm5Q?=
 =?utf-8?B?VkVTYkJ1OURyWEVESnJqcEp4U01CV3pEWW16emdlYktPWldnaytwUXBUSWFS?=
 =?utf-8?B?bFU0L0hmRGRDLzQvNVB1L1hnN1ptMWxBZlROZFF5WVZGbHVjZHlmdDJOSFlI?=
 =?utf-8?B?aVZtTEQ1ZHFPSnhYTXZkRFZZUjJQRGJaUVJCakJBTGh5RjZsM0JzalJJaTdq?=
 =?utf-8?B?OFg0NHhmWjNGQkRCT2hWdTFxZ0YwZDc1MUd0OFR2UnpOdyt0OUg5UUZIV2JH?=
 =?utf-8?B?ZjJCQ1NOV21VeDAyWXkvQ1dRclcyYW9JZGgvUlBMUFBXTkM4WFNNVUN0bHZT?=
 =?utf-8?B?VVg2OVhMajNSSVY1V3VBTHdhQzJPaUJQckN5Vm9QOXM5OFFFMkV2SEZyYXFU?=
 =?utf-8?B?NnhEcXJnUjdvcm9iajhwOEVNM2dEK29wWnhFRXdHNnowdERaMnduL1o3RnNx?=
 =?utf-8?B?bFRBOFFiM0x2emdzN2prcEZZV0FlS1BIQ0V4T3RrbmNtR2FRbitzUDNlRHo1?=
 =?utf-8?B?ODJxcDlMSWxnbUsvejY4Y0ZCTUZLWldQYjQ0UTdNYm5TK1J0SG5heGFhZEd3?=
 =?utf-8?B?Vkc3N1V1Y08zOXBVTmV0RWY4ZzE5MFoxQUJ1eVgrelZFRDFvejFhRVB6Qi94?=
 =?utf-8?B?dzZzZXorUVNpR3hxenVHZGhtWTBrdGxXTVZ4SGF4b3NYdG9rb0RsVkdqZkVH?=
 =?utf-8?B?YlBzaWNFRnFRMlllaTdlYkF0bUxWWHNxa3oyeHZVWmVDZThrbCtqam5FNk5q?=
 =?utf-8?B?Z2RoNzFtZG9Tb2hjcGplZmhyZkJaYk9yZG1Zelk1WE1CdllueHFPRkZZckY3?=
 =?utf-8?B?V1p6eUFzWE4zZHFIejhwQUZ5Z2dKR3UzdlNxWVE4V2tEck84ZjJnWHlyc3lw?=
 =?utf-8?B?OXRvWVJ4OGk2Q0VqT0RTOXJDVlRCcC9vY3BtUGJLKzNqM2YwaUljM2tqalA4?=
 =?utf-8?B?QUFxUHpUdVlPemVyWnlnM3NkanZzQ1gvT2I1L2RGYlRPUmRUbEVFNDJRR0hO?=
 =?utf-8?B?YTdQMy8xN1h0MTd6OE96MTV6VjlRQ2phQmJqcmpENHhBWFZMMUwzelJPcmNi?=
 =?utf-8?B?SGNLMkxyWmhmTFNOZkpsOHNpNDEwZzBQVnR6YWVIYTJzVTNXQWg4T2h3YXRF?=
 =?utf-8?B?MjFmN3lYem5YbjRkZnc4WGZTb2FMZHgxcys2bDczYUc1VWQrWXhDbEJmRmJh?=
 =?utf-8?B?MEJsaXFYdHVDMXZoRmFab0dPTFpHN1NjMStMVzQwRUR4VXlBQlc1VWw5Tkl5?=
 =?utf-8?B?RFBnOHhhMUJaRkE0VnFaWml0SVNEWDArdFE0YU1TSzJzVkQ1VndEaVFHdjFN?=
 =?utf-8?B?WWJWWURORmh4bFRnSDhvOW44RzZGUkVpUWFDekhlbndpVEJoS1cwK1c5YW53?=
 =?utf-8?B?aklYVzNydldtajhtd0ZoQ2syL1VOelp2MVR3aGU1a0dyWk5qVitUWCs5OHZ6?=
 =?utf-8?B?a2dxYzhrZWR2d3hteU5yWU5kbWowWXdzQ3JZQ2lBcmNPWTE4T2NLdFkrRk1Q?=
 =?utf-8?B?V2JhZlRraUc2Tlh1aC9YREIvNVZrZDlvWS9lYW1pekpUcWZCd2pmUCtmZFlI?=
 =?utf-8?B?YUo1K3NMYm1FMElTYnNKR1RJOUxUQ3VHQ3JOa0tMdHIxQ0pIcnlCR0t1TXE0?=
 =?utf-8?B?R1pXNXNVYlFPbnZ1OWhUNDcxOXJpOEExQlJhdXdFZzJOR3ZXTFRxVXZRMjdF?=
 =?utf-8?B?UThWaHJlb1BtS2Rxb0ZxYUFqWEM2NW4wSGRoa2RFUTVvMHZUdXpuL2xFUUN2?=
 =?utf-8?Q?dbH2zqMVr8nuQl2QAeOBHxVzi?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c652107-961e-4fdc-801c-08de12b01991
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 03:47:48.7136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOmzUzCypn+ALC0gnJYDuOZYXZJCvsLk4b+4s73RxhXqKPk4ZcaEmprmMaeYIGM+BvtXpujkmFnNs/XLYb4Atg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7898

Hi Luiz,
A gentle ping, thanks.

> Hi Luiz,
>> [ EXTERNAL EMAIL ]
>>
>> Hi Yang,
>>
>> On Sun, Aug 3, 2025 at 9:07 PM Yang Li <yang.li@amlogic.com> wrote:
>>> Hi Luiz,
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> Hi Yang,
>>>>
>>>> On Thu, Jul 31, 2025 at 4:00 AM Yang Li via B4 Relay
>>>> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>>>>> From: Yang Li <yang.li@amlogic.com>
>>>>>
>>>>> When both BIS and CIS links exist, their sockets are in
>>>>> the BT_LISTEN state.
>>>> We probably need to introduce tests to iso-test that setup both then
>>>> to avoid reintroducing the problem.
>>>
>>> Since the coexistence of BIS sink and CIS sink is determined by
>>> application-level logic, it may be difficult to reproduce this scenario
>>> using iso-test.
>> Looks like you haven't look at what iso-tester tools tests do, that is
>> not tight to bluetoothd, it directly operates at the socket layer so
>> we can create any scenario we want.
>
>
> Based on the current structure of iso-tester, it is not possible to 
> implement test cases where CIS and BIS listen simultaneously. There 
> are several issues:
>
> 1.
>
>    In struct iso_client_data, although both CIS and BIS related
>    elements are defined, they are mutually exclusive. CIS and BIS
>    cannot be used at the same time. For example, .bcast must explicitly
>    specify whether it is broadcast or unicast.
>
> 2.
>
>    The setup_listen_many function also identifies BIS or CIS through
>    .bcast.
>
> Therefore, if we want to add test cases for the coexistence of BIS and 
> CIS, the current data structure needs to be modified to completely 
> separate the elements for BIS and CIS.
>
>

I'm not sure if my understanding is fully correct, so I would appreciate 
any guidance or suggestions.

Based on my testing, this patch does fix the issue on my side.
Please let me know if there is anything I may have missed or if further 
changes are needed.


>>> Do you have any suggestions on how to simulate or test this case more
>>> effectively?
>>>
>>>>> dump sock:
>>>>>     sk 000000001977ef51 state 6
>>>>>     src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
>>>>>     sk 0000000031d28700 state 7
>>>>>     src 10:a5:62:31:05:cf dst00:00:00:00:00:00
>>>>>     sk 00000000613af00e state 4   # listen sock of bis
>>>>>     src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
>>>>>     sk 000000001710468c state 9
>>>>>     src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
>>>>>     sk 000000005d97dfde state 4   #listen sock of cis
>>>>>     src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
>>>>>
>>>>> To locate the CIS socket correctly, check both the BT_LISTEN
>>>>> state and whether dst addr is BDADDR_ANY.
>>>>>
>>>>> Link: https://github.com/bluez/bluez/issues/1224
>>>>>
>>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>>>> ---
>>>>>    net/bluetooth/iso.c | 9 +++++++--
>>>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
>>>>> index eaffd25570e3..9a4dea03af8c 100644
>>>>> --- a/net/bluetooth/iso.c
>>>>> +++ b/net/bluetooth/iso.c
>>>>> @@ -1919,6 +1919,11 @@ static bool iso_match_pa_sync_flag(struct 
>>>>> sock *sk, void *data)
>>>>>           return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
>>>>>    }
>>>>>
>>>>> +static bool iso_match_dst(struct sock *sk, void *data)
>>>>> +{
>>>>> +       return !bacmp(&iso_pi(sk)->dst, (bdaddr_t *)data);
>>>>> +}
>>>>> +
>>>>>    static void iso_conn_ready(struct iso_conn *conn)
>>>>>    {
>>>>>           struct sock *parent = NULL;
>>>>> @@ -1981,7 +1986,7 @@ static void iso_conn_ready(struct iso_conn 
>>>>> *conn)
>>>>>
>>>>>                   if (!parent)
>>>>>                           parent = iso_get_sock(&hcon->src, 
>>>>> BDADDR_ANY,
>>>>> -                                             BT_LISTEN, NULL, NULL);
>>>>> +                                             BT_LISTEN, 
>>>>> iso_match_dst, BDADDR_ANY);
>>>>>
>>>>>                   if (!parent)
>>>>>                           return;
>>>>> @@ -2220,7 +2225,7 @@ int iso_connect_ind(struct hci_dev *hdev, 
>>>>> bdaddr_t *bdaddr, __u8 *flags)
>>>>>                   }
>>>>>           } else {
>>>>>                   sk = iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
>>>>> -                                 BT_LISTEN, NULL, NULL);
>>>>> +                                 BT_LISTEN, iso_match_dst, 
>>>>> BDADDR_ANY);
>>>> Perhaps we should add helper function that wrap the iso_get_sock (e.g.
>>>> iso_get_sock_cis and iso_get_sock_bis) to make it clearer what is the
>>>> expected socket type, also if the hcon has been set perhaps that
>>>> should be matched as well with CIS_LINK/BIS_LINK, or perhaps we
>>>> introduce a socket type to differentiate since the use of the address
>>>> can make the logic a little confusing when the socket types are mixed
>>>> together.
>>>>
>>>> Now looking at the source code perhaps we can have a separate list for
>>>> cis and bis sockets instead of global iso_sk_list (e.g. cis_sk_list
>>>> and bis_sk_list), that way we don't need a type and there is no risk
>>>> of confusing the sockets since they would never be in the same list.
>>>
>>> Alright, I will give it a try.
>>>
>>>>>           }
>>>>>
>>>>>    done:
>>>>>
>>>>> ---
>>>>> base-commit: 9c533991fe15be60ad9f9a7629c25dbc5b09788d
>>>>> change-id: 20250731-bis_cis_coexist-717a442d5c42
>>>>>
>>>>> Best regards,
>>>>> -- 
>>>>> Yang Li <yang.li@amlogic.com>
>>>>>
>>>>>
>>>> -- 
>>>> Luiz Augusto von Dentz
>>
>>
>> -- 
>> Luiz Augusto von Dentz


