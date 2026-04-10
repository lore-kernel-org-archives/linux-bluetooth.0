Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3F529E0F6;
	Fri, 10 Apr 2026 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775810071; cv=fail; b=U/IQBVy6lC9ZPVKXRmFKIwJppEoTUbryYtnJ1pm0HOQRNFT4U0Tv04f9YadvnROUiyBK1EOcwGtkfGARKvVIfDO6UxvBNCbm439ABrkG/f7zWxH0Mx3mXsgQ68tRokNqKxPRxiqFotwclwNVcFV24haIemrHkWKfLHQCnSGT+kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775810071; c=relaxed/simple;
	bh=V7yN9Mdc2dUuUOuLPdbj+AtVKC5NCGU/eHCSfMjiRZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sNDSclNFRY1hj+3xAkAddVnBtgJxRaTyByosA8mNqRqzNqTVZHaCV9K8s9O5TJJ+S4SI+ZIBj+nWhM1CcitAYejPSnwkZFDqpNGL7BfrC6IXKxSYmqok3lFRyuuRBd5PXq6TityVQqLu+VxU+3Rrre91Sy5toIFfc9A7xWVqPlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rGQ8+suZ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=fzQiXaQR; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rGQ8+suZ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="fzQiXaQR"
X-UUID: 10434a0034b811f19a16598d5ca7f8ec-20260410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=V7yN9Mdc2dUuUOuLPdbj+AtVKC5NCGU/eHCSfMjiRZM=;
	b=rGQ8+suZbHLRgNdBJJkKPIzhE2dfIKpsZaPUmKUyB5XDRiGF5ZqjeqICrIg1iiti0zd+qxtfv5Cc24zRnr/v79z9d1Tx++Iv663tS2d3gjRDU5L8VxQz5+eDusVMtcvwQ740ZeVUrebqM18i8KICcI8fvon4on9AkgzmCqN/sKM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a8dafae9-e69d-4b60-a0fc-58142fa1e042,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:faccb4d5-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 10434a0034b811f19a16598d5ca7f8ec-20260410
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 210983372; Fri, 10 Apr 2026 16:34:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 10 Apr 2026 16:34:16 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 10 Apr 2026 16:34:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwWzEueblR/qiwBsNTi/s9eklGOo4yWjUXgHNOag4YCfHiUbWyZ+fAQZSfx1Qz6SMWyXw2qLDLB0x9PqBZ2j2EHGPrTm/WhMSN2rG2DvlexdD91u4UuhR7P7ghCRI62UnI7ApFrm+mH4cE3RTiRJcNk0TREtXXw4PEnc8F243xw9wXQWrA/TgOnewmR8oZeqzXE9NZ9ubd3UdhifO+q42g3nLnZOJKUcPuk+rZjaGuD74dm9kW4QwQi/aVOofQCk3lNSqb/RWAjhjf8HENKeN/aj/fEEejavOT0IP1NwTfJ2Aw0ct9KLTXXkpizzpfESUMt5iducSJuOI8zZKtogEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7yN9Mdc2dUuUOuLPdbj+AtVKC5NCGU/eHCSfMjiRZM=;
 b=VWajlufwh4YZ77lqcqqfqoT+CEkXGeeQHpW5aqcktB6fme3hRW7KQYr1BRz7mr7xDICmj+QCCKVEbrpaegQgpSaDQD51p8vq+Ky1QwD4csEU+BsrQCcoxq/h2Pa3+EWvSd2vf1knhZIXqfVQsgdin0rJ2Xn2A3VcAcxTtya0kTxLulLepa24gGHK65+0UXz7Ad7KIR6SfHpE/ByVqWM+MZ95QwLeTzOAcWcZijmsSQ/mWo1xXbbkzTzI/6y4i+AOdKWYXV0BJDLW0GYXrHC/gKgD7wlkj1bTFi/SPIx3+ED+ZsH2KV/3jW3wLmeziqXS20pmNzLSOipwPGrx4hsrAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7yN9Mdc2dUuUOuLPdbj+AtVKC5NCGU/eHCSfMjiRZM=;
 b=fzQiXaQR2w2Q1HT/YvX9yU/cbGbMQHmtKUm7XBdm9Kr9lhixP+USo1IMpghyokk/Upz+YwRf0yf/Da8tuIrSI04TbkwsibFaPY1/aWu8gm9iIps4kPB7Q+jGl5YSX3fJe6n7XprgxXyzJ9nbpibmlAVHvZ7QmiNA+57PfNkWeCM=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by SEYPR03MB7966.apcprd03.prod.outlook.com (2603:1096:101:175::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 10 Apr
 2026 08:34:08 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771%3]) with mapi id 15.20.9769.016; Fri, 10 Apr 2026
 08:34:08 +0000
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
Subject: Re: [RESEND PATCH v1] Bluetooth: btusb: MT7925: Add VID/PID 0e8d/8c38
Thread-Topic: [RESEND PATCH v1] Bluetooth: btusb: MT7925: Add VID/PID
 0e8d/8c38
