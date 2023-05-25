Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F03FC77B7E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 15:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241575AbjEYPfS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 May 2023 11:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241195AbjEYPfR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 May 2023 11:35:17 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2070.outbound.protection.outlook.com [40.107.14.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0738499
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 08:35:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYQX4YlxFaKP3eL9c03R7D0LCX5D27KrXY2v1KBRTMyNx6id4TdGRobXmDcNHfT9mLgBSb9IAf5miB6rWRLUYmlkzPkBL/C8IMbvcwOyPU1MNf9LyoreraFiZkX0etXeTfL2L7JGpBVOC2vbyHoNlZt854lZuOF6bd5dpSbc+TjgYhHhOZBPkZ4a4BzEeceehFFFu2JLaMluCeZdPRDXcjXsxgBLWXaqO+CaJVYiExlt/BnCv1V+RrKKfaZ2p1FErpvZrKMRQQgj/2xGamXlkV7fDPoVhqPGJps4s06BapnIw7NSjf1PfeECRA5B06BqRZH/3PG3sSEeAU0cUFXyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkZaV4L7uO6NcYDFxKpuSJE1t07Jl3x/OBFt6mQeLf8=;
 b=kflAZsshl9bz8/Nljjmd6N6uQdomiatLhsPEGAEsblBjrW4JLLSluM61CvitaksscEMKYT+DsnuQwSITMGZFqmWR8/xgrxYEZ8zax8cFzm5TXQwberLFIH54mRPzzygH+S5ZLX/iT2Fm0OlDCqh3a+nP2qzgaCad2ehIEl34QAHZcxyVFby9Mo8wgnoz10AQoobF6SDBZw9Hn4SG1NouETK7VhgqNEhl0zljhLRnICiH54do7MRbMoXP7ZV/AObNxM520E/ihie9DfRDwPKyNq9TYyURbhnL29qEXyykDfqHI2xlW15gBN8MwTDUZmRkrXNS0OZnM8z4fxzRZ/4Cmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkZaV4L7uO6NcYDFxKpuSJE1t07Jl3x/OBFt6mQeLf8=;
 b=rNL8pHa/4su2/e/+5pxPfsA0ejQO1JNg73Qrdzbmuo8hKwDj4NhTsy0a3lrCFBsTg2uE0YekCD1JrR92q8duKoUqm27qVT2iT4LPHcCb+WJ+kmXjt7JjHfvBcKvhyX12QyqDs3MnqFZyIAhVdsvhxI77C724/5gtWprZflWcoR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by AS8PR04MB7848.eurprd04.prod.outlook.com (2603:10a6:20b:288::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Thu, 25 May
 2023 15:35:13 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::981d:d04a:5851:1578]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::981d:d04a:5851:1578%4]) with mapi id 15.20.6411.029; Thu, 25 May 2023
 15:35:13 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH v2 1/6] Update Docs for BAP broadcast source
