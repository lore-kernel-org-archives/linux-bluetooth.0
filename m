Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3233A381E;
	Tue,  7 Apr 2026 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558100; cv=fail; b=qT2EkpNkFWxsAYzYOWb8edTEUFelDIiQINoDI/CahasKaBHuWwdqgNHD/jxUUcLAt02bSX06Nk58SGWt0nrh6yewd7Ia7nOrppWuIO31ZC03Cc9d62tc3MCgKq/JbJDXD/EWufgVPMReCxa/To1pIKjfu7bApbXuBwr9pFAatFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558100; c=relaxed/simple;
	bh=7DupyA7gHASIwFoyuJKneL9IVQseNo1fJ7hhBh8QsoE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DTC29hux+jmP6EbqfX6XN8U131r44OkywjCqEfOpLNkVihJRyCPk7t/Q3bV6xP0k10W7z9b81q3+fojf0+C5IWFIABztgKf4k0i4qlyMztTLyCWZ0JsMKHVVi4Dqbu2rSMLYcMZg/M3OUtNdxnxeLfbinFE+zNM7g8tmxWh/2Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=t1Hp6YGc; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=DwF+rchM; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="t1Hp6YGc";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="DwF+rchM"
X-UUID: 6612c3a4326d11f1ae70033691e9ac7d-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7DupyA7gHASIwFoyuJKneL9IVQseNo1fJ7hhBh8QsoE=;
	b=t1Hp6YGcVBtp5Okx0Ue/WxqGaab8lIQED5SmICO0L+9z4bUR5OB6sNilmq9mP3pEWne2upXgClu3WfZPxQQU/ZwfFXeZUvbj92rsKqlM5QaJjAHmoLcfrH7CpXn5RkRqJMlCjg4WYX8L64piZhLG16tT/qj2XeBrQ1zzjkGviYw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4ff46914-fe00-497a-ab7e-6169e7593305,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:13a09424-cb5c-4236-a89a-9a7fb20c9bc4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6612c3a4326d11f1ae70033691e9ac7d-20260407
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1198244942; Tue, 07 Apr 2026 18:34:47 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 18:34:45 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 18:34:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eD4AXdhZPurCGyrjGceqqhfiPVD0Lh7tuRYWgLkRXgGY0ecdaK5VqKM1NAr3bnRH2WdCIxQ+TwnJiDV5zSm3l1EtM2mFJtoz54If2s9CPWGLPKrdIC9okAUiPu9VLoYKrmTRuvcQShNwFZkI/ZqyU2COLCUfHkHi7v2YPZSxHMOAScca/DWHVaKgUps7ZnpZBoKt1oD5V/ThS3fu6DQCuSgqlVPg/24wzdsq3VknHkvIUq3WWR85u7FHivcZO9eTN6Kzu6w2Rt/tA9OE76RkcygSvnJRYniEqZHYFnxBAxxKr6KpY0OjOu5PEZn54btqlaLj/O1t2HcObMfLMo014g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DupyA7gHASIwFoyuJKneL9IVQseNo1fJ7hhBh8QsoE=;
 b=txPSavnIuoQsXBAEmrDC/RI32P+csTvfugcnl37INY5B098HSZdAXhOD+k8V+tGr9JxgHNNyloQ97YjRH0mHUI+7ntcJ3SjKkcg0UDqLOJRQefjmFAu42KUd/V9bG6jBYSDvNmknmP5XSsPkYzLDIvkaxbVwlaU7v0dLnduuwS4vu07hivmLO5XzWVG/IlQa1oBUSi0h2m2ZtTrvMHS1CM1XKkJcj85CWA4fyWXoY+i5nj3H7mA2rw+mS2b1cQbhKBjMAOJw9lzSPIJtu9GraaSKptNznCNETKOje/bg35T97c9nDiDKqLA5OqAbwOtwPNGzkWVYbUANyCcycscGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DupyA7gHASIwFoyuJKneL9IVQseNo1fJ7hhBh8QsoE=;
 b=DwF+rchMz+RqqC1e7hAfDZCPEOJyAug77qBzGGtNmzuL6acMTmueQWFcVDF5uK0nMq00tZGtb7dHoOfIWTKPLBP2lbByOZRk/iYchZoYBcG9TXJ4FpoputDpa5TqfO3mNFKDIzk8nLqS7rB+9axXE8y9Gp00sgUeb4hN1Ksxs6Q=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by KL1PR03MB8257.apcprd03.prod.outlook.com (2603:1096:820:10d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 7 Apr
 2026 10:34:41 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771%3]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 10:34:41 +0000
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
Subject: Re: [PATCH v1] Bluetooth: btmtk: add event filter to filter specific
 event
