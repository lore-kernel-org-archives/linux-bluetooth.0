Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B338B158;
	Fri, 26 Jun 2026 02:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782441671; cv=fail; b=th/9MJYjKE2RNeZUdNW+DsjZeVTDxsOGx+tik2wk3yIg+3pXhuLY+f1wJFmsqD4BWOjmFOgXR7jRPuWdkUBFFviEp+r0yWY9fJSg+2IKq/p7CH9KgYWRFeYfJYuuzHD6ImZpqCL2Ymwh/e9xAi8JW9bgwN06OdBUlhFx51biOP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782441671; c=relaxed/simple;
	bh=vXIcVE9yoYBL2PIS2pqkOswi4tN1/QabZM6ZxdHVnCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nm2ooP8z7gLvb1/9Cei2PswBKOAH8FjSTw9JgURA1YRVDztZ4WzHcpyJIZdKnzot2BwvUZ7pulWkl9sAL2/NvmSJOlR0674NokfkAMEKbXYSUxodzvkn9YjsRLbBaBZzipmYyH1B/RJ5I2vTNs8DK+UVcVG6ZgPsBe/7NTIo9oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ex+PaTIy; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=fpmzIKyA; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ex+PaTIy";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="fpmzIKyA"
X-UUID: 77c7214c710811f1b1788b6acf885367-20260626
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vXIcVE9yoYBL2PIS2pqkOswi4tN1/QabZM6ZxdHVnCc=;
	b=Ex+PaTIyxpHGTvVURI3NPjoemINDt0fOrAW+x67PDhjMNG+op8O9vnoJC1R5j8N9m/pFStSWhjnVeT9dchngnkdh1A9o+FXR/20ml3cyPCbeKdeK/KVEEmlJzKO4NUWR3m8sDHw2UeylRBUoYCCxq+I/JgFoX2xW+ulYR8Sc/EQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:feb541ac-de33-4bfe-8353-8ba432492b2d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:d497b38,CLOUDID:cf00cf84-ff5d-4a2f-8903-3dfaa1fcebca,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50,EDM:-3,IP:nil,URL:1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 77c7214c710811f1b1788b6acf885367-20260626
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 680965944; Fri, 26 Jun 2026 10:41:00 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 26 Jun 2026 10:40:59 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 26 Jun 2026 10:40:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFBsvhdfTE1fUn5vn1e83RxvQ10MgyHZtCMvmIqiMBGZoHH39+R/WA/szPAKnm/6GMRLnWdcxJ4bcebMMk8jYh/gdVj4sx7jAqQqs6LpAhqnZzQwSmwCbZ9xgKrAsa14zYnUkYPhAmI+z0w44zOk+NTl9cI5R2IuKY4eS7WMN0Gwz89iVpmnONGLX0DjZdr4NtbtngWCezQoDIuakh3jLI2IPKqgsSKx5QCfOhZeVxT2j5/ZBMZry7M7conjF1WnSvu2NXZgq+nJl8BH1CLIy+XqAc21wFaTSUfkG38qovZH2qLb2lC5LW7tU4EInVxS2Xl22XJFXPyf5I+iMY4vhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXIcVE9yoYBL2PIS2pqkOswi4tN1/QabZM6ZxdHVnCc=;
 b=VreQ//wfKKVPL4xDxe2wd26NDJw0uWTDmd3m1CxUCw24JV1qidUep7GIjN3GORoSOU5v5BsQMgR/ebNYEzq19zvDrHP2leMwdde4o9k1ei2a5UCmUzGESOCvZ+/f7iW5hYSvfAYehkCrnNFQ9tfwXUqCQd0KhTqBiBImvb0fSKlNI0Xq3UoKvt4P0YED49LmTergfprNYh1EwEa5saQ/FajsdOsLaPrlXNGNtmBQrah2fzU7oCj0Ka7VmyL444ryCgbLEWzjwyguBpmK9jIbpwu4rj3kZwEym2vD3yj3DuXMXRE43HGDD7JBpfPB6kzR7Qf7TU1VN6iPFZht4P6uMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXIcVE9yoYBL2PIS2pqkOswi4tN1/QabZM6ZxdHVnCc=;
 b=fpmzIKyAThgxngeacbzDeV4KLofsnvTdmYVrnytt41N2ip08TyzCPkzp0mIIhZoRXsmejYans6eUu5AYcqdN9dfcKPqsIENsP5eLkPcwW1uFCS/6iut0bdylwNYj4oVndWLw2C5Ijpu+/h9fdpQHGUPwXLoKgMXc6cjC77ZS3Nk=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by SEYPR03MB7477.apcprd03.prod.outlook.com (2603:1096:101:147::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.7; Fri, 26 Jun
 2026 02:40:54 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771%4]) with mapi id 15.21.0181.006; Fri, 26 Jun 2026
 02:40:54 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "patchwork-bot+bluetooth@kernel.org" <patchwork-bot+bluetooth@kernel.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "i@rong.moe" <i@rong.moe>
