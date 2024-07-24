Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AADB158871
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831728; cv=fail; b=ayAHSaCslJvMARufK8nKOeaIcBzJMMUddxa+x/RtFzc3l+lv67iftt1V2K6FR+ohwx0WeNWBDbSrX2+gS41b4vISXZivz09Qo5KvNdFO6ggly0cdXMJ/T28+gJHiBlkpooUwR/NjoMHoZxTD0pagVtmvjMtG4L0DLJIN37bpDCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831728; c=relaxed/simple;
	bh=ou4SbUO7uilT77h4/IoXh+cpb6rbJKfId4Jtc3XM8GE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iVpIwXm/9Yxsiv4CD6AY+byqIvYitY6ZYSkclrge/YWmtdEW2Av4RBrLrety55WsAUrtcsokZFg1BDkAle3AMOnbSuqyqwQnJy+WLn8vSi3iACiFTE/09bYHek1EAmNirqyPz6dQV1ik3hRQFI9sv3T4QQ6airY6PObtiktgnMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cAV/MRNz; arc=fail smtp.client-ip=52.101.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cAV/MRNz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WafRvpA4oCQE8TlvmGXdaa1iz3HTv02j98XV19DfLEzFbKOlNmJwTD7oEoGmb9fK2baiVJTZlo/+p4LZyve2CPshj5dmaa+hwt72P7B2FRa8tjV1ZixPzyRqtnFWI2lB1aZK2JEUKv//a9kkM/15TF7HUUw6KgskdcGGldjoceTPx8foSt+UpY3qTDQQzVTW0+FTCd5ThxFsOp+NkRQY5F72aPL4shUaHn0Pa+VDmGCx4VpsFHelBBuG7FTJagVN/5Z9RRShrRj8pZnrskT7MQRsHHGuTP9zwA2O5ksmlmxVz/EPBEH1aWbTMMeaNM06IEUWc/GyQF2iZlgl3fRO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlJ0q9PzlOav6z8uhds3C5JZ7xWggjdHo3Dh0S9swtw=;
 b=YJDLD/ruS/M2qNtlugGcgkXr1v3m4oO68hCR0raOIJsFgmoeQ+hSxSaNrn07RSCcth+UfEYaV9QU/JcHCwLwBvA6pTR+Yw7p18dNNixy26CaO369iR/qszeI6HOZYSx0CH96Bm1PCyxtj9/M5ulP54pYnTVrGC6+KJ6zLSPXcfkr3mkAVrNrpHj34SPA4OT6BP1GyM8/zVK0tvEDWYGceZEdCWxHPwRsUdtv7532v1f/204JOem2sGrhBFRs4AvXWXS4UIXUBymp2IydoVLk+D/S71YRvNxnFFdDycocZdzFyNzy9YuxdrC9fXCVcLLD0zjuxOP8y7RKnmi0YBxE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlJ0q9PzlOav6z8uhds3C5JZ7xWggjdHo3Dh0S9swtw=;
 b=cAV/MRNz6pS0X7anhQys0ICYNGkqVzpQ5Q+X0WbiwiWn9b8HEzXLg5wnO1lQtotlXvcbmYjfVexBRrX47ieA66XibBccvB/0cpHj9FY4zU84ie48eQHQb0nKeScjuCoADNisoEgPemCoKYQeuKdzSaxC+JxA/n4pprFDKOiaF8CfqI2Mif42nAvDUbIMyrbEChe9SVjZxGZuTCrLnRbdDJ+YjxK/ICHFRR1QyidJOSlkJR+7d3jbK/EoQIm8PrtCvx78qcQr7+eCCRV4HfDnxlgvOBJMuxczubplF0m4ZdxzRJ49rDjimo+PbZ3JLL8/pPQ1PKlktfaJK1cR3z59mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by GVXPR04MB9994.eurprd04.prod.outlook.com (2603:10a6:150:11a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 14:35:23 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%2]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 14:35:23 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 4/4] transport: Broadcast sink: wait for user to select transport
