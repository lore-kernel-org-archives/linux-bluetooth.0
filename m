Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F6138DC75;
	Fri, 16 Oct 2026 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140708; cv=fail; b=eBuLv551dIGvNvOQDyAcaLPCDFefF1UWMAivZSE1uhWvFwCLAYr+dCyAbUcBAk27mrwJe5XtP7ixorOIXnB/W9IutHrgQokoQaJgze5SiSNT2RuM7UNnz865XuqlA1sH4x+1pQorej76PtkFm60h7dCTceZ4vojciVro5zVaaUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140708; c=relaxed/simple;
	bh=GQbf7qBuCKP2ZnLM7KTqarvaN2XxJUnoIOHJ6rfm1AE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JNil6R4mbhWo7xrykolj6NKke1Cq/3ALA5dX4K7a/gpoB+InjFKwuQBsZA7+X2BiYpR5sEPgQmRWJLVFygb+RrYNvFiPl4rimySIg3lkhIUzdd+QvAZKEPTQ4jTk3xHBjy9IC5KyDUSfOHyO9GMXzK2Xpn+9P4a1408LiF0gFzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Wwa2Xp2u; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Qxzmz/oE; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Wwa2Xp2u";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Qxzmz/oE"
X-UUID: c7f29ce4c93e11f18dc8c9802ae25ab1-20261016
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GQbf7qBuCKP2ZnLM7KTqarvaN2XxJUnoIOHJ6rfm1AE=;
	b=Wwa2Xp2u//h1B4JMTUv9s1ABdeLaoz8WS02Q6GqiUZa9BqThrvF/SgmqEbruVGZ2u0Yc4f3MTYNO55n+Tg6JCNfk/dHSp4w3KrPGijwP2pDm0p11e+2BwBM9xgRYKY6RFsvYfEEI/SQK7ekbWHm5eivbWXv/f6dSewIYGdaubmE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:10da8c22-6e52-495e-b973-ecf76c7c65a3,IP:0,U
	RL:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:12
X-CID-META: VersionHash:291e20b,CLOUDID:ad99d174-1cd7-46d4-8ea9-dde309ceb772,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:11|82|106|99|80|1,File:130,RT:0,Bulk:
	nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c7f29ce4c93e11f18dc8c9802ae25ab1-20261016
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 779956486; Fri, 16 Oct 2026 16:51:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Oct 2026 16:51:29 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 16 Oct 2026 16:51:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mu9Cu4clyEwKVpCjyuEqcjKNctRQOnNnAhF14hSsm+gix27tGyfwU7D5iTtDzPuG08IAlVhHbAbTGjstMIdDjx0Fcs8AyjBg7IinlEAUIq1kkXy8a6sDRiABE82eAzPYn8cpKfIk808K/WbIOh7hZ41DM2QqS3tA9d1wZ/f0n8BqRwxe4KuVH15eOovCVWzGbl+FPOps1aXay0Dk78Edl+Ne6wOClf3IW9YqH1svq8b/QrVkTwsNJVzadIivO5ULWpZMj36usumopJayJHNlDE41S4psTvo4sD0AA2KEvmrX5zepA8XEWAxKL83jdhT8T7AtjM/uXj98+0pSZDWIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQbf7qBuCKP2ZnLM7KTqarvaN2XxJUnoIOHJ6rfm1AE=;
 b=RdPbz0nnyp6WsJT5bINdYrEz9GO5werMFV5KAd5qBDfIl6JjkxJ78Mh1fO27bapNS9kvYczSeOZPKfm4MDtLX7d7LUAasV9ul89gImn/VK4lsra8ZO/6XVYKujdBubZ19S5fMobUeclfpDBOxts2f6VJASu8ZJAyW4PjaauKagi4r4rntGpNN+3klgN8BYO/37DkWAHkKnn0JMJA6jqA8tLsq2+l2IVS8uKBOVrwXMGNUnsjieU2dG4FqzwqmLxdQVERNIiEPfig6cX9QbqkDQhf1oLwcYNn4j7EGkjTOSpU3rlz4n+8RFLUo3m4o3FW10r+rnsYwydplGVC9uxB3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQbf7qBuCKP2ZnLM7KTqarvaN2XxJUnoIOHJ6rfm1AE=;
 b=Qxzmz/oE0b6dD7Pc06pt5BZHqN97Ak0pz1wMMLgC3DDZzB/CIYmWomHnjFhCuhZT4g5sGt/8mytGHW2EmmKvEsdPyrvg+NU5xYJg8qH2jbV6lugjEBPHML+mXB0QlprbTOIIW6jIlaGR5TJhjPBrxfp0fxVnMbvNnZSZDr6+1kY=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by SEZPR03MB8382.apcprd03.prod.outlook.com (2603:1096:101:21f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 08:51:24 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 08:51:23 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: =?utf-8?B?SGFvIFFpbiAo56em5rWpKQ==?= <Hao.Qin@mediatek.com>,
	=?utf-8?B?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
	=?utf-8?B?V2VubG9uZyBUaWFuICjnlLDmlofpvpkp?= <ot_wenlong.tian@mediatek.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	=?utf-8?B?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, Sean Wang
	<Sean.Wang@mediatek.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 0/3] Bluetooth: btmtk: fix ISO data reception
