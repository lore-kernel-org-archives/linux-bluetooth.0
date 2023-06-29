Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554DAEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 09:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjF2Ju0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 05:50:26 -0400
Received: from mail-am7eur03on2077.outbound.protection.outlook.com ([40.107.105.77]:28961
        "EHLO EUR03-AM7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231842AbjF2JuX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 05:50:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikDfy/WH8FnYTO6rfzeo8OfOVfBzW8XWB/FBR+kbD7d6kwDR0hiR42hP/1VTV3P1iM1WJ1hdV6W17nPJvsD07CsZKOSW4b19h1r4o+GgkdDs1wqqEvXtXGatoQv8IvZs7yyO2Ew5V+waKb6p+z93qk+SrtDO/ubXFOkB4Qs7yCrin3BPnSN5wvUZuXFOCQ329/sLkgnjwEDtaxqMLv4pPRki9/CoxcQf0CcSb4m7X4kyrrwCx1ZShli8Fd4waBRwVYwVWgL6eofAwE9AoXQy8jkqJq47GteVdLlLrQRB91nff8O3xFopJU5QgsgCafBGjJlxKDvCkivlHdxHf/I3Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOU3YdKqgj6kMMT74ECrNgcUWNwqMhJSMxvGGQBwhBA=;
 b=Lu8jPnmGideeZvzRluoO3aDL/EPUByL5QKd3OjSxAJ6ZNmuVrZLBDFtbXPXV46SbDcbdn7+ybqGqN06qTKrLZLJtDZYN09WRG6WasvQmRxQtHl4E65Fub6jdyhxZouYFpRsC/od+pGDU+B6VegY3FzncaIfFYA0PREgtr+8soJW+RlIWivtG8OIAXRNnMEg1PyH5qDn9FQBoorfQf1jLH1XkGky7ReVuVLmct4Noa4MIH8yzZ4PfdNxm5gr9vtxrGARZr0zagvLPEfCTmYxBM68CNwFpjJ6wb6WKMpNVeMuvF7x6eoJFO/CWUPzsAvTB7ZmgHfXEEg8NaD8bmdzi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOU3YdKqgj6kMMT74ECrNgcUWNwqMhJSMxvGGQBwhBA=;
 b=pqZW5x+SQFUV9h/xZGlDDhZfpopkLfviXcLVJol3cVkDrSDPEaaTrRTPgpaZM9X76g8LjD1rutnlA4MqM6aCwiKsSGoeAC6emMYRX6DtL6Ekflb46z08/vsEMaHZWVW7OJISh0yTsxbG81EHv7aGf5Jc5FJiozCqDkosD5SlRoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by PAXPR04MB8783.eurprd04.prod.outlook.com (2603:10a6:102:20e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 09:50:20 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 09:50:20 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Add support for periodic adv reports processing
Date:   Thu, 29 Jun 2023 12:32:23 +0300
Message-Id: <20230629093224.5135-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0147.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::14) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|PAXPR04MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: c34acc0c-ea94-4108-c6aa-08db78864013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/w3+uRxOMFaY7cZ7AI9vTj+MFPcsah5TN4OKUzhJ9ssu3SzjKI30PAIOQmoSHzLm334nW2Poc2GLt73sHVe66uGysWAW4lJ3T8LoDEE8DUy2HIpC5jETR5XEZa+E38NHXUuVM3wlaudExRPlCoIA5AS1vWPh5zJesctpGXvyzxK8COZaRd2sunIPHHQsvw+11iLatkYmEHCIrCiivsPb9KhUfXKnxTirbxkbR6oCTFq7GvEd1+4bmsldj1TywMsFadQ7EutIYgXmaDXI6j9L64oeamBf+qRnbPuzoH9dwP8pLguNKjvgsC7m2eeaUN4m6WlLhFY0+THnmGaavUpUTTm1UxjkLkgQ6fdN1ckEMdgfOJvcyrOtw8ThHXU/zsrfsJyjBUaN1yB5BYhRqv6s2Y0tIPTj5yDnqKBtg2EaohqOcr4rAx65erctJ+HEsHEr0nCNvrnHo9JbRhNcIIvxd6OX7dXdDhvY562k20hFAkBA7cOOriZSgKQzrsLBHV9rleUAFuZAwTcYrK7zvfGPJ/rofmU3riYmDeAqEbhOHWvilq5aBXdkRbgbr/8nhS1wmkCwh0VQR+HUzzDnsyHDwTRC8GXJ52utNF1FNDM0fw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(6506007)(36756003)(66556008)(6486002)(26005)(2616005)(52116002)(83380400001)(4744005)(55236004)(6512007)(186003)(2906002)(478600001)(1076003)(86362001)(316002)(5660300002)(66476007)(38350700002)(66946007)(8676002)(4326008)(6916009)(41300700001)(8936002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EjeTI2MELNHcy0eZg3m411DvMvV50UP+1kM2VxoIxn747bibVPGL7fUDndUy?=
 =?us-ascii?Q?VHKmDh3tcykHrn9Ss199lqYp3Z1YiMkYCFknt/0T4FL8NYa35s74SGXcybT8?=
 =?us-ascii?Q?L/DqKr6f+GfYN3Dqj3Nn1IQCv28qTyhIaElvh3b5W97q5kc8Q3XFQp2soau4?=
 =?us-ascii?Q?NpaWV/90d88wEdEjvzdB/MiKVonbPPBRz4Q3FAsWaYYJdQkHJg7KnnwlWFfQ?=
 =?us-ascii?Q?ZUzyL9OZLg/KS5oYSO5y3seL2GkiB/pQWEYhXSCQUuixLDXOqQ/xtY3dSvI6?=
 =?us-ascii?Q?TTE3wDPeyQez2UiryUPLqW5U1Vg1a0FGFQbBjuORwYEpVBT9Xf1NP9DPe3x9?=
 =?us-ascii?Q?Ho0ZG2h0nIbPIiVx2niiCWAc2O3RPnC1tam6l7whDNzSswM4VNJaV9kCqe3/?=
 =?us-ascii?Q?TrjeKpoYaqnje0ZWA19ArfsC6ZyAxwN2xfPYqDu2YiJpfOt9mKWZGP08B4Rb?=
 =?us-ascii?Q?zImfrPPGJlWPr5SKmwyvOw3YJR9XjTGWxGF8ESgN7NRf+R0ijk7gU5hDr0a9?=
 =?us-ascii?Q?Fu6otaU2CPVItXraX2hUaZJgMxLKYREbtAdF8HbBWIVJjrJ+I0HpxkDb/EDa?=
 =?us-ascii?Q?gW19yD3gV/9VptJs/Q6BNOxg+2Qhx4j3u3rBGFbUqaYJY9crdYIgXP6Vm0Vj?=
 =?us-ascii?Q?j8m0IgoHYS1hpbQ1M1Z4xPn51tKbyI+1dAhFgnl9vCOma6FXn43X1pJ5U15R?=
 =?us-ascii?Q?qNyVi8hYj8dMrqcM/HrspVONt2KjFalkERCjhrJ+lqxvyCgEBk0f37gtY2Hs?=
 =?us-ascii?Q?DwmOUIhZRAcdVDlBBNpirz0WpCqKRgYWC+5lVQTOp8vntUzeV8giRQxwGerj?=
 =?us-ascii?Q?uWsNqUh4PkoSbwMe9KeMZqjgV6wNrOVM4K8VBPQMhX70EPeTJsrodlQJYK7p?=
 =?us-ascii?Q?9hBrfvZsRTJlHYfJadtUepqAq6UCtnzQKydE9IWiQCj2jxzla/PIyiDTDYRm?=
 =?us-ascii?Q?uON7g5VsHphY0K+9kcwPCJjvN99H8I8Plg6BEBa78CkhZK6L7+w9W+gw7RIi?=
 =?us-ascii?Q?oy/CaJAGqXimytAPirOFPiiegbaLWOv8WHrUsxcWdN3GPcKPmXmpYwHZ0pvD?=
 =?us-ascii?Q?yp3nJbrWw7xk4s1HkC/4SqJXKtEj57WIyVAJ5J7j6ZLlJebWjYhTrohZfnwY?=
 =?us-ascii?Q?dGmb1mkyI7l7saP5K7075Iama1JccvHrT5FyzO/T/XDEFDvtiD4d5GRKqVRJ?=
 =?us-ascii?Q?Ic0tJc4exAlIpcaoiSN07MTmzo4TOegSNkeEVTL/u19pnq93baRuByVa2LrO?=
 =?us-ascii?Q?e1U7jwN85O5Mx5z8UWEBF6Qrk1tzuB8YueY09eniTt2W2yGAzBU10b4K7n/l?=
 =?us-ascii?Q?J4n79+r0ceJdB5FcfyONoR8SJzpnwqK6jgvfnSKHrKeKt+nN13Qc8W4oBZO8?=
 =?us-ascii?Q?FolGjVysPy8OciBY8pCz6nkCYXt8Xios5gyso7d87GDetvZIOjfJ89U1FQ+I?=
 =?us-ascii?Q?VQ1WNSGDpMBFSErxf+RjcnKcudUjr0kRjxregIEhzVBQZLvsnyIK+/OAzXTD?=
 =?us-ascii?Q?ZwfXP25L/lAAmuP/l1+xaTmRZ5fBBWjRZtgNPEu/adJj0EVpcNTRNpCg5C3A?=
 =?us-ascii?Q?TwqlspsBqRnQkxt0SwStFqFMIZesCOE98KYS10Ja?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34acc0c-ea94-4108-c6aa-08db78864013
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 09:50:20.1684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrSysTNuKvv9IUNwiJmWgo0FMCO3oazI1GPom4QZiBKsHaEQ6CBHFQMJX6IeedM0C4Vd/D8h2BPYmPjsSG71Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8783
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In the case of a Periodic Synchronized Receiver, the PA report received
from a Broadcaster contains the BASE, which has information about codec
and other parameters of a BIG. The application can retrieve this information
using getsockopt(BT_ISO_BASE). 

Claudia Draghicescu (1):
  Add support for PA reports processing

 include/net/bluetooth/hci.h | 11 +++++++++++
 net/bluetooth/hci_event.c   | 23 +++++++++++++++++++++++
 net/bluetooth/iso.c         | 28 +++++++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 1 deletion(-)


base-commit: e63d8ed98082395ca509163f386f5b04f53872b3
-- 
2.34.1

