Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E52F5E22C
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288949; cv=fail; b=FpT2uExPMAO5yjnGk4RvjK7ZBTSq5AeadSKeqT8Hl0l7eaRg/TE2b9hNJMNvGkSq0XD/lWT/fFFX8D+uj+YO1Bg7KTMaJGVjPoJ5k+GvZvTe4mnKgVi25n9q0DqSFdZkCe5R92Zii9isPRjltxltCC29LQ1cVoqQ+kbyntQvtDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288949; c=relaxed/simple;
	bh=4JhdlFLf+3iAzh2TYXXe23k36c3Xz+nAoCYvn7kT31Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dxjRL+pTZvlEzO6Vs68aKgzZDNqS791HTcRKIaXWq8z5cGurNYsC1B6TmRLGVTbmKpRtNAVXmEOIPn79TjGXwRl6PS8F6IAI5dAAZ9b96zQWOUzK9VrpIoFbO5mIRqz1AEb2O+QfzpsXnXr9Xp2caP5PDBb224+0KCijrcbspPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fOm/AfCc; arc=fail smtp.client-ip=40.107.105.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fOm/AfCc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REaPLuYNtss3OUav+gaU1UCd7JC7MFw4AXgG1U88xfms8BcqB00lwDkqvK08bE3iRnvC4AWaHeJwG/HQRiNoSo7pFo6eBrqo3HOnK+x16Hep+Y0S/UNWrrSd4mWMsQ+xmg1P+/U0dANoetq2LTacYbBi1oo2QsrgycN6e3db1oTFqxHgR8ct4ZSsk0fJT1x2CR2duBOUdNzhm/eTJWQKfIDI6mBf7lRQ5r9S6n/a+0V8RcdcmmkVvpp2Yh8eMYPGfrhe5rLcJV1UjqxtXfTN3uWujXsVB4Egpw7CXCEUKAS9Xkkh7qatpE+hWAZ6IX85wEZiqFub7mU4aea77spWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaCfbVBS3OjhFF1QWFJ2IYD9ZrMKbaYtkMOz2ENsn0g=;
 b=Wd1c8TWqH0IITiiV32GS2lcIaL3uPD1ObPQWRE8O/KF7c4q474e57cM391xBsGCui8FvO+11XpXHWnzSgayh+qPOQIDpYgVzJ4q32nRAnKujVIO/ixn4qtPwwwtAfj5nT+saQRnKj1c2XdEV6rGSIhW3fzfnwPR+nDJVVT94SiQyY/Pemu3HBmrOK21IYwcpmd13u6VLvVVXHrb2aIDtzI43GVWMr53qvYPx97yIqSCcThcWa8pgmdHP3Ao8kwuebZDkOev+rz0kfM40m8a11PUG4Pf8WPnPjHT6OoCMJA7TbvwtFN+70s7f1HLMMPkssGRpBbCtT9o5o1+wGUWitw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaCfbVBS3OjhFF1QWFJ2IYD9ZrMKbaYtkMOz2ENsn0g=;
 b=fOm/AfCc0jSoWLDMwh3tF9G0yHvC+V5davSrCnjuCiQSCE7woDYdS2luarufJiqnkz3gHub2KGGa0lt5xxjnm45S73zIj7PZjjQue3gBvrn3M48x/y7PNuZzvTePhaP3N9Hc0GtiGZXVmH2AHmh6s4JIHx0O1wUdX7ZZBmC/ddw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB10947.eurprd04.prod.outlook.com (2603:10a6:150:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 10:55:44 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 10:55:44 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/3] test-bap: Keep streams queue in test_data
