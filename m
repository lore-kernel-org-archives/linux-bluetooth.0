Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4527D17624C
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jul 2024 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802542; cv=fail; b=Y+Gdq/lvuArS5AGm5ooaLX6DGUwxfMIORbnJMnP53x3n9OkpjITtZTxI2BrGFmQJdlnjJErQovRngiNrHEEd5GZr1l8h0CX+g6s3ORo+H/o3MoYuNiksJbFYpGHe83UHTSON9s7iXxHocmueNO3HottWNtE5nePUmdoFg/i0ClY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802542; c=relaxed/simple;
	bh=wWaQ7+1YF+WGOzp4TX1fqxLFIQaDnutvrvhH+ArCEj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e5o2eIR/KT5MmceNXmUhdQfqa06HKF9UDdCDKsOcgfFKz3hVI2ZqkXS2Re6PNEEdECBIbAOkJ27mXo44i++HfA2XDF9C5mP/xHJhCM2WH9rzBHIVFpsi1N9Qs1L/W7m+D5ObFN4NWAdBYd7/88F7ap3nC8M9iE7YU1ndXvakEF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=dDcuM232; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="dDcuM232"
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CCkASi016301;
	Fri, 12 Jul 2024 12:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	smtpout1; bh=wWaQ7+1YF+WGOzp4TX1fqxLFIQaDnutvrvhH+ArCEj8=; b=dDc
	uM232FNeDHJPNvbB7/CQFXnKwaL4ig63qy6nn1RGitVc7d2ewlz4GUFwQigMunOI
	EPKPSBdb5rziYuG2kHZicBgISX5M3LlpkJZiVvJO3BtY6sc2Wx1BPC6l6QvuaaU4
	L4TM9dKZR3CAD9EosByKT4wJ4zn0NZ1H1MVnh9r2jfgyadQScrJDczZW8DwEU+1B
	M5x79R5vDXByQeZWtsPL8yNZhikHH8suy0WE8ULjG9f4UERuVs8/3bflXwBHAnST
	3PcOPRn/RHDlfNe65hgtLgG3IRCpGVn5/CKGynG8jPHk/zzQ1FL7fXb+CYuag4bV
	sIY0mAi5AoO1SxAFzdg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 407156dj2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 12:42:17 -0400 (EDT)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 46CGB5Al021378;
	Fri, 12 Jul 2024 12:42:17 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 40avx9jmra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 12:42:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCL7F0fCc2h+rCXIwOFNq1DXJyRyq1336iaPB/iTbCzn/vcGowE2J9AqZZ6YITpT3kp02FiaDA/p0yhoGgBUZI0Spg2SfBTK325hWSqScXmfxck5uXnEjjE8kR1OKAPz90Bvl9C74+TN+Ektd/pEkT4j32ZqhsnD3oQdrfe2wZsOEhrhd3FN9847wUhsoIPAtWWPTffbWDQeyHljW0ogr/txMKrHnT/9d6L37hRadKY7iP+UIXKP6l1yzzpK52QxomBZOk7t+lRVjH3sidlXFgkLEBCETTTdkmpwlzllsjtPBI1DIiZ40VN5b3ju4bPKqaLBXAOdwqpeVSUzqFU+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWaQ7+1YF+WGOzp4TX1fqxLFIQaDnutvrvhH+ArCEj8=;
 b=uM2O/Axv+j5UBYJabS15XMRACZAjFIXu6u9iHwLPHjknVARj7uUB3JfY1SPupiXq6GX8k0KJSG2U0s7DUnjn/ZwgN/U/maG8MObsOrQ3SyjJHtvGX70/D7GRJiUzHG0DIsZYG7tacugWREWjMOuy12QUmDCzrfzGTz0ihhI8sAhC3LiCC3nKmLBx6yTM1xpBfWfKj2e0+yBbar45gGeMlzRVh/SiTs7MJt+yT7arB1GxscLuOShXpiBdLqXEUckqY+np4cxdjllXQiFK7gZp4ZvhEacKRFz9K2egxcy7uFNELEn7qH5qfP2PofpCbSBboO+rhyIId6AEfHSIr69FHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SN4PR19MB5421.namprd19.prod.outlook.com (2603:10b6:806:20c::7)
 by BY3PR19MB4835.namprd19.prod.outlook.com (2603:10b6:a03:368::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Fri, 12 Jul
 2024 16:42:13 +0000
Received: from SN4PR19MB5421.namprd19.prod.outlook.com
 ([fe80::237c:614c:8f0b:ae83]) by SN4PR19MB5421.namprd19.prod.outlook.com
 ([fe80::237c:614c:8f0b:ae83%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 16:42:13 +0000
From: "Ramsay, Trey" <Trey.Ramsay@dell.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14) Prepare
 Write req (0x16)
Thread-Topic: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14) Prepare
 Write req (0x16)
Thread-Index: 
 AQHa0j9b0zaQeN00PEyxcrJ2hKNEr7HwXB7wgAAbcQCAAUmRIIAAFVYAgAAcjgCAABEZAIABRJOw
Date: Fri, 12 Jul 2024 16:42:13 +0000
Message-ID: 
 <SN4PR19MB54210A0B9F146FD283208663E4A62@SN4PR19MB5421.namprd19.prod.outlook.com>
References: 
 <SN4PR19MB5421B1226EA92B735CADEA44E4C82@SN4PR19MB5421.namprd19.prod.outlook.com>
 <SN4PR19MB54215EF3B4E7380A21387D2EE4DB2@SN4PR19MB5421.namprd19.prod.outlook.com>
 <CABBYNZ+8ca5f6nWG3D3x8mL3g=57Z0pogQP-+ww_aQuC0R1DWw@mail.gmail.com>
 <SN4PR19MB54214DD841A41FB8C01DDFC9E4A42@SN4PR19MB5421.namprd19.prod.outlook.com>
 <CABBYNZJpG3ioCK9Skqx7_ki3TrqF+Z0GecApPF6Crv+D+J3hDA@mail.gmail.com>
 <SN4PR19MB5421EA5BEB05EFAC63160576E4A52@SN4PR19MB5421.namprd19.prod.outlook.com>
 <CABBYNZJXfviR-5FND4LxMtdwDL1y-_iRkEJsrp+PkyVk+g=BNw@mail.gmail.com>
 <SN4PR19MB542196B1C79E5262A2F578FBE4A52@SN4PR19MB5421.namprd19.prod.outlook.com>
 <CABBYNZLzgTLqHcKfmOaPUKMkcPXsBeWxbTTfH1V+Dkm-Kvwwog@mail.gmail.com>
In-Reply-To: 
 <CABBYNZLzgTLqHcKfmOaPUKMkcPXsBeWxbTTfH1V+Dkm-Kvwwog@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=b72b80f3-49c0-444d-b341-6aadcdb9cb3c;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public
 No Visual
 Label;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2024-07-12T16:14:46Z;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR19MB5421:EE_|BY3PR19MB4835:EE_
x-ms-office365-filtering-correlation-id: ab0166af-92b0-4a45-3335-08dca2919537
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?a0o0dk8wdk9lcU53aWUyTDR1VXJZK012S1pnVFNDR09oRVkvbTNrMWtOb2pC?=
 =?utf-8?B?bHpxdEFES2d4SFhGSmtWSW5ENktMVUhEY3FQb0laU1VyVGR4NG9idlp2elRT?=
 =?utf-8?B?NlRVTWp5Vi9PODFsT1JUM2hrNlcycWlqd01CMjE3MEliajlPOTYyUmtIaEEr?=
 =?utf-8?B?WHZFVm16c2lPaWtDQTEzWUlNVVFoY1Zab3gzQXVVZ2RIdFBUZVFSbEdkaXp1?=
 =?utf-8?B?RDlBSzhlVk9RMzFFZ2tzMDd1b3VZaTNDNit4OFFtTW1BWERkQUhTL1hleEJ0?=
 =?utf-8?B?NEYwU24rWlJpVFhPamxmNmhiS3BsUUJjRDFXM25vekpSZ09JdWdsMnpoeDdL?=
 =?utf-8?B?VWF5VTdxNml0VUxmNnlEZXl1UFZTUnV5RDgrVHA2cjNpOVUyaUdEcGdmOTNu?=
 =?utf-8?B?K2xsODZGRkVoUUlwT0s5cFpWTStybmV0Q0FDVG1QTEZoNEhHWXFPRUk1WFY3?=
 =?utf-8?B?UDZLRGFZU0NjSElBdk8rOUkyQWMwUmF3UFRaWFVDUW9BZEVxVDJ5eVZCbVpC?=
 =?utf-8?B?RDU4bVl0ZkhZWHpOMWRpWklaeE5mZ1R1WUNKK24xbkFISnNBWHF6QVAzUTcy?=
 =?utf-8?B?WWgyVXZHY0ZkOHlnMkUxY1NOOGhESjBPNmN4OXdQUHJ1bDZuVVJwaVVJN1dM?=
 =?utf-8?B?dk9sUFJJSzkvYndsVm1BaFYvcjlGTk1Rdm5HdDE3SFJmSDd1elhQdHdBUEpq?=
 =?utf-8?B?aWNkNmVoQ0dYS0RpV0J6RzhyVittRzFiSlg4elBmelhjVVhueHZGMUZKZWIw?=
 =?utf-8?B?V1EyREMzVEVGeXRicnR0cXlhQm9TQ215eG85WkpWbHdKaE5qM0ZvdDNzZ016?=
 =?utf-8?B?Ymd3WGVxWGdlV2xuT1VlU2JhR05YSEk2ZnNSZVMrNmZpUnFuRzl3bEp2OGRW?=
 =?utf-8?B?YkZRbkN3b1V3bVJsSUdNQ3BpNkdtSXNCNWtXTTcrbldSM25yQ05henFGamQr?=
 =?utf-8?B?bkYyalY3Tk12SWp2TmZyOVdJZldQUHZpajZYdCt5cU9HR2pUNHpaeWlxRUtW?=
 =?utf-8?B?ZDIxZWJscG1PMlJXYXFmaW0xOGowNGY0anVCay9ueTF4bEJOayt0M2VucGp6?=
 =?utf-8?B?Y2IveExJNiswS3I5azY1T3p2b2VPc1dRMjRTaE1DdWdpaDU0YkVoS09BYVEv?=
 =?utf-8?B?RDlQbDVxMkU3Uk10YlJhcWsyNGxsMzJyLzFVREk3dFJsQzBKSWFDcG1VWEZM?=
 =?utf-8?B?c0xwU21wUk4yOEVocUZBb3Z3T3JjNDYzR3NDSkFIMzhtM1VZTXNZWHpjbHUx?=
 =?utf-8?B?OU5IVS9uSVYwNXRBeDRIdFFmSFZud3Y3QlVvSkVEQXMwbDZTQnBhbU5KWnY4?=
 =?utf-8?B?VStGcCtLS0pTaDFWbXppUzBDek1ySytzOU1JdjJqYStwSHA2bThkdGdzcWFv?=
 =?utf-8?B?VDR1SFNyOXZlamkxR0pHL3BTTGkrTnU1V0FEY3ZVN0dBSE04eDllaWdyU3Zk?=
 =?utf-8?B?SVFZZDQvMTNwdk93Y0x6WWJFT3FkRGJpazhGWmpOcmRsdWVtb1drVi9kSE9p?=
 =?utf-8?B?QXZ2WWt1RjFQRGZXVEZZQ2JpVmJkYWJZQ3hTaDJGVjU3WnUrV1JCQzZQR3R5?=
 =?utf-8?B?c2hmS3BmczVhZXREbXpFR05GNFExdVNOc0JINkJxbzdkZFhsYk5xWUFOTUUz?=
 =?utf-8?B?Q3lta3lJRk9qMlEvTHdpanNyQkVHK2tMekpWcm1wK2wxdVMyNFdHamcvTmFv?=
 =?utf-8?B?YVh6VGVtWmZNRkwvZ3pYTk81bGtRenc5amdkb05NNEgyVk1iUW8rZHJObkJU?=
 =?utf-8?B?R20vclp5WHRtcUcyV1E3OXZPb0pFc3RrQnEyUmtnNzV1SXl2SnAxRzNQeDNl?=
 =?utf-8?B?bE14RW1EWFRiSlVaUkYvcU85SlpGbXlSU053N25mVWpjUERpczcwcDkwRHBV?=
 =?utf-8?B?MW9uSzVLb0ZhZi9ESUpWK1pvd3ovbHhWUlM2NnR0b1BGMmc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR19MB5421.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eWNyUGp4aTFyNmZIamdWR0V1eloyYkNWWEQrYlFYaXJYTUFJNXZac2ZXSENV?=
 =?utf-8?B?OHpZdGhWM1BneGRCM1NicWFoWmFIV25sOEdWY3NBd0RDWk5KRnZzb01QMTBI?=
 =?utf-8?B?RHRtd0hSQi9GcjBhWk5oNUNGckVCYjR3RDAvNkVrb0ZpYy9aK3JmL1p3aVJz?=
 =?utf-8?B?RE1BbDk1K2FCVzRjcDNqZTdobjZmQk5kWTY3MGVlSkpVQS9RMzBqZm4xQksw?=
 =?utf-8?B?dWRmVWhQU0dIWnArTmxKZFN5elc5Y2lPUlFKVXpBViswYlNndXYvVHVVMUN4?=
 =?utf-8?B?WERIbG4yRDEyb3BxV21tVlVBYi8wKzBsY2xwTUxURE9GN0ltMDhtVDVCUEw1?=
 =?utf-8?B?ZDBYWkpJRXczd3BpMHpCS1Q0WTN1VGtqWHN5ZWZOSmRRajJCYkRrWGx5cll4?=
 =?utf-8?B?SWhHeVR2Wm1zTWl2SHlPblRIbEtaN3dPaGNqR0dlcXRkeTFBTnk3c2hEL2Vo?=
 =?utf-8?B?aUc3d3VIZEpEZEZEQVRQNEozY2VWdEV3KzF4NHZHdmFWb2psMm4rcHhSZmFp?=
 =?utf-8?B?UFkrbzdZTFBsa21zTXhQRjREYWhEMTYzV1hNNUdJTHdDN3hKTW9hMDhWd1F4?=
 =?utf-8?B?Z01nRnE5MGpDQVg0V0JTSnBTdGRnSERhcUZiUHRGODR3MHRPWXZXNVh0Ny82?=
 =?utf-8?B?NUVGcGRrUll4Ymw5SnZVOGptaVJtV3p0Umdjd25CRTl0VHNYWS9CelozcVZ1?=
 =?utf-8?B?SExiT0M1ZG9wMjVjalRXdTBzZjFyZnJWYm9LVG9QcUFJTlB1Wkt4RGJoUE9Q?=
 =?utf-8?B?bzhqYm9UVTVqNXlGb0RCTmdENkFFdS9DT3JFU2RHWjRXVG44VjdIeitQdFF6?=
 =?utf-8?B?QWFIU09Yek1kblhmYXlhVWJ3OEVRZUZxWmRpUjFIV1dsbkZTS21PcEc4MGFC?=
 =?utf-8?B?Tk5tenBtRDJWWlBqTkJ5Q0tRcWxScWVXeTcrV1J3UVdkZUdrYjZMWXl3V3BM?=
 =?utf-8?B?dDhIUEZZR244azBHdzZCcXgvS21SUmlZcmR4Zk51ejExUzNTRjRoUnFEa1Jk?=
 =?utf-8?B?U0hCaldMeWZ2cXQxTGtHYkNUdTd4TDlRRzhEdVhPeDRzZytOUnpHSmlMWVZm?=
 =?utf-8?B?UGpIN2ZiMlVSLzdyVDRWK3YzaktPVmRZcXRxb2RLYk5XYzNhNS9XT0ZERSsy?=
 =?utf-8?B?STZQdURjSlhpNGx2bHdxdytxZDdwS21NQ3doNVNLUDdPWTM5ekpYOTRwNk9K?=
 =?utf-8?B?QXZGVENtKy8yWE9yMEFrRXBwTnRnK2dmaGc3YjRIUUNmRmZXcGc4UW8yNjBP?=
 =?utf-8?B?VnlKV1VVSUE4cmlGdDEvYXZNNVhtZ3ZkR2xLWTA4REtqYzhKQUF0LzRIZFFw?=
 =?utf-8?B?cUJnOFc4UnB5akxpblVMb0o4UUFLeEtocnlCcXhsTDkwNjhVN041QWNBVFBU?=
 =?utf-8?B?ZmFBY1RWbnh2MEU3MldNVkpFNU42T1d0dlRMam9TMGNtdERDT1hCNFBVL21j?=
 =?utf-8?B?YldDR1UxMDdYK3AwanBQcm5lYWxLaEVtSUI2d1ZGYzV0djZseFRZM2pvczhN?=
 =?utf-8?B?TktIV1AvWmF3TmFudG9FUnRHYVNQRmNBWWZmeFZia0RWSGZ5RUsvRWVnZWwx?=
 =?utf-8?B?SDloZm1lVVpsc3d4dDFiZmRjR2s2RHZlYXdsN2FIR1dzNTJMQ3F5VDdlaHgw?=
 =?utf-8?B?OVh1UjhNQ1g5RnNRaEQ0anltNnNudWdWMzFCTVlWVGdqSHB4SHJCaHNxV3pr?=
 =?utf-8?B?WEJKdnFoRy9TUElRNVJiQlN6OXJncXBieHBRNTR0SytHQUxlSE9pZ2JEMVdC?=
 =?utf-8?B?czBjbjFnR1hNZ3BGdGh6Vjd4dThYTXI5Q0dIWnNwUXh1dzJvdUR4cXpldGdh?=
 =?utf-8?B?Y2NGbkY4ek1nV3M4RHFHTUJTRTE1VSs0ZTFTZWhFMkptUVZjbFpXNmFrQlAv?=
 =?utf-8?B?N2xETmR5RjhwVktvbUVhNUFlWEJ0dmxNNnpRRDhDSGEya3ZnRnhOZW1XS2F4?=
 =?utf-8?B?b0k1eFJFWDZCQ3JOU01lajMyL2daWkl6aHQ4TUt6VllKTitWWndMMU9FeFVw?=
 =?utf-8?B?cktBcWpZSUIxeWZ0MWxDVnJwdm1Ed2RIYWZFUzJqbnVVUVM0b2d1V1BKQTBR?=
 =?utf-8?B?dVlRVkZFaDVBVVBBSXNyb0VwMUxBNFJuSEQrT2lGN0JIb1JGU2gyRElPNFkr?=
 =?utf-8?Q?R5sYd62mmerQ5cLgaMDmSxlaF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR19MB5421.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0166af-92b0-4a45-3335-08dca2919537
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 16:42:13.6793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: did4ipiC0yszDTSOTMgFmbwkU7IxbWVhLVbdiN8+DZWUarWPPYs0YJc8915miwdTT3QbxFyqhRGwsP8v0Q5Pqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB4835
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407120114
X-Proofpoint-GUID: -4V6fEInJA8Xx1HwoHfPlVMqxNndEKRW
X-Proofpoint-ORIG-GUID: -4V6fEInJA8Xx1HwoHfPlVMqxNndEKRW
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407120114

SGkgTHVpeiwNCldlIHVzZSBnYXR0LXNlcnZlciBmb3IgaW4gaG91c2UgQk1DIGRhZW1vbiBmb3Ig
QkxFIGNvbW11bmljYXRpb24gdG8gYW5kIGZyb20gdGhlIEJNQyB2aWEgbW9iaWxlIGRldmljZS4g
IFdoZW4gd2UgdXBkYXRlZCB0aGUgYmx1ZXogbGlicmlhcnksIHRoZSBhdHRyaWJ1dGUgZm9yIHNl
dHRpbmcgdGhlIElQVjQgc2V0dGluZ3MgZmFpbGVkIGJlY2F1c2UgYSByZXNwb25zZSB3YXMgbmV2
ZXIgc2VudCBmb3IgcHJlcF93cml0ZV9jYg0KDQpJIGJlbGlldmUgcHJlcF93cml0ZV9jb21wbGV0
ZV9jYiBzaG91bGQgYmUgY2FsbGVkIGFmdGVyIHByZXBfd3JpdGVfY2Igc28gdGhlIEJUX0FUVF9P
UF9QUkVQX1dSSVRFX1JTUCByZXNwb25zZSBpcyBzZW50Lg0KDQpUaGFua3MsDQpUcmV5DQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxs
dWl6LmRlbnR6QGdtYWlsLmNvbT4gDQpTZW50OiBUaHVyc2RheSwgSnVseSAxMSwgMjAyNCAzOjUz
IFBNDQpUbzogUmFtc2F5LCBUcmV5IDxUcmV5X1JhbXNheUBEZWxsLmNvbT4NCkNjOiBsaW51eC1i
bHVldG9vdGhAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBBVFQ6IEVycm9y
ICgweDAxKSAtIEVycm9yOiBVbmxpa2VseSBlcnJvciAoMTQpIFByZXBhcmUgV3JpdGUgcmVxICgw
eDE2KQ0KDQoNCltFWFRFUk5BTCBFTUFJTF0gDQoNCkhpIFRyZXksDQoNCk9uIFRodSwgSnVsIDEx
LCAyMDI0IGF0IDQ6MTTigK9QTSBSYW1zYXksIFRyZXkgPFRyZXkuUmFtc2F5QGRlbGwuY29tPiB3
cm90ZToNCj4NCj4gVGhhbmtzIEx1aXosDQo+IE1heWJlIEkgZG9uJ3QgdW5kZXJzdGFuZC4gSW4g
Ymx1ZXogNS4zOSwgcHJlcF93cml0ZV9jYiB3b3VsZCBzZW5kIEJUX0FUVF9PUF9QUkVQX1dSSVRF
X1JTUCBhdCB0aGUgZW5kIG9mIHRoZSBmdW5jdGlvbi4gIEluIHRoZSBuZXcgY29kZSwgcHJlcF93
cml0ZV9jb21wbGV0ZV9jYiBpcyBzdXBwb3NlZCB0byBzZW5kIEJUX0FUVF9PUF9QUkVQX1dSSVRF
X1JTUCAgYnV0IHByZXBfd3JpdGVfY29tcGxldGVfY2IgIGlzIG5ldmVyIGNhbGxlZCBmcm9tIGdh
dHRfZGJfYXR0cmlidXRlX3dyaXRlLiAgV2hvIGlzIHN1cHBvc2VkIHRvIHNlbmQgdGhlIEJUX0FU
VF9PUF9QUkVQX1dSSVRFX1JTUCBzaW5jZSBwcmVwX3dyaXRlX2NvbXBsZXRlX2NiICBpcyBub3Qg
Z2V0dGluZyBjYWxsZWQ/ICBXaXRoIHRoZSBwYXRjaCwgcHJlcF93cml0ZV9jb21wbGV0ZV9jYiB3
aWxsIGdldCBjYWxsZWQuDQo+DQo+DQo+IEZyb20gQmx1ZXogNS4zOQ0KPiBzdGF0aWMgdm9pZCBw
cmVwX3dyaXRlX2NiKHVpbnQ4X3Qgb3Bjb2RlLCBjb25zdCB2b2lkICpwZHUsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MTZfdCBsZW5ndGgsIHZvaWQgDQo+
ICp1c2VyX2RhdGEpIHsNCj4gICAgICAgICBzdHJ1Y3QgYnRfZ2F0dF9zZXJ2ZXIgKnNlcnZlciA9
IHVzZXJfZGF0YTsNCj4gICAgICAgICB1aW50MTZfdCBoYW5kbGUgPSAwOw0KPiAgICAgICAgIHVp
bnQxNl90IG9mZnNldDsNCj4gICAgICAgICBzdHJ1Y3QgZ2F0dF9kYl9hdHRyaWJ1dGUgKmF0dHI7
DQo+ICAgICAgICAgdWludDhfdCBlY29kZTsNCj4NCj4gICAgICAgICBpZiAobGVuZ3RoIDwgNCkg
ew0KPiAgICAgICAgICAgICAgICAgZWNvZGUgPSBCVF9BVFRfRVJST1JfSU5WQUxJRF9QRFU7DQo+
ICAgICAgICAgICAgICAgICBnb3RvIGVycm9yOw0KPiAgICAgICAgIH0NCj4NCj4gICAgICAgICBp
ZiAocXVldWVfbGVuZ3RoKHNlcnZlci0+cHJlcF9xdWV1ZSkgPj0gc2VydmVyLT5tYXhfcHJlcF9x
dWV1ZV9sZW4pIHsNCj4gICAgICAgICAgICAgICAgIGVjb2RlID0gQlRfQVRUX0VSUk9SX1BSRVBB
UkVfUVVFVUVfRlVMTDsNCj4gICAgICAgICAgICAgICAgIGdvdG8gZXJyb3I7DQo+ICAgICAgICAg
fQ0KPg0KPiAgICAgICAgIGhhbmRsZSA9IGdldF9sZTE2KHBkdSk7DQo+ICAgICAgICAgb2Zmc2V0
ID0gZ2V0X2xlMTYocGR1ICsgMik7DQo+DQo+ICAgICAgICAgYXR0ciA9IGdhdHRfZGJfZ2V0X2F0
dHJpYnV0ZShzZXJ2ZXItPmRiLCBoYW5kbGUpOw0KPiAgICAgICAgIGlmICghYXR0cikgew0KPiAg
ICAgICAgICAgICAgICAgZWNvZGUgPSBCVF9BVFRfRVJST1JfSU5WQUxJRF9IQU5ETEU7DQo+ICAg
ICAgICAgICAgICAgICBnb3RvIGVycm9yOw0KPiAgICAgICAgIH0NCj4NCj4gICAgICAgICB1dGls
X2RlYnVnKHNlcnZlci0+ZGVidWdfY2FsbGJhY2ssIHNlcnZlci0+ZGVidWdfZGF0YSwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiUHJlcCBXcml0ZSBSZXEgLSBoYW5kbGU6IDB4
JTA0eCIsIA0KPiBoYW5kbGUpOw0KPg0KPiAgICAgICAgIGVjb2RlID0gY2hlY2tfcGVybWlzc2lv
bnMoc2VydmVyLCBhdHRyLCBCVF9BVFRfUEVSTV9XUklURSB8DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJUX0FUVF9QRVJNX1dSSVRFX0FVVEhFTiB8
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJUX0FU
VF9QRVJNX1dSSVRFX0VOQ1JZUFQpOw0KPiAgICAgICAgIGlmIChlY29kZSkNCj4gICAgICAgICAg
ICAgICAgIGdvdG8gZXJyb3I7DQo+DQo+ICAgICAgICAgaWYgKCFzdG9yZV9wcmVwX2RhdGEoc2Vy
dmVyLCBoYW5kbGUsIG9mZnNldCwgbGVuZ3RoIC0gNCwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJigodWludDhfdCAqKSBwZHUpWzRdKSkgew0KPiAg
ICAgICAgICAgICAgICAgZWNvZGUgPSBCVF9BVFRfRVJST1JfSU5TVUZGSUNJRU5UX1JFU09VUkNF
UzsNCj4gICAgICAgICAgICAgICAgIGdvdG8gZXJyb3I7DQo+ICAgICAgICAgfQ0KPg0KPiAgICAg
ICAgIGJ0X2F0dF9zZW5kKHNlcnZlci0+YXR0LCBCVF9BVFRfT1BfUFJFUF9XUklURV9SU1AsIHBk
dSwgbGVuZ3RoLCBOVUxMLCAgICAgPC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gUmVzcG9uc2Ug
aXMgc2VudA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgTlVMTCwgTlVMTCk7DQo+ICAgICAgICAgcmV0dXJuOw0KPg0KPiBl
cnJvcjoNCj4gICAgICAgICBidF9hdHRfc2VuZF9lcnJvcl9yc3Aoc2VydmVyLT5hdHQsIG9wY29k
ZSwgaGFuZGxlLCBlY29kZSk7IH0NCj4NCj4NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gSW4g
Qmx1ZXogbWFzdGVyLCB0aGUgcmVzcG9uc2UgaXMgc2VudCBmcm9tIHByZXBfd3JpdGVfY29tcGxl
dGVfY2IgYnV0IHRoZSBjYWxsIGJhY2sgaXMgbmV2ZXIgY2FsbGVkIHNpbmNlIGdhdHRfZGJfYXR0
cmlidXRlX3dyaXRlIHJldHVybnMgVHJ1ZSBiZWZvcmUgZnVuYyBpcyBleGVjdXRlZCB3aGljaCBp
cyB0aGUgZnVuY3Rpb24gcG9pbnRlciB0byBwcmVwX3dyaXRlX2NvbXBsZXRlX2NiDQo+IHN0YXRp
YyB2b2lkIHByZXBfd3JpdGVfY29tcGxldGVfY2Ioc3RydWN0IGdhdHRfZGJfYXR0cmlidXRlICph
dHRyLCBpbnQgZXJyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqdXNlcl9kYXRhKQ0KPiB7DQo+ICAgICAgICAg
c3RydWN0IHByZXBfd3JpdGVfY29tcGxldGVfZGF0YSAqcHdjZCA9IHVzZXJfZGF0YTsNCj4gICAg
ICAgICB1aW50MTZfdCBoYW5kbGUgPSAwOw0KPiAgICAgICAgIHVpbnQxNl90IG9mZnNldDsNCj4N
Cj4gICAgICAgICBoYW5kbGUgPSBnZXRfbGUxNihwd2NkLT5wZHUpOw0KPg0KPiAgICAgICAgIGlm
IChlcnIpIHsNCj4gICAgICAgICAgICAgICAgIGJ0X2F0dF9jaGFuX3NlbmRfZXJyb3JfcnNwKHB3
Y2QtPmNoYW4sIEJUX0FUVF9PUF9QUkVQX1dSSVRFX1JFUSwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhhbmRsZSwgZXJy
KTsNCj4gICAgICAgICAgICAgICAgIGZyZWUocHdjZC0+cGR1KTsNCj4gICAgICAgICAgICAgICAg
IGZyZWUocHdjZCk7DQo+DQo+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+ICAgICAgICAgfQ0K
Pg0KPiAgICAgICAgIG9mZnNldCA9IGdldF9sZTE2KHB3Y2QtPnBkdSArIDIpOw0KPg0KPiAgICAg
ICAgIGlmICghc3RvcmVfcHJlcF9kYXRhKHB3Y2QtPnNlcnZlciwgaGFuZGxlLCBvZmZzZXQsIHB3
Y2QtPmxlbmd0aCAtIDQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICYoKHVpbnQ4X3QgKikgcHdjZC0+cGR1KVs0XSkpDQo+ICAgICAgICAgICAgICAg
ICBidF9hdHRfY2hhbl9zZW5kX2Vycm9yX3JzcChwd2NkLT5jaGFuLCBCVF9BVFRfT1BfUFJFUF9X
UklURV9SU1AsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBoYW5k
bGUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCVF9BVFRfRVJS
T1JfSU5TVUZGSUNJRU5UX1JFU09VUkNFUyk7DQo+DQo+ICAgICAgICAgYnRfYXR0X2NoYW5fc2Vu
ZF9yc3AocHdjZC0+Y2hhbiwgQlRfQVRUX09QX1BSRVBfV1JJVEVfUlNQLCBwd2NkLT5wZHUsICA8
LS0tLS0tLS0tLS0tLS0gUmVzcG9uc2UgaXMgc2VudA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHdjZC0+bGVuZ3RoKTsN
Cj4NCj4gICAgICAgICBmcmVlKHB3Y2QtPnBkdSk7DQo+ICAgICAgICAgZnJlZShwd2NkKTsNCj4g
fQ0KDQpJdCBtaWdodCBiZSBiZWNhdXNlIG9mOg0KDQpjb21taXQgMWViZmM2OGZmNTNlYTVlZDVj
YjQyNGRmMTUxYmY0MTNjN2ZmZTliZQ0KQXV0aG9yOiBHcnplZ29yeiBLb2xvZHppZWpjenlrIDxn
cnplZ29yei5rb2xvZHppZWpjenlrQGNvZGVjb3VwLnBsPg0KRGF0ZTogICBNb24gTWF5IDI4IDEw
OjIwOjUyIDIwMTggKzAyMDANCg0KICAgIHNoYXJlZC9nYXR0LXNlcnZlcjogUmVxdWVzdCBhdXRo
b3JpemF0aW9uIGZvciBwcmVwYXJlIHdyaXRlcw0KDQogICAgVGhpcyBwYXRjaCBhZGRzIGdhdHQt
c2VydmVyIHBvc3NpYmlsaXR5IHRvIHJlcXVlc3QgYXV0aG9yaXphdGlvbiBmcm9tDQogICAgYXBw
bGljYXRpb24gaWYgbmVlZGVkIGFuZCBwcmV2aW91c2x5IHdhc24ndCBhdXRob3JpemVkLiBBdXRo
b3JpemF0aW9uIGlzDQogICAgcmVxdWVzdGVkIGJ5IHNlbmRpbmcgbWVzc2FnZSB3aXRoIHNldCBw
cmVwYXJlIHdyaXRlIGF1dGhvcml6YXRpb24gcmVxZXN0DQogICAgdG8gY2xpZW50Lg0KDQpBbnl3
YXkgd2UgYXJlIHRhbGtpbmcgYWJvdXQgYW5jaWVudCBjaGFuZ2VzIGhlcmUsIHdoYXQgZXhhY3Rs
eSBpcyB0aGUNCmF0dHJpYnV0ZSB5b3UgYXJlIHRyeWluZyB0byB1c2UgdGhlIHNvIGNhbGxlZCBs
b25nIHdyaXRlIHByb2NlZHVyZQ0KYnR3PyBJcyB0aGF0IHVzaW5nIGJsdWV0b290aGN0bCB0byBy
ZWdpc3RlciBpdCBvciBpcyBzb21lIG90aGVyDQphcHBsaWNhdGlvbiBpbnZvbHZlZD8gT3IgaXMg
dGhpcyBzb21lIFBUUyB0ZXN0IGNhc2UgdGhhdCByZXF1aXJlcw0KYXV0aG9yaXphdGlvbj8gSWYg
eW91IHVzZSBibHVldG9vdGhjdGwgZm9yIHRoYXQgaXQgbWlnaHQgYmUgcHJvbXB0aW5nDQp0byBh
dXRob3JpemUgdGhlIHJlcXVlc3QuDQo=
