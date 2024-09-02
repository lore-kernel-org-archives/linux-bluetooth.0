Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69696224EF
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Sep 2024 03:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725248386; cv=fail; b=eix22CUi5i5TYAGTYXnQKCv+vcV5lAvlX3PlWl4hwitctwYYiyA3W2Z/OdeglK/JZS/BGLJsQTFnC3UrOPH3VI+2dviotl8DlfpmW1oCmPil0xiFY5v72PXRdfo5M3nAOp8Pm/zGbDrhqN2h2CVUMJnTbqM4jySNyZKV5XuGt6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725248386; c=relaxed/simple;
	bh=UKpgbBSlZzOox4pzTttwyJFWnJD/Bxb6aX1jZGxIB9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KZvoCdCKwS6aeiEKWMip04Au+eSLlSANCrPtJYyAkcf0cqRTIlCvsWPzixZo8egpso2YxW7/8CCCSeD9bTPIMcZ2MrTDTQwV6ij9t3L5AuETz6nAHTc8hK+P8YPwzk27YF1bt9QF5Qu7CknQN7eYlzs2H4HNai4h5y8pJIspVoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mi5DMyMW; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=mPmkdF4q; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mi5DMyMW";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mPmkdF4q"
X-UUID: f97582dc68dc11ef8593d301e5c8a9c0-20240902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=UKpgbBSlZzOox4pzTttwyJFWnJD/Bxb6aX1jZGxIB9Y=;
	b=mi5DMyMWjgmFxS3SF71kZNRp4XlH2oHvmKKcDfxMvxyVa/nWWkxBYMedasGB9hX7faloUakLQH2Y9qG7a5dBPwsNgereIecR8FZZWobmGWrbWos/hV1WoR6VVYeKdllBwz9SmtL0+xJNd8YshOebaeR9QlXpE5FUm5MqAFjosp0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:a8e2eea9-6b3d-44df-abfb-067182a1dc69,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6dc6a47,CLOUDID:ec234abf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f97582dc68dc11ef8593d301e5c8a9c0-20240902
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1848614604; Mon, 02 Sep 2024 11:39:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 2 Sep 2024 11:39:36 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 2 Sep 2024 11:39:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zs1VNSnjz6JKnYNrJPWylcXIQ/2Su0iVb6xZVotlBj6LXPY65Aj4ixsZ6qXdlktVnlRuoKPwQHkC8BMm/kRKKRaF+yDcaAeEFJCUMntyFmqS6zNpIwZ0XFZRb8Pd274xOrLGOnJ6KHEQG+xWsUej+BhhYh3BuPUY56MlA7FMkW20tPl5Na4T1f53ggLZEg0mYEIuHjVuYSg+tnSdUPLXZPZAzRMElTnItcOVBTHPqwuqEmbKkBlnFxWLdSwyawYOHKAMe+6NDLG8EEBNoY1nxYU6Lr5MWnjtPlyfnKavT80XqcbpmClnIiE/VEss9cipzDnRthDGiT3jFYuMbP8eiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKpgbBSlZzOox4pzTttwyJFWnJD/Bxb6aX1jZGxIB9Y=;
 b=uji+PZfkpcWQ7Wu0XQZ6dfwNHbzk0rvNaKxXffTcrTNUWRa/37BaHI84mcpUg6hvL1zKxCb6VGN3N644uOD4a0ayrits1SbnsVY8NaFtVKELsqTQQ+Yz+9uPv0UBixqWtUvNeNpC9RTHvv0nXrtC1MWn1Ax9yDDEvSjWFRbWW0/7Fep3YcZEsRFBr66XulRXgQFxFtMkzbF4oTGAO4BwFhE5cdbijGKWT6+pAHXzzLyb8kK4OWxcyAAJRCUGsPC4YMTjvdmdC0WDMVGBFFVu/aWHw93Iua8qY0chIocW3KSrZlxT6/EZUsC9N8gAPE7CU3DAsAjShf4hZU5dgKMmKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKpgbBSlZzOox4pzTttwyJFWnJD/Bxb6aX1jZGxIB9Y=;
 b=mPmkdF4qD2vSlsDye9kQDlgS8x+oRz7/nttV9D1DCWIVf62ceCPDD7ZThhRr672gChQCzJRiYDnvtMPItTS/vUn/fLmNBA4vGQqQCbnHi26iBlsloKlCAZZg+z97FdP9LSJ5WhoVmhcHgofWuMc9PN9n3XMcFugO/7xBOXv+7FA=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by OSQPR03MB8642.apcprd03.prod.outlook.com (2603:1096:604:298::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 03:39:33 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf%6]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 03:39:33 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "cascardo@igalia.com" <cascardo@igalia.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>,
	=?utf-8?B?SmluZyBDYWkgKOiUoeaZtik=?= <Jing.Cai@mediatek.com>, Sean Wang
	<Sean.Wang@mediatek.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] Bluetooth: btmtk: avoid UAF in btmtk_process_coredump
