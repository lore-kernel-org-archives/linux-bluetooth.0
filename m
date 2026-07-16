Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6237F3DA7DF
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193526; cv=fail; b=elEVL0F98X0B9a/YDFBARvnpBHvUo0zoPzKzefyde9Xb0xwd4ZtyQF5S+jOHR3UMH/Hu3XgJsgVHWmCySbRAdgtZOyREwpBKD6ic66+OT9j4k69r/yZrW320VPEBCOKSL0sBVXirnVDhMndNgYvvC4lPE9u2K7jX28K5Bz1eolA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193526; c=relaxed/simple;
	bh=dzFExBeANmrsClQGIqbk86il0j+0QUiToWwAzzCU0AY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P3ovMPaoAGwxLyifgEPsgExoPfUZFmjIsgo+7S05NUHUUMltDrV1BNixIhAPS0CyMBUIDeJpSmG8OnWb7C4PTqXA0RweVaoBudiosi4PTCGSl9/LW2n7FKgW8X87PlCHxUHgZTamFBNbHuMNCXoKWW6ljlg5j75i9l3+RUDsyN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gc6d75Wu; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gc6d75Wu"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7DYtS1995205
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dzFExBeANmrsClQGIqbk86
	il0j+0QUiToWwAzzCU0AY=; b=gc6d75WuLKNZDOSAoByQcduzuy/l9tgmRBhlD3
	aFaMIRFRjjpgr6CA0sqZjtEUNW3+/dA+wlr8bjGVvI7FvgwagY2XE4+kLq8NIwyl
	31t/cQYuP1vvU9B5IXuGAPNuxddI8X3Jgp+wnwgPJG+jLxH0eA19QHH3SxKE4FVp
	BU1mlB26Gfmmw2BDpUq3OA4sKeRNGw/2wW6MeRt0vhhTGhumvuPC7+N/0A14jZ56
	eR4jp6DnUKT+I5o029M7Cl0Xl8/0tf7qwbbAYNi9jX/De8eFtTUOGLDqUtEuTJeH
	sWLwG82HW6Uhb3Z50SznyUbfNPSV3pwqdSijkOomeFu0U8cQ==
