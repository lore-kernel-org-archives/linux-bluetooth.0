Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3F95589C;
	Thu, 22 Aug 2024 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724306050; cv=fail; b=dBjNd9O97EZFcTtf37YAwwPjccjDXE/gqTlhXmXQ0E8Nsyjr5GOLEgM84PuLOppMTaYqrJ6Udwf+TQto4n+hxjgjVwM5/4S1QtcRreIctH9rsxldrKVqxIid23l+nIL2r5uqFlTfY37446UKOzRsyHUe5K1+d+cY/8Y6uR+lta4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724306050; c=relaxed/simple;
	bh=vtpXDMczHbPe8z30wDyvfeji6Ak0viKr34mD1yE9DV4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s4VEuksS/fg2MxcdD2wb9aOKAubrDU3ewe2U4S3F2cBbL7feE1Kmj33hgZk0tA9TGYSCID5xXCRtn6C58/eM03Qb6OJr8U+EGEEfK/tLUsNSAefktSt/qJzwlGkgr1LSJqOo+z3q/YEkL1mzHJKKnJ4vki+0sTXNYInnwlG/64U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=m6axJcxX; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=KMq/EaR8; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="m6axJcxX";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="KMq/EaR8"
X-UUID: ed44c56c604a11ef8593d301e5c8a9c0-20240822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vtpXDMczHbPe8z30wDyvfeji6Ak0viKr34mD1yE9DV4=;
	b=m6axJcxXvTsjv5YzHYaZjwjyMw8Bpgfurrkf2ZuBivyX6yekQlpsIu6/AuV1wBedd38RKA4J4Kc7rBZ6dT5chTXem9df4Tal0gioks5Vk257RBPv2mwsdRk0gLuIKskOvuwPQtvYkNxIap875MdoE0f9Ldh/OYf+T5Mrv0pRGzQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:d7e1ae21-a0c3-459e-9dc2-4b1a5fdc7417,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:2154fece-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ed44c56c604a11ef8593d301e5c8a9c0-20240822
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1260392698; Thu, 22 Aug 2024 13:53:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 21 Aug 2024 22:54:00 -0700
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 22 Aug 2024 13:54:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=up6G9a4a/9S4AvOuc1Ca6QLI6mqox+XvcHMILMuOKTUMyF6qs7P3FT6T9QS3pWz/gj7W6V/SyanCFZ6EmlRg/gbRRJTpjHLLihKng5JkO8D/QI0f8K2KnYP6NcTdNnHqSXerLSwF6iEjOlRcTWwPZbaXVTubhcdoSKTBLRPiOMgASVtmilDkp0aa8A+HDbGPSRZMwHwPcx3JVHjE11kMNv8siVgpL0YPA94fbNMjXe2D6fKJYE3X07uQngohjDa6tuIrak9aoPzUMrSdG6AUUxF21jeKE28HP/KW1Tsuh4MQ1c+ymra4lSIcNdZmpleVV+TGUNv9RioX02HqWOBuxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtpXDMczHbPe8z30wDyvfeji6Ak0viKr34mD1yE9DV4=;
 b=J8O+VkE26NFzWuzdcn4hGS5I3wbdXrW98V6bu8Z7PLYRkUszsPzx1r8oS2ssmqWC0HRO4vrrXHzfXEeK1+6VxhOlaPULpo4+ZscI3geohDjZG/7N8FzsRR+5CMRA2ktRHofGQHpwtTBe3vvYoAzo6rQ22WvcR+hb5FXRXNoO9477w6Kzx7Lanxcb8Y8eSvgehwiqhBTT4Cv7A85i/L91bjL8C+pWyMprHLYOCzLnYJ7H5XZWkDJN4qGykyr2nM1cNXWDE2u9y8latkV978fL80lwqN1voy4YD7KWFrtzWXYrTkhGY8rcBNOF3Fjfaiq91qT/XosZOH9F46T6dC1eXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtpXDMczHbPe8z30wDyvfeji6Ak0viKr34mD1yE9DV4=;
 b=KMq/EaR8T7MzK7FcDoYNSMD2ZcwdU2hmVTcCJQ3CV2u0092xUo6UO1YOrHlQrlwz4nkGT7+FgXxozw1dcBU7G3AJJ6bZV2dAwkMLUWAxRQH35zclaWlY5P+57w429/rUm4USJjc4Q0aeBH8zeOw40K6BB4mbms1RyX32kmSmHBo=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by TYUPR03MB7085.apcprd03.prod.outlook.com (2603:1096:400:358::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Thu, 22 Aug
 2024 05:53:57 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf%5]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 05:53:57 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "pavel@noa-labs.com"
	<pavel@noa-labs.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	=?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>, Sean Wang
	<Sean.Wang@mediatek.com>, =?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?=
	<Aaron.Hou@mediatek.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek MT7925 support ID
 0x13d3:0x3608
