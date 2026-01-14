Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011045.outbound.protection.outlook.com [40.107.130.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FD738756F;
	Wed, 14 Jan 2026 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382377; cv=fail; b=avoTfbE5Av7x3dSzAT90ylkqHc6gzT8J060Rv3GjBoOUwxhZ8IYtm14VuSc3xlAvQHqtqokwvBd/iZZ6eg2DkedExgVffLtXloRHXpXicKFMsPgOj2bl39Pk9+cSObzsnfRsREcRgi/Xp3mR2sMXNJH/Ol4kGcE9IuypGi7b1IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382377; c=relaxed/simple;
	bh=gHGmrA6zwVfiGet6lPnrjQLQUFEMS0dUc4QK/rJ2GA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JxNg7MoOLy49gMZEfvJH655hZgzm3KSuLCLkfnV1t4Rxr/2aS45q7aCbqcdppgzV/v81gYC+RvJwEvBD/kCC1Q4o220gp1ltmB+9ZlVXUWiFwSK1f+zCaPRRnDavbMCgqP1eN1xV3+o8mq5i3fIcL/ti99DZ9Rf8vB4t39ugkgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Em3Oyhov; arc=fail smtp.client-ip=40.107.130.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Em3Oyhov"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9bdo/iJTlWEnlzDf7IsUNdM0mQjRhrOGNBpODfCb6AQQz+350R4Zk2G3/kmz+2QYQDjyUlJ+9SDADH6fw++lGz59xTBnYbi1Obr//3VqZRfAzBWIkR8mfaqIY9fMRfmRjRn1eDO3xRpSgu5duMHiOhlBcglJps7tEfOGoWJG+62tNv4q3Jp37z+KTVqzFEzQreaP8ALdTadpMhQumPCFC110cVKrEn2y/i8yU7vQZrNYHqUt9V0e3puSJDM69aTb6zzsSLbaNRKb5gvlakDiPv336SSs+gbk81j+OTHaTjGDo2gwZic59j9iau7IPzYSpdc5C0TkGTHyy2pghRrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHGmrA6zwVfiGet6lPnrjQLQUFEMS0dUc4QK/rJ2GA0=;
 b=gSPkVwI1hge0WbyA7FDhCJNP3InC6ynpU5PK9IFlZqje77m6t6UEc1iCKlCItTqlemz9oeHQIxAVgN9LU5a862C/y8eiXQVvM5lERYB7DvhuFpuexPcQ4BU/Xgk/iMo5X228JaFmqDTT0i90/HbQqLXTPbBgi7GiIRu5jty82OyIaM701gw5oB+E49XH1sD85VSKaeT4WUN7NvY2SKcNXcs1+bnN/Dk2hAKHHmVS+spV9M2oO6pdFna2UwntCQlklwWG7O5UCEJTdbse3Y/YMG9tahe5cTyN1fzeIXInbGjQlVcKQj4YFQD7lqOPwJhOqXLzJtsQlQfd8ccdDzGTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHGmrA6zwVfiGet6lPnrjQLQUFEMS0dUc4QK/rJ2GA0=;
 b=Em3Oyhov15qPGW2kA1F+gVNWfqXtnGWEJ5v9Uo/3c4HD65EiaOFuN/fcu2E+hdIG/9dpyTlWFX0KfTdQEeB1V/yvUXvKMFJOxvGGQJeAdhygHLCwnJS8+IthFLQ4gxP0gj/xjMU/64cgB13PHKgwjIdSPzRFne7UExwle5aJHUS6LGQqJJXkEYJzSFhGXYYZdWV/s778G/+wW365gqJ28ixDgS6W/AIZCL6tdb5ScTn0JNrnpe1VYxN3XqN51t2X1Loge+d8jdOta18tagJ3nvc8Z64BlB9hYqdDXDnQu5DNyuopYE0jsjrPYs4eJukZR5dTyLHFX5RetHbaS5l5cw==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AMDPR04MB11701.eurprd04.prod.outlook.com (2603:10a6:20b:71a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 09:19:32 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 09:19:31 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Sherry Sun <sherry.sun@nxp.com>, Dmitrii Lebed
	<dmitrii.lebed@nxp.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ethan Lo <ethan.lo@nxp.com>
Subject: RE: [EXT] Re: [RESEND PATCH v2 00/11] Bluetooth: btnxpuart: Add
 secure interface support for NXP chipsets
Thread-Topic: [EXT] Re: [RESEND PATCH v2 00/11] Bluetooth: btnxpuart: Add
 secure interface support for NXP chipsets
Thread-Index: AQHchGDGusFPmc/6okS9DlKOx5YoU7VQMd+AgAA2moCAAPvd4A==
Date: Wed, 14 Jan 2026 09:19:31 +0000
Message-ID:
 <AS4PR04MB9692112F8A4D81D905716131E78FA@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
 <CABBYNZ+crY9eDfy6=cz8FwbUqFbjWjqjiVTHanw2J-7QB-Wh_g@mail.gmail.com>
 <CABBYNZ+P6SUq4QAD9MS3MYw3yUDv6q8O5tDjR+wk8Zi9gmhAAQ@mail.gmail.com>
In-Reply-To:
 <CABBYNZ+P6SUq4QAD9MS3MYw3yUDv6q8O5tDjR+wk8Zi9gmhAAQ@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AMDPR04MB11701:EE_
x-ms-office365-filtering-correlation-id: 9c8e7781-54d2-4a9f-53ba-08de534e06a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?d1BSYlFZTUNuM0NaLzNtSjdib0c4Q1NrT0M1bjNxRWN5b3UxZ3hUR3crdkJt?=
 =?utf-8?B?WjlHWWNBSXUyZGhQemN6L2NoT0JoaVY0cHlPYXRrTlNNWThJVXVHZVc2N1Ns?=
 =?utf-8?B?bFlvVWRUeWdPakVjMVk1MkI3VUtJRGlMOGQ2OEloZ056dmZTTmJta3ozWjJh?=
 =?utf-8?B?YU1zM1ZrYnk0R0QxZVdtSGdQMmkxcWRCY1hJTlZZVHJtZUFrL08wbUZJVmNI?=
 =?utf-8?B?T0hzVCtlR1RnMEpPMEtndWxOUkZBbFZLSVF0TmoxMkZnOENwOEFseHBFQ0Fj?=
 =?utf-8?B?WjRHNnNBMjdUeHRCU1d2NnBTRURqQ1NQaDhKcWFHSnRaUkdrRDBWem1DaXNO?=
 =?utf-8?B?NGtNZ2NseGNHbG9DYi8wd01jckRzWUh0MGdDTEQxakpiWGR0WElLVzEwVkIw?=
 =?utf-8?B?N1pXcHNiRHh5VTRTYXNxVVZaQ0ZmdHI3cFZDRVQ5OXlXQkF4VkR1ZGFDNXc1?=
 =?utf-8?B?a3JYOVZoYzJtcnV2NGtmZU5QaFRzYis2ZVNFZTE3bHI2ejExNG9JTStLSnlu?=
 =?utf-8?B?cjZoOUFaTm5Ccnd5SUp2bWxWc0dxanRsUWljeDFXQ0VtbWNHV3UrYko5NmRv?=
 =?utf-8?B?ZVNCQStOcnMxNUhNem1sZzl1NWQ1Uk5YNzJ0d0FmMWxTZ21haTRrTUhYSloy?=
 =?utf-8?B?S3psUnF4Z01kbjhsdlhoZjB4MTJuUzRnMUlhTXZYQUtraEw4Ynl1bUpnb0dE?=
 =?utf-8?B?cDVnbm14bndFOUFBa1FXUjdtdU9WNXB6dHBYSkRPZURIUmRKTTV2cFZwM3Jx?=
 =?utf-8?B?T2Ezc2tmbVAyWEFaRGwvbGg5S2JBVzJwMEREeWs5YWhzSkFvWC8xK3k4Nktq?=
 =?utf-8?B?T1ZqZVpJM0NpSFRJWHZ3Z3lEQzZxOVBwbHI0TUs5MDQ0VXYyTEFINjdnSkR1?=
 =?utf-8?B?bXR6eWhZNTdCSzdFTzdMTUd2N29NUnA1MGxDTUE1a1JEdTQvRzRUWGszLzJv?=
 =?utf-8?B?WjZiVUFPUGpVVk1sZGRpYmZBY0JhakVtaTMzMXQ1YUZDR3RLNmxwTUxOV2ZY?=
 =?utf-8?B?WjlEYTFoNjNaZjdwOTV2SVk4SE5uQmFpSFNRK1c0SFM5aTY0TnFhMlMwdzZw?=
 =?utf-8?B?UWxrTzBzVWdSdU0zMitJblloTUcyMDZHWUNyaDdyb2NSNTBadmdWcnR5ZzBs?=
 =?utf-8?B?VXNDNXVDZHJSV2xUb3NJOENNVVhCTUdxcFlpd1B2WEozL1ZBazQ5eWdwQUpD?=
 =?utf-8?B?S0NNMkMvSTNKL3laU1UweGJPcW9reWV5cjkyMHdNTkNzMjBsQmNVRUtUTUxw?=
 =?utf-8?B?M0tSbENOQ1d3VmluMUxUZXV3bFlpblVLc0NYMHdYOGlqeVZCcmxabWMyWFE3?=
 =?utf-8?B?NXh4VVJMaURlbVY3ZU1PV1hCZ0JVd0xxZjM5NHRsMkRLUDNzcFpxaWNTN1RX?=
 =?utf-8?B?RjcrNTJxRHZDU1c2K3ZlVDVDd3VSczlWc1h2cHF3dnhoUjloclEveER6Ty9E?=
 =?utf-8?B?NS9lS09ydCtnemFkdDE4eWtWcVpmSjNtTmtVVmFXeG1LenFmb2lLQ1lwTW96?=
 =?utf-8?B?a1lHV2QvU0hVMXAzVUVmd3RyWlVUdnFHRnlmc1cyZStQRUNiVTYyUDkxcHRv?=
 =?utf-8?B?NlpTMHdGSjVzMSszYnFHS1Vxb25JcVlHa1RRSXZMV3J0eGNXTjlTODVsOVQv?=
 =?utf-8?B?V1E4RGdBL2NsaFoyYlRYUmdCSFh1SUN1K3Y1emFaUG90YUUrZWRGSFluV1Ux?=
 =?utf-8?B?aDNxTHdwQ000dkpzTndDdW8xZ3VCQTcwcXlmZjEwZm90QXUyKytJcmFDbGNx?=
 =?utf-8?B?bGpPTDI3MjkxbEZUSlF4UDRXdzJPcTcva000Q3Q1eFlwZUpuczBOajBYQWR4?=
 =?utf-8?B?eE81RUhvd1lxcTJhVmVsZGh3SnRqK0JvK2VNSzR6Qng1bEpCTU1pV3B3aWlW?=
 =?utf-8?B?Zkx2UVcxK3dqcnZ1Mm5aSllBL2d6WnRVa1N4Z1VBNklNYkpjZ0p0ZkF2Nzhl?=
 =?utf-8?B?SmRwMXhwR0pzUmlMZVhoUkdsR1REZG9uT0VmRXd2SlovVTUvRndhZFpVMkdj?=
 =?utf-8?B?cGErd3RHaVAzNE1uVy9sWkt0ME90RUdGd0R3T1EyZ1hXb2l1SmlacGQyRkF3?=
 =?utf-8?Q?hEKCki?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmRSWmM5V0djMmNUa1JhaUExRDN3OTVpdUVwcUpKTWppMXVXSG42OW8vL01o?=
 =?utf-8?B?UmpGYks5aGRNNUtDQ2RzSmgvejNyOEhMZDc1UWdKUzJEd04zMEMyVm5Hc1F4?=
 =?utf-8?B?dytBMVl3ZjkwV1NMVDRqaS9LZ3R3bm12YVA3Q3NSVS9CMlRPODNpN2JhNGNq?=
 =?utf-8?B?eERWbGI1QUR4SWhaRktIajh4NFJueFpSWVdDS3JXSU1LK1RnRDE1VHZMeXFm?=
 =?utf-8?B?QnhPTnJiVW9QQnZzME04aWsvTG5kL0VJWHAyQzhDTkZrbUc0NWV5WW93SEl0?=
 =?utf-8?B?Vy8xK1ZSdHMrak9GMCs1QVg3V2M3U2lDbHVVd01FcGlrVURDb2poN216alAy?=
 =?utf-8?B?M09URGI2ZFpDdjZoREtRdm5KcGp4SjZTYmRGcGZxWGEzci8xWHlPMXltSWx4?=
 =?utf-8?B?TEZRcEQrTEZYdnFEU0pIZzQxWERrMUdTYmtMdGxyNmQxZ1lET2xlU2dWeWdj?=
 =?utf-8?B?NEdyZTd1UXF4L0dZT3VQUlNqNFZxTnBwWmFpR3JTNmovNHA0emRFNHpLaUl4?=
 =?utf-8?B?M004UkpFbGJoVmJPYnJYQWgvcmVFdEFXODd0RUNLNTIrL1N4S2JBOWdiWDdh?=
 =?utf-8?B?TzM0bUlOU09YMmI1R1V1VFg1aHZEZUN3aUxaMGpUdDJmQ2oyQ2tHeFljV0s3?=
 =?utf-8?B?dms1Wkt6d2VwZjdIRTBnUXhpaHBoRmh1czQ5Y2N1ZEovek96c212b2hCL1NF?=
 =?utf-8?B?WmFYTjJkbXlzUC9oQUJJZElZUU5aTVVIVHNuZTNaKy95aUZ5WUVXLzBLd0lo?=
 =?utf-8?B?K2JEVWY3ZmRxYVAvZnJJOXZiQUgrUEw5TjRaTlB4WFBUU3BYQy96alNWenYr?=
 =?utf-8?B?Snc5YmFEVWV2eG9BNm5NY2x4elJ1djRRNlo1Yml6MmFTMVYxSVhzOS9NN3g2?=
 =?utf-8?B?MlBQL0RpNmoxQU94MkF4eHBZbzdIWjdya1JWNW8wUS9RTWJ4VDIwaWZDeW0y?=
 =?utf-8?B?V1ExbFM3TTN2OGFSR1Z0dVZTeW9uUXJFWnFQSzBpT2NQOFhtLzd2Ry9FenlX?=
 =?utf-8?B?WVJWbHhEVURQZ2x3eWJPVEU0cDNQRXpXc0c2SU92bkNmRlgxRXBXU3pGNGtX?=
 =?utf-8?B?alZJK0xPZ1BLb0Nrb05lNzI0enF2SGJkYng4Q3luRlFVa3QxSFRscVZheXRS?=
 =?utf-8?B?YjdmdXczVFJXbFBWRlNMa1ppMU5EemFDREVDaDFKQ2dZM25vT1BuUWV2TFRG?=
 =?utf-8?B?WVVkTDExMFlseTRpd25JaXR1U0pkc2FUL3dlZi82Vk9YMzBSNnVScnpFTVBm?=
 =?utf-8?B?aUNLTytmcE5HUWZQUmk1YkQ2YklqcnpOVkYrbzVRU29rbERoRjl6SnNDMEdV?=
 =?utf-8?B?OWtjMjM4eG1jVUVKKzJkekx6ZWhZdWhQZHd5L0pPdnphcjdhRzcwbmh6TEVO?=
 =?utf-8?B?OVpBdTFkRExQRGoxMFJoVGR0SXlHYXdMVkdwWHBDUUNSVnVhQWxhVXFxcXg1?=
 =?utf-8?B?aTBCWHhXSURFVm9JRnQ3SW93RUZXbG9KdjVpYXR4WkltVk5JN0JHODB3ZFhq?=
 =?utf-8?B?dDJMR1NBeDJCQms0cURwQno0OXlEVVdpL0VOd21DalJtSTNNMEVlVHV1eWpt?=
 =?utf-8?B?ZEs5WWpyL3ZSQ3pUd3hiaWx5bTViUW1PajNaRDc4K2F5YWlJcEVYYWhTLyta?=
 =?utf-8?B?Y2pHaXkxSmozNXpMd0lwaXRkSUk3Y1o3UTZYSGczQXNPdXYvdTdjRVdtakU5?=
 =?utf-8?B?WHlUdEJMUDdva2RPM3ExQytRc2tWbzhWZWhqYmJaRmJKSGtQTHlnNnE5UFpG?=
 =?utf-8?B?ekZRLzllVWFBYmV2dDhtT2h0WnYzWW9CQ2twUDdBQlEvVjBLTFJBV3hId2d4?=
 =?utf-8?B?cHRuT05vWDJ5YjlqN05qeWszQm5Ea25uY3pCWko0MDNJK0YzdDhvTlp2NEFi?=
 =?utf-8?B?OVhOU3NtaHVBM2hPTEYyVWFTa1JyM2VKUUVXMHlOcEhVQkFOUENrT2NsL3NV?=
 =?utf-8?B?L3BLMUhCL2JMZ2hyV1RzR3d3M2hkRjZBSzY5bWVmU2E5THBvUi9mVnEwVTdV?=
 =?utf-8?B?ZTV2WVVGVjdVK3FtQXRyUHNObXR3azhrZ04yRUgwazNSUVhFYmpveklzaVgv?=
 =?utf-8?B?VEFobFo1T2cvTzdjTDI4ZnFoNE9VQ0VjemxUSUNMSGZzL1VxdWIxU1RYWXBD?=
 =?utf-8?B?RTQ5d2JtZFJ6ajNJTEJrK1pvNVQxVmlKSkxLdDFLTFJ1MW04dlZKdzFaaXlS?=
 =?utf-8?B?amE3M1RSQ01SaEcyRHR4a0FsRmtYZndoSk5Vd0N4VjNQc1cya1R0NUJPaVlE?=
 =?utf-8?B?UmxDdU5UY1V0cmpLVVFBdVpNclNsZFo2RU83Y3RuWlgyTis5NjUrQmdRSnFz?=
 =?utf-8?B?dXF3cDYwNVBOUXkweDBFK0hRcm5ka3RaSzAxZE9GdUJIQXNRYVFSUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8e7781-54d2-4a9f-53ba-08de534e06a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 09:19:31.6843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jOhaJQBrkGBpnhg7RgRPeJ0n/K5nAdEtwIkdpLKhhnPJIm2QDGHidkn3IVgt165cp0Tph2IQZ0vQZwqbXNDRvYTOFpEQ7UOhaBexW8GfTF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11701

SGkgTHVpeiwNCg0KPiA+IE9uIFR1ZSwgSmFuIDEzLCAyMDI2IGF0IDI6NDbigK9BTSBOZWVyYWog
U2FuamF5IEthbGUNCj4gPiA8bmVlcmFqLnNhbmpheWthbGVAbnhwLmNvbT4gd3JvdGU6DQo+ID4g
Pg0KPiA+ID4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBzZWN1cmUgaW50ZXJmYWNlIHN1cHBvcnQg
Zm9yIE5YUCBCbHVldG9vdGgNCj4gPiA+IGNoaXBzZXRzIHRvIHByb3RlY3QgYWdhaW5zdCBVQVJU
LWJhc2VkIGF0dGFja3Mgb24gQmx1ZXRvb3RoIHNlY3VyaXR5IGtleXMuDQo+ID4gPg0KPiA+ID4g
UHJvYmxlbSBTdGF0ZW1lbnQ6DQo+ID4gPiA9PT09PT09PT09PT09PT09PT0NCj4gPiA+IEJsdWV0
b290aCBVQVJUIGRyaXZlcnMgYXJlIHZ1bG5lcmFibGUgdG8gcGh5c2ljYWwgYXR0YWNrcyB3aGVy
ZQ0KPiA+ID4gYWR2ZXJzYXJpZXMgY2FuIG1vbml0b3IgVUFSVCBUWC9SWCBsaW5lcyB0byBleHRy
YWN0IHNlbnNpdGl2ZQ0KPiBjcnlwdG9ncmFwaGljIG1hdGVyaWFsLg0KPiA+ID4gQXMgZGVtb25z
dHJhdGVkIGluIHJlc2VhcmNoIFsxXSwgYXR0YWNrZXJzIGNhbiBjYXB0dXJlIEg0IHBhY2tldHMN
Cj4gPiA+IGNvbnRhaW5pbmcgTGluayBLZXlzLCBMVEtzLCBhbmQgb3RoZXIgcGFpcmluZyBkYXRh
IHRyYW5zbWl0dGVkIGluDQo+ID4gPiBwbGFpbnRleHQgb3ZlciBVQVJULg0KPiA+ID4NCj4gPiA+
IE9uY2UgYW4gYXR0YWNrZXIgb2J0YWlucyB0aGVzZSBrZXlzIGZyb20gVUFSVCB0cmFmZmljLCB0
aGV5IGNhbjoNCj4gPiA+IC0gRGVjcnlwdCBhbGwgQmx1ZXRvb3RoIGNvbW11bmljYXRpb24gZm9y
IHBhaXJlZCBkZXZpY2VzDQo+ID4gPiAtIEltcGVyc29uYXRlIHRydXN0ZWQgZGV2aWNlcw0KPiA+
ID4gLSBQZXJmb3JtIG1hbi1pbi10aGUtbWlkZGxlIGF0dGFja3MNCj4gPiA+DQo+ID4gPiBUaGlz
IHZ1bG5lcmFiaWxpdHkgYWZmZWN0cyBhbnkgQmx1ZXRvb3RoIGltcGxlbWVudGF0aW9uIHVzaW5n
IFVBUlQNCj4gPiA+IHRyYW5zcG9ydCwgbWFraW5nIHBoeXNpY2FsIGFjY2VzcyB0byBVQVJUIGxp
bmVzIGVxdWl2YWxlbnQgdG8NCj4gPiA+IGNvbXByb21pc2luZyBhbGwgcGFpcmVkIGRldmljZSBz
ZWN1cml0eS4NCj4gPiA+DQo+ID4gPiBTb2x1dGlvbjoNCj4gPiA+ID09PT09PT09PQ0KPiA+ID4g
SW1wbGVtZW50IGEgVExTIDEuMy1pbnNwaXJlZCBzZWN1cmUgaW50ZXJmYWNlIHRoYXQ6DQo+ID4g
PiAtIEF1dGhlbnRpY2F0ZXMgdGhlIGNoaXBzZXQgdXNpbmcgRUNEU0Egc2lnbmF0dXJlIHZlcmlm
aWNhdGlvbg0KPiA+ID4gLSBFc3RhYmxpc2hlcyBzaGFyZWQgZW5jcnlwdGlvbiBrZXlzIHZpYSBF
Q0RIIGtleSBleGNoYW5nZQ0KPiA+ID4gLSBFbmNyeXB0cyBzZW5zaXRpdmUgSENJIGNvbW1hbmRz
IChMaW5rIEtleSBSZXBseSwgTFRLIFJlcGx5LCBldGMuKSB1c2luZw0KPiA+ID4gICBBRVMtR0NN
DQo+ID4gPiAtIERlY3J5cHRzIGVuY3J5cHRlZCB2ZW5kb3IgZXZlbnRzIGZyb20gdGhlIGNoaXBz
ZXQNCj4gPiA+DQo+ID4gPiBUaGlzIGVuc3VyZXMgdGhhdCBldmVuIHdpdGggZnVsbCBVQVJUIGFj
Y2VzcywgYXR0YWNrZXJzIGNhbm5vdA0KPiA+ID4gZXh0cmFjdCB1c2FibGUgY3J5cHRvZ3JhcGhp
YyBrZXlzIGZyb20gdGhlIGNvbW11bmljYXRpb24gY2hhbm5lbC4NCj4gPiA+DQo+ID4gPiBJbXBs
ZW1lbnRhdGlvbiBPdmVydmlldzoNCj4gPiA+ID09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+
ID4gVGhlIHNvbHV0aW9uIGlzIGltcGxlbWVudGVkIGluIDExIGluY3JlbWVudGFsIHBhdGNoZXM6
DQo+ID4gPg0KPiA+ID4gMS0yOiAgIEFkZCBmaXJtd2FyZSBtZXRhZGF0YSBwYXJzaW5nIGFuZCB2
ZXJzaW9uIGRldGVjdGlvbg0KPiA+ID4gMy00OiAgIEVzdGFibGlzaCBzZWN1cmUgaW50ZXJmYWNl
IGZyYW1ld29yayBhbmQgY3J5cHRvIHNldHVwDQo+ID4gPiA1LTc6ICAgSW1wbGVtZW50IFRMUyBo
YW5kc2hha2UgKEhvc3QgSGVsbG8sIERldmljZSBIZWxsbywgYXV0aGVudGljYXRpb24pDQo+ID4g
PiA4OiAgICAgRGVyaXZlIGFwcGxpY2F0aW9uIHRyYWZmaWMga2V5cyBmb3IgZW5jcnlwdGlvbi9k
ZWNyeXB0aW9uDQo+ID4gPiA5LTEwOiAgQWRkIGNvbW1hbmQgZW5jcnlwdGlvbiBhbmQgZXZlbnQg
ZGVjcnlwdGlvbiBzdXBwb3J0DQo+ID4gPiAxMTogICAgQWRkIHJlcXVpcmVkIGNyeXB0byBhbGdv
cml0aG0gZGVwZW5kZW5jaWVzDQo+ID4gPg0KPiA+ID4gVGhlIGltcGxlbWVudGF0aW9uIGF1dG9t
YXRpY2FsbHkgZGV0ZWN0cyBzZWN1cmUgaW50ZXJmYWNlIGNhcGFiaWxpdHkNCj4gPiA+IHZpYSBm
aXJtd2FyZSB2ZXJzaW9uIHN0cmluZ3MgYW5kIGVuYWJsZXMgZW5jcnlwdGlvbiBvbmx5IHdoZW4N
Cj4gPiA+IG5lZWRlZC4gTGVnYWN5IGNoaXBzZXRzIGNvbnRpbnVlIHRvIHdvcmsgd2l0aG91dCBt
b2RpZmljYXRpb24uDQo+ID4gPg0KPiA+ID4gU2VjdXJpdHkgUHJvcGVydGllczoNCj4gPiA+ID09
PT09PT09PT09PT09PT09PT0NCj4gPiA+IC0gQ2hpcHNldCBhdXRoZW50aWNhdGlvbiBwcmV2ZW50
cyByb2d1ZSBkZXZpY2Ugc3Vic3RpdHV0aW9uDQo+ID4gPiAtIEZvcndhcmQgc2VjcmVjeSB0aHJv
dWdoIGVwaGVtZXJhbCBFQ0RIIGtleSBleGNoYW5nZQ0KPiA+ID4gLSBBdXRoZW50aWNhdGVkIGVu
Y3J5cHRpb24gKEFFUy1HQ00pIHByZXZlbnRzIHRhbXBlcmluZw0KPiA+ID4gLSBQZXItc2Vzc2lv
biBrZXlzIGxpbWl0IGV4cG9zdXJlIGZyb20ga2V5IGNvbXByb21pc2UNCj4gPiA+DQo+ID4gPiBU
ZXN0aW5nOg0KPiA+ID4gPT09PT09PT0NCj4gPiA+IFRlc3RlZCBvbiBBVzY5MyBjaGlwc2V0cyB3
aXRoIHNlY3VyZSBmaXJtd2FyZS4gVmVyaWZpZWQgdGhhdDoNCj4gPiA+IC0gQXV0aGVudGljYXRp
b24gaGFuZHNoYWtlIGNvbXBsZXRlcyBzdWNjZXNzZnVsbHkNCj4gPiA+IC0gU2Vuc2l0aXZlIGNv
bW1hbmRzIGFyZSBlbmNyeXB0ZWQgYmVmb3JlIHRyYW5zbWlzc2lvbg0KPiA+ID4gLSBFbmNyeXB0
ZWQgZXZlbnRzIGFyZSBwcm9wZXJseSBkZWNyeXB0ZWQNCj4gPiA+IC0gVUFSVCBtb25pdG9yaW5n
IHNob3dzIG9ubHkgZW5jcnlwdGVkIHBheWxvYWRzIGZvciBzZW5zaXRpdmUNCj4gPiA+IG9wZXJh
dGlvbnMNCj4gPiA+IC0gTGVnYWN5IGNoaXBzZXRzIHJlbWFpbiB1bmFmZmVjdGVkDQo+ID4gPg0K
PiA+ID4gWzFdICJCTEFQOiBCbHVldG9vdGggTG93IEVuZXJneSBBdHRhY2tzIG9uIFBhaXJpbmci
IC0gRFNOIDIwMjINCj4gPiA+DQo+ID4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZuZQ0KPiA+ID4NCj4gdHNlYy5ldGh6
LmNoJTJGcHVibGljYXRpb25zJTJGcGFwZXJzJTJGZHNuMjJfYmxhcC5wZGYmZGF0YT0wNSU3QzAy
JQ0KPiA3DQo+ID4gPg0KPiBDbmVlcmFqLnNhbmpheWthbGUlNDBueHAuY29tJTdDMGU2MTYxODQ4
ZGVlNDM5ODdlNWEwOGRlNTJjZmM4OWMlNw0KPiBDNjgNCj4gPiA+DQo+IDZlYTFkM2JjMmI0YzZm
YTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM5MDM5MjQ5NTUzMDY5MzkwJTdDDQo+IFVua25v
dw0KPiA+ID4NCj4gbiU3Q1RXRnBiR1pzYjNkOGV5SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0lsWWlP
aUl3TGpBdU1EQXdNQ0lzSWwNCj4gQWlPaUpYDQo+ID4gPg0KPiBhVzR6TWlJc0lrRk9Jam9pVFdG
cGJDSXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT1qJTINCj4gRlFvRDYNCj4g
PiA+IEJPaGxOWlF4YXE0JTJGRWdmWmFaTUtOcU5Ud2M1d2dqV1Y3bFFOYyUzRCZyZXNlcnZlZD0w
DQo+ID4NCj4gPiBPaywgSSBzdGFydCByZWFkaW5nIHRoZSBkb2N1bWVudCBhYm92ZSBidXQgaXQg
c2F5cyB0aGUgcHJvYmxlbSBpcyB3aXRoDQo+ID4gSENJIGl0c2VsZiB0aG91Z2g6DQo+ID4NCj4g
PiAnV2UgZmlyc3QgcHJlc2VudCBhIGxpbmsga2V5IGV4dHJhY3Rpb24gYXR0YWNrIHRoYXQgZXhw
bG9pdHMgdGhlDQo+ID4gc2VjdXJpdHkgZmxhdyBpbiB0aGUgSENJIGR1bXAsIHdoaWNoIHJlY29y
ZHMgYWxsIGRhdGEgcGFzc2VkIHRocm91Z2gNCj4gPiB0aGUgSENJIGludGVyZmFjZSBpbiBhIGxv
ZyBmaWxlLCBpbmNsdWRpbmcgbGluayBrZXlzLicNCj4gPg0KPiA+IEl0IGRvZXMgc2F5IHRoYXQg
aXQgaXMgcGFzc2VkIHRvIGEgbG9nIGZpbGUgdGhvdWdoLCBtYXliZSB0aGUNCj4gPiBwZXJtaXNz
aW9uIG9mIHRoZSBmaWxlIGlzIHRoZSBwcm9ibGVtIHRoZW4sIGVpdGhlciB3YXkgdGhpcyB3b3Vs
ZCBiZQ0KPiA+IFVBUlQgZXhwZWNpZmljLiBXZSBkbyByZXF1aXJlIE5FVF9BRE1JTiAoYWthLiBy
b290KSBmb3IgYWNjZXNzaW5nIEhDSQ0KPiA+IHRob3VnaCwgYm90aCBmb3IgbW9uaXRvcmluZyBv
ciBnZW5lcmF0aW5nIEhDSSB0cmFmZmljIChlLmcuDQo+ID4gSENJX1VTRVJfQ0hBTk5FTCksIHNv
IEkgZG9uJ3QgYmVsaWV2ZSB0aGVzZSBjbGFpbXMgYXJlIHZhbGlkIHdpdGgNCj4gPiByZXNwZWN0
IHRvIExpbnV4IHNpbmNlIGZvciBjb2xsZWN0aW5nIHRoZSBsb2dzIHdpdGggdGhlIGxpa2VzIG9m
IGJ0bW9uDQo+ID4gdGhhdCB3aWxsIHJlcXVpcmUgcm9vdCBhY2Nlc3MsIHRoYXQgc2FpZCBwZXJo
YXBzIHRoZSAtdyBvcHRpb24gc2hhbGwNCj4gPiBsaW1pdCB0aGUgcGVybWlzc2lvbiBvZiB0aGUg
ZmlsZSB0byByb290IG9ubHkgYXMgd2VsbCwgaW4gYW55IGNhc2UgaXQNCj4gPiBpcyBub3QgbGlr
ZSBidG1vbiBjYW4gYmUgcnVuIGJ5IGFuIGF0dGFja2VyIHdpdGhvdXQgcm9vdCBhY2Nlc3MsIHNv
IGl0DQo+ID4gYmVhdHMgbWUgaG93IExpbnV4IGNvdWxkIGJlIGNvbnNpZGVyZWQgdnVsbmVyYWJs
ZSBoZXJlLg0KPiANCj4gSnVzdCByZWFkaW5nIHRocnUgaXQgc2F5czoNCj4gDQo+ICdNb3Jlb3Zl
ciwgaXQgaXMgYWxzbyBzdHJhaWdodGZvcndhcmQgdG8gaW1wbGVtZW50IHRoZSBsaW5rIGtleSBl
eHRyYWN0aW9uDQo+IGF0dGFjayBpbiBMaW51eCBPUyBieSBsZXZlcmFnaW5nIGJvdGggVVNCIHNu
aWZmIGFuZCBIQ0kgZHVtcCBsb2csIGJlY2F1c2UNCj4gdGhlcmUgYXJlIFVTQiBzbmlmZmluZyBz
b2x1LSB0aW9ucyBhcyB3ZWxsIGFzIHRoZSBibHVlei1oY2lkdW1wIHBhY2thZ2UuDQo+IEhvd2V2
ZXIsIHJ1bm5pbmcgVVNCIHNuaWZmaW5nIGFuZCBibHVlei1oY2lkdW1wLCBhbmQgYWNjZXNzaW5n
IHRoZSBib25kaW5nDQo+IGluZm9ybWF0aW9uIGZpbGUgaW4gTGludXggcmVxdWlyZSB0aGUgc3Vw
ZXJ1c2VyIHByaXZpbGVnZS4gVGh1cywgdGhlIHByYWN0aWNhbGl0eQ0KPiBvZiBsaW5rIGtleSBl
eHRyYWN0aW9uIGluIExpbnV4IGRlcGVuZHMgb24gdGhlIGF0dGFja2Vy4oCZcyBhZmZvcmRhYmxl
IHByaXZpbGVnZS4nDQo+IA0KPiBBbnl0aGluZyBpcyB0cml2aWFsIGlmIHlvdSBoYXZlIHN1cGVy
dXNlciBwcml2aWxlZ2UsIHNvIEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkDQo+IGNvbnNpZGVyIExp
bnV4IHZ1bG5lcmFibGUganVzdCBiZWNhdXNlIHNvbWVvbmUgdGhpbmtzIGhhdmluZyByb290IGFj
Y2VzcyBpcw0KPiBzb21ldGhpbmcgdHJpdmlhbCB0byBnZXQsIHRoYXQgaW4gaXRzZWxmIGlzIHRo
ZSByZWFsIHZ1bG5lcmFiaWxpdHkgaWYgeW91IGFzayBtZS4NCg0KQWdyZWUg4oCUIHRoZSBCTEFQ
IGF0dGFja+KAmXMgTGludXggcGF0aCByZXF1aXJlcyBzdXBlcnVzZXIgZm9yIFVTQi9IQ0kgbG9n
Z2luZywgc28gd2XigJlyZSBub3QgY2xhaW1pbmcgYW4gdW5wcml2aWxlZ2VkIExpbnV4IGlzc3Vl
LiBPdXIgc2VyaWVzIHRhcmdldHMgYSBkaWZmZXJlbnQsIE9T4oCRaW5kZXBlbmRlbnQgcmlzazog
InBoeXNpY2FsIHNuaWZmaW5nIG9mIHBsYWludGV4dCBsaW5r4oCRa2V5IGV4Y2hhbmdlcyIgb24g
SDQgVUFSVCAoY29tbW9uIG9uIE0uMiBLZXnigJFFIGJyaW5n4oCRdXAgcGF0aHMpLCB3aGljaCBh
biBhdHRhY2tlciBjYW4gdGFwIHdpdGhvdXQgaG9zdCBwZXJtaXNzaW9ucyDigJQgaGVuY2Ugd2Ug
ZW5jcnlwdCB0aG9zZSBIQ0kgbWVzc2FnZXMuIFRoZSB1c2Ugb2Ygc3RvbGVuIGtleXMgdG8gZGVj
cnlwdCBvbuKAkWFpciB0cmFmZmljIGlzIGRlc2NyaWJlZCBpbiB0aGUgQkxBUDsgd2XigJlyZSBy
ZW1vdmluZyB0aGUga2V54oCRZXh0cmFjdGlvbiB2ZWN0b3IgZnJvbSB0aGUgVUFSVCBidXMuDQoN
ClRoYW5rcywNCk5lZXJhag0K