Thread-Index: AQHcxlrxSl1e3XLlSUW7sEXymTyIxbXX/OGA
Date: Fri, 10 Apr 2026 08:34:08 +0000
Message-ID: <2dfebd7dc8f7f93030f90988bff9a37df9aa0906.camel@mediatek.com>
References: <20260407065110.3037135-1-chris.lu@mediatek.com>
In-Reply-To: <20260407065110.3037135-1-chris.lu@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|SEYPR03MB7966:EE_
x-ms-office365-filtering-correlation-id: f6306f0d-d75f-43ec-6806-08de96dbeed8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: YgnD+LW388SrtxtyJx9d7vFvAXazGvXleZEljA2eMLlDPYjAj98sgI6a5RLSG5wX6FnhaOQjubMVfrRPna7smjpS4VSXHCc5xYEAfQ+1jPudw7YSidBAjXp+PD81xx/XgOlLbNdDeFbRzl48KRIpkvMAS9Sy8PRCXsAIJpNQX+h3X041XmGfZOfz8N1GnTichMZcwdOHs/f2dge3PhZ252Gp37gR/kC/mGL03VHaUZ/oDG8pgYc81i1tWpB8/Ub1Q+Q6RnYCcJEsGvjnDkhzqpN2hVTlQIpfuus50OU9INNq/FCH+6yPPlDTuOZeMCb2R72r3V/i8WNmVn3k6GJ8knBCRVnAHhbzwr/S1wgFch/vCSmAYUhe06kpefshtZkhfDAI4KqL9KrkXZEJ+ma/TXfVoc06jBGyK85roPomkbhDEdCe1w0kRz04WsuhAXPCnfZ4VWYaunXO49SLRjCvqyE1M3zNPKaXDhRNAyVSAw1WgLwbX7I9njMkfrdrOqKBWsdHLsKr2slg9HaohmEg7DUQcEkniKRRSK0MAJ51ucDIl+NpQJHMS5Q5Z1zCgtAgsl7oNc0WKiDA0uN9UuP2Y4L5h9J9KBj8XzzyCMfcfVxa7srZtT1SIgodNsVgtGH3nFscz36JqBRwx+pCkXAPC1jhNA2fj7WkylKOrOZFCd6wKG/mor0Ofki+emUJTGz03pCIdFenBziDWvz/csLsnI2y/vbv39yP+jdchDvhrhEvUpP156zJeoKw0kIl8N46DVd8joLAiDce7OArUcPqOKvrrgjdLw++h4ktUkGIBnk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3lobFlGdzRUbVFEdzlRWjQyZE40KzdjNFgzYU9JSSt0RE1BQ0I4bGNxRnhu?=
 =?utf-8?B?Ni9PRGM5eWV1RVFnKy9seCtDMjcrcUdIdEVNcXJpSFhRWTErU0JMVlUzdVZo?=
 =?utf-8?B?eFVTMS9mejE5bTRrcEhZS0dLNUs4UlhWS3VlVkpJTmtMQkFRNElsQzhCSmpw?=
 =?utf-8?B?NzdMTExoYzM5YUM1QnlFbEhiUlFqQVJNd3U2bnpMWmJQUk9oMnl1SXJHdFYw?=
 =?utf-8?B?eklJeGJnZmpXcDU1QnVlbUdaTWdaMkMzejBOUlpIeUFrZ0JLUGM5R3JrTElw?=
 =?utf-8?B?MEdsWitsbUVGVTE4M21nampSQUdWZUFDOHpycFQ3elQ5aFFaekFCcWhBUndK?=
 =?utf-8?B?UG5nUlpLY0RnRHZ3REJmUTcvcHhhZXlFRm0zdU5tM0dFbU9lcHgxb1l5ODUw?=
 =?utf-8?B?MHg4Sm5SblA0eDZ0WlhyM1orYUp0RW1rK090eTllNWVkVlRoQ0tWU0h3R3Ji?=
 =?utf-8?B?WFJiOU0vVWtwNG1RNERubU81azBJZ0ZRa1RnLytsNE5aTFlnS2pENWlyRXpi?=
 =?utf-8?B?MkhYNzFjUGNUNkQ3NURtWmtab1NrdW5FMERLei9nUG1lUHVhY2dyMXJvV3RS?=
 =?utf-8?B?MGowS252dFZsdG9ydFUyUFJYQkhSS0g1WXViaDZ3TkVGRVpSL3pWMWEycEpz?=
 =?utf-8?B?SVNLMFBjOVA5NjN4Z3lJancvUkJxQktORXBZSFdMSWlHczZlRWdiRGtlVURQ?=
 =?utf-8?B?cjhnM2JVcmUreHlBeTNsMWRJTVB4VGF3VG9iYUpYWFpSUzJwVWdDYkFVcDVr?=
 =?utf-8?B?RkJaUTQrWEFnMFJhYld6eFYxM3dQaHlDM1huNTB5NkdXYStwdE54cDgvYnNu?=
 =?utf-8?B?Zkc0UitoYlR5MEZobWZtVjIzeWl0QzdaeXcrM0sxTWtadG0zL1YyTG9hTGt1?=
 =?utf-8?B?UmUwa04yMTU4dEdSK3RVNUhjNUUzdzJ0K3luSTZ4Qy9UbGNSWWhmSUF0SWVv?=
 =?utf-8?B?NzErZWNjOGNmOFpzYlVHT3QzVVhtOGh2VS9uOVlqUUhOL1A3aGlYVVdTMHNv?=
 =?utf-8?B?TENRK1VoMEdoRm1JcEljbkZVYnY3T2IzcHFQRE4vMHpEUE1ROFA3d081VWto?=
 =?utf-8?B?Y1JJY1NSVTd4cjJnQ01pdGVOQkdJVCtVWUlicmtLSEJ2aWpDSElhRGxDRUF3?=
 =?utf-8?B?MkRZZ2cwM3BrTlNJYnp5eVREeVI3Wm1TUm55VTIyYWxaQUxJN0JDNkNGMHVQ?=
 =?utf-8?B?T3VGRGgyN2V3RlpVRGhwbHROcHFzMS8rS01CTEtwUGRsNG1pQS80MDZLYXVu?=
 =?utf-8?B?QlBOaURGRXVLUFdCaXN0d0V4NW4yMWpTU1lWVUZYMmpsTFgvOCtDZmNma0c0?=
 =?utf-8?B?Q09OdEdPclZxQlBqWVAvNEZhK1N6ZnkwRlpFZ2JiMWQvdURjQk1Pbm5tTkxU?=
 =?utf-8?B?TzdkckRWQUFyRk1zc1NYMGFDQ2F6eDVEK1c4S1pMMTl5UkF1V0VaSDJxajR1?=
 =?utf-8?B?LzFZVVhMRzkyVFBnTlIxaDZSMTRscXhaeGlrVExsSDlEczkvQmx1bk9mVnE3?=
 =?utf-8?B?QmpVVzRtSGJVdkRKWngzcURIYktLMCsyclBkTGlUVXVaV0I0QmptN2lHSk9y?=
 =?utf-8?B?RFZGSTJNVXVoQkdZcGNpYm1qQmdOUURYWjRnRW9zaWk2TmdyV2w1NkRieGVW?=
 =?utf-8?B?OVcyUmViTG1SdmxwOTRtYVZGRmwxN1BDK0MvL0UrT0w3MCtEeXZqUkNVMjI2?=
 =?utf-8?B?a1JDMk5kT1hZQ01QbFpaR2RXOWpJS3dnUXBKdkJlajB1Zm43RXkwUnNLMzU2?=
 =?utf-8?B?Y3dLTzZtdnNEZ1VpdFl0NUw1OWZHeEZJalVkMnNsMVBZSHlMWFJMeGlHR2lt?=
 =?utf-8?B?bWxWZ2lZd01JbjBKL2pUZTJJemZRR3FpdjRMM29Wb1VyZHRQaGVONVNxN3dU?=
 =?utf-8?B?bjF3L2piWHNaQUx5cms4Q0lXZWlneXlxVHluN2o2RDVQWmxOb3I5aVFNYWp4?=
 =?utf-8?B?Yy9RanJxQ3VuQ2JNNzc3T3d4bzBZVGhldXVERy8wT1loUlE3U1licCtDQmlU?=
 =?utf-8?B?V0tZVWx3blc5RnRVclRvZXNmWUFXamF5L3U2Z2pzeTg3TWZrSzBHTGRRK3Js?=
 =?utf-8?B?Slo3eWR3TFVoREhnSno1N2pqaGlPWTl6K2hPelB0Rkg4YnVobk90TGNiODBY?=
 =?utf-8?B?VUQ1bWdNeFFSVlZmQWQwWHBtK2dxQVN3QlFmeUR0Uk5qRDIzU2dqNzFFeWUx?=
 =?utf-8?B?dVlOOEtnZFBWQm80d1hTR1hDTnFZbjFMUldDU1k0Tm8wb0RHQnVNL1FNcmhU?=
 =?utf-8?B?NG9Jbmg5WE5Iekk1ZXdZcy9OYjcrU0gvUG9WZExXeTE2cGNsL0tVaXR2eWR5?=
 =?utf-8?B?SEo0a0tFQmVYbDIxWC9GcCt4dDVXWGdKWG40ek9KcXhaL0xWOUZKNU1qWU9z?=
 =?utf-8?Q?ehUR06aBjy+J4tFI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FD04FC37D860C4A8D8478E4C9315BF5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mgh1NK14on0TPYVuSOtWDXohK3dUspUvOnNtV/wnKyas/xforjOFhfFMq7zhQiXJVTF9wmRuKkNSa7fB0YZTWwvRZtjf+KMqPF1V082bhFxxjfm8wbKyqyWIyPAFpSrspwRv5ifTOXs7bo9OD5h+tu1wgvQQD+7vyWOJiLuX+pdYKQY/RmZP2vRRfbTgypHCwLBCIi4Gp4u3MRnpcXQuXYf2VkKutmd5Um6356AYv3SGFkOiGmmw3YXAAHhX8Su+ZyDPNTuKnFf+lt1lYTLGkGNtCzRCZTOzb1aTwMFERn/0J+hzgw01O3K3fyaSZZzDj6bdKfWpAx2p63PC+G0h4w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6306f0d-d75f-43ec-6806-08de96dbeed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 08:34:08.2313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xt80bhOG59dkLXPFxg5M1A+GHct3SRaN9SR5gakIrIp1sA5aXevTgQGaMI8HUJn7LgTBJoKlcnh3Ny3XSzmp8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7966

