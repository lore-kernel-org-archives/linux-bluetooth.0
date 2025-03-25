Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A441818A6AB
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917949; cv=fail; b=QQQlXYiMs70dNTRyM0poFLkOuJJJQq67vaK5XKKocSn7N0VJYZ2pbk1+4b17Nqf0HrK7HZuOS11ThrTODomxbr5RinXGjhS7onQxNCbjNfCGs+0s0EeBM3wwf/eZglFgcZdLATqFjtcEwP/uKFcP2kkwkEft5+SBpkOWwny48TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917949; c=relaxed/simple;
	bh=1iEcFtJYfUv7oQjoGkkzxJ5ANNHLxIY9Dpr5Svw23Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SYUTxz+dJ/J+3Duhox9gmoYwjpxUD9Js5XIQa7KBS520NWB8eMHW9oiMFsSSVjDvFEPT5oOrtdXBSuMP89VYPcne9fQoC3nQjnXVZFm+MCWu/nap6fHoBvttBr+t+HUq+YzYZ++USMS64Q9++tQA43rw4AZjdGvf5RsyQx1GNXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dlmjavnY; arc=fail smtp.client-ip=40.107.247.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dlmjavnY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcmuUJw6OsYKLfFc8etIClkgkauo1C+Z6SXMjPFqtojvFOQdHikELgPkNhVs+gbWOG07unJ9YGIfHTwv8aAmPVruBqsIofFhWf8x8Iu/JOgp0VFqa3PTFzAzSa+nFMHRWPAPqPULXQShy2+fz2kcvrXovxDKlDXeNa6yuTTIrftAZKHPUrjVPEkYQCU4cWELJ4QpIcFauM1H3/wBArtKCaqfNNNKdy4WJbQooSbVDtAqRT4OsXo3QYLNI7et7QInvAoJcytRg2wnjaFP4L8DtZfxsOB2/5PZgfxcPFBfxPzQqOBuLjAnW76xAMjRALgYUNlSRu3WB6qLfwYILYefTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xlr1SJDxBi2jcr0wCdeLc24KlSC00nOwKqaagOVmWR8=;
 b=mj+sXRaDa8Fl4Pd/Cy4evpqCeumcP40QvbWfyVGsgi6x/HgVMfD5x3PKWk5j81QoVs29a3fowuOlDFFyACUGiN+dkWDuiZ2djgtblYGSoXW8qt0KXzcxRS5h6RJXq1mCLrEa/OjvH+MCeQMhZB6iS5jHYxhqrubxGkCT1mVVI/9sK46ox+jh5BYbTtbSt4ej/N2OqjtnPgq8/c4pzuLhyIgOzo7nn7jY4iaSwKx10vZlbr49c72moAVTOEuDbJcKVxVv5t7WpG5qhKdpkKDvYpl2BSdJ8ojYGZvvJuKuaE3PGUlNeeqPkw2aH+IyuqjJqm3bot2Ump1cz/KgtswK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xlr1SJDxBi2jcr0wCdeLc24KlSC00nOwKqaagOVmWR8=;
 b=dlmjavnYG7Hr4gNU2zpdSGbPiWIwD7pYJoW73cXhF1UpjTkqj15RznmnRSFybp5XRYyFP4RfQ4U2owT5mAo5FgeMC++EFZoEIt0+Kpq8sTz6Lb6F+/CwS8Fypge6gdSu4Pz69qcNlBkfUi80ng4D8kY7M7lpJiCd+QJ+5Gc1iwZcX4FbEHchd+5aWASD2DTc7kJ6dAN81nfAok2lLlsJUlXvfB+g6SdvfCC/SOU2Aj+no7nIqvWIif1L69wtzlmnW68HTjC1Kn033TBJBXWMGCNv5D/rkWoYY+5E052aMG6yld++Kw3ydaZk2ClmHAmX87ecWM6fdK6J6iz6p4SR1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI0PR04MB10542.eurprd04.prod.outlook.com (2603:10a6:800:265::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 15:52:23 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 15:52:23 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] bass: Add support for selecting multiple transports
