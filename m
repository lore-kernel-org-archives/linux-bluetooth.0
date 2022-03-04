Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105FCC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Mar 2022 13:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiCDNSO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 08:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiCDNRz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 08:17:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FF71B65EA
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 05:17:08 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224A742b017339;
        Fri, 4 Mar 2022 13:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=DEfpPDO4RZGMn7U1p+1I+w9bQPjiUByeiw1/ekz7Y+s=;
 b=P1DIgW3hCPXSNdIYN5+FkNHuuVPt4AvJAU+m7rFTcw640uzwwuW7BumkBKe36qi+mDEn
 1TboTh0Xc6tldNqUAdLqUIOTC0kd9zpBwXZE2QWNqt9mEJ++j6tQ9yqh2m+8bGOENJHy
 nGnSn/HuBmZ4h4ae6uGhTwT6/EJsGoK3RD7uuG7W+I0Opmb5uRTyc10aPY8+rpcLC74J
 4MqzWyCxfQM9XwxFLey2wb/TmJ1zv/Hs7M0IFY9OGaFgfh5wE7Igm23Ux0t9Is1tAxP4
 n+GcOtzM62W97Wu6XaUH55Wf86ZHzxXJPzEhzw1rh9Oee5CcmFQa1vu+aMIKZKeTkjlX Yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hvhqk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 13:17:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 224DGNwD054775;
        Fri, 4 Mar 2022 13:17:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3030.oracle.com with ESMTP id 3ek4juahtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 13:17:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxBm7r+tcntOZl4jWGZ2KLxLeVl/N7zlXGEiPJusBgtwd8PYR0eEqXjkOeR5I0geGhKG3IQBdWfvhdUzxGpC0mMtQtR9H/dpMLTKUctlyWM53EvI5I6b9iUMxw/ahxAwdb2R3NuOR0DOqNPbd82p1kNb/abYVEdqa+BV1g6GqIGr1om0e+AF5lgfaG4PcBfNMF1yhHW/NeMzB2/6lJc4l5wUwkI5aHB9F2vKqyoiXMuKN2jP6NiJ3QLfW+0ypGUGBsGEzueOyjE+5aMdZ6CjNZK9OtYBAX9BElZAvIa/qF5MH3FHTRUUExlcKnrmLBwoJhqlaB2cFRqLmqlsIWge+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEfpPDO4RZGMn7U1p+1I+w9bQPjiUByeiw1/ekz7Y+s=;
 b=dTyqcl4kmzEDjvaLde/XM6ax3qRKovTbK3Wh8GvmjvWXb0UfP3SKXCaUv+eGyslq5hyE+nC7g1D1ku3sOLyTjNG4GCoWL0k0Aj8OX+wTj1u4VvyjyQ91c67exf0dXpCA+aYEwziNhm2CRpTYOmd5JhjaTnZuFts8LSih3z5Up9bRBUa4Gt67+5HNo16v7bL3lfoJ8IWvUw0pneSXwu9rhs4D3U8wdYLDpdSVAFESUNCLGIUM7Loit1YMbjxSZp+s0kg7mI4Fk7aE+dz4Od24G702nMHfdXNwx87pGDjp6r2QMkyE0TD7O7pmXcAcoJdxnmY+jsjSvgyCmhuGtnE9iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEfpPDO4RZGMn7U1p+1I+w9bQPjiUByeiw1/ekz7Y+s=;
 b=W6mDjGfjrTMvqfO22GV9rmj32QSjiK5+qpkthBNV6QbC9RQ36uwT0nT4zlvMVKv00vrwdEFYO9SaYtBd0w1/M63NZsC4kPNH+y0XgMfLEQBV6EgWCPRfBwshpnuNfJHGE6c3OERVj/oVbm99Ip9t2BaFJ0YAWuwyeCtfBrEs/uw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 13:17:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Fri, 4 Mar 2022
 13:17:02 +0000
