Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286C1D47BD
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157559; cv=fail; b=HabtMGXneKNlTcK/deJUjXBrQfsNt3/7rQ5h0PhtApnTzQqQUMcGmBy5C1awJpOC7CK4kMm2ypi704S4f3jPc0ZpGXITHQG2i+T7NKjQoDdr3095pwsXxdNE82HZcn440PkY3fO+LwenClDlWW2kudfxl2/1nlDtDtWELaltQMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157559; c=relaxed/simple;
	bh=FlLqWFV1BNqMMi3KvnPLM+KBpej2TwZVKREMmlQKLaY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U9jnfjjgChn9ICmC5+Vil0LuQBzy5XP91PD89q88bd7zGcP3SsY3zholy80QF0eZiVUEgCYy3t3weVwzVLzsAjmjhueyf+62scWNnP5+0Ri03jMDKxc9xHEFEsuBr7Hk73qTnY+pC1b9Mb3t3oALR5sWF7UUNe0rOQU3XScPyWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Vk7ts8Ov; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=K7YTWCtO; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Vk7ts8Ov";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="K7YTWCtO"
X-UUID: bbc7b2f08c6a11efbd192953cf12861f-20241017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=FlLqWFV1BNqMMi3KvnPLM+KBpej2TwZVKREMmlQKLaY=;
	b=Vk7ts8OvdYBTOjuwkctI5PbxScoNaDcL/MRQ7VKjdDGywfXocZzUnLlmCITWOoQyjn5c4F1QmeO/XwWu01YdNrLWDf7lV8l+j0aM0O6KWRPz/50j428Cu/cl7B+uwCC+ytgxH8AFgVVF9V5nBkRXWEZcbXjUeKZ6jTML4iKADgo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:c8a91309-775b-4385-b30a-84b2c3aa22d9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:bb1af006-3d5c-41f6-8d90-a8be388b5b5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: bbc7b2f08c6a11efbd192953cf12861f-20241017
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 3185257; Thu, 17 Oct 2024 17:32:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 17 Oct 2024 17:32:30 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 17 Oct 2024 17:32:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQSXqgSO3sCyd1TtP+4J3L06uRrB7ir43vtEZDzTBB7G3DSUlMo1f5vUmITIl1fNCqnVB3kJNinKlH2d2nK8gjnhqD7sVhbE71GY/5Ps7Q1cv7+qONrh+nQ27K0pLHY9QaZ7uTtBTEwZkHTHSL1Ek34D1sPcETa2aX8X/Xtod4DJ5idN5WHU8SifmBNAbgdfMcOo07ns0+mHbavrPPiQpuHeEFDFOni/fG+yHQxk6qKe7bHyZ/BmN0VuGa3Mpd4YUa4vKB7UNMpjD9Rh4WZ3azdiubKC6QkBlju4TYBQSWnQg91YYDcPEwbEmRA1iTRQKMRQEfw075Xd2OjgZRsJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlLqWFV1BNqMMi3KvnPLM+KBpej2TwZVKREMmlQKLaY=;
 b=xDjJV5RmofFRWZqmMlIibAfNQXTERkO7rpmFHYVpP0ohV7LC4innq6cM08lL/iPyf5lVHgA/zBVEcR5lSG1m+fZW0yncA7WRI33eoCQBeDbforiVXPimcaVHZ1hFVzAcR7Nmxzdom5H3w1hTjC+9a/F70GhHpgH/tMp6x5FZu5qgBc2fZTNexsIsojYmWH/GcvsN41GxFsFT34/VbQ9sI3cisMyfDUccWG95W+ZobnzVDnKLUqp+KkXdOeRIKw+ulEbxDIAC9AsFWd9gOmSyWfbg1VgpAe7ONbRtQu0OnRJkniF1Tlc/MB2sihVSrKYf+fMp+pXux7yYyolAJ/+Pdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlLqWFV1BNqMMi3KvnPLM+KBpej2TwZVKREMmlQKLaY=;
 b=K7YTWCtOdqaOrN4+2O0uz3MXjwTevoBku8KGf8q9Y160NYkPeXj8WibjwifO+THQG7Uw5acOJIYV9gpAU/LJp33gFWvbir/6+vaIn0RKCXuvPDvj/ZOoReN/OI7Esvai4jN2RZiRysR5XEcXxdo87TICWgndZTs0v2WxJjw6JeE=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by PUZPR03MB6887.apcprd03.prod.outlook.com (2603:1096:301:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 09:32:28 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf%6]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 09:32:27 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "aprilgrimoire@gmail.com"
	<aprilgrimoire@gmail.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	=?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?= <Aaron.Hou@mediatek.com>
