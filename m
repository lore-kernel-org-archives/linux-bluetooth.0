Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C23C9454
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786741320; cv=fail; b=YR7DPIgfPCwlc9wz5f5fHhp4Q6BawgJtdRbu1Uu6aPbBy5JSsB2l1NGoDWx0bA+6/bfovE7tm/owVCaPcVoUf9K8WWQw4Eo5F5W9aymfWYto3wb5XbzMmSPmbMv9k4X8ChQlXG4dZ95uM0j3m7ujvY8qInzrKRILWJDcSonCUIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786741320; c=relaxed/simple;
	bh=rrWwakf0eU9D0EonGE+QkOP3SqIq4S6QmBMuFYnoutE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FYlfsFv/cy7K+YD625neSWljhffjlViClejk0ovcTfa202fAjdNngzVGOqi1Nv2SU5e+0PDeTLxUMyAqvuBCYg5/ZGD+7BC+uvDmxENLJEeb/f2BvruMjEjVgr64uKacWL203fWwd8M72HG3qhgsRxQybJFTWvzdh+bnkFBZCWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C3IaS/g9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qSQ1CRdr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C3IaS/g9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qSQ1CRdr"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EItvwn2269053;
	Fri, 14 Aug 2026 21:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9OKM/yoJoLX/QxaBOr8GiT0Wu3altf0CWmIEEvqsA48=; b=
	C3IaS/g9Ey+IhgU2ye5PPopBxI8/OjvYm9dVtxji+SSbGiHgIo++c2x0qEprkaTD
	SJkKzpGIkYoZ5BzFp1IIVxnH8LXdAcsaOqquX8fhOU6pj3xjD3cancgOLCDcuauh
	M2x9BsRHliK6s3LGs+Bkh2oM2mZQTSNwH6POl3IjqmczjgGRFPgKhW8uDPWt6PxM
	EXHyKwHUYK7s6plAwdrwg+JKa2DcpgDNz5qwn0pF3bo7x9MxV3wWfMW/BvN64U45
	fgab3YI/RT2B2MMryH0fZ/qr0xIpizFnbdWvKDjV2hhot6SUztpjbmolxG4b8bfH
	FqatU8z6B7PF5xqH4ikIPQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvka4v02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 21:01:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67EL0Dh4024082;
	Fri, 14 Aug 2026 21:01:43 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwj3n01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Aug 2026 21:01:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hALuD2L5j0DOWJdPMRZCOX+WCywQ73JJDgraigGtI38RlWW7SC69kjOIGTZN/Gi7VlljvYKLt0ZyHVWNk+/GXW2KS6tZVZwntaKwb8J4277qrlUNFySezoFGpbix5v0UeV8gHH8Un50mKreiilTljKWiPMZSppGItcxqidgJ+aJCCfRdsi389Ijd8AUPMkNfHULFgPV3tlXmc8PAKPW3Hlp7SO/nepq4zE2LxAxnaaC3GPMM677Erzz8BmwyVeDIr/YwK4Jyk8CxScAfwfwMiy4JCvmmrJLPCR+cUR9X1VpahexzYDyGF+RxJ2/J7G+2kycnSbWRHxUTFw1DtuS0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OKM/yoJoLX/QxaBOr8GiT0Wu3altf0CWmIEEvqsA48=;
 b=CiGTdLvT8ZWew3EzlPH59plaaiXXF3IMCcF5GRvpVA4UDcYK2lme0CIOszxdsMVRGas3PkGYnIKY4BD7tj04lmoulkgeX0C6u+CiPvh4n+rLN9j2+IfUITu2KACVErL7vcbofgfBoL1bfFOkj8yBAMY1fuNGiMCOJPLMKVQ9KbELPmxdwDvZHp6zlYqC42OedgJZRRQFIXnWJB4/T3rkIxhhCutUBj0ZRy6KsNPObCQvhyUYKSfqUlncc0hJJmJ6dSHuHbEw6ua+57R6siJ0xNaR+Md2f5DWkkkKFuVk6P8P5vDHJ74rVPrCLQUmcxvsAxxgmtBw4Di4WjEmAv95MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OKM/yoJoLX/QxaBOr8GiT0Wu3altf0CWmIEEvqsA48=;
 b=qSQ1CRdr27SeEaBuORLqwoLoi9T9LGhlxbTjcLBFkPD+iVFzxRNov20wvn53DrsELLncbhlkocFI8h7Z+XgYa/FUZ2inf9VO/FS1n/QHk64myFntYMRV1MUwINNofRqFe+RtlPIBJMdDS5L+oKJ3QnzvIiC60l4k5Et0ivCC8Do=
