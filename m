Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B99332610;
	Mon, 14 Sep 2026 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368796; cv=fail; b=fAP8zlSyu2JF47Jrfl2/FOARWRaQSQ8Dw+J/MiDRFzhcVSUZX5aURHxXZLlGk1X6MHsv6sm2Wgi9n6G74A6Nu5QG2qpN6A2yMd5YWCMys1DZeE5C1Bu1xA7MH13XCeUT9XJZu8Y6lRlidH7tmX3a5CetBCeeOAKaPaZGwZrMnrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368796; c=relaxed/simple;
	bh=mfZm4zIQpbiFIgIR8RSGXaoFW18F+GCSCcHwRHidiuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S2l+JZxEpWc15a7GJ2iRjNM+Jo7Lw/XOb1pQignQGVY74YsOjLCJK708vL6QWGv+WZRwky2pi70LkqVmbJQ2GusefgkAF4k07KdFY3PP19KzT7jqMKzkTE5l02sbKDWqEXH4x9d8mfPB0FEUpOhTW+xOCSIvJM9Akb3mCogjpTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Yu2GtDKz; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=eOtqa1/l; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Yu2GtDKz";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="eOtqa1/l"
X-UUID: effc0530b00811f18dc8c9802ae25ab1-20260914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mfZm4zIQpbiFIgIR8RSGXaoFW18F+GCSCcHwRHidiuU=;
	b=Yu2GtDKzkzRsz9V9AWOYAi0N1OCG9lPwmsTdNIVGyFa9ydmuePj72BNLlxlbSyMqZRFzP/OhXSYZA57vxYKyNopG1tczDr9IqtOl5lxQDWlCQf1uM7BNaB/kpxXSaymyqheR0JVsPevAQE/9nkPimzjBc91jexu4u77itsGEnh0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:94ff6387-be2b-4c8d-9080-f106fd663cef,IP:0,U
	RL:12,TC:0,Content:9,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:21
X-CID-META: VersionHash:7db8b62,CLOUDID:c40b3fd1-f9b0-4ba3-931f-dd1de252a72d,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
	:-5,Content:4|15|50|99,EDM:-3|-100,IP:nil,URL:11|95|82|106|99|80|1,File:13
	0,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DK
	P:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: effc0530b00811f18dc8c9802ae25ab1-20260914
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 750991846; Mon, 14 Sep 2026 14:53:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 14 Sep 2026 14:53:04 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 14 Sep 2026 14:53:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIuK1LTKwz+RX2Zf6ANreKqW2pJndhZsP8EngBnjh6r7vY5XK64IwtZaDowE+hSJcNVJOJhs/8KiI7QtVPKg3XAZzGgPwrcUesMZSh+th1zWTHcJHP/y/uLaw+ksEJ2IuIhJ0RaK0w18KRKsgQuihrszFrHeGgt1EKLzkFN/5R35aXBXI+WIKtYtfKhcA/MwZjhvmCQAhs73tDrWIdk5JLneM77bAe62u3jUAj7Vq67lkwDIg9C7gKd/4j+p9ojAwjjKvLotF5RCuajOE3ZOko7y3SXws+bEudxXEcmAH22GmJZy4pkF3ANEUBpB9ZNSPS4gD1g1b33k6gTSwocY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfZm4zIQpbiFIgIR8RSGXaoFW18F+GCSCcHwRHidiuU=;
 b=BDDGPaMrp54HvsNA+aRmO49Y9uEnhTu5OlAy7Qt5yp4u+B9loYb0xAYsx8aPHhEImt+w24PSNNzeW68R0wecwkmZMtjgU30QrVtmHxPw84YBsbthTXPd4/WLB7jii9CyZ+zRtx0+lJEMA7LYctXA+oXF8cq8mKgri8NB5BiO8RSCwrNVpPNLifp0RcZUPu1OhNpJH6FHCuKhpkEm4MYeVRj58uMK2WY7B8HBkw1iTvVSJM0Um9UK4nnUt+ciGDsQdtK37l6qI/q509fS8rM6mBoDbOxktZM86oh9je7Oh1aqqn3wPLkBmF5p0H9b5PBxwA15o7RnhwK7epClcU4gKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfZm4zIQpbiFIgIR8RSGXaoFW18F+GCSCcHwRHidiuU=;
 b=eOtqa1/lb3xlnhE+OdkJ9fp7j1Wy+YvqZb8iaHiWnXgqEHM6GCLGgl4zTNfK6mlE+bdTQIMtLpqlHQPMQfWQObwDFdA0OMSDNKQK0gHYFskvcxvSajog/edT3R7oumR3mbJh4JEBKYhebO0Dxm8Dl1VJiKOeQyXj6PR986jllJI=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by SE3PR03MB10559.apcprd03.prod.outlook.com (2603:1096:101:323::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 06:53:01 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 06:53:01 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: =?utf-8?B?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	=?utf-8?B?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, Sean Wang
	<Sean.Wang@mediatek.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 0/3] Bluetooth: btmtk: firmware debug event routing and
 WMT FUNC_CTRL status fixes
