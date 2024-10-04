Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2047.outbound.protection.outlook.com [40.107.104.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74C21D3571
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045343; cv=fail; b=MNZSnV7kL3eGmUzTpQF47gTYRofE9PMOFWYDFyvZmuBDXokYsDBqu14pvZ1Iqjwi8oAOYXELdzxfaUA3TW2uxxGHvFUc2JQ7JKqCaiUB1OMgXnttOwbTdz+KhL60vvJeG6PpwVoSGryeoCG9UGLrcyZYos3kC5Kn8usnu+iLbsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045343; c=relaxed/simple;
	bh=iCAtyWHW5KK2TOmQHHIzlHnmgL4bo6unsB2vKXkvIf0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=P4usgDz5mwVMtM8iBMrTe7d2srk5KxcOTGlpgTU6Qnl/zsAYpZtdzpC6tfShYlbyXD5IOr5CS3IGImfiMrOEIh3+8Q1zjJhHDbutYHCcDfLjTJXOXyX3jvQ41fFWDpZafIA1qpE77sLLKO/JZI6LxWUyGoi4QHlfROAL7M0ar8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k2i0YDsO; arc=fail smtp.client-ip=40.107.104.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k2i0YDsO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RShQjvQjeGgaORnI1V6kkI1Oq9t9QDdPdjTDEp5bd3prk8KYWWeRIEdeUvAQoBXU213QQnsbLeaRx7dlrJhTo4jxFpZ+GGUPP80/x0nGFjn2MqIFEbkTAslKEFvI2G9JvkObS8LvxZR21fduVTEsam1QsMfWJl/uiSpl8SPz52gzkGrOcQ9jVL7WWuJWo/OwK2ZBfYim3OmuavJPYjgF+BqN9wEUmGDe7if1WMGhcB5j7znE1FHBfyT3A+FPot0LWCuXRv4fZL12+Q95hyD1/afmeJBm4TsA/ap/kpyDdEwgnoVvf5DGPcmXoLUXtLTJY+bebkY/3T9sO2ORzA/BdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ul2ryNpenXQ9jyUs+9m0z+Q+LP87qBdfj+yEoGtimng=;
 b=gb2ig7CTmyKDWBIrycg1jDMIqrAM8lzmLIRsp/HuWI6xKvQVGBTBLDO9LO0+iRCOzEe4sAGGDfCkKfLJ9CogrMnVxxjY6eOkpXGa8q5NgPSVTD0JJvEV94GwRTepOLT6WHq8SE93UuloC7chM6xbt62RWhZuW0e3sQI6ebkVgcOSHF1gWCqt5yqQ/K8yDr1plzZ8aU0k9V0kbqoijLuHxNkQRnCiE5yASKdrEHHdiHJUIavv4+3SwTEOCa10VEOoN9GplZBXZm9XyM3CuaSsIbbjkBgJo7enJEiA/sRbKtOrPxjFEOVbbLlLxOZsBjgbbKOD5WbAeENYvVw+75cqfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ul2ryNpenXQ9jyUs+9m0z+Q+LP87qBdfj+yEoGtimng=;
 b=k2i0YDsOqH3qmCYGXXOgZXEnPyVE28vf5mfklA0Rv/+4ifZwcRP4XaOyNGDeOIV7ywAptY7Q06qxShEyCYowmRIFr/LGQY2lmWkg0OxWYaWzhXqjF+7dhydHwHnDuRjGvMjSky+iaFKK0vHocD3MqANa0IaeHlntlckOHX45tb7DgjhXoxng4bdZvV8dlQbav7rpiiIZW0oL6af+/rvBwyxKS+CPwaW+g4NpvnJldMYRXPSEu8nD9WuVDvr0XSPdLun3xAIvMG4tCXXR5Hr1AFfVfmqtVp1O7dXYDLA+bizrHlimG+dIWItBEwcGtna7o7HY8QgT4W1wNMV4dWL8FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by VI2PR04MB11075.eurprd04.prod.outlook.com (2603:10a6:800:27a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 12:35:38 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:35:38 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/9] Allow syncing to multiple BISes from the same BIG
Date: Fri,  4 Oct 2024 15:35:14 +0300
Message-Id: <20241004123523.1012743-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0056.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::7) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|VI2PR04MB11075:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb3740e-7197-4b55-d4aa-08dce4710d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lI6E9GNtBBKGRp4AzozsmVFh0f8O4SdmFY62o4hPFROg7xxqcBfIiy2TXtCA?=
 =?us-ascii?Q?2AhYhXGp+nnaldGOYtuW4BxGyIhMBMFGoB2QZ8mM7TYWAYSwxW+iIxO9pW8I?=
 =?us-ascii?Q?i/EC+cEVlfmZvoyJFtFIyflyYpZ6we2pxTbAfKfe2KMExXAJiSATHjbyY9nU?=
 =?us-ascii?Q?09FyW7RDfmJna2Wm4xunydh8q/ePNQwniUKm/FrK3oq/uP24Jo5ofc9H1Sse?=
 =?us-ascii?Q?XJ2arLPFeUu1eUV2F1dz0ZNrcMsxdM96+rNtkjz+OSm1zkD/ymP2hniqlt77?=
 =?us-ascii?Q?DgFjG/WztrGKW5Mf4OLvhHoOmTWDb/ulHeGzkoyxOtG47zUFIylrgt2ZymdT?=
 =?us-ascii?Q?ch6d6WhHPYGnRpLHaRTLS9QhH+tFdGrrF1pGB7rnJl48goeZzXdLwpjlYx1f?=
 =?us-ascii?Q?V6Nb7ROo+Y4nFlrDgG33njdxXMLOAa/7x5nW6knJF5jTjmCc7ACKgECF11cO?=
 =?us-ascii?Q?zKtio6S5SuuCmkqiI64e3d9g5v6BvnE3LxB6MlbHeSAVn4V5aO0FD4mOpiYj?=
 =?us-ascii?Q?4ApzLYaKkV2RuXSgcONPXjooH6Fmt5QPbpPZenghiw4/nMD3j856HuX/CLqt?=
 =?us-ascii?Q?JqmuPMhi60SjJpZKOXjC8nk7bvhOHzpyCNEcK29nkg+CWEqRYbDNP4mF8bEf?=
 =?us-ascii?Q?lXQrnYPrMfN7ZDbnrjMaMHUTgF5ej8VtWUgHePoidMl9I4OD+3wRkhXA1PTt?=
 =?us-ascii?Q?lzyhF3jcwMqNQJfUCjYPFtHyN5DbvhdOvxyXd50Tcz00Gyl6ZkcqdirH5D0j?=
 =?us-ascii?Q?O8c2xO1HLN3+uh0WG2pYPqSyTabENZhV+Z+ldalFV0ECGEjiCyS/ybKX4aMI?=
 =?us-ascii?Q?21GPfDRf6Ui5tfoBWbBPSHvMLvZnrRHECW1r7yTvYEPuUlSaQMbvN9+9W67H?=
 =?us-ascii?Q?L1y3D37d3p5dgRy9a/LYz5vNbpShnRCxof1N4dMliZHU3YpH+SsQ12oHCwGO?=
 =?us-ascii?Q?EaX5eKCVFcjFUfLAyE9AL78P9E4wn1JMAp+IbzBOlaHqPQPl3XudjPfhFvdM?=
 =?us-ascii?Q?upXIkNMCjz+ZND8ECk7Tcpky5PtNVDhlGSIHVS+nJN8s0HRzjc+J/l524+97?=
 =?us-ascii?Q?9ihorWGuZeU2Xzn4h0MWk5JYomJ+mzHfvp5Vb7f5Fpxxj5LsaOpNwwOre9t2?=
 =?us-ascii?Q?Pevkcb6lnlyq7ofFsU5BZ4xIHQUBIhvkxxXzf1VEOoVNol5jJgJIBTkuLOqC?=
 =?us-ascii?Q?z9DDdRX/NaEJtChUOG7jRgQt7yWTRyIOieB0HXCncJn2JpV9uCf9/FfXQwKa?=
 =?us-ascii?Q?f9kX05MS79WQBhXd8+jf0NjGna4JVClwqBjhQ9nIV6X+BuhohwxMYF9SlRUt?=
 =?us-ascii?Q?xT/ZkexFK4h+RHiJdal7CpWVlheoLCBGn/o4lRxadfoSuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qGacX5xSwvNRz9I6zcg21Gp/PFZqtGTgUHbehvBoc0ZtNdyc/ahap8BZkRuE?=
 =?us-ascii?Q?ImlsW1tF36qU9mSecV6sFSkYgYqrQCdbnu6PIwzYAa/Wc+ItEAeXBCgWjWko?=
 =?us-ascii?Q?ZuyIAX4GfqdsX48j8fBiRGqZ6sBAu4utFkziSfOG9TDEY4bJpHR9+QMDuU2W?=
 =?us-ascii?Q?zKbm23D05RU/2ugcgfLD9cAAUS/piczWIFZB+plo2FWOzmmPC1i9IhADaRu1?=
 =?us-ascii?Q?pgbEYdQcAOzLQdTJIg1ucd8ltCf0dz3uyfCuq1ta+WRPw6KtdOpnFXfapqCV?=
 =?us-ascii?Q?Yg8zG5+Ngfv1h2mBqqoXOfu0HG0//lRDIdIaixJMEnpTNrm83szWY1ZTpLLW?=
 =?us-ascii?Q?GZ2Hcy2Z3dxQFtrWKmlLjb6FgR+w+MoIHREoQ8uFg1eKxUqvvbShmNzb/++U?=
 =?us-ascii?Q?E3pdDpLQ49hnpTEo6RP0MiBVDBTvjrC4lfpIwKBd38LQ3WUqm4nGRzm1K1pV?=
 =?us-ascii?Q?jSKq6MWhqjDnWMz56zEkSCTQOduOF9n/cYMKjp6ZsOkf9+VfJ1jTNpSDKYEc?=
 =?us-ascii?Q?aL+c9ymemjElgv2Nx4TKGprytDXnyo4NrVofaY+1jJFWDD76A7BVPDNZNogI?=
 =?us-ascii?Q?sxBpSNBc2Jf5tcsXNUrUxsytp/z45BTMXt3J7yVWeNJKqtHHESLxDTuejXX1?=
 =?us-ascii?Q?zflZ0h4izE+emMQNhrzu3mHDQUVmDYfhQNgIwW9h0pjv2REtd2oRkJTSdO2b?=
 =?us-ascii?Q?KAm+7qCE+y7h/j8O0GHJPSbRUeDl/jTioRBoJDXttvSQFQNRsQDEru24xRyV?=
 =?us-ascii?Q?YynYTP0dRaFXhm7ysNCa8weqH0Euxdig7StUfbUn8e+eKWDqaBNtkfmmOVcO?=
 =?us-ascii?Q?ZjiyuXq2iU/flkMZuhng5Ii1o5hgCB326tLHxa1pRY91eTr9PSItIiAN8OAd?=
 =?us-ascii?Q?VoyTTvfSpAUt2xms81Xq25WRJacVoeDo1zwpW7AmbLnJpPjdj8djRNAGtehs?=
 =?us-ascii?Q?H3x3YfODuZsb1RO/Htj7l/WJbPn3hYlqjCvQtD2fF3Tj4UH/qXhv0DcOsWdV?=
 =?us-ascii?Q?VxhXh3jki4zVArHADfVak1/gOmXeuTkZxJv9ie4Wy3VfMZrySfejX0Wh992C?=
 =?us-ascii?Q?AzHleGrLoLOcXxBJTVTIUcyn8yVp510y7+A959X7i/nOJwdXVLThgn0plrXT?=
 =?us-ascii?Q?gGLC21KbhrQabaKZJYiDX70kDsotIwqt00gvdlH3b4zjkdKi1rKP6p95IvXg?=
 =?us-ascii?Q?7NihEhjYlxwdslIy8dEb8cRWCXIcHVvAzOUPJtPXcfMGzB4icgkJHXmsRkLP?=
 =?us-ascii?Q?Luuq7wZQEnLSLQrNZNzeMMzlppUyzEmFzFapRbUoK10rum3WzhQEHfKDxxKH?=
 =?us-ascii?Q?BmzCOc6hCWJJAZXlrCpoQnpGk7JuobNSHcmTlaPNQAlQwp/v86fTsMdonILg?=
 =?us-ascii?Q?hdU3E/ebyQlVcEjUMY0wmGl5RMCsu/+cG+SX6QzhYr0hIwt/4I3VVjXZAk2F?=
 =?us-ascii?Q?fbyuIt1UhZrR19Crhp4aH+XcjjHK10dM/G11g7Hnn0RvQpkiTBYK1C0hak1Y?=
 =?us-ascii?Q?rISyyLPXjC9h9VxPNuwRcGWpvx0qri6L5PmYmBawdB05IGlHM2AIEul5glNo?=
 =?us-ascii?Q?VI/GhjzeDhmyRkkiJu5l7DusR0LE23J4IJYkIZ4r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb3740e-7197-4b55-d4aa-08dce4710d20
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:35:38.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdxwNpWQY5EaDqCxdzjo4wBIkcJY5kyZfOqWs8kw02vTG1oIsUT95wicizasoLNNrwlRrBo073TFLaqa8v8arQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11075

