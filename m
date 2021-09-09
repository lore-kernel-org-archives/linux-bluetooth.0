Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5858CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 09:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED4561178
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 09:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhIIJDg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Sep 2021 05:03:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60030 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231281AbhIIJDf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Sep 2021 05:03:35 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1898xNdd016388;
        Thu, 9 Sep 2021 09:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=e+be/6hHN4D4Eapfd5bmE6xYKFKLypbhVkPIJ+yJ4g0=;
 b=JKdEUVjo5jonrgHKkurMXc1sVwXZfNmMvdCWsDEA11d9lj6I8jHZJpYTFYy/VzgQk+xG
 5DzJx2uzVrv6ETpUkxEnPoNLmcuXSBYBRU5XVmv83KXcBOYUe4FTUEJYr9Fcz5zdgvQi
 mGeyqGaKAwWpTd3rKBmENHlttfeUrdCYOcWNp1cQ+5OiIFt+BZEYThGPa48Cnvns/jwL
 5yVF833Ulj23zmSBMLOHW2ZUXJHbkYHPfYMQtnH5MfRrAFByJSYkTXLSwPG3qAzE6yMQ
 Ce8G8+edurw9o5xtB0KNmWbS8wMFwrKyTeUOn+EvMRjHqTJrUBfZPmFHQsJebijIERZQ kg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=e+be/6hHN4D4Eapfd5bmE6xYKFKLypbhVkPIJ+yJ4g0=;
 b=RWhxFp6ncHSNiF1Le0Qaev5D15KOHrrPo9sa45qSEdhhr7TtQCQFDvU7ls6277EXaIE/
 qeJK5CO1F3PKsusANof44VcN7/JCC/i4TVZyuhbcikzTP8E8u7s0B/VwA3ueFs7xz0qB
 Vf5Yz3FwUgov5IXxrbwAKAMazG8A/EFHX9oR+eYBpYBJ/RoEjrY2837rIZIKJL5HnmW3
 0KR98BClHgvOxSyrX0GF4T5uEs4jk6EiQXXBQ7aW3Xi9l/ujUu+Kczi/WfIq1BB99Im4
 dmueyOpUrrRU0COZ8zfDPIUxTMBhL/rd3qja5oMp4fSlUf3cB9WVe4+1RMSESZobOcND gA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ayf8a807p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 09:02:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 189907gQ105085;
        Thu, 9 Sep 2021 09:02:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3020.oracle.com with ESMTP id 3axcpnevcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 09:02:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xf4cPfAW/PKJNCrJy82dnbNIZ85ecvevLQaVZRSTvjk3one40+A3v8ExEIK3LyABbAVx/f1xmQRDzbtjTMe0vwOND7NL5XVSQvbKrzLMXnYFm2ABRmufmH5wypSt5RIwJhLfnyL7Lm3x3MSUG7uRL9zeWSmiKD0VkzJsimF8mPJBf5+0/wE3TosqOpEqMtokD/nkBUP2Uw3HdU0pXbkqLyBPLu9gS58MJPa9cSJ103wATS39i4h9zdNq0jnBvDBGUe3RcBLOmXL+C7uRABD98Jk1TQil4jlG8VB4PP+DBX+ttk9cxIkbkzKLu0cwmD3q7ocneRgxmErM3huBIeYbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=e+be/6hHN4D4Eapfd5bmE6xYKFKLypbhVkPIJ+yJ4g0=;
 b=DyI+nHZOJ82hxPoHMU4IKMkb3v60WhehB0mXlcbB6PCrn0HOKfeYCQld8u2t0IY1fbsfaGGH8TiqBFfmiooC7biXnwhFyU/+mVIJ2blEBZXL0CBYWW7ovN70ryeWvbQkj2M5VOiLtJd2wXO8wRaOQ3UKjd+OP9sXMTj9Ql+/b+5Nbie2nOQftIVPAIiFeYG8oJN/lUcecNyOtfmgk84qnTFfjgg5jI6yMd5C8ySDNTe/BVR+auEykzUCvy/IjfFXqDzM/4QTeFlTMdQ+fSRzBG6ivJ8JHw0d8QhjOSyPgjppVNExShiv360iVOoaDER/t1BriA3/mnHNx9g2j575tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+be/6hHN4D4Eapfd5bmE6xYKFKLypbhVkPIJ+yJ4g0=;
 b=v7RO9uZ0ShxHlnyNG4UtZQAgvqYyBQcZfOufzJt/0qAjjlUFFRx2V2MgaWllNzkgDqZ3CjSZzppdx2kO2QZlif9vPhiEXbVO0fO5xYUG0tCyGbNcKOcj9XIjIAAnXb2RAEHyN29R4jXENrt8gMrY+84DCmcOXGFgEMs9uGVZl2A=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 09:02:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.014; Thu, 9 Sep 2021
 09:02:16 +0000
