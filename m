Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74EE84A2E
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497199; cv=fail; b=qWa9X7Fs+v0f8ayPf00d7GCJJ8vI/iD96tNQJqY3Evac+EkjD0HB1o2PQYsSljwPU+om99iiTHFpr1bUWjAmP90MM/RfteVrEo72A4mOZLu7d2xaI00Y66xGM7G15m1At6IvSmUpYHcbWnzWIGRWI1xOeX4JIs0WxiBMpEwC0Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497199; c=relaxed/simple;
	bh=TebVeTQC4WBqVbnHMOR6OEWg0+mKAvFzgo3kfGOwDsI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bwfbQY7D/wNxxoS64BpVgJv+alYNRn3PB30xJ+6q3d3UjPjPQ7Ov6n4wEbG/Mn1vcV9pdb3CsA3jKRb+but8yX1ly5ZZKqCeGGMkPBfJt0OEmu4I4vaeHM77FRE42PnBUBlkvPesBhi64LkoyYDzNV7XC6iNtpstj3UOMAgdAEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=j/2r7G/t; arc=fail smtp.client-ip=40.107.104.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j/2r7G/t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJej1wdihul+se01aiboKYF4yEZR5v6+GizMvKgBt+wLiioAJGwlw44Miho4QoxGMC6oPkoihM46ewDXXWdhogdJlyROEgMvMxx8lR3dyfEF26z7VVel+FdrigUULG9Og5k9E0hJ9IRCxRAyagYb9tJtTz9rlpjwSs/esxabMFZqU8YoF/FcnvugcJ9oialGKuvg8wYh3ef9XvXUtUkuZxjL3au0mbIepNljAdr1GggTHPdG6IBxUXDD6m5DHpmi9dRwZ/TwTQJ3qfN2qt/3uCO39Sr1nXHIqL6bPHHrJIod+LbG8sVy+JMy195D8ehyO6e9/fRFtUVcNkLG2nzL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+qRvfj0k5OPAPjFcviD02hWV7eQ/k9vJAtwHqgSATk=;
 b=OvhzdrtgFigewA1+NTno01YLwOINgBFGtbbhxbsR2bYAYerASDNOFvrE/CLpyq5ARJ4iqkX4xk53kb5t1gjGxcQtn+gA4NswCdaHx+aBeQAzypQob6B6WtStV+ZGhBn40DWPxqy0Wj3AJz4j3iuQ5K5JI7jvqXJMTZuVJuTnNacn+y4YIVpclYKe8GPDWGpOBeO0VA3qCUGZiWEH4XgmFS8eUwpdQB3iOgzjTeK7fOpP0XA7l4VLcYrgk0vF2otIgaflL5+1quGnrv6/pxhx+TvQYjboGS+168NtPrSUPDzcO32jf1rGfKl3iKcb7lSNnU093sh7IHEOB9AHnJibYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+qRvfj0k5OPAPjFcviD02hWV7eQ/k9vJAtwHqgSATk=;
 b=j/2r7G/teEUNQb5+JBKN/xLiZI6yd45GMR6WaJSmwpQcEQc4wzvLCY7KmQKGLPPxXj2eG/ToEqgdhj2G3VimFfUtvznTiuuyJZj4STrAooz8TLoz6ISq/D5ZsU4n0w5sVr5V8blfYevaE4v5jwKCaZqZHsptNognPMmH1Bn4al8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 16:46:34 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7249.039; Fri, 9 Feb 2024
 16:46:34 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 0/3] Update Sink BASE management
