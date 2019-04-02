Return-Path: <SRS0=lHyt=SE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E7CC4360F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Apr 2019 20:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C01E2084B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Apr 2019 20:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tPnZYsZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbfDBUPk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:15:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45362 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfDBUPj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Apr 2019 16:15:39 -0400
X-Greylist: delayed 942 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Apr 2019 16:15:38 EDT
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32KDSss137809;
        Tue, 2 Apr 2019 20:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=sW61JQS+QVZkRFnCR3ma5ITkO/uFFL1hQ8JexoK2Gwo=;
 b=tPnZYsZUndWvABOQtn6Vo8HbTaNPtNsjCepKq/6kEBExQ3lN1XmeEIzS4U2LjPK9PeK3
 5EWTNITzzuM8oJwm5mzNADS47/MgP2pEKUOwVf++UCuJag4MsTX+j0tdQE7Nus/A+Cql
 RigENraEJhqm+sguLGMlNi14iDZ975t989ENLUoi8wVvXdPR4N6mpxr99WtTRbmnJKO6
 RxA/CezrX1y34mf/R1AWhWU8bamTQP6wSyzjE0SF7oBQvpriktU9xlck4TUKXSD55sMy
 fW9IyEnsXZ+eqb/EIM94MFa4EmqhkbTAA1/TrWOR9mzJ7o16vuInkCTP35lMDhhO7tTI Bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2rj0dnksgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 20:15:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32KDLbQ003068;
        Tue, 2 Apr 2019 20:13:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2rm8f4y70p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 20:13:33 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x32KDWDU012652;
        Tue, 2 Apr 2019 20:13:32 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Apr 2019 13:13:31 -0700
Date:   Tue, 2 Apr 2019 23:13:23 +0300
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
Message-ID: <20190402201322.GG32613@kadam>
References: <20190330072511.GA5502@kadam>
 <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
 <CAM_iQpVNqyoBirtKg-rbOHsOZCZ0Oz5PTE2sFQnHQnv6s7g2gg@mail.gmail.com>
 <20190402063313.GA32613@kadam>
 <CAM_iQpW=X2X5A873nSPM7yLBiWZM+rsJk+uMpiOioYPFsFP9vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpW=X2X5A873nSPM7yLBiWZM+rsJk+uMpiOioYPFsFP9vg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904020135
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020135
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Apr 02, 2019 at 10:42:38AM -0700, Cong Wang wrote:
> > Btw, get rid of all the likely/unlikely() macros.  Then the other style
> > comment would be don't move the "ev = (void *)skb->data;" assignments
> > around.  It's ok to say:
> 
> 
> Similarly, pskb_may_pull() may reallocate skb's, although very unlikely
> for bluetooth case (skb's are linear). At least it doesn't harm anything
> we move the skb->data dereference after pskb_may_pull().
> 

It harms readability.

regards,
dan carpenter

