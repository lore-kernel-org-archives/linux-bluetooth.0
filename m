Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D202E62B4;
	Fri,  4 Apr 2025 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743734440; cv=fail; b=uEJ/MH8ih4fNnjVc0JtKow+JlopNMWU/46nz8WqV/6MxiX7EQKuCopG3KahkxBzsp1TCMbwE39j1aM5Zh3oXfZ88cyy920iD8w5EB7S+P5QG/08viCSxnzQ3sJ2bUE9dnxd2X5ZFqY8m8noUTjFilumJSzWLp9sfvGQ3u9DB0mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743734440; c=relaxed/simple;
	bh=o3s4xTH21e0Fn6KRHaZjF+D9i1MKV4LudkAWtbJ43ig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JeAYmkXu2eSP3NdFlTMc32tEV2RyyFTiXUljTRuaKjb2PEl6BpG9ACqcEus2qK+NK6cqHiW/pkXLfMrY45ofjubHHibAJWJ64vFtbOAdlw5zZ4S1mjdeVSO2DDEyP50EWcZ4ailtwmwX3sR2PtkxhEJ4SlVn0lW3cD427BAHgj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bEqKgAvG; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bEqKgAvG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvsqscHyBzqvaqbvNDf8KYUXoDcipU8w/7Y1eZiHF+PMbPQmuPOP0SOjOfMHppmLa+tkzu030nEHSP/BDeNO/iS/BXZ1SLfknnXrjFFpPrC6JLYN4bGg+ZZc8jWjEj+C2ctOyR14RaknI7SIjSs1c6wGNjPf2QsxI24LRBAPazxDxN3gZQY0Z8MwYk8iMrvPcmmycZDZJljtzFZoLB2mBgReeaTg2c1MhbbQIhgOpXJGsLRXwbGjB+G2CliGqXfY/JPKL97Bm+ehTuhuWbCpu9N9YLnbS5hcTvirc2fBIjL+WgSwAsCmuEeEZhrYNahXYUJyc7wa4A66GiioMniePQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWgpxp4qQ3Q+zg5JoSx0L9q8PUpscpRshuCxFVTMg4k=;
 b=aUMz2w2LO8s/Dhh1fpgtQXVCyIzVaOAEGUzECAKc+ECKFJD+oCkP+m8TusVky/ED2ctaSAXzYPmVA1Zn7w1PQq7K8b3JvyduIzAxoKnfDCHwDXxGHRUliYndEjsW3d+Pmjy8VQWsY5FQcDsTfDBXxjzHa8ueND+F63CzCJZOibTBeBJS5847K/dRqGo4ptK8rrDDGZ8CuzB1DsYj5oVlKmIFMNU3Z20Toa9xj9ekaChXXN/9Rx1fuKZ8qkn7PUEfFFlvdxJ7I1aQdWv1bNySC/RyfRVSAWGdWnrIhyiFEbkkQzDZiaQ1Lc6d7eBt3Al2IkgtLL2Az9yXkjoz44mNmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWgpxp4qQ3Q+zg5JoSx0L9q8PUpscpRshuCxFVTMg4k=;
 b=bEqKgAvGFsdLYQ9P49Myrgg/9m5o7mneGRpiIp1fV8dDZNeb1ULpA1qSEhgPZsJMYtbnSGzvjsT8gVmdkgdDmZiLt9Rv5BNlU8TfffQRCIXOI1EMcqyZYLhaGLnkkpc26cf9dptp7DO4JWWgQvm9BLnCFzD5G8prI+sq47rkIbZeisMAjZDoRqN48AHTkjmGXOQuuQIFYt85c7jo5txgW6LPdX4P1P64lmpxfU8lJ5qn1iUIqXIZKcGBKAKGA78hA8o+O1Uox3f5OUEafDx3Uy8p7hWBHJQaGtU+wXHymWc3c9mzgzNsCXY3bZygva1fE2egbM+NVD/4QnOw0pDZfg==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM9PR04MB8210.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Fri, 4 Apr
 2025 02:40:35 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8583.041; Fri, 4 Apr 2025
 02:40:35 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: "patchwork-bot+bluetooth@kernel.org" <patchwork-bot+bluetooth@kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: btnxpuart: Add msleep() after changing
 the baudrate
