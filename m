Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23943A9DA4;
	Fri, 26 Jun 2026 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496615; cv=fail; b=CnvRenCDYM8COEQ/wWyqa/fhd0l1OYJhJ8RbVjG2aCA1diPimtxbhXhRuqXo0s6WE28WMTr75LpgWB/O2hD5B94eWmZnQLoEBLCL4zXA7IXEumnhIeGpMocLL9AvTtT5pnOUfav2PXLC43UEF3O2rOTIHqiA3J+yCDcPlyj2x1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496615; c=relaxed/simple;
	bh=LcdVXdtC0ISEPW5LFTbzcg6/Eub+M6zWN2HVLCCooPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l2LxC38J3ABJ5r7FsMr03UekqgGoCq/gUNnNg1sbCnqxfRqBdmsofETETjx/jEqFOlLAUFUKwOcOBzoY53I1+rlnbFnUKqY3ENPry87iKf+EI7ywCZjCJPKeCVqOvFkXVtI8UrMhUgCyz7l+cR/uhgx4uY7XlcmJkM8r7l+WOwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gzbubYw9; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=FOvWgSlR; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gzbubYw9";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="FOvWgSlR"
X-UUID: 6713beca718811f1b1788b6acf885367-20260627
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LcdVXdtC0ISEPW5LFTbzcg6/Eub+M6zWN2HVLCCooPU=;
	b=gzbubYw9Q5ct2lucvt2Q+Ra0jXYLKcOe83pszHTAnZ28+dmGtmwiRUxBvDH9LbbiS3i8WlIdPCHth4qxS1QR+pS50YQQt0p357kFnaEPG9XJO7h41vhcWUu/HDycn6rS0VidDkBveswPqI3gG4ZF2pODDbfKBywNzyHSqD6Y5Eo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:d6cc3053-d19d-469c-8221-ac80de2279b0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:04b293a5-9ef7-4489-861a-e83b251ece46,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6713beca718811f1b1788b6acf885367-20260627
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 388710773; Sat, 27 Jun 2026 01:56:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 27 Jun 2026 01:56:47 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Sat, 27 Jun 2026 01:56:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edy4ksX/FKC35gMKujpbGofSJVVC0dbiy6hTPChBC8kdS8DesW5tyA9NfMOllvbeYq5iBnb30BhAc1J6WLXZ9Papqn9bHYB5q28ZDJtg0P0+HxrK93TN2KqBumb4Ooes4szSzOIJNUt2S7k/2bAsTfQvYMqDue2OkENPpqUyHTsfyZ6w6VaYpvf6OlekiOTkZ2WCi/o8KF4SG78DeBrRDV3h8Tqe+inTHrWVNuMcQ29n+vabHD6ywnzNtwYyBj/oXQapaqHHjh4eGvH57ZVJpBeynFkfrfXsdl8UuVbMbdtPauh8TSi6RVKDKEOq5dx+yqdgU2no6+Q24Ty6f59W4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcdVXdtC0ISEPW5LFTbzcg6/Eub+M6zWN2HVLCCooPU=;
 b=tDz3SRiUoiI/mlaZ1HbcmFq2D7amZyi2lEoQsodxWBAxkE2gP7593Ilc2/RJL3Uio/Satj/nvieRxlzzdjeXK5HMaG59es/MU6foRKP7H6IbawVACEg1TTcoi0/mbfLmYXvWfmGyc7az0OGss1ws+h4myPsW7Gy8ek0M37eIamkIhXL0/5BGbHOk3ryRVymfABjqb+A57BDr/AE+OgMjh6R5R0g7KdmRXnCXOlj1LgHZOC26r/NWNzpKnxWRyAQ5tczry9pPm7nRNo321qLZ4bblgD35LuJUe2ZGxzMXvh36gZXqlvZWV9hxNNDPsd1lSHd8gp2/V/UWMxn05ZFYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcdVXdtC0ISEPW5LFTbzcg6/Eub+M6zWN2HVLCCooPU=;
 b=FOvWgSlRBtyKbwCo377tj6iYO3nRNKpdo5XFpnDgh5B3xT5Q6cK+bJZ3/YuUtSImk8y+70QZBwypGx9otbMg893EPGzNbeVpAJZSj+JIjBviyra3+YOARxkaM7K/n6lXHxsK2R4WHqcRxBCxe6pCZVuT/r/REHTzD8aFzauEjGI=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by SI4PR03MB10151.apcprd03.prod.outlook.com (2603:1096:4:2ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.6; Fri, 26 Jun
 2026 17:56:44 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771%4]) with mapi id 15.21.0181.006; Fri, 26 Jun 2026
 17:56:44 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "i@rong.moe" <i@rong.moe>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "patchwork-bot+bluetooth@kernel.org"
	<patchwork-bot+bluetooth@kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925