Date: Fri,  9 Feb 2024 18:46:24 +0200
Message-Id: <20240209164630.92208-1-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::18) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|DB8PR04MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: bef0bccb-6b3a-4175-9f84-08dc298eaccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r7kZaFdqlz2y1nr9q5uV0mYnOKp32SOCwRqvV/u6zuHNGw9IQ87TSradrXqPfn0I6gRHKEdLQrogSA5wkCpc15WA1ONNrFj8MsNhYQVIcNv1A4ngWC7Y30CmGiyUtvrQqvzw1WqNp1FJRI4kE5s5YoXN6KjtedVvJwL6pf6BawBFdBSIjYIvWiSpMk5SvKnEoVWew9fzJ/gN/YKlK64t41XD06StWuPi2IIs4AMb2t6nfhX1G+K4wdqd38kWbLt+8eWvuXhlO4krpn/aZKyKox3WVFHVepmUHPft+L/R6D7l8j71fDljigLNdIh1bIjHZKulm3p9/U6cORBeNeDttQQco2mYLERnoacx7/IT0vpO88HEviWXDqatZy6qAq7Vyw5QFi8BXPELUUoJBz1tFhd43W7xl6yJG3bXPneeiC2wEjWRiaxYnTGeDtnA+VST8snYmSmPkR1SSmnMBkOwjf5NcqwpJVXhTAGAuaAhHrfYWrwMBn2FevTztb7COM+qNgLBnc9xj0CHFvUhNXIFqhsy1oZ7Kzo4X3ClkA4YuR694umdthqiNebFjlczNhDO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(4326008)(5660300002)(6916009)(66556008)(66946007)(8676002)(66476007)(8936002)(44832011)(2906002)(83380400001)(26005)(36756003)(86362001)(38100700002)(1076003)(6666004)(316002)(478600001)(41300700001)(6486002)(6506007)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cK6kTZP4hgBStvo44EB9xX++z9MHYToIysKMaFUct6+nmY0WSJVLebsmjbG3?=
 =?us-ascii?Q?fnGNEh2AStGpSW3GVUx4qa9RLua1hGb0AiTiWRV/rQyY3FrXrn9g9SDt4mNp?=
 =?us-ascii?Q?mUARTMwLtlp6Fk5J8ujr6s4ZDQaT3HC6VNV7p6FjZ9rf75Upg1nSQz3aicGD?=
 =?us-ascii?Q?QvMZvfgTPCqbuDxyQwslXOhqy/23PBiChOSUNFajcii45L9rRhswFqXnyXRa?=
 =?us-ascii?Q?dDpIqv2Q/8zgLxDLv/EJ9u8hFD/PtAh4293mY1SMc50p90C2VOl/qeLdvDSI?=
 =?us-ascii?Q?ehMg5ILHNuTpLd+CWMoLXZjXbjZiDMTwnrEsEAy4iCwYrT8DIFp3opFj8U26?=
 =?us-ascii?Q?FQz7IMi7CMRBmULtErz3AgYzRZTOy4cIlsuuh0FPGUO6pkugGsw8+yIdc6Bq?=
 =?us-ascii?Q?hee8YdMHmzgLFWbYVchTqGQi8D0XAcUsWKzHdGFbftNc7ciKzEug/Ouet6+4?=
 =?us-ascii?Q?MDJ3Xj24SHriKKNb2Jw1lQqfju11nIBwMVhpmws4wOSGhKSb1vRjWZQ7IKCv?=
 =?us-ascii?Q?KFWTPBdSGcFKv9me/EXfGCoT4YwEPqv/2KjrldmiRGedDWzCkn7Nqrtk10y6?=
 =?us-ascii?Q?jTmpoTI2yWmppKSwAmAH6KWrUkJ8fK/5bqi4/w1lRygLWJqj8Be4UZQlbvMd?=
 =?us-ascii?Q?vdzu19WbGtaXR4xYlQYjsLshyGyyUKCQ2LH1zkqGeTjOeVf5l6Qw3Sz8Lt+U?=
 =?us-ascii?Q?JaFkrWbaRYW6XU5Bzg36WPDPt6g0NULFvE7+6EI8QdV8t4IBh2hs3enEpvGo?=
 =?us-ascii?Q?QezvhwnJObvEiEx16fi6cALIFcNEgRzwktcr2aYN2xp8tIG4DSfvm+H+g/zE?=
 =?us-ascii?Q?zGDn2rkEW/7ka1UhqSj5yzw1ucjWQcNHJCDO0EzPnGUNAura7Taz1BY2KgBf?=
 =?us-ascii?Q?Oyx7SoMJxUd6ZY88s67R3OQ9wMY9JVRpwVJk6uBteLum4XCf6iuc7YsvNht+?=
 =?us-ascii?Q?lEBKylAScWrHh6oA7I7M7EMPJhLk8yGpT+4KveUIBDZtHjYBYshd5o4CrOdu?=
 =?us-ascii?Q?MhrzD4LY5bpEQZXehRqDikmRA6cffnZKkG6rXJppaGz6MkCFTasa1hmMMvOf?=
 =?us-ascii?Q?DM8s5CYHcijccLstr6F1KarUIiZlyT1vfQ7fsG6kiTaETvUt33f3cCA+eCqM?=
 =?us-ascii?Q?KgpzLboEZWGRuOF8OOVfOIQkpHgtHIDPR0KeucJL+RZ2UL7ELA48ebZV3Ubk?=
 =?us-ascii?Q?4Wt6stqccKuLFtqT0Jjtwe3ibtB5JLpJ1pNCBeakeeUxbzMPOFmV8HUTQeaQ?=
 =?us-ascii?Q?+XnkNJ8HvMXq+X54qvzxXVb/3Uz9uTVPOcpwbI95APbPuYpZ05Mf7nfw+8Sn?=
 =?us-ascii?Q?AHby6Wlrjr1XPV+p7GFKQ4Ysqq9tykXZKDi91ypFQaKguWi2RfmS5UlJJERI?=
 =?us-ascii?Q?KbaShTN3iSUJVLuuIyRJdkPrG/A9Cwsu+Y1662rJ8mh5fMLrAg+CpqbMaga/?=
 =?us-ascii?Q?IuctTf+Ogt4mG1vMS/RZyqX+VrjQ5VTplLpEANUtRbimLkZ/wpajHg1uMNLf?=
 =?us-ascii?Q?kWzUlRWmJcDYlrwd30ezE4vUZ1dnyFS8j3zn/FgjLsL9ttU1i9rU8tYKRLB2?=
 =?us-ascii?Q?tpB4sNRvH/ApSWWCPT5jvoF4+W8ZDQ5ZsQNJMocn9htEm0P/XArqdP3uz9iq?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef0bccb-6b3a-4175-9f84-08dc298eaccc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 16:46:34.2132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oztS7pvwCoqDWLm3AI7WFYozOEbf3kx24Y4djd497FeyKPDgxIggzz2lXVA9oqFNtWFMEClgpcePfty/F/4LY0QLWhjT3BVWbGZEflPcQ4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7097

This patch refactors the flow for the BAP Broadcast Sink.
After discovering a new Broadcast Source a short PA Sync will be tried. 
Depending on the BASE information present in the PA and the local PACS 
capabilities of the Sink, one remote media endpoint will be created for 
each compatible BIS.
Configuring one of these endpoints results in creating a stream and a 
media transport for the corresponding BIS.


Andrei Istodorescu (6):
  shared/bap: Add API to convert BASE into bt_bap_base queue
  shared/bap: Add API to convert parsed BASE into pac data
  btio: Check for non-zero qos before setting it
  shared/bap: Add Broadcast QOS copy functions
  bap: Do PA Sync for each BAP Broadcast source discovered
  shared/bap: Remove stream double configuration

 btio/btio.c          |  12 +-
 profiles/audio/bap.c | 308 ++++++++----------------
 src/shared/bap.c     | 547 +++++++++++++++++++++++++++++++++++++++----
 src/shared/bap.h     |  38 ++-
 4 files changed, 643 insertions(+), 262 deletions(-)


base-commit: c1851987ca2c6e41d1e0e166e959b754e369c254
-- 
2.40.1

