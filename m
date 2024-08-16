Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C00316F0D2;
	Fri, 16 Aug 2024 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723804042; cv=fail; b=ugO8vw76rNaTAaGtKBbSw65xmWXRyktE8BnuO77NpLVjusqEieIYECBqZZaBPriLboS/Li94K2wk682tsWX9SpESYpAj604TZBPQhsjUeezzFuXidVl46fgNYScP4pKBwX2Ly+qy6uBWyI7kUL+AZyajN3pV69BWwPDVBrdUJ6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723804042; c=relaxed/simple;
	bh=1BDpmu1BBufXSfsiMD62zPgRFODR3l51a8J14Y9f0dI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HocRvhrppM1GUNOKh3Bq9PnJTHYN//wVtbh1n34gdZ6zG8zn6ZUsKjcwJavl2hDAQ17tC+cMQdxtcmRzL5jAKMuEB8AMsNb2aupnJIktoHHVAccPP8i3c1+HncLHTvO4X/SDBD3qN68G5Zl60YOLoJP7z10LtLCK2vObtFqGTJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UtadUHMd; arc=fail smtp.client-ip=52.101.70.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UtadUHMd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZnUHdjkepgUPH0bZ4HpzxOMkCAoQoXeT//iUyETWO3wugw/hg4fLOojb3+wSpPpDaCG34nHRxlXVzZkYZ2y/LTxG10Xld1PGXivrMwwGKAlKUkP/wItDxeIcsK1rDqBD/RGe2v7AQrcvCPOResO482bFV6b0FzMmdov+5VViKaUR47T/m3P6CHLJTAb5Ht7nE3BvF1bzxDCfvXidu+3Di7IVThFQnlA8UsmLBMgTAQcZ4VRv4MNsLluJgys4cjCDcQsT+DB/Xs9pkq+fbgPp/OnNUNYTxsohCFeq3NqlnUXNefXZfPJBQHGrrEuhxYPUQ0IAo5femHvUIOr6S3+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BDpmu1BBufXSfsiMD62zPgRFODR3l51a8J14Y9f0dI=;
 b=knWOZS4CcvNdKLsIofqM0BLsMbg52S7cYAcYpzMjJFiiwjSIOi/UQXIMHIbu7gJHW09nLeAdwL2ET/k1Y6l5+IGOU0WSf0/6hvwSgT+Paj1HfK4yizrtjiAjZSRenLHevPQvPAbQnHtW/wSTEg5oGAce3p/tF+6I5q8cLzc8IUdh3z7kpJfT+dkJTHPuJL96WEnVlsQK4aSvODUV0jXhwweAvR9IIJ9czHUFSxWY0Gw4lCfKIrwTsOBqhDG63Y9pwC8w8HpH3u8jZ6dkj2e5FBXzT92/4nqDPNynBGpe33IANVUIZPRKUnsBcs8CDcg7Fhw5YaF3IBUMEgdo8RFgsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BDpmu1BBufXSfsiMD62zPgRFODR3l51a8J14Y9f0dI=;
 b=UtadUHMdmjvybJXE/lLNeAN5zvlcSN5b5vZvLhOUtxRBuAmC6Aix8oHs4G2NU+Og/dCRQNzemyCoVfh2z3cB7S8oKKoSe0AkcSlUSfMVOrOOpGPn2mLMX/iq/gA4zInDoZH8kFQoCjJqrjAdk6D2AJrzmzKQgeFPEBUzELRbDuCN6CKBkctxmSyyC3K3qd9WIAzr7X2W72Tq3XvyKwUIlwmhtHTQiCK7nr37f72RC8lRsRLJheDvAhfOV2A70MoSyUtO4eSuDmdROu3BTN0uhphQ+fZ1MONKj/inrlLLc6mvKhoZiquFCC56KNBPDIICoCaenp7a3DoNMQ0/s2cHnw==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8688.eurprd04.prod.outlook.com (2603:10a6:102:21f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 10:27:17 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%6]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 10:27:17 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Rohit Fule <rohit.fule@nxp.com>, Sherry Sun <sherry.sun@nxp.com>, Luke Wang
	<ziniu.wang_1@nxp.com>, Bough Chen <haibo.chen@nxp.com>, LnxRevLi
	<LnxRevLi@nxp.com>
Subject: Re: [PATCH v1] Bluetooth: btnxpuart: Fix random crash seen while
 removing driver
Thread-Topic: [PATCH v1] Bluetooth: btnxpuart: Fix random crash seen while
 removing driver
Thread-Index: AQHa78beE2C5tcC5fEyrBp4Ub07g9g==
Date: Fri, 16 Aug 2024 10:27:17 +0000
Message-ID:
 <AS4PR04MB9692DDCF49E162650102A87DE7812@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20240816064751.284786-1-neeraj.sanjaykale@nxp.com>
 <da777827-cefe-4d95-b072-1579f0c662d9@molgen.mpg.de>