This implementation is a result of the following limitation: a BIS can't be 
added to an already established sync. To achieve this the old sync must be
removed and a new one, with the new BIS included must be issued. To better
explain the this implementation, I'll consider an example where the user wants
to sync to BIS1 and BIS2 of the same BIG.


First, he will run transport.select on transport_bis1. After the sync to this
BIS is done, he will run transport.select on transport_bis2. As mentioned above,
the old sync must be discarded and a new one issued. Thus, new sockets will be
created for each BIS. The audio server must be made aware of these changes. So,
on the receival of the second transport.select, BlueZ detects the ACTIVE
transport_bis1, and calls bt_bap_stream_release on it's stream, which will call
bap_bcast_release, thus setting the stream's state to RELEASING. This is
detected by bap_state_changed, which calls
transport_update_playing(transport_bis1, FALSE), prompting the audio server to
release it. The release will trigger the stream's state to be changed to
PENDING. It will also trigger the call of bap_stop_complete. Here, since the
transport is PENDING, transport_update_playing(transport_bis1, TRUE) will be
called, which will prompt the audio server to reacquire transport_bis1.


Acquire calls result in a call to setup_accept_io_broadcast. Here, if no streams
are in the RELEASING or PENDING state (meaning that they are waiting an
acquire), the PA req is allocated. It's num_bis and bc_bis are set, are filled,
based on streams in ENABLING state. From here, the sync request, with all the
desired BISes will be sent to the kernel and then to the controller.

Vlad Pruteanu (9):
  bap: Add helper function get_bis_from_stream
  bap: Drop union from bap_bcast_pa_req and add setups queue
  bap: Store sockaddr_iso_bc in bap_bcast_pa_req
  transport: Trigger transport release when syncing to multiple BISes
  shared/bap: Add guard for broadcast sink
  shared/bap: Add PENDING state for streams
  bap: Handle req to sync to multiple BISes
  bap: Update broadcast sink state machine
  transport: Trigger transport reacquire for multiple BISes sync

 profiles/audio/bap.c       | 213 +++++++++++++++++++++++--------------
 profiles/audio/transport.c |  56 +++++++++-
 src/shared/bap-defs.h      |   1 +
 src/shared/bap.c           |  18 +++-
 4 files changed, 203 insertions(+), 85 deletions(-)

-- 
2.40.1