Thread-Topic: [PATCH] Bluetooth: btusb: Add Realtek MT7925 support ID
 0x13d3:0x3608
Thread-Index: AQHa9FVM9CM1Nl74FEed+I96K/R5ALIyxquA
Date: Thu, 22 Aug 2024 05:53:57 +0000
Message-ID: <2b7a1c4ee1d6e78f166d545b31f4fd3fbd252e26.camel@mediatek.com>
References: <20240821110856.22552-1-pavel@noa-labs.com>
In-Reply-To: <20240821110856.22552-1-pavel@noa-labs.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|TYUPR03MB7085:EE_
x-ms-office365-filtering-correlation-id: e64a5262-8cc3-4d34-5250-08dcc26ed02a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dEdzc0VkN2FDb0orRWlsQVdwVUxlMHRZOG5VYzVXWFZOU3dCQkEwQ1oxWVEx?=
 =?utf-8?B?Qjlpem4zMDg5NENwNU9IS3RDMTdXdFo3M1BXWmg2UUZGd2EwR05Za2s4dTZ3?=
 =?utf-8?B?QmQvK21McXlpVy9ZSlpxemJmVmlLNVBhYTNYSnpuYndiZk90WU1lLzFkcVJK?=
 =?utf-8?B?R2dDa0hrb2FXYjRTaFRGRGs1ckZIb1p5M2VCTTcxdmQyRklqZ3lPenRkVTQw?=
 =?utf-8?B?Tno4Qm9sdWs0eTJtM3hZSkw5UFNvQWVybHZRcVBRYjZvbkZESGlhdVRSMVk0?=
 =?utf-8?B?bDZaMXdTRW5uSEt3OXZtRWU4eEp5NWsyeDFQU05KbUQ3OUlZMmMxc2NiWWY1?=
 =?utf-8?B?YkNBbXduLzVaY00vbE00RWwwMHRuYVk5Qmc4WlVqNEJqZlFndUhlalR2YkQw?=
 =?utf-8?B?SHFNdlBra1pwWnc5QTZLWjY3YTNpZ2t6SHpyZzlCS2RjREJSV29Td25OSnpH?=
 =?utf-8?B?RG56UTlzUWNEbXRIZ3JrR0NLWjBzZzFVc3Joc0JybTZSakJkRWhzaytzblJy?=
 =?utf-8?B?d0JjbnZod0sxejkyMTA0SEpjbGpSTGNBSDJiM2JCbnMvbm9oNGF3ZDNjbDJS?=
 =?utf-8?B?SGllOW9EY2pBczJzclU0ZkpwK1JyVWxibkIwODR4LytxSkV3OTlUc3orU3Ar?=
 =?utf-8?B?S2xhcFltQjVQQnk1NDFvK1JyZ2JWbVU1bERINWVJSUdPbmNPUHdpZjZObWRv?=
 =?utf-8?B?MjV3Zjl6ZTVTbGhaeUU3MzlOdzVNWnF0dWdqUkdoSUlpdjlhQXhlOVB6eHpk?=
 =?utf-8?B?Wm9WSFhsYkE2RXkzTVhoOHVBOUZBMHdnWmVjNUJsYURyU3BMbzV6dnJYemNM?=
 =?utf-8?B?Wmt3L3VvdWRBQWlPMGt6QjlGMU5scWJ4MjFtdTRCWVU4M2xhc3RvRTA4bW9i?=
 =?utf-8?B?VktOaS9aVHYzU3JiT0ZoVEUrR1BhV3JwVy9wWEVUNmljV0l5MFcyLzlvTXBr?=
 =?utf-8?B?RENUS0tYeWk3SzBRMWZDV0xOTGluaFdCa1dRL0VNK0tzUFJLVmxsdzlZT1RS?=
 =?utf-8?B?TU1sMzNCeTdJZ1BXMEJCOTQzRER0UnBTcGgvMGpwNXpOaWljWnJFd2lmSjE4?=
 =?utf-8?B?VXF5ZjNtZXV4VVIyV3NjT2tlbko5clpYUHBOMjFXMmxVR013cE52bmZwZTB6?=
 =?utf-8?B?d2MzWWZ6VmFIYS9LSzNQNGVweC96SlRRTTBqTFg4M2Q1ZWNrYXYvY3hhdmp2?=
 =?utf-8?B?b3h6UGc5dDdRcWNUVG54b0ZuZ0dCUTJ2SWt6UnhOMkhjMEZzd1Faakhla3Rh?=
 =?utf-8?B?VWd4UWxxTkFiUlZEVlpzRXJmZnlUQldLQ0VEVC90QjZnVnZjMlZHUGZDSkRU?=
 =?utf-8?B?MDR4U2FHT3A1MHd0cXNqM3gzY1d4eHh5MzNuaVQ3MjQ1aU5iSTR3eFNvM3Ri?=
 =?utf-8?B?WEprcWJTTzNqZnUrMlVoUU1qMGNBbnRxRnJ0SWN6OHNwZHY0czZLbGlxa0JV?=
 =?utf-8?B?dGNOMGpFOEY4N0ZHaWxPa1Z3ako0RTRYeVZzcFJFSzNrVnZOZkNiRFVMQ1My?=
 =?utf-8?B?dE16WVdYVzFPVmN0SVNFQTd0NmM0RktkR2tPcTZqNS9VTTgvVHdUbWxtUTNn?=
 =?utf-8?B?bGFhNDlpQUorYWg5UG5icGswQWdTSjY5dkJrM3pxVlgyQk9Kd2JMNjdBUDlw?=
 =?utf-8?B?YVg5cFdVYkQ5L1lFMDY5MjMxN0F1ZkZNN1VVYTZyS2lnQ0pJdGhaSDBUb3M5?=
 =?utf-8?B?aXhIakxiU3pQMXdtREV5RDFDdHVCZDNqVTlXMWtvSWo4cHlFcU9oOVUxbVBm?=
 =?utf-8?B?bzJCWHBtYWY5ekxkR1pvRzA4NDVBTHlMaUNDYTV1dm9SVU53elhBblhZUFd0?=
 =?utf-8?B?aFA4T0ZnaVA2VHVLRGM2TjEwT3Z0bVVvYkdjaTVYR05XTWJSTFIySjBwR0Vj?=
 =?utf-8?B?TE1XTisxVWQxMkl3ZWJWOUZabEN3eTZ4WHFwNFpsalNBZkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDZRUjdJWUtBUVM0SEc1dzlYSi9iYlRjc3BoNzRMbkhHU1Jja3FnOWdVZkV0?=
 =?utf-8?B?WDRORnpHS2xuRFZPYkdUK1c2Rmd3UXM5R0hNaFRQN0NJY2JuL0FOSGZsQXgz?=
 =?utf-8?B?VzlvVTl4Qmh3aDMwVG9hSm5STmJGM1F5dk53U2pKRWdVUXgrRitnVnNZaEVy?=
 =?utf-8?B?bTBGN0VRWHFqUHVuYVU3YWlHTGcwS3hDUi9PSFo4MkdLRm9NODFjbU5qZFZT?=
 =?utf-8?B?UUREeERDMy9id1Zhc0lzbXVjMnNyTzhCRThXS3cxdkZNYVY3VW9GN0s3Zkp3?=
 =?utf-8?B?NHk3ZDEyT0QvUGhiQ3hoNXUvcWVIVUJkTjNoY0NuanpYaXVRenlXZGtqVGo2?=
 =?utf-8?B?ZWZGVHEvUzdCeSs1MzJLRkVNMHFhNWpqUDBQdU5OaFdJUGZrdTArVEtaVm5U?=
 =?utf-8?B?ZUVhcmR4TkQ1OW41WWtEbFF5UFN5VzdsRFBHOVR0U1RZNmdUMGhQMk5qNE1F?=
 =?utf-8?B?VzdUQ1lKRnpkVEErWVlLakc5UG1GdzlyK21Ba2pGV1d0ZE9SMWRaWEFEMGI1?=
 =?utf-8?B?eVdEb0YxbTR5VThkOFpjMXhSbFlMMEpqTXJmNnFCZ3IyUGsvNy9rdEE0YUhK?=
 =?utf-8?B?aCtyb1YvTnFYNHBpMXd2WHVRSUR5VEd5ZU1CSHpxUnB0NTVmNFhuRlZMaEp5?=
 =?utf-8?B?T3E5VXVDRDdFMkdzVzh0amJlTXB2UEJqaHBSZGJqc1ZVL1VYTkh4SVhKL0Zk?=
 =?utf-8?B?Y0pKSy84M0JPNy8xeXZrZXVXQzJEQytaQmRjV3c1SzA4Nk9Wb3BzUG9zSDlV?=
 =?utf-8?B?Ty9zQ3hhMFFYc1ZpRzBjTnJoTE84aTh5Qm43VFFYa3l5TU9jN3VIZzVRNU5Z?=
 =?utf-8?B?NFovODhvT1FwS2l6VXVTTUd5TGJZZUgraFRxdkZWME13WHNiSmVkeWlnQ0RT?=
 =?utf-8?B?Qmg3Y2p2c21DcFBrTmZjbnp3THhxYzFDZ2F5WFVJMWpBQUhKUjlibDBJQmhK?=
 =?utf-8?B?WG9TNEk3SlJueFNUaUUwTGM0TzUxQklZT1FsU1UxT1YwNlA2RzBvT0xwUUVO?=
 =?utf-8?B?bEY0a0libzg1cmRsZjBrTUVNU1hoNnNVQ3RDMkduZCtRUkpoWXQ0TkZ3OG1q?=
 =?utf-8?B?VjdISjY0ZFVyYzlZTzB4MGdtVG9XOWQ5RDA0bDZ5eGQybVlYNGczRlVXQXI0?=
 =?utf-8?B?TTJxVUhaU2NQdlRxdXFiNXBzU2NNMGp1d1BqU3pQdVhHV1h5M2R0c3dEUGdL?=
 =?utf-8?B?eURKbDJBQ3Jnb3lZeFZieFFvaFNWcWdmRzlzTXhoblRCbGs2Q0xxNFBkODhj?=
 =?utf-8?B?enY4K3AwcUdWK0dhbW92M1lKRU9ORHdSaDA0UjArMEs3YkRaK0xLMzFpaitj?=
 =?utf-8?B?R09UUFJPeUVXV2w2Y3BpQ3AvdWo1QmRGUnMrKzJVSG96ODBpbnpUaW45bTVR?=
 =?utf-8?B?NDgyVGRoSDFUK2NTSFNCenZ1am9UR3FvejhaWjZXWUtXYjR4aUw5eU9zeUk5?=
 =?utf-8?B?VXV6SnhxYTlNbFdRZTJNdmNtQ1loNUJDTm9VL1JILzlLOWJwZ0ZEbTh3RTBW?=
 =?utf-8?B?NnZab2s1WWZVVlRmbkJ1MlBZRzVDU2lqZGdFNElEUnlOU2x4dXJaaytGcytm?=
 =?utf-8?B?S1cwZ09icGk0NTl5Mi82SGYyU1dVQVNOZ2wwak45NUhkOFp3S3Z4UjdPSG9T?=
 =?utf-8?B?UldHKzk4bFRVWXhTU1IwN1A1a1JNOG5NSENxdHJESjJWWk1JbVk2SSs4TlhV?=
 =?utf-8?B?YXpLQi9EdjIrclNSNWtycGlQOG5sVUpEdmdLSmp3RjNGZWZUYitzNTVPSkhF?=
 =?utf-8?B?Ui9RQzZPdU16L3d1NloyZ1ZyQW1vVzkwOFdmTzcwUHE4aWVOcE1pTkR5SnBR?=
 =?utf-8?B?L1czdWRPRG51VGxPQkVCVEFEOXphQ1pYL3U0WkRpd0YvZXphNkZtS1FXNGtS?=
 =?utf-8?B?UnNBSVdGY1pPeVNieGhhd2NYQkZXMDVZbVhydFNsMFhCd1pQY3hyN3lyZnhU?=
 =?utf-8?B?NWI3VDBWUVRJYS9iWDBxRFdFeGRzZlVuMVhIRnJ2akU0cjBwcE1oMmNXelZ2?=
 =?utf-8?B?Q3lXdWJiM29nSFFZWXFMWlpjeWRZNVJtZytEMUYweWUydVE4S08yVlYvK3ZN?=
 =?utf-8?B?UUpZRmR1MHhDSjI3SWRIQVZsT1lEc1RsdkU1Y3A5bEwxK04vQXhUbkxleCtR?=
 =?utf-8?B?UXBrWUhmMXRVaGFaYXNRLzZ6b1luQXJRZHdodFRFdWZTZHRCcXovTEovODdJ?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D30B985EDAECC440AF53A4237F2BDA9B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64a5262-8cc3-4d34-5250-08dcc26ed02a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 05:53:57.3767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mwRlR97W/iZ3XMDFk0JuwVh1e2pMf5I8HXqUr+2bCwP/t+SODUlkhUs222LvDrfFUSrF/GPia1A9rHJZcAaYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7085