Date: Tue, 21 May 2024 13:55:13 +0300
Message-Id: <20240521105515.103972-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240521105515.103972-1-iulia.tanasescu@nxp.com>
References: <20240521105515.103972-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::33) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB10947:EE_
X-MS-Office365-Filtering-Correlation-Id: b9263eb4-19df-495b-701d-08dc7984902e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HvFASmhiB1yQu73niQclfFy+FA/QLR2lLHMrPRiqUwtyugv2ScBeRpGWd9jz?=
 =?us-ascii?Q?FbKHRo5OdMuAkVnb5KrJuk0wJEtXrJ169mymfeUh83LqYXi96L7nkoGVRWnG?=
 =?us-ascii?Q?bTrs8ONH7ZLm+P/hhO+W7O4wJEUIBGjcRr6v0pW2lKTP+Kxqbf02bCyZUwlU?=
 =?us-ascii?Q?q0rXPgzuXmgGUfs6V+EvDG6RheDt55hOIXVkMBAYV40eYavJrz/ZCuM1sa2h?=
 =?us-ascii?Q?9+SSRXYXqsyz/uqToorXjp7kG0JSE0NOhh9BD1Dzvshm55njs73hdMCsutgH?=
 =?us-ascii?Q?peughFokrs0pS1Qkto/lmI/Stoj665VI7MCwk2mC4/eAER+O+TmlvauL3PSP?=
 =?us-ascii?Q?8SavyaBladecL4QJ7dQWfMDpTkB9SYH/TgzC261jZchl2rIQXCZuhM2SDHuM?=
 =?us-ascii?Q?vXgImls+ToM8Np/Luxt2JfDjGrnyai91RNOoSIlt8qaDZZGExq01KUj4hpbK?=
 =?us-ascii?Q?bhoRf4wirwBNiMbrGx5VfNIFWZam4Ekn++NW8oL1Wb0VSvjAJ0G8727zYjlq?=
 =?us-ascii?Q?64yjI3OCVAMjvAmNSXGNoskwjKx4t91otF5/x05TlQe6dtAfBu2hLtcN1VeV?=
 =?us-ascii?Q?teaoJcGgKpaPHFuSX1XreiZFM4wrgM/aRl3tuxJRcqUVwmTOQJhNppvZzWzJ?=
 =?us-ascii?Q?ITU/Yt262UZEmycgDguI06IukVULTdxIEPAuvs4Ns2I02v2mE28MnOHRQRmR?=
 =?us-ascii?Q?drz2my7Z4A7cILgIO/z1CQiBkLJI/7IFAXnFGI0BntARUMKDU+sydFI2Z4T6?=
 =?us-ascii?Q?BQMglh3XfpddooqeaQE0arr7/0HIZs2WvyqwgWIUW5ttNxQYCnPFeMaD+FJt?=
 =?us-ascii?Q?cPgAgWYDNEf1Or0RfYctL2slbAlC1tGzjq8FZ0KvOvxFaJU7vTer62GNnlYe?=
 =?us-ascii?Q?1gvP6KR6tbDUg4hlZ6fCeXFIl9LWvRLdyCGgi/SqcDBPXigqZaqLPQPdSZrE?=
 =?us-ascii?Q?4ey+jUH3tfSUCZ68w/1qmqlUJd58VPHq3sjtGz5t9YMEUhyVKN2vkwEn7YBW?=
 =?us-ascii?Q?0tOhbANtXo7JB+X6XJQMjUTNnGfwogm0YNIrH3+EdPVZLJ4p0VNOQ4wEHnfb?=
 =?us-ascii?Q?8Rz4LICxpNKM2rHHGriPSPv1QvHfR23bBSRjoh7Zq+mJht/1XPuQCbq1DjWD?=
 =?us-ascii?Q?SUz28tbMHlVnpcRPNz2N9w1zSVuEe3aZ8x2VFsi3Cab1aDLloQL+5A/Ymtbb?=
 =?us-ascii?Q?0X2aCIyNIuCAHN3cUlpefyUpthbFXUt0G4nmQ6B4swR4EBZsc4QOQRWuuJUL?=
 =?us-ascii?Q?guzOBicrl/v1FkbGZKgyVhL2ToHQdYt4OUCDTxZhyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bh8aKqXszhvbTTsXY6GgTtMr7T0IzLn8xQ/UyRZ3DHrsyb/1Mp265ZuNm3/1?=
 =?us-ascii?Q?F5GZ2Whet2R/KjhDhVRocbhFXSq7SAKEvXXNOp9JDE2fk3F6HB6bXWUvMgJu?=
 =?us-ascii?Q?64id3Vf0R7YgKdlADx7gJF8QN2rLJfW5n/518NNM3rs0h7OVw8+xkUyLJyOY?=
 =?us-ascii?Q?OYXLNj8zAX23aRAdGh9vOCAD7yLDXLlO0tZhmgtbjYgFp+3QjYsysA61g5D7?=
 =?us-ascii?Q?5/VTS3fmo8IupzpjjK2xFXLDqH7p9DPFMd6YJsHjzSGw/WNMvXx28dQJX31Q?=
 =?us-ascii?Q?EwMYKQPxCk8nj8F4CeTYdw25SvCviuvE63UKW5EDEKZa1m/S2hMfzwyoS5cG?=
 =?us-ascii?Q?hd2riWBPuWZ1d2gvapuIxcBs5KXvFfgGVfuGJUY3qaLRCdPjbA1uBEv/XtcX?=
 =?us-ascii?Q?KLYWlhn0U0MlitnrR1YvkIlvmKZ2+fcH5BIsQy+NmDzpVCthjbCdbkoxLE+5?=
 =?us-ascii?Q?zz5rApR/tWqCUcMiu5BvcyBYIP8synvln0oy6QHtoj2fiJ/QRncoNK0Guy9n?=
 =?us-ascii?Q?CnhUBWmjzi3Nj3W5f4iy1IALixfjH1tyCFCg5G474mMF5IrGMTLFcA7y6W9G?=
 =?us-ascii?Q?qyOMr6k0078Hqzv4JLZ0cPYUrAdwBJ8w2/ZxOUPGwQMCdMitRgy0NmRZIj86?=
 =?us-ascii?Q?LvdsP83xOoX2jm90fFDgV5/EVhXmbSfqiMHqfvX3Bw+A/jR4w5mCv5AtfxuK?=
 =?us-ascii?Q?8CR1W9ch3cg6cGPKdQTb/BCAjHhY6bcb46jJptJWfuXrIbycPEp4WDqVCXtX?=
 =?us-ascii?Q?LjTpnsJVjOLD2T9n5ScUfGAj4if2L1R77C37lXo300K/atSEJJ7CYJ+P3fmC?=
 =?us-ascii?Q?xEUxjViBwSZDRgntcCwes7frVU/yVoMdKWx07oe2ZgLDc4ebngyXDGm8w6sO?=
 =?us-ascii?Q?VuIoUF39+vfNRqKyJj+Oa3HZ8Rlr+Z+BBRJ9DRI1zNt9QYcBJUANpN7lLFHz?=
 =?us-ascii?Q?eWGdWiyY1IHPg9nTozaKzg3YmIZZcEEgshQlLbFoynBSfRC3vUMNSZYN7acc?=
 =?us-ascii?Q?LaijlR9QyORMR3A6gU/PIXbV0kayz4r/BKyAuObm96+OLz/8sCenMdt39a/n?=
 =?us-ascii?Q?phVY/ahavUvqnCqXnjvj01PAjPJEyh+y4ZTY1PskyD62gQowtZwNcwdWVKVw?=
 =?us-ascii?Q?M7+katr5Rp9LzayqGjjjBOYg8lZ/xwKe0OJ42fF6o8KcjO4cST1i2APuZ5/0?=
 =?us-ascii?Q?3B9I+rU+aaJ6Z7uTd8/2kqTC+s3271uToUQYOHziv0qoNKopAQ4G2Sgkgd8C?=
 =?us-ascii?Q?AD5tT2h3om64Y/0oerEkj8t63QuOBlOKmifYTTWuzGTCwNZ1AxMOBPRD9ePy?=
 =?us-ascii?Q?+unSahGyaZq3XVTkyT1UgBacH1rEENcpoVBGS1c4DBgWrgN4kpvKBP1Hv+9T?=
 =?us-ascii?Q?6k+gRM57n2BrALrl3gdQsa75L0bfwjmugHqEziAr3IPyhjjTDiL7Ssmaw+o+?=
 =?us-ascii?Q?pzElaCB6nfD+VSqCQWxELKorLYaYEp1ebeJ6Az8rH8FVA0Kg+j4bPwci+Mtm?=
 =?us-ascii?Q?/ipSWaYVRB8nWXHw1O/JFx2CpI9kM13sEcfvBmDWqTbqBiISEUmX6h1go2i3?=
 =?us-ascii?Q?6AU4iYOaewGip4gsGzbtSCx4zsZIYNcUXb3zvSAsEw0H4HLpbAjAXov/gxs9?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9263eb4-19df-495b-701d-08dc7984902e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 10:55:44.2311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYkO+Pvi30mXPEp3TvODpzFbkQ7ZhhXJgIq9OBmCwblKgeOQflWqP5jGVK0StzsjwFlvWxUmRW5ToaSC7nkqzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10947

