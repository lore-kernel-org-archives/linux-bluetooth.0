Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096FB156993
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722859492; cv=fail; b=eA5piUzFRjpOYN8u0X+IdZti3rpWxeEoNlXRWC36iYZ0lNwt5NI0COQL263nEwRBV1y62aIORyO4ZuADnzUh360I/yymuGS+bvXqGyh3y2iLHjUm19qg5hdY6FmTfH+53j5tC37h1+Y/fUASMDZHZRnIWM8yEO2EoOnSGg1ej6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722859492; c=relaxed/simple;
	bh=bADFmirTvQUC1e9/Wp2C5pijbT+KBU/vBsh8GbgEmMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tfBbPJFyGRUtleI8q0MGK1LEbXp1BcJlNOxVg0vrhHklGMhu0QbNkTnX1z/QNge139Jth6DQ5M8OC7emPgEn+h19DQYx21XCBIZTJ3fiCGFFiAg52vvtSb+NKU5jp6vS1ahsgYJNZuonqx+jWFUvPy08kdRt/l1rra6sq1oud24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c19rGHE1; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c19rGHE1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZoHuixaS4bx6aOG7CGRjY3mXep4Wnpoi7/oaNeXEeRI5rilGCmihlcKCPsIGjU3m31km7mz4sVNeD7WxmhjblVtUOueZBn68OukOqrbkw/6dL4EW6vD//p7cFPSH9K2rBlV+drQ+5/DQPL9A+tenszdJlqWweK0GKKP/z28wG6u4WU0SEFP35h3fEWGQ69/h5o2nNOvcVs8gC0JhUxRV/UUXxrsOVNouJa7R/4FkfYUTh6lHwnrw3473aRGpBaxY5MLPVQOrezrQgNVUMIrfOY1oUzhNmj8uR8uWMARai5LLRBCvctbs4WnMv8tiplzLq+v2veBOejBvFWOFtIgWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXkn+mKQ0y4rSovFLAO/ar2FdpBuCZ3JPhI4t0NnA1s=;
 b=PK1oeFKnv7tic72DLMrfD+hR6OvsPXpHMfEbtLP01KqxjvQvlVloqI3iwjr8ZVG56ZbXjJO6KYbw5naiecccVHbh2+vz0E84CemzpTFyqoikbQ/YrNJhicrQ94Su31If00pONIG63LgwfYlu7rf9+ua4CJGYKzydNNJos8WIW6nIzarWJcmIgsC8AEWdC1vN1HFNcfFS9ySMz3GkTc+PYO+n0PxfDeivz31u0r7A01ItcmkOtTL38mKeLFpbRgOjoDBXoPvesk5wryS75zADtgpa9vghxbRjZJkjqLG3A0zA+8uTDuoyC6BNxCnz5mCcLl+XZMgQUA71kU+5v+zz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXkn+mKQ0y4rSovFLAO/ar2FdpBuCZ3JPhI4t0NnA1s=;
 b=c19rGHE1s6x1llrmWMVFpxMKnoifk/DXJk1CIobGWeBcvVG0R1NTdslqCw8eN2LHp9+D9VvH4CVDM+uV/l5yREtlVGmstizij5l0rlRH558b/hDvD+noJWX3nQz1arTxUjSG+8umLrzZa/dZe+HU8jd736coX8MuFYob027aTcBgpjMe5z1cQgOwFzwmYIRh01WLZZ/y26fhPbOt+L2ISjX566+9QXndpw13wOB5SDcnOI/C0IoUfWrGyXR/SnvP289QdPLRjG0nStVI6q1affCwxJYUB073CC68RpybDJTJCrZsUJ6qvC4NP/CjjW8boIxdIBsQ475kSwlN4IBJTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU4PR04MB10499.eurprd04.prod.outlook.com (2603:10a6:10:568::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:04:49 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:04:49 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 5/7] shared/bass: Add additional defines
