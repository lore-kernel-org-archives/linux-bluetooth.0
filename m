Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2122.outbound.protection.outlook.com [40.107.20.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13613C9D4
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738664210; cv=fail; b=mdyXVSsrpmxEqzkMAH3VsxhvRljamm9WaNK1kFtoCiTlugPlxnWi0eLSzV+3Py7T2ZG2A8XRPHW1ZeBBYUlar5bIsOHlFoyts9OtPMbnaupZ2Vn3OPx6dVfYk6QDjTkmeHxBSKV3EBOthimnEg7E8JBcFYKELiwwLCM+Boezacw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738664210; c=relaxed/simple;
	bh=b12hKuD+uLth/YWwvM+8TBDic8+On5lS8jB/CmZPdaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uW/URTlwlqniMvP6fcSLOZojBybRuKBUVh5emj0gIgWR3uls5CqS4kW9Xw3C0SmcKQr6s4Xqu1JuPB0RlIaFKasoDkhmS0R9ceX0nIM48A60kyojPMqnRv6dZ1AaRO2dBK937lJsgGVYJPVoYCraEZ7JeA/GBp8e6jleRgpz1a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shsconsultores.es; spf=pass smtp.mailfrom=shsconsultores.es; dkim=pass (1024-bit key) header.d=acshsconsultores.onmicrosoft.com header.i=@acshsconsultores.onmicrosoft.com header.b=VrPI0lCa; arc=fail smtp.client-ip=40.107.20.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shsconsultores.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shsconsultores.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=acshsconsultores.onmicrosoft.com header.i=@acshsconsultores.onmicrosoft.com header.b="VrPI0lCa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIteHLbxi0ewDtMuLGnguaSIvKNOzfUGs2wSKEX8v8jI8Yt8s2yS7dlQnXqCFF5Egld+YzBLzxW8naUrqOhHsGhqUzKhTLaFBPAEHpOH/+wdpDMfUp/EQuf4MKYomJC/EgYs5NacvQRHTKPR6RXJ/7MKKBb9aQNIE8JovL9p4trK57dnf273dhp5DxtMPNK9aCCysxR+OgAnUVZ8egRQikz2CTzn0nJdR0llR5nhQ5lnuTZLrrX1aZrPfoNLHNjvTM7ds6xX/RG7/deakiCcm131elc3hFRSKmEX5k8bH5nakZh29oaT4W2NNm4A30WmbG/QBKMpkAoaXDcoTyCQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzFSft6qpDv2J1nFXIZg9k49Fx5VWor7POqpmoqte8c=;
 b=ok6Zq44krtJWJSQ4qN5TDYdXJQyuyBTEsIPzndpe5dzvhi1GsHuZVxWwPUm02pxVVf37P9RFkXXVtxz2lwBe4ZqcsnFgnsdhlSvFDwoixheLuruQHuP5wU35HcCHEroHMHNWUkGMkUaTeQqaLzG3NGp0SgQAdnoAmmSi6MLRjDfwGf8+orfO355MuMye1HY+ZFkYWXWti8o0KAH6JBP0gDWzCyXHn4Lm7ZA+KCvfY56cRIahmZfbAMbw21FFJPCtUxLVdECjWW7/9+WwMPyMfZlko/3hlOLAH0GQjPF9uBaGuynCSE8Fh28/+6Md3l+qg1HsAEAyHFhHOgsIjLnApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=shsconsultores.es; dmarc=pass action=none
 header.from=shsconsultores.es; dkim=pass header.d=shsconsultores.es; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=acshsconsultores.onmicrosoft.com;
 s=selector2-acshsconsultores-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzFSft6qpDv2J1nFXIZg9k49Fx5VWor7POqpmoqte8c=;
 b=VrPI0lCah3x+jjyvrwwtGYu5u4A6wPVK6VWwR8aKcwW85BPsR6GdtrRACUk2+2bB+AXoj1DreiInF0LbmSzX89XE4d4ABIF7jcCJHJ07qZr/gM8z+Vezq+VJpRgGO600YUGygnPX0/8V5MLZcfo01QvP86aYThHwRdLDgVUXrNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=shsconsultores.es;
Received: from AS4PR08MB7653.eurprd08.prod.outlook.com (2603:10a6:20b:4cf::5)
 by DU0PR08MB9912.eurprd08.prod.outlook.com (2603:10a6:10:400::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 10:16:44 +0000
Received: from AS4PR08MB7653.eurprd08.prod.outlook.com
 ([fe80::fbf2:7802:4c0c:8197]) by AS4PR08MB7653.eurprd08.prod.outlook.com
 ([fe80::fbf2:7802:4c0c:8197%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 10:16:44 +0000
From: Pablo Montes <pmontes@shsconsultores.es>
To: linux-bluetooth@vger.kernel.org
Cc: Pablo Montes <pmontes@shsconsultores.es>
Subject: [PATCH BlueZ 0/2] Fix Ubuntu 24.04 build error
Date: Tue,  4 Feb 2025 11:16:10 +0100
Message-ID: <20250204101612.66823-1-pmontes@shsconsultores.es>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0080.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::13) To AS4PR08MB7653.eurprd08.prod.outlook.com
 (2603:10a6:20b:4cf::5)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR08MB7653:EE_|DU0PR08MB9912:EE_
X-MS-Office365-Filtering-Correlation-Id: ae45688b-83b4-4d3c-bad4-08dd45050656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JNTI5I7zIl08MW4W7rY7uXgAHhtmLBF9vNJAKrE1W6UgMq+brcFnErtQJ3Bv?=
 =?us-ascii?Q?1dlD/EvEHScsTk5ZGCWGnTDoRX/zc43Gk01MyVWSIuf0dYqrHUb95oHK3RzL?=
 =?us-ascii?Q?FgRdYwfvcrdVQf9l8CHp2ioTlmcwyFVJz1wDS525cD+pb2LJMEHGbtVwZ1Eo?=
 =?us-ascii?Q?m94zZlF771RRAAjR8SE729AkaVLt7OX+cU1FPUPLYlRPgeoeN+dwc3cmQeJx?=
 =?us-ascii?Q?8/PnBQAWuVP1NKUNr6Cxd2Zf67CjD6GAH98E+POD76Tp4dfVd/3awB+YKGL8?=
 =?us-ascii?Q?gmvYEl3ECswAmyDzQ6iBaNT9wlPENXLTR2HNNF87XurFnuM6NPon84laXNf+?=
 =?us-ascii?Q?+CEHIsFf/xmsCpX56gYKhpz2dSO7vZnIr44vBE1As2ka+swBXPWaD0VUtBdB?=
 =?us-ascii?Q?EY40Jn0CDtKFFfry6ueS+rqs3+rb6omuyO3Z3T5dJOglLopVhbfmb8yvEvCP?=
 =?us-ascii?Q?R6uscD5F9O+jUwZWNSehMvzb58VUpvuFzqEZhXSjx2WS1VXld195TSZ2ZvDd?=
 =?us-ascii?Q?QrlomycnSI9niYyB9JrmK6gZgD6N0YjDTzd/3tt6koEOalOAfvPVI6RwdS5K?=
 =?us-ascii?Q?DpASfG7fq99I1tywFTDFRRf9sieuTbL/2U0A20dfPBzoo/YUWoJLwoGuFYC8?=
 =?us-ascii?Q?8IvIjy7L0Nwf7rbblMEXPCIllV44l8HHT5DlF1HRESBgFeNBqlmvDdibxA0S?=
 =?us-ascii?Q?ApqSaO+GSOt2epsXXA1RFhvrr0qrNULO8DauMRn9J92pgbkwZ5fQM8J8wnUt?=
 =?us-ascii?Q?D0lD7VcBSGQbJ/KLg33ijuyvUIQtcLsGAz/O11arq/R/e2RIW+y9QTPXUH7I?=
 =?us-ascii?Q?hO3VBq/u+tUA0t/dSqbrrDdphaPWcJyUssuUrvOhQD14cHDAv2vKOacWbOi3?=
 =?us-ascii?Q?0N8j+R9z4GWH9M2nWTnxFGybDgrJDjWZ4EF4PTb3nBa4OFkyGwg+j93/jSi1?=
 =?us-ascii?Q?g/XRqtpfp0h27tClp3rKxGE5dMIFcqXmMxKAquHNbYamIaHQodvrpUCqDDE/?=
 =?us-ascii?Q?s6En5vvBypcQr9MWLR1L/xRxDPSm58Wl3Wtm3HcnHw/MZiUx39a26cEo+Xe2?=
 =?us-ascii?Q?ojWdnBOwZnbQDBenAKHhumpmtrnYdgIRTwTZTpEe66qidrEMbAM0vBVfggk4?=
 =?us-ascii?Q?+EMWaH/MaOrNx1gAtZe6vPNcnWeKAE9sFEqyIRhnLcCVDjQfamEe7NFbGkOa?=
 =?us-ascii?Q?ir7PbLXmncoxbjj0kauDfKZ11nn7RwC+ZFNmGSFb313OdIqUmtPRRv4VqZYe?=
 =?us-ascii?Q?zF97ZDfJBTTqgt7QWm1r02fRFitaBgAPTrSuInO8QD9GACgAD9I3zcMmM9u6?=
 =?us-ascii?Q?BSPEDoVtTYqg0DcVL49y7AXmxsynecGNwDFINSUmPeuc1YvMwqptZmgFWGwz?=
 =?us-ascii?Q?A3vXaWn8IYryEyq1GhgVkbAAppAoh95adKjHyjrPoSi+mPYZPNKyuJnRgNnb?=
 =?us-ascii?Q?COpmCGNpfygZt/YH+R4ta+/FU1oFVxHm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB7653.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uJV6sOnV62mAgY0B5YhFa5KDgfU/oFUswSphx3le7ijRniOJXzAdFxhdrJV5?=
 =?us-ascii?Q?9HgrkB6Bgj7x6pDU9RbHkuSg7PIOsC+PWYiWO6zzaL1UE36w4eINr3qiasCa?=
 =?us-ascii?Q?qFSH+rwYoAXchI4u2gCppPrvd4IWtUNAz7lxlJ/Uy6d+t8vHXR8KiLUjNbE1?=
 =?us-ascii?Q?XbxvX8DLUlzQ3cplfOZHTh3gV6BKHxz9OtbV/jD10TXkJ4kl6A+ZblHZdfHt?=
 =?us-ascii?Q?BPfW+Sf750usOD6SsrfpXBoCktALIcnGV6sw08VaPyXkX9LbfDu0pEiFP/7R?=
 =?us-ascii?Q?LYSilyCu7/h/ayVAtg4+pkgEHE1QubF1RUb1fzcayJKqMGBoKoS3XAWCVdUh?=
 =?us-ascii?Q?vEY51RXVgFssxeVZ7X+IoLnkqfnxgvIPh8+cSyb1d3y0iLZBpZXX2vg7+fRh?=
 =?us-ascii?Q?1mx3FSCNB2myaYCDJ6gXs4NXzG2pIxnm6TOkAapNXlF/y3EUM4WfuJ/vJEmb?=
 =?us-ascii?Q?ebQW++L0mQX2uOnaKpgFf3rMdqkt0jb+R5lsGi8y/Z9D6vf4ib80uuNdpfB7?=
 =?us-ascii?Q?hvd5ENgdBtdj2FQa5fZZop/7Q/hfo2RaKMRHJ3bDJZAxEMB/Gttjq6A0WqR9?=
 =?us-ascii?Q?xyWYgCf7YQIKBciTsGKYmGtVMsaf9rVYzNnYGX09kMiEOvJ/O5DKPufmhEgP?=
 =?us-ascii?Q?S0Z2xl/dg8O1EemkWcIabpqZttFvIWSz1bYCoge/m25iS2dqKuZI4YTDGOC8?=
 =?us-ascii?Q?sSJICm0bPdLshfMbCElNvwOZ6VyXtVaWaODkxHxN+FH7r2bj4mcO1GufY6P4?=
 =?us-ascii?Q?pAjULsj3FZxO9cmVV6Tv4uqkx8qPXIxaJgNuk26j+tA0rQdzTw6FuCi589hb?=
 =?us-ascii?Q?63ZGOHLN+FBKNHy/1iXuaNa6LVHqbTSzDdX8HO+sQIhW76K7B3uDfDqUtcsW?=
 =?us-ascii?Q?1kpNih+tDy0AztZjeF08M537vyW4sdRfUWpCkZQxv0mdfletjwtNXl9NTfB2?=
 =?us-ascii?Q?8rD5iw1AIh8Mxe2ObtKmqZvLvdNvrnnetnfIIyM5VquetvL1Mf6N1JbPTSxK?=
 =?us-ascii?Q?2HLhgfqbPjOExt0EL9f0PE2ky3+oxXRWmUmKy5/iLsIz3xi9lt+misC3IetC?=
 =?us-ascii?Q?h6T+6ChYnOifWpleldIzMS07OskzFCFEM2R2mPGmfI+ZYK9w+P9FyAb2cQjR?=
 =?us-ascii?Q?uE7l+Ur+NxG16O6bxgW1Fgq4QrY3r81VCOHAvAA6QxlFWvFZADfOegDv7gqx?=
 =?us-ascii?Q?CdHQ5mZNiwbTqqDP5zHv1lWzKBYlGn0uqCXzb4AThmFMx/M/K8j+qFw9P87g?=
 =?us-ascii?Q?h1RyK7zwN/Hl1EAY8TcQGJC+Vj7JbmhBuQNoLNX6ozza02fWLl4BedJrl+OG?=
 =?us-ascii?Q?twkh0NumSJFMn87SZu1udUkNJgWaoQZMS7r13ht+M6j+5Rme6YAQWpcMxGe9?=
 =?us-ascii?Q?LTzxonPo1l19K3iEMlkHn5gRbqu7ruSeT9rVUjwa2n2UVEhikxNKiqEgDKOP?=
 =?us-ascii?Q?3aowv7RDsxL9l3KltM+fFNDabXlAJm4kH/HzFKHWIxsJGG53Wyul/8SpBWaT?=
 =?us-ascii?Q?bgaxwnvsD8OUTl9gS6g32kVeYVrBRPSeva+FOB9xZtLFjaQezRR9og7iLPWI?=
 =?us-ascii?Q?hkwq49klezXNLbThNWbT9UyULIQzVcgIGWdXTvj1Xoui2YHVhwBEn5+3gUwv?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: shsconsultores.es
X-MS-Exchange-CrossTenant-Network-Message-Id: ae45688b-83b4-4d3c-bad4-08dd45050656
X-MS-Exchange-CrossTenant-AuthSource: AS4PR08MB7653.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 10:16:44.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: daf9f132-b852-43ef-bd93-64da5b8621ee
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XraZoLYnagzMRdg/56vOz2j8WfjQtscadzUIkD7licGw3UzBIcwePscz90c4GuXe9FmaDpJjJ5hMlwvJA8UNTcF6EXayoOnXv6IwG0MUOBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9912

On Ubuntu 24.04: build warnings for buffer read overflow are treated
as errors on emulator. This may be ignored with 
CFLAGS="-Wno-error=stringop-overflow" but discarding packet if offset
is greater than buffer size removes the warning.
Could close GitHub issue #1049.

Also I lost some time using mesh-cfgclient on a fresh Linux with no
.config folder in home: mesh-cfgclient failed but did not explain the
error, so printing a message could be welcome for others.

From instructions I read patches should be separate,
but I thought the minor print error did not deserve a full patch.

Tests are OK, save test-vcp which does not work on master branch
either and it is not related to this.

Pablo Montes (2):
  emulator: Fix Werror=stringop-overflow
  tools: print error on mkdir

 emulator/serial.c      | 11 ++++++++++-
 tools/mesh-cfgclient.c |  4 +++-
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.43.0

