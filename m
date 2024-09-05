Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405C519E837
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Sep 2024 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545642; cv=fail; b=fx+O1PwZoKoT2ZYsOftC8vwuZi6VAw/GMJUDaNUN4kRQNrZ3oEpxmph1SiylMzHj6WaREECUPU+pj6veTEE8gmdb+i/JJXJ2VkTNMh/7KE7sEKM/qcz6dK7szIVDJTBgw1wgtYAkOXZ/ISVA1c0eaOeHoqGIZYQcvoTMgetTCZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545642; c=relaxed/simple;
	bh=WDs47TQP3Q3c8Ho0e5nvHqTTx+YYbA7QVv17GD2Kj+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IckTK4F8QTlCC6MmSW8wL83Nj44C8bqthGo2wZMzMHWXdLp1uh/fcKaIqMDT2Vso5GI13sM6Vg24lNDzz45LuQgzhjHLOn0XSHS9HAzL+DsQrTd2epuped936NklbFCYHJlDvIbPnVFf67YFlEOOmmqhyK3KV28coXFm59iq/zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z1nPzDU7; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z1nPzDU7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cs4gHEZVLbE95WHtxExahehmmeX+Z6srOK1S7hK7UParnWpZ7vYg99zoLyQwKNtHfN4dEClUeHqe72gUVWanfwHqD7jqyjqN5nJqI4LI0kRqGRj2hdt14JrG8r6A7gmhgNUoW5E+ap5IEb/qkBwIalr9t2DH/UJCOdiqb5Wsp1ojAynU6FuzAAOPDckHHx2mrycezamum3AcvpZmbQ+FWhBYZsBuEYESqOt5hNYCa8jODYfChWni8fgnIGGcJu6nLGxa0ju/TwiC0x0xv0yJmgNbEmKWqj5BPKF9QtEUuZMpurjtl9mwSDQy2kfqOaWraBRN+z7NTWUIdBpy/sz4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhjecJQpNHvxeAk9iryB3FwH0OOlmKPzrCRZ+5v+PTw=;
 b=y4Pd2xAeyx1KgABs8vm7uwp9VWZI6oFrE+0Nn8mZi/OC6B0R8qUGuc3TZMjDBYr2lY3mok+Wsn7oax8Ro7CEk09k1ZPbEzPGEHkdesSvliaNHGefSefZrN8NJ0Bvmdvp8Iv0rf1iLuTeyONO8yEhHaYhBpTu3fX/FIdTRj2S5z8Y/Z4E1oBYtrztxafwji1ve03N8ekhBJVBeWUnyIWG01kuEOK9uMzs3mHbD4FbsKbPXigHvUrsGtNPfz7SQJFpnx8kJx/RwUAZ3vt8uyJiZxnBzbrs87nLjVkt5iyWEzLHXyrNY+IDPLB/NLTBh4P2v1plbf7jhnuFvv63/fdzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhjecJQpNHvxeAk9iryB3FwH0OOlmKPzrCRZ+5v+PTw=;
 b=Z1nPzDU7UGtEABoDLDy75KumzGKTIHXuCJ11oPdO1z7ftutbXWGoZtey7qp6mcpbL2B+cWLpWLsSgWewO00i06LY8Gqb8UbJYVYgzs6wMm9HAXrzOOajGhWwMUT2awEGCZ+wFH8pLFOR4M7PPUQSJ+tWj38VVmo0p9jnQuSdg4Ko3zeaA9CWQeWskyNy3tz2mLd1Rb1OL4olRzJs/fWYUg3nbOmwIZZP9VWXIuC7WpDGvJ70PFHrpbHZ9PZsW+FLkZyRuBGZf4idgiNtPNNoOQYfva5cI+BtZHfh8rYBkERwzVjFMQWcqMs49qNA06/hqL9WRLvVlRNXfJc2C8CbfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAXPR04MB9108.eurprd04.prod.outlook.com (2603:10a6:102:22b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 14:13:56 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 14:13:56 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1] transport: Fix broadcast sink check
