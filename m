Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0003DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 09:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D092861246
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 09:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhIOJ1W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 05:27:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19148 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231610AbhIOJ1V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 05:27:21 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18F82l1F018644;
        Wed, 15 Sep 2021 09:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=X6wEOqgSrP3ARx0El7bCyLlRJ/7cp0T9pu/cp5qvHpY=;
 b=jaTSHUgAh8kpFiixh35a5HZbRM+RMa6MdE6VTm75yiVl3lF0Edyc1JH2L6r+YRtQK9TF
 Y3WW03wNVFHiWcOgFojznQZUe7pHOUXWS3zGvXthre4yZaDsno5KzTRCZ6V+UgxyS+L9
 mu+OkLhSsV2m2L99h4qWup1xSyB7uuK0PjkMpmSjrAK08NYd55f4KWU0GxCZ2kKFkHQA
 0WVwQQTbsMbWvro4Z9UZxYkdFulSMh0V7syTeaL5NanenqfcGU8ZyTrF60jo4qmmlb6w
 WHY83PdDYFeLoqRtkUuRTYp1ImhSh3ljxHQS2p4dqy+bF+umR0Hv/Gouwm5Vkns3NBnO LQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=X6wEOqgSrP3ARx0El7bCyLlRJ/7cp0T9pu/cp5qvHpY=;
 b=0NhlBK/pYmgzvTkrcTXhXgNnFB9bgsTgqM4IRW0wo/Ba2H0Nc8rbh2WtScekwn68RWO6
 qBZ/nPyVzDZEuntY0IDqYXYC5wxk3ftNmXgSH0Gv7kd1+FMNgIrjxLE3KP8bjEgz4ZlC
 HfMBJGgETXNjKsN5ztCMD0vPYSXOK1/gJrSaPQCEN4QFAVcoZ+ZVLsmvjYVs+I0f9SZ9
 8QW2WYhffLc9/J+0qkr7HVj+t2jIrNUx3KKDgxCyKkXQIb7YwBB/ze/ThqRDxYwex4Y8
 UE9SB1uLEdxMzgCVdvNm56CK9e3pvpFZLGz+NWDHqUY1omXptGRdYvijv+5hZm1q9vXs oA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2kj5vkr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 09:26:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18F9Fcr2048634;
        Wed, 15 Sep 2021 09:25:59 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by userp3020.oracle.com with ESMTP id 3b167tbwts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 09:25:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKQH9QI4Bt98TTuApYFdurVFa0TWBm0G/Tn7TqyTJIevSRgtJ8MidmchEuoCyCOKqbGkDuBO1Cy2xPUWg53/aFgiE6CM8UF+rUViFKGC9Rpj1WkIgdpNeVR9YM1slfiS7BmVDVwM9QhQfP87hbzivdWhRu46Cv8WMQslCRrdNJUavzFSDF/gtNbcprHDZMmFbY35BoYkPFU4xIW6UQVmU3Rbp9AKJfc6C7WDhs3cUqpSuWzZcbWwvkcz4oG2xXPsDj3BsCphZi43IN+b1/orWI4TylYuWHVCM3n7vO+/RxLNG/56mgpul4shfkZ1ByJ/xqxvmRdw5E2SzcrYRwy4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=X6wEOqgSrP3ARx0El7bCyLlRJ/7cp0T9pu/cp5qvHpY=;
 b=Bdio17Zkd+XA8+Tk5fq8Hw/2EvuuxIHsbg+eDaP9q52HubHdfU4TJT5c9oxQRcqXihFVYVjnxLNzVWqTcMyofIwdXwP90w7dPQxk8X06pXGnAJS+kgvVyClyORboBDhgz2TmxQMKb49NPehEKJrG6VBzm/KiDiYM7dzmbgZqCtAIRO/w1lIjHOHn4AERdkPSAhYBVWA/ZmP0tTjj291oqXPJyZVZMLMEdtXzCbXZHasr8mCSzvDiB1kt/fgXQYBqYzhrQkIzA3yvniLVo7EMJIS2wk6Om3WNs6HooHKj/wKFB0SK1gQWket0gDay14k2LQ9zAhT0AQYNt8L4B0sPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6wEOqgSrP3ARx0El7bCyLlRJ/7cp0T9pu/cp5qvHpY=;
 b=IS2pSz1sWipkDNTlDfKHrv1VOgZSdvBeDn6VZoBSeMMHJbe0DM/REEf20UP9ZvvVA8eYfNuwkKGGI/R5ZCMAKfZKJ5JTlOqWqL156tO5i3jbvQaZhQgEqyDKzqTzKBt96SbWX+lblKc27xDO5e4wJmtY6rwjMmOKazRYbacHp/o=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4706.namprd10.prod.outlook.com
 (2603:10b6:303:9d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 09:25:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 09:25:57 +0000
Date:   Wed, 15 Sep 2021 12:25:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: RFCOMM: Replace use of memcpy_from_msg with
 bt_skb_sendmmsg
Message-ID: <20210915092546.GA4603@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0144.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0144.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 15 Sep 2021 09:25:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a128879-febe-409c-d8a7-08d9782ad309
X-MS-TrafficTypeDiagnostic: CO1PR10MB4706:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB470670966495AE9B31352CF28EDB9@CO1PR10MB4706.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xbQe1zhdGDP10SdyFGlclfp6uRoyQyVhU/DaG1s6nAv0DsfYqzDO7uX1t4JkplKoKLoK+Ivn92Svy+VYetwkL4qgX6W1yO/CBEvpxOQE5awx1XPJvswJrbDs+6S52rgVJLWmgd4ezA+wJmx3wx/rKK+79ssTyxxztXzFW9QzPxDDSPFY7zFCjV53jGOuAzJj/N22uSd1eTqTJsRNBAEiBxns/KiNLCi8MQiLrgiwsOfj7cCjaJwWRgeknlMupbicQ6glNDVFESMq9sL2mjD8CqftwdKZMUn1RFXZzPiU9b2B6JMH6t05ap27ibcMvUxJLEv0GnOHlfF8DW6ZGcVLyMI9mY8+yZnO6IlYoX4RKW5whIDVtlL9Hv45b7EzzGFQK6FLpfV4RRVdnKGHJY1H/y/jPV21UauVf62VArhknfaUZu8ymTmq9YezMojVn+mpv69sMgf6fbHQ0BIj4v5hMvI/izLmT6NXkfJxTfATI+cQqLwmVCekGtNBCNycaraSsrlR1QXXaJFAfEnDU+fAkyAyNs+tNa0YuYbp3W+Rj6xLpkXryAI6wRR099laDNCPnrnMyTNmAJkWz2VVYDV/OK26wEii28rw5VeLZDHmZ4xAdsl2Vh7ewEhRvQI2jjRx/PozrXwXLG1GWhvEPqrHjeGP+7K+EALERbRtE9siBpdpCfDcQiTGa8rA+s/xm/fh1acG4KcXvjjsaRXNa5JGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(136003)(346002)(376002)(316002)(9686003)(55016002)(6496006)(6916009)(4326008)(5660300002)(1076003)(86362001)(33716001)(478600001)(6666004)(2906002)(66476007)(66556008)(66946007)(83380400001)(956004)(26005)(8676002)(186003)(33656002)(52116002)(8936002)(38350700002)(38100700002)(44832011)(9576002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5O98AKN8jyV+vbj08hMnEkTW7iYqv6uB1og5NGlKG1ldbk591BQABbxHxmbq?=
 =?us-ascii?Q?dK9rGn08rcg0pF9rk59FJBeINIHEX7VnpCXDEN1aSRQ+HDd7Dfq6TOBJQIxu?=
 =?us-ascii?Q?ke1Ima3vRUq8Kyb13FYC/S0gpwVdBVs8NOjHcW7cciPP/GWX8LHUx2Cngu7f?=
 =?us-ascii?Q?qPXEV8ghGMb0QiiNsSONVAQychzfjJokXjGTYxuo8iB/edIvtfIWvM5cTOFe?=
 =?us-ascii?Q?Z/COZIg74zdaDr7wBddulaEynC576wtMSDuSWZ3lHWYVYK+/s9aIAdW1t6dY?=
 =?us-ascii?Q?9HXGB7lw4VWn/EoVeGcNPoesQMtuRXhJy4NLdsDOArjHdaFa4jINOsTfh8Hh?=
 =?us-ascii?Q?EKL9B3Qk3BCPW3nb5c7fRiNCkm+2y5ZoCG5U4hLW8kTQx6hvpKmy0jSdeH4u?=
 =?us-ascii?Q?OBLcI1FM61rN9JMrNqcJoCgTMVHrwmWTQymxFu3P7OQVP2YjNyHTX+qOmpMz?=
 =?us-ascii?Q?3C630HVitpY4ANAELBcqozGeDyZBIijTTK3XitC4lKiFddJ/sMTMn9VJFSZh?=
 =?us-ascii?Q?DKwLAdbjrz7lYu+Ssy0uI8bQpSEMmPd+BMweNGDCH65snlUmrS1QIqQmtR6X?=
 =?us-ascii?Q?fII2nObEFaHxBaizUeDrTE7f3CLaizs+owIUNNEDR27XF6xOXyArITOg7e+r?=
 =?us-ascii?Q?AhWJkdsSh1iZ0Iwz379kD5HN5GhGyuvGnqom/su2NoQGy8+M35dHChHFLvdw?=
 =?us-ascii?Q?rsMSbzI0lxNYGRFjtQqyMW8oLsOnOr1Xah9hVaC6umPIlqJEACM0/SSk0X2l?=
 =?us-ascii?Q?p8AKC2NzC3Ivj5TPghql8RXrelEtI8LA/hRdenZ+6eYZsN7ChQzQOmRq9Qdl?=
 =?us-ascii?Q?3YAaDhl2Oz+y9HaGrMWhVC2IC87ggKb3h1mRd0LG5luqfpy0SijQ232BRrQq?=
 =?us-ascii?Q?GuhMH+sK6E4gPsJ0PYNVUhItOgSZW5mytChMglId8R+uWrtf5rYXM8fOdH2M?=
 =?us-ascii?Q?KeOmPSe72+79ii2RjgDY6W7D8UQ3buAgLUdlpmdagBK8D6DTQznZoS5flqPX?=
 =?us-ascii?Q?EC87Z3DAkKNs02WZxjwnK+f/Icd6WkxIFhWMff7vi2v/kGroxvEIW0+BIEeN?=
 =?us-ascii?Q?UNsTfI1dM3gVucwUHxctkUhTwxMdl+kkC4Q6l4nOgJvpdZYfhWRRepFZaWeA?=
 =?us-ascii?Q?WKuVNWpK6/nbSP8sXCbTDRzS15A8XuTpq9AJJYDhH3OxOqbAifCU8jVAl6oZ?=
 =?us-ascii?Q?b9QBNKuolqdnueqyrgawoyFfC0qWjQHkxeWOTHuMRgpy5gi4M0EZ14oEb3N3?=
 =?us-ascii?Q?8b/mzSUuMHgzkofJiqfh6u4ei+aC86THwH/6HaxuNSm1afQPF5mzgXfzUaMY?=
 =?us-ascii?Q?6CWUIkYucBbrGA5UkNVIrXs6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a128879-febe-409c-d8a7-08d9782ad309
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 09:25:57.7701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oNU+ffSf4odK1uRdlFSXCRzsRAGzx9B7Y+lTnPFoPOzQtLetbfRF+CbUuIdQxnGiT1aNjgY9WnuWkrQ4kp0LB/fWYRgXuzgg5o5BHEmpws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4706
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=917 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109150060
X-Proofpoint-ORIG-GUID: _40gz13rWLEjNWLQR2ct7VfFnlZ7FjJC
X-Proofpoint-GUID: _40gz13rWLEjNWLQR2ct7VfFnlZ7FjJC
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz Augusto von Dentz,

The patch 81be03e026dc: "Bluetooth: RFCOMM: Replace use of
memcpy_from_msg with bt_skb_sendmmsg" from Sep 3, 2021, leads to the
following
Smatch static checker warning:

	net/bluetooth/rfcomm/sock.c:587 rfcomm_sock_sendmsg()
	warn: passing zero to 'PTR_ERR'

net/bluetooth/rfcomm/sock.c
    556 static int rfcomm_sock_sendmsg(struct socket *sock, struct msghdr *msg,
    557                                size_t len)
    558 {
    559         struct sock *sk = sock->sk;
    560         struct rfcomm_dlc *d = rfcomm_pi(sk)->dlc;
    561         struct sk_buff *skb;
    562         int sent;
    563 
    564         if (test_bit(RFCOMM_DEFER_SETUP, &d->flags))
    565                 return -ENOTCONN;
    566 
    567         if (msg->msg_flags & MSG_OOB)
    568                 return -EOPNOTSUPP;
    569 
    570         if (sk->sk_shutdown & SEND_SHUTDOWN)
    571                 return -EPIPE;
    572 
    573         BT_DBG("sock %p, sk %p", sock, sk);
    574 
    575         lock_sock(sk);
    576 
    577         sent = bt_sock_wait_ready(sk, msg->msg_flags);
    578 
    579         release_sock(sk);
    580 
    581         if (sent)
    582                 return sent;
    583 
    584         skb = bt_skb_sendmmsg(sk, msg, len, d->mtu, RFCOMM_SKB_HEAD_RESERVE,
    585                               RFCOMM_SKB_TAIL_RESERVE);
    586         if (IS_ERR_OR_NULL(skb))

When a function returns both error pointers and NULL then that means
the feature is optional and can be turned off by the user.

	blinking_lights = get_blinking_lights();

We should report the error to the user.

	if (IS_ERR(blinking_lights))
		return PTR_ERR(blinking_lights);

However, some users maybe want a smaller kernel with no blinking lights
so they disable it.  In that case the driver has to check for NULL, and
not print an error message but instead continue as best as possible
without that feature enabled.

The bt_skb_sendmmsg() cannot return NULL.  But if it did return NULL
then PTR_ERR(NULL) is success so that's not right...  All the callers
of bt_skb_sendmmsg() have the same issue.

--> 587                 return PTR_ERR(skb);
    588 
    589         sent = rfcomm_dlc_send(d, skb);
    590         if (sent < 0)
    591                 kfree_skb(skb);
    592 
    593         return sent;
    594 }

regards,
dan carpenter