Thread-Topic: [PATCH 0/3] Bluetooth: btmtk: firmware debug event routing and
 WMT FUNC_CTRL status fixes
Thread-Index: AQHdQdpIXacUA6hYrE2hdgct/zaxR7bJcWgAgAQ2N4A=
Date: Mon, 14 Sep 2026 06:53:00 +0000
Message-ID: <a192906e6881226d18583a1c25ca5ccb2731f8fd.camel@mediatek.com>
References: <20260911104234.2276126-1-chris.lu@mediatek.com>
	 <CABBYNZ+SD=KAyMwGf_cBZARONqXhjTg2O-r5FHTqUyMrsprZMQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+SD=KAyMwGf_cBZARONqXhjTg2O-r5FHTqUyMrsprZMQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|SE3PR03MB10559:EE_
x-ms-office365-filtering-correlation-id: 647884a9-e24c-47ea-66c3-08df122cd166
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|4143699003|56012099006|6133799003|4133799003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: AlstrAM3AHxagjDmuMMqRUAp2g7L715gTCBhqWPA+26g/rrzxVa45Djsv3u8QosRHhCWAlNERfk6WIRUGoxILf/xvp5UgufimyWI/YIQg3DHDhUXY12RmbRoXeRZGM84o1si7Fb8Mz5Hv2CKciJ7X6JMN49Zw91bJ9mh/ddBy3wQixm3yj0Ixn2Xl+Y84sQ1+wEIkNy2Wiy+Xa98t5SOlyPrbwy3cH7rf4sf43+6VZeDKSMCjhZJcm/Gi5sTDuIPlm9NZ18gDTt90HGuwiPbPap9eqJERIbl20WyGkHmQ/dmKRXCNYddJkEaXS4otJ+HR6ioFT47/k2iOUghW8ng666jeCG23G7HwBvxYHI1uiqsAQOYTwY4GHMHqdZUhMgUaleqyG+Ifkrv4mvJVqPdTPu5mP059Y3LI702OZQNizanESYgOAf2/DPyAcbvI4Vj4KjfC3SWchIREFNMaAoblHPjzIbwzbDf0YipwQvaO3CXhYOeZpV8RsKDMZ32qHEZm7VLUkpfWwQ7/UttLcPyh7uyDTqOZ0sXmrmC907r6WARj6tK8G81Hxgfj0P9p8owA4QOkYWgxPvjU+yCuNVDFoa/NGusp0O/Kx1G2mhfLZtSxLDKYBcqJxO++7Hwl+24hbKOLNVDxSHeij9c3AgzK4lc/JzaDHljL3YRrmXQyQs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(4143699003)(56012099006)(6133799003)(4133799003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTZaWGhMOWw0aDZIeVh0ejdabzVWMlZ2VTlaNVh0YkRBRDNJdGlKWEZ2c2JH?=
 =?utf-8?B?WnIvZlZQUU5zTVlPbkpoZFdyUXJxaklaT3kxVDNXMjhnbzB5b2FiN24zTkFF?=
 =?utf-8?B?aTBDeFM1VkNjUjdpb3M5aUFsY3JFLzdmbjFWbkRCNWtLcTgreUxyS3dqZ081?=
 =?utf-8?B?T1NramJ5bkZNclJCallKQTBtbkliVjlwN3FrR3JRWFhCNEE5QXNCdDRxbWtL?=
 =?utf-8?B?MFYzcVN3QS9rQTNBVGx0SEUrb1FHVXdwRzRzczBHNmtZdlMreGJkL3dMRVhq?=
 =?utf-8?B?dEN3bSszSE9uNU9FSHNCMldtOHkwQ0NJK011dGkvM2VwNlZXeTFWN3hiTjNi?=
 =?utf-8?B?QVQ4SHNIL1lVMmZjaW84aUswejNNVUVqVGJQWkp0cG8vR3RYTUwrNlpsOTl1?=
 =?utf-8?B?NE9PTzdVbG1yaDg3cnBIdEpZZFIwNU9BU0tob0cwTTNCUmNycG15UkxsSFh3?=
 =?utf-8?B?TGtEc05UWHRwN0V1VjdaMFlrdWxQdUd4MEEyQTFTTjBWWTk2THQ0aDJ5bEhS?=
 =?utf-8?B?UVpGaTZvRTlvMlJnZG91U1Vka2NtNjMxZzA3ME9tcUwzRjhvTnBONE1IT0xi?=
 =?utf-8?B?NGJYRG1Hb2xKYlNYQVJIRVBXSG9CZDZDV203T01VbC9ld2Y4TS9jWWRjb0R6?=
 =?utf-8?B?d2NuVXlyZkozZFVYa2JDNE1PeUJVMFhVRkE1cGozTnJ0bzlpR2tSaGFEK2Ja?=
 =?utf-8?B?N1pndGh6ck5lbkxRQ2FmSnRvbzhNRHRTemlaVGl3SjM1OEV2cHZydFVuSUMx?=
 =?utf-8?B?TVJVTXpDYkIrQUtDNEtEL2VlMDA1empCdkJGdkpyZDZYZEY1NitLOCtaZzlm?=
 =?utf-8?B?eEtHa3dLMEppMHYzTlE3MU8zM2tuRDNJeUVITVBDMnVJNG5XM29JaFNvd3FC?=
 =?utf-8?B?SEt1QUhqSm1McWUxaW00NFVRZkFhMHdWaHNrQXQyWDd3R3k0L3hJWFJMS2Yx?=
 =?utf-8?B?bi9sVVpkdWF5OWp4ekUzdDFINkI3V3Frb3RSb1ZEeFpRRm5tdEhvazBXc1BU?=
 =?utf-8?B?cDRKeitEdTFQMXNrTzRkMFVWbzNybXFMZkpsWFJQRE9XcXlsRFRDdCtNaTFS?=
 =?utf-8?B?akgxTmdEZ1A5czJUT3ZKZnFwR0VQcHQwdVhqeUV6QzB1d3hUelJnZjlraFBG?=
 =?utf-8?B?Zm8rNDVGNVMvakVkU01SYW9vRnYxRDZhN3dsRXNoejhudVloVmdFNi9lTFRo?=
 =?utf-8?B?V3dCbVMxUWkrdmlhcmZTSUhuenhhWm9aeGdqVHNzK2JtY1pkdzRNYTEzMFlL?=
 =?utf-8?B?QWJTVkZ4SGtCM2NmdUQvSnJnRnJyNUY2OHhkYkhmMFgvT0cyVWxTdE0wR1pZ?=
 =?utf-8?B?dlRGMUE3MENYOFNLWVNRTWQycmk4a2E3Wk81RStxVklPQ2JHbktaQTVzQnd5?=
 =?utf-8?B?Q3gvdWIwSnQ3QmZYeTRQOXp6NFE0MFRHcVd1dE9TLzZjRTduOTA4MmVNZ01o?=
 =?utf-8?B?SGkvc2Q1RTFxNFQzUEV5ZUZ3cUpyYkJzZ0FLVXY5cWVWS1VLMXRXaEZ3MmVV?=
 =?utf-8?B?ZVRqWDB0TU5XdjQ2OWNpVFFrc1NQYjFpWW1iQTZUWWZNT3hNU0ZTRmRBZHAx?=
 =?utf-8?B?ZnBvelcwU2lWQUZGYTdHdXBiMVNCMEg0azlkOVE0MXF6TkZTV1YvaVMyRk5G?=
 =?utf-8?B?T3QzaUNUcVhNVmlVOENjRFUvV0U2M3o3blJ5RC9pRFBBR0lmSnZxMlhuMkxm?=
 =?utf-8?B?TXlWdHlwKzFUVUhvbFU2WDVxbVVjZDJTVi96b3JBSk13eEhPdVFNNGdlRVdO?=
 =?utf-8?B?TktiNDVJK1lvRzBteFdsb2JPNUZ0dUhsZ3FqKy9QN1ZKaUhZUVQ5WXIyYmlq?=
 =?utf-8?B?YlhlRWJpMnM5S1RwRzhzTkdtY1ViMnorWGkrYy9kT3NoaDNLb0Rqcm9YL1Bo?=
 =?utf-8?B?NndYbnlqNW5hU04rT09RcStvUTFxVjRJY2xKV1pkbDR3cGRaWXlwVTNjclpz?=
 =?utf-8?B?YmkwMnhCUEZQNE00UWVzYnlWMTg3YUQ0Rk15cE9BWjV5SHJPemo1NTJSZFU2?=
 =?utf-8?B?ZkR4cW0zVGtpaXJiVHFYQUdTQ29SR2MxZnNmZVFsYVM2RS9EVjkvbXNQZ0hp?=
 =?utf-8?B?ZUFBWkJnTGFUS0M5U0R1WHdWWWFRSVUrM1pQNHVONVl4WVZ1UHV2OHVmUmhh?=
 =?utf-8?B?SUNrL0dQN1htK09SMzhmOGh2M2thOTBKeEVhMDB1RVQ5ZFdrMnJIK2owS2lG?=
 =?utf-8?B?ZkhJWlBVTjFqd3lUTkcyYWNWdDh3ZzFNNVN6Wk5URE9FMmNrVlViN3V6bFJB?=
 =?utf-8?B?bVcvblJGVjYwNC9RaXhGTGxSemJML2hJSlZFMnJZT1I1NFdYTkx3V2hCbnh4?=
 =?utf-8?B?YkxqdDVkMXd0N2FTSDNwQ21xVjd4NEJ1a01mdklMUHJNSEN0TDc5Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22E15CF9E600F549A19211F740119493@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n2SD5SmMDbaVawLZv/ZMkCJ1Fqt6pPcZQVJrBYSqLjtgp7tpCdNNYS9+sefPnh1YDvXj0k7jgnflxBha5PLJ4zb5mjfUuxBExA0xZGhcDPaPNCMFXhEt9wNm4NNQkvyxt44/+hf+nNyWrvD9NXISaU6V+DrgGylDFL1obTkxAztYtmyUjwHZbulHN2fGoA5lrl3Ms63g/fUOKNWprYd0XnfWs+qg/f//Nk95z/juMrVAEnOgt1Vznd3hB+OTnVyTTI/veWHszzQ2S2aH1DerSGYpMBMglr7UPfXlEbBQLw1hXR8sst7VPb801vUlaVKctO9cdJmxfjdTZz1tNf387Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647884a9-e24c-47ea-66c3-08df122cd166
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 06:53:01.0581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dk9sZ+3wM9Y36skQTp/cwciuEEt190Z0xCHY2+zGytzb59vfKd27UQKG5ZNFJwY4OKfTJf1afLTyzvRNd0+w4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR03MB10559

SGkgTHVpeiwNCg0KT24gRnJpLCAyMDI2LTA5LTExIGF0IDEwOjMzIC0wNDAwLCBMdWl6IEF1Z3Vz
dG8gdm9uIERlbnR6IHdyb3RlOg0KPiBIaSBDaHJpcywNCj4gDQo+IE9uIEZyaSwgU2VwIDExLCAy
MDI2IGF0IDY6NDLigK9BTSBDaHJpcyBMdSA8Y2hyaXMubHVAbWVkaWF0ZWsuY29tPg0KPiB3cm90
ZToNCj4gPiANCj4gPiBUaGlzIHNlcmllcyBidW5kbGVzIHRocmVlIGluZGVwZW5kZW50IE1lZGlh
VGVrIEJsdWV0b290aCBkcml2ZXINCj4gPiBmaXhlczoNCj4gPiANCj4gPiBQYXRjaCAxIGlzIGEg
cmVzZW5kIG9mIGEgZml4IHN1Ym1pdHRlZCBvbiAyNSBBdWcgMjAyNg0KPiA+ICgiQmx1ZXRvb3Ro
OiBidG10azogUm91dGUgZmlybXdhcmUgZGVidWcgZXZlbnQgdG8gdGhlIGRpYWcNCj4gPiBjaGFu
bmVsIikNCj4gPiB0aGF0IHJlY2VpdmVkIG5vIHJldmlldyBmZWVkYmFjay4gVGhlcmUgYXJlIG5v
IGNvZGUgY2hhbmdlcyBzaW5jZQ0KPiA+IHRoYXQgc3VibWlzc2lvbjsgcmVzZW5kaW5nIGl0IGFs
b25nc2lkZSB0aGUgdHdvIHJlbGF0ZWQgZml4ZXMNCj4gPiBiZWxvdy4NCj4gPiANCj4gPiBQYXRj
aGVzIDItMyBmaXggaG93IGJ0bXRrX3VzYl9oY2lfd210X3N5bmMoKSAoYW5kIGl0cyBidG10a3Nk
aW8uYyAvDQo+ID4gYnRtdGt1YXJ0LmMgY291bnRlcnBhcnRzKSBpbnRlcnByZXQgYSBXTVQgRlVO
Q19DVFJMIGV2ZW50IHRoYXQNCj4gPiBjYXJyaWVzDQo+ID4gb25seSB0aGUgV01UIGhlYWRlciBh
bmQgbm8gdHJhaWxpbmcgMi1ieXRlIHN0YXR1cyB3b3JkLiBTdWNoIGFuDQo+ID4gZXZlbnQNCj4g
PiBpcyBhIG5vcm1hbCBmaXJtd2FyZSBhY2sgZm9yIGEgcGxhaW4gZW5hYmxlL2Rpc2FibGUgcmVx
dWVzdCwgd2l0aA0KPiA+IHRoZQ0KPiA+IHJlc3VsdCBjYXJyaWVkIGluIHRoZSBoZWFkZXIncyBv
d24gZmxhZyBieXRlLCBub3QgYSBmYWlsdXJlIGFzIHRoZQ0KPiA+IGN1cnJlbnQgY29kZSBhc3N1
bWVzOg0KPiA+IA0KPiA+IMKgIC0gUGF0Y2ggMiBmaXhlcyB0aGlzIGZvciBidG10ay5jLCB3aGVy
ZSBhIGJvdW5kcyBjaGVjayBhbHJlYWR5DQo+ID4gwqDCoMKgIGV4aXN0ZWQgKGFkZGVkIGJ5IGUz
YWMwZDlmMWEyMCkgYnV0IGRlZmF1bHRlZCB0byB0aGUgd3JvbmcNCj4gPiDCoMKgwqAgcmVzdWx0
Lg0KPiA+IMKgIC0gUGF0Y2ggMyBhcHBsaWVzIHRoZSBzYW1lIGZpeCB0byBidG10a3NkaW8uYyBh
bmQgYnRtdGt1YXJ0LmMsDQo+ID4gd2hpY2gNCj4gPiDCoMKgwqAgbmV2ZXIgaGFkIGEgYm91bmRz
IGNoZWNrIGZvciB0aGlzIGV2ZW50IGF0IGFsbCBhbmQgcmVhZCAyIGJ5dGVzDQo+ID4gwqDCoMKg
IHBhc3QgdGhlIGVuZCBvZiB0aGUgcmVjZWl2ZWQgU0tCIHdoZW5ldmVyIGZpcm13YXJlIHNlbnQg
dGhlDQo+ID4gc2hvcnQNCj4gPiDCoMKgwqAgZm9ybS4gV2hpbGUgdGhlcmUsIGl0IGFsc28gYWRk
cyB0aGUgbWlzc2luZyBiYXNlIFdNVCBoZWFkZXINCj4gPiBsZW5ndGgNCj4gPiDCoMKgwqAgY2hl
Y2sgdGhhdCBidG10ay5jIGFscmVhZHkgaGFzIChza2JfcHVsbF9kYXRhKCkgYmVmb3JlIHRvdWNo
aW5nDQo+ID4gwqDCoMKgIHdtdF9ldnQtPndoZHIub3ApLCBzaW5jZSB0aGVzZSB0d28gZmlsZXMg
d2VyZSB1bmNvbmRpdGlvbmFsbHkNCj4gPiDCoMKgwqAgZGVyZWZlcmVuY2luZyB0aGF0IGZpZWxk
IHdpdGggbm8gbGVuZ3RoIHZhbGlkYXRpb24gYXQgYWxsLg0KPiA+IA0KPiA+IENocmlzIEx1ICgz
KToNCj4gPiDCoCBCbHVldG9vdGg6IGJ0bXRrOiBSb3V0ZSBmaXJtd2FyZSBkZWJ1ZyBldmVudCB0
byB0aGUgZGlhZyBjaGFubmVsDQo+ID4gwqAgQmx1ZXRvb3RoOiBidG10azogZml4IHdyb25nIHN0
YXR1cyBmb3Igc2hvcnQgV01UIEZVTkNfQ1RSTCBldmVudHMNCj4gPiDCoCBCbHVldG9vdGg6IGJ0
bXRrc2RpbywgYnRtdGt1YXJ0OiB2YWxpZGF0ZSBXTVQgZXZlbnQgbGVuZ3RoIGJlZm9yZQ0KPiA+
IMKgwqDCoCBzdHJ1Y3QgYWNjZXNzDQo+ID4gDQo+ID4gwqBkcml2ZXJzL2JsdWV0b290aC9idG10
ay5jwqDCoMKgwqAgfMKgIDggKysrKysrKy0NCj4gPiDCoGRyaXZlcnMvYmx1ZXRvb3RoL2J0bXRr
c2Rpby5jIHwgMjAgKysrKysrKysrKysrKysrKysrKy0NCj4gPiDCoGRyaXZlcnMvYmx1ZXRvb3Ro
L2J0bXRrdWFydC5jIHwgMTkgKysrKysrKysrKysrKysrKysrLQ0KPiA+IMKgMyBmaWxlcyBjaGFu
Z2VkLCA0NCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IC0tDQo+ID4g
Mi40NS4yDQo+IA0KPiBTYXNoaWtvIGZsYWdnZWQgYSBwcm9ibGVtIHJlZ2FyZGluZyB0aGUgdXNh
Z2Ugb2YgQUNMIGNvbm5lY3Rpb24NCj4gaGFuZGxlDQo+IHdpdGhvdXQgbWFza2luZyB0aGUgUEIg
ZmllbGQ6DQo+IA0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9zYXNoaWtv
LmRldi8qL3BhdGNoc2V0LzIwMjYwOTExMTA0MjM0LjIyNzYxMjYtMS1jaHJpcy5sdSo0MG1lZGlh
dGVrLmNvbV9fO0l5VSEhQ1RSTktBOXdNZzBBUmJ3IWp3TmUxVGZ1ZDAyek91Vi1TM1VHdnkxdmRK
UXRxZmZneEgxdHZOc3Y4RDRRazVvR21kLUIwMFBRWWhiaWZEeDlId1R4N0tyX19SUDJaQWpqbnJv
JA0KPiDCoA0KPiANCj4gSWYgdGhlIEhDSSBmcmFnbWVudGF0aW9uIGRvZXNuJ3QgYXBwbHkgdG8g
dGhlc2UgaGFuZGxlcywgcGxlYXNlIGFkZCBhDQo+IGNvbW1lbnQgcmVnYXJkaW5nIGl0OyBvdGhl
cndpc2UsIHVzZXJzIGxpa2UgU2FzaGlrbyB3aWxsIGtlZXANCj4gZmxhZ2dpbmcNCj4gaXQgZ29p
bmcgZm9yd2FyZC4NCj4gDQo+IA0KDQpDb25maXJtZWQgd2l0aCBNZWRpYVRlayBpbnRlcm5hbGx5
OiAweDBlZmQgKGFuZCB0aGUgb3RoZXIgdGhyZWUNCnZlbmRvci1yZXNlcnZlZCBoYW5kbGVzIGFs
cmVhZHkgaGFuZGxlZCBpbiB0aGlzIHN3aXRjaDogMHhmYzZmLCAweDA1ZmYsDQoweDA1ZmUpIGlz
IG5vdCBhIHJlYWwgY29ubmVjdGlvbiBoYW5kbGUgLS0gaXQncyB1c2VkIHRvIG11bHRpcGxleA0K
ZmlybXdhcmUgZGVidWcvZHVtcCBkYXRhIG9udG8gdGhlIEFDTCBjaGFubmVsLiBUaGlzIGV2ZW50
IGlzIGFsd2F5cw0Kc2VudCBhcyBhIHNpbmdsZSwgY29tcGxldGUgQUNMX1NUQVJUIHBhY2tldCwg
c28gSENJIGZyYWdtZW50YXRpb24NCihhbmQgdGh1cyBhIG1hdGNoaW5nIEFDTF9DT05UIGNhc2Us
IDB4MWVmZCkgbmV2ZXIgYXBwbGllcyB0byBpdC4NCg0KQWRkZWQgYSBjb21tZW50IGFib3ZlIHRo
ZSBzd2l0Y2ggc3RhdGVtZW50IGluIGJvdGggYnRtdGsuYyBhbmQNCmJ0bXRrc2Rpby5jIGV4cGxh
aW5pbmcgdGhpcyBmb3IgYWxsIGZvdXIgaGFuZGxlcywgc28gaXQncyBjbGVhciBnb2luZw0KZm9y
d2FyZC4gV2lsbCBpbmNsdWRlIGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNClRoYW5rcyBmb3Ig
Y2F0Y2hpbmcgdGhpcy4NCg0KQlJzLA0KQ2hyaXMgTHUNCg0K
