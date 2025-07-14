Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B15234984;
	Mon, 14 Jul 2025 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752479307; cv=fail; b=cAj/xN4k3RKmQUyCPemmWIzpTuJ2zg1/79XYvUTY5BtIAtDslEl524pBdCMKn3ml1SoNuPPjEyrnTs3gX2iJagPlEXWpUo6PXvTUxCCnfpnTf28EWD79VzXLUBae3QWGVwRZUEiDgjapMSvV9Owqn+5Z6XnDqDVqwlP4aCo25kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752479307; c=relaxed/simple;
	bh=8lns0L44Y9UYBkaqbdM4V8uBtBjVNWBZ8yOOLAfNmGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hmBFLoRSMbFlSSHKrTO5btshG3tvQV8e48rB2b31OGAaQToNfLXHhm2Qh00Qtc8tl2aPog2zFeATuObhxKHAvQ/5Arm2icC9eqVdUtqP3IjbzCcA0899Ckjzi5kK6ciyx1AQk7gAsPoODimBfSPy/oEhBf0ZwIjohf2QUJQIfFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WwEKDPJJ; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WwEKDPJJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpZzl5wW8QJ4HsboGkYV7DYbJzXCoyGBkRRGdhU3IvKHdZr5jrPhChzShDidxD78CRCCZaExB1bhDEAZtjSx7aG57kIg6Qo010FQE44F6UsZCWKw1eQvPmKX4YdlUibLoGEdF7MOdwGlu+O9pw/k92G7X4WYtx01P/PmFb6+a+iFkd0BbxC+M6UiVFOCqTkW/mMg6e6gfQ+8Tk0eInei3xLCtvCu9UCH0SL7Aima4O7du9HzAlcSv58xSvm9zHq/8w6pH20p6o3miNVvx9keLRpSeLNMjIEBpPh2T6E2iERVikvAZze1MzTPdNZzGEvd9w/whxeoeoeAjCmX5OUf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxiVz8W/dG/C1nkA4LUFTdOCj0QC+pphrTe4IVhtV3A=;
 b=zLVH9NFzReGYNirIKrOg4FTmipDdfoaRyGkqhhFlef3FKvBt8pQaUSVuQb8d4PXOIIWkQ+964OwwqJk9VrTaX4c2bqObr/jBOxeE6+C3pm9+VvUArasCqBIfB4v9FZs1bezKF2r4M8b7krV7YWp3a4tLb5oJQmQtQeOon8suWn1Sf4DfPZfeLqp+3cZSCkYf8dzArMhWupBI5MH8mh8KsF+sp7+FkPdrvJc9e7NRcVHQviUydHcZ0c/iMs+MEca1ufsy+9UmGkVimv2l4W7C2B5OLXe445wgnYGAIO3zQi3JJP0fCI3DUNvbTlDkZqtssRxbW9VDquziwbZdV3pZ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxiVz8W/dG/C1nkA4LUFTdOCj0QC+pphrTe4IVhtV3A=;
 b=WwEKDPJJR6fOr/JinuN9SFN25Rxlc6/Fczzlyca5O+kxqIsbOIBzWFjwTMN2fiD8Ts8bfpa4wJzfpsJE5yIcjBkucRc7icIZvA83n7qY9TuTTS3qGq+I2nK70yN+4+wglGegp/PiFQBbetVJfIQAWzlPqpBXURWk/NVA3pFtpvvdFMp51W2zGbPhLFlpzf4CSyv4h4e1QJmkszfM4exJ+JPuztSCsMXRjSAcK8KBw4hkpR1cEqvaCXqgTXHCSpbPd00yrPpbMFkiqlvtg1umiZYn7bp6sMRaQEklTp1cN28obmXXanm/FUtag2aDIlf8fpmlEMV5U1hzFcKk5xWDCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by VI0PR04MB10496.eurprd04.prod.outlook.com (2603:10a6:800:21a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 07:48:21 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 07:48:21 +0000
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
Subject: [PATCH v1 2/2] Bluetooth: btnxpuart: Add uevents for FW dump and FW download complete
Date: Mon, 14 Jul 2025 13:00:16 +0530
Message-Id: <20250714073016.1703837-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714073016.1703837-1-neeraj.sanjaykale@nxp.com>
References: <20250714073016.1703837-1-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 37440f77-5697-4bfb-b4a4-08ddc2aacde9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2NOZkFmWkJPZks1a24wQjRUZW9rK0Mzc005YkxpRmdFdWR4KzFBYStQRzBH?=
 =?utf-8?B?Z0xtdy90N2Q3TGhkVzZCa3RVL1YvazljQzEwODRrbU9od1dXSnlDejl0MjFF?=
 =?utf-8?B?MnV5MHduR3BaR3Q5MlRjYlEvUEQrV003YXdjSFIwOGJTLzJmSVRFWkF2MTRT?=
 =?utf-8?B?M1VPY0pEUmhRaUdUWmpWeUVURGE1alFEODNVUGxNUkw0ekJGY0pzR290emZq?=
 =?utf-8?B?SG9TN2xNaEg2NG16V1lFSVd3OEM1QndHQW5qMWhkZDZKY0hTN1c1ZzVpNWlR?=
 =?utf-8?B?TUkzQXV6bDZEbG9qOXB5MDNMNEJYUm42UXl6Y2VoV2lSbC9JU0p6NnJXRkJ1?=
 =?utf-8?B?Vy9YODI3S0JocVRDdERJSGl2TGQzWG43eElsZ0VTQ1k4YUl0MXIzK3BzZ0pO?=
 =?utf-8?B?ZFY4NmJMTG1aT2ZWcXFiOHFJQWVMUi9ZR2VOL2VOVmZzMlhPenFBVU5QUm9o?=
 =?utf-8?B?cG9KSlNiNkxaN0N5SUtpMTdCWE82dk5Va3N2ZU1oREFWZmd1eTlvN0R2SWVE?=
 =?utf-8?B?ajZsaVE4NzRISVoxSFl3czdVbGNnL21mQXptVGtxUW1WY0dVL1E2eG5vYkpM?=
 =?utf-8?B?Smxlc3QzamZ5UnJudDFTWHZSWjhzR2dpVFpvWFlCcUlFUk9vUDZYY0xNeElk?=
 =?utf-8?B?L0J5UDBIWVIzVTFhQ1Z5dlQ2L213T3MxeVVlQm92UG5wM2JHNHlnMTZBRXR5?=
 =?utf-8?B?QWdIbWZKbVlrSWhUVzhpTnltUTdFUEtMVFRxbSszbzlyU0tFcEVka1NVM2tK?=
 =?utf-8?B?ak83Sk9xVTBGT1NMcmZuZnpCSnVVZGFaZjhSbjBKUncxYmV2Nm5WWEEwL1lW?=
 =?utf-8?B?ejBFdlBubHkwOHBibnNvZzJSR1FWY3R2WFovOCtORUhSZmQ1RGpxN0hUcXJm?=
 =?utf-8?B?TXo2YmtmTzQzK1kxR01zOGJ0V1BVWmdCdmcxVlIzOElORkZuMDJhNGR5QkYv?=
 =?utf-8?B?TWpud2sxMTVvNldybFpuR0cybVNCb0FCOFBraGZoUUJlZFd4OXMrWXl0OERZ?=
 =?utf-8?B?aTlhQjhTdkVDeXRHVGhvSnhNRW16YmlSYzlkRzVFTnRsRHlHWjhlUHdWK1g5?=
 =?utf-8?B?cER0VEtlcDltSW9CaWUxNlgrQTNMMDdIRUhQbkt2Z1JlWUZ6aHNRd2hQR3li?=
 =?utf-8?B?MXA1VGxwSkJuaGJxWEZCTmE0SzJNeENrUm1lUVBrWW9GVEhsMkxZUlJTek1x?=
 =?utf-8?B?d3VWQkp0THlaVFdpQmlFclFXMUQ0VUlORG5BNXVPaXlscFEwd0dNdWsyemdY?=
 =?utf-8?B?OExNaVdIUWg4K3lsUGxxb1p5M251UE43NDUzNEhyZng2VUp4eVpWbW5CV1pp?=
 =?utf-8?B?Q2V0Nk9SbGtTUy8vb3hSU1QwQ0hiNWVXeW5GR01XUzJyRmUwWHo5RjFtY0dh?=
 =?utf-8?B?RDZ0U0lEbklCcTdVZ1kya2hmSk9kWWp2b2dJSWJYMWoyZWJzQWhMYUxBS2Vq?=
 =?utf-8?B?VDFqbi8rTkpiL2xEbTRUMFJCNGZxekVibk5XMEZQWElHQlg3TGIzWlpyYjR1?=
 =?utf-8?B?RndUdzQwc2E5czEyMWRhZ1grN2ptdFhPdE1CaTdoY0cvVVExTzhiZWJjeVZl?=
 =?utf-8?B?NnF6czg5NlpPVlZoU2JBa2tBeERmQWtkOXZ6ZjVNOERzQXB4dW1IYnh6ZDFU?=
 =?utf-8?B?aDlqNGJacnhMSi9ZZzFaZVlJMWl0by91SURFYkN5VDMxL2c3V09sd3FLVDlE?=
 =?utf-8?B?cHk5c0NoR2NNa0sxQjRhNzFRbzVJYkdUcE9PcHEvZ0Ftbjg4MlJ5Yk1GUFVV?=
 =?utf-8?B?c01mY1Q5MHgzWDRETjRDT1dKOVNMKzk2RHFBUno5K0tJcStHbVdySnpMVFB1?=
 =?utf-8?B?K2xVU0ZhcFUyd2dhL3RKMXkweGFmY1RZS1VhaHh1TVZpY1lyYXJsQk4xMlVO?=
 =?utf-8?B?Y0M2WnEvNTlHY3hDb0NqTHVvQ0N5RlpyR2srNDk0WVFrM243OFNlMlZKWWRE?=
 =?utf-8?B?WXNIc0E0Njl2ekYvQ1lWY3hQVlNCTy9zYStSNzY3b1dXQU41Z1pPTzI5TXNu?=
 =?utf-8?B?NjVOSGl3NGZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzllcXFiYnl6MmY1QUJla0tpdDdLWFZ6S1VaMEUxTmM2N1A2bWtTRlEyam0w?=
 =?utf-8?B?M1g5R2g2TGFLc2t3VmkwQm1jdXNlSUJzVlJTcjZPRmc3WmUyb3JCMzVLR09V?=
 =?utf-8?B?RnVmdDFicDNmTEt0bngyaXk1a2ZBelUrTWNRNUxBd1FielV6YUVjcm5Nc0Zj?=
 =?utf-8?B?VU16cXJmQnh6NGNlTXZVeWJmQURRM1dtMUtucVIzRDZCOE53OWpsYmNnMVlC?=
 =?utf-8?B?Ynh6RTFFZXJQakhmZUNNVWJnNkdOQUVMZlE2VXZXUURaRnM2MlNPd2NGMnZa?=
 =?utf-8?B?UHl3NXc0TzVnTGFOci9kdFE4N3c0dXF3ZytjR2h6MVpEMXdncFBOZUI5YUU5?=
 =?utf-8?B?RjAxUEllY3pCS0dkMC9ETVVKNEdLSlF2SjR5MkErUDRYUGg2Q1RNUEdOQUNq?=
 =?utf-8?B?Nk9mU3NrTlptTEtOYU1vTVYzYUlkcUNmRkZOYkdTZU5NcWlVU2k1c0FYT3pz?=
 =?utf-8?B?NGE3UVhRMTBWNjVyeU5LYjlTVGsybjJMR1ZFMEQ5b24wRW1zRUFXTWxveVVD?=
 =?utf-8?B?V045Nlo1ZVB0ZEx3WHNTZmtSN0RXL3BiUXhSRjVmcVdsaytVbWJlZlhXR3Yw?=
 =?utf-8?B?dW9sQVRRenNmcW9sQkUrU2NHZW1KMzRXd0pEeVNOSjNqOXd0YlFkVU8xV0pz?=
 =?utf-8?B?QTZrd2VrUGVBMWd1YXNHZUsyYURBYldEcmU1UmZvWWtUR01ZVUFDbjV0NUcv?=
 =?utf-8?B?YWlyeVBMVlNwWHA5OGlQdlE4eGJZVGxIMVo5dWdERHBOWkhjRkQrQ3NUNmMz?=
 =?utf-8?B?SG5TdVdENlJ0WklNRTNnejZFSFBTUFM0Skd6VVYzdGtMNWZyY0dVNUN3L0Ft?=
 =?utf-8?B?ZG5vWUo5anVmTUErSU1uUUFSbEhQYXRiZlVRVXVjeXYvcXdlbmoyOU1XVzZr?=
 =?utf-8?B?U3FKYThGSjdia2l0WExldHZab2hsL21aekpaczRVSGY3M3NtZzZJNndJNHp4?=
 =?utf-8?B?UXpBYjF2aG92MjFpd2dhRmM3Nko3WkRhM09zVlhzY3lGMnprY2pOODdCNStR?=
 =?utf-8?B?bVNIb1FJTERVSWJqT3FmK2RCbUFmRjZkUDQzcy9CdjFkRjkvUDZlRTNwMVZR?=
 =?utf-8?B?OFRWOXNEM2lMdUtXNG9haU83cnI0a0lOMjIzR0IzdEovbTgvaFp6U2JFdTNj?=
 =?utf-8?B?VkJVVE1Eb0VhMVc1b1d4N0cyMklVcEVQRkJmZC8vbUxZKzkzR2xPWk93d09l?=
 =?utf-8?B?M2NwQ0FhVElWbEhRV2JSNTM3MWpuazJ6Y2NyQ1RWMnFjRjFRcm9STzF1VnA3?=
 =?utf-8?B?YWJXazhvZVl4K1FjTlhjaFBXSlJiM3R4NmdIZDhIeXgrYmhSN3J6UlFWYUg3?=
 =?utf-8?B?YjhXVWlYc29PaUhDTjJpSWxNYUNOVHdpcUtKYjZxS056bmloVXk5QWhDb1M2?=
 =?utf-8?B?VThiTTdmYVRwNkpINlRBSzUwWlJ0Qk5YTE5CZTZrRWxSWnZNa3FYWndwOHp3?=
 =?utf-8?B?MjdWWjR0OWVmOWxsdlpSb3p1RTVwdjhwdVprejhWdXhZaklSNUUzeSsvNXYv?=
 =?utf-8?B?VTl0QWxLYmRPY0NKbXQ4czhWb2pIelV1QWFHVUh1cmQzbXNzZWJlam9zUnkw?=
 =?utf-8?B?YytVK05nVGh2WkNpcGxIVVZYSnFRY0VRQzJ0dXVUYmN1elBOK3J3OUxFb242?=
 =?utf-8?B?RFp5em1sR0M3dEhUMXBjQ29NU1NoaGZXa1NOUG1tMUgxSzFNZzRZOVNJRWsr?=
 =?utf-8?B?dEtRNUdnYi9wTk1WVEorUW9FL2ZJV05ZT3JTYlNlcWZBbHFjYnJhekExbFlz?=
 =?utf-8?B?Tko2OXlqS0FtTmRvVzJGVWVrZWduRGNDS0tQZ3lTMGx2T0xUU3MyV3lLaGFG?=
 =?utf-8?B?WTk5ODAwa0dtNERIV1FOOU15Tm55SWNFbGxkQitDUGF1R21xZ2VMTDFZUVJw?=
 =?utf-8?B?R1YrUlJzdjAyeHRGUDVZVHpUZWh5WHIrYVA1aldrU0xnTTkyUVA3WkkwVUF5?=
 =?utf-8?B?dGlUQ0RSWW41L2l5QmtoKy8ya1haNDhleStEOFNCbUlIS3A5b2RzZENmNzZI?=
 =?utf-8?B?QXNQdktxSUlLcjNyNGl2VStNY01pOUl3VlBKdjBEMktieGZrMVAyd0J3Q1Nt?=
 =?utf-8?B?V2txMkNIdmZkSXhRRzlYL25WN04vSXpWT3B1QWNFUU5adm9HV1FnM2pwZnBa?=
 =?utf-8?B?anJuN1gzNWdERmtQMzMxK0tWSmdvaTRQTUJONGFqaU1DOUhwZkZLa2NrbWhW?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37440f77-5697-4bfb-b4a4-08ddc2aacde9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 07:48:21.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HiqHUVPhPhqdaQD9s+TGhVBCA/qK2H5YvCQeO5U8U9tBeb/AcZDz+0RfXC5gH8nALGmxTcYlfavNc3Kc5+7bqgT9df0HXf3o91zrpXzi4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10496

This adds uevents which will be generated whenever FW dump is triggered,
FW dump is complete and FW (re)download is done.

This feature is needed for IW612 chipset, which is a tri-radio chipset,
where WLAN runs on CPU1 and BT and Zigbee runs on CPU2.

Currently, whenever BT FW crashes, and FW dump is in progress, there is
no way for 15.4 application to know that CPU2 is in bad state, and when
it will be recovered.

With the help of these uevents and udev rules, the 15.4 app, or any
userspace application can be alerted whenever CPU2 goes in bad state and
recoveres after BTNXPUART reloads the firmware.

[  334.255154] Bluetooth: hci0: ==== Start FW dump ===
[  334.261003] Bluetooth: hci0: ==== Send uevent: BTNXPUART_DEV=serial0-0:BTNXPUART_STATE=FW_DUMP_ACTIVE ===
[  351.486048] Bluetooth: hci0: ==== FW dump complete ===
[  351.491356] Bluetooth: hci0: ==== Send uevent: BTNXPUART_DEV=serial0-0:BTNXPUART_STATE=FW_DUMP_DONE ===
[  352.028974] Bluetooth: hci0: ChipID: 7601, Version: 0
[  352.034490] Bluetooth: hci0: Request Firmware: nxp/uartspi_n61x_v1.bin.se
[  353.979977] Bluetooth: hci0: FW Download Complete: 417064 bytes
[  355.197222] Bluetooth: hci0: ==== Send uevent: BTNXPUART_DEV=serial0-0:BTNXPUART_STATE=FW_READY ===

Tested this change by creating a simple udev rule to store the
BTNXPUART_STATE value in a ~/<BTNXPUART_DEV>/state file, and running
15.4 traffic.

The 15.4 packets were sent over SPI only when BTNXPUART_STATE was
FW_READY.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Tested-by: Jean-Yves Salaün <jean-yves.salaun@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 38 ++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index f40794be2d89..c16ff72c9948 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1434,6 +1434,10 @@ static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 static int nxp_setup(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct serdev_device *serdev = nxpdev->serdev;
+	char device_string[30];
+	char event_string[50];
+	char *envp[] = {device_string, event_string, NULL};
 	int err = 0;
 
 	if (nxp_check_boot_sign(nxpdev)) {
@@ -1446,6 +1450,11 @@ static int nxp_setup(struct hci_dev *hdev)
 		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 	}
 
+	snprintf(device_string, 30, "BTNXPUART_DEV=%s", dev_name(&serdev->dev));
+	snprintf(event_string, 50, "BTNXPUART_STATE=FW_READY");
+	bt_dev_dbg(hdev, "==== Send uevent: %s:%s ===", device_string, event_string);
+	kobject_uevent_env(&serdev->dev.kobj, KOBJ_CHANGE, envp);
+
 	serdev_device_set_baudrate(nxpdev->serdev, nxpdev->fw_init_baudrate);
 	nxpdev->current_baudrate = nxpdev->fw_init_baudrate;
 
@@ -1766,6 +1775,33 @@ static const struct serdev_device_ops btnxpuart_client_ops = {
 	.write_wakeup = btnxpuart_write_wakeup,
 };
 
+static void nxp_coredump_notify(struct hci_dev *hdev, int state)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct serdev_device *serdev = nxpdev->serdev;
+	char device_string[30];
+	char event_string[50];
+	char *envp[] = {device_string, event_string, NULL};
+
+	snprintf(device_string, 30, "BTNXPUART_DEV=%s", dev_name(&serdev->dev));
+	switch (state) {
+	case HCI_DEVCOREDUMP_ACTIVE:
+		snprintf(event_string, 50, "BTNXPUART_STATE=FW_DUMP_ACTIVE");
+		break;
+	case HCI_DEVCOREDUMP_DONE:
+		snprintf(event_string, 50, "BTNXPUART_STATE=FW_DUMP_DONE");
+		break;
+	case HCI_DEVCOREDUMP_TIMEOUT:
+		snprintf(event_string, 50, "BTNXPUART_STATE=FW_DUMP_TIMEOUT");
+		break;
+	default:
+		snprintf(event_string, 50, "BTNXPUART_STATE=FW_DUMP_STATE_%d", state);
+		break;
+	}
+	bt_dev_dbg(hdev, "==== Send uevent: %s:%s ===", device_string, event_string);
+	kobject_uevent_env(&serdev->dev.kobj, KOBJ_CHANGE, envp);
+}
+
 static int nxp_serdev_probe(struct serdev_device *serdev)
 {
 	struct hci_dev *hdev;
@@ -1849,7 +1885,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	if (ps_setup(hdev))
 		goto probe_fail;
 
-	hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr, NULL);
+	hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr, nxp_coredump_notify);
 
 	return 0;
 
-- 
2.34.1