Thread-Topic: [PATCH] Bluetooth: btmtk: Disable remote wakeup for
 MT7922/MT7925
Thread-Index: AQHdBRLBhFiAz9gODkexykUa0FLDErYs+LQAgCMnkICAAJDJAIAAXb6AgAARWoA=
Date: Fri, 26 Jun 2026 17:56:44 +0000
Message-ID: <fd8587e97a48e49332a4ad36e51e18739d000250.camel@mediatek.com>
References: <20260603-btmtk-remote-wakeup-v1-1-5c1006442f36@rong.moe>
	 <178050901239.1520440.2026593395539384648.git-patchwork-notify@kernel.org>
	 <3f9c376a5dbfc9d737e2a7f83c5db8e591fb8793.camel@mediatek.com>
	 <17FE08E9-2229-4C97-846F-6FA099E22C90@rong.moe>
	 <CABBYNZ+rR71SKUEuZBTf+E3SwRNzV2-s-zt8EwNJM3PSx9qB_A@mail.gmail.com>
In-Reply-To: <CABBYNZ+rR71SKUEuZBTf+E3SwRNzV2-s-zt8EwNJM3PSx9qB_A@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|SI4PR03MB10151:EE_
x-ms-office365-filtering-correlation-id: fda60153-07f3-4318-9ddd-08ded3ac48ea
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|11063799006|56012099006|4143699003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: l4IlMizQW1De8E8IQ9JVqikln4wn0Mq3wnmD8BLf7euUcgFBn1PWzBQ+/BHxaoNK7oqKtlPs2ejeNzVTvi5xu/fY9mcPyFElcNTKjAEklZtwsHmmbGFMNKuDYeGui50BACR9gHePiTJ8qYHdgFKJGo3ykIO/UtALsDtq2IbGY7KXt1e8xIjof9e677ATiajottA6m5kB8DDohPC4HG0Ay/UL9gJJFqhxHVhiuK/0PIeFo1+AUrj0LUmqJhvZ/oDcaWPb3GLG1XzmTprLS0Z0AiSB2CZ4t6//yl5jLbub7v9tDApeggHocjMkAOU6zMuW9OBYaoEXrhjn314Nyu24ULjJHXKyQWAiTh1Xenep64eJs0X7KZ9YxVozyko0fwDzPW37qmOTSreahJfyK7JadQFxcxlC2RDC0Xlo/znZUxwXD7lxLLMCX8iSclAIL6B0HxDZZjp0qZ0BCPDrTFhULZe1xn+d1tBOds6pokp1widPoN2SVN4xRap4QQWF8CAt/vLlJSRkzgEGcmqF4vI2LBeQMVw4mNI56K8CJs+vSnFqltR3ONOHJrl4S+iYYnQvgcJOoXNmgjHOKcM3pksRhDG8jMphRz3zJOV+X4qysEzAONwUTNF8/Nm8EF9t1mt7zNamb4LxQ5sCtOOZV78cK3RgFMf+yvThFt6GvMGgGJAvv10vrKg8+VkCzhpwHltm4tj1aPth+Trl7W+e9dWON3/Bep9GhGBsX0yvVXJgh/s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(11063799006)(56012099006)(4143699003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkxXcm4vZkJmaktwVFhNMFkrK3JTYmxXRkRTdE9tWlZyNHpaZHZKNHBLMVV2?=
 =?utf-8?B?WXhVcDNYbFJsTUdRV1h1eVpjT043WnVjWE1CZWNmalpuNGlPb3d3VFBMOUo5?=
 =?utf-8?B?dzR6MUJta2Jad1grZ1dnRVNaa3loV3VNdzQvem9EMjhGczI1Wm1QTDhqMC9P?=
 =?utf-8?B?SEt6SWg4VnU4cG5wL0oybVJ6aC9La1lOdTZjRWVhMkkwRnJ5eFhvMEh3ZEtK?=
 =?utf-8?B?MlA3K3BBYmlCMElaa3NSRjBuOWt5VFJJby9mNnYwdXNFekxpUk9pc3BKNFBX?=
 =?utf-8?B?ZWNXaDkxTFVzcmcxYm1ReXRJNld5UVdteWZ1RGRsN0VJczVsOFZKbm13U3F4?=
 =?utf-8?B?ZklqdE5WVlFYSElKdXREOWlHckVDbTdXTm5QVFZwdlk1d2xEZkVnWjRwYkgr?=
 =?utf-8?B?K3ZtQ3lmZXVhK2pGN2dWV09kU3Fpd1NJN0wwZUdGa3RkVGJEMEQ2Y3NqNUlT?=
 =?utf-8?B?a1lHM3B0RTRJSE5qaTFmL085R1VXTHg1SDc1NGFNRzhYY3doVkNVd0dKYW4r?=
 =?utf-8?B?Sk8vUHNXdjhTOVc3TDVMSG1uWjlnT3dTK3k4UWw4TWQxbU5xSmdtSExOTVVB?=
 =?utf-8?B?S3FxblFYbnp2eXVSNlllQThtOHNjaXRST2pGcHR0M1pLV1dicFpWZnNGbzdO?=
 =?utf-8?B?cGN1QmwyRnp0RWtKcStmV2g5VEkxUmdzVFg3Tld1YnloUWhuZDdidjRKdmRP?=
 =?utf-8?B?Y01OVklpd0k4cTJ1RzlIclRoak9CazVBZ2Q3K3gweFBsbnNLYzFYU2c1N3VB?=
 =?utf-8?B?QTcwb2hKRTBiT2p3a0ZDTjRDQzlyaXR1RDR4VHJxSWV1T3F5SGhtcy95Z2Rx?=
 =?utf-8?B?UzdaUHZnWWszTW5jS0VJRmcvSDc3TkV5eE1OZUI0TEM0NGE5KzBYOEpGaG05?=
 =?utf-8?B?MUZNQWFpVzJqWUlkK1gzVlBBM2JmY2FLQjgyVGk0ajU5bzhNM25zdVoxOUJz?=
 =?utf-8?B?WC9WTWQzdGlDWE8wNnZWZzIwVkJBamQxZnN3YTh3dG9rcmdJY2M5VmUyOWRT?=
 =?utf-8?B?UUVPVnFQSnN1RlRueWgwZDFLbG9Bbk5ZMkJLOWNLZlZJWW8yUWlsRCtMVjdj?=
 =?utf-8?B?cUgrK0t5UDFHRS9SWWNEV1k5MDd1S1BUYTczOERsL3hyTVljTDZqbXY3SXhO?=
 =?utf-8?B?bWpIRnQ0QjFlUWw5SVNVNTdVZG9veDZPWVdrS2NXUUJUVWJIN3RIK0lzUWxM?=
 =?utf-8?B?MDFQcmluQjZ5eGp5bUh5a3h3R1VwUkRiUXNLc053ajBZeXhodFZvTjFxbzV0?=
 =?utf-8?B?Ymdob3MxZE9jVUFRcjcvZWwxdWtwMThETUhOdjJyelN1S2QxSDJQKzczVVJp?=
 =?utf-8?B?cWxQYzN3YVhETlNnUHE1dGpQNUF2TURWMDZ6UUs0RXhWK25nblhOQ3p0L0da?=
 =?utf-8?B?bVM1UkIvelJjUG1kMU5yY3ZlOGdFNVJuQ09rNkpCckpqdFppTlBHM2ZlaElY?=
 =?utf-8?B?K3phVEkwcFZ3MkdQLzBvSkJ3TGVHaUVmSTI5TUx1cVJOTHRJcDYza3FGN1dD?=
 =?utf-8?B?emFRMWIwOFBYWHpoRUlhMm00NVBadHAvVEFRNUJGMmgzYXBEMmI3WDBndjFu?=
 =?utf-8?B?bG8ybUsybVg5U0EvN0FSUmRYNUxWVVdNSWZTQ2w1VVdYeTBJT0NJWVZNd3Jm?=
 =?utf-8?B?bGxoOTRBOTQ4bngxbFVEcjg0K1Z6ZkcvTk1NZUxVejdHazRRWkdoUkY0bHBo?=
 =?utf-8?B?ZU05NEp3Zm13d2xLamZXeXJoU0NCVzdSYjh5cVBYOVBsSDNHUnQ2NDNFZGhp?=
 =?utf-8?B?UEhncGxVYmxBN0UxYWRDS0FBMXJrYy90REdJTHVaZXlmYVU0TnNOclpGczg0?=
 =?utf-8?B?VnordFN3eHdrem9zVXhpZUQxK0Q4UGFtY3h2WVYrN2Z5blNqQldnTmhSMnRD?=
 =?utf-8?B?QTNjT285RTBiS1BTYUM4Y3Z4SURYYmlBbkZMajRSRHgwYzhYWSsra0NZcnhJ?=
 =?utf-8?B?WXdURnRGb2NiUlZBREg0emZzanFiSUQ0TDZiSjFuUmtBWjdRdVVmOWRreXBh?=
 =?utf-8?B?WW1BZEVwdFJxVzBxekZtamV1eUpFNmNIbmlnUEx0Y091WmV1V2JXZU93SjBT?=
 =?utf-8?B?U2l6NjB3SVJ6aGgwS1NTdjlQQk1jaktIZEZCbUIrODREMG8xcW9DRDV0YzNN?=
 =?utf-8?B?ajR1SEtUWjhkVGwxb3JSRHZPdlpXWGJXTllqcG1YN2t6U2hvWUl0OXNycmFY?=
 =?utf-8?B?NHRhSG1GQ2dGL21SS3VZaUFZblREdExTVnFJQmlLUm50L0NtSWdqTWxkRGoz?=
 =?utf-8?B?dTFyaWdaVnNMTnU0UVM3OG9oQlcxa2hsbXRQNXBSMTVPRjdLTXRiemN4VStq?=
 =?utf-8?B?RWhoa2tSbjFmb1pBK21HM1dLK3VBWWt5VHJ1QnVGYVFMTTNRUWptdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EEE7BC41464DE46904C30862D5370D7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AvB/S5AgG3ISZiB7COz+HnEKZz4iffKjzx2lvpv7A1UhPsFm38DjDh4iCztwkcPT4oyNO6b2tv9g7cB1/8ItcUKqhRBTDu4KLi2xjc+0v8wBvANYTMZ4p1MynF6wC8fZDN/WejZwCbM6c0N+WIi1HYiF83HnFgKo/rychr7R8EXdjShexZ1Pa7OrOom/zqm5ZotnZw23R4e3Q4c7HSpfMVIlnzXMoIcGg7gaCHs3QArfSdyXpitOnH6EDnVs4Sn/HSwyDPvIM9SLfdCFozdN5jZBc8wu7WeVNlLzGjNrsY+KvsCCDYY5PWX3XSFXAbhdQTH4fNhficGMiiDoAVys7Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda60153-07f3-4318-9ddd-08ded3ac48ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 17:56:44.4172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KAy7mboppSz0Gtruu94XwZ7fwmXwuMh7Ob/Tp0GqA6bWjf+l3VJZIdPdsS249PhD5DzpFWwqr6RI/vrJtgQMRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR03MB10151

