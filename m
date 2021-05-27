Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B892C47089
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 16:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1AE613B6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 16:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbhE0Qwo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 May 2021 12:52:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31208 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229829AbhE0Qwn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 May 2021 12:52:43 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14RGp59K016382;
        Thu, 27 May 2021 16:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=t8U3y+BEnwMR9Nm4f3rMEIoCwU2ABG1SRbM2gHAUH68=;
 b=FSu78usnjSeXTsQk3WGKa48m0fzZXREaCz0V5aBGkYSy/OpZPl2OMI7EBDizXqSGK9QK
 aZwGc5++S0QQ9D2fBLoCsgIIxwALGKKx0ZtpsJnqlgW11PO8InMkXj823fULrsWMXjsq
 ZnASqyAB2t+VG7mi3dkIiLzpSypaNNRpHkaFkriEUoW3R2Pq/UltAUKKm0ZYr7uAR/Uw
 o+vZdcG5am0NJEVPQJau1Ws04V/jWR1NmnTFrQGkyYB/QH6Z2vPrQ88bOls8qReVyvLW
 xIZXNzNwzajg67+nvXWGO7NToY2KVekKjbFG88hYIXLxO/MqU+1HXuVrbh17PFjYDYKe Mg== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38smut0jbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 16:51:05 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14RGp4AI090090;
        Thu, 27 May 2021 16:51:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38rehh0k8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 16:51:04 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14RGo3Vu080058;
        Thu, 27 May 2021 16:50:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 38rehh0gdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 16:50:03 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14RGnRE1019495;
        Thu, 27 May 2021 16:49:27 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 May 2021 09:49:26 -0700
Date:   Thu, 27 May 2021 19:49:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Loic Poulain <loic.poulain@intel.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_intel: prevent reads beyond the end of
 skb->data
Message-ID: <20210527164919.GP24442@kadam>
References: <YK+Yo6c1UuiACSZA@mwanda>
 <ED41E619-3AC3-41B4-AC59-004ED6446537@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ED41E619-3AC3-41B4-AC59-004ED6446537@holtmann.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: OQjlczKUMkWKu4yc3uyjwZt1i1l4Sjp9
X-Proofpoint-GUID: OQjlczKUMkWKu4yc3uyjwZt1i1l4Sjp9
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, May 27, 2021 at 05:19:04PM +0200, Marcel Holtmann wrote:
> Hi Dan,
> 
> > There doesn't appear to be any checks to ensure that skb->data is large
> > enough in these functions.  For most of these, if we specify a header
> > length, then h4_recv_buf() will ensure that all packets are at least the
> > minimum length.  The intel_recv_lpm() function needs an additional
> > check for LPM_OP_TX_NOTIFY packets.
> > 
> > Fixes: ca93cee5a56e ("Bluetooth: hci_uart: Add basic support for Intel Lightning Peak devices")
> > 
> > No signed-off-by because I can't test this and just wanted to collect
> > feedback.  This is part of a static checker warning because someone
> > reported the hci_event.c read overflows to security@kernel.org.  This
> > stuff is quite complicated for static checkers of course and I don't
> > understand all the rules yet.  Right now I have about 2000 warnings
> > that look like this:
> > 
> > drivers/bluetooth/hci_intel.c:877 intel_recv_event() warn: assignment assumes 'skb->len' is '2' bytes
> > drivers/bluetooth/hci_intel.c:922 intel_recv_lpm() warn: assignment assumes 'skb->len' is '2' bytes
> > drivers/bluetooth/hci_intel.c:1028 intel_dequeue() warn: assignment assumes 'skb->len' is '3' bytes
> 
> I think it will be hard to find people with this hardware. LnP devices are rare, but maybe someone will speak up here.
> 

It's easier to fix all the bugs than it is to try figure out if anyone
has the hardware.  Plus if no one has the hardware then I will get the
credit for fixing a security bug with none of the risk of breaking
someone's system.  ;)

[ snip ]

> > +	{ H4_RECV_ACL,    .recv = hci_recv_frame, .hlen = sizeof(struct bt_skb_cb) },
> > +	{ H4_RECV_SCO,    .recv = hci_recv_frame, .hlen = sizeof(struct bt_skb_cb) },
> > +	{ H4_RECV_EVENT,  .recv = intel_recv_event, .hlen = sizeof(struct hci_event_hdr) },
> > +	{ INTEL_RECV_LPM, .recv = intel_recv_lpm, .hlen = sizeof(struct hci_lpm_pkt) },
> 
> This part I do not understand, all the H4_RECV_* and even INTEL_RECV_* provide the hlen. So I have no idea what your change is doing here. And the two for H4_RECV_{ACL,SCO} are actually wrong. In case you wonder this is how they are defined:
> 
> #define H4_RECV_ACL \
>         .type = HCI_ACLDATA_PKT, \
>         .hlen = HCI_ACL_HDR_SIZE, \
>         .loff = 2, \
>         .lsize = 2, \
>         .maxlen = HCI_MAX_FRAME_SIZE \
> 
> #define H4_RECV_SCO \
>         .type = HCI_SCODATA_PKT, \
>         .hlen = HCI_SCO_HDR_SIZE, \
>         .loff = 2, \
>         .lsize = 1, \
>         .maxlen = HCI_MAX_SCO_SIZE
> 
> #define H4_RECV_EVENT \
>         .type = HCI_EVENT_PKT, \
>         .hlen = HCI_EVENT_HDR_SIZE, \
>         .loff = 1, \
>         .lsize = 1, \
>         .maxlen = HCI_MAX_EVENT_SIZE

Oh...  Crap...  I've been banging my head into the wall trying to figure
out why I couldn't make Smatch generate a warning for this.  But now
when I remove the macro it does.

drivers/bluetooth/hci_intel.c:961 (null)() struct member not set 'intel_recv_pkts[0]->hlen'

It's embarrassing how long I have spend trying to figure out why it
said it was already initialized to non-zero...

regards,
dan carpenter

