Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6A115A485
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801333; cv=fail; b=kpFCFDBLVTMWnv3RCiJn/CPCNjdK58QLh0WNjPJC/gZQtH28v+Zk1+PXJNIVXQENH9pWlGW1gYvNNT/UMB7YOJU0yb6eqN9FDRpCjULwlBeeML8Pyqh2skvQfi/2IwXeHgzoXD9Ho8wjvRGQeQN32mpxQvTDsbFXIf2JTnD9p0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801333; c=relaxed/simple;
	bh=8F2j1n+VLb//X5vcdy4lDKqXi0nsp+WRC8HLR7hpdJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=igsK+Ys9fhiHLA8Mdjz6i22fFSwNp1uGry2GF1P2XDfcV9k/W4A4sMtlpzr5D5VR+waX87UitdrxYgFrvfxwbUwrL2MwdHo5N94wHPJPsC7Aaf8B5t7VnyGNfGS0uNuQhsBRV8smArqUTZYdVLW6M/fbSN70KH7+AEJoTfoirMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=R4Hj8QT3; arc=fail smtp.client-ip=40.107.7.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R4Hj8QT3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBK/+wLxJAb+YCVepGdZXDs+2/+g2gv50u0j/K1o/JJv72NMfUicrE3Bl5jvar0vE87mvqsF+4phkUdjOeaizeQ6ufVWD3UxhMxysDpzy41Ml8dPL9cC/N/BLfY441bIZW2GHlMDG1gZHOoo08iMVkTrilb4emS0LlvqKgGw36krSZ2wBOlCKQYM31GELhe/wpKsDcNjki7rRJEWvKUgRSicQrCJNvDUxCB8KalgsFtPmIQ76+0ZtQFG+2xhFq/7lQdwSG07+TOSpD6wo5t8fP3gh6sgjWGM7MhpE0zCrvOd5lYWdaJo3l0F00V6NwIGQIYh//SZr4UetHq1Wh4dyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sMlhjmIhOiKbJfqaCBElJgoXGpyGAVhJ3+iQLTo+RY=;
 b=UPUcVN2bmjgznDysq9dUVkFVinO2t7KRpETSfC+sWSYNDw+Ornx+tIEDpZviH1DKqwkbnwqk9xspvJQli+ATmxMqYQqMhZ3F8ZzEN89uyeN3ZeXkTQShHkKjfn0jw1EmVAePIA1JkS2KbPCJj2SeYUCheftoiXEve4Syf5q67QBPe53mkmfSpCinytFAc26G8SYGAUirAFCo/hHO+yGkKLLHi4kP2YJ0eRO7Fwhjqmi6jCiOcx9Mt7z5+mPqB42jSE6TH+45YM4pzEZGVrNaja/XSKRs6WrdEK7+ViO2AEP9/APh/JI4TaJBenoWGjmIUAkxXowLQj4KeXdYO09oqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sMlhjmIhOiKbJfqaCBElJgoXGpyGAVhJ3+iQLTo+RY=;
 b=R4Hj8QT3Kji1L1nQN6s7UouPpcaxev58Pl2csAIITDKS4JkudhFjqq9rCJ6/g3lG3xd6gICpsbFVErpcjT/Lfa33h0rydTETWoTd22bEowAuIu3gJqXDmDUQnR3vhgRBuy/zRkie4A/+TlUk6cv1MjdQX4A1rbW48AaxQStId/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DBBPR04MB8044.eurprd04.prod.outlook.com (2603:10a6:10:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Thu, 1 Feb
 2024 15:28:48 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 15:28:48 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 3/7] bap: Create a new endpoint to be available for the next BIS configuration
