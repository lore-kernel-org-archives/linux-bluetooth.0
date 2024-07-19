Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D954645
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jul 2024 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721374487; cv=fail; b=PiN6yIyQoP9VlrQy6yIPjKhs9m68efoJJoVjkDYfcikQaKws8QMxG7SmDl1Sz3/NtDHGnDtJV/sEleT8lueek5cdJoIxlOV+qx4ef6H2T5Jio/RIMgWzZUgremSI1syYO+SknlqiOq7/C8NI8S8ITctWOtS7RIO9zZdtDtV/ANE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721374487; c=relaxed/simple;
	bh=ZT6FDEHB7UXSS+RJVMcS0koXnU40hQg94TRfUWIWvV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i6P3nlF1j5qtlWn3cWxQhzdJxLCupG71/b+qMKdhulL0G6Q3GWyFXS4/HrInkFMzF1hnPaQIJJy38vI0J4p4qF9/9nSZNtcer9WVxgdCTmDzFPDpMtLIamjpw/5TkvxfVI05LHFm4qqgTb++Qrswy6IdGOj3HXDyTORtVUjpKiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=alaZhEd4; arc=fail smtp.client-ip=52.101.69.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="alaZhEd4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYWy3izOY12BxzT1oDpsJfG07heDe3J6PTqTdX+PMRMVs10ghOXA4e0TgxgvcCkE08RDC6kyVgtz2D9eEfJq0fyJbyPMDwvgtW8APxbReqg/i0mGD+HsC3UCxYPsnGmshYYj+0oqGw+DGF5yJxhjVXgpa0uF1ELG9X77ChtmL4qKctCoy6pI0LF1UEnMosQNhrtCyjmI5N8OPrJ5MxpZHdWiGlaxxKvWSZFQ7pGVFQWAho13rEhdriO+jv3eruX8aerWCb0wTEXIM8Z5HndgBQ3pg4R8GjUnzxG5q2YnY5pg6zLPn6Oz2wI9ErypPdhy/aHs7Npt6JywunouH+TLYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT6FDEHB7UXSS+RJVMcS0koXnU40hQg94TRfUWIWvV0=;
 b=nAmvxZHarqotM/Ddk8dI9IGCJgVq9umbVqD6EH1YSnx1zvis4zH6elDLK564N3kVmbAiL8BYlzYBPKMRbHSAzpoZJAmS0lebz+1EJ0VWiYSSRRxMCNM3UlF6+g338wupkM9tJNWLVtwJMkv7Bb6QjxQQuZsyr+9uAO2lzbs1CxFvKQEDhTvVlD/iNGiBcM3bsp/JPDv+bQ1XlKtL3Xj07/KCbz/pvjTgDTRM+sLvaJsWxeOR501A7zrkYRcVARwXncZ0uzuXwax9nT1A+B8JE6R+tcDZeITTx/1prweZBW3Jrj1lScW7qlWIvQXveZ8Xs48Ds7LFs/DQ1H3mgFy/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT6FDEHB7UXSS+RJVMcS0koXnU40hQg94TRfUWIWvV0=;
 b=alaZhEd4BVwa+Kp+U7lKEHgT/QlbzNokbR77r5cWZicyzKDufuIF8s0N7ysCrcgk7nYqI3zn5SYn831WA/wLexFV2HyxIMqNw3SpveOxOTm+Q5CvWX1vhUu3Kbh/pN5RRsP/xSfwYu8BbQFJPnxs5XrrNNqrqrQPHZoUFt8G7fE=
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PR3PR04MB7420.eurprd04.prod.outlook.com (2603:10a6:102:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 19 Jul
 2024 07:34:42 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%2]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 07:34:41 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mihai-Octavian Urzica <mihai-octavian.urzica@nxp.com>, Iulia Tanasescu
	<iulia.tanasescu@nxp.com>, Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: RE: [EXT] Re: [PATCH BlueZ 0/3] Add transport.select method
Thread-Topic: [EXT] Re: [PATCH BlueZ 0/3] Add transport.select method
Thread-Index: AQHa0qEbQJwd3+UiA02s1R7EkPBYRLHwNySAgA1/YPA=
Date: Fri, 19 Jul 2024 07:34:41 +0000
Message-ID:
 <GV1PR04MB90880C90597E584743AB4FBDFEAD2@GV1PR04MB9088.eurprd04.prod.outlook.com>
