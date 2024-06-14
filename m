Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8A6184126;
	Fri, 14 Jun 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354532; cv=fail; b=UGNKD4O5f+ItyggvLi6p9tlA2GTZ6UEv2UPhjJFiMVgFgNmRXJoOSby6QVUHxwEY0s0m8MX4gAcdD+59mU3nf8UmAERafamwZdLst/D8yNfgFmppWGoevT8MONUvajofmKHFRkmyWmDZRyba4fe0JzA+YkjHIphEk6TsRcQzv1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354532; c=relaxed/simple;
	bh=5GZriSpkjcASn4i3dbnGhzi68cPXXVyzx/pLEMDsiiA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ill8pSFidDZf/GYXB7b3jt+k8azVvsyX+zeJerIHCvkGmq/puB6VzepOYVpbinciX8aB84+mbYMSIArYolrVqkiplO9cFtXVF1Hte5SNXOS5kbDNDMUZvKKWhh8kj+PcZyNnD+UpYzPWFTnxKSCpzpgN0CX48uzU26Q/umBELbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IYqz/rZJ; arc=fail smtp.client-ip=40.107.249.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IYqz/rZJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtxI7WlOPaHLFR1JBSQHF9/fqgU+waW+rJgosCWB8zIWZ7fbiAogs6Cv7Hlaer4tGyaTfqe09J676kKLpSYeojF8D4vX4279HpRH8merD2mf1s/QmrzGqp4IIVc3LRSU2EYnq7cnhlV3dkWMg8uwMZabJq1dwZmkV8v92levWsXh1sgKOL5k4m1HSoYYDdfDjKK5sodnR57ziQm0EFAH+zssakNjXFuApkJuYJECoAMcsKcaj2nH1iUyBV/YcQ9zG6wsdOip+J36+3bYkKd3/MNGoHPc0Qe1GFlxElJux7kV5j82mkZdowEIBoH6jgfUsaOHhNKx0WIp3I7vYKh1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GZriSpkjcASn4i3dbnGhzi68cPXXVyzx/pLEMDsiiA=;
 b=AsFGOi+8zjstGyPJXFQvsV9Gxry0uAR/pS76l38odmYBpfJY4sGXI22QK1HFqyQ5/V64SvYO+Tu44rcEUY7Q3WdqPg2nCcwyuICq47vzCgWn4o78j9OIxuCKwqpknBh3gNkM03MDL7yfD1iVsZ3mi0AlD9aX6ZuMOr334wxbwNZUyy3rn1XrEPu8WjpOImQAdwAlvuW9/A5GzCYWdqjVuTkWk0S28CAN5D3UFQ7yHa28osPsIYMqHj7Guh+Y6fPvftEmCh+3ju6MKCb8R06GPDzAkAXV0X9/PpLo00R4JGL8FUM757OIC6dXPlab5oWlLTj7mnrb+eaxXqRIotpbtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GZriSpkjcASn4i3dbnGhzi68cPXXVyzx/pLEMDsiiA=;
 b=IYqz/rZJynUDms5WFgaNrjIDprqkPDWaK7kMA4PSJ0g4BI/ltoz0EFX0eCaL0ZKWK9SjLFxes4qhxC7Rk8eOura9X/Vgi80uFvNT82Oc7HJC86pBrUuMqkkdl0uzhWLy41dYH1XbPtoVzxNd0zzze41VeoWc+OJFaPGCOs0QOmM=
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8319.eurprd04.prod.outlook.com (2603:10a6:102:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 08:42:05 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 08:42:05 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Rohit Fule <rohit.fule@nxp.com>, Sherry Sun <sherry.sun@nxp.com>, Luke Wang
	<ziniu.wang_1@nxp.com>, Bough Chen <haibo.chen@nxp.com>, LnxRevLi
	<LnxRevLi@nxp.com>
Subject: Re: [PATCH v1 1/1] Bluetooth: btnxpuart: Add handling for
 boot-signature timeout errors
Thread-Topic: [PATCH v1 1/1] Bluetooth: btnxpuart: Add handling for
 boot-signature timeout errors
Thread-Index: AQHavja7DGp8p3IJf0G/b5Q3U+PAtg==
Date: Fri, 14 Jun 2024 08:42:04 +0000
Message-ID:
 <AS4PR04MB9692D1152AC9D6CF302F13CAE7C22@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20240603063753.134272-1-neeraj.sanjaykale@nxp.com>
 <1793d793-2282-43a4-a65d-abfcb590f5cc@molgen.mpg.de>
In-Reply-To: <1793d793-2282-43a4-a65d-abfcb590f5cc@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|PAXPR04MB8319:EE_
x-ms-office365-filtering-correlation-id: cb21804c-2efb-4af4-2885-08dc8c4dde58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|376009|366011|1800799019|38070700013;
x-microsoft-antispam-message-info:
 =?utf-8?B?dzhmYXgrS2ZqYnNCU2YwVmgwakc2ekVIN1dROXI0c2xLZW0wMXVzejl2WlEx?=
 =?utf-8?B?Y0Qxb0tZQVU1bm5ZeG16aW9zelB6QW9rdlJ1Rk1XTXFwMXpBdXFWcmxCSFhL?=
 =?utf-8?B?VDJjTmVZZjhMbVhxbGNXWG1TNkh3VjlOTGxhZS9uNWFUeGl5dm90T0xYWmRy?=
 =?utf-8?B?c255alUyTVlXODltRlVVNCsxVnJFelFoNnNoeXlkMjNtVVFiczQxcExVWXBX?=
 =?utf-8?B?ZmpZU2tqdXRzU0c1TVVtZXlyZXJuVG1tL2VOdzF6R2czMmtyZFhlSXdNVnNj?=
 =?utf-8?B?eVBNWG9aeWtaczhQNDRLcTQ3dEFCUjJZOW9IYWJGOVR5R0YwUDV4TzA0U3VN?=
 =?utf-8?B?elphN2x6QjI1TUFnS1h6cnoxd2ZxVHZjYWdtZGNZRWtrbUhMdkx4VWE0azI3?=
 =?utf-8?B?NTZwcGxuQjY1ZXI1MWNSdEV4bzdYbm9waHh3aGoreHRaMGtzVXhFb3dEQ3Bw?=
 =?utf-8?B?WHNEemlMTWhQdVhPb0FRd2lZa1hyZnVMVzJVZUJXdHNLbElodGw2ZitiK0RS?=
 =?utf-8?B?QWJwT1FBYy9NSGJhOUZjbHk4THlzRUdHUWFlYUpmMS9HbXdEL3hDTFBZMjMw?=
 =?utf-8?B?SUhMRHFsZmF3RVhycUl4eGRmTXVyQ2JEV3NxYXRQeFJyelFtdWZXbEJNQlFK?=
 =?utf-8?B?ZDdxNXJqdUlqTTVuNFZzdXk5NUpWTWloZzZSUkc2QkdudGZrb2tKajJVblVG?=
 =?utf-8?B?OVlkRlRvK0dlUldaMXpMVUU3aTFhMytaV25KeTJGV2RiNlpYay9wdTF0WUhK?=
 =?utf-8?B?TC9xUjdzVHpDM3V5cmhpcEJRU2oxeDdpSC9QelVKTU1EaVhEalZDWUNWS0FN?=
 =?utf-8?B?UVFadGpyZFl1NGQ5V3dHK0JsYkdmVXR1bzh0U2gxK21tV2tDZklKd1ZMRGRU?=
 =?utf-8?B?OEhUTEhYMVZQNTM1ZnFUM0tKd2dRNkFyS1c3U2V1RzZvU0ZSZlRDUzEwWThy?=
 =?utf-8?B?L3V5Qmw4MEwrNVlVRy84akcrZ2tPQy9jN0thUUFqSVBwS1NnUDJLY1V2dVh4?=
 =?utf-8?B?MWIxSGc5UThlcmMybi8vVE54dDZ5WXl4dE9wVEZ0QlBwSlhQSlpVUFpvZmhp?=
 =?utf-8?B?dVdDMUNjZkJGKzI5bEpKaGZ3RFFCMUtvNTcveFRaSmZHeUNFSlY1amtPZkdZ?=
 =?utf-8?B?cktkL3hwWDIvTm50WXZhQmI0VEp2SVhiVXlEZC9GVDVDK1NYUEJ0amhTK280?=
 =?utf-8?B?TS94UDlRcXcvRlhYazgyT2hHZEtRV3FuNWRmTGtsWXNFdXBrQkFpd01rN2Nz?=
 =?utf-8?B?QWlxNWRmRWlFUk04UkZyWkx3a254M3lHQVVpVVJlNlZjUWVoYjZBRHhZdk9t?=
 =?utf-8?B?WnczdW8zakVWaFZHMS93akxkNmh4MWl2TXY0bzJDRVRqQU14Sm5QcmtqYXh4?=
 =?utf-8?B?QkJ4STJxQXFRaHhOMmRiZDJPRmFWdGc0QmZZa0R0ZzE5aFhWMkozWmJOa0Vu?=
 =?utf-8?B?eU81elNsQjBPejQ5d3dkcVR6ZkVjcHlvb2o4N1JWczEvYnlsbFFCQ3BiSlVr?=
 =?utf-8?B?Y05FdTllVWxvM1poS3RiV05obDk0OUxBYWF3anVrZEV3VkNLWHV6ZnJlVW04?=
 =?utf-8?B?RjFiaGN2Qi9QaThPMzlLL0s0OUNpUkx3bG5vSFcwdjRTOXdreFFjVVBxYlJl?=
 =?utf-8?B?NkFndE1uZS9SKzJjbzc3VWVZMWxFbEZUdWliWVEycmhwOGg3Y2Y4bzV5Y1B5?=
 =?utf-8?B?dmNicURHbGFsYVhSQkxtTU93bWhqM3lHakkwMjlyMzdrWFJYTjRMRnpqMEtV?=
 =?utf-8?B?ZWttMFA4eC8wRGZUakdXQjBOVS9QOXIxdWszWWR1TUR2VWppNEZycUZzclV3?=
 =?utf-8?Q?1YHlzFBbYQCWmSmAQxtcODKrMh76ZFi2pKuJY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(366011)(1800799019)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TjFVWTdHRHRXeUpLRmNuV1pHb2Q2SmVFam5kTUU2WmtBbjJWRmdBdDNuY1po?=
 =?utf-8?B?NDFXcFk3V1JVU2ttai9ZaVNOWHNXMjdCWEI4cWIwV1ByNTY4Z0l4STVSK3hU?=
 =?utf-8?B?eC9PcEpTcVFHUUpLWGpKY2xEZHlIVVVyM1FvcVVGdm5IWVp6THR6a1FWWWVM?=
 =?utf-8?B?bjVxZmg0UEJJTWx6YmdTYXJ2WEVLRmUvYVBhRjRFaUdQMDVQVllvaEhGeVRX?=
 =?utf-8?B?SUt1M0IwNVZkM05hNlFKTUtVSEtUNDBNdjROamJwUWhwWGlLbEJUb1p5aGU1?=
 =?utf-8?B?dHFzL2ZucW9nbTBtaWRmUzdZVHBRb1grV0tlbW9HUXByKytqaVJRczVDUVFG?=
 =?utf-8?B?Z2s2d0lNUTRkdU51cjZwc09HOFVQV0tWZWZsVXFUeEh4RWdqSVhJd3hodFBL?=
 =?utf-8?B?ZVNqck01ZnFvNGwxR253NFZhWnQ3ejRRMUphWFIwdkVTVEJHOGhQWlZGUjBP?=
 =?utf-8?B?UEJTNzBkNTBlMFFiVUs3U2svejNSbHhoSU1sSDJYTFdrb3IzMDZHY25hRGFx?=
 =?utf-8?B?ZVMzSmhWSTljTlhabVZsNldLY0c5dnh4R2FrbmJ3WmxMdkdKUFg1TVBFaGNj?=
 =?utf-8?B?c0VXdVp3aTVLN3I5SGhCS29hWGs1NURmVExUajZFbmxMdzhSSW1kWHRsYUpu?=
 =?utf-8?B?VGJjWC9JcERjb3lZeDZsTVVteXBlcFRnNW1uMlZSRWl4bzEreXJBNnRra3Fs?=
 =?utf-8?B?VDNoMHBrQVRJVnV0TjFQVWJmclhzNlFmdW5HcFFVSmlYMVppTjl1OG9zTlJx?=
 =?utf-8?B?NG80cmUwZC82ZWFFL2FiTHcwWi9QVHltQm9XMEZEUi9HSnRyV1BrMVBNRlNx?=
 =?utf-8?B?Q1FLRG1wYXBmWGdXdGNlL2twcGZSRWllaDRwY3YzRkxCbTByMlRtSEIrSjZR?=
 =?utf-8?B?RS9vL3N6YklybzFFM3NHSTBLT09SSGxaT003VXJaV2ovaDJ2czEzK0s3dUh2?=
 =?utf-8?B?MEVtN05RbnJsSEtXc0I2S2ZEMGFYNmU3OXQ3VnpFd1NFS1NBZ1Rhb2kwNy8v?=
 =?utf-8?B?TG5sa3JjNGl2T2YwcEFLQk03K2ZWNU1jU0ZTV0U2Z0FZMHMyM1lYWnNWaDVz?=
 =?utf-8?B?SlZoZSs5MXRUMlFoZFdsbGJCY3JEbVQxMTlJUGdvbnNCb010aG5Hamd3ZVY4?=
 =?utf-8?B?R1M3V2F5ZHVOTEVGaWNCTFREVTVSTVZoc0MyNzRyMmM4NEU0c1BVa3FkdzhJ?=
 =?utf-8?B?STUzT1grQTkxTEVyWWdRcHZQYjJoWmM2S1dwZFQ2M2s3NXdBQ0tTWE1YdGZM?=
 =?utf-8?B?bTdFTFFJUTYyNFdEQXJwbWd2UVBPcS9PL2FNRWRJVXpVUUQwTXU0YzZqTXZI?=
 =?utf-8?B?S3pqaWhQVWtmbzVnM25JMGt3NTdOYlo5RVNwTk9LR0EyUXZRMjhvZTJZZnhy?=
 =?utf-8?B?a1hXTEprRjVEY2JXOVNTL0RrOFUzNnNsWFNyNFlBZ0hsWTdVNHQ5TDdZd0Nt?=
 =?utf-8?B?ZVg0OWhMS2diMGlvZ00yL2lpQ1RPU091cGxvTnE0VjdDNEd4RE82UG1XNlEr?=
 =?utf-8?B?V1doRzc0cElsenJ1K1pZb3dqVldlVDNoNmh4cDJ4ZGhEc2xMM25JSUw3Smh0?=
 =?utf-8?B?UkRodWJhWUVxQldWU0tTMlJLeW9TTTlKcXVvQnNHRmxtWmo4WHliK05VK0R6?=
 =?utf-8?B?VFJySGpLVU45a1VSUFZ1SXdQNHl5K2c5aFM5YU1EcDdGamQyZkFQZm8vaEE5?=
 =?utf-8?B?L1NIRjV0MWlJamQzV1dhcGtUdTd2V0t5M1VQVXVTSGtIemNIRmhuUEpCT0py?=
 =?utf-8?B?SHo1WTdoaHdaQlowMjRIb2p3LzIvc1dxeHZJZnduWFNoTi9YZDJoN1ZaMWxQ?=
 =?utf-8?B?UUNtbWZJS3dTTU9wVm5OaVRxbjNMZU5QSUhJcXlXclZmeVNRNXVIV0lWMEQ2?=
 =?utf-8?B?UlgxZTRFTTg3bnlWdlU0MGdrMU94MnV1b0hXSERXN2FjS25hOHdtVkRwcFda?=
 =?utf-8?B?NzNJR0lyZ280Qlk5NHlEOE5KVldmWDFCTE1xaGlzK2ZzcldXdkdhODNIUzF2?=
 =?utf-8?B?U2YrT2pUQmNpZUkzazFvRkxFRlpKUVpybkF3QzY2ZC9DU0J6UUlHZGYvZjlv?=
 =?utf-8?B?Yno1UUYvaEU2UHlKcVh6NHEwWnVacWNYMjNHOWdDS3R1SFJHQ0lhOW00SWJm?=
 =?utf-8?Q?Jkq/KZpg2BCI/Ti57CqbaX1bq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb21804c-2efb-4af4-2885-08dc8c4dde58
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 08:42:05.0158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bB12JuFPLoK8uEFm2F6dzx0+EL8u0r4VCYyybI6zX5f5ipwzL+TveP43aiNjNI5WxI2AHt+y80VKXhBYkkActnhxo5ubwxwE5wkjb6e3D8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8319

SGkgUGF1bCwNCg0KVGhhbmsgeW91IGZvciByZXZpZXdpbmcgdGhlIHBhdGNoIGFuZCBzb3JyeSBm
b3IgdGhlIGRlbGF5IGluIHJlc3BvbnNlLg0KSSBoYXZlIGFkZHJlc3NlZCBtb3N0IG9mIHlvdSBj
b21tZW50cyBhbmQgc2VudCBvdXQgcGF0Y2ggVjIgZm9yIHJldmlldy4NCg0KPiANCj4gQW0gMDMu
MDYuMjQgdW0gMDg6Mzcgc2NocmllYiBOZWVyYWogU2FuamF5IEthbGU6DQo+ID4gVGhpcyBoYW5k
bGVzIHRoZSB0aW1lb3V0IGVycm9ycyBzZWVuIGluIHRoZSBib290bG9hZGVyIHNpZ25hdHVyZXMN
Cj4gPiBkdXJpbmcgRlcgZG93bmxvYWQuDQo+IA0KPiBQbGVhc2UgYWRkIHRoZSBlcnJvciB0byB0
aGUgY29tbWl0IG1lc3NhZ2UuDQpXZWxsIHRoZXJlIGlzIG5vIGVycm9yIHByaW50ZWQgaW4gZG1l
c2cuIFRoZSBib290bG9hZGVyIHNpZ25hdHVyZSBjb250YWlucyBhbiBlcnJvciBmaWVsZCB3aGlj
aCBoYXMgY2VydGFpbiBiaXRzIHNldCB3aGVuIHRoZSBjaGlwIGRvZXMgbm90IHJlY2VpdmUgdGhl
IGV4cGVjdGVkIHJlc3BvbnNlIGZyb20gdGhlIGhvc3QuDQpUaGVyZSB3YXMgYSBkZWJ1ZyBwcmlu
dCAiRlcgRG93bmxvYWQgcmVjZWl2ZWQgZXJyIDB4MDQgZnJvbSBjaGlwIiB3aGVuIGRyaXZlciBk
ZWJ1ZyB3YXMgZW5hYmxlZCwgYnV0IHRoaXMgZXJyb3Igd2FzIG5vdCBoYW5kbGVkIGluIHRoZSBp
bml0aWFsIGRldmVsb3BtZW50IHBoYXNlIG9mIHRoaXMgZHJpdmVyLg0KQXMgbG9uZyBhcyBib290
bG9hZGVyIHNpZ25hdHVyZSBjb250YWlucyBhbiBlcnJvciwgdGhlIGNoaXAga2VlcHMgcmVxdWVz
dGluZyBmb3IgdGhlIHNhbWUgRlcgY2h1bmsuDQpUaGlzIGVycm9yIGNsZWFycyBpdHNlbGYgYWZ0
ZXIgZmV3IGl0ZXJhdGlvbnMsIHdoaWNoIGlzIGluZGV0ZXJtaW5pc3RpYyBhbmQgRlcgZG93bmxv
YWQgcHJvY2VlZHMgYWhlYWQuDQpUaGUgYm9vdGxvYWRlciBleHBlY3RzIHRoZSBob3N0IHRvIGFj
a25vd2xlZGdlIHRoZSBlcnJvciBhbmQgY2xlYXIgaXQgYnkgcmVwbHlpbmcgd2l0aCBhIE5BSy4N
CkkgaGF2ZSB0cmllZCB0byBleHBsYWluIHRoaXMgYnkgcmVwaHJhc2luZyB0aGUgY29tbWl0IG1l
c3NhZ2UgaW4gVjIuIExldCBtZSBrbm93IGlmIHRoYXQncyBmaW5lLg0KDQo+ID4gQEAgLTE4Nyw2
ICsxODcsMTAgQEAgc3RydWN0IGJ0bnhwdWFydF9kZXYgew0KPiA+ICAgI2RlZmluZSBOWFBfTkFL
X1YzICAgICAgICAgIDB4N2INCj4gPiAgICNkZWZpbmUgTlhQX0NSQ19FUlJPUl9WMyAgICAweDdj
DQo+ID4NCj4gPiArI2RlZmluZSBOWFBfQUNLX1JYX1RJTUVPVVQgICAweDAwMDINCj4gPiArI2Rl
ZmluZSBOWFBfSERSX1JYX1RJTUVPVVQgICAweDAwMDMNCj4gPiArI2RlZmluZSBOWFBfREFUQV9S
WF9USU1FT1VUICAweDAwMDQNCj4gPiArDQo+IA0KPiBQbGVhc2UgbWVudGlvbiB0aGUgZGF0YXNo
ZWV0IG5hbWUsIHJldmlzaW9uIGFuZCBzZWN0aW9uIGluIHRoZSBjb21taXQNCj4gbWVzc2FnZSBm
b3IgcmV2aWV3Lg0KQXMgbWVudGlvbmVkIGVhcmxpZXIsIHRoZXNlIGVycm9yIGNvZGVzIGFyZSBw
YXJ0IG9mIGJvb3Rsb2FkZXIgc2lnbmF0dXJlcy4gVW5mb3J0dW5hdGVseSBJIGNvdWxkIG5vdCBm
aW5kIGFueSBkb2N1bWVudC9kYXRhc2hlZXQgaW4gcHVibGljIGRvbWFpbiB0aGF0IG1lbnRpb25l
ZCB0aGVzZSBlcnJvciBjb2Rlcy4NCkkgaGF2ZSBhZGRlZCBmZXcgY29tbWVudHMgaW5zdGVhZCB3
aGljaCBleHBsYWluIHRoZSBtZWFuaW5nIG9mIHRoZXNlIGVycm9yIGNvZGVzIGluIFYyIHBhdGNo
Lg0KDQpUaGFua3MsDQpOZWVyYWoNCg==
