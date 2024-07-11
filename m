Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FF81C14;
	Thu, 11 Jul 2024 00:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720658775; cv=fail; b=saKc+zn9HToB2dw/hjwUDejA/Z+zwKaiCCtPS5N1Fd85Mc2b0CNi63XM0dostV75A+hH2RHaGU7hJatxMPdKCT9O/FOyp/kbfKCLEm+5GzW/D4fhekOABxxltk5/gYit3tRgcgZwcYergexaySL4oP3xW0cs8y91rmIympA0myk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720658775; c=relaxed/simple;
	bh=gpps4pSwqcGll/wf7aObzcPrvjA3Lz7XfQa2dhXlIAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fdHUMgouJwrS6gzVHunUZnYMOEMwqs7yUohPVK9MCdiTdEZ5dou6XCvP5iD4NntXe2xmYC+gbYIyJKWErDeJjRz85ycBFuSGtST2XZEr7++K250WoKqV6mlM1TQXe6Rb0QR8amaFiIwRuDsw2tXp7CQkYopjf0V6fyuJO74odok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eR+qjy5S; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=kO1zXwjz; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eR+qjy5S";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kO1zXwjz"
X-UUID: f57a19aa3f1e11efb5b96b43b535fdb4-20240711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gpps4pSwqcGll/wf7aObzcPrvjA3Lz7XfQa2dhXlIAs=;
	b=eR+qjy5SUkVscBYScNJdENtxXh4T+1ofHXB5gCT26OT1Xla+wDazC6qiHLE5/Bkgg8EwT495w0ehFFlrRq+ZM7tWXwY31OJfkg2Mee4JjSi0L4mONlitYaIYl7nbjrzbefvURiQtVTPT5PND5xMn3A3r1KUYtvnojBxjS1XIDog=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:dc62afd6-a9fd-400b-97c6-d853a9b6ad19,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:d7a832d5-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f57a19aa3f1e11efb5b96b43b535fdb4-20240711
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1010394286; Thu, 11 Jul 2024 08:46:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 11 Jul 2024 08:46:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 11 Jul 2024 08:46:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dA540OKvcgfVeSMvnSW4TudUIOqSHtzN+TR03YcWIq4aK8RG1fvfOqTEmOROqkFRBYYgcvFb5MZ3CHVIPbtA6yMliI1SY4Keqs/20kVhgKDO2fwVFSloLRk15sdiL7qzpimgAgjbeK+eJg8yVQp6eGbbEz7BwSz/e8sS3+p4MwyJtltMrk/dNLzXUtd21D9XMYEvpp1dMRvJPuzglohEhmsGq7RG1fnchxR9v4/7J125zOq2X6pXZcFZYrldDi+fyx9RUoh4Pk/Y/3QNEh2ArlZpoVPpo1LPqC7kJYH0TnZZJ59cwZDHLQA912M1gO55alQ5iuqk4sXmonHF5ubzuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpps4pSwqcGll/wf7aObzcPrvjA3Lz7XfQa2dhXlIAs=;
 b=P9rvxgvs3e2LcFD4nbdfjHuPs5rmMdwqk2RqzWi32znxR7X+hN4HOrtZmpSQZKdPMsC4pNI6GRJnnmQNwEKsdjwjM7d4oInWEnRIpyvaeB7y+tSnPrHTeMC5InJdp4FOMz2IGRp0k4mEZ1H0jp7vGMotr0kzxCDBMEsJydq4JNRxHYvOJYQucuRihezybgXVtwDzdxYj0Ln1R77rJpK8ZEdLML8qW5cfCDg8AD7tucrBsjrbel4abj0LOGJp6q9GDLn1Dt2VNHjW9ydChDtpBrol7xhSHDirCNDHWKBB8Sw2Ukt0U1v2xXq7Bh1tFG3j9hI6pK2X5U2ZEtWkZKhuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpps4pSwqcGll/wf7aObzcPrvjA3Lz7XfQa2dhXlIAs=;
 b=kO1zXwjz6jRFp4hD4wu2qta0QQG1U5g692NIrQ7w9DSIB4n9TWzEpoyE3Y8wayOFIZti1qcrO1zvLozcfrEb/p9JsM6yZxfGLrujIv6ckP1MiL65UcbElZYNogLRewLIMsihT+z5C9Z1FAXXpLHSOWxpo6wCBZbZFcyzDEoTYLA=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by JH0PR03MB7467.apcprd03.prod.outlook.com (2603:1096:990:16::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 00:46:04 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf%4]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 00:46:03 +0000
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
Subject: Re: [PATCH] Bluetooth: btmtk: Fix btmtk.c undefined reference build
 error
