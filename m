Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEE8EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jul 2023 07:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjGDHmL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jul 2023 03:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjGDHmK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jul 2023 03:42:10 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA16E64
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jul 2023 00:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuE0RTkOyYkyCXQLLWFFLD3Kq/IjnEazp56gCW3dvAE+s9Ckvfv9YMbx2AqZ5Nc8NB0YY8J4XgyVVE7Sm4Yn9Or1gDYwg0lsHBRF9KyD6EkzwwR9vWEW/8FTmjbJxy3iG9ZI/9g0hlHN8vanVQ8g3OTpSH5kL9IGKuOnFZ1v43S6mFk6QlIrx3Z/BVHQJ1Ang2Y3gvpe/CK9ps7+pKgZPuUCXVuTxhASiD3TzRAk4dhOEKoW27Q8J5tU5RdeS2Vgz1HziGNKDQrgJllsSwMpxqswhKD/p+xBee0pk5f4bOD/YpgNkYbof5kzh1i5LBuPJPYEJLDuw44iegVA6uFaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOqIg0G/jQdaeOeQV+LMr9rkOM9SW41GmlShaGEkumQ=;
 b=MA52Buig1gM2yf4b/+msTMah6XW8hXOvp9G9xH/m1oBYey1Ibj5rD2zQZnalnWuwNuMxWTASQdp8RpDOjhHfM5ZkHsHqpaM9ZD61LektVxD4qaLno4KlBJv48eF6N7vZicCpTS321XTTzGsgmrQq8EckVXpliKzkDTr6BXgkXErYBasyzfyP9q7l96qpE+VJeWX5qgZurvSAXekLDE6TZmGFRdbiBmyVYXging4lrAun9unaeJZMdOAhu8s97wUvTekkRbr8VBQ/ittEu4DnVMb3fLAtKE711TMxuVUcDgIbH58yUJmlZLq+Sx5mC4vnD9aJrehQQVU8K/l1ymNJJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOqIg0G/jQdaeOeQV+LMr9rkOM9SW41GmlShaGEkumQ=;
 b=Qqdkui6RNLGsquvuP6T8FM9Pned8Pn0h+d/VGeblScJxfJE/k96PZ33YIPKZD7y8H2oUKwh5PT9NvVfmE+coN5T/C36GPGU3cfqFzX/gKfdMM9DxpkiXirL6l6SC6uwgrzL9ohEEbscGiHp7w6ieC4E7nZDJsu242ZSsvHpk6X4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by PAXPR04MB8222.eurprd04.prod.outlook.com (2603:10a6:102:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 07:42:03 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 07:42:03 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v2 1/1] monitor: Add decoding support for Sync Receiver events
