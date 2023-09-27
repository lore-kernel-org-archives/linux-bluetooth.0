Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C6EE810D2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 11:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjI0LiD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 07:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjI0LiC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 07:38:02 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2046.outbound.protection.outlook.com [40.107.249.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F230E19C
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 04:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2ZqnwxpK8bUXEI2yWZNgqPdPGg45Rj2z5crLVWtz5advj8Olp5QU5STia7NaW+IAfsRIjRgInNGh18elLpkDV3sV4gncO8lzmhxdK+QYcwetYdq8eM9QG6WcygQAenQh6pyGwCdb2NaBNNf9lk6sJ7KALSFxSLidYWTGKQedZuzSe1WwVIfLVimdsY9n+D0INptx74P/lqnqNnuYH5htLhZWAwCuLrayhxiYPRGpgdX0T6NIRS7ugwe/yy2qUUh4mJUa6xm3JrUu5UiujSiieTbTfEQEDR+JrxHPtaxvb56m8NXjWUQ1X9WLkRokKOQ4OyX/Ttq+GmR56Yykv3tYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edlstyItnaYpPOYhvnuuwBni0oQQvaqnVYI+RWLV9dM=;
 b=MxUdBA27DkgBXJ7EHji6/9PinyqTReZVkOokqu8JMrwwSvSQeAbdQtaPEIa+OmCQdk+hOS/2z5ukKldBuzxDONWjReehz3nRAswydZpEPkAgW8kFSVL1yPogDKW1v3w8fkYTMk7dms5Hs1BbEclE5HBwr/LWKXUP5hqNkKVXzDgit7ARvHQ06tYZ/VuI2oGDIxGPvbwrC+XXmbgtYsKCyjovLFWfH6qvbyVaEXVBatm0SKbBJRT01IGAZdVGFkGLEdVOCxCLUX3+79kTMMg3bNOSKL3tQoHCB9zC6VmpfCKGCIVdkQjNMw7eeKekjKUxJ1eokXvv+Nrn+wW3Q65FCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edlstyItnaYpPOYhvnuuwBni0oQQvaqnVYI+RWLV9dM=;
 b=pZfW7ShMX07Php6lQJ9kwZcsfDehxm9CpdgOGY12g9WUyzZIfcJq1hHOcDJNZREOK35X2EA8IPBjcFQHGkMsEovNgtmhvgcQZYLYYLatNwgdIWXCt+OKva5XbmZsLLdqIQ6Ea8UVV7LhNoc4G3vmTt3WlxhghWlCBunssT9jeNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7826.eurprd04.prod.outlook.com (2603:10a6:20b:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 11:37:58 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 11:37:58 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Fix invalid context error
Date:   Wed, 27 Sep 2023 14:37:39 +0300
Message-Id: <20230927113739.3332-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927113739.3332-1-iulia.tanasescu@nxp.com>
References: <20230927113739.3332-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0481.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: e5aaa54b-57bc-40c0-4d25-08dbbf4e3277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35WjvLKSQuoKg5Qu9SXiTglI2hwGJb7NDtg9zGDpN6wvAUKT31BRbMys22USkYEV/0GsLMwrOMILPSIKL6QAX/qqr9jaLIlWcI4VbAwzURjVG7INlpaRqT/h2BQkNUmWi7MYiKDusqgrUx8UAOvgcFw1Q/gU3WUjMp0iRrSeWzVJsS3ajQFtuf0IMMXNKvUmk7lV8dESLYqBMQ9kVGvDnUCfka9AWbGBAkjmPo2DBPQVq/NPIZwEmNttHGExFlmtYJ/VIIGDV/P97MsafLXvy8igW1QyDjD58Cse38usIB2sDcZk+edBw/IOO1JkwzGjMgY2pHR+f2J4icfwq3K/HW0qDc6PXb9WOlzKK9rEhRQOem+XDu3Sajx2hPLVgGY9hOw/IZkwiUJRut5vzusvVT7EqdEroNZZEBRch4T09JFrK1WATa2kTsXoUm3piZohqGv8+VW46wZHaP5rGrzkU+fcsO4gyEn/Ac9I9Fb+sMz0JqiZ6D8T5Nl3na14TXHCp0bbr7+QRiPUZENMUvH4iTDJnW1WhStQKmDG5vdYvEcnZE0I0xd5zfi8fOWW9wo4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(230922051799003)(451199024)(1800799009)(186009)(6486002)(6506007)(38100700002)(83380400001)(36756003)(2906002)(86362001)(26005)(6512007)(478600001)(66946007)(6666004)(1076003)(8676002)(2616005)(4326008)(8936002)(5660300002)(66476007)(66556008)(6916009)(44832011)(41300700001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bdX6koQVu7wAbJPZveqFr8/VCFXs74P1PWFu4cDXmmEK2lVpbghtH02HzOB0?=
 =?us-ascii?Q?O89/H1cvt6NE9ddst/bJSkxUS/P6WEwXaquJfvRsR9gekBbbMiFzJvpRNKkh?=
 =?us-ascii?Q?A95r8N5aeBjMV5wSZVSQUV91EeU3Z0VeEsK4GZfSdxreCqnVunuVG/LRTiJL?=
 =?us-ascii?Q?moZ7ZLqsq0tXWguAkf6I0waYS+y51fyOCuachZzTtc8uN9JRiEqJeuUdq6Ef?=
 =?us-ascii?Q?HV9Awb6c4Fcn/opkZLbR/1IEDbiHs9mP297pEiFh6aFZ4fL9b9UBp4gBh2uL?=
 =?us-ascii?Q?82KPzAcDv0WaQcM8s9bcahVYUXKKxElaQwBuZyo8BOdgxGY9QhPG6FbSSZWX?=
 =?us-ascii?Q?6PvWrh/nhHixo3hEksm5ITJKEnDUEPbk2WIU5ulyGakeobWTTbyc4Iouy63/?=
 =?us-ascii?Q?+zu7rHOsgwgzw+qINzbUniuR0jABcfoyHHtSGJATVhSCKh8rTKp9XIMR4OpV?=
 =?us-ascii?Q?jqOKd7IYfAJ8KVMzy7Vh9vJG+CEuS1YR+f0ix8tnYdsQ6fEHP0fIFbiHugE7?=
 =?us-ascii?Q?T0r/j+8bbrbS4xgY/p8eI0htzLGy9kP04TtaHfyZB97gENlClMeh+yUUHVuP?=
 =?us-ascii?Q?Pmxym83WId+64PsBVxsI31EMAoPM1b5DfAgHBtXTQvWylJ1OCo15OAdY5x30?=
 =?us-ascii?Q?mH/2Q2XcPJTTMVQZM9O8hBlnQEuqNoj+cUg7ixEQQjjhgm9jvb2YexMObuCs?=
 =?us-ascii?Q?svi/VKfDTVaIl9tXYKfyN2xRtKoPv1KHyY8yvocKFPdxhii9Kq4uCCNp29xG?=
 =?us-ascii?Q?fErifXdzafpgY0saIcOALr5F57U06jhlzmXgEKjLWp/XPJmQa58y7V+msJ2J?=
 =?us-ascii?Q?zwTtRDuk7IiW4v9SO9X5D6Rsv9Vfv7j+UKdgjav50Li7YoWJu2tyC0gS0M8a?=
 =?us-ascii?Q?iixvIWKkPXufjw06QMByPfrxHgK7pB1nA5ZVROt4FQ1FQ0DjketVX/++EszR?=
 =?us-ascii?Q?VA37kTCuuRHYuzWNtDLHu7VAtyfqt2JSHhqiPCn/eMhrMnoH4VEWW6rO8mRr?=
 =?us-ascii?Q?TVnW/hlQmhnsuBm0tsXIQlWRg7ADTlSrSj9txyfPu9btoojUDtsC3hq+WynT?=
 =?us-ascii?Q?DqFlsTlcxeUhjpulslX587m15TcTJeb/wRCXoNNGGSDKFV6FkXjICL5vCOx9?=
 =?us-ascii?Q?Iehchx3ujHHwCu+bJ8/yZKjQ69NZxun79saZDYvqn/X1nDJ6vASXgczkcvhB?=
 =?us-ascii?Q?ox165aKovEZ8Y4elDD3IwP+HO6cY7Rbnfj6bTxLnG4eb/K95of/ylLvKjfH5?=
 =?us-ascii?Q?0jlYJOSuLCGKltB01fcNrn4Rxw+HTdj+ZOm0GXZdW4/+vHog/qvHA7IsNQx1?=
 =?us-ascii?Q?5PaQPqumNuXO/0x9njMRos6YfS90Ty1/r36/gwtTFeFiNXBvRNxEQVLQMHQp?=
 =?us-ascii?Q?7nJ7iq0pV88oX1uOaQlQ2Ca7jIpmo5WiaUgqAuxnMztJcTwyX/JNLtuRD91z?=
 =?us-ascii?Q?pqT4g07kM8Z/XAhuHtPnyUxEVTYdosbeF8Yc1ALldC6QAIktp8Hc7gMru0B6?=
 =?us-ascii?Q?uR2PCuGIqcbAaKahVCiJQYDxZvJIoLV1eaLdh5ftCiORk1YXs5ZpvZfff6wl?=
 =?us-ascii?Q?WSlQEOZ4crnEsSZ1cJtuoYkIjURGygWoEPMEHmOrQqXXv71UQV3pFvHGS2j2?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5aaa54b-57bc-40c0-4d25-08dbbf4e3277
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 11:37:57.9515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AW9AU10Act0kt4E9pE3o7y6TclPcqTrK71MyXe0J+aaU/5kBhqBvlCY320lKYmx3DkEBHyX5/6CZWv7iFu2c1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7826
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This moves the hci_le_terminate_big_sync call from rx_work
to cmd_sync_work, to avoid calling sleeping function from
an invalid context.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/hci_event.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d242f956dea8..640921358e5f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7020,12 +7020,26 @@ static void hci_le_cis_req_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+static int hci_iso_term_big_sync(struct hci_dev *hdev, void *data)
+{
+	__u8 *handle = data;
+
+	return hci_le_terminate_big_sync(hdev, *handle,
+					 HCI_ERROR_LOCAL_HOST_TERM);
+}
+
+static void hci_iso_term_big_destroy(struct hci_dev *hdev, void *data, int err)
+{
+	kfree(data);
+}
+
 static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 					   struct sk_buff *skb)
 {
 	struct hci_evt_le_create_big_complete *ev = data;
 	struct hci_conn *conn;
 	__u8 i = 0;
+	__u8 *big_handle;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -7064,16 +7078,25 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		rcu_read_lock();
 	}
 
-	if (!ev->status && !i)
+	rcu_read_unlock();
+
+	if (!ev->status && !i) {
 		/* If no BISes have been connected for the BIG,
 		 * terminate. This is in case all bound connections
 		 * have been closed before the BIG creation
 		 * has completed.
 		 */
-		hci_le_terminate_big_sync(hdev, ev->handle,
-					  HCI_ERROR_LOCAL_HOST_TERM);
+		big_handle = kzalloc(sizeof(*big_handle), GFP_KERNEL);
+		if (!big_handle)
+			goto unlock;
 
-	rcu_read_unlock();
+		*big_handle = ev->handle;
+
+		hci_cmd_sync_queue(hdev, hci_iso_term_big_sync, big_handle,
+				   hci_iso_term_big_destroy);
+	}
+
+unlock:
 	hci_dev_unlock(hdev);
 }
 
-- 
2.39.2

