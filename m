Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4042F568A
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916760; cv=fail; b=l0t3YvgRy08BOxqM4PFL5Ty2qf4fYilDn+teX3WQfWKYzyh/StZ5fthJAabME255XCCwmKNWWDNjt9VlPHLdk6vVc13nuvb1aeYVa+wY3mUVDREmebUIAOfvW7E+opBuj61RlpcdSSgFiMbRZtGqDZniDRir4cp+Li0snyGCB34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916760; c=relaxed/simple;
	bh=4xgurhMLcRx9TWGKRKFZID7ox65uFgqtVzu+F86XhGY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GL6mjqy6Q9Wn2Fg8MAOZqzm9yCDH7qziEOaYj2BrVFVA7xAuooIHLG/Alo/UV5G/uxZArBUJvYmlSiJ87IEFm88RcGKG17dPM8y3Y1oKTE4/kmhDcAXDcNNKcBW+JAOHsJxu/SAmMS4RnF6KyPBTMcgRQnbYdQWOwy4Tu2YVdgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jvpD2K9L; arc=fail smtp.client-ip=40.107.8.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jvpD2K9L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBKr2to1TQvDEQ19+T91nRk4H63pcdYsGm588rnRc/iNIoApqpxfWqP1lTIXPABzij5Fvk0ihexoJuMavZvl6IdsWiMsINTPF7KyAyL1sZ7fvGMNbpDnK2Ei3kU76VeWMegsr2JHcqsn45+M1MBfWQKwv3TBl5M3cqnoUa57B+JxGMZJTymabzyzaIqoMq4DgEIJa9Gw+SLLrXiEu0+JPenZ3wrJl2ay//pYDV8l++zdZOEvrupJzTla6g8m4Sh8L4zUy56Ly+E1HP5SCYWYjStxYv3a59/c9dvikXd8SKxtCR/7n+lJ7IWekkWaQpfJaQk6aq4mkFApZsg3KgweQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pN7C0KhxMzpidGYAMnylESPOV5gsxSoKCGNP46EOgEQ=;
 b=FSR8cPzV8K0GUIxXWtRE9WzCzMZnzgV4SOlm9E/R5Zw0cvUG39WJgAFfu6R0af9r5Tfl6P/vK71Lf2kcXbrRwF6+UEu0DqILqp6mfzTPqyXK0+7UXKh38ag1hw6bpS6Myhfik5jnFsSphZhfo8cOcUn3H0RFiIOZmGAx2EZ7jYcLLciFc8hKdYM85urgk1ZnjP+0zA5Y0D1xAIotozwNQfa7dzK+7uceJL9g1SBkS57b+K74qx60auATLzm9In3MFUHierjrQTMPTQsMw7ryt+yKk6pdJ5uWVvA4uvgNafu4b9XcPDQ4elyyo7iN+PsFiwPC8qgddKpattXKuaeS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN7C0KhxMzpidGYAMnylESPOV5gsxSoKCGNP46EOgEQ=;
 b=jvpD2K9LeFnEUOKQQ/fc7npS9E6gejvvNSu1lpKtuDkKRdS+mXoaatR75uab932hvZrZSDd7BBzxMsDIiQgUvOVTq0usIkJUI8S3PjvFElO5Wx+yc+O2cxoDk9gtJjX3vMvGWCEzheI3qMgfhqtFH+GeiCbwDW+/dhURajc4wzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM9PR04MB7572.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 16:52:35 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 16:52:35 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 0/3] Broadcast source reconfiguration support
