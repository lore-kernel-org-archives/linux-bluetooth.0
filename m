Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.170.195
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792585986;
	b=4iJH+SE1zA0OF085pQvAWcy+XG7FlvMxjhIacCG8PzkiHF/txVI1jY8x1vGbWNlUG5lu
	 2+NfLGw2y1+0FyfzrEWSZdyOs+bzJwXRUuK3t7o/Ih/lW+JCAVaqXgyNh831440IqO7dN
	 JOxHU0K78jVei90E5f60iRpoeSrAjOUzIGXs2Hxj4bueaX6MDqtezNr8CkinojdSjZigi
	 riAJfxNDSOAgQ2O457N2l9QxFWRe0qfYUbwsgkQY6NzPAMSgJbiHqC67Z7kDiMEyYbZL/
	 qktICUZrRxdLYccNj1CEaobjiWG/PS3O7erFyPd4oVQAZ+MOz2s/4hFOM9oSCAd9wYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585986;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:From:
	 To:Subject:Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID;
	bh=QRSMsVI6hMb2icfCCQMKX5TCI2we/JC1vO5Uduk/YDk=;
	b=PNg+AuJQtIrNN5Wv3DN0/MBWOSpZC2rfXJVK5xHx5yMHMpvrRDzbQd2XLDmXFuz+gNmD
	 P0voG2y974twJG5EN98+G2bW8eKBoSao48YN7whbAsaL1hI47PCrohtQsYsn8VTWtkyXS
	 pMc/Muuvl5tqEY58fh1Dsg3z9W84X7zaaQIU76GtOomk/CrtdkYAOok7sjPxZENU78alR
	 BnzEb9fgxhJ2aTMx5c13pdv0U/oytGQtKooLtqKfnsTZ+wxLyGVzxAqT7zY8xBO+Xfbp4
	 p5TMwCmPGnTgY6V8CFYiuXt2q5JpXwmbpuuQdnjiXOz5KEBMOnhBVnhhs4SJMb7/Uig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nozominetworks.com;
	spf=pass smtp.mailfrom=nozominetworks.com;
	dkim=pass header.d=nozominetworks.com header.i=@nozominetworks.com header.a=rsa-sha256 header.s=selector2 header.b=kpl0D3X5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.170.195
