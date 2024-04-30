Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0325213D633
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2024 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479829; cv=fail; b=Qq8r9NJ0DOIKgYA3BEfdPD8PZbI4AfCyiJVyPiCo1H6r1SW4yCPgIH8BHt0Ee3JEFayy2TUaxkA4ld85F3kmXMO7eDb3aFSOE5tj+Nq8cEqxgrQvmXDL0PzmpfmBJh4b8JR0dDvi2RAyaCVk7fLbNThrtR+X7cKJGkeb9r0ozks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479829; c=relaxed/simple;
	bh=Wue0x+LtiXXSVnx7nQeTzY7AuJYGFG5Jece8Fq4EhJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QRFjQCQX1VNzbR5ucEDERkVgCODYtr4I3cDV3BW4gGqWM1OXL28TRen8PJawe1GVTyRBE+xPjyLw3KCtn4yodbCcoEhMmeKqxKZRNAZQXmbkKbWMZeUGCMPlGvxLp4KaU9acug4ut4Vtrs6/rzhVYgk67Tf4NPL0TpPzaNUquS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=n4/UseP8; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n4/UseP8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYheXa1aonAyWXc8FMeTfuJRMevy3cptEEABRZrcRGlDxbx2uDr1ZOlHVMEmD/MteJZBGpeKlYhjL/GzvvlghsR/v3zUkI/14Aq8isgYfncxXWLWT/ADEzOHb1pRGsUBma4gSM0GVgP02hEU0HT+nPPhq9fCXiPU3DKXA9X1wBpoTeurl7FVN0/TtclDkCUAmnH0kdna+GZCFVbgLJseC1Fh3OEMHPhHiKxGeVk5rCtyWQkk//NAzhvbU5GyysuuLrx8uLvBZ1qrStkpcmxva7PK9A27xxg4Qco8vPZgrImshL4CLsXZV9EKoXgx8Wyfi7wgXsZOjWlxiLKa9Xmbgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wue0x+LtiXXSVnx7nQeTzY7AuJYGFG5Jece8Fq4EhJo=;
 b=AVH7Ocot77uJXySSrxpdBANjPaGQ0hv63w8J0+Mn3CGtpPPsEANKDKDUuucM4FGV43dcvgyiMSYz0iO3acHcF3l2ik9Y1SYnJZen3KSVRVHhvze3zA8KkGBJ2mtEFRodTelxd3QT+hV4iUUxNhQM/HMP2tByxXEBCmAFEcTksnMIUDeZK6895dYewx5O/6H6moDc3bs1xIRrQX4SDT77ke9QjxyU0GA/bae/yK5V6Kor10m15KsRN1abMkgqQyFc2bs5bNA7BbBKnh6fb9ZtzkLru2EFOqQ9p4+8ciS7lMsn5zClMMLOylOxEYlPPD7zPQSUNgEaSN0ebH+cEg8PpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wue0x+LtiXXSVnx7nQeTzY7AuJYGFG5Jece8Fq4EhJo=;
 b=n4/UseP80RtJnUdFwgUzBZ1RiOB1CXKhpGVKbyLo9y4wn4mkiATGat/8PzN4rmCZaLvfHhcGmoYKSq8A+3S2f4pHeWPpgNlmmyANYBGhOVi3nDXWs7ad0CTuUdTiXVAA1uEFPa6ivDQBYSN1ghbwZKpa57KRTikBkV0fDDNUjt0=
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 by PAXPR04MB8237.eurprd04.prod.outlook.com (2603:10a6:102:1cc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 12:23:43 +0000
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::f1cc:8138:54fa:6fa2]) by AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::f1cc:8138:54fa:6fa2%3]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 12:23:43 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Devyani Godbole <devyani.godbole@nxp.com>, Sarveshwar Bajaj
	<sarveshwar.bajaj@nxp.com>
Subject: RE: [EXT] Re: [PATCH BlueZ v1 1/1] LE Create Connection command
 timeout increased to 20 secs from 4 secs
Thread-Topic: [EXT] Re: [PATCH BlueZ v1 1/1] LE Create Connection command
 timeout increased to 20 secs from 4 secs