Date:   Fri, 4 Mar 2022 16:16:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     brian.gix@intel.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: Fix not checking MGMT cmd pending queue
Message-ID: <20220304131641.GE28739@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0184.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5546d3f-0d39-4b6c-bc18-08d9fde1453e
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB511744CB4C318768C781C6058E059@DS7PR10MB5117.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jr9KpJyJJ9dsJhGrT/RAArZg57Df8KMLUPr3+V3nEYlgebgi3LTb+1t2Z8bp7QWhopdrwH78RnYuYO0TYGkUHY1yymk9KBqSOuux3OLMBNCzFhBltsQ6E4zauO7WbXnehf9u1ylK+w1yhQ9zj054BDZOMfm11MnxwtwuIr4LqtbD9HEEUSYpv6LzDbRWcfmnvDzE4DzOiWdOgcVOnIqYNDgJQSypwPCKIjwr8GXxPRA1Sz/xATvOlOLb1Uo9dtozxYsPXneTHA0+UY1PFb8Pv9xoAHNec2LGKpKiwIMhil9vw05ppdpD8fX+SmzTEyoAPFZ6oS4wkJRyG5N+VUBmPZs8ur3p6JxjTv7Yn1j7frQtUVzQFD5TWEhs3KebDo0h++fZWgM04Ul9GkSP4KUogfJkHGweNDN0JQhkK+00p+71Th+IbP5FUQma/9w11LYxD7RSr6SNDLKOeW91OKWyEJoUZg3/Rd6oD2DzvrQTXHJ3sA7QSXm2u7OJAsyXobphyahhVb5xxNU3YZfSxz3pPXQSq+Dniw1m6JZgKWdriim7mDPv9+A7K2F7ozT7+rjdxi5XAygzUlaf0vIV+B50E0ILD6hn7tXwf29Y/ywa11tnzbAvSG1Nih1DLYAje8q0HUOqqzV00o6CMb5xT4PA+qIIa7NiFUWszqbJkszpqdvIFJAYrhxqBKGDk8RzuhEj+WtWerIE8f6KCnqf4Ph8Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(6916009)(316002)(66476007)(66946007)(66556008)(44832011)(38350700002)(1076003)(38100700002)(5660300002)(33656002)(508600001)(6506007)(83380400001)(6512007)(9686003)(8676002)(86362001)(26005)(6666004)(6486002)(186003)(4326008)(52116002)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zR1ZcZe5zZcWG8VwjtZAhABUTGNCkvaF65t6Tv3Kar0gtYuZtpj6ItVGa8bQ?=
 =?us-ascii?Q?TrR/idyppYTS3J+kpyiHv9xFYz2CTnjG3N+Fm4ZRXmGsnERq99+0TITRa8t9?=
 =?us-ascii?Q?lMaboghb8LEVndqB72VjaNkDhLUup5L0PvGtz5UbyqglOI8maQsQkuTLu2rg?=
 =?us-ascii?Q?EwWZiumrpS/DJgjPNrFHaQSfgs2v4afQB4carDvXn4JtkqWHbOSLwz4A/5jr?=
 =?us-ascii?Q?OYj0Rqzcf+hzVJWbI0XYbPcHtDd2/vF8byYOxESTRR2PiVCI2j99art37cw0?=
 =?us-ascii?Q?mo0Ljo0DEzGpBJ3yhbBLao03sTt2/+JlvjVnmBVWFPDjtYF2dYnpnSYPXylg?=
 =?us-ascii?Q?byB5FyqZdlPPwFszTHotZnWV76hRRZYcNP/7Zl3+fm+41H317+/euqVWT21h?=
 =?us-ascii?Q?/iGpwnAs/kEeVC1n32PSZQKVRTV43EYELcNJKPDW95CAJOiR5a8rdzkGgTqo?=
 =?us-ascii?Q?QNuWlNQWLRkBRlX4mn8JI3yoq1e44qiOWgGOTusBo0RM3aZ57Izq/+CHdeo9?=
 =?us-ascii?Q?nfQp8F5MjIKeO+rkryFduJF1o0SZDR2TBhCPUwnOTyBKHKr6kVLepLgQ7/gp?=
 =?us-ascii?Q?E5nx6NuuQPL29M0u1jmWPhXIyckrPm8i00pbLVmbGzNmR5v+DCSwyFHcxh5v?=
 =?us-ascii?Q?vQmrPnf52adRgOQBQGxtbclJU9CE03H1HF68V/+g14fYkX5ht1KtKVDJ/xeL?=
 =?us-ascii?Q?9hho66+Q3Xvmfu5/uFvhOR5ZJG9k0dfxZGLCeUgBsITPzFcX7RC5Hafj+7yu?=
 =?us-ascii?Q?i5LXmzEHT3uALSHqFeHLYDRZbVQMwCyGEzQOmf9xXst9YnX7VrnvaQ5M7fPu?=
 =?us-ascii?Q?VPpwdIMraHN3j4QjvoICtC9DyeGyV4xAAuPCAqvSdFF3gYTmJA/KwtC06b2r?=
 =?us-ascii?Q?eAEtzK6XRKeHeE8xfKNQyAB1SfAEqBSm4Hxt/SSnidWp1UXWatYBntrEFsql?=
 =?us-ascii?Q?eOE585tGThB4TTSCmCO1KgHhbn8bQdyveVkpBwa97gXg0+Hq4/wMe8iOS8rJ?=
 =?us-ascii?Q?DH7JEGEj+UjpHzA4io7Pp84dtAJc1bfDH5BXKKHbT4xpNt6WzfPAMwHIaZ6j?=
 =?us-ascii?Q?7YqAs9wukJvi++nbCEkRoKAX5w4p1yj0tI3L78vJXiSTQUlGYDOQtoW/bYZF?=
 =?us-ascii?Q?MpqI6zld4t2U8igX67H46ddmSy7siLcxb3XqteHQTCHisVRqxJ8oapIdS2kw?=
 =?us-ascii?Q?xxZSL0Y3pWFVXTSVNsnxUpdDbrMxjZlWsb2dXyfVZPe9ENq68+CpRGQseJi1?=
 =?us-ascii?Q?ux2TEfxPHlPnQkDcfZsAGOCxiRjKgQhfzjfcqrGkGZN1Y08O95yllwM8r3dp?=
 =?us-ascii?Q?VMh+IQdSKyZt33Zr0Na0ulwPxJuhpMmlZbDrJ7tb8jjCJeqkrllOhVjqg0zl?=
 =?us-ascii?Q?NL1MPprSzpiW5Ahv7dL3JyajhL2d9a4qWp5S8MdDV5aDleskdajNI+geXbZr?=
 =?us-ascii?Q?7ppJdPo5bMHecKncLSlqiDtC+4vAOTpwwRwQ0zzrqZRKhAscG2qhwJ0qBR9g?=
 =?us-ascii?Q?JEuqKwV854WEQ+emqOLjqT88KfzwQJ9LTF2DJt6bIMKszkFsKjVhsmeAlTN1?=
 =?us-ascii?Q?MF3E1VLz+SihjvqwDNGaGLdkBHEGtuzkjrMOfx0Fw9iWUwWJQxDs/Lkbiozz?=
 =?us-ascii?Q?e22Ma36jTyjGKr2nCKDGDfm7GKK6+FX0ZIBS9v0L5GxXf8mJ4qgzH+YzWQHi?=
 =?us-ascii?Q?KJZMZQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5546d3f-0d39-4b6c-bc18-08d9fde1453e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 13:17:02.2250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 699fgPnrc8Uf8r0jaRkMljZSBEf6OfXsSRQISHHhTB/wd+gEYQVul4crZoWPu7n/vExi1ZevNSFF+WkH/4qiLHc5VVXOlAsezEmopVkupmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5117
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203040073
X-Proofpoint-ORIG-GUID: Jli7MROiMUUw5PxyR07GQywf74z8aL5J
X-Proofpoint-GUID: Jli7MROiMUUw5PxyR07GQywf74z8aL5J
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Brian Gix,