CC: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925
Thread-Topic: [PATCH] Bluetooth: btmtk: Disable remote wakeup for
 MT7922/MT7925
Thread-Index: AQHdBRLBhFiAz9gODkexykUa0FLDErYs+LQAgCMnkIA=
Date: Fri, 26 Jun 2026 02:40:54 +0000
Message-ID: <3f9c376a5dbfc9d737e2a7f83c5db8e591fb8793.camel@mediatek.com>
References: <20260603-btmtk-remote-wakeup-v1-1-5c1006442f36@rong.moe>
	 <178050901239.1520440.2026593395539384648.git-patchwork-notify@kernel.org>
In-Reply-To: <178050901239.1520440.2026593395539384648.git-patchwork-notify@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|SEYPR03MB7477:EE_
x-ms-office365-filtering-correlation-id: e3568fc2-2ad6-4932-d658-08ded32c5838
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|56012099006|4143699003|22082099003|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info: qWVEAqddrI4PGIQa+e4WT3mEqTJSZ35XF9jVnjM/74F7+BrCDDPviiMo0qYoH8zVttGnotXPK6S2AIDjh046vhEKY8POQo3L5KWZRq4AF6HT0E1v3aRsUNGjYem2rHX8zthoXvWxdDZA6oV2L26HrLlcb5o8z1H6EUZyrE5mWmWRHqv+4EVIQSRbvfEjEnSTdl+SPGUE4dEmIxuiMc72BAKYIj9a1kZ9n1EGJAkIR8tqAWiPTOXJ36Rgb+1tKcCUzVU/BhEfqeX/PNufdxhVTEitSIxufZGK7xOWKSDlXu/2wNjxWQh5qVqYQVOIC31m8Lv6mVl6GVxThNtb8httVORCCUrqxWqjVMRH/MyLSWxbJ8ApezPu/Wa+yaVadn6b0JgK2q9MSmIqQ8vPGdAlpLLMQ1v0+/CGSnr8rf9OVnw6An23tL7aJUvYg1QcSBfBnvN1DNXIlONPt4CPVeEFo/F0vp0pOyAK0LlCM4jULq23s9pqkFCT8ashsohc8ynpz9z4a0/nN+VrqBJaVI1P/jRmVdakJUZR8DnRANjNvISjV1Fllj2ZVg2ndH8JnWqvt8RRA5tewB2S3Q/oU9EVxt/WzlWUOFrH/cZE3O/Cl4GfCi95/YnlGRdPDBadMQNjSExwD2JQRzIVRh6toUW4Gkr9FZhwWQyCfBAa9EBXYlSpR8ZwiGS++76lrU4OS1Fxaa4jmaUmEiLU7QvU9is7UqgAtXODDDRbN/D9l0O+HXo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(56012099006)(4143699003)(22082099003)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHdFZE5sR1lqb28xTittYVhaRFFpSVdWUnJ3OFV6RWRxQXNPVVduTVFVOGww?=
 =?utf-8?B?V3hvbFp0b1FKNkxqNFlRc2ZQTnVmeGc3YUZnRVEzRUFsLzhLOVpRclVVSTVU?=
 =?utf-8?B?SitUQmV5cmtpaGdycEJaSkNRbHV3SWEvR09NZjM3YWFBOHhweGo1bHcyS2Vw?=
 =?utf-8?B?Z2VjZUZVNWpTVTF2L3dzOERLS1dYZ1AxNUhGSHhWLzQ4dU1mdmRkWFgvQm5B?=
 =?utf-8?B?eTBaZW14QVRWUHluRUZtWEhMbVRIRVl1cjhGVURaNXdwOUYwMWlaVlJtOEl1?=
 =?utf-8?B?cHB6Vm1SMVBpL0xUa0RXaEFnRnFzZFBtNnN0S3dMaXNYNmN6V1Rvanh2R2Nv?=
 =?utf-8?B?QW5FZWlTMndrcnVNcHROdENXT29kVzQwdEZ1L0thaktUa241dytTUXdyeXU3?=
 =?utf-8?B?bmRhQWtNOXN4ekNXd1gvVHl0dThQcEJ6V2NlMjR4Q1ZWU0NFOHBJSm1mZXI2?=
 =?utf-8?B?Sk5hV21vbTZNWjlBcmU3RllkN04yYUg2TlluUkZRN0lXbTV3ZjBrejY5dFdZ?=
 =?utf-8?B?RW9WeVlCcEptL04rU2tEdVlxK2wyUElYZmN6RXdTdmp6SmpnMnFpL2dOcXcx?=
 =?utf-8?B?U21heVlaVU5tNE4xYUNWMzJvb2dodWIxamZJeVhlU1k2S1RzV1RHZ2dRWmhN?=
 =?utf-8?B?SlRaSkNGVngzZGM0M3pZRjgwRysyMTJoZEFRSW9aUTZwWkhKNFF4dGFUY2pK?=
 =?utf-8?B?UFpqT29Kd0pkalhSQnhDbGxDZmd6MVlOZkZVVWI3NlZQM2EwZzBWaW1TQnBz?=
 =?utf-8?B?WEswcEhENUFxUUFjbEJPRUx0eHZpMEtqeHpoNjg3LzBFRUVEdm9mSHZHUHJ6?=
 =?utf-8?B?ZnYyS0Z0ZWxVT0F0TmVqUXhsUytZaXFxZ0RhOTluNGlyeXErMmtrRzMwSFcz?=
 =?utf-8?B?ZmN4UVVIY1dac0I0YmJINEVPcUFyL1ZvMG5tc0I4QWp6OUV5NXV6ZHFmQzBI?=
 =?utf-8?B?L3YyRjBydE5CQWlsa2ZobTkxSTBSTDRFUE9DbENOdlMzejZSU0x3cHdzU3lH?=
 =?utf-8?B?T3ArcnBjS1JYeTF2OVVlckFJZVlxVEw1RUN2RXZsQ1pZelJvQk5aejMydUpK?=
 =?utf-8?B?V2V0OGFYQVZxUFg3Q2R6YWdncnBGa0J0UmdrSjA4enBDUGtMWlNTNm5YSkhs?=
 =?utf-8?B?K2xNNWxPUDZiaVBTaWY0dFJLdnhFTml3Zy9ka0dTWDgzWGFhaFp1eGRuNDdz?=
 =?utf-8?B?b2MrZEl3TlNLR0poSG92ellxZDZJY3RnRnhLS0prbnI4VGRlbld0Rm5Damx5?=
 =?utf-8?B?ODNNUGw4N1kvZ0hCcjkzR2JBNU41Mjd1WHg5MkY3YVFIbXF5SENzaVB2Z2th?=
 =?utf-8?B?NGhTKzl4K1pLQ1U0anVvb3EvS1VjeXhVNFVRckIvekowaVNrbzFleWFad21u?=
 =?utf-8?B?WVQ4aWlVd1FVaUhERjF1QVZTeUxCOXpnL1BlUjlUc3h1YnFSRzZFSG5NNVc5?=
 =?utf-8?B?NXhOVHloTVJwdFRyY0VBMnhqVlIzbjNjTmMyV2ZCMGtvVnIxa3hZVENwcCtq?=
 =?utf-8?B?L05UV1ZXZzhmd0pLRFowZEg3ZHJGRk8vZ0xYSUwxby9yNllhM1RxLzkvbXJa?=
 =?utf-8?B?RmwvM1haQmxLWFdOeHNsT3M4VDJGNVhlQ3k0M2xpMHFtVUhCTlI2Q3FhdzFo?=
 =?utf-8?B?azg3L1FqQ3ZNZ0Mwc3REZjhGNjZjUFpXUFBGQUVTbXBqOXFYQmRMb2ZEeGlo?=
 =?utf-8?B?cmZ1VlRDNkNxazFuRzcyb0ZhRWRld2lwME9BM3Zza1RiNjRJQVJacXVFY2Y1?=
 =?utf-8?B?TXNGTnFJSTVLakUrV2NMT0pPYkdBSTY4eWZRbzNnbm12NEFoSGNFL3NDNGYx?=
 =?utf-8?B?eS9oU3BCOFk4ZDU5QVFxcXhiQkszYWlMYnhSUmNzcGNkRjZ6VlREKzhNbi9K?=
 =?utf-8?B?cG9kSjllTURHaEJIMEZVMmZRUjhhbGh1blhFK21WKzlueHlJTHc1NDUxSGth?=
 =?utf-8?B?Z1BwZkV1TnFNaVBndC9iZGRsQWF2U09RZ0VHTnFUdWM2aUhoQmk2cHUxY3pI?=
 =?utf-8?B?d211ZzhnRTB3VTdvZVIrblFMbzFlY2R2UlVkNmNvcHhBWXpVQnpPVmlHVldM?=
 =?utf-8?B?UC9YY1JleTlnQ01PK1JWYzMvL1E1eFpyWWl4KzhTWEl3Z1NzQlVaRVo4QXJm?=
 =?utf-8?B?ZnJNS3ZrakpGU2tOZ2hSRFhLbmdwaVVITjJBY2RLOEYxMDhNRmR1WnR5VzBC?=
 =?utf-8?B?d0VZSmJjN09PR0hQWmdZYTN3QW9iN1U1RTFwOHUyNkhRdXZyM2hpR1Rnd2Zy?=
 =?utf-8?B?Q3BmUThia3RJMFpGOFdUc050M0QweGEvZ0YwNmdvdVA3UWNPa05kKzM4SmRa?=
 =?utf-8?B?bkdFZGlqbVBqbWkyL0xTeTRvM1BYRFN3RjdYdzRiUTBuMzYwcUtnUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8096201138CC6F4E9023E9A9DD698AE9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UYNhCB8wohkBgq3t/LHh03f6qBgNLZF7bYwL7y2FLVDqNwPF2icU/4fYdE7AoI0GfxiEQA58Z6eM1I5NvjQQL/ZqoaxK1uHrsWt/JKxfAAI34J616ktnaBqq7dP5BdnTDRaxP33GyaWVsAbi1VGQU/71S8YvC3o/GDc8ZB9sJ/2CUTZPVfEDOUNVmaT52uiKbAdYYMP9jYfLd9RCwL+CayuZLSS7IPKhUiaUYj35NSuefZd362n5s6aia0USO7aGiMyrJ/4LEVrcI87RzMKgZCYUVxdI+7sj0f9s6n/XyKBmmhSmyhyvu7Sm7kuApL4KN3dLOdhLjn9hjspaIzJ8Ig==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3568fc2-2ad6-4932-d658-08ded32c5838
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 02:40:54.4765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kpg+bG3Jv8fnj9dgk074V+5Ett5AK5Kq2vyM0wy+G2Nvvt1G1pnrvabdZWKKuat5G3s+Eg2KZ1FqEbNtntu9NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7477

