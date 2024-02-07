Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA27259B60
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Feb 2024 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308598; cv=fail; b=QTzXXg2Z6thXgMFU/ZGaRnZN6UkIu6URDPcUk8SP04au63opGuNn610UMd4rUOzcdGiExghfFd64xWPveN/CsKSYm2fg8glSU90pZk9P2BxcFgl42Biw8mkmLFM/5vGMgWlYuGRYwhw3wDcFvuUK9o0LbmVqGh/m/yf2U7W9Fsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308598; c=relaxed/simple;
	bh=dJBZAsbd/XKGwIf7ZdtqhR4di919QLblIHB26SlU0Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EyTDVyAsojOJp4SZR3RtwB7+8P6J6WCr5WOdbQvJHUJ175C8UnK76jRpv5lE8J665qzdspNNxWe+umqr8BbpkjooLGbtBDp3jP8aQDLzBQpXH9m2gF1jMTzbyk2oxbifMN5x75VngaQlqcozMSpI4z1u2/cKh8QwCQ5rdZqtZBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ALj8hl/A; arc=fail smtp.client-ip=40.107.105.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ALj8hl/A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Joa/6k6JnzTHChScs3+e9+sa6VDvwDWgoAbiTU3Zaet4JekRBhCyzPE29SQus1IImsELqlCcB7bOSe8xgujE2zv4ERM/aDoITJnw0IJCoFAhjHN1Xm10ix1HH4K0Y3F4Blic619TNd08NnQ0EwzsavmscjsSRJFRA6ZlwrvSMjncr7LOthtg8ebMsL3wCRVEC3H/LCGHlrV7xmA9FMyY0I0ay5JmiyaIDO4vG4gqwsAwHh7cg7BAwx4Q/7OjJBMPepVhg9haZ2zDncD03g7ZexEcTMFZAVH8sD5bDy+IUIWLhppnvcBedPYPojwEOev9wk1/MnN3e0qqqokvjHV1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5O5qZOlS03+Tuq9qD6OyJCCY+2GtNI3hC8LnC0+wo+E=;
 b=h1/qGw5d4HtDKnvQpSWzAX4N9eyGB+kmbSf4GUFI9KiNy9/2QKtjYRxRFtjj6u3L7xet5s0H4NBC13YjoB/J8C6rs/yKWS+f8iksqDCXiwOoM2e6OccMmlUv+9tI6/MViRaNKhKXOQcHdqtdRzHUT/a3x7IrUDAC8+iXYhwXZPBU2k5EbFLLn8esgl/NAzdTsktKmLN82dQsf8sY0hgLssXUwlaN2Tej0wUpvMkrZAmL2nV1Lo07m7YqCLyAu6zBDV8Y3ovsXahZRMjBW1QaFWHqQjCmsNoUrZGSMZBUpJpwxmowm5KZLEEQ/57xRdYub/XXnWu7AvabTLAZvDRbnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5O5qZOlS03+Tuq9qD6OyJCCY+2GtNI3hC8LnC0+wo+E=;
 b=ALj8hl/ADjkT/4jzCKaE6N4SQmQfZ3SiPSQ0dT9u5ksl7oSwr9CRm18gCmgy828uKVG9rsyHovb00WZ/bpvgX7u60bG7ntL4f4/0jKb5QoqSgaR1htLSdzgetmWXlYCfwu1On1rxAk3kpaLSRSM+j/KZDQp0PHFZW6cMA/J89uE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by GVXPR04MB9851.eurprd04.prod.outlook.com (2603:10a6:150:118::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 12:23:12 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 12:23:12 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 0/3] Update Sink BASE management