SGkgTHVpeiwNCg0KSSB3YW50ZWQgdG8ga2luZGx5IGZvbGxvdyB1cCBvbiB0d28gcGF0Y2hlcyBh
Ym91dCBhZGRpbmcgTWVkaWFUZWsncw0KQmx1ZXRvb3RoIElEIHRvIHVzYiB0YWJsZSBpbiBidHVz
YiBkcml2ZXIuDQoNCiJCbHVldG9vdGg6IGJ0dXNiOiBNVDc5MjU6IEFkZCBWSUQvUElEIDBlOGQv
OGMzOCINCiJCbHVldG9vdGg6IGJ0dXNiOiBNVDc5MjI6IEFkZCBWSUQvUElEIDBlOGQvMjIzYyIN
Cg0KSXMgdGhlcmUgYW55IG1pc3NpbmcgaW5mb3JtYXRpb24gSSBkaWRuJ3QgcHJvdmlkZSBvciBj
b25jZXJucyB0aGF0IGFyZQ0KcHJldmVudGluZyB0aGVzZSB0d28gY2hhbmdlcyBmcm9tIGJlaW5n
IHByb2Nlc3NlZD8NClRoYW5rcyBhIGxvdCENCg0KT24gVHVlLCAyMDI2LTA0LTA3IGF0IDE0OjUx
ICswODAwLCBDaHJpcyBMdSB3cm90ZToNCj4gQWRkIFZJRCAwZThkICYgUElEIDhjMzggZm9yIE1l
ZGlhVGVrIE1UNzkyNSBVU0IgQmx1ZXRvb3RoIGNoaXAuDQo+IA0KPiBUaGUgaW5mb3JtYXRpb24g
aW4gL3N5cy9rZXJuZWwvZGVidWcvdXNiL2RldmljZXMgYWJvdXQgdGhlIEJsdWV0b290aA0KPiBk
ZXZpY2UgaXMgbGlzdGVkIGFzIHRoZSBiZWxvdy4NCj4gDQo+IFQ6wqAgQnVzPTA2IExldj0wMSBQ
cm50PTAxIFBvcnQ9MDAgQ250PTAxIERldiM9wqAgMiBTcGQ9NDgwwqAgTXhDaD0gMA0KPiBEOsKg
IFZlcj0gMi4xMCBDbHM9ZWYobWlzYyApIFN1Yj0wMiBQcm90PTAxIE14UFM9NjQgI0NmZ3M9wqAg
MQ0KPiBQOsKgIFZlbmRvcj0wZThkIFByb2RJRD04YzM4IFJldj0gMS4wMA0KPiBTOsKgIE1hbnVm
YWN0dXJlcj1NZWRpYVRlayBJbmMuDQo+IFM6wqAgUHJvZHVjdD1XaXJlbGVzc19EZXZpY2UNCj4g
UzrCoCBTZXJpYWxOdW1iZXI9MDAwMDAwMDAwDQo+IEM6KiAjSWZzPSAzIENmZyM9IDEgQXRyPWUw
IE14UHdyPTEwMG1BDQo+IEE6wqAgRmlyc3RJZiM9IDAgSWZDb3VudD0gMyBDbHM9ZTAod2xjb24p
IFN1Yj0wMSBQcm90PTAxDQo+IEk6KiBJZiM9IDAgQWx0PSAwICNFUHM9IDMgQ2xzPWUwKHdsY29u
KSBTdWI9MDEgUHJvdD0wMSBEcml2ZXI9YnR1c2INCj4gRTrCoCBBZD04MShJKSBBdHI9MDMoSW50
LikgTXhQUz3CoCAxNiBJdmw9MTI1dXMNCj4gRTrCoCBBZD04MihJKSBBdHI9MDIoQnVsaykgTXhQ
Uz0gNTEyIEl2bD0wbXMNCj4gRTrCoCBBZD0wMihPKSBBdHI9MDIoQnVsaykgTXhQUz0gNTEyIEl2
bD0wbXMNCj4gSToqIElmIz0gMSBBbHQ9IDAgI0VQcz0gMiBDbHM9ZTAod2xjb24pIFN1Yj0wMSBQ
cm90PTAxIERyaXZlcj1idHVzYg0KPiBFOsKgIEFkPTgzKEkpIEF0cj0wMShJc29jKSBNeFBTPcKg
wqAgMCBJdmw9MW1zDQo+IEU6wqAgQWQ9MDMoTykgQXRyPTAxKElzb2MpIE14UFM9wqDCoCAwIEl2
bD0xbXMNCj4gSTrCoCBJZiM9IDEgQWx0PSAxICNFUHM9IDIgQ2xzPWUwKHdsY29uKSBTdWI9MDEg
UHJvdD0wMSBEcml2ZXI9YnR1c2INCj4gRTrCoCBBZD04MyhJKSBBdHI9MDEoSXNvYykgTXhQUz3C
oMKgIDkgSXZsPTFtcw0KPiBFOsKgIEFkPTAzKE8pIEF0cj0wMShJc29jKSBNeFBTPcKgwqAgOSBJ
dmw9MW1zDQo+IEk6wqAgSWYjPSAxIEFsdD0gMiAjRVBzPSAyIENscz1lMCh3bGNvbikgU3ViPTAx
IFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQo+IEU6wqAgQWQ9ODMoSSkgQXRyPTAxKElzb2MpIE14UFM9
wqAgMTcgSXZsPTFtcw0KPiBFOsKgIEFkPTAzKE8pIEF0cj0wMShJc29jKSBNeFBTPcKgIDE3IEl2
bD0xbXMNCj4gSTrCoCBJZiM9IDEgQWx0PSAzICNFUHM9IDIgQ2xzPWUwKHdsY29uKSBTdWI9MDEg
UHJvdD0wMSBEcml2ZXI9YnR1c2INCj4gRTrCoCBBZD04MyhJKSBBdHI9MDEoSXNvYykgTXhQUz3C
oCAyNSBJdmw9MW1zDQo+IEU6wqAgQWQ9MDMoTykgQXRyPTAxKElzb2MpIE14UFM9wqAgMjUgSXZs
PTFtcw0KPiBJOsKgIElmIz0gMSBBbHQ9IDQgI0VQcz0gMiBDbHM9ZTAod2xjb24pIFN1Yj0wMSBQ
cm90PTAxIERyaXZlcj1idHVzYg0KPiBFOsKgIEFkPTgzKEkpIEF0cj0wMShJc29jKSBNeFBTPcKg
IDMzIEl2bD0xbXMNCj4gRTrCoCBBZD0wMyhPKSBBdHI9MDEoSXNvYykgTXhQUz3CoCAzMyBJdmw9
MW1zDQo+IEk6wqAgSWYjPSAxIEFsdD0gNSAjRVBzPSAyIENscz1lMCh3bGNvbikgU3ViPTAxIFBy
b3Q9MDEgRHJpdmVyPWJ0dXNiDQo+IEU6wqAgQWQ9ODMoSSkgQXRyPTAxKElzb2MpIE14UFM9wqAg
NDkgSXZsPTFtcw0KPiBFOsKgIEFkPTAzKE8pIEF0cj0wMShJc29jKSBNeFBTPcKgIDQ5IEl2bD0x
bXMNCj4gSTrCoCBJZiM9IDEgQWx0PSA2ICNFUHM9IDIgQ2xzPWUwKHdsY29uKSBTdWI9MDEgUHJv
dD0wMSBEcml2ZXI9YnR1c2INCj4gRTrCoCBBZD04MyhJKSBBdHI9MDEoSXNvYykgTXhQUz3CoCA2
MyBJdmw9MW1zDQo+IEU6wqAgQWQ9MDMoTykgQXRyPTAxKElzb2MpIE14UFM9wqAgNjMgSXZsPTFt
cw0KPiBJOsKgIElmIz0gMiBBbHQ9IDAgI0VQcz0gMiBDbHM9ZTAod2xjb24pIFN1Yj0wMSBQcm90
PTAxIERyaXZlcj1idHVzYg0KPiBFOsKgIEFkPThhKEkpIEF0cj0wMyhJbnQuKSBNeFBTPcKgIDY0
IEl2bD0xMjV1cw0KPiBFOsKgIEFkPTBhKE8pIEF0cj0wMyhJbnQuKSBNeFBTPcKgIDY0IEl2bD0x
MjV1cw0KPiBJOiogSWYjPSAyIEFsdD0gMSAjRVBzPSAyIENscz1lMCh3bGNvbikgU3ViPTAxIFBy
b3Q9MDEgRHJpdmVyPWJ0dXNiDQo+IEU6wqAgQWQ9OGEoSSkgQXRyPTAzKEludC4pIE14UFM9IDUx
MiBJdmw9MTI1dXMNCj4gRTrCoCBBZD0wYShPKSBBdHI9MDMoSW50LikgTXhQUz0gNTEyIEl2bD0x
MjV1cw0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgTHUgPGNocmlzLmx1QG1lZGlhdGVrLmNv
bT4NCj4gLS0tDQo+IMKgZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYyB8IDIgKysNCj4gwqAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9i
bHVldG9vdGgvYnR1c2IuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMNCj4gaW5kZXggYTVl
NDQ4ODdhNWI1Li4wYmQ2MjU0YTJmNjMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3Ro
L2J0dXNiLmMNCj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0KPiBAQCAtNzU5LDYg
Kzc1OSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdXNiX2RldmljZV9pZCBxdWlya3NfdGFibGVb
XQ0KPiA9IHsNCj4gwqAJCQkJCQnCoMKgwqDCoA0KPiBCVFVTQl9XSURFQkFORF9TUEVFQ0ggfSwN
Cj4gwqAJeyBVU0JfREVWSUNFKDB4MDQ4OSwgMHhlMTUxKSwgLmRyaXZlcl9pbmZvID0gQlRVU0Jf
TUVESUFURUsNCj4gfA0KPiDCoAkJCQkJCcKgwqDCoMKgDQo+IEJUVVNCX1dJREVCQU5EX1NQRUVD
SCB9LA0KPiArCXsgVVNCX0RFVklDRSgweDBlOGQsIDB4OGMzOCksIC5kcml2ZXJfaW5mbyA9IEJU
VVNCX01FRElBVEVLDQo+IHwNCj4gKwkJCQkJCcKgwqDCoMKgDQo+IEJUVVNCX1dJREVCQU5EX1NQ
RUVDSCB9LA0KPiDCoAl7IFVTQl9ERVZJQ0UoMHgxM2QzLCAweDM2MDIpLCAuZHJpdmVyX2luZm8g
PSBCVFVTQl9NRURJQVRFSw0KPiB8DQo+IMKgCQkJCQkJwqDCoMKgwqANCj4gQlRVU0JfV0lERUJB
TkRfU1BFRUNIIH0sDQo+IMKgCXsgVVNCX0RFVklDRSgweDEzZDMsIDB4MzYwMyksIC5kcml2ZXJf
aW5mbyA9IEJUVVNCX01FRElBVEVLDQo+IHwNCg0KQmVzdCBSZWdhcmRzLA0KQ2hyaXMgTHUNCg==
