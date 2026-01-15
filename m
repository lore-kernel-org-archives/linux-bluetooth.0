Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6B6399A6D
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768481280; cv=fail; b=O1rPx1lXeHdokL8e9aVnqM0tcmm2Z8WEE3NOPopA3r3E9iIgbRmK69D+sljihJyHd+3eapr010X97H1fSvrCVmwsTLZCTX0FVqVLsOaCem7q5GCgbIxkiHmSTZRh7SjoXDM5yindwNhUgOS3ccreCNZmJDUhLVRJpFIglbyN83I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768481280; c=relaxed/simple;
	bh=2tFuDoqgaH1Y8hOj8sMnFbmrk63IocwkHrYRvhWXA6w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=enYR6Tk3fC0U6oVwcFhtA2wpUX6+6q1EkjrRUO3O35lpIwsmQGWydXbQI8WwPP6Fak6oD+gBzuGdM6I9sqAA4KZc3a8TkEtLjZzSp4GS969dzLAf0u9QypJ3qvVT8XTsYQ2FrvWdW2T0/HEb3PQvWU3UGIuL7BHQtaQsrIlRoZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XMiSW6qP; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XMiSW6qP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRerQ/37+xBX5r8BEzFiXIJyraQqIiCPx4oIwIiJ1g+KRKJ5/N9nYC9cZlwYkyEyuGxORT/V4oZkuqUAAFlYGrOjSEvVvsNYl0bn3QM2OxySqhD9drPMsD+ZPAZplSNsGz7QA2klZX4LQAanUvp8lxbb8BaASgjnXjrmlvLsJb3dS75bIIbtY8WWWK0x/h4CRqejECk+BQbRpDmHlgqcH/drGYMf/fcOflnwHTPz+reTCRWsxbIro/mQUx1Eph0oqdGAw4EC8MgdHljbRlBh2QadmptIozaMIdAHXqHNfoBE5Km31o66u4AtHQ1PjpCQEOgmynXIQFW17Wf1nfTAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tFuDoqgaH1Y8hOj8sMnFbmrk63IocwkHrYRvhWXA6w=;
 b=CHpzu8UY4+gZs8L8fp7eJlAbu+Q1hKMYdtidSU3OqOn5R5cqUIjo/brgm30cSYHphCWfqBlYtJHdE5HkSwpcv4XJac6ZlztTQaY25YJubTrrgyxidpFyCZEwZz7DEIi3i2K4Mon2hFBBIytSTNE9agTOJvBwf98UZQ8BcPpD8Pz7xRNMydXtKKCNogpcRyCOCT6gxxRx7/C2MAeYjxIKvt8JaKerboKemvlU5uhhbNH2R9P1vTdirQQkl/rYjL2uBbijGrvsB5Ty4T60bD6VcaAotjI7OPhQmgVAJeYtd6HdYZV76g30F40CHVcw4jXTXwbpX0jGSFAfq/VrZV2yug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tFuDoqgaH1Y8hOj8sMnFbmrk63IocwkHrYRvhWXA6w=;
 b=XMiSW6qPlTI3pa9NEI1VZZ+dqMUJxesglPtaMJy32k+muKD7gPh0+VfyT+qYOAuhvEmbjd3MMn8ep2F1jgD/H8IIfNvbFJJTKN/8vz99xD3R4ZDnvjI7zUkriS5a5V8SWu5V6NBFmF+9SHo5M7Py/CFtdIB4zTcN2hXITVBwg9x+t7vAK7OqzEN6WT9Gv/dn4T0V2xR9KLIlLQvUCywCn9nmMiB9QQ1DBQeEvfov/S22Oe8wrw1DDQ3pGFerfIFqpgKiVZePitc0SVsPJoWQfeBAhMVB9FwgFgN1EOSQziAB5G4HOxFVnoGkGtjtZ84DmgOjCX9SJ4RMmdguXwfKGQ==
