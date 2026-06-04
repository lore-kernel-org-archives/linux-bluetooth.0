Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7363A6B68;
	Thu,  4 Jun 2026 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591212; cv=fail; b=Lqc12iiPgo96gIkiw96PFHhMh5icSR42SDv3tZZXanoZkve7HPvoxmdPypF3KgY0CyBfUQi/PrqlOujL7AzknhUE8Wt6rHruiT1sYCxdLfcz/4EN5ipk3ZsmILGDAdvc8hfexPNrPfPpIBomo8IhJK73gOoBMQtG0NL4/FBQUQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591212; c=relaxed/simple;
	bh=99xJ2KO40U7rfdXCyo1FQv7gCS0FuOXv6N846wdTDIo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SsHPrMyaAK2+5Na8sHizjUCZSHWX/TCoq5PEdi40/XDcrORxfW0M5sgfdQ/rg2JqruLPJpY8WSPM6jjyP08bUogev3xJzcPhTedWv3+42/3aactKY5LCjMjhhajhLUzj+l9uzkUCK593cYN9AzbkopCZcEY/zyTkeIp3DiUL9iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=okAzoY1+; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="okAzoY1+"
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654Erv4r1010319;
	Thu, 4 Jun 2026 16:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=99xJ2KO
	40U7rfdXCyo1FQv7gCS0FuOXv6N846wdTDIo=; b=okAzoY1+tBPac6olJTzZrHD
	Pg2RqsniWZ7HBo7q//yv49an3/3t4rYiB7j6BTrayzlWMTTPpUhtzVe06JA6ixRv
	ZxMVkqTShOoDqRA17wiAC6JlDYPF8fJUrzxP3Faugvulgg296vfuBy2E1L8jZNIF
	fHK4JA0TDYXsFF6zdIChlI3L0n0qgB6YyVWRd9CqyjKUsRdQYFa8nbN5YdP1HuAu
	q9xZUlx9MtapcS3ncBZsEu2SJZV5/rM/iKBIZqxV9uPrytXPPk2DOXXsrlm2qDUE
	M1NfFt5kVB6AiySiqBXC2UCmQigaSYAXOwxkSsGsCfP8kFiN4m+wf7Ko1WHP+8w=
	=
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4efphw6k3f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 04 Jun 2026 16:38:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMU2tVKV4/Y172SRjVydHB+zvMCsPBzgAXODQsX1n0GV/nZfNaVg0etsLc8gxsBufYeVD4D6pl45GSkNEmBbw4PgGFTd4l2YEJgQk2ogDJc/SL/x8oypMNprHvaERU/QWc6llphlAmXQzyArCX9cd4Oa2ixA13vJZcvZuVvA4ADyRyynxuZUvpNpRJSOgkVPphK4RyfYJIdzzPUHx1CfFTXCE/sSsW1yNkbI6oQkcNY1hh9CxuM3yosnmQKQERrcUkSMnQcksvKE8jXztWBe7hT3eHp1/CDo4gLWDdj+hl7Kc2Qi17OPkMzOF15gfLXZrORvzGH87ErAEzQI+7NDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99xJ2KO40U7rfdXCyo1FQv7gCS0FuOXv6N846wdTDIo=;
 b=x9h3vVT1zoby2x0GOlfXVEdNdioga3b8uBQqM/7lgXe+vaD7mtvRUpYfsPyvBR3VDEfBZwI2AuK27OzbFs8XitPV9VVWyKwQNRUleSitV60S+MjQgNcfGDVcRTAB5qPrW5tVXaOCQRS0t6zlMi6uvFeUcm9tRkv3xNK2/8jGCDiLCLHU2ohe4ShLYaKkmW2/amGjT4paANKpjFlJIvu5w/RxfBfalW7AbdoHC6rZx2SmFa3bhYRvL3tq41R3t6UH/sIMRM5CMJbN2k4oox5IjNL0jlCs7v3sA0eXk1fVcovTXyhmkvsMAWF1BehBV3HVeA0tjPjWcm4gIimZYRNTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by DM8PR13MB5208.namprd13.prod.outlook.com (2603:10b6:8:6::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Thu, 4 Jun 2026 16:38:26 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::29e9:b355:cabf:66f1]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::29e9:b355:cabf:66f1%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 16:38:25 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Bastien Nocera <hadess@hadess.net>,
        "marcel@holtmann.org"
	<marcel@holtmann.org>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "kiran.k@intel.com" <kiran.k@intel.com>,
        "chharry@chromium.org"
	<chharry@chromium.org>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "prameela.j04cs@gmail.com" <prameela.j04cs@gmail.com>,
        "salvatore.benedetto@intel.com" <salvatore.benedetto@intel.com>,
        "maxk@qualcomm.com" <maxk@qualcomm.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] Bluetooth: Add SPDX id lines to some source files