Thread-Topic: [PATCH] Bluetooth: btmtk: Fix btmtk.c undefined reference build
 error
Thread-Index: AQHa0pwvjlG2J3TFa0eem1JWOxVHPbHv4dOAgADQXAA=
Date: Thu, 11 Jul 2024 00:46:03 +0000
Message-ID: <933ef4f9500cb1e88c68f3e811a0df982c4089f9.camel@mediatek.com>
References: <20240710073832.4381-1-chris.lu@mediatek.com>
	 <CABBYNZLOn4pAnx70afymGWR=XRzeO4WshaX2Swew9GGp6CRnvw@mail.gmail.com>
In-Reply-To: <CABBYNZLOn4pAnx70afymGWR=XRzeO4WshaX2Swew9GGp6CRnvw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|JH0PR03MB7467:EE_
x-ms-office365-filtering-correlation-id: 3a0a085e-23c2-4f53-6a46-08dca142d78d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZE9yTTNaS1VaR3JWRkFnaHU2UlJRSm1qZWJnbllZZHo5NkthcE4yRHBpajc4?=
 =?utf-8?B?SjI5aGNNeUVFY2ZLZ3MxMkZ0WTNudjQ3OXYxVWNndzZpVExOWFQxOXJseW5T?=
 =?utf-8?B?TGc5cEg1eks4dTN2NlJ4SFRLamFLbkhlK095Wk12R2Q5bGpwUVBCOVpsRWFP?=
 =?utf-8?B?eXg5ckFzWWk3OGl0TlhJc3UzZGMzK1lOVHhKUi8yTVhTN3ZadEVwU2hBS3hr?=
 =?utf-8?B?T2ZpUGdzL2d2R2ZFQVo4SUNmdWhYM1NpMldaN1Y4STN2MWFmRWNHcmJ0VVRZ?=
 =?utf-8?B?cVJVN0NsenZEejF4QnVHNisvWHFtVkx1cmVsVm0wV0NTUis1MGFZY2w5QTdj?=
 =?utf-8?B?NmdPMkdpMnQxUmNzNWxsaWF5enlvNkJiN1N3RWprL3hSQ2tYbFN0TXFXdjAy?=
 =?utf-8?B?aU5UZFBxVlh5Q1hGK2RoSUFldVAvQWVJSkpWQUxtRWZQYTFsMEREdm16VFFl?=
 =?utf-8?B?dDhhNEZWRWFaWS85OHhxOUJHbWRJNyt6UHhldHVQajJYb1pTS1I0TXY0R3N3?=
 =?utf-8?B?Z1NpTTY2clFJRmN6eGVadzhqNHN2YXN4SWtDQUdEN0FDY3laUUJpOVI2ckw2?=
 =?utf-8?B?QktjMGZzM1VyOFFNRW13UFhoS3hadTJEN091UFlQRVl2b2ZhZWVONlhnKzN2?=
 =?utf-8?B?T1FWYTRaMmhYVm45NWhCc0pmZGRqZi84RVZvMVd5T2dnUVczdTRmd083bDM1?=
 =?utf-8?B?YTl1b3c3YUtTZlpONlNiSE1Rek15Sm9lcC8wZVVYMTJlNEp3QmxSWHI0WWla?=
 =?utf-8?B?VDk2cUZXbU9sNzdxQWNtWXJxYlVFaSsrUlg5RFZhTGk5RGJiWGpTZVJUQ2Fi?=
 =?utf-8?B?MW1Fd2VKNncwZ25aSWttdGx6NmQwQmZnK3JlcmRmcXVvTFRzMmVmVjBXR0F4?=
 =?utf-8?B?YS9mcjlRLzd3UVQyV1YwbHZ6SzlscElnK1hTSmorZUkrZTJOTnJQbXFlRzR3?=
 =?utf-8?B?M3lVSjgzRHhHcW9xV3NzaVdOM0YwaEQ1WU5SNFpjdHRmWjBkOC9UdlJJRFNt?=
 =?utf-8?B?UlNjbGtKSTdDQ21qVGZXRnlPbnYvN091Y1J1SndpUEIwY3E0VlM3TitydjZB?=
 =?utf-8?B?N21Dd0V4WWkzL3VnVVhiV3BZY2p3STRkWHZ2a3FYMzVrUFhlajhyYkpua1dW?=
 =?utf-8?B?YW9QanpKd2NZYXZVcEJ5Qm1QeWJHd2U3c1JUYzZsZkVHUVVodUloQTZCYUpR?=
 =?utf-8?B?N0NpQ0dQSnlhb2E2NUlKY3F5d1RVWGVSc0Q1ZDBIMlM1MjZJek95djNUc1N0?=
 =?utf-8?B?dE1CMXl1TmNkVW9uR3NoU1ZjY0hBdXpkREg1Q0FrdCtjWXF2MGVHRXlIVkJB?=
 =?utf-8?B?T0xwR0FhZjlPbldVK3JpWGx5Wk9NUWtnRzJYV3JibHEwMWJ1aFp6RS9pOHpz?=
 =?utf-8?B?VjhuejVlVGErcXp6V09aZyt0QU5IUjQ0Y3NSdFFHT2dTYnpzSERZSkNGYXIr?=
 =?utf-8?B?NVBIQXJYUUhLbzR2NUF0Z3BHZ2FKd2JBbS82ekx2aXo3dXE1MGdpaHpVY2Fx?=
 =?utf-8?B?MkY0UE0wYVV1Y1FEK1lIMnNEZG1Zb1dHMkhXUFRub2kxazJyS3Y5NjR0Q0ha?=
 =?utf-8?B?amZsdXlpakdpL2JVQzRqVmdmenAxUTY3UmtUOWxQdU12OWlabGZldDlRdC9l?=
 =?utf-8?B?MXAvYkZYWGlXZGV5U2oxWHlhZ1E0K0pxSU5nVmZPTVB6Ym1CcnpoU3J3Zmhn?=
 =?utf-8?B?OHlLdFlqMC9rNFlPWXdzcEJnN09wNWFoQXVEc3RGcmRwSmlCckFndkM1MkZD?=
 =?utf-8?B?OHBsUlFIMXhOc2JZSllBeGhSSWFqd0JqRW9RcUtHVHRyOXF0eEtyYitqUXhU?=
 =?utf-8?Q?UJVXetS4ccrGIBnTYtMUA2kvMGA3vSz9iqzbg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0dKVjF2TGUvL0VpdEZON3EvNHVhR0FqV0RBWXlEWk11TzhVU045NnFlNmNL?=
 =?utf-8?B?ZGl1WmJFMkpoNnNJbGFIdzNwOHVZdmVybC8xYVRPNHUzOVpwMHlMaGl5cmoz?=
 =?utf-8?B?R0VWWlBhdnM2TDhtSnFVbUVSbHkyMzNFcnh3Q3dSNHMwQWpuODV6K3lrR3pK?=
 =?utf-8?B?M29jcFl1QVF0cVZKaUhYSTZ5Y2EyRVp1d1k0ZnU4amRlMVFncjV1MmZmbmdC?=
 =?utf-8?B?QUQyNHRycTJ0M3E0TGRtV1oyT2ZOS2pzSU02U2xGMktFNjMxS25TRFY2b0Nl?=
 =?utf-8?B?Sy9nVVVlcU5RVkRCRThZTUQxMUd2S1ZNQ2lTY0pVWVU5RHI2cGQvb3FMUUtS?=
 =?utf-8?B?SDZyQUFCaG9nMHk2YzF4RytySWNXeWpsWTZSTlNUVFhCVDdSYW1zUVBMdkx3?=
 =?utf-8?B?WWFPMmhlWGxuam1vOW9mNHkrRFdhU2NBSFVBRDFDeklIOVQrSDJBSjQzRFdZ?=
 =?utf-8?B?anRqQWd2TnNqWjJZQlFhWUNKYmUwQ0hZbHdVTHBxUjZseGtxWjRJald4RzRW?=
 =?utf-8?B?Nys2czYvVHZQN1k1dk1YVXRuNjlrSzJMKzQ1MHJwNkFyNlFpN05WQmVaREVN?=
 =?utf-8?B?cS85elJTNkc0S25vcWRya2puc1dJR2UwWHdqN1g5a281Z0lYaHR1bTQ2Qlg1?=
 =?utf-8?B?OTZtcms0aE5QT0xoaVhRVktZbW1oMjFuMmlmZUQ1WjBpR2h5SEE3UVdUU1Bl?=
 =?utf-8?B?c21oc2FwNmt6RHBBbUgxcGNnL0VrSlZDb082UFQxdFhITTE2WWZ0NDFHYXFL?=
 =?utf-8?B?ZUNiOTlqeklMWEVpUTZ5TkNGSldaZGxEbGZUSEg3L2pWNEVYWTVoOWh4Umg5?=
 =?utf-8?B?a29HOGpxK0xSOUhycUorTG9kbHZnT1pUNVR1cFVCNWNwOTcwZnZkSTQzdU1I?=
 =?utf-8?B?S1lrdjJMeEp5N2QxdGlpL2liVDJacmJQbzNFQ0hTM0FFakVjcENWc3YxQ2lB?=
 =?utf-8?B?MG5GazVlNm92TTVRTWluSEl3L0hsRzhOTTZVUi9jaDQ3VUlLbTBmYk03N1p4?=
 =?utf-8?B?Y0hZcW9ucDA3cXpaTnNoM0RzT29NR2F3dy81YmNXdFppQi9OM2xvclpGRlRh?=
 =?utf-8?B?ME9CWEhtTHBPbnE4SHZwanlSbVdwcjR6SXZ2aG1WN3VTVjMydWVKQUlvL3Jh?=
 =?utf-8?B?RFhOQklWM0lVSW9DblZKS3lrN0JsVVFEb1hkNFp3QUl5SlhtbjdUTUlHRm9t?=
 =?utf-8?B?MkJZUFVxdFlWdnB6SElUeUJPYTN4RVp5OU1KbTAzZE1rcVNjbElYYUJDSW5p?=
 =?utf-8?B?aUZaN0tiY2FLejNUWUpVWm1Qa2dTWC9YcTR1ZE9GNCtWUHZodXUyUUtsRHV1?=
 =?utf-8?B?cExJLzYrWlFqa2RxWXFiOGN2SlNQbXI5elZHNXpqUGJCaStBazVhVTIwKzdv?=
 =?utf-8?B?Q2MyU1BUZ1FVMk9DYXM2b0s4YmlxcEZIbk9FQzhIZXYvNm16V3d5OExxWG0w?=
 =?utf-8?B?MHBBTjYwSzRoVUk5NFFrZFd3S2xsUTBWcnNEUFhEYnkxU2x6YzJiT3AzUDN2?=
 =?utf-8?B?cDEvZWFpSFdoK29QU1hIcHlpTlNwR0JvNkFiM211U01wRU9MbUNBNU1FaTU4?=
 =?utf-8?B?TTVLUGpvaXB6OS9pQkxycEdUQytpcVVJR0RQY2ZTbE1ud0lyditEbVhydDZt?=
 =?utf-8?B?N2hTYXBXbUZ4S1ljM2EyL1ltRzRUbWI2Y3Z0eVVnRjFENHl1ZWkybklyNzZv?=
 =?utf-8?B?UWdLWGJyUDZwUkEvYy9sQnRXMFNKTytaNjQwc2kyUStDQWJKd2xTNnlsbUtq?=
 =?utf-8?B?VjcrWUtuQlNpcmJOeUVyck4rSGM4VVFuNHJhQTc2bmhsdi9VN0MyUHBObk1H?=
 =?utf-8?B?N0ZxVCtvMXY3QXFlL0pyRTRQdlZVNkw4ODh3YjU0bEIyVnh0U0lrRVJmSzRJ?=
 =?utf-8?B?bnYzS09zQXNFTHlib0VYRlF3R20xcUdzYytnUzQ4cUhiMm1IRGV2cVZ3QytB?=
 =?utf-8?B?Nlowek1sSlkzODBuck9OKy9GSUlZbGs1bkRaQ2VDaXVrcXdoVHhLbm1UUkZo?=
 =?utf-8?B?YkJpYXh5amRTWTZTN2dQb1lHM0ZKSFRjRHpWekhCTXJtU09la1hNT1pHZTFP?=
 =?utf-8?B?VjBqLzJZU1Z1Ty9qU2tod0hDSUZOS3J0SnhZeXRwOFlEUEc0L2xJTlFYYWVT?=
 =?utf-8?B?UzdQdEZDK3B5SWhxSlVCWUt2OG5MV0pXUC9KR25hQ0V0U3pZQlBVUmZidW9H?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <125283523652094F95F90F87ADEA8193@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0a085e-23c2-4f53-6a46-08dca142d78d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 00:46:03.5881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sjM4+snDe7z5NLqKIDRsnz1OIXR5MsG1eInPe7tUKlmIXa18oQxDfw5QJPh48OFvQPVq6ea7+/uC9H/MtymEzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7467

