Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2087.outbound.protection.outlook.com [40.107.241.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DF1156644;
	Wed, 15 Jan 2025 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937907; cv=fail; b=lN+WG0xm8VAols/c+WEKGkfHlGH2OTzpEJSpI1zuF1QdUDP9FifIAFq6P5GXMT9iPKbmokdUu1atZhDxm+visO3wLp0EuGyHHcgmsqXjan9SoxnodhorpW2KNiHvufD9mKNwPQuBQuJcZ9GFh0XDOGFePYX0jswmp8e83IM9X04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937907; c=relaxed/simple;
	bh=09FLFt7CPRqw0H74Tp5wTNa5H8JujFRAXlRT7R9NEBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ki1V7ibzV4QMXWrSQ3BBnW4cBdGWjkZ3TbvlgeiSD9BvpXxd6xIUvsHP0dELNqKuuma1EQruNnMQOXhr8FwboMn9QqF1kYlR6q6Cj3/IYZPmyqqQT6XjJ/xesisPupHU1JfPpoJTMwnBXc8Qzyrsa2k2c4p0SRnBvxUYdlb3k88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B3nL9mjJ; arc=fail smtp.client-ip=40.107.241.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B3nL9mjJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OklW3BtU6JiW6UZg09vDE/Tw2N6GCIAd0PSZ5hpf2dfrPzjDpc+mF0xuzQDwzTi/Kqu4P56FgoSmJA6rrGZc8O2TkG6YuJzMs0QU6LFJ7OX3zG3cwwfwN9DSERQgWOd13gzc5iHZ93KH2HEpDX4mckVurYN758zO7r0BoWzEg2fUkhQwDwnF5qw06Tu7SMI/YwZbj3J8VP7EuX1KwQrothPzfzAhYEyYqNl6EOFUrOF9wDvD2+BuogOKtJ7VjZ+Kv4sU7mtYU8RsIqkwqSpkgQKAbzpUzEKUYbFASYdnpnngUCCr2cS8AXSEjobk6/JBwET/5UGHJoIO3rN5XkSL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B094ROyfelAXhuEfHOLnG8f0c1McKjS2hRphp+ggeWU=;
 b=AjPxhAVIXcKHRvgWFr7ODgjC8+r3Fj3pjCfEYdwcMaivPB2JHINy/EyDK4rGg8hDeeU0IZ626DJ0CZ7wfqF/KIuS3jR3/iejsXQELUZuiX4dD3dbdxwjQJ18XS9h0FmMShvUCKJz8m/QFgmyynww2dBnVRMtzETh0Xmox3A8LC83Hx8PmGMT1nOQsS1RAwpFw52Oter/nq+C5Pe7bn3ofwOjrOgSa5YpXXFzODlSbbLvmH3pHjyjvB6iqkZN4DZAsqM++NjUgOHwT1N2D2EIC2Bk54AymfwoMvsT2KWHQVmNSvGjM6TrmPm7txjJpIYqUv6fnz5jkcBT94mMoIUTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B094ROyfelAXhuEfHOLnG8f0c1McKjS2hRphp+ggeWU=;
 b=B3nL9mjJ34V+DTm2/SSvYS8dYZQJS8xqrAY43h6lY8pO5Itg+hoG2BxKJrjwAC7BgSJuLLR9xzETzcVe2HhRRdm72stok62LT+kELqwbLS38A+dfNboEgJxnyMZXdiPRxpOwdR0WSOuX7ORG8M4aPt/vs9XE1g6m5nM6WVC0UNe4h1XMZ/IfEtSbZXUQEYYwZHESqE6ETUcaOX6AQ920f8mu+eEMERt4aqFg9/uBK79Sv8FcG66CUpPsbCv1ab9uCLubcasqCwhDZc0MMI3dgt+s85/S6enLQ09OHH4FtRV8CAsyqatb7nW92HA2AcKnh99ebDJkcTokDgTFBnvYmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 10:45:03 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%3]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 10:45:03 +0000
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
Subject: [PATCH v4 2/2] Bluetooth: btnxpuart: Add support for set BD address
Date: Wed, 15 Jan 2025 16:16:14 +0530
Message-Id: <20250115104614.2381674-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250115104614.2381674-1-neeraj.sanjaykale@nxp.com>
References: <20250115104614.2381674-1-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DU2PR04MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: 1620ffea-f523-43a1-b61b-08dd3551ab26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWZqZ0dobTA1NS9kcjVDbGQzYVdmVENVWi9CcFJNczMxM1cvRlpITFg5RkFW?=
 =?utf-8?B?TDZXUUNxaU15WnBSeWRrUE1wU2lqTUtUZU9PdDhGdFJpYWtLYmkyWi9pZ3VR?=
 =?utf-8?B?ZjRDaTNyTWljekpXSWo2R201VVNvT2JpMml3b3Zsbk0rTW9WdXlzWWgvS0dw?=
 =?utf-8?B?c3NWZ2g0V0NwYTNUcStqa0JaMklFdW1DMkxXY1A2RjJMNWt5VUR6azVSK1JO?=
 =?utf-8?B?U1ZGdnNpT2VYQVFKQS9JbDRDdDVpWmdFamUvNTVEb054ZFBDMmY5a3hnd3Vm?=
 =?utf-8?B?WVNuaFNtcU5HazA4Vmo4djMxeS9QL0dobzIwSEppb2pLSXBRUXVLajhCQkFG?=
 =?utf-8?B?eXQ4MWI2QmdpbDVCb0JVY1FpNkFHbXorWS9ML3ZNT1lySkpXZ1YyeHpNSDM1?=
 =?utf-8?B?TWNMVVpFVmJ3a0UrYjQ1eVNPdmJBcjA2VFNETVRCWFpFcHJScEhSRDByRVN0?=
 =?utf-8?B?Mjh0R1NGbmFIT3NDdDlDM2xNenRXN21VcG8wOVNORVdzcTNxYVY4dkJVU0lC?=
 =?utf-8?B?bExFWW9qb2pLUWNxQ1A4M0huODcvOFNacEkxZ2s2dFYzeGxsVk03TEk4MVBk?=
 =?utf-8?B?S1UvZkRIN25xbHFaTWpRSmtzdzBBclpjb2JXTFBCNE1zbERMVkVxdXZtUmpo?=
 =?utf-8?B?bC9ISVVhU0YrSmZkcXQ2SlFBQ2VMT21FbXlObjlHZXhGcDFzK3VmVktscHM2?=
 =?utf-8?B?TklQbyt1S3NEVWtEWVJVT3gvVzZ0eGdMZ1FJRXhuODhGeXd4RTVRMWJxblg3?=
 =?utf-8?B?TGNITU9MYzFHMlpsN0E5T3k0cm4vbUpINWJWcXRENFIrRzBQMWkxeHFCVWxS?=
 =?utf-8?B?bERHNVJ3RFdtRVFhallwMk0zZFp6a015LzhPOWtKT3FGVUhTNXRlV0g0aCs0?=
 =?utf-8?B?VVJOd3RNdkFBY0FxSUlKRFl4Zm1yMWVJd1lOSDhRMG9aZzZ2N3E0OFMxbmk5?=
 =?utf-8?B?YStnd1Axb1RVcjEwWi9GMXd0RWl4SmoxNVJZUlRXSVdrZFFSOHdodGVtckhu?=
 =?utf-8?B?eHB3dzBHcWJDY2RsUU9RNTl6amh0eVpkRXhjTzMyRkhHblQrYjQ0c3RXNVRF?=
 =?utf-8?B?N3F2OGV3WmJ0aDI3MlRBQStKNjIzamgzNW8wN2M3OVNsY0ZGcmQ4OWk5SGVO?=
 =?utf-8?B?TzBIWVJhTUdVeC9PL2c4czV4bVZvMjVrSmxYeTVpWDIySTZQY3dpK1VEWkNO?=
 =?utf-8?B?bm1MR2xvRW5YaEFzZ1RVV2NDOTRmUlBTNFM3eVB3Ylp1b1ltSFFrWmM0Z3Ax?=
 =?utf-8?B?QS95WDlSQWRMK3hKRURvdUNYcGNXRmhtNFRSZ1ZJenB6SW1wYURIRVkxY1h1?=
 =?utf-8?B?SlVxdGZYajlhR01BeG5tZWtUUkFvMGd1WlNWQnZjNDQvY01kU0N1MFM1em5U?=
 =?utf-8?B?cHpzZGZZOXQ2V0JNRWpDNGdpb1ZZNzZrWncvQi9aaUtUcGVrZVEvMjY5aW0v?=
 =?utf-8?B?cjJaSnZsUWFLNlh5UUlhU3NEcjZJd3Q1S0tEV1YvT0ZxbUJzL1VCOGNHazVv?=
 =?utf-8?B?dThqMmZuaTRTN0tlQWFEcTlxOURSVUNvY0JEOWsxZm9uWnhJNVYwNWF1SENO?=
 =?utf-8?B?cm14ZmZEaFdDK2hsSGk4ajdWYUFDUFh3d01ZUE9wWGVnQjU5clIyS1B5MXJP?=
 =?utf-8?B?VmtkNzZjbVRJZnVXLzZLUWNsb29JYTdMNXJ2bjNYdEJobDl3eWFzQjFrOHN0?=
 =?utf-8?B?YTBEb3E1cTUxa0NzMFhkeE5QcmYzMEhWc2prdSsxT2FWZTJRSlJ0cjlXcGZ6?=
 =?utf-8?B?Q2lkdTl0TmdNWjVYOEh0RXpLdVd4VTk3eXlBcFVwa3gzcWZxNFB4YTRJMGxv?=
 =?utf-8?B?eWFscVNvbVk0R2Rld2RwR0RlNTk1WGxiQjNlV0Y0ZytFTWRvRmp4aW9UTkNK?=
 =?utf-8?B?TEFOV0VpQ0MwNlFoY3E5MVh6MFFjYlVtM1I0UFNuNGxJWGwzK2xSbVI2bEpp?=
 =?utf-8?Q?ExNntEbA4OJsPQNfsAOBWCDhvMHHRchn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHhXWGxMdFNBYU1MU0tKMkNKSDlaVnlMMEFOVzIrdjA5b25oL0QrdS9wRlVr?=
 =?utf-8?B?aGtZcVRKMVIxQzBubm5Sc2NYVFFxcWJJaDQ5dEtMcjFNRG9hRG45b3QvSWY3?=
 =?utf-8?B?dks0WHlpWW5QUlQxMjZkTVRBeS9xcVM5MkRBNm1ZU0Vab3NuVk9qcjlHZUEz?=
 =?utf-8?B?elJXbU85NWF3YUVvL3A4Sm4xYlVualJQMDdtZklhL29aYzQ0a00vNWtlaURC?=
 =?utf-8?B?S2lYVmpySmVLOWt1dkZqeHg4dDhEOTNqUHFnMHNVT1ZZQXBEdzA1ZFNwNHBP?=
 =?utf-8?B?MVF2QkV2TGhheU1Pc1h2SUNjQjhZbCtuc2NZdUFURy9SMmNUUlhiejE5enRF?=
 =?utf-8?B?MDYyb1VVbi9PWWNKT1FqWmR2dmFiU2d6a2ZCRTdZK01FcjNwOWp3bFFsTFBE?=
 =?utf-8?B?cnFTTjJCS3lTVnZCSTFLOTkzNlFLajRQeElrUVRHU0dxamlGY2lTUCtzRFJ0?=
 =?utf-8?B?U2VQbDZLblVYdDI5YnhCUk10OWMxK2daNkVLZTFYSUV2NGVoS2dGZ2dMa1Z4?=
 =?utf-8?B?YXM4Z0lJMnVmSER0OXh6a2REbkUyYzBZVDYwL0Uwa1BhZ2wxckJya0dreGpp?=
 =?utf-8?B?ZzRmOThPVVpWUy9YdHFCTmFRRjg2NVg0QUpFOTBOa2tYYWJ4em85elRyTXdu?=
 =?utf-8?B?MEhrNEhFaUoraGFnclJ0blFyV3Q2SStlVWE1Y3lRYTRqdGh0Y0UwaFh0Rk1h?=
 =?utf-8?B?RHRmTGFGY1BYUWxuQndRRmNyR0xyNGduZjJOM3k5dklUSEovVVQ0QnF2b0t6?=
 =?utf-8?B?WmNHSTQwMEFUUmJLODlPaFBWV1ZETFg0dUtjYk8xeG1oOHlXLzlUMGhRZCt1?=
 =?utf-8?B?VDdOSS9FWG9oNU5YdUw3YStIT1V5amlQNWhNbjZjTTE1M2p1M0M4Rld5cjNk?=
 =?utf-8?B?L25FT0lnWUlKcHQ5MU1NZUJpVStMRDJXd2hwSi9pNzV1OTQvOUZZYVdPWi9X?=
 =?utf-8?B?OWJjZFNDM1RtV0xDSU9FN2xSYmMwa1FvZ0U3Q1dIYWpMdDl2Y1YxZ0U2K0Fu?=
 =?utf-8?B?c3BwdWZUTFRBU0hwQjlKRU91dGNFcHdIVzFCOHlaS2JucUJQd1YvY0I1SkRo?=
 =?utf-8?B?TExHazEzL0lQT05KSFJhUVV1aFlvc2hkcnIvV3hRVnNWejF2R3lhNlNZclJ4?=
 =?utf-8?B?K0x5ZUs2Wnc3ZnZkUUNud1pnKzUxRks1Wk5hcGU4Q1NYT2RsNW81NFZJNGZQ?=
 =?utf-8?B?T3JMMDVSYWZueXpzUFZnU1YvSTVyeUNpUm8vRG1Ud2xQNnpXNjU4UlVkeVE5?=
 =?utf-8?B?emFjRVI2cVJubVU1eWRKTFZzczFpMjZITzFaMVZHdXlXcWxQS2kyQXFYZmNw?=
 =?utf-8?B?MXVGUWU4bWx5R3R6alRhWTJsLzM4MFAxQ0RRcHZGSFJHZlR5UXpPOGFMMlh0?=
 =?utf-8?B?eTlLbzk3NEYvVUFIS2ZzWXNqMFN0VjFxaW42VUZpSzhXU2xSWGJpb3BkeVRX?=
 =?utf-8?B?WTVqV3pUNU9OZlVEVTcybmFlcEZzTWZiUGI4TVZWSFl1czdHOGpPbmVjdGlK?=
 =?utf-8?B?am1uRzVEMG9tQ0Jxczc5Uko4aXFoQmRpRnU1RXNUQ0NycUtWaEwxNUg0RTNw?=
 =?utf-8?B?TTVoVFVERkNsZ0orOVJnbHB3U1hYSFlPQXJnd3hQMDVDanRRQVlCMDRyR21F?=
 =?utf-8?B?N2lySEFiVGNxMHcyVFpmRGZqdHdVVThYQVNMSW9PMWRHOWZzUWdYQlVpa0tU?=
 =?utf-8?B?SE1JdVJka2tySDd1aFludUE2cnlkNjlwU3BaZisvMEh2N1pBKzFqODVTRlMz?=
 =?utf-8?B?WFFwQktKZDVuajVGOEZGVFpkdXF6aVl0TTVBR2hEeUJPRXllQTZTV2xCNUF5?=
 =?utf-8?B?VTFqbUxISXVnbERtUGZzMVRwK2s4VXpaWUZISUkyV2ZZT1l1L2I4RzBucUo1?=
 =?utf-8?B?U29EdEJpWE03SXRvemtkeFVQRzJXcG8wV0N3dFNucVNtSE9lVzRGSFplZDBU?=
 =?utf-8?B?NGsxeHh1aUZkL3ZzaWI1SEdtRjBwQm81NjkwYzd0QjUrV2RyVEgwcW9TMEt0?=
 =?utf-8?B?LzdNMUtLeitrb3JZTXhKNzRFTUNnYnRNRXZJdHR0RWtvM05Wd2xodmtqd1Iw?=
 =?utf-8?B?QXMvZmRjT2dJeG9KQzhXZlVrYk50VVlZa0tIWjIydnMweFdkb0VWRGg2Yjc0?=
 =?utf-8?B?Q2c3ajRqL0pnQU50NnFMaDcxZHovR2UvYlkyajdJTXh5VTAxOFp4R1BkaERD?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1620ffea-f523-43a1-b61b-08dd3551ab26
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 10:45:03.8363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwn+xFwaijsrHaB2FOzz0ytKKRlNa5xk4pZmzWJr2QZDcps6dsqVgpP+cvbySFh2TaCCnSRN7HsthIEjLpJQvQLbBY7CwUvNAfzhdOTMZd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9180

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
v4: hci0 interface shows RAW mode if 'local-bd-address' not defined and
    HCI_QUIRK_USE_BDADDR_PROPERTY is set. Add Quirk only if device tree
    property 'local-bd-address' found. (Neeraj)
---
 drivers/bluetooth/btnxpuart.c | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 1230045d78a5..f237c0264e0e 100644
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
@@ -1500,6 +1528,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 {
 	struct hci_dev *hdev;
 	struct btnxpuart_dev *nxpdev;
+	bdaddr_t ba;
 
 	nxpdev = devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL);
 	if (!nxpdev)
@@ -1547,8 +1576,16 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	hdev->send  = nxp_enqueue;
 	hdev->hw_error = nxp_hw_err;
 	hdev->shutdown = nxp_shutdown;
+	hdev->set_bdaddr = nxp_set_bdaddr;
+
 	SET_HCIDEV_DEV(hdev, &serdev->dev);
 
+	device_property_read_u8_array(&nxpdev->serdev->dev,
+				      "local-bd-address",
+				      (u8 *)&ba, sizeof(ba));
+	if (bacmp(&ba, BDADDR_ANY))
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
 	if (hci_register_dev(hdev) < 0) {
 		dev_err(&serdev->dev, "Can't register HCI device\n");
 		goto probe_fail;
-- 
2.25.1