Thread-Topic: [PATCH v2] Bluetooth: Add SPDX id lines to some source files
Thread-Index: AQHc87rtD8cMQsYTXkuJqTxLtVmCnbYuREGAgABQdGA=
Date: Thu, 4 Jun 2026 16:38:25 +0000
Message-ID:
 <MW5PR13MB5632FBFA947B82F49EBC6926FD102@MW5PR13MB5632.namprd13.prod.outlook.com>
References: <20260604004125.715884-1-tim.bird@sony.com>
 <1b4540a3814b2e6106f48435df8692beaf177f8a.camel@hadess.net>
In-Reply-To: <1b4540a3814b2e6106f48435df8692beaf177f8a.camel@hadess.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|DM8PR13MB5208:EE_
x-ms-office365-filtering-correlation-id: 6bc39e3e-c8e7-46b5-25c7-08dec257b335
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|38070700021|921020|4143699003|18002099003|22082099003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info:
 r6P8uPdzGvrPWquxqc7bJov7qLlvYXvdkGgeEyfqz2Q98al7Lehj/CRdd624bOFvhcTCFDYTsRUaG0Ft+p473vhmxJjI20D6mSFAAVuxAHG6gRMC3dDo0UurrP0M5dW54e7VVGTlNDodr8/HhmDkvbu1jwiY3SdZkQTX9KCVBHcEbgvV5Mt9bMja/MWuC2Uk2Oy00sL8kjmKbTOP3XbGYhOqmYpiy1RZ4C8iqoajB+eRwSHnvCxdc+30rPiueXDvgstd9GXaxOa9hxib3r4qi8GAYO8IhpzC+gSK7a+Van1FUBnqZc/qpowf0nvXI1g+wfogYWEFPvoUlqeaIyHvly3e04vytfaLn0WSt6vQGfyqkyjxKkG0DmB8FirwQ4UbrINpwZF+O65JYiWHiYYnkHZGq4HLhnVYiUM8iQ2ADowThN1VOm/SdFd/vnbdRmvJC0I63ZZMMsMNSVFL5+LqxpNW4Fi4rAGFIivzOF70X4RC3L5S5FOUMAJA9fIbs9MjyxiIJAamvQwx23EaWexmBq6lJ92XhYxGbU60e60BPjk78Vl1VXLGv+FOV7ZRBzFO4IfYGdesWRSaUnS1IiIgp24vUhD4yi/7DeuKuMoZU4gXdXZtf1MXkA1T69tDxIII2Dozbqp/UVZespBZ1pkUDaisOiULX55Ytx67WB1DsdUGxtqyYbU71R7oMZ/SsNswBUhmRiw6JjnCAbSlXda3Lg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(38070700021)(921020)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFovampDVnI0cTBJLzZJeW01QkY4YUViamJ6S1lWc0VYcVhyZWo2Q2dqc3hy?=
 =?utf-8?B?YlJOa3c3b1ZZKzRFcC9GUno2Um1pMkZWa1JRdDhKSm56ZEtRMGNzREE2Ylcv?=
 =?utf-8?B?VkRWMWZNOStuWXorYlkrMnBWb3lIVUpHeHMvd1NUcFdkRzlpTFNpa3p5aDlP?=
 =?utf-8?B?SWtwU0x4L3JFU2NoeEdjQTYyME1sbHc5YXFtZkNwNFhIcENzZ1dNWEFPdHli?=
 =?utf-8?B?bG9TV0hESjIvU3hTQS9KZ1Y2UUNmOHFHbmFBLy95LzhrQy9Pc2FzeXUzOGpn?=
 =?utf-8?B?b1lyTm9UZUpLekhobXd1Tm16QzhtMEQ0b0t5cXdlTUhJa0tuMzR0dDhMcW5Y?=
 =?utf-8?B?d0JWUzNmQXQvZ244KzRNeWRya3d4b051TmJKbnp4YWNvK2ZUTlE1c3BlSXhk?=
 =?utf-8?B?WHYyR0dxTHlWRGUxSUVYZSswK2gvOFFES013NmlSVldia3JKZTZPVGJmN216?=
 =?utf-8?B?ODZ4cTdhclhVZUJRdEdBNEVCUDdRcVNheFJtV2NpN1BkYUhSN0xYNHN6eXUw?=
 =?utf-8?B?TFFJWlk1RWxZeUJzUWZWelA3MlMvdHNWZkJubmZ4cVBpNzl6MDJYclVZaWdv?=
 =?utf-8?B?aGZoYmRVQllBMmxWWUN0cEZRRHdFem56Tm0wbmlNbFFYclIrZkNyNW5EZEtS?=
 =?utf-8?B?TzZQYnhPbFB3WXhTdnloV1R0anVzQXdhb0MyVktuRi9RYnZBdGtqRGE0QWk4?=
 =?utf-8?B?eDRXNHZ1MC93UUovMTJqbVVvRm9jOXo4NDVRL09uRFJNTFRrNWxva0pqeW9I?=
 =?utf-8?B?Uno0ZGRxMUlaNnQyQnQ2RGpXSUlKd2phYzRXbjR4eER0NlhVTHFuZklsVXIy?=
 =?utf-8?B?OS9FckpMdlQxOTRDQ3RwOUZOY2UzMThhSDVZcE4xQ2Q3eUI0SVZJY2sxNUhV?=
 =?utf-8?B?UkRLVHpVVG9LbjA4UmEzNmRDNi9RRTErV09HaDU5azJRckdDdmVscjU1ZkJ0?=
 =?utf-8?B?V2p4ZUtZOFVJUTg5bWlYZ05tamtBa3lUZ0IyeTNwbGJONG9pWTFnQktRYVRv?=
 =?utf-8?B?VlFJakVpSVQ2OWJpRkJ2aVZYRkRmV0NkMFhJSjZsZER6dnYrQ2w3eitlMWdK?=
 =?utf-8?B?dEVUSGF2SHlNQXh4Vk5BR21RZTVKWk5SRzJFOUJzWjA2WWpXSC8rNHBtWGto?=
 =?utf-8?B?OHR2S0NGN0x1NVcyRTZ1S2hIdmpFbmVoUEZIRWFySVhVUVJzSXorTnRNSExr?=
 =?utf-8?B?UlljTWlpUS9ZWkNBSCtrM2NCV0lzbk1xckphRW1YMXhGblY1RS9ucVFGai9j?=
 =?utf-8?B?cENoOUM2UkkvY3pKZE9IVWYzYmpiMDBvdEYwL3hJTHZ0UURMR3NlTEJkVFlx?=
 =?utf-8?B?K2JSbVROTmZLQS9hc0IxbGxTYngyTE9yVXRyVzJiLzlKOXRrbVkyVk5UMzJy?=
 =?utf-8?B?Zy85MkhXUlpRaW1kenZaWkZtY212aWFyMnRjUHVORm1jdE5jakhsb0gxRDRE?=
 =?utf-8?B?S0NLbVAwZVloWTBkWDBUNFZYQURibHBiSmZoNUJHRVJRMnFnTm12SjJLaEg2?=
 =?utf-8?B?QkNnSXZkaFp5UzNvVlk3WGZra1NBclYzZ2dwSUdEVEhKNFVOeUZ5ZjVGRU9I?=
 =?utf-8?B?L0VXWWl3SEpjYXhtcHdFODREamJjUHVNZHd6QjRyODhVem01aEZHVm1SK21Z?=
 =?utf-8?B?RGdPM0tySVY4dE1TUXN2R0JybEFDM25PeVFuN3lMU0ZhdUowdGxhSlZ3T1I2?=
 =?utf-8?B?djY4RDRrZHY1dlc1Qmp0c2RSeFIxY2hkeFNITjdIWUs0Umk3RS94eHNqZzVD?=
 =?utf-8?B?VU5EZVhnTWt1TE95Qm55RWFiZ0l2QTM2WFVDR3ZmTW5MWDd0eGNGWU9PWHlq?=
 =?utf-8?B?OC94cUM2Y1ErRG5tWXp5OWR3NWNYNmFXQ2JwMDRkTjZWamJ2U3RNSkEzNS9Z?=
 =?utf-8?B?c3M2bGM0UzFMNFgyVDhNVGFhanprdHdOendXbjlpZUt1ZjBHakYrY0NOTURs?=
 =?utf-8?B?UUxJdXFwb0lsRUcrTnplY1F6NGtVTE9Zai9VaDJOM2VodW9RdDliVkdXRHdz?=
 =?utf-8?B?QUpmays0KzQ5Q3RNMUhaQkpMTlNOSW0zaDN4LzRMRmVtVmZqQy9FN2RSNExY?=
 =?utf-8?B?UnZhRzNlcHduRVVXYjBvaHE4cVJqZWdJTVV6aFAxU1VBbkgyZ09mbnUyenpD?=
 =?utf-8?B?cjBDK1U2aTZnTHdqZmMyRGloRlJGUSs5TkltUEFQeGZoU2NaTTEzdzU0QXc2?=
 =?utf-8?B?Nzc5LzQveU5oOHZmZmk1T3BwL0ZwSUxuNm55U1hEMllNbTBGWVNpcHZ3c0Iv?=
 =?utf-8?B?SnU4KzF3OFN3NWNFVWdrQ1dsQmhUTFNCNFVSMFR3MERGcWp5ZEw1bWR3c0Jh?=
 =?utf-8?B?NEVHamlIQkNMMTkvb0pOSWFhU09hT3lRcUNSOHZwLy9ENm53VTJnQXB4UHAv?=
 =?utf-8?Q?+7LcWG6VhdVVBn7rNeiPiuVxh7Vz0cWOK1r81?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	g0PJ6B5kBmpw55dBln9+wJW3TVzKVi5fcpzrbwgfKguCQGRfhRURhaZYi5f8yg5NIzyD/2lpFwt2XR0bbiyowwhwtFEV4IBpI797ljkPgMIUWBEqPoDgXqql/TEJx4d+RI9Grl5iJIBne/yGBzmZ5uobYoRs4HQg8s6wfSUh/1BFkLuUqpzy/VSkq7VPDa3+vYFnxBd2MUh9EJhoI02BW1h5HgZt/VnbEbB/fmaIZIJMgqNWt1kNCXgq0jtk2PDKJYCpg89gJ3CpbfIyLJNxtt2Hy1jsBFE7XcvL/MrOTYIWg3fMEIhGIpPhakalUCuDwXjmRYTRZecJFVaIdzn+Rg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NMhU9gZmgFbMpW2mBJ2wxJLLoZk/24XH3JUVtygYwaymxsKNX929Yw1n5eE5n85qGZ8GhR4EHYPcUhM1Hzez12r7/KPmXENAOeNWiMXMf50fm09v1sHnGPfjOVm/P5+NsywDvK+3ZYX7yNh2slUCy6mVE3ZLfphWGpBGPib8lRcxkr4R0PeELy7GUe2jaUPIvXB4ifIhiLSvSLEqPcAEqPYUxZFmI8I6TdsgBt/jdWa6Uv0duDupywkEyxPZ86esO0vyCNgA2Bh5RaItvxGmGUynsD3SZXhzPMHXumVQi1eetJ0xfDI9eMuJRw1RU0T464QO2SNwY5xrHMoiAKuCgKh7gj+4fjYwJJqlo/4xwP7STPw05bQ+RuHuQZNnc8Dgt1r1DlY1Hf1GdUOOnPD/FuBP/1pEzHeIkMHd3NxYhib2H6cFZFE2yc6AdCmmCbcjrRdVKfiFYA53JKnOQolaKCYS8T8IXrMna+fPmDt274MLnA9B98eiiKrutHAfhF6WN7iEy+jYwEh345hFDcJ9G5C+5w4iVyKDJaxIp2kwXSF32+1M1bMI5cDj2W8NE6ONdZexZglxz/iwNGWX+cgQ7XDhXAnICVRVRBiogRYkGrcXIFnqPnBXJZVCWqzVmH+q
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc39e3e-c8e7-46b5-25c7-08dec257b335
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 16:38:25.7210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96pqEo+5z0ezy7gxvh731rH6zgf/l+zkJAjPzULkdoGcQ7aI4DY36uCneeTI3gYO0QyiyJojph/Ky2E5iM3OtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5208
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE2MyBTYWx0ZWRfX7GlRMJkl7H2L
 9aDPKDEwKVKuAB/f74nR2bgsRdujHvwO5wuhy5FQj+V4EaR2bL3CZgi3cekIbBPSxIU+GDPlzhn
 CnGAg+lbRu25UOA2lflS1AELEcvBlzbgViQbSJMOWob/eBlUKvj9MfTdqy0nMKoWQMX4KFVFdL1
 H6PcIXvAMuHWbGlsw85LcARyQXUGzooL1Zdy7TGHIU3BB12ee9ZlhmNzNaGvBfhrC9Xzcyus5s3
 2fDpHiJKy++9HgwaKNVbeuMSYBBe5uyqXDg3FnV2Zk3DUpPWP85kxyfW8Fff8QHPd0W7uyOFMhs
 7lNxjDiUvZhXbTf4NqxGcxNTQwLQJ9KMHXap5rkoNsF0Wy+YW10LtrNmKquAdLm18Cat/Ps5OR7
 uckFUwDMJ3syuSnAcjO+cnEYiAJI6jYi/urY6AWKCaXVl/hlzGOmJEPWW4azYAygZknk67mQRy+
 PjJuqjdVxoF6co2UsKQ==
