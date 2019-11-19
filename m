Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9796EC432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 06:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69ADE21852
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 06:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ng0Vfa6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKSGRa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:17:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57092 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfKSGRa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 01:17:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ69EE9164663;
        Tue, 19 Nov 2019 06:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=xoL2OE7J9dozOOz6fSfhOItWDwzPKZ6B7LsDWEpIpYI=;
 b=ng0Vfa6/ccyn0uFHVXpfIBPcN9MLqGT7OySCmSONw5RUUWr6t2q5opTukxedcT4SwT+g
 LN5AyVjlTzmvhx1ZQJJTe0DGP0v9+aiBC+nwJ7TNMIRZNdfQUvrJIMAd2EldA+fSDvXd
 DGLcFujjwwG1KfLWiZ16+cm54XtmWWvEDUVJX5lS8rvxT9He0EtxLgw1WB/pKWGIBhDP
 QYGZqlLn6k61nLSR48GrLjrdPoT7lduQCzZzRk5TvCsfAL4XyZCYZa3Ai1wKDq4LZfi4
 AJ8Q8FDMi20VpeT+tOT3csKAPyId0FCGIh7JPbSZ2p9GO02vsUzb6R43ShUdWctxazhf lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wa8htmsy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 06:17:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ68XQr074398;
        Tue, 19 Nov 2019 06:17:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wbxged8fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 06:17:21 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAJ6HFOx028859;
        Tue, 19 Nov 2019 06:17:15 GMT
Received: from kili.mountain (/41.210.141.188)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 22:17:14 -0800
Date:   Tue, 19 Nov 2019 09:17:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: delete a stray unlock
Message-ID: <20191119053710.eflgllzyoyglrrj7@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190057
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We used to take a lock in amp_physical_cfm() but then we moved it to
the caller function.  Unfortunately the unlock on this error path was
overlooked so it leads to a double unlock.

Fixes: a514b17fab51 ("Bluetooth: Refactor locking in amp_physical_cfm")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/bluetooth/l2cap_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index da7fdbdf9c41..a845786258a0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4936,10 +4936,8 @@ void __l2cap_physical_cfm(struct l2cap_chan *chan, int result)
 	BT_DBG("chan %p, result %d, local_amp_id %d, remote_amp_id %d",
 	       chan, result, local_amp_id, remote_amp_id);
 
-	if (chan->state == BT_DISCONN || chan->state == BT_CLOSED) {
-		l2cap_chan_unlock(chan);
+	if (chan->state == BT_DISCONN || chan->state == BT_CLOSED)
 		return;
-	}
 
 	if (chan->state != BT_CONNECTED) {
 		l2cap_do_create(chan, result, local_amp_id, remote_amp_id);
-- 
2.11.0