SGkgUm9uZyBhbmQgTHVpeiwNCg0KT24gRnJpLCAyMDI2LTA2LTI2IGF0IDEyOjU0IC0wNDAwLCBM
dWl6IEF1Z3VzdG8gdm9uIERlbnR6IHdyb3RlOg0KPiBIaSwNCj4gDQo+IA0KPiBPbiBGcmksIEp1
biAyNiwgMjAyNiBhdCA3OjE54oCvQU0gUm9uZyBaaGFuZyA8aUByb25nLm1vZT4gd3JvdGU6DQo+
ID4gDQo+ID4gSGkgQ2hyaXMsDQo+ID4gDQo+ID4g5LqOIDIwMjblubQ25pyIMjbml6UgR01UKzA4
OjAwIDEwOjQwOjU077yMIkNocmlzIEx1ICjpmbjnqJrms5MpIg0KPiA+IDxDaHJpcy5MdUBtZWRp
YXRlay5jb20+IOWGmemBk++8mg0KPiA+ID4gSGkgTHVpeiwNCj4gPiA+IA0KPiA+ID4gQ291bGQg
d2UgcmV2ZXJ0IHRoaXMgY2hhbmdlPw0KPiA+IA0KPiA+IFBsZWFzZSBkb24ndC4gVGhlIGZ1bmRh
bWVudGFsIGdvYWwgb2YgdGhlIHBhdGNoIGlzIHRvIG1ha2UNCj4gPiBNVDc5MjIvTVQ3OTI1ICp1
c2FibGUqIG9uIGFmZmVjdGVkIHBsYXRmb3Jtcy4NCj4gPiANCj4gPiBNb3Jlb3ZlciwgYWxtb3N0
IGFsbCByZWNlbnQgQU1EIHBsYXRmb3JtcyBzaGlwIHdpdGggTVQ3OTIyL01UNzkyNSwNCj4gPiBy
ZXZlcnRpbmcgdGhpcyBwYXRjaCBhZmZlY3RzIHF1aXRlIGEgbG90IG9mIHVzZXJzLiBBbG1vc3Qg
ZXZlcnkgQU1EDQo+ID4gcGxhdGZvcm0gSSd2ZSBtZXQgc3VmZmVycyBmcm9tIHRoZSBpc3N1ZSwg
YW5kIHRoZXJlIGFyZSBwbGVudHkgb2YNCj4gPiBidWcgcmVwb3J0cy4NCj4gPiANCj4gPiBJbnRl
bCBwbGF0Zm9ybXMgbmV2ZXIgc2hpcCB3aXRoIE1USyBXTEFOIE5JQ3MsIHNvIEkgY2FuJ3QgdGVs
bCBpZg0KPiA+IHRoZSBpc3N1ZSBpcyByZXByb2R1Y2libGUgb24gdGhlbS4NCj4gDQpXZSBzdGls
bCBoYXZlIG5vbi1BTUQgcGxhdGZvcm1zIHdpdGggTVQ3OTIyLzc5MjUsIHdoZXJlwqANCiJ3YWtl
dXAgYnkgQmx1ZXRvb3RoIiBpcyBhbiBlc3NlbnRpYWwgZmVhdHVyZS4gSW4gb3RoZXIgd29yZCwg
dGhpcw0KY2hhbmdlIHdpbGwgaGF2ZSBhIHNlcmlvdXMgaW1wYWN0IHRvIHRoZW0uDQoNCj4gV2Ug
Y2Fubm90IHJlYWxseSByZW1vdmUgaXQgYW55bW9yZSwgc2luY2UgaXQgaGFzIGFscmVhZHkgYmVl
biBwdWxsZWQuDQo+IFRoZXJlZm9yZSwgSSBzdHJvbmdseSBwcmVmZXIgdGhhdCB0aGUgaXNzdWUg
aXMgZml4ZWQgc29tZWhvdyBvciBpZg0KPiB0aGVyZSBpcyBubyBvdGhlciB3YXkgdGhlbiBhIHBy
b3BlciByZXZlcnQgcGF0Y2ggbXVzdCBiZSBzZW50LCBzaW5jZQ0KPiBJDQo+IGRvbid0IGhhdmUg
YW55IGhhcmR3YXJlIHdpdGggdGhpcyBjb250cm9sbGVyIEkgY2Fubm90IHJlYWxseSB0ZXN0DQo+
IHRoaXMNCj4gbXlzZWxmLg0KPiANCkdvdCAgaXQuDQo+ID4gPiANCj4gPiA+IFNvcnJ5LCBNZWRp
YVRlayB3YXNuJ3QgYXdhcmUgc29tZW9uZSBzdWJtaXR0ZWQgdGhpcyBjaGFuZ2UgYW5kIGl0DQo+
ID4gPiBoYWQNCj4gPiA+IGFscmVhZHkgYmVlbiBtZXJnZWQuDQo+ID4gPiANCj4gPiA+IE1USyBi
ZWxpZXZlcyB0aGlzIGlzc3VlIGlzIHN0cm9uZ2x5IHJlbGF0ZWQgdG8gdGhlIHBsYXRmb3JtJ3Mg
VVNCDQo+ID4gPiBodWINCj4gPiA+IGJlaGF2aW9yLA0KPiA+IA0KPiA+IFN0aWxsLCBJIGJlbGll
dmUgdGhhdCB0aGVyZSBhcmUgc29tZSBpbnRlcm9wZXJhYmlsaXR5IGlzc3VlcyBpbg0KPiA+IE1U
NzkyMi9NVDc5MjUncyBoYXJkd2FyZSBvciBmaXJtd2FyZSwgYXMgcmVpbml0aWFsaXppbmcgdGhl
IFhIQ0kNCj4gPiByb290IGh1YiAoYnkgbG9naWNhbGx5IHJlbW92aW5nIGl0IGZyb20gdGhlIFBD
SSBidXMgYW5kIHByb2JpbmcgaXQNCj4gPiBhZ2FpbikgZG9lc24ndCBtYWtlIGl0IHJlY292ZXIg
YXQgYWxsLg0KPiA+IA0KPiA+ID4gVGhlIHByb2R1Y3QgbGluZXMgTVRLIGRpcmVjdGx5IHN1cHBv
cnQgaGF2ZW4ndCByZXBvcnRlZCBzdWNoDQo+ID4gPiBpc3N1ZS4NCj4gPiANCj4gPiAuLi5vciBk
aWQgeW91IG1lYW4gbm9uZSBvZiB0aGUgZXhpc3RpbmcgQU1EIHBsYXRmb3JtcyBhcmUgc3VwcG9y
dGVkDQo+ID4gYnkgTVRLPw0KPiA+IA0KSSdsbCByZXBvcnQgaXQgdG8gY29ycmVzcG9uZGluZyBk
ZXBhcnRtZW50IHRvIHNlZSBpZiB0aGV5IGhhdmUgc3VjaA0KaXNzdWUuIChJJ20gbm90IGZyb20g
Qmx1ZXRvb3RoIHdpdGggQU1EIHBsYXRmb3JtIHN1cHBvcnQgdGVhbSkNCg0KPiA+ID4gDQo+ID4g
PiBEaXNhYmxlIHdha2UgY2FwYWJpbGl0eSB3b3VsZCBzZXZlcmVseSBpbXBhY3Qgd2FrZSBvbiBC
bHVldG9vdGgNCj4gPiA+IG9uDQo+ID4gPiBNVEsncyBvZmZpY2lhbCBwcm9kdWN0IGxpbmVzLg0K
PiA+IA0KPiA+IENvdWxkIHlvdSBraW5kbHkgZXhwbGFpbiAiTVRLJ3Mgb2ZmaWNpYWwgcHJvZHVj
dCBsaW5lcyI/DQo+ID4gDQpTb21lIHByb2R1Y3RzIGFyZSBtb2R1bGUgbWFrZXJzIHNlbGxpbmcg
b3VyIG1vZHVsZXMgdG8gZG93bnN0cmVhbQ0KY3VzdG9tZXJzIGRpcmVjdGx5Lg0KDQo+ID4gPiBG
dXJ0aGVybW9yZSwgdGhpcyBwYXRjaCBsb29rcyBsaWtlIGENCj4gPiA+IHdvcmthcm91bmQuIFRo
ZXJlIHNob3VsZCBiZSBhIGJldHRlciB3YXkgdG8gaGFuZGxlIHRoaXMgaXNzdWUuIFdlDQo+ID4g
PiBob3BlDQo+ID4gPiB0aGlzIGNoYW5nZSBjYW4gYmUgcmV2ZXJ0ZWQuDQo+ID4gDQo+ID4gVGhl
IGlzc3VlIGlzIHNldmVyZSBvbiBhZmZlY3RlZCBwbGF0Zm9ybXMgYnkgbWFraW5nIHRoZSBCbHVl
dG9vdGgNCj4gPiBpbnRlcmZhY2UgY29tcGxldGVseSBnb25lLiBJTUhPLCB3ZSBtdXN0IGZpZ3Vy
ZSBvdXQgdGhlICJiZXR0ZXINCj4gPiB3YXkiIGJlZm9yZSByZXZlcnRpbmcgaXQsIG9yIGVsc2Ug
aXQncyBtb3JlIGxpa2UgYnVyeWluZyB5b3VyIGhlYWQNCj4gPiBpbnRvIHNhbmQgYnkgc2hvdXRp
bmcgIndvcmtzIGZpbmUgb24gb3VyIHBsYXRmb3JtcyIgKFRNKS4NCj4gPiANCj4gPiBUaGF0IGJl
aW5nIHNhaWQsIEkgdGhpbmsgd2UgY2FuIG5hcnJvdyB0aGUgcmFuZ2Ugb2YgdGhlIHF1aXJrIGRv
d24NCj4gPiB0byBBTUQgcGxhdGZvcm1zIG9ubHkuIERvZXMgaXQgbWFrZSBzZW5zZSB0byB5b3U/
IElmIHNvLCBJIHdpbGwNCj4gPiBzdWJtaXQgYSBwYXRjaCBmb3IgdGhpcy4NCj4gDQpBcyBJIG1l
bnRpb25lZCBhYm92ZSwgd2UgaGF2ZSBtYW55IHBsYXRmb3JtcyB1c2luZyB0aGUga2VybmVsIGRy
aXZlciwNCm5vdCBqdXN0IEFNRCwNCg0KSWYgdGhpcyBjaGFuZ2UgY2FuIGJlIGxpbWl0ZWQgdG8g
c3BlY2lmaWMgcGxhdGZvcm0gLCBpdCB3b3VsZCBiZSB0aGUNCmJlc3Qgd2F5IHNvIGZhci4NCg0K
PiBPaywgdGhlbiB5b3UgZ3V5cyBwbGVhc2UgY29vcmRpbmF0ZS4gSSBkb24ndCB3YW50IHRvIHN0
YXJ0IHJlcXVpcmluZw0KPiBTaWduLU9mZi1CeSAoU09CKSBmcm9tIGRyaXZlciBhdXRob3JzIGJl
Y2F1c2UgdGhpcyBpbnN0YW5jZSBzaG93cw0KPiB0aGF0DQo+IHJlc3BvbnNlIHRpbWUgY2FuIGJl
IHZlcnkgbG9uZy4gVGhlcmVmb3JlLCB0aGUgYmVzdCB3YXkgZm9yd2FyZCBpbiBteQ0KPiBvcGlu
aW9uLCBpcyB0byBoYXZlIHRoZSBpc3N1ZSBmaXhlZCBpbiBhIHdheSB0aGF0IHdvcmtzIGZvciBi
b3RoIG9mDQo+IHlvdS4NCg0KT2YgY291cnNlLCBNZWRpYXRlayBCVCB0ZWFtIGFsc28gYWdyZWUg
dGhhdCBhbnkgaXNzdWUgbmVlZCB0byBiZQ0KcmVzb2x2ZWQsIEhvd2V2ZXIsIG9yaWdpbmFsIGlz
c3VlIGZvciB0aGlzIGNoYW5nZSByZXF1aXJlcyBmdXJ0aGVyDQp2ZXJpZmljYXRpb24gb2YgSGFy
ZHdhcmUvZmlybXdhcmUgYW5kIGV2ZW4gVVNCIGJlaGF2aW9yLiBBIGRldmljZSB0aGF0DQpjYW4g
cmVwcm9kdWNlIHRoZSBpc3N1ZSBzdGFibHkgaXMgcmVxdWlyZWQgaW4gb3JkZXIgdG8gZXhwZXJp
bWVudCBhbmQNCmlkZW50aWZ5IHRoZSByb290IGNhdXNlLg0KDQpBcyBtZW50aW9uZWQsIEknbGwg
ZGVsaXZlciBpbnRlcm5hbGx5IHRvIHJlbGF0ZSBzdXBwb3J0IHRlYW0uIElmIHRoZXkNCmhhdmUg
c2ltaWxhciBzZXR0aW5ncywgTVRLIHdpbGwgYXR0ZW1wdCB0byByZXByb2R1Y2UgaXQgYW5kIHBy
b3ZpZGUgYW4NCm9mZmljaWFsIHNvbHV0aW9uLg0KDQpUaGFua3MgdmVyeSBtdWNoIGZvciB5b3Vy
IGlucHV0IGFuZCB1bmRlcnN0YW5kaW5nLg0KDQpCZXN0IFJlZ2FyZHMsDQpDaHJpcyBMdQ0KDQo=