Date:   Thu, 25 May 2023 18:34:47 +0300
Message-Id: <20230525153452.125789-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525153452.125789-1-silviu.barbulescu@nxp.com>
References: <20230525153452.125789-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::15) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|AS8PR04MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: ec291cf5-70cc-4407-9606-08db5d35a193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kF/d7GGG7T+ETKkDG4q8rxe3ImbOstdOedoMY4JCTiGqKoRtK5x8ko99vFzmD8zrus/zmHtHg+1bL4KWv7kFdX/FMgALVjsbbolZz2hNAbWI22Ig77bR3n/7CsAwL2yJrUzNa3zSdMjKertuizjFjKvqfRKdCWor1wAXSrJTldBQVjSQ2Oi/JMgqQbABho5ARHXF7DcH6p8uVlqU6g7zVDn9eM8Tu6PdFRvxXz0VzLpE5sMSHrATyNthZiEUcXZBMdljPS/Yo/620XqnDVujbaLr7pJw4EyhWVEfudrfw8jIWeTNd4Ph+62+vEOuhQU/+xOP4Y8chKzrxNIyx8e6FgMUq7IsF+s3Ez6v7SkX2sd+JEa84tvET7hpLrSzHtpd8DhHMwauSbjPKz0f0hRBjS2dJQas8yXU5zlLNVJAHDPLVFTMO/BDFrb7+LmocjSMuw2jczcN/26ELfP77xrKWs9vTmzZyZaBwDZDEDbvSzz+WAEwCyzdbEVBd85Jga3pnOGqojKpgk7MnpjlFFF6Q0VRMFsTrJq29JMOl+6/gHzURB2HXMzhI6/R+rTnSq/UdVuhrBn4f0VX6pLHJOn3MQSidg1nn85oTNCsjfGt/G1ffh5F/rWSsSoLzfZ22YPA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199021)(5660300002)(36756003)(186003)(2906002)(2616005)(8936002)(6512007)(1076003)(6506007)(26005)(55236004)(478600001)(66946007)(66556008)(66476007)(6916009)(86362001)(4326008)(8676002)(38350700002)(38100700002)(41300700001)(83380400001)(316002)(52116002)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j1qcKUWldVGc1cQvJjoZ3Yiv7nmw5AAjhJSAuyr5Qq4XVrz1ILvnE4MNR+0B?=
 =?us-ascii?Q?VDOlEwJnnIdNLxva1IVut9Hluymn7PxDLjmTuGciFra519/DVO/nBlM5uQjk?=
 =?us-ascii?Q?LlydRwi1za0LYUJe3oXHzeOSDTtb6DMpEg2TucY9q9b9ISjaMWZqnTa1Mj9Z?=
 =?us-ascii?Q?Qq8haGQTrEVafGZOR+OHT70Sjymde/x50o/VXzNXpXPko3gDDfnPyhxhJTa+?=
 =?us-ascii?Q?ko4+YgzZEnnYQ725xYBtAKmSgBkVEfxjRBbNHYcB6nqpEDSHrUGVf6g6Cpfh?=
 =?us-ascii?Q?GlVBTulK17HVjPZRHoU5HBbBlbj8o6nN+w0QaEgSOvjj8cwwobVzBPAW3tkz?=
 =?us-ascii?Q?CPqYZMXxy7wbavZbzWr9aRyqvNUeGnWYF0WwxhMKjwO1HB9yJRaVLJ6gik5u?=
 =?us-ascii?Q?7qIWTnyinDUPh92BhFpEo0YWPbFTeRfNR4Zo7rXEjR/c/Wbx9TPg7tddI9cZ?=
 =?us-ascii?Q?4QjHD20AA8S6tHG97aiLCHSdLDDKEdMCoIMl3Z+sfUVvXsYkquxlFAVrWKk8?=
 =?us-ascii?Q?QAFv/ax+MGZAgzdUe/Y/Fer1lTLpYqGSNl8EPfNUy8CREUg9jjdVvgHR0e8U?=
 =?us-ascii?Q?3RTxtTkACQm8EJNMOoeh3+k6cmKiV7B/NpTol9vXYutlFCAY0bJrRgjtbN97?=
 =?us-ascii?Q?bFFezd31QWgsS5LGtkrQzrx06rYZr7KiR60qGH6B1pxU9hFTNmfJcwKtj+SM?=
 =?us-ascii?Q?6lgrko39merC4FhtBXGb+S3oIirQU2WJnidPyHv5sWM4/sQfpncTvz5XqvW2?=
 =?us-ascii?Q?KxQBq8+O6fmRdk98GBwf77402JvTTQl8hawGTsOkzvDY6xuQjm6E/Rf1r0ky?=
 =?us-ascii?Q?u7sHydTBEFgXZpy6P+qKJJ+Dlu8jKO9VBmotxXDy7yxFYavJBffniq+b99Yw?=
 =?us-ascii?Q?w14kO749j2fKgG2e+dW1JQfbOYKpIdLIwtJCSxaUp7cgRYE1LId3nEUMPjfJ?=
 =?us-ascii?Q?z9w2KC0xOsYGi4yibX6r7DRm0haLziwIxQ8kEp6Bmh872fCY/ztqx2a750VM?=
 =?us-ascii?Q?dHuj7d26BqoI3Q4P6pHNPb7edDvs3J/RlTjg2PGeKdaFruE6RwXpMI3jnZ0r?=
 =?us-ascii?Q?sFIqQOHK096JqJ7rzWqk/h1qfvDoyuJdj7X7RrfWsl+h4Bi9dqNcCKKe3/fq?=
 =?us-ascii?Q?pE6DwIS5c3XT3rammxLhsL0MqZjInc8QBQxyX0reHnYJGjiH+wQoine6UXyN?=
 =?us-ascii?Q?JyNYB/xgQuzDL8xKCk19dMK2a+bOPCUAuuFzMYiltkILitZxhr8v3LUTE4ce?=
 =?us-ascii?Q?P8VRqb5nL7Am7qhPsaAfy1YW1pBbQni9hRO9rD6+ww0xk5NjFCx2JgKzARtp?=
 =?us-ascii?Q?0tGJspUXbG6CWFMqdzfL6RDg5mUX69Ex3Qpfy6jSSth3c5y8P9vS1d1NDHg8?=
 =?us-ascii?Q?VyC57v4K/PX/FCj7gjjAhHXw0Iqs60iwuLTSXvFR6WtcW5btoSDhQ1qfq1eo?=
 =?us-ascii?Q?u9tUBCWnRSN+n9aNCpFbhn/gIWe0Pw11YwJNUl91Q8lQ986IyJ7WVD03Wv36?=
 =?us-ascii?Q?FvvRGL03A13NeejYy4fnQEPqWcdt8kQDD37jgz+sOqz+q0+U+hlhLHtkQqy+?=
 =?us-ascii?Q?cpp80i0/wfR7NkLJ9NA6J48DQ31eMcRm/2hmmCG4ZJQQ897MMJ5zO35WYtaV?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec291cf5-70cc-4407-9606-08db5d35a193
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 15:35:13.0171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Olj7Yf9Kk1O6kSaoFtJPydFHgaB57skmUrZZiQOukgPiJl937lGK3N3h9ktDHthjST6fMwyz9Au1TafvjIzJgmPmuL2BBDYis87pmjlItUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7848
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds broadcast properties to the SetConfiguration method and
bits for Broadcast support to the Supported_Settings bitmask.

