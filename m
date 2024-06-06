Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054BA182BD;
	Thu,  6 Jun 2024 03:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717642893; cv=fail; b=Gt6dyFTEQmIryhlfBVMDoeQ/w+fWnARZEIekOv0ZmQeJ10BAwn3ryVawcSZkstZnpnJlsYw2D+aeEKHvnYzs5phuy8rfnVCEIxK1lUaSc56nGgz+3RA6SmFtVQYUJhqcIx6bC52K2a0Lvxl23MvUjyokAX+/wQ17FCUaBEphJuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717642893; c=relaxed/simple;
	bh=HkXI66yP8YwZ9Jur7C47Zgr6Ct0TcqVHbKkgMiqxlnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R6PaZ9hw+nngyPZ5ZY7/79WsrZnIhu2S+iz16WlAOKz2CmPTTRD81VLcya9AsM9mSk8WgeFbb8HlNuACmMUY40yYepkdCprwK4cBT3q6u8jY6BIeLjEMK/Z8olDnyx/Es5gi5pvhZjASZhLzDiJErGzz7nKQ/Uh3qBwtrlPhQHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UwCSyslw; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=f9jKXCZ0; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UwCSyslw";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="f9jKXCZ0"
X-UUID: 0ff31cac23b111efbace61486a71fe2b-20240606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HkXI66yP8YwZ9Jur7C47Zgr6Ct0TcqVHbKkgMiqxlnQ=;
	b=UwCSyslwmxMOzpv+4KN8qi64M9uaTvNRiy2IUIR74kWWHYh5VPTxW5KXLm/87h3Ow0n4ajT6HYiPTwEdddnG4QACpeeBAmi8DIkDY7OFx0igFRSuDBZGvb04d9zbWmeGRLI0yd93WomxIWn1uIWBAYaMkrraa9TsNJzBBerU9R4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:cf5bdabd-9da6-46b7-8090-299fb833733f,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:393d96e,CLOUDID:6b454588-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 0ff31cac23b111efbace61486a71fe2b-20240606
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1473506816; Thu, 06 Jun 2024 11:01:25 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Jun 2024 11:01:24 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Jun 2024 11:01:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GN4N6BIZdhx8rf5b68/oq7D32arh+KktF9KigM0f6d++8SY4RGYy90MqZeldHg0qikLXuWP4P4WaFgfF8pvLFoZY/X8p3Hx8TiKK6Avynvx2VmcygZhyKNC7QRlkcKRFGimn1NvB7sR5pwYth24RhPFkuuAVw6xgrpeBoWeMmBbRkuP7kfhqGvCbOwahzthQvPx/Q1g5h1dqaMaCbV6OE12fM1OGTaVK3Jt44jt7YEVXr5QqhfUo7IwuTVWatuUWYQBTF0olVyCXT5/2O2Il4SL9E9K36KO4bze/4fEKdYX30mYCh+PWRArsMfP4YZ2qNgh8xkOkmL0Vago5KJvCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkXI66yP8YwZ9Jur7C47Zgr6Ct0TcqVHbKkgMiqxlnQ=;
 b=kKGPjtG3ad51QGPYuxpA4y/bdJ4h2oHHfuchumcmR5UaoBmOwKfUmUv6l6nykL1zYSLGwdKWekD7fFMdTf+rigEsS0y6WGxy6JztsQoYZKOBLf4KQWT2ALVxCQREBUXtdpq9vFhUHJ8LwtYlYljToGJYZ+XC6pbu6c5wpQOmeFx1ajhS0IV6mI9pviZ+uaYt+dvogtF1IXliyjG2TUbz4/G9Vw88BChUYWoLEwWPHXJuT0vKkhgz5EbJyu5nfUEzXbemTK32Mvtv21pPoj7olaUDcDBmfvtA+Wngz0gw9OxES6v68UgfBYhvPT5cUpO7/jRqkjitG249yVRUUlK3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkXI66yP8YwZ9Jur7C47Zgr6Ct0TcqVHbKkgMiqxlnQ=;
 b=f9jKXCZ0uKVj0ZXnBCsGwBcjCijkM+f3c2dhemP4om6ewJSFCHijW+vlG5HSOiquo6BUs2RoLmGzhHOVOrZqHATQEgkahOA+FbGPIsetpUMEQLdv14YT+p+CEGC5tJNaL0vgAFo6hmG0Kn+fDzjmOLIEfkI40jErKHSlr79cbLs=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by JH0PR03MB8236.apcprd03.prod.outlook.com (2603:1096:990:50::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16; Thu, 6 Jun
 2024 03:01:22 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf%2]) with mapi id 15.20.7656.012; Thu, 6 Jun 2024
 03:01:22 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "lkp@intel.com"
	<lkp@intel.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	=?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>, Sean Wang
	<Sean.Wang@mediatek.com>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, =?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?=
	<Aaron.Hou@mediatek.com>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH v2 3/3] Bluetooth: btusb: mediatek: add MediaTek ISO data
 transmission function