Thread-Topic: [PATCH v1 1/2] Bluetooth: btnxpuart: Add msleep() after changing
 the baudrate
Thread-Index: AQHbpQrxvKzeDbjtU0ORz5T3W0Sixw==
Date: Fri, 4 Apr 2025 02:40:35 +0000
Message-ID:
 <AS4PR04MB969280C43E48134AD6D1F73FE7A92@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250327182523.524534-1-neeraj.sanjaykale@nxp.com>
 <174371163549.2672071.11589670566595157295.git-patchwork-notify@kernel.org>
In-Reply-To:
 <174371163549.2672071.11589670566595157295.git-patchwork-notify@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AM9PR04MB8210:EE_
x-ms-office365-filtering-correlation-id: 364f479d-047d-472a-b73a-08dd732213c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hle3TdHQIws5UxnjgAQy7GfKHUGznoiFjSSoD9VM5NjkNjfxLDdhiMah3nv5?=
 =?us-ascii?Q?AID3wSxuPwyVeYgZihZBUBdlzkqysvufg5sTj23LEUvM73nGe+06xJK0/0Er?=
 =?us-ascii?Q?5GjRo1D4ISyuSS8Q1wgd1FGbuS54v/q3PdugXYLy7zXw/TZlZqBEMXk5W1Ut?=
 =?us-ascii?Q?tTns8tAORHcPqxiNIZaylZ8c9QsGY228U9yguQOJC6IirYdSLuJLiHB3CBfO?=
 =?us-ascii?Q?Nw34v8m/zvkjUcjEwxAoZS+k3qvamFRmxEldYRmN+/eAr38IFzj4/3mHJNUI?=
 =?us-ascii?Q?FFBiVgHTZ06/sxMek+X8hnQuPkUfvHSIbbooxZPjLze+SbJP4Z8XQxMdxAfH?=
 =?us-ascii?Q?pKPKRy/t+6fJY6CS36r2gObtj9Gh4Q7+vLHlfgFTVs+SY2251OxmdMb1ZCcu?=
 =?us-ascii?Q?+lrifuRoSqJ2/9TgqnlkO7cQXttup+yAKlv/Qg4k0UUNSdHUMBIoDHTLAGDK?=
 =?us-ascii?Q?ReiMg7NtfL8L+2mdDjWlk4PvGhcgo52KmE9dytJlkXxZJuIIQfHKuCQTzLI8?=
 =?us-ascii?Q?DxF5WGSpsJXPLrywwVvmTD6T/31D5OoAkPvAcWgpgWaFC0H0nSTqfBVqbk8Y?=
 =?us-ascii?Q?qNvh1uVlbmp10q6zbLPQZOoTtbJz4GYH6RU/E4xeBJqa2kteCyUh1LlHfTEe?=
 =?us-ascii?Q?cNpBoWVenk8C6zTBwzUAOte5sdVT1BkH1fkZraskC6UwTNEHYyShgjP0AZDy?=
 =?us-ascii?Q?4v3tVQM64jwK0eIEm8LYW+74QaVge9dg1AJPG485wVj4KDpqFwURUlgIIcoS?=
 =?us-ascii?Q?XPb9uDviMMaeWljrlp3mHIagtkvbRJLJjPzZvKhBJkJp345IOU862OPI77F+?=
 =?us-ascii?Q?DpM2adiwiimFFuqYGh6+DK4PpWvNR/DlJAYpWfTvQJGxZfxXw4PUTvdd3Njx?=
 =?us-ascii?Q?xo+CK5oYmuPuc3mTa/QUmYFL3LAe4ojAaMXganp6RWmU08r5lPlqZ+ghTx7d?=
 =?us-ascii?Q?9d4er37tZImiSmsmFrm/jsDZ8xM0R+rJ7GBg7dAJL9my/OKNQ13Gg15gyfvY?=
 =?us-ascii?Q?xIPlJZTzMJFBPktxD2+XrytBM1AIx2nL0lrAgIkICLJcfejd+Y1WlXwuJPD1?=
 =?us-ascii?Q?4ywWGS7jitZ0XyPj6IpWO7y4pizpeM7VhZs5sy1V+JmoTdUoDUuCwyTmBEf2?=
 =?us-ascii?Q?YcF3jATijo6I1+EQUOLxl7RlT+M2bWWaCCcgOODxSVQdfEtu2+aXrjdR04ST?=
 =?us-ascii?Q?KKeVYuZQipvP+JNFiT50CFkMCjN5G2y+nbWuQi4+Gogx3Thz3iR3N12w9eFb?=
 =?us-ascii?Q?xrzWWETWcNd4eimpY/fRR2XED6cG1fS7sNs/RQX9QcIvRPiG5+DLVMAZPvFe?=
 =?us-ascii?Q?UjRK6XZBQbbi0ZrBqTDkxeVEijrl0fY6ZEduzZC01M+PwQSmN3nJXZideBu9?=
 =?us-ascii?Q?ZmtsjGH34UfN0eXBgWJxNIXnk37m?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uImUA6nnVBQ3MJoLTrWJgcyYJYZNwZwjP0zBAJgelSMmU7uCzP9AcVmRlAIo?=
 =?us-ascii?Q?GINx4NgUQapwAJuGbzOXOX5o4eOmiiwyAMO4q6aFnZw2Zz3pzCvlyRBXOzdw?=
 =?us-ascii?Q?gUSEMeaqijvPqxDBgTbclG5F8IMHmRzSj4in4VnbwlORxys9rpu3FYVNgjLX?=
 =?us-ascii?Q?I0H8FDD5pszB96gYMc1Kz7dHrmwvCUKGReLl8C1/GEFubFjz7NqxC1b59uQI?=
 =?us-ascii?Q?sMcwqd6r9S/BClKL4nl3wiUTp9rmLXtxwDphSYkvxpa0u+9WZtn2aB9r8OP1?=
 =?us-ascii?Q?WR8WH1LDjaKkyBRRiWhp8iCUIhBzdRM8w8EPmenf0wqrk6mFmdmax0M2y9Uc?=
 =?us-ascii?Q?RcUBKDVMRSWU5X0zajCT9JooEEP/8PXBtZu3NSJWVigzVwzKeNlRtkOKJBEd?=
 =?us-ascii?Q?CS3FwkO6lrNPnJW9qQdyn7npgzD7WLw0mvEq9isSbaN/S27X0PMO5/iL4Aml?=
 =?us-ascii?Q?pHKJG8pQoLYTEKwGEe9iutkyduBTMWz2zW3oxu3QiVBhvE7iXfw0xVFtHXpd?=
 =?us-ascii?Q?CPIEsYzvlwfw8h8zEHnAa9MgkayPCrdZeBwuP8xC6JwYI+68Mmwl1Ex3XCyh?=
 =?us-ascii?Q?FLrtPwlgCI1xOtaIMRVgmNz5iSMuyAit3NUAKM7GYIDj7UNijxaqmaHKAsnU?=
 =?us-ascii?Q?+U6KUBCkvtyneiRjC2n48lEH3JbHL1UMz8D8OHIjy6xhhLrOMMQOeuzBbRmA?=
 =?us-ascii?Q?6FJH4kxdeHA6m7EZoZYdnBbj3Zji8SbS29YwvUKmRNlnR5QugPbE+4597xbC?=
 =?us-ascii?Q?6T/az+KKzExNeXPlHA6SmmgsnKzEWcIkrVOB+YjXGJ21ZNneRTYf7m4ijcpZ?=
 =?us-ascii?Q?eJIU0Oro1PaqTE6chtz9WAC+cXp2HGMi3nEfPli/BIIR27gBxCGUg4WZTxP+?=
 =?us-ascii?Q?iNyVVMaSYBH/SpY4q1Fm1KoNHy79fl2FUdADObzom8x4zLdLB3Jq53Gfb+5b?=
 =?us-ascii?Q?T2mxXwo9aIt5HwmE95zo6bXo/M9Pz3hHiqGHK8xobNCaqwq9w3TC0mgk79BM?=
 =?us-ascii?Q?GZ33hIph5jstR2VZ1cb+r3fsDLVz9VtQtktrwsIVM/Dj1uflsRBI3X8Sv2xI?=
 =?us-ascii?Q?fJXBrouSUHsHiSo4Vl+Flg38oVuUa/qHK+mmu03jvNshAlaO591BzgDq2u6u?=
 =?us-ascii?Q?5EsJWaFQr1QRghgYaIC6Q6O8py0ff1r7f/kI7Yhell5vINAzoVPrwwXZXrEY?=
 =?us-ascii?Q?yrJnSwi1MxQE7CLp34yhIyox/ZRbCDbWQKvXCLHSdqhUNGaag4A0KIXfAWd/?=
 =?us-ascii?Q?xG9ZbFgE6UG7YcRIflQsQGF4Buy0sSyx3cZ3jbNqFtjGeWsLVMPIvquo9jTm?=
 =?us-ascii?Q?nRHefZ7AgmUwfXKDVeXEsKcqS8Qsr3unsxkEVdGNdvVXBgN5Qb5lYbNB8fXw?=
 =?us-ascii?Q?xj7WaQbn3V+Ovk/NHBR19P0DSCtmgTMXcYybmjzP+Zs/4yF2syWF02wnGvC7?=
 =?us-ascii?Q?7mKFQqiOnG5blMRv5kjV/qRta3dhKL0wwde17NbBlxLoMMSczEc57p4DJ4+e?=
 =?us-ascii?Q?W/Y1NnGkDS6WCxOpXip+UF2TDTbl1lVpkioh/OSchN4ToW9fgKqz/caCPSbr?=
 =?us-ascii?Q?nvDHQExgiNgXYJd6tT1apdd057J9cftpuLso/M54?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364f479d-047d-472a-b73a-08dd732213c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 02:40:35.4201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++v1+DBBfFXQE5lBQuHYsEaIDp4DRLAJCvqjmGIrHf1UBFgc5daqQEaMD6te36NN9QJzRY46bxwqrfWJlNTo4kBJMyDlbqRr1ESS/w/50FI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8210

