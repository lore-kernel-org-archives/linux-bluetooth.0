Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670B92737F2;
	Wed,  1 Oct 2025 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303878; cv=fail; b=QHIAgMvWbUXvK8GY0CXKgOiwPcV6IZyp0IFqjUTcOd7ng7hKArm1VsH2X02UOxIEYyPuXjbcWD6XZ4SXLNjZtWORNWTcFo47u+IiI4Q646sBFD1pFfWQiF98/VilWglbocXF7caJLr6ope7+PaM9PVKQkEESd5CTv6Cdq4kEbeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303878; c=relaxed/simple;
	bh=xexFi8I/R+1CqtIOKv04SKXDwi+IAYkydGPyga6ql1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TEGICHQMqv5weyjfED8+ugoLB5DGyXU7yCcxku7cRGyU8r+CLMTFI1e1Ip2LBSYROSAHEnNHsVh1TyHEowIj1pgRiEb3VE2Da6bToGMYWLEyBBxsxyalGLahuhn140EfxpIxMZcZY/cugco/Hi/beQpfwdUtpp77bx+T5G9HOC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ghQh5rNY; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Dzg9Zp5i; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ghQh5rNY";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Dzg9Zp5i"
X-UUID: 9a46eab09e9811f08d9e1119e76e3a28-20251001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xexFi8I/R+1CqtIOKv04SKXDwi+IAYkydGPyga6ql1w=;
	b=ghQh5rNYqTjn3uc7ywxg9NmPPfQ+B8Wc1HJnSAsyJcvCCco6jMlXrLK04XRFxfFbNjC7fWP2lku07tI8lRMFizOVThFAq5D51iZNM7rLZyFwDaRF7guLVb7CI9U20juN6dWF6bbX5U5Q3DyZqYnUTUNcW5jfUSNRHMdO6PG9R3I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:2cd395c5-9e47-40c6-ac76-8aded2b54436,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:9bb61f6d-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9a46eab09e9811f08d9e1119e76e3a28-20251001
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 43517063; Wed, 01 Oct 2025 15:31:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 1 Oct 2025 15:31:08 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Wed, 1 Oct 2025 15:31:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMPr1FrzIpQhzXsDrr1Y1qAwxBS76JQyv8SZJ1cRnthlbpCGpPnt6FIesllI+n2/Ci/MfwnlUKtsqkQY8Sko3QaBYFYdSOancfaisyIr+DrbvsY/Iz9gCyQQfEqQFXJbqb97kvhPY0z92nRbN8qzPcdl0vxXD7jWnRmf1EYj/CuSt1VMQ3d912DGiPrBAwp8ivO9c0b4MQRkWnT4GRzPjH1orPJ2C9ymiqywZ32zM79tjPbZjW+oxunk848sj+9KjkVu9q+pCx2tuNWDZP07gNiMzOgS48s3bJBKnOPOIAIGCgf9QY3TY/73FygIGVeSzagWgXDYOzZG5OwqSKYFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xexFi8I/R+1CqtIOKv04SKXDwi+IAYkydGPyga6ql1w=;
 b=cnY5p0Z0LcUnpDmJw+Go852pGdkPW27cshqVGcFW9ohpG/M23GOry/amvZU2qU7AjK183TVQ+6FwHxlf91f7TvE32NloCjoCoFZGhc8p9+2Y05d8vbBc3k15adfCeZ6ZeWKULRH4k63kp6bC9kQxS09QK4kojvYfBD9gy9Vd6pDIfx7jCb0Nm3pOhrov3HGG5qBRXOfTnBTuLfK/2++NNvcRAzM5mhdecpx1WaaGCFAlOY5As2A39riGas1aZxVIhbNCOj874dbGe+fjbmTESGDME9QY0cS+ahhxSWEpdyYUBx8HPsLktSDLhaC6FfIBxID5//jJ0svkD8jvKnVz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xexFi8I/R+1CqtIOKv04SKXDwi+IAYkydGPyga6ql1w=;
 b=Dzg9Zp5iZPmc0RKzw/MfhCVGYlR9UdDrfrfpRb4SKTeqUJLCffa7Vqf615Xh8EJSJhr8Xb6cf75jpTB/uwV8gtegB6f5e5TZ874n9U0aR8Uu2eLCw/Kyi/xcYSXqBu/lMTrUn/YPGz2hhgrzTsT7KdWjn5ElqXLePTVw5QVUHbo=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by SEZPR03MB7631.apcprd03.prod.outlook.com (2603:1096:101:10d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 07:31:06 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf%6]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 07:31:05 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
