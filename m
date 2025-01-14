Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D413B7A3;
	Tue, 14 Jan 2025 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864286; cv=fail; b=lmmQwhzfTcjLbFDdU4c/MkX8rqzbfaCTmMFp3Woqj8kgybevNuRWh0JE723t+2hzgZHUx+tandXfzf9JHSKjvCWtdMSgvbmbCR5rdrrr3/sJLgy9nFTkBG/db3hsDlq7Ap16BjPEFHnh84Cq+2sUjgRIOlpDBBGyh7DgM2RlSaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864286; c=relaxed/simple;
	bh=qEwOgUuNtM3MeGJu+fGRwOdHtEdlmeqDutKE/H3W7xM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RyZBlfvDns6L7X8mHR28DPLCcd20fvii8xTugDO1zBwiG0pTuP2qn192NIbo6lLslK8dcmgLFdnDNDk6XpfeUQxLm4Q428YmJnGZNuVQdwQrDcBStbhwI5iQfH5SKaqkh1sXFFAQUZpgT3FxsZMzIUn+2/XyqMvBsWw5wwLSXzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iVEaU5Ac; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iVEaU5Ac"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGFxjJ89DhJunm3B6GmI8xVHXYAjm/w+BOrbwjXzg/HSAu7oU9hdELKG/zWpi5uzstbyp3h1i0IzN1CVS4MgB/cMJbQuOU6oYSbwuN9DJDTZknYO3lCLga8+wQnT8H7gz935G5+bsnu5Tc9alONU0gH83gmSX4CmuZXMN/VvTPz/NWWssSDjvaIPvubjHvzwmXEhq3JpEA2Zqa2TlsZuleMuQDmrDPafKFSyAIOlQXcsv1/gb9aTzE5J3VhL6A7Tdd/na86L6hGOFfFvJyDMDcxkIty8ryUkQVwFC5KTtJLJD+EwN4Vg71y9Sud3b7/4FwlSRqoHSv2gocIkCbs36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3GfMA54z6RQBfAsc5L3IwjxdztoEiO/a87y148hXfw=;
 b=WbjB4OEISWJ3W+Yv4N0KU/HueoeutzLpU9vA6Fk88FROs5LjF8lfjS/4/Tc3yRKym3LqGfT3ed7oDDkoDIMGW83mkyVj64I97nfS7ZuQT60uzu8ZqzVbayhNg/x9SBm62mkz4L9+cGwCHbufQjEPBQLROlFF62wes9GhqeDtNctzi2t1i/A0kVe4nBAHEpRtci3WoJM8b+Br0mzwCd7F7GTR7/kxnRzmKWGN9x8K1voNmA9Te0ss4bGtuBAEIxjFQOmaMd3A+MjZAPybv6c7I9bpZIxXfW52QpDjrFiaCn+76tJRfcJO1PoGgmGZhnbHHGx3sJUP/nB101RiBO1aSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3GfMA54z6RQBfAsc5L3IwjxdztoEiO/a87y148hXfw=;
 b=iVEaU5AcxSuCRSt7FLE4hJPbVJoSr1qH/lBKqIbe7289WYZHY2Wy94CKtgXHYwIUQT+sE+miQGH1fXG9GPrJ9K+xfzv5YromEg0S1rTZwlZFdOleH51d+LfNj/HUIt/1mQdeXERutlbpAsA4wzvdpSJyhTaY4dNtsSAzjG0nePeyAuUiAJ6e5tONHjkDaaSDn/bn8s7HHhyELB1OKTd39aRAVVpw/sClJahITGl3oo6j6Ws5KIhJL7OwEPyPD1qK+w9l3woj7L7GZMCJwsYcuWfZ3tH4j2U0w0p7RFLRT+geU1WIBcBYjDshNdSvU6O4ytODxsE7Ad0+JU8VeCnmGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15)
 by DB8PR04MB6812.eurprd04.prod.outlook.com (2603:10a6:10:f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 14:18:03 +0000
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a]) by PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a%5]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 14:18:03 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	johan.korsnes@remarkable.no,
	kristian.krohn@remarkable.no,
	manjeet.gupta@nxp.com
