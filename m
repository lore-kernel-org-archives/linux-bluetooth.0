Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="POP5VA/L"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2051.outbound.protection.outlook.com [40.107.249.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74961AE
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 13:59:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgWOtKUkceEhdbLMtEpgsbCffY0/wP70gytIhzPI5xp/w2yahWxkc+7sLNKZW44PW1d0+v+LFFfxAztgXJzZMIK73p70P5Uo4OG0B4VrPXUKf89cl/H/q24v+J8/v3c3vesltbFP+19V06gyd+eFMxKGQm9ZiwTCcVK/Zf8zmyf9OI6ZWOQlyZuq52nCvV6eyVqOi7nXIzFXRnomHwAQeeDy7wWBUhSJZ0bnobNPEjZVsypia1/yd6K0hQ0nbdzcYXbLJgjmZcmLuxKsqTsn2e2oOkH0Uqf/Gb0yHRRXfBHdBmFEt7D86gPw7thsYuRtksSZwJVvG14EayPYlWBznQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6V61KzbkqvULtcjKTON8fjRp63WjR6XKvDu3wxKNns=;
 b=JBMMpq7Mlvt+XfDdvfBkysjB4WzlItuye4eTm6PGDbYGSbt8X6EbJQYvL0OtxYDxahEiAvbyFL4Qt4Q4JgR9TkgGu4IvTSlVmlchcwogsG0RKBKCuJY0UgVzCHdf04vVafG9TyITHvQZ5c1wKR8AgSXH/OwBN5v35TGnmDrQP8oZP9s3KbjXY54eJXWC87J/jqOmOHxnAhWXejiQg9mqNyHR9M9P+yVGQ4av+nSad+EBjylziLuuhzihOyAk1TZ56Oja6jOnORtzY7ntWfHtzuTt4+e9R654X8Ura7u3Wjne37m759khP/sbl4RB3HjgPpefIUa0h/OKLLteDEAA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6V61KzbkqvULtcjKTON8fjRp63WjR6XKvDu3wxKNns=;
 b=POP5VA/L7fiKKU0g7RzqDBe0WexocPpqehlFeOIotjHQKYY7xKk7zwjylX8bDIoxLNjbliJSucx6RERJPXH78dGtAOkHhLC4flh5Fr98VTIFck7pJY+0p4b9OPmrVDm6t4PhudWdhpJllQA3jGecrkEXS0ucC868Y0DZ2OwDzMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PAXPR04MB8335.eurprd04.prod.outlook.com (2603:10a6:102:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.14; Thu, 23 Nov
 2023 21:59:45 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a%6]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 21:59:45 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v6 2/5] audio/bap: Fix source+sink endpoint registration
