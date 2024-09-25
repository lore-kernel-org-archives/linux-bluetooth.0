Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972591F943
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271816; cv=fail; b=sx3W68fECeP+WhGjKlIr4MBsMsR8NymyVCGiCHEuKzlKq+YtFIDNR9JZ+YM36qWPoD5k9HvJwtSw2jPkZsoXsTDheMHIJesAtfvic6pd7NvVZiV5VOQx5lBUJ36tbZaW0SrCmsm3LbbyKse3awI9RurlQoZKLZLO34ynbS3spYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271816; c=relaxed/simple;
	bh=0O8RQbMqRKVYUTf/EymwNAkwkO6PEd+TPLC/Zdlhu5c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UVOR2ImJ/1rOClHXrxxPcoswDVOyy3mmHIitMswsFTcHiI1iNQ1USfXGJ9Lj5t1GlN+4RmsD9QWJkbir+tkTbQfcP+VyQ9xdsrk4LU+O+iJqL0GuMSYqdFXFLE+tZQf3T6A9rEwJTj9idBJmjmpSe8skeaP1/9NyQmtI2mzb/8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SicZP72n; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=hEVthJB4; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SicZP72n";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hEVthJB4"
X-UUID: 2610c4a47b4411ef8b96093e013ec31c-20240925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=0O8RQbMqRKVYUTf/EymwNAkwkO6PEd+TPLC/Zdlhu5c=;
	b=SicZP72nUBknF63AVnk1TWCrN1pfr7WC35zfVUDEB1VUC0X3R4qGPXvzhk8C3R/XlIk/iOlbjzkaRcFSnKyISHXAq6uWFndCvoJ4U0CaZFauz0/x8cAWc3dWqxnnIqNQhcwydMuC7QzZmXNRa6KXa4OXhN7HN6kbFz2O8KSlFog=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:afa80c0e-a8c1-4bd5-9bb7-3c5d214d3264,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:4f803d18-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 2610c4a47b4411ef8b96093e013ec31c-20240925
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <jiande.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 846339144; Wed, 25 Sep 2024 21:43:29 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Sep 2024 21:43:28 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Sep 2024 21:43:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjVq+sSR6TfQoQbK5W+daOVkXh6IScTaHu6ypKelJP5dXq8DENWy5Xv8az64dqZA6Yz2ZWO1aIDdSVccAHOhDtu2LZ954JEIpqIwFlAMUyv8nWVWzsMaGujhJOEZAY2+nyKktUdmxJwxs2OcNDBybPWK8iJKMjXv8+E0cfU86Rlzy+LShX3UseJAj9V20ijEKdI89XFldSFENafKn+kWn3T+1TMPCmftnNl2Zw9M3Q08o4DvC+Dqt+0n5WXuOIc0Gz1gaT95Y92Ffi4HegVK8vq0XIzlAOVVjtAtZKCNGfT6/Uh2Kh+9iTrihK1nP0dsDfS4T0rqndAUAX+0Tottkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0O8RQbMqRKVYUTf/EymwNAkwkO6PEd+TPLC/Zdlhu5c=;
 b=F+e0Immh+94CfP0xmv2lBk9i3vqwiUkj3YOtLU7sct/6YT53l9RCYFphjBYm4VC7RV2CCg6quSsQ7+GX4OhXGfLTbE4Ln/56gTzUQlQto23/OaO6jL0hsUOD2g/jvJEMpPxDts4kHlc+sv3FW3nH93mMBb3A5kPzwjEU5tpZZeRcqsL9kozaBCeHulo4C4Aa3x3tLfZ9nuUCHlkdQQju+rL8khTGQ1DONi15tVR/jIxAbvtvXTu0kF3+nhg+fVwP1HxqI+9CvZPFSr9fn9V58DAqm7KxyiRqHCHf5nqt8FQOVwShZff5k0rh7ZT/UjnDasTdzh2L734he1TXrC19TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0O8RQbMqRKVYUTf/EymwNAkwkO6PEd+TPLC/Zdlhu5c=;
 b=hEVthJB4NHA5/Zg4h18D8fTjw91EgsarhlkNnmTUruj1ZW6AV5wdAcxk5xUlCYCN+ya/7InoHAPu+WkklY0Zghbv+fv36OJPJsn0rCtUpwYQVvbXvJ6LkHRtZ/BFLbdBjrYPMA7E+5yISXBsWbty4/ZiDlLLKwz2Xa0zx7V8d54=