Thread-Topic: [PATCH] Bluetooth: btmtk: avoid UAF in btmtk_process_coredump
Thread-Index: AQHa43x7LUHlGEdHz0qNVrnnMxNypbIzLH4AgBDf+gA=
Date: Mon, 2 Sep 2024 03:39:33 +0000
Message-ID: <2306bbd971726aa3324c6f2d13ab66f9d4d6b835.camel@mediatek.com>
References: <20240731190330.1619718-1-cascardo@igalia.com>
	 <ZscLmFqTGpAdWCdJ@quatroqueijos.cascardo.eti.br>
In-Reply-To: <ZscLmFqTGpAdWCdJ@quatroqueijos.cascardo.eti.br>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|OSQPR03MB8642:EE_
x-ms-office365-filtering-correlation-id: 1325b845-056b-484b-dc26-08dccb00dc4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dll6dE9ENmhHNHM3azVNYm1Jd1NRNUNaMVFpcnR2eEJRNTZRY1RpTDJPWHlU?=
 =?utf-8?B?bFpKSFYreXNyR1pSTHNCTFVEMnhyMmdDNks4aWxZcU91SnJQSThqYzczdEIr?=
 =?utf-8?B?ZzVHWGxmK0RieVFHTVA1NGFHUStIWS9OMlgvY2M4YVVrb1ZSeWhKSkZna2U4?=
 =?utf-8?B?d3BTdE4rYThzSlJRWDdiUjdOUGRLZTlWbTJnMy9BK1JRRHdSNUxsMlB3WmpO?=
 =?utf-8?B?U3p6TE9KY3drc0JmMStPWEpORjRINVZQYVRDSDVpVDBCK0hibC96NkVmeExL?=
 =?utf-8?B?YnR4WE1rNmp5QjdKSjVhTU52U2M0ZFF4ZG8wOTlmNkVqV2NSYm5BcWNwVjJk?=
 =?utf-8?B?TXNJaEo3Z3h0dTVDMjZ6Rjh6ZjdSdFZrbmxoc1ZockJYNU9tMWVQek4xZkQy?=
 =?utf-8?B?WUh6SzRpS0htNnRYck1JQXF4eEJTRzk2SjlxandWaVpCSUtNQkZ4dERtTE1Y?=
 =?utf-8?B?NkhqZklXNDFsZE9Ha3RtRjVRZlkyYzdCTmxKMTYycVVkNWYxRk80dHJ1K3Jo?=
 =?utf-8?B?NnNZdzluVkQzZ1MrY1p4bU5mWW1sY3lpYUxBMkttRUh2S0gySy85SlFiQm5v?=
 =?utf-8?B?cTErUWNDTzJ5NnFKckJjQ3h3RjN0Q3ZNSHE4eUNISWVNVElNOGN0anNVbURv?=
 =?utf-8?B?R0JMZHA0VHFERklHNklGdTB3VkQzdllXcDJRV3IyVGcyekhkVVZSUHRVN05L?=
 =?utf-8?B?OTNKeXZSeU9kWEtmMzBvQWtENFNLemtYT3ZQb3N0KzI1S3dzelNUY3MwVThM?=
 =?utf-8?B?dkwyeUZyVHNvSG5Ddy9jcVJTQTZ4M1ZObEhqeGJJVERWMEVaWGRHbDI1WGIx?=
 =?utf-8?B?SEc4eW5pZkE2MjhWZmdkbTRDZzl1cUN6YVBDK2FOcmFJUklQdTNVaXM4MVZF?=
 =?utf-8?B?TnNQNXNFQXRidGZSNndwRjEvbFk4UkcrWmtUVm1DNVVlNitRVzVSaHpjQWNV?=
 =?utf-8?B?N1M3Q2Q4aDkva3poTFZBZXdjY3I2T1RVbVAyUlByTlpia2w3TlE4dmVpL01L?=
 =?utf-8?B?R0E4YmJqeWNKcEFldnJUdWFDZ0xKSHdEcVpJYnBWbmtVeGkwOE02NnVBMi8v?=
 =?utf-8?B?MGdWTWd2M0lzdXNKQTN0Y1VJclJmcFB4bTRoOHJmYm9OZWhNNHBkTTUweWts?=
 =?utf-8?B?dWpqSHVOU3lvU29IOGI2T0lxdHJ2Ym81KzR5TElXWnRZTlpGOTFsV21Hbm9y?=
 =?utf-8?B?Y2Zwbm40akZiUEJQK0xKdi9UWkRkWFVDcmVYVElYZUp0cnFQSk03bmhKdi9S?=
 =?utf-8?B?a3F0VXZZeE52VzRkcW9WK3B1ejNwaG9Kc0hjYlQ3YlRxR29lSGxRTGRITTRw?=
 =?utf-8?B?bkJOSmMyemdldzBKY1lBYlQyRFdUN1dYTkozWXZTVFN6RE1qL1R4N2cwbmp3?=
 =?utf-8?B?eU5Vak9XMnU5YWc5V0hoaVQxRXlsTmoxYzRzVHZNa0FUcmFTak5MdldlWHNv?=
 =?utf-8?B?NVJBcEZIdVJoZFpsY3FHRmNVV1kxbDgyZDltdnIwSzc3UmcrNTR1N3RJVmd1?=
 =?utf-8?B?Zk9DM2NJUGJ6VE1XYW5vNjJMbmJ1UmExNm02V0FoR00vckFvb1VwcFd2Z3hp?=
 =?utf-8?B?TFZkOWhwb0YreVR1NGd4L0dFNlVwcDI4MVJjQzJQbXNqZ0hicHJDK2RjWGJ6?=
 =?utf-8?B?bHF6cUV0M2xUMHU4cEF5MExxSkNteDVyVHNianlORDVDaUxDelZ2QThkeUti?=
 =?utf-8?B?blBpd0ttZ2JFUjFFN0p3bWR1bnFlanhSZHE1SEdEcXVDRDgzZmlCMkozQlZO?=
 =?utf-8?B?SFlsblJzTGpUQ0VpdG1qZ3lNNHBpUTM3THVrZ3hGZTdVQ2dMTUp1WGNuc1pn?=
 =?utf-8?B?RjZycFdsTnF4SE5XMDJQKzA3WVBRcUNGbDc4K1RxM2ticlJydkNvTC9hZTF0?=
 =?utf-8?B?bFRadWs4NHlIVXJwUkNaeno5RnVVM3lDdlJ3d0hCZUUyWXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUJ2U2JCZUZ2dWxITC9VNTh3RVFLSi9oejVUN0xLRHlKbWFtb0NuNXNNTEtX?=
 =?utf-8?B?WmFYRnZUK2hxZFYveCt1NU1hQUpIU0FRT2RSK05BdW9XbHdKdHpkazJnUGlw?=
 =?utf-8?B?ZzZUaEY1ZVUzYmV1RkxvUzdMejVoeE9ZQXROVDZhRGx2b3JnUDR5d2JiQmMy?=
 =?utf-8?B?ZWZyMzhzcGhyRG00MktJK0tBMDhBOVhnS3NvWW9jM1F2b05Ma2ZzcG1SMnlI?=
 =?utf-8?B?UXlCUXZIcXY0elRyNXpEQThJLytpcFlTZjlrVGo2V0U3blZYSHRUZXRlNGxv?=
 =?utf-8?B?U0xaVk5ZdjZEZ1k1WVQ2aGcwQzVOaFRQQm80NkFZK1VubE83cldJNDc3YUt5?=
 =?utf-8?B?NE1LUm8raFFqZzFjZFBBNTJqcXZzQXhBaDQ5SGVRSmNFcWFDbGVFYzEraDNW?=
 =?utf-8?B?K21ZTDVVOERpK3VZR0RHdzU4dndhcEMwQ2h3NEo0UHFoUk8zd3VwZ3lCU0hI?=
 =?utf-8?B?ckhOZTFka0VnaVZqRmNzMkdFYXZrMjFFVzJ3YVhXdjFaSDVWOW5Bd2ttWUFn?=
 =?utf-8?B?L1pCVFB0ZDNJeXFlb0l4NnpQN00vNkJVUGxnRlp5NGFtK1ZNS2t4aHVlbGJa?=
 =?utf-8?B?NFZPTFlhUTVETE83NUJOYkYxTzlLSWQ3WnlDMXdPQldQbWIzdDVEOVRCREtP?=
 =?utf-8?B?OHFNajloK0VrczArU0t6bVpPRGZaNGcvQ3MrMEZ1OW13Z01Db0sya1hDZ1FO?=
 =?utf-8?B?UlljOENpQXBZaWhVTkxydU84OE5JWUxKUnc3Wm11UFBSQmpmOU1yWjNzTWFT?=
 =?utf-8?B?TDNnWDZLTjVCS2FCMGhvTVQvMUdjNmw1OVI3YmNQK0l3dGQ1djdiVkw0bjJr?=
 =?utf-8?B?aU8xdE9oNTczeXpXRTJFTlJxRXhSbEd4NThCTEFITDZzekJ0YWNTVkhrWWl0?=
 =?utf-8?B?MjRib3ZDSDJDbVg4VzZ3YmFWNnBlM1pyNEdKaWpQVHRvTUpFNUl4b203bUFM?=
 =?utf-8?B?Z01ra3dPd3VGV1hFUUFJd2Jlc3FDQzdCQ09hcnRXZGphcVhqSFdxMUEwNDdG?=
 =?utf-8?B?UWpYRnJxTmJLUGRzT1crOWFaTzVQTW56aTZCRUJ3elViM29oQ1ozUUVTTWJi?=
 =?utf-8?B?OFhPR1pCSkFoRm8rdmtTZnI3SUtVa2VqTmdrWnVTMFVpV0M1WlBwMnhIRVVz?=
 =?utf-8?B?Nk5XN2dnUVlyY3hmY3JPekRmYURIaWpGRnRoSHhpT2tNeHpId0JicHpsaTc5?=
 =?utf-8?B?TUpTdGNvZUo1UzRienVtMXNiQTdEeEdQWERKTkR0cEM4QmpQcU9penhNTWlu?=
 =?utf-8?B?cWpXZkhQbm1aSVI5WmV4Y3pRcVZZRTNsT09yczNpNVpHVkhtRTVSWk5QMDRj?=
 =?utf-8?B?YzhHK3RmV2ZRZlNqRUhzUE9ZQjBsSHdpbEFyVGg2MjAzUHlwVDZDSzVSZUFj?=
 =?utf-8?B?NkR6VldTSlp1Sm1jNEZHRGlCVDBzUlNJZjMwS3ZQaWZMYzlVd1R1QVdBRUwr?=
 =?utf-8?B?bFVRSTdSOG5ZZU8wTFF2cjgwYk40Mm9kWTBRb0E3VDNGU1NydjFGeXNLb2dq?=
 =?utf-8?B?bFVpaXNZYVpuSTlGWGRTVXRtS1F0SkFiTlpoK2J1RnIwRGtLSGU5ZHh3V2hm?=
 =?utf-8?B?YlRCVkIwaVNEYWxKMlc1bzhKYnUrVlcwMFJQZEVHcWFSaVE1UTl4TjRFQnVy?=
 =?utf-8?B?TmFnNm9BcTN0TStGZjJ4aUVaV2lQMVhPdXVJcTBxS1NSSEVycWJwa2t3dlQz?=
 =?utf-8?B?aithVUJ1Wm1pUkJmSFlTeEM3TUMyaERXdG9GM1FYZHlDSFRXVWxFMlJJNFVv?=
 =?utf-8?B?TFhBNW5tVHV1WWlUbFIxUW5jRTNZWGNQYXNQbG9hUHFSd2psRXpKQ05Ya1lx?=
 =?utf-8?B?dzFhbzhHclh1UGk0bHJ3UUFFS2o5RTNSTnNuK1N0czNVblk1VFo0V3VhK05O?=
 =?utf-8?B?ZndzOE1HZkN1SHhHbEl5Um9XVjZMaS9qWlNCcUZjRUtldWdjS3Q1MWpiWjlS?=
 =?utf-8?B?aGl6OFBvQ2U2bm8yY3Y5NFBkZ1BYVG1sUXNFRFlhUUIxeWFyTXNJMzI5V0kw?=
 =?utf-8?B?bXIzRWdqcmcrQ1RhMXN6NnlxZGxONVV0L2VQWlZZcnd3Mk94VEk4b09Oa0Rl?=
 =?utf-8?B?ZmlUOTd5L2ZxbEorRGpuL1RZdzNGczBLM2pXSXJPYTFMQkNqOTRudnFFRFJL?=
 =?utf-8?B?VWJ6YVNvbVJpYkhIMklCMHprUkplVitsSy9wS2RZNXRqc2NtczNKWlQrVURO?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7EC554CAAA2DA4CB3D7F8346E94F6A9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1325b845-056b-484b-dc26-08dccb00dc4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 03:39:33.6034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l0TEPIj4JmVUU2M7RzZxWqNl2UjSvvHxrMp/jg0aIiIrE0gj/Ogwt08AX6xpZ5D6U5gvSRzHRQYlOetscFpe6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8642
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--27.103900-8.000000
X-TMASE-MatchedRID: 0dFPYP4mu5R7z7Ua4wbKNSa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCpGpaLcbZyfwmlaAItiONP0jaS5JaFRo9TlvF4AocVXYiNN
	q94LzED++hW/S1TWHJxzBSAi+7m3T62xBm/uUP3lbuDP8ZuCmXuj86Ng8AayKMWJ1MFFZvbzj3V
	nySuqu9tP/wJvxl5XtMswE733qr6XgFjNk3kzVpeEbUg4xvs+wjzwigoyOACSM2ehTV+imi65vN
	MfupUfWZt7d7ErwIfeRr6aBAhuUh3rSP9RtGZYokDpLRKO9xhSwR/wKmchi2d9RlPzeVuQQIA6D
	0Tft3i8ANcTxXeakRSe1F2Q6lt/AYB11qN+uiQDmAId+2bAQwtmmHZ8J+6h3gUP7D6Sav8zRpl9
	lqiu4/+YERrLHt6t3kZOl7WKIImrS77Co4bNJXUY41YX/o/8KSnQ4MjwaO9cqtq5d3cxkNQwWxr
	7XDKH8lExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--27.103900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B1E5915F55D123CC91684288E22441B179C1B58E44B3C29D994D5EFF1284251F2000:8

