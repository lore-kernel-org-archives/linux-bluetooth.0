Return-Path: <SRS0=YUNQ=SD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771A2C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Apr 2019 06:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EA320879
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Apr 2019 06:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bBwd29T8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbfDAGcn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:32:43 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49358 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDAGcn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Apr 2019 02:32:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x316T2aw152891;
        Mon, 1 Apr 2019 06:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=b6nY0qXTKp5TMcADTjsV6qwhE0+Y0LYE+D5VHdUnw+E=;
 b=bBwd29T8TJG6TGhC5japWlvKt4YeSz7W2lJQFj62iI6E8/XyKhpcKWpGUOpgmDm8v2n6
 8cm+yP2ApOJEN+ivXXdT+dvx6P6wQXnQ7zqV37RzAXeKP5Aafdi8hEaEzNDfTwRLihJn
 RTwK236bp9LXmB8RZdFslg5Md+FGtS3JP2ozl4be/lgqBbfQpZ8LWOH3tXkheTNd2GVp
 sB7OrjwFCjzwgBqPQwoOdtcAc4VEkVig4LhCquznX/f7S/lQ+QMUT9Wui5LWbabAthfD
 3fPjtRpRmheRe6RYhru9IlPcNK8UVpJiCKAtjZbdZaihjS7OBwPPwOXh7qgiJKepxW+1 Gg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2rhwycw1ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Apr 2019 06:32:37 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x316Wam1029782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 06:32:36 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x316WYVp004956;
        Mon, 1 Apr 2019 06:32:34 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 31 Mar 2019 23:32:33 -0700
Date:   Mon, 1 Apr 2019 09:32:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_event: potential out of bounds parsing
 ADV events
Message-ID: <20190401063215.GC32590@kadam>
References: <20190330072511.GA5502@kadam>
 <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
 <b2a2b63a-c5f0-5d03-7516-668df6049c95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2a2b63a-c5f0-5d03-7516-668df6049c95@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9213 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904010048
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, Mar 30, 2019 at 11:44:29PM +0100, Tomas Bortoli wrote:
> Hi,
> 
> sorry for the multiple emails but I have checked again the code and
> looks like process_adv_report() reads from ev->data for a size of
> ev->length.
> 
> I attach a patch that applies the bound check to both
> hci_le_ext_adv_report_evt() and hci_le_adv_report_evt().
> 

You're right that both need to be fixed.

> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 609fd6871c5a..275926e0753e 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5345,6 +5345,7 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>  	u8 num_reports = skb->data[0];
>  	void *ptr = &skb->data[1];
> +	u8 *end = &skb->data[skb->len - 1];
                             ^^^^^^^^^^^^
>  
>  	hci_dev_lock(hdev);
>  
> @@ -5352,6 +5353,9 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  		struct hci_ev_le_advertising_info *ev = ptr;
>  		s8 rssi;
>  
> +		if (ev->data + ev->length > end)

No, this isn't right.  You've removed the + 1 and you've introduced an
additional "sbk->len - 1" so we're off by two...  The test is supposed
to be:

	start + length_read > start + length_of_buffer

So the end has to be &skb->data[skb->len].  The "+ 1" comes from later
in the function when we do:

		ptr += sizeof(*ev) + ev->length + 1;
                                               ^^^^

I don't where the "+ 1" comes from, but I know the condition and the
increment should match.  We could use ev->data instead of
"ptr + sizeof(*ev)" but to me, because the mysterious "+ 1" then it
seems more readable to match the increment exactly...

regards,
dan carpenter

