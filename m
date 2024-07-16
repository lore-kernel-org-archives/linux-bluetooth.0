Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F51821A04;
	Tue, 16 Jul 2024 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116842; cv=fail; b=hraSRlWMeiW5ENmDohtiAtpIngVbDP7iRh59hYM2Z0TQ2OxamiBqmzpRzKCBjK6Yw3sjHpz05SEIJZh9LGQt14NRXJ2aX6ZMmw+eqsqSLwIip4SMNNGnARSUpiXqI3KGqEQMKFSSPVe7T0JPHWCsSmyILSD552vTcIw3aeRIc9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116842; c=relaxed/simple;
	bh=KgRETM+uqKxgbZzYFW73h7AyPjlu3Sn8HgHDSUi573I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nXGlnvmLFJsXNUYBYf4+ojBimIpZx5kPplwO1QwQZ4tFMZoF+sw8S4K+rLe4nm+LtnQXdiGWcausWTJWVV7rVAWPmZ1Q/fFqKZvu3xU3By+1PenQFgj/5k8bKIEoLNVgYeVT1pf3CDKAA0rJJhJwVbDn4H7svNrsdv/aHUVhJHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IsA8TavF; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=GiQm1r39; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IsA8TavF";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="GiQm1r39"
X-UUID: 654537e6434911efb5b96b43b535fdb4-20240716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KgRETM+uqKxgbZzYFW73h7AyPjlu3Sn8HgHDSUi573I=;
	b=IsA8TavFTRdD5/y5ayNlOVW49Otpk5JhgudC1txvShRmq32SeyttfNtCzI6YYy0QLhPwrrlk6Uo0b8Vxbbll6Wr1tC8/+pFKXmiYBY7hBoPv7RcVdeFg9GYGvXD9OpljKKY9q0RTnUizWIhX7ZPxmEGpXIoGtvlqTPrXwqvcPT8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:4985fef1-7b2b-432a-b36d-2b82f50d2367,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:ba885a6,CLOUDID:079789d1-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 654537e6434911efb5b96b43b535fdb4-20240716
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 910090908; Tue, 16 Jul 2024 15:59:58 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 16 Jul 2024 15:59:57 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 Jul 2024 15:59:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUa/ZmQOElKYx7WwaFm5lU0C/K1nIEvY1nhv7SXVi4VXByP+U7dfowKVHSZVf7SZ4FHz68DN90BZqQMchWBQz3z8W68EsOFqJvpaTlGWrAuYk6x2/Djc5/BqV9BwKTxkgOtbnN9ZJznSO9jw3aAUlH+jd02wD9hbpOMaThw+mFtu0COcJYjATg5DL38rKIoRU8llpTdNsSW9LJ4ZGRxw81QomDnhxal0TFhQp7w8U4sDbGIDQeZdH4KoAuvsYEvgvZuTcCkl3s/GsPjaOYdij49fNIVH5yXCY7C2wIhCxiELPsCMHNLYTRRsm+vxPUm92eQ06EYcaYE/jhzxk05CMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgRETM+uqKxgbZzYFW73h7AyPjlu3Sn8HgHDSUi573I=;
 b=Qe0cwP7RnYnZjsX/wH5k6bTRxiDu/6sGV+7OEBqLDesqJRnL4RiQfr6edis0wWZhJYbffmaTEcRiz7o5N/if5fueW9VGakSHUbzBGKmApc5tBQ4uNXliddcXrsxq2PhmF7V2mGAee+xGjkz1STXc319Ml79Yf9UT3jNiM7DmvR1vFMBdLktOtDx1G1ZJu+5jjc36ILnoa7dz7AD8KdmpnZ75+hpimjyc2JYTV7BfTId4ClWZ4tY8+gxBXPscvKXGa2D4HY00VqI+Bkf0B1JI2ABUKiuoA1Ph8yEDG01FtOGtTGltYSEoDsozuyb7/3ZozMf5kTDUGew9P5xFzDyYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgRETM+uqKxgbZzYFW73h7AyPjlu3Sn8HgHDSUi573I=;
 b=GiQm1r39sU0BoZOnJkIMimjum+rLYAPoEDnrhGBcMWB9gaQVRpaDINrQZ5gw0ygsYHlhP9IkIGF81//jfLE05y9XZxkcmp5OZtj2ALWTRHcB//PWsPILgj7rLIE1YWIswWpk+4rkI12rQo1/5eZF/7DZ/Tsu4T1no79etLBUOgk=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by SEZPR03MB7006.apcprd03.prod.outlook.com (2603:1096:101:aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 07:59:54 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 07:59:53 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "nfraprado@collabora.com"
	<nfraprado@collabora.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernelci@lists.linux.dev" <kernelci@lists.linux.dev>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	=?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
	"kernel@collabora.com" <kernel@collabora.com>, Sean Wang
	<Sean.Wang@mediatek.com>, =?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?=
	<Aaron.Hou@mediatek.com>
Subject: Re: [PATCH v7 8/8] Bluetooth: btusb: mediatek: add ISO data
 transmission functions
Thread-Topic: [PATCH v7 8/8] Bluetooth: btusb: mediatek: add ISO data
 transmission functions
Thread-Index: AQHazdeaA32TCev3Sk69TatyYzbTebH4cxoAgACdfQA=
Date: Tue, 16 Jul 2024 07:59:53 +0000
Message-ID: <6a6dc0b081e8caa99172666c71b0826c1cb17a1c.camel@mediatek.com>
References: <20240704060116.16600-1-chris.lu@mediatek.com>
	 <20240704060116.16600-9-chris.lu@mediatek.com>
	 <7851401b-e884-4ed4-998d-7651f427ad37@notapiano>
