Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.35.87
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793956783;
	b=aOyKhGjy+T0RZYjPBUQrbHbei+49lSgZcZZujxJQvuOHyeHUl1VK0NddyOrZp9BiznGY
	 t5fiUbXb/vVyckkAuGt1ZwYsAzEtIXRNAEiFBYN/UZZAkV48UOmf+iz9MsMfTz4EYzPry
	 sk+sjq5msGYzUdJRGoQKKRNfg7NUWTRbweIW4yK72EDX0mo2U4zHEpix/YeRud5To/8lY
	 pxAjIAdvbaK+s4WgDdF2cGTIyfaYlRTXrnKzeugoyfuhoVC3qKNhy1sGtIbtYBT68Gyp7
	 SNBucBzfGLLza8PTw1cWXQS7wVrOVDAnx2SuuKohNbqg238hDjftVA2dzKDKqW4Z/cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956783;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Gr3G8dQiU9y/C/Dgmi2tJmRnmtweQHj6PjbiGIHadX8=;
	b=hk+NhoyfkCkfIlvzxwO5iTzZd11Sti5oh5qRoc1A8UQgxsIT1oXvwXGMPIfaulEwh+zz
	 ZOjP0rNf7z9FwHTmj3jR6d1hzHlBNH9qJUqSP2GX8y945IZY1Sp/iWkOgGPoXpRsSjR04
	 XOGDcdA9N/qxGiZZ39EeHXFM8XRW6fHuK3MorkMpi08A5HfczCo9zM5pH38kBdXjsFOGG
	 kqL2CpWotezgJejfmqhzT9gj4ZNzm01CMRLh+p+JaK/1KYNN17L0nUGszcpsKqOWs+uCZ
	 l52vHVYMLHkvbAVMVJCmAnj/n2qYaPW+Vo8FzV4JvV9OBCfclcyLPMFUq45SP4Mj2lQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=outlook.de;
	spf=pass smtp.mailfrom=outlook.de;
	dkim=pass header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.a=rsa-sha256 header.s=selector1 header.b=HSd2RD8o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.35.87
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013087.outbound.protection.outlook.com [52.103.35.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BA0606D80D;
	Fri,  6 Nov 2026 09:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35BA0606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.a=rsa-sha256 header.s=selector1 header.b=HSd2RD8o
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fI1Nz1YeWslrmiN6aUmLj7d1dwK/wcUJQ8rxj5AmD9dTZYbFL8tMZdspPu0KqzBZQUpalJVsxhr1YinXmUCfElTKU1wfdqUxlXCkeAkYg0josKbBEKmSDcmsLmcosFZZ6zsSoCVhGsGuPSOedSTz4u4TnAYKb2VbhRwQhSQ0mvoRws9GF/mpyY6tiTLUG9aurjGHhVzlHd4k9BaXPptSIJNltJCAcNCFqB4RRvi2jNg46cfVbWuqOttZiSVPAUlQWfIW8sgk+uPbRHmKS+wzsXO926FGxaCzDfInqN2g0uV4NZWms9SQ9SCehW2JyGr61FgklydSI3u/1126SnDmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr3G8dQiU9y/C/Dgmi2tJmRnmtweQHj6PjbiGIHadX8=;
 b=SyTyAUyBbnsXyz1RFYy2ZtX1Qo7gtbTcaDJoAp+1zzKzy4AIsvmZxZsMKfBQXE1Xr3LW/QntNz9xS2lY2i1FkqtC7fahL2jnsdliJMTAcQWgJr4q4/AJptnSxyIps6Y6FTYNemnakUqqBy0XM1NMAVnX7ehjNXowx0fQLUuvaTY+ct22i8/WpG+g6tQd+2MlGvrgkGTl5TyCxX9n3EzQxqgGxh1q+haT1ITaYUYhbc1d/79LrSQjUJHG+EDZ+DKXqg7OXBRiH30quIBJJLkEzk1Mr3K5bNuy9k/loUfukzz2wqk7NWtpPijmhrv69K60DqToNUPJbaAkEDwZOEJmRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr3G8dQiU9y/C/Dgmi2tJmRnmtweQHj6PjbiGIHadX8=;
 b=HSd2RD8ohVMJvGZffP262YBqZ+9zq8Uev0XaWK7doDLM8NDBM4kulyyHwOq7h6AUBpXFAMERNpL9ncEp8L3LlhrbSdhqjI+G9+DVJfAdoFXrRMmKIp4VJnqm2OOAqs/rJjRAGRKkSZ1CWR2sQWfY9kLS/kep/TjfZKC9L6J4con1pYaCOFFxXV+UhJpO0XNqixa6Kyj8YHyv9pAqadAvAvAKPo4ay7xCvQkiYTQLmriQ5KzZTGZHhn08/SN1375gVkBfvBZeyGizYW1rWoGnT5ozIJLY/wdE43SQPk9ebbEYJZl90hU7ttUKDN3gvKkt1TlkHLtiXmvYTZrzmubs2A==
Received: from MMZPR08MB549315.eurprd08.prod.outlook.com
 (2603:10a6:190:28::19) by AMCPR08MB11995.eurprd08.prod.outlook.com
 (2603:10a6:20b:76f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 09:19:40 +0000
Received: from MMZPR08MB549315.eurprd08.prod.outlook.com
 ([fe80::21ab:3314:172:c7e5]) by MMZPR08MB549315.eurprd08.prod.outlook.com
 ([fe80::21ab:3314:172:c7e5%5]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 09:19:40 +0000
Message-ID:
 <MMZPR08MB5493152BAB536106F1884EEB52DF762@MMZPR08MB549315.eurprd08.prod.outlook.com>
Date: Fri, 6 Nov 2026 10:19:37 +0100
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Christain_Stefan_K=C3=B6ver-Draxl?= <ckoever@outlook.de>
Subject: Re: [PATCH 2/7] Bluetooth: add a quirk for controllers that hang on
 Write Current IAC LAP
To: Yang Li <yang.li@amlogic.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192338.209574-3-christian.koever-draxl@student.uibk.ac.at>
 <2b75bc46-3e93-449a-b13a-2cc4ba8cf755@amlogic.com>
Content-Language: en-US
In-Reply-To: <2b75bc46-3e93-449a-b13a-2cc4ba8cf755@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0135.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::33) To MMZPR08MB549315.eurprd08.prod.outlook.com
 (2603:10a6:190:28::19)
X-Microsoft-Original-Message-ID:
 <f9649c69-733a-4617-8303-035cda3429ce@outlook.de>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MMZPR08MB549315:EE_|AMCPR08MB11995:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ea21ad-c611-47f8-ac0f-08df3be715e2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|8060799015|19110799012|6090799003|15080799012|5072599009|16051099003|23021999003|51005399006|19101099003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEtCUkloaWh2MVNWYXRFQy9mL2tFSHRJeC9wZWhpVmlFVDY0a1g1b1VPYUlT?=
 =?utf-8?B?TldXL0VaWHp2NEZHaGVKTWVyS2VMcnkwRms0aERGWU5ORkM5U21TKzVGaVRq?=
 =?utf-8?B?WkZqemliNmZrdUo5QmdvazZIWXRLWUF6YWk3cU5OUkJjWmxpTHc0R1FiMWlU?=
 =?utf-8?B?VmY3eDUvNnhDenJSbjZlNUVndFc1ekkzZENyT1hlb0RNaDZ5dmR6STk3ai9N?=
 =?utf-8?B?NXNtMUJhUHA5UzJ3WTRJWmZvRVB1VFlTQXErQUtvaFlQeE1Cb3JOclJEWUsz?=
 =?utf-8?B?MVluWUtvcnJyUVRzMnZxQzJTQllmQ2kyOS9LZ3BpMkdWNlNLclkrc3cyOUh1?=
 =?utf-8?B?aVZSMXBGWW1WZ1BMd0dLNHNuQS9KZnhnaXg4cldzRE5ZeVMxbDdIMnVGaGJD?=
 =?utf-8?B?QzdnQjJoTEFiZk9yVkxkOUczRWY3ZWNTM0gwOTQ4QVNOT1pNeG42VldtUFFj?=
 =?utf-8?B?RXlKQnNNcityRzZVR2hGdEkrcmtWd0tUNDBZNlFOVERRdnY3NUNYVk8vQnBH?=
 =?utf-8?B?dCt2by9IMG40ME5seFFVVm43YjRtTEQ5cnVmOHpSSlNpRWdBcnpsTkpReDl3?=
 =?utf-8?B?aG5wM1d4QWpwamw4ZHJJWEVBc3lGWml5TzdqSkFsV1ZjamQ3NjZiRHh3emtU?=
 =?utf-8?B?d0h4amZxYThoV1lWKzBlSXN6VUdHWUJmT0Z5Qm1SZlA2M3FmZU1iV0xLYXEv?=
 =?utf-8?B?dHltM1ZoYVp3OGhDYWNyVkE5elM1ZXQ3UVE1WjNrc2tLWjc4cS9YL0FyNFBM?=
 =?utf-8?B?eFNYVFl0WVd5THdwaitXNHo0WWxHem9ZbVcrZEhSOEhCWmJkYjFLQUFITTc0?=
 =?utf-8?B?WG9mRGk3bTRTV0FlaGR2RlREZjlLMUJYTlUwM2h4MlpFT0llUVBZcXVpcDVa?=
 =?utf-8?B?b1JsdXhDdFpZL0hVZmZWdXhTUjkrbHU4WFBoT1hQM3NuMy9sZitDWUxvMHlh?=
 =?utf-8?B?MjROVlB6ZldZUUc1c0JXMlZ1T3dVQWRYY2FLeVJiRVdkK2dhbWNPTUNKTGhO?=
 =?utf-8?B?MFFoT2RQcURDdTRUNGxjUXIwVXR1S0d4MWIreXhDZFJkZDBaMzU5Vld1bG5p?=
 =?utf-8?B?RlpWUCtWNlVFS3BlZE1RVmhiY2tITFRmcDBiVmxXaUNwYUgxN2JhV21VZ0c0?=
 =?utf-8?B?aFhzdU9pbjFzUEZubTVWU0t2QldHTWxrM3E1MllQOXFYRVpPTFd1cFJoV2li?=
 =?utf-8?B?SitBaEY3dSsyemZVelpsTmFkTkkzSi8zNzhyR29NYWovWkoxUDdXdCtkcmpn?=
 =?utf-8?B?dzdBMWpUYXc5MU5pczlXZ2duUi9wUXFmUzk4RmhJRzNWcE9iNmFTdC80M0wv?=
 =?utf-8?Q?2IjNz9j8JGu97Zw8RbsoPLmbIrlDW3a6Bx?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlVCL3V6emdDajlEa2wrMHBORjhXQTJUV1lFcWUwZG9yQjhWb21ZcHNWT0xS?=
 =?utf-8?B?clA4NmRzUVU3Y3N1ODRlUEg3bitKeFZIeitpelhaYm1FVjlEbHhYbFhSeGhv?=
 =?utf-8?B?ZnkvTWRHSEZzSGExWndnMkcyY2VzU29wUnY3MDdtdGUzdUlRUjVENHFRbUJC?=
 =?utf-8?B?WmcrV3V1SlgxazRBMGovZVRNd3JoL0ZyQkdqRWtXYjFVRUJnVFBSSExINVVO?=
 =?utf-8?B?TVhJRVU5aG14UUhWVGN4QTYwcjRJOGEzSjJVQ0dOMDNhMkpldGJpbnhvZUFp?=
 =?utf-8?B?Q3UrTTQ4cmE1L3FnTGVRK0RvN3VLbGNOcU02U2w2c1FrVU5jckxaM2NWcCt5?=
 =?utf-8?B?SFVuTDJDVk1XK1FLR0lKRkg0MzdrcXJpQjcrY1U2Sk5PV0tBanhRV2NQdXNq?=
 =?utf-8?B?ZTJlbXFBS05GWlNIOGFoYjY0RGNaTkwwMU9KZWZWYStrLzJMbVA2U2NLd3lT?=
 =?utf-8?B?SDErNThkWnM1bWFObnNPcmlXU2RCL1pqQXlXSytseSt1eEJqUHV2cGhrR3Ar?=
 =?utf-8?B?NGhJMWpTeHNHWlJmQ2Y2NVZQSkhHSnp0NEFWc1EzT1BJOFJ0cUp1K0p2VDVa?=
 =?utf-8?B?T1hRV0lSam1rVzdBazdnckhoaWtxOGZvd2JWckxTaFJjYnlueVQ0dlZxK3d3?=
 =?utf-8?B?MEhMMFlGcDZwRlJ5TFFDUmxjYnhCdFNKMzU0eW9BSVY3ZlJVUjdzRzZrTlZI?=
 =?utf-8?B?bFNEdkNITGhiNE5JMGxlTWM5S05OT0wxUTJRZC9hZ2JoY3Y1WVlaN3YrVlNJ?=
 =?utf-8?B?YkJLdk9kNFpFUW1FZzhId3MwRXlQNU44L0txd0NtaTF1ZUZqUWpqUzVpQlFs?=
 =?utf-8?B?TWhMSy9NUEFTU0h6RTZtbU1ya1JGMC9SZUovNGJpd25RV2x5ay9kbVhhZkZy?=
 =?utf-8?B?akREMi9GVkhhdktJY1JDRGpkQk01eGYwSnZteXZDeFpzeHNESGpLNFZFTHYw?=
 =?utf-8?B?UnB0ZmhKazFsZFZVTFZybFdpaEY4aGJ4UTY0RHlUOTdVTEdrUzA2NkErb2RV?=
 =?utf-8?B?R1pNYitOWE8vczdjTmZkQ1JzeGVndXJKcVpkZU00cnBHYWN0citNbG9pU1Bz?=
 =?utf-8?B?OENlU0RJRVJzcWp4aFNjdXVEQloyZUxwZ3lDMEcxTEdlOENyZDVXVHZwTUQ4?=
 =?utf-8?B?T3hpOVdWSXluWXdhMGNVZVJpb1c2TWZZdVBqMk1aL3ZCUVJKUkh1a1RMTE9E?=
 =?utf-8?B?alJ1T2hmbVRsaEEwUFM3MmVZcTF2NlZsbVlDdkVNWHRZL1l0UGhTYUczYlVz?=
 =?utf-8?B?dWtTRzJUZGxxdHJsTVRES3hFMTJyV2ZGWUJlekt5Vi8yOXBMQ1hIUWt2bzBk?=
 =?utf-8?B?S09EVzNHeHNSS0ttb0NNaExScERHZGVIZGhMaEZSVnRKdi91ZlZvZVJ0UVZB?=
 =?utf-8?B?WTlLNFFrRHNmUytZeDh3bGdkWHFGWitCT3VKaC90bnYrQWJTekdrZFVpblNx?=
 =?utf-8?B?WVBvSWx2by9IeW1SMVU5bzhPM3ZqMXE3WS9aZk14M0I1TDBVaUtnYkhWT2VM?=
 =?utf-8?B?bkF4TWI0T05IMTZoc2RZR3dwV3ZmSS9aandOY1duNEYxWnBHekM3c3hJN2Nk?=
 =?utf-8?B?NkpqOVdxMDlrSVpmN1EyZmhkcDVXSGpLRjZ5VHk1eTVGR0VNZC9yVytTSlBG?=
 =?utf-8?B?UTBMNnZqcDF4QnJWMElxTi9FVVlRVk5mNUZTL3VnSnkzNWl1cHJZaGRIT295?=
 =?utf-8?B?Nklib3c1RW5tZlN4dlU0M0pCejB6WVd1cldDd0xHQitocE5xQTFXb3E2Z25G?=
 =?utf-8?B?YkxDa2M5K1pid29kMjRXU0JsZDAxS2FNbDBXWWttUTBoQkk0akp0dDl4Z1c4?=
 =?utf-8?B?cUtwV3ZtODBXbDkyNFZsdEx4NXNPdi8rWGpvVU5ZN1Y2NEF4aEVMQURwOUhv?=
 =?utf-8?Q?MGtBVp6o6IquC?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-fbb9b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ea21ad-c611-47f8-ac0f-08df3be715e2
X-MS-Exchange-CrossTenant-AuthSource: MMZPR08MB549315.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:19:40.2368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR08MB11995

On 11/5/26 10:24, Yang Li wrote:
> This appears to be an anomaly with the firmware binary. Could you
> provide the FW version in use? It is logged during Bluetooth driver
> initialization.

Hi Yang,

the controller reports

   fw_version: date = 09.08, number = 0x15d2

On that firmware the controller stops answering any HCI command right 
after Write Current IAC LAP, until the chip is power-cycled. If a newer 
firmware fixes this, I am happy to test it.

Best regards,
Christian K.-D.