Date:   Tue,  4 Jul 2023 10:41:44 +0300
Message-Id: <20230704074144.5587-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704074144.5587-1-claudia.rosu@nxp.com>
References: <20230704074144.5587-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0171.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f::20) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|PAXPR04MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f5a780-089e-4df8-0af9-08db7c6228ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZVpx/dm8ibKJ6lEWzbh1ONQhYSAMIIgnLguAoXItale9cn5HQffJV32QV8P2ywFMM4wkjg5ohDsh05J0G5KZfkHpk8rNRcR+Gtz/aHZs24gfU3m8TR0Vwm9Z25Qn8OdJBNh3cn2W+BHp9VoaJEtZQWZNq7Vm20F28GipYLQ+9rU9E5a68rPrV/SupnIJbO3iYCONSa37HxlbzL7QZOxpKp099Xdioooznaz5LOADm5HdAImVS0Ai4z6j2I9yEhpNgiKpk0K3gH3LIen3frJbFszQTqHdn3/0Tk/8aHxkb/j5O7EmqH47IQSRKgV4gLN2FmqEuYCAM2K87OQqCPtrabsICfnzvFmd35jKoPIYu/EnAm0GPOolmiIaLRYYT9QCk33J9xdhxUtxF1HsmEauZm2ZIX4xNSa7q+oJkwAGnQe+89Mc+F9Ce1A47gTgZSfu2FZrqsDsZKzuVJtPuwqP2Ch1EY5IVvoimykRQnUdvGn7NLaBIfsBnqOSc0zM9fWPMlu5lxsaZLSdfCe8zAqXrdG/m3co4VWN6RqK5Aw7dHHArvU+q1sYXrRJgaYO40CnvT6fGzE7OQ6bq8UPtCWjjzrQoZSoqVjZj+0OauesVmFpcq1tdjFcNeJqC1YfMAR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(52116002)(6666004)(38100700002)(38350700002)(83380400001)(6486002)(2616005)(186003)(36756003)(26005)(6506007)(6512007)(478600001)(2906002)(5660300002)(316002)(66556008)(6916009)(66946007)(66476007)(1076003)(41300700001)(4326008)(86362001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QCH7vWnuNb7XyiQoELE2EjZ4pRBVZz2Co6M0v+KZp6VXdj0Wk3ukGw9s7+J4?=
 =?us-ascii?Q?jFsCx2EEtZlS3sHu5jb+p2362aPJRGYWoDUNi1BqApwKZZ74NGnWvCGgY5RS?=
 =?us-ascii?Q?ZJb+eoZ72YpMg1nZcHa+Ln9TVhiPnaOWn4JxiyKFBJAs7rjxlGspFXK34dTp?=
 =?us-ascii?Q?FtooWdKMhiT1ONOGTnQLxAIIkZxryCRRlPWjhEHEtiUMCsEnDFc6v53yDd3W?=
 =?us-ascii?Q?ML338B2fhOv/frDBWU/lQCy2DGoE9+/QGdJm9dAY4JeKB+FiMok4sLYOWJ+D?=
 =?us-ascii?Q?Q+GASe92x69wbKP6VI20clUyXeI2sdjn69HlrsfCE0qWuVpRf302LfVUrqEG?=
 =?us-ascii?Q?y4EIrFppSt6LNd7NgSHhHBRjLszYgQW0iRT0Kll5GnjAKbkJWVZakmwl1+Ky?=
 =?us-ascii?Q?CTPsqkH4MvUGpFCm9PPRXq7Q0jhEMCXYpaFkKywQhJG8nZ3nn/HkBuuRB+iE?=
 =?us-ascii?Q?2F6sC1RGYWzs5ffukAhyo9D6gwQbNce9Dpw7DFMeKKBm3IwMi27LudPx9yGX?=
 =?us-ascii?Q?3k3eVkA0Rl4wtfh1tlrnE+zGjawJEZfD5GuXKoQO+Yuk53gjmr4RDaXiWQno?=
 =?us-ascii?Q?tT2FQS2E3aU+eeA0KhG7g0QuwG8133GekfPmzr3d+0k+j8voMfL0sxTTlbTp?=
 =?us-ascii?Q?milpLb2Nb9C2IOXo1dHgzBgsBDOEjlKojq5Hix1ZtLhp4a4LBPQUYOo9UyL3?=
 =?us-ascii?Q?uksQrIA2NCbhaLgoT9eSnOLgizfaQIT7GB3DyvdIxX7DVBTBJ/k0ijOPK54U?=
 =?us-ascii?Q?W6v4qxboze8jssMY3vLYTEbeUHqms8ysoK8kD1opotslMG35AolvKITeJFls?=
 =?us-ascii?Q?ya6IYUY0poXdFrBY6xumzjZrmfp7S2Y8Tg+bX6rt9dz+bxoj9mnG6OOWv1hA?=
 =?us-ascii?Q?+EgGifZq/7/p/MHSjDsyWp3VQNeurtHIRU0DrqADUvJv+TW/3Cf5OMVbm0vq?=
 =?us-ascii?Q?S8QbajgUgCnpP6X54S4IYtJWjMcKBOF2MCDOvqrv6HJK25XUewqB0TEC79NT?=
 =?us-ascii?Q?8C9NHRRNrGnM9ObvqACc4v+eoabmIaENqnRfVhojQ+E/FcJkNf/6xcIYYApr?=
 =?us-ascii?Q?1vgK9LB72SRFM4TyLv4Ymg8uGzUF94nNbSC4A1LIhulWoeAYSsOPtwcn4Upw?=
 =?us-ascii?Q?RkPRnuyDdljgR/i+acOcw6CT7tYQ9z6MdKnWDhyD+E++sgFKZKDOlcR89e7A?=
 =?us-ascii?Q?lsinpEN4h56qOYIJCFfO0tXYisDi7XT+zJTyeMYZT2mXPCFs5wHTGtoHsOV6?=
 =?us-ascii?Q?LK7h18kRJmSwY32K54SZO21B3vD+XWyLZoDWRFSdx+d6upUH/GgTEY8WBf1/?=
 =?us-ascii?Q?Q+ZaXqksLzg0GuhDAQS6obNpOEuvWfx7GSboqluzrzecAvz+HwKuA+ldzbpQ?=
 =?us-ascii?Q?qQK8GofarnWxZNx6R9wcO4KEiuJohCznAH7VFOetgwyz+VmX70ph8pjtr4N0?=
 =?us-ascii?Q?iWSrhkhB6QQ/LXRjshBdlELhfr29eRsOYwrWs1g795BHazRwbQ6zmTo0o5hM?=
 =?us-ascii?Q?6vu0Sr1fdXi7rY0V6pBTtAeijT1zT5KXhF+Vkc7NuEPEWv6ENcjZWIIThp2P?=
 =?us-ascii?Q?hCVd7z8l/0JrL51lw1nJNCGLzAm9IHN31kQHnVJ5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f5a780-089e-4df8-0af9-08db7c6228ce
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 07:42:03.8392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOfNvRRMBZ6CHpCdts0v1YPdXHJktJTTcfQGIS+lDHchGhGXHBD1l5ntdusVdSSBAJH3AU30SvIc5rTSLJDbhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8222
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit adds decoding support for PA Sync Established,
BIG Sync Established and BIG Sync Lost events.

---
 lib/mgmt.h       | 3 +++
 monitor/packet.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 062fa0271..8f92b7731 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -1238,6 +1238,9 @@ static const char *mgmt_ev[] = {
 	"Advertisement Monitor Device Lost",
 	"Mesh Packet Found",
 	"Mesh Packet Complete",
+	"PA Sync Established",
+	"BIG Sync Established",
+	"BIG Sync Lost",
 };
 
 static const char *mgmt_status[] = {
diff --git a/monitor/packet.c b/monitor/packet.c
index a871c7f27..f2167fb52 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3093,6 +3093,11 @@ static const struct bitfield_data events_le_table[] = {
 	{ 27, "LE Terminate BIG Complete"		},
 	{ 28, "LE BIG Sync Estabilished Complete"	},
 	{ 29, "LE BIG Sync Lost"			},
+	{ 30, "LE Request Peer SCA Complete"},
+	{ 31, "LE Path Loss Threshold"		},
+	{ 32, "LE Transmit Power Reporting"	},
+	{ 33, "LE BIG Info Advertising Report"	},
+	{ 34, "LE Subrate Change"			},
 	{ }
 };
 
-- 
2.34.1