Hi Luiz,

Please do not merge this patch series.

I have sent out 2 different patches instead titled:
1) [PATCH v2] Bluetooth: btnxpuart: Add an error message if FW dump trigger=
 fails
2) [PATCH v1] Bluetooth: btnxpuart: Revert baudrate change in nxp_shutdown

Thanks,
Neeraj


>
> Hello:
>
> This series was applied to bluetooth/bluetooth-next.git (master) by Luiz
> Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Thu, 27 Mar 2025 23:55:22 +0530 you wrote:
> > This adds a 100 millisec sleep after change baudrate vendor command.
> >
> > It is observed that when the baudrate change command changes the
> > baudrate from 3000000 to 115200, any immediate HCI command returns an
> > error -22 (Device Busy).
> >
> > Adding a small delay after the change baudrate command complete event
> > is received helps fix the issue.
> >
> > [...]
>
> Here is the summary with links:
>   - [v1,1/2] Bluetooth: btnxpuart: Add msleep() after changing the baudra=
te
>     (no matching commit)
>   - [v1,2/2] Bluetooth: btnxpuart: Add an error message if FW dump trigge=
r
> fails
>
> https://git.kern/
> el.org%2Fbluetooth%2Fbluetooth-
> next%2Fc%2F061e4972c48c&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.co
> m%7C08b8a55d25e04b812fd008dd72ecea34%7C686ea1d3bc2b4c6fa92cd99c
> 5c301635%7C0%7C0%7C638793084075362630%7CUnknown%7CTWFpbGZsb
> 3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF
> OIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D8u4Uw6T820eP6
> mAFNCXU1xuUFpXYUB32nrYKuj8th%2BQ%3D&reserved=3D0
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.do/
> cs.kernel.org%2Fpatchwork%2Fpwbot.html&data=3D05%7C02%7Cneeraj.sanjay
> kale%40nxp.com%7C08b8a55d25e04b812fd008dd72ecea34%7C686ea1d3bc2
> b4c6fa92cd99c5c301635%7C0%7C0%7C638793084075397504%7CUnknown%
> 7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOi
> JXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dth
> Hgu6Dw8RWjMWGzjv7C%2F4JPJzBwwC7RzDUmor8bq4M%3D&reserved=3D0
>