Date: Wed, 24 Jul 2024 17:34:25 +0300
Message-Id: <20240724143425.165959-5-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240724143425.165959-1-vlad.pruteanu@nxp.com>
References: <20240724143425.165959-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::20) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|GVXPR04MB9994:EE_
X-MS-Office365-Filtering-Correlation-Id: 63bd304e-7fdb-4c62-71ca-08dcabedd9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pgin73Ht8+QK5iEtWV6CMym96tPtV6ankmWhFtdf3Sc5lfffP3wOfLXPmTgW?=
 =?us-ascii?Q?6ifOkscxqVGJAaLDeHnzVDh9SuOOjpi91s7fnYjhDmVxl6fdjnk3yEy4sBI2?=
 =?us-ascii?Q?NS7e2Cm/SIDiw8YMgYKnClX+aK2kUsPkA/FgozrRzhyr3US/IS9jTh1OLyfV?=
 =?us-ascii?Q?IXDEb1ow+uZ1IOY0V8g+PffRTfmraobYPga+v9t2tcQcSWC4Sb9EaHc7+GXX?=
 =?us-ascii?Q?OHAnUDftJs3M2iLeLayOfP9sN87hduYkk8HeuWv6Tca5p5xK/FOdF7fBz5xt?=
 =?us-ascii?Q?gvMAXp7oo4UWYpTCW/NnRrqN129HglDvtFxqQuEDDubtZFx9mJLs5XltcF5d?=
 =?us-ascii?Q?Lw9yiT2s0klvo9ep6Swtj5mhOmvVljttZXqSRcjjFbNTIFmrMwLMNz8ulkEY?=
 =?us-ascii?Q?Iir9i2t9DnsrFSCbp77Rh+6qbq4C7Tk7gtI6jUCOZ9RODI4RybGIKy1NQu1/?=
 =?us-ascii?Q?SbwouaAlONvOMFAONm1FZa6XCXHpfcmpi4t4U546tkJiSJ16t4r9KaKC0Btv?=
 =?us-ascii?Q?LnligYxKdXu5GKqSdbVqws6giIzr9WC3nbzrS1m+P5IMFBRBqkTx7hkNi4AU?=
 =?us-ascii?Q?x6Gkxto2bAUbtqT/Oa9H2MXJ9CAbXRWNJxgHj0tq73thWjTLw/MMUaHeJFzl?=
 =?us-ascii?Q?cdgtbFFVfuqUbtrnhCnVZU6rxLfpwFvW6VEGD4JtVV23HmLGOdpq+3Ya5zJI?=
 =?us-ascii?Q?Vcq/PZ/iQs7N8BwvkD3U+7XUzGMqmq306sbylfeK0yyqg0qROhoEBsISv0Ci?=
 =?us-ascii?Q?xuShC9Tq8qdBsqaE/WOPtOQQE39t1+wQX/+osd0XURxFu1d/A9bvd8BFgKdQ?=
 =?us-ascii?Q?6BteFDTjdHs/W64ra4a4KXqzWpIhBnYzd/yHoFeiCgqZnthtGdXdhUDrjlCW?=
 =?us-ascii?Q?m5Cj+NRc8yy3N10GphdbCLay/ZMZs/SWns/5gt2/SwqkWXvlkrOlEMIj4stt?=
 =?us-ascii?Q?JBcGjYiOHyvyA8zErA4rwhmMbHVNiLHv0bi92LYtfg4Ex/kk9MR8SRIAMUlP?=
 =?us-ascii?Q?yrbdsdaCoMmRx/SkvEgp/GbMemLTTTD0D/DqihUus6MG+gYqtgxadqNGTP9l?=
 =?us-ascii?Q?ut2EM/f188WRXj7A9v7RVv8YfvKMZufZ6GYbaca0Bl8D33PTaVIkQSnx049v?=
 =?us-ascii?Q?RQ70MgDXb1/bz7KOozIVC1e98bTfbcqnaZ09+0dOhPWpcn9q0STEXuMPrzjw?=
 =?us-ascii?Q?9H/sDGBxFO5nJ7dgUqYfzge87xblMbs8MSoiFXjIjlVdbzxc721fOCd+XCLy?=
 =?us-ascii?Q?YQ7w5b+ZFmm942aqP5ep0nJCGWVCkqHW6jcveG83SJu4iEdSItmCjn+Qq4uy?=
 =?us-ascii?Q?KgvLGS6uEjMTSJU2agzecOS1WI54aZAigvXg0N+eZ6plQsMssG1sGRwphynR?=
 =?us-ascii?Q?4wp67esZt9DB2veo42xnWExXFWnS53L0prkCGgMcQzORSGlE4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r/zJmJMj6g18k9QZihSl/a4SRD5fSr5XVI/tBcwZOLDUTmMZzxYiwi0G8w/V?=
 =?us-ascii?Q?ttvy8RH8V7lzAA8Mn3GCv43e6ZwStkVUcVhsTv5zsN2wI3fsh/v+GXAzycqL?=
 =?us-ascii?Q?xdC3en8Y6Nc41Ur3gSJ8UVirKam+63jgt3OBRraP6YpMb8TF5uJxMfWdWU/l?=
 =?us-ascii?Q?elCwisyvNPpCrAYWVs7iOP0cMN1MHFu2tgEmtGO3wxWfDGiDdNq97UhY5VaH?=
 =?us-ascii?Q?VjexWQKLrFt3ZRrjRTUMzPBf17UkcB7UJvFpWQJ+9VBSXvmdZUjdhkqV8KYn?=
 =?us-ascii?Q?UuIAylvUHfv1LdMG30RvhpC7MXFfSdhj8hSZuITqc8QsChS7Eo4fFHtunFJW?=
 =?us-ascii?Q?X+Bzf2IZBYvCQkcEls6BC3eYK+/9oWwmBfzZWO2WJhbLePFwqAOjLHc+9nRA?=
 =?us-ascii?Q?M0kRDOgHm4MAt0nyP3KYsxOC/y6aB8rLqVWBYedNhUBW0p51dql7PnPmgErc?=
 =?us-ascii?Q?GNELyWMzMd/ua+mm1MbJXZxeK/LJhFRJoBhnMlex1pTV2Skg56B3m99S7RXk?=
 =?us-ascii?Q?gtj2A1s0+X++W81/brAusENBU+v7HRTtxWhY0U1wqITuYCYlKCO1NYj30gza?=
 =?us-ascii?Q?AdIjjZ8BEdwNqaVPbcrJFLLk6QGYUQVpmHDAEl7JjKnAMcy/aQVJVFIUB0Q0?=
 =?us-ascii?Q?j/t/L+YIt8XHxlk6q6qg99vO3NBy8yYWOlwIHBYG4JXFTVsxc8AhrjbAEIU0?=
 =?us-ascii?Q?ZGUXNJ9VQyOFTLnum3hbvm8SfDKjoe3tIgxqjjeGZk/ThlgkwnCc90ysXSDc?=
 =?us-ascii?Q?EVSMXtstFD3FQ8zRaD/PTf/5bOzDCJCnef90PlhqqKm5hHXQ9FflLY+sKc0B?=
 =?us-ascii?Q?+1Ed318OgzpmNNulDAreNrjJ5owv8D+oOCxtANtA5M9X4u9ifWDJil7KXLit?=
 =?us-ascii?Q?FCCIvpYWGNqAgorzw3ryqOxxml1SQDK89i75y1mW5WGDXBUejY4/qf2nIvlm?=
 =?us-ascii?Q?FO2E3PsSrOFQCeeVrY0HY2SY9rfMiyt1ASdDrnlPJhchu3nujxMI6fdDumcN?=
 =?us-ascii?Q?6Qq1KM39jWIHgqpiORQkxSeG/vEE77yXOVxAFK3awhmjbf4Gv6j7wDd2N8gO?=
 =?us-ascii?Q?s9ThmvXlKS/4JTyy+8JutxWMLO3yy4F68IY9TiIUUgMQYba2kcMMYh/WgeIB?=
 =?us-ascii?Q?r/ebDVqE7XKXzXGtvILw6oF7uFx4zyByLEk9mH39JLkI6QhCqIEDaZaMd7xl?=
 =?us-ascii?Q?qpDo47HKSg2OL5S3zDxTg4R5Sc4HRVrMyvLMOJODZZsOW3LMrj8Fp4TTS7DZ?=
 =?us-ascii?Q?GocnDi8B7jFwTvOCEzEhMckjjFW5C2Vfl+DCZLAd3tQTyKZvsqxZKZbmSrv2?=
 =?us-ascii?Q?DhIUSuoTLJDUdAc7ZFjDJSXFHnxhuZcUbFOS1++szyOSmQ/SE6ySt40orasW?=
 =?us-ascii?Q?sMb+rnqt/ePRrhFvSrBT562//8v07c+j9WR7xIGEkp/NXj0Ag2CWay1SUVoi?=
 =?us-ascii?Q?PRL1DtIqBcORZ+7FA66NaGB/7ktIeRXDJqYIPNSV8hv9HVyyBqo3rHkkP9qY?=
 =?us-ascii?Q?EEbAl6ey44eMtRuHmgjoELL2cffKwK47e8CpJB8jqJL5E+2P/downbEiA7qi?=
 =?us-ascii?Q?Hf/qPyEZICVqsilFrizd4KGbsq6PYgkZC+JcMl/E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bd304e-7fdb-4c62-71ca-08dcabedd9aa
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 14:35:22.9277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwtHxAXxHip4D2al8KYJg0PeODJwdjyeDxP3W8iNluvWb1RIbqc7D1cNT1LWvAg2TUf0rR+ZpCWm0Q8UVZ9tEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9994

