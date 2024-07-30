Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5271C1A38D0
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348621; cv=fail; b=kRYyYGo4J5e4Y5Pm60/G59hvhWpY4qHQbcR8dxKQYbZXYx5jH5sW8mu4969uCpy2tjWiWAKUa8NQoHk/u+WrtkfZ6PIYY0Gtvs3GGfbBXLlk18JgqmzC2lR0ihvH2UU2GtkgWeo4kHFaFFmIsYsjSbG8a2AFi6B0+K8driZOLQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348621; c=relaxed/simple;
	bh=Z7LX9XM2Amtl+uR4HYCOgsS/xgxyJD7PiV9dN5s3XWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HFLYtbIx9FMKn83DWA9UrK2JkizdWwNrqfjUD2sUqMUITKvlAmG/LLeB/uV+COMC0vaOjqbCAC7jK5qtif7HvKOjqNZyWilm5qUpgKwpOLwrLS7uwUzU6/iQ0iZgUAFG7UwDqLr6pAplbdZbvgyzfyxeci98HjMyU/vyw2JzNso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c04/xoGw; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c04/xoGw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVPfUdxElp5LMUQeWceA6nle7QSzi3l5xOmSU4ZeQydtM/kgD9H9fNewmKFpAelx7KXsW+BT9tbuXq4tv9Ub6HAb6r9dNuQDOwv95gwrmQnjax4Cb/xSzvZyt/vLO7zBLerf0LQ+IpXw8gB6yc/5debgtW3EPRuc8CKMWzOE6E2+zyE8hC86/XEKjYwh61vhFUb1PytxJXvQcrkHo1AS1SBZNc5eENuHLzsBNBzHAWvZiUIC2iRGzn3soo44SDwbMT1IUZDM7v6IzEX/bSgOEuBH/t2vrQ/rkACZsFy0kOABR3r6B3EZqJRJ+J7WUQZJI+sSApLlbVm+SuoASee7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nnU9cuP1EYfbYCP2gx3b1ZGbqSXP4oI4fOsHemwom0=;
 b=STUPqppJ+xHLHSURNAg1wF647l1UKL4OD5s323iEZee7pthN9pLoSV1xRBMylMm/ATD1Kmrq7mArbVM5xxGki+sVfIZ3bvo5ZBeMCQTSkbM49I7KMR8vwKhEa2U3AY7e+yppbKoPonoxCxCa9VlLQzlulIFlqKJdRTxlVliNdyeJr7sFfZ0dM930Hoj6CQDXmUUxlzYJGK/iE2UT49E/RKheTUpZCvPQ5UgdI5BNuvFyFvS+mWWOVbCX4D35CIhxS3KdiCvNoU9ivuoK0nBnssOVte8paEBy7PkqZDinfKqgOfhBVU5719dctitGbm2NxDU0kgwouRHWs77GCdQJ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nnU9cuP1EYfbYCP2gx3b1ZGbqSXP4oI4fOsHemwom0=;
 b=c04/xoGwpffsGpA1LkhxClUCDCrQjVYri1+DV39P08G17AqkE2BxAt8o9B5AxcOVEAn+XnEwvPBoC1NJ5DFVqiFRs63KyTSV30ZDZaIzW9WEU1oq6sbJ2qtswNrGWIaN5EnLC9Y5b/e4kA2oYAGqm2AxZqaCVpFY1E0+dX2SyqeQM5N8tixtUt4KCmlReLBE3mmk73NX42hw3SS1ppDYsti7272ZkwcXi0c3RbBO1o1jYbJchfq1Kzd9lugH0xt8rU4ohDt2HpbBgaOjLhXq1PLCW+qZv5kmSdTa3CmcVNiOnX0DvJvZjAmmZRZqwCCCshQSyY7i4bU3vwqhwxDmpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DBBPR04MB8026.eurprd04.prod.outlook.com (2603:10a6:10:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 30 Jul
 2024 14:10:13 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 14:10:13 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v4 5/8] transport: Broadcast sink: wait for user to select transport