SGkgTHVpeiwNCg0KT24gV2VkLCAyMDI0LTA3LTEwIGF0IDA4OjIwIC0wNDAwLCBMdWl6IEF1Z3Vz
dG8gdm9uIERlbnR6IHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVy
aWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEhpIENocmlzLA0KPiANCj4gT24g
V2VkLCBKdWwgMTAsIDIwMjQgYXQgMzozOOKAr0FNIENocmlzIEx1IDxjaHJpcy5sdUBtZWRpYXRl
ay5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gTWVkaWFUZWsgbW92ZSBzb21lIHVzYiBpbnRlcmZh
Y2UgcmVsYXRlZCBmdW5jdGlvbiB0byBidG10ay5jIHdoaWNoDQo+ID4gbWF5IGNhdXNlIGJ1aWxk
IGZhaWxlZCBpZiBCVCBVU0IgS2NvbmZpZyB3YXNuJ3QgZW5hYmxlZC4NCj4gPiBGaXggdW5kZWZp
bmVkIHJlZmVyZW5jZSBieSBhZGRpbmcgY29uZmlnIGNoZWNrLg0KPiA+DQo+ID4gRml4ZXM6IDM5
YTllMWM2OWU3NCBCbHVldG9vdGg6IGJ0bXRrOiBtb3ZlIGJ0dXNiX210a19oY2lfd210X3N5bmMN
Cj4gdG8gYnRtdGsuYw0KPiA+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGlu
dGVsLmNvbT4NCj4gPiBDbG9zZXM6IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVp
bGQtYWxsLzIwMjQwNzA5MTkyOC5BSDBhR1pueC1sa3BAaW50ZWwuY29tLw0KPiA+IFNpZ25lZC1v
ZmYtYnk6IENocmlzIEx1IDxjaHJpcy5sdUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmMgfCAyICsrDQo+ID4gIGRyaXZlcnMvYmx1ZXRvb3RoL2J0
bXRrLmggfCA0ICsrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idG10ay5jIGIvZHJpdmVycy9i
bHVldG9vdGgvYnRtdGsuYw0KPiA+IGluZGV4IGI3YzM0ODY4N2E3Ny4uOTc4OTI5NmFkNGY2IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmMNCj4gPiArKysgYi9kcml2
ZXJzL2JsdWV0b290aC9idG10ay5jDQo+ID4gQEAgLTQzNyw2ICs0MzcsNyBAQCBpbnQgYnRtdGtf
cHJvY2Vzc19jb3JlZHVtcChzdHJ1Y3QgaGNpX2Rldg0KPiAqaGRldiwgc3RydWN0IHNrX2J1ZmYg
KnNrYikNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MX0dQTChidG10a19wcm9jZXNzX2NvcmVk
dW1wKTsNCj4gPg0KPiA+ICsjaWYgSVNfRU5BQkxFRChDT05GSUdfQlRfSENJQlRVU0JfTVRLKQ0K
PiA+ICBzdGF0aWMgdm9pZCBidG10a191c2Jfd210X3JlY3Yoc3RydWN0IHVyYiAqdXJiKQ0KPiA+
ICB7DQo+ID4gICAgICAgICBzdHJ1Y3QgaGNpX2RldiAqaGRldiA9IHVyYi0+Y29udGV4dDsNCj4g
PiBAQCAtMTQ4Nyw2ICsxNDg4LDcgQEAgaW50IGJ0bXRrX3VzYl9zaHV0ZG93bihzdHJ1Y3QgaGNp
X2RldiAqaGRldikNCj4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4gIEVYUE9SVF9T
WU1CT0xfR1BMKGJ0bXRrX3VzYl9zaHV0ZG93bik7DQo+ID4gKyNlbmRpZg0KPiA+DQo+ID4gIE1P
RFVMRV9BVVRIT1IoIlNlYW4gV2FuZyA8c2Vhbi53YW5nQG1lZGlhdGVrLmNvbT4iKTsNCj4gPiAg
TU9EVUxFX0FVVEhPUigiTWFyayBDaGVuIDxtYXJrLXl3LmNoZW5AbWVkaWF0ZWsuY29tPiIpOw0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idG10ay5oIGIvZHJpdmVycy9ibHVl
dG9vdGgvYnRtdGsuaA0KPiA+IGluZGV4IDQ1M2VkNTEzMWEzNy4uODkwZGJlOWJlZmY4IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmgNCj4gPiArKysgYi9kcml2ZXJz
L2JsdWV0b290aC9idG10ay5oDQo+ID4gQEAgLTE2NSw2ICsxNjUsNyBAQCBzdHJ1Y3QgYnRtdGtf
ZGF0YSB7DQo+ID4gICAgICAgICBidG10a19yZXNldF9zeW5jX2Z1bmNfdCByZXNldF9zeW5jOw0K
PiA+ICAgICAgICAgc3RydWN0IGJ0bXRrX2NvcmVkdW1wX2luZm8gY2RfaW5mbzsNCj4gPg0KPiA+
ICsjaWYgSVNfRU5BQkxFRChDT05GSUdfQlRfSENJQlRVU0JfTVRLKQ0KPiA+ICAgICAgICAgc3Ry
dWN0IHVzYl9kZXZpY2UgKnVkZXY7DQo+ID4gICAgICAgICBzdHJ1Y3QgdXNiX2ludGVyZmFjZSAq
aW50ZjsNCj4gPiAgICAgICAgIHN0cnVjdCB1c2JfYW5jaG9yICpjdHJsX2FuY2hvcjsNCj4gPiBA
QCAtMTc3LDYgKzE3OCw3IEBAIHN0cnVjdCBidG10a19kYXRhIHsNCj4gPg0KPiA+ICAgICAgICAg
Lyogc3BpbmxvY2sgZm9yIElTTyBkYXRhIHRyYW5zbWlzc2lvbiAqLw0KPiA+ICAgICAgICAgc3Bp
bmxvY2tfdCBpc29yeGxvY2s7DQo+ID4gKyNlbmRpZg0KPiANCj4gSWYgSSByZWNhbGwgdGhpcyBj
b3JyZWN0bHkgaXQgaXMgbm90IGEgZ29vZCBwcmFjdGljZSB0byB1c2UgI2lmDQo+IGluc2lkZQ0K
PiBzdHJ1Y3RzIGFzIGl0IHdvdWxkIGNoYW5nZSBpdHMgb3ZlcmFsbCBzaXplLCBtZW1vcnkgbGF5
b3V0LCBldGMsIGFuZA0KPiBpdCBhbHNvIG1ha2VzIGl0IGRpZmZpY3VsdCB0byB1c2UgaWYgKElT
X0RFRklORUQpIGFuZCBsZXQgdGhlDQo+IGNvbXBpbGVyDQo+IGVsaW1pbmF0ZSBkZWFkIGNvZGUg
aW5zdGVhZCBvZiB1c2luZyB0aGUgcHJlcHJvY2Vzc29yIGxpa2UgeW91IGRvaW5nLg0KPiANCj4g
DQoNCiIjaWYiIGNhbiBiZSByZW1vdmUgaGVyZSwgdXNiLmggd2FzIGluY2x1ZGVkIGluIGVhY2gg
YyBmaWxlIGluIGNhc2UgDQptYWtpbmcgY2VydGFpbiBjb21waWxlciBlcnJvciBhcyB5b3UgbWVu
dGlvbmVkLiBJdCBzaG91bGQgYmUgZmluZSBub3QNCnRvIHNlcGFyYXRlIHRoZXNlIGVsZW1lbnQu
IEknbSBhYmxlIHRvIGJ1aWxkIHBhc3MgYWZ0ZXIgcmVtb3ZlIHRoZQ0KIiNpZiIgaGVyZSBsb2Nh
bGx5IHdpdGggc2FtZSBLY29uZmlnLg0KDQpJIHNhdyBzb21lb25lIHNlbnQgYW5vdGhlciBwYXRj
aCBmb3IgdGhpcyBpc3N1ZSBieSBhZGRpbmcgaW5saW5lICB0bw0KZWFjaCBmdW5jdGlvbi4gSXQg
d291bGQgYmUgYW5vdGhlciB3YXkgdG8gYXZvaWQgdW5kZWZpbmVkIHJlZmVyZW5jZS4NCg0KDQpU
aGFua3MsDQpDaHJpcyBMdQ0KPiA+ICB9Ow0KPiA+DQo+ID4gIHR5cGVkZWYgaW50ICgqd210X2Nt
ZF9zeW5jX2Z1bmNfdCkoc3RydWN0IGhjaV9kZXYgKiwNCj4gPiBAQCAtMjAyLDYgKzIwNCw3IEBA
IGludCBidG10a19wcm9jZXNzX2NvcmVkdW1wKHN0cnVjdCBoY2lfZGV2DQo+ICpoZGV2LCBzdHJ1
Y3Qgc2tfYnVmZiAqc2tiKTsNCj4gPiAgdm9pZCBidG10a19md19nZXRfZmlsZW5hbWUoY2hhciAq
YnVmLCBzaXplX3Qgc2l6ZSwgdTMyIGRldl9pZCwgdTMyDQo+IGZ3X3ZlciwNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1MzIgZndfZmxhdm9yKTsNCj4gPg0KPiA+ICsjaWYgSVNfRU5B
QkxFRChDT05GSUdfQlRfSENJQlRVU0JfTVRLKQ0KPiA+ICBpbnQgYnRtdGtfdXNiX3N1YnN5c19y
ZXNldChzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdTMyIGRldl9pZCk7DQo+ID4NCj4gPiAgaW50IGJ0
bXRrX3VzYl9yZWN2X2FjbChzdHJ1Y3QgaGNpX2RldiAqaGRldiwgc3RydWN0IHNrX2J1ZmYgKnNr
Yik7DQo+ID4gQEAgLTIxNiw2ICsyMTksNyBAQCBpbnQgYnRtdGtfdXNiX3N1c3BlbmQoc3RydWN0
IGhjaV9kZXYgKmhkZXYpOw0KPiA+ICBpbnQgYnRtdGtfdXNiX3NldHVwKHN0cnVjdCBoY2lfZGV2
ICpoZGV2KTsNCj4gPg0KPiA+ICBpbnQgYnRtdGtfdXNiX3NodXRkb3duKHN0cnVjdCBoY2lfZGV2
ICpoZGV2KTsNCj4gPiArI2VuZGlmDQo+ID4gICNlbHNlDQo+ID4NCj4gPiAgc3RhdGljIGlubGlu
ZSBpbnQgYnRtdGtfc2V0X2JkYWRkcihzdHJ1Y3QgaGNpX2RldiAqaGRldiwNCj4gPiAtLQ0KPiA+
IDIuMTguMA0KPiA+DQo+IA0KPiANCj4gLS0gDQo+IEx1aXogQXVndXN0byB2b24gRGVudHoNCg==
