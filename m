Return-Path: <SRS0=YUNQ=SD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3EDC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Apr 2019 17:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8955F20883
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Apr 2019 17:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DqqwvKgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388086AbfDARmV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:42:21 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54832 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbfDARmU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Apr 2019 13:42:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x31HdgYj160268;
        Mon, 1 Apr 2019 17:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ZnNEGANaS3UkYUP95TUbi7QxD6Djpb0+uEyWb6YjXyw=;
 b=DqqwvKgfzXaiiay9u2Dj3zj6j15fxI613wqMEGUFqrDpqtkx3vfJxi5jHcZjRaS4DVog
 pXFB/qRUAy4uJ1iFJtfKwho+wM8AL0i8UoY9tFEZFTxiWw+fCgcIcneaJWVtRAH673ax
 5us0nJfX7apOgTFCNToJ5moYSHKl66c3VVGU5UXfnrWDdHhhC6JZULH3CZkUcx4EHbYR
 wnhG5SahVQPwnm27IMrbw7HrKD6wlYll10i39CvlxxQS8HWV+0BlYr+Ale+uC6e2qhp2
 A3SCGQcEES5TEcwAN78lXTm65LpNpv7jNzEQWUYeqH/Jowj4LwICPsiG1bFECEa5rqZc rA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2rhwyd0nnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Apr 2019 17:42:13 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x31HgCAT020299
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 17:42:13 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x31Hg9Vl002197;
        Mon, 1 Apr 2019 17:42:09 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Apr 2019 10:42:08 -0700
Date:   Mon, 1 Apr 2019 20:41:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_event: potential out of bounds parsing
 ADV events
Message-ID: <20190401174156.GZ32613@kadam>
References: <20190330072511.GA5502@kadam>
 <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
 <b2a2b63a-c5f0-5d03-7516-668df6049c95@gmail.com>
 <20190401063215.GC32590@kadam>
 <d1b5afe2-8760-55eb-8b6f-28c31b3c3658@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1b5afe2-8760-55eb-8b6f-28c31b3c3658@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9214 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904010116
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Apr 01, 2019 at 07:24:47PM +0200, Tomas Bortoli wrote:
> On 4/1/19 8:32 AM, Dan Carpenter wrote:
> > On Sat, Mar 30, 2019 at 11:44:29PM +0100, Tomas Bortoli wrote:
> >> Hi,
> >>
> >> sorry for the multiple emails but I have checked again the code and
> >> looks like process_adv_report() reads from ev->data for a size of
> >> ev->length.
> >>
> >> I attach a patch that applies the bound check to both
> >> hci_le_ext_adv_report_evt() and hci_le_adv_report_evt().
> >>
> > 
> > You're right that both need to be fixed.
> > 
> >> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >> index 609fd6871c5a..275926e0753e 100644
> >> --- a/net/bluetooth/hci_event.c
> >> +++ b/net/bluetooth/hci_event.c
> >> @@ -5345,6 +5345,7 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
> >>  {
> >>  	u8 num_reports = skb->data[0];
> >>  	void *ptr = &skb->data[1];
> >> +	u8 *end = &skb->data[skb->len - 1];
> >                              ^^^^^^^^^^^^
> >>  
> >>  	hci_dev_lock(hdev);
> >>  
> >> @@ -5352,6 +5353,9 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
> >>  		struct hci_ev_le_advertising_info *ev = ptr;
> >>  		s8 rssi;
> >>  
> >> +		if (ev->data + ev->length > end)
> > 
> > No, this isn't right.  You've removed the + 1 and you've introduced an
> > additional "sbk->len - 1" so we're off by two...  The test is supposed
> > to be:
> > 
> > 	start + length_read > start + length_of_buffer
> > 
> 
> afaict: ev->data = start and length_read = ev->length
> and the right side of the condition is the upper limit. "end" as defined
> in my patch is the last readable byte of skb->data (or am I wrong on
> this too?)
> 

You have:

	ptr + length > &skb->data[skb->len - 1];

Imagine we "ptr = &skb->data[skb->len - 1]" that means we can read one
more byte.  But in that case "if (ptr + 1 > &skb->data[skb->len - 1])"
is true so we break instead of allowing the read.  Idiomatically > is
for length and >= is for indexes...

Btw, unrelated but in hci_le_adv_report_evt() if we hit the
HCI_MAX_AD_LENGTH condition we should just break as well.  Everything
after that is going to be guess work and garbage.  No point in trying to
parse it.  IOW:

		if (ptr + sizeof(*ev) + ev->length + 1 > end ||
		    ev->length > HCI_MAX_AD_LENGTH)
			break;

I was planning to resend my patch and the fixes to hci_le_adv_report_evt()
with your Reported-by tonight as two separate patches.  It just makes it
easier to backport if we have a different Fixes tag for both functions.
But then I decided to wait until tomorrow to see if anyone knew what the
+ 1 was about...

regards,
dan carpenter
 
