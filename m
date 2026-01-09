Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023127.outbound.protection.outlook.com [52.101.127.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5DC322B93;
	Fri,  9 Jan 2026 03:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767928043; cv=fail; b=rFU0Mrzx5qLB3bjj4U4VVnuHDtm1EVEiaf+kfZfd8ffa1R5f8BwEhQ21X2v7L2mvubL29LNUTJYvL5aiFZRWYilGdd4kGiPhn52BE53ZfZRUCJtFTysYZi7Zj5IMZ1R2PWt7Cx0CVXCk8YoX/4vbsx1aUaOvSViDXcmintD0LDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767928043; c=relaxed/simple;
	bh=lLeNbKsVhUrVMa3q5La0Ny6RLp2gkMCVR6t2/Kye4uE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N1oNgOMs9B3kk275euzhpBlZ299EYA25t74JxLLaZWM2NKcYLVQgFBk6ierWwKjgj+9oDdLQGCXUVAdAdsZSKKsHFdzERYGI1xsMc8rAD2gQn6RDzXoMw0jgoOkH+acvWDCG+v2v017gl1jG3izuMC5Nz9w27o62AqqWr00set4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=JixeDnOf; arc=fail smtp.client-ip=52.101.127.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="JixeDnOf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDyj81Jc6QWoGjV+WVQpcnuaZkbdj+E5BC7klj6eaJx8g2J7LVNAnNZggJpMvNCeeYloEAsqGKOBaPQqdk3JM7w/wd9JtXhRcmWbd09hzqbrytd5zkW4lI37RQWcZ7wTsgFeux6+dxQWzKLlN1eHlvZLBpA8+BYTQre94IESJiovLdwwBRDrp98CKyGH4HOkA6LkO3RklTQCx9qsrvb3GQr61VJlvrAUfiYFsD7Tz6YetnLkV4B2e3SxzyPC4xSLK6GwPYHbLAQ1fFMpV05qtYviEt3oYh+ssPV+xyLKUAxAEEv5d4MnNSQ2eH4r8Ssly45wEu2e3maJKuB0A+I3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWYm7DxG2Oz4Zg1EbsRb6mva5RPcf7HXk8APqw7QwsA=;
 b=Z+YvysBARtlpQAaEprZHpC3SNmDS+pvyj0H2VAcbqtu8qeri+TLxdsgGaKIYzvqCchUfKvhEOQO28J8oQmjkBsQmCbilgWmZ8hP7JFLPDohrrt+S7kwC0V/Y8BGC3VPm/WqkVSFHwF6duSw90ZDJervQAKOi8YchWhfWl5Qdya0GCk7ogWoIr8GoYKxq1IpXc7bJDP9wXC58WOdAh+xlnjLesB6Ztzxe9f+aUTVaifhZjP0ftYTyeNbeG09rifNxbwBgOcc55ILARIjLzwv/4OBNyEyD6odq/PQnseUpAi/QPyIZoKuLsXKgLiVr4W25oW+NkSq7I/yHy7lMEDdx7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWYm7DxG2Oz4Zg1EbsRb6mva5RPcf7HXk8APqw7QwsA=;
 b=JixeDnOfsnUU8tcBmsyPK1mWSUbvN46Gq7tExEsBnEGgdRbJrY0ybKlVFuZqkPbnNqYYRCljo1tJXRLw5DUz95bTCQx1tTIhLJeRnQr0dA+tSTEMaWB8Zi5wlkASVCdZm05+1K5QsKRuC1gsBoaml3IpKMFydUEe2dfcPb4Oi2Y49Cg7FbCnbZBe29fJtI2u5dageCCYo4MweDHlK9U8sGSV9HYrp/HGzhnY/7FntPo9staRKa+XlFmUN8lu8ZedQ7dMtOhK/61Eh8WZzk/tBMLc/gRhqErGphmJ59WfWjZEVnUDCxtF+EZdunhAHZPMAuTlRoYT98zoqrHh+cz3Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by TYZPR03MB6893.apcprd03.prod.outlook.com (2603:1096:400:286::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 03:07:19 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 03:07:19 +0000
Message-ID: <baca64ce-add3-4937-a4ce-1e372942e91b@amlogic.com>
Date: Fri, 9 Jan 2026 11:06:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_sync: use HCI_CMD_TIMEOUT for PA sync
 commands
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260108-pa_sync_cmd_timeout-v1-1-cd35538a9e12@amlogic.com>
 <CABBYNZKATWfF+5ekMGGQxkq0_gu8UkEJ5Me3-d1c66rxJROy5A@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZKATWfF+5ekMGGQxkq0_gu8UkEJ5Me3-d1c66rxJROy5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|TYZPR03MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: d0fda608-b2d4-47c4-7c6c-08de4f2c3330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2VNRnhyc2ZzUFdYZkQ4YytMUTRMYXYxREg2bVFPd3pKOEc5SnZEWkYwaTJk?=
 =?utf-8?B?TG1BNnBhWmlGMno4NUZjTHJ0TzBIUTRqUnJUTU90N2dnVTBKN2svYjV0bFRU?=
 =?utf-8?B?YVp4WURYV2xFMlVWYk52WkU3TldVeGRmQllBOGhpUkNLZDZqa0hVc2F3WVkz?=
 =?utf-8?B?ZHFQaHJiNUxUSWtLZERpUDZzQ0h2SFptdkZueGVwSHlPNlVpM1FiYmVaaWRD?=
 =?utf-8?B?d3p3MXNNcVR1OFhDMWFsUllXWW0xOUp0YnJneGUzRDNRMzZoZ09hbDBQaFUy?=
 =?utf-8?B?Ui9JY1ZnZ0NpUnVQM3FQa2k5L0Z1YTdIck5MVlVjZGhXT3FEblpqK1JMMXBn?=
 =?utf-8?B?OUtNblBVK0RVM285c2NTeDhZRE92RStCOWNOS0h5U2NYUjBIWTBzaHA5SGVJ?=
 =?utf-8?B?RE8rVjMzQ2lWb2E2d2dXYlNLUGZ2VXMxQjdnaDJONUZVK2o5ekg0bmtuRjFv?=
 =?utf-8?B?TlhDVzBlY0hJc2dLMmJ4MUtPcGRPMENvaS9LakEwcXFOSWpSeHRiQW5DSy81?=
 =?utf-8?B?ZVc2N2F6Q2VZK3lWWjhhd1lNa0cybUM2MzBEQWtTc0J2RVdmU2dIbFkwcmE5?=
 =?utf-8?B?bXI0RGNPZEhSWXJadU9SOWNEaUR6OEJsLzFKSnZJaDFGb3hTZElZZ2FUWXlZ?=
 =?utf-8?B?ajNCQ2VaR0JkWVFKT1FZQ2NEOWxXckR1a0g4SzZKRk53clJ6OGdsbDZ3dDJv?=
 =?utf-8?B?TlBMQ0dvYXVrT0swdWhIbmRiRzJOWkU5dXhpcVVzK0JsZXhqdkMrSE45TmRT?=
 =?utf-8?B?bkRGRjM5VFBVaDJhKzZTbHpuamtBSWwxckVKSlBqN01YRUJDUjgzenBmbHVk?=
 =?utf-8?B?SThTc2ZwTHd3bXZ3clRUSlF3eGFQR1JiRFBiMFJTMUxFNzF5QjBFKzFWb1A4?=
 =?utf-8?B?ZVNzYlJkQVg3YXVKYitqVDhDTHBiWDRJQmJ6cVIvb0tWY0tYTUU0bTVYc1Z1?=
 =?utf-8?B?eVErWlBYcGsyLzYyVTVxL2JOSmg1RnJya0J2NjJ2NkFRd0txUjVUeWJVYkJz?=
 =?utf-8?B?QXVVbUM3NE8wcUNLcTVlM2hHTzRhcGQ2YUFjbFdteXAyVmp3Smd3Uk95T2RV?=
 =?utf-8?B?RzlycVdReWZrU25qVlQxd1dXeE0zdU5qTW9kMFBJYVpmbEFmY1YxNkVYQ2lV?=
 =?utf-8?B?U3g3RUo0VkhqWmtnNm0vNzFJaGorRzBsWUhmM1NSQmtoWWpTWWRmdjZlK21C?=
 =?utf-8?B?Uk9OTDhNL25ES09nTDRuaEFjaDd3SVVzTXUvcnhpbDF6UG1LSDB1WDlPU1FS?=
 =?utf-8?B?NnU3anZiV2x1TUgrdkJpUUZkSXAzdEVJd2pMMVphUnVSdlFTQ2hNb3dCS1BL?=
 =?utf-8?B?VDRLd3pjNDFHeVRYeDJTOExpUmU1cTgydGcxV1ErMkJJRnJpOEhPSmE2UmNR?=
 =?utf-8?B?S1B4RzBwMVo2QmtUYzVZSkZkdXk0YWxpK2o3eHJoZUFmNkhJT25Ka25PVFlw?=
 =?utf-8?B?NmRyd1pHMFBXOEc1MWFzcDQ1VGM2Wll1blVNRVcvZytLSXhnWmlKcXVEdlBn?=
 =?utf-8?B?M3JnQ2d4dnIvdDhydjhLQUZSMjJ4TGtVbGgreExzcEJFMEVZSE5CV2t4ZU55?=
 =?utf-8?B?ZUZ2MEtOeDZjK3IyeWw2L3EyVm1mOVRZUkRBZ1ZRbDN0dkRjYnJTMG0vblQx?=
 =?utf-8?B?VllJYVF6NDJTZno4VFkrMExhNXlOVjlYSWtXQnJEaGFoREcwZ285Ui9MOGox?=
 =?utf-8?B?MGJTYitJb0t3UkFiNjlHOFZFVFBUN0JZVEVIaWxNNlVRRER1QlZHVWJPSzY4?=
 =?utf-8?B?NjN3RzYvWC9sUmxUcDNuTmJLbEZKNkVSUmVhZitUQW1taDN0SUs5NVdkM1Ji?=
 =?utf-8?B?V3IvWEtkRXUySVh5UWpibkFMdUJSRVlPNFZlRW9ZUDlUTXRCL21ueFRzY0NY?=
 =?utf-8?B?UkZ3QVpzTHAvb0pWajlyUjNsdUpkZW81SUtMdmVtSEZRL01OaHpjS1I4U05K?=
 =?utf-8?Q?tXczvzZnU5/+myO+ZDiH0xoAFkCCnwJb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmpSTzhMYnY3Vy92bm53NWRjS2dVd2srOUlJRi9rb0l4YjQzVFRXZlR1VjlI?=
 =?utf-8?B?aGtoVk9mdTB6ay9pNkxMTjFoWjVaeGNoM0FqdGtnNEIxaHZGdHNydlFFZ0tu?=
 =?utf-8?B?b0lvaU5LQ1dKdkpLK2xwVUp0UEh4R2tmS0JuYlRHZDYxMElIT1BCMG1zT05R?=
 =?utf-8?B?L2NGQThtaDlJbFdEUWZIcEVCUXB1Zmx5anpYdFhNa3gzdGZqM1gvU3dyNUQv?=
 =?utf-8?B?bTVJejd2dk9XS1g4Yndxb2sxcTdKb3Jka25iQjJtbDI4THBlMEVpOFdNNFRP?=
 =?utf-8?B?SVppUHNVSzJqOG1aclA2cFhYUThWVlpTTkV3ZmxVVkczWkxLSldiK0NGNGlj?=
 =?utf-8?B?cUpMWHFadnN6WTJWWkNIZWU4Sm9UK29wdzVSL1MzQ3drY3BISUZiY1Eya1J3?=
 =?utf-8?B?QkVTbnFPQzVIekUyem9lWTZ3dHAxN1AweC95bXY1MlVvcFdjOXovcDRTNGxR?=
 =?utf-8?B?OS91bEtUS2hQZWhYY3VRTXpIS1lQOW1sYjVORkFZWkpjT05ueDZJM012cThE?=
 =?utf-8?B?QlM4M2VHL08zQyt5V21kTjZRaS82OVlkTGtOQzVQYy9PNi9DV0xvdmcrRm5X?=
 =?utf-8?B?eUFvVjFuMDJDS3JIK3hCbXFTb3JiU1piOVVRdUlUdXo5c3RadlFBNXpBZy9j?=
 =?utf-8?B?aTJnYkhhMUo2ZFlIWTFpdHEvZ3ByT2o4T014TWVmWXljcUtTMHBacW5abGM4?=
 =?utf-8?B?WnFqYVFnbWR2VkNxRFhKcEhGdjJHSkFvaUc3VHFVZmU3cFdzZkloVklvR2NS?=
 =?utf-8?B?UFBHVldlb0k0czV5dkFLVXVtZDNhRWpFZWM1ZldqVW9NeXdBR3lqcXBERnFo?=
 =?utf-8?B?Wk1la3g2WFBCaXhRWVR5M1NGZkU2TEx3ZitoZk14N01ubThtYnNaL3lmUkd2?=
 =?utf-8?B?Sk5HRnUrZk9qMlBjaVhIUW9nOGdDVFY4SUZFWUhmUldpZVh3ZFhVY1E4bW5G?=
 =?utf-8?B?QzliU1Rnd051bnRPaHM1eWtDc0RGYThkTkdvcFN3VTM3Mk42OFFCd29RQ1Bp?=
 =?utf-8?B?N01NOWxleWpIYm5KcWtURE4zc1poQStLVDhab3VpNHZSVDUyaWplaksydmc1?=
 =?utf-8?B?dnc5b2FMdkZYSUk3dXVPUHhaT1FrQnV1bEYrT0pNaW5pMFpZcGJFRldQT2dP?=
 =?utf-8?B?UmdodkpvWnlOL04rNXkzcWVxZ3QraGdXMll6UHRSdkUyb2lMaXpzb29lSzBx?=
 =?utf-8?B?L0xuTms2aDZzYVNpVUcrQmE2cnFocjZLS0x4bmszczdWUXdjN2ZTQjZ6b3Fz?=
 =?utf-8?B?M0tTbDJwbVNKRG5pc1RRQlFTdHZxVmhNWFpaWUhNbXhUODNBZnBTR0Rrd0li?=
 =?utf-8?B?OFd5TzE5eVd5b3p4emhsK09rSXY3ZnlBQy9xQUExL01jVHB6ekl1aEs4bjRs?=
 =?utf-8?B?WjZLNENrdzVDVGg5Um9WelFpSEtJdFM1dFhwcGZBNTR5NlgyeXd3SEhkQmkz?=
 =?utf-8?B?akxHMXRoUkhBUE45eVRxS05wSmNPMW9DMVZSTi8wM3NqOHZKaUhjWjV4OEZN?=
 =?utf-8?B?NHJiNU9LQWM5ZnZ4QXgrNldxR3UzL3lBNXVPQ2VUTUhEMmNLRUZZemN3ZXc1?=
 =?utf-8?B?SkNXU3lUcUxCQUg0VmNzRW9tNHp0L2s2eDkzellhZE5Gcmg2YkhJWThTbmk5?=
 =?utf-8?B?YUsvK3I0L0xIcklDSjVGS1RJVTlUWk5vQkl1bndVUmRmVnFRRlZCYW9samVC?=
 =?utf-8?B?aEpZZUs5QjduWENVRjcvUUdmcG9WV0k0alZCdkYvTXVQSUhxOUxCZmNiS0Rk?=
 =?utf-8?B?Y3JLcGdWZ051N0VaVXNQZW9XMWZoTlhISXZVOHR6YVVSczZSMWF1dmsreHdW?=
 =?utf-8?B?cjc0ZmdvWkplaU13V080VWtkSG9ZYnl1VGs1MDUycVc2TGtQVnoweGk5OVpn?=
 =?utf-8?B?NHhxTVdVYmo4bGEyYmZHQ0p4MU51SkxNUWUxdkdLc1lxQ2lOVklsTnY5ZEpm?=
 =?utf-8?B?WFBnbklkUi9mV25qaEV4eDhyaWUyaitHVGRqQmw1NGQyUFY4WGhSY1N1YzFT?=
 =?utf-8?B?aDNmYllqZmpTSldvMms2bk5ZMFEyN1gxSjEzWjQ5MFpDSEZkTisrRXozNk04?=
 =?utf-8?B?a1AyQ2FDSzNKbVhJNWdXWTd6RFFtYzZ1N2ZETkd1MVhxY1ViRkJMN2tJTWZV?=
 =?utf-8?B?RU1jakJsdHhsR1YzY2RtYUR4YXlMb3BZbVRzYmdZQ00xTm1hdi84RHhPNitq?=
 =?utf-8?B?RFZCY0lPWEtFdzJKUGxUa0YvdUU2SFY3WDJPQWtkNXd5R2I0Q1hLb2NnRG9s?=
 =?utf-8?B?SXJIVnZ5Tk5xZFZtNnNiRWlxVXVWbVpoREVuanViS1hrK0tjbk5hbjlER1gz?=
 =?utf-8?B?bUhoTFQzUVRhYWZrbVh3emZtKzVscm1SMkt5MytTbVk4eGIvNkV1QT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fda608-b2d4-47c4-7c6c-08de4f2c3330
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 03:07:19.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tx3m4G+lEtafU2QCXc5L7zZtjaLFLbK3qxJJvm4f5ka8Tg1veo9UBqx07B+iAnnQ7LjXYInZqduP4nDatKmPYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6893

Hi Luiz
> [ EXTERNAL EMAIL ]
>
> Hi Yang,
>
> On Thu, Jan 8, 2026 at 1:03 AM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> PA sync HCI commands incorrectly use conn->conn_timeout, which defaults
>> to 20s and is too long. If the PA Sync Established event is not
>> received, the command remains pending and causes userspace timeouts.
> Im pretty sure this is impossible scenario with bluetooth-next, since
> 1. only one work can be running hci_le_pa_create_sync at time so
> HCI_EV_LE_PA_SYNC_ESTABLISHED cannot be outstanding 2. The
> conn->timeout shall be aligned with socket timeout so perhaps the
> problem is userspace is not setting the socket timeout correctly or
> something.


Well, I got it.

I noticed that BlueZ has a default setting for sync_time with the value 
BT_ISO_SYNC_TIMEOUT=0x07d0 /* 20 secs */.

I would like to know the rationale behind setting it to 20 seconds 
initially. This value seems a bit long to me. Can I directly change this 
value as:

BT_ISO_SYNC_TIMEOUT=0x00C8 /* 2 secs */

>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   net/bluetooth/hci_sync.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> index f04a90bce4a9..58292b01f062 100644
>> --- a/net/bluetooth/hci_sync.c
>> +++ b/net/bluetooth/hci_sync.c
>> @@ -7159,7 +7159,7 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
>>          if (conn->sid == HCI_SID_INVALID) {
>>                  err = __hci_cmd_sync_status_sk(hdev, HCI_OP_NOP, 0, NULL,
>>                                                 HCI_EV_LE_EXT_ADV_REPORT,
>> -                                              conn->conn_timeout, NULL);
>> +                                              HCI_CMD_TIMEOUT, NULL);
>>                  if (err == -ETIMEDOUT)
>>                          goto done;
>>          }
>> @@ -7187,7 +7187,7 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
>>          err = __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_PA_CREATE_SYNC,
>>                                         sizeof(cp), &cp,
>>                                         HCI_EV_LE_PA_SYNC_ESTABLISHED,
>> -                                      conn->conn_timeout, NULL);
>> +                                      HCI_CMD_TIMEOUT, NULL);
>>          if (err == -ETIMEDOUT)
>>                  __hci_cmd_sync_status(hdev, HCI_OP_LE_PA_CREATE_SYNC_CANCEL,
>>                                        0, NULL, HCI_CMD_TIMEOUT);
>>
>> ---
>> base-commit: bdb9aba465a85122bcba01a6154e237b9843e25b
>> change-id: 20260108-pa_sync_cmd_timeout-ff46f67b5d2a
>>
>> Best regards,
>> --
>> Yang Li <yang.li@amlogic.com>
>>
>>
>
> --
> Luiz Augusto von Dentz
