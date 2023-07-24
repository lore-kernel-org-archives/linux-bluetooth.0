Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30763C001B0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jul 2023 08:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjGXI41 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jul 2023 04:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjGXI4P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jul 2023 04:56:15 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78AD19A1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 01:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4+eva2mUaMWzBXqsSVRBzFZNN2bbUMkYFoqT+VuafUi9oYQTFsLOyOHOnlLjSMMsOdBJ8N6if8+jC0sSYI+ItRXAx0i8cwgsNbzBzLKFQYHRdNwOa503r+IT10KrrVEIY8pd6qjQj6qSj6xqgY4pNUGrKQmghecUT3zUkXcFVxT8l9gYIUwTNxJaqxaLUy+7mffbNzsj4uJ5/Q0AP7XxtTyAfcjbYcd2bdQSv5lBUu8eZNT128rUZ0XzLk5lec2SuqfRKSq0kQgmRacEORSIbAG7iYJG52P9sOzjF9ld7z3zRizq/Xq6YxTFO50JzArLlfKXbZqm37jokr1Uf8+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orFneN1+Oxw/4fNqRV/okxHZk+vZkVuKzUSJE27KPJE=;
 b=U6PdsV46sQBnhEsTxwcHWnpRZD631WCI02CxLdVsabN18KLJHHyr9fllJBo7WKDa1yfI9L5/6q8ipKc2Tro3gDLP/3J+tSsE/bjuvqbvdcgbsK71jrIvvJcC0zUwQnf1bpBDn02wgrYQdZ8BHrzimsoruQcZb6qHbQxb+WmrfqRdVCm2D1yu5Ab2X+wsbEEcJkSyn9eFw5PqxuHIDysXWjvo6A3K6CBYN4oGp2xSVTMMlSGbIGIqwHIwNgM8PF9bDV9JP+uo5nWr/5QxnXhYjLQ3JKhnA5u8GCUNPVCx6oYrOcp/xCx0Mjznwa6rgD4lo8kUz/ebeylPahRIr2GoHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orFneN1+Oxw/4fNqRV/okxHZk+vZkVuKzUSJE27KPJE=;
 b=h9RvzWyatS9eQGNPAZ3AMZjHgTwt+4s7mGkAMpHp//e6GjSaC7b7w9Xz22mfWlJsrMv1Y+o2XEX8LKSmXu5A5Jn/4sxTzW6P1vGvjrSsGFUFBEkyzc8EI3szeW4b8t5cTnmVH7U1e0o8Xey8GhqC57Jw700gRSrX6LqBuFTk0dU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by AM9PR04MB8537.eurprd04.prod.outlook.com (2603:10a6:20b:434::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 08:55:57 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 08:55:57 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, pav@iki.fi, luiz.dentz@gmail.com,
        sathish.narasimman@intel.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v1 0/1] Fixed the crash observed with VOCS when pairing with LE Audio TWS earbuds