Date: Tue, 25 Mar 2025 17:52:10 +0200
Message-ID: <20250325155211.18111-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0197.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::34) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI0PR04MB10542:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bdad73-c9c4-4bdb-74c4-08dd6bb50897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3g58EQicTy5PTlGq/yaIhlmCWHbF/N8kevAc/VnK9SU6CtSsQLwkvRoZkrlG?=
 =?us-ascii?Q?dozh3j90cLPDN+Cis5GFckdCrYBZOuJIx0VFFV0+OxyPg2+UNOkVBTef3Brx?=
 =?us-ascii?Q?0q0mP9nGhek9wPK/i/6yKXkyUZYN7xpt1ydYUx0bMoozxJQHnpBGIymFs1bh?=
 =?us-ascii?Q?Ilb82QqC6u6rkitlC3+pzvNgYkOLfy64d1DcHaRnH3NmTMBks5D9n7UesXmi?=
 =?us-ascii?Q?vaaY9CZr9homtGtId2LoA0faRpMVXxBV2e8n11UOe2wKGc8qKOPUfIMBbDsu?=
 =?us-ascii?Q?SSDt324Vx+JlUGiqq+BvanIb/JftsNOqtFqvr6BJKMyNS1BXfGHdP9eO6IZr?=
 =?us-ascii?Q?rGXs+YjSKTFQF1JUW1E0ogzktlkMNzdyds2vWGMj09mAKNRENUtUrUG5fzr2?=
 =?us-ascii?Q?nctKpbvWtlH5uo+Yytpx1IdWin0STczSK2OzGQZOaJrTMcSMcA5zbClqr/wI?=
 =?us-ascii?Q?BkqCufN4bc1tgY71jWRLiOxOzBLm9CLCMe2TwbpDiIbiNqa+pd62/E9w3Lfq?=
 =?us-ascii?Q?ExnqHjIp/ETdXwPtQkgWmLEyehnT5m0FDgMYvGKGXlUaBqwo5zfKjOx52FhF?=
 =?us-ascii?Q?OH27OmXYZcnAPKv6dSL4vBOjYCurCc4RklP7zvAJrYJ12SMx/w3Te1nlkOTk?=
 =?us-ascii?Q?OwmtFDCGq6UYlKx8sMrpfiVMtkdzH6O1ZXpeKf+4lCvEUZU2JVD7wBKkKY/4?=
 =?us-ascii?Q?Gy+ll8UwVlQ0c08/1bZXcSC5GwTc7s3DH+tD2UC7z0pCR6VJfhvawVVFi23W?=
 =?us-ascii?Q?2DlCB0FEUTwJWb5nNRgVGgZczrciN5S7SSkJ+k54MUAS7pGNtZ7j1MZy26CB?=
 =?us-ascii?Q?XEeLiiN/FtskCRQV5cMPm5/tLhNAYS4kA66eVCTvPkPkdZEGGed8UhBycrav?=
 =?us-ascii?Q?YMSZh6KtmbDpoMmqLLFUL5u4onhunMOcHhfPW3pctfVstTVjtRBIZTunCv6H?=
 =?us-ascii?Q?ulDgfRihqaVZYykFt8vK64+AHIzwg1XF1jZgErCnQWjplzZUfeEt8nWMx/FG?=
 =?us-ascii?Q?z1Gm9Ay5CeduWEAwHdoiC7H6SHQ4pLmkNmxpXr1E7arrED6QbjINspv8ZkJL?=
 =?us-ascii?Q?IbVufaU5C59FT5iYrECZ6gFZXuYqFv07tefbIA3Kipn4sdkBZOR1G7VEkfxM?=
 =?us-ascii?Q?Tgr+Oe0eH26C+KCh1gil7wnEJofZnyjc3leM3seqoaZNV66/MsxLPcXmwN18?=
 =?us-ascii?Q?gU+PwjYPA2FfMCjOG3w9XIB5gBWZWPU0qpLL9lCViaNYlEQydrcKV0ycu6e+?=
 =?us-ascii?Q?iugRMXZShv11lyk/IboqcGPsLQPipoWKROXiLvDdsOsMNnFk8IONIR1VpJGw?=
 =?us-ascii?Q?rwUaIUjg+Cda3kctIJ9ElbGLBtNr2aoKp7esGgyf50XiDaypuf7AjSitvka4?=
 =?us-ascii?Q?j4GDSlDEzUXk/KLbs4r/mAQUM0nw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ho+S1c5lxliPBpbvxggnkuNzFpiZtmkwnK3wQwPeLRwM4k0/gmVeBei+3876?=
 =?us-ascii?Q?zjCw7USN8w6K9V21m3ppk+w9usp3aiotaduAzFETJ0J1XlorLa+DzI1DSBmM?=
 =?us-ascii?Q?aPGjjjo0qJoL7ncXCwpNyrmdQ8Zq2fV7l25d/utIdM0ozbP49oqmyDRm/nW2?=
 =?us-ascii?Q?dUtIDQZgygUqEa6WVWBBHCGxmdvGEVU1+rMcTDpwmufsYtfDv95S6JTS77Z+?=
 =?us-ascii?Q?op6vhFEP/HF1FMvKDMmGLXnC+gFV3tZFU9nP0M7nud+TX+Wn4B45NaOxu7Xb?=
 =?us-ascii?Q?6Lgakz5Z3T+PpJBUsaQLMiWGIFfSRf6hHTTJYfNte4DDBvSE8Uoq8AGB5HYz?=
 =?us-ascii?Q?k103Ea627ADaZwYjIOR1dlebQCtcCKt/wxFFBfPhzORchYOrB6WOBAQNfWcv?=
 =?us-ascii?Q?vubrGd7yAeWE4fs+8l37QcgSl7L0IMOy79av7vmqRrwY9b0wJsMHkykXOoZ2?=
 =?us-ascii?Q?Pb+n/YolvPB/ekz2SBYb7ATp5LIK/8tNkAUpWQLdVMv7SBREeh3eYI7k4TEU?=
 =?us-ascii?Q?34JUr3Hh06uKg8osjUZ7M34RhDkQs2L0qQHrTYJsKQiqkfpR5Z0W69Tj7k4w?=
 =?us-ascii?Q?z/kSQADM3n7JRdoPVpIMgJmImOo0LAnOjrjV3T+WHreCb7kK0o6fjdPgeL3Q?=
 =?us-ascii?Q?k2pC2zMukBjyo5+9clXknhbh4wZ7zT3PfIPUbKagebqC7TfVYd/A21eMClFj?=
 =?us-ascii?Q?LUV05aTfAszLibthNqBWuJCpiHA9PxcbsawbeA8dTPgXyHxkWD5nbF4SGx2r?=
 =?us-ascii?Q?fvA5Ua3ZnJIVeD7djLviOwa9YbEJq5ULWEHOpRjpbKLj3CBnWHXluNVUTPAS?=
 =?us-ascii?Q?RPWqGDhVHjeqMMdFmH56JYneLloGF7mT7pcTJrll23OEocveTLQoLySBYPlZ?=
 =?us-ascii?Q?+TZDWMnD1v2p1/wawPypRIOVYbHtEy/MtbWaIWQvQHVp1YooRM00jPcSuq5T?=
 =?us-ascii?Q?22TposyFkBO+mMtBPbES3sQOr+s3uSZDYf0qHnASmp4yhH23a5EjUGakZ3CU?=
 =?us-ascii?Q?yGeHrIIgS072xvoG2fmq81ZemZTitKaLG4dvhr4WSBEn2WauYIUE9YQEwi14?=
 =?us-ascii?Q?7+ly6TyhKn21ToY0X+EX92ymmTdqv7LlA8yGeC+5TPKg4eHOJzIFZsaT8geG?=
 =?us-ascii?Q?DDH7Dt2G3cE+IL0gAQNjgH/YdGjtNP9x6J71I9hiryaL3FtdWMUvRgSYLxGb?=
 =?us-ascii?Q?gXnFj4Bd4s3wXHoPAgpTKpKCBOk0MWzo1VVrBD+U8TxOA3QeZYpauJrTtRIt?=
 =?us-ascii?Q?X0gaVFbR4yAE6jEWHLXKYMBuiTrFtGKI9Q3XozyNE8rHSXbCgelaCNoxVQS1?=
 =?us-ascii?Q?HWNc1zIruvEOZzZS0GzfHA0VrboxIStRWmAoYHT4xgkXfVJQZk4Y69l27GGH?=
 =?us-ascii?Q?eOJO+CsAz731LMLhkEZ4UXLFC7wBs6pUkREOUeDmubWfhMr9oPJgcUAyVZYq?=
 =?us-ascii?Q?Np3ThpbWmzMbUjIM5+wtfCZLltzeE+D5FXg4Wd5+pY9NejVEwHe+axq9GDey?=
 =?us-ascii?Q?cZpP5m49dwk1EOa3QeU9zHdnFJPnkY/vDM9kt2S2tPtwy4auUL1zjkvh7fG0?=
 =?us-ascii?Q?U0pOS6vQelfyCosafIT+6u88GmijUsiLXCIqUIuyBL5nmSyfgmFTsraSvm9i?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bdad73-c9c4-4bdb-74c4-08dd6bb50897
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 15:52:23.5070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEgEKHU7h10m9ISQ4G8588O8cCDM/cBXV4lpIBlWfoN94Yl+HAbQ4FpqujE8gau//pQ1CtdCh+MhGuYxf/DNuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10542

This adds support for the BAP Scan Delegator to select multiple transports
added by a Broadcast Assistant and to acquire them one by one to receive
the streams.

This provides a fix for https://github.com/bluez/bluez/issues/1139

Iulia Tanasescu (1):
  bass: Add support for selecting multiple transports

 profiles/audio/bass.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

-- 
2.43.0

