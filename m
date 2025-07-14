Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666B83D76;
	Mon, 14 Jul 2025 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752479304; cv=fail; b=AHvCHIbO22WPnw1xZcxcIS0eODJRAtoB3WIJv8mFvu6jtgKK1HUI7h0OPQ1xqeF75sw2pQYAvTgpBDm5Q618QYzrs5Co7TIJ+TLFq23ppdx85kcZ4c1EyBWc6MxFPPi54Wrv2M7kbS2s0W+kCFDjBp5NFVIEc0CtlceF5RMxeUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752479304; c=relaxed/simple;
	bh=3xIRtyuFnyDKlMk7g+pMEQc5fCz3NUanplr8wgFmcsM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=l20gmL/0JnIe2E7vhad1PcYezLrYSk3iX59alj0oiGaYTmTe47k/UxVbZhUiushf92yg+YRJUWAEbRWkKHcfB2fxZllhv7mizSbrYYBhUBmsi0RLE3MeRV6jupeWbwveSAQjve7rJRShkAzQxYWvGTRSgfolxcrhoZ9zqA4Vjrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VsJ/519f; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VsJ/519f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WU80B6x/KF96Hk/4ZwZfdYrpfs/urS5fNNdy7H9kLbARP6Ki6QYNRWg4Cw61KMIonCGYmuY7j7NwLucrmxUxEqJdUIAo1e0k5SdZQzO5xfyLeiJh5w2evY6XvXIspXtA7RyGF/I8GsWt4t0ay+Js2ytGgtlzUCZ6zuEDEJ+bUmW8bl/YpntbFdywOCbfLoag0zUuyy6W81sl7nTyUPRq0svu1R1z3pu5oVFLVS9KTeW4qX/JQxPhYVc0N5VMWsTpgqOPVjt1iz4yd+wVZWh+Sp8mSmIHMpGmqM2EAwUTJZX7M6sHiXBHsSHt1VqfhQymzDHtH1TEcGEDb3iGTb7Cgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAf0STOMY691vxgphBERkNuLPZpY8Tmq8pO4pFi/YgI=;
 b=xthe5Qf4U2qi8AgN0SZkRHK309utjmNt0R2isrdxiHEef6CHFp0FLr5ufdbNtD4Mj5VRhgqiXDAUwnw9JBe03fog5th8LTR9ljLVQ/SYguwKqlAzQBTSZgcfrdINGIBIByOUzq/xQoT1Q4QUnIRlfp+NLsXuITm2hxo3Y0bPa3Q2h7Ptall/VBabyOYlpIpIP8it+PRv6j8Jhh+pw7OpX8ap7fnC185Hoaz1jNZ8Mos65HVAgZ0VfcQrckuOIwm84ZBpZ9/HRpD9Z7symRLhENfkDPLBvofsz6LGAuK+qQjw355qFR0aluV6W8WxdBQljZj/dxzA94m31ZbzAfKcIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAf0STOMY691vxgphBERkNuLPZpY8Tmq8pO4pFi/YgI=;
 b=VsJ/519fJLrqlJUVjsykHmnyGNUxyVysyVdXERuTY7bPxP+ZwjcJVWKaUWXuMnL8ukL1QEhPnY0MIq/RGZfwjrp+kw7J96Zc1QJfdhFqJkBLVDIRwtWCz63lX9BE5voA/7OWH3wRkwFqqKfbqzhe9uK57ywtNS124ux5Idf4W2EqZh4rgFAZXNspXk9kycBNKtIKA3DNlQ1/o+58M12sQiZtn/OgA7OvQBwK4i5T/cXJc+R3jkvajWdrKioCZuV1IigB45O6NXf06kGtR3xmJnyKl48AG6ZZr1BXG5J/yN8BUaHJQhyPoprY7Iq1P96kPT/j2yKWHKmHWdpRWCprEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by VI0PR04MB10496.eurprd04.prod.outlook.com (2603:10a6:800:21a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 07:48:19 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 07:48:18 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	manjeet.gupta@nxp.com,
	jean-yves.salaun@nxp.com
Subject: [PATCH v1 1/2] Bluetooth: btnxpuart: Correct the Independent Reset handling after FW dump
Date: Mon, 14 Jul 2025 13:00:15 +0530
Message-Id: <20250714073016.1703837-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::10) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|VI0PR04MB10496:EE_
X-MS-Office365-Filtering-Correlation-Id: 07982309-1757-4011-b1cc-08ddc2aacc43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZCtOci84RlMxbmRLVEZtRGZXci94aHhaOEE4RW9OUzdFUitqU1R6WVZWS2FV?=
 =?utf-8?B?ZVVvVTZZR3E1QmM5VEhzTDhLYll0dGZTWHFuTmk2YWFqajVMTVljKzAxT1g0?=
 =?utf-8?B?c2M5RzJ3SmtNbXNyeEVDaUNpRzRlcEhTQ01ZdHRQWElaZVNKM1AwY0pzcHlq?=
 =?utf-8?B?bHQ4dmhVWFBHVGNlRGxKUnpTODBabTg1bnpaWFJaSUpPdkZYejRtNWk0SFQv?=
 =?utf-8?B?akk5ZW1sZ2hWaHNJMW1aR1Zzb0hWTFRwM2xXV1pxQlJRaWNIQlYzeDM2Y3kx?=
 =?utf-8?B?RzJDYk1BdFhNR2lEaDJHRENrWGdUYW5tNGZBWElYa012dzJhTlFFUHFNaXB6?=
 =?utf-8?B?eUtTcWpxWG9mNGljS2k4RWhXMDdHUHliNkJqeWhPRjFudFdqVW9FbFY4aEJL?=
 =?utf-8?B?VFhoeU5kQXl2S1dQRHo3bFNnU3I5Qms0NUVOR1MvWVFrRlFibFE1UzZrMGs2?=
 =?utf-8?B?K0dsTzVyRzhSTDZjdHRydjUyODZnM0d2eFIyYS9vc3pLQTRTV0REbXRvWG5L?=
 =?utf-8?B?K1pycDhTeEY3bWNLQ0l3QVBmejFjYi91OFhPZDJ6eW9nKy9WaEtzNWpPNmtr?=
 =?utf-8?B?Z25jQVBYNU1mNzUzRy9Ba2taSEdMS3UvdFIvNFJHU2pqTUVwWVJIdHVvMDBz?=
 =?utf-8?B?dHBlQ0o3dUxaekM1QVJsQkRuZTJ5M2ZueGo4Z1FrNllGQ1ZkUmZrdHludjJx?=
 =?utf-8?B?c2swQnpXUVpZYXNQWHBJVzU2S1hCd3I5ZWozS2lyWE4xeTBjQ1hxTXNlMTN2?=
 =?utf-8?B?d3UwRG0ydjR3c3FSeGQ3ekgwYm9NcDhHV1BuUVVtbDcvWXhMZ1pFNjVXNGlM?=
 =?utf-8?B?UDV4MUtRakxSOVZQSTc0NDVRbVZMZG1CZTd3RHB4MFdsczEwajZMOEpHUUJE?=
 =?utf-8?B?djJnVGdpTm1uWUd6dFZETkNhTjFqeFRybWxuK1FEbHV3cDVwa3FPSmVJRjFM?=
 =?utf-8?B?TjJxa3M4d2IxdXRmOTJoZWF0L3lYRDQrdDl5WmZKQk13MC9pOTIrdTUwY0JN?=
 =?utf-8?B?bVNlRzEzTUx3d1JMUnJ3bkVuUDF6NlpPdzJPUmxlbVNna2Q5blRyVjRaZzN4?=
 =?utf-8?B?anZGTHIzY1k5YnpTSVlyUE9NMi9DYVJtVU8xSVNrczhUUzVDNVY1bXY5UmY0?=
 =?utf-8?B?L1RVSm5rYmtwdmhlaTQ3UGRTTFhVUGk1RGxsS2hWRmtYYVAvR081SG5kN0N6?=
 =?utf-8?B?VURPSFVZNGo0eDlFSEVJVktadTAyQTdlM2hBUnhweUZqSDM1M3NUN3lmcFBV?=
 =?utf-8?B?TWlkV2pRQnk1Nnc3VjdJcHZhSnNlZWZkOE8zK3FxMVphb2NhR0lnNkMvTTRI?=
 =?utf-8?B?STdQc0FXZURlTVIwUzJjQmllZ0pCdy82aHplYmRJSDJnTzhlcGE4TEZWS0tu?=
 =?utf-8?B?LzlsQnJGSWI3WTRST1NCZFJFUEhWZXM1Qk90c2V6QWdjSGxkbDJFTEpIVy95?=
 =?utf-8?B?bVRiNUYvREVleDhqMVcydS94M0hhTkZJbUpnZUpoMUZDSkNLZmduWS9MTTBG?=
 =?utf-8?B?MmdyN1dTamgybFVzd29NWk92aURMeW52RVhnRGpHY2hhRE5mV2xPMW9QcjlO?=
 =?utf-8?B?dTlsWFBPODZhZHRqZXI3Zi9xek9mblhvblQzdW0xQnlZMFBscjBpeFp6UTFz?=
 =?utf-8?B?OUhiME0wSEg0dm85VnUrR1pISTdVZTBmVmRSQ00rNlZad29XQ0w2dXFkQzBB?=
 =?utf-8?B?UVdocDh2T2t4Q0ozSEtUb0RCUU9FQmhzYzBOZEh3clF3cHRkVmVYdm9IL0do?=
 =?utf-8?B?YXljTE5GM0dsK2U5QVlHd2RQdzYzUE5odWxDTGVGM0ZseW1JSFREaThNN0NY?=
 =?utf-8?B?RldPLzUwWE1wRXdldTRrV044VVZPNmowWkZpUC9LcVFUbHZIT3NlSnZZRHYy?=
 =?utf-8?B?bmJsVVo3RlQxeEYrYjY4VWFtZEVOOFhkMVdDS242RkpHT09OVW5tTlZRbWky?=
 =?utf-8?B?TDNwYzhTVjZiV1VVMndiRi82VGlOdUlyZFRBd0tTNU5TVUE4ZlpxdUgycmpD?=
 =?utf-8?B?elRNSEloNERnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHJkYURxN2E2T0JuWHpGaW80RDh1ZC9jd0RjcExBRnFVdkxkV0NnMTh6VThS?=
 =?utf-8?B?b1VNZCtKMWc3aDBCWWdrVkFoZzNoanRnQnZUTDBvSXdPZndxbllTUmc4QThL?=
 =?utf-8?B?bWVZNDQ1dHdpZkNveWNYdGsySHM2RGdCNG9wVHlmbkNpblVKQnJMUjRhUlpP?=
 =?utf-8?B?TTVqVmRaNEtiWHN6WlBjVlVQalBsODlXNWpLZzUrK3cyR3B6RGtQNEs5b1hR?=
 =?utf-8?B?ZXluek9wT1N2Qlk1TUhybGhRUDZXcDRHQ0J6d1QyTE1BVzMrRTIwUTQzbjh4?=
 =?utf-8?B?dXU4bS80QXFTN2s0dDdUTUFrRVlTRllXT0NQZFVJR3N0MXhaQ2ZaNjM5MFZJ?=
 =?utf-8?B?U09BZGR4emV4K1lSaktKUjZhbmF5Qkt1SENNL09TcmIyT2hMcEErRTd1bE8r?=
 =?utf-8?B?ZTg0eUxHcE4rUkFEMGtqUHE5WVFndnBFQ3RTZlFoWUtONnlRRVM1cGxBdDJn?=
 =?utf-8?B?Nm1oRzhrK2FmZFRRaHhTS24ydXh0cnlZQW5PNVB0bVZFa2xsWktwbEx3UVA4?=
 =?utf-8?B?WjBudUdYd3BlUm9Wck5LTFlpODJoSDZacVZlQWlINkE0cXB1WlcrWnlSaFpp?=
 =?utf-8?B?VTc4ejYzTTRhdm1GMGh5QmxsblA0d1lCY1QrekMzRHYvTTM3V0twemlmYnFp?=
 =?utf-8?B?MXBnT2VtdEZZNVF1dDNLd2JyeHZWZkZrSFYvZ1J6eVdocEdsWGxRQkNlekhr?=
 =?utf-8?B?aHdsWTdTS1Z1ZmlncjhJK3QzNHBHV3htbTgwUHE3UjVGY3RuclZxWElXTU1U?=
 =?utf-8?B?VDVGR0lTV0ZvbnZza1cvazFUMXpPdkJSRUoyTlhBZEhVOUdudDErVVk2UGVZ?=
 =?utf-8?B?RTBqWjR1VzY1bi8wUmFkdjBCS3VXRUpBRGhQcDg5aDFGd0dLVFBMM25nT0R3?=
 =?utf-8?B?WWZZQzEva2J0czJ2SHgyclgxbTlJWTh6dDJSYkcrL01RSGpSRC9TSUJCNGY1?=
 =?utf-8?B?TXUxUzBhdmFCRUpwUFp6M2lvckg0VDlJZURlWUN1cExIVkp4YTVSdE1BYW1l?=
 =?utf-8?B?K25pQ0lNWXB1NUlaSTd1Y0lMWUhoRTBYQXdDampId3BBUHB0WFVrOVU0Y3c4?=
 =?utf-8?B?RUxWbkl5L1pBbFZ2cWczbHQvKzVlTWg1dzRIY2ppZ2hIczFqS3VaK0U2cUdU?=
 =?utf-8?B?REVlSmF1K0FObU9GaXBTbTdiREh2WDdhWURXaHQyaEV1MTN2cE9xUWJvUkgx?=
 =?utf-8?B?MllNUmNUdGlBc2FCQnZkdDl1RTFTcnVRaXkwZDFxNDNNYkVqQktmVlJycVFL?=
 =?utf-8?B?bGFTZ2dFbm5HTVRnNGZOWG05cG54QnZ6ZTZOclJuL1lmU0pVT1hHamQ0bSt6?=
 =?utf-8?B?U2FnRjNCdEFoN09VOS83L2R5SGhNSEUvMGc3YjBuaUp3Q1lYSkNJSlZURXYx?=
 =?utf-8?B?bDJ4Undyb2ljeEFtRmRnVCttVzNrc2JLR2VuUEMxUkxaSVlmUHM4bE1saEd6?=
 =?utf-8?B?NVYyRFdXanlLQm9wK3hqcDEvTGl6TkZ2TVdWVHdTK2JEd0VZWnJKL2tVcGt3?=
 =?utf-8?B?MUZhb3hSQjluWFpERm5CV2NrSGMxRmtSYUI1d3pMQ0xtNGR4MnIvRVNKRWhr?=
 =?utf-8?B?SVFRM0NORU9EcnZQWWtMbU1HaUVzQUQwRGZyY3Jlbjl5Qy92L1Z6ZXZyeXha?=
 =?utf-8?B?cGRudHp2WVhqU1krVy91aTE3UEtzWURwRlIvQnd5RUo2WlhnK3p6YVNzRmxP?=
 =?utf-8?B?VWhvZ2VuVDhObVlFcjhrVjdMWDVXSnZqRktOdkZpRHNBbXJ6TDllanNpOTFn?=
 =?utf-8?B?Y2R0TnY5eEZEZC91amtvV2ptWHMrck9saUJQMk1XTFJoMzFaR1lSdkhtbStX?=
 =?utf-8?B?QVNqMVJRL3llYTkwc1pxTUs0NmtHUHFOazFzZUV3NU5vbWlUS3NYVTZZSTdT?=
 =?utf-8?B?cXVEMVhyMWQrcFdkZGVUWFlhZ3FmVzhHTCsxOFhwVllVOWd3Qm4wTWhHWEdi?=
 =?utf-8?B?dmpPeWQvMnN2VGl4RjNuL09CbXdROENTN3lsK2pIcUhLaEhMTWp1dGFrV0hG?=
 =?utf-8?B?YU12LzFYTXlMVzVFaDhGZ2gwdWRWQjd2eWYwc25RUGRpZkhqWjdUR1AvR2JT?=
 =?utf-8?B?dVAvYldGRDVtMFB6UUpkcnJaUDNTSlJ0dG5JSVpsRHRkSnR6aHJxOEhZaHox?=
 =?utf-8?B?Z2RpK3JTeCtHRndOemFjOGFnK3RzSVUvSThwbitPLzlzOEt6WFBvUFhFN3c2?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07982309-1757-4011-b1cc-08ddc2aacc43
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 07:48:18.8347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HmjVK1IrEGlI3yeRvz+RCsBo+WNhYyb8GOoa9fT4rcn4vWXbmahJsxzYkH0hr2ziM/CZ3uBNxN7s6y6tF6RaVVvTfmtGS57omLnjUMcWWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10496