Date:   Mon, 24 Jul 2023 11:55:29 +0300
Message-Id: <20230724085530.5555-1-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|AM9PR04MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: fa537ea9-3690-4add-3e2f-08db8c23cbc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wwzw+H6Dva4hxQGebMN84HN9n9NzaFu70FK+R5k7PEwu+O1i/9VnE7sS/Q3nAZkG0vU2lx56rZl4BfkW9x23HMaGfEYuW7TakdTf+l2STSde6QKsRjF2xcX/Pjp8Hcfd/7deEa6s4hkckbf0EEWrM0fiKCPN5DUZqNUisEMuSLZiPCFFbW2Il3h5IEMSR0K7J5OXPAst4nqZN4HxsdCPx+UfRnBZdOp2vl/ePJJNRxNwOUfO5KBTBlEaodxLQIYP4j6sHWaZ7lR3FOoMjOI/PsJrj303tCOVpAmitryc4YXjgkmO5h007hWYMdPgL4BvKE3JHNZHesCfObNQT5OuMUvQuFH2Ac6dGahI8mzpCmBso173g07fj28eMEhT7Aj6YQVdQ2Amq0jytI/YK2JsaC+xDhkdCYXr+kvwqzb5wydK25BMcJBpJo4Usn+g78P5V3hCzzz1kgjqNdFezl0VUwGaJidCHX9PALpxcRbaFI6K6XkEjo+MhFtHa+COkiHOeQ7zXT5oH7XbC7z8keb6AEqQkdSr4KpxNUJ0cmNm2cu3me+p9ilT8NG9SwocnKMCJ6XPMYd/333ahXyoKh1c6ImScy6s+M5d1+4pV14syrw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66476007)(4326008)(6916009)(478600001)(41300700001)(316002)(66946007)(5660300002)(44832011)(8676002)(8936002)(966005)(6486002)(6512007)(6666004)(2906002)(4744005)(186003)(52116002)(1076003)(26005)(6506007)(66556008)(83380400001)(36756003)(55236004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yd2bfPmKHSb2rJjtKFix9mlEqKOJbh6rjJ1RRwH/hrMoAdMUx6Et4HxK0HWz?=
 =?us-ascii?Q?CutZ8rNwosDCofuoM3ABmH7rvb8KD0woEhbxqQIwgRH4EYrbWh87LjqQ3TbH?=
 =?us-ascii?Q?KcNRWzNo0HmhjDxubxWxBrnEhTbdQaZK+vCuITpZ0QBSTbLZP0AfJi+wbju9?=
 =?us-ascii?Q?RQSyLqoDCZ0/D02TxEdbN9rW7lC71NUXjvokkFwbXnGzsGfdncVqrzKVONy1?=
 =?us-ascii?Q?ll4aZNUypS5b2dhXCNMPizFus7rF/bl7BdW2xkRIsEeWikCPJtJytx/RLxjy?=
 =?us-ascii?Q?4QgPuOp+/Aagchnr5Tc1FdA8Mcx+rErxwQpvdg/zQg+SH2qo01mSXRn+9CR2?=
 =?us-ascii?Q?U7kIZjQZD4rr3r3W+itrrCOvDK1nKoC9vPs69Y0Yal7UydTCGkbRPsOmQdRP?=
 =?us-ascii?Q?dBK5pdAKzHojlYsm58DaH41CzR0bmR96lmkofUUW9EXrQlnSO7SId3igqVPg?=
 =?us-ascii?Q?rEQOeIh+Aew10xlN5Tt1na1kSOYJKXaWfrpmez418M0wNtNxFOxoO7sxSh6I?=
 =?us-ascii?Q?WosybYS7pNpSElkEtBAiljVdwMIGpr4nGF3aDiLWHbyd87W47HJuVkygiveA?=
 =?us-ascii?Q?EPTG7yUi3QgXFBTBHRuLWZ5kzGclkGo02pdNxstT3qRp/viOCEciZKNw4lsl?=
 =?us-ascii?Q?GlM0rMU4rAGIb5Pof/XxmoDUYCOfvok7qpXzSjATVv1yFjlf/LMiPWRskoFj?=
 =?us-ascii?Q?/2usNoBrFIZ5TVfrZwUSvMX2RcGkJ/Fxa7HyIu9eBtOfK6X0v42hyt2FzRJf?=
 =?us-ascii?Q?cuu7VE9ixh0AfpkKIwhlTg5JR9Tqtd2+ucoPrdH31opHh+0LuesKcCJbmgL+?=
 =?us-ascii?Q?RZ5pohOqmK7nJbfpHKG8Jz2+a+YivKN5V9oBjVIbuPK13Dq3hvnYSE6pwED/?=
 =?us-ascii?Q?/JE59VLZ8hXDyThixLN9mT2Men+4f12J3zE7AuPXNRrd9nQKygr9G+jI2uQ8?=
 =?us-ascii?Q?tiOh0EV06VLcWLTbmyY4T9Pmpy8ddyuTQx6S9y+gCkqoCyPSlDt6wmWCVawb?=
 =?us-ascii?Q?7FVEBv3F9FTE5h68jcGMIJxl2azk8L47aJ/f3z7Xzsj/+aYx/sQtSKjUOuEZ?=
 =?us-ascii?Q?O7fJK+yFXvnq9anayATpa/FyQO/CHSLSM7iVN8DD5hNhhBSqLKeIHyyTSR4E?=
 =?us-ascii?Q?/xURKew1SZz5vs+dXgaSFyfpYfyhDtv0VTgYzCaYCTqQs+pSqxewb/74NJBs?=
 =?us-ascii?Q?1ImbIzrGgXWQyoLZNqrwvEfXDYaDo7eWQTGPxYSpxcFHHx6y5XjDFnAYQtkD?=
 =?us-ascii?Q?lFB1ln9ovK97x7NXzLjssj60q1Xl7tSUTYbHcXWKV2yxcEAlQ/IQe9ueAFPA?=
 =?us-ascii?Q?mlqOaeuhGTxnZHeNODryWnBG4FJrgjSp7pGtowJxChQW59Y59qnJ68Svwlyv?=
 =?us-ascii?Q?/1FWOaX7nYkxlwV0DqYAKi5BvjYLVXe3SIYLJS2DYzlsnjBE48f2C5KBAaI3?=
 =?us-ascii?Q?gX2JTyrgLNEY/HDzaYMrptv8GUneCtGdL3sqBATuytQah8gMenFcguaZF1f0?=
 =?us-ascii?Q?lPHp8bXThv/kN048FcDg6yXtSatQcbdE6JkLCIW/xmPvyUFnv8KRnfIPljnK?=
 =?us-ascii?Q?isdpD/TkDI7QicaazFUHxOHVsXyMVKkjYtOEBNnr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa537ea9-3690-4add-3e2f-08db8c23cbc7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 08:55:57.4567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZq3jx4uUPjmSI1yuIw4MWRRuaFzJwp3qZylqhzwcBpXTC4ZVxISwPq1lf5klQbmVap3eNSSK2R5kyCr5WZ3ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8537
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers

This patch handles the fix for the crash observed with VOCS when trying to pair with LE Audio TWS earbuds. 

A crash was reproted for the following patch by Pauli Virtanen <pav@iki.fi>. 
Patch Link: https://patchwork.kernel.org/project/bluetooth/patch/20230612133251.194-4-nitin.jadhav@nxp.com/

Root cause: 
- There are two types of database- Remote and Local (rdb and ldb)
- In client mode currently the code was written to access ldb

Fix:
- Correcting it to access rdb has resolved the problem in VOCS
- Same correction is done for VCS.

Thanks
Warm Regards
Nitin Jadhav

Nitin Jadhav (1):
  shared/vcp: Fixed the crash observed with VOCS when pairing with LE
    Audio TWS earbuds

 src/shared/vcp.c | 52 +++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

-- 
2.34.1

