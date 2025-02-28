Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013038.outbound.protection.outlook.com [52.101.67.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A481EF395
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758223; cv=fail; b=KasaIBET1hiahdb59OHz5zyQqStQWjI+X3VH+5i7GvEIT+XmZMxwlzmAjaNnYThnQpHNUL369JHX5WNOGK0mXB1LWS6cSxZZCQWkM3bORf6K/s3wwaJyBzi7yyoMQRdwjqeFj2PA+7vcj02FvAkNVIie7Hb9yL4xtJc4xnHo9c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758223; c=relaxed/simple;
	bh=LizF3+ePBTbKm37Mhi3j1z+Vj15IwpfdlXhU8ArJlpI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UZz+75wHYJ/PprzTwEhUY0986wRQsuA7UiCDkozveIdjk2aeZFdhOE9sxmHTHuVZ71U60tiSKQQHUXczU8L6optgMszgJjns6vvHlDK1K3rmPIcggl7iz0iXo+tY5sC0T3u4yWgBcIC4eTvupju+NTRm0jgL0LTQr1j5fG87z04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mfTLiBxE; arc=fail smtp.client-ip=52.101.67.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mfTLiBxE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwaUxXzGcbSdbmwbNBH1guTcq/JXcPKfQjwOfwXiw/29of5uw5HjvfkgCgcQqVaOofh4eEvJ3llvSRD2+W/7PgPwVdD69k4NQQhPDosnrJlopI0DI5PJxBWEZbCTLEVgQ6RSp4WaM4Sv/gLdaM1KDoSj4CaMQ5IY5qUiaph4pP64DX4+UodnZm1nDAmsn8u4NnwOMxcJS0q5oularqpCVIU6m0jNoKFRjTE0r0TtJyIldpBkBP6EdKpB8NW97mTUy/uWs2RL6GLGfTYnQwqHppOabUxP6QnX5CSFgHEiNjTa0Advn/fxM6CRsknd2r6YA/BN5Pb2eoqRc0Ox/pZ4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjbvlBYaPB05VcOeJGg5X0p5ZqMz1mSdkT3FshdX10s=;
 b=GgNg3oKW8X2nCFlxIFe684E5xl3UNTimK4gVkPL5PEHi/44Mikw+GmMDjkkhwcDvkyRN6QDiTxjXg5B/Ccfv0FfBYKZoDjsuouFuhTY30t7W/mokFvq0XuGy0fIKulfPNmgQIoFfgAYE5Zmx7TTK/qrrSI2wskuMS9MHJHSygqU/xElCRGXKaVHPchMAnYAMzM2e06/fEiMsYhXZRTIWJyncgLRTOk70+8x0iS6xhkz4LfjrNOwbNuEmh5W2aAI2AumFHmkL5tnN3BXccbOTyOb8SAlfUU+7gnyOWsk+omqDWlNeRlkA4pvMsLzi9Tro/i+K7OXpai+L7NScFPmL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjbvlBYaPB05VcOeJGg5X0p5ZqMz1mSdkT3FshdX10s=;
 b=mfTLiBxEO/F2ziDtE6QkfqwUTuTmAEswd9PTMB6BiBg1RZ5Ap9UZQTjZO5ZqMJBP/1Ewwg7FomLFksrTnxBOFead1YQRhJlSJtDXeJ+v3ILrwPGdRDNpEqLX9pHMpVBHipNP0ym6jG8T6szwduvGqZLeVBYPiitxHG+etH/fTGcR6QZaJVMTFD1jxGGyqotlYAVyHuDGstsaal9T6xm+UnCWzinKdDrCHTACeU+5daQy90EJHCFJJP/hPBvMqEU7C0lkTwkspWrUJU6OpMYBKhVjQD27XieERUv0rNaqeoij/fVyrn8KRl/CJ2J8HgE+ejS9jsYP8KWUBJFIby9k6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 15:56:59 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:56:58 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/3] bass: Register broadcast code request callback
