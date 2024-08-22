Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7861C9ED7
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332381; cv=fail; b=sfbaKMEk4wTrAwJE+ItapCECwVxxxtkEqbjgg2AdncTQSrWnXIe2vl1VVNp4lN7isRdEZ3mtCMCyGFJ6YHM2zC5i1YNxr6dnMmjmVVzH04Jn1E8yAKd9D6WQyBOI3DKQiAUcomW5Mi4OsMHlXAGpAyucFb6t7plf/TNVvZw7rr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332381; c=relaxed/simple;
	bh=NUSt1nJT7sKygv4xw0kO1WAyxC05uiXUoJ0VFDqIOHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OQaJUGendQ6ErbhWIgFPTDGAhuNkhkqnpcZT3hOsnsj5L0zuSFeSL6SfZ9PPkMlMmC/Xk9VEgGkc3/Liskna8lUcdDKTt1lFgvEBZ057w32Wtdwk7TpBL9YTPU0Y9rrKylU5iQTV7Z4zzgRinyJBRPq8aMA0UlT/EWJr6xX17iY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TJHKyYwW; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TJHKyYwW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xT1kDiHxuVDT5l3su/HLw38MI+r0+CN39gyeSHPlQU2Ndd8O2Oxy4gzsyP3ZGu9YnXAAezXSdjIt1j/WfEuNoIJbes1j2CvRewW3fTxaeazJ9M64+5/I9x18fUt5roFIII80B4ujhpaQvkrw2A0iqYkthTXTa06DGbylG3IM0faVdZvzCtf7/qGGp8p3Pt79Hl04ivkwvEkZ15iucMnnjYebCEkSJR7X+DeULvjUffVbVGzfvZEDGSFCOuUIHvt1PXuwj7L55AsZ/exlanSGyCk7xH9YFeU9+HPRh+Hcd+9e/wNb8quC3dY45U+YQa0DNXaSumeZekbzSKoT6ga59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkVX4V+r82xNgWqE0GXl35HsaW2JcsXVuIgU9ldPBiw=;
 b=slXnG5HHULZpO/ZmMPcOVPREvKgcKvMKHMyQxXBqumisbMZrTUI5lpFshymx5KeHBChgopCY85/bSROd7W3hUoNvMLrZ3pZaTVRMj/cwROLzPHSYuFepWHw1ioIepGfUjIBsBzqZnE6Cfk2yR4D3sQSFCqyiZeQPLfjJDEnoJvLSlVocPZ65ovKL1b+QJtlP/vhJ3FOI+EAsi/O6nBwc0fOXVvW25Gcyd88m3BeY7dntRk1L0gq7EeDRhAVU8pjNorStz5BzkjMW6Loe0iBQ9MnmMUY/4pBe9Qkcfqbb9aFOZVB7SNzCPATk5t3HdOB0P8B3GvqlKbpuRRvo3CC+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkVX4V+r82xNgWqE0GXl35HsaW2JcsXVuIgU9ldPBiw=;
 b=TJHKyYwWn5GhFDYlue6VdnsaBMmxIL9kRTl+Lp/2KuR8E8JqJqMvBKxnx5Ba9xN5uW87wulFZOHIR2ipLCKKBJAyEukLARGREY0vezrp1aeIJtIVCipdUObSfXJCWqKchS4jtjlOqNDPzcxWnr4FZxaatbapLDHOzgvwBVI2G7hxmAIf1kICll02Bg6BSi8OMtKOg2RBNYmLt2Rhi4MKhMJfdEKu/eNdx29TwNcUzDytaIpQ6qGGOWMgG5ngdMQ/CD2MxpHrJEMmI438sJn8iVkZovaL7UGIBi/m+XTL9mdRFeH7Xk55X2/6wXJwLTvEL2Re3C6NEiuBXX1llOF8EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by VI0PR04MB10565.eurprd04.prod.outlook.com (2603:10a6:800:25b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 13:12:56 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:12:56 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 2/8] transport: Make get_bcast_qos return the encryption flag