In-Reply-To: <7851401b-e884-4ed4-998d-7651f427ad37@notapiano>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|SEZPR03MB7006:EE_
x-ms-office365-filtering-correlation-id: aa33d635-5fe3-4bca-28e9-08dca56d46e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZTIxOEM0UWhjQXZMa2QyVnU5MFlVZG9ldmJlU0ZsSnN1Q2dydXp2QVd2Yitq?=
 =?utf-8?B?bk1zV2dPQzIyNDlENmpkRlo3VFhBNVJhMyt0UnozYThsN2hvUkxOUE5nZkw4?=
 =?utf-8?B?YVFrWFBCWE0xdVpSU1MyNzIxN2JqVTBreHNrQ1JXeXVuVDNqR3dtaEliMlNC?=
 =?utf-8?B?T0F2TVIrRElycWJpQ0ZQQUExei9UaWs0QlFZQThEU281ck5ScTdhUTh2L3Bm?=
 =?utf-8?B?VVdEY0pLUk9jelI0ZXdoYTdpODRYb08wOWJSWlVMVTJTZFZXZ0Jhc2ZjWXdX?=
 =?utf-8?B?cSs1T1kyOXVnSTFyMzc4QkVlYzZGeXExbjRKSUlVVTB4bThYVUlYVnFudmp6?=
 =?utf-8?B?dDcyeW5IUjg4OU5HUUE1L3NRVU1raFlYUWJXelJnM1FOM2t3UWRvTDl1ZVhK?=
 =?utf-8?B?Y3RKWE1zcmN2QWt0SFQ0SGY1QXZaVnJMMHBZYU1NVmtjSUc5S0JXVHpXQ2tv?=
 =?utf-8?B?UG8yeGErUDBrY0Q5RTY3QWlqdDJGalpGVzZxWVBrK0xrNHBLeFJRWDZmVTVh?=
 =?utf-8?B?Mk8zVGN0d1FDNHlkaDlvWURUY3V4TlFhVjNaUnpJdncxa0JSV3F0L2dWR3Nl?=
 =?utf-8?B?cGJyWHUxUDhhSzRSQy90MmcxWjV0K0hOa2R5WC9yMEx6UTBDa2hZUlNLMkJn?=
 =?utf-8?B?L0g3NTVUa21VazhQY2RFV0JZNTFoVGU5QVNrb3VRNWg2WmthN1owakRRbVJR?=
 =?utf-8?B?VXJPMSsrNVZOWnlIWTg1amdFVGZYcHk2NXFWK3RtZFVvNTA3Zy9qblFUTnc2?=
 =?utf-8?B?YzBFVHFtdXhtRkFPZFpzTklIM0YxdnczUnVDN2N0aW95U1BySzNlNHE0ZFRi?=
 =?utf-8?B?eHkvVUlkL1hReC9US3ViVmtoV00xYkQzQWJ6ZHBvN1NldkJTNWRwT3ZnSlNP?=
 =?utf-8?B?dmR3WkptT1gxOVJCUDU2M2FTemtvdEdUMDUxN083L3BqeE9Db0JPSnNKVWth?=
 =?utf-8?B?ZVhKUFJ0UkYyZTRBVHc4YUIvQWNLVzg1NFBLdmlIaDBpTTRIMURBWWFBWXJX?=
 =?utf-8?B?T1AwV3E3TTFMQzEyQXpqdmVId1lGR20rZnFaM0YvOER6YjVualp6Mk9LQW9K?=
 =?utf-8?B?ZnAyazZTMW1rYzgyUW5Xc1ZoUTYxd1RpY0s2WDVGYXU3WXZuZTlkMHF3YXNP?=
 =?utf-8?B?bTRrNFpveHlJWVY0SllVbXFoOWhBWUNNbzRjbjhEaGpiakljSzg5eG9rbFNn?=
 =?utf-8?B?RHpORk13RXp1Q2ZpWW82SncrNXVUT0JFbHB1Ym0zcm9VUnVjMThVRUVQbnFm?=
 =?utf-8?B?QlcxV1lLYjFnaE42TGhDS1ZxaDQyQWd2WGx4VHVzZ1pGQlBXOEROSkZMMUl2?=
 =?utf-8?B?YklQWi9KQzNKUnJkREttVUo2ZXpLbi9HT2Q4dTFBQStjODJjSkVXWkRaME1v?=
 =?utf-8?B?OGN5RFlIMnVlOTMwenJUQ0tBcUdmVGQ1ZVhvN1AwL2M4NXJJRklMVmttbThI?=
 =?utf-8?B?Y2NVZWViYURXdmJzK0dtd1lkS0VSWldKZ1Q0YVhmM1piaUhFZTZuQ2NvVWNE?=
 =?utf-8?B?THQyWWFKRjdVbXc4WjhIdFVWaEJZZ3h1S0V5WEZQQTNxQW5lV2RpdlBDUGxa?=
 =?utf-8?B?RWNRYnNjclJNWkF1c2tnenorWVZDb0I0L1NINDN0UHl6MFB0NW4wcXV1ejBv?=
 =?utf-8?B?MmFwZDUvUVZKK040akpvQlRRV2tnR092YzY0b2hzZTdrbjNKcTBiRG1ROGhi?=
 =?utf-8?B?UEJ4NmsyMloyZ3VoZ1dKYmtCV2dPUkUrVGhyZ0lzYnpNUkJVQzROanNPbVpD?=
 =?utf-8?B?c3VoejJ2dDM5ajVGVE5YRUpmRlNvZlNSaHhiR0QxSXBaaUNIb0p2UlVDQytZ?=
 =?utf-8?Q?yibQcR25P/SoGct07aLAGkEgULbjcN5hSMgS0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTNSUDhCa3BPRzBYZm9GMWEvYzVKaXI0ZmJuRFp1NkdHYTM3SzN6TkF6MVoz?=
 =?utf-8?B?U29VcjZRelZOcmJoRFFCVmt2S2pZNHR1YkJDd2ExYWFGQThHcmQvTUgrY3px?=
 =?utf-8?B?WVowMDVMTWJKS3YvRlc1eUZYQXVIbVFaQ2RGdDNYK1JuYzVmYWVMaFdVb1Iz?=
 =?utf-8?B?b050Yk5WcGdCeWIwWEpyRHp0VU9JdHRER0tLMUM5UGJQMm5EdzMwVVo4YTV2?=
 =?utf-8?B?TGk1L3l5NEJXNzJmMGJaRDZrSG4vRjhwRW9oM2JKNEovMHJJdkZFTUd0R2dN?=
 =?utf-8?B?NkxqZytJZGZrN3BwRURrVlpKMC9FWXpnc3JSQWhPTjhBL1A1UUxmZ0dQQ0xw?=
 =?utf-8?B?NmRkaXovMkl1TTdnLzlTeDEyK2RvT3ZRSFAwSE1yZEo5TUhXWlA1RStnOHdI?=
 =?utf-8?B?VUF3bDNZS3k0MTNkMzBaQjdPRDZmOFloSkc1Q2FFYytWaWMveEpETHNEeDBE?=
 =?utf-8?B?REFUVEt0bkVNSlRhSDYyL245WGlUaGhYNzRicWxOdjZ2YXhXUW13THR4TURr?=
 =?utf-8?B?K2tCMkhJUkgySVlEQW1rck1QbVpPcHFpaDE2d0IxdGZQQjZpb2lBc1FMM01j?=
 =?utf-8?B?dElLeGhBQjBOMVFwbEhMdUNQY1ozWHVxOTBwaGJpVHpzbTJuakt0V2swSDVl?=
 =?utf-8?B?ZG1vbFY0d1RtZHRIYThMUUNZQXRPem13NVpJYWo1OEVveGJoZUYrZlR2ZnpN?=
 =?utf-8?B?SCtXRWk3SVVLbmx5SXczaWhKQlJNaHIxTnF3bU9BQUJjNHh3OEtHZXNNTVR3?=
 =?utf-8?B?MERPaEU2emM5WS96VjFnUHFmK0pCMjNyTko4Sk1qSVYyQXUxWDE2RFZpSEdo?=
 =?utf-8?B?TDZPM3BjeWwrdDhrV0VNUWk4djZRU0JjbHdNenQzNlJvODlndDd5MTh3SGVU?=
 =?utf-8?B?alFUMHg1UEpPVXFOd2V6TzZrdFJhN3crb0tiblpjZmFyWGxVU0Vsa1pvL3Q3?=
 =?utf-8?B?eDZNRlRjWURNa0tRWFVLWTlyczlTQldMMVdoUHhaMlptbTc1S3E5Q2pPSWFX?=
 =?utf-8?B?NXljajFUb1VhN2thSnB3aVF3QThub1NOZ0JHUXFmclplcVMvaGpIc3YySkVr?=
 =?utf-8?B?TitzdUxzUkxDdklUQzRnUUYvWlorTDZ2MjBXblIzM1d1MThWRnRTVUEvUkVN?=
 =?utf-8?B?dVRYcXN2dklLNXB0cmljaVpWdlJ1WnNGM1ovem1VM3RNTnh1U04wdDg3eDlB?=
 =?utf-8?B?L005c0w1SW9XZ09oTWowNmxJTTdDQXVkNjdlT0ZMUE1adDZQMmNva0NWZzdz?=
 =?utf-8?B?cmpkbDJJTmlLRzZzbzFLTEdvVlBIQkREZFdzdjNSZGRzUXFXdXRmdWR6TzEr?=
 =?utf-8?B?b3dPYThmK1pWcmp4dG4zcHgxbzJMS2kwYVBwUE5ucnNMUzc4SzhUOXYzdXhq?=
 =?utf-8?B?S2dMOFo2LzhWTXlsTHlWektmTGtsZkxCRjBGRkZzWXR0ZHBTS1FzL1A1NUhn?=
 =?utf-8?B?c0tTTjdmSGM3OGp5Q1Q3U3FOR1dRamlsNlJNbDY4eHVOWkhWeUUxcU1Ba2p6?=
 =?utf-8?B?bytMcisvUDQrVFQ4dVVMK1dyOVVic0RPSWVZYldsYjB6dlo4YjZyRWdMa0Ur?=
 =?utf-8?B?eS9aNk1pOFpLenowWVdOM2Nrb2RGNVRabWZBQ0ExSHZRTW9WSjBWNXB2QUZY?=
 =?utf-8?B?MWkvSmlveHFNWWZ3b0RvRHhvVjZBdEJtZHBCNitSRzFKQjI2SVZJU2dzbEZW?=
 =?utf-8?B?TUFtdndIOUlIdlZGOVFRSmwxVXRjREVJUTdDOG9SR0tUNUt6ZWpFdGw4d1N0?=
 =?utf-8?B?T04vcUdMenVYSGdkeWQ1bGxwSWhnQndrYnNVWVNTbS9lZU0wOEdvSWRSellY?=
 =?utf-8?B?TXlOVEFLQkRMV2FQSE9pa1RleUduSkF4OGxBZU9Femx4YTBjVGV5WVAyR2dU?=
 =?utf-8?B?cWlDSUI4UXpOSXhYamIxOWxyTVhkWnlpTUlvSXpYaWxJdFUyc2J1MU4yWVpo?=
 =?utf-8?B?OVlzOE1SMUErWG9vc1NTYWFxYkk0SisrY1piQVhpVHhCZ0puUjBhYkFlWVdn?=
 =?utf-8?B?Z3JnTmtYdWtoLzJDVjBzenVuZlE5OVR3QkhIS21SeUYxOGNlaXZzSXV6UlQx?=
 =?utf-8?B?SW9TVzNPcHpRc1RLSlBIZy9CWTRuUTJNc2J2anEvL242S2NscTdIZkRsWHJ4?=
 =?utf-8?B?Vk5ERUNCR3pBdzRwdDhtdGJRUCtEWHp4YXFnMmU1aUE5WjZzY3BmLzJYS2xP?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <291FF605717B5F4BAB61EC0BB9F0B835@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa33d635-5fe3-4bca-28e9-08dca56d46e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 07:59:53.8326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qraFMbPkVlTACd4/TGWkNkze/V4dobioNoWhPTKOELDYGd4eNl0M3b2D3JiwakC2CuKFaGcRCuaBJCacTFPJcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7006
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.804000-8.000000
X-TMASE-MatchedRID: ZFzIhWOuIzunykMun0J1wozb2GR6Ttd3Qa2sDHLkQ04GW3hFnC9N1Zop
	ZrlwTUy0Kkve98HPUws7b3Js3F6vVAMWCgdCzp+aQpxiLlDD9FXg5IlbqEYTO1XWVD8efRM6yRS
	EpZz6DA+Lw7tARCqxTgu99iJGFEn0lNn1XnREFDs97LaDkTe7WyT0t/+p7zHHaxKBbTWINAswJd
	cvGDLYlDo9Pn1RcbLQ1tp8+XTTM4PyRw5iUQdLQ1T/YzREB9OKc3ewuwbSaG7EYvhZV5Vohd+HY
	jGHlFYn4538uJtNlEpRK9dnxWTW0IQ0XwUs6dU+0MohG+IQ2sdY8mfhSYy5UqLVgbkZxM5PpgOY
	g0FJDWiQmXwS7ElYLrkK4EPjG7pLEd0YyW6tLbn62mDKTRDEUopu5TX35E2uYdn5x3tXIpezi0A
	Q4R+iwXgHfz06cmB/pt3L5VFqVtscclT8xH6eYY9hRjNfZeOXRpk33F8u9aiK7YOuYEnUwYWGw1
	NtzLd55kVAFMQGYVI9h9DU7GMhOBUtfqgsaZaLngIgpj8eDcDBa6VG2+9jFNQdB5NUNSsiV2g5+
	g4QNgK5G5ZK4Ai7+N0H8LFZNFG7JQhrLH5KSJ0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.804000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	1B6BE0139243A5963EB648BEB82D98193557A640B014715DEA17F08E1CE723852000:8

