Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F053513B2BE
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032264; cv=fail; b=f9Hwt6XrMmXmph3FT3v8cWId3mSOQFu+MC1BmnNk2aqM8YeG8CjecV7eSj0+xygAzhGprS+FAtRaRh18tiguoV0d1vVc0Vab2O8XWbZYogYbxCm5zyAXnxWXxVpyD8j41C+ewxoj8+3RjUNZuYvlJ8xxr9EvcVMNb0JhuST69Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032264; c=relaxed/simple;
	bh=NfEaeYMq7wCjgpl1qD5td+SI76wSJ7PhjAp1KvnMlC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QBMQ+wTAYoMGqM2GYT6wA68HT0IQvbLuBN62GYDBzZ3fAftkzE/XAJQu9YDvss5/R6iPlUPKdPrWtcPfeBWRqVgjAlMHXUJpkYyCcxH8rY8nraSoGEihTqCJr85/7rq5NMtQXfyM0EeDvtW8k5ZXYCd/fL1XpsLUgdN6WgN4sMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=duBma52b; arc=fail smtp.client-ip=40.107.7.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="duBma52b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmkEO1CDE2CLdcl9gfNACgBRS9FMLvyDnudHH4b5qXTIZPxsy0nhm71c+vVjJv8vtTTMBbgGNPzGlI33JrwNgyg0pvPX9XHA1312TwnAa/sCPKrmgxBJdx1jLbZVFCXR8vCG/Q5Fx/9A3bSSmzW9ClGR3dPOeHPuuNkrzfe8CePv8Wcb4kGSIwaLUx9/NZH2jM5/tG9TqK+MHjduuDRyHCHs2JZi9CxiybX1UJU//D5WIfN9GrM/2GR/gwVaH0l5hVF2E2k+sdD1+xS64CQALi4rBQU08QlHEvivCpXrbksSPkeyXCdJn8Uv074vdqSzHsDM3QZg6y3ywL6f6TuqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gulSLYnZfHdePQ2vCN0vcmcXi4PtUs3FQkEWFcDuRo=;
 b=KzP3LNRR9R0kz658y2xxAJnWgT7VWbSzZI68WoAjP3YclwsUE3MA+mTCdzPN1PfVzNLtbic7ma1lGEveVxyppi2wq55Qs/HUQ1QZ9llRDKpI0ANLn7L5nhCm8+/+CNjn1zrrzrsE/jQ6PLh8WGY4A4QsFcCI4jQVv5g4wnaAtGWuFfnwDxehP5f5YE5tVsmcvpx6MKQxDtS+aLT+vnmBhNDgjo29DoPxIXC3mWdeOBlbsGP2VarDQXNs1N1kThHVrCDXF+Kn+bYZk3yxFphBU2RaUuN5ZKHBQHbyKVLzk7NgSOl6AAjrNUoPUT/6SO9IrcCjkbH/RT3Wir1t0tichw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gulSLYnZfHdePQ2vCN0vcmcXi4PtUs3FQkEWFcDuRo=;
 b=duBma52b6ssPnx+VO2xYgovUOxKVsB7+eccsFLp8/zkCTOCjbIeOpINf1TAHb8Kq9LIZXryHi9+Uz0VLHz9msQ2g2h0AvhJHAilsk0YFCkzkH+4piRdAR09WRTeI1qB30FO6dXmN1M2iMdLCwAiHLv8aA2NBwDdqrlBFyyIk+1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM9PR04MB8275.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Thu, 15 Feb
 2024 21:24:19 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 21:24:18 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v3 6/7] shared/bap: Add support to create stream for bcast source
