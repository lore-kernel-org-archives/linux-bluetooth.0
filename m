Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843644369A;
	Fri,  8 Nov 2024 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057933; cv=fail; b=IjG/wRERHXS5RshpWZp77qLzzrZbyRPnadsCCGDCxyZAENTzGpXa7VSA/iEfOqLBZQKkNksoaIv+BYbpJn9QhYKh6KrfWtubibX8nFqeTWDBkdpfVF0pWQUmgpBXxjPqP1SaDXGY5zMWFrJ7lKEN/++7saW9k5rF7m9yX069OIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057933; c=relaxed/simple;
	bh=prAPN8q7MZEfGm3P5Uz+HQ2GfvEr1G2+4DkJznCqP5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=teOSf8izQlRcTj+/PONVPbR5iel3mlvFxwQldYdS0TKqsSxWe22Ys/atEMz+F6l51wMy3V64PUWqTUAVJzwE3bzUt2zpR6Md1D752R1vj00Hnfyuu9/ymvTPhJJ5t7RqWV7cAI+NrsZiAf5HtgD9oInpvO782jxaiSc/UDbTH0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=l/i8o2PQ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=JNgide9S; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="l/i8o2PQ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JNgide9S"
X-UUID: 63d4c3b29db311efbd192953cf12861f-20241108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=prAPN8q7MZEfGm3P5Uz+HQ2GfvEr1G2+4DkJznCqP5I=;
	b=l/i8o2PQek+DbCxBmomv9xv7cJIKvj1anY+XzK5b0aBElsBNdDNuQutCMuEvASl9jyIAFBcZ/knhK3FO4nxeWrzC03QZrE7CYFM+IT4lnwcMIjBFJnzNBGH+3WeyFlIzqpwOS3miBRU6EInF9p/Iqp1CV2WBNUGt6x24272yez0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:87b54d40-e50b-4899-8090-0e662c968312,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:b0fcdc3,CLOUDID:f827c406-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 63d4c3b29db311efbd192953cf12861f-20241108
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1121048500; Fri, 08 Nov 2024 17:25:27 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Nov 2024 17:25:25 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Nov 2024 17:25:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1IcQxv4FSGNPdRQYXB5/p0X2urmHh+wKkY/pxCK7I1hVuC7XHbKQ4L06ZsguGuJ6zP0scbmdYoJvJGsBFPMFXcnfNZ4mFGrEpZSF4g0G1dB3hqLWXgSL1rQPyoR0UNCKIRFMIU1jMeRJAu/HNAyCwA+TYrlhEr+CK5xbpSPWwBHrI72M6ZKRip46I/iFeV8WHHtVpBtMM7S3mzP9fqXs1tcRQfN3MXO7N6qbTdW5g9cMQmPsHQLW8fQ3JZ5KCBOKYdwgaBNvgh+C7ErJes3cOfswNZsRQNYsv0/FHu6m6J7QNwec2WR43+gbOOruIoGqFjCWFKAGHcYbD2o3vpU4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prAPN8q7MZEfGm3P5Uz+HQ2GfvEr1G2+4DkJznCqP5I=;
 b=c9w5tNgGHZwcopNcWeybWspEyC97MeQDQtzjsr9y/FKH6ZPyp7vGsF0Wyf7W8VKjHEb9TPqzzLTVN74dzcN4wW8MO3Gbtb09bNBtfVamdkMqBSFlaAKz0YrBrWbDuMPTi8Eoi2C20IjJ+0G0L2MJzpEBeBv27vD0i1lH4WQwPQOExVjjkKXp82mRougu7zYOrgcOfQnoSximqesdrbz5sqsph5csXm8hBioZUpsvQ8sWKPB7vySwSJ4oWlEV5FeoDm4E4z2OYJLlRUoxgvZ6idlMQOEMrGbqQpWE3xbL0WDNLNqtBNCBhp9urt7+maNS+HFaFomRHzkfvCVMzGgbeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prAPN8q7MZEfGm3P5Uz+HQ2GfvEr1G2+4DkJznCqP5I=;
 b=JNgide9S8YlJuKEG/1SFtZghW3g7SMKaGgF4nS8wa8VSUaKeRep0YGc4lv2loZ4J1THJ8eMjGe9K04Z+/1Gk8FLYZsmOhw5I1c+uY3VLeNGfthxNtgLoQL/qRoBnYHcflRtI5umQg1d7Ahk2wPNJNPa26DNEjmcGawoRsWRV3WQ=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by SEZPR03MB7753.apcprd03.prod.outlook.com (2603:1096:101:128::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 09:25:23 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf%6]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 09:25:23 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"ben@decadent.org.uk" <ben@decadent.org.uk>, "linux-firmware@kernel.org"
	<linux-firmware@kernel.org>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, =?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?=
	<steve.lee@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>,
	=?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?= <Aaron.Hou@mediatek.com>,
	"jwboyer@kernel.org" <jwboyer@kernel.org>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>
