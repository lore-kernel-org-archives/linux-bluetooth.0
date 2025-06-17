Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013071.outbound.protection.outlook.com [40.107.159.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863A27380D;
	Tue, 17 Jun 2025 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750154278; cv=fail; b=YPVB5BAYn5GXoSLQUbiJtymlCQqQUdu4cOFyXEi8HONtIWYULog+Z9wam/4i6/ANLgiHLGIAtXonLQnk4QGANp6TJp4s4u++TH2R499ZBZRpashxNH7yiydHD7rGzTPQbG3w76U1hDQlAAAOVAUkT4T/15gNMWnzTsivYSpQy64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750154278; c=relaxed/simple;
	bh=1/shfsm76LF65O8HaI0npcnzcO4SLdWOHO2OzkhKk7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E2kNQ5tmWQtFkWDoYztokI5f4QQii7/NfB78AUzr4C057MeJ9EYgdYkkxC6wIo2+c4UAUtlx7KvgHAIy/FbScdI8Alg+8Q2QYhZTHnphr2Hd3QfaLa+63BIDniIxobZun+XF1L3L6vlozuipa677W113XLxZYkjVETIn4I5nmpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tx7tufhG; arc=fail smtp.client-ip=40.107.159.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tx7tufhG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Np1o/1Od89kLla7J5TpMNHvDoYuH4Pom1OV/7FBLhe4jPElJG2G+daJe3djjCn3hzkBp7zZZVR1G5lVOhr82IAARtu+rB/x5ZqfzoNIo0QxRu5F9HmYuG208U+X/jxG29ZTY7pZtnGxoUHwODLSFZXJp9mEPsWzqUg9fstD5hcPZVXLWnqr92M9HwFAASJJPvmmko/pLvz4ejb6TEoLyF6AnBLEwZCqZNqWYLppTF6q1JqC+EitxnDhuWU4aK2zNSSN9Ku6SVJJiBYaUzfSVb+eTUfY5rHsw/SoKLKPwJh/650vV+sp20lVaDVbfT8kbQ3h4OSLRnVw+WfDo2oRTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/shfsm76LF65O8HaI0npcnzcO4SLdWOHO2OzkhKk7M=;
 b=ucJvyCEh5SxgTYnABhC96g5f5/rR8VcjUiYY8vbR9+6kK1RzswyEPinQHCWr172eYAG7RmdDFF+N/a+vT0QcUmwNqBLmmrtz1CSIu2CMYAVT67VjjJ+1dTSo5PPpYe3omEFGqZKp/3O12eNZoW84MUIxhbuqxxWvO1wV6BWq+rqcvhz/nwWDRvuqDZxsAlNhi4ZXYow0TCrALawzad7hGnETklk7HDvoR1inZt1Am2vBVYPYGHLnwT4MzIxr4+q+phnePUmZV9aWlaOQZWwqYcroBdoJ4rbZvZbrzU/zQbXSTOh38BUuwTcVB8alukR4FYqZwgeXbMDrDRRB22HhDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/shfsm76LF65O8HaI0npcnzcO4SLdWOHO2OzkhKk7M=;
 b=Tx7tufhGXvRjYiURpUS0RdIUWpHb1OVJJh2zckTddeSlMnQkwSPCyDysBvMIN6JkWczeTGPDe+wbjwt/PW54H5gQKTFIGRnCxouzfHQnHwdZ40AQd94Ck/zc7nq05fNsieVvWdnVT8ZBTMzUjBKkL7T0dXgigeN23bSm5+ZZmImSb9s3SwOsl/hRnyMW9BV4vH685dgv/Rj/rTLEkU4c8QDPKwrEYGoPQerJU3LSKTaAxDJvdcP6PQWeNZKf6BohoD7mYg2mf9bsjvDwPts8CShh5JTcGgIoEq49nLTgBgAFxmjNgzeuY8IL/3nCPB850sVP20/Eg6sO30zM7vggug==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GVXPR04MB10451.eurprd04.prod.outlook.com (2603:10a6:150:1ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 09:57:50 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 09:57:50 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Sherry Sun <sherry.sun@nxp.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Manjeet Gupta <manjeet.gupta@nxp.com>
Subject: Re: [PATCH v1 2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
Thread-Topic: [PATCH v1 2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
Thread-Index: AQHb325JRuX35fgj+06avDMopdNmKA==
Date: Tue, 17 Jun 2025 09:57:50 +0000
Message-ID:
 <AS4PR04MB96927A0C132F5C9404AF2C8AE773A@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250616150919.8821-1-neeraj.sanjaykale@nxp.com>
 <20250616150919.8821-2-neeraj.sanjaykale@nxp.com>
 <DB9PR04MB8429D531C76CD31AF66864419273A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <6fe27c9d-4641-4aba-9e34-686a4d7f1fa8@kernel.org>
In-Reply-To: <6fe27c9d-4641-4aba-9e34-686a4d7f1fa8@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|GVXPR04MB10451:EE_
x-ms-office365-filtering-correlation-id: 48f234db-67c6-423a-c9d7-08ddad856bd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmZCSGV0dDB2L29tSmFBQWRNcTdVZXFkWmptYlg0Ni9iWWxGY1lBYis0UjBJ?=
 =?utf-8?B?dHZRNzZIZEtCMXBJSXR5cHBYMVN0QW4xZFVYeW5ialdvSGMvVytGSHRkUDhV?=
 =?utf-8?B?bFV6S3dFdDRZanpSV1hrY1RJaE9pVS8ybHd0b2tXTkVZc2JIWVVUeVFGZnQz?=
 =?utf-8?B?VGhOampqeFB2S2lWd0FMRTBkNkFtc3d0TUFsN3Joa2wxSGNnZzNsNXp5WEl6?=
 =?utf-8?B?c0RFVk85SlZsd2w0UnVQSk01bUt6cVU2S1JVUnQwKzZTRTVJeGxiM0E1Y28z?=
 =?utf-8?B?cXhuRHlLdEIrblo0bnJQczdaK3VvUGlVWUJEell0Y2pUYnluMXlYSmZ6eGxP?=
 =?utf-8?B?RytTNjVhcmVJalZlRFpqRGE1OWQ5ZFg4czI0RFdCVlpzc0hnY2dhVmdNMDFk?=
 =?utf-8?B?UE8xNDRUOExkNEZHQkUzN09HZ1lIK2MzSlNDcUhnamJTZHlDSHZOWmdMZTJs?=
 =?utf-8?B?Zjk1bnpmTXF4Wm81U1ROMUQ2enArZ2JzTEx5cmNyNmt1a0Zud1NVcmIwaTNa?=
 =?utf-8?B?Nk1zZmtaaE85WHErQVpza3pEKzhLVG4vK0RqRUdqQUdWNjhPbDVUS3JLejc3?=
 =?utf-8?B?RGMxcndDbnJ1N2d0d3huMXIxVFdPOExDSWN4aU45QzJ3ZWEyYnR3WkVNRUQx?=
 =?utf-8?B?VUpycWpMUFppV1p6anRhZTArWjgxWDlqc3c0c3EzTWlkUXdVU1hmN25kVXIv?=
 =?utf-8?B?Q1BkbGdRMGRtTjZJM0M3NUh0azdDaytZb0FTTlptUlR1OHU1cHNValJnUEc0?=
 =?utf-8?B?L2EyMWp6ektyYVBWcCtBSFpKdFVwemJxZDJCZFVvN1VxbVdXYndINjhHaTBn?=
 =?utf-8?B?NTRUKzRXV3AwZGFJVE8rRFRZU0pxK3BKM1FSdzFKK09QeHR1bndVSU44cjJ2?=
 =?utf-8?B?RFp0cGVwV0RxSnNwckFTRnhaZHdJeHhoeC9KVU5QaGppcDRjZE1oSHJsbStx?=
 =?utf-8?B?a2NTdDlTYkx3dG5sV08rMmZDOVhXRGxQUGttTmdNczhZd2JvcUhSbkhiTnVI?=
 =?utf-8?B?OWU0dzBnaHZ3OTB4aTJjenRRemk4OGtTc09kdDhSSjJMZ3dvMTFxc3NZZkZ2?=
 =?utf-8?B?M2p6YURrTGFuNWNWZXIwRzBZRDEwZXRWSEZRWEdBaUplbkJMM3NLMGRaR0VN?=
 =?utf-8?B?N25tc3hZYW5BSWpKWm1jS1ZEU0JDeS9STmZ4ZlgzcUcxTzB0bUlmbDZHSHN6?=
 =?utf-8?B?Wm8xaC93eTBuclJBcWFNcFlHYzljSjl1MVN4MWFkNEgvNXhyaitMUWFUTHdB?=
 =?utf-8?B?QmFwSjRTMWZGNDlzMGZjakNDWXI0dzEyWGZrd2tFZ1Z1TE80M1pEZ1laMG9r?=
 =?utf-8?B?TDlJVVByQmg3cEpjM0hDVHNWVXhqOVlnbm9mV2JETkpmc3F2WXI4R3ZOclF2?=
 =?utf-8?B?bTEyS0w4VVlwODh3Ky9OakhNMEsxWjZNdlpIajlYUTlBT3l0VmExa29DN09a?=
 =?utf-8?B?ZzhDeFppTm8rL2pKbWg5Y2dVK25mMVA4WmYrblNRdmZiZ3F5QUdvanZxaWdF?=
 =?utf-8?B?RmlpbEpKRCtqdzY1T25UbVZkYW15T21aUmNyTkJBbmJFblh5VnhQaFl0ZlR5?=
 =?utf-8?B?K2RMMFVWYS9Eclcvc01mYUF1ZzhPQ0Iza21raFRTaHRKQ1dNVmNqSUJmbTdr?=
 =?utf-8?B?TzVBMVlwRnpGUmQ0RHUyNGZVMWRHNDZqVldWK2Jzc0lnMzR4SnFreDdVamh6?=
 =?utf-8?B?L1FjZjV5N3pvWWRJZGFSYXJBdTVFc3BBRTNsVk1FV0czMW1aRm5EaDJZL2w3?=
 =?utf-8?B?a09VZWtUYTI4ekNGaHNEOWpDUUVxeldwYkVpMEpvSFZiNlA1YlFYNWtUUTJa?=
 =?utf-8?B?YzVIRzFqTHUvejFmQjRZQ25qelBmR2I1QlZzRzBod0hGeW1YQktDUWlkbjNK?=
 =?utf-8?B?S2NQVklDenlDS1g5OTFsSU56MXg5SnRGTCsydmpQNWVuSUhKR1pnRi85YlU0?=
 =?utf-8?B?ejk4NG1yRmc3QzJHcERieDVnak9RVW1oVWN0UFZhcjF5YUcweno2c2VUbW5l?=
 =?utf-8?B?dEVwOEtIS2xRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHR5aFpOWFVjbDU2R1QwVlpmeWJwd2VyTXpTUUpKWE5MVDh1Y1ZkeTl3cEVS?=
 =?utf-8?B?VGRvQS80OWhjY0E4QlhjSm5qWDNOeHlRVzZQSmI0RGhnLyt1eTZYY05PUWNP?=
 =?utf-8?B?L255NTBvam15emtXQ3QvbUxFakhsdXR1QVBuT3lIVFloZ1dsTHFxOTZpQWpm?=
 =?utf-8?B?enJxTm5veWxnaU5vTmx2enBDOGRnM1BDTTRhWUkreEJzdTJCK2IyVGlIeTJC?=
 =?utf-8?B?UnZBdUZiNnB5VUJrSTlHUzZ5RjZoVlRpekJJVnA5ZU5KTk5mZXhUVUxoeVZ1?=
 =?utf-8?B?UU1ONTVKbzBOaVRzV21IYWFVRkNIVi9IR0c4Q3FYOFh6cnhjeTIvakF4UFFn?=
 =?utf-8?B?anVLVlE4L2k3ZXd6ajFKb0dQelJ0cmVEN1diZHI5VkNLcVIrSDMrYXpEQURy?=
 =?utf-8?B?VWRxY2YyMUlZc2V5UCtkV2tqNmVhdE5RTE1ETlM4TkJCSXVUazIzL0p3aUxt?=
 =?utf-8?B?eVFIN01kd09yekxnMUNKa01hbVNKZFoxdFZNRExCNWF2UmtocEVXa0p5eEsy?=
 =?utf-8?B?cS9aM0IzU0FJb2hGMEJWYXJKMkVaaDJLL2s0L0pUR2NSaTZ6cGdEcHVyRzZN?=
 =?utf-8?B?b3N3b3FOQ3VLQVd5Z2hKSGtGMVVSV1MraHEvSzZEL3ptQ0cxYWN6eWplbHo5?=
 =?utf-8?B?a2p3bmdoWnhDK3F2dDZLdUN5cFVScWFoQWNxZ0NQbXdvMTBBaEhmcTVNaW0y?=
 =?utf-8?B?TXBqRjZZOVBzS204RHZpc2tpS3dpSDdtQVVJamh0aUROZ1h0ajg0MkJGY0cw?=
 =?utf-8?B?N2YwOHczNlJLQkJsK1Jkd0RGem81SG91M1NManNLWm9VNUNKM0hDSm9sdE1X?=
 =?utf-8?B?TFdURHVQMi9pTTFmUWdaNksvc3JTTERXRHR2R0NBbHo0a3JBM3dqbWJhMysw?=
 =?utf-8?B?TXo1VDJlZkNqZ2RtTkFKUDAyc3VZSzZlaXpyZ2M0WEp5TkI0U1lwY0VVM2dD?=
 =?utf-8?B?S3hvaUg0d0tnSUxUcHNRSXNBTWhRZXBVQ29KQ3EwQ0dWSWJKTlZXbGE4eVls?=
 =?utf-8?B?Q2FhWVNnUkFjd3BFckY5MHBXRmViajBBQS9yVFNPVitwR0NlSHl0MEhNaEMz?=
 =?utf-8?B?dTVjSkVseFlzUTIvaHJ6WG5rN0NPbmx6aHFMeVVvTFZZdHV5Y3NqNXFQRGhz?=
 =?utf-8?B?MERleFFFSlM5dlFZeXg0RWQzNTVoZHU4K0ZPU1pvTGZHTUdiM3graGhEclBn?=
 =?utf-8?B?anFxUWJwYU4xSTFLbXJKV3VHTEdaZ0c5c0R5WFZDaW0zOXZ4NUdMN3BrYTNH?=
 =?utf-8?B?Z0M3N2FBMC9GZm1yNS9NZFF5eFBWVlUvKzhOZmx5NUl2dHBoQllXYm4yR25q?=
 =?utf-8?B?QXpKRDF1MlQ1QlJvWG5vTGVvQUJFR3VEak5vK1ZBNGFQZzdtZ0pjT3NYelpD?=
 =?utf-8?B?OS94bDhWWWtiZjE1MDB0N29ScE04eHl3OFZzRzR1Y1lYOVF5TVF4RUdnWTFu?=
 =?utf-8?B?M1dDcUpKWFM5Q09DU2RtNSsxMmtyMFZXRXd3SExZYWJBamhYMlhlcmYzRFVN?=
 =?utf-8?B?SUVXd2lwTXZUZE9xdThHdnkvU2dTYkpBaHlMckU4c29SSEh1UmFGa3MrVUh1?=
 =?utf-8?B?RFdYQktZN0o1U0p2SCtWMTlDNXhETkMyQWhPRUsvMFpsUVlTVFlyOWlaeUI5?=
 =?utf-8?B?NXgvT24vYU5Vbk9zZ2dKTHNsdVRreHBoblVrbmppLzhZTGp2ZW43NjExamZD?=
 =?utf-8?B?R0VtOEZYN1UvZ1NKWS9DTWNZdjI5cStqcHY5N1lXR3FiaE1NUXdJUXhLWTg1?=
 =?utf-8?B?USsvdjZHa0VpRmR0WG9BNW5NakZ3ck45c2V5Q3lHTVNqV0wvTmxkc2szNlVM?=
 =?utf-8?B?SG50MGtqdUd0YVdKTmVxTHhHQU8rNEFKUTBFYThxQ05VdzRleThZbkg1UHhK?=
 =?utf-8?B?ais4ZzllQW5qc1NyTDBHek16ZG5BakhPYjhnVGNkUDBwdU1jdkE4S3Z3VEtV?=
 =?utf-8?B?bjA2TUh4cURnRk13dDR2bzhaSnloR1hkd0NEQVBvRFZOOEVLclhyRXhqS3FB?=
 =?utf-8?B?VHVaY002bCtjNVpmdGJUNE00bDBGenJhWVp5TWFmdSswSTV3WDROak1id0Rt?=
 =?utf-8?B?NTBUNGtadFVsbitLYTdRQVVWdVY1bEJCZHhNaUlCVlFVV3EyL1JTV2NzUkx4?=
 =?utf-8?Q?C8txzxxqgbD8zZ5jn1AZ6LVEt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f234db-67c6-423a-c9d7-08ddad856bd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 09:57:50.7569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95X8SGmCyqGY4pSXHD8yUi8bJpW0K8pbW8W19FaNC0joUf0W5R8wRunPzTWgl4A+NIc67LD4R5iJsA7TmwQzLFAETqgeJV0VIBTN2KCXpso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10451

SGkgU2hlcnJ5LCBLcnp5c3p0b2YsDQoNClRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nIHRoZSBwYXRj
aC4NCg0KSSBkaWQgbm90IGFkZCA0TSBiYXVkcmF0ZSBzdXBwb3J0IGluIG54cF9yZWN2X2Z3X3Jl
cV92MSgpIGFzIFYxIGJvb3Rsb2FkZXIgYXJlIExlZ2FjeSBjaGlwc2V0cywgYW5kIDRNIGJhdWRy
YXRlIHdhcyBuZXZlciB0ZXN0ZWQgb3IgdXNlZCBieSBhbnkgY3VzdG9tZXIgc28gZmFyLiBUaGlz
IGZlYXR1cmUgaXMgbW9yZSBhY3RpdmVseSB1c2VkIHdpdGggbmV3ZXIgVjMgYm9vdGxvYWRlcnMu
IEJ1dCBpbiBteSB0ZXN0aW5nIHc4OTg3ICh2MSBib290bG9hZGVyKSBvbiBpTVg4TSBtaW5pIHdv
cmtzIGZpbmUgYXQgNE0gYmF1ZHJhdGUuIEkgY2FuIGFkZCBpdCBoZXJlLg0KDQo+IE9uIDE3LzA2
LzIwMjUgMDQ6NTMsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4+IEBAIC05OTIsNyArOTk3LDcgQEAg
c3RhdGljIGludCBueHBfcmVjdl9md19yZXFfdjEoc3RydWN0IGhjaV9kZXYNCj4gPj4gKmhkZXYs
IHN0cnVjdCBza19idWZmICpza2IpDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgIG54cGRldi0+
aGVscGVyX2Rvd25sb2FkZWQgPSB0cnVlOw0KPiA+PiAgICAgICAgICAgICAgICAgICAgICBzZXJk
ZXZfZGV2aWNlX3dhaXRfdW50aWxfc2VudChueHBkZXYtPnNlcmRldiwgMCk7DQo+ID4+ICAgICAg
ICAgICAgICAgICAgICAgIHNlcmRldl9kZXZpY2Vfc2V0X2JhdWRyYXRlKG54cGRldi0+c2VyZGV2
LA0KPiA+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBI
Q0lfTlhQX1NFQ19CQVVEUkFURSk7DQo+ID4+ICsNCj4gPj4gSENJX05YUF9TRUNfQkFVRFJBVEVf
M00pOw0KPiA+DQo+ID4gSGkgTmVlcmFqLA0KPiA+DQo+ID4gRG9lcyB0aGlzIG1lYW4gdGhhdCBz
b21lIGxlZ2FjeSBCVCBjaGlwcyB1c2luZyBueHBfcmVjdl9md19yZXFfdjEoKSBkb24ndA0KPiBz
dXBwb3J0IDRNYnBzPw0KPiA+IElmIHNvLCBwbGVhc2UgYWRkIGNvbW1lbnRzIGluIHRoZSBjb21t
aXQgbWVzc2FnZS4NCj4gDQo+IElmIHRoYXQncyB0cnVlIHRoaXMgaXMgaW1wbGllZCBieSBjb21w
YXRpYmxlIGFuZCBlbnRpcmUgcHJvcGVydHkgc2hvdWxkIGJlDQo+IGRyb3BwZWQuDQogDQpBcyBm
b3IgdGhlIGNvZGUgc25pcHBldCBhYm92ZSwgaXQgY29tZXMgaW50byBwaWN0dXJlIGZvciB3ODk5
Nywgd2hpY2ggbmVlZHMgYSBoZWxwZXIuYmluIGZpbGUgdG8gYmUgZG93bmxvYWRlZCBiZWZvcmUg
dGhlIGFjdHVhbCBGVyBmaWxlLg0KVGhlIGhlbHBlci5iaW4gc2V0cyB0aGUgY2hpcCdzIGJhdWRy
YXRlIHRvIDNNIG9ubHksIGhlbmNlIEkgaGF2ZSBrZXB0IEhDSV9OWFBfU0VDX0JBVURSQVRFXzNN
Lg0KDQpUaGFua3MsDQpOZWVyYWoNCg==