Thread-Topic: [PATCH v2 3/3] Bluetooth: btusb: mediatek: add MediaTek ISO data
 transmission function
Thread-Index: AQHasZG1zamCUZ6Et0Oxwkvz4PAqqbGu13qAgAqrnoCAAJVigA==
Date: Thu, 6 Jun 2024 03:01:22 +0000
Message-ID: <e03d2d685542d11fe6369d12b9b3abc6ac2e96af.camel@mediatek.com>
References: <20240529062946.5655-4-chris.lu@mediatek.com>
	 <202405300602.AUh9Yu96-lkp@intel.com>
	 <CABBYNZK53Fx8rmanh6fsLsNjppEtThtis8naKa11nLk3gCHbLQ@mail.gmail.com>
In-Reply-To: <CABBYNZK53Fx8rmanh6fsLsNjppEtThtis8naKa11nLk3gCHbLQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|JH0PR03MB8236:EE_
x-ms-office365-filtering-correlation-id: c874e234-4ca3-4788-0f6f-08dc85d4f21f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bWNIMzZobmxQSVAxQ2Z1MEtEVTQrMEl6d3NqN1pmcGF2VkdrekZLNkpMcEZF?=
 =?utf-8?B?K2FqMzFCdm9iYzB4V2EyWGkyOUFuOHJTZFJIZzBNK24zWHByQW5RSlpIUFZn?=
 =?utf-8?B?bmgwcTRhSytFQU1PeWNjZ0JpN3VjWURuS24vREV4bWFkVVZTWWxBb1N5VWNr?=
 =?utf-8?B?T0J6Ty9NUGxiRGtHU01jWEp2QWd3c3NFSzRWU1lEUHZIejVWeUdSaUxTRlov?=
 =?utf-8?B?bFZvaldvN2pNU1U4c0FFNW41NlVFQ2dUWUh5SzNCSVhaL3NLZ3FJNkh4dy9l?=
 =?utf-8?B?b3FyY3cyV0xhWUlPYW1XRW05SDRON2hjU2VHM1VvbFY4OW5BNVdyZVlkWFNy?=
 =?utf-8?B?N21FK3hleVllTndScloxTW83L3lxQXZvUVIzNEM4akhRY1N3WElEQVRKVndj?=
 =?utf-8?B?dGxiRGJDTTdvWklnRUF4K2FTaHUvVVpGZW1EUVJhV0wvZmJkb3MxeUcvUlpV?=
 =?utf-8?B?cXFtdkhVZ0JjVG90YVpDUjdycnBoOE9GWmtRVHUvZms1YkFjVXJDUjZ3STBU?=
 =?utf-8?B?VUxrZDhoSm9TSWp1U0RrbzgxUHJIbUp2eDBYSWhmWGtYT0FUOTRsUU9kN1Bz?=
 =?utf-8?B?cFFhTUZJR25pclJ3TjN2NWVWQk5QYWRSNDV3Mjdwc0swREthVFBjcjh0RFE4?=
 =?utf-8?B?Nmg2WUJEV2l6SUhuMW04ZnNLRDRGSkwyeWxHUzVJdk9CV2prakxjNk1QZ2p0?=
 =?utf-8?B?V25Remp2UlhFWWFab0tOcGZDZ1RXSEg2WWs0cDFpSS9zQ0wzNktqVklucldy?=
 =?utf-8?B?dEwwYy9rNjVySnljSHF0TkZPem1jWENIU0o0cDJSSWVGbGwzUkRwYlVsbUVU?=
 =?utf-8?B?WmhIZklEMWtuMyt3UHFDNEJQYnVqc3MrQlVRQjRzcENvd2Q2QVhPZnhJeXJW?=
 =?utf-8?B?dVhQUEZWd2tRQzZhWEdYb2dZMHVZd0dXRDJ2OWltMnNzSDBtekFjQlVvOUkv?=
 =?utf-8?B?VTBZWXJjM3RkRENiR1U5aDNQZmRJUzVSQ2VZWWpMQnFoYll1L1Y5SEZzbUE0?=
 =?utf-8?B?SHZBVUtRMHlRQ21PNmprZUJ0WFZxMThRMGZZVHpDdU5JN1dFM3R0d2ZwT25r?=
 =?utf-8?B?TU5NOHNNWjZzTFVJR29qM1ZXZHI0TEs3OElLaFBEaHRhMklqVUpnVUFGQTJ0?=
 =?utf-8?B?bUNQdW5ETTNGRzRROXhHVm4yKzRxSXlKTHlGU2ZBMFdSVThEODZjTXp1SlNj?=
 =?utf-8?B?T0tqV1VRaUh4VnZxYXpGT3JpajdacUhOcDJVUTA3RTRIak94cjhEUE92cTBT?=
 =?utf-8?B?TExRMEhkMi90WjVPdVZuMDhsZlB4akhvMTNtd2xHNnZzalcwZjN1TndhYjUw?=
 =?utf-8?B?MHIxRmM4dUlkWG83Y2QvME1idmtIZXFiZS9zanlPbXczdk0wbzhJenI3NEVD?=
 =?utf-8?B?V0RHTnZhY3RJZGxyREpDVnd2MERjVWo0eEVGUUFuOXFzc1p1YWFzMFBwTndX?=
 =?utf-8?B?WTlpOXUveDl5NzFlMTlrRmJ1UGtPY1lES2lBalBWd0c1SkxMN2VJQk15ZHlC?=
 =?utf-8?B?QzB2bURyaFNVa2FtTWRScVJNSERsWkR3SkJIMUp1YVFjM3VKMDFHOFJST0t6?=
 =?utf-8?B?ZisyQ3ArZHBBNkpoVzA3d0lyeEp6TUNTdXNTU1ZCRkZzRFNFdjQzZDd6dWlq?=
 =?utf-8?B?dElXMzdhWG4xY2QyZUxOdmtibWRoa2RNMVJpZWd0UmJSS1RlYlAwQzFXZDJs?=
 =?utf-8?B?T0duVU02dmx4NnZ4SVVYdE1SSnNYbjdXQk1pYVRxRCt4UmVqWmV6OVhDZ0dr?=
 =?utf-8?Q?zw6voSAjACxZwy34wNkod4KiNsWcDmqRvrHWoL8?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGtZSXc0cUllODV0djZlVWVzMnVTL2ExdFFVelBRdlFFcG9FKzBuaGhDMzU2?=
 =?utf-8?B?S2dpTFJZMzFDeEREYTJUaDFCczlLQ3VDTDdQOXBnZ1lUUEh1aEpiQllVNnN2?=
 =?utf-8?B?VTJPU3o3T1psT2MwTHhxWUVwTE5TSW9YOGkzenFsazRmUGtQdk9SUGNTczRL?=
 =?utf-8?B?ZDROYWdGVUJEdHIrcmkvbFZpRVVIZ3VOT1U3Ri9wekFIeGIzMk9JZG9mUWVq?=
 =?utf-8?B?ZndlSlpoc1hRWkFoWk5jKzMzRzk3ejBpWm5DZEZxeTVVcTRNN0NkNDloNWV1?=
 =?utf-8?B?RlZoYlE3R0JVdmsxeFVUQ0JHbkZtMHp4OVFxeVZWK3krUFNhVDhza0p0WktD?=
 =?utf-8?B?MGdsMS8xRk5RdnFXWXZwWHZxTHZWS1ZUSU5UTkpLZG9ENjNrb2FCZ1M0TUsr?=
 =?utf-8?B?b3pZNDN6VG11MURodmxQajVkcDMxZjZtTXhud1pMOWVuOHJTK2tFdVNibE5L?=
 =?utf-8?B?cXV5NlRnRG1sODE5K2Q3Q0pTdFNCREJFcGFkcWc0WGNFelJ2Tkc4RjhnOW1P?=
 =?utf-8?B?eTVkdUJVNk5MUWQxWFZoY3V4ZGlFK09VcmJRZi9VTlUyQ1hzQnpqcEdoUGRF?=
 =?utf-8?B?amdEVFVDSDJzSE43VnExcEJpODNSVHJ0VVZLUWNxaC9pajR1b2YxN012d1RF?=
 =?utf-8?B?SStkMmZPVktET0dCeFpiaTVmblZVeTBlWldGZ3NaZW9NR2F6TDNmdGhlb0E4?=
 =?utf-8?B?NGJ3VjJWdTZ3WksvbjNqUVBZdWRncEhVWFRuemdnNHNOU1F4dkVPa3ZwNVNE?=
 =?utf-8?B?aFNxY1hkUEFoMWpvcEg5U2k3WjNZd2RHYmxjTHVOMm05NXorNldId21WelNw?=
 =?utf-8?B?ajcwOGd3V1dvdGd1ZWNaSGR6ek1IM2xNaHN5c1J3SXl4TVA2OVRIVmo3YXAw?=
 =?utf-8?B?SmNxZzBmWmZFY3Z1NS9FbU96QW15dEcyMWJFemplYlRnTGkvaHFkOVdPWGZo?=
 =?utf-8?B?KzJrOXRMTTNKRDRNbVF0RmRES0MrejBWMUQxdlkxOENRWjBEa0d1bjM3WVpU?=
 =?utf-8?B?VVpxUjU4MlN5R1VDenBzc1Z1NE4yR250SXNhWEE1WkxVVnBIMUhQVmJUaFBi?=
 =?utf-8?B?R0RZU3doS2txWnQ5TWpiSW5NSW41REZyamYwd0RMc01kYjhCT29GdE1Kand1?=
 =?utf-8?B?eXNuOE5LQUN3TTdDYmFITkMydm8zUWduUU5lbTJvTU1JbU1pKy9jSzNuTGdY?=
 =?utf-8?B?bjlCVFlGZTVPWXZuZFgyRUxHZ3JPb3MrTmxTWXovTE5ZWmVhRUlreTNjREEy?=
 =?utf-8?B?RXhlTmRZVWp5bXpqUjRTRnpjSHgveWFkckVqTTc0cmZPRm9XVlBqRk91QnpX?=
 =?utf-8?B?dStTVGpsQUJkQnhsVko4OFViYm9XR0c4NXJqYTdoNEhxMWNVZzJnQVFrUzJT?=
 =?utf-8?B?N0NSYngyS1JWVFhMTUMrRTdka1ZVc1hhZlBBeDNUNnRvUTQyejVlNURaOGZz?=
 =?utf-8?B?bW5neWgwZXJveWVvazRtM1haMU1aMkRmVzAreXZDL1FETkZuWWR2UnJmKzR2?=
 =?utf-8?B?MUQrRjIvRE5VRG16TUV5TitWOFhEbVZHWExUUlF1UXNtNjRzTjBSQ2t0QWRv?=
 =?utf-8?B?QVd1d1QveHZTdTZHVWVmTkd1NytTWVBGL3BBb2N1MFY4djl1SGphc0d1Sk80?=
 =?utf-8?B?ZGRKL0dSaTlDbWxhOFJLbjhsaXJRc3FkSmsvNWxZWUJlaHBIakdrQ1dPOXpa?=
 =?utf-8?B?N3AvWXR1NEVUM2lnbjVnSjRoU0dyWi9EcGpKRzZyT1MwNXlSVjdja250aENY?=
 =?utf-8?B?MTNCbmUyL0dDdjBBeGFuWCt2MlFCMldoT25NOFdsSVNoUmlJcEswU1l1SHRX?=
 =?utf-8?B?ZCtzSzRYNThyMDV0TW1rdjB6L25yb3dMN2hJVnhkb1B4d2lKaHdudWFFWlFu?=
 =?utf-8?B?MEl1c2llL1JmN3FYMmNwT2N4TS9kZ2l1U2hTdy9HdDJOdFJoU2lFMlBOZmsv?=
 =?utf-8?B?RHBGZ3NNSml4Z1NRTUwyYy9PUGwxTjVtT3NLblR5Y3RaSWxuUHdjV0dCZDdK?=
 =?utf-8?B?SzBibTNOU0lQazh5N0h3OERXSGdqZFZMV2tpWUU5V3VNRTZ3eWZ5aENIZmxS?=
 =?utf-8?B?VkI5RTlYakRucllESTM3YmZvcmc4dUd2OHdDNU9aWURrOXJ3eVdXbnQ5WURL?=
 =?utf-8?B?VXdCR1U2MlhaVEhWakNaRld2S01Pelp2Zk9oMmZyRHlhbS80V3Q3VEx5YXdv?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8CB471E97546D468F40D8BE890B4CFD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c874e234-4ca3-4788-0f6f-08dc85d4f21f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 03:01:22.1336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kiGkkr1YgTkkRa79X9H6EqSqqEOlTgPOTgfhNnGICudxIttFDzplNW4TcUwI7eAv46TDlrgp6ENCRV2RtPItQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8236
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.917600-8.000000
X-TMASE-MatchedRID: C/snMIRQLS2nykMun0J1wpmug812qIbzvtVce6w5+K99WQH9y/pSXRpU
	JOgv093xqAiL+D9B+BpbAeHsEbW6gW0AffdZMVlDlGudLLtRO1uMs7LXcKBvj+fR40+Y897kpbN
	aghGJX0Mz9J7+r+ATJ/kyJLszxzV4aZcyLs23KjYZXJLztZviXF3KZkFy4YZEnp2mAS3hGeLabn
	9rCMsYTgCcACCs6ncVYW47rs9hAEnMHUInqqZ02p1U1lojafr/UKlt4AyW7uDjud2x7TPVt+oAI
	QX383DdvjLJcslQ0rgroSXEo28ySwi9LIdJLRICVU3yVpaj3QwZskwWqoib3AIH2h2T9kPwg1rA
	2EcuXratP8EqUrIoNN3aGFWi0hbJL0W1btd8e56VCT+7xcp60V3g6vec15lkGM7yl/HgfuB8VEc
	pJdDXGxIzlTSvMv2lkYFGmjmOignzNZjRxuo8vp4CIKY/Hg3AwWulRtvvYxTUHQeTVDUrIiOHCQ
	wuRJVLjaPj0W1qn0SQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.917600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	F5B4457AC643F3326263426E4F6C431173FB79C4E6D75AA866C4285143C74A612000:8