CC: =?utf-8?B?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
	=?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, =?utf-8?B?U1MgV3UgKOW3q+aGsuasoyk=?=
	<ss.wu@mediatek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, Sean Wang <Sean.Wang@mediatek.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1 1/2] Bluetooth: btusb: Add new VID/PID 0489/e135 for
 MT7920
Thread-Topic: [PATCH v1 1/2] Bluetooth: btusb: Add new VID/PID 0489/e135 for
 MT7920
Thread-Index: AQHcMplJxmAbFA2pY06jlJArZ6IB6LSs0M0AgAAUjYA=
Date: Wed, 1 Oct 2025 07:31:05 +0000
Message-ID: <c01095336878844585d70facd75964bb43391122.camel@mediatek.com>
References: <20251001060437.2298529-1-chris.lu@mediatek.com>
	 <20251001060437.2298529-2-chris.lu@mediatek.com>
	 <632b054e-2c67-4d6d-9e61-435d1566fc4d@molgen.mpg.de>
In-Reply-To: <632b054e-2c67-4d6d-9e61-435d1566fc4d@molgen.mpg.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|SEZPR03MB7631:EE_
x-ms-office365-filtering-correlation-id: 868762fe-ca9f-4b55-94d2-08de00bc7b5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dE8ySWRHRnkzSFNZZ2h2OTVsUUNEZXMrZWM4Y0l3VmpSeHFSY21iRVdQL0FG?=
 =?utf-8?B?MTNOcVJ3MGFYc0FQY0lNSmc1elJmUHNHOUdFSFRMYkwwdFVVd1NxMVBKU3Ny?=
 =?utf-8?B?MWFncTNZdTJnemU4UHZiTklBMnl4V2ViNzNlajZlQ2txUVpxYXI5R2dYeUdz?=
 =?utf-8?B?a1hHTjJhSWNHSyt4WVdrME9la2twcGl3ak5OTis2aTJGeGtPR1BOclBDOUJT?=
 =?utf-8?B?YzBaY0VFQ2pXbTBVRDIyRmVFb3BhbW5Ta0tuQ2IrSWxUeGZ5cU9uWURoQUFj?=
 =?utf-8?B?Vkg4OWwxeHpSREpsK09vT3FZazFzZ3dRcnJ0S1NWMWFKM2s3cHVuTklmUnVs?=
 =?utf-8?B?V2hjOGw0dCtvRHdmcTc3UTdkZG1UVzdGVWNhUjFXVFlFdi9MYUk1U2xEb3dR?=
 =?utf-8?B?Nk5WN1pQcFpEbFp1eks0SGJyZ0UyYXg5NEN2VWlVTjFqbG5JRUN1VmlOY1ZO?=
 =?utf-8?B?V1l5cit3VFNhS3Y0bWVodHNjY0lVSXBlMHBIVTVJbWFGUk9LaUdtTUtDYkRp?=
 =?utf-8?B?UGs0WVBDRWlCWXJoWiswbURiRnE5bmlWVVkyZmlTcTVPMUdqUTFDOTZHZlJl?=
 =?utf-8?B?Rms5WmprZHZ3bVI3RFNtT2svSDE5ZUkzZFFMY2lRcElHOTJ0V1htcmFTUzIy?=
 =?utf-8?B?RHg0TFllcHRiakNZTFZ4Tkd4M3VKUkt4cElDOXI3S012M0xSeDZ1TGdxZFZB?=
 =?utf-8?B?Zi9NQnFDYmhPRlBOMHRtSGZjQWlYYkUvUDZHalU5MDVWVklQaXk3N0VOa3lL?=
 =?utf-8?B?SUh4MzhTdWJkUytVQTJVVjROUGhvSkgrZE9zZlhXOWR4aDNiWUdHRUdXZG9Z?=
 =?utf-8?B?alk4aFl6T2dTajdOUnloanlnY1BhVzRadjI2RnZ3ejNSS1ducVdiWERqZXJO?=
 =?utf-8?B?UVJHRGdDaUdkVTFUekN3aExFem1LekhFNGJNdFlJUnREbkJVRSt5UWNQT0Y3?=
 =?utf-8?B?ZUtRZUdyT0tSNEg0NS9GY0JlaExEQTFnRjU1eldYS2hGVG0wSGpaa2loV1d2?=
 =?utf-8?B?MGZLZm9meDlwMm5UbktPd3M5YkhsblR1VUZzUGJGclhMSThVS2NGbVBRZDZ6?=
 =?utf-8?B?TGZoWWkvbmFIcTRKR29IRmI1M1B4REt6TlVsK0dYRG5UMXoxcHUrYVBNd3BE?=
 =?utf-8?B?SHVhenhjUi9PVHRTUGljaWJUdnhkUXJTbHEySWxZZ1l1c3BCTTZFQTlwbDlI?=
 =?utf-8?B?TERoc1FtVm96bjhaaGszU0RXMFVpRmhMUWFpQWlxUktqUks2SWVXaDE5M1By?=
 =?utf-8?B?czhVenVxKzhpcGRBbXN3c1RlcEJ1ZEplZkE0cTNwSU9vYkVxZ2tucXBPTUt1?=
 =?utf-8?B?TzI4U2tYS3pwc2s3YkZuS3B1UnR1UEJFaDRrUFh6dTNVMXc4N2tPdTF1eWVj?=
 =?utf-8?B?aU96WjczNnVRT1FSUzFHb003eHZvYmkrU2V6QTRXN1hHbkEza240MFRHbDBm?=
 =?utf-8?B?Q3pjWTRNMWZjM2ZpQkFrM2lCWDliREpkRHJiOFN0bm9MYzErS0FWdXRwVUs3?=
 =?utf-8?B?K2NPUjRiNkhpVy9kWWNKQU1VZzZWMVFkLytzc1hMeGJnb3g3L3FMMFYzMzhx?=
 =?utf-8?B?V09JbXNCclpKY2dOMzZuN1pkZWUyNkwxYXBRTFJKdDBZRzNWNVNJSUczNVc3?=
 =?utf-8?B?UiszTVNyNTFKdjZraXozNVFXUXU0SDdoR0k1SUNlTFk2eCtSR0hEMFZRNTZE?=
 =?utf-8?B?TVp4V2pBNk54VkE2Y3J1SkpNRUhXOHJLS1J5bEV6VFlDN0pYT0hhaEI3VzFW?=
 =?utf-8?B?aWtyZWU3bTc4THVZclpFbVloT2ZYeFJVTkVEa1F2a1gzR1ZhdkZDdm5XVmpt?=
 =?utf-8?B?aGFGK3QxR0NUS1k2QWpDZW4vdWhodk5BOEZDK3d3VXFXeXBuOXI2MUkxekh1?=
 =?utf-8?B?NWE3SzVZNi9oSy9qZUJ2dDBYbWZYS0RhbzVsb05Ua2R4QksvWVdIREdZRTl1?=
 =?utf-8?B?OENMaGkrMlRqRGYyMms2T2lQOElYQy9veTdZQnc4MkdMT3F2RTZGc2xraE9E?=
 =?utf-8?B?dzN2bXVTU0k0MkpTdlB1OW9hTERhZWp6N3JaOHBIeG1QWmNBZzRkV0t5Szlx?=
 =?utf-8?Q?xifnqt?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkkrMjl0d0xha0JLOWoyUTg5UmRhNGxqb3Njc2U1dHVRTkY3Vml0VjFBM1ZB?=
 =?utf-8?B?MVNCM0REaU5MSDE3aTFsSWVHb1pTZ1BBUlV3dE9TVmkzUDlYUDNmU1JoVXJo?=
 =?utf-8?B?YjdNRnI5aTBwaHEya2g5L0crU0IybVIvd3BkNE5KS1RodUQyb3Q5M2hDTnM4?=
 =?utf-8?B?S2N4b1JmUUNMNThMdi9wbHNSS2hSVzBTQTY2ZVd5eGJaRFhGQmhlbHUzWmJo?=
 =?utf-8?B?eVY3YmlYdmptV21LY1lTNmp2STJvTWVGRWNmd3VxTkUyT0Y2RDQwZTE5WFUz?=
 =?utf-8?B?Z2ExcUZBQzU3UEpaRkc0bU1jNlNzZ2t3aGtsZE9CS2JsM0FjYkJ3RnlsdGVL?=
 =?utf-8?B?NDVSNVBPSlllVWpUQ29TcXZqMXJQN09LTmxXSWg5QUhnLzBKZmFTN2xEcElw?=
 =?utf-8?B?M1cyWURTWGY3R3pBSlZvdWo1akJFMlR0cXVFSTRvK1d4VnBGYnF5M00vYXRE?=
 =?utf-8?B?S1BWaERpTmh1L3FZT1RSaHNtU0dwdU81T1FwbjlzaS9ycTlLWnhLc0I2a3Jk?=
 =?utf-8?B?UjA3MzAyRzFhR0M4OCs4cVB3aDlIOGI1b0VMbDR6S1c1L2hLMEtSaFQ3RGFs?=
 =?utf-8?B?SktMQU5mYm5YYmIxKzU0VVllWWdzZ2hvUWdYeUh3d1NIVzhERkdsZENRTXo0?=
 =?utf-8?B?SFppTkNDcEM4MUh3Qk0vQm03dEt6VndvYlA1djZjeE56RzVhRXRkTkEyQjBV?=
 =?utf-8?B?dUFiT3prZzhGd3B0aE83THRTaFY1TGZlZE9lQWxLdVc0ZnNLTTBUb1FYaUUx?=
 =?utf-8?B?U3QvYTI5eVRsWEZPdFpiVnkvTDdFdXEwTFljMmFhdjZmbFJFUW1WSnFLVGJG?=
 =?utf-8?B?eU56dHNsSE9YWG5lL2N2SDNwV25mTkJUYmorTGRZV0x1U3lBMEFyWG9TTHR2?=
 =?utf-8?B?eHhXOG15dVJLYndVTHNlLy9VeUNpRmhqOFo3T0p5Ym05TE9sNzJhZjJoNXhB?=
 =?utf-8?B?OGY5dlNLZnF1QWFwMkZmYmlkL001NUxNMHNwaVhQaFZ4dnVCaTIxQU9SU1pG?=
 =?utf-8?B?U0hONjFHbDhESXhkTXBoUFpObGJpMDRiOTdRR1ozTkpGT2Rvblh4WXNJUmRD?=
 =?utf-8?B?TFZTUnIwSlZNYW5nazFjQzMyU1FZZ2d2b1FCaThsVmFxUm5RMHc0bk5iWWE3?=
 =?utf-8?B?b1hydk1qQ1FhSE9ZL1d3UTVoeTdkajA1VWQ0cXZBc1h3Q054UVZzWTQxWVFW?=
 =?utf-8?B?R2NOdGtPd3F5SW5yMWp6R05vMEcyUHM5UjBMdEV4USttcUg4UkVhWXhLVlov?=
 =?utf-8?B?ZXgyZ3k5ZGl1dDRPY1I3OFl1THRYdTFZT00xRW5ZZ1k1b01UcGI5S3RKRnZS?=
 =?utf-8?B?b3I4T3p3ZFlRQmJKdVp3clVrN1lGNEpzOGRZYVI2Ti90WkYrQTNpRmVlYjNq?=
 =?utf-8?B?NU8rUmFqWG9GYUY4M3pzTWJuMXA4VFo0VzR1WkVzRkE0bXNxRCsyeTB2SFZB?=
 =?utf-8?B?cCs5cUwvaHZoVFR3UUt2T0xNNElvb1JTYndDV1lKOXlwcXZCYkpoMHppNjlY?=
 =?utf-8?B?a0pWbU9OWm0zNmJVa0EwS3UyUmZqalR5ZHN2cUFyWHFJYXRJM29EaHZzandS?=
 =?utf-8?B?eHZQSXZqZVozbkNZSXloUVlsZm1XU1VnNmwvTEJhMXo4N1hWVmdpVjhpdW9Y?=
 =?utf-8?B?L0JLK2xHZ0ZXZVNjRHlUdmgzTCtJYTBsY28wZmNKVEZqSEN5Y1BMbXVLUVMx?=
 =?utf-8?B?WUZwTm1qQjlFanJLT3R6b0gvTHc3ZkJvR2NLeS9yUmF4a04wL1VJQS9SRXBl?=
 =?utf-8?B?elkrSmd6WSs2Ry9wd0ZJekcxWVhNQ01LTW9hK0lWME1UcWNxbFpGUnBLMlRx?=
 =?utf-8?B?UEpaUndMaHpsNkQzL1JwQ3FBRkhjTENoMmlxN09abVJ0WU9sSEZ4YkF3WkJw?=
 =?utf-8?B?NDVBUzVrT0tuQVNrc1dvRkdNaU1QUnlrY0lmcG5FMmRBNk4rNWE3M0F2S2ph?=
 =?utf-8?B?Nnp0bjdKRjdtOTdscVFaSU5zQmF2SXJoVUNZbWphUTBIdndoOTFYb0V3eVdr?=
 =?utf-8?B?VjBaamRBRnlVd2JPakNaLzJKRU8xaXlGOU5NSy80UWlMTDE1U2xlNGNGaktC?=
 =?utf-8?B?TUpKY0F5a2IvOGNjdjNtSkVRSFl5TnFyaTJOWGsvZE54Q2JRb2xpUS9tQk9H?=
 =?utf-8?B?ZlgrV2J1cU5HdzBpQnFiaVBZZHk0VEJJbXpKZU9EVmhleXZ5a3lTUnhBNWxk?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <724FE58DEA4FF346A079ECBD33A8F2BE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868762fe-ca9f-4b55-94d2-08de00bc7b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 07:31:05.6207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gF8rwSd1EXnhYcjhGkYiWt/gVsfhyKsH+5GnK+/iB1qniIgYumbXeySPOXcDqusybdueSBi9COrIya+1pFvizA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7631