Date: Fri,  8 Mar 2024 18:52:29 +0200
Message-Id: <20240308165232.53906-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0014.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::17) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM9PR04MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd2154a-1531-41a1-ee5e-08dc3f902774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	odXDxbjbYwMNVnoKquKRYTEiXJ/T9zGH2T+pha30z7aou7RyQhdMtaNadnFdxlZWx+2wqMUH1tnnlhB5MGtesngsxAXyizOEEy06Hz5sm1WmIVCGHqZPSCVaQtWxw2vpN1t1rMPssoF1CWddf0D/I3dmd5RwYrsmufSgLZ3VnSkUBY6aq6hAEGwTxH7ZAdUVYr9zEi/eNDa0nSZqBGSVDgtp2lwTYc4anlDzb/mVQLTlBjN8ssCduLQh2kbjBuovAB+tgEO0WSiRUoqk94Lm7+Ok+JcLKMuqvWw4vN2HhXNb7d7G+w07gObtYolQmdlSWzdmp3O0lYKUyCYxQ8a5JOTXfoZx2fAmsiyKDhlhErNfKtZd+siADylFpmnW4xo40uC4vm8kclqS8ulinYl7N3+G0n53tMQ3jnh6JXMhWnL7qVc4q16r1suDUid58+jootpCWTbx5rTltVpALv+yw1MOuVrosrNa1dWnMD4vMFweJzu0xJGFwTXMl70rT+rf4dpjxCzdBMrBPh0sO1uo8fRzpscp4qWOo4lQBqJBOo3eyEy9bMTXcCco89xahBJWor0Fb1z8VoS8PZqgoBrISD2zHWL8COIXAYhEgxrTUNpr9iUT5ZFKkL3Vq8QSoILw/hemSkMuPtb7vb+dChIEg5TLGfKMAJUq29ZSdpAY9p4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JOvQy0d0jMWH6vllNcDe5Ci2k9sLrX3N9ar1a7eV8WTytzq/KHLDKPuM1x29?=
 =?us-ascii?Q?IYsC2iZUZVU0sI6/sqVVhTkVgAV9JMbpYBgWS3j9PhG2kbCgAOevTPTJVZNX?=
 =?us-ascii?Q?1BFoed7ri1P9kAuYgCTLsghXzudhAWH7tYIhR18O8ossHYjSMJW7NyTnue2C?=
 =?us-ascii?Q?cV0RWlBMfQ91JlOv63Khica0YntvtsdOBh6E/YXaoJ5747UbnG6erx738RBM?=
 =?us-ascii?Q?iH/SQHavywHVuS1aTI+WOI/WZv8bmvRtDtHzWHJI5nFeT/hai+D4lHJdXbRa?=
 =?us-ascii?Q?xEsy84DnnhS3x4fPjbRm78cLjADtioKm5CeKJrmzlkCFhble4SdCuU3mMcAr?=
 =?us-ascii?Q?xfbk/Aoh3QHjcQ7GyYKLWuiXnudvTKfJpqfBZUD5BOB3khU2/boqSHZ1aDRL?=
 =?us-ascii?Q?85Y/doTDQi42/5Y6+aRZNc4RA0BmhNpx48ffWZlv6xw7cSVxWZgKqLWLXwiC?=
 =?us-ascii?Q?bdLFzpVM5mIteVknrjYhupF2naeg8kwZsBu3x6A4XfzQbo5Yh0RQsiUWEdAT?=
 =?us-ascii?Q?Dtvp9spalPKSi6VhMlz0sh6JlUbIzRiD//hyKTSiCAw+lUc9rKLCT8iRlFlo?=
 =?us-ascii?Q?leHqgNKfRA0QGV/lJqyUGyL4ZHELHERg24gY0N3d/94CJbWJy6GCtesn5X/8?=
 =?us-ascii?Q?B8KM5FXCzvfYaPBcaVxDuSmNoyzmBrePtKxCAkAtQkNEgD3dOBKCfd35/PUl?=
 =?us-ascii?Q?B1hyUMu8twulTwwhJfzViMmJVDVUVwTME47g1CTmYtTG+f0ZpSW4wTYql9U9?=
 =?us-ascii?Q?DWuawh4LjwJv/bD5uMbuiLAF8suydmIpAODTnOERW9upx8KoQLd/INqXs0zE?=
 =?us-ascii?Q?nS0Y7d/ObiGLiS0Bqf82x3FCpjbxs19xCuJhPxrEsM8AR0AtgQS9csE/AANE?=
 =?us-ascii?Q?eEr7lihhPRVr0hXLxtbYXz1/jTh0OcsP3xT4gMvgwIvDeTN5b/GMhUgYlqel?=
 =?us-ascii?Q?sJVtrurf+6T4936c6zt4Mrs+5RP3EBKnegJBRuVXEeNNKU14uJd/PK/97etj?=
 =?us-ascii?Q?tbtx9WWrxukP3JDGTFvt2T8ckya6nnps3lOBCdz3dGip5e5mEywVYjrOEETk?=
 =?us-ascii?Q?euTpBQ+/OV55ApsSO6pEb0G59aIl79vUCvD8Ih711wqQab+ApxGchTjFYMfG?=
 =?us-ascii?Q?5zcz5DxEVRp5XvUmzo14r9EJu5tbpJV0ADHS8xdl17Pda5Kk75KmrmwDVvHy?=
 =?us-ascii?Q?v4xTnI6ZBOlnAc2KGw9uQhyIvffST8z4biug0YU+sKxkz1XlLdJU25qot8w7?=
 =?us-ascii?Q?GJVpNCq6OykBqr2fRyDHIzRSuQJHMOmouiV/w+qm4MDSMoL7TxUyRpscuV2K?=
 =?us-ascii?Q?+czb6r52fAfFofGVPJE6ChsEBrn3dBfEfsKbOWgLOQX/y9vivjxX8BTLUI7+?=
 =?us-ascii?Q?EvNA9dXFeAc/0k/53YGz9kXazUDf1+w13rOfuanH6po4eI/wMwXv4RVZv0aZ?=
 =?us-ascii?Q?2+j8SHxG9918z6un+Uap22yHE9NoX0b8ntShZWuaydi5YWKIqw6+VZ7QLwpz?=
 =?us-ascii?Q?Tle/gVdQ6gOD12GLcx1Z2MYDLwf4eHtxVFv++XoqF2woh0RYZYACqrT1CgVx?=
 =?us-ascii?Q?g/jxi7ZWLqIz5DwuKQRt+a3MLqnJLhLlyy09kOJe1oJbsBt5/nDQ2JnhHwjW?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd2154a-1531-41a1-ee5e-08dc3f902774
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 16:52:35.0697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2T+thd6ynkUR338hUEwy3+czhcS61FVtyMDG9we5GuSlJRSKNo8kVOch2OeE12mb1D3hrTkdUF9682oK++Om609CQmQ7b/sZ7YFr+QfButg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7572

