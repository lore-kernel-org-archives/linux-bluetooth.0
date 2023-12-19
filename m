Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D99749F
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="foe6Z14Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMGfNU2I7wJon4Isr+6ZPQA9wB31DQof9UEGVTaf87XQ3YD+BQLATeO5F6ZlYX7cqWsyZmibzgcNOmyQjXi/uewznErYtRjT6FuKfWyQShs3pcFVFWiO0+h9EGWO9ktU1fujyqQj1J0jRYD79DyiKbZWJ96Mm6t90l02mnXLgPGI73WZ4ZzZsDwgq2JsR2cU5BWswgw3FFgpCedVzcwZ+Ef26RHmCMg0z5ZQ/7LMaVwHuQn8kjQMdO3cTU1lcIOmpB9uk3+UkbTPzJlT7tRMkrIj2t/3gNG4SKQiqSV6NPQJN49vHWETGI3yNPALKYCPyhuS4JdrQ7gKtj5VHDEOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LPk682dn7o7vAfqVslsovqDXnKTW67s63vUPsEz68s=;
 b=X+baehQpKR6puPxA97yI79oN1DPEhKFIpMhs4xuluQtzXuSpxFDN9WDozjnxQzYBhdG7vpcLfI+VtW/fuwjExWu08nTdkG+oWsk5L86UEkSf4p5FaMoxRjA5ygiMOSODdOPdARdoQmxmWXN0QdQfyZBSuVS6q8ciCGKk5OJNDqJgp4slz+QCklIRNxBnSo35PuF859xovQ7762YNJI98Yvyrsrii2KlnmUbPRMt4J+OZXwC26eVpNbsH4NpwkAkrHNvv2PP4F6hzYeCmp/bUy8+rz5T276uZA7asNu1CbDVJmcAa9363xResHjBH83gRxP8XOcbVzFzOvJA3QEHFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LPk682dn7o7vAfqVslsovqDXnKTW67s63vUPsEz68s=;
 b=foe6Z14YOfDWAq73WFSbgS3KsHE1vckcLo9DJ4B43NUxgAgCiJnXVK+4QFgyIknUcFlxRgr/I0JitnTRhOpjAnkxmB16E3kjtNxVO8zp75pHOf+PE3XfSFn3EXjQSXssxqj5txX3HPqmuPGxZD2JVw7Usy02ApkVavzkmdXi5KY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7709.eurprd04.prod.outlook.com (2603:10a6:102:e3::11)
 by AS8PR04MB7717.eurprd04.prod.outlook.com (2603:10a6:20b:292::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 06:30:20 +0000
Received: from PA4PR04MB7709.eurprd04.prod.outlook.com
 ([fe80::9f65:a4bf:7753:21bb]) by PA4PR04MB7709.eurprd04.prod.outlook.com
 ([fe80::9f65:a4bf:7753:21bb%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 06:30:20 +0000
From: Vinit Mehta <vinit.mehta@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: vinit.mehta@nxp.com,
	devyani.godbole@nxp.com,
	nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v2 1/1] mgmt: Fix crash after pair command
Date: Tue, 19 Dec 2023 11:58:01 +0530
Message-ID: <20231219062801.307-2-vinit.mehta@nxp.com>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20231219062801.307-1-vinit.mehta@nxp.com>
References: <20231219062801.307-1-vinit.mehta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To PA4PR04MB7709.eurprd04.prod.outlook.com
 (2603:10a6:102:e3::11)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7709:EE_|AS8PR04MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e0f6ab-810f-49a2-61a2-08dc005bf90d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ab1vXs8w5Mm1+SsBb4I28vHojdf07O+vXdWK8D0KZIFalE02HG4eeRy4V6OffA+sIsRj/6s5CwROsN9sKu3XT/K9sqhz44K1bMR/vZeP/VIiGsD95JYhOayV5StyeepuY6q8kvQ5uS+MFB0X8O3EPEsC6Ma8byCr08EJ/O7MmDCbNkww+sk4apIiATjgDTYli80IWo2K4L3M7yqaltmXJaZeF3hSLiYPsfgKSes5MYdn3XzR2I+Y1lUQXjVTtPOtb+PyHARCZU2atKVCJrkbp2DmE/qmby0/U0ad4gM1ADCy0wyG+E7u+AyPb3iwUWH2q1YWm2I7wikeei8bf1OPEmi7dlGPLbc48XiWDJSIhhSR3x1CQ4eT/01iBGkltdg99KIA0RfF++xM0/rKXsRMCw7mZirXvGzVyVJCFuH/6xXCZGyLMx3IqlPSvRViCErZXbC+3VNExwRnsR29c6/9Ku31CGm7amoiaTkyM2ORHelLvRRSSya9y3YiERgQnIPscy//n4YkRIo1R45KRA4ba22hYaskvFORZMAuBT2szOrhjw/b86sa4AgDfdgRraYYFhq3l4i9z6YfwtznvNJozbQ/DHWzSF6sBFM26dtE4sQ+AQab1Is1ctrIr6QdpoFI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7709.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(8936002)(8676002)(4326008)(6512007)(6666004)(6506007)(52116002)(2616005)(26005)(66946007)(66556008)(66476007)(478600001)(6486002)(36756003)(38100700002)(83380400001)(1076003)(86362001)(6916009)(38350700005)(316002)(2906002)(5660300002)(41300700001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kYQouUavioLZVU6u/Nc/0BeS0PcvVh85KjFGVGBrwULESBmSOyRD1ClComvB?=
 =?us-ascii?Q?jnn3SkEvCOLTgEiyox1dbIpKQzYDL33p3El/+5U8v/XmIYxosryif/cfsCvT?=
 =?us-ascii?Q?gPyzGpvd3VI9dZxQSWEkA/ZYq3HNnBmP3XxxcetRVA5nsU1sqFnVEI6ulDOO?=
 =?us-ascii?Q?zfkCPc/sCsGo6MZnNz93P46DpiHnykYVMapyQJq+up0uKMTNNaETB1OJgx5p?=
 =?us-ascii?Q?7PO8oWK2yXJAdzQSXBlcvh9YBwR0NASW1tPHjr0ZKDr2Y80qsQTEQqk1Hd6x?=
 =?us-ascii?Q?YJ09IvipnewdltFfeA5Axp8hwP+FAjjPp7DVFBAKWUsx/NR5NNBGKy75GuIT?=
 =?us-ascii?Q?SyrErZe1fiVbzM50hEtxEY7VGcehuE8vh7u9x8zXCmm5Nh3OYggbJSnk7aWJ?=
 =?us-ascii?Q?hhhj5AP072bnUZWGiLlb+j7/B/ZT6HOHo6kWPn5VMIP1vuygybrDOGEUBijV?=
 =?us-ascii?Q?G+nyujvwm333KqD7CUO2liNN/jraUOF1bOMje0ZkQPJOA5vvh+qXPTD61oPb?=
 =?us-ascii?Q?AsKXKFF8iNUIIK0mvj0YFY37Dsa5vUtCs0CeT5NAOwOdqYkF2nVvhqj/T8dA?=
 =?us-ascii?Q?nUeiUtvlIK0yomwseHqC0vmZQQxFC2hMsg7kWcHIhb50DWly8iqScISrO2JS?=
 =?us-ascii?Q?ewV7I7f6zVn28qpIl2suEB8SAPkJOfUm3FpHdnWVRoFbEv+kbQRLa3ZSmQv+?=
 =?us-ascii?Q?/qiwjUejDzW+5zjdyXgsRriL+LZaDe1SbQBIvw2BAneAHG4PKTjnN5SwSTIu?=
 =?us-ascii?Q?zJIgOGqu86B7SJm/3LUHZ/gqt6niuOZLCIMVi4l0H+ZfkAo4/g8HcZ1ln65N?=
 =?us-ascii?Q?WPklQIoWjp/FWVzu1UPws+Y4GDsJweZJyH4abECWUZk8utPCpqeqs8o4mDjF?=
 =?us-ascii?Q?0o5oYFA7aNd2aN0fk4A0anXjBHq9B/5Y4nK8H1Kaup3JP/XX9qLFDBjyqUj/?=
 =?us-ascii?Q?iASEZuD0YmZJxRILW0wBO3tazOJtBSQFBMAldn/0IBSdd50V3Na+nIQSycqh?=
 =?us-ascii?Q?qjS6Tf9DUecsIBmb0NOgbPVDoAy6wlopzkIu5arloZxh1TA1sPi+bU9EmRay?=
 =?us-ascii?Q?igPX97WDAI50MqZI/lF/+MKrs1rXp+wwlH4bZn+2HXoam2y/+Nb8DC2Bmo6j?=
 =?us-ascii?Q?4TnKmBZqRAMEOM/cla8fQTljxhaySmadOMvak6G0w1eJ23t/Z/92A4Emxsk4?=
 =?us-ascii?Q?tYYWqz/tsq6gSAFboaNrg9x2/qJExYQQP5PYGS7AGf7/KZPxGTvtrFAtKQLd?=
 =?us-ascii?Q?ZfkDaXOTKRqZBzjKptdL+JC8nlE1EKa6dz2lsDNp2AxrbdfVD+i5XAAkbu8r?=
 =?us-ascii?Q?XTuQB+nrTZwmW1up6/iYVh6FIxGDGWDWPlFxyTRtK0pCOg/xaAjX+28LP6Z1?=
 =?us-ascii?Q?FNHHubFQKUMBL8EufB7M0noPsZ6lCpMouJO72Ey28m0IXAbE8xqaqGvaWhwe?=
 =?us-ascii?Q?RJ6Vo89TuD+8mCyfNJLz5D6k8e6rcrdxnlu+AeSFrKfipcD+3EcB3C1ZB5sB?=
 =?us-ascii?Q?wvmY6JuodHRTNMIBgKFtyBW6CoAHTnLVY9Z53LyJhsKgdLqoaSTaXm+u7dPu?=
 =?us-ascii?Q?oXjOQdLF9rONKMYTUsz+enQh148c2yDyUiXorAnw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e0f6ab-810f-49a2-61a2-08dc005bf90d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7709.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 06:30:20.2756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbz2BVesJ76WvdE5yRvBjJ/Qhf31SRbDDEeJRld18MIxYDy94MWKedzLdN6VeJjkGes9tcoQfOCbaUKGlgPwFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7717

After pair command, if the user doesn't provide any input on bluetoothctl
CLI interface after receiving the prompt(yes/no) below crash is observed:

dbus[782]: arguments to dbus_message_get_no_reply() were incorrect,
assertion "message != NULL" failed in file
/usr/src/debug/dbus/1.14.10-r0/dbus/dbus-message.c line 3250.
This is normally a bug in some application using the D-Bus library.
/usr/lib/libc.so.6(+0x27534) [0xffffa1b67534]
/usr/lib/libc.so.6(__libc_start_main+0x9c) [0xffffa1b6760c]
bluetoothctl(+0x188f0) [0xaaaac9c088f0]
Aborted (core dumped)
---
 client/agent.c | 15 +++++++++------
 client/mgmt.c  | 12 +++++++++---
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index 35b404114..ff5e57ff2 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -77,14 +77,17 @@ static void confirm_response(const char *input, void *user_data)
 {
 	DBusConnection *conn = user_data;
 
-	if (!strcmp(input, "yes"))
-		g_dbus_send_reply(conn, pending_message, DBUS_TYPE_INVALID);
-	else if (!strcmp(input, "no"))
-		g_dbus_send_error(conn, pending_message,
+	if (pending_message != NULL) {
+		if (!strcmp(input, "yes"))
+			g_dbus_send_reply(conn, pending_message,
+					DBUS_TYPE_INVALID);
+		else if (!strcmp(input, "no"))
+			g_dbus_send_error(conn, pending_message,
 					"org.bluez.Error.Rejected", NULL);
-	else
-		g_dbus_send_error(conn, pending_message,
+		else
+			g_dbus_send_error(conn, pending_message,
 					"org.bluez.Error.Canceled", NULL);
+	}
 }
 
 static void agent_release(DBusConnection *conn)
diff --git a/client/mgmt.c b/client/mgmt.c
index c056d018a..2cc40a7e3 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -849,10 +849,16 @@ static void prompt_input(const char *input, void *user_data)
 								&prompt.addr);
 		break;
 	case MGMT_EV_USER_CONFIRM_REQUEST:
-		if (input[0] == 'y' || input[0] == 'Y')
-			mgmt_confirm_reply(prompt.index, &prompt.addr);
-		else
+		if (len) {
+			if (input[0] == 'y' || input[0] == 'Y')
+				mgmt_confirm_reply(prompt.index, &prompt.addr);
+			else
+				mgmt_confirm_neg_reply(prompt.index,
+						&prompt.addr);
+		} else {
 			mgmt_confirm_neg_reply(prompt.index, &prompt.addr);
+			bt_shell_set_prompt(PROMPT_ON);
+		}
 		break;
 	}
 }
-- 
2.42.0.windows.2