Subject: Re: Bluetooth not working on 13d3:3585 IMC Networks Wireless_Device
Thread-Topic: Bluetooth not working on 13d3:3585 IMC Networks Wireless_Device
Thread-Index: AQHbH/7OgLqpYHXoxUWml53o6U+vQrKKrvYA
Date: Thu, 17 Oct 2024 09:32:27 +0000
Message-ID: <95cafaf747109364da5bd5957a56159e052bc0db.camel@mediatek.com>
References: <CAAhaqxrW=0g9E2qWdEXTGkjv5cxZLAu-6UGDO5tGLxZDdQXvJg@mail.gmail.com>
	 <CABBYNZKu465GRDOCGepyckgrk4CZF4tOwbzUN6HQyG8ZKfg=8w@mail.gmail.com>
	 <CABBYNZ+pYGDBUWg1=+X8JiHVeTHe4rZM20ckTixpGW6bLsnaBw@mail.gmail.com>
In-Reply-To: <CABBYNZ+pYGDBUWg1=+X8JiHVeTHe4rZM20ckTixpGW6bLsnaBw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|PUZPR03MB6887:EE_
x-ms-office365-filtering-correlation-id: 034dd28e-570a-4496-1e71-08dcee8e9db5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eWJMOEJlZ05paGhzWmlOeGVTQmV4OEFXUHhRMEkyR3RiYWw2VVdQblJkOTJX?=
 =?utf-8?B?Y25VR1NSVS83a3VPSmNJWEg5ZEVwOGg5eFZKbzQzbUhXV1JIR01EWXFWemg5?=
 =?utf-8?B?MTJsdFF4OEpWblRWeDQvUUk0YkNNZUc1bTlIYVZNYmNNUkdybzZjdmNnWWhw?=
 =?utf-8?B?eFVOQ1RvMysvaUFvSWNUUnNuV0R5MzAxcTdpU0ZDWXdjWDRSdXJEelBRYmo4?=
 =?utf-8?B?d0ZvYU1sZ3Z4UitwV3RVOCtleEYzN1UvR0VheG42TExMUWkzdzVkWDY3ZkVp?=
 =?utf-8?B?eXdBeWdHU1Z6ekNLaG41RmwvWEI3SlkxZGFQRzRmV09UMndBa0RKbS85N3BK?=
 =?utf-8?B?UHptaC8zY0RQOWNubHpSdUJkdnRNUmtXM1VVK0JyUWM2RlowaGp2WEF6SHBU?=
 =?utf-8?B?R0k2NTdqV20rdXU1M0JvMUZoS1dSdDdSakpNbW9obVUxQmV6Zm9qcWdXTzl0?=
 =?utf-8?B?QnVCK2J1b2tXRmhXTUVwWk9kV3MwWWxLWDhIbGdodythTGtGS2pzZUpyZk91?=
 =?utf-8?B?VHN3TFF1cUF2alFPbm1IQ3JMK01haTlmRC9Kc1dYZ3R6Uk14aVBGelRsdEZ4?=
 =?utf-8?B?bm4yd3RGOEFEOFg4NWxqSldDSktmcXlPL1NQNlZmWHlCUWNjWWwxMUpvMjc4?=
 =?utf-8?B?M0xmaDh1bnFSNCtSd3FHdFJHT2VzVHhmRVpZZm9MNVBpVHlBeHZXWXI1aG55?=
 =?utf-8?B?UUNscklQa0w2bEhmZm43OWdxQmcwWEx3amc5L1dhS0p5Z2s3ZjJvTkdZV3c0?=
 =?utf-8?B?QkQzaVlSM1VSTWl5Y3ZNU21kRFpZSk5aaTJhWE5KUmJaMksvODlReEtVVkFi?=
 =?utf-8?B?cnpoaVlyOFAzR2p5YnJBZ1M2b0lyTS9XTE5VbDRURnJBS2daS3hPRng3bmlO?=
 =?utf-8?B?aDdqVXhpYkxnc2FaYmhEaGZyNmVIZHdOWlcycFI2WTd0MFBYQjRvR0dtOWFX?=
 =?utf-8?B?bzBjVXZPeTdtTmJyMGpGOXdrbnY2aUVDc09yUVgrNnBhWHl6YTJnMmoxSGF1?=
 =?utf-8?B?THpNODljdFZaUEhKV1BFb0VrcDlIaDdWczhDUlQ4NjFrWDdiZ294MzdDemh0?=
 =?utf-8?B?Ni9FSy81cHAydXpvNEJmcXVHUkc0ZTJ1K0sxQ2ovNUREOVhQanFjWHRyMHJS?=
 =?utf-8?B?WU9GQmcxbHFKMCtNV3Vnd2RDS2E2akNrdzhzL1JYdnUxM1FLcXF5VWovL3VP?=
 =?utf-8?B?VVhoM0JLMFRKa0V3Z0FxazBXOWVMMXhXOThxMUFHc3Zmc1BNWEhoV3hCZ1Q3?=
 =?utf-8?B?RnhSWHdFZW0zNWhlNTd6TDk0RjB2VGdkb2RhVW5VTWw4dUhsSEVZZVdkVWpx?=
 =?utf-8?B?UUxady9BZHh0c1lpMC9yVERJZ3BBTmMyczVDTTdTWmZrMzNYNi9RR1J6RkdZ?=
 =?utf-8?B?czJNTVErUytmU2xpb0FKSDZSUzdNSHcwS1hwQlJUanpBZXZHbDlvQ2l4S3F5?=
 =?utf-8?B?eUJETmxHQlFBemtOTm5ScnFvVXZudHAyUnpPemU0RnNPRkhXUGtteDZZaURk?=
 =?utf-8?B?NmIzdWVwT2Rwc2hHYldMQ1JMMytOYVorSFV0SjAyQURsR3B2Y09yMGFrbDNi?=
 =?utf-8?B?VExQQ2Z1ejBHbENGbzNCR1lxdXJaWFRwa3k1NEJMN3hUdlZRUGpUUWVWU1hO?=
 =?utf-8?B?MnNHZjRrd3pkNXNuQThYemRodm9BQTdOQnhOZUl6aUNUbk5WaGZtZEcxK0wv?=
 =?utf-8?B?MjRxc0R2RHRreFlMampZZFFFTmo3ckJhd3JIcS9mY3VwUUtHSnZQNkphZkEy?=
 =?utf-8?B?VURXUXZBenQ3YktjQVFrZlZTWVFHaHprb1dnU0kwSnVSUzI5K1EvMGlKeGdS?=
 =?utf-8?Q?lkd1Kue5DCBkoNQvtmEqKT1YLxLjRvmwAMBj4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDFmM01JcjIybTlRWUdvTVVjdThJMzh1SXdPS05WV3U1NENlcDF5UFhIUzRj?=
 =?utf-8?B?bDdsUVBtc0NTOEcreDJ3V2gwUlltY1g2V09IL2JXK0xlYjN1bmdwZlRQMVo5?=
 =?utf-8?B?bkhjL2lRS21yak9CN2NpVC9BSmcvRzlEMzErclhuSUtLL05NYTAvbXRVcHFv?=
 =?utf-8?B?a2JPWjZES1hSSUZOZmI4YnA1UndjWHFVQWFOVDNQdnJCSXhZNUFCREt0Zm5B?=
 =?utf-8?B?S0d2UTI4OFQwS3hkcTJJRkg5UktrN2lLK1dCVGlvQ21rY2toeWJUUUVacDhD?=
 =?utf-8?B?SDN3dzZnNVowaitPMTBnWThBdmxISzIxS2czeWE1eEhvajF1TWJEd0xlQ2Zo?=
 =?utf-8?B?Y05ZMlpWaG54b3RYbGdZS2lTZGlJNXRLZXVpVlh3SUpTMGg5QXp1WXJaYTM5?=
 =?utf-8?B?c1lYZ1B4RHdNYXJMc3BBYWRjOFdrbzI4a0ZPMVFsSVBWZ3M1eHgxLzdIRXls?=
 =?utf-8?B?Zy90cUhQTVpYVXhEemtnMzdaL21nR2o1a1h3bVBjZ3BBUDhETlhmMEN0WTBS?=
 =?utf-8?B?VHNYY2MvVXlWbCt1ZVFURnhVVGlCaUhjOGdtNXRGaXFoMkpwNWgyNTZoSVlC?=
 =?utf-8?B?NGs2M2hVWXE3UGxNblZveWFDYkNncWVWYW9kY0pUZEpxNFJWNzFJTzRmUUxD?=
 =?utf-8?B?eDRIeHFjaEdaL0RJaW9xT1IvZ0FaYXdRQVFlZ2swdWVocjg3VDVnbXNxTWdL?=
 =?utf-8?B?VGdXSEZiaHF5NzhwWHFsand4ekh4dDd4SGVQWEU2TTE4ZDU4WlpjZStaN2N3?=
 =?utf-8?B?eWsrWFdjcFZOQnc2bjMwdUEvdVNXK3RqU1UwVzZucmpUREw4c0lSUkNqa0dS?=
 =?utf-8?B?OXp0VHpLSXZsczhnK1ZzVm9Gc3F3Rzl6Q0c4VW16TXA4VCtOSnlXUHJWbEVJ?=
 =?utf-8?B?R1F6M3EvU2tmUVJrMTRsRTBNdHRCN0R1NWVLbU5xVkdPN0VXbERrSCs0Z25o?=
 =?utf-8?B?V1RKeGRod2tteE5KcysvVDZ5UnEvSHpyOWFZN0ptT1BPcktRK3V5VDVUYUdC?=
 =?utf-8?B?N3Q5Y1diTXZBbFMvdjZmZ3o2VHh5c0kzMFU4akxoYmsvWEhpUWNNWFJGSklW?=
 =?utf-8?B?ckNCNnUrNE9lamFVZGxXRVpZYWUyenRJZkdmdGxEZC83QitsVFZwdlFRVEh1?=
 =?utf-8?B?NjJJWlB3dDRsa29BRXhJaWMrTVU4ZlV5SnVuRjlqUDRTVldZWkllVXJ1cmlE?=
 =?utf-8?B?cGNPc3FuK0V5anpRcEsyUEhteVlKUDFITWcwbU94RGFJT3pOSEtxSVVLTVpa?=
 =?utf-8?B?NTlGMGEvaGNvRjhINmxoQUVXSTRhZWRjei9ObzRucWFZRUlSRWNQN0RYQ21k?=
 =?utf-8?B?dFBKSk9pekI5aUFpZmVjMkdBOWV5czV1ekN3N2tjYUR0M0V5TDgyc0htRDNk?=
 =?utf-8?B?RUJUczZIS3FXRitaV3lKU1BucGZWT2R2c2R2MVBHczlOQmNPbFNXOHFHQ0s4?=
 =?utf-8?B?alU5ZTFncWtCN0VqNzhNbldBdWErT01ZUVpzMDVXeFNHdVY1TTJ6cDJzSkYx?=
 =?utf-8?B?cWlqWnQ0OU90ZGdiWVQ1NlJMY1VFbVRac090aU1nbUxZdlJjNjZFZnk2Y0do?=
 =?utf-8?B?YTcvMDJWeGJUYjFpNytodVVVZENiQXNBYUtNdFFEb1NETXdwUmd3MmNsWmls?=
 =?utf-8?B?SmRPUnkzeC9rOFg3U2djRGF3eXd2Nkp6SXdWU0Zqb01rdDFiMjFIL1VwV2lZ?=
 =?utf-8?B?T3BRMU1JTFl0Vy9IWnZiQ282WDA0ZE41NVlJSFdrZGNaNCtSTEhpN0RIZitr?=
 =?utf-8?B?ekJod3NIS1lQdEVxUGFDSkFuZnVUb3Q4TUdmQlVDbFcwOVc4aEpIYmlYeVJt?=
 =?utf-8?B?RTgwVFB6Vld4T0FLWVlsOW1EM1BWVnptOVNvbWFyRXhzUDlUTURlVFJ4dk1D?=
 =?utf-8?B?a25DeGRFNlRVa0dsbWFIK2I2Qy9aZW56b3p4RisxR2wxYjJReDRaMHNYVnB2?=
 =?utf-8?B?Y042SlZTOE5CTzdqalpvdGdZcFJ6UE1rK1RqcGxSaWhNRUZlT3ZNSWFBc2Vn?=
 =?utf-8?B?RVpRNEpBNG1SaWM5TlZVVkoyN082ekhrL0trKzhjYW9keHZpSzBkUDJJWXdr?=
 =?utf-8?B?cStZSTRqMGs4UjlOTjltS1JSVTBrV1E4THNiMHNMR0ZvL2svc21hNitHRmhG?=
 =?utf-8?B?SDRJZHlhdlBYMW9ic1hKRjNJUXdpUmdZQ2NvanVKN0c1OUkzL3M5aTVKZnBQ?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <292739688B403540989B320D5974B810@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034dd28e-570a-4496-1e71-08dcee8e9db5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 09:32:27.8331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SWytyXdDU5ueaPQzPzEBgR7pHwlG7VXPV6aYqRZdLnpahmQOVZBSYbP2QrcOZPojqbXBgF0T1A8x0pDXCCl4+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6887