SGkgTHVpeiBhbmQgUGF2ZWwsDQoNCkkgdGhpbmsgdGhlc2UgaXMgc29tZXRoaW5nIHdyb25nIHRv
IHRoZSB0aXRsZSBhbmQgY29udGVudCBvZiB0aGlzDQpwYXRjaC4gTVQ3OTI1IGlzIGFuIGNvbm5l
Y3Rpdml0eSBJQyBmcm9tIE1lZGlhdGVrIHJhdGhlciB0aGFuIFJlYWx0ZWsuDQoNCkFsdGhvdWdo
IHRoaXMgcGF0Y2ggaGFzIGJlZW4gYWNjcGV0ZWQgYW5kIG1lcmdlZCB0byB0aGUgbmV4dCB0cmVl
LCBJJ20NCndvbmRlcmluZyBpZiB0aGUgdHlwbyBjYW4gc3RpbGwgYmUgZml4ZWQ/IEknbSBhZnJh
aWQgdGhhdCBzdWNoIGVycm9yDQpjb3VsZCBjYXVzZSBzb21lIG1pc3VuZGVyc3RhbmRpbmcgdG8g
dXNlcnMuDQoNClRoYW5rcyBhIGxvdCENCg0KQlJzLA0KQ2hyaXMNCg0KT24gV2VkLCAyMDI0LTA4
LTIxIGF0IDE1OjA4ICswNDAwLCBQYXZlbCBOaWt1bGluIHdyb3RlOg0KPiBBZGQgdGhlIHN1cHBv
cnQgSUQgKDB4MTNkMywgMHgzNjA4KSB0byB1c2JfZGV2aWNlX2lkIHRhYmxlIGZvcg0KPiBSZWFs
dGVrIE1UNzkyNUIxNEwgZm91bmQgb24gQVctRU02MzcgV2lGaStCVCBtb2R1bGVzIGluIDIwMjQg
QXN1cw0KPiBsYXB0b3BzLg0KPiANCj4gVGhlIGRldmljZSBpbmZvIGZyb20gL3N5cy9rZXJuZWwv
ZGVidWcvdXNiL2RldmljZXMgYXMgYmVsb3cuDQo+IA0KPiBUOiAgQnVzPTAzIExldj0wMSBQcm50
PTAxIFBvcnQ9MDAgQ250PTAxIERldiM9ICAyIFNwZD00ODAgIE14Q2g9IDANCj4gRDogIFZlcj0g
Mi4xMCBDbHM9ZWYobWlzYyApIFN1Yj0wMiBQcm90PTAxIE14UFM9NjQgI0NmZ3M9ICAxDQo+IFA6
ICBWZW5kb3I9MTNkMyBQcm9kSUQ9MzYwOCBSZXY9IDEuMDANCj4gUzogIE1hbnVmYWN0dXJlcj1N
ZWRpYVRlayBJbmMuDQo+IFM6ICBQcm9kdWN0PVdpcmVsZXNzX0RldmljZQ0KPiBTOiAgU2VyaWFs
TnVtYmVyPTAwMDAwMDAwMA0KPiBDOiogI0lmcz0gMyBDZmcjPSAxIEF0cj1lMCBNeFB3cj0xMDBt
QQ0KPiBBOiAgRmlyc3RJZiM9IDAgSWZDb3VudD0gMyBDbHM9ZTAod2xjb24pIFN1Yj0wMSBQcm90
PTAxDQo+IEk6KiBJZiM9IDAgQWx0PSAwICNFUHM9IDMgQ2xzPWUwKHdsY29uKSBTdWI9MDEgUHJv
dD0wMSBEcml2ZXI9YnR1c2INCj4gRTogIEFkPTgxKEkpIEF0cj0wMyhJbnQuKSBNeFBTPSAgMTYg
SXZsPTEyNXVzDQo+IEU6ICBBZD04MihJKSBBdHI9MDIoQnVsaykgTXhQUz0gNTEyIEl2bD0wbXMN
Cj4gRTogIEFkPTAyKE8pIEF0cj0wMihCdWxrKSBNeFBTPSA1MTIgSXZsPTBtcw0KPiBJOiogSWYj
PSAxIEFsdD0gMCAjRVBzPSAyIENscz1lMCh3bGNvbikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0
dXNiDQo+IEU6ICBBZD04MyhJKSBBdHI9MDEoSXNvYykgTXhQUz0gICAwIEl2bD0xbXMNCj4gRTog
IEFkPTAzKE8pIEF0cj0wMShJc29jKSBNeFBTPSAgIDAgSXZsPTFtcw0KPiBJOiAgSWYjPSAxIEFs
dD0gMSAjRVBzPSAyIENscz1lMCh3bGNvbikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQo+
IEU6ICBBZD04MyhJKSBBdHI9MDEoSXNvYykgTXhQUz0gICA5IEl2bD0xbXMNCj4gRTogIEFkPTAz
KE8pIEF0cj0wMShJc29jKSBNeFBTPSAgIDkgSXZsPTFtcw0KPiBJOiAgSWYjPSAxIEFsdD0gMiAj
RVBzPSAyIENscz1lMCh3bGNvbikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQo+IEU6ICBB
ZD04MyhJKSBBdHI9MDEoSXNvYykgTXhQUz0gIDE3IEl2bD0xbXMNCj4gRTogIEFkPTAzKE8pIEF0
cj0wMShJc29jKSBNeFBTPSAgMTcgSXZsPTFtcw0KPiBJOiAgSWYjPSAxIEFsdD0gMyAjRVBzPSAy
IENscz1lMCh3bGNvbikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQo+IEU6ICBBZD04MyhJ
KSBBdHI9MDEoSXNvYykgTXhQUz0gIDI1IEl2bD0xbXMNCj4gRTogIEFkPTAzKE8pIEF0cj0wMShJ
c29jKSBNeFBTPSAgMjUgSXZsPTFtcw0KPiBJOiAgSWYjPSAxIEFsdD0gNCAjRVBzPSAyIENscz1l
MCh3bGNvbikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQo+IEU6ICBBZD04MyhJKSBBdHI9
MDEoSXNvYykgTXhQUz0gIDMzIEl2bD0xbXMNCj4gRTogIEFkPTAzKE8pIEF0cj0wMShJc29jKSBN
eFBTPSAgMzMgSXZsPTFtcw0KPiBJOiAgSWYjPSAxIEFsdD0gNSAjRVBzPSAyIENscz1lMCh3bGNv
bikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQo+IEU6ICBBZD04MyhJKSBBdHI9MDEoSXNv
YykgTXhQUz0gIDQ5IEl2bD0xbXMNCj4gRTogIEFkPTAzKE8pIEF0cj0wMShJc29jKSBNeFBTPSAg
NDkgSXZsPTFtcw0KPiBJOiAgSWYjPSAxIEFsdD0gNiAjRVBzPSAyIENscz1lMCh3bGNvbikgU3Vi
PTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQo+IEU6ICBBZD04MyhJKSBBdHI9MDEoSXNvYykgTXhQ
Uz0gIDYzIEl2bD0xbXMNCj4gRTogIEFkPTAzKE8pIEF0cj0wMShJc29jKSBNeFBTPSAgNjMgSXZs
PTFtcw0KPiBJOiAgSWYjPSAyIEFsdD0gMCAjRVBzPSAyIENscz1lMCh3bGNvbikgU3ViPTAxIFBy
b3Q9MDEgRHJpdmVyPWJ0dXNiDQo+IEU6ICBBZD04YShJKSBBdHI9MDMoSW50LikgTXhQUz0gIDY0
IEl2bD0xMjV1cw0KPiBFOiAgQWQ9MGEoTykgQXRyPTAzKEludC4pIE14UFM9ICA2NCBJdmw9MTI1
dXMNCj4gSToqIElmIz0gMiBBbHQ9IDEgI0VQcz0gMiBDbHM9ZTAod2xjb24pIFN1Yj0wMSBQcm90
PTAxIERyaXZlcj1idHVzYg0KPiBFOiAgQWQ9OGEoSSkgQXRyPTAzKEludC4pIE14UFM9IDUxMiBJ
dmw9MTI1dXMNCj4gRTogIEFkPTBhKE8pIEF0cj0wMyhJbnQuKSBNeFBTPSA1MTIgSXZsPTEyNXVz
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQYXZlbCBOaWt1bGluIDxwYXZlbEBub2EtbGFicy5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYyB8IDIgKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0
b290aC9idHVzYi5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0KPiBpbmRleCBiYjY5OGNh
OTguLmRmMGQyZTRhYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0K
PiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jDQo+IEBAIC02MjcsNiArNjI3LDggQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCB1c2JfZGV2aWNlX2lkIHF1aXJrc190YWJsZVtdDQo+ID0gew0K
PiAgCQkJCQkJICAgICBCVFVTQl9XSURFQkFORF9TUEUNCj4gRUNIIH0sDQo+ICAJeyBVU0JfREVW
SUNFKDB4MTNkMywgMHgzNjA0KSwgLmRyaXZlcl9pbmZvID0gQlRVU0JfTUVESUFURUsgfA0KPiAg
CQkJCQkJICAgICBCVFVTQl9XSURFQkFORF9TUEUNCj4gRUNIIH0sDQo+ICsJeyBVU0JfREVWSUNF
KDB4MTNkMywgMHgzNjA4KSwgLmRyaXZlcl9pbmZvID0gQlRVU0JfTUVESUFURUsgfA0KPiArCQkJ
CQkJICAgICBCVFVTQl9XSURFQkFORF9TUEUNCj4gRUNIIH0sDQo+ICANCj4gIAkvKiBBZGRpdGlv
bmFsIFJlYWx0ZWsgODcyM0FFIEJsdWV0b290aCBkZXZpY2VzICovDQo+ICAJeyBVU0JfREVWSUNF
KDB4MDkzMCwgMHgwMjFkKSwgLmRyaXZlcl9pbmZvID0gQlRVU0JfUkVBTFRFSyB9LA0K
