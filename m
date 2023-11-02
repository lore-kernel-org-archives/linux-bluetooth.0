Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEA5C4167B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Nov 2023 15:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347662AbjKBP67 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Nov 2023 11:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377113AbjKBP65 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Nov 2023 11:58:57 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A823194
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Nov 2023 08:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXMhgWVr0jXGkZAUS544UNpFzUWwVv1eyeQH0QyrtaUxBYRBymS5S6EhAYj/PDWJ/Fkp2fSWbJUWtZGr6t6GJ/n1/jBc/iZ6tr91jaef9L51YcOdeavNxMon1GdwMn2IfhMz0JGa6iVST07ugFYVwB9OtNw/OEDToaehqh/X3TMSoqEDNgbiKJk0uxFJmBZyUK/4e/Z0rDaTwgfJQSP/+dNiUAgmVERTzma6YGSOTzpPejmEZplQ3HmlshPmFTSMR7lnc6LHLYQWYyNuWXHrUoLuNAhnyqoNTLGvgwNwAe00IEnO9cNmvSyfConaP9QYb/F8/yaZx5HSFIXYTwOlPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4P7N6R0YZ7jVM++ZH6BIFAcsphVZ+UzRMM1Nptk+J8=;
 b=TPZBoDFQwJ8ObU8/3kJiwSArce0g5eDiBqqoAjPUSfI6+dGTmS4NBmz5D5xgz6mdVGPP2HI390FPENfoFH0iqGeF4BQ9sU/HNZApD/0kfLXNqKpdbkPFUYxr0N2oBHAXNWWK9sg8nvsoBRt3zCDGQzt+iiStV6KhuccmlyW7c/4LKEuNIOMTz9dCJ2bCIiHCPmXZTRVHKi4gcEGOCA7yPViz6Bul0RTJAdQ/jZLs5FsLb5dxYnb88iMpO/FtX5caldjYw65Q3sLrEIyQ04+8HyKJer5/FfVWm5fUkG5DhZTosOKs7gJi8zFvb+wTqyEX2r/kZYbivveTWCBdIpzOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4P7N6R0YZ7jVM++ZH6BIFAcsphVZ+UzRMM1Nptk+J8=;
 b=iRHyMRQNNrPp/OReJ0IT6Gm6Azr241aHDUBnjndU5HZ1GoCS3/xfTNeIaPhhtBddxPhdx0Wpi0SuToshAPvABNToySslOWih00ELX7mURwATsg3JwaCRDvNTFrneoxRyJ7edm5wBgNuXGSAdzuI6VGEvAe98edLaskPNyCignOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by PAXPR04MB9005.eurprd04.prod.outlook.com (2603:10a6:102:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Thu, 2 Nov
 2023 15:58:45 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 15:58:45 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH v3 5/5] client/player.c: Add support for multiple BISes
