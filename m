Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CLMu6ULL"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82771A4
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Dec 2023 08:11:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P47FWiotNvBIRSrwnlJmf9KsZtQGtUahGgxGDwvvqG4Wd/sKEtSuKunGerEbC/h71Boad0rEDvBIaZ7UKuoYqhcznYcfyDF/Sq8AnZBetrR55Rj2MUxCDE21SeuaUuZgIJIxtPdo2A+joZCtJiXU2+UxMpbWEEo6Ubq7oKrq+d3JdTDtKBDnVr577E+Nek/6LAqyhM6DM7aAkRcFAPDJQhawxmTmj6exQNYqneOuXnuATfkN9qiPBeiyxD0D8Be8xXlR5XXVK+JZibU2D39qJMcIVm0npxmWEtMpXVg6MoaOYK99Q/GKYyCxsIPO8eKAwbKJTfGL6+AWugmgNlK+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki/0l0YXHZj1ymn7SHBdxEPBP0HzW8tYpy+QlRkmtfw=;
 b=Lij2I8GyrSEfPLxa2AavbTe7Y7+yUrNM7DPPwbQvxXlDp53qccRTzrmLkLzQXR1+QcnwvJAAhqyfFbrCRjgSuKaUu7/iOC5S7yrLF8DVcxnf8wz7WVnO2zMgJF++lVCDkAzUsS5nrA7jFlOMiIAm17L/JAcc0AvX36B9SZFHI3j5d+tZamw6hOLy2f82S/z/Ku4QHlGCQd3lzjLbC3/7H+Nbho1hiiTOiwJQr4QAyKVcX6lCYzYHqw5y5bMqm1z1AD3Pdft7Wkc0e2gxjZIGkiW9NistEKLuqlR2+NhbCauoYllUdDK3DrAAKinixlNov9m5ZNcSV4K/uh6d0T/+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ki/0l0YXHZj1ymn7SHBdxEPBP0HzW8tYpy+QlRkmtfw=;
 b=CLMu6ULL0dqqyXRnAtUN+GJwuBLDeltwZ8SGBMfnyDeLqTPA1mXh8xLowINXy4Tu3sDC3XYYyNZuVfintmAQNLK8iiColJA3418gmYyBP2FUA8OGtNmSwJe9UpBvpOgyKR/qryr9qNA+uNOl1gwnwUKzJguqt9/SRe3bwua9p5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB8287.eurprd04.prod.outlook.com (2603:10a6:102:1c4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Tue, 5 Dec
 2023 16:11:50 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d%3]) with mapi id 15.20.7068.022; Tue, 5 Dec 2023
 16:11:50 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Avoid creating child socket if PA sync is terminating