Received: from mx0a-00756801.pphosted.com (mx0a-00756801.pphosted.com [205.220.170.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B11606A322
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 12:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96B11606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nozominetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozominetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=nozominetworks.com header.i=@nozominetworks.com header.a=rsa-sha256 header.s=selector2 header.b=kpl0D3X5
Received: from pps.filterd (m0297686.ppops.net [127.0.0.1])
	by mx0a-00756801.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBflcJ3498940
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 05:32:54 -0700
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11023128.outbound.protection.outlook.com [52.101.83.128])
	by mx0a-00756801.pphosted.com (PPS) with ESMTPS id 4he8yhh2r3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 05:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cX+r2oQWZZvL+KNTVfsh7Lt0SJVbpIOjnUxc4W6PRVrQdAdYsIrqO5C8nP7Y6PLSOWjD8e1TkecOE+oGqJgdy25ga7SAyLRLolI3V6VOo7b3hpdL1lNIVU9dsLFvP7noHLoU+02NOTLPRHCblwjTENWH+WXQ0Ex3pmXyRSqkBOgQNufadMzr3752nr22E30pkmuodCtocuvBZFSQpjsW4iIYJ0ttM88WF/8WTaH8g9MJ6u/fbOOO7sHVz6c8uAst6am++ujWDv5nYL0g7ovhgAcCpJEhYpC6LMkY7UwhKlb3dlyHU9X++8GLiw39qmA6rVKZjnFdSnzNVmzyASGr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRSMsVI6hMb2icfCCQMKX5TCI2we/JC1vO5Uduk/YDk=;
 b=cWBCk7wWQnSwZHm2E7FEGaO/rfDcRBbs0fwBxjEQKgE9AEb1aBYQnvw6oYkHQUHp4yBJ+kUjvUa0mwdzn0ZJyeQmyEjjePztGc9L9TFsvtK92hKvY1ETG3kxYWASof8r9UpupvRsmbPjrRrAE41TsIzObjriCwtzAerehJIf0YHwM0crqc6tvx/iDQSmwIFO1/Xx2ZKtWUfHPiM7DG9u6QVAQtSAumcT2MhUXg+zcuAflmodrXXpf8ijXDzyeuC8hyfqxTnGynUW1CD3L0ykt1QcFRQSRYslpMcARET6swDjqB+e4v6nj0ixgReFjvWia31nRUnfyi6mn4famxV3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nozominetworks.com; dmarc=pass action=none
 header.from=nozominetworks.com; dkim=pass header.d=nozominetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozominetworks.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRSMsVI6hMb2icfCCQMKX5TCI2we/JC1vO5Uduk/YDk=;
 b=kpl0D3X5oGR87cWluYhMf3HyoQsf0AlyAD/Lr7nlWfxjdfGzKr4AyV3qQybWlYKa+aXbxGcLrrrD8RiIkXU/6JwYrv86g+MSQ9GroaR1kboiOQUB5P/BHHU7Zy+udDsAelAR/Bok89DlDUQpJflH87Y8ehazkdh1gS0BhMTz4K8=
Received: from BR2PPF4EC869C10.eurprd03.prod.outlook.com (2603:10a6:2d0::107)
 by AMBPR03MB11725.eurprd03.prod.outlook.com (2603:10a6:20b:75e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 12:32:51 +0000
Received: from BR2PPF4EC869C10.eurprd03.prod.outlook.com
 ([fe80::18a3:338a:c54c:c2e2]) by BR2PPF4EC869C10.eurprd03.prod.outlook.com
 ([fe80::18a3:338a:c54c:c2e2%7]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 12:32:51 +0000
From: =?iso-8859-1?Q?Alexandro_Cal=F2?= <alexandro.calo@nozominetworks.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Reported Bluez vulnerabilities 
Thread-Topic: Reported Bluez vulnerabilities 
Thread-Index: AQHdYVhK/gu7TxhNr0CXwOi7v3/Pow==
Date: Wed, 21 Oct 2026 12:32:51 +0000
Message-ID: <2DD1304A-FC44-4D84-BD11-7B76055400CB@nozominetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nozominetworks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BR2PPF4EC869C10:EE_|AMBPR03MB11725:EE_
x-ms-office365-filtering-correlation-id: d6bbe357-1c50-46ec-bf25-08df2f6f6c81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|56012099006|11063799006|10067099003|18002099003;
x-microsoft-antispam-message-info:
 /VWYSQoL0aWrECZt7E+TlATvzYl6iNgMkG7V+HudH3ipYjwNBm8rdvSWQ1obfsVNOwD+mHqQkRmsrUMUAAcP6wHGuEq8qwi76fBeCQqbeb5PGdHiFaYHKZN/qhNxkXmSnaggy/fv2XKg/p/XWWyrC2FrmW1g9AwsavqF1+f4xq+um0culs5g5ZZvN15+xlSwHuByTIReHsqooEtn8DskryHoIHrBPOKjt/nevfNp+lL2djFMj7MGH0GFKoMwj/EYUaaPRUp3kwUAJynp7kThNlpmSyECm5pKJjp8HvkSXluntmJYxKsXsGV5PJaGaW1Kz62G3o2xATbRMf4G9uDLMPnsgidzWvn+RsbFK7JydxWqEie9tDeOdBqpe2QiW0FbyGtqwwU8XnjlC330tGqduGFZ5YJnsLSk6QS+3+z8c+G0RDQtnAlj2CE6ukdmbUogrGP7cTot2uaBCUJrbe99NUsjs+rh0R7KzH8xSB2UZFUKu+FPZUbIRlfE70lAKNk13+KYSSfoolGYuAasdST47M3XON3bUiGNNRcRZyKCwS4tIYm+g4A+xifSN1pY575rqtd3p2GQFgZzEifhDOel4NKhH1cEFruzE+RE05ZNhJ1/zZP2hn9WmMMGlkscNvUwNsMezCL6cIW7bQRDsYlBu5lD6Zt75asK4U0bsI8YyJI5mAIPbFMRIPtMXsnwikuhKXs2yzr0BZOJCnIco4kI+/CyAZX9wbqpSWMD0wGtE8w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BR2PPF4EC869C10.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DzT7BOFr9/1BiuETljaYRyMP69SwlaxA7yRDQgizWHYbogRwHoQjZhXOlX?=
 =?iso-8859-1?Q?Yxzr7I4NBEdQJC1anT5VvSsHMnu4ALgeZbcI4R/DBPw5hm0PNozC68Ks0w?=
 =?iso-8859-1?Q?hmOX4+bv3wmbJmAEweq8xAbt3ZL38SJq0Gmut5e+ODqQwIX1SEF0yg2vj8?=
 =?iso-8859-1?Q?of/yEJ+2ThWO6BgBwi0MoUZjqsbja0mY5BgsCP7AZuwfKXDuxtpBhRfaLS?=
 =?iso-8859-1?Q?BMny8C8VLseilbvZUC6kwYr8IuGazjnRi2QBwpWDBkGEq9LJ/wFTht1cWU?=
 =?iso-8859-1?Q?BuCRj5QKJK1tbBNFLPklLEt0hkCROHZYTRMlF7Q/bb7inp3NGfjGMNTpiy?=
 =?iso-8859-1?Q?0HoKu8YwU7+YC4q9OD03bQSZjnAnC6NAWM8PlkFxps6ThiqzTYUSYe+Gtp?=
 =?iso-8859-1?Q?2c3wgqC6YVVweiflfNNc3ykMbV68icV4AiB9MXndUJPZm8IEat1VwpP5f0?=
 =?iso-8859-1?Q?pqoV7jRB0Qz4sj2O21rtGXhDergau9tE1YsqfVm6AM5IfPlpD8yIRMqToj?=
 =?iso-8859-1?Q?GKiONlxLelfVo4ISM6Gy9c4kVnEuOsOjdA+FUt0Wqb1zNrGrbWr12qzxt+?=
 =?iso-8859-1?Q?fROcbkGdCd0JR7BwPm1KVKeKf6aPV4CsoOJbMdLCXJAwgKjFZ/Be7EEU0Q?=
 =?iso-8859-1?Q?cCXgO9CvS2PZSK0sDM7eihJ8iIf22SySgzABpIRA3G22/R/RaZ3EN/M2ji?=
 =?iso-8859-1?Q?oDtrxkeKAng4Wnee5F4cs3V2DEH2O9GUUBrsX1j5+HwHCCEw0bkKVKK2l4?=
 =?iso-8859-1?Q?P20uivSZ8AK/VXgL2C4x4k5QErxaGIhNdzOFguyHOP8TISMSuuOT6l5ewQ?=
 =?iso-8859-1?Q?U/amU7MCI4iNSMHXfvsvKgvtRBMzDg7aUpaFkdEacUUSL79eMjFz5enyTs?=
 =?iso-8859-1?Q?kYLMUgR50BncwUD+w3iVNyfWhyaZQxz5TMHWvfaX1P6puinw7Li2yxMDNW?=
 =?iso-8859-1?Q?JC1A98wyHNtLXH0X+HIbDd8Ldtd4pIKqTrS988X+tcEClywZeN0jQhlOSk?=
 =?iso-8859-1?Q?FXY54VcRIQ0aQ1+OIVtUcca5GWOTM+DC4VESj/Rjcwf9zUXSb/db4xuils?=
 =?iso-8859-1?Q?GrA0m8TePAHpAOHVI5MgT6I/jrV3P39Wn/uBl3K/tQyLid1IdGo++psiqo?=
 =?iso-8859-1?Q?fhdxLfTL22rrPHFVj/kOMgol/Z3LrIfyREPd8pi+2gI9eXXM8rR382BmH9?=
 =?iso-8859-1?Q?FyPS4OYWex8xR6div7ai1M7ofjAbY3b3mbqxoDUOfHgqylS2oL1SxJwii8?=
 =?iso-8859-1?Q?upOrFnvhZS84iH2TF45lcj67aQ+KqeHe/Vso0Bq3YsgH/8IMwQ9Wzr22Dz?=
 =?iso-8859-1?Q?Kd0HtePxl92RAW8b8BF+839/tVHBXTw0IP9NO5WXdYgHFRJV0u0ma2d+nd?=
 =?iso-8859-1?Q?2WrJRSOo1F8Ns2W6RdcoqWISDjqVcD0tyaOt52F3MN1uqsDaGvreqVV17z?=
 =?iso-8859-1?Q?Q/GjFDQD7kA5xxT3DW+T8LIUqdKtaeKNjzzmp4CBvwB22udQzflSc+UfyX?=
 =?iso-8859-1?Q?WguF4jZ/2Vh2o+/Vr8voNdqTKVesWwZ8CZyJrDeYtuGnpWPJn2oKuKJwbb?=
 =?iso-8859-1?Q?FtGMibLYQUeLnqLRMNTr9CoCXs8AvYo4XtDaCiYTz//ZKbZrjEVFSGvsMO?=
 =?iso-8859-1?Q?/1vms2k4JSO2RKZ6S1xhTxND8jROVZkzw+/M5ttZDikRDi3uz8jioL5gAO?=
 =?iso-8859-1?Q?ClMBHGCSxEN5a0Yp8QqdMjQCnxVThZ7ZLelbI3m+ws5S89LKS99YenXQoK?=
 =?iso-8859-1?Q?i/BRYvrFaZJwlZWpIcrlH1O+46Q9h3zbWLEFHHwjuenqQxCvxsi9K0P+jj?=
 =?iso-8859-1?Q?EOEA14rOme9Pc9MSzbQM+vApbZWPlZpQAl2zekmKK9M28B3ZRz7k?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7513FCB44FA69D4EA94F617DDF581368@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	HdKCOk/y9O/I+dHYYi/45xgeiAj49T6AkmZ3Pn5JWWUlLJj2mVoSmtFW0YUcMceJzvENm26UrQKVr6cXkK+pNzswoftzyLBbeySUkkdFoP82GnU8459QR5iJvnVXOHdRSdN0PpzgAA2BoD57iJhAFkqTX16pPPTEx7FRG1hdwTzqYF4NNH+TIjFOD5m7Zwja11dfRS+TjPBwaUckVzQ2DIvKjYQ9NKLFytmK9ekjILRkuIuLN66waHcVrOYFgNWmWLUf2XyRBHIij8SzGwG2lZ+J+/qDE3uy6wOrfy1+p40nCazkzhA4xzU3K4As0QugCSWBzKcP56Rrl5MUmBr8fg==
X-OriginatorOrg: nozominetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BR2PPF4EC869C10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bbe357-1c50-46ec-bf25-08df2f6f6c81
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 12:32:51.8128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f04d14b-0796-4b81-b7fd-779778e05341
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PAdQxCqux46Lo8VaG47lLfnb3JwkBa4AayobjN0uPT7lpXXbEsldVHJxfPf2oTqCzI/4jPsvrGo4R7olDR360moNjiGBLQ2kx+dpAczFxgXRKgRJyurLHyroW9gEfD/C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR03MB11725
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0OSBTYWx0ZWRfX5CXCVIKSk7l4
 V3kgw8n4Mg4rehmuAx2faZ51ZuAuePPaFjtgUupBrBYy5AXnttJ/XpCC2rRxSos8Lzp9uld0dFR
 Jf1YfQK3cupflgEupuobezRp3PG32KilXpsVSp22oN1JgnPbzrKZ+03wLsuai7R69a/OO5pmvDr
 ykwlu58tpwGiV/yh/MmbRrIt1qBTg9wIFUCvY28DIUnlKpplJDI8AojfSMOfMsFaA17r+MJnd/x
 81CFqOy66YTsoBOY4GlLrQJUggpB8mrPqWBMgZYh2/gdRAJNBSpRjPFuYv15fyOVXZScGKJDNmC
 J0lgf6C6wMqunN7ePWz9tAicOQY6W2ZS7AiBUSydin493HuIe3QOWgjmfkB8mDbYEEm3B8b1BkZ
 /hA7ACmZW+jfKlkJZ2M7xdRj/wS+kODe65Ku4W0LK0fEZTE7OXEaklDpXsC7CkEwNhABKGqV8Pa
 9JxwnuzWjPHl2Tm++/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0OSBTYWx0ZWRfX1UjRwJcgwBG9
 XIVHzShqL4MvBZJKxoZtriQ41yZn4zGu4ZGSrVgVaEr7nXll4CsJRCuQks8teKvlcnHufjm32QV
 8oQP92fKG+BrojCV/SAxoRq3xHoUXHWppPaFdlV+ePmjp4jk6nip
X-Proofpoint-GUID: 9EEuCy3R5Z4NfAqpf79r28eeZ1lROiRc
X-Authority-Analysis: v=2.4 cv=JKauIMKb c=1 sm=1 tr=0 ts=6ad8b0f5 cx=c_pps
 a=I1KN2F6RgR6t1zUZZ2nx0Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=LLPZWm0_0O8A:10 a=nBHfkqHukZMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7VS2YgxpqphC4cixgVMD:22 a=iLFNfmxFs0q4OnAKpmcp:22
 a=QZ2HEVeaeKsYXbxLPScA:9 a=wPNLvfGTeEIA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: 9EEuCy3R5Z4NfAqpf79r28eeZ1lROiRc

Hi guys,
A couple of months ago I reported some security issues through GitHub.
Some have already been published, others are still under triage, just want =
to check whether there has been any updates on the remaining reports.
Is GitHub the preferred channel for reporting vulnerabilities?

With appreciation,

Alexandro Calo'
Nozomi Networks Labs=