The patch 275f3f648702: "Bluetooth: Fix not checking MGMT cmd pending
queue" from Mar 1, 2022, leads to the following Smatch static checker
warning:

	net/bluetooth/mgmt.c:1587 mgmt_set_connectable_complete()
	warn: variable dereferenced before check 'cmd' (see line 1579)

net/bluetooth/mgmt.c
    1564 static void mgmt_set_connectable_complete(struct hci_dev *hdev, void *data,
    1565                                           int err)
    1566 {
    1567         struct mgmt_pending_cmd *cmd = data;
    1568 
    1569         bt_dev_dbg(hdev, "err %d", err);
    1570 
    1571         /* Make sure cmd still outstanding. */
    1572         if (cmd != pending_find(MGMT_OP_SET_CONNECTABLE, hdev))
    1573                 return;
    1574 
    1575         hci_dev_lock(hdev);
    1576 
    1577         if (err) {
    1578                 u8 mgmt_err = mgmt_status(err);
    1579                 mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
                                         ^^^^^^^

    1580                 goto done;
    1581         }
    1582 
    1583         send_settings_rsp(cmd->sk, MGMT_OP_SET_CONNECTABLE, hdev);
    1584         new_settings(hdev, cmd->sk);
                                    ^^^^^^^
Dereferences.

    1585 
    1586 done:
--> 1587         if (cmd)
                     ^^^
The patch adds a new NULL check but the pointer has already been
dereferenced.

    1588                 mgmt_pending_remove(cmd);
    1589 
    1590         hci_dev_unlock(hdev);
    1591 }

regards,
dan carpenter
