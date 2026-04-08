Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB00C34DB59;
	Wed,  8 Apr 2026 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775647750; cv=fail; b=RteUoBjkvEFO28cFJPrZyB/vWf/4kDeYOcFNuG0aszqqRbUXRVuyxLw+jvjKSxCZSPgwqaV+KUb+x6+QSxBKx0H+MXSLFLl9pWMhrMPsyXDGIsG4EJh74ykSrnZgtx6q+iZZM/Br4B3vFlYDJ6IWkJ2darFG70sWVOLndvvaA8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775647750; c=relaxed/simple;
	bh=3Spt4X6Cchq2+HMCuFjpw+g6uC9inujgEBOaiFQ36aI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P/eSdqufwjoEJdxFOgNoF/Srtqd5h2h+z8vzw5JaBBGhCNTA24Bfyq6+JP0QtY9GflWab9+uaoj9fz3RSNIM8wtpWe/f+wheO0FOgRl8aHWJH2STz+TUzi/Tf4BKLreTMBB25PTy3gZ8f8xDKjbxhdH+vqxdKRrCzgw6+Y5fA1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Q3b+UBPz; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=fVS583fg; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Q3b+UBPz";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="fVS583fg"
X-UUID: 0bebd02e333e11f1ae70033691e9ac7d-20260408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3Spt4X6Cchq2+HMCuFjpw+g6uC9inujgEBOaiFQ36aI=;
	b=Q3b+UBPzPpnNrYzEEvYxQi6mSxyzYBjfoC8M7Etmsn6sikwDY2KC1cvzNBnWjBuQtbqfBzkGrhBSg8wsvnNH1Cq5wTk0zUu1UtYdim+WBhqCKOE896RqwvvsWEc4wM7nDKX3Fh00/pt0LobpOrGI+ewJtL786g6ySEM2dXlYAGs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b00ea1af-a150-477a-8193-fd6da77ffeab,IP:0,U
	RL:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:12
X-CID-META: VersionHash:e7bac3a,CLOUDID:7687a024-cb5c-4236-a89a-9a7fb20c9bc4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|11|94|81|104|80|1,File:130,
	RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:
	0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0bebd02e333e11f1ae70033691e9ac7d-20260408
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2098822561; Wed, 08 Apr 2026 19:28:20 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 8 Apr 2026 19:28:19 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 8 Apr 2026 19:28:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGJ+fBpWVk0mWE4F+X4HT448I7m/C6Xd8ESMYf4+894jGqXFv5bNKepCBIj91yAOfD0ubI8K/CIJ9EzB96AbD4/q32W9+NBDKDNidnOwXBQSMqAPMQ55tLMLSIQjvuYzzT2KzrIN7qqbBSc1IA4zkOpF4iM5YrA5FYO/0g1qhd+FkDOQms41iuVfcvSwHHzNoQPqIc9hCcRJNLJuugaY6CvWbyB/BoshCOUizNEArO8QaMn87km4f6ITYMZsGzaLUEyH7gnXlP4aR4F6OjtcWM6jNh9tVETPIyTSTjvTePzsb2jfPViPN3vz7DHugn9riTFDgiI631D3v2EvSBkztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Spt4X6Cchq2+HMCuFjpw+g6uC9inujgEBOaiFQ36aI=;
 b=GT5b+4A2a1DJ7V8JjUvAsXVdXmd24l9SneU38h9o8D4QVRsYHthP2fHI5UEtzuwVX5dOkLfNsmQ+yv+A8nbdcp2VsIf8DXxYQD21SzOP1WmVWOkhVKnY8Qlml403KQcFrP9ohRn7+LVGtXCPr0jtz4J2e8nRgOZn/c6Cj0jdE+7/6Ije3obSax/L4EbghoYrWYnbdve547mleWez/3Uvc9z3xT6RCHwIA0G00r1ug88cuhThwAKlXXLcbb5cPDu0CZUMxezwygrX4I4BRxrm4aR9o7eb/hCLKZ6cUSRcFIe5+b4JlUGcwu3J8z7EX1d/fWqfC0RzrQ9FTUGrR8deuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Spt4X6Cchq2+HMCuFjpw+g6uC9inujgEBOaiFQ36aI=;
 b=fVS583fg7xvtQQV83nNQ7DjXXVT9RN5MFWxS6O5iRQxyIsSdxk1kW47i/lGkT6orCNDvepZ+GAWWgHdn8P7lqF8KzjkmlqW7FYfVBK6v79LNbRvrYv3T84oFJ426z61GHuxuqeN3sWvNZDirY/R8NfotMiW3RWUuiKZJPoM3Rb0=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by KUXPR03MB9386.apcprd03.prod.outlook.com (2603:1096:d10:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 11:28:16 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771%3]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 11:28:15 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: =?utf-8?B?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
	=?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	=?utf-8?B?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, Sean Wang
	<Sean.Wang@mediatek.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] Bluetooth: btmtk: add event filter to filter specific
 event