Received: from KL1PR0302MB5410.apcprd03.prod.outlook.com
 (2603:1096:820:33::14) by SG2PR03MB6540.apcprd03.prod.outlook.com
 (2603:1096:4:1d4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 13:43:27 +0000
Received: from KL1PR0302MB5410.apcprd03.prod.outlook.com
 ([fe80::c129:d5a8:beac:1bae]) by KL1PR0302MB5410.apcprd03.prod.outlook.com
 ([fe80::c129:d5a8:beac:1bae%5]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 13:43:26 +0000
From: =?utf-8?B?SmlhbmRlIEx1ICjlkYLlu7rlvrcp?= <Jiande.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Add new USB HW IDs for MT7920/MT7925
Thread-Topic: Add new USB HW IDs for MT7920/MT7925
Thread-Index: AQHbD1DlDQfdFfAzuESZGf6Ovr2iew==
Date: Wed, 25 Sep 2024 13:43:26 +0000
Message-ID: <c67f550bf294bf3c103da2806ca862bab96d0153.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0302MB5410:EE_|SG2PR03MB6540:EE_
x-ms-office365-filtering-correlation-id: 9a4e5d76-afb5-4af9-c3a1-08dcdd68086c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RjFRSjRBY3BKaVNweWEvQWNkZ1FKeXYrVXloblU2MjV1WmpzYktMZFY3OEhX?=
 =?utf-8?B?NmZTQ2kxM0F0ZWFQbzMzdTdQQXlXYjdjbzNXcDhjM0xKUVk3SG1kWnBTdmdj?=
 =?utf-8?B?dXlzb1hmM0JHbEpGUG4rTFRHaXIwRDZHZmpEdERESk1XLzJGWnBLeERPcWNG?=
 =?utf-8?B?QTM3Q3VidHlOcXVad1R3TXdLaTZQMWpENjhFMC8rTzM2eXFSL28wY091ZTRH?=
 =?utf-8?B?aXpYZEp1Wi9sRkNSVFI5Q2pUT3NRaDRBVGFOd2tGUmQyMWFEbnFJU2JMcnpR?=
 =?utf-8?B?T3orTkpBT3dsYWQ1cVg1dHBTWDFaVDYzM0FmNnBjM2s0U0NMNlhTZm9vcG9Z?=
 =?utf-8?B?ODNFdXB4VHJaTWlORUw2YmJhNUx6KzVlOHQrR002c1E0UzFFTlJteVh5dU4w?=
 =?utf-8?B?TEpLOHBDRE4wb2NvK0gwNTBJd3ZKNW52OTFuWGx5QzFpQnJtMlpGSmxQMmJ5?=
 =?utf-8?B?aWtYWE1BN1d5cXFucmV2NTZncGZFM01zOHRuTm5hdXF4MGwxR0lyQXZ5dkZR?=
 =?utf-8?B?NFdWSWZCRFo5a0lLR09SL0VpTnI1QmIwelovOHNnMlNyZ2FDdmhrTXdBN2dS?=
 =?utf-8?B?bjdGMjZNZDB4L3l6emYyL2hwbCtzUFhmN1RZVmc2RGNTMWc4dzdXSFJaemZU?=
 =?utf-8?B?VDU1TUk0LzgrVjVBZ3p2ZWxxSUlqSUF5dFYxTkFUNUlvdXd2VkpzRnJ4U3Jp?=
 =?utf-8?B?bjZsMXBKelpDTzlWcU9nRkl3aVNLSnFpVWtNUitjdUxCaXVYZEYwcVdXbmhm?=
 =?utf-8?B?UWlCR0JySVgvNmVYdGw0N0RJdWdkNC9NcFdYOVZrSWc2L1ViMnpGcnQvdlVk?=
 =?utf-8?B?b21EeE42NHJTMENjbmJrL3Y2SkhJeHk2RHE4cWgzZE9ncjE0N1pLcUU1OUNO?=
 =?utf-8?B?bHhnK1RjOEJ0amh3ei9ERm84ek1zcklDNVlYdFFvNC9QbC9sWlVLNmNrRGYx?=
 =?utf-8?B?bnI0RFVYWlVYelpzMEtZTWsrajRLRzdteWo1TVpmMkxoWTB5cDhPdFNpSFd1?=
 =?utf-8?B?bEUzUTBHN1MxS1FtdTFHOWNrUTR3Ly9uRDIyRllGenlyendXRXdudWJMVk9q?=
 =?utf-8?B?TWVjeUo4MlIzaW1sWW1sRG8vMXN4RXBSMld6emU4NEtybkx3QkJDbkVoeXNn?=
 =?utf-8?B?Wm04RHIzb0tvTnU5RnBlckVNQ01FcERhanBZYmJHTFZsRnZxMTZkTmVxZ2du?=
 =?utf-8?B?SUJqdG1ON2hDZk1xWCtLOE9mNEU3Z2tkMU5lVUhmeGF3MGdhR0RyaUdvSlZ6?=
 =?utf-8?B?YmhnT1BiWUxpaVc2bUxRYkEvRDk0K2M0V3VqQ2N0S3ZjeWZad045anNLVldw?=
 =?utf-8?B?Vk5LaktYUlVneExyZFlzTmVWVk5pMGE3UGhINThYSndkeGZvUm9kSjhiRXE3?=
 =?utf-8?B?ckFGWWl1UHJOTTlPbFcwQ3RLbGhKblBpQmozQ1ZsakwzQnFOR0NZdjN1cGVI?=
 =?utf-8?B?T2FpZGQ0MStPRUQyVzNqVmhuZlBwa3pSZlhSYnBQclM1cU5CR2x0cWk1OW1u?=
 =?utf-8?B?L1R2L2R5eVlKK0JRaDVIblBNbGhIeHBhSHpUeVQ5ck9sVnRWRFpwRS9iS0NO?=
 =?utf-8?B?cGhhUE51c3BBN0xSWEhJYU40UHlkZnVKN1ZqdmJlemgvcmFuREIybWhINVY1?=
 =?utf-8?B?aXBpOXIycHpmcXlBYXhJSGo4d2F4ODhIK2N0bFkyUW5MelRwOHplWGplbk12?=
 =?utf-8?B?cGxVTXY0dTJ6NmNYRmZ4R1VQdlhJZ054REFpSUNyRUVFajN0RDMxTkEyTkJi?=
 =?utf-8?B?allyQjlUZG5jNWVGdXlkQ0lDYmpvNmxPWEdTcVZCZnMrN2F1TUlkeEovZ3kz?=
 =?utf-8?B?cTdESWo2U25peDRvdTVGdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0302MB5410.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aldYbHJpZjhtcXRpOTVUK2o3LzcvdndOWXZ1d2lJVm9kbUVSY2J5ZU9NMUh3?=
 =?utf-8?B?SG96alpyazZhSldTSk13NXp3MTlJekJaYzdKYitpTWxtc3ErT2pqaW5La3Uz?=
 =?utf-8?B?ejhDS3dKMWt5NXgvKzJYUFlQcWhJck1VcWUrb0FIUjVLcFVUNmw5blVTZkFs?=
 =?utf-8?B?bGhPZCtnOCtzUVo4NGZVbWlvZndrQkIwOFVocTRJWURRNW1mNnB3RmQrV3lo?=
 =?utf-8?B?U0duNmR5VmZFUXdtMzcwOFQ0NTFpa3U0cGIwdVBrcnVxRTBQUlhsWjFIUXM1?=
 =?utf-8?B?RkVoT0VjeWRWUnBSeFNWUnVYcVRlZDBHT2Y0ZEt0THhTdGZWZStnclQyeVNz?=
 =?utf-8?B?UjVTRGYxQ3lyZnJOY2s1eWhDbEdVVUtTckVIcU4yQ3VBendsaGQwTk1Vbk5H?=
 =?utf-8?B?WWdldGM1cWFHNXdvK2dySVdzZTZLcGsvbG9WODBreGc0TUlDV1c1Q0Y5SCtl?=
 =?utf-8?B?NjgzZCtRcXNaUjBVR0VtS0hvTGlSazJwWncrM2MybXBmZFkvSFRKMzZKKzdR?=
 =?utf-8?B?VkZqYzYrcHhkRUM4RFpBdTlybWI3SXBkTlhMNEFnUENTU0FJVGF6bUFtRkQz?=
 =?utf-8?B?TU9kWHZyNXZQbFdGQVF1RGo0RVlaZUFiRG5BRUgvdDZSYWFRY29XQmtTSDlQ?=
 =?utf-8?B?VjNQM1Q5cG8zZGRING5UTHZFaVVUU2FsRjJ5d0E3RDN2bGUveElIeXkzWThi?=
 =?utf-8?B?N0hIbjVaYk9yMVZUVW41dzJueERCc3E2dGl6MXdEVStTTHhIMHZvckd4RUxM?=
 =?utf-8?B?aVpMMWsrSUxrOEZYNE1RMGZxam9HNEtFUXhNdzBPN0pBc1RoUkh1UWtIYUk2?=
 =?utf-8?B?S05lYkVQMVRJSDB2VFMzaXdvQW5xRFNxWi9FUFU1TFJnLzJQeVJTKzRXeXZV?=
 =?utf-8?B?cFFSdlNQUlVHenMrR1F3NlVXNktQc3FheWlYN01iMExiSDcxdTVUVnZIQmJI?=
 =?utf-8?B?YmhzaU1BODZ3N0dxTDcyTVlQUVFsUlN3bllnSDlnUVRhU3lkem4xWkRDa0lp?=
 =?utf-8?B?dWU3dzQveS93VDNHbVppRFVDOUNrYjlmam85WENnNzZBaHdHQ3VLNmdCaU1x?=
 =?utf-8?B?cDI2TUF0WWFYS3hTMjljRVFnZGFaSGNTTVFlZ3ZHdjdMUTd4T21VQ2tocTZG?=
 =?utf-8?B?TWprZk5WQXFSSTV3Wk9JeW5PcjN0WTNJNFhzNGM1K0tFYnBDN04xZDZlU0VD?=
 =?utf-8?B?aDNFWXRyQ0RJQ2tpMm1wc212VVFwbkpGSUVWVnhPUk80S040OWIzTjFqaGZp?=
 =?utf-8?B?YjZ2Vk9ScVhRMzNXRHdTWjE2QjE5c0NCU3FIcVhFVm9SMHljOUt4M1pmV3dC?=
 =?utf-8?B?eWFJV0poRHFtZlhsc2cwandmK0dEaWxOVlIra0MxMEowbEs4MExCbVhBVzdj?=
 =?utf-8?B?bnhlMWtobEFrZzVqTWk0R1YxYjRLanp2QzNORlR2cXV2dEFZb1I4U3FIMFU4?=
 =?utf-8?B?ODNNL25kZlAxTGwrZm5MNXhVZUZoNWJVcm1IV1dYNE8rYnJibnlOT0p5M2NQ?=
 =?utf-8?B?TFk5dFYyUThJSitRaS9xeHQyRW40ZHUrWkxaZUtMV0I0dWNaay9yN1loUkxZ?=
 =?utf-8?B?SXVvdnhiRGhSWTE4VndiY05JYXhFQ2xkdENwbG1FbW5GbG16L1dkWWNrS0J1?=
 =?utf-8?B?YWgzUmp0aTR4bGpqbVNIcnJpWkdOd0hwVmF3OGxHY0FuZk1hbVBNSHpzSFA4?=
 =?utf-8?B?b1h6azFsT1VnYzh0MEtaZld3Y0xSWGRCTldtODNLWmhTYmJCRHBnV3lqVExO?=
 =?utf-8?B?VGxSUG1tWVpick1oYVl2VVRTNGZRMWVoQ0pxWVVDb3R1MTlheFBDMEtLWWty?=
 =?utf-8?B?WDBuamdZS1hDcW9qQXAralkyb25SdnNXNGJ0U0x1K1NyeDd3Q1hHSGxqdHov?=
 =?utf-8?B?THhJcDN1ZEVUWDZ4Ym1XYlFjbm82Z0t6eStJTmlzb0JvcThsSTRveSs4anh2?=
 =?utf-8?B?TS9hUXZUdnVGUmFnTmk3VUVxdUllbnlCOUtMRkRMS1RhdDRlcUxPNS9FM2xY?=
 =?utf-8?B?NkhEM0tqNlVDQkhhZ2o5STdlZTNCQXpNR2JBRURDSEVBMHZTRHpwZFpHZE1y?=
 =?utf-8?B?b3Q2eGYrblRHWXhmMks0OTBkVXFGWVVLSmY2VTR0bVlNOFRicVZLRnU5c21K?=
 =?utf-8?B?bk52SDN5SVU5c243UkJ0MHBmeCtVUm92ZTJseW4zY2FCSmZoTXVYM3RnMlND?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B71917F94D0624A9D2EA14B9D4F95A7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0302MB5410.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4e5d76-afb5-4af9-c3a1-08dcdd68086c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 13:43:26.7205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DnonAX3pvNAfAHvF5QUEfqhrDHBEtRTI6s11KjQrhXtWTjTfyw0drU1Zey8cdcrtJYGFeI+7nE48f7/VMVMltw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6540

RGVhciByZXZpZXdlcnMsDQoNCkNvdWxkIHlvdSBoZWxwIHJldmlldyBiZWxvdyBwYXRjaD8gVGhh
bmsgeW91IQ0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvYmx1ZXRvb3Ro
L3BhdGNoLzIwMjQwOTE2MDMyMjI4LjY2MDEtMS1qaWFuZGUubHVAbWVkaWF0ZWsuY29tLw0KDQpU
aGFua3MhDQpKaWFuZGUNCg==
