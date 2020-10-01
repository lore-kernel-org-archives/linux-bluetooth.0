Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C2DC4727C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 07:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC2521481
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 07:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgJAHI0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 03:08:26 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42456 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAHI0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 03:08:26 -0400
Received: from marcel-macbook.fritz.box (p4fefc7f4.dip0.t-ipconnect.de [79.239.199.244])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8D48ECECD2;
        Thu,  1 Oct 2020 09:15:24 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [Linux-kernel-mentees][PATCH] bluetooth: hci_h5: close serdev
 device and free hu in h5_close
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200929185815.12879-1-anant.thazhemadam@gmail.com>
Date:   Thu, 1 Oct 2020 09:08:24 +0200
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9D145813-A4B8-46AB-A55F-54C4AF82FD19@holtmann.org>
References: <20200929185815.12879-1-anant.thazhemadam@gmail.com>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Anant,

> When h5_close() gets called, the memory allocated for the hu gets 
> freed only if hu->serdev doesn't exist. This leads to a memory leak.
> So when h5_close() is requested, close the serdev device instance and
> free the memory allocated to the hu entirely instead.
> 
> Fixes: https://syzkaller.appspot.com/bug?extid=6ce141c55b2f7aafd1c4
> Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
> Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
> drivers/bluetooth/hci_h5.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