Thread-Index:
 AQHaeTEPMqiC0Iq8WEO4vPnWaUEu4LFAZciAgAAQ9bCAAA5eAIAzrrFQgAN1N8CAAGC6AIAI9LBw
Date: Tue, 30 Apr 2024 12:23:43 +0000
Message-ID:
 <AS5PR04MB97540A3B63FC307F4B64F2BB891A2@AS5PR04MB9754.eurprd04.prod.outlook.com>
References: <20240318123712.9729-1-mahesh.talewad@nxp.com>
 <20240318123712.9729-2-mahesh.talewad@nxp.com>
 <CABBYNZKvAmb5JjfxkPADED6CQKD+GxsRqLajHX=w0GE+imhCMA@mail.gmail.com>
 <AS5PR04MB975486834B434042CE2A693689332@AS5PR04MB9754.eurprd04.prod.outlook.com>
 <CABBYNZK5YS6paOYbx4yL6R7Wt9o+oGrtmfiQNmOaTAUo2DBfdQ@mail.gmail.com>
 <AS5PR04MB9754B55170413A2FD0A00F0A89122@AS5PR04MB9754.eurprd04.prod.outlook.com>
 <AS5PR04MB9754210A13AD74FB8C3E361D89102@AS5PR04MB9754.eurprd04.prod.outlook.com>
 <CABBYNZJJq9UTf467LXJ-7WvWbn8bcge0L6CprkGSnu4ZpopSpw@mail.gmail.com>
In-Reply-To:
 <CABBYNZJJq9UTf467LXJ-7WvWbn8bcge0L6CprkGSnu4ZpopSpw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR04MB9754:EE_|PAXPR04MB8237:EE_