Date:   Thu, 9 Sep 2021 12:02:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     chethan.tumkur.narayan@intel.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: Allow usb to auto-suspend when SCO use
 non-HCI transport
Message-ID: <20210909090215.GA23894@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO2P265CA0228.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::24) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by LO2P265CA0228.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 09:02:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86f3c496-030d-4726-9795-08d9737084d1
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB54096D657451E9201714DE0D8ED59@CO6PR10MB5409.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lFJJAqQfZ6y3c/pZeSwIarqP47HYrNE99zsvlVqsfirIKSCRSAmkQZ2X+Qy0IF+0OjNpW8F8NtyVpsueZUmSR5MoYrm3GLZoC0Fl/6XNP7aTHk4+QZiIqbJG7LP61YetfnAQiYNVBdCjHdxzbQiEygVRoZMEibeJkOQR1mBIHiFb+PuWp9cJnntOBQPownTGp8gCGVr4/Val5p3EPbFo4E/ipToutSPHNsl3te2meq/nMVJAGx/0btFv/echc8nggYbtr/cTg7rL6oBR/3eB3NziiT7bg4/n2325X9t68T8hxZkA2X7d27R9WTXDrxcAwWRYXQJ6WO2IjrAptSZcPuU4Kw7ITlFRJ0mFJvJHpGFHM9bfW7CDEBRMSCKqOgEfH+zHgs+/GGyIWQF/dUiWQ0x6FMSe+8nZiDrL7HB/PzMtXNyVNXuSbqHGT90C2L5z4+2c3m8yVC6WXXKlpQWIJeWOL5J/zrQwAlUgGhV+X0Vv9+1KigCS7+q5Qa+8lZ+cXPJ5kyIUQ7RHulfp9KuzzBT/s1iUWvIBAPbrFsFn39fmNpf61UetFrz4FafoDUAYp63DT2UYIpByC2OZw8gRPtcjSfKy3Wj6dry5cxXmNpCkjHzLs2Dj/ANQvbHJPsm+gV5QKiLRDbvXOepB6+bQiHAAnSgVNYv8k0ZmWYr9xx4vxjvpw7NeQ/zlAgRMiRwgbbCiKk45DV3D2GOMHtLKDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(15650500001)(33716001)(52116002)(508600001)(66946007)(6496006)(33656002)(316002)(5660300002)(55016002)(956004)(8936002)(86362001)(6916009)(8676002)(2906002)(9686003)(1076003)(44832011)(186003)(83380400001)(26005)(9576002)(38350700002)(38100700002)(66556008)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VhXv4ZKMoyHnxKEbFLWjZABiPD+2xih+aOUj//b1XkEOO/jlDBlJbVWTVniE?=
 =?us-ascii?Q?Pw71GORFQWyzkhFJxKiAO/XrdPUOEfECwRbd3yIu6XBvYEg8YlW/vAQt+RVp?=
 =?us-ascii?Q?EKovzzxsKslVqmaaxfsw6JHBi5tAiEdrJuOV9/gCocKcHVDrzaNXLvgI9oFO?=
 =?us-ascii?Q?NlCUQ0D8Z3ttnUiqefqnzlqhj7BTJxi81PLjEFhNmBbsX8WiijkF9OPt0YRQ?=
 =?us-ascii?Q?sSucOew//yRQJHVT4aVgs7/CZDYbSCMfjdn4BiKdSEnb0GOFo+5AaOhZXxsS?=
 =?us-ascii?Q?PlOUJ+Dz4XfLZjfuUqisFE9zG39TFoLLf8HIn3n9cgGCFvUTKnZb7gGV3632?=
 =?us-ascii?Q?JK1L50AE76ZW6Ctt0R5kfBF0mLkFgxBoec4VYUkqRBvBDYo/kk+pxxwqyTpX?=
 =?us-ascii?Q?EGHpX3k+l/W6mEnX0AfGzgTs7gtz+tH9wYYDI2EeXoCWHw4DPrEDEjGG0TCn?=
 =?us-ascii?Q?8ZBtNcFYvTUOkZIxVxYfi2b/suAvZAzAQvEBGVMTP/Spdyt9UjJ7omhMUm+A?=
 =?us-ascii?Q?gl7QwAx6ukOIC93+qLnGoA9bbvDGlJnxOhGVNe2cQ9XGtZHOLhpzzN6QPiIX?=
 =?us-ascii?Q?TF9U+tUcs+7P75mzFWmkLffeKFu1ZlSkIoPZVt1G1KyHQEx/06SXZ7pWHvmI?=
 =?us-ascii?Q?WCxDrysqMKGJeoTHuv2lQFmC6KPq20mEam0w7j8OW9atczHN36kyL7/5QwlN?=
 =?us-ascii?Q?rgcQiW4JStSmiGFYfpi+3pOVb31RcNrmSiXZhMGonW9RkMqWax8o17w1XKJ0?=
 =?us-ascii?Q?DkjAV1pJH9IpAsHafEhAoDX68P4zlp8LmVLZ17D8ZJNVaSmDhGCjyXQkr4uE?=
 =?us-ascii?Q?lNHosSK7OiiOMvoGNsaZUNQCnKf4ZHzwoHRuBtmeTa5RCiSXTuFB9Skjvb+l?=
 =?us-ascii?Q?QgDj79Ebgyc041vEuT3Bx+8g4bplgZhFzFi2NDTwgtkpyRTCqjvAqc9FIBas?=
 =?us-ascii?Q?MmbER6Z6HhWopCEXFj788dfeRbbgkM0nRy3+v9L2aHGn0t2/Sn/t1f2wBJi+?=
 =?us-ascii?Q?Q+KMuqOytqsz1phRyGlune4khbq8zIdFD2lKumWIDeBDD9iYHgfKrSm56ZDW?=
 =?us-ascii?Q?AXIcGSK7c6KwMIe7OeKmQGiNV9Fs8gjnrCoHD/6b1vm0pDH1kTDMquy1mEao?=
 =?us-ascii?Q?+/kiEXhAKV5A/d6LXw5wq7YP2e9nmP3ugfJz3xNduMa8EOrG6/5NcM2JDpCF?=
 =?us-ascii?Q?Tc9Y+C6VPwwbbBZQPNggOriEHa72IchEPcu5S5XOnHioMPAUGywoH+FMPgl+?=
 =?us-ascii?Q?BQ4vIKja+UYK5+5n2GAx8V9jUh+a4mijhdFrVmeZVMLzdcHgRv1k0BdivpMa?=
 =?us-ascii?Q?i/20mrIrIm9cMZRcs53mQU7v?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f3c496-030d-4726-9795-08d9737084d1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 09:02:16.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9MvrnxIaDdlRvQasb7VeLQhui/OgIRr4SCs6RL6HXYZkO5I5E3BAC6pvwcGy7xAYlllJfGtWOfvNI6WG3VEbGAMrUpr+uyFIwyN7dY+H1fQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5409
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=961
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090054
X-Proofpoint-ORIG-GUID: Uf5K4NcxGCBepKh-qTB5ZBQMhnCEL3i8
X-Proofpoint-GUID: Uf5K4NcxGCBepKh-qTB5ZBQMhnCEL3i8
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Chethan T N,