Date: Tue,  5 Dec 2023 18:11:39 +0200
Message-Id: <20231205161140.2855-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0169.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::26) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 91aa32ae-15ad-4777-b864-08dbf5ace333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fPGBauDu/UqsyqNEPWWPCdBCcQxJDG0Urxeyde6mPheM6EQUPcT+LWt4G/DTqmt47uQUFepeLMN8NE3BsVe0b7Mlpr5bCkwVXkbxZ6lWg8jeKuWlCC3uR7W4TCxRYU2m/mMuNbWpe1X8hz6+9f7ko3fXcwJo1IkZSi4SuappJeya1QilL6ECA3O1KBsMU+4njb6CCeST6P0FxShDZg5YErJTicu/tl0lOsxOJ1RPtIc5t2648d1GYrUHb6ZhHe0DgFujxWC4u/3DMBZWhYQvDOwv02GBja8TbtI8IsIbGadN5+HNrFQ5LiAPp66PYPy0B7L842pxnJ6+7e0tUe1Rk/UJUGBqyS/J2w6QDQKqw64u6SnKji0PQVzEr0+qol4oZpAEz72Z6XqHb0VNxbQWPsL3ydTL+b8WI0AhhsyZdU+VcpGl7fq2DTQr5LaUI9PM7JSTBjURpk55H8pGlwguTMzzpCZrUxqiQhy4aWsxeZbjFZprY6xvPYbQjF9uFH0q7kswOFqOCFwc2U6VHYLBKKz6kewJogvnLvgWaTdJ1Q6laqSwTP2pu29RpYrfwYUx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(83380400001)(2616005)(6666004)(36756003)(1076003)(6506007)(26005)(6512007)(4744005)(478600001)(6486002)(44832011)(66946007)(66476007)(6916009)(66556008)(316002)(86362001)(38100700002)(2906002)(5660300002)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+YKZLxHpcsC2p+vD/ryhBRJQa9Q3PHQS7lSa7vXM7RHPf1ERqYC6CUjL8wgx?=
 =?us-ascii?Q?r56m3pp4LLahGWB4pzQa46YPbr7iHEwGfvSc1R6Tik5Nrv0sZ5sujyqX3piy?=
 =?us-ascii?Q?tkR3sryp0gkciM92KP+d1hz3lNbW/52ag8VaPTziy7c5zbUrNNZRtPp1R773?=
 =?us-ascii?Q?QOzy1zTL5aF1iFtTC8nQ6J9eo23Yg+T1S2/j/XBFpcdAqcb2aW+XVQVS+EAW?=
 =?us-ascii?Q?igYvIlhDtQj1GK8JDyM9mnZ8sXRv4ulssOOOkAUH0gzWPA8/thBpNfZELf8k?=
 =?us-ascii?Q?mcfDFZ6h5tjpSNXBReo5WMm6uJV4jDRRdWnvwEskhKhEpeBp0EZHabcLYRVv?=
 =?us-ascii?Q?KKk6HX2jYSOdVtCtBdv63UX+xVr9WSXSo3H3xlYe04fT4YlEYe0OIsy737eW?=
 =?us-ascii?Q?p91KPk+fYQKxBlI+FWK/RMdOZ280evCqUBZjHJSuz5a9c960HIHYf4TjOOGf?=
 =?us-ascii?Q?eQa8rgkXuv162aBAW0wuNOmXbASObwOasR2SvFXYx65xweEyGKzZ+arL+CH9?=
 =?us-ascii?Q?14G9ZzMXQGBvHzAnZhGLQ93lu7nlEO1w/K8LNL1WMls3w69otyjYm+wfowx4?=
 =?us-ascii?Q?7IlXX5bu3b1CLV95uAD5fDPwvAp/um8DTo/ajRwr6DG6ry8oZEdEOlxjjpcq?=
 =?us-ascii?Q?4jRE0kEEFcNuesAzTVofW3sTBWhfijRuN4ZxXtR4yhL8ZPX6FlR3/4eVp88N?=
 =?us-ascii?Q?U57hgOJJkj8Cna+eGHVcAlih8cilmskLmukyLNb/lmcrt2uXOB43UXiOQ9+N?=
 =?us-ascii?Q?xvZm5pbZz/g6sRjUDqDZtB1OIxd1QYWDRHWcW7ciEjUlsOR9Te+Oov6B1DO0?=
 =?us-ascii?Q?oWN+jRmZNLCw9BMmbIBk0CRNjwh671iQ/EYoW04Ng+g6OipZMIgYnIiBOks2?=
 =?us-ascii?Q?9gjC5PE+5qavRU0OZcNKNiQqJIu52SYsvDpgzI1rxY2a3+U0UB69rth8mH52?=
 =?us-ascii?Q?fKXmVRrNzfIZrshzdsII9+zfrvpzszvFtrgjazN92XCTlDjiMusG9OI1u/XV?=
 =?us-ascii?Q?n982jm78JnHFcFhFOMr07SLG+vBngsxI4S7NNu33uLyZ+E12jF/3tZ5EoCAU?=
 =?us-ascii?Q?H82uhuJPYY3hjKaH/KQ4IJpwP7acDVTdAcBOvUyD0LKY+jpwL0+mVe3sdrko?=
 =?us-ascii?Q?lxvhOc/1ed1T8jxP7vkVTlqZQCkHh7QeISTzXusWgIPTf1xcm8hv67KOPiIE?=
 =?us-ascii?Q?Qev9UKWxFkL2/3KTaHWEKoWFdhacZldPdPQy9pnu1vRXHf2bBPY6pv2hYuu1?=
 =?us-ascii?Q?GI6uVL+wUxC2vka7cd1LTis3tQ9lylA9Ow3AJnw21PgufePear5TLgmDUTP2?=
 =?us-ascii?Q?ggL2H7PunW5qEt8I7B1fYX7SvRa7gSFqMH92BGgITCZEF7OOZBJGgdtqHHYP?=
 =?us-ascii?Q?C6MBZKnaUi0VPsMxvFVTOKdf45jF4jEz+5gX4uLdiR/LmmUwr4LysciBntZm?=
 =?us-ascii?Q?B1AHN6zQavB/aN5GEdho4qU4AUtUHtUXUam1Zul3RMqlMb7nnBYn8jNedJOe?=
 =?us-ascii?Q?I7HxTXormnDySSjbhmcBap2yRtGA5aIZyvwoG1oEYtqZyvkkL5KGco8tDpEs?=
 =?us-ascii?Q?L1u3AYj23DC2kFnbdbLGrZwV2XpZEHO2reb2ZMjd7jk1LvTotzGHS37vhlyh?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91aa32ae-15ad-4777-b864-08dbf5ace333
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 16:11:49.9638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VL1jF7TMez53aAzzluJZa6JW8ceGiBw7vP/hM1uLbiz/KXJhHm9nbOrZMGU6tUtnRliWhZqZiNbpyiPINxH7cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8287

When a PA sync socket is closed, the associated hcon is also unlinked
and cleaned up. If there are no other hcons marked with the
HCI_CONN_PA_SYNC flag, HCI_OP_LE_PA_TERM_SYNC is sent to controller.

Between the time of the command and the moment PA sync is terminated
in controller, residual BIGInfo reports might continue to come.
This causes a new PA sync hcon to be added, and a new socket to be
notified to user space.

This commit fixs this by adding a flag on a Broadcast listening
socket to mark when the PA sync child has been closed.

This flag is checked when BIGInfo reports are indicated in
iso_connect_ind, to avoid recreating a hcon and socket if
residual reports arrive before PA sync is terminated.

Iulia Tanasescu (1):
  Bluetooth: ISO: Avoid creating child socket if PA sync is terminating

 net/bluetooth/iso.c | 51 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)


base-commit: ab3d463ded5dfd81227fc998910c40913ce17616
-- 
2.39.2