SGkgTHVpeiwNCg0KT24gV2VkLCAyMDI0LTEwLTE2IGF0IDE1OjA4IC0wNDAwLCBMdWl6IEF1Z3Vz
dG8gdm9uIERlbnR6IHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVy
aWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEhpIENocmlzLA0KPiANCj4gT24g
V2VkLCBPY3QgMTYsIDIwMjQgYXQgMjo1MeKAr1BNIEx1aXogQXVndXN0byB2b24gRGVudHoNCj4g
PGx1aXouZGVudHpAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIEdyaW1vaXJlLA0KPiA+
DQo+ID4gT24gV2VkLCBPY3QgMTYsIDIwMjQgYXQgMzoyOOKAr0FNIEdyaW1vaXJlIEFwcmlsIDwN
Cj4gYXByaWxncmltb2lyZUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEhpLiBJIGhh
dmUgYSBsYXB0b3Agd2l0aCBhbiBpbnRlZ3JhdGVkIGJsdWV0b290aCBhZGFwdG9yDQo+IHJlY29n
bml6ZWQgYXMNCj4gPiA+IGEgdXNiIGRldmljZS4gSG93ZXZlciwgaXQgZmFpbHMgdG8gaW5pdGlh
bGl6ZSBwcm9wZXJseS4gU2VhcmNoaW5nDQo+IGZvcg0KPiA+ID4gb3RoZXIgaW5zdGFuY2VzIG9u
IGJ1Z3ppbGxhLCBpdCBzZWVtcyBvdGhlcnMgaGFkIHN1Y2Nlc3Mgd2l0aA0KPiA+ID4gMTNkMzoz
NTg1IGFkYXB0b3JzLg0KPiA+ID4NCj4gPiA+IChiYXNlKSDinpwgIH4gc3VkbyBkbWVzZyB8IGdy
ZXAgQmx1ZXRvb3RoDQo+ID4gPiBbICAgIDAuNDIyMjQ0XSBCbHVldG9vdGg6IENvcmUgdmVyIDIu
MjINCj4gPiA+IFsgICAgMC40MjIyNTRdIEJsdWV0b290aDogSENJIGRldmljZSBhbmQgY29ubmVj
dGlvbiBtYW5hZ2VyDQo+IGluaXRpYWxpemVkDQo+ID4gPiBbICAgIDAuNDIyMjU3XSBCbHVldG9v
dGg6IEhDSSBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQNCj4gPiA+IFsgICAgMC40MjIyNjFdIEJs
dWV0b290aDogTDJDQVAgc29ja2V0IGxheWVyIGluaXRpYWxpemVkDQo+ID4gPiBbICAgIDAuNDIy
MjY1XSBCbHVldG9vdGg6IFNDTyBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQNCj4gPiA+IFsgICAg
MC41MzAwNTJdIEJsdWV0b290aDogSENJIFVBUlQgZHJpdmVyIHZlciAyLjMNCj4gPiA+IFsgICAg
MC41MzUzNDZdIEJsdWV0b290aDogSElEUCAoSHVtYW4gSW50ZXJmYWNlIEVtdWxhdGlvbikgdmVy
DQo+IDEuMg0KPiA+ID4gWyAgICAwLjUzNTM1NV0gQmx1ZXRvb3RoOiBISURQIHNvY2tldCBsYXll
ciBpbml0aWFsaXplZA0KPiA+ID4gWyAgICAzLjU1NjA2OF0gQmx1ZXRvb3RoOiBoY2kwOiBPcGNv
ZGUgMHgwYzAzIGZhaWxlZDogLTExMA0KPiA+ID4NCj4gPiA+IGh0dHBzOi8vYnVnemlsbGEua2Vy
bmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE4NDcyDQo+ID4gPg0KPiA+ID4gSSB1cGRhdGVkIHRv
IDYuMTEuMSBhbmQgdGhlIGlzc3VlIHBlcnNpc3RzLg0KPiA+DQo+ID4gV2VsbCBpdCBsb29rcyBs
aWtlIHRoZSByZXNldCBjb21tYW5kIGlzIHRpbWluZyBvdXQsIGJ1dCB0aGUgaXNzdWUNCj4gd2Fz
DQo+ID4gb3JpZ2luYWxseSB0aGUgUElEOlZJRCB3YXMgbm90IHN1cHBvcnRlZCBpbiBidHVzYiBz
byBwZXJoYXBzDQo+IHNvbWV0aGluZw0KPiA+IGVsc2UgaXMgaGFwcGVuaW5nLCBwZXJoYXBzIGFu
b3RoZXIgbWFudWZhY3R1cmVyIHRoYXQgZG9uJ3Qgc3VwcG9ydA0KPiA+IHNob3J0LXRyYW5zZmVy
IHdoaWNoIHdhcyBpbnRyb2R1Y2VkIGJ5IDdiMDU5MzMzNDBmNCAoIkJsdWV0b290aDoNCj4gPiBi
dHVzYjogRml4IG5vdCBoYW5kbGluZyBaUEwvc2hvcnQtdHJhbnNmZXIiKSBzbyB0cnkgcmV2ZXJ0
aW5nIHRoYXQNCj4gdG8NCj4gPiBzZWUgaWYgaXQgaGVscHMuDQo+IA0KPiBTZWVtcyB0aGlzIGFw
cGVhcnMgdG8gYmUgYSBNZWRpYXRlayBjaGlwIGFyZSB5b3UgZ3V5cyBhYmxlIHRvIHZlcmlmeQ0K
PiB0aGUgYWJvdmUgY2hhbmdlIGRvZXNuJ3QgYnJlYWsgd2l0aCB5b3VyIGNvbnRyb2xsZXJzPw0K
PiANCg0KSSd2ZSBhcHBsaWVkIHRoaXMgY2hhbmdlIG1hbnVhbGx5IG9uIENocm9tZU9TKGtlcm5l
bCB2Ni42KSBhbmQgVWJ1bnR1DQpQQyhrZXJuZWwgdjYuMTEpIHRvZGF5LiBNVDc5MjEgQmx1ZXRv
b3RoIGlzIGFibGUgdG8gd29yayBvbiBib3RoDQpwbGF0Zm9ybXMuIEkgdGhpbmsgdGhpcyBjaGFu
Z2UgaXMgZmluZSB0byBNZWRpYVRlaydzIGJsdWV0b290aA0Kc29sdXRpb24uDQoNClRoZSBidWd6
aWxsYSBpc3N1ZSBhYm92ZSB3YXMgYWxyZWFkeSBiZWVuIHJlc29sdmVkIGluIHRoZSBsYXRlc3Qg
a2VybmVsDQpieSBhZGRpbmcgUElEL1ZJRC4gRG8geW91IGhhdmUgb3RoZXIgbG9ncyBpZiBNZWRp
YVRlaydzIGJsdWV0b290aCBpcw0Kc3RpbGwgbm90IGFibGUgdG8gYnJpbmcgdXA/DQo+ID4NCj4g
PiA+IFRoYW5rIHlvdS4NCj4gPiA+DQo+ID4NCj4gPg0KPiA+IC0tDQo+ID4gTHVpeiBBdWd1c3Rv
IHZvbiBEZW50eg0KPiANCj4gDQo+IA0KVGhhbmsgeW91Lg0KDQpDaHJpcyBMdQ0KDQo=
