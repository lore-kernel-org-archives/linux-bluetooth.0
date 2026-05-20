Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726B133F5A8
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262734; cv=fail; b=dGEOCFD8qniuz2gdhun25U22RHqMvHmUMvlB26R53gCxLkbz6bdkQ+G1yGJ/4/R6wYYkTmzQOyvaxkn3UvGCCjU9fdLRyt0cDNuZ7NoznisoQiHcHC3S1dlIqBxQL511CXVZS7gPcx2fhSTbEqnoUnJ5uiZNWOkMjhxEuamdtrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262734; c=relaxed/simple;
	bh=ZzPmmRAwDmpFE2ezmikzrpod3ZXgSdKHsyxwc7c+wzc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DiV4e8YzIbd3dYEBGgNXFOl0Ru1kpP8GlKGSOe+2edGtrPdupVv7LaXLk4m3WbtFKCQmkvmFE22TEGtFeqHe5Sitzep+dXgqeYVFlfMAIfwdmC0nrP2RrDRTUFdY/amG5RUdPrLXbMtzU/AEtfB2ZZGhTnvcewJP/E52oqMvngs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bZymB7lR; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=e+RTfi9l; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bZymB7lR";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="e+RTfi9l"
X-UUID: efed78b2541e11f1a3561939bc42ff46-20260520
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZzPmmRAwDmpFE2ezmikzrpod3ZXgSdKHsyxwc7c+wzc=;
	b=bZymB7lRBxYDnnn8vCeiUSk6q7aMeWjMl8G/pvLnZZYxdP4cS1poH0kqnmSzlS2n+SD0qaNtyxIFnsWMr7KWwkzMxqPtitsNaPDj4VFgHtlDVp1HK3gPzH4ZDzfTOC7arYYtYU6TVT8YFWJbgEMinsj5sKIb45YVAXobDn/XP1o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14,REQID:12fa237d-074b-4a51-a635-484e0caffbf4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:9091e75,CLOUDID:b636051f-023f-4f87-9e9c-6c116c694fb3,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|52,EDM:-3,IP:nil,URL:1,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: efed78b2541e11f1a3561939bc42ff46-20260520
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1360120161; Wed, 20 May 2026 15:38:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 20 May 2026 15:38:46 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 20 May 2026 15:38:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOYctO4ed7J2+R0i9A9mokWrWd+h6715sTyx32KwkJ24GtybajsgZGuFlmN2uEaXuCQ+RREFbaxkc1hiMk7RD24OvZMa+thKcfnhSypwrR0mkt7Lp8wZK4+C3Lk2oL70PRIZcYGPbA3+cqThg2tnGOxVtWXHapjS4ztPHsvIQxFx0AZHW3+JLF1W43ZT0OdLjmUwkhhrYCQ0usJaXTiDXPgp4cOFKwHjMlKFvXaeTna6oZiB+hGaPoOpwH8QeiJX0BFnT5uqBZH438PH1hAXJIr9muMvNsKIdvNewMcumr/DOO5YjGYYcLWAPc9qUyQZk3azPc0rMLlJhQoZLHVrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzPmmRAwDmpFE2ezmikzrpod3ZXgSdKHsyxwc7c+wzc=;
 b=kvtn6y6Bxt4eQvgclMCl+ZeGPLNCh+3LvCAK4p9mBtDIqCtzTUfG66z4Lowxp3wXB6j4ALf8vFOxDx9b66738oVlMi5D14BA1sFrIKj239OfWwGUYjNKt8gnTFGP0ygD4CfEoz8UqDydK33zGd/P+bLPSp+X459fgBjOjRPS7XI+hozHcHv9mkdH2JM1kZ8Ao/fcyYEitrKRmJX8JLEGPwPUxg4PF1DeRvZXnIEfXAHmnZvdYFk+SZJgXc45c33B2e2qIwkWXCu2lEh9wjilLSPRZj4MlICsdkjkCd0WgT0tSTCG832iL6TVMKV+aKhQTcaGwDMGBv7QYWoejOuOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzPmmRAwDmpFE2ezmikzrpod3ZXgSdKHsyxwc7c+wzc=;
 b=e+RTfi9l9z0b2EQupQfGBzSAr966gOiNxzs3Ka40HLHD4iOB2ozKnNFU00CQcD9pK72zVAqXqP4KwOYv+m+fBpRFZ6okVBNyu2Cg+MRxV0SjlCQ8F1v1cvwqLJV6Nuf9I5rY2n+0m2E4HALprKp8idlG7a6lmVtOwrotUEyWlYM=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by TYZPR03MB6598.apcprd03.prod.outlook.com (2603:1096:400:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.15; Wed, 20 May
 2026 07:38:42 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 07:38:42 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "yjg0107@163.com"
	<yjg0107@163.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: =?utf-8?B?UmU6IOi9rOWPkTog5Zue5aSNOiBBYm91dCBLZXJuZWwgbGltaXRhdGlvbiBI?=
 =?utf-8?B?Q0lfTUFYX0ZSQU1FX1NJWkUgKDEwMjQgKyA0KQ==?=
Thread-Topic: =?utf-8?B?6L2s5Y+ROiDlm57lpI06IEFib3V0IEtlcm5lbCBsaW1pdGF0aW9uIEhDSV9N?=
 =?utf-8?B?QVhfRlJBTUVfU0laRSAoMTAyNCArIDQp?=
Thread-Index: AQHc6CbXmXLTwZGRd0i74vxxwfzT3bYWhw4A
Date: Wed, 20 May 2026 07:38:42 +0000
Message-ID: <368e8bb2c34ae1d770baa7a87cc2dc900046de02.camel@mediatek.com>
References: <lot3ns12vglamg8c0b87iaoe.1777272055182@email.vivo.com>
	 <lot3ns12vglamg8c0b87iaoe.1777272055182@email.vivo.com>
	 <h8u6o3dq4p0sir056l06sja8.1779260604813@email.vivo.com>
In-Reply-To: <h8u6o3dq4p0sir056l06sja8.1779260604813@email.vivo.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|TYZPR03MB6598:EE_
x-ms-office365-filtering-correlation-id: a415ff59-7126-494c-0b42-08deb642d14e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|11063799006|3023799007|4143699003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 8YEcBGYjJT6gn3zCEngKF0yJpMVhqNEWcSYP5ffRsdM7KRRAUqtmX7z1CLLmcqRImGlTSYhsfw2SFQC9Jtgrfb81cV9RKXP2j0ynn/P6PrSjp8PxXXg+V/rAInQw2x5sX2PAPQN1atp9gFF0cDxT2H6FvRL0Ojdja6l431ceTRfT/VrEe9GxSOj+jHJTXwm8zLuI3AUWcJU5+4Sxc+2zZrjWMXx3zcaJX+JQngCutZNZ/tRqwFeSIyHB1wFgUQ2W4vUcxVIeZOSuySf8bayWU8UKWse49IrDZColz2fRXdLePv1tbA27mJnw7uM9QXYnLnSIUKoiY+HzgJ3QloXKI/mx4leRgd1l312yCOrsZoJHc4tmaSxr/a7hKC1S14ZSqQmSWFU82WZvtLADd8bPIbfTmpcQM256PNtAvZtHEmWxFqpLUmIuN0IBDxES8kdN5mvTfOW6bjknkHrw0guWELyDC2dZShD7EnxyFuTM/LnG6BzJwPPWRIo0+GuI6JLKyfdV5hdz0HiL99qqLgCjvYhuNdhASSuIE6NmpKpIK5GoDfLXhxdBzRapjFR2tvZrDo1Mv444h20l1ftlVnlj9lhsUPlbADCn2Ar1PNbn1dA3HWpCjgiIxDMsm/TwXxJtYpFm6mFx1hMt4TPLcjKqr6tVnxhKSD92gsde0RaE6NRkQf71xu7MPahrSuM0cb7DlqqFMdp6ObZElB8Wmx3d8MYTGrJvJQjp6r/aaq5iZJB95faOaeYL3h8kRWyQhGNl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(11063799006)(3023799007)(4143699003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlNmWkJHSEMxcXpENjZNeUVkSDR6T09ua3oxOWlCTFRtdnQxL241eENzUlFX?=
 =?utf-8?B?bWxiRmJGcGx5RzZyc2hmTDRLTWl3OXdpK1NwaEdWSkxOQ1pEWWxOYzlKVWht?=
 =?utf-8?B?TkpRR0JjNmxoeDN2R2FvMENSR21XMW9ZTEZxdnUyYmlDSDN4NkRTalAzOWov?=
 =?utf-8?B?WFRQdzNjVzhacnBDMUFDY2V6RXNUeHE3YXcxSmVFUCtXeUI2Zi9KdE1UUVIv?=
 =?utf-8?B?SnZpcHpaa2ozSnZ5aU16T0lwNEErSTRFOTVQRXhSVkEwWHZCeWYvVTdZY0dn?=
 =?utf-8?B?MDdWei9QM3hGRElldEx3dFZjZ0h5bmdHUkxUVWNlL2UvQTVyQ21MdEJLYkx0?=
 =?utf-8?B?ZFFMdmFFUG42TXFVRDVwK21ualRHSzhKUUY2dC8ybjkrbGI4dE5vc2l4VkRZ?=
 =?utf-8?B?enN0WEh3SlBvV2RmZ1I2aURrdDErME5ucy9ISU1HRWwrSVpmWUZHZjBDM1hB?=
 =?utf-8?B?K0hkd1VNQUVDNjZvdGxDL2d0Mlh6eVVhSEtkeWc3enVNcGV1SVovamZ4NndL?=
 =?utf-8?B?N01sTldWNGNyQzRqM1lDYUxZenA2eGp0TytqVHYzb1ZWU1dFMVhqK21Lakhu?=
 =?utf-8?B?Y0JyNGR2M3FFSW04dGJFczkvN0k1WFVrYm1WbzdNS2o1MHBXUm83ME9odnpX?=
 =?utf-8?B?L1ZsZS9Wd3VqeWVXM0d1OU4vUndqNFdXMGdPQlROaVJocEpURDlaQ1FHcHNu?=
 =?utf-8?B?QWhyZVN5RnpNWEp6SE9pUU1CZENmWVRiWm5nbjlkVnJFSUN6ZnY1aVhvcXMz?=
 =?utf-8?B?b3dlNk14dU1OcVBzN3FtVVBUVWlxamVzUXhyMFVpVzJTeWRBR2c0NFRZVi96?=
 =?utf-8?B?Smxlei9EdDgvbzN6SWcrWXhFZlhlL1Y4cVlvZm1HNmtLSnhIcGcxNGlwcmRz?=
 =?utf-8?B?ZEZzVUdMQ0E5L3gvTlV1b3Z5cnpoUE0xRitQenpvRm9HTTlqZitleTRJaTli?=
 =?utf-8?B?bmR2REM5c2N3OEFCOTh3akd3eEJ5V2VhUGRiV1lUZ2Y5VEwwZndGN0hmSkho?=
 =?utf-8?B?ZXlkRkJwQTU5YVdSSll2ZGRBNnhDSXRxQ2psVmpiNlBxZHFCQ0FMNVhWbkw2?=
 =?utf-8?B?Tlk1UUcvbzhNdGZ1cGlmWER0VnNKZTVkYjZGWjBYaHUxQVNOdGRWdWRRQVl4?=
 =?utf-8?B?bnlLNFhYSjFNOC9MT2d0TWpmQitabHJYOEdmSXFKL2RPT3gxeEtaTk02M0Q0?=
 =?utf-8?B?ZmJPQkhLRXJxV3JnbUZSZ0k4dTJWNFA0cURvVWd4ZmZySFk2cXIyMUxuTVVh?=
 =?utf-8?B?U2hwUXVXRTlPci9LRDBpNVVSU3VLTmo4VnA2eVAvTjlsNnJmck9weWdrZHln?=
 =?utf-8?B?SkVJTC9EdDJza3R0VG4zSGJKa1RkRlJBLzRNTEJKSDVEVzltWTJIbklILzZH?=
 =?utf-8?B?amMxdWpldUEzd3pnZUJrV3VaNEZoTUk0S2V5REJhTnlqUXhLclk3aDZhYit4?=
 =?utf-8?B?VDNLaXR6R0h3WklwUDhCRlJYSWdjWDRKZkN0a09odU9zSVNnU2o5K0V2dlB1?=
 =?utf-8?B?MEpJbjlEbjBEVVR0ZVp3SnFrbnczZE9JcEJQTUFXQ2NqbGtmaWxoZkJBRVVB?=
 =?utf-8?B?Y3VmWXNkYU5VWUF6NHlXZVhoUmNHbGhPSmQ3aW5UWkJJRzFObzBQOWJibzR3?=
 =?utf-8?B?eHBjWjdqMDNjSXNNVWFtU2tBLyt0ZVlLd3Jyb2dSQlh6ZGFxakh4SEZvaVBG?=
 =?utf-8?B?TGZYOWI0WmozZ2ZJWVJ0VmJHSXlsditnZTFpS2FOU0ZjTU9paHgxVXpTTTEx?=
 =?utf-8?B?RVdmWkxtbW8wam1GNUtNcVoxemltZTg0cnB0ZTNJRUhwOXhxMjRVcjlVb0l5?=
 =?utf-8?B?bk1LZ0E5S2h5WVZnL0I0Tm01VHRXMjgvekdCUFN0bzVyU25zZ0dQaU11ZnQz?=
 =?utf-8?B?cG5Qa2JlWnVZeDhhTVlvSlVYOFVEdStPWG8yNXM0UVgwTFYyb1huYkFpMngw?=
 =?utf-8?B?ZjVTa2c0NjROTm5XdGU4M3pDOEdwcnRXOVJhUExIWDBJTEJvdmlvQld6dFF1?=
 =?utf-8?B?NyttS21iV0FleUNuU1dNNElrNng4blhZWWF4NjEyYjJqd2ltQ1RpSjQzUFlk?=
 =?utf-8?B?RWx2RXZycEREdWVQa0w1dE5kNTdWVVM0RWEvMlJHajZPendqTUlZc25aeUQz?=
 =?utf-8?B?MExCM0NQZjQyM1ZWaU5IakFIak52OERqNEdCOGdNTEViUVZMRDVMSWRzVXln?=
 =?utf-8?B?bldjeXdwMjVSSCtQeDg2NHJpV1dOYkh0WjVGaDh0YWJLQW5kL09QSllNZ3Zz?=
 =?utf-8?B?OWFCTHNEOG9nVWpMbUQ5R2dHc09nUkF3RGdVSkY4TGRSNXpHdlNkZHdDUkdp?=
 =?utf-8?B?ZFQ5QkdPRFg5RFpCdXQ4SEZoZk1MRDYvRkpKMmIzdThscjFpS1ExUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF06F6B1FC984E4CABBAAA79677717B8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BTHFTmn+elN7spLjQDtowRs9ZgolUoW2yPr5sdXLCP6m+iMT57Yl1WPXEurZvIbU9PlwusZSIvsfckT5oxQXzPwqCTjIZ0abQo7C2dgh/SBmooFyZqGYQ4UVD9ELcieOTRCdFm/OwHzuGHcvVCK4h68f1qAjxZ97Sm9TROKw1y2vBpqREorsOZuYHuVtiW2O/+3I7o6G/gKlK0AkeLjKJaEeKGSIN2Pwg4GFC77QWJhsKc3EngeMqSbkGzgyTQxZK4uXXvsqh1V6dfaTW0TIBCJPhbE0+7OV0BPOWbuFNDe6wjJvrgDvhKguNbnX4JBM5dFkFZxl+yOB2POAT1WGRg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a415ff59-7126-494c-0b42-08deb642d14e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 07:38:42.8024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZb9Ev3zBqw8pAosw/BdsG9/IhC6Qyru/LIdV+6R2Cs1jv6chMfojleqUq8qwzeqaq52i6LwID12eGK2DZMPEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6598

T24gV2VkLCAyMDI2LTA1LTIwIGF0IDE1OjAzICswODAwLCB5amcwMTA3IHdyb3RlOg0KDQpIaSBM
dWl6LA0KDQpJIHJlY2VpdmVkIGEgcXVlc3Rpb24gYWJvdXQgdGhlIHJlc3RyaWN0aW9ucyBvZiBI
Q0lfQ0hBTk5FTF9VU0VSIGFuZA0KSENJX01BWF9GUkFNRV9TSVpFLiBTaW5jZSB0aGlzIGludm9s
dmVzIGNoYW5nZXMgcmVsYXRlZCB0byBLZXJuZWwgSENJDQpsYXllciwgd2hhdCdzIHlvdXIgdmll
dyBvbiByZWxheGluZyBIQ0lfTUFYX0ZSQU1FX1NJWkUgbGltaXQ/DQoNCkkgc2F3IHRoYXQgdGhl
cmUgd2FzIHNvbWUgZGlzY3Vzc2lvbiBhYm91dCB0aGlzIG9uIGJsdWV6IGdpdGh1YiwgYnV0IGl0
DQpzZWVtcyB0aGVyZSBoYXNuJ3QgYmVlbiBhbnkgYWN0aXZpdHkgZm9yIGEgd2hpbGUuIFdvdWxk
IHlvdSBzdWdnZXN0DQp0aGV5IGRpcmVjdGx5IHVwbG9hZCBhIHBhdGNoIHRoZXkgd2FudCBhbmQg
Y29udGludWUgdGhlIGRpc2N1c3Npb24gd2l0aA0KeW91Pw0KDQo+IA0KPiAtLS0tLS0tLS0tIOi9
rOWPkeeahOmCruS7tiAtLS0tLS0tLS0tDQo+IOWPkeS7tuS6uu+8mnlqZzAxMDcgPHlqZzAxMDdA
MTYzLmNvbT4NCj4g5pel5pyf77yaMjAyNuW5tDXmnIg35pelIDE3OjU1DQo+IOS4u+mimO+8muWb
nuWkjTogQWJvdXQgS2VybmVsIGxpbWl0YXRpb24gSENJX01BWF9GUkFNRV9TSVpFICgxMDI0ICsg
NCkNCj4g5pS25Lu25Lq677yaImx1aXouZGVudHoiIDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4g
5oqE6YCB77yabGludXgtYmx1ZXRvb3RoIDxsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3Jn
Pg0KPiANCj4gDQo+IA0KPiANCj4gDQo+IA0KPiANCj4gDQo+IEhpIFZ1ZGVudHosDQo+IA0KPiBJ
biB0aGUgZnV0dXJlLCBCVCBTSUcgd2lsbCBpbnRyb2R1Y2UgdGhlIEhpZ2ggRGF0YSBUaHJvdWdo
cHV0IChIRFQpLA0KPiB3aGljaCBtYXkgcmVxdWlyZSB0cmFuc21pdCBsYXJnZXIgZGF0YSBzaXpl
LCBub3QganVzdCAxMDI0Lg0KPiBTbyB3aGF0J3MgeW91ciBvcGluaW9ucz8gQ291bGQga2VybmVs
IHJlbW92ZSB0aGUgbGltaXRhdGlvbiB0aGF0DQo+IEhDSV9DSEFOTkVMX1VTRVIgY2FuIG5vdCBj
aGFuZ2UgTVRVPw0KPiBMb29raW5nIGZvcndhcmQgdG8geW91ciByZXBseSwgdGhhbmsgeW91IHZl
cnkgbXVjaC4NCj4gDQo+IEIuUi4NCj4gSmlnb25nIFlpbijmrrflkInlip8pDQo+IC0tLS0tLS0t
LS0g5Zue5aSN55qE5Y6f6YKu5Lu2IC0tLS0tLS0tLS0NCj4g5Y+R5Lu25Lq677yaeWpnMDEwNyA8
eWpnMDEwN0AxNjMuY29tPg0KPiDml6XmnJ/vvJoyMDI25bm0NOaciDI35pelIDE0OjQwDQo+IOS4
u+mimO+8mkFib3V0IEtlcm5lbCBsaW1pdGF0aW9uIEhDSV9NQVhfRlJBTUVfU0laRSAoMTAyNCAr
IDQpDQo+IOaUtuS7tuS6uu+8miJsdWl6LmRlbnR6IiA8bHVpei5kZW50ekBnbWFpbC5jb20+DQo+
IOaKhOmAge+8mmxpbnV4LWJsdWV0b290aCA8bGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9y
Zz4NCj4gDQo+IA0KPiANCj4gDQo+IA0KPiANCj4gDQo+IA0KPiBIaSBMdWl6LA0KPiANCj4gUXVl
c3Rpb24gaXMgc2FtZSBhcyBodHRwczovL2dpdGh1Yi5jb20vYmx1ZXovYmx1ZXovaXNzdWVzLzIw
NzMuDQo+IEFib3V0IEtlcm5lbCBsaW1pdGF0aW9uIEhDSV9NQVhfRlJBTUVfU0laRSAoMTAyNCAr
IDQpLCB5b3Ugc2FpZCB0aGF0DQo+IHRoaXMgd2lsbCBiZSBmaXhlZCB0byBlbmFibGUgdXNlciBz
cGFjZSBjaGFuZ2VkLCBmcm9tICMyMDEgKGNvbW1lbnQpLg0KPiBUaGUgcGF0Y2ggY29tbWl0IGlz
IHRvcnZhbGRzL2xpbnV4QDA5NTcyZmMsIHJpZ2h0Pw0KPiANCj4gSG93ZXZlciwgd2h5IEhDSV9D
SEFOTkVMX1VTRVIgdHlwZSBjYW4gbm90IGNoYW5nZSBNVFUgdmFsdWU/IEdvb2dsZQ0KPiBibHVl
dG9vdGggYWlkbCB1c2VzIEhDSV9DSEFOTkVMX1VTRVIgdHlwZQ0KPiBmcm9taHR0cHM6Ly9jcy5h
bmRyb2lkLmNvbS9hbmRyb2lkL3BsYXRmb3JtL3N1cGVycHJvamVjdC8rL2FuZHJvaWQtbGENCj4g
dGVzdC0NCj4gcmVsZWFzZTpoYXJkd2FyZS9pbnRlcmZhY2VzL2JsdWV0b290aC9haWRsL2RlZmF1
bHQvbmV0X2JsdWV0b290aF9tZ210DQo+IC5jcHAgbGluZSAyODIuDQo+IA0KPiBDb3VsZCBrZXJu
ZWwgcmVtb3ZlIHRoZSBsaW1pdGF0aW9uIHRoYXQgSENJX0NIQU5ORUxfVVNFUiBjYW4gbm90DQo+
IGNoYW5nZSBNVFU/DQo+IA0KPiBUaGFua3MuDQo+IEIuUi4NCj4gSmlnb25nIFlpbg0KPiANCj4g
DQo+IA0KPiDlj5Hoh6p2aXZv55S15a2Q6YKu5Lu2DQo+IA0KPiANCg0KQmVzdCBSZWdhcmRzLA0K
Q2hyaXMgTHUNCg0K