Date: Thu,  5 Sep 2024 17:13:39 +0300
Message-Id: <20240905141340.65495-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0003.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::6) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAXPR04MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e908e1-b076-4e25-8492-08dccdb4faa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8REqvj85q3C5yMFhMW1qldV4gFdHH8UU1E4XAFTb2ll9pJ1FbxB+gFXpmntu?=
 =?us-ascii?Q?qLqFWDhvPMY1NpwoZJzpZEf9nFBwp1UgBz03TNnhv5IijwnTRA5oXGMUTU3H?=
 =?us-ascii?Q?I8AKyc38SUBpgThWDtZfBcNEnhrz43gIk7VoWKwTs5OZ6r/mYrbO4FNfbKFs?=
 =?us-ascii?Q?wXw/Z+5Tglj1BqSjc7qvLNXVdMFRvSJHrmmPIsTNDHGNsHJ0ST4CYoE9262a?=
 =?us-ascii?Q?A0/aZNVFFMMe/wROeKf+5Xma1gMkRnUiE0DpGVSPYPcdwf3n0C+9pA23l1Rl?=
 =?us-ascii?Q?C8vrpaeFItQYckBUOVMckFflzcFJFV5A9dZTFkFdjxsZS9S7+Kbe9Onq6ePC?=
 =?us-ascii?Q?Y9XDApU4GU4hedgaYHHdddslSwH1GN8CS0WhUhozbYwvLVkmTJbU/wxkWHoF?=
 =?us-ascii?Q?ha+Cj5gy0jxETLBeg1G0KHdBxRFD0hQOWotMP30QWH7Xku7NH8cYFycN0PhF?=
 =?us-ascii?Q?4W1blZsim43yLtcbVwrp+hnWblUvWoN0E2kDLTrGfTgw8Hmzlm07lCnbQDSI?=
 =?us-ascii?Q?6jFWR47Gm2TQBpGc3GIppcCcyCvUdYKrv3SBylt+/alecTAV6uf+z4GskfOs?=
 =?us-ascii?Q?jgfnq1KG4NIorAgKDCg2HBQtVALTW8ygR0oZoWjpU2lZy0iSS9xmn0H0Iw3N?=
 =?us-ascii?Q?Pm1+jWY/9kvSInWRf016GY6wVwLJrnPYOo9gBsSwowrrGOK/4g90dKq2hypI?=
 =?us-ascii?Q?xvMTjYKKESMArUsK/lpdsMC93EITNYhHNQIT+qmEcUukFjoyvG4JFz/Srt7n?=
 =?us-ascii?Q?ANikZ2zeqH/bC1qBxaJnrjqjHjzhs9RYlllehfupRhvg8ynMftwiPsbmIE06?=
 =?us-ascii?Q?qj8g9fjIz0kO2kBTOKwg4vyl5dZeXfqbMDWl0er874JoVsrapF3APqOL6My+?=
 =?us-ascii?Q?KRAiPh0T3PlSQ8oGVnfqrbXzQMNhOH7ASgmVTk1cabCqZ8eGpjF3U0xpcBS2?=
 =?us-ascii?Q?9/ugkdcAytKqcrhoi8XvQImF5ZLM6Axm5q8MNjxl/GHmOmp0UPNjLQojWhZH?=
 =?us-ascii?Q?50x9sLDmxZw1oZd+koeyp04UTwMhLoPZm4/4aukxOsLD+ExGJ9X9ueSIbT+G?=
 =?us-ascii?Q?sx7KMRcrZ4JYn0x/o24za2ghCfYWFcLoTMdgQkgb9S0lb7rtbGiLfcwhlo17?=
 =?us-ascii?Q?XWg6xLAGJBCs0H+1bHA673RTlmCZxVtNStgjB3JZwWwLmPb19FBUOlWPJDOT?=
 =?us-ascii?Q?GaAAzUI7BoJxz//uPQsah4m1lq1pLjqPyLMBDyqmJCH49YTeemY1kI4hbBk5?=
 =?us-ascii?Q?y0FQHc+tV1rdiz76eT79RKSxa7nMLBSKbw6VwcjQcDiUyMu1dapthpRuzoed?=
 =?us-ascii?Q?8DGeFeDl2JscWD/WYXKOrOeqp/6C4AEBKd/zOec8pf95tY6fW+oIwM4OfjUV?=
 =?us-ascii?Q?qAHi4AtKBMsy/p0AuositJJ/lyO9J4HY90gTGAP7csRG/9/Zaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p0eXuxLq6PhAWwyVEAvoVBhieO7il1L92QqQqSnlaFZrt4jNaS5t/iaxvfP3?=
 =?us-ascii?Q?xz4GvSiwpagpvwESU3aJnUZ4AqHy/fI6fegpCNmkotC6nqyAbzE+1Ex2qko1?=
 =?us-ascii?Q?Z2ikA9acBuvjh5shrRaJGBRBW87Fja0xz1JMWXmAZynGBhtEty12Xsc0sSGS?=
 =?us-ascii?Q?lGLM4AIwKbjI487os5eE10Eqb+l1O/F6t2Ov4i9/rc8HeYEIZ500XUExGHDq?=
 =?us-ascii?Q?Q8jKDXqsRce3lfyG2ARsBYsfrjybUawAr/PpvsA3j50TmSIZn3Aei+aeuvKk?=
 =?us-ascii?Q?v/MfxNklmgPxjn843e+gGP7+wYeMf4KJeagRzKODHELHTSkpPJhUwBYcSVqH?=
 =?us-ascii?Q?nrPkfpPyY+RjLqpoMtTA/V8LeqrXwPazjKsTLA2qXUzhDmTkHv1HMaKVS/Gn?=
 =?us-ascii?Q?6k33f6nqXbVVj1fF9DlJgp4i4LBaI1EVA1uxo28/Fgqcz3woXwW716/soa/l?=
 =?us-ascii?Q?vbS5ClH1gzRH/sDtcdsUs5HmLPha5L8joUOKbH3HowvTQnswYXJpLPy0f2ua?=
 =?us-ascii?Q?ns5otVQ/AwrBQGc0CUL63hWfDBnxS9EKr7FIxqtEFdGuBNpKPzqIdQDOYP/i?=
 =?us-ascii?Q?W2Vbwejib7Vo/hVWcUXxoWwY/eF1tPFoB7fuIiCat5zhG8e9bJ+INHOU+byd?=
 =?us-ascii?Q?MaElaZNAql4R+frJRJIUYvRRNZS8DJ0x9ICjWwS+yUgnV6HeCcoIAbuQUqqB?=
 =?us-ascii?Q?MLfhj9Guc9m//YgNptLPBlBxxyR73a1KTISAu/mD9wFBVLnryA973MJioHG5?=
 =?us-ascii?Q?RwVCpUjDgYXXAYhOeCBtDZsGtU3oy56qqGEOG8bCsM3M4ytm7gjSN9PQ0Y55?=
 =?us-ascii?Q?KCMRu3xnNwQf/9/eN5RtPZSfopZ/CH1WuTqRXIeqiMIl6RWtz+cmHTxVB63E?=
 =?us-ascii?Q?Ii89AkHW+Qn4vyPP69n6XEiHd1pgYctna+poslirxaDHNeAwcXCQyIQYRfr9?=
 =?us-ascii?Q?8YLXaxOJXLMBWi4EgKecyHiFNr3TamqFIL7Jv75sfG/nwoSPuEQmLnM24ZfD?=
 =?us-ascii?Q?j++4csVVA7G+AEmdXR5BmV8SeRygqZ8HHhc+r64Z+0XPWX/hKH0lWn0tqKi6?=
 =?us-ascii?Q?bLQs2QWeYpFlJ4eVFxN5fj0uoDw571Zuei0ZbETlV+LnxnUwZ8eLr/9CWGQO?=
 =?us-ascii?Q?lWkDDx2ZFnnsrZQN0fVl///2znS+PLYVQB78Aq2J5AFN2ails1LW9WHRIE48?=
 =?us-ascii?Q?L+jmbJ+OluNs5Ub4mgnGYotTdmnnQ97whp5Qc19k0x/4iLW+sSk2nobI7re6?=
 =?us-ascii?Q?5I81bzNRs3/PPiYzo7JqzvKyAqyMupol1FG9TLdznjm8KPJeXEdlMfaEqpsQ?=
 =?us-ascii?Q?n7PmpcyYfCu7V8iNi0Go02PvRiG2ZvW7sJTJPkMd8owK0H7fwRIqWi/gSUcz?=
 =?us-ascii?Q?mnPfdmH0XDKAYjJTRzheWfeX30Zzj5iqq73W2ysZ6zOuk0x10UmvHUofqxyo?=
 =?us-ascii?Q?8eS8aMIDErSdrELaaqSOWrtR+/SzcQFTi5f+p+UEqFG7aybZ2fKe8NLjvE/8?=
 =?us-ascii?Q?YNZxKK/B+3iTFelBdlga1n/cEqUzNwYPPJHq30Cm++5fpyyMvpxkyUnc8/Fj?=
 =?us-ascii?Q?JjDMdngIITkOExgntlVZiSvJaPQ8MYMETyzOeSmM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e908e1-b076-4e25-8492-08dccdb4faa1
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 14:13:56.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWggLNifvoSvemnKkiUHceumcYT+OKhYz/qeKZO0hlkYJwx0OWM+6E6bvcD6c4w8fEvyw6U79bo6MLb5cJBsPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9108

In transport_update_playing a check is performed to guard the path
which contains the TRANSPORT_STATE_BROADCASTING state. This branch
should be taken only when the device on which the code runs is a
broadcast sink. Thus, the UUID check is wrong, and this patch
updates it appropriately.

Vlad Pruteanu (1):
  transport: Fix broadcast sink check

 profiles/audio/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.40.1

