Return-Path: <SRS0=tQl/=SH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412A5C282CE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Apr 2019 20:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1077520989
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Apr 2019 20:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kFCzj+nh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDEUs6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:48:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50044 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfDEUs6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Apr 2019 16:48:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x35KiGXa064862;
        Fri, 5 Apr 2019 20:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=3xnhVRnSMvD3Mn5e4IS3FiYW7w8C19AdFedu5dOHHDc=;
 b=kFCzj+nhrYThtGD+QCIxmmbQMyQGOKXIjlDG8t0QopBf6ogVlei0BhDFR3/MKgVjp+Kb
 KW29zSn/UqnBmebqMlHKAgfp7Ozq2XxlIgJ6NpcxuggHz7EFSKFttLC3D6TBRM40VNjR
 Ie6SGigd5fywr09YjNoIRog1OUs6B31z6O1Yimv3LLKEWRYSWSH/vgXw203oynGVozr2
 nCffx0eCpWoCWXCBIRjsXxC1DaMipTEUGiz3s2QWOr2Lo1mUnoOP0kKyjRnE96xZnlS4
 k7CswU0Cvo+e2Wc9UO546uIxj18awXnCXTGETdc4x6yuAppMIRLbhGimqqqgXLDhAcjo 0w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2rhyvtpywd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 20:48:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x35KmJno015339;
        Fri, 5 Apr 2019 20:48:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2rp357ttm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 20:48:52 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x35KmlRx005736;
        Fri, 5 Apr 2019 20:48:47 GMT
Received: from kadam (/41.202.241.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Apr 2019 13:48:47 -0700
Date:   Fri, 5 Apr 2019 23:48:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_event: potential out of bounds parsing
 ADV events
Message-ID: <20190405204838.GR32590@kadam>
References: <20190330072511.GA5502@kadam>
 <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
 <CAM_iQpVNqyoBirtKg-rbOHsOZCZ0Oz5PTE2sFQnHQnv6s7g2gg@mail.gmail.com>
 <20190402063313.GA32613@kadam>
 <CAM_iQpW=X2X5A873nSPM7yLBiWZM+rsJk+uMpiOioYPFsFP9vg@mail.gmail.com>
 <20190402195537.GF32613@kadam>
 <CAM_iQpU2qwezhk8XdnX+kvUi8Oi0mwNxRuFOo8uGvjZaPZGNWA@mail.gmail.com>
 <20190404080627.GG32590@kadam>
 <CAM_iQpXLoSU5f4tGtwDt9=+AQ==4CfYhnxcOmKkmvB+Yd0KNfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpXLoSU5f4tGtwDt9=+AQ==4CfYhnxcOmKkmvB+Yd0KNfw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=928
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904050138
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=961 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904050138
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


I'm don't have a lot of time for these discussions.  The object code is
exactly the same regardless of whether you add the annotations or not.

32c307d27583a624baa3a24eec00402e  net/bluetooth/hci_event.o.no_annotation
32c307d27583a624baa3a24eec00402e  net/bluetooth/hci_event.o.w_annotation

regards,
dan carpenter