Received: from CH3PR10MB6739.namprd10.prod.outlook.com (2603:10b6:610:147::6)
 by CH0PR10MB7497.namprd10.prod.outlook.com (2603:10b6:610:18b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:01:35 +0000
Received: from CH3PR10MB6739.namprd10.prod.outlook.com
 ([fe80::2f5f:44c3:faec:55ea]) by CH3PR10MB6739.namprd10.prod.outlook.com
 ([fe80::2f5f:44c3:faec:55ea%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 21:01:33 +0000
Message-ID: <09ea7851-c5ca-4978-a5b3-102fda13269e@oracle.com>
Date: Fri, 14 Aug 2026 14:01:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [oss-security] CVE Request: BlueZ AVRCP Out-of-Bounds Read
 (CWE-125)
To: oss-security@lists.openwall.com,
        Elman Shahbazov <shahbazovelman97@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <CADE-WFd0FhWa=cc-w1_cm3C8kRdc3PE5HaFJ+uSM+99jjr_wjg@mail.gmail.com>
From: Alan Coopersmith <alan.coopersmith@oracle.com>
Content-Language: en-US
Autocrypt: addr=alan.coopersmith@oracle.com; keydata=
 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
 5V9JclVH6u5Gug==
In-Reply-To: <CADE-WFd0FhWa=cc-w1_cm3C8kRdc3PE5HaFJ+uSM+99jjr_wjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0060.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::16) To CH3PR10MB6739.namprd10.prod.outlook.com
 (2603:10b6:610:147::6)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6739:EE_|CH0PR10MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: a64f3afd-3dc0-4af0-6fec-08defa4738c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GIs2UP1AAxullPRJmkR+yf0PkUR7XkG/YqRB1WFRwt+6C4mD0pE6f4S4yFW0TozAwZZZb6Ae9Aw04ZKxp/B9lgv6Atc9YTsfp/vdKkSo2HTBBG/7N/B4eJgQi2V9RNNbFTtQkhWO+4hV9oE+P8Dwf1+Ho/4UHUmv0HBd6JKINojrzlTgC1CyFRVbsXf7e0tOxlHqHTa5XiKkHz/1KIOXLmgeBVi+360Uash/Kewv5e0/wmjlAiKBBuRIAGOb3kPlSbVG73/tBYJJg8QKrsvZBwZgoe10v/5olK5qYFTMnvMvb8XK8ouaMiMS5KMatsQBRqxEp00r3vEjaXQU7PNBnHIUHZLyN5T7rLvZt2WcDtd/3NA8z3Ijq8pRijqgtDpidJt2fxLI3qTTI+FlEHXA6pOx1FYf6z5nl7kv8R6tVvN3fggKAvMlWMbR9lF+9matgI8sGpqNwJprROCuKpCE1KiAMaaxENCwxVMWnFGogmbJ9HRy/V8H6wGGbfHwpkmMOisnS7mZjJjgKKT5q/6f0TdCORG/YOuGSUQPfxzEjn1ggkZ0GTrKTYGVdxtQkz7+hZqLld8sy2D2mXiz48m36HFtIUxHcw1In9n7YzTk5IPjuAzMAjJMg0Wd2M/XutMPZ0r/jTwVNyohprJGAf7cPIWvH03q4zodUEeGm+oH42g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6739.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SENJbDZnWFFSSzZPd0M2RmFoVWloQ1RUangzZjdLUlhTeEpxSUJHbnlWQWt0?=
 =?utf-8?B?ZFJjeEx1eXdSQzYvSkVuN3U2bjZ4T2NDcDhnNlNrUnhlc3MraUNXWFZCQWxo?=
 =?utf-8?B?Z3NSWVpnY0ZkcEdzUDk5bDBDSW9MeVg3YnFZTnhGT2NRMlh5WDBHeWNtZlV6?=
 =?utf-8?B?NnhhNHg5Qk1GMkRiQjNpY2dvZDBkQnQ5ZDRlMHkwTlVtM3JRVW4vYk5OZlZa?=
 =?utf-8?B?MTQ3anNyYUNEY2t5M0tKeEZxRkdCa0tGbkZkZVk3U3NmaEt3emZnaHF6QkFQ?=
 =?utf-8?B?Sm5CMkJ2WStDZzIxb2xDNXEzLzAxaEdoeHNjODVDdjBWNDhqMWdQVk9vemZL?=
 =?utf-8?B?eEZqR3Z0WUtzR2NKOXJhWi9PaFNBaW9Wcng2VTNWcjdzOU14bGFNcnh5dEtR?=
 =?utf-8?B?WlI3NWtZVVUzV3lMQjAyOHp0ak1pK0NVVW1TSFoxTE9PbDVWYWZqU05FOWpr?=
 =?utf-8?B?UHNuTUhHRUE5OFpVYnkwajJOeXVMT1ZtR3Uxb0d6ZFFYeDZEVElmMlQ1cnk1?=
 =?utf-8?B?NDhtWG9JYWF2UThqaEF0TFNybW1WcURjZ212WEM3TmgrMmFOd2xaTXZ3ejVH?=
 =?utf-8?B?YzA5OGk3OHhlZDhDTmxFVlRlVC9JV3VnYVgwOE5rUTVWeTE5Ujh4UVBjMEVV?=
 =?utf-8?B?U2djYzV4c0hSRnBCd2dTblc1dlZwaDgyWS9oMU5LeVdIN2NhaUlmWHFKaWFo?=
 =?utf-8?B?aDR3cWVUOEd3VlgvZlhYdEZ2MHVHcWFTNEVGbUFQVENvRldmSi91Um0vQ3Ix?=
 =?utf-8?B?RGNSRWd4TGJucVBFZlNrUlFUS1NPMkNzZTFJWnlQdCtseERVSktrVWhrbTcx?=
 =?utf-8?B?em0vMWtCMW5pelNad3A4QjJsYkQyc2t5ZTQrQ2FoOUlJME5KQ1ZaMEZTV3BK?=
 =?utf-8?B?RDhCSGVxNW51RmNYeDJwSzJOSXNTSlBqMnh4bEIrU3YwMk04NzBpc0FPN2lt?=
 =?utf-8?B?aVQvYkFtdlJMRkhzZVlkZml4aEpyd0U0cGwvY0dkOG9PTVQ2dEhNazFlSFlF?=
 =?utf-8?B?UEVvSElOUnk1ZDMzUU5EbkUxVnVqVlc4Sk1EdjZKQ3NQY2JQTkg4bkcrMU5j?=
 =?utf-8?B?bHhRQlhMM1hqRWpUSWJnVUFUeGg0clhNL0l1TVpOdXVROU82djRtR0tDYlpk?=
 =?utf-8?B?bklIbktCTURqRWVnUmNkd0o1KzJweklqQlYyYTE4a2JXcUdWUlRic0hHbGZW?=
 =?utf-8?B?TWdQN1g1N2VIdUJ1d3AyMU1GSXlNVjJBSHByR3NCRkRPTmVTZWVhZVhvYVh5?=
 =?utf-8?B?WGV1b3BWTUlTejVvV2JCazBlQmV6ZHlCRXJGS3BQZ0taWWZRZzRYbW10TFFQ?=
 =?utf-8?B?dCtkeG9YaEh5U0NoVTV6U0VVc3BhMnlpTHc0V1Jra21Sem04YUZRNkxjLzAr?=
 =?utf-8?B?SGh4bGs2MTVsckZmMUZ3S2NxVVFTaFh6NEhvbVo4QVQyWElhc21ZbGRqeG9m?=
 =?utf-8?B?ZkFTZzhnUWN0cnBtTGVhM0lnK0VXbVBYN2R6Vjl0dDZJTFhUTXhDYWhoOWNZ?=
 =?utf-8?B?QVB4d010c1NRTFJYS0FTUnRMZnp0NUVQVUM1SUV4ZFJNcWg2b2xBSkF6SnRw?=
 =?utf-8?B?WDZJMVBKYzhOMDdicmduM1E3N1ZPeDMrY2NDSHpyNnp2MmxBQThSMjVhTm8v?=
 =?utf-8?B?SkNQaXMwSFdDYkhlR1I2N1RMUHNZSWdxK0ZReEFiclFLdzVFMjk5dkxCQ25Q?=
 =?utf-8?B?SEhNLzdZb09IM1R3K2MzdWJZUUJpTGxSM1pXcDdZdlJ3WHc3bE9iTnJtWG81?=
 =?utf-8?B?QW1nSklVWW4rMm1ncXVhTERpRTRQVVVuWDk2eUxKZU5XWnc1NlZkT0dSZ1M0?=
 =?utf-8?B?d3FWdDluT3BmbUFpUG5zenk0OWNrRERHdnBXa3JmSExSYm5tQ05tSUVuNEVL?=
 =?utf-8?B?eVBrUTRGUFlUUzhGdWsyMUhZZ0J1eExyYzVlR0JrTlZnR0xRWE5qY1pkd3dC?=
 =?utf-8?B?T2RPaVMxdEVrc2NSTDNQV1BVSjR4STQ3Vm4yeEIzL1NIR0E1cFROZWpSQVRB?=
 =?utf-8?B?QmRKMGNZWmt0d3drOTV3RDd4WGl3ZEs1a2h0ZnpsbEtTTEx1bXRzbVdvczA4?=
 =?utf-8?B?cjlod3FqczdKQXpMY2Y1UU9NNzZNQXY5UmkrckdUR1BEbFBHdmVhMitrdEx4?=
 =?utf-8?B?S0FUMlFZTjVFOUlzc0ViRTFJKy85Z3lhTG9EN2dObnJiajVaOHhWaFByY2hj?=
 =?utf-8?B?K2l5dVE1Si9Ga1hGV255NCtkTXl0enhIZDB5dGJEcjFWM3JDSkpHTnpRNjZL?=
 =?utf-8?B?bkg2R00yY28rb05OeUp1MTZMSWE1elg3RFE0b2JpcWJkeUUxbFAxSG1xSkRY?=
 =?utf-8?B?UERab1UzVVR0QmtsdFQ0WDZod2piUld0WGFGM284U1hFdlBrbTFIY3JXenR4?=
 =?utf-8?Q?Bshe8hsx83c71rvg=3D?=
X-Exchange-RoutingPolicyChecked:
	V92kGV5lArbjPaBtjr+p88hmuvStAkQbs2gOAVC8j5ORzaMyQ2K5VAXKMVatQPAedBSROVv6sDlJxX9nbQqEIjf0FX51rIeqloD/+fGkVDokAHdm3/AxE9oNGOT4FBra6zjWRXdJ8076wnzEbNgjbtng/spHDOR/Oqzj22xwuGAcIwY4RaJf5Iek+wYJCN6Q8fcxXH+XjRJdZeVrl2Xg3SAUpDC9kqhy3O6j2kTcH6P/yDbTqc2utImPo5OfQKauH8TgIK3dnEeg5Jq/4vRhwptfO8rmvmCWaNtszZFbzJrsCbZl+vOUBBzjUEuubpgRm/GupBH1zOHRydLIm5UxtQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UvNTtZSg04KSasShJa5GknkxBhYQtZ48t/shpFhI/yK1t5QVQweCWoG88CXYkTyeHclDCea1PWARMWBZGb0Mg4MhkQ7x1a35lI1HyjesWVMAC5jHh42RGGX4M+KixIw/LvOjNzG8CNH8t/FWwFcD/KvODSlr3EEMObDOXVvrsOnjjqAzzulFSIZ1ze8ZchuxzdYRFFDZLb2B2HDjgNPCaJ4ERoPPwoHVDahDi9lP2Uapu5YcHpJpyQIenjNcL7Y6RJj0FwaU+Yf1hzhAPpu06nTrO+9N2y5CW+A1LkVe0rJyB0MnDOi6ONyB0JS03UdDgi6C97lmcuGd5oLVs9H6abQI4qJvYwkHTARWsx4nmLFdr+xS+/YACPAVCaWE+OsG5N4o5/kTJAj2mbKNsuDFWcjyRzhjnw5H2njiV5RkyQ78WT/cpQXr3jTyMA6sjMuk54KVMyn6KNriQwRbL+unXz1LOGJ0X8qJV92nNmkQHvI90or+IPWqagqiEdYwvuRjYMXDmutaiG9/1/0zJRRKc0REpuLtDBR5Ho57OUQd0ay4LpXfqXIsPjuyQh0pnJCzvv1+cRCxiF4qONXtQGmHSYWjQwWxFlgRbjt81l/JIzQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64f3afd-3dc0-4af0-6fec-08defa4738c0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6739.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:01:33.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0guQtselv7/JaPmNgiFZvQt4JGvUNbyn6hS4kUWYG47rRitLoNqhW9arEO4jKHBEYxeJpJDgnnXGN/K5WE9STgA7OiIN4NYmFb0iRCwUuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7497
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608140161
X-Proofpoint-GUID: tBWEEgDzctUTc8jv4zVPWt8FQWWhyPUs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDE2MSBTYWx0ZWRfX6kQz4tc3XHiV
 uRacmUPG6m9LrP3I1i5bz/l4xhjM6ZQq+1rg+8qGGpl7o+CwZnR+u/WujOJpEFuBdN9FEs7Ve/R
 2rUFoq/ubaIq/5EKQKgWxHugDXuqDhRt3+cB2k15ZlznzKkR11WcghXEG4RuYW3E4znfygUcaAa
 RxgmaoLdSJ86Y3fC7NJZ2majg15nYqukaVoTo189mMUH025DNUa5VBZu4EarPe+L5iU3J463Qrp
 DpdX9p/+L8jOpq/E2Z7J1LekBn8JsFCls4w3bErIjScw9WaHDuI+olXvCDvfMnQZfYeCZ8IEBmp
 QXK5+T+gGmoc9YekunKKSqbKRPAD/pxVxDO0wPetnsMsaQlGdKndou5i0QRWjQ9nWMd3t2moIrH
 WeD2S6R1JDyupIiWUBwTBODBoyTuj/kuUYxi/OTsPcnhOmH3pPdbnvn4RGbhh37Ikbz6g6lgTFE
 JklgWFn5vVyzEpy5NAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDE2MSBTYWx0ZWRfX/OO5Yr9vLBNJ
 YzydQztzQ0jBUWvwjtCggxY245zWsDwOc++XIFePqsI6svEk55cHsOryeCdZoB7tfCbEyVgFygi
 TsMJciyqDtmS1VnIocfr3R6L0RWUvxpDiWroiSaLRcMUD3Ldcdpw
X-Proofpoint-ORIG-GUID: tBWEEgDzctUTc8jv4zVPWt8FQWWhyPUs
X-Authority-Analysis: v=2.4 cv=UdJhjqSN c=1 sm=1 tr=0 ts=6a7f8238 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8
 a=20KFwNOVAAAA:8 a=Iit44f9xRtqzGMnoNjYA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10

On 8/14/26 10:27, Elman Shahbazov wrote:
> Hello,
> 
> I would like to request a CVE ID for an Out-of-Bounds Read vulnerability
> (CWE-125) that was recently fixed in the official BlueZ Bluetooth stack.

Then you need to contact the Red Hat Security Team at secalert@redhat.com.

CVE requests have not been accepted on the oss-security list since 2017.

-- 
         -Alan Coopersmith-                 alan.coopersmith@oracle.com
          Oracle Solaris Engineering - https://blogs.oracle.com/solaris