This adds proper handling for the independent reset command sent by the
driver after FW dump is complete.

In normal scenario, the independent reset vendor command gives a success
response before jumping to bootcode.

However, when FW goes in a bad state, and sends out FW dump packets, the
independent reset command does not get any response from the controller.

[  159.807732] Bluetooth: hci0: ==== Start FW dump ===
[  180.759060] Bluetooth: hci0: ==== FW dump complete ===
[  182.779208] Bluetooth: hci0: command 0xfcfc tx timeout
[  183.364974] Bluetooth: hci0: ChipID: 7601, Version: 0
[  183.368490] Bluetooth: hci0: Request Firmware: nxp/uartspi_n61x_v1.bin.se
[  184.679977] Bluetooth: hci0: FW Download Complete: 417064 bytes
[  187.963102] Bluetooth: hci0: Opcode 0x0c03 failed: -110

As a fix for such scenario, the independent reset vendor command is sent
using the __hci_cmd_send() API, which does not expect any response for
vendor commands.

__hci_cmd_send is non blocking, so before the tx_work is scheduled, it
sometimes gets canceled and 3F|FC command is never sent. Adding a small
delay after __hci_cmd_send allows the command to be sent to the
controller.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Tested-by: Jean-Yves Salaün <jean-yves.salaun@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index c56b52bd8d98..f40794be2d89 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -367,17 +367,26 @@ static u8 crc8_table[CRC8_TABLE_SIZE];
 
 static struct sk_buff *nxp_drv_send_cmd(struct hci_dev *hdev, u16 opcode,
 					u32 plen,
-					void *param)
+					void *param,
+					bool resp)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 
 	/* set flag to prevent nxp_enqueue from parsing values from this command and
 	 * calling hci_cmd_sync_queue() again.
 	 */
 	psdata->driver_sent_cmd = true;