Date: Thu, 15 Feb 2024 23:23:55 +0200
Message-Id: <20240215212356.310301-7-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215212356.310301-1-silviu.barbulescu@nxp.com>
References: <20240215212356.310301-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0097.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::38) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM9PR04MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b41c27-047a-4100-5d66-08dc2e6c7810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jDyql1JIsVJQks48DLriQt7X6dlkWqrkzpSIak5I3MpebNqA0h6JaC+sV3BCYNnz3c/JHMb7cC+YIM8P+AUYTcHgs/IqEQPR/3wQP+/65YFhhAQgiheXCzuGk18mSZNH99/YWDQNIELnhPvUcR6o7ETLOdmiRI0TeRgeUBvpygMfTjNp0D0sZEkHEKH7tRSR45Lx+QtJGDqqfKK9SCbbL8eyBNpndRbyv9j73vyVipPBEmKaHuSS9YSZ/AagjEBxSRjvGFdG+n5uTALUx+Z6w6VZZkYuGWDkJyKjdAhXo/d1zzgk6CaIAyudFOLyXsqS4C6XPGv8vD6NOfNSAdEq+ufM9DUdCx1oN2nAUKKYvEAqGfN0zCHP87qWAxp0H3nW6AZeZlTjJ6DWejsn1nyAzjcgItJGsVJBy5cyS3SD3KTPcqQ7K+Sq3Lznj9kulXpb90t06YNtrWBO/zxey7VrhJpl2ic9BtfpxMFByqLD7ZtBGSXsgOWBp2+HsRRo4LHc2hf/KAOUHG+D0SQSS3Ocyclvn8rrj1z1Z4R+YNEP0ynKT9CxEI1EBxXgBzsC9XSQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2906002)(478600001)(1076003)(2616005)(26005)(316002)(6666004)(41300700001)(6486002)(6506007)(6512007)(5660300002)(66556008)(66476007)(66946007)(4326008)(8936002)(6916009)(8676002)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aTzff1fl4Hc3VkZjik5Cyr28Cr3AX+BgngW/KFdJIDmbJzk6Yc68Jabu/xpV?=
 =?us-ascii?Q?1uanCxsGg4+ml9/wn2idbjk8gb8bpzpFCPZjis6HEEx/gOMImtqTw5TNipB0?=
 =?us-ascii?Q?lZciI/asbgFCzC+nUkqS9pxJgINsijQWEE1OiNujvCgQa2xPaHJNclSAUmTv?=
 =?us-ascii?Q?SMa83cIMCe12QZuG7DHzuCsmxyXlCT/nVjmXlLkn1H9EKEbH+G81JKPJDIo5?=
 =?us-ascii?Q?xTtpazov03Wyz+oIXW/EYqlMd+sKxwYOYjJ7maBEsnrR8soQfArcIwNbToo6?=
 =?us-ascii?Q?+lW8CwSg/I+ZjbE/YJ+o9+U2xC53pb7etYJQbwKkD8W4bQnyzFT/v7yh8gT5?=
 =?us-ascii?Q?GWOqoLl1vu9KyiweMQXflSoxtBNgAUu7eW0r3FdlAZ0pevPUETWk0zDfLpB0?=
 =?us-ascii?Q?UWyAhkzNJHvZgQ/ixn9aE7jMhgodnu3ujleuL1kFxaNuCzaeNtlnhl+utT1C?=
 =?us-ascii?Q?4+RGbkt9j6fSnEgN09Y1zgp/KniQ5F3x/r3xOIBvxxYyhHWkN+2We03AjJZf?=
 =?us-ascii?Q?Tu43TGu7ZDsFX67HDu2UrcYpcLnj2Ingh9LBCQW7Yg+UpSloJW+5V20kBY9/?=
 =?us-ascii?Q?zCckFPS+Cklh060ALgZ9qNjaUok2WCTbThjEm5NbZuGXuN/N7Mp1YA0bH6y0?=
 =?us-ascii?Q?SVepH3XFGJf7YdMDCXXcV+ADqtXPxiU6iDoPLLcpEJXko3NFz/jmnVh9esWP?=
 =?us-ascii?Q?tITloF7zsgJMPqjceAOlp5KdXLq7CY/swkjSk7BIWgpSUC06N2PREn81YjFb?=
 =?us-ascii?Q?L3HYhIPrgKZDFsof4CD6v4FUD5AACsc181GCrXetFEPx4DJ8AQKDdYntey7Y?=
 =?us-ascii?Q?cayhJGVizGsrZYRqenczqbpL2FINkvBqryuD9hEoYftKFeqiD2tg+FSpVe+n?=
 =?us-ascii?Q?ltwN5yzd7IVA3IZotDvLZ3c9xJ1x5XQlQJEGEBu/9cSoo8pRJ+0A+hVf+uoL?=
 =?us-ascii?Q?NOY1PheJOqIqVxmUHye1mthIgUNZdKB4Bjo9LkcvsqmsGTUg/3by5mRnuuPx?=
 =?us-ascii?Q?6YMUceCZvEpr7oKJiyP7ideCWeEwXpXDBRr4+BHOM/5n4VbCcskb9w24DF+W?=
 =?us-ascii?Q?lUj5fnJm2b+8U0w/8qcxld+wBKYgwkVRQ/xbtuUfEI4Rdqv/0jmFPxGSuWPw?=
 =?us-ascii?Q?urDzX5u5CsW4qq0Qb4juYFgGyHfbpaa55atp5mxJGxDlOoQQHPstxnYBxxH3?=
 =?us-ascii?Q?wfcPoHvSKx0ICox97nk0tsYZdH3a6hSKvoFgQxTplko63mMNdo3/mYfJY7sm?=
 =?us-ascii?Q?diGJC7QNrGbnfOi4WMH1iRiPng7DXHCidy4U/eJAn7ecew5rxeNuk0Is24qs?=
 =?us-ascii?Q?RkojWom7f8UiRh3invs/xN6iUGkbJdHharG1w3iPERLvUmcsfCSY87SVtcec?=
 =?us-ascii?Q?qo84AvuDsUe6fkhHIIWnca1kZiX1ZZJwAv/oZXwdMco/vK34gocLwBNGEQAD?=
 =?us-ascii?Q?Wq+RVBAJn0Cj6DwwwningfSu40TEaElfNc5eQfprEj6Z13lKPnJWXjfcSl50?=
 =?us-ascii?Q?R3S478rkoYWD+6j66Kr7OkBRHcHDz87MGDYJyjl2rTS6mdAUZwF7SYfPuPx+?=
 =?us-ascii?Q?+jUOvG4Gyadk4HOgm/ebjCZDPLOEwBYW3cu2iCSXa19PmMu0uxhnEQYQvmPh?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b41c27-047a-4100-5d66-08dc2e6c7810
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 21:24:18.6441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1fMQqfy6l+0GjFt0fxfvAznImN0CFF3R7VSU0N2kdrwc/mcIyrGudVajjXDjaEDSMfDpwIlizNRhMkZfR7oHwTcdLvNri5dbI3bP4NkMaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8275

Add support to create stream for bcast source

---
 src/shared/bap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 49d9838fb..97bf65c24 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5038,6 +5038,10 @@ static bool find_ep_pacs(const void *data, const void *user_data)
 	case BT_BAP_STREAM_STATE_CONFIG:
 	case BT_BAP_STREAM_STATE_QOS:
 		return true;
+	default:
+		if (ep->stream->lpac->type ==
+				BT_BAP_BCAST_SOURCE)
+			return true;
 	}
 
 	return false;
@@ -5159,7 +5163,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 					struct bt_bap_qos *pqos,
 					struct iovec *data)
 {
-	struct bt_bap_stream *stream;
+	struct bt_bap_stream *stream = NULL;
 	struct bt_bap_endpoint *ep;
 	struct match_pac match;
 
@@ -5227,7 +5231,8 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 		}
 	}
 
-	stream = ep->stream;
+	if (lpac->type != BT_BAP_BCAST_SOURCE)
+		stream = ep->stream;
 	if (!stream)
 		stream = bap_stream_new(bap, ep, lpac, rpac, data, true);
 
-- 
2.39.2