Date: Fri, 28 Feb 2025 17:56:31 +0200
Message-ID: <20250228155634.57979-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0106.eurprd04.prod.outlook.com
 (2603:10a6:208:be::47) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GV1PR04MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: c8177ecf-2357-45fb-325e-08dd5810882a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sRy48+xzMCsi1rLHxNql/mAkyBXDuncTg6tD8xUv3YWVO3uWaazcvHqvkxkp?=
 =?us-ascii?Q?MByw4Ew84HuwAMb7kMyzxlSZndJcC3A/MlbMDpzfN/gC34OyIn1c+MbkhQ+3?=
 =?us-ascii?Q?F6swbcp+9ESFMES4kaiv5mRXm3x3Y0ENGrEdEF6Cxkt3Yo++AUdI4vJ1PGWA?=
 =?us-ascii?Q?szMBi5IFWb/xB0/YK3wJM8xedDUAQHbPc25HLpfa9aOBRIJ2mlrS2tCdbw6S?=
 =?us-ascii?Q?idtAfe2SXyTmWGzg/K7IHV7Ym56iC3bkvKisgiJbhtRqemjGFh/P5KTOa87F?=
 =?us-ascii?Q?Xgv5W/5yHNhjpQY9vHsk4X82Ul9N3z8P1mfNEGN7CfRiNi8NPc6+khYNcKE8?=
 =?us-ascii?Q?exBR3s2lanfOjcXNyR1mhEucm8/KPHsy4USR31eg7uS8lFkcZa5cGqJYBQBw?=
 =?us-ascii?Q?TZr17kn8HrP/lDtyqtOKgTpsF+3HvkpPLE6iWlAxHspMJ7r4HeOhYAoj/eYX?=
 =?us-ascii?Q?zJLyecbg34xlBNUIptSUIq0OiLJbJbTRhYNMm3YAJpQZNxPVhRjycjihBhUm?=
 =?us-ascii?Q?Pn5RhAHBGcY9pr/0EOKTrD+2BQv41Bj9Yr7bvkmL4SKvMA+oJiBx2F/ZAoLO?=
 =?us-ascii?Q?fTBYpcc8rWeMprTBc3w1rHu4vPWPH/4H5vw7IdJrz44AsCpjvJ+ehIRdUxQ+?=
 =?us-ascii?Q?51Qo1MgUHZmSetFU6DcV55Sc46cj3DlSoK+ez6qIbnH8U+6GkAuhrsk8dmKD?=
 =?us-ascii?Q?ZAYtK5hkN7nKi+tJPjuY8U0YAh4pARLg+NHyqSWPTt55wbcsLy0S+Pq2yWCk?=
 =?us-ascii?Q?Wl/VmGlDAmervzRNNedkUc38BwCGIKNnLxamQWWtF8TZ+V7lvMvb9Z2a2mCS?=
 =?us-ascii?Q?P785HhY48l2LRKKpqK2L7cXdds69B9teI6Sg9lpdVoJr9OuoSFCGfZ96fDn3?=
 =?us-ascii?Q?4krqayHsy5GvUNJGTi7iuJvzMUrkARqaKEoS6lb9cjqRiDv2py5YsAOPBgMu?=
 =?us-ascii?Q?osOVVdXa8LwYEZ9rEd8MHQMnHhUTJfojsL10/lObXLGBfI9K0jM/r9GE7lSO?=
 =?us-ascii?Q?TTSyb018oa2DsYEqiCf2yMORLsZDDG5s6B4KW1NI5+/b2SzINVZQJ6hBphwS?=
 =?us-ascii?Q?ILJ7uGfJ2l2RsQdJn0CVmH65KwtdOgQBX+Eg+gzuXe+IYEJqvomw7X6BhvVl?=
 =?us-ascii?Q?8sqQ1LkQ7nRIEpkfr4GzD5VPee1Z23ZSxg/R70ZXklZ40PpBkPDQ+0AiSeNz?=
 =?us-ascii?Q?wiDiEXRgBWVptrPC0xt7pBp0xK8ycylUnTbiVpPdS/xvCXV1/spz/ewAGlxA?=
 =?us-ascii?Q?g0IQfIJiuNfG0jJ0prCQ2DcarUJy2521nMV65jXGCyyNe/Ksyex5oOZ0gPgA?=
 =?us-ascii?Q?atWjzRMcmnGhD+8ZUMKLIjcX5jPranlbz5xGTrsjshQJnvAgTQbSREUtqafl?=
 =?us-ascii?Q?p7CvzWTjSu8q6GENg4BASTx+3Fyi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?azVYkaTOL9AIQU009f5YI3uR7mTZQDY22ub1hhgEGKbH73uvBf82ICd2XwlX?=
 =?us-ascii?Q?W3BVaOVVnX8r37GIyUbysDgf6HfZ6MinENnoOqtFjX5pHtBKPE8D7NU37+o8?=
 =?us-ascii?Q?9yXOTm0WBgLrBFdAV+BIxcownfEGQKey06kn8u3WV0qkkX/WqBkeI/3ChJ7D?=
 =?us-ascii?Q?Xg0U4jsyJ1wAVxkamwzsVI1gMjBQMVxlAvKqFblQJ5poxV6BdP2tVtSwZ16f?=
 =?us-ascii?Q?0cnUP7tX02/CzYNT14Rt5RwROyrU22HxE4f2t27/TRcQBN0/po9F1R3TLLpz?=
 =?us-ascii?Q?cWjx+VHJzn5jvsG7QfUOo8gctFja+xRkDxW80bFc9C4gXdIPsi0dHVe0sWZg?=
 =?us-ascii?Q?EFrkx1sPSFCZjF0fMo0N8rundHXur7UAsRcY+xIgSvzr0XB4wp1QaJEb0WLY?=
 =?us-ascii?Q?qFpyyHDoQkn8OOvroEQAnjncAf6HmpYndOv158ywwuJtiREUcYvmzLrsLJk7?=
 =?us-ascii?Q?tFnnFuN+LDPXn6M28NqUnTvWhYHwvJowo7dMDBot3qjrYQqLSfZx2aze9q9t?=
 =?us-ascii?Q?XLHoImBtjnKXjYc8oRjGbRjnfRgPPJMoJ1/BsM/dcGgWtpzop5VmCCIqYKZo?=
 =?us-ascii?Q?CqDPKX57NISKJrxkADzIJAdchKRw0NMKSTxZzIB/Z+WXPauwVmeUlMwoMNwf?=
 =?us-ascii?Q?HsJFrcwzLrcOE1Jap+2XQ5BmbmHqcxSBF2XLHiXHemvF1wHbMuGU4XryZKGI?=
 =?us-ascii?Q?ZAbMMPvE2dtMCs7ZPxzrC25G6OZTbvNAJuubnnJfQ5KunNO7mQn/abPtmq3X?=
 =?us-ascii?Q?9jLAmiTFnH/C34jvXDSFsWiaXqklXJltum10HBZwQ4O6KvOs/TDTeFXMhxBt?=
 =?us-ascii?Q?5OfCEA6tWdjt8c5t/iBmFoAk6sSbjoNHDRdLNauUA2CFvyPqVed8aTbMWX2K?=
 =?us-ascii?Q?x1WM9Bb94qqhJVdi1ytMSWyUZOW0YQX5FtGJcTA65di2emh0Jh33jGdGfCMT?=
 =?us-ascii?Q?UvILFdAjL9nzrUw2m39kBSz5ML+ufOYXlJ5gCeN/lS/Oejmrss0OxNGzTgne?=
 =?us-ascii?Q?TJhP6QMoQdDLZlHtoZIbRQddFjna2EISgnLZLWglmazIJgNbWu8+osbT9Oeh?=
 =?us-ascii?Q?EDlaet6QmMSAkQxhvLoFPg3KzNdlIYnfRMuyY77Ani1NpVY90LUdUniOGdeT?=
 =?us-ascii?Q?JI6NArxkAJVDk2mTSSww8LnT8Axmm6jycA1AGIIOm/HSIGKbIBMpjWh4UIrg?=
 =?us-ascii?Q?orRphOFVGn8hC8qzNgXUoG69g9bi9GpWUxB3JMFfpdXyyxX6B85WrwfpYRC9?=
 =?us-ascii?Q?IHSn+/7797fnnTycxdrlC0pcNqvAeGA2KWsPsg98HVzLc/sPieu5MBxaJsuF?=
 =?us-ascii?Q?W6L4SngO3iAsKiuFfFK0wSPWQIxlEjw7cSyZxYdUxCrn3gVqZJqAPSl2Jrvo?=
 =?us-ascii?Q?20l4Abuu7jI6/fcw7WERkWPgIjUI0LrVryJW0+sHYjhZ3q0WrwnSvXG5UlKI?=
 =?us-ascii?Q?o1Oq6n3gGdRc+M+CgV/M6G8x6MPjmpfaZOk/RmNVDWa1dV6wyJg8ldnVHluW?=
 =?us-ascii?Q?KAg7tHblpZUlNYLI9OG3iqo9nFZRe5IQ6q5yq9c3a+JAgBq91rnt/r2Ltj2f?=
 =?us-ascii?Q?P3KAU3lurkdTK2ar5TOmCRoH9uCK45r/tqWEqub4kAQ7k7Q/fV8M3IhIKZBl?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8177ecf-2357-45fb-325e-08dd5810882a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:56:58.9254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bo8Gda8xkEB95aXlKw+cUWijV+NvQ/+nZqchE1aKxQWJgKn/oOf+1CKZCJUwUOIj68QcZ05lNG/fIBC2Y1C6OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118

This adds support for BASS to register Broadcast Code request callback
with shared/bap, to be notified by the transport plugin when the
Broadcast Code is needed at transport select. This is done to avoid
direct calls between plugins.

Iulia Tanasescu (3):
  shared/bap: Add APIs to register broadcast code callback
  bass: Register broadcast code request callback
  bass: Remove interface

 Makefile.plugins           |  2 +-
 profiles/audio/bap.c       |  1 -
 profiles/audio/bass.c      | 30 +++++++-----
 profiles/audio/bass.h      | 14 ------
 profiles/audio/transport.c |  5 +-
 src/shared/bap.c           | 98 ++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h           | 17 +++++++
 7 files changed, 137 insertions(+), 30 deletions(-)
 delete mode 100644 profiles/audio/bass.h

-- 
2.43.0