Date: Tue, 30 Jul 2024 17:09:44 +0300
Message-Id: <20240730140947.411655-6-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240730140947.411655-1-vlad.pruteanu@nxp.com>
References: <20240730140947.411655-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DBBPR04MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: f58ba29b-2382-45ed-574e-08dcb0a15417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sq5gOmxWER+7Yblrwf7CtcDE3v/8frtR5+0BdySooX1WclsG/8Wr757zjsa2?=
 =?us-ascii?Q?AbGaHL2qFCKmpcG4TbKFUmuXLJY9Ku3fZbHMi3LFJki5k0eMpBxpOJ3XECZS?=
 =?us-ascii?Q?G/kSKHcRchXd3Pcn99B3z/UckO46ozArqWyBp4C4BiNWN4RFq8KVmnIbzkDX?=
 =?us-ascii?Q?3hQVeghVPRmFgv3CLuuZhhEI2t5QOj0AWI9n/OlfciQIfvsiF63qfZZO3xQx?=
 =?us-ascii?Q?m9n2PXF+dLtHksu5+lOCV2VHxbUjzQ0vfKoknSzTkwz7bXomDV/oQvJhO9Wc?=
 =?us-ascii?Q?PkX5M/pQEEmj3Oa93IA1cVthTMd2tJMQxnFsTqAr/YCfO30I1QRB3b0Tk8G9?=
 =?us-ascii?Q?itTAk3SIVprrhwIQ+VgBfP3lMYg9lOjDzPeanmw9a610qvuLTeRoFmUSEpGu?=
 =?us-ascii?Q?Jcqu/S6hYlGpUQO/HcFkgekXAUO6oT0WYzA4gy1WF/8UmRVTLLtwluXJlizQ?=
 =?us-ascii?Q?swGfajD9atAir7MHemnA7yzkchtLwgTlKZEaWiaKspfoGdaXhWS9h8WG9Voe?=
 =?us-ascii?Q?r/rGXyhpP6adOerX0yr+ZN1XnO/ttdzVZVCBq1NENgBxur97FP6RlXuGwGjC?=
 =?us-ascii?Q?oS+eUKIB3QuzQ6uCnCXHFEiXAb3s69xxyjUmJSyFfJOE5wuxcV1gerlOSXvG?=
 =?us-ascii?Q?viZNYI9WbErV8YiQSmpCvNP0FEyxfoN50Pg5NoeaRu56i/J4TSoVpyy7AWQ9?=
 =?us-ascii?Q?9VwNwPgIRvk3SScprCvbTxTIYzqd8RhmwR43qFu315U8/cVGnRuGCoO+//Ze?=
 =?us-ascii?Q?A3aaw1BOj96CuWFqxJifZDiWmNvkaCFlMnEo0cmlVV8t9K2LYQkjgeIVhyVE?=
 =?us-ascii?Q?7c7xv1IyMNrUVaHSt8oEpxVB2Clt6a8u9OhRfEd92ZYMUwlI5mvtJnE4WaS+?=
 =?us-ascii?Q?haHn5mGLfsdmNNTyKGasSMcCozemV+NcZd63ZmFMVRaTPXirywpC7tINYwvk?=
 =?us-ascii?Q?gsutS+UJr9giEXgzaZbsxYVMCZIKxeg2ZbXB1MDvbT4TWfR04yE7MJzNFyG0?=
 =?us-ascii?Q?2IgEv3AGrt4JP9jPDk4HWvpn2UeH8L1UhomSI3Al1Bi8Urj/sZUiwkoukerk?=
 =?us-ascii?Q?39Z+9Ywq0ok3I6GyAA7WSyCZFuIO97fFeWnEfVAKjY8EO1+FeJ9EXuExknN+?=
 =?us-ascii?Q?g/rkir+qTc60v/jCV3nuGcU+tBokpdhaV0Mv8hVa4FieVqznh5nN+DovsS7C?=
 =?us-ascii?Q?1i0ANvlh4XjQK1uVCukAMypwm/5AI0OmDRxPsEgxCjgDIa2vLnvxTv2aeMxi?=
 =?us-ascii?Q?VOKil4AaUGgX8wTOyVRvvALyG/omQ698g786jxaMxtq+jRrK38Q01YlkwXG9?=
 =?us-ascii?Q?hK/5oKFKxXjenDlMvw8NtbNGfjtetAXr5P/Xvf+zPO/TWFvCOiKV0ru7cnXe?=
 =?us-ascii?Q?BZi30v1f//P9W7izGYS+KI41bprRLXyV5vPRx32Vorxa10Sj9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Zz4jl8B1/k6NKFhzF4UNaR3nd6trHqz/FiIxUmvzAzlOTbGe/Aoz+Rl84T0?=
 =?us-ascii?Q?woxm+MmZ5O/uhOThX38mP3r8gry+8GBLe5DydN4v0smOhlenD5VgBXUamLHb?=
 =?us-ascii?Q?PmH9yctQrWX+Hr1mt7XXxdyAFNSqNyxm8xJ4hQ8PgnojSsS8ADjHOibi3hrO?=
 =?us-ascii?Q?61vDEBCuG3a4qkxslYVvdzyBp5xE2M6shx8jyq8q0o2MFc7QTjJkIfTNMGyL?=
 =?us-ascii?Q?sMqEVPKEsch02egnoBxi3tzrPcOAgd355SwyvvdTy3btGV39NvYr6tJx+fBr?=
 =?us-ascii?Q?yPBw+XHi9UgpO7irC+M/yOBfyq129ay8DEdWbeKejCSx/DH/VAiGIyN9leVB?=
 =?us-ascii?Q?gs6q1aeX7zznZH1ena7vjXkQKSZPPV0pHvpXqwVwuIMl0dDO+VZ6Vy1+YFL3?=
 =?us-ascii?Q?dw6m8FajlycfQ/2Pkr8Qh3M/vlmOG9ewNmCFlim6qBliEoYi9a6QPrn7dMSI?=
 =?us-ascii?Q?+Mu8mgApWqrW9yMNrq0xZlt0U4N4GwioWfDGCZ31ToKHgFDEWRhHg5EoC3yz?=
 =?us-ascii?Q?ETzUw3LS73CctbgDttwiEr9s5JMrY4e9C7S4F1KCttavMowEABJQTFOenRrC?=
 =?us-ascii?Q?BZmvITG4glFuMuiC/h9XAr+dGiiTIoe1x6OzXOCMO9az9po0mIavfyK61gdJ?=
 =?us-ascii?Q?VaGiqCc0G3o9JbcfHjyn5lJEI6mFHKN/kC5LYgcTVMPW9Lf5kv/lSCT8E/2b?=
 =?us-ascii?Q?3YesiPoZBAMc5rchDekMrzaHB3XwQ8df0ufFsqYep4t9tu2iFdviN7+EyNYl?=
 =?us-ascii?Q?d2AzkRmaO+XMErGdMJeWb9iSllfNDrfmcO5GAOwARRgjBzn1kGiKEP0mQl5/?=
 =?us-ascii?Q?p8vNrjzfRqENFnzmDwPOd6e5+MGolHT/aPPRLb1NXttfQ7mCOZYgkKgaUC5q?=
 =?us-ascii?Q?wyebcVF1Jss9p8PmOEE1rdNL0ZY3tM7BeqckiDl3/GAsYiRVUvfU0LV2NQq6?=
 =?us-ascii?Q?NcBhKawWa3gWoSUiRTKnKSS3FwZaMrOsuvuv0qTeFvU9aoeiSESTfyUv03Tm?=
 =?us-ascii?Q?O0rkVaTAnaKqBHmXCBpLqToNfHLcmDAwckZxlPONdpCy48d4o2J9kGL4Ys2l?=
 =?us-ascii?Q?iRLdjCLB3uaTuIm5+wPZk9z0MHkf7NQaPcG3uJhw12q7WZ3W7nEzvHZsxwWP?=
 =?us-ascii?Q?HaELlQ7BZDuvcEvZR6I8cXosEtuYbyJUFadGPIhTDvfcadmrnsOzO+zbihyR?=
 =?us-ascii?Q?niOR5GJyIq++kVISKZzVT0Fhxy8gdLrd51n3owB68CsuSCTpVK/M1NQMPfpi?=
 =?us-ascii?Q?UGWdeNNzg4+0C1r9JWw3KInXquWxx9Nk8wCrcOyyrRZGh89PRuGKV8jK1/fJ?=
 =?us-ascii?Q?6R7AWgnlBaKvYR+Dquw2Yls51WCSTeHFGezNnutyozX0hWNKhlgAprzsV3YH?=
 =?us-ascii?Q?cV5sPuSouK5n+x0k1UL5oWLdF+PxFIXPmRmt7EqNoqe4ZsTk4/ABzPOTr2VU?=
 =?us-ascii?Q?Unm16YuBDeiPWiNhGClLYgE4G8xu/prQFqOzEoYu5fDxIBLdYk3KmR+4uoS6?=
 =?us-ascii?Q?yxFQbSsCZOFGNf3eLDKyYzfhqoQwlTN1VjguOQcrC5OPYoOkaHWznIycYH6D?=
 =?us-ascii?Q?3EBeElWeuJvJjqXdizQp05AFpEJRLPU/9WXzsgsk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58ba29b-2382-45ed-574e-08dcb0a15417
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 14:10:12.9614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1nPCooG+J+DSXd/pKGDMODoSh7YSheBUNeloA83qhOadPGrCixi0TNJqfU0HvNyDqTxn6+/UnmqS0zK5ud5cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8026

This changes the flow for transports created on broadcast sink side.
Transports are not automatically changed to pending anymore, instead
the user must first run transport.select on them which updates the
state to 'broadcasting'. This allows for the selection of the desired
stream when running the setup with PipeWire, which acquires any transport
that is broadcasting.
---
 profiles/audio/transport.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index bf2215a0f..80e4f564c 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1303,8 +1303,14 @@ static void transport_update_playing(struct media_transport *transport,
 			if (transport->owner != NULL)
 				media_transport_remove_owner(transport);
 		}
-	} else if (transport->state == TRANSPORT_STATE_IDLE)
-		transport_set_state(transport, TRANSPORT_STATE_PENDING);
+	} else if (transport->state == TRANSPORT_STATE_IDLE) {
+		if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BAA_SERVICE_UUID))
+			transport_set_state(transport,
+						TRANSPORT_STATE_BROADCASTING);
+		else
+			transport_set_state(transport, TRANSPORT_STATE_PENDING);
+	}
 }
 
 static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
@@ -1686,10 +1692,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
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