Date: Wed,  7 Feb 2024 14:23:05 +0200
Message-Id: <20240207122308.26457-1-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0055.eurprd03.prod.outlook.com (2603:10a6:208::32)
 To AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|GVXPR04MB9851:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4e1901-fc2a-4192-dc21-08dc27d78d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8trq96Sxs05sZLKufgiIBYGimmz4v7Y0OIOPn91Oq76uLqn0C1/zhwYpq0rrLjPwsTCfklGEDQcmIrXFZKCKsKYOrIkWXSjz0BJ16duBrxTmNeD9E4+Jiy5nytEgrFhoqzYMR0OxfmlZjRUoxWJQWE0YB4jLYW7qLbmn6VO3eeddGavbYAkLRid0knz6Obtrl3xmLSz/ZlHkDE3ZiqS+OsC+V0bmN5XsFOiABLH1I0R8Fqec4GcjRlqGRxjz5J9msaVe14oU2e1YN0+6hoi3sf+CmmYZbHrf92mmXp3zyNVYtAyd0m7Wwpbv0+iz3JL1e18Jt2JIk6eMxZ2fzbRvKsCBtmhCSsG335xIz4jtmLdBWTe6VojrLjx+2B/o0vTvzVG+rmtjfMsXQKLynvYG+sr0c5JihIDunG5vA42ks3MkHdTXZQx98nt9qhpaQ3lpd4Sn9Bofp0jX8UatTGdvdsUYJ1ubCFEnPzQA6eEbZS97roDAYPidRVmN0qESJQXzkJTdKEzLnrItvRQLE1xs1xaqMO/hQzAJsbEj8nVriauEKGVzKJnkBMhl30+xQoWQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6666004)(6506007)(38100700002)(83380400001)(26005)(86362001)(41300700001)(1076003)(2616005)(8676002)(6512007)(4326008)(8936002)(36756003)(478600001)(2906002)(4744005)(5660300002)(6486002)(66556008)(6916009)(66946007)(66476007)(316002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R39tJvLXFdhLfT0mzJaBPvWXPywlSjgznNsyJUy0O1gEWUdDAhHW+D1Uzl8o?=
 =?us-ascii?Q?Kwdn97SL03EP7ugXRue15Db5B5l/VQQORb/mDFfQQQ2a01SVy2iGMtBmkzjY?=
 =?us-ascii?Q?eYAJ/camsINYvVgsv1nYFZ++fHXlNpia8LfpuPD1R60EJ1RHIEyxEPxFvzxL?=
 =?us-ascii?Q?fgOcnQlRYQnAyFwfK2ZND69grAvgpXKAl56/A8pFHpeJ22B0xtA9ugsSJ+GV?=
 =?us-ascii?Q?mKJYRwp5TkIJKm/Zeer1ug4Uvj6fE4G9YtDVEOqzZuLswQ6pdSVfNkFn42+c?=
 =?us-ascii?Q?r3UWfU2Pnh+QRwuJGBZ/Wz0vWUGbJANvymcwsXjPQryChan1bygds87YGWeM?=
 =?us-ascii?Q?1XeSEmQ3MPiH/0P7EIDjC6S27yfFQugZ8I9wyMI13yer/9DlYF/6OwlS3Q1+?=
 =?us-ascii?Q?7x+KjeMXjRoQQ+dzc1Nl/G2Mv8Daht10RPydXR3NEMIwJluGKPsqJRt8ZmQB?=
 =?us-ascii?Q?hg2il9QbLGbDETvPsLKnuJG+HDt1lIZ4h8uO+1zecVNYSQWxyIBs1v91MDvl?=
 =?us-ascii?Q?/o/BW/+1ui5mWRdWbxjqs241jPBhchOuNHzi3KLBzXD1ieALx8oDVsO3/HYL?=
 =?us-ascii?Q?V6LpXAaBF4jFzUVwHBEidhToy620RRmBS6D14PyKe1G+6WEw32CmeFklDCy/?=
 =?us-ascii?Q?RjmLBRQcBzZ4Z+1YtnfjJ59HgVo8/CV1Woh8bYpACU4QMu8xg3YhhsH9bpAs?=
 =?us-ascii?Q?fluneB9Pzct638BexBRdpHBUCQpcY8jckqMEQORDPmCY3lVhd9qcKjBmp/hb?=
 =?us-ascii?Q?ZQ4role7+j30rPXMei8esqt5q/W7gZ9LvPCVOvgfo4Q00rlX0kG9MMx2ocVC?=
 =?us-ascii?Q?puMcBHSnSFW1r2KPysNHrhTkhLnxW0MmqqrZZDxSKUEqWmwmSOBEeZA5iorS?=
 =?us-ascii?Q?aiVy1grhJdaYQXWGSXWgOQ+LjzogpMxsPRRC11gjOc+jNtW/YFfRot2jRKUJ?=
 =?us-ascii?Q?fxjE7Hxcx7gRBAS7Ohm823VHJEgry+nZiNwPdE/NX/O9xxhsEFOgSQbAGAl7?=
 =?us-ascii?Q?+a8OaLr5zTy2WnojMoGh4b6r5//AH+H585fJGXkbeeOQ4pzDD3cwld45vu7a?=
 =?us-ascii?Q?aSLvKTy1kd7BjhvY09TzP6UQiKa+KIp0Qo5RQmXmGbEfcGOhzcpvNVqvKVF1?=
 =?us-ascii?Q?cMXerNFym4/PCiYOddC7w7vWoEID6QcTpywlFA42+WEu18dWF9Zgqg+Iaxsz?=
 =?us-ascii?Q?E/tSvZBjHaevRFQC+6rvzmocPt4RgxhbIk0MKja8/hBcC0mUuLhnpREBQ1EI?=
 =?us-ascii?Q?AIFO2BdJ6FIEx9eU9FTK/gFHvydZU+kF3DGWEgAlvVnamBB+ebxWIvIeVD32?=
 =?us-ascii?Q?thoKXgt2AWBOxyEargP48zPxAwSivNPYFlI60V/4NKn0bzb344LiNM3ZyFWg?=
 =?us-ascii?Q?Gw8nYcfIc6WJnIVrHsYE2ZvGIe2Y0i9JANaZ6H59Lb8mcGJbDlB3MyFVc7pp?=
 =?us-ascii?Q?V/1omORt8KL7O68NAKsFwhTrcWgzX1iBou3HmN40OU3YsNdwI2genk3/RM5C?=
 =?us-ascii?Q?sxU29mFSf8+uPqu75v/qWSV7UciC3IScIELV2cGjxwFb/cl06PfamPAL5M+S?=
 =?us-ascii?Q?gVAi5wflZN1YFkJXUqGhgfiz5TOdS95Gmxzax+L8aJ9Lnx+AU4nojMrfiPFY?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4e1901-fc2a-4192-dc21-08dc27d78d76
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 12:23:12.5828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DgMfOAV8GkDhopFR0yahN1ByZQPqLybYXU51CLOswgk0a/SSKKsulVd7PP7F1zr76o7UVtV4wu5sMpIihom4MBU/ShwYsk3Oh2MhRvRRGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9851

This patch refactors the flow for the BAP Broadcast Sink.
After discovering a new Broadcast Source a short PA Sync will be tried. 
Depending on the BASE information present in the PA and the local PACS 
capabilities of the Sink, one remote media endpoint will be created for 
each compatible BIS.
Configuring one of these endpoints results in creating a stream and a 
media transport for the corresponding BIS.


Andrei Istodorescu (3):
  shared/bap: Add API to convert BASE into bt_bap_base queue
  shared/bap: Add API to convert parsed BASE into pac data
  bap: Do PA Sync for each BAP Broadcast source discovered

 profiles/audio/bap.c | 324 ++++++++++------------------
 src/shared/bap.c     | 502 +++++++++++++++++++++++++++++++++++++++----
 src/shared/bap.h     |  34 ++-
 3 files changed, 602 insertions(+), 258 deletions(-)

-- 
2.40.1