-	skb = __hci_cmd_sync(hdev, opcode, plen, param, HCI_CMD_TIMEOUT);
+	if (resp) {
+		skb = __hci_cmd_sync(hdev, opcode, plen, param, HCI_CMD_TIMEOUT);
+	} else {
+		__hci_cmd_send(hdev, opcode, plen, param);
+		/* Allow command to be sent before tx_work is cancelled
+		 * by btnxpuart_flush()
+		 */
+		msleep(20);
+	}
 	psdata->driver_sent_cmd = false;
 
 	return skb;
@@ -597,7 +606,7 @@ static int send_ps_cmd(struct hci_dev *hdev, void *data)
 		pcmd.ps_cmd = BT_PS_DISABLE;
 	pcmd.c2h_ps_interval = __cpu_to_le16(psdata->c2h_ps_interval);
 
-	skb = nxp_drv_send_cmd(hdev, HCI_NXP_AUTO_SLEEP_MODE, sizeof(pcmd), &pcmd);
+	skb = nxp_drv_send_cmd(hdev, HCI_NXP_AUTO_SLEEP_MODE, sizeof(pcmd), &pcmd, true);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Setting Power Save mode failed (%ld)", PTR_ERR(skb));
 		return PTR_ERR(skb);
@@ -646,7 +655,7 @@ static int send_wakeup_method_cmd(struct hci_dev *hdev, void *data)
 		break;
 	}
 