Received: from sn1pr07cu001.outbound.protection.outlook.com (mail-sn1pr07cu00103.outbound.protection.outlook.com [40.93.14.99])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feefqjypk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:18:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmMFJnRVQDqcmLvZAyy9CZG0TJlBtkxiCmhPkpuzIS/Ixd93CY4SFbFO2mmPH2e4DGOFqEvA0BmYOakUuXnsqSNbocbfLGKb7WTPkIZl+gf1f9BBNAhgX0t6m6ge5rFZjRFF8D2Edpm2TrO153/oZuqXab8q6KOr0rnW1Kilf9qCdTNARmvCoQ4b5kAm1dLPTb26QBv/gyhm22ip2OOYBYf0jqOBG+tlVvL/b/igpOQmecrseTKbX+K+1dyaKTjgejPYShmJszPkOPANhELhx8cGZsLnAHphGRnPs7rvd5adEwsa9vFYj0PJv+kIyD8t7CI8mvEfX8pHi+oXYISOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzFExBeANmrsClQGIqbk86il0j+0QUiToWwAzzCU0AY=;
 b=CwNJ6qXnPmO3NlF2sJpxnL/PHKuDkf7PddZ0rcf3NJnW+H7Qf3la11NIwjQNKEHGYo/po/+Zb78Ji6sJWc6Z2IW83mtLP9qFuSWGlI18Paq6PGV0IWzwjpBwukeQeAuuD1jkMe2rfcHNQ1CqRW0nvUqF3/sw5bKngZqAseUSfJGdvtdx0qr4nMVOTnRShaaK18LrRmGgY9a2yYdTL2gEDC+CFELq8IYvbhpuIfCJwpJp+YVVTTrPPRKOtgWlAwPXbiNIM7Lwyav5WzvakHczUvGbgt86nM9MpJXhjjkX/CpBW5L5EOu+KzUV8X+Nd9XUILTGbiG5wN0/270UJdv/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CO1PR02MB8667.namprd02.prod.outlook.com (2603:10b6:303:15e::24)
 by BN0PR02MB8112.namprd02.prod.outlook.com (2603:10b6:408:164::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 09:18:40 +0000
Received: from CO1PR02MB8667.namprd02.prod.outlook.com
 ([fe80::e174:cf1f:9fe1:726a]) by CO1PR02MB8667.namprd02.prod.outlook.com
 ([fe80::e174:cf1f:9fe1:726a%3]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 09:18:39 +0000
From: Yixi Cai <yixicai@qti.qualcomm.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Cheng Jiang (IOE)" <chejiang@qti.qualcomm.com>,
        Jinwang Li
	<jinwli@qti.qualcomm.com>,
        Eleanor Xiao <eyxiao@qti.qualcomm.com>,
        Huali Xie
	<hxie@qti.qualcomm.com>,
        Jie Zhang <jiezhang@qti.qualcomm.com>,
        Peng Cheng
	<penche@qti.qualcomm.com>,
        Mohammed Sameer Mulla <mohamull@qti.qualcomm.com>
Subject: Recall: Missing test steps for BNEP/DID/FTP/HFP/MAP/OPP/PAN/PBAP
 profiles in BlueZ doc tree
Thread-Topic: Missing test steps for BNEP/DID/FTP/HFP/MAP/OPP/PAN/PBAP
 profiles in BlueZ doc tree
Thread-Index: AQHdFQQWgkfgRRsUekODjvGi3Z8ThQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Thu, 16 Jul 2026 09:18:39 +0000
Message-ID:
 <CO1PR02MB8667E40E28084D54C2B86BC098C72@CO1PR02MB8667.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
 CO1PR02MB8667:EE_|BN0PR02MB8112:EE_LegacyOutlookRecall
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8687fb62-c6f6-4dcf-9842-08dee31b394f
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|10067099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 oj/HRJWE+1akuSCLTHwTZfjMfiEzGP6ELk6gGg5VtDnRUrKi9sztiflxayFaCy3VSgH4fQ9REJFkUlw25wCaZ1VWbODcAUWJJqQZtDEW4zv2cQxmSvhBRR7myULLQt86XieSaKgfZuSJpinFymEmjSeAm5ESS5sKmVwN6citgP2fmwHJ7CbghFqDnZgy/5/MvA0DwypovJ9MTVgIzYrfecuVuk2XtJ4cEJw8v73GOlUBhUSZbTCbAsqGV9yXHdqHRWzpfC3zFPC1on3heuBPhd1/mhb+PCfZb6XVrIICINlofu2QLfkSQIykC+1mSLqANA2wime9Fbjybudm94hbpFaWwsxjpGEBKEUO/WgtkK17fEL6/sLJ+Eg/uN/cy8JWLnrR1dTZuV9T42RYVLvTfwA2ImmQcjMHi8ONmC6bgGpv3rV7mcKC3WQ48kwQ+NOug/AmA64hfbi25LUc5mSO5ny0NiV1ivPUbHjafGSbzsEJVfxhJpBvjZAsBIphZlshy65hLX286Vim/RnEmTnPg/KdB8ZBOUOzQ9o3vE/h+phyi7DAiDNrLQDZq98XrLVC3D8nsFDrDWr/AcTpU6e27hUL632eJVxr0NHuUcc732Cf28YPesREcVXtTX13bub5Duc0tjuwBvO0rVbi222iXp/EAQQrnfZlkPAOeKPJKAlGePECtNKkd+xXZ4n4XtzjygeYy8t4WPTYEeYGd1UWM34zLWsC/yKxid27ORnrRoQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR02MB8667.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(10067099003)(18002099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CFD7YWZ6BTZemDMKFS1uF3kkAf29ZnGUfhdclikMFOFgVFdVUQG8eanKW3Kx?=
 =?us-ascii?Q?thi1m2bY7VpLnt9KEvI7W6bfacP9ZNbjpZTi76wT5F6D1MtYnEzeJ23djMUJ?=
 =?us-ascii?Q?acQQKmIezO4O/gwdYNeWK7uLtKzvkmh9j3XLp2sLD+9xn6w/z2eOO9Rqx/b0?=
 =?us-ascii?Q?g6ek2r/qEhZXCiH1GSaE5m+UsmZM3bsxO/MAX5ci9Qv74quWaOlh4D8CjOW0?=
 =?us-ascii?Q?1STKeDZRizgXun1Xsw7Wg5pL/LTKFJKZhQmjtoA5gewdJG76lXq4OFHGrJRE?=
 =?us-ascii?Q?jCeCLHAexjw1CPiGQ1XFK9k8n8KnidqOvghSBNa9wtuT6brQDt8oAzKnGNZi?=
 =?us-ascii?Q?4o/xPs9z3z4Wngahi1C/UzJXp1pKcydyplhYYMjLwci3Kbu2lg86ulfsr6Fn?=
 =?us-ascii?Q?Iek5BYq3GMle3a/TgtJxp1xKNB3bXxqnowSvC6MUWuLJTLKTF1NWmhyQe4qK?=
 =?us-ascii?Q?2DVRvdRnk3TvcKGftZ5Nuu94L7cq6XIzL3RBSerYLDcuerEYWJqM+mWAF5TH?=
 =?us-ascii?Q?HUJURvDWfmhd8eQnCAuUSpiOSvhE/bEasoq7/N5czxqnMcNPjS0OX1me0KmT?=
 =?us-ascii?Q?Y+ngDu1eiwzEhwHXxxAY5sEe4N32PJu/fHGkjPdF0kqDxH7AtC7o8Ws4heOn?=
 =?us-ascii?Q?Gu8sHbM4A01hJrOwSv77/tlcyurqEXEoCF+8nTNOeXJyeNuM6O//GSY8tMn5?=
 =?us-ascii?Q?u+CdvV2sak+gfFNJjC1Ha89mMobRpSnctapqAxRljFckpfar4n0KEZ8NdS5I?=
 =?us-ascii?Q?EylaXdKKEgz8mIjsQz/mKvkYhv4p8PpBuZ7nqQYWvcCzqeUA6GIQAsGw847o?=
 =?us-ascii?Q?v6pnZ+D5gTzE9QeOrl81b7T/5GGXFmVwoMob+QPw97hRbx8godDDdMSgkmCj?=
 =?us-ascii?Q?1gkLhgSPAynjFMxTFuy66n8tNTe/RxGmkCov2JTYCEwlVITzjPz6YoNwsPlJ?=
 =?us-ascii?Q?SMgQe1z7Rs1bKZEU3gmBkQWorH91E6uu8+3CiEIElEjoh8WeuggtiMrzJppd?=
 =?us-ascii?Q?YNdYPoIhXoaI8TjvyfsrxyxvsiqkjXlSyLWMSFlBoSBUMw8EpDL+NnX+ZnNZ?=
 =?us-ascii?Q?C7J9ApxrHCSNxPxlH1z9+JHesIA+/LJ82ugx3NS0EdhGTcqyCjh0Y8AnVfQJ?=
 =?us-ascii?Q?k7gTjsxonchTo2UQlflipuoFU3KpJZxjELpsBkJQigqtN/olHiKosrohgGbk?=
 =?us-ascii?Q?jOBsIKSJKQZi++fIcTr+qCw81fhv3Ie7Xoi0h10t5Bapc0xdVIxZVD+l59uZ?=
 =?us-ascii?Q?1n/QmVvgpMrxJgQ7ip13l6Ouc8Wu+wHC6kG2pl5YElXzP1xT3KkW4HUZDsB0?=
 =?us-ascii?Q?Wglv9FNQx04lXPNYqbOpUIJizkSL/R/JCAGFflVScgHKThcfDaMcfTGGdEjD?=
 =?us-ascii?Q?XKyuM1pVsIWLo9qDdxceP9KJ4JIaeargYSsIXj+DXxqibmKnH3zKesJ4Q3Eg?=
 =?us-ascii?Q?ensv57ncAqW63kkM9/60hXWHhBJ4ctSXd/NeIT70FnmIPIPLqum4V0z7Y/i2?=
 =?us-ascii?Q?wxfr48sJJ63lFZTD+XNebf9mTB24sos6UUSdHCcRorSCiOSf3kFwXrWFyR0I?=
 =?us-ascii?Q?YeuAmLGb1ZSyw1fCJ4u0BLcm0YvzkxKwO0rvEQN822aBy7vXX8B9R5iRc7Pj?=
 =?us-ascii?Q?dq611qNQGflYK8LP+/cPYdqbHJL2Fo+e15GjQ8tJQpfhYViBBUjlDs1M01yj?=
 =?us-ascii?Q?jGLhvyPDurIWUk3t90chwv67Np7d3ygQGn31Qb99AaiAtliqG55gO8y4xJwO?=
 =?us-ascii?Q?m+ynStvAiw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mmORs82EODOm4XnnI6Zh+Ykn4Fn+jUGx4R2V7UIiBvcXIEpAALpyfWrFWXNJgbD/FLOcYnOj2T4mTUWQxmKkzSI9TpuVmIu8GJENDUbVG9PVXlhSX/WJPwjEidqFGTiGkQRDz1JpgDN/d9Gk0BpBgvPuUTHyXP3ephM0CogXzR1yWrbTTDgH5ExNBhWuhx9a5egufYAhQ8Vw1tEQaZ7QD4gp0VyG1nIyfWHO7nqAlH5QJrLHBkrOrY+mQNcujz7c1FZ0L4M69blBZbbpVZUFn4r0EzPFHSKRMpDCgjj+XNYlwpVgt98iLAsMP/1SfP1oTDqVWha948FuZ052JqJF2g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LLeBIF3lSRCtHNEClZ6J/B5duTZKxKV14pXrLLUx8/shrzmTMLqaweDsYbzW7uuyXw1ucerOznhknfpzsIRtGGEbZXg+RpQhzvWXQD6cleaJRZtKjmqgKT6eBfY3t0UTFCJcXyX1Z9AEIYN8C12FHsdXHf00nRW8r6qBgIoGTCe5HZzECq22uHUndGUaE9ZOztLpqn3CaISByJiUZpYc5MbVhupAQIVgDCboZZ5Mzk5EPRfXoewvSs8o5E0/nz1idqmt0R3xFFWtjo8aEFSKxhq0h/eXjDnh1aSTrz8DBFbl7x8LJwjaVVXbJG80SuooZX15tKpzSIwRicmX6a6moeI6a6/smRIqVvrOuIWwPcC/76Jr1/R10NG2GJYrRRLrnwHSNfCnTH8rPcfCMiZf8bW4rruArSCUNzRph/wC4icdDnzHot2dFoi+UosviziACXpcEsayQaEm2X5fp/RJplVPtMuxcLipBhEMv/i6/ljhTPgd5pIU3trwmCJ6S80b1Eqh1I8sN4Jv8Dyekueg7tajy70Oq3krpcOLPB6xfi5BG/2Lp8fyzSQqeJuGdnlvBquzKwPXaY8uHB9ik1IOA45Adr+K4HnYebBxVN9eZBFSz36HKXI20DRXYMcLiWu4
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8667.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8687fb62-c6f6-4dcf-9842-08dee31b394f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 09:18:39.7863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-transportrecall-originalinternetmessageid: <CO1PR02MB8667ED35545BC461E3AE560C98C72@CO1PR02MB8667.namprd02.prod.outlook.com>
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wj9tfCNG5GgjXpIHZu+/Sb7rojTIbAEXF+Z8W2i71JYqsKORsZn9SVFir4NHsUI8IgG4voW9p9e6642bu8cl2amYEUf3XXWcZm6TVDVEHM=
X-MS-Exchange-CrossTenant-messagerecallsenderobjectid: 19da13eb-dcfe-4ac9-9e93-74de8f30f1c5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8112
X-Authority-Analysis: v=2.4 cv=APNfGQ4N c=1 sm=1 tr=0 ts=6a58a1f4 cx=c_pps
 a=UDtsvq0nnnj+Y6xic+By+g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=yn0ClLjSJ3kquDla_xoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5NSBTYWx0ZWRfX9tH3V8a1OA+r
 MIByX4UVTFvod3fQZrQNOK3KAnCUTNI/j60fYe2UKjGpkj9vvsQ2bCDlHdKiXZB0ywJI8CYfmtu
 5XjeRU5D+dUpkMrLL1ikcr5tsCe4Zy4=
X-Proofpoint-ORIG-GUID: pfAcbQOtvzKILBGJsrXd30VKpxtgYFtN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5NSBTYWx0ZWRfXypW5Lsvo4gsZ
 kX5qXg9St2E82aUo9aGPGxYel+hPVE9uc20ncz+5j0wccpugyh+zRUQhdGrLTXdhXCSQOpVcykC
 zMRNUZEnQer7vgna20RMVl8GnEdmTEVyKeF5CviwmxCBQ9588Tk/rHoAvMbTdtLPo+5EZwGew2B
 YUhkL/ihbUkT1f730zvzAqalyKiB4HuGFnJRCxxq6kC/H23AOCG7H/uBaDWFY6VWvzHPXOn65Zh
 LxVGsswl/gy3eZNeSsNxjxlfCxotDvCLRqt6tIKWxZGsWb+FRCD47eUoSuNYwWcXNuXCduIdQdi
 XWA9XbawzWjWsCJV50s2IY6u6NcbWtckoykK6MXZH6VML4/3EWhC62+bFuXfn12hqKK9aESzIn9
 TLOt/Tkqmvzxd5nGLQRTUehVpHvOawjsommTNtIX+G8/W3Y0HDww7om2RxtInfP2BrruNiSyZ2c
 ruqWOtUgJcb0XJrDg0w==
X-Proofpoint-GUID: pfAcbQOtvzKILBGJsrXd30VKpxtgYFtN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160095

Yixi Cai would like to recall the message, "Missing test steps for BNEP/DID=
/FTP/HFP/MAP/OPP/PAN/PBAP profiles in BlueZ doc tree".=