X-Proofpoint-ORIG-GUID: g6H6Kc8RC2sLMBLkOT8MEmmFeVUdV0id
X-Proofpoint-GUID: g6H6Kc8RC2sLMBLkOT8MEmmFeVUdV0id
X-Authority-Analysis: v=2.4 cv=TO91jVla c=1 sm=1 tr=0 ts=6a21aa08 cx=c_pps
 a=6O9SViV89A8ZJb2Gg0v8VA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KAb5x4SsHD3PzxGk7EmX:22 a=pQehfwC0D4oxWvs5GOjV:22 a=NEAV23lmAAAA:8
 a=JAcjjVAEAAAA:8 a=vugxpd_pAAAA:8 a=iP7vMvkZAAAA:8 a=0QPK_YWQbrcEsa51EGwA:9
 a=QEXdDO2ut3YA:10 a=Acyig5GiBk5jV-JuFR3u:22 a=dlIDbnWlQMEhdIxAeUMX:22
 a=SKixG8JwDLmn6dAKAxWB:22
X-Sony-Outbound-GUID: g6H6Kc8RC2sLMBLkOT8MEmmFeVUdV0id
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01

SGV5IEJhc3RpZW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFz
dGllbiBOb2NlcmEgPGhhZGVzc0BoYWRlc3MubmV0Pg0KPiBIZWxsbyBUaW0sDQo+IA0KPiBPbiBX
ZWQsIDIwMjYtMDYtMDMgYXQgMTg6NDEgLTA2MDAsIFRpbSBCaXJkIHdyb3RlOg0KPiA+IE1hbnkg
Ymx1ZXRvb3RoIHNvdXJjZSBmaWxlcyBhcmUgbWlzc2luZyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cg0KPiA+IGxpbmVzLiBBZGQgYXBwcm9wcmlhdGUgSURzIHRvIHRoZXNlIGZpbGVzLCBhbmQgcmVt
b3ZlIG90aGVyDQo+ID4gbGljZW5zZSBsaW5lcyBmcm9tIHRoZSBoZWFkZXJzLg0KPiANCj4gSSB0
aGluayBpdCB3b3VsZCBiZSB1c2VmdWwgdG8gc2VwYXJhdGUgdGhlIGNoYW5nZXMgaW4gZHJpdmVy
cy9ibHVldG9vdGgNCj4gYW5kIHRoZSBvbmVzIGluIHtpbmNsdWRlLyx9bmV0L2JsdWV0b290aC4N
Cg0KSSB0aG91Z2h0IGFib3V0IHRoYXQuICBUaGVyZSdzIG9ubHkgb25lIGZpbGUgaW4gZHJpdmVy
cy9ibHVldG9vdGggaW4gdGhpcyBwYXRjaCwgDQphbmQgaXQncyBnb3QgYSB2ZXJ5IHN0cmFpZ2h0
Zm9yd2FyZCBhbmQgdW5hbWJpZ3VvdXMgbGljZW5zZSBzaXR1YXRpb24uDQpJIHRob3VnaHQgaXQg
d291bGQgYmUgZWFzaWVyIGZvciB0aGUgQmx1ZXRvb3RoIG1haW50YWluZXJzIHRvIHNlZSBvbmUg
cGF0Y2gNCmluc3RlYWQgb2YgbXVsdGlwbGUsIGJ1dCBJIGNhbiBicmVhayB0aGF0IG9uZSBmaWxl
IG91dCBpZiBuZWVkZWQuDQoNClRoZXNlIHR5cGVzIG9mIGNoYW5nZXMgYXJlIHVzdWFsbHkgZG9u
ZSBpbiBiYXRjaGVzLCB3aXRoIHBhdGNoIGJvdW5kYXJpZXMNCm1hdGNoaW5nIG1haW50YWluZXIg
b3Igc3ViLXN5c3RlbSBib3VuZGFyaWVzLCByYXRoZXIgdGhhbiBkaXJlY3RvcnkNCmJvdW5kYXJp
ZXMuDQoNCj4gDQo+IFdoeSBkbyBzb21lIG9mIHRoZSBpZCBsaW5lcyB1c2UgQy1zdHlsZSBjb21t
ZW50cyBhbmQgb3RoZXJzIEMrKy1zdHlsZQ0KPiBjb21tZW50cz8gKC8qICovIHZzLiAvLykgPw0K
DQpUaGlzIGlzIGR1ZSB0byBzb21lIG9sZCBwYXJzZXJzIHRoYXQgb3BlcmF0ZSBvbiBrZXJuZWwg
c291cmNlIG5vdCBoYW5kbGluZw0KLy8gaW4gLmggZmlsZXMgdmVyeSB3ZWxsLg0KU2VlIERvY3Vt
ZW50YXRpb24vcHJvY2Vzcy9saWNlbnNlLXJ1bGVzLnJzdCAoU2VjdGlvbiAyIG9uIFN0eWxlOikN
CiANCj4gPiBMZWF2ZSB0aGUgd2FycmFudHkgZGlzY2xhaW1lciBpbiBmaWxlcyB3aGVyZSB0aGUg
bGljZW5zZSBJRCBpcw0KPiA+IEdQTC0yLjAgYnV0IHRoZSB3b3JkaW5nIG9mIHRoZSBkaXNjbGFp
bWVyIGlzIHNsaWdodGx5IGRpZmZlcmVudA0KPiA+IGZyb20gdGhhdCBvZiB0aGUgR1BMIHYyIGRp
c2NsYWltZXIuDQo+ID4NCj4gPiBJdCBpcyBub3QgZGlmZmVyZW50IGVub3VnaCB0byBjYXVzZSBs
aWNlbnNpbmcgY29uZmxpY3RzLCBidXQgaXMNCj4gPiBrZXB0IHRvIGhvbm9yIHRoZSBvcmlnaW5h
bCBjb250cmlidXRvcnMnIGxlZ2FsIGludGVudC4NCj4gDQo+IEdvb2Qgam9iIGRvaW5nIHRoaXMs
IGRvIHlvdSBrbm93IGlmIHRoZXJlJ3MgYSBwbGFuIHRvIGF1dG9tYXRlIHRoaXMNCj4gc29tZWhv
dz8NCg0KQSBsb3Qgb2Ygd2hhdCBjb3VsZCBiZSBkb25lIGF1dG9tYXRpY2FsbHkgd2FzIGFscmVh
ZHkgZG9uZSwgaW4gDQoyMDE3IGJ5IEdyZWcgS0ggYW5kIGluIDIwMTkgYnkgVGhvbWFzIEdsZWl4
bmVyLiAgSSdtIGZvbGxvd2luZyB1cA0Kbm93IG9uIGZpbGVzIHRoYXQgd2VyZSBlaXRoZXIgb3Zl
cmxvb2tlZCwgb3IgaGF2ZSBzcGVjaWFsIGlzc3Vlcy4NCg0KSSBkbyB1c2UgdG9vbHMgZm9yIGFu
YWx5c2lzIGFuZCB0byBoZWxwIGF1dG9tYXRlIHNvbWUgdGFza3MuDQpTZWUgaHR0cHM6Ly9naXRo
dWIuY29tL3RiaXJkMjBkL3NwZHgtcHJvamVjdA0KDQo+IEl0IHdvdWxkIGJlIGdyZWF0IHRvIGJl
IGFibGUgdG8gcmUtcnVuIGEgc2NyaXB0IG9uIHRvcCBvZiBhDQo+IGNvZGViYXNlIHRvIHZlcmlm
eSB0aGF0IG5vIHNvdXJjZXMgd2VyZSBtaXNzZWQsIGFuZCB0aGF0IHdlIGdvdCB0aGUNCj4gc2Ft
ZSBsaWNlbnNlIElEIGFzc2lnbmVkIGZvciB0aGUgc2FtZSBsaWNlbnNlIHZlcmJpYWdlIGluIHRo
ZSBzb3VyY2UNCj4gaGVhZGVycy4NCg0KU2VlIHNjcmlwdHMvc3BkeGNoZWNrLnB5Lg0KDQpJIGFs
c28gaGF2ZSBzb21lIGF1dG9tYXRpb24gdGhhdCBjaGVja3MNCnRoZSBvdmVyYWxsIHN0YXR1cyAo
YnkgdG9wLWxldmVsIGtlcm5lbCBkaXJlY3RvcnkpLCB3aXRoIHJlc3VsdHMgcG9zdGVkIGhlcmU6
DQpodHRwczovL2JpcmRjbG91ZC5vcmcvYmMvS1Rlc3RfTWlzc2luZ19TUERYDQoNClNvbWUgb2Yg
dGhlIHRvb2xzIEkgdXNlIGNoZWNrIHRoZSBsaWNlbnNlIHZlcmJpYWdlIGluIHRoZSBzb3VyY2Ug
aGVhZGVycywNCmJ1dCBJIGFsc28gbWFudWFsbHkgY29tcGFyZSB0aGUgdmVyYmlhZ2UgdG8gbWFr
ZSBzdXJlIEkgYW0gYXNzaWduaW5nDQp0aGUgcmlnaHQgbGljZW5zZS4gIEluIHRoZSBjYXNlIG9m
IHRoZXNlIEJsdWV0b290aCBmaWxlcywgdGhlIHZlcmJpYWdlIGlzIHF1aXRlDQpjbGVhciBhYm91
dCB0aGUgaW50ZW5kZWQgbGljZW5zZSwgYnV0IEkgZ290IGNhdWdodCBieSBzb21lIGRpZmZlcmVu
Y2VzDQppbiB0aGUgd2FycmFudHkgZGlzY2xhaW1lciB0aGF0IEkgbWlzc2VkLCBtYWtpbmcgYSBz
ZWNvbmQgdmVyc2lvbiBvZiB0aGlzDQpwYXRjaCBuZWNlc3NhcnkuDQogICAtLSBUaW0NCg0KUC5T
LiBJIGdhdmUgYSB0YWxrIG9uIHRoaXMgd29yayBhdCBPcGVuIFNvdXJjZSBTdW1taXQgTm9ydGgg
QW1lcmljYSBhIGZldyB3ZWVrcyBhZ28uDQpZb3UgY2FuIGZpbmQgbXkgc2xpZGVzIGFuZCBpbmZv
IGFib3V0IHRoYXQgdGFsayBoZXJlOiANCmh0dHBzOi8vb3NzZWxjbmEyMDI2LnNjaGVkLmNvbS9l
dmVudC8ySlF0Qy9zcGR4LWFuZC1zYm9tLXdvcmstZm9yLXRoZS1saW51eC1rZXJuZWwtdGltLWJp
cmQtc29ueS1lbGVjdHJvbmljcw0KDQo=