Received: from DB9PR04MB9452.eurprd04.prod.outlook.com (2603:10a6:10:367::13)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 12:47:54 +0000
Received: from DB9PR04MB9452.eurprd04.prod.outlook.com
 ([fe80::4c69:3f0c:6701:a1cd]) by DB9PR04MB9452.eurprd04.prod.outlook.com
 ([fe80::4c69:3f0c:6701:a1cd%2]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 12:47:54 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Devyani Godbole <devyani.godbole@nxp.com>, Sarveshwar Bajaj
	<sarveshwar.bajaj@nxp.com>, Vinit Mehta <vinit.mehta@nxp.com>
Subject: RE: [EXT] Re: [PATCH BlueZ v1 1/1] Enhanced Accept Synchronous
 Connection Request command is handled in emulator.
Thread-Topic: [EXT] Re: [PATCH BlueZ v1 1/1] Enhanced Accept Synchronous
 Connection Request command is handled in emulator.
Thread-Index: AQHcdJ7M0lZvYZ0uPEuypLWtxUbZOLVR2bQAgAF11AA=
Date: Thu, 15 Jan 2026 12:47:54 +0000
Message-ID:
 <DB9PR04MB94526C8409BC4F75CCA79CBE898CA@DB9PR04MB9452.eurprd04.prod.outlook.com>
References: <20251224063439.2477969-1-mahesh.talewad@nxp.com>
 <20251224063439.2477969-2-mahesh.talewad@nxp.com>
 <CABBYNZ+zsqdf4rmO8e+rb1ZNxJRxC31K_aa8kCaOHp53BqGUKA@mail.gmail.com>
In-Reply-To:
 <CABBYNZ+zsqdf4rmO8e+rb1ZNxJRxC31K_aa8kCaOHp53BqGUKA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9452:EE_|DU2PR04MB8552:EE_
x-ms-office365-filtering-correlation-id: 32da3185-170a-47de-5936-08de54344d70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmI2bWNxQW1Eck04bnIwMXFQTGFJcW84NDRUb0RXVEFqeXQwcjYyaldZMWRh?=
 =?utf-8?B?ckNIMjNySUNCcUFadVNISXlWRU5GYXhTRlc1eGhwMVFaSDFXbTd1YVdaSXBn?=
 =?utf-8?B?RHZCbEVXcnJWSnYxdWExNzh2QUJ5UWdyMlpsVUFwYU51ODJEWE96WUpZaFI5?=
 =?utf-8?B?MmM4Tjg5eHdleGNMS0h5dVUzNVNON1lib1RNQ1I1S0pqcTFjUWVjcjFRSXBI?=
 =?utf-8?B?RXBQYnVxcXg5eWw5UDJLVGxHNVhBTDRPZGNLUnJpUnNwM0thT0MzSEsxTHlT?=
 =?utf-8?B?WDZQVGE2VjgvR0t1cFZRZ3ZHWDlRNUpPay9lSDlINlVITzB1cmdUdTZpcnVR?=
 =?utf-8?B?UGJ4UEM2OThIbmpxUmdOdm5XL3M1dHd4QUw0Mi93NC81Y2xwMHpWYmtxVnZE?=
 =?utf-8?B?RnIwaXZPRDZ2OUlRU3Mzc2tNSW53THRTa3lEancvK1lwZzhLbUtNTGpXRkEy?=
 =?utf-8?B?eFlKd25nbnEyTThDU2FCTjN1ZnJGV1NhTUFnVHU1WE9rMCt4WEVseUhITStT?=
 =?utf-8?B?cVpVRjdiclpTODc3bThhMnNNVUNjeTlPT1JWNlJTcEJjWDVneHFSWUc1a3d5?=
 =?utf-8?B?akRCU3NmY2RmZURKVnQwUWNZdkFPYlI3WUkxNnFBaUFnR0VOK0hKMTN0UlNm?=
 =?utf-8?B?anFVa0NlQnBEbXVBNW1qVVhnVDN6Y3NDbUFhVVNMNUYwdHJ2NXExOFN0U3hU?=
 =?utf-8?B?N3diNzM4SXBIcmxhaG02SUplOXkreUliMFpiZ1BaL091YjNYejVLUUszNGQx?=
 =?utf-8?B?RTdIUUFwN1pGNmg5Q2ZUY0EwSVlFK2Uzc1JYOVhET1d4MFZ0bDBtdGhKR0Zv?=
 =?utf-8?B?ZWZpNWhFNnpJR2svM3RXcjFOY29PbnRhKzlDcHlGVlczTzNxUVJoNW5aZTNi?=
 =?utf-8?B?dWhZc1EvMVJTT1VFRzByeGs5UEJkNWVaV3IvN2k3U1p1MktoUkJHVkM2ekdx?=
 =?utf-8?B?SmZmL0Z5K3lhOU8yeFFwWmJIOTE4SVpWVWRualNUeUIvN0RQbko0cGZZS3M2?=
 =?utf-8?B?bFU1emtYV1ZPRkZ1TEJubWwzQU8xYWVTYW5zOWR3NnUxSmIwM1htakV3Mlow?=
 =?utf-8?B?bUJ3ZURvQlFpYk90SE05bDlidGpMZ1h1TEVnOW9Pc0p0bzlkMVArZ2FZbkV5?=
 =?utf-8?B?RXl0V3UrK254cUdsNkE4NVN2NDBTWm5SNGx6QnlaZFBLK1R2NXEzUnlBbTYx?=
 =?utf-8?B?UkkxUXROMHVjaEZlZHg2VlhEZ0NaUWQwdThob1B3TnRxenl4VjBmWjI0NlE1?=
 =?utf-8?B?S0JwZ2xCejAzdC9KTWNIV1RoVVlpeTA0UXFMWkwvUStYYWd3VjJEN1RlblJY?=
 =?utf-8?B?NXVRODFlYlkrQUJibnF3aVhwUHlFWmxqR0JzZEltTmc0ZEVXcWZIemJpRCtG?=
 =?utf-8?B?ODN0QmRzNDloZTJBejVDSjU2enNsQnJ2L2VYQjRGc0NHWEUwL2tpbUkyQmFz?=
 =?utf-8?B?TnZRaXBIZ0tseWJudUFFWEhSamNabHNQZkNGbDZITS93a3JiZUdKY1Y4aDQ2?=
 =?utf-8?B?ckovUEZDZGdhUTZnZVN2MDlGclpqY2hib3FWY2FRdFl4b0dkSFc2ZVBGUmVs?=
 =?utf-8?B?Y1NEa0NuejdPTGtxRjNUSTZZUXVxaGpwUGU1czkweDNPKzB6cDJ4cXVpZGYw?=
 =?utf-8?B?SVBYdlJvaENORmVSbnd5UGQvMmJHaWlyencrbDdLZ00vblBpazdiaHBEUTJJ?=
 =?utf-8?B?Z3FOakI3RWpFVDZVSDJBbWR2bnlhcE15NVFjZzc3Z0VZMkJuUnMzcUNNRGZU?=
 =?utf-8?B?Mzl3ZXFMeEdqU3B1VzhYNk1iQjNQeDlMZ1FSSjlINDViR2JzL0x2OFdESGZ0?=
 =?utf-8?B?djNGek1XRUcrUE1hYk5DazVDbXpUZCtuVVpQb0FpTTZvOG8weElaaXNYc1R5?=
 =?utf-8?B?U1lRNmdIQURjQlhXVE91SzlkY09LUGFqQ0tyUFluYURINVp5UzNjRi85VDhN?=
 =?utf-8?B?UVNUQjNiY1RXU1ZRazU0Vjh5L09UYWVPR1llb285cUp5Q01hQ1g4WVRVNDBS?=
 =?utf-8?B?cDJtTnREelNNODVsRm1USnh1SVdUYzdYMUlvVDJXK05LQ3dsVjdXUHd4amxm?=
 =?utf-8?B?UG93MXVPYUJUeUxrSFdqMXdqelpNV0hFWTRQcFJoSGtLQVBsdlpOTFV5UnJu?=
 =?utf-8?B?QXZNNzkvZ2FuSGp0MkVzeWV2bC8vdFZlRE03RVZRampVWXZhcEFPNG5BUGJm?=
 =?utf-8?Q?0+89ajd5vP4U/PBBf/sTOdw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjE0YzN6L2JPYmRvQ2paeEpPdUJ0dEVnN2kvVzBtc0FXY3V3THBLZjRyQXh2?=
 =?utf-8?B?dlNTMlZTOU1zc2hQK0lHRmcvTXMzOE11UStQYzFVb3ZrMlk1dWU2Si8vMDNT?=
 =?utf-8?B?WmZGVjZEOEpWdTZGUDlaaVU3blc4a0I5VEY2NVRvcXlMOWpEeEFCeXB0QjhP?=
 =?utf-8?B?SGpNUC8xOHJ3VDQ3Yng3bFpVaTVab05EbVdNT3Bqc0JvV1pvYmM5TXQxVXF1?=
 =?utf-8?B?ZFo5b1BWWEpPa1QyOTVFZ056b3l4cncwTGxIVkxlUmk3ditKMDFKKzBjWjR0?=
 =?utf-8?B?bWNFa0VkNFB0Y0tIY3BQQ3pNZzJNQzR0T3YwVlZINTdEMnpYVFFZQnJ2MFcr?=
 =?utf-8?B?MUtpblp1NHJLTEVZNjVtQ1p3Y0JIanJFTGpVamhNV1ZQdWk0enpENGcyc1U0?=
 =?utf-8?B?b2xodFYwazltckVuZEFlK1RHQjlqNnpBdkJaamlyRUIrWHFHM1R5MFN1ZHZR?=
 =?utf-8?B?T1VvNWFnMHY0NCtnV2pLRUZLY2dSMEJMWlRYNDh1K0xQV3NzV3RpMXRIRGVs?=
 =?utf-8?B?dHlJak1leTRlWkVTRFhMT1FuSTNBajlIS0U0eE9vMGhkVE9EZVdldC9FSlZx?=
 =?utf-8?B?TVlVVzJ1OTFwMGFDc0Q0M2hUc1VXeUIzSSthSjBrdmNuaE96Nm5HUU1rNjhB?=
 =?utf-8?B?RFhIM2hFRTdPRElZdTNGTzFxNy9NM0dLVlphZUhqeFpoQ1FqbU93VHNIazJt?=
 =?utf-8?B?V3RBSXN5ODl4MitSa0gwNDd0Wm9nZGdaWUtrTWdQbU5yR1c2Y25pZkVwaG1X?=
 =?utf-8?B?cXVmVEhub1JsL2dYWDNWR1MzM3VvTzZqblNGQzBMOTFOMHdEU09SbEM0UmRs?=
 =?utf-8?B?QkdCU3BoYnZuc0NoaUlNTCtkVnVhd3EvN3B6ZlUrVkVzZ3RwMDd0Smk1dm5U?=
 =?utf-8?B?a2FEWjZDSFNZK3hGK3VIdWJsaHlRRWZLdjI2VmVXNlFoVmp6cGNiUzN4WUk0?=
 =?utf-8?B?QmVZczdZTEN3cTdyckloNXRBUGtnYTc4WDFIRTRXdUJnNThsUlZsK01MSUUr?=
 =?utf-8?B?eDB6Tm5ITDU4cWNjMXNxR2pkRmhYRVF5WjYyUjVyVDFzMWNZaUxjcTZxRXg1?=
 =?utf-8?B?Vjhzb3RzOVNCeDk4MzM5QnloeGdTUDIwWTQ2bjlVejY1ZkZ1dzM4eVQxbmdh?=
 =?utf-8?B?TzlQMVo5cFJGdXdZMGpRYVVaYml4Z2F2LzBoeUc2SkEwKyt0eDhUdGdzNUxu?=
 =?utf-8?B?ajBpbE5NQzZJbFdwckNuYllDY0R4MEd5NGQxKzljSnR6c0JCZ3dxSjlXZU8v?=
 =?utf-8?B?OU4xZElFejQ0ZndGeFZtV0lGdGxVTXlyaTRWQThCdG9wWm9XMEM3Q2hadHpG?=
 =?utf-8?B?U3RNSlNlZm5Vb0lrUVd6QW9qWXNTSVZlbUl2YVBpZW9TbGkvcWl6YklaUW1E?=
 =?utf-8?B?UHovYXhVWXlYRFZKaVdwZzZHcVljeG1ubUdrMVoxNEtRVVVSTUhCMnl0dDRz?=
 =?utf-8?B?b3BMeWVsUEN1bmlKbkFYdDdXaFdvbjJQcGU5UXpsS1p3WlNNNnpOSm4yRG14?=
 =?utf-8?B?MFRPeFNHOXdPSG1WQkVLNVU5M09Vd01BUm82c1dERVZNV0ZRTmZYcEFUdCtr?=
 =?utf-8?B?U1JBekc0eVF1bHRIaUxtZjQ2YzZ4QUdVc2ZYNEtVNVVKWG9sblNPbHAyOEE5?=
 =?utf-8?B?TjFERElPem1TQjR4RTI2M0RRemM4cm9ma0ZlR2RpR3dvYkplT0VHdE5MbnFZ?=
 =?utf-8?B?ZWJYa1FvTENYRVBVSVNRL3laOEhrbUM2b0ZTKzE5NE9TK2RhSDBlUEI2NFBs?=
 =?utf-8?B?MjFEMVpSOEZ2VVZvZTA2VnV5dmxtTWFqVDkzMUZ6MmxuNEVRRWRyS091b0lU?=
 =?utf-8?B?Z2o0ZDVLSEZEOXFrMWxyMy9QenRUMWVTZnl4NVM3YUEyOGFsbDFXMit1Z2M4?=
 =?utf-8?B?ZXhRRFZVSjdMWlNhOVVMT0xkNzBrcU11dktDc0phWnlKbHlIb0wwVkg5Lzl4?=
 =?utf-8?B?eU9WMlV4bmRRT3I1M25UaVNidVRIeUdaK1oybkxreGtDZlBkUmtCMitmUmVh?=
 =?utf-8?B?TFJ2QUdxNWxSZU9IWTdGZC9xems2bG1NKy90YnFIa1BCTXRJeFBqWUFBTExv?=
 =?utf-8?B?MUwvSGZRdUJSMU1pV2VmN0ZZSDdxdDd4aUVkNjlaVGgrQzlqYi9RVTlGNmtK?=
 =?utf-8?B?K0xib2FicGpGWnhFQzZ6Um52ZVNRMy9XNkRzZ1ZIQ2ZwYzJ6djhzVjVqYStn?=
 =?utf-8?B?bTRlTFNvTld4T3dmNlJMeFpiRXB0NlJGbzVTYnNETG1UNWxnVktUV2dJSkxV?=
 =?utf-8?B?K3BrSEFxZlM4eUgxNlZaa3BWeGlPSTFULzZpdVk4THBWY2xKUGlyaHllQjV5?=
 =?utf-8?B?bGNwamZSeEExcEJuei9QRnVZQ1ROT1NTZEh2bjRGT05FRlJoZURNUT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32da3185-170a-47de-5936-08de54344d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 12:47:54.7194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMSmp52AjBb/vZXeU0telkB9zAlpIFMwIvb6pxL9kjkxErVZAaEiKQvQu1uq6aseENVMXZW1Xs3rkh+NElFVtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552

SGkgTHVpeiwNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEx1aXogQXVndXN0
byB2b24gRGVudHogPGx1aXouZGVudHpAZ21haWwuY29tPiANClNlbnQ6IFdlZG5lc2RheSwgSmFu
dWFyeSAxNCwgMjAyNiA3OjU0IFBNDQpUbzogTWFoZXNoIFRhbGV3YWQgPG1haGVzaC50YWxld2Fk
QG54cC5jb20+DQpDYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsgRGV2eWFuaSBH
b2Rib2xlIDxkZXZ5YW5pLmdvZGJvbGVAbnhwLmNvbT47IFNhcnZlc2h3YXIgQmFqYWogPHNhcnZl
c2h3YXIuYmFqYWpAbnhwLmNvbT47IFZpbml0IE1laHRhIDx2aW5pdC5tZWh0YUBueHAuY29tPg0K
U3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCBCbHVlWiB2MSAxLzFdIEVuaGFuY2VkIEFjY2VwdCBT
eW5jaHJvbm91cyBDb25uZWN0aW9uIFJlcXVlc3QgY29tbWFuZCBpcyBoYW5kbGVkIGluIGVtdWxh
dG9yLg0KDQpDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBj
YXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBk
b3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0IHRoaXMgZW1haWwnIGJ1
dHRvbg0KDQoNCkhpIE1haGVzaCwNCg0KT24gV2VkLCBEZWMgMjQsIDIwMjUgYXQgMTozMOKAr0FN
IE1haGVzaCBUYWxld2FkIDxtYWhlc2gudGFsZXdhZEBueHAuY29tPiB3cm90ZToNCj4NCj4gSW1w
bGVtZW50ZWQgdGhlIGNvbW1hbmQgLSBFbmhhbmNlZCBBY2NlcHQgU3luY2hyb25vdXMgQ29ubmVj
dGlvbiANCj4gUmVxdWVzdCBjb21tYW5kIGluIGVtdWxhdG9yW2VtdWxhdG9yL2J0ZGV2LmNdLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBNYWhlc2ggVGFsZXdhZCA8bWFoZXNoLnRhbGV3YWRAbnhwLmNv
bT4NCj4gLS0tDQo+ICBlbXVsYXRvci9idGRldi5jIHwgNjQgDQo+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYzIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2VtdWxhdG9yL2J0
ZGV2LmMgYi9lbXVsYXRvci9idGRldi5jIGluZGV4IA0KPiBiZTQzNjIzZTguLjU1MzY3Y2M3ZCAx
MDA2NDQNCj4gLS0tIGEvZW11bGF0b3IvYnRkZXYuYw0KPiArKysgYi9lbXVsYXRvci9idGRldi5j
DQo+IEBAIC0zNDM0LDYgKzM0MzQsNjQgQEAgc3RhdGljIGludCBjbWRfZ2V0X213c190cmFuc3Bv
cnRfY29uZmlnKHN0cnVjdCBidGRldiAqZGV2LCBjb25zdCB2b2lkICpkYXRhLA0KPiAgICAgICAg
IHJldHVybiAwOw0KPiAgfQ0KPg0KPiArc3RhdGljIGludCBjbWRfZW5oYW5jZWRfYWNjZXB0X3N5
bmNfY29ubl9yZXEoc3RydWN0IGJ0ZGV2ICpkZXYsDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY29uc3Qgdm9pZCAqZGF0YSwgdWludDhfdCBsZW4pIHsNCj4gKyAgICAgICBjb25z
dCBzdHJ1Y3QgYnRfaGNpX2NtZF9lbmhhbmNlZF9hY2NlcHRfc3luY19jb25uX3JlcXVlc3QgKmNt
ZCA9IGRhdGE7DQo+ICsgICAgICAgdWludDhfdCBzdGF0dXMgPSBCVF9IQ0lfRVJSX1NVQ0NFU1M7
DQo+ICsNCj4gKyAgICAgICBpZiAoY21kLT50eF9jb2RpbmdfZm9ybWF0WzBdID4gNSkNCj4gKyAg
ICAgICAgICAgICAgIHN0YXR1cyA9IEJUX0hDSV9FUlJfSU5WQUxJRF9QQVJBTUVURVJTOw0KPiAr
DQo+ICsgICAgICAgY21kX3N0YXR1cyhkZXYsIHN0YXR1cywgDQo+ICsgQlRfSENJX0NNRF9FTkhB
TkNFRF9BQ0NFUFRfU1lOQ19DT05OX1JFUVVFU1QpOw0KPiArDQo+ICsgICAgICAgcmV0dXJuIDA7
DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgY21kX2VuaGFuY2VkX2FjY2VwdF9zeW5jX2Nvbm5f
cmVxX2NvbXBsZXRlKHN0cnVjdCBidGRldiAqZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY29uc3Qgdm9pZCAqZGF0YSwgdWludDhfdCBsZW4pIA0KPiArew0K
PiArICAgICAgIGNvbnN0IHN0cnVjdCBidF9oY2lfY21kX2VuaGFuY2VkX2FjY2VwdF9zeW5jX2Nv
bm5fcmVxdWVzdCAqY21kID0gZGF0YTsNCj4gKyAgICAgICBzdHJ1Y3QgYnRfaGNpX2V2dF9zeW5j
X2Nvbm5fY29tcGxldGUgY2M7DQo+ICsgICAgICAgc3RydWN0IGJ0ZGV2X2Nvbm4gKmNvbm47DQo+
ICsNCj4gKyAgICAgICBtZW1zZXQoJmNjLCAwLCBzaXplb2YoY2MpKTsNCj4gKw0KPiArICAgICAg
IGNvbm4gPSBxdWV1ZV9maW5kKGRldi0+Y29ubnMsIG1hdGNoX2JkYWRkciwgY21kLT5iZGFkZHIp
Ow0KPiArICAgICAgIGlmICghY29ubikgew0KPiArICAgICAgICAgICAgICAgY2Muc3RhdHVzID0g
QlRfSENJX0VSUl9JTlZBTElEX1BBUkFNRVRFUlM7DQo+ICsgICAgICAgICAgICAgICBnb3RvIGRv
bmU7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAgY29ubiA9IGNvbm5fYWRkX3Njbyhjb25u
KTsNCj4gKyAgICAgICBpZiAoIWNvbm4pIHsNCj4gKyAgICAgICAgICAgICAgIGNjLnN0YXR1cyA9
IEJUX0hDSV9FUlJfTUVNX0NBUEFDSVRZX0VYQ0VFREVEOw0KPiArICAgICAgICAgICAgICAgZ290
byBkb25lOw0KPiArICAgICAgIH0NCj4gKw0KPiArDQo+ICsgICAgICAgY2Muc3RhdHVzID0gQlRf
SENJX0VSUl9TVUNDRVNTOw0KPiArICAgICAgIG1lbWNweShjYy5iZGFkZHIsIGNvbm4tPmxpbmst
PmRldi0+YmRhZGRyLCA2KTsNCj4gKw0KPiArICAgICAgIGNjLmhhbmRsZSA9IGNwdV90b19sZTE2
KGNvbm4tPmhhbmRsZSk7DQo+ICsgICAgICAgY2MubGlua190eXBlID0gMHgwMjsNCj4gKyAgICAg
ICBjYy50eF9pbnRlcnZhbCA9IDB4MDAwYzsNCj4gKyAgICAgICBjYy5yZXRyYW5zX3dpbmRvdyA9
IDB4MDY7DQo+ICsgICAgICAgY2MucnhfcGt0X2xlbiA9IDYwOw0KPiArICAgICAgIGNjLnR4X3Br
dF9sZW4gPSA2MDsNCj4gKyAgICAgICBjYy5haXJfbW9kZSA9IGNtZC0+dHhfY29kaW5nX2Zvcm1h
dFswXTsNCg0KV2h5IGFyZSB5b3UgaGFyZGluZyBtb3N0IG9mIHRoZSBmaWVsZCBhYm92ZSwgYXJl
bid0IHRoZXkgYXZhaWxhYmxlIGZyb20gdGhlIGNtZD8NCltNYWhlc2hdOiBUaGV5IGFyZW4ndCBh
dmFpbGFibGUgZnJvbSB0aGUgY21kLiBIZW5jZSBoYXJkY29kZWQuDQoNCj4gKw0KPiArZG9uZToN
Cj4gKyAgICAgICBzZW5kX2V2ZW50KGRldiwgQlRfSENJX0VWVF9TWU5DX0NPTk5fQ09NUExFVEUs
ICZjYywgDQo+ICtzaXplb2YoY2MpKTsNCj4gKw0KPiArICAgICAgIGlmIChjb25uKQ0KPiArICAg
ICAgICAgICAgICAgc2VuZF9ldmVudChjb25uLT5saW5rLT5kZXYsIEJUX0hDSV9FVlRfU1lOQ19D
T05OX0NPTVBMRVRFLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICZjYywgDQo+ICsgc2l6ZW9mKGNjKSk7DQo+ICsNCj4gKyAgICAgICBy
ZXR1cm4gMDsNCj4gKw0KPiArfQ0KPiArDQo+ICAjZGVmaW5lIENNRF9CUkVEUiBcDQo+ICAgICAg
ICAgQ01EKEJUX0hDSV9DTURfU0VUVVBfU1lOQ19DT05OLCBjbWRfc2V0dXBfc3luY19jb25uLCBc
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbWRfc2V0dXBfc3lu
Y19jb25uX2NvbXBsZXRlKSwgDQo+IFwgQEAgLTM0NzEsNyArMzUyOSwxMCBAQCBzdGF0aWMgaW50
IGNtZF9nZXRfbXdzX3RyYW5zcG9ydF9jb25maWcoc3RydWN0IGJ0ZGV2ICpkZXYsIGNvbnN0IHZv
aWQgKmRhdGEsDQo+ICAgICAgICAgQ01EKEJUX0hDSV9DTURfR0VUX01XU19UUkFOU1BPUlRfQ09O
RklHLCBjbWRfZ2V0X213c190cmFuc3BvcnRfY29uZmlnLCBcDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBOVUxMKSwgXA0KPiAgICAgICAgIENNRChCVF9IQ0lfQ01E
X0VOSEFOQ0VEX1NFVFVQX1NZTkNfQ09OTiwgY21kX2VuaGFuY2VkX3NldHVwX3N5bmNfY29ubiwg
XA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY21kX2VuaGFuY2Vk
X3NldHVwX3N5bmNfY29ubl9jb21wbGV0ZSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY21k
X2VuaGFuY2VkX3NldHVwX3N5bmNfY29ubl9jb21wbGV0ZSksIFwNCj4gKyAgICAgICBDTUQoQlRf
SENJX0NNRF9FTkhBTkNFRF9BQ0NFUFRfU1lOQ19DT05OX1JFUVVFU1QsIFwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgY21kX2VuaGFuY2VkX2FjY2VwdF9zeW5jX2Nvbm5fcmVxLCBcDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGNtZF9lbmhhbmNlZF9hY2NlcHRfc3luY19jb25uX3JlcV9j
b21wbGV0ZSkNCj4NCj4gIHN0YXRpYyBpbnQgY21kX3NldF9ldmVudF9tYXNrXzIoc3RydWN0IGJ0
ZGV2ICpkZXYsIGNvbnN0IHZvaWQgKmRhdGEsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDhfdCBsZW4pIA0KPiBAQCAtMzYwNCw2
ICszNjY1LDcgQEAgc3RhdGljIHZvaWQgc2V0X2JyZWRyX2NvbW1hbmRzKHN0cnVjdCBidGRldiAq
YnRkZXYpDQo+ICAgICAgICAgYnRkZXYtPmNvbW1hbmRzWzIzXSB8PSAweDA0OyAgICAvKiBSZWFk
IERhdGEgQmxvY2sgU2l6ZSAqLw0KPiAgICAgICAgIGJ0ZGV2LT5jb21tYW5kc1syOV0gfD0gMHgy
MDsgICAgLyogUmVhZCBMb2NhbCBTdXBwb3J0ZWQgQ29kZWNzICovDQo+ICAgICAgICAgYnRkZXYt
PmNvbW1hbmRzWzI5XSB8PSAweDA4OyAgICAvKiBFbmhhbmNlZCBTZXR1cCBTeW5jaHJvbm91cyBD
b25uICovDQo+ICsgICAgICAgYnRkZXYtPmNvbW1hbmRzWzI5XSB8PSAweDEwOyAgICAvKiBFbmhh
bmNlZCBBY2NlcHQgU3luYyBDb25uZWN0aW9uICovDQo+ICAgICAgICAgYnRkZXYtPmNvbW1hbmRz
WzMwXSB8PSAweDA4OyAgICAvKiBHZXQgTVdTIFRyYW5zcG9ydCBMYXllciBDb25maWcgKi8NCj4g
ICAgICAgICBidGRldi0+Y21kcyA9IGNtZF9icmVkcjsNCj4gIH0NCj4gLS0NCj4gMi4zNC4xDQo+
DQoNCg0KLS0NCkx1aXogQXVndXN0byB2b24gRGVudHoNCg0KVGhhbmtzIGFuZCByZWdhcmRzLA0K
TWFoZXNoIFZpdGhhbCBUYWxld2FkDQo=