Subject: Re: [PATCH v1] linux-firmware: update firmware for mediatek bluetooth
 chip (MT7920)
Thread-Topic: [PATCH v1] linux-firmware: update firmware for mediatek
 bluetooth chip (MT7920)
Thread-Index: AQHbMbfME8qQii/dQEKGjHAWbX5M0rKtD4YAgAANUIA=
Date: Fri, 8 Nov 2024 09:25:23 +0000
Message-ID: <024285d0deb37c1444b1aaa4cba64542fe4ac844.camel@mediatek.com>
References: <20241108082515.19817-1-chris.lu@mediatek.com>
	 <46444b60-2d1a-45c2-9a96-8352d1879516@molgen.mpg.de>
In-Reply-To: <46444b60-2d1a-45c2-9a96-8352d1879516@molgen.mpg.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|SEZPR03MB7753:EE_
x-ms-office365-filtering-correlation-id: 77246f2d-34bf-49d8-e3b2-08dcffd745f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cFc2aElySnhYRWYzczR0Qk9sU1V5R1FzbkNDbkZ0ano5a0lSd3o2UzlyeTB3?=
 =?utf-8?B?cGNsczUvY0JJU3NBWS83VGxtS0ZzRE5VV2ltMTE0dkZRRzE2RnpGMnV1Y3gy?=
 =?utf-8?B?QkRUcmllRnE1dHVtWHhhTUF1TTJOTTU5dFdaTEZ2WnA1MnVmbENvNkhaYUZ2?=
 =?utf-8?B?ZlhyRkJlWXViUHA2eTFwZW1Xems1czQ5VzhMeEZLMzBFVyt0VlI2ZVl4ejdI?=
 =?utf-8?B?RE1KbE4vUCs4WDFhbU0vRUVQUXFKMXMyb2dKdDhTVHJCd2ZCZUhmbG5VZ3M1?=
 =?utf-8?B?K0R6MUQ3SllTdTRIdnRvQnoxS24yS3k3UGxwSy9sNFlzamdFYjRhQVdIQTdE?=
 =?utf-8?B?YmdoNElLYy9CdmFOSGYrUkNzYVRUNTFjQ2lldUtvUXhUb2ZzY3h0RDdmUVFU?=
 =?utf-8?B?Rm42Sm51S1laT2toZ3U3TmtvMkFZR2RJTlBtZUJoZ0dXbkVPRlM3SnUrekFl?=
 =?utf-8?B?Tjg4RytzeU1zM2V2Slc1UmxERmRFODRMMXJpNXpvWTI1QW5JZE40aGgxSytN?=
 =?utf-8?B?cDBXNHdUL2J5SFE4RC9pS2daL2ZhbFFFME54N1JKRHJkRFlOTm9FaGQ2elhF?=
 =?utf-8?B?MzhpcFpmN09GdmxQeFlCTG9RSHZSb3J5TldtWlBHMVNkU2FwbVFTS0h4QXpH?=
 =?utf-8?B?NnJ6VVlVK3ZUZDJkd2cxeTJta0NaQVZIVWRSVFc2OVhDQnBOMldueTcvem4z?=
 =?utf-8?B?RnArb2NvOFVyQmxOZWI5NXYzS2tMbGN0UzREcWhtRVduUGoxMGE0WXJ3Z3d2?=
 =?utf-8?B?VTcxQlRHUmFGMmt4UXNhVWlpYTZZVkVYTHgzdmdXMjJoTEJ2Y1U2Vit0S3Zo?=
 =?utf-8?B?bVcydU5qaVZMZnIzelR3UXRYWWwzMWhxTUVwREZwc29VcXBDV3RESGp4ZGhO?=
 =?utf-8?B?NkpjWE43bUJqdjlPQjNiYTVzU2lQajZ0emdJLzdscHRFejdXVng5Z0IyTHhQ?=
 =?utf-8?B?K3Y2a2FwUmk0bzcwYUtrbURFRmVrU0pDcEhWNUhrSll2OTFRSC8zUFlOZGVC?=
 =?utf-8?B?RlFoNDUySHVJMDV3R1JhYndoM1Z0dVNEdUdDeERYRXBZSHZwR1pTUzFMb25h?=
 =?utf-8?B?SXE3aVJrQ21TaXZjQ25LQ0lhcE9tT1hmVjRUeFpxbHJWSmtPenE4eXBTOGhP?=
 =?utf-8?B?ZHRTODBSRXF4a1UxTm5WQngzVG1OdTVhN2xlNVRzVm5ZNFM3eDE5TThSQVlN?=
 =?utf-8?B?S1dPY0lndGY1ZC92TjFuU3ZldFZ6aHF1eU5HNWFtV1ZEMUNVK3R5ZTV0MVVh?=
 =?utf-8?B?UkFINmF1SlBtYmhMUFkwN283TWxNVmh6Q1RDMC9XWDVrdjFObG5EL0tZRk1L?=
 =?utf-8?B?c1hMOG1YcThOMW5xUDRHZmdBelJib0ZkTVRaMXVuR1hQZFVWbldPak0yNnRv?=
 =?utf-8?B?cm5ONUdJcUNPVk01YmVob3lYQUw1TXlRWTNTOTVnb2xNQ1Yra05JRVcxa1JC?=
 =?utf-8?B?WTU2d1cyWHlCZ1ZBbEhjTG1aL2Fkak1vMWZ2ZWFoeGYwZnVhdTVoanEreSto?=
 =?utf-8?B?V2pyVlZLdno2NFpyL1d6aHZnbDFpcHhVS01wT1RveTVvUlA3aWFoNHZESHlW?=
 =?utf-8?B?WlV0alVHTHNSU1BsaUNUVFp6UXV1Y1FIVzRQTVdIY3dGR1E1MzhCbUcxQXZs?=
 =?utf-8?B?T25RYTgvUXhPa1F0N09VUVIxbUxxZm9RQ0hRbWZwUCtzY2xGN1lSS1ZEVFBD?=
 =?utf-8?B?SjdiOExZWXlEVDJYOUlUNjNqWTZOdmpSbHJsU1I0YmV0Q0JGM2pRTkFkWFZB?=
 =?utf-8?B?MGxSZ1ZacVNoWXN5dDJzdFAzZjBocmRIaXcyVDhUUEdITkx0ZmVKV3NkNkRP?=
 =?utf-8?Q?SAIxITK6gJIiclXHJaTvJjNz2q9fXCkkuoQI0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHNrM3dFODVhTExyNnJ6U21SaUo2L2svUmVsNkFmRllTZXJMT0pxanJPWmxk?=
 =?utf-8?B?ODZGaE5QdC9PTWtkKzlRL2ZNcjZ5Tk45bFF5Z0VWVGIvK0xpblJ1NDV3TmVL?=
 =?utf-8?B?R3M0Tzh4TDBFcWRQZkRCNzRGMmNNbHBnMHMwVVRCbTgxWE1oWC8xTmJyamN3?=
 =?utf-8?B?R2hsd2ZlSVFMVFdMd0E4VWhmRUtCdVdNN1dHQmZhSlQrUUd6bXJ4aXFGWVlZ?=
 =?utf-8?B?dFlJZWRzMmoyUjMrMWZEWklMblpuc012YWtJVmMydTFZUUphR3AyRDdyZmpE?=
 =?utf-8?B?a1JVVy9NV1A4VEtjbm5lUU5UVzdvUGdRWjJDVWhEWmhqZGdZWmNUK1pTS1hE?=
 =?utf-8?B?N3E4MlIrdlcvbi9zUnBLNTFnd2JFTkJoZGdicTVIS0JtK3VnaXlzSFpybi9K?=
 =?utf-8?B?NjFKMkc1aldPbzR3ZXZyejZRdkdFYTRGTWh2alc4RU5yQTZVNmloU0VYWDVE?=
 =?utf-8?B?V2k4QlJIRFpYd09UWmpoM2JNNFA2eXh1OHk1aXdGRkF1Z3hIeEFxd0hGbENl?=
 =?utf-8?B?dUFyMnUvM3BXREJVcVNNTlBydjRXdkFFeUQ4blRLZ2lBU3ljVFJhakFxbjJU?=
 =?utf-8?B?Qi9YeHVoazhnWHcxK0dqZUF5UmxzcitPNTN0VmxUTC9BUGV4cUk2dzE0TDJK?=
 =?utf-8?B?S25yaDZMZ3VzK09mdDIvb0c4VllnTkFwa1dJR05hYlZCRE5jL1RISFo2M0oz?=
 =?utf-8?B?ZTlUdVRTMGtrMlI2cVJkK29qRXR2TC9EYkJaK0RPWUtFWnRFL0JLTGFXd2JJ?=
 =?utf-8?B?ZzJkOGYvQjNvYmRISHUvMldJYXliNmJhTWlnM3ZQZ0haRVhUYnpXZEVLNHdR?=
 =?utf-8?B?dmxSQmNyZGhLbFdvTDVGYkJkeHBzejZhZTJFQy9UNDZ4ZjloMlduRlZOV1po?=
 =?utf-8?B?bHMwOUFiRzBYbWpVWktpRnB2cnJoUVN3c2E4OXhYYTIya3l2QXlqMTlTeTM0?=
 =?utf-8?B?VlpJOWlGS2x1RGNZYlJDaHZIQSttYmRvbVJHL1FEWitsU1RXRUY4RlZzemRI?=
 =?utf-8?B?a2ZmT3c1cXIreEZkR2dlZ3AxTkxIbHkwT1BzQ0dPT1hlRmVuRVVEZWFuZHdy?=
 =?utf-8?B?Tk56TmFHVWtJNzlWVzRDYmtCc1VScDhwQjBYd0thRGs4SkJIdEI4R3NRcyt5?=
 =?utf-8?B?TFRuck9YL0hXRDFDV1c1VFZrYXVURXUzSmxjRjMrdlo2RXIwZUxoZlJ6VkZW?=
 =?utf-8?B?NndQVEtDVUI4LzNzeUVRUUgvZndsRTloVytmalVGMUlEUHZVY2tuendzQkl3?=
 =?utf-8?B?c2VDaTdEZlBrZEJvcXFkdCtLVTZzNTB2dmNxd0Ntb0xFdUd2QkJvcmRxeTNq?=
 =?utf-8?B?R0luYlZTN0ljWmhDQ2EyTS9xMnE5dVUreG8xcC9HaGpPK3RidDlDeEV3Z1hL?=
 =?utf-8?B?M1pXYVBRVGJaVk45OGljSXB4d0VHY2tKMFBjY3BWTEtaNXo3RWsxVWd1MGt4?=
 =?utf-8?B?SmYreG9MTkpGYVQybUNhWFE3RGNDaWYxbVc5TlFUdnhIcHhCbWx6UU9HYXdP?=
 =?utf-8?B?M3FEY3RzSWRwN2ltTzZkRDZ0VEs5WVNTVk1IemhTUzAzWHd5RUoxRkE5MlFt?=
 =?utf-8?B?QjFid3pTZGxEUnVlWjRjR1p2QSt5WEx3dk1aaEpESHBDbUcxMmNJc05hbFVz?=
 =?utf-8?B?T3h6Wm5KVktOYTFlRG5BY3Y1NERGQk9VM2lyZHF6eG5aMU5qTWEwOW01b0ky?=
 =?utf-8?B?T3BSS29pbEhBVHR2TzZ2R0RZRStpVHZ6VHhCaXZPOWRKN1JTNzB6cUZuS3BX?=
 =?utf-8?B?V0o3NDFvQ29nYXJwNXNWVFFyUnVuNFVDSHJwTVZ4THNXYVk3VlNXNkNOR1F2?=
 =?utf-8?B?dDVlek5iajlxbjZGV3p3SlRDbmorcG9mc2lpZXpoV3YwbERkMkV6MHFqMVZv?=
 =?utf-8?B?TERWVXB6ZFZia1pJMi9ZSFpRU0pXdEVreFVrMHVGbDZUSVlTN2dpRUs0dERt?=
 =?utf-8?B?K1pZSG96dmhWakxvL0pGRy9qeTl3ZEc2Wmw4U0h6cVR2SHprYXZrTzdlWVVL?=
 =?utf-8?B?QlpTVDllZkY0MExjSDVVWlVkOFY0bkg5SmVuM3M5bTQ4Z09CUGppaHQyUjNO?=
 =?utf-8?B?OWt4SnJrWWw3c29oclJDZnVzY1dRSjlxN1IrZFpqN3dBNit5UUFJTFdmTnVJ?=
 =?utf-8?B?YjNkZDFPSzllOHFEWlFUV2hwcUdPWllHdDBjRm1FbWpHbVF4SEFPSk9od0ZP?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4EA684D77B4064D83D84D0B0467C46D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77246f2d-34bf-49d8-e3b2-08dcffd745f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 09:25:23.6333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: blFwqXmIZ7JB2+V2/84xh2OTY9H4fHu50JMRssPQR/MiIXuuXyAOGJ5KqI8HGBeS6ngLsATnIHTmLLX35jA90A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7753
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--30.080800-8.000000
X-TMASE-MatchedRID: eVEkOcJu0F6nykMun0J1wpmug812qIbzju+GX08gELD7I1hjCeCvFh4u
	a24ul9odYS4zoKmh97jlPWOZdnoFfID/Mgy7K7lHvHKClHGjjr2cyCGZko2aplVqIv0mjuMGgx0
	sFCXnAdqiwVDL24OU/lVh7jl/wmldE6qoNXpB3JxgP1dNF1ow7XN3sLsG0mhunAsoIr/AIn1vKp
	xZPgVlFys4ktrMjxBCUxh2ckoDQVl0V8DAplF7wbCvlllU7Dl1/duHe/ZmXJnJyYU2J054PVKTe
	W+F3fxdtKmFsO4nVm4XRUhFNMQDTqe6BbWZGzO0j2FGM19l45e+1Vx7rDn4r8ANrY4Rqb7GRRZI
	1R6hQzbQGlxIVvV/XpGTpe1iiCJq0u+wqOGzSV1WdFebWIc3VsRB0bsfrpPI6T/LTDsmJmg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--30.080800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	CD23A28C14A774CF2110F303E6C598256FFE50F3F729F244C59E90CEC62198762000:8

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB5b3VyIHJlc3BvbnNlLg0KSSdsbCBzZW5kIGEgdjIgdG8g
dXBkYXRlIGNvbW1pdCBtZXNzYWdlIGJhc2VkIG9uIHlvdXIgc3VnZ2VzdGlvbnMuDQoNCk9uIEZy
aSwgMjAyNC0xMS0wOCBhdCAwOTozNyArMDEwMCwgUGF1bCBNZW56ZWwgd3JvdGU6DQo+IEV4dGVy
bmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+
IA0KPiANCj4gRGVhciBDaHJpcywNCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaC4gTWF5
YmUgaW5jbHVkZSB0aGUgdmVyc2lvbiBpbiB0aGUNCj4gc3VtbWFyeS90aXRsZT8gYGxpbnV4LWZp
cm13YXJlYCBhbHNvIHNlZW1zIHJlZHVuZGFudC4gTWF5YmU6DQo+IA0KPiBtZWRpYXRlayBNVDc5
MjA6IFVwZGF0ZSBCVF9SQU1fQ09ERV9NVDc5NjFfMWFfMl9oZHIgdG8gMjAyNDExMDQwOTEyNDYN
Cj4gDQo+IG1lZGlhdGVrIE1UNzkyMDogVXBkYXRlIEJUX1JBTV9DT0RFX01UNzk2MV8xYV8yX2hk
ciBmcm9tDQo+IDIwMjQwOTMwMTExNDU3DQo+IHRvIDIwMjQxMTA0MDkxMjQ2DQo+IA0KU3VyZSwg
J2xpbnV4LWZpcm13YXJlJyBpcyByZWR1bmRhbnQuIFdlJ2xsIHJlbW92ZSB0aGF0IGluIHRoZSBm
dXR1cmUuDQoNCj4gQW0gMDguMTEuMjQgdW0gMDk6MjUgc2NocmllYiBDaHJpcyBMdToNCj4gPiBV
cGRhdGUgYmluYXJ5IGZpcm13YXJlIGZvciBNVDc5MjAgQlQgZGV2aWNlcy4NCj4gPiANCj4gPiBG
aWxlOiBtZWRpYXRlay9CVF9SQU1fQ09ERV9NVDc5NjFfMWFfMl9oZHIuYmluDQo+IA0KPiBUaGUg
c3VtbWFyeSBzYXlzIE1UNzkyMCwgYnV0IHRoZSBmaWxlIG5hbWUgaGFzIE1UNzk2MS4gSXMgTVQ3
OTYxIGENCj4gcGFydA0KPiBvZiBNVDc5MjA/DQo+IA0KDQpNVDc5MjAgaXMgdGhlIG1vZGVsIG5h
bWUgb24gdGhlIG1hcmtldCB3aGljaCBpcyBNVDc5NjFfMWEuDQoNCj4gPiBWZXJzaW9uOiAyMDI0
MTEwNDA5MTI0Ng0KPiANCj4gSXTigJlkIGJlIGdyZWF0IGlmIHlvdSBhZGRlZCBhIGNoYW5nZS1s
b2cuDQo+IA0KV2UnbGwgdXBkYXRlcyB0aGUgZmlybXdhcmUgd2l0aCBXaS1GaSBtb2R1bGUgYXQg
dGhlIHNhbWUgdGltZSBpZiBlaXRoZXINCm9mIG1vZHVsZXMgaGFzIGFueSBmaXggbmVlZCB0byBi
ZSB1cHN0cmVhbS4NCg0KSXQncyBhIHJvdXRpbmUgdXBkYXRlIHRvIE1UNzkyMCBCbHVldG9vdGgg
c2lkZS4NCg0KPiA+IFNpZ25lZC1vZmYtYnk6IENocmlzIEx1IDxjaHJpcy5sdUBtZWRpYXRlay5j
b20+DQo+ID4gLS0tDQo+ID4gICBXSEVOQ0UgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAyICstDQo+ID4gICBtZWRpYXRlay9CVF9SQU1fQ09ERV9NVDc5NjFfMWFfMl9oZHIu
YmluIHwgQmluIDQ5MzgwOSAtPiA0OTM4MDkNCj4gPiBieXRlcw0KPiA+ICAgMiBmaWxlcyBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gDQo+IEtpbmQgcmVnYXJk
cywNCj4gDQo+IFBhdWwNCg==
