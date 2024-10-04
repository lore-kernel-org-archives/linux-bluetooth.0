Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3281AB4;
	Fri,  4 Oct 2024 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728027396; cv=fail; b=VAj3vWIVghjNAfRJp02o2zkG3PLcO32oIM05RHaHy2FhAEBgVHdL6s9qGkAnBx4mTHeZIjkzIZuMP2LegbCOwcuqKsF2LmhU6dsHzad6ILOSBWfvolF/MRQc3YFk9xHSIDNVisrGEI3So3SDaxFjvlq4pXwwyJ+Q7hR6ohWhRc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728027396; c=relaxed/simple;
	bh=6lDf+SVWA/jUlQSQlDG1wnFGMk1wjW3XmpQiNkpB3pU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UJMR3Q6NH5qDow8ubWr5sc2ADx6543r9h8NhTa5X4rmyOENpNkOnYEqOdibP9xMJhkK5TK4fZ+tgf72IkcoImxRBgyhLpDIGoKrYPS/+bk41EYn3Tja6jhBmmbOLZ6670MY1UkSurUTsAseAwYQfpKjbMwNcTOi5uHSd4jiAxME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BAz/TrGT; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BAz/TrGT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqj5qYWi7KnL5mRm/IqnYH5dB5pqEoYLSbE8fmxYTnCnU/TwwaC4yAh1QOwRJwYhb5CYhBNiIzBJSPkiuCW+DkrwT6id+LwJq2j7Yuli0iuJTELiqZrAGOzHG+j9+nkc21z4oud9U8bZkwKFdGTNrHBx5f6iWbSQepFmby/HdhULo5megUgeq9wYO/QVEnjLHHoTJ3x7Bvo4o/b5UUWH5OQcVipuvgoI+M3QFSHMkj9M4mEwoiaquPUfYGHEKb94OUT3evW1ZxFIjMlIvw1KpJfU9sqwwml58Vr0g0Alvave8WOHsfBck4ocGnl2K+klhV1cmJ4CjDAF49VWq5sBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lDf+SVWA/jUlQSQlDG1wnFGMk1wjW3XmpQiNkpB3pU=;
 b=x3Rggo/Yj4BNLOwcWnRR9U+qmNUDtb29qD6eG5W0yH3VAnmV3CSaaLymCsvxT/ENv/TcyVXrL4PU7z4YVb7pjGpiU/iEwvksZFL+UhSDA0SustpVOGfFWkYjrA7pTimBiSwYMP3xsO7c5T+c12nlGrJ0E3eYn0r2iQ1fej5IW7oPpyCQRXwLiMr7Nro4KCDanWaMVjof++GwqtylnaqAM43q7dihDbCoqaqgWYE+0NSpAAM8SAGgWML2vzfBlS5RKdsE+2KkTJUGdxbji/LpP/oYmsSPNG5FqXz1XZ7y9LxtCqemOMhmaSMyA2yhjMkadthVQNr9r+Xq0AVJZkhCRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lDf+SVWA/jUlQSQlDG1wnFGMk1wjW3XmpQiNkpB3pU=;
 b=BAz/TrGTCSJemiPxNKOHC/lmUbIVtQKOzK8daodIC0+w2kXnwGViQVQ7RRQDr1s2mnfYXuXkeGnK9JVV6zc2a/1hYia77k0P7HXlPI0NmPD7ku7JvJx23dTqRX5NpoTXsr9hC6wptHgoW/OsmQGsNJbSGD+4+exCOv8Xkrt/+UERkPZTsOXJi5du6jzym3mvus/rJq83SR4nZ4Y/Y77+GoJKkg3rGWSEO3y7GOXQnA2RXmEVehrgjdUD27DnBP6E6DVEDc+b06b8b7wkWpS+XGCNI5aPadWLQbdYQgTzO74vLu+yRvZbacehavnI3vEY/WXcoi37NsNW/yhCLOvGrQ==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by VI1PR04MB9762.eurprd04.prod.outlook.com (2603:10a6:800:1d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 07:36:30 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 07:36:30 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Rohit Fule <rohit.fule@nxp.com>, Sherry Sun <sherry.sun@nxp.com>, Luke Wang
	<ziniu.wang_1@nxp.com>, Bough Chen <haibo.chen@nxp.com>, LnxRevLi
	<LnxRevLi@nxp.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 power save feature using GPIO
Thread-Topic: [PATCH v2 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 power save feature using GPIO
Thread-Index: AQHbFjAgbd+mQnaqhUaWmZyL6jvrNw==
Date: Fri, 4 Oct 2024 07:36:30 +0000
Message-ID:
 <AS4PR04MB969238D42394A9FDDAFD2F83E7722@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20241003154507.537363-1-neeraj.sanjaykale@nxp.com>
 <20241003154507.537363-2-neeraj.sanjaykale@nxp.com>
 <sllfy6srzwlwemkesnrgbdegywy6llysrylq45xf7no7ox7uwt@4u25dxff2fyr>
In-Reply-To: <sllfy6srzwlwemkesnrgbdegywy6llysrylq45xf7no7ox7uwt@4u25dxff2fyr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|VI1PR04MB9762:EE_
x-ms-office365-filtering-correlation-id: 4dfa9f38-cf3a-4e2f-9381-08dce4474375
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3NtWVExMUZ3VWpOZk1wNU4wcHl4REdFajd3UkFocVJkSXNDak8ySGhsZU1m?=
 =?utf-8?B?Q1dxdEtFYjZkMWZKWEFUd1ZYaVFacmZrUGhHRnZxT1dCZzBLT0NOaEQvbzM2?=
 =?utf-8?B?QTh2UXpaQTEzb1ZRS0daY1BVR1lwdThzeU0xUnRpTGZCNEdVNzNNTE1CTkI0?=
 =?utf-8?B?OTlzMVVMa0xDNldvaERvV2s1bW5UTk5TYVpweDVjNkdLU0ZNSUl5YzQ5Z3dv?=
 =?utf-8?B?NmhWVThLVVg1R0kxbzRQYXh3RGFwUTVBRFBnNHFuNFl4TElJMjNpanR4dGk1?=
 =?utf-8?B?dDBnSnZ6U2dpL1ArYy9rODhsSWlKMm1NWnlQQis2RDZsQjNxTzI1TC9RanpV?=
 =?utf-8?B?WWNKNGF1N3M4Zm9ya3c0THF1MFRVclVFLzFzWXhyTkh5VDRiNUxXS0NsTTh6?=
 =?utf-8?B?K1lycFZQbjBVOGpKWGthVjlCRDhmVnR1YVdWZWR6TkNQbEJkU0F3cHo2MkQ0?=
 =?utf-8?B?YzBIbktQRE12ZzlmZC84VHNlZ2ZmWm9KM0c4REY0THVvc003TTNpS1EwTVlM?=
 =?utf-8?B?bE9hMWloSGV4UjhzWGhPczZ3aFB3Vi9zbmJKc0pwcUZNTjZOQ3RaTzRRaXNH?=
 =?utf-8?B?YTVLYkd2TTN4ZDdKdGdKVmt4blp2T1N6a2pocnArZjY4NlRHWnhuQ3NSeWZt?=
 =?utf-8?B?cDdjWUxGU3ZjUjhleWxkeTgrandPdlBoK0tVTWV1SU1KNzJrY2pTaG9Cc1oz?=
 =?utf-8?B?alFzbW5vMFBGVVZtdjNoNng5QlVOOTNRcFE0OTl3dUxRaHRCUG5mcnpFZ0p6?=
 =?utf-8?B?Rk1tK1QzNEZsYmZBSUYzamJDaThTMEw0QkNrYWNERFNhV1lHOGlJQS9xZGM1?=
 =?utf-8?B?MDk1UHErTGRQNXFUZHpEVkFTRVNyR3B0NzRBMkVKeUdubkJEeHhJYUJ5VTFW?=
 =?utf-8?B?d3kwWVYvaGtOTlBBTXBsdkxtLzlDdWxHSTNNem1yOVVRZVBzQjN5MXdEODBn?=
 =?utf-8?B?RXFJMjA5N09WMzBaMzB2UEVQV0I1M215VURLU3FYem5UWHRXQVNvZHlKM1hs?=
 =?utf-8?B?VHJmNEo3eVRrc25NeXhwYTZHR3pWU0w5Y1NIU1paSzFBTkRSNTNnd3g1UVhB?=
 =?utf-8?B?N045VjhxajZudUE4VnQ0RmJCUnVFdGszNFdUVi9wM1dDZEJKaUlHWmtNRTBm?=
 =?utf-8?B?emlDVmpONlQvZ2NvUUE2UkJIQ0VkMFhuL1JDRG9YNmZCdklYMFdKNyt4Z0FK?=
 =?utf-8?B?WkFBWHUxREd3Njd1QW9wYXd2blorQjQxaGZlVVVXeUE0Q2pOVHhwWXd4U2Ra?=
 =?utf-8?B?dmNSRlJ1VHVuL1lNWG82RmZRKzl4R3VQV1grcUkwTzRBNEk3OW9relJUV2Ni?=
 =?utf-8?B?VzNoQ1pOT2ZVQ1hEaWlpWTF4cWxZWEw0eVpMMHR4QVc0WVRzejQxWjhpTkpy?=
 =?utf-8?B?eWdiZFZDaWlValROSjVzb2xNWkI1NElGLzJzTjEySjltOXdtNzRPTWFUcFFF?=
 =?utf-8?B?M0hWLzZEV1Q2OURlMVJkUTlvWTdnT3FxanF0cFJ4c3Jub2ROK0hXZ1NpZDI1?=
 =?utf-8?B?T0Fab1VFOHNWdEM2cE0xdjRNenpwTzhjQis0ZzVjQUJ5MFY1UHl1d1htTnhh?=
 =?utf-8?B?QVhEaVR6ZjFnU2kzZVphQi9SZHBGaDJpbW4yQnIreXVYSjQ2MHhZc1JwVHQ4?=
 =?utf-8?B?RzJMTEpadnRpbmI5Qlo4dHJuanRNT3Jxb3N5Y0YxTjBmeU1Na3lYWTI4VVVH?=
 =?utf-8?B?dXNBSW4yU0ZLRFExd2FTZC9LTUNGZm40MzZYcnJSZ0l1NnRRMzRxVTFFTEw3?=
 =?utf-8?B?RjE0TUtxZ2pPcnQ2Z1BvNGdSQzVRcnprZENPcTNmdG5meFc4QlFzQTc3d3kv?=
 =?utf-8?B?YU9tOUx0Tjh5UUdoZVA3UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SS96ckxrdG9MS3hOdTRUc0NaSTQ4Tmsway83TlNSVnBSVHUzcjQzMmc1Q1RH?=
 =?utf-8?B?QzA4QnlUOTlIUkFSZ1J1M2xFSXU0V0lCZjBKcFl1WjR3ZG5WSEJmOWl2cytk?=
 =?utf-8?B?SUNKUSt6OGZJQkU1L1RyQThudEtsRk8xUFZLU2NhRkRsbGxiekFTTXN2QkIz?=
 =?utf-8?B?MC9ReUFrN1NRSm96U0tqVGUyWUpmSlhpTU9TNEp0TSsxejZ1UDk1WExtVmIv?=
 =?utf-8?B?SWJzV1BEVFluejZNNlpMV1QwVjFjZHZCUjRkMGJFYy9YVkdIMGhhNFRzbi9Y?=
 =?utf-8?B?M2I1KzNYWkxBK1VvWlBWVjY3SE1WTlZYanZ4Tk9zbGRyOU51R3lTb0JnenFQ?=
 =?utf-8?B?SGMrMWlLeHdhMnlqdDRkSE5IbWFoY2F2bjV6Z1BIdHJNeCtZNnovRFV4b2Yx?=
 =?utf-8?B?V1NhUVU2eVEvWlI0eWZrenEzb3NRaHNuVFhldS9CcE40aFlDdnRXamQ2WldP?=
 =?utf-8?B?czdYN3F3S2luMVZ0MGJhajV0QXJHN1VQVG5EU3FYbkMveDN6Vk9WRFhtTFhh?=
 =?utf-8?B?QTF0OFdJeTV5SUsreVM4emluQm1tYTJ4RndPcXIzVGRqYjE4K0kxVnkweUxi?=
 =?utf-8?B?NHFYVmVzYjNrMXB6TlZjYjl4eE9xQjZNaEkzRDQ0YWxPQmFhajJHM29EM2JP?=
 =?utf-8?B?ZWEvbFVIOExBR1lnbGdueTd5YW1kL0cyYkRhZ3dTWDRZNzF1alBGSDFDY2Vo?=
 =?utf-8?B?NDgwcmRvOE9FWis4NHdiRnFSQmNiek15OXp2enZOSHZsV0NpWFRBWS9zMWVw?=
 =?utf-8?B?U3R1aHhqY0ZEMnZxdWVxVHF6MkluNE56TlZwRjlaQ0VLdC9MVTBQamdlMFU4?=
 =?utf-8?B?d0xRbTRPTTBjclkrb2pEQTdJWDZHQU9VZ3lKZlV4YkRpVThYVWF3Sm5xaUlE?=
 =?utf-8?B?UThzRG9Hb2J1QTFLckFqNnMrdTNkRkdzNVJqMFRKbGlFcDlQckFNdGQvL2lW?=
 =?utf-8?B?L3hwWjJ1SVhsSVExTnVsQlFPS2w0RHdBaktXVi9xRW1OUkhIcU5raXBPUzR3?=
 =?utf-8?B?Q3g1ZXdWSU1iSFhEV1N5Z3ExTnMwUkY5NGtMSGp1aDA5VUlET284TGhQYzh1?=
 =?utf-8?B?YlptbGN1djFMeHVmc2s2QVZ2SzNObVE4bHFRK3ZPcEs5ZGJabUZtV1hzaXhj?=
 =?utf-8?B?cXJ3dDV6cytwVVl1cHNkVkhDNnlPZ2ljQ0RNSFI0WmQ0cndHUi9MMEpYeDAy?=
 =?utf-8?B?bUJBZ0ttdi83dms1SUd4WHVQMERRWGZFVi9JSVEzbkJybGRYYnk2dUpEaGQv?=
 =?utf-8?B?MUtvYndieEtPVUY5K3JzQXYvNXVVdnllRE41ZlIwTGlIdDFoTWhWZE1ZSnh3?=
 =?utf-8?B?cEMxa0xQUGlYdEsvVGVKSmxYZ2trL2xtUWVXVzgzMm1CMWp6R2x2aUFlelFu?=
 =?utf-8?B?T2ZOZFJUSWxRVmZERGQ0T1dsR3ZLUVVuYkxDSkZ4V1ZxZjBhczRoVThMOXJL?=
 =?utf-8?B?OVNDZ1dKSHBFb1VQTXU5MjQ1c1RhRzRBbmpqdFJ0VmdZejhYQVp5aG1yLzcv?=
 =?utf-8?B?UGJWMkVNTC9iaEE3U3h2ZmhhQUN3N3IvSlBKMnhBQTBKN0VIMlQ2K2YxWU92?=
 =?utf-8?B?dXV5M0FUZFlaRHdBT1NKd1A3WTNPcWUwVndPaXZOUENWaFlFQ0N2M0NtUTFx?=
 =?utf-8?B?YlFVTWI2cFRBdzdzcG1PWVhFUEc3TDl4VG94ejljZ0s0NFRHZFVDdDBYcjBU?=
 =?utf-8?B?Y3A5SFhEMTM0NERURGhQYWo0YkZSbXFocVNiMmVsVzYyTkZETWRRU2M3c2t4?=
 =?utf-8?B?WStlWWlxY3MyQjArZVdYNkl6aERkU3Q3TXIvR1V0QXhsVnlEaFBVbDlTNnZn?=
 =?utf-8?B?alpnZUk3SkUrRVZqeld6S0VJRzdMYmw5blFaaUpHZWxwb2NRVlhLZE15VlRO?=
 =?utf-8?B?UEtxaUZVL0hrSEpubjV0TnZXemJYTEY0TnorMU02YVNOMHRseVpWcVZhNVBU?=
 =?utf-8?B?YnVGSjN3eFY0R1FBRU44cUM1eTlicjMrQTUzRFhXd05NZmpPdjdPZjZaSU1p?=
 =?utf-8?B?QzM0a3ROSEFwSFNPeTZxbWRGbjRUUmsrQWd2aFVZODIxbVlCVVdBcFEremFm?=
 =?utf-8?B?cGxINWNVbExtMHpjMk9yTUxYTU5UUGVnL2ZaSHN0bjBXZldVSE8vbkY3ZURZ?=
 =?utf-8?Q?eIuZB8iLh1/YGkmdC2amG5/bp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfa9f38-cf3a-4e2f-9381-08dce4474375
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 07:36:30.5286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Hss+GSbN+wUpCvR3f2fZzw6IHtQw91med2p08udk+bIKAjJW/0Fb2O/ardaIKSeCQTVj3HuAGRpNmiYD6uYQYqGos7dVkLHqFkM4JbfvWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9762

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuDQoNCj4gDQo+IE9uIFRo
dSwgT2N0IDAzLCAyMDI0IGF0IDA5OjE1OjA2UE0gKzA1MzAsIE5lZXJhaiBTYW5qYXkgS2FsZSB3
cm90ZToNCj4gPiBUaGlzIGFkZHMgYSBuZXcgb3B0aW9uYWwgZGV2aWNlIHRyZWUgcHJvcGVydHkg
aDJjLXBzLWdwaW9zLCB3aGljaA0KPiA+IHNwZWNpZmllcyB0aGUgR1BJTyBjb25uZWN0ZWQgdG8g
QlRfV0FLRV9JTiBwaW4gb2YgdGhlIE5YUCBjaGlwc2V0Lg0KPiA+DQo+ID4gSWYgdGhpcyBwcm9w
ZXJ0eSBpcyBkZWZpbmVkLCB0aGUgZHJpdmVyIHdpbGwgdXNlIHRoaXMgR1BJTyBmb3IgZHJpdmlu
Zw0KPiA+IGNoaXAgaW50byBzbGVlcC93YWtldXAgc3RhdGUsIGVsc2UgdXNlIHRoZSBVQVJUIGJy
ZWFrIHNpZ25hbCBieSBkZWZhdWx0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmVlcmFqIFNh
bmpheSBLYWxlIDxuZWVyYWouc2FuamF5a2FsZUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+IHYyOiBS
ZXBocmFzZSBkZXNjcmlwdGlvbiBhbmQgdXNlICItZ3Bpb3MiLiAoS3J6eXN6dG9mLCBSb2IpDQo+
ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9ibHVldG9vdGgvbnhwLDg4
dzg5ODctYnQueWFtbCB8IDgNCj4gPiArKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbmV0L2JsdWV0b290aC9ueHAsODh3ODk4Ny1idC55YW1sDQo+ID4g
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2JsdWV0b290aC9ueHAsODh3
ODk4Ny1idC55YW1sDQo+ID4gaW5kZXggMzdhNjViYWRiNDQ4Li5jZDgyMzZlYjMxZGUgMTAwNjQ0
DQo+ID4gLS0tDQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Js
dWV0b290aC9ueHAsODh3ODk4Ny1idC55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL25ldC9ibHVldG9vdGgvbnhwLDg4dzg5ODctYnQueQ0KPiA+ICsrKyBh
bWwNCj4gPiBAQCAtMzQsNiArMzQsMTIgQEAgcHJvcGVydGllczoNCj4gPiAgICBmaXJtd2FyZS1u
YW1lOg0KPiA+ICAgICAgbWF4SXRlbXM6IDENCj4gPg0KPiA+ICsgIGgyYy1wcy1ncGlvczoNCj4g
PiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgSG9z
dC1Uby1DaGlwIHBvd2VyIHNhdmUgbWVjaGFuaXNtIGlzIGRyaXZlbiBieSB0aGlzIEdQSU8NCj4g
PiArICAgICAgY29ubmVjdGVkIHRvIEJUX1dBS0VfSU4gcGluIG9mIHRoZSBOWFAgY2hpcHNldC4N
Cj4gDQo+IFNvIHRoaXMgc2hvdWxkIGJlIHdha2V1cC1ncGlvcyBvciBkZXZpY2Utd2FrZXVwLWdw
aW9zPw0KPiANClllcywgaWYgdGhhdCdzIHRoZSBwcmVmZXJyZWQgbmFtZSwgbGV0IG1lIHF1aWNr
bHkgY2hhbmdlIGl0IHRvIGRldmljZS13YWtldXAtZ3Bpb3MuDQpUaGVyZSBtYXkgYmUgYSBkaWZm
ZXJlbnQgZmVhdHVyZSBpbXBsZW1lbnRhdGlvbiBpbiBuZWFyIGZ1dHVyZSBmb3IgaG9zdCB3YWtl
LXVwLiBTbyB3YWtldXAtZ3Bpb3MgbWF5IHNlZW0gY29uZnVzaW5nIHRoZW4uDQoNClRoYW5rcywN
Ck5lZXJhag0K