SGkgTHVpeiwNCg0KQ291bGQgd2UgcmV2ZXJ0IHRoaXMgY2hhbmdlPw0KDQpTb3JyeSwgTWVkaWFU
ZWsgd2Fzbid0IGF3YXJlIHNvbWVvbmUgc3VibWl0dGVkIHRoaXMgY2hhbmdlIGFuZCBpdCBoYWQN
CmFscmVhZHkgYmVlbiBtZXJnZWQuDQoNCk1USyBiZWxpZXZlcyB0aGlzIGlzc3VlIGlzIHN0cm9u
Z2x5IHJlbGF0ZWQgdG8gdGhlIHBsYXRmb3JtJ3MgVVNCIGh1Yg0KYmVoYXZpb3IsIFRoZSBwcm9k
dWN0IGxpbmVzIE1USyBkaXJlY3RseSBzdXBwb3J0IGhhdmVuJ3QgcmVwb3J0ZWQgc3VjaA0KaXNz
dWUuIA0KDQpEaXNhYmxlIHdha2UgY2FwYWJpbGl0eSB3b3VsZCBzZXZlcmVseSBpbXBhY3Qgd2Fr
ZSBvbiBCbHVldG9vdGggb24NCk1USydzIG9mZmljaWFsIHByb2R1Y3QgbGluZXMuIEZ1cnRoZXJt
b3JlLCB0aGlzIHBhdGNoIGxvb2tzIGxpa2UgYQ0Kd29ya2Fyb3VuZC4gVGhlcmUgc2hvdWxkIGJl
IGEgYmV0dGVyIHdheSB0byBoYW5kbGUgdGhpcyBpc3N1ZS4gV2UgaG9wZQ0KdGhpcyBjaGFuZ2Ug
Y2FuIGJlIHJldmVydGVkLg0KDQoNCk9uIFdlZCwgMjAyNi0wNi0wMyBhdCAxNzo1MCArMDAwMCwg
cGF0Y2h3b3JrLWJvdCtibHVldG9vdGhAa2VybmVsLm9yZw0Kd3JvdGU6DQo+IEhlbGxvOg0KPiAN
Cj4gVGhpcyBwYXRjaCB3YXMgYXBwbGllZCB0byBibHVldG9vdGgvYmx1ZXRvb3RoLW5leHQuZ2l0
IChtYXN0ZXIpDQo+IGJ5IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXoudm9uLmRlbnR6QGlu
dGVsLmNvbT46DQo+IA0KPiBPbiBXZWQsIDAzIEp1biAyMDI2IDAyOjM4OjEwICswODAwIHlvdSB3
cm90ZToNCj4gPiBUaGVzZSBOSUNzIGFyZSBvZnRlbiByZXBvcnRlZCB0byBsb3NlIHRoZWlyIEJs
dWV0b290aCBpbnRlcmZhY2VzLA0KPiA+IGkuZSwNCj4gPiB0aGVpciBVU0IgaW50ZXJmYWNlcyBz
dWRkZW5seSBiZWNvbWUgY29tcGxldGVseSB1bnJlc3BvbnNpdmUsDQo+ID4gY2F1c2luZw0KPiA+
IHRoZSBVU0IgY29yZSB0byByZXNldCB0aGVtLCBvbmx5IHRvIGZpbmQgdGhhdCB0aGV5IGFyZSBu
byBsb25nZXINCj4gPiBhY2Nlc3NpYmxlLiBBIHBvd2VyIGN5Y2xlIGlzIHJlcXVpcmVkIHRvIG1h
a2UgdGhlIEJsdWV0b290aA0KPiA+IGludGVyZmFjZXMNCj4gPiByZWNvdmVyLg0KPiA+IA0KPiA+
IEFmdGVyIHNvbWUgaW52ZXN0aWdhdGlvbnMsIEkgZm91bmQgdGhhdCB0aGVpciBVU0IgYXV0b3N1
c3BlbmQNCj4gPiByZW1vdGUNCj4gPiB3YWtldXAgY2FwYWJpbGl0aWVzIGFyZSBzbyBicm9rZW4g
dGhhdCB0aGV5IGFyZSBwcmVjaXNlbHkgdGhlDQo+ID4gY3VscHJpdA0KPiA+IGJlaGluZCB0aGUg
aXNzdWU6DQo+ID4gDQo+ID4gWy4uLl0NCj4gDQo+IEhlcmUgaXMgdGhlIHN1bW1hcnkgd2l0aCBs
aW5rczoNCj4gwqAgLSBCbHVldG9vdGg6IGJ0bXRrOiBEaXNhYmxlIHJlbW90ZSB3YWtldXAgZm9y
IE1UNzkyMi9NVDc5MjUNCj4gwqDCoMKgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvYmx1ZXRvb3Ro
L2JsdWV0b290aC1uZXh0L2MvMjQ3NTcwMTUxNzg5DQo+IA0KPiBZb3UgYXJlIGF3ZXNvbWUsIHRo
YW5rIHlvdSENCg0KDQpCZXN0IFJlZ2FyZHMsDQpDaHJpcyBMdQ0K
