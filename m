Return-Path: <SRS0=7owS=SG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC1DC4360F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Apr 2019 06:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F852147C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Apr 2019 06:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3Do1IMXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfDDGfm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:35:42 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42422 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDDGfl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Apr 2019 02:35:41 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x346YW7W177464;
        Thu, 4 Apr 2019 06:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=hI+DrXL8rDYxE0bVyKW6MXyMaZ36TCkmHH2/H/zepas=;
 b=3Do1IMXnWJPnNbTDCUfGAme9LrRgWcdM3Efcc7AK5OTtgOTzRlgJYpA2q1oPEb8CueAw
 TS/qEP8aQAvAwKbIdfwNw1JLoJp0JAHzW5spwQ0C3zdQOBSPa00u2OU48osVUw4rQPuy
 pneAyOQ0vvjdqmiYwUDR7QW2v0LhO/t2XbBe8OAW48a0kuSDkhGqbjCKXo6gZX45HexZ
 DVM9hEWo+xeJ17koKv+49Q5CaknfbWvV+9jE0mnoQ+0aiaYHzkIZk8khS0qwPXWWhBZU
 n1y+cFanlilEvZssoDBAzaEgnlnt65ZZov/JElMPfTMcklE+keTnZTOIQ6wlx/d50HpH 8Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2rhwydd9j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 06:35:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x346XcPp004933;
        Thu, 4 Apr 2019 06:35:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2rm8f6g4ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 06:35:33 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x346ZVZY031025;
        Thu, 4 Apr 2019 06:35:31 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Apr 2019 23:35:30 -0700
Date:   Thu, 4 Apr 2019 09:35:21 +0300
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
Message-ID: <20190404063521.GF32590@kadam>
References: <20190330072511.GA5502@kadam>
 <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
 <CAM_iQpVNqyoBirtKg-rbOHsOZCZ0Oz5PTE2sFQnHQnv6s7g2gg@mail.gmail.com>
 <20190402063313.GA32613@kadam>
 <CAM_iQpW=X2X5A873nSPM7yLBiWZM+rsJk+uMpiOioYPFsFP9vg@mail.gmail.com>
 <20190402201322.GG32613@kadam>
 <CAM_iQpWjwOwawBN3yiZ0F-B-HDSOW8KGfpLGhAsf5yE0A=wtDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpWjwOwawBN3yiZ0F-B-HDSOW8KGfpLGhAsf5yE0A=wtDA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040046
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904040046
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Apr 03, 2019 at 03:51:18PM -0700, Cong Wang wrote:
> On Tue, Apr 2, 2019 at 1:15 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Tue, Apr 02, 2019 at 10:42:38AM -0700, Cong Wang wrote:
> > > > Btw, get rid of all the likely/unlikely() macros.  Then the other style
> > > > comment would be don't move the "ev = (void *)skb->data;" assignments
> > > > around.  It's ok to say:
> > >
> > >
> > > Similarly, pskb_may_pull() may reallocate skb's, although very unlikely
> > > for bluetooth case (skb's are linear). At least it doesn't harm anything
> > > we move the skb->data dereference after pskb_may_pull().
> > >
> >
> > It harms readability.
> 
> Why? I can't see how it harms readability if you have pskb_may_pull()
> in mind that it potentially reallocates skb->data.

You're making the code more complicated because you're pretending that
we didn't linearize the skb data already...  :/

regards,
dan carpenter