Date:   Thu,  2 Nov 2023 17:58:27 +0200
Message-Id: <20231102155827.4219-6-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231102155827.4219-1-silviu.barbulescu@nxp.com>
References: <20231102155827.4219-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0108.eurprd09.prod.outlook.com
 (2603:10a6:803:78::31) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|PAXPR04MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 64fec5dc-553e-46ca-ad4a-08dbdbbc9827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwXuvZj1vEu2NGKvEGimJ7GrvJrcre/6MAVMvyJEopc14fAcGQcjCg8rW8qmMdkfNARfmXCF08ZT4H7DOP/N4NtyXww+SODpOmDq/imf1k4yN51m6X14fQ0tkJTYeyhHtXSldgVIYJre32+H8EOGOE4mDyQnAB3QJfEtB0rNRTeTgMHn+fYywRcc6OQsFRNVnKhjLtamRki+D83Q/ukq/b3DLZqsInCwUBDRBPDKsCk5zG78PM5W57KU8x/TtH5GFOs7cn1wTx75a3nDumjazVHrPPIjHcyS+MpHPHSeJqG1pmbuDh+3RFTmVP7xT/1UI3+b3yN2WE6T+h553rdTi/U47YKB/ZPS2JtTA26S9U3+EySK187s+P186dfNfQa5V+t7Q8KN888zPmXLBl6//oh8fXklH+OL2HL2VGyaDdlw1FQOs3thuObedOIObl8aLJsKgnxeHPz0bkpACWRMXm1FkZ6xwLzyKXrzcutYwAfb0JOWOv5ktqv2D9mVNdiyg3jMGbcobVxz6Ly2DGEZT2D2ync0tdKZO5ggX2xurtgofbeu8S5FJapAyiekYRQv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(6512007)(1076003)(478600001)(6506007)(83380400001)(6666004)(8936002)(8676002)(66946007)(41300700001)(5660300002)(66556008)(6486002)(2616005)(66476007)(6916009)(316002)(4326008)(38100700002)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JaTr1fKJMFBUHuCuFadvuSJkgPhj8yUhw2TNgaxJH0pkeQx+MDZTRgnffHjo?=
 =?us-ascii?Q?LcYB7LZuLokLrVIyBLyO2htvgH103egutZB4ni9hdSD24+vMAWz+eFJkqeSo?=
 =?us-ascii?Q?U9M5VO7avfIKY6/OZMTvLyIVVh57EYI5yMDZmpYt7SQk+KyAs6+vaTyrDKgd?=
 =?us-ascii?Q?f/qLANu3vBZZhIgezNZOv2mB0brMZnsiOUA6G5+jghG+owCSwat1BC31X/yO?=
 =?us-ascii?Q?MelaSdRERDAmotSrxI3MzrZ9b2rJLef+o3YpHnh/uT3dc+52iTkrI0BCBo0c?=
 =?us-ascii?Q?cdSEZ0LPBQ2WuMQfZ+ppZrGuVk6StV5rRHaiGB6DBz4pbBGBvWKNdByJsqwV?=
 =?us-ascii?Q?mfx38IJc3Krhz+KsdKn+LCD5yIOU/TRHCrqmTWRSUPBmZ4QSTJB4poqwqT67?=
 =?us-ascii?Q?SLcNDkaJuO6fpMFsKE0rP0pu8jljKCrl+yr3cFeoWJI4ksRRIARVPD3u9D3S?=
 =?us-ascii?Q?xAblivGkwtxbvgJ+gSvX94ji+EILzizAs2Q6YfsfHyzJFW7j+lMS7orNe1/H?=
 =?us-ascii?Q?YNf4TWotOyQdSE8QicFlWx5PegzIN4p5bhj6nwgp+aFLM6tOeXhbUsUfYvB8?=
 =?us-ascii?Q?shHqjaTOskuGo7YAPi7pARyq202DyBqH6e8uYq69ksIq8g64U6GHBbgRP8fj?=
 =?us-ascii?Q?uUaADMIcJuD+vsG876feaPj4KnqZ+2XlJootMiyKArfJ/YX/3YaXVWDFHCNT?=
 =?us-ascii?Q?koPyovV7jhEP84lI9n6MipkUY/ECiyHdNSYOa5Y0ITMaCHNwSR5UJt9pONtA?=
 =?us-ascii?Q?iAegKCCbhwzjZb7qI+prBu4a662YeeWEjamqoySomnUJno3Y8sJR8abV/jy6?=
 =?us-ascii?Q?llcuLmjUQoK6E3Yr4/2MfTo7WiN/3iYS4Ltt9Qa4FKp4ThKN58SK75YA0Hj4?=
 =?us-ascii?Q?ClpULWuyfYeqIL9zSuX4NcJQCVTb9ragHV+QeNgWwfAQnmiBNoANIJUKWUIS?=
 =?us-ascii?Q?xSBbgKCXvQNhK4ifsqj7w/ZMRDmEA/orOmtWHPx7wDvLyXYRGhpY3n4sjpED?=
 =?us-ascii?Q?/YeNxpk/0XSiU//of/WlHVRMgtq0BpwFa0Xh/OEjlnuWxUXKNkzmNyBQtCu3?=
 =?us-ascii?Q?an9zn2ncyZTDOgprBP/vgeGWt37UhpU7stB8ufuT/s2fhZ0ioLzIdJ2x8FS2?=
 =?us-ascii?Q?GEihnlZ+DC2NFANp/mbPXAXBRDwvF0crn6W5K2w96DAvFNrj6Ecu2yO1ext8?=
 =?us-ascii?Q?isHvTT6qgdK7HQ1jvIG5vz4/emHnz7YZ3x2JXmK3lof+s3JR/2+wNGvkdB8C?=
 =?us-ascii?Q?F787WXaOpOxrRK9LvZd2gMZpQs1BEc6cCt7jEfnKSUJ/Pja990EO/5p62FuL?=
 =?us-ascii?Q?WTfJR8lnSgjx4tVhR96vIWT3vxNtNfvU23TGHTU6HEIxTCKZQ/6x7I5cMDnr?=
 =?us-ascii?Q?WZlELdsYSRwZqhG4+cMY1YggIUbkm1sm8CK5IRZG97bfz59EMlHXTX/4o9io?=
 =?us-ascii?Q?ztSQHX8AMaSa/6QaeAt5epzNfIxKhKMJqyhP+yGpBFG52+PN2tHjwE3c/PG8?=
 =?us-ascii?Q?FXamymYRroyWL5cgxSEz9geZ6TTBrsbExnyxKCURnLFgiYHcS5WYsRqhSiao?=
 =?us-ascii?Q?0fF9KxGIucmHJlayUxix5g9MOr/EakL38L57n7sAdJIzfWWqFdgDXZs6KTnI?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fec5dc-553e-46ca-ad4a-08dbdbbc9827
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 15:58:45.7163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xitzCBcnWSVvRLvpNyhdHDRls/pawAlrICg3FlYOi+aTKqY8Xstvd6t1OsxVgbi5jtAPmk81rnzOoVyKTkr7u4PFzCFPKPz0fMTPuZaBprs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9005
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for bcast multiple BISes