This changes the flow for transports created on broadcast sink side.
Transports are not automatically changed to pending anymore, instead
the user must first run transport.select on them which updates the
state to 'broadcasting'. This allows for the selection of the desired
stream when running the setup with PipeWire, which acquires any transport
that is broadcasting.
---
 profiles/audio/transport.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index ce1edbf46..44e82da38 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -156,6 +156,7 @@ static gboolean state_in_use(transport_state_t state)
 	switch (state) {
 	case TRANSPORT_STATE_IDLE:
 	case TRANSPORT_STATE_PENDING:
+	case TRANSPORT_STATE_BROADCASTING:
 		return FALSE;
 	case TRANSPORT_STATE_REQUESTING:
 	case TRANSPORT_STATE_ACTIVE:
@@ -1299,8 +1300,14 @@ static void transport_update_playing(struct media_transport *transport,
 			if (transport->owner != NULL)
 				media_transport_remove_owner(transport);
 		}
-	} else if (transport->state == TRANSPORT_STATE_IDLE)
-		transport_set_state(transport, TRANSPORT_STATE_PENDING);
+	} else if (transport->state == TRANSPORT_STATE_IDLE) {
+		if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BCAA_SERVICE_UUID))
+			transport_set_state(transport,
+						TRANSPORT_STATE_BROADCASTING);
+		else
+			transport_set_state(transport, TRANSPORT_STATE_PENDING);
+	}
 }
 
 static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
@@ -1682,10 +1689,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			bap_update_qos(transport);
 		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE)
 			bap_update_bcast_qos(transport);
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
-			transport_update_playing(transport, TRUE);
-		else
-			transport_update_playing(transport, FALSE);
+		transport_update_playing(transport, FALSE);
 		return;
 	case BT_BAP_STREAM_STATE_DISABLING:
 		return;
-- 
2.40.1