Thread-Topic: [PATCH v1] Bluetooth: btmtk: add event filter to filter specific
 event
Thread-Index: AQHcxlp/fA5Xz39xKkiaG6DcZmCdsLXTL6OAgAA3ugA=
Date: Tue, 7 Apr 2026 10:34:41 +0000
Message-ID: <729d8adf633815a5b9fb446d640cba1dfe4f6299.camel@mediatek.com>
References: <20260407064759.3036650-1-chris.lu@mediatek.com>
	 <abdf652a-f7e1-4641-bfd9-c0cfc20cca6d@molgen.mpg.de>
In-Reply-To: <abdf652a-f7e1-4641-bfd9-c0cfc20cca6d@molgen.mpg.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|KL1PR03MB8257:EE_
x-ms-office365-filtering-correlation-id: 36ebcd03-5479-4aa5-3018-08de949146f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: wPFXuWziP0yQCzeFdDogRLF5ZBrEWQ/0356mwfYHzBhE3iNpvbDQxAy/jWLNC/IVIZC4oc9yv8ELD5+TTEI8JndiDFeOLwesHUlB92Fjat1w893WOT3Vr4nLY+AvVWGZ6niJLJ7nIo9pvaYuKCa88SS+s3ykCbETE/aJ0GLg+KJZHj5tZitJStgR7ifvNWgV0nkFzRk6cet6wapeVdHcsvRKf21M63AZnT76t1GeSkMJXRdq23NISY2uHXDO3sev4nYWON7DnNzqQDbhrrf1VYm0gaX0wK0HYmF7ZNx5sq1OWdbInhf+7lJzH4pdzUhya4zlaM6ZrTdPJuhXZfUh3o0ZcniLMrprjQ3rpryMyndEYynnMrQEnL7FCXCfLw6ZqIwAbCKBbGQMhqnJ7BLW/KnG0KmHxo++Yr4sdTTsMd7eO6Zsi1M9tirkOTqo4RQD+HcvYfeUp9JAMtipVJMriYxb9o4seVqxGkmicH2NLRh39NTUhgNG4IwqWV/VWyIfPXTxirgzV4Sujwaxo4DKMM7WjB8kNl+AaVuaKXqiuQnDnix0YicNjEXbB/WF2NQjzRO01OnMfxK6xPzpkl98swJEf2NzQRFPKNAbK2QGvYi7py7Wc8WuPiF/OyYdsM73YHXZPN0/Vdm0N7tIrGvZ/ndDg2uHohNlWeGOpnp5EplkJcsuEv6K2AypzdU73toH8Hyc+uHbLM3ZLRtn53v/qyqjtYQzcJpuiSPsFiNolDbN7lQF/4i+UwG7dtDhHhhp2cRaQ0uBljAHJmnkNLiN4n2zOCevvrhW8Ukr+myiV64=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHFjMzgxdWdZNVFzWTRwNGZpZjEvQ3VYbEpBdUdNbUs4dWJvd2Jhb2t1TUVN?=
 =?utf-8?B?eDk4dWhzYmd4ZHZRUmNJSHA5VEVYazhNRFFwMFZaYWVHdVpDQW9QekdidWlq?=
 =?utf-8?B?NzVINmVGZmw1THVMQjI5L2lldGwwcW83ck93d3ZKRDZWczloVEZVQWdzbDY3?=
 =?utf-8?B?K0ZGUkR2Y0VyMCsvWFkwazZzTmNWcWVPcStuZ0lYdHNuZHQ1dlB0U21PQk9v?=
 =?utf-8?B?ZXJJQk9hNlJCRHgyblkwZ2RiZ3IzNjVlQTgwZm5jNS8xcEw5N3hIUTkwNXg0?=
 =?utf-8?B?Q25TNjRwOUJ1SGtmTGdQd1UxVnFFNERBWUdvUnpYQ0M1cXMyR0todEtXM0tR?=
 =?utf-8?B?YnFraU5vejd2MnhyVGxFcUI3RzNZc3pLUlRyMHpaUDZSZFFRZVNqa2pZall1?=
 =?utf-8?B?QnZROWFKbXZqT0x1RUJCVVlyZkd1bHZWS09Ub21SajVGWVBnbDRURldua1N5?=
 =?utf-8?B?UGZnb09kYkVCdUZXSVg2YStZSk5jOWRQbWhUZFpGb3FaVjF3OHFGbW5GeTRm?=
 =?utf-8?B?dmNjcmU3alNsMGNMNnJmb1hRZHFhTGV3czR1SWxmakg5V1lvblRJZEhHZklQ?=
 =?utf-8?B?dldFT1F5Q29iVGxwTnhmcTJSYWQ1VU5aSmlWUnQ3VVFQT042M3JQNGE0aXlN?=
 =?utf-8?B?UFpoL0FzWjVLQ0x4MURjSUtIVFlsWGNjdlpXS3RvcDdIbzAyclN4ekxFVmMz?=
 =?utf-8?B?RUFpcmZKL3JQeWFWRlc1Z2s0MXo3dXhnbzAwazdRZFBuclNiMktiSEh4QWhD?=
 =?utf-8?B?VCs1MHhoM2ZJcFgzM3BuT24xWEtXV1ZzVzg2a2dwOUp0TzJ2V2MyNC9oK3ZJ?=
 =?utf-8?B?cndwdFJXaW9wSDZrU3ZnK2pyNC9ScENLaXFpUStlTGJLZWllZTVvYVRIajVR?=
 =?utf-8?B?ZW9LMDc4MXZWQUM5ZXdRalhWclMyamYrZU5iUHZlSERlTzFHakRMMk00Tmds?=
 =?utf-8?B?OTI4MDZmcW5IeGRZOE5sR0RPamlpQTZjaDBxZ0dMWTN1K0lnaUFieUdqVEVR?=
 =?utf-8?B?SGs2TG5mTm03TkRtRDhYVlNVWHY4d1ZUalRYSVdhOEdCVkU0YmVvTEFLMlE3?=
 =?utf-8?B?YzJTVms1TWxLa2dKakJTcWozZWUwVlZNbTdSZTF2bmRxQWNOYlh3YTlFbHpH?=
 =?utf-8?B?bGN3QnlVc1R2MXNtMk1Wa0xJWlRWMGgxNkVJdmV5OW9PM3lvdWNnQkhxN3pj?=
 =?utf-8?B?c2FxWURYZkR4Q09MRlZJdHdKUnNMczJQdmVGOTZ0ZmgyZTBzSGg2NUlYZGdh?=
 =?utf-8?B?UWJLR2tjVHJkQ1pmb0V3Sy9SZFNMeEFINWp5ei9wcUdqa2M5aThHWW5LYktY?=
 =?utf-8?B?aXFsSmwzb2pNN1VrMUY5RExxOXNjOG1QeWkxMC9mVEhQK3diWHpWbUo5emRD?=
 =?utf-8?B?aG1lcDNlTnhjMXNhQTJNemtsMG45VkJkb1JjT1FDeWRaRk5LOWdqRzZXcDZ5?=
 =?utf-8?B?eXgyU05OWUJ2SFpwUEdJd0JQSFRzODVkM0grME12TmczT2lDaldhTGJrb01V?=
 =?utf-8?B?SUJMQkREN1lsR0ZMNFJyTTFZL01xVDE3V0g3YVB0cE1GbGRMMmV2MWNwMFZJ?=
 =?utf-8?B?R3VWUEJOak8rTlpIZnZJaHlLcXYrSU5aeGlYLzBKSnk3emdmejhMNExuV1VZ?=
 =?utf-8?B?TUliV0JCZURxYnRoUUJYUVc0VTF5TkQrZ2ltMGt0N2t6UlJDODhIYkFDWlpF?=
 =?utf-8?B?dWhDM2RFZXVJL3F4bWZrT2Q2dmFhT3hFdG5MbDNVY2swUVM5OG4xSU5iZGVW?=
 =?utf-8?B?SlNBV2ZLdWczTVVqVHUxc2hCQlhTbWowQVUvcEgzQVBIcDJoSi8xcFFaOVJ0?=
 =?utf-8?B?TEhFdnQxRnlNcGRxUE8rbktpdHZPM3hOc2kwYVgyQUdidk5YUWg2U2Nnakgr?=
 =?utf-8?B?QWVtU1FnM2kvVDBadDAwM0d1NFcrdHVNMUpobzFUaHk3aDBUTHpCSUpYU0VH?=
 =?utf-8?B?a2J1dGp0YzhWbnhzV3RJbFZUU1FsdEsrMHhUejFoeUFoaEhnWTVzMGRHSlJJ?=
 =?utf-8?B?OTY2VWIyenVqNkZEenAveEY4b0lUL0Y3YVlyRytNTi8zdnBSK2RUQ2Fjd3hU?=
 =?utf-8?B?bjdTRTdzR3d3Ry8rVGdCWFI0WjRzeGZPZ0JJQVpsVzExWGUxc2hjSmZySzZY?=
 =?utf-8?B?WmJnRWNGcEk0SlRMUmg5aEZkYU9BNWx0WXQ2SnRMNWRqQ2FQNC8rVXcwOC9r?=
 =?utf-8?B?S2lwV3psU25UVTlaSVZpNURzNHowNmN0TWozcGg2a3kwVG1HcnlHRlVBRVU1?=
 =?utf-8?B?Sjk0Zng0QWNnbXlGVGdwRHlla2Y2TUVCSVVXckREQUZwNFJMdjAvS1Q3OFBv?=
 =?utf-8?B?bWsvRjJ6NzZRWnhlS3o2WHlRU2Q4VEw4eEtBQ3M1bEJLdXNYS204UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FF5D02FB97AC246915223E793E538A8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Sy64fcsmxe4pSOb3t8Dla82z/cZmPu+BnFGXgwAIcqjoot6hhiBcDJKUyc2aN6/xgbXVQxkKdndoThZNfVloYoQoVGGGFOFP75WtVGwo8q5g3MXrAvq5kH9KyA0WPLS5x2Os/K13d39QaTiEPJ4sbms9a9AD7nMRjEXnd6MBdIvmvmdAkVPD/LmtSbE0EGGmWKQflNqm3vVEzmVeFg7sHGxA/wp+l2kGLbTMP3MJ+NlCqCuIN6+O8tZRVMYbK2clB2y6D789HwOTxHVie+nvR4Ex/KJ6epVl66KfsxGdJ6sNT+KE5whG7DMQo1bTskxARH5EfwH4TxRKiVSszbUdAA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ebcd03-5479-4aa5-3018-08de949146f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 10:34:41.4382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B96lRnc/73uxDjldnDYqnOEfl5qXFWEmCKZVAwq/Gy0aGjJ7618K/oqab991QrZQT4BJNJfOQowT/dAzPGBFeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8257

