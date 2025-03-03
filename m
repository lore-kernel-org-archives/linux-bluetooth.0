Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8013C8E8;
	Mon,  3 Mar 2025 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993899; cv=fail; b=mnCUTNwRVALwVtZrwS/pdYzOWY/8UG3sk1yn8O+Y71UETWEnjdGXMgXWWwaXD60X1knAdEnhrEFH7pv8WMay1aZZolFUq07dZ+actDvMMZhowh1FD0y70tO4lbGGsjFTlaFmHyhGxm/85l5vE6oD3ozJEmB5bpstS1xnBYTqcqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993899; c=relaxed/simple;
	bh=5GOdcPDMFx08ZroUVsXYkqmU7NG7FGkOJDpLNdYMjtc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y0VAjjeQUY9JONatc/u+BocnSWBkZAcLzOLqlQAlAYIqR+XmAs3ZQoovs2eTTIJ92PbYS/YYKEgj3kL3k+I+MZlOnmFcW/xbgkmkwFne8M96xL2MbiqZ6F9lUPsgpoNnI1xHYjMsGHOM6DzXngxgNj3GSpQT0YY0NO/wD3DP7i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GFOuD0Ms; arc=fail smtp.client-ip=40.107.104.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GFOuD0Ms"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJBa4CfTIU4QQoo+bAjFBLNf0JmVOB6dH6Uq2kgyx45O138pOSeKpq/dTTDEuFTPjEOyyNep6G36hzdYq62n4YFySYMXCQ8DfJF8hf6rzcuXyO7hQcoxo/Zy9YFXs628DwSfOzEYstzmaYCbCGLDaTv/jmTrX34OMM/RwrbnCKn5wmDzSLn5qMfjDfHDCIiwvG2qK7gSsAAf4YZdAPPQPYu9vKZknCn1F3JafF5Q386+ppO5Jdw4YhMfGhZwepCXUjL8SMlM6eHF9Yrkg7RZS0sW0h5v/JL32lVa5n8fnvQdmPZrs3ORLmXctqppn7+6pGeAvRuO6Npdxa8WC2rNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GOdcPDMFx08ZroUVsXYkqmU7NG7FGkOJDpLNdYMjtc=;
 b=xGVMAQo1Fc7ylTRArr/3grFw6JSAqE+DXM5KrpW1xEHYO+rvKWSSXJ6fVAYGmIAJUhQK6L7KJwrEN4EhoZklqGImpKUCPew2/AAnCobUWjnC67OjfWAcHBKmYwfOq41t0mIQ6p5/jHv/+9O6PaYz0l6uic8kKe16Ko8kIyIbaADU05gOO33/l894oYrfE5Y2phuJhCco53A/XOc9qcYL0j8CApIBGypzAr5/ZsJuYhI8IS6HGjVj+pbu3ep9U13Yyk1/BGEYVaezy0sK4d2jsgBJHaR3zQ9JEMH1KhEn4TDN4yBMx7G+InVX4Ijs+WqybIf/J5urcBWeGFykBtCdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GOdcPDMFx08ZroUVsXYkqmU7NG7FGkOJDpLNdYMjtc=;
 b=GFOuD0Mse/Iq7Kfh4Zmoq/kOUAvAf7EUhTWM/C8W/HWIcFiJLUGrQd1MKIKX5ejpXOg12OEK+Hl9VZXTLveedbIFsFfPRW2KDqLfKq+SjVQ1+4m6PDW9jOLLDXAvC4aFIla1AHpH18ub9t1+BaP8nzuwGk35GDrk7D+y765kze2JCIVWXOQMFV9871FoVlbX7qiyAAre/AvqpUDG8vnzeDWyS59ugtiKroFrVGnZvTz1O8OyQXF2dVMSlD5JwsWl1paEww7X9+6V5qNGva7dtu6R1w8F9DnKsFr++SpyUe4ORS0vmVw472lgv/RZm1P/xSi41hKBxIy20nO/1HZiTA==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by VI0PR04MB10289.eurprd04.prod.outlook.com (2603:10a6:800:242::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 09:24:52 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:24:52 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Sherry Sun <sherry.sun@nxp.com>, Luke Wang
	<ziniu.wang_1@nxp.com>, "johan.korsnes@remarkable.no"
	<johan.korsnes@remarkable.no>, "kristian.krohn@remarkable.no"
	<kristian.krohn@remarkable.no>, Manjeet Gupta <manjeet.gupta@nxp.com>
Subject: Re: [PATCH v6 2/2] Bluetooth: btnxpuart: Add support to set BD
 address
Thread-Topic: [PATCH v6 2/2] Bluetooth: btnxpuart: Add support to set BD
 address
Thread-Index: AQHbjB4eSmUvLL/f1UCKjFRt2h0l3Q==
Date: Mon, 3 Mar 2025 09:24:52 +0000
Message-ID:
 <AS4PR04MB969235CFCC9D2D74A5C17322E7C92@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250228152917.5432-1-neeraj.sanjaykale@nxp.com>
 <20250228152917.5432-2-neeraj.sanjaykale@nxp.com>
 <CABBYNZLMFYaEjgRhO7J+sDRdp=JPVhgLdLrUNWkum5YTc5dv_w@mail.gmail.com>
In-Reply-To:
 <CABBYNZLMFYaEjgRhO7J+sDRdp=JPVhgLdLrUNWkum5YTc5dv_w@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|VI0PR04MB10289:EE_
x-ms-office365-filtering-correlation-id: e3edc43d-1a57-4eb7-fee2-08dd5a3540e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aVkxcXNhc1FaRTVSOTJmVWJrdEZiVGFsRmZaR0xqWWNmS3VXZkM4VFEzM01T?=
 =?utf-8?B?VVlKZ2k0eXc1ZSt0a1UyYUJXQUQ5a1pHRmNxUXpTVm5jQ0pYaWxwTjhhZDdS?=
 =?utf-8?B?aHpkUGFzNGJVTUFFazBGaWxTbHRhVjl3b1ZNdEdKMzBzMmRORkRiNU0rdTdy?=
 =?utf-8?B?UVdrNzljNkJaQXB2RVduMjVUaGdZMjJ0c0RnR3BBTlc4bnE0VWl3dWtoR29E?=
 =?utf-8?B?NzBXZVZUZDJnbjR1TzNzUDJaaVBHWnkyZklaZWpKeUdWcmFuNWU3RDBTaTU1?=
 =?utf-8?B?YUdjeElpYnBScWhxZHBXdG44eWdIL2FXWWNpVmN0WkhkUmFxMkNnbm8zSzFS?=
 =?utf-8?B?b3NjUmQxN2gydGl3OWlOaUVrQk96V0liYlRMWmExSVNIbmRCNmh1ZFJWYUFr?=
 =?utf-8?B?ZGFuZW45UFdlS25vOHVKczF0TmEyVHAzK21VaEkzWjJoUWxzZGM2SStkRDRG?=
 =?utf-8?B?cjVkZENqSkZIMm9FN1Z2WlF5V0JOSHlVL2ZGc2o0aFFQS0RVTklKczRZYWlp?=
 =?utf-8?B?ak4zcHlpS0NKRGw4cndQZVpLVTB6WVM4QkJ3U2grRjhwME5zMWdXdUtPWlln?=
 =?utf-8?B?cnVNcVZMRmg5bEcxZU1pdzl3OHRlSTAwNlVCb1pJWVkzcVlQcFFaUVBwMlk2?=
 =?utf-8?B?aVB5d1ExZzZFTHNLSlRidVkrTTVqNjZJNTJYc0FUK014U1JYc1dPRnhrOEVu?=
 =?utf-8?B?SW5nZk56Q2IvTVpyQ21lR056WEZVcUZ0bk8xampLbGFXdVNWb1RvS1VFbVVs?=
 =?utf-8?B?ajNZV21kN3hTdWppTE44M3ZiYko3ZGtDcVZSNi9wN3VhV01pZTRnakNjakhB?=
 =?utf-8?B?R3FFazNCMHdndmMrelVLekREeXp0eXIrTGF0Q0NONUJ0MzA0NHY3Vm1MQTRz?=
 =?utf-8?B?VU9uMU85Vm9SSlY0VHZwWmkyUWlvY2hna2V3Zkc5Mk1VK2hTZ1RuSzN4VkJp?=
 =?utf-8?B?Yk5WSElsekY2dzJ5WkhnREtsZDNJQWdJNmQvRWx3VTZIOU5tUGxKdFhvalpS?=
 =?utf-8?B?MHlmRWpmcjAwQmhwaUlSOUF3dXk0RXBaMzl3TlZXTDN1eWROTGdnQ2VYQTJv?=
 =?utf-8?B?bjhzQnhxdnhaMEVjOWlWUmIxRTF1MjNoQkt4a1UvU3d6R3VOZ0tWdmpyZm1I?=
 =?utf-8?B?YU04ZTdoL0tvNHFXZndpOEtRdmRRa3ZqOGE5ajJKM3AvNlpKYllWcjh2d3RV?=
 =?utf-8?B?Ry93S3dkQ25WRnpMbE43cHZIc3BNYU5kRGZnZldmaUYvSW9zVE5JamM2bEc0?=
 =?utf-8?B?MGxRWXljbGdDandoVXNsMjUvZnl4eDI0aDFLM1pXTlRzNmhQa0FKaGZpbEk1?=
 =?utf-8?B?SnlUVld0aWNJbW9hYkN6Y3pzYXhyd0pQNjJPLzNKZFBuL1RxTzlOYkpQZkIw?=
 =?utf-8?B?ZWhld0dQNG9rS1JyMzZHdjIxMXFISitVSkR4UEMzUG81R3BmbXNiNXYwd0J4?=
 =?utf-8?B?aEVCZStlVVQ3WmpCYkk5MUdySzZsOUVtVnQ5eUp1M0dzVmU5Z2dVVGJuTm80?=
 =?utf-8?B?U3hmNGp3ZXRza2hvalc1amVRMFlTeUo0TGpaODlFYmdYWVdHZHhxVmxUcHMy?=
 =?utf-8?B?ajlFMTFtdWNGbjBUL2Nqbyt0VmxIYi9ZeHJtUWNDaVpKSTNqVjZYZnNJSDhX?=
 =?utf-8?B?SXpWaU5YUG5CZ3pmK2RCOEtRemZJQUs0ZUVIMU9va2V3VWNRMTRyQzhUY0pn?=
 =?utf-8?B?KzVUZzJqS2dFRFBHRHY0Qk5UWE04aW1ZWllpd0szaHF5T0xDY3FzSGE4cElL?=
 =?utf-8?B?c0tadWRjY0hQVEVrbEJEb2xUT3dqczd0LytyU1h6cW9WZVZoeW5VZ3IveVlz?=
 =?utf-8?B?bWI0ZUVWaUdOWXdqWDNJRzVVTjJCMjBteG9WeUVJa3RWWE53UWZXeEdnekgw?=
 =?utf-8?B?ck83amxFRk5NNEw2ZUtDSDJIY0JrZmZMNElDY1ZrVGJiZXZJWE9EdG1CTndn?=
 =?utf-8?Q?pimaAdQHljKqanOtlVeUItVJBc9LHydJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnpzV0FyMGNYK1VuMER3WkdVVUxCRktTUnM0RHVIcDd6Wm9RNEhFb1lHbC9i?=
 =?utf-8?B?RlJzcTR3T2dwdHNwMGdqNDR2M1dzc2hBR0VET2s1YUtNbStVdW4vZW82NVZr?=
 =?utf-8?B?VWF2VFpWM2VQOVdldHhRK1dGQUdhb2JlbGhoNTVrUnpSREcrMkJHZ0d2ZzRo?=
 =?utf-8?B?a2h4blZDdnlaNnp2bk9lK3N5SmQwYkZwL1gwUm4vZXZOS3lsaHMwaU9OdmdC?=
 =?utf-8?B?VHh4TjVqOThiN3hXMzkyRUdRbThzQ1IyVXA5TFd3N1l5bExqMlRxcGRWU0tZ?=
 =?utf-8?B?Q0loUlZ2K2RLSnpVc0YxcHd3Uk5ibTVRZ1hlWGNJdEJ2QTlPUG1tMFBudjVD?=
 =?utf-8?B?bFN2VldZVWZ5cENvRnZ0S2FvbE1wcER6eHNyWXp2elpMb1h3QlVOeExBUTI3?=
 =?utf-8?B?UXRBNnduang0bHQxYm52WFJSd1FoRTBHZ2tWZGNmekpjN1ZyME4xZmJIOWNG?=
 =?utf-8?B?cDF1OXB0eENlQ0pCUTVZVEpVa05zY2d4UWtYd2N0UUNQd2kxR2lrMkQ5VGM4?=
 =?utf-8?B?VzhjUGtmVm5pMzU1S2RZUklJWTFMZzVSSVo0VCtYcDgvYmp2RFZEQWdMSjlU?=
 =?utf-8?B?Yzh1WUN6UzhIVTFOUnRUSUlMZVlKVmRieEFnd01RMjRUMHRWRXZOeE1aV0Fw?=
 =?utf-8?B?ZTFsbkdhMC8yT0gwYTl4WEd4WUpJYS9QUjNtbDB6dzJhMGVvbkptcWczTENJ?=
 =?utf-8?B?ZzljTEI3NmNIeTIrbWpvZVRUNHRDcWR2UkFkd0xzTTRJYnM3aFRMa0NsVXV2?=
 =?utf-8?B?bERISG1IRHpoSEl2VGZLUTM4ZVRic2dsRGF0RFZJREhhSWxFV2p3dkVqM2hw?=
 =?utf-8?B?Ym9ldk1GNlJNU0U1ZTFTL1lYYmtXa2JPQVZXTWp4Rk01OURBd2ZPWHc4d0N2?=
 =?utf-8?B?dkx4d1d5S2RhZTY0dENleGppR25EM2ZmODluTCtURUpHSnhBNlhrYzJBMHA5?=
 =?utf-8?B?bzJXdzBMNWMrWS9qWmZhaURZTHhtMEVRb2NIVGVWVjRmWXlhWmhEbkk1VGZT?=
 =?utf-8?B?NXppQ3NBSU51WUVZU3lqdndDVi9IQkhSUnZzQjJsSzFFZWhySVI1dnhJT3B0?=
 =?utf-8?B?aTl0OXk5M1BVWkRDSVN4anZrU2dFVmI5UkNoNU1SRWtQV3ZXelRZK3FKcVIz?=
 =?utf-8?B?VFQ2Y1Q3ZStqQkdrbUFnbjZLSXRNcVdDSjRUdmM2a3d5YWdSZ01TRFlvemRQ?=
 =?utf-8?B?alZIeXR5MXk0K3ZHM080TkpMRXZrc3d4cGpBV2s2WEcreE5LaTRybThPZGNR?=
 =?utf-8?B?dGlnckxEY3Y4ZitLMzJDK2VlODhtK3MvalZmMkt2L0JsMXRKTkE4bVNMV3I4?=
 =?utf-8?B?UXk5NEpIUkxQNzZIV1lVZmphOFNTUmZVMUpzUzROV3BsY21mbmdub2MxNHhH?=
 =?utf-8?B?UDRDR0VnekVROThnRnNkRlhYcXJIVXNmYTVNd043czE4c0RPemtCNllMVEky?=
 =?utf-8?B?aHAzSDV3ZzA4Y3Y1M2ZvQ1kvVnFYUXVOcmZjTlYyUnlwaGhmdWpzRm5xd3dV?=
 =?utf-8?B?WHY4dGZuKzQyZ3R4UlNRdGJ0UktWaXFSUDhBV0VHTVVqWGR2RjRJcElibkFj?=
 =?utf-8?B?V3g4Q1lYZWZCaW1lRElIZnNDYzhBM1AxVXRlQUdRMDVlUVQvS2lqQkl3dnR2?=
 =?utf-8?B?NWhTVFEydWlidGZoak9zaXloVmdyd21BZndPN094ZEt6b1NYd3VBL1l4QnJJ?=
 =?utf-8?B?di9ZS3dHaGZ2U1c0Ynp2ZVhvejF0eHNlWCtNOFpPS1N6UkJGOUw4VEoza08z?=
 =?utf-8?B?K2NlR09pVFlsSDhXMm1lYk0vZWZwWDQrNU9ZOFMwTzZ5OEN6TVRTL05VckRB?=
 =?utf-8?B?SDNkZ1NFdnlpNG5tbXg1RUFlZXkwd1NVMjJVYjhFUGNNNzdQaVhLWncxUnJm?=
 =?utf-8?B?WWl0K2owdTIrZm5qYXlyWG1JZzVpZ25DWFEzNlVWYTVZMGdZMC9JS2Y0MUtF?=
 =?utf-8?B?cEM4a1krL05jQW9MK2ltRUVnMWw4Rm5IKzZHb3FGNThwR0hkL2dwQ1hOZGth?=
 =?utf-8?B?aE8xeWZSWVYzYnpMbVVjTWxWQ2dpbXVsNW45TWlacUMrclp6QjlBR0NmL3M0?=
 =?utf-8?B?THdscHZqRjVGcEd3WVJNN1NYeENGQTFNNXF5U1NFM1RsRmJmUUJPNlBpeTRQ?=
 =?utf-8?Q?339FTFenu56b8Ph5PxihrJ761?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e3edc43d-1a57-4eb7-fee2-08dd5a3540e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 09:24:52.4509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJhnxVkhC9kcoSWkn424mGsTPZNkcK5JKw8wnEXmA/ViGckLYpcten604qFRAiWf7qdPd134nk1aOeiidUmZmbLzqkKXK1IaBvntRvKnBgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10289

SGkgTHVpeiwNCg0KVGhhbmsgeW91IGZvciByZXZpZXdpbmcgdGhlIHBhdGNoLg0KDQo+ID4gQEAg
LTExOTcsNiArMTIwOSwzOCBAQCBzdGF0aWMgaW50IG54cF9zZXRfaW5kX3Jlc2V0KHN0cnVjdCBo
Y2lfZGV2DQo+ICpoZGV2LCB2b2lkICpkYXRhKQ0KPiA+ICAgICAgICAgcmV0dXJuIGhjaV9yZWN2
X2ZyYW1lKGhkZXYsIHNrYik7ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBueHBfc2V0X2JkYWRk
cihzdHJ1Y3QgaGNpX2RldiAqaGRldiwgY29uc3QgYmRhZGRyX3QNCj4gPiArKmJkYWRkcikgew0K
PiA+ICsgICAgICAgdW5pb24gbnhwX3NldF9iZF9hZGRyX3BheWxvYWQgcGNtZDsNCj4gPiArICAg
ICAgIHN0cnVjdCBza19idWZmICpza2I7DQo+ID4gKyAgICAgICBpbnQgZXJyOw0KPiA+ICsNCj4g
PiArICAgICAgIHBjbWQuZGF0YS5wYXJhbV9pZCA9IDB4ZmU7DQo+ID4gKyAgICAgICBwY21kLmRh
dGEucGFyYW1fbGVuID0gNjsNCj4gPiArICAgICAgIG1lbWNweShwY21kLmRhdGEucGFyYW0sIGJk
YWRkciwgNik7DQo+ID4gKw0KPiA+ICsgICAgICAgLyogQkQgYWRkcmVzcyBjYW4gYmUgYXNzaWdu
ZWQgb25seSBhZnRlciBmaXJzdCByZXNldCBjb21tYW5kLiAqLw0KPiA+ICsgICAgICAgc2tiID0g
X19oY2lfY21kX3N5bmMoaGRldiwgSENJX09QX1JFU0VULCAwLCBOVUxMLA0KPiBIQ0lfSU5JVF9U
SU1FT1VUKTsNCj4gPiArICAgICAgIGlmIChJU19FUlIoc2tiKSkgew0KPiA+ICsgICAgICAgICAg
ICAgICBlcnIgPSBQVFJfRVJSKHNrYik7DQo+ID4gKyAgICAgICAgICAgICAgIGJ0X2Rldl9lcnIo
aGRldiwgIlJlc2V0IGJlZm9yZSBzZXR0aW5nIGxvY2FsLWJkLWFkZHIgZmFpbGVkICglbGQpIiwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICBQVFJfRVJSKHNrYikpOw0KPiA+ICsgICAg
ICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsgICAgICAga2ZyZWVf
c2tiKHNrYik7DQo+IA0KPiBJZiB5b3UgZG9uJ3QgY2FyZSBhYm91dCB0aGUgcmVzcG9uc2UsIGp1
c3QgdGhlIHN0YXR1cywgaXQgaXMgcHJvYmFibHkgYmV0dGVyIHRvDQo+IHVzZSBfX2hjaV9jbWRf
c3luY19zdGF0dXMsIGFsc28gc2luY2UgdGhlIGhkZXYtPnNldF9iZGFkZHIgY29tZXMgYWZ0ZXIN
Cj4gaGRldi0+c2V0dXAgZG9lc24ndCB0aGUgbGF0ZXIgZG8gcGVyZm9ybSBhIHJlc2V0IGFueXdh
eT8NCj4gSWYgeW91IGVuZCB1cCB3aXRoIDIgcmVzZXRzIGluIGEgcm93IGl0IHByb2JsZW1zIG1l
YW5zIHlvdSBkb24ndCBuZWVkIHRvDQo+IHJlc2V0IGFnYWluLg0KDQpIZGV2LT5zZXRfYmRhZGRy
IGNvbWVzIGFmdGVyIGhkZXYtPnNldHVwLCBidXQgY29tZXMgYmVmb3JlIHRoZSBmaXJzdCBIQ0kg
UkVTRVQuDQoNCldpdGggdGhpcyBwYXRjaCwgaWYgRGV2aWNlIFRyZWUgaGFzIGEgbG9jYWwtYmQt
YWRkciBwcm9wZXJ0eSwgaGRldi0+c2V0X2JkYWRkciB3aWxsIHNlbmQgSENJIFJFU0VULCBmb2xs
b3dlZCBieSAzZjIyIGNvbW1hbmQsIGFuZCB0aGVuIEhDSSBSRVNFVCBhZ2FpbiBkdXJpbmcgaW5p
dGlhbGl6YXRpb24sIGFsb25nIHdpdGggUkVBRCBMT0NBTCBGRUFUVVJFUywgUkVBRCBMT0NBTCBW
RVJTSU9OIGFuZCBSRUFEIEJEIEFERFIuIA0KDQpXaXRob3V0IGxvY2FsLWJkLWFkZHIgRFQgcHJv
cGVydHksIGhkZXYtPnNldF9iZGFkZHIgd2lsbCBiZSBza2lwcGVkIGFuZCBvbmx5IG9uZSBIQ0kg
UkVTRVQgd2lsbCBiZSBzZW50Lg0KPiANCj4gPiArDQo+ID4gKyAgICAgICBza2IgPSBfX2hjaV9j
bWRfc3luYyhoZGV2LCBIQ0lfTlhQX1NFVF9CRF9BRERSLCBzaXplb2YocGNtZCksDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBwY21kLmJ1ZiwgSENJX0NNRF9USU1FT1VUKTsNCj4g
DQo+IERpdHRvLg0KPiANCj4gPiArICAgICAgIGlmIChJU19FUlIoc2tiKSkgew0KPiA+ICsgICAg
ICAgICAgICAgICBlcnIgPSBQVFJfRVJSKHNrYik7DQo+ID4gKyAgICAgICAgICAgICAgIGJ0X2Rl
dl9lcnIoaGRldiwgIkNoYW5naW5nIGRldmljZSBhZGRyZXNzIGZhaWxlZCAoJWQpIiwgZXJyKTsN
Cj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4gPiArICAgICAgIH0NCj4gPiArICAg
ICAgIGtmcmVlX3NrYihza2IpOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9
DQo+ID4gKw0KPiA+ICAvKiBOWFAgcHJvdG9jb2wgKi8NCg0KVGhhbmtzLA0KTmVlcmFqDQo=
