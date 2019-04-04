Return-Path: <SRS0=7owS=SG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A86C4360F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Apr 2019 08:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61A320882
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Apr 2019 08:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VOLE84aC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfDDIGt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:06:49 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42440 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDIGs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Apr 2019 04:06:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x34843XU053161;
        Thu, 4 Apr 2019 08:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=JQaHQoDTj2RZl8EhL/svxKzZ3ITNZ5Ew2+Hlm1vh/64=;
 b=VOLE84aCU7S2Yqsdeg4ODHSPxAivTpU/0JO95CbzBPb+Tp+HAlW9m3TbssPnJkduVOvZ
 HGNeHdL0DZdCQPr7BqNeiNF+8hI7OtadQvod5rS8oh7vZbOHAveTLPcw8QJn5chk9ThN
 WR6LZuFs9o3e+R6MycbLLD0XguCuKGlRjAiA34OG55nG+IRwrnsp+l67w5APkDxr/Iow
 IB0QJP5gH918B/0bFE/L+lC+aK8/aTWcXjXMWEjsI2vgHBuVSRxPL7aXoaOqxbjMs/cA
 ujL4nPy0133aZsRiihK6XTU4dRR+FsIUjvleelAH9/Xz3eEIc4jTFOOmQuJv+IL8RqT7 sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2rhwyddnn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 08:06:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3485NB3053225;
        Thu, 4 Apr 2019 08:06:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2rm9mjfpcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 08:06:42 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3486ceg004051;
        Thu, 4 Apr 2019 08:06:38 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Apr 2019 01:06:37 -0700
Date:   Thu, 4 Apr 2019 11:06:27 +0300
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
Message-ID: <20190404080627.GG32590@kadam>
References: <20190330072511.GA5502@kadam>
 <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
 <CAM_iQpVNqyoBirtKg-rbOHsOZCZ0Oz5PTE2sFQnHQnv6s7g2gg@mail.gmail.com>
 <20190402063313.GA32613@kadam>
 <CAM_iQpW=X2X5A873nSPM7yLBiWZM+rsJk+uMpiOioYPFsFP9vg@mail.gmail.com>
 <20190402195537.GF32613@kadam>
 <CAM_iQpU2qwezhk8XdnX+kvUi8Oi0mwNxRuFOo8uGvjZaPZGNWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpU2qwezhk8XdnX+kvUi8Oi0mwNxRuFOo8uGvjZaPZGNWA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040058
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904040058
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Apr 03, 2019 at 03:55:20PM -0700, Cong Wang wrote:
> I tried checkpatch.pl, it has no such a complain.

Huh?

I sorry, I must have been very unclear if you're asking about
checkpatch.  Checkpatch is a Perl script.  It's basically like grep.  It
has no idea about fast paths or benchmarking.  Let me try explain
better.

The likely/unlikely annotations are there to help optimize branch
prediction and make the code run faster.  In the real world if you can't
benchmark or measure or detect a speed improvement then it's not a real
speed improvement.

1) HCI events don't happen often enough to where the speed can be easily
   benchmarked.  In that situation, we just write the code as readably
   as possible instead of trying to micro optimize it.

2) The compiler already does common sense branch prediction.  These
   conditions look straight forward so it probably gets it right.  You
   should take a look at the object code.  The compiler probably gets
   it right.  I bet that these annotations don't even affect the
   compiled code let alone the benchmarking output.

So in this case, we are not adding likely and unlikely for their
intended purpose of improving benchmarks.  I guess we are instead adding
them just for the human readers?  But most people can immediately see
that this is an error path so they don't need the annotations.  In fact
the annotations obscure what the error condition is so they hurt
readability.  Now there are just too many parentheses to keep track of.

	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
		return;

	if (!pskb_may_pull(skb, sizeof(*rp)))
		return;

I know this isn't explained in CodingStyle but some things are
assumed.  In drivers/ about 1.5% of if statements have likely/unlikely
annotations.  It really is not normal to add it to everything willy-nilly
for no reason.

regards,
dan carpenter