Thread-Topic: [PATCH v2] Bluetooth: btmtk: add event filter to filter specific
 event
Thread-Index: AQHcxoSHcZlCm/wtD0CejGRbJO4qQrXTr/KAgAFYmAA=
Date: Wed, 8 Apr 2026 11:28:15 +0000
Message-ID: <860436cddf4324c794817b54295b6fe083be8bb1.camel@mediatek.com>
References: <20260407114851.3087886-1-chris.lu@mediatek.com>
	 <CABBYNZ+xi_ktCMSeXP_aNTVLZzKoz+Ye4gFZFvF7eiMRZcULww@mail.gmail.com>
In-Reply-To: <CABBYNZ+xi_ktCMSeXP_aNTVLZzKoz+Ye4gFZFvF7eiMRZcULww@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|KUXPR03MB9386:EE_
x-ms-office365-filtering-correlation-id: 53efe54c-674f-46ee-a06f-08de9561ecfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: N7LDALsXTmh16KPucjbe8vtd6aDFB8ulBLvW5BSak15a1UACLRAKfyg3oXAN8bkM7K6uLirIyF5a2IaUkUIHMopJnsziOt6vBaQ0keKuAhCRHlsE4ZDHgKmOKnOem/xNsj6SSUHXv6CgWxRBRKcKW7Q5wcacZMdheYsrPFmaORGs6QfBPjCV7EwI4qePy8Y0EIGhDIisE/N6mwJ32h15aPLSnxmpmUWm6ksJguDL04deizOCuTmifeI/Tq+wF9a64vAuvSkMu20Cm6eEPAUSh4PjOh1CHwHAcM+ZWcTXuC8vfG52KCNLDAK/PdicmO9/rkpPeNLklUQ8ZCZZv5y8UK4p1sdJ6adOTd8RRRqITlKSV6nuoEKvTyNAKGztqAoxquvnioLYpvbo9G4bCy66kkJL+mYT5xz0+5xwtA5SiFzjLl2OJpUArnDV5dpoEBU9fKcmQSJafqZhtCuA0MyRdvaZDCQO92AoI5IlkeLitfSKeI8g+iK18Hsd9silJNPigSwuuGGxXKPsn1NTGe7HvGV3AigWtn3mwFUMuWw2RLCtM8kYLAX3QUDB96HsnwAZ9PU/ZL+ey0BV9s9cvQBSAejPamgWd2CEwocDgcFW6OVVb53AZPkpIzx5bQ6YRtFez4nuY0n20spSC1d6MqnMas8vzmkCMo/iI0DkGq257zNDC5VaW2RrJ5ntH+fsKwbvdsZeM9/dqrPqDi7LNK4xcK/MDDpWUcKzmi79zIgfyhU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWw3Wm9Tc2p1dEUrNmdHVnpORmR6SjNTZmpSS0tmQ0toeHFBaUJLRnVYaHhq?=
 =?utf-8?B?VXpWb1dYNzMvNFZtL1NWVm9kT1V6U3dCWW5DNDVJM0JSRmdCdUY3dlkrdm03?=
 =?utf-8?B?aEwvUmNsMDVoK0FRd0tuYnBxMnlIcVJBUkJKdENwV2FicVlZMkVhVXcrMEti?=
 =?utf-8?B?K2VkY0x4bTNhWWdPRUZNUHRLQkxtNzNhL29ocFFQeDcxd0w0TkRwUkZMRTJN?=
 =?utf-8?B?cmRXM0RDOWxtYUxOejMxY1FNdWE4RVNGSnFxaGY4c3hlWjJESjB2amM4Q2h3?=
 =?utf-8?B?a0lJQi9LUHZqeEtSdDQwNEtHbWhGNGtkZHdnWmZXeUVTSCtlSHlHUElkSTdu?=
 =?utf-8?B?RVVzYzdaTVc3M29vVXZkZnZuWXQ1aEJhdTgxcU4rZDJaSU9HNm5RZDloa2Jh?=
 =?utf-8?B?aytWdml2ajRkR1Z5QUFJc25SRythYUdZcmY3M2lxRk95Vnpoczc5TllOazla?=
 =?utf-8?B?WGNzcE9IbUV5R084OXZib3hBbXdEZEhBeXVDTkhzWGt2eE92N3ZZRXBjN2h6?=
 =?utf-8?B?SGVwU0p1aFlXZm92SjNWN1FBTnRNNTVMaGd3R2lHcmt5WTFEdmJ4SjF3RVVV?=
 =?utf-8?B?Tmk1SWdhSW4yVmNnbzNtcUE2bWJlS3A1eVErWlp4TnNNdWRvMmdIeDZ4NSt4?=
 =?utf-8?B?bUhJb2NyN1BTaXA5UHhHb2VqOEZLMDk3K1dCaU4vOEZXbXlLWmdYOGUwTXNH?=
 =?utf-8?B?S3ozeXBGcDdNQi9ZcWtYc2dWZHVEeUh0dWMrYVNwZ0dsSHJYMDdycklUOHFX?=
 =?utf-8?B?VVRnMWVPckZ5UkFKQkdaaWw5NWVXbVpoNy81QVlOcDMvOWZleFlZM296RGlw?=
 =?utf-8?B?dE14MWpjL3RpdkxNUDdUcjgvTXhOTXlkNm1SZHFjSCt4TDd0QnorVzR1ZTVq?=
 =?utf-8?B?cE9XaXYwMkZwMHZ3WDJ1YmYzUW8wMW11cUw5MlgxaCtJMGw2SndQNytVYlhq?=
 =?utf-8?B?SG5uV0FKaG5Bb3hzOHMxTVNVM0J1TlZmMGdmYjV2clZ3NzdGbndINExucHps?=
 =?utf-8?B?c0lMczdHZEh1TisxdXM1eFA3TTFrdktBUVBmTUMxZ2kwakFYbWxyaHZrRDhL?=
 =?utf-8?B?bWlMdmRJWTFzSUxGUVl2aWFock1DYmM1T2VpTEZWVC9NWDhaRmt2UlpoZ0g4?=
 =?utf-8?B?dkEycUs5U0FDam5rQm9NMGRnblpSK2FOMVVUNDBlNkFCaVgrcTVhQWdjQlZK?=
 =?utf-8?B?aTgxSENSSmRmMXQ4R2tQYkJXS0pCQStzZ0hyTmRqdS9ub3JId0JtYkttMitL?=
 =?utf-8?B?ZnNuVUpkaHJ0ejZhczZ1cEkxdjJjRGwzcDVETTNwMUYvdjJ1SW9lc3Uzd1Fk?=
 =?utf-8?B?NGs5SjJqRTV3aElONEIyeHMxbmxRR2xLaUxCRFRGWEt3U3BnNkhQdXpWWU9s?=
 =?utf-8?B?RjZidW81MDdXd0pUU29DelhDL21kejRDVk55Vy9IekpETkZrOHAyUCtJKzVz?=
 =?utf-8?B?alF3YzFwVEFlQW9ZRlhlaFNoMElKSlpOMnJqQlVBQkRERWV0YUtsMUt4TkVk?=
 =?utf-8?B?VXdhMEIwcHk1bklYK21qQmd6Q3pkd3BTK3RPQ2xwZ0I5T0J1OUdxMmxLNmQ5?=
 =?utf-8?B?UzV1czhOR01RQ0Ryc1VkTHJsMGxHbGNjK3pOcUkyKzVzUGo1eFRWY1l5dEow?=
 =?utf-8?B?WTZJamVnejJVQ3ZnRk1EVk5kTTBsZ01xbXZhRTAraTJZdEI2MUsvdFlsTFY1?=
 =?utf-8?B?M0VLbW11bzNaSmhkK1VnWlZVaytydXByUEVGSC9mdjd1cHNJc2dTbHM0Q0gz?=
 =?utf-8?B?aVBiY0NJOEpXTmZvTVVsMFdqV0NTMGgxcS9yTE1ETGpkWHhidzNCcFNhM3ZQ?=
 =?utf-8?B?c0p2RnNRWTMySEJ1aEE0SXpSVXliNmFJRXdMY3RVdVVMNE9vMlMrbmJ3N1JU?=
 =?utf-8?B?dm5FZGNBT3hHNVRjeGxVdVlQajh6eFFFRWlFblViZW5Hcll1Z0N4NEpCZnZZ?=
 =?utf-8?B?T0NpWVkrRTMzTmVKS1VjM283MU9mVFlTelRkcDNlY0U3MnhkcTRpQnFveGEx?=
 =?utf-8?B?TE01c1I1ZzI1czZlQXd0b2djMFJEeGgvTTV6WlZCMGc1TFFWVDFBSGFYdHlL?=
 =?utf-8?B?TUFCNUZ6WnNrMktTcEp0cm5UQzhTNWRRUS92U3pmTVZ1VnppdnBGTC9oN0Mw?=
 =?utf-8?B?N0d6N2JRd04rdGdlZGRwUWJHZHhXclpzSzZZNzdheStsS2FtWEZVMXd5QnB6?=
 =?utf-8?B?b3RQMGZVUjVUNjArS0FwYmhLV2tqdzVVWGxBTkM2QXUyVUNuaXFmSE5rM0Uw?=
 =?utf-8?B?U2FDa1V2RGdadkIxRHB0RzZrMnlXMlBWYm83RGdWY2c3M09jWFQraWJWZWgr?=
 =?utf-8?B?S01HVkU0cUxUMTM0Tk4wU2FhN05aa0RoTlZNbTM2MGNpcEZMZkhEUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7557B0281841A42B515797EEE3184E6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sccIfb/hdd+tUAlhVpUNODqKHzzQrdZ6kw+XvQ84DrWciF8WYjLccX7i8iZ2GUJ+Z7+gMFm6TmQ/ooTdw27iaQyVvechqDADXPzE2T6VxyWQmilMkile617Ij/CZX1HKUhRf1ZANsg5AwdkeNZ8IhDV7PosrfZ779/F75Hp69JcdosXECwhFr1tP2kErWwD50g5Ke7kmqKvKHKKbO9ejQsxTFa+/KRJJStJOiZGXNkX2fuUCxZJzkN+7A9aQkRvNf2VH01VT2cWckE/jREJZQkrLWYAZDCtbx9M1UoOUWLKA8ugM61ZQUiLeSFub6l/hgMpglqrD7kN2xM6/tRapIQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53efe54c-674f-46ee-a06f-08de9561ecfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 11:28:15.3174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TEF3Kvfk1cTysM1Senj15E3G6QqnaxonFHYgH2iuKy+XY1Ik6uraGeYeQE4ovNMdB/SM7DRuZr6GI82McF5KVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR03MB9386