SGkgTmljb2xhcywNCg0KVGhhbmtzIGZvciByZXBvcnRpbmcgdGhlIGNyYXNoIGlzc3VlLCBJJ3Zl
IHNlbnQgYW5vdGhlciBwYXRjIHRvIGF2b2lkDQp0aGlzIGNyYXNoIGlzc3VlIGhhcHBlbmVkLiBr
aWxsIGFuY2hvciBmdW5jdGlvbiB3YXNuJ3QgcHJvdGVjdCB3ZWxsIGlmDQpNZWRpYVRlayBCbHVl
dG9vdGggZmFpbGVkIHRvIHNldHVwLiBBZGQgYSBmbGFnIGNoZWNrIHdoZW4gcnVubmluZyBpbnRv
DQpidG10a191c2Jfc3VzcGVuZCBmdW5jdGlvbi4NCg0KVGhhbmtzIGEgbG90LA0KQ2hyaXMNCg0K
T24gTW9uLCAyMDI0LTA3LTE1IGF0IDE4OjM2IC0wNDAwLCBOw61jb2xhcyBGLiBSLiBBLiBQcmFk
byB3cm90ZToNCj4gT24gVGh1LCBKdWwgMDQsIDIwMjQgYXQgMDI6MDE6MTZQTSArMDgwMCwgQ2hy
aXMgTHUgd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIGZ1bmN0aW9ucyBmb3IgSVNP
IGRhdGEgc2VuZCBhbmQgcmVjZWl2ZSBpbg0KPiA+IGJ0dXNiDQo+ID4gZHJpdmVyIGZvciBNZWRp
YVRlaydzIGNvbnRyb2xsZXIuDQo+ID4gDQo+ID4gTWVkaWFUZWsgZGVmaW5lcyBhIHNwZWNpZmlj
IGludGVycnVwdCBlbmRwb2ludCBmb3IgSVNPIGRhdGENCj4gPiB0cmFuc21pc3Npbg0KPiA+IGJl
Y2F1c2UgdGhlIGNoYXJhY3RlcmlzdGljcyBvZiBpbnRlcnJ1cHQgZW5kcG9pbnQgYXJlIHNpbWls
YXIgdG8NCj4gPiB0aGUNCj4gPiBhcHBsaWNhdGlvbiBvZiBJU08gZGF0YSB3aGljaCBjYW4gc3Vw
cG9ydCBndWFyYW50ZWVkIHRyYW5zbWlzc2luDQo+ID4gYmFuZHdpZHRoLCBlbm91Z2ggbWF4aW11
bSBkYXRhIGxlbmd0aCBhbmQgZXJyb3IgY2hlY2tpbmcgbWVjaGFuaXNtLg0KPiA+IA0KPiA+IERy
aXZlciBzZXRzIHVwIElTTyBpbnRlcmZhY2UgYW5kIGVuZHBvaW50cyBpbiBidHVzYl9tdGtfc2V0
dXAgYW5kDQo+ID4gY2xlYXJzDQo+ID4gdGhlIHNldHVwIGluIGJ0dXNiX210a19zaHV0ZG93bi4g
VGhlc2UgZmxvdyBjYW4ndCBtb3ZlIHRvIGJ0bXRrLmMNCj4gPiBkdWUgdG8NCj4gPiBidHVzYl9k
cml2ZXIgaXMgb25seSBkZWZpbmVkIGluIGJ0dXNiLmMgd2hlbiBjbGFpbWluZy9yZWxhZXNpbmcN
Cj4gPiBpbnRlcmZhY2UuDQo+ID4gSVNPIHBhY2tldCBhbmNob3Igc3RvcHMgd2hlbiBkcml2ZXIg
c3VzcGVuZGluZyBhbmQgcmVzdWJtaXQNCj4gPiBpbnRlcnJ1cHQgdXJiDQo+ID4gZm9yIElTTyBk
YXRhIHdoZW4gZHJpdmVyIHJlc3VtaW5nLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENocmlz
IEx1IDxjaHJpcy5sdUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+IA0KPiBIaSwNCj4gDQo+IEtl
cm5lbENJIGhhcyBpZGVudGlmaWVkIGEgYm9vdCByZWdyZXNzaW9uIG9yaWdpbmF0aW5nIGZyb20g
dGhpcw0KPiBwYXRjaC4gSXQNCj4gYWZmZWN0cyB0aGUgbXQ4MTk1LWNoZXJyeS10b21hdG8tcjIg
cGxhdGZvcm0uDQo+IA0KPiBUaHJvdWdoIGFkZGl0aW9uYWwgcnVucyBJJ3ZlIGRldGVybWluZWQg
dGhhdCBpdCBvbmx5IGhhcHBlbnMgd2hlbiB0aGUNCj4gYmx1ZXRvb3RoDQo+IGZpcm13YXJlIChC
VF9SQU1fQ09ERV9NVDc5NjFfMV8yX2hkci5iaW4pIGlzbid0IHByZXNlbnQuIEkgcmVhbGl6ZQ0K
PiB0aGUgZmlybXdhcmUNCj4gc2hvdWxkIGJlIHByZXNlbnQgdG8gbWFrZSBwcm9wZXIgdXNlIG9m
IHRoZSBibHVldG9vdGggZHJpdmVyLCBhbmQNCj4gSSdsbCBhZGQgaXQgdG8NCj4gb3VyIHRlc3Rp
bmcgaW1hZ2VzLiBTdGlsbCwgYSBwYW5pYyBzaG91bGRuJ3QgaGFwcGVuIHdoZW4gaXQncw0KPiBt
aXNzaW5nLCBoZW5jZQ0KPiB0aGlzIHJlcG9ydC4NCj4gDQo+IFJldmVydGluZyB0aGlzIHBhdGNo
IGZpeGVzIHRoZSBpc3N1ZS4NCj4gDQo+IFRoaXMgaXMgdGhlIHRyYWNlYmFjazoNCj4gDQo+IFsg
ICAgNi43MzQyMTRdIEJVRzogc3BpbmxvY2sgYmFkIG1hZ2ljIG9uIENQVSMzLCBrd29ya2VyLzM6
MS8xMDQNCj4gWyAgICA2Ljc0MDAwMl0gIGxvY2s6IDB4ZmZmZjJjN2I4NjU1ZjY2MCwgLm1hZ2lj
OiAwMDAwMDAwMCwgLm93bmVyOg0KPiA8bm9uZT4vLTEsIC5vd25lcl9jcHU6IDANCj4gWyAgICA2
Ljc0ODIwN10gQ1BVOiAzIFVJRDogMCBQSUQ6IDEwNCBDb21tOiBrd29ya2VyLzM6MSBOb3QgdGFp
bnRlZA0KPiA2LjEwLjAtbmV4dC0yMDI0MDcxNSAjMSAzNTg5MzIwMmNhOGY5OWIzNzEyOTk5Nzgy
MTQ0MWEyOWQyYjIzZjBhDQo+IFsgICAgNi43NTk4NzRdIEhhcmR3YXJlIG5hbWU6IEFjZXIgVG9t
YXRvIChyZXYyKSBib2FyZCAoRFQpDQo+IFsgICAgNi43NjUxOTVdIFdvcmtxdWV1ZTogcG0gcG1f
cnVudGltZV93b3JrDQo+IFsgICAgNi43NjkyMzVdIENhbGwgdHJhY2U6DQo+IFsgICAgNi43NzE2
ODldICBkdW1wX2JhY2t0cmFjZSsweDljLzB4MTAwDQo+IFsgICAgNi43NzU0NTZdICBzaG93X3N0
YWNrKzB4MjAvMHgzOA0KPiBbICAgIDYuNzc4Nzg2XSAgZHVtcF9zdGFja19sdmwrMHg4MC8weGY4
DQo+IFsgICAgNi43ODI0NjNdICBkdW1wX3N0YWNrKzB4MTgvMHgyOA0KPiBbICAgIDYuNzg1Nzkx
XSAgc3Bpbl9idWcrMHg5MC8weGQ4DQo+IFsgICAgNi43ODg5NTBdICBkb19yYXdfc3Bpbl9sb2Nr
KzB4ZjQvMHgxMjgNCj4gWyAgICA2Ljc5Mjg5MF0gIF9yYXdfc3Bpbl9sb2NrX2lycSsweDMwLzB4
NzANCj4gWyAgICA2Ljc5NjkxNV0gIHVzYl9raWxsX2FuY2hvcmVkX3VyYnMrMHg0OC8weDFlMA0K
PiBbICAgIDYuODAxMzc4XSAgYnRtdGtfdXNiX3N1c3BlbmQrMHgyMC8weDM4IFtidG10aw0KPiA1
ZjIwMGE5N2JhZGJkZmRhNDI2Njc3M2ZlZTQ5YWNmYzhlMDIyNGQ1XQ0KPiBbICAgIDYuODA5NTc4
XSAgYnR1c2Jfc3VzcGVuZCsweGQwLzB4MjEwIFtidHVzYg0KPiAwYmZiZjE5YTg3ZmY0MDZjODNi
ODcyNjhiODdjZTFlODBlOWE4MjliXQ0KPiBbICAgIDYuODE3NTI3XSAgdXNiX3N1c3BlbmRfYm90
aCsweDkwLzB4Mjg4DQo+IFsgICAgNi44MjE0NjldICB1c2JfcnVudGltZV9zdXNwZW5kKzB4M2Mv
MHhhOA0KPiBbICAgIDYuODI1NTg1XSAgX19ycG1fY2FsbGJhY2srMHg1MC8weDFmMA0KPiBbICAg
IDYuODI5MzUxXSAgcnBtX2NhbGxiYWNrKzB4NzAvMHg4OA0KPiBbICAgIDYuODMyODU2XSAgcnBt
X3N1c3BlbmQrMHhlNC8weDVhMA0KPiBbICAgIDYuODM2MzYxXSAgcG1fcnVudGltZV93b3JrKzB4
ZDQvMHhlMA0KPiBbICAgIDYuODQwMTI2XSAgcHJvY2Vzc19vbmVfd29yaysweDE4Yy8weDQ0MA0K
PiBbICAgIDYuODQ0MTU2XSAgd29ya2VyX3RocmVhZCsweDMxNC8weDQyOA0KPiBbICAgIDYuODQ3
OTIzXSAga3RocmVhZCsweDEyOC8weDEzOA0KPiBbICAgIDYuODUxMTY3XSAgcmV0X2Zyb21fZm9y
aysweDEwLzB4MjANCj4gWyAgICA2Ljg1NDc2OV0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFn
aW5nIHJlcXVlc3QgYXQgdmlydHVhbA0KPiBhZGRyZXNzIGZmZmZmZmZmZmZmZmZmZDgNCj4gWyAg
ICA2Ljg2MjY5NF0gTWVtIGFib3J0IGluZm86DQo+IFsgICAgNi44NjU0OTRdICAgRVNSID0gMHgw
MDAwMDAwMDk2MDAwMDA2DQo+IFsgICAgNi44NjkyNDldICAgRUMgPSAweDI1OiBEQUJUIChjdXJy
ZW50IEVMKSwgSUwgPSAzMiBiaXRzDQo+IFsgICAgNi44NzQ1NzFdICAgU0VUID0gMCwgRm5WID0g
MA0KPiBbICAgIDYuODc3NjMyXSAgIEVBID0gMCwgUzFQVFcgPSAwDQo+IFsgICAgNi44ODA3ODBd
ICAgRlNDID0gMHgwNjogbGV2ZWwgMiB0cmFuc2xhdGlvbiBmYXVsdA0KPiBbICAgIDYuODg1NjY1
XSBEYXRhIGFib3J0IGluZm86DQo+IFsgICAgNi44ODg1NTNdICAgSVNWID0gMCwgSVNTID0gMHgw
MDAwMDAwNiwgSVNTMiA9IDB4MDAwMDAwMDANCj4gWyAgICA2Ljg5NDA0NF0gICBDTSA9IDAsIFdu
UiA9IDAsIFRuRCA9IDAsIFRhZ0FjY2VzcyA9IDANCj4gWyAgICA2Ljg5OTEwM10gICBHQ1MgPSAw
LCBPdmVybGF5ID0gMCwgRGlydHlCaXQgPSAwLCBYcyA9IDANCj4gWyAgICA2LjkwNDQyM10gc3dh
cHBlciBwZ3RhYmxlOiA0ayBwYWdlcywgNDgtYml0IFZBcywNCj4gcGdkcD0wMDAwMDAwMDQyNTMz
MDAwDQo+IFsgICAgNi45MTExMzRdIFtmZmZmZmZmZmZmZmZmZmQ4XSBwZ2Q9MDAwMDAwMDAwMDAw
MDAwMCwNCj4gcDRkPTAwMDAwMDAwNDJlOTQwMDMsIHB1ZD0wMDAwMDAwMDQyZTk1MDAzLCBwbWQ9
MDAwMDAwMDAwMDAwMDAwMA0KPiBsYXZbICAgIDYuOTIxNzgxXSBJbnRlcm5hbCBlcnJvcjogT29w
czogMDAwMDAwMDA5NjAwMDAwNiBbIzFdIFBSRUVNUFQNCj4gU01QDQo+IFsgICAgNi45MjE3OTRd
IE1vZHVsZXMgbGlua2VkIGluOiBtdDc5MjFlIG10NzkyMV9jb21tb24gbXQ3OTJ4X2xpYg0KPiBt
dDc2X2Nvbm5hY19saWIgbXQ3NiBtdGtfdmNvZGVjX2RlY19odyBtYWM4MDIxMSBjcm9zX2VjX2xp
ZF9hbmdsZQ0KPiBjcm9zX2VjX3NlbnNvcnMgY3Jvc19lY19zZW5zb3JzX2NvcmUgaW5kdXN0cmlh
bGlvX3RyaWdnZXJlZF9idWZmZXINCj4gY2ZnODAyMTEga2ZpZm9fYnVmIG10a192Y29kZWNfZGVj
IG10a19qcGVnIHY0bDJfdnA5IGNyb3NfZWNfcnBtc2cNCj4gbXRrX3Zjb2RlY19lbmMgdjRsMl9o
MjY0IG10a19qcGVnX2VuY19odyBidHVzYiBtdGtfdmNvZGVjX2RiZ2ZzDQo+IG10a19qcGVnX2Rl
Y19odyBtdGtfZHAgbXRrX3Zjb2RlY19jb21tb24gYnRpbnRlbCBidGJjbSB1dmN2aWRlbyBidG10
aw0KPiBtdGtfbWRwMyB2aWRlb2J1ZjJfdm1hbGxvYyB2NGwyX21lbTJtZW0gYnRydGwgdXZjIGpv
eWRldg0KPiB2aWRlb2J1ZjJfdjRsMiB2aWRlb2J1ZjJfZG1hX2NvbnRpZyBibHVldG9vdGggZWxh
bl9pMmMNCj4gdmlkZW9idWYyX21lbW9wcyBlY2RoX2dlbmVyaWMgZWNjIHZpZGVvYnVmMl9jb21t
b24gY3Jvc19lY19zZW5zb3JodWINCj4gY3Jvc19rYmRfbGVkX2JhY2tsaWdodCBtdGtfc2NwIHNu
ZF9zb2ZfbXQ4MTk1IHBjaWVfbWVkaWF0ZWtfZ2VuMw0KPiBtdGtfcnBtc2cgbXRrX3N2cyBtdGtf
YWRzcF9jb21tb24gc25kX3NvZl94dGVuc2FfZHNwIHJwbXNnX2NvcmUNCj4gbHZ0c190aGVybWFs
IHNuZF9zb2Zfb2YgbXRrX3NjcF9pcGkgc25kX3NvY19tdDgxOTVfYWZlIHNuZF9zb2YNCj4gc25k
X3NvZl91dGlscyBtdGtfd2R0IG10NjU3N19hdXhhZGMgbXQ4MTk1X210NjM1OQ0KPiBbICAgIDYu
OTIyMDg3XSBDUFU6IDMgVUlEOiAwIFBJRDogMTA0IENvbW06IGt3b3JrZXIvMzoxIE5vdCB0YWlu
dGVkDQo+IDYuMTAuMC1uZXh0LTIwMjQwNzE1ICMxIDM1ODkzMjAyY2E4Zjk5YjM3MTI5OTk3ODIx
NDQxYTI5ZDJiMjNmMGENCj4gWyAgICA2LjkyMjEwNl0gSGFyZHdhcmUgbmFtZTogQWNlciBUb21h
dG8gKHJldjIpIGJvYXJkIChEVCkNCj4gWyAgICA2LjkyMjExNF0gV29ya3F1ZXVlOiBwbSBwbV9y
dW50aW1lX3dvcmsNCj4gWyAgICA2LjkyMjEzMl0gcHN0YXRlOiA4MDQwMDBjOSAoTnpjdiBkYUlG
ICtQQU4gLVVBTyAtVENPIC1ESVQgLVNTQlMNCj4gQlRZUEU9LS0pDQo+IFsgICAgNi45MjIxNDdd
IHBjIDogdXNiX2tpbGxfYW5jaG9yZWRfdXJicysweDZjLzB4MWUwDQo+IFsgICAgNi45MjIxNjRd
IGxyIDogdXNiX2tpbGxfYW5jaG9yZWRfdXJicysweDQ4LzB4MWUwDQo+IFsgICAgNi45MjIxODFd
IHNwIDogZmZmZjgwMDA4MDkwM2I2MA0KPiBbICAgIDYuOTIyMTg3XSB4Mjk6IGZmZmY4MDAwODA5
MDNiNjAgeDI4OiBmZmZmMmM3Yjg1YzMyYjgwIHgyNzoNCj4gZmZmZjJjN2JiYjM3MDkzMA0KPiBb
ICAgIDYuOTIyMjExXSB4MjY6IDAwMDAwMDAwMDAwZjQyNDAgeDI1OiAwMDAwMDAwMGZmZmZmZmZm
IHgyNDoNCj4gZmZmZmQ0OWVjZTJkY2I0OA0KPiBbICAgIDYuOTIyMjMzXSB4MjM6IDAwMDAwMDAw
MDAwMDAwMDEgeDIyOiBmZmZmMmM3Yjg2NTVmNjYwIHgyMToNCj4gZmZmZjJjN2I4NjU1ZjYyOA0K
PiBbICAgIDYuOTIyMjU1XSB4MjA6IGZmZmZmZmZmZmZmZmZmZDggeDE5OiAwMDAwMDAwMDAwMDAw
MDAwIHgxODoNCj4gMDAwMDAwMDAwMDAwMDAwNg0KPiBbICAgIDYuOTIyMjc2XSB4MTc6IDY1MzE2
NTYzMzczODYyMzggeDE2OiAzNjMyMzczODYyMzMzODYzIHgxNToNCj4gZmZmZjgwMDA4MDkwMzQ4
MA0KPiBbICAgIDYuOTIyMjk3XSB4MTQ6IDAwMDAwMDAwMDAwMDAwMDAgeDEzOiAzMDMyNzgzMDJm
MzAzMTc4IHgxMjoNCj4gZmZmZmQ0OWVjZjA5MGUzMA0KPiBbICAgIDYuOTIyMzE4XSB4MTE6IDAw
MDAwMDAwMDAwMDAwMDEgeDEwOiAwMDAwMDAwMDAwMDAwMDAxIHg5IDoNCj4gZmZmZmQ0OWVjZDJj
NWJiNA0KPiBbICAgIDYuOTIyMzM5XSB4OCA6IGMwMDAwMDAwZmZmZmRmZmYgeDcgOiBmZmZmZDQ5
ZWNlZmUwZGI4IHg2IDoNCj4gMDAwMDAwMDAwMDBhZmZhOA0KPiBbICAgIDYuOTIyMzYwXSB4NSA6
IGZmZmYyYzdiYmIzNWRkNDggeDQgOiAwMDAwMDAwMDAwMDAwMDAwIHgzIDoNCj4gMDAwMDAwMDAw
MDAwMDAwMA0KPiBbICAgIDYuOTIyMzc5XSB4MiA6IDAwMDAwMDAwMDAwMDAwMDAgeDEgOiAwMDAw
MDAwMDAwMDAwMDAzIHgwIDoNCj4gZmZmZmZmZmZmZmZmZmZkOA0KPiBbICAgIDYuOTIyNDAwXSBD
YWxsIHRyYWNlOg0KPiBbICAgIDYuOTIyNDA1XSAgdXNiX2tpbGxfYW5jaG9yZWRfdXJicysweDZj
LzB4MWUwDQo+IFsgICAgNi45MjI0MjJdICBidG10a191c2Jfc3VzcGVuZCsweDIwLzB4MzggW2J0
bXRrDQo+IDVmMjAwYTk3YmFkYmRmZGE0MjY2NzczZmVlNDlhY2ZjOGUwMjI0ZDVdDQo+IFsgICAg
Ni45MjI0NDRdICBidHVzYl9zdXNwZW5kKzB4ZDAvMHgyMTAgW2J0dXNiDQo+IDBiZmJmMTlhODdm
ZjQwNmM4M2I4NzI2OGI4N2NlMWU4MGU5YTgyOWJdDQo+IFsgICAgNi45MjI0NjldICB1c2Jfc3Vz
cGVuZF9ib3RoKzB4OTAvMHgyODgNCj4gWyAgICA2LjkyMjQ4N10gIHVzYl9ydW50aW1lX3N1c3Bl
bmQrMHgzYy8weGE4DQo+IFsgICAgNi45MjI1MDddICBfX3JwbV9jYWxsYmFjaysweDUwLzB4MWYw
DQo+IFsgICAgNi45MjI1MjNdICBycG1fY2FsbGJhY2srMHg3MC8weDg4DQo+IFsgICAgNi45MjI1
MzhdICBycG1fc3VzcGVuZCsweGU0LzB4NWEwDQo+IFsgICAgNi45MjI1NTNdICBwbV9ydW50aW1l
X3dvcmsrMHhkNC8weGUwDQo+IFsgICAgNi45MjI1NjldICBwcm9jZXNzX29uZV93b3JrKzB4MThj
LzB4NDQwDQo+IFsgICAgNi45MjI1ODhdICB3b3JrZXJfdGhyZWFkKzB4MzE0LzB4NDI4DQo+IFsg
ICAgNi45MjI2MDZdICBrdGhyZWFkKzB4MTI4LzB4MTM4DQo+IFsgICAgNi45MjI2MjFdICByZXRf
ZnJvbV9mb3JrKzB4MTAvMHgyMA0KPiBbICAgIDYuOTIyNjQ0XSBDb2RlOiBmMTAwYTI3NCA1NDAw
MDUyMCBkNTAzMjAxZiBkMTAwYTI2MCAoYjgzNzAwMDApDQo+IFsgICAgNi45MjI2NTRdIC0tLVsg
ZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiBhLTE0OFsgICAgNy4yMDM5MTBdIEtl
cm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBPb3BzOiBGYXRhbCBleGNlcHRpb24NCj4gWyAgICA3
LjIwOTY0OV0gU01QOiBzdG9wcGluZyBzZWNvbmRhcnkgQ1BVcw0KPiBbICAgIDcuMjEzNzEzXSBL
ZXJuZWwgT2Zmc2V0OiAweDU0OWU0YzQwMDAwMCBmcm9tIDB4ZmZmZjgwMDA4MDAwMDAwMA0KPiBb
ICAgIDcuMjE5Nzk2XSBQSFlTX09GRlNFVDogMHhmZmYwZDM4NTgwMDAwMDAwDQo+IFsgICAgNy4y
MjM5NjldIENQVSBmZWF0dXJlczogMHgwNCwwMDAwMDAwYiw4MDE0MDUyOCw0MjAwNzIwYg0KPiBb
ICAgIDcuMjI5MzYwXSBNZW1vcnkgTGltaXQ6IG5vbmUNCj4gDQo+IEZ1bGwga2VybmVsIGxvZzog
DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vMHgwLnN0L1g5cngudHh0X187
ISFDVFJOS0E5d01nMEFSYnchZ19VbGVPSDZDNUFkWm9LRVZva28zZXdiNnpLQ2NXZkRHZnczdTZM
Vl94M0pDU1Q3V252TXJBek03d1AwQTRXa2lXNHYwRU01M3dqZjhlbDFnWFdmcUEkDQo+ICANCj4g
Q29uZmlnOiANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly8weDAuc3QvWDly
Mi50eHRfXzshIUNUUk5LQTl3TWcwQVJidyFnX1VsZU9INkM1QWRab0tFVm9rbzNld2I2ektDY1dm
REdmdzN1NkxWX3gzSkNTVDdXbnZNckF6TTd3UDBBNFdraVc0djBFTTUzd2pmOGVuUEdKTjFzZyQN
Cj4gIA0KPiANCj4gI3JlZ3pib3QgaW50cm9kdWNlZDogZWU2YmQ0Yjk1YzY2DQo+ICNyZWd6Ym90
IHRpdGxlOiB1c2Jfa2lsbF9hbmNob3JlZF91cmJzIHBhbmljIGR1cmluZyBib290IG9uIG10ODE5
NS0NCj4gY2hlcnJ5LXRvbWF0by1yMg0KPiANCj4gVGhhbmtzLA0KPiBOw61jb2xhcw0K