Subject: [PATCH v3 2/2] Bluetooth: btnxpuart: Add support for set BD address
Date: Tue, 14 Jan 2025 19:49:12 +0530
Message-Id: <20250114141912.2363131-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250114141912.2363131-1-neeraj.sanjaykale@nxp.com>
References: <20250114141912.2363131-1-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0109.apcprd02.prod.outlook.com
 (2603:1096:4:92::25) To PA4PR04MB9687.eurprd04.prod.outlook.com
 (2603:10a6:102:270::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9687:EE_|DB8PR04MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1fae63-1319-42dd-e27c-08dd34a641af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0ttMVlKclpiaGNNN2d1aDFiMDdUSlZ2UVZkUjBuTWR3eUthQ1dUYmFLRjdz?=
 =?utf-8?B?N1FJbEh5TWl0TGdvKzhOb0FZYTg5QlQrczAwRUxyK2lqK0txcmRaQWdrd05y?=
 =?utf-8?B?WGlRb09QNlE2SkpZM2Q0YmFhenBtRTZJemhrVHRrQU1xbFh4Z3oraDgzMXla?=
 =?utf-8?B?VXMzRjdUSW9idGFhVzYwZEZ0NEl0NEkxM0VqVFllR0JCVEFGejJ6M1VSQjFq?=
 =?utf-8?B?ZEhQN1VjbVVmRWZBUjY0Vjk0d09tMENkdi9YcWUwcGRiNjNESkZCRzFHOHRn?=
 =?utf-8?B?QUVUL1RueW9rc1VJVnpjRS9XT3NQZk5GWEF3eG14dVdtMGpJam1VcUtoL3NL?=
 =?utf-8?B?QWE4YkhZWnQ1MThqbllieGMyYTloSmhiQmpTMWs0Q1V1U2V1NjFzazVXeHIx?=
 =?utf-8?B?UTBDTzFVc29GR2JBeUZHUUQwdFJ0bWRxbjRNMUFJRVp0SmVtMnNXUTVaczZm?=
 =?utf-8?B?UExkMnlVQjdQakVTK01WTzNKaE04bm5na3dnWklmNCtKWWVja2N6S2NSREVW?=
 =?utf-8?B?QW9ncWRqdDgyZlZxN0Jja1dLc3F5YlBiNGRTQ0FNMjdUMnVTZWMyY1BJLzlL?=
 =?utf-8?B?eFowTU9VYnJYSnBrdDlMSHYvb01CaGNqYVRvZ2lZOTFSN081M3hFWFFkOFpN?=
 =?utf-8?B?eUlnbmo1WFQ5c3hFeWRwR0xHVjk0SFBlb25Ga2tVV0xFLzcva1FPOFJhT01F?=
 =?utf-8?B?NUJLMXQ3bkVSOWxqcVdOZS9TUDAycnJYQzY0SWpHVWtBaUxSd09aWENIbTdN?=
 =?utf-8?B?TnBpZFlGTlhOb1U5K3plSXB3MVA0MFNUQXhLRXhBSyt1SnVzajA0eGg5cGpy?=
 =?utf-8?B?QmkzUm93cDlzQ0hoZnZBbEU1SU5wUXdPd1lsd3RDbFJTblh5eUU2eVU0ZG5S?=
 =?utf-8?B?SWkxRUNscFFXZEZNdU4zVWN0L2lmQTlGV3lWbFpvSmlqQUtMVkdHRUMycjAw?=
 =?utf-8?B?L05tejgrZ1Urc0RrSEVhNGppb2pqblN2VDR6M0tMM1RXZ25ONXEwOSs0d2Z4?=
 =?utf-8?B?a1g0ci8wQytrRnJ3R21PYkFsaXUvYlMrSkRpQ0VhbWFUbUhxODlOV0lyR3Na?=
 =?utf-8?B?aXBEMGV2TlNJRGpjK0hrYWV2N0ZFUmNEekdmREV3bldUR1hhNXBYcHg4cGsy?=
 =?utf-8?B?TW9jTitGOFc1NytFSDJZd0IrNHlyQ2lUOFA2RjJSVHJNNXZ0SjgwZG1rdkww?=
 =?utf-8?B?SjdjOXhqUW8yQzdGdnMydkR2eERFWTJaWUdBbGNyNGRKVFV4UjNDWmFLTmt5?=
 =?utf-8?B?d0JISXZpNERkSmw0VGxnVDl2b05vazk1YzR0KzBIOXZPTmRTb3JQNUdGSWtj?=
 =?utf-8?B?ZTlXZFUvc2hFeDZhUXN5V1huNCtIQmlKVDJoSThHKzcxaVFoMm0zNGhqSkt0?=
 =?utf-8?B?cmdWY2FPREwxN051Q0loZ0ZBSmo2OXJ1RXRWWW9kbG54WTlRUGZrRXA4RFVu?=
 =?utf-8?B?VkMxRDIyb2g4bUMraWc4ckdGeTlzM3h1Z2lxS29RWlpISFZrc2NkUGJNenBX?=
 =?utf-8?B?NUF5QVExTktMYWNjYjYrTk8vQ1RQMzVFaTRPMGdzd2k3SS9FZktYdStJc2Iv?=
 =?utf-8?B?TnRrNGd6Mk8rbWpkYUdBSDYwR3RUaXVuVzJNZHJ0WDZBRmJlSGNOTjU2QVJq?=
 =?utf-8?B?eDFvSlpFVWwydEtENlpqN1UvWVlwNldvR3RHclFoUGtJVXNKWmt0Y1grMTNp?=
 =?utf-8?B?SVdLYzZZOVdJd2RNZmdKbDV1S1k0bkhDRWF1dDI5Tmx4Y2VRY2JXUHE1ZXZJ?=
 =?utf-8?B?NHdKbDhMTXRUaytpL0xvWjM3OFZWZUVndStTbWRsYXZLUkRySHpWWi9VbWVO?=
 =?utf-8?B?Smdrc29nSzJRcGIrQ21RM1M4RXo3K1NFT2F1WHE2cjNYaWROTkp4UDI4ZEZ6?=
 =?utf-8?B?TC9mdlFwTEw5cXcyU212OTh3Ni9jWDBpU0hibGQ3YW1sUlhHNDEzcUh0Z0Vj?=
 =?utf-8?Q?vmG0er7axCmcXc4C7D2p2TnnwNYD8Q0N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDN5cVVBU09PYWZBUVdYM3BVQ2o2Y3F1L1MrcUxVbWlJSklWUjI3d2YzZVBx?=
 =?utf-8?B?Z1Z3SnZvbnlzbnd2d2M3djZOMjVUZFl2OThJTC9ySHRXK0pZcUhHQlo1d1Jk?=
 =?utf-8?B?ODI4SXBXa3RCWm4zM0g5dHpieVVwcnFrVno0NmFDQldyQWhvWjBKL0crNVY4?=
 =?utf-8?B?c1JaSmtqOEk0cnJlby9waCtCb3lEQ3F6N2s1dmpuRjVRRk1GZVZtenBmcmo3?=
 =?utf-8?B?SXljbk1tZUNTZlgvY0pIR01sMmRGL3RQdWxRaHFYbnluV0NTNWZ4QXpaTWJS?=
 =?utf-8?B?UDJSSTFxVzJUTEFsL2xHSVZtdnlrSFlKdXNad2dma1dJSlJIdS8vTDdEYlRi?=
 =?utf-8?B?NEM3S1E1MTRocFJIZlpzU20ybEFwaVRyUXJ3QWNveUNWYmZhdlVYNi93RUpG?=
 =?utf-8?B?eGJ2cktRVWZmYWE2cTFtenRRN1p1Vk1hSWVZT2toMjdtU25MV1NhTmYvNzlY?=
 =?utf-8?B?c0Ntb2dHYy8yZEhUQTVaQmY2MlM3K1I3eWo2TThtaWpncjFIVDM5d0JDUkk5?=
 =?utf-8?B?SmtRYkdTQkd6N3cyaFRQb0t6V0tJVTQxeTBNRDhMRklQcUZjcFQ5VnY5Q3Fv?=
 =?utf-8?B?RDNNOEdGZENSSGs1QkEvWFl5Y3ZGNTNFc2RWeVlSQ205SlBZVllFek55Tm0v?=
 =?utf-8?B?UFdmOFNRMnBKZm9jWDB1bEVOVHI2NEQ4cnN5Y2MwSDU1ZHZKQlNMVXlhZ2Ro?=
 =?utf-8?B?NCtVc2kweFFRZEhWWkRWVlozMW5BV3NmY3VOQWh6U0xMUEttM3plQTF5d0l5?=
 =?utf-8?B?M0wwQ3VPbDlnTU9tR25pOWxXcDF1UUVvN0RSbU85WURtODV4RDJwSS9qRnJD?=
 =?utf-8?B?OHNYeW9Fays0OWhMdUROc216dlI1SkwrZENLRWphVlI0aFpjYUIrZW5YYTdM?=
 =?utf-8?B?UjdKRVZZcHNlOVdTZ0lhUk9hQTJpMlF5aGVNbVdkeDlhRGc2Ry9jODVSTnQz?=
 =?utf-8?B?eER4Nms5cmlEbnp5aUhxQzJYZkFZVlVqVW5mdkZPMHd4WHliWXlhTkRJais4?=
 =?utf-8?B?ckJNMDJqL05lVlk1Mm8rSzV5YnpuT0pMUUtQZmtNdUhFY0hRTXRzd2VpVjRz?=
 =?utf-8?B?a1VpTTdzd2ErVzhyY0tCWUcvdzVka21mbk5uTGVjemprcHZ1c2g1YmIyeDY3?=
 =?utf-8?B?c21qSjMzZ1Z4aFYwYlR2bGF4MWorZU1sVU1RVUg5N2Q2NldXc1ljODM3OURL?=
 =?utf-8?B?WFpreml6WlpUdmJUWlArYWtBOGxuMHAwZG4wU2JkU3dtN0dsQjBoMUNMMXJ2?=
 =?utf-8?B?Ymt3anpPOXpaWUtpSTRpeFdhdlZ3VkhyVmFUSlU2K21yaXR2d296TUtZVVNM?=
 =?utf-8?B?d0ZMTXNPa2ZmdzZUWERLM09lc0d0aUJPa09zVitKZjJQcy9aSnZDTDZreTNk?=
 =?utf-8?B?WmZ1QmZtTWhkQm9BMmNjT045eUdZM29mb3YzYWRyUVk0aWFqaDJybHZoVndW?=
 =?utf-8?B?SXY1TDJzUXNMblNiUjIydkpZek9QdUVJa1VZQ2dQT05mQnJyQUxuKzRZZ05l?=
 =?utf-8?B?MENWUzltb1BvblYyd1FnUFBMdW5ORUkybXhzS3AxZVZkUThXSkt4UmsxWmd4?=
 =?utf-8?B?dW5Kd1BIUGF5WHBSNEhSMEpyV1BsMjVFQzZtL0twWkpsY3o4U3V0WjR3VENC?=
 =?utf-8?B?NmJ3czYyQlBXSG1LdjJIcHVpRDdLYXNPRFd4OFJ2ajRacDNJKzBLK0htczQv?=
 =?utf-8?B?bHNYTUdtTzVvUGhTaHNiRk1DVFg0VXBGdHYrNXpJWW1tWVhOSGZQUlI2dExM?=
 =?utf-8?B?a2JEOUFrZGE2ZWllMXpNdWZ6akd3TXFuU0J1bXE5eG1QWXFvNk8wODVaUk9j?=
 =?utf-8?B?czBWN2NRSGoyUW0xbEtNNm55cTAyRFJUSllINmFxbGhvaDdhVlNjcXNGazBu?=
 =?utf-8?B?dCtQWFlINDhxZGdlZlc1Ujk4WnlPSWRHNk5qVm5wZTdTMmg0c1dXb3NFRGpQ?=
 =?utf-8?B?Tks3K1lCZkswNmdEVlN1dktlYXdHbHdaRG1Tb3NKUjVuYzZuMUd2VFpyVWhx?=
 =?utf-8?B?NW5ZL1cyc2FaSmE2Q3JhTUtaNWVFVGFiVVI4OXlxYlJ5T0ZmTXhFOWk5Qlpu?=
 =?utf-8?B?L0oxV0F5U0ZnT1R5QkQ4RUZsem5kZGFWRDlzN3hMM0lrWjdhc3F6NzhsY2Ev?=
 =?utf-8?B?MkdNbjRjSStyNnVnaDBPK1B4Kzd1a2hOVi9PaDJ1S0QrcnhOak9zY3ZlVjF3?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1fae63-1319-42dd-e27c-08dd34a641af
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 14:18:02.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fY/nNWHD7er+Ay9+oxiisBUH9CRSxJMxFNv4a5bsf2+fB8n4oKRWvolyRzO19yLYa8wp2vvsXAycWLNUGuCwwgsBCJqUWzNPHS1Rjv+wPzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6812

This adds support for setting BD address during hci registration. NXP
FW does not allow vendor commands unless it receives a reset command
after FW download and initialization done.
As a workaround, the .set_bdaddr callback function will first send the
HCI reset command, followed by the actual vendor command to set BD
address.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Johan Korsnes <johan.korsnes@remarkable.no>
Signed-off-by: Kristian HusevÃ¥g Krohn <kristian.krohn@remarkable.no>
Tested-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 1230045d78a5..deb546a4e664 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1197,6 +1197,34 @@ static int nxp_set_ind_reset(struct hci_dev *hdev, void *data)
 	return hci_recv_frame(hdev, skb);
 }
 
+static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	u8 data[8] = { 0xfe, 0x06, 0, 0, 0, 0, 0, 0 };
+	struct sk_buff *skb;
+	int err;
+
+	memcpy(data + 2, bdaddr, 6);
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Reset before setting local-bd-addr failed (%ld)",
+			   PTR_ERR(skb));
+		return err;
+	}
+	kfree_skb(skb);
+
+	skb = __hci_cmd_sync(hdev, 0xfc22, sizeof(data), data, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Changing device address failed (%d)", err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
 /* NXP protocol */
 static int nxp_setup(struct hci_dev *hdev)
 {
@@ -1547,8 +1575,12 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	hdev->send  = nxp_enqueue;
 	hdev->hw_error = nxp_hw_err;
 	hdev->shutdown = nxp_shutdown;
+	hdev->set_bdaddr = nxp_set_bdaddr;
+
 	SET_HCIDEV_DEV(hdev, &serdev->dev);
 
+	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
 	if (hci_register_dev(hdev) < 0) {
 		dev_err(&serdev->dev, "Can't register HCI device\n");
 		goto probe_fail;
-- 
2.25.1