Date: Thu,  1 Feb 2024 17:28:31 +0200
Message-Id: <20240201152835.196617-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201152835.196617-1-silviu.barbulescu@nxp.com>
References: <20240201152835.196617-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0202.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::9) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DBBPR04MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 0275f803-d5e2-467d-b000-08dc233a7cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vCDRbRZXZ/NxnPIdtFSRmsHP3621YdS5QgPLsj36DTMp4JfR9eWlXqXNCM/vThrxgH2FtTZsTpKBsmchbeRVHdgXgF0uqh7qE/mxlOhKiKQCt9FCZJvQl9eG9Zub0MN0mNAE3xgypniSFgQp9F6xY7rLwLcsKR8P/aeVHCpFT6LIL2RDqh0kU9/vo7Kx6KS4yisMGZ1pN6JAVRcgTga51kLwkIB9NEPPIgL0SenrPib2SoIStAW+rTEhvL5gHrqvDLYsL2IlRd+sZT30Z6hcrADDFx6WT7B3/yV9JnJ1BYvKcDc4ySHnihgkO3TvVF9XIIKUFqabGBgB06KIJxqyDafArvThL+z5u9dfVncQm281kdA0GkWR2LX4QOMKUcJ5xSmpJyLIygWGzowWjqt3twp+U9ArU7aVtlFwWPOfmNy6hOhqCz6Tcx1rsQQD9+G53p46/HgpnAFHVTLinpSa0mHtdTbvTtUZ1X/ATGIA9JbhU/XXoy/0IlYBsDgA/RUAb3/N9HezWKT8YQypw6z/eBqcvrR+/f9O8ivbSMF5TzIe/FqCnr7uM7OW2/+E3gvs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66556008)(66476007)(5660300002)(2906002)(316002)(86362001)(8936002)(4326008)(6916009)(8676002)(66946007)(478600001)(41300700001)(36756003)(38100700002)(6486002)(26005)(6666004)(6512007)(1076003)(83380400001)(6506007)(55236004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?urCADEkrXxXf1qruSbb+QkbKx6QiE2snnW3GF8vuKtlWayXZE7pvpeNyPZCC?=
 =?us-ascii?Q?oTQ71qtR1+JiA7YnU7mp300q60PIVUfAyFqUygcBTe1QD+6qsyab7vSeMi74?=
 =?us-ascii?Q?RngENQQlTbRdow5dFFgiNcvO+eT1YEhadopvLPQzQQPxc1dJwjobpO5qyAyS?=
 =?us-ascii?Q?SBBytOA1V00HRdsmKVnp4bZ4Sw122SCpTpVFTo4CFZue8O4WgplaoS5mEJ0V?=
 =?us-ascii?Q?SB+gXKbmbmEhyaPz4L9Ao5WCnEwRiKpZdmK+gEoz9tMgiNcXiG2TQdaMsFX0?=
 =?us-ascii?Q?nSyxrjydDDf4xWbsPKv8GaxO34AQf0j1DQzTtKYGd9h52mC8gEqisl6iyvhU?=
 =?us-ascii?Q?4KFRXSUpsOfyC+bwkYJCLDTPTFcZOEkP9CnM94Xlt9IBb3/WSzveusTyqCBm?=
 =?us-ascii?Q?wsvL8e3Ng/9TJUh1/YqXYsyX9id9+c2FldlOu/1C43xCsT5or92JbiU1vsts?=
 =?us-ascii?Q?y0AE5e7ftTCxJ+QR2JjLmO8fdVkb8e8ZS+hKheb1tLjDeeMUZSm27jKJUZao?=
 =?us-ascii?Q?071DM/0mOhDb5mKSo4Bhty3hk1YNAVrJKyQiijKflQ6QdVmhCU5zjGmaj2go?=
 =?us-ascii?Q?4tKJxsVeZoa5oVlhoAyBks7WNhFsZspNMWrppojthEUW/3YvJaccdYtQSGNX?=
 =?us-ascii?Q?7aBcR7nlFhMOy6vaTs3xLd0SamkdQbHsciXTR4uqaIKE55FW7o8UrIUoNe77?=
 =?us-ascii?Q?/xRSxAbiTm/yCRoEi6pv5ZIgdRS6D51mO2N3uKr35oS0JE7rF/ocJXcyX8pf?=
 =?us-ascii?Q?duSwP67NFF+jgXHSl9A83VRFX5iVsgWZ5qLwK1HqL8Z1FP3b9njg3Fi3lTCF?=
 =?us-ascii?Q?fNWw1qsIKnHIPW7w3lc85WFagbqQepwdreXWFKVo75ynOkF4I4f0lgbI9cAe?=
 =?us-ascii?Q?gxRqNt3SjO33bHK85Qvy573zpszH9Ann2j3x0h16jzF57UJ5tWrQYrueZhvg?=
 =?us-ascii?Q?bOY7XFxqQPWe+qOmbL/+t4+VlrLcKh2w9y4W5xd+HHWMVzR2OXMrbqkSgYWy?=
 =?us-ascii?Q?s4NQiLDPUc6rMwZO4N+HG86B5F43IKc8s9fRbM9e41CJsR3D1ffv+ZD+hxgu?=
 =?us-ascii?Q?XeNFDuUSShusBUjhbhMQGnSefEjU5J6ri/yzVBXTBq47jYQclqhy5geKQCVF?=
 =?us-ascii?Q?PFEwvTK9RJm2UY64zOOnnpnsaYoHeA2fN9uqR8xDwWYyb2t0tmbk0/VZl7Iz?=
 =?us-ascii?Q?KGM2Qae6eAmzby3D3RBFAGNxRZTgq9kI1souX3TaW9KKUyXjaqx1zjZNJfPk?=
 =?us-ascii?Q?gjL4VaSYfAlFS1BvK3ZAo9Kt1AEFuh0gMOYBKjuKn/zSV2dHmpKo8pOeydW+?=
 =?us-ascii?Q?Tk5ZEZik96yi4Dm2xtPKmTg37gk491K41J34yuDjEvoN8lpWzYIKQVTeh0Cl?=
 =?us-ascii?Q?dgsytyMIl1FcGD5hVuBbleE6xzZWs/sllkfXsDXGvzTVAPppucU1NpokqT1o?=
 =?us-ascii?Q?c4LKC43a/OmOHJGp5TVAzXswDxxgxF6a5DulDWEnkLbEzyqsefA/JNQO1gdD?=
 =?us-ascii?Q?peL/C9o3v3rdFMby5bSrYgHTCMUEkf6gwTBp7eeSC4vtTHWukvAFRjSIKMbY?=
 =?us-ascii?Q?Kt/pNVOa3n8vZHzfcC3mRLOYqlJJuBN1HOrR3rjXJeAfrc1klGQGEo0/RJqo?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0275f803-d5e2-467d-b000-08dc233a7cb1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:28:48.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scYM+iSqksZbExCc7VURiJjw1JSIawv7JVnkr1LQsUHdQY9crgXrKfVhNE/5wxtrGXkrUPhIqNyD7ReTjeiCRAFtYtXR1ImqB1Tj6D8jVbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8044

Add support to create a new endpoint to be available for the next
BIS configuration.
Broadcast source requires the creation of multiple endpoints, one
for each BIS for the multiple BISes scenario.

---
 profiles/audio/bap.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 209f21471..9300e98ec 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -916,6 +916,10 @@ static void setup_free(void *data)
 	free(setup);
 }
 
+static struct bap_ep *ep_register_bcast(struct bap_data *data,
+					struct bt_bap_pac *lpac,
+					struct bt_bap_pac *rpac);
+
 static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -972,6 +976,10 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		else {
 			setup->base = bt_bap_stream_get_base(setup->stream);
 			setup->id = 0;
+			/* Create a new endpoint for a new BIS */
+			if (!ep_register_bcast(ep->data, ep->lpac, ep->rpac))
+				error("Unable to register endpoint for pac %p",
+						ep->lpac);
 		}
 
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
@@ -1150,9 +1158,14 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 		return NULL;
 	}
 
-	ep = queue_find(queue, match_ep, &match);
-	if (ep)
-		return ep;
+	/* Broadcast source creates multiple endpoints (multiple BISes)
+	 * for one pac so queue_find will return always true.
+	 */
+	if (bt_bap_pac_get_type(lpac) == BT_BAP_BCAST_SINK) {
+		ep = queue_find(queue, match_ep, &match);
+		if (ep)
+			return ep;
+	}
 
 	ep = new0(struct bap_ep, 1);
 	ep->data = data;
-- 
2.39.2