x-ms-office365-filtering-correlation-id: d3793367-029d-4583-05b3-08dc6910606c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?bnc2OHVPVzRab0piRXI1N3FGTzI2YnU3U1B6YjNZKzNrMEwzSmNTaUJKVGJV?=
 =?utf-8?B?c1JwOTJSSURUTHlTaVhRb1ppUExLRVVTU00rNksxalNYME5VYXFTZVVLaGh3?=
 =?utf-8?B?bmROSVVzYlNRaTdKcFRaR09Zc0htbEVLdXN0VS9qdFBmWG1CQUthd0lISEZj?=
 =?utf-8?B?SkxWSDFOMG9LbWhZZ3o5bnFCekhFcHpxQXRYN2hkZHpPOSt6V2YvOGZiOHhS?=
 =?utf-8?B?ems5L1dVK09zMTNJd2YxdzA1Tlk0T0xtcU1ZUlpLZVZqNncrNGFxVmZockF1?=
 =?utf-8?B?K2FKSFJ4RG9qQUtoTHJkOFEyOThTSmhxWkRsMGRTVUNtdklXMUo1L1BCQVZQ?=
 =?utf-8?B?MGEwdHkyZlg5Z3AzVlJ6MWtkVG1xZjlUKzNiSitYdXlPV2pVZUQvSWNwYTdV?=
 =?utf-8?B?Z25KVHZZdVFiazhJbHQvNGtNdllCK0c4L3Z3THlGQkUrZ00wSm5KMHJUN09n?=
 =?utf-8?B?TG81QzVvUjhLU0FoVC9mWlpxazQySE02STJwYlpxeUJSV1AvQi9qcXBod0JY?=
 =?utf-8?B?Q3ZMbitmT2wraVNnKzBjellMZ1RVdkJzbjVNR0VQRFAyei9ieWIvS3ZmdTZ1?=
 =?utf-8?B?UEFGM2V3UGRHRDltWW5PR2drZTVPcUxTS2Q5TkUzMGhVNmVlcnJLSVRmaXRT?=
 =?utf-8?B?Qnl0eHFBYjdaeHlDeXAyampyMVlJRXhOelRnSmdoMFBidnhoMTlDUzVhOWIy?=
 =?utf-8?B?TmJOc1JqREdtTVM2ZjR6V1dNalVvUTljZ21qZGJuTVBtaHZkTFllUXd0QzNC?=
 =?utf-8?B?VUdCWmJmTXVEbkYzaDhoOXBBd0FPcU1vcVErSDlnZk1IQm50Nk1HNWlPZnhz?=
 =?utf-8?B?a2luTnBsNGVDMUdvRGpZa00yeFV4QVltdVIxM01oOE5WNEpzRmN2ZUU5bmJa?=
 =?utf-8?B?SDk2TmR2N2IwZWZDVmp3T211SFA0Q1JsQ1djK1BCYW1wUmxHZGZHQzQybTli?=
 =?utf-8?B?dmdyREhzbG4zTmpmbVNiV1hNc3FsS0MxbUkvajh6aXZ1SytMblpXMFpIanJ3?=
 =?utf-8?B?bGcxQzVkUncrNUdUZjIwd2tGWFhlVkg2dWplUDc4Sk1vT3Q1NTNPejArTG9V?=
 =?utf-8?B?dFg5TmlxcVBETUhSU1NLTE5HU0VIdVNPVkozK2ZaR212MkJ6ZWRlRTRUc0VL?=
 =?utf-8?B?bzB4OHdWVmdScGE0NGdXMmZmcFhVQzBGdHhydUk3QkErSm9idXZORERXTkFt?=
 =?utf-8?B?V3lYR1Vjd3QwOC92bS9yaGNld01KVjBjR1RURzJ6VnA5NE55ZDlsMzAwUEU0?=
 =?utf-8?B?ejRTVXhvREM4dUhKL0lxWE1UQ01HT0sreTdyWW15VVNSL0JTNzN6NEliQ25L?=
 =?utf-8?B?N0I2bkx2YUYzYzM4YUptdHREYUtoZXZqYW16dnY3VzQ1dXgybmhVZE5tR0RB?=
 =?utf-8?B?UXFBNVB4WnZiWWRQTE5yTldvWUprOHh6a01GVXZvNUM4RHdjeERpS29ib3Zt?=
 =?utf-8?B?eVV5eldsT2NwMzFjVk9WTTNlNUNBWW5FMkl5ajIvYlNlN0h2Mm9MVm41ZWx3?=
 =?utf-8?B?QzFqQXlQQ3FqZkgwYXdiZzJqSldneGM1UVB1SW4zLzBjTFd6S2RmVGJFV1pi?=
 =?utf-8?B?eVJZMTU5dnhBckdZMWdJc2hKZ1RCV1dCMDhCRnNseDI5MnhNY3BxMHNzTU93?=
 =?utf-8?B?bEpzWHU5VUxWSjZKWGw1cUM0Q3VlZm45UUxiSmc1VytGTmFidFdERkRnU3hZ?=
 =?utf-8?B?bWNaakdmL2tIVm1EVmNBRU81eGo3cTNvVExjUTM0MlNrcFlMZ0RUQTRIOU1q?=
 =?utf-8?B?WmsyQUdVTTNIbjFkNGxXanRNcjdBZTB6WVh6WU9pQUkrMTNjTWVrWld5Mk9v?=
 =?utf-8?B?ZWxHMHp2M0tYcXk3T1RDUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR04MB9754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXorajV6WmphQXFMejFrQ2xVcEtySUYzMUtPaHVxbXphVXRvQUIrbHF6SURF?=
 =?utf-8?B?UzZvU1NhWHJ1Vi85QVJIWWl2RDRFcFdPVEVwUkp0R1lRbDBmblk3UmVjYm9S?=
 =?utf-8?B?WXlZbUMyMmlPMG83aTdFQWxQdzJNUVk1a0ZYWGJyMUlrYy9TSVJjMU9Kck9l?=
 =?utf-8?B?L3cwU21nazBtTWY4b3FsaHl3Z1lyWCt1YlFHVFpmN1N2ekhSakc4dHBiVkp0?=
 =?utf-8?B?ekVqNnVUc2ZIbTYwYWJTLzY2bEsraG1KRm83MHJNaXFRRXNHckpURmFESWhK?=
 =?utf-8?B?aFZJemtoWENOT1VrMjFDa0Rqd2F5aE1DZkx2VUorazlzdFJhTG1FaHJSREFp?=
 =?utf-8?B?TmV4OHFiYUJSYklpWVpGTkcwQUdoU1lRWXI5UmdVd09KM1pYWlN2VzZ6dm5h?=
 =?utf-8?B?aTF3N2YzSG44dzU5dk93ZzdWT2xyK01nTFZ0MUNjb0ZZeFJVTml4Zy92WGxr?=
 =?utf-8?B?RFFuNEEwSDZjZG5xOW9nWUVQVlNmbG9rZndtR3dQanR0SmNCUStSVktlblZV?=
 =?utf-8?B?ZzQwdVMxK0NJRjVOWXZwR0hXNm1KN1FsaVFPcTV5V3dha1Y2azJQZ1pLc3ZP?=
 =?utf-8?B?Q0UyV0ZEa3d2aE14U1p5MHJnYlgvOUp3dHY1VTNEcUxSV0c5QUFXb0FaWWRI?=
 =?utf-8?B?dGdjQkdXbEZzbWJ0dStGd0ljWDFMektKb0doQnA1SEJMZUUyUHVHOXdka3Yx?=
 =?utf-8?B?QnJZVzMvdUhlUXVGR21mYjFaM1pZUlZSUU9Ecld2c0ZsTFJsb3Zsc0kwNjNi?=
 =?utf-8?B?UHhvQWNscEZmQVlFS3hCaWNHT1dLWTlJeTJBRXJQekhnYUgwMFZFbEVQSVpu?=
 =?utf-8?B?OTdzSTNPU1lGdHhaNTFUNHdqUzc5QytsWmxSSExtSWpHcE9zbXVGRGQ0VFdI?=
 =?utf-8?B?NkxxUjZtYmRQLy9OK3R4QythQzlXWTRldXlOUjNDVHJaczlTTHFvY0cvSVkx?=
 =?utf-8?B?Q1VTbU0rVnZLM2NBbmNUM1RkN0Fwd0VlMFJhVWFFS3FSZlZFeXQ0U25ZYnhj?=
 =?utf-8?B?V0Z1MFpLNDlrc1BSMDgzS1dOMjE4ZU4wTVdjSGtBQ0tmcXNoZ0RSSForWWlG?=
 =?utf-8?B?d2l3ZERGWU12czBsaHFsTkd3UnJsR1hIdnloYzNzNXNSMGpST0RMNWp3NXVR?=
 =?utf-8?B?bml5dm5GQWZqOVp6MDluMFdnSUt2OUx5U0dwb0NQY2ZJN1B4NHRoWWdyUWFh?=
 =?utf-8?B?UHZZYTM0azFpRHFvcWxiSkxPaDBHU05WdnpRdDk4UnNDRjBkaDNJYjRMWVJK?=
 =?utf-8?B?QUpXcFIxNDRBMFVaRkZjU0FWdFBjZ0NHS1FWZU9tSHZDcnY0aVZDLzF0dUpJ?=
 =?utf-8?B?bHB0R3BxWHBmU1RkaW9heElURXBFRUttTWVWR0N0YmJLOU8rbFYzOEh0UVV3?=
 =?utf-8?B?ZG03Wmx0OTRBWVJFOXZsc1R0Q1dPMnBlVFZwSVZoYWVUUGhYanFKeDBRMXZs?=
 =?utf-8?B?UHRZb1U5YzFkc2lyRGFtQU1PUlYxbC9DeHAvcWE3Rlk0V1g5aWpUNEE1UThF?=
 =?utf-8?B?WFFMOUVOSStFOUlEN1VIVlBBNTRqYlRxRm5JUzJ3dFlrcGh4L2pQamlxMkxt?=
 =?utf-8?B?NExDREVJVGtvZ1Rqbmk2SWdYQTh0VUVZWWoxVG9LMTJMbUpKdjB4d1NmOFVq?=
 =?utf-8?B?WVdDakYvTE5iUHljcHRhTEk3THFCS01NVCt6azZXUklMd3U0Mm5Vb1ZZMGZF?=
 =?utf-8?B?OVNKWE9qbkVUdStYMWZITThMM09hUGhOVjVaR0x3dWtIb09PKytRbkt5L205?=
 =?utf-8?B?VGxWaG80ZlVEL0JpeGtFWEJ0ZXFQV04zQ3ZwOHRpRVYzWGFqQ09wR3B3K1pv?=
 =?utf-8?B?a1JtdWRQSHh6emQzcWNLMjdjaDhaM1d6ZUVmdWxKWnhWY0pRcTFRQWliUWJw?=
 =?utf-8?B?d3NtelcwWm45Y0kxYm0yckdvdXQ1L0lNbXNER1p5djJxeGptbjlFalpDTTJD?=
 =?utf-8?B?NWtKdXE2eXl1RW53UEVoQ0xTL2hGSVZPZCtqUXhlUk02Y2l4Vm9NT2V0TnE2?=
 =?utf-8?B?YzlGRzVaUE8vQUI0K2JPNTVxb0pWQ3dmSmRpK0phMkMzSUk4dEJyVytPcy9i?=
 =?utf-8?B?QTJ1V0RvYi9Pakk3ZzI3Q3o1VTJwWWxJOEJpRFpQRWFKNkV5dDBjVVlvTnVF?=
 =?utf-8?Q?M9XFtqFodGXat/iVhBc7AYDfp?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS5PR04MB9754.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3793367-029d-4583-05b3-08dc6910606c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 12:23:43.7555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2yEp+/AQHxiYHYNRMK0DboZZLo6m8HI947LpF3wnWJ9ShePPF6/5G2qQ7Oi3exChspeOI0LPlm3akgWINlHBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8237