SGkgTHVpeiwNCg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KDQpPbiBUdWUsIDIwMjYtMDQtMDcg
YXQgMTA6NTQgLTA0MDAsIEx1aXogQXVndXN0byB2b24gRGVudHogd3JvdGU6DQo+IEhpIENocmlz
LA0KPiANCj4gT24gVHVlLCBBcHIgNywgMjAyNiBhdCA3OjQ44oCvQU0gQ2hyaXMgTHUgPGNocmlz
Lmx1QG1lZGlhdGVrLmNvbT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gQWRkIGFuIGV2ZW50IGZpbHRl
ciB0byBmaWx0ZXIgZXZlbnQgd2l0aCBzcGVjaWZpYyBvcGNvZGUgdG8gcHJldmVudA0KPiA+IEJU
DQo+ID4gc3RhY2sgZnJvbSByZWNlaXZpbmcgdW5leHBlY3RlZCBldmVudC4NCj4gPiANCj4gPiBF
dmVudCB3aXRoIG9wY29kZSAweGZjNWQgaXMgZ2VuZXJhdGVkIHdoZW4gTWVkaWFUZWsncyBCbHVl
dG9vdGgNCj4gPiBlbmFibGUNCj4gPiBmaXJtd2FyZSBsb2dzIGFuZCBpcyBub3QgZXhwZWN0ZWQg
dG8gYmUgc2VudCB0byB1c2Vyc3BhY2UuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hyaXMg
THUgPGNocmlzLmx1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiB2MSAtPiB2MjogdXBkYXRl
IGNvbW1pdCBtZXNzYWdlDQo+ID4gLS0tDQo+ID4gwqBkcml2ZXJzL2JsdWV0b290aC9idG10ay5j
IHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KPiA+IMKgZHJpdmVycy9ibHVldG9vdGgvYnRt
dGsuaCB8wqAgNyArKysrKysrDQo+ID4gwqBkcml2ZXJzL2JsdWV0b290aC9idHVzYi5jIHzCoCAy
ICsrDQo+ID4gwqAzIGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRtdGsuYyBiL2RyaXZlcnMvYmx1ZXRvb3Ro
L2J0bXRrLmMNCj4gPiBpbmRleCA1NTUxNmI0NjAyZGIuLjMwMmQ2ZGRmOTA2MiAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idG10ay5jDQo+ID4gKysrIGIvZHJpdmVycy9ibHVl
dG9vdGgvYnRtdGsuYw0KPiA+IEBAIC0xNTAzLDYgKzE1MDMsMjggQEAgaW50IGJ0bXRrX3VzYl9z
aHV0ZG93bihzdHJ1Y3QgaGNpX2RldiAqaGRldikNCj4gPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
MDsNCj4gPiDCoH0NCj4gPiDCoEVYUE9SVF9TWU1CT0xfR1BMKGJ0bXRrX3VzYl9zaHV0ZG93bik7
DQo+ID4gKw0KPiA+ICtpbnQgYnRtdGtfcmVjdl9ldmVudChzdHJ1Y3QgaGNpX2RldiAqaGRldiwg
c3RydWN0IHNrX2J1ZmYgKnNrYikNCj4gPiArew0KPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IGhj
aV9ldmVudF9oZHIgKmhkciA9ICh2b2lkICopc2tiLT5kYXRhOw0KPiA+ICsNCj4gPiArwqDCoMKg
wqDCoMKgIGlmIChoZHItPmV2dCA9PSBIQ0lfRVZfQ01EX0NPTVBMRVRFKSB7DQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGhjaV9ldl9jbWRfY29tcGxldGUgKmVjOw0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHUxNiBvcGNvZGU7DQo+ID4gKw0KPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVjID0gKHZvaWQgKikoc2tiLT5kYXRhICsg
SENJX0VWRU5UX0hEUl9TSVpFKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBv
cGNvZGUgPSBfX2xlMTZfdG9fY3B1KGVjLT5vcGNvZGUpOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBGaWx0ZXIgdmVuZG9yIG9wY29kZSAqLw0KPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChvcGNvZGUgPT0gMHhmYzVkKSB7DQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGtmcmVlX3NrYihza2Ip
Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gMDsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gK8KgwqDCoMKg
wqDCoCB9DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqAgcmV0dXJuIGhjaV9yZWN2X2ZyYW1lKGhk
ZXYsIHNrYik7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwoYnRtdGtfcmVjdl9ldmVu
dCk7DQo+ID4gwqAjZW5kaWYNCj4gPiANCj4gPiDCoE1PRFVMRV9BVVRIT1IoIlNlYW4gV2FuZyA8
c2Vhbi53YW5nQG1lZGlhdGVrLmNvbT4iKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVl
dG9vdGgvYnRtdGsuaCBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmgNCj4gPiBpbmRleCBhZGFm
Mzg1NjI2ZWUuLjA4YjczOTI3YzhmMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290
aC9idG10ay5oDQo+ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRtdGsuaA0KPiA+IEBAIC0y
MTgsNiArMjE4LDggQEAgaW50IGJ0bXRrX3VzYl9zdXNwZW5kKHN0cnVjdCBoY2lfZGV2ICpoZGV2
KTsNCj4gPiDCoGludCBidG10a191c2Jfc2V0dXAoc3RydWN0IGhjaV9kZXYgKmhkZXYpOw0KPiA+
IA0KPiA+IMKgaW50IGJ0bXRrX3VzYl9zaHV0ZG93bihzdHJ1Y3QgaGNpX2RldiAqaGRldik7DQo+
ID4gKw0KPiA+ICtpbnQgYnRtdGtfcmVjdl9ldmVudChzdHJ1Y3QgaGNpX2RldiAqaGRldiwgc3Ry
dWN0IHNrX2J1ZmYgKnNrYik7DQo+ID4gwqAjZWxzZQ0KPiA+IA0KPiA+IMKgc3RhdGljIGlubGlu
ZSBpbnQgYnRtdGtfc2V0X2JkYWRkcihzdHJ1Y3QgaGNpX2RldiAqaGRldiwNCj4gPiBAQCAtMjk2
LDQgKzI5OCw5IEBAIHN0YXRpYyBpbmxpbmUgaW50IGJ0bXRrX3VzYl9zaHV0ZG93bihzdHJ1Y3QN
Cj4gPiBoY2lfZGV2ICpoZGV2KQ0KPiA+IMKgew0KPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiAt
RU9QTk9UU1VQUDsNCj4gPiDCoH0NCj4gPiArDQo+ID4gK3N0YXRpYyBpbmxpbmUgaW50IGJ0bXRr
X3JlY3ZfZXZlbnQoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHN0cnVjdA0KPiA+IHNrX2J1ZmYgKnNr
YikNCj4gPiArew0KPiA+ICvCoMKgwqDCoMKgwqAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+ICt9
DQo+ID4gwqAjZW5kaWYNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnR1c2Iu
YyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMNCj4gPiBpbmRleCBmOWQ1MTVlZTkxMjQuLmRh
ZjhhMzg3ZTY2MCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jDQo+
ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0KPiA+IEBAIC00MTUwLDYgKzQxNTAs
OCBAQCBzdGF0aWMgaW50IGJ0dXNiX3Byb2JlKHN0cnVjdCB1c2JfaW50ZXJmYWNlDQo+ID4gKmlu
dGYsDQo+ID4gwqDCoMKgwqDCoMKgwqAgfSBlbHNlIGlmIChpZC0+ZHJpdmVyX2luZm8gJiBCVFVT
Ql9NRURJQVRFSykgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBBbGxv
Y2F0ZSBleHRyYSBzcGFjZSBmb3IgTWVkaWF0ZWsgZGV2aWNlICovDQo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHByaXZfc2l6ZSArPSBzaXplb2Yoc3RydWN0IGJ0bXRrX2RhdGEp
Ow0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkYXRhLT5yZWN2X2V2
ZW50ID0gYnRtdGtfcmVjdl9ldmVudDsNCj4gPiDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gDQo+ID4g
wqDCoMKgwqDCoMKgwqAgZGF0YS0+cmVjdl9hY2wgPSBoY2lfcmVjdl9mcmFtZTsNCj4gPiAtLQ0K
PiA+IDIuNDUuMg0KPiANCj4gDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczov
L3Nhc2hpa28uZGV2LyovcGF0Y2hzZXQvMjAyNjA0MDcxMTQ4NTEuMzA4Nzg4Ni0xLWNocmlzLmx1
KjQwbWVkaWF0ZWsuY29tX187SXlVISFDVFJOS0E5d01nMEFSYnchajRjOWE5YThOMHlDLXVQVnh6
UDNwaVFOOEdhNGFFRzFnRTdaTXRURmVGWUZ6a05pcTA4WmRfWEhpOUltaGlRVFNXVGpLUC1Yb1J1
dEdRVTB5S2skDQo+IMKgDQo+IA0KPiBCb3RoIGlzc3VlcyBzZWVtIHZhbGlkIHRvIG1lLiBUaGF0
IHNhaWQsIEkgd29uZGVyIGlmIGl0IHdvdWxkbid0IGhhdmUNCj4gYmVlbiBiZXR0ZXIgdG8gYWxs
b3cgZHJpdmVycyB0byByZWdpc3RlciB3aXRoIGl0cyBvd24gc3RydWN0DQo+IGhjaV9ldi9zdHJ1
Y3QgaGNpX2NjIHRhYmxlcywgdGhhdCB3YXkgdGhlIGRyaXZlciBjYW4gZXh0ZW5kIGV2ZW50DQo+
IHBhcnNpbmcgcmF0aGVyIHRoYW4gaW50ZXJjZXB0aW5nIGl0IGFuZCBwZXJmb3JtaW5nIGN1c3Rv
bSBwYXJzaW5nDQo+IHdoaWNoIGNhbiBsZWFkIHRvIGJ1Z3MgbGlrZSB0aGUgb25lcyBtZW50aW9u
ZWQgYWJvdmUuDQo+IA0KPiANCg0KRm9yIHRoZSBhcHByb2FjaCB5b3UgbWVudGlvbmVkLCBJIHRo
aW5rIGl0J3MgYSBiZXR0ZXIgbG9uZy10ZXJtDQpkaXJlY3Rpb24gYnV0IGl0IHNlZW1zIHRoYXQg
dGhpcyBtZWNoYW5pc20gaGFzbid0IGJlZW4gaW1wbGVtZW50IHlldCwNCm9yIGlzIHRoZXJlIGFs
cmVhZHkgZXhpc3RpbmcgYW4gc3RydWN0dXJlL0FQSSBpbiBrZXJuZWwgdGhhdCBJIGNhbg0KcmVm
ZXIgdG8/DQoNClNvIGZhciBJIHJlZmVyIHRvIHRoZSBtZXRob2RzIHVzZWQgYnkgb3RoZXIgdmVu
ZG9yIHRvIGF0dGFjaCB0aGUgZXZlbnQNCmZpbHRlciBpbiBkcml2ZXIgc2V0dXAgc3RhZ2UuIEkn
bGwgc2VuZCBhIHYzIGFkZHJlc3NpbmcgdGhlIHJldmlldw0KY29tbWVudCBpbiBhYm92ZSB3ZWJz
aXRlIGFmdGVyIGRvaW5nIHNvbWUgdmVyaWZpY2F0aW9uIGxvY2FsbHkuDQoNClRoYW5rcywNCkNo
cmlzIEx1DQo=