Date: Mon,  5 Aug 2024 15:04:27 +0300
Message-Id: <20240805120429.67606-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240805120429.67606-1-iulia.tanasescu@nxp.com>
References: <20240805120429.67606-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0025.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::30) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU4PR04MB10499:EE_
X-MS-Office365-Filtering-Correlation-Id: cda1a52a-d7d5-4691-ec55-08dcb546ce18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZN96QiTyuiC/GRGXR70mBqOz84nl48ib11dkd9rxIDMObabF2mz+YORS1AG5?=
 =?us-ascii?Q?QhbRsqJN+PVs8BNELZhDdoGdu+aLx1akkkV4UJAPdbcvPxNqBkRiW8FBD+6I?=
 =?us-ascii?Q?1EgFzoIcFyTjzY3FlyMxFmi+DtX62zsyOP/kaFfDsoJWM/pQk/x8If8oZy1g?=
 =?us-ascii?Q?OXXUIViyrZnej8xcgdQfo+F9Dqjko/RIqBcl4CN9UTosWmW/zq7AI9i5a6iR?=
 =?us-ascii?Q?AsSrwm2hjxfuHiIE5vkcmNyqiHvXyH1yw7NHAz903mr2UuMuDdRJcbP6qPmv?=
 =?us-ascii?Q?aZLA5O4kflkXrKNs2Xdl8MCmkVxuPvBHtcJX2LctuXcz7PO0TvV+of7AWs2r?=
 =?us-ascii?Q?QcR1HcJGy30bEwPXVMO49buCi2lF8EVszjEt0AUwKVUv1fhF7yFDRNSpqHxx?=
 =?us-ascii?Q?YkAExHrY4hdhmtHyg5PluAcEqpss9w87Ug+kEtgyrEWROJTxXVOshzL7Zfon?=
 =?us-ascii?Q?SFO+puHpPtVFC8PXJAhltNccdxopW4oEuuTXtUH5feifgyySHEVyjYDfuJqC?=
 =?us-ascii?Q?3EuY1Mi3INiXvnoerFarfE+n9eE+RZtY11MTSVehVRxff88Y3zq7I1GwRZoz?=
 =?us-ascii?Q?bKgzIcWMGNCKf5PwqSzjyLUqb4EZ4ufwlJsyI1+OhwVz9Hq290JdT4RW2gRC?=
 =?us-ascii?Q?64yLzNDEyilHX7yjFymaNnbSQDdl5two6NOD0ZekdMSUwfp7zem39zeauh5I?=
 =?us-ascii?Q?Z7WKodJCnX+fPb1eXXqNFSQnZWGZznhxfpZLP4/qSiFp2wY1dZuoE9377P4q?=
 =?us-ascii?Q?4F1B1kVWBg7eWDnjhg3VqY5+bOEk6bHCD3t0cPRMiEXjCKnSffLZEBho+QoY?=
 =?us-ascii?Q?BshlwV7yKTLlhFCxZnkFIEN7Iz1lHt5pjy4D7G+fYrEQ3h1XoYy8yr7Xwm4P?=
 =?us-ascii?Q?wSdmsIMriBBrDkTBvLe3VeFUpZUhFZQR90QeTzJr6OBSPKwO29bkHTbc0QWu?=
 =?us-ascii?Q?qMmrvwr7TKufrHWEnjPxH190xfbsvGIPoOqvPT7uXk6VLE5B1Zg5OJvAtsr0?=
 =?us-ascii?Q?KNQC3QcmNhiZbHLkR8WVgXNI8GHN33JZyZY7/59ZClgru7bQC3ctiSnkkcaJ?=
 =?us-ascii?Q?AYrL7OPxrXDmVYzxysKYthlbavDqb0J2crxCiwTyZ39ZAJ+T7JP9ddsRPzU0?=
 =?us-ascii?Q?2LhPQSciPrYE4NAeQrFD2mGPxGfTgVBI9hP2aJDP6CSOpgx79OW1miRXcgJt?=
 =?us-ascii?Q?rk1iO481uKIG9zthS7fYO2xRihtmIY8CuysXa3vr2d2az57bLTWZ3NAxK9LG?=
 =?us-ascii?Q?KWjyaruUyToG0X9n+NN4+TCHN2DCsijNw656RNaLp28uH3I0ZCXl0eA+VDFW?=
 =?us-ascii?Q?YWc6/DC08tnYEUqZ069Od3KcC3cQHsCKuz7EKIhIQUKBzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mETvsvjy+fmcC8OlEoR3OcwsZcFUkYdFM9vMwWNN0q6KLnYW8RtRQUrX+fma?=
 =?us-ascii?Q?rVwLwYS5tfQvr9Eb++Fpoc9bDeKAPBCwQ8g4om52A4fFF78uBgZRD/XGjTEy?=
 =?us-ascii?Q?TeMIBAWDwpBebBmTV0GAHLm+tx8bMbwFCE8ENDODmDVodM6g8cGSXqOa47MZ?=
 =?us-ascii?Q?BN3HvdAaC4Quvun+BXlh1LKnbTNb/uXL6DbN0HlI13TjHxZbpZTNv0HfFIcz?=
 =?us-ascii?Q?Jn1JJuiFDzITiLiMBFMONLszBkHJBnZYOs14Ib6vMQjFMjHWp6ktF3c/TNP7?=
 =?us-ascii?Q?BDogi0QfM7FdJLXv/ZAtxvekEvUJIBH0GpUD8ZtVrOuQ2sYhrb0xjfqBSLpP?=
 =?us-ascii?Q?4ZL7o+zINRTG3d5LWDzlbk9Ix5Eg3NGjDW/86/4VyKB4Cy1/Rqd3xy3/aYpK?=
 =?us-ascii?Q?yN3hNs5f9whaNEV1QMOMGgTmNU03Jd0MNHrM2vvE/IVTyz1+exBdYWbpvots?=
 =?us-ascii?Q?KMJTgDFQVPpV92tYbq0yvqKxjj5H2jsDLDCxRAkL8nnsEwz9C3i0MpBfd6gk?=
 =?us-ascii?Q?ETp4h1Nz2ZdxtG15uI16J7Cd9bVXseo9g8OaNjbniByQPHJIchQ3+aSYcz03?=
 =?us-ascii?Q?EMsNmTjnjgSQfOHyq1IiiH+2BF9MVugMOjc4W9R54lhEZ/Lis0AEkOqcGkk1?=
 =?us-ascii?Q?eQiMMNP356IP0KiJuSFRiL5mLVM5b0X2rhojvN8qzRUASQiBg670gnb1UT71?=
 =?us-ascii?Q?o7AxH2Zj7OajvTX1Ynzj4kTYnoEQyInBAu8sf+2F/6JGkAuDUhLwTcHEJDA+?=
 =?us-ascii?Q?j4baHpbLNcqLYlKVHK+PJELBAU6NEefPqEBvLwoJgHZdTqxm4LOwutQEMhcQ?=
 =?us-ascii?Q?SzQNZNmybY9lT5qEAb8tFz0OADsWIKZDYza6b+Rx/5hUYRxTQ0+GgpGRQ2zM?=
 =?us-ascii?Q?KwpTi1C8mqZ34ryMbbgKv4KrjrsOWkFNCCDggNA5wvOadn6kBrGLjUhPLukY?=
 =?us-ascii?Q?92AZoBd8mI+EF16cuTd4Vg/cWLOo1+wMDT1qxbqOcAEmIGY/6HHlJHVM7rt6?=
 =?us-ascii?Q?U4WNWDU76nz504MT3vGmtcBaIWYJIP4vhjNLRM3HWf0wTqs0I9qg4Hv/bLAN?=
 =?us-ascii?Q?V0MxRHa/UMa1xYlnFYl6VLHSF3ca1hnCM36/8RWwZdXPXXHo5Jg3BxUq4LAx?=
 =?us-ascii?Q?VV1EN9AzvqRT8kYIL59K4ES9rOnCKec2ux2UDjCb9MCHB/QHgUsuPTJByXwe?=
 =?us-ascii?Q?vQX5GYjX1/05SNPm4Vk6OwZ+4NmIechACBZzwdcrTHJe8Gw5UtYhhlVSe9M1?=
 =?us-ascii?Q?WYu/rzq54yj6UfeiLkieQ9zumSGTa+gJMjI1BIk9SrFMJzXcTqr7WFOKaKQ8?=
 =?us-ascii?Q?y4NIHf1oDDRvB6wqrNV0fRqifVtfEWY6tNIpczPOC+mJpbycx2E4dB/D8w5Z?=
 =?us-ascii?Q?JGpk51LAxCG3Q9FLQB8ng3l+H/PIICe5z9m6Sc7kHNRCv8c1lJc87pULXOWm?=
 =?us-ascii?Q?J5oG30/QaehdlKOzJnTmI2aZO+/bi+W99TVGnYPyDZ66bWg0J+BfPjkbkSvh?=
 =?us-ascii?Q?husNuK/7/f5fRwsYJ63MDIZHevNur+sv8zsuHv5woBg8wy6yrJgiyvOS0XE7?=
 =?us-ascii?Q?XQz+u6XczVUHDWDCzCo1JNOjptpA+5NXEocteeKAq/e8RbMg8lorqlVwHeD1?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda1a52a-d7d5-4691-ec55-08dcb546ce18
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:04:49.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obzu4MhfpCKP78w/SttiCxV7sv1EwOl8KSiKMnp+7YN4niFFxQNXs+dsJudR9omTWwMWrnwvXnyL123pD466QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10499

This adds BASS macros for Broadcast Source address types and for the
unknown PA interval value. These values are to be used as parameters
for the "Add Source" command.
---
 src/shared/bass.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/bass.h b/src/shared/bass.h
index 01c1279bb..878bab51a 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -74,6 +74,9 @@ struct bt_bass_bcast_audio_scan_cp_hdr {
 
 #define BT_BASS_ADD_SRC					0x02
 
+#define BT_BASS_ADDR_PUBLIC				0x00
+#define BT_BASS_ADDR_RANDOM				0x01
+
 /* PA_Sync values */
 #define PA_SYNC_NO_SYNC					0x00
 #define PA_SYNC_PAST					0x01
@@ -82,6 +85,8 @@ struct bt_bass_bcast_audio_scan_cp_hdr {
 /* BIS_Sync no preference bitmask */
 #define BIS_SYNC_NO_PREF				0xFFFFFFFF
 
+#define PA_INTERVAL_UNKNOWN				0xFFFF
+
 struct bt_bass_add_src_params {
 	uint8_t addr_type;
 	bdaddr_t addr;
-- 
2.39.2