SGkgTHVpeiwNCg0KVGhhbmsgeW91LiBUaGlzIHBhdGNoIGlzIHdvcmtpbmcuIGxlIGNvbm5lY3Rp
b24gdGltZW91dCBzdWNjZXNzZnVsbHkgY2hhbmdlZCB0byAyMHNlY3MuDQoNClRoYW5rcyBhbmQg
cmVnYXJkcywNCk1haGVzaCBWaXRoYWwgVGFsZXdhZA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei5kZW50ekBnbWFpbC5jb20+
IA0KU2VudDogVGh1cnNkYXksIEFwcmlsIDI1LCAyMDI0IDE6MDIgQU0NClRvOiBNYWhlc2ggVGFs
ZXdhZCA8bWFoZXNoLnRhbGV3YWRAbnhwLmNvbT4NCkNjOiBsaW51eC1ibHVldG9vdGhAdmdlci5r
ZXJuZWwub3JnOyBEZXZ5YW5pIEdvZGJvbGUgPGRldnlhbmkuZ29kYm9sZUBueHAuY29tPjsgU2Fy
dmVzaHdhciBCYWphaiA8c2FydmVzaHdhci5iYWphakBueHAuY29tPg0KU3ViamVjdDogUmU6IFtF
WFRdIFJlOiBbUEFUQ0ggQmx1ZVogdjEgMS8xXSBMRSBDcmVhdGUgQ29ubmVjdGlvbiBjb21tYW5k
IHRpbWVvdXQgaW5jcmVhc2VkIHRvIDIwIHNlY3MgZnJvbSA0IHNlY3MNCg0KQ2F1dGlvbjogVGhp
cyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxp
bmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVz
c2FnZSB1c2luZyB0aGUgJ1JlcG9ydCB0aGlzIGVtYWlsJyBidXR0b24NCg0KDQpIaSBNYWhlc2gs
DQoNCk9uIFdlZCwgQXByIDI0LCAyMDI0IGF0IDk6NDnigK9BTSBNYWhlc2ggVGFsZXdhZCA8bWFo
ZXNoLnRhbGV3YWRAbnhwLmNvbT4gd3JvdGU6DQo+DQo+IEhpIEx1aXosDQo+DQo+IFdlIHRyaWVk
IHdpdGggLSA2MDkzZjI4NDAyYWE2MzQyODkwZmMzYWRiNmJlMzU1ZjgwNGI3MTlkIC0gd2l0aCB0
aGlzIGFzIHdlbGwgaXNzdWUgaXMgb2JzZXJ2ZWQuDQoNClRoZSBsZXRzIGRvIHNvbWV0aGluZyBs
aWtlOg0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaS5oIGIvaW5jbHVk
ZS9uZXQvYmx1ZXRvb3RoL2hjaS5oIGluZGV4IDVjMTI3NjFjYmMwZS4uZmJmMGE2MjYzZGFlIDEw
MDY0NA0KLS0tIGEvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaS5oDQorKysgYi9pbmNsdWRlL25l
dC9ibHVldG9vdGgvaGNpLmgNCkBAIC00NTYsNyArNDU2LDYgQEAgZW51bSB7DQogI2RlZmluZSBI
Q0lfQVVUT19PRkZfVElNRU9VVCAgIG1zZWNzX3RvX2ppZmZpZXMoMjAwMCkgIC8qIDIgc2Vjb25k
cyAqLw0KICNkZWZpbmUgSENJX0FDTF9DT05OX1RJTUVPVVQgICBtc2Vjc190b19qaWZmaWVzKDIw
MDAwKSAvKiAyMCBzZWNvbmRzICovDQogI2RlZmluZSBIQ0lfTEVfQ09OTl9USU1FT1VUICAgIG1z
ZWNzX3RvX2ppZmZpZXMoMjAwMDApIC8qIDIwIHNlY29uZHMgKi8NCi0jZGVmaW5lIEhDSV9MRV9B
VVRPQ09OTl9USU1FT1VUICAgICAgICBtc2Vjc190b19qaWZmaWVzKDQwMDApICAvKiA0IHNlY29u
ZHMgKi8NCg0KIC8qIEhDSSBkYXRhIHR5cGVzICovDQogI2RlZmluZSBIQ0lfQ09NTUFORF9QS1Qg
ICAgICAgICAgICAgICAgMHgwMQ0KZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvaGNpX2NvcmUu
YyBiL25ldC9ibHVldG9vdGgvaGNpX2NvcmUuYyBpbmRleCA5OWI0ZTY4MDc1ZjQuLjY1MWU1MTA1
ZmRkNSAxMDA2NDQNCi0tLSBhL25ldC9ibHVldG9vdGgvaGNpX2NvcmUuYw0KKysrIGIvbmV0L2Js
dWV0b290aC9oY2lfY29yZS5jDQpAQCAtMjU1Niw3ICsyNTU2LDcgQEAgc3RydWN0IGhjaV9kZXYg
KmhjaV9hbGxvY19kZXZfcHJpdihpbnQgc2l6ZW9mX3ByaXYpDQogICAgICAgIGhkZXYtPmxlX3J4
X2RlZl9waHlzID0gSENJX0xFX1NFVF9QSFlfMU07DQogICAgICAgIGhkZXYtPmxlX251bV9vZl9h
ZHZfc2V0cyA9IEhDSV9NQVhfQURWX0lOU1RBTkNFUzsNCiAgICAgICAgaGRldi0+ZGVmX211bHRp
X2Fkdl9yb3RhdGlvbl9kdXJhdGlvbiA9IEhDSV9ERUZBVUxUX0FEVl9EVVJBVElPTjsNCi0gICAg
ICAgaGRldi0+ZGVmX2xlX2F1dG9jb25uZWN0X3RpbWVvdXQgPSBIQ0lfTEVfQVVUT0NPTk5fVElN
RU9VVDsNCisgICAgICAgaGRldi0+ZGVmX2xlX2F1dG9jb25uZWN0X3RpbWVvdXQgPSBIQ0lfTEVf
Q09OTl9USU1FT1VUOw0KICAgICAgICBoZGV2LT5taW5fbGVfdHhfcG93ZXIgPSBIQ0lfVFhfUE9X
RVJfSU5WQUxJRDsNCiAgICAgICAgaGRldi0+bWF4X2xlX3R4X3Bvd2VyID0gSENJX1RYX1BPV0VS
X0lOVkFMSUQ7DQo=