T24gVGh1LCAyMDI0LTA4LTIyIGF0IDA2OjU3IC0wMzAwLCBUaGFkZXUgTGltYSBkZSBTb3V6YSBD
YXNjYXJkbyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVk
IHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBPbiBXZWQsIEp1bCAzMSwgMjAyNCBhdCAw
NDowMzozMFBNIC0wMzAwLCBUaGFkZXUgTGltYSBkZSBTb3V6YQ0KPiBDYXNjYXJkbyB3cm90ZToN
Cj4gPiBoY2lfZGV2Y2RfYXBwZW5kIG1heSBsZWFkIHRvIHRoZSByZWxlYXNlIG9mIHRoZSBza2Is
IHNvIGl0IGNhbm5vdA0KPiBiZQ0KPiA+IGFjY2Vzc2VkIG9uY2UgaXQgaXMgY2FsbGVkLg0KPiA+
IA0KPiA+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQ0KPiA+IEJVRzogS0FTQU46IHNsYWItdXNlLWFmdGVyLWZyZWUgaW4N
Cj4gYnRtdGtfcHJvY2Vzc19jb3JlZHVtcCsweDJhNy8weDJkMCBbYnRtdGtdDQo+ID4gUmVhZCBv
ZiBzaXplIDQgYXQgYWRkciBmZmZmODg4MDMzY2ZhYmIwIGJ5IHRhc2sga3dvcmtlci8wOjMvODIN
Cj4gPiANCj4gPiBDUFU6IDAgUElEOiA4MiBDb21tOiBrd29ya2VyLzA6MyBUYWludGVkOg0KPiBH
ICAgICBVICAgICAgICAgICAgIDYuNi40MC1sb2NrZGVwLTAzNDY0LWcxZDhiNGViMzA2MGUgIzEN
Cj4gYjBiM2MxY2MwYzg0MjczNTY0M2ZiNDExNzk5ZDk3OTIxZDFmNjg4Yw0KPiA+IEhhcmR3YXJl
IG5hbWU6IEdvb2dsZSBZYXZpa3NfVWZzL1lhdmlrc19VZnMsIEJJT1MNCj4gR29vZ2xlX1lhdmlr
c19VZnMuMTUyMTcuNTUyLjAgMDUvMDcvMjAyNA0KPiA+IFdvcmtxdWV1ZTogZXZlbnRzIGJ0dXNi
X3J4X3dvcmsgW2J0dXNiXQ0KPiA+IENhbGwgVHJhY2U6DQo+ID4gIDxUQVNLPg0KPiA+ICBkdW1w
X3N0YWNrX2x2bCsweGZkLzB4MTUwDQo+ID4gIHByaW50X3JlcG9ydCsweDEzMS8weDc4MA0KPiA+
ICBrYXNhbl9yZXBvcnQrMHgxNzcvMHgxYzANCj4gPiAgYnRtdGtfcHJvY2Vzc19jb3JlZHVtcCsw
eDJhNy8weDJkMCBbYnRtdGsNCj4gMDNlZGQ1NjdkZDcxYTY1OTU4ODA3Yzk1YTY1ZGIzMWQ0MzNl
MWQwMV0NCj4gPiAgYnR1c2JfcmVjdl9hY2xfbXRrKzB4MTFjLzB4MWEwIFtidHVzYg0KPiA2NzU0
MzBkMWU4N2M0ZjI0ZDBjMWY4MGVmZTYwMDc1N2EwZjMyYmVjXQ0KPiA+ICBidHVzYl9yeF93b3Jr
KzB4OWUvMHhlMCBbYnR1c2INCj4gNjc1NDMwZDFlODdjNGYyNGQwYzFmODBlZmU2MDA3NTdhMGYz
MmJlY10NCj4gPiAgd29ya2VyX3RocmVhZCsweGU0NC8weDJjYzANCj4gPiAga3RocmVhZCsweDJm
Zi8weDNhMA0KPiA+ICByZXRfZnJvbV9mb3JrKzB4NTEvMHg4MA0KPiA+ICByZXRfZnJvbV9mb3Jr
X2FzbSsweDFiLzB4MzANCj4gPiAgPC9UQVNLPg0KPiA+IA0KPiA+IEFsbG9jYXRlZCBieSB0YXNr
IDgyOg0KPiA+ICBzdGFja190cmFjZV9zYXZlKzB4ZGMvMHgxOTANCj4gPiAga2FzYW5fc2V0X3Ry
YWNrKzB4NGUvMHg4MA0KPiA+ICBfX2thc2FuX3NsYWJfYWxsb2MrMHg0ZS8weDYwDQo+ID4gIGtt
ZW1fY2FjaGVfYWxsb2MrMHgxOWYvMHgzNjANCj4gPiAgc2tiX2Nsb25lKzB4MTMyLzB4ZjcwDQo+
ID4gIGJ0dXNiX3JlY3ZfYWNsX210aysweDEwNC8weDFhMCBbYnR1c2JdDQo+ID4gIGJ0dXNiX3J4
X3dvcmsrMHg5ZS8weGUwIFtidHVzYl0NCj4gPiAgd29ya2VyX3RocmVhZCsweGU0NC8weDJjYzAN
Cj4gPiAga3RocmVhZCsweDJmZi8weDNhMA0KPiA+ICByZXRfZnJvbV9mb3JrKzB4NTEvMHg4MA0K
PiA+ICByZXRfZnJvbV9mb3JrX2FzbSsweDFiLzB4MzANCj4gPiANCj4gPiBGcmVlZCBieSB0YXNr
IDE3MzM6DQo+ID4gIHN0YWNrX3RyYWNlX3NhdmUrMHhkYy8weDE5MA0KPiA+ICBrYXNhbl9zZXRf
dHJhY2srMHg0ZS8weDgwDQo+ID4gIGthc2FuX3NhdmVfZnJlZV9pbmZvKzB4MjgvMHhiMA0KPiA+
ICBfX19fa2FzYW5fc2xhYl9mcmVlKzB4ZmQvMHgxNzANCj4gPiAga21lbV9jYWNoZV9mcmVlKzB4
MTgzLzB4M2YwDQo+ID4gIGhjaV9kZXZjZF9yeCsweDkxYS8weDIwNjAgW2JsdWV0b290aF0NCj4g
PiAgd29ya2VyX3RocmVhZCsweGU0NC8weDJjYzANCj4gPiAga3RocmVhZCsweDJmZi8weDNhMA0K
PiA+ICByZXRfZnJvbV9mb3JrKzB4NTEvMHg4MA0KPiA+ICByZXRfZnJvbV9mb3JrX2FzbSsweDFi
LzB4MzANCj4gPiANCj4gPiBUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBvYmplY3Qg
YXQgZmZmZjg4ODAzM2NmYWI0MA0KPiA+ICB3aGljaCBiZWxvbmdzIHRvIHRoZSBjYWNoZSBza2J1
ZmZfaGVhZF9jYWNoZSBvZiBzaXplIDIzMg0KPiA+IFRoZSBidWdneSBhZGRyZXNzIGlzIGxvY2F0
ZWQgMTEyIGJ5dGVzIGluc2lkZSBvZg0KPiA+ICBmcmVlZCAyMzItYnl0ZSByZWdpb24gW2ZmZmY4
ODgwMzNjZmFiNDAsIGZmZmY4ODgwMzNjZmFjMjgpDQo+ID4gDQo+ID4gVGhlIGJ1Z2d5IGFkZHJl
c3MgYmVsb25ncyB0byB0aGUgcGh5c2ljYWwgcGFnZToNCj4gPiBwYWdlOjAwMDAwMDAwYTE3NGJh
OTMgcmVmY291bnQ6MSBtYXBjb3VudDowDQo+IG1hcHBpbmc6MDAwMDAwMDAwMDAwMDAwMCBpbmRl
eDoweDAgcGZuOjB4MzNjZmENCj4gPiBoZWFkOjAwMDAwMDAwYTE3NGJhOTMgb3JkZXI6MSBlbnRp
cmVfbWFwY291bnQ6MCBucl9wYWdlc19tYXBwZWQ6MA0KPiBwaW5jb3VudDowDQo+ID4gYW5vbiBm
bGFnczogMHg0MDAwMDAwMDAwMDAwODQwKHNsYWJ8aGVhZHx6b25lPTEpDQo+ID4gcGFnZV90eXBl
OiAweGZmZmZmZmZmKCkNCj4gPiByYXc6IDQwMDAwMDAwMDAwMDA4NDAgZmZmZjg4ODEwMDg0OGEw
MCAwMDAwMDAwMDAwMDAwMDAwDQo+IDAwMDAwMDAwMDAwMDAwMDENCj4gPiByYXc6IDAwMDAwMDAw
MDAwMDAwMDAgMDAwMDAwMDA4MDE5MDAxOSAwMDAwMDAwMWZmZmZmZmZmDQo+IDAwMDAwMDAwMDAw
MDAwMDANCj4gPiBwYWdlIGR1bXBlZCBiZWNhdXNlOiBrYXNhbjogYmFkIGFjY2VzcyBkZXRlY3Rl
ZA0KPiA+IA0KPiA+IE1lbW9yeSBzdGF0ZSBhcm91bmQgdGhlIGJ1Z2d5IGFkZHJlc3M6DQo+ID4g
IGZmZmY4ODgwMzNjZmFhODA6IGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZi
IGZjIGZjIGZjDQo+ID4gIGZmZmY4ODgwMzNjZmFiMDA6IGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZj
IGZhIGZiIGZiIGZiIGZiIGZiIGZiIGZiDQo+ID4gPmZmZmY4ODgwMzNjZmFiODA6IGZiIGZiIGZi
IGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4gPiAgZmZmZjg4ODAzM2NmYWMwMDogZmIgZmIg
ZmIgZmIgZmIgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMNCj4gPiAgZmZmZjg4ODAz
M2NmYWM4MDogZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIN
Cj4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NCj4gPiANCj4gPiBDaGVjayBpZiB3ZSBuZWVkIHRvIGNhbGwgaGNpX2Rl
dmNkX2NvbXBsZXRlIGJlZm9yZSBjYWxsaW5nDQo+ID4gaGNpX2RldmNkX2FwcGVuZC4gVGhhdCBy
ZXF1aXJlcyB0aGF0IHdlIGNoZWNrIGRhdGEtPmNkX2luZm8uY250ID49DQo+ID4gTVRLX0NPUkVE
VU1QX05VTSBpbnN0ZWFkIG9mIGRhdGEtPmNkX2luZm8uY250ID4gTVRLX0NPUkVEVU1QX05VTSwN
Cj4gYXMgd2UNCj4gPiBpbmNyZW1lbnQgZGF0YS0+Y2RfaW5mby5jbnQgb25seSBvbmNlIHRoZSBj
YWxsIHRvIGhjaV9kZXZjZF9hcHBlbmQNCj4gPiBzdWNjZWVkcy4NCj4gPiANCj4gPiBGaXhlczog
MGI3MDE1MTMyODc4ICgiQmx1ZXRvb3RoOiBidHVzYjogbWVkaWF0ZWs6IGFkZCBNZWRpYVRlaw0K
PiBkZXZjb3JlZHVtcCBzdXBwb3J0IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBUaGFkZXUgTGltYSBk
ZSBTb3V6YSBDYXNjYXJkbyA8Y2FzY2FyZG9AaWdhbGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9ibHVldG9vdGgvYnRtdGsuYyB8IDIwICsrKysrKysrKysrKy0tLS0tLS0tDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idG10ay5jIGIvZHJpdmVycy9ibHVldG9v
dGgvYnRtdGsuYw0KPiA+IGluZGV4IGI3YzM0ODY4N2E3Ny4uNDZmNjA1MjQ5ZGY3IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmMNCj4gPiArKysgYi9kcml2ZXJzL2Js
dWV0b290aC9idG10ay5jDQo+ID4gQEAgLTM5NSw2ICszOTUsNyBAQCBpbnQgYnRtdGtfcHJvY2Vz
c19jb3JlZHVtcChzdHJ1Y3QgaGNpX2Rldg0KPiAqaGRldiwgc3RydWN0IHNrX2J1ZmYgKnNrYikN
Cj4gPiAgew0KPiA+ICBzdHJ1Y3QgYnRtdGtfZGF0YSAqZGF0YSA9IGhjaV9nZXRfcHJpdihoZGV2
KTsNCj4gPiAgaW50IGVycjsNCj4gPiArYm9vbCBjb21wbGV0ZSA9IGZhbHNlOw0KPiA+ICANCj4g
PiAgaWYgKCFJU19FTkFCTEVEKENPTkZJR19ERVZfQ09SRURVTVApKSB7DQo+ID4gIGtmcmVlX3Nr
Yihza2IpOw0KPiA+IEBAIC00MTYsMTkgKzQxNywyMiBAQCBpbnQgYnRtdGtfcHJvY2Vzc19jb3Jl
ZHVtcChzdHJ1Y3QgaGNpX2Rldg0KPiAqaGRldiwgc3RydWN0IHNrX2J1ZmYgKnNrYikNCj4gPiAg
ZmFsbHRocm91Z2g7DQo+ID4gIGNhc2UgSENJX0RFVkNPUkVEVU1QX0FDVElWRToNCj4gPiAgZGVm
YXVsdDoNCj4gPiArLyogTWVkaWF0ZWsgY29yZWR1bXAgZGF0YSB3b3VsZCBiZSBtb3JlIHRoYW4g
TVRLX0NPUkVEVU1QX05VTSAqLw0KPiA+ICtpZiAoZGF0YS0+Y2RfaW5mby5jbnQgPj0gTVRLX0NP
UkVEVU1QX05VTSAmJg0KPiA+ICsgICAgc2tiLT5sZW4gPiBNVEtfQ09SRURVTVBfRU5EX0xFTikN
Cj4gPiAraWYgKCFtZW1jbXAoKGNoYXIgKikmc2tiLT5kYXRhW3NrYi0+bGVuIC0gTVRLX0NPUkVE
VU1QX0VORF9MRU5dLA0KPiA+ICsgICAgTVRLX0NPUkVEVU1QX0VORCwgTVRLX0NPUkVEVU1QX0VO
RF9MRU4gLSAxKSkNCj4gPiArY29tcGxldGUgPSB0cnVlOw0KPiA+ICsNCj4gPiAgZXJyID0gaGNp
X2RldmNkX2FwcGVuZChoZGV2LCBza2IpOw0KPiA+ICBpZiAoZXJyIDwgMCkNCj4gPiAgYnJlYWs7
DQo+ID4gIGRhdGEtPmNkX2luZm8uY250Kys7DQo+ID4gIA0KPiA+IC0vKiBNZWRpYXRlayBjb3Jl
ZHVtcCBkYXRhIHdvdWxkIGJlIG1vcmUgdGhhbiBNVEtfQ09SRURVTVBfTlVNICovDQo+ID4gLWlm
IChkYXRhLT5jZF9pbmZvLmNudCA+IE1US19DT1JFRFVNUF9OVU0gJiYNCj4gPiAtICAgIHNrYi0+
bGVuID4gTVRLX0NPUkVEVU1QX0VORF9MRU4pDQo+ID4gLWlmICghbWVtY21wKChjaGFyICopJnNr
Yi0+ZGF0YVtza2ItPmxlbiAtIE1US19DT1JFRFVNUF9FTkRfTEVOXSwNCj4gPiAtICAgIE1US19D
T1JFRFVNUF9FTkQsIE1US19DT1JFRFVNUF9FTkRfTEVOIC0gMSkpIHsNCj4gPiAtYnRfZGV2X2lu
Zm8oaGRldiwgIk1lZGlhdGVrIGNvcmVkdW1wIGVuZCIpOw0KPiA+IC1oY2lfZGV2Y2RfY29tcGxl
dGUoaGRldik7DQo+ID4gLX0NCj4gPiAraWYgKGNvbXBsZXRlKSB7DQo+ID4gK2J0X2Rldl9pbmZv
KGhkZXYsICJNZWRpYXRlayBjb3JlZHVtcCBlbmQiKTsNCj4gPiAraGNpX2RldmNkX2NvbXBsZXRl
KGhkZXYpOw0KPiA+ICt9DQo+ID4gIA0KPiA+ICBicmVhazsNCj4gPiAgfQ0KPiA+IC0tIA0KPiA+
IDIuMzQuMQ0KPiA+IA0KPiA+IA0KPiANCj4gSGksIGFueW9uZSBjYW4gaGVscCByZXZpZXcgdGhp
cz8NCj4gDQo+IFRoYW5rcy4NCg0KSGkgVGhhZGV1LA0KDQpTb3JyeSBmb3IgbGF0ZSByZXBseS4N
CkkndmUgYWxzbyB2ZXJpZmllZCBvbiB0aGUgcGxhdGZvcm0gd2hpY2ggc3VwcG9ydHMgZGV2Y29y
ZWR1bXAgZmVhdHVyZQ0KdGhhdCBCbHVldG9vdGggY2FuIHJlY292ZXIgYWZ0ZXIgdHJpZ2dlcnJp
bmcgZGV2Y29yZWR1bXAuDQpMR1RNLiBJdCBtYXkgbmVlZCBtYWludGFpbmVyJ3MgYXBwcm92YWwg
Zm9yIHRoZSBuZXh0IHN0ZXAuDQoNCg0KVGhhbmtzIGEgbG90IQ0KQ2hyaXMNCg0KPiBDYXNjYXJk
by4NCg==
