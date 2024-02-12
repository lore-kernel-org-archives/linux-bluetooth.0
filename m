Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D523B799
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751961; cv=fail; b=Pfoj7+3JBGRfjMb3SRylJqxGJOZLYh5lxQQcFX+QDby0ufzPotfaF/zXDK8dzIdaclNuOPkIbISI1rjwXR+InihKXiwB210TvMklFTGB7RgiGrTrBb6+VwcMGLn588VQNwpo1c1jAavV/6ubuSmQe/0s90EH3o7BBhzHA/PAEN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751961; c=relaxed/simple;
	bh=CRCGugpck/+qO6ArnikxW4NC0SJVfFatAx2T/CW/Hc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b67UUPaw1yqkBJC8Bn30ZebkAvV1QaIkdPIkrspFoRLnY8UPzcwECgxsXjdfNoBGSt3K9E0nc0Z54H5XaXLTx1umAQamDnW+Rjn5Dkhg4T2pbB8uGHgVO0shZOrOBkOH378gZVM/RSvsS5LVtHB+8bjZibSiyOlmSMQaQHzbbF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GV5kIeYm; arc=fail smtp.client-ip=40.107.6.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GV5kIeYm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuVMaIS2msEGVl4Opvk4tJq/FiNl/lI39NyDNAHgwt8nbNtwGyh28fG0pkbclvDWMA4OVGBn6HHKelbgg9p/hXWA9QHMbIKCBWSEEVXfQgA2nEZt636uAZ3dihyxpAAYF6Hpfdw1q7+L7lw/WCMfAq0AV34vRQHHTHfh2HIXZJJGQWY7Vrj3vxQ1y0GzjyhetMCa5NOCH6ftfMYzqRHVlOyNV4Wo8VdqkymDwlkNKutKmt9fmGfHE6I9ZGBXkdRgRY9P1taZepMNsH1yNL0QNosLKT50iheyITOa2f7zr6quR0QbfXn85iC6CCOWBJUmTFU7tDLuS7clZrjq6k/bAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycROY/n45NnvxlaM4coSi1tjNHuEdZI61E+owK/S9l4=;
 b=DNg9WyoQ5ADxN0kIjhgy3bRtRUs+kzmdYcPMoJfdqGF/x3qiWqlU7j6qK0CNCEuPjULdjBJgIRZ1n5C7ZvCkx93cxvjEW/dvk9C8Q/Ve2DR1E0A20kZmb61OdFNq2OPzq4JquxhWEsa7qlJ5DxmxuEVZCH+GfE4S0436HtptnNo1V4L69rhdV0wK079V3uaUOaJK2QOl5JJFWbDBqlbyXjXW0H8atyJKt7BuVlid+LDZskYalbIlDhULa5LhVN5oflwdkc8ke4NxBLHa0aR6RwFuoGxY4IvYT/0Yvp0PeySp4D1bfwwyrI1tKKkLIiiqquaYJAT9GgGTHOmyBlT8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycROY/n45NnvxlaM4coSi1tjNHuEdZI61E+owK/S9l4=;
 b=GV5kIeYm7katRiHNuuKF2vOR44X0hEG+ejW0QFdAkuswqHjjtKZNLkJ/b9PVoq+AnWa41qTZxER/YQFf/3oiRZ4ItchrPDYif8bXG+ZBOxCRZPdSkf6krsmPLcwQ+VMvDHNfnQ1TBkkanT2eAHyIJJKJbkw2H9PO/qT7OOIXzZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PAXPR04MB8301.eurprd04.prod.outlook.com (2603:10a6:102:1c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Mon, 12 Feb
 2024 15:32:33 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.025; Mon, 12 Feb 2024
 15:32:33 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 3/7] bap: Create a new endpoint for the next BIS configuration
