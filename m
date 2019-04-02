Return-Path: <SRS0=lHyt=SE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECDAC4360F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Apr 2019 06:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C029206B7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Apr 2019 06:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kD6HB1o+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfDBGdf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:33:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45630 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbfDBGde (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Apr 2019 02:33:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x326TIWW148994;
        Tue, 2 Apr 2019 06:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=7jOgfn2qKtOuuuan1pqqX1geHTsoT5f5/MIB0r9bWpE=;
 b=kD6HB1o+W+nH9ll4h5Yzat8lmVQr6HMc6jtKz9XvCGwT8H5+4nwOAMEi4iD7t0QjOPj1
 ztr9ouri+C+y9SjkyZCQsPAXuZ68PsYv1Ib/2Zb2QPEFB+eWCg+Bhhx3NBAQjOVwscbR
 69XsR8nO9pdmyXB0FgsIy6gx8/XOTo9OPkq5wAYPKKWL9YRoIgZkOk44zCoo5TrUW0CS
 +HNzXcZvYkvZTwiBX6sI2C5eO+HgjeHnldEF5vq9IDqVaxXwlRw0YVdtiQIgEziYGRCR
 yXofdqcAmVDHIT7AlyX2fCFFfyU3RK4z9sNAt/1U3QbPYODGC+hQm+7sYgWHJrrtxksy 5w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2rj13q2yne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 06:33:27 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x326XPTp021739
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 06:33:27 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x326XN5J022385;
        Tue, 2 Apr 2019 06:33:23 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Apr 2019 23:33:23 -0700
Date:   Tue, 2 Apr 2019 09:33:14 +0300
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
Message-ID: <20190402063313.GA32613@kadam>
References: <20190330072511.GA5502@kadam>
 <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
 <CAM_iQpVNqyoBirtKg-rbOHsOZCZ0Oz5PTE2sFQnHQnv6s7g2gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpVNqyoBirtKg-rbOHsOZCZ0Oz5PTE2sFQnHQnv6s7g2gg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9214 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904020047
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Apr 01, 2019 at 11:03:53AM -0700, Cong Wang wrote:
> Hi,
> 
> On Sat, Mar 30, 2019 at 2:23 AM Tomas Bortoli <tomasbortoli@gmail.com> wrote:
> >
> > Hi Dan,
> >
> > On 3/30/19 8:25 AM, Dan Carpenter wrote:
> > > There is a potential out of bounds if "ev->length" is too high or if the
> > > number of reports are too many.
> > >
> > > Fixes: c215e9397b00 ("Bluetooth: Process extended ADV report event")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Reviewed-By: Tomas Bortoli <tomasbortoli@gmail.com>
> 
> I sent a patchset to fix all of this kind of OOB:
> https://marc.info/?l=linux-netdev&m=155314874622831&w=2
> 
> Unfortunately I get no response...
> 
> Does any of you mind to look at them?
> 

I don't know the rules...  When is it ok say:

	if (skb->len < sizeof(*ev))
		return;

and when must we say:

	if (!pskb_may_pull(skb, sizeof(*ev)))
		return;

Btw, get rid of all the likely/unlikely() macros.  Then the other style
comment would be don't move the "ev = (void *)skb->data;" assignments
around.  It's ok to say:

	struct hci_ev_pin_code_req *ev = (void *)skb->data;
	struct hci_conn *conn;

	if (!pskb_may_pull(skb, sizeof(*ev)))
		return;

regards,
dan carpenter