RGVhciBQYXVsLA0KDQoNCk9uIFR1ZSwgMjAyNi0wNC0wNyBhdCAwOToxNCArMDIwMCwgUGF1bCBN
ZW56ZWwgd3JvdGU6DQo+IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUg
c2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IERlYXIgQ2hyaXMsDQo+IA0KPiANCj4g
VGhhbmsgeW91IGZvciB0aGUgcGF0Y2guDQo+IA0KPiBBbSAwNy4wNC4yNiB1bSAwODo0NyBzY2hy
aWViIENocmlzIEx1Og0KPiA+IER1ZSB0byBzb21lIEJsdWV0b290aCBob3N0cyBoYXZlIG1lY2hh
bmlzbSB0byBkZXRlY3QgaW52YWxpZA0KPiA+IGV2ZW50cywNCj4gPiBjYXVzaW5nIGFibm9ybWFs
IGJlaGF2aW9yLg0KPiANCj4gU29ycnksIHRoaXMgZGVzY3JpcHRpb24gaXMgbXVjaCB0b28gc2hv
cnQgYW5kIGdlbmVyYWwuIFBsZWFzZQ0KPiBlbGFib3JhdGUsDQo+IGFuZCBkb2N1bWVudCBkZXRh
aWxzLg0KPiANCj4gPiBBZGQgYSBldmVudCBmaWx0ZXIgdG8gcHJldmVudCBkZWJ1Z2dpbmcgZXZl
bnRzIGZyb20gYmVpbmcgc2VudCB0bw0KPiA+IGhvc3QuDQo+IA0KPiBhKm4qDQo+IA0KPiBXaGF0
IGFyZSBkZWJ1Z2dpbmcgZXZlbnRzLCBhbmQgaG93IGNhbiB0aGV5IGJlIGRldGVjdGVkPw0KDQpU
aGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4NCkknbGwgc3VibWl0IHYyIHRvIHJldmlzZSB0aGUg
Y29tbWl0IG1lc3NhZ2UgdG8gYXZvaWQgdXNpbmcgdmFndWUNCmRlc2NyaXB0aW9ucy4NCg0KPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBMdSA8Y2hyaXMubHVAbWVkaWF0ZWsuY29tPg0KPiAN
Cj4gU2hvdWxkIHRoZXJlIGJlIGEgRml4ZXM6IHRhZywgc28gaXQgZ2V0cyBiYWNrcG9ydGVkPw0K
DQpObywgaXQncyBub3QgYW4gaXNzdWUgZGVyaXZlZCBmcm9tIHByZXZpb3VzIGRyaXZlciBjaGFu
Z2VzLg0KPiANCj4gPiAtLS0NCj4gPiDCoCBkcml2ZXJzL2JsdWV0b290aC9idG10ay5jIHwgMjIg
KysrKysrKysrKysrKysrKysrKysrKw0KPiA+IMKgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmgg
fMKgIDcgKysrKysrKw0KPiA+IMKgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMgfMKgIDIgKysN
Cj4gPiDCoCAzIGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRtdGsuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0
bXRrLmMNCj4gPiBpbmRleCA1NTUxNmI0NjAyZGIuLjMwMmQ2ZGRmOTA2MiAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2JsdWV0b290aC9idG10ay5jDQo+ID4gKysrIGIvZHJpdmVycy9ibHVldG9v
dGgvYnRtdGsuYw0KPiA+IEBAIC0xNTAzLDYgKzE1MDMsMjggQEAgaW50IGJ0bXRrX3VzYl9zaHV0
ZG93bihzdHJ1Y3QgaGNpX2RldiAqaGRldikNCj4gPiDCoMKgwqDCoMKgIHJldHVybiAwOw0KPiA+
IMKgIH0NCj4gPiDCoCBFWFBPUlRfU1lNQk9MX0dQTChidG10a191c2Jfc2h1dGRvd24pOw0KPiA+
ICsNCj4gPiAraW50IGJ0bXRrX3JlY3ZfZXZlbnQoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHN0cnVj
dCBza19idWZmICpza2IpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqAgc3RydWN0IGhjaV9ldmVudF9o
ZHIgKmhkciA9ICh2b2lkICopc2tiLT5kYXRhOw0KPiA+ICsNCj4gPiArwqDCoMKgwqAgaWYgKGhk
ci0+ZXZ0ID09IEhDSV9FVl9DTURfQ09NUExFVEUpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHN0cnVjdCBoY2lfZXZfY21kX2NvbXBsZXRlICplYzsNCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHUxNiBvcGNvZGU7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZWMgPSAodm9pZCAqKShza2ItPmRhdGEgKyBIQ0lfRVZFTlRfSERSX1NJWkUpOw0KPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3Bjb2RlID0gX19sZTE2X3RvX2NwdShlYy0+b3Bj
b2RlKTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBGaWx0ZXIgdmVu
ZG9yIG9wY29kZSAqLw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG9wY29kZSA9
PSAweGZjNWQpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBrZnJlZV9za2Ioc2tiKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gMDsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gPiAr
wqDCoMKgwqAgfQ0KPiA+ICsNCj4gPiArwqDCoMKgwqAgcmV0dXJuIGhjaV9yZWN2X2ZyYW1lKGhk
ZXYsIHNrYik7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwoYnRtdGtfcmVjdl9ldmVu
dCk7DQo+ID4gwqAgI2VuZGlmDQo+ID4gDQo+ID4gwqAgTU9EVUxFX0FVVEhPUigiU2VhbiBXYW5n
IDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPiIpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Js
dWV0b290aC9idG10ay5oIGIvZHJpdmVycy9ibHVldG9vdGgvYnRtdGsuaA0KPiA+IGluZGV4IGFk
YWYzODU2MjZlZS4uMDhiNzM5MjdjOGYzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRv
b3RoL2J0bXRrLmgNCj4gPiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idG10ay5oDQo+ID4gQEAg
LTIxOCw2ICsyMTgsOCBAQCBpbnQgYnRtdGtfdXNiX3N1c3BlbmQoc3RydWN0IGhjaV9kZXYgKmhk
ZXYpOw0KPiA+IMKgIGludCBidG10a191c2Jfc2V0dXAoc3RydWN0IGhjaV9kZXYgKmhkZXYpOw0K
PiA+IA0KPiA+IMKgIGludCBidG10a191c2Jfc2h1dGRvd24oc3RydWN0IGhjaV9kZXYgKmhkZXYp
Ow0KPiA+ICsNCj4gPiAraW50IGJ0bXRrX3JlY3ZfZXZlbnQoc3RydWN0IGhjaV9kZXYgKmhkZXYs
IHN0cnVjdCBza19idWZmICpza2IpOw0KPiA+IMKgICNlbHNlDQo+ID4gDQo+ID4gwqAgc3RhdGlj
IGlubGluZSBpbnQgYnRtdGtfc2V0X2JkYWRkcihzdHJ1Y3QgaGNpX2RldiAqaGRldiwNCj4gPiBA
QCAtMjk2LDQgKzI5OCw5IEBAIHN0YXRpYyBpbmxpbmUgaW50IGJ0bXRrX3VzYl9zaHV0ZG93bihz
dHJ1Y3QNCj4gPiBoY2lfZGV2ICpoZGV2KQ0KPiA+IMKgIHsNCj4gPiDCoMKgwqDCoMKgIHJldHVy
biAtRU9QTk9UU1VQUDsNCj4gPiDCoCB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW5saW5lIGludCBi
dG10a19yZWN2X2V2ZW50KHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBzdHJ1Y3QNCj4gPiBza19idWZm
ICpza2IpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+ICt9
DQo+ID4gwqAgI2VuZGlmDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNi
LmMgYi9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jDQo+ID4gaW5kZXggZjlkNTE1ZWU5MTI0Li5k
YWY4YTM4N2U2NjAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMNCj4gPiBAQCAtNDE1MCw2ICs0MTUw
LDggQEAgc3RhdGljIGludCBidHVzYl9wcm9iZShzdHJ1Y3QgdXNiX2ludGVyZmFjZQ0KPiA+ICpp
bnRmLA0KPiA+IMKgwqDCoMKgwqAgfSBlbHNlIGlmIChpZC0+ZHJpdmVyX2luZm8gJiBCVFVTQl9N
RURJQVRFSykgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIEFsbG9jYXRlIGV4
dHJhIHNwYWNlIGZvciBNZWRpYXRlayBkZXZpY2UgKi8NCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBwcml2X3NpemUgKz0gc2l6ZW9mKHN0cnVjdCBidG10a19kYXRhKTsNCj4gPiArDQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkYXRhLT5yZWN2X2V2ZW50ID0gYnRtdGtfcmVj
dl9ldmVudDsNCj4gPiDCoMKgwqDCoMKgIH0NCj4gPiANCj4gPiDCoMKgwqDCoMKgIGRhdGEtPnJl
Y3ZfYWNsID0gaGNpX3JlY3ZfZnJhbWU7DQo+IA0KPiANCj4gS2luZCByZWdhcmRzLA0KPiANCj4g
UGF1bA0KDQpUaGFua3MsDQpDaHJpcyBMdQ0KDQo=