References: <20240710081338.17262-1-vlad.pruteanu@nxp.com>
 <CABBYNZJOcRO3SNawYE4D+gXeh-h2pHuj+JwRVQN_JLrGhx53zA@mail.gmail.com>
In-Reply-To:
 <CABBYNZJOcRO3SNawYE4D+gXeh-h2pHuj+JwRVQN_JLrGhx53zA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB9088:EE_|PR3PR04MB7420:EE_
x-ms-office365-filtering-correlation-id: 74a55cec-bdc3-4c21-e136-08dca7c540d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RnEyUDdyS0VLSkYxNTNrVS8zdm8wQjhSRHRzaEdYN25mdkdzWklhUDV6Tkcx?=
 =?utf-8?B?YzlnYmJGc0c0YlI0ejN1dEJNWS9RZmVYdkhVL0FTMEFiOWZvMTZ4WFlSWFNE?=
 =?utf-8?B?Q2s4M0lXbjdpd3BKTXk2bTdHYXVQa256eXlJUnJPU21GM2tsd0Z2ODR2TUJI?=
 =?utf-8?B?ZUZPTEF5bDFHR09OMGt3NHozSFJnQlBiTnNiN1A0U25UakM5czEyTURPQVpV?=
 =?utf-8?B?bnVpVFprbmkvVzlDeS9LQ1d4bXh6Y01SRGxXanVVcjV6ak5GYkhTR1pvMExL?=
 =?utf-8?B?bjNkMC96NzJMZ2JrdGFHZXFFdCtJRVl2TVE0U2tia0s2dXFDVWs0OFJVemN0?=
 =?utf-8?B?Sk11UHlzQ3gwMmwzSjJ4L0Z6MkpSV1JhRG9DaVdIYkxxRTFUSmxuUHI2TVJo?=
 =?utf-8?B?OUppMUc2UHIyVms5VEs3aTEyZFpoZXNFOW1IaDJrbnZWSlhRRFBHZzVlSGlO?=
 =?utf-8?B?cnpNdHNVUGhCYmYrNnlWT0ZtODNmZ1FaQnF5dmVJaUt4cTJTUjhFRVY2cUM3?=
 =?utf-8?B?MlhXN1drUzdISTI1RExwUU1TaDJHZ09FbmNGMnBPZmJQUVRCdDljMENWR3Nh?=
 =?utf-8?B?Zndwamx0S1B2c3NqYnRRM3VycndVVTlDbkZDNHFZSzVGbnk4OUoreUpuNnV3?=
 =?utf-8?B?cWRZVGo2ZUI3cXoxRzUxNW81THAxRFdjWXYvVHBaK0VaVWphZ2puMnFma0tt?=
 =?utf-8?B?Wnl6OXQrYWtwK1ZZNFIrR1hySis0b2lHQzlvUndtQ0JhalRVV3EwVVgzU1BP?=
 =?utf-8?B?MXc2UlZtY2RMdEQrRGU2Mk9scHUzMHJ0MDRBTXI3dCt6NTIzSWRJNnRwelda?=
 =?utf-8?B?ZVpjMFlCM1U1elIrMW94a0srcXdBT1FLdmwvcE5SOC9LalVOVDNaOE9SK0d5?=
 =?utf-8?B?SHVENlFJYm94MmFQbWpHVzkyQTFjVnlDK3diTEp1RWVJZk5saHB3ZzZHUmNn?=
 =?utf-8?B?djF0ZlB3MzE0K2FlQVJKcldIa2FpbDhLRlZwK3pEeEVOWm0vVU5BWkVyNzZY?=
 =?utf-8?B?ZVlsa0J6YTM2R3NsWmx4WGtRdWRzdytWMDRmSUpQSDRTRHVkckxNZW41S09I?=
 =?utf-8?B?M1V1cjlZdzJsNXB5dTNPQWNvbHJNb0ZqTlY5R1g1N3h2UlJFUXcyVkdKSUta?=
 =?utf-8?B?a2ZnOFZpKzVLa0VLYnlmRllVN1JNVXoxdlR4VVRiQ3NBQU9SSzJqT0lYd1F5?=
 =?utf-8?B?VDlaVi9TNFFmTWhFY2tObTYxRlByV0pnK1kwQVR0TWlUT1grcnJPb1BENTVK?=
 =?utf-8?B?eGw1Nk94d0d0VVdwb1E3MjJlSkNFcTAwR1RTYjZzUGZiUWZqdWdvYllaY0c3?=
 =?utf-8?B?cCsrYlN6aFlDYUw5NkhISUpVNStlenMxb2JGT1N4WFJaekY2Z3FJVVJPYWNu?=
 =?utf-8?B?SjB2Qk5jWHpEaFFzdGxrS0dRTUtJUVhoK3JyMTBKZTdyTXdoTTdJVWtYQUdQ?=
 =?utf-8?B?Y0ZzdGVBL2VyY281aG1mbElOZUQ5VXFhT0dOeTJ2THFFZjR3T3NrODBqeXR2?=
 =?utf-8?B?bC8yUWIzL243R0ZTem1jenlFdU1RWVFEWDVEM0YxN0NoV2NEM2VQUllabHd0?=
 =?utf-8?B?Ry9lZVN6Z3hKWkorcU5XMUprYUNBMEpOd2FYaklBQXJBN0ZJQ0R3VUVOK3M1?=
 =?utf-8?B?N3YxVVhFVkc5enZDZFpxbERORFlzVUZSSHNLWTFUR0VSUVdQTVh6WFJSY3ZD?=
 =?utf-8?B?NXZsVWlPVEp5M3lHSTZhRHl0OE1WU2xyc05NRko0ZkxsZkYzRnJQamQweHJ2?=
 =?utf-8?B?bE4zOS91SldoNC80Unl5T1hlV20zZ21sRUdPaHZnWlJzZXd6dmhIa01MUUtD?=
 =?utf-8?B?cHFmR2xoS0I4V1lmMG5IbE1zK0lrTis5enBvcHVoc0dpU0g1NVdTUTYvWUVm?=
 =?utf-8?B?NThQQTJKVnBtbFEzbmVwSWt6ZUJiODN3Z3FZazE1U2loVlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXlneWI5TVByR0h4cGhTbVFMZjl6OXpvREtZVkZVdnNXUUdsOGszclIzVlFW?=
 =?utf-8?B?UXM3M2UwTStZUUtxQmZQa3QwZ0V0b2VGNWxSMVZ2OGVldTdzbXkzQk03T3Rh?=
 =?utf-8?B?Um9oaElUT09WTGQyMWRSVDlYUzZFV1pMSWZHN0pYNzNST1NuaEtLZ1NrK0dN?=
 =?utf-8?B?dEVmQ0Qyb1FrUm9rUUV3WUVVSkx2RXZHMjF3WTBkRVdCT3B2Qy84RmExOVBG?=
 =?utf-8?B?TGs1NlRiL1l4U1A2alFUSEVEbzV5TjZsdGM4M0llZkNlOUVoSlNZaUZCd0JE?=
 =?utf-8?B?ZkJjZTVPaHpicGFxdW1XR0VRVDZnVTVQaGNKNitDaTVYUVdqdW55M2JlRmJE?=
 =?utf-8?B?VjJ0cVNlVXBqVnVlT0t6cGdMM0RFdG5mdTM4YlRJNnNlcHNzRTNTNmVXTXpX?=
 =?utf-8?B?bkdjRUdKSnV2bmp5VjlRb1ViSTJVRTlOb0QwNU5ZRW5kTHRDTm5JUllVSFJ3?=
 =?utf-8?B?YUZCdkNDbWRwVGZSQWVINFd5WnY0djgxK3FQSHZTc1FoUFhWRmRtV1I0UFdL?=
 =?utf-8?B?YlZMWGxoeXZkRzBnaTh1eERudVAxV2xOdE53VUFsM2NpY1JRc2RzUWdJQ3M2?=
 =?utf-8?B?eWVZWEJLdjYwSnJEbzBwOXUwU1BJMWZDalA1eDB1Ym9GVDdubERlQytBT09R?=
 =?utf-8?B?RVh3VTJqVWJaWWgySHFMMHIxWXVEVENvV1VWNmsrNlo1RmpoaFBnWWxuNUlR?=
 =?utf-8?B?WStXM3lRVHNyNFRqVDNMY0JQclM3L3lmNVRsQU1PVUJUQjRwYmZaVDVIYjBy?=
 =?utf-8?B?UmNwV3lkSyswcmp2R3dVN2IvN015UldTN0VwQmkxUnBvM3dDSy9IYVBDMmVv?=
 =?utf-8?B?VUk0R2w0KzhFT1M2cUNWdjFsdVQzV1BCOVZxMWEzNGF6MjJHZ2ZtclF5OGpT?=
 =?utf-8?B?RnRxY0k0MUVNTkczNUI3OGFqUTB2bHYyTkVvaW5ZWVdEdUZKVllZM3V0UDZP?=
 =?utf-8?B?VWhqU3g3OWY3NXBTdStqajRRUXpZaGcrb043UVFhUXBaY3luUVUram9Ra1Yr?=
 =?utf-8?B?cjFNem5XSFpEYTFVV3VXR0h5bUdzVnUxalllRkdWNWsvTXhyRjNXcVFOeisw?=
 =?utf-8?B?M2xFQVN4SlNpNGkyMzdMajZPNjJXdVRDQ1pqak52Z05jUGtRcDdwR3E2d0Jn?=
 =?utf-8?B?SUlDTnVZYjBtYWtndlY2NXB0WUF5OUs5TURvTDdrcWhsMFhUTXBJc0dYSE1J?=
 =?utf-8?B?V2FSUHRSUjlHZGZZcGpFOFNHbCtXTlhuZUNYQUttRFl2MXVNT3lmd01PNUlD?=
 =?utf-8?B?MkdGZ2JFdHk0Z0g2a0JoR2RkWXRudExBK2VKSjB1Y3puOVRIemRGQ0d1WnZY?=
 =?utf-8?B?THNoL0hXMi9LZFBqMHRCc0Nrc2RBYmxwbUtOWU5ObVVFWlJock1PRVZhRHpQ?=
 =?utf-8?B?REZuZ1ljbW5XbDBjT1RQZWdXTTl0dHdseEVIdHpOWnBzYW9YakVVZEpETW4w?=
 =?utf-8?B?RS9pYWVsaTBvTEZHSnJDcFRRK1ZNQllla2Zhd3BtK2k2M25uUnNuRFpiL2pj?=
 =?utf-8?B?S0ovZjl6VHhzTWtab2txRjBBQzBiN1M1TXR6NTFQMXpSQzVPQUFUTTQzQi9x?=
 =?utf-8?B?Q0JiWnlhT2lLSyt0Z2w4dEo5d0NSU0VzeGw1d1p1ZTUyaElHY2NZblZKZ2Fk?=
 =?utf-8?B?L0s1ZzRWMkRpUXQ5QVIrTWpKUmZqQVU0ais3OFRzWHVSclB5NnVHeEJFT1Mv?=
 =?utf-8?B?WERhRkViQjdnb3J0MG12ci9EMUhjd0dWYmRZZkw4YlRDQWV2bkVkSytxR3VC?=
 =?utf-8?B?YkNsR2g5KytBUVB2dGtTZXZsejZGK1pqWUUzV0d1T042U3FuRzlNZWF6Ulp4?=
 =?utf-8?B?eXlWRHFxU3RrWDBZcXhaUTF2ZTVoUjlpSDkybEZzRWFsaFhRWDhWRmRjQXRI?=
 =?utf-8?B?dFgxUk5mWXlWR3o2M0pRWHNRNC9QeEpZNUtBWXp6eFAzc2hQcXQ3UWxlSVh2?=
 =?utf-8?B?TENXVEpHOWdoVTJBMnEreERNclJlN1JXamlYdzE0Mmx0TWpQSkd4SHoyVlRX?=
 =?utf-8?B?UDI0QXFwVFp2TXVNcGVKM1pjMkNDejAwYURKRndoNmJkOGFvbVl6c1F0ajdw?=
 =?utf-8?B?aVhBWUxmSVNKbittYUdyQ2pxem12V1NzTzNkR3dPT3dJSkw0RE1PNC94Tlg1?=
 =?utf-8?Q?oR7j31rYSwk0FFs/e3uFsL+xz?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a55cec-bdc3-4c21-e136-08dca7c540d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 07:34:41.7205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdSXTy596u3gaikgMhTNipJBcRNN6WPfXpspv2RcotyAPv2XuIRHq1ae/FI+ZwE0NyOr12Rl3yT1AOGNVmLowg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7420