Date: Mon, 12 Feb 2024 17:32:18 +0200
Message-Id: <20240212153222.8191-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212153222.8191-1-silviu.barbulescu@nxp.com>
References: <20240212153222.8191-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0009.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::22) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PAXPR04MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b23c92-9bc8-46de-cf0f-08dc2bdfd52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0DICoEOcMvo4qnZkD1X1Pc4dcTqGf4Hbo0zFKlPWcG9mWvCTv+nrp0Mu/vYjcYd13KS0x7bXaXudj8vEsDJfseM4gw5DPe5PqW2mUlouOZhiSKstaV2s1RmfO6zlFA2A6T71djfSEGQG4jzAzzg+7M0RfV3uV7M+ovAz5rWJNf2Q0Fyl1qBGabfU7LWk8tx7anUBEr5K6TWRoV7y8O4nwkMkK82kcAb5jZYTINaPr++oMo++SG4SKXkQTddQQonsnqcuL2g7Fngv7RVFh8MiGpMT4FaGew4mMntjUXfk5WFsz3eiOsOe3sx83ASeibqQqFrqzjOwtlUDY2Nh/AMlCQBsIMkmsL75wDqblS977UoFTmjQpCr4UJ1FnPP/7uvdf1HUsO7mWaMu1yetE4SUdw0HKo9ehmMUAb+u3/Y+OYpt89e9jG32qYhu4Z01b9NgHrw+JwQ9xHTCy+rpYqFJQuXnyEcSKudZ3mq6SdTYQm5+7Vzt8xqj6i/G9EynMT1lxJtgfKYA+YbjGo/tr8TJWRdVmygX5+W7DxLWCcKFDkgF84m0EwZywK2CqC+orum7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6666004)(316002)(2906002)(5660300002)(66556008)(66476007)(4326008)(66946007)(86362001)(8936002)(8676002)(6916009)(6512007)(6506007)(478600001)(26005)(2616005)(41300700001)(1076003)(36756003)(6486002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gPmNt8QworZsp9IKcPZP+BV7yaZ+WIr6Z6BgwhcFRa+R6AFnb66En6lx9lTS?=
 =?us-ascii?Q?bKUGyx1aCEVccOz2idzIF8IxXMb3lRcBwlCt8iw/NJQo8viimnET8DNuUSZz?=
 =?us-ascii?Q?QLunUEiRolj2htCT42uvu7OxZTtY5fMZlRRKjr965OPc4OZrSEcBeXuLOYSc?=
 =?us-ascii?Q?u0V3U9OYKdbPY/KjuJD+n/F/8kLK4Bs4JoFqKst6X1UNygjsy+m4tjyHIB8r?=
 =?us-ascii?Q?71S4IJx+EOEDboi+XF2GspUkGTgFkE2nQnjRyLlXnVs5onRl5u5++ZwN9cMJ?=
 =?us-ascii?Q?QBKxVl1N0AI4y5+AJ70pdQHpt7eXP+N4M5RWad1C+OOdi8JOkFV/Yq7DWDtT?=
 =?us-ascii?Q?uveHO+pkbawJguDpVA2CWL92BE55H7HBb4zjaiCvy6ds9GLt2C9K5lvVyCHB?=
 =?us-ascii?Q?iWQu2isOcXuFYp2uGso6JzDyg4qCkEZSEcTIZWomAcErZ3nqRLMOfjzCrXta?=
 =?us-ascii?Q?vVvAzrMTWidOkBlWitKhvmdaJ+IeCOGvC0VdvLRzOZ57evxgae84mXLZDrb4?=
 =?us-ascii?Q?lsj/sQIRin+WEypbeEIgmS8Ajau9a1l/IP6cOSSdL1iFtb8o0JSOTTB8OBnl?=
 =?us-ascii?Q?5qAcAkFjLxjHumiILlQWmqZRt3gLFI1cnjaKewTkyHb6KUryyWRhTlFIAPl7?=
 =?us-ascii?Q?8i0PJW2WJ13D8rnjXOFhM5ffp9X6JxAZylsrmRjzezw4kji9DIrNEUCzEdYK?=
 =?us-ascii?Q?GkR/MnTvqd3s627gyiVJyFgQjq9rNLtdVucRQUt+ukmJiIcaZ4rhwxks+k8S?=
 =?us-ascii?Q?kjnb6RKW46rbC2Jr+R9BJ18csW8jUQ8dQajPhw66JYFZQcK9wuejBpKvDPvP?=
 =?us-ascii?Q?yi6DCFCBiBDSn2h/bWlmB5SIQzI498GV00kQIs+Hi8SV/Okg9c7kQYlt5nb1?=
 =?us-ascii?Q?IeCovVwk5euBFeMR565kWH6pSP/WL3ar8dIGhl9BowGW5MBOdPX4LXWpfu5U?=
 =?us-ascii?Q?GC/RoEcK2atxDY+9AUwOMpXRcce7K0e7qyLoSVy7aZG4OItgUQrxOAeEK4SH?=
 =?us-ascii?Q?MrRvT1swZsT16KG8WWaSxPPDNZomNrxqNK/uKwWvEMdIjePtRHotUWAbpqBg?=
 =?us-ascii?Q?yROFxyBH/n4ajzDB+hjJe2wxm+qMzyvhl1XFfOkEZB0GVWv3oK1Ms+pzTmWE?=
 =?us-ascii?Q?vcMJ/Lg5AA4IDKZSQCLLoDyciuM2st6WyaPxToV5TCRTzR7B3Htgc5F75B55?=
 =?us-ascii?Q?UCoDMxnxnC7yq2xTjG2XnnOnz0qspnckgLHaFeVkRulwRXfBJ+Wa2BVYtsE2?=
 =?us-ascii?Q?9bquX/r8VEi+QZsyeeRiY8UlOr6AGVOAGO16ZaDSeAVxaQvWctANBSFGeLl6?=
 =?us-ascii?Q?K5u3JFHm8ng/UCOhb+kI2mXETHHzE8cH5dsKsnsvUxTBqAUhHWK71V3zQZPU?=
 =?us-ascii?Q?nJamSmSDxxqg5SyclVmWWPdN6DzO53vj31jSwk5SSLC6CInqnkw4ETNys3Dt?=
 =?us-ascii?Q?HIhM7l17dEgyznj2aF2bUf2yp7yHpFaIYTz54XWV3X6Hs/r1VgyziwyAxYVB?=
 =?us-ascii?Q?AaaxiNEevFV2UO2etmBxuMvRSqn0S8pPoEIAdp97yn1Jyw3iTrNnpIQJO0Va?=
 =?us-ascii?Q?EiR6VYUa1J44vb3fdQts5yokG9KD72Lzh4++PIeU0gvK6w77he4pSqvbE+LW?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b23c92-9bc8-46de-cf0f-08dc2bdfd52a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 15:32:33.5159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wa4g4KxwlD4LQ2rXlGKbULxnFRbP9ivn+OgrRzrNjN7mLZg8n8ICRLdqE6nMWXT5ZFZVKasCnMVJsWXD51w5nmYDfdLmtfQoqPoLXcpD42A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8301

Add support to create a new endpoint to be available for the next
BIS configuration.
Broadcast source requires the creation of multiple endpoints, one
for each BIS for the multiple BISes scenario.
---
 profiles/audio/bap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 38ee42894..ffd742d7d 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -926,6 +926,10 @@ static void setup_free(void *data)
 	free(setup);
 }
 
+static struct bap_ep *ep_register_bcast(struct bap_data *data,
+					struct bt_bap_pac *lpac,
+					struct bt_bap_pac *rpac);
+
 static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -982,6 +986,10 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		else {
 			setup->base = bt_bap_stream_get_base(setup->stream);
 			setup->id = 0;
+			/* Create a new endpoint for a new BIS */
+			if (!ep_register_bcast(ep->data, ep->lpac, ep->rpac))
+				error("Unable to register endpoint for pac %p",
+						ep->lpac);
 		}
 
 		if (ep->data->service)
@@ -1133,6 +1141,10 @@ static bool match_ep(const void *data, const void *user_data)
 	const struct bap_ep *ep = data;
 	const struct match_ep *match = user_data;
 
+	if ((!ep->lpac) || (!ep->rpac) ||
+		(!match->lpac) || (!match->rpac))
+		return false;
+
 	if (ep->lpac != match->lpac)
 		return false;
 
-- 
2.39.2