Some BAP test configurations require multiple streams to be created
(for example, 4.14.4 Broadcast Sink Receives Audio Data Over Multiple
BISes).

This replaces the stream pointer inside test_data with a queue of
streams, where each created stream is pushed.

Unicast callbacks where the created stream needs to be accessed
already pass the stream reference as parameter, so there is no need
to access it from test_data.
---
 unit/test-bap.c | 56 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 20609694e..061c7a119 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -56,7 +56,7 @@ struct test_data {
 	struct iovec *base;
 	struct iovec *caps;
 	struct test_config *cfg;
-	struct bt_bap_stream *stream;
+	struct queue *streams;
 	size_t iovcnt;
 	struct iovec *iov;
 };
@@ -80,6 +80,7 @@ static struct iovec lc3_caps = LC3_CAPABILITIES(LC3_FREQ_ANY, LC3_DURATION_ANY,
 		data.cfg = _cfg;				\
 		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
 		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
+		data.streams = queue_new(); \
 		tester_add(name, &data, setup, function,	\
 				test_teardown);			\
 	} while (0)
@@ -373,13 +374,13 @@ static void bap_enable(struct bt_bap_stream *stream,
 	case BT_BAP_STREAM_STATE_ENABLING:
 		return;
 	case BT_BAP_STREAM_STATE_DISABLING:
-		id = bt_bap_stream_disable(data->stream, true, bap_disable,
+		id = bt_bap_stream_disable(stream, true, bap_disable,
 						data);
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
 		if (data->cfg->snk)
 			return;
-		id = bt_bap_stream_start(data->stream, bap_start, data);
+		id = bt_bap_stream_start(stream, bap_start, data);
 		break;
 	}
 
@@ -400,7 +401,7 @@ static void bap_qos(struct bt_bap_stream *stream,
 	if (data->cfg->state > BT_BAP_STREAM_STATE_QOS) {
 		unsigned int qos_id;
 
-		qos_id = bt_bap_stream_enable(data->stream, true, NULL,
+		qos_id = bt_bap_stream_enable(stream, true, NULL,
 							bap_enable, data);
 		g_assert(qos_id);
 	}
@@ -420,7 +421,7 @@ static void bap_config(struct bt_bap_stream *stream,
 	if (data->cfg->state > BT_BAP_STREAM_STATE_CONFIG) {
 		unsigned int qos_id;
 
-		qos_id = bt_bap_stream_qos(data->stream, &data->cfg->qos,
+		qos_id = bt_bap_stream_qos(stream, &data->cfg->qos,
 					   bap_qos, data);
 		g_assert(qos_id);
 	}
@@ -431,13 +432,16 @@ static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 {
 	struct test_data *data = user_data;
 	unsigned int config_id;
+	struct bt_bap_stream *stream;
 
-	data->stream = bt_bap_stream_new(data->bap, lpac, rpac,
+	stream = bt_bap_stream_new(data->bap, lpac, rpac,
 						&data->cfg->qos,
 						&data->cfg->cc);
-	g_assert(data->stream);
+	g_assert(stream);
 
-	config_id = bt_bap_stream_config(data->stream, &data->cfg->qos,
+	queue_push_tail(data->streams, stream);
+
+	config_id = bt_bap_stream_config(stream, &data->cfg->qos,
 					&data->cfg->cc, bap_config, data);
 	g_assert(config_id);
 
@@ -529,15 +533,18 @@ static struct bt_bap_pac_ops bcast_pac_ops = {
 static void bsrc_pac_added(struct bt_bap_pac *pac, void *user_data)
 {
 	struct test_data *data = user_data;
+	struct bt_bap_stream *stream;
 
 	bt_bap_pac_set_ops(pac, &bcast_pac_ops, NULL);
 
-	data->stream = bt_bap_stream_new(data->bap, pac, NULL,
+	stream = bt_bap_stream_new(data->bap, pac, NULL,
 						&data->cfg->qos,
 						&data->cfg->cc);
-	g_assert(data->stream);
+	g_assert(stream);
 
-	bt_bap_stream_config(data->stream, &data->cfg->qos,
+	queue_push_tail(data->streams, stream);
+
+	bt_bap_stream_config(stream, &data->cfg->qos,
 					&data->cfg->cc, NULL, data);
 }
 
@@ -572,6 +579,7 @@ static void bsnk_pac_added(struct bt_bap_pac *pac, void *user_data)
 	struct bt_bap_pac *lpac;
 	struct iovec *cc;
 	struct bt_bap_codec codec = {0};
+	struct bt_bap_stream *stream;
 
 	if (data->cfg->vs)
 		codec.id = 0xff;
@@ -587,12 +595,14 @@ static void bsnk_pac_added(struct bt_bap_pac *pac, void *user_data)
 
 	bt_bap_pac_set_ops(pac, &bcast_pac_ops, NULL);
 
-	data->stream = bt_bap_stream_new(data->bap,
+	stream = bt_bap_stream_new(data->bap,
 		pac, NULL, &data->cfg->qos, cc);
 
-	g_assert(data->stream);
+	g_assert(stream);
 
-	bt_bap_stream_config(data->stream, &data->cfg->qos,
+	queue_push_tail(data->streams, stream);
+
+	bt_bap_stream_config(stream, &data->cfg->qos,
 			cc, NULL, NULL);
 
 	util_iov_free(cc, 1);
@@ -704,6 +714,8 @@ static void test_teardown(const void *user_data)
 	bt_bap_remove_pac(data->bsnk);
 	gatt_db_unref(data->db);
 
+	queue_destroy(data->streams, NULL);
+
 	tester_teardown_complete();
 }
 
@@ -2643,7 +2655,7 @@ static void state_start_disable(struct bt_bap_stream *stream,
 
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_STREAMING:
-		id = bt_bap_stream_disable(data->stream, true, bap_disable,
+		id = bt_bap_stream_disable(stream, true, bap_disable,
 						data);
 		g_assert(id);
 		break;
@@ -2719,7 +2731,7 @@ static void state_cc_release(struct bt_bap_stream *stream,
 
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_CONFIG:
-		id = bt_bap_stream_release(data->stream, bap_release, data);
+		id = bt_bap_stream_release(stream, bap_release, data);
 		g_assert(id);
 		break;
 	}
@@ -2788,7 +2800,7 @@ static void state_qos_release(struct bt_bap_stream *stream,
 
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_QOS:
-		id = bt_bap_stream_release(data->stream, bap_release, data);
+		id = bt_bap_stream_release(stream, bap_release, data);
 		g_assert(id);
 		break;
 	}
@@ -2827,7 +2839,7 @@ static void state_enable_release(struct bt_bap_stream *stream,
 
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_ENABLING:
-		id = bt_bap_stream_release(data->stream, bap_release, data);
+		id = bt_bap_stream_release(stream, bap_release, data);
 		g_assert(id);
 		break;
 	}
@@ -2866,7 +2878,7 @@ static void state_start_release(struct bt_bap_stream *stream,
 
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_STREAMING:
-		id = bt_bap_stream_release(data->stream, bap_release, data);
+		id = bt_bap_stream_release(stream, bap_release, data);
 		g_assert(id);
 		break;
 	}
@@ -2894,7 +2906,7 @@ static void state_disable_release(struct bt_bap_stream *stream,
 
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_DISABLING:
-		id = bt_bap_stream_release(data->stream, bap_release, data);
+		id = bt_bap_stream_release(stream, bap_release, data);
 		g_assert(id);
 		break;
 	}
@@ -2971,7 +2983,7 @@ static void state_enable_metadata(struct bt_bap_stream *stream,
 
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_ENABLING:
-		id = bt_bap_stream_metadata(data->stream, &iov, bap_metadata,
+		id = bt_bap_stream_metadata(stream, &iov, bap_metadata,
 						data);
 		g_assert(id);
 		break;
@@ -3047,7 +3059,7 @@ static void state_start_metadata(struct bt_bap_stream *stream,
 
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_STREAMING:
-		id = bt_bap_stream_metadata(data->stream, &iov, bap_metadata,
+		id = bt_bap_stream_metadata(stream, &iov, bap_metadata,
 						data);
 		g_assert(id);
 		break;
-- 
2.39.2