Thread-Topic: [PATCH v2 0/3] Bluetooth: btmtk: fix ISO data reception
Thread-Index: AQHdXH1KX8Q8ppm+F0GvX/curuRmk7b+nocAgAE/hwA=
Date: Fri, 16 Oct 2026 08:51:23 +0000
Message-ID: <f20a81c09df8dbf766608204405edf489074ecd0.camel@mediatek.com>
References: <20261015081450.1241194-1-chris.lu@mediatek.com>
	 <CABBYNZKaRo1SLa33mWwxE0Vp+3Wd=tJpvTFru-q8uraysdw4Qw@mail.gmail.com>
In-Reply-To: <CABBYNZKaRo1SLa33mWwxE0Vp+3Wd=tJpvTFru-q8uraysdw4Qw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|SEZPR03MB8382:EE_
x-ms-office365-filtering-correlation-id: 113c418c-f383-4c79-01f4-08df2b62a831
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|3023799007|4133799003;
x-microsoft-antispam-message-info: z9cksizGXx5ucKe2WtYskv+IsaODmAAd02YooV2jXIBapN9cgv7JYQUemtrPwsSGc2CXBJw3OaVt1PRUIvJJpf3qvetdBo1IqF9+WF1yJEPGvPy4SVrerVVCnJYNIXroa6EhiSZ7gFV/Ep8EcdlaMjyUMyZNbG1jgHQyaJNiWVi9SwoBhhIgO1hSEs3W2as683MUN69XwcrhJjbyqnQR5k7sIzyKZanxJlvm0OlcW24AXfhEJQZ+7zMdndP3m9jOedI4nf5Bjg/KAW+Nj4ZzTPJSjItJ9L4xU8BUK/RI8YHCCyIDSIwpR6XE5zYSRQs+0iEp7CDbbfT92IGRw/gSF1h+bse1z+57ZmXk8RbQQZ9IO/9FkXmtLLH1jM+rciayLKvOXfHW5kiEXT3eCtDtO0/OIf8W6P+hM9qEeMVMUXnG8jC3Ztlcs1SvobdT3gr9KUbnOU5HsnP+3GhNUIhT0O0fz0sy2rWC9uFU4zs9IzwvPifBdRfBNxONyV8X7V92Kc9ofA1C66qBGVuBied8Jp6EQ2VlHWeuWx3JBfY5+Fgi2hqhJDlubYVUDD6NWRaM/0oNufgWK9jqKgeOj7uErrWpBWi7dsAOjqs4osqCeW3rvEMsn98a8Oi/UjAALV0W6SISRhpBEYnCVkHZIRS8hHidZv2VRLjFhQtGPZSBawU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007)(4133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE5ZWTVPWmpPYXJMTzVjc2lEME80R3ZqbEh5d0Y2N1QrL2UxWEhRa2NicGhB?=
 =?utf-8?B?NlpMZzYySU13SFVielRxcHNLdFhkSUEzNTR1Zktxb0E0VTV3WTBaVVJldFlC?=
 =?utf-8?B?MHJkTEloQm1qVTVBdGVkU3RZcjUrMVNGUkl2SzZqOUpqdjdWTnZKMjVhYi9l?=
 =?utf-8?B?Y3ZrR2ttdzd4M0RDT1FpUmlESitDT1A1VGQvZHdNaVJ1TDRrTTlsSFRnU2Ix?=
 =?utf-8?B?S2p0eWFHQ0lCTmsyNXB1Rlc0STNIVTcvS21adEFmNTFFc0JCdVNmYUhRMlRB?=
 =?utf-8?B?NTZYNk5UdHZ6NzQ1WVhvcUl5NVV0UTl6MmxVaVVqeDV6Q2VhVXk4TElwWjdB?=
 =?utf-8?B?Q2h2RDhaQ3Q5b21yVGMzaDZaZXhPb2pTZWNKNGhvQUUrRnpoSFhQdVNBcVlF?=
 =?utf-8?B?bXFQWGh6MWludGgrTWFYRmpwK1N6Wlc0WnZTa2diNzJnYmVjNWo4UUpEUWM2?=
 =?utf-8?B?Z3N3Nm85RWUyMUdodFh4OFFQSXA4a3pDT0pFNDJhTXlUbWd2Z251K0FEMW82?=
 =?utf-8?B?ck9Eejc1SXVlTkVzcERhYjlQeDk3ckgrd0EwalNmRnh1SGkzS1BYNnhtbU44?=
 =?utf-8?B?aE5jZEt2a2JXK0tVWUlxUkZzTjFUSEhSZW5IY3RlOGpFVjZkM3BDMDRLaW8w?=
 =?utf-8?B?Q29LUTl4bTcvY3BCWDhCRnpJUS8xeDRPQUZZZHRCRzEydE5NeGhqKzJKSmpZ?=
 =?utf-8?B?cWlxOEZoajh0SDlQSUIwZkYzRGk3OVRLU24zSnpFanhzS2YxT0YyQ0htUG9q?=
 =?utf-8?B?aUZ1T0VmbW9wRUEzV2RqUmlyZ2FqNVFuazhuQ2d6VUVTWUpTazhvYmx0T2VH?=
 =?utf-8?B?K3BDcVZVU0NEVDJiNDB6cG81c1lLTEtNN3U0eVQ4c1BEVEppRjlFMlZ4QUkr?=
 =?utf-8?B?RWN0WXB6WWZ2MUE3L0h2ZHRYZG9paFBHbGViU0ozQUpQUW5QNjQ5NkF1d0xK?=
 =?utf-8?B?ZDN5b0owaGpqZTQ4b1NINVBCVzU1NVZ6TWpTdUdQVmdpaTZLUEYyVFZJaEFj?=
 =?utf-8?B?UXpOTEx1VUV0NHZrRGZ2VEpQVDVUUy8ybUlzdUgraEFzdUJqYnBaZ2lDVS9R?=
 =?utf-8?B?L0hBMDVNM05VRDlTVWZCY3BmMUVOV0Y5eVVwdTNvNlo3NmYvSDV5NUMyQm16?=
 =?utf-8?B?NXhpalJUS1VBdDZtQW82ZlV3ME56MDdFSVRueS9iTk42WUtjZzFBSDR2Qlh6?=
 =?utf-8?B?ZUE4ejlUYmhieHJ5dWJEZ0tCUEh3ajNXYTRsZU9VMGE2c09aR2RJc1A3Kyts?=
 =?utf-8?B?cnl4NHVua2tXY1NOS2txdnowNEp0VG8veHU1dkdQTElVSk15aWhTcjFNK3FZ?=
 =?utf-8?B?SzhEVS9FWkxUREcxWkNMYzNydW92NEZ6RWtSb0Iza0dsUjYvZ053bTBQL0xr?=
 =?utf-8?B?NFo3dG5RQnB3WmZnTFdOYXJWMlhjMkxTZHpWTlo4MnpnOHdDeTJlNDRFdmJF?=
 =?utf-8?B?Q3pPNHJ4Q0twNC9kalQ3WjdObDlIWkRwd2VZa1drZ2x1U3E4L3NPV0dVREpz?=
 =?utf-8?B?M2plOXVXM0lQcFBJYmlhMFAzZUJBNGVjM1lZN0szRWRFeXIyMHNVNWlFcEtU?=
 =?utf-8?B?VHFGNzdUTms3OXI0eGMzL0d6R05vUFM1elgvQW1oeHJMa3A4bHdlcVFlcTBV?=
 =?utf-8?B?TGFIbUxyeXJZOWJEczMwM0trS1l1b3h2SStiNXU2ZEVqUC9KUVE5RFBDQTdV?=
 =?utf-8?B?MVhGaE9MYWptZzdJK29kcWl3bkdNN01iQk43czE2UHhUQWc5bVphRGVKODZz?=
 =?utf-8?B?dU9HRE52MzRSZVBPdGdsNWhHN0o3ODdZQnNzbDR4RUk2dVJ6a1FmZGQ3ejhV?=
 =?utf-8?B?MldjM0pXTUs5bklPSDZoTG9wRUZmbXZmaVdXZnAzWE9LMGErczc2eGRPVmh1?=
 =?utf-8?B?aFJxeDBmVjI5RjFHaUxOWi9Hd3VZcXFON1lxK0pSZm9ybHBVcE9HdkR3UW1V?=
 =?utf-8?B?bkNCN1NPczROV0V0VTM5Vm5ORWYzaWN6U01kL3RPelVxOStwUmVWUnlFZUtV?=
 =?utf-8?B?VkF0NmRGS0YvRXhDTng4QWw2QVlZdk05M1JwZmErTzRveVJmLzdiMmR2ZGcx?=
 =?utf-8?B?aDdlTk0zMDByUnI5NHg4c3BGRFQ4K0ViS2ZicWo0UCtVR0M1T1NqdXhjZ0lG?=
 =?utf-8?B?UlZDNXV4VktRWHhjWGkvQUV1RWJUcE9DeDQ0Q2htWXhYNEdEOUhyQW02eWhS?=
 =?utf-8?B?aVRkZHJ1RS90djk0em5Qd2JIWW5vTW8xRzAvRVk2UStDTENLbGQrUFFuQ2hK?=
 =?utf-8?B?YnV6OTA5TlozNFVtdEhjVzBQbTh5Tit4VnR0M2pMMUxkcDVJeVkxaWxXdW40?=
 =?utf-8?B?VUx6eEQrU1Y1V1VSOFRZUTdUVXRLVVB6V2N3VXVCcE5GQUZWcnVVdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24649A5385706D48BA0EF14837D20CCE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f3joR4PiuLyjxfdwn+1QHc2a7Jd35m3aObdnNRJYr7wTNf6HNyX5q8vrJ7v3PZHERYr/GgtIIBXecFH8sq8m3K6dpU/nNWVhXqpNduLchBYrqUv9krmvzSUI9Q8coxcrhRl8t0ngl8oqF4qEYgIUtU56ogIAFQIyKWMquBVJmwkfpDo/qYZqsd29yubo0Cj7M33usRsigLuG/wsoz6CP90y0/+HX7l0+tFPRAl9ttGCzAU947kXiGHpNVy8Ep8GrCRwEhsaRM441BebHabi8/dOqF3cMM6KW/1ixqWHCBClosYAgNFYMVe+WEtIpAp3/ywS/FxrZknXlB9FJa1MqXg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113c418c-f383-4c79-01f4-08df2b62a831
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 08:51:23.7914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWEqiFqMEEtwJklreHoC1yKM8/KdTbbTD4UveNInoHv/m0k7V66jKlL/XbcQM3a0ZOdX/dH9R3TQuR1RWxerPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8382

SGkgTHVpeiwNCg0KVGhhbmtzIGZvciByZW1pbmRlciBhbmQgcmV2aWV3LCBJJ3ZlIHNlZW4gU2Fz
aGlrbydzIGZlZWRiYWNrIGFuZCBqdXN0DQphYm91dCB0byBkaXNjdXNzIHdpdGggeW91Lg0KDQpP
biBUaHUsIDIwMjYtMTAtMTUgYXQgMDk6NDcgLTA0MDAsIEx1aXogQXVndXN0byB2b24gRGVudHog
d3JvdGU6DQo+IEhpIENocmlzLA0KPiANCj4gT24gVGh1LCBPY3QgMTUsIDIwMjYgYXQgNDoxNeKA
r0FNIENocmlzIEx1IDxjaHJpcy5sdUBtZWRpYXRlay5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+
IFRocmVlIGZpeGVzIGZvciBJU08gZGF0YSBoYW5kbGluZyBpbiBidG10aywgZm91bmQgd2hpbGUg
ZGVidWdnaW5nDQo+ID4gTEUgQXVkaW8NCj4gPiBvbiBNVDc5MjUuIFRoZSBjb2RlIGlzIHNoYXJl
ZCBieSBldmVyeSBNZWRpYVRlayBVU0IgY29udHJvbGxlciB0aGF0DQo+ID4gc3VwcG9ydHMgSVNP
IGRhdGEsIHNvIG5vbmUgb2YgdGhpcyBpcyBzcGVjaWZpYyB0byB0aGF0IHBhcnQuDQo+ID4gDQo+
ID4gUGF0Y2ggMSBkcm9wcyB0aGUgemVybyBwYWRkaW5nIHRoYXQgdGhlIElTTyBpbnRlcnJ1cHQg
SU4gZW5kcG9pbnQNCj4gPiBhcHBlbmRzDQo+ID4gdG8gZWFjaCB0cmFuc2ZlciBpbnN0ZWFkIG9m
IHBhcnNpbmcgaXQgYXMgSVNPIHBhY2tldHMuIFRoZSBkcml2ZXINCj4gPiB0dXJucw0KPiA+IHRo
YXQgcGFkZGluZyBpbnRvIGhhbmRsZSAwIHBhY2tldHMgd2l0aCBhIERhdGFfVG90YWxfTGVuZ3Ro
IG9mIHplcm8NCj4gPiBhbmQNCj4gPiBoYW5kcyB0aGVtIHRvIHRoZSBzdGFjaywgd2hpY2ggaXMg
d2hhdCBmaWxscyB0aGUgSENJIGxvZyB3aXRoDQo+ID4gbWFsZm9ybWVkDQo+ID4gSVNPIGZyYW1l
cywgYW5kIGEgdmFsaWQgU0RVIGlzIGxvc3Qgd2hlbmV2ZXIgaGFuZGxlIDAgYmVsb25ncyB0byBh
DQo+ID4gbGl2ZQ0KPiA+IENJUy9CSVMuDQo+ID4gDQo+ID4gUGF0Y2ggMiBib3VuZHMgRGF0YV9U
b3RhbF9MZW5ndGggYnkgaGRldi0+aXNvX210dS4gVGhlIGV4aXN0aW5nDQo+ID4gc2tiX3RhaWxy
b29tKCkgdGVzdCBlbmZvcmNlcyBubyBwcm90b2NvbCBsaW1pdCwgYmVjYXVzZSB0aGUgc2tiDQo+
ID4gaGVhZA0KPiA+IGFsbG9jYXRpb24gaXMgcm91bmRlZCB1cCB0byBhIGttYWxsb2MgYnVja2V0
IGFuZCBza2JfdGFpbHJvb20oKQ0KPiA+IHJlcG9ydHMNCj4gPiB0aGUgYnVja2V0IHNpemUgcmF0
aGVyIHRoYW4gd2hhdCB3YXMgcmVxdWVzdGVkLg0KPiA+IA0KPiA+IFBhdGNoIDMgdXBkYXRlcyB0
aGUgbXQ3OXh4IElTTyBkYXRhIHRyYW5zbWlzc2lvbiBzZXR0aW5nLg0KPiA+IA0KPiA+IFRoZSB0
aHJlZSBodW5rcyBkbyBub3Qgb3ZlcmxhcCwgc28gYW55IHByZWZpeCBvZiB0aGUgc2VyaWVzIGFw
cGxpZXMNCj4gPiBvbiBpdHMNCj4gPiBvd24uDQo+ID4gDQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4g
PiAtIFBhdGNoIDIgcmV3b3JrZWQgYW5kIHJldGl0bGVkLiB2MSBvbmx5IGVubGFyZ2VkIHRoZSBy
ZWNlaXZlIHNrYiwNCj4gPiB3aGljaA0KPiA+IMKgIHR1cm5lZCBvdXQgdG8gYmUgYSBuby1vcCwg
YW5kIGFkZGVkIG5vIGJvdW5kIGF0IGFsbC4gdjIgYm91bmRzDQo+ID4gwqAgRGF0YV9Ub3RhbF9M
ZW5ndGggYnkgaGRldi0+aXNvX210dSBhbmQgc2l6ZXMgdGhlIHNrYiBmcm9tIHRoZQ0KPiA+IHNh
bWUNCj4gPiDCoCB2YWx1ZS4NCj4gPiAtIFBhdGNoIDMgYWRkZWQuDQo+ID4gLSBQYXRjaCAxIHVu
Y2hhbmdlZC4NCj4gPiANCj4gPiBCYXNlZCBvbiBibHVldG9vdGgtbmV4dC4NCj4gPiANCj4gPiBD
aHJpcyBMdSAoMyk6DQo+ID4gwqAgQmx1ZXRvb3RoOiBidG10azogZHJvcCB6ZXJvLWxlbmd0aCBJ
U08gcGFja2V0cyBmcm9tIGVuZHBvaW50DQo+ID4gcGFkZGluZw0KPiA+IMKgIEJsdWV0b290aDog
YnRtdGs6IGJvdW5kIHRoZSBJU08gcGF5bG9hZCBsZW5ndGggYnkgdGhlDQo+ID4gY29udHJvbGxl
cidzIE1UVQ0KPiA+IMKgIEJsdWV0b290aDogYnRtdGs6IGRlcml2ZSB0aGUgZmlybXdhcmUgSVNP
IHNldHRpbmcgZnJvbQ0KPiA+IMKgwqDCoCBNVEtfSVNPX1RIUkVTSE9MRA0KPiA+IA0KPiA+IMKg
ZHJpdmVycy9ibHVldG9vdGgvYnRtdGsuYyB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tDQo+ID4gLS0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IC0tDQo+ID4gMi40NS4yDQo+ID4gDQo+IA0KPiBJ
biBjYXNlIHlvdSBoYXZlbid0IHNlZW4gaXQgc2FzaGlrbyBmbGFnZ2VkIGEgcHJvYmxlbSB3aXRo
IHRoaXMgc2V0Og0KPiANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vc2Fz
aGlrby5kZXYvKi9wYXRjaHNldC8yMDI2MTAxNTA4MTQ1MC4xMjQxMTk0LTEtY2hyaXMubHUqNDBt
ZWRpYXRlay5jb21fXztJeVUhIUNUUk5LQTl3TWcwQVJidyFtWWRzcWVON19ZQkg0Ym0zeTVBVng3
cE5nOFZmM1BDZWpXZWp5aWw5NDVkdmVaVXMyaVlvaHJCdWppVS1BbE9lclVlUXVUTWRVcHU2VUtP
WEtSWSQNCj4gwqANCj4gDQo+IFVuc3VjY2Vzc2Z1bCBwYWNrZXRzIHNoYWxsIHN0aWxsIGJlIGRl
bGl2ZXJlZCB0byB0aGUgaG9zdCwgdGhpcyBpcw0KPiB1c2VkLCBmb3IgZXhhbXBsZSwgdG8gaW1w
bGVtZW50IFBhY2tldCBMb3NzIENvbmNlYWxtZW50IChQTEMpIGxvZ2ljLg0KPiANCg0KQWdyZWVk
LCBhbmQgdGhhdCBpcyB3aHkgdGhlIGNvbmRpdGlvbiBoZXJlIGlzIERhdGFfVG90YWxfTGVuZ3Ro
ID09IDANCnJhdGhlciB0aGFuIElTT19TRFVfTGVuZ3RoID09IDA6DQoNCi11bnN1Y2Nlc3NmdWwg
U0RVIDogRGF0YV9Ub3RhbF9MZW5ndGggPSA0ICg4IHdpdGggVFMpLCBJU09fU0RVX0xlbmd0aCA9
DQowDQotZW5kcG9pbnQgcGFkZGluZyA6IERhdGFfVG90YWxfTGVuZ3RoID0gMCwgbm8gSVNPX0Rh
dGFfTG9hZCBhdCBhbGwNCg0KQW4gdW5zdWNjZXNzZnVsIHBhY2tldCBjYXJyaWVzIGl0cyBQYWNr
ZXRfU3RhdHVzX0ZsYWcgaW5zaWRlIHRoZQ0KSVNPX0RhdGFfTG9hZCwgYWxvbmdzaWRlIHRoZSBQ
YWNrZXRfU2VxdWVuY2VfTnVtYmVyIGFuZCBJU09fU0RVX0xlbmd0aCwNCnNvIGl0IHN0aWxsIGhh
cyBhIERhdGFfVG90YWxfTGVuZ3RoIG9mIDQgZXZlbiB3aGVuIHRoZSBTRFUgaXRzZWxmIGlzDQpl
bXB0eS4gVGhhdCBpcyB3aGF0IHJlYWNoZXMgdGhlIHNvY2tldCB0b2RheTogaXNvX3JlY3YoKSBw
dWxscw0KSENJX0lTT19EQVRBX0hEUl9TSVpFLCB0aGVuIGRlcml2ZXMgSVNPX1NEVV9MZW5ndGgg
dmlhDQpoY2lfaXNvX2RhdGFfbGVuKCkgYW5kIHRoZSBQYWNrZXRfU3RhdHVzX0ZsYWcgdmlhIGhj
aV9pc29fZGF0YV9mbGFncygpDQpmcm9tIHRoYXQgc2FtZSBzbGVuIGZpZWxkLCBzZWVzIGxlbiA9
PSBza2ItPmxlbiA9PSAwLCBhbmQgZGVsaXZlcnMgYQ0KemVyby1sZW5ndGggc2tiIHdpdGggaGNp
X3NrYl9wa3Rfc3RhdHVzKCkgc2V0LCB3aGljaCBhZl9ibHVldG9vdGguYw0KcGFzc2VzIHVwIGFz
IEJUX1NDTV9QS1RfU1RBVFVTLiBUaGlzIHBhdGNoIGRvZXMgbm90IHRvdWNoIGFueQ0Kb2YgdGhh
dCwgc28gUExDIGtlZXBzIGdldHRpbmcgaXRzIGluZGljYXRpb25zLg0KDQpXaGF0IHRoaXMgcGF0
Y2ggZHJvcHMgaXMgdGhlIHNlY29uZCBsaW5lOiBhIHBhY2tldCB3aXRoIG5vDQpJU09fRGF0YV9M
b2FkIGF0IGFsbC4gSXQgY2Fubm90IGNhcnJ5IGEgUGFja2V0X1N0YXR1c19GbGFnLCBzaW5jZSB0
aGUNCmZvdXIgb2N0ZXRzIGhvbGRpbmcgaXQgYXJlIHNpbXBseSBub3QgdGhlcmUsIHNvIGl0IGNh
bm5vdCBleHByZXNzIGFuDQp1bnN1Y2Nlc3NmdWwgcGFja2V0IGluIHRoZSBmaXJzdCBwbGFjZS4N
Cg0KVGhlIHJlYXNvbiB0aGlzIGlzIGhhbmRsZWQgaW4gdGhlIGRyaXZlciBpcyBob3cgTWVkaWFU
ZWsgY29udHJvbGxlcnMNCnRyYW5zcG9ydCBJU08gZGF0YTogdGhlIElTTyBpbnRlcnJ1cHQgSU4g
ZW5kcG9pbnQgZGVsaXZlcnMgYSBmaXhlZC1zaXplDQp0cmFuc2ZlciBwZXIgY29tcGxldGlvbiBh
bmQgemVyby1maWxscyB3aGF0ZXZlciBpcyBsZWZ0IGFmdGVyIHRoZSBJU08NCnBhY2tldCBpdCBj
YXJyaWVzLiBUaGF0IHBhZGRpbmcgYmVsb25ncyB0byB0aGUgdHJhbnNmZXIgcmF0aGVyIHRoYW4g
dG8NCnRoZSBzdHJlYW0sIGFuZCBzaW5jZSBpdCBpcyBhbHdheXMgdHJhaWxpbmcsIHBhcnNpbmcg
Y2FuIHN0b3AgYXQgdGhlDQpmaXJzdCB6ZXJvLWxlbmd0aCBoZWFkZXIgaW5zdGVhZCBvZiBza2lw
cGluZyBpdCBhbmQgbG9va2luZyBmb3IgbW9yZQ0KcGFja2V0cyBiZWhpbmQgaXQuDQoNCk9uIHRo
ZSBBSSByZXZpZXcncyBvdGhlciBzdWdnZXN0aW9uLCBnYXRpbmcgdGhpcyBvbiBhIG5vbi16ZXJv
DQpjb25uZWN0aW9uIGhhbmRsZTogaGFuZGxlIDAgaXMgYSB2YWxpZCBjb25uZWN0aW9uIGhhbmRs
ZSwgc28gdGhhdCB3b3VsZA0KdHJlYXQgYSBzdHJlYW0gb24gaGFuZGxlIDAgZGlmZmVyZW50bHkg
ZnJvbSB0aGUgc2FtZSBzdHJlYW0gb24gYW55DQpvdGhlciBoYW5kbGUsIHdoaWNoIGlzIHRoZSBi
ZWhhdmlvdXIgdGhpcyBwYXRjaCByZW1vdmVzLg0KDQpJIGNhbiBtYWtlIHRoZSBjb21tZW50IHNh
eSBleHBsaWNpdGx5IHRoYXQgdW5zdWNjZXNzZnVsIHBhY2tldHMgYXJlDQpwcmVzZXJ2ZWQsIGlm
IHRoYXQgaGVscHMgdGhlIG5leHQgcmVhZGVyLg0KDQpNeSBwcmVmZXJlbmNlIGlzIHRvIGtlZXAg
dGhlIHNlcmllcyBhcyBwcm9wb3NlZCwgc2luY2UNCkRhdGFfVG90YWxfTGVuZ3RoID09IDAgYWxy
ZWFkeSBpZGVudGlmaWVzIHRoZSBwYWRkaW5nIHdpdGhvdXQNCmFtYmlndWl0eS4gSWYgeW91J2Qg
c3RpbGwgcmF0aGVyIG5vdCByZWx5IG9uIHRoYXQgY2hlY2sgYWxvbmUsIHRoZXJlIGlzDQphbm90
aGVyIHdheSB0byBjb25maXJtIHRoaXMgaXMgcGFkZGluZyByYXRoZXIgdGhhbiBpbmZlciBpdCBm
cm9tIHRoZQ0KaGVhZGVyLCBhbmQgSSdtIGdsYWQgdG8gc2VuZCBhIHYzIHdpdGggdGhhdCBpbnN0
ZWFkIGlmIHlvdSdkIHByZWZlci4NCg0KVGhhbmtzLA0KQ2hyaXMgTHUNCg==