The patch f4f9fa0c07bb: "Bluetooth: Allow usb to auto-suspend when
SCO use non-HCI transport" from Sep 7, 2021, leads to the following
Smatch static checker warning:

	net/bluetooth/hci_event.c:4534 hci_sync_conn_complete_evt()
	error: uninitialized symbol 'notify_evt'.

net/bluetooth/hci_event.c
    4442 static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
    4443                                        struct sk_buff *skb)
    4444 {
    4445         struct hci_ev_sync_conn_complete *ev = (void *) skb->data;
    4446         struct hci_conn *conn;
    4447         unsigned int notify_evt;
    4448 
    4449         BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
    4450 
    4451         hci_dev_lock(hdev);
    4452 
    4453         conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
    4454         if (!conn) {
    4455                 if (ev->link_type == ESCO_LINK)
    4456                         goto unlock;
    4457 
    4458                 /* When the link type in the event indicates SCO connection
    4459                  * and lookup of the connection object fails, then check
    4460                  * if an eSCO connection object exists.
    4461                  *
    4462                  * The core limits the synchronous connections to either
    4463                  * SCO or eSCO. The eSCO connection is preferred and tried
    4464                  * to be setup first and until successfully established,
    4465                  * the link type will be hinted as eSCO.
    4466                  */
    4467                 conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK, &ev->bdaddr);
    4468                 if (!conn)
    4469                         goto unlock;
    4470         }
    4471 
    4472         switch (ev->status) {
    4473         case 0x00:
    4474                 /* The synchronous connection complete event should only be
    4475                  * sent once per new connection. Receiving a successful
    4476                  * complete event when the connection status is already
    4477                  * BT_CONNECTED means that the device is misbehaving and sent
    4478                  * multiple complete event packets for the same new connection.
    4479                  *
    4480                  * Registering the device more than once can corrupt kernel
    4481                  * memory, hence upon detecting this invalid event, we report
    4482                  * an error and ignore the packet.
    4483                  */
    4484                 if (conn->state == BT_CONNECTED) {
    4485                         bt_dev_err(hdev, "Ignoring connect complete event for existing connection");
    4486                         goto unlock;
    4487                 }
    4488 
    4489                 conn->handle = __le16_to_cpu(ev->handle);
    4490                 conn->state  = BT_CONNECTED;
    4491                 conn->type   = ev->link_type;
    4492 
    4493                 hci_debugfs_create_conn(conn);
    4494                 hci_conn_add_sysfs(conn);
    4495                 break;
    4496 
    4497         case 0x10:        /* Connection Accept Timeout */
    4498         case 0x0d:        /* Connection Rejected due to Limited Resources */
    4499         case 0x11:        /* Unsupported Feature or Parameter Value */
    4500         case 0x1c:        /* SCO interval rejected */
    4501         case 0x1a:        /* Unsupported Remote Feature */
    4502         case 0x1e:        /* Invalid LMP Parameters */
    4503         case 0x1f:        /* Unspecified error */
    4504         case 0x20:        /* Unsupported LMP Parameter value */
    4505                 if (conn->out) {
    4506                         conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
    4507                                         (hdev->esco_type & EDR_ESCO_MASK);
    4508                         if (hci_setup_sync(conn, conn->link->handle))
    4509                                 goto unlock;
    4510                 }
    4511                 fallthrough;
    4512 
    4513         default:
    4514                 conn->state = BT_CLOSED;
    4515                 break;
    4516         }
    4517 
    4518         bt_dev_dbg(hdev, "SCO connected with air mode: %02x", ev->air_mode);
    4519 
    4520         switch (ev->air_mode) {
    4521         case 0x02:
    4522                 notify_evt = HCI_NOTIFY_ENABLE_SCO_CVSD;
    4523                 break;
    4524         case 0x03:
    4525                 notify_evt = HCI_NOTIFY_ENABLE_SCO_TRANSP;
    4526                 break;

notify_evt not initlaised on default: case.

    4527         }
    4528 
    4529         /* Notify only in case of SCO over HCI transport data path which
    4530          * is zero and non-zero value shall be non-HCI transport data path
    4531          */
    4532         if (conn->codec.data_path == 0) {
    4533                 if (hdev->notify)
--> 4534                         hdev->notify(hdev, notify_evt);
    4535         }
    4536 
    4537         hci_connect_cfm(conn, ev->status);
    4538         if (ev->status)
    4539                 hci_conn_del(conn);
    4540 
    4541 unlock:
    4542         hci_dev_unlock(hdev);
    4543 }

regards,
dan carpenter
