Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E507C199935;
	Fri, 25 Oct 2024 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837156; cv=fail; b=Bb24URFENUzqFapmXR9sLQPaKQINOkD1PTO6mmK8dvRSb2Bg5bx4P/8xAXKIRGygTA3WJqacUfqaVn/XjIOf6oDS60pvLIAMy4dTsIUwbX33cok+9bYXKOuwVXQ3Y6FcTho6RHcaLJ4DLLEFR4lRGfZby0FdonFGGxRZ9jPkfJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837156; c=relaxed/simple;
	bh=rhQYhqK0uOAPd49EErzs6fkfUsAEomKM0wa2+pbZebs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K6ftKtF5iiGqsp5L1Sl/iQiGUlUKrtooLh7HVnvaVrZHrs1FBNwki8ATMl4RQ8Gwklkqs5hISNOanUuFkzZmaVaGM8Yba4Qn9PN8nomD2GbtpGKuzGxWTaA5fkMHTGQKTjHm5OC8c5c7muBIWxTi/z2nT9tii2TiUFfK8ICrbns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TUrFuQmX; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=U5R78E1S; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TUrFuQmX";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="U5R78E1S"
X-UUID: 0a9c663a929911efb88477ffae1fc7a5-20241025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=rhQYhqK0uOAPd49EErzs6fkfUsAEomKM0wa2+pbZebs=;
	b=TUrFuQmXbrg1DYaWqMcxN5hB2jnvosxYaXnqPxdVYkj3AxB2O9zk8p/lDmtetd5tgr7F5kST1340xwRogBBJoiUnzaiyu+q01+sI/T1ZVPmwOZrmMJxS++tno520oLl1bH2Qf+0YzbKNFqTt+HAYCgzI1h9zuoHMY8gwXvbwcfs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:1c12a396-cc11-4467-b042-e330de98b5d7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:7f7e172e-a7a0-4b06-8464-80be82133975,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 0a9c663a929911efb88477ffae1fc7a5-20241025
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2109004421; Fri, 25 Oct 2024 14:19:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 25 Oct 2024 14:19:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 25 Oct 2024 14:19:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSbmW3KcFoE8s95ZTvC2iyBBbgtVsRcJR6PmcQzqLqumJ48SHJ3zKCM4jALObAKZcFjk8+p9dSPzS3Ojhk6cahBG3CI1LoLD0QGnYlz+9FoircKu/5cIiv90Pwk3DYqSv5DVUUJ7ohlKseWZPA9LZBO/9wuPyoS9NbPadNz4mZmI3pryBOm3qmk6xR6ioaVXY+UIqKWlvGjmI6rMmcJsAeE7ocRI/pt0GarmQkURZ6IDBy1LBVY1K3JgZDlKG0EYwAH2lJA1Y9VaaDVROOeWf6HQDy7HFHsIOOPSaxsaFTar4ihXif8iu+NbaF6LjE3IsrT3R9BtSDQFsdz7XsjaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhQYhqK0uOAPd49EErzs6fkfUsAEomKM0wa2+pbZebs=;
 b=bmc0hUoRG40Ps0uBEzUteA1TLQF/7gl4H1u9ZRWD0EoETdmNXVIW4uFdlsxgdh8ETnaeLfMiQLudC0dH2tr8hqmGR0ok2wUMw+zmF/01y2TuOqE5avPX98JlKOzKC9iPMzAh5h2cy7+A4ucZeI1IDSTIET9FBCa5oJduu7q2gQo7UprU63EZMvnNEOjR2nYJudpD9/oIlEumuJwy39uN04m9nkqrZ9rwE4puq8ayHdEYbA1ywxKxM7QRm4JuD3IxpC7rArKtJcfY5+YA4RHVAQHLCkVuuD6Wf4JbpGITlX/WGL3wPz44tRTXzyBMhqAJdMafMyFMd9CA+s4QIId91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhQYhqK0uOAPd49EErzs6fkfUsAEomKM0wa2+pbZebs=;
 b=U5R78E1S76OpgnqPngPwLztJvRxQo36TFoUQbobQLSGpv+u9hBjuJDsJf48sP9wJ1bAbPikTiIzKjJAWLPLYQqQKvxFUwcVISZABhWqOru6A0a1X+MP/+WyLpPq2AGlBzrevCwP3HrVyoRNt5CQfvdUcOz6sSbv0Z1y+dIJ8YLE=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by TY0PR03MB6727.apcprd03.prod.outlook.com (2603:1096:400:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 06:19:03 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 06:19:02 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	=?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>, Sean Wang
	<Sean.Wang@mediatek.com>, =?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?=
	<Aaron.Hou@mediatek.com>
Subject: Re: [PATCH v1] Bluetooth: btmtk: adjust the position to init iso data
 anchor
Thread-Topic: [PATCH v1] Bluetooth: btmtk: adjust the position to init iso
 data anchor
Thread-Index: AQHbJT/i41zl0LC95UOboH2xVo7nHrKV/L6AgAEEUoA=
Date: Fri, 25 Oct 2024 06:19:02 +0000
Message-ID: <595973b751b001181fea1da69622b50525445050.camel@mediatek.com>
References: <20241023113626.12236-1-chris.lu@mediatek.com>
	 <CABBYNZLpMCTy8z8ObEU90gqenb58VoB2EZKbZJfWK_J=h45Qew@mail.gmail.com>
In-Reply-To: <CABBYNZLpMCTy8z8ObEU90gqenb58VoB2EZKbZJfWK_J=h45Qew@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|TY0PR03MB6727:EE_
x-ms-office365-filtering-correlation-id: 332fbdd1-f8ee-4dc3-a494-08dcf4bceb7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K0h6WU9Sc3JlaWRyTURHMG9qaHVDcmM4dmlWdWVENHhaR0xadGU0TXl4KzJh?=
 =?utf-8?B?bEVIYnN5K3pYSHpVZFVGVWVjVnEyemRoVEI5OGdQY01TQTl1Z3pscDlyMFl5?=
 =?utf-8?B?TzVUWEw4aTFRNFQ4aHlUTEZvMFE2Z3pKVktzTEVwM3doSmdzNm42YVY3YVhX?=
 =?utf-8?B?dlpQRkJxRkhPS0tkeklwSFBRQ2xqU003b09YNUlEYVY2Tkx3RGsxbUZqWWU3?=
 =?utf-8?B?N1cvNFd1SkdtdndWOC91UGRsVFhrMEQ3Y05oaTFvRldNQjBacnRSa0lMMWsz?=
 =?utf-8?B?ZS9UaitQanNqeFllM0tvNmd2azUwMHZVVUZQLy9DMW1aaDdqcXduUlptbnJv?=
 =?utf-8?B?R3FzK2RFZ1FST1E3MGFnMXZkWFlqZmZQdzRodjlwOVV6MHAzVUptUmlTN0VI?=
 =?utf-8?B?dU9JOExPamlyUkFxVzEveS9kTmFxbGJmZTdTTUtTWUErdGRqZkNaeERtQ3BN?=
 =?utf-8?B?VUxmbkNVSWZPMnlEQXRsQnRFbHlNNnA2S2lJUHlaRjRjWHdEUzNRQTVOeTFj?=
 =?utf-8?B?Q01CVnVJT3BwU1ZBaHErYmFxdnczL2pLcVdWK04yOVkrUThZT2Iva25IR0ZR?=
 =?utf-8?B?R1VnTk9HMUtBV3V6bmthTVRrdEl5SkxaQVBhb1UvN3FYZ3FHSFZlY3pBeDFp?=
 =?utf-8?B?SWpUMnUrTTE5ZmR1K0lVT0twSkViaFdIUFh2RTNlajNTemRCaWtmaDJmUGMy?=
 =?utf-8?B?Q2F2R3dncHQwSkZGalg3akVYSGtGa2NsZzlwTDVYSFpQeEpXS0pBMTdQcWIw?=
 =?utf-8?B?YzdWN2g0WmpQZVdPaXUva1M2SkJBdUpEVStDTkI5ZnlpTjRTSlpHQVVsdFhS?=
 =?utf-8?B?NExOUUVZbkd1V040dCt5TjNNWVRqUWxDbEhjTCtKeS94b0NzR0g1cVljK1Ji?=
 =?utf-8?B?M1F0S2YvV3BFRXlFc1kwd0IyYlRkU1ZWY1NmSE8ybW93Znp2ZDIzYzBKaWIx?=
 =?utf-8?B?M01XbzNleUVZMDRyUDZtSHBLRnRUdXh0Rkx4T0dUb1NncVJhc2w3Y3FGdHNz?=
 =?utf-8?B?MmRjcWZ3d3c4VEZmaGxxdkp3MmgzV1hrNHFrdURiclpkWktBUXNQekN5WXFB?=
 =?utf-8?B?ZkZBQXRxQ1VKZFFYRHFjZFlvTTlONHFkV2w0S25QTEJ3em9hcGgxQk9GSXQr?=
 =?utf-8?B?ZCsyUWxVMnFSVmErRS91K0x4NDh5b0NuTTdod0hYNGpQczlvclRZTHNtL0R2?=
 =?utf-8?B?TFBydzQwUm9lMXhyR0Y1RE44NXRFVVp0NTljS2VrbzVpUDVLVE9IMmZ3eHNz?=
 =?utf-8?B?SFZnUHUyMmJOS2g4NjI5VHlOV1ZsUlNlTFZITkJ1ZEZwK2FSNmoxVWtwNE1l?=
 =?utf-8?B?KzB6akd0cWZ0V3I1aEFQa0Qvb1k0QjhuQkl0R1NtU1hYK1ZWbWhIdUprNjda?=
 =?utf-8?B?Nk1RU2N1ZFcyN3htR2NyWE1OcE9PVEU5S1l6RERvaHNCeDNRaTZDVmVFbHlK?=
 =?utf-8?B?SlZ2ODZRd3liZWo0d1VQcXVFMm9jN0dHZytvVDJsMVd6TytaZ3kzQVAwUEpO?=
 =?utf-8?B?QTQxS3VjREJuak9Qa0c4ZGppcDZEdlRjRDArMGpqRUpYVnJCRkNYaitpb2ZW?=
 =?utf-8?B?WGloZEF1NTlmZGJ4Z1pSQ3J3QmNUN1VyVWlJQy9YZ3R1OWM3OUc5KzJLTGlH?=
 =?utf-8?B?L1lVWTVrVDFCdGd2eHo1OWdNRTVKL3B4R3ovUUpuMHVPWlhWTHNGTHFyVzlV?=
 =?utf-8?B?TTREdUdMLzJDd3c2enBNaXlUZTFPbFNuNkRidzRKbzZVblBNOWQwc0tTeTJl?=
 =?utf-8?B?Yzlzc3JGaDZSMm94czJ0cVBBempMcGZUMW4zVlprckVWbXJnWEtEbEI5NS9o?=
 =?utf-8?Q?Aqvrju6lxQ+GGxY/wwML4qPjM78TOtYdemH4U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmF0anJJY0VYSWxYRGVlVzVCTkZFby9FV2dQdnN1dy92YS9lZE1vbTJLYk9h?=
 =?utf-8?B?YzFVMGdmeDVESTJ3ZlEwekdHczU5MUZMWUtOU1VrWVEzdkhyZzBFeCtrMHJ3?=
 =?utf-8?B?Y0toWXhhZ3Bja05qVlFOWVhERTI3dWkvaS93RlplQWVJRGdHemk1TitBUGFn?=
 =?utf-8?B?OGRHVkFjZC9yTVhjYmIwR08zUklQTVd4LzIxeWxDbDJDRW1kMUxJMWNuTTRu?=
 =?utf-8?B?RTY3bk9aQzF1cWgrYm1OU2tSem53c21sUUVVNFZVYVBhQU5mL3U4NUc1aFJ2?=
 =?utf-8?B?WGZXZDI2NkQxUCs3WitGSzJmbHJYOHVENWZTcGRLMm44bllVMnlZQU1yUThD?=
 =?utf-8?B?azlZOTZRbWJVZ1czSm5uZ3BGL3B4RGhaTENpNFRtL2VrUTVHblNIRDZQckVr?=
 =?utf-8?B?WXNwMUZDSkpNVWtWakY0QnViTVRXcWlNVjF4NzZkMHlkUHNRYWUwb0MyL1hp?=
 =?utf-8?B?cFNrSE8rZWRVclUwdmQxdU5BVDc0L3pMaGRxRVFURDdJOVp1U00vck1pcWEz?=
 =?utf-8?B?NEhVVjVmWmVESWwvTXFqSExDYmxNU2plYzMyRCt2b0cybWdTZ0NjNmwwZHhF?=
 =?utf-8?B?ZUFrV2JqY3NiSCt4eDk2eEthL3VCTXJMN2xhUkJFZExhTHoyeXhJbThrNGpP?=
 =?utf-8?B?TDEvSGNUOVJxTU91aUIrSDhWRW91Y3BZR0JaNHB5Sy91dENMNWtqKzVwd0lO?=
 =?utf-8?B?NWtUOG9tNVY4bTdJTnF4dERkazhsbGhnc05FRk1QbVdpd1hJOFloSmVzTjY3?=
 =?utf-8?B?dC91RnkyU1F2cEp3WVpiYlVzejhWdjM5M1AyTThySGc0MWRpRndpamo1MEJV?=
 =?utf-8?B?TCt4b0M0aXVKS1Z0aXdjcENKbVg3QlRWdzY0SzB0OEhCSzNpYVp2WE15dklE?=
 =?utf-8?B?ajI1anphZW85eGRpZzBEQUxmR1ptcnJVdE5tMUw4NThxMW0xUzVPWi9ocmRY?=
 =?utf-8?B?WDM3c0U1THo2VDFoME5TOEUwdC9FRVYwSWZKTkZVTzRGZG1TNmZ4RnEyWElv?=
 =?utf-8?B?Q0p5ZDNUOTFNSWlRR0RlT1hYVFpqOFYrS0NtWGMrQ3FXcWRRWlp2KzQzRHlT?=
 =?utf-8?B?U2w2QlRwTFhsU2pVMk5MajAwKzY2citCWVBpRStaWFZhM2EyaXY0a2dEclFy?=
 =?utf-8?B?MzJtNklaN2pITGtmRUtvZFAvbitKNmRSWkZWelFXMUlCWGtKa2xvN1dUNXY4?=
 =?utf-8?B?WTBUQkRPSm4zYWgwRFZXdGVYRjhiNVh1S3paei9uNWE2NUVSa0lXYXI2YjZV?=
 =?utf-8?B?MFhwZEs1aXlZSnlyVHlzd1dVOVgrR2RTY3hJT3Z1NWVIc2ovZUExZmRlRTI3?=
 =?utf-8?B?STVsOWt1cTFRbHFkUklsSW8xa0lIUEFIVFVGWXczcGRaNGFoSFZHWjIybjV1?=
 =?utf-8?B?cTlTQ2Vzb1dwaVhnTXh1NWUwZWNaT0FzM3FGSHFobzFUOHAvWVZWRUZEMVhi?=
 =?utf-8?B?TlRKd3Q4ODNwSXNlRzZhdFpKSTZqNmh6U3Q0cG1jaGROdFA3SDU0TlZicnJq?=
 =?utf-8?B?dnNlT1pxL3lJSy9YT0dGZ3g0R2Nnd3ZXZGlmMkpxSGdZOUxMK290VTI1RnU2?=
 =?utf-8?B?dFZlbWlIQzI3QUdmRDhhRDlwaTB4UzkyYVJuUFNRczNBam42V3NjbXNFbjN6?=
 =?utf-8?B?YUtwWC9TZFhua3hTdzcyaFNnWHlZNzg1ZUZ1TkZKQzZGazdRUllQMHhoK29K?=
 =?utf-8?B?cktHSHo1MVkvWFE1Sm9YcWdyTFBHd200U1grR2RJVVN5bHpNOXgwL0sxVWMz?=
 =?utf-8?B?eFl0bFN1S3M2bFlmcjhId2pTOU5XNnVkTVpOZ1gvODdBZ2VraW5NUmIwRmxz?=
 =?utf-8?B?bXB6c2ZRZjJIOTNqWEVXZlJuazUvd2tTWG5xS3RjUTZCdzdrbDRwSmhnV29y?=
 =?utf-8?B?eHd5cTRXVy9hTXZKRTM1TFA2bXVVL0lSS0JwOUEvZzgvZmxZMXZ2TkxXZ05M?=
 =?utf-8?B?VW1COFB0MkZMMGh3aHJuVTk0OVlndDd0N0N0MEVrek5OUzFEenRDdk1WK29o?=
 =?utf-8?B?amxHd3E1SVA1ZEExR3hsdVk5Z2xpbjArNzVUU2E0N0poKzRpckx1VktRODlw?=
 =?utf-8?B?cUNIRCtOb2g5NjZPUXZWNzdnTmtHNVBlRlowVVp3OXBmYkcvaDN4R3dRS2Zu?=
 =?utf-8?B?MWtjZlRuWkcvMFFOV24yc29TaFFIZW0wcE1nS01iTnQ1VGlTb25SdElwWkwx?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9456D738D50AD542BD31C26F74670B73@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332fbdd1-f8ee-4dc3-a494-08dcf4bceb7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 06:19:02.1315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wCE/RZcUA0fXhMT3JjdVQzZUQ+mZxaoMJl8+mBuvSc/1QfvW5tWfDcUBfLx+lP84gv/+iOp1K2xu0SWmDc8D2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6727
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.287400-8.000000
X-TMASE-MatchedRID: 6otD/cJAac0OwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0rfEt9Ay9zO7ifZYRtbOr2tSEQN/D/3cG7ljSRvSGpq3Gd6vNuG6CqynJl
	qVKcsJUg6lNHl8VwK1UauvlED5EuwwwTYGyiIoky04Y/NhTxUgtIv4RV84lHT/Z2SSD7R8hSVQ2
	bE9K2FguLJAFDOOYm47hAaNENZjh8cpQFoU5/IHVVN8laWo90MEtdrY/Wb3fPADa2OEam+xkUWS
	NUeoUM2IV4u8YKdeKsBtjkcfRMmqbbpplP4MuvUbc297PAGtWZ9LQinZ4QefKU8D0b0qFy9suf7
	RWbvUtyrusVRy4an8bxAi7jPoeEQftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.287400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	02E35FB3AA723C7888086786958FAA5B42A0BF42AEAADBAC28ADB46FE5D752682000:8

SGkgTHVpeiwNCg0KT24gVGh1LCAyMDI0LTEwLTI0IGF0IDEwOjQ3IC0wNDAwLCBMdWl6IEF1Z3Vz
dG8gdm9uIERlbnR6IHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVy
aWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEhpIENocmlzLA0KPiANCj4gT24g
V2VkLCBPY3QgMjMsIDIwMjQgYXQgNzozN+KAr0FNIENocmlzIEx1IDxjaHJpcy5sdUBtZWRpYXRl
ay5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gTWVkaWFUZWsgaXNvIGRhdGEgYW5jaG9yIGluaXQg
c2hvdWxkIGJlIG1vdmUgdG8gd2hlcmUgTWVkaWFUZWsNCj4gPiBjbGFpbXMgaXNvIGRhdGEgaW50
ZXJmYWNlLg0KPiA+IElmIHRoZXJlIGlzIGFuIHVuZXhwZWN0ZWQgdXNiIGRpc2Nvbm5lY3QgZHVy
aW5nIHNldHVwIGZsb3csDQo+ID4gaXQgd2lsbCBjYXVzZSBhIE5VTEwgcG9pbnRlciBjcmFzaCBp
c3N1ZSB3aGVuIHJlbGVhc2luZyBpc28NCj4gPiBhbmNob3Igc2luY2UgdGhlIGFuY2hvciB3YW4n
dCBiZWVuIGluaXQgeWV0LiBBZGp1c3QgdGhlIHBvc2l0aW9uDQo+ID4gdG8gZG8gaXNvIGRhdGEg
YW5jaG9yIGluaXQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBMdSA8Y2hyaXMubHVA
bWVkaWF0ZWsuY29tPg0KPiANCj4gUGxlYXNlIGFkZCB0aGUgYmFja3RyYWNlIG9yIGEgTGluayB0
YWcgaWYgdGhlcmUgaXMgYW4gaXNzdWUvYnVnIG9wZW4uDQo+IEFsc28gaXQgaXMgaW1wb3J0YW50
IHRvIGFsd2F5cyBpbmNsdWRlIGEgRml4ZXMgdGFnIHdpdGggdGhhIGhhc2ggdGhhdA0KPiBpbnRy
b2R1Y2VkIHRoZSBwcm9ibGVtLCBzcGVjaWFsbHkgaW4gY2FzZSBvZiBhIGNyYXNoIHNpbmNlIGl0
IG1pZ2h0DQo+IGJlDQo+IGEgZ29vZCBpZGVhIHRvIGJhY2twb3J0IHRvIGZpeC4NCj4gDQpTb3Jy
eSBhYm91dCB0aGF0LCBJIHdpbGwgbWFrZSBzdXJlIHRvIGluY2x1ZGUgdGhvc2UgaW5mb3JtYXRp
b24gaWYNCk1lZGlhVGVrIGZpeGVzIHN1Y2ggS2VybmVsIGNyYXNoIGlzc3VlIGluIHRoZSBmdXR1
cmUuDQoNCkkndmUgc3VibWl0dGVkIHYyIHRvIGFkZCBiYWNrdHJhY2UgYW5kIEZpeGVzIHRhZyBp
bmZvcm1hdGlvbiB0byBjb21taXQNCm1lc3NhZ2UuIEJUVywgSSBhbHNvIG1vdmVkIHRoZSBwb3Np
dGlvbiB0byBkbyBhbmNocm8gaW5pdCB0byB0aGUgZW5kIG9mDQpzYW1lIGZ1bmN0aW9uIGluIHYy
IHdoaWNoIHdpbGwgbWFrZSB0aGUgZmxvdyBtb3JlIG1ha2Ugc2Vuc2UuDQoNClRoYW5rcyBhIGxv
dCwNCkNocmlzIEx1DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmMgfCAx
IC0NCj4gPiAgZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYyB8IDIgKysNCj4gPiAgMiBmaWxlcyBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2JsdWV0b290aC9idG10ay5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnRtdGsu
Yw0KPiA+IGluZGV4IGI3ZmMxNGFhZmM3NC4uOGEzZjdjM2ZjZmVjIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmMNCj4gPiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9i
dG10ay5jDQo+ID4gQEAgLTEyMTUsNyArMTIxNSw2IEBAIHN0YXRpYyBpbnQgYnRtdGtfdXNiX2lz
b2ludGZfaW5pdChzdHJ1Y3QNCj4gaGNpX2RldiAqaGRldikNCj4gPiAgICAgICAgIHN0cnVjdCBz
a19idWZmICpza2I7DQo+ID4gICAgICAgICBpbnQgZXJyOw0KPiA+DQo+ID4gLSAgICAgICBpbml0
X3VzYl9hbmNob3IoJmJ0bXRrX2RhdGEtPmlzb3BrdF9hbmNob3IpOw0KPiA+ICAgICAgICAgc3Bp
bl9sb2NrX2luaXQoJmJ0bXRrX2RhdGEtPmlzb3J4bG9jayk7DQo+ID4NCj4gPiAgICAgICAgIF9f
c2V0X210a19pbnRyX2ludGVyZmFjZShoZGV2KTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9i
bHVldG9vdGgvYnR1c2IuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMNCj4gPiBpbmRleCA5
OTcwNDcwYzlkMTUuLjE1YzA4ODVjMzdjZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2JsdWV0
b290aC9idHVzYi5jDQo+ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0KPiA+IEBA
IC0yNjI4LDYgKzI2MjgsOCBAQCBzdGF0aWMgdm9pZCBidHVzYl9tdGtfY2xhaW1faXNvX2ludGYo
c3RydWN0DQo+IGJ0dXNiX2RhdGEgKmRhdGEpDQo+ID4gICAgICAgICBzdHJ1Y3QgYnRtdGtfZGF0
YSAqYnRtdGtfZGF0YSA9IGhjaV9nZXRfcHJpdihkYXRhLT5oZGV2KTsNCj4gPiAgICAgICAgIGlu
dCBlcnI7DQo+ID4NCj4gPiArICAgICAgIGluaXRfdXNiX2FuY2hvcigmYnRtdGtfZGF0YS0+aXNv
cGt0X2FuY2hvcik7DQo+ID4gKw0KPiA+ICAgICAgICAgZXJyID0gdXNiX2RyaXZlcl9jbGFpbV9p
bnRlcmZhY2UoJmJ0dXNiX2RyaXZlciwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGJ0bXRrX2RhdGEtPmlzb3BrdF9pbnRmLA0KPiBkYXRhKTsNCj4gPiAgICAg
ICAgIGlmIChlcnIgPCAwKSB7DQo+ID4gLS0NCj4gPiAyLjE4LjANCj4gPg0KPiANCj4gDQo+IC0t
IA0KPiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQo=