Date: Thu, 23 Nov 2023 23:59:32 +0200
Message-Id: <20231123215935.73501-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123215935.73501-1-silviu.barbulescu@nxp.com>
References: <20231123215935.73501-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::12) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PAXPR04MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd504ef-11f0-40de-5a54-08dbec6f813c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	POX9bzLD0ofEIZ40rBlNxkwgfn0aN3ldLL4g9dEW71eBLtx4e+VbxI0Dk85p0nwi+8iSl+DyCRBDJvShGzoXq2ltU5VGYZEdTfTxA7B/pi5pi5GEEH2XqtL7fMcCwEhghCWEr7JPvyFegIxUkj6QpRICRnGgkBL4k5Q2jndAbGQEJ2P5fPPGjTLJmaZIEx1zK1letwC/XO7ct5fGC+1DtvSkxQY2RV9pApiRJIPoCGxbuv4CEYQs/zWjMN2yxyDumjs0cMT0Mg/MNwb8XhTiiTOsvHHNX+xxuypl1bGvDDzKMrhaXvrq8G+m2ZqzLMMnEG1rUMC2RdHE5xTScnPcoKHw4Hf+u9hyicmPe0orzpxLf2e9mauTPO7qPj4CxAxVWe4gtWFbglLboCq5YiEWme/G4bRqpruGXiyJiIYexxYgJjzjlBf4+hUl69226pXDdawgszNArX5nZX/RZ1Zb8auGZX76OJ76VS7zbOAcWUIZw5GedH5eRKl8kjk9qw3JoGze9vmWmKF/pJgL3mP/6kwDMe1vgHrwrOA26vjk6HfGe42c+6GaLuw33PRnQVmkjQF1xvN8DpLo4OjdkWXxZgAcQ7nHZoVPM97cwZQD1P4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(316002)(66476007)(6916009)(66556008)(6512007)(1076003)(26005)(66946007)(8676002)(8936002)(83380400001)(478600001)(6486002)(6666004)(4326008)(6506007)(5660300002)(2906002)(38100700002)(41300700001)(2013699003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x7NLrCsrLxOgI4/u6oTI3k8QHj9OS6p54BqylRZZP83m70klE+LVYqENntde?=
 =?us-ascii?Q?2hRP/QURaecW3dfFTdrwV1tS07exctR033U3TIHsvN6hmzkRO3vE1P4D/rZE?=
 =?us-ascii?Q?T/R897KxmUr4l5Blyhgg9P/WPfq3JxTfvpgJGdhVKXz6NUL1emYBEWpKjqmR?=
 =?us-ascii?Q?DDkEa8nuDF0YxvveA5g3iQQWIvAkgWLdBDpNexKSNrLEB1OZk5qkEEw1jozV?=
 =?us-ascii?Q?DqP8NX8cvilf7HPKtGIpIbua4pElSQV3XJZEk5jfLai1AP0RgNhuKA8cs3te?=
 =?us-ascii?Q?lCUxunnFWehXlo2YwLOKFekGTqID5Y8JHkTfJX73y+lWpVm/g4AQsOQe0BkS?=
 =?us-ascii?Q?ABV/upS/KnoOMXaVE39+VeXnRMAtQF+AA3oMTo2rTH2dl5nqYSNcChzIHpqs?=
 =?us-ascii?Q?e3zT2zoalCjeR2hpVwVE1i6cf124rWkNqM/ocYa5PKII8aaTWgjJG9pe9nC0?=
 =?us-ascii?Q?bzt3rkdNib6YocSHtPXECLqwI0RwOKUWDmL5HfuJVYV9PyyQW1D8otqimAVQ?=
 =?us-ascii?Q?JZq7ATHLvJXl1VMJf0hzAURK+XGj+wOfgXC340mUHKVAfN+z00smmyU0DPTo?=
 =?us-ascii?Q?u6p7mmujYAW06RBgo676+fJX3cM3QSsB1PNICDaVXpZzFsRdTnHU5msMSXmK?=
 =?us-ascii?Q?g7lXuOy7mlvM1cQQuWM0DIQA1/TrJYeg6AbnWMD6S3Cgu32oj2znPqmU0aCI?=
 =?us-ascii?Q?Bfzkc8+iLsQhBdKU4Sh/Ee7dkUeq0u5O9LjQgBv1y2CCy/aKZFTV6AHzZCOV?=
 =?us-ascii?Q?FQn5IXFDOiuDG0hAxoiE/dktJBN8apwQf1ZvGUc3DD5AHySxnRi4n20uaqkC?=
 =?us-ascii?Q?1AIT8p7zrNw8yrCdrpJLZq5U4rdYvZd3ndiX7JmifMjPtZfdOFXP4FyY4Lb2?=
 =?us-ascii?Q?hLIEEtc5Dgmh/smCy9n6Hj7UWJLB3lTdclS+aLQP/SSX8CsHV+eB+57BjQqH?=
 =?us-ascii?Q?L4YJwQInDrJjyYNTXZ63YS01nBS4ODKc/1d5hqk+O/3T+NzQkioITYVKVEyc?=
 =?us-ascii?Q?OxKTzE5cZLkqUxB/GD+jmIOdM1vQTHUO/fK+a6m/xCb9RHZap90qWqgPB5KN?=
 =?us-ascii?Q?KuRQy8FI0/ReqmGuh38/H+SB9qa7pg8WTkoG0sNJhdNV5j2XHWyxfM7N9Jnm?=
 =?us-ascii?Q?Lw+vWBTejb0+83ZASOWUF9F4W4yfpZ9H/eD/qQ4YA9yAgdE7hVknZXt4qr65?=
 =?us-ascii?Q?EV6jXoyzLd8fc24KW4nG1419ET0QrqT2LonnJLXHlhMfBsTy1BRqRRss/+sy?=
 =?us-ascii?Q?EOo0mjem+95ejoyLuWnX/YMnpXOMuHPwRlFFzI2OFKNQhArbVcwDW8baUWfZ?=
 =?us-ascii?Q?/1N6Md41gKEZxQXa7ZDKm4t6ryjwYGlGqfbUrMMQ8gIQrZpKm8O487PIo3NL?=
 =?us-ascii?Q?ugfMSaihL+KXn677r8xW1TsfkbykKdRqGj1iOukYjWy7hITf5IDCmPRdxFpt?=
 =?us-ascii?Q?r4fe5xNlPM/tH8iPmpyxFWF3futlfamneHWUJTyI8W3IT+vmdDgNK2Vm2sDD?=
 =?us-ascii?Q?5YwJFeWdOZclO0hpc1BQLggyZPFCG0DKMQ7mw/IXeNAd3kWwbJosIPxQQB+b?=
 =?us-ascii?Q?oqRKBJwwACviudkyrVoNlzrefF6xRGQ8XsJjedN3ixN0Hm7pbH/b4PzAfIVN?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd504ef-11f0-40de-5a54-08dbec6f813c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 21:59:45.8298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8ttKCK30aADfgD35jkwn5CWjAtB7cCXrStN7CdI7hA21NhZnAMAILDgjcsNB+KFJ3bmNuJq/zWkEFZdnRoDyS9hcXPY0W929825ykyNAVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8335

From: Claudia Draghicescu <claudia.rosu@nxp.com>

When registering both sink and source endpoints,
the register endpoint method call results in 2 remote endpoints for each
scanned broadcast source

---
 profiles/audio/bap.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 780dff412..c279b5b0e 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1050,7 +1050,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	const char *suffix;
 	struct match_ep match = { lpac, rpac };
 
-	switch (bt_bap_pac_get_type(rpac)) {
+	switch (bt_bap_pac_get_type(lpac)) {
 	case BT_BAP_BCAST_SOURCE:
 	case BT_BAP_BCAST_SINK:
 		queue = data->bcast;
@@ -1073,13 +1073,13 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	if (device)
 		ep->data->device = device;
 
-	switch (bt_bap_pac_get_type(rpac)) {
-	case BT_BAP_BCAST_SINK:
+	switch (bt_bap_pac_get_type(lpac)) {
+	case BT_BAP_BCAST_SOURCE:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				adapter_get_path(adapter), suffix, i);
 		ep->base = new0(struct iovec, 1);
 		break;
-	case BT_BAP_BCAST_SOURCE:
+	case BT_BAP_BCAST_SINK:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				device_get_path(device), suffix, i);
 		ep->base = new0(struct iovec, 1);
@@ -1101,7 +1101,15 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 		ep_free(ep);
 		return NULL;
 	}
-	bt_bap_pac_set_user_data(rpac, ep->path);
+
+	/*
+	 * The broadcast source local endpoint has only lpac and broadcast
+	 * sink local endpoint has a rpac and a lpac
+	 */
+	if (rpac)
+		bt_bap_pac_set_user_data(rpac, ep->path);
+	else
+		bt_bap_pac_set_user_data(lpac, ep->path);
 
 	DBG("ep %p lpac %p rpac %p path %s", ep, ep->lpac, ep->rpac, ep->path);
 
@@ -1792,7 +1800,7 @@ static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 		error("%s", err->message);
 		g_error_free(err);
 	}
-
+	ep->io = io;
 	ep->data->listen_io = io;
 
 }
@@ -1962,12 +1970,18 @@ static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
 {
 	struct bap_data *data = user_data;
 
-	if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SOURCE)
-		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SOURCE,
-						pac_found_bcast, data);
-	else if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SINK)
-		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SINK,
-						pac_found_bcast, data);
+	/*
+	 * If pac type is BT_BAP_BCAST_SOURCE locally create an endpoint
+	 * without a remote pac.
+	 * If pac type is BT_BAP_BCAST_SOURCE and remote then look for a
+	 * local broadcast sink pac locally before creating an endpoint.
+	 */
+	if (bt_bap_pac_bcast_is_local(data->bap, pac) &&
+		(bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SOURCE))
+		pac_found_bcast(pac, NULL, user_data);
+	else
+		bt_bap_foreach_pac(data->bap, bt_bap_pac_get_type(pac),
+					pac_found_bcast, data);
 }
 
 static bool ep_match_pac(const void *data, const void *match_data)
-- 
2.39.2

