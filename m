Return-Path: <SRS0=5fC3=SF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7DAC10F0B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 05:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB9C21473
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 05:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SvvNTk3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfDCFgm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:36:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42000 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfDCFgm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Apr 2019 01:36:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x335XSMk193046;
        Wed, 3 Apr 2019 05:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=vrkPIXCFFYf0yDJZBlW1mXf2V0iSbvCla+RFhl5+qNE=;
 b=SvvNTk3mRQfLudW8atx0KJzglBMjMMY028yKofdKi3Rm75l/MkJgOof6zy/hUrT0BOFC
 AQChmaMGI9OPfjdbQxvd/eZgPwHDwlKIDDjCQNDbw1yJkSlTAgVxJm3ct0KwAmpUD9ij
 C0fpc9/jBxIOTp/PwH3K4x2+sbgjuWr4KUHOzC59ywGYwMadqDJtjcJSf3puB3ZlPj2i
 izdciV/0T0eSPPL02qKO/PaMQ7IMIlHJ+UPI1snoOs1Lb6yQO6FmzZo1msCokcn5/76H
 BXcERVmlK9qV+1yct21AIPhu2Wj81t30+/bqAlMCqiDEhB60JZ7eguNdQSgwV/hIxujf jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2rj0dnnwx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 05:36:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x335XJWs150182;
        Wed, 3 Apr 2019 05:34:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2rm9mhurgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 05:34:27 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x335YRae002627;
        Wed, 3 Apr 2019 05:34:27 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Apr 2019 22:34:26 -0700
Date:   Wed, 3 Apr 2019 08:34:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexander Aring <alex.aring@gmail.com>
Cc:     Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] 6lowpan: Off by one handling ->nexthdr
Message-ID: <20190403053416.GA21913@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030037
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030037
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

NEXTHDR_MAX is 255.  What happens here is that we take a u8 value
"hdr->nexthdr" from the network and then look it up in
lowpan_nexthdr_nhcs[].  The problem is that if hdr->nexthdr is 0xff then
we read one element beyond the end of the array so the array needs to
be one element larger.

Fixes: 92aa7c65d295 ("6lowpan: add generic nhc layer interface")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This is the only place which uses the NEXTHDR_MAX define, so I considered
changing that to 256 instead.  Either fix would work.

 net/6lowpan/nhc.c  | 2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
index 4fa2fdda174d..9e56fb98f33c 100644
--- a/net/6lowpan/nhc.c
+++ b/net/6lowpan/nhc.c
@@ -18,7 +18,7 @@
 #include "nhc.h"
 
 static struct rb_root rb_root = RB_ROOT;
-static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX];
+static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX + 1];
 static DEFINE_SPINLOCK(lowpan_nhc_lock);
 
 static int lowpan_nhc_insert(struct lowpan_nhc *nhc)
-- 
2.17.1