-	skb = nxp_drv_send_cmd(hdev, HCI_NXP_WAKEUP_METHOD, sizeof(pcmd), &pcmd);
+	skb = nxp_drv_send_cmd(hdev, HCI_NXP_WAKEUP_METHOD, sizeof(pcmd), &pcmd, true);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Setting wake-up method failed (%ld)", PTR_ERR(skb));
 		return PTR_ERR(skb);
@@ -1272,7 +1281,7 @@ static int nxp_set_baudrate_cmd(struct hci_dev *hdev, void *data)
 	if (!psdata)
 		return 0;
 
-	skb = nxp_drv_send_cmd(hdev, HCI_NXP_SET_OPER_SPEED, 4, (u8 *)&new_baudrate);
+	skb = nxp_drv_send_cmd(hdev, HCI_NXP_SET_OPER_SPEED, 4, (u8 *)&new_baudrate, true);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Setting baudrate failed (%ld)", PTR_ERR(skb));
 		return PTR_ERR(skb);
@@ -1330,7 +1339,7 @@ static void nxp_coredump(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	u8 pcmd = 2;
 
-	skb = nxp_drv_send_cmd(hdev, HCI_NXP_TRIGGER_DUMP, 1, &pcmd);
+	skb = nxp_drv_send_cmd(hdev, HCI_NXP_TRIGGER_DUMP, 1, &pcmd, true);
 	if (IS_ERR(skb))
 		bt_dev_err(hdev, "Failed to trigger FW Dump. (%ld)", PTR_ERR(skb));
 	else
@@ -1372,7 +1381,6 @@ static int nxp_process_fw_dump(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (buf_len == 0) {
 		bt_dev_warn(hdev, "==== FW dump complete ===");
-		clear_bit(BTNXPUART_FW_DUMP_IN_PROGRESS, &nxpdev->tx_state);
 		hci_devcd_complete(hdev);
 		nxp_set_ind_reset(hdev, NULL);
 	}
@@ -1486,7 +1494,13 @@ static int nxp_shutdown(struct hci_dev *hdev)
 	u8 pcmd = 0;
 
 	if (ind_reset_in_progress(nxpdev)) {
-		skb = nxp_drv_send_cmd(hdev, HCI_NXP_IND_RESET, 1, &pcmd);
+		if (test_and_clear_bit(BTNXPUART_FW_DUMP_IN_PROGRESS,
+				       &nxpdev->tx_state))
+			skb = nxp_drv_send_cmd(hdev, HCI_NXP_IND_RESET, 1,
+					       &pcmd, false);
+		else
+			skb = nxp_drv_send_cmd(hdev, HCI_NXP_IND_RESET, 1,
+					       &pcmd, true);
 		serdev_device_set_flow_control(nxpdev->serdev, false);
 		set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 		/* HCI_NXP_IND_RESET command may not returns any response */
-- 
2.34.1

