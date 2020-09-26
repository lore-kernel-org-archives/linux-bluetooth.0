Return-Path: <SRS0=G13S=DD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C3AC4727F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 07:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1E62083B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 07:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgIZHqy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Sep 2020 03:46:54 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38708 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIZHqy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Sep 2020 03:46:54 -0400
Received: from [172.20.10.2] (dynamic-046-114-136-219.46.114.pool.telefonica.de [46.114.136.219])
        by mail.holtmann.org (Postfix) with ESMTPSA id 52A45CECE8;
        Sat, 26 Sep 2020 09:53:50 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [Linux-kernel-mentees] [PATCH] Fix uninit-value in
 hci_chan_lookup_handle
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200905020410.20350-1-anant.thazhemadam@gmail.com>
Date:   Sat, 26 Sep 2020 09:46:49 +0200
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2AEF86AF-8F80-4B01-B506-D2ABC654DBC7@holtmann.org>
References: <20200905020410.20350-1-anant.thazhemadam@gmail.com>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Anant,

> When the amount of data stored in the location corresponding to
> iov_iter *from is less then 4, some data seems to go uninitialized.
> 
> Updating this condition accordingly, makes sense both intuitively and 
> logically as well, since the other check for extreme condition done is if
> len > HCI_MAX_FRAME_SIZE, which is HCI_MAX_ACL_SIZE (which is 1024) + 4;
> which itself gives some idea about what must be the ideal mininum size.
> 
> Reported-and-tested by: syzbot+4c14a8f574461e1c3659@syzkaller.appspotmail.com
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
> If there is some explicit reason why len < 4 doesn't work, and only len < 2 works, 
> please do let me know.
> The commit message that introduced the initial change 
> (512b2268156a4e15ebf897f9a883bdee153a54b7) wasn't exactly very helpful in this 
> respect, and I couldn't find a whole lot of discussion regarding this either.
> 
> drivers/bluetooth/hci_vhci.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 8ab26dec5f6e..0c49821d7b98 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -159,7 +159,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
> 	__u8 pkt_type, opcode;
> 	int ret;
> 
> -	if (len < 2 || len > HCI_MAX_FRAME_SIZE)
> +	if (len < 4 || len > HCI_MAX_FRAME_SIZE)
> 		return -EINVAL;

so the minimum requirement is to have an 1 octet packet indicator. If some other functions are missing length checks, then it should be fixed there. I see that in case of HCI_VENDOR_PKT we need to check for the 2nd octet to be present, but I have no idea why you require 3 octets minimum. As I said, if so, then the other functions that get called require proper range checks.

Regards

Marcel

