Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E07EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 07:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjGEHdA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 03:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjGEHc6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 03:32:58 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2051.outbound.protection.outlook.com [40.107.249.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C065C10C9
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 00:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eov+lEYSC26GA+i1XDvN4mSMro3HaD0VUmwPGmAdomt7ObmOjm0pCfd9m0ErAQENOvwzQMQIvTHxtByRBVq+A8yCS3t2MAfFe1RpAA1JfoqM9Rp4+R6Ajeg22CwLt/OYAbeZgnNI8ld3EgtwudhBi74btUY6JbWcA7k1eWfz1dSbO70jWLXyroV3WCcaO4ggJg4CCE7oEPCjn/voGzl05VKTDf6ikTkP0l7p6RXtDgLbICE7OP5Vv4lRifuiFthOhLyTLXXg3C/H3fSsAqp7SOKPIB5erTIrizKpGKIxxNCmD9rCDBW1izRKRVVSKPjCvtxfv4tIxBk+bedoTtDLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iSDMg2pN5B99fSjj6rerZyOKYts+l/MDOxij0bQod0=;
 b=ELLqUCwl53lLjIfivTAS4qUr+wy+NIq9lOBooBifgHyXAjjTm1b+W3is80y639rqYNM00i6HPZKjxOTchrfHtI890IiLgmlEpDQa42xvE9v/l7APS4k9j12Rk1ytSHQqFZH8IExH4KTmzGISHwJRMnRzmFABLOuzeO69wDZ9ninmxibABwrtKHm90b2KH/bmOl63xHltJJckNMivsNxmQwru1JQJD/Q8aKc9DUYsbWUYzfjYlRm/XlAobQGVEz6xIikbVIw4PEGmaMwpBfbhV9nHqOjVqnWIHFu9/rTFPoTKyk12EEefHgwuToiMvcRIi6KyPsyYe/aqyFIX/S+fxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iSDMg2pN5B99fSjj6rerZyOKYts+l/MDOxij0bQod0=;
 b=lhPcWT9Z/qnZrgo/fkliyl6QUo+kxFIrk60Zz9laUhwbwtnnsMz5j8GvoYJQeimGopuyC5L/4MFn/yJ+yZRO9OaHrlgQtXtdx2wozQN8eCUayotStLqQbHBj7eYx/Ofp9Oqq0rKu3kMpTWDVXRGRgA1Bof6WCghdBvIfzzx3QFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AS8PR04MB8546.eurprd04.prod.outlook.com (2603:10a6:20b:421::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 07:32:49 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:32:49 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ 1/1] adapter: Allow broadcaster to be passed up to application
Date:   Wed,  5 Jul 2023 10:32:19 +0300
Message-Id: <20230705073219.5357-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705073219.5357-1-claudia.rosu@nxp.com>
References: <20230705073219.5357-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0013.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::15) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AS8PR04MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fe2445-266c-45f0-f727-08db7d2a08e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9VAFxD51I2yNCjVxboTdMYKGGGShnv3gASTFQ4fttCI5buImIl/fne/1DUmfF7Ien51tiRTuFkHLKmlY13NM+WihTqams3+K0FlUof/FFvrV+q6ri1ToZiDNa3qMagRSfHQ2TQEXUU0LFkSSe8hZDDbWWIh/CrnYc3kdiNzW3nmb3XSypn5BK3NCHy0q/xwbkwoQYDcvynT3XuGZHUmHT1oV8GtxrK4mx7CNANx6BXnOJ5Q0Ek33eiMXRBSZTIRo+lyQtB8R8pzmkNgOoNGUhe+DhD9IVPoaYGEZUl+Grdh1ldfEA0QEbSF44i73tnbp0k9mUkAlVoii4UCqRy9y6PTXIvoNjtL0gUiKP4wK4nXhYsJseHiXy4MNllMUAmNS/moOIZhFeRaCmo452aNeFoAB++/Jp3+KreBALjRTRLDod51jQVl9GOUr1CxFnPAlVt5tnYFpuS4eTS1Hr0Q6/hqqC3zFLF1PAC6XNnJqZMiNr9gn7vO/8vZE8lEIu/gbaHS6gtytjDFat4p4cJD/x/IFFYTQLzS/xS7dCpnFd3uT+4kT5bNpY+DntOsQN3uXNiCC7aqI0OSEmkrj6pUT0AKv/vmnNJlghpfsCem0BCt4LUT5ObCvEcXgpil2/ZzP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199021)(6506007)(55236004)(1076003)(6512007)(66556008)(316002)(38350700002)(66946007)(66476007)(4326008)(38100700002)(6916009)(2616005)(26005)(478600001)(186003)(2906002)(8936002)(52116002)(36756003)(5660300002)(8676002)(86362001)(6486002)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RTWfpdnbf32q6uPmbErplC/7sVqXhaGxkQg95zoxqnmUqVeeiiMA9teIcN6E?=
 =?us-ascii?Q?n/P6qQeSALcMDjW94xLbdd5muiAuACBPM+V21q+PREsyRqYz1eZ5tRKPyNaS?=
 =?us-ascii?Q?8TL5hTIPDyPz+iCJGamtoZB0bAbbZDO9+5A+8IOiJ32ZsmJ1+aOOXf1+Ru9D?=
 =?us-ascii?Q?HHACLVNNjR5rwDn6b4mzORJ+4EVG1IqJXRItezTHYUGWuC4H7dtrq0hpE+Uz?=
 =?us-ascii?Q?dNGuwJHTRKkaTNvvV9kNb7d2ZbsPqmOKma+gkirmNWB0zvMFMrjmR2z1Clwj?=
 =?us-ascii?Q?dARe8QCWL4WxRlfXFHRepqtqYS1G9PPvdp4mknuy0qo5TOMBUqgh0TmTj6CC?=
 =?us-ascii?Q?hes2RZMyNTx/4XDOtwdJCesJ2f3HKQumTt1lV7bNL6/MPG/KgbUTsUKdqrBb?=
 =?us-ascii?Q?zoJBv9BKNnbg/R1nX5kCDSHmiczrUfK8+STcB7Y4w5EVBcG9An8LLMjs8RhT?=
 =?us-ascii?Q?/i6twau1guaM7R3Hm9G0tZ7uPGN4zCHPLh5eW6DZzO/p2QXKSRanxVWK+haa?=
 =?us-ascii?Q?+pkj51IVYfr+lNR0oNrU4hmbh+kAMcVWFnbdq4QGwsBLoXSsY3kZhp9IAk0t?=
 =?us-ascii?Q?8iGDUsg03wo1UYInt8lGejNKh/ORSQubo7MSF4/VBARKohS1AQL8fIAaHmmQ?=
 =?us-ascii?Q?aNxDOytON0J1O07T8A+xpivuCJfM/i/emOiWll3hjpmgJLFzflogEJlsjUBz?=
 =?us-ascii?Q?ZU+k0veu1vx5xP9P4vydL1HQ+Y8DAVL4Wm75mJx3pSBNjDaIanKS1woOhvp9?=
 =?us-ascii?Q?ww7E0QiZ9G9+KYd2wQlcwxHhqEiA/tXYvdpqoZ2wQ+69Mt+T+fi1eelzE/Nr?=
 =?us-ascii?Q?O4ZiWG9wuaflQ6MSHCwnIJ+2DZA0ioIIASsmsAl1Ztxg5LmPymk4SQKMD/Zk?=
 =?us-ascii?Q?19a7fWTycSOaRTOfb2rzb3FfVXRc4UmiMcj2ChQ/xUddJWwQF0NuAkcbmpmv?=
 =?us-ascii?Q?JO3O5zi9iRBE28bhnFaI5NmP1r7h24WT3oMB8VOjfj7BxHCGgb7Ooe8nnrg+?=
 =?us-ascii?Q?94BU2zZOu3Vxsgv/+opIO7smtHedVbkEVPi91dudSpvsKiQEzbJ94Tjy0OD/?=
 =?us-ascii?Q?/+WGKpTWfmgkE4dX7vcqmgn9zZEUASZXEl4BSiukreVayqUDczfVIqIVugmE?=
 =?us-ascii?Q?ahoPzzUzYk6N2Ht+7cVhI9SyjFXs4F0rfVYJJozo5OwDSsc33mzTMgqbb0/0?=
 =?us-ascii?Q?TAL33agXUqfeciDP0eEEpItagIKxnu/tMi1Pwjjkkaz5jxA3hJtAvZnTHiF2?=
 =?us-ascii?Q?Lk0sqn2YwGEkOaJAI1EDBdBb8mQbSiqLjHMReDfrdoqQxxeJzXvFu0VfSowX?=
 =?us-ascii?Q?R3T0+zm1ELl5w8TYSYGOLhVd4fyILG9zTc37dxAmQ3eeaJ/gpRIz2DYhIwGC?=
 =?us-ascii?Q?lpx3SLRFGQwA0ObaPJxPzawbyEwxjo7ot9LhnoTj3GtALovFBqJ2K+hV6Co8?=
 =?us-ascii?Q?YjQLHew/X96IlY+UQ8IjTGPy5d5HC96bCNWSDRCX8VnvJFYtemjIbINGi7M8?=
 =?us-ascii?Q?XmEmQonhmiPGOu5deKwtNCldDyngjeCVZkNkCrzji1Rjb3LJLJNxtG965qw6?=
 =?us-ascii?Q?5LDfTYGM5VbHJmfrmMR7FHcvrd1XqkBC8V61n3za?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fe2445-266c-45f0-f727-08db7d2a08e6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 07:32:49.6126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wrDl8in/kpR7014lTHgssPXM+9IwZ72F+b25L7hAkSYvObu7BDlyHNRykMeSgxSS4xJd/1VLeQyDc0s9FCquQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8546
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Allow a broadcast advertiser to be passed up to application,
if the scanner is an ISO Sync Receiver capable device.
This allows for a broadcast sink to discover broadcast sources.

---
 src/adapter.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 2679d4302..dbc469651 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7031,6 +7031,16 @@ static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
 	return got_match;
 }
 
+static bool accept_bcast_adv(struct btd_adapter *adapter,
+								struct eir_data *eir_data)
+{
+	if ((btd_adapter_has_settings(adapter, MGMT_SETTING_ISO_SYNC_RECEIVER))
+		&& !(eir_data->flags & (EIR_LIM_DISC | EIR_GEN_DISC)))
+		return true;
+
+	return false;
+}
+
 static void filter_duplicate_data(void *data, void *user_data)
 {
 	struct discovery_client *client = data;
@@ -7154,12 +7164,18 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 			return;
 		}
 
+		if (accept_bcast_adv(adapter, &eir_data))
+			monitoring = true;
+
 		if (!discoverable && !monitoring && !eir_data.rsi) {
 			eir_data_free(&eir_data);
 			return;
 		}
 
 		dev = adapter_create_device(adapter, bdaddr, bdaddr_type);
+
+		if (accept_bcast_adv(adapter, &eir_data))
+			btd_device_set_temporary(dev, false);
 	}
 
 	if (!dev) {
-- 
2.34.1