DQpEZWFyIFBhdWwsDQoNClRoYW5rcyBmb3IgeW91ciByZXBseSwgSSdsbCB1cGRhdGUgdjIgd2l0
aCB0aGUgc3VnZ2VzdGVkIG1lc3NhZ2UNCmNoYW5nZXMuDQoNCkNocmlzIEx1DQoNCk9uIFdlZCwg
MjAyNS0xMC0wMSBhdCAwODoxNyArMDIwMCwgUGF1bCBNZW56ZWwgd3JvdGU6DQo+IA0KPiBFeHRl
cm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0K
PiANCj4gDQo+IERlYXIgQ2hyaXMsDQo+IA0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNo
LiBJbiB0aGUgc3VtbWFyeSAqbmV3KiBjb3VsZCBiZSBsZWZ0IG91dCBpbg0KPiB0aGUNCj4gZnV0
dXJlLiBNYXliZSBhbHNvIHB1dCBNVDc5MjAgaW4gdGhlIGZyb250Og0KPiANCj4gQmx1ZXRvb3Ro
OiBidHVzYjogTVQ3OTIwOiBBZGQgVklEOlBJRCAwNDg5OmUxMzUNCj4gDQo+IA0KPiBBbSAwMS4x
MC4yNSB1bSAwODowNCBzY2hyaWViIENocmlzIEx1Og0KPiA+IEFkZCBWSUQgMDQ4OSAmIFBJRCBl
MTM1IGZvciBNZWRpYVRlayBNVDc5MjAgVVNCIEJsdWV0b290aCBjaGlwLg0KPiA+IA0KPiA+IFRo
ZSBpbmZvcm1hdGlvbiBpbiAvc3lzL2tlcm5lbC9kZWJ1Zy91c2IvZGV2aWNlcyBhYm91dCB0aGUN
Cj4gPiBCbHVldG9vdGgNCj4gPiBkZXZpY2UgaXMgbGlzdGVkIGFzIHRoZSBiZWxvdy4NCj4gPiAN
Cj4gPiBUOsKgIEJ1cz0wNiBMZXY9MDEgUHJudD0wMSBQb3J0PTAwIENudD0wMSBEZXYjPcKgIDIg
U3BkPTQ4MMKgIE14Q2g9IDANCj4gPiBEOsKgIFZlcj0gMi4xMCBDbHM9ZWYobWlzYyApIFN1Yj0w
MiBQcm90PTAxIE14UFM9NjQgI0NmZ3M9wqAgMQ0KPiA+IFA6wqAgVmVuZG9yPTA0ODkgUHJvZElE
PWUxMzUgUmV2PSAxLjAwDQo+ID4gUzrCoCBNYW51ZmFjdHVyZXI9TWVkaWFUZWsgSW5jLg0KPiA+
IFM6wqAgUHJvZHVjdD1XaXJlbGVzc19EZXZpY2UNCj4gPiBTOsKgIFNlcmlhbE51bWJlcj0wMDAw
MDAwMDANCj4gPiBDOiogI0lmcz0gMyBDZmcjPSAxIEF0cj1lMCBNeFB3cj0xMDBtQQ0KPiA+IEE6
wqAgRmlyc3RJZiM9IDAgSWZDb3VudD0gMyBDbHM9ZTAod2xjb24pIFN1Yj0wMSBQcm90PTAxDQo+
ID4gSToqIElmIz0gMCBBbHQ9IDAgI0VQcz0gMyBDbHM9ZTAod2xjb24pIFN1Yj0wMSBQcm90PTAx
IERyaXZlcj1idHVzYg0KPiA+IEU6wqAgQWQ9ODEoSSkgQXRyPTAzKEludC4pIE14UFM9wqAgMTYg
SXZsPTEyNXVzDQo+ID4gRTrCoCBBZD04MihJKSBBdHI9MDIoQnVsaykgTXhQUz0gNTEyIEl2bD0w
bXMNCj4gPiBFOsKgIEFkPTAyKE8pIEF0cj0wMihCdWxrKSBNeFBTPSA1MTIgSXZsPTBtcw0KPiA+
IEk6KiBJZiM9IDEgQWx0PSAwICNFUHM9IDIgQ2xzPWUwKHdsY29uKSBTdWI9MDEgUHJvdD0wMSBE
cml2ZXI9YnR1c2INCj4gPiBFOsKgIEFkPTgzKEkpIEF0cj0wMShJc29jKSBNeFBTPcKgwqAgMCBJ
dmw9MW1zDQo+ID4gRTrCoCBBZD0wMyhPKSBBdHI9MDEoSXNvYykgTXhQUz3CoMKgIDAgSXZsPTFt
cw0KPiA+IEk6wqAgSWYjPSAxIEFsdD0gMSAjRVBzPSAyIENscz1lMCh3bGNvbikgU3ViPTAxIFBy
b3Q9MDEgRHJpdmVyPWJ0dXNiDQo+ID4gRTrCoCBBZD04MyhJKSBBdHI9MDEoSXNvYykgTXhQUz3C
oMKgIDkgSXZsPTFtcw0KPiA+IEU6wqAgQWQ9MDMoTykgQXRyPTAxKElzb2MpIE14UFM9wqDCoCA5
IEl2bD0xbXMNCj4gPiBJOsKgIElmIz0gMSBBbHQ9IDIgI0VQcz0gMiBDbHM9ZTAod2xjb24pIFN1
Yj0wMSBQcm90PTAxIERyaXZlcj1idHVzYg0KPiA+IEU6wqAgQWQ9ODMoSSkgQXRyPTAxKElzb2Mp
IE14UFM9wqAgMTcgSXZsPTFtcw0KPiA+IEU6wqAgQWQ9MDMoTykgQXRyPTAxKElzb2MpIE14UFM9
wqAgMTcgSXZsPTFtcw0KPiA+IEk6wqAgSWYjPSAxIEFsdD0gMyAjRVBzPSAyIENscz1lMCh3bGNv
bikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQo+ID4gRTrCoCBBZD04MyhJKSBBdHI9MDEo
SXNvYykgTXhQUz3CoCAyNSBJdmw9MW1zDQo+ID4gRTrCoCBBZD0wMyhPKSBBdHI9MDEoSXNvYykg
TXhQUz3CoCAyNSBJdmw9MW1zDQo+ID4gSTrCoCBJZiM9IDEgQWx0PSA0ICNFUHM9IDIgQ2xzPWUw
KHdsY29uKSBTdWI9MDEgUHJvdD0wMSBEcml2ZXI9YnR1c2INCj4gPiBFOsKgIEFkPTgzKEkpIEF0
cj0wMShJc29jKSBNeFBTPcKgIDMzIEl2bD0xbXMNCj4gPiBFOsKgIEFkPTAzKE8pIEF0cj0wMShJ
c29jKSBNeFBTPcKgIDMzIEl2bD0xbXMNCj4gPiBJOsKgIElmIz0gMSBBbHQ9IDUgI0VQcz0gMiBD
bHM9ZTAod2xjb24pIFN1Yj0wMSBQcm90PTAxIERyaXZlcj1idHVzYg0KPiA+IEU6wqAgQWQ9ODMo
SSkgQXRyPTAxKElzb2MpIE14UFM9wqAgNDkgSXZsPTFtcw0KPiA+IEU6wqAgQWQ9MDMoTykgQXRy
PTAxKElzb2MpIE14UFM9wqAgNDkgSXZsPTFtcw0KPiA+IEk6wqAgSWYjPSAxIEFsdD0gNiAjRVBz
PSAyIENscz1lMCh3bGNvbikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQo+ID4gRTrCoCBB
ZD04MyhJKSBBdHI9MDEoSXNvYykgTXhQUz3CoCA2MyBJdmw9MW1zDQo+ID4gRTrCoCBBZD0wMyhP
KSBBdHI9MDEoSXNvYykgTXhQUz3CoCA2MyBJdmw9MW1zDQo+ID4gSToqIElmIz0gMiBBbHQ9IDAg
I0VQcz0gMiBDbHM9ZTAod2xjb24pIFN1Yj0wMSBQcm90PTAxDQo+ID4gRHJpdmVyPShub25lKQ0K
PiA+IEU6wqAgQWQ9OGEoSSkgQXRyPTAzKEludC4pIE14UFM9wqAgNjQgSXZsPTEyNXVzDQo+ID4g
RTrCoCBBZD0wYShPKSBBdHI9MDMoSW50LikgTXhQUz3CoCA2NCBJdmw9MTI1dXMNCj4gPiBJOsKg
IElmIz0gMiBBbHQ9IDEgI0VQcz0gMiBDbHM9ZTAod2xjb24pIFN1Yj0wMSBQcm90PTAxDQo+ID4g
RHJpdmVyPShub25lKQ0KPiA+IEU6wqAgQWQ9OGEoSSkgQXRyPTAzKEludC4pIE14UFM9wqAgNjQg
SXZsPTEyNXVzDQo+ID4gRTrCoCBBZD0wYShPKSBBdHI9MDMoSW50LikgTXhQUz3CoCA2NCBJdmw9
MTI1dXMNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBMdSA8Y2hyaXMubHVAbWVkaWF0
ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IMKgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMgfCAyICsr
DQo+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnR1
c2IuYw0KPiA+IGluZGV4IDRiZTM0YzU1NmRiOC4uYTJjZGUyMjg0MTYzIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMNCj4gPiArKysgYi9kcml2ZXJzL2JsdWV0b290
aC9idHVzYi5jDQo+ID4gQEAgLTYyMSw2ICs2MjEsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHVz
Yl9kZXZpY2VfaWQNCj4gPiBxdWlya3NfdGFibGVbXSA9IHsNCj4gPiDCoMKgwqDCoMKgIC8qIEFk
ZGl0aW9uYWwgTWVkaWFUZWsgTVQ3OTIwIEJsdWV0b290aCBkZXZpY2VzICovDQo+ID4gwqDCoMKg
wqDCoCB7IFVTQl9ERVZJQ0UoMHgwNDg5LCAweGUxMzQpLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9N
RURJQVRFSyB8DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oA0KPiA+IEJUVVNCX1dJREVCQU5EX1NQRUVDSCB9LA0KPiA+ICvCoMKgwqDCoCB7IFVTQl9ERVZJ
Q0UoMHgwNDg5LCAweGUxMzUpLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9NRURJQVRFSyB8DQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+ID4gQlRVU0JfV0lE
RUJBTkRfU1BFRUNIIH0sDQo+ID4gwqDCoMKgwqDCoCB7IFVTQl9ERVZJQ0UoMHgxM2QzLCAweDM2
MjApLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9NRURJQVRFSyB8DQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0KPiA+IEJUVVNCX1dJREVCQU5EX1NQRUVDSCB9
LA0KPiA+IMKgwqDCoMKgwqAgeyBVU0JfREVWSUNFKDB4MTNkMywgMHgzNjIxKSwgLmRyaXZlcl9p
bmZvID0gQlRVU0JfTUVESUFURUsgfA0KPiANCj4gUmV2aWV3ZWQtYnk6IFBhdWwgTWVuemVsIDxw
bWVuemVsQG1vbGdlbi5tcGcuZGU+DQo+IA0KPiANCj4gS2luZCByZWdhcmRzLA0KPiANCj4gUGF1
bA0K
