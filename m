Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022077.outbound.protection.outlook.com [52.101.126.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244923958F
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750302763; cv=fail; b=eYJBujfXs5FaOWAOOWLp4ccgcjM/Pjt3j8kvCFoUpNTtwxmvzZIxaTltP/PsfMyVamYu+cgXWqoX7X/pfUZfv5Z0ikLfpifnJwkXUZ+TjnPfMWFgEOqIQVCxxC+2uu5NevGPj0Vfd5KIL2cxARCvQAl7KV98SxooFrbPV3cUk3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750302763; c=relaxed/simple;
	bh=GuocKRZOTulRnABG3wc/spIEC1WGVOmTVot7j0MqaXA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GzRgL8FgWSgaXuGubLW1xs2VkdD4Ie3I79B131wPdn9xCm+vNMeUq7JqsuVdjJ5Qi5FfNLAGN9V1so6OywdKRlg4xCvtsvMB4hEt9jejWmEV0tVpCdzlIrmSYfqKfrknXh/X5xEBHs7HSc8ZdkftR1ro6UdrQUe5BgeXYEYw4hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=E7QcEi7T; arc=fail smtp.client-ip=52.101.126.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="E7QcEi7T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOxB/RSnjma6C4I7hci1O6h7lEpkQ6tUkeLz91p5COcIDAoDy6YZ5NEQK+51DqRYGKkCJU2Zk4/zMFq7kSSZmBJroFP67MFMMKuImXiQf3TyyBqZThfvxzr/OULWKEg+poJgYolsafPX9FYhg+uXtt8fQNxnHcG3J8RGZAlF4n9OQZeTYTqhyEHg/uOa0pw1k9VWqXc/7qFeWAGSh3VZRC2W8TsEIet9vB+LasVyeegwk2gjIGaopczTjSRgALkCyZt5A4EjEBzjhNMs+uwGvXL+JTVcZxXNj34cHnaCsQsMk6vmOwKTpKUO2J+A5uSxLMiS+cMdD0UIgnVRbUGm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugaoFf108ZZJleiSaAQx5Gk6373KgrNgRcifdVF1VKk=;
 b=PY2Oo/MaXtVJu5a4KonjCK1Rmh1sa25e4KB5M8AfF0w9UDoM4D6K67BYG54+63PwttbMw3r0vLu8fcpHKM9q73/G1yx2i4dbG8sr53+26/Bxg5Kh3nJICNCUjw5JMzN2kskmt7Ro9e73bv3gg24XCFVaqXBclcQPLyw84tErgX37vts0NdGtFz0EQ+3xw+QbhD6RZR1vJJugwMeFwMs+0RIxlrhdolYp+cS9B9WXIAUCMtnOSw+W1ns6HKx/HzVDqnHHj+UV5OYZxorpmGwTRYVlqSdpadCNJXqHwD7FMnmq0sMRFxjPeonrqj6doZg387sAEYz+oC9Km0Kp+yq6sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugaoFf108ZZJleiSaAQx5Gk6373KgrNgRcifdVF1VKk=;
 b=E7QcEi7TXPGpcNkVI8lb//X5HuBxvXTFKZq3hdNwfdAv9A+k0jRTbObcvXA+2fBU4fVK5bb9/fejZ6XTA8qy7FzhF0ZWJY9xBJlJ7J/44Atojo9scp+1rcqFqm2q6ZX+uI/8SBu/5ppIYjb1dD57XqD0lAwH41BFvpUeTBbungmbnMvolUtQScaqX95R9MkOKl5JWE0g5AISgOzfD/SqkpcAeFyS2efN3tQoEoW+ijtWKi2tYf7SQwSSxeomC6mFtx5CkrFaRAQb/hzIcD/VqN2OdH+FEYe/p7t+XbqChYXuy9BIaKfqsyQS4CH3HLu+/UhCUagcWThh9IJXaOgOSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7311.apcprd03.prod.outlook.com (2603:1096:820:cc::11)
 by TYSPR03MB7370.apcprd03.prod.outlook.com (2603:1096:400:414::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Thu, 19 Jun
 2025 03:12:38 +0000
Received: from KL1PR03MB7311.apcprd03.prod.outlook.com
 ([fe80::68e7:f16a:544d:2ed3]) by KL1PR03MB7311.apcprd03.prod.outlook.com
 ([fe80::68e7:f16a:544d:2ed3%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 03:12:37 +0000
Message-ID: <22da8fc4-f5e2-453b-9b45-5697732e9494@amlogic.com>
Date: Thu, 19 Jun 2025 11:12:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bluez] device: Add bearer info to Connected/Disconnected
 signals
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bastien Nocera <hadess@hadess.net>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20250618-device-bearer-level-conn-state-v1-1-dca5df09c0bd@amlogic.com>
 <d57fedd0a0889309c217e9e145d302ba8a5bac83.camel@hadess.net>
 <CABBYNZKQVNJJ7iSV=wv3iEgP8RRtK1uD4M_KBr+Lpzu7nh9Ngw@mail.gmail.com>
Content-Language: en-US
From: Ye He <ye.he@amlogic.com>
In-Reply-To: <CABBYNZKQVNJJ7iSV=wv3iEgP8RRtK1uD4M_KBr+Lpzu7nh9Ngw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To KL1PR03MB7311.apcprd03.prod.outlook.com
 (2603:1096:820:cc::11)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7311:EE_|TYSPR03MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a4917f-c2ce-414a-4ee6-08ddaedf24ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE9xdnJoWTZaS1NWYi9jaFlVQ2tLZ0Z1NnFqQklMY2lzR2Y5ck5DRFBEMUhE?=
 =?utf-8?B?bHI0S0Qyam1RbGkwSjBTRzE0YlVWWkZWcURzNEIvb0hUM1ZkRkljRzNHVS9l?=
 =?utf-8?B?aEtqeGRMZ01KM0V0dUswbW9VaC9paU9MRTRIVnkvU3hnUWJTY3ZWNzlPUkpP?=
 =?utf-8?B?YUt3aWpaTmhMQ1lwK1ZQNHhKSWR4TXNtYlkzcU4wek1tbjcyZTgxQWwrU3lM?=
 =?utf-8?B?VFJOSEE5MnUybW5tY3dpdWVTYW1hbTFjbEhpU0JmTkFzV29iQVBXeVJDVmdz?=
 =?utf-8?B?TVdWMGlKM0tlQXR0bWJDS0E3VHNhS0R5SnFUVU1MZXc1ZjhkWXo4aml3c2lq?=
 =?utf-8?B?dzd4TWNvRzVNYjJXVzU5T0JGMmFPaVpJWGVKRVpCVW1DRndIbVYxbG5hSHFE?=
 =?utf-8?B?dGlpQWZsNmMwU3BnVzBXUU5CUUE1a3ZrdkNYbHBnQjgyZXRmUW94M25CR2o1?=
 =?utf-8?B?bXNnSExzL1FYaVlraE5wWEVYc3MwSXlGbWVSWE9BcnptRUlMK0tYMnBTWkZE?=
 =?utf-8?B?VHFiemdTcXNpTUIyS2gvSGd0MjJaZXphZmlwRGJoaHgycGZoN012a09ja0cv?=
 =?utf-8?B?M204RmJRVEhyY05XaXo5S050ZGFBSVdaeHA3L3o5TDZmUGVXZm1kN2RxclRS?=
 =?utf-8?B?d1U0Slg4amRkakdBdTVEU0pYVmppdGpSS2p2V3NnRUZ0a01hMnFuT0RMNktH?=
 =?utf-8?B?ci9uak5LcUpqdFh2NHlGRmlHVjNuNGJNY2t2dlVwbzlOV1lZSzJMRnBzZXd1?=
 =?utf-8?B?OU42ODByRzN1K3oyeHdwb1VWRTlwamZhSXJZRUk3ODFhbXNFUG0vZlU1clZF?=
 =?utf-8?B?bC9pMUhYajltaUNxWjFiQ1BNa1krN3dkaWhiTHYwTndGQVpZbUZYa0twanpi?=
 =?utf-8?B?QWZwQng5dkwvVGh4UHNOSTlzR3ZJV2tDR0VMQWJ0SHF1WHcrZGNyNUdZRVRn?=
 =?utf-8?B?K2VQbnZJcEJLcXVvK0VxQ1d0UC80QUxFb0ZkVzh5amIyKzNrY0xXdHdyU0xu?=
 =?utf-8?B?YXljb2wxVmhYUVF2MGhETC82QWQ5aVpXY2djZWg2aHJ4aVVQZGhsSkc5T05r?=
 =?utf-8?B?ejYxb3VkSEtaMTd5T1RGUG5MZWxxdlpqMTFMTDRzakk4NmRmTkI1em1DRmdL?=
 =?utf-8?B?WW14WVgrbFNmSzNQTmRqWXc2R1JINWpqQlBzNkVETUl0M0R2Yy92cXlBVDNJ?=
 =?utf-8?B?UW8wMXk2cXM0QTFjaGczS0FRY2JzR25ESmhRMzhJaU9lR1VJaHJiejA0WTNK?=
 =?utf-8?B?K0ZoQUZWLy8ydzNuTUJjcHowZWxBK3d4T1l4QSt5dTNnZGk3VEtpbzc1VndI?=
 =?utf-8?B?blg2U0hkTjJzV0ZVMmlwYVVkK3ZvNTcvWEZQMGUyNk5VMlpFL2ZKRFF2ZkZY?=
 =?utf-8?B?dERwUXNHTkxVb3Z2eUp4eFJHZlp0eTc2ajVZZlZhUG5ZOWFGK3hLekVyeVdK?=
 =?utf-8?B?YXRnQ3d1OGl6dHFtQlFyVGtuWnpudmZNQXg2bDV3Vi9la0RSWHRaYlFVUk9p?=
 =?utf-8?B?bGRFRnR5Tis1dDBsRm1aSUFJL0l3N2ZJckdMTnQ4eHRZdXpDTkJEUkplLzNy?=
 =?utf-8?B?NUF4S2tQMCs3OWFzNXNLcWg3WEtSQkpLZyt1LzYzQjJETGhwS2RoaG1UaXRO?=
 =?utf-8?B?Y2c5bGp6ejljYVkrV0Y1U0NSbktXL2V4Y2N2N21GNWR6WXc2Tm1TT25NTnZ2?=
 =?utf-8?B?d3I4enFMMzYrSGpPNWZtRTBpRjJ1T1JycHpuUy9ZOEJWT2VaTVlxNk5rdkV1?=
 =?utf-8?B?eG5HT0lkN3BwcVU5L2pRZ2k1TmpYVk5rWm03QUFjcHpqc0pxTHJiNDFTYkJl?=
 =?utf-8?B?TjhJcmtiN3hTOW9DRGwvdzN3UFR1MnZVaWNRUVNsN3J5eUlhTnJqSVZXNjJm?=
 =?utf-8?B?Syt6NEpmeW5lMlE0UTZmUVB2RzRHTS9CMTNsOU5qT2ttcjdMZ2pCNE83dS9F?=
 =?utf-8?Q?+HQuauAm0Hc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7311.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVd2NUV4Z21LajZGZnFPMlZBN1pLTm1VWnJNeTVzelFpZ3RHMzBQa1AzeVZz?=
 =?utf-8?B?OTJvVU40UDR6WE5kMkRGdDlaUWJiV3Y2SStUaFZ6ckxjL2FIRE9mWitTMVVs?=
 =?utf-8?B?eFVuWUgrdWlscEZmQi9TSzFXWkNVNmkxTHNvc2lsbGE0YXlvMitaRUxXWFNk?=
 =?utf-8?B?VWJLRXNRWDFCV3BTMWxMZFhRQWlZMFNjYUFyUlBxMmFaR0NIZE1sY3BXc1Jv?=
 =?utf-8?B?WjFUMTZob3M0M3VyZzQvR2ZBU2VyWngxSkt4S3JZb3NFY2VjRzB3MEJhcWtM?=
 =?utf-8?B?dC9hQ0MwTDBGTFE3bWJMQzFJSGVQWGdhN3llYXd6bkhoaHJrSTR2UWxib0ZO?=
 =?utf-8?B?UXZBTUhHTXRpWmZMVTNCR0kvcVYxNmxFcHFZRE54QjJ2R2VoZjIxVTloc3I3?=
 =?utf-8?B?dzJpTy84TFpZejZsSW5Ua01FbmVyemZsSmxFWGJoVitjWTF3YlZZV1NuNVhZ?=
 =?utf-8?B?blZyK0lwc0NreHhrUFZnbmhGU3FZRGVUeXF4YWRCblUrSkphZHZlMUdPTE12?=
 =?utf-8?B?Nk1WbXZPb2JFNm44WVpKelNKTjBuT2lIam9yenhFdDE2dUd2R0M0L1I4U2FK?=
 =?utf-8?B?ckJEc1hIdHFzTUpWaU9TQ2UvUGwreVF4WEZpV052SThSZ0Y5WlhTMHBhZFV5?=
 =?utf-8?B?VDAxMlJvNGZMWjFRSnIzTy9JVHdkdTlvMk50eTNIV0lsYkovTFpvbUIxM2JL?=
 =?utf-8?B?WndpSGpsejNuSGFDSU5oVitvZFZ3SWc2ZTFYNVYrNVJBN0dIQ1l4cEpIUTN1?=
 =?utf-8?B?ZW4wT0o2SHVualBOTnNJNVFjTEZYbDJGL3RDSERtVlJvdTV3ZzNJN204anll?=
 =?utf-8?B?S01ySGYzdDIxaTRsQXhKL2FRUExmM0hIcGJrc3RZcFBEb3dkNVkzZnMvVlRC?=
 =?utf-8?B?SURPTWNsME5odldpNmd6S2RFN01pRWhBRmdvcVRyWVJLOEdmaFprMlJhSmtO?=
 =?utf-8?B?ajIwNnJGdVpuU2xZWE5paElqUzQ1aEhMaHFNQTBMaXJWVEFzRzY1QWFkNmpZ?=
 =?utf-8?B?UFVVL3JnUm9JT2NaaXF6T0FzWkFqbEhWVnczRk8xRnlFUUl3MzBhdnBRSUgv?=
 =?utf-8?B?ZUtDcGhzaEZwUkJ3RUtjYzNRaWpUTnVLR21tWnI1cXl1MUh1WHlBTTZpVXZi?=
 =?utf-8?B?ejZQSFkzaGdYblJ5V1FQK1JzeDN5VG5McjI2Uks5bERXK1lsdWYxN24zdzlx?=
 =?utf-8?B?MWJCaEs0R2lXeFZtOFhvQnE2WUFYdWErVkovYm52eDV5ajNzRUh6UjNPUnBH?=
 =?utf-8?B?b2JHRExuTlU5RnB5a1ZtZHdVYncvSFg3V21hdVZhcWluU090amhIWFpxMkxv?=
 =?utf-8?B?Mnc2Q09TRFV2YjRCOTl5UU16bWY0UlhzV2xML2pOa3V0MGFxOGV5amUxcndL?=
 =?utf-8?B?RmpaWVpzc3dGYnhpWUFtbVgvMndhbnJhbCtPU2R4cWNqMTREY3BNZDd1cUpn?=
 =?utf-8?B?U1NiOGF5dUJxMWU3dU9oT3lhMlRpdURZdnROZElGQjZ2QVlYaDVRL0FreUF5?=
 =?utf-8?B?V3p2Z3FnVUg1Mzllc1hmazB2MTlPZmZFYWRWZ2E0cENTWm5vWUtPYWNIRWxw?=
 =?utf-8?B?MXRmYjNNK3FyZUU1RlB6MTNWY29PNktWMGw3NE9HVnRvU2Zqb3c5R1pqaXhT?=
 =?utf-8?B?R2wwU2dLbWMyR0p3aHAvK2J3SEVUSjVlYm96NFFJZW5ubkoyeE1LemJIbGg2?=
 =?utf-8?B?aEZFZkpzUXN2SFczaEhVNlNTakR0Q3M1Z2RWRm82b3RDUktEcEtGY2l3UTda?=
 =?utf-8?B?R1krQ2VaaExLd1B6U2FML3h0c0dZRUdpZkoxQzl0SGZubHdLWklsNXFZUCtq?=
 =?utf-8?B?M3poMGZkMGdPNmVmVDE1dm1lZk5scHBibENUN21kL0laREluTFo5VXJkMXpm?=
 =?utf-8?B?YWFqNjhwV0M3djJGK0RVZElITkJPbGRRV3k3MkUrbjJMTDVFL3NRVStJUTZy?=
 =?utf-8?B?am11VmRYaVVDWUM3THpEVlZpMXdFZG90OURPR0RudmN0L0ExcGIxZ3NNRE1B?=
 =?utf-8?B?WUxvRnB5Z3NxOVRnRVEvRVN2NWlkTUdrQXNsVndNRmF6a3VMS3czTjJBUkxo?=
 =?utf-8?B?aUcvRjZwRTlkT0ZWWkQ2eVVQWEZQR2Y3ZWhET0pJOTVCTnplaW1FYzBuOTV4?=
 =?utf-8?Q?/dylFjbcZZ+cgiGfkNr0fP51A?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a4917f-c2ce-414a-4ee6-08ddaedf24ac
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7311.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 03:12:37.3685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTYtvcup+tn7uJvCNjuaG6csIa7Ul6mMXt4y8bozteLmCo9/5JmYKMugx5XDqiga7PyO9Sb1iSB9QIi0isZfgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7370

Hi Luiz, Bastien
> [ EXTERNAL EMAIL ]
>
> Hi Bastien,
>
> On Wed, Jun 18, 2025 at 4:09 AM Bastien Nocera <hadess@hadess.net> wrote:
>> On Wed, 2025-06-18 at 10:39 +0800, Ye He via B4 Relay wrote:
>>> From: Ye He <ye.he@amlogic.com>
>>>
>>> This patch add a new Connected(string bearer) signal to indicate
>>> which transport
>>> (LE or BR/EDR) has connected. Also extend the Disconnected signal to
>>> include
>>> a bearer argument.
>>>
>>> This allows applications to distinguish transport-specific connection
>>> events in dual-mode scenarios.
>>>
>>> Fixes: https://github.com/bluez/bluez/issues/1350
>> This is an API change, the commit needs to explain when the
>> Disconnected signal API was introduced, and probably mention that the
>> because it was introduced in 5.82, it didn't have time to be used.
>>
>> It might also be a better idea for both signals to send out a
>> dictionary of values, so that the "bearer" can be added without an API
>> change, and further info can also be passed without an API change.
> +1, I don't really like the idea of introducing bearer specific API
> into Device interface, using dedicated interface is probably better to
> avoid confusions and we can then introduce bearer specific methods and
> properties as well.
Thanks for the feedback. I understand and agree with your point — 
introducing dedicated org.bluez.Device.LE and org.bluez.Device.BREDR 
interfaces would be a cleaner long term solution. It would certainly 
make the transport specific behavior more explicit and extensible.

At the same time, this approach will be a significant change, requiring 
substantial refactoring and extensive testing across the stack. This may 
be too large an effort for a single contributor, and it would take some 
time to design, implement, and validate thoroughly.

As an interim solution, I'd propose extending the existing Device1 
interface:
-Adding the new Connected(string bearer) signal, which has no backward 
compatibility risk because it is a completely new signal.
-Extending the Disconnected signal introduced in BlueZ 5.82 with an 
additional bearer parameter. Since this signal is very new, it's 
unlikely that any application depends on its original signature, so 
updating it now should have minimal impact.

Then, as a next step, we can gradually work towards introducing 
dedicated Device.LE and Device.BREDR interfaces and migrating to that 
design when the community has enough bandwidth and agreement.

Would this approach be acceptable?
>> Cheers
>>
>>> Signed-off-by: Ye He <ye.he@amlogic.com>
>>> ---
>>>   doc/org.bluez.Device.rst | 33 ++++++++++++++++++++++++++++++++-
>>>   src/device.c             | 34 ++++++++++++++++++++++++++--------
>>>   2 files changed, 58 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
>>> index
>>> 646e2c77ec2ddcbf7e6897336165d228c349fe00..1022402d95a1cd34dea88103ba6
>>> 6fb06f3007de7 100644
>>> --- a/doc/org.bluez.Device.rst
>>> +++ b/doc/org.bluez.Device.rst
>>> @@ -157,7 +157,26 @@ Possible errors:
>>>   Signals
>>>   -------
>>>
>>> -void Disconnected(string reason, string message)
>>> +void Connected(string bearer)
>>> +````````````````````````````````````````````````
>>> +
>>> +This signal is emitted when a device establishes a connection,
>>> indicating the
>>> +bearer (transport type) over which the connection occurred.
>>> +
>>> +Client applications may use this signal to take actions such as
>>> stopping discovery
>>> +or advertising, depending on their internal policy.
>>> +
>>> +Possible bearer:
>>> +
>>> +:"le":
>>> +
>>> +     LE transport is cconnected.
>>> +
>>> +:"bredr":
>>> +
>>> +     BR/EDR transport is connected.
>>> +
>>> +void Disconnected(string reason, string message, string bearer)
>>>   ````````````````````````````````````````````````
>>>
>>>   This signal is launched when a device is disconnected, with the
>>> reason of the
>>> @@ -208,6 +227,18 @@ Possible reasons:
>>>
>>>        Connection terminated by local host for suspend.
>>>
>>> +The additional 'bearer' field indicates which transport was
>>> disconnected.
>>> +
>>> +Possible bearer:
>>> +
>>> +:"le":
>>> +
>>> +     LE transport is disconnected.
>>> +
>>> +:"bredr":
>>> +
>>> +     BR/EDR transport is disconnected.
>>> +
>>>   Properties
>>>   ----------
>>>
>>> diff --git a/src/device.c b/src/device.c
>>> index
>>> 902c4aa44d21eb89076eff3a47ffa727420967a8..ae6196eb2e5b6eca10a8e1c3360
>>> b85023dcddec2 100644
>>> --- a/src/device.c
>>> +++ b/src/device.c
>>> @@ -3491,8 +3491,10 @@ static const GDBusMethodTable device_methods[]
>>> = {
>>>   };
>>>
>>>   static const GDBusSignalTable device_signals[] = {
>>> +     { GDBUS_SIGNAL("Connected",
>>> +                     GDBUS_ARGS({ "bearer", "s" })) },
>>>        { GDBUS_SIGNAL("Disconnected",
>>> -                     GDBUS_ARGS({ "name", "s" }, { "message", "s"
>>> })) },
>>> +                     GDBUS_ARGS({ "name", "s" }, { "message", "s"
>>> }, { "bearer", "s" })) },
>>>        { }
>>>   };
>>>
>>> @@ -3676,6 +3678,7 @@ void device_add_connection(struct btd_device
>>> *dev, uint8_t bdaddr_type,
>>>                                                        uint32_t
>>> flags)
>>>   {
>>>        struct bearer_state *state = get_state(dev, bdaddr_type);
>>> +     const char *bearer;
>>>
>>>        device_update_last_seen(dev, bdaddr_type, true);
>>>        device_update_last_used(dev, bdaddr_type);
>>> @@ -3691,14 +3694,22 @@ void device_add_connection(struct btd_device
>>> *dev, uint8_t bdaddr_type,
>>>        dev->conn_bdaddr_type = dev->bdaddr_type;
>>>
>>>        /* If this is the first connection over this bearer */
>>> -     if (bdaddr_type == BDADDR_BREDR)
>>> +     if (bdaddr_type == BDADDR_BREDR) {
>>>                device_set_bredr_support(dev);
>>> -     else
>>> +             bearer = "bredr";
>>> +     } else {
>>>                device_set_le_support(dev, bdaddr_type);
>>> +             bearer = "le";
>>> +     }
>>>
>>>        state->connected = true;
>>>        state->initiator = flags & BIT(3);
>>>
>>> +     g_dbus_emit_signal(dbus_conn, dev->path, DEVICE_INTERFACE,
>>> +                             "Connected",
>>> +                             DBUS_TYPE_STRING, &bearer,
>>> +                             DBUS_TYPE_INVALID);
>>> +
>>>        if (dev->le_state.connected && dev->bredr_state.connected)
>>>                return;
>>>
>>> @@ -3747,7 +3758,7 @@ static void set_temporary_timer(struct
>>> btd_device *dev, unsigned int timeout)
>>>                                                                dev,
>>> NULL);
>>>   }
>>>
>>> -static void device_disconnected(struct btd_device *device, uint8_t
>>> reason)
>>> +static void device_disconnected(struct btd_device *device, uint8_t
>>> reason, const char *bearer)
>>>   {
>>>        const char *name;
>>>        const char *message;
>>> @@ -3787,6 +3798,7 @@ static void device_disconnected(struct
>>> btd_device *device, uint8_t reason)
>>>                                                "Disconnected",
>>>                                                DBUS_TYPE_STRING,
>>> &name,
>>>                                                DBUS_TYPE_STRING,
>>> &message,
>>> +                                             DBUS_TYPE_STRING,
>>> &bearer,
>>>                                                DBUS_TYPE_INVALID);
>>>   }
>>>
>>> @@ -3798,10 +3810,16 @@ void device_remove_connection(struct
>>> btd_device *device, uint8_t bdaddr_type,
>>>        DBusMessage *reply;
>>>        bool remove_device = false;
>>>        bool paired_status_updated = false;
>>> +     const char *bearer;
>>>
>>>        if (!state->connected)
>>>                return;
>>>
>>> +     if (bdaddr_type == BDADDR_BREDR)
>>> +             bearer = "bredr";
>>> +     else
>>> +             bearer = "le";
>>> +
>>>        state->connected = false;
>>>        state->initiator = false;
>>>        device->general_connect = FALSE;
>>> @@ -3854,15 +3872,15 @@ void device_remove_connection(struct
>>> btd_device *device, uint8_t bdaddr_type,
>>>                                                DEVICE_INTERFACE,
>>>                                                "Paired");
>>>
>>> -     if (device->bredr_state.connected || device-
>>>> le_state.connected)
>>> -             return;
>>> -
>>>        device_update_last_seen(device, bdaddr_type, true);
>>>
>>>        g_slist_free_full(device->eir_uuids, g_free);
>>>        device->eir_uuids = NULL;
>>>
>>> -     device_disconnected(device, reason);
>>> +     device_disconnected(device, reason, bearer);
>>> +
>>> +     if (device->bredr_state.connected || device-
>>>> le_state.connected)
>>> +             return;
>>>
>>>        g_dbus_emit_property_changed(dbus_conn, device->path,
>>>                                                DEVICE_INTERFACE,
>>> "Connected");
>>>
>>> ---
>>> base-commit: dc8db3601001de9a085da063e0c5e456074b8963
>>> change-id: 20250618-device-bearer-level-conn-state-3e29d56bda88
>>>
>>> Best regards,
>
> --
> Luiz Augusto von Dentz