This patch adds support for broadcast source to reconfigure a BIS.
endpoint.config command has a new prompt for broadcast source:
" This is a BIS Reconfiguration? (yes/no)"
Yes or y if a BIS reconfiguration is required
No or n if it is a new BIS configuration
"The BIS index is assigned in the order of the configuration
starting with 1"
"BIS Index (value):" a value representing the BIS index if this is a
BIS reconfiguration.
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
This is a BIS Reconfiguration? (yes/no): n
[/local/endpoint/ep0] BIG (auto/value): 0
[/local/endpoint/ep0] Enter channel location (value/no): 1
[/local/endpoint/ep0] Enter Metadata (value/no): n
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] This is a BIS Reconfiguration? (yes/no): y
The BIS index is assigned in the order of the configuration
starting with 1
[/local/endpoint/ep0] BIS Index (value): 1
[/local/endpoint/ep0] BIG (auto/value): 0
[/local/endpoint/ep0] Enter channel location (value/no): 2
[/local/endpoint/ep0] Enter Metadata (value/no): n
transport.show /org/bluez/hci0/pac_bcast0/fd0 to view the update
Transport /org/bluez/hci0/pac_bcast0/fd0

Configuration.Location: 0x00000002
Configuration.Location: Front Right (0x00000002)


Silviu Florian Barbulescu (3):
  player: Add reconfiguration prompt for broadcast source
  transport: Add support to update the transport configuration
  bap: Broadcast source reconfiguration support added

 client/player.c            | 46 ++++++++++++++++++++-
 profiles/audio/bap.c       | 85 ++++++++++++++++++++++++++++++++++++++
 profiles/audio/media.c     |  3 +-
 profiles/audio/transport.c | 23 +++++++++++
 profiles/audio/transport.h |  1 +
 src/shared/bap.c           |  9 +++-
 6 files changed, 163 insertions(+), 4 deletions(-)


base-commit: 19f8fcdc2084048bebe5bd9ea4fb97f7ece16df0
-- 
2.39.2