SGkgTHVpeiwNCg0KVGhhbmtzIGZvciB5b3VyIHJlbWluZGluZywgSSB3aWxsIGZpeCB0aGUgZXJy
b3IgYW5kIGZvbGxvdyB5b3VyDQpzdWdnZXN0aW9uIGluIGxhc3QgbWFpbCBhYm91dCBtb3Zpbmcg
c29tZSB2ZW5kb3Itc3BlY2lmaWMgY2hhbmdlIGZyb20NCmJ0dXNiLmMgdG8gYnRtdGsuYyB0byBt
aW5pbWl6ZSB0aGUgY2hhbmdlIGluIGJ0dXNiLmMuDQpJJ2xsIHN1Ym1pdCBhbm90aGVyIHZlcnNp
b24gc29vbi4NCg0KVGhhbmtzLA0KQ2hyaXMuDQoNCk9uIFdlZCwgMjAyNC0wNi0wNSBhdCAxNDow
NiAtMDQwMCwgTHVpeiBBdWd1c3RvIHZvbiBEZW50eiB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFs
IGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
dGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBI
aSBDaHJpcywNCj4gDQo+IE9uIFdlZCwgTWF5IDI5LCAyMDI0IGF0IDc6MTDigK9QTSBrZXJuZWwg
dGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBIaSBDaHJpcywN
Cj4gPg0KPiA+IGtlcm5lbCB0ZXN0IHJvYm90IG5vdGljZWQgdGhlIGZvbGxvd2luZyBidWlsZCBl
cnJvcnM6DQo+ID4NCj4gPiBbYXV0byBidWlsZCB0ZXN0IEVSUk9SIG9uIGJsdWV0b290aC1uZXh0
L21hc3Rlcl0NCj4gPiBbYWxzbyBidWlsZCB0ZXN0IEVSUk9SIG9uIG5leHQtMjAyNDA1MjldDQo+
ID4gW2Nhbm5vdCBhcHBseSB0byBibHVldG9vdGgvbWFzdGVyIGxpbnVzL21hc3RlciB2Ni4xMC1y
YzFdDQo+ID4gW0lmIHlvdXIgcGF0Y2ggaXMgYXBwbGllZCB0byB0aGUgd3JvbmcgZ2l0IHRyZWUs
IGtpbmRseSBkcm9wIHVzIGENCj4gbm90ZS4NCj4gPiBBbmQgd2hlbiBzdWJtaXR0aW5nIHBhdGNo
LCB3ZSBzdWdnZXN0IHRvIHVzZSAnLS1iYXNlJyBhcyBkb2N1bWVudGVkDQo+IGluDQo+ID4gaHR0
cHM6Ly9naXQtc2NtLmNvbS9kb2NzL2dpdC1mb3JtYXQtcGF0Y2gjX2Jhc2VfdHJlZV9pbmZvcm1h
dGlvbl0NCj4gPg0KPiA+IHVybDogICAgDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC1sYWIt
bGtwL2xpbnV4L2NvbW1pdHMvQ2hyaXMtTHUvQmx1ZXRvb3RoLW5ldC1hZGQtaGNpX2lzb19oZHIt
ZnVuY3Rpb24tZm9yLWlzby1kYXRhLzIwMjQwNTI5LTE0MzIxNg0KPiA+IGJhc2U6ICAgDQo+IGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2JsdWV0b290aC9i
bHVldG9vdGgtbmV4dC5naXQNCj4gIG1hc3Rlcg0KPiA+IHBhdGNoIGxpbms6ICAgIA0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQwNTI5MDYyOTQ2LjU2NTUtNC1jaHJpcy5sdSU0MG1l
ZGlhdGVrLmNvbQ0KPiA+IHBhdGNoIHN1YmplY3Q6IFtQQVRDSCB2MiAzLzNdIEJsdWV0b290aDog
YnR1c2I6IG1lZGlhdGVrOiBhZGQNCj4gTWVkaWFUZWsgSVNPIGRhdGEgdHJhbnNtaXNzaW9uIGZ1
bmN0aW9uDQo+ID4gY29uZmlnOiBpMzg2LXJhbmRjb25maWctMDE0LTIwMjQwNTMwICgNCj4gaHR0
cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjQwNTMwLzIwMjQwNTMwMDYw
Mi5BVWg5WXU5Ni1sa3BAaW50ZWwuY29tL2NvbmZpZw0KPiApDQo+ID4gY29tcGlsZXI6IGNsYW5n
IHZlcnNpb24gMTguMS41ICgNCj4gaHR0cHM6Ly9naXRodWIuY29tL2xsdm0vbGx2bS1wcm9qZWN0
DQo+IDYxN2ExNWE5ZWFjOTYwODhhZTVlOTEzNDI0OGQ4MjM2ZTM0YjkxYjEpDQo+ID4gcmVwcm9k
dWNlICh0aGlzIGlzIGEgVz0xIGJ1aWxkKTogKA0KPiBodHRwczovL2Rvd25sb2FkLjAxLm9yZy8w
ZGF5LWNpL2FyY2hpdmUvMjAyNDA1MzAvMjAyNDA1MzAwNjAyLkFVaDlZdTk2LWxrcEBpbnRlbC5j
b20vcmVwcm9kdWNlDQo+ICkNCj4gPg0KPiA+IElmIHlvdSBmaXggdGhlIGlzc3VlIGluIGEgc2Vw
YXJhdGUgcGF0Y2gvY29tbWl0IChpLmUuIG5vdCBqdXN0IGENCj4gbmV3IHZlcnNpb24gb2YNCj4g
PiB0aGUgc2FtZSBwYXRjaC9jb21taXQpLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0YWdzDQo+ID4g
fCBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+ID4gfCBD
bG9zZXM6IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVpbGQtYWxsLzIwMjQwNTMw
MDYwMi5BVWg5WXU5Ni1sa3BAaW50ZWwuY29tLw0KPiA+DQo+ID4gQWxsIGVycm9ycyAobmV3IG9u
ZXMgcHJlZml4ZWQgYnkgPj4pOg0KPiA+DQo+ID4gPj4gbGQubGxkOiBlcnJvcjogdW5kZWZpbmVk
IHN5bWJvbDogYnRtdGtfaXNvcGt0X3BhZA0KPiA+ICAgID4+PiByZWZlcmVuY2VkIGJ5IGJ0dXNi
LmM6MjI2NyAoZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYzoyMjY3KQ0KPiA+ICAgID4+PiAgICAg
ICAgICAgICAgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLm86KGJ0dXNiX3NlbmRfZnJhbWUpDQo+
IGluIGFyY2hpdmUgdm1saW51eC5hDQo+IA0KPiBQbGVhc2UgaGF2ZSB0aGUgYWJvdmUgZml4ZWQg
YW5kIHdoaWxlIGF0IG1vdmUgdGhlIHZlbmRvciBzcGVjaWZpYw0KPiBoYW5kbGluZyBvZiB0aGUg
bmV3IGVuZHBvaW50IHRvIGJ0bXRrLmMgc2luY2UgdGhhdCBpcyBub3Qgc3RhbmRhcmQgaXQNCj4g
c2hhbGwgbm90IGJlIHBhcnQgb2YgYnR1c2IuYw0KPiANCj4gDQo=