In-Reply-To: <da777827-cefe-4d95-b072-1579f0c662d9@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|PAXPR04MB8688:EE_
x-ms-office365-filtering-correlation-id: 51acb173-a7bf-41c0-22c5-08dcbdde00d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N0dyalZJS1lSZDJ5RUQ0aUJBcnJVOEMzNXUyM2V4Q1hZbWN1ODh0cGhEUnV3?=
 =?utf-8?B?SDF2bWdDNW1ST0pWUWM3cVhWUGR0NTZTc1MzaXlwRWZiRFk1YVdwV3lOZXFX?=
 =?utf-8?B?VjR4WVdLL1liTGVoSGJINnlmdnpBakdGQVhzZkY5cXRQZ2lEZldKTGlzMkkx?=
 =?utf-8?B?dEJ4NmRYbVRvb09WV0JzRG1QVk5hc3R0VC82ZndBS0Q2MStTaGt3Y2kzbTJ1?=
 =?utf-8?B?bGliM3JFcWdzZUNGSW9HV05KYXlQYVVZNUQ5bVBoU3MwdktMYlpkSkYrMlNB?=
 =?utf-8?B?QmMwNVhRZ3N5R0dxa1J2MEtZVlBwUlpiTEM4ci9kWWUzM2FPRGg4NUFGRks4?=
 =?utf-8?B?em9KdDk5TE43eTluMFk0L3VIMW5KQVFnU3VtL3dCcDN3R1dxQzhkMW45c01T?=
 =?utf-8?B?N2pKOW95S0s5MldXS0kxQlFiWVlMM3BlNGV5NlpXVzVPUk1HOU93RFA3Vlc2?=
 =?utf-8?B?Y0lRTWx3b0FJdFB6OUs0bGc4V2FhUDY3RXZvYnVFVU9XdlNtUFZ4VkZxbDlq?=
 =?utf-8?B?WnN0YkczMWxxL1FQSmZmak84RW16cmI0VzNFd3pSWmFsNWJsRXJPcGowWEdB?=
 =?utf-8?B?Y1l1SnVPUFpkUm81QXpnQUpJZkZBTk9tVTN2S2x3aFdVMHI1RjNEM20yaCts?=
 =?utf-8?B?VU1OUWhHRDNSTzRzY1g4L3JBNytuSkFxSFJNUDhoNnNodHdiZHkzOXFyZWJP?=
 =?utf-8?B?dXVtejBHbFRuS0N0NXFGQ2dMdC9Pamt2UXU3RVp6dDhyZklGUTQ2ZWZSM1I5?=
 =?utf-8?B?aWVOZTRxVUtQeHRxcUUxSTV1cDNDY00rTDIycmkzNEdUZHVPMVZUSkx5a3RF?=
 =?utf-8?B?NE8zd3RYNEJBM0NSeUZwNktrb3prUEk0UmprS0tRVWVNSmVZcDMrbVlJajBa?=
 =?utf-8?B?SjBOT24wQW1FUWNqTHYxaFlDVWt3LzNiYkNMbkkrZ0RNUDhzMC9EdXozRUsy?=
 =?utf-8?B?YTBpNFROZ1Z0ZGw5VU5ySExSTGNUZUFnc1M5bnF6U0xSQ1kyZTlVcnFXYkRE?=
 =?utf-8?B?KzJERGYyOXFtQ0E4QlowR29jOEI1NmNVUG5CeTJlMnFyRThKaStZZ0w2clhP?=
 =?utf-8?B?ZHF5alR3OENub1I5L0QydjRzK1JnRXNBRnNwcEJSZ1EzMWF2VDZTVUk1dEUv?=
 =?utf-8?B?cTFxRHFmb1FsbnhqWUtzYy8vcStjQlBURW1WSzZZZ3J4QTVyOFdhbS9WWU40?=
 =?utf-8?B?dDZ5Sk82ZmJEMFI5a0RMTzBIejJ2VmgxbFozdm5xdnpOR0JSSEJWMUhNcFpV?=
 =?utf-8?B?OFJCajZ4MXFGOUM5VUdON25HckMyUExhb1h0S0dNdldmekxJVC8zdGd0REZZ?=
 =?utf-8?B?ZUNkdGV0LzNyeHRWdUtLMy9ZTnNsRUhVM0ZtZ1l0KzV4dGdlbHF6VHVEL25o?=
 =?utf-8?B?MUUzS2ZEcUp0NUVONGpjblpwZmsxekY3S3dpMk1KVkxOZ1AvRXFHTHp2aFRR?=
 =?utf-8?B?S0cxd0M3eTFOOGFEeFRUTnJINlpuNTc2L1d6MWJ2QU81dmhoQk9Zb0V4Rm1K?=
 =?utf-8?B?NSs0bjEwNW1JeDloQXEvMm1BRWR0cUc0eEFyQXJsRFV5WStpdWRhbkFSVTBY?=
 =?utf-8?B?RVpnVjFyakRFelI3aUhSN0lpdlVCS3JlK3NYaWRSUEhyV1JURzQrMW1pUmoz?=
 =?utf-8?B?QklTT0ZQeDF3djBBd3oydkRQOFJyZk9Jejc0QnZQLy9WMUZuYXU0eGpQZitp?=
 =?utf-8?B?ZjBiK1diUHNpaXZqclFmMjZnT1V6U0dyM0pabWxtazFUQW9JcE56VnVxZXNP?=
 =?utf-8?B?WU9XOHM4Ukd2Z3FBeFNBU3gzYVRxZHZKVWE5YXpISmxwVWtrdkpRekJ2bjhR?=
 =?utf-8?B?RWlhZlpoOVRJV1Y2a2lhd0E3SmJXNlNvdVN0OE1vVDVaclVKVFNHQm9QV0U3?=
 =?utf-8?B?VzVYZmlZZ0RGeXlDckNaQmh4MG1jMzlMZ1BXaVhwTStwN2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VG5oekRSL0lzckUxSnp4S2x2UzJ6dzZIUHNUMHdndEFFeHJqS2Yra1RqdkZh?=
 =?utf-8?B?Q0I3K0ZiSjBUZnJjREVjbmRiSlJndFA2cHF1MHZYaUpZeHlqUmhCQUVrbnVV?=
 =?utf-8?B?cFRINWlVbEdIVFIyNlk2akxheVdoZ2o3NlJSaTlZU3hJT3dpQjlqREUxUzAv?=
 =?utf-8?B?d00zMEhaaGkwZzhKSE5IdjhsYStJb01KN2NuajRkMmN0RUN1WTVRM0htUHhj?=
 =?utf-8?B?WDJKYkFvWE5sTDdMM2ZISHIxb2p6Y1FQcm1NV3hLV2NRbktxODB2UkUzMVpN?=
 =?utf-8?B?S1hJNUZPWURNdDRCcXVKS05VbFJuVzMyT3hyajBab0tYRmo1RmcxY3JPVysz?=
 =?utf-8?B?UnhObFVtci9yeEgxZDVCWldNWkp3bk9oNVpzVnIycUFtSzZyN01BMzJqelRh?=
 =?utf-8?B?VU04c2QwalRhaUtYVi9UNlhPZXhiWDR6RUlidDV2MFFlL3hoWVBaWDUxUWJ5?=
 =?utf-8?B?ZG1MdHU0V0lHTWtxT0x0R2tkT0dkV3VrS1BONEtvdis4Yk1QbHBaeGptUnJK?=
 =?utf-8?B?T1Exdktua2RGdXhKQWg0SFJveG1HaG1JVGFObVVzaTF6ZE9rRmRobldpbGhS?=
 =?utf-8?B?SWNTcTJKbFF3bS93UU53N3k5bDBnZDZQZk1PQ3ZxZUR4S0d3VE83aGhZRll0?=
 =?utf-8?B?bmc5Mzc1YW5uS3lVd0txUE93VXZ3aXNYV0R6eGdvZzFmSUJpVGxOY0p1ankv?=
 =?utf-8?B?RWFjLzlJYWJ6aEdZYXhnekNhRVR1SVFEdWRZMVhxTHJPUkRqOW8yak1KTnpE?=
 =?utf-8?B?aWdyZlFmckx3NFpkNm5OeHhQS2o3NmNLK1hyelE1UWMrL3d3NlY0SXFUdGtQ?=
 =?utf-8?B?N0VJY1RhRHVkWXI1ZjV4dnVnNVJhbHBCUnJxVjlhZTkveXpJb0RXWDlieG1R?=
 =?utf-8?B?QnVXS2kyUU1GWGZZdmo3d245SURzTEljbm5JdWowTjNXeWVxTDdxU0NsdXRD?=
 =?utf-8?B?bEppM3hkSkY3SEVGS1pWd2JVbjEraEJuZEZzWExMUmpUWTJRZE11blYzWEd1?=
 =?utf-8?B?dC9qTEhBemgrc0RUZlJ0cnhWTTVZTVUzcWwreExWUElpbGtJL0VFSittNWJB?=
 =?utf-8?B?LzJOdklQRFJKVVJ6NU5yVWxjV0UwYkxrc2FXcGgrSGxOdlZFZVBCWjg2a2dh?=
 =?utf-8?B?TzJUYmtZMUVwMFRWZ3hCMXpCMFdJKzkyd3B2NndtS1dnQmcxNkZxVkVydDAr?=
 =?utf-8?B?bkhrTWloVlR5ejNKV29TRkZHVHZLR05UUUUweTRrYjF1QiszRjNBcC96RWZT?=
 =?utf-8?B?Nnh4SlVOUXdUTWZ4eGFKem5IcW9INExwaXl2UXRleHRSR0lHcjIvMk5XOFl2?=
 =?utf-8?B?SjRKckJJRmpjVEFOQ3lGRHZWdVlxWWVQcWhUSXI1aFRoVS9UNDdsbDBMYUVD?=
 =?utf-8?B?bUlMVFY1THpKMllqdUpGblgyZDdZdnFSUm84S3VZcm42Nm82bXZnL01YSER0?=
 =?utf-8?B?OVNaTmxZRTdPQzJyL0lFemx0aU05Yk9mZlA0WkxuWUx4U21UM3kwUlUzNzZE?=
 =?utf-8?B?N1lhb3ZHVEoxZkRJeHVFcUIvd3kvTlg1MXhHUE1rRlJxQTZ1TnBJRXRzTitK?=
 =?utf-8?B?bkRsb01FMzJGNlVnMkxVVERBdDhESlNTRm1jMjdxTTR4dU44NHJrV0JGQ2lR?=
 =?utf-8?B?UUNIalNFWmpFQnRhU1RNRUhjVTAvbTFDVFlLWW9JMlU0cm9PNVFLSG1tMzdk?=
 =?utf-8?B?VVNDM0JqVk14L2IxOWxHdllXajVPV3lQYUxKRjA1NmpIb3BZMHNZUDQ3RXpY?=
 =?utf-8?B?ZkZjendnK3p0ODJPQ2l2bGxHSW1MS25vZHN2N2hVblNYaGJaenFyRXhYZDNO?=
 =?utf-8?B?VTcwTU9hdnRwZnpndnlvV2UwS01vQ0tJeGJvODVVOHAwSksxVTE5VkFtNVox?=
 =?utf-8?B?eFJNUW9NdEFpREh0L21zdngxaHZnNWdiV01WTC9GV2c1WXhrUkZKVXVmc1V2?=
 =?utf-8?B?U3JSUFRTRnhCOHY1VE5sYlNjdGlNTDFzRUxUU0dZbElwSS9uODFjcGFpeGhN?=
 =?utf-8?B?empZRHViMEtDaWZWT095VzJVQmxlVG1YVDV1T0hPcHhWSXJHQU9BTHpJdmV5?=
 =?utf-8?B?YjBvVEU5Zm9sVXN3aWJVNGRuY3A1bS9RZHpHTFZGREdhRG5vYUh4aTVsQ0wv?=
 =?utf-8?B?Yi9PbkdDTXFrWk5EZHBRb3dSSktHSk14Q0Y3TG05OVA1RS8rZWduVTcyTisw?=
 =?utf-8?B?blE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 51acb173-a7bf-41c0-22c5-08dcbdde00d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 10:27:17.4123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tz1yfT7qkhVTUttGvHxJMGa4gg2KqgKXjSJjRLl89NzGqKoBIhHB4xosQ1yeDU6/awjlFsrB1dQP0v7ASjh2eIn+jp5mb9IL7R+y0tQaTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8688

SGkgUGF1bA0KDQpUaGFuayB5b3UgZm9yIHJldmlld2luZyB0aGUgcGF0Y2guDQoNCg0KPiA+IEZp
eGVzOiA4NmQ1NWYxMjRiNTIgKCJCbHVldG9vdGg6IGJ0bnhwdWFydDogRGVhc3NldCBVQVJUIGJy
ZWFrIGJlZm9yZQ0KPiA+IGNsb3Npbmcgc2VyZGV2IGRldmljZSIpDQo+IA0KPiAoSnVzdCBmb3Ig
bWUsIHByZXNlbnQgc2luY2UgNi40LXJjMS4pDQo+IA0KVGhpcyBpc3N1ZSBpcyBzZWVuIGZyb20g
djYuOS4xMS4gSXQgd2FzIGhpZ2hsaWdodGVkIGFmdGVyIGRlZmF1bHQgcG93ZXIgc2F2ZSBtZWNo
YW5pc20gd2FzIHNldCB0byBlbmFibGUuDQpJIGhhdmUgYWRkZWQgdGhlIGRldGFpbHMgdG8gdGhl
IGNvbW1pdCBtZXNzYWdlLg0KDQpUaGFua3MsDQpOZWVyYWoNCg==