Date: Thu, 22 Aug 2024 16:12:26 +0300
Message-Id: <20240822131232.531952-3-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240822131232.531952-1-vlad.pruteanu@nxp.com>
References: <20240822131232.531952-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::15) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|VI0PR04MB10565:EE_
X-MS-Office365-Filtering-Correlation-Id: 133350a1-fc03-4bcd-01ed-08dcc2ac2373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+lhQKRTeuBCxKvl91KkK65DNJDivpBmvLtChFwMvhapXqiDlhrIkFLG/qXNh?=
 =?us-ascii?Q?iu+0iiuaRFKGw2WEC9baik03b9IuM34/5CZdzlZ0Kz16xGxI87ckOhb35StS?=
 =?us-ascii?Q?7Nzq6/eydVW1QMlyd+wbYEAb6LpkN2f7k1SaSbRYzu94rbAUo2SBAfLohy5A?=
 =?us-ascii?Q?2x8xM8UVpIoeUNfCM+KKqpYhhHpNE7YkFN5VFzTqQgaru+GE5o6U4FjQGnE5?=
 =?us-ascii?Q?yp/3PDeveD5EQfXPmftjZJC0MAEVCpNUf5Y7AyjlYXNH7n7wA5S1F2jvOzYS?=
 =?us-ascii?Q?o2e4RdIzR0Hj53zJUlvmT2iR8SuDaue9VptIWmx0Bu+Og9aYdX510zm7qSqS?=
 =?us-ascii?Q?8KY8QwcUfe6ye3qyIELAvvJysE133DEHTFYf91Qucf2bM2V27lb3Gk2gprGU?=
 =?us-ascii?Q?xNKtNlcMo1REDZnwc/yIwxOmhTuN1QfOzrMaWh1b8Mk9OsgtE/EefaEcVk5U?=
 =?us-ascii?Q?f7giGIxN8XqVtdrTD2uPrdrfV+jw0T/w0GTpd6xdPTO0FHktlQi55UGzMLnN?=
 =?us-ascii?Q?gk7TvYpyTVKbXQ9smbO8JhSyhKJt8dIc6K9oJ4rBFc4A3/0k5HlF9wPpJpWK?=
 =?us-ascii?Q?pa5bibfDpmx0tK+m26zi+Xa6+d6yrFxAJmBzQXnlSIzaCff01YtEPf4WbHhW?=
 =?us-ascii?Q?z3C/n5vowpQtUsBUKTuorteKcC76yHSjpWe1FMRcyBxDCRgJWnqEIEiXDEOE?=
 =?us-ascii?Q?VMMr54NLNJdLylSFqOBePPuvL/vt0ZGrjZMw1/pqGMeUbLCCEmunfYSBACVz?=
 =?us-ascii?Q?FHM+HmoxRNpYmfb5LPiSzBkNBzUXfyQTucuWu5cuLe824IAmokpraXtockZZ?=
 =?us-ascii?Q?fnZCfSnjhmaCBKgRC+Kr6JQ6Tux/hZbVio3GQ3ijpRonDwqeSBkvqvAZv3hY?=
 =?us-ascii?Q?a8o9WE2Vk1CRIORlCwAxPznY23j01XNejhslWRTI+GQEC5PFAMjgXGsVfN3v?=
 =?us-ascii?Q?Pwls4UzWLIOsCxwzbidToy+XVVWXBl1JJC7AnHCnJf1XzOS5padalO8mizlA?=
 =?us-ascii?Q?QIZUqdyeigdCF+iYR+2P19JtCPBEz9nmyfmG2c2CyEBw6Z+hvisILMApYvB8?=
 =?us-ascii?Q?HI4eCScJ5Mzr3Z+gqGQzASQyrQ1xEreyVUjXv+WRl+IEeoGk5gsox1h++q3W?=
 =?us-ascii?Q?ZzpaAXle/EX4F+U9DO6ZILVoTOMDm4SCaXh1hIc2lfyLzs6wp5ij+p26cjkl?=
 =?us-ascii?Q?pDBNEOjLruMZOBbjZ82cPa0/CISixZ2wbyD8dWnwTiaIgN+7/5q5qazEdaQJ?=
 =?us-ascii?Q?oBCAVHZHIlg72yvddLikb6Xt/jXgUxCBAsBK274I1ks/ZVQhX9xzm+Cll4g0?=
 =?us-ascii?Q?RG2/4qjFcjYbfB2hON36HawCzCOaztNzl4Wd4FaHINM69WDGR26nAgj7VitA?=
 =?us-ascii?Q?OD9MEhaAj+E3My683E0vgmHRINdwYtnGWR/dkC/elTx86nq1gQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QggOmQI4xJKE6slr+5NeIpkOxSFylP1pDvHja9d2T6e0S0CvjyUDCzi9qlGs?=
 =?us-ascii?Q?0RJFP4kBIA0Lo1Lrr9pnCjlYM7r0fC/z0j2LmhbpBu1D5GzAXgm0+un34pnM?=
 =?us-ascii?Q?xhXLFUTQdn734Lg/5VeqFCGN0c9h5tHV0pYRjNeRaWT76hIzZxlGCnt1h0D6?=
 =?us-ascii?Q?2sFWdxjYOxv9Hrr8mC57McsfYgaMhQgCZaisl95Nkso4FZwVLW47Z94vu4c+?=
 =?us-ascii?Q?0BrQjL4xarz9KbmojTYDVN94Gw2z5kPZ/dRCm7QD5CxKzXDYaJheoXgySbhh?=
 =?us-ascii?Q?6dR7hcI7O1z1sPH+c+aMY2hnPfsZfnQDMc7U4WhIe/YDZG2fPljH2pI3zTx8?=
 =?us-ascii?Q?6Jaf3XLvG+7G3CklPBNhQL/OwOudOSL2QNsg0ev53ZybI/4KDVCrwWJMwI68?=
 =?us-ascii?Q?PViNUN9BfDIWXw++tGIGm+NBUckLrD2m9gzO0JPKEsGgSubQHLiehapqBWic?=
 =?us-ascii?Q?2NOBBWibJ1Fu9hpgUtNo+0XPlUKYjkojHStSvD/axGP1JV7U6wsHvHBBNL/q?=
 =?us-ascii?Q?odWWW02NBVUzjOR816zdAdl9b6zfGY39i+DktiBpuk3826m3jxirLsHTEM/t?=
 =?us-ascii?Q?fBRtl129IYfRjfBlfRFh8uWMTkIsfcn78LjOmiHSXV//KVXvOVqVEIjWUjm/?=
 =?us-ascii?Q?TipPWXlColSlSTqE3avpjlr6r8K6KKIkZadtPjAhtzG0AhjSB5XqIaN2RHL8?=
 =?us-ascii?Q?2OtKDg7RhRczjFlES6XZF19oM/ZYV5h032BQ/HzRlscHeKnTBZUpq/sb8e6L?=
 =?us-ascii?Q?ZVB8FOx43BRPplgpj1rsR+xEV+9ekCwVfb/vXKQ0ZJpno3LaQRa+oU+2adTU?=
 =?us-ascii?Q?dy6ziI2Xaq6jLls0jBlJwseR6ZlSARI9376zbdE41RwVP86meCvArBtMOb29?=
 =?us-ascii?Q?lOdyRWP7GiqRs5WOKcbKKgqEF4VHVSU6sj39E7mR4GUT0CXhipDTrDL7j1Xf?=
 =?us-ascii?Q?qtY+akS90cLJhwIgDM5aRlK/vsZLitYRl2+ILLoiqBPfrq5fqXpf0JlCZ6Ca?=
 =?us-ascii?Q?a6vk0NmGkWAEFxX+UE6L4QCe6pz8SHLhXjuYNoHaLXyc/RBpkFbw5tJemGfA?=
 =?us-ascii?Q?gf4iSTNPQHkFlMEPwfDSIQ4puE8GK+NnFLGoyZXBXFiu0qbugRiSiQrRKFYH?=
 =?us-ascii?Q?cZybTzPSJc2BFkLzs1Mkf3alK5wp12czsPRXu1JH+nVH3lx+JosEGqUG4ajC?=
 =?us-ascii?Q?7BBWK+kdpWGYVUMKI0G168SPUHP1a9e178AjnzB/ZbeJDu+99H09g4EGFADu?=
 =?us-ascii?Q?6dU8XkPwzaXVFEqUtObbaFbD/fWAK8QO0zBFnYJ9tnqic0FcOhUFZHlQ0Ife?=
 =?us-ascii?Q?uPal9Sek1XUpmOjh7NPenm8wAJkNtB+DPAom9amsYsv3GDCl+K3M2RU2Q6uF?=
 =?us-ascii?Q?2Xd2pw4w6CAcNEQvquJKyVIHounkG0yMnj3ArKeXkY7Jdb5roNaw7JhwzBCN?=
 =?us-ascii?Q?2kzbCFTcb06U349qu2gq7OQY9LrKLzRc2a9K6QrGwUaxvDFzzYMUkGCbsOXr?=
 =?us-ascii?Q?UtFgjBPS7S2Eda11Fj/dYJcilzdeR09HTCRjLD28hKRmzEWHagiBfY3zg/Wd?=
 =?us-ascii?Q?HMsb5kXyjG91j2dBPcMn6bQruzhER4nIhWbm9Amt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133350a1-fc03-4bcd-01ed-08dcc2ac2373
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:12:56.6207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLIDsPsoalf4ACESnbXl2Zfnnmy21SMLdksm+nidIs6s0hjiYsAqJdOD9iFksjhaFGzqaDHyLYfN+DTlhvDw9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10565

This adds the encryption flag to the response returned by the
get_bcast_qos method.
---
 profiles/audio/transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 300145794..e8915490d 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1174,6 +1174,8 @@ static gboolean get_bcast_qos(const GDBusPropertyTable *property,
 					&bap->qos.bcast.packing);
 	dict_append_entry(&dict, "Framing", DBUS_TYPE_BYTE,
 					&bap->qos.bcast.framing);
+	dict_append_entry(&dict, "Encryption", DBUS_TYPE_BYTE,
+					&bap->qos.bcast.encryption);
 	if (bap->qos.bcast.bcode)
 		dict_append_array(&dict, "BCode", DBUS_TYPE_BYTE,
 					&bap->qos.bcast.bcode->iov_base,
-- 
2.40.1

