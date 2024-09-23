Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F283032A;
	Mon, 23 Sep 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081218; cv=fail; b=stZ0JOX6y6Jgk/8m0IhoZXnqoRyPxneDXwoTk0ud5A1zKRhxBGZlj2n/HUY3ld6OUMjM7Fs5+TUwZrAdcSpYfKE6z5B6z9cy9POgwsZVQuyM16yedEbEMo5T88D5gpQxGQcRFkveKUz64i7VoNt0NLxOmkNyr/XZyPlUB7O+HKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081218; c=relaxed/simple;
	bh=rnQD45a+6+HxTNfr80AYnFeP1gBPpUfbxjsbpL5awd8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jhnyCE2r0vUSWpE6b73KcaKDeG9lcliioNph6h5wlZ0C62hMX+fdRMdHFW3V6wFHAzWmN62tvP/U2CrnAW9FXU+rhaOJqcV9umYH/kBz7ps6CaebWD83h/yFfHhuSnRj1fen8qB0AZHH0Hq6jZ6neH8UXC4si73QLMLVvQPHSEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=K6g8IUzg; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dqrSPh3E; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="K6g8IUzg";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dqrSPh3E"
X-UUID: 603cea1c798811efb66947d174671e26-20240923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=rnQD45a+6+HxTNfr80AYnFeP1gBPpUfbxjsbpL5awd8=;
	b=K6g8IUzg6cOhJjBJod9yI84M27CNxYMkTwmdmZIOVzd4zcl5xBIW51xw0F8dWo6pRALM5qHHscR5ImjPci1ZO4P/A3IVlCVv75sM4SzjJ2Uchrc0K80TiUMY44Y3Psy++RIK4J8pLn+1ufAOJjCL0+zux1qS4MY3pkoTJ87Q/0Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:7146975b-911c-4354-86d2-0c490d99707e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:ab1e9ed0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 603cea1c798811efb66947d174671e26-20240923
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1587612033; Mon, 23 Sep 2024 16:46:50 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Sep 2024 16:46:49 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Sep 2024 16:46:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+SLQORWMJtfLWUPVTfFEHWbFpZ2UWLGHRjBD4V7l7nO/+uYYwlMcLdZfx2kdR+pHNmjnZCvq9JlupQr/mv4diY+l8XUZx57dPow8u1jwZWadu3bBEtbVzrf9t2QYlwDE7QP5TDnTg+b226L5CBZBtBm3s5MQPrCJbuJtEK7hJoL+XflngxXQwPBmyCzMjWGHd6gWB2AwltSLyi3IchZ6NS2d1HXNSBujwWoq/BXnvmBWkONK8HQA7XYBp54Ou1AxNlOZ9mWU9kf9BtaYJ+T4XMzz0EpTTQvevZJXZOHE7I9IAJzYYHe6Bg5IdjKLQ208ScE4P5Wyxh3KpSXDW1lNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnQD45a+6+HxTNfr80AYnFeP1gBPpUfbxjsbpL5awd8=;
 b=SWV9EJh+sfE1s2aUpro6c6Rbmnew4C1NEh75SnyWrack8PTy2gVK7kbo5MmA0QkmjkixSd9IACN4vUB5Zf5wyOQD/qGfq9FfyqTM6qW6DU+hDAHPH9OKS4TKkFG1bbQbHdD8L+TV69IK+3bDenk6ZtEw4CXxtVAn6hnneZoZgYrPOYuyFBbE7CCN+9rxRjgo8EgHCkcpgPHtu37aQ0w9E3GxkDm+xAJUPlPEeplVPC6cOe/aFTC5rDJYc3tDVvNIHzX1SiFD6c9ajI92mZjBK4I9NZ6OzdpFiqEdICsw7krTohWsmX1sPs5k0OQ2N3TDxQvwmUT+2u2yktJZ6vgooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnQD45a+6+HxTNfr80AYnFeP1gBPpUfbxjsbpL5awd8=;
 b=dqrSPh3Ec4TuBEflXZernWQ9Z1jXpqtmqSjqk1RonsCchQCT0ebQqpvmNihrFSYDCujMM6joBhVGWZ2iI0YrlmaMrwmNstaszKnaYR3jb5iyMLNC5I6XlRfeup2HzxmB4dPE1qMOMt6R16u+Sav9jJAHpTQ0J5J76IpL/wh/ydk=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by TYSPR03MB8720.apcprd03.prod.outlook.com (2603:1096:405:91::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 08:46:47 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 08:46:47 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	=?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>, Sean Wang
	<Sean.Wang@mediatek.com>, =?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?=
	<Aaron.Hou@mediatek.com>
Subject: Re: [PATCH v2 3/4] Bluetooth: btusb: mediatek: add intf release flow
 when usb disconnect
Thread-Topic: [PATCH v2 3/4] Bluetooth: btusb: mediatek: add intf release flow
 when usb disconnect
Thread-Index: AQHbCmh36F6qoVjFHEaQl5VIyQjxvbJgxUcAgARQJYA=
Date: Mon, 23 Sep 2024 08:46:47 +0000
Message-ID: <24753c7a74fad98d6a7a0f6a032add50f829493f.camel@mediatek.com>
References: <20240919074925.22860-1-chris.lu@mediatek.com>
	 <20240919074925.22860-4-chris.lu@mediatek.com>
	 <CABBYNZJ62dw0JHTrNK7xe9_kO61_gH9+XGPm+UEWw4CGRVCnnQ@mail.gmail.com>
In-Reply-To: <CABBYNZJ62dw0JHTrNK7xe9_kO61_gH9+XGPm+UEWw4CGRVCnnQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|TYSPR03MB8720:EE_
x-ms-office365-filtering-correlation-id: 550893bd-03db-41fd-6033-08dcdbac4227
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b3JoMC9qejZkNFJKaXZicjV0RUs2b0hHM2c5WU4yTitGejY5ZkMzVWpwSFV4?=
 =?utf-8?B?Y3owK3I1OE1JV3c1eGVjUE84TEx1ZlVWZ0ZFT2pncW43T2Zmc21tNUtkVTFn?=
 =?utf-8?B?NEdUZ3d0Y0RJSXBTL1A4eHpVQlpKYTl2cVRCQjA1UHJSdE9UMG84cnBadGxB?=
 =?utf-8?B?c2JDLzE4Nkd0REJwaTVpQ2FoTUI3bW05d1cyaCs0UWtqWDJUZHRLNk9adFVi?=
 =?utf-8?B?YnhnckFiWStGMVBXYUNXQXgvdllkcWNqWU80MWJxdXEvMmJSemFlQjBFaWdQ?=
 =?utf-8?B?R1krRnp3S0cvQWlkWHUvVTRTY0lVRFZhb3VlOSt2ZmlndlhNSFZ2ZEVmMG80?=
 =?utf-8?B?Qis2cUZsRDdiZERWYktDNjFDc0dqOU9kREpwRGVQZnBuMERNQTBFMTJzRzJm?=
 =?utf-8?B?RzZrWDBCaDV6N0ZoZTNWQUVqMURXcncvZmNGTERyMmEyM0Rnc0FGRHlHUUlF?=
 =?utf-8?B?VnE0Y0NtYUJsVFh5RmM1TzlyOEFUUXlocnJ5Z0l0YUpZYTRma2c5VGp0OC96?=
 =?utf-8?B?UlNZV0hVallYU01WNkZnbHB1MGswSGpncFhiam01NkNlWjF6L3JqbnhTZVFk?=
 =?utf-8?B?Wk45Uk5Vdm0zNmw3NzVjQ3owNnZZLy9pR3A2ejMxaDhrN3BselhUb0daUnFO?=
 =?utf-8?B?Mndjd2JXN2lNSlZkeUYwU3ZTVUkwdXBLbWhROWNjQWFuS1JRM2xkU1NINGJz?=
 =?utf-8?B?L1c5WmZpR1RFNnlDZklHSEZLOFZFQS9uZVNaOGxpMlBUSURTUFJPTmNpWDVJ?=
 =?utf-8?B?YmlNZVlrajVXbCs4QjFacUU1bGRmR3Y4aVZWUUlYU2V5NytXNlMyeHZnUThS?=
 =?utf-8?B?aStkZWxFZ2M3eWVZdklkUFZndWp2S1FzQ0NSWHVid0RDbWJRSFM3dU9OVk9h?=
 =?utf-8?B?THovOWw1dXpLNzh1NDE0OVpScmdSTHZraW9PNXFnQjlqZnprWWZYcGgyV1RX?=
 =?utf-8?B?UW9jNHhvMUVkUEZuVDhzTUQyVWFneFZ2Uno1TEZrWjV6TUg3dXlCc3RIaEE0?=
 =?utf-8?B?N0xLaDYycU9FZjBaL2xEcHB0Zm5WZEpFdjU2M3Z4NkYwTm0vSXBWWTdsRjhs?=
 =?utf-8?B?MldvNGdiZ001K05vc1Q5ZUhnYmdZbTc4dzVORm1HaThaL3lxRjNVTDBoWWlZ?=
 =?utf-8?B?cXRYd1VhaG9pMFIxU2lObHVKa2M3VmNleW9kcndXUXV4OHNNcHk5TnB0SVNy?=
 =?utf-8?B?S2EvRU1DWG5Sa2o4WGhDeDFrbnpLclRSRFVLS2c4c3MrRG14NkMvajJXbm9N?=
 =?utf-8?B?ZGhDcjA1UkhVWjVYN1RHaFBKM1dONzZPNndWaGtwU0FTR3lpZWpFYThIYkQ0?=
 =?utf-8?B?c25lU2RHNG12Rm5RUmxwdnpGdjVWVHBpb1dwSVNZQ2pIc2Y0VE5jOE5CM3JN?=
 =?utf-8?B?WHJsbk1SVFR6YU5aRXhLV3RLdER2MFREUGdKeisxU0QvSGI0WTFFVmlsWDRV?=
 =?utf-8?B?clNVb3VPN3doSDh4T3RRekQ1Mmgvb0FsZE9iTWhJNTNySnBZZXNVbjNRRUdR?=
 =?utf-8?B?S2tuZ2I0bTlDZ1ZHRkVwNks2ZHFKay9tc0E2dkF6bzBrZnZ4RXJKVjNwYjE4?=
 =?utf-8?B?aVdabmlCWkhMemZDOWRncmlqWThEVGJOVGtLQ2p5MWpZSURSbWJ2c2hUTGph?=
 =?utf-8?B?b0lHSGlsVzhiNU5QTjNvVGdwZnBaOVhxalRoVnNBTDYvc3VDa050K1NxTW9n?=
 =?utf-8?B?eFZ1aW8vem5sZXBPQ2J5RnhVR2Q5aTFpY1NnT3RNWFJXaUorZlJlWDBjVWo5?=
 =?utf-8?B?SERmQzFFQXZscm5vR2VlT29Ga1Y3Vk5oYktTdFpHTllFMjdHRGFncllRaWdN?=
 =?utf-8?B?MU1EN2ZhUk9pNUcxYVUzdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUZpOEFNZHRhQUEwRnNHbVR4ZGM1cW82UThwdTRpL21sMUJOL1lScXRRQi9L?=
 =?utf-8?B?UUtIZ2s3b29zODQvWU1YUzR4emRxMXpRbVI3T3QzbWFrNEtBZW42WXdTSU5R?=
 =?utf-8?B?LytaM1lHS25yN2ViQjdKQWllU1p3K004NFhJZWFaRjVrSkNjL01hS0tOdDIz?=
 =?utf-8?B?QW5QNHpvaUdCazVKc1M4N2VxbkJkbURSRVVRbVl6NTVJaVdaTCt1bzQ3QXRU?=
 =?utf-8?B?NGxHVnhBVStrQ2hKMGhlQkIvT2dDaWlLQU1ESmxJNTQzd1I2ZnJ0cnU0MDRi?=
 =?utf-8?B?M2Q2ZHNHTk9DNmJNMDdIVDNyQkptam9ia2UzMGY1bW5pbmNQVmtJQXI4SWc0?=
 =?utf-8?B?L1NrOVczblNqNkszM1FLakhPNUdMTHJvRVc0SG9wZVNuNmU0TmF3ZlpvQVlR?=
 =?utf-8?B?R1krV0VKY1ZXbDZhOWtNWjN3b0kzeGIvUktCRFlJZWZDK0FhVDZTY0FtYksx?=
 =?utf-8?B?M0ZXZmNqSU1WWHluMVU1cC83NTVRZnVqNjBPNXZRam5kQXprdGNXdHU4Z3Jj?=
 =?utf-8?B?aElOanlPc2FNemVZTDNSaE4wZDRPQ3Nub2tJWU9Sek8wZUVESGEzbjV1VVBo?=
 =?utf-8?B?ekFHakNkL3p4RE04dCs1bzVMYUdhaTVnMjd4VFQvN0tUQUY5V3RpQzEvWGU4?=
 =?utf-8?B?THRIMmIyU2NqOVpXa2t3YkxnMnZQQklwWS9memtnRHo4N3FJcDZLVFFGalpB?=
 =?utf-8?B?czNGYytxQTVSRjBzMENnOS9SS3M5TEpvSkgvZ29Gcm5QWGVkd1ZqcUVST2dV?=
 =?utf-8?B?VGdYVURaRFRKOVdtWE1TbUVsengwMzU3VjNUOUdwNFVSaHNqZjFzV0lucmgy?=
 =?utf-8?B?VG9yRC9pZmdGOWtKd25XeVRldjNDUW9zQitzbnhueisyZ0FGZURGd2g0ZGth?=
 =?utf-8?B?aSs1dElFZk4wVlJ4b1VwZnhocytMbnhsQk5WdklwRGZxV3lBWG1iR0xaTGFB?=
 =?utf-8?B?SW5sNkpLd0hsYnZZVDhTRm9zTU42Mlc3dXp2dHlZYXlBNlRjRXYyOFhFby9H?=
 =?utf-8?B?Rjl1aXh0S21sTHRQQS9vZlFYNy9aSW5nMjhWTE92RFZOeXdTbE1QdFBlQU1O?=
 =?utf-8?B?MytQbk1NYUZxLytOTzFaTFV1ZHBRT2RTeUVwV3Y1Z1BIaklhRElMc0pNMUVx?=
 =?utf-8?B?aVVqeFI3dkYyK0xBTGx1aHJaYVVLQ2lZbktDWEEvYnBKUkJPMTE0QVhsSUxD?=
 =?utf-8?B?aEV5MWtveG9VbXFydS9IVjNDNEdlVGRwQkZYWGUybE9ReDc3RlhuWlJOQkJm?=
 =?utf-8?B?Yzd6c1FWZ2V5Z2crYVJacXF2WlhoWWZIUVdUclNlSmNiY0R1OWVISEp5WGt2?=
 =?utf-8?B?dmtvQTl1UWJWMUFoMmhUR25mTSs4RTg4OTVZSlFsNWlxMDNLb1RIMXZaZkg4?=
 =?utf-8?B?MzJ0VjIyYnVMMmQ2VlIzdVFLWEdPaEtUZ2krVklMNUZqdUNsMUVINEFwNjIx?=
 =?utf-8?B?OGZaTVFLS1F5SnJMSDNTbGRpZng1VG9neDBQKzFrYW9jTkNLMndiSjZYVG9H?=
 =?utf-8?B?eXZ5NkdXdjh5K1B1YmpDd0d6emYrZm1FUi80MlA3SDFzZlhQZkQwRlBwRW9l?=
 =?utf-8?B?SE1RSytPeXpEM2traGhWLzhOMGhKYlNITkZweVBZUXdKcTFkK2l5QjhsOVI3?=
 =?utf-8?B?VFd2Wk4ycGZhQUN4TU9ncFNnR0lIL25rUmNaMlZOaSt5MWtMOXVBQiszS0xF?=
 =?utf-8?B?OVR5a0Fpak1iY0JjU3I3SEFhOGdOTzdXTS9kT2o4eGtQR3lSK1JFYzVnb1Ro?=
 =?utf-8?B?UklkeEZIaEdHT1pjdHMrd2ZkZTdNRzZrK0crRTI4cjY5NldRaHlyYUJTTk9J?=
 =?utf-8?B?UXFEc3lVTTNFcGhMYmFCQjMydFR3dFZiRWRhR1RjeGdRcHZjZjN3ZzV4ZkZ2?=
 =?utf-8?B?dzlXYmlYRjVtTWV2UGhNY0VmQTcvNFRVelpqNWIvdXJqcUIvN1Z1U0JRbFZU?=
 =?utf-8?B?VG9jNkRHK3hIcnRjaU4wNXVGM3RWbnRRd3kxOUMram9rRzRDOFM0dXl2YjVv?=
 =?utf-8?B?WVZOakNBM2NSOTJRUlBCbUlpWDNzeU9VWG0rSVlJREM0T0wzUWl5NzVHMUcw?=
 =?utf-8?B?cEVURi9GbjJqejgrYm9mL1hmTkxHeHF5YW1FZmhBNzNrYTJLWWVISUUzalZl?=
 =?utf-8?B?MWV4VGhmekhqTHUrTDNkUXlyazBXTHlFa1dLREY1RzFWWFFZbHBUQk9NeWhh?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2B52EBC2259814EAB7F3D2B693AC435@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550893bd-03db-41fd-6033-08dcdbac4227
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 08:46:47.0403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MX4S5wX31ejmtoRW/NogUaTlNKz2/0ihIESHJ6pm7ESeMAgHcIY4eG/EmaY8yw00F85rzX5I7ZUHhcJLIRduVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8720

SGkgTHVpeiwNCg0KT24gRnJpLCAyMDI0LTA5LTIwIGF0IDEwOjU0IC0wNDAwLCBMdWl6IEF1Z3Vz
dG8gdm9uIERlbnR6IHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVy
aWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEhpIENocmlzLA0KPiANCj4gT24g
VGh1LCBTZXAgMTksIDIwMjQgYXQgMzo0OeKAr0FNIENocmlzIEx1IDxjaHJpcy5sdUBtZWRpYXRl
ay5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gTWVkaWFUZWsgY2xhaW0gYW4gc3BlY2lhbCB1c2Ig
aW50ciBpbnRlcmZhY2UgZm9yIElTTyBkYXRhDQo+IHRyYW5zbWlzc2lvbi4NCj4gPiBUaGUgaW50
ZXJmYWNlIG5lZWQgdG8gYmUgcmVsZWFzZWQgYmVmb3JlIHVucmVnaXN0ZXJpbmcgaGNpIGRldmlj
ZQ0KPiB3aGVuDQo+ID4gdXNiIGRpc2Nvbm5lY3QuIFJlbW92aW5nIEJUIHVzYiBkb25nbGUgd2l0
aG91dCBwcm9wZXJseSByZWxlYXNpbmcNCj4gdGhlDQo+ID4gaW50ZXJmYWNlIG1heSBjYXVzZSBL
ZXJuZWwgcGFuaWMgd2hpbGUgdW5yZWdpc3RlciBoY2kgZGV2aWNlLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogQ2hyaXMgTHUgPGNocmlzLmx1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYyB8IDEyICsrKysrKystLS0tLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMgYi9kcml2ZXJzL2JsdWV0b290aC9idHVz
Yi5jDQo+ID4gaW5kZXggZGZjNDJiZGM4YWFmLi4zN2U2N2I0NTFiMzQgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3Ro
L2J0dXNiLmMNCj4gPiBAQCAtMjYxNCw5ICsyNjE0LDkgQEAgc3RhdGljIHZvaWQgYnR1c2JfbXRr
X2NsYWltX2lzb19pbnRmKHN0cnVjdA0KPiBidHVzYl9kYXRhICpkYXRhKQ0KPiA+ICAgICAgICAg
c2V0X2JpdChCVE1US19JU09QS1RfT1ZFUl9JTlRSLCAmYnRtdGtfZGF0YS0+ZmxhZ3MpOw0KPiA+
ICB9DQo+ID4NCj4gPiAtc3RhdGljIHZvaWQgYnR1c2JfbXRrX3JlbGVhc2VfaXNvX2ludGYoc3Ry
dWN0IGJ0dXNiX2RhdGEgKmRhdGEpDQo+ID4gK3N0YXRpYyBpbnQgYnR1c2JfbXRrX3JlbGVhc2Vf
aXNvX2ludGYoc3RydWN0IGhjaV9kZXYgKmhkZXYpDQo+ID4gIHsNCj4gPiAtICAgICAgIHN0cnVj
dCBidG10a19kYXRhICpidG10a19kYXRhID0gaGNpX2dldF9wcml2KGRhdGEtPmhkZXYpOw0KPiA+
ICsgICAgICAgc3RydWN0IGJ0bXRrX2RhdGEgKmJ0bXRrX2RhdGEgPSBoY2lfZ2V0X3ByaXYoaGRl
dik7DQo+ID4NCj4gPiAgICAgICAgIGlmIChidG10a19kYXRhLT5pc29wa3RfaW50Zikgew0KPiA+
ICAgICAgICAgICAgICAgICB1c2Jfa2lsbF9hbmNob3JlZF91cmJzKCZidG10a19kYXRhLT5pc29w
a3RfYW5jaG9yKTsNCj4gPiBAQCAtMjYzMCw2ICsyNjMwLDggQEAgc3RhdGljIHZvaWQgYnR1c2Jf
bXRrX3JlbGVhc2VfaXNvX2ludGYoc3RydWN0DQo+IGJ0dXNiX2RhdGEgKmRhdGEpDQo+ID4gICAg
ICAgICB9DQo+ID4NCj4gPiAgICAgICAgIGNsZWFyX2JpdChCVE1US19JU09QS1RfT1ZFUl9JTlRS
LCAmYnRtdGtfZGF0YS0+ZmxhZ3MpOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+
ICB9DQo+ID4NCj4gPiAgc3RhdGljIGludCBidHVzYl9tdGtfcmVzZXQoc3RydWN0IGhjaV9kZXYg
KmhkZXYsIHZvaWQgKnJzdF9kYXRhKQ0KPiA+IEBAIC0yNjQ5LDcgKzI2NTEsNyBAQCBzdGF0aWMg
aW50IGJ0dXNiX210a19yZXNldChzdHJ1Y3QgaGNpX2Rldg0KPiAqaGRldiwgdm9pZCAqcnN0X2Rh
dGEpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+ID4NCj4gPiAgICAgICAgIGlm
ICh0ZXN0X2JpdChCVE1US19JU09QS1RfUlVOTklORywgJmJ0bXRrX2RhdGEtPmZsYWdzKSkNCj4g
PiAtICAgICAgICAgICAgICAgYnR1c2JfbXRrX3JlbGVhc2VfaXNvX2ludGYoZGF0YSk7DQo+ID4g
KyAgICAgICAgICAgICAgIGJ0dXNiX210a19yZWxlYXNlX2lzb19pbnRmKGhkZXYpOw0KPiANCj4g
V2UgY2FuIHByb2JhYmx5IG1vdmUgdGhlIGNoZWNrIGZvciBCVE1US19JU09QS1RfUlVOTklORyBp
bnRvDQo+IGJ0dXNiX210a19yZWxlYXNlX2lzb19pbnRmIHRvIGF2b2lkIGhhdmluZyB0byBkdXBs
aWNhdGUgaXQgd2hlbmV2ZXINCj4gY2FsbGluZyBidHVzYl9tdGtfcmVsZWFzZV9pc29faW50Zi4N
Cj4gDQoNClllcywgY29uZGl0aW9uIGNoZWNrIGhlcmUgaXMgcmVkdW5kYW50LCBLZWVwIHRoZSBj
aGVjayBpbg0KYnR1c2JfbXRrX3JlbGVhc2VfaXNvX2ludGYgaXMgYmV0dGVyLg0KDQo+ID4NCj4g
PiAgICAgICAgIGJ0dXNiX3N0b3BfdHJhZmZpYyhkYXRhKTsNCj4gPiAgICAgICAgIHVzYl9raWxs
X2FuY2hvcmVkX3VyYnMoJmRhdGEtPnR4X2FuY2hvcik7DQo+ID4gQEAgLTI3MDMsMTQgKzI3MDUs
MTMgQEAgc3RhdGljIGludCBidHVzYl9tdGtfc2V0dXAoc3RydWN0IGhjaV9kZXYNCj4gKmhkZXYp
DQo+ID4NCj4gPiAgc3RhdGljIGludCBidHVzYl9tdGtfc2h1dGRvd24oc3RydWN0IGhjaV9kZXYg
KmhkZXYpDQo+ID4gIHsNCj4gPiAtICAgICAgIHN0cnVjdCBidHVzYl9kYXRhICpkYXRhID0gaGNp
X2dldF9kcnZkYXRhKGhkZXYpOw0KPiA+ICAgICAgICAgc3RydWN0IGJ0bXRrX2RhdGEgKmJ0bXRr
X2RhdGEgPSBoY2lfZ2V0X3ByaXYoaGRldik7DQo+ID4gICAgICAgICBpbnQgcmV0Ow0KPiA+DQo+
ID4gICAgICAgICByZXQgPSBidG10a191c2Jfc2h1dGRvd24oaGRldik7DQo+ID4NCj4gPiAgICAg
ICAgIGlmICh0ZXN0X2JpdChCVE1US19JU09QS1RfUlVOTklORywgJmJ0bXRrX2RhdGEtPmZsYWdz
KSkNCj4gPiAtICAgICAgICAgICAgICAgYnR1c2JfbXRrX3JlbGVhc2VfaXNvX2ludGYoZGF0YSk7
DQo+ID4gKyAgICAgICAgICAgICAgIGJ0dXNiX210a19yZWxlYXNlX2lzb19pbnRmKGhkZXYpOw0K
PiANCj4gRGl0dG8uDQo+IA0KcmVtb3ZlIHJlZHVuZGFudCBjaGVjay4NCg0KPiA+ICAgICAgICAg
cmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+IEBAIC0zODI0LDYgKzM4MjUsNyBAQCBzdGF0aWMgaW50
IGJ0dXNiX3Byb2JlKHN0cnVjdCB1c2JfaW50ZXJmYWNlDQo+ICppbnRmLA0KPiA+ICAgICAgICAg
ICAgICAgICBkYXRhLT5yZWN2X2FjbCA9IGJ0bXRrX3VzYl9yZWN2X2FjbDsNCj4gPiAgICAgICAg
ICAgICAgICAgZGF0YS0+c3VzcGVuZCA9IGJ0bXRrX3VzYl9zdXNwZW5kOw0KPiA+ICAgICAgICAg
ICAgICAgICBkYXRhLT5yZXN1bWUgPSBidG10a191c2JfcmVzdW1lOw0KPiA+ICsgICAgICAgICAg
ICAgICBkYXRhLT5kaXNjb25uZWN0ID0gYnR1c2JfbXRrX3JlbGVhc2VfaXNvX2ludGY7DQo+IA0K
PiBJJ2Qgd3JhcCAoZS5nLiBidG10a191c2JfZGlzY29ubmVjdCkgdGhlIGNhbGwgdG8NCj4gYnR1
c2JfbXRrX3JlbGVhc2VfaXNvX2ludGYgc2luY2UgdGhhdCBpcyBvbmx5IG1lYW50IHRvIHJlbGVh
c2UgdGhlDQo+IElTTw0KPiBlbmRwb2ludC4NCj4gDQpBZGQgYSBuZXcgZnVuY3Rpb24gImJ0dXNi
X210a19kaXNjb25uZWN0Ii4gU2luY2UgdGhpcyBmdW5jdGlvbiB3aWxsIHVzZQ0KYnR1c2JfZGF0
YSB3aGljaCBpcyBkZWZpbmVkIGluIGJ0dXNiLmMgb25seSwgSSdsbCBhbHNvIGRlZmluZSB0aGlz
DQpmdW5jdGlvbiBpbiBidHVzYi5jLg0KDQpUaGFua3MgZm9yIHlvdXIgYWR2aWNlLiBJJ2xsIHN1
Ym1pdCB2MyBsYXRlci4NCg0KQmVzdCByZWdhcmRzLA0KQ2hyaXMgTHUNCg0KPiA+ICAgICAgICAg
fQ0KPiA+DQo+ID4gICAgICAgICBpZiAoaWQtPmRyaXZlcl9pbmZvICYgQlRVU0JfU1dBVkUpIHsN
Cj4gPiAtLQ0KPiA+IDIuMTguMA0KPiA+DQo+IA0KPiANCj4gLS0gDQo+IEx1aXogQXVndXN0byB2
b24gRGVudHoNCg==