---
 doc/media-api.txt | 11 +++++++++++
 doc/mgmt-api.txt  |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 3746ccd55..3a0ec38e2 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -599,6 +599,17 @@ Methods		void SetConfiguration(object transport, dict properties)
 				uint16 Latency [ISO only]
 				uint32 Delay [ISO only]
 				uint8 TargetLatency [ISO Latency]
+				byte BIG [ISO broadcast only]
+				byte BIS [ISO broadcast only]
+				byte SyncInterval [ISO broadcast only]
+				byte Encryption [ISO broadcast only]
+				byte Options [ISO broadcast only]
+				uint16 Skip [ISO broadcast only]
+				uint16 SyncTimeout [ISO broadcast only]
+				byte SyncCteType [ISO broadcast only]
+				byte MSE [ISO broadcast only]
+				uint16 Timeout [ISO broadcast only]
+				array{byte} BroadcastCode [ISO broadcast only]
 
 		array{byte} SelectConfiguration(array{byte} capabilities)
 
diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 58395dc90..c7191a028 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -334,6 +334,8 @@ Read Controller Information Command
 		17	Wideband Speech
 		18	Connected Isochronous Stream - Central
 		19	Connected Isochronous Stream - Peripheral
+		20	Isochronous Broadcaster
+		21	Synchronized Receiver
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
-- 
2.34.1

