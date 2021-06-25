Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC875C49EA7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jun 2021 15:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9234661864
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jun 2021 15:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhFYPCx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Jun 2021 11:02:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17078 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhFYPCw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Jun 2021 11:02:52 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PEunDr028653;
        Fri, 25 Jun 2021 15:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=R3UUkLIxm/AmMV3IJTJTXNwAbhgOyICacczkE14XPLg=;
 b=stvEjRtLt+e+OfddZWLc6TaLgoZdQu13bEAoknNrYDcobYqzTXk3URcUcosIRttQsbrA
 /EnYZ0UXH+pQJTIjW5+cZgeP4r1oB6CkAqtgn0RqulOFIaG1sdbcN3/L5QU27WGawDyH
 oJBfFgNPzs5ynHswCgGBl9AHuigQe0udS6UU07aF40MbrXnanh44/atHnyayf7SJtwaY
 AgT0yiwEAmW+wqfoc4AsvDK4hHp+rSmny4Pec1kh5oNb3WKLl2vAViDgy15bL5Fc9ZRE
 LrOZZyDnhh4Z26ismo1JXv3wrtKv32BSWNsiLC58J1aMfpSGKeBSBm1LjEZvkpYJjnUA ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d27esjkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 15:00:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15PEtNo6019143;
        Fri, 25 Jun 2021 15:00:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 39d23y7d84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 15:00:22 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15PEwP8o031787;
        Fri, 25 Jun 2021 15:00:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 39d23y7d5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 15:00:22 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15PF0Gjh027858;
        Fri, 25 Jun 2021 15:00:16 GMT
Received: from mwanda (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jun 2021 08:00:16 -0700
Date:   Fri, 25 Jun 2021 18:00:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau 
        <frederic.dalleau@linux.intel.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: sco: prevent information leak in
 sco_conn_defer_accept()
Message-ID: <YNXveZZwzS3crmHH@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: e15vRjHMF6J31MkXcwjM9L_eBo_jMSUG
X-Proofpoint-ORIG-GUID: e15vRjHMF6J31MkXcwjM9L_eBo_jMSUG
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Smatch complains that some of these struct members are not initialized
leading to a stack information disclosure:

    net/bluetooth/sco.c:778 sco_conn_defer_accept() warn:
    check that 'cp.retrans_effort' doesn't leak information

This seems like a valid warning.  I've added a default case to fix
this issue.  It's sort of unusual to have case SCO_AIRMODE_CVSD,
followed by a default case but I think it's nicely readable.  :)

Fixes: 2f69a82acf6f ("Bluetooth: Use voice setting in deferred SCO connection request")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/bluetooth/sco.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index d9a4e88dacbb..e2ee00fea64b 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -770,6 +770,7 @@ static void sco_conn_defer_accept(struct hci_conn *conn, u16 setting)
 			cp.retrans_effort = 0x02;
 			break;
 		case SCO_AIRMODE_CVSD:
+		default:
 			cp.max_latency = cpu_to_le16(0xffff);
 			cp.retrans_effort = 0xff;
 			break;
-- 
2.30.2