SGVsbG8gTHVpeiwNCg0KPiBIaSBWbGFkLA0KPiANCj4gT24gV2VkLCBKdWwgMTAsIDIwMjQgYXQg
NDoxM+KAr0FNIFZsYWQgUHJ1dGVhbnUgPHZsYWQucHJ1dGVhbnVAbnhwLmNvbT4NCj4gd3JvdGU6
DQo+ID4NCj4gPiBUaGlzIHNlcmllcyBhZGRzIGEgbmV3ICJzZWxlY3QiIG1ldGhvZCB0aGF0IGNh
biBiZSBjYWxsZWQgYnkNCj4gPiB0aGUgdXNlciBvbiB0aGUgYnJvYWRjYXN0IHNpbmsgc2lkZSwg
dG8gc2VsZWN0IHRoZSBzdHJlYW0gZm9yDQo+ID4gd2hpY2ggc3luY2hyb25pemF0aW9uIGlzIGRl
c2lyZWQuIFRoaXMgaXMgYWNoaWV2ZWQgYnkgY2hhbmdpbmcNCj4gPiB0aGUgc3RhdGVzIGZsb3cg
c28gdGhhdCB0cmFuc3BvcnQgYXJlIG5vdCBzZXQgdG8gcGVuZGluZyBhdXRvbWF0aWNhbGx5DQo+
ID4gYW55bW9yZS4gSW5zdGVhZCwgdGhlIHRyYW5zcG9ydCBtdXN0IGZpcnN0IGJlIHNlbGVjdGVk
IGJ5IHRoZSB1c2VyLA0KPiA+IHdoaWNoIHdpbGwgdXBkYXRlIGl0J3Mgc3RhdGUgZnJvbSBpZGxl
IHRvIHBlbmRpbmcuIEFueSBwZW5kaW5nDQo+ID4gdHJhbnNwb3J0IHdpbGwgYmUgYWNxdWlyZWQg
YnkgUGlwZVdpcmUuDQo+IA0KPiBIbW0sIHBlcmhhcHMgaXQgd291bGQgaGF2ZSBiZWVuIGJldHRl
ciB0aGF0IFBpcGVXaXJlIGRvbid0IGF1dG8NCj4gcGljay11cCB0cmFuc3BvcnQgb24gcGVuZGlu
ZyBzdGF0ZSBpZiB0aGVyZSBhcmUgYnJvYWRjYXN0ZXJzLCBvciB3ZQ0KPiBjb3VsZCBwZXJoYXBz
IHBlcmhhcHMgdXNlIGEgZGlmZmVyZW50IHN0YXRlIGUuZy4gImJyb2FkY2FzdGluZyIsIHNpbmNl
DQo+IHBlbmRpbmcgZG9lc24ndCByZWFsbHkgYXBwbHkgZm9yIGJyb2FkY2FzdGVycyBhcyBmYXIg
YXMgc3RyZWFtaW5nIGlzDQo+IGNvbmNlcm5lZC4NCj4gDQpXaGF0IEkgcHJvcG9zZSB3aXRoIHRo
aXMgcGF0Y2ggaXMgdG8gc2xpZ2h0bHkgY2hhbmdlIGhvdyB0aGUgUEVORElORw0Kc3RhdGUgaXMg
dHJpZ2dlcmVkIG9uIHRoZSBCcm9hZGNhc3QgU2luayBzaWRlLg0KIA0KQ3VycmVudGx5Og0KQSBT
aW5rIHNjYW5zIGEgU291cmNlIGFuZCBhdXRvbWF0aWNhbGx5IG1vdmVzIHRoZSBhc3NvY2lhdGVk
IHRyYW5zcG9ydA0KdG8gUEVORElORy4gUGlwZVdpcmUgc2VlcyB0aGlzIGFuZCBhY3F1aXJlcy4N
CiANCk15IGltcGxlbWVudGF0aW9uOg0KQSBTaW5rIHNjYW5zIGEgU291cmNlLCAgdGhlIGFzc29j
aWF0ZWQgdHJhbnNwb3J0IHJlbWFpbnMgaW4gSURMRS4gVXNlcg0KZG9lcyB0cmFuc3BvcnQuc2Vs
ZWN0LCBtb3ZpbmcgaXQgdG8gUEVORElORy4gUGlwZVdpcmUgc2VlcyB0aGlzIGFuZA0KYWNxdWly
ZXMuDQogDQpTbyBJIHdvdWxkbid0IGJlIGNoYW5naW5nIGhvdyB0aGUgUEVORElORyBzdGF0ZSBp
cyB1c2VkLCBqdXN0IGhvdyB0aGUNCnRyYW5zcG9ydCBnZXRzIHRoZXJlLiBJbiBhbnkgY2FzZSwg
SSB0aGluayB0aGF0IGV2ZXJ5dGhpbmcgaXMgaW4gbGluZSB3aXRoDQp0aGUgY29tbWVudCBmb3Ig
dGhpcyBzdGF0ZToNClRSQU5TUE9SVF9TVEFURV9QRU5ESU5HLAkvKiBQbGF5aW5nIGJ1dCBub3Qg
YWNxdWlyZWQgKi8NCiANCk5vbmV0aGVsZXNzLCBpZiB5b3UgdGhpbmsgdGhhdCB0aGUgdXNlIG9m
IHRoaXMgc3RhdGUgaW4gdGhlIEJyb2FkY2FzdCBjb250ZXh0DQpjYW4gY2F1c2UgY29uZnVzaW9u
IEkgd2lsbCBhZGQgYSBjb21tZW50IGNsYXJpZnlpbmcgaXQncyBtZWFuaW5nLiBQZXJoYXBzIGl0
DQpjb3VsZCBiZSBwbGFjZWQgaW4gdGhlIHNlbGVjdF90cmFuc3BvcnQgZnVuY3Rpb24uDQoNCj4g
PiBGdXJ0aGVybW9yZSwgdGhpcyBtZXRob2Qgd2lsbCBiZSB1c2VkIGZvciBzZXR0aW5nIHRoZSBi
cm9hZGNhc3QgY29kZQ0KPiA+IG9mIGEgc3RyZWFtIG9uIHRoZSBzaW5rIHNpZGUuIElmIHRoZSBl
bmNyeXB0aW9uIGZsYWcgaXMgc2V0LCB0aGUNCj4gPiB0cmFuc3BvcnQuc2VsZWN0IGNhbGwgaW4g
Ymx1ZXRvb3RoY3RsIHdpbGwgcHJvbXB0IHRoZSB1c2VyIHRvIGVudGVyDQo+ID4gdGhlIGNvZGUN
Cj4gDQo+IFRoZSByb2xlcyBvZiBibHVldG9vdGhjdGwgaXMgbW9zdGx5IHRvIGRlbW9uc3RyYXRl
IGhvdyBjbGllbnQgY2FuDQo+IGltcGxlbWVudCB0aGUgaGFuZGxpbmcgb2YgRC1CdXMgQVBJcywg
c28gd2UgaGF2ZSB0byBiZSBjYXJlZnVsIG5vdCB0bw0KPiBhc3N1bWUgaXQgd2lsbCBiZSB1c2Vk
IHRvIHJlcGxhY2UgdGhpbmdzIGxpa2UgUGlwZXdpcmUvYXVkaW8gc2V0dGluZ3MsDQo+IHNvIGZv
ciBpbnN0YW5jZSB0aGUgYnJvYWRjYXN0IGNvZGUgc2hhbGwgYmUgcHJvdmlkZWQgYnkgdGhlIHNh
bWUNCj4gZW50aXR5IGF0dGVtcHRpbmcgdG8gZG8gVHJhbnNwb3J0LkFjcXVpcmUgb3RoZXJ3aXNl
IHRoaW5ncyBtYXkgZ2V0IGENCj4gbGl0dGxlIHRvbyBjb252b2x1dGVkIGlmIHdlIG5lZWQgZGlm
ZmVyZW50IGVudGl0aWVzIHRvIHNldCB0cmFuc3BvcnQNCj4gdXAgYmVmb3JlIGl0IGlzIHJlYWR5
IHRvIGJlIGFjcXVpcmVkLg0KPiANCj4gPiBWbGFkIFBydXRlYW51ICgzKToNCj4gPiAgIHRyYW5z
cG9ydDogQWRkICJzZWxlY3QiIG1ldGhvZA0KPiA+ICAgY2xpZW50L3BsYXllcjogRXhwb3NlIHRy
YW5zcG9ydCAic2VsZWN0IiBtZXRob2QgdG8gdGhlIHVzZXINCj4gPiAgIHRyYW5zcG9ydDogQnJv
YWRjYXN0IHNpbms6IHdhaXQgZm9yIHVzZXIgdG8gc2VsZWN0IHRyYW5zcG9ydA0KPiA+DQo+ID4g
IGNsaWVudC9wbGF5ZXIuYyAgICAgICAgICAgIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gPiAgcHJvZmlsZXMvYXVkaW8vdHJhbnNwb3J0LmMgfCAyOSArKysr
KysrKysrKysrKysrKystLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA3NyBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjQwLjENCj4gPg0KPiANCj4gDQo+
IC0tDQo+IEx1aXogQXVndXN0byB2b24gRGVudHoNCg==