---
 client/player.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index 715598aa9..e060e6a5f 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2999,7 +2999,45 @@ static void endpoint_config(const char *input, void *user_data)
 	endpoint_set_config(cfg);
 }
 
+static void config_endpoint_iso_stream(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+	char *endptr = NULL;
+	int value;
+
+	value = strtol(input, &endptr, 0);
+
+	if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bcast_qos.bcast.bis = value;
+
+	endpoint_set_config(cfg);
+}
+
+static void config_endpoint_iso_group(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+	char *endptr = NULL;
+	int value;
+
+	value = strtol(input, &endptr, 0);
+
+	if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bcast_qos.bcast.big = value;
+
+	bt_shell_prompt_input(cfg->ep->path, "BIS (value):",
+			config_endpoint_iso_stream, cfg);
+}
+
 static struct endpoint *endpoint_new(const struct capabilities *cap);
+static void endpoint_init_defaults(struct endpoint *ep);
 
 static void cmd_config_endpoint(int argc, char *argv[])
 {
@@ -3033,6 +3071,7 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		if (cap) {
 			broadcast = true;
 			cfg->ep = endpoint_new(cap);
+			endpoint_init_defaults(cfg->ep);
 			cfg->ep->preset = find_presets_name(uuid, argv[3]);
 			if (!cfg->ep->preset)
 				bt_shell_printf("Preset not found\n");
@@ -3068,7 +3107,12 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		/* Set QoS parameters */
 		cfg->qos = &preset->qos;
 
-		endpoint_set_config(cfg);
+		if ((cfg->ep->broadcast) && (strcmp(cfg->ep->uuid,
+						BCAA_SERVICE_UUID) == 0))
+			bt_shell_prompt_input(cfg->ep->path, "BIG (value):",
+					config_endpoint_iso_group, cfg);
+		else
+			endpoint_set_config(cfg);
 		return;
 	}
 
-- 
2.39.2

